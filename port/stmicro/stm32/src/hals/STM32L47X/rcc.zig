const microzig = @import("microzig");
const enums = @import("../common/enums.zig");

const RCC = microzig.chip.peripherals.RCC;
const PWR = microzig.chip.peripherals.PWR;
const I2C1SEL = microzig.chip.types.peripherals.rcc_l4.I2C1SEL;
const I2C2SEL = microzig.chip.types.peripherals.rcc_l4.I2C2SEL;
const I2C3SEL = microzig.chip.types.peripherals.rcc_l4.I2C3SEL;

const ICSW = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    _,
};
const pins = microzig.hal.pins;

pub const Clock = struct {
    sys_clk: u32 = 4_000_000,
    h_clk: u32 = 4_000_000,
    p1_clk: u32 = 4_000_000,
    p2_clk: u32 = 4_000_000,
    hse: u32 = 0,
    hsi: u32 = 4_000_000,
    pllout: u32 = 0,
    usart1_clk: u32 = 4_000_000,
};

pub var current_clock: Clock = .{};

pub fn enable_gpio_port(used_gpios_port: u8) void {
    RCC.AHB2ENR.modify(.{
        .GPIOAEN = @as(u1, @truncate(0b1 & used_gpios_port)),
        .GPIOBEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 1))),
        .GPIOCEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 2))),
        .GPIODEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 3))),
        .GPIOEEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 4))),
        .GPIOHEN = @as(u1, @truncate(0b1 & (used_gpios_port >> 7))),
    });
}

pub fn enable_uart(comptime index: enums.UART_Type) void {
    switch (index) {
        .LPUART1 => RCC.APB1ENR2.modify(.{ .LPUART1EN = 1 }),
        .USART1 => RCC.APB2ENR.modify(.{ .USART1EN = 1 }),
        .USART2 => RCC.APB1ENR1.modify(.{ .USART2EN = 1 }),
        .USART3 => RCC.APB1ENR1.modify(.{ .USART3EN = 1 }),
        .UART4 => RCC.APB1ENR1.modify(.{ .UART4EN = 1 }),
        .UART5 => RCC.APB1ENR1.modify(.{ .UART5EN = 1 }),
    }
}

pub fn enable_i2c(comptime i2cindex: enums.I2C_Type, clock: ICSW) void {
    RCC.APB1ENR1.modify(switch (i2cindex) {
        .I2C1 => .{ .I2C1EN = 1 },
        .I2C2 => .{ .I2C2EN = 1 },
        .I2C3 => .{ .I2C3EN = 1 },
    });

    RCC.CCIPR.modify(switch (i2cindex) {
        .I2C1 => .{ .I2C1SEL = @as(I2C1SEL, @enumFromInt(@intFromEnum(clock))) },
        .I2C2 => .{ .I2C2SEL = @as(I2C2SEL, @enumFromInt(@intFromEnum(clock))) },
        .I2C3 => .{ .I2C3SEL = @as(I2C3SEL, @enumFromInt(@intFromEnum(clock))) },
    });
}

pub fn enable_rtc_lcd() void {
    RCC.APB1ENR1.modify(.{
        .PWREN = 1,
    });
    PWR.CR1.modify(.{
        .DBP = 1,
    });

    RCC.BDCR.modify(.{
        .LSEON = 1,
    });

    while (RCC.BDCR.read().LSERDY != 1) {
        asm volatile ("" ::: .{ .memory = true });
    }

    RCC.BDCR.modify(.{
        .RTCSEL = .LSE,
        .RTCEN = 1,
        .LSCOEN = 1,
        .LSCOSEL = .LSE,
    });

    RCC.APB1ENR1.modify(.{
        .LCDEN = 1,
    });
}

pub fn enable_dma(index: enums.DMA_Type) void {
    switch (index) {
        .DMA1 => RCC.AHB1ENR.modify(.{ .DMA1EN = 1 }),
        .DMA2 => RCC.AHB1ENR.modify(.{ .DMA2EN = 1 }),
    }
}
