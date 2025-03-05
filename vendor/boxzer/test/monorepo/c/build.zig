const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule("c", .{
        .root_source_file = .{ .path = "src/root.zig" },
    });
}
