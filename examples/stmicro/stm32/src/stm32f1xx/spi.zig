const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const GPTimer = stm32.timer.GPTimer;
const gpio = stm32.gpio;
const SPI = stm32.spi.SPI;

const timer = GPTimer.init(.TIM2).into_counter_mode();

const spi = SPI.init(.SPI2);
const MOSI = gpio.Pin.from_port(.B, 15);
const MISO = gpio.Pin.from_port(.B, 14);
const SCK = gpio.Pin.from_port(.B, 13);

pub fn main() void {
    rcc.enable_clock(.GPIOB);
    rcc.enable_clock(.SPI2);
    rcc.enable_clock(.TIM2);

    const counter = timer.counter_device(rcc.get_clock(.TIM2));

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
