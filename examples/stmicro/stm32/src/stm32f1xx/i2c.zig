const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;
const i2c = stm32.i2c;

const usart2: stm32.uart.UART = @enumFromInt(0);
const i2c1: i2c.I2C = @enumFromInt(1);
const TX = gpio.Pin.from_port(.A, 9);
const SCL = gpio.Pin.from_port(.B, 10);
const SDA = gpio.Pin.from_port(.B, 11);

fn delay() void {
    var i: u32 = 0;
    while (i < 25_000) {
        asm volatile ("nop");
        i += 1;
    }
}

pub fn main() !void {
    RCC.APB2ENR.modify(.{
        .GPIOBEN = 1,
        .GPIOAEN = 1,
        .AFIOEN = 1,
        .USART1EN = 1,
    });

    RCC.APB1ENR.modify(.{
        .I2C2EN = 1,
    });

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    SCL.set_output_mode(.alternate_function_open_drain, .max_50MHz);
    SDA.set_output_mode(.alternate_function_open_drain, .max_50MHz);

    i2c1.apply(.{
        .pclk = 8_000_000,
        .speed = 100_000,
        .mode = .Standard,
    });

    usart2.apply(.{
        .baud_rate = 9600,
        .clock_speed = 8_000_000,
    });

    var byte: [1]u8 = undefined;
    try usart2.write_blocking("START UART ECHO\n", null);
    while (true) {
        for (0..0xFF) |val| {
            byte[0] = @intCast(val);
            i2c1.write(i2c.Address.new(0x27), &byte) catch |err| {
                usart2.writer().print("error {any}\n", .{err}) catch {};
                i2c1.clear_errors();
                continue;
            };
            usart2.write_blocking("no errors!\n", null) catch {};
            delay();
        }
    }
}
