const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub fn has_port(comptime id: u8) bool {
    return @hasDecl(peripherals, "GPIO" ++ &[_]u8{id});
}

pub fn match_name(heystack: []const u8, needles: []const []const u8) bool {
    for (needles) |needle| {
        if (std.mem.indexOf(u8, heystack, needle)) |_| {
            return true;
        }
    }
    return false;
}

pub fn create_peripheral_enum() type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};
    @setEvalBranchQuota(10_000);
    for (@typeInfo(peripherals).@"struct".decl_names, 0..) |decl_name, i| {
        field_names = field_names ++ .{decl_name};
        field_values = field_values ++ .{i};
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

fn sorted_field_indices(comptime fields: []const [:0]const u8) [fields.len]usize {
    var _fields: [fields.len]usize = undefined;
    for (0..fields.len) |i| {
        _fields[i] = i;
    }

    const f: fn (void, usize, usize) bool = struct {
        fn s(_: void, a: usize, b: usize) bool {
            const aname = fields[a];
            const bname = fields[b];
            const an = std.mem.trimEnd(u8, aname, "0123456789");
            const bn = std.mem.trimEnd(u8, bname, "0123456789");
            const ai = std.fmt.parseInt(u8, aname[an.len..aname.len], 10) catch 0;
            const bi = std.fmt.parseInt(u8, bname[bn.len..bname.len], 10) catch 0;
            if (ai == bi) {
                return std.mem.order(u8, aname, bname) == .lt;
            }
            return ai < bi;
        }
    }.s;
    std.mem.sortUnstable(usize, &_fields, {}, f);
    return _fields;
}

pub fn sub_peripheral_enum(comptime T: type, comptime keep_name: []const []const u8, match_type: ?[]const u8) type {
    var field_names: []const []const u8 = &.{};
    var field_values: []const usize = &.{};

    @setEvalBranchQuota(30_000);
    const info = @typeInfo(T).@"enum";
    for (sorted_field_indices(info.field_names)) |i| {
        const field_name = info.field_names[i];
        const field_value = info.field_values[i];
        if (match_name(field_name, keep_name)) {
            if (match_type) |match| {
                const type_name = @typeName(@TypeOf(@field(peripherals, field_name)));
                _ = std.mem.indexOf(u8, type_name, match) orelse continue;
            }
            field_names = field_names ++ .{field_name};
            field_values = field_values ++ .{field_value};
        }
    }

    return @Enum(usize, .exhaustive, field_names, field_values[0..]);
}

fn num_nonempty_types(comptime size: usize, comptime T: [size]type) usize {
    var i: usize = 0;
    for (T) |t| {
        if (t != @Enum(usize, .exhaustive, &[0][]const u8{}, &[0]usize{})) {
            i += 1;
        }
    }
    return i;
}

pub fn filter_empty_types(comptime size: usize, comptime T: [size]type) [num_nonempty_types(size, T)]type {
    var ret: [num_nonempty_types(size, T)]type = undefined;
    var i: usize = 0;
    for (T) |t| {
        if (t != @Enum(usize, .exhaustive, &[0][]const u8{}, &[0]usize{})) {
            ret[i] = t;
            i += 1;
        }
    }
    return ret;
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
