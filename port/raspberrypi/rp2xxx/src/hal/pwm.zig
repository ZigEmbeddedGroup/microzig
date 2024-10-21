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

// NOTE: There are 16 Channels, so this struct could be called Channel.
//  Each slice has two channels, and so the channel field isn't storing enough information to
//  uniquely identify a channel--its only storing which of the two channels for the current slice it is
pub const RuntimePwm = struct {
    slice_number: u32,
    channel: Channel,

    pub fn set_level(self: RuntimePwm, level: u16) void {
        set_channel_level(self.slice_number, self.channel, level);
    }

    pub fn set_wrap(self: RuntimePwm, wrap: u16) void {
        set_slice_wrap(self.slice_number, wrap);
    }

    pub fn enable(self: RuntimePwm) void {
        get_regs(self.slice_number).csr.modify(.{ .EN = 1 });
    }
};

// NOTE: What the frick is this
pub fn instance(slice_number: u32, channel: Channel) RuntimePwm {
    return RuntimePwm {
        .slice_number = slice_number,
        .channel = channel,
    };
}

pub fn Pwm(slice_num: u32, chan: Channel) type {
    return struct {
        pub const slice_number = slice_num;
        pub const channel = chan;

        pub fn set_level(_: @This(), level: u16) void {
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

        pub fn set_wrap(_: @This(), wrap: u16) void {
            set_slice_wrap(slice_number, wrap);
        }

        pub fn enable(_: @This()) void {
            get_regs(slice_number).csr.modify(.{ .EN = 1 });
        }

        pub fn disable(_: @This()) void {
            get_regs(slice_number).csr.modify(.{ .EN = 0 });
        }

        pub fn set_phase_correct(_: @This(), phase_correct: bool) void {
            set_slice_phase_correct(slice_number, phase_correct);
        }

        pub fn set_clk_div(_: @This(), integer: u8, fraction: u4) void {
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

pub fn set_slice_phase_correct(comptime slice: u32, phase_correct: bool) void {
    // log.debug("PWM{} set phase correct: {}", .{ slice, phase_correct });
    get_regs(slice).csr.modify(.{
        .PH_CORRECT = @intFromBool(phase_correct),
    });
}

pub fn set_slice_clk_div(comptime slice: u32, integer: u8, fraction: u4) void {
    // log.debug("PWM{} set clk div: {}.{}", .{ slice, integer, fraction });
    get_regs(slice).div.modify(.{
        .INT = integer,
        .FRAC = fraction,
    });
}

pub fn set_slice_clk_div_mode(comptime slice: u32, mode: ClkDivMode) void {
    // log.debug("PWM{} set clk div mode: {}", .{ slice, mode });
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
    // log.debug("PWM{} set wrap: {}", .{ slice, wrap });
    get_regs(slice).top.raw = wrap;
}

pub fn set_channel_level(
    slice: u32,
    channel: Channel,
    level: u16,
) void {
    log.debug("PWM{} {} set level: {}", .{ slice, channel, level });
    // asm volatile ("" ::: "memory");
    switch (channel) {
        .a => get_regs(slice).cc.modify(.{ .A = level }),
        .b => get_regs(slice).cc.modify(.{ .B = level }),
    }
}
