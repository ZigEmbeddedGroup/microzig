const std = @import("std");
const microzig = @import("microzig");

pub const chips = @import("src/chips.zig");

pub fn build(b: *std.build.Builder) void {
    const optimize = b.standardOptimizeOption(.{});
    inline for (@typeInfo(chips).Struct.decls) |decl| {
        const exe = microzig.addEmbeddedExecutable(b, .{
            .name = decl.name ++ ".minimal",
            .source_file = .{
                .path = "test/programs/minimal.zig",
            },
            .backing = .{ .chip = @field(chips, decl.name) },
            .optimize = optimize,
        });
        exe.installArtifact(b);
    }
}
