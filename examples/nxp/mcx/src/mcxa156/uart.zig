const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const hal = microzig.hal;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const UART = hal.lpuart.LPUART.LPUART0;
const PORT0: hal.port.Port = @fromBackingInt(@intCast(0));

pub fn main() !void {
    try hal.syscon.clock_init(.{});
    PORT0.init();
    UART.enable_clock(0, .FRO_12M);
    UART.set_pins(.{ .TXD = .P0_21, .RXD = .P0_20 });
    try UART.apply(.{});
    var data: [1]u8 = .{0};
    while (true) {
        UART.read_blocking(&data, time.Deadline.no_deadline) catch {
            UART.clear_errors();
            continue;
        };
        UART.write_blocking(&data, time.Deadline.no_deadline) catch unreachable;
    }
}
