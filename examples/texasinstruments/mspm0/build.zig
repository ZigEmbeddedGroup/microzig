const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{ .mspm0 = true });

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    inline for (comptime std.meta.fieldNames(@TypeOf(mb.ports.mspm0.chips))) |field_name| {
        const target = @field(mb.ports.mspm0.chips, field_name);

        const raw_blinky = mb.add_firmware(.{
            .name = b.fmt("raw_blinky_{s}", .{field_name}),
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/raw_blinky.zig"),
        });

        mb.install_firmware(raw_blinky, .{});

        const blinky = mb.add_firmware(.{
            .name = b.fmt("blinky_{s}", .{field_name}),
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/blinky.zig"),
        });

        mb.install_firmware(blinky, .{});
    }
}
