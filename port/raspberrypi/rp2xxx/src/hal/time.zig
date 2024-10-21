const std = @import("std");
const microzig = @import("microzig");

const cpu = @import("compatibility.zig").cpu;
const TIMER = @field(
    microzig.chip.peripherals,
    switch (cpu) {
        .RP2040 => "TIMER",
        .RP2350 => "TIMER0",
    },
);

///
/// An absolute point in time since the startup of the device.
///
/// NOTE: Using an enum to make it a distinct type, the underlying number is
///       time since boot in microseconds.
///
pub const Absolute = enum(u64) {
    _,

    pub fn from_us(us: u64) Absolute {
        return @as(Absolute, @enumFromInt(us));
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

///
/// A duration with microsecond precision.
///
/// NOTE: Using an `enum` type here prevents type confusion with other
///       related or unrelated integer-like types.
///
pub const Duration = enum(u64) {
    _,

    pub fn from_us(us: u64) Duration {
        return @as(Duration, @enumFromInt(us));
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

///
/// The deadline construct is a construct to create optional timeouts.
///
/// NOTE: Deadlines use maximum possible `Absolute` time for
///       marking the deadline as "unreachable", as this would mean the device
///       would ever reach an uptime of over 500.000 years.
///
pub const Deadline = struct {
    const disabled_sentinel = Absolute.from_us(std.math.maxInt(u64));

    timeout: Absolute,

    /// Create a new deadline with an absolute end point.
    ///
    /// NOTE: `abs` must not point to the absolute maximum time stamp, as this is
    ///       used as a sentinel for "unset" deadlines.
    pub fn init_absolute(abs: ?Absolute) Deadline {
        if (abs) |a|
            std.debug.assert(a != disabled_sentinel);
        return .{ .timeout = abs orelse disabled_sentinel };
    }

    /// Create a new deadline with a certain duration from now on.
    pub fn init_relative(dur: ?Duration) Deadline {
        return init_absolute(if (dur) |d|
            make_timeout(d)
        else
            null);
    }

    /// Returns `true` if the deadline can be reached.
    pub fn can_be_reached(deadline: Deadline) bool {
        return (deadline.timeout != disabled_sentinel);
    }

    /// Returns `true` if the deadline is reached.
    pub fn is_reached(deadline: Deadline) bool {
        return deadline.can_be_reached() and deadline.timeout.is_reached();
    }

    /// Checks if the deadline is reached and returns an error if so,
    pub fn check(deadline: Deadline) error{Timeout}!void {
        if (deadline.is_reached())
            return error.Timeout;
    }
};

pub fn get_time_since_boot() Absolute {
    var high_word = TIMER.TIMERAWH.read().TIMERAWH;

    return while (true) {
        const low_word = TIMER.TIMERAWL.read().TIMERAWL;
        const next_high_word = TIMER.TIMERAWH.read().TIMERAWH;
        if (next_high_word == high_word)
            break @as(Absolute, @enumFromInt(@as(u64, @intCast(high_word)) << 32 | low_word));

        high_word = next_high_word;
    } else unreachable;
}

pub fn make_timeout(timeout: Duration) Absolute {
    return @as(Absolute, @enumFromInt(get_time_since_boot().to_us() + timeout.to_us()));
}

pub fn make_timeout_us(timeout_us: u64) Absolute {
    return @as(Absolute, @enumFromInt(get_time_since_boot().to_us() + timeout_us));
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = make_timeout_us(time_us);
    while (!end_time.is_reached()) {}
}
