//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;

///
/// Implementation of a digital i/o device.
///
pub const GPIO_Device = struct {
    pub const SetDirError = Digital_IO.SetDirError;
    pub const SetBiasError = Digital_IO.SetBiasError;
    pub const WriteError = Digital_IO.WriteError;
    pub const ReadError = Digital_IO.ReadError;

    pub const State = Digital_IO.State;
    pub const Direction = Digital_IO.Direction;

    pin: hal.gpio.Pin,

    pub fn init(pin: hal.gpio.Pin) GPIO_Device {
        return .{ .pin = pin };
    }

    pub fn digital_io(dio: *GPIO_Device) Digital_IO {
        return Digital_IO{
            .ptr = dio,
            .vtable = &vtable,
        };
    }

    pub fn set_direction(dio: GPIO_Device, dir: Direction) SetDirError!void {
        dio.pin.set_output_enable(dir == .output);
    }

    pub fn set_bias(dio: GPIO_Device, maybe_bias: ?State) SetBiasError!void {
        dio.pin.set_pullup(if (maybe_bias) |bias| switch (bias) {
            .low => false,
            .high => true,
        } else false);
    }

    pub fn write(dio: GPIO_Device, state: State) WriteError!void {
        dio.pin.write(@enumFromInt(state.value()));
    }

    pub fn read(dio: GPIO_Device) ReadError!State {
        return @enumFromInt(@intFromEnum(dio.pin.read()));
    }

    const vtable = Digital_IO.VTable{
        .set_direction_fn = set_direction_fn,
        .set_bias_fn = set_bias_fn,
        .write_fn = write_fn,
        .read_fn = read_fn,
    };

    fn set_direction_fn(io: *anyopaque, dir: Direction) SetDirError!void {
        const gpio: *GPIO_Device = @ptrCast(@alignCast(io));
        try gpio.set_direction(dir);
    }

    fn set_bias_fn(io: *anyopaque, bias: ?State) SetBiasError!void {
        const gpio: *GPIO_Device = @ptrCast(@alignCast(io));

        try gpio.set_bias(bias);
    }

    fn write_fn(io: *anyopaque, state: State) WriteError!void {
        const gpio: *GPIO_Device = @ptrCast(@alignCast(io));

        try gpio.write(state);
    }

    fn read_fn(io: *anyopaque) ReadError!State {
        const gpio: *GPIO_Device = @ptrCast(@alignCast(io));
        return try gpio.read();
    }
};

///
/// Implementation of a time device
///
// TODO What do we call this concrete implementation?
pub const ClockDevice = struct {
    pub fn clock_device(td: *ClockDevice) Clock_Device {
        _ = td;
        return Clock_Device{
            .ptr = undefined,
            .vtable = &vtable,
        };
    }
    const vtable = Clock_Device.VTable{
        .get_time_since_boot = get_time_since_boot_fn,
    };

    fn get_time_since_boot_fn(td: *anyopaque) time.Absolute {
        _ = td;
        const t = hal.time.get_time_since_boot().to_us();
        return @enumFromInt(t);
    }
};
