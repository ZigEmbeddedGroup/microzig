const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;
const drivers = microzig.drivers;

const rtc = hal.rtc;
const time = hal.time;
const uart = hal.uart;

const DateTime = drivers.DateTime;

const uart0 = uart.instance.num(0);

const pin_config = hal.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
};


pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = uart.log,
};

pub fn main() !void {
    var buffer: [128]u8 = undefined;
    var len: usize = 0;

    _ = pin_config.apply();

    uart0.apply(.{
        .clock_config = hal.clock_config,
    });

    uart.init_logger(uart0);

    std.log.info("Hello, World!", .{});

    // In a live application this time could be read using NTP, fetched from
    // a real-time clock chip or other connected device, or input by the user.

    const epoch_time = 1747677500 * 1000;

    len = try DateTime.from_timestamp(epoch_time).to_rfc_7231(&buffer);
    std.log.info("epoch time: {s}", .{buffer[0..len]});

    // Load a time into the always on timer and start it ticking.

    rtc.set_time(epoch_time);

    // Set an alarm to fire 60 seconds from now.

    rtc.alarm.set_time(rtc.get_time() + 60 * 1000, true);

    rtc.enable();

    // Print the time every 5 seconds and check if the alarm has expired.

    std.log.info("We're going to loop with a 5 second delay.", .{});

    rtc.set_clock_source(.lposc);
    std.log.info("Note the sloppy timing with the low precision oscillator.", .{});

    var low_clock = true;

    while (true) {
        time.sleep_ms(5000);

        len = try DateTime.from_timestamp(rtc.get_time()).to_rfc_7231(&buffer);
        std.log.info("rtc time: {s}", .{buffer[0..len]});

        if (rtc.alarm.has_expired()) {
            std.log.info("*** Alarm expired! ***", .{});
            rtc.alarm.disable();
            rtc.alarm.clear_expired();

            if (low_clock) {
                // Let's switch to the crystal oscillator.

                rtc.set_clock_source(.xosc);
                std.log.info("Note the much more accurate timing with the crystal oscillator.", .{});
                low_clock = false;
            }

            // Reset the alarm for another 60 seconds from now.

            rtc.alarm.set_time(rtc.get_time() + 60 * 1000, true);
        }
    }
}
