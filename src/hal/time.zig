const microzig = @import("microzig");
const TIMER = microzig.chip.peripherals.TIMER;

/// Using an enum to make it a distinct type, the underlying number is
/// time since boot in microseconds.
pub const Absolute = enum(u64) {
    _,

    pub fn reached(time: Absolute) bool {
        const now = get_time_since_boot();
        return now.to_us() >= time.to_us();
    }

    pub fn to_us(time: Absolute) u64 {
        return @enumToInt(time);
    }
};

pub fn get_time_since_boot() Absolute {
    var high_word = TIMER.TIMERAWH;

    return while (true) {
        var low_word = TIMER.TIMERAWL;
        const next_high_word = TIMER.TIMERAWH;
        if (next_high_word == high_word)
            break @intToEnum(Absolute, @intCast(u64, high_word) << 32 | low_word);

        high_word = next_high_word;
    } else unreachable;
}

pub fn make_timeout_us(timeout_us: u64) Absolute {
    return @intToEnum(Absolute, get_time_since_boot().to_us() + timeout_us);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = make_timeout_us(time_us);
    while (!end_time.reached()) {}
}
