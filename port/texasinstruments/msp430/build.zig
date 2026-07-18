const std = @import("std");
const microzig = @import("microzig/build-internals");
const Chips = @import("src/Chips.zig");

const Self = @This();

chips: Chips,
boards: Boards,

const Boards = struct {
    launch_pad_msp430f5529: *microzig.Target,
    launch_pad_msp430g2553: *microzig.Target,
};

pub fn init(dep: *std.Build.Dependency) ?Self {
    const chips = Chips.init(dep) orelse return null;
    const boards = Boards{
        .launch_pad_msp430f5529 = chips.MSP430F5529.derive(.{
            .board = .{
                .name = "MSP-EXP430F5529LP",
                .url = "https://www.ti.com/tool/MSP-EXP430F5529LP",
                .root_source_file = dep.builder.path("src/boards/MSP-EXP430F5529LP.zig"),
            },
        }),
        .launch_pad_msp430g2553 = chips.MSP430G2553.derive(.{
            .board = .{
                .name = "MSP-EXP430G2ET",
                .url = "https://www.ti.com/tool/MSP-EXP430G2ET",
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
    const generate = b.option(bool, "generate", "") orelse false;
    if (generate) {
        const ti_data = b.lazyDependency("ti_data", .{}) orelse return;
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
        generate_run.addFileArg(targetdb);

        b.getInstallStep().dependOn(&generate_run.step);
    }

    _ = b.step("test", "Run platform agnostic unit tests");
}
