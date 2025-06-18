const std = @import("std");
const microzig = @import("microzig");
const config = microzig.config;
const time = microzig.drivers.time;
const nrf = microzig.hal;
const gpio = nrf.gpio;

pub const Revision = enum {
    v1,
    v2,
};

const board_name = config.board_name.?;
pub const revision: Revision = if (std.mem.eql(u8, board_name, "micro:bit v1"))
    .v1
else if (std.mem.eql(u8, board_name, "micro:bit v2"))
    .v2
else
    @compileError("board name `" ++ board_name ++ "` not supported by the micro:bit board");

pub const pins = switch (revision) {
    .v1 => struct {
        pub const display = struct {
            pub const cols: [9]gpio.Pin = .{
                gpio.num(0, 4),
                gpio.num(0, 5),
                gpio.num(0, 6),
                gpio.num(0, 7),
                gpio.num(0, 8),
                gpio.num(0, 9),
                gpio.num(0, 10),
                gpio.num(0, 11),
                gpio.num(0, 12),
            };

            pub const rows: [3]gpio.Pin = .{
                gpio.num(0, 13),
                gpio.num(0, 14),
                gpio.num(0, 15),
            };
        };

        pub const button_a: gpio.Pin = gpio.num(17);
        pub const button_b: gpio.Pin = gpio.num(26);
    },
    .v2 => struct {
        pub const display = struct {
            pub const cols: [5]gpio.Pin = .{
                gpio.num(0, 28),
                gpio.num(0, 11),
                gpio.num(0, 31),
                gpio.num(0, 5),
                gpio.num(0, 30),
            };

            pub const rows: [5]gpio.Pin = .{
                gpio.num(0, 21),
                gpio.num(0, 22),
                gpio.num(0, 15),
                gpio.num(0, 24),
                gpio.num(0, 19),
            };
        };

        pub const button_a: gpio.Pin = gpio.num(14);
        pub const button_b: gpio.Pin = gpio.num(23);
    },
};

// TODO: should led matrix be a driver?

pub const display = struct {
    pub const width = 5;
    pub const height = 5;

    pub fn init() void {
        for (&pins.display.rows) |pin| {
            pin.set_direction(.out);
            pin.put(0);
        }

        for (&pins.display.cols) |pin| {
            pin.set_direction(.out);
            pin.put(1);
        }
    }

    pub fn render(image: [height][width]u1, duration: time.Duration) void {
        // only microbit v1, otherwise just use image
        const matrix = switch (revision) {
            .v1 => blk: {
                var tmp: [matrix_height][matrix_width]u3 = @splat(@splat(0));
                for (0..height) |i| {
                    for (0..width) |j| {
                        const location = led_layout[i][j];
                        tmp[location.row][location.col] = image[i][j];
                    }
                }
                break :blk tmp;
            },
            .v2 => image,
        };

        const done = nrf.time.get_time_since_boot().add_duration(duration);
        while (!done.is_reached_by(nrf.time.get_time_since_boot())) {
            for (0..matrix_height) |i| {
                pins.display.rows[i].put(1);
                for (0..matrix_width) |j| {
                    if (matrix[i][j] != 0) {
                        pins.display.cols[j].put(0);
                    }
                }

                nrf.time.sleep_ms(2);

                for (0..matrix_width) |j| {
                    pins.display.cols[j].put(1);
                }
                pins.display.rows[i].put(0);
            }
        }
    }

    const matrix_height = pins.display.rows.len;
    const matrix_width = pins.display.cols.len;

    // used for microbit v1
    const led_layout: [height][width]struct {
        row: usize,
        col: usize,
    } = .{
        .{
            .{ .row = 0, .col = 0 },
            .{ .row = 1, .col = 3 },
            .{ .row = 0, .col = 1 },
            .{ .row = 1, .col = 4 },
            .{ .row = 0, .col = 2 },
        },
        .{
            .{ .row = 2, .col = 3 },
            .{ .row = 2, .col = 4 },
            .{ .row = 2, .col = 5 },
            .{ .row = 2, .col = 6 },
            .{ .row = 2, .col = 7 },
        },
        .{
            .{ .row = 1, .col = 1 },
            .{ .row = 0, .col = 8 },
            .{ .row = 1, .col = 2 },
            .{ .row = 2, .col = 8 },
            .{ .row = 1, .col = 0 },
        },
        .{
            .{ .row = 0, .col = 7 },
            .{ .row = 0, .col = 6 },
            .{ .row = 0, .col = 5 },
            .{ .row = 0, .col = 4 },
            .{ .row = 0, .col = 3 },
        },
        .{
            .{ .row = 2, .col = 2 },
            .{ .row = 1, .col = 6 },
            .{ .row = 2, .col = 0 },
            .{ .row = 1, .col = 5 },
            .{ .row = 2, .col = 1 },
        },
    };
};
