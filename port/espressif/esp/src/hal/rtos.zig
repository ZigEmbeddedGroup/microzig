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

// TODO: trigger context switch if a higher priority is awaken in sync
// primitives
// TODO: low power mode where tick interrupt is only triggered when necessary
// TODO: investigate tick interrupt assembly and improve generated code
// TODO: stack overflow detection
// TODO: direct task signaling
// TODO: implement std.Io
// TODO: use @stackUpperBound when implemented
// TODO: support SMP for other esp32 chips with multicore (far future)

const STACK_ALIGN: std.mem.Alignment = .@"16";
const EXTRA_STACK_SIZE = @max(@sizeOf(TrapFrame), 32 * @sizeOf(usize));

pub const TickFrequency = enum(u32) {
    _,

    pub fn from_hz(v: u32) TickFrequency {
        assert(v < 100_000); // frequency too high
        return @enumFromInt(v);
    }

    pub fn from_khz(v: u32) TickFrequency {
        return .from_hz(v * 1_000);
    }

    fn to_us(comptime freq: TickFrequency) u24 {
        return @intFromFloat(1_000_000.0 / @as(f32, @floatFromInt(@intFromEnum(freq))));
    }
};

pub const Options = struct {
    enable: bool = false,

    /// How many bits to be used for priority. Highly recommended to be kept
    /// less than or equal to 5 to benefit from the use of buckets for the
    /// ready task queue.
    priority_bits: u5 = 3,

    tick_interrupt: microzig.cpu.Interrupt = .interrupt31,
    tick_freq: TickFrequency = .from_khz(1),
    systimer_unit: systimer.Unit = .unit0,
    systimer_alarm: systimer.Alarm = .alarm0,
    cpu_interrupt: system.CPU_Interrupt = .cpu_interrupt_0,

    preempt_same_priority_tasks_on_tick: bool = false,

    paint_stack_byte: ?u8 = null,
    /// Disable the use of buckets (one linked list per priority) for the ready
    /// queue. Buckets use a maximum of 260 bytes, but offer a massive speedup.
    /// Buckets are disabled automatically if there are more than 32 priorities
    /// (the priority enum has a tag type bigger than u5).
    ready_queue_force_no_buckets: bool = false,
};

pub const Priority = enum(@Type(.{ .int = .{
    .bits = rtos_options.priority_bits,
    .signedness = .unsigned,
} })) {
    idle = 0,
    lowest = 1,
    _,

    pub const highest: @This() = @enumFromInt(std.math.maxInt(@typeInfo(@This()).@"enum".tag_type));

    pub fn next_higher(prio: Priority) Priority {
        return @enumFromInt(@intFromEnum(prio) +| 1);
    }
};

const ready_queue_use_buckets = !rtos_options.ready_queue_force_no_buckets and @bitSizeOf(@typeInfo(Priority).@"enum".tag_type) <= 5;

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
    sleep_queues: [2]DoublyLinkedList = @splat(.{}),

    current_sleep_queue: *DoublyLinkedList,
    overflow_sleep_queue: *DoublyLinkedList,

    /// The task in .running state. Safe to access outside of critical section
    /// as it is always the same for the currently executing task.
    current_task: *Task,

    current_ticks: u32 = 0,
    overflow_count: u32 = 0,

    just_switched_tasks_cooperatively: bool = false,
};

