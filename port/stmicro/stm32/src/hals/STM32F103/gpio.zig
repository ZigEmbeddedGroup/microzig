const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

const GPIOA = peripherals.GPIOA;
const GPIOB = peripherals.GPIOB;
const GPIOC = peripherals.GPIOC;
const GPIOD = peripherals.GPIOD;
const GPIOE = peripherals.GPIOE;
const GPIOF = peripherals.GPIOF;
const GPIOG = peripherals.GPIOG;

const GPIO = @TypeOf(GPIOA);

const log = std.log.scoped(.gpio);

pub const Function = enum {};

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
pub const Pin = packed struct(u8) {
    number: u4,
    port: u3,
    padding: u1,

    pub fn init(port: u3, number: u4) Pin {
        return Pin{
            .number = number,
            .port = port,
            .padding = 0,
        };
    }
    inline fn write_pin_config(gpio: Pin, config: u32) void {
        const port = gpio.get_port();
        if (gpio.number <= 7) {
            const offset = @as(u5, gpio.number) << 2;
            port.CR[0].raw &= ~(@as(u32, 0b1111) << offset);
            port.CR[0].raw |= config << offset;
        } else {
            const offset = (@as(u5, gpio.number) - 8) << 2;
            port.CR[1].raw &= ~(@as(u32, 0b1111) << offset);
            port.CR[1].raw |= config << offset;
        }
    }

    fn mask(gpio: Pin) u16 {
        return @as(u16, 1) << gpio.number;
    }

    // NOTE: Im not sure I like this
    //       We could probably calculate an offset from GPIOA?
    pub fn get_port(gpio: Pin) GPIO {
        return switch (gpio.port) {
            0 => GPIOA,
            1 => GPIOB,
            2 => GPIOC,
            3 => GPIOD,
            4 => GPIOE,
            //5 => GPIOF,
            //6 => GPIOG,
            else => @panic("The STM32 only has ports 0..6 (A..G)"),
        };
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
};
