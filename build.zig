const std = @import("std");
const microzig = @import("microzig");
const rp2040 = @import("rp2040");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // `addFirmware` basically works like addExecutable, but takes a
    // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
    //
    // The target will convey all necessary information on the chip,
    // cpu and potentially the board as well.
    const firmware = microzig.addFirmware(b, .{
        .name = "blinky",
        .target = rp2040.boards.raspberrypi.pico,
        .optimize = optimize,
        .source_file = .{ .path = "src/blinky.zig" },
    });

    // Pendant to `getEmittedBin()`: Always returns the path to the output elf file
    _ = firmware.getEmittedElf();

    // Extension of `getEmittedElf()` that will also convert the file to the given
    // binary format.
    _ = firmware.getEmittedBin(.uf2);

    // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
    // and allows installing the firmware as a typical firmware file.
    //
    // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
    microzig.installFirmware(firmware, .{
        .format = .uf2, // .dfu, .bin, .hex, .elf, …
    });
}
