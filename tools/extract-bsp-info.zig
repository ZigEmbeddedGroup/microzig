//!
//! A tool that extracs which chips and boards are available from a board support package
//! and validates that the declarations conform
//!

const std = @import("std");
const bsp = @import("bsp");
const microzig = @import("microzig/build");

// Fake build_runner.zig api:
pub const dependencies = struct {
    pub const imports = struct {};
};

const JsonTarget = struct {
    id: []const u8,

    output_format: ?[]const u8,

    features: struct {
        hal: bool,
    },

    memory: struct {
        flash: u64,
        ram: u64,
    },

    cpu: []const u8,

    chip: []const u8,
    chip_url: ?[]const u8,

    board: ?[]const u8,
    board_url: ?[]const u8,
};

fn renderMicroZigTarget(stream: anytype, key: []const u8, target: microzig.Target) !void {
    var jtarget = JsonTarget{
        .id = key,

        .output_format = if (target.preferred_format) |fmt| @tagName(fmt) else null,

        .features = .{
            .hal = (target.hal != null),
        },

        .cpu = @tagName(target.chip.cpu),

        .chip = target.chip.name,
        .chip_url = target.chip.url,

        .board = null,
        .board_url = null,

        .memory = .{
            .flash = 0,
            .ram = 0,
        },
    };

    if (target.board) |brd| {
        jtarget.board = brd.name;
        jtarget.board_url = brd.url;
    }

    for (target.chip.memory_regions) |reg| {
        switch (reg.kind) {
            .flash => jtarget.memory.flash += reg.length,
            .ram => jtarget.memory.ram += reg.length,
            else => {},
        }
    }

    try std.json.stringify(jtarget, .{}, stream);
}

fn renderTargetArray(stream: anytype, targets: []const microzig.BoardSupportPackageDefinition.TargetDefinition) !void {
    for (targets, 0..) |target_def, i| {
        if (i > 0) try stream.writeAll(",");
        try renderMicroZigTarget(
            stream,
            target_def.id,
            target_def.target,
        );
    }
}

pub fn main() !void {
    const info = bsp.microzig_board_support;

    var stdout = std.io.getStdOut().writer();

    try stdout.writeAll("{ \"board-support\": {");

    try stdout.writeAll("\"targets\":[");
    try renderTargetArray(stdout, info.targets);

    try stdout.writeAll("]}}");
}
