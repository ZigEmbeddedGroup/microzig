//! Some words on the build script here:
//! We cannot use a test runner here as we're building for freestanding.
//! This means we need to use addExecutable() instead of using

const std = @import("std");

pub const microzig = @import("src/main.zig");

// alias for packages
pub const addEmbeddedExecutable = microzig.addEmbeddedExecutable;
pub const boards = microzig.boards;
pub const Backing = microzig.Backing;

pub fn build(b: *std.build.Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    const test_step = b.step("test", "Builds and runs the library test suite");

    _ = optimize;
    _ = test_step;
}
