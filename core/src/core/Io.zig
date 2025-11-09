const builtin = @import("builtin");
const std = @import("std");
const drivers = @import("drivers");
const assert = std.debug.assert;
const time = drivers.time;

/// Unsigned integer with the same alignment as the stack.
const StackUint = usize;

/// Up direction completely untested.
const stack_growth_direction: enum { up, down } = .down;

/// Convert size of struct or union into how many byte multiples
/// of stack alignment are needed to store it on the stack.
fn to_stack_units(size: usize) usize {
    return std.math.divCeil(
        usize,
        size,
        @sizeOf(StackUint),
    ) catch unreachable;
}

/// Information about when a task should be resumed.
/// This could me made into an interface.
/// Upside: Much easier to move more functionality into core.
/// Downside: Performance (may be mitigated once https://github.com/ziglang/zig/issues/23367 is implemeted).
pub const PauseReason = union(enum) {
    const OnStack = [to_stack_units(@sizeOf(@This()))]StackUint;

    /// Task volutarily gave up execution, but is ready to continue.
    yield,
    sleep_until: time.Absolute align(@alignOf(StackUint)),
    bits_mask_any_high: struct { ptr: *const usize, mask: usize },
    /// This value means there is no context stored on this stack
    /// so it can be used to launch a new task.
    no_task,

    comptime {
        assert(@alignOf(@This()) <= @alignOf(StackUint));
    }

    /// Check if the task should be resumed.
    /// The io interface may not be necessary.
    pub fn can_resume(this: *const @This(), io: anytype) bool {
        return switch (this.*) {
            .no_task => false,
            .yield => true,
            .bits_mask_any_high => |info| {
                return @atomicLoad(usize, info.ptr, .acquire) & info.mask != 0;
            },
            .sleep_until => |t| t.is_reached_by(io.monotonic_clock()),
        };
    }

    // Returns the context of this task, assuming that the pause reason
    // is stored just beyond the end of the stack.
    pub fn context(this: *@This()) ?*Context {
        if (this.* == .no_task) return null;

        const on_stack: *OnStack = @ptrCast(this);
        const both: *ContextAndReason = @fieldParentPtr("reason", on_stack);
        return &both.context;
    }
};

/// All the state preserved between function calls.
/// This assumes cooperative multitasking. Preemtion would need to save more data,
/// but may not be needed thanks to interrupts (see https://github.com/rtic-rs/rtic).
/// The order of registers is arbitrary, this order makes the assembly more compact.
pub const ContextArm = extern struct {
    r8: u32,
    r9: u32,
    r10: u32,
    r11: u32,
    r12: u32,
    r4: u32,
    r5: u32,
    r6: u32,
    r7: u32,
    pc: u32,

    comptime {
        assert(@alignOf(@This()) <= @alignOf(StackUint));
    }

    /// Return value of context switch. After exiting save_and_switch_raw the pause
    /// reason needs to be saved to the stack (this was troublesome to do in assembly).
    const SaveResult = packed struct {
        previous_reason: *PauseReason,
        previous_pause_reason: *const PauseReason,
    };

    /// Switches context to `switch_to` and then stores `reason` just beyond the stack.
    /// The address at which `reason` was stored is saved to `save_to`.
    /// By doing it this way we can store all information that a scheduler needs on top of the task stack.
    /// This may be made generic so that other schedulers can save any data.
    pub fn save_and_switch(save_to: **PauseReason, switch_to: *@This(), reason: *const PauseReason) void {
        const raw: *const fn (
            **PauseReason,
            *const PauseReason,
            *@This(),
        ) callconv(.c) SaveResult =
            @ptrCast(&save_and_switch_raw);

        const ret = raw(save_to, reason, switch_to);
        ret.previous_reason.* = ret.previous_pause_reason.*;
    }

    /// Prepares the saved context registers to launch a new task.
    /// In this implementation, the same mechanism as in a context switch is used.
    /// The context switch assembly 'just so happens' to temporarily store some of the
    /// context in registers used for argument passing (arguments 3 and 4).
    /// Arguments 1 and 2 correspond to the return value, so they contain
    /// what would be the return value of `save_and_switch`.
    pub fn init_launch(this: *@This(), F: type, func: *const F, args: *const std.meta.ArgsTuple(F)) void {
        const LaunchTask = struct {
            // ABI arguments 1 and 2 are used for the two structure fields.
            fn launch_task(ret: SaveResult, f: *const F, a: @TypeOf(args)) callconv(.c) void {
                ret.previous_reason.* = ret.previous_pause_reason.*;

                _ = @call(.auto, f, a.*);

                // TODO: futures and return values
                std.debug.panic("task returned", .{});
            }
        };

        this.pc = @intFromPtr(&LaunchTask.launch_task);
        // r8 corresponds to argument 3, r9 to arg 4.
        this.r8 = @intFromPtr(func);
        this.r9 = @intFromPtr(args);
    }

    /// Piece of assembly used for context switch.
    fn save_and_switch_raw() callconv(.naked) void {
        asm volatile (
        // save registers
            \\push {r4,r5,r6,r7,lr}
            \\mov r4, r8
            \\mov r5, r9
            \\mov r6, r10
            \\mov r7, r11
            \\mov lr, r12
            \\push {r4,r5,r6,r7,lr}
            // switch sp
            \\mov r4, sp
            \\subs r4, r4, #12
            \\str r4, [r0]
            \\mov sp, r2
            \\mov r0, r4
            // load registers
            \\pop {r2,r3,r4,r5,r6}
            \\mov r8, r2
            \\mov r9, r3
            \\mov r10, r4
            \\mov r11, r5
            \\mov r12, r6
            \\pop {r4,r5,r6,r7,pc}
            ::: .{ .memory = true });
    }
};

