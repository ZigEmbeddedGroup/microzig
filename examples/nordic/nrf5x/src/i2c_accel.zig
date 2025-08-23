const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;

const I2C_Device = nrf.drivers.I2C_Device;
const uart = nrf.uart.num(0);
const i2c0 = i2c.num(0);

const ICM_20948 = microzig.drivers.sensor.ICM_20948;

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
    var i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x69), null);
    // Pass i2c device to driver to create sensor instance
    var dev = try ICM_20948.init(
        i2c_device.datagram_device(),
        nrf.drivers.clock_device(),
        .{
            .accel_dlp = .@"6Hz",
            .gyro_dlp = .@"6Hz",
            .accel_odr_div = 21, // About 50Hz
            .gyro_odr_div = 21, // About 50Hz
        },
    );

    try dev.setup();

    while (true) {
        const data = try dev.get_accel_gyro_mag_data();
        std.log.info(
            "accel: x {d: >6.2} y {d: >6.2} z {d: >6.2} (m/s²) " ++
                "gyro: x {d: >6.2} y {d: >6.2} z {d: >6.2} (rads) " ++
                "temp: {d: >5.2}°C " ++
                "mag: x {d: >6.2} y {d: >6.2} z {d: >6.2} (µT)",
            .{ data.accel.x, data.accel.y, data.accel.z, data.gyro.x, data.gyro.y, data.gyro.z, data.temp, data.mag.x, data.mag.y, data.mag.z },
        );

        sleep_ms(500);
    }
}
