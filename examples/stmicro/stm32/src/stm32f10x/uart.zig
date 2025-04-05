const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;

const usart2: stm32.uart.UART = @enumFromInt(1);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 2);
const RX = gpio.Pin.from_port(.A, 3);

pub fn main() !void {
    TX.set_output_mode(.alternate_function_push_pull, .max_10MHz);
    RX.set_output_mode(.alternate_function_push_pull, .max_10MHz);
    RCC.APB2ENR.modify(.{
        .GPIOAEN = 1,
    });

    RCC.APB1ENR.modify(.{
        .USART2EN = 1,
    });

    usart2.apply(.{
        .baud_rate = 9600,
        .clock_speed = 8_000_000,
    });

    while (true) {
        try usart2.write_blocking("teste123\n");
    }
}
