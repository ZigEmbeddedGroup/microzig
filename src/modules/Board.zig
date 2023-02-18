const std = @import("std");
const Chip = @import("Chip.zig");

name: []const u8,
source: std.build.FileSource,
chip: Chip,
