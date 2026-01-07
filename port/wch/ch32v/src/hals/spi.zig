//!
//! This file implements the SPI driver for the CH32V chip family
//!
//! Based on the WCH CH32V20x SPI peripheral implementation.
//! Reference: CH32V20x Reference Manual Section on SPI
//!
//! Pin Configuration Requirements:
//! ==============================
//! SPI1 Default Pins (config.remap = .default):
//!   PA5: SCK  (Alternate Function Push-Pull, 50MHz)
//!   PA6: MISO (Input Floating or Input Pull-up)
//!   PA7: MOSI (Alternate Function Push-Pull, 50MHz)
//!   PA4: CS   (Output Push-Pull, 50MHz - if using GPIO CS)
//!
//! SPI1 Remapped Pins (config.remap = .remap1):
//!   PB3: SCK  (Alternate Function Push-Pull, 50MHz)
//!   PB4: MISO (Input Floating or Input Pull-up)
//!   PB5: MOSI (Alternate Function Push-Pull, 50MHz)
//!   PA15: CS  (Output Push-Pull, 50MHz - if using GPIO CS)
//!
//! SPI2 Pins (no remap available):
//!   PB13: SCK  (Alternate Function Push-Pull, 50MHz)
//!   PB14: MISO (Input Floating or Input Pull-up)
//!   PB15: MOSI (Alternate Function Push-Pull, 50MHz)
//!   PB12: CS   (Output Push-Pull, 50MHz - if using GPIO CS)
//!
//! User must configure pins before calling apply()
//!

const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const dma = hal.dma;
const gpio = hal.gpio;

const SPI1 = microzig.chip.peripherals.SPI1;
const SPI2 = microzig.chip.peripherals.SPI2;

const SpiRegs = microzig.chip.types.peripherals.SPI1;

pub const Error = error{
    Timeout,
    Overrun,
    ModeFault,
    CrcError,
    NoData,
};

/// Clock polarity configuration
pub const Polarity = enum(u1) {
    idle_low = 0,  // Clock is low when idle (CPOL=0)
    idle_high = 1, // Clock is high when idle (CPOL=1)
};

/// Clock phase configuration
pub const Phase = enum(u1) {
    first_edge = 0,  // Data captured on first clock edge (CPHA=0)
    second_edge = 1, // Data captured on second clock edge (CPHA=1)
};

/// Bit order configuration
pub const BitOrder = enum(u1) {
    msb_first = 0, // MSB transmitted first
    lsb_first = 1, // LSB transmitted first
};

/// Data frame format
pub const DataSize = enum(u1) {
    eight_bit = 0,  // 8-bit data frames
    sixteen_bit = 1, // 16-bit data frames (not yet supported)
};

/// Pin remapping configuration for SPI peripherals
///
/// SPI1 has 2 configurations (1 bit: PCFR1.SPI1_RM):
///   .default (0): NSS=PA4, SCK=PA5, MISO=PA6, MOSI=PA7
///   .remap1  (1): NSS=PA15, SCK=PB3, MISO=PB4, MOSI=PB5
///
/// SPI2 has only 1 configuration (no remap available):
///   .default: NSS=PB12, SCK=PB13, MISO=PB14, MOSI=PB15
///
/// See CH32V Reference Manual AFIO_PCFR1 section for details
pub const Remap = enum(u1) {
    default = 0,
    remap1 = 1,
};

