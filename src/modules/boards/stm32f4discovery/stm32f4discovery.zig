pub const chip = @import("chip");
pub const micro = @import("microzig");

pub const pin_map = .{
    // LED cross, connected to GPIOD bits 12..15
    // N orange
    .@"LD3" = "PD13",
    // E red
    .@"LD5" = "PD14",
    // S blue
    .@"LD6" = "PD15",
    // W green
    .@"LD4" = "PD12",

    // User button
    .@"B2" = "PA0",
};
