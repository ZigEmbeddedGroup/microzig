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
        camera.temperature(&image) catch |err| {
            std.log.err("unable to read image: {}", .{err});
            time.sleep_ms(100);
            continue;
        };

        const hot = find_hottest_pixel(&image);
        const pos = camera_to_display(hot.row, hot.col);

        fb.clear(.black);
        draw_crosshair(&fb, pos.x, pos.y);

        try lcd.write_full_display(fb.bit_stream());
        time.sleep_ms(100);
    }
}

inline fn camera_to_display(row: usize, col: usize) struct { x: i16, y: i16 } {
    return .{
        .x = @intCast(col * 128 / 32 + 2),
        .y = @intCast(row * 64 / 24 + 1),
    };
}

inline fn find_hottest_pixel(image: *const [768]f32) struct { row: usize, col: usize, temp: f32 } {
    var max_temp: f32 = image[0];
    var hot_row: usize = 0;
    var hot_col: usize = 0;
    for (0..24) |row| {
        for (0..32) |col| {
            const temp = image[row * 32 + col];
            if (temp > max_temp) {
                max_temp = temp;
                hot_row = row;
                hot_col = col;
            }
        }
    }
    return .{ .row = hot_row, .col = hot_col, .temp = max_temp };
}

inline fn draw_crosshair(fb: *display.ssd1306.Framebuffer, cx: i16, cy: i16) void {
    for (0..10) |d| {
        const offset: i16 = @as(i16, @intCast(d)) - 5;
        const hx = cx + offset;
        const vy = cy + offset;
        if (hx >= 0 and hx < 128) fb.set_pixel(@intCast(hx), @intCast(@as(u7, @intCast(cy))), .white);
        if (vy >= 0 and vy < 64) fb.set_pixel(@intCast(@as(u7, @intCast(cx))), @intCast(vy), .white);
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
