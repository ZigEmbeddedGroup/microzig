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

// TODO: add identifier names to tasks
// TODO: stack usage report based on stack painting
// TODO: implement task garbage collection
// TODO: for other esp32 chips with multicore support SMP
// TODO: make a cancelation system
// TODO: implement std.Io
// TODO: use @stackUpperBound when implemented
// TODO: implement priority inheritance for respective sync primitives
// TODO: better handling if timeout is in the past or very short
// NOTE: don't use anonymous structs for reinitializing state unions with
// previous union state to avoid compiler bug (0.15.2)

comptime {
    if (microzig.options.cpu.interrupt_stack_size == null)
        @compileError("Please enable interrupt stacks to use the scheduler");
}

const STACK_ALIGN: std.mem.Alignment = .@"16";
const EXTRA_STACK_SIZE = @max(@sizeOf(TrapFrame), 31 * @sizeOf(usize));

// TODO: configurable
const generic_interrupt: microzig.cpu.Interrupt = .interrupt30;
// TODO: configurable
const yield_interrupt: microzig.cpu.Interrupt = .interrupt31;
const systimer_unit = systimer.unit(0);
const systimer_alarm = systimer.alarm(0);

const Scheduler = @This();

var maybe_instance: ?*Scheduler = null;

gpa: Allocator,

ready_queue: ReadyPriorityQueue = .{},
timer_queue: std.DoublyLinkedList = .{},
scheduled_for_deletion_list: std.DoublyLinkedList = .{},

main_task: Task,

// Idle only requires the stack space used by the yield interrupt
idle_stack: [std.mem.alignForward(usize, EXTRA_STACK_SIZE, STACK_ALIGN.toByteUnits())]u8 align(STACK_ALIGN.toByteUnits()) = undefined,
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

    scheduler.ready(&scheduler.idle_task, .{});

    maybe_instance = scheduler;

    microzig.cpu.interrupt.map(.from_cpu_intr0, yield_interrupt);
    microzig.cpu.interrupt.set_type(yield_interrupt, .level);
    microzig.cpu.interrupt.set_priority(yield_interrupt, .lowest);
    microzig.cpu.interrupt.enable(yield_interrupt);

    // unit0 is already enabled as it is used by `hal.time`.
    systimer_alarm.set_unit(systimer_unit);
    systimer_alarm.set_mode(.target);
    systimer_alarm.set_enabled(false);
    systimer_alarm.set_interrupt_enabled(true);

    microzig.cpu.interrupt.map(.systimer_target0, generic_interrupt);
    microzig.cpu.interrupt.set_type(generic_interrupt, .level);
    microzig.cpu.interrupt.set_priority(generic_interrupt, .lowest);
    microzig.cpu.interrupt.enable(generic_interrupt);
}

// TODO: deinit

fn idle() callconv(.naked) void {
    asm volatile (
        \\1:
        \\wfi
        \\j 1b
    );
}

fn task_entry() callconv(.naked) void {
    asm volatile (
        \\lw a0, -4(sp)
        \\lw a1, -8(sp)
        \\jr a1
        \\
    );
}

pub fn spawn(
    scheduler: *Scheduler,
    function: anytype,
    args: std.meta.ArgsTuple(@TypeOf(function)),
    options: SpawnOptions,
) !*Task {
    const Args = @TypeOf(args);
    const TypeErased = struct {
        fn start(context: ?*anyopaque) callconv(.c) noreturn {
            const args_casted: *const Args = @ptrCast(@alignCast(context));

            @call(.auto, function, args_casted.*);

            const sched = maybe_instance orelse @panic("no active scheduler");
            sched.yield(.delete);
            unreachable;
        }
    };

    // SAFETY: @constCast is safe to use since the task entry only dereferences the ptr
    return scheduler.raw_spawn_with_options(TypeErased.start, @ptrCast(@constCast(&args)), options);
}

pub const SpawnOptions = struct {
    stack_size: usize = 4096,
    // TODO: should we ban idle priority?
    priority: Priority = .lowest,
};

