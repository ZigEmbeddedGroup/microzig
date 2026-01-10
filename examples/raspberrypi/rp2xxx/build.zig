const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .rp2xxx = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const raspberrypi = mb.ports.rp2xxx.boards.raspberrypi;

    const specific_examples: []const Example = &.{
        // RaspberryPi Boards:
        .{ .target = raspberrypi.pico, .name = "pico_board_blinky", .file = "src/board_blinky.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_flash-program", .file = "src/rp2040_only/flash_program.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_flash-id", .file = "src/rp2040_only/flash_id.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_random", .file = "src/rp2040_only/random.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_rtc", .file = "src/rp2040_only/rtc.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_multicore", .file = "src/blinky_core1.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_hd44780", .file = "src/rp2040_only/hd44780.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_pcf8574", .file = "src/rp2040_only/pcf8574.zig" },
        .{ .target = raspberrypi.pico, .name = "pico_i2c_slave", .file = "src/rp2040_only/i2c_slave.zig" },

        .{ .target = raspberrypi.pico2_arm, .name = "pico2_arm_multicore", .file = "src/blinky_core1.zig" },
        .{ .target = raspberrypi.pico2_arm, .name = "pico2_arm_board_blinky", .file = "src/board_blinky.zig" },

        .{ .target = raspberrypi.pico_flashless, .name = "pico_flashless_blinky", .file = "src/blinky.zig" },
        .{ .target = raspberrypi.pico_flashless, .name = "pico_flashless_flash-program", .file = "src/rp2040_only/flash_program.zig" },

        .{ .target = raspberrypi.pico2_arm_flashless, .name = "pico2_arm_flashless_blinky", .file = "src/blinky.zig" },
        .{ .target = raspberrypi.pico2_riscv_flashless, .name = "pico2_riscv_flashless_blinky", .file = "src/blinky.zig" },
        .{ .target = raspberrypi.pico2_arm_flashless, .name = "pico2_arm_flashless_system-timer", .file = "src/system_timer.zig" },
        .{ .target = raspberrypi.pico2_riscv_flashless, .name = "pico2_riscv_flashless_system-timer", .file = "src/system_timer.zig" },

        .{ .target = raspberrypi.pico2_arm, .name = "pico2_arm_random_data", .file = "src/rp2350_only/random_data.zig" },
        .{ .target = raspberrypi.pico2_riscv, .name = "pico2_riscv_random_data", .file = "src/rp2350_only/random_data.zig" },

        .{ .target = raspberrypi.pico2_arm, .name = "pico2_arm_always_on_timer", .file = "src/rp2350_only/always_on_timer.zig" },
        .{ .target = raspberrypi.pico2_riscv, .name = "pico2_riscv_always_on_timer", .file = "src/rp2350_only/always_on_timer.zig" },

        // Adafruit boards
        .{ .target = mb.ports.rp2xxx.boards.adafruit.feather_rp2350, .name = "adafruit_feather_rp2350_blinky", .file = "src/board_blinky.zig" },
        .{ .target = mb.ports.rp2xxx.boards.adafruit.metro_rp2350, .name = "adafruit_metro_rp2350_blinky", .file = "src/board_blinky.zig" },

        // WaveShare Boards:
        .{ .target = mb.ports.rp2xxx.boards.waveshare.rp2040_matrix, .name = "rp2040_matrix_tiles", .file = "src/rp2040_only/tiles.zig" },
        // .{ .target = "board:waveshare/rp2040_eth", .name = "rp2040-eth" },
        // .{ .target = "board:waveshare/rp2040_plus_4m", .name = "rp2040-plus-4m" },
        // .{ .target = "board:waveshare/rp2040_plus_16m", .name = "rp2040-plus-16m" },
    };

    const font8x8_dep = b.dependency("font8x8", .{});

    const chip_agnostic_examples: []const ChipAgnosticExample = &.{
        .{ .name = "adc", .file = "src/adc.zig" },
        .{ .name = "i2c-accel", .file = "src/i2c_accel.zig" },
        .{ .name = "i2c-bus-scan", .file = "src/i2c_bus_scan.zig" },
        .{ .name = "i2c-hall-effect", .file = "src/i2c_hall_effect.zig" },
        .{ .name = "pwm", .file = "src/pwm.zig" },
        .{ .name = "uart-echo", .file = "src/uart_echo.zig" },
        .{ .name = "uart-log", .file = "src/uart_log.zig" },
        .{ .name = "rtt-log", .file = "src/rtt_log.zig", .works_with_riscv = false },
        .{ .name = "spi-master", .file = "src/spi_master.zig" },
        .{ .name = "spi-slave", .file = "src/spi_slave.zig" },
        .{ .name = "spi-loopback-dma", .file = "src/spi_loopback_dma.zig" },
        .{ .name = "squarewave", .file = "src/squarewave.zig" },
        .{ .name = "ws2812", .file = "src/ws2812.zig" },
        .{ .name = "blinky", .file = "src/blinky.zig" },
        .{ .name = "ds18b20", .file = "src/ds18b20.zig" },
        .{ .name = "gpio-clock-output", .file = "src/gpio_clock_output.zig" },
        .{ .name = "gpio-interrupts", .file = "src/gpio_irq.zig" },
        .{ .name = "changing-system-clocks", .file = "src/changing_system_clocks.zig" },
        .{ .name = "custom-clock-config", .file = "src/custom_clock_config.zig" },
        .{ .name = "watchdog-timer", .file = "src/watchdog_timer.zig" },
        .{ .name = "system_timer", .file = "src/system_timer.zig" },
        .{ .name = "stepper_driver", .file = "src/stepper_driver.zig" },
        .{ .name = "stepper_driver_dumb", .file = "src/stepper_driver_dumb.zig" },
        .{ .name = "usb-hid", .file = "src/usb_hid.zig" },
        .{ .name = "usb-cdc", .file = "src/usb_cdc.zig" },
        .{ .name = "dma", .file = "src/dma.zig" },
        .{ .name = "cyw43", .file = "src/cyw43.zig" },
        .{ .name = "cyw43-blinky", .file = "src/cyw43/blinky.zig" },
        .{ .name = "cyw43-wifi-scan", .file = "src/cyw43/wifi_scan.zig" },
        .{ .name = "cyw43-wifi-connect", .file = "src/cyw43/wifi_connect.zig" },
        .{ .name = "allocator", .file = "src/allocator.zig" },
        .{ .name = "mlx90640", .file = "src/mlx90640.zig" },
        .{ .name = "ssd1306", .file = "src/ssd1306_oled.zig", .imports = &.{
            .{ .name = "font8x8", .module = font8x8_dep.module("font8x8") },
        } },
        .{ .name = "net-pong", .file = "src/net/pong.zig" },
        .{ .name = "net-udp", .file = "src/net/udp.zig" },
        .{ .name = "net-tcp_client", .file = "src/net/tcp_client.zig" },
        .{ .name = "net-tcp_server", .file = "src/net/tcp_server.zig" },
    };

    var available_examples: std.array_list.Managed(Example) = .init(b.allocator);
    available_examples.appendSlice(specific_examples) catch @panic("out of memory");
    for (chip_agnostic_examples) |example| {
        available_examples.append(.{
            .target = raspberrypi.pico,
            .name = b.fmt("pico_{s}", .{example.name}),
            .file = example.file,
            .imports = example.imports,
        }) catch @panic("out of memory");

        available_examples.append(.{
            .target = raspberrypi.pico2_arm,
            .name = b.fmt("pico2_arm_{s}", .{example.name}),
            .file = example.file,
            .imports = example.imports,
        }) catch @panic("out of memory");

        if (example.works_with_riscv) {
            available_examples.append(.{
                .target = raspberrypi.pico2_riscv,
                .name = b.fmt("pico2_riscv_{s}", .{example.name}),
                .file = example.file,
                .imports = example.imports,
            }) catch @panic("out of memory");
        }
    }

    for (available_examples.items) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        // `add_firmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = mb.add_firmware(.{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
            .imports = example.imports,
        });

        if (std.mem.indexOf(u8, example.name, "_net-") != null) {
            const target = b.resolveTargetQuery(firmware.target.zig_target);
            const foundation_dep = b.dependency("foundationlibc", .{
                .target = target,
                .optimize = optimize,
            });
            const lwip_dep = b.dependency("lwip", .{
                .target = target,
                .optimize = optimize,
            });
            const lwip_mod = lwip_dep.module("lwip");
            // link libc
            lwip_mod.linkLibrary(foundation_dep.artifact("foundation"));
            // add path to the configuration, lwipopts.h
            lwip_mod.addIncludePath(b.path("src/net/lwip/include"));
            // add c import paths
            for (lwip_mod.include_dirs.items) |dir| {
                firmware.app_mod.include_dirs.append(b.allocator, dir) catch @panic("out of memory");
            }
            firmware.app_mod.addImport("lwip", lwip_mod);
        }

        // `install_firmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        mb.install_firmware(firmware, .{});

        // For debugging, we also always install the firmware as an ELF file
        mb.install_firmware(firmware, .{ .format = .elf });
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
    imports: []const std.Build.Module.Import = &.{},
};

const ChipAgnosticExample = struct {
    name: []const u8,
    file: []const u8,
    works_with_riscv: bool = true,
    imports: []const std.Build.Module.Import = &.{},
};
