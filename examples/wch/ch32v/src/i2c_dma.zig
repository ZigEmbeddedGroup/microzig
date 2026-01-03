const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;
const i2c = hal.i2c;
const dma = hal.dma;

// Configure I2C1 with DMA support
const i2c_config = i2c.Config{
    .baud_rate = 400_000, // 400 kHz fast mode
    .dma = .{
        .tx_channel = .Ch6, // I2C1 TX must use Ch6
        .rx_channel = .Ch7, // I2C1 RX must use Ch7
        .priority = .High,
    },
};

pub fn main() !void {
    board.init();

    const i2c1 = i2c.instance.I2C1;
    i2c1.apply(i2c_config);

    // Example: Write large buffer using DMA
    var tx_buffer: [64]u8 = undefined;
    for (&tx_buffer, 0..) |*byte, i| {
        byte.* = @intCast(i);
    }

    const device_addr: i2c.Address = @enumFromInt(0x50);

    // Explicit DMA write
    try i2c1.write_dma(i2c_config, device_addr, &tx_buffer, null);

    hal.time.sleep_ms(10);

    // Automatic selection (uses DMA for large transfers)
    try i2c1.write_auto(i2c_config, device_addr, &tx_buffer, null);

    // Small transfer (automatic polling)
    const small_buffer = [_]u8{ 0x12, 0x34 };
    try i2c1.write_auto(i2c_config, device_addr, &small_buffer, null);

    // Read using DMA
    var rx_buffer: [64]u8 = undefined;
    try i2c1.read_dma(i2c_config, device_addr, &rx_buffer, null);

    while (true) {
        // Success - blink LED or continue operation
        hal.time.sleep_ms(1000);
    }
}
