const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const DMA = microzig.chip.peripherals.DMA;
pub const Dreq = microzig.chip.types.peripherals.DMA.Dreq;
pub const DataSize = microzig.chip.types.peripherals.DMA.DataSize;

const chip = @import("compatibility.zig").chip;

const hw = @import("hw.zig");

const num_channels = switch (chip) {
    .RP2040 => 12,
    .RP2350 => 16,
};
var claimed_channels = microzig.concurrency.AtomicStaticBitSet(num_channels){};

pub fn channel(n: u4) Channel {
    assert(n < num_channels);

    return @as(Channel, @enumFromInt(n));
}

pub fn claim_unused_channel() ?Channel {
    const ch = claimed_channels.set_first_available() catch {
        return null;
    };
    return channel(@intCast(ch));
}

pub const ChannelError = error{AlreadyClaimed};

pub const Channel = enum(u4) {
    _,

    pub fn claim(chan: Channel) ChannelError!void {
        if (!claimed_channels.set(@intFromEnum(chan)))
            return ChannelError.AlreadyClaimed;
    }

    pub fn unclaim(chan: Channel) void {
        const result = claimed_channels.reset(@intFromEnum(chan));
        std.debug.assert(result);
    }

    pub fn is_claimed(chan: Channel) bool {
        return claimed_channels.test_bit(@intFromEnum(chan)) == 1;
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
        al1_trans_count_trig: u32,

        // alias 2
        al2_ctrl: u32,
        al2_trans_count: u32,
        al2_read_addr: u32,
        al2_write_addr_trig: u32,

        // alias 3
        al3_ctrl: u32,
        al3_write_addr: u32,
        al3_trans_count: u32,
        al3_read_addr_trig: u32,
    };

    fn get_regs(chan: Channel) *volatile Regs {
        const regs = @as(*volatile [num_channels]Regs, @ptrCast(&DMA.CH0_READ_ADDR));
        return &regs[@intFromEnum(chan)];
    }

    pub const TransferConfig = struct {
        data_size: DataSize,
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
        chan: Channel,
        write_addr: u32,
        read_addr: u32,
        count: u32,
        config: TransferConfig,
    ) void {
        const regs = chan.get_regs();
        regs.read_addr = read_addr;
        regs.write_addr = write_addr;
        regs.trans_count = count;
        regs.ctrl_trig.modify(.{
            .EN = @intFromBool(config.enable),
            .DATA_SIZE = config.data_size,
            .INCR_READ = @intFromBool(config.read_increment),
            .INCR_WRITE = @intFromBool(config.write_increment),
            .TREQ_SEL = config.dreq,
        });
    }

    pub fn set_irq0_enabled(chan: Channel, enabled: bool) void {
        if (enabled) {
            const inte0_set = hw.set_alias_raw(&DMA.INTE0);
            inte0_set.* = @as(u32, 1) << @intFromEnum(chan);
        } else {
            const inte0_clear = hw.clear_alias_raw(&DMA.INTE0);
            inte0_clear.* = @as(u32, 1) << @intFromEnum(chan);
        }
    }

    pub fn acknowledge_irq0(chan: Channel) void {
        const ints0_set = hw.set_alias_raw(&DMA.INTS0);
        ints0_set.* = @as(u32, 1) << @intFromEnum(chan);
    }

    pub fn is_busy(chan: Channel) bool {
        const regs = chan.get_regs();
        return regs.ctrl_trig.read().BUSY == 1;
    }

    pub fn wait_for_finish_blocking(chan: Channel) void {
        while (chan.is_busy()) {
            hw.tight_loop_contents();
        }
    }
};
