const std = @import("std");
const assert = std.debug.assert;

pub fn OldMmio(comptime PackedT: type) type {
    const startsWith = std.mem.startsWith;

    var access: MmioAccess(PackedT) = undefined;
    for (@typeInfo(PackedT).@"struct".fields) |fld| {
        const read_only = startsWith(u8, fld.name, "reserved") or startsWith(u8, fld.name, "padding");
        @field(access, fld.name) = if (read_only) .read_only else .read_write;
    }
    return Mmio(PackedT, access);
}

/// Access type of a single field. Special and illegal have
/// the same functionality, but display different error messages.
pub const Access = struct {
    /// Effect of reading the field
    pub const Read = enum {
        /// Reading returns the currently stored field value and does not affect it.
        normal,
        /// Reading is not an error, but the returned value is meaningless.
        garbage,
        /// Reading changes the field value in an implementation-defined way.
        special,
        /// This register should never be read from.
        illegal,
        // There exist more!
    };

    pub const Write = enum {
        /// Writing sets the field value to what was written.
        normal,
        /// Writing has no effect.
        ignored,
        /// Write 1 to set, 0 to leave unaffected.
        set_mask,
        /// Write 1 to clear, 0 to leave unaffected.
        clear_mask,
        /// Write 1 to toggle, 0 to leave unaffected.
        toggle_mask,
        /// Writing changes the this field in an implementation-defined way.
        special,
        /// This register should never be written to.
        illegal,
        // There exist more!
    };

    read: Read,
    write: Write,

    pub const read_only: @This() = .{ .read = .normal, .write = .ignored };
    pub const read_write: @This() = .{ .read = .normal, .write = .normal };
    pub const write_only: @This() = .{ .read = .garbage, .write = .normal };
    pub const reserved: @This() = .{ .read = .garbage, .write = .ignored };
};

