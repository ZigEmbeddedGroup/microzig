const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const gpio = @import("gpio.zig");

/// For now this is always a GPIO pin configuration
const PinConfiguration = struct {
    name: ?[:0]const u8 = null,
    mode: ?gpio.Mode = null,
};

fn GPIO(comptime port: []const u8, comptime num: []const u8, comptime mode: gpio.Mode) type {
    if (mode == .input) @compileError("TODO: implement GPIO input mode");
    return switch (mode) {
        .input => struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn read(_: @This()) u1 {
                return pin.read();
            }
        },
        .output => packed struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn put(_: @This(), value: u1) void {
                pin.put(value);
            }

            pub inline fn toggle(_: @This()) void {
                pin.toggle();
            }

            fn configure(_: @This(), pin_config: PinConfiguration) void {
                _ = pin_config; // Later: use for GPIO pin speed etc.
                pin.configure();
            }
        },
    };
}

/// This is a helper empty struct with comptime constants for parsing an STM32 pin name.
/// Example: PinDescription("PE9").gpio_port_id = "E"
/// Example: PinDescription("PA12").gpio_port_number_str = "12"
fn PinDescription(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'F')
        @compileError(invalid_format_msg);

    const gpio_pin_number_int: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);
    return struct {
        /// 'A'...'F'
        const gpio_port_id = spec[1..2];
        const gpio_pin_number_str = std.fmt.comptimePrint("{d}", .{gpio_pin_number_int});
    };
}

/// Based on the fields in `config`, returns a struct {
///     PE11: GPIO(...),
///     PF7: GPIO(...),
/// }
/// Later: Also support non-GPIO pins?
pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                for (@typeInfo(PortConfiguration()).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        const D = PinDescription(field.name);
                        fields = fields ++ &[_]StructField{.{
                            .is_comptime = false,
                            .name = pin_config.name orelse field.name,
                            .type = GPIO(D.gpio_port_id, D.gpio_pin_number_str, pin_config.mode orelse .{ .input = .floating }),
                            .default_value_ptr = null,
                            .alignment = @alignOf(field.type),
                        }};
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

/// Returns the struct {
///     PA0: ?PinConfiguration = null,
///     ...
///     PF15: ?PinConfiguration = null,
/// }
fn PortConfiguration() type {
    @setEvalBranchQuota(200000);
    var fields: []const StructField = &.{};
    for ("ABCDEF") |gpio_port_id| {
        for (0..16) |gpio_pin_number_int| {
            fields = fields ++ &[_]StructField{.{
                .is_comptime = false,
                .name = std.fmt.comptimePrint("P{c}{d}", .{ gpio_port_id, gpio_pin_number_int }),
                .type = ?PinConfiguration,
                .default_value_ptr = &@as(?PinConfiguration, null),
                .alignment = @alignOf(?PinConfiguration),
            }};
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
pub const GlobalConfiguration = struct {
    GPIOA: ?PortConfiguration() = null,
    GPIOB: ?PortConfiguration() = null,
    GPIOC: ?PortConfiguration() = null,
    GPIOD: ?PortConfiguration() = null,
    GPIOE: ?PortConfiguration() = null,
    GPIOF: ?PortConfiguration() = null,

    pub fn apply(comptime config: @This()) Pins(config) {
        const pins: Pins(config) = undefined; // Later: something seems incomplete here...

        inline for (@typeInfo(@This()).@"struct".fields) |port_field| {
            const gpio_port_name = port_field.name;
            if (@field(config, gpio_port_name)) |port_config| {
                peripherals.RCC.AHBENR.modify_one(gpio_port_name ++ "EN", 1);

                inline for (@typeInfo(PortConfiguration()).@"struct".fields) |pin_field| {
                    if (@field(port_config, pin_field.name)) |pin_config| {
                        @field(pins, pin_field.name).configure(pin_config);
                    }
                }
            }
        }

        return pins;
    }
};
