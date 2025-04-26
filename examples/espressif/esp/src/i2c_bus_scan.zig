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
    var sda_pin = gpio.num(5);
    var scl_pin = gpio.num(6);
    // TODO: Probably not needed?
    // inline for (&.{ scl_pin, sda_pin }) |pin| {
    //     // Give the pin a sane default config
    //     pin.apply(.{});
    // }

    try i2c0.apply(
        .{ .sda = &sda_pin, .scl = &scl_pin },
        // TODO: Take hal.clock_config?
        100_000,
    );

    std.log.info("Hello", .{}); // DELETEME
    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);
        std.log.info("Trying {x:0>2}", .{addr}); // DELETEME

        // Skip over any reserved addresses.
        if (a.is_reserved()) continue;

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(250)) catch |e| {
            std.log.info("Error {any}", .{e}); // DELETEME
            continue;
        };

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
