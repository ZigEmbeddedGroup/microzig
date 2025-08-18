const std = @import("std");

const microzig = @import("microzig");
const mdf = microzig.drivers;
const peripherals = microzig.chip.peripherals;
const compatibility = @import("compatibility.zig");
const drivers = mdf.base;

const gpio = @import("gpio.zig");
const time = @import("time.zig");

const version: enum {
    nrf5283x,
    nrf52840,
} = switch (compatibility.chip) {
    .nrf52, .nrf52833 => .nrf5283x,
    .nrf52840 => .nrf52840,
    else => compatibility.unsupported_chip("I2C"),
};

const I2C0 = peripherals.TWI0;
const I2C1 = peripherals.TWI1;

const I2cRegs = microzig.chip.types.peripherals.TWI0;

const Config = struct {
    scl_pin: gpio.Pin,
    sda_pin: gpio.Pin,
    frequency: enum {
        @"100000",
        @"250000",
        @"400000",
    } = .@"100000",
};

pub const Address = drivers.I2C_Device.Address;
pub const AddressError = drivers.I2C_Device.Address.Error;
pub const Error = drivers.I2C_Device.Error || error{Overrun};

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
            .nrf5283x => regs.PSELSCL.raw = @intFromEnum(config.scl_pin),
            .nrf52840 => regs.PSEL.SCL.write(.{
                .PIN = config.scl_pin.index(),
                .PORT = config.scl_pin.port(),
                .CONNECT = .Connected,
            }),
        }

        config.sda_pin.set_direction(.in);
        config.sda_pin.set_drive_strength(.SOD1);
        switch (version) {
            .nrf5283x => regs.PSELSDA.raw = @intFromEnum(config.sda_pin),
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
    }

    /// Disables I2C, returns peripheral registers to reset state.
    pub fn reset(i2c: I2C) void {
        i2c.disable();
        const regs = i2c.get_regs();
        regs.SHORTS.raw = 0x00000000;
        regs.INTENSET.raw = 0x00000000;
        regs.ERRORSRC.raw = 0xFFFFFFFF;
        switch (version) {
            .nrf5283x => {
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

    fn tx_sent(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_TXDSENT.read().EVENTS_TXDSENT == .Generated;
    }

    fn rx_ready(i2c: I2C) bool {
        return i2c.get_regs().EVENTS_RXDREADY.read().EVENTS_RXDREADY == .Generated;
    }

    fn write_byte(i2c: I2C, byte: u8, deadline: mdf.time.Deadline) Error!void {
        const regs = i2c.get_regs();
        regs.TXD.write(.{ .TXD = byte });
        while (!i2c.tx_sent()) {
            if (deadline.is_reached_by(time.get_time_since_boot()))
                return Error.Timeout;
            try i2c.check_and_clear_error();
            std.mem.doNotOptimizeAway(0);
        }
        regs.EVENTS_TXDSENT.raw = 0;
    }

    fn read_byte(i2c: I2C, deadline: mdf.time.Deadline) Error!u8 {
        const regs = i2c.get_regs();
        while (!i2c.rx_ready()) {
            if (deadline.is_reached_by(time.get_time_since_boot()))
                return Error.Timeout;
            try i2c.check_and_clear_error();
            std.mem.doNotOptimizeAway(0);
        }
        const v = regs.RXD.read().RXD;
        regs.EVENTS_RXDREADY.raw = 0;
        return v;
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

    fn set_address(i2c: I2C, addr: Address) Error!void {
        // TODO: Allow arg
        addr.check_reserved() catch return Error.IllegalAddress;

        i2c.disable();
        defer i2c.enable();
        i2c.get_regs().ADDRESS.write(.{
            .ADDRESS = @intFromEnum(addr),
        });
    }

    fn check_and_clear_error(i2c: I2C) Error!void {
        const regs = i2c.get_regs();
        const error_generated = regs.EVENTS_ERROR.read().EVENTS_ERROR == .Generated;
        if (error_generated) {
            // Clear error
            regs.EVENTS_ERROR.raw = 0x0000000;
            // We expect this to return an error, if it doesn't then we don't understand the error
            const error_src = try i2c.check_error();
            if (error_src != 0) {
                std.log.err("Unknown error source, EVENTS_ERROR=0x{X}", .{error_src});
                return Error.UnknownAbort;
            }
        }
    }

    fn check_error(i2c: I2C) Error!u32 {
        const regs = i2c.get_regs();
        const error_src = regs.ERRORSRC.read();

        if (error_src.OVERRUN == .Present) {
            // Byte was received before we read the last one
            return Error.Overrun;
        } else if (error_src.ANACK == .Present) {
            // NACK received after address (device not present)
            return Error.DeviceNotPresent;
        } else if (error_src.DNACK == .Present) {
            // NACK received after sending data
            return Error.NoAcknowledge;
        }
        return @bitCast(error_src);
    }

    /// Attempts to write number of bytes provided to target device and blocks until one of the following occurs:
    /// - Bytes have been transmitted successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn write_blocking(i2c: I2C, addr: Address, data: []const u8, timeout: ?mdf.time.Duration) Error!void {
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
    pub fn writev_blocking(i2c: I2C, addr: Address, chunks: []const []const u8, timeout: ?mdf.time.Duration) Error!void {
        addr.check_reserved() catch |err| switch (err) {
            AddressError.GeneralCall => {},
            else => return Error.TargetAddressReserved,
        };

        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(chunks);
        if (write_vec.size() == 0)
            return Error.NoData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        try i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();
        // Probably not needed, we never set them
        i2c.disable_interrupts();

        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        var iter = write_vec.iterator();
        while (iter.next_element()) |element|
            try i2c.write_byte(element.value, deadline);

        regs.TASKS_STOP.write(.{ .TASKS_STOP = .Trigger });
    }

    /// Attempts to read number of bytes in provided slice from target device and blocks until one
    /// of the following occurs:
    /// - Bytes have been read successfully
    /// - An error occurs and the transaction is aborted
    /// - The transaction times out (a null for timeout blocks indefinitely)
    ///
    pub fn read_blocking(i2c: I2C, addr: Address, dst: []u8, timeout: ?mdf.time.Duration) Error!void {
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
    pub fn readv_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) Error!void {
        addr.check_reserved() catch return Error.TargetAddressReserved;

        const read_vec = microzig.utilities.Slice_Vector([]u8).init(chunks);
        if (read_vec.size() == 0)
            return Error.NoData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        try i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();
        // Probably not needed, we never set them
        i2c.disable_interrupts();

        var iter = read_vec.iterator();
        var count: usize = 0;
        const total_len = read_vec.size();
        // If we want to read more than one byte, then we have to suspend between bytes,
        // otherwise automatically trigger a stop
        if (total_len > 1) {
            regs.SHORTS.modify(.{ .BB_SUSPEND = .Enabled });
        } else {
            regs.SHORTS.modify(.{ .BB_STOP = .Enabled });
        }

        // Start reception
        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });

        // Read bytes
        while (iter.next_element_ptr()) |element| {
            // Handle last byte specially
            if (count == total_len - 1) {
                // Stop after last byte
                regs.SHORTS.modify(.{ .BB_STOP = .Enabled });
                regs.TASKS_RESUME.write(.{ .TASKS_RESUME = .Trigger });
                element.value_ptr.* = try i2c.read_byte(deadline);
                break;
            }

            regs.TASKS_RESUME.write(.{ .TASKS_RESUME = .Trigger });
            element.value_ptr.* = try i2c.read_byte(deadline);
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
    /// NOTE: This function is a vectored `writev_blocking` and `readv_blocking` and takes an array
    ///       of arrays. This pattern allows one to create better zero-copy send routines as message
    ///       prefixes and suffixes won't need to be concatenated/inserted to the original buffer,
    ///       but can be managed in a separate memory.
    ///
    pub fn writev_then_readv_blocking(i2c: I2C, addr: Address, write_chunks: []const []const u8, read_chunks: []const []u8, timeout: ?mdf.time.Duration) Error!void {
        addr.check_reserved() catch return Error.TargetAddressReserved;

        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(write_chunks);
        const read_vec = microzig.utilities.Slice_Vector([]u8).init(read_chunks);

        if (write_vec.size() == 0)
            return Error.NoData;
        if (read_vec.size() == 0)
            return Error.NoData;

        const regs = i2c.get_regs();
        const deadline = mdf.time.Deadline.init_relative(time.get_time_since_boot(), timeout);

        try i2c.set_address(addr);

        i2c.clear_shorts();
        i2c.clear_events();
        i2c.clear_errors();
        // Probably not needed, we never set them
        i2c.disable_interrupts();

        regs.TASKS_STARTTX.write(.{ .TASKS_STARTTX = .Trigger });

        // Write provided bytes to device
        var write_iter = write_vec.iterator();
        while (write_iter.next_element()) |element|
            try i2c.write_byte(element.value, deadline);

        // Read back requested bytes immediately following a repeated start
        var read_iter = read_vec.iterator();
        var count: usize = 0;
        const total_len = read_vec.size();
        // If we want to read more than one byte, then we have to suspend between bytes,
        // otherwise automatically trigger a stop
        if (total_len > 1) {
            regs.SHORTS.modify(.{ .BB_SUSPEND = .Enabled });
        } else {
            regs.SHORTS.modify(.{ .BB_STOP = .Enabled });
        }

        // We start the RX task without stopping the TX task
        regs.TASKS_STARTRX.write(.{ .TASKS_STARTRX = .Trigger });

        // Read bytes
        while (read_iter.next_element_ptr()) |element| {
            // Handle last byte specially
            if (count == total_len - 1) {
                // Stop after last byte
                regs.SHORTS.modify(.{ .BB_STOP = .Enabled });
                regs.TASKS_RESUME.write(.{ .TASKS_RESUME = .Trigger });
                element.value_ptr.* = try i2c.read_byte(deadline);
                break;
            }

            regs.TASKS_RESUME.write(.{ .TASKS_RESUME = .Trigger });
            element.value_ptr.* = try i2c.read_byte(deadline);
            count += 1;
        }
    }
};
