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
                .board = microzig.ModuleDeclaration.init(b, .{
                    .root_source_file = b.path("src/boards/STM32F3DISCOVERY.zig"),
                }),
            }),
            .stm32f4discovery = chips.STM32F407VG.derive(.{
                .board = microzig.ModuleDeclaration.init(b, .{
                    .root_source_file = b.path("src/boards/STM32F4DISCOVERY.zig"),
                }),
            }),
            .stm3240geval = chips.STM32F407VG.derive(.{
                .board = microzig.ModuleDeclaration.init(b, .{
                    .root_source_file = b.path("src/boards/STM3240G_EVAL.zig"),
                }),
            }),
            .stm32f429idiscovery = chips.STM32F429ZI.derive(.{
                .board = microzig.ModuleDeclaration.init(b, .{
                    .root_source_file = b.path("src/boards/STM32F429IDISCOVERY.zig"),
                }),
            }),
        },
    };
}

pub fn build(b: *std.Build) !void {
    const update = b.step("update", "Update chip definitions from embassy-rs/stm32-data-generated");

    const stm32_data_generated = b.lazyDependency("stm32-data-generated", .{}) orelse return;

    const regz_dep = b.dependency("microzig/tools/regz", .{});
    const regz = regz_dep.module("regz");

    const generate = b.addExecutable(.{
        .name = "generate",
        .root_source_file = b.path("src/generate.zig"),
        .target = b.host,
        .optimize = .Debug,
    });
    generate.root_module.addImport("regz", regz);

    const generate_run = b.addRunArtifact(generate);
    generate_run.max_stdio_size = std.math.maxInt(usize);
    generate_run.addFileArg(stm32_data_generated.path("."));
    update.dependOn(&generate_run.step);

    _ = b.step("test", "Run platform agnostic unit tests");
}
