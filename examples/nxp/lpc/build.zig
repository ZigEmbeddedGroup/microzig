const std = @import("std");
const Build = std.Build;
const MicroZig = @import("microzig");

pub const microzig_options = .{
    .enable_ports = .{
        .lpc = true,
    },
};

pub fn build(b: *Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mz = MicroZig.init(b, mz_dep);

    const available_examples = [_]Example{
        .{ .target = mz.ports.lpc.boards.mbed.lpc1768, .name = "mbed-lpc1768_blinky", .file = "src/blinky.zig" },
    };

    for (available_examples) |example| {
        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const fw = mz.add_firmware(.{
            .name = example.name,
            .root_source_file = b.path(example.file),
            .optimize = optimize,
            .target = example.target,
        });

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        mz.install_firmware(fw, .{});

        // For debugging, we also always install the firmware as an ELF file
        mz.install_firmware(fw, .{ .format = .elf });
    }
}

const Example = struct {
    target: *MicroZig.Target,
    name: []const u8,
    file: []const u8,
};
