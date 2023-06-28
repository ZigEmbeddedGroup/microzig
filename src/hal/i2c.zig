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
    sda_pin: ?gpio.Pin = gpio.num(20), // both pins only have I²C as alternate function
    scl_pin: ?gpio.Pin = gpio.num(21), // both pins only have I²C as alternate function
    baud_rate: u32 = 100_000,
};

pub fn num(n: u1) I2C {
    return @as(I2C, @enumFromInt(n));
}

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

pub const I2C = enum(u1) {
    _,

    fn get_regs(i2c: I2C) *volatile I2cRegs {
        return switch (@intFromEnum(i2c)) {
            0 => I2C0,
            1 => I2C1,
        };
    }

    fn disable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .{ .value = .DISABLED },
            .ABORT = .{ .value = .DISABLE },
            .TX_CMD_BLOCK = .{ .value = .NOT_BLOCKED },
            .padding = 0,
        });
    }

    fn enable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .{ .value = .ENABLED },
            .ABORT = .{ .value = .DISABLE },
            .TX_CMD_BLOCK = .{ .value = .NOT_BLOCKED },
            .padding = 0,
        });
    }

    /// Initialise the I2C HW block.
    pub fn apply(i2c: I2C, comptime config: Config) u32 {
        const peri_freq = (comptime config.clock_config.get_frequency(.clk_sys)) orelse @compileError("clk_sys must be set for I²C");

        const regs = i2c.get_regs();

        i2c.disable();

        regs.IC_ENABLE.write(.{
            .ENABLE = .{ .value = .DISABLED },
            .ABORT = .{ .value = .DISABLE },
            .TX_CMD_BLOCK = .{ .value = .NOT_BLOCKED },
            .padding = 0,
        });

        // Configure as a fast-mode master with RepStart support, 7-bit addresses
        regs.IC_CON.write(.{
            .MASTER_MODE = .{ .value = .ENABLED },
            .SPEED = .{ .value = .FAST },
            .IC_RESTART_EN = .{ .value = .ENABLED },
            .IC_SLAVE_DISABLE = .{ .value = .SLAVE_DISABLED },
            .TX_EMPTY_CTRL = .{ .value = .ENABLED },

            .IC_10BITADDR_SLAVE = .{ .raw = 0 },
            .IC_10BITADDR_MASTER = .{ .raw = 0 },
            .STOP_DET_IFADDRESSED = .{ .raw = 0 },
            .RX_FIFO_FULL_HLD_CTRL = .{ .raw = 0 },
            .STOP_DET_IF_MASTER_ACTIVE = 0,
            .padding = 0,
        });

        // Set FIFO watermarks to 1 to make things simpler. This is encoded by a register value of 0.
        regs.IC_RX_TL.write(.{ .RX_TL = 0, .padding = 0 });
        regs.IC_TX_TL.write(.{ .TX_TL = 0, .padding = 0 });

        // Always enable the DREQ signalling -- harmless if DMA isn't listening
        regs.IC_DMA_CR.write(.{
            .RDMAE = .{ .value = .ENABLED },
            .TDMAE = .{ .value = .ENABLED },
            .padding = 0,
        });

        if (config.sda_pin) |pin| {
            pin.set_function(.i2c);
            pin.set_pull(.up);
            // TODO: Set slew rate
        }
        if (config.scl_pin) |pin| {
            pin.set_function(.i2c);
            pin.set_pull(.up);
            // TODO: Set slew rate
        }

        // Re-sets regs.enable upon returning:
        return i2c.set_baudrate(config.baud_rate, peri_freq);
    }

    /// Set I2C baudrate.
    pub fn set_baudrate(i2c: I2C, baud_rate: u32, freq_in: u32) u32 {
        std.debug.assert(baud_rate != 0);
        // I2C is synchronous design that runs from clk_sys

        const regs = i2c.get_regs();

        // TODO there are some subtleties to I2C timing which we are completely ignoring here
        const period: u32 = (freq_in + baud_rate / 2) / baud_rate;
        const lcnt: u32 = period * 3 / 5; // oof this one hurts
        const hcnt: u32 = period - lcnt;

        // Check for out-of-range divisors:
        std.debug.assert(hcnt <= std.math.maxInt(u16));
        std.debug.assert(lcnt <= std.math.maxInt(u16));
        std.debug.assert(hcnt >= 8);
        std.debug.assert(lcnt >= 8);

        // Per I2C-bus specification a device in standard or fast mode must
        // internally provide a hold time of at least 300ns for the SDA signal to
        // bridge the undefined region of the falling edge of SCL. A smaller hold
        // time of 120ns is used for fast mode plus.
        const sda_tx_hold_count: u32 = if (baud_rate < 1_000_000)
            // sda_tx_hold_count = freq_in [cycles/s] * 300ns * (1s / 1e9ns)
            // Reduce 300/1e9 to 3/1e7 to avoid numbers that don't fit in uint.
            // Add 1 to avoid division truncation.
            ((freq_in * 3) / 10000000) + 1
        else
            // sda_tx_hold_count = freq_in [cycles/s] * 120ns * (1s / 1e9ns)
            // Reduce 120/1e9 to 3/25e6 to avoid numbers that don't fit in uint.
            // Add 1 to avoid division truncation.
            ((freq_in * 3) / 25000000) + 1;

        std.debug.assert(sda_tx_hold_count <= lcnt - 2);

        i2c.disable();

        // Always use "fast" mode (<= 400 kHz, works fine for standard mode too)
        regs.IC_CON.modify(.{ .SPEED = .{ .value = .FAST } });
        regs.IC_FS_SCL_HCNT.write(.{ .IC_FS_SCL_HCNT = @as(u16, @intCast(hcnt)), .padding = 0 });
        regs.IC_FS_SCL_LCNT.write(.{ .IC_FS_SCL_LCNT = @as(u16, @intCast(lcnt)), .padding = 0 });
        regs.IC_FS_SPKLEN.write(.{ .IC_FS_SPKLEN = if (lcnt < 16) 1 else @as(u8, @intCast(lcnt / 16)), .padding = 0 });
        regs.IC_SDA_HOLD.modify(.{ .IC_SDA_TX_HOLD = @as(u16, @intCast(sda_tx_hold_count)) });

        i2c.enable();

        return freq_in / period;
    }

    // /// Set I2C port to slave mode.
    // pub fn set_slave_mode(i2c: I2C, slave: bool, addr: u8) void {
    //     //
    // }

    pub const WriteBlockingUntilError = error{ DeviceNotPresent, NoAcknowledge, Timeout };

    /// Attempt to write specified number of bytes to address, blocking until the specified absolute time is reached.
    pub fn write_blocking_until(i2c: I2C, addr: Address, src: []const u8, until: time.Absolute) WriteBlockingUntilError!usize {
        const Timeout = struct {
            limit: time.Absolute,
            inline fn perform(tc: @This()) !void {
                if (tc.limit.is_reached())
                    return error.Timeout;
            }
        };
        return i2c.write_blocking_internal(addr, src, Timeout{ .limit = until });
    }

    pub const ReadBlockingUntilError = error{ DeviceNotPresent, NoAcknowledge, Timeout };

    /// Attempt to read specified number of bytes from address, blocking until the specified absolute time is reached.
    pub fn read_blocking_until(i2c: I2C, addr: Address, dst: []u8, until: time.Absolute) ReadBlockingUntilError!usize {
        const Timeout = struct {
            limit: time.Absolute,
            inline fn perform(tc: @This()) !void {
                if (tc.limit.is_reached())
                    return error.Timeout;
            }
        };
        return i2c.read_blocking_internal(addr, dst, Timeout{ .limit = until });
    }

    pub const WriteTimeoutUsError = error{ DeviceNotPresent, NoAcknowledge, Timeout };

    /// Attempt to write specified number of bytes to address, with timeout.
    pub fn write_timeout_us(i2c: I2C, addr: Address, src: []const u8, timeout: time.Duration) WriteTimeoutUsError!usize {
        return i2c.write_blocking_until(addr, src, time.get_time_since_boot().add_duration(timeout));
    }

    pub const ReadTimeoutUsError = error{ DeviceNotPresent, NoAcknowledge, Timeout };

    /// Attempt to read specified number of bytes from address, with timeout.
    pub fn read_timeout_us(i2c: I2C, addr: Address, dst: []u8, timeout: time.Duration) ReadTimeoutUsError!usize {
        return i2c.read_blocking_until(addr, dst, time.get_time_since_boot().add_duration(timeout));
    }

    /// Attempt to write specified number of bytes to address, blocking.
    pub const WriteBlockingError = error{ DeviceNotPresent, NoAcknowledge, Unexpected };
    pub fn write_blocking(i2c: I2C, addr: Address, src: []const u8) WriteBlockingError!usize {
        const Timeout = struct {
            inline fn perform(tc: @This()) !void {
                _ = tc;
            }
        };
        return try i2c.write_blocking_internal(addr, src, Timeout{});
    }

    /// Attempt to read specified number of bytes from address, blocking.
    pub const ReadBlockingError = error{ DeviceNotPresent, NoAcknowledge, Unexpected };
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8) ReadBlockingError!usize {
        const Timeout = struct {
            inline fn perform(tc: @This()) !void {
                _ = tc;
            }
        };
        try i2c.read_blocking_internal(addr, dst, Timeout{});
    }

    /// Determine non-blocking write space available.
    pub inline fn get_write_available(i2c: I2C) u5 {
        return i2c.get_regs().IC_TXFLR.read().TXFLR;
    }

    /// Determine number of bytes received.
    pub inline fn get_read_available(i2c: I2C) u5 {
        return i2c.get_regs().IC_RXFLR.read().RXFLR;
    }

    // /// Write direct to TX FIFO.
    // pub fn write_raw_blocking(i2c: I2C, src: []const u8) void {
    //     //
    // }

    // /// Read direct from RX FIFO.
    // pub fn read_raw_blocking(i2c: I2C, dst: []u8) void {
    //     //
    // }

    // /// Pop a byte from I2C Rx FIFO.
    // pub fn read_byte_raw(i2c: I2C) u8 {
    //     //
    // }

    // /// Push a byte into I2C Tx FIFO.
    // pub fn write_byte_raw(i2c: I2C, value: u8) void {
    //     //
    // }

    // /// Return the DREQ to use for pacing transfers to/from a particular I2C instance.
    // pub fn get_dreq(i2c: I2C, is_tx: bool) u32 {
    //     //
    // }

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

    fn write_blocking_internal(i2c: I2C, addr: Address, src: []const u8, timeout_check: anytype) !usize {
        std.debug.assert(!addr.is_reserved());
        // Synopsys hw accepts start/stop flags alongside data items in the same
        // FIFO word, so no 0 byte transfers.
        std.debug.assert(src.len > 0);

        const regs = i2c.get_regs();

        i2c.set_address(addr);

        {
            // If the transaction was aborted or if it completed
            // successfully wait until the STOP condition has occured.
            defer blk: {

                // TODO Could there be an abort while waiting for the STOP
                // condition here? If so, additional code would be needed here
                // to take care of the abort.
                while (regs.IC_RAW_INTR_STAT.read().STOP_DET.value == .INACTIVE) {
                    timeout_check.perform() catch break :blk;
                    hw.tight_loop_contents();
                }

                // If there was a timeout, don't attempt to do anything else.
                _ = regs.IC_CLR_STOP_DET.read();
            }

            for (src, 0..) |byte, i| {
                const first = (i == 0);
                const last = (i == (src.len - 1));

                regs.IC_DATA_CMD.write(.{
                    .RESTART = .{ .raw = @intFromBool(first) }, // TODO: Implement non-restarting variant
                    .STOP = .{ .raw = @intFromBool(last) }, // TODO: Implement non-restarting variant
                    .CMD = .{ .value = .WRITE },
                    .DAT = byte,

                    .FIRST_DATA_BYTE = .{ .value = .INACTIVE },
                    .padding = 0,
                });

                // Wait until the transmission of the address/data from the internal
                // shift register has completed. For this to function correctly, the
                // TX_EMPTY_CTRL flag in IC_CON must be set. The TX_EMPTY_CTRL flag
                // was set in i2c_init.
                while (regs.IC_RAW_INTR_STAT.read().TX_EMPTY.value == .INACTIVE) {
                    try timeout_check.perform();
                    hw.tight_loop_contents();
                }

                const abort_reason = regs.IC_TX_ABRT_SOURCE.read();
                if (@as(u32, @bitCast(abort_reason)) != 0) {
                    // Note clearing the abort flag also clears the reason, and
                    // this instance of flag is clear-on-read! Note also the
                    // IC_CLR_TX_ABRT register always reads as 0.
                    _ = regs.IC_CLR_TX_ABRT.read();

                    if (abort_reason.ABRT_7B_ADDR_NOACK.value == .ACTIVE) {
                        // No reported errors - seems to happen if there is nothing connected to the bus.
                        // Address byte not acknowledged
                        return error.DeviceNotPresent;
                    }
                    if (abort_reason.ABRT_TXDATA_NOACK.value == .ABRT_TXDATA_NOACK_GENERATED) {
                        // TODO: How to handle this, also possible to do "return i;" here to signal not everything was transferred
                        return error.NoAcknowledge;
                    }

                    std.log.debug("unexpected i2c abort while writing to {}: {}", .{ addr, abort_reason });
                    return error.Unexpected;
                }
            }
        }

        return src.len;
    }

    fn read_blocking_internal(i2c: I2C, addr: Address, dst: []u8, timeout_check: anytype) !usize {
        std.debug.assert(!addr.is_reserved());

        const regs = i2c.get_regs();

        i2c.set_address(addr);

        for (dst, 0..) |*byte, i| {
            const first = (i == 0);
            const last = (i == dst.len - 1);
            while (i2c.get_write_available(i2c) == 0) {
                hw.tight_loop_contents();
            }

            regs.IC_DATA_CMD.write(.{
                .RESTART = .{ .raw = @intFromBool(first) }, // TODO: Implement non-restarting variant
                .STOP = .{ .raw = @intFromBool(last) }, // TODO: Implement non-restarting variant
                .CMD = .{ .value = .READ },

                .DAT = 0,
                .FIRST_DATA_BYTE = .{ .value = 0 },
                .padding = 0,
            });

            while (i2c.get_read_available() == 0) {
                const abort_reason = regs.IC_TX_ABRT_SOURCE.read();
                const abort = (regs.IC_CLR_TX_ABRT.read().CLR_TX_ABRT != 0);
                if (abort) {
                    if (abort_reason.ABRT_7B_ADDR_NOACK.value == .ACTIVE)
                        return error.DeviceNotPresent;
                    std.log.debug("unexpected i2c abort while reading from {}: {}", .{ addr, abort_reason });
                    return error.Unexpected;
                }

                try timeout_check.perform();
            }

            byte.* = regs.IC_DATA_CMD.read().DAT;
        }

        return dst.len;
    }
};
