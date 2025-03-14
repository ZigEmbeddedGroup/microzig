//!
//! An abstract stream orientied device with runtime dispatch.
//!
//! Stream devices behave similar to an UART and can send/receive data
//! in variying lengths without clear boundaries between transmissions.
//!

const std = @import("std");

const Stream_Device = @This();

/// Pointer to the object implementing the driver.
///
/// If the implementation requires no `ptr` pointer,
/// you can safely use `undefined` here.
ptr: *anyopaque,

/// Virtual table for the stream device functions.
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };

pub const ConnectError = BaseError || error{DeviceBusy};
pub const WriteError = BaseError || error{ Unsupported, NotConnected };
pub const ReadError = BaseError || error{ Unsupported, NotConnected };

/// Establishes a connection to the device (like activating a chip-select lane or similar).
/// NOTE: Call `.disconnect()` when the usage of the device is done to release it.
pub fn connect(sd: Stream_Device) ConnectError!void {
    const connect_fn = sd.vtable.connect_fn orelse return;
    return connect_fn(sd.ptr);
}

/// Releases a device from the connection.
pub fn disconnect(sd: Stream_Device) void {
    const disconnect_fn = sd.vtable.disconnect_fn orelse return;
    return disconnect_fn(sd.ptr);
}

/// Writes some `bytes` to the device and returns the number of bytes written.
pub fn write(sd: Stream_Device, bytes: []const u8) WriteError!usize {
    return sd.writev(&.{bytes});
}

/// Writes some `bytes` to the device and returns the number of bytes written.
pub fn writev(sd: Stream_Device, bytes_vec: []const []const u8) WriteError!usize {
    const writev_fn = sd.vtable.writev_fn orelse return error.Unsupported;
    return writev_fn(sd.ptr, bytes_vec);
}

/// Reads some `bytes` to the device and returns the number of bytes read.
pub fn read(sd: Stream_Device, bytes: []u8) ReadError!usize {
    return sd.readv(&.{bytes});
}

/// Reads some `bytes` to the device and returns the number of bytes read.
pub fn readv(sd: Stream_Device, bytes_vec: []const []u8) ReadError!usize {
    const readv_fn = sd.vtable.readv_fn orelse return error.Unsupported;
    return readv_fn(sd.ptr, bytes_vec);
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
    connect_fn: ?*const fn (*anyopaque) ConnectError!void,
    disconnect_fn: ?*const fn (*anyopaque) void,
    writev_fn: ?*const fn (*anyopaque, datagram: []const []const u8) WriteError!usize,
    readv_fn: ?*const fn (*anyopaque, datagram: []const []u8) ReadError!usize,
};

/// A device implementation that can be used to write unit tests for datagram devices.
pub const Test_Device = struct {
    input: ?std.io.FixedBufferStream([]const u8),
    output: ?std.ArrayList(u8),

    connected: bool,

    // Public API

    pub fn init(input: ?[]const u8, write_enabled: bool) Test_Device {
        return Test_Device{
            .connected = false,

            .input = if (input) |bytes|
                std.io.FixedBufferStream([]const u8){ .buffer = bytes, .pos = 0 }
            else
                null,

            .output = if (write_enabled)
                std.ArrayList(u8).init(std.testing.allocator)
            else
                null,
        };
    }

    pub fn deinit(td: *Test_Device) void {
        if (td.output) |*list| {
            list.deinit();
        }
        td.* = undefined;
    }

    pub fn stream_device(td: *Test_Device) Stream_Device {
        return Stream_Device{
            .ptr = td,
            .vtable = &vtable,
        };
    }

    // Testing interface:

    /// Checks if all of the provided input was consumed.
    pub fn expect_all_input_consumed(td: Test_Device) !void {
        // No input is totally fine and counts as "all input consumed"
        const input = td.input orelse return;

        try std.testing.expectEqualSlices(u8, "", input.buffer[input.pos..]);
    }

    /// Expects that all sent data is `expected`.
    pub fn expect_sent(td: Test_Device, expected: []const u8) !void {
        if (td.output) |output| {
            try std.testing.expectEqualSlices(u8, expected, output.items);
        }
    }

    // Interface implementation

    const vtable = VTable{
        .connect_fn = Test_Device.connect,
        .disconnect_fn = Test_Device.disconnect,
        .writev_fn = Test_Device.writev,
        .readv_fn = Test_Device.readv,
    };

    fn connect(ctx: *anyopaque) ConnectError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));
        if (td.connected)
            return error.DeviceBusy;
        td.connected = true;
    }

    fn disconnect(ctx: *anyopaque) void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));
        if (!td.connected) {
            std.log.err("disconnect when test device was not connected!", .{});
        }
        td.connected = false;
    }

    fn writev(ctx: *anyopaque, bytes_vec: []const []const u8) WriteError!usize {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));
        if (!td.connected) {
            return error.NotConnected;
        }

        const list = if (td.output) |*output| output else return error.Unsupported;

        var total_len: usize = 0;
        for (bytes_vec) |bytes| {
            list.appendSlice(bytes) catch return error.IoError;
            total_len += bytes.len;
        }
        return total_len;
    }

    fn readv(ctx: *anyopaque, bytes_vec: []const []u8) ReadError!usize {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));
        if (!td.connected) {
            return error.NotConnected;
        }

        const data_reader = if (td.input) |*stream| stream.reader() else return error.Unsupported;

        var total_length: usize = 0;

        for (bytes_vec) |bytes| {
            const len = data_reader.read(bytes) catch comptime unreachable;
            total_length += len;
            if (len < bytes.len)
                return total_length;
        }

        return total_length;
    }
};

