const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .stm32 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep);

    const available_examples = [_]Example{
        .{ .target = mb.ports.stm32.chips.STM32F103C8, .name = "STM32F103C8", .file = "src/blinky.zig" },
        // TODO: stm32.pins.GlobalConfiguration is not available on those targets
        // .{ .target = stm32.chips.stm32f303vc, .name = "stm32f303vc", .file = "src/blinky.zig" },
        // .{ .target = stm32.chips.stm32f407vg, .name = "stm32f407vg", .file = "src/blinky.zig" },
        // .{ .target = stm32.chips.stm32f429zit6u, .name = "stm32f429zit6u", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm32f3discovery, .name = "stm32f3discovery", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm32f4discovery, .name = "stm32f4discovery", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm3240geval, .name = "stm3240geval", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm32f429idiscovery, .name = "stm32f429idiscovery", .file = "src/blinky.zig" },
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
        mb.install_firmware(fw, .{});

        // For debugging, we also always install the firmware as an ELF file
        mb.install_firmware(fw, .{ .format = .elf });
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
};
