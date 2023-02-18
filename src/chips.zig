const std = @import("std");
const micro = @import("../deps/microzig/src/main.zig");
const Chip = micro.Chip;
const MemoryRegion = micro.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const lpc176x5x = Chip.from_standard_paths(root_dir(), .{
    .name = "LPC176x5x",
    .cpu = micro.cpus.cortex_m3,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
        MemoryRegion{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
    },
});
