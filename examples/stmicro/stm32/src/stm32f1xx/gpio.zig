const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;

fn delay() void {
    var i: u32 = 0;
    while (i < 100_000) {
        asm volatile ("nop");
        i += 1;
    }
}

pub fn main() !void {
    const led = gpio.Pin.from_port(.C, 13);
    RCC.APB2ENR.modify(.{
        .GPIOAEN = 1,
        .GPIOBEN = 1,
        .GPIOCEN = 1,
    });

    led.set_output_mode(.general_purpose_push_pull, .max_10MHz);
    while (true) {
        delay();
        led.toggle();
    }
}
