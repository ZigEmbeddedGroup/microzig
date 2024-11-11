//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");
const MicroZig = @import("microzig/build/definitions");

/// This build script validates usage patterns we expect from MicroZig
pub fn build(b: *std.Build) !void {
    const unit_tests = b.addTest(.{
        // We're not using the `start.zig` entrypoint as it overrides too much
        // configuration
        .root_source_file = b.path("src/microzig.zig"),
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    b.getInstallStep().dependOn(&run_unit_tests.step);
}
