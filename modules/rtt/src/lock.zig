const std = @import("std");
const builtin = @import("builtin");

/// A generic struct that provides exclusive access to the RTT control block
pub fn GenericLock(
    comptime Context: type,
    comptime lock_fn: fn (context: Context) void,
    comptime unlock_fn: fn (context: Context) void,
) type {
    return struct {
        const Self = @This();
        context: Context,

        pub inline fn lock(self: Self) void {
            return lock_fn(self.context);
        }

        fn type_erased_lock(context: *anyopaque) void {
            const ptr: *const Context = @alignCast(@ptrCast(context));
            return lock_fn(ptr.*);
        }

        pub inline fn unlock(self: Self) void {
            return unlock_fn(self.context);
        }

        fn type_erased_unlock(context: *anyopaque) void {
            const ptr: *const Context = @alignCast(@ptrCast(context));
            return unlock_fn(ptr.*);
        }

        pub inline fn any(self: *Self) AnyLock {
            return .{
                .context = @ptrCast(&self.context),
                .lock_fn = type_erased_lock,
                .unlock_fn = type_erased_unlock,
            };
        }
    };
}

/// A type erased version of GenericLock that serves as a concrete type to pass into Config
pub const AnyLock = struct {
    context: *anyopaque,
    lock_fn: fn (context: *anyopaque) void,
    unlock_fn: fn (context: *anyopaque) void,
};

/// Provides the same locking mechanism as included by the original RTT code.
///
/// The default lock behavior when none is provided explicitly. Will error
/// if platform doesn't have a default locking implementation and no user
/// provided implementation (including none) is specified.
pub const default = struct {
    const Context = struct { isr_reg_value: usize };
    var ctx: Context = undefined;
    var generic_lock: resolve_lock_type() = .{ .context = &ctx };
    const ArmV6mV8m = struct {
        fn lock(context: *Context) void {
            var val: usize = undefined;
            asm volatile (
                \\mrs   %[val], primask
                \\movs  r1, #1
                \\msr   primask, r1
                : [val] "=r" (val),
                :
                : "r1", "cc"
            );
            context.isr_reg_value = val;
        }

        fn unlock(context: *Context) void {
            const val = context.isr_reg_value;
            asm volatile ("msr   primask, %[val]"
                :
                : [val] "r" (val),
            );
        }
    };

    const ArmV7mV7emV8mMain = struct {
        const MAX_ISR_PRIORITY = 0x20;

        fn lock(context: *Context) void {
            var val: usize = undefined;
            asm volatile (
                \\mrs   %[val], basepri
                \\movs  r1, %[MAX_ISR_PRIORITY]
                \\msr   basepri, r1
                : [val] "=r" (val),
                : [MAX_ISR_PRIORITY] "i" (MAX_ISR_PRIORITY),
                : "r1", "cc"
            );
            context.isr_reg_value = val;
        }

        fn unlock(context: *Context) void {
            const val = context.isr_reg_value;
            asm volatile ("msr   basepri, %[val]"
                :
                : [val] "r" (val),
            );
        }
    };

    const ArmV7aV7r = struct {
        fn lock(context: *Context) void {
            var val: usize = undefined;
            asm volatile (
                \\mrs   r1, CPSR
                \\mrs   %[val], r1
                \\orr r1, r1, #0xC0
                \\msr CPSR_C, r1
                : [val] "=r" (val),
                :
                : "r1", "cc"
            );
            context.isr_reg_value = val;
        }

        fn unlock(context: *Context) void {
            const val = context.isr_reg_value;
            asm volatile (
                \\mov r0, %[val]
                \\mrs r1, CPSR
                \\bic r1, r1, #0xC0
                \\and r0, r0, #0xC0
                \\orr r1, r1, r0
                \\msr CPSR_C, r1
                :
                : [val] "r" (val),
                : "r0", "r1", "cc"
            );
        }
    };

    /// Allows an intelligent compile error when someone attempts to use RTT on a platform where "default" locking isn't supported yet
    const ErrorLock = struct {
        fn error_lock_unlock(_: *Context) void {
            @compileError(std.fmt.comptimePrint("Unsupported architecture for built in lock support: {any}, please provide custom locking support via Config.exclusive_access field", .{builtin.cpu.arch}));
        }
    };

    fn resolve_lock_type() type {
        const current_arch = builtin.cpu.arch;
        switch (current_arch) {
            .arm, .armeb, .thumb, .thumbeb => {},
            else => return GenericLock(*Context, ErrorLock.error_lock_unlock, ErrorLock.error_lock_unlock),
        }

        if (builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v6m)) or builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v8m))) {
            return GenericLock(
                *Context,
                ArmV6mV8m.lock,
                ArmV6mV8m.unlock,
            );
        } else if (builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7m)) or builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7em)) or builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v8m_main))) {
            return GenericLock(
                *Context,
                ArmV7mV7emV8mMain.lock,
                ArmV7mV7emV8mMain.unlock,
            );
        } else if (builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7a)) or builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7r))) {
            return GenericLock(
                *Context,
                ArmV7aV7r.lock,
                ArmV7aV7r.unlock,
            );
        } else {
            return GenericLock(*Context, ErrorLock.error_lock_unlock, ErrorLock.error_lock_unlock);
        }
    }
    pub fn get() AnyLock {
        return generic_lock.any();
    }
};

/// Empty lock implementation that allows RTT to be used without lock protection
pub const empty = struct {
    const Context = @TypeOf({});
    fn lock(_: Context) void {}
    fn unlock(_: Context) void {}
    var generic_lock: GenericLock(Context, lock, unlock) = .{ .context = {} };

    pub fn get() AnyLock {
        return generic_lock.any();
    }
};
