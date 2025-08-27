const std = @import("std");
const microzig = @import("microzig");
const I2C = @import("i2c.zig");
const drivers = microzig.drivers.base;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;

const I2CError = drivers.I2C_Device.Error;
// TODO: The STM HAL still has its own I2CAddress type, since it supports 10 bit addresses. For now
// we will paper over it, but we should unify them.
const I2CAddress = drivers.I2C_Device.Address;

pub const CounterDevice = struct {
    us_psc: u32,
    ms_psc: u32,
    ns_per_tick: u32,
    busy_wait_fn: *const fn (*const anyopaque, time: u64) void,
    load_and_start: *const fn (*const anyopaque, psc: u32, arr: u16) void,
    check_event: *const fn (*const anyopaque) bool,
    ctx: *const anyopaque,

    pub fn sleep_ns(self: *const CounterDevice, ns: u64) void {
        const arr = ns / self.ns_per_tick;
        self.busy_wait_fn(self.ctx, arr);
    }

    pub fn sleep_us(self: *const CounterDevice, us: u64) void {
        self.sleep_ns(us * 1_000);
    }

    pub fn sleep_ms(self: *const CounterDevice, ms: u64) void {
        self.sleep_us(ms * 1_000);
    }

    pub fn make_ms_timeout(self: *const CounterDevice, time: u16) Timeout {
        self.load_and_start(self.ctx, self.ms_psc, time);
        return Timeout{
            .ctx = self.ctx,
            .check_event = self.check_event,
        };
    }
};

pub const Timeout = struct {
    ctx: *const anyopaque,
    check_event: *const fn (*const anyopaque) bool,

    pub fn check_timeout(self: *const Timeout) bool {
        return self.check_event(self.ctx);
    }
};

pub const I2C_Datagram_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects I²C bus should be used.
    bus: I2C.I2C,

    /// The address of our I²C device.
    address: I2C.Address,

    /// Default timeout duration
    timeout: u16,

    //for the Datagram device
    config: I2C.Config,
    counter_device: ?*const CounterDevice,
    pub fn init(bus: I2C.I2C, address: I2C.Address, config: I2C.Config, counter: ?*CounterDevice, timeout: ?u16) I2C_Datagram_Device {
        return .{
            .bus = bus,
            .address = address,
            .config = config,
            .counter_device = counter,
            .timeout = timeout orelse 1000,
        };
    }

    pub fn datagram_device(dev: *const I2C_Datagram_Device) Datagram_Device {
        dev.bus.runtime_apply(dev.config) catch {};
        return .{
            .ptr = @constCast(dev),
            .vtable = &vtable,
        };
    }

    pub fn write(dev: I2C_Datagram_Device, datagram: []const u8, timeout: ?Timeout) !void {
        try dev.bus.write_blocking(dev.address, datagram, timeout);
    }

    pub fn writev(dev: I2C_Datagram_Device, datagrams: []const []const u8, timeout: ?Timeout) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, timeout);
    }

    pub fn read(dev: I2C_Datagram_Device, datagram: []u8, timeout: ?Timeout) !usize {
        try dev.bus.read_blocking(dev.address, datagram, timeout);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Datagram_Device, datagrams: []const []u8, timeout: ?Timeout) !usize {
        try dev.bus.readv_blocking(dev.address, datagrams, timeout);
        return microzig.utilities.Slice_Vector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = null,
        .disconnect_fn = null,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
    };

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        return dev.writev(chunks, timeout) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            I2C.Error.BusError,
            I2C.Error.BusTimeout,
            I2C.Error.ArbitrationLoss,
            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            => error.IoError,

            I2C.Error.Timeout => return error.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return error.IoError;
            },
            error.NoData => {},
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;

        return dev.readv(chunks, timeout) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            I2C.Error.BusError,
            I2C.Error.BusTimeout,
            I2C.Error.ArbitrationLoss,
            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.NoData,
            => error.IoError,

            I2C.Error.Timeout => return error.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return error.IoError;
            },
        };
    }
};

