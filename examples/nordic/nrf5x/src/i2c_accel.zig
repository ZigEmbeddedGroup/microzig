const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;

const ClockDevice = nrf.drivers.ClockDevice;
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
    var cd = ClockDevice{};
    var dev = try ICM_20948.init(
        i2c_device.datagram_device(),
        cd.clock_device(),
        .{
            .accel_dlp = .@"6Hz",
            .gyro_dlp = .@"6Hz",
            .accel_odr_div = 21, // About 50Hz
            .gyro_odr_div = 21, // About 50Hz
        },
    );

    try dev.setup();
    // try dev.write_byte(.{ .bank3 = .i2c_slv0_ctrl }, 0);
    // try dev.write_byte(.{ .bank0 = .int_pin_cfg }, 0b10); // bypass_en
    // // read device id
    // try i2c0.write_blocking(@enumFromInt(0x0C), &.{0x01}, null);
    // var buf: [32]u8 = undefined;
    // try i2c0.read_blocking(@enumFromInt(0x0C), &buf, null);
    // std.log.info("Got: {x}", .{buf});
    // try dev.health_check();

    while (true) {
        const data = try dev.get_accel_gyro_data();
        std.log.info(
            "accel: x {d: >8.2} y {d: >8.2} z {d: >8.2} " ++
                "gyro: x {d: >8.2} y {d: >8.2} z {d: >8.2}",
            .{ data.accel.x, data.accel.y, data.accel.z, data.gyro.x, data.gyro.y, data.gyro.z },
        );

        const temp_c = try dev.get_temp();
        std.log.info("temp: {d: >5.2}°C", .{temp_c});

        const mag_data = try dev.get_mag_data_unscaled();
        std.log.info(
            "mag: x {d: >8.2} y {d: >8.2} z {d: >8.2} ",
            .{ mag_data.x, mag_data.y, mag_data.z },
        );

        sleep_ms(200);
    }
}