pub fn raw_spawn_with_options(
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

    const cs = enter_critical_section();
    defer cs.leave();

    scheduler.ready(task, .{});

    return task;
}

pub const YieldAction = union(enum) {
    reschedule,
    wait: struct {
        timeout: ?TimerTicks = null,
        wait_queue: ?*PriorityWaitQueue = null,
    },
    delete,
};

pub inline fn yield(scheduler: *Scheduler, action: YieldAction) void {
    const cs = enter_critical_section();
    scheduler.yield_and_leave_cs(action, cs);
}

/// Must be called inside critical section. Calling leave on the critical
/// section becomes unnecessary.
pub inline fn yield_and_leave_cs(scheduler: *Scheduler, action: YieldAction, cs: CriticalSection) void {
    defer if (!cs.enable_on_leave) {
        microzig.cpu.interrupt.disable_interrupts();
    };
    const current_task, const next_task = scheduler.yield_inner(action);
    context_switch(&current_task.context, &next_task.context);
}

fn yield_inner(scheduler: *Scheduler, action: YieldAction) struct { *Task, *Task } {
    const current_task = scheduler.current_task;
    switch (action) {
        .reschedule => {
            current_task.state = .{ .ready = .{} };
            scheduler.ready_queue.put(current_task);
        },
        .wait => |wait_action| {
            assert(current_task != &scheduler.idle_task);

            if (wait_action.wait_queue) |wait_queue| {
                assert(current_task.wait_queue == null);
                wait_queue.put(current_task);
                current_task.wait_queue = wait_queue;
            }

            if (wait_action.timeout) |timeout| {
                scheduler.schedule_wake_at(current_task, timeout);
            } else {
                current_task.state = .suspended;
            }
        },
        .delete => {
            assert(current_task != &scheduler.idle_task and current_task != &scheduler.main_task);

            current_task.state = .scheduled_for_deletion;
            scheduler.scheduled_for_deletion_list.append(&current_task.node);
        },
    }

    const next_task: *Task = scheduler.ready_queue.pop(null) orelse @panic("No task ready to run!");

    next_task.state = Task.State{ .running = next_task.state.ready };
    scheduler.current_task = next_task;

    return .{ current_task, next_task };
}

pub fn wake_from_wait_queue(scheduler: *Scheduler, wait_queue: *PriorityWaitQueue, how_many: enum(usize) {
    one = 1,
    all = std.math.maxInt(usize),
    _,
}) void {
    var remaining: usize = @intFromEnum(how_many);
    if (remaining == 0) return;
    while (wait_queue.pop()) |task| : (remaining -= 1) {
        if (remaining == 0) break;

        assert(task.wait_queue == wait_queue);
        task.wait_queue = null;

        switch (task.state) {
            .alarm_set => |_| scheduler.timer_queue.remove(&task.node),
            .suspended => {},
            else => @panic("invalid state for waiting task"),
        }

        scheduler.ready(task, .{});
    }
}

pub const TimeoutError = error{Timeout};

pub fn sleep(scheduler: *Scheduler, duration: time.Duration) void {
    scheduler.yield(.{ .wait = .{
        .timeout = .after(duration),
    } });
    assert(scheduler.current_task.state.running.timeout);
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
        \\addi sp, sp, -16
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

    const current_task = scheduler.current_task;
    const ready_task = scheduler.ready_queue.pop(scheduler.current_task.priority) orelse return;

    // swap contexts
    current_task.context = context.*;
    context.* = ready_task.context;

    // keep the state until the next yield
    current_task.state = Task.State{ .ready = current_task.state.running };
    scheduler.ready_queue.put(current_task);

    ready_task.state = Task.State{ .running = ready_task.state.ready };
    scheduler.current_task = ready_task;
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

        if (ticks.is_reached())
            scheduler.sweep_timer_queue_for_timeouts();
    }
}

