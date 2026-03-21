const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .attiny = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const available_examples = [_]Example{
        .{ .target = mb.ports.attiny.boards.digispark, .name = "digispark_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.attiny.boards.adafruit.trinket, .name = "trinket_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.attiny.boards.adafruit.gemma, .name = "gemma_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.attiny.chips.attiny85, .name = "attiny85_blinky", .file = "src/blinky.zig" },
        .{ .target = mb.ports.attiny.chips.attiny85, .name = "attiny85_blinky_interrupt", .file = "src/blinky_interrupt.zig" },
        .{ .target = mb.ports.attiny.chips.attiny84, .name = "attiny84_blinky", .file = "src/blinky84.zig" },
    };

    for (available_examples) |example| {
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        const fw = mb.add_firmware(.{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        mb.install_firmware(fw, .{});
        mb.install_firmware(fw, .{ .format = .elf });
    }
}

const Example = struct {
    target: *const microzig.Target,
    name: []const u8,
    file: []const u8,
};
