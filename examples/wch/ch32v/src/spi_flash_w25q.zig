//! W25Q128 SPI Flash Test
//!
//! This example demonstrates using the SPI HAL with external W25Q128 flash memory.
//!
//! Hardware setup:
//! - W25Q128 flash chip connected to SPI1:
//!   - CS:   PA4 (or any GPIO)
//!   - SCK:  PA5
//!   - MISO: PA6
//!   - MOSI: PA7
//!   - VCC:  3.3V
//!   - GND:  GND
//!
//! This tests:
//! - Reading JEDEC ID (should be 0xEF4018 for W25Q128)
//! - Small transfers (status register - uses polling)
//! - Large transfers (256-byte page - uses DMA if enabled)
//! - Erase/Write/Read cycle with verification
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

// W25Q128 Commands
const W25Q_CMD = struct {
    const READ_JEDEC_ID: u8 = 0x9F;
    const READ_STATUS_REG1: u8 = 0x05;
    const WRITE_ENABLE: u8 = 0x06;
    const WRITE_DISABLE: u8 = 0x04;
    const READ_DATA: u8 = 0x03;
    const PAGE_PROGRAM: u8 = 0x02;
    const SECTOR_ERASE_4KB: u8 = 0x20;
    const BLOCK_ERASE_64KB: u8 = 0xD8;
    const CHIP_ERASE: u8 = 0xC7;
};

// W25Q128 Status Register bits
const W25Q_STATUS = struct {
    const BUSY: u8 = 0x01;
    const WEL: u8 = 0x02; // Write Enable Latch
};

// Flash configuration
const JEDEC_ID_EXPECTED: u24 = 0xEF4018; // Winbond W25Q128
const PAGE_SIZE: usize = 256;
const SECTOR_SIZE: usize = 4096;

// CS pin
const cs_pin = gpio.Pin.init(0, 4); // PA4

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

    std.log.info("W25Q128 SPI Flash Test", .{});
    std.log.info("======================", .{});
    std.log.info("", .{});

    // Configure SPI1 pins
    // PA5: SCK  (Alternate Function Push-Pull, 50MHz)
    // PA6: MISO (Input Floating)
    // PA7: MOSI (Alternate Function Push-Pull, 50MHz)
    // PA4: CS   (Output Push-Pull, 50MHz)
    const sck_pin = gpio.Pin.init(0, 5); // PA5
    const miso_pin = gpio.Pin.init(0, 6); // PA6
    const mosi_pin = gpio.Pin.init(0, 7); // PA7

    sck_pin.configure_alternate_function(.push_pull, .max_50MHz);
    miso_pin.enable_clock();
    miso_pin.set_input_mode(.floating);
    mosi_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Configure CS pin (manual control)
    cs_pin.enable_clock();
    cs_pin.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    cs_pin.put(1); // Deselect (CS is active low)

    // Initialize SPI1
    const spi1 = spi.instance.SPI1;

    // Test with DMA enabled
    std.log.info("Initializing SPI with DMA support...", .{});
    spi1.apply(.{
        .baud_rate = 4_000_000, // 4 MHz
        .polarity = .idle_low,
        .phase = .first_edge,
        .dma = .{
            .tx_channel = .Ch3,
            .rx_channel = .Ch2,
            .threshold = 16, // Use DMA for transfers >= 16 bytes
        },
    });

    std.log.info("SPI initialized at 4 MHz with DMA", .{});
    std.log.info("", .{});

    // Test 1: Read JEDEC ID
    std.log.info("Test 1: Reading JEDEC ID...", .{});
    const jedec_id = try read_jedec_id(spi1);
    std.log.info("  JEDEC ID: 0x{X:0>6}", .{jedec_id});

    if (jedec_id == JEDEC_ID_EXPECTED) {
        std.log.info("  Device: Winbond W25Q128 - VERIFIED ✓", .{});
    } else {
        std.log.warn("  Unknown device (expected 0x{X:0>6})", .{JEDEC_ID_EXPECTED});
    }
    std.log.info("", .{});

    // Test 2: Read Status Register (small transfer - should use polling)
    std.log.info("Test 2: Reading Status Register (polling)...", .{});
    const status = try read_status_reg(spi1);
    std.log.info("  Status: 0x{X:0>2}", .{status});
    std.log.info("  BUSY: {}", .{status & W25Q_STATUS.BUSY != 0});
    std.log.info("  WEL:  {}", .{status & W25Q_STATUS.WEL != 0});
    std.log.info("", .{});

    // Test 3: Erase/Write/Read Cycle
    std.log.info("Test 3: Erase/Write/Read Cycle...", .{});

    const test_address: u24 = 0x001000; // Start of sector 1 (4KB aligned)
    const test_data_len: usize = 256; // One page

    // Create test pattern
    var write_buffer: [PAGE_SIZE]u8 = undefined;
    for (&write_buffer, 0..) |*byte, i| {
        byte.* = @truncate(i);
    }

    std.log.info("  Erasing sector at 0x{X:0>6}...", .{test_address});
    try erase_sector(spi1, test_address);
    std.log.info("  Sector erased", .{});

    std.log.info("  Writing {} bytes...", .{test_data_len});
    try write_page(spi1, test_address, write_buffer[0..test_data_len]);
    std.log.info("  Page written", .{});

    std.log.info("  Reading {} bytes (DMA)...", .{test_data_len});
    var read_buffer: [PAGE_SIZE]u8 = undefined;
    try read_data(spi1, test_address, read_buffer[0..test_data_len]);
    std.log.info("  Page read", .{});

    // Verify
    std.log.info("  Verifying data...", .{});
    if (std.mem.eql(u8, write_buffer[0..test_data_len], read_buffer[0..test_data_len])) {
        std.log.info("  Data verified ✓", .{});
    } else {
        std.log.err("  Data mismatch!", .{});
        std.log.err("    First mismatch at byte:", .{});
        for (write_buffer[0..test_data_len], read_buffer[0..test_data_len], 0..) |w, r, i| {
            if (w != r) {
                std.log.err("      Index {}: wrote 0x{X:0>2}, read 0x{X:0>2}", .{ i, w, r });
                break;
            }
        }
    }
    std.log.info("", .{});

    std.log.info("All tests complete!", .{});
    std.log.info("", .{});

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}

