const std = @import("std");
const gpio = @import("gpio.zig");
const pwm = @import("pwm.zig");
const adc = @import("adc.zig");
const resets = @import("resets.zig");
const regs = @import("microzig").chip.registers;

const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

pub const Pin = enum {
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

    pub const Configuration = struct {
        name: ?[]const u8 = null,
        function: Function = .SIO,
        direction: ?gpio.Direction = null,
        drive_strength: ?gpio.DriveStrength = null,
        pull: ?enum { up, down } = null,
        slew_rate: ?gpio.SlewRate = null,
        // input/output enable
        // schmitt trigger
        // hysteresis

        pub fn getDirection(comptime config: Configuration) gpio.Direction {
            return if (config.direction) |direction|
                direction
            else if (comptime config.function.isPwm())
                .out
            else if (comptime config.function.isUartTx())
                .out
            else if (comptime config.function.isUartRx())
                .in
            else if (comptime config.function.isAdc())
                .in
            else
                @panic("TODO");
        }
    };
};

pub const Function = enum {
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

    pub fn isPwm(function: Function) bool {
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

    pub fn isUartTx(function: Function) bool {
        return switch (function) {
            .UART0_TX,
            .UART1_TX,
            => true,
            else => false,
        };
    }

    pub fn isUartRx(function: Function) bool {
        return switch (function) {
            .UART0_RX,
            .UART1_RX,
            => true,
            else => false,
        };
    }

    pub fn pwmSlice(comptime function: Function) u32 {
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

    pub fn isAdc(function: Function) bool {
        return switch (function) {
            .ADC0,
            .ADC1,
            .ADC2,
            .ADC3,
            => true,
            else => false,
        };
    }

    pub fn pwmChannel(comptime function: Function) pwm.Channel {
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

fn all() [30]u1 {
    var ret: [30]u1 = undefined;
    for (ret) |*elem|
        elem.* = 1;

    return ret;
}

fn list(gpio_list: []const u5) [30]u1 {
    var ret = std.mem.zeroes([30]u1);
    for (gpio_list) |num|
        ret[num] = 1;

    return ret;
}

fn single(gpio_num: u5) [30]u1 {
    var ret = std.mem.zeroes([30]u1);
    ret[gpio_num] = 1;
    return ret;
}

const function_table = [@typeInfo(Function).Enum.fields.len][30]u1{
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
    list(&.{ 0, 11, 16, 28 }), // UART0_TX
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

pub fn GPIO(comptime num: u5, comptime direction: gpio.Direction) type {
    return switch (direction) {
        .in => struct {
            const gpio_num = num;

            pub inline fn read(self: @This()) u1 {
                _ = self;
                return gpio.read(gpio_num);
            }
        },
        .out => struct {
            const gpio_num = num;

            pub inline fn put(self: @This(), value: u1) void {
                _ = self;
                gpio.put(gpio_num, value);
            }

            pub inline fn toggle(self: @This()) void {
                _ = self;
                gpio.toggle(gpio_num);
            }
        },
    };
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).Struct.fields) |field| {
            if (@field(config, field.name)) |pin_config| {
                var pin_field = StructField{
                    .is_comptime = false,
                    .default_value = null,

                    // initialized below:
                    .name = undefined,
                    .field_type = undefined,
                    .alignment = undefined,
                };

                if (pin_config.function == .SIO) {
                    pin_field.name = pin_config.name orelse field.name;
                    pin_field.field_type = GPIO(@enumToInt(@field(Pin, field.name)), pin_config.direction orelse .in);
                } else if (pin_config.function.isPwm()) {
                    pin_field.name = pin_config.name orelse @tagName(pin_config.function);
                    pin_field.field_type = pwm.PWM(pin_config.function.pwmSlice(), pin_config.function.pwmChannel());
                } else if (pin_config.function.isAdc()) {
                    pin_field.name = pin_config.name orelse @tagName(pin_config.function);
                    pin_field.field_type = adc.Input;
                    pin_field.default_value = @ptrCast(?*const anyopaque, switch (pin_config.function) {
                        .ADC0 => &adc.Input.ain0,
                        .ADC1 => &adc.Input.ain1,
                        .ADC2 => &adc.Input.ain2,
                        .ADC3 => &adc.Input.ain3,
                        else => unreachable,
                    });
                } else {
                    continue;
                }

                // if (pin_field.default_value == null) {
                //     if (@sizeOf(pin_field.field_type) > 0) {
                //         pin_field.default_value = @ptrCast(?*const anyopaque, &pin_field.field_type{});
                //     } else {
                //         const Struct = struct {
                //             magic_field: pin_field.field_type = .{},
                //         };
                //         pin_field.default_value = @typeInfo(Struct).Struct.fields[0].default_value;
                //     }
                // }

                pin_field.alignment = @alignOf(field.field_type);

                fields = fields ++ &[_]StructField{pin_field};
            }
        }

        return @Type(.{
            .Struct = .{
                .layout = .Auto,
                .is_tuple = false,
                .fields = fields,
                .decls = &.{},
            },
        });
    }
}

pub const GlobalConfiguration = struct {
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

    comptime {
        const pin_field_count = @typeInfo(Pin).Enum.fields.len;
        const config_field_count = @typeInfo(GlobalConfiguration).Struct.fields.len;
        if (pin_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ pin_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        comptime var input_gpios: u32 = 0;
        comptime var output_gpios: u32 = 0;
        comptime var has_adc = false;
        comptime var has_pwm = false;

        // validate selected function
        comptime {
            inline for (@typeInfo(GlobalConfiguration).Struct.fields) |field|
                if (@field(config, field.name)) |pin_config| {
                    const gpio_num = @enumToInt(@field(Pin, field.name));
                    if (0 == function_table[@enumToInt(pin_config.function)][gpio_num])
                        @compileError(comptimePrint("{s} cannot be configured for {}", .{ field.name, pin_config.function }));

                    if (pin_config.function == .SIO) {
                        switch (pin_config.getDirection()) {
                            .in => input_gpios |= 1 << gpio_num,
                            .out => output_gpios |= 1 << gpio_num,
                        }
                    }

                    if (pin_config.function.isAdc()) {
                        has_adc = true;
                    }
                    if (pin_config.function.isPwm()) {
                        has_pwm = true;
                    }
                };
        }

        // TODO: ensure only one instance of an input function exists

        const used_gpios = comptime input_gpios | output_gpios;
        gpio.reset();

        if (used_gpios != 0) {
            regs.SIO.GPIO_OE_CLR.raw = used_gpios;
            regs.SIO.GPIO_OUT_CLR.raw = used_gpios;
        }

        inline for (@typeInfo(GlobalConfiguration).Struct.fields) |field| {
            if (@field(config, field.name)) |pin_config| {
                const gpio_num = @enumToInt(@field(Pin, field.name));
                const func = pin_config.function;

                // xip = 0,
                // spi,
                // uart,
                // i2c,
                // pio0,
                // pio1,
                // gpck,
                // usb,
                // @"null" = 0x1f,

                if (func == .SIO) {
                    gpio.setFunction(gpio_num, .sio);
                } else if (comptime func.isPwm()) {
                    gpio.setFunction(gpio_num, .pwm);
                } else if (comptime func.isAdc()) {
                    gpio.setFunction(gpio_num, .@"null");
                } else if (comptime func.isUartTx() or func.isUartRx()) {
                    gpio.setFunction(gpio_num, .uart);
                } else {
                    @compileError(comptime std.fmt.comptimePrint("Unimplemented pin function. Please implement setting pin function {s} for GPIO {}", .{
                        @tagName(func),
                        gpio_num,
                    }));
                }
            }
        }

        if (output_gpios != 0)
            regs.SIO.GPIO_OE_SET.raw = output_gpios;

        if (input_gpios != 0) {
            inline for (@typeInfo(GlobalConfiguration).Struct.fields) |field|
                if (@field(config, field.name)) |pin_config| {
                    const pull = pin_config.pull orelse continue;
                    if (comptime pin_config.getDirection() != .in)
                        @compileError("Only input pins can have pull up/down enabled");

                    const gpio_regs = @field(regs.PADS_BANK0, field.name);
                    gpio_regs.modify(comptime .{
                        .PUE = @boolToInt(pull == .up),
                        .PDE = @boolToInt(pull == .down),
                    });
                };
        }

        if (has_pwm) {
            resets.reset(&.{.pwm});
        }

        if (has_adc) {
            adc.init();
        }

        // fields in the Pins(config) type should be zero sized, so we just
        // default build them all (wasn't sure how to do that cleanly in
        // `Pins()`
        var ret: Pins(config) = undefined;
        inline for (@typeInfo(Pins(config)).Struct.fields) |field| {
            if (field.default_value) |default_value| {
                @field(ret, field.name) = @ptrCast(*const field.field_type, default_value).*;
            } else {
                @field(ret, field.name) = .{};
            }
        }

        return ret;
    }
};
