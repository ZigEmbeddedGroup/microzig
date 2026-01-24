const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;
const log = std.log.scoped(.rtos);
const builtin = @import("builtin");

const microzig = @import("microzig");
const CriticalSection = microzig.interrupt.CriticalSection;
const enter_critical_section = microzig.interrupt.enter_critical_section;
const TrapFrame = microzig.cpu.TrapFrame;
const SYSTEM = microzig.chip.peripherals.SYSTEM;
const time = microzig.drivers.time;
const rtos_options = microzig.options.hal.rtos;
pub const Priority = rtos_options.Priority;

const get_time_since_boot = @import("time.zig").get_time_since_boot;
const system = @import("system.zig");
const systimer = @import("systimer.zig");

// How it works?
//
// For task to task context switches, only required registers are
// saved through the use of inline assembly clobbers. If a higher priority task
// becomes ready during the handling of an interrupt, a task switch is forced
// by saving the entire state of the task on the stack. What is interesting is
// that the two context switches are compatible. Voluntary yield can resume a
// task that was interrupted by force and vice versa. Because of the forced
// yield, tasks are required to have a minimum stack size available at all
// times.

// TODO: stack overflow detection
// TODO: task joining and deletion
//       - the idea is that tasks must return before they can be freed
// TODO: direct task signaling
// TODO: implement std.Io
// TODO: use @stackUpperBound when implemented
// TODO: support SMP for other esp32 chips with multicore (far future)

const STACK_ALIGN: std.mem.Alignment = .@"16";
const EXTRA_STACK_SIZE = @max(@sizeOf(TrapFrame), 32 * @sizeOf(usize));

pub const Options = struct {
    enable: bool = false,
    Priority: type = enum(u8) {
        idle = 0,
        lowest = 1,
        _,

        pub const highest: @This() = @enumFromInt(std.math.maxInt(@typeInfo(@This()).@"enum".tag_type));
    },
    general_purpose_interrupt: microzig.cpu.Interrupt = .interrupt30,
    systimer_unit: systimer.Unit = .unit0,
    systimer_alarm: systimer.Alarm = .alarm0,
    cpu_interrupt: system.CPU_Interrupt = .cpu_interrupt_0,
    yield_interrupt: microzig.cpu.Interrupt = .interrupt31,

    paint_stack_byte: ?u8 = null,
};

var main_task: Task = .{
    .name = "main",
    .context = undefined,
    .priority = .lowest,
    .stack = &.{},
};
var idle_stack: [STACK_ALIGN.forward(EXTRA_STACK_SIZE)]u8 align(STACK_ALIGN.toByteUnits()) = undefined;
var idle_task: Task = .{
    .name = "idle",
    .context = .{
        .pc = &idle,
        .sp = idle_stack[idle_stack.len..].ptr,
        .fp = null,
    },
    .priority = .idle,
    .stack = &idle_stack,
};

var rtos_state: RTOS_State = undefined;
pub const RTOS_State = struct {
    ready_queue: ReadyPriorityQueue = .{},
    timer_queue: std.DoublyLinkedList = .{},
    suspended_list: std.DoublyLinkedList = .{},
    scheduled_for_deletion_list: std.DoublyLinkedList = .{},

    /// The task in .running state. Safe to access outside of critical section
    /// as it is always the same for the currently executing task.
    current_task: *Task,
};