pub fn generic_interrupt_handler(_: *TrapFrame) callconv(.c) void {
    const scheduler = maybe_instance orelse @panic("no active scheduler");

    var iter: microzig.cpu.interrupt.SourceIterator = .init();
    while (iter.next()) |source| {
        switch (source) {
            .systimer_target0 => {
                const cs = enter_critical_section();
                defer cs.leave();

                systimer_alarm.clear_interrupt();

                scheduler.sweep_timer_queue_for_timeouts();
            },
            else => {},
        }
    }

    if (scheduler.is_a_higher_priority_task_ready()) {
        yield_from_isr();
    }
}

fn sweep_timer_queue_for_timeouts(scheduler: *Scheduler) void {
    while (scheduler.timer_queue.popFirst()) |node| {
        const task: *Task = @alignCast(@fieldParentPtr("node", node));
        if (!task.state.alarm_set.is_reached()) {
            scheduler.timer_queue.prepend(&task.node);
            break;
        }

        if (task.wait_queue) |wait_queue| {
            wait_queue.remove(task);
            task.wait_queue = null;
        }

        scheduler.ready(task, .{ .timeout = true });
    }

    if (scheduler.timer_queue.first) |node| {
        const task: *Task = @alignCast(@fieldParentPtr("node", node));
        systimer_alarm.set_target(@intFromEnum(task.state.alarm_set));
        systimer_alarm.set_enabled(true);
    } else {
        systimer_alarm.set_enabled(false);
    }
}

fn ready(scheduler: *Scheduler, task: *Task, flags: Task.ReadyFlags) void {
    assert(task.state != .ready);
    task.state = .{ .ready = flags };
    scheduler.ready_queue.put(task);
}

