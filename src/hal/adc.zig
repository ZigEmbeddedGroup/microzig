//! NOTE: no settling time is needed when switching analog inputs

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const ADC = microzig.chip.registers.ADC;
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const resets = rp2040.resets;

pub const temperature_sensor = struct {
    pub inline fn init() void {
        setTempSensorEnabled(true);
    }

    pub inline fn deinit() void {
        setTempSensorEnabled(false);
    }

    pub inline fn readRaw() u16 {
        return Input.read(.temperature_sensor);
    }

    // One-shot conversion returning the temperature in Celcius
    pub inline fn read(comptime T: type, comptime Vref: T) T {
        // TODO: consider fixed-point
        const raw = @intToFloat(T, readRaw());
        const voltage: T = Vref * raw / 0x0fff;
        return (27.0 - ((voltage - 0.706) / 0.001721));
    }
};

pub const Input = enum(u3) {
    ain0,
    ain1,
    ain2,
    ain3,
    temperature_sensor,

    /// Setup the GPIO pin as an ADC input
    pub fn init(comptime input: Input) void {
        switch (input) {
            .temperature_sensor => setTempSensorEnabled(true),
            else => {
                const gpio_num = @as(u32, @enumToInt(input)) + 26;

                gpio.setFunction(gpio_num, .@"null");
                // TODO: implement these, otherwise adc isn't going to work.
                //gpio.disablePulls(gpio_num);
                //gpio.setInputEnabled(gpio_num, false);
            },
        }
    }

    /// Disables temp sensor, otherwise it does nothing if the input is
    /// one of the others.
    pub inline fn deinit(input: Input) void {
        switch (input) {
            .temperature_sensor => setTempSensorEnabled(true),
            else => {},
        }
    }

    /// Single-shot, blocking conversion
    pub fn read(input: Input) u12 {
        // TODO: not sure if setting these during the same write is
        // correct
        ADC.CS.modify(.{
            .AINSEL = @enumToInt(input),
            .START_ONCE = 1,
        });

        // wait for the
        while (ADC.CS.read().READY == 0) {}

        return ADC.RESULT.read();
    }
};

pub const InputMask = InputMask: {
    const enum_fields = @typeInfo(Input).Enum.fields;
    var fields: [enum_fields.len]std.builtin.Type.StructField = undefined;

    const default_value: u1 = 0;
    for (enum_fields) |enum_field, i|
        fields[i] = std.builtin.Type.StructField{
            .name = enum_field.name,
            .field_type = u1,
            .default_value = &default_value,
            .is_comptime = false,
            .alignment = 1,
        };

    break :InputMask @Type(.{
        .Struct = .{
            .layout = .Packed,
            .fields = &fields,
            .backing_integer = std.meta.Int(.Unsigned, enum_fields.len),
            .decls = &.{},
            .is_tuple = false,
        },
    });
};

/// Initialize ADC hardware
pub fn init() void {
    std.log.info("init.a", .{});
    resets.reset(&.{.adc});
    std.log.info("init.b", .{});
    ADC.CS.write(.{
        .EN = 1,
        .TS_EN = 0,
        .START_ONCE = 0,
        .START_MANY = 0,
        .READY = 0,
        .ERR = 0,
        .ERR_STICKY = 0,
        .AINSEL = 0,
        .RROBIN = 0,
    });
    std.log.info("init.c", .{});
    while (ADC.CS.read().READY == 0) {}
    std.log.info("init.d", .{});
}

/// Enable/disable ADC interrupt
pub inline fn irqSetEnabled(enable: bool) void {
    // TODO: check if this works
    ADC.INTE.write(.{ .FIFO = if (enable) @as(u1, 1) else @as(u1, 0) });
}

/// Select analog input for next conversion.
pub inline fn selectInput(input: Input) void {
    ADC.CS.modify(.{ .AINSEL = @enumToInt(input) });
}

/// Get the currently selected analog input. 0..3 are GPIO 26..29 respectively,
/// 4 is the temperature sensor.
pub inline fn getSelectedInput() Input {
    // TODO: ensure that the field shouldn't have other values
    return @intToEnum(Input, ADC.CS.read().AINSEL);
}

/// Set to true to power on the temperature sensor.
pub inline fn setTempSensorEnabled(enable: bool) void {
    ADC.CS.modify(.{ .TS_EN = if (enable) @as(u1, 1) else @as(u1, 0) });
}

/// Sets which of the inputs are to be run in round-robin mode. Setting all to
/// 0 will disable round-robin mode but `disableRoundRobin()` is provided so
/// the user may be explicit.
pub inline fn setRoundRobin(comptime enabled_inputs: InputMask) void {
    ADC.CS.modify(.{ .RROBIN = @bitCast(u5, enabled_inputs) });
}

/// Disable round-robin sample mode.
pub inline fn disableRoundRobin() void {
    ADC.CS.modify(.{ .RROBIN = 0 });
}

/// Enable free-running sample mode.
pub inline fn run(enable: bool) void {
    ADC.CS.modify(.{ .START_MANY = if (enable) @as(u1, 1) else @as(u1, 0) });
}

pub inline fn setClkDiv() void {
    @compileError("todo");
}

/// The fifo is 4 samples long, if a conversion is completed and the FIFO is
/// full, the result is dropped.
pub const fifo = struct {
    pub inline fn setup() void {
        @compileError("todo");
        // There are a number of considerations wrt DMA and error detection
    }

    /// Return true if FIFO is empty.
    pub inline fn isEmpty() bool {
        @compileError("todo");
    }

    /// Read how many samples are in the FIFO.
    pub inline fn getLevel() u8 {
        @compileError("todo");
    }

    /// Pop latest result from FIFO.
    pub inline fn get() u16 {
        @compileError("todo");
    }

    /// Block until result is available in FIFO, then pop it.
    pub inline fn getBlocking() u16 {
        @compileError("todo");
    }

    /// Wait for conversion to complete then discard results in FIFO.
    pub inline fn drain() void {
        @compileError("todo");
    }
};
