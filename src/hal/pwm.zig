const std = @import("std");
const microzig = @import("microzig");
const PWM = microzig.chip.peripherals.PWM;

const log = std.log.scoped(.pwm);

pub const Config = struct {};

fn get_regs(comptime slice: u32) *volatile Regs {
    @import("std").debug.assert(slice < 8);
    const PwmType = microzig.chip.types.peripherals.PWM;
    const reg_diff = comptime @offsetOf(PwmType, "CH1_CSR") - @offsetOf(PwmType, "CH0_CSR");
    return @ptrFromInt(*volatile Regs, @intFromPtr(PWM) + reg_diff * slice);
}

pub fn Pwm(comptime slice_num: u32, comptime chan: Channel) type {
    return struct {
        pub const slice_number = slice_num;
        pub const channel = chan;

        pub inline fn set_level(_: @This(), level: u16) void {
            set_channel_level(slice_number, channel, level);
        }

        pub fn slice(_: @This()) Slice(slice_number) {
            return .{};
        }
    };
}

pub fn Slice(comptime slice_num: u32) type {
    return struct {
        const slice_number = slice_num;

        pub inline fn set_wrap(_: @This(), wrap: u16) void {
            set_slice_wrap(slice_number, wrap);
        }

        pub inline fn enable(_: @This()) void {
            get_regs(slice_number).csr.modify(.{ .EN = 1 });
        }

        pub inline fn disable(_: @This()) void {
            get_regs(slice_number).csr.modify(.{ .EN = 0 });
        }

        pub inline fn set_phase_correct(_: @This(), phase_correct: bool) void {
            set_slice_phase_correct(slice_number, phase_correct);
        }

        pub inline fn set_clk_div(_: @This(), integer: u8, fraction: u4) void {
            set_slice_clk_div(slice_number, integer, fraction);
        }
    };
}

pub const ClkDivMode = enum(u2) {
    free_running,
    b_high,
    b_rising,
    b_falling,
};

pub const Channel = enum(u1) { a, b };

const Regs = extern struct {
    csr: @TypeOf(PWM.CH0_CSR),
    div: @TypeOf(PWM.CH0_DIV),
    ctr: @TypeOf(PWM.CH0_CTR),
    cc: @TypeOf(PWM.CH0_CC),
    top: @TypeOf(PWM.CH0_TOP),
};

pub inline fn set_slice_phase_correct(comptime slice: u32, phase_correct: bool) void {
    log.debug("PWM{} set phase correct: {}", .{ slice, phase_correct });
    get_regs(slice).csr.modify(.{
        .PH_CORRECT = @intFromBool(phase_correct),
    });
}

pub inline fn set_slice_clk_div(comptime slice: u32, integer: u8, fraction: u4) void {
    log.debug("PWM{} set clk div: {}.{}", .{ slice, integer, fraction });
    get_regs(slice).div.modify(.{
        .INT = integer,
        .FRAC = fraction,
    });
}

pub inline fn set_slice_clk_div_mode(comptime slice: u32, mode: ClkDivMode) void {
    log.debug("PWM{} set clk div mode: {}", .{ slice, mode });
    get_regs(slice).csr.modify(.{
        .DIVMODE = @intFromEnum(mode),
    });
}

pub inline fn set_channel_inversion(
    comptime slice: u32,
    comptime channel: Channel,
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

pub inline fn set_slice_wrap(comptime slice: u32, wrap: u16) void {
    log.debug("PWM{} set wrap: {}", .{ slice, wrap });
    get_regs(slice).top.raw = wrap;
}

pub inline fn set_channel_level(
    comptime slice: u32,
    comptime channel: Channel,
    level: u16,
) void {
    log.debug("PWM{} {} set level: {}", .{ slice, channel, level });
    switch (channel) {
        .a => get_regs(slice).cc.modify(.{ .A = level }),
        .b => get_regs(slice).cc.modify(.{ .B = level }),
    }
}
