const std = @import("std");
const microzig = @import("microzig");
const PWM = microzig.chip.peripherals.PWM;

const log = std.log.scoped(.pwm);

pub const Config = struct {};

fn get_regs(slice: u32) *volatile Regs {
    @import("std").debug.assert(slice < 8);
    const PwmType = microzig.chip.types.peripherals.PWM;
    const reg_diff = comptime @offsetOf(PwmType, "CH1_CSR") - @offsetOf(PwmType, "CH0_CSR");
    return @as(*volatile Regs, @ptrFromInt(@intFromPtr(PWM) + reg_diff * slice));
}

pub const Channel = enum(u1) { a, b };

// An instance of Pwm corresponds to one of the 16 total channels
//  (There are eight slices and each has two channels)
pub const Pwm = struct {
    slice_number: u32,
    channel: Channel,

    pub fn set_level(self: Pwm, level: u16) void {
        set_channel_level(self.slice_number, self.channel, level);
    }

    pub fn set_wrap(self: Pwm, wrap: u16) void {
        set_slice_wrap(self.slice_number, wrap);
    }

    pub fn enable(self: Pwm) void {
        get_regs(self.slice_number).csr.modify(.{ .EN = 1 });
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

pub fn set_slice_phase_correct(slice: u32, phase_correct: bool) void {
    log.debug("PWM{} set phase correct: {}", .{ slice, phase_correct });
    get_regs(slice).csr.modify(.{
        .PH_CORRECT = @intFromBool(phase_correct),
    });
}

pub fn set_slice_clk_div(slice: u32, integer: u8, fraction: u4) void {
    log.debug("PWM{} set clk div: {}.{}", .{ slice, integer, fraction });
    get_regs(slice).div.modify(.{
        .INT = integer,
        .FRAC = fraction,
    });
}

pub fn set_slice_clk_div_mode(slice: u32, mode: ClkDivMode) void {
    log.debug("PWM{} set clk div mode: {}", .{ slice, mode });
    get_regs(slice).csr.modify(.{
        .DIVMODE = @intFromEnum(mode),
    });
}

pub fn set_channel_inversion(
    slice: u32,
    channel: Channel,
    invert: bool,
) void {
    switch (channel) {
        .a => get_regs(slice).csr.modify(.{
            .A_INV = @intFromBool(invert),
        }),
        .b => get_regs(slice).csr.modifi(.{
            .B_INV = @intFromBool(invert),
        }),
    }
}

pub fn set_slice_wrap(slice: u32, wrap: u16) void {
    log.debug("PWM{} set wrap: {}", .{ slice, wrap });
    get_regs(slice).top.raw = wrap;
}

pub fn set_channel_level(
    slice: u32,
    channel: Channel,
    level: u16,
) void {
    log.debug("PWM{} {} set level: {}", .{ slice, channel, level });
    switch (channel) {
        .a => get_regs(slice).cc.modify(.{ .A = level }),
        .b => get_regs(slice).cc.modify(.{ .B = level }),
    }
}
