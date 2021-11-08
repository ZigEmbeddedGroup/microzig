const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

pub fn Uart(comptime index: usize) type {
    const SystemUart = chip.Uart(index);
    return struct {
        const Self = @This();

        internal: SystemUart,

        /// Initializes the UART with the given config and returns a handle to the uart.
        pub fn init(config: Config) InitError!Self {
            //micro.clock.ensure();
            return Self{
                .internal = try SystemUart.init(config),
            };
        }

        pub fn canRead(self: Self) bool {
            return self.internal.canRead();
        }

        pub fn canWrite(self: Self) bool {
            return self.internal.canWrite();
        }

        pub fn reader(self: Self) Reader {
            return Reader{ .context = self };
        }

        pub fn writer(self: Self) Writer {
            return Writer{ .context = self };
        }

        pub const Reader = std.io.Reader(Self, ReadError, readSome);
        pub const Writer = std.io.Writer(Self, WriteError, writeSome);

        fn readSome(self: Self, buffer: []u8) ReadError!usize {
            for (buffer) |*c| {
                c.* = self.internal.rx();
            }
            return buffer.len;
        }
        fn writeSome(self: Self, buffer: []const u8) WriteError!usize {
            for (buffer) |c| {
                self.internal.tx(c);
            }
            return buffer.len;
        }
    };
}

/// A UART configuration. The config defaults to the *8N1* setting, so "8 data bits, no parity, 1 stop bit" which is the 
/// most common serial format.
pub const Config = struct {
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
