const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const CriticalSection = microzig.interrupt.CriticalSection;
const enter_critical_section = microzig.interrupt.enter_critical_section;
const TrapFrame = microzig.cpu.TrapFrame;
const SYSTEM = microzig.chip.peripherals.SYSTEM;
const time = microzig.drivers.time;

const systimer = @import("systimer.zig");
const get_time_since_boot = @import("time.zig").get_time_since_boot;

// How it works?
// For simple task to task context switches, only necessary registers are
// saved. But if a higher priority task becomes available during the handling
// of an interrupt, a task switch is forced by saving the entire state of the
// task on the stack. What is interresting is that the two context switches are
// compatible. Voluntary yield can resume a task that was interrupted by force
// and vice versa. Because of the forced yield, tasks are required to have a
// minimum stack size available.

// TODO: add identifier to tasks
// TODO: stack usage report based on stack painting
// TODO: for other esp32 chips support SMP
// TODO: use @stackUpperBound when implemented

const STACK_ALIGN: std.mem.Alignment = .@"16";
const EXTRA_STACK_SIZE = @max(@sizeOf(TrapFrame), 31 * @sizeOf(usize));
const IDLE_STACK_SIZE = 512 + EXTRA_STACK_SIZE;

// TODO: configurable
const generic_interrupt: microzig.cpu.Interrupt = .interrupt30;
// TODO: configurable
const yield_interrupt: microzig.cpu.Interrupt = .interrupt31;
const systimer_unit = systimer.unit(0);
const systimer_alarm = systimer.alarm(0);

const Scheduler = @This();

var maybe_instance: ?*Scheduler = null;

gpa: Allocator,

ready_queue: Task.ReadyPriorityQueue = .{},
timer_queue: std.DoublyLinkedList = .{},
suspended_list: std.DoublyLinkedList = .{},

main_task: Task,

idle_stack: [IDLE_STACK_SIZE]u8 = undefined,
idle_task: Task,

/// The task in .running state
current_task: *Task,

// TODO: configurable
pub const Priority = enum(u8) {
    idle = 0,
    lowest = 1,
    _,

    pub const highest: Priority = @enumFromInt(std.math.maxInt(@typeInfo(Priority).@"enum".tag_type));

    pub fn is_greater(prio: Priority, other: Priority) bool {
        return @intFromEnum(prio) > @intFromEnum(other);
    }
};

pub fn init(scheduler: *Scheduler, gpa: Allocator) void {
    comptime {
        if (microzig.options.cpu.interrupt_stack_size == null)
            @compileError("Please enable interrupt stacks to use the scheduler");
    }

    assert(maybe_instance == null);

    scheduler.* = .{
        .gpa = gpa,
        .main_task = .{
            .context = undefined,
            .priority = .lowest,
            .stack = &.{},
        },
        .idle_task = .{
            .context = .{
                .pc = @intFromPtr(&idle),
                .sp = @intFromPtr(scheduler.idle_stack[scheduler.idle_stack.len..].ptr),
                .fp = 0,
            },
            .stack = &scheduler.idle_stack,
            .priority = .idle,
        },
        .current_task = &scheduler.main_task,
    };

    scheduler.make_task_ready(&scheduler.idle_task);

    maybe_instance = scheduler;

    microzig.cpu.interrupt.map(.from_cpu_intr0, yield_interrupt);
    microzig.cpu.interrupt.set_type(yield_interrupt, .level);
    microzig.cpu.interrupt.set_priority(yield_interrupt, .lowest);
    microzig.cpu.interrupt.enable(yield_interrupt);

    microzig.cpu.interrupt.set_type(generic_interrupt, .level);
    microzig.cpu.interrupt.set_priority(generic_interrupt, .lowest);
    microzig.cpu.interrupt.map(.systimer_target0, generic_interrupt);
    microzig.cpu.interrupt.enable(generic_interrupt);

    // unit0 is already enabled as it is used by `hal.time`.
    systimer_alarm.set_unit(systimer_unit);
    systimer_alarm.set_mode(.target);
    systimer_alarm.set_enabled(false);
    systimer_alarm.set_interrupt_enabled(true);
}

pub fn idle() callconv(.c) void {
    const scheduler = maybe_instance orelse @panic("no active scheduler");
    while (true) {
        scheduler.yield(.reschedule);
        microzig.cpu.wfi();
    }
}

fn task_entry() callconv(.naked) void {
    asm volatile (
        \\lw a0, -4(sp)
        \\lw a1, -8(sp)
        \\jr a1
        \\
    );
}

pub const SpawnOptions = struct {
    stack_size: usize = 4096,
    // TODO: should we ban idle priority?
    priority: Priority = .lowest,
};