/// If a field is not null, it contains the name of one of the registers
/// that prevent this capability, so that a nice error message can be displayed.
const Capabilities = struct {
    /// If null, register can be read from.
    read: ?[:0]const u8 = null,
    /// If null, register can be written to.
    write: ?[:0]const u8 = null,
    /// If null, register can have bits set by a write operation.
    set_mask: ?[:0]const u8 = null,
    /// If null, register can have bits cleared by a write operation.
    clear_mask: ?[:0]const u8 = null,
    /// If null, register can have bits toggled by a write operation.
    toggle_mask: ?[:0]const u8 = null,
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

pub fn Mmio(comptime PackedT: type, access_type: MmioAccess(PackedT)) type {
    @setEvalBranchQuota(2_000);

    const IntT, const reg_fields = switch (@typeInfo(PackedT)) {
        .@"struct" => |info| .{ switch (info.layout) {
            .@"packed" => info.backing_integer.?,
            else => @compileError("Struct must be packed"),
        }, info.fields },
        else => @compileError("Unsupported type: " ++ @typeName(PackedT)),
    };

    if (@bitSizeOf(PackedT) != 8 * @sizeOf(PackedT))
        @compileError("Size in bits must be divisible by 8");

    if (!std.math.isPowerOfTwo(@sizeOf(PackedT)))
        @compileError("Size in bytes must be a power of two");

    if (@alignOf(PackedT) != @sizeOf(PackedT))
        @compileError("PackedT must be naturally aligned");

    if (@sizeOf(IntT) != @sizeOf(PackedT)) @compileError(std.fmt.comptimePrint(
        "IntT and PackedT must have the same size, they are {} and {} bytes respectively",
        .{ @sizeOf(IntT), @sizeOf(PackedT) },
    ));

    if (@bitSizeOf(IntT) != @bitSizeOf(PackedT)) @compileError(std.fmt.comptimePrint(
        "IntT and PackedT must have the same bitsize, they are {} and {} bits respectively",
        .{ @bitSizeOf(IntT), @bitSizeOf(PackedT) },
    ));

    return extern struct {
        raw: IntT,

        pub const underlying_type = PackedT;
        const capabilities: Capabilities = blk: {
            var ret: Capabilities = .{};
            for (reg_fields) |field| {
                const a: Access = @field(access_type, field.name);
                switch (a.read) {
                    .normal, .garbage => {},
                    .special, .illegal => ret.read = field.name,
                }
                switch (a.write) {
                    .normal => {
                        ret.set_mask = field.name;
                        ret.clear_mask = field.name;
                        ret.toggle_mask = field.name;
                    },
                    .ignored => {},
                    .set_mask => {
                        ret.write = field.name;
                        ret.clear_mask = field.name;
                        ret.toggle_mask = field.name;
                    },
                    .clear_mask => {
                        ret.write = field.name;
                        ret.set_mask = field.name;
                        ret.toggle_mask = field.name;
                    },
                    .toggle_mask => {
                        ret.write = field.name;
                        ret.set_mask = field.name;
                        ret.clear_mask = field.name;
                    },
                    .special, .illegal => {
                        ret.write = field.name;
                        ret.set_mask = field.name;
                        ret.clear_mask = field.name;
                        ret.toggle_mask = field.name;
                    },
                }
                break :blk ret;
            }
        };

        pub inline fn read(self: *volatile @This()) PackedT {
            if (capabilities.read) |name|
                reg_type_op_error(name, "reading from the register");

            return @bitCast(self.raw);
        }

        pub inline fn write(self: *volatile @This(), val: PackedT) void {
            if (capabilities.write) |name|
                reg_type_op_error(name, "writing to the register");

            self.raw = @bitCast(val);
        }

        /// Set field `field_name` of this register to `value`.
        /// A one-field version of modify(), more helpful if `field_name` is comptime calculated.
        pub inline fn modify_one(
            self: *volatile @This(),
            comptime field_name: []const u8,
            value: @FieldType(underlying_type, field_name),
        ) void {
            if (capabilities.read) |name|
                reg_type_op_error(name, "modifying this register by read-modify-write");
            if (capabilities.write) |name|
                reg_type_op_error(name, "modifying this register by read-modify-write");

            if (@field(access_type, field_name).write != .normal)
                reg_type_op_error(field_name, "modifying this field by read-modify-write");

            var val: PackedT = @bitCast(self.raw);
            @field(val, field_name) = value;
            self.raw = @bitCast(val);
        }

        /// For each `.Field = value` entry of `fields`:
        /// Set field `Field` of this register to `value`.
        /// This is implemented using read-modify-write.
        pub inline fn modify(self: *volatile @This(), fields: anytype) void {
            if (capabilities.read) |name|
                reg_type_op_error(name, "modifying this register by read-modify-write");
            if (capabilities.write) |name|
                reg_type_op_error(name, "modifying this register by read-modify-write");

            self.modify_passed_value_and_write(
                @bitCast(@as(IntT, 0)),
                fields,
                .normal,
                "modifying this field by read-modify-write",
            );
        }

        pub inline fn set_mask(self: *volatile @This(), fields: anytype) void {
            if (capabilities.set_mask) |name|
                reg_type_op_error(name, "setting bits in this register by masking");

            self.modify_passed_value_and_write(
                @bitCast(@as(IntT, 0)),
                fields,
                .set_mask,
                "setting bits in this field by masking",
            );
        }

        pub inline fn clear_mask(self: *volatile @This(), fields: anytype) void {
            if (capabilities.clear_mask) |name|
                reg_type_op_error(name, "clearing bits in this register by masking");

            self.modify_passed_value_and_write(
                @bitCast(@as(IntT, 0)),
                fields,
                .clear_mask,
                "clearing bits in this field by masking",
            );
        }

        inline fn modify_passed_value_and_write(
            self: *volatile @This(),
            initial: PackedT,
            fields: anytype,
            allowed_write_access: Access.Write,
            comptime action: [:0]const u8,
        ) void {
            var val = initial;
            inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
                if (@field(access_type, field.name).write != allowed_write_access)
                    reg_type_op_error(field.name, action);
                @field(val, field.name) = @field(fields, field.name);
            }
            self.raw = @bitCast(val);
        }

        fn reg_type_op_error(comptime reg_name: [:0]const u8, comptime action: []const u8) noreturn {
            const a = @field(access_type, reg_name);
            @compileError(
                "Register field's \"" ++ reg_name ++ "\" access type is read: " ++
                    @tagName(a.read) ++ ", write: " ++ @tagName(a.write) ++ ",\nso " ++ action ++
                    \\ is not possible.
                    \\
                    \\If you think the access type is wrong, you can add a svd patch
                    \\in port/.../.../patches or to your build.zig directly.
                    \\
                    \\-freference-trace may be useful to locate where this was called.
                ,
            );
        }
    };
}
