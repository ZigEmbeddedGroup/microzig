//!
//! This file implements the I²C driver for the esp32c3 chip family.
//!
//! Useful links:
//!     (Unofficial) I²C Reference: https://www.i2c-bus.org/
//!
const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const I2C0 = peripherals.I2C0;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const time = @import("time.zig");

// This is the type, not the struct
const I2cRegs = microzig.chip.types.peripherals.I2C0;
// I2C registers are configured in APB_CLK domain, whereas the I2C controller is configured in asynchronous
// I2C_SCLK domain. Therefore, before being used by the I2C controller, register values should be synchronized
// by first writing configuration registers and then writing 1 to I2C_CONF_UPGATE. Registers that need
// synchronization are listed in Table 28.4-1.
// Clear I2C_SCL_FORCE_OUT and I2C_SDA_FORCE_OUT to make SCL and SDA pins open-drain

// i2c_master_bus_config_t i2c_mst_config_1 = {
//     .clk_source = I2C_CLK_SRC_DEFAULT,
//     .i2c_port = TEST_I2C_PORT,
//     .scl_io_num = I2C_MASTER_SCL_IO,
//     .sda_io_num = I2C_MASTER_SDA_IO,
//     .glitch_ignore_cnt = 7,
//     .flags.enable_internal_pullup = true,
// };
pub const Config = struct {
    mode: enum { master, slave },
    // TODO: gpios?
    sda_io_num: usize,
    sda_pullup_en: bool,
    scl_io_num: usize,
    scl_pullup_en: bool,
    // clock speed, separate for master and slave
    clock_config: clocks.config.Global,
    // TODO: Clock source for master can be XTAL or RTC
};

pub const Command = union(enum) {
    Start,
    Stop,
    End,
    Write: struct {
        ack_exp: enum(u1) { Ack = 0, Nack = 1 },
        ack_check_en: bool,
        length: u8,
    },
    Read,
};

// TODO: Taken from rp2xxx. Could we make some common hal?
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

// Maybe enum. How many i2c devices are there? 1
pub const I2C = enum(u1) {
    _,
    inline fn get_regs(i2c: I2C) *volatile I2cRegs {
        _ = i2c;
        return I2C0;
    }

    inline fn disable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .DISABLED,
            .ABORT = .DISABLE,
            .TX_CMD_BLOCK = .NOT_BLOCKED,
            .padding = 0,
        });
    }

    inline fn enable(i2c: I2C) void {
        i2c.get_regs().IC_ENABLE.write(.{
            .ENABLE = .ENABLED,
            .ABORT = .DISABLE,
            .TX_CMD_BLOCK = .NOT_BLOCKED,
            .padding = 0,
        });
    }
    pub fn apply(i2c: I2C, comptime config: Config) ConfigError!void {
        // i2c_new_master_bus(config, &handle);
        i2c.get_regs().CTR.modify(.{
            .MS_MODE = 1, // master
            .SDA_FORCE_OUT = 1, // open drain
            .SCL_FORCE_OUT = 1, // open drain
            .TX_LSB_FIRST = 0,
            .RX_LSB_FIRST = 0,
            .CLK_EN = 1,
        });

        // Set frequency
        // Reset peripheral and FIFO
        i2c.reset();
    }

    fn reset(i2c: I2C) void {
        // Reset FSM
        i2c.get_regs().CTR.modify(.{ .FSM_RST = 1 });
        // Clear all interrupts
        i2c.get_regs().INT_CLR.write(.{
            .TRANS_COMPLETE_INT_CLR = 1,
            .END_DETECT_INT_CLR = 1,
            .NACK_INT_CLR = 1,
        });

        i2c.reset_fifo();
        i2c.reset_command_list();
    }
    fn reset_command_list(i2c: I2C) void {
        _ = i2c;
        // for all 8 commands in i2c.get_regs().COMD, reset them. Maybe by setting all to 0?
    }

    fn reset_fifo(i2c: I2C) void {
        i2c.get_regs().FIFO_CONF.modify(.{
            .RX_FIFO_RST = 1,
            .TX_FIFO_RST = 1,
            .NONFIFO_EN = 0,
            .FIFO_PRT_EN = 1,
            .RXFIFO_WM_THRHD = 1,
            .TX_FIFO_WM_THRHD = 8,
        });

        i2c.get_regs().FIFO_CONF.modify(.{
            .RX_FIFO_RST = 0,
            .TX_FIFO_RST = 0,
        });

        // write to clear?
        i2c.get_regs().INT_CLR.write(.{
            .RXFIFO_WM_INT_CLR = 1,
            .TXFIFO_WM_INT_CLR = 1,
        });

        i2c.update_config();
    }

    fn update_config(i2c: I2C) void {
        i2c.get_regs().CTR.modify(.{ .CONF_UPDATE = 1 });
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

        // TODO: Add a start command
        // TODO: Setup write
        // TODO: Add End command
        // TODO: Start transmission

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
                .padding = 0,
            });
            // If an abort occurrs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
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
                .padding = 0,
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

    /// Attempts to write number of bytes provided to target device and then immediately read bytes following a repeated
    /// start command (or Start + Stop if repeated start is disabled). Blocks until one of the following occurs:
    /// - Bytes have been transmitted and read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    /// This is useful for the common scenario of writing an address to a target device, and then immediately reading bytes from that address
    ///
    /// NOTE: This function is a vectored version of `read_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
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
        send_loop: while (write_iter.next_element()) |element| {
            regs.IC_DATA_CMD.write(.{
                .RESTART = @enumFromInt(0),
                .STOP = @enumFromInt(0),
                .CMD = .WRITE,
                .DAT = element.value,

                .FIRST_DATA_BYTE = .INACTIVE,
                .padding = 0,
            });
            // If an abort occurrs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
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
                break :send_loop;
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
                .padding = 0,
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
