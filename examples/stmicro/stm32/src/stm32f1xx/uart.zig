const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;

const usart2: stm32.uart.UART = @enumFromInt(0);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);
const RX = gpio.Pin.from_port(.A, 10);

pub fn main() !void {
    TX.set_output_mode(.alternate_function_push_pull, .max_10MHz);
    RX.set_input_mode(.pull);

    RCC.APB2ENR.modify(.{
        .USART1EN = 1,
        .GPIOAEN = 1,
    });

    usart2.apply(.{
        .baud_rate = 9600,
        .clock_speed = 8_000_000,
    });

    var byte: [1]u8 = undefined;

    //simple USART echo
    try usart2.write_blocking("START UART ECHO\n", null);
    while (true) {
        usart2.read_blocking(&byte, null) catch |err| {
            usart2.writer().print("Got error {any}\n", .{err}) catch unreachable;
            usart2.clear_errors();
            continue;
        };
        try usart2.write_blocking(&byte, null);
    }
}
