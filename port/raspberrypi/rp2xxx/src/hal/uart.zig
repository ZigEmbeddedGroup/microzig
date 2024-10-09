const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const UART0_reg = peripherals.UART0;
const UART1_reg = peripherals.UART1;

const gpio = @import("gpio.zig");
const clocks = @import("clocks.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");
const dma = @import("dma.zig");

const UartRegs = microzig.chip.types.peripherals.UART0;

pub const WordBits = enum {
    five,
    six,
    seven,
    eight,
};

pub const StopBits = enum {
    one,
    two,
};

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const ConfigError = error{
    UnsupportedBaudRate,
};

pub const Config = struct {
    clock_config: clocks.config.Global,
    baud_rate: u32,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
};

pub const TransmitError = error{
    Timeout,
};

pub const ReceiveError = error{
    OverrunError,
    BreakError,
    ParityError,
    FramingError,
    Timeout,
};

pub const ErrorStates = packed struct(u4) {
    overrun_error: bool = false,
    break_error: bool = false,
    parity_error: bool = false,
    framing_error: bool = false,
};

fn comptime_fail_or_error(msg: []const u8, fmt_args: anytype, err: ConfigError) ConfigError {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, fmt_args));
    } else {
        return err;
    }
}

/// Checks against datasheet settings for invalid baud rates.
///
/// Returns an error at runtime, and raises a compile error at comptime.
fn validate_baudrate(baud_rate: u32, peri_freq: u32) ConfigError!void {
    if (peri_freq < 16 * baud_rate) {
        return comptime_fail_or_error(
            "Peripheral clock: {d} too low for baudrate: {d}",
            .{ peri_freq, baud_rate },
            ConfigError.UnsupportedBaudRate,
        );
    } else if ((peri_freq / 65535) > 16 * baud_rate) {
        return comptime_fail_or_error(
            "Peripheral clock: {d} too high for baudrate: {d}",
            .{ peri_freq, baud_rate },
            ConfigError.UnsupportedBaudRate,
        );
    }
}

test "uart.validate_baudrate" {
    const peripheral_clk = 125_000_000;
    inline for (&.{
        4800,
        9600,
        19200,
        38400,
        57600,
        115200,
        230400,
        460800,
        921600,
    }) |baud_rate| {
        try std.testing.expectEqual(validate_baudrate(baud_rate, peripheral_clk), {});
    }
    inline for (&.{
        0,
        peripheral_clk,
        peripheral_clk / 2,
        peripheral_clk / 4,
        peripheral_clk / 8,
    }) |baud_rate| {
        try std.testing.expectError(ConfigError.UnsupportedBaudRate, validate_baudrate(baud_rate, peripheral_clk));
    }
}

pub const instance = struct {
    pub const UART0: UART = @enumFromInt(0);
    pub const UART1: UART = @enumFromInt(1);
    pub fn num(n: u1) UART {
        return @enumFromInt(n);
    }
};

