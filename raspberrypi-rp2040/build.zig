const std = @import("std");
const rp2040 = @import("rp2040");

const available_targets = [_]TargetDesc{
    .{ .name = "pico", .target = rp2040.boards.raspberry_pi.pico },
    .{ .name = "rp2040-eth", .target = rp2040.boards.waveshare.rp2040_eth },
    .{ .name = "rp2040-plus-4m", .target = rp2040.boards.waveshare.rp2040_plus_4m },
    .{ .name = "rp2040-plus-16m", .target = rp2040.boards.waveshare.rp2040_plus_16m },
    .{ .name = "rp2040-matrix", .target = rp2040.boards.waveshare.rp2040_matrix },
};

const available_examples = [_][]const u8{
    "src/adc.zig",
    "src/blinky.zig",
    // TODO: Fix multicore hal! "src/blinky_core1.zig",
    "src/flash_program.zig",
    "src/gpio_clk.zig",
    "src/i2c_bus_scan.zig",
    "src/pwm.zig",
    "src/random.zig",
    "src/spi_master.zig",
    "src/squarewave.zig",
    "src/uart.zig",
    "src/usb_device.zig",
    "src/usb_hid.zig",
    "src/ws2812.zig",
};

pub fn build(b: *std.Build) void {
    const microzig = @import("microzig").init(b, "microzig");
    const optimize = b.standardOptimizeOption(.{});

    for (available_targets) |target| {
        for (available_examples) |example| {
            // `addFirmware` basically works like addExecutable, but takes a
            // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
            //
            // The target will convey all necessary information on the chip,
            // cpu and potentially the board as well.
            const firmware = microzig.addFirmware(b, .{
                .name = b.fmt("{s}-{s}", .{ std.fs.path.stem(example), target.name }),
                .target = target.target,
                .optimize = optimize,
                .source_file = .{ .path = example },
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
}

const TargetDesc = struct {
    target: @import("microzig").Target,
    name: []const u8,
};
