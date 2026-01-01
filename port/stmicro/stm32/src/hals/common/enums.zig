const std = @import("std");
const util = @import("util.zig");
const microzig = @import("microzig");

// Any peripheral that must be enable in RCC.
pub const Peripherals = util.create_peripheral_enum(&.{
    "DMA",
    "USBRAM",
    "FLASH",
    "CRC",
    "SDIO",
    "AFIO",
    "GPIO",
    "ADC",
    "TIM",
    "SPI",
    "USART",
    "WWDG",
    "UART",
    "I2C",
    "CAN",
    "BKP",
    "PWR",
    "DAC",
    "RTC",
    "LPUART",
});

pub const UART_Type = util.sub_peripheral_enum(Peripherals, &.{ "USART", "UART", "LPUART" }, null);
pub const I2C_Type = util.sub_peripheral_enum(Peripherals, &.{"I2C"}, null);
pub const SPI_Type = util.sub_peripheral_enum(Peripherals, &.{"SPI"}, null);
pub const DMA_Type = util.sub_peripheral_enum(Peripherals, &.{"DMA"}, null);
pub const TIMGP16_Type = util.sub_peripheral_enum(Peripherals, &.{"TIM"}, "TIM_GP16");
pub const ADC_Type = util.sub_peripheral_enum(Peripherals, &.{"ADC"}, null);

pub fn to_perihperal(comptime val: anytype) Peripherals {
    return switch (@TypeOf(val)) {
        UART_Type,
        I2C_Type,
        SPI_Type,
        DMA_Type,
        TIMGP16_Type,
        ADC_Type,
        => @as(Peripherals, @enumFromInt(@intFromEnum(val))),
        else => @panic("Value must be one of the sur peripheral enum define below"),
    };
}

pub fn get_regs(comptime T: type, comptime val: anytype) *volatile T {
    const periph_enum = comptime to_perihperal(val);
    return @field(microzig.chip.peripherals, @tagName(periph_enum));
}

pub fn base_perihperal_index(comptime val: anytype) u32 {
    return switch (@TypeOf(val)) {
        UART_Type => @intFromEnum(val) - @intFromEnum(Peripherals.USART1),
        I2C_Type => @intFromEnum(val) - @intFromEnum(Peripherals.I2C1),
        SPI_Type => @intFromEnum(val) - @intFromEnum(Peripherals.SPI1),
        DMA_Type => @intFromEnum(val) - @intFromEnum(Peripherals.DMA1),
        else => @panic("Index peripheral is only for multiple index peripherals"),
    };
}