/// Automatically called inside hal startup sequence if it the rtos is enabled
/// in hal options.
pub fn init() void {
    comptime {
        if (!microzig.options.cpu.interrupt_stack.enable)
            @compileError("rtos requires the interrupt stack cpu option to be enabled");
        microzig.cpu.interrupt.expect_handler(rtos_options.general_purpose_interrupt, general_purpose_interrupt_handler);
        microzig.cpu.interrupt.expect_handler(rtos_options.yield_interrupt, yield_interrupt_handler);
    }

    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    rtos_state = .{
        .current_task = &main_task,
    };
    if (rtos_options.paint_stack_byte) |paint_byte| {
        @memset(&idle_stack, paint_byte);
    }
    make_ready(&idle_task);

    microzig.cpu.interrupt.map(rtos_options.cpu_interrupt.source(), rtos_options.yield_interrupt);
    microzig.cpu.interrupt.set_type(rtos_options.yield_interrupt, .level);
    microzig.cpu.interrupt.set_priority(rtos_options.yield_interrupt, .lowest);
    microzig.cpu.interrupt.enable(rtos_options.yield_interrupt);

    // unit0 is already enabled as it is used by `hal.time`.
    if (rtos_options.systimer_unit != .unit0) {
        rtos_options.systimer_unit.apply(.enabled);
    }
    rtos_options.systimer_alarm.set_unit(rtos_options.systimer_unit);
    rtos_options.systimer_alarm.set_mode(.target);
    rtos_options.systimer_alarm.set_enabled(false);
    rtos_options.systimer_alarm.set_interrupt_enabled(true);

    microzig.cpu.interrupt.map(rtos_options.systimer_alarm.interrupt_source(), rtos_options.general_purpose_interrupt);
    microzig.cpu.interrupt.set_type(rtos_options.general_purpose_interrupt, .level);
    microzig.cpu.interrupt.set_priority(rtos_options.general_purpose_interrupt, .lowest);
    microzig.cpu.interrupt.enable(rtos_options.general_purpose_interrupt);
}

// TODO: deinit

fn idle() linksection(".ram_text") callconv(.naked) void {
    // interrupts are initially disabled in new tasks
    asm volatile (
        \\csrsi mstatus, 8
        \\1:
        \\wfi
        \\j 1b
    );
}

pub fn get_current_task() *Task {
    return rtos_state.current_task;
}

pub const SpawnOptions = struct {
    name: ?[]const u8 = null,
    stack_size: usize = 4096,
    priority: Priority = .lowest,
};

pub fn spawn(
    gpa: std.mem.Allocator,
    comptime function: anytype,
    args: std.meta.ArgsTuple(@TypeOf(function)),
    options: SpawnOptions,
) !*Task {
    assert(options.priority != .idle);

    const Args = @TypeOf(args);
    const args_align: std.mem.Alignment = comptime .fromByteUnits(@alignOf(Args));

    const TypeErased = struct {
        fn call() callconv(.c) void {
            // interrupts are initially disabled in new tasks
            microzig.cpu.interrupt.enable_interrupts();

            const context_ptr: *const Args =
                @ptrFromInt(args_align.forward(@intFromPtr(rtos_state.current_task) + @sizeOf(Task)));
            @call(.auto, function, context_ptr.*);
            if (@typeInfo(@TypeOf(function)).@"fn".return_type.? != noreturn) {
                yield(.delete);
                unreachable;
            }
        }
    };

    const alloc_align = comptime STACK_ALIGN.max(.of(Task)).max(args_align);

    const args_start = args_align.forward(@sizeOf(Task));
    const stack_start = STACK_ALIGN.forward(args_start + @sizeOf(Args));
    const stack_end = STACK_ALIGN.forward(stack_start + options.stack_size + EXTRA_STACK_SIZE);

    const alloc_size = stack_end;
    const raw_alloc = try gpa.alignedAlloc(u8, alloc_align, alloc_size);

    const task: *Task = @ptrCast(@alignCast(raw_alloc));

    const task_args: *Args = @ptrCast(@alignCast(raw_alloc[args_start..][0..@sizeOf(Args)]));
    task_args.* = args;

    const stack: []u8 = raw_alloc[stack_start..stack_end];
    if (rtos_options.paint_stack_byte) |paint_byte| {
        @memset(stack, paint_byte);
    }

    task.* = .{
        .name = options.name,
        .context = .{
            .sp = stack[stack.len..].ptr,
            .pc = &TypeErased.call,
            .fp = null,
        },
        .stack = stack,
        .priority = options.priority,
    };

    const cs = enter_critical_section();
    defer cs.leave();

    make_ready(task);

    return task;
}

