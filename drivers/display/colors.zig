//!
//! This file provides common color types found on the supported displays.
//!

/// A color type encoding only black and white.
pub const BlackWhite = enum(u1) {
    black = 0,
    white = 1,
};

pub const RGB565 = packed struct(u16) {
    pub usingnamespace DefaultColors(@This());

    r: u5,
    g: u6,
    b: u5,

    pub fn from_rgb(r: u8, g: u8, b: u8) RGB565 {
        return RGB565{
            .r = @truncate(r >> 3),
            .g = @truncate(g >> 2),
            .b = @truncate(b >> 3),
        };
    }
};

pub const RGB888 = extern struct {
    pub usingnamespace DefaultColors(@This());

    r: u8,
    g: u8,
    b: u8,

    pub fn from_rgb(r: u8, g: u8, b: u8) RGB888 {
        return RGB888{ .r = r, .g = g, .b = b };
    }
};

/// Provides a namespace with the default colors for the given `Color` type.
pub fn DefaultColors(comptime Color: type) type {
    return struct {
        pub const black = Color.from_rgb(0x00, 0x00, 0x00);
        pub const white = Color.from_rgb(0xFF, 0xFF, 0xFF);
        pub const red = Color.from_rgb(0xFF, 0x00, 0x00);
        pub const green = Color.from_rgb(0x00, 0xFF, 0x00);
        pub const blue = Color.from_rgb(0x00, 0x00, 0xFF);
        pub const cyan = Color.from_rgb(0x00, 0xFF, 0xFF);
        pub const magenta = Color.from_rgb(0xFF, 0x00, 0xFF);
        pub const yellow = Color.from_rgb(0xFF, 0xFF, 0x00);
    };
}
