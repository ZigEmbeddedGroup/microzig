//! Example that generates a 4 byte random number every second and outputs the result over UART

const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const flash = rp2040.flash;
const time = rp2040.time;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;
const rand = rp2040.rand;

const led = gpio.num(25);
const uart = rp2040.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = .{
    .log_level = .debug,
    .logFn = rp2040.uart.logFn,
};

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2040.clock_config,
    });

    var ascon = rand.Ascon.init();
    var rng = ascon.random();

    rp2040.uart.init_logger(uart);

    var buffer: [8]u8 = undefined;
    var dist: [256]usize = .{0} ** 256;
    var counter: usize = 0;

    while (true) {
        rng.bytes(buffer[0..]);
        counter += 8;
        for (buffer) |byte| {
            dist[@as(usize, @intCast(byte))] += 1;
        }
        std.log.info("Generate random number: {any}", .{buffer});

        if (counter % 256 == 0) {
            var i: usize = 0;
            std.log.info("Distribution:", .{});
            while (i < 256) : (i += 1) {
                std.log.info("{} -> {}, {d:2}%", .{ i, dist[i], @as(f32, @floatFromInt(dist[i])) / @as(f32, @floatFromInt(counter)) });
            }
        }
        time.sleep_ms(1000);
    }
}
