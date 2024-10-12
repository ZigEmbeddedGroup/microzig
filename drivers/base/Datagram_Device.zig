//!
//! An abstract datagram orientied device with runtime dispatch.
//!
//! Datagram devices behave similar to an SPI or Ethernet device where
//! packets with an ahead-of-time known length can be transferred in a
//! single transaction.
//!

const std = @import("std");

const Datagram_Device = @This();

/// Pointer to the object implementing the driver.
object: ?*anyopaque,

/// Virtual table for the datagram device functions.
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };

pub const ConnectError = BaseError || error{DeviceBusy};

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(dd: Datagram_Device) ConnectError!void {
    if (dd.vtable.connect_fn) |connectFn| {
        return connectFn(dd.object);
    }
}

/// Releases a device from the connection.
pub fn disconnect(dd: Datagram_Device) void {
    if (dd.vtable.disconnect_fn) |disconnectFn| {
        return disconnectFn(dd.object);
    }
}

pub const WriteError = BaseError || error{ Unsupported, NotConnected };

/// Writes a single `datagram` to the device.
pub fn write(dd: Datagram_Device, datagram: []const u8) WriteError!void {
    return try dd.writev(&.{datagram});
}

/// Writes a single `datagram` to the device.
pub fn writev(dd: Datagram_Device, datagrams: []const []const u8) WriteError!void {
    if (dd.vtable.writev_fn) |writev_fn| {
        return writev_fn(dd.object, datagrams);
    } else {
        return error.Unsupported;
    }
}

pub const ReadError = BaseError || error{ Unsupported, NotConnected };

/// Reads a single `datagram` from the device.
pub fn read(dd: Datagram_Device, datagram: []u8) ReadError!void {
    return try dd.readv(&.{datagram});
}

/// Reads a single `datagram` from the device.
pub fn readv(dd: Datagram_Device, datagrams: []const []u8) ReadError!void {
    if (dd.vtable.readv_fn) |readv_fn| {
        return readv_fn(dd.object, datagrams);
    } else {
        return error.Unsupported;
    }
}

pub const VTable = struct {
    connect_fn: ?*const fn (?*anyopaque) ConnectError!void,
    disconnect_fn: ?*const fn (?*anyopaque) void,
    writev_fn: ?*const fn (?*anyopaque, datagrams: []const []const u8) WriteError!void,
    readv_fn: ?*const fn (?*anyopaque, datagrams: []const []u8) ReadError!void,
};

/// A device implementation that can be used to write unit tests for datagram devices.
pub const Test_Device = struct {
    arena: std.heap.ArenaAllocator,
    packets: std.ArrayList([]u8),

    input_sequence: ?[]const []const u8,
    input_sequence_pos: usize,

    write_enabled: bool,

    connected: bool,

    pub fn init_receiver_only() Test_Device {
        return init(null, true);
    }

    pub fn init_sender_only(input: []const []const u8) Test_Device {
        return init(input, false);
    }

    pub fn init(input: ?[]const []const u8, write_enabled: bool) Test_Device {
        return Test_Device{
            .arena = std.heap.ArenaAllocator.init(std.testing.allocator),
            .packets = std.ArrayList([]u8).init(std.testing.allocator),

            .input_sequence = input,
            .input_sequence_pos = 0,

            .write_enabled = write_enabled,

            .connected = false,
        };
    }

    pub fn deinit(td: *Test_Device) void {
        td.arena.deinit();
        td.packets.deinit();
        td.* = undefined;
    }

    pub fn expect_sent(td: Test_Device, expected_datagrams: []const []const u8) !void {
        const actual_datagrams = td.packets.items;

        try std.testing.expectEqual(expected_datagrams.len, actual_datagrams.len);
        for (expected_datagrams, actual_datagrams) |expected, actual| {
            try std.testing.expectEqualSlices(u8, expected, actual);
        }
    }

    pub fn datagram_device(td: *Test_Device) Datagram_Device {
        return Datagram_Device{
            .object = td,
            .vtable = &vtable,
        };
    }

    fn connect(ctx: ?*anyopaque) ConnectError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx.?));
        if (td.connected)
            return error.DeviceBusy;
        td.connected = true;
    }

    fn disconnect(ctx: ?*anyopaque) void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx.?));
        if (!td.connected) {
            std.log.err("disconnect when test device was not connected!", .{});
        }
        td.connected = false;
    }

    fn writev(ctx: ?*anyopaque, datagrams: []const []const u8) WriteError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx.?));

        if (!td.connected) {
            return error.NotConnected;
        }

        if (!td.write_enabled) {
            return error.Unsupported;
        }

        const total_len = blk: {
            var len: usize = 0;
            for (datagrams) |dg| {
                len += dg.len;
            }
            break :blk len;
        };

        const dg = td.arena.allocator().alloc(u8, total_len) catch return error.IoError;
        errdefer td.arena.allocator().free(dg);

        {
            var offset: usize = 0;
            for (datagrams) |datagram| {
                @memcpy(dg[offset..][0..datagram.len], datagram);
                offset += datagram.len;
            }
            std.debug.assert(offset == total_len);
        }

        td.packets.append(dg) catch return error.IoError;
    }

    fn readv(ctx: ?*anyopaque, datagrams: []const []u8) ReadError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx.?));

        if (!td.connected) {
            return error.NotConnected;
        }

        const inputs = td.input_sequence orelse return error.Unsupported;

        if (td.input_sequence_pos >= inputs.len) {
            return error.IoError;
        }

        const packet = inputs[td.input_sequence_pos];
        td.input_sequence_pos += 1;

        const total_len = blk: {
            var len: usize = 0;
            for (datagrams) |dg| {
                len += dg.len;
            }
            break :blk len;
        };

        if (packet.len != total_len)
            return error.IoError;

        {
            var offset: usize = 0;
            for (datagrams) |datagram| {
                @memcpy(datagram, packet[offset..][0..datagram.len]);
                offset += datagram.len;
            }
            std.debug.assert(offset == total_len);
        }
    }

    const vtable = VTable{
        .connect_fn = Test_Device.connect,
        .disconnect_fn = Test_Device.disconnect,
        .writev_fn = Test_Device.writev,
        .readv_fn = Test_Device.readv,
    };
};
