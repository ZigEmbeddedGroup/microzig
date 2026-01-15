const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const i2c = hal.i2c;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

fn hex_dump(data: []const u8) void {
    var offset: usize = 0;
    while (offset < data.len) : (offset += 16) {
        const end = @min(offset + 16, data.len);
        std.log.info("{x:0>4}: {x}", .{ offset, data[offset..end] });
    }
}

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Configure USART2 TX pin (PA2) for alternate function (disable GPIO)
    usart_tx_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud (uses default pins PA2/PA3)
    usart.apply(.{
        .baud_rate = 115200,
        .remap = .default,
    });

    hal.usart.init_logger(usart);

    // I2C1 is on PB6 (SCL) and PB7 (SDA)
    const scl_pin = hal.gpio.Pin.init(1, 6); // GPIOB pin 6
    const sda_pin = hal.gpio.Pin.init(1, 7); // GPIOB pin 7

    // Configure I2C pins for alternate function (open-drain required for I2C)
    scl_pin.configure_alternate_function(.open_drain, .max_50MHz);
    sda_pin.configure_alternate_function(.open_drain, .max_50MHz);

    // Initialize I2C at 100kHz (uses default pins PB6/PB7)
    const instance = i2c.instance.I2C1;
    instance.apply(.{});

    const eeprom_address: i2c.Address = @enumFromInt(0x50);

    // AT24C256 has 32KB (256Kbit), requiring 2-byte addresses
    // Read first 256 bytes as a test
    var data: [256]u8 = undefined;

    // Set address to 0x0000 (2 bytes: high, low)
    try instance.write_blocking(eeprom_address, &.{ 0x00, 0x00 }, .from_ms(100));
    // Sequential read - address auto-increments
    try instance.read_blocking(eeprom_address, &data, .from_ms(100));

    std.log.info("Read {d} bytes from EEPROM:", .{data.len});
    hex_dump(&data);

    // Write value 0x42 at address 0x0005
    // Format: [addr_high] [addr_low] [data]
    std.log.info("Writing 0x42 at address 0x0005", .{});
    try instance.write_blocking(eeprom_address, &.{ 0x00, 0x05, 0x42 }, .from_ms(100));

    // Wait for write cycle to complete (~5ms for AT24C256)
    hal.time.sleep_ms(10);

    // Read back to verify
    try instance.write_blocking(eeprom_address, &.{ 0x00, 0x00 }, .from_ms(100));
    try instance.read_blocking(eeprom_address, &data, .from_ms(100));

    std.log.info("After write:", .{});
    hex_dump(&data);

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}
