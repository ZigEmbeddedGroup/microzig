const std = @import("std");
const FileSource = std.build.FileSource;

const MemoryRegion = @import("MemoryRegion.zig");
const Cpu = @import("Cpu.zig");

name: []const u8,
path: []const u8,
cpu: Cpu,
hal: ?FileSource = null,
json_register_schema: ?FileSource = null,
memory_regions: []const MemoryRegion,
