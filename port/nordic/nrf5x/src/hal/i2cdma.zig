const std = @import("std");

const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");

const gpio = @import("gpio.zig");
const time = @import("time.zig");

const version: enum {
    nrf5283x,
    nrf52840,
} = switch (compatibility.chip) {
    .nrf52832, .nrf52833 => .nrf5283x,
    .nrf52840 => .nrf52840,
    else => compatibility.unsupported_chip("DMA I2C"),
};

// "Two Wire Interface Master"
const I2C0 = peripherals.TWIM0;
const I2C1 = peripherals.TWIM1;

const I2cRegs = microzig.chip.types.peripherals.TWIM0;

const Config = struct {
    scl_pin: gpio.Pin,
    sda_pin: gpio.Pin,
    // TODO: Name these more nicely
    frequency: enum {
        @"100000",
        @"250000",
        @"400000",
    } = .@"100000",
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
    Overrun,
    TooMuchData,
    Transmit,
    Receive,
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
        switch (version) {
            .nrf5283x => regs.PSEL.SCL.write(.{
                .PIN = config.scl_pin.index(),
                .CONNECT = .Connected,
            }),
            .nrf52840 => regs.PSEL.SCL.write(.{
                .PIN = config.scl_pin.index(),
                .PORT = config.scl_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        config.sda_pin.set_direction(.in);
        config.sda_pin.set_drive_strength(.SOD1);
        switch (version) {
            .nrf5283x => regs.PSEL.SDA.write(.{
                .PIN = config.sda_pin.index(),
                .CONNECT = .Connected,
            }),
            .nrf52840 => regs.PSEL.SDA.write(.{
                .PIN = config.sda_pin.index(),
                .PORT = config.sda_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        regs.FREQUENCY.write(.{
            .FREQUENCY = switch (config.frequency) {
                .@"100000" => .K100,
                .@"250000" => .K250,
                .@"400000" => .K400,
            },
        });

        i2c.disable_interrupts();
    }

    /// Disables I2C, returns peripheral registers to reset state.
    pub fn reset(i2c: I2C) void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.SHORTS.raw = 0x00000000;
        regs.INTENSET.raw = 0x00000000;
        regs.ERRORSRC.raw = 0xFFFFFFFF;
        regs.PSEL.SCL.raw = 0xFFFFFFFF;
        regs.PSEL.SDA.raw = 0xFFFFFFFF;
        regs.FREQUENCY.raw = 0x04000000;
        regs.ADDRESS.raw = 0x00000000;
    }

    fn tx_sent(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_TXDSENT.read().EVENTS_TXDSENT == .Generated;
    }

    fn rx_ready(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_RXDREADY.read().EVENTS_RXDREADY == .Generated;
    }

    fn set_tx_buffer(i2c: I2C, buf: []const u8) void {
        const regs = i2c.get_regs();
        regs.TXD.PTR.write(.{ .PTR = @intFromPtr(buf.ptr) });
        regs.TXD.MAXCNT.write(.{ .MAXCNT = @truncate(buf.len) });
    }

    fn set_rx_buffer(i2c: I2C, buf: []u8) void {
        const regs = i2c.get_regs();
        regs.RXD.PTR.write(.{ .PTR = @intFromPtr(buf.ptr) });
        regs.RXD.MAXCNT.write(.{ .MAXCNT = @truncate(buf.len) });
    }

    fn set_address(i2c: I2C, addr: Address) void {
        i2c.disable();
        defer i2c.enable();
        i2c.get_regs().ADDRESS.write(.{
            .ADDRESS = @intFromEnum(addr),
        });
    }

    fn clear_shorts(i2c: I2C) void {
        const regs = i2c.get_regs();
        regs.SHORTS.raw = 0x00000000;
    }

    fn clear_events(i2c: I2C) void {
        const regs = i2c.get_regs();
        regs.EVENTS_SUSPENDED.raw = 0;
        regs.EVENTS_STOPPED.raw = 0;
        regs.EVENTS_ERROR.raw = 0;
    }

    fn clear_errors(i2c: I2C) void {
        const regs = i2c.get_regs();
        regs.ERRORSRC.raw = 0xFFFFFFFF;
    }

    fn disable_interrupts(i2c: I2C) void {
        const regs = i2c.get_regs();
        // NOTE: Ignore `.Enabled`, this is write to clear
        regs.INTENCLR.modify(.{
            .STOPPED = .Enabled,
            .ERROR = .Enabled,
            .SUSPENDED = .Enabled,
        });
    }

    fn check_error(i2c: I2C) TransactionError!u32 {
        const regs = i2c.get_regs();
        const abort_reason = regs.ERRORSRC.read();

        if (abort_reason.OVERRUN == .Received) {
            // Byte was received before we read the last one
            return TransactionError.Overrun;
        } else if (abort_reason.ANACK == .Received) {
            // NACK received after address (device not present)
            return TransactionError.DeviceNotPresent;
        } else if (abort_reason.DNACK == .Received) {
            // NACK received after sending data
            return TransactionError.NoAcknowledge;
        }
        return @bitCast(abort_reason);
    }

    fn check_rx(i2c: I2C, len: usize) TransactionError!void {
        const regs = i2c.get_regs();
        const bytes_read = regs.RXD.AMOUNT.read().AMOUNT;
        if (bytes_read != len) {
            return TransactionError.Receive;
        }
    }

    fn check_tx(i2c: I2C, len: usize) TransactionError!void {
        const regs = i2c.get_regs();
        const bytes_written = regs.TXD.AMOUNT.read().AMOUNT;
        if (bytes_written != len) {
            return TransactionError.Transmit;
        }
    }

    /// Wait until the task is stopped or suspended, there's an error, or we timeout.
    fn wait(i2c: I2C, deadline: mdf.time.Deadline) TransactionError!void {
        const regs = i2c.get_regs();
        while (true) {
            if (regs.EVENTS_SUSPENDED.read().EVENTS_SUSPENDED == .Generated or
                regs.EVENTS_STOPPED.read().EVENTS_STOPPED == .Generated)
            {
                regs.EVENTS_STOPPED.raw = 0;
                break;
            }
            // Stop the task on error, but we need to keep waiting until the stop event
            if (regs.EVENTS_ERROR.read().EVENTS_ERROR == .Generated) {
                regs.EVENTS_ERROR.raw = 0;
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
            }
            if (deadline.is_reached_by(time.get_time_since_boot())) {
                regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
                return TransactionError.Timeout;
            }
        }
    }

    /// Attempts to write number of bytes provided to target device and blocks until one of the
    /// following occurs:
    /// - Bytes have been transmitted successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn write_blocking(i2c: I2C, addr: Address, data: []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        // TODO: We can handle this if for some reason we want to send a start and immediate stop?
        if (data.len == 0)
            return TransactionError.NoData;

        // TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
        // nRF52831
        const tx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "TXD"), "MAXCNT").underlying_type, "MAXCNT");
        if (std.math.cast(tx_cnt_type, data.len) == null)
            return TransactionError.TooMuchData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();
        // Probably not needed, we never set them
        i2c.disable_interrupts();

        i2c.set_tx_buffer(data);

        // TODO: We only set the stop one if this is the last transaction... we could handle writev
        // this way probably. If it's not the last chunk, then just suspend
        // Set it up to automatically stop after sending the last byte
        regs.SHORTS.modify(.{ .LASTTX_STOP = .Enabled });

        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        try i2c.wait(deadline);
        // Read the error
        _ = try i2c.check_error();
        try i2c.check_tx(data.len);
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one
    /// of the following occurs:
    /// - Bytes have been read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        // TODO: We can handle this if for some reason we want to send a start and immediate stop?
        if (dst.len == 0)
            return TransactionError.NoData;

        // TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
        // nRF52831
        const rx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "RXD"), "MAXCNT").underlying_type, "MAXCNT");
        if (std.math.cast(rx_cnt_type, dst.len) == null)
            return TransactionError.TooMuchData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();

        // Probably not needed, we never set them
        i2c.disable_interrupts();

        i2c.set_rx_buffer(dst);

        // TODO: We only set the stop one if this is the last transaction... we could handle writev
        // this way probably. If it's not the last chunk, then just suspend
        // Set it up to automatically stop after receiving the last expected byte
        regs.SHORTS.modify(.{ .LASTRX_STOP = .Enabled });

        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });

        try i2c.wait(deadline);
        // Read the error
        _ = try i2c.check_error();
        try i2c.check_rx(dst.len);
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
    pub fn write_then_read_blocking(i2c: I2C, addr: Address, data: []const u8, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        if (addr.is_reserved())
            return TransactionError.TargetAddressReserved;

        // TODO: We can handle this actually
        if (data.len == 0)
            return TransactionError.NoData;
        if (dst.len == 0)
            return TransactionError.NoData;

        // TODO: There has got to be a nicer way to do this. MAXCNT is u16 on nRF52840, and u8 on
        // nRF52831
        const tx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "TXD"), "MAXCNT").underlying_type, "MAXCNT");
        if (std.math.cast(tx_cnt_type, data.len) == null)
            return TransactionError.TooMuchData;
        const rx_cnt_type = @FieldType(@FieldType(@FieldType(I2cRegs, "RXD"), "MAXCNT").underlying_type, "MAXCNT");
        if (std.math.cast(rx_cnt_type, dst.len) == null)
            return TransactionError.TooMuchData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();

        // Probably not needed, we never set them
        i2c.disable_interrupts();

        i2c.set_tx_buffer(data);
        i2c.set_rx_buffer(dst);

        // Set it up to automatically start a read after it's finished writing, and stop after it's
        // finished reading.
        regs.SHORTS.modify(.{
            .LASTTX_STARTRX = .Enabled,
            .LASTRX_STOP = .Enabled,
        });

        // Trigger transaction
        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        try i2c.wait(deadline);
        // Read the error
        _ = try i2c.check_error();
        try i2c.check_rx(dst.len);
        try i2c.check_tx(data.len);
    }
};
