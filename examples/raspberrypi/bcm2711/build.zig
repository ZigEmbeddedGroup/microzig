const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .bcm2711 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const maybe_example = b.option([]const u8, "example", "only build matching examples");

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const examples: []const Example = &.{
        .{ .name = "blinky", .file = "src/blinky.zig" },
        .{ .name = "uart_echo", .file = "src/uart_echo.zig" },
    };

    for (examples) |example| {
        // If we specify example, only select the ones that match
        if (maybe_example) |selected_example|
            if (!std.mem.containsAtLeast(u8, example.name, 1, selected_example))
                continue;

        const fw = mb.add_firmware(.{
            .name = example.name,
            .target = mb.ports.bcm2711.boards.raspberrypi.pi_4b,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });

        // The firmware is installed as a raw image. Rename a copy to kernel8.img on the boot
        // partition of the card.
        mb.install_firmware(fw, .{});

        // For debugging, we also always install the firmware as an ELF file
        mb.install_firmware(fw, .{ .format = .elf });
    }
}

const Example = struct {
    name: []const u8,
    file: []const u8,
};
