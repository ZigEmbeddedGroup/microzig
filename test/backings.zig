//! This file contains some backings for different test programs
const std = @import("std");
const microzig = @import("../build.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse unreachable;
}

const cpu = microzig.Cpu{
    .name = "my_cpu",
    .source = .{
        .path = root_dir() ++ "/cpu.zig",
    },

    // this will actually make it a native target, this is still fine
    .target = std.zig.CrossTarget{},
};

const minimal_chip = microzig.Chip{
    .name = "my_chip",
    .cpu = cpu,
    .source = .{
        .path = root_dir() ++ "/chip.zig",
    },
    .memory_regions = &.{
        .{ .offset = 0x1000, .length = 0x1000, .kind = .flash },
        .{ .offset = 0x2000, .length = 0x1000, .kind = .ram },
    },
};

const chip_with_hal = microzig.Chip{
    .name = "my_chip",
    .cpu = cpu,
    .source = .{
        .path = root_dir() ++ "/chip.zig",
    },
    .hal = .{
        .path = root_dir() ++ "/hal.zig",
    },
    .memory_regions = &.{
        .{ .offset = 0x1000, .length = 0x1000, .kind = .flash },
        .{ .offset = 0x2000, .length = 0x1000, .kind = .ram },
    },
};

pub const minimal = microzig.Backing{
    .chip = minimal_chip,
};

pub const has_hal = microzig.Backing{
    .chip = chip_with_hal,
};

pub const has_board = microzig.Backing{
    .board = .{
        .name = "has_board",
        .chip = minimal_chip,
        .source = .{
            .path = root_dir() ++ "/board.zig",
        },
    },
};
