const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const I2C_Device = microzig.hal.drivers.I2C_Device;
const peripherals = microzig.chip.peripherals;

const I2C0 = peripherals.I2C;
const RESET = microzig.chip.peripherals.RESET;

pub const Config = struct {
    baud: u8,
};

///
/// 7-bit I²C address, without the read/write bit.
///
pub const Address = enum(u7) {
    /// The general call addresses all devices on the bus using the I²C address 0.
    pub const general_call: Address = @enumFromInt(0x00);

    _,

    pub fn new(addr: u7) Address {
        const a: Address = @enumFromInt(addr);
        std.debug.assert(!is_reserved(addr));
        return a;
    }

    ///
    /// Returns `true` if the Address is a reserved I²C address.
    ///
    /// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
    ///
    /// See more here: https://www.i2c-bus.org/addressing/
    pub fn is_reserved(addr: u7) bool {
        return ((addr & 0x78) == 0) or ((addr & 0x78) == 0x78);
    }

    pub fn format(addr: Address, fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("I2C(0x{X:0>2})", .{@intFromEnum(addr)});
    }
};

const i2c = @This();

pub const instance = struct {
    pub const I2C: i2c.I2C = @enumFromInt(0);
    pub fn num(instance_number: u1) i2c.I2C {
        std.debug.assert(instance_number == 0);
        return @enumFromInt(instance_number);
    }
};

pub const TransactionError = error{
    NoAcknowledge,
    Timeout,
    TargetAddressReserved,
    NoData,
};

pub const ConfigError = error{
    UnsupportedBaudRate,
};

pub const I2C = enum(u1) {
    _,

    pub fn apply(self: I2C, comptime config: Config) ConfigError!void {
        self.reset();
        I2C0.TM.write(.{ .TM = config.baud });
        I2C0.ADDR.write(.{
            .I2CADR = 0,
            .GC = 0,
        });
    }

    pub inline fn reset(_: I2C) void {
        RESET.PREI_RESET.modify(.{
            .I2C = 0,
        });
        RESET.PREI_RESET.modify(.{
            .I2C = 1,
        });
    }

    pub inline fn enable(_: I2C) void {
        I2C0.TMRUN.write(.{
            // enable baudrate generation
            .TME = 1,
        });

        I2C0.CR.modify(.{
            // enable i2c module
            .ENS = 1,
            // enable high speed mode
            .H1M = 1,
        });
    }

    pub inline fn disable(_: I2C) void {
        I2C0.CR.modify(.{
            .TMRUN = 0,
            .ENS = 0,
            .H1M = 0,
        });
    }

    pub fn writev_blocking(self: I2C, address: Address, buffers: []const []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        // TODO: timeouts
        _ = timeout;

        const write_vec = microzig.utilities.Slice_Vector([]const u8).init(buffers);
        if (write_vec.size() == 0)
            return TransactionError.NoData;

        self.set_start();

        // send address
        self.wait_for_irq();
        {
            const state = self.get_state();
            switch (state) {
                0x08 => {}, // ACK
                else => @panic("invalid i2c state"),
            }
        }
        self.clear_start();
        self.write_data(@intFromEnum(address) << 1);
        self.clear_irq();

        // wait for ack/nack
        self.wait_for_irq();
        {
            const state = self.get_state();
            switch (state) {
                0x18 => {}, // ACK
                0x20 => return error.NoAcknowledge,
                else => @panic("invalid i2c state"),
            }
        }

        var iter = write_vec.iterator();
        while (iter.next_element()) |element| {
            self.write_data(element.value);
            self.clear_irq();

            self.wait_for_irq();
            const state = self.get_state();
            switch (state) {
                0x28 => {}, // ACK
                0x20 => return error.NoAcknowledge,
                else => @panic("invalid i2c state"),
            }
        }

        self.set_stop();
        self.clear_irq();
    }

    pub fn write_blocking(self: I2C, address: Address, data: []const u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return self.writev_blocking(address, &.{data}, timeout);
    }

    pub fn readv_blocking(self: I2C, address: Address, buffers: []const []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        // TODO: timeouts
        _ = timeout;

        const write_vec = microzig.utilities.Slice_Vector([]u8).init(buffers);
        const total_size = write_vec.size();
        if (total_size == 0)
            return TransactionError.NoData;

        self.set_start();

        // send address
        self.wait_for_irq();
        {
            const state = self.get_state();
            switch (state) {
                0x08 => {},
                else => @panic("invalid i2c state"),
            }
        }
        self.clear_start();
        self.write_data((@intFromEnum(address) << 1) | 0x01);
        self.clear_irq();

        // wait for ack/nack
        self.wait_for_irq();
        {
            const state = self.get_state();
            switch (state) {
                0x40 => {}, // ACK
                0x48 => return error.NoAcknowledge,
                else => @panic("invalid i2c state"),
            }
        }

        if (total_size > 1) {
            self.set_ack();
        }
        self.clear_irq();

        var iter = write_vec.iterator();
        var offset: usize = 0;
        while (iter.next_element_ptr()) |element| {
            self.wait_for_irq();
            const state = self.get_state();

            element.value_ptr.* = self.read_data();

            switch (state) {
                0x50 => {
                    // clear ack after second to last element
                    if (total_size > 1 and offset == total_size - 2) {
                        self.clear_ack();
                    }
                },
                0x58 => {
                    if (element.last) {
                        self.set_stop();
                    }
                },
                // TODO: find out which value corresponds to NACK
                else => @panic("invalid i2c state"),
            }
            self.clear_irq();
            offset += 1;
        }
    }

    pub fn read_blocking(self: I2C, address: Address, dst: []u8, timeout: ?mdf.time.Duration) TransactionError!void {
        return try self.readv_blocking(address, &.{dst}, timeout);
    }

    pub inline fn device(self: I2C, address: Address) I2C_Device {
        return I2C_Device.init(self, address);
    }

    inline fn set_start(_: I2C) void {
        I2C0.CR.modify(.{ .STA = 1 });
    }

    inline fn clear_start(_: I2C) void {
        I2C0.CR.modify(.{ .STA = 0 });
    }

    inline fn set_stop(_: I2C) void {
        I2C0.CR.modify(.{ .STO = 1 });
    }

    inline fn clear_stop(_: I2C) void {
        I2C0.CR.modify(.{ .STO = 0 });
    }

    inline fn set_ack(_: I2C) void {
        I2C0.CR.modify(.{ .AA = 1 });
    }

    inline fn clear_ack(_: I2C) void {
        I2C0.CR.modify(.{ .AA = 0 });
    }

    inline fn write_data(_: I2C, data: u8) void {
        I2C0.DATA.write(.{ .I2CDAT = data });
    }

    inline fn read_data(_: I2C) u8 {
        return I2C0.DATA.read().I2CDAT;
    }

    inline fn get_state(_: I2C) u8 {
        return I2C0.STAT.read().I2CSTA;
    }

    fn wait_for_irq(self: I2C) void {
        while (!self.is_irq_set()) {}
    }

    inline fn is_irq_set(_: I2C) bool {
        return I2C0.CR.read().SI == 1;
    }

    inline fn clear_irq(_: I2C) void {
        I2C0.CR.modify(.{ .SI = 0 });
    }
};
