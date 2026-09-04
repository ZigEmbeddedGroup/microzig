//! GPIO of the BCM2711.
//!
//! The 58 pins are spread over registers that hold either three bits per pin (the function
//! select) or one bit per pin (set, clear, level), so most of the code here is index arithmetic.

const std = @import("std");
const microzig = @import("microzig");
const GPIO = microzig.chip.peripherals.GPIO;

/// The chip has 58 pins. Only 0 to 27 are brought out on the 40 pin header of a Raspberry Pi,
/// the rest drive on board peripherals.
pub const pin_count = 58;

/// Function of a pin, as selected through GPFSEL.
pub const Function = enum(u3) {
    input = 0b000,
    output = 0b001,
    alt5 = 0b010,
    alt4 = 0b011,
    alt0 = 0b100,
    alt1 = 0b101,
    alt2 = 0b110,
    alt3 = 0b111,
};

/// Pull resistor of a pin.
///
/// NOTE: the BCM2711 sets this directly through GPIO_PUP_PDN_CNTRL_REG. The clocked GPPUD
/// sequence of the older BCM2835 and BCM2837 does not apply to this chip.
pub const Pull = enum(u2) {
    none = 0b00,
    up = 0b01,
    down = 0b10,
};

pub fn num(n: u6) Pin {
    std.debug.assert(n < pin_count);
    return @as(Pin, @fromBackingInt(n));
}

pub const Pin = enum(u6) {
    _,

    pub const Config = struct {
        function: Function = .input,
        pull: Pull = .none,
    };

    pub fn apply(pin: Pin, config: Config) void {
        pin.set_pull(config.pull);
        pin.set_function(config.function);
    }

    pub fn set_function(pin: Pin, function: Function) void {
        const n = @backingInt(pin);
        const reg = &GPIO.GPFSEL[n / 10];
        const shift: u5 = @intCast((n % 10) * 3);

        const mask = @as(u30, 0b111) << shift;
        const value = @as(u30, @backingInt(function)) << shift;

        reg.modify(.{ .FSEL = (reg.read().FSEL & ~mask) | value });
    }

    pub fn set_pull(pin: Pin, pull: Pull) void {
        const n = @backingInt(pin);
        const reg = &GPIO.GPIO_PUP_PDN_CNTRL_REG[n / 16];
        const shift: u5 = @intCast((n % 16) * 2);

        const mask = @as(u32, 0b11) << shift;
        const value = @as(u32, @backingInt(pull)) << shift;

        reg.write(.{ .PUP_PDN = (reg.read().PUP_PDN & ~mask) | value });
    }

    /// Drives an output pin. The set and clear registers ignore zero bits, so there is no read
    /// modify write here and no race against another core.
    pub fn put(pin: Pin, level: u1) void {
        const n = @backingInt(pin);
        const bit = @as(u32, 1) << @intCast(n % 32);

        switch (level) {
            0 => GPIO.GPCLR[n / 32].write(.{ .CLR = bit }),
            1 => GPIO.GPSET[n / 32].write(.{ .SET = bit }),
        }
    }

    pub fn read(pin: Pin) u1 {
        const n = @backingInt(pin);
        return @intCast((GPIO.GPLEV[n / 32].read().LEV >> @intCast(n % 32)) & 1);
    }

    pub fn toggle(pin: Pin) void {
        switch (pin.read()) {
            0 => pin.put(1),
            1 => pin.put(0),
        }
    }
};
