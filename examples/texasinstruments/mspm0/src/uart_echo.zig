const std = @import("std");
const microzig = @import("microzig");
const mspm0 = microzig.hal;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});
comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    mspm0.gpio.enable(.gpioa);

    const led = mspm0.gpio.num(.gpioa, 22);
    const uart_rx = mspm0.gpio.num(.gpioa, 26);
    const uart_tx = mspm0.gpio.num(.gpioa, 27);

    led.set_function(1);
    led.set_direction(.out);

    uart_rx.set_function(3);
    uart_tx.set_function(5);

    const uart = mspm0.Uart.num(0);
    uart.configure(.{
        .clk = .{ .div = .from_float(3.0) },
    });

    while (true) {
        led.toggle();

        if (uart.read()) |c|
            _ = uart.write(std.ascii.toUpper(c))
        else
            _ = uart.write('.');

        for (0..1_000_000) |_|
            asm volatile ("nop");
    }
}
