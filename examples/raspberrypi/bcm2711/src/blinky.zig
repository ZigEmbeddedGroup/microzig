//! Blinks an led on header pin 40 of a Raspberry Pi 4B and logs over the serial console on
//! header pins 8 and 10.
//!
//! The green ACT led of a Pi 4B hangs off the VideoCore gpio expander rather than a BCM gpio, so
//! it cannot be driven from here. Put an led and a resistor between header pin 40 and a ground
//! pin, pin 39 for example.

const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const hal = microzig.hal;
const gpio = hal.gpio;
const time = hal.time;
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

    const led = board.header.pin40;
    led.apply(.{ .function = .output });

    std.log.info("Hello from a Raspberry Pi 4B, running at EL{}", .{microzig.cpu.current_el()});
    std.log.info("generic timer runs at {} Hz", .{microzig.cpu.counter_frequency()});

    var on: u1 = 0;
    while (true) {
        on ^= 1;
        led.put(on);

        std.log.info("led {s}", .{if (on == 1) "on" else "off"});
        time.sleep_ms(500);
    }
}
