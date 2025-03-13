const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const i2c = rp2xxx.i2c;
const gpio = rp2xxx.gpio;
const peripherals = microzig.chip.peripherals;
const chip = rp2xxx.compatibility.chip;

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.logFn,
};

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

const i2c0 = i2c.instance.num(0);

pub fn main() !void {
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    const scl_pin = gpio.num(4);
    const sda_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }

    try i2c0.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        // Skip over any reserved addresses.
        if (a.is_reserved()) continue;

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, time.Duration.from_ms(100)) catch continue;

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
