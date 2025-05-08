const std = @import("std");
const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");
const SIO = microzig.chip.peripherals.SIO;

const chip = @import("compatibility.zig").chip;

const gpio = @import("gpio.zig");
const pwm = @import("pwm.zig");
const adc = @import("adc.zig");
const resets = @import("resets.zig");

pub const Pin = if (chip == .RP2350_QFN80) enum {
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    GPIO4,
    GPIO5,
    GPIO6,
    GPIO7,
    GPIO8,
    GPIO9,
    GPIO10,
    GPIO11,
    GPIO12,
    GPIO13,
    GPIO14,
    GPIO15,
    GPIO16,
    GPIO17,
    GPIO18,
    GPIO19,
    GPIO20,
    GPIO21,
    GPIO22,
    GPIO23,
    GPIO24,
    GPIO25,
    GPIO26,
    GPIO27,
    GPIO28,
    GPIO29,
    GPIO30,
    GPIO31,
    GPIO32,
    GPIO33,
    GPIO34,
    GPIO35,
    GPIO36,
    GPIO37,
    GPIO38,
    GPIO39,
    GPIO40,
    GPIO41,
    GPIO42,
    GPIO43,
    GPIO44,
    GPIO45,
    GPIO46,
    GPIO47,

    pub const Configuration = PinConfiguration;
    pub const count = 48;
} else enum {
    GPIO0,
    GPIO1,
    GPIO2,
    GPIO3,
    GPIO4,
    GPIO5,
    GPIO6,
    GPIO7,
    GPIO8,
    GPIO9,
    GPIO10,
    GPIO11,
    GPIO12,
    GPIO13,
    GPIO14,
    GPIO15,
    GPIO16,
    GPIO17,
    GPIO18,
    GPIO19,
    GPIO20,
    GPIO21,
    GPIO22,
    GPIO23,
    GPIO24,
    GPIO25,
    GPIO26,
    GPIO27,
    GPIO28,
    GPIO29,

    pub const Configuration = PinConfiguration;
    pub const count = 30;
};

const PinConfiguration = struct {
    name: ?[:0]const u8 = null,
    function: Function = .SIO,
    direction: ?gpio.Direction = null,
    drive_strength: ?gpio.DriveStrength = null,
    pull: ?gpio.Pull = null,
    slew_rate: ?gpio.SlewRate = null,
    // input/output enable
    // schmitt trigger
    // hysteresis

    pub fn get_direction(comptime config: PinConfiguration) gpio.Direction {
        return if (config.direction) |direction|
            direction
        else if (comptime config.function.is_pwm())
            .out
        else if (comptime config.function.is_uart_tx())
            .out
        else if (comptime config.function.is_uart_rx())
            .in
        else if (comptime config.function.is_adc())
            .in
        else
            @panic("TODO");
    }
};

