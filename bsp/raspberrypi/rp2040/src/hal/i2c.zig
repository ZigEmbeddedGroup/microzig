const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const I2C0 = peripherals.I2C0;
const I2C1 = peripherals.I2C1;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");
const hw = @import("hw.zig");

const I2cRegs = microzig.chip.types.peripherals.I2C0;

pub const Config = struct {
    clock_config: clocks.GlobalConfiguration,
    repeated_start: bool = true,
    baud_rate: u32 = 100_000,
};

pub const Address = enum(u7) {
    _,

    pub fn new(addr: u7) Address {
        var a = @as(Address, @enumFromInt(addr));
        std.debug.assert(!a.is_reserved());
        return a;
    }

    pub fn is_reserved(addr: Address) bool {
        return ((@intFromEnum(addr) & 0x78) == 0) or ((@intFromEnum(addr) & 0x78) == 0x78);
    }

    pub fn format(addr: Address, fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("I2C(0x{X:0>2}", .{@intFromEnum(addr)});
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
    const scl_low_ns = (1_000_000_000 / freq_in) * scl_lcnt_with_additions;
    const scl_high_ns = (1_000_000_000 / freq_in) * scl_hcnt_with_additions;
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
        .scl_hcnt = @as(u16, @intCast(scl_hcnt)),
        .scl_lcnt = @as(u16, @intCast(scl_lcnt)),
        .sda_tx_hold_count = @as(u16, @intCast(sda_tx_hold_count)),
        .spklen = spklen,
    };
}

