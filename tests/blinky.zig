const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

// Configures the led_pin to a hardware pin
const led_pin = switch (@import("builtin").cpu.arch) {
    .avr => if (micro.config.has_board)
        micro.Pin("D13")
    else
        micro.Pin("PB5"),
    .arm => if (micro.config.has_board)
        micro.Pin("LED-1")
    else
        micro.Pin("P1.18"),
    else => @compileError("Unsupported platform!"),
};

pub fn main() void {
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
    var i: u24 = 0;
    while (i < 100_000) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}
