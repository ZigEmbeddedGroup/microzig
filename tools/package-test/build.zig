const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .rp2xxx = true,
    .gd32 = true,
    .atsam = true,
    //.avr = true,
    .nrf5x = true,
    .lpc = true,
    .stm32 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const examples: []const Example = &.{
        .{ .target = mb.ports.rp2xxx.boards.raspberrypi.pico, .name = "rp2xxx" },
        .{ .target = mb.ports.gd32.boards.sipeed.longan_nano, .name = "gd32" },
        .{ .target = mb.ports.atsam.chips.atsamd51j19, .name = "atsam" },
        //.{ .target = mb.ports.avr.boards.arduino.nano, .name = "avr" },
        .{ .target = mb.ports.nrf5x.boards.nordic.nrf52840_dongle, .name = "nrf5x" },
        .{ .target = mb.ports.lpc.boards.mbed.lpc1768, .name = "lpc" },
        .{ .target = mb.ports.stm32.boards.stm32f3discovery, .name = "stm32" },
    };

    for (examples) |example| {
        const firmware = mb.add_firmware(.{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path("src/empty.zig"),
        });

        mb.install_firmware(firmware, .{});
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
};
