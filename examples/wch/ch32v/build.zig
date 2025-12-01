const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .ch32v = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const available_examples = [_]Example{
        // CH32V003
        .{ .target = mb.ports.ch32v.chips.ch32v003x4, .name = "empty_ch32v003", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v003x4, .name = "blinky_ch32v003", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v003x4, .name = "blinky_systick_ch32v003", .file = "src/blinky_systick.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v003.ch32v003f4p6_r0_1v1, .name = "ch32v003f4p6_r0_1v1_empty", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v003.ch32v003f4p6_r0_1v1, .name = "ch32v003f4p6_r0_1v1_blinky", .file = "src/blinky.zig" },

        // CH32V103
        .{ .target = mb.ports.ch32v.chips.ch32v103x6, .name = "empty_ch32v103", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v103x6, .name = "blinky_ch32v103", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v103.ch32v103r_r1_1v1, .name = "ch32v103r_r1_1v1_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v103.ch32v103r_r1_1v1, .name = "ch32v103r_r1_1v1_empty", .file = "src/empty.zig" },

        // CH32V203
        .{ .target = mb.ports.ch32v.chips.ch32v203x6, .name = "empty_ch32v203", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v203x6, .name = "blinky_ch32v203", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v203x6, .name = "blinky_systick_ch32v203", .file = "src/blinky_systick.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.suzuduino_uno_v1b, .name = "suzuduino_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_ws2812", .file = "src/ws2812.zig" },

        // CH32V30x
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "empty_ch32v303", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "blinky_ch32v303", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "blinky_systick_ch32v303", .file = "src/blinky_systick.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v305.nano_ch32v305, .name = "nano_ch32v305_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v307.ch32v307v_r1_1v0, .name = "ch32v307v_r1_1v0_blinky", .file = "src/blinky.zig" },
    };

    for (available_examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

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
