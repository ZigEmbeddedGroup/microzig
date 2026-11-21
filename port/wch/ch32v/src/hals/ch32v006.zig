const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

pub const pins = @import("ch32v006/pins.zig");
pub const gpio = @import("ch32v006/gpio.zig");

/// HSI (High Speed Internal) oscillator frequency.
/// This is the fixed internal RC oscillator frequency for the CH32V00X series.
pub const hsi_frequency: u32 = 24_000_000; // 24 MHz

const RCC = peripherals.RCC;
const FLASH = peripherals.FLASH;
