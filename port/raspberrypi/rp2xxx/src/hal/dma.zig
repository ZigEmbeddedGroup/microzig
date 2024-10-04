const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const chip = microzig.chip;
const DMA = chip.peripherals.DMA;

const hw = @import("hw.zig");

/// This encompasses all Dreq signals, plus "non Dreq" signals that can be
/// written to the TREQ_SEL field of the CHX_CTRL_TRIG register.
pub const Dreq = enum(u6) {
    pio0_tx0 = 0,
    pio0_tx1 = 1,
    pio0_tx2 = 2,
    pio0_tx3 = 3,
    pio0_rx0 = 4,
    pio0_rx1 = 5,
    pio0_rx2 = 6,
    pio0_rx3 = 7,
    pio1_tx0 = 8,
    pio1_tx1 = 9,
    pio1_tx2 = 10,
    pio1_tx3 = 11,
    pio1_rx0 = 12,
    pio1_rx1 = 13,
    pio1_rx2 = 14,
    pio1_rx3 = 15,

    spi0_tx = 16,
    spi0_rx = 17,
    spi1_tx = 18,
    spi1_rx = 19,

    uart0_tx = 20,
    uart0_rx = 21,
    uart1_tx = 22,
    uart1_rx = 23,

    pwm_wrap0 = 24,
    pwm_wrap1 = 25,
    pwm_wrap2 = 26,
    pwm_wrap3 = 27,
    pwm_wrap4 = 28,
    pwm_wrap5 = 29,
    pwm_wrap6 = 30,
    pwm_wrap7 = 31,

    i2c0_tx = 32,
    i2c0_rx = 33,
    i2c1_tx = 34,
    i2c1_rx = 35,

    adc = 36,

    xip_stream = 37,
    xip_ssitx = 38,
    xip_ssirx = 39,

    /// Technically not "DREQ" signals but a config option for the same
    /// register
    timer0 = 0x3b,
    timer1 = 0x3c,
    timer3 = 0x3d,
    permanent = 0x3f,
};

pub const TransferWordSize = enum(u2) {
    ONE_BYTE = 0,
    TWO_BYTES = 1,
    FOUR_BYTES = 2,
};

pub const RingConfig = struct {
    address_to_wrap: enum(u1) {
        read_addr = 0,
        write_addr = 1,
    },

    /// If non-zero, causes only the lower [wrap_bits] to change leading
    /// to a wrap size of 2^N
    wrap_bits: u4,
};

pub const Config = struct {
    transfer_word_size: TransferWordSize,
    transfer_count: u32,
    read_increment: bool,
    write_increment: bool,
    dreq: Dreq,
    read_addr: u32,
    write_addr: u32,

    chain_to: ?DmaChannel = null,
    high_priority: bool = false,
    // TODO:
    // chain to
    // ring
    // byte swapping
};

pub const DmaChannel = enum(u4) {
    _,

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

    fn get_regs(chan: DmaChannel) *volatile Regs {
        const regs = @as(*volatile [12]Regs, @ptrCast(&DMA.CH0_READ_ADDR));
        return &regs[@intFromEnum(chan)];
    }

    pub fn apply(
        chan: DmaChannel,
        config: Config,
    ) void {
        const regs = chan.get_regs();
        regs.read_addr = config.read_addr;
        regs.write_addr = config.write_addr;
        regs.trans_count = config.transfer_count;
        regs.ctrl_trig.modify(.{
            .DATA_SIZE = .{
                .raw = @intFromEnum(config.transfer_word_size),
            },
            .INCR_READ = @intFromBool(config.read_increment),
            .INCR_WRITE = @intFromBool(config.write_increment),
            .TREQ_SEL = .{
                .raw = @intFromEnum(config.dreq),
            },
            // Disables chaining
            .CHAIN_TO = @intFromEnum(chan),
        });
    }

    pub inline fn enable(chan: DmaChannel) void {
        const regs = chan.get_regs();
        regs.ctrl_trig.modify(.{
            .EN = 1,
        });
    }

    pub inline fn disable(chan: DmaChannel) void {
        const regs = chan.get_regs();
        regs.ctrl_trig.modify(.{
            .EN = 0,
        });
    }

    pub fn set_irq0_enabled(chan: DmaChannel, enabled: bool) void {
        if (enabled) {
            const inte0_set = hw.set_alias_raw(&DMA.INTE0);
            inte0_set.* = @as(u32, 1) << @intFromEnum(chan);
        } else {
            const inte0_clear = hw.clear_alias_raw(&DMA.INTE0);
            inte0_clear.* = @as(u32, 1) << @intFromEnum(chan);
        }
    }

    pub fn acknowledge_irq0(chan: DmaChannel) void {
        const ints0_set = hw.set_alias_raw(&DMA.INTS0);
        ints0_set.* = @as(u32, 1) << @intFromEnum(chan);
    }

    pub fn is_busy(chan: DmaChannel) bool {
        const regs = chan.get_regs();
        return regs.ctrl_trig.read().BUSY == 1;
    }
};

pub const instance = struct {
    pub const DMA0: DmaChannel = @as(DmaChannel, @enumFromInt(0));
    pub const DMA1: DmaChannel = @as(DmaChannel, @enumFromInt(1));
    pub const DMA2: DmaChannel = @as(DmaChannel, @enumFromInt(2));
    pub const DMA3: DmaChannel = @as(DmaChannel, @enumFromInt(3));
    pub const DMA4: DmaChannel = @as(DmaChannel, @enumFromInt(4));
    pub const DMA5: DmaChannel = @as(DmaChannel, @enumFromInt(5));
    pub const DMA6: DmaChannel = @as(DmaChannel, @enumFromInt(6));
    pub const DMA7: DmaChannel = @as(DmaChannel, @enumFromInt(7));
    pub const DMA8: DmaChannel = @as(DmaChannel, @enumFromInt(8));
    pub const DMA9: DmaChannel = @as(DmaChannel, @enumFromInt(9));
    pub const DMA10: DmaChannel = @as(DmaChannel, @enumFromInt(10));
    pub const DMA11: DmaChannel = @as(DmaChannel, @enumFromInt(11));

    pub fn num(instance_number: u4) DmaChannel {
        const num_channels = 12;
        assert(instance_number < num_channels);
        return @as(DmaChannel, @enumFromInt(instance_number));
    }
};
