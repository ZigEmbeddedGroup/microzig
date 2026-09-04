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

    const examples: []const Example = &.{
        .{ .name = "blinky", .file = "src/blinky.zig", .chips = &.{ .esp32_c3, .esp32_c6 } },
        .{ .name = "custom_clock_config", .file = "src/custom_clock_config.zig", .chips = &.{ .esp32_c3, .esp32_c6 } },
        .{ .name = "gpio_input", .file = "src/gpio_input.zig", .chips = &.{ .esp32_c3, .esp32_c6 } },
        .{ .name = "i2c_bus_scan", .file = "src/i2c_bus_scan.zig" },
        .{ .name = "i2c_temp", .file = "src/i2c_temp.zig" },
        .{ .name = "i2c_display_sh1106", .file = "src/i2c_display_sh1106.zig" },
        .{ .name = "ledc_pwm_servo", .file = "src/ledc_pwm_servo.zig" },
        .{ .name = "stepper_driver", .file = "src/stepper_driver.zig" },
        .{ .name = "stepper_driver_dumb", .file = "src/stepper_driver_dumb.zig" },
        .{ .name = "systimer", .file = "src/systimer.zig", .chips = &.{ .esp32_c3, .esp32_c6 } },
        .{ .name = "ws2812_blinky", .file = "src/ws2812_blinky.zig" },
        .{ .name = "rtos", .file = "src/rtos.zig" },
        .{ .name = "tcp_server", .file = "src/tcp_server.zig", .features = .{
            .flashless = false,
            .lwip = true,
        } },
    };

    const board_examples: []const BoardExample = &.{
        .{
            .name = "board_blinky",
            .file = "src/xiao_esp32_c6_blinky.zig",
            .prefix = "xiao_esp32_c6",
            .target = mb.ports.esp.boards.seeedstudio.xiao_esp32_c6,
        },
    };

    for (examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        for (std.enums.values(TargetEnum)) |target_enum| {
            if (!example.features.flashless and std.mem.containsAtLeast(u8, @tagName(target_enum), 1, "flashless"))
                continue;

            if (std.mem.indexOfScalar(Chip, example.chips, target_enum.chip()) == null)
                continue;

            const target_desc = target_enum.get_target_desc(mb);

            // `add_firmware` basically works like addExecutable, but takes a
            // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
            //
            // The target will convey all necessary information on the chip,
            // cpu and potentially the board as well.
            const fw = mb.add_firmware(.{
                .name = b.fmt("{s}_{s}", .{ target_desc.prefix, example.name }),
                .target = target_desc.target,
                .optimize = optimize,
                .root_source_file = b.path(example.file),
            });

            if (example.features.lwip) {
                const target = b.resolveTargetQuery(fw.target.zig_target);

                const foundation_dep = b.dependency("foundation_libc", .{
                    .target = target,
                    .optimize = optimize,
                    .single_threaded = true,
                });

                const lwip_dep = b.dependency("lwip", .{
                    .target = target,
                    .optimize = optimize,
                    .include_dir = b.path("src/lwip/include"),
                });

                const libc_lib = foundation_dep.artifact("foundation");
                const lwip = lwip_dep.module("lwip");

                lwip.linkLibrary(libc_lib);
                fw.exe.root_module.addImport("lwip", lwip);
            }

            // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
            // and allows installing the firmware as a typical firmware file.
            //
            // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
            mb.install_firmware(fw, .{});

            // For debugging, we also always install the firmware as an ELF file
            mb.install_firmware(fw, .{ .format = .elf });
        }
    }

    for (board_examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        const fw = mb.add_firmware(.{
            .name = b.fmt("{s}_{s}", .{ example.prefix, example.name }),
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        mb.install_firmware(fw, .{});
        mb.install_firmware(fw, .{ .format = .elf });
    }
}

/// An example written against one specific board instead of a bare chip.
const BoardExample = struct {
    name: []const u8,
    file: []const u8,
    /// Prefixed to the installed firmware name.
    prefix: []const u8,
    target: *const microzig.Target,
};

const TargetEnum = enum {
    esp32_c3,
    esp32_c3_direct_boot,
    esp32_c3_flashless,
    esp32_c6,
    esp32_c6_direct_boot,
    esp32_c6_flashless,

    fn get_target_desc(target_enum: TargetEnum, mb: *MicroBuild) TargetDescription {
        return switch (target_enum) {
            .esp32_c3 => .{
                .prefix = "esp32_c3",
                .target = mb.ports.esp.chips.esp32_c3,
            },
            .esp32_c3_direct_boot => .{
                .prefix = "esp32_c3_direct_boot",
                .target = mb.ports.esp.chips.esp32_c3_direct_boot,
            },
            .esp32_c3_flashless => .{
                .prefix = "esp32_c3_flashless",
                .target = mb.ports.esp.chips.esp32_c3_flashless,
            },
            .esp32_c6 => .{
                .prefix = "esp32_c6",
                .target = mb.ports.esp.chips.esp32_c6,
            },
            .esp32_c6_direct_boot => .{
                .prefix = "esp32_c6_direct_boot",
                .target = mb.ports.esp.chips.esp32_c6_direct_boot,
            },
            .esp32_c6_flashless => .{
                .prefix = "esp32_c6_flashless",
                .target = mb.ports.esp.chips.esp32_c6_flashless,
            },
        };
    }

    fn chip(target_enum: TargetEnum) Chip {
        return switch (target_enum) {
            .esp32_c3, .esp32_c3_direct_boot, .esp32_c3_flashless => .esp32_c3,
            .esp32_c6, .esp32_c6_direct_boot, .esp32_c6_flashless => .esp32_c6,
        };
    }
};

const Chip = enum {
    esp32_c3,
    esp32_c6,
};

const TargetDescription = struct {
    prefix: []const u8,
    target: *const microzig.Target,
};

const Example = struct {
    const Features = packed struct {
        flashless: bool = true,
        lwip: bool = false,
    };

    name: []const u8,
    file: []const u8,
    features: Features = .{},
    /// Chips this example builds for. Most of the hal is not ported to the esp32c6 yet.
    chips: []const Chip = &.{.esp32_c3},
};
