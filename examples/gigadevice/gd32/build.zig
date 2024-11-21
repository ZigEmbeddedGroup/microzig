const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .gd32 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep);

    const available_examples = [_]Example{
        .{ .target = mb.ports.gd32.chips.gd32vf103xb, .name = "gd32vf103xb", .file = "src/empty.zig" },
        .{ .target = mb.ports.gd32.chips.gd32vf103x8, .name = "gd32vf103x8", .file = "src/empty.zig" },
        .{ .target = mb.ports.gd32.boards.sipeed.longan_nano, .name = "sipeed-longan_nano", .file = "src/empty.zig" },
        .{ .target = mb.ports.gd32.boards.sipeed.longan_nano, .name = "sipeed-longan_nano_blinky", .file = "src/blinky.zig" },
    };

    for (available_examples) |example| {
        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const fw = mb.add_firmware(.{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        mb.install_firmware(fw, .{ .format = .bin });

        // For debugging, we also always install the firmware as an ELF file
        mb.install_firmware(fw, .{});
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
};
