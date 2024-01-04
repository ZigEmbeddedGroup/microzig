const std = @import("std");
const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;

const gpio = @import("gpio.zig");
// const pwm = @import("pwm.zig");
// const adc = @import("adc.zig");
// const resets = @import("resets.zig");

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
        name: ?[]const u8 = null,
        // function: Function = .SIO,
        mode: ?gpio.Mode = null,
        speed: ?gpio.Speed = null,
        pull: ?gpio.Pull = null,
        // input/output enable
        // schmitt trigger
        // hysteresis

        pub fn get_mode(comptime config: Configuration) gpio.Mode {
            return if (config.mode) |mode|
                mode
                // else if (comptime config.function.is_pwm())
                //     .out
                // else if (comptime config.function.is_uart_tx())
                //     .out
                // else if (comptime config.function.is_uart_rx())
                //     .in
                // else if (comptime config.function.is_adc())
                //     .in
            else
                @panic("TODO");
        }
    };
};

pub fn GPIO(comptime port: u3, comptime num: u4, comptime mode: gpio.Mode) type {
    return switch (mode) {
        .input => struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn read(self: @This()) u1 {
                _ = self;
                return pin.read();
            }
        },
        .output => struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn put(self: @This(), value: u1) void {
                _ = self;
                pin.put(value);
            }

            pub inline fn toggle(self: @This()) void {
                _ = self;
                pin.toggle();
            }
        },
    };
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).Struct.fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                for (@typeInfo(Port.Configuration).Struct.fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin_field = StructField{
                            .is_comptime = false,
                            .default_value = null,

                            // initialized below:
                            .name = undefined,
                            .type = undefined,
                            .alignment = undefined,
                        };

                        pin_field.name = pin_config.name orelse field.name;
                        pin_field.type = GPIO(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)), pin_config.mode orelse .{ .input = .{.floating} });
                        pin_field.alignment = @alignOf(field.type);

                        fields = fields ++ &[_]StructField{pin_field};
                    }
                }
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
            const pin_field_count = @typeInfo(Pin).Enum.fields.len;
            const config_field_count = @typeInfo(Configuration).Struct.fields.len;
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
        const port_field_count = @typeInfo(Port).Enum.fields.len;
        const config_field_count = @typeInfo(GlobalConfiguration).Struct.fields.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        inline for (@typeInfo(GlobalConfiguration).Struct.fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                comptime var input_gpios: u16 = 0;
                comptime var output_gpios: u16 = 0;
                comptime {
                    inline for (@typeInfo(Port.Configuration).Struct.fields) |field|
                        if (@field(port_config, field.name)) |pin_config| {
                            const gpio_num = @intFromEnum(@field(Pin, field.name));

                            switch (pin_config.get_mode()) {
                                .input => input_gpios |= 1 << gpio_num,
                                .output => output_gpios |= 1 << gpio_num,
                            }
                        };
                }

                // TODO: ensure only one instance of an input function exists
                const used_gpios = comptime input_gpios | output_gpios;

                if (used_gpios != 0) {
                    const offset = @intFromEnum(@field(Port, port_field.name)) + 2;
                    const bit = @as(u32, 1 << offset);
                    RCC.APB2ENR.raw |= bit;
                    // Delay after setting
                    _ = RCC.APB2ENR.raw & bit;
                }

                inline for (@typeInfo(Port.Configuration).Struct.fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
                        pin.set_mode(pin_config.mode.?);
                    }
                }

                if (input_gpios != 0) {
                    inline for (@typeInfo(Port.Configuration).Struct.fields) |field|
                        if (@field(port_config, field.name)) |pin_config| {
                            var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field.name)), @intFromEnum(@field(Pin, field.name)));
                            const pull = pin_config.pull orelse continue;
                            if (comptime pin_config.get_mode() != .input)
                                @compileError("Only input pins can have pull up/down enabled");

                            pin.set_pull(pull);
                        };
                }
            }
        }

        // fields in the Pins(config) type should be zero sized, so we just
        // default build them all (wasn't sure how to do that cleanly in
        // `Pins()`
        var ret: Pins(config) = undefined;
        inline for (@typeInfo(Pins(config)).Struct.fields) |field| {
            if (field.default_value) |default_value| {
                @field(ret, field.name) = @as(*const field.field_type, @ptrCast(default_value)).*;
            } else {
                @field(ret, field.name) = .{};
            }
        }
        return ret;
        // validate selected function
    }
};
