const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;
const peripherals = microzig.chip.peripherals;

const BUF_LEN = 0x100;
const spi = rp2xxx.spi.instance.SPI0;
const led = gpio.num(14);

const rtt = @import("rtt");
const rtt_instance = rtt.RTT(.{});
var rtt_logger: ?rtt_instance.Writer = null;
pub fn log(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const level_prefix = comptime "[{}.{:0>6}] " ++ level.asText();
    const prefix = comptime level_prefix ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (rtt_logger) |writer| {
        const current_time = time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;

        writer.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
    }
}
pub const microzig_options = .{
    .log_level = .debug,
    .logFn = log,
};
// Communicate with another RP2040 over spi
// No device implementation yet in Zig, see Rpi Pico SDK for an example: https://github.com/raspberrypi/pico-examples/blob/master/spi/spi_master_slave/spi_slave/spi_slave.c
pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    // >>RTT logging
    rtt_instance.init();
    rtt_logger = rtt_instance.writer(0);
    std.log.info("Hello in spi master\n", .{});
    // <<RTT logging

    // Note that CSN pin is manually controlled here rather than by the SPI peripheral.
    // If CSN is configured to "SPI" function, it will get toggled after every data packet by the RP2040's
    // SPI peripheral which is problematic for certain chips. It's generally easier to just toggle it
    // manually before/after every transaction.
    const csn = rp2xxx.gpio.num(1);
    csn.set_function(.sio);
    csn.set_direction(.out);
    csn.put(1);

    // These will change depending on which GPIO pins you have your SPI device routed to
    const hodi = rp2xxx.gpio.num(3);
    const hido = rp2xxx.gpio.num(4);
    const sck = rp2xxx.gpio.num(2);
    inline for (&.{ hodi, hido, sck }) |pin| {
        pin.set_function(.spi);
    }

    // 8 bit data words
    try spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .data_width = .eight,
    });
    var out_buf_eight: [BUF_LEN]u8 = .{ 'h', 'e', 'l', 'o' } ** (BUF_LEN / 4);
    // var out_buf_eight: [BUF_LEN]u8 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    // var in_buf_eight: [BUF_LEN]u8 = undefined;
    csn.put(0);
    spi.write_blocking(u8, &out_buf_eight);
    csn.put(1);

    // // 12 bit data words
    // try spi.apply(.{
    //     .clock_config = rp2xxx.clock_config,
    //     .data_width = .twelve,
    // });
    // // var out_buf_twelve: [BUF_LEN]u12 = .{ 0xAA, 0xBB, 0xCC, 0xDD } ** (BUF_LEN / 4);
    // var out_buf_twelve: [BUF_LEN]u12 = .{ 'h', 'e', 'l', 'o' } ** (BUF_LEN / 4);
    // var in_buf_twelve: [BUF_LEN]u12 = undefined;
    // csn.put(0);
    // spi.transceive_blocking(u12, &out_buf_twelve, &in_buf_twelve);
    // csn.put(1);

    // Back to 8 bit mode
    try spi.apply(.{
        .clock_config = rp2xxx.clock_config,
        .data_width = .eight,
    });
    while (true) {
        led.put(1);
        csn.put(0);
        std.log.info("Sending some data\n", .{});
        spi.write_blocking(u8, &out_buf_eight);
        time.sleep_ms(1 * 500);
        csn.put(1);
        led.put(0);
        time.sleep_ms(1 * 500);
    }
}
