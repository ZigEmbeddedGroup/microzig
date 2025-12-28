const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
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

comptime {
    if (microzig.options.cpu.interrupt_stack_size == null)
        @compileError("Please enable interrupt stacks to use the scheduler");
}

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
    microzig.cpu.interrupt.set_priority(generic_interrupt, .highest);
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
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    scheduler.make_task_ready_from_cs(task);
}

pub fn make_task_ready_from_cs(scheduler: *Scheduler, task: *Task) void {
    switch (task.state) {
        .running, .none => {},
        .ready => return,
        .alarm_set => |_| {
            scheduler.timer_queue.remove(&task.internal_node);
        },
        .suspended => {
            scheduler.suspended_list.remove(&task.internal_node);
        },
    }

    // Remove the task from any external waiting list (eg: from a mutex).
    if (task.waiting_queue) |waiting_queue| {
        waiting_queue.inner.remove(&task.waiting_queue_node);
        task.waiting_queue = null;
    }

    task.state = .ready;
    scheduler.ready_queue.append(task);
}

pub fn change_task_priority_from_cs(scheduler: *Scheduler, task: *Task, new_priority: Priority) void {
    task.priority = new_priority;

    switch (task.state) {
        .ready => {
            scheduler.ready_queue.inner.remove(task);
            scheduler.ready_queue.inner.append(task);
        },
        else => {},
    }

    if (task.waiting_queue) |waiting_queue| {
        waiting_queue.inner.remove(&task.waiting_queue_node);
        waiting_queue.append(&task.waiting_queue_node);
    }
}

pub const YieldAction = union(enum) {
    reschedule,
    wait: ?u52,
};

pub inline fn yield(scheduler: *Scheduler, action: YieldAction) void {
    const cs = microzig.interrupt.enter_critical_section();
    scheduler.yield_and_leave_cs(action, cs);
}

/// Must be called inside critical section. Calling leave on the critical
/// section becomes unnecessary.
pub inline fn yield_and_leave_cs(
    scheduler: *Scheduler,
    action: YieldAction,
    cs: microzig.interrupt.CriticalSection,
) void {
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
                scheduler.suspended_list.append(&prev_task.internal_node);
            }
        },
    }

    const next_task: *Task = scheduler.ready_queue.pop(null) orelse @panic("Idle task can't be waiting.");

    scheduler.current_task = next_task;
    next_task.state = .running;

    return .{ &prev_task.context, &next_task.context };
}

pub fn get_ticks(_: *Scheduler) u52 {
    return systimer_unit.read();
}

pub fn sleep(scheduler: *Scheduler, ticks: u52) void {
    const now_ticks = scheduler.get_ticks();
    const timeout_ticks = now_ticks +% ticks;
    scheduler.yield(.{ .wait = timeout_ticks });
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

pub fn yield_from_isr(scheduler: *Scheduler) void {
    if (scheduler.ready_queue.peek_top()) |top_ready_task| {
        if (top_ready_task.priority.is_greater(scheduler.current_task.priority)) {
            SYSTEM.CPU_INTR_FROM_CPU_0.write(.{
                .CPU_INTR_FROM_CPU_0 = 1,
            });
        }
    }
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
fn schedule_wake_at(scheduler: *Scheduler, sleeping_task: *Task, timeout: u52) void {
    sleeping_task.state = .{ .alarm_set = timeout };

    var maybe_node = scheduler.timer_queue.first;
    while (maybe_node) |node| : (maybe_node = node.next) {
        const task: *Task = @alignCast(@fieldParentPtr("internal_node", node));
        const wake_ticks = task.state.alarm_set;
        if (is_a_before_b(timeout, wake_ticks)) {
            scheduler.timer_queue.insertBefore(&task.internal_node, &sleeping_task.internal_node);
            break;
        }
    } else {
        scheduler.timer_queue.append(&sleeping_task.internal_node);
    }

    // If we updated the first element of the list, it means that we have to
    // reschedule the timer
    if (scheduler.timer_queue.first == &sleeping_task.internal_node) {
        systimer_alarm.set_target(timeout);
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
                systimer_alarm.set_enabled(false);

                const now_ticks = scheduler.get_ticks();

                var maybe_node = scheduler.timer_queue.first;
                while (maybe_node) |node| : (maybe_node = node.next) {
                    const task: *Task = @alignCast(@fieldParentPtr("internal_node", node));
                    const wake_ticks = task.state.alarm_set;
                    if (is_a_before_b(now_ticks, wake_ticks)) {
                        break;
                    }

                    scheduler.make_task_ready_from_cs(task);
                }

                if (scheduler.timer_queue.first) |node| {
                    const task: *Task = @alignCast(@fieldParentPtr("internal_node", node));
                    systimer_alarm.set_target(task.state.alarm_set);
                    systimer_alarm.set_enabled(true);
                }
            },
            else => {},
        }
    }

    scheduler.yield_from_isr();
}

