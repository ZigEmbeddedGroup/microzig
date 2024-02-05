const std = @import("std");
const MicroZig = @import("microzig-build");

const available_examples = [_]ExampleDesc{
    .{ .target = "board:mbed/lpc1768", .name = "mbed-lpc1768_blinky", .file = "src/blinky.zig" },
};

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.createBuildEnvironment(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    const show_targets_step = b.step("show-targets", "Shows all available MicroZig targets");
    show_targets_step.dependOn(microzig.getShowTargetsStep());

    for (available_examples) |example| {
        const target = microzig.findTarget(example.target).?;

        // `addFirmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = microzig.addFirmware(b, .{
            .name = example.name,
            .target = target,
            .optimize = optimize,
            .source_file = .{ .path = example.file },
        });

        // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        microzig.installFirmware(b, firmware, .{});

        // For debugging, we also always install the firmware as an ELF file
        microzig.installFirmware(b, firmware, .{ .format = .elf });
    }
}

const ExampleDesc = struct {
    target: []const u8,
    name: []const u8,
    file: []const u8,
};
