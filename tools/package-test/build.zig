const std = @import("std");

const ports = &.{
    "microzig/port/raspberrypi/rp2xxx",
};

pub fn build(b: *std.Build) void {
    const test_ports_step = b.step("run-port-tests", "Run all platform agnostic tests for Ports");
    for (ports) |port| {
        const dep = b.dependency(port, .{});
        test_ports_step.dependOn(&dep.builder.top_level_steps.get("test").?.step);
    }
}
