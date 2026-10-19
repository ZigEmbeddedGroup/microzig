const std = @import("std");

pub fn EndianInt(comptime T: type, e: std.lang.Endian) type {
    return packed struct(T) {
        raw: T,

        pub fn from(val: T) @This() {
            return .{ .raw = std.mem.nativeTo(T, val, e) };
        }

        pub fn native(self: @This()) T {
            return std.mem.toNative(T, self.raw, e);
        }

        pub fn format(self: @This(), writer: *std.Io.Writer) !void {
            try writer.print("{}", .{self.native()});
        }
    };
}