/// Automatically called inside hal startup sequence if it the rtos is enabled
/// in hal options.
pub fn init() void {
    comptime {
        if (!microzig.options.cpu.interrupt_stack.enable)
            @compileError("rtos requires the interrupt stack cpu option to be enabled");
        microzig.cpu.interrupt.expect_handler(rtos_options.tick_interrupt, tick_interrupt_handler);
    }

    const cs = enter_critical_section();
    defer cs.leave();

    rtos_state = .{
        .current_task = &main_task,
        .current_sleep_queue = &rtos_state.sleep_queues[0],
        .overflow_sleep_queue = &rtos_state.sleep_queues[1],
    };
    if (rtos_options.paint_stack_byte) |paint_byte| {
        @memset(&idle_stack, paint_byte);
    }
    make_ready(&idle_task);

    // unit0 is already enabled as it is used by `hal.time`.
    if (rtos_options.systimer_unit != .unit0) {
        rtos_options.systimer_unit.apply(.enabled);
    }
    rtos_options.systimer_alarm.set_unit(rtos_options.systimer_unit);
    rtos_options.systimer_alarm.set_mode(.period);
    rtos_options.systimer_alarm.set_period(comptime @intCast(systimer.ticks_per_us() * rtos_options.tick_freq.to_us()));
    rtos_options.systimer_alarm.set_interrupt_enabled(true);
    rtos_options.systimer_alarm.set_enabled(true);

    microzig.cpu.interrupt.map(rtos_options.cpu_interrupt.source(), rtos_options.tick_interrupt);
    microzig.cpu.interrupt.map(rtos_options.systimer_alarm.interrupt_source(), rtos_options.tick_interrupt);

    microzig.cpu.interrupt.set_type(rtos_options.tick_interrupt, .level);
    microzig.cpu.interrupt.set_priority(rtos_options.tick_interrupt, .lowest);
    microzig.cpu.interrupt.enable(rtos_options.tick_interrupt);
}

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

    const result_type_info = @typeInfo(@typeInfo(@TypeOf(function)).@"fn".return_type.?);
    switch (result_type_info) {
        .noreturn, .void => {},
        else => @compileError("the return value of an rtos task must be noreturn or void"),
    }

    const TypeErased = struct {
        fn call() callconv(.c) void {
            // interrupts are initially disabled in new tasks
            microzig.cpu.interrupt.enable_interrupts();

            const context_ptr: *const Args =
                @ptrFromInt(args_align.forward(@intFromPtr(rtos_state.current_task) + @sizeOf(Task)));

            @call(.auto, function, context_ptr.*);

            if (result_type_info != .noreturn) {
                yield(.exit);
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

/// Wait for a task to finish and free its memory. The allocator must be the
/// same as the one used for spawning.
pub fn wait_and_free(gpa: std.mem.Allocator, task: *Task) void {
    {
        const cs = enter_critical_section();
        defer cs.leave();
        if (task.state != .exited) {
            task.awaiter = rtos_state.current_task;
            yield(.wait);
        }
    }
    // alloc_size = stack_end - task
    const alloc_size = @intFromPtr(task.stack[task.stack.len..].ptr) - @intFromPtr(task);
    const alloc: []u8 = @as([*]u8, @ptrCast(task))[0..alloc_size];
    gpa.free(alloc);
}

/// Must execute inside a critical section.
pub fn make_ready(task: *Task) linksection(".ram_text") void {
    switch (task.state) {
        .ready, .running, .exited => return,
        .none, .suspended => {},
        .sleep_queue_0 => {
            rtos_state.sleep_queues[0].remove(&task.node);
        },
        .sleep_queue_1 => {
            rtos_state.sleep_queues[1].remove(&task.node);
        },
    }

    task.state = .ready;
    rtos_state.ready_queue.put(task);
}

pub const YieldAction = union(enum) {
    reschedule,
    sleep: Duration,
    wait,
    exit,
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
        .sleep => |sleep_duration| {
            assert(current_task != &idle_task);

            const sleep_ticks = sleep_duration.to_ticks();
            if (sleep_ticks == 0) {
                continue :action .reschedule;
            }

            const expire_ticks, const overflow = @addWithOverflow(rtos_state.current_ticks, sleep_ticks);

            const sleep_queue = if (overflow == 0)
                rtos_state.current_sleep_queue
            else
                rtos_state.overflow_sleep_queue;

            current_task.ticks = expire_ticks;
            current_task.state = if (sleep_queue == &rtos_state.sleep_queues[0])
                .sleep_queue_0
            else
                .sleep_queue_1;

            var it = sleep_queue.first;
            while (it) |node| : (it = node.next) {
                const task: *Task = @alignCast(@fieldParentPtr("node", node));
                if (expire_ticks < task.ticks) {
                    sleep_queue.insert_before(&task.node, &current_task.node);
                    break;
                }
            } else {
                sleep_queue.append(&current_task.node);
            }
        },
        .wait => {
            assert(current_task != &idle_task);
            current_task.state = .suspended;
        },
        .exit => {
            assert(current_task != &idle_task and current_task != &main_task);
            current_task.state = .exited;

            if (current_task.awaiter) |awaiter| {
                make_ready(awaiter);
            }
        },
    }

    const next_task: *Task = rtos_state.ready_queue.pop(.none).?;
    next_task.state = .running;

    rtos_state.current_task = next_task;

    if (rtos_options.preempt_same_priority_tasks_on_tick) {
        // Set flag that we already yielded. Don't preempt to an equal priority
        // task on the next tick.
        rtos_state.just_switched_tasks_cooperatively = true;
    }

    return .{ current_task, next_task };
}

pub fn sleep(duration: Duration) void {
    yield(.{ .sleep = duration });
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

pub fn yield_from_isr() linksection(".ram_text") void {
    rtos_options.cpu_interrupt.set_pending(true);
}

pub fn is_a_higher_priority_task_ready() linksection(".ram_text") bool {
    const cs = enter_critical_section();
    defer cs.leave();

    return @intFromEnum(rtos_state.ready_queue.max_ready_priority() orelse .idle) > @intFromEnum(rtos_state.current_task.priority);
}

pub const tick_interrupt_handler: microzig.cpu.InterruptHandler = .{
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
                \\jal %[tick_handler]
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
                \\li a2, 0x80
                \\csrc mstatus, a2
                \\
                // jump to new task
                \\csrw mepc, a1
                \\mret
                \\
                \\1:
                \\
                \\lw a1, 30*4(sp)
                \\csrw mstatus, a1
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
                : [tick_handler] "i" (&tick_handler),
                  [interrupt_stack_top] "i" (microzig.cpu.interrupt_stack[microzig.cpu.interrupt_stack.len..].ptr),
            );
        }
    }.handler_fn,
};

