const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const time = stm32.time;

pub fn main() !void {
    try rcc.apply_clock(.{
        .SysClkSource = .RCC_SYSCLKSOURCE_PLLCLK,
        .PLLSource = .RCC_PLLSOURCE_HSE,
        .PLLMUL = .RCC_PLL_MUL9,
        .APB1Prescaler = .RCC_HCLK_DIV2,
        .RTCClkSource = .RCC_RTCCLKSOURCE_LSI,
    });
    rcc.enable_clock(.GPIOC);

    // You can choose the time counting method between RTC or a general purpose Timer (TIM2-TIM5)!
    time.init_rtc();
    //time.init_timer(.TIM2);

    const led = gpio.Pin.from_port(.C, 13);

    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        time.sleep_ms(100);
        led.toggle();
    }
}
