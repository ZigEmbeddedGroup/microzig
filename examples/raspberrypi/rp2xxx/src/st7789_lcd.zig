//! ST7789 Driver Demo — using WaveShare 1.3inch LCD Display Module
//!
//! WaveShare 1.3inch LCD Display Module is based on ST7789 driver and has a 240x240 pixel resolution.
//! This example demonstrates how to interface with the display using SPI and GPIO,
//! and includes basic drawing operations like clearing the screen and setting pixels.
//!
//! Pinout:
//! - CS: GPIO 9
//! - SCK: GPIO 10
//! - MOSI: GPIO 11
//! - DC: GPIO 8
//! - RST: GPIO 12
//! - Backlight: GPIO 13 (PWM for brightness control)

const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pwm = rp2xxx.pwm;
const drivers = rp2xxx.drivers;

// Default pin mapping for SPI0 ST7735 bring-up on Pico style boards.
// Update these pins to match your display wiring.
const DISPLAY_CS_PIN = 9;
const DISPLAY_SCK_PIN = 10;
const DISPLAY_MOSI_PIN = 11;
const DISPLAY_DC_PIN = 8;
const DISPLAY_RST_PIN = 12;
const DISPLAY_BACKLIGHT_PIN = 13;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

const led = gpio.num(DISPLAY_BACKLIGHT_PIN);
const led_pwm = pwm.get_pwm(DISPLAY_BACKLIGHT_PIN);
const spi = rp2xxx.spi.instance.SPI1;

// Use pre-compiled display setttings for ST7789 with a 240x240 RGB panel.
const DisplayDriver = microzig.drivers.display.st77xx.ST7789(.lcd240x240rgb);
// Framebuffer for off-screen drawing before pushing to the display.
var display_buffer: [240 * 240]DisplayDriver.Color = undefined;

fn fill_display_buffer(buffer: []DisplayDriver.Color, color: DisplayDriver.Color) void {
    @memset(buffer, color);
}

fn fill_display_buffer_rect(
    buffer: []DisplayDriver.Color,
    x: usize,
    y: usize,
    width: usize,
    height: usize,
    color: DisplayDriver.Color,
) void {
    const display_width: usize = 240;
    const display_height: usize = 240;

    if (buffer.len < display_width * display_height) return;
    if (x >= display_width or y >= display_height) return;
    if (width == 0 or height == 0) return;

    const x_end = @min(x +| width, display_width);
    const y_end = @min(y +| height, display_height);

    for (y..y_end) |row| {
        const row_start = row * display_width + x;
        @memset(buffer[row_start .. row_start + (x_end - x)], color);
    }
}

fn flush_display_buffer(display: *DisplayDriver, buffer: []DisplayDriver.Color) !void {
    try display.set_address_window(0, 0, 240, 240);
    try display.push_colors(buffer);
}

pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart, &.{});

    led.set_function(.pwm);
    led.set_direction(.out);
    led_pwm.slice().set_wrap(100);
    led_pwm.slice().set_clk_div(50, 0);
    led_pwm.set_level(1);
    led_pwm.slice().enable();

    const cs_pin = gpio.num(DISPLAY_CS_PIN);
    const sck_pin = gpio.num(DISPLAY_SCK_PIN);
    const mosi_pin = gpio.num(DISPLAY_MOSI_PIN);
    const dc_pin = gpio.num(DISPLAY_DC_PIN);
    const rst_pin = gpio.num(DISPLAY_RST_PIN);

    inline for (&.{ cs_pin, sck_pin, mosi_pin }) |pin| {
        pin.set_function(.spi);
    }

    try spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .baud_rate = 10_000_000, // 10 MHz is a common max for ST7735, but check your display's datasheet.
    });

    var spi_dev = drivers.SPI_Device.init(spi, .{
        .chip_select = .{ .pin = cs_pin, .active_level = .low },
    });

    dc_pin.set_function(.sio);
    dc_pin.set_direction(.out);
    rst_pin.set_function(.sio);
    rst_pin.set_direction(.out);

    var dc_gpio = drivers.GPIO_Device.init(dc_pin);
    var rst_gpio = drivers.GPIO_Device.init(rst_pin);

    var my_display = try DisplayDriver.init(spi_dev.datagram_device(), rst_gpio.digital_io(), dc_gpio.digital_io(), time.sleep_ms);

    while (true) {
        time.sleep_ms(2000);
        try my_display.set_rotation(.deg0);
        fill_display_buffer(&display_buffer, .red);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        fill_display_buffer(&display_buffer, .green);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        fill_display_buffer(&display_buffer, .blue);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        fill_display_buffer_rect(&display_buffer, 20, 20, 50, 50, .white);
        fill_display_buffer_rect(&display_buffer, 70, 20, 50, 50, .black);
        fill_display_buffer_rect(&display_buffer, 20, 70, 50, 50, .yellow);
        fill_display_buffer_rect(&display_buffer, 70, 70, 50, 50, .cyan);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        try my_display.set_rotation(.deg90);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        try my_display.set_rotation(.deg180);
        try flush_display_buffer(&my_display, display_buffer[0..]);

        time.sleep_ms(2000);
        try my_display.set_rotation(.deg270);
        try flush_display_buffer(&my_display, display_buffer[0..]);
    }
}
