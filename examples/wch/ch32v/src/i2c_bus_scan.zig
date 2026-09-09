const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;
const i2c = hal.i2c;

const uart = board.uart_setup;
const i2c_hw = board.i2c_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = hal.usart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    // Initialize UART for logging
    uart.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart.instance);

    // Initialize I2C
    i2c_hw.apply(.{});

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @fromBackingInt(@intCast(addr));

        var rx_data: [1]u8 = undefined;
        _ = i2c_hw.instance.read_blocking(a, &rx_data, null) catch |e| {
            // Expected errors for non-present devices
            if (e != i2c.Error.NoAcknowledge and e != i2c.Error.Timeout) {
                std.log.warn("Unexpected error at 0x{X:0>2}: {}", .{ addr, e });
            }
            continue;
        };
        std.log.info("I2C device found at address {X}.", .{addr});
    }

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}
