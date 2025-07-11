const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const GPTimer = microzig.hal.timer.GPTimer;
const gpio = microzig.hal.gpio;
const SPI = microzig.hal.spi.SPI;

const timer = GPTimer.init(.TIM2).into_counter_mode();

const spi = SPI.init(.SPI2);
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

    const counter = timer.counter_device(8_000_000);

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
