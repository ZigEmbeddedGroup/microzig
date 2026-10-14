const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .ch32h = true,
});

fn add_example(b: *std.Build, mb: anytype, comptime name: []const u8, optimize: std.builtin.OptimizeMode) void {
    const v3f = mb.add_firmware(.{
        .name = "v3f",
        .root_source_file = b.path("src/" ++ name ++ "_v3f.zig"),
        .optimize = optimize,
        .target = mb.ports.ch32h.chips.ch32h417_v3f,
    });

    const v5f = mb.add_firmware(.{
        .name = "v5f",
        .root_source_file = b.path("src/" ++ name ++ "_v5f.zig"),
        .optimize = optimize,
        .target = mb.ports.ch32h.chips.ch32h417_v5f,
    });

    const merged_bin = mb.ports.ch32h.merge(b, v3f.get_emitted_elf(), v5f.get_emitted_elf(), name ++ "_merged.bin");

    const install = b.addInstallFileWithDir(merged_bin, .{ .custom = "firmware" }, name ++ ".bin");
    b.getInstallStep().dependOn(&install.step);
}

const examples = [_][]const u8{
    "blinky",
    "interrupts",
    "systick",
};

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .small });

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    inline for (examples) |example| {
        add_example(b, mb, example, optimize);
    }
}
