const std = @import("std");
const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");
const enums = @import("../common/enums.zig");

const Digital_IO = microzig.drivers.base.Digital_IO;
const Direction = Digital_IO.Direction;
const SetDirError = Digital_IO.SetDirError;
const SetBiasError = Digital_IO.SetBiasError;
const WriteError = Digital_IO.WriteError;
const ReadError = Digital_IO.ReadError;

const State = Digital_IO.State;

const gpio_v2 = microzig.chip.types.peripherals.gpio_v2;
const PUPDR = gpio_v2.PUPDR;
const rcc = microzig.hal.rcc;

const gpio = @import("gpio_v2.zig");

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
    };
};

pub const InputGPIO = struct {
    pin: gpio.Pin,
    pub inline fn read(self: @This()) u1 {
        return self.pin.read();
    }
};

pub const OutputGPIO = struct {
    pin: gpio.Pin,

    pub inline fn put(self: @This(), value: u1) void {
        self.pin.put(value);
    }

    pub inline fn low(self: @This()) void {
        self.put(0);
    }

    pub inline fn high(self: @This()) void {
        self.put(1);
    }

    pub inline fn toggle(self: @This()) void {
        self.pin.toggle();
    }
};

pub const AlternateFunction = struct {
    // Empty on perpose it should not be used as a GPIO.
};

const Analog = struct {
    pin: gpio.Pin,
};

pub const Digital_IO_Pin = struct {
    pin: gpio.Pin,
    const vtable: Digital_IO.VTable = .{
        .set_direction_fn = Digital_IO_Pin.set_direction_fn,
        .set_bias_fn = Digital_IO_Pin.set_bias_fn,
        .write_fn = Digital_IO_Pin.write_fn,
        .read_fn = Digital_IO_Pin.read_fn,
    };
    pub fn set_direction_fn(ptr: *anyopaque, dir: Direction) SetDirError!void {
        const self: *@This() = @ptrCast(@alignCast(ptr));
        switch (dir) {
            .input => self.pin.set_moder(.Input),
            .output => self.pin.set_moder(.Output),
        }
    }
    pub fn set_bias_fn(ptr: *anyopaque, maybe_bias: ?State) SetBiasError!void {
        const self: *@This() = @ptrCast(@alignCast(ptr));

        const pupdr: PUPDR = if (maybe_bias) |bias| switch (bias) {
            .low => .PullDown,
            .high => .PullUp,
        } else .Floating;
        self.pin.set_bias(pupdr);
    }
    pub fn write_fn(ptr: *anyopaque, state: State) WriteError!void {
        const self: *@This() = @ptrCast(@alignCast(ptr));
        self.pin.put(@intFromEnum(state));
    }

    pub fn read_fn(ptr: *anyopaque) ReadError!State {
        const self: *@This() = @ptrCast(@alignCast(ptr));
        return @as(State, @enumFromInt(self.pin.read()));
    }

    pub fn digital_io(ptr: *@This()) Digital_IO {
        return .{
            .ptr = ptr,
            .vtable = &vtable,
        };
    }
};

pub fn GPIO(comptime mode: gpio.Mode) type {
    return switch (mode) {
        .input => InputGPIO,
        .output => OutputGPIO,
        .alternate_function => AlternateFunction,
        .analog => Analog,
        .digital_io => Digital_IO_Pin,
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

                        const default_name = "P" ++ port_field.name[4..5] ++ field.name[3..];
                        pin_field.name = pin_config.name orelse default_name;
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
    GPIOH,
    GPIOI,
    GPIOJ,
    GPIOK,
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
    GPIOH: ?Port.Configuration = null,
    GPIOI: ?Port.Configuration = null,
    GPIOJ: ?Port.Configuration = null,
    GPIOK: ?Port.Configuration = null,

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".fields.len;
        const config_field_count = @typeInfo(GlobalConfiguration).@"struct".fields.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        var ret: Pins(config) = undefined;

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |_| {
                rcc.enable_clock(@field(enums.Peripherals, port_field.name));
            }
        }

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        const port = @intFromEnum(@field(Port, port_field.name));
                        var pin = gpio.Pin.from_port(@enumFromInt(port), @intFromEnum(@field(Pin, field.name)));
                        pin.write_pin_config(pin_config.mode.?);
                        const default_name = "P" ++ port_field.name[4..5] ++ field.name[3..];

                        switch (pin_config.mode orelse .input) {
                            .input => @field(ret, pin_config.name orelse default_name) = InputGPIO{ .pin = pin },
                            .output => @field(ret, pin_config.name orelse default_name) = OutputGPIO{ .pin = pin },
                            .analog => @field(ret, pin_config.name orelse default_name) = Analog{},
                            .alternate_function => @field(ret, pin_config.name orelse default_name) = AlternateFunction{},
                            .digital_io => @field(ret, pin_config.name orelse default_name) = Digital_IO_Pin{ .pin = pin },
                        }
                    }
                }
            }
        }

        return ret;
    }
};
