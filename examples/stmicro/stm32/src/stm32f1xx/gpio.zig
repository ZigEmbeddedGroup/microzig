const std = @import("std");
const microzig = @import("microzig");

const RCC = microzig.chip.peripherals.RCC;
const stm32 = microzig.hal;
const gpio = stm32.gpio;
const timer = stm32.timer.GPTimer.TIM2;

pub fn main() !void {
    const led = gpio.Pin.from_port(.C, 13);
    const counter = timer.into_counter(.{ .pclk = 8_000_000 });

    RCC.APB2ENR.modify(.{
        .GPIOCEN = 1,
    });

    RCC.APB1ENR.modify(.{
        .TIM2EN = 1,
    });

    led.set_output_mode(.general_purpose_push_pull, .max_10MHz);
    while (true) {
        counter.sleep_ms(100);
        led.toggle();
    }
}
