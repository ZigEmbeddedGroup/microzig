const std = @import("std");
const assert = std.debug.assert;
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");
const util = @import("util.zig");

const Digital_IO = microzig.drivers.base.Digital_IO;
const Direction = Digital_IO.Direction;
const SetDirError = Digital_IO.SetDirError;
const SetBiasError = Digital_IO.SetBiasError;
const WriteError = Digital_IO.WriteError;
const ReadError = Digital_IO.ReadError;

const State = Digital_IO.State;

const gpio_v2 = microzig.chip.types.peripherals.gpio_v2;
const PUPDR = gpio_v2.PUPDR;
const MODER = gpio_v2.MODER;
const OSPEEDR = gpio_v2.OSPEEDR;
const OT = gpio_v2.OT;
const AFIO = microzig.chip.peripherals.AFIO;

const rcc = microzig.hal.rcc;
const peripherals = microzig.chip.peripherals;

pub const Mode = union(enum) {
    input: InputMode,
    output: OutputMode,
    analog: AnalogMode,
    alternate_function: AlternateFunctionMode,
    digital_io: Digital_IO_Mode,
};

const Digital_IO_Mode = struct {};

const InputMode = struct {
    resistor: PUPDR,
};

const OutputMode = struct {
    resistor: PUPDR,
    o_type: OT,
    o_speed: OSPEEDR = .LowSpeed,
};

const AnalogMode = struct {
    resistor: PUPDR = .Floating,
};

const AF = enum(u4) {
    AF0,
    AF1,
    AF2,
    AF3,
    AF4,
    AF5,
    AF6,
    AF7,
    AF8,
    AF9,
    AF10,
    AF11,
    AF12,
    AF13,
    AF14,
    AF15,
};

pub const AlternateFunctionMode = struct {
    afr: AF,
    resistor: PUPDR = .Floating,
    o_type: OT = .PushPull,
    o_speed: OSPEEDR = .HighSpeed,
};

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
        mode: ?Mode = null,
    };
};

const GPIO_Pin = struct {
    pin: Pin,
    port: Port,

    inline fn write_pin_config(_gpio: GPIO_Pin, mode: Mode) void {
        switch (mode) {
            .input => |imode| {
                _gpio.set_moder(MODER.Input);
                _gpio.set_bias(imode.resistor);
            },
            .output => |omode| {
                _gpio.set_moder(MODER.Output);
                _gpio.set_output_type(omode.o_type);
                _gpio.set_bias(omode.resistor);
                _gpio.set_speed(omode.o_speed);
            },
            .analog => |amode| {
                _gpio.set_moder(MODER.Analog);
                _gpio.set_bias(amode.resistor);
            },
            .alternate_function => |afmode| {
                _gpio.set_moder(MODER.Alternate);
                _gpio.set_bias(afmode.resistor);
                _gpio.set_speed(afmode.o_speed);
                _gpio.set_output_type(afmode.o_type);
                _gpio.set_alternate_function(afmode.afr);
            },
            .digital_io => {
                // Nothing for now
            },
        }
    }

    fn mask_2bit(_gpio: GPIO_Pin) u32 {
        const pin: u4 = @intFromEnum(_gpio.pin);
        return @as(u32, 0b11) << (pin << 1);
    }

    fn mask(_gpio: GPIO_Pin) u32 {
        const pin: u4 = @intFromEnum(_gpio.pin);
        return @as(u32, 1) << pin;
    }

    //NOTE: should invalid pins panic or just be ignored?
    fn get_port(_gpio: GPIO_Pin) *volatile gpio_v2.GPIO {
        return _gpio.port.get_port();
    }

    inline fn set_bias(_gpio: GPIO_Pin, bias: PUPDR) void {
        const port = _gpio.port.get_port();
        const pin: u4 = @intFromEnum(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @intFromEnum(bias)) << (pin << 1));
    }

    inline fn set_speed(_gpio: GPIO_Pin, speed: OSPEEDR) void {
        const port = _gpio.port.get_port();
        const pin: u5 = @intFromEnum(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.OSPEEDR.write_raw((port.OSPEEDR.raw & ~modMask) | @as(u32, @intFromEnum(speed)) << (pin << 1));
    }

    inline fn set_moder(_gpio: GPIO_Pin, moder: MODER) void {
        const port = _gpio.port.get_port();
        const pin: u5 = @intFromEnum(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @intFromEnum(moder)) << (pin << 1));
    }

    inline fn set_output_type(_gpio: GPIO_Pin, otype: OT) void {
        const port = _gpio.port.get_port();
        const pin: u5 = @intFromEnum(_gpio.pin);

        port.OTYPER.write_raw((port.OTYPER.raw & ~_gpio.mask()) | @as(u32, @intFromEnum(otype)) << pin);
    }

    fn from_port(port: Port, pin: Pin) GPIO_Pin {
        return .{
            .port = port,
            .pin = pin,
        };
    }
};

