const std = @import("std");
const microzig = @import("microzig");
const sensor = microzig.drivers.sensor;
const rp2040 = microzig.hal;
const gpio = rp2040.gpio;
const i2c = rp2040.i2c;
const I2C_Device = rp2040.drivers.I2C_Device;
const ClockDevice = rp2040.drivers.ClockDevice;
const MLX90640 = sensor.MLX90640;

const time = rp2040.time;

const uart = rp2040.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

var i2c0 = i2c.instance.num(0);

const pin_config = rp2040.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
};

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2040.uart.logFn,
};

pub fn main() !void {
    try init();

    var cd = ClockDevice{};
    var i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x33), null);

    var camera = try MLX90640.init(.{
        .i2c = i2c_device.datagram_device(),
        .clock = cd.clock_device(),
    });

    const sn = try camera.serialNumber();
    std.log.info("camera serial number: 0x{x}", .{sn});

    try camera.setRefreshRate(0b011);
    const rate = try camera.refreshRate();
    std.log.info("camera refresh rate: 0b{b:0>3}", .{rate});

    const rez = try camera.resolution();
    std.log.info("camera resolution: 0b{b:0>2}", .{rez});

    camera.extractParameters() catch |err| {
        std.log.info("error: bad pixels {}", .{err});
        return;
    };

    var temperature: [834]f32 = undefined;
    var x: [24][32]f32 = undefined;

    while (true) {
        try camera.temperature(&temperature);

        for (0..24) |i| {
            for (0..32) |j| {
                x[i][j] = temperature[i + (i * j)];
            }
        }

        for (0..24) |i| {
            std.log.debug("{d:.3}\n", .{x[i]});
        }
        time.sleep_ms(100);
    }
}

fn init() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2040.clock_config,
    });

    try i2c0.apply(i2c.Config{ .clock_config = rp2040.clock_config });

    rp2040.uart.init_logger(uart);
    pin_config.apply();

    std.log.info("Hello from mlx90640", .{});

    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }
}
