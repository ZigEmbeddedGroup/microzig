const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const SPI0_reg = peripherals.SPI0;
const SPI1_reg = peripherals.SPI1;

const clocks = @import("clocks.zig");
const dma = @import("dma.zig");
const resets = @import("resets.zig");
const time = @import("time.zig");
const hw = @import("hw.zig");

const SpiRegs = microzig.chip.types.peripherals.SPI0;

pub const FrameFormat = union(enum) {
    pub const Motorola = struct {
        pub const Polarity = enum(u1) {
            default_low = 0,
            default_high = 1,
        };

        pub const Phase = enum(u1) {
            first_edge = 0,
            second_edge = 1,
        };

        /// default_low means clock is steady state low, default_high means steady state high
        clock_polarity: Polarity = .default_low,

        /// Controls whether data is captured on the first or second clock edge transition
        clock_phase: Phase = .first_edge,
    };

    motorola: Motorola,
    texas_instruments,
    ns_microwire,
};

pub const DataWidthBits = enum(u4) {
    four = 3,
    five = 4,
    six = 5,
    seven = 6,
    eight = 7,
    nine = 8,
    ten = 9,
    eleven = 10,
    twelve = 11,
    thirteen = 12,
    fourteen = 13,
    fifteen = 14,
    sixteen = 15,
};

pub const Config = struct {
    clock_config: clocks.config.Global,
    data_width: DataWidthBits = .eight,
    frame_format: FrameFormat = .{ .motorola = .{} },
    baud_rate: u32 = 1_000_000,
};

pub const instance = struct {
    pub const SPI0: SPI = @as(SPI, @enumFromInt(0));
    pub const SPI1: SPI = @as(SPI, @enumFromInt(1));
    pub fn num(instance_number: u1) SPI {
        return @as(SPI, @enumFromInt(instance_number));
    }
};

pub const ConfigError = error{
    InvalidDataWidth,
    InputFreqTooLow,
    InputFreqTooHigh,
    UnsupportedBaudRate,
};

