const std = @import("std");
const MicroZig = @import("microzig/build");

fn path(comptime suffix: []const u8) std.Build.LazyPath {
    return .{
        .cwd_relative = comptime ((std.fs.path.dirname(@src().file) orelse ".") ++ suffix),
    };
}

const hal = .{
    .root_source_file = path("/src/hals/LPC176x5x.zig"),
};

pub const chips = struct {
    pub const lpc176x5x = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            // TODO: Separate over those chips, this is not generic!
            .name = "LPC176x5x",
            .cpu = MicroZig.cpus.cortex_m3,
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 512 * 1024, .kind = .flash },
                .{ .offset = 0x10000000, .length = 32 * 1024, .kind = .ram },
                .{ .offset = 0x2007C000, .length = 32 * 1024, .kind = .ram },
            },
            .register_definition = .{
                .json = path("/src/chips/LPC176x5x.json"),
            },
        },
        .hal = hal,
        .binary_post_process = postprocess,
    };
};

pub const boards = struct {
    pub const mbed = struct {
        pub const lpc1768 = MicroZig.Target{
            .preferred_format = .hex,
            .chip = chips.lpc176x5x.chip,
            .hal = hal,
            .board = .{
                .name = "mbed LPC1768",
                .url = "https://os.mbed.com/platforms/mbed-LPC1768/",
                .root_source_file = path("/src/boards/mbed_LPC1768.zig"),
            },
            .binary_post_process = postprocess,
        };
    };
};

/// Post-processes an ELF file to add a checksum over the first 8 words so the
/// cpu will properly boot.
fn postprocess(b: *std.Build, input: std.Build.LazyPath) std.Build.LazyPath {
    const patchelf = b.addExecutable(.{
        .name = "lpc176x5x-patchelf",
        .root_source_file = path("/src/tools/patchelf.zig"),
        .target = b.host,
    });

    const patch = b.addRunArtifact(patchelf);
    patch.addFileArg(input);
    return patch.addOutputFileArg("firmware.elf");
}

pub fn build(b: *std.Build) void {
    _ = b.step("test", "Run platform agnostic unit tests");
}
