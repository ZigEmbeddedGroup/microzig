const std = @import("std");
const microzig = @import("microzig.zig");

/// Unmasks the given interrupt and enables its execution.
/// Note that interrupts must be globally enabled with `enable_interrupts()` as well.
pub inline fn enable(comptime interrupt: anytype) void {
    microzig.cpu.interrupt.enable(interrupt);
}

/// Masks the given interrupt and disables its execution.
pub inline fn disable(comptime interrupt: anytype) void {
    microzig.cpu.interrupt.disable(interrupt);
}

/// Returns true when the given interrupt is unmasked.
pub inline fn is_enabled(comptime interrupt: anytype) bool {
    _ = interrupt;
    @compileError("not implemented yet!");
}

/// *Set Enable Interrupt*, will enable interrupts globally, but keep the masking done via
/// `enable` and `disable` intact.
pub inline fn enable_interrupts() void {
    microzig.cpu.interrupt.enable_interrupts();
}

/// *Clear Enable Interrupt*, will disable interrupts globally, but keep the masking done via
/// `enable` and `disable` intact.
pub inline fn disable_interrupts() void {
    microzig.cpu.interrupt.disable_interrupts();
}

/// Returns true, when interrupts are globally enabled via `sei()`.
pub inline fn globally_enabled() bool {
    return microzig.cpu.interrupt.globally_enabled();
}

/// Enters a critical section and disables interrupts globally.
/// Call `.leave()` on the return value to restore the previous state.
pub fn enter_critical_section() CriticalSection {
    const section = CriticalSection{
        .enable_on_leave = globally_enabled(),
    };
    disable_interrupts();
    return section;
}

/// A critical section structure that allows restoring the interrupt
/// status that was set before entering.
pub const CriticalSection = struct {
    enable_on_leave: bool,

    /// Leaves the critical section and restores the interrupt state.
    pub fn leave(self: @This()) void {
        if (self.enable_on_leave) {
            enable_interrupts();
        }
    }
};

// defined for regz
pub const Handler = extern union {
    naked: *const fn () callconv(.naked) void,
    c: *const fn () callconv(.c) void,
};

// defined for regz
pub const unhandled: Handler = .{
    .c = struct {
        pub fn unhandled() callconv(.c) void {
            @panic("unhandled interrupt");
        }
    }.unhandled,
};

/// Return the mutex type to use.  If a target provides its own mutex type
/// in its HAL, use that; otherwise, use the default `CriticalSectionMutex`.
///
/// Create a mutex instance with `var aMutex = Mutex.init(.{});`.
///
/// Lock it (blocking) with `aMutex.lock();`,
/// try to lock it (non-blocking) with `const success: bool = aMutex.try_lock();`,
/// and unlock it with `aMutex.unlock();`.
///
pub const Mutex = if (microzig.config.has_hal and @hasDecl(microzig.hal, "mutex") and @hasDecl(microzig.hal.mutex, "Mutex"))
    microzig.hal.mutex.Mutex
else
    CriticalSectionMutex;

/// This is an implementation of a mutex that simply wraps the critical section
/// functionality.
///
pub const CriticalSectionMutex = struct {
    critical_section: ?CriticalSection = null,

    /// Initialize the mutex.
    /// Parameters:
    /// - `params`: Mutex configuration parameters. (ignored)
    pub fn init(params: anytype) CriticalSectionMutex {
        _ = params;
        return .{};
    }

    /// Try to lock the mutex.
    /// If the mutex was already locked return false.
    pub fn try_lock(self: *CriticalSectionMutex) bool {
        const cs = enter_critical_section();
        if (self.critical_section != null) {
            cs.leave();
            return false;
        }
        self.critical_section = cs;
        return true;
    }

    /// Makes sure the mutex is locked.
    /// If this function is called from within a block of code that already
    /// held the mutex it will panic.
    pub fn lock(self: *CriticalSectionMutex) void {
        if (!self.try_lock()) @panic("mutex already locked");
    }

    /// Unlocks the mutex.
    pub fn unlock(self: *CriticalSectionMutex) void {
        const maybe_cs = self.critical_section;
        self.critical_section = null;
        if (maybe_cs) |cs| {
            cs.leave();
        }
    }
};
