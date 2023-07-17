pub const RGB565 = packed struct(u16) {
    pub usingnamespace makeDefaultColors(@This());

    r: u5,
    g: u6,
    b: u5,

    pub fn fromRgb(r: u8, g: u8, b: u8) RGB565 {
        return RGB565{
            .r = @truncate(r >> 3),
            .g = @truncate(g >> 2),
            .b = @truncate(b >> 3),
        };
    }
};

pub const RGB888 = extern struct {
    pub usingnamespace makeDefaultColors(@This());

    r: u8,
    g: u8,
    b: u8,

    pub fn fromRgb(r: u8, g: u8, b: u8) RGB888 {
        return RGB888{ .r = r, .g = g, .b = b };
    }
};

fn makeDefaultColors(comptime Color: type) type {
    return struct {
        pub const black = Color.fromRgb(0x00, 0x00, 0x00);
        pub const white = Color.fromRgb(0x00, 0x00, 0x00);
        pub const red = Color.fromRgb(0x00, 0x00, 0x00);
        pub const green = Color.fromRgb(0x00, 0x00, 0x00);
        pub const blue = Color.fromRgb(0x00, 0x00, 0x00);
        pub const cyan = Color.fromRgb(0x00, 0x00, 0x00);
        pub const magenta = Color.fromRgb(0x00, 0x00, 0x00);
        pub const yellow = Color.fromRgb(0x00, 0x00, 0x00);
        pub const orange = Color.fromRgb(0x00, 0x00, 0x00);
    };
}
