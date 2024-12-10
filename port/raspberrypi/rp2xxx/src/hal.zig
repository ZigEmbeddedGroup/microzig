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
pub const rtc = switch (compatibility.cpu) {
    .RP2040 => @import("hal/rtc.zig"),
    .RP2350 => {}, // No explicit "RTC" module on RP2350
};
pub const spi = @import("hal/spi.zig");
pub const i2c = @import("hal/i2c.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const usb = @import("hal/usb.zig");
pub const drivers = @import("hal/drivers.zig");
pub const compatibility = @import("hal/compatibility.zig");

/// A default clock configuration with sensible defaults that will work
/// for the majority of use cases. Use this unless you have a specific
/// clock configuration use case that this wont work for (for instance a custom
/// board that does NOT use an external oscillator XOSC as the clock source).
///
/// Users will have to provide their own init() function to override init() below
/// to provide their own custom clock config.
pub const clock_config = clocks.config.preset.default();

pub inline fn init() void {
    init_sequence(clock_config);
}

/// Allows user to easily swap in their own clock config while still
/// using the reccomended initialization sequence
pub fn init_sequence(comptime clock_cfg: clocks.config.Global) void {

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

    clocks.default_startup_procedure(clock_cfg);

    // Peripheral clocks should now all be running
    resets.unreset_block_wait(resets.masks.all);
}

pub fn get_cpu_id() u32 {
    return SIO.CPUID.*;
}

test "hal tests" {
    _ = pio;
    _ = usb;
    _ = i2c;
    _ = uart;
}
