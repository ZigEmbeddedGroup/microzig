const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const serial_dep = b.dependency("serial", .{
        .target = target,
        .optimize = optimize,
    });

    const printer_mod = b.addModule("printer", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const printer_exe = b.addExecutable(.{
        .name = "printer",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .imports = &.{
                .{ .name = "printer", .module = printer_mod },
                .{ .name = "serial", .module = serial_dep.module("serial") },
            },
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(printer_exe);

    const example_exe = b.addExecutable(.{
        .name = "rp2xxx_runner",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/rp2xxx_runner.zig"),
            .imports = &.{
                .{ .name = "printer", .module = printer_mod },
                .{ .name = "serial", .module = serial_dep.module("serial") },
            },
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(example_exe);
}
