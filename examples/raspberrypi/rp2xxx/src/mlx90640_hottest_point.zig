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
var i2c1 = i2c.instance.num(1);

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
};

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    try init();

    var i2c_device = I2C_Device.init(i2c1, null);

    var camera = try MLX90640.init(.{
        .i2c = i2c_device.i2c_device(),
        .address = @enumFromInt(0x33),
        .clock = rp2xxx.drivers.clock_device(),
    });

    try camera.set_refresh_rate(0b101);

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

        const centroid = find_hottest_cluster_centroid(&image);
        const pos = camera_to_display(centroid.row, centroid.col);

        fb.clear(.black);
        draw_crosshair(&fb, pos.x, pos.y);

        try lcd.write_full_display(fb.bit_stream());
        time.sleep_ms(50);
    }
}

inline fn camera_to_display(row: f32, col: f32) struct { x: i16, y: i16 } {
    return .{
        .x = @intFromFloat((31.0 - col) * 128.0 / 32.0 + 2.0),
        .y = @intFromFloat(row * 64.0 / 24.0 + 1.0),
    };
}

inline fn find_hottest_cluster_centroid(image: *const [768]f32) struct { row: f32, col: f32 } {
    var max_temp: f32 = image[0];
    for (image) |temp| {
        if (temp > max_temp) max_temp = temp;
    }

    const threshold = max_temp - 2.0;

    var hot: [768]bool = undefined;
    for (0..768) |i| {
        hot[i] = image[i] >= threshold;
    }

    var visited: [768]bool = .{false} ** 768;
    var queue: [768]u16 = undefined;

    var best_sum_row: f32 = 0;
    var best_sum_col: f32 = 0;
    var best_sum_weight: f32 = 0;
    var best_count: usize = 0;

    for (0..768) |start| {
        if (!hot[start] or visited[start]) continue;

        var sum_row: f32 = 0;
        var sum_col: f32 = 0;
        var sum_weight: f32 = 0;
        var count: usize = 0;
        var head: usize = 0;
        var tail: usize = 0;

        queue[tail] = @intCast(start);
        tail += 1;
        visited[start] = true;

        while (head < tail) {
            const cur = queue[head];
            head += 1;
            const r: i32 = @intCast(cur / 32);
            const c: i32 = @intCast(cur % 32);
            const weight = image[cur];
            sum_row += @as(f32, @floatFromInt(r)) * weight;
            sum_col += @as(f32, @floatFromInt(c)) * weight;
            sum_weight += weight;
            count += 1;

            const deltas = [_][2]i32{ .{ 0, 1 }, .{ 0, -1 }, .{ 1, 0 }, .{ -1, 0 } };
            for (deltas) |d| {
                const nr = r + d[0];
                const nc = c + d[1];
                if (nr >= 0 and nr < 24 and nc >= 0 and nc < 32) {
                    const ni: usize = @intCast(@as(u32, @intCast(nr)) * 32 + @as(u32, @intCast(nc)));
                    if (hot[ni] and !visited[ni]) {
                        visited[ni] = true;
                        queue[tail] = @intCast(ni);
                        tail += 1;
                    }
                }
            }
        }

        if (count > best_count) {
            best_count = count;
            best_sum_row = sum_row;
            best_sum_col = sum_col;
            best_sum_weight = sum_weight;
        }
    }

    if (best_sum_weight > 0) {
        return .{
            .row = best_sum_row / best_sum_weight,
            .col = best_sum_col / best_sum_weight,
        };
    } else {
        return .{ .row = 12.0, .col = 16.0 };
    }
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
    i2c1.apply(i2c.Config{ .clock_config = rp2xxx.clock_config });

    rp2xxx.uart.init_logger(uart);
    _ = pin_config.apply();

    // i2c0: camera (GPIO4=SDA, GPIO5=SCL)
    const i2c0_scl = gpio.num(5);
    const i2c0_sda = gpio.num(4);
    inline for (&.{ i2c0_scl, i2c0_sda }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    // i2c1: display (GPIO2=SDA, GPIO3=SCL)
    const i2c1_scl = gpio.num(3);
    const i2c1_sda = gpio.num(2);
    inline for (&.{ i2c1_scl, i2c1_sda }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }
}
