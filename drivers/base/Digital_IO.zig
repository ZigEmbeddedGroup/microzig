//!
//! An abstract digital input/output pin.
//!
//! Digital I/Os can be used to drive single-wire data
//!

const std = @import("std");

const Digital_IO = @This();

/// Pointer to the object implementing the driver.
///
/// If the implementation requires no `ptr` pointer,
/// you can safely use `undefined` here.
ptr: *anyopaque,

/// Virtual table for the digital i/o functions.
vtable: *const VTable,

const BaseError = error{ IoError, Timeout };

pub const SetDirError = BaseError || error{Unsupported};
pub const SetBiasError = BaseError || error{Unsupported};
pub const WriteError = BaseError || error{Unsupported};
pub const ReadError = BaseError || error{Unsupported};

pub const State = enum(u1) {
    low = 0,
    high = 1,

    pub inline fn invert(state: State) State {
        return @as(State, @enumFromInt(~@intFromEnum(state)));
    }

    pub inline fn value(state: State) u1 {
        return @intFromEnum(state);
    }
};
pub const Direction = enum { input, output };

/// Sets the direction of the pin.
pub fn set_direction(dio: Digital_IO, dir: Direction) SetDirError!void {
    return dio.vtable.set_direction_fn(dio.ptr, dir);
}

/// Sets if the pin has a bias towards either `low` or `high` or no bias at all.
/// Bias is usually implemented with pull-ups and pull-downs.
pub fn set_bias(dio: Digital_IO, bias: ?State) SetBiasError!void {
    return dio.vtable.set_bias_fn(dio.ptr, bias);
}

/// Changes the state of the pin.
pub fn write(dio: Digital_IO, state: State) WriteError!void {
    return dio.vtable.write_fn(dio.ptr, state);
}

/// Reads the state state of the pin.
pub fn read(dio: Digital_IO) ReadError!State {
    return dio.vtable.read_fn(dio.ptr);
}

pub const VTable = struct {
    set_direction_fn: *const fn (*anyopaque, dir: Direction) SetDirError!void,
    set_bias_fn: *const fn (*anyopaque, bias: ?State) SetBiasError!void,
    write_fn: *const fn (*anyopaque, state: State) WriteError!void,
    read_fn: *const fn (*anyopaque) ReadError!State,
};

pub const Test_Device = struct {
    state: State,
    dir: Direction,

    pub fn init(initial_dir: Direction, initial_state: State) Test_Device {
        return Test_Device{
            .dir = initial_dir,
            .state = initial_state,
        };
    }

    pub fn digital_io(dev: *Test_Device) Digital_IO {
        return Digital_IO{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    fn set_direction(ctx: *anyopaque, dir: Direction) SetDirError!void {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        dev.dir = dir;
    }

    fn set_bias(ctx: *anyopaque, bias: ?State) SetBiasError!void {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        _ = dev;
        _ = bias;
    }

    fn write(ctx: *anyopaque, state: State) WriteError!void {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        if (dev.dir != .output)
            return error.Unsupported;
        dev.state = state;
    }

    fn read(ctx: *anyopaque) ReadError!State {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        return dev.state;
    }

    const vtable = VTable{
        .set_direction_fn = Test_Device.set_direction,
        .set_bias_fn = Test_Device.set_bias,
        .write_fn = Test_Device.write,
        .read_fn = Test_Device.read,
    };
};

test Test_Device {
    var td = Test_Device.init(.input, .high);

    const io = td.digital_io();

    // Check if the initial state is correct:
    try std.testing.expectEqual(.high, try io.read());

    // Check if we can change the state
    td.state = .low;
    try std.testing.expectEqual(.low, try io.read());

    // Check if we can change the state
    td.state = .high;
    try std.testing.expectEqual(.high, try io.read());

    // We're currently in "input" state, so we can't write the pin level:
    try std.testing.expectError(error.Unsupported, io.write(.low));

    try io.set_direction(.output);
    try std.testing.expectEqual(.output, td.dir);

    // Changing direction should not change the current level:
    try std.testing.expectEqual(.high, try io.read());

    try io.write(.low);
    try std.testing.expectEqual(.low, td.state);

    try io.write(.high);
    try std.testing.expectEqual(.high, td.state);
}
