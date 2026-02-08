const std = @import("std");
const assert = std.debug.assert;

pub fn OldMmio(comptime PackedT: type) type {
    const startsWith = std.mem.startsWith;

    var access: MmioAccess(PackedT) = undefined;
    for (@typeInfo(PackedT).@"struct".fields) |fld| {
        const read_only = startsWith(u8, fld.name, "reserved") or
            startsWith(u8, fld.name, "_reserved") or
            startsWith(u8, fld.name, "padding");
        @field(access, fld.name) = if (read_only) .@"read-only" else .@"read-write";
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

    // Mapping of svd types
    pub const @"read-only": @This() = .{ .read = .normal, .write = .ignored };
    pub const @"read-write": @This() = .{ .read = .normal, .write = .normal };
    pub const @"read-write-once": @This() = .@"read-write";
    pub const @"write-only": @This() = .{ .read = .garbage, .write = .normal };
    pub const @"write-once": @This() = .@"write-only";
    pub const @"read/clear": @This() = .{ .read = .normal, .write = .clear_mask };
    pub const reserved: @This() = .{ .read = .garbage, .write = .ignored };
};

fn check_type_has_all_fields(T: type, fields: anytype) void {
    inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field| {
        if (!@hasField(T, field.name))
            @compileError("Field " ++ field.name ++ " not present in " ++ @typeName(T));
    }
}

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
        const all_zeros: PackedT = @bitCast(@as(IntT, 0));

        pub inline fn read(self: *volatile @This()) PackedT {
            comptime for (reg_fields) |field|
                switch (@field(access_type, field.name).read) {
                    .normal, .garbage, .special => {},
                    .illegal => reg_type_op_error(field.name, "reading from any fields of the register"),
                };
            return @bitCast(self.raw);
        }

        pub inline fn write(self: *volatile @This(), w: PackedT) void {
            comptime for (reg_fields) |field|
                switch (@field(access_type, field.name).write) {
                    .normal, .ignored, .set_mask, .clear_mask, .toggle_mask, .special => {},
                    .illegal => reg_type_op_error(field.name, "writing to any fields of the register"),
                };
            self.raw = @bitCast(w);
        }

        /// Set field `field_name` of this register to `value`.
        /// A one-field version of modify(), more helpful if `field_name` is comptime calculated.
        pub inline fn modify_one(
            self: *volatile @This(),
            comptime field_name: [:0]const u8,
            value: @FieldType(underlying_type, field_name),
        ) void {
            // Replace with @Struct when migrating to zig 0.16
            var fields: @import("core/usb.zig").Struct(
                .auto,
                null,
                &.{field_name},
                &.{@TypeOf(value)},
                &.{.{}},
            ) = undefined;
            @field(fields, field_name) = value;
            self.modify(fields);
        }

        /// For each `.Field = value` entry of `fields`:
        /// Set field `Field` of this register to `value`.
        /// This is implemented using read-modify-write.
        pub inline fn modify(self: *volatile @This(), fields: anytype) void {
            @setEvalBranchQuota(10_000);
            check_type_has_all_fields(PackedT, fields);
            const Fields = @TypeOf(fields);

            const r = self.read();
            var w: PackedT = undefined;
            inline for (reg_fields) |field| {
                const access = @field(access_type, field.name);
                @field(w, field.name) = if (@hasField(Fields, field.name))
                    // Overwrite this field
                    if (access.write == .normal and (access.read == .normal or access.read == .garbage))
                        @field(fields, field.name)
                    else
                        reg_type_op_error(field.name, "modifying this field by read-modify-write")
                else switch (access.write) {
                    // Leave field unchanged
                    .normal => if (access.read == .normal)
                        @field(r, field.name)
                    else
                        // This should actually be:
                        // reg_type_op_error(field.name, "modifying any field in this register by read-modify-write")
                        @field(all_zeros, field.name),
                    // Preserve old functionality
                    .ignored => @field(r, field.name),
                    // Write zeros so that nothing happens
                    .set_mask, .clear_mask, .toggle_mask => @field(all_zeros, field.name),
                    else => reg_type_op_error(field.name, "modifying any field in this register by read-modify-write"),
                };
            }
            self.write(w);
        }

        pub inline fn set_mask(self: *volatile @This(), fields: anytype) void {
            @setEvalBranchQuota(10_000);
            check_type_has_all_fields(PackedT, fields);
            const Fields = @TypeOf(fields);

            var w: PackedT = undefined;
            inline for (reg_fields) |field| {
                const access = @field(access_type, field.name);
                @field(w, field.name) = if (@hasField(Fields, field.name))
                    // Set bits in this field
                    if (access.write == .set_mask)
                        @field(fields, field.name)
                    else
                        reg_type_op_error(field.name, "setting bits of this field by masking")
                else switch (access.write) {
                    // Write zeros so that nothing happens
                    .ignored, .set_mask, .clear_mask, .toggle_mask => @field(all_zeros, field.name),
                    else => reg_type_op_error(field.name, "setting bits of any field in this register by masking"),
                };
            }
            self.write(w);
        }

        pub inline fn clear_mask(self: *volatile @This(), fields: anytype) void {
            @setEvalBranchQuota(10_000);
            check_type_has_all_fields(PackedT, fields);
            const Fields = @TypeOf(fields);

            var w: PackedT = undefined;
            inline for (reg_fields) |field| {
                const access = @field(access_type, field.name);
                @field(w, field.name) = if (@hasField(Fields, field.name))
                    // Clear bits in this field
                    if (access.write == .clear_mask)
                        @field(fields, field.name)
                    else
                        reg_type_op_error(field.name, "clearing bits of this field by masking")
                else switch (access.write) {
                    // Write zeros so that nothing happens
                    .ignored, .set_mask, .clear_mask, .toggle_mask => @field(all_zeros, field.name),
                    else => reg_type_op_error(field.name, "clearing bits of any field in this register by masking"),
                };
            }
            self.write(w);
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
