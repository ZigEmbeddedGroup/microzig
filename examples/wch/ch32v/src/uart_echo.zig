const microzig = @import("microzig");

const hal = microzig.hal;
const board = microzig.board;
const time = hal.time;

const uart = board.uart_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    board.init();

    uart.apply(.{ .baud_rate = 115200 });

    const usart = uart.instance;

    var data: [1]u8 = .{0};
    while (true) {
        usart.read_blocking(&data, .no_deadline) catch {
            continue;
        };
        _ = usart.write_blocking(&data, time.deadline_in_ms(100)) catch {};
    }
}