pub const Function = if (chip == .RP2350_QFN80) enum {
    SIO,

    PIO0,
    PIO1,
    PIO2,

    SPI0_RX,
    SPI0_CSn,
    SPI0_SCK,
    SPI0_TX,

    SPI1_RX,
    SPI1_CSn,
    SPI1_SCK,
    SPI1_TX,

    UART0_TX,
    UART0_RX,
    UART0_CTS,
    UART0_RTS,

    UART1_TX,
    UART1_RX,
    UART1_CTS,
    UART1_RTS,

    I2C0_SDA,
    I2C0_SCL,

    I2C1_SDA,
    I2C1_SCL,

    PWM0_A,
    PWM0_B,

    PWM1_A,
    PWM1_B,

    PWM2_A,
    PWM2_B,

    PWM3_A,
    PWM3_B,

    PWM4_A,
    PWM4_B,

    PWM5_A,
    PWM5_B,

    PWM6_A,
    PWM6_B,

    PWM7_A,
    PWM7_B,

    PWM8_A,
    PWM8_B,

    PWM9_A,
    PWM9_B,

    PWM10_A,
    PWM10_B,

    PWM11_A,
    PWM11_B,

    CLOCK_GPIN0,
    CLOCK_GPIN1,

    CLOCK_GPOUT0,
    CLOCK_GPOUT1,
    CLOCK_GPOUT2,
    CLOCK_GPOUT3,

    USB_OVCUR_DET,
    USB_VBUS_DET,
    USB_VBUS_EN,

    ADC0,
    ADC1,
    ADC2,
    ADC3,
    ADC4,
    ADC5,
    ADC6,
    ADC7,

    pub const is_uart_tx = function_is_uart_tx;
    pub const is_uart_rx = function_is_uart_rx;
    pub const is_spi = function_is_spi;
    pub const is_i2c = function_is_i2c;

    pub fn is_adc(function: Function) bool {
        return switch (function) {
            .ADC0,
            .ADC1,
            .ADC2,
            .ADC3,
            .ADC4,
            .ADC5,
            .ADC6,
            .ADC7,
            => true,
            else => false,
        };
    }

    pub fn is_pio(function: Function) bool {
        return switch (function) {
            .PIO0,
            .PIO1,
            .PIO2,
            => true,
            else => false,
        };
    }

    fn is_pwm(function: Function) bool {
        return switch (function) {
            .PWM0_A,
            .PWM0_B,
            .PWM1_A,
            .PWM1_B,
            .PWM2_A,
            .PWM2_B,
            .PWM3_A,
            .PWM3_B,
            .PWM4_A,
            .PWM4_B,
            .PWM5_A,
            .PWM5_B,
            .PWM6_A,
            .PWM6_B,
            .PWM7_A,
            .PWM7_B,
            .PWM8_A,
            .PWM8_B,
            .PWM9_A,
            .PWM9_B,
            .PWM10_A,
            .PWM10_B,
            .PWM11_A,
            .PWM11_B,
            => true,
            else => false,
        };
    }

    fn pwm_channel(comptime function: Function) pwm.Channel {
        return switch (function) {
            .PWM0_A,
            .PWM1_A,
            .PWM2_A,
            .PWM3_A,
            .PWM4_A,
            .PWM5_A,
            .PWM6_A,
            .PWM7_A,
            .PWM8_A,
            .PWM9_A,
            .PWM10_A,
            .PWM11_A,
            => .a,
            .PWM0_B,
            .PWM1_B,
            .PWM2_B,
            .PWM3_B,
            .PWM4_B,
            .PWM5_B,
            .PWM6_B,
            .PWM7_B,
            .PWM8_B,
            .PWM9_B,
            .PWM10_B,
            .PWM11_B,
            => .b,
            else => @compileError("not pwm"),
        };
    }
} else enum {
    SIO,

    PIO0,
    PIO1,

    SPI0_RX,
    SPI0_CSn,
    SPI0_SCK,
    SPI0_TX,

    SPI1_RX,
    SPI1_CSn,
    SPI1_SCK,
    SPI1_TX,

    UART0_TX,
    UART0_RX,
    UART0_CTS,
    UART0_RTS,

    UART1_TX,
    UART1_RX,
    UART1_CTS,
    UART1_RTS,

    I2C0_SDA,
    I2C0_SCL,

    I2C1_SDA,
    I2C1_SCL,

    PWM0_A,
    PWM0_B,

    PWM1_A,
    PWM1_B,

    PWM2_A,
    PWM2_B,

    PWM3_A,
    PWM3_B,

    PWM4_A,
    PWM4_B,

    PWM5_A,
    PWM5_B,

    PWM6_A,
    PWM6_B,

    PWM7_A,
    PWM7_B,

    CLOCK_GPIN0,
    CLOCK_GPIN1,

    CLOCK_GPOUT0,
    CLOCK_GPOUT1,
    CLOCK_GPOUT2,
    CLOCK_GPOUT3,

    USB_OVCUR_DET,
    USB_VBUS_DET,
    USB_VBUS_EN,

    ADC0,
    ADC1,
    ADC2,
    ADC3,

    pub const is_uart_tx = function_is_uart_tx;
    pub const is_uart_rx = function_is_uart_rx;
    pub const is_spi = function_is_spi;
    pub const is_i2c = function_is_i2c;

    pub fn is_adc(function: Function) bool {
        return switch (function) {
            .ADC0,
            .ADC1,
            .ADC2,
            .ADC3,
            => true,
            else => false,
        };
    }

    pub fn is_pio(function: Function) bool {
        return switch (function) {
            .PIO0,
            .PIO1,
            => true,
            else => false,
        };
    }

    fn is_pwm(function: Function) bool {
        return switch (function) {
            .PWM0_A,
            .PWM0_B,
            .PWM1_A,
            .PWM1_B,
            .PWM2_A,
            .PWM2_B,
            .PWM3_A,
            .PWM3_B,
            .PWM4_A,
            .PWM4_B,
            .PWM5_A,
            .PWM5_B,
            .PWM6_A,
            .PWM6_B,
            .PWM7_A,
            .PWM7_B,
            => true,
            else => false,
        };
    }

    fn pwm_channel(comptime function: Function) pwm.Channel {
        return switch (function) {
            .PWM0_A,
            .PWM1_A,
            .PWM2_A,
            .PWM3_A,
            .PWM4_A,
            .PWM5_A,
            .PWM6_A,
            .PWM7_A,
            => .a,
            .PWM0_B,
            .PWM1_B,
            .PWM2_B,
            .PWM3_B,
            .PWM4_B,
            .PWM5_B,
            .PWM6_B,
            .PWM7_B,
            => .b,
            else => @compileError("not pwm"),
        };
    }
};

