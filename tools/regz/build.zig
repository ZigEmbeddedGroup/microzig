const std = @import("std");
const libxml2 = @import("libs/zig-libxml2/libxml2.zig");

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const xml = try libxml2.create(b, target, mode, .{
        .iconv = false,
        .lzma = false,
        .zlib = false,
    });
    xml.step.install();

    const commit_result = try std.ChildProcess.exec(.{
        .allocator = b.allocator,
        .argv = &.{ "git", "rev-parse", "HEAD" },
        .cwd = std.fs.path.dirname(@src().file) orelse unreachable,
    });

    const build_options = b.addOptions();
    build_options.addOption([]const u8, "commit", commit_result.stdout);

    const exe = b.addExecutable("regz", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addOptions("build_options", build_options);
    exe.addPackagePath("clap", "libs/zig-clap/clap.zig");
    xml.link(exe);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const tests = b.addTest("tests/main.zig");
    tests.setTarget(target);
    tests.setBuildMode(mode);
    tests.addOptions("build_options", build_options);
    tests.addPackagePath("xml", "src/xml.zig");
    tests.addPackagePath("Database", "src/Database.zig");
    xml.link(tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&tests.step);
}
