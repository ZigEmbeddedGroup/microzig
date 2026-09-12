const microzig = @import("microzig");

pub const peripherals = microzig.chip.peripherals;

pub const drivers = struct {};

pub fn init() void {}

pub const gpio = @import("gpio.zig");
pub const clock = @import("clocks.zig");
