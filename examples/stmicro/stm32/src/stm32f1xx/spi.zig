const std = @import("std");
const microzig = @import("microzig");

const timer = microzig.hal.timer.GPTimer.TIM2;
const RCC = microzig.chip.peripherals.RCC;
const gpio = microzig.hal.gpio;
const spi = microzig.hal.spi.get_SPI(.SPI2);
const MOSI = gpio.Pin.from_port(.B, 15);
const MISO = gpio.Pin.from_port(.B, 14);
const SCK = gpio.Pin.from_port(.B, 13);

pub fn main() void {
    RCC.APB1ENR.modify(.{
        .SPI2EN = 1,
        .TIM2EN = 1,
    });
    RCC.APB2ENR.modify(.{
        .GPIOBEN = 1,
        .AFIOEN = 1,
    });

    const counter = timer.into_counter(8_000_000);

    MOSI.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    MISO.set_input_mode(.pull);
    MISO.set_pull(.up);
    SCK.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    spi.apply(.{ .prescaler = .Div128 });

    const msg = "Hello world!";
    while (true) {
        spi.write_blocking(msg);
        counter.sleep_ms(100);
    }
}
