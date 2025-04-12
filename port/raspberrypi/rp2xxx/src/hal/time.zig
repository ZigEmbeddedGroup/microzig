const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const chip = @import("compatibility.zig").chip;
const TIMER = @field(
    microzig.chip.peripherals,
    switch (chip) {
        .RP2040 => "TIMER",
        RP2350, .RP2350_QFN80 => "TIMER0",
    },
);

pub fn get_time_since_boot() time.Absolute {
    var high_word = TIMER.TIMERAWH.read().TIMERAWH;

    return while (true) {
        const low_word = TIMER.TIMERAWL.read().TIMERAWL;
        const next_high_word = TIMER.TIMERAWH.read().TIMERAWH;
        if (next_high_word == high_word)
            break @as(time.Absolute, @enumFromInt(@as(u64, @intCast(high_word)) << 32 | low_word));

        high_word = next_high_word;
    } else unreachable;
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
