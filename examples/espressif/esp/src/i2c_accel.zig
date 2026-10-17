const std = @import("std");
const microzig = @import("microzig");
const ICM_20948 = microzig.drivers.sensor.ICM_20948(.{});

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const I2C_Device = esp.drivers.I2C_Device;
const sleep_ms = esp.time.sleep_ms;

var i2c0 = i2c.instance.num(0);

const usb_serial_jtag = esp.usb_serial_jtag;

pub const std_options = microzig.std_options(.{
    .log_level = .info,
    .logFn = usb_serial_jtag.logger.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    const sda_pin = gpio.num(5);
    const scl_pin = gpio.num(6);

    // Setup SDA pin
    sda_pin.apply(.{
        .output_enable = true,
        .input_enable = true,
        .open_drain = true,
        .pull = .up,
    });

    // Setup SCL pin
    scl_pin.apply(.{
        .output_enable = true,
        .input_enable = true,
        .open_drain = true,
        .pull = .up,
    });

    i2c0.connect_pins(.{ .sda = sda_pin, .scl = scl_pin });
    try i2c0.apply(100_000);

    // Create i2c and clock devices
    var i2c_device = I2C_Device.init(i2c0, null);
    // Pass devices to driver to create sensor instance
    var dev = try ICM_20948.init(
        i2c_device.i2c_device(),
        @fromBackingInt(@intCast(0x69)),
        esp.drivers.clock_device(),
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
