// This is an example RCC configuration for the STM32H723
// Configurations and procedures may vary for other targets

const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const pins = hal.pins;
const rcc = hal.rcc;
const PWR = microzig.chip.peripherals.PWR;

//set Master Clock Output(MCO) pins
const global_pins = pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN8 = .{
            .mode = .{
                .alternate_function = .{
                    .afr = .AF0,
                },
            },
            .name = "MCO1",
        },
    },
    .GPIOC = .{
        .PIN9 = .{
            .mode = .{
                .alternate_function = .{ .afr = .AF0 },
            },
            .name = "MCO2",
        },
    },
};

pub fn main() !void {

    // set inital power state
    PWR.CR3.modify(.{
        .LDOEN = 1,
        .SDEN = 1,
    });

    //configure cpu clock to 550 Mhz
    _ = try rcc.apply(.{
        .HSE_VALUE = 25_000_000,
        .PLLSource = .RCC_PLLSOURCE_HSE,
        .DIVM1 = 5,
        .DIVN1 = 110,
        .DIVP1 = 1,
        .DIVQ1 = 10,
        .SYSCLKSource = .RCC_SYSCLKSOURCE_PLLCLK,
        .RCC_MCO1Source = .RCC_MCO1SOURCE_PLL1QCLK,
        .RCC_MCO2Source = .RCC_MCO2SOURCE_LSICLK,
        .RCC_MCODiv2 = .RCC_MCODIV_10,
        .RCC_MCODiv1 = .RCC_MCODIV_10,
        .D2PPRE2 = .RCC_APB2_DIV2,
        .D2PPRE1 = .RCC_APB1_DIV2,
        .D3PPRE = .RCC_APB4_DIV2,
        .D1PPRE = .RCC_APB3_DIV2,
        .HPRE = .RCC_HCLK_DIV2,
        .flags = .{
            .MCO1Config = true,
            .MCO2Config = true,
            .HSEOscillator = true,
        },
    });

    //apply pins config
    _ = global_pins.apply();

    while (true) {}
}
