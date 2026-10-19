//! W25Q128 SPI Flash Test
//!
//! This example demonstrates using the SPI HAL with external W25Q128 flash memory.
//!
//! Hardware setup:
//! - W25Q128 flash chip connected to SPI0:
//!   - CS:   PB0 (or any GPIO)
//!   - SCK:  PB5
//!   - MISO: PB4
//!   - MOSI: PB3
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
const hal = microzig.hal;
const board = microzig.board;
const spi = hal.spi;
const uart = hal.uart;

const spi_hw = board.spi_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

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

// CS pin
const cs_pin = hal.gpio.pin(.b, 0);

pub fn main() !void {
    board.uart_setup.apply(.{ .baud_rate = 57600 });
    uart.write_blocking("W25Q128 SPI Flash Test\r\n");
    uart.write_blocking("======================\r\n");
    uart.write_blocking("\r\n");

    cs_pin.set_direction(.output);
    cs_pin.put(1);

    uart.write_blocking("Initializing SPI...\r\n");
    spi_hw.apply(.{ .baud_rate = 1_000_000 });
    uart.write_blocking("SPI initialized\r\n");
    uart.write_blocking("\r\n");

    // Test 1: Read JEDEC ID
    uart.write_blocking("Test 1: Reading JEDEC ID...\r\n");
    const jedec_id = read_jedec_id(spi_hw.instance);
    uart.write_blocking("  JEDEC ID: 0x");
    write_hex_u24(jedec_id);
    uart.write_blocking("\r\n");

    if (jedec_id == JEDEC_ID_EXPECTED) {
        uart.write_blocking("  Device: Winbond W25Q128 - VERIFIED\r\n");
    } else {
        uart.write_blocking("  Unknown device\r\n");
    }
    uart.write_blocking("\r\n");

    // Test 2: Read Status Register
    uart.write_blocking("Test 2: Reading Status Register...\r\n");
    const status = read_status_reg(spi_hw.instance);
    uart.write_blocking("  Status: 0x");
    write_hex_u8(status);
    uart.write_blocking("\r\n");
    if (status & W25Q_STATUS.BUSY != 0) {
        uart.write_blocking("  BUSY: true\r\n");
    } else {
        uart.write_blocking("  BUSY: false\r\n");
    }
    if (status & W25Q_STATUS.WEL != 0) {
        uart.write_blocking("  WEL:  true\r\n");
    } else {
        uart.write_blocking("  WEL:  false\r\n");
    }
    uart.write_blocking("\r\n");

    // Test 3: Erase/Write/Read Cycle
    uart.write_blocking("Test 3: Erase/Write/Read Cycle...\r\n");
    const test_address: u24 = 0x001000;

    var write_buffer: [PAGE_SIZE]u8 = undefined;
    for (&write_buffer, 0..) |*byte, i| {
        byte.* = @truncate(i);
    }

    uart.write_blocking("  Erasing sector at 0x");
    write_hex_u24(test_address);
    uart.write_blocking("...\r\n");
    erase_sector(spi_hw.instance, test_address);
    uart.write_blocking("  Sector erased\r\n");

    uart.write_blocking("  Writing 256 bytes...\r\n");
    write_page(spi_hw.instance, test_address, &write_buffer);
    uart.write_blocking("  Page written\r\n");

    uart.write_blocking("  Reading 256 bytes...\r\n");
    var read_buffer: [PAGE_SIZE]u8 = undefined;
    read_data(spi_hw.instance, test_address, &read_buffer);
    uart.write_blocking("  Page read\r\n");

    // Verify
    uart.write_blocking("  Verifying data...\r\n");
    var mismatch: bool = false;
    for (0..PAGE_SIZE) |i| {
        if (write_buffer[i] != read_buffer[i]) {
            uart.write_blocking("  Data mismatch!\r\n");
            uart.write_blocking("    First mismatch at byte 0x");
            write_hex_u8(@truncate(i));
            uart.write_blocking(": wrote 0x");
            write_hex_u8(write_buffer[i]);
            uart.write_blocking(", read 0x");
            write_hex_u8(read_buffer[i]);
            uart.write_blocking("\r\n");
            mismatch = true;
            break;
        }
    }
    if (!mismatch) {
        uart.write_blocking("  Data verified\r\n");
    }
    uart.write_blocking("\r\n");

    uart.write_blocking("All tests complete!\r\n");
    uart.write_blocking("\r\n");

    while (true) {
        busy_sleep(1_000_000);
    }
}

