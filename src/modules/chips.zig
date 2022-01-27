const std = @import("std");
const cpus = @import("cpus.zig");
const Chip = @import("Chip.zig");
const MemoryRegion = @import("MemoryRegion.zig");

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const root_path = root() ++ "/";

pub const atmega328p = Chip{
    .name = "ATmega328p",
    .path = root_path ++ "chips/atmega328p/atmega328p.zig",
    .cpu = cpus.avr5,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
    },
};

pub const lpc1768 = Chip{
    .name = "NXP LPC1768",
    .path = root_path ++ "chips/lpc1768/lpc1768.zig",
    .cpu = cpus.cortex_m3,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
        MemoryRegion{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
    },
};

pub const stm32f103x8 = Chip{
    .name = "STM32F103x8",
    .path = root_path ++ "chips/stm32f103/stm32f103.zig",
    .cpu = cpus.cortex_m3,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x00000000, .length = 64 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x10000000, .length = 20 * 1024, .kind = .ram },
    },
};

pub const stm32f30x = Chip{
    .name = "STM32F30x",
    .path = root_path ++ "chips/stm32f30x/stm32f30x.zig",
    .cpu = cpus.cortex_m4,
    .memory_regions = &.{
        MemoryRegion{ .offset = 0x08000000, .length = 256 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x20000000, .length = 40 * 1024, .kind = .ram },
    },
};
