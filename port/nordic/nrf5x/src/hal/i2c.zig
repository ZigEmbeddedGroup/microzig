const std = @import("std");

const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");

const gpio = @import("gpio.zig");
const time = @import("time.zig");

const I2C0 = peripherals.TWI0;
const I2C1 = peripherals.TWI1;

const I2cRegs = microzig.chip.types.peripherals.TWI0;

const Config = struct {
    scl_pin: gpio.Pin,
    sda_pin: gpio.Pin,
    // TODO: Name these more nicely
    frequency: enum {
        K100,
        K250,
        K400,
    } = .K100,
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

// TODO: Cleanup
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

pub fn num(n: u1) I2C {
    return @as(I2C, @enumFromInt(n));
}

pub const I2C = enum(u1) {
    _,

    fn get_regs(i2c: I2C) *volatile I2cRegs {
        return switch (@intFromEnum(i2c)) {
            0 => I2C0,
            1 => I2C1,
        };
    }

    inline fn disable(i2c: I2C) void {
        i2c.get_regs().ENABLE.write(.{
            .ENABLE = .Disabled,
        });
    }

    inline fn enable(i2c: I2C) void {
        i2c.get_regs().ENABLE.write(.{
            .ENABLE = .Enabled,
        });
    }

    pub fn apply(i2c: I2C, config: Config) !void {
        i2c.disable();
        defer i2c.enable();

        const regs = i2c.get_regs();

        // Pins must be setup as INPUT with SOD1 drive strength
        config.scl_pin.set_direction(.in);
        config.scl_pin.set_drive_strength(.SOD1);
        switch (compatibility.chip) {
            .nrf52 => regs.PSELSCL.raw = @intFromEnum(config.scl_pin),
            .nrf52840 => regs.PSEL.SCL.write(.{
                .PIN = config.scl_pin.index(),
                .PORT = config.scl_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        config.sda_pin.set_direction(.in);
        config.sda_pin.set_drive_strength(.SOD1);
        switch (compatibility.chip) {
            .nrf52 => regs.PSELSDA.raw = @intFromEnum(config.sda_pin),
            .nrf52840 => regs.PSEL.SDA.write(.{
                .PIN = config.sda_pin.index(),
                .PORT = config.sda_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        regs.FREQUENCY.write(.{
            .FREQUENCY = switch (config.frequency) {
                .K100 => .K100,
                .K250 => .K250,
                .K400 => .K400,
            },
        });
    }

    /// Disables I2C, returns peripheral registers to reset state.
    pub fn reset(i2c: I2C) void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.SHORTS.raw = 0x00000000;
        regs.INTENSET.raw = 0x00000000;
        regs.ERRORSRC.raw = 0x00000000;
        switch (compatibility.chip) {
            .nrf52 => {
                regs.PSELSCL.raw = 0xFFFFFFFF;
                regs.PSELSDA.raw = 0xFFFFFFFF;
            },
            .nrf52840 => {
                regs.PSEL.SCL.raw = 0xFFFFFFFF;
                regs.PSEL.SDA.raw = 0xFFFFFFFF;
            },
        }
        regs.FREQUENCY.raw = 0x04000000;
        regs.ADDRESS.raw = 0x00000000;
    }

    // TODO: This is the rp2xxx name, but it's a boolean here, so maybe we rename it. The nrf
    // doesn't seem to have a fifo!
    pub inline fn tx_fifo_available_spaces(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_TXDSENT.read().EVENTS_TXDSENT == .Generated;
    }

    // TODO: This is the rp2xxx name, but it's a boolean here, so maybe we rename it
    pub inline fn rx_fifo_bytes_ready(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_RXDREADY.read().EVENTS_RXDREADY == .Generated;
    }

    fn set_address(i2c: I2C, addr: Address) void {
        i2c.disable();
        defer i2c.enable();
        i2c.get_regs().ADDRESS.write(.{
            .ADDRESS = @intFromEnum(addr),
        });
    }

    /// Independent of successful write or abort, always ensure
    /// the STOP condition is generated and transaction is concluded before
    /// returning. The one exception is if timeout is hit, then return,
    /// potentially still leaving the I2C block in an "active" state.
    /// However, this avoids an infinite loop.
    fn ensure_stop_condition(i2c: I2C, deadline: mdf.time.Deadline) void {
        const regs = i2c.get_regs();
        while (regs.EVENTS_STOPPED.read().EVENTS_STOPPED != .Generated) {
            std.mem.doNotOptimizeAway(0);
            if (deadline.is_reached_by(time.get_time_since_boot()))
                break;
        }
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
        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        // TODO: Do we need this? I don't think so, the stop task should do this
        // defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        var iter = write_vec.iterator();
        while (iter.next_element()) |element| {
            regs.TXD.write(.{ .TXD = element.value });

            while (!i2c.tx_fifo_available_spaces()) {
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
                std.mem.doNotOptimizeAway(0);
            }
            // TODO: Do we need to do this?
            // try i2c.check_and_clear_abort();
            if (timed_out)
                break;
        }

        regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });

        // Waits until everything in the TX FIFO is either successfully transmitted, or flushed
        // due to an abort. This functions because of TX_EMPTY_CTRL being enabled in apply().
        // while (!i2c.tx_fifo_available_spaces()) {
        //     if (deadline.is_reached_by(time.get_time_since_boot())) {
        //         timed_out = true;
        //         break;
        //     }
        //     std.mem.doNotOptimizeAway(0);
        // }

        if (timed_out)
            return TransactionError.Timeout;
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one
    /// of the following occurs:
    /// - Bytes have been read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return try i2c.readv_blocking(addr, &.{dst}, timeout);
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one
    /// of the following occurs:
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
        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });

        // TODO: Do we need this? I don't think so, the stop task should do this
        // defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        var iter = read_vec.iterator();
        var count: usize = 0;
        const total_len = read_vec.size();
        while (iter.next_element_ptr()) |element| {
            while (true) {
                // TODO: Do we need to do this?
                // try i2c.check_and_clear_abort();
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
                if (i2c.rx_fifo_bytes_ready()) break;
            }

            if (timed_out)
                return TransactionError.Timeout;

            // NOTE: We must trigger STOPRX before receiving the last byte so that we properly NACK
            // HACKC:
            if (count == total_len - 1)
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
            element.value_ptr.* = regs.RXD.read().RXD;
            count += 1;
        }
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
        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        // TODO: Do we need this? I don't think so, the stop task should do this
        // defer i2c.ensure_stop_condition(deadline);

        var timed_out = false;

        // Write provided bytes to device
        var write_iter = write_vec.iterator();
        send_loop: while (write_iter.next_element()) |element| {
            regs.TXD.write(.{ .TXD = element.value });

            // If an abort occurrs, the TX/RX FIFO is flushed, and subsequent writes to IC_DATA_CMD
            // are ignored. If things work as expected, the TX FIFO gets drained naturally.
            // This makes it okay to poll on this and check for an abort after.
            // Note that this WILL loop infinitely if called when I2C is uninitialized and no
            // timeout is supplied!
            while (!i2c.tx_fifo_available_spaces()) {
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break;
                }
                std.mem.doNotOptimizeAway(0);
            }
            // TODO: Do we need to do this?
            // try i2c.check_and_clear_abort();
            if (timed_out)
                break :send_loop;
        }

        if (timed_out)
            return TransactionError.Timeout;

        // We start the RX stack without stopping the TX task
        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });
        // Read back requested bytes immediately following a repeated start
        var read_iter = read_vec.iterator();
        var count: usize = 0;
        const total_len = read_vec.size();
        recv_loop: while (read_iter.next_element_ptr()) |element| {
            while (true) {
                // TODO: Do we need to do this?
                // try i2c.check_and_clear_abort();
                if (deadline.is_reached_by(time.get_time_since_boot())) {
                    timed_out = true;
                    break :recv_loop;
                }

                if (i2c.rx_fifo_bytes_ready()) break;
            }

            // NOTE: We must trigger STOPRX before receiving the last byte so that we properly NACK
            // HACKC:
            if (count == total_len - 1)
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
            element.value_ptr.* = regs.RXD.read().RXD;
            count += 1;
        }

        if (timed_out)
            return TransactionError.Timeout;
    }
};
