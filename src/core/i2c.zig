const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

pub fn I2CMaster(comptime index: usize) type {
    const SystemI2CMaster = chip.I2CMaster(index);

    const I2CSlave = struct {
        const Self = @This();

        internal: SystemI2CMaster,
        address: u7,

        pub fn write(self: Self, bytes: []const u8) WriteError!void {
            try self.internal.write(self.address, bytes);
        }

        pub fn readByte(self: Self) ReadError!u8 {
            var buffer: [1]u8 = undefined;
            try self.internal.read(self.address, &buffer);
            return buffer[0];
        }
    };

    return struct {
        const Self = @This();

        internal: SystemI2CMaster,

        pub fn init() InitError!Self {
            return Self{
                .internal = try SystemI2CMaster.init(),
            };
        }

        pub fn slave(self: Self, address: u7) I2CSlave {
            return I2CSlave{ .internal = self.internal, .address = address };
        }
    };
}

pub const InitError = error{};
pub const WriteError = error{};
pub const ReadError = error{
    TooFewBytesReceived,
    TooManyBytesReceived,
};
