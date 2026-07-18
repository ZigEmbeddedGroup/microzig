//!
//! An abstract datagram oriented device with runtime dispatch.
//!
//! Datagram devices behave similar to an SPI or Ethernet device where
//! packets with an ahead-of-time known length can be transferred in a
//! single transaction.
//!

const std = @import("std");

const DatagramDevice = @This();

/// Pointer to the object implementing the driver.
///
/// If the implementation requires no `ptr` pointer,
/// you can safely use `undefined` here.
ptr: *anyopaque,

/// Virtual table for the datagram device functions.
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };
pub const ConnectError = BaseError || error{DeviceBusy};
pub const WriteError = BaseError || error{ Unsupported, NotConnected };
pub const ReadError = BaseError || error{ Unsupported, NotConnected, BufferOverrun };
pub const AnyError = ConnectError || WriteError || ReadError;

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(dd: DatagramDevice) ConnectError!void {
    if (dd.vtable.connect_fn) |connectFn| {
        return connectFn(dd.ptr);
    }
}

/// Releases a device from the connection.
pub fn disconnect(dd: DatagramDevice) void {
    if (dd.vtable.disconnect_fn) |disconnectFn| {
        return disconnectFn(dd.ptr);
    }
}

/// Writes a single `datagram` to the device.
pub fn write(dd: DatagramDevice, datagram: []const u8) WriteError!void {
    return try dd.writev(&.{datagram});
}

/// Writes multiple `datagrams` to the device.
pub fn writev(dd: DatagramDevice, datagrams: []const []const u8) WriteError!void {
    const writev_fn = dd.vtable.writev_fn orelse return error.Unsupported;
    return writev_fn(dd.ptr, datagrams);
}

/// Writes then reads a single `datagram` to the device.
pub fn write_then_read(
    dd: DatagramDevice,
    src: []const u8,
    dst: []u8,
) (WriteError || ReadError)!void {
    return try dd.writev_then_readv(&.{src}, &.{dst});
}

/// Writes a slice of datagrams to the device, then reads back into another slice of datagrams
pub fn writev_then_readv(
    dd: DatagramDevice,
    write_chunks: []const []const u8,
    read_chunks: []const []u8,
) (WriteError || ReadError)!void {
    const writev_then_readv_fn = dd.vtable.writev_then_readv_fn orelse return error.Unsupported;
    return writev_then_readv_fn(dd.ptr, write_chunks, read_chunks);
}

/// Reads a single `datagram` from the device.
/// Function returns the number of bytes written in `datagram`.
///
/// If `error.BufferOverrun` is returned, the `datagram` will still be fully filled with the data
/// that was received up till the overrun. The rest of the datagram will be discarded.
pub fn read(dd: DatagramDevice, datagram: []u8) ReadError!usize {
    return try dd.readv(&.{datagram});
}

/// Reads multiple `datagrams` from the device.
/// Function returns the number of bytes written in `datagrams`.
///
/// If `error.BufferOverrun` is returned, the `datagrams` will still be fully filled with the data
/// that was received up till the overrun. The rest of the datagram will be discarded.
pub fn readv(dd: DatagramDevice, datagrams: []const []u8) ReadError!usize {
    const readv_fn = dd.vtable.readv_fn orelse return error.Unsupported;
    return readv_fn(dd.ptr, datagrams);
}

pub const VTable = struct {
    connect_fn: ?*const fn (*anyopaque) ConnectError!void,
    disconnect_fn: ?*const fn (*anyopaque) void,
    writev_fn: ?*const fn (*anyopaque, datagrams: []const []const u8) WriteError!void,
    readv_fn: ?*const fn (*anyopaque, datagrams: []const []u8) ReadError!usize,
    writev_then_readv_fn: ?*const fn (
        *anyopaque,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) (WriteError || ReadError)!void = null,
};

