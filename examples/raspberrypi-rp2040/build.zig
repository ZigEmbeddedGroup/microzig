const std = @import("std");
const rp2040 = @import("microzig-bsp-rp2040");
const MicroZig = @import("microzig");

const available_examples = [_]Example{
    .{ .name = "pico_adc", .target = "board:raspberry_pi/pico", .file = "src/adc.zig" },
    .{ .name = "pico_blinky", .target = "board:raspberry_pi/pico", .file = "src/blinky.zig" },
    // TODO: Fix multicore hal! .{ .name = "pico", .target = "board:raspberry_pi/pico", .file = "src/blinky_core1.zig" },
    .{ .name = "pico_flash-program", .target = "board:raspberry_pi/pico", .file = "src/flash_program.zig" },
    .{ .name = "pico_gpio-clk", .target = "board:raspberry_pi/pico", .file = "src/gpio_clk.zig" },
    .{ .name = "pico_i2c-bus-scan", .target = "board:raspberry_pi/pico", .file = "src/i2c_bus_scan.zig" },
    .{ .name = "pico_pwm", .target = "board:raspberry_pi/pico", .file = "src/pwm.zig" },
    .{ .name = "pico_random", .target = "board:raspberry_pi/pico", .file = "src/random.zig" },
    .{ .name = "pico_spi-master", .target = "board:raspberry_pi/pico", .file = "src/spi_master.zig" },
    .{ .name = "pico_squarewave", .target = "board:raspberry_pi/pico", .file = "src/squarewave.zig" },
    .{ .name = "pico_uart", .target = "board:raspberry_pi/pico", .file = "src/uart.zig" },
    .{ .name = "pico_usb-device", .target = "board:raspberry_pi/pico", .file = "src/usb_device.zig" },
    .{ .name = "pico_usb-hid", .target = "board:raspberry_pi/pico", .file = "src/usb_hid.zig" },
    .{ .name = "pico_ws2812", .target = "board:raspberry_pi/pico", .file = "src/ws2812.zig" },

    .{ .name = "rp2040-matrix_tiles", .target = "board:waveshare/rp2040_matrix", .file = "src/tiles.zig" },
};

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.createBuildEnvironment(b, .{});

    const optimize = b.standardOptimizeOption(.{});

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
