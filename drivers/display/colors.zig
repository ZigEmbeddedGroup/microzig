//!
//! This file provides common color types found on the supported displays.
//!
//!
const builtin = @import("builtin");
const std = @import("std");

/// A color type encoding only black and white.
pub const BlackWhite = enum(u1) {
    black = 0,
    white = 1,
};

pub fn RGB565_Generic(comptime desired_endianness: std.builtin.Endian) type {
    return struct {
        const Self = @This();

        value: u16,

        pub const black: Self = from_rgb(0x00, 0x00, 0x00);
        pub const white: Self = from_rgb(0xFF, 0xFF, 0xFF);
        pub const red: Self = from_rgb(0xFF, 0x00, 0x00);
        pub const green: Self = from_rgb(0x00, 0xFF, 0x00);
        pub const blue: Self = from_rgb(0x00, 0x00, 0xFF);
        pub const cyan: Self = from_rgb(0x00, 0xFF, 0xFF);
        pub const magenta: Self = from_rgb(0xFF, 0x00, 0xFF);
        pub const yellow: Self = from_rgb(0xFF, 0xFF, 0x00);

        pub fn from_rgb(r: u8, g: u8, b: u8) Self {
            const r5: u16 = @as(u16, r) >> 3;
            const g6: u16 = @as(u16, g) >> 2;
            const b5: u16 = @as(u16, b) >> 3;

            const v: u16 = (r5 << 11) | (g6 << 5) | b5;

            return .{ .value = std.mem.nativeTo(u16, v, desired_endianness) };
        }
    };
}