fn function_is_uart_tx(function: Function) bool {
    return switch (function) {
        .UART0_TX,
        .UART1_TX,
        => true,
        else => false,
    };
}

fn function_is_uart_rx(function: Function) bool {
    return switch (function) {
        .UART0_RX,
        .UART1_RX,
        => true,
        else => false,
    };
}

fn function_is_spi(function: Function) bool {
    return switch (function) {
        .SPI0_RX,
        .SPI0_CSn,
        .SPI0_SCK,
        .SPI0_TX,
        .SPI1_RX,
        .SPI1_CSn,
        .SPI1_SCK,
        .SPI1_TX,
        => true,
        else => false,
    };
}

fn function_is_i2c(function: Function) bool {
    return switch (function) {
        .I2C0_SDA,
        .I2C0_SCL,
        .I2C1_SDA,
        .I2C1_SCL,
        => true,
        else => false,
    };
}

fn function_pwm_slice(comptime function: Function) u32 {
    return switch (function) {
        .PWM0_A, .PWM0_B => 0,
        .PWM1_A, .PWM1_B => 1,
        .PWM2_A, .PWM2_B => 2,
        .PWM3_A, .PWM3_B => 3,
        .PWM4_A, .PWM4_B => 4,
        .PWM5_A, .PWM5_B => 5,
        .PWM6_A, .PWM6_B => 6,
        .PWM7_A, .PWM7_B => 7,
        else => @compileError("not pwm"),
    };
}

fn all() [Pin.count]u1 {
    var ret: [Pin.count]u1 = undefined;
    for (&ret) |*elem|
        elem.* = 1;

    return ret;
}

fn list(gpio_list: []const u5) [Pin.count]u1 {
    var ret = std.mem.zeroes([Pin.count]u1);
    for (gpio_list) |num|
        ret[num] = 1;

    return ret;
}

fn single(gpio_num: u5) [Pin.count]u1 {
    var ret = std.mem.zeroes([Pin.count]u1);
    ret[gpio_num] = 1;
    return ret;
}

