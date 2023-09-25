const std = @import("std");
const stm32 = @import("stm32");

const available_examples = [_]Example{
    // TODO: .{ .name = "stm32f103x8", .target = stm32.chips.stm32f103x8, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f303vc", .target = stm32.chips.stm32f303vc, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f407vg", .target = stm32.chips.stm32f407vg, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f429zit6u", .target = stm32.chips.stm32f429zit6u, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f3discovery", .target = stm32.boards.stm32f3discovery, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f4discovery", .target = stm32.boards.stm32f4discovery, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm3240geval", .target = stm32.boards.stm3240geval, .file = "src/blinky.zig" },
    // TODO: .{ .name = "stm32f429idiscovery", .target = stm32.boards.stm32f429idiscovery, .file = "src/blinky.zig" },
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
