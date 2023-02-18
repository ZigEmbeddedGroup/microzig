const std = @import("std");
const microzig = @import("../deps/microzig/src/main.zig");
const Chip = microzig.Chip;
const MemoryRegion = microzig.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const stm32f103x8 = Chip.from_standard_paths(root_dir(), .{
    .name = "STM32F103",
    .cpu = microzig.cpus.cortex_m3,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 64 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 20 * 1024, .kind = .ram },
    },
});

pub const stm32f303vc = Chip.from_standard_paths(root_dir(), .{
    .name = "STM32F303",
    .cpu = microzig.cpus.cortex_m4,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 256 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 40 * 1024, .kind = .ram },
    },
});

pub const stm32f407vg = Chip.from_standard_paths(root_dir(), .{
    .name = "STM32F407",
    .cpu = microzig.cpus.cortex_m4,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 1024 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 128 * 1024, .kind = .ram },
        // CCM RAM
        MemoryRegion{ .offset = 0x10000000, .length = 64 * 1024, .kind = .ram },
    },
});

pub const stm32f429zit6u = Chip.from_standard_paths(root_dir(), .{
    .name = "STM32F429",
    .cpu = microzig.cpus.cortex_m4,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 2048 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 192 * 1024, .kind = .ram },
        // CCM RAM
        MemoryRegion{ .offset = 0x10000000, .length = 64 * 1024, .kind = .ram },
    },
});
