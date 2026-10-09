pub const chip = @import("chip");
const hal = @import("microzig").hal;

pub const clock_frequencies = .{
    .cpu = 16_000_000,
};

/// USART0 on PD0 (RX) / PD1 (TX), exposed on programming header
pub const uart_setup: hal.uart.Setup = .{ .cpu_frequency = clock_frequencies.cpu };

/// SPI on PB5 (SCK), PB3 (MOSI) and PB4 (MISO). PB2 (D10) is set as an
/// output to keep the SPI in host mode.
pub const spi_setup: hal.spi.Setup = .{ .cpu_frequency = clock_frequencies.cpu };

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

    // Onboard LED
    .LED = "PB5",
};
