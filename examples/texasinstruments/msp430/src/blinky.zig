const std = @import("std");
const microzig = @import("microzig");
const watchdog = microzig.hal.watchdog;
const launchpad = microzig.board;
const green_led = launchpad.green_led;

pub const panic = std.debug.no_panic;

pub fn main() void {
    watchdog.disable();
    green_led.set_direction(.output);

    while (true) {
        green_led.toggle();
    }
}
