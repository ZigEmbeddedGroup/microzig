pub const microzig = @import("microzig");

pub const hal = microzig.hal;

pub const cpu_frequency = 16_000_000;

pub const pin_map = .{
    // LEDs, connected to GPIOG bits 13, 14
    // green
    .LD3 = "PG13",
    // red
    .LD4 = "PG14",

    // User button
    .B1 = "PA0",
};

pub const leds_config = (hal.pins.GlobalConfiguration{
    .GPIOG = .{
        .PIN13 = .{ .name = "LD3", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN14 = .{ .name = "LD4", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
});
