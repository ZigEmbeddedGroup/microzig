const std = @import("std");
const assert = std.debug.assert;

pub fn Mmio(comptime PackedT: type) type {
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
        pub inline fn modify_one(addr: *volatile Self, comptime field_name: []const u8, value: anytype) void {
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

        /// In field `field_name` of struct `val`, toggle (only) all bits that are set in `value`.
        inline fn toggle_field(val: anytype, comptime field_name: []const u8, value: anytype) void {
            const FieldType = @TypeOf(@field(val, field_name));
            switch (@typeInfo(FieldType)) {
                .int => {
                    @field(val, field_name) = @field(val, field_name) ^ value;
                },
                .@"enum" => |enum_info| {
                    // same as for the .Int case, but casting to and from the u... tag type U of the enum FieldType
                    const U = enum_info.tag_type;
                    @field(val, field_name) =
                        @as(FieldType, @enumFromInt(@as(U, @intFromEnum(@field(val, field_name))) ^
                        @as(U, @intFromEnum(@as(FieldType, value)))));
                },
                else => |T| {
                    @compileError("unsupported register field type '" ++ @typeName(T) ++ "'");
                },
            }
        }

        /// In field `field_name` of this register, toggle (only) all bits that are set in `value`.
        /// A one-field version of toggle(), more helpful if `field_name` is comptime calculated.
        pub inline fn toggle_one(addr: *volatile Self, comptime field_name: []const u8, value: anytype) void {
            var val = read(addr);
            toggle_field(&val, field_name, value);
            write(addr, val);
        }

        /// For each `.Field = value` entry of `fields`:
        /// In field `F` of this register, toggle (only) all bits that are set in `value`.
        pub inline fn toggle(addr: *volatile Self, fields: anytype) void {
            var val = read(addr);
            inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                toggle_field(&val, field.name, @field(fields, field.name));
            }
            write(addr, val);
        }
    };
}
