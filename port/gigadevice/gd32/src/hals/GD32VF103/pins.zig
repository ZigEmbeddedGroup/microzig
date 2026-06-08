const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;

const microzig = @import("microzig");

const RCU = microzig.chip.peripherals.RCU;

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
        name: ?[:0]const u8 = null,
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
    var count: usize = 0;
    for (@typeInfo(GlobalConfiguration).@"struct".field_names) |port_field_name| {
        if (@field(config, port_field_name)) |port_config| {
            for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name| {
                if (@field(port_config, field_name) != null) {
                    count += 1;
                }
            }
        }
    }

    var field_names: [count][]const u8 = undefined;
    var field_types: [count]type = undefined;
    var field_attrs: [count]std.builtin.Type.Struct.FieldAttributes = undefined;

    var i: usize = 0;
    for (@typeInfo(GlobalConfiguration).@"struct".field_names) |port_field_name| {
        if (@field(config, port_field_name)) |port_config| {
            for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name| {
                if (@field(port_config, field_name)) |pin_config| {
                    field_names[i] = pin_config.name orelse field_name;
                    field_types[i] = GPIO(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)), pin_config.mode orelse .{ .input = .{.floating} });
                    field_attrs[i] = .{};

                    i += 1;
                }
            }
        }
    }

    return @Struct(.auto, null, &field_names, &field_types, &field_attrs);
}

pub const Port = enum {
    GPIOA,
    GPIOB,
    GPIOC,
    GPIOD,
    GPIOE,
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
            const pin_field_count = @typeInfo(Pin).@"enum".field_names.len;
            const config_field_count = @typeInfo(Configuration).@"struct".field_names.len;
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

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".field_names.len;
        const config_field_count = @typeInfo(GlobalConfiguration).@"struct".field_names.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        inline for (@typeInfo(GlobalConfiguration).@"struct".field_names) |port_field_name| {
            if (@field(config, port_field_name)) |port_config| {
                comptime var input_gpios: u16 = 0;
                comptime var output_gpios: u16 = 0;
                comptime {
                    for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name|
                        if (@field(port_config, field_name)) |pin_config| {
                            const gpio_num = @intFromEnum(@field(Pin, field_name));

                            switch (pin_config.get_mode()) {
                                .input => input_gpios |= 1 << gpio_num,
                                .output => output_gpios |= 1 << gpio_num,
                            }
                        };
                }

                // TODO: ensure only one instance of an input function exists
                const used_gpios = comptime input_gpios | output_gpios;

                if (used_gpios != 0) {
                    const offset = @intFromEnum(@field(Port, port_field_name)) + 2;
                    const bit = @as(u32, 1 << offset);
                    RCU.APB2EN.raw |= bit;
                    // Delay after setting
                    _ = RCU.APB2EN.raw & bit;
                }

                inline for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name| {
                    if (@field(port_config, field_name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)));
                        pin.set_mode(pin_config.mode.?);
                    }
                }

                if (input_gpios != 0) {
                    inline for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name|
                        if (@field(port_config, field_name)) |pin_config| {
                            var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)));
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
        const info = @typeInfo(Pins(config)).@"struct";
        inline for (info.field_names, info.field_types, info.field_attrs) |field_name, field_type, field_attrs| {
            if (field_attrs.default_value_ptr) |default_value_ptr| {
                @field(ret, field_name) = @as(*const field_type, @ptrCast(default_value_ptr)).*;
            } else {
                @field(ret, field_name) = .{};
            }
        }
        return ret;
        // validate selected function
    }
};