pub fn raw_alloc_spawn_with_options(
    scheduler: *Scheduler,
    function: *const fn (param: ?*anyopaque) callconv(.c) noreturn,
    param: ?*anyopaque,
    options: SpawnOptions,
) !*Task {
    const alignment = comptime STACK_ALIGN.max(.of(Task));

    const unaligned_allocation_size = @sizeOf(Task) + options.stack_size + EXTRA_STACK_SIZE;
    const allocation_size = std.mem.alignForward(usize, unaligned_allocation_size, alignment.toByteUnits());
    const raw_alloc = try scheduler.gpa.alignedAlloc(u8, alignment, allocation_size);

    const task: *Task = @ptrCast(raw_alloc.ptr);
    const stack: []u8 = raw_alloc[@sizeOf(Task)..];
    const stack_top = @intFromPtr(stack[stack.len..].ptr);

    const startup_state: *[2]u32 = @ptrFromInt(stack_top - 2 * @sizeOf(u32));
    startup_state[0] = @intFromPtr(function);
    startup_state[1] = @intFromPtr(param);

    task.* = .{
        .context = .{
            .sp = stack_top,
            .pc = @intFromPtr(&task_entry),
            .fp = 0,
        },
        .stack = stack,
        .priority = options.priority,
    };

    scheduler.make_task_ready(task);

    return task;
}

pub fn make_task_ready(scheduler: *Scheduler, task: *Task) void {
    const cs = enter_critical_section();
    defer cs.leave();

    scheduler.make_task_ready_from_cs(task, cs);
}

pub fn make_task_ready_from_cs(scheduler: *Scheduler, task: *Task, _: CriticalSection) void {
    switch (task.state) {
        .running, .none => {},
        .ready => return,
        .alarm_set => |_| {
            scheduler.timer_queue.remove(&task.node);
        },
        .suspended => {
            scheduler.suspended_list.remove(&task.node);
        },
    }

    task.state = .ready;
    scheduler.ready_queue.append(task);
}

pub fn change_task_priority_from_cs(scheduler: *Scheduler, task: *Task, new_priority: Priority, _: CriticalSection) void {
    task.priority = new_priority;

    switch (task.state) {
        .ready => {
            scheduler.ready_queue.inner.remove(task);
            scheduler.ready_queue.inner.append(task);
        },
        else => {},
    }
}

pub const YieldAction = union(enum) {
    reschedule,
    wait: ?TimerTicks,
};

pub inline fn yield(scheduler: *Scheduler, action: YieldAction) void {
    const cs = enter_critical_section();
    scheduler.yield_and_leave_cs(action, cs);
}

/// Must be called inside critical section. Calling leave on the critical
/// section becomes unnecessary.
pub inline fn yield_and_leave_cs(scheduler: *Scheduler, action: YieldAction, cs: CriticalSection) void {
    const prev_context, const next_context = scheduler.yield_inner(action);
    context_switch(prev_context, next_context);
    if (!cs.enable_on_leave) {
        microzig.cpu.interrupt.disable_interrupts();
    }
}

fn yield_inner(scheduler: *Scheduler, action: YieldAction) struct { *Context, *Context } {
    const prev_task = scheduler.current_task;
    switch (action) {
        .reschedule => {
            scheduler.ready_queue.append(prev_task);
            prev_task.state = .ready;
        },
        .wait => |maybe_timeout| {
            if (maybe_timeout) |timeout| {
                scheduler.schedule_wake_at(prev_task, timeout);
            } else {
                prev_task.state = .suspended;
                scheduler.suspended_list.append(&prev_task.node);
            }
        },
    }

    const next_task: *Task = scheduler.ready_queue.pop(null) orelse @panic("Idle task can't be waiting.");

    scheduler.current_task = next_task;
    next_task.state = .running;

    return .{ &prev_task.context, &next_task.context };
}

pub fn sleep(scheduler: *Scheduler, duration: time.Duration) void {
    scheduler.yield(.{ .wait = .after(duration) });
}

inline fn context_switch(prev_context: *Context, next_context: *Context) void {
    asm volatile (
        \\la a2, 1f
        \\sw a2, 0(a0)      # save return pc
        \\sw sp, 4(a0)      # save prev stack pointer
        \\sw s0, 8(a0)      # save prev frame pointer
        \\
        \\lw a2, 0(a1)      # load next pc
        \\lw sp, 4(a1)      # load next stack pointer
        \\lw s0, 8(a1)      # load next frame pointer
        \\
        \\csrsi mstatus, 8  # enable interrupts
        \\
        \\jr a2             # jump to next task
        \\1:
        \\
        :
        : [prev_context] "{a0}" (prev_context),
          [next_context] "{a1}" (next_context),
        : .{
          .x1 = true, // ra
          .x3 = true,
          .x4 = true,
          .x5 = true,
          .x6 = true,
          .x7 = true,
          .x8 = true,
          .x9 = true,
          .x10 = true,
          .x11 = true,
          .x12 = true,
          .x13 = true,
          .x14 = true,
          .x15 = true,
          .x16 = true,
          .x17 = true,
          .x18 = true,
          .x19 = true,
          .x20 = true,
          .x21 = true,
          .x22 = true,
          .x23 = true,
          .x24 = true,
          .x25 = true,
          .x26 = true,
          .x27 = true,
          .x28 = true,
          .x29 = true,
          .x30 = true,
          .x31 = true,
          .memory = true,
        });
}

