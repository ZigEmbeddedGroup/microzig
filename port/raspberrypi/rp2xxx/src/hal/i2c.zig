//!
//! This file implements the I²C driver for the RP2 chip family.
//!
//! Useful links:
//!     (Unofficial) I²C Reference: https://www.i2c-bus.org/
//!
const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const I2C0 = peripherals.I2C0;
const I2C1 = peripherals.I2C1;

const clocks = @import("clocks.zig");
const dma = @import("dma");
const time = @import("time.zig");
const hw = @import("hw.zig");

pub const slave = @import("i2c_slave.zig");

const I2cRegs = microzig.chip.types.peripherals.I2C0;

pub const Config = struct {
    clock_config: clocks.config.Global,
    repeated_start: bool = true,
    baud_rate: u32 = 100_000,
};

///
/// 7-bit I²C address, without the read/write bit.
///
pub const Address = enum(u7) {
    /// The general call addresses all devices on the bus using the I²C address 0.
    pub const general_call: Address = @enumFromInt(0x00);

    _,

    pub fn new(addr: u7) Address {
        var a = @as(Address, @enumFromInt(addr));
        std.debug.assert(!a.is_reserved());
        return a;
    }

    ///
    /// Returns `true` if the Address is a reserved I²C address.
    ///
    /// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
    ///
    /// See more here: https://www.i2c-bus.org/addressing/
    pub fn is_reserved(addr: Address) bool {
        const value: u7 = @intFromEnum(addr);
        return ((value & 0x78) == 0) or ((value & 0x78) == 0x78);
    }

    pub fn format(addr: Address, fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("I2C(0x{X:0>2})", .{@intFromEnum(addr)});
    }
};

pub const TransactionError = error{
    DeviceNotPresent,
    NoAcknowledge,
    Timeout,
    TargetAddressReserved,
    NoData,
    TxFifoFlushed,
    UnknownAbort,
};

pub const ConfigError = error{
    UnsupportedBaudRate,
    InputFreqTooLow,
    InputFreqTooHigh,
    HoldCountViolation,
};

const TimingRegisterValues = struct {
    scl_hcnt: u16,
    scl_lcnt: u16,
    sda_tx_hold_count: u16,
    spklen: u8,
};

