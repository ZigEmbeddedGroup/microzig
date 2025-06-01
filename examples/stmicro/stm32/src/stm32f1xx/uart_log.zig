const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

pub fn main() !void {
    RCC.APB2ENR.modify(.{
        .USART1EN = 1,
        .GPIOAEN = 1,
    });

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    stm32.uart.init_logger(&uart);
    std.log.info("hello world!", .{});
    var foo: usize = 0;
    while (true) {
        std.log.info("foo {d}", .{foo});
        foo += 1;
    }
}