const function_table = if (chip == .RP2350_QFN80)
    [_][Pin.count]u1{
        all(), // SIO
        all(), // PIO0
        all(), // PIO1
        all(), // PIO2
        list(&.{ 0, 4, 16, 20, 32, 36 }), // SPI0_RX
        list(&.{ 1, 5, 17, 21, 33, 37 }), // SPI0_CSn
        list(&.{ 2, 6, 18, 22, 34, 38 }), // SPI0_SCK
        list(&.{ 3, 7, 19, 23, 35, 39 }), // SPI0_TX
        list(&.{ 8, 12, 24, 28, 40, 44 }), // SPI1_RX
        list(&.{ 9, 13, 25, 29, 37, 41 }), // SPI1_CSn
        list(&.{ 10, 14, 26, 30, 42 }), // SPI1_SCK
        list(&.{ 11, 15, 27, 31, 43 }), // SPI1_TX
        list(&.{ 0, 12, 16, 28, 32, 44 }), // UART0_TX
        list(&.{ 1, 13, 17, 29, 33, 45 }), // UART0_RX
        list(&.{ 2, 14, 18, 30, 34, 46 }), // UART0_CTS
        list(&.{ 3, 15, 19, 31, 35, 47 }), // UART0_RTS
        list(&.{ 4, 8, 20, 24, 36, 40 }), // UART1_TX
        list(&.{ 5, 9, 21, 25, 37, 41 }), // UART1_RX
        list(&.{ 6, 10, 22, 26, 38, 42 }), // UART1_CTS
        list(&.{ 7, 11, 23, 27, 39, 43 }), // UART1_RTS
        list(&.{ 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44 }), // I2C0_SDA
        list(&.{ 1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45 }), // I2C0_SCL
        list(&.{ 2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46 }), // I2C1_SDA
        list(&.{ 3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47 }), // I2C1_SCL
        list(&.{ 0, 16 }), // PWM0_A
        list(&.{ 1, 17 }), // PWM0_B
        list(&.{ 2, 18 }), // PWM1_A
        list(&.{ 3, 19 }), // PWM1_B
        list(&.{ 4, 20 }), // PWM2_A
        list(&.{ 5, 21 }), // PWM2_B
        list(&.{ 6, 22 }), // PWM3_A
        list(&.{ 7, 23 }), // PWM3_B
        list(&.{ 8, 24 }), // PWM4_A
        list(&.{ 9, 25 }), // PWM4_B
        list(&.{ 10, 26 }), // PWM5_A
        list(&.{ 11, 27 }), // PWM5_B
        list(&.{ 12, 28 }), // PWM6_A
        list(&.{ 13, 29 }), // PWM6_B
        single(14), // PWM7_A
        single(15), // PWM7_B
        single(20), // CLOCK_GPIN0
        single(22), // CLOCK_GPIN1
        single(21), // CLOCK_GPOUT0
        single(23), // CLOCK_GPOUT1
        single(24), // CLOCK_GPOUT2
        single(25), // CLOCK_GPOUT3
        list(&.{ 0, 3, 6, 9, 12, 15, 18, 21, 24, 27 }), // USB_OVCUR_DET
        list(&.{ 1, 4, 7, 10, 13, 16, 19, 22, 25, 28 }), // USB_VBUS_DET
        list(&.{ 2, 5, 8, 11, 14, 17, 20, 23, 26, 29 }), // USB_VBUS_EN
        single(40), // ADC0
        single(41), // ADC1
        single(42), // ADC2
        single(43), // ADC3
        single(44), // ADC4
        single(45), // ADC5
        single(46), // ADC6
        single(47), // ADC7
    }
