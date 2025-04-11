const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

// NOTE: esp32c3 specific
const SYSTIMER = microzig.chip.peripherals.SYSTIMER;

pub fn get_time_since_boot() time.Absolute {
    const t = get_time();
    return @enumFromInt(t);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const now = get_time_since_boot();
    std.log.info("Now: {any}", .{now});
    const end_time = time.make_timeout_us(now, time_us);
    std.log.info("End time: {any}", .{end_time});
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}

// uint64_t systimer_hal_get_counter_value(systimer_hal_context_t *hal, uint32_t counter_id)
fn get_systimer_counter(counter_id: u32) u64 {
    // TODO: If needed, we need to put it somewhere else
    SYSTIMER.CONF.modify(.{
        // .TARGET0_WORK_EN = 1,
        .TIMER_UNIT0_WORK_EN = 1,
        .CLK_EN = 1,
    });
    // TODO: Support using the other unit
    _ = counter_id;
    const OP = &SYSTIMER.UNIT0_OP;
    const LO = &SYSTIMER.UNIT0_VALUE_LO;
    // const LO = &SYSTIMER.UNIT0_LOAD_LO;
    const HI = &SYSTIMER.UNIT0_VALUE_HI;
    // const HI = &SYSTIMER.UNIT0_LOAD_HI;
    // TODO: this doesn't work well because the fields also have the id in the name
    // switch (counter_id) {
    //     0 => {
    //         const OP = SYSTIMER.UNIT0_OP;
    //         const LO = SYSTIMER.UNIT0_LOAD_LO;
    //         const HI = SYSTIMER.UNIT0_LOAD_HI;
    //     },
    //     1 => {
    //         const OP = SYSTIMER.UNIT1_OP;
    //         const LO = SYSTIMER.UNIT1_LOAD_LO;
    //         const HI = SYSTIMER.UNIT1_LOAD_HI;
    //     },
    //     _ => unreachable,
    // }
    // counter_id is 0 or 1, for which unit
    // uint32_t lo, lo_start, hi;
    var lo: u32 = 1; // Make it not match for now in case lo_start raeds as 0
    var lo_start: u32 = 0;
    var hi: u20 = 0;
    // /* Set the "update" bit and wait for acknowledgment */
    OP.modify(.{ .TIMER_UNIT0_UPDATE = 1 });
    // systimer_ll_counter_snapshot(hal->dev, counter_id);
    while (OP.read().TIMER_UNIT0_VALUE_VALID != 1) {}
    // while (!systimer_ll_is_counter_value_valid(hal->dev, counter_id));
    // /* Read LO, HI, then LO again, check that LO returns the same value.
    //  * This accounts for the case when an interrupt may happen between reading
    //  * HI and LO values, and this function may get called from the ISR.
    //  * In this case, the repeated read will return consistent values.
    //  */
    lo_start = LO.read().TIMER_UNIT0_VALUE_LO; // 32 bits
    // lo_start = LO.read().TIMER_UNIT0_LOAD_LO; // 32 bits
    // lo_start = systimer_ll_get_counter_value_low(dev, counter_id);
    while (lo_start != lo) {
        // do {
        lo = lo_start;
        // hi = systimer_ll_get_counter_value_high(dev, counter_id);
        hi = HI.read().TIMER_UNIT0_VALUE_HI; // 20 bits
        // hi = HI.read().TIMER_UNIT0_LOAD_HI; // 20 bits
        // lo_start = systimer_ll_get_counter_value_low(counter_id);
        lo_start = LO.read().TIMER_UNIT0_VALUE_LO;
        // lo_start = LO.read().TIMER_UNIT0_LOAD_LO;
        // } while (lo_start != lo);
    }

    return (@as(u64, hi) << 32) | lo;
    // systimer_counter_value_t result = {
    //     .lo = lo,
    //     .hi = hi
    // };
    //
    // return result.val;
}

inline fn ticks_to_us(ticks: u64) u64 {
    // TODO: Use clock
    // 'average 16MHz ticks' based on 40MHz XTAL with 2.5 divider
    return ticks / 16;
}

fn get_time() u64 {
    // uint64_t systimer_hal_get_time(systimer_hal_context_t *hal, uint32_t counter_id)
    // return hal->ticks_to_us(systimer_hal_get_counter_value(hal, counter_id));
    const c = get_systimer_counter(0);
    // std.log.info("Systimer: {}", .{c});
    return ticks_to_us(c);
}
