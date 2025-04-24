//!
//! This file implements driver abstractions based on HAL devices.
//!

const std = @import("std");
const microzig = @import("microzig");
const hal = @import("../hal.zig");

const drivers = microzig.drivers.base;
const time = microzig.drivers.time;

const Datagram_Device = drivers.Datagram_Device;
const Stream_Device = drivers.Stream_Device;
const Digital_IO = drivers.Digital_IO;
const Clock_Device = drivers.Clock_Device;

///
/// A datagram device attached to an I²C bus.
///
pub const I2C_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    /// Selects I²C bus should be used.
    bus: hal.i2c.I2C,

    /// The address of our I²C device.
    address: hal.i2c.Address,

    pub fn init(bus: hal.i2c.I2C, address: hal.i2c.Address) I2C_Device {
        return .{
            .bus = bus,
            .address = address,
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
        try dev.bus.write_blocking(dev.address, datagram, null);
    }

    pub fn writev(dev: I2C_Device, datagrams: []const []const u8) !void {
        try dev.bus.writev_blocking(dev.address, datagrams, null);
    }

    pub fn read(dev: I2C_Device, datagram: []u8) !usize {
        try dev.bus.read_blocking(dev.address, datagram, null);
        return datagram.len;
    }

    pub fn readv(dev: I2C_Device, datagrams: []const []u8) !usize {
        try dev.bus.readv_blocking(dev.address, datagrams, null);
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
        return dev.writev(chunks) catch |err| switch (err) {
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.TargetAddressReserved,
            => return error.Unsupported,

            error.UnknownAbort,
            error.TxFifoFlushed,
            => return error.IoError,

            error.Timeout => return error.Timeout,
            error.NoData => {},
        };
    }

    fn readv_fn(dd: *anyopaque, chunks: []const []u8) ReadError!usize {
        const dev: *I2C_Device = @ptrCast(@alignCast(dd));
        return dev.readv(chunks) catch |err| switch (err) {
            error.DeviceNotPresent,
            error.NoAcknowledge,
            error.TargetAddressReserved,
            => return error.Unsupported,

            error.UnknownAbort,
            error.TxFifoFlushed,
            => return error.IoError,

            error.Timeout => return error.Timeout,
            error.NoData => return 0,
        };
    }
};

///
/// A datagram device attached to an SPI bus.
///
pub const SPI_Device = struct {
    pub const ConnectError = Datagram_Device.ConnectError;
    pub const WriteError = Datagram_Device.WriteError;
    pub const ReadError = Datagram_Device.ReadError;

    bus: hal.spi.SPI,
    chip_select: hal.gpio.Pin,
    active_level: Digital_IO.State,
    rx_dummy_data: u8,

    pub const InitOptions = struct {
        /// The active level for the chip select pin
        active_level: Digital_IO.State = .low,

        /// Which dummy byte should be sent during reads
        rx_dummy_data: u8 = 0x00,
    };

    pub fn init(
        bus: hal.spi.SPI,
        chip_select: hal.gpio.Pin,
        options: InitOptions,
    ) SPI_Device {
        chip_select.set_function(.sio);
        chip_select.set_direction(.out);

        var dev: SPI_Device = .{
            .bus = bus,
            .chip_select = chip_select,
            .active_level = options.active_level,
            .rx_dummy_data = options.rx_dummy_data,
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
        const actual_level = dev.chip_select.read();

        const target_level: u1 = switch (dev.active_level) {
            .low => 0,
            .high => 1,
        };

        if (target_level == actual_level)
            return error.DeviceBusy;

        dev.chip_select.put(target_level);
    }

    pub fn disconnect(dev: SPI_Device) void {
        dev.chip_select.put(switch (dev.active_level) {
            .low => 1,
            .high => 0,
        });
    }

    pub fn write(dev: SPI_Device, datagrams: []const u8) !void {
        dev.bus.writev_blocking(u8, datagrams);
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