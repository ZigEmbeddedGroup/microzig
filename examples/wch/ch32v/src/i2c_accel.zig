const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;

const gpio = hal.gpio;
const i2c = hal.i2c;

const I2C_Device = hal.drivers.I2C_Device;
const ICM_20948 = microzig.drivers.sensor.ICM_20948;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = hal.usart.log,
};

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

    const instance = i2c.instance.I2C1;
    const i2c_config = i2c.Config{
        .baud_rate = 100_000, // 100 kHz
        .dma = .{
            .tx_channel = .Ch6, // I2C1 TX must use Ch6
            .rx_channel = .Ch7, // I2C1 RX must use Ch7
            .priority = .High,
            .threshold = 4, // Lower threshold for testing (accelerometer makes 6-byte reads)
        },
    };
    instance.apply(i2c_config);

    // Get the specialized I2C_Device type for this config
    const I2C_DeviceType = hal.drivers.I2C_Device(i2c_config);

    // Create i2c and clock devices
    var i2c_device = I2C_DeviceType.init(instance, null);
    // Pass devices to driver to create sensor instance
    var dev = try ICM_20948.init(
        i2c_device.i2c_device(),
        @enumFromInt(0x69),
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
