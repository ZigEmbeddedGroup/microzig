pub const chip = @import("chip");

pub const cpu_frequency = 8_000_000;

pub const pin_map = .{
    // LEDs
    .@"LD3" = "PE9", // GPIOE bit 9
};
