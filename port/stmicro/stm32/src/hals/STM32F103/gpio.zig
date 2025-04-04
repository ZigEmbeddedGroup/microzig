const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

const GPIO = @TypeOf(peripherals.GPIOA);

const log = std.log.scoped(.gpio);

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
};

pub const InputMode = enum(u2) {
    analog,
    floating,
    pull,
    reserved,
};

pub const OutputMode = enum(u2) {
    general_purpose_push_pull,
    general_purpose_open_drain,
    alternate_function_push_pull,
    alternate_function_open_drain,
};

pub const Speed = enum(u2) {
    reserved,
    max_10MHz,
    max_2MHz,
    max_50MHz,
};

pub const IrqLevel = enum(u2) {
    low,
    high,
    fall,
    rise,
};

pub const IrqCallback = fn (gpio: u32, events: u32) callconv(.c) void;

pub const Enabled = enum {
    disabled,
    enabled,
};

pub const Pull = enum {
    up,
    down,
};

// NOTE: With this current setup, every time we want to do anythting we go through a switch
//       Do we want this?
pub const Pin = enum(usize) {
    _,

    inline fn write_pin_config(gpio: Pin, config: u32) void {
        const port = gpio.get_port();
        const pin: u4 = @intCast(@intFromEnum(gpio) % 16);
        if (pin <= 7) {
            const offset = @as(u5, pin) << 2;
            port.CR[0].raw &= ~(@as(u32, 0b1111) << offset);
            port.CR[0].raw |= config << offset;
        } else {
            const offset = (@as(u5, pin) - 8) << 2;
            port.CR[1].raw &= ~(@as(u32, 0b1111) << offset);
            port.CR[1].raw |= config << offset;
        }
    }

    fn mask(gpio: Pin) u16 {
        const pin: u4 = @intCast(@intFromEnum(gpio) % 16);
        return @as(u16, 1) << pin;
    }

    // NOTE: Im not sure I like this
    //       We could probably calculate an offset from GPIOA?

    //NOTE 2025-3-8: the reference manual states that this GPIO implementation should work with the F101/102/103 families....
    //so just check if the field exists

    //NOTE: should invalid pins panic or just be ignored?
    pub fn get_port(gpio: Pin) GPIO {
        const pin: usize = @divFloor(@intFromEnum(gpio), 16);
        switch (pin) {
            0 => return if (@hasDecl(peripherals, "GPIOA")) peripherals.GPIOA else @panic("Invalid Pin"),
            1 => return if (@hasDecl(peripherals, "GPIOB")) peripherals.GPIOB else @panic("Invalid Pin"),
            2 => return if (@hasDecl(peripherals, "GPIOC")) peripherals.GPIOC else @panic("Invalid Pin"),
            3 => return if (@hasDecl(peripherals, "GPIOD")) peripherals.GPIOD else @panic("Invalid Pin"),
            4 => return if (@hasDecl(peripherals, "GPIOE")) peripherals.GPIOA else @panic("Invalid Pin"),
            5 => return if (@hasDecl(peripherals, "GPIOF")) peripherals.GPIOA else @panic("Invalid Pin"),
            6 => return if (@hasDecl(peripherals, "GPIOG")) peripherals.GPIOA else @panic("Invalid Pin"),
            else => @panic("The STM32 only has ports 0..6 (A..G)"),
        }
    }

    pub inline fn set_mode(gpio: Pin, mode: Mode) void {
        switch (mode) {
            .input => |in| gpio.set_input_mode(in),
            .output => |out| gpio.set_output_mode(out, .max_2MHz),
        }
    }

    pub inline fn set_input_mode(gpio: Pin, mode: InputMode) void {
        const m_mode = @as(u32, @intFromEnum(mode));
        const config: u32 = m_mode << 2;
        gpio.write_pin_config(config);
    }

    pub inline fn set_output_mode(gpio: Pin, mode: OutputMode, speed: Speed) void {
        const s_speed = @as(u32, @intFromEnum(speed));
        const m_mode = @as(u32, @intFromEnum(mode));
        const config: u32 = s_speed + (m_mode << 2);
        gpio.write_pin_config(config);
    }

    pub inline fn set_pull(gpio: Pin, pull: Pull) void {
        var port = gpio.get_port();
        switch (pull) {
            .up => port.BSRR.raw = gpio.mask(),
            .down => port.BRR.raw = gpio.mask(),
        }
    }

    pub inline fn read(gpio: Pin) u1 {
        const port = gpio.get_port();
        return if (port.IDR.raw & gpio.mask() != 0)
            1
        else
            0;
    }

    pub inline fn put(gpio: Pin, value: u1) void {
        var port = gpio.get_port();
        switch (value) {
            0 => port.BSRR.raw = gpio.mask() << 16,
            1 => port.BSRR.raw = gpio.mask(),
        }
    }

    pub inline fn toggle(gpio: Pin) void {
        var port = gpio.get_port();
        port.ODR.raw ^= gpio.mask();
    }

    pub fn num(pin: usize) Pin {
        return @enumFromInt(pin);
    }

    pub fn from_port(port: Port, pin: u4) Pin {
        const value: usize = pin + (@as(usize, 16) * @intFromEnum(port));
        return @enumFromInt(value);
    }
};
