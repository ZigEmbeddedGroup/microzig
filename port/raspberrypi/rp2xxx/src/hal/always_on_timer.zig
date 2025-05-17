///! Always On Timer (AOT)
///
/// This is a timer that is always on, even when the CPU is in sleep mode.
///
/// It is used to generate interrupts at regular intervals, and can be used
/// to implement a software timer or real-time clock.
///
/// We implement much of the RTC functionality here, as the RTC is not
/// available on the RP2350.
/// Note: We generally cannot use the Mmio function to write to the timer
/// since all timer write operations require the "magic" value 0x5afe
/// to be written to the top 16 bits of the register.
const std = @import("std");
const microzig = @import("microzig");

const clocks = @import("clocks.zig");
const hw = @import("hw.zig");

const peripherals = microzig.chip.peripherals;
const POWMAN = peripherals.POWMAN;

pub const DayOfWeek = enum(u3) {
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
};

pub const DateTime = struct {
    year: u12,
    month: u4,
    day: u5,
    day_of_week: DayOfWeek,
    hour: u5,
    minute: u6,
    second: u6,
};

pub const ClockSource = enum {
    /// The low power 32_768 Hz oscillator
    lposc,
    /// The crystal oscillator
    xosc,
    /// External 1 kHz clock
    gpio_1khz,
    /// Not set -- timer will not run
    /// Do not use this value for `set_clock_source`
    none,
};

/// Set the clock source for the timer
///
/// This will disable the timer while setting the clock source.
///
/// Parameters:
///
/// * `source` - The clock source to use
pub fn set_clock_source(source: ClockSource) void {
    disable();
    var val = POWMAN.TIMER.raw;
    val &= 0x0000_ffff;
    val |= 0x5afe_0002;

    switch (source) {
        .lposc => val |= 0x0100,
        .xosc => val |= 0x0200,
        .gpio_1khz => val |= 0x0400,
        .none => @panic("Cannot set clock source to none."),
    }

    POWMAN.TIMER.raw = val;
}

/// Get the current clock source for the timer
///
/// Returns:
///
/// * `ClockSource` - The current clock source
pub fn get_clock_source() ClockSource {
    const src = POWMAN.TIMER.raw;

    if ((src & 0x0001_0000) != 0) return .xosc;
    if ((src & 0x0002_0000) != 0) return .lposc;
    if ((src & 0x0004_0000) != 0) return .gpio_1khz;
    return .none;
}

/// Set whether to use the 1 Hz clock for seconds.
/// The timer set by `set_time` will continue to
/// be used to count microseconds,
///
/// Parameters:
///
/// * `use_1hz` - Whether to use the 1 Hz clock
pub fn set_use_1hz_clock(use_1hz: bool) void {
    var val = POWMAN.TIMER.raw;
    val &= 0x0000_ffff;
    val |= 0x5afe_000;
    if (use_1hz) val |= 0x2000;
    POWMAN.TIMER.raw = val;
}

/// Get whether the 1 Hz clock is enabled
///
/// Returns:
///
/// * `bool` - Whether the 1 Hz clock is enabled
pub fn get_use_1hz_clock() bool {
    return POWMAN.TIMER.raw & 0x2000 != 0;
}

/// Get the frequency of the low power oscillator
///
/// Returns:
///
/// * `f32` - The frequency of the low power oscillator in Hz
pub fn get_lposc_frequency() f32 {
    const freq = POWMAN.LPOSC_FREQ_KHZ_INT.read().LPOSC_FREQ_KHZ_INT;
    const frac = POWMAN.LPOSC_FREQ_KHZ_FRAC.read().LPOSC_FREQ_KHZ_FRAC;
    return (@as(f32, @floatFromInt(freq)) + @as(f32, @floatFromInt(frac)) / 65_536) * 1_000;
}

/// Set the frequency of the low power oscillator
///
/// Parameters:
///
/// * `frequency` - The frequency of the low power oscillator in Hz
pub fn set_lposc_frequency(frequency: f32) void {
    if (frequency < 0.0) @panic("Frequency must be positive");
    const hz = frequency * 1_000.0;
    const freq: u6 = @truncate(hz);
    const frac: u16 = @truncate((hz - @trunc(hz)) * 65_536.0);
    POWMAN.LPOSC_FREQ_KHZ_INT.write(.{ .padding = 0x5afe, .LPOSC_FREQ_KHZ_INT = freq });
    POWMAN.LPOSC_FREQ_KHZ_FRAC.write(.{ .padding = 0x5afe, .LPOSC_FREQ_KHZ_FRAC = frac });
}