/// A device implementation that can be used to write unit tests for datagram devices.
pub const TestDevice = struct {
    arena: std.heap.ArenaAllocator,
    packets: std.array_list.Managed([]u8),

    // If empty, reads are supported, but don't yield data.
    // If `null`, reads are not supported.
    input_sequence: ?[]const []const u8,
    input_sequence_pos: usize,

    write_enabled: bool,

    connected: bool,

    pub fn init_receiver_only() TestDevice {
        return init(null, true);
    }

    pub fn init_sender_only(input: []const []const u8) TestDevice {
        return init(input, false);
    }

    pub fn init(input: ?[]const []const u8, write_enabled: bool) TestDevice {
        return TestDevice{
            .arena = std.heap.ArenaAllocator.init(std.testing.allocator),
            .packets = std.array_list.Managed([]u8).init(std.testing.allocator),

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

    pub fn expect_sent(td: TestDevice, expected_datagrams: []const []const u8) !void {
        const actual_datagrams = td.packets.items;

        try std.testing.expectEqual(expected_datagrams.len, actual_datagrams.len);
        for (expected_datagrams, actual_datagrams) |expected, actual| {
            try std.testing.expectEqualSlices(u8, expected, actual);
        }
    }

    pub fn datagram_device(td: *TestDevice) DatagramDevice {
        return DatagramDevice{
            .ptr = td,
            .vtable = &vtable,
        };
    }

    fn connect(ctx: *anyopaque) ConnectError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (td.connected)
            return error.DeviceBusy;
        td.connected = true;
    }

    fn disconnect(ctx: *anyopaque) void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));
        if (!td.connected) {
            std.log.err("disconnect when test device was not connected!", .{});
        }
        td.connected = false;
    }

    fn writev(ctx: *anyopaque, datagrams: []const []const u8) WriteError!void {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));

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

    fn readv(ctx: *anyopaque, datagrams: []const []u8) ReadError!usize {
        const td: *TestDevice = @ptrCast(@alignCast(ctx));

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

        const written = @min(packet.len, total_len);

        {
            var offset: usize = 0;
            for (datagrams) |datagram| {
                const amount = @min(datagram.len, written - offset);
                @memcpy(datagram[0..amount], packet[offset..][0..amount]);
                offset += amount;
                if (amount < datagram.len)
                    break;
            }
            std.debug.assert(offset == written);
        }

        if (packet.len > total_len)
            return error.BufferOverrun;

        return written;
    }

    fn writev_then_readv(ctx: *anyopaque, write_chunks: []const []const u8, read_chunks: []const []u8) (WriteError || ReadError)!void {
        try TestDevice.writev(ctx, write_chunks);
        _ = try TestDevice.readv(ctx, read_chunks);
    }

    const vtable = VTable{
        .connect_fn = TestDevice.connect,
        .disconnect_fn = TestDevice.disconnect,
        .writev_fn = TestDevice.writev,
        .readv_fn = TestDevice.readv,
        .writev_then_readv_fn = TestDevice.writev_then_readv,
    };
};

test TestDevice {
    var td = TestDevice.init(&.{
        "first datagram",
        "second datagram",
        "the very third datagram which overruns the buffer",
    }, true);
    defer td.deinit();

    var buffer: [16]u8 = undefined;

    const dd = td.datagram_device();

    // As long as we're not connected, the test device will handle
    // this case and yield an error:
    try std.testing.expectError(error.NotConnected, dd.write("not connected"));
    try std.testing.expectError(error.NotConnected, dd.read(&buffer));

    {
        // The first connect call must succeed ...
        try dd.connect();

        // ... while the second call must fail:
        try std.testing.expectError(error.DeviceBusy, dd.connect());

        // After a disconnect...
        dd.disconnect();

        // ... the connect must succeed again:
        try dd.connect();

        // We'll keep the device connected for the rest of the test to
        // ease handling.
    }

    {
        // The first input datagram will be received here:
        const recv_len = try dd.read(&buffer);
        try std.testing.expectEqualStrings("first datagram", buffer[0..recv_len]);
    }

    {
        // The second one here:
        const recv_len = try dd.read(&buffer);
        try std.testing.expectEqualStrings("second datagram", buffer[0..recv_len]);
    }

    {
        // The third datagram will overrun our buffer, so we're receiving an error
        // which tells us that the whole buffer is filled, but there's data that
        // was discarded:
        try std.testing.expectError(error.BufferOverrun, dd.read(&buffer));
        try std.testing.expectEqualStrings("the very third d", &buffer);
    }

    // As there's no fourth datagram available, the test device will yield
    // an `IoError` for when no datagrams are available anymore:
    try std.testing.expectError(error.IoError, dd.read(&buffer));

    try dd.write("Hello, World!");
    try dd.writev(&.{ "See", " you ", "soon!" });

    // Check if we had exactly these datagrams:
    try td.expect_sent(&.{
        "Hello, World!",
        "See you soon!",
    });
}
