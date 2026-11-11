// This file is based on the stm32 port.

const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub fn match_name(heystack: []const u8, needles: []const []const u8) bool {
    for (needles) |needle| {
        if (std.mem.startsWith(u8, heystack, needle)) {
            return true;
        }
    }
    return false;
}

pub fn create_peripheral_enum(comptime bases_name: []const []const u8) type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};
    @setEvalBranchQuota(10_000);
    for (@typeInfo(peripherals).@"struct".decl_names, 0..) |decl_name, i| {
        if (match_name(decl_name, bases_name)) {
            field_names = field_names ++ .{decl_name};
            field_values = field_values ++ .{i};
        }
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

fn sub_peripheral_enum_impl(
    comptime Parent: type,
    comptime keep_name: []const []const u8,
    comptime match_type: ?[]const u8,
    comptime check_same_regs: bool,
) type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};
    @setEvalBranchQuota(10_000);
    const info = @typeInfo(Parent).@"enum";
    for (info.field_names, info.field_values) |field_name, field_value| {
        if (!match_name(field_name, keep_name)) continue;

        if (match_type) |match| {
            const type_name = @typeName(@TypeOf(@field(peripherals, field_name)));
            _ = std.mem.indexOf(u8, type_name, match) orelse continue;
        }

        field_names = field_names ++ .{field_name};
        field_values = field_values ++ .{field_value};
    }

    if (field_names.len == 0) {
        @compileError("sub_peripheral_enum: no peripheral of " ++ @typeName(Parent) ++ " matches the given criteria");
    }

    if (check_same_regs) {
        // to_reg() relies on every peripheral in the group sharing the same register block type.
        const first_regs = @TypeOf(@field(peripherals, field_names[0]));
        for (field_names[1..]) |field_name| {
            if (@TypeOf(@field(peripherals, field_name)) != first_regs) {
                @compileError("sub_peripheral_enum: " ++ field_name ++ " has a different register type (" ++
                    @typeName(@TypeOf(@field(peripherals, field_name))) ++ "); use match_type to split the group");
            }
        }
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

pub fn sub_peripheral_enum(comptime Parent: type, comptime keep_name: []const []const u8, comptime match_type: ?[]const u8) type {
    return sub_peripheral_enum_impl(Parent, keep_name, match_type, true);
}

/// Like `sub_peripheral_enum`, but does not require every peripheral in the
/// group to share one register block type. Use this for groups driven through
/// a hand-written common register view (see `spi.SpiRegs`); `to_reg` must not
/// be used on the result.
pub fn sub_peripheral_enum_any_type(comptime Parent: type, comptime keep_name: []const []const u8) type {
    return sub_peripheral_enum_impl(Parent, keep_name, null, false);
}

/// The register block pointer type shared by every peripheral in enum `E`.
fn Regs(comptime E: type) type {
    const info = @typeInfo(E).@"enum";
    if (info.field_names.len == 0) {
        @compileError("to_reg: " ++ @typeName(E) ++ " has no fields");
    }
    const R = @TypeOf(@field(peripherals, info.field_names[0]));
    for (info.field_names[1..]) |field_name| {
        if (@TypeOf(@field(peripherals, field_name)) != R) {
            @compileError("to_reg: " ++ @typeName(E) ++ " has mixed register types; narrow to a sub-enum first");
        }
    }
    return R;
}

/// Resolves a (sub-)peripheral enum value to its register block.
pub inline fn to_reg(id: anytype) Regs(@TypeOf(id)) {
    switch (id) {
        inline else => |tag| return @field(peripherals, @tagName(tag)),
    }
}