// fn maybe_inherit_priority_section(scheduler: *Scheduler, task: *Task, priority: Priority) void {
//     if (!priority.is_greater(task.priority)) return;
//
//     task.priority = priority;
//
//     switch (task.state) {
//         .ready => {
//             scheduler.ready_queue.inner.remove(task);
//             scheduler.ready_queue.put(task);
//         },
//         else => {},
//     }
//
//     if (task.active_wait_list) |wait_list| {
//         wait_list.list.update_priority(wait_list.awaiter);
//     }
// }

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

    /// Node used for external wait queues.
    wait_queue_node: std.DoublyLinkedList.Node = .{},

    /// The wait queue in which this task is currently placed.
    wait_queue: ?*PriorityWaitQueue = null,

    pub const State = union(enum) {
        none,
        ready: ReadyFlags,
        running: ReadyFlags,
        alarm_set: TimerTicks,
        suspended,
        scheduled_for_deletion,
    };

    pub const ReadyFlags = packed struct(u1) {
        timeout: bool = false,
    };

    pub const WaitQueueEntry = struct {
        queue: *std.DoublyLinkedList,
        node: std.DoublyLinkedList = .{},
    };
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

    pub fn put(pq: *ReadyPriorityQueue, new_task: *Task) void {
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

pub const PriorityWaitQueue = struct {
    list: std.DoublyLinkedList = .{},

    pub fn pop(q: *PriorityWaitQueue) ?*Task {
        if (q.list.popFirst()) |first_node| {
            return @alignCast(@fieldParentPtr("wait_queue_node", first_node));
        } else {
            return null;
        }
    }

    pub fn put(q: *PriorityWaitQueue, task: *Task) void {
        var it = q.list.first;
        while (it) |current_node| : (it = current_node.next) {
            const current_task: *Task = @alignCast(@fieldParentPtr("wait_queue_node", current_node));
            if (task.priority.is_greater(current_task.priority)) {
                q.list.insertBefore(&current_task.wait_queue_node, &task.wait_queue_node);
                break;
            }
        } else {
            q.list.append(&task.wait_queue_node);
        }
    }

    pub fn remove(q: *PriorityWaitQueue, task: *Task) void {
        q.list.remove(&task.wait_queue_node);
    }

    pub fn update_priority(q: *PriorityWaitQueue, task: *Task) void {
        q.remove(&task.wait_queue_node);
        q.put(task);
    }
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

pub const Mutex = struct {
    state: State = .unlocked,
    wait_queue: PriorityWaitQueue = .{},

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

        while (mutex.state != .unlocked) {
            scheduler.yield(.{ .wait = .{
                .timeout = maybe_timeout_ticks,
                .wait_queue = &mutex.wait_queue,
            } });
            if (scheduler.current_task.state.running.timeout)
                return error.Timeout;
        }

        mutex.state = .locked;
    }

    pub fn unlock(mutex: *Mutex, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        assert(mutex.state == .locked);
        mutex.state = .unlocked;

        scheduler.wake_from_wait_queue(&mutex.wait_queue, .one);
    }
};

pub const RecursiveMutex = struct {
    value: u32 = 0,
    owning_task: ?*Task = null,
    wait_queue: PriorityWaitQueue = .{},

    pub fn lock(mutex: *RecursiveMutex, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer cs.leave();

        const current_task = scheduler.current_task;

        if (mutex.owning_task == current_task) {
            mutex.value += 1;
            return;
        }

        // if (mutex.owning_task) |owning_task| {
        //     // if (current_task.priority.is_greater(owning_task.priority)) {
        //     //     scheduler.change_task_priority_from_cs(owning_task, current_task.priority, cs);
        //     // }
        //
        while (mutex.owning_task != null) {
            scheduler.yield(.{ .wait = .{
                .wait_queue = &mutex.wait_queue,
            } });
        }
        // }

        assert(mutex.value == 0);
        mutex.value += 1;
        mutex.owning_task = current_task;
    }

    pub fn unlock(mutex: *RecursiveMutex, scheduler: *Scheduler) bool {
        const cs = enter_critical_section();

        assert(mutex.value > 0);
        mutex.value -= 1;
        if (mutex.value <= 0) {
            defer scheduler.yield_and_leave_cs(.reschedule, cs);

            mutex.owning_task = null;
            scheduler.wake_from_wait_queue(&mutex.wait_queue, .one);

            return true;
        } else {
            cs.leave();
            return false;
        }
    }
};

pub const Semaphore = struct {
    value: u32,
    wait_queue: PriorityWaitQueue = .{},

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

        while (sem.value <= 0) {
            scheduler.yield(.{ .wait = .{
                .timeout = maybe_timeout_ticks,
                .wait_queue = &sem.wait_queue,
            } });
            if (scheduler.current_task.state.running.timeout)
                return error.Timeout;
        }

        sem.value -= 1;
    }

    pub fn give(sem: *Semaphore, scheduler: *Scheduler) void {
        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        sem.value += 1;

        scheduler.wake_from_wait_queue(&sem.wait_queue, .one);
    }
};

