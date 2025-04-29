const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const peripherals = microzig.chip.peripherals;

const i2c0 = i2c.instance.num(0);

const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.logFn,
};

pub fn main() !void {
    const sda_pin = gpio.num(6);
    const scl_pin = gpio.num(5);

    // TODO: Should this be done in apply?
    // Enable I2C peripheral clock
    peripherals.SYSTEM.PERIP_CLK_EN0.modify(.{ .I2C_EXT0_CLK_EN = 1 });
    // Take I2C out of reset
    peripherals.SYSTEM.PERIP_RST_EN0.modify(.{ .I2C_EXT0_RST = 0 });

    try i2c0.apply(
        .{ .sda = sda_pin, .scl = scl_pin },
        100_000,
    );

    // for (0x20..0x21) |addr| {
    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(250)) catch continue;

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
