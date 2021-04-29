const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

/// A UART configuration. The config defaults to the *8N1* setting, so "8 data bits, no parity, 1 stop bit" which is the 
/// most common serial format.
pub const Config = struct {
    baud_rate: u32,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
    data_bits: DataBits = .@"8",
};

const DataBits = enum {
    @"5",
    @"6",
    @"7",
    @"8",
    @"9",
};

const StopBits = enum { one, two };

const Parity = enum {
    none,
    even,
    odd,
    mark,
    space,
};

pub fn Uart(comptime index: usize) type {
    return struct {
        const Self = @This();

        /// Initializes the UART with the given config and returns a handle to the uart.
        pub fn init(config: Config) Self {
            micro.clock.ensure();
            return Self{};
        }

        pub fn reader(self: Self) Reader {
            return Reader{ .context = self };
        }

        pub fn writer(self: Self) Writer {
            return Writer{ .context = self };
        }

        const ReadError = error{
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
        const WriteError = error{};
        pub const Reader = std.io.Reader(Self, ReadError, readSome);
        pub const Writer = std.io.Writer(Self, WriteError, writeSome);

        fn readSome(self: Self, buffer: []u8) ReadError!usize {
            return 0;
        }
        fn writeSome(self: Self, buffer: []const u8) WriteError!usize {
            return 0;
        }
    };
}
