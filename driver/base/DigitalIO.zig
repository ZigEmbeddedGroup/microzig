//!
//! An abstract digital input/output pin.
//!
//! Digital I/Os can be used to drive single-wire data
//!

const std = @import("std");

const DigitalIO = @This();
const BaseError = error{ IoError, Timeout };

object: ?*anyopaque,
vtable: *const VTable,

pub const SetDirError = error{Unsupported};
pub const SetBiasError = error{Unsupported};
pub const WriteError = error{Unsupported};
pub const ReadError = error{Unsupported};

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
pub fn set_direction(dio: DigitalIO, dir: Direction) SetDirError!void {
    return dio.vtable.set_direction_fn(dio.object, dir);
}

/// Sets if the pin has a bias towards either `low` or `high` or no bias at all.
/// Bias is usually implemented with pull-ups and pull-downs.
pub fn set_bias(dio: DigitalIO, bias: ?State) SetBiasError!void {
    return dio.vtable.set_bias_fn(dio.object, bias);
}

/// Changes the state of the pin.
pub fn write(dio: DigitalIO, state: State) WriteError!void {
    return dio.vtable.write_fn(dio.object, state);
}

/// Reads the state state of the pin.
pub fn read(dio: DigitalIO) ReadError!State {
    return dio.vtable.read_fn(dio.object);
}

pub const VTable = struct {
    set_direction_fn: *const fn (?*anyopaque, dir: Direction) SetDirError!void,
    set_bias_fn: *const fn (?*anyopaque, bias: ?State) SetBiasError!void,
    write_fn: *const fn (?*anyopaque, state: State) WriteError!void,
    read_fn: *const fn (?*anyopaque) State,
};

pub const TestDevice = struct {
    state: State,
    dir: Direction,

    pub fn init(initial_dir: Direction, initial_state: State) TestDevice {
        return TestDevice{
            .dir = initial_dir,
            .state = initial_state,
        };
    }

    pub fn digital_io(dev: *TestDevice) DigitalIO {
        return DigitalIO{
            .object = dev,
            .vtable = &vtable,
        };
    }

    fn set_direction_fn(ctx: ?*anyopaque, dir: Direction) SetDirError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        dev.dir = dir;
    }

    fn set_bias_fn(ctx: ?*anyopaque, bias: ?State) SetBiasError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        _ = dev;
        _ = bias;
    }

    fn write_fn(ctx: ?*anyopaque, state: State) WriteError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        if (dev.dir != .output)
            return error.Unsupported;
        dev.state = state;
    }

    fn read_fn(ctx: ?*anyopaque) State {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        return dev.state;
    }

    const vtable = VTable{
        .set_direction_fn = set_direction_fn,
        .set_bias_fn = set_bias_fn,
        .write_fn = write_fn,
        .read_fn = read_fn,
    };
};
