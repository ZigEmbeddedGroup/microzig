const std = @import("std");
const MicroZig = @import("microzig/build");

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}

const build_root = root();

pub const chips = struct {
    pub const atsamd51j19 = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "ATSAMD51J19A",
            .url = "https://www.microchip.com/en-us/product/ATSAMD51J19A",
            .cpu = MicroZig.cpus.cortex_m4f,
            .register_definition = .{
                .atdf = .{ .cwd_relative = build_root ++ "/src/chips/ATSAMD51J19A.atdf" },
            },
            .memory_regions = &.{
                .{ .kind = .flash, .offset = 0x00000000, .length = 512 * 1024 }, // Embedded Flash
                .{ .kind = .ram, .offset = 0x20000000, .length = 192 * 1024 }, // Embedded SRAM
                .{ .kind = .ram, .offset = 0x47000000, .length = 8 * 1024 }, // Backup SRAM
                .{ .kind = .flash, .offset = 0x00804000, .length = 512 }, // NVM User Row
            },
        },
    };
};

pub const boards = struct {
    // empty right now
};
