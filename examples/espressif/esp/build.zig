const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .esp = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const targets = [_]TargetDescription{
        .{ .prefix = "esp32_c3", .target = mb.ports.esp.chips.esp32_c3 },
        .{ .prefix = "esp32_c3_direct_boot", .target = mb.ports.esp.chips.esp32_c3_direct_boot },
    };

    const available_examples = [_]Example{
        .{ .name = "blinky", .file = "src/blinky.zig" },
        .{ .name = "custom_clock_config", .file = "src/custom_clock_config.zig" },
        .{ .name = "gpio_input", .file = "src/gpio_input.zig" },
        .{ .name = "i2c_bus_scan", .file = "src/i2c_bus_scan.zig" },
        .{ .name = "i2c_temp", .file = "src/i2c_temp.zig" },
        .{ .name = "i2c_display_sh1106", .file = "src/i2c_display_sh1106.zig" },
        .{ .name = "stepper_driver", .file = "src/stepper_driver.zig" },
        .{ .name = "stepper_driver_dumb", .file = "src/stepper_driver_dumb.zig" },
        .{ .name = "systimer", .file = "src/systimer.zig" },
        .{ .name = "ws2812_blinky", .file = "src/ws2812_blinky.zig" },
    };

    for (available_examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        for (targets) |target_desc| {
            // `add_firmware` basically works like addExecutable, but takes a
            // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
            //
            // The target will convey all necessary information on the chip,
            // cpu and potentially the board as well.
            const firmware = mb.add_firmware(.{
                .name = b.fmt("{s}_{s}", .{ target_desc.prefix, example.name }),
                .target = target_desc.target,
                .optimize = optimize,
                .root_source_file = b.path(example.file),
            });

            // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
            // and allows installing the firmware as a typical firmware file.
            //
            // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
            mb.install_firmware(firmware, .{});

            // For debugging, we also always install the firmware as an ELF file
            mb.install_firmware(firmware, .{ .format = .elf });
        }
    }
}

const TargetDescription = struct {
    prefix: []const u8,
    target: *const microzig.Target,
};

const Example = struct {
    name: []const u8,
    file: []const u8,
};