// Helper functions

fn read_jedec_id(spi_inst: spi.SPI) !u24 {
    const cmd = [_]u8{W25Q_CMD.READ_JEDEC_ID};
    var response: [3]u8 = undefined;

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    try spi_inst.write_blocking(&cmd, mdf.time.Duration.from_ms(10));
    try spi_inst.read_blocking(&response, mdf.time.Duration.from_ms(10));

    return (@as(u24, response[0]) << 16) | (@as(u24, response[1]) << 8) | response[2];
}

fn read_status_reg(spi_inst: spi.SPI) !u8 {
    const cmd = [_]u8{W25Q_CMD.READ_STATUS_REG1};
    var status: u8 = 0;

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    try spi_inst.write_blocking(&cmd, mdf.time.Duration.from_ms(10));
    try spi_inst.read_blocking(@as(*[1]u8, &status), mdf.time.Duration.from_ms(10));

    return status;
}

fn write_enable(spi_inst: spi.SPI) !void {
    const cmd = [_]u8{W25Q_CMD.WRITE_ENABLE};

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    try spi_inst.write_blocking(&cmd, mdf.time.Duration.from_ms(10));
}

fn wait_while_busy(spi_inst: spi.SPI) !void {
    var retries: u32 = 0;
    while (retries < 10000) : (retries += 1) {
        const status = try read_status_reg(spi_inst);
        if (status & W25Q_STATUS.BUSY == 0) return;
        hal.time.sleep_ms(1);
    }
    return error.Timeout;
}

fn erase_sector(spi_inst: spi.SPI, address: u24) !void {
    try write_enable(spi_inst);

    const cmd = [_]u8{
        W25Q_CMD.SECTOR_ERASE_4KB,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS
    try spi_inst.write_blocking(&cmd, mdf.time.Duration.from_ms(10));
    cs_pin.put(1); // Deassert CS

    try wait_while_busy(spi_inst);
}

fn write_page(spi_inst: spi.SPI, address: u24, data: []const u8) !void {
    if (data.len > PAGE_SIZE) return error.PageTooLarge;

    try write_enable(spi_inst);

    const cmd = [_]u8{
        W25Q_CMD.PAGE_PROGRAM,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS

    // Use vectored I/O to send command + data in one operation
    const chunks = [_][]const u8{ &cmd, data };
    try spi_inst.writev_blocking(&chunks, mdf.time.Duration.from_ms(100));

    cs_pin.put(1); // Deassert CS

    try wait_while_busy(spi_inst);
}

fn read_data(spi_inst: spi.SPI, address: u24, data: []u8) !void {
    const cmd = [_]u8{
        W25Q_CMD.READ_DATA,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    try spi_inst.write_blocking(&cmd, mdf.time.Duration.from_ms(10));
    try spi_inst.read_blocking(data, mdf.time.Duration.from_ms(100));
}
