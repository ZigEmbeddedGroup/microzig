const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .rp2xxx = true,
    .gd32 = true,
    .atsam = true,
    .avr = true,
    .nrf5x = true,
    .lpc = true,
    .stm32 = true,
    .ch32 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep);

    const examples: []const Example = &.{
        .{ .target = mb.ports.rp2xxx.boards.raspberrypi.pico, .name = "rpi_pico" },
    };

    for (examples) |example| {
        const firmware = mb.add_firmware(.{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path("src/empty.zig"),
        });

        mb.install_firmware(firmware, .{});
    }
}

const Example = struct {
    target: *microzig.Target,
    name: []const u8,
};
