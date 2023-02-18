const std = @import("std");
const micro = @import("microzig");
const chip = @import("chip");

pub fn Uart(comptime index: usize, comptime pins: Pins) type {
    const SystemUart = chip.Uart(index, pins);
    return struct {
        const Self = @This();

        internal: SystemUart,

        /// Initializes the UART with the given config and returns a handle to the uart.
        pub fn init(config: Config) InitError!Self {
            micro.clock.ensure();
            return Self{
                .internal = try SystemUart.init(config),
            };
        }

        /// If the UART is already initialized, try to return a handle to it,
        /// else initialize with the given config.
        pub fn get_or_init(config: Config) InitError!Self {
            if (!@hasDecl(SystemUart, "getOrInit")) {
                // fallback to reinitializing the UART
                return init(config);
            }
            return Self{
                .internal = try SystemUart.getOrInit(config),
            };
        }

        pub fn can_read(self: Self) bool {
            return self.internal.canRead();
        }

        pub fn can_write(self: Self) bool {
            return self.internal.canWrite();
        }

        pub fn reader(self: Self) Reader {
            return Reader{ .context = self };
        }

        pub fn writer(self: Self) Writer {
            return Writer{ .context = self };
        }

        pub const Reader = std.io.Reader(Self, ReadError, read_some);
        pub const Writer = std.io.Writer(Self, WriteError, write_some);

        fn read_some(self: Self, buffer: []u8) ReadError!usize {
            for (buffer) |*c| {
                c.* = self.internal.rx();
            }
            return buffer.len;
        }
        fn write_some(self: Self, buffer: []const u8) WriteError!usize {
            for (buffer) |c| {
                self.internal.tx(c);
            }
            return buffer.len;
        }
    };
}

/// The pin configuration. This is used to optionally configure specific pins to be used with the chosen UART.
/// This makes sense only with microcontrollers supporting multiple pins for a UART peripheral.
pub const Pins = struct {
    tx: ?type = null,
    rx: ?type = null,
};

/// A UART configuration. The config defaults to the *8N1* setting, so "8 data bits, no parity, 1 stop bit" which is the
/// most common serial format.
pub const Config = struct {
    /// TODO: Make this optional, to support STM32F303 et al. auto baud-rate detection?
    baud_rate: u32,
    stop_bits: StopBits = .one,
    parity: ?Parity = null,
    data_bits: DataBits = .eight,
};

// TODO: comptime verify that the enums are valid
pub const DataBits = chip.uart.DataBits;
pub const StopBits = chip.uart.StopBits;
pub const Parity = chip.uart.Parity;

pub const InitError = error{
    UnsupportedWordSize,
    UnsupportedParity,
    UnsupportedStopBitCount,
    UnsupportedBaudRate,
};

pub const ReadError = error{
    /// The input buffer received a byte while the receive fifo is already full.
    /// Devices with no fifo fill overrun as soon as a second byte arrives.
    Overrun,
    /// A byte with an invalid parity bit was received.
    ParityError,
    /// The stop bit of our byte was not valid.
    FramingError,
    /// The break interrupt error will happen when RXD is logic zero for
    /// the duration of a full byte.
    BreakInterrupt,
};
pub const WriteError = error{};
