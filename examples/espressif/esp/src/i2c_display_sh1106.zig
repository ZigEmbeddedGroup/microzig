const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const SH1106 = microzig.drivers.display.SH1106;

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const peripherals = microzig.chip.peripherals;
const I2C_Device = esp.drivers.I2C_Device;
const sleep_ms = esp.time.sleep_ms;

const i2c0 = i2c.instance.num(0);

const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.logFn,
};

pub fn main() !void {
    const sda_pin = gpio.num(5);
    const scl_pin = gpio.num(6);

    // TODO: Should this be done in apply?
    // Enable I2C peripheral clock
    peripherals.SYSTEM.PERIP_CLK_EN0.modify(.{ .I2C_EXT0_CLK_EN = 1 });
    // Take I2C out of reset
    peripherals.SYSTEM.PERIP_RST_EN0.modify(.{ .I2C_EXT0_RST = 0 });

    try i2c0.apply(
        .{ .sda = sda_pin, .scl = scl_pin },
        400_000,
    );

    // Create i2c datagram device
    const i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x3C));
    // Pass i2c device to driver to create display instance
    const display_driver = SH1106(.{
        .mode = .i2c,
        .Datagram_Device = I2C_Device,
    });

    // Configure device
    const display = try display_driver.init(i2c_device);

    while (true) {
        std.log.debug("Clearing (white)", .{});
        try display.clear_screen(false);
        sleep_ms(500);
        std.log.debug("Clearing (black)", .{});
        try display.clear_screen(true);
        sleep_ms(500);
    }
}
