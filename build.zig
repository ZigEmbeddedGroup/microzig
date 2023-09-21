const std = @import("std");
const rp2040 = @import("rp2040");
const stm32 = @import("stm32");
const lpc = @import("lpc");
const gd32 = @import("gd32");
const nrf5x = @import("nrf5x");

pub fn build(b: *std.Build) void {
    const microzig = @import("microzig").init(b, "microzig");
    const optimize = b.standardOptimizeOption(.{});

    const TargetDesc = struct {
        target: @import("microzig").Target,
        name: []const u8,
    };

    const available_targets = [_]TargetDesc{
        // RP2040
        .{ .name = "pico", .target = rp2040.boards.raspberry_pi.pico },
        .{ .name = "rp2040-eth", .target = rp2040.boards.waveshare.rp2040_eth },
        .{ .name = "rp2040-plus-4m", .target = rp2040.boards.waveshare.rp2040_plus_4m },
        .{ .name = "rp2040-plus-16m", .target = rp2040.boards.waveshare.rp2040_plus_16m },
        .{ .name = "rp2040-matrix", .target = rp2040.boards.waveshare.rp2040_matrix },

        // STM32
        .{ .name = "stm32f103x8", .target = stm32.chips.stm32f103x8 },
        .{ .name = "stm32f303vc", .target = stm32.chips.stm32f303vc },
        .{ .name = "stm32f407vg", .target = stm32.chips.stm32f407vg },
        .{ .name = "stm32f429zit6u", .target = stm32.chips.stm32f429zit6u },
        .{ .name = "stm32f3discovery", .target = stm32.boards.stm32f3discovery },
        .{ .name = "stm32f4discovery", .target = stm32.boards.stm32f4discovery },
        .{ .name = "stm3240geval", .target = stm32.boards.stm3240geval },
        .{ .name = "stm32f429idiscovery", .target = stm32.boards.stm32f429idiscovery },

        // NXP LPC
        // TODO: Add checksum postprocessing
        .{ .name = "lpc176x5x", .target = lpc.chips.lpc176x5x },
        .{ .name = "mbed-lpc1768", .target = lpc.boards.mbed.lpc1768 },

        // GigaDevice GD32
        .{ .name = "gd32vf103xb", .target = gd32.chips.gd32vf103xb },
        .{ .name = "gd32vf103x8", .target = gd32.chips.gd32vf103x8 },
        .{ .name = "sipeed-longan_nano", .target = gd32.boards.sipeed.longan_nano },

        // Nordic Nrf5x
        .{ .name = "nrf52832", .target = nrf5x.chips.nrf52832 },
        .{ .name = "nrf52840", .target = nrf5x.chips.nrf52840 },
        .{ .name = "nrf52840-dongle", .target = nrf5x.boards.nordic.nRF52840_Dongle }, // TODO: Add support for DFU files!

        // Espressif ESP
        // .{ .name = "nrf52832", .target = nrf5x.chips.nrf52832 },
        // TODO: Add support for Espressif Update Binaries

        // Microchip ATmega
        // TODO: Fix compiler bugs
    };

    for (available_targets) |dest| {
        // `addFirmware` basically works like addExecutable, but takes a
        // `microzig.Target` for target instead of a `std.zig.CrossTarget`.
        //
        // The target will convey all necessary information on the chip,
        // cpu and potentially the board as well.
        const firmware = microzig.addFirmware(b, .{
            .name = b.fmt("empty-{s}", .{dest.name}),
            .target = dest.target,
            .optimize = optimize,
            .source_file = .{ .path = "src/empty.zig" },
        });

        // `installFirmware()` is the MicroZig pendant to `Build.installArtifact()`
        // and allows installing the firmware as a typical firmware file.
        //
        // This will also install into `$prefix/firmware` instead of `$prefix/bin`.
        microzig.installFirmware(b, firmware, .{});
    }
}
