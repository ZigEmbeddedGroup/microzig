const std = @import("std");
const microzig = @import("microzig");
const I2c = @import("i2c.zig");
const drivers = microzig.drivers.base;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;

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

pub const I2C_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects I²C bus should be used.
    bus: I2c.I2C,

    /// The address of our I²C device.
    address: I2c.Address,

    //for the Datagram device
    config: I2c.Config,
    counter_device: ?*const CounterDevice,
    timeout: u16,
    pub fn init(bus: I2c.I2C, address: I2c.Address, config: I2c.Config, counter: ?*CounterDevice, timeout: ?u16) I2C_Device {
        return .{
            .bus = bus,
            .address = address,
            .config = config,
            .counter_device = counter,
            .timeout = timeout orelse 1000,
        };
    }

    pub fn datagram_device(dev: *const I2C_Device) Datagram_Device {
        dev.bus.runtime_apply(dev.config) catch {};
        return .{
            .ptr = @constCast(dev),
            .vtable = &vtable,
        };
    }

    pub fn write(dev: I2C_Device, datagram: []const u8, timeout: ?Timeout) !void {
        try dev.bus.write_blocking(dev.address, datagram, timeout);
    }

    pub fn writev(dev: I2C_Device, datagrams: []const []const u8, timeout: ?Timeout) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, timeout);
    }

    pub fn read(dev: I2C_Device, datagram: []u8, timeout: ?Timeout) !usize {
        try dev.bus.read_blocking(dev.address, datagram, timeout);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Device, datagrams: []const []u8, timeout: ?Timeout) !usize {
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
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;
        return dev.writev(chunks, timeout) catch |err| switch (err) {
            I2c.IOError.AckFailure,
            I2c.IOError.BusError,
            I2c.IOError.BusTimeout,
            I2c.IOError.ArbitrationLoss,
            => return error.IoError,

            I2c.IOError.Timeout => return error.Timeout,
            I2c.IOError.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return error.IoError;
            },
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        const timeout = if (dev.counter_device) |counter| counter.make_ms_timeout(dev.timeout) else null;

        return dev.readv(chunks, timeout) catch |err| switch (err) {
            I2c.IOError.AckFailure,
            I2c.IOError.BusError,
            I2c.IOError.BusTimeout,
            I2c.IOError.ArbitrationLoss,
            => return error.IoError,

            I2c.IOError.Timeout => return error.Timeout,
            I2c.IOError.UnrecoverableError => {
                dev.bus.runtime_apply(dev.config) catch {};
                return error.IoError;
            },
        };
    }
};
