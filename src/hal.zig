const std = @import("std");
const microzig = @import("microzig");
const SIO = microzig.chip.peripherals.SIO;

pub const adc = @import("hal/adc.zig");
pub const clocks = @import("hal/clocks.zig");
pub const dma = @import("hal/dma.zig");
pub const flash = @import("hal/flash.zig");
pub const gpio = @import("hal/gpio.zig");
pub const irq = @import("hal/irq.zig");
pub const multicore = @import("hal/multicore.zig");
pub const pins = @import("hal/pins.zig");
pub const pio = @import("hal/pio.zig");
pub const pwm = @import("hal/pwm.zig");
pub const rand = @import("hal/random.zig");
pub const resets = @import("hal/resets.zig");
pub const rom = @import("hal/rom.zig");
pub const spi = @import("hal/spi.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const usb = @import("hal/usb.zig");

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
    // Reset all peripherals to put system into a known state, - except
    // for QSPI pads and the XIP IO bank, as this is fatal if running from
    // flash - and the PLLs, as this is fatal if clock muxing has not been
    // reset on this boot - and USB, syscfg, as this disturbs USB-to-SWD
    // on core 1
    resets.reset_block(resets.masks.init);

    // Remove reset from peripherals which are clocked only by clk_sys and
    // clk_ref. Other peripherals stay in reset until we've configured
    // clocks.
    resets.unreset_block_wait(resets.masks.clocked_by_sys_and_ref);

    clock_config.apply();

    // Peripheral clocks should now all be running
    resets.unreset_block_wait(resets.masks.all);
}

pub fn get_cpu_id() u32 {
    return SIO.CPUID.*;
}

test "hal tests" {
    _ = pio;
    _ = usb;
}
