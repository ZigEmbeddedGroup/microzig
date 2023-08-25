const std = @import("std");
const microzig = @import("microzig");
const cpus = @import("cpus.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const esp32_c3 = microzig.Chip{
    .name = "ESP32-C3",
    .source = .{
        .path = root_dir() ++ "/chips/ESP32_C3.zig",
    },
    .hal = .{
        .path = root_dir() ++ "/hals/ESP32_C3.zig",
    },

    .cpu = cpus.esp32_c3,
    .memory_regions = &.{
        .{ .kind = .flash, .offset = 0x4200_0000, .length = 0x0080_0000 }, // external memory, ibus
        .{ .kind = .ram, .offset = 0x3FC8_0000, .length = 0x0006_0000 }, // sram 1, data bus
    },
};
