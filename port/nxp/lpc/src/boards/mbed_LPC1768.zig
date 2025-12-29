pub const chip = @import("chip");
pub const microzig = @import("microzig");

pub const clock_frequencies = .{
    .cpu = 100_000_000, // 100 Mhz
};

pub const pin_map = .{
    // Onboard-LEDs
    .@"LED-1" = "P1.18",
    .@"LED-2" = "P1.20",
    .@"LED-3" = "P1.21",
    .@"LED-4" = "P1.23",
    .LED_LINK = "P1.25",
    .LED_SPEED = "P1.26",

    // Ethernet
    .@"TD+" = "P1.0",
    .@"TD-" = "P1.1",
    .@"RD+" = "P1.9",
    .@"RD-" = "P1.10",

    // USB
    .@"D+" = "P0.29",
    .@"D-" = "P0.30",

    // GPIO pins
    .DIP5 = "P0.9",
    .DIP6 = "P0.8",
    .DIP7 = "P0.7",
    .DIP8 = "P0.6",
    .DIP9 = "P0.0",
    .DIP10 = "P0.1",
    .DIP11 = "P0.18",
    .DIP12 = "P0.17",
    .DIP13 = "P0.15",
    .DIP14 = "P0.16",
    .DIP15 = "P0.23",
    .DIP16 = "P0.24",
    .DIP17 = "P0.25",
    .DIP18 = "P0.26",
    .DIP19 = "P1.30",
    .DIP20 = "P1.31",
    .DIP21 = "P2.5",
    .DIP22 = "P2.4",
    .DIP23 = "P2.3",
    .DIP24 = "P2.2",
    .DIP25 = "P2.1",
    .DIP26 = "P2.0",
    .DIP27 = "P0.11",
    .DIP28 = "P0.10",
    .DIP29 = "P0.5",
    .DIP30 = "P0.4",
};
