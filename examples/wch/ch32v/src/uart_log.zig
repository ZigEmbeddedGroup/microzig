const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;
const time = hal.time;

const uart_setup = board.uart_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = hal.usart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    board.init();

    uart_setup.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart_setup.instance);

    var i: u32 = 0;
    while (true) : (i += 1) {
        std.log.info("what {}", .{i});
        time.sleep_ms(1000);
    }
}
