const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const systimer = @import("systimer.zig");

pub fn init() void {
    systimer.unit(0).apply(.enabled);
}

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

fn get_time() u64 {
    return systimer.unit(0).read() / systimer.ticks_per_us();
}
