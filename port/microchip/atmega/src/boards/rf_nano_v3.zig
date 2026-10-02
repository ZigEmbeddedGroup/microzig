//! Emakefun RF-Nano V3.0: Arduino Nano V3.0 compatible board with an onboard
//! nRF24L01+ (or Si24R1) wired to the hardware SPI bus.
//!
//! - Radio: CE = D7 (PD7), CS = D8 (PB0), SCK = D13 (PB5), HODI = D11 (PB3), HIDO = D12 (PB4).
//! - The radio IRQ pin is not connected; poll the STATUS register instead.
//! - The onboard LED shares D13 (PB5) with SCK, so it flickers with SPI traffic.
//! - D7, D8, D11, D12 and D13 are used by the radio.
//!
//! Schematic: https://github.com/emakefun/rf-nano/blob/master/schematic/rf-nano_sch_v3.0.pdf

pub const chip = @import("chip");

pub const clock_frequencies = .{
    .cpu = 16_000_000,
};

pub const pin_map = .{
    // Port D
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

    // Onboard LED
    .LED = "PB5",

    // nRF24L01+ radio
    .NRF_CE = "PD7",
    .NRF_CS = "PB0",
    .SCK = "PB5",
    .HODI = "PB3",
    .HIDO = "PB4",
};
