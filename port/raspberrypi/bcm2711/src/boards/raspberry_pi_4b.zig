//! Raspberry Pi 4 Model B
//!
//! https://www.raspberrypi.com/products/raspberry-pi-4-model-b/
//!
//! Put the built `kernel8.img` on the boot partition of an otherwise normal Raspberry Pi OS card
//! next to the firmware files (`start4.elf`, `fixup4.dat`, `bcm2711-rpi-4-b.dtb`) and a
//! `config.txt` holding at least:
//!
//! ```
//! arm_64bit=1
//! kernel=kernel8.img
//! ```

const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

comptime {
    if (!std.mem.eql(u8, microzig.config.chip_name, "BCM2711"))
        @compileError("the Raspberry Pi 4B board definition only fits the BCM2711");
}

/// The 40 pin header, by BCM pin number rather than by physical position. Only the gpio pins are
/// listed, the power and ground pins have no number.
pub const header = struct {
    pub const pin3 = gpio.num(2);
    pub const pin5 = gpio.num(3);
    pub const pin7 = gpio.num(4);
    pub const pin8 = gpio.num(14);
    pub const pin10 = gpio.num(15);
    pub const pin11 = gpio.num(17);
    pub const pin12 = gpio.num(18);
    pub const pin13 = gpio.num(27);
    pub const pin15 = gpio.num(22);
    pub const pin16 = gpio.num(23);
    pub const pin18 = gpio.num(24);
    pub const pin19 = gpio.num(10);
    pub const pin21 = gpio.num(9);
    pub const pin22 = gpio.num(25);
    pub const pin23 = gpio.num(11);
    pub const pin24 = gpio.num(8);
    pub const pin26 = gpio.num(7);
    pub const pin27 = gpio.num(0);
    pub const pin28 = gpio.num(1);
    pub const pin29 = gpio.num(5);
    pub const pin31 = gpio.num(6);
    pub const pin32 = gpio.num(12);
    pub const pin33 = gpio.num(13);
    pub const pin35 = gpio.num(19);
    pub const pin36 = gpio.num(16);
    pub const pin37 = gpio.num(26);
    pub const pin38 = gpio.num(20);
    pub const pin40 = gpio.num(21);
};

/// Serial console on the header. This is where the PL011 lands once `hal.uart.apply` puts the
/// pads in alt0, and it is what a usb to serial cable on pins 8, 10 and 6 talks to.
pub const uart = struct {
    /// Header pin 8.
    pub const tx = header.pin8;
    /// Header pin 10.
    pub const rx = header.pin10;
};

/// Default I2C1 pads, header pins 3 and 5.
pub const i2c = struct {
    pub const sda = header.pin3;
    pub const scl = header.pin5;
};

/// Default SPI0 pads.
pub const spi = struct {
    /// Header pin 23.
    pub const sclk = header.pin23;
    /// Header pin 21.
    pub const miso = header.pin21;
    /// Header pin 19.
    pub const mosi = header.pin19;
    /// Header pin 24.
    pub const ce0 = header.pin24;
    /// Header pin 26.
    pub const ce1 = header.pin26;
};

/// NOTE: unlike on earlier models, the green ACT led of a Raspberry Pi 4B does not hang off a
/// BCM gpio. It sits behind the gpio expander of the VideoCore, which is only reachable through
/// the firmware mailbox, so this port cannot drive it yet. Wire an led to a header pin instead.
pub const act_led = {};
