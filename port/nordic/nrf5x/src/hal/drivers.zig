//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");
const mdf = microzig.drivers;

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;
const I2CError = drivers.I2C_Device.Error;
const I2CAddress = drivers.I2C_Device.Address;

///
/// A datagram device attached to an I²C bus.
///
pub const I2C_Datagram_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects I²C bus should be used.
    bus: hal.i2c.I2C,

    /// The address of our I²C device.
    address: I2CAddress,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, address: hal.i2c.Address, timeout: ?mdf.time.Duration) I2C_Datagram_Device {
        return .{
            .bus = bus,
            .address = address,
            .timeout = timeout,
        };
    }

    pub fn datagram_device(dev: *I2C_Datagram_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: I2C_Datagram_Device) ConnectError!void {
        _ = dev;
    }

    pub fn disconnect(dev: I2C_Datagram_Device) void {
        _ = dev;
    }

    pub fn write(dev: I2C_Datagram_Device, datagram: []const u8) !void {
        try dev.bus.write_blocking(dev.address, datagram, dev.timeout);
    }

    pub fn writev(dev: I2C_Datagram_Device, datagrams: []const []const u8) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, dev.timeout);
    }

    pub fn read(dev: I2C_Datagram_Device, datagram: []u8) !usize {
        try dev.bus.read_blocking(dev.address, datagram, dev.timeout);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Datagram_Device, datagrams: []const []u8) !usize {
        try dev.bus.readv_blocking(dev.address, datagrams, dev.timeout);
        return microzig.utilities.SliceVector([]u8).init(datagrams).size();
    }

    pub fn writev_then_readv(
        dev: I2C_Datagram_Device,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) !void {
        try dev.bus.writev_then_readv_blocking(dev.address, write_chunks, read_chunks, null);
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = null,
        .disconnect_fn = null,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = writev_then_readv_fn,
    };

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.Overrun,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => {},
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.Overrun,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => 0,
        };
    }

    fn writev_then_readv_fn(
        dd: *anyopaque,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) (WriteError || ReadError)!void {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.writev_then_readv(write_chunks, read_chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.Overrun,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => {},
        };
    }
};

///
/// A Implementation of the I2C_Device interface
///
pub const I2C_Device = struct {
    /// Selects which I²C bus should be used.
    bus: hal.i2c.I2C,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, timeout: ?mdf.time.Duration) I2C_Device {
        return .{
            .bus = bus,
            .timeout = timeout,
        };
    }

    pub fn i2c_device(dev: *I2C_Device) drivers.I2C_Device {
        return .{
            .ptr = dev,
            .vtable = &i2c_vtable,
        };
    }

    pub fn write(dev: I2C_Device, address: I2CAddress, buf: []const u8) I2CError!void {
        return dev.bus.write_blocking(address, buf, dev.timeout) catch |err| switch (err) {
            error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev(dev: I2C_Device, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        return dev.bus.writev_blocking(address, chunks, dev.timeout) catch |err| switch (err) {
            error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn read(dev: I2C_Device, address: I2CAddress, buf: []u8) I2CError!usize {
        dev.bus.read_blocking(address, buf, dev.timeout) catch |err| return switch (err) {
            error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
        return buf.len;
    }

    pub fn readv(dev: I2C_Device, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        dev.bus.readv_blocking(address, chunks, dev.timeout) catch |err| return switch (err) {
            error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
        return microzig.utilities.SliceVector([]u8).init(chunks).size();
    }

    pub fn write_then_read(dev: I2C_Device, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
        try dev.bus.write_then_read_blocking(address, src, dst, dev.timeout);
    }

    pub fn writev_then_readv(
        dev: I2C_Device,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        return dev.bus.writev_then_readv_blocking(address, write_chunks, read_chunks, dev.timeout) catch |err| switch (err) {
            error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    const i2c_vtable = drivers.I2C_Device.VTable{
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = writev_then_readv_fn,
    };

    fn writev_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev(address, chunks);
    }

    fn readv_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.readv(address, chunks);
    }

    fn writev_then_readv_fn(
        dd: *anyopaque,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev_then_readv(address, write_chunks, read_chunks);
    }
};

///
/// Implementation of a time device
///
pub const ClockDevice = struct {
    const vtable = Clock_Device.VTable{
        .get_time_since_boot = get_time_since_boot_fn,
    };

    interface: Clock_Device = .{
        .vtable = &vtable,
    },

    pub fn clock_device(td: *ClockDevice) Clock_Device {
        return &td.interface;
    }

    fn get_time_since_boot_fn(_: *Clock_Device) time.Absolute {
        const t = hal.time.get_time_since_boot().to_us();
        return @enumFromInt(t);
    }
};

///
/// A datagram device attached to an SPI bus.
///
pub const SPI_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;
    pub const ChipSelect = struct {
        pin: hal.gpio.Pin,
        active_level: Digital_IO.State = .low,
    };

    bus: hal.spim.SPIM,
    maybe_chip_select: ?ChipSelect = null,

    pub fn init(bus: hal.spim.SPIM, maybe_chip_select: ?ChipSelect) SPI_Device {
        if (maybe_chip_select) |cs|
            cs.pin.set_direction(.out);

        var dev: SPI_Device = .{
            .bus = bus,
            .maybe_chip_select = maybe_chip_select,
        };
        // set the chip select to "deselect" the device
        dev.disconnect();
        return dev;
    }

    pub fn datagram_device(dev: *SPI_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: SPI_Device) void {
        if (dev.maybe_chip_select) |cs|
            cs.pin.put(switch (cs.active_level) {
                .low => 0,
                .high => 1,
            });
    }

    pub fn disconnect(dev: SPI_Device) void {
        if (dev.maybe_chip_select) |cs|
            cs.pin.put(switch (cs.active_level) {
                .low => 1,
                .high => 0,
            });
    }

    pub fn write(dev: SPI_Device, tx: []const u8) !void {
        return dev.bus.write_blocking(u8, tx);
    }

    pub fn writev(dev: SPI_Device, datagrams: []const []const u8) !void {
        return dev.bus.writev_blocking(u8, datagrams);
    }

    pub fn read(dev: SPI_Device, rx: []u8) !usize {
        dev.bus.read_blocking(u8, rx);
        return rx.len;
    }

    pub fn readv(dev: SPI_Device, datagrams: []const []const u8) !usize {
        dev.bus.readv_blocking(u8, datagrams);
        return microzig.utilities.SliceVector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = connect_fn,
        .disconnect_fn = disconnect_fn,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = null,
    };

    fn connect_fn(dd: *anyopaque) ConnectError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.connect();
    }

    fn disconnect_fn(dd: *anyopaque) void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.disconnect();
    }

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.bus.writev_blocking(chunks, null) catch |err| switch (err) {
            error.Timeout => WriteError.Timeout,
            else => WriteError.Unsupported,
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        dev.bus.readv_blocking(chunks, null) catch |err| switch (err) {
            error.Timeout => return ReadError.Timeout,
            else => return ReadError.Unsupported,
        };
        return microzig.utilities.SliceVector([]u8).init(chunks).size();
    }
};

var clock: struct {
    interface: Clock_Device = .{
        .vtable = &.{
            .get_time_since_boot = get_time_since_boot_fn,
        },
    },

    fn get_time_since_boot_fn(_: *Clock_Device) time.Absolute {
        return hal.time.get_time_since_boot();
    }
} = .{};

///
/// Implementation of a `Clock_Device` that uses the HAL's `time` module.
///
pub fn clock_device() *Clock_Device {
    return &clock.interface;
}
