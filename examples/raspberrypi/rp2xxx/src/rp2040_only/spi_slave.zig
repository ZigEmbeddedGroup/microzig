const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const chip = rp2xxx.compatibility.chip;

const BUF_LEN = 0x10;
const spi = rp2xxx.spi.instance.SPI0;

const led = gpio.num(25);
const led_red = gpio.num(11);
const led_green = gpio.num(12);
const led_blue = gpio.num(13);
// >>UART logging
const uart = rp2xxx.uart.instance.num(1);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(8);
const uart_rx_pin = gpio.num(9);
// <<UART logging

// These will change depending on which GPIO pins you have your SPI device routed to.
const CS_PIN = 17;
const SCK_PIN = 18;
// TODO: rx/tx, e.g. is mosi just miso in slave mode?
// -- Since this is the slave device, we read on MISO_PIN
const MOSI_PIN = 16;
const MISO_PIN = 19;
// const MOSI_PIN = 19;
// const MISO_PIN = 16;

pub const microzig_options = .{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);
    inline for (.{ led_red, led_green, led_blue }) |p| {
        p.set_function(.sio);
        p.set_direction(.out);
        p.put(1);
    }
    // Set pin functions for CS, SCK, MOSI, MISO
    // TODO Should we wait on csn manually
    const csn = gpio.num(CS_PIN);
    // csn.set_function(.sio);
    // csn.set_direction(.in);
    const mosi = gpio.num(MOSI_PIN);
    const miso = gpio.num(MISO_PIN);
    const sck = gpio.num(SCK_PIN);
    // inline for (&.{ mosi, miso, sck }) |pin| {
    inline for (&.{ csn, mosi, miso, sck }) |pin| {
        pin.set_function(.spi);
    }

    // >>UART logging
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        switch (chip) {
            .RP2040 => pin.set_function(.uart),
            .RP2350 => pin.set_function(.uart_first),
        }
    }
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);
    // <<UART logging

    // led.toggle();
    std.log.info("Setting SPI as slave device", .{});
    spi.set_slave(true);
    led_red.put(0);
    led_green.put(1);
    led_blue.put(1);

    // Back to 8 bit mode
    spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .data_width = .eight,
    }) catch {};
    // led.toggle();
    var in_buf_eight: [BUF_LEN]u8 = undefined;
    led_red.put(0);
    led_green.put(0);
    led_blue.put(1);
    // Wait on CS low
    // std.log.info("Waiting on CSn", .{});
    // while (csn.read() != 0) {}
    // std.log.info("cs low", .{});
    led_red.put(1);
    led_green.put(0);
    led_blue.put(0);
    std.log.info("Reading", .{});
    spi.read_blocking(u8, 0, &in_buf_eight);
    led_red.put(1);
    led_green.put(1);
    led_blue.put(1);

    std.log.info("Got: {s}", .{in_buf_eight});
    led_red.put(1);
    led_green.put(0);
    led_blue.put(1);

    // 12 bit data words
    // try spi.apply(.{
    //     .clock_config = rp2xxx.clock_config,
    //     .data_width = .twelve,
    // });
    // var in_buf_twelve: [BUF_LEN]u12 = undefined;
    // // Wait on CS low
    // while (csn.read() != 0) {}
    // spi.read_blocking(u12, 0, &in_buf_twelve);
    // std.log.info("Got: {any}\r", .{in_buf_twelve});

    // Back to 8 bit mode
    try spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .data_width = .eight,
    });

    while (true) {
        // led.put(0);
        time.sleep_ms(250);
        led_red.put(0);
        led_green.put(0);
        led_blue.put(1);
        // Wait on CS low
        // std.log.info("Waiting on CSn\n", .{});
        // while (csn.read() != 0) {}
        led_red.put(1);
        led_green.put(0);
        led_blue.put(0);
        spi.read_blocking(u8, 0, &in_buf_eight);
        led_red.put(1);
        led_green.put(1);
        led_blue.put(1);
        // led.put(1);
        std.log.info("Got: {s}", .{in_buf_eight});
        time.sleep_ms(250);
    }
}
