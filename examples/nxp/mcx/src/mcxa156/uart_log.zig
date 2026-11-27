const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;
const hal = microzig.hal;

pub const std_options = microzig.std_options(.{
    .logFn = hal.lpuart.log,
});

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
    UART.init_logger();
    while (true) {
        hal.time.sleep_ms(1000);
        std.log.info("Hello from MCXA156!", .{});
    }
}
