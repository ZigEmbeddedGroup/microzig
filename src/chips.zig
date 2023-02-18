const std = @import("std");
const micro = @import("../deps/microzig/src/main.zig");
const Chip = micro.Chip;
const MemoryRegion = micro.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const atmega328p = Chip.from_standard_paths(root_dir(), .{
    .name = "ATmega328P",
    .cpu = micro.cpus.avr5,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
    },
});
