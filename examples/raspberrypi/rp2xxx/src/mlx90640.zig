const std = @import("std");
const microzig = @import("microzig");
const sensor = microzig.drivers.sensor;
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const i2c = rp2xxx.i2c;
const I2C_Device = rp2xxx.drivers.I2C_Device;
const MLX90640 = sensor.MLX90640;

const time = rp2xxx.time;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

var i2c0 = i2c.instance.num(0);

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
};

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    try init();

    var i2c_device = I2C_Device.init(i2c0, null);

    var camera = try MLX90640.init(.{
        .i2c = i2c_device.i2c_device(),
        .address = @enumFromInt(0x33),
        .clock = rp2xxx.drivers.clock_device(),
    });

    const sn = try camera.serial_number();
    std.log.info("camera serial number: 0x{x}", .{sn});

    try camera.set_refresh_rate(0b011);
    const rate = try camera.refresh_rate();
    std.log.info("camera refresh rate: 0b{b:0>3}", .{rate});

    const rez = try camera.resolution();
    std.log.info("camera resolution: 0b{b:0>2}", .{rez});

    var temperature: [834]f32 = undefined;
    var x: [24][32]f32 = undefined;

    while (true) {
        camera.temperature(&temperature) catch |err| {
            std.log.err("unable to read temperature: {}", .{err});
            time.sleep_ms(100);
            continue;
        };

        for (0..24) |i| {
            for (0..32) |j| {
                x[i][j] = temperature[i + (i * j)];
            }
        }

        for (0..24) |i| {
            std.log.debug("{any:.3}\n", .{x[i]});
        }
        time.sleep_ms(100);
    }
}

fn init() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    i2c0.apply(i2c.Config{ .clock_config = rp2xxx.clock_config });

    rp2xxx.uart.init_logger(uart);
    pin_config.apply();

    std.log.info("Hello from mlx90640", .{});

    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }
}
