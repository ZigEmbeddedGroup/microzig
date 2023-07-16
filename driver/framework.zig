//!

pub const display = struct {
    const ssd1306_ns = @import("display/ssd1306.zig");

    pub const ssd1306 = ssd1306_ns.ssd1306;
    pub const SSD1306 = ssd1306_ns.SSD1306;

    pub const ili9488 = @import("display/ili9488.zig");
    pub const st7735 = @import("display/st7735.zig");
};

pub const input = struct {
    pub const rotary_encoder = @import("input/rotary-encoder.zig");
    pub const keyboard_matrix = @import("input/keyboard-matrix.zig");

    pub const touch = struct {
        const xpt2046 = @import("input/touch/xpt2046.zig");
    };
};

pub const wireless = struct {
    pub const sx1278 = @import("wireless/sx1278.zig");
};
