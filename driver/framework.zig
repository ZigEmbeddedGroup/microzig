//!

pub const display = struct {
    pub const ssd1306 = @import("display/ssd1306.zig");
    pub const ili9488 = @import("display/ili9488.zig");
    pub const st7735 = @import("display/st7735.zig");

    // Export generic drivers:
    pub const SSD1306 = ssd1306.SSD1306;
};

pub const input = struct {
    pub const rotary_encoder = @import("input/rotary-encoder.zig");
    pub const keyboard_matrix = @import("input/keyboard-matrix.zig");

    // Export generic drivers:
    pub const Key = keyboard_matrix.Key;
    pub const KeyboardMatrix = keyboard_matrix.KeyboardMatrix;

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
    _ = display.st7735;

    _ = input.keyboard_matrix;
    _ = input.touch.xpt2046;

    _ = wireless.sx1278;

    _ = base.DatagramDevice;
    _ = base.StreamDevice;
    _ = base.DigitalIO;
}
