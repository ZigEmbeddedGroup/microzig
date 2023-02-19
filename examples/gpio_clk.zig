const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;

const gpout0_pin = 21;
const clock_config = clocks.GlobalConfiguration.init(.{
    .sys = .{ .source = .src_xosc },
    .gpout0 = .{ .source = .clk_sys },
});

pub fn init() void {
    clock_config.apply();
    gpio.reset();
}

pub fn main() !void {
    gpio.set_function(gpout0_pin, .gpck);
    while (true) {}
}
