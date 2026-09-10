const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const section_name = b.option([]const u8, "section_name", "") orelse ".defmt";
    const section_marker_start = b.option([]const u8, "section_marker_start", "") orelse "__defmt_start";
    const section_marker_end = b.option([]const u8, "section_marker_end", "") orelse "__defmt_end";
    const print_info_size_max = b.option(u32, "print_info_size_max", "") orelse 4 * 1024 * 1024;

    const config = b.addOptions();
    config.addOption([]const u8, "section_name", section_name);
    config.addOption([]const u8, "section_marker_start", section_marker_start);
    config.addOption([]const u8, "section_marker_end", section_marker_end);
    config.addOption(u32, "print_info_size_max", print_info_size_max);

    const defmt = b.addModule("defmt", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "config", .module = config.createModule() },
        },
    });

    // Only going to work for targets that output ELF
    if (target.result.os.tag == .linux) {
        const example_app = b.addExecutable(.{
            .name = "example_app",
            .root_module = b.createModule(.{
                .root_source_file = b.path("src/example/app.zig"),
                .target = target,
                .optimize = optimize,
                .imports = &.{
                    .{ .name = "defmt", .module = defmt },
                },
            }),
        });
        b.installArtifact(example_app);

        const example_printer = b.addExecutable(.{
            .name = "example_printer",
            .root_module = b.createModule(.{
                .root_source_file = b.path("src/example/printer.zig"),
                .target = target,
                .optimize = optimize,
                .imports = &.{
                    .{ .name = "defmt", .module = defmt },
                },
            }),
        });
        b.installArtifact(example_printer);
    }
}
