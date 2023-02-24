const std = @import("std");
const microzig = @import("../deps/microzig/build.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

const chip_path = std.fmt.comptimePrint("{s}/chips/RP2040.zig", .{root_dir()});
const hal_path = std.fmt.comptimePrint("{s}/hal.zig", .{root_dir()});
const json_register_schema_path = std.fmt.comptimePrint("{s}/chips/RP2040.json", .{root_dir()});

pub const rp2040 = microzig.Chip{
    .name = "RP2040",
    .source = .{ .path = chip_path },
    .hal = .{ .path = hal_path },
    .cpu = microzig.cpus.cortex_m0plus,
    .memory_regions = &.{
        .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
        .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
        .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
    },
    .json_register_schema = .{
        .path = json_register_schema_path,
    },
};