test Test_Device {
    const input_text =
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque pen" ++
        "atibus et magnis dis parturient montes, nascetur ridiculus mus. " ++
        "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, " ++
        "sem.";

    const output_text =
        "Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate el" ++
        "eifend tellus. Aenean leo ligula, porttitor eu, consequat vitae," ++
        " eleifend ac, enim.";

    var td = Test_Device.init(input_text, true);
    defer td.deinit();

    var buffer: [128]u8 = undefined;

    const sd = td.stream_device();

    // As long as we're not connected, the test device will handle
    // this case and yield an error:
    try std.testing.expectError(error.NotConnected, sd.write("not connected"));
    try std.testing.expectError(error.NotConnected, sd.read(&buffer));

    {
        // The first connect call must succeed ...
        try sd.connect();

        // ... while the second call must fail:
        try std.testing.expectError(error.DeviceBusy, sd.connect());

        // After a disconnect...
        sd.disconnect();

        // ... the connect must succeed again:
        try sd.connect();

        // We'll keep the device connected for the rest of the test to
        // ease handling.
    }

    {
        const len = try sd.read(&buffer);
        try std.testing.expectEqual(buffer.len, len);
        try std.testing.expectEqualStrings(input_text[0..128], buffer[0..len]);
    }

    {
        const len = try sd.read(buffer[0..64]);
        try std.testing.expectEqual(64, len);
        try std.testing.expectEqualStrings(input_text[128 .. 128 + 64], buffer[0..len]);
    }

    {
        const len = try sd.read(buffer[0..64]);
        try std.testing.expectEqual(64, len);
        try std.testing.expectEqualStrings(input_text[128 + 64 .. 128 + 64 + 64], buffer[0..len]);
    }

    {
        const len = try sd.read(&buffer);
        try std.testing.expectEqual(4, len);
        try std.testing.expectEqualStrings(input_text[128 + 64 + 64 ..], buffer[0..len]);
    }

    try td.expect_all_input_consumed();

    var output_splitter = struct {
        text: []const u8,
        pos: usize = 0,

        fn fetch(h: *@This(), len: usize) []const u8 {
            const str = h.text[h.pos..][0..len];
            h.pos += len;
            return str;
        }

        fn rest(h: *@This()) []const u8 {
            const str = h.text[h.pos..];
            h.pos = h.text.len;
            return str;
        }
    }{ .text = output_text };

    {
        const slice = output_splitter.fetch(64);
        const len = try sd.write(slice);
        try std.testing.expectEqual(slice.len, len);
    }

    {
        const len = try sd.writev(&.{
            output_splitter.fetch(16),
            output_splitter.fetch(10),
            output_splitter.fetch(6),
            output_splitter.fetch(24),
            output_splitter.fetch(8),
        });
        try std.testing.expectEqual(64, len);
    }

    {
        const slice = output_splitter.rest();
        const len = try sd.write(slice);
        try std.testing.expectEqual(slice.len, len);
    }

    try td.expect_sent(output_text);
}
