const std = @import("std");
const microzig = @import("microzig");
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;

const gpout0_pin = gpio.num(21);
const clock_config = clocks.GlobalConfiguration.init(.{
    .sys = .{ .source = .src_xosc },
    .gpout0 = .{ .source = .clk_sys },
});

pub fn main() !void {
    gpout0_pin.set_function(.gpck);
    while (true) {}
}
