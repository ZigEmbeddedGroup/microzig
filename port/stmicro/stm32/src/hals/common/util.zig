const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub fn match_name(heystack: []const u8, needles: []const []const u8) bool {
    for (needles) |needle| {
        if (std.mem.indexOf(u8, heystack, needle)) |_| {
            return true;
        }
    }
    return false;
}

pub fn create_peripheral_enum(comptime bases_name: []const []const u8) type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};
    @setEvalBranchQuota(10_000);
    for (@typeInfo(peripherals).@"struct".decls, 0..) |decl, i| {
        if (match_name(decl.name, bases_name)) {
            field_names = field_names ++ .{decl.name};
            field_values = field_values ++ .{i};
        }
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

pub fn sub_peripheral_enum(comptime T: type, comptime keep_name: []const []const u8, match_type: ?[]const u8) type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};
    @setEvalBranchQuota(10_000);
    for (@typeInfo(T).@"enum".fields) |field| {
        if (match_name(field.name, keep_name)) {
            if (match_type) |match| {
                const type_name = @typeName(@TypeOf(@field(peripherals, field.name)));
                _ = std.mem.indexOf(u8, type_name, match) orelse continue;
            }

            field_names = field_names ++ .{field.name};
            field_values = field_values ++ .{field.value};
        }
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

pub fn load_timer_interrupt(handler: *const fn () callconv(.c) void) microzig.cpu.InterruptOptions {
    var int_op: microzig.cpu.InterruptOptions = .{};
    if (@hasField(microzig.cpu.InterruptOptions, "TIM2")) {
        int_op.TIM2 = .{ .c = handler };
    }
    if (@hasField(microzig.cpu.InterruptOptions, "TIM3")) {
        int_op.TIM3 = .{ .c = handler };
    }
    if (@hasField(microzig.cpu.InterruptOptions, "TIM4")) {
        int_op.TIM4 = .{ .c = handler };
    }
    if (@hasField(microzig.cpu.InterruptOptions, "TIM5")) {
        int_op.TIM5 = .{ .c = handler };
    }

    return int_op;
}
