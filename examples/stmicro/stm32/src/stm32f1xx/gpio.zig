const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;
const timer = stm32.timer.GPTimer.init(.TIM2);

pub fn main() !void {
    RCC.APB2ENR.modify(.{
        .GPIOCEN = 1,
    });

    RCC.APB1ENR.modify(.{
        .TIM2EN = 1,
    });

    const led = gpio.Pin.from_port(.C, 13);
    const counter = timer.into_counter(8_000_000);

    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        counter.sleep_ms(100);
        led.toggle();
    }
}
