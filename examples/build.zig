const std = @import("std");

const example_dep_names: []const []const u8 = &.{
    //"espressif/esp",
    "gigadevice/gd32",
    "microchip/atsam",
    "microchip/avr",
    "nordic/nrf5x",
    "nxp/lpc",
    "raspberrypi/rp2xxx",
    "stmicro/stm32",
    "wch/ch32",
};

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Build all examples
    for (example_dep_names) |example_dep_name| {
        const example_dep = b.dependency(example_dep_name, .{
            .optimize = optimize,
        });

        const example_dep_install_step = example_dep.builder.getInstallStep();
        example_dep.builder.install_path = b.install_path; // HACK: install in the current directory
        b.getInstallStep().dependOn(example_dep_install_step);
    }
}