pub fn yield_from_isr() void {
    SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
        .CPU_INTR_FROM_CPU_0 = 1,
    });
}

pub fn is_a_higher_priority_task_ready(scheduler: *Scheduler) bool {
    return if (scheduler.ready_queue.peek_top()) |top_ready_task|
        top_ready_task.priority.is_greater(scheduler.current_task.priority)
    else
        false;
}

pub fn isr_yield_handler() linksection(".ram_vectors") callconv(.naked) void {
    comptime {
        assert(@sizeOf(Context) == 3 * @sizeOf(usize));
    }

    asm volatile (
        \\
        \\addi sp, sp, -31*4
        \\
        \\sw ra, 0*4(sp)
        \\sw t0, 1*4(sp)
        \\sw t1, 2*4(sp)
        \\sw t2, 3*4(sp)
        \\sw t3, 4*4(sp)
        \\sw t4, 5*4(sp)
        \\sw t5, 6*4(sp)
        \\sw t6, 7*4(sp)
        \\sw a0, 8*4(sp)
        \\sw a1, 9*4(sp)
        \\sw a2, 10*4(sp)
        \\sw a3, 11*4(sp)
        \\sw a4, 12*4(sp)
        \\sw a5, 13*4(sp)
        \\sw a6, 14*4(sp)
        \\sw a7, 15*4(sp)
        \\sw s1, 16*4(sp)
        \\sw s2, 17*4(sp)
        \\sw s3, 18*4(sp)
        \\sw s4, 19*4(sp)
        \\sw s5, 20*4(sp)
        \\sw s6, 21*4(sp)
        \\sw s7, 22*4(sp)
        \\sw s8, 23*4(sp)
        \\sw s9, 24*4(sp)
        \\sw s10, 25*4(sp)
        \\sw s11, 26*4(sp)
        \\sw gp, 27*4(sp)
        \\sw tp, 28*4(sp)
        \\
        \\csrr a1, mepc
        \\sw a1, 29*4(sp)
        \\
        \\csrr a1, mstatus
        \\sw a1, 30*4(sp)
        \\
        // save sp for later
        \\mv a2, sp
        \\
        // use the interrupt stack in this call to minimize task stack size
        // NOTE: mscratch doesn't need to be zeroed because this can't be
        // interrupted by a higher priority interrupt
        \\la sp, %[interrupt_stack_top]
        \\
        // allocate `Context` struct and save context
        \\addi sp, sp, -3*4
        \\la a1, 1f
        \\sw a1, 0(sp)
        \\sw a2, 4(sp)
        \\sw s0, 8(sp)
        \\
        // first parameter is a pointer to context
        \\mv a0, sp
        \\mv s1, a1
        \\jal %[schedule_in_isr]
        \\
        // load next task context
        \\lw a1, 0(sp)
        \\lw a2, 4(sp)
        \\lw s0, 8(sp)
        // change sp to the new task
        \\mv sp, a2
        \\
        // if the next task program counter is equal to 1f's location just jump
        // to it (ie. the task was interrupted). Technically not required but
        // works as an optimization.
        \\beq a1, s1, 1f
        \\
        // ensure interrupts get enabled after mret
        \\li t0, 0x80
        \\csrs mstatus, t0
        \\
        // jump to new task
        \\csrw mepc, a1
        \\mret
        \\
        \\1:
        \\
        \\lw t1, 30*4(sp)
        \\csrw mstatus, t1
        \\
        \\lw t0, 29*4(sp)
        \\csrw mepc, t0
        \\
        \\lw ra, 0*4(sp)
        \\lw t0, 1*4(sp)
        \\lw t1, 2*4(sp)
        \\lw t2, 3*4(sp)
        \\lw t3, 4*4(sp)
        \\lw t4, 5*4(sp)
        \\lw t5, 6*4(sp)
        \\lw t6, 7*4(sp)
        \\lw a0, 8*4(sp)
        \\lw a1, 9*4(sp)
        \\lw a2, 10*4(sp)
        \\lw a3, 11*4(sp)
        \\lw a4, 12*4(sp)
        \\lw a5, 13*4(sp)
        \\lw a6, 14*4(sp)
        \\lw a7, 15*4(sp)
        \\lw s1, 16*4(sp)
        \\lw s2, 17*4(sp)
        \\lw s3, 18*4(sp)
        \\lw s4, 19*4(sp)
        \\lw s5, 20*4(sp)
        \\lw s6, 21*4(sp)
        \\lw s7, 22*4(sp)
        \\lw s8, 23*4(sp)
        \\lw s9, 24*4(sp)
        \\lw s10, 25*4(sp)
        \\lw s11, 26*4(sp)
        \\lw gp, 27*4(sp)
        \\lw tp, 28*4(sp)
        \\
        \\addi sp, sp, 31*4
        \\mret
        :
        : [schedule_in_isr] "i" (&schedule_in_isr),
          [interrupt_stack_top] "i" (microzig.cpu.interrupt_stack[microzig.cpu.interrupt_stack.len..].ptr),
    );
}

