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

pub const State = enum(u1) { low = 0, high = 1 };
pub const Direction = enum { input, output };

/// Sets the direction of the pin.
pub fn setDirection(dio: DigitalIO, dir: Direction) SetDirError!void {
    return dio.vtable.setDirectionFn(dio.object, dir);
}

/// Sets if the pin has a bias towards either `low` or `high` or no bias at all.
/// Bias is usually implemented with pull-ups and pull-downs.
pub fn setBias(dio: DigitalIO, bias: ?State) SetBiasError!void {
    return dio.vtable.setBiasFn(dio.object, bias);
}

/// Changes the state of the pin.
pub fn write(dio: DigitalIO, state: State) WriteError!void {
    return dio.vtable.writeFn(dio.object, state);
}

/// Reads the state state of the pin.
pub fn read(dio: DigitalIO) State {
    return dio.vtable.readFn(dio.object);
}

pub const VTable = struct {
    setDirectionFn: *const fn (?*anyopaque, dir: Direction) SetDirError!void,
    setBiasFn: *const fn (?*anyopaque, bias: ?State) SetBiasError!void,
    writeFn: *const fn (?*anyopaque, state: State) WriteError!void,
    readFn: *const fn (?*anyopaque) State,
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

    pub fn digitalIO(dev: *TestDevice) DigitalIO {
        return DigitalIO{
            .object = dev,
            .vtable = &vtable,
        };
    }

    fn setDirectionFn(ctx: ?*anyopaque, dir: Direction) SetDirError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        dev.dir = dir;
    }

    fn setBiasFn(ctx: ?*anyopaque, bias: ?State) SetBiasError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        _ = dev;
        _ = bias;
    }

    fn writeFn(ctx: ?*anyopaque, state: State) WriteError!void {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        if (dev.dir != .output)
            return error.Unsupported;
        dev.state = state;
    }

    fn readFn(ctx: ?*anyopaque) State {
        const dev: *TestDevice = @ptrCast(@alignCast(ctx.?));
        return dev.state;
    }

    const vtable = VTable{
        .setDirectionFn = setDirectionFn,
        .setBiasFn = setBiasFn,
        .writeFn = writeFn,
        .readFn = readFn,
    };
};
