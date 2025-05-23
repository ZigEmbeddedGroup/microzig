///
/// Basic timekeeping for the nRF5x series MCUs.
///
/// This module hogs TIMER0.
/// It uses CC1 as the register to read the current count from.
const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const timer = microzig.chip.peripherals.TIMER0;
// const INTERRUPT_INDEX = 0;
const READ_INDEX = 1;

var overflow_count: u32 = 0;

pub fn init() void {
    // Stop timer while we set it up
    timer.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
    defer timer.TASKS_START.write(.{ .TASKS_START = .Trigger });

    // Clear the time
    timer.TASKS_CLEAR.write(.{ .TASKS_CLEAR = .Trigger });

    timer.MODE.write(.{ .MODE = .Timer });
    timer.BITMODE.write(.{ .BITMODE = .@"32Bit" });
    // 16Mhz / 2^4 = 1MHz: us resolution
    timer.PRESCALER.write(.{ .PRESCALER = 4 });

    // TODO: Set an interrupt to fire when the timer overflows, and keep track of the count, that
    // way we get more than 2^32 us.
    // timer.INTENSET.modify(.{ .COMPARE0 = .Enabled });
    // timer.SHORTS.modify(.{ .COMPARE0_CLEAR = .Enabled });
    // timer.EVENTS_COMPARE[0].write(.{ .EVENTS_COMPARE = .NotGenerated });
}

pub fn get_time_since_boot() time.Absolute {
    // TODO: Check for overflow here? Probably want to disable interrupts, and them and clear, just
    // in case an interrupt for an overflow comes in right after we check the count.
    // Trigger a 'capture' to get the timer value copied into the corresponding CC register.
    timer.TASKS_CAPTURE[READ_INDEX].write(.{ .TASKS_CAPTURE = .Trigger });
    return @enumFromInt(@as(u64, overflow_count) << 32 | timer.CC[READ_INDEX].raw);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    std.log.info("End time is: {d}", .{@intFromEnum(end_time)});
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
