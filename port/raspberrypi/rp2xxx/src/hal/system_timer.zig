const std = @import("std");
const microzig = @import("microzig");
const compatibility = @import("compatibility.zig");

pub fn num(n: u2) Timer {
    return switch (compatibility.chip) {
        .RP2040 => if (n == 0)
            @enumFromInt(n)
        else
            @panic("only timer 0 is available on RP2040"),
        .RP2350 => @enumFromInt(n),
    };
}

pub const Timer = enum(u1) {
    _,

    /// Reads the current value of the timer (multicore safe).
    pub fn read(timer: Timer) u64 {
        const regs = timer.get_regs();

        var high_word = regs.TIMERAWH.read().TIMERAWH;
        return while (true) {
            const low_word = regs.TIMERAWL.read().TIMERAWL;
            const next_high_word = regs.TIMERAWH.read().TIMERAWH;
            if (next_high_word == high_word)
                break @as(u64, @intCast(high_word)) << 32 | low_word;

            high_word = next_high_word;
        } else unreachable;
    }

    /// Reads the current value of the low word of the timer. Use this when
    /// scheduling alarms.
    pub fn read_low(timer: Timer) u32 {
        return timer.get_regs().TIMERAWL.read().TIMERAWL;
    }

    /// Overrides the current timer value. WARN: **The use of this function on
    /// timer 0 is not recommended as it is used by the time hal (aka it is
    /// used in time.sleep_us/ms).**
    pub fn write(timer: Timer, value: u64) void {
        const regs = timer.get_regs();
        regs.TIMELW.write(.{ .TIMELW = @truncate(value) });
        regs.TIMEHW.write(.{ .TIMEHW = @truncate(value >> 32) });
    }

    /// Enables or disables the interrupt for the given alarm.
    pub fn set_interrupt_enabled(timer: Timer, alarm: Alarm, enable: bool) void {
        const regs = timer.get_regs();
        regs.INTE.write_raw(@as(u4, @intFromBool(enable)) << @intFromEnum(alarm));
    }

    /// Clears the interrupt flag for the given alarm.
    pub fn clear_interrupt(timer: Timer, alarm: Alarm) void {
        const regs = timer.get_regs();
        regs.INTR.write_raw(@as(u4, 1) << @intFromEnum(alarm));
    }

    /// Schedules an alarm to be triggered when the low word of the timer
    /// reaches the given value.
    pub fn schedule_alarm(timer: Timer, alarm: Alarm, at: u32) void {
        const regs = timer.get_regs();
        switch (alarm) {
            .alarm0 => regs.ALARM0.write(.{ .ALARM0 = at }),
            .alarm1 => regs.ALARM1.write(.{ .ALARM1 = at }),
            .alarm2 => regs.ALARM2.write(.{ .ALARM2 = at }),
            .alarm3 => regs.ALARM3.write(.{ .ALARM3 = at }),
        }
    }

    /// Stop an alarm before it triggers.
    pub fn stop_alarm(timer: Timer, alarm: Alarm) void {
        const regs = timer.get_regs();
        regs.ARMED.write(.{ .ARMED = @as(u4, 1) << @intFromEnum(alarm) });
    }

    pub fn get_regs(timer: Timer) *volatile Regs {
        return switch (compatibility.chip) {
            .RP2040 => switch (@intFromEnum(timer)) {
                0 => microzig.chip.peripherals.TIMER,
                else => @panic("only timer 0 is available on RP2040"),
            },
            .RP2350 => switch (@intFromEnum(timer)) {
                0 => microzig.chip.peripherals.TIMER0,
                1 => microzig.chip.peripherals.TIMER1,
            },
        };
    }
};

pub const Alarm = enum(u2) {
    alarm0,
    alarm1,
    alarm2,
    alarm3,
};

pub const Regs = switch (compatibility.chip) {
    .RP2040 => microzig.chip.types.peripherals.TIMER,
    .RP2350 => microzig.chip.types.peripherals.TIMER0,
};
