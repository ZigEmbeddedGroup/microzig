//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");
const mdf = microzig.drivers;

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
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
    address: I2CAddress,

    /// Default timeout duration
    timeout: ?mdf.time.Duration = null,

    pub fn init(bus: hal.i2c.I2C, address: I2CAddress, timeout: ?mdf.time.Duration) I2C_Datagram_Device {
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

    pub fn write_then_read(dev: I2C_Datagram_Device, src: []const u8, dst: []u8) !void {
        try dev.bus.write_then_read_blocking(dev.address, src, dst, dev.timeout);
    }

    pub fn writev_then_readv(dev: I2C_Datagram_Device, write_chunks: []const []const u8, read_chunks: []const []u8) !void {
        try dev.bus.writev_then_readv_blocking(dev.address, write_chunks, read_chunks, dev.timeout);
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = null,
        .disconnect_fn = null,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
        .writev_then_readv_fn = writev_then_readv_fn,
    };

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.writev(chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.TxFifoFlushed,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => {},
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.TxFifoFlushed,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => return 0,
        };
    }

    fn writev_then_readv_fn(
        dd: *anyopaque,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) (WriteError || ReadError)!void {
        const dev: *I2C_Datagram_Device = @ptrCast(@alignCast(dd));
        return dev.writev_then_readv(write_chunks, read_chunks) catch |err| switch (err) {
            error.TargetAddressReserved,
            error.IllegalAddress,
            => error.Unsupported,

            error.BufferOverrun,
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.UnknownAbort,
            error.TxFifoFlushed,
            => error.IoError,

            error.Timeout => error.Timeout,
            error.NoData => {},
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
            error.TxFifoFlushed => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn writev(dev: I2C_Device, address: I2CAddress, chunks: []const []const u8) I2CError!void {
        return dev.bus.writev_blocking(address, chunks, dev.timeout) catch |err| switch (err) {
            error.TxFifoFlushed => I2CError.UnknownAbort,
            else => |e| e,
        };
    }

    pub fn read(dev: I2C_Device, address: I2CAddress, buf: []u8) I2CError!usize {
        dev.bus.read_blocking(address, buf, dev.timeout) catch |err| return switch (err) {
            error.TxFifoFlushed => I2CError.UnknownAbort,
            else => |e| e,
        };
        return buf.len;
    }

    pub fn readv(dev: I2C_Device, address: I2CAddress, chunks: []const []u8) I2CError!usize {
        dev.bus.readv_blocking(address, chunks, dev.timeout) catch |err| return switch (err) {
            error.TxFifoFlushed => I2CError.UnknownAbort,
            else => |e| e,
        };
        return microzig.utilities.Slice_Vector([]u8).init(chunks).size();
    }

    pub fn write_then_read(dev: I2C_Device, address: I2CAddress, src: []const u8, dst: []u8) I2CError!void {
        try dev.bus.write_then_read_blocking(address, src, dst, dev.timeout);
    }

    pub fn writev_then_readv(
        dev: I2C_Device,
        address: I2CAddress,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) I2CError!void {
        return dev.bus.writev_then_readv_blocking(address, write_chunks, read_chunks, dev.timeout) catch |err| switch (err) {
            error.TxFifoFlushed => I2CError.UnknownAbort,
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
/// A datagram device attached to an SPI bus.
///
pub const SPI_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;
    pub const ChipSelect = struct {
        pin: hal.gpio.Pin,
        active_level: Digital_IO.State = .low,
    };

    bus: hal.spi.SPI,
    chip_select: ?ChipSelect = null,
    rx_dummy_data: u8,

    pub const InitOptions = struct {
        /// The active level for the chip select pin
        active_level: Digital_IO.State = .low,

        /// Which dummy byte should be sent during reads
        rx_dummy_data: u8 = 0x00,
    };

    pub fn init(bus: hal.spi.SPI, chip_select: ChipSelect, rx_dummy_data: u8) SPI_Device {
        if (chip_select) |cs| {
            cs.pin.set_function(.sio);
            cs.pin.set_direction(.out);
        }

        var dev: SPI_Device = .{
            .bus = bus,
            .chip_select = chip_select,
            .rx_dummy_data = rx_dummy_data,
        };
        // set the chip select to "deselect" the device
        dev.disconnect();
        return dev;
    }

    pub fn datagram_device(dev: *SPI_Device) Datagram_Device {
        return .{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn connect(dev: SPI_Device) !void {
        if (dev.chip_select) |cs| {
            const actual_level = cs.pin.read();

            const target_level: u1 = switch (cs.active_level) {
                .low => 0,
                .high => 1,
            };

            if (target_level == actual_level)
                return error.DeviceBusy;

            cs.pin.put(target_level);
        }
    }

    pub fn disconnect(dev: SPI_Device) void {
        if (dev.chip_select) |cs|
            cs.pin.put(switch (cs.active_level) {
                .low => 1,
                .high => 0,
            });
    }

    pub fn write(dev: SPI_Device, datagrams: []const u8) !void {
        dev.bus.write_blocking(u8, datagrams);
    }

    pub fn writev(dev: SPI_Device, datagrams: []const []const u8) !void {
        dev.bus.writev_blocking(u8, datagrams);
    }

    pub fn read(dev: SPI_Device, datagrams: []u8) !void {
        dev.bus.read_blocking(u8, dev.rx_dummy_data, datagrams);
    }

    pub fn readv(dev: SPI_Device, datagrams: []const []const u8) !usize {
        dev.bus.readv_blocking(u8, dev.rx_dummy_data, datagrams);
        return microzig.utilities.Slice_Vector([]u8).init(datagrams).size();
    }

    const vtable = Datagram_Device.VTable{
        .connect_fn = connect_fn,
        .disconnect_fn = disconnect_fn,
        .writev_fn = writev_fn,
        .readv_fn = readv_fn,
    };

    fn connect_fn(dd: *anyopaque) ConnectError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        try dev.connect();
    }

    fn disconnect_fn(dd: *anyopaque) void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        dev.disconnect();
    }

    fn writev_fn(dd: *anyopaque, chunks: []const []const u8) WriteError!void {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        dev.bus.writev_blocking(u8, chunks);
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *SPI_Device = @ptrCast(@alignCast(dd));
        dev.bus.readv_blocking(u8, dev.rx_dummy_data, chunks);
        return microzig.utilities.Slice_Vector([]u8).init(chunks).size();
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
        dio.pin.set_direction(switch (dir) {
            .output => .out,
            .input => .in,
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

const Cyw43PioSpi = microzig.hal.cyw49_pio_spi.Cyw43PioSpi;
const Cyw43_Spi = microzig.drivers.wireless.Cyw43_Spi;
const Cyw43_Bus = microzig.drivers.wireless.Cyw43_Bus;
const Cyw43_Runner = microzig.drivers.wireless.Cyw43_Runner;

pub const CYW43_Pio_Device_Config = struct {
    spi: hal.cyw49_pio_spi.Cyw43PioSpi_Config,
    pwr_pin: hal.gpio.Pin,
};

// TODO: CYW43 top level struct just for testing purpose (please redesign)
pub const CYW43_Pio_Device = struct {
    const Self = @This();
    pwr_pin: GPIO_Device = undefined,
    cyw43_pio_spi: Cyw43PioSpi = undefined,
    cyw43_spi: Cyw43_Spi = undefined,
    cyw43_bus: Cyw43_Bus = undefined,
    cyw43_runner: Cyw43_Runner = undefined,

    pub fn init(this: *Self, config: CYW43_Pio_Device_Config) !void {
        std.log.info("before gpio init", .{});

        this.cyw43_pio_spi = try hal.cyw49_pio_spi.init(config.spi);
        this.cyw43_spi = this.cyw43_pio_spi.cyw43_spi();

        config.pwr_pin.set_function(.sio);
        config.pwr_pin.set_direction(.out);
        var pwr_gpio = GPIO_Device.init(config.pwr_pin);

        this.cyw43_bus = .{ .pwr_pin = pwr_gpio.digital_io(), .spi = &this.cyw43_spi, .internal_delay_ms = hal.time.sleep_ms };
        this.cyw43_runner = .{ .bus = &this.cyw43_bus, .internal_delay_ms = hal.time.sleep_ms };

        try this.cyw43_runner.init();
    }

    pub fn test_loop(this: *Self) void {
        while (true) {
            this.cyw43_runner.run();
        }
    }
};