// Can't be preempted by a higher priority interrupt so already in a "critical
// section".
fn tick_handler(context: *Context) linksection(".ram_vectors") callconv(.c) void {
    const status: microzig.cpu.interrupt.Status = .init();
    if (status.is_set(rtos_options.systimer_alarm.interrupt_source())) {
        rtos_options.systimer_alarm.clear_interrupt();

        rtos_state.current_ticks +%= 1;

        // if overflow
        if (rtos_state.current_ticks == 0) {
            @branchHint(.unlikely);

            assert(rtos_state.current_sleep_queue.first == null); // the current sleep queue should be empty on an overflow
            rtos_state.overflow_count += 1;
            std.mem.swap(*DoublyLinkedList, &rtos_state.current_sleep_queue, &rtos_state.overflow_sleep_queue);
        }

        while (rtos_state.current_sleep_queue.first) |node| {
            const task: *Task = @alignCast(@fieldParentPtr("node", node));
            if (task.ticks > rtos_state.current_ticks) {
                break;
            }
            _ = rtos_state.current_sleep_queue.pop_first().?;
            task.state = .ready;
            rtos_state.ready_queue.put(task);
        }
    }

    if (status.is_set(rtos_options.cpu_interrupt.source())) {
        rtos_options.cpu_interrupt.set_pending(false);
    }

    const current_task = rtos_state.current_task;

    // if there is a higher priority task ready switch to it
    // if preempt if there is an equal priority task switch to it
    const ready_task_constraint: ReadyTaskConstraint =
        if (rtos_options.preempt_same_priority_tasks_on_tick and !rtos_state.just_switched_tasks_cooperatively) blk: {
            break :blk .{ .at_least_prio = current_task.priority };
        } else .{ .more_than_prio = current_task.priority };

    if (rtos_options.preempt_same_priority_tasks_on_tick) {
        rtos_state.just_switched_tasks_cooperatively = false;
    }

    const ready_task = rtos_state.ready_queue.pop(ready_task_constraint) orelse return;

    // swap contexts
    current_task.context = context.*;
    context.* = ready_task.context;

    current_task.state = .ready;
    rtos_state.ready_queue.put(current_task);

    ready_task.state = .running;
    rtos_state.current_task = ready_task;
}