else
    [_][Pin.count]u1{
        all(), // SIO
        all(), // PIO0
        all(), // PIO1
        list(&.{ 0, 4, 16, 20 }), // SPI0_RX
        list(&.{ 1, 5, 17, 21 }), // SPI0_CSn
        list(&.{ 2, 6, 18, 22 }), // SPI0_SCK
        list(&.{ 3, 7, 19, 23 }), // SPI0_TX
        list(&.{ 8, 12, 24, 28 }), // SPI1_RX
        list(&.{ 9, 13, 25, 29 }), // SPI1_CSn
        list(&.{ 10, 14, 26 }), // SPI1_SCK
        list(&.{ 11, 15, 27 }), // SPI1_TX
        list(&.{ 0, 12, 16, 28 }), // UART0_TX
        list(&.{ 1, 13, 17, 29 }), // UART0_RX
        list(&.{ 2, 14, 18 }), // UART0_CTS
        list(&.{ 3, 15, 19 }), // UART0_RTS
        list(&.{ 4, 8, 20, 24 }), // UART1_TX
        list(&.{ 5, 9, 21, 25 }), // UART1_RX
        list(&.{ 6, 10, 22, 26 }), // UART1_CTS
        list(&.{ 7, 11, 23, 27 }), // UART1_RTS
        list(&.{ 0, 4, 8, 12, 16, 20, 24, 28 }), // I2C0_SDA
        list(&.{ 1, 5, 9, 13, 17, 21, 25, 29 }), // I2C0_SCL
        list(&.{ 2, 6, 10, 14, 18, 22, 26 }), // I2C1_SDA
        list(&.{ 3, 7, 11, 15, 19, 23, 27 }), // I2C1_SCL
        list(&.{ 0, 16 }), // PWM0_A
        list(&.{ 1, 17 }), // PWM0_B
        list(&.{ 2, 18 }), // PWM1_A
        list(&.{ 3, 19 }), // PWM1_B
        list(&.{ 4, 20 }), // PWM2_A
        list(&.{ 5, 21 }), // PWM2_B
        list(&.{ 6, 22 }), // PWM3_A
        list(&.{ 7, 23 }), // PWM3_B
        list(&.{ 8, 24 }), // PWM4_A
        list(&.{ 9, 25 }), // PWM4_B
        list(&.{ 10, 26 }), // PWM5_A
        list(&.{ 11, 27 }), // PWM5_B
        list(&.{ 12, 28 }), // PWM6_A
        list(&.{ 13, 29 }), // PWM6_B
        single(14), // PWM7_A
        single(15), // PWM7_B
        single(20), // CLOCK_GPIN0
        single(22), // CLOCK_GPIN1
        single(21), // CLOCK_GPOUT0
        single(23), // CLOCK_GPOUT1
        single(24), // CLOCK_GPOUT2
        single(25), // CLOCK_GPOUT3
        list(&.{ 0, 3, 6, 9, 12, 15, 18, 21, 24, 27 }), // USB_OVCUR_DET
        list(&.{ 1, 4, 7, 10, 13, 16, 19, 22, 25, 28 }), // USB_VBUS_DET
        list(&.{ 2, 5, 8, 11, 14, 17, 20, 23, 26, 29 }), // USB_VBUS_EN
        single(26), // ADC0
        single(27), // ADC1
        single(28), // ADC2
        single(29), // ADC3
    };

pub const GlobalConfiguration = if (chip == .RP2350_QFN80) struct {
    GPIO0: ?Pin.Configuration = null,
    GPIO1: ?Pin.Configuration = null,
    GPIO2: ?Pin.Configuration = null,
    GPIO3: ?Pin.Configuration = null,
    GPIO4: ?Pin.Configuration = null,
    GPIO5: ?Pin.Configuration = null,
    GPIO6: ?Pin.Configuration = null,
    GPIO7: ?Pin.Configuration = null,
    GPIO8: ?Pin.Configuration = null,
    GPIO9: ?Pin.Configuration = null,
    GPIO10: ?Pin.Configuration = null,
    GPIO11: ?Pin.Configuration = null,
    GPIO12: ?Pin.Configuration = null,
    GPIO13: ?Pin.Configuration = null,
    GPIO14: ?Pin.Configuration = null,
    GPIO15: ?Pin.Configuration = null,
    GPIO16: ?Pin.Configuration = null,
    GPIO17: ?Pin.Configuration = null,
    GPIO18: ?Pin.Configuration = null,
    GPIO19: ?Pin.Configuration = null,
    GPIO20: ?Pin.Configuration = null,
    GPIO21: ?Pin.Configuration = null,
    GPIO22: ?Pin.Configuration = null,
    GPIO23: ?Pin.Configuration = null,
    GPIO24: ?Pin.Configuration = null,
    GPIO25: ?Pin.Configuration = null,
    GPIO26: ?Pin.Configuration = null,
    GPIO27: ?Pin.Configuration = null,
    GPIO28: ?Pin.Configuration = null,
    GPIO29: ?Pin.Configuration = null,
    GPIO30: ?Pin.Configuration = null,
    GPIO31: ?Pin.Configuration = null,
    GPIO32: ?Pin.Configuration = null,
    GPIO33: ?Pin.Configuration = null,
    GPIO34: ?Pin.Configuration = null,
    GPIO35: ?Pin.Configuration = null,
    GPIO36: ?Pin.Configuration = null,
    GPIO37: ?Pin.Configuration = null,
    GPIO38: ?Pin.Configuration = null,
    GPIO39: ?Pin.Configuration = null,
    GPIO40: ?Pin.Configuration = null,
    GPIO41: ?Pin.Configuration = null,
    GPIO42: ?Pin.Configuration = null,
    GPIO43: ?Pin.Configuration = null,
    GPIO44: ?Pin.Configuration = null,
    GPIO45: ?Pin.Configuration = null,
    GPIO46: ?Pin.Configuration = null,
    GPIO47: ?Pin.Configuration = null,

    pub const PinsType = GlobalConfigurationPinType;
    pub const pins = global_config_pins;
    pub const apply = global_config_apply;
} else struct {
    GPIO0: ?Pin.Configuration = null,
    GPIO1: ?Pin.Configuration = null,
    GPIO2: ?Pin.Configuration = null,
    GPIO3: ?Pin.Configuration = null,
    GPIO4: ?Pin.Configuration = null,
    GPIO5: ?Pin.Configuration = null,
    GPIO6: ?Pin.Configuration = null,
    GPIO7: ?Pin.Configuration = null,
    GPIO8: ?Pin.Configuration = null,
    GPIO9: ?Pin.Configuration = null,
    GPIO10: ?Pin.Configuration = null,
    GPIO11: ?Pin.Configuration = null,
    GPIO12: ?Pin.Configuration = null,
    GPIO13: ?Pin.Configuration = null,
    GPIO14: ?Pin.Configuration = null,
    GPIO15: ?Pin.Configuration = null,
    GPIO16: ?Pin.Configuration = null,
    GPIO17: ?Pin.Configuration = null,
    GPIO18: ?Pin.Configuration = null,
    GPIO19: ?Pin.Configuration = null,
    GPIO20: ?Pin.Configuration = null,
    GPIO21: ?Pin.Configuration = null,
    GPIO22: ?Pin.Configuration = null,
    GPIO23: ?Pin.Configuration = null,
    GPIO24: ?Pin.Configuration = null,
    GPIO25: ?Pin.Configuration = null,
    GPIO26: ?Pin.Configuration = null,
    GPIO27: ?Pin.Configuration = null,
    GPIO28: ?Pin.Configuration = null,
    GPIO29: ?Pin.Configuration = null,

    pub const PinsType = GlobalConfigurationPinType;
    pub const pins = global_config_pins;
    pub const apply = global_config_apply;
};

