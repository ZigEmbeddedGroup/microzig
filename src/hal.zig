const microzig = @import("microzig");
const regs = microzig.chip.registers;

pub const gpio = @import("hal/gpio.zig");
pub const clocks = @import("hal/clocks.zig");
pub const multicore = @import("hal/multicore.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");

pub const clock_config = clocks.GlobalConfiguration.init(.{
    .sys = .{
        .source = .pll_sys,
        .freq = 125_000_000,
    },
    .ref = .{ .source = .src_xosc },
    .peri = .{ .source = .clk_sys },
});

pub fn init() void {
    // TODO: resets need to be reviewed here
    clock_config.apply();
    gpio.reset();
}

pub fn getCpuId() u32 {
    return regs.SIO.CPUID.*;
}
