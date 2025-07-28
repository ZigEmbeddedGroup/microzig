pub const rcc = @import("rcc.zig");
pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const uart = @import("uart.zig");
pub const i2c = @import("i2c.zig");
pub const spi = @import("spi.zig");
pub const drivers = @import("drivers.zig");
pub const timer = @import("timer.zig");
pub const usb = @import("usb.zig");
pub const adc = @import("adc.zig");
pub const crc = @import("crc.zig");
pub const power = @import("power.zig");

pub var RESET: rcc.ResetReason = .POR_or_PDR;
pub fn init() void {
    RESET = rcc.get_reset_reason();
}
