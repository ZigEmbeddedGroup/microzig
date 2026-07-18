const std = @import("std");
const assert = std.debug.assert;
const FieldAttributes = std.builtin.Type.Struct.FieldAttributes;

pub fn Mmio(T: type) type {
    @setEvalBranchQuota(10_000);

    const info = @typeInfo(T);
    if (info != .@"struct" or info.@"struct".layout != .@"packed")
        @compileError("Expected a packed struct, got " ++ @typeName(T));

    if (@bitSizeOf(T) != @sizeOf(T) * 8)
        @compileError(std.fmt.comptimePrint(
            "Bitsize of {s} ({}) must be 8 times its size ({}).",
            .{ @typeName(T), @bitSizeOf(T), @sizeOf(T) },
        ));

    if (!std.math.isPowerOfTwo(@sizeOf(T)))
        @compileError(std.fmt.comptimePrint(
            "Size of {s} ({}) must be a power of two.",
            .{ @typeName(T), @bitSizeOf(T), @sizeOf(T) },
        ));

    return extern struct {
        const field_names = info.@"struct".field_names;
        const field_types = info.@"struct".field_types[0..field_names.len].*;

        /// Struct defining register field layout
        pub const Fields = T;
        /// Backing integer
        pub const Int = @Int(.unsigned, @bitSizeOf(Fields));
        /// Naturally aligned volatile pointer
        pub const MmioPtr = *align(@sizeOf(Fields)) volatile @This();
        /// Like `Fields`, but all fields are optional and default to `null`
        pub const FieldsOpt = @Struct(
            .auto,
            null,
            field_names,
            blk: {
                var ret: [field_names.len]type = undefined;
                for (0..field_names.len) |i|
                    ret[i] = ?field_types[i];
                break :blk &ret;
            },
            blk: {
                var ret: [field_names.len]FieldAttributes = undefined;
                for (0..field_names.len) |i| {
                    const default: ?field_types[i] = null;
                    ret[i] = .{ .default_value_ptr = &default };
                }
                break :blk &ret;
            },
        );
        /// Identical struct to `Fields`, but all fields without
        /// default values are given a default value of zero.
        pub const FieldsZero = @Struct(
            .@"packed",
            Int,
            field_names,
            &field_types,
            blk: {
                var ret: [field_names.len]FieldAttributes = undefined;
                for (0..field_names.len) |i| {
                    ret[i] = info.@"struct".field_attrs[i];
                    if (ret[i].default_value_ptr == null) {
                        const default = std.mem.zeroes(field_types[i]);
                        ret[i].default_value_ptr = &default;
                    }
                }
                break :blk &ret;
            },
        );

        /// Unstable API. Use read/write functions instead.
        raw: Int,

        pub inline fn read_raw(mmio: MmioPtr) Int {
            return mmio.raw;
        }

        pub inline fn write_raw(mmio: MmioPtr, val: Int) void {
            mmio.raw = val;
        }

        pub inline fn read(mmio: MmioPtr) Fields {
            return @bitCast(mmio.read_raw());
        }

        pub inline fn write(mmio: MmioPtr, val: Fields) void {
            mmio.write_raw(@bitCast(val));
        }

        /// Set field `field_name` of this register to `value`.
        /// A one-field version of modify(), more helpful if `field_name` is comptime calculated.
        pub inline fn modify_one(
            addr: MmioPtr,
            comptime field_name: []const u8,
            value: @FieldType(Fields, field_name),
        ) void {
            var val = read(addr);
            @field(val, field_name) = value;
            write(addr, val);
        }

        /// For each `.Field = value` entry of `fields`:
        /// Set field `Field` of this register to `value`.
        /// Operiation done by read-modify-write.
        pub inline fn modify(mmio: MmioPtr, fields: FieldsOpt) void {
            var val = mmio.read();
            inline for (field_names) |field_name| {
                if (@field(fields, field_name)) |value|
                    @field(val, field_name) = value;
            }
            mmio.write(val);
        }

        /// For each `.Field = value` entry of `fields`:
        /// Set field `Field` of this register to `value`.
        /// All unspecified fields are initialized to zero.
        /// Particularily useful for registers with atomic set/clear/xor
        pub inline fn write_default_zero(mmio: MmioPtr, fields: FieldsZero) void {
            mmio.write(@bitCast(fields));
        }
    };
}