fn translate_baudrate(baud_rate: u32, freq_in: u32) ConfigError!TimingRegisterValues {
    if ((baud_rate < 1) or (baud_rate > 1e6)) {
        return ConfigError.UnsupportedBaudRate;
    }

    // Per spec, must suppress at least 50ns spikes
    const spklen_u32: u32 = @divFloor(50 - 1, (@divFloor(1_000_000_000 - 1, freq_in) + 1)) + 1;

    // You shouldn't be able to drive the sys clock high enough to meet this condition, but doesn't hurt to check
    if (spklen_u32 > std.math.maxInt(u8)) return ConfigError.InputFreqTooHigh;
    const spklen: u8 = @intCast(spklen_u32);

    // I2C clock period in peripheral clock counts, rounding up
    const period: u32 = (freq_in + baud_rate / 2) / baud_rate;

    // Setting SCL low time to 60% duty cycle should meet spec
    // no matter if the receiver is operating in normal, fast mode,
    // or fast mode+ across all of those supported frequency ranges.
    // Note that these desired counts are AFTER the internal clock cycle
    // additions described below.
    const scl_lcnt_with_additions: u32 = period * 3 / 5;
    const scl_hcnt_with_additions: u32 = period - scl_lcnt_with_additions;

    // In the case where a rounding error shifts a timing parameter out of spec,
    // that means the input clock frequency is too low (not granular enough).
    // This also serves as a nice sanity check that we're still in spec no matter
    // the baud rate.
    const scl_low_ns: u64 = @as(u64, scl_lcnt_with_additions) * 1_000_000_000 / freq_in;
    const scl_high_ns: u64 = @as(u64, scl_hcnt_with_additions) * 1_000_000_000 / freq_in;
    switch (baud_rate) {
        1...100_000 => {
            const i2c_normal_scl_low_min_ns = 4700;
            const i2c_normal_scl_high_min_ns = 4000;
            if (scl_low_ns < i2c_normal_scl_low_min_ns) return ConfigError.InputFreqTooLow;
            if (scl_high_ns < i2c_normal_scl_high_min_ns) return ConfigError.InputFreqTooLow;
        },
        100_001...400_000 => {
            const i2c_fm_scl_low_min_ns = 1300;
            const i2c_fm_scl_high_min_ns = 600;
            if (scl_low_ns < i2c_fm_scl_low_min_ns) return ConfigError.InputFreqTooLow;
            if (scl_high_ns < i2c_fm_scl_high_min_ns) return ConfigError.InputFreqTooLow;
        },
        400_001...1_000_000 => {
            const i2c_fmplus_scl_low_min_ns = 500;
            const i2c_fmplus_scl_high_min_ns = 260;
            if (scl_low_ns < i2c_fmplus_scl_low_min_ns) return ConfigError.InputFreqTooLow;
            if (scl_high_ns < i2c_fmplus_scl_high_min_ns) return ConfigError.InputFreqTooLow;
        },
        else => unreachable, // Already checked baud rate within spec
    }

    // Per RP2040 datasheet: "4.3.14.1. Minimum High and Low Counts in SS, FS, and FM+ Modes.":
    // - IC_FS_SCL_LCNT must be greater than: IC_FS_SPKLEN + 7
    // - Actual low count in clock cycles is: IC_FS_SCL_LCNT + 1
    const scl_lcnt_min_val = spklen + 7;
    const scl_lcnt_internal_additions = 1;
    // - IC_FS_SCL_HCNT must be greater than: IC_FS_SPKLEN + 5
    // - Actual high count in clock cycles is: IC_FS_SCL_HCNT + IC_FS_SPKLEN + 7
    const scl_hcnt_min_val = spklen + 5;
    const scl_hcnt_internal_additions = spklen + 7;
    // Check for violating minimum/maximum values for high/low count registers given counts "with additions"
    if (scl_hcnt_with_additions > std.math.maxInt(u16)) return ConfigError.InputFreqTooHigh;
    if (scl_lcnt_with_additions > std.math.maxInt(u16)) return ConfigError.InputFreqTooHigh;
    if (scl_hcnt_with_additions <= scl_hcnt_min_val + scl_hcnt_internal_additions) return ConfigError.InputFreqTooLow;
    if (scl_lcnt_with_additions <= scl_lcnt_min_val + scl_lcnt_internal_additions) return ConfigError.InputFreqTooLow;

    // Find the actual register settings given these adjustments
    const scl_hcnt = scl_hcnt_with_additions - scl_hcnt_internal_additions;
    const scl_lcnt = scl_lcnt_with_additions - scl_lcnt_internal_additions;

    // Per I2C-bus specification a device in standard or fast mode must
    // internally provide a hold time of at least 300ns for the SDA signal to
    // bridge the undefined region of the falling edge of SCL. A smaller hold
    // time of 120ns is used for fast mode plus.
    const sda_tx_hold_count: u32 = if (baud_rate < 1_000_000)
        // sda_tx_hold_count = freq_in [cycles/s] * 300ns * (1s / 1e9ns)
        // Reduce 300/1e9 to 3/1e7 to avoid numbers that don't fit in uint.
        // Add 1 to avoid division truncation.
        ((freq_in * 3) / 10_000_000) + 1
    else
        // sda_tx_hold_count = freq_in [cycles/s] * 120ns * (1s / 1e9ns)
        // Reduce 120/1e9 to 3/25e6 to avoid numbers that don't fit in uint.
        // Add 1 to avoid division truncation.
        ((freq_in * 3) / 25_000_000) + 1;

    // Per spec, hold count can't exceed lcnt - 2, and must be a u16
    if ((sda_tx_hold_count > scl_lcnt - 2) or (sda_tx_hold_count > std.math.maxInt(u16))) return ConfigError.HoldCountViolation;

    return .{
        .scl_hcnt = @intCast(scl_hcnt),
        .scl_lcnt = @intCast(scl_lcnt),
        .sda_tx_hold_count = @intCast(sda_tx_hold_count),
        .spklen = spklen,
    };
}