/// Must execute inside a critical section.
pub fn make_ready(task: *Task) void {
    switch (task.state) {
        .ready, .running, .scheduled_for_deletion => return,
        .none => {},
        .alarm_set => {
            rtos_state.timer_queue.remove(&task.node);
        },
        .suspended => {
            rtos_state.suspended_list.remove(&task.node);
        },
    }

    task.state = .ready;
    rtos_state.ready_queue.put(task);
}

pub const YieldAction = union(enum) {
    reschedule,
    wait: struct {
        timeout: ?TimerTicks = null,
    },
    delete,
};

pub inline fn yield(action: YieldAction) void {
    const cs = enter_critical_section();
    defer cs.leave();

    const current_task, const next_task = yield_inner(action);
    context_switch(&current_task.context, &next_task.context);
}

fn yield_inner(action: YieldAction) linksection(".ram_text") struct { *Task, *Task } {
    assert(microzig.cpu.csr.mscratch.read_raw() == 0);

    const current_task = rtos_state.current_task;
    action: switch (action) {
        .reschedule => {
            current_task.state = .ready;
            rtos_state.ready_queue.put(current_task);
        },
        .wait => |wait_action| {
            assert(current_task != &idle_task);

            if (wait_action.timeout) |timeout| {
                if (timeout.is_reached_by(.now())) {
                    continue :action .reschedule;
                }

                schedule_wake_at(current_task, timeout);
            } else {
                current_task.state = .suspended;
                rtos_state.suspended_list.append(&current_task.node);
            }
        },
        .delete => {
            assert(current_task != &idle_task and current_task != &main_task);

            current_task.state = .scheduled_for_deletion;
            rtos_state.scheduled_for_deletion_list.append(&current_task.node);
        },
    }

    const next_task: *Task = rtos_state.ready_queue.pop(null) orelse @panic("No task ready to run!");

    next_task.state = .running;
    rtos_state.current_task = next_task;

    return .{ current_task, next_task };
}

pub fn sleep(duration: time.Duration) void {
    const timeout: TimerTicks = .after(duration);
    while (!timeout.is_reached_by(.now()))
        yield(.{ .wait = .{ .timeout = timeout } });
}

inline fn context_switch(prev_context: *Context, next_context: *Context) void {
    // Clobber all registers (except sp) to restore them after the context
    // switch.
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
    rtos_options.cpu_interrupt.set_pending(true);
}

pub fn is_a_higher_priority_task_ready() bool {
    return if (rtos_state.ready_queue.peek_top()) |top_ready_task|
        @intFromEnum(top_ready_task.priority) > @intFromEnum(rtos_state.current_task.priority)
    else
        false;
}

pub const yield_interrupt_handler: microzig.cpu.InterruptHandler = .{
    .naked = struct {
        pub fn handler_fn() linksection(".ram_vectors") callconv(.naked) void {
            comptime {
                assert(@sizeOf(Context) == 3 * @sizeOf(usize));
            }

            asm volatile (
                \\
                \\addi sp, sp, -32*4
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
                // s0 is saved in context
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
                \\csrr a0, mepc
                \\sw a0, 29*4(sp)
                \\
                \\csrr a0, mstatus
                \\sw a0, 30*4(sp)
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
                \\jal %[schedule_in_isr]
                \\
                // load next task context
                \\lw a1, 0(sp)
                \\lw a2, 4(sp)
                \\lw s0, 8(sp)
                // change sp to the new task
                \\mv sp, a2
                \\
                // if the next task program counter is equal to 1f's location
                // just jump to it (ie. the task forcefully yielded).
                \\la a0, 1f
                \\beq a1, a0, 1f
                \\
                // ensure interrupts are disabled after mret (when a normal
                // context switch occured)
                \\li a0, 0x80
                \\csrc mstatus, a0
                \\
                // jump to new task
                \\csrw mepc, a1
                \\mret
                \\
                \\1:
                \\
                \\lw a0, 30*4(sp)
                \\csrw mstatus, a0
                \\
                \\lw a0, 29*4(sp)
                \\csrw mepc, a0
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
                \\addi sp, sp, 32*4
                \\mret
                :
                : [schedule_in_isr] "i" (&schedule_in_isr),
                  [interrupt_stack_top] "i" (microzig.cpu.interrupt_stack[microzig.cpu.interrupt_stack.len..].ptr),
            );
        }
    }.handler_fn,
};

