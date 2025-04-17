const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;

const uart: stm32.uart.UART = @enumFromInt(0);
const gpio = stm32.gpio;
const TX = gpio.Pin.from_port(.A, 9);
const RX = gpio.Pin.from_port(.A, 10);

pub fn main() !void {
    RCC.APB2ENR.modify(.{
        .USART1EN = 1,
        .GPIOAEN = 1,
    });

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    RX.set_input_mode(.pull);

    uart.apply(.{
        .baud_rate = 115200,
        .clock_speed = 8_000_000,
    });

    var byte: [1]u8 = undefined;

    //simple USART echo
    try uart.write_blocking("START UART ECHO\n", null);
    while (true) {
        uart.read_blocking(&byte, null) catch |err| {
            uart.writer().print("Got error {any}\n", .{err}) catch unreachable;
            uart.clear_errors();
            continue;
        };
        try uart.write_blocking(&byte, null);
    }
}
