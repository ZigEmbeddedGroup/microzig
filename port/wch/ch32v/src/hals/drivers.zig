//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const gpio = @import("./gpio.zig");
const i2c = @import("./i2c.zig");
const spi = @import("./spi.zig");
const mdf = microzig.drivers;

const time = microzig.hal.time;

const drivers = microzig.drivers.base;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;
const I2CError = drivers.I2C_Device.Error;
const I2CAddress = drivers.I2C_Device.Address;

///
/// A Implementation of the I2C_Device interface
/// Generic over I2C configuration to enable compile-time DMA optimization
///
pub fn I2C_Device(comptime config: i2c.Config) type {
    return struct {
        const Self = @This();

        /// Selects which I²C bus should be used.
        bus: i2c.I2C,

        /// Default timeout duration
        timeout: ?mdf.time.Duration = null,

        pub fn init(bus: i2c.I2C, timeout: ?mdf.time.Duration) Self {
            return .{
                .bus = bus,
                .timeout = timeout,
            };
        }

        pub fn i2c_device(dev: *Self) drivers.I2C_Device {
            return .{
                .ptr = dev,
                .vtable = &i2c_vtable,
            };
        }

        pub fn write(dev: Self, address: I2CAddress, buf: []const u8) I2CError!void {
            return dev.bus.write_auto(config, address, buf, dev.timeout) catch |err| switch (err) {
                error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                else => |e| e,
            };
        }

        pub fn writev(dev: Self, address: I2CAddress, chunks: []const []const u8) I2CError!void {
            return dev.bus.writev_auto(config, address, chunks, dev.timeout) catch |err| switch (err) {
                error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                else => |e| e,
            };
        }

        pub fn read(dev: Self, address: I2CAddress, buf: []u8) I2CError!usize {
            dev.bus.read_auto(config, address, buf, dev.timeout) catch |err| return switch (err) {
                error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                else => |e| e,
            };
            return buf.len;
        }

        pub fn readv(dev: Self, address: I2CAddress, chunks: []const []u8) I2CError!usize {
            dev.bus.readv_auto(config, address, chunks, dev.timeout) catch |err| return switch (err) {
                error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                else => |e| e,
            };
            return microzig.utilities.SliceVector([]u8).init(chunks).size();
        }

        pub fn write_then_read(dev: Self, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
            const write_chunks: []const []const u8 = &.{src};
            const read_chunks: []const []u8 = &.{dst};
            dev.bus.writev_then_readv_auto(config, address, write_chunks, read_chunks, dev.timeout) catch |err|
                return switch (err) {
                    error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                    else => |e| e,
                };
        }

        pub fn writev_then_readv(
            dev: Self,
            address: I2CAddress,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) I2CError!void {
            return dev.bus.writev_then_readv_auto(config, address, write_chunks, read_chunks, dev.timeout) catch |err|
                switch (err) {
                    error.ArbitrationLost, error.BusError, error.Overrun => I2CError.UnknownAbort,
                    else => |e| e,
                };
        }

        const i2c_vtable = drivers.I2C_Device.VTable{
            .writev_fn = writev_fn,
            .readv_fn = readv_fn,
            .writev_then_readv_fn = writev_then_readv_fn,
        };

        fn writev_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []const u8) I2CError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.writev(address, chunks);
        }

        fn readv_fn(dd: *anyopaque, address: I2CAddress, chunks: []const []u8) I2CError!usize {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.readv(address, chunks);
        }

        fn writev_then_readv_fn(
            dd: *anyopaque,
            address: I2CAddress,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) I2CError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.writev_then_readv(address, write_chunks, read_chunks);
        }
    };
}

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

    pin: gpio.Pin,

    pub fn init(pin: gpio.Pin) GPIO_Device {
        return .{ .pin = pin };
    }

    pub fn digital_io(dio: *GPIO_Device) Digital_IO {
        return Digital_IO{
            .ptr = dio,
            .vtable = &vtable,
        };
    }

    pub fn set_direction(dio: GPIO_Device, dir: Direction) SetDirError!void {
        dio.pin.set_mode(switch (dir) {
            .output => .{ .output = .general_purpose_push_pull },
            .input => .{ .input = .pull },
        });
    }

    pub fn set_bias(dio: GPIO_Device, maybe_bias: ?State) SetBiasError!void {
        dio.pin.set_pull(if (maybe_bias) |bias| switch (bias) {
            .low => .down,
            .high => .up,
        } else .disabled);
    }

    pub fn write(dio: GPIO_Device, state: State) WriteError!void {
        dio.pin.put(state.value());
    }

    pub fn read(dio: GPIO_Device) ReadError!State {
        return @enumFromInt(dio.pin.read());
    }

    const vtable = Digital_IO.VTable{
        .set_direction_fn = set_direction_fn,
        .set_bias_fn = set_bias_fn,
        .write_fn = write_fn,
        .read_fn = read_fn,
    };

    fn set_direction_fn(io: *anyopaque, dir: Direction) SetDirError!void {
        const gd: *GPIO_Device = @ptrCast(@alignCast(io));
        try gd.set_direction(dir);
    }

    fn set_bias_fn(io: *anyopaque, bias: ?State) SetBiasError!void {
        const gd: *GPIO_Device = @ptrCast(@alignCast(io));

        try gd.set_bias(bias);
    }

    fn write_fn(io: *anyopaque, state: State) WriteError!void {
        const gd: *GPIO_Device = @ptrCast(@alignCast(io));

        try gd.write(state);
    }

    fn read_fn(io: *anyopaque) ReadError!State {
        const gd: *GPIO_Device = @ptrCast(@alignCast(io));
        return try gd.read();
    }
};

