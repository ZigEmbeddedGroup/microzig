const std = @import("std");
const microzig = @import("microzig");

pub const Chip = enum {
    esp32_c3,
};

pub const chip: Chip = blk: {
    if (std.mem.eql(u8, microzig.config.chip_name, "ESP32-C3")) {
        break :blk .esp32_c3;
    } else {
        @compileError(std.fmt.comptimePrint("Unsupported chip for ESP HAL: \"{s}\"", .{microzig.config.chip_name}));
    }
};
