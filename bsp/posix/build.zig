const std = @import("std");
const Build = std.Build;

const MicroZig = @import("microzig/build");
const Target = MicroZig.Target;
const Firmware = MicroZig.Firmware;

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

pub fn build(b: *Build) !void {
    _ = b;
}

pub const chips = struct {
    pub const posix = Target{
        .preferred_format = .{ .elf = {} },
        .chip = chip,
        .hal = hal,
        .linker_script = .{ .none = {} },
        .board = null,
    };
};
pub const boards = struct {};

const hal = .{
    .root_source_file = .{ .cwd_relative = build_root ++ "/src/hal.zig" },
};

const chip = .{
    .name = "POSIX",
    .url = "TODO",
    .cpu = .{ .name = "native-posix4", .root_source_file = .{ .path = build_root ++ "/src/startup.zig" }, .target = .{} },
    .register_definition = .{ .zig = .{ .path = build_root ++ "/src/empty.zig" } },
    .memory_regions = &.{},
};
