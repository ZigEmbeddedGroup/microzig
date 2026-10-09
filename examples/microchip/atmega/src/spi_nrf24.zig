//! Reads the STATUS and CONFIG registers of an nRF24L01+ over SPI and prints
//! them over USART0 (115200 8N1) each time a key is pressed. After the
//! radio's power-on reset it reports STATUS=0x0E CONFIG=0x08.
//!
//! Wiring as on the Emakefun RF-Nano V3.0, which has the radio on board: CS on
//! D8 (PB0) and the hardware SPI pins (D11, D12, D13).

const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const cs_pin = hal.gpio.pin(.b, 0);

// nRF24L01+ command and register read here (datasheet §8.3.1 and §9).
const r_register = 0x00;
const config_register = 0x00;

/// Clocked out to receive a byte; the radio ignores it.
const dummy_byte = 0xFF;

pub fn main() void {
    cs_pin.put(1); // deselect the radio before CS becomes an output
    cs_pin.set_direction(.output);

    board.uart_setup.apply(.{ .baud_rate = 115_200 });
    board.spi_setup.apply(.{ .baud_rate = 1_000_000 });

    // Reading only after a key press leaves time for the radio's 100 ms
    // power-on reset, unless a key arrives right after power-up.
    hal.uart.write_blocking("Press a key to read the radio registers.\r\n");

    while (true) {
        var key: u8 = undefined;
        hal.uart.read_byte_blocking(&key) catch continue;

        // R_REGISTER for CONFIG (0x00). The radio shifts out STATUS while it
        // receives the command byte, then CONFIG.
        var rx: [2]u8 = undefined;
        cs_pin.put(0);
        hal.spi.transceive_blocking(&.{ r_register | config_register, dummy_byte }, &rx);
        cs_pin.put(1);

        hal.uart.write_blocking("STATUS=");
        write_hex(rx[0]);
        hal.uart.write_blocking(" CONFIG=");
        write_hex(rx[1]);
        hal.uart.write_blocking("\r\n");
    }
}

fn write_hex(byte: u8) void {
    hal.uart.write_blocking("0x");
    for ([_]u8{ byte >> 4, byte & 0x0F }) |nibble| {
        hal.uart.write_byte_blocking(if (nibble < 10) '0' + nibble else 'A' - 10 + nibble);
    }
}
