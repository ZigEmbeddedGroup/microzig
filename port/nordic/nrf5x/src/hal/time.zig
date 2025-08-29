///
/// Basic timekeeping for the nRF5x series MCUs.
///
/// This module hogs TIMER0.
/// It uses CC1 as the register to read the current count from.
/// It also sets up an interrupt to fire when the 32 bit timer overflows, so that we are able to
/// count them and keep time for centuries.
/// It does this by setting up a comparator in CC0, and configures it to fire an interrupt when this
/// happen. This interrupt handler simply increments the high value.
const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const compatibility = microzig.hal.compatibility;

const version: enum {
    nrf51,
    nrf52,
} = switch (compatibility.chip) {
    .nrf51 => .nrf51,
    .nrf52, .nrf52833, .nrf52840 => .nrf52,
    else => compatibility.unsupported_chip("time"),
};

const timer = microzig.chip.peripherals.TIMER0; // DELETEME
const rtc = microzig.chip.peripherals.RTC0;
const interrupts = microzig.chip.peripherals.interrupts;
const COMPARE_INDEX = 3;
const TIMER_BITS = 23;

// Must use @atomic to load an store from here.
var period: u32 = 0;

pub fn init() void {
    // Stop timer while we set it up
    // switch (version) {
    //     .nrf51 => {
    //         timer.TASKS_STOP = 1;
    //         defer timer.TASKS_START = 1;
    //
    //         // Clear the time
    //         timer.TASKS_CLEAR = 1;
    //
    //         timer.MODE.write(.{ .MODE = .Timer });
    //         timer.BITMODE.write(.{ .BITMODE = .@"32Bit" });
    //         // 16Mhz / 2^4 = 1MHz: us resolution
    //         timer.PRESCALER.write(.{ .PRESCALER = 4 });
    //     },
    //     .nrf52 => {
    //         timer.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
    //         defer timer.TASKS_START.write(.{ .TASKS_START = .Trigger });
    //
    //         // Clear the time
    //         timer.TASKS_CLEAR.write(.{ .TASKS_CLEAR = .Trigger });
    //
    //         timer.MODE.write(.{ .MODE = .Timer });
    //         timer.BITMODE.write(.{ .BITMODE = .@"32Bit" });
    //         // 16Mhz / 2^4 = 1MHz: us resolution
    //         timer.PRESCALER.write(.{ .PRESCALER = 4 });
    //     },
    // }

    // TODO: embassy uses RTC instead?
    // https://github.com/embassy-rs/embassy/blob/main/embassy-nrf/src/time_driver.rs
    // We only use 23 of 24 bits of the RTC to avoid a race condition where time_since_boot() is
    // called after an overflow but before we can update the high value. This means that we have to
    // increment the 'period' on two different events:
    // First, when it hits the halfway point, and again on overflow.

    // TODO: Tuck into version prong
    // Enable interrupt firing on compare AND on overflow
    rtc.INTENSET.modify(.{
        .COMPARE3 = .Enabled,
        .OVRFLW = .Enabled,
    });
    // Set the comparator to trigger on overflow of bottom 23 bits
    rtc.CC[COMPARE_INDEX].write(.{ .COMPARE = 0x800000 });

    // Clear counter, then start timer
    switch (version) {
        .nrf51 => {
            rtc.TASKS_CLEAR = 1;
            rtc.TASKS_START = 1;
        },
        .nrf52 => {
            rtc.TASKS_CLEAR.write_raw(1);
            rtc.TASKS_START.write_raw(1);
        },
    }

    // Wait for clear
    while (rtc.COUNTER.read().COUNTER != 0) {}
    // TODO: Set priority
    // Enable interrupt
    // TODO: Use an interrupt hal
    // VectorTable.RTC0 = rtc_overflow_interrupt;
}

/// Handle both overflow and compare interrupts. Update the period which acts as the high bits of
/// the elapsed time.
pub fn rtc_overflow_interrupt() callconv(.c) void {
    if (rtc.EVENTS_OVRFLW.raw == 1) {
        rtc.EVENTS_OVRFLW.raw = 0;
        next_period();
    }

    if (rtc.EVENTS_COMPARE[COMPARE_INDEX].raw == 1) {
        rtc.EVENTS_COMPARE[COMPARE_INDEX].write_raw(0);
        next_period();
    }
}

inline fn next_period() void {
    _ = @atomicRmw(u32, &period, .Add, 1, .monotonic);
}

// TODO: Rename arg to period, but it shadows the global
/// Calculate the full 56 bit value of the RTC. We have to take into account whether the period
/// counter is odd or even, flipping the top bit of the counter when it's off.
fn calc_now(p: u32, counter: u24) u64 {
    return (@as(u64, p) << TIMER_BITS) + @as(u64, counter ^ ((p & 1) << TIMER_BITS));
}

pub fn get_time_since_boot() time.Absolute {
    // TODO: Scale. This is counting ticks, which update at 32768Hz
    const p = @atomicLoad(u32, &period, .acquire);

    const counter = rtc.COUNTER.read().COUNTER;

    return @enumFromInt(calc_now(p, counter));
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}

test "tick calculations" {
    try std.testing.expectEqual(calc_now(0, 0x000000), 0x0_000000);
    try std.testing.expectEqual(calc_now(0, 0x000001), 0x0_000001);
    try std.testing.expectEqual(calc_now(0, 0x7FFFFF), 0x0_7FFFFF);
    try std.testing.expectEqual(calc_now(1, 0x7FFFFF), 0x1_7FFFFF);
    try std.testing.expectEqual(calc_now(0, 0x800000), 0x0_800000);
    try std.testing.expectEqual(calc_now(1, 0x800000), 0x0_800000);
    try std.testing.expectEqual(calc_now(1, 0x800001), 0x0_800001);
    try std.testing.expectEqual(calc_now(1, 0xFFFFFF), 0x0_FFFFFF);
    try std.testing.expectEqual(calc_now(2, 0xFFFFFF), 0x1_FFFFFF);
    try std.testing.expectEqual(calc_now(1, 0x000000), 0x1_000000);
    try std.testing.expectEqual(calc_now(2, 0x000000), 0x1_000000);
}
