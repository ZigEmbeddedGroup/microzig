const std = @import("std");
const gd32 = @import("gd32");

const available_examples = [_]Example{
    // .{ .name = "gd32vf103xb", .target = gd32.chips.gd32vf103xb, .file = "src/blinky.zig" },
    // .{ .name = "gd32vf103x8", .target = gd32.chips.gd32vf103x8, .file = "src/blinky.zig" },
    // .{ .name = "sipeed-longan_nano", .target = gd32.boards.sipeed.longan_nano, .file = "src/blinky.zig" },
};

pub fn build(b: *std.Build) void {
    const microzig = @import("microzig").init(b, "microzig");
    const optimize = .ReleaseSmall; // The others are not really an option on AVR

    for (available_examples) |example| {
        // `addFirmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = microzig.addFirmware(b, .{
            .name = example.name,
            .target = example.target,
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

const Example = struct {
    target: @import("microzig").Target,
    name: []const u8,
    file: []const u8,
};
