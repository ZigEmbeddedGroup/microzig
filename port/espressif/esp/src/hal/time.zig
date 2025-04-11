const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

// NOTE: esp32c3 specific
const SYSTIMER = microzig.chip.peripherals.SYSTIMER;

pub fn get_time_since_boot() time.Absolute {
    return @enumFromInt(get_time());
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}

fn get_systimer_counter(counter_id: u32) u64 {
    // TODO: We need to put it somewhere else
    SYSTIMER.CONF.modify(.{
        .TIMER_UNIT0_WORK_EN = 1,
        .CLK_EN = 1,
    });

    // TODO: Support using the other unit
    _ = counter_id;
    const OP = &SYSTIMER.UNIT0_OP;
    const LO = &SYSTIMER.UNIT0_VALUE_LO;
    const HI = &SYSTIMER.UNIT0_VALUE_HI;

    var lo: u32 = 1; // Make it not match for now in case lo_start raeds as 0
    var lo_start: u32 = 0;
    var hi: u20 = 0;
    // Set the "update" bit and wait for acknowledgment
    OP.modify(.{ .TIMER_UNIT0_UPDATE = 1 });
    while (OP.read().TIMER_UNIT0_VALUE_VALID != 1) {}
    // Read LO, HI, then LO again, check that LO returns the same value.
    // This accounts for the case when an interrupt may happen between reading
    // HI and LO values, and this function may get called from the ISR.
    // In this case, the repeated read will return consistent values.
    lo_start = LO.read().TIMER_UNIT0_VALUE_LO; // 32 bits
    while (lo_start != lo) {
        lo = lo_start;
        hi = HI.read().TIMER_UNIT0_VALUE_HI; // 20 bits
        lo_start = LO.read().TIMER_UNIT0_VALUE_LO;
    }

    return (@as(u64, hi) << 32) | lo;
}

inline fn ticks_to_us(ticks: u64) u64 {
    // TODO: Use clock
    // 'average 16MHz ticks' based on 40MHz XTAL with 2.5 divider
    return ticks / 16;
}

fn get_time() u64 {
    return ticks_to_us(get_systimer_counter(0));
}
