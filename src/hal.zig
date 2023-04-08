const std = @import("std");
const microzig = @import("microzig");
const SIO = microzig.chip.peripherals.SIO;

pub const adc = @import("hal/adc.zig");
pub const pins = @import("hal/pins.zig");
pub const gpio = @import("hal/gpio.zig");
pub const clocks = @import("hal/clocks.zig");
pub const multicore = @import("hal/multicore.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const pwm = @import("hal/pwm.zig");
pub const spi = @import("hal/spi.zig");
pub const resets = @import("hal/resets.zig");
pub const irq = @import("hal/irq.zig");
pub const rom = @import("hal/rom.zig");
pub const flash = @import("hal/flash.zig");
pub const pio = @import("hal/pio.zig");

pub const clock_config = clocks.GlobalConfiguration.init(.{
    .ref = .{ .source = .src_xosc },
    .sys = .{
        .source = .pll_sys,
        .freq = 125_000_000,
    },
    .peri = .{ .source = .clk_sys },
    .usb = .{ .source = .pll_usb },
    .adc = .{ .source = .pll_usb },
    .rtc = .{ .source = .pll_usb },
});

pub fn init() void {
    clock_config.apply();
}

pub fn get_cpu_id() u32 {
    return SIO.CPUID.*;
}
