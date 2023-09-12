const std = @import("std");
const microzig = @import("microzig");
const rp2040 = @import("../build.zig");
const chips = @import("chips.zig");

fn root_dir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

fn board_path(comptime path: []const u8) std.Build.LazyPath {
    return .{
        .path = std.fmt.comptimePrint("{s}/boards/{s}", .{ root_dir(), path }),
    };
}

pub const Board = struct {
    inner: microzig.Board,
    bootrom: rp2040.BootROM,
};

// https://www.raspberrypi.com/products/raspberry-pi-pico/
pub const raspberry_pi_pico = Board{
    .inner = .{
        .name = "Raspberry Pi Pico",
        .source = board_path("raspberry_pi_pico.zig"),
        .chip = chips.rp2040,
    },
    .bootrom = .w25q080,
};

// https://www.waveshare.com/rp2040-plus.htm
pub const waveshare_rp2040_plus_4m = Board{
    .inner = .{
        .name = "Waveshare RP2040-Plus (4M Flash)",
        .source = board_path("waveshare_rp2040_plus_4m.zig"),
        .chip = chips.rp2040,
    },
    .bootrom = .w25q080,
};

// https://www.waveshare.com/rp2040-plus.htm
pub const waveshare_rp2040_plus_16m = Board{
    .inner = .{
        .name = "Waveshare RP2040-Plus (16M Flash)",
        .source = board_path("waveshare_rp2040_plus_16m.zig"),
        .chip = chips.rp2040,
    },
    .bootrom = .w25q080,
};

// https://www.waveshare.com/rp2040-eth.htm
pub const waveshare_rp2040_eth = Board{
    .inner = .{
        .name = "Waveshare RP2040-ETH Mini",
        .source = board_path("waveshare_rp2040_eth.zig"),
        .chip = chips.rp2040,
    },
    .bootrom = .w25q080,
};

// https://www.waveshare.com/rp2040-matrix.htm
pub const waveshare_rp2040_matrix = Board{
    .inner = .{
        .name = "Waveshare RP2040-Matrix",
        .source = board_path("waveshare_rp2040_matrix.zig"),
        .chip = chips.rp2040,
    },
    .bootrom = .w25q080,
};
