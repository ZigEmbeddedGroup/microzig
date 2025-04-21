const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;

const timer = stm32.timer.GPTimer.TIM2;

const uart: stm32.uart.UART = @enumFromInt(0);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);
const RX = gpio.Pin.from_port(.A, 10);

pub fn main() !void {
    RCC.APB1ENR.modify(.{
        .TIM2EN = 1,
    });

    RCC.APB2ENR.modify(.{
        .USART1EN = 1,
        .GPIOAEN = 1,
    });

    const counter = timer.into_counter(8_000_000);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    RX.set_input_mode(.pull);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
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
