//! Echoes back whatever arrives on the serial console of a Raspberry Pi 4B, header pins 8 and 10.

const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const uart = hal.uart;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .logFn = uart.logger.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    uart.apply(.{});

    std.log.info("echoing, type something", .{});

    while (true) {
        const byte = uart.read_byte();
        uart.write_byte(byte);

        // Terminals send a bare carriage return, add the line feed so the output stays readable.
        if (byte == '\r') uart.write_byte('\n');
    }
}
