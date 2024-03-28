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
