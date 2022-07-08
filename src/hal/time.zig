const microzig = @import("microzig");
const TIMER = microzig.chip.registers.TIMER;

pub const Absolute = struct {
    us_since_boot: u64,
};

pub fn getTimeSinceBoot() Absolute {
    var high_word = TIMER.TIMERAWH.*;

    return while (true) {
        var low_word = TIMER.TIMERAWL.*;
        const next_high_word = TIMER.TIMERAWH.*;
        if (next_high_word == high_word)
            break Absolute{
                .us_since_boot = @intCast(u64, high_word) << 32 | low_word,
            };

        high_word = next_high_word;
    } else unreachable;
}

pub fn makeTimeoutUs(timeout_us: u64) Absolute {
    return Absolute{
        .us_since_boot = getTimeSinceBoot().us_since_boot + timeout_us,
    };
}

pub fn reached(time: Absolute) bool {
    const now = getTimeSinceBoot();
    return now.us_since_boot >= time.us_since_boot;
}

pub fn sleepMs(time_ms: u32) void {
    sleepUs(time_ms * 1000);
}

pub fn sleepUs(time_us: u64) void {
    const end_time = Absolute{
        .us_since_boot = time_us + getTimeSinceBoot().us_since_boot,
    };

    while (!reached(end_time)) {}
}
