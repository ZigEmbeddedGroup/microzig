const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

pub fn create_peripheral_enum(comptime base_name: []const u8, match_type: ?[]const u8) type {
    const base_len = base_name.len;
    var names: [10]std.builtin.Type.EnumField = undefined;
    var names_index = 0;
    var num_index = 0;
    const peripheral = @typeInfo(peripherals);
    switch (peripheral) {
        .@"struct" => |data| {
            for (data.decls) |decls| {
                const decl_name = decls.name;
                const type_name = @typeName(@TypeOf(@field(peripherals, decl_name)));
                if (std.mem.indexOf(u8, decl_name, base_name)) |base_index| {
                    num_index = base_index + base_len;
                    if (match_type) |match| {
                        _ = std.mem.indexOf(u8, type_name, match) orelse continue;
                    }
                    const peri_num = std.fmt.parseInt(usize, decl_name[num_index..], 10) catch names_index;
                    names[names_index] = std.builtin.Type.EnumField{
                        .name = decls.name,
                        .value = peri_num,
                    };
                    names_index += 1;
                }
            }
        },
        else => unreachable,
    }

    const peri_enum = std.builtin.Type{ .@"enum" = .{
        .tag_type = usize,
        .is_exhaustive = true,
        .decls = &[_]std.builtin.Type.Declaration{},
        .fields = names[0..names_index],
    } };
    return @Type(peri_enum);
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
