//! These are experimental generic interfaces. We want to see more use and
//! discussion of them before committing them to microzig's "official" API.
//!
//! They are bound to have breaking changes in the future, or even disappear,
//! so use at your own risk.
pub const clock = @import("experimental/clock.zig");
pub const debug = @import("experimental/debug.zig");
pub const gpio = @import("experimental/gpio.zig");
pub const i2c = @import("experimental/i2c.zig");
pub const Pin = @import("experimental/pin.zig").Pin;
pub const spi = @import("experimental/spi.zig");
pub const uart = @import("experimental/uart.zig");

///semihosting requires a valid host session, either via a simulator or via a debug probe, otherwise the code will always result in a halt.
///This implementation only supports Arm-M.
///More info: https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.rst
pub const ARM_semihosting = @import("experimental/semihosting.zig");
