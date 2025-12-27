const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;

const MCO = gpio.Pin.from_port(.A, 8);

const uart = stm32.uart.UART.init(.USART1);
const TX = gpio.Pin.from_port(.A, 9);

pub const microzig_options = microzig.Options{
    .logFn = stm32.uart.log,
};

const clk_config = rcc.Config{
    .PLLSource = .RCC_PLLSOURCE_HSE,
    .HSEDivPLL = .RCC_HSE_PREDIV_DIV1,
    .PLLMUL = .RCC_PLL_MUL2,
    .SYSCLKSource = .RCC_SYSCLKSOURCE_PLLCLK,
    .APB1CLKDivider = .RCC_HCLK_DIV2,
    .RCC_MCOSource = .RCC_MCO1SOURCE_SYSCLK,
    .flags = .{
        .HSEOscillator = true,
        .MCOUsed_ForRCC = true,
        .MCOConfig = true,
    },
};

pub fn main() !void {
    _ = try rcc.apply(clk_config);
    rcc.enable_clock(.GPIOA);
    rcc.enable_clock(.AFIO);
    rcc.enable_clock(.USART1);

    TX.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    try uart.apply_runtime(.{
        .clock_speed = rcc.get_clock(.USART1),
    });

    stm32.uart.init_logger(&uart);

    //the value seen in the uart should be equal to the value of the MCO
    try uart.writer().print("sys freq: {d}", .{rcc.get_sys_clk()});

    MCO.set_output_mode(.alternate_function_push_pull, .max_50MHz);
    while (true) {}
}
