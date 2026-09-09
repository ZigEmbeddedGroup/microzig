const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

const i2c = hal.i2c;

const AS5600 = microzig.drivers.sensor.AS5600;

const uart = board.uart_setup;
const i2c_hw = board.i2c_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .info,
    .logFn = hal.usart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    // Initialize UART for logging
    uart.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart.instance);

    // Initialize I2C with DMA
    const i2c_config = i2c.Config{
        .baud_rate = 100_000, // 100 kHz
        .dma = .{
            .tx_channel = .Ch6, // I2C1 TX must use Ch6
            .rx_channel = .Ch7, // I2C1 RX must use Ch7
            .priority = .High,
            .threshold = 4, // Threshold for DMA transfers
        },
    };
    i2c_hw.apply(i2c_config);

    // Get the specialized I2C_Device type for this config
    const I2C_DeviceType = hal.drivers.I2C_Device(i2c_config);

    // Create i2c device
    var i2c_device = I2C_DeviceType.init(i2c_hw.instance, null);
    // Pass device to driver to create sensor instance
    std.log.info("Creating AS5600 driver instance", .{});
    var dev = AS5600.init(i2c_device.i2c_device());

    std.log.info("Starting position sensor reads...", .{});

    while (true) {
        const status = try dev.read_status();
        if (status.MD != 0 and status.MH == 0 and status.ML == 0) {
            const raw_angle = try dev.read_raw_angle();
            std.log.info("Raw Angle: {d:0.2}°", .{raw_angle});
            const angle = try dev.read_angle();
            std.log.info("Angle: {d:0.2}°", .{angle});
            const magnitude = try dev.read_magnitude();
            std.log.info("Magnitude: {any}", .{magnitude});
        } else {
            std.log.warn("Magnet status - MD:{} MH:{} ML:{}", .{ status.MD, status.MH, status.ML });
        }

        hal.time.sleep_ms(250);
    }
}
