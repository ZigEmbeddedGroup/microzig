const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
pub const peripherals = microzig.chip.peripherals;

const GPIO = microzig.chip.types.peripherals.gpio_v1.GPIO;
const AFIO = microzig.chip.peripherals.AFIO;

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

    fn mask(gpio: Pin) u32 {
        const pin: u4 = @intCast(@intFromEnum(gpio) % 16);
        return @as(u32, 1) << pin;
    }

    // NOTE: Im not sure I like this
    //       We could probably calculate an offset from GPIOA?

    //NOTE 2025-3-8: the reference manual states that this GPIO implementation should work with the F101/102/103 families....
    //so just check if the field exists

    //NOTE: should invalid pins panic or just be ignored?
    pub fn get_port(gpio: Pin) *volatile GPIO {
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
            0 => port.BSRR.raw = @intCast(gpio.mask() << 16),
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

/// Enables the EVENTOUT Cortex® output on the selected pin.
/// NOTE: not available for GPIO F and G
pub fn enable_cortex_EVENTOUT(pin: Pin) void {
    const port: u3 = @intCast(@divFloor(@intFromEnum(pin), 16));
    const ev_pin: u4 = @intCast(@intFromEnum(pin) % 16);

    AFIO.EVCR.modify(.{
        .PIN = ev_pin,
        .PORT = port,
        .EVOE = 1,
    });
}

pub inline fn disable_cortex_EVENTOUT() void {
    AFIO.EVCR.modify_one("EVOE", 0);
}

pub const PartialRemap = enum(u2) {
    Normal,
    Partial_Remap_1,
    Partial_Remap_2,
    Full_Remap,
};

pub const DebugRemap = enum(u3) {
    Full_SWJ,
    Full_SWJ_No_NJTRST,
    Only_SWDP,
    Off = 0b100,
};

///low-, medium- high- and XL-density devices only
pub const Remap = union(enum) {
    SPI1: bool,
    I2C1: bool,
    USART1: bool,
    USART2: bool,
    USART3: PartialRemap,
    TIM1: PartialRemap,
    TIM2: PartialRemap,
    TIM3: PartialRemap,
    TIM4: bool,
    CAN: PartialRemap,
    PD01: bool,
    TIM5CH4: bool,
    ADC1_ETRGINJ: bool,
    ADC1_ETRGREG: bool,
    ADC2_ETRGINJ: bool,
    ADC2_ETRGREG: bool,
    SWJ: DebugRemap,

    // MAPR2
    TIM9_CH1: bool,
    TIM10_CH1: bool,
    TIM11_CH1: bool,
    TIM13_CH1: bool,
    TIM14_CH1: bool,
    FSMC_NADV: bool,
};

pub fn apply_remap(map: Remap) void {
    switch (map) {
        .SPI1 => |val| AFIO.MAPR.modify_one("SPI1_REMAP", @intFromBool(val)),
        .I2C1 => |val| AFIO.MAPR.modify_one("I2C1_REMAP", @intFromBool(val)),
        .USART1 => |val| AFIO.MAPR.modify_one("USART1_REMAP", @intFromBool(val)),
        .USART2 => |val| AFIO.MAPR.modify_one("USART2_REMAP", @intFromBool(val)),
        .USART3 => |val| AFIO.MAPR.modify_one("USART3_REMAP", @intFromEnum(val)),
        .TIM1 => |val| AFIO.MAPR.modify_one("TIM1_REMAP", @intFromEnum(val)),
        .TIM2 => |val| AFIO.MAPR.modify_one("TIM2_REMAP", @intFromEnum(val)),
        .TIM3 => |val| AFIO.MAPR.modify_one("TIM3_REMAP", @intFromEnum(val)),
        .TIM4 => |val| AFIO.MAPR.modify_one("TIM4_REMAP", @intFromBool(val)),
        .CAN => |val| AFIO.MAPR.modify_one("CAN1_REMAP", @intFromEnum(val)),
        .PD01 => |val| AFIO.MAPR.modify_one("PD01_REMAP", @intFromBool(val)),
        .TIM5CH4 => |val| AFIO.MAPR.modify_one("TIM5CH4_IREMAP", @intFromBool(val)),
        .ADC1_ETRGINJ => |val| AFIO.MAPR.modify_one("ADC1_ETRGINJ_REMAP", @intFromBool(val)),
        .ADC1_ETRGREG => |val| AFIO.MAPR.modify_one("ADC1_ETRGREG_REMAP", @intFromBool(val)),
        .ADC2_ETRGINJ => |val| AFIO.MAPR.modify_one("ADC2_ETRGINJ_REMAP", @intFromBool(val)),
        .ADC2_ETRGREG => |val| AFIO.MAPR.modify_one("ADC2_ETRGREG_REMAP", @intFromBool(val)),
        .SWJ => |val| AFIO.MAPR.modify_one("SWJ_CFG", @intFromEnum(val)),
        .TIM9_CH1 => |val| AFIO.MAPR2.modify_one("TIM9_REMAP", @intFromBool(val)),
        .TIM10_CH1 => |val| AFIO.MAPR2.modify_one("TIM10_REMAP", @intFromBool(val)),
        .TIM11_CH1 => |val| AFIO.MAPR2.modify_one("TIM11_REMAP", @intFromBool(val)),
        .TIM13_CH1 => |val| AFIO.MAPR2.modify_one("TIM13_REMAP", @intFromBool(val)),
        .TIM14_CH1 => |val| AFIO.MAPR2.modify_one("TIM14_REMAP", @intFromBool(val)),
        .FSMC_NADV => |val| AFIO.MAPR2.modify_one("FSMC_NADV", @intFromBool(val)),
    }
}
