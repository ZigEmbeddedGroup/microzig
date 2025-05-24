const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;
const nrf = microzig.hal;

const gpio = nrf.gpio;
const i2c = nrf.i2c;

const uart = nrf.uart.num(0);
const i2c0 = i2c.num(0);

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
        // .control_flow = .{
        //     .cts_pin = board.uart_cts,
        //     .rts_pin = board.uart_rts,
        // },
        .baud_rate = .@"115200",
    });

    nrf.uart.init_logger(uart);

    // ------------------------ BUS SCAN ------------------------
    // std.log.info("I2C bus scan", .{});
    //
    // try i2c0.apply(.{
    //     .scl_pin = gpio.num(0, 9),
    //     .sda_pin = gpio.num(0, 10),
    // });
    // for (0..std.math.maxInt(u7)) |addr| {
    //     const a: i2c.Address = @enumFromInt(addr);
    //     std.log.info("Trying {}", .{@intFromEnum(a)});
    //
    //     var rx_data: [1]u8 = undefined;
    //     _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(100)) catch continue;
    //
    //     std.log.info("I2C device found at address {X}.", .{addr});
    // }

    // ------------------------ TMP117 w/ driver & datagram_device ------------------------
    // std.log.info("I2C temp sensor", .{});
    //
    // try i2c0.apply(.{
    //     .scl_pin = gpio.num(0, 9),
    //     .sda_pin = gpio.num(0, 10),
    // });
    // var i2c_device = nrf.drivers.I2C_Device.init(i2c0, @enumFromInt(0x48));
    //
    // const temp_sensor = try microzig.drivers.sensor.TMP117.init(i2c_device.datagram_device());
    // try temp_sensor.write_configuration(.{});
    //
    // const id = try temp_sensor.read_device_id();
    // std.log.info("ID: {any}", .{id});
    //
    // while (true) {
    //     const temp = try temp_sensor.read_temperature();
    //     std.log.info("Temp: {d:0.2}°C", .{temp});
    //     sleep_ms(500);
    // }

    // ------------------------ TMP117 raw ------------------------
    std.log.info("I2C temp sensor", .{});

    try i2c0.apply(.{
        .scl_pin = gpio.num(0, 9),
        .sda_pin = gpio.num(0, 10),
    });
    const address = 0x48;
    const config = packed struct {
        reserved0: u1 = 0,
        Soft_Reset: bool = false,
        DR: u1 = 0,
        POL: u1 = 0,
        TNA: u1 = 0,
        AVG: u2 = 0,
        CONV: u3 = 0,
        MOD: u2 = 0,
        EEPROM_BUSY: bool = false,
        Data_Ready: bool = false,
        LOW_Alert: bool = false,
        HIGH_Alert: bool = false,
    }{};
    try i2c0.writev_blocking(
        @enumFromInt(address),
        &.{&@as([2]u8, @bitCast(std.mem.nativeToBig(u16, @bitCast(config))))},
        null,
    );
    var buf: [2]u8 = undefined;
    while (true) {
        const temp_u = std.mem.readInt(u16, &buf, .big);
        const temp = @as(f32, @floatFromInt(temp_u)) * 7.8125E-3;
        const write_buf = [_]u8{0};
        try i2c0.writev_then_readv_blocking(@enumFromInt(address), &.{&write_buf}, &.{&buf}, null);
        std.log.info("Temp: {d:0.2}°C", .{temp});
        sleep_ms(500);
    }

    // now echo any bytes sent
    // var buf: [1]u8 = undefined;
    // while (true) {
    //     uart.read_blocking(&buf);
    //     uart.write_blocking(buf[0..]);
    // }
}
