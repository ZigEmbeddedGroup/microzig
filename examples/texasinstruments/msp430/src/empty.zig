const std = @import("std");

const microzig = @import("microzig");

pub const std_options = microzig.std_options(.{});

pub const panic = std.debug.no_panic;
pub fn main() void {}
