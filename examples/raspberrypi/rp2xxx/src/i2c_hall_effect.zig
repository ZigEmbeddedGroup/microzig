const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const i2c = rp2xxx.i2c;
const gpio = rp2xxx.gpio;

const I2C_Device = rp2xxx.drivers.I2C_Device;
const I2CError = microzig.drivers.base.I2C_Device.Error;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const TLV493D = microzig.drivers.sensor.TLV493D;

const sleep_ms = rp2xxx.time.sleep_ms;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

const i2c0 = i2c.instance.num(0);

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
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

    // Pass i2c and clock_device to driver to create sensor instance
    var dev = try TLV493D.init(
        I2C_Device.init(i2c0, null).i2c_device(),
        @enumFromInt(0x5E),
        rp2xxx.drivers.clock_device(),
        .{
            .enable_temp = true,
        },
    );

    while (true) {
        const data = try dev.read();
        std.log.info(
            "accel: x {d: >6.2}mT y {d: >6.2}mT z {d: >6.2}mT",
            .{ data.x, data.y, data.z },
        );

        sleep_ms(500);
    }

    std.log.info("Done!", .{});
}
