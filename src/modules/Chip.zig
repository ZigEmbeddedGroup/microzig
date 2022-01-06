const MemoryRegion = @import("MemoryRegion.zig");
const Cpu = @import("Cpu.zig");

name: []const u8,
path: []const u8,
cpu: Cpu,
memory_regions: []const MemoryRegion,
