const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

const GPIOA = peripherals.GPIOA;
const GPIOB = peripherals.GPIOB;
const GPIOC = peripherals.GPIOC;
const GPIOD = peripherals.GPIOD; // GPIOD has only 3 pins.

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
    alternate_function_push_pull, // multiplexing_
    alternate_function_open_drain, // multiplexing_
};

pub const Speed = enum(u2) {
    reserved,
    max_10MHz,
    max_2MHz,
    max_50MHz,
};

// pub const DriveStrength = enum(u1) {
//     low,
//     high,
// };

pub const Pull = enum {
    up,
    down,
};

// NOTE: With this current setup, every time we want to do anythting we go through a switch
//       Do we want this?
// NOTE: How about to use port_config_mask, _value as previous apply function?
pub const Pin = packed struct(u8) {
    number: u4,
    port: u2,
    padding: u2 = 0,

    pub fn init(port: u2, number: u4) Pin {
        return Pin{
            .number = number,
            .port = port,
        };
    }

    // TODO:
    inline fn write_pin_config(gpio: Pin, config: u32) void {
        const port = gpio.get_port();
        if (gpio.number <= 7) {
            const offset = @as(u5, gpio.number) << 2; // number * 4
            port.CFGLR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGLR.raw |= config << offset;
        } else {
            const offset = (@as(u5, gpio.number) - 8) << 2; // number * 4
            port.CFGHR.raw &= ~(@as(u32, 0b1111) << offset);
            port.CFGHR.raw |= config << offset;
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
            // else => @panic("The CH32V[12]03 has only ports A..D"),
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
            // 0 => port.BSHR.raw = gpio.mask() << 16, // BR
            0 => port.BCR.raw = gpio.mask(), // clear, accessed only 16bit form
            1 => port.BSHR.raw = gpio.mask(), // BS
        }
    }

    pub inline fn toggle(gpio: Pin) void {
        var port = gpio.get_port();
        port.OUTDR.raw ^= gpio.mask(); // mask: 0 => stay, 1 => flip
    }
};
