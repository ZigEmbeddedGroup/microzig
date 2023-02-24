const std = @import("std");
const FileSource = std.build.FileSource;

const MemoryRegion = @import("MemoryRegion.zig");
const Cpu = @import("Cpu.zig");

const Chip = @This();

name: []const u8,
source: FileSource,
cpu: Cpu,
hal: ?FileSource = null,
json_register_schema: ?FileSource = null,
memory_regions: []const MemoryRegion,

pub fn from_standard_paths(comptime root_dir: []const u8, args: struct {
    name: []const u8,
    cpu: Cpu,
    memory_regions: []const MemoryRegion,
}) Chip {
    return Chip{
        .name = args.name,
        .cpu = args.cpu,
        .memory_regions = args.memory_regions,
        .source = .{
            .path = std.fmt.comptimePrint("{s}/chips/{s}.zig", .{
                root_dir,
                args.name,
            }),
        },
        .hal = .{
            .path = std.fmt.comptimePrint("{s}/hals/{s}.zig", .{
                root_dir,
                args.name,
            }),
        },
        .json_register_schema = .{
            .path = std.fmt.comptimePrint("{s}/chips/{s}.json", .{
                root_dir,
                args.name,
            }),
        },
    };
}
