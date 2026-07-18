const std = @import("std");

const example_dep_names: []const []const u8 = &.{
    "texasinstruments/tm4c",
    "texasinstruments/msp430",
    "nordic/nrf5x",
    "nxp/mcx",
    "nxp/lpc",
    "wch/ch32v",
    "microchip/samd51",
    //"microchip/atmega",
    //"microchip/attiny",
    "gigadevice/gd32",
    "stmicro/stm32",
    "no_hal/stm32_l031",
    "espressif/esp",
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
        //example_dep.builder.install_path = b.pathJoin(&.{ b.install_path, example_dep_name }); // HACK: install in the current directory
        b.getInstallStep().dependOn(example_dep_install_step);
    }
}
