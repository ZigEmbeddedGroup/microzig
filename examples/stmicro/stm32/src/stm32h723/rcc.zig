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

    //configure cpu clock to 500 Mhz
    _ = try rcc.apply(.{
        .HSE_VALUE = 25_000_000,
        .PLLSourceVirtual = .HSE,
        .DIVM1 = 25,
        .DIVN1 = 500,
        .DIVP1 = 1,
        .DIVQ1 = 10,
        .SYSCLKSource = .PLL1_P,
        .RCC_MCO1Source = .PLL1_Q,
        .RCC_MCO2Source = .SYS,
        .RCC_MCODiv2 = .Div15,
        .RCC_MCODiv1 = .Div10,
        .D2PPRE2 = .Div2,
        .D2PPRE1 = .Div2,
        .D3PPRE = .Div2,
        .D1PPRE = .Div2,
        //.D1CPRE = .RCC_SYSCLK_DIV2,
        .HPRE = .Div2,
        .flags = .{
            .MCO1Config = true,
            .MCO2Config = true,
            .HSEOscillator = true,
            .RCC_MCO1SOURCE_PLL1QCLK = true,
        },
    });

    //apply pins config
    _ = global_pins.apply();

    while (true) {}
}
