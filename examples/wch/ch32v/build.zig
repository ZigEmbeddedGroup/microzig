const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .ch32v = true,
});

pub fn build(b: *std.Build) void { // $ls root_id 30
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    // Use GNU objcopy instead of LLVM objcopy to avoid 512MB binary issue.
    // LLVM objcopy includes LOAD segments for NOLOAD sections, causing the binary
    // to span from flash (0x0) to RAM (0x20000000) = 512MB of zeros.
    const gnu_objcopy = b.findProgram(&.{"riscv64-unknown-elf-objcopy"}, &.{}) catch null;

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
        .{ .target = mb.ports.ch32v.boards.ch32v203.nano_ch32v203, .name = "nano_ch32v203_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.nano_ch32v203, .name = "nano_ch32v203_usb_cdc", .file = "src/usb_cdc.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.suzuduino_uno_v1b, .name = "suzuduino_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.suzuduino_uno_v1b, .name = "suzuduino_usb_cdc", .file = "src/usb_cdc.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_dma", .file = "src/dma.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_ws2812", .file = "src/ws2812.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_uart_log", .file = "src/uart_log.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_i2c_bus_scan", .file = "src/i2c_bus_scan.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_i2c_eeprom", .file = "src/i2c_eeprom.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_i2c_position_sensor", .file = "src/i2c_position_sensor.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_spi_loopback", .file = "src/spi_loopback.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_spi_flash_w25q", .file = "src/spi_flash_w25q.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_sharp_niceview", .file = "src/sharp_niceview.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v203.lana_tny, .name = "lana_tny_usb_cdc", .file = "src/usb_cdc.zig" },

        // CH32V30x
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "empty_ch32v303", .file = "src/empty.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "blinky_ch32v303", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.chips.ch32v303xb, .name = "blinky_systick_ch32v303", .file = "src/blinky_systick.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v305.nano_ch32v305, .name = "nano_ch32v305_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v307.ch32v307v_r1_1v0, .name = "ch32v307v_r1_1v0_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.ch32v.boards.ch32v307.ch32v307v_r1_1v0, .name = "ch32v307v_r1_1v0_usb_cdc", .file = "src/usb_cdc.zig" },
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
        mb.install_firmware(fw, .{ .format = .elf });

        // Use GNU objcopy to create .bin files (avoids LLVM objcopy 512MB issue)
        if (gnu_objcopy) |objcopy_path| {
            const bin_filename = b.fmt("{s}.bin", .{example.name});
            const objcopy_run = b.addSystemCommand(&.{objcopy_path});
            objcopy_run.addArgs(&.{ "-O", "binary" });
            objcopy_run.addArtifactArg(fw.artifact);
            const bin_output = objcopy_run.addOutputFileArg(bin_filename);
            b.getInstallStep().dependOn(&b.addInstallFileWithDir(
                bin_output,
                .{ .custom = "firmware" },
                bin_filename,
            ).step);
        }
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
};
