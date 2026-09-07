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

    inline fn write_pin_config(p: GPIO_Pin, mode: Mode) void {
        switch (mode) {
            .input => |imode| {
                p.set_moder(MODER.Input);
                p.set_bias(imode.resistor);
            },
            .output => |omode| {
                p.set_moder(MODER.Output);
                p.set_output_type(omode.o_type);
                p.set_bias(omode.resistor);
                p.set_speed(omode.o_speed);
            },
            .analog => |amode| {
                p.set_moder(MODER.Analog);
                p.set_bias(amode.resistor);
            },
            .alternate_function => |afmode| {
                p.set_moder(MODER.Alternate);
                p.set_bias(afmode.resistor);
                p.set_speed(afmode.o_speed);
                p.set_output_type(afmode.o_type);
                p.set_alternate_function(afmode.afr);
            },
            .digital_io => {
                // Nothing for now
            },
        }
    }

    fn mask_2bit(_gpio: GPIO_Pin) u32 {
        const pin: u4 = @backingInt(_gpio.pin);
        return @as(u32, 0b11) << (pin << 1);
    }

    fn mask(_gpio: GPIO_Pin) u32 {
        const pin: u4 = @backingInt(_gpio.pin);
        return @as(u32, 1) << pin;
    }

    //NOTE: should invalid pins panic or just be ignored?
    fn get_port(_gpio: GPIO_Pin) *volatile gpio_v2.GPIO {
        switch (@backingInt(_gpio.port)) {
            inline 0...@typeInfo(Port).@"enum".field_names.len - 1 => |p| {
                return @field(peripherals, @typeInfo(Port).@"enum".field_names[p]);
            },
            else => unreachable,
        }
    }

    inline fn set_bias(_gpio: GPIO_Pin, bias: PUPDR) void {
        const port = _gpio.get_port();
        const pin: u4 = @backingInt(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.PUPDR.write_raw((port.PUPDR.raw & ~modMask) | @as(u32, @backingInt(bias)) << (pin << 1));
    }

    inline fn set_speed(_gpio: GPIO_Pin, speed: OSPEEDR) void {
        const port = _gpio.get_port();
        const pin: u5 = @backingInt(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.OSPEEDR.write_raw((port.OSPEEDR.raw & ~modMask) | @as(u32, @backingInt(speed)) << (pin << 1));
    }

    inline fn set_moder(_gpio: GPIO_Pin, moder: MODER) void {
        const port = _gpio.get_port();
        const pin: u5 = @backingInt(_gpio.pin);
        const modMask: u32 = _gpio.mask_2bit();

        port.MODER.write_raw((port.MODER.raw & ~modMask) | @as(u32, @backingInt(moder)) << (pin << 1));
    }

    inline fn set_output_type(_gpio: GPIO_Pin, otype: OT) void {
        const port = _gpio.get_port();
        const pin: u5 = @backingInt(_gpio.pin);

        port.OTYPER.write_raw((port.OTYPER.raw & ~_gpio.mask()) | @as(u32, @backingInt(otype)) << pin);
    }

    inline fn set_alternate_function(_gpio: GPIO_Pin, afr: AF) void {
        const port = _gpio.get_port();
        const pin: u5 = @backingInt(_gpio.pin);
        const afrMask: u32 = @as(u32, 0b1111) << ((pin % 8) << 2);
        const register = if (pin > 7) &port.AFR[1] else &port.AFR[0];
        register.write_raw((register.raw & ~afrMask) | @as(u32, @backingInt(afr)) << ((pin % 8) << 2));
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
    var count: usize = 0;
    for (@typeInfo(GlobalConfiguration).@"struct".field_names, @typeInfo(GlobalConfiguration).@"struct".field_types) |port_field_name, port_field_type| {
        if (port_field_type != ?PortConfiguration) {
            continue;
        }
        if (@field(config, port_field_name)) |port_config| {
            for (@typeInfo(PortConfiguration).@"struct".field_names) |field_name| {
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
    for (@typeInfo(GlobalConfiguration).@"struct".field_names, @typeInfo(GlobalConfiguration).@"struct".field_types) |port_field_name, port_field_type| {
        if (port_field_type != ?PortConfiguration) {
            continue;
        }
        if (@field(config, port_field_name)) |port_config| {
            for (@typeInfo(PortConfiguration).@"struct".field_names) |field_name| {
                if (@field(port_config, field_name)) |pin_config| {
                    const default_name = "P" ++ port_field_name[4..5] ++ field_name[3..];
                    field_names[i] = pin_config.name orelse default_name;
                    field_types[i] = GPIO(pin_config.mode orelse .{ .input = .{.floating} });
                    field_attrs[i] = .{};
                    i += 1;
                }
            }
        }
    }

    return @Struct(.auto, null, &field_names, &field_types, &field_attrs);
}

fn _port() type {
    var result_len: usize = 0;

    for (0..11) |i| {
        const port_id: u8 = "ABCDEFGHIJK"[i];
        if (util.has_port(port_id)) {
            result_len += 1;
        }
    }

    var field_names: [result_len][]const u8 = undefined;
    var field_values: [result_len]u8 = undefined;
    var v: u8 = 0;
    for (0..11) |i| {
        const port_id: u8 = "ABCDEFGHIJK"[i];
        if (util.has_port(port_id)) {
            const x: []const u8 = "GPIO" ++ .{port_id};
            field_names[v] = x;
            field_values[v] = v;
            v += 1;
        }
    }

    return @Enum(u8, .exhaustive, &field_names, &field_values);
}

pub const Port = _port();

pub const PortConfiguration = struct {
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
        const config_field_count = @typeInfo(PortConfiguration).@"struct".field_names.len;
        if (pin_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ pin_field_count, config_field_count }));
    }
};

pub const GlobalConfiguration = struct {
    GPIOA: ?if (util.has_port('A')) PortConfiguration else struct {} = null,
    GPIOB: ?if (util.has_port('B')) PortConfiguration else struct {} = null,
    GPIOC: ?if (util.has_port('C')) PortConfiguration else struct {} = null,
    GPIOD: ?if (util.has_port('D')) PortConfiguration else struct {} = null,
    GPIOE: ?if (util.has_port('E')) PortConfiguration else struct {} = null,
    GPIOF: ?if (util.has_port('F')) PortConfiguration else struct {} = null,
    GPIOG: ?if (util.has_port('G')) PortConfiguration else struct {} = null,
    GPIOH: ?if (util.has_port('H')) PortConfiguration else struct {} = null,
    GPIOI: ?if (util.has_port('I')) PortConfiguration else struct {} = null,
    GPIOJ: ?if (util.has_port('J')) PortConfiguration else struct {} = null,
    GPIOK: ?if (util.has_port('K')) PortConfiguration else struct {} = null,

    comptime {
        const port_field_count = @typeInfo(Port).@"enum".field_names.len;

        var config_field_count: usize = 0;
        for (@typeInfo(GlobalConfiguration).@"struct".field_types) |port_field_type| {
            if (port_field_type == ?PortConfiguration) {
                config_field_count += 1;
            }
        }

        if (port_field_count != config_field_count)
            @compileError(comptimePrint("{} {}", .{ port_field_count, config_field_count }));
    }

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        var ret: Pins(config) = undefined;

        inline for (@typeInfo(GlobalConfiguration).@"struct".field_names, @typeInfo(GlobalConfiguration).@"struct".field_types) |port_field_name, port_field_type| {
            if (port_field_type != ?PortConfiguration) {
                continue;
            }
            if (@field(config, port_field_name)) |_| {
                rcc.enable_clock(@field(rcc.Peripherals, port_field_name));
            }
        }

        inline for (@typeInfo(GlobalConfiguration).@"struct".field_names, @typeInfo(GlobalConfiguration).@"struct".field_types) |port_field_name, port_field_type| {
            if (port_field_type != ?PortConfiguration) {
                continue;
            }
            if (@field(config, port_field_name)) |port_config| {
                inline for (@typeInfo(PortConfiguration).@"struct".field_names) |field_name| {
                    if (@field(port_config, field_name)) |pin_config| {
                        const port = @field(Port, port_field_name);
                        var pin = GPIO_Pin.from_port(port, @field(Pin, field_name));
                        pin.write_pin_config(pin_config.mode.?);
                        const default_name = "P" ++ port_field_name[4..5] ++ field_name[3..];

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
