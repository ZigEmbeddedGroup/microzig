const std = @import("std");
const assert = std.debug.assert;

pub fn OldMmio(comptime PackedT: type) type {
    var access: MmioAccess(PackedT) = undefined;
    for (@typeInfo(PackedT).@"struct".fields) |fld|
        @field(access, fld.name) = .read_write;
    return Mmio(PackedT, access);
}

pub const Access = enum {
    read_only,
    read_write,
};

pub fn MmioAccess(comptime PackedT: type) type {
    @setEvalBranchQuota(20_000);
    const info = @typeInfo(PackedT).@"struct";
    var field_names: [info.fields.len][:0]const u8 = undefined;
    for (&field_names, info.fields) |*dst, src|
        dst.* = src.name;
    return @import("../src/core/usb.zig").Struct(
        .auto,
        null,
        &field_names,
        &@splat(Access),
        &@splat(.{}),
    );
}

pub fn Mmio(comptime PackedT: type, access: MmioAccess(PackedT)) type {
    _ = access;
    @setEvalBranchQuota(2_000);

    const size = @bitSizeOf(PackedT);
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
            return @bitCast(addr.raw);
        }

        pub inline fn write(addr: *volatile Self, val: PackedT) void {
            comptime {
                assert(@bitSizeOf(PackedT) == @bitSizeOf(IntT));
            }
            addr.write_raw(@bitCast(val));
        }

        pub inline fn write_raw(addr: *volatile Self, val: IntT) void {
            addr.raw = val;
        }

        /// Set field `field_name` of this register to `value`.
        /// A one-field version of modify(), more helpful if `field_name` is comptime calculated.
        pub inline fn modify_one(addr: *volatile Self, comptime field_name: []const u8, value: @FieldType(underlying_type, field_name)) void {
            var val = read(addr);
            @field(val, field_name) = value;
            write(addr, val);
        }

        /// For each `.Field = value` entry of `fields`:
        /// Set field `Field` of this register to `value`.
        pub inline fn modify(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                @field(val, field.name) = @field(fields, field.name);
            }
            write(addr, val);
        }
    };
}
