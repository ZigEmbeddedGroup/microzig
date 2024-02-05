const std = @import("std");
const MicroZig = @import("microzig-build");

const available_examples = [_]Example{
    // RaspberryPi Boards:
    .{ .target = "board:raspberry_pi/pico", .name = "pico_adc", .file = "src/adc.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_blinky", .file = "src/blinky.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_flash-program", .file = "src/flash_program.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_gpio-clk", .file = "src/gpio_clk.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_i2c-bus-scan", .file = "src/i2c_bus_scan.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_pwm", .file = "src/pwm.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_random", .file = "src/random.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_spi-master", .file = "src/spi_master.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_squarewave", .file = "src/squarewave.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_uart", .file = "src/uart.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_usb-device", .file = "src/usb_device.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_usb-hid", .file = "src/usb_hid.zig" },
    .{ .target = "board:raspberry_pi/pico", .name = "pico_ws2812", .file = "src/ws2812.zig" },
    // TODO: Fix multicore hal! .{ .target = "board:raspberry_pi/pico", .name = "pico_multicore" , .file = "src/blinky_core1.zig" },

    // WaveShare Boards:
    .{ .target = "board:waveshare/rp2040_matrix", .name = "rp2040-matrix_tiles", .file = "src/tiles.zig" },
    // .{ .target = "board:waveshare/rp2040_eth", .name = "rp2040-eth" },
    // .{ .target = "board:waveshare/rp2040_plus_4m", .name = "rp2040-plus-4m" },
    // .{ .target = "board:waveshare/rp2040_plus_16m", .name = "rp2040-plus-16m" },
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

const Example = struct {
    target: []const u8,
    name: []const u8,
    file: []const u8,
};
