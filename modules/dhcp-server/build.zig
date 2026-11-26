const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const root = b.addModule("dhcp_server", .{
        .root_source_file = b.path("src/root.zig"),
        .optimize = optimize,
        .target = target,
    });

    const exe_example = b.addExecutable(.{
        .name = "dhcp-server",
        .root_module = b.createModule(.{
            .root_source_file = b.path("example/main.zig"),
            .optimize = optimize,
            .target = target,
        }),
    });
    exe_example.root_module.addImport("dhcp", root);
    b.installArtifact(exe_example);

    const step_run = b.step("run", "Run the example dhcp server");
    const run_eaxmple = b.addRunArtifact(exe_example);
    step_run.dependOn(&run_eaxmple.step);

    const step_test = b.step("test", "Run unit tests");
    const unit_test = b.addTest(.{ .root_module = root });
    step_test.dependOn(&unit_test.step);
}