/// A SPI Datagram Device implementation
/// Generic over SPI configuration to enable compile-time DMA optimization
/// Manages chip select pin via connect/disconnect
///
pub fn SPI_Datagram_Device(comptime config: spi.Config) type {
    return struct {
        const Self = @This();

        /// Selects which SPI bus should be used
        bus: spi.SPI,

        /// Chip select pin (managed by this device)
        cs_pin: gpio.Pin,

        /// CS polarity (false = active low, true = active high)
        cs_active_high: bool,

        /// Default timeout duration
        timeout: ?mdf.time.Duration = null,

        pub fn init(
            bus: spi.SPI,
            cs_pin: gpio.Pin,
            cs_active_high: bool,
            timeout: ?mdf.time.Duration,
        ) Self {
            return .{
                .bus = bus,
                .cs_pin = cs_pin,
                .cs_active_high = cs_active_high,
                .timeout = timeout,
            };
        }

        pub fn datagram_device(dev: *Self) Datagram_Device {
            return .{
                .ptr = dev,
                .vtable = &datagram_vtable,
            };
        }

        /// Assert chip select
        fn assert_cs(dev: Self) void {
            dev.cs_pin.put(if (dev.cs_active_high) 1 else 0);
        }

        /// Deassert chip select
        fn deassert_cs(dev: Self) void {
            dev.cs_pin.put(if (dev.cs_active_high) 0 else 1);
        }

        pub fn writev(dev: Self, chunks: []const []const u8) Datagram_Device.WriteError!void {
            return dev.bus.writev_auto(config, chunks, dev.timeout) catch |err| switch (err) {
                error.Timeout => Datagram_Device.WriteError.Timeout,
                else => Datagram_Device.WriteError.IoError,
            };
        }

        pub fn readv(dev: Self, chunks: []const []u8) Datagram_Device.ReadError!void {
            return dev.bus.readv_auto(config, chunks, dev.timeout) catch |err| switch (err) {
                error.Timeout => Datagram_Device.ReadError.Timeout,
                else => Datagram_Device.ReadError.IoError,
            };
        }

        pub fn writev_then_readv(
            dev: Self,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) Datagram_Device.ReadError!void {
            // Send write chunks
            dev.bus.writev_auto(config, write_chunks, dev.timeout) catch |err|
                return switch (err) {
                error.Timeout => Datagram_Device.ReadError.Timeout,
                else => Datagram_Device.ReadError.IoError,
            };

            // Receive read chunks
            dev.bus.readv_auto(config, read_chunks, dev.timeout) catch |err|
                return switch (err) {
                error.Timeout => Datagram_Device.ReadError.Timeout,
                else => Datagram_Device.ReadError.IoError,
            };
        }

        const datagram_vtable = Datagram_Device.VTable{
            .connect_fn = connect_fn,
            .disconnect_fn = disconnect_fn,
            .writev_fn = writev_fn,
            .readv_fn = readv_fn,
            .writev_then_readv_fn = writev_then_readv_fn,
        };

        fn connect_fn(dd: *anyopaque) Datagram_Device.ConnectError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            dev.assert_cs();
        }

        fn disconnect_fn(dd: *anyopaque) void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            dev.deassert_cs();
        }

        fn writev_fn(dd: *anyopaque, chunks: []const []const u8) Datagram_Device.WriteError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.writev(chunks);
        }

        fn readv_fn(dd: *anyopaque, chunks: []const []u8) Datagram_Device.ReadError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.readv(chunks);
        }

        fn writev_then_readv_fn(
            dd: *anyopaque,
            write_chunks: []const []const u8,
            read_chunks: []const []u8,
        ) Datagram_Device.ReadError!void {
            const dev: *Self = @ptrCast(@alignCast(dd));
            return dev.writev_then_readv(write_chunks, read_chunks);
        }
    };
}

///
/// Implementation of a time device
///
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
        const t = time.get_time_since_boot().to_us();
        return @enumFromInt(t);
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

        fn get_time_since_boot_fn(_: *anyopaque) mdf.time.Absolute {
            return time.get_time_since_boot();
        }
    };

    return .{
        .ptr = undefined,
        .vtable = &S.vtable,
    };
}
