const std = @import("std");
const cpus = @import("cpus.zig");
const MemoryRegion = @import("MemoryRegion.zig");

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const root_path = root() ++ "/";

pub const Chip = struct {
    name: []const u8,
    path: []const u8,
    cpu: cpus.Cpu,
    memory_regions: []const MemoryRegion,
};

pub const atmega328p = Chip{
    .name = "ATmega328p",
    .path = root_path ++ "chips/atmega328p/atmega328p.zig",
    .cpu = cpus.avr5,
    .memory_regions = &[_]MemoryRegion{
        MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
    },
};

pub const lpc1768 = Chip{
    .name = "NXP LPC1768",
    .path = root_path ++ "chips/lpc1768/lpc1768.zig",
    .cpu = cpus.cortex_m3,
    .memory_regions = &[_]MemoryRegion{
        MemoryRegion{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
        MemoryRegion{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
        MemoryRegion{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
    },
};
