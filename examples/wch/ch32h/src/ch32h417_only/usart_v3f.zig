const std = @import("std");
const microzig = @import("microzig");

pub const panic = microzig.panic;

const usart = microzig.hal.usart;
const usart1 = usart.usart1;

pub const std_options = microzig.std_options(.{});
pub const microzig_options: microzig.Options = .{};

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;

pub fn main() !void {
    clocks.init();

    usart1.apply(.{
        .baud_rate = 115200,
        .tx_pin = .{ .gpio = .GPIOA, .number = 9 },
        .rx_pin = .{ .gpio = .GPIOA, .number = 10 },
    });

    cpu.wakeup_v5f();

    while (true) {}
}
