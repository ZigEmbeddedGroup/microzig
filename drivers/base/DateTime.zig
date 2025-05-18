//! This allows manipulation of dates and times.
//!
//! Notes:
//! - Date operations are based on the Gregorian calendar, so dates and times
//!   prior to 15 October 1582 may not be accurate.
//! - No support for BCE dates.

pub const std = @import("std");
pub const time = @import("../framework.zig").time;

const DateTime = @This();

year: u16,
month: u4,
day: u5,
hour: u5,
minute: u6,
second: u6,
millisecond: u10,
timezone: Timezone = .UTC,

/// Days of the week
pub const DayOfWeek = enum(u3) {
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
};

pub const Error = error{
    InvalidYear,
    InvalidMonth,
    InvalidDay,
    InvalidHour,
    InvalidMinute,
    InvalidSecond,
    InvalidMillisecond,
    InvalidTimezone,
    InvalidOffset,
    NotEnoughSpace,
    InvalidFormat,
};

/// A date order
pub const DateOrder = enum(u2) {
    ymd,
    mdy,
    dmy,
};

/// Datetime to string localization
pub const Localization = struct {
    day_names: [7][]const u8,
    day_abbr: [7][]const u8,
    month_names: [12][]const u8,
    month_abbr: [12][]const u8,
    am_pm: [2][]const u8,

    // English
    pub const en: Localization = .{
        .day_names = .{
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
        },
        .day_abbr = .{
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
        },
        .month_names = .{
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        },
        .month_abbr = .{
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        },
        .am_pm = .{
            "AM",
            "PM",
        },
    };

    // Deutsch
    pub const de: Localization = .{
        .day_names = .{
            "Sonntag",
            "Montag",
            "Dienstag",
            "Mittwoch",
            "Donnerstag",
            "Freitag",
            "Samstag",
        },
        .day_abbr = .{
            "Son",
            "Mon",
            "Die",
            "Mit",
            "Don",
            "Fre",
            "Sam",
        },
        .month_names = .{
            "Januar",
            "Februar",
            "März",
            "April",
            "Mai",
            "Juni",
            "Juli",
            "August",
            "September",
            "Oktober",
            "November",
            "Dezember",
        },
        .month_abbr = .{
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "Mai",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dez",
        },
        .am_pm = .{
            "vorm",
            "nach",
        },
    };

    // Français
    pub const fr: Localization = .{
        .day_names = .{
            "Dimanche",
            "Lundi",
            "Mardi",
            "Mercredi",
            "Jeudi",
            "Vendredi",
            "Samedi",
        },
        .day_abbr = .{
            "Dim",
            "Lun",
            "Mar",
            "Mer",
            "Jeu",
            "Ven",
            "Sam",
        },
        .month_names = .{
            "Janvier",
            "Février",
            "Mars",
            "Avril",
            "Mai",
            "Juin",
            "Juillet",
            "Août",
            "Septembre",
            "Octobre",
            "Novembre",
            "Décembre",
        },
        .month_abbr = .{
            "Jan",
            "Fev",
            "Mar",
            "Avr",
            "Mai",
            "Jun",
            "Jul",
            "Aou",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
        },
        .am_pm = .{
            "avant-midi",
            "après-midi",
        },
    };

    // Español
    pub const es: Localization = .{
        .day_names = .{
            "Domingo",
            "Lunes",
            "Martes",
            "Miércoles",
            "Jueves",
            "Viernes",
            "Sábado",
        },
        .day_abbr = .{
            "Dom",
            "Lun",
            "Mar",
            "Mie",
            "Jue",
            "Vie",
            "Sab",
        },
        .month_names = .{
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Diciembre",
        },
        .month_abbr = .{
            "Ene",
            "Feb",
            "Mar",
            "Abr",
            "May",
            "Jun",
            "Jul",
            "Ago",
            "Sep",
            "Oct",
            "Nov",
            "Dic",
        },
        .am_pm = .{
            "AM",
            "PM",
        },
    };

    // ### TODO ### Add more localizations
};

pub const default_localization = Localization{};

