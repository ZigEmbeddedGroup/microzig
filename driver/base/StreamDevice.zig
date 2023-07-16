//!
//! An abstract stream orientied device with runtime dispatch.
//!
//! Stream devices behave similar to an UART and can send/receive data
//! in variying lengths without clear boundaries between transmissions.
//!

const std = @import("std");

const StreamDevice = @This();

object: ?*anyopaque,
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };

pub const ConnectError = BaseError || error{DeviceBusy};
pub const WriteError = BaseError || error{ Unsupported, NotConnected };
pub const ReadError = BaseError || error{ Unsupported, NotConnected };

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(sd: StreamDevice) ConnectError!void {
    if (sd.vtable.connectFn) |connectFn| {
        return connectFn(sd.object);
    }
}

/// Releases a device from the connection.
pub fn disconnect(sd: StreamDevice) void {
    if (sd.vtable.disconnectFn) |disconnectFn| {
        return disconnectFn(sd.object);
    }
}

/// Writes some `bytes` to the device and returns the number of bytes written.
pub fn write(sd: StreamDevice, bytes: []const u8) WriteError!usize {
    if (sd.vtable.writeFn) |writeFn| {
        return writeFn(sd.object, bytes);
    } else {
        return error.Unsupported;
    }
}

/// Reads some `bytes` to the device and returns the number of bytes read.
pub fn read(sd: StreamDevice, bytes: []u8) ReadError!usize {
    if (sd.vtable.readFn) |readFn| {
        return readFn(sd.object, bytes);
    } else {
        return error.Unsupported;
    }
}

pub const Reader = std.io.Reader(StreamDevice, ReadError, readerRead);
pub fn reader(sd: StreamDevice) Reader {
    return .{ .context = sd };
}

fn readerRead(sd: StreamDevice, buf: []u8) ReadError!usize {
    return sd.read(buf);
}

pub const Writer = std.io.Reader(StreamDevice, WriteError, writerWrite);
pub fn writer(sd: StreamDevice) Writer {
    return .{ .context = sd };
}

fn writerWrite(sd: StreamDevice, buf: []const u8) WriteError!usize {
    return sd.write(buf);
}

pub const VTable = struct {
    connectFn: ?*const fn (?*anyopaque) ConnectError!void,
    disconnectFn: ?*const fn (?*anyopaque) void,
    writeFn: ?*const fn (?*anyopaque, datagram: []const u8) WriteError!usize,
    readFn: ?*const fn (?*anyopaque, datagram: []u8) ReadError!usize,
};
