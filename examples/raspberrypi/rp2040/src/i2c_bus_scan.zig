const std = @import("std");
const microzig = @import("microzig");

const rp2040 = microzig.hal;
const i2c = rp2040.i2c;
const gpio = rp2040.gpio;
const peripherals = microzig.chip.peripherals;

pub const microzig_options = .{
    .log_level = .info,
    .logFn = rp2040.uart.log,
};

const uart = rp2040.uart.num(0);
const i2c0 = i2c.instance.num(0);

pub fn main() !void {
    uart.apply(.{
        .baud_rate = 115200,
        .tx_pin = gpio.num(0),
        .rx_pin = gpio.num(1),
        .clock_config = rp2040.clock_config,
    });
    rp2040.uart.init_logger(uart);

    const scl_pin = gpio.num(4);
    const sda_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }

    try i2c0.apply(.{
        .clock_config = rp2040.clock_config,
    });

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        // Skip over any reserved addresses.
        if (a.is_reserved()) continue;

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, rp2040.time.Duration.from_ms(100)) catch continue;

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
