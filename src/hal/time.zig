const microzig = @import("microzig");
const TIMER = microzig.chip.peripherals.TIMER;

/// Using an enum to make it a distinct type, the underlying number is
/// time since boot in microseconds.
pub const Absolute = enum(u64) {
    _,

    pub fn from_us(us: u64) Absolute {
        return @enumFromInt(Absolute, us);
    }

    pub fn to_us(time: Absolute) u64 {
        return @intFromEnum(time);
    }

    pub fn is_reached_by(deadline: Absolute, point: Absolute) bool {
        return deadline.to_us() <= point.to_us();
    }

    pub fn is_reached(time: Absolute) bool {
        const now = get_time_since_boot();
        return time.is_reached_by(now);
    }

    pub fn diff(future: Absolute, past: Absolute) Duration {
        return Duration.from_us(future.to_us() - past.to_us());
    }

    pub fn add_duration(time: Absolute, dur: Duration) Absolute {
        return Absolute.from_us(time.to_us() + dur.to_us());
    }
};

pub const Duration = enum(u64) {
    _,

    pub fn from_us(us: u64) Duration {
        return @enumFromInt(Duration, us);
    }

    pub fn from_ms(ms: u64) Duration {
        return from_us(1000 * ms);
    }

    pub fn to_us(duration: Duration) u64 {
        return @intFromEnum(duration);
    }

    pub fn less_than(self: Duration, other: Duration) bool {
        return self.to_us() < other.to_us();
    }

    pub fn minus(self: Duration, other: Duration) Duration {
        return from_us(self.to_us() - other.to_us());
    }

    pub fn plus(self: Duration, other: Duration) Duration {
        return from_us(self.to_us() + other.to_us());
    }
};

pub fn get_time_since_boot() Absolute {
    var high_word = TIMER.TIMERAWH;

    return while (true) {
        var low_word = TIMER.TIMERAWL;
        const next_high_word = TIMER.TIMERAWH;
        if (next_high_word == high_word)
            break @enumFromInt(Absolute, @intCast(u64, high_word) << 32 | low_word);

        high_word = next_high_word;
    } else unreachable;
}

pub fn make_timeout_us(timeout_us: u64) Absolute {
    return @enumFromInt(Absolute, get_time_since_boot().to_us() + timeout_us);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = make_timeout_us(time_us);
    while (!end_time.is_reached()) {}
}