fn schedule_in_isr(context: *Context) linksection(".ram_vectors") callconv(.c) void {
    const scheduler = maybe_instance orelse @panic("no active scheduler");

    SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
        .CPU_INTR_FROM_CPU_0 = 0,
    });

    const prev_task = scheduler.current_task;
    const ready_task = scheduler.ready_queue.pop(scheduler.current_task.priority) orelse return;

    // swap contexts
    prev_task.context = context.*;
    context.* = ready_task.context;

    scheduler.ready_queue.append(prev_task);
    prev_task.state = .ready;

    scheduler.current_task = ready_task;
    ready_task.state = .running;
}

/// Must be called from a critical section.
fn schedule_wake_at(scheduler: *Scheduler, sleeping_task: *Task, ticks: TimerTicks) void {
    sleeping_task.state = .{ .alarm_set = ticks };

    var maybe_node = scheduler.timer_queue.first;
    while (maybe_node) |node| : (maybe_node = node.next) {
        const task: *Task = @alignCast(@fieldParentPtr("node", node));
        if (ticks.is_before(task.state.alarm_set)) {
            scheduler.timer_queue.insertBefore(&task.node, &sleeping_task.node);
            break;
        }
    } else {
        scheduler.timer_queue.append(&sleeping_task.node);
    }

    // If we updated the first element of the list, it means that we have to
    // reschedule the timer
    if (scheduler.timer_queue.first == &sleeping_task.node) {
        systimer_alarm.set_target(@intFromEnum(ticks));
        systimer_alarm.set_enabled(true);
    }
}

pub fn generic_interrupt_handler(_: *TrapFrame) callconv(.c) void {
    const scheduler = maybe_instance orelse @panic("no active scheduler");

    var iter: microzig.cpu.interrupt.SourceIterator = .init();
    while (iter.next()) |source| {
        switch (source) {
            .systimer_target0 => {
                systimer_alarm.clear_interrupt();

                const cs = enter_critical_section();
                defer cs.leave();

                while (scheduler.timer_queue.first) |node| {
                    const task: *Task = @alignCast(@fieldParentPtr("node", node));
                    if (!task.state.alarm_set.is_reached()) {
                        break;
                    }
                    scheduler.make_task_ready_from_cs(task, cs);
                }

                if (scheduler.timer_queue.first) |node| {
                    const task: *Task = @alignCast(@fieldParentPtr("node", node));
                    systimer_alarm.set_target(@intFromEnum(task.state.alarm_set));
                    systimer_alarm.set_enabled(true);
                } else {
                    systimer_alarm.set_enabled(false);
                }
            },
            else => {},
        }
    }

    if (scheduler.is_a_higher_priority_task_ready())
        yield_from_isr();
}

pub const Task = struct {
    context: Context,
    stack: []u8,
    priority: Priority,

    /// What is the deal with this task right now?
    state: State = .none,

    /// Node used for scheduler internal lists.
    node: std.DoublyLinkedList.Node = .{},

    /// Task specific semaphore (required by the wifi driver)
    semaphore: Semaphore = .init(0),

    pub const State = union(enum) {
        none,
        ready,
        running,
        alarm_set: TimerTicks,
        suspended,
    };

    // TODO: Maybe swap with something more efficient.
    pub const ReadyPriorityQueue = struct {
        inner: std.DoublyLinkedList = .{},

        pub fn peek_top(pq: *ReadyPriorityQueue) ?*Task {
            if (pq.inner.first) |first_node| {
                return @alignCast(@fieldParentPtr("node", first_node));
            } else {
                return null;
            }
        }

        pub fn pop(pq: *ReadyPriorityQueue, maybe_more_than_prio: ?Priority) ?*Task {
            if (pq.peek_top()) |task| {
                if (maybe_more_than_prio) |more_than_prio| {
                    if (!task.priority.is_greater(more_than_prio)) {
                        return null;
                    }
                }
                pq.inner.remove(&task.node);
                return task;
            }
            return null;
        }

        pub fn append(pq: *ReadyPriorityQueue, new_task: *Task) void {
            var maybe_node = pq.inner.first;
            while (maybe_node) |node| : (maybe_node = node.next) {
                const task: *Task = @alignCast(@fieldParentPtr("node", node));
                if (new_task.priority.is_greater(task.priority)) {
                    pq.inner.insertBefore(node, &new_task.node);
                    break;
                }
            } else {
                pq.inner.append(&new_task.node);
            }
        }
    };
};

