const std = @import("std");

// TODO: fix this issue with AVR. For some reason we fail wasi assertions?
//
// error: the following command failed with 1 compilation errors:
//Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/zig build-exe -freference-trace=256 -OReleaseSmall -target avr-freestanding-eabi -mcpu avr5 --dep app --dep microzig -Mroot=/Users/mattnite/code/microzig/core/src/start.zig --dep microzig -Mapp=/Users/mattnite/code/microzig/examples/microchip/avr/src/blinky.zig --dep config --dep chip --dep cpu --dep hal --dep board -Mmicrozig=/Users/mattnite/code/microzig/core/src/microzig.zig -Mconfig=/Users/mattnite/code/microzig/zig-cache/c/303c67fccae4ec4bb03ec2180082b67b/options.zig --dep microzig -Mchip=/Users/mattnite/code/microzig/zig-cache/o/2c86b0de714a8b4409eb761d16297c00/chip.zig --dep microzig -Mcpu=/Users/mattnite/code/microzig/core/src/cpus/avr5.zig --dep microzig -Mhal=/Users/mattnite/code/microzig/bsp/microchip/avr/src/hals/ATmega328P.zig --dep microzig -Mboard=/Users/mattnite/code/microzig/bsp/microchip/avr/src/boards/arduino_uno.zig --cache-dir /Users/mattnite/code/microzig/zig-cache --global-cache-dir /Users/mattnite/.cache/zig --name arduino-nano_blinky -static -fcompiler-rt --script /Users/mattnite/code/microzig/zig-cache/o/2c186d936508aa71bea517796451c3f9/linker.ld --listen=-
//install
//mq install
//   mq install generated to arduino-nano_blinky.hex
//      mq objcopy generated
//         mq zig build-exe arduino-nano_blinky ReleaseSmall avr-freestanding-eabi 1 errors
///Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/lib/std/debug.zig:403:14: error: reached unreachable code
//    if (!ok) unreachable; // assertion failure
//             ^~~~~~~~~~~
///Users/mattnite/zig/0.12.0-dev.3097+5c0766b6c/files/lib/std/os/wasi.zig:12:11: note: called from here
//    assert(@alignOf(i16) == 2);
//    ~~~~~~^~~~~~~~~~~~~~~~~~~~
const example_dep_names: []const []const u8 = &.{
    "microzig/examples/nordic/nrf5x",
    "microzig/examples/nxp/lpc",
    "microzig/examples/microchip/atsam",
    //"microzig/examples/microchip/avr",
    "microzig/examples/gigadevice/gd32",
    "microzig/examples/stmicro/stm32",
    "microzig/examples/espressif/esp",
    "microzig/examples/raspberrypi/rp2040",
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

    const boxzer_dep = b.dependency("boxzer", .{});
    const boxzer_exe = boxzer_dep.artifact("boxzer");
    const boxzer_run = b.addRunArtifact(boxzer_exe);
    if (b.args) |args|
        boxzer_run.addArgs(args);

    const package_step = b.step("package", "Package monorepo using boxzer");
    package_step.dependOn(&boxzer_run.step);
}
