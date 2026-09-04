//! Seeed Studio XIAO ESP32C6
//!
//! https://wiki.seeedstudio.com/xiao_esp32c6_getting_started/
//!
//! The pin map matches the one in the arduino-esp32 variant for this board:
//! https://github.com/espressif/arduino-esp32/blob/master/variants/XIAO_ESP32C6/pins_arduino.h

const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

comptime {
    if (!std.mem.eql(u8, microzig.config.chip_name, "ESP32-C6"))
        @compileError("the XIAO ESP32C6 board definition only fits the ESP32-C6");
}

/// Frequency of the crystal on this board.
pub const xtal_freq = 40_000_000;

/// Size of the on module flash.
pub const flash_size = 4 * 1024 * 1024;

/// The eleven pads broken out on the castellated edges, in board order. D0 to D2 double as the
/// analog inputs, the rest carry the default bus assignments of the XIAO form factor.
pub const pins = struct {
    pub const d0 = gpio.num(0);
    pub const d1 = gpio.num(1);
    pub const d2 = gpio.num(2);
    pub const d3 = gpio.num(21);
    pub const d4 = gpio.num(22);
    pub const d5 = gpio.num(23);
    pub const d6 = gpio.num(16);
    pub const d7 = gpio.num(17);
    pub const d8 = gpio.num(19);
    pub const d9 = gpio.num(20);
    pub const d10 = gpio.num(18);
};

/// Pads that reach an ADC channel.
pub const analog = struct {
    pub const a0 = pins.d0;
    pub const a1 = pins.d1;
    pub const a2 = pins.d2;
};

/// Default I2C pads of the XIAO form factor.
pub const i2c = struct {
    pub const sda = pins.d4;
    pub const scl = pins.d5;
};

/// Default UART pads of the XIAO form factor.
pub const uart = struct {
    pub const tx = pins.d6;
    pub const rx = pins.d7;
};

/// Default SPI pads of the XIAO form factor.
pub const spi = struct {
    pub const sck = pins.d8;
    pub const miso = pins.d9;
    pub const mosi = pins.d10;
    pub const cs = pins.d3;
};

/// Pads of the usb serial/jtag controller, brought out on the USB-C connector. They are not
/// usable as gpio while the controller is enabled.
pub const usb = struct {
    pub const dm = gpio.num(12);
    pub const dp = gpio.num(13);
};

/// Held low during reset to enter the rom download mode.
pub const boot = gpio.num(9);

/// The yellow user led. It sits between 3V3 and the pad, so the pin has to be driven low to
/// light it up.
pub const led = gpio.num(15);

/// Configures the user led pad as an output. The led starts out off.
pub fn init_led() void {
    led.apply(.{ .output_enable = true });
    set_led(false);
}

/// Drives the user led. The pad has to be configured as an output first, `init_led` does that.
pub fn set_led(on: bool) void {
    led.put(@intFromBool(!on));
}

/// The rf switch in front of the 2.4 GHz radio. The module carries a ceramic antenna and a
/// U.FL connector for an external one.
pub const antenna = struct {
    pub const Selection = enum {
        /// The ceramic antenna on the module. This is what the board comes up with.
        internal,
        /// An antenna on the U.FL connector.
        external,
    };

    /// Powers the rf switch. Active low.
    pub const power = gpio.num(3);

    /// Picks which antenna the rf switch connects. Low is the internal one.
    pub const select = gpio.num(14);

    /// Powers up the rf switch and points it at one of the two antennas.
    pub fn apply(selection: Selection) void {
        power.apply(.{ .output_enable = true });
        power.put(0);

        select.apply(.{ .output_enable = true });
        select.put(switch (selection) {
            .internal => 0,
            .external => 1,
        });
    }
};
