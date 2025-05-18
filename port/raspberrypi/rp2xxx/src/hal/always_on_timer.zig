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

const peripherals = microzig.chip.peripherals;
const POWMAN = peripherals.POWMAN;

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
/// be used to count milliseconds,
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

    /// Get the raw alarm time in milliseconds
    pub fn get_time() u64 {
        const b1 = POWMAN.ALARM_TIME_15TO0.read().ALARM_TIME_15TO0;
        const b2 = POWMAN.ALARM_TIME_31TO16.read().ALARM_TIME_31TO16;
        const b3 = POWMAN.ALARM_TIME_47TO32.read().ALARM_TIME_47TO32;
        const b4 = POWMAN.ALARM_TIME_63TO48.read().ALARM_TIME_63TO48;
        return @as(u64, b4) << 48 | @as(u64, b3) << 32 | @as(u64, b2) << 16 | b1;
    }

    /// Set the raw alarm time in milliseconds and optionally enable the alarm
    ///
    /// Parameters:
    ///
    /// * `time` - The time in milliseconds
    /// * `enable_alarm` - Whether to enable the alarm
    pub fn set_time(time: u64, enable_alarm: bool) void {
        alarm.disable();
        POWMAN.ALARM_TIME_15TO0.write(.{ .ALARM_TIME_15TO0 = @truncate(time) });
        POWMAN.ALARM_TIME_31TO16.write(.{ .ALARM_TIME_31TO16 = @truncate(time >> 16) });
        POWMAN.ALARM_TIME_47TO32.write(.{ .ALARM_TIME_47TO32 = @truncate(time >> 32) });
        POWMAN.ALARM_TIME_63TO48.write(.{ .ALARM_TIME_63TO48 = @truncate(time >> 48) });
        if (enable_alarm) alarm.enable();
    }
};

/// Control whether or not this peripheral's IRQ is enabled
pub const irq = struct {
    /// Disable interrupts being generated every time an alarm occurs
    pub inline fn disable() void {
        // ### TODO ### implement  irq.disable()
        // // Clear alias to atomically disable IRQ
        // hw.clear_alias(&RTC.INTE).write(.{
        //     .RTC = 1,
        // });
    }

    /// Enable interrupts being generated every time an alarm occurs
    pub inline fn enable() void {
        // ### TODO ### implement  irq.enable()
        // // Set alias to atomically enable IRQ
        // hw.set_alias(&RTC.INTE).write(.{
        //     .RTC = 1,
        // });
    }
};
