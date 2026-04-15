const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .tm4c = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const target = mb.ports.tm4c.boards.launch_pad_tm4c123g;

    const empty = mb.add_firmware(.{
        .name = b.fmt("empty_{s}", .{target.chip.name}),
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/empty.zig"),
    });

    mb.install_firmware(empty, .{});
}
