const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;
const cpu = rp2xxx.compatibility.cpu;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
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
    .logFn = rp2xxx.uart.logFn,
};

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    switch (cpu) {
        .RP2040 => inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
            pin.set_function(.uart);
        },
        .RP2350 => inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
            pin.set_function(.uart_second);
        },
    }

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    var i: u32 = 0;
    while (true) : (i += 1) {
        led.put(1);
        std.log.info("what {}", .{i});
        time.sleep_ms(500);

        led.put(0);
        time.sleep_ms(500);
    }
}
