const std = @import("std");
const microzig = @import("microzig");

const assert = std.debug.assert;
pub const peripherals = microzig.chip.peripherals;

const gpio_v2 = microzig.chip.types.peripherals.gpio_v2;
const GPIO = gpio_v2.GPIO;
const MODER = gpio_v2.MODER;
const PUPDR = gpio_v2.PUPDR;
const OSPEEDR = gpio_v2.OSPEEDR;
const OT = gpio_v2.OT;
const AFIO = microzig.chip.peripherals.AFIO;

pub const Port = enum {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
};

pub const Mode = union(enum) {
    input: InputMode,
    output: OutputMode,
    analog: AnalogMode,
    alternate_function: AlternateFunction,
    digital_io: Digital_IO,
};

pub const Digital_IO = struct {};

pub const InputMode = struct {
    resistor: PUPDR,
};

pub const OutputMode = struct {
    resistor: PUPDR,
    o_type: OT,
    o_speed: OSPEEDR = .LowSpeed,
};

pub const AnalogMode = struct {
    resistor: PUPDR = .Floating,
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
    AF8,
    AF9,
    AF10,
    AF11,
    AF12,
    AF13,
    AF14,
    AF15,
};

pub const AlternateFunction = struct {
    afr: AF,
    resistor: PUPDR = .Floating,
    o_type: OT = .PushPull,
    o_speed: OSPEEDR = .HighSpeed,
};

// This is mostly internal to hal for writing configuration.
// Public implementation is provided in the pins.zig file.
pub const Pin = enum(usize) {
    _,

    pub inline fn write_pin_config(gpio: Pin, mode: Mode) void {
        switch (mode) {
            .input => |imode| {
                gpio.set_moder(MODER.Input);
                gpio.set_bias(imode.resistor);
            },
            .output => |omode| {
                gpio.set_moder(MODER.Output);
                gpio.set_output_type(omode.o_type);
                gpio.set_bias(omode.resistor);
                gpio.set_speed(omode.o_speed);
            },
            .analog => |amode| {
                gpio.set_moder(MODER.Analog);
                gpio.set_bias(amode.resistor);
            },
            .alternate_function => |afmode| {
                gpio.set_moder(MODER.Alternate);
                gpio.set_bias(afmode.resistor);
                gpio.set_speed(afmode.o_speed);
                gpio.set_output_type(afmode.o_type);
                gpio.set_alternate_function(afmode.afr);
            },
            .digital_io => {
                // Nothing for now
            },
        }
    }

    pub fn mask_2bit(gpio: Pin) u32 {
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        return @as(u32, 0b11) << (pin << 1);
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
            7 => return if (@hasDecl(peripherals, "GPIOH")) peripherals.GPIOH else @panic("Invalid Pin"),
            8 => return if (@hasDecl(peripherals, "GPIOI")) peripherals.GPIOI else @panic("Invalid Pin"),
            9 => return if (@hasDecl(peripherals, "GPIOJ")) peripherals.GPIOJ else @panic("Invalid Pin"),
            10 => return if (@hasDecl(peripherals, "GPIOK")) peripherals.GPIOK else @panic("Invalid Pin"),
            else => @panic("The STM32 GPIO_v2 only has ports 0..10 (A..K)"),
        }
    }

    pub inline fn set_bias(gpio: Pin, bias: PUPDR) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        const modMask: u32 = gpio.mask_2bit();

        port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @intFromEnum(bias)) << (pin << 1));
    }

    pub inline fn set_speed(gpio: Pin, speed: OSPEEDR) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        const modMask: u32 = gpio.mask_2bit();

        port.OSPEEDR.write_raw((port.OSPEEDR.raw & ~modMask) | @as(u32, @intFromEnum(speed)) << (pin << 1));
    }

    pub inline fn set_moder(gpio: Pin, moder: MODER) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        const modMask: u32 = gpio.mask_2bit();

        port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @intFromEnum(moder)) << (pin << 1));
    }

    pub inline fn set_output_type(gpio: Pin, otype: OT) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);

        port.OTYPER.write_raw((port.OTYPER.raw & ~gpio.mask()) | @as(u32, @intFromEnum(otype)) << pin);
    }

    pub inline fn set_alternate_function(gpio: Pin, afr: AF) void {
        const port = gpio.get_port();
        const pin: u5 = @intCast(@intFromEnum(gpio) % 16);
        const afrMask: u32 = @as(u32, 0b1111) << ((pin % 8) << 2);
        const register = if (pin > 7) &port.AFR[1] else &port.AFR[0];
        register.write_raw((register.raw & ~afrMask) | @as(u32, @intFromEnum(afr)) << ((pin % 8) << 2));
    }

    pub fn from_port(port: Port, pin: u4) Pin {
        const value: usize = pin + (@as(usize, 16) * @intFromEnum(port));
        return @enumFromInt(value);
    }

    pub inline fn put(self: Pin, value: u1) void {
        var port = self.get_port();
        switch (value) {
            0 => port.BSRR.raw = @intCast(self.mask() << 16),
            1 => port.BSRR.raw = self.mask(),
        }
    }

    pub inline fn low(self: @This()) void {
        self.put(0);
    }

    pub inline fn high(self: @This()) void {
        self.put(1);
    }

    pub inline fn toggle(self: Pin) void {
        var port = self.get_port();
        port.ODR.raw ^= self.mask();
    }

    pub inline fn read(self: Pin) u1 {
        const port = self.get_port();
        return @intFromBool((port.IDR.raw & self.mask() != 0));
    }
};
