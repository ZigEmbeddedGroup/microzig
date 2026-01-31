const microzig = @import("microzig");
pub const pins = @import("pins.zig");
pub const gpio = @import("gpio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
pub const i2c = @import("i2c.zig");
pub const usart = @import("usart.zig");
const std = @import("std");
pub const usbhs = @import("./usbhs.zig");

/// HSI (High Speed Internal) oscillator frequency
/// This is the fixed internal RC oscillator frequency for CH32V30x
pub const hsi_frequency: u32 = 8_000_000; // 8 MHz
pub const hse_frequency: u32 = 8_000_000; // 8 MHz

/// Default interrupt handlers provided by the HAL
pub const default_interrupts: microzig.cpu.InterruptOptions = .{
    .TIM2 = time.tim2_handler,
    // .USBHS = usb.usbhs_interrupt_handler,
};

/// Initialize HAL subsystems used by default
pub fn init() void {
    // Configure TIM2 timing driver
    time.init();
    clocks.init(.{
        .source = .hse,
        .hse_frequency = hse_frequency,
        .target_frequency = 48_000_000,
    }); // 8 MHz external crystal
    clocks.enable_usbhs_clock(.{
        .ref_source_hz = hse_frequency,
        .ref_source = .hse,
    });
}