// Can't be preempted by a higher priority interrupt.
fn schedule_in_isr(context: *Context) linksection(".ram_vectors") callconv(.c) void {
    rtos_options.cpu_interrupt.set_pending(false);

    const current_task = rtos_state.current_task;
    const ready_task = rtos_state.ready_queue.pop(rtos_state.current_task.priority) orelse return;

    // swap contexts
    current_task.context = context.*;
    context.* = ready_task.context;

    current_task.state = .ready;
    rtos_state.ready_queue.put(current_task);

    ready_task.state = .running;
    rtos_state.current_task = ready_task;
}

pub const general_purpose_interrupt_handler: microzig.cpu.InterruptHandler = .{ .c = struct {
    pub fn handler_fn(_: *TrapFrame) linksection(".ram_text") callconv(.c) void {
        var status: microzig.cpu.interrupt.Status = .init();
        if (status.is_set(rtos_options.systimer_alarm.interrupt_source())) {
            const cs = enter_critical_section();
            defer cs.leave();

            rtos_options.systimer_alarm.clear_interrupt();

            sweep_timer_queue();
        }

        if (is_a_higher_priority_task_ready()) {
            yield_from_isr();
        }
    }
}.handler_fn };

/// Must execute inside a critical section.
fn schedule_wake_at(sleeping_task: *Task, ticks: TimerTicks) void {
    sleeping_task.state = .{ .alarm_set = ticks };

    var maybe_node = rtos_state.timer_queue.first;
    while (maybe_node) |node| : (maybe_node = node.next) {
        const task: *Task = @alignCast(@fieldParentPtr("node", node));
        if (ticks.is_reached_by(task.state.alarm_set)) {
            rtos_state.timer_queue.insertBefore(&task.node, &sleeping_task.node);
            break;
        }
    } else {
        rtos_state.timer_queue.append(&sleeping_task.node);
    }

    // If we updated the first element of the list, it means that we have to
    // reschedule the timer
    if (rtos_state.timer_queue.first == &sleeping_task.node) {
        rtos_options.systimer_alarm.set_target(@intFromEnum(ticks));
        rtos_options.systimer_alarm.set_enabled(true);
        if (ticks.is_reached_by(.now())) {
            sweep_timer_queue();
        }
    }
}

fn sweep_timer_queue() void {
    while (rtos_state.timer_queue.popFirst()) |node| {
        const task: *Task = @alignCast(@fieldParentPtr("node", node));
        if (!task.state.alarm_set.is_reached_by(.now())) {
            rtos_state.timer_queue.prepend(&task.node);
            rtos_options.systimer_alarm.set_target(@intFromEnum(task.state.alarm_set));
            rtos_options.systimer_alarm.set_enabled(true);
            if (task.state.alarm_set.is_reached_by(.now()))
                continue
            else
                break;
        }
        task.state = .ready;
        rtos_state.ready_queue.put(task);
    } else {
        rtos_options.systimer_alarm.set_enabled(false);
    }
}

pub fn log_tasks_info() void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    log_task_info(get_current_task());

    const list: []const ?*std.DoublyLinkedList.Node = &.{
        rtos_state.ready_queue.inner.first,
        rtos_state.timer_queue.first,
        rtos_state.suspended_list.first,
        rtos_state.scheduled_for_deletion_list.first,
    };
    for (list) |first| {
        var it: ?*std.DoublyLinkedList.Node = first;
        while (it) |node| : (it = node.next) {
            const task: *Task = @alignCast(@fieldParentPtr("node", node));
            log_task_info(task);
        }
    }
}

