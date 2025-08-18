const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;

const gpio = rp2xxx.gpio;
const i2c = rp2xxx.i2c;

const ClockDevice = rp2xxx.drivers.ClockDevice;
const I2C_Device = rp2xxx.drivers.I2C_Device;
const ICM_20948 = microzig.drivers.sensor.ICM_20948;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const i2c0 = i2c.instance.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.log,
};

const sleep_ms = rp2xxx.time.sleep_ms;

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    defer i2c0.reset();

    const sda_pin = gpio.num(4);
    const scl_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    i2c0.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    // Create i2c and clock devices
    var i2c_device = I2C_Device.init(i2c0, null);
    var cd = ClockDevice{};
    // Pass devices to driver to create sensor instance
    var dev = try ICM_20948.init(
        i2c_device.i2c_device(),
        @enumFromInt(0x69),
        cd.clock_device(),
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

        sleep_ms(500);
    }
}
