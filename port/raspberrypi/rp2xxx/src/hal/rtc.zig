const std = @import("std");
const microzig = @import("microzig");

const RTC = microzig.chip.peripherals.RTC;
const clocks = @import("clocks.zig");
const hw = @import("hw.zig");

pub const DateTime = struct {
    year: u12,
    month: u4,
    day: u5,
    day_of_week: enum(u3) {
        Sunday = 0,
        Monday = 1,
        Tuesday = 2,
        Wednesday = 3,
        Thursday = 4,
        Friday = 5,
        Saturday = 6,
    },
    hour: u5,
    minute: u6,
    second: u6,
};

/// Configure and enable the RTC given a clock configuration that specifies what CLK_RTC frequency is
pub fn apply(comptime clock_config: clocks.config.Global) void {
    disable();

    const MAX_RTC_FREQ = 65536;
    const rtc_freq = comptime clock_config.rtc.?.frequency();
    comptime std.debug.assert((rtc_freq <= MAX_RTC_FREQ) and (rtc_freq >= 1));
    RTC.CLKDIV_M1.write(.{ .CLKDIV_M1 = @as(u16, @truncate(rtc_freq - 1)), .padding = 0 });

    enable();
}

pub inline fn disable() void {

    // Clear alias to atomically disable RTC
    hw.clear_alias(&RTC.CTRL).write(.{
        .RTC_ENABLE = 1,
        .RTC_ACTIVE = 0,
        .reserved4 = 0,
        .LOAD = 0,
        .reserved8 = 0,
        .FORCE_NOTLEAPYEAR = 0,
        .padding = 0,
    });
    // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
    while (RTC.CTRL.read().RTC_ACTIVE != 0) {}
}

pub inline fn enable() void {
    // Set alias to atomically enable RTC
    hw.set_alias(&RTC.CTRL).write(.{
        .RTC_ENABLE = 1,
        .RTC_ACTIVE = 0,
        .reserved4 = 0,
        .LOAD = 0,
        .reserved8 = 0,
        .FORCE_NOTLEAPYEAR = 0,
        .padding = 0,
    });
    // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
    while (RTC.CTRL.read().RTC_ACTIVE != 1) {}
}

pub inline fn set_datetime(datetime: DateTime) void {
    RTC.SETUP_0.modify(.{
        .YEAR = datetime.year,
        .MONTH = datetime.month,
        .DAY = datetime.day,
    });
    RTC.SETUP_1.modify(.{
        .DOTW = @intFromEnum(datetime.day_of_week),
        .HOUR = datetime.hour,
        .MIN = datetime.minute,
        .SEC = datetime.second,
    });
    // Set alias to atomically load RTC values
    hw.set_alias(&RTC.CTRL).write(.{
        .RTC_ENABLE = 0,
        .RTC_ACTIVE = 0,
        .reserved4 = 0,
        .LOAD = 1,
        .reserved8 = 0,
        .FORCE_NOTLEAPYEAR = 0,
        .padding = 0,
    });
}

pub inline fn get_datetime() DateTime {
    // Order is important for these as reading SETUP0 latches
    // SETUP1 to prevent changes happening in between register reads.
    //
    // TODO: I believe the compiler is forbidden from re-ordering these two
    //       volatile accesses, however this should be confirmed!
    const RTC0 = RTC.RTC_0.read();
    const RTC1 = RTC.RTC_1.read();

    return .{
        .year = RTC1.YEAR,
        .month = RTC1.MONTH,
        .day = RTC1.DAY,
        .day_of_week = @enumFromInt(RTC0.DOTW),
        .hour = RTC0.HOUR,
        .minute = RTC0.MIN,
        .second = RTC0.SEC,
    };
}

