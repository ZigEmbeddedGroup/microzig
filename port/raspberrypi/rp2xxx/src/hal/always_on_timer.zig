///! Always On Timer (AOT)
///
/// This is a timer that is always on, even when the CPU is in sleep mode.
///
/// It is used to generate interrupts at regular intervals, and can be used
/// to implement a software timer or real-time clock.
///
/// We implement much of the RTC functionality here, as the RTC is not
/// available on the RP2350.

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

pub fn get_time() u64 {
    const lower = POWMAN.READ_TIME_LOWER.read().READ_TIME_LOWER;
    const upper = POWMAN.READ_TIME_UPPER.read().READ_TIME_UPPER;
    return @as(u64, upper) << 32 | lower;
}

pub fn set_time(time: u64) void {
    disable();
    POWMAN.SET_TIME_63TO48.write(.{ .SET_TIME_63TO48 = @truncate(time >> 48) });
    POWMAN.SET_TIME_47TO32.write(.{ .SET_TIME_47TO32 = @truncate(time >> 32) });
    POWMAN.SET_TIME_31TO16.write(.{ .SET_TIME_31TO16 = @truncate(time >> 16) });
    POWMAN.SET_TIME_15TO0.write(.{ .SET_TIME_15TO0 = @truncate(time) });
    enable();
}

pub fn enable() void {
    POWMAN.TIMER.write(.{ .RUN = 1 });
}
pub fn disable() void {
    POWMAN.TIMER.write(.{ .RUN = 0 });
}

pub fn is_enabled() bool {
    return POWMAN.TIMER.read().RUN != 0;
}


fn is_leap_year(year: u32) bool {
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0);
}

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

    set_time(raw_time);
}

pub fn get_datetime() DateTime {
    var raw = get_time();

    // Hours minutes and seconds are easy

    const second = raw % 60;
    raw /= 60;
    const minute = raw % 60;
    raw /= 60;
    const hour = raw % 24;
    raw /= 24;

    // The rest are a bit trickier

    var day = raw;
    var year = 1970;

    while (day >= 365) {
        day -= 365;
        if (is_leap_year(year)) {
            day -= 1;
        }
        year += 1;
    }

    // Now we need to find the month
    var month = 1;

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
            2 => if (day >= if (is_leap_year(year)) 29 else 28) {
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
        .day = day,
        .day_of_week = @enumFromInt(dow),
        .hour = hour,
        .minute = minute,
        .second = second,
    };
}

