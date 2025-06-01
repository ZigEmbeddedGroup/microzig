//! Example that generates a 4 byte random number every second and outputs the result over UART

const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;
const rand = rp2xxx.rand;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    var ascon = rand.Ascon.init();
    var rng = ascon.random();

    var buffer: [8]u8 = undefined;
    var dist: [256]usize = @splat(0);
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