/// For configuring time alarms that will generate interrupts
pub const alarm = struct {
    const Config = struct {
        year: ?u12 = null,
        month: ?u4 = null,
        day: ?u5 = null,
        day_of_week: ?enum(u3) {
            Sunday = 0,
            Monday = 1,
            Tuesday = 2,
            Wednesday = 3,
            Thursday = 4,
            Friday = 5,
            Saturday = 6,
        } = null,
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
        var irq_setup0 = RTC.IRQ_SETUP_0.read();
        var irq_setup1 = RTC.IRQ_SETUP_1.read();
        irq_setup0.MATCH_ENA = 0;

        if (config.year) |year| {
            irq_setup0.YEAR = year;
            irq_setup0.YEAR_ENA = 1;
        }
        if (config.month) |month| {
            irq_setup0.MONTH = month;
            irq_setup0.MONTH_ENA = 1;
        }
        if (config.day) |day| {
            irq_setup0.DAY = day;
            irq_setup0.DAY_ENA = 1;
        }

        if (config.day_of_week) |day_of_week| {
            irq_setup1.DOTW = @intFromEnum(day_of_week);
            irq_setup1.DOTW_ENA = 1;
        }
        if (config.hour) |hour| {
            irq_setup1.HOUR = hour;
            irq_setup1.HOUR_ENA = 1;
        }
        if (config.minute) |minute| {
            irq_setup1.MIN = minute;
            irq_setup1.MIN_ENA = 1;
        }
        if (config.second) |second| {
            irq_setup1.SEC = second;
            irq_setup1.SEC_ENA = 1;
        }

        RTC.IRQ_SETUP_0.write(irq_setup0);
        RTC.IRQ_SETUP_1.write(irq_setup1);

        // Re-enable alarm now that settings have been applied
        alarm.enable();
    }

    /// Enable an alarm
    ///
    /// NOTE: To get an interrupt from an alarm, interrupts must also be enabled via irq.enable()
    pub inline fn enable() void {
        // Set alias to atomically enable Alarm
        hw.set_alias(&RTC.IRQ_SETUP_0).write(.{
            .DAY = 0,
            .reserved8 = 0,
            .MONTH = 0,
            .YEAR = 0,
            .DAY_ENA = 0,
            .MONTH_ENA = 0,
            .YEAR_ENA = 0,
            .reserved28 = 0,
            .MATCH_ENA = 1,
            .MATCH_ACTIVE = 0,
            .padding = 0,
        });
        // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
        while (RTC.IRQ_SETUP_0.read().MATCH_ACTIVE != 1) {}
    }

    /// Disable an alarm
    ///
    /// NOTE: This is useful for interval alarms. In order to prevent
    ///       interrupts from being generated the entire period the interval
    ///       is active, in the ISR you should call rtc.alarm.disable() then rtc.alarm.enable()
    pub inline fn disable() void {
        // Clear alias to atomically disable Alarm
        hw.clear_alias(&RTC.IRQ_SETUP_0).write(.{
            .DAY = 0,
            .reserved8 = 0,
            .MONTH = 0,
            .YEAR = 0,
            .DAY_ENA = 0,
            .MONTH_ENA = 0,
            .YEAR_ENA = 0,
            .reserved28 = 0,
            .MATCH_ENA = 1,
            .MATCH_ACTIVE = 0,
            .padding = 0,
        });
        // Poll until enable bit takes effect, important for the purpose of ensuring state while changing settings
        while (RTC.IRQ_SETUP_0.read().MATCH_ACTIVE != 0) {}
    }
};

/// Control whether or not this peripheral's IRQ is enabled
pub const irq = struct {
    /// Disable interrupts being generated every time an alarm occurs
    pub inline fn disable() void {
        // Clear alias to atomically disable IRQ
        hw.clear_alias(&RTC.INTE).write(.{
            .RTC = 1,
            .padding = 0,
        });
    }

    /// Enable interrupts being generated every time an alarm occurs
    pub inline fn enable() void {
        // Set alias to atomically enable IRQ
        hw.set_alias(&RTC.INTE).write(.{
            .RTC = 1,
            .padding = 0,
        });
    }
};