///
/// A Implementation of the I2C_Device interface
///
pub const I2C_Device = struct {
    /// Selects which I²C bus should be used.
    bus: I2C.I2C,

    /// Default timeout duration
    timeout: u16,
    config: I2C.Config,
    counter_device: ?*const CounterDevice,

    pub fn init(bus: I2C.I2C, config: I2C.Config, counter: ?*CounterDevice, timeout: ?u16) I2C_Device {
        return .{
            .bus = bus,
            .config = config,
            .counter_device = counter,
            .timeout = timeout orelse 1000,
        };
    }

    pub fn i2c_device(dev: *const I2C_Device) drivers.I2C_Device {
        dev.bus.runtime_apply(dev.config) catch {};
        return .{
            .ptr = @constCast(dev),
            .vtable = &i2c_vtable,
        };
    }

    pub fn write(dev: I2C_Device, address: I2CAddress, buf: []const u8) I2CError!void {
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        return dev.bus.write_blocking(.from_generic(address), buf, timeout) catch |err| switch (err) {
            error.TxFifoFlushed => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev(dev: I2C_Device, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        return dev.bus.writev_blocking(.from_generic(address), chunks, timeout) catch |err| switch (err) {
            I2C.Error.ArbitrationLoss => I2CError.UnknownAbort,
            I2C.Error.BusError => I2CError.UnknownAbort,
            I2C.Error.BusTimeout => I2CError.Timeout,
            I2C.Error.Timeout => I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| e,
        };
    }

    pub fn read(dev: I2C_Device, address: I2CAddress, buf: []u8) I2CError!usize {
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        dev.bus.read_blocking(.from_generic(address), buf, timeout) catch |err| switch (err) {
            I2C.Error.ArbitrationLoss => return I2CError.UnknownAbort,
            I2C.Error.BusError => return I2CError.UnknownAbort,
            I2C.Error.BusTimeout => return I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| e,
        };
        return buf.len;
    }

    pub fn readv(dev: I2C_Device, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        dev.bus.readv_blocking(.from_generic(address), chunks, timeout) catch |err| switch (err) {
            I2C.Error.ArbitrationLoss => return I2CError.UnknownAbort,
            I2C.Error.BusError => return I2CError.UnknownAbort,
            I2C.Error.BusTimeout => return I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| return e,
        };
        return microzig.utilities.Slice_Vector([]u8).init(chunks).size();
    }

    pub fn write_then_read(dev: I2C_Device, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        dev.bus.write_then_read_blocking(.from_generic(address), src, dst, timeout) catch |err| switch (err) {
            I2C.Error.ArbitrationLoss => I2CError.UnknownAbort,
            I2C.Error.BusError => I2CError.UnknownAbort,
            I2C.Error.BusTimeout => I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| e,
        };
    }

    pub fn writev_then_readv(
        dev: I2C_Device,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        // TODO: Should be a deadline since the timeout is doubled with two calls
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        dev.bus.writev_blocking(.from_generic(address), write_chunks, timeout) catch |err| switch (err) {
            I2C.Error.ArbitrationLoss => return I2CError.UnknownAbort,
            I2C.Error.BusError => return I2CError.UnknownAbort,
            I2C.Error.BusTimeout => return I2CError.Timeout,
            I2C.Error.Timeout => return I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| return e,
        };
        dev.bus.readv_blocking(.from_generic(address), read_chunks, timeout) catch |err| return switch (err) {
            I2C.Error.ArbitrationLoss => return I2CError.UnknownAbort,
            I2C.Error.BusError => return I2CError.UnknownAbort,
            I2C.Error.BusTimeout => return I2CError.Timeout,
            I2C.Error.Timeout => return I2CError.Timeout,
            I2C.Error.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return I2CError.UnknownAbort;
            },
            else => |e| e,
        };
    }

    const i2c_vtable = drivers.I2C_Device.VTable{
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = writev_then_readv_fn,
    };

    fn writev_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev(address, chunks);
    }

    fn readv_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.readv(address, chunks);
    }

    fn writev_then_readv_fn(
        dd: *anyopaque,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev_then_readv(address, write_chunks, read_chunks);
    }
};
