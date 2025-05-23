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

const timer = microzig.chip.peripherals.TIMER0;
// const INTERRUPT_INDEX = 0;
const READ_INDEX = 1;

var overflow_count: u32 = 0;

pub fn init() void {
    // Stop timer while we set it up
    switch (version) {
        .nrf51 => {
            timer.TASKS_STOP = 1;
            defer timer.TASKS_START = 1;

            // Clear the time
            timer.TASKS_CLEAR = 1;

            timer.MODE.write(.{ .MODE = .Timer });
            timer.BITMODE.write(.{ .BITMODE = .@"32Bit" });
            // 16Mhz / 2^4 = 1MHz: us resolution
            timer.PRESCALER.write(.{ .PRESCALER = 4 });
        },
        .nrf52 => {
            timer.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
            defer timer.TASKS_START.write(.{ .TASKS_START = .Trigger });

            // Clear the time
            timer.TASKS_CLEAR.write(.{ .TASKS_CLEAR = .Trigger });

            timer.MODE.write(.{ .MODE = .Timer });
            timer.BITMODE.write(.{ .BITMODE = .@"32Bit" });
            // 16Mhz / 2^4 = 1MHz: us resolution
            timer.PRESCALER.write(.{ .PRESCALER = 4 });
        },
    }

    // TODO: Set an interrupt to fire when the timer overflows, and keep track of the count, that
    // way we get more than 2^32 us.
    // Set the comparator to trigger on overflow
    // timer.CC[INTERRUPT_INDEX].write(.{ .CC = 0xFFFFFFFF });
    // Enable interrupt firing
    // timer.INTENSET.modify(.{ .COMPARE0 = .Enabled });
    // Automatically clear the event on trigger
    // timer.SHORTS.modify(.{ .COMPARE0_CLEAR = .Enabled });
    // Clear events
    // timer.EVENTS_COMPARE[INTERRUPT_INDEX].write(.{ .EVENTS_COMPARE = .NotGenerated });
}

pub fn get_time_since_boot() time.Absolute {
    switch (version) {
        .nrf51 => {
            timer.TASKS_CAPTURE[READ_INDEX] = 1;
            return @enumFromInt(@as(u64, overflow_count) << 32 | timer.CC[READ_INDEX]);
        },
        .nrf52 => {
            timer.TASKS_CAPTURE[READ_INDEX].write(.{ .TASKS_CAPTURE = .Trigger });
            return @enumFromInt(@as(u64, overflow_count) << 32 | timer.CC[READ_INDEX].raw);
        },
    }
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
