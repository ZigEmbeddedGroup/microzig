//! Prints a greeting over USART0 (8N1) and echoes back every byte it receives.
//! It runs at 115200 baud, or 57600 on 8 MHz boards, where 115200 is out of
//! reach. On Nano-style boards it shows up on the USB serial port, e.g.:
//!   picocom -b 115200 /dev/ttyUSB0

const microzig = @import("microzig");
const uart = microzig.hal.uart;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    const baud_rate = if (microzig.board.clock_frequencies.cpu < 16_000_000) 57_600 else 115_200;
    microzig.board.uart_setup.apply(.{ .baud_rate = baud_rate });

    uart.write_blocking("Hello from MicroZig! Type something:\r\n");

    while (true) {
        var byte: u8 = undefined;
        uart.read_byte_blocking(&byte) catch |err| {
            uart.write_blocking(switch (err) {
                error.FramingError => "\r\n[framing error]\r\n",
                error.OverrunError => "\r\n[overrun]\r\n",
                error.ParityError => "\r\n[parity error]\r\n",
            });
            continue;
        };
        uart.write_byte_blocking(byte);
        if (byte == '\r') uart.write_byte_blocking('\n');
    }
}