fn log_task_info(task: *Task) void {
    if (rtos_options.paint_stack_byte) |paint_byte| {
        const stack_usage = for (task.stack, 0..) |byte, i| {
            if (byte != paint_byte) {
                break task.stack.len - i;
            }
        } else task.stack.len;

        log.debug("task {?s} with prio {} in state {t} uses {} bytes out of {} for stack", .{
            task.name,
            @intFromEnum(task.priority),
            task.state,
            stack_usage,
            task.stack.len,
        });
    } else {
        log.debug("task {?s} with prio {} in state {t}", .{
            task.name,
            @intFromEnum(task.priority),
            task.state,
        });
    }
}

pub const Task = struct {
    name: ?[]const u8 = null,

    context: Context,
    stack: []u8,
    priority: Priority,

    /// What is the deal with this task right now?
    state: State = .none,

    /// Node used for rtos internal lists.
    node: std.DoublyLinkedList.Node = .{},

    /// Task specific semaphore (required by the wifi driver)
    semaphore: Semaphore = .init(0, 1),

    pub const State = union(enum) {
        none,
        ready,
        running,
        alarm_set: TimerTicks,
        suspended,
        scheduled_for_deletion,
    };
};

pub const Context = extern struct {
    pc: ?*const anyopaque,
    sp: ?*const anyopaque,
    fp: ?*const anyopaque,

    pub fn format(
        self: Context,
        writer: *std.Io.Writer,
    ) std.Io.Writer.Error!void {
        try writer.print(".{{ .pc = 0x{x}, .sp = 0x{x}, .fp = 0x{x} }}", .{
            @intFromPtr(self.pc),
            @intFromPtr(self.sp),
            @intFromPtr(self.fp),
        });
    }
};

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
                if (@intFromEnum(task.priority) <= @intFromEnum(more_than_prio)) {
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
            if (@intFromEnum(new_task.priority) > @intFromEnum(task.priority)) {
                pq.inner.insertBefore(node, &new_task.node);
                break;
            }
        } else {
            pq.inner.append(&new_task.node);
        }
    }
};

pub const TimerTicks = enum(u52) {
    _,

    pub fn now() TimerTicks {
        return @enumFromInt(rtos_options.systimer_unit.read());
    }

    pub fn after(duration: time.Duration) TimerTicks {
        return TimerTicks.now().add_duration(duration);
    }

    pub fn is_reached_by(a: TimerTicks, b: TimerTicks) bool {
        const _a = @intFromEnum(a);
        const _b = @intFromEnum(b);
        return _b -% _a < std.math.maxInt(u51);
    }

    pub fn add_duration(ticks: TimerTicks, duration: time.Duration) TimerTicks {
        return @enumFromInt(@intFromEnum(ticks) +% @as(u52, @intCast(duration.to_us())) * systimer.ticks_per_us());
    }
};

pub const TimeoutError = error{Timeout};

pub const PriorityWaitQueue = struct {
    list: std.DoublyLinkedList = .{},

    pub const Waiter = struct {
        task: *Task,
        priority: Priority,
        node: std.DoublyLinkedList.Node = .{},
    };

    /// Must execute inside a critical section.
    pub fn wake_one(q: *PriorityWaitQueue) void {
        if (q.list.first) |first_node| {
            const waiter: *Waiter = @alignCast(@fieldParentPtr("node", first_node));
            make_ready(waiter.task);
        }
    }

    /// Must execute inside a critical section.
    pub fn wake_all(q: *PriorityWaitQueue) void {
        while (q.list.popFirst()) |current_node| {
            const current_waiter: *Waiter = @alignCast(@fieldParentPtr("node", current_node));
            make_ready(current_waiter.task);
        }
    }

    /// Must execute inside a critical section.
    pub fn wait(q: *PriorityWaitQueue, task: *Task, maybe_timeout: ?TimerTicks) void {
        var waiter: Waiter = .{
            .task = task,
            .priority = task.priority,
        };

        var it = q.list.first;
        while (it) |current_node| : (it = current_node.next) {
            const current_waiter: *Waiter = @alignCast(@fieldParentPtr("node", current_node));
            if (@intFromEnum(waiter.priority) > @intFromEnum(current_waiter.priority)) {
                q.list.insertBefore(&current_waiter.node, &waiter.node);
                break;
            }
        } else {
            q.list.append(&waiter.node);
        }

        yield(.{ .wait = .{
            .timeout = maybe_timeout,
        } });

        q.list.remove(&waiter.node);
    }
};

