//!
//! An abstract I2C device with runtime dispatch
//!

const std = @import("std");

/// Error is a set of errors that make sense for I2C at the protocol level
pub const Error = error{
    DeviceNotPresent,
    NoAcknowledge,
    Timeout,
    TargetAddressReserved,
    NoData,
    BufferOverrun,
    UnknownAbort,
    IllegalAddress,
};
// InterfaceError adds additional errors that only make sense for the interface (e.g. unsupported
// feature).
pub const InterfaceError = Error || error{Unsupported};

///
/// 7-bit I²C address, without the read/write bit.
///
pub const Address = enum(u7) {
    _,
    /// The general call addresses all devices on the bus using the I²C address 0.
    pub const general_call: Address = @enumFromInt(0x00);

    pub const Error = error{
        GeneralCall,
        CBUSAddress,
        ReservedFormat,
        ReservedFuture,
        HighSpeedMaster,
        TenBitSlave,
    };

    ///
    /// Returns an Address.Error if the Address is a reserved I²C address.
    /// The error gives detail on why the address is reserved, allowing the client to determine
    /// whether it should allow it.
    ///
    /// Reserved addresses are ones that match `0b0000XXX` or `0b1111XXX`.
    ///
    /// See more here: https://www.i2c-bus.org/addressing/
    pub fn is_reserved(addr: Address) Address.Error!void {
        const value: u7 = @intFromEnum(addr);

        switch (value) {
            0b0000000 => return Address.Error.GeneralCall,
            0b0000001 => return Address.Error.CBUSAddress,
            0b0000010 => return Address.Error.ReservedFormat,
            0b0000011 => return Address.Error.ReservedFuture,
            0b0001000...0b0001111 => return Address.Error.HighSpeedMaster,
            0b1111000...0b1111011 => return Address.Error.TenBitSlave,
            0b1111100...0b1111111 => return Address.Error.ReservedFuture,
            else => return,
        }
    }

    pub fn format(addr: Address, fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        try writer.print("I2C(0x{X:0>2})", .{@intFromEnum(addr)});
    }
};

const I2C_Device = @This();

/// Pointer to the object implementing the driver.
///
/// If the implementation requires no `ptr` pointer,
/// you can safely use `undefined` here.
ptr: *anyopaque,

/// Virtual table for the datagram device functions.
vtable: *const VTable,

pub fn set_address(dev: I2C_Device, addr: Address, allow_reserved: AllowReserved) InterfaceError!void {
    const set_address_fn = dev.vtable.set_address_fn orelse return InterfaceError.Unsupported;
    return set_address_fn(dev.ptr, addr, allow_reserved);
}

/// Writes a single `datagram` to the device.
pub fn write(dev: I2C_Device, datagram: []const u8) InterfaceError!void {
    return try dev.writev(&.{datagram});
}

/// Writes multiple `datagrams` to the device.
pub fn writev(dev: I2C_Device, datagrams: []const []const u8) InterfaceError!void {
    const writev_fn = dev.vtable.writev_fn orelse return InterfaceError.Unsupported;
    return writev_fn(dev.ptr, datagrams);
}

/// Writes then reads a single `datagram` to the device.
pub fn write_then_read(dev: I2C_Device, src: []const u8, dst: []u8) InterfaceError!void {
    return try dev.writev_then_readv(&.{src}, &.{dst});
}

/// Writes a slice of datagrams to the device, then reads back into another slice of datagrams
pub fn writev_then_readv(
    dev: I2C_Device,
    write_chunks: []const []const u8,
    read_chunks: []const []u8,
) InterfaceError!void {
    const writev_then_readv_fn = dev.vtable.writev_then_readv_fn orelse return InterfaceError.Unsupported;
    return writev_then_readv_fn(dev.ptr, write_chunks, read_chunks);
}

/// Reads a single `datagram` from the device.
/// Function returns the number of bytes written in `datagram`.
pub fn read(dev: I2C_Device, datagram: []u8) InterfaceError!usize {
    return try dev.readv(&.{datagram});
}

/// Reads multiple `datagrams` from the device.
/// Function returns the number of bytes written in `datagrams`.
pub fn readv(dev: I2C_Device, datagrams: []const []u8) InterfaceError!usize {
    const readv_fn = dev.vtable.readv_fn orelse return InterfaceError.Unsupported;
    return readv_fn(dev.ptr, datagrams);
}

const AllowReserved = enum { AllowReserved, DontAllowReserved };

pub const VTable = struct {
    set_address_fn: ?*const fn (*anyopaque, Address, AllowReserved) InterfaceError!void,
    writev_fn: ?*const fn (*anyopaque, datagrams: []const []const u8) InterfaceError!void,
    readv_fn: ?*const fn (*anyopaque, datagrams: []const []u8) InterfaceError!usize,
    writev_then_readv_fn: ?*const fn (
        *anyopaque,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) InterfaceError!void = null,
};

