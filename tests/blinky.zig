const std = @import("std");
const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

// Configures the led_pin to a hardware pin
const led_pin = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"Arduino Nano" => micro.Pin("D13"),
        .@"mbed LPC1768" => micro.Pin("LED-1"),
        .@"Raspberry Pi Pico" => micro.Pin("LED"),
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .@"ATmega328p" => micro.Pin("PB5"),
    .@"NXP LPC1768" => micro.Pin("P1.18"),
    .@"Raspberry Pi RP2040" => micro.Pin("GPIO25"),
    else => @compileError("unknown chip"),
};

pub fn main() void {
    micro.reset(.{.gpio});
    led_pin.route(.gpio);

    const led = micro.Gpio(led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    while (true) {
        busyloop();
        led.toggle();
    }
}

fn busyloop() void {
    const limit = 100_000;

    var i: u24 = 0;
    while (i < limit) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}
