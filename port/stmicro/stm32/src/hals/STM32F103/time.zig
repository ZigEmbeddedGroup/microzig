const microzig = @import("microzig");
const rcc = @import("rcc.zig");
const bkp = @import("backup.zig");
const rtc = @import("rtc.zig");
const time = microzig.drivers.time;

pub fn init() void {
    //Enable Backup domain clocks
    rcc.enable_clock(.PWR);
    rcc.enable_clock(.BKP);

    //disable Write protection to write into RTC register
    bkp.set_data_protection(false);
    rtc.enable(true);

    rtc.apply(.{
        .counter_start_value = 0,
        .prescaler = @intCast(rcc.get_clock(.RTC) - 1),
    });
    // HSE/128 is a special case that requires DBP always disabled
    if (microzig.chip.peripherals.RCC.BDCR.read().RTCSEL != .HSE) {
        bkp.set_data_protection(true);
        rcc.disable_clock(.PWR);
        rcc.disable_clock(.BKP);
    }
}

pub fn get_time_since_boot() time.Absolute {
    const rtc_freq: u64 = rcc.get_clock(.RTC);
    var sec: u64 = rtc.read_counter();
    var sec_frac: u64 = rtc.read_frac();
    const sec2: u64 = rtc.read_counter();

    //check for roll over
    if (sec != sec2) {
        @branchHint(.unlikely); // a very rare case due to the high speed of APB1 compared to the RTC
        sec = sec2;
        sec_frac = rtc.read_frac();
    }

    const frac = rtc_freq - sec_frac;
    const us: u64 = (sec * 1_000_000) + (frac * 1_000_000) / rtc_freq;
    return @enumFromInt(us);
}

pub fn sleep_ms(time_ms: u32) void {
    sleep_us(time_ms * 1000);
}

pub fn sleep_us(time_us: u64) void {
    const end_time = time.make_timeout_us(get_time_since_boot(), time_us);
    while (!end_time.is_reached_by(get_time_since_boot())) {}
}