pub fn log_task_info(task: *Task) void {
    const cs = enter_critical_section();
    defer cs.leave();

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
    node: LinkedListNode = .{},

    /// Ticks for when the task will wake.
    ticks: u32 = 0,

    /// Another task waiting for this task to exit.
    awaiter: ?*Task = null,

    /// Task specific semaphore (required by the wifi driver)
    semaphore: Semaphore = .init(0, 1),

    pub const State = enum {
        none,
        ready,
        running,
        sleep_queue_0,
        sleep_queue_1,
        suspended,
        exited,
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

pub const ReadyTaskConstraint = union(enum) {
    none,
    at_least_prio: Priority,
    more_than_prio: Priority,
};

pub const ReadyPriorityQueue = if (ready_queue_use_buckets) struct {
    const ReadySet = std.EnumSet(Priority);

    ready: ReadySet = .initEmpty(),
    lists: std.EnumArray(Priority, LinkedList(.{
        .use_last = true,
        .use_prev = false,
    })) = .initFill(.{}),

    pub fn max_ready_priority(pq: *ReadyPriorityQueue) ?Priority {
        const raw_prio = pq.ready.bits.findLastSet() orelse return null;
        return ReadySet.Indexer.keyForIndex(raw_prio);
    }

    pub fn pop(pq: *ReadyPriorityQueue, constraint: ReadyTaskConstraint) ?*Task {
        const prio = pq.max_ready_priority() orelse return null;
        switch (constraint) {
            .none => {},
            inline else => |constraint_priority, tag| {
                if ((tag == .at_least_prio and @intFromEnum(prio) < @intFromEnum(constraint_priority)) or
                    (tag == .more_than_prio and @intFromEnum(prio) <= @intFromEnum(constraint_priority)))
                {
                    return null;
                }
            },
        }

        const bucket = pq.lists.getPtr(prio);

        // We know there is at least one task ready.
        const task: *Task = @alignCast(@fieldParentPtr("node", bucket.pop_first().?));

        // If there aren't any more tasks inside the current bucket, unset the
        // ready bit.
        if (bucket.first == null) {
            pq.ready.remove(prio);
        }

        return task;
    }

    pub fn put(pq: *ReadyPriorityQueue, new_task: *Task) void {
        pq.lists.getPtr(new_task.priority).append(&new_task.node);
        pq.ready.setPresent(new_task.priority, true);
    }
} else struct {
    inner: DoublyLinkedList = .{},

    fn peek_top(pq: *ReadyPriorityQueue) ?*Task {
        if (pq.inner.first) |first_node| {
            return @alignCast(@fieldParentPtr("node", first_node));
        } else {
            return null;
        }
    }

    pub fn max_ready_priority(pq: *ReadyPriorityQueue) ?Priority {
        return if (pq.peek_top()) |task|
            task.priority
        else
            null;
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
                pq.inner.insert_before(node, &new_task.node);
                break;
            }
        } else {
            pq.inner.append(&new_task.node);
        }
    }
};

pub const Duration = enum(u32) {
    _,

    pub const us_per_tick = rtos_options.tick_freq.to_us();
    pub const ms_per_tick = @max(1, us_per_tick / 1_000);

    pub fn from_us(v: u32) Duration {
        return @enumFromInt(v / us_per_tick);
    }

    pub fn from_ms(v: u32) Duration {
        return @enumFromInt(v / ms_per_tick);
    }

    pub fn from_ticks(v: u32) Duration {
        return @enumFromInt(v);
    }

    pub fn to_ticks(duration: Duration) u32 {
        return @intFromEnum(duration);
    }
};

/// Must be used only from a critical section.
pub const Timeout = struct {
    end_ticks: u64,

    pub fn after(duration: Duration) Timeout {
        const current_ticks = (@as(u64, rtos_state.overflow_count) << 32) | rtos_state.current_ticks;
        return .{
            .end_ticks = current_ticks + duration.to_ticks(),
        };
    }

    pub fn get_remaining_sleep_duration(timeout: Timeout) ?Duration {
        const current_ticks = (@as(u64, rtos_state.overflow_count) << 32) | rtos_state.current_ticks;
        const remaining = timeout.end_ticks -| current_ticks;
        if (remaining == 0) return null;
        return .from_ticks(@truncate(remaining));
    }
};

