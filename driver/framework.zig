//!

pub const display = struct {
    pub const ssd1306 = @import("display/ssd1306.zig");
    pub const ili9488 = @import("display/ili9488.zig");
    pub const st77xx = @import("display/st77xx.zig");

    // Export generic drivers:
    pub const SSD1306 = ssd1306.SSD1306;
    pub const ST7735 = st77xx.ST7735;
    pub const ST7789 = st77xx.ST7789;

    // Export color types:
    const colors_ns = @import("display/colors.zig");

    pub const BlackAndWhite = enum(u1) { black = 0, white = 1 };

    pub const RGB565 = colors_ns.RGB565;
    pub const RGB888 = colors_ns.RGB888;
};

pub const input = struct {
    pub const rotary_encoder = @import("input/rotary-encoder.zig");
    pub const keyboard_matrix = @import("input/keyboard-matrix.zig");
    pub const debounced_button = @import("input/debounced-button.zig");

    // Export generic drivers:
    pub const Key = keyboard_matrix.Key;
    pub const KeyboardMatrix = keyboard_matrix.KeyboardMatrix;
    pub const DebouncedButton = debounced_button.DebouncedButton;
    pub const RotaryEncoder = rotary_encoder.RotaryEncoder;

    pub const touch = struct {
        const xpt2046 = @import("input/touch/xpt2046.zig");
    };
};

pub const wireless = struct {
    pub const sx1278 = @import("wireless/sx1278.zig");
};

pub const base = struct {
    pub const DatagramDevice = @import("base/DatagramDevice.zig");
    pub const StreamDevice = @import("base/StreamDevice.zig");
    pub const DigitalIO = @import("base/DigitalIO.zig");
};

test {
    _ = display.ssd1306;
    _ = display.ili9488;
    _ = display.st77xx;

    _ = input.keyboard_matrix;
    _ = input.debounced_button;
    _ = input.rotary_encoder;

    _ = input.touch.xpt2046;

    _ = wireless.sx1278;

    _ = base.DatagramDevice;
    _ = base.StreamDevice;
    _ = base.DigitalIO;
}
