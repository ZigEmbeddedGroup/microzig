const std = @import("std");

const Builder = std.build.Builder;
const Pkg = std.build.Pkg;
const comptimePrint = std.fmt.comptimePrint;

const chip_path = comptimePrint("{s}/src/rp2040.zig", .{root()});
const board_path = comptimePrint("{s}/src/raspberry_pi_pico.zig", .{root()});
const hal_path = comptimePrint("{s}/src/hal.zig", .{root()});
const linkerscript_path = comptimePrint("{s}/rp2040.ld", .{root()});

pub const BuildOptions = struct {};

pub fn addPiPicoExecutable(
    comptime microzig: type,
    builder: *Builder,
    name: []const u8,
    source: []const u8,
    _: BuildOptions,
) microzig.EmbeddedExecutable {
    const rp2040 = microzig.Chip{
        .name = "RP2040",
        .path = chip_path,
        .cpu = microzig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
            .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
            .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
        },
    };

    const raspberry_pi_pico = microzig.Board{
        .name = "Raspberry Pi Pico",
        .path = board_path,
        .chip = rp2040,
    };

    const ret = microzig.addEmbeddedExecutable(
        builder,
        name,
        source,
        .{ .board = raspberry_pi_pico },
        .{
            .hal_package_path = .{ .path = hal_path },
        },
    );
    ret.inner.setLinkerScriptPath(.{ .path = linkerscript_path });

    return ret;
}

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
