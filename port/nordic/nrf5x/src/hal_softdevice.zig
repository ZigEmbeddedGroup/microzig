// HAL wrapper for SoftDevice-enabled targets.
//
// Re-exports the standard nRF5x HAL and adds the variant-specific SoftDevice
// module. The build system provides the "softdevice" import pointing to the
// correct variant root (s112, s113, s122, s132, or s140).

const hal = @import("hal.zig");

pub const softdevice = @import("softdevice");

pub const compatibility = hal.compatibility;
pub const clocks = hal.clocks;
pub const gpio = hal.gpio;
pub const i2c = hal.i2c;
pub const i2cdma = hal.i2cdma;
pub const spim = hal.spim;
pub const time = hal.time;
pub const uart = hal.uart;
pub const drivers = hal.drivers;

pub const default_interrupts = hal.default_interrupts;

pub fn init() void {
    hal.init();
}
