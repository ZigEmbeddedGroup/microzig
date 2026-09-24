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

// Configure I2C1 with DMA support
const i2c_config = i2c.Config{
    .baud_rate = 400_000, // 400 kHz fast mode
    .dma = .{
        .tx_channel = .Ch6, // I2C1 TX must use Ch6
        .rx_channel = .Ch7, // I2C1 RX must use Ch7
        .priority = .High,
    },
};

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    // Initialize UART for logging
    uart.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart.instance);

    // Initialize I2C
    i2c_hw.apply(i2c_config);

    const eeprom_address: i2c.Address = @fromBackingInt(0x50);

    // Example: Write large buffer using DMA
    std.log.info("Writing large buffer manually", .{});
    var tx_buffer: [64]u8 = undefined;
    for (&tx_buffer, 0..) |*byte, i| {
        byte.* = @intCast(i);
    }

    // Explicit DMA write
    std.log.info("Writing to EEPROM via DMA", .{});
    try i2c_hw.instance.write_dma(i2c_config, eeprom_address, &tx_buffer, null);

    hal.time.sleep_ms(10);

    // Automatic selection (uses DMA for large transfers)
    std.log.info("Writing to EEPROM via 'auto'", .{});
    try i2c_hw.instance.write_auto(i2c_config, eeprom_address, &tx_buffer, null);

    // Small transfer (automatic polling)
    const small_buffer = [_]u8{ 0x12, 0x34 };
    try i2c_hw.instance.write_auto(i2c_config, eeprom_address, &small_buffer, null);

    // Read using DMA
    std.log.info("Reading from EEPROM via DMA", .{});
    var rx_buffer: [64]u8 = undefined;
    try i2c_hw.instance.read_dma(i2c_config, eeprom_address, &rx_buffer, null);

    while (true) {
        hal.time.sleep_ms(1000);
    }
}
