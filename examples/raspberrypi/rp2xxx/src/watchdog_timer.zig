const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const watchdog = rp2xxx.watchdog;
const time = rp2xxx.time;

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO25 = .{
        .name = "led",
        .direction = .out,
    },
};
pub fn main() !void {
    const pins = pin_config.apply();

    // Set up different blinking behavior if this reset was due to a WD trip
    const wd_reset: bool = if (watchdog.caused_reboot()) |_|
        true
    else
        false;

    watchdog.apply(.{
        // Set up the watchdog timer to trip after 1 second
        .duration_us = 1000 * 1000,
        // Watchdog timer should NOT trip if a debugger is connected
        // NOTE: This doesn't appear to work with a JLink, your mileage may vary
        .pause_during_debug = true,
    });

    var blink_time: usize = 100;
    var fast_counter: usize = 0;

    // Slowly decrease blink frequency until a watchdog reset is triggered from waiting too long between watchdog.update() calls
    while (true) {

        // "null" uses whatever the previously configured timeout period for the watchdog was
        watchdog.update(null);
        pins.led.toggle();
        time.sleep_ms(@as(usize, @intCast(blink_time)));

        // 10 fast blinks to start if the WD caused reset
        if (wd_reset and fast_counter < 10) {
            fast_counter += 1;
        } else {
            blink_time += 100;
        }
    }
}
