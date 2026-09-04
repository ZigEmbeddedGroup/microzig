const std = @import("std");
const microzig = @import("microzig");

pub const gpio = @import("hal/gpio.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");

/// There is nothing to do before main: the firmware has already set the clocks up and loaded the
/// image, and this port leaves the mmu and the caches off.
pub fn init() void {}
