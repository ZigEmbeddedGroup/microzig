pub const chip = @import("chip");

pub const clock_frequencies = .{
    .cpu = 8_000_000,
};

pub const pin_map = .{
    .D0 = "PB0",
    .D1 = "PB1",
    .D2 = "PB2",
    // Built-in LED on D1 (PB1)
    .LED = "PB1",
};
