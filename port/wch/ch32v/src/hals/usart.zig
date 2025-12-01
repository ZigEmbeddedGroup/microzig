//!
//! This file implements the USART driver for the CH32V chip family
//!
//! Based on the WCH CH32V20x USART peripheral implementation.
//!
const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;

const USART1 = microzig.chip.peripherals.USART1;
const USART2 = microzig.chip.peripherals.USART2;
const USART3 = microzig.chip.peripherals.USART3;

const UsartRegs = microzig.chip.types.peripherals.USART1;

pub const WordBits = enum {
    eight,
    nine,
};

pub const StopBits = enum {
    one,
    half,
    two,
    one_and_half,
};

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const FlowControl = enum {
    none,
    CTS,
    RTS,
    CTS_RTS,
};

pub const ConfigError = error{
    UnsupportedBaudRate,
};

pub const Config = struct {
    baud_rate: u32 = 115200,
    word_bits: WordBits = .eight,
    stop_bits: StopBits = .one,
    parity: Parity = .none,
    flow_control: FlowControl = .none,
};

pub const TransmitError = error{
    Timeout,
};

pub const ReceiveError = error{
    OverrunError,
    FramingError,
    ParityError,
    NoiseError,
    Timeout,
};

pub const instance = struct {
    pub const USART1: USART = @enumFromInt(0);
    pub const USART2: USART = @enumFromInt(1);
    pub const USART3: USART = @enumFromInt(2);
    pub fn num(n: u2) USART {
        return @enumFromInt(n);
    }
};

