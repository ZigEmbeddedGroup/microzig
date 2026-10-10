//! SPI host for the ATmega328P (polling).
//!
//! SCK is PB5, MOSI is PB3 and MISO is PB4. PB2 is the peripheral's own SS
//! pin: it is set as an output, because an SS input pulled low would switch
//! the SPI into device mode. Chip select is not handled here; the caller
//! drives its own CS pin.

const std = @import("std");
const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

// The generated `peripherals.SPI` is a pointer to address 0 (not `allowzero`)
// with absolute register offsets, so it can't be used. Each register gets its
// own pointer instead, at its offset (which is its data-space address).
const SPI_Regs = microzig.chip.types.peripherals.SPI;
const SPCR: *volatile @FieldType(SPI_Regs, "SPCR") = @ptrFromInt(@offsetOf(SPI_Regs, "SPCR"));
const SPSR: *volatile @FieldType(SPI_Regs, "SPSR") = @ptrFromInt(@offsetOf(SPI_Regs, "SPSR"));
const SPDR: *volatile u8 = @ptrFromInt(@offsetOf(SPI_Regs, "SPDR"));

const ss = gpio.pin(.b, 2);
const mosi = gpio.pin(.b, 3);
const sck = gpio.pin(.b, 5);

pub const Polarity = enum(u1) {
    idle_low = 0, // CPOL = 0
    idle_high = 1, // CPOL = 1
};

pub const Phase = enum(u1) {
    first_edge = 0, // CPHA = 0
    second_edge = 1, // CPHA = 1
};

pub const BitOrder = enum(u1) {
    msb_first = 0,
    lsb_first = 1,
};

/// Board-level SPI setup. Boards export a `spi_setup` const of this type;
/// the application passes its own settings (clock, mode, etc.) to `apply`.
pub const Setup = struct {
    /// The ATmega328P has a single SPI peripheral.
    instance: SPI = .spi0,
    /// CPU clock in Hz.
    cpu_frequency: u32,

    /// Configures the pins and enables the SPI in host mode.
    pub fn apply(comptime setup: Setup, comptime config: Config) void {
        setup.instance.apply(setup.cpu_frequency, config);
    }
};

/// The transfers poll the peripheral without a timeout: the SPI must be set
/// up with `apply`, and nothing else may use it at the same time.
pub const SPI = enum {
    spi0,

    /// Configures the pins and enables the SPI in host mode.
    pub fn apply(comptime _: SPI, comptime cpu_frequency: u32, comptime config: Config) void {
        const clock = comptime compute_clock(cpu_frequency, config.baud_rate);

        // MISO (PB4) needs no setup: host mode forces it to be an input.
        ss.set_direction(.output); // see the file comment
        mosi.set_direction(.output);
        sck.set_direction(.output);

        SPSR.write_raw(@intFromBool(clock.double_speed)); // SPI2X
        SPCR.write(.{
            .SPR = @fromBackingInt(@intCast(clock.spr)),
            .CPHA = @backingInt(config.phase),
            .CPOL = @backingInt(config.polarity),
            .MSTR = 1,
            .DORD = @backingInt(config.bit_order),
            .SPE = 1,
            .SPIE = 0,
        });
    }
    /// Sends `data`, discarding what is received.
    pub fn write_blocking(_: SPI, data: []const u8) void {
        for (data) |byte| _ = transfer_byte(byte);
    }
    /// Sends each chunk in order, as one transfer.
    pub fn writev_blocking(spi: SPI, chunks: []const []const u8) void {
        for (chunks) |chunk| spi.write_blocking(chunk);
    }
    /// Fills `data`, sending 0xFF.
    pub fn read_blocking(_: SPI, data: []u8) void {
        for (data) |*byte| byte.* = transfer_byte(0xFF);
    }
    /// Fills each chunk in order, as one transfer.
    pub fn readv_blocking(spi: SPI, chunks: []const []u8) void {
        for (chunks) |chunk| spi.read_blocking(chunk);
    }
    /// Sends `tx_data` and receives into `rx_data` at the same time. Both must
    /// have the same length.
    pub fn transceive_blocking(_: SPI, tx_data: []const u8, rx_data: []u8) void {
        for (tx_data, rx_data) |tx_byte, *rx_byte| rx_byte.* = transfer_byte(tx_byte);
    }
};

pub const instance = struct {
    pub const SPI0: SPI = .spi0;
};

pub const Config = struct {
    /// Highest allowed SCK frequency in Hz. The actual frequency is the
    /// fastest CPU clock divider (2 to 128) that doesn't exceed it.
    baud_rate: u32 = 1_000_000,
    polarity: Polarity = .idle_low,
    phase: Phase = .first_edge,
    bit_order: BitOrder = .msb_first,
};

const Clock = struct {
    spr: u2,
    double_speed: bool,
};

/// Returns the fastest divider that doesn't exceed `baud_rate`, or null if
/// even the slowest one does.
fn find_clock(cpu_frequency: comptime_int, baud_rate: comptime_int) ?Clock {
    // { divider, SPR1:0, SPI2X }, from fastest to slowest (datasheet table 18-5).

    const dividers = .{
        .{ 2, 0b00, true },
        .{ 4, 0b00, false },
        .{ 8, 0b01, true },
        .{ 16, 0b01, false },
        .{ 32, 0b10, true },
        .{ 64, 0b10, false },
        .{ 128, 0b11, false },
    };
    inline for (dividers) |d| {
        if (cpu_frequency <= baud_rate * d[0]) return .{ .spr = d[1], .double_speed = d[2] };
    }

    return null;
}

fn compute_clock(cpu_frequency: comptime_int, baud_rate: comptime_int) Clock {
    const clock = comptime find_clock(cpu_frequency, baud_rate);
    if (clock == null)
        @compileError(std.fmt.comptimePrint(
            "SPI clock {d} Hz is below the slowest one available ({d} Hz)",
            .{ baud_rate, cpu_frequency / 128 },
        ));

    return clock.?;
}

test find_clock {
    // The slowest SCK at 16 MHz is 125 kHz.
    // TODO: test the compile error itself (https://github.com/ziglang/zig/issues/513).
    try std.testing.expectEqual(null, find_clock(16_000_000, 100_000));
}

test compute_clock {
    try std.testing.expectEqual(Clock{ .spr = 0b00, .double_speed = true }, compute_clock(16_000_000, 8_000_000));
    try std.testing.expectEqual(Clock{ .spr = 0b01, .double_speed = false }, compute_clock(16_000_000, 1_000_000));
    try std.testing.expectEqual(Clock{ .spr = 0b01, .double_speed = false }, compute_clock(16_000_000, 1_500_000));
    try std.testing.expectEqual(Clock{ .spr = 0b11, .double_speed = false }, compute_clock(16_000_000, 125_000));
    try std.testing.expectEqual(Clock{ .spr = 0b01, .double_speed = true }, compute_clock(16_000_000, 2_000_000));
    try std.testing.expectEqual(Clock{ .spr = 0b10, .double_speed = true }, compute_clock(16_000_000, 500_000));
    try std.testing.expectEqual(Clock{ .spr = 0b10, .double_speed = false }, compute_clock(16_000_000, 250_000));

    // 16_000_001 / 2 is just above 8 MHz, so it needs the next divider.
    try std.testing.expectEqual(Clock{ .spr = 0b00, .double_speed = false }, compute_clock(16_000_001, 8_000_000));
}

/// Sends `byte` and returns the byte received at the same time.
fn transfer_byte(byte: u8) u8 {
    SPDR.* = byte;
    while (SPSR.read().SPIF == 0) {}
    return SPDR.*;
}
