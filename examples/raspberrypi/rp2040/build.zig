const std = @import("std");
const MicroZig = @import("microzig/build");
const rp2040 = @import("microzig/bsp/raspberrypi/rp2040");

const available_examples = [_]Example{
    // RaspberryPi Boards:
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_adc", .file = "src/adc.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_blinky", .file = "src/blinky.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_flash-program", .file = "src/flash_program.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_flash-id", .file = "src/flash_id.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_gpio-clk", .file = "src/gpio_clk.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_i2c-bus-scan", .file = "src/i2c_bus_scan.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_pwm", .file = "src/pwm.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_random", .file = "src/random.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_spi-host", .file = "src/spi_host.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_squarewave", .file = "src/squarewave.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_uart", .file = "src/uart.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_usb-hid", .file = "src/usb_hid.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_usb-cdc", .file = "src/usb_cdc.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_ws2812", .file = "src/ws2812.zig" },
    .{ .target = rp2040.boards.raspberrypi.pico, .name = "pico_multicore", .file = "src/blinky_core1.zig" },

    // WaveShare Boards:
    .{ .target = rp2040.boards.waveshare.rp2040_matrix, .name = "rp2040-matrix_tiles", .file = "src/tiles.zig" },
    // .{ .target = "board:waveshare/rp2040_eth", .name = "rp2040-eth" },
    // .{ .target = "board:waveshare/rp2040_plus_4m", .name = "rp2040-plus-4m" },
    // .{ .target = "board:waveshare/rp2040_plus_16m", .name = "rp2040-plus-16m" },
};

pub fn build(b: *std.Build) void {
    const mz = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    for (available_examples) |example| {

        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = mz.add_firmware(b, .{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        mz.install_firmware(b, firmware, .{});

        // For debugging, we also always install the firmware as an ELF file
        mz.install_firmware(b, firmware, .{ .format = .elf });
    }
}

const Example = struct {
    target: MicroZig.Target,
    name: []const u8,
    file: []const u8,
};
