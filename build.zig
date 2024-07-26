const std = @import("std");
const Build = std.Build;

const MicroZig = @import("build/definitions");

const example_dep_names: []const []const u8 = &.{
    "examples/nordic/nrf5x",
    "examples/nxp/lpc",
    "examples/microchip/atsam",
    "examples/microchip/avr",
    "examples/gigadevice/gd32",
    "examples/stmicro/stm32",
    //"examples/espressif/esp",
    "examples/raspberrypi/rp2xxx",
};

const ports = .{
    .{ "port/nordic/nrf5x", @import("port/nordic/nrf5x") },
    .{ "port/nxp/lpc", @import("port/nxp/lpc") },
    .{ "port/microchip/atsam", @import("port/microchip/atsam") },
    .{ "port/microchip/avr", @import("port/microchip/avr") },
    .{ "port/gigadevice/gd32", @import("port/gigadevice/gd32") },
    .{ "port/stmicro/stm32", @import("port/stmicro/stm32") },
    .{ "port/espressif/esp", @import("port/espressif/esp") },
    .{ "port/raspberrypi/rp2xxx", @import("port/raspberrypi/rp2xxx") },
};

pub fn build(b: *Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Build all examples
    for (example_dep_names) |example_dep_name| {
        const example_dep = b.dependency(example_dep_name, .{
            .optimize = optimize,
        });

        const example_dep_install_step = example_dep.builder.getInstallStep();
        b.getInstallStep().dependOn(example_dep_install_step);
    }

    const boxzer_dep = b.dependency("boxzer", .{ .optimize = .ReleaseSafe });
    const boxzer_exe = boxzer_dep.artifact("boxzer");
    const boxzer_run = b.addRunArtifact(boxzer_exe);
    if (b.args) |args|
        boxzer_run.addArgs(args);

    const package_step = b.step("package", "Package monorepo using boxzer");
    package_step.dependOn(&boxzer_run.step);

    const test_ports_step = b.step("run-port-tests", "Run all platform agnostic tests for Ports");
    inline for (ports) |port| {
        const port_dep = b.dependency(port[0], .{});
        if (port_dep.builder.top_level_steps.get("test")) |test_step| {
            test_ports_step.dependOn(&test_step.step);
        }
    }
}
