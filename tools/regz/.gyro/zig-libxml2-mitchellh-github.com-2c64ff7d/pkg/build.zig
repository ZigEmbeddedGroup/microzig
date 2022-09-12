const std = @import("std");
const libxml2 = @import("libxml2.zig");
const zlib = @import("test/zig-zlib/zlib.zig");

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const xml2 = try libxml2.create(b, target, mode, .{
        // We don't have the required libs so don't build these
        .iconv = false,
        .lzma = false,
        .zlib = false,
    });
    xml2.step.install();

    // Tests that we can depend on other libraries like zlib
    const xml2_with_libs = try libxml2.create(b, target, mode, .{
        // We don't have the required libs so don't build these
        .iconv = false,
        .lzma = false,

        // Testing this
        .zlib = true,
    });
    const z = zlib.create(b, target, mode);
    z.link(xml2_with_libs.step, .{});

    const static_binding_test = b.addTest("test/basic.zig");
    static_binding_test.setBuildMode(mode);
    xml2.link(static_binding_test);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&xml2_with_libs.step.step);
    test_step.dependOn(&static_binding_test.step);
}