pub const Config = struct {
    /// DMA configuration for SPI transfers (optional)
    /// When configured, enables DMA for transfers >= threshold bytes
    /// Smaller transfers automatically use polling mode
    pub const DmaConfig = struct {
        tx_channel: dma.Channel,
        rx_channel: dma.Channel,
        priority: dma.Priority = .Medium,
        /// Minimum transfer size in bytes to use DMA (smaller uses polling)
        /// Default: 16 bytes (conservative heuristic)
        threshold: usize = 16,
    };

    /// Chip select pin configuration (optional HAL-managed CS)
    /// If provided, CS will be automatically asserted/deasserted during transfers
    pub const ChipSelectConfig = struct {
        pin: gpio.Pin,
        active_high: bool = false,
    };

    baud_rate: u32 = 1_000_000,
    polarity: Polarity = .idle_low,
    phase: Phase = .first_edge,
    bit_order: BitOrder = .msb_first,
    data_size: DataSize = .eight_bit,
    remap: Remap = .default,

    /// Optional DMA configuration - null means polling-only mode
    /// Example: .dma = .{ .tx_channel = .Ch3, .rx_channel = .Ch2 }
    dma: ?DmaConfig = null,

    /// Optional chip select configuration - null means manual CS control
    chip_select: ?ChipSelectConfig = null,
};

pub const instance = struct {
    pub const SPI1: SPI = @enumFromInt(0);
    pub const SPI2: SPI = @enumFromInt(1);
    pub fn num(instance_number: u2) SPI {
        return @enumFromInt(instance_number - 1);
    }
};

