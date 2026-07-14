const std = @import("std");
const microzig = @import("microzig");

const MicroBuild = microzig.MicroBuild(.{ .mspm0 = true });

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const mz_dep = b.dependency("microzig", .{});
    const mb = MicroBuild.init(b, mz_dep) orelse return;

    inline for (comptime std.meta.fieldNames(@TypeOf(mb.ports.mspm0.chips))) |field_name| {
        const target = @field(mb.ports.mspm0.chips, field_name);

        inline for ([_][]const u8{
            "blinky",
            "raw_blinky",
            "uart_echo",
            "uart_log",
        }) |name| {
            const example = mb.add_firmware(.{
                .name = name ++ "_" ++ field_name,
                .target = target,
                .optimize = optimize,
                .root_source_file = b.path("src/" ++ name ++ ".zig"),
            });

            mb.install_firmware(example, .{});
        }
    }
}
