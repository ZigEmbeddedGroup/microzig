//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const i2c = @import("./i2c.zig");
const mdf = microzig.drivers;

const time = microzig.hal.time;

const drivers = microzig.drivers.base;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;
const I2CError = drivers.I2C_Device.Error;
const I2CAddress = drivers.I2C_Device.Address;

///
/// A Implementation of the I2C_Device interface
///
pub const I2C_Device = struct {
    /// Selects which I²C bus should be used.
    bus: i2c.I2C,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: i2c.I2C, timeout: ?mdf.time.Duration) I2C_Device {
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
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev(dev: I2C_Device, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        return dev.bus.writev_blocking(address, chunks, dev.timeout) catch |err| switch (err) {
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn read(dev: I2C_Device, address: I2CAddress, buf: []u8) I2CError!usize {
        dev.bus.read_blocking(address, buf, dev.timeout) catch |err| return switch (err) {
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
        return buf.len;
    }

    pub fn readv(dev: I2C_Device, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        dev.bus.readv_blocking(address, chunks, dev.timeout) catch |err| return switch (err) {
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
        return microzig.utilities.SliceVector([]u8).init(chunks).size();
    }

    pub fn write_then_read(dev: I2C_Device, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
        dev.bus.write_then_read_blocking(address, src, dst, dev.timeout) catch |err| return switch (err) {
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev_then_readv(
        dev: I2C_Device,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        return dev.bus.writev_then_readv_blocking(address, write_chunks, read_chunks, dev.timeout) catch |err| switch (err) {
            error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
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
    pub fn clock_device(td: *ClockDevice) Clock_Device {
        _ = td;
        return Clock_Device{
            .ptr = undefined,
            .vtable = &vtable,
        };
    }
    const vtable = Clock_Device.VTable{
        .get_time_since_boot = get_time_since_boot_fn,
    };

    fn get_time_since_boot_fn(td: *anyopaque) time.Absolute {
        _ = td;
        const t = time.get_time_since_boot().to_us();
        return @enumFromInt(t);
    }
};

///
/// Implementation of a `Clock_Device` that uses the HAL's `time` module.
///
pub fn clock_device() Clock_Device {
    const S = struct {
        const vtable: Clock_Device.VTable = .{
            .get_time_since_boot = get_time_since_boot_fn,
        };

        fn get_time_since_boot_fn(_: *anyopaque) mdf.time.Absolute {
            return time.get_time_since_boot();
        }
    };

    return .{
        .ptr = undefined,
        .vtable = &S.vtable,
    };
}
