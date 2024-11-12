const std = @import("std");

const example_dep_names: []const []const u8 = &.{
    // "nordic/nrf5x",
    "nxp/lpc",
    // "microchip/atsam",
    // "microchip/avr",
    // "gigadevice/gd32",
    "stmicro/stm32",
    //"espressif/esp",
    "raspberrypi/rp2xxx",
};

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Build all examples
    for (example_dep_names) |example_dep_name| {
        const example_dep = b.dependency(example_dep_name, .{
            .optimize = optimize,
        });

        const example_dep_install_step = example_dep.builder.getInstallStep();
        b.getInstallStep().dependOn(example_dep_install_step);
    }
}
