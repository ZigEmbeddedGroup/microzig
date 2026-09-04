//! Timekeeping off the ARM generic timer.
//!
//! The BCM2711 also has the legacy 1 MHz system timer at 0xFE003000, but the generic timer is a
//! cpu register read, needs no peripheral setup and is not shared with the VideoCore.

const microzig = @import("microzig");
const cpu = microzig.cpu;
const time = microzig.drivers.time;

/// Ticks of the generic timer per microsecond. The firmware runs the counter at 54 MHz on a
/// Raspberry Pi 4, but it is read from CNTFRQ_EL0 rather than assumed.
pub fn ticks_per_us() u64 {
    return cpu.counter_frequency() / 1_000_000;
}

pub fn get_time_since_boot() time.Absolute {
    return @fromBackingInt(cpu.counter() / ticks_per_us());
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(@as(u64, time_ms) * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
