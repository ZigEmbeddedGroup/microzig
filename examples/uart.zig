const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const time = rp2040.time;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;

const led = 25;
const uart_id = 0;
const baud_rate = 115200;
const uart_tx_pin = 0;
const uart_rx_pin = 1;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const std_options = struct {
    pub const log_level = .debug;
    pub const logFn = rp2040.uart.log;
};

pub fn main() !void {
    gpio.reset();
    gpio.init(led);
    gpio.set_direction(led, .out);
    gpio.put(led, 1);

    const uart = rp2040.uart.UART.init(uart_id, .{
        .baud_rate = baud_rate,
        .tx_pin = uart_tx_pin,
        .rx_pin = uart_rx_pin,
        .clock_config = rp2040.clock_config,
    });

    rp2040.uart.init_logger(uart);

    var i: u32 = 0;
    while (true) : (i += 1) {
        gpio.put(led, 1);
        std.log.info("what {}", .{i});
        time.sleep_ms(500);

        gpio.put(led, 0);
        time.sleep_ms(500);
    }
}
