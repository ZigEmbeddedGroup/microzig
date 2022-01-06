const std = @import("std");
const micro = @import("microzig");
const micro_linker = @import("microzig-linker");

pub const cpu = @import("cpu");
pub const registers = @import("registers.zig");

pub const memory_regions = [_]micro_linker.MemoryRegion{
    micro_linker.MemoryRegion{ .offset = 0x00000000, .length = 64 * 1024, .kind = .flash },
    micro_linker.MemoryRegion{ .offset = 0x10000000, .length = 20 * 1024, .kind = .ram },
};
