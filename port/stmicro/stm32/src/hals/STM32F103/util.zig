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

pub fn find_clock_tree(comptime name: []const u8) type {
    const F103 = @import("clocks/clock_stm32f103.zig");
    //ALL F1 peri
    const F105_7 = @import("clocks/clock_stm32f105.zig");

    if (std.mem.indexOf(u8, name, "105")) |_| return F105_7;
    if (std.mem.indexOf(u8, name, "107")) |_| return F105_7;
    return F103;
}
