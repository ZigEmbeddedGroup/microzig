//! USART0 for the ATmega328P (asynchronous mode, polling).
//!
//! RXD is PD0 and TXD is PD1. On Arduino Nano-style boards they are wired to
//! the USB-to-serial chip. Enabling the receiver and transmitter overrides the
//! GPIO configuration of both pins, so no pin setup is needed.
//!
//! Functions that return an error with a payload (`E!u8`) don't compile for
//! AVR yet (https://codeberg.org/ziglang/zig/issues/37099), so reads use an
//! out parameter and there are no `std.Io` interfaces yet.

const std = @import("std");
const microzig = @import("microzig");

const USART0 = microzig.chip.peripherals.USART0;
/// Largest accepted baud rate error. This is above the datasheet's
/// recommendation, so that 115200 baud at 16 MHz (+2.1 %) is accepted, as
/// in Arduino.
const max_baud_error = 0.025;

pub const Parity = enum { none, even, odd };
pub const StopBits = enum { one, two };

/// Board-level UART setup. Boards export a `uart_setup` const of this type;
/// the application passes its own settings (baud rate, etc.) to `apply`.
pub const Setup = struct {
    /// CPU clock in Hz.
    cpu_frequency: u32,

    /// Configures USART0 and enables the receiver and transmitter.
    pub fn apply(comptime setup: Setup, comptime config: Config) void {
        const baud = comptime compute_baud(setup.cpu_frequency, config.baud_rate);

        USART0.UBRR0 = baud.ubrr;
        // Single write: FE0, DOR0 and UPE0 must be written as zero.
        USART0.UCSR0A.write_raw(if (baud.double_speed) 0b10 else 0); // U2X0
        USART0.UCSR0C.write(.{
            .UCPOL0 = 0,
            .UCSZ0 = 0b11, // 8 data bits (with UCSZ02 = 0)
            .USBS0 = switch (config.stop_bits) {
                .one => .@"1_BIT",
                .two => .@"2_BIT",
            },
            .UPM0 = switch (config.parity) {
                .none => .DISABLED,
                .even => .ENABLED_EVEN_PARITY,
                .odd => .ENABLED_ODD_PARITY,
            },
            .UMSEL0 = .ASYNCHRONOUS_USART,
        });
        USART0.UCSR0B.modify(.{
            .RXEN0 = 1,
            .TXEN0 = 1,
        });
    }
};

pub const Config = struct {
    baud_rate: u32 = 115_200,
    parity: Parity = .none,
    stop_bits: StopBits = .one,
};

pub const ReceiveError = error{
    FramingError,
    OverrunError,
    ParityError,
};

const Baud = struct {
    ubrr: u12,
    double_speed: bool,
    @"error": comptime_float,
};

fn compute_baud(cpu_frequency: comptime_float, baud_rate: comptime_float) Baud {
    var best: ?Baud = null;
    for ([_]bool{ false, true }) |double_speed| {
        const divisor: comptime_float = if (double_speed) 8 else 16;
        // UBRR0 + 1 divides the clock; try the nearest values on both sides.
        const ideal = cpu_frequency / (divisor * baud_rate);
        for ([_]comptime_float{ @floor(ideal), @ceil(ideal) }) |n_unclamped| {
            const n = std.math.clamp(n_unclamped, 1, 4096);
            const @"error" = (cpu_frequency / (divisor * n) - baud_rate) / baud_rate;
            if (best == null or @abs(@"error") < @abs(best.?.@"error"))
                best = .{ .ubrr = @intFromFloat(n - 1), .double_speed = double_speed, .@"error" = @"error" };
        }
    }

    if (@abs(best.?.@"error") > max_baud_error)
        @compileError(std.fmt.comptimePrint(
            "baud rate {d} can't be generated from {d} Hz (error {d:.2} %)",
            .{ baud_rate, cpu_frequency, best.?.@"error" * 100 },
        ));

    return best.?;
}

test compute_baud {
    try std.testing.expect(compute_baud(16_000_000, 115_200).ubrr == 16);
    try std.testing.expect(compute_baud(16_000_000, 115_200).double_speed);
    try std.testing.expect(compute_baud(16_000_000, 9_600).ubrr == 103);
    try std.testing.expect(compute_baud(16_000_000, 97_600).ubrr == 20);
    try std.testing.expect(compute_baud(16_000_000, 242).ubrr == 4095);
}

pub fn write_byte_blocking(byte: u8) void {
    while (USART0.UCSR0A.read().UDRE0 == 0) {}
    USART0.UDR0 = byte;
}

/// Returns once the last byte is queued, not when it has been sent.
pub fn write_blocking(payload: []const u8) void {
    for (payload) |byte| write_byte_blocking(byte);
}

pub fn is_readable() bool {
    return USART0.UCSR0A.read().RXC0 == 1;
}

/// Waits for a byte and stores it in `byte`. On error, `byte` still holds the
/// byte that was read.
pub fn read_byte_blocking(byte: *u8) ReceiveError!void {
    while (!is_readable()) {}

    // The error flags belong to the byte in UDR0, so read them first.
    const status = USART0.UCSR0A.read();
    byte.* = USART0.UDR0;

    if (status.FE0 == 1) return error.FramingError;
    if (status.DOR0 == 1) return error.OverrunError;
    if (status.UPE0 == 1) return error.ParityError;
}

/// Fills `buffer`. On error, `buffer` holds the bytes read so far, including
/// the one that failed.
pub fn read_blocking(buffer: []u8) ReceiveError!void {
    for (buffer) |*byte| try read_byte_blocking(byte);
}
