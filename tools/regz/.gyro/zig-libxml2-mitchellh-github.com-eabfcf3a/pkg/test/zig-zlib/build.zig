const std = @import("std");
const zlib = @import("zlib.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = zlib.create(b, target, optimize);
    lib.step.install();

    const tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
    });
    lib.link(tests, .{});

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&tests.step);
}
