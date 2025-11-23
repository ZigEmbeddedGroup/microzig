const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const i2c = rp2xxx.i2c;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = rp2xxx.uart.log,
};

const i2c0 = i2c.instance.num(0);

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    const sda_pin = gpio.num(4);
    const scl_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    i2c0.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, null) catch |e| {
            if (e != i2c.Error.DeviceNotPresent and
                e != i2c.Error.IllegalAddress)
                std.log.info("Error {any}", .{e});
            continue;
        };

        std.log.info("I2C device found at address {X}.", .{addr});
    }
}
