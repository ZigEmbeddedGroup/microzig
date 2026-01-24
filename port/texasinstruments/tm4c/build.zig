const std = @import("std");
const microzig = @import("microzig/build-internals");
const Chips = @import("src/Chips.zig");

const Self = @This();

chips: Chips,
boards: Boards,

const Boards = struct {
    launch_pad_tm4c123g: *microzig.Target,
};

pub fn init(dep: *std.Build.Dependency) Self {
    const chips = Chips.init(dep);
    const boards = Boards{
        .launch_pad_tm4c123g = chips.TM4C123GH6PM.derive(.{
            .board = .{
                .name = "EK-TM4C123GXL",
                .url = "https://www.ti.com/tool/EK-TM4C123GXL",
                .root_source_file = dep.builder.path("src/boards/EK-TM4C123GXL.zig"),
            },
        }),
    };

    return .{
        .chips = chips,
        .boards = boards,
    };
}

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
