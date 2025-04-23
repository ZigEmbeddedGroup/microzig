const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const esp = microzig.hal;
const i2c = esp.i2c;
const gpio = esp.gpio;
const peripherals = microzig.chip.peripherals;

const i2c0 = i2c.instance.num(0);

pub fn main() !void {
    var sda_pin = gpio.num(2);
    var scl_pin = gpio.num(3);
    // TODO: Probably not needed?
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        // Give the pin a sane default config
        pin.apply(.{});
    }

    try i2c0.apply(
        .{ .sda = &sda_pin, .scl = &scl_pin },
        // TODO: Take hal.clock_config?
        100_000,
    );

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        // Skip over any reserved addresses.
        if (a.is_reserved()) continue;

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(100)) catch continue;

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
