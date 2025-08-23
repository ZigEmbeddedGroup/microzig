const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const TMP117 = microzig.drivers.sensor.TMP117;

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const peripherals = microzig.chip.peripherals;
const I2C_Device = esp.drivers.I2C_Device;
const sleep_ms = esp.time.sleep_ms;

const i2c0 = i2c.instance.num(0);

const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.log,
};

pub fn main() !void {
    const sda_pin = gpio.num(5);
    const scl_pin = gpio.num(6);

    try i2c0.apply(
        .{ .sda = sda_pin, .scl = scl_pin },
        100_000,
    );

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
