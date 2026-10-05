//! Prints a greeting over USART0 (115200 8N1) and echoes back every byte it
//! receives. On Nano-style boards it shows up on the USB serial port, e.g.:
//!   picocom -b 115200 /dev/ttyUSB0

const microzig = @import("microzig");
const uart = microzig.hal.uart;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    uart.apply(.{
        .cpu_frequency = microzig.board.clock_frequencies.cpu,
        .baud_rate = 115_200,
    });

    uart.write_blocking("Hello from MicroZig! Type something:\r\n");

    while (true) {
        var byte: u8 = undefined;
        uart.read_byte_blocking(&byte) catch {
            uart.write_blocking("\r\n[receive error]\r\n");
            continue;
        };
        uart.write_byte_blocking(byte);
        if (byte == '\r') uart.write_byte_blocking('\n');
    }
}
