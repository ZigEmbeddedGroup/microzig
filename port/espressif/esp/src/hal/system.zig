const compatibility = @import("compatibility.zig");

/// Peripheral mask for this specific chip. The set of fields varies from chip to chip, the names
/// of the peripherals that exist on more than one chip do not.
pub const PeripheralMask = chip_specific.PeripheralMask;

/// Disables most peripheral clocks and puts peripherals in the reset state to bring them to a
/// known state.
pub const init = chip_specific.init;

/// Enables the clocks of the peripherals in the mask.
pub const clocks_enable_set = chip_specific.clocks_enable_set;

/// Disables the clocks of the peripherals in the mask.
pub const clocks_enable_clear = chip_specific.clocks_enable_clear;

/// Puts the peripherals in the mask into reset and releases them again.
pub const peripheral_reset = chip_specific.peripheral_reset;

/// Puts the peripherals in the mask into reset.
pub const peripheral_reset_set = chip_specific.peripheral_reset_set;

/// Releases the peripherals in the mask from reset.
pub const peripheral_reset_clear = chip_specific.peripheral_reset_clear;

/// Enable clocks and release peripherals from reset.
pub const enable_clocks_and_release_reset = chip_specific.enable_clocks_and_release_reset;

/// Software triggered interrupts routed from the cpu back into the interrupt matrix.
pub const CPU_Interrupt = chip_specific.CPU_Interrupt;

const chip_specific = switch (compatibility.chip) {
    .esp32_c3 => @import("system/esp32_c3.zig"),
    .esp32_c6 => @import("system/esp32_c6.zig"),
};