pub const USART = enum(u2) {
    _,

    pub const USART_With_Timeout = struct {
        instance: USART,
        deadline: mdf.time.Deadline,
    };

    pub const Writer = std.io.GenericWriter(USART_With_Timeout, TransmitError, generic_writer_fn);
    pub const Reader = std.io.GenericReader(USART_With_Timeout, ReceiveError, generic_reader_fn);

    pub fn writer(usart: USART, deadline: mdf.time.Deadline) Writer {
        return .{ .context = .{ .instance = usart, .deadline = deadline } };
    }

    pub fn reader(usart: USART, deadline: mdf.time.Deadline) Reader {
        return .{ .context = .{ .instance = usart, .deadline = deadline } };
    }

    pub inline fn get_regs(usart: USART) *volatile UsartRegs {
        return switch (@intFromEnum(usart)) {
            0 => USART1,
            1 => USART2,
            2 => USART3,
            else => unreachable,
        };
    }

    /// Get the peripheral clock frequency for this USART instance
    inline fn get_pclk(usart: USART) u32 {
        const rcc_clocks = hal.clocks.get_freqs();
        return switch (@intFromEnum(usart)) {
            0 => rcc_clocks.pclk2, // USART1 is on APB2
            1, 2 => rcc_clocks.pclk1, // USART2/3 are on APB1
            else => unreachable,
        };
    }

    /// Apply configuration to the USART peripheral
    pub fn apply(usart: USART, comptime config: Config) void {
        const regs = usart.get_regs();

        // Configure stop bits
        const stop_bits_val: u2 = switch (config.stop_bits) {
            .one => 0b00,
            .half => 0b01,
            .two => 0b10,
            .one_and_half => 0b11,
        };
        regs.CTLR2.modify(.{ .STOP = stop_bits_val });

        // Configure word length, parity, and mode
        const word_length: u1 = switch (config.word_bits) {
            .eight => 0,
            .nine => 1,
        };
        const parity_enable: u1 = if (config.parity == .none) 0 else 1;
        const parity_select: u1 = switch (config.parity) {
            .even => 0,
            .odd => 1,
            .none => 0,
        };

        regs.CTLR1.modify(.{
            .M = word_length,
            .PCE = parity_enable,
            .PS = parity_select,
            .TE = 1, // Enable transmitter
            .RE = 1, // Enable receiver
        });

        // Configure hardware flow control
        const rts_enable: u1 = switch (config.flow_control) {
            .RTS, .CTS_RTS => 1,
            else => 0,
        };
        const cts_enable: u1 = switch (config.flow_control) {
            .CTS, .CTS_RTS => 1,
            else => 0,
        };
        regs.CTLR3.modify(.{
            .RTSE = rts_enable,
            .CTSE = cts_enable,
        });

        // Set baud rate
        const pclk = usart.get_pclk();
        usart.set_baudrate(config.baud_rate, pclk);

        // Enable USART
        regs.CTLR1.modify(.{ .UE = 1 });
    }

    /// Set the baud rate for the USART
    /// CH32V always uses 16x oversampling (no OVER8 configuration)
    pub fn set_baudrate(usart: USART, baud_rate: u32, pclk: u32) void {
        const regs = usart.get_regs();

        // Calculate baud rate divisor for 16x oversampling
        // Formula: BRR = (25 * PCLK) / (4 * baud_rate)
        const integerdivider = (25 * pclk) / (4 * baud_rate);

        const mantissa = integerdivider / 100;
        const fraction_part = integerdivider - (100 * mantissa);

        const fraction = ((fraction_part * 16 + 50) / 100) & 0x0F;

        const brr_value = (mantissa << 4) | fraction;
        regs.BRR.write_raw(@intCast(brr_value));
    }

    /// Check if transmit data register is empty (can write)
    pub inline fn is_writeable(usart: USART) bool {
        return usart.get_regs().STATR.read().TXE == 1;
    }

    /// Check if receive data register is not empty (can read)
    pub inline fn is_readable(usart: USART) bool {
        return usart.get_regs().STATR.read().RXNE == 1;
    }

    /// Check if transmission is complete
    pub inline fn is_tx_complete(usart: USART) bool {
        return usart.get_regs().STATR.read().TC == 1;
    }

    /// Write a single byte (non-blocking)
    pub inline fn write_byte(usart: USART, byte: u8) void {
        usart.get_regs().DATAR.write_raw(byte);
    }

    /// Read a single byte (non-blocking)
    pub inline fn read_byte(usart: USART) u8 {
        return @intCast(usart.get_regs().DATAR.read().DR);
    }

    /// Check for errors and return them
    /// TRM 18.10.1 (USARTx_STATR): PE/FE/NE (and IDLE) are cleared by reading the status register
    /// then reading the data register. ORE is also cleared by the SR→DR read sequence. Note the TRM
    /// caveat for PE:
    /// > Before this bit is cleared, the software must wait for RXNE to be set.
    /// Our call sites only invoke check_errors() after RXNE is set.
    fn check_errors(usart: USART) ReceiveError!void {
        const regs = usart.get_regs();
        const status = regs.STATR.read();

        // Determine which (if any) error occurred, prefer first-match order
        var err: ?ReceiveError = null;
        if (status.ORE == 1) {
            err = ReceiveError.OverrunError;
        } else if (status.FE == 1) {
            err = ReceiveError.FramingError;
        } else if (status.PE == 1) {
            err = ReceiveError.ParityError;
        } else if (status.NE == 1) {
            err = ReceiveError.NoiseError;
        }

        // If any error was detected, clear by reading SR then DR once
        if (err) |e| {
            _ = regs.STATR.read();
            _ = regs.DATAR.read();
            return e;
        }
    }

    /// Write bytes to USART TX and block until complete
    pub fn write_blocking(usart: USART, payload: []const u8, deadline: mdf.time.Deadline) TransmitError!void {
        return try usart.writev_blocking(&.{payload}, deadline);
    }

    /// Vectored write - writes multiple buffers in sequence
    pub fn writev_blocking(usart: USART, payloads: []const []const u8, deadline: mdf.time.Deadline) TransmitError!void {
        var iter = microzig.utilities.SliceVector([]const u8).init(payloads).iterator();
        while (iter.next_chunk(null)) |payload| {
            for (payload) |byte| {
                // Wait for TX register to be empty
                while (!usart.is_writeable()) {
                    if (deadline.is_reached_by(hal.time.get_time_since_boot())) {
                        return TransmitError.Timeout;
                    }
                }
                usart.write_byte(byte);
            }
        }

        // Wait for transmission to complete
        while (!usart.is_tx_complete()) {
            if (deadline.is_reached_by(hal.time.get_time_since_boot())) {
                return TransmitError.Timeout;
            }
        }
    }

    /// Wraps write_blocking() for use as a GenericWriter
    fn generic_writer_fn(usart: USART_With_Timeout, buffer: []const u8) TransmitError!usize {
        try usart.instance.write_blocking(buffer, usart.deadline);
        return buffer.len;
    }

    /// Read bytes from USART RX and block until complete
    pub fn read_blocking(usart: USART, buffer: []u8, deadline: mdf.time.Deadline) ReceiveError!void {
        return usart.readv_blocking(&.{buffer}, deadline);
    }

    /// Vectored read - reads into multiple buffers in sequence
    pub fn readv_blocking(usart: USART, buffers: []const []u8, deadline: mdf.time.Deadline) ReceiveError!void {
        var iter = microzig.utilities.SliceVector([]u8).init(buffers).iterator();
        while (iter.next_chunk(null)) |buffer| {
            for (buffer) |*byte| {
                // Wait for RX register to have data
                while (!usart.is_readable()) {
                    if (deadline.is_reached_by(hal.time.get_time_since_boot())) {
                        return ReceiveError.Timeout;
                    }
                }

                // Check for errors before reading
                try usart.check_errors();

                byte.* = usart.read_byte();
            }
        }
    }

    /// Read a single byte with timeout
    pub fn read_word_blocking(usart: USART, deadline: mdf.time.Deadline) ReceiveError!u8 {
        var byte: [1]u8 = undefined;
        try usart.read_blocking(&byte, deadline);
        return byte[0];
    }

    /// Read a single byte if available, otherwise returns null
    pub fn read_word(usart: USART) ReceiveError!?u8 {
        if (!usart.is_readable()) return null;
        try usart.check_errors();
        return usart.read_byte();
    }

    /// Wraps read_blocking() for use as a GenericReader
    fn generic_reader_fn(usart: USART_With_Timeout, buffer: []u8) ReceiveError!usize {
        try usart.instance.read_blocking(buffer, usart.deadline);
        return buffer.len;
    }
};

var usart_logger: ?USART.Writer = null;

/// Set a specific USART instance to be used for logging
pub fn init_logger(usart: USART) void {
    usart_logger = usart.writer(.no_deadline);
    usart_logger.?.writeAll("\r\n================ STARTING NEW LOGGER ================\r\n") catch {};
}

/// Disables logging via the USART instance
pub fn deinit_logger() void {
    usart_logger = null;
}

pub fn log(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
    comptime format: []const u8,
    args: anytype,
) void {
    const level_prefix = comptime "[{}.{:0>6}] " ++ level.asText();
    const prefix = comptime level_prefix ++ switch (scope) {
        .default => ": ",
        else => " (" ++ @tagName(scope) ++ "): ",
    };

    if (usart_logger) |usart| {
        const current_time = hal.time.get_time_since_boot();
        const seconds = current_time.to_us() / std.time.us_per_s;
        const microseconds = current_time.to_us() % std.time.us_per_s;

        usart.print(prefix ++ format ++ "\r\n", .{ seconds, microseconds } ++ args) catch {};
    }
}
