const std = @import("std");
const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const gpio_v2 = microzig.chip.types.peripherals.gpio_v2;
const OSPEEDR = gpio_v2.OSPEEDR;

const gpio = @import("gpio.zig");

pub const Pin = enum {
    PIN0,
    PIN1,
    PIN2,
    PIN3,
    PIN4,
    PIN5,
    PIN6,
    PIN7,
    PIN8,
    PIN9,
    PIN10,
    PIN11,
    PIN12,
    PIN13,
    PIN14,
    PIN15,
    pub const Configuration = struct {
        name: ?[:0]const u8 = null,
        mode: ?gpio.Mode = null,
        speed: ?OSPEEDR = null,
    };
};

pub const InputGPIO = struct {
    pin: gpio.Pin,
    pub inline fn read(self: @This()) u1 {
        const port = self.pin.get_port();
        return if (port.IDR.raw & gpio.mask() != 0)
            1
        else
            0;
    }
};

pub const OutputGPIO = struct {
    pin: gpio.Pin,

    pub inline fn put(self: @This(), value: u1) void {
        var port = self.pin.get_port();
        switch (value) {
            0 => port.BSRR.raw = @intCast(self.pin.mask() << 16),
            1 => port.BSRR.raw = self.pin.mask(),
        }
    }

    pub inline fn low(self: @This()) void {
        self.put(0);
    }

    pub inline fn high(self: @This()) void {
        self.put(1);
    }

    pub inline fn toggle(self: @This()) void {
        var port = self.pin.get_port();
        port.ODR.raw ^= self.pin.mask();
    }
};

pub const AlternateFunction = struct {
    // Empty on perpose it should not be used as a GPIO.
};

const Analog = struct {
    pin: gpio.Pin,
};

pub fn GPIO(comptime mode: gpio.Mode) type {
    return switch (mode) {
        .input => InputGPIO,
        .output => OutputGPIO,
        .alternate_function => AlternateFunction,
        .analog => Analog,
    };
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin_field = StructField{
                            .is_comptime = false,
                            .default_value_ptr = null,

                            // initialized below:
                            .name = undefined,
                            .type = undefined,
                            .alignment = undefined,
                        };

                        pin_field.name = pin_config.name orelse field.name;
                        pin_field.type = GPIO(pin_config.mode orelse .{ .input = .{.floating} });
                        pin_field.alignment = @alignOf(field.type);

                        fields = fields ++ &[_]StructField{pin_field};
                    }
                }
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
}

pub const Port = enum {
    GPIOA,
    GPIOB,
    GPIOC,
    GPIOD,
    GPIOE,
    GPIOF,
    GPIOG,
    pub const Configuration = struct {
        PIN0: ?Pin.Configuration = null,
        PIN1: ?Pin.Configuration = null,
        PIN2: ?Pin.Configuration = null,
        PIN3: ?Pin.Configuration = null,
        PIN4: ?Pin.Configuration = null,
        PIN5: ?Pin.Configuration = null,
        PIN6: ?Pin.Configuration = null,
        PIN7: ?Pin.Configuration = null,
        PIN8: ?Pin.Configuration = null,
        PIN9: ?Pin.Configuration = null,
        PIN10: ?Pin.Configuration = null,
        PIN11: ?Pin.Configuration = null,
        PIN12: ?Pin.Configuration = null,
        PIN13: ?Pin.Configuration = null,
        PIN14: ?Pin.Configuration = null,
        PIN15: ?Pin.Configuration = null,

        comptime {
            const pin_field_count = @typeInfo(Pin).@"enum".fields.len;
            const config_field_count = @typeInfo(Configuration).@"struct".fields.len;
            if (pin_field_count != config_field_count)
                @compileError(comptimePrint("{} {}", .{ pin_field_count, config_field_count }));
        }
    };
};

pub const GlobalConfiguration = struct {
    GPIOA: ?Port.Configuration = null,
    GPIOB: ?Port.Configuration = null,
    GPIOC: ?Port.Configuration = null,
    GPIOD: ?Port.Configuration = null,
    GPIOE: ?Port.Configuration = null,
    GPIOF: ?Port.Configuration = null,
    GPIOG: ?Port.Configuration = null,

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".fields.len;
        const config_field_count = @typeInfo(GlobalConfiguration).@"struct".fields.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        var ret: Pins(config) = undefined;

        comptime var used_gpios: u16 = 0;

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                _ = port_config;
                const port = @intFromEnum(@field(Port, port_field.name));
                used_gpios |= 1 << port;
            }
        }

        if (used_gpios != 0) {
            RCC.AHBENR.modify(.{
                .GPIOAEN = 0b1 & used_gpios,
                .GPIOBEN = 0b1 & (used_gpios >> 1),
                .GPIOCEN = 0b1 & (used_gpios >> 2),
                .GPIODEN = 0b1 & (used_gpios >> 3),
                .GPIOEEN = 0b1 & (used_gpios >> 4),
                .GPIOFEN = 0b1 & (used_gpios >> 5),
                .GPIOGEN = 0b1 & (used_gpios >> 6),
                .GPIOHEN = 0b1 & (used_gpios >> 7),
            });
        }

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        const port = @intFromEnum(@field(Port, port_field.name));
                        var pin = gpio.Pin.from_port(@enumFromInt(port), @intFromEnum(@field(Pin, field.name)));
                        pin.set_mode(pin_config.mode.?);
                        switch (pin_config.mode orelse .input) {
                            .input => @field(ret, pin_config.name orelse field.name) = InputGPIO{ .pin = pin },
                            .output => @field(ret, pin_config.name orelse field.name) = OutputGPIO{ .pin = pin },
                            .analog => @field(ret, pin_config.name orelse field.name) = Analog{},
                            .alternate_function => @field(ret, pin_config.name orelse field.name) = AlternateFunction{},
                        }
                    }
                }
            }
        }

        return ret;
    }
};
