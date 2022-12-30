const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

/// An SPI bus
pub fn Spi(comptime index: usize) type {
    const SystemSpi = chip.Spi(index);

    const SpiDevice = struct {
        const Device = @This();

        internal: SystemSpi,

        const Transfer = struct {
            const Self = @This();

            device: Device,

            pub const Writer = std.io.Writer(*Self, WriteError, writeSome);

            pub fn writer(self: *Self) Writer {
                return Writer{ .context = self };
            }

            fn writeSome(self: *Self, buffer: []const u8) WriteError!usize {
                try self.device.internal.writeAll(buffer);
                return buffer.len;
            }

            pub const Reader = std.io.Reader(*Self, ReadError, readSome);

            pub fn reader(self: *Self) Reader {
                return Reader{ .context = self };
            }

            fn readSome(self: *Self, buffer: []u8) ReadError!usize {
                try self.device.internal.readInto(buffer);
                return buffer.len;
            }

            pub fn end(self: *Self) void {
                self.device.internal.endTransfer();
            }
        };

        pub fn beginTransfer(device: Device) !Transfer {
            device.internal.beginTransfer();
            return Transfer{ .device = device };
        }
    };

    return struct {
        const Self = @This();

        internal: SystemSpi,

        /// Initializes the SPI bus with the given config and returns a handle to the uart.
        pub fn init(config: BusConfig) InitError!Self {
            micro.clock.ensure(); // TODO: Wat?
            return Self{
                .internal = try SystemSpi.init(config),
            };
        }

        pub fn device(self: Self, comptime cs_pin: type, config: DeviceConfig) SpiDevice {
            _ = cs_pin; // TODO
            _ = config; //TODO
            return SpiDevice{ .internal = self.internal };
        }
    };
}

/// A SPI bus configuration.
pub const BusConfig = struct {
    // Later: add common options
};

/// A SPI device configuration (excluding the pin).
pub const DeviceConfig = struct {
    // TODO: add common options
};

pub const InitError = error{
// TODO: add common options
};

pub const WriteError = error{};
pub const ReadError = error{};
