const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const chip = microzig.chip;
const DMA = chip.peripherals.DMA;

const hw = @import("hw.zig");

var claimed_channels: u12 = 0;

pub const Dreq = enum(u6) {
    uart0_tx = 20,
    uart1_tx = 21,
    _,
};

pub fn num(n: u4) Channel {
    assert(n < 12);

    return @intToEnum(Channel, n);
}

pub fn claim_unused_channel() ?Channel {}

pub const Channel = enum(u4) {
    _,

    /// panics if the channel is already claimed
    pub fn claim(channel: Channel) void {
        _ = channel;
        @panic("TODO");
    }

    pub fn unclaim(channel: Channel) void {
        _ = channel;
        @panic("TODO");
    }

    pub fn is_claimed(channel: Channel) bool {
        _ = channel;
        @panic("TODO");
    }

    const Regs = extern struct {
        read_addr: u32,
        write_addr: u32,
        trans_count: u32,
        ctrl_trig: @TypeOf(DMA.CH0_CTRL_TRIG),

        // alias 1
        al1_ctrl: u32,
        al1_read_addr: u32,
        al1_write_addr: u32,
        al1_trans_count: u32,

        // alias 2
        al2_ctrl: u32,
        al2_read_addr: u32,
        al2_write_addr: u32,
        al2_trans_count: u32,

        // alias 3
        al3_ctrl: u32,
        al3_read_addr: u32,
        al3_write_addr: u32,
        al3_trans_count: u32,
    };

    fn get_regs(channel: Channel) *volatile Regs {
        const regs = @ptrCast(*volatile [12]Regs, &DMA.CH0_READ_ADDR);
        return &regs[@enumToInt(channel)];
    }

    pub const TransferConfig = struct {
        transfer_size_bytes: u3,
        enable: bool,
        read_increment: bool,
        write_increment: bool,
        dreq: Dreq,

        // TODO:
        // chain to
        // ring
        // byte swapping
    };

    pub fn trigger_transfer(
        channel: Channel,
        write_addr: u32,
        read_addr: u32,
        count: u32,
        config: TransferConfig,
    ) void {
        const regs = channel.get_regs();
        regs.read_addr = read_addr;
        regs.write_addr = write_addr;
        regs.trans_count = count;
        regs.ctrl_trig.modify(.{
            .EN = @boolToInt(config.enable),
            .DATA_SIZE = .{
                .value = .SIZE_BYTE,
            },
            .INCR_READ = @boolToInt(config.read_increment),
            .INCR_WRITE = @boolToInt(config.write_increment),
            .TREQ_SEL = .{
                .raw = @enumToInt(config.dreq),
            },
        });
    }

    pub fn set_irq0_enabled(channel: Channel, enabled: bool) void {
        if (enabled) {
            const inte0_set = hw.set_alias_raw(&DMA.INTE0);
            inte0_set.* = @as(u32, 1) << @enumToInt(channel);
        } else {
            const inte0_clear = hw.clear_alias_raw(&DMA.INTE0);
            inte0_clear.* = @as(u32, 1) << @enumToInt(channel);
        }
    }

    pub fn acknowledge_irq0(channel: Channel) void {
        const ints0_set = hw.set_alias_raw(&DMA.INTS0);
        ints0_set.* = @as(u32, 1) << @enumToInt(channel);
    }

    pub fn is_busy(channel: Channel) bool {
        const regs = channel.get_regs();
        return regs.ctrl_trig.read().BUSY == 1;
    }
};
