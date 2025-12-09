const std = @import("std");
const Allocator = std.mem.Allocator;

const microzig = @import("microzig");
const TrapFrame = microzig.cpu.TrapFrame;
const SYSTEM = microzig.chip.peripherals.SYSTEM;

const Scheduler = @This();

// TODO: Custom wrapper handlers for interrupts that switch to an interrupt
// stack

allocator: std.mem.Allocator = undefined,
ready_queue: ?*Task = null,
main_task: Task = undefined,
/// SAFETY: we don't need optionals because there will always be the main task
/// running. It can't be deleted.
current_task: *Task = undefined,

pub const Task = struct {
    // NOTE: I believe this ensures an alignment for the struct, useful because
    // some bits for instance in the mutex state are mark whether it is locked
    // or unlocked
    _: void align(4) = {},
    context: Context,
    async_closure: AsyncClosure,
    stack: []u8,
    queue_next: ?*Task = null,

    pub fn init(function: *const fn (param: ?*anyopaque) callconv(.c) void, param: ?*anyopaque, stack: []u8) Task {
        return .{
            .context = .{
                .sp = stack.ptr[stack.len..],
                .pc = AsyncClosure.call,
            },
            .stack = stack,
            .async_closure = .{
                .entry = function,
                .param = param,
            },
        };
    }
};

pub fn init(scheduler: *Scheduler, allocator: Allocator) void {
    scheduler.allocator = allocator;
    scheduler.main_task = .{
        .context = undefined,
        .async_closure = undefined,
        .stack = &.{},
    };
    scheduler.current_task = &scheduler.main_task;
}

// TODO: implement ziggy spawn

pub const SpawnOptions = struct {
    stack_size: usize = 4096,
};

pub fn raw_alloc_spawn_with_options(
    scheduler: *Scheduler,
    function: *const fn (param: ?*anyopaque) callconv(.c) void,
    param: ?*anyopaque,
    options: SpawnOptions,
) !void {
    // TODO: maybe find a way to only do one allocation. This is a bit tricky
    // because we want to also support statically allocated tasks, maybe based
    // on the not yet available @stackSize builtin

    const STACK_ALIGN: std.mem.Alignment = .@"16";
    const stack_size = std.mem.alignForward(usize, options.stack_size, STACK_ALIGN.toByteUnits());
    const stack = try scheduler.allocator.alignedAlloc(u8, STACK_ALIGN, stack_size);
    errdefer scheduler.allocator.free(stack);

    const task = try scheduler.allocator.create(Task);
    errdefer scheduler.allocator.destroy(task);

    task.* = .init(function, param, stack);
    scheduler.schedule(task);
}

pub fn schedule(scheduler: *Scheduler, task: *Task) void {
    const first_task = scheduler.ready_queue;

}

const AsyncClosure = extern struct {
    entry: *const fn (param: ?*anyopaque) callconv(.c) void,
    param: ?*anyopaque,

    pub fn call(contexts: *const @FieldType(SwitchMessage, "contexts")) callconv(.c) noreturn {
        const message: *const SwitchMessage = @fieldParentPtr("contexts", contexts);
        message.handle();

        const task: *Task = @fieldParentPtr("context", contexts.next);
        task.async_closure.entry(task.async_closure.param);
        while (true) message.scheduler.yield_with_action(.exit);
    }
};

pub fn yield(scheduler: *Scheduler, options: struct {
    task: ?*Task = null,
    action: SwitchMessage.Action = .nothing,
}) void {
    const cs = microzig.interrupt.enter_critical_section();

    const node = options.task orelse scheduler.find_ready_task() orelse {
        cs.leave();
        // TODO: maybe switch to idle task if not called in isr
        return;
    };
    const next_task: *Task = @fieldParentPtr("node", node);

    const message: SwitchMessage = .{
        .scheduler = scheduler,
        .contexts = .{
            .prev = &scheduler.current_task.context,
            .next = &next_task.context,
        },
        .action = options.action,
        .cs = cs,
    };
    context_switch(&message).handle();
}

pub fn mutex_lock(scheduler: *Scheduler, prev_state: Mutex.State, mutex: *Mutex) void {
    scheduler.yield(.{ .action = .{ .mutex_lock = .{
        .prev_state = prev_state,
        .mutex = mutex,
    } } });
}

pub fn mutex_unlock(scheduler: *Scheduler, _: Mutex.State, mutex: *Mutex) void {
    // NOTE: only gets called if mutex is contented, very simplified
    // implementation because single core (esp32c3 only for now)

    const waiting_task = blk: {
        const cs = microzig.interrupt.enter_critical_section();
        defer cs.leave();

        const waiting_task: *Task = @ptrFromInt(@intFromEnum(mutex.state));
        mutex.state = @enumFromInt(@intFromPtr(waiting_task.queue_next));
        break :blk waiting_task;
    };

    scheduler.yield(.{
        .action = .nothing,
        .task = waiting_task,
    });
}

