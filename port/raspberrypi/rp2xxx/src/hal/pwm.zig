const std = @import("std");
const microzig = @import("microzig");
const PWM = microzig.chip.peripherals.PWM;
const pins = microzig.hal.pins;

const compatibility = @import("compatibility.zig");
const has_rp2350b = compatibility.has_rp2350b;

pub const Config = struct {};

fn get_regs(slice: u32) *volatile Regs {
    @import("std").debug.assert(slice < if (has_rp2350b) 12 else 8);
    const PwmType = microzig.chip.types.peripherals.PWM;
    const reg_diff = comptime @offsetOf(PwmType, "CH1_CSR") - @offsetOf(PwmType, "CH0_CSR");
    return @as(*volatile Regs, @ptrFromInt(@intFromPtr(PWM) + reg_diff * slice));
}

pub const Channel = enum(u1) { a, b };

pub const Slice = enum(u32) {
    _,

    /// Set the wrap value for the slice.  This is the number of pwm clock
    /// cycles that the slice will count to before wrapping.
    ///
    /// Parameters:
    ///   wrap - the wrap value
    pub fn set_wrap(self: Slice, wrap: u16) void {
        set_slice_wrap(@intFromEnum(self), wrap);
    }

    /// Enable the slice.
    pub fn enable(self: Slice) void {
        get_regs(@intFromEnum(self)).csr.modify(.{ .EN = 1 });
    }

    /// Disable the slice
    pub fn disable(self: Slice) void {
        get_regs(@intFromEnum(self)).csr.modify(.{ .EN = 0 });
    }

    /// Set the slice to phase correct mode.
    ///
    /// Parameters:
    ///   phase_correct - true to enable phase correct mode, false to disable it
    pub fn set_phase_correct(self: Slice, phase_correct: bool) void {
        set_slice_phase_correct(@intFromEnum(self), phase_correct);
    }

    /// Set the slice to a clock divider mode.
    ///
    /// Parameters:
    ///   integer - the integer part of the clock divider
    ///   fraction - the fractional part of the clock divider
    pub fn set_clk_div(self: Slice, integer: u8, fraction: u4) void {
        set_slice_clk_div(@intFromEnum(self), integer, fraction);
    }
};

// An instance of Pwm corresponds to one of the channels
//
// There are eight pwm instances on RP2040 and RP2350A and
// twelve on RP2350B.  Each pwm instance has two channels
// (a and b).
pub const Pwm = struct {
    slice_number: u32,
    channel: Channel,

    /// Set the level of the channel.  This is the number of pwm clock
    /// cycles that the channel will be high.
    ///
    /// The duty cycle of the channel is the ratio of this `level`
    /// to the the channel's `wrap` value.
    ///
    /// Parameters:
    ///   level - the level to set
    pub fn set_level(self: Pwm, level: u16) void {
        set_channel_level(self.slice_number, self.channel, level);
    }

    /// Set the channel to be inverted
    ///
    /// Parameters:
    ///   inverted - true to invert the channel, false to disable inversion
    pub fn set_inverted(self: Pwm, inverted: bool) void {
        set_channel_inversion(self.slice_number, self.channel, inverted);
    }

    /// Get the slice that this pwm instance is on.
    pub fn slice(self: Pwm) Slice {
        return @enumFromInt(self.slice_number);
    }
};

pub const ClkDivMode = enum(u2) {
    free_running,
    b_high,
    b_rising,
    b_falling,
};

const Regs = extern struct {
    csr: @TypeOf(PWM.CH0_CSR),
    div: @TypeOf(PWM.CH0_DIV),
    ctr: @TypeOf(PWM.CH0_CTR),
    cc: @TypeOf(PWM.CH0_CC),
    top: @TypeOf(PWM.CH0_TOP),
};

/// Set the slice to phase correct mode.
///
/// Parameters:
///   slice - the slice to set
///   phase_correct - true to enable phase correct mode, false to disable it
pub fn set_slice_phase_correct(slice: u32, phase_correct: bool) void {
    get_regs(slice).csr.modify(.{
        .PH_CORRECT = @intFromBool(phase_correct),
    });
}

/// Set the slice to a clock divider mode.
///
/// Parameters:
///   slice - the slice to set
///   integer - the integer part of the clock divider
///   fraction - the fractional part of the clock divider
pub fn set_slice_clk_div(slice: u32, integer: u8, fraction: u4) void {
    get_regs(slice).div.modify(.{
        .INT = integer,
        .FRAC = fraction,
    });
}

/// Set the slice to a clock divider mode.
///
/// Parameters:
///   slice - the slice to set
///   mode - the clock divider mode
pub fn set_slice_clk_div_mode(slice: u32, mode: ClkDivMode) void {
    get_regs(slice).csr.modify(.{
        .DIVMODE = @intFromEnum(mode),
    });
}

/// Set the channel to invert its output.
///
/// Parameters:
///   slice - the slice to set
///   channel - the channel to set
///   invert - true to invert the channel's output, false to disable inversion
pub fn set_channel_inversion(
    slice: u32,
    channel: Channel,
    invert: bool,
) void {
    switch (channel) {
        .a => get_regs(slice).csr.modify(.{
            .A_INV = @intFromBool(invert),
        }),
        .b => get_regs(slice).csr.modify(.{
            .B_INV = @intFromBool(invert),
        }),
    }
}

/// Set the wrap value for the slice.  This is the number of pwm clock
/// cycles that the slice will count to before wrapping.
///
/// Parameters:
///   slice - the slice to set
///   wrap - the wrap value
pub fn set_slice_wrap(slice: u32, wrap: u16) void {
    get_regs(slice).top.raw = wrap;
}

/// Set the level of the channel.  This is the number of pwm clock
/// cycles that the channel will be high.
///
/// The duty cycle of the channel is the ratio of this `level`
/// to the the channel's `wrap` value.
///
/// Parameters:
///   slice - the slice to set
///   channel - the channel to set
///   level - the level to set
pub fn set_channel_level(
    slice: u32,
    channel: Channel,
    level: u16,
) void {
    switch (channel) {
        .a => get_regs(slice).cc.modify(.{ .A = level }),
        .b => get_regs(slice).cc.modify(.{ .B = level }),
    }
}
