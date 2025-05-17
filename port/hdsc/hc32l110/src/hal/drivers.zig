const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Datagram_Device = drivers.Datagram_Device;

///
/// A datagram device attached to an I²C bus.
///
pub const I2C_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects I²C bus should be used.
    bus: hal.i2c.I2C,

    /// The address of our I²C device.
    address: hal.i2c.Address,

    pub fn init(bus: hal.i2c.I2C, address: hal.i2c.Address) I2C_Device {
        return .{
            .bus = bus,
            .address = address,
        };
    }

    pub fn datagram_device(dev: *I2C_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: I2C_Device) ConnectError!void {
        _ = dev;
    }

    pub fn disconnect(dev: I2C_Device) void {
        _ = dev;
    }

    pub fn write(dev: I2C_Device, datagram: []const u8) !void {
        try dev.bus.write_blocking(dev.address, datagram, null);
    }

    pub fn writev(dev: I2C_Device, datagrams: []const []const u8) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, null);
    }

    pub fn read(dev: I2C_Device, datagram: []u8) !usize {
        try dev.bus.read_blocking(dev.address, datagram, null);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Device, datagrams: []const []u8) !usize {
        try dev.bus.readv_blocking(dev.address, datagrams, null);
        return microzig.utilities.Slice_Vector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = null,
        .disconnect_fn = null,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
    };

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks) catch |err| switch (err) {
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.TargetAddressReserved,
            => return error.Unsupported,

            error.UnknownAbort,
            error.TxFifoFlushed,
            => return error.IoError,

            error.Timeout => return error.Timeout,
            error.NoData => {},
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |err| switch (err) {
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.TargetAddressReserved,
            => return error.Unsupported,

            error.UnknownAbort,
            error.TxFifoFlushed,
            => return error.IoError,

            error.Timeout => return error.Timeout,
            error.NoData => return 0,
        };
    }
};
