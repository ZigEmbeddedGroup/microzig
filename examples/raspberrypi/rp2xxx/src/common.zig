const std = @import("std");
const microzig = @import("microzig");
const options = @import("options");

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;

pub const log = switch (options.logger) {
    .uart => rp2xxx.uart.log,
    .rtt => rtt_log,
};

pub const init_logger = switch (options.logger) {
    .uart => init_uart_logger,
    .rtt => init_rtt_logger,
};

// UART
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub fn init_uart_logger() void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);
}

// RTT
const rtt = microzig.cpu.rtt;
const time = rp2xxx.time;

// Configure RTT with all default settings:
const rtt_instance = rtt.RTT(.{});
var rtt_logger: ?rtt_instance.Writer = null;

pub fn init_rtt_logger() void {
    rtt_instance.init();
    rtt_logger = rtt_instance.writer(0, &.{});
}

pub fn rtt_log(
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
    if (rtt_logger) |*writer| {
        const current_time = time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;
        writer.interface.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
        // Don't forget to flush! This never returns an error with how the Writer interface is implemented
        // so unreachable is appropriate here.
        writer.interface.flush() catch unreachable;
    }
}