/// An API for interacting with the RP2040's UART driver.
///
/// Note: Assumes proper GPIO configuration, does NOT configure GPIO pins.
///
/// Features of the peripheral that are explicitly NOT supported by this API are:
/// - CTS/RTS Hardware flow control
/// - Interrupt Driven/Asynchronous writes/reads
/// - DMA based writes/reads
pub const UART = enum(u1) {
    _,

    pub const Writer = std.io.GenericWriter(UART, TransmitError, generic_writer_fn);
    pub const Reader = std.io.GenericReader(UART, ReceiveError, generic_reader_fn);

    pub fn writer(uart: UART) Writer {
        return .{ .context = uart };
    }

    pub fn reader(uart: UART) Reader {
        return .{ .context = uart };
    }

    fn get_regs(uart: UART) *volatile UartRegs {
        return switch (@intFromEnum(uart)) {
            0 => UART0_reg,
            1 => UART1_reg,
        };
    }

    fn apply_internal(uart: UART, config: Config) void {
        const uart_regs = uart.get_regs();
        const peri_freq = config.clock_config.peri.?.frequency();
        uart.set_baudrate(config.baud_rate, peri_freq);
        uart.set_format(config.word_bits, config.stop_bits, config.parity);
        uart_regs.UARTLCR_H.modify(.{ .FEN = 1 });

        // always enable DREQ signals -- no harm if dma isn't listening
        uart_regs.UARTDMACR.modify(.{
            .TXDMAE = 1,
            .RXDMAE = 1,
        });

        uart_regs.UARTCR.modify(.{
            .UARTEN = 1,
            .TXE = 1,
            .RXE = 1,
        });
    }

    /// Apply a configuration to the UART peripheral, takes in a comptime known config to enable
    /// validation of parameters at compile time. See apply_runtime() if configuration using
    /// parameters known ONLY at runtime is needed.
    pub fn apply(uart: UART, comptime config: Config) void {
        const peri_freq = comptime config.clock_config.peri.?.frequency();
        comptime validate_baudrate(config.baud_rate, peri_freq) catch unreachable;
        uart.apply_internal(config);
    }

    /// Same as apply(), but due to parameters being runtime known, returns an error on invalid
    /// configurations.
    pub fn apply_runtime(uart: UART, config: Config) ConfigError!void {
        const peri_freq = config.clock_config.peri.?.frequency();
        try validate_baudrate(config.baud_rate, peri_freq);
        uart.apply_internal(config);
    }

    /// Disable Uart transmission, pre-fill the TX FIFO as much as possible, and then re-enable to start transmission.
    fn prime_tx_fifo(uart: UART, src: []const u8) usize {
        const uart_regs = uart.get_regs();
        uart_regs.UARTCR.modify(.{
            .TXE = 0,
        });
        var tx_remaining = src.len;
        while (tx_remaining > 0 and uart.is_writeable()) {
            uart_regs.UARTDR.write_raw(src[src.len - tx_remaining]);
            tx_remaining -= 1;
        }
        uart_regs.UARTCR.modify(.{
            .TXE = 1,
        });
        return src.len - tx_remaining;
    }

    pub inline fn is_readable(uart: UART) bool {
        return (0 == uart.get_regs().UARTFR.read().RXFE);
    }

    pub inline fn is_writeable(uart: UART) bool {
        return (0 == uart.get_regs().UARTFR.read().TXFF);
    }

    pub inline fn is_busy(uart: UART) bool {
        return (1 == uart.get_regs().UARTFR.read().BUSY);
    }

    /// Write bytes to uart TX line and block until transaction is complete.
    ///
    /// Note that this does NOT disable reception while this is happening,
    /// so if this takes too long the RX FIFO can potentially overflow.
    pub fn write_blocking(uart: UART, payload: []const u8, timeout: ?time.Duration) TransmitError!void {
        uart.writev_blocking(&.{payload}, timeout);
    }

    /// Write bytes to uart TX line and block until transaction is complete.
    ///
    /// NOTE: This function is a vectored version of `write_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    /// Note that this does NOT disable reception while this is happening,
    /// so if this takes too long the RX FIFO can potentially overflow.
    pub fn writev_blocking(uart: UART, payloads: []const []const u8, timeout: ?time.Duration) TransmitError!void {
        const uart_regs = uart.get_regs();
        const deadline = time.Deadline.init_relative(timeout);

        for (payloads) |payload| {
            var offset: usize = uart.prime_tx_fifo(payload);
            while (offset < payload.len) {
                while (!uart.is_writeable()) {
                    try deadline.check();
                }
                uart_regs.UARTDR.write_raw(payload[offset]);
                offset += 1;
            }
        }

        while (uart.is_busy()) {
            try deadline.check();
        }
    }

    /// Wraps write_blocking() for use as a GenericWriter
    fn generic_writer_fn(uart: UART, buffer: []const u8) TransmitError!usize {
        try uart.write_blocking(buffer, null);
        return buffer.len;
    }

    // TODO: Will potentially be modified in a future DMA overhaul
    pub fn dreq_tx(uart: UART) dma.Dreq {
        return switch (@intFromEnum(uart)) {
            0 => .uart0_tx,
            1 => .uart1_tx,
        };
    }

    /// Returns a struct with the current status of UART errors.
    pub fn get_errors(uart: UART) ErrorStates {
        const uart_regs = uart.get_regs();
        const read_val = uart_regs.UARTRSR.read();
        return .{
            .overrun_error = read_val.OE == 1,
            .break_error = read_val.BE == 1,
            .parity_error = read_val.PE == 1,
            .framing_error = read_val.FE == 1,
        };
    }

    /// Clears all UART errors
    pub inline fn clear_errors(uart: UART) void {
        const uart_regs = uart.get_regs();
        uart_regs.UARTRSR.write(.{
            .OE = 1,
            .BE = 1,
            .PE = 1,
            .FE = 1,
            .padding = 0,
        });
    }

    /// Returns the first active error encountered while reading a byte from the RX FIFO.
    fn read_rx_fifo_with_error_check(uart: UART) ReceiveError!u8 {
        const uart_regs = uart.get_regs();
        const read_val = uart_regs.UARTDR.read();

        if (read_val.OE == 1) {
            return ReceiveError.OverrunError;
        } else if (read_val.BE == 1) {
            return ReceiveError.BreakError;
        } else if (read_val.PE == 1) {
            return ReceiveError.ParityError;
        } else if (read_val.FE == 1) {
            return ReceiveError.FramingError;
        }
        return read_val.DATA;
    }

    /// Read bytes from uart RX line and block until transaction is complete.
    ///
    /// Returns a transaction error immediately if it occurs and doesn't
    /// complete the transaction. Errors are preserved for further inspection,
    /// so must be cleared with clear_errors() before another transaction is attempted.
    pub fn read_blocking(uart: UART, buffer: []u8, timeout: ?time.Duration) ReceiveError!void {
        return uart.readv_blocking(&.{buffer}, timeout);
    }

    /// Read bytes from uart RX line and block until transaction is complete.
    ///
    /// NOTE: This function is a vectored version of `read_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    /// Returns a transaction error immediately if it occurs and doesn't
    /// complete the transaction. Errors are preserved for further inspection,
    /// so must be cleared with clear_errors() before another transaction is attempted.
    pub fn readv_blocking(uart: UART, buffers: []const []u8, timeout: ?time.Duration) ReceiveError!void {
        const deadline = time.Deadline.init_relative(timeout);

        for (buffers) |buffer| {
            for (buffer) |*byte| {
                while (!uart.is_readable()) {
                    try deadline.check();
                }
                byte.* = try uart.read_rx_fifo_with_error_check();
            }
        }
    }

    /// Convenience function for waiting for a single byte to come across the RX line.
    pub fn read_word(uart: UART, timeout: ?time.Duration) ReceiveError!u8 {
        var byte: [1]u8 = undefined;
        try uart.read_blocking(&byte, timeout);
        return byte[0];
    }

    /// Wraps read_blocking() for use as a GenericReader
    fn generic_reader_fn(uart: UART, buffer: []u8) ReceiveError!usize {
        try uart.read_blocking(buffer, null);
        return buffer.len;
    }

    pub fn set_format(
        uart: UART,
        word_bits: WordBits,
        stop_bits: StopBits,
        parity: Parity,
    ) void {
        const uart_regs = uart.get_regs();
        uart_regs.UARTLCR_H.modify(.{
            .WLEN = switch (word_bits) {
                .eight => @as(u2, 0b11),
                .seven => @as(u2, 0b10),
                .six => @as(u2, 0b01),
                .five => @as(u2, 0b00),
            },
            .STP2 = switch (stop_bits) {
                .one => @as(u1, 0),
                .two => @as(u1, 1),
            },
            .PEN = switch (parity) {
                .none => @as(u1, 0),
                .even, .odd => @as(u1, 1),
            },
            .EPS = switch (parity) {
                .even => @as(u1, 1),
                .odd, .none => @as(u1, 0),
            },
        });
    }

    pub fn set_baudrate(uart: UART, baud_rate: u32, peri_freq: u32) void {
        const uart_regs = uart.get_regs();
        const baud_rate_div = (8 * peri_freq / baud_rate);
        var baud_ibrd = @as(u16, @intCast(baud_rate_div >> 7));

        const baud_fbrd: u6 = if (baud_ibrd == 0) baud_fbrd: {
            baud_ibrd = 1;
            break :baud_fbrd 0;
        } else if (baud_ibrd >= 65535) baud_fbrd: {
            baud_ibrd = 65535;
            break :baud_fbrd 0;
        } else @as(u6, @intCast(((@as(u7, @truncate(baud_rate_div))) + 1) / 2));

        uart_regs.UARTIBRD.write(.{ .BAUD_DIVINT = baud_ibrd, .padding = 0 });
        uart_regs.UARTFBRD.write(.{ .BAUD_DIVFRAC = baud_fbrd, .padding = 0 });

        // PL011 needs a (dummy) LCR_H write to latch in the divisors.
        // We don't want to actually change LCR_H contents here.
        uart_regs.UARTLCR_H.modify(.{});
    }
};

var uart_logger: ?UART.Writer = null;

/// Set a specific uart instance to be used for logging.
///
/// Allows system logging over uart via:
/// pub const microzig_options = .{
///     .logFn = hal.uart.logFn,
/// };
pub fn init_logger(uart: UART) void {
    uart_logger = uart.writer();
    uart_logger.?.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
}

/// Disables logging via the uart instance.
pub fn deinit_logger() void {
    uart_logger = null;
}

pub fn logFn(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const level_prefix = comptime "[{}.{:0>6}] " ++ level.asText();
    const prefix = comptime level_prefix ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (uart_logger) |uart| {
        const current_time = time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;

        uart.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
    }
}