// comptime {
//     const pin_field_count = @typeInfo(Pin).@"enum".fields.len;
//     const config_field_count = @typeInfo(GlobalConfiguration).@"struct".fields.len;
//     if (pin_field_count != config_field_count)
//         @compileError(comptimePrint("{} {}", .{ pin_field_count, config_field_count }));
// }

/// This function is called at compile time to generate the type of the
/// structure that is returned by the `pins` function.
fn GlobalConfigurationPinType(comptime self: GlobalConfiguration) type {
    var fields: []const StructField = &.{};
    for (@typeInfo(GlobalConfiguration).@"struct".fields) |field| {
        if (@field(self, field.name)) |pin_config| {
            var pin_field = StructField{
                .is_comptime = false,
                .default_value_ptr = null,

                // initialized below:
                .name = undefined,
                .type = undefined,
                .alignment = undefined,
            };

            pin_field.name = pin_config.name orelse field.name;
            if (pin_config.function == .SIO) {
                pin_field.type = gpio.Pin;
            } else if (pin_config.function.is_pwm()) {
                pin_field.type = pwm.Pwm;
            } else if (pin_config.function.is_adc()) {
                pin_field.type = adc.Input;
            } else {
                continue;
            }

            pin_field.alignment = @alignOf(field.type);

            fields = fields ++ &[_]StructField{pin_field};
        }
    }

    return @Type(.{
        .@"struct" = .{
            .layout = .auto,
            .is_tuple = false,
            .fields = fields,
            .decls = &.{},
        },
    });
}

