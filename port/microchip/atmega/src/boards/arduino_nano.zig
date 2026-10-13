pub const chip = @import("chip");
const hal = @import("microzig").hal;

pub const clock_frequencies = .{
    .cpu = 16_000_000,
};

/// USART0 on PD0 (RX) / PD1 (TX), wired to the USB serial chip.
pub const uart_setup: hal.uart.Setup = .{ .cpu_frequency = clock_frequencies.cpu };

/// SPI on PB5 (SCK), PB3 (MOSI) and PB4 (MISO). PB2 (D10) is set as an
/// output to keep the SPI in host mode.
pub const spi_setup: hal.spi.Setup = .{ .cpu_frequency = clock_frequencies.cpu };
