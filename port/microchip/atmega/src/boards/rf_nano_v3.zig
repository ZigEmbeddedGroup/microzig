//! Emakefun RF-Nano V3.0: Arduino Nano V3.0 compatible board with an onboard
//! nRF24L01+ (or Si24R1) wired to the hardware SPI bus.
//!
//! - Radio: CE = D7 (PD7), CS = D8 (PB0), SCK = D13 (PB5), MOSI = D11 (PB3), MISO = D12 (PB4).
//! - The radio IRQ pin is not connected; poll the STATUS register instead.
//! - The onboard LED shares D13 (PB5) with SCK, so it flickers with SPI traffic.
//! - D7, D8, D11, D12 and D13 are used by the radio.
//!
//! Schematic: https://github.com/emakefun/rf-nano/blob/master/schematic/rf-nano_sch_v3.0.pdf

pub const chip = @import("chip");
const hal = @import("microzig").hal;

pub const clock_frequencies = .{
    .cpu = 16_000_000,
};

/// USART0 on PD0 (RX) / PD1 (TX), wired to the USB serial chip.
pub const uart_setup: hal.uart.Setup = .{ .cpu_frequency = clock_frequencies.cpu };

/// SPI on PB5 (SCK), PB3 (MOSI) and PB4 (MISO), wired to the radio. PB2 (D10)
/// is set as an output to keep the SPI in host mode.
pub const spi_setup: hal.spi.Setup = .{ .cpu_frequency = clock_frequencies.cpu };
