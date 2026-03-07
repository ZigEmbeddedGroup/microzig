const std = @import("std");
const microzig = @import("microzig");
const sensor = microzig.drivers.sensor;
const display = microzig.drivers.display;
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

    try camera.set_refresh_rate(0b011);

    const i2c_dd = rp2xxx.drivers.I2C_Datagram_Device.init(i2c0, @enumFromInt(0x3C), null);
    const lcd = try display.ssd1306.init(.i2c, i2c_dd, null);
    try lcd.clear_screen(false);

    var fb = display.ssd1306.Framebuffer.init(.black);
    var image: [768]f32 = undefined;

    while (true) {
        camera.image(&image) catch |err| {
            std.log.err("unable to read image: {}", .{err});
            time.sleep_ms(100);
            continue;
        };

        const min_max = min_max_temp(&image);
        const threshold = min_max.min + (min_max.max - min_max.min) * 0.5;

        fb.clear(.black);
        scale_128_x_64(&fb, &image, threshold);

        try lcd.write_full_display(fb.bit_stream());
        time.sleep_ms(100);
    }
}

fn min_max_temp(image: *const [768]f32) struct { min: f32, max: f32 } {
    var min: f32 = image[0];
    var max: f32 = image[0];
    for (0..24) |row| {
        for (0..32) |col| {
            const temp = image[row * 32 + col];
            if (temp < min) min = temp;
            if (temp > max) max = temp;
        }
    }
    return .{ .min = min, .max = max };
}

// Scale 24×32 thermal image to 128×64 framebuffer
fn scale_128_x_64(fb: *display.ssd1306.Framebuffer, image: *const [768]f32, threshold: f32) void {
    for (0..64) |y| {
        const cam_row: usize = y * 24 / 64;
        for (0..128) |x| {
            const cam_col: usize = x * 32 / 128;
            const temp = image[cam_row * 32 + cam_col];
            if (temp >= threshold) {
                fb.set_pixel(@intCast(x), @intCast(y), .white);
            }
        }
    }
}

fn init() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    i2c0.apply(i2c.Config{ .clock_config = rp2xxx.clock_config });

    rp2xxx.uart.init_logger(uart);
    _ = pin_config.apply();

    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }
}
