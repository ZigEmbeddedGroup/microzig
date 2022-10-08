const std = @import("std");
const microzig = @import("microzig");

pub inline fn cli() void {
    asm volatile ("");
}

pub inline fn sei() void {
    asm volatile ("");
}

pub const startup_logic = microzig.chip.startup_logic;
