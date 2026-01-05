//! SPI Loopback Test
//!
//! This example tests the SPI HAL in loopback mode by connecting MOSI to MISO.
//!
//! Hardware setup:
//! - Connect PA7 (MOSI) to PA6 (MISO) with a jumper wire
//! - No other connections required
//!
//! This tests:
//! - Basic SPI functionality in blocking mode
//! - Different SPI modes (polarity/phase combinations)
//! - Various baud rates
//! - Data integrity verification
//!

const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const spi = hal.spi;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Configure USART2 TX pin (PA2) for logging
    usart_tx_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{
        .baud_rate = 115200,
        .remap = .default,
    });

    hal.usart.init_logger(usart);

    std.log.info("SPI Loopback Test", .{});
    std.log.info("==================", .{});
    std.log.info("", .{});
    std.log.info("Hardware setup:", .{});
    std.log.info("  Connect PA7 (MOSI) to PA6 (MISO) with jumper wire", .{});
    std.log.info("", .{});

    // Configure SPI1 pins
    // PA5: SCK  (Alternate Function Push-Pull, 50MHz)
    // PA6: MISO (Input Floating)
    // PA7: MOSI (Alternate Function Push-Pull, 50MHz)
    const sck_pin = gpio.Pin.init(0, 5);  // PA5
    const miso_pin = gpio.Pin.init(0, 6); // PA6
    const mosi_pin = gpio.Pin.init(0, 7); // PA7

    sck_pin.configure_alternate_function(.push_pull, .max_50MHz);
    miso_pin.enable_clock();
    miso_pin.set_input_mode(.floating);
    mosi_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Test patterns
    const test_patterns = [_][]const u8{
        &.{0x00},
        &.{0xFF},
        &.{0xAA},
        &.{0x55},
        &.{ 0x01, 0x02, 0x03, 0x04, 0x05 },
        &.{ 0xDE, 0xAD, 0xBE, 0xEF },
        &.{ 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF },
    };

    // Test SPI mode 0 (CPOL=0, CPHA=0)
    std.log.info("Testing SPI Mode 0 (CPOL=0, CPHA=0)...", .{});
    const spi1 = spi.instance.SPI1;
    spi1.apply(.{
        .baud_rate = 1_000_000,
        .polarity = .idle_low,
        .phase = .first_edge,
        .bit_order = .msb_first,
    });

    var rx_buffer: [16]u8 = undefined;

    for (test_patterns, 0..) |pattern, i| {
        @memset(&rx_buffer, 0);

        // Perform loopback
        spi1.transceive_blocking(pattern, rx_buffer[0..pattern.len], mdf.time.Duration.from_ms(100)) catch |err| {
            std.log.err("Test pattern {} failed: {}", .{ i, err });
            continue;
        };

        // Verify
        if (std.mem.eql(u8, pattern, rx_buffer[0..pattern.len])) {
            std.log.info("  Pattern {}: PASS (len={})", .{ i, pattern.len });
        } else {
            std.log.err("  Pattern {}: FAIL", .{i});
            std.log.err("    Sent: {any}", .{pattern});
            std.log.err("    Recv: {any}", .{rx_buffer[0..pattern.len]});
        }
    }

    // Test different SPI modes
    const spi_modes = [_]struct {
        name: []const u8,
        polarity: spi.Polarity,
        phase: spi.Phase,
    }{
        .{ .name = "Mode 1 (CPOL=0, CPHA=1)", .polarity = .idle_low, .phase = .second_edge },
        .{ .name = "Mode 2 (CPOL=1, CPHA=0)", .polarity = .idle_high, .phase = .first_edge },
        .{ .name = "Mode 3 (CPOL=1, CPHA=1)", .polarity = .idle_high, .phase = .second_edge },
    };

    for (spi_modes) |mode| {
        std.log.info("", .{});
        std.log.info("Testing {s}...", .{mode.name});

        spi1.apply(.{
            .baud_rate = 1_000_000,
            .polarity = mode.polarity,
            .phase = mode.phase,
        });

        // Test with a simple pattern
        const simple_pattern = [_]u8{ 0x12, 0x34, 0x56, 0x78 };
        @memset(&rx_buffer, 0);

        spi1.transceive_blocking(&simple_pattern, rx_buffer[0..simple_pattern.len], mdf.time.Duration.from_ms(100)) catch |err| {
            std.log.err("  {s} failed: {}", .{ mode.name, err });
            continue;
        };

        if (std.mem.eql(u8, &simple_pattern, rx_buffer[0..simple_pattern.len])) {
            std.log.info("  {s}: PASS", .{mode.name});
        } else {
            std.log.err("  {s}: FAIL", .{mode.name});
        }
    }

    // Test different baud rates
    std.log.info("", .{});
    std.log.info("Testing different baud rates...", .{});

    const baud_rates = [_]u32{ 125_000, 250_000, 500_000, 1_000_000, 2_000_000, 4_000_000 };

    for (baud_rates) |baud_rate| {
        spi1.apply(.{
            .baud_rate = baud_rate,
            .polarity = .idle_low,
            .phase = .first_edge,
        });

        const test_data = [_]u8{0xA5};
        @memset(&rx_buffer, 0);

        spi1.transceive_blocking(&test_data, rx_buffer[0..test_data.len], mdf.time.Duration.from_ms(100)) catch |err| {
            std.log.err("  {} Hz failed: {}", .{ baud_rate, err });
            continue;
        };

        if (std.mem.eql(u8, &test_data, rx_buffer[0..test_data.len])) {
            std.log.info("  {} Hz: PASS", .{baud_rate});
        } else {
            std.log.err("  {} Hz: FAIL", .{baud_rate});
        }
    }

    // Test vectored I/O
    std.log.info("", .{});
    std.log.info("Testing vectored I/O (writev)...", .{});

    spi1.apply(.{
        .baud_rate = 1_000_000,
        .polarity = .idle_low,
        .phase = .first_edge,
    });

    const chunk1 = [_]u8{ 0x01, 0x02 };
    const chunk2 = [_]u8{ 0x03, 0x04 };
    const chunk3 = [_]u8{ 0x05, 0x06 };
    const chunks = [_][]const u8{ &chunk1, &chunk2, &chunk3 };

    spi1.writev_blocking(&chunks, mdf.time.Duration.from_ms(100)) catch |err| {
        std.log.err("  writev failed: {}", .{err});
    };

    std.log.info("  writev: PASS (if no errors above)", .{});

    std.log.info("", .{});
    std.log.info("All tests complete!", .{});
    std.log.info("", .{});

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}
