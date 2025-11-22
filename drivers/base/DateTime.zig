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

/// A timezone.  The value is the offset in minutes from UTC.
pub const Timezone = enum(i16) {
    UTC = 0,
    _,

    pub const Z = Timezone.UTC;

    /// Convert a string in the form "±00:00" or "±0000" to a Timezone
    /// This allows for leading characters so "UTC+00:00" or "UTC-0000" are also valid.
    pub fn from_string(in_string: []const u8) Error!Timezone {
        // Look for a leading + or -
        var i: usize = 0;

        while (i < in_string.len) : (i += 1) {
            if (in_string[i] == '+' or in_string[i] == '-') break;
        }

        const is_minus = in_string[i] == '-';
        i += 1;

        var hour_offset: u16 = undefined;

        if (in_string[i] < '0' or in_string[i] > '1') return error.InvalidTimezone;
        hour_offset = 10 * (in_string[i] - '0');
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        hour_offset += in_string[i] - '0';
        i += 1;

        if (hour_offset > 14) return error.InvalidTimezone;

        if (in_string[i] == ':') i += 1;

        var minute_offset: i16 = undefined;

        if (in_string[i] < '0' or in_string[i] > '5') return error.InvalidTimezone;
        minute_offset = 10 * (in_string[i] - '0');
        i += 1;

        if (in_string[i] < '0' or in_string[i] > '9') return error.InvalidTimezone;
        minute_offset += @intCast(in_string[i] - '0');
        i += 1;

        if (minute_offset > 59) return error.InvalidTimezone;

        minute_offset += @intCast(hour_offset * 60);

        if (is_minus) {
            minute_offset = -minute_offset;
        }

        return @enumFromInt(minute_offset);
    }

    /// Convert a Timezone to a string like "+00:00" or "-00:00"
    ///
    /// Parameters:
    ///
    /// * `out_string` - The buffer to write the string to
    /// * `separator` - An optional separator to add between  the hours and minutes
    ///                 defaults to ":" if null
    pub fn to_string(self: Timezone, out_string: []u8, separator: ?[]const u8) Error!usize {
        if (out_string.len < 5 + (separator orelse ":").len) return error.NotEnoughSpace;

        const minus = @intFromEnum(self) < 0;

        var m = @abs(@intFromEnum(self));
        const h = m / 60;
        m = m % 60;

        var i: usize = 0;

        if (minus) {
            out_string[i] = '-';
        } else {
            out_string[i] = '+';
        }
        i += 1;

        _ = int_to_string_padded(out_string[i..], h, 2);
        i += 2;

        if (separator) |sep| {
            if (sep.len > 0) {
                std.mem.copyForwards(u8, out_string[i..], sep);
                i += sep.len;
            }
        } else {
            out_string[i] = ':';
            i += 1;
        }

        _ = int_to_string_padded(out_string[i..], m, 2);
        i += 2;

        return i;
    }

    /// Compute the offset in milliseconds between two timezones
    /// This number is the number of milliseconds to add to a time in the this timezone
    /// to get the time in the other timezone
    pub fn offset(self: Timezone, other: Timezone) i64 {
        var delta: i64 = @intFromEnum(other);
        delta -= @intFromEnum(self);
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
        .day = @intCast(day + 1),
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

    if (self.year < 1970) return error.InvalidYear;

    const leap_year = is_leap_year(self.year);

    // First computer number of days since 1970-01-01
    var result: u64 = @as(u64, self.year - 1970) * 365;

    // Add leap years
    for (1970..self.year) |y| {
        if (is_leap_year(@intCast(y))) {
            result += 1;
        }
    }

    // Add days in previous months

    switch (self.month) {
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

    if (self.month > 2 and leap_year) {
        result += 1;
    }

    // Add in days in this month

    result += @as(u64, self.day) - 1;

    // now add in hours, minutes and seconds, converting to seconds as we go

    result *= 24;
    result += @as(u64, self.hour);
    result *= 60;
    result += @as(u64, self.minute);
    result *= 60;
    result += @as(u64, self.second);

    // Add milliseconds

    result *= 1_000;
    result += @as(u64, self.millisecond);

    // Subtract the timezone offset checking for underflow.

    const tz_offset = self.timezone.offset(.UTC);

    if (tz_offset > 0) {
        if (result < @abs(tz_offset)) return error.InvalidYear;
        result -= @abs(tz_offset);
    } else {
        result += @abs(tz_offset);
    }

    return result;
}

/// Offset the DateTime by a number of milliseconds
pub fn offset(self: DateTime, offset_ms: i64) Error!DateTime {
    if (offset_ms == 0) return self;

    var t = try self.timestamp();
    if (-offset_ms > t) return error.InvalidOffset;
    t += @intCast(offset_ms);

    return DateTime.from_timestamp(t);
}

/// Convert a DateTime to a different timezone
pub fn to_timezone(self: DateTime, tz: Timezone) Error!DateTime {
    const delta = tz.offset(self.timezone);
    var result = try self.offset(-delta);

    result.timezone = tz;

    return result;
}

/// Compute the day of the week for a given date
pub fn day_of_week(self: DateTime) DayOfWeek {
    var y: u16 = self.year;
    var m: u16 = self.month;

    if (m < 3) {
        y -= 1;
        m += 12;
    }

    const c = y / 100;
    y = y % 100;

    var dow: i32 = (13 * (m + 1) / 5) + y + (y / 4) + (c / 4) + self.day;
    dow -= 2 * c;

    return @enumFromInt(@mod(dow, 7) - 1);
}

/// Convert the DateTime to an ISO 8601 string.
pub fn to_iso_8601(self: DateTime, out_string: []u8) !usize {
    if (self.timezone != .UTC) {
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
    const the_date = if (self.timezone != .UTC)
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
/// %Z    UTC offset in the form +HH:MM or -HH:MM.                     +00:00 - +14:00 or -00:00 - -14:00
///
/// %%    A literal '%' character.                                   %
pub fn to_string(self: DateTime, out_string: []u8, format: []const u8, localization: ?Localization) Error!usize {
    var i: usize = 0;
    var f: usize = 0;

    const l10n = localization orelse Localization.en;

    while (f < format.len) {
        if (format[f] == '%') {
            f += 1;
            if (f >= format.len) break;
            switch (format[f]) {
                'a' => {
                    const val = l10n.day_abbr[@intFromEnum(self.day_of_week())];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..], val);
                    i += val.len;
                },
                'A' => {
                    const val = l10n.day_names[@intFromEnum(self.day_of_week())];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..], val);
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
                    const val = l10n.month_abbr[self.month - 1];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..], val);
                    i += val.len;
                },
                'B' => {
                    const val = l10n.month_names[self.month - 1];
                    if (i + val.len > out_string.len) return error.NotEnoughSpace;
                    std.mem.copyForwards(u8, out_string[i..], val);
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
                    i += try self.timezone.to_string(out_string[i..], "");
                },
                'Z' => {
                    if (i + 6 > out_string.len) return error.NotEnoughSpace;
                    i += try self.timezone.to_string(out_string[i..], null);
                },
                '%' => {
                    if (i + 1 > out_string.len) return error.NotEnoughSpace;
                    out_string[i] = '%';
                    i += 1;
                },
                '-' => {
                    f += 1;
                    if (f >= format.len) break;
                    switch (format[f]) {
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
    return std.fmt.printInt(out_string, int, 10, .lower, .{});
}

fn int_to_string_padded(out_string: []u8, int: u32, width: usize) usize {
    return std.fmt.printInt(out_string, int, 10, .lower, .{ .fill = '0', .width = width });
}

test "DateTime-Conversion" {
    const ts = 1110388142 * 1000 + 320;
    const dt = DateTime.from_timestamp(ts);

    try std.testing.expect(dt.year == 2005);
    try std.testing.expect(dt.month == 3);
    try std.testing.expect(dt.day == 9);
    try std.testing.expect(dt.hour == 17);
    try std.testing.expect(dt.minute == 9);
    try std.testing.expect(dt.second == 2);
    try std.testing.expect(dt.millisecond == 320);

    try std.testing.expect(try dt.timestamp() == ts);

    try std.testing.expect(dt.day_of_week() == .Wednesday);

    const tz = try Timezone.from_string("UTC+08:00");
    const dt1 = try dt.to_timezone(tz);

    try std.testing.expect(dt1.year == 2005);
    try std.testing.expect(dt1.month == 3);
    try std.testing.expect(dt1.day == 10);
    try std.testing.expect(dt1.hour == 1);
    try std.testing.expect(dt1.minute == 9);
    try std.testing.expect(dt1.second == 2);
    try std.testing.expect(dt1.millisecond == 320);
}

test "TimeZone-Compare" {
    const tz1 = Timezone.UTC;
    const tz2 = try Timezone.from_string("UTC-04:00");

    try std.testing.expect(tz1.offset(tz2) == -4 * 60 * 60 * 1000);
}

test "DateTime to string" {
    const ts = 1110388142 * 1000 + 320;
    const dt = DateTime.from_timestamp(ts);

    var buf: [128]u8 = undefined;
    const len = try dt.to_string(&buf, "%a-%A-%w-%d-%-d-%b-%B-%m-%-m-%y-%-y-%Y-%H-%-H-%I-%-I-%p-%M-%-M-%S-%-S-%f-%z-%Z-%%100", .de);

    try std.testing.expectEqualStrings("Mit-Mittwoch-3-09-9-Mar-März-03-3-05-5-2005-17-17-05-5-nach-09-9-02-2-320-+0000-+00:00-%100", buf[0..len]);
}

test "Boundary Conditions - Year" {
    const ts = 1767225599_999;
    var dt = DateTime.from_timestamp(ts);

    try std.testing.expect(dt.year == 2025);
    try std.testing.expect(dt.month == 12);
    try std.testing.expect(dt.day == 31);
    try std.testing.expect(dt.hour == 23);
    try std.testing.expect(dt.minute == 59);
    try std.testing.expect(dt.second == 59);
    try std.testing.expect(dt.millisecond == 999);

    dt = try dt.offset(1);

    try std.testing.expect(dt.year == 2026);
    try std.testing.expect(dt.month == 1);
    try std.testing.expect(dt.day == 1);
    try std.testing.expect(dt.hour == 0);
    try std.testing.expect(dt.minute == 0);
    try std.testing.expect(dt.second == 0);
    try std.testing.expect(dt.millisecond == 0);

    try std.testing.expect(try dt.timestamp() == ts + 1);
}

test "Boundary Conditions - Feb/Mar - Non-Leap Year" {
    const ts = 1740787199_999;
    var dt = DateTime.from_timestamp(ts);

    try std.testing.expect(dt.year == 2025);
    try std.testing.expect(dt.month == 2);
    try std.testing.expect(dt.day == 28);
    try std.testing.expect(dt.hour == 23);
    try std.testing.expect(dt.minute == 59);
    try std.testing.expect(dt.second == 59);
    try std.testing.expect(dt.millisecond == 999);

    dt = try dt.offset(1);

    try std.testing.expect(dt.year == 2025);
    try std.testing.expect(dt.month == 3);
    try std.testing.expect(dt.day == 1);
    try std.testing.expect(dt.hour == 0);
    try std.testing.expect(dt.minute == 0);
    try std.testing.expect(dt.second == 0);
    try std.testing.expect(dt.millisecond == 0);

    try std.testing.expect(try dt.timestamp() == ts + 1);
}

test "Boundary Conditions - Feb/Mar - Leap Year" {
    const ts = 1709164799_999;
    var dt = DateTime.from_timestamp(ts);

    try std.testing.expect(dt.year == 2024);
    try std.testing.expect(dt.month == 2);
    try std.testing.expect(dt.day == 28);
    try std.testing.expect(dt.hour == 23);
    try std.testing.expect(dt.minute == 59);
    try std.testing.expect(dt.second == 59);
    try std.testing.expect(dt.millisecond == 999);

    dt = try dt.offset(1);

    try std.testing.expect(dt.year == 2024);
    try std.testing.expect(dt.month == 2);
    try std.testing.expect(dt.day == 29);
    try std.testing.expect(dt.hour == 0);
    try std.testing.expect(dt.minute == 0);
    try std.testing.expect(dt.second == 0);
    try std.testing.expect(dt.millisecond == 0);

    dt = try dt.offset(24 * 60 * 60 * 1000);

    try std.testing.expect(dt.year == 2024);
    try std.testing.expect(dt.month == 3);
    try std.testing.expect(dt.day == 1);
    try std.testing.expect(dt.hour == 0);
    try std.testing.expect(dt.minute == 0);
    try std.testing.expect(dt.second == 0);
    try std.testing.expect(dt.millisecond == 0);

    try std.testing.expect(try dt.timestamp() == ts + 1 + 24 * 60 * 60 * 1000);
}
