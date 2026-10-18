const microzig = @import("microzig");

pub const peripherals = microzig.chip.peripherals;

pub const drivers = struct {};

pub fn init() void {}

pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
