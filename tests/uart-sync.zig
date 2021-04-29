const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

// Configures the led_pin to a hardware pin
const uart_txd_pin = micro.Pin("P0.15");
const uart_rxd_pin = micro.Pin("P0.16");

pub const cpu_frequency: u32 = 10_000_000; // 10 MHz

pub fn main() !void {
    var debug_port = micro.Uart(0).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = .none, // { none, even, odd, mark, space }
        .data_bits = .@"8", // 5, 6, 7, 8, or 9 data bits
    });

    var out = debug_port.writer();
    var in = debug_port.reader();

    try out.writeAll("Please enter a sentence:\r\n");

    while (true) {
        try out.writeAll("> ");
        var line_buffer: [64]u8 = undefined;
        const line = (try in.readUntilDelimiterOrEof(&line_buffer, '\r')).?;
        try out.writeAll(line);
    }
}
