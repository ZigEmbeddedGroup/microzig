const std = @import("std");
const microzig = @import("microzig");

pub fn create_peripheral_enum(comptime base_name: []const u8) type {
    var names: [10]std.builtin.Type.EnumField = undefined;
    var names_index = 0;
    const peripheral = @typeInfo(microzig.chip.peripherals);
    switch (peripheral) {
        .@"struct" => |data| {
            for (data.decls) |decls| {
                if (std.mem.startsWith(u8, decls.name, base_name)) {
                    names[names_index] = std.builtin.Type.EnumField{
                        .name = decls.name,
                        .value = names_index,
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
