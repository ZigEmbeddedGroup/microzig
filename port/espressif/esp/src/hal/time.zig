const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

// NOTE: esp32c3 specific
const SYSTEM = microzig.chip.peripherals.SYSTEM;
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

pub fn enable_systimer(unit_id: u1) void {
    // This is 1 on reset, but let's set it anyway
    SYSTEM.PERIP_CLK_EN0.modify(.{
        .SYSTIMER_CLK_EN = 1,
    });
    switch (unit_id) {
        0 => SYSTIMER.CONF.modify(.{
            .TIMER_UNIT0_WORK_EN = 1,
            .CLK_EN = 1,
        }),
        1 => SYSTIMER.CONF.modify(.{
            .TIMER_UNIT1_WORK_EN = 1,
            .CLK_EN = 1,
        }),
    }
}

pub fn get_systimer_counter(unit_id: u1) u64 {
    // TODO: We need to put it somewhere else
    enable_systimer(unit_id);

    const OP: @TypeOf(&SYSTIMER.UNIT0_OP) = switch (unit_id) {
        0 => &SYSTIMER.UNIT0_OP,
        1 => @ptrCast(&SYSTIMER.UNIT1_OP),
    };
    const LO: @TypeOf(&SYSTIMER.UNIT0_VALUE_LO) = switch (unit_id) {
        0 => &SYSTIMER.UNIT0_VALUE_LO,
        1 => @ptrCast(&SYSTIMER.UNIT1_VALUE_LO),
    };
    const HI: @TypeOf(&SYSTIMER.UNIT0_VALUE_HI) = switch (unit_id) {
        0 => &SYSTIMER.UNIT0_VALUE_HI,
        1 => @ptrCast(&SYSTIMER.UNIT1_VALUE_HI),
    };

    // Set the "update" bit and wait for acknowledgment
    OP.modify(.{ .TIMER_UNIT0_UPDATE = 1 });
    while (OP.read().TIMER_UNIT0_VALUE_VALID != 1) {}
    // Read LO, HI, then LO again, check that LO returns the same value. This accounts for the case
    // when an interrupt may happen between reading HI and LO values, and this function may get
    // called from the ISR. In this case, the repeated read will return consistent values.
    var lo_start = LO.read().TIMER_UNIT0_VALUE_LO;
    while (true) {
        const lo = lo_start;
        const hi = HI.read().TIMER_UNIT0_VALUE_HI;
        lo_start = LO.read().TIMER_UNIT0_VALUE_LO;

        if (lo_start == lo) return (@as(u64, hi) << 32) | lo;
    }
}

inline fn ticks_to_us(ticks: u64) u64 {
    // 'average 16MHz ticks' based on 40MHz XTAL with 2.5 divider
    return ticks / 16;
}

fn get_time() u64 {
    return ticks_to_us(get_systimer_counter(0));
}
