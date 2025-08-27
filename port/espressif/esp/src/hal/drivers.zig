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
const I2CError = drivers.I2C_Device.Error;
const I2CAddress = drivers.I2C_Device.Address;

///
/// A datagram device attached to an I²C bus.
///
pub const I2C_Datagram_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;

    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects which I²C bus should be used.
    bus: hal.i2c.I2C,

    /// The address of our I²C device.
    address: hal.i2c.Address,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, address: hal.i2c.Address, timeout: ?mdf.time.Duration) I2C_Datagram_Device {
        return .{
            .bus = bus,
            .address = address,
            .timeout = timeout,
        };
    }

    pub fn datagram_device(dev: *I2C_Datagram_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: I2C_Datagram_Device) ConnectError!void {
        _ = dev;
    }

    pub fn disconnect(dev: I2C_Datagram_Device) void {
        _ = dev;
    }

    pub fn write(dev: I2C_Datagram_Device, datagram: []const u8) !void {
        try dev.bus.write_blocking(dev.address, datagram, dev.timeout);
    }

    pub fn writev(dev: I2C_Datagram_Device, datagrams: []const []const u8) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, dev.timeout);
    }

    pub fn read(dev: I2C_Datagram_Device, datagram: []u8) !usize {
        try dev.bus.read_blocking(dev.address, datagram, dev.timeout);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Datagram_Device, datagrams: []const []u8) !usize {
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
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks) catch |e|
            switch (e) {
                hal.i2c.Error.Timeout => WriteError.Timeout,
                else => WriteError.IoError,
            };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |e|
            switch (e) {
                hal.i2c.Error.Timeout => WriteError.Timeout,
                else => WriteError.IoError,
            };
    }
};

///
/// A Implementation of the I2C_Device interface
///
pub const I2C_Device = struct {
    /// Selects which I²C bus should be used.
    bus: hal.i2c.I2C,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, timeout: ?mdf.time.Duration) I2C_Device {
        return .{
            .bus = bus,
            .timeout = timeout,
        };
    }

    pub fn i2c_device(dev: *I2C_Device) drivers.I2C_Device {
        return .{
            .ptr = dev,
            .vtable = &i2c_vtable,
        };
    }

    pub fn write(dev: I2C_Device, address: I2CAddress, buf: []const u8) I2CError!void {
        return dev.bus.write_blocking(address, buf, dev.timeout) catch |err| switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev(dev: I2C_Device, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        return dev.bus.writev_blocking(address, chunks, dev.timeout) catch |err| switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn read(dev: I2C_Device, address: I2CAddress, buf: []u8) I2CError!usize {
        dev.bus.read_blocking(address, buf, dev.timeout) catch |err| return switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
        return buf.len;
    }

    pub fn readv(dev: I2C_Device, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        dev.bus.readv_blocking(address, chunks, dev.timeout) catch |err| return switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
        return microzig.utilities.Slice_Vector([]u8).init(chunks).size();
    }

    pub fn write_then_read(dev: I2C_Device, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
        dev.bus.write_then_read_blocking(address, src, dst, dev.timeout) catch |err| return switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev_then_readv(
        dev: I2C_Device,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        // TODO: When writev_then_readv_blocking is implemented in the HAL, use that.
        // NOTE: Since we are making two calls with the same timeout, we are effectively doubling
        // the timeout here.
        dev.bus.writev_blocking(address, write_chunks, dev.timeout) catch |err| return switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
            else => |e| e,
        };
        dev.bus.readv_blocking(address, read_chunks, dev.timeout) catch |err| return switch (err) {
            error.FifoExceeded => I2CError.UnknownAbort,
            error.ArbitrationLost => I2CError.UnknownAbort,
            error.ExecutionIncomplete => I2CError.UnknownAbort,
            error.CommandNumberExceeded => I2CError.UnknownAbort,
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

///
/// A datagram device attached to an SPI half duplex connection.
///
pub const SPI_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;

    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    pub const ChipSelect = struct {
        pin: hal.gpio.Pin,
        active_level: Digital_IO.State,
    };

    bus: hal.spi.SPI_Bus,
    bit_mode: hal.spi.BitMode,
    maybe_chip_select: ?ChipSelect = null,

    pub fn init(bus: hal.spi.SPI_Bus, bit_mode: hal.spi.BitMode, maybe_chip_select: ?ChipSelect) SPI_Device {
        if (maybe_chip_select) |chip_select| {
            chip_select.pin.apply(.{
                .output_enable = true,
            });
        }

        const dev: SPI_Device = .{
            .bus = bus,
            .bit_mode = bit_mode,
            .maybe_chip_select = maybe_chip_select,
        };

        dev.disconnect();

        return dev;
    }

    pub fn datagram_device(dev: *SPI_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: SPI_Device) ConnectError!void {
        if (dev.maybe_chip_select) |chip_select| {
            chip_select.pin.write(switch (chip_select.active_level) {
                .low => .low,
                .high => .high,
            });
        }
    }

    pub fn disconnect(dev: SPI_Device) void {
        if (dev.maybe_chip_select) |chip_select| {
            chip_select.pin.write(switch (chip_select.active_level) {
                .low => .high,
                .high => .low,
            });
        }
    }

    pub fn write(dev: SPI_Device, datagram: []const u8) WriteError!void {
        return dev.bus.write_blocking(datagram, dev.bit_mode);
    }

    pub fn writev(dev: SPI_Device, datagrams: []const []const u8) WriteError!void {
        return dev.bus.writev_blocking(datagrams, dev.bit_mode);
    }

    pub fn read(dev: SPI_Device, datagram: []u8) ReadError!usize {
        return dev.bus.read_blocking(datagram, dev.bit_mode);
    }

    pub fn readv(dev: SPI_Device, datagrams: []const []u8) ReadError!usize {
        return dev.bus.readv_blocking(datagrams, dev.bit_mode);
    }

    pub fn write_then_read(
        dev: SPI_Device,
        src: []const u8,
        dst: []u8,
    ) (WriteError || ReadError)!void {
        try dev.write(src);
        _ = try dev.read(dst);
    }

    pub fn writev_then_readv(
        dev: SPI_Device,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) (WriteError || ReadError)!void {
        try dev.writev(write_chunks);
        _ = try dev.readv(read_chunks);
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = connect_fn,
        .disconnect_fn = disconnect_fn,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = writev_then_readv_fn,
    };

    fn connect_fn(dd: *anyopaque) ConnectError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.connect();
    }

    fn disconnect_fn(dd: *anyopaque) void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        dev.disconnect();
    }

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks);
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks);
    }

    fn writev_then_readv_fn(
        dd: *anyopaque,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) (WriteError || ReadError)!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        return dev.writev_then_readv(write_chunks, read_chunks);
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
/// Implementation of a `Clock_Device` that uses the HAL's `time` module.
///
pub fn clock_device() Clock_Device {
    const S = struct {
        const vtable: Clock_Device.VTable = .{
            .get_time_since_boot = get_time_since_boot_fn,
        };

        fn get_time_since_boot_fn(_: *anyopaque) time.Absolute {
            return hal.time.get_time_since_boot();
        }
    };

    return .{
        .ptr = undefined,
        .vtable = &S.vtable,
    };
}
