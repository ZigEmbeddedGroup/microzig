const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

/// An SPI bus
pub fn Spi(comptime index: usize) type {
    const SystemSpi = chip.Spi(index);

    const SpiDevice = struct {
        const Device = @This();
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

        pub fn device(_: Self, comptime cs_pin: type, config: DeviceConfig) SpiDevice {
            _ = cs_pin; // TODO
            _ = config; //TODO
            return SpiDevice{};
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
