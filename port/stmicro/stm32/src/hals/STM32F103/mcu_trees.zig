//TODO: find a better way to select and configure the clock tree for each MCU

const std = @import("std");

const STM32F100 = @import("clocks/STM32F100_STM32F100_rcc_v1_0.zig");
const STM32F102 = @import("clocks/STM32F102_STM32F102_rcc_v1_0.zig");
const STM32F105 = @import("clocks/STM32F105_STM32F105_rcc_v1_0.zig");

//Blue Pill
pub const @"STM32F103C(8-B)Tx" = STM32F102.ClockTree(std.StaticStringMap(void).initComptime(.{
    .{ "DIE410", {} },
    .{ "ADC1_Exist", {} },
    .{ "ADC2_Exist", {} },
    .{ "CAN_Exist", {} },
    .{ "CRC_Exist", {} },
    .{ "FATFS_Exist", {} },
    .{ "FREERTOS_Exist", {} },
    .{ "I2C1_Exist", {} },
    .{ "I2C2_Exist", {} },
    .{ "IWDG_Exist", {} },
    .{ "RTC_Exist", {} },
    .{ "SPI1_Exist", {} },
    .{ "SPI2_Exist", {} },
    .{ "SYS_Exist", {} },
    .{ "TIM1_Exist", {} },
    .{ "TIM2_Exist", {} },
    .{ "TIM3_Exist", {} },
    .{ "TIM4_Exist", {} },
    .{ "USART1_Exist", {} },
    .{ "USART2_Exist", {} },
    .{ "USART3_Exist", {} },
    .{ "USB_Exist", {} },
    .{ "USB_DEVICE_Exist", {} },
    .{ "WWDG_Exist", {} },
    .{ "GPIO_Exist", {} },
    .{ "DMA_Exist", {} },
    .{ "NVIC_Exist", {} },
    .{ "STM32F1", {} },
    .{ "STM32F103", {} },
    .{ "LQFP48", {} },
}));

//stm32vldiscovery
pub const @"STM32F100R(8-B)Tx" = STM32F100.ClockTree(std.StaticStringMap(void).initComptime(.{
    .{ "DIE420", {} },
    .{ "ADC1_Exist", {} },
    .{ "CRC_Exist", {} },
    .{ "DAC_Exist", {} },
    .{ "FATFS_Exist", {} },
    .{ "FREERTOS_Exist", {} },
    .{ "HDMI_CEC_Exist", {} },
    .{ "I2C1_Exist", {} },
    .{ "I2C2_Exist", {} },
    .{ "IWDG_Exist", {} },
    .{ "RTC_Exist", {} },
    .{ "SPI1_Exist", {} },
    .{ "SPI2_Exist", {} },
    .{ "SYS_Exist", {} },
    .{ "TIM1_Exist", {} },
    .{ "TIM2_Exist", {} },
    .{ "TIM3_Exist", {} },
    .{ "TIM4_Exist", {} },
    .{ "TIM6_Exist", {} },
    .{ "TIM7_Exist", {} },
    .{ "TIM15_Exist", {} },
    .{ "TIM16_Exist", {} },
    .{ "TIM17_Exist", {} },
    .{ "USART1_Exist", {} },
    .{ "USART2_Exist", {} },
    .{ "USART3_Exist", {} },
    .{ "WWDG_Exist", {} },
    .{ "GPIO_Exist", {} },
    .{ "DMA_Exist", {} },
    .{ "NVIC_Exist", {} },
    .{ "STM32F1", {} },
    .{ "STM32F100_Value_Line", {} },
    .{ "LQFP64", {} },
}));

//some high density MCU
pub const @"STM32F107V(B-C)Tx" = STM32F105.ClockTree(std.StaticStringMap(void).initComptime(.{
    .{ "DIE418", {} },
    .{ "ADC1_Exist", {} },
    .{ "ADC2_Exist", {} },
    .{ "CAN1_Exist", {} },
    .{ "CAN2_Exist", {} },
    .{ "CRC_Exist", {} },
    .{ "DAC_Exist", {} },
    .{ "ETH_Exist", {} },
    .{ "FATFS_Exist", {} },
    .{ "FREERTOS_Exist", {} },
    .{ "I2C1_Exist", {} },
    .{ "I2S2_Exist", {} },
    .{ "I2S3_Exist", {} },
    .{ "IWDG_Exist", {} },
    .{ "LWIP_Exist", {} },
    .{ "RTC_Exist", {} },
    .{ "SPI1_Exist", {} },
    .{ "SPI2_Exist", {} },
    .{ "SPI3_Exist", {} },
    .{ "SYS_Exist", {} },
    .{ "TIM1_Exist", {} },
    .{ "TIM2_Exist", {} },
    .{ "TIM3_Exist", {} },
    .{ "TIM4_Exist", {} },
    .{ "TIM5_Exist", {} },
    .{ "TIM6_Exist", {} },
    .{ "TIM7_Exist", {} },
    .{ "UART4_Exist", {} },
    .{ "UART5_Exist", {} },
    .{ "USART1_Exist", {} },
    .{ "USART2_Exist", {} },
    .{ "USART3_Exist", {} },
    .{ "USB_DEVICE_Exist", {} },
    .{ "USB_HOST_Exist", {} },
    .{ "USB_OTG_FS_Exist", {} },
    .{ "WWDG_Exist", {} },
    .{ "GPIO_Exist", {} },
    .{ "DMA_Exist", {} },
    .{ "NVIC_Exist", {} },
    .{ "STM32F1", {} },
    .{ "STM32F105/107", {} },
    .{ "LQFP100", {} },
}));

pub fn find_clock_tree(comptime name: []const u8) type {
    //ALL F1 peri
    if (std.mem.containsAtLeast(u8, name, 1, "105") or
        std.mem.containsAtLeast(u8, name, 1, "107")) return @"STM32F107V(B-C)Tx";

    if (std.mem.containsAtLeast(u8, name, 1, "100")) return @"STM32F100R(8-B)Tx";

    return @"STM32F103C(8-B)Tx";
}
