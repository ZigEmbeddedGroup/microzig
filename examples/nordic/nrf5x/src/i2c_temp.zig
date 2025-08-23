const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;

const nrf = microzig.hal;
const TMP117 = microzig.drivers.sensor.TMP117;

const i2c = nrf.i2c;
const i2cdma = nrf.i2cdma;
const gpio = nrf.gpio;
const peripherals = microzig.chip.peripherals;
const I2C_Device = nrf.drivers.I2C_Device;

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

    // ------------------------ TMP117 w/driver ------------------------
    std.log.info("I2C temp sensor (using driver)", .{});
    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });

    // Create i2c device
    var i2c_device = I2C_Device.init(i2c0, null);
    // Pass i2c device to driver to create sensor instance
    const temp_sensor = try TMP117.init(i2c_device.i2c_device(), @enumFromInt(0x48));

    const temp_sensor_address = 0x48;
    var temp_buf: [2]u8 = undefined;
    const cbuf = [3]u8{ 1, 0, 0 };

    std.log.info("Writing config", .{});
    try temp_sensor.write_configuration(.{});

    std.log.info("Reading device ID config", .{});
    const id = try temp_sensor.read_device_id();
    std.log.info("ID: {any}", .{id});

    for (0..5) |_| {
        const temp = try temp_sensor.read_temperature();
        std.log.info("Temp: {d:0.2}°C", .{temp});
        sleep_ms(500);
    }
    i2c0.reset();

    // ------------------------ TMP117 raw ------------------------
    std.log.info("I2C temp sensor (raw writes)", .{});

    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });

    std.log.info("Writing config", .{});
    try i2c0.writev_blocking(@enumFromInt(temp_sensor_address), &.{&cbuf}, null);

    std.log.info("Reading temp", .{});
    for (0..5) |_| {
        const write_buf = [_]u8{0}; // Read temperature register
        try i2c0.writev_then_readv_blocking(@enumFromInt(temp_sensor_address), &.{&write_buf}, &.{&temp_buf}, null);
        const temp_u = std.mem.readInt(u16, &temp_buf, .big);
        const temp = @as(f32, @floatFromInt(temp_u)) * 7.8125E-3;
        std.log.info("Temp: {d:0.2}°C", .{temp});
        sleep_ms(500);
    }
    i2c0.reset();

    // ------------------------ TMP117 raw (DMA) ------------------------
    std.log.info("I2C temp sensor (raw writes w/DMA)", .{});

    try i2c0dma.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });

    std.log.info("Writing config", .{});
    try i2c0dma.write_blocking(@enumFromInt(temp_sensor_address), &cbuf, null);

    std.log.info("Reading temp", .{});
    for (0..5) |_| {
        const write_buf = [_]u8{0}; // Read temperature register
        try i2c0dma.write_then_read_blocking(@enumFromInt(temp_sensor_address), &write_buf, &temp_buf, null);
        const temp_u = std.mem.readInt(u16, &temp_buf, .big);
        const temp = @as(f32, @floatFromInt(temp_u)) * 7.8125E-3;
        std.log.info("Temp: {d:0.2}°C", .{temp});
        sleep_ms(500);
    }
    i2c0dma.reset();
}