test "i2c.translate_baudrate" {
    try std.testing.expectEqualDeep(
        TimingRegisterValues{ .scl_hcnt = 486, .scl_lcnt = 749, .sda_tx_hold_count = 38, .spklen = 7 },
        translate_baudrate(100_000, 125_000_000),
    );
    try std.testing.expectEqualDeep(
        TimingRegisterValues{ .scl_hcnt = 112, .scl_lcnt = 186, .sda_tx_hold_count = 38, .spklen = 7 },
        translate_baudrate(400_000, 125_000_000),
    );
    try std.testing.expectError(ConfigError.UnsupportedBaudRate, translate_baudrate(0, 125_000_000));
    // Taken directly from Table 450 to confirm our calculations match the datasheet's expectations
    try std.testing.expectError(ConfigError.InputFreqTooLow, translate_baudrate(100_000, 2_600_000));
    try std.testing.expectError(ConfigError.InputFreqTooLow, translate_baudrate(400_000, 11_900_000));
    try std.testing.expectError(ConfigError.InputFreqTooLow, translate_baudrate(1_000_000, 31_900_000));
}

pub const instance = struct {
    pub const I2C0: I2C = @as(I2C, @enumFromInt(0));
    pub const I2C1: I2C = @as(I2C, @enumFromInt(1));
    pub fn num(instance_number: u1) I2C {
        return @as(I2C, @enumFromInt(instance_number));
    }
};

