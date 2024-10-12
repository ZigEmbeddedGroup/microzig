//!
//! An abstract stream orientied device with runtime dispatch.
//!
//! Stream devices behave similar to an UART and can send/receive data
//! in variying lengths without clear boundaries between transmissions.
//!

const std = @import("std");

const Stream_Device = @This();

/// Pointer to the object implementing the driver.
object: ?*anyopaque,

/// Virtual table for the stream device functions.
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };

pub const ConnectError = BaseError || error{DeviceBusy};
pub const WriteError = BaseError || error{ Unsupported, NotConnected };
pub const ReadError = BaseError || error{ Unsupported, NotConnected };

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(sd: Stream_Device) ConnectError!void {
    if (sd.vtable.connectFn) |connectFn| {
        return connectFn(sd.object);
    }
}

/// Releases a device from the connection.
pub fn disconnect(sd: Stream_Device) void {
    if (sd.vtable.disconnectFn) |disconnectFn| {
        return disconnectFn(sd.object);
    }
}

/// Writes some `bytes` to the device and returns the number of bytes written.
pub fn write(sd: Stream_Device, bytes: []const u8) WriteError!usize {
    return sd.writev(&.{bytes});
}

/// Writes some `bytes` to the device and returns the number of bytes written.
pub fn writev(sd: Stream_Device, bytes_vec: []const []const u8) WriteError!usize {
    const writev_fn = sd.vtable.writev_fn orelse return error.Unsupported;
    return writev_fn(sd.object, bytes_vec);
}

/// Reads some `bytes` to the device and returns the number of bytes read.
pub fn read(sd: Stream_Device, bytes: []u8) ReadError!usize {
    return sd.readv(&.{bytes});
}

/// Reads some `bytes` to the device and returns the number of bytes read.
pub fn readv(sd: Stream_Device, bytes_vec: []const []u8) ReadError!usize {
    const readv_fn = sd.vtable.readv_fn orelse return error.Unsupported;
    return readv_fn(sd.object, bytes_vec);
}

pub const Reader = std.io.Reader(Stream_Device, ReadError, reader_read);
pub fn reader(sd: Stream_Device) Reader {
    return .{ .context = sd };
}

fn reader_read(sd: Stream_Device, buf: []u8) ReadError!usize {
    return sd.read(buf);
}

pub const Writer = std.io.Reader(Stream_Device, WriteError, writer_write);
pub fn writer(sd: Stream_Device) Writer {
    return .{ .context = sd };
}

fn writer_write(sd: Stream_Device, buf: []const u8) WriteError!usize {
    return sd.write(buf);
}

pub const VTable = struct {
    connect_fn: ?*const fn (?*anyopaque) ConnectError!void,
    disconnect_fn: ?*const fn (?*anyopaque) void,
    writev_fn: ?*const fn (?*anyopaque, datagram: []const []const u8) WriteError!usize,
    readv_fn: ?*const fn (?*anyopaque, datagram: []const []u8) ReadError!usize,
};
