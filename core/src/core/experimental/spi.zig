const std = @import("std");
const hal = @import("hal");
const clock = @import("clock.zig"); // Is there a different/better way?

/// The SPI bus with the given environment-specific number.
/// Only 'master' mode is supported currently.
pub fn SpiBus(comptime index: usize) type {
    const SystemSpi = hal.SpiBus(index);

    return struct {
        /// A SPI 'slave' device, selected via the given CS pin.
        /// (Default is CS=low to select.)
        pub fn SpiDevice(comptime cs_pin: type, comptime config: DeviceConfig) type {
            return struct {
                const SelfSpiDevice = @This();

                internal: SystemSpi,

                /// A 'transfer' is defined as a sequence of reads/writes that require
                /// the SPI device to be continuously enabled via its 'chip select' (CS) line.
                const Transfer = struct {
                    const SelfTransfer = @This();

                    device: SelfSpiDevice,

                    fn transceive_byte(self: *SelfTransfer, write_byte: u8, read_pointer: *u8) !void {
                        try self.device.internal.transceive_byte(write_byte, read_pointer);
                    }

                    pub const Writer = std.io.Writer(*SelfTransfer, WriteError, write_some);

                    /// Return a standard Writer (which ignores the bytes read).
                    pub fn writer(self: *SelfTransfer) Writer {
                        return Writer{ .context = self };
                    }

                    fn write_some(self: *SelfTransfer, buffer: []const u8) WriteError!usize {
                        try self.device.internal.write_all(buffer);
                        return buffer.len;
                    }

                    pub const Reader = std.io.Reader(*SelfTransfer, ReadError, read_some);

                    /// Return a standard Reader (which writes arbitrary bytes).
                    pub fn reader(self: *SelfTransfer) Reader {
                        return Reader{ .context = self };
                    }

                    fn read_some(self: *SelfTransfer, buffer: []u8) ReadError!usize {
                        try self.device.internal.read_into(buffer);
                        return buffer.len;
                    }

                    /// end the current transfer, releasing via the CS pin
                    pub fn end(self: *SelfTransfer) void {
                        self.device.internal.end_transfer(cs_pin, config);
                    }
                };

                /// start a new transfer, selecting using the CS pin
                pub fn begin_transfer(self: SelfSpiDevice) !Transfer {
                    self.internal.switch_to_device(cs_pin, config);
                    self.internal.begin_transfer(cs_pin, config);
                    return Transfer{ .device = self };
                }

                pub fn transceive(self: SelfSpiDevice, write_buffer: []const u8, read_buffer: []u8) !void {
                    std.debug.assert(write_buffer.len == read_buffer.len);
                    var transfer = try self.begin_transfer();
                    defer transfer.end();
                    for (write_buffer, 0..) |_, i| {
                        try transfer.transceive_byte(write_buffer[i], &read_buffer[i]);
                    }
                }

                /// Shorthand for 'register-based' devices
                pub fn write_register(self: SelfSpiDevice, register_address: u8, byte: u8) ReadError!void {
                    try self.write_registers(register_address, &.{byte});
                }

                /// Shorthand for 'register-based' devices
                pub fn write_registers(self: SelfSpiDevice, register_address: u8, buffer: []const u8) ReadError!void {
                    var transfer = try self.begin_transfer();
                    defer transfer.end();
                    // write auto-increment, starting at given register
                    try transfer.writer().writeByte(0b01_000000 | register_address);
                    try transfer.writer().writeAll(buffer);
                }

                /// Shorthand for 'register-based' devices
                pub fn read_register(self: SelfSpiDevice, register_address: u8) ReadError!u8 {
                    var buffer: [1]u8 = undefined;
                    try self.read_registers(register_address, &buffer);
                    return buffer[0];
                }

                /// Shorthand for 'register-based' devices
                pub fn read_registers(self: SelfSpiDevice, register_address: u8, buffer: []u8) ReadError!void {
                    var transfer = try self.begin_transfer();
                    defer transfer.end();
                    // read auto-increment, starting at given register
                    try transfer.writer().writeByte(0b11_000000 | register_address);
                    try transfer.reader().readNoEof(buffer);
                }
            };
        }

        const SelfSpiBus = @This();

        internal: SystemSpi,

        /// Initialize this SPI bus and return a handle to it.
        pub fn init(config: BusConfig) InitError!SelfSpiBus {
            clock.ensure(); // TODO: Wat?
            return SelfSpiBus{
                .internal = try SystemSpi.init(config),
            };
        }

        /// Create (a descriptor for) a device on this SPI bus.
        pub fn device(self: SelfSpiBus, comptime cs_pin: type, config: DeviceConfig) SpiDevice(cs_pin, config) {
            return SpiDevice(cs_pin, config){ .internal = self.internal };
        }
    };
}

/// A SPI bus configuration.
/// (There are no bus configuration options yet.)
pub const BusConfig = struct {
    // Later: add common options
};

/// A SPI device configuration (excluding the CS pin).
/// (There are no device configuration options yet.)
pub const DeviceConfig = struct {
    // TODO: add common options, like clock polarity and phase, and CS polarity
};

pub const InitError = error{
    // TODO: add common options
    };

pub const WriteError = error{};
pub const ReadError = error{
    EndOfStream,
};
