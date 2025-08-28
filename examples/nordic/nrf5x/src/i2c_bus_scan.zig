const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;
const i2cdma = nrf.i2cdma;

const uart = nrf.uart.num(0);
const i2c0 = i2c.num(0);
const i2c0dma = i2cdma.num(0);

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
        .baud_rate = .@"115200",
    });

    nrf.uart.init_logger(uart);

    defer i2c0.reset();
    defer i2c0dma.reset();

    // ------------------------ BUS SCAN ------------------------
    std.log.info("I2C bus scan", .{});

    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });
    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, null) catch |e| {
            if (e != i2c.Error.DeviceNotPresent and
                e != i2c.Error.IllegalAddress)
                std.log.info("Error {any}", .{e});
            continue;
        };

        std.log.info("I2C device found at address {X}.", .{addr});
    }
    i2c0.reset();

    // ------------------------ BUS SCAN (DMA) ------------------------
    std.log.info("I2C bus scan (DMA)", .{});

    try i2c0dma.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });
    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2cdma.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0dma.read_blocking(a, &rx_data, null) catch |e| {
            if (e != i2c.Error.DeviceNotPresent and
                e != i2c.Error.IllegalAddress)
                std.log.info("Error {any}", .{e});
            continue;
        };

        std.log.info("I2C device found at address {X}.", .{addr});
    }
    i2c0dma.reset();

    std.log.info("Done!", .{});
}
