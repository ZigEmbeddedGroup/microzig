const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b;
    //  Dummy func to make package manager happy
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}

const build_root = root();

pub const chips = struct {
    pub const atsamd51j19 = .{
        .name = "ATSAMD51J19A",
        .url = "https://www.microchip.com/en-us/product/ATSAMD51J19A",
        .cpu = .cortex_m4,
        .register_definition = .{
            .atdf = .{ .path = build_root ++ "/src/chips/ATSAMD51J19A.atdf" },
        },
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x00004000, .length = 512 * 1024 }, // Embedded Flash
            .{ .kind = .ram, .offset = 0x20000000, .length = 192 * 1024 }, // Embedded SRAM
            .{ .kind = .ram, .offset = 0x47000000, .length = 8 * 1024 }, // Backup SRAM
            .{ .kind = .flash, .offset = 0x00804000, .length = 512 }, // NVM User Row
        },
    };
};
