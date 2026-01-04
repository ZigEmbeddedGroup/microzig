const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{
    .msp430 = true,
});

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    const targets = &.{
        mb.ports.msp430.boards.@"MSP-EXP430F5529LP",
        mb.ports.msp430.boards.@"MSP-EXP430G2ET",
    };

    inline for (targets) |target| {
        const empty = mb.add_firmware(.{
            .name = b.fmt("empty_{s}", .{target.chip.name}),
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/empty.zig"),
        });

        const blinky = mb.add_firmware(.{
            .name = b.fmt("blinky_{s}", .{target.chip.name}),
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/blinky.zig"),
        });

        mb.install_firmware(empty, .{});
        mb.install_firmware(blinky, .{});
    }
}
