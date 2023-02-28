//! This file contains some backings for different test programs
const std = @import("std");
const microzig = @import("../build.zig");

const minimal_chip = microzig.Chip{};

const chip_with_hal = microzig.Chip{};

pub const minimal = microzig.Backing{
    .chip = minimal_chip,
};

pub const has_hal = microzig.Backing{
    .chip = chip_with_hal,
};

pub const has_board = microzig.Backing{
    .board = .{
        .chip = minimal_chip,
    },
};
