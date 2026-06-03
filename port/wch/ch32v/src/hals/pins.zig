const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;

const microzig = @import("microzig");
const RCC = microzig.chip.peripherals.RCC;
const hal = microzig.hal;
const gpio = hal.gpio;

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
        speed: ?gpio.Speed = null,
        pull: ?gpio.Pull = null,
        // drive_strength: ?gpio.DriveStrength = null,

        pub fn get_mode(comptime config: Configuration) gpio.Mode {
            return if (config.mode) |mode|
                mode
                // TODO: set mode when configure alternative mode.
                // else if (comptime config.function.is_pwm())
                //     .output
                // else if (comptime config.function.is_uart_tx())
                //     .output
                // else if (comptime config.function.is_uart_rx())
                //     .input
                // else if (comptime config.function.is_adc())
                //     .input
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
                // return pin.input_read();
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

            // TODO: Read current output from ODR.
            // pub inline fn read(self: @This()) u1 {
            //     _ = self;
            //     return pin.output_read();
            // }
        },
    };
}

fn get_tag_name_by_index(comptime T: type, comptime index: usize) []const u8 {
    const fields = @typeInfo(T).@"enum".fields;
    if (index >= fields.len) {
        @compileError("Index is out of enum members.");
    }
    return fields[index].name;
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    const Attributes = std.builtin.Type.StructField.Attributes;

    var field_names: []const []const u8 = &.{};
    var field_types: []const type = &.{};
    var field_attrs: []const Attributes = &.{};
    for (@typeInfo(GlobalConfiguration).@"struct".field_names) |port_field_name| {
        if (@field(config, port_field_name)) |port_config| {
            for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name| {
                if (@field(port_config, field_name)) |pin_config| {
                    const name: []const u8 = pin_config.name orelse get_tag_name_by_index(PortName, @intFromEnum(@field(Port, port_field_name))) ++ @tagName(@field(Pin, field_name))[3..];
                    const typ: type = GPIO(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)), pin_config.mode orelse .{ .input = .{.floating} });
                    field_names = field_names ++ .{name};
                    field_types = field_types ++ .{typ};
                    field_attrs = field_attrs ++ .{Attributes{}};
                }
            }
        }
    }

    return @Struct(.auto, null, field_names, field_types[0..], field_attrs[0..]);
}

pub const PortName = enum {
    PA,
    PB,
    PC,
    PD,
};

pub const Port = enum {
    GPIOA,
    GPIOB,
    GPIOC,
    GPIOD,

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

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".field_names.len;
        const config_field_count = @typeInfo(GlobalConfiguration).@"struct".field_names.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        // Check if we need to enable AFIO for GPIOD PD0/PD1 remapping
        comptime var needs_pd01_remap = false;
        if (config.GPIOD) |gpiod_config| {
            if (gpiod_config.PIN0 != null or gpiod_config.PIN1 != null) {
                needs_pd01_remap = true;
            }
        }

        // Enable clocks first for PD0/PD1 remapping (must be done before remap)
        if (needs_pd01_remap) {
            // Enable AFIO and GPIOD clocks
            RCC.APB2PCENR.modify(.{ .AFIOEN = 1, .IOPDEN = 1 });

            // Remap PD0/PD1 from OSCIN/OSCOUT to GPIO
            // On CH32V20x, AFIO.PCFR1.PD01_RM = 1 selects PD0/PD1 as GPIO pins.
            const AFIO = microzig.chip.peripherals.AFIO;
            AFIO.PCFR1.modify(.{ .PD01_RM = 1 });
        }

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

                // enable clocks
                const used_gpios = comptime input_gpios | output_gpios;

                if (used_gpios != 0) {
                    // Figure out IO port enable bit from name
                    const offset = @as(u3, @intFromEnum(@field(Port, port_field_name))) + 2;
                    RCC.APB2PCENR.raw |= @as(u32, 1 << offset);
                }

                // GPIO
                // comptime var port_cfg_mask: u32 = 0;
                // comptime var port_cfg_value: u32 = 0;
                // comptime var port_cfg_default: u32 = 0;
                // Configure port mode.
                inline for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name| {
                    // TODO: GPIOD has only 3 ports. Check this.
                    if (@field(port_config, field_name)) |pin_config| {
                        var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)));
                        // TODO: Remove this loop. Set at once.
                        pin.set_mode(pin_config.mode.?);
                    }
                }

                // Set pull-up and pull-down.
                if (input_gpios != 0) {
                    inline for (@typeInfo(Port.Configuration).@"struct".field_names) |field_name|
                        if (@field(port_config, field_name)) |pin_config| {
                            var pin = gpio.Pin.init(@intFromEnum(@field(Port, port_field_name)), @intFromEnum(@field(Pin, field_name)));
                            const pull = pin_config.pull orelse continue;
                            if (comptime pin_config.get_mode() != .input)
                                @compileError("Only input pins can have pull up/down enabled");

                            // TODO: Remove this loop. Set at once.
                            pin.set_pull(pull);
                        };
                }
            }
        }

        return get_pins(config);
    }
};

pub fn get_pins(comptime config: GlobalConfiguration) Pins(config) {
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
}
