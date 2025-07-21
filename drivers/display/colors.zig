//!
//! This file provides common color types found on the supported displays.
//!

/// A color type encoding only black and white.
pub const BlackWhite = enum(u1) {
    black = 0,
    white = 1,
};

pub const RGB565 = Color(.{ u5, u6, u5 });
pub const RGB888 = Color(.{ u8, u8, u8 });

/// Provides a namespace with the default colors for the given `Color` type.
pub fn Color(comptime Ts: [3]type) type {
    return packed struct {
        const Self = @This();

        r: Ts[0],
        g: Ts[1],
        b: Ts[2],

        pub const black: Self = .from_rgb(0x00, 0x00, 0x00);
        pub const white: Self = .from_rgb(0xFF, 0xFF, 0xFF);
        pub const red: Self = .from_rgb(0xFF, 0x00, 0x00);
        pub const green: Self = .from_rgb(0x00, 0xFF, 0x00);
        pub const blue: Self = .from_rgb(0x00, 0x00, 0xFF);
        pub const cyan: Self = .from_rgb(0x00, 0xFF, 0xFF);
        pub const magenta: Self = .from_rgb(0xFF, 0x00, 0xFF);
        pub const yellow: Self = .from_rgb(0xFF, 0xFF, 0x00);

        pub fn from_rgb(r: u8, g: u8, b: u8) Self {
            return Self{
                .r = @truncate(r >> (8 - @bitSizeOf(Ts[0]))),
                .g = @truncate(g >> (8 - @bitSizeOf(Ts[1]))),
                .b = @truncate(b >> (8 - @bitSizeOf(Ts[2]))),
            };
        }
    };
}
