const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;

const log = std.log.scoped(.pwm);

pub const Config = struct {};

fn getRegs(comptime slice: u32) *volatile Regs {
    @import("std").debug.assert(slice < 8);
    const reg_diff = comptime (@ptrToInt(regs.PWM.CH1_CSR) - @ptrToInt(regs.PWM.CH0_CSR));
    return @intToPtr(*volatile Regs, regs.PWM.base_address + reg_diff * slice);
}

pub fn PWM(comptime slice_num: u32, comptime chan: Channel) type {
    return struct {
        pub const slice_number = slice_num;
        pub const channel = chan;

        pub inline fn setLevel(_: @This(), level: u16) void {
            setChannelLevel(slice_number, channel, level);
        }

        pub fn slice(_: @This()) Slice(slice_number) {
            return .{};
        }
    };
}

pub fn Slice(comptime slice_num: u32) type {
    return struct {
        const slice_number = slice_num;

        pub inline fn setWrap(_: @This(), wrap: u16) void {
            setSliceWrap(slice_number, wrap);
        }

        pub inline fn enable(_: @This()) void {
            getRegs(slice_number).csr.modify(.{ .EN = 1 });
        }

        pub inline fn disable(_: @This()) void {
            getRegs(slice_number).csr.modify(.{ .EN = 0 });
        }

        pub inline fn setPhaseCorrect(_: @This(), phase_correct: bool) void {
            setSlicePhaseCorrect(slice_number, phase_correct);
        }

        pub inline fn setClkDiv(_: @This(), integer: u8, fraction: u4) void {
            setSliceClkDiv(slice_number, integer, fraction);
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
    csr: @typeInfo(@TypeOf(regs.PWM.CH0_CSR)).Pointer.child,
    div: @typeInfo(@TypeOf(regs.PWM.CH0_DIV)).Pointer.child,
    ctr: @typeInfo(@TypeOf(regs.PWM.CH0_CTR)).Pointer.child,
    cc: @typeInfo(@TypeOf(regs.PWM.CH0_CC)).Pointer.child,
    top: @typeInfo(@TypeOf(regs.PWM.CH0_TOP)).Pointer.child,
};

pub inline fn setSlicePhaseCorrect(comptime slice: u32, phase_correct: bool) void {
    log.debug("PWM{} set phase correct: {}", .{ slice, phase_correct });
    getRegs(slice).csr.modify(.{
        .PH_CORRECT = @boolToInt(phase_correct),
    });
}

pub inline fn setSliceClkDiv(comptime slice: u32, integer: u8, fraction: u4) void {
    log.debug("PWM{} set clk div: {}.{}", .{ slice, integer, fraction });
    getRegs(slice).div.modify(.{
        .INT = integer,
        .FRAC = fraction,
    });
}

pub inline fn setSliceClkDivMode(comptime slice: u32, mode: ClkDivMode) void {
    log.debug("PWM{} set clk div mode: {}", .{ slice, mode });
    getRegs(slice).csr.modify(.{
        .DIVMODE = @enumToInt(mode),
    });
}

pub inline fn setChannelInversion(
    comptime slice: u32,
    comptime channel: Channel,
    invert: bool,
) void {
    switch (channel) {
        .a => getRegs(slice).csr.modify(.{
            .A_INV = @boolToInt(invert),
        }),
        .b => getRegs(slice).csr.modifi(.{
            .B_INV = @boolToInt(invert),
        }),
    }
}

pub inline fn setSliceWrap(comptime slice: u32, wrap: u16) void {
    log.debug("PWM{} set wrap: {}", .{ slice, wrap });
    getRegs(slice).top.raw = wrap;
}

pub inline fn setChannelLevel(
    comptime slice: u32,
    comptime channel: Channel,
    level: u16,
) void {
    log.debug("PWM{} {} set level: {}", .{ slice, channel, level });
    switch (channel) {
        .a => getRegs(slice).cc.modify(.{ .A = level }),
        .b => getRegs(slice).cc.modify(.{ .B = level }),
    }
}