/// A timezone
pub const Timezone = struct {
    hour_offset: i4,
    minute_offset: i6 = 0,

    pub const UTC = Timezone{ .hour_offset = 0 };
    pub const Z = Timezone{ .hour_offset = 0 };

    /// Convert a string in the form "+00:00" or "-00:00" to a Timezone
    /// This allows for leading characters so "UTC+00:00" or "UTC-00:00" are also valid.
    pub fn from_string(in_string: []const u8) Error!Timezone {
        // Look for a leading + or -
        var i: usize = 0;
        var hour_offset: i4 = 0;
        var minute_offset: i6 = 0;

        while (i < in_string.len) : (i += 1) {
            if (in_string[i] == '+' or in_string[i] == '-') break;
        }

        if (in_string.len < i + 6) return error.InvalidTimezone;

        const is_minus = in_string[i] == '-';
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        hour_offset = 10 * (in_string[i] - '0');
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        hour_offset += in_string[i] - '0';
        i += 1;

        if (in_string[i] != ':') return error.InvalidTimezone;
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        minute_offset = 10 * (in_string[i] - '0');
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        minute_offset += in_string[i] - '0';
        i += 1;

        if (is_minus) {
            hour_offset = -hour_offset;
            minute_offset = -minute_offset;
        }

        return Timezone{ .hour_offset = hour_offset, .minute_offset = minute_offset };
    }

    /// Convert a Timezone to a string in the form "+00:00" or "-00:00"
    ///
    /// Parameters:
    ///
    /// * `out_string` - The buffer to write the string to
    /// * `prefix` - An optional prefix to add to the string (e.g, "UTC")
    pub fn to_string(self: Timezone, out_string: []u8, prefix: ?[]const u8) Error!void {
        if (out_string.len < 6 + (prefix orelse "").len) return error.NotEnoughSpace;

        var i: usize = 0;

        if (prefix) |p| {
            std.mem.copyForwards(u8, out_string[0..p.len], p);
            i += p.len;
        }

        if (self.hour_offset < 0) {
            out_string[i] = '-';
        } else {
            out_string[i] = '+';
        }
        i += 1;

        _ = int_to_string_padded(out_string[i..], @abs(self.hour_offset), 2);

        out_string[i + 2] = ':';

        _ = int_to_string_padded(out_string[i + 3 ..], @abs(self.minute_offset), 2);
    }

    /// Compute the offset in milliseconds between two timezones
    pub fn offset(self: Timezone, other: Timezone) i64 {
        var delta: i64 = self.hour_offset;
        delta -= other.hour_offset;
        delta *= 60;
        delta += self.minute_offset;
        delta -= other.minute_offset;
        delta *= 60_000;
        return delta;
    }
};

/// Check a DateTime for validity
pub fn is_valid(self: DateTime) Error!void {
    if (self.year == 0) return error.InvalidYear;
    if (self.day < 1 or self.day > days_in_month(self.year, self.month)) return error.InvalidDay;
    if (self.hour < 0 or self.hour > 23) return error.InvalidHour;
    if (self.minute < 0 or self.minute > 59) return error.InvalidMinute;
    if (self.second < 0 or self.second > 59) return error.InvalidSecond;
    if (self.millisecond < 0 or self.millisecond > 999) return error.InvalidMillisecond;
    return;
}

/// Create a DateTime from a timestamp in milliseconds since the epoch
/// 1970-01-01 00:00:00 UTC
pub fn from_timestamp(in_time: u64) DateTime {
    // Hours minutes and seconds are easy

    var input = in_time;

    const millisecond = input % 1_000;
    input /= 1_000;
    const second = input % 60;
    input /= 60;
    const minute = input % 60;
    input /= 60;
    const hour = input % 24;
    input /= 24;

    // The rest are a bit trickier

    var day = input;
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

    return .{
        .year = year,
        .month = month,
        .day = @intCast(day),
        .hour = @intCast(hour),
        .minute = @intCast(minute),
        .second = @intCast(second),
        .millisecond = @intCast(millisecond),
    };
}

/// Convert a DateTime to a timestamp in milliseconds since the epoch
/// 1970-01-01 00:00:00
///
/// Trying to convert a date prior to 1970-01-01 will return an error.
///
pub fn timestamp(self: DateTime) Error!u64 {
    try self.is_valid();

    const utc = try self.to_timezone(.UTC);

    if (utc.year < 1970) return error.InvalidYear;

    const leap_year = is_leap_year(utc.year);

    // First computer number of days since 1970-01-01
    var result: u64 = @as(u64, utc.year - 1970) * 365;

    // Add leap years
    for (1970..utc.year) |y| {
        if (is_leap_year(@intCast(y))) {
            result += 1;
        }
    }

    // Add days in previous months

    switch (utc.month) {
        1 => result += 0,
        2 => result += 31,
        3 => result += 59,
        4 => result += 90,
        5 => result += 120,
        6 => result += 151,
        7 => result += 181,
        8 => result += 212,
        9 => result += 243,
        10 => result += 273,
        11 => result += 304,
        12 => result += 334,
        else => unreachable,
    }

    if (utc.month > 2 and leap_year) {
        result += 1;
    }

    // Add in days in this month

    result += @as(u64, utc.day) - 1;

    // now add in hours, minutes and seconds, converting to seconds as we go

    result *= 24;
    result += @as(u64, utc.hour);
    result *= 60;
    result += @as(u64, utc.minute);
    result *= 60;
    result += @as(u64, utc.second);

    // Add milliseconds

    result *= 1_000;
    result += @as(u64, utc.millisecond);

    return result;
}

