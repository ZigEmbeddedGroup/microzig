const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;

const board = stm32.rcc.ClockTree;
const config = board.Config{
    .PLLSource = .RCC_PLLSOURCE_HSE,
    .PLLMUL = .RCC_PLL_MUL9,
    .SysClkSource = .RCC_SYSCLKSOURCE_PLLCLK,
    .APB1Prescaler = .RCC_HCLK_DIV2,
    .MCOMult = .RCC_MCO1SOURCE_HSI,
};

pub fn main() !void {
    try rcc.clock_init(config);
    rcc.enable_clock(.GPIOB);

    const reset_reason = stm32.RESET;
    std.mem.doNotOptimizeAway(reset_reason);

    const led = gpio.Pin.from_port(.B, 0);
    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        led.toggle(); //<- use an oscilloscope to observe the frequency change
    }
}
