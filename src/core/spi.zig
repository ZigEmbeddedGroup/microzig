const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

/// An SPI bus
pub fn Spi(comptime index: usize) type {
    const SystemSpi = chip.Spi(index);

    return struct {
        pub fn SpiDevice(comptime cs_pin: type) type {
            return struct {
                const SelfSpiDevice = @This();

                internal: SystemSpi,

                const Transfer = struct {
                    const SelfTransfer = @This();

                    device: SelfSpiDevice,

                    pub const Writer = std.io.Writer(*SelfTransfer, WriteError, writeSome);

                    pub fn writer(self: *SelfTransfer) Writer {
                        return Writer{ .context = self };
                    }

                    fn writeSome(self: *SelfTransfer, buffer: []const u8) WriteError!usize {
                        try self.device.internal.writeAll(buffer);
                        return buffer.len;
                    }

                    pub const Reader = std.io.Reader(*SelfTransfer, ReadError, readSome);

                    pub fn reader(self: *SelfTransfer) Reader {
                        return Reader{ .context = self };
                    }

                    fn readSome(self: *SelfTransfer, buffer: []u8) ReadError!usize {
                        try self.device.internal.readInto(buffer);
                        return buffer.len;
                    }

                    pub fn end(self: *SelfTransfer) void {
                        self.device.internal.endTransfer(cs_pin);
                    }
                };

                pub fn beginTransfer(dev: SelfSpiDevice) !Transfer {
                    dev.internal.beginTransfer(cs_pin);
                    return Transfer{ .device = dev };
                }
            };
        }

        const SelfSpi = @This();

        internal: SystemSpi,

        /// Initializes the SPI bus with the given config and returns a handle to it.
        pub fn init(config: BusConfig) InitError!SelfSpi {
            micro.clock.ensure(); // TODO: Wat?
            return SelfSpi{
                .internal = try SystemSpi.init(config),
            };
        }

        pub fn device(self: SelfSpi, comptime cs_pin: type, config: DeviceConfig) SpiDevice(cs_pin) {
            _ = config; //TODO
            return SpiDevice(cs_pin){ .internal = self.internal };
        }
    };
}

/// A SPI bus configuration.
pub const BusConfig = struct {
    // Later: add common options
};

/// A SPI device configuration (excluding the CS pin).
pub const DeviceConfig = struct {
    // TODO: add common options
};

pub const InitError = error{
// TODO: add common options
};

pub const WriteError = error{};
pub const ReadError = error{};