/// Offset the DateTime by a number of milliseconds
pub fn offset(self: DateTime, offset_ms: i64) Error!DateTime {
    if (offset_ms == 0) return self;

    var t = try self.timestamp();

    if (-offset_ms > t) return error.InvalidOffset;

    t += @intCast(offset_ms);

    return from_timestamp(t);
}

/// Convert a DateTime to a different timezone
pub fn to_timezone(self: DateTime, tz: Timezone) Error!DateTime {
    const delta = tz.offset(self.timezone);
    var result = try self.offset(delta);

    result.timezone = tz;

    return result;
}

/// Compute the day of the week for a given date
pub fn day_of_week(self: DateTime) DayOfWeek {
    var dow_month: u32 = self.month;
    var dow_year: u32 = self.year;

    if (self.month < 3) {
        dow_month += 12;
        dow_year -= 1;
    }

    const dow_cent = dow_year / 100;
    dow_year = dow_year % 100;

    dow_month = 13 * (dow_month + 1) / 5;

    const dow = (self.day + dow_month + dow_year + dow_year / 4 + dow_cent / 4 - 2 * dow_cent) % 7;

    return @enumFromInt(dow);
}

/// Convert the DateTime to an ISO 8601 string.
pub fn to_iso_8601(self: DateTime, out_string: []u8) !usize {
    if (self.timezone.hour_offset != 0 or self.timezone.minute_offset != 0) {
        if (self.millisecond == 0) {
            return try self.to_string(out_string, "%Y-%m-%dT%H:%M:%S%z", null);
        }

        return try self.to_string(out_string, "%Y-%m-%dT%H:%M:%S.%f%z", null);
    }

    if (self.millisecond == 0) {
        return try self.to_string(out_string, "%Y-%m-%dT%H:%M:%SZ", null);
    }

    return try self.to_string(out_string, "%Y-%m-%dT%H:%M:%S.%fZ", null);
}

/// Convert the DateTime to an RFC 7231 string in the format
/// ddd, DD MMM YYYY HH:MM:SS GMT
pub fn to_rfc_7231(self: DateTime, out_string: []u8) !usize {
    const the_date = if (self.timezone.hour_offset != 0 or self.timezone.minute_offset != 0)
        try self.to_timezone(.UTC)
    else
        self;

    return try the_date.to_string(out_string, "%a, %d %b %Y %H:%M:%S GMT", null);
}

