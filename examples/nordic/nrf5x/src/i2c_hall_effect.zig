const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;
// TODO: Try the DMA one?
const i2cdma = nrf.i2cdma;

const ClockDevice = nrf.drivers.ClockDevice;
const I2C_Device = nrf.drivers.I2C_Device;
const uart = nrf.uart.num(0);
const i2c0 = i2c.num(0);
const i2c0d = i2cdma.num(0);

const TLV493D = microzig.drivers.sensor.TLV493D;

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

    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });

    // Create i2c datagram device
    // var i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x1F), null);
    var i2c_device = I2C_Device.init(i2c0, null);
    // Pass i2c device to driver to create sensor instance
    var cd = ClockDevice{};
    var dev = try TLV493D.init(
        i2c_device.i2c_device(),
        @enumFromInt(0x5E),
        cd.clock_device(),
        .{
            .reset = false,
        },
    );

    while (true) {
        const data = try dev.read();
        std.log.info(
            "accel: x {d: >6.2} y {d: >6.2} z {d: >6.2} (mT)",
            .{ data.x, data.y, data.z },
        );
        std.log.info("temp: {d: >6.2}°C", .{data.temp});

        sleep_ms(500);
    }

    std.log.info("Done!", .{});
}