// Can be called at comptime or runtime it returns a structure of the type
// generated by `GlobalConfigurationPinType` that describes the pins.
fn global_config_pins(comptime self: GlobalConfiguration) self.PinsType() {
    var ret: self.PinsType() = undefined;
    inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |field| {
        if (@field(self, field.name)) |pin_config| {
            if (pin_config.function == .SIO) {
                @field(ret, pin_config.name orelse field.name) = gpio.num(@intFromEnum(@field(Pin, field.name)));
            } else if (pin_config.function.is_pwm()) {
                @field(ret, pin_config.name orelse field.name) = pwm.Pwm{
                    .slice_number = pin_config.function.pwm_slice(),
                    .channel = pin_config.function.pwm_channel(),
                };
            } else if (pin_config.function.is_adc()) {
                @field(ret, pin_config.name orelse field.name) = @as(adc.Input, @enumFromInt(switch (pin_config.function) {
                    .ADC0 => 0,
                    .ADC1 => 1,
                    .ADC2 => 2,
                    .ADC3 => 3,
                    .ADC4 => if (chip == .RP2350_QFN80) 4 else unreachable,
                    .ADC5 => if (chip == .RP2350_QFN80) 5 else unreachable,
                    else => unreachable,
                }));
            }
        }
    }

    return ret;
}

/// This function is called at runtime to apply the global configuration to
/// the hardware.
fn global_config_apply(comptime config: GlobalConfiguration) void {
    comptime var input_gpios: u32 = 0;
    comptime var output_gpios: u32 = 0;
    comptime var has_adc = false;
    comptime var has_pwm = false;

    // validate selected function
    comptime {
        for (@typeInfo(GlobalConfiguration).@"struct".fields) |field|
            if (@field(config, field.name)) |pin_config| {
                const gpio_num = @intFromEnum(@field(Pin, field.name));
                if (0 == function_table[@intFromEnum(pin_config.function)][gpio_num])
                    @compileError(comptimePrint("{s} cannot be configured for {}", .{ field.name, pin_config.function }));

                if (pin_config.function == .SIO) {
                    switch (pin_config.get_direction()) {
                        .in => input_gpios |= 1 << gpio_num,
                        .out => output_gpios |= 1 << gpio_num,
                    }
                }

                if (pin_config.function.is_adc()) {
                    has_adc = true;
                }
                if (pin_config.function.is_pwm()) {
                    has_pwm = true;
                }
            };
    }

    // TODO: ensure only one instance of an input function exists

    const used_gpios = comptime input_gpios | output_gpios;

    if (used_gpios != 0) {
        SIO.GPIO_OE_CLR.raw = used_gpios;
        SIO.GPIO_OUT_CLR.raw = used_gpios;
    }

    inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |field| {
        if (@field(config, field.name)) |pin_config| {
            const pin = gpio.num(@intFromEnum(@field(Pin, field.name)));
            const func = pin_config.function;

            // xip = 0,
            // spi,
            // uart,
            // i2c,
            // pio0,
            // pio1,
            // pio2 (rp2350 only)
            // gpck,
            // usb,
            // uart_alt (rp2350 only)
            // @"null" = 0x1f,

            if (func == .SIO) {
                pin.set_function(.sio);
            } else if (comptime func.is_pwm()) {
                pin.set_function(.pwm);
            } else if (comptime func.is_adc()) {
                // Matches adc.Input.configure_gpio_pin
                pin.set_function(.disabled);
                pin.set_pull(.disabled);
                pin.set_input_enabled(false);
            } else if (comptime func.is_uart_tx() or func.is_uart_rx()) {
                // TODO: Handle pins that can be used with an alternate uart function
                pin.set_function(.uart);
            } else if (comptime func.is_spi()) {
                pin.set_function(.spi);
            } else if (comptime func.is_i2c()) {
                pin.set_function(.i2c);
            } else {
                @compileError(std.fmt.comptimePrint("Unimplemented pin function. Please implement setting pin function {s} for GPIO {}", .{
                    @tagName(func),
                    @intFromEnum(pin),
                }));
            }
        }
    }

    if (output_gpios != 0)
        SIO.GPIO_OE_SET.raw = output_gpios;

    if (input_gpios != 0) {
        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |field|
            if (@field(config, field.name)) |pin_config| {
                const gpio_num = @intFromEnum(@field(Pin, field.name));
                const pull = pin_config.pull orelse continue;
                if (comptime pin_config.get_direction() != .in)
                    @compileError("Only input pins can have pull up/down enabled");

                gpio.num(gpio_num).set_pull(pull);
            };
    }

    if (has_adc) {
        // FIXME: https://github.com/ZigEmbeddedGroup/microzig/issues/311
        // adc.init();
    }
}
