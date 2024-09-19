const std = @import("std");
const MicroZig = @import("microzig/build");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

const KiB = 1024;

pub const chips = @import("src/chips.zig");

pub fn build(b: *std.Build) !void {
    const update = b.step("update", "Update chip definitions from embassy-rs/stm32-data-generated");

    const regz_dep = b.dependency("microzig/tools/regz", .{});
    const regz = regz_dep.module("regz");

    const curl_commits_run = b.addSystemCommand(&.{
        "curl", "-s", "https://api.github.com/repos/embassy-rs/stm32-data-generated/commits", "-o",
    });
    curl_commits_run.stdio = .inherit;
    const commits_json = curl_commits_run.addOutputFileArg("commits.json");

    const jq_run = b.addSystemCommand(&.{ "jq", "-r", ".[0].sha" });
    jq_run.addFileArg(commits_json);
    const commit = jq_run.captureStdOut();

    const generate = b.addExecutable(.{
        .name = "generate",
        .root_source_file = b.path("src/generate.zig"),
        .target = b.host,
        .optimize = .Debug,
    });
    generate.root_module.addImport("regz", regz);

    const generate_run = b.addRunArtifact(generate);
    generate_run.max_stdio_size = std.math.maxInt(usize);
    generate_run.addFileArg(commit);
    _ = generate_run.addOutputDirectoryArg("stm32-data-generated");
    update.dependOn(&generate_run.step);

    _ = b.step("test", "Run platform agnostic unit tests");
}

pub const boards = struct {
    pub const stm32f3discovery = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.STM32F303VC.chip,
        .board = .{
            .name = "STM32F3DISCOVERY",
            .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/STM32F3DISCOVERY.zig" },
        },
    };

    pub const stm32f4discovery = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.STM32F407VG.chip,
        .board = .{
            .name = "STM32F4DISCOVERY",
            .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/STM32F4DISCOVERY.zig" },
        },
    };

    pub const stm3240geval = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.STM32F407VG.chip,
        .board = .{
            .name = "STM3240G_EVAL",
            .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/STM3240G_EVAL.zig" },
        },
    };

    pub const stm32f429idiscovery = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.STM32F429ZIT6U.chip,
        .board = .{
            .name = "STM32F429IDISCOVERY",
            .root_source_file = .{ .cwd_relative = build_root ++ "/src/boards/STM32F429IDISCOVERY.zig" },
        },
    };
};

// pub fn build(b: *std.build.Builder) void {
//     _ = b;
// const optimize = b.standardOptimizeOption(.{});
// inline for (@typeInfo(boards).Struct.decls) |decl| {
//     if (!decl.is_pub)
//         continue;

//     const exe = microzig.addEmbeddedExecutable(b, .{
//         .name = @field(boards, decl.name).name ++ ".minimal",
//         .root_source_file = .{
//             .path = "test/programs/minimal.zig",
//         },
//         .backing = .{ .board = @field(boards, decl.name) },
//         .optimize = optimize,
//     });
//     exe.installArtifact(b);
// }

// inline for (@typeInfo(chips).Struct.decls) |decl| {
//     if (!decl.is_pub)
//         continue;

//     const exe = microzig.addEmbeddedExecutable(b, .{
//         .name = @field(chips, decl.name).name ++ ".minimal",
//         .root_source_file = .{
//             .path = "test/programs/minimal.zig",
//         },
//         .backing = .{ .chip = @field(chips, decl.name) },
//         .optimize = optimize,
//     });
//     exe.installArtifact(b);
// }
// }
