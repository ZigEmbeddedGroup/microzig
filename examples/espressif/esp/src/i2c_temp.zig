const std = @import("std");
const microzig = @import("microzig");
const TMP117 = microzig.drivers.sensor.TMP117;

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const I2C_Device = esp.drivers.I2C_Device;
const sleep_ms = esp.time.sleep_ms;

var i2c0 = i2c.instance.num(0);

const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.log,
};

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

    // Create i2c datagram device
    var i2c_device = I2C_Device.init(i2c0, null);
    // Pass i2c device to driver to create sensor instance
    const temp_sensor = try TMP117.init(i2c_device.i2c_device(), @enumFromInt(0x48));

    // Configure device
    try temp_sensor.write_configuration(.{});

    while (true) {
        const temp = try temp_sensor.read_temperature();
        std.log.info("Temp: {d:0.2}°C", .{temp});
        sleep_ms(1000);
    }
}
