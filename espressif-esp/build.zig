const std = @import("std");
const esp = @import("esp");

const available_targets = [_]TargetDesc{
    .{ .name = "esp32-c3", .target = esp.chips.esp32_c3 },
};

const available_examples = [_][]const u8{
    "src/blinky.zig",
};

pub fn build(b: *std.Build) void {
    const microzig = @import("microzig").init(b, "microzig");
    const optimize = b.standardOptimizeOption(.{});

    for (available_targets) |target| {
        for (available_examples) |example| {
            // `addFirmware` basically works like addExecutable, but takes a
            // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
            //
            // The target will convey all necessary information on the chip,
            // cpu and potentially the board as well.
            const firmware = microzig.addFirmware(b, .{
                .name = b.fmt("{s}-{s}", .{ std.fs.path.stem(example), target.name }),
                .target = target.target,
                .optimize = optimize,
                .source_file = .{ .path = example },
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
}

const TargetDesc = struct {
    target: @import("microzig").Target,
    name: []const u8,
};
