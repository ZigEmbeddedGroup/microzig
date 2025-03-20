const std = @import("std");
const microzig = @import("microzig");
const Chip = microzig.Chip;
const MemoryRegion = microzig.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