/// Get the frequency of the external oscillator
///
/// Returns:
///
/// * `f32` - The frequency of the external oscillator in Hz
pub fn get_xosc_frequency() f32 {
    const freq = POWMAN.XOSC_FREQ_KHZ_INT.read().XOSC_FREQ_KHZ_INT;
    const frac = POWMAN.XOSC_FREQ_KHZ_FRAC.read().XOSC_FREQ_KHZ_FRAC;
    return (@as(f32, @floatFromInt(freq)) + @as(f32, @floatFromInt(frac)) / 65_536) * 1_000;
}

/// Set the frequency of the external oscillator
///
/// Parameters:
///
/// * `frequency` - The frequency of the external oscillator in Hz
pub fn set_xosc_frequency(frequency: f32) void {
    if (frequency < 0.0) @panic("Frequency must be positive");
    const hz = frequency * 1_000.0;
    const freq: u16 = @truncate(hz);
    const frac: u16 = @truncate((hz - @trunc(hz)) * 65_536.0);
    POWMAN.XOSC_FREQ_KHZ_INT.write(.{ .padding = 0x5afe, .XOSC_FREQ_KHZ_INT = freq });
    POWMAN.XOSC_FREQ_KHZ_FRAC.write(.{ .padding = 0x5afe, .XOSC_FREQ_KHZ_FRAC = frac });
}

/// Get the current time in milliseconds
///
/// Returns:
///
/// * `u64` - The current time in milliseconds
pub fn get_time() u64 {
    const lower = POWMAN.READ_TIME_LOWER.read().READ_TIME_LOWER;
    const upper = POWMAN.READ_TIME_UPPER.read().READ_TIME_UPPER;
    return @as(u64, upper) << 32 | lower;
}

/// Set the current time in milliseconds
///
/// Parameters:
///
/// * `time` - The time in milliseconds
pub fn set_time(time: u64) void {
    disable();
    POWMAN.SET_TIME_63TO48.write(.{ .padding = 0x5afe, .SET_TIME_63TO48 = @truncate(time >> 48) });
    POWMAN.SET_TIME_47TO32.write(.{ .padding = 0x5afe, .SET_TIME_47TO32 = @truncate(time >> 32) });
    POWMAN.SET_TIME_31TO16.write(.{ .padding = 0x5afe, .SET_TIME_31TO16 = @truncate(time >> 16) });
    POWMAN.SET_TIME_15TO0.write(.{ .padding = 0x5afe, .SET_TIME_15TO0 = @truncate(time) });
    enable();
}

/// Enable the timer
pub fn enable() void {
    var val = POWMAN.TIMER.raw;
    val &= 0x0000_ffff;
    val |= 0x5afe_0002;
    POWMAN.TIMER.raw = val;
}

/// Disable the timer
pub fn disable() void {
    var val = POWMAN.TIMER.raw;
    val &= 0x0000_fffd;
    val |= 0x5afe_0000;
    POWMAN.TIMER.raw = val;
}

/// Check if the timer is enabled
///
/// Returns:
///
/// * `bool` - Whether the timer is enabled
pub fn is_enabled() bool {
    return POWMAN.TIMER.read().RUN != 0;
}

/// Check if a year is a leap year
fn is_leap_year(year: u32) bool {
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0);
}

