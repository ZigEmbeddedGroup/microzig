const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;
const i2c = hal.i2c;

const uart = board.uart_setup;
const i2c_hw = board.i2c_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = hal.usart.log,
});

comptime {
    _ = microzig.export_startup();
}

fn hex_dump(data: []const u8) void {
    var offset: usize = 0;
    while (offset < data.len) : (offset += 16) {
        const end = @min(offset + 16, data.len);
        std.log.info("{x:0>4}: {x}", .{ offset, data[offset..end] });
    }
}

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    // Initialize UART for logging
    uart.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart.instance);

    // Initialize I2C
    i2c_hw.apply(.{});

    const eeprom_address: i2c.Address = @fromBackingInt(0x50);

    // AT24C256 has 32KB (256Kbit), requiring 2-byte addresses
    // Read first 256 bytes as a test
    var data: [256]u8 = undefined;

    // Set address to 0x0000 (2 bytes: high, low)
    try i2c_hw.instance.write_blocking(eeprom_address, &.{ 0x00, 0x00 }, .from_ms(100));
    // Sequential read - address auto-increments
    try i2c_hw.instance.read_blocking(eeprom_address, &data, .from_ms(100));

    std.log.info("Read {d} bytes from EEPROM:", .{data.len});
    hex_dump(&data);

    // Write value 0x42 at address 0x0005
    // Format: [addr_high] [addr_low] [data]
    std.log.info("Writing 0x42 at address 0x0005", .{});
    try i2c_hw.instance.write_blocking(eeprom_address, &.{ 0x00, 0x05, 0x42 }, .from_ms(100));

    // Wait for write cycle to complete (~5ms for AT24C256)
    hal.time.sleep_ms(10);

    // Read back to verify
    try i2c_hw.instance.write_blocking(eeprom_address, &.{ 0x00, 0x00 }, .from_ms(100));
    try i2c_hw.instance.read_blocking(eeprom_address, &data, .from_ms(100));

    std.log.info("After write:", .{});
    hex_dump(&data);

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}
