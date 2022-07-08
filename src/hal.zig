const microzig = @import("microzig");
const regs = microzig.chip.regsisters;
pub const gpio = @import("hal/gpio.zig");
pub const clocks = @import("hal/clocks.zig");
pub const multicore = @import("hal/multicore.zig");
pub const time = @import("hal/time.zig");

pub const default_clock_config = clocks.GlobalConfiguration.init(.{
    //.ref = .{ .source = .src_xosc },
    .sys = .{
        .source = .pll_sys,
        .freq = 125_000_000,
    },
    .usb = .{ .source = .pll_usb },
    //.adc = .{ .source = .pll_usb },
    //.rtc = .{ .source = .pll_usb },
    .peri = .{ .source = .clk_sys },
});

pub fn getCpuId() u32 {
    return regs.SIO.CPUID.*;
}
