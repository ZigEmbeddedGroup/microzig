const std = @import("std");
const microzig = @import("microzig");

const assert = std.debug.assert;
pub const peripherals = microzig.chip.peripherals;

const gpio_v2 = microzig.chip.types.peripherals.gpio_v2;
const GPIO = gpio_v2.GPIO;
const MODER = gpio_v2.MODER;
const PUPDR = gpio_v2.PUPDR;
const OT = gpio_v2.OT;
const AFIO = microzig.chip.peripherals.AFIO;

pub const Function = enum {};

pub const Port = enum {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
};

pub const Mode = union(enum) {
    input: InputMode,
    output: OutputMode,
    analog: AnalogMode,
    alternate_function: AlternateFunction,
};

pub const InputMode = struct {
    resistor: PUPDR,
};

pub const OutputMode = struct { resistor: PUPDR, o_type: OT };

pub const AnalogMode = enum(u2) {
    //todo
    _,
};

pub const AF = enum(u4) {
    AF0,
    AF1,
    AF2,
    AF3,
    AF4,
    AF5,
    AF6,
    AF7,
};

pub const AlternateFunction = struct {
    afr: AF,
    resistor: PUPDR = .Floating,
    o_type: OT = .PushPull,
};

// This is mostly internal to hal for writing configuration.
// Public implementation is provided in the pins.zig file.
pub const Pin = enum(usize) {
    _,

    inline fn write_pin_config(gpio: Pin, mode: Mode) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        const modMask: u32 = @as(u32, 0b11) << (pin << 1);
        const afrMask: u32 = @as(u32, 0b1111) << ((pin % 8) << 2);

        switch (mode) {
            .input => |imode| {
                port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @intFromEnum(MODER.Input)) << (pin << 1));
                port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @intFromEnum(imode.resistor)) << (pin << 1));
            },
            .output => |omode| {
                port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @intFromEnum(MODER.Output)) << (pin << 1));
                port.OTYPER.write_raw((port.OTYPER.raw & ~gpio.mask()) | @as(u32, @intFromEnum(omode.o_type)) << pin);
                port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @intFromEnum(omode.resistor)) << (pin << 1));
            },
            .analog => {},
            .alternate_function => |afmode| {
                port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @intFromEnum(MODER.Alternate)) << (pin << 1));
                port.OTYPER.write_raw((port.OTYPER.raw & ~gpio.mask()) | @as(u32, @intFromEnum(afmode.o_type)) << pin);
                port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @intFromEnum(afmode.resistor)) << (pin << 1));
                const register = if (pin > 7) &port.AFR[1] else &port.AFR[0];
                register.write_raw((register.raw & ~afrMask) | @as(u32, @intFromEnum(afmode.afr)) << ((pin % 8) << 2));
            },
        }
    }

    pub fn mask(gpio: Pin) u32 {
        const pin: u4 = @intCast(@intFromEnum(gpio) % 16);
        return @as(u32, 1) << pin;
    }

    //NOTE: should invalid pins panic or just be ignored?
    pub fn get_port(gpio: Pin) *volatile GPIO {
        const port: usize = @divFloor(@intFromEnum(gpio), 16);
        switch (port) {
            0 => return if (@hasDecl(peripherals, "GPIOA")) peripherals.GPIOA else @panic("Invalid Pin"),
            1 => return if (@hasDecl(peripherals, "GPIOB")) peripherals.GPIOB else @panic("Invalid Pin"),
            2 => return if (@hasDecl(peripherals, "GPIOC")) peripherals.GPIOC else @panic("Invalid Pin"),
            3 => return if (@hasDecl(peripherals, "GPIOD")) peripherals.GPIOD else @panic("Invalid Pin"),
            4 => return if (@hasDecl(peripherals, "GPIOE")) peripherals.GPIOE else @panic("Invalid Pin"),
            5 => return if (@hasDecl(peripherals, "GPIOF")) peripherals.GPIOF else @panic("Invalid Pin"),
            6 => return if (@hasDecl(peripherals, "GPIOG")) peripherals.GPIOG else @panic("Invalid Pin"),
            else => @panic("The STM32 only has ports 0..6 (A..G)"),
        }
    }

    pub inline fn set_mode(gpio: Pin, mode: Mode) void {
        gpio.write_pin_config(mode);
    }

    pub fn from_port(port: Port, pin: u4) Pin {
        const value: usize = pin + (@as(usize, 16) * @intFromEnum(port));
        return @enumFromInt(value);
    }
};
