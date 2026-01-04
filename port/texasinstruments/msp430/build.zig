const std = @import("std");
const microzig = @import("microzig/build-internals");
const Chips = @import("src/Chips.zig");

const Self = @This();

chips: Chips,
boards: Boards,

const Boards = struct {
    @"MSP-EXP430F5529LP": *microzig.Target,
    @"MSP-EXP430G2ET": *microzig.Target,
};

pub fn init(dep: *std.Build.Dependency) Self {
    const chips = Chips.init(dep);
    const boards = Boards{
        .@"MSP-EXP430F5529LP" = chips.MSP430F5529.derive(.{
            .board = .{
                .name = "MSP-EXP430F5529LP",
                .description = "MSP430F5529 Launch Pad",
                .root_source_file = dep.builder.path("src/boards/MSP-EXP430F5529LP.zig"),
            },
        }),
        .@"MSP-EXP430G2ET" = chips.MSP430G2553.derive(.{
            .board = .{
                .name = "MSP-EXP430G2ET",
                .description = "MSP430G2553 Launch Pad",
                .root_source_file = dep.builder.path("src/boards/MSP-EXP430G2ET.zig"),
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
