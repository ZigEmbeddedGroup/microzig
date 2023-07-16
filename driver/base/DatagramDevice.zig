//!
//! An abstract datagram orientied device with runtime dispatch.
//!
//! Datagram devices behave similar to an SPI or Ethernet device where
//! packets with an ahead-of-time known length can be transferred in a
//! single transaction.
//!

const std = @import("std");

const DatagramDevice = @This();

const BaseError = error{ IoError, Timeout };

pub const ConnectError = BaseError || error{DeviceBusy};

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(dd: DatagramDevice) ConnectError!void {
    if (dd.vtable.connectFn) |connectFn| {
        return connectFn(dd.object);
    }
}

/// Releases a device from the connection.
pub fn disconnect(dd: DatagramDevice) void {
    if (dd.vtable.disconnectFn) |disconnectFn| {
        return disconnectFn(dd.object);
    }
}

pub const WriteError = BaseError || error{ Unsupported, NotConnected };

/// Writes a single `datagram` to the device.
pub fn write(dd: DatagramDevice, datagram: []const u8) WriteError!void {
    if (dd.vtable.writeFn) |writeFn| {
        return writeFn(dd.object, datagram);
    } else {
        return error.Unsupported;
    }
}

pub const ReadError = BaseError || error{ Unsupported, NotConnected };

/// Reads a single `datagram` from the device.
pub fn read(dd: DatagramDevice, datagram: []u8) ReadError!void {
    if (dd.vtable.readFn) |readFn| {
        return readFn(dd.object, datagram);
    } else {
        return error.Unsupported;
    }
}

object: ?*anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    connectFn: ?*const fn (?*anyopaque) ConnectError!void,
    disconnectFn: ?*const fn (?*anyopaque) void,
    writeFn: ?*const fn (?*anyopaque, datagram: []const u8) WriteError!void,
    readFn: ?*const fn (?*anyopaque, datagram: []u8) ReadError!void,
};

/// A device implementation that can be used to write unit tests.
pub const TestDevice = struct {
    arena: std.heap.ArenaAllocator,
    packets: std.ArrayList([]u8),

    input_sequence: ?[]const []const u8,
    input_sequence_pos: usize,

    write_enabled: bool,

    connected: bool,

    pub fn initRecevierOnly() TestDevice {
        return init(null, true);
    }

    pub fn initSenderOnly(input: []const []const u8) TestDevice {
        return init(input, false);
    }

    pub fn init(input: ?[]const []const u8, write_enabled: bool) TestDevice {
        return TestDevice{
            .arena = std.heap.ArenaAllocator.init(std.testing.allocator),
            .packets = std.ArrayList([]u8).init(std.testing.allocator),

            .input_sequence = input,
            .input_sequence_pos = 0,

            .write_enabled = write_enabled,

            .connected = false,
        };
    }

    pub fn deinit(td: *TestDevice) void {
        td.arena.deinit();
        td.packets.deinit();
        td.* = undefined;
    }

    pub fn expectSent(td: TestDevice, expected_datagrams: []const []const u8) !void {
        const actual_datagrams = td.packets.items;

        try std.testing.expectEqual(expected_datagrams.len, actual_datagrams.len);
        for (expected_datagrams, actual_datagrams) |expected, actual| {
            try std.testing.expectEqualSlices(u8, expected, actual);
        }
    }

    pub fn datagramDevice(td: *TestDevice) DatagramDevice {
        return DatagramDevice{
            .object = td,
            .vtable = &vtable,
        };
    }

    fn connectFn(ctx: ?*anyopaque) ConnectError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx.?));
        if (td.connected)
            return error.DeviceBusy;
        td.connected = true;
    }

    fn disconnectFn(ctx: ?*anyopaque) void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx.?));
        if (!td.connected) {
            std.log.err("disconnect when test device was not connected!", .{});
        }
        td.connected = false;
    }

    fn writeFn(ctx: ?*anyopaque, datagram: []const u8) WriteError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx.?));

        if (!td.connected) {
            return error.NotConnected;
        }

        if (!td.write_enabled) {
            return error.Unsupported;
        }

        const dg = td.arena.allocator().dupe(u8, datagram) catch return error.IoError;
        errdefer td.arena.allocator().free(dg);

        td.packets.append(dg) catch return error.IoError;
    }

    fn readFn(ctx: ?*anyopaque, datagram: []u8) ReadError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx.?));

        if (!td.connected) {
            return error.NotConnected;
        }

        const inputs = td.input_sequence orelse return error.Unsupported;

        if (td.input_sequence_pos >= inputs.len) {
            return error.IoError;
        }

        const packet = inputs[td.input_sequence_pos];
        td.input_sequence_pos += 1;

        if (packet.len != datagram.len)
            return error.IoError;

        @memcpy(datagram, packet);
    }

    const vtable = VTable{
        .connectFn = connectFn,
        .disconnectFn = disconnectFn,
        .writeFn = writeFn,
        .readFn = readFn,
    };
};