pub const Context = extern struct {
    pc: usize,
    sp: usize,
    fp: usize,

    pub fn format(
        self: Context,
        writer: *std.Io.Writer,
    ) std.Io.Writer.Error!void {
        try writer.print(".{{ .pc = 0x{x}, .sp = 0x{x}, .fp = 0x{x} }}", .{ self.pc, self.sp, self.fp });
    }
};

pub const WaitingList = struct {
    inner: std.DoublyLinkedList = .{},

    pub const Awaiter = struct {
        task: *Task,
        node: std.DoublyLinkedList.Node = .{},
    };

    pub fn get_highest_priority(l: *WaitingList) ?*Task {
        var maybe_node = l.inner.first;
        var maybe_max_priority_awaiter: ?*Awaiter = null;
        while (maybe_node) |node| : (maybe_node = node.next) {
            const awaiter: *Awaiter = @fieldParentPtr("node", node);
            if (maybe_max_priority_awaiter) |max_priority_awaiter| {
                if (awaiter.task.priority.is_greater(max_priority_awaiter.task.priority)) {
                    maybe_max_priority_awaiter = awaiter;
                }
            } else {
                maybe_max_priority_awaiter = awaiter;
            }
        }

        return if (maybe_max_priority_awaiter) |max_priority_awaiter|
            max_priority_awaiter.task
        else
            null;
    }
};

pub const TimeoutError = error{Timeout};

// TODO: implement priority inheritance
pub const Mutex = struct {
    state: State = .unlocked,
    awaiters: WaitingList = .{},

    pub const State = enum(u32) {
        locked,
        unlocked,
    };

    pub fn lock(mutex: *Mutex, scheduler: *Scheduler) void {
        lock_with_timeout(mutex, scheduler, null) catch unreachable;
    }

    pub fn lock_with_timeout(mutex: *Mutex, scheduler: *Scheduler, maybe_timeout: ?time.Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var awaiter: WaitingList.Awaiter = .{
            .task = scheduler.current_task,
        };
        mutex.awaiters.inner.append(&awaiter.node);
        defer mutex.awaiters.inner.remove(&awaiter.node);

        while (mutex.state != .unlocked) {
            if (maybe_timeout_ticks) |timeout_ticks| {
                if (timeout_ticks.is_reached()) {
                    return error.Timeout;
                }
            }

            scheduler.yield(.{ .wait = maybe_timeout_ticks });
        }

        mutex.state = .locked;
    }

    pub fn unlock(mutex: *Mutex, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        assert(mutex.state == .locked);
        mutex.state = .unlocked;

        if (mutex.awaiters.get_highest_priority()) |task| {
            scheduler.make_task_ready_from_cs(task, cs);
        }
    }
};

pub const RecursiveMutex = struct {
    value: u32 = 0,
    owning_task: ?*Task = null,
    awaiters: WaitingList = .{},

    pub fn lock(mutex: *RecursiveMutex, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer cs.leave();

        const current_task = scheduler.current_task;

        if (mutex.owning_task == current_task) {
            mutex.value += 1;
            return;
        }

        var awaiter: WaitingList.Awaiter = .{
            .task = current_task,
        };
        mutex.awaiters.inner.append(&awaiter.node);
        defer mutex.awaiters.inner.remove(&awaiter.node);

        while (mutex.owning_task != null) {
            scheduler.yield(.{ .wait = null });
        }

        assert(mutex.value == 0);
        mutex.value += 1;
        mutex.owning_task = scheduler.current_task;
    }

    pub fn unlock(mutex: *RecursiveMutex, scheduler: *Scheduler) bool {
        const cs = enter_critical_section();

        assert(mutex.value > 0);
        mutex.value -= 1;
        if (mutex.value <= 0) {
            defer scheduler.yield_and_leave_cs(.reschedule, cs);

            mutex.owning_task = null;

            if (mutex.awaiters.get_highest_priority()) |task| {
                scheduler.make_task_ready_from_cs(task, cs);
            }

            return true;
        } else {
            cs.leave();
            return false;
        }
    }
};

