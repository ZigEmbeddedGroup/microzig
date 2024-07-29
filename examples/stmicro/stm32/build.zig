const std = @import("std");
const MicroZig = @import("microzig/build");
const stm32 = @import("microzig/bsp/stmicro/stm32");

const available_examples = [_]Example{
    .{ .target = stm32.chips.stm32f103x8, .name = "stm32f103x8", .file = "src/blinky.zig" },
    // TODO: stm32.pins.GlobalConfiguration is not available on those targets
    // .{ .target = stm32.chips.stm32f303vc, .name = "stm32f303vc", .file = "src/blinky.zig" },
    // .{ .target = stm32.chips.stm32f407vg, .name = "stm32f407vg", .file = "src/blinky.zig" },
    // .{ .target = stm32.chips.stm32f429zit6u, .name = "stm32f429zit6u", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm32f3discovery, .name = "stm32f3discovery", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm32f4discovery, .name = "stm32f4discovery", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm3240geval, .name = "stm3240geval", .file = "src/blinky.zig" },
    // .{ .target = stm32.boards.stm32f429idiscovery, .name = "stm32f429idiscovery", .file = "src/blinky.zig" },
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
            .root_source_file = b.path(example.file),
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

const Example = struct {
    target: MicroZig.Target,
    name: []const u8,
    file: []const u8,
};
