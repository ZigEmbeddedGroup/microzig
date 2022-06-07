const std = @import("std");

const Builder = std.build.Builder;
const Pkg = std.build.Pkg;

pub const BuildOptions = struct {
    packages: ?[]const Pkg = null,
};

pub fn addPiPicoExecutable(
    comptime microzig: type,
    builder: *Builder,
    name: []const u8,
    source: []const u8,
    options: BuildOptions,
) *std.build.LibExeObjStep {
    const rp2040 = microzig.Chip{
        .name = "RP2040",
        .path = root() ++ "src/rp2040.zig",
        .cpu = microzig.cpus.cortex_m0plus,
        .memory_regions = &.{
            .{ .kind = .flash, .offset = 0x10000100, .length = (2048 * 1024) - 256 },
            .{ .kind = .flash, .offset = 0x10000000, .length = 256 },
            .{ .kind = .ram, .offset = 0x20000000, .length = 256 * 1024 },
        },
    };

    const raspberry_pi_pico = microzig.Board{
        .name = "Raspberry Pi Pico",
        .path = root() ++ "src/raspberry_pi_pico.zig",
        .chip = rp2040,
    };

    const ret = microzig.addEmbeddedExecutable(
        builder,
        name,
        source,
        .{ .board = raspberry_pi_pico },
        .{
            .packages = options.packages,
            .hal_package_path = .{ .path = root() ++ "src/hal.zig" },
        },
    ) catch @panic("failed to create embedded executable");
    ret.setLinkerScriptPath(.{ .path = root() ++ "rp2040.ld" });

    return ret;
}

fn root() []const u8 {
    return (std.fs.path.dirname(@src().file) orelse unreachable) ++ "/";
}
