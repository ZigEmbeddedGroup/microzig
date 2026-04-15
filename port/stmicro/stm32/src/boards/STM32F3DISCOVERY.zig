const std = @import("std");

pub const microzig = @import("microzig");
const RCC = microzig.chip.peripherals.RCC;

pub const hal = microzig.hal;
const rcc = hal.rcc;

pub const rcc_high_speed: rcc.Config = .{
    .PRESCALERUSB = .RCC_USBCLKSOURCE_PLL_DIV1_5,
    .SYSCLKSource = .RCC_SYSCLKSOURCE_PLLCLK,
    .APB1CLKDivider = .RCC_HCLK_DIV2,
    .PLLSource = .RCC_PLLSOURCE_HSE,
    .PLLMUL = .RCC_PLL_MUL9,
    .flags = .{
        .HSEByPass = true,
        .HSEOscillator = true,
        .USART1Used_ForRCC = true,
        .I2C1Used_ForRCC = true,
    },
};

pub const rcc_medium_speed: rcc.Config = .{
    .SYSCLKSource = .RCC_SYSCLKSOURCE_PLLCLK,
    .APB1CLKDivider = .RCC_HCLK_DIV2,
    .PLLSource = .RCC_PLLSOURCE_HSE,
    .PLLMUL = .RCC_PLL_MUL6,
    .flags = .{
        .HSEByPass = true,
        .HSEOscillator = true,
        .USART1Used_ForRCC = true,
        .I2C1Used_ForRCC = true,
    },
};

pub const uart_logger = hal.uart.UARTLogger(.USART1);

pub const leds_config = (hal.pins.GlobalConfiguration{
    .GPIOE = .{
        .PIN8 = .{ .name = "LD4", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN9 = .{ .name = "LD3", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN10 = .{ .name = "LD5", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN11 = .{ .name = "LD7", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN12 = .{ .name = "LD9", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN13 = .{ .name = "LD10", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN14 = .{ .name = "LD8", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
        .PIN15 = .{ .name = "LD6", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
});

pub fn init() void {
    rcc.apply();
}

// Init should come first or the baud_rate would be too fast for the default HSI.
pub fn init_log() void {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOC = .{
            .PIN4 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
            .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
        },
    }).apply();
    uart_logger.init(.{
        .baud_rate = 9600,
        .dma = hal.dma.DMA1_Channel4.get_channel(),
    });
}

pub fn i2c1() !hal.i2c.I2C_Device {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOB = .{
            // I2C
            .PIN6 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
            .PIN7 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
        },
    }).apply();

    return try hal.i2c.I2C_Device.init(.I2C1);
}
