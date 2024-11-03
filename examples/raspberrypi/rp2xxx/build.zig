const std = @import("std");
const Build = std.Build;
const MicroZig = @import("microzig");

pub const microzig_options = .{
    .enable_ports = .{
        .rp2xxx = true,
    },
};

pub fn build(b: *Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mz = MicroZig.init(b, mz_dep);

    const rp2040_only_examples: []const Example = &.{
        // RaspberryPi Boards:
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_adc", .file = "src/rp2040_only/adc.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_flash-program", .file = "src/rp2040_only/flash_program.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_flash-id", .file = "src/rp2040_only/flash_id.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_i2c-bus-scan", .file = "src/rp2040_only/i2c_bus_scan.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_pwm", .file = "src/rp2040_only/pwm.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_random", .file = "src/rp2040_only/random.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_spi-host", .file = "src/rp2040_only/spi_host.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_squarewave", .file = "src/rp2040_only/squarewave.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_uart", .file = "src/rp2040_only/uart.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_usb-hid", .file = "src/rp2040_only/usb_hid.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_usb-cdc", .file = "src/rp2040_only/usb_cdc.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_ws2812", .file = "src/rp2040_only/ws2812.zig" },
        .{ .target = mz.ports.rp2xxx.boards.raspberrypi.pico, .name = "pico_multicore", .file = "src/rp2040_only/blinky_core1.zig" },

        // WaveShare Boards:
        .{ .target = mz.ports.rp2xxx.boards.waveshare.rp2040_matrix, .name = "rp2040-matrix_tiles", .file = "src/rp2040_only/tiles.zig" },
        // .{ .target = "board:waveshare/rp2040_eth", .name = "rp2040-eth" },
        // .{ .target = "board:waveshare/rp2040_plus_4m", .name = "rp2040-plus-4m" },
        // .{ .target = "board:waveshare/rp2040_plus_16m", .name = "rp2040-plus-16m" },
    };

    const rp2350_only_examples: []const Example = &.{
        // TODO: No RP2350 feature specific examples to show off yet
    };

    const chip_agnostic_examples: []const ChipAgnosticExample = &.{
        .{ .name = "blinky", .file = "src/blinky.zig" },
        .{ .name = "gpio-clock-output", .file = "src/gpio_clock_output.zig" },
        .{ .name = "changing-system-clocks", .file = "src/changing_system_clocks.zig" },
        .{ .name = "custom-clock-config", .file = "src/custom_clock_config.zig" },
    };

    var available_examples = std.ArrayList(Example).init(b.allocator);
    available_examples.appendSlice(rp2040_only_examples) catch @panic("out of memory");
    available_examples.appendSlice(rp2350_only_examples) catch @panic("out of memory");
    for (chip_agnostic_examples) |example| {
        available_examples.append(.{
            .target = mz.ports.rp2xxx.boards.raspberrypi.pico,
            .name = b.fmt("pico_{s}", .{example.name}),
            .file = example.file,
        }) catch @panic("out of memory");

        available_examples.append(.{
            .target = mz.ports.rp2xxx.boards.raspberrypi.pico2_arm,
            .name = b.fmt("pico2_{s}", .{example.name}),
            .file = example.file,
        }) catch @panic("out of memory");
    }

    for (available_examples.items) |example| {
        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = mz.add_firmware(.{
            .name = example.name,
            .root_source_file = b.path(example.file),
            .optimize = optimize,
            .target = example.target,
        });

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        mz.install_firmware(firmware, .{});

        // For debugging, we also always install the firmware as an ELF file
        mz.install_firmware(firmware, .{ .format = .elf });
    }
}

const Example = struct {
    target: *MicroZig.Target,
    name: []const u8,
    file: []const u8,
};

const ChipAgnosticExample = struct {
    name: []const u8,
    file: []const u8,
};
