const std = @import("std");
const microzig = @import("deps/microzig/build.zig");

pub const chips = @import("src/chips.zig");
pub const cpus = @import("src/cpus.zig");

pub fn build(b: *std.build.Builder) void {
    const optimize = b.standardOptimizeOption(.{});

    var exe = microzig.addEmbeddedExecutable(b, .{
        .name = "esp-bringup",
        .source_file = .{
            .path = "src/example/blinky.zig",
        },
        .backing = .{ .chip = chips.esp32_c3 },
        .optimize = optimize,
    });
    exe.installArtifact(b);
}
