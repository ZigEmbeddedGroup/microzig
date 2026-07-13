const std = @import("std");
const microzig = @import("microzig");
const mspm0 = microzig.hal;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    while (true) @breakpoint();
}

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = mspm0.Uart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    mspm0.gpio.enable(.gpioa);

    { // init logger
        const uart_tx = mspm0.gpio.num(.gpioa, 27);
        uart_tx.set_function(5);
        const uart = mspm0.Uart.num(0);
        uart.configure(.{
            .clk = .{ .div = .from_ratio(3) },
        });
        mspm0.Uart.init_logger(uart);
    }

    const led = mspm0.gpio.num(.gpioa, 22);

    led.set_function(1);
    led.set_direction(.out);

    var i: u32 = 0;
    while (true) : (i +%= 1) {
        std.log.info("Toggling LED {}", .{i});
        led.toggle();

        for (0..2_000_000) |_|
            asm volatile ("nop");
    }
}
