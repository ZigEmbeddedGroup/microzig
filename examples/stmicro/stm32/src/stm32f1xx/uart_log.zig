const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

pub fn main() !void {
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.USART1);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    stm32.uart.init_logger(&uart);
    std.log.info("hello world!", .{});
    var foo: usize = 0;
    while (true) {
        std.log.info("foo {d}", .{foo});
        foo += 1;
    }
}
