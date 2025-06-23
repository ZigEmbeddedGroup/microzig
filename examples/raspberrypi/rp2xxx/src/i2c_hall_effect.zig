const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const board = microzig.board;

const rp2xxx = microzig.hal;
const i2c = rp2xxx.i2c;
const gpio = rp2xxx.gpio;

const ClockDevice = rp2xxx.drivers.ClockDevice;
const I2C_Device = rp2xxx.drivers.I2C_Device;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const i2c0 = i2c.instance.num(0);

const TLV493D = microzig.drivers.sensor.TLV493D;

const sleep_ms = rp2xxx.time.sleep_ms;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    const sda_pin = gpio.num(4);
    const scl_pin = gpio.num(5);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }

    i2c0.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    // ------------------------ BUS SCAN ------------------------
    std.log.info("I2C bus scan", .{});

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = i2c0.read_blocking(a, &rx_data, null) catch |e| {
            if (e != i2c.TransactionError.DeviceNotPresent and
                e != i2c.TransactionError.TargetAddressReserved)
                std.log.info("Error {any}", .{e});
            continue;
        };

        std.log.info("I2C device found at address {X}.", .{addr});
    }
    i2c0.reset();

    // Create i2c datagram device
    var i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x5E), null);
    // Pass i2c device to driver to create sensor instance
    var cd = ClockDevice{};
    var dev = try TLV493D.init(
        i2c_device.datagram_device(),
        cd.clock_device(),
        .{
            // .mode = .fast,
        },
    );

    while (true) {
        const data = try dev.read();
        std.log.info(
            "accel: x {d: >6.2} y {d: >6.2} z {d: >6.2}",
            .{ data.x, data.y, data.z },
        );

        sleep_ms(500);
    }

    std.log.info("Done!", .{});
}
