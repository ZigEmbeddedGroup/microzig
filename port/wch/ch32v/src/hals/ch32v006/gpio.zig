const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

// The CH32V00X MCUs have all four GPIO ports.
// [CH32V00X Reference Manual - 1.1 Bus Architecture].
const GPIOA = peripherals.GPIOA; // Pin 0~7
const GPIOB = peripherals.GPIOB; // Pin 0~6
const GPIOC = peripherals.GPIOC; // Pin 0~7
const GPIOD = peripherals.GPIOD; // Pin 0~7

const GPIO = @TypeOf(GPIOA);

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

// The CH32V00X pins support only a single output speed of 30 MHz.
// [CH32V00X Reference Manual - 7.3.1.1 Port Configuration Register Low]
pub const Speed = enum(u1) {
    reserved,
    max_30MHz,
};

pub const Pull = enum {
    up,
    down,
};

// See note in ../ch32v003/gpio.zig#L48
pub const Pin = packed struct(u8) {
    number: u3,
    port: u2,
    padding: u3 = 0,

    pub fn init(port: u2, number: u3) Pin {
        return Pin{
            .number = number,
            .port = port,
        };
    }

    inline fn write_pin_config(gpio: Pin, config: u32) void {
        const port = gpio.get_port();
        const offset = @as(u5, gpio.number) << 2; // number * 4
        port.CFGLR.raw &= ~(@as(u32, 0b1111) << offset);
        port.CFGLR.raw |= config << offset;
    }

    fn mask(gpio: Pin) u16 {
        return @as(u16, 1) << gpio.number;
    }

    // See note in ../ch32v003/gpio.zig#L75
    pub fn get_port(gpio: Pin) GPIO {
        return switch (gpio.port) {
            0 => GPIOA,
            1 => GPIOB,
            2 => GPIOC,
            3 => GPIOD,
        };
    }

    pub inline fn set_mode(gpio: Pin, mode: Mode) void {
        switch (mode) {
            .input => |in| gpio.set_input_mode(in),
            .output => |out| gpio.set_output_mode(out, .max_30MHz),
        }
    }

    pub inline fn set_input_mode(gpio: Pin, mode: InputMode) void {
        const m_mode = @as(u32, @backingInt(mode));
        const config: u32 = m_mode << 2;
        gpio.write_pin_config(config);
    }

    pub inline fn set_output_mode(gpio: Pin, mode: OutputMode, speed: Speed) void {
        const s_speed = @as(u32, @backingInt(speed));
        const m_mode = @as(u32, @backingInt(mode));
        const config: u32 = s_speed + (m_mode << 2);
        gpio.write_pin_config(config);
    }

    pub inline fn set_pull(gpio: Pin, pull: Pull) void {
        var port = gpio.get_port();
        switch (pull) {
            .up => port.BSHR.raw = gpio.mask(),
            .down => port.BCR.raw = gpio.mask(),
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
            // BCR: Port Reset Register. the corresponding OUTDR pins are cleared.
            0 => port.BCR.raw = gpio.mask(),
            // BSHR: Port Set/Reset Register, the location bits will make the corresponding OUTDR
            // pins. Note: the [23:16] bits could also be used to clear the pins instead of BCR.
            // [CH32V003/CH32V00X Reference Manual - 7.3.1 GPIO Register Description]
            1 => port.BSHR.raw = gpio.mask(),
        }
    }

    pub inline fn toggle(gpio: Pin) void {
        var port = gpio.get_port();
        port.OUTDR.raw ^= gpio.mask();
    }
};
