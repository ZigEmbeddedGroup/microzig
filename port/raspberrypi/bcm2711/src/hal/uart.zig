//! PL011 UART, the one the BCM2711 datasheet calls UART0.
//!
//! On a Raspberry Pi 4 the firmware leaves this uart wired to the bluetooth module and puts the
//! mini uart on the header instead. `apply` routes it to GPIO14 and GPIO15 by putting those pads
//! in alt0, which takes the header back from the mini uart and leaves bluetooth without a uart.
//! That is the right trade for a bare metal image: unlike the mini uart, the PL011 baud rate does
//! not move with the VideoCore core clock.

const std = @import("std");
const assert = std.debug.assert;
const microzig = @import("microzig");
const UART0 = microzig.chip.peripherals.UART0;

const gpio = @import("gpio.zig");

/// Reference clock of the PL011, in Hz. The firmware brings it up at 48 MHz; `init_uart_clock`
/// in config.txt changes it.
pub const clock_freq: u32 = 48_000_000;

pub const Config = struct {
    baud_rate: u32 = 115200,
    /// Pads to route the uart onto. GPIO14 and GPIO15 are the header pins of a Raspberry Pi.
    tx_pin: ?gpio.Pin = gpio.num(14),
    rx_pin: ?gpio.Pin = gpio.num(15),
};

/// Brings the uart up and routes it onto the given pads.
pub fn apply(config: Config) void {
    // Disable while reconfiguring, then drain what the firmware may have left in flight.
    UART0.CR.write(.{
        .UARTEN = 0,
        .SIREN = 0,
        .SIRLP = 0,
        .reserved3 = 0,
        .LBE = 0,
        .TXE = 0,
        .RXE = 0,
        .DTR = 0,
        .RTS = 0,
        .OUT1 = 0,
        .OUT2 = 0,
        .RTSEN = 0,
        .CTSEN = 0,
        .padding = 0,
    });
    while (UART0.FR.read().BUSY == 1) {}

    if (config.tx_pin) |pin| pin.apply(.{ .function = .alt0, .pull = .none });
    if (config.rx_pin) |pin| pin.apply(.{ .function = .alt0, .pull = .up });

    // The divisor is clock / (16 * baud) in 6.6 fixed point, so compute it in sixty fourths and
    // split it afterwards.
    const divisor_64ths = (@as(u64, clock_freq) * 4) / config.baud_rate;
    assert(divisor_64ths >= 64);

    UART0.IBRD.write(.{ .IBRD = @intCast(divisor_64ths / 64), .padding = 0 });
    UART0.FBRD.write(.{ .FBRD = @intCast(divisor_64ths % 64), .padding = 0 });

    // Eight bits, no parity, one stop bit, fifos on. Writing LCRH latches the baud registers.
    UART0.LCRH.write(.{
        .BRK = 0,
        .PEN = 0,
        .EPS = 0,
        .STP2 = 0,
        .FEN = 1,
        .WLEN = 0b11,
        .SPS = 0,
        .padding = 0,
    });

    // Mask every interrupt, this port polls.
    UART0.IMSC.write(.{ .MASK = 0 });
    UART0.ICR.write(.{ .CLEAR = 0x7ff });

    UART0.CR.write(.{
        .UARTEN = 1,
        .SIREN = 0,
        .SIRLP = 0,
        .reserved3 = 0,
        .LBE = 0,
        .TXE = 1,
        .RXE = @intFromBool(config.rx_pin != null),
        .DTR = 0,
        .RTS = 0,
        .OUT1 = 0,
        .OUT2 = 0,
        .RTSEN = 0,
        .CTSEN = 0,
        .padding = 0,
    });
}

/// Blocks until the byte is in the transmit fifo.
pub fn write_byte(byte: u8) void {
    while (UART0.FR.read().TXFF == 1) {}
    UART0.DR.write(.{ .DATA = byte, .FE = 0, .PE = 0, .BE = 0, .OE = 0, .padding = 0 });
}

pub fn write(bytes: []const u8) void {
    for (bytes) |byte| write_byte(byte);
}

/// Blocks until a byte arrives.
pub fn read_byte() u8 {
    while (UART0.FR.read().RXFE == 1) {}
    return UART0.DR.read().DATA;
}

/// Blocks until everything queued has left the shift register.
pub fn flush() void {
    while (UART0.FR.read().BUSY == 1) {}
}

/// UART logger. To use this, add `.logFn = uart.logger.log` to your `microzig_options`, and call
/// `uart.apply(.{})` before the first log line.
pub const logger = struct {
    var buffer: [256]u8 = undefined;
    var writer = std.Io.Writer{
        .buffer = &buffer,
        .vtable = &.{
            .drain = logger.drain,
        },
    };

    fn drain(w: *std.Io.Writer, data: []const []const u8, splat: usize) std.Io.Writer.Error!usize {
        write(w.buffer[0..w.end]);
        w.end = 0;

        var n: usize = 0;
        for (0..data.len - 1) |i| {
            write(data[i]);
            n += data[i].len;
        }

        for (0..splat) |_| {
            write(data[data.len - 1]);
            n += data[data.len - 1].len;
        }

        return n;
    }

    pub fn log(
        comptime level: std.log.Level,
        comptime scope: @TypeOf(.EnumLiteral),
        comptime format: []const u8,
        args: anytype,
    ) void {
        const level_prefix = comptime level.asText();
        const prefix = comptime level_prefix ++ switch (scope) {
            .default => ": ",
            else => " (" ++ @tagName(scope) ++ "): ",
        };

        writer.print(prefix ++ format ++ "\r\n", args) catch {};
        writer.flush() catch {};
    }
};
