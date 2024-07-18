const std = @import("std");
const MicroZig = @import("microzig/build");
const ch32 = @import("microzig/bsp/wch/ch32");

const available_examples = [_]Example{
    .{ .target = ch32.chips.ch32v003xx, .name = "ch32v003xx", .file = "src/empty.zig" },
};

pub fn build(b: *std.Build) void {
    const microzig = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    for (available_examples) |example| {
        const firmware = microzig.add_firmware(b, .{
            .name = example.name,
            .target = example.target,
            .optimize = optimize,
            .root_source_file = b.path(example.file),
        });
        microzig.install_firmware(b, firmware, .{});
        microzig.install_firmware(b, firmware, .{ .format = .bin });
    }
}

const Example = struct {
    target: MicroZig.Target,
    name: []const u8,
    file: []const u8,
};