/// An API for interacting with the RP2040's I2C driver.
///
/// Note: Assumes proper GPIO configuration, does NOT configure GPIO pins.
///
/// Features of the peripheral that are explicitly NOT supported by this API are:
/// - General Call/Start Byte Behavior
/// - 10 bit address mode
/// - Target mode
/// - Interrupt Driven/Asynchronous writes/reads
/// - DMA based writes/reads
pub const I2C = enum(u1) {
    _,

    pub inline fn get_regs(i2c: I2C) *volatile I2cRegs {
        return switch (@intFromEnum(i2c)) {
            0 => I2C0,
            1 => I2C1,
        };
    }

    inline fn disable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .DISABLED,
            .ABORT = .DISABLE,
            .TX_CMD_BLOCK = .NOT_BLOCKED,
        });
    }

    inline fn enable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .ENABLED,
            .ABORT = .DISABLE,
            .TX_CMD_BLOCK = .NOT_BLOCKED,
        });
    }

    /// Initializes the I2C HW block per the Config provided
    /// Per the API limitations discussed above, the following settings are fixed and not configurable:
    /// - Controller Mode only
    /// - Fast Mode only (full backwards compatibility in the I2C spec means this is suitable even for standard mode baud rates, IE 100kHz)
    /// - TX_EMPTY_CTRL is always enabled for easy detection of TX finished
    /// - TX and RX FIFO detection thresholds set to 1, this makes polling for TX finished/RX ready much simpler
    /// - DREQ signalling is always enabled, harmless if DMA isn't configured to listen for this
    pub fn apply(i2c: I2C, comptime config: Config) void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.IC_CON.write(.{
            .MASTER_MODE = .ENABLED,
            .SPEED = .FAST,
            .IC_RESTART_EN = if (config.repeated_start) .ENABLED else .DISABLED,
            .IC_SLAVE_DISABLE = .SLAVE_DISABLED,
            .TX_EMPTY_CTRL = .ENABLED,
            .IC_10BITADDR_SLAVE = @enumFromInt(0),
            .IC_10BITADDR_MASTER = @enumFromInt(0),
            .STOP_DET_IFADDRESSED = @enumFromInt(0),
            .RX_FIFO_FULL_HLD_CTRL = @enumFromInt(0),
            .STOP_DET_IF_MASTER_ACTIVE = 0,
        });

        // TX and RX FIFO thresholds
        regs.IC_RX_TL.write(.{ .RX_TL = 0 });
        regs.IC_TX_TL.write(.{ .TX_TL = 0 });

        // DREQ signal control
        regs.IC_DMA_CR.write(.{
            .RDMAE = .ENABLED,
            .TDMAE = .ENABLED,
        });

        const peripheral_block_freq = (comptime config.clock_config.get_frequency(.clk_sys)) orelse @compileError("clk_sys must be set for I²C");

        const timings = comptime translate_baudrate(config.baud_rate, peripheral_block_freq) catch @compileError("baud_rate is not possible with the provided clock_config");

        // set_baudrate() enables I2C block before returning
        i2c.set_computed_baudrate(timings);
    }

    /// Disables I2C, returns peripheral registers to reset state.
    pub fn reset(i2c: I2C) void {
        i2c.disable();
    }

    /// Configures I2C to run at a specified baud rate given a peripheral clock frequency.
    ///
    /// Validates configuration to ensure it's both within I2C spec, and the peripheral
    /// block's configuration capabilities. Note that this does NOT take into account
    /// pin rise/fall time as that is board specific, so actual baud rates may be
    /// slightly lower than specified.
    pub fn set_baudrate(i2c: I2C, baud_rate: u32, freq_in: u32) ConfigError!void {
        const timings = try translate_baudrate(baud_rate, freq_in);
        i2c.set_computed_baudrate(timings);
    }

    /// Configures I2C to run at a specified baud rate given a peripheral clock frequency.
    ///
    /// Validates configuration to ensure it's both within I2C spec, and the peripheral
    /// block's configuration capabilities. Note that this does NOT take into account
    /// pin rise/fall time as that is board specific, so actual baud rates may be
    /// slightly lower than specified.
    pub fn set_computed_baudrate(i2c: I2C, timings: TimingRegisterValues) void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.IC_FS_SCL_HCNT.write(.{ .IC_FS_SCL_HCNT = timings.scl_hcnt });
        regs.IC_FS_SCL_LCNT.write(.{ .IC_FS_SCL_LCNT = timings.scl_lcnt });
        regs.IC_FS_SPKLEN.write(.{ .IC_FS_SPKLEN = timings.spklen });
        regs.IC_SDA_HOLD.modify(.{ .IC_SDA_TX_HOLD = timings.sda_tx_hold_count });
        i2c.enable();
    }

    pub inline fn tx_fifo_available_spaces(i2c: I2C) u5 {
        const IC_TX_BUFFER_DEPTH = 16;
        return IC_TX_BUFFER_DEPTH - i2c.get_regs().IC_TXFLR.read().TXFLR;
    }

    pub inline fn rx_fifo_bytes_ready(i2c: I2C) u5 {
        return i2c.get_regs().IC_RXFLR.read().RXFLR;
    }

    fn set_address(i2c: I2C, addr: Address) void {
        i2c.disable();
        i2c.get_regs().IC_TAR.write(.{
            .IC_TAR = @intFromEnum(addr),
            .GC_OR_START = .GENERAL_CALL,
            .SPECIAL = .DISABLED,
        });
        i2c.enable();
    }

    fn check_and_clear_abort(i2c: I2C) TransactionError!void {
        const regs = i2c.get_regs();
        const abort_reason = regs.IC_TX_ABRT_SOURCE.read();
        if (@as(u32, @bitCast(abort_reason)) != 0) {
            // Note clearing the abort flag also clears the reason, and
            // this instance of flag is clear-on-read! Note also the
            // IC_CLR_TX_ABRT register always reads as 0.
            _ = regs.IC_CLR_TX_ABRT.read();

            if (abort_reason.ABRT_7B_ADDR_NOACK == .ACTIVE) {
                // Address byte wasn't acknowledged by any targets on the bus
                return TransactionError.DeviceNotPresent;
            } else if (abort_reason.ABRT_TXDATA_NOACK == .ABRT_TXDATA_NOACK_GENERATED) {
                // Address byte was acknowledged, but a data byte wasn't
                return TransactionError.NoAcknowledge;
            } else if (abort_reason.TX_FLUSH_CNT > 0) {
                // A previous abort caused the TX FIFO to be flushed
                return TransactionError.TxFifoFlushed;
            } else {
                std.log.err("Unknown abort reason, IC_TX_ABRT_SOURCE=0x{X}", .{@as(u32, @bitCast(abort_reason))});
                return TransactionError.UnknownAbort;
            }
        }
    }

    /// Independent of successful write or abort, always ensure
    /// the STOP condition is generated and transaction is concluded before
    /// returning. The one exception is if timeout is hit, then return,
    /// potentially still leaving the I2C block in an "active" state.
    /// However, this avoids an infinite loop.
    fn ensure_stop_condition(i2c: I2C, deadline: mdf.time.Deadline) void {
        const regs = i2c.get_regs();

        // From pico-sdk:
        //     TODO Could there be an abort while waiting for the STOP
        //     condition here? If so, additional code would be needed here
        //     to take care of the abort.
        // As far as I can tell from the datasheet, no, this is not possible.
        while (regs.IC_RAW_INTR_STAT.read().STOP_DET == .INACTIVE) {
            hw.tight_loop_contents();
            if (deadline.is_reached_by(time.get_time_since_boot()))
                break;
        }
        _ = regs.IC_CLR_STOP_DET.read();
    }

    pub fn tx(i2c: I2C) dma.DMA_WriteTarget {
        return .{
            .dreq = if (@intFromEnum(i2c) == 0) .i2c0_tx else .i2c1_tx,
            .addr = @intFromPtr(&i2c.get_regs().IC_DATA_CMD),
        };
    }

    pub fn rx(i2c: I2C) dma.DMA_ReadTarget {
        return .{
            .dreq = if (@intFromEnum(i2c) == 0) .i2c0_rx else .i2c1_rx,
            .addr = @intFromPtr(&i2c.get_regs().IC_DATA_CMD),
        };
    }

    /// Attempts to write number of bytes provided to target device and blocks until one of the following occurs:
    /// - Bytes have been transmitted successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn write_blocking(i2c: I2C, addr: Address, data: []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return i2c.writev_blocking(addr, &.{data}, timeout);
    }

    /// Attempts to write number of bytes provided to target device and blocks until one of the following occurs:
    /// - Bytes have been transmitted successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// NOTE: This function is a vectored version of `write_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    pub fn writev_blocking(i2c: I2C, addr: Address, chunks: []const []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(chunks);
        if (write_vec.size() == 0)
            return TransactionError.NoData;

        var deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        var iter = write_vec.iterator();
        while (iter.next_element()) |element| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = @enumFromInt(0),
                .STOP = @enumFromInt(@intFromBool(element.last)),
                .CMD = .WRITE,
                .DAT = element.value,

                .FIRST_DATA_BYTE = .INACTIVE,
            });
            // If an abort occurs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
            // are ignored. If things work as expected, the TX FIFO gets drained naturally.
            // This makes it okay to poll on this and check for an abort after.
            // Note that this WILL loop infinitely if called when I2C is uninitialized and no
            // timeout is supplied!
            while (i2c.tx_fifo_available_spaces() == 0) {
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
                hw.tight_loop_contents();
            }
            try i2c.check_and_clear_abort();
            if (timed_out)
                break;
        }

        // Waits until everything in the TX FIFO is either successfully transmitted, or flushed
        // due to an abort. This functions because of TX_EMPTY_CTRL being enabled in apply().
        while (regs.IC_RAW_INTR_STAT.read().TX_EMPTY == .INACTIVE) {
            if (deadline.is_reached_by(time.get_time_since_boot())) {
                timed_out = true;
                break;
            }
            hw.tight_loop_contents();
        }

        try i2c.check_and_clear_abort();
        if (timed_out)
            return TransactionError.Timeout;
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one of the following occurs:
    /// - Bytes have been read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return try i2c.readv_blocking(addr, &.{dst}, timeout);
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one of the following occurs:
    /// - Bytes have been read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// NOTE: This function is a vectored version of `read_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    pub fn readv_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        const read_vec = microzig.utilities.Slice_Vector([]u8).init(chunks);
        if (read_vec.size() == 0)
            return TransactionError.NoData;

        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        var iter = read_vec.iterator();
        while (iter.next_element_ptr()) |element| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = @enumFromInt(0),
                .STOP = @enumFromInt(@intFromBool(element.last)),
                .CMD = .READ,
                .DAT = 0,

                .FIRST_DATA_BYTE = .INACTIVE,
            });

            while (true) {
                try i2c.check_and_clear_abort();
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
                if (i2c.rx_fifo_bytes_ready() != 0) break;
            }

            if (timed_out)
                return TransactionError.Timeout;

            element.value_ptr.* = regs.IC_DATA_CMD.read().DAT;
        }
    }

    /// Attempts to write number of bytes provided to target device and then immediately read bytes following a repeated
    /// start command (or Start + Stop if repeated start is disabled). Blocks until one of the following occurs:
    /// - Bytes have been transmitted and read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// This is useful for the common scenario of writing an address to a target device, and then immediately reading bytes from that address
    pub fn write_then_read_blocking(i2c: I2C, addr: Address, src: []const u8, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return i2c.writev_then_readv_blocking(addr, &.{src}, &.{dst}, timeout);
    }

    /// Attempts to write number of bytes provided to target device and then immediately read bytes
    /// following a repeated start command (or Start + Stop if repeated start is disabled). Blocks
    /// until one of the following occurs:
    /// - Bytes have been transmitted and read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// This is useful for the common scenario of writing an address to a target device, and then
    /// immediately reading bytes from that address
    ///
    /// NOTE: This function is a vectored `writev_blocking` and `readv_blocking` and takes an array
    ///       of arrays. This pattern allows one to create better zero-copy send routines as message
    ///       prefixes and suffixes won't need to be concatenated/inserted to the original buffer,
    ///       but can be managed in a separate memory.
    ///
    pub fn writev_then_readv_blocking(i2c: I2C, addr: Address, write_chunks: []const []const u8, read_chunks: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(write_chunks);
        const read_vec = microzig.utilities.Slice_Vector([]u8).init(read_chunks);

        if (write_vec.size() == 0)
            return TransactionError.NoData;
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        // Write provided bytes to device
        var write_iter = write_vec.iterator();
        while (write_iter.next_element()) |element| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = @enumFromInt(0),
                .STOP = @enumFromInt(0),
                .CMD = .WRITE,
                .DAT = element.value,

                .FIRST_DATA_BYTE = .INACTIVE,
            });
            // If an abort occurs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
            // are ignored. If things work as expected, the TX FIFO gets drained naturally.
            // This makes it okay to poll on this and check for an abort after.
            // Note that this WILL loop infinitely if called when I2C is uninitialized and no
            // timeout is supplied!
            while (i2c.tx_fifo_available_spaces() == 0) {
                hw.tight_loop_contents();
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
            }
            try i2c.check_and_clear_abort();
            if (timed_out)
                break;
        }

        if (timed_out)
            return TransactionError.Timeout;

        // Read back requested bytes immediately following a repeated start
        var read_iter = read_vec.iterator();
        recv_loop: while (read_iter.next_element_ptr()) |element| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = @enumFromInt(@intFromBool(element.first)),
                .STOP = @enumFromInt(@intFromBool(element.last)),
                .CMD = .READ,
                .DAT = 0,

                .FIRST_DATA_BYTE = .INACTIVE,
            });

            while (true) {
                try i2c.check_and_clear_abort();
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break :recv_loop;
                }

                if (i2c.rx_fifo_bytes_ready() != 0)
                    break;
            }

            element.value_ptr.* = regs.IC_DATA_CMD.read().DAT;
        }

        if (timed_out)
            return TransactionError.Timeout;
    }
};
