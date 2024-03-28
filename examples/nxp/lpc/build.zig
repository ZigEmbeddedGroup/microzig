const std = @import("std");
const MicroZig = @import("microzig/build");
const lpc = @import("microzig/bsp/nxp/lpc");

const available_examples = [_]ExampleDesc{
    .{ .target = lpc.boards.mbed.lpc1768, .name = "mbed-lpc1768_blinky", .file = "src/blinky.zig" },
};

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    for (available_examples) |example| {
        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = microzig.add_firmware(b, .{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = .{ .path = example.file },
        });

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        microzig.install_firmware(b, firmware, .{});

        // For debugging, we also always install the firmware as an ELF file
        microzig.install_firmware(b, firmware, .{ .format = .elf });
    }
}

const ExampleDesc = struct {
    target: MicroZig.Target,
    name: []const u8,
    file: []const u8,
};
