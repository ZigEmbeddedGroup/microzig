const std = @import("std");
const micro = @import("../deps/microzig/src/main.zig");
const Chip = micro.Chip;
const MemoryRegion = micro.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const gd32vf103xb = Chip.from_standard_paths(root_dir(), .{
    .name = "GD32VF103",
    .cpu = micro.cpus.riscv32_imac,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 128 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 32 * 1024, .kind = .ram },
    },
});

pub const gd32vf103x8 = Chip.from_standard_paths(root_dir(), .{
    .name = "GD32VF103",
    .cpu = micro.cpus.riscv32_imac,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
    },
});