pub const TypeErasedQueue = struct {
    buffer: []u8,
    start: usize,
    len: usize,

    putters: PriorityWaitQueue,
    getters: PriorityWaitQueue,

    pub fn init(buffer: []u8) TypeErasedQueue {
        assert(buffer.len != 0); // buffer len must be greater than 0
        return .{
            .buffer = buffer,
            .start = 0,
            .len = 0,
            .putters = .{},
            .getters = .{},
        };
    }

    pub fn put(
        q: *TypeErasedQueue,
        scheduler: *Scheduler,
        elements: []const u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) usize {
        assert(elements.len >= min);
        if (elements.len == 0) return 0;

        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var n: usize = 0;

        while (true) {
            n += q.put_non_blocking_from_cs(scheduler, elements[n..]);
            if (n >= min) return n;

            scheduler.yield(.{ .wait = .{
                .timeout = maybe_timeout_ticks,
                .wait_queue = &q.putters,
            } });
            if (scheduler.current_task.state.running.timeout)
                return n;
        }
    }

    pub fn put_non_blocking(q: *TypeErasedQueue, scheduler: *Scheduler, elements: []const u8) usize {
        const cs = enter_critical_section();
        defer cs.leave();

        return q.put_non_blocking_from_cs(scheduler, elements);
    }

    fn put_non_blocking_from_cs(q: *TypeErasedQueue, scheduler: *Scheduler, elements: []const u8) usize {
        var n: usize = 0;
        while (q.puttable_slice()) |slice| {
            const copy_len = @min(slice.len, elements.len - n);
            assert(copy_len > 0);
            @memcpy(slice[0..copy_len], elements[n..][0..copy_len]);
            q.len += copy_len;
            n += copy_len;
            if (n == elements.len) break;
        }
        if (n > 0) scheduler.wake_from_wait_queue(&q.getters, .one);
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

    pub fn get(
        q: *TypeErasedQueue,
        scheduler: *Scheduler,
        buffer: []u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) usize {
        assert(buffer.len >= min);
        if (buffer.len == 0) return 0;

        const cs = enter_critical_section();
        defer scheduler.yield_and_leave_cs(.reschedule, cs);

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var n: usize = 0;

        while (true) {
            n += q.get_non_blocking_from_cs(scheduler, buffer[n..]);
            if (n >= min) return n;

            scheduler.yield(.{ .wait = .{
                .timeout = maybe_timeout_ticks,
                .wait_queue = &q.getters,
            } });
            if (scheduler.current_task.state.running.timeout)
                return n;
        }
    }

    pub fn get_non_blocking(q: *TypeErasedQueue, scheduler: *Scheduler, buffer: []u8) usize {
        const cs = enter_critical_section();
        defer cs.leave();

        return q.get_non_blocking_from_cs(scheduler, buffer);
    }

    fn get_non_blocking_from_cs(q: *TypeErasedQueue, scheduler: *Scheduler, buffer: []u8) usize {
        var n: usize = 0;
        while (q.gettable_slice()) |slice| {
            const copy_len = @min(slice.len, buffer.len - n);
            assert(copy_len > 0);
            @memcpy(buffer[n..][0..copy_len], slice[0..copy_len]);
            q.start += copy_len;
            if (q.buffer.len - q.start == 0) q.start = 0;
            q.len -= copy_len;
            n += copy_len;
            if (n == buffer.len) break;
        }
        if (n > 0) scheduler.wake_from_wait_queue(&q.putters, .one);
        return n;
    }

    fn gettable_slice(q: *const TypeErasedQueue) ?[]const u8 {
        const overlong_slice = q.buffer[q.start..];
        const slice = overlong_slice[0..@min(overlong_slice.len, q.len)];
        return if (slice.len > 0) slice else null;
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

        pub fn put(q: *Self, scheduler: *Scheduler, elements: []const Elem, min: usize, timeout: ?time.Duration) usize {
            return @divExact(q.type_erased.put(scheduler, @ptrCast(elements), min * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn put_all(q: *Self, scheduler: *Scheduler, elements: []const Elem, timeout: ?time.Duration) TimeoutError!void {
            if (q.put(scheduler, elements, elements.len, timeout) != elements.len)
                return error.Timeout;
        }

        pub fn put_one(q: *Self, scheduler: *Scheduler, item: Elem) TimeoutError!void {
            if (q.put(scheduler, &.{item}, 1, null) != 1)
                return error.Timeout;
        }

        pub fn put_non_blocking(q: *Self, scheduler: *Scheduler, elements: []const Elem) usize {
            return @divExact(q.type_erased.put_non_blocking(scheduler, @ptrCast(elements)), @sizeOf(Elem));
        }

        pub fn put_one_non_blocking(q: *Self, scheduler: *Scheduler, item: Elem) bool {
            return q.put_non_blocking(scheduler, @ptrCast(&item)) == 1;
        }

        pub fn get(q: *Self, scheduler: *Scheduler, buffer: []Elem, target: usize, timeout: ?time.Duration) usize {
            return @divExact(q.type_erased.get(scheduler, @ptrCast(buffer), target * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn get_one(q: *Self, scheduler: *Scheduler, timeout: ?time.Duration) TimeoutError!Elem {
            var buf: [1]Elem = undefined;
            if (q.get(scheduler, &buf, 1, timeout) != 1)
                return error.Timeout;
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
