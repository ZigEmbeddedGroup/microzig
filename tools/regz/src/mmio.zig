const std = @import("std");

pub fn Mmio(comptime size: u8, comptime PackedT: type) type {
    if ((size % 8) != 0)
        @compileError("size must be divisible by 8!");

    if (!std.math.isPowerOfTwo(size / 8))
        @compileError("size must encode a power of two number of bytes!");

    const IntT = std.meta.Int(.unsigned, size);

    if (@sizeOf(PackedT) != (size / 8))
        @compileError(std.fmt.comptimePrint("IntT and PackedT must have the same size!, they are {} and {} bytes respectively", .{ size / 8, @sizeOf(PackedT) }));

    return extern struct {
        const Self = @This();

        raw: IntT,

        pub const underlying_type = PackedT;

        pub inline fn read(addr: *volatile Self) PackedT {
            return @as(PackedT, @bitCast(addr.raw));
        }

        pub inline fn write(addr: *volatile Self, val: PackedT) void {
            // This is a workaround for a compiler bug related to miscompilation
            // If the tmp var is not used, result location will fuck things up
            const tmp = @as(IntT, @bitCast(val));
            addr.raw = tmp;
        }

        pub inline fn modify(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                @field(val, field.name) = @field(fields, field.name);
            }
            write(addr, val);
        }

        pub inline fn toggle(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                @field(val, field.name) = @field(val, field.name) ^ @field(fields, field.name);
            }
            write(addr, val);
        }
    };
}