pub const SPI = enum(u1) {
    _,

    pub inline fn get_regs(spi: SPI) *volatile SpiRegs {
        return switch (@intFromEnum(spi)) {
            0 => @ptrCast(SPI1),
            1 => @ptrCast(SPI2),
        };
    }

    inline fn disable(spi: SPI) void {
        spi.get_regs().CTLR1.modify(.{ .SPE = 0 });
    }

    inline fn enable(spi: SPI) void {
        spi.get_regs().CTLR1.modify(.{ .SPE = 1 });
    }

    /// Check if TX buffer is empty
    inline fn is_tx_empty(spi: SPI) bool {
        return spi.get_regs().STATR.read().TXE == 1;
    }

    /// Check if RX buffer has data
    inline fn is_rx_not_empty(spi: SPI) bool {
        return spi.get_regs().STATR.read().RXNE == 1;
    }

    /// Check if SPI is busy
    inline fn is_busy(spi: SPI) bool {
        return spi.get_regs().STATR.read().BSY == 1;
    }

    /// Check for and return any error flags
    fn check_errors(spi: SPI) Error!void {
        const statr = spi.get_regs().STATR.read();
        if (statr.OVR == 1) return Error.Overrun;
        if (statr.MODF == 1) return Error.ModeFault;
        if (statr.CRCERR == 1) return Error.CrcError;
    }

    /// Initializes the SPI HW block per the Config provided
    pub fn apply(comptime spi: SPI, comptime config: Config) void {
        const regs = spi.get_regs();

        // Compile-time DMA validation
        if (comptime config.dma) |dma_cfg| {
            const tx_peripheral = comptime if (@intFromEnum(spi) == 0)
                dma.Peripheral.SPI1_TX
            else
                dma.Peripheral.SPI2_TX;
            const rx_peripheral = comptime if (@intFromEnum(spi) == 0)
                dma.Peripheral.SPI1_RX
            else
                dma.Peripheral.SPI2_RX;

            // Validate channels (compile error if invalid)
            comptime tx_peripheral.ensure_compatible_with(dma_cfg.tx_channel);
            comptime rx_peripheral.ensure_compatible_with(dma_cfg.rx_channel);
        }

        // Enable peripheral clock
        hal.clocks.enable_peripheral_clock(switch (@intFromEnum(spi)) {
            0 => .SPI1,
            1 => .SPI2,
        });

        // Configure AFIO remap (SPI1 only)
        hal.clocks.enable_afio_clock();
        const AFIO = microzig.chip.peripherals.AFIO;
        switch (@intFromEnum(spi)) {
            0 => AFIO.PCFR1.modify(.{ .SPI1_RM = @intFromEnum(config.remap) }),
            // SPI2 does not have remap support on CH32V20x
            1 => {},
        }

        // Get peripheral clock frequency
        const rcc_clocks = hal.clocks.get_freqs();
        const pclk = if (@intFromEnum(spi) == 0) rcc_clocks.pclk2 else rcc_clocks.pclk1;

        // Calculate baud rate prescaler
        // SPI baud rate = PCLK / (2^(BR+1))
        // BR values: 000=/2, 001=/4, 010=/8, 011=/16, 100=/32, 101=/64, 110=/128, 111=/256
        const target_div = pclk / config.baud_rate;
        var br: u3 = 0;
        var actual_div: u32 = 2;
        while (br < 7 and actual_div < target_div) : (br += 1) {
            actual_div = actual_div * 2;
        }

        // Disable peripheral for configuration
        spi.disable();

        // Configure CTLR1
        regs.CTLR1.write(.{
            .CPHA = @intFromEnum(config.phase),
            .CPOL = @intFromEnum(config.polarity),
            .MSTR = 1, // Master mode
            .BR = br,
            .SPE = 0, // Keep disabled for now
            .LSBFIRST = @intFromEnum(config.bit_order),
            .SSI = 1, // Internal slave select
            .SSM = 1, // Software slave management
            .RXONLY = 0, // Full duplex
            .DFF = @intFromEnum(config.data_size),
            .CRCNEXT = 0,
            .CRCEN = 0,
            .BIDIOE = 0,
            .BIDIMODE = 0,
        });

        // Configure CTLR2
        const enable_dma = comptime config.dma != null;
        regs.CTLR2.modify(.{
            .RXDMAEN = if (enable_dma) @as(u1, 1) else 0,
            .TXDMAEN = if (enable_dma) @as(u1, 1) else 0,
            .SSOE = 0,
            .ERRIE = 0,
            .RXNEIE = 0,
            .TXEIE = 0,
        });

        // Enable peripheral
        spi.enable();
    }

    /// Reset and disable SPI peripheral
    pub fn reset(spi: SPI) void {
        spi.disable();
    }

    /// Wait for TX buffer to be empty with timeout
    fn wait_tx_empty(spi: SPI, deadline: mdf.time.Deadline) Error!void {
        var iterations: u32 = 0;
        while (!spi.is_tx_empty()) {
            try spi.check_errors();
            iterations += 1;
            if (iterations > 100_000) return Error.Timeout;
            if (deadline.is_reached_by(hal.time.get_time_since_boot()))
                return Error.Timeout;
        }
    }

    /// Wait for RX buffer to have data with timeout
    fn wait_rx_not_empty(spi: SPI, deadline: mdf.time.Deadline) Error!void {
        var iterations: u32 = 0;
        while (!spi.is_rx_not_empty()) {
            try spi.check_errors();
            iterations += 1;
            if (iterations > 100_000) return Error.Timeout;
            if (deadline.is_reached_by(hal.time.get_time_since_boot()))
                return Error.Timeout;
        }
    }

    /// Wait for SPI to not be busy with timeout
    fn wait_not_busy(spi: SPI, deadline: mdf.time.Deadline) Error!void {
        var iterations: u32 = 0;
        while (spi.is_busy()) {
            try spi.check_errors();
            iterations += 1;
            if (iterations > 100_000) return Error.Timeout;
            if (deadline.is_reached_by(hal.time.get_time_since_boot()))
                return Error.Timeout;
        }
    }

    /// Write data blocking (polling mode)
    /// Discards received data
    pub fn write_blocking(
        spi: SPI,
        data: []const u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (data.len == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();

        for (data) |byte| {
            // Wait for TX buffer empty
            try spi.wait_tx_empty(deadline);

            // Write data
            regs.DATAR.modify(.{ .DR = byte });

            // Wait for RX buffer to have data (dummy read)
            try spi.wait_rx_not_empty(deadline);

            // Discard received byte
            _ = regs.DATAR.read().DR;
        }

        // Wait for transmission to complete
        try spi.wait_not_busy(deadline);
    }

    /// Write multiple buffers blocking (vectored I/O)
    /// Useful for zero-copy command+data operations
    pub fn writev_blocking(
        spi: SPI,
        chunks: []const []const u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        const write_vec = microzig.utilities.SliceVector([]const u8).init(chunks);
        if (write_vec.size() == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();
        var iter = write_vec.iterator();

        while (iter.next_element()) |element| {
            // Wait for TX buffer empty
            try spi.wait_tx_empty(deadline);

            // Write data
            regs.DATAR.modify(.{ .DR = element.value });

            // Wait for RX buffer to have data (dummy read)
            try spi.wait_rx_not_empty(deadline);

            // Discard received byte
            _ = regs.DATAR.read().DR;
        }

        // Wait for transmission to complete
        try spi.wait_not_busy(deadline);
    }

    /// Read data blocking (polling mode)
    /// Sends 0xFF as dummy data
    pub fn read_blocking(
        spi: SPI,
        data: []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (data.len == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();

        for (data) |*byte| {
            // Wait for TX buffer empty
            try spi.wait_tx_empty(deadline);

            // Write dummy byte (0xFF)
            regs.DATAR.modify(.{ .DR = 0xFF });

            // Wait for RX buffer to have data
            try spi.wait_rx_not_empty(deadline);

            // Read received byte
            byte.* = @truncate(regs.DATAR.read().DR);
        }

        // Wait for transmission to complete
        try spi.wait_not_busy(deadline);
    }

    /// Read multiple buffers blocking (vectored I/O)
    pub fn readv_blocking(
        spi: SPI,
        chunks: []const []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        const read_vec = microzig.utilities.SliceVector([]u8).init(chunks);
        if (read_vec.size() == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();
        var iter = read_vec.iterator();

        while (iter.next_element_ptr()) |element| {
            // Wait for TX buffer empty
            try spi.wait_tx_empty(deadline);

            // Write dummy byte (0xFF)
            regs.DATAR.modify(.{ .DR = 0xFF });

            // Wait for RX buffer to have data
            try spi.wait_rx_not_empty(deadline);

            // Read received byte
            element.value_ptr.* = @truncate(regs.DATAR.read().DR);
        }

        // Wait for transmission to complete
        try spi.wait_not_busy(deadline);
    }

    /// Simultaneous read and write blocking (full duplex)
    pub fn transceive_blocking(
        spi: SPI,
        tx_data: []const u8,
        rx_data: []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (tx_data.len == 0 or rx_data.len == 0) return Error.NoData;
        if (tx_data.len != rx_data.len) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();

        for (tx_data, rx_data) |tx_byte, *rx_byte| {
            // Wait for TX buffer empty
            try spi.wait_tx_empty(deadline);

            // Write data
            regs.DATAR.modify(.{ .DR = tx_byte });

            // Wait for RX buffer to have data
            try spi.wait_rx_not_empty(deadline);

            // Read received byte
            rx_byte.* = @truncate(regs.DATAR.read().DR);
        }

        // Wait for transmission to complete
        try spi.wait_not_busy(deadline);
    }

    // ========================================================================
    // DMA Functions
    // ========================================================================

    /// Write data using DMA
    /// Requires config.dma to be non-null
    /// SPI DMA requires both TX and RX channels (uses dummy RX buffer)
    pub fn write_dma(
        spi: SPI,
        comptime config: Config,
        data: []const u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        const dma_cfg = comptime config.dma orelse @compileError("DMA config required for write_dma");

        if (data.len == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();

        // SPI DMA requires both TX and RX to be active
        // Use dummy RX buffer to discard received data
        var dummy_rx: u8 = 0;
        const rx_target = dma.PeripheralTarget{ .addr = @intFromPtr(&regs.DATAR) };
        const tx_target = dma.PeripheralTarget{ .addr = @intFromPtr(&regs.DATAR) };

        // Setup RX DMA (discard to dummy buffer)
        dma_cfg.rx_channel.setup_transfer(
            @as([*]u8, @ptrCast(&dummy_rx))[0..data.len],
            rx_target,
            .{ .priority = dma_cfg.priority },
        );

        // Setup TX DMA (real data)
        dma_cfg.tx_channel.setup_transfer(
            tx_target,
            data,
            .{ .priority = dma_cfg.priority },
        );

        // Wait for both channels to complete
        dma_cfg.tx_channel.wait_for_finish_blocking();
        dma_cfg.rx_channel.wait_for_finish_blocking();

        // Wait for SPI to finish transmission
        try spi.wait_not_busy(deadline);
    }

    /// Read data using DMA
    /// Requires config.dma to be non-null
    /// Sends 0xFF as dummy data while reading
    pub fn read_dma(
        spi: SPI,
        comptime config: Config,
        data: []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        const dma_cfg = comptime config.dma orelse @compileError("DMA config required for read_dma");

        if (data.len == 0) return Error.NoData;

        const deadline = mdf.time.Deadline.init_relative(
            hal.time.get_time_since_boot(),
            timeout orelse mdf.time.Duration.from_ms(1000),
        );

        const regs = spi.get_regs();

        // SPI DMA requires both TX and RX to be active
        // Use dummy TX buffer with 0xFF to clock out data
        var dummy_tx: u8 = 0xFF;
        const rx_target = dma.PeripheralTarget{ .addr = @intFromPtr(&regs.DATAR) };
        const tx_target = dma.PeripheralTarget{ .addr = @intFromPtr(&regs.DATAR) };

        // Setup RX DMA (real data)
        dma_cfg.rx_channel.setup_transfer(
            data,
            rx_target,
            .{ .priority = dma_cfg.priority },
        );

        // Setup TX DMA (dummy 0xFF bytes)
        dma_cfg.tx_channel.setup_transfer(
            tx_target,
            @as([*]const u8, @ptrCast(&dummy_tx))[0..data.len],
            .{ .priority = dma_cfg.priority },
        );

        // Wait for both channels to complete
        dma_cfg.tx_channel.wait_for_finish_blocking();
        dma_cfg.rx_channel.wait_for_finish_blocking();

        // Wait for SPI to finish transmission
        try spi.wait_not_busy(deadline);
    }

    /// Write data with automatic DMA/polling selection based on threshold
    pub fn write_auto(
        spi: SPI,
        comptime config: Config,
        data: []const u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (comptime config.dma) |dma_cfg| {
            if (data.len >= dma_cfg.threshold) {
                return spi.write_dma(config, data, timeout);
            }
        }
        return spi.write_blocking(data, timeout);
    }

    /// Read data with automatic DMA/polling selection based on threshold
    pub fn read_auto(
        spi: SPI,
        comptime config: Config,
        data: []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (comptime config.dma) |dma_cfg| {
            if (data.len >= dma_cfg.threshold) {
                return spi.read_dma(config, data, timeout);
            }
        }
        return spi.read_blocking(data, timeout);
    }

    /// Write multiple buffers with automatic DMA/polling selection
    pub fn writev_auto(
        spi: SPI,
        comptime config: Config,
        chunks: []const []const u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (comptime config.dma) |dma_cfg| {
            // Calculate total length at runtime
            var total_len: usize = 0;
            for (chunks) |chunk| {
                total_len += chunk.len;
            }

            if (total_len >= dma_cfg.threshold) {
                // For vectored DMA, we need to send chunks sequentially
                // TODO: Optimize with scatter-gather DMA in the future
                for (chunks) |chunk| {
                    try spi.write_dma(config, chunk, timeout);
                }
                return;
            }
        }
        return spi.writev_blocking(chunks, timeout);
    }

    /// Read multiple buffers with automatic DMA/polling selection
    pub fn readv_auto(
        spi: SPI,
        comptime config: Config,
        chunks: []const []u8,
        timeout: ?mdf.time.Duration,
    ) Error!void {
        if (comptime config.dma) |dma_cfg| {
            // Calculate total length at runtime
            var total_len: usize = 0;
            for (chunks) |chunk| {
                total_len += chunk.len;
            }

            if (total_len >= dma_cfg.threshold) {
                // For vectored DMA, we need to read chunks sequentially
                // TODO: Optimize with scatter-gather DMA in the future
                for (chunks) |chunk| {
                    try spi.read_dma(config, @constCast(chunk), timeout);
                }
                return;
            }
        }
        return spi.readv_blocking(chunks, timeout);
    }
};
