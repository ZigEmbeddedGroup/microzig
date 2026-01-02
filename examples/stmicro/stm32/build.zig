const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .stm32 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;
    const stm32 = mb.ports.stm32;

    const available_examples = [_]Example{
        .{ .target = stm32.boards.stm32f3discovery, .name = "stm32f3discovery", .file = "src/blinky.zig" },
        // TODO: stm32.pins.GlobalConfiguration is not available on those targets
        // .{ .target = stm32.chips.stm32f407vg, .name = "stm32f407vg", .file = "src/blinky.zig" },
        // .{ .target = stm32.chips.stm32f429zit6u, .name = "stm32f429zit6u", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm32f4discovery, .name = "stm32f4discovery", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm3240geval, .name = "stm3240geval", .file = "src/blinky.zig" },
        // .{ .target = stm32.boards.stm32f429idiscovery, .name = "stm32f429idiscovery", .file = "src/blinky.zig" },
        .{ .target = stm32.boards.stm32f3discovery, .name = "STM32F303_HTS221", .file = "src/hts221.zig" },
        .{ .target = stm32.boards.stm32l476discovery, .name = "STM32L476Discovery_Lcd", .file = "src/stm32l476/lcd.zig" },
        .{ .target = stm32.boards.stm32l476discovery, .name = "STM32L476Discovery_Blinky", .file = "src/blinky.zig" },
        .{ .target = stm32.boards.stm32l476discovery, .name = "STM32L476Discovery_HTS221", .file = "src/hts221.zig" },

        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_blink", .file = "src/blinky.zig" },
        .{ .target = stm32.chips.STM32F100RB, .name = "STM32F1xx_semihost", .file = "src/semihosting.zig" }, //QEMU target: stm32vldiscovery
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_adc", .file = "src/stm32f1xx/adc.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_adv_adc", .file = "src/stm32f1xx/advanced_adc.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_dual_adc", .file = "src/stm32f1xx/adc_dualmode.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_gpio", .file = "src/stm32f1xx/gpio.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_uart_echo", .file = "src/stm32f1xx/uart_echo.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_uart_log", .file = "src/stm32f1xx/uart_log.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_i2c", .file = "src/stm32f1xx/i2c.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_i2c_bus_scan", .file = "src/stm32f1xx/i2c_bus_scan.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_hd44780", .file = "src/stm32f1xx/hd44780.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_ssd1306", .file = "src/stm32f1xx/ssd1306.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_spi", .file = "src/stm32f1xx/spi.zig" },
        .{ .target = stm32.chips.STM32F103C8, .name = "STM32F1xx_usb_hid", .file = "src/stm32f1xx/usb_hid.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_usb_cdc", .file = "src/stm32f1xx/usb_cdc.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_rcc", .file = "src/stm32f1xx/rcc.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_timer", .file = "src/stm32f1xx/timer.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_timer_capture", .file = "src/stm32f1xx/timer_capture.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_rtc", .file = "src/stm32f1xx/rtc.zig" },
        .{ .target = stm32.chips.STM32F103CB, .name = "STM32F1xx_EXTI", .file = "src/stm32f1xx/EXTI.zig" },
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
        mb.install_firmware(fw, .{});

        // For debugging, we also always install the firmware as an ELF file
        mb.install_firmware(fw, .{ .format = .elf });
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
};
