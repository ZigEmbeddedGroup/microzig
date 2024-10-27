const std = @import("std");
const MicroZig = @import("microzig/build");
const rp2xxx = @import("microzig/port/raspberrypi/rp2xxx");

const rp2040_only_examples = [_]Example{
    // RaspberryPi Boards:
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_adc", .file = "src/rp2040_only/adc.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_flash-program", .file = "src/rp2040_only/flash_program.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_flash-id", .file = "src/rp2040_only/flash_id.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_i2c-bus-scan", .file = "src/rp2040_only/i2c_bus_scan.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_pwm", .file = "src/rp2040_only/pwm.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_random", .file = "src/rp2040_only/random.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_spi-host", .file = "src/rp2040_only/spi_host.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_squarewave", .file = "src/rp2040_only/squarewave.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_uart_echo", .file = "src/rp2040_only/uart_echo.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_uart_log", .file = "src/rp2040_only/uart_log.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_usb-hid", .file = "src/rp2040_only/usb_hid.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_usb-cdc", .file = "src/rp2040_only/usb_cdc.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_ws2812", .file = "src/rp2040_only/ws2812.zig" },
    .{ .target = rp2xxx.boards.raspberrypi.pico, .name = "pico_multicore", .file = "src/rp2040_only/blinky_core1.zig" },

    // WaveShare Boards:
    .{ .target = rp2xxx.boards.waveshare.rp2040_matrix, .name = "rp2040-matrix_tiles", .file = "src/rp2040_only/tiles.zig" },
    // .{ .target = "board:waveshare/rp2040_eth", .name = "rp2040-eth" },
    // .{ .target = "board:waveshare/rp2040_plus_4m", .name = "rp2040-plus-4m" },
    // .{ .target = "board:waveshare/rp2040_plus_16m", .name = "rp2040-plus-16m" },
};

const rp2350_only_examples = [_]Example{
    // TODO: No RP2350 feature specific examples to show off yet
};

const chip_agnostic_examples = [_]ChipAgnosticExample{
    .{ .name = "blinky", .file = "src/blinky.zig" },
    .{ .name = "gpio-clock-output", .file = "src/gpio_clock_output.zig" },
    .{ .name = "changing-system-clocks", .file = "src/changing_system_clocks.zig" },
    .{ .name = "custom-clock-config", .file = "src/custom_clock_config.zig" },
};

const available_examples = val: {
    var examples: [rp2040_only_examples.len + rp2350_only_examples.len + chip_agnostic_examples.len * 2]Example = rp2040_only_examples ++
        rp2350_only_examples ++
        [_]Example{undefined} ** (chip_agnostic_examples.len * 2);

    var i: usize = rp2040_only_examples.len + rp2350_only_examples.len;

    for (chip_agnostic_examples) |ex| {
        examples[i] = .{
            .target = rp2xxx.boards.raspberrypi.pico,
            .name = "pico_" ++ ex.name,
            .file = ex.file,
        };
        i += 1;
        examples[i] = .{
            .target = rp2xxx.boards.raspberrypi.pico2,
            .name = "pico2_" ++ ex.name,
            .file = ex.file,
        };
        i += 1;
    }

    break :val examples;
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

const ChipAgnosticExample = struct {
    name: []const u8,
    file: []const u8,
};
