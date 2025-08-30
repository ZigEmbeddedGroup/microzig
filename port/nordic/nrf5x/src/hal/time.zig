///
/// Basic timekeeping for the nRF5x series MCUs.
///
/// This module uses RTC0 and hogs CC[3]
/// It also sets up an interrupt to fire at certain values so that we are able to count them and
/// keep time for centuries.
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
/// Stored the high bits of the current time, giving us 55 (23+32) instead of just 24 bits
pub var period: u32 = 0;

pub fn init() void {
    // We only use 23 of 24 bits of the RTC to avoid a race condition where time_since_boot() is
    // called during an overflow, where we read the high bits, then an overflow occurs, then we read
    // the low bits, which overlowed and would be near 0. This means that we have to increment the
    // 'period' on two different events:
    // First, when it hits the halfway point, and again on overflow.

    // TODO: Put this in clocks hal
    // Set clock source
    microzig.chip.peripherals.CLOCK.LFCLKSRC.modify(.{ .SRC = .RC });
    // Start LFCLK
    microzig.chip.peripherals.CLOCK.TASKS_LFCLKSTART.write_raw(1);
    microzig.cpu.interrupt.enable(.RTC0);
    microzig.cpu.interrupt.enable_interrupts();
    // microzip.cpu

    // Enable interrupt firing on compare AND on overflow
    rtc.INTENSET.write_raw(0x00080002);
    // rtc.INTENSET.modify(.{
    //     // .TICK = .Enabled, // This triggers!
    //     .COMPARE3 = .Enabled,
    //     .OVRFLW = .Enabled,
    // });
    // Set the comparator to trigger on overflow of bottom 23 bits
    rtc.CC[COMPARE_INDEX].write(.{ .COMPARE = 0x8000 }); // DELETEME Just to not have to wait too
    // long for the interrupt to fire
    // rtc.CC[COMPARE_INDEX].write(.{ .COMPARE = 0x800000 });

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
        std.log.info("overflow!", .{}); // DELETEME
        next_period();
    }

    if (rtc.EVENTS_COMPARE[COMPARE_INDEX].raw == 1) {
        rtc.EVENTS_COMPARE[COMPARE_INDEX].write_raw(0);
        std.log.info("compare!", .{}); // DELETEME
        next_period();
    }
    @panic("lol");
}

inline fn next_period() void {
    _ = @atomicRmw(u32, &period, .Add, 1, .monotonic);
}

/// Calculate the full 55 bit value of the RTC. We have to take into account whether the period
/// counter is odd or even, flipping the top bit of the counter when it's off.
fn calc_ticks(p: u32, counter: u24) u64 {
    return (@as(u64, p) << TIMER_BITS) + @as(u64, counter ^ ((p & 1) << TIMER_BITS));
}

pub fn get_time_since_boot() time.Absolute {
    const p = @atomicLoad(u32, &period, .acquire);
    const counter = rtc.COUNTER.read().COUNTER;
    const ticks = calc_ticks(p, counter);
    // RTC updates at 32768 hertz, so we can just multiply by 1M, then shift 15
    return @enumFromInt((ticks * 1_000_000) >> 15);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}

test "tick calculations" {
    try std.testing.expectEqual(calc_ticks(0, 0x000000), 0x0_000000);
    try std.testing.expectEqual(calc_ticks(0, 0x000001), 0x0_000001);
    try std.testing.expectEqual(calc_ticks(0, 0x7FFFFF), 0x0_7FFFFF);
    try std.testing.expectEqual(calc_ticks(1, 0x7FFFFF), 0x1_7FFFFF);
    try std.testing.expectEqual(calc_ticks(0, 0x800000), 0x0_800000);
    try std.testing.expectEqual(calc_ticks(1, 0x800000), 0x0_800000);
    try std.testing.expectEqual(calc_ticks(1, 0x800001), 0x0_800001);
    try std.testing.expectEqual(calc_ticks(1, 0xFFFFFF), 0x0_FFFFFF);
    try std.testing.expectEqual(calc_ticks(2, 0xFFFFFF), 0x1_FFFFFF);
    try std.testing.expectEqual(calc_ticks(1, 0x000000), 0x1_000000);
    try std.testing.expectEqual(calc_ticks(2, 0x000000), 0x1_000000);
}
