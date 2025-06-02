//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const mdf = microzig.drivers;

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Datagram_Device = drivers.Datagram_Device;
const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;

///
/// A datagram device attached to an I²C bus.
///
pub const I2C_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;

    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects which I²C bus should be used.
    bus: hal.i2c.I2C,

    /// The address of our I²C device.
    address: hal.i2c.Address,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, address: hal.i2c.Address, timeout: ?mdf.time.Duration) I2C_Device {
        return .{
            .bus = bus,
            .address = address,
            .timeout = timeout,
        };
    }

    pub fn datagram_device(dev: *I2C_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: I2C_Device) ConnectError!void {
        _ = dev;
    }

    pub fn disconnect(dev: I2C_Device) void {
        _ = dev;
    }

    pub fn write(dev: I2C_Device, datagram: []const u8) !void {
        try dev.bus.write_blocking(dev.address, datagram, dev.timeout);
    }

    pub fn writev(dev: I2C_Device, datagrams: []const []const u8) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, dev.timeout);
    }

    pub fn read(dev: I2C_Device, datagram: []u8) !usize {
        try dev.bus.read_blocking(dev.address, datagram, dev.timeout);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Device, datagrams: []const []u8) !usize {
        try dev.bus.readv_blocking(dev.address, datagrams, dev.timeout);

        return microzig.utilities.Slice_Vector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = connect_fn,
        .disconnect_fn = disconnect_fn,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
    };

    fn connect_fn(dd: *anyopaque) ConnectError!void {
        _ = dd;
        return;
    }

    fn disconnect_fn(dd: *anyopaque) void {
        _ = dd;
        return;
    }

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks) catch |e|
            switch (e) {
                hal.i2c.Error.Timeout => WriteError.Timeout,
                else => WriteError.IoError,
            };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |e|
            switch (e) {
                hal.i2c.Error.Timeout => WriteError.Timeout,
                else => WriteError.IoError,
            };
    }
};

///
/// A datagram device attached to an SPI half duplex connection.
///
pub const SPI_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;

    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    pub const ChipSelect = struct {
        pin: hal.gpio.Pin,
        active_level: hal.gpio.Level,
    };

    bus: hal.spi.SPI_Bus,
    bit_mode: hal.spi.BitMode,
    chip_select: ?ChipSelect = null,

    pub fn init(bus: hal.spi.SPI_Bus, bit_mode: hal.spi.BitMode, chip_select: ?ChipSelect) SPI_Device {
        return .{
            .bus = bus,
            .bit_mode = bit_mode,
            .chip_select = chip_select,
        };
    }

    pub fn datagram_device(dev: *SPI_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: SPI_Device) ConnectError!void {
        if (dev.chip_select) |chip_select| {
            chip_select.pin.write(chip_select.active_level);
        }
    }

    pub fn disconnect(dev: SPI_Device) void {
        if (dev.chip_select) |chip_select| {
            chip_select.pin.write(if (chip_select.active_level == .high) .low else .high);
        }
    }

    pub fn write(dev: SPI_Device, datagram: []const u8) WriteError!void {
        dev.bus.write_blocking(datagram, dev.bit_mode);
    }

    pub fn writev(dev: SPI_Device, datagrams: []const []const u8) WriteError!void {
        dev.bus.writev_blocking(datagrams, dev.bit_mode);
    }

    pub fn read(dev: SPI_Device, datagram: []u8) ReadError!usize {
        dev.bus.read_blocking(datagram, dev.bit_mode);
        return datagram.len;
    }

    pub fn readv(dev: SPI_Device, datagrams: []const []u8) ReadError!usize {
        dev.bus.readv_blocking(datagrams, dev.bit_mode);
        return microzig.utilities.Slice_Vector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = connect_fn,
        .disconnect_fn = disconnect_fn,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
    };

    fn connect_fn(dd: *anyopaque) ConnectError!void {
        _ = dd;
        return;
    }

    fn disconnect_fn(dd: *anyopaque) void {
        _ = dd;
        return;
    }

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks);
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks);
    }
};

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
