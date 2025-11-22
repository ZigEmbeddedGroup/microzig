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

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(100)) catch continue;

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