// Helper functions

fn read_jedec_id(spi_inst: spi.SPI) u24 {
    const cmd = [_]u8{W25Q_CMD.READ_JEDEC_ID};
    var response: [3]u8 = undefined;

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    spi_inst.write_blocking(&cmd);
    spi_inst.read_blocking(&response);

    return (@as(u24, response[0]) << 16) | (@as(u24, response[1]) << 8) | response[2];
}

fn read_status_reg(spi_inst: spi.SPI) u8 {
    const cmd = [_]u8{W25Q_CMD.READ_STATUS_REG1};
    var status: u8 = 0;

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    spi_inst.write_blocking(&cmd);
    spi_inst.read_blocking(@as(*[1]u8, &status));

    return status;
}

fn write_enable(spi_inst: spi.SPI) void {
    const cmd = [_]u8{W25Q_CMD.WRITE_ENABLE};

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    spi_inst.write_blocking(&cmd);
}

fn wait_while_busy(spi_inst: spi.SPI) void {
    var retries: u16 = 0;
    while (retries < 10000) : (retries += 1) {
        const status = read_status_reg(spi_inst);
        if (status & W25Q_STATUS.BUSY == 0) return;
    }
    // Timeout — device did not become ready
}

fn erase_sector(spi_inst: spi.SPI, address: u24) void {
    write_enable(spi_inst);

    const cmd = [_]u8{
        W25Q_CMD.SECTOR_ERASE_4KB,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS
    spi_inst.write_blocking(&cmd);
    cs_pin.put(1); // Deassert CS

    wait_while_busy(spi_inst);
}

fn write_page(spi_inst: spi.SPI, address: u24, data: []const u8) void {
    write_enable(spi_inst);

    const cmd = [_]u8{
        W25Q_CMD.PAGE_PROGRAM,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS

    // Use vectored I/O to send command + data in one operation
    const chunks = [_][]const u8{ &cmd, data };
    spi_inst.writev_blocking(&chunks);

    cs_pin.put(1); // Deassert CS

    wait_while_busy(spi_inst);
}

fn read_data(spi_inst: spi.SPI, address: u24, data: []u8) void {
    const cmd = [_]u8{
        W25Q_CMD.READ_DATA,
        @truncate(address >> 16),
        @truncate(address >> 8),
        @truncate(address),
    };

    cs_pin.put(0); // Assert CS
    defer cs_pin.put(1); // Deassert CS

    spi_inst.write_blocking(&cmd);
    spi_inst.read_blocking(data);
}

const hex_chars = "0123456789ABCDEF";

fn write_hex_u8(val: u8) void {
    const out = [2]u8{ hex_chars[val >> 4], hex_chars[val & 0x0F] };
    uart.write_blocking(&out);
}

fn write_hex_u24(val: u24) void {
    write_hex_u8(@truncate(val >> 16));
    write_hex_u8(@truncate(val >> 8));
    write_hex_u8(@truncate(val));
}

pub fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be positive!");

    const outer = std.math.divCeil(comptime_int, limit, std.math.maxInt(u16)) catch unreachable;
    const inner = limit / outer;

    for (0..outer) |_| {
        var i: std.math.IntFittingRange(0, inner) = 0;
        while (i < inner) : (i += 1) {
            std.mem.doNotOptimizeAway(i);
        }
    }
}