/// An API for interacting with the RP2040's SPI driver.
///
/// Note: Assumes proper GPIO configuration, does NOT configure GPIO pins.
///
/// Features of the peripheral that are explicitly NOT supported by this API are:
/// - Target mode
/// - Interrupt Driven/Asynchronous writes/reads
/// - DMA based writes/reads
pub const SPI = enum(u1) {
    _,

    pub inline fn get_regs(spi: SPI) *volatile SpiRegs {
        return switch (@intFromEnum(spi)) {
            0 => SPI0_reg,
            1 => SPI1_reg,
        };
    }

    /// Initializes the SPI HW block per the Config provided
    /// Per the API limitations discussed above, the following settings are fixed and not configurable:
    /// - Controller Mode only
    /// - DREQ signalling is always enabled, harmless if DMA isn't configured to listen for this
    pub fn apply(spi: SPI, comptime config: Config) ConfigError!void {
        const peri_freq = comptime config.clock_config.peri.?.frequency();
        try spi.set_baudrate(config.baud_rate, peri_freq);

        const spi_regs = spi.get_regs();

        switch (config.frame_format) {
            .motorola => |ff| {
                spi_regs.SSPCR0.modify(.{
                    .FRF = 0b00,
                    .DSS = @intFromEnum(config.data_width),
                    .SPO = @intFromEnum(ff.clock_polarity),
                    .SPH = @intFromEnum(ff.clock_phase),
                });
            },

            .texas_instruments => {
                spi_regs.SSPCR0.modify(.{
                    .FRF = 0b01,
                    .DSS = @intFromEnum(config.data_width),
                    .SPO = 0,
                    .SPH = 0,
                });
            },

            .ns_microwire => {
                spi_regs.SSPCR0.modify(.{
                    .FRF = 0b10,
                    .DSS = @intFromEnum(config.data_width),
                    .SPO = 0,
                    .SPH = 0,
                });
            },
        }

        spi_regs.SSPDMACR.modify(.{
            .TXDMAE = 1,
            .RXDMAE = 1,
        });

        // Enable SPI
        spi_regs.SSPCR1.modify(.{
            .SSE = 1,
        });
    }

    /// Disable SPI and return peripheral registers to reset values
    pub fn reset(spi: SPI) void {
        const spi_regs = spi.get_regs();
        spi_regs.SSPCR1.modify(.{
            .SSE = 0,
        });
        spi_regs.SSPDMACR.modify(.{
            .TXDMAE = 0,
            .RXDMAE = 0,
        });
        spi_regs.SSPCR0.modify(.{
            .FRF = 0,
            .DSS = 0,
            .SPO = 0,
            .SPH = 0,
            .SCR = 0,
        });
        spi_regs.SSPCPSR.modify(.{ .CPSDVSR = 0 });
    }

    pub fn set_slave(spi: SPI, slave: bool) void {
        const regs = spi.get_regs();
        // Disable SPI
        regs.SSPCR1.modify(.{ .SSE = 0 });

        regs.SSPCR1.modify(.{ .MS = @intFromBool(slave) });

        // Re-enable SPI
        regs.SSPCR1.modify(.{ .SSE = 1 });
    }

    pub inline fn is_writable(spi: SPI) bool {
        return spi.get_regs().SSPSR.read().TNF == 1;
    }

    pub inline fn is_readable(spi: SPI) bool {
        return spi.get_regs().SSPSR.read().RNE == 1;
    }

    fn validate_bitwidth(comptime PacketType: type) void {
        if (@bitSizeOf(PacketType) < 4 or @bitSizeOf(PacketType) > 16)
            @compileError("PacketType must be a datatype with a size between 4 and 16 bits inclusive");
    }

    pub fn tx(spi: SPI) dma.DMA_WriteTarget {
        return .{
            .dreq = if (@intFromEnum(spi) == 0) .spi0_tx else .spi1_tx,
            .addr = @intFromPtr(&spi.get_regs().SSPDR),
        };
    }

    pub fn rx(spi: SPI) dma.DMA_ReadTarget {
        return .{
            .dreq = if (@intFromEnum(spi) == 0) .spi0_rx else .spi1_rx,
            .addr = @intFromPtr(&spi.get_regs().SSPDR),
        };
    }

    const fifo_depth = 8;

    /// Disable SPI, pre-fill the TX FIFO as much as possible, and then re-enable to start transmission.
    /// Leads to performance gains in thoroughput. Returns how many bytes were consumed from src.
    fn prime_tx_fifo(spi: SPI, comptime PacketType: type, src_iter: *microzig.utilities.Slice_Vector([]const PacketType).Iterator) usize {
        const spi_regs = spi.get_regs();
        spi_regs.SSPCR1.modify(.{
            .SSE = 0,
        });

        var count: usize = 0;
        while (spi.is_writable()) {
            const element = src_iter.next_element() orelse break;
            spi_regs.SSPDR.write_raw(element.value);
            count += 1;
        }
        spi_regs.SSPCR1.modify(.{
            .SSE = 1,
        });
        return count;
    }

    /// Same as prime_tx_fifo but for a repeated byte.
    fn prime_tx_fifo_repeated(spi: SPI, comptime PacketType: type, repeated_byte: PacketType, repeat_count: usize) usize {
        const spi_regs = spi.get_regs();
        spi_regs.SSPCR1.modify(.{
            .SSE = 0,
        });
        var tx_remaining = repeat_count;
        while (tx_remaining > 0 and spi.is_writable()) {
            spi_regs.SSPDR.write_raw(repeated_byte);
            tx_remaining -= 1;
        }
        spi_regs.SSPCR1.modify(.{
            .SSE = 1,
        });
        return repeat_count - tx_remaining;
    }

    /// Write and read a number of packets. src and dst must be the same length.
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    pub fn transceive_blocking(spi: SPI, comptime PacketType: type, src: []const PacketType, dst: []PacketType) void {
        return spi.transceive_vecs_blocking(PacketType, &.{src}, &.{dst});
    }

    /// Write and read a number of packets. src and dst must be the same length.
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    ///
    /// NOTE: This function is a vectored version of `transceive_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    pub fn transceive_vecs_blocking(spi: SPI, comptime PacketType: type, src_vecs: []const []const PacketType, dst_vecs: []const []PacketType) void {
        comptime validate_bitwidth(PacketType);

        const src_data = microzig.utilities.Slice_Vector([]const PacketType).init(src_vecs);
        const dst_data = microzig.utilities.Slice_Vector([]PacketType).init(dst_vecs);

        var rx_remaining = src_data.size();
        var tx_remaining = dst_data.size();
        std.debug.assert(rx_remaining == tx_remaining);

        const spi_regs = spi.get_regs();

        var src_iter = src_data.iterator();
        var dst_iter = dst_data.iterator();

        tx_remaining -= spi.prime_tx_fifo(PacketType, &src_iter);

        while (rx_remaining > 0 or tx_remaining > 0) {
            if (tx_remaining > 0 and spi.is_writable() and rx_remaining < tx_remaining + fifo_depth) {
                const element = src_iter.next_element() orelse unreachable;
                spi_regs.SSPDR.write_raw(element.value);
                tx_remaining -= 1;
            }
            if (rx_remaining > 0 and spi.is_readable()) {
                const element = dst_iter.next_element_ptr() orelse unreachable;
                const value: u16 = spi_regs.SSPDR.read().DATA;
                element.value_ptr.* = @truncate(value);
                rx_remaining -= 1;
            }
        }
    }

    pub fn set_loopback_mode(spi: SPI, enabled: bool) void {
        spi.get_regs().SSPCR1.modify(.{ .LBM = @intFromBool(enabled) });
    }

    /// Write a number of packets and discard any data received back.
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    pub fn write_blocking(spi: SPI, comptime PacketType: type, src: []const PacketType) void {
        return spi.writev_blocking(PacketType, &.{src});
    }

    /// Write a number of packets and discard any data received back.
    ///
    /// NOTE: This function is a vectored version of `write_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    pub fn writev_blocking(spi: SPI, comptime PacketType: type, src_vec: []const []const PacketType) void {
        comptime validate_bitwidth(PacketType);

        var src_iter = microzig.utilities.Slice_Vector([]const u8).init(src_vec).iterator();

        _ = spi.prime_tx_fifo(PacketType, &src_iter);

        const spi_regs = spi.get_regs();

        // Write to TX FIFO whilst ignoring RX, then clean up afterward. When RX
        // is full, PL022 inhibits RX pushes, and sets a sticky flag on
        // push-on-full, but continues shifting. Safe if SSPIMSC_RORIM is not set.
        while (src_iter.next_element()) |element| {
            while (!spi.is_writable()) {
                hw.tight_loop_contents();
            }
            spi_regs.SSPDR.write_raw(element.value);
        }

        // Drain RX FIFO, then wait for shifting to finish (which may be *after*
        // TX FIFO drains), then drain RX FIFO again
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.read();
        }
        while (spi_regs.SSPSR.read().BSY == 1) {
            hw.tight_loop_contents();
        }
        while (spi.is_readable()) {
            _ = spi_regs.SSPDR.read();
        }
        // Don't leave overrun flag set
        peripherals.SPI0.SSPICR.modify(.{ .RORIC = 1 });
    }

    /// Read a number of packets while repeatedly sending the data
    /// packet specified by "repeated_tx_data". Generally this can
    /// be 0, but some devices require a specific value here,
    /// e.g. SD cards expect 0xff
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    pub fn read_blocking(spi: SPI, comptime PacketType: type, repeated_tx_data: PacketType, dst: []PacketType) void {
        return spi.readv_blocking(PacketType, repeated_tx_data, &.{dst});
    }

    /// Read a number of packets while repeatedly sending the data
    /// packet specified by "repeated_tx_data". Generally this can
    /// be 0, but some devices require a specific value here,
    /// e.g. SD cards expect 0xff
    ///
    /// NOTE: This function is a vectored version of `read_blocking` and takes an array of arrays.
    ///       This pattern allows one to create better zero-copy send routines as message prefixes and
    ///       suffixes won't need to be concatenated/inserted to the original buffer, but can be managed
    ///       in a separate memory.
    ///
    /// PacketType specifies the bit width of each packet using any of
    /// the types u4, u5, ..., u16. Data truncation is possible if this
    /// doesn't match the peripheral's configured bit width.
    pub fn readv_blocking(spi: SPI, comptime PacketType: type, repeated_tx_data: PacketType, dst_vec: []const []PacketType) void {
        comptime validate_bitwidth(PacketType);

        const dst_data = microzig.utilities.Slice_Vector([]PacketType).init(dst_vec);

        const spi_regs = spi.get_regs();
        var rx_remaining = dst_data.size();
        var tx_remaining = rx_remaining;

        var dst_iter = dst_data.iterator();

        tx_remaining -= spi.prime_tx_fifo_repeated(PacketType, repeated_tx_data, tx_remaining);
        while (rx_remaining > 0 or tx_remaining > 0) {
            if (tx_remaining > 0 and spi.is_writable() and rx_remaining < tx_remaining + fifo_depth) {
                spi_regs.SSPDR.write_raw(repeated_tx_data);
                tx_remaining -= 1;
            }
            if (rx_remaining > 0 and spi.is_readable()) {
                const value: u16 = spi_regs.SSPDR.read().DATA;
                const dst = dst_iter.next_element_ptr() orelse unreachable;

                dst.value_ptr.* = @truncate(value);
                rx_remaining -= 1;
            }
        }
    }

    fn set_baudrate(spi: SPI, baudrate: u32, freq_in: u32) ConfigError!void {
        const spi_regs = spi.get_regs();

        // Clock constraints per the datasheet
        if (baudrate > 62_500_000) return ConfigError.UnsupportedBaudRate;
        if (freq_in < 2 * baudrate) return ConfigError.InputFreqTooLow;
        if ((freq_in / (254 * 256)) > baudrate) return ConfigError.InputFreqTooHigh;

        // Find smallest prescale value which puts output frequency in range of
        // post-divide. Prescale is an even number from 2 to 254 inclusive.
        var prescale: u64 = 2;
        while (prescale <= 254) : (prescale += 2) {
            if (freq_in < (prescale + 2) * 256 * baudrate) break;
        }
        if (prescale > 254) return ConfigError.InputFreqTooLow;

        // Find largest post-divide which makes output <= baudrate. Post-divide is
        // an integer in the range 1 to 256 inclusive.
        var postdiv: u64 = 256;
        while (postdiv > 1) : (postdiv -= 1) {
            if (freq_in / (prescale * (postdiv - 1)) > baudrate) break;
        }
        spi_regs.SSPCPSR.modify(.{ .CPSDVSR = @as(u8, @intCast(prescale)) });
        spi_regs.SSPCR0.modify(.{ .SCR = @as(u8, @intCast(postdiv - 1)) });
    }
};
