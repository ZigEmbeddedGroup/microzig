const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x000000, .length = 32 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x800100, .length = 2048, .kind = .ram },
};
