const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

const i2c = hal.i2c;

const ICM_20948 = microzig.drivers.sensor.ICM_20948(.{ .log_level = null });

const uart = board.uart_setup;
const i2c_hw = board.i2c_setup;

pub const std_options = microzig.std_options(.{
    .log_level = .info,
    .logFn = hal.usart.log,
});

// Configure I2C1 with DMA support
const i2c_config = i2c.Config{
    .baud_rate = 100_000, // 100 kHz
    .dma = .{
        .tx_channel = .Ch6, // I2C1 TX must use Ch6
        .rx_channel = .Ch7, // I2C1 RX must use Ch7
        .priority = .High,
        // Lower DMA threshold for testing (accelerometer makes 6-byte reads)
        .threshold = 4,
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

    // Get the specialized I2C_Device type for this config
    const I2C_DeviceType = hal.drivers.I2C_Device(i2c_config);

    // Create i2c and clock devices
    var i2c_device = I2C_DeviceType.init(i2c_hw.instance, null);
    // Pass devices to driver to create sensor instance
    var dev = try ICM_20948.init(
        i2c_device.i2c_device(),
        @fromBackingInt(@intCast(0x69)),
        hal.drivers.clock_device(),
        .{
            .accel_dlp = .@"6Hz",
            .gyro_dlp = .@"6Hz",
            .accel_odr_div = 21, // About 50Hz
            .gyro_odr_div = 21, // About 50Hz
        },
    );

    try dev.setup();

    while (true) {
        const data = try dev.get_accel_gyro_mag_data();
        std.log.info(
            "accel: x {d: >6.2} y {d: >6.2} z {d: >6.2} (m/s²) " ++
                "gyro: x {d: >6.2} y {d: >6.2} z {d: >6.2} (rads) " ++
                "temp: {d: >5.2}°C " ++
                "mag: x {d: >6.2} y {d: >6.2} z {d: >6.2} (µT)",
            .{ data.accel.x, data.accel.y, data.accel.z, data.gyro.x, data.gyro.y, data.gyro.z, data.temp, data.mag.x, data.mag.y, data.mag.z },
        );

        hal.time.sleep_ms(500);
    }
}
