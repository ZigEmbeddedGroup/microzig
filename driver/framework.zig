//!
//! The driver framework provides device-independent drivers for peripherials supported by MicroZig.
//!

pub const display = struct {
    pub const ssd1306 = @import("display/ssd1306.zig");
    pub const st77xx = @import("display/st77xx.zig");

    // Export generic drivers:
    pub const SSD1306_I2C = ssd1306.SSD1306_I2C;
    pub const ST7735 = st77xx.ST7735;
    pub const ST7789 = st77xx.ST7789;

    // Export color types:
    pub const colors = @import("display/colors.zig");
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
        // const xpt2046 = @import("input/touch/xpt2046.zig");
    };
};

pub const wireless = struct {
    // pub const sx1278 = @import("wireless/sx1278.zig");
};

pub const base = struct {
    pub const Datagram_Device = @import("base/Datagram_Device.zig");
    pub const Stream_Device = @import("base/Stream_Device.zig");
    pub const Digital_IO = @import("base/Digital_IO.zig");
};

test {
    _ = display.ssd1306;
    _ = display.st77xx;

    _ = input.keyboard_matrix;
    _ = input.debounced_button;
    _ = input.rotary_encoder;

    _ = base.Datagram_Device;
    _ = base.Stream_Device;
    _ = base.Digital_IO;
}
