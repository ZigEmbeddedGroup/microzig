const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

pub const pins = struct {
    pub const col_1: gpio.Pin = gpio.num(4);
    pub const col_2: gpio.Pin = gpio.num(5);
    pub const col_3: gpio.Pin = gpio.num(6);
    pub const col_4: gpio.Pin = gpio.num(7);
    pub const col_5: gpio.Pin = gpio.num(8);
    pub const col_6: gpio.Pin = gpio.num(9);
    pub const col_7: gpio.Pin = gpio.num(10);
    pub const col_8: gpio.Pin = gpio.num(11);
    pub const col_9: gpio.Pin = gpio.num(12);
    pub const row_1: gpio.Pin = gpio.num(13);
    pub const row_2: gpio.Pin = gpio.num(14);
    pub const row_3: gpio.Pin = gpio.num(15);

    pub const button_a: gpio.Pin = gpio.num(17);
    pub const button_b: gpio.Pin = gpio.num(26);
};

pub const display = struct {
    pub const width = 5;
    pub const height = 5;

    pub fn init() void {
        inline for (&.{
            pins.row_1,
            pins.row_2,
            pins.row_3,
            pins.col_1,
            pins.col_2,
            pins.col_3,
            pins.col_4,
            pins.col_5,
            pins.col_6,
            pins.col_7,
            pins.col_8,
            pins.col_9,
        }) |pin| {
            pin.set_direction(.out);
        }
    }

    pub const led_layout: [width * height]struct {
        row: gpio.Pin,
        col: gpio.Pin,
    } = .{
        .{ .row = pins.row_1, .col = pins.col_1 },
        .{ .row = pins.row_2, .col = pins.col_4 },
        .{ .row = pins.row_1, .col = pins.col_2 },
        .{ .row = pins.row_2, .col = pins.col_5 },
        .{ .row = pins.row_1, .col = pins.col_3 },
        .{ .row = pins.row_3, .col = pins.col_4 },
        .{ .row = pins.row_3, .col = pins.col_5 },
        .{ .row = pins.row_3, .col = pins.col_6 },
        .{ .row = pins.row_3, .col = pins.col_7 },
        .{ .row = pins.row_3, .col = pins.col_8 },
        .{ .row = pins.row_2, .col = pins.col_2 },
        .{ .row = pins.row_1, .col = pins.col_9 },
        .{ .row = pins.row_2, .col = pins.col_3 },
        .{ .row = pins.row_3, .col = pins.col_9 },
        .{ .row = pins.row_2, .col = pins.col_1 },
        .{ .row = pins.row_1, .col = pins.col_8 },
        .{ .row = pins.row_1, .col = pins.col_7 },
        .{ .row = pins.row_1, .col = pins.col_6 },
        .{ .row = pins.row_1, .col = pins.col_5 },
        .{ .row = pins.row_1, .col = pins.col_4 },
        .{ .row = pins.row_3, .col = pins.col_3 },
        .{ .row = pins.row_2, .col = pins.col_7 },
        .{ .row = pins.row_3, .col = pins.col_1 },
        .{ .row = pins.row_2, .col = pins.col_6 },
        .{ .row = pins.row_3, .col = pins.col_2 },
    };
};
