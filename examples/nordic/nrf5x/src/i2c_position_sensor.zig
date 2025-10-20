const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;

const I2C_Device = nrf.drivers.I2C_Device;
const i2c0 = i2c.num(0);

const uart = nrf.uart.num(0);

const AS5600 = microzig.drivers.sensor.AS5600;

const sleep_ms = nrf.time.sleep_ms;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.log,
};

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
    });

    nrf.uart.init_logger(uart);

    // Configure i2c peripheral
    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });
    defer i2c0.reset();

    // Create I2C_Device
    std.log.info("Creating device", .{});
    var i2c_device = I2C_Device.init(i2c0, null);
    // Pass i2c and clock device to driver to create sensor instance
    std.log.info("Creating driver instance", .{});
    var dev = AS5600.init(
        i2c_device.i2c_device(),
        @enumFromInt(0x36),
    );

    while (true) {
        std.log.info("Reading status", .{});
        const status = try dev.read_status();
        std.log.info("Status: {any}", .{status});

        sleep_ms(250);
    }
}
