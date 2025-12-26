const std = @import("std");

const Chips = @import("src/Chips.zig");

chips: Chips,

pub fn build(b: *std.Build) void {
    const ti_data = b.dependency("ti_data", .{});
    const targetdb = ti_data.path("targetdb");

    const generate_optimize = .ReleaseSafe;
    const regz_dep = b.dependency("microzig/tools/regz", .{
        .optimize = generate_optimize,
    });
    const regz = regz_dep.module("regz");

    const generate_exe = b.addExecutable(.{
        .name = "generate",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/generate.zig"),
            .target = b.graph.host,
            .optimize = generate_optimize,
        }),
    });
    generate_exe.root_module.addImport("regz", regz);

    const generate_run = b.addRunArtifact(generate_exe);
    generate_run.max_stdio_size = std.math.maxInt(usize);
    generate_run.addFileArg(targetdb);

    const generate_step = b.step("generate", "Generate chips file 'src/Chips.zig'");
    generate_step.dependOn(&generate_run.step);
}