pub const SwitchMessage = struct {
    scheduler: *Scheduler,
    contexts: extern struct {
        prev: *Context,
        next: *Context,
    },
    action: Action,
    cs: microzig.interrupt.CriticalSection,

    pub const Action = union(enum) {
        nothing,
        mutex_lock: struct {
            prev_state: Mutex.State,
            mutex: *Mutex,
        },
        exit,
    };

    pub fn handle(message: *const SwitchMessage) void {
        defer message.cs.leave();

        const scheduler = message.scheduler;
        const prev_task: *Task = @fieldParentPtr("context", message.contexts.prev);
        const next_task: *Task = @fieldParentPtr("context", message.contexts.next);

        scheduler.current_task = next_task;

        switch (message.action) {
            .nothing => {
                scheduler.schedule(prev_task);
            },
            .mutex_lock => |state| {
                if (state.prev_state == .unlocked) {
                    state.mutex.state = .locked_once;
                    prev_task.queue_next = null;
                    scheduler.schedule(prev_task);
                } else {
                    const maybe_first_awaiter: ?*Task = @ptrFromInt(@intFromEnum(state.mutex.state));
                    if (maybe_first_awaiter) |first_awaiter| {
                        var last_awaiter = first_awaiter;
                        while (true) last_awaiter = last_awaiter.queue_next orelse break;
                        last_awaiter.queue_next = prev_task;
                    } else {
                        state.mutex.state = @enumFromInt(@intFromPtr(prev_task));
                    }
                }
            },
            .exit => {
                scheduler.allocator.free(prev_task.stack);
                scheduler.allocator.destroy(prev_task);
            },
        }
    }
};

fn find_ready_task(scheduler: *Scheduler) ?*Task {
    if (scheduler.ready_queue) |next_task| {
        scheduler.ready_queue = next_task.queue_next;
        return next_task;
    }
    return null;
}

pub const Context = extern struct {
    pc: ?*const anyopaque,
    sp: ?*anyopaque,
};

inline fn context_switch(message: *const SwitchMessage) *const SwitchMessage {
    return @fieldParentPtr("contexts", asm volatile (
        \\lw t0, 0(a0)    # prev context
        \\lw t1, 4(a0)    # next context
        \\
        \\la t2, ret
        \\sw t2, 0(t0)    # save return pc
        \\
        \\sw sp, 4(t0)    # save prev stack pointer
        \\
        \\lw t2, 0(t1)    # load next pc
        \\lw sp, 4(t1)    # load next stack pointer
        \\jr t2           # jump to next task
        \\ret:
        \\
        : [received_message] "={a0}" (-> *const @FieldType(SwitchMessage, "contexts")),
        : [message_to_send] "{a0}" (&message.contexts),
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
        }));
}

pub const Mutex = struct {
    state: State,

    pub const State = enum(usize) {
        locked_once = 0b00,
        unlocked = 0b01,
        contended = 0b10,
        /// contended
        _,

        pub fn isUnlocked(state: State) bool {
            return @intFromEnum(state) & @intFromEnum(State.unlocked) == @intFromEnum(State.unlocked);
        }
    };

    pub const init: Mutex = .{ .state = .unlocked };

    pub fn tryLock(mutex: *Mutex) bool {
        const prev_state: State = @enumFromInt(@atomicRmw(
            usize,
            @as(*usize, @ptrCast(&mutex.state)),
            .And,
            ~@intFromEnum(State.unlocked),
            .acquire,
        ));
        return prev_state.isUnlocked();
    }

    pub fn lock(mutex: *Mutex, scheduler: *Scheduler) void {
        const prev_state: State = @enumFromInt(@atomicRmw(
            usize,
            @as(*usize, @ptrCast(&mutex.state)),
            .And,
            ~@intFromEnum(State.unlocked),
            .acquire,
        ));
        if (prev_state.isUnlocked()) {
            @branchHint(.likely);
            return;
        }
        scheduler.mutex_lock(prev_state, mutex);
    }

    pub fn unlock(mutex: *Mutex, scheduler: *Scheduler) void {
        const prev_state = @cmpxchgWeak(State, &mutex.state, .locked_once, .unlocked, .release, .acquire) orelse {
            @branchHint(.likely);
            return;
        };
        std.debug.assert(prev_state != .unlocked);
        return scheduler.mutex_unlock(prev_state, mutex);
    }
};

pub const Condition = struct {
    state: u64 = 0,

    pub fn wait(cond: *Condition, scheduler: *Scheduler, mutex: *Mutex) void {
        return scheduler.condition_wait(cond, mutex);
    }

    pub fn signal(cond: *Condition, scheduler: *Scheduler) void {
        scheduler.condition_wake(cond, .one);
    }

    pub fn broadcast(cond: *Condition, scheduler: *Scheduler) void {
        scheduler.condition_wake(cond, .all);
    }

    pub const Wake = enum {
        /// Wake up only one thread.
        one,
        /// Wake up all threads.
        all,
    };
};
