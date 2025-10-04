const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const time = stm32.time;
const Duration = microzig.drivers.time.Duration;

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);
const RX = gpio.Pin.from_port(.A, 10);

pub fn main() !void {
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.USART1);

    time.init_timer(.TIM2);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    RX.set_input_mode(.pull);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    var byte: [100]u8 = undefined;

    //simple USART echo
    _ = try uart.write_blocking("START UART ECHO\n", null);
    while (true) {
        @memset(&byte, 0);
        const len = uart.read_blocking(&byte, Duration.from_ms(100)) catch |err| {
            if (err != error.Timeout) {
                uart.writer().print("Got error {any}\n", .{err}) catch unreachable;
                uart.clear_errors();
            }
            continue;
        };

        _ = uart.write_blocking(byte[0..len], null) catch unreachable;
    }
}
