const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO25 = .{
        .name = "led",
        .direction = .out,
    },
};

pub const microzig_options = microzig.Options{
    .interrupts = .{
        .RTC_IRQ = .{ .c = rtc_isr },
    },
};

var _fast_blink: bool = false;
/// Access underlying _sleep_time via volatile * to prevent reads from being optimized away
var fast_blink_vp: *volatile bool = &_fast_blink;

fn rtc_isr() callconv(.c) void {

    // Important to disable + re-enable the RTC alarm so that the interrupt doesn't
    // continue firing for the entire time the alarm condition is met
    // (For example, it would fire the entire second that it matches the desired "second" count)
    rp2xxx.rtc.alarm.disable();
    rp2xxx.rtc.alarm.enable();

    // Every 1 minute, alternate between fast and slow blinking
    fast_blink_vp.* = !fast_blink_vp.*;
}

pub fn main() !void {
    const pins = pin_config.apply();

    // Configure initial datetime for RTC
    rp2xxx.rtc.set_datetime(.{
        .year = 2024,
        .month = 12,
        .day = 25,
        .day_of_week = .Monday,
        .hour = 0,
        .minute = 0,
        .second = 0,
    });
    rp2xxx.rtc.apply(rp2xxx.clock_config);

    // Configure an alarm that goes off once a minute (whenever second == 0)
    rp2xxx.rtc.alarm.configure(.{ .second = 0 });

    // Enable peripheral level alarm
    rp2xxx.rtc.irq.enable();

    // Enable top level NVIC alarm
    microzig.cpu.interrupt.enable(.RTC_IRQ);

    while (true) {

        // Disable interrupts during volatile read of fast_blink to prevent data races
        microzig.cpu.interrupt.disable_interrupts();
        const fast_blink = fast_blink_vp.*;
        microzig.cpu.interrupt.enable_interrupts();

        pins.led.toggle();
        time.sleep_ms(if (fast_blink) 500 else 1000);
    }
}
