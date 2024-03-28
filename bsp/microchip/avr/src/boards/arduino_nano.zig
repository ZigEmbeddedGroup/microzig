pub const chip = @import("chip");

pub const clock_frequencies = .{
    .cpu = 16_000_000,
};

pub const pin_map = .{
    // Port A
    .D0 = "PD0",
    .D1 = "PD1",
    .D2 = "PD2",
    .D3 = "PD3",
    .D4 = "PD4",
    .D5 = "PD5",
    .D6 = "PD6",
    .D7 = "PD7",
    // Port B
    .D8 = "PB0",
    .D9 = "PB1",
    .D10 = "PB2",
    .D11 = "PB3",
    .D12 = "PB4",
    .D13 = "PB5",
    // Port C (Analog)
    .A0 = "PC0",
    .A1 = "PC1",
    .A2 = "PC2",
    .A3 = "PC3",
    .A4 = "PC4",
    .A5 = "PC5",
    .A6 = "ADC6",
    .A7 = "ADC7",
};
