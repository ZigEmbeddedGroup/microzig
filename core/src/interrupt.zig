const std = @import("std");
const microzig = @import("microzig.zig");

/// Unmasks the given interrupt and enables its execution.
/// Note that interrupts must be globally enabled with `enable_interrupts()` as well.
pub inline fn enable(comptime interrupt: anytype) void {
    microzig.cpu.enable(interrupt);
}

/// Masks the given interrupt and disables its execution.
pub inline fn disable(comptime interrupt: anytype) void {
    microzig.cpu.disable(interrupt);
}

/// Returns true when the given interrupt is unmasked.
pub inline fn is_enabled(comptime interrupt: anytype) bool {
    _ = interrupt;
    @compileError("not implemented yet!");
}

/// *Set Enable Interrupt*, will enable interrupts globally, but keep the masking done via
/// `enable` and `disable` intact.
pub inline fn enable_interrupts() void {
    microzig.cpu.enable_interrupts();
}

/// *Clear Enable Interrupt*, will disable interrupts globally, but keep the masking done via
/// `enable` and `disable` intact.
pub inline fn disable_interrupts() void {
    microzig.cpu.disable_interrupts();
}

/// Returns true, when interrupts are globally enabled via `sei()`.
pub inline fn globally_enabled() bool {
    return microzig.cpu.globally_enabled();
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
const CriticalSection = struct {
    enable_on_leave: bool,

    /// Leaves the critical section and restores the interrupt state.
    pub fn leave(self: @This()) void {
        if (self.enable_on_leave) {
            enable_interrupts();
        }
    }
};

// TODO: remove this once the vector table uses it's own implementation
pub const Handler = *const fn () callconv(.C) void;

pub fn unhandled() callconv(.C) void {
    @panic("unhandled interrupt");
}