/// Alarm functionality
pub const alarm = struct {
    pub fn is_enabled() bool {
        return POWMAN.TIMER.read().ALARM != 0;
    }

    pub fn disable() void {
        POWMAN.TIMER.write(.{ .ALARM = 0 });
    }

    pub fn enable() void {
        POWMAN.TIMER.write(.{ .ALARM = 1 });
    }

    pub fn get_raw() u64 {
        const b1 = POWMAN.ALARM_TIME_15TO0.read().ALARM_TIME_15TO0;
        const b2 = POWMAN.ALARM_TIME_31TO16.read().ALARM_TIME_31TO16;
        const b3 = POWMAN.ALARM_TIME_47TO32.read().ALARM_TIME_47TO32;
        const b4 = POWMAN.ALARM_TIME_63TO48.read().ALARM_TIME_63TO48;
        return @as(u64, b4) << 48 | @as(u64, b3) << 32 | @as(u64, b2) << 16 | b1;
    }

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

// pub const DateTime = struct {
//     year: u12,
//     month: u4,
//     day: u5,
//     day_of_week: enum(u3) {
//         Sunday = 0,
//         Monday = 1,
//         Tuesday = 2,
//         Wednesday = 3,
//         Thursday = 4,
//         Friday = 5,
//         Saturday = 6,
//     },
//     hour: u5,
//     minute: u6,
//     second: u6,
// };

// /// Configure and enable the RTC given a clock configuration that specifies what CLK_RTC frequency is
// pub fn apply(comptime clock_config: clocks.config.Global) void {
//     // disable();

//     // const MAX_RTC_FREQ = 65536;
//     // const rtc_freq = comptime clock_config.rtc.?.frequency();
//     // comptime std.debug.assert((rtc_freq <= MAX_RTC_FREQ) and (rtc_freq >= 1));
//     // RTC.CLKDIV_M1.write(.{ .CLKDIV_M1 = @as(u16, @truncate(rtc_freq - 1)) });

//     // enable();
// }

// pub inline fn disable() void {

//     // Clear alias to atomically disable RTC
//     hw.clear_alias(&RTC.CTRL).write(.{
//         .RTC_ENABLE = 1,
//         .RTC_ACTIVE = 0,
//         .LOAD = 0,
//         .FORCE_NOTLEAPYEAR = 0,
//     });
//     // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
//     while (RTC.CTRL.read().RTC_ACTIVE != 0) {}
// }

// pub inline fn enable() void {
//     // Set alias to atomically enable RTC
//     hw.set_alias(&RTC.CTRL).write(.{
//         .RTC_ENABLE = 1,
//         .RTC_ACTIVE = 0,
//         .LOAD = 0,
//         .FORCE_NOTLEAPYEAR = 0,
//     });
//     // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
//     while (RTC.CTRL.read().RTC_ACTIVE != 1) {}
// }

// pub inline fn set_datetime(datetime: DateTime) void {
//     // ### TODO ### Implement this
// }

// pub inline fn get_datetime() DateTime {
//     // ### TODO ### Implement this

//     return .{
//         .year = RTC1.YEAR,
//         .month = RTC1.MONTH,
//         .day = RTC1.DAY,
//         .day_of_week = @enumFromInt(RTC0.DOTW),
//         .hour = RTC0.HOUR,
//         .minute = RTC0.MIN,
//         .second = RTC0.SEC,
//     };
// }

// /// For configuring time alarms that will generate interrupts
// pub const alarm = struct {
//     // ### TODO ### Implement this
//     };

//     /// Configure and enable an alarm to fire at values specified by config
//     ///
//     /// If a single alarm is desired at a specific datetime, all fields to make a datetime unique should be populated.
//     /// For example:
//     /// - The config .{.year = 2024, .month = 12, .day = 25, .hour = 8, .minute = 30, .second = 0}
//     ///   Will fire an alarm at 12/25/2024 08:30:00
//     ///
//     /// For an alarm that fires on a set interval, only some fields should be specified. For example:
//     /// - An alarm that fires once a minute at second "0" would have the config .{.second = 0}
//     /// - An alarm that fires once an hour at minute "20" would have the config .{.minute = 20}
//     /// - An alarm that fires 24 times a day at minute "20" but only on day "10" of the month would have the config .{.day = 10, .minute = 20}
//     /// and so on...
//     ///
//     /// NOTE: To get an interrupt from an alarm, interrupts must also be enabled via irq.enable()
//     ///
//     pub fn configure(config: Config) void {

//         // Keep alarm disabled while modifying settings
//         alarm.disable();
//         var irq_setup0 = RTC.IRQ_SETUP_0.read();
//         var irq_setup1 = RTC.IRQ_SETUP_1.read();
//         irq_setup0.MATCH_ENA = 0;

//         if (config.year) |year| {
//             irq_setup0.YEAR = year;
//             irq_setup0.YEAR_ENA = 1;
//         }
//         if (config.month) |month| {
//             irq_setup0.MONTH = month;
//             irq_setup0.MONTH_ENA = 1;
//         }
//         if (config.day) |day| {
//             irq_setup0.DAY = day;
//             irq_setup0.DAY_ENA = 1;
//         }

//         if (config.day_of_week) |day_of_week| {
//             irq_setup1.DOTW = @intFromEnum(day_of_week);
//             irq_setup1.DOTW_ENA = 1;
//         }
//         if (config.hour) |hour| {
//             irq_setup1.HOUR = hour;
//             irq_setup1.HOUR_ENA = 1;
//         }
//         if (config.minute) |minute| {
//             irq_setup1.MIN = minute;
//             irq_setup1.MIN_ENA = 1;
//         }
//         if (config.second) |second| {
//             irq_setup1.SEC = second;
//             irq_setup1.SEC_ENA = 1;
//         }

//         RTC.IRQ_SETUP_0.write(irq_setup0);
//         RTC.IRQ_SETUP_1.write(irq_setup1);

//         // Re-enable alarm now that settings have been applied
//         alarm.enable();
//     }


