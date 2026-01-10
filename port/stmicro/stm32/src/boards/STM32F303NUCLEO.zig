const std = @import("std");

pub const microzig = @import("microzig");

pub const hal = microzig.hal;

pub const leds_config = (hal.pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN5 = .{ .name = "LD2", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
});
