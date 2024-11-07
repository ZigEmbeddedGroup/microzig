const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    _ = optimize;

    const test_ports_step = b.step("run-port-tests", "Run all platform agnostic tests for Ports");
    _ = test_ports_step;
}
