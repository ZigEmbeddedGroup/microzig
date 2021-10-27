const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

pub fn main() !void {
    var debug_port = micro.Uart(1).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = null,
        .data_bits = .eight,
    }) catch {
        micro.debug.write("Failed");
        micro.hang();
    };

    var out = debug_port.writer();
    var in = debug_port.reader();
    _ = in;

    try out.writeAll("Please enter a sentence:\r\n");

    while (true) {
        try out.writeAll(".");
        micro.debug.write(".");
        micro.debug.busySleep(100_000);
    }
}
