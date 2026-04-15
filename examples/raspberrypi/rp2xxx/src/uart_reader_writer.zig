const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub const microzig_options: microzig.Options = .{
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    uart_tx_pin.set_function(.uart);
    uart_rx_pin.set_function(.uart);

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
        .baud_rate = 115_200,
    });
    rp2xxx.uart.init_logger(uart, &.{});

    var read_buf: [32]u8 = undefined;
    var reader = uart.reader(&read_buf, .no_deadline);

    var write_buf: [32]u8 = undefined;
    var writer = uart.writer(&write_buf, .no_deadline);

    var i: u32 = 0;
    while (true) : (i += 1) {
        // Read one line
        const secret_text = (try reader.interface.takeDelimiter('\r')) orelse continue;

        // Split the line into words
        var words = std.mem.splitScalar(u8, std.mem.trim(u8, secret_text, &.{ '\r', '\n' }), ' ');

        // Output each word
        while (words.next()) |word| {
            try writer.interface.print("Word: {s}\n\r", .{word});
        }

        // Don't forget to flush
        try writer.interface.flush();

        // Toggle the led after each written line
        led.toggle();
    }
}
