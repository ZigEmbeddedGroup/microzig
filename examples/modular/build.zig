const std = @import("std");
const microzig_build = @import("microzig-build");
const lpc = @import("lpc");

pub fn build(b: *std.Build) void {
    const microbuild = microzig_build.init(
        b,
        b.dependency("microzig", .{}),
    );

    const optimize = b.standardOptimizeOption(.{});

    // `addFirmware` basically works like addExecutable, but takes a
    // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
    //
    // The target will convey all necessary information on the chip,
    // cpu and potentially the board as well.
    const firmware = microbuild.addFirmware(b, .{
        .name = "blinky",
        .target = lpc.boards.mbed.lpc1768,
        .optimize = optimize,
        .source_file = .{ .path = "src/blinky.zig" },
    });

    // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
    // and allows installing the firmware as a typical firmware file.
    //
    // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
    microbuild.installFirmware(b, firmware, .{});

    // For debugging, we also always install the firmware as an ELF file
    microbuild.installFirmware(b, firmware, .{ .format = .elf });
}
