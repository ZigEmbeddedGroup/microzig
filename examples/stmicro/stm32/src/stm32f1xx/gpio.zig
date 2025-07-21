const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const timer = stm32.timer.GPTimer.init(.TIM2).into_counter_mode();

pub fn main() !void {
    rcc.enable_clock(.GPIOC);
    rcc.enable_clock(.TIM2);
    const led = gpio.Pin.from_port(.C, 13);
    const counter = timer.counter_device(rcc.get_clock(.TIM2));

    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        counter.sleep_ms(100);
        led.toggle();
    }
}
