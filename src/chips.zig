const std = @import("std");
const micro = @import("microzig");
const Chip = micro.Chip;
const MemoryRegion = micro.MemoryRegion;

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

pub const nrf52840 = Chip{
    .name = "nrf52840",
    .source = .{ .path = root_dir() ++ "/chips/nrf52840.zig" },
    .json_register_schema = .{ .path = root_dir() ++ "/chips.nrf52840.json" },
    .cpu = micro.cpus.cortex_m4,

    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 0x100000, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 0x40000, .kind = .ram },

        // EXTFLASH
        MemoryRegion{ .offset = 0x12000000, .length = 0x8000000, .kind = .flash },

        // CODE_RAM
        MemoryRegion{ .offset = 0x800000, .length = 0x40000, .kind = .ram },
    },
};

pub const nrf52832 = Chip{
    .name = "nrf52",
    .source = .{ .path = root_dir() ++ "/chips/nrf52.zig" },
    .json_register_schema = .{ .path = root_dir() ++ "/chips.nrf52.json" },
    .cpu = micro.cpus.cortex_m4,

    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 0x80000, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 0x10000, .kind = .ram },
    },
};