pub const Input_GPIO = struct {
    pin: GPIO_Pin,
    pub inline fn read(self: @This()) u1 {
        const port = self.pin.get_port();
        return if (port.IDR.raw & self.pin.mask() != 0)
            1
        else
            0;
    }
};

pub const Output_GPIO = struct {
    pin: GPIO_Pin,

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
    pin: GPIO_Pin,
};

pub const Digital_IO_Pin = struct {
    pin: GPIO_Pin,
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
        var port = self.pin.get_port();
        switch (state) {
            .low => port.BSRR.raw = @intCast(self.pin.mask() << 16),
            .high => port.BSRR.raw = self.pin.mask(),
        }
    }
    pub fn read_fn(ptr: *anyopaque) ReadError!State {
        const self: *@This() = @ptrCast(@alignCast(ptr));
        const port = self.pin.get_port();
        return if (port.IDR.raw & self.pin.mask() != 0)
            .high
        else
            .low;
    }

    pub fn digital_io(ptr: *@This()) Digital_IO {
        return .{
            .ptr = ptr,
            .vtable = &vtable,
        };
    }
};

pub fn GPIO(comptime mode: Mode) type {
    return switch (mode) {
        .input => Input_GPIO,
        .output => Output_GPIO,
        .alternate_function => AlternateFunction,
        .analog => Analog,
        .digital_io => Digital_IO_Pin,
    };
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (port_field.type != ?Port.Configuration) {
                continue;
            }
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

pub const Port = enum(u8) {
    GPIOA = if (util.has_port('A')) 0 else undefined,
    GPIOB = if (util.has_port('B')) 1 else undefined,
    GPIOC = if (util.has_port('C')) 2 else undefined,
    GPIOD = if (util.has_port('D')) 3 else undefined,
    GPIOE = if (util.has_port('E')) 4 else undefined,
    GPIOF = if (util.has_port('F')) 5 else undefined,
    GPIOG = if (util.has_port('G')) 6 else undefined,
    GPIOH = if (util.has_port('H')) 7 else undefined,
    GPIOI = if (util.has_port('I')) 8 else undefined,
    GPIOJ = if (util.has_port('J')) 9 else undefined,
    GPIOK = if (util.has_port('K')) 10 else undefined,

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
            const config_field_count = @typeInfo(Port.Configuration).@"struct".fields.len;
            if (pin_field_count != config_field_count)
                @compileError(comptimePrint("{} {}", .{ pin_field_count, config_field_count }));
        }
    };

    pub fn get_port(port: Port) *volatile gpio_v2.GPIO {
        switch (@intFromEnum(port)) {
            inline 0...@typeInfo(Port).@"enum".fields.len - 1 => |p| {
                const port_id = [_]u8{"ABCDEFGHIJK"[p]};
                return @field(peripherals, "GPIO" ++ port_id);
            },
            else => unreachable,
        }
    }
};

pub const GlobalConfiguration = struct {
    GPIOA: ?if (util.has_port('A')) Port.Configuration else undefined = null,
    GPIOB: ?if (util.has_port('B')) Port.Configuration else undefined = null,
    GPIOC: ?if (util.has_port('C')) Port.Configuration else undefined = null,
    GPIOD: ?if (util.has_port('D')) Port.Configuration else undefined = null,
    GPIOE: ?if (util.has_port('E')) Port.Configuration else undefined = null,
    GPIOF: ?if (util.has_port('F')) Port.Configuration else undefined = null,
    GPIOG: ?if (util.has_port('G')) Port.Configuration else undefined = null,
    GPIOH: ?if (util.has_port('H')) Port.Configuration else undefined = null,
    GPIOI: ?if (util.has_port('I')) Port.Configuration else undefined = null,
    GPIOJ: ?if (util.has_port('J')) Port.Configuration else undefined = null,
    GPIOK: ?if (util.has_port('K')) Port.Configuration else undefined = null,

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".fields.len;
        const config_field_count = @typeInfo(GlobalConfiguration).@"struct".fields.len;
        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        var ret: Pins(config) = undefined;

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (port_field.type != ?Port.Configuration) {
                continue;
            }
            if (@field(config, port_field.name)) |_| {
                rcc.enable_clock(@field(rcc.Peripherals, port_field.name));
            }
        }

        inline for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (port_field.type != ?Port.Configuration) {
                continue;
            }
            if (@field(config, port_field.name)) |port_config| {
                inline for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        const port = @field(Port, port_field.name);
                        var pin = GPIO_Pin.from_port(port, @field(Pin, field.name));
                        pin.write_pin_config(pin_config.mode.?);
                        const default_name = "P" ++ port_field.name[4..5] ++ field.name[3..];

                        switch (pin_config.mode orelse .input) {
                            .input => @field(ret, pin_config.name orelse default_name) = Input_GPIO{ .pin = pin },
                            .output => @field(ret, pin_config.name orelse default_name) = Output_GPIO{ .pin = pin },
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