pub const Task = struct {
    context: Context,
    stack: []u8,
    priority: Priority,

    /// What is the deal with this task right now?
    state: State = .none,

    /// Node used for scheduler internal lists.
    internal_node: std.DoublyLinkedList.Node = .{},

    /// In which external waiting queue is this task in.
    waiting_queue: ?*WaitingPriorityQueue = null,
    /// Node used for external waiting queue.
    waiting_queue_node: std.DoublyLinkedList.Node = .{},

    /// Task specific semaphore (required by the wifi driver)
    semaphore: Semaphore = .init(0),

    pub const State = union(enum) {
        none,
        ready,
        running,
        alarm_set: u52,
        suspended,
    };

    // TODO: Maybe swap with something more efficient.
    pub const ReadyPriorityQueue = struct {
        inner: std.DoublyLinkedList = .{},

        pub fn peek_top(pq: *ReadyPriorityQueue) ?*Task {
            if (pq.inner.first) |first_node| {
                return @alignCast(@fieldParentPtr("internal_node", first_node));
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
                pq.inner.remove(&task.internal_node);
                return task;
            }
            return null;
        }

        pub fn append(pq: *ReadyPriorityQueue, new_task: *Task) void {
            var maybe_node = pq.inner.first;
            while (maybe_node) |node| : (maybe_node = node.next) {
                const task: *Task = @alignCast(@fieldParentPtr("internal_node", node));
                if (new_task.priority.is_greater(task.priority)) {
                    pq.inner.insertBefore(node, &new_task.internal_node);
                    break;
                }
            } else {
                pq.inner.append(&new_task.internal_node);
            }
        }
    };

    pub const WaitingPriorityQueue = struct {
        inner: std.DoublyLinkedList = .{},

        pub fn first(pq: *WaitingPriorityQueue) ?*Task {
            if (pq.inner.first) |first_node| {
                return @alignCast(@fieldParentPtr("waiting_queue_node", first_node));
            } else {
                return null;
            }
        }

        pub fn append(pq: *WaitingPriorityQueue, new_task: *Task) void {
            new_task.waiting_queue = pq;

            var maybe_node = pq.inner.first;
            while (maybe_node) |node| : (maybe_node = node.next) {
                const task: *Task = @alignCast(@fieldParentPtr("waiting_queue_node", node));
                if (new_task.priority.is_greater(task.priority)) {
                    pq.inner.insertBefore(node, &new_task.waiting_queue_node);
                    break;
                }
            } else {
                pq.inner.append(&new_task.waiting_queue_node);
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

// TODO: implement priority inheritance
pub const Mutex = struct {
    state: State = .unlocked,
    waiting_queue: Task.WaitingPriorityQueue = .{},

    pub const State = enum(u32) {
        locked,
        unlocked,
    };

    pub fn lock(mutex: *Mutex, scheduler: *Scheduler) void {
        lock_with_timeout(mutex, scheduler, null) catch unreachable;
    }

    pub fn lock_with_timeout(mutex: *Mutex, scheduler: *Scheduler, maybe_timeout: ?u52) error{Timeout}!void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        while (mutex.state != .unlocked) {
            const current_task = scheduler.current_task;
            mutex.waiting_queue.append(current_task);
            scheduler.yield(.{ .wait = maybe_timeout });
            if (maybe_timeout) |timeout| {
                if (!is_a_before_b(scheduler.get_ticks(), timeout)) {
                    return error.Timeout;
                }
            }
        }

        mutex.state = .locked;
    }

    pub fn unlock(mutex: *Mutex, scheduler: *Scheduler) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        assert(mutex.state == .locked);
        mutex.state = .unlocked;

        if (mutex.waiting_queue.first()) |waiting_task| {
            scheduler.make_task_ready_from_cs(waiting_task);
        }
    }
};

pub const RecursiveMutex = struct {
    value: u32 = 0,
    owning_task: ?*Task = null,
    waiting_queue: Task.WaitingPriorityQueue = .{},

    pub fn lock(mutex: *RecursiveMutex, scheduler: *Scheduler) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        const current_task = scheduler.current_task;

        if (mutex.owning_task == current_task) {
            mutex.value += 1;
            return;
        }

        while (mutex.owning_task != null) {
            mutex.waiting_queue.append(current_task);
            scheduler.yield(.{ .wait = null });
        }

        assert(mutex.value == 0);
        mutex.value += 1;
        mutex.owning_task = scheduler.current_task;
    }

    pub fn unlock(mutex: *RecursiveMutex, scheduler: *Scheduler) bool {
        const cs = microzig.interrupt.enter_critical_section();

        assert(mutex.value > 0);
        mutex.value -= 1;
        if (mutex.value <= 0) {
            defer scheduler.yield_and_leave_cs(.reschedule, cs);

            mutex.owning_task = null;

            if (mutex.waiting_queue.first()) |waiting_task| {
                scheduler.make_task_ready_from_cs(waiting_task);
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
    waiting_queue: Task.WaitingPriorityQueue = .{},

    pub fn init(initial_value: u32) Semaphore {
        return .{
            .value = initial_value,
        };
    }

    pub fn take(sem: *Semaphore, scheduler: *Scheduler) void {
        sem.take_with_timeout(scheduler, null) catch unreachable;
    }

    pub fn take_with_timeout(sem: *Semaphore, scheduler: *Scheduler, maybe_timeout: ?u52) error{Timeout}!void {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        while (sem.value <= 0) {
            if (maybe_timeout) |timeout| {
                if (!is_a_before_b(scheduler.get_ticks(), timeout)) {
                    return error.Timeout;
                }
            }

            const current_task = scheduler.current_task;
            sem.waiting_queue.append(current_task);
            scheduler.yield(.{ .wait = maybe_timeout });
        }

        sem.value -= 1;
    }

    pub fn give(sem: *Semaphore, scheduler: *Scheduler) void {
        const cs = microzig.interrupt.enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        sem.value += 1;

        if (sem.waiting_queue.first()) |waiting_task| {
            scheduler.make_task_ready_from_cs(waiting_task);
        }
    }
};

pub const TypeErasedQueue = struct {
    buffer: []const u8,

};

fn is_a_before_b(a: u52, b: u52) bool {
    return a < b or b -% a < a;
}