pub const Semaphore = struct {
    value: u32,
    awaiters: WaitingList = .{},

    pub fn init(initial_value: u32) Semaphore {
        return .{
            .value = initial_value,
        };
    }

    pub fn take(sem: *Semaphore, scheduler: *Scheduler) void {
        sem.take_with_timeout(scheduler, null) catch unreachable;
    }

    pub fn take_with_timeout(sem: *Semaphore, scheduler: *Scheduler, maybe_timeout: ?time.Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var awaiter: WaitingList.Awaiter = .{
            .task = scheduler.current_task,
        };
        sem.awaiters.inner.append(&awaiter.node);
        defer sem.awaiters.inner.remove(&awaiter.node);

        while (sem.value <= 0) {
            if (maybe_timeout_ticks) |timeout_ticks| {
                if (timeout_ticks.is_reached()) {
                    return error.Timeout;
                }
            }

            scheduler.yield(.{ .wait = maybe_timeout_ticks });
        }

        sem.value -= 1;
    }

    pub fn give(sem: *Semaphore, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        sem.value += 1;

        if (sem.awaiters.get_highest_priority()) |task| {
            scheduler.make_task_ready_from_cs(task, cs);
        }
    }
};

pub const QueueClosedError = error{Closed};

pub const TypeErasedQueue = struct {
    closed: bool,

    /// Ring buffer. This data is logically *after* queued getters.
    buffer: []u8,
    start: usize,
    len: usize,

    putters: std.DoublyLinkedList,
    getters: std.DoublyLinkedList,

    const Put = struct {
        remaining: []const u8,
        needed: usize,
        task: *Task,
        node: std.DoublyLinkedList.Node,
    };

    const Get = struct {
        remaining: []u8,
        needed: usize,
        task: *Task,
        node: std.DoublyLinkedList.Node,
    };

    pub fn init(buffer: []u8) TypeErasedQueue {
        return .{
            .closed = false,
            .buffer = buffer,
            .start = 0,
            .len = 0,
            .putters = .{},
            .getters = .{},
        };
    }

    pub fn close(q: *TypeErasedQueue, scheduler: *Scheduler) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        q.closed = true;

        {
            var it = q.getters.first;
            while (it) |node| : (it = node.next) {
                const getter: *Get = @alignCast(@fieldParentPtr("node", node));
                scheduler.make_task_ready_from_cs(getter.task, cs);
            }
        }

        {
            var it = q.putters.first;
            while (it) |node| : (it = node.next) {
                const putter: *Put = @alignCast(@fieldParentPtr("node", node));
                scheduler.make_task_ready_from_cs(putter.task, cs);
            }
        }
    }

    pub fn put(q: *TypeErasedQueue, scheduler: *Scheduler, elements: []const u8, min: usize) QueueClosedError!usize {
        return q.put_with_timeout(scheduler, elements, min, null) catch |err| switch (err) {
            error.Timeout => unreachable,
            error.Closed => return error.Closed,
        };
    }

    pub fn put_with_timeout(
        q: *TypeErasedQueue,
        scheduler: *Scheduler,
        elements: []const u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) (QueueClosedError || TimeoutError)!usize {
        assert(elements.len >= min);
        if (elements.len == 0) return 0;

        const cs = enter_critical_section();
        defer cs.leave();

        const n = try q.put_nonblocking(scheduler, elements, cs);

        // Don't block if we hit the target.
        if (n >= min) return min;

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var pending: Put = .{
            .remaining = elements[n..],
            .needed = min - n,
            .task = scheduler.current_task,
            .node = .{},
        };
        q.putters.append(&pending.node);
        defer if (pending.needed > 0) q.putters.remove(&pending.node);

        while (pending.needed > 0 and !q.closed) {
            if (maybe_timeout_ticks) |timeout_ticks| {
                if (timeout_ticks.is_reached()) {
                    return error.Timeout;
                }
            }

            scheduler.yield(.{ .wait = maybe_timeout_ticks });
        }

        if (pending.remaining.len == elements.len) {
            // The queue was closed while we were waiting. We appended no elements.
            assert(q.closed);
            return error.Closed;
        }
        return elements.len - pending.remaining.len;
    }

    pub fn put_from_isr(q: *TypeErasedQueue, scheduler: *Scheduler, elements: []const u8) QueueClosedError!usize {
        const cs = enter_critical_section();
        defer cs.leave();

        return q.put_nonblocking(scheduler, elements, cs);
    }

    pub fn put_nonblocking(q: *TypeErasedQueue, scheduler: *Scheduler, elements: []const u8, cs: CriticalSection) QueueClosedError!usize {
        // A closed queue cannot be added to, even if there is space in the buffer.
        if (q.closed) return error.Closed;

        // Getters have first priority on the data, and only when the getters
        // queue is empty do we start populating the buffer.

        // The number of elements we add immediately, before possibly blocking.
        var n: usize = 0;

        while (q.getters.popFirst()) |getter_node| {
            const getter: *Get = @alignCast(@fieldParentPtr("node", getter_node));
            const copy_len = @min(getter.remaining.len, elements.len - n);
            assert(copy_len > 0);
            @memcpy(getter.remaining[0..copy_len], elements[n..][0..copy_len]);
            getter.remaining = getter.remaining[copy_len..];
            getter.needed -|= copy_len;
            n += copy_len;
            if (getter.needed == 0) {
                scheduler.make_task_ready_from_cs(getter.task, cs);
            } else {
                assert(n == elements.len); // we didn't have enough elements for the getter
                q.getters.prepend(getter_node);
            }
            if (n == elements.len) return elements.len;
        }

        while (q.puttable_slice()) |slice| {
            const copy_len = @min(slice.len, elements.len - n);
            assert(copy_len > 0);
            @memcpy(slice[0..copy_len], elements[n..][0..copy_len]);
            q.len += copy_len;
            n += copy_len;
            if (n == elements.len) return elements.len;
        }

        return n;
    }

    fn puttable_slice(q: *const TypeErasedQueue) ?[]u8 {
        const unwrapped_index = q.start + q.len;
        const wrapped_index, const overflow = @subWithOverflow(unwrapped_index, q.buffer.len);
        const slice = switch (overflow) {
            1 => q.buffer[unwrapped_index..],
            0 => q.buffer[wrapped_index..q.start],
        };
        return if (slice.len > 0) slice else null;
    }

    pub fn get(q: *TypeErasedQueue, scheduler: *Scheduler, buffer: []u8, min: usize) QueueClosedError!usize {
        return q.put_with_timeout(scheduler, buffer, min, null) catch |err| switch (err) {
            error.Timeout => unreachable,
            error.Closed => return error.Closed,
        };
    }

    pub fn get_with_timeout(
        q: *TypeErasedQueue,
        scheduler: *Scheduler,
        buffer: []u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) (QueueClosedError || TimeoutError)!usize {
        assert(buffer.len >= min);
        if (buffer.len == 0) return 0;

        const cs = enter_critical_section();
        defer cs.leave();

        // The ring buffer gets first priority, then data should come from any
        // queued putters, then finally the ring buffer should be filled with
        // data from putters so they can be resumed.

        // The number of elements we received immediately, before possibly blocking.
        var n: usize = 0;

        while (q.gettable_slice()) |slice| {
            const copy_len = @min(slice.len, buffer.len - n);
            assert(copy_len > 0);
            @memcpy(buffer[n..][0..copy_len], slice[0..copy_len]);
            q.start += copy_len;
            if (q.buffer.len - q.start == 0) q.start = 0;
            q.len -= copy_len;
            n += copy_len;
            if (n == buffer.len) {
                q.fill_ring_buffer_from_putters(scheduler);
                return buffer.len;
            }
        }

        // Copy directly from putters into buffer.
        while (q.putters.popFirst()) |putter_node| {
            const putter: *Put = @alignCast(@fieldParentPtr("node", putter_node));
            const copy_len = @min(putter.remaining.len, buffer.len - n);
            assert(copy_len > 0);
            @memcpy(buffer[n..][0..copy_len], putter.remaining[0..copy_len]);
            putter.remaining = putter.remaining[copy_len..];
            putter.needed -|= copy_len;
            n += copy_len;
            if (putter.needed == 0) {
                scheduler.make_task_ready_from_cs(putter.task, cs);
            } else {
                assert(n == buffer.len); // we didn't have enough space for the putter
                q.putters.prepend(putter_node);
            }
            if (n == buffer.len) {
                q.fill_ring_buffer_from_putters(scheduler);
                return buffer.len;
            }
        }

        // No need to call `fillRingBufferFromPutters` from this point onwards,
        // because we emptied the ring buffer *and* the putter queue!

        // Don't block if we hit the target or if the queue is closed. Return how
        // many elements we could get immediately, unless the queue was closed and
        // empty, in which case report `error.Closed`.
        if (n == 0 and q.closed) return error.Closed;
        if (n >= min or q.closed) return n;

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var pending: Get = .{
            .remaining = buffer[n..],
            .needed = min - n,
            .task = scheduler.current_task,
            .node = .{},
        };
        q.getters.append(&pending.node);
        defer if (pending.needed > 0) q.getters.remove(&pending.node);

        while (pending.needed > 0 and !q.closed) {
            if (maybe_timeout_ticks) |timeout_ticks| {
                if (timeout_ticks.is_reached()) {
                    return error.Timeout;
                }
            }

            scheduler.yield(.{ .wait = maybe_timeout_ticks });
        }

        if (pending.remaining.len == buffer.len) {
            // The queue was closed while we were waiting. We received no elements.
            assert(q.closed);
            return error.Closed;
        }

        return buffer.len - pending.remaining.len;
    }

    fn gettable_slice(q: *const TypeErasedQueue) ?[]const u8 {
        const overlong_slice = q.buffer[q.start..];
        const slice = overlong_slice[0..@min(overlong_slice.len, q.len)];
        return if (slice.len > 0) slice else null;
    }

    /// Called when there is nonzero space available in the ring buffer and
    /// potentially putters waiting. The mutex is already held and the task is
    /// to copy putter data to the ring buffer and signal any putters whose
    /// buffers been fully copied.
    fn fill_ring_buffer_from_putters(q: *TypeErasedQueue, scheduler: *Scheduler) void {
        while (q.putters.popFirst()) |putter_node| {
            const putter: *Put = @alignCast(@fieldParentPtr("node", putter_node));
            while (q.puttable_slice()) |slice| {
                const copy_len = @min(slice.len, putter.remaining.len);
                assert(copy_len > 0);
                @memcpy(slice[0..copy_len], putter.remaining[0..copy_len]);
                q.len += copy_len;
                putter.remaining = putter.remaining[copy_len..];
                putter.needed -|= copy_len;
                if (putter.needed == 0) {
                    scheduler.yield(.{ .wait = null });
                    break;
                }
            } else {
                q.putters.prepend(putter_node);
                break;
            }
        }
    }
};