/// A device implementation that can be used to write unit tests for datagram devices.
pub const Test_Device = struct {
    arena: std.heap.ArenaAllocator,
    packets: std.ArrayList([]u8),

    // If empty, reads are supported, but don't yield data.
    // If `null`, reads are not supported.
    input_sequence: ?[]const []const u8,
    input_sequence_pos: usize,

    addr: Address,
    write_enabled: bool,

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

            .addr = @enumFromInt(0),
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

    pub fn i2c_device(td: *Test_Device) I2C_Device {
        return I2C_Device{
            .ptr = td,
            .vtable = &vtable,
        };
    }

    fn set_address(ctx: *anyopaque, addr: Address, allow_reserved: AllowReserved) InterfaceError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));
        if (allow_reserved == .DontAllowReserved)
            addr.is_reserved() catch return Error.IllegalAddress;
        td.addr = addr;
    }

    fn writev(ctx: *anyopaque, datagrams: []const []const u8) InterfaceError!void {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));

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

        const dg = td.arena.allocator().alloc(u8, total_len) catch return error.UnknownAbort;
        errdefer td.arena.allocator().free(dg);

        {
            var offset: usize = 0;
            for (datagrams) |datagram| {
                @memcpy(dg[offset..][0..datagram.len], datagram);
                offset += datagram.len;
            }
            std.debug.assert(offset == total_len);
        }

        td.packets.append(dg) catch return error.UnknownAbort;
    }

    fn readv(ctx: *anyopaque, datagrams: []const []u8) InterfaceError!usize {
        const td: *Test_Device = @ptrCast(@alignCast(ctx));

        const inputs = td.input_sequence orelse return error.Unsupported;

        if (td.input_sequence_pos >= inputs.len) {
            return error.NoData;
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

    fn writev_then_readv(ctx: *anyopaque, write_chunks: []const []const u8, read_chunks: []const []u8) InterfaceError!void {
        try Test_Device.writev(ctx, write_chunks);
        _ = try Test_Device.readv(ctx, read_chunks);
    }

    const vtable = I2C_Device.VTable{
        .set_address_fn = Test_Device.set_address,
        .writev_fn = Test_Device.writev,
        .readv_fn = Test_Device.readv,
        .writev_then_readv_fn = Test_Device.writev_then_readv,
    };
};

test "Address.is_reserved returns correct error types" {
    const TestCase = struct {
        address: u7,
        expected_error: ?Address.Error,
        description: []const u8,
    };

    const test_cases = [_]TestCase{
        .{ .address = 0x00, .expected_error = Address.Error.GeneralCall, .description = "General Call" },
        .{ .address = 0x01, .expected_error = Address.Error.CBUSAddress, .description = "CBUS Address" },
        .{ .address = 0x02, .expected_error = Address.Error.ReservedFormat, .description = "Reserved Format" },
        .{ .address = 0x03, .expected_error = Address.Error.ReservedFuture, .description = "Reserved for future purposes" },
        .{ .address = 0x08, .expected_error = Address.Error.HighSpeedMaster, .description = "High-Speed Master Code" },
        .{ .address = 0x0F, .expected_error = Address.Error.HighSpeedMaster, .description = "High-Speed Master Code" },
        .{ .address = 0x78, .expected_error = Address.Error.TenBitSlave, .description = "10-bit Slave Addressing" },
        .{ .address = 0x7B, .expected_error = Address.Error.TenBitSlave, .description = "10-bit Slave Addressing" },
        .{ .address = 0x7C, .expected_error = Address.Error.ReservedFuture, .description = "Reserved for future purposes" },
        .{ .address = 0x7F, .expected_error = Address.Error.ReservedFuture, .description = "Reserved for future purposes" },
        .{ .address = 0x10, .expected_error = null, .description = "Valid address" },
        .{ .address = 0x50, .expected_error = null, .description = "Valid address" },
        .{ .address = 0x77, .expected_error = null, .description = "Valid address" },
    };

    for (test_cases) |test_case| {
        const addr: Address = @enumFromInt(test_case.address);
        if (test_case.expected_error) |expected_error| {
            std.testing.expectError(expected_error, addr.is_reserved()) catch |err| {
                std.debug.print(
                    "Failed test case: {s} (address 0x{X:0>2})\n",
                    .{ test_case.description, test_case.address },
                );
                return err;
            };
        } else {
            addr.is_reserved() catch |err| {
                std.debug.print(
                    "Expected valid address but got error for: {s} (address 0x{X:0>2})\n",
                    .{ test_case.description, test_case.address },
                );
                return err;
            };
        }
    }
}

test Test_Device {
    var td = Test_Device.init(&.{
        "first datagram",
        "second datagram",
        "the very third datagram which overruns the buffer",
    }, true);
    defer td.deinit();

    var buffer: [16]u8 = undefined;

    const dd = td.i2c_device();

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
    try std.testing.expectError(error.NoData, dd.read(&buffer));

    try dd.write("Hello, World!");
    try dd.writev(&.{ "See", " you ", "soon!" });

    // Check if we had exactly these datagrams:
    try td.expect_sent(&.{
        "Hello, World!",
        "See you soon!",
    });
}
