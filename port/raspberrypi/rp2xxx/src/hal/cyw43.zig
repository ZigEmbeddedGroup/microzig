const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const Cyw43PioSpi = hal.cyw49_pio_spi.Cyw43PioSpi;
const Cyw43_Spi = microzig.drivers.wireless.Cyw43_Spi;
const Cyw43_Bus = microzig.drivers.wireless.Cyw43_Bus;
const Cyw43_Runner = microzig.drivers.wireless.Cyw43_Runner;
const GPIO_Device = hal.drivers.GPIO_Device;

// See page 8 of the Raspberry Pi Pico 2 W Datasheet
/// Pico 2 W pin configuration for CYW43
const pico2w_config = .{
    .pio = hal.pio.num(0),
    .pwr_pin = hal.gpio.num(23),
    .cs_pin = hal.gpio.num(25),
    .io_pin = hal.gpio.num(24),
    .clk_pin = hal.gpio.num(29),
};

/// Static state for the CYW43 device
var state: struct {
    pwr_gpio: GPIO_Device = undefined,
    pio_spi: Cyw43PioSpi = undefined,
    spi: Cyw43_Spi = undefined,
    bus: Cyw43_Bus = undefined,
    runner: Cyw43_Runner = undefined,
    initialized: bool = false,
} = .{};

/// Initialize the CYW43 chip with Pico 2 W defaults.
/// Must be called before using gpio functions.
pub fn init() !void {
    if (state.initialized) return;

    // Initialize PIO SPI
    state.pio_spi = try hal.cyw49_pio_spi.init(.{
        .pio = pico2w_config.pio,
        .cs_pin = pico2w_config.cs_pin,
        .io_pin = pico2w_config.io_pin,
        .clk_pin = pico2w_config.clk_pin,
    });
    state.spi = state.pio_spi.cyw43_spi();

    // Initialize power pin
    pico2w_config.pwr_pin.set_function(.sio);
    pico2w_config.pwr_pin.set_direction(.out);
    state.pwr_gpio = GPIO_Device.init(pico2w_config.pwr_pin);

    // Initialize bus and runner
    state.bus = .{
        .pwr_pin = state.pwr_gpio.digital_io(),
        .spi = &state.spi,
        .internal_delay_ms = hal.time.sleep_ms,
    };
    state.runner = .{
        .bus = &state.bus,
        .internal_delay_ms = hal.time.sleep_ms,
    };

    try state.runner.init();
    state.initialized = true;
}

/// CYW43 GPIO interface
pub const gpio = struct {
    /// Available GPIO pins on the CYW43
    pub const Pin = enum(u3) {
        /// The onboard LED (active high)
        led = 0,
        // See sections 3.3 and 3.4 of the Raspberry Pi Pico 2 W Datasheet for info on these pins
        /// WL_GPIO1 - controls the on-board SMPS power save pin
        wl_gpio1 = 1,
        /// WL_GPIO2 - VBUS sense, high is present else low
        wl_gpio2 = 2,
    };

    /// Set a GPIO pin high or low
    pub fn put(pin: Pin, value: bool) void {
        if (!state.initialized) return;
        state.runner.wifi().gpio_set(@intFromEnum(pin), value) catch {};
    }
};
