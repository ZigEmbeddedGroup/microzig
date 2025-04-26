const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .hc32l110 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const examples: []const Example = &.{
        .{ .name = "blinky", .file = "src/blinky.zig" },
    };

    for (examples) |example| {
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        const firmware = mb.add_firmware(.{
            .name = example.name,
            .target = mb.ports.hc32l110.chips.hc32l110x4,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        mb.install_firmware(firmware, .{});
        mb.install_firmware(firmware, .{ .format = .elf });
    }
}

const Example = struct {
    name: []const u8,
    file: []const u8,
};
