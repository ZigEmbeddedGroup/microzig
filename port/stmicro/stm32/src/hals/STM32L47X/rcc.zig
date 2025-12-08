const microzig = @import("microzig");
const emus_type = @import("./enums.zig");

const RCC = microzig.chip.peripherals.RCC;

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

pub fn enable_uart(comptime index: emus_type.UARTType) void {
    switch (index) {
        .USART1 => RCC.APB2ENR.modify(.{ .USART1EN = 1 }),
        .USART2 => RCC.APB1ENR1.modify(.{ .USART2EN = 1 }),
        .USART3 => RCC.APB1ENR1.modify(.{ .USART3EN = 1 }),
        .UART4 => RCC.APB1ENR1.modify(.{ .UART4EN = 1 }),
        .UART5 => RCC.APB1ENR1.modify(.{ .UART5EN = 1 }),
    }
}
