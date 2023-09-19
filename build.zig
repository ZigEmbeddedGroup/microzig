const std = @import("std");
const microzig = @import("microzig");
const rp2040 = @import("rp2040");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const firmware = microzig.addFirmware(b, .{
        .name = "blinky",
        .target = rp2040.chips.rp2040,
        .optimize = optimize,
        .source_file = .{ .path = "src/blinky.zig" },
    });

    microzig.installFirmware(firmware, .{
        
        .format = .uf2, // .dfu, .bin, .hex, .elf, …
    });
}