pub fn Queue(Elem: type) type {
    return struct {
        const Self = @This();

        type_erased: TypeErasedQueue,

        pub fn init(buffer: []Elem) Self {
            return .{ .type_erased = .init(@ptrCast(buffer)) };
        }

        pub fn close(q: *Self, scheduler: *Scheduler) void {
            q.type_erased.close(scheduler);
        }

        pub fn put(q: *Self, scheduler: *Scheduler, elements: []const Elem, min: usize) QueueClosedError!usize {
            return @divExact(try q.type_erased.put(scheduler, @ptrCast(elements), min * @sizeOf(Elem)), @sizeOf(Elem));
        }

        pub fn put_all(q: *Self, scheduler: *Scheduler, elements: []const Elem) QueueClosedError!void {
            const n = try q.put(scheduler, elements, elements.len);
            if (n != elements.len) {
                _ = try q.put(scheduler, elements[n..], elements.len - n);
                unreachable;
            }
        }

        pub fn put_one(q: *Self, scheduler: *Scheduler, item: Elem) QueueClosedError!void {
            assert(try q.put(scheduler, &.{item}, 1) == 1);
        }

        pub fn put_from_isr(q: *Self, scheduler: *Scheduler, elements: []const Elem) QueueClosedError!usize {
            return @divExact(try q.type_erased.put_from_isr(scheduler, @ptrCast(elements)), @sizeOf(Elem));
        }

        pub fn put_one_from_isr(q: *Self, scheduler: *Scheduler, item: Elem) QueueClosedError!bool {
            return try q.type_erased.put_from_isr(scheduler, @ptrCast(&item)) == @sizeOf(Elem);
        }

        pub fn get(q: *Self, scheduler: *Scheduler, buffer: []Elem, target: usize) QueueClosedError!usize {
            return @divExact(try q.type_erased.get(scheduler, @ptrCast(buffer), target * @sizeOf(Elem)), @sizeOf(Elem));
        }

        pub fn get_one(q: *Self, scheduler: *Scheduler) QueueClosedError!Elem {
            var buf: [1]Elem = undefined;
            assert(try q.get(scheduler, &buf, 1) == 1);
            return buf[0];
        }

        pub fn capacity(q: *const Self) usize {
            return @divExact(q.type_erased.buffer.len, @sizeOf(Elem));
        }
    };
}

pub const TimerTicks = enum(u52) {
    _,

    pub fn now() TimerTicks {
        return @enumFromInt(systimer_unit.read());
    }

    pub fn after(duration: time.Duration) TimerTicks {
        return TimerTicks.now().add_duration(duration);
    }

    pub fn is_reached(ticks: TimerTicks) bool {
        return ticks.is_before(.now());
    }

    pub fn is_before(a: TimerTicks, b: TimerTicks) bool {
        const _a = @intFromEnum(a);
        const _b = @intFromEnum(b);
        return _a < _b or _b -% _a < _a;
    }

    pub fn add_duration(ticks: TimerTicks, duration: time.Duration) TimerTicks {
        return @enumFromInt(@intFromEnum(ticks) +% @as(u52, @intCast(duration.to_us())) * systimer.ticks_per_us());
    }
};