test "i2c.translate_baudrate" {
    try std.testing.expectEqualDeep(TimingRegisterValues{ .scl_hcnt = 486, .scl_lcnt = 749, .sda_tx_hold_count = 38, .spklen = 7 }, translate_baudrate(100_000, 125_000_000));
    try std.testing.expectEqualDeep(TimingRegisterValues{ .scl_hcnt = 112, .scl_lcnt = 186, .sda_tx_hold_count = 38, .spklen = 7 }, translate_baudrate(400_000, 125_000_000));
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

    fn get_regs(i2c: I2C) *volatile I2cRegs {
        return switch (@intFromEnum(i2c)) {
            0 => I2C0,
            1 => I2C1,
        };
    }

    inline fn disable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .{ .value = .DISABLED },
            .ABORT = .{ .value = .DISABLE },
            .TX_CMD_BLOCK = .{ .value = .NOT_BLOCKED },
            .padding = 0,
        });
    }

    inline fn enable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .{ .value = .ENABLED },
            .ABORT = .{ .value = .DISABLE },
            .TX_CMD_BLOCK = .{ .value = .NOT_BLOCKED },
            .padding = 0,
        });
    }

    /// Initializes the I2C HW block per the Config provided
    /// Per the API limitations discussed above, the following settings are fixed and not configurable:
    /// - Controller Mode only
    /// - Fast Mode only (full backwards compatibility in the I2C spec means this is suitable even for standard mode baud rates, IE 100kHz)
    /// - TX_EMPTY_CTRL is always enabled for easy detection of TX finished
    /// - TX and RX FIFO detection thresholds set to 1, this makes polling for TX finished/RX ready much simpler
    /// - DREQ signalling is always enabled, harmless if DMA isn't configured to listen for this
    pub fn apply(i2c: I2C, comptime config: Config) ConfigError!void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.IC_CON.write(.{
            .MASTER_MODE = .{ .value = .ENABLED },
            .SPEED = .{ .value = .FAST },
            .IC_RESTART_EN = .{ .value = if (config.repeated_start) .ENABLED else .DISABLED },
            .IC_SLAVE_DISABLE = .{ .value = .SLAVE_DISABLED },
            .TX_EMPTY_CTRL = .{ .value = .ENABLED },
            .IC_10BITADDR_SLAVE = .{ .raw = 0 },
            .IC_10BITADDR_MASTER = .{ .raw = 0 },
            .STOP_DET_IFADDRESSED = .{ .raw = 0 },
            .RX_FIFO_FULL_HLD_CTRL = .{ .raw = 0 },
            .STOP_DET_IF_MASTER_ACTIVE = 0,
            .padding = 0,
        });

        // TX and RX FIFO thresholds
        regs.IC_RX_TL.write(.{ .RX_TL = 0, .padding = 0 });
        regs.IC_TX_TL.write(.{ .TX_TL = 0, .padding = 0 });

        // DREQ signal control
        regs.IC_DMA_CR.write(.{
            .RDMAE = .{ .value = .ENABLED },
            .TDMAE = .{ .value = .ENABLED },
            .padding = 0,
        });

        const peripheral_block_freq = (comptime config.clock_config.get_frequency(.clk_sys)) orelse @compileError("clk_sys must be set for I²C");
        // set_baudrate() enables I2C block before returning
        try i2c.set_baudrate(config.baud_rate, peripheral_block_freq);
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
        const reg_vals = try translate_baudrate(baud_rate, freq_in);
        i2c.disable();
        const regs = i2c.get_regs();
        regs.IC_FS_SCL_HCNT.write(.{ .IC_FS_SCL_HCNT = reg_vals.scl_hcnt, .padding = 0 });
        regs.IC_FS_SCL_LCNT.write(.{ .IC_FS_SCL_LCNT = reg_vals.scl_lcnt, .padding = 0 });
        regs.IC_FS_SPKLEN.write(.{ .IC_FS_SPKLEN = reg_vals.spklen, .padding = 0 });
        regs.IC_SDA_HOLD.modify(.{ .IC_SDA_TX_HOLD = reg_vals.sda_tx_hold_count });
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
            .GC_OR_START = .{ .value = .GENERAL_CALL },
            .SPECIAL = .{ .value = .DISABLED },
            .padding = 0,
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

            if (abort_reason.ABRT_7B_ADDR_NOACK.value == .ACTIVE) {
                // Address byte wasn't acknowledged by any targets on the bus
                return TransactionError.DeviceNotPresent;
            } else if (abort_reason.ABRT_TXDATA_NOACK.value == .ABRT_TXDATA_NOACK_GENERATED) {
                // Address byte was acknowledged, but a data byte wasn't
                return TransactionError.NoAcknowledge;
            } else if (abort_reason.TX_FLUSH_CNT > 0) {
                // A previous abort caused the TX FIFO to be flusehed
                return TransactionError.TxFifoFlushed;
            } else {
                std.log.err("Unknown abort reason, IC_TX_ABRT_SOURCE=0x{X}", .{@as(u32, @bitCast(abort_reason))});
                return TransactionError.UnknownAbort;
            }
        }
    }

    /// Attempts to write number of bytes provided to target device and blocks until one of the following occurs:
    /// - Bytes have been transmitted successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn write_blocking(i2c: I2C, addr: Address, src: []const u8, timeout: ?time.Duration) TransactionError!void {
        if (addr.is_reserved()) return TransactionError.TargetAddressReserved;
        if (src.len == 0) return TransactionError.NoData;

        const deadline_maybe: ?time.Absolute = if (timeout) |v| time.make_timeout_us(v.to_us()) else null;

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        // Independent of successful write or abort, always ensure
        // the STOP condition is generated and transaction is concluded before
        // returning. The one exception is if timeout is hit, then return,
        // potentially still leaving the I2C block in an "active" state.
        // However, this avoids an infinite loop.
        defer {
            // From pico-sdk:
            //     TODO Could there be an abort while waiting for the STOP
            //     condition here? If so, additional code would be needed here
            //     to take care of the abort.
            // As far as I can tell from the datasheet, no, this is not possible.
            while (regs.IC_RAW_INTR_STAT.read().STOP_DET.value == .INACTIVE) {
                hw.tight_loop_contents();
                if (deadline_maybe) |deadline| if (deadline.is_reached()) break;
            }
            _ = regs.IC_CLR_STOP_DET.read();
        }

        var timed_out = false;
        for (src, 0..) |byte, i| {
            const last = (i == (src.len - 1));
            regs.IC_DATA_CMD.write(.{
                .RESTART = .{ .raw = 0 },
                .STOP = .{ .raw = @intFromBool(last) },
                .CMD = .{ .value = .WRITE },
                .DAT = byte,

                .FIRST_DATA_BYTE = .{ .value = .INACTIVE },
                .padding = 0,
            });
            // If an abort occurrs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
            // are ignored. If things work as expected, the TX FIFO gets drained naturally.
            // This makes it okay to poll on this and check for an abort after.
            // Note that this WILL loop infinitely if called when I2C is uninitialized and no
            // timeout is supplied!
            while (i2c.tx_fifo_available_spaces() == 0) {
                if (deadline_maybe) |deadline| {
                    if (deadline.is_reached()) {
                        timed_out = true;
                        break;
                    }
                }
                hw.tight_loop_contents();
            }
            try i2c.check_and_clear_abort();
            if (timed_out) break;
        }

        // Waits until everything in the TX FIFO is either successfully transmitted, or flushed
        // due to an abort. This functions because of TX_EMPTY_CTRL being enabled in apply().
        while (regs.IC_RAW_INTR_STAT.read().TX_EMPTY.value == .INACTIVE) {
            if (deadline_maybe) |deadline| {
                if (deadline.is_reached()) {
                    timed_out = true;
                    break;
                }
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
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?time.Duration) TransactionError!void {
        if (addr.is_reserved()) return TransactionError.TargetAddressReserved;
        if (dst.len == 0) return TransactionError.NoData;

        const deadline_maybe: ?time.Absolute = if (timeout) |v| time.make_timeout_us(v.to_us()) else null;

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        // Independent of successful read or abort, always ensure
        // the STOP condition is generated and transaction is concluded before
        // returning. The one exception is if timeout is hit, then return,
        // potentially still leaving the I2C block in an "active" state.
        // However, this avoid an infinite loop.
        defer {
            // From pico-sdk:
            //     TODO Could there be an abort while waiting for the STOP
            //     condition here? If so, additional code would be needed here
            //     to take care of the abort.
            // As far as I can tell from the datasheet, no, this is not possible.
            while (regs.IC_RAW_INTR_STAT.read().STOP_DET.value == .INACTIVE) {
                hw.tight_loop_contents();
                if (deadline_maybe) |deadline| if (deadline.is_reached()) break;
            }
            _ = regs.IC_CLR_STOP_DET.read();
        }

        var timed_out = false;
        for (dst, 0..) |*byte, i| {
            const last = (i == (dst.len - 1));
            regs.IC_DATA_CMD.write(.{
                .RESTART = .{ .raw = 0 },
                .STOP = .{ .raw = @intFromBool(last) },
                .CMD = .{ .value = .READ },
                .DAT = 0,

                .FIRST_DATA_BYTE = .{ .value = .INACTIVE },
                .padding = 0,
            });

            while (true) {
                try i2c.check_and_clear_abort();
                if (deadline_maybe) |deadline| if (deadline.is_reached()) {
                    timed_out = true;
                    break;
                };
                if (i2c.rx_fifo_bytes_ready() != 0) break;
            }

            if (timed_out)
                return TransactionError.Timeout;

            byte.* = regs.IC_DATA_CMD.read().DAT;
        }
    }

    /// Attempts to write number of bytes provided to target device and then immediately read bytes following a repeated
    /// start command (or Start + Stop if repeated start is disabled). Blocks until one of the following occurs:
    /// - Bytes have been transmitted and read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// This is useful for the common scenario of writing an address to a target device, and then immediately reading bytes from that address
    pub fn write_then_read_blocking(i2c: I2C, addr: Address, src: []const u8, dst: []u8, timeout: ?time.Duration) TransactionError!void {
        if (addr.is_reserved()) return TransactionError.TargetAddressReserved;
        if (src.len == 0) return TransactionError.NoData;

        const deadline_maybe: ?time.Absolute = if (timeout) |v| time.make_timeout_us(v.to_us()) else null;

        i2c.set_address(addr);
        const regs = i2c.get_regs();

        // Independent of successful write or abort, always ensure
        // the STOP condition is generated and transaction is concluded before
        // returning. The one exception is if timeout is hit, then return,
        // potentially still leaving the I2C block in an "active" state.
        // However, this avoids an infinite loop.
        defer {
            // From pico-sdk:
            //     TODO Could there be an abort while waiting for the STOP
            //     condition here? If so, additional code would be needed here
            //     to take care of the abort.
            // As far as I can tell from the datasheet, no, this is not possible.
            while (regs.IC_RAW_INTR_STAT.read().STOP_DET.value == .INACTIVE) {
                hw.tight_loop_contents();
                if (deadline_maybe) |deadline| if (deadline.is_reached()) break;
            }
            _ = regs.IC_CLR_STOP_DET.read();
        }

        var timed_out = false;

        // Write provided bytes to device
        for (src) |byte| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = .{ .raw = 0 },
                .STOP = .{ .raw = 0 },
                .CMD = .{ .value = .WRITE },
                .DAT = byte,

                .FIRST_DATA_BYTE = .{ .value = .INACTIVE },
                .padding = 0,
            });
            // If an abort occurrs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
            // are ignored. If things work as expected, the TX FIFO gets drained naturally.
            // This makes it okay to poll on this and check for an abort after.
            // Note that this WILL loop infinitely if called when I2C is uninitialized and no
            // timeout is supplied!
            while (i2c.tx_fifo_available_spaces() == 0) {
                hw.tight_loop_contents();
                if (deadline_maybe) |deadline| {
                    if (deadline.is_reached()) {
                        timed_out = true;
                        break;
                    }
                }
            }
            try i2c.check_and_clear_abort();
            if (timed_out) break;
        }

        // Read back requested bytes immediately following a repeated start
        for (dst, 0..) |*byte, i| {
            const first = (i == 0);
            const last = (i == (dst.len - 1));
            regs.IC_DATA_CMD.write(.{
                .RESTART = .{ .raw = @intFromBool(first) },
                .STOP = .{ .raw = @intFromBool(last) },
                .CMD = .{ .value = .READ },
                .DAT = 0,

                .FIRST_DATA_BYTE = .{ .value = .INACTIVE },
                .padding = 0,
            });

            while (true) {
                try i2c.check_and_clear_abort();
                if (deadline_maybe) |deadline| if (deadline.is_reached()) {
                    timed_out = true;
                    break;
                };

                if (i2c.rx_fifo_bytes_ready() != 0) break;
            }

            if (timed_out)
                return TransactionError.Timeout;

            byte.* = regs.IC_DATA_CMD.read().DAT;
        }
    }
};