pub const Mutex = struct {
    locked: ?*Task = null,
    prev_priority: ?Priority = null,
    wait_queue: PriorityWaitQueue = .{},

    pub fn lock(mutex: *Mutex) void {
        mutex.lock_with_timeout(null) catch unreachable;
    }

    pub fn lock_with_timeout(mutex: *Mutex, maybe_timeout: ?time.Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const current_task = get_current_task();

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        assert(mutex.locked != current_task);

        while (mutex.locked) |owning_task| {
            if (maybe_timeout_ticks) |timeout_ticks|
                if (timeout_ticks.is_reached_by(.now()))
                    return error.Timeout;

            // Owning task inherits the priority of the current task if it the
            // current task has a bigger priority.
            if (@intFromEnum(current_task.priority) > @intFromEnum(owning_task.priority)) {
                if (mutex.prev_priority == null)
                    mutex.prev_priority = owning_task.priority;
                owning_task.priority = current_task.priority;
                make_ready(owning_task);
            }

            mutex.wait_queue.wait(current_task, maybe_timeout_ticks);
        }

        mutex.locked = current_task;
    }

    pub fn unlock(mutex: *Mutex) void {
        const cs = enter_critical_section();
        defer cs.leave();

        mutex.unlock_impl();
    }

    fn unlock_impl(mutex: *Mutex) void {
        const owning_task = mutex.locked.?;

        // Restore the priority of the task
        if (mutex.prev_priority) |prev_priority| {
            owning_task.priority = prev_priority;
            mutex.prev_priority = null;
        }

        mutex.locked = null;
        mutex.wait_queue.wake_one();
    }
};

pub const Condition = struct {
    wait_queue: PriorityWaitQueue = .{},

    pub fn wait(cond: *Condition, mutex: *Mutex) void {
        {
            const cs = enter_critical_section();
            defer cs.leave();
            mutex.unlock_impl();
            cond.wait_queue.wait(get_current_task(), null);
        }

        mutex.lock();
    }

    pub fn signal(cond: *Condition) void {
        const cs = enter_critical_section();
        defer cs.leave();
        cond.wait_queue.wake_one();
    }

    pub fn broadcast(cond: *Condition) void {
        const cs = enter_critical_section();
        defer cs.leave();
        cond.wait_queue.wake_all();
    }
};