// TODO
pub const ContextRV32 = struct {
    pub fn save_and_switch(save_to: **PauseReason, switch_to: *@This(), reason: *const PauseReason) void {
        _ = save_to;
        _ = switch_to;
        _ = reason;
        std.debug.panic("Unimplemented", .{});
    }

    pub fn init_launch(this: *@This(), F: type, func: *const F, args: *const std.meta.ArgsTuple(F)) void {
        _ = this;
        _ = func;
        _ = args;
        std.debug.panic("Unimplemented", .{});
    }
};

/// Context type of the current target.
pub const Context = switch (builtin.target.cpu.arch) {
    .thumb => switch (builtin.target.abi) {
        .eabi, .eabihf => ContextArm,
        // TODO: also save fpu registers
        // .eabihf => ContextThumbFloat
        else => |abi| @compileError("Unsupported abi: " ++ @tagName(abi)),
    },
    .riscv32 => switch (builtin.target.abi) {
        .eabi => ContextRV32,
        else => |abi| @compileError("Unsupported abi: " ++ @tagName(abi)),
    },
    else => |arch| @compileError("Unsupported architecture: " ++ @tagName(arch)),
};

/// The order in which those elemts appear on the stack.
const ContextAndReason = switch (stack_growth_direction) {
    .up => extern struct { context: Context, reason: PauseReason.OnStack },
    .down => extern struct { reason: PauseReason.OnStack, context: Context },
};

const EmptyStackLayout = switch (stack_growth_direction) {
    .up => extern struct {
        len: usize,
        reason: PauseReason.OnStack,
    },
    .down => extern struct {
        reason: PauseReason.OnStack,
        len: usize,
    },
};

/// Mark stack as empty and ready to launch a task.
pub fn prepare_empty_stack(stack: []StackUint) *PauseReason {
    const layout_len = @divExact(@sizeOf(EmptyStackLayout), @sizeOf(StackUint));
    const layout: *EmptyStackLayout = switch (stack_growth_direction) {
        .up => @ptrCast(stack.ptr),
        .down => @ptrCast(stack.ptr + stack.len - layout_len),
    };

    const reason: *PauseReason = @ptrCast(&layout.reason);
    layout.len = stack.len;
    reason.* = .no_task;
    return reason;
}

/// Prepare the stack for launching a new task.
pub fn prepare_task_stack(comptime F: type, f: *const F, stack: *PauseReason) struct {
    reason: *PauseReason,
    args: *std.meta.ArgsTuple(F),
} {
    if (stack.context() != null)
        std.debug.panic("Stack needs to be empty!", .{});

    const on_stack: *PauseReason.OnStack = @ptrCast(stack);
    const empty_addr: *EmptyStackLayout = @fieldParentPtr("reason", on_stack);

    const Args = std.meta.ArgsTuple(F);
    const Result = @typeInfo(F).@"fn".return_type.?;
    const size_result = if (Result == noreturn) 0 else @sizeOf(Result);
    const ArgsResultUnion = [to_stack_units(@max(@sizeOf(Args), size_result))]StackUint;

    const Layout = switch (stack_growth_direction) {
        .up => extern struct {
            len: usize,
            args_ret: ArgsResultUnion,
            cr: ContextAndReason,
        },
        .down => extern struct {
            cr: ContextAndReason,
            args_ret: ArgsResultUnion,
            len: usize,
        },
    };

    // stack length is in the same place for both layouts.
    const layout: *Layout = @fieldParentPtr("len", &empty_addr.len);
    layout.cr.context.init_launch(F, f, @as(*const Args, @ptrCast(&layout.args_ret)));

    return .{
        .reason = @ptrCast(&layout.cr.reason),
        .args = @ptrCast(&layout.args_ret),
    };
}

/// Simple round-robin scheduler.
pub const RoundRobin = struct {
    next_swap: usize,
    tasks: []*PauseReason,
    vtable: VTable,

    /// Pause the current task allow others to run.
    pub fn pause(this: *@This(), reason: *const PauseReason) void {
        const i = blk: while (true) {
            const next_swap = @min(this.next_swap, this.tasks.len);
            for (next_swap..this.tasks.len) |i| {
                if (this.tasks[i].can_resume(this)) break :blk i;
            }
            for (0..next_swap) |i| {
                if (this.tasks[i].can_resume(this)) break :blk i;
            }
            if (reason.can_resume(this)) return;
        };
        this.next_swap = i + 1;
        Context.save_and_switch(&this.tasks[i], this.tasks[i].context().?, reason);
    }

    /// Add a task.
    pub fn async(this: *@This(), comptime func: anytype, args: std.meta.ArgsTuple(@TypeOf(func))) void {
        for (this.tasks) |*task|
            if (task.*.context() == null) {
                const ptrs = prepare_task_stack(@TypeOf(func), &func, task.*);

                ptrs.reason.* = .yield;
                ptrs.args.* = args;
                task.* = ptrs.reason;

                return; // TODO: return future
            };
        // Maybe we could wait for them to complete instead?
        std.debug.panic("Cannot launch more tasks.", .{});
    }

    pub fn monotonic_clock(this: *@This()) time.Absolute {
        return this.vtable.monotonic_clock();
    }
};

/// Common functionality between all implementations.
/// Needs to be specified by every port.
pub const VTable = struct {
    /// A clock source that only ever goes up, not synchronized with epoch.
    monotonic_clock: *const fn () time.Absolute,
};
