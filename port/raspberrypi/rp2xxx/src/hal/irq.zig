/// These are wrappers around the `microzig.cpu.interrupt` interface.
///
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const cpu = microzig.cpu;
const chip = rp2xxx.compatibility.chip;
const PPB = microzig.chip.peripherals.PPB;

const interrupt = cpu.interrupt;

/// Returns true, when interrupts are globally enabled.
pub fn is_globally_enabled() bool {
    return cpu.interrupt.globally_enabled();
}

/// Enable interrupts globally
pub fn globally_enable() void {
    cpu.interrupt.enable_interrupts();
}

/// Disable interrupts globally
pub fn globally_disable() void {
    interrupt.disable_interrupts();
}

/// Returns true, when the given interrupt is enabled.
/// Parameters:
///   int: The interrupt to check
pub fn is_enabled(comptime int: cpu.ExternalInterrupt) bool {
    return interrupt.is_enabled(int);
}

/// Enable a specific device interrupt.
/// Note: This only enables the interrupt for the NVIC item.  Interrupts for
/// specific device functions may also have to be enabled at the device level.
/// Parameters:
///   int: The interrupt to enable
pub fn enable(comptime int: cpu.ExternalInterrupt) void {
    interrupt.clear_pending(int);
    interrupt.enable(int);
}

/// Disable a specific device interrupt
/// Parameters:
///   int: The interrupt to disable
pub fn disable(comptime int: cpu.ExternalInterrupt) void {
    interrupt.disable(int);
}

/// Returns true, when setting interrupt handlers at runtime is possible.
pub inline fn can_set_handler() bool {
    return interrupt.has_ram_vectors();
}

/// Set the handler for a specific interrupt.
/// Parameters:
///   int: The interrupt to set the handler for
///   handler: The new handler, or null to remove the handler
/// Returns:
///   The old handler, or null if the handler was not set
pub fn set_handler(comptime int: cpu.ExternalInterrupt, handler: ?cpu.Handler) ?cpu.Handler {
    return interrupt.set_handler(int, handler);
}