pub const Semaphore = struct {
    current_value: u32,
    max_value: u32,
    wait_queue: PriorityWaitQueue = .{},

    pub fn init(initial_value: u32, max_value: u32) Semaphore {
        assert(initial_value <= max_value);
        assert(max_value > 0);

        return .{
            .current_value = initial_value,
            .max_value = max_value,
        };
    }

    pub fn take(sem: *Semaphore) void {
        sem.take_with_timeout(null) catch unreachable;
    }

    pub fn take_with_timeout(sem: *Semaphore, maybe_timeout: ?time.Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        while (sem.current_value <= 0) {
            if (maybe_timeout_ticks) |timeout_ticks|
                if (timeout_ticks.is_reached_by(.now()))
                    return error.Timeout;

            sem.wait_queue.wait(rtos_state.current_task, maybe_timeout_ticks);
        }

        sem.current_value -= 1;
    }

    pub fn give(sem: *Semaphore) void {
        const cs = enter_critical_section();
        defer cs.leave();

        sem.current_value += 1;
        if (sem.current_value > sem.max_value) {
            sem.current_value = sem.max_value;
        } else {
            sem.wait_queue.wake_one();
        }
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
        elements: []const u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) usize {
        assert(elements.len >= min);
        if (elements.len == 0) return 0;

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var n: usize = 0;

        const cs = enter_critical_section();
        defer cs.leave();

        while (true) {
            n += q.put_non_blocking_from_cs(elements[n..]);
            if (n >= min) return n;

            if (maybe_timeout_ticks) |timeout_ticks|
                if (timeout_ticks.is_reached_by(.now()))
                    return n;

            q.putters.wait(rtos_state.current_task, maybe_timeout_ticks);
        }
    }

    pub fn put_non_blocking(q: *TypeErasedQueue, elements: []const u8) usize {
        const cs = enter_critical_section();
        defer cs.leave();

        return q.put_non_blocking_from_cs(elements);
    }

    fn put_non_blocking_from_cs(q: *TypeErasedQueue, elements: []const u8) usize {
        var n: usize = 0;
        while (q.puttable_slice()) |slice| {
            const copy_len = @min(slice.len, elements.len - n);
            assert(copy_len > 0);
            @memcpy(slice[0..copy_len], elements[n..][0..copy_len]);
            q.len += copy_len;
            n += copy_len;
            if (n == elements.len) break;
        }
        if (n > 0) q.getters.wake_one();
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
        buffer: []u8,
        min: usize,
        maybe_timeout: ?time.Duration,
    ) usize {
        assert(buffer.len >= min);
        if (buffer.len == 0) return 0;

        const maybe_timeout_ticks: ?TimerTicks = if (maybe_timeout) |timeout|
            .after(timeout)
        else
            null;

        var n: usize = 0;

        const cs = enter_critical_section();
        defer cs.leave();

        while (true) {
            n += q.get_non_blocking_from_cs(buffer[n..]);
            if (n >= min) return n;

            if (maybe_timeout_ticks) |timeout_ticks|
                if (timeout_ticks.is_reached_by(.now()))
                    return n;

            q.getters.wait(rtos_state.current_task, maybe_timeout_ticks);
        }
    }

    pub fn get_non_blocking(q: *TypeErasedQueue, buffer: []u8) usize {
        const cs = enter_critical_section();
        defer cs.leave();

        return q.get_non_blocking_from_cs(buffer);
    }

    fn get_non_blocking_from_cs(q: *TypeErasedQueue, buffer: []u8) usize {
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
        if (n > 0) q.putters.wake_one();
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

        pub fn put(q: *Self, elements: []const Elem, min: usize, timeout: ?time.Duration) usize {
            return @divExact(q.type_erased.put(@ptrCast(elements), min * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn put_all(q: *Self, elements: []const Elem, timeout: ?time.Duration) TimeoutError!void {
            if (q.put(elements, elements.len, timeout) != elements.len)
                return error.Timeout;
        }

        pub fn put_one(q: *Self, item: Elem, timeout: ?time.Duration) TimeoutError!void {
            if (q.put(&.{item}, 1, timeout) != 1)
                return error.Timeout;
        }

        pub fn put_non_blocking(q: *Self, elements: []const Elem) usize {
            return @divExact(q.type_erased.put_non_blocking(@ptrCast(elements)), @sizeOf(Elem));
        }

        pub fn put_one_non_blocking(q: *Self, item: Elem) bool {
            return q.put_non_blocking(@ptrCast(&item)) == 1;
        }

        pub fn get(q: *Self, buffer: []Elem, target: usize, timeout: ?time.Duration) usize {
            return @divExact(q.type_erased.get(@ptrCast(buffer), target * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn get_one(q: *Self, timeout: ?time.Duration) TimeoutError!Elem {
            var buf: [1]Elem = undefined;
            if (q.get(&buf, 1, timeout) != 1)
                return error.Timeout;
            return buf[0];
        }

        pub fn get_one_non_blocking(q: *Self) ?Elem {
            var buf: [1]Elem = undefined;
            if (q.type_erased.get_non_blocking(@ptrCast(&buf)) == 1) {
                return buf[0];
            } else {
                return null;
            }
        }

        pub fn capacity(q: *const Self) usize {
            return @divExact(q.type_erased.buffer.len, @sizeOf(Elem));
        }
    };
}