pub const TimeoutError = error{Timeout};

pub const PriorityWaitQueue = struct {
    list: DoublyLinkedList = .{},

    pub const Waiter = struct {
        task: *Task,
        priority: Priority,
        node: LinkedListNode = .{},
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
        while (q.list.pop_first()) |current_node| {
            const current_waiter: *Waiter = @alignCast(@fieldParentPtr("node", current_node));
            make_ready(current_waiter.task);
        }
    }

    /// Must execute inside a critical section.
    pub fn wait(q: *PriorityWaitQueue, task: *Task, maybe_timeout_duration: ?Duration) void {
        var waiter: Waiter = .{
            .task = task,
            .priority = task.priority,
        };

        var it = q.list.first;
        while (it) |current_node| : (it = current_node.next) {
            const current_waiter: *Waiter = @alignCast(@fieldParentPtr("node", current_node));
            if (@intFromEnum(waiter.priority) > @intFromEnum(current_waiter.priority)) {
                q.list.insert_before(&current_waiter.node, &waiter.node);
                break;
            }
        } else {
            q.list.append(&waiter.node);
        }

        if (maybe_timeout_duration) |duration| {
            yield(.{ .sleep = duration });
        } else {
            yield(.wait);
        }

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

    pub fn lock_with_timeout(mutex: *Mutex, maybe_timeout_after: ?Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const current_task = get_current_task();

        const maybe_timeout: ?Timeout = if (maybe_timeout_after) |duration|
            .after(duration)
        else
            null;

        assert(mutex.locked != current_task);

        while (mutex.locked) |owning_task| {
            const maybe_remaining_duration = if (maybe_timeout) |timeout|
                timeout.get_remaining_sleep_duration() orelse return error.Timeout
            else
                null;

            // Owning task inherits the priority of the current task if it the
            // current task has a bigger priority.
            if (@intFromEnum(current_task.priority) > @intFromEnum(owning_task.priority)) {
                if (mutex.prev_priority == null)
                    mutex.prev_priority = owning_task.priority;
                owning_task.priority = current_task.priority;
                make_ready(owning_task);
            }

            mutex.wait_queue.wait(current_task, maybe_remaining_duration);
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

    pub fn take_with_timeout(sem: *Semaphore, maybe_timeout_after: ?Duration) TimeoutError!void {
        const cs = enter_critical_section();
        defer cs.leave();

        const maybe_timeout: ?Timeout = if (maybe_timeout_after) |duration|
            .after(duration)
        else
            null;

        while (sem.current_value <= 0) {
            const maybe_remaining_duration = if (maybe_timeout) |timeout|
                timeout.get_remaining_sleep_duration() orelse return error.Timeout
            else
                null;
            sem.wait_queue.wait(rtos_state.current_task, maybe_remaining_duration);
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
        maybe_timeout_after: ?Duration,
    ) usize {
        assert(elements.len >= min);
        if (elements.len == 0) return 0;

        const maybe_timeout: ?Timeout = if (maybe_timeout_after) |duration|
            .after(duration)
        else
            null;

        var n: usize = 0;

        const cs = enter_critical_section();
        defer cs.leave();

        while (true) {
            n += q.put_non_blocking_from_cs(elements[n..]);
            if (n >= min) return n;

            const maybe_remaining_duration = if (maybe_timeout) |timeout|
                timeout.get_remaining_sleep_duration() orelse return n
            else
                null;
            q.putters.wait(rtos_state.current_task, maybe_remaining_duration);
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
        maybe_timeout_after: ?Duration,
    ) usize {
        assert(buffer.len >= min);
        if (buffer.len == 0) return 0;

        const maybe_timeout: ?Timeout = if (maybe_timeout_after) |duration|
            .after(duration)
        else
            null;

        var n: usize = 0;

        const cs = enter_critical_section();
        defer cs.leave();

        while (true) {
            n += q.get_non_blocking_from_cs(buffer[n..]);
            if (n >= min) return n;

            const maybe_remaining_duration = if (maybe_timeout) |timeout|
                timeout.get_remaining_sleep_duration() orelse return n
            else
                null;
            q.getters.wait(rtos_state.current_task, maybe_remaining_duration);
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

        pub fn put(q: *Self, elements: []const Elem, min: usize, timeout: ?Duration) usize {
            return @divExact(q.type_erased.put(@ptrCast(elements), min * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn put_all(q: *Self, elements: []const Elem, timeout: ?Duration) TimeoutError!void {
            if (q.put(elements, elements.len, timeout) != elements.len)
                return error.Timeout;
        }

        pub fn put_one(q: *Self, item: Elem, timeout: ?Duration) TimeoutError!void {
            if (q.put(&.{item}, 1, timeout) != 1)
                return error.Timeout;
        }

        pub fn put_non_blocking(q: *Self, elements: []const Elem) usize {
            return @divExact(q.type_erased.put_non_blocking(@ptrCast(elements)), @sizeOf(Elem));
        }

        pub fn put_one_non_blocking(q: *Self, item: Elem) bool {
            return q.put_non_blocking(@ptrCast(&item)) == 1;
        }

        pub fn get(q: *Self, buffer: []Elem, target: usize, timeout: ?Duration) usize {
            return @divExact(q.type_erased.get(@ptrCast(buffer), target * @sizeOf(Elem), timeout), @sizeOf(Elem));
        }

        pub fn get_one(q: *Self, timeout: ?Duration) TimeoutError!Elem {
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

pub const LinkedListNode = struct {
    prev: ?*LinkedListNode = null,
    next: ?*LinkedListNode = null,
};

pub const DoublyLinkedList = LinkedList(.{
    .use_last = true,
    .use_prev = true,
});

pub const LinkedListCapabilities = struct {
    use_last: bool = true,
    use_prev: bool = true,
};

pub fn LinkedList(comptime caps: LinkedListCapabilities) type {
    return struct {
        const Self = @This();

        first: ?*LinkedListNode = null,
        last: if (caps.use_last) ?*LinkedListNode else noreturn = null,

        pub const append = if (caps.use_last) struct {
            fn append(ll: *Self, node: *LinkedListNode) void {
                if (caps.use_prev) node.prev = ll.last;
                node.next = null;
                if (ll.last) |last| {
                    last.next = node;
                    ll.last = node;
                } else {
                    ll.first = node;
                    ll.last = node;
                }
            }
        }.append else @compileError("linked list does not support append");

        pub fn prepend(ll: *Self, node: *LinkedListNode) void {
            if (caps.use_prev) {
                node.prev = null;
                if (ll.first) |first| {
                    first.prev = node;
                }
            }
            node.next = ll.first;
            if (caps.use_last and ll.first == null) {
                ll.last = node;
            }
            ll.first = node;
        }

        pub fn pop_first(ll: *Self) ?*LinkedListNode {
            if (ll.first) |first| {
                ll.first = first.next;
                if (caps.use_last) {
                    if (ll.last == first) {
                        ll.last = null;
                    }
                }
                if (caps.use_prev) {
                    if (ll.first) |new_first| {
                        new_first.prev = null;
                    }
                }
                return first;
            } else return null;
        }

        pub const insert_before = if (caps.use_prev) struct {
            pub fn insert_before(ll: *Self, existing_node: *LinkedListNode, new_node: *LinkedListNode) void {
                new_node.next = existing_node;
                if (existing_node.prev) |prev_node| {
                    // Intermediate node.
                    new_node.prev = prev_node;
                    prev_node.next = new_node;
                } else {
                    // First element of the list.
                    new_node.prev = null;
                    ll.first = new_node;
                }
                existing_node.prev = new_node;
            }
        }.insert_before else @compileError("linked list does not support insert_before");

        pub const remove = if (caps.use_prev) struct {
            pub fn remove(ll: *Self, node: *LinkedListNode) void {
                if (node.prev) |prev_node| {
                    // Intermediate node.
                    prev_node.next = node.next;
                } else {
                    // First element of the list.
                    ll.first = node.next;
                }

                if (node.next) |next_node| {
                    // Intermediate node.
                    next_node.prev = node.prev;
                } else {
                    // Last element of the list.
                    if (caps.use_last) ll.last = node.prev;
                }
            }
        }.remove else @compileError("linked list does not support remove");
    };
}

test "LinkedList.with_last" {
    const expect = std.testing.expect;
    const TestNode = struct {
        data: i32,
        node: LinkedListNode = .{},
    };

    var list: LinkedList(.{
        .use_prev = false,
        .use_last = true,
    }) = .{};

    var n1: TestNode = .{ .data = 1 };
    var n2: TestNode = .{ .data = 2 };
    var n3: TestNode = .{ .data = 3 };

    // 1. Test Append on empty
    list.append(&n1.node);

    // State: [1]
    try expect(list.first == &n1.node);
    try expect(list.last == &n1.node);
    try expect(n1.node.next == null);

    // 2. Test Append on existing
    list.append(&n2.node);

    // State: [1, 2]
    try expect(list.first == &n1.node);
    try expect(list.last == &n2.node);
    try expect(n1.node.next == &n2.node);
    try expect(n2.node.next == null);

    // 3. Test Prepend
    list.prepend(&n3.node);

    // State: [3, 1, 2]
    try expect(list.first == &n3.node);
    try expect(list.last == &n2.node);
    try expect(n3.node.next == &n1.node);

    // 4. Test Pop (FIFO if we pop from head)
    const p1 = list.pop_first();

    // State: [1, 2]
    try expect(p1 == &n3.node);
    try expect(list.first == &n1.node);

    if (p1) |node_ptr| {
        const parent: *TestNode = @fieldParentPtr("node", node_ptr);
        try expect(parent.data == 3);
    }

    const p2 = list.pop_first();
    // State: [2]
    try expect(p2 == &n1.node);
    try expect(list.first == &n2.node);
    try expect(list.last == &n2.node);

    const p3 = list.pop_first();
    // State: []
    try expect(p3 == &n2.node);
    try expect(list.first == null);
    try expect(list.last == null);

    // 5. Test Pop on empty
    try expect(list.pop_first() == null);
}

test "LinkedList.doubly_linked" {
    const expect = std.testing.expect;
    const TestNode = struct {
        data: i32,
        node: LinkedListNode = .{},
    };

    var list: LinkedList(.{
        .use_prev = true,
        .use_last = true,
    }) = .{};

    var n1: TestNode = .{ .data = 10 };
    var n2: TestNode = .{ .data = 20 };
    var n3: TestNode = .{ .data = 30 };
    var n4: TestNode = .{ .data = 40 };

    // 1. Build List
    list.append(&n1.node);
    list.append(&n2.node);
    list.append(&n3.node);

    // State: [10, 20, 30]
    try expect(list.first == &n1.node);
    try expect(list.last == &n3.node);
    try expect(n1.node.next == &n2.node);
    try expect(n2.node.prev == &n1.node); // Backward link check

    // 2. Remove Middle Node
    list.remove(&n2.node);

    // State: [10, 30]
    try expect(n1.node.next == &n3.node); // 10 -> 30
    try expect(n3.node.prev == &n1.node); // 30 <- 10
    try expect(list.first == &n1.node);
    try expect(list.last == &n3.node);

    // 3. Insert Before Head
    list.insert_before(&n1.node, &n4.node);

    // State: [40, 10, 30]
    try expect(list.first == &n4.node);
    try expect(n4.node.next == &n1.node); // 40 -> 10
    try expect(n1.node.prev == &n4.node); // 10 <- 40

    // 4. Remove Tail
    list.remove(&n3.node);

    // State: [40, 10]
    try expect(list.last == &n1.node);
    try expect(n1.node.next == null);
    try expect(list.first == &n4.node);

    const n4_popped = list.pop_first().?;
    try expect(n1.node.prev == null);
    try expect(n1.node.next == null);
    try expect(list.first == &n1.node);
    try expect(list.last == &n1.node);

    list.insert_before(&n1.node, n4_popped);

    try expect(list.first == &n4.node);

    // 5. Check Parent Pointer
    if (list.first) |node_ptr| {
        const head_struct: *TestNode = @fieldParentPtr("node", node_ptr);
        try expect(head_struct.data == 40);
    }
}
