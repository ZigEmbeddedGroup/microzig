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

pub const microzig_options = .{
    .interrupts = .{
        .RTC_IRQ = .{ .C = &rtc_isr },
    },
};

/// Enables/disables interrupts to prevent data-races with variables
/// shared between ISRs and normal code
///
/// TODO: microzig/core/src/interrupt.zig might provide a more general implementation
///       for this in the future.
const CriticalSection = struct {
    isr_reg_value: usize = 0,

    pub fn enter(self: *CriticalSection) void {
        var val: usize = undefined;
        asm volatile (
            \\mrs   %[val], primask
            \\movs  r1, #1
            \\msr   primask, r1
            : [val] "=r" (val),
            :
            : "r1", "cc"
        );
        self.isr_reg_value = val;
    }

    pub fn exit(self: *CriticalSection) void {
        const val = self.isr_reg_value;
        asm volatile ("msr   primask, %[val]"
            :
            : [val] "r" (val),
        );
    }
};
var critical_section: CriticalSection = .{};

var _fast_blink: bool = false;
/// Access underlying _sleep_time via volatile * to prevent reads from being optimized away
var fast_blink_vp: *volatile bool = &_fast_blink;

fn rtc_isr() callconv(.C) void {

    // Important to disable + re-enable the RTC alarm so that the interrupt doesn't
    // continue firing for the entire time the alarm condition is met
    // (For example, it would fire the entire second that it matches the desired "second" count)
    rp2xxx.rtc.alarm.disable();
    rp2xxx.rtc.alarm.enable();

    // Every 1 minute, alternate between fast and slow blinking
    critical_section.enter();
    fast_blink_vp.* = !fast_blink_vp.*;
    critical_section.exit();
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
    rp2xxx.irq.enable(.RTC_IRQ);

    while (true) {

        // Disable interrupts during volatile read of fast_blink to prevent data races
        critical_section.enter();
        const fast_blink = fast_blink_vp.*;
        critical_section.exit();

        pins.led.toggle();
        time.sleep_ms(if (fast_blink) 500 else 1000);
    }
}
