const std = @import("std");
const microzig = @import("microzig/build-internals");
const Chips = @import("src/Chips.zig");

const Self = @This();

chips: Chips,
boards: struct {
    stm32f3discovery: *const microzig.Target,
    stm32f4discovery: *const microzig.Target,
    stm3240geval: *const microzig.Target,
    stm32f429idiscovery: *const microzig.Target,
},

pub fn init(dep: *std.Build.Dependency) Self {
    const b = dep.builder;
    const chips = Chips.init(dep);

    return .{
        .chips = chips,
        .boards = .{
            .stm32f3discovery = chips.STM32F303VC.derive(.{
                .board = .{
                    .name = "STM32F3DISCOVERY",
                    .root_source_file = b.path("src/boards/STM32F3DISCOVERY.zig"),
                },
                .hal = microzig.HardwareAbstractionLayer{
                    .root_source_file = b.path("src/hals/STM32F303.zig"),
                },
            }),
            .stm32f4discovery = chips.STM32F407VG.derive(.{
                .board = .{
                    .name = "STM32F4DISCOVERY",
                    .root_source_file = b.path("src/boards/STM32F4DISCOVERY.zig"),
                },
            }),
            .stm3240geval = chips.STM32F407VG.derive(.{
                .board = .{
                    .name = "STM3240G_EVAL",
                    .root_source_file = b.path("src/boards/STM3240G_EVAL.zig"),
                },
            }),
            .stm32f429idiscovery = chips.STM32F429ZI.derive(.{
                .board = .{
                    .name = "STM32F429IDISCOVERY",
                    .root_source_file = b.path("src/boards/STM32F429IDISCOVERY.zig"),
                },
            }),
        },
    };
}

pub fn build(b: *std.Build) !void {
    const stm32_data_generated = b.lazyDependency("stm32-data-generated", .{}) orelse return;

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

    const clocktree_test = b.addTest(.{
        .name = "ClockTree Test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("stm32-clocks/lib.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
        }),
    });

    const clocktree_test_run = b.addRunArtifact(clocktree_test);

    const generate_run = b.addRunArtifact(generate_exe);
    generate_run.max_stdio_size = std.math.maxInt(usize);
    generate_run.addFileArg(stm32_data_generated.path("."));

    const generate_step = b.step("generate", "Generate chips file 'src/Chips.zig'");
    generate_step.dependOn(&generate_run.step);

    _ = b.step("test", "Run platform agnostic unit tests");

    const clocktree_step = b.step("test_clocktree", "Run clocktree unit tests");
    clocktree_step.dependOn(&clocktree_test_run.step);
}
