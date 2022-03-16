const std = @import("std");
const micro = @import("microzig.zig");

/// Unmasks the given interrupt and enables its execution.
/// Note that interrupts must be globally enabled with `sei()` as well.
pub fn enable(comptime interrupt: anytype) void {
    _ = interrupt;
    @compileError("not implemented yet!");
}

/// Masks the given interrupt and disables its execution.
pub fn disable(comptime interrupt: anytype) void {
    _ = interrupt;
    @compileError("not implemented yet!");
}

/// Returns true when the given interrupt is unmasked.
pub fn isEnabled(comptime interrupt: anytype) bool {
    _ = interrupt;
    @compileError("not implemented yet!");
}

/// *Set Enable Interrupt*, will enable IRQs globally, but keep the masking done via
/// `enable` and `disable` intact.
pub fn sei() void {
    micro.cpu.sei();
}

/// *Clear Enable Interrupt*, will disable IRQs globally, but keep the masking done via
/// `enable` and `disable` intact.
pub fn cli() void {
    micro.cpu.cli();
}

/// Returns true, when interrupts are globally enabled via `sei()`.
pub fn areGloballyEnabled() bool {
    @compileError("not implemented yet!");
}

/// Enters a critical section and disables interrupts globally.
/// Call `.leave()` on the return value to restore the previous state.
pub fn enterCriticalSection() CriticalSection {
    var section = CriticalSection{
        .enable_on_leave = areGloballyEnabled(),
    };
    cli();
    return section;
}

/// A critical section structure that allows restoring the interrupt
/// status that was set before entering.
const CriticalSection = struct {
    enable_on_leave: bool,

    /// Leaves the critical section and restores the interrupt state.
    pub fn leave(self: @This()) void {
        if (self.enable_on_leave) {
            sei();
        }
    }
};