/// Format date time to string:
///
/// Format characters:
///
/// %a    Abbreviated weekday name.                                  Sun, Mon, ...
/// %A    Full weekday name.                                         Sunday, Monday, ...
/// %w    Weekday as a decimal number.                               0, 1, ..., 6
///
/// %d    Day of the month as a zero-padded decimal.                 01, 02, ..., 31
/// %-d   Day of the month as a decimal number.                      1, 2, ..., 30
///
/// %b    Abbreviated month name.                                    Jan, Feb, ..., Dec
/// %B    Full month name.                                           January, February, ...
/// %m    Month as a zero-padded decimal number.                     01, 02, ..., 12
/// %-m   Month as a decimal number.                                 1, 2, ..., 12
///
/// %y    Year without century as a zero-padded decimal number.      00, 01, ..., 99
/// %-y   Year without century as a decimal number.                  0, 1, ..., 99
/// %Y    Year with century as a decimal number.                     2013, 2019 etc.
///
/// %H    Hour (24-hour clock) as a zero-padded decimal number.      00, 01, ..., 23
/// %-H   Hour (24-hour clock) as a decimal number.                  0, 1, ..., 23
/// %I    Hour (12-hour clock) as a zero-padded decimal number.      01, 02, ..., 12
/// %-I   Hour (12-hour clock) as a decimal number.                  1, 2, ... 12
/// %p    AM or PM indicator
///
/// %M    Minute as a zero-padded decimal number.                    00, 01, ..., 59
/// %-M   Minute as a decimal number.                                0, 1, ..., 59
///
/// %S    Second as a zero-padded decimal number.                    00, 01, ..., 59
/// %-S   Second as a decimal number.                                0, 1, ..., 59
///
/// %f    Millisecond as a decimal number, zero-padded on the left.  000 - 999
///
/// %z    UTC offset in the form +HHMM or -HHMM.                      +0000 - +1400 or -0000 - -1400
///
/// %%    A literal '%' character.                                   %
pub fn to_string(self: DateTime, out_string: []u8, format: []const u8, localization: ?Localization) Error!usize {
    var i: usize = 0;
    var f: usize = 0;

    const l10n = localization orelse Localization.en;

    while (f < format.len) {
        if (format[f] == '%') {
            f += 1;
            switch (format[f]) {
                'a' => {
                    const val = l10n.day_abbr[@intFromEnum(self.day_of_week())];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i .. i + val.len], val);
                    i += val.len;
                },
                'A' => {
                    const val = l10n.day_names[@intFromEnum(self.day_of_week())];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..i], val);
                    i += val.len;
                },
                'w' => {
                    if (i + 1 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], @intFromEnum(self.day_of_week()), 1);
                },
                'd' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.day, 2);
                },
                'm' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.month, 2);
                },
                'b' => {
                    const val = l10n.month_abbr[self.month];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i .. i + val.len], val);
                    i += val.len;
                },
                'B' => {
                    const val = l10n.month_names[self.month];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i .. i + val.len], val);
                    i += val.len;
                },
                'y' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.year % 100, 2);
                },
                'Y' => {
                    if (i + 4 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.year, 4);
                },
                'H' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.hour, 2);
                },
                'I' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    const hour = if (self.hour == 0) 12 else self.hour % 12;
                    i += int_to_string_padded(out_string[i..], hour, 2);
                },
                'p' => {
                    const val = l10n.am_pm[if (self.hour < 12) 0 else 1];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..], val);
                    i += val.len;
                },
                'M' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.minute, 2);
                },
                'S' => {
                    if (i + 2 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.second, 2);
                },
                'f' => {
                    if (i + 3 > out_string.len) return error.NotEnoughSpace;
                    i += int_to_string_padded(out_string[i..], self.millisecond, 3);
                },
                'z' => {
                    if (i + 6 > out_string.len) return error.NotEnoughSpace;
                    try self.timezone.to_string(out_string[i..], null);
                    i += 6;
                },
                '%' => {
                    if (i + 1 > out_string.len) return error.NotEnoughSpace;
                    out_string[i] = '%';
                    i += 1;
                },
                '-' => {
                    switch (format[f + 1]) {
                        'd' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.day);
                        },
                        'm' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.month);
                        },
                        'y' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.year % 100);
                        },
                        'H' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.hour);
                        },
                        'I' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            const hour = if (self.hour == 0) 12 else self.hour % 12;
                            i += int_to_string(out_string[i..], hour);
                        },
                        'M' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.minute);
                        },
                        'S' => {
                            if (i + 2 > out_string.len) return error.NotEnoughSpace;
                            i += int_to_string(out_string[i..], self.second);
                        },
                        else => return error.InvalidFormat,
                    }
                    f += 1;
                },
                else => return error.InvalidFormat,
            }
            f += 1;
        } else {
            if (i + 1 > out_string.len) return error.NotEnoughSpace;
            out_string[i] = format[f];
            i += 1;
            f += 1;
        }
    }

    return i;
}

/// Determine if a year is a leap year
pub fn is_leap_year(year: u16) bool {
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0);
}

/// Determine the number of days in a month
pub fn days_in_month(year: u16, month: u4) u5 {
    switch (month) {
        1, 3, 5, 7, 8, 10, 12 => return 31,
        4, 6, 9, 11 => return 30,
        2 => return if (is_leap_year(year)) 29 else 28,
        else => unreachable,
    }
}

fn int_to_string(out_string: []u8, int: u32) usize {
    return std.fmt.formatIntBuf(out_string, int, 10, .lower, .{});
}

fn int_to_string_padded(out_string: []u8, int: u32, width: usize) usize {
    return std.fmt.formatIntBuf(out_string, int, 10, .lower, .{ .fill = '0', .width = width });
}

// test "DateTime tz_offset" {
//     const dt = DateTime{
//         .year = 2025,
//         .month = Month.January,
//         .day = 1,
//         .hour = 0,
//         .minute = 0,
//         .second = 0,
//         .millisecond = 0,
//     };

//     const tz = time.Timezone{
//         .hour_offset = 0,
//         .minute_offset = 0,
//     };

//     return dt.tz_offset(tz);
// }
