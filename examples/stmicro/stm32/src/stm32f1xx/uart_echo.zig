const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const rcc = stm32.rcc;

const timer = stm32.timer.GPTimer.init(.TIM2).into_counter_mode();

const uart = stm32.uart.UART.init(.USART1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);
const RX = gpio.Pin.from_port(.A, 10);

pub fn main() !void {
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.TIM2);
    rcc.enable_clock(.USART1);

    const counter = timer.counter_device(rcc.get_clock(.TIM2));

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    RX.set_input_mode(.pull);

    try uart.apply_runtime(.{
        .baud_rate = 115200,
        .clock_speed = rcc.get_clock(.USART1),
    });

    var byte: [100]u8 = undefined;

    //simple USART echo
    try uart.write_blocking("START UART ECHO\n", null);
    while (true) {
        @memset(&byte, 0);
        uart.read_blocking(&byte, counter.make_ms_timeout(100)) catch |err| {
            if (err != error.Timeout) {
                uart.writer().print("Got error {any}\n", .{err}) catch unreachable;
                uart.clear_errors();
                continue;
            }
        };

        uart.write_blocking(&byte, null) catch unreachable;
    }
}
