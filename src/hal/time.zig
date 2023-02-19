const microzig = @import("microzig");
const TIMER = microzig.chip.peripherals.TIMER;

pub const Absolute = struct {
    us_since_boot: u64,
};

pub fn get_time_since_boot() Absolute {
    var high_word = TIMER.TIMERAWH;

    return while (true) {
        var low_word = TIMER.TIMERAWL;
        const next_high_word = TIMER.TIMERAWH;
        if (next_high_word == high_word)
            break Absolute{
                .us_since_boot = @intCast(u64, high_word) << 32 | low_word,
            };

        high_word = next_high_word;
    } else unreachable;
}

pub fn make_timeout_us(timeout_us: u64) Absolute {
    return Absolute{
        .us_since_boot = get_time_since_boot().us_since_boot + timeout_us,
    };
}

pub fn reached(time: Absolute) bool {
    const now = get_time_since_boot();
    return now.us_since_boot >= time.us_since_boot;
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = Absolute{
        .us_since_boot = time_us + get_time_since_boot().us_since_boot,
    };

    while (!reached(end_time)) {}
}