/// Set the current based on a datetime
///
/// Parameters:
///
/// * `datetime` - The datetime to set
///
/// Returns an error if the datetime is invalid
pub fn set_datetime(datetime: DateTime) !void {
    const leap_year = is_leap_year(datetime.year);

    if (datetime.second > 59) {
        return error.InvalidSecond;
    }

    if (datetime.minute > 59) {
        return error.InvalidMinute;
    }

    if (datetime.hour > 23) {
        return error.InvalidHour;
    }

    switch (datetime.month) {
        0 => return error.InvalidMonth,
        1, 3, 5, 7, 8, 10, 12 => if (datetime.day > 31) return error.InvalidDay,
        4, 6, 9, 11 => if (datetime.day > 30) return error.InvalidDay,
        2 => if (datetime.day > if (leap_year) 29 else 28) return error.InvalidDay,
        else => {},
    }

    if (datetime.year < 1970) {
        return error.InvalidYear;
    }

    // First computer number of seconds since 1970-01-01 00:00:00 UTC

    var raw_time: u64 = datetime.second;
    raw_time += @as(u64, datetime.minute) * 60;
    raw_time += @as(u64, datetime.hour) * 60 * 60;
    raw_time += (@as(u64, datetime.day) - 1) * 24 * 60 * 60;

    switch (datetime.month) {
        1 => raw_time += 0,
        2 => raw_time += 31 * 24 * 60 * 60,
        3 => raw_time += (87 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        4 => raw_time += (118 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        5 => raw_time += (149 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        6 => raw_time += (180 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        7 => raw_time += (211 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        8 => raw_time += (242 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        9 => raw_time += (273 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        10 => raw_time += (304 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        11 => raw_time += (335 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        12 => raw_time += (366 + if (leap_year) 1 else 0) * 24 * 60 * 60,
        else => unreachable,
    }

    raw_time += @as(u64, datetime.year - 1970) * 365 * 24 * 60 * 60;

    // Add leap years
    for (1970..datetime.year) |year| {
        if (is_leap_year(year)) {
            raw_time += 24 * 60 * 60;
        }
    }

    set_time(raw_time * 1_000);
}

/// Get the current datetime
pub fn get_datetime() DateTime {
    var raw = get_time() / 1_000;

    // Hours minutes and seconds are easy

    const second = raw % 60;
    raw /= 60;
    const minute = raw % 60;
    raw /= 60;
    const hour = raw % 24;
    raw /= 24;

    // The rest are a bit trickier

    var day = raw;
    var year: u12 = 1970;

    while (day >= 365) {
        day -= 365;
        if (is_leap_year(year)) {
            day -= 1;
        }
        year += 1;
    }

    // Now we need to find the month
    var month: u4 = 1;

    while (true) {
        switch (month) {
            1, 3, 5, 7, 8, 10, 12 => if (day >= 31) {
                day -= 31;
                month += 1;
            } else break,
            4, 6, 9, 11 => if (day >= 30) {
                day -= 30;
                month += 1;
            } else break,
            2 => if (day >= if (is_leap_year(year)) @as(u5, 29) else @as(u5, 28)) {
                day -= if (is_leap_year(year)) 29 else 28;
                month += 1;
            } else break,
            else => unreachable,
        }
    }

    // Now we need to find the day of the week

    var dow_month: u32 = month;
    var dow_year: u32 = year;

    if (month < 3) {
        dow_month += 12;
        dow_year -= 1;
    }

    const dow_cent = dow_year / 100;
    dow_year = dow_year % 100;

    dow_month = 13 * (dow_month + 1) / 5;

    const dow = (day + dow_month + dow_year + dow_year / 4 + dow_cent / 4 - 2 * dow_cent) % 7;

    return .{
        .year = year,
        .month = month,
        .day = @intCast(day),
        .day_of_week = @enumFromInt(dow),
        .hour = @intCast(hour),
        .minute = @intCast(minute),
        .second = @intCast(second),
    };
}

/// Alarm functionality
pub const alarm = struct {
    /// Check if the alarm is enabled
    pub fn is_enabled() bool {
        return POWMAN.TIMER.read().ALARM != 0;
    }

    /// Disable the alarm
    pub fn disable() void {
        POWMAN.TIMER.write(.{ .ALARM = 0 });
    }

    /// Enable the alarm
    pub fn enable() void {
        POWMAN.TIMER.write(.{ .ALARM = 1 });
    }

    /// Get the raw alarm time in microseconds
    pub fn get_raw() u64 {
        const b1 = POWMAN.ALARM_TIME_15TO0.read().ALARM_TIME_15TO0;
        const b2 = POWMAN.ALARM_TIME_31TO16.read().ALARM_TIME_31TO16;
        const b3 = POWMAN.ALARM_TIME_47TO32.read().ALARM_TIME_47TO32;
        const b4 = POWMAN.ALARM_TIME_63TO48.read().ALARM_TIME_63TO48;
        return @as(u64, b4) << 48 | @as(u64, b3) << 32 | @as(u64, b2) << 16 | b1;
    }

    /// Set the raw alarm time in microseconds and optionally enable the alarm
    ///
    /// Parameters:
    ///
    /// * `time` - The time in microseconds
    /// * `enable_alarm` - Whether to enable the alarm
    pub fn set_raw(time: u64, enable_alarm: bool) void {
        alarm.disable();
        POWMAN.ALARM_TIME_15TO0.write(.{ .ALARM_TIME_15TO0 = @truncate(time) });
        POWMAN.ALARM_TIME_31TO16.write(.{ .ALARM_TIME_31TO16 = @truncate(time >> 16) });
        POWMAN.ALARM_TIME_47TO32.write(.{ .ALARM_TIME_47TO32 = @truncate(time >> 32) });
        POWMAN.ALARM_TIME_63TO48.write(.{ .ALARM_TIME_63TO48 = @truncate(time >> 48) });
        if (enable_alarm) alarm.enable();
    }

    const Config = struct {
        year: ?u12 = null,
        month: ?u4 = null,
        day: ?u5 = null,
        day_of_week: ?DayOfWeek = null,
        hour: ?u5 = null,
        minute: ?u6 = null,
        second: ?u6 = null,
    };

    /// Configure and enable an alarm to fire at values specified by config
    ///
    /// If a single alarm is desired at a specific datetime, all fields to make a datetime unique should be populated.
    /// For example:
    /// - The config .{.year = 2024, .month = 12, .day = 25, .hour = 8, .minute = 30, .second = 0}
    ///   Will fire an alarm at 12/25/2024 08:30:00
    ///
    /// For an alarm that fires on a set interval, only some fields should be specified. For example:
    /// - An alarm that fires once a minute at second "0" would have the config .{.second = 0}
    /// - An alarm that fires once an hour at minute "20" would have the config .{.minute = 20}
    /// - An alarm that fires 24 times a day at minute "20" but only on day "10" of the month would have the config .{.day = 10, .minute = 20}
    /// and so on...
    ///
    /// NOTE: To get an interrupt from an alarm, interrupts must also be enabled via irq.enable()
    ///
    pub fn configure(config: Config) void {

        // Keep alarm disabled while modifying settings
        alarm.disable();

        // ### TODO ### implement interrupts
        _ = config;
        // var irq_setup0 = RTC.IRQ_SETUP_0.read();
        // var irq_setup1 = RTC.IRQ_SETUP_1.read();
        // irq_setup0.MATCH_ENA = 0;

        // if (config.year) |year| {
        //     irq_setup0.YEAR = year;
        //     irq_setup0.YEAR_ENA = 1;
        // }
        // if (config.month) |month| {
        //     irq_setup0.MONTH = month;
        //     irq_setup0.MONTH_ENA = 1;
        // }
        // if (config.day) |day| {
        //     irq_setup0.DAY = day;
        //     irq_setup0.DAY_ENA = 1;
        // }

        // if (config.day_of_week) |day_of_week| {
        //     irq_setup1.DOTW = @intFromEnum(day_of_week);
        //     irq_setup1.DOTW_ENA = 1;
        // }
        // if (config.hour) |hour| {
        //     irq_setup1.HOUR = hour;
        //     irq_setup1.HOUR_ENA = 1;
        // }
        // if (config.minute) |minute| {
        //     irq_setup1.MIN = minute;
        //     irq_setup1.MIN_ENA = 1;
        // }
        // if (config.second) |second| {
        //     irq_setup1.SEC = second;
        //     irq_setup1.SEC_ENA = 1;
        // }

        // Re-enable alarm now that settings have been applied
        alarm.enable();
    }
};

/// Control whether or not this peripheral's IRQ is enabled
pub const irq = struct {
    /// Disable interrupts being generated every time an alarm occurs
    pub inline fn disable() void {
        // ### TODO ### implement
        // // Clear alias to atomically disable IRQ
        // hw.clear_alias(&RTC.INTE).write(.{
        //     .RTC = 1,
        // });
    }

    /// Enable interrupts being generated every time an alarm occurs
    pub inline fn enable() void {
        // ### TODO ### implement
        // // Set alias to atomically enable IRQ
        // hw.set_alias(&RTC.INTE).write(.{
        //     .RTC = 1,
        // });
    }
};
