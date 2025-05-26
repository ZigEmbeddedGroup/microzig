const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;
// const i2cdma = nrf.i2cdma;

const ClockDevice = nrf.drivers.ClockDevice;
const I2C_Device = nrf.drivers.I2C_Device;
const uart = nrf.uart.num(0);
const i2c0 = i2c.num(0);
// const i2c0dma = i2cdma.num(0);

const ICM_20948 = microzig.drivers.sensor.ICM_20948;

const sleep_ms = nrf.time.sleep_ms;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = nrf.uart.logFn,
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
    // defer i2c0dma.reset();

    // ------------------------ BUS SCAN ------------------------
    // std.log.info("I2C bus scan", .{});

    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });
    // for (0..std.math.maxInt(u7)) |addr| {
    //     const a: i2c.Address = @enumFromInt(addr);
    //
    //     var rx_data: [1]u8 = undefined;
    //     _ = i2c0.read_blocking(a, &rx_data, null) catch |e| {
    //         if (e != i2c.TransactionError.DeviceNotPresent and
    //             e != i2c.TransactionError.TargetAddressReserved)
    //             std.log.info("Error {any}", .{e});
    //         continue;
    //     };
    //
    //     std.log.info("I2C device found at address {X}.", .{addr});
    // }

    // ------------------------ Accel ------------------------
    std.log.info("Accelerometer", .{});
    // Create i2c datagram device
    var i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x69), null);
    // Pass i2c device to driver to create sensor instance
    var cd = ClockDevice{};
    var dev = try ICM_20948.init(
        i2c_device.datagram_device(),
        cd.clock_device(),
        .{
            .accel_dlp = .@"50Hz",
            .gyro_dlp = .@"51",
        },
    );

    try dev.setup();

    while (true) {
        // const accel = try dev.get_accel_data();
        // std.log.info("accel: x {d: >8} y {d: >8} z {d: >8}", .{ accel.x, accel.y, accel.z });

        const gyro = try dev.get_gyro_data();
        std.log.info("gyro: x {d: >8} y {d: >8} z {d: >8}", .{ gyro.x, gyro.y, gyro.z });

        // var log_buf: [128]u8 = undefined;
        // _ = try std.fmt.bufPrint(&log_buf, gyro.x, gyro.y, gyro.z);
        // uart.write_blocking(&log_buf);

        sleep_ms(200);
        // uart.write_blocking("\x1b[2K\r"[0..]);
    }

    std.log.info("Done!", .{});
}
