//AUTO-GENERATED FILE. DO NOT MODIFY.
//any issues or changes should be made in the source JSON files or the generator script.

const std = @import("std");
const clock = @import("nodes/ClockNode.zig");
const ClockNode = clock.ClockNode;
const ClockNodeTypes = clock.ClockNodesTypes;
const ClockState = clock.ClockState;
const ClockError = clock.ClockError;
const comptime_fail_or_error = clock.comptime_fail_or_error;
const math_op = clock.math_op;
const check_ref = clock.check_ref;
const Limit = clock.Limit;

pub const SYSCLKSourceList = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_HSE => 1,
            .RCC_SYSCLKSOURCE_PLLCLK => 2,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_HSE => 1,
        };
    }
};
pub const RTCClockSelectionList = enum {
    HSERTCDevisor,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .HSERTCDevisor => 0,
            .RCC_RTCCLKSOURCE_LSE => 1,
            .RCC_RTCCLKSOURCE_LSI => 2,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_SYSCLK,
    RCC_I2C1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_SYSCLK => 1,
            .RCC_I2C1CLKSOURCE_HSI => 2,
        };
    }
};
pub const I2C2CLockSelectionList = enum {
    RCC_I2C2CLKSOURCE_PCLK1,
    RCC_I2C2CLKSOURCE_SYSCLK,
    RCC_I2C2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_PCLK1 => 0,
            .RCC_I2C2CLKSOURCE_SYSCLK => 1,
            .RCC_I2C2CLKSOURCE_HSI => 2,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK1,
    RCC_I2C3CLKSOURCE_SYSCLK,
    RCC_I2C3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK1 => 0,
            .RCC_I2C3CLKSOURCE_SYSCLK => 1,
            .RCC_I2C3CLKSOURCE_HSI => 2,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_PCLK1,
    RCC_I2C4CLKSOURCE_SYSCLK,
    RCC_I2C4CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_PCLK1 => 0,
            .RCC_I2C4CLKSOURCE_SYSCLK => 1,
            .RCC_I2C4CLKSOURCE_HSI => 2,
        };
    }
};
pub const PLL48CLockSelectionList = enum {
    RCC_CLK48SOURCE_PLL,
    RCC_CLK48SOURCE_PLLSAIP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLK48SOURCE_PLL => 0,
            .RCC_CLK48SOURCE_PLLSAIP => 1,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLLSAI,
    RCC_SAI1CLKSOURCE_PLLI2S,
    RCC_SAI1CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLLSAI => 0,
            .RCC_SAI1CLKSOURCE_PLLI2S => 1,
            .RCC_SAI1CLKSOURCE_PIN => 2,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLLSAI,
    RCC_SAI2CLKSOURCE_PLLI2S,
    RCC_SAI2CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLLSAI => 0,
            .RCC_SAI2CLKSOURCE_PLLI2S => 1,
            .RCC_SAI2CLKSOURCE_PIN => 2,
        };
    }
};
pub const I2SCLockSelectionList = enum {
    RCC_I2SCLKSOURCE_PLLI2S,
    RCC_I2SCLKSOURCE_EXT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SCLKSOURCE_PLLI2S => 0,
            .RCC_I2SCLKSOURCE_EXT => 1,
        };
    }
};
pub const SDMMCClockSelectionList = enum {
    RCC_SDMMC1CLKSOURCE_CLK48,
    RCC_SDMMC1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC1CLKSOURCE_CLK48 => 0,
            .RCC_SDMMC1CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_HSI => 2,
            .RCC_MCO1SOURCE_PLLCLK => 3,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_PLLI2SCLK,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_SYSCLK => 0,
            .RCC_MCO2SOURCE_PLLI2SCLK => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_PLLCLK => 3,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK2,
    RCC_USART1CLKSOURCE_SYSCLK,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_SYSCLK => 1,
            .RCC_USART1CLKSOURCE_HSI => 2,
            .RCC_USART1CLKSOURCE_LSE => 3,
        };
    }
};
pub const USART2CLockSelectionList = enum {
    RCC_USART2CLKSOURCE_PCLK1,
    RCC_USART2CLKSOURCE_SYSCLK,
    RCC_USART2CLKSOURCE_HSI,
    RCC_USART2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_PCLK1 => 0,
            .RCC_USART2CLKSOURCE_SYSCLK => 1,
            .RCC_USART2CLKSOURCE_HSI => 2,
            .RCC_USART2CLKSOURCE_LSE => 3,
        };
    }
};
pub const USART3CLockSelectionList = enum {
    RCC_USART3CLKSOURCE_PCLK1,
    RCC_USART3CLKSOURCE_SYSCLK,
    RCC_USART3CLKSOURCE_HSI,
    RCC_USART3CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART3CLKSOURCE_PCLK1 => 0,
            .RCC_USART3CLKSOURCE_SYSCLK => 1,
            .RCC_USART3CLKSOURCE_HSI => 2,
            .RCC_USART3CLKSOURCE_LSE => 3,
        };
    }
};
pub const USART6CLockSelectionList = enum {
    RCC_USART6CLKSOURCE_PCLK2,
    RCC_USART6CLKSOURCE_SYSCLK,
    RCC_USART6CLKSOURCE_HSI,
    RCC_USART6CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART6CLKSOURCE_PCLK2 => 0,
            .RCC_USART6CLKSOURCE_SYSCLK => 1,
            .RCC_USART6CLKSOURCE_HSI => 2,
            .RCC_USART6CLKSOURCE_LSE => 3,
        };
    }
};
pub const UART4CLockSelectionList = enum {
    RCC_UART4CLKSOURCE_PCLK1,
    RCC_UART4CLKSOURCE_SYSCLK,
    RCC_UART4CLKSOURCE_HSI,
    RCC_UART4CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_PCLK1 => 0,
            .RCC_UART4CLKSOURCE_SYSCLK => 1,
            .RCC_UART4CLKSOURCE_HSI => 2,
            .RCC_UART4CLKSOURCE_LSE => 3,
        };
    }
};
pub const UART5CLockSelectionList = enum {
    RCC_UART5CLKSOURCE_PCLK1,
    RCC_UART5CLKSOURCE_SYSCLK,
    RCC_UART5CLKSOURCE_HSI,
    RCC_UART5CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART5CLKSOURCE_PCLK1 => 0,
            .RCC_UART5CLKSOURCE_SYSCLK => 1,
            .RCC_UART5CLKSOURCE_HSI => 2,
            .RCC_UART5CLKSOURCE_LSE => 3,
        };
    }
};
pub const UART7CLockSelectionList = enum {
    RCC_UART7CLKSOURCE_PCLK1,
    RCC_UART7CLKSOURCE_SYSCLK,
    RCC_UART7CLKSOURCE_HSI,
    RCC_UART7CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART7CLKSOURCE_PCLK1 => 0,
            .RCC_UART7CLKSOURCE_SYSCLK => 1,
            .RCC_UART7CLKSOURCE_HSI => 2,
            .RCC_UART7CLKSOURCE_LSE => 3,
        };
    }
};
pub const UART8CLockSelectionList = enum {
    RCC_UART8CLKSOURCE_PCLK1,
    RCC_UART8CLKSOURCE_SYSCLK,
    RCC_UART8CLKSOURCE_HSI,
    RCC_UART8CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART8CLKSOURCE_PCLK1 => 0,
            .RCC_UART8CLKSOURCE_SYSCLK => 1,
            .RCC_UART8CLKSOURCE_HSI => 2,
            .RCC_UART8CLKSOURCE_LSE => 3,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK => 0,
            .RCC_LPTIM1CLKSOURCE_LSI => 1,
            .RCC_LPTIM1CLKSOURCE_HSI => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
        };
    }
};
pub const CECClockSelectionList = enum {
    RCC_CECCLKSOURCE_HSI,
    RCC_CECCLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CECCLKSOURCE_HSI => 0,
            .RCC_CECCLKSOURCE_LSE => 1,
        };
    }
};
pub const RCC_RTC_Clock_Source_FROM_HSEList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV2,
    RCC_RTCCLKSOURCE_HSE_DIV3,
    RCC_RTCCLKSOURCE_HSE_DIV4,
    RCC_RTCCLKSOURCE_HSE_DIV5,
    RCC_RTCCLKSOURCE_HSE_DIV6,
    RCC_RTCCLKSOURCE_HSE_DIV7,
    RCC_RTCCLKSOURCE_HSE_DIV8,
    RCC_RTCCLKSOURCE_HSE_DIV9,
    RCC_RTCCLKSOURCE_HSE_DIV10,
    RCC_RTCCLKSOURCE_HSE_DIV11,
    RCC_RTCCLKSOURCE_HSE_DIV12,
    RCC_RTCCLKSOURCE_HSE_DIV13,
    RCC_RTCCLKSOURCE_HSE_DIV14,
    RCC_RTCCLKSOURCE_HSE_DIV15,
    RCC_RTCCLKSOURCE_HSE_DIV16,
    RCC_RTCCLKSOURCE_HSE_DIV17,
    RCC_RTCCLKSOURCE_HSE_DIV18,
    RCC_RTCCLKSOURCE_HSE_DIV19,
    RCC_RTCCLKSOURCE_HSE_DIV20,
    RCC_RTCCLKSOURCE_HSE_DIV21,
    RCC_RTCCLKSOURCE_HSE_DIV22,
    RCC_RTCCLKSOURCE_HSE_DIV23,
    RCC_RTCCLKSOURCE_HSE_DIV24,
    RCC_RTCCLKSOURCE_HSE_DIV25,
    RCC_RTCCLKSOURCE_HSE_DIV26,
    RCC_RTCCLKSOURCE_HSE_DIV27,
    RCC_RTCCLKSOURCE_HSE_DIV28,
    RCC_RTCCLKSOURCE_HSE_DIV29,
    RCC_RTCCLKSOURCE_HSE_DIV30,
    RCC_RTCCLKSOURCE_HSE_DIV31,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV2 => 2,
            .RCC_RTCCLKSOURCE_HSE_DIV3 => 3,
            .RCC_RTCCLKSOURCE_HSE_DIV4 => 4,
            .RCC_RTCCLKSOURCE_HSE_DIV5 => 5,
            .RCC_RTCCLKSOURCE_HSE_DIV6 => 6,
            .RCC_RTCCLKSOURCE_HSE_DIV7 => 7,
            .RCC_RTCCLKSOURCE_HSE_DIV8 => 8,
            .RCC_RTCCLKSOURCE_HSE_DIV9 => 9,
            .RCC_RTCCLKSOURCE_HSE_DIV10 => 10,
            .RCC_RTCCLKSOURCE_HSE_DIV11 => 11,
            .RCC_RTCCLKSOURCE_HSE_DIV12 => 12,
            .RCC_RTCCLKSOURCE_HSE_DIV13 => 13,
            .RCC_RTCCLKSOURCE_HSE_DIV14 => 14,
            .RCC_RTCCLKSOURCE_HSE_DIV15 => 15,
            .RCC_RTCCLKSOURCE_HSE_DIV16 => 16,
            .RCC_RTCCLKSOURCE_HSE_DIV17 => 17,
            .RCC_RTCCLKSOURCE_HSE_DIV18 => 18,
            .RCC_RTCCLKSOURCE_HSE_DIV19 => 19,
            .RCC_RTCCLKSOURCE_HSE_DIV20 => 20,
            .RCC_RTCCLKSOURCE_HSE_DIV21 => 21,
            .RCC_RTCCLKSOURCE_HSE_DIV22 => 22,
            .RCC_RTCCLKSOURCE_HSE_DIV23 => 23,
            .RCC_RTCCLKSOURCE_HSE_DIV24 => 24,
            .RCC_RTCCLKSOURCE_HSE_DIV25 => 25,
            .RCC_RTCCLKSOURCE_HSE_DIV26 => 26,
            .RCC_RTCCLKSOURCE_HSE_DIV27 => 27,
            .RCC_RTCCLKSOURCE_HSE_DIV28 => 28,
            .RCC_RTCCLKSOURCE_HSE_DIV29 => 29,
            .RCC_RTCCLKSOURCE_HSE_DIV30 => 30,
            .RCC_RTCCLKSOURCE_HSE_DIV31 => 31,
        };
    }
};
pub const RCC_MCODiv1List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
        };
    }
};
pub const RCC_MCODiv2List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
        };
    }
};
pub const AHBCLKDividerList = enum {
    RCC_SYSCLK_DIV1,
    RCC_SYSCLK_DIV2,
    RCC_SYSCLK_DIV4,
    RCC_SYSCLK_DIV8,
    RCC_SYSCLK_DIV16,
    RCC_SYSCLK_DIV64,
    RCC_SYSCLK_DIV128,
    RCC_SYSCLK_DIV256,
    RCC_SYSCLK_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_SYSCLK_DIV1 => 1,
            .RCC_SYSCLK_DIV2 => 2,
            .RCC_SYSCLK_DIV4 => 4,
            .RCC_SYSCLK_DIV8 => 8,
            .RCC_SYSCLK_DIV16 => 16,
            .RCC_SYSCLK_DIV64 => 64,
            .RCC_SYSCLK_DIV128 => 128,
            .RCC_SYSCLK_DIV256 => 256,
            .RCC_SYSCLK_DIV512 => 512,
        };
    }
};
pub const Cortex_DivList = enum {
    SYSTICK_CLKSOURCE_HCLK,
    SYSTICK_CLKSOURCE_HCLK_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .SYSTICK_CLKSOURCE_HCLK => 1,
            .SYSTICK_CLKSOURCE_HCLK_DIV8 => 8,
        };
    }
};
pub const APB1CLKDividerList = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV1 => 1,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV16 => 16,
        };
    }
};
pub const APB2CLKDividerList = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV1 => 1,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV16 => 16,
        };
    }
};
pub const PLLPList = enum {
    RCC_PLLP_DIV2,
    RCC_PLLP_DIV4,
    RCC_PLLP_DIV6,
    RCC_PLLP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV2 => 2,
            .RCC_PLLP_DIV4 => 4,
            .RCC_PLLP_DIV6 => 6,
            .RCC_PLLP_DIV8 => 8,
        };
    }
};
pub const PLLSAIPList = enum {
    RCC_PLLSAIP_DIV2,
    RCC_PLLSAIP_DIV4,
    RCC_PLLSAIP_DIV6,
    RCC_PLLSAIP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLSAIP_DIV2 => 2,
            .RCC_PLLSAIP_DIV4 => 4,
            .RCC_PLLSAIP_DIV6 => 6,
            .RCC_PLLSAIP_DIV8 => 8,
        };
    }
};
pub const PLLSAIRDivList = enum {
    RCC_PLLSAIDIVR_2,
    RCC_PLLSAIDIVR_4,
    RCC_PLLSAIDIVR_8,
    RCC_PLLSAIDIVR_16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLSAIDIVR_2 => 2,
            .RCC_PLLSAIDIVR_4 => 4,
            .RCC_PLLSAIDIVR_8 => 8,
            .RCC_PLLSAIDIVR_16 => 16,
        };
    }
};
pub const PLLI2SPList = enum {
    RCC_PLLP_DIV2,
    RCC_PLLP_DIV4,
    RCC_PLLP_DIV6,
    RCC_PLLP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV2 => 2,
            .RCC_PLLP_DIV4 => 4,
            .RCC_PLLP_DIV6 => 6,
            .RCC_PLLP_DIV8 => 8,
        };
    }
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
    FLASH_LATENCY_4,
    FLASH_LATENCY_5,
    FLASH_LATENCY_6,
    FLASH_LATENCY_7,
    FLASH_LATENCY_8,
    FLASH_LATENCY_9,
};
pub const RCC_TIM_PRescaler_SelectionList = enum {
    RCC_TIMPRES_ACTIVATED,
    RCC_TIMPRES_DESACTIVATED,
};
pub const PWREXT_OverDriveList = enum {
    PWREXT_OverDrive_ACTIVATED,
    PWREXT_OverDrive_DESACTIVATED,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE3,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const RTCEnableList = enum {
    true,
    false,
};
pub const LSIEnableList = enum {
    true,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const EnableHSERTCDevisorList = enum {
    true,
    false,
};
pub const IWDGEnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const I2C2EnableList = enum {
    true,
    false,
};
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const I2C4EnableList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const SDMMCEnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const LCDEnableList = enum {
    true,
    false,
};
pub const SPDIFEnableList = enum {
    true,
    false,
};
pub const SAI1EnableList = enum {
    true,
    false,
};
pub const SAI2EnableList = enum {
    true,
    false,
};
pub const I2SEnableList = enum {
    true,
    false,
};
pub const MCO1OutPutEnableList = enum {
    true,
    false,
};
pub const MCO2OutPutEnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const USART2EnableList = enum {
    true,
    false,
};
pub const USART3EnableList = enum {
    true,
    false,
};
pub const USART6EnableList = enum {
    true,
    false,
};
pub const UART4EnableList = enum {
    true,
    false,
};
pub const UART5EnableList = enum {
    true,
    false,
};
pub const UART7EnableList = enum {
    true,
    false,
};
pub const UART8EnableList = enum {
    true,
    false,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const CECEnableList = enum {
    true,
    false,
};
pub const MCO2I2SEnableList = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const EnableLSERTCList = enum {
    true,
    false,
};
pub const EnableLSEList = enum {
    true,
    false,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCO1Config: bool = false,
            MCO2Config: bool = false,
            AudioClockConfig: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            USB_OTG_HSEmbeddedPHYUsed_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            ETHUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            SAI1Used_ForRCC: bool = false,
            SAI2Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            LPTIMUsed_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null,
            PWREXT_OverDrive: ?PWREXT_OverDriveList = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            PLL48CLockSelection: ?PLL48CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            I2SCLockSelection: ?I2SCLockSelectionList = null,
            SDMMCClockSelection: ?SDMMCClockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART3CLockSelection: ?USART3CLockSelectionList = null,
            USART6CLockSelection: ?USART6CLockSelectionList = null,
            UART4CLockSelection: ?UART4CLockSelectionList = null,
            UART5CLockSelection: ?UART5CLockSelectionList = null,
            UART7CLockSelection: ?UART7CLockSelectionList = null,
            UART8CLockSelection: ?UART8CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            CECClockSelection: ?CECClockSelectionList = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?u32 = null,
            PLLSAIN: ?u32 = null,
            PLLSAIP: ?PLLSAIPList = null,
            PLLSAIQ: ?u32 = null,
            PLLSAIQDiv: ?u32 = null,
            PLLSAIR: ?u32 = null,
            PLLSAIRDiv: ?PLLSAIRDivList = null,
            PLLI2SN: ?u32 = null,
            PLLI2SP: ?PLLI2SPList = null,
            PLLI2SQ: ?u32 = null,
            PLLI2SQDiv: ?u32 = null,
            PLLI2SR: ?u32 = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            I2S_CKIN: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            I2C4Mult: f32 = 0,
            I2C4output: f32 = 0,
            PLL48Mult: f32 = 0,
            RNGoutput: f32 = 0,
            USBoutput: f32 = 0,
            LCDTFTKOutput: f32 = 0,
            SPDIFoutput: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
            I2SMult: f32 = 0,
            I2Soutput: f32 = 0,
            SDMMCMult: f32 = 0,
            SDMMCoutput: f32 = 0,
            EthernetPtpOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2output: f32 = 0,
            USART3Mult: f32 = 0,
            USART3output: f32 = 0,
            USART6Mult: f32 = 0,
            USART6output: f32 = 0,
            UART4Mult: f32 = 0,
            UART4output: f32 = 0,
            UART5Mult: f32 = 0,
            UART5output: f32 = 0,
            UART7Mult: f32 = 0,
            UART7output: f32 = 0,
            UART8Mult: f32 = 0,
            UART8output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1Output: f32 = 0,
            HSIDivCEC: f32 = 0,
            CECMult: f32 = 0,
            CECOutput: f32 = 0,
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLQ: f32 = 0,
            PLLQoutput: f32 = 0,
            PLLSAIN: f32 = 0,
            PLLSAIP: f32 = 0,
            PLLSAIoutput: f32 = 0,
            PLLSAIQ: f32 = 0,
            PLLSAIQDiv: f32 = 0,
            PLLSAIR: f32 = 0,
            PLLSAIRDiv: f32 = 0,
            PLLI2SN: f32 = 0,
            PLLI2SP: f32 = 0,
            PLLI2SQ: f32 = 0,
            PLLI2SQDiv: f32 = 0,
            PLLI2SR: f32 = 0,
            PLLI2SRoutput: f32 = 0,
            VCOInput: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            PLLQCLK: f32 = 0,
            VCOSAIOutput: f32 = 0,
            PLLSAIPCLK: f32 = 0,
            PLLSAIQCLK: f32 = 0,
            PLLSAIRCLK: f32 = 0,
            VCOI2SOutput: f32 = 0,
            PLLI2SPCLK: f32 = 0,
            PLLI2SQCLK: f32 = 0,
            PLLI2SRCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            PLL48CLockSelection: ?PLL48CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            I2SCLockSelection: ?I2SCLockSelectionList = null, //from RCC Clock Config
            SDMMCClockSelection: ?SDMMCClockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from RCC Clock Config
            USART3CLockSelection: ?USART3CLockSelectionList = null, //from RCC Clock Config
            USART6CLockSelection: ?USART6CLockSelectionList = null, //from RCC Clock Config
            UART4CLockSelection: ?UART4CLockSelectionList = null, //from RCC Clock Config
            UART5CLockSelection: ?UART5CLockSelectionList = null, //from RCC Clock Config
            UART7CLockSelection: ?UART7CLockSelectionList = null, //from RCC Clock Config
            UART8CLockSelection: ?UART8CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            HSI_Div_CEC: ?f32 = null, //from RCC Clock Config
            CECClockSelection: ?CECClockSelectionList = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLP: ?PLLPList = null, //from RCC Clock Config
            PLLQ: ?f32 = null, //from RCC Clock Config
            PLLSAIN: ?f32 = null, //from RCC Clock Config
            PLLSAIP: ?PLLSAIPList = null, //from RCC Clock Config
            PLLSAIQ: ?f32 = null, //from RCC Clock Config
            PLLSAIQDiv: ?f32 = null, //from RCC Clock Config
            PLLSAIR: ?f32 = null, //from RCC Clock Config
            PLLSAIRDiv: ?PLLSAIRDivList = null, //from RCC Clock Config
            PLLI2SN: ?f32 = null, //from RCC Clock Config
            PLLI2SP: ?PLLI2SPList = null, //from RCC Clock Config
            PLLI2SQ: ?f32 = null, //from RCC Clock Config
            PLLI2SQDiv: ?f32 = null, //from RCC Clock Config
            PLLI2SR: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null, //from RCC Advanced Config
            PWREXT_OverDrive: ?PWREXT_OverDriveList = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            PLLSAIUsed: ?f32 = null, //from extra RCC references
            PLLI2SUsed: ?f32 = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            I2C4Enable: ?I2C4EnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            SDMMCEnable: ?SDMMCEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            SPDIFEnable: ?SPDIFEnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            SAI2Enable: ?SAI2EnableList = null, //from extra RCC references
            I2SEnable: ?I2SEnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART3Enable: ?USART3EnableList = null, //from extra RCC references
            USART6Enable: ?USART6EnableList = null, //from extra RCC references
            UART4Enable: ?UART4EnableList = null, //from extra RCC references
            UART5Enable: ?UART5EnableList = null, //from extra RCC references
            UART7Enable: ?UART7EnableList = null, //from extra RCC references
            UART8Enable: ?UART8EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
            MCO2I2SEnable: ?MCO2I2SEnableList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            HSEUsed: ?f32 = null, //from extra RCC references
            LSIUsed: ?f32 = null, //from extra RCC references
        };

        pub const Tree_Output = struct {
            clock: Clock_Output,
            config: Config_Output,
        };

        fn check_MCU(comptime to_check: []const u8) bool {
            return mcu_data.get(to_check) != null;
        }
        pub fn get_clocks(config: Config) anyerror!Tree_Output {
            var out = Clock_Output{};
            var ref_out = Config_Output{};
            ref_out.flags = config.flags;

            //Semaphores flags

            var SysSourceIsHSI: bool = false;
            var SysSourceIsHSE: bool = false;
            var SysSourceIsPLLclk: bool = false;
            var I2C1SourcePCLK1: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C2SourcePCLK1: bool = false;
            var I2C2SourceSys: bool = false;
            var I2C2SourceHSI: bool = false;
            var I2C3SourcePCLK1: bool = false;
            var I2C3SourceSys: bool = false;
            var I2C3SourceHSI: bool = false;
            var I2C4SourcePCLK1: bool = false;
            var I2C4SourceSys: bool = false;
            var I2C4SourceHSI: bool = false;
            var USBSourceisPLL: bool = false;
            var USBSourceisPLLSAI: bool = false;
            var SAI1SourcePLLSAI: bool = false;
            var SAI1SourcePLLI2S: bool = false;
            var SAI1SourceEXT: bool = false;
            var SAI2SourcePLLSAI: bool = false;
            var SAI2SourcePLLI2S: bool = false;
            var SAI2SourceEXT: bool = false;
            var I2SSourceIsPLLI2SR: bool = false;
            var I2SSourceIsEXT: bool = false;
            var SDMMC1SourceCK48: bool = false;
            var SDMMC1SourceSys: bool = false;
            var MCOSourceIsPLLI2SP: bool = false;
            var USART1SourcePCLK2: bool = false;
            var USART1SourceSys: bool = false;
            var USART1SourceHSI: bool = false;
            var USART1SourceLSE: bool = false;
            var USART2SourcePCLK1: bool = false;
            var USART2SourceSys: bool = false;
            var USART2SourceHSI: bool = false;
            var USART2SourceLSE: bool = false;
            var USART3SourcePCLK1: bool = false;
            var USART3SourceSys: bool = false;
            var USART3SourceHSI: bool = false;
            var USART3SourceLSE: bool = false;
            var USART6SourcePCLK1: bool = false;
            var USART6SourceSys: bool = false;
            var USART6SourceHSI: bool = false;
            var USART6SourceLSE: bool = false;
            var UART4SourcePCLK1: bool = false;
            var UART4Sourcesys: bool = false;
            var UART4SourceHSI: bool = false;
            var UART4SourceLSE: bool = false;
            var UART5SourcePCLK1: bool = false;
            var UART5Sourcesys: bool = false;
            var UART5SourceHSI: bool = false;
            var UART5SourceLSE: bool = false;
            var UART7SourcePCLK1: bool = false;
            var UART7Sourcesys: bool = false;
            var UART7SourceHSI: bool = false;
            var UART7SourceLSE: bool = false;
            var UART8SourcePCLK1: bool = false;
            var UART8Sourcesys: bool = false;
            var UART8SourceHSI: bool = false;
            var UART8SourceLSE: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var CECSourceHSI: bool = false;
            var CECSourceLSE: bool = false;
            var HCLKDiv1: bool = false;
            var PLLI2SDiv2: bool = false;
            var PLLI2SDiv4: bool = false;
            var PLLI2SDiv6: bool = false;
            var PLLI2SDiv8: bool = false;
            var TimPrescalerEnabled: bool = false;
            var RTCFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var USBFreq_ValueLimit: Limit = .{};
            var LCDTFToutputFreq_ValueLimit: Limit = .{};
            var SPDIFRXFreq_ValueLimit: Limit = .{};
            var SDMMCFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var PLLQoutputFreq_ValueLimit: Limit = .{};
            var PLLSAIoutputFreq_ValueLimit: Limit = .{};
            var PLLI2SRoutputFreq_ValueLimit: Limit = .{};
            var VCOInputFreq_ValueLimit: Limit = .{};
            var VCOOutputFreq_ValueLimit: Limit = .{};
            var PLLCLKFreq_ValueLimit: Limit = .{};
            var PLLQCLKFreq_ValueLimit: Limit = .{};
            var VCOSAIOutputFreq_ValueLimit: Limit = .{};
            var PLLSAIPCLKFreq_ValueLimit: Limit = .{};
            var PLLSAIQCLKFreq_ValueLimit: Limit = .{};
            var PLLSAIRCLKFreq_ValueLimit: Limit = .{};
            var VCOI2SOutputFreq_ValueLimit: Limit = .{};
            var PLLI2SPCLKFreq_ValueLimit: Limit = .{};
            var PLLI2SQCLKFreq_ValueLimit: Limit = .{};
            var PLLI2SRCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass",
                                "HSEByPass",
                                1e6,
                                val,
                            });
                        }
                        if (val > 5e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass",
                                "HSEByPass",
                                5e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 25000000;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 4e6) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_VALUE",
                            "Else",
                            "No Extra Log",
                            4e6,
                            val,
                        });
                    }
                    if (val > 2.6e7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_VALUE",
                            "Else",
                            "No Extra Log",
                            2.6e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 25000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI_VALUE;
                if (config_val) |val| {
                    if (val < 1.7e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI_VALUE",
                            "Else",
                            "No Extra Log",
                            1.7e4,
                            val,
                        });
                    }
                    if (val > 4.7e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI_VALUE",
                            "Else",
                            "No Extra Log",
                            4.7e4,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32000;
            };
            const LSE_VALUEValue: ?f32 = blk: {
                if (config.flags.LSEOscillator) {
                    if (config.LSE_VALUE) |val| {
                        if (val != 3.2768e4) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {e} found: {e}
                                \\note: some values are fixed depending on the clock configuration.
                                \\
                                \\
                            , .{
                                "LSE_VALUE",
                                "LSEOscillator",
                                "LSE In crystal Mode",
                                3.2768e4,
                                val,
                            });
                        }
                    }
                    break :blk 3.2768e4;
                }
                const config_val = config.LSE_VALUE;
                if (config_val) |val| {
                    if (val < 0e0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSE_VALUE",
                            "Else",
                            "No Extra Log",
                            0e0,
                            val,
                        });
                    }
                    if (val > 1e6) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSE_VALUE",
                            "Else",
                            "No Extra Log",
                            1e6,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32768;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SysSourceIsHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceIsHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourceIsPLLclk = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceIsHSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if (((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC))) {
                    const item: PLLSourceList = .RCC_PLLSOURCE_HSE;
                    const conf_item = config.PLLSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PLLSource", "((USB_OTG_FSUsed_ForRCC|USB_OTG_HSEmbeddedPHYUsed_ForRCC)) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const PLLMValue: ?f32 = blk: {
                const config_val = config.PLLM;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 63) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?RCC_RTC_Clock_Source_FROM_HSEList = blk: {
                const conf_item = config.RCC_RTC_Clock_Source_FROM_HSE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_HSE_DIV2 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV3 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV4 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV5 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV6 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV7 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV8 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV9 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV10 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV11 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV12 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV13 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV14 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV15 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV16 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV17 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV18 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV19 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV20 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV21 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV22 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV23 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV24 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV25 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV26 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV27 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV28 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV29 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV30 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV31 => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_HSE_DIV2;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_LSE => {},
                        .RCC_RTCCLKSOURCE_LSI => {},
                        .HSERTCDevisor => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTCUsed_ForRCC) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")))) {
                    RTCFreq_ValueLimit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                break :blk 3.2e4;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => I2C1SourcePCLK1 = true,
                        .RCC_I2C1CLKSOURCE_SYSCLK => I2C1SourceSys = true,
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C1SourcePCLK1 = true;
                    break :blk .RCC_I2C1CLKSOURCE_PCLK1;
                };
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const I2C2CLockSelectionValue: ?I2C2CLockSelectionList = blk: {
                const conf_item = config.I2C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_PCLK1 => I2C2SourcePCLK1 = true,
                        .RCC_I2C2CLKSOURCE_SYSCLK => I2C2SourceSys = true,
                        .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C2SourcePCLK1 = true;
                    break :blk .RCC_I2C2CLKSOURCE_PCLK1;
                };
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK1 => I2C3SourcePCLK1 = true,
                        .RCC_I2C3CLKSOURCE_SYSCLK => I2C3SourceSys = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C3SourcePCLK1 = true;
                    break :blk .RCC_I2C3CLKSOURCE_PCLK1;
                };
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_PCLK1 => I2C4SourcePCLK1 = true,
                        .RCC_I2C4CLKSOURCE_SYSCLK => I2C4SourceSys = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C4SourcePCLK1 = true;
                    break :blk .RCC_I2C4CLKSOURCE_PCLK1;
                };
            };
            const I2C4Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const PLL48CLockSelectionValue: ?PLL48CLockSelectionList = blk: {
                const conf_item = config.PLL48CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLK48SOURCE_PLLSAIP => USBSourceisPLLSAI = true,
                        .RCC_CLK48SOURCE_PLL => USBSourceisPLL = true,
                    }
                }

                break :blk conf_item orelse {
                    USBSourceisPLL = true;
                    break :blk .RCC_CLK48SOURCE_PLL;
                };
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                RNGFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    USBFreq_ValueLimit = .{
                        .min = 4.788e7,
                        .max = 4.812e7,
                    };

                    break :blk null;
                }
                break :blk 4.8e7;
            };
            const LCDTFToutputFreq_ValueValue: ?f32 = blk: {
                LCDTFToutputFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.5e7,
                };

                break :blk null;
            };
            const SPDIFRXFreq_ValueValue: ?f32 = blk: {
                SPDIFRXFreq_ValueLimit = .{
                    .min = 5.632e6,
                    .max = null,
                };

                break :blk null;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLLSAI => SAI1SourcePLLSAI = true,
                        .RCC_SAI1CLKSOURCE_PLLI2S => SAI1SourcePLLI2S = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1SourcePLLSAI = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLLSAI;
                };
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                break :blk 2.4e7;
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLLSAI => SAI2SourcePLLSAI = true,
                        .RCC_SAI2CLKSOURCE_PLLI2S => SAI2SourcePLLI2S = true,
                        .RCC_SAI2CLKSOURCE_PIN => SAI2SourceEXT = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2SourcePLLSAI = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLLSAI;
                };
            };
            const SAI2Freq_ValueValue: ?f32 = blk: {
                break :blk 2.4e7;
            };
            const I2SCLockSelectionValue: ?I2SCLockSelectionList = blk: {
                const conf_item = config.I2SCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2SCLKSOURCE_EXT => I2SSourceIsEXT = true,
                        .RCC_I2SCLKSOURCE_PLLI2S => I2SSourceIsPLLI2SR = true,
                    }
                }

                break :blk conf_item orelse {
                    I2SSourceIsPLLI2SR = true;
                    break :blk .RCC_I2SCLKSOURCE_PLLI2S;
                };
            };
            const I2SFreq_ValueValue: ?f32 = blk: {
                break :blk 2.4e7;
            };
            const SDMMCClockSelectionValue: ?SDMMCClockSelectionList = blk: {
                const conf_item = config.SDMMCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC1CLKSOURCE_CLK48 => SDMMC1SourceCK48 = true,
                        .RCC_SDMMC1CLKSOURCE_SYSCLK => SDMMC1SourceSys = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1SourceSys = true;
                    break :blk .RCC_SDMMC1CLKSOURCE_SYSCLK;
                };
            };
            const SDMMCFreq_ValueValue: ?f32 = blk: {
                SDMMCFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };
            const EthernetFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_PLLCLK => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_HSI;
            };
            const RCC_MCODiv1Value: ?RCC_MCODiv1List = blk: {
                const conf_item = config.RCC_MCODiv1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCODIV_1 => {},
                        .RCC_MCODIV_2 => {},
                        .RCC_MCODIV_3 => {},
                        .RCC_MCODIV_4 => {},
                        .RCC_MCODIV_5 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_SYSCLK => {},
                        .RCC_MCO2SOURCE_PLLI2SCLK => MCOSourceIsPLLI2SP = true,
                        .RCC_MCO2SOURCE_HSE => {},
                        .RCC_MCO2SOURCE_PLLCLK => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO2SOURCE_SYSCLK;
            };
            const RCC_MCODiv2Value: ?RCC_MCODiv2List = blk: {
                const conf_item = config.RCC_MCODiv2;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCODIV_1 => {},
                        .RCC_MCODIV_2 => {},
                        .RCC_MCODIV_3 => {},
                        .RCC_MCODIV_4 => {},
                        .RCC_MCODIV_5 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const AHBCLKDividerValue: ?AHBCLKDividerList = blk: {
                const conf_item = config.AHBCLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLK_DIV1 => {},
                        .RCC_SYSCLK_DIV2 => {},
                        .RCC_SYSCLK_DIV4 => {},
                        .RCC_SYSCLK_DIV8 => {},
                        .RCC_SYSCLK_DIV16 => {},
                        .RCC_SYSCLK_DIV64 => {},
                        .RCC_SYSCLK_DIV128 => {},
                        .RCC_SYSCLK_DIV256 => {},
                        .RCC_SYSCLK_DIV512 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLK_DIV1;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    HCLKFreq_ValueLimit = .{
                        .min = 3e7,
                        .max = 2.16e8,
                    };

                    break :blk null;
                } else if (config.flags.ETHUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 2.5e7,
                        .max = 2.16e8,
                    };

                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 1.42e7,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.16e8,
                };

                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const Cortex_DivValue: ?Cortex_DivList = blk: {
                const conf_item = config.Cortex_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .SYSTICK_CLKSOURCE_HCLK => HCLKDiv1 = true,
                        .SYSTICK_CLKSOURCE_HCLK_DIV8 => {},
                    }
                }

                break :blk conf_item orelse {
                    HCLKDiv1 = true;
                    break :blk .SYSTICK_CLKSOURCE_HCLK;
                };
            };
            const CortexFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const APB1CLKDividerValue: ?APB1CLKDividerList = blk: {
                const conf_item = config.APB1CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => {},
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HCLK_DIV1;
            };
            const APB1Freq_ValueValue: ?f32 = blk: {
                if (config.flags.RTCUsed_ForRCC) {
                    const min: ?f32 = try math_op(@TypeOf(RTCFreq_ValueValue), RTCFreq_ValueValue, 4, .@"*", "APB1Freq_Value", "RTCFreq_Value", "4");
                    const max: ?f32 = @min(54000000, std.math.floatMax(f32));
                    APB1Freq_ValueLimit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value*4",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 5.4e7,
                };

                break :blk null;
            };
            const RCC_TIM_PRescaler_SelectionValue: ?RCC_TIM_PRescaler_SelectionList = blk: {
                const conf_item = config.extra.RCC_TIM_PRescaler_Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMPRES_ACTIVATED => TimPrescalerEnabled = true,
                        .RCC_TIMPRES_DESACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMPRES_DESACTIVATED;
            };
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV2, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV4, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const APB1TimFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const APB2CLKDividerValue: ?APB2CLKDividerList = blk: {
                const conf_item = config.APB2CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => {},
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HCLK_DIV1;
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.08e8,
                };

                break :blk null;
            };
            const APB2TimCLKDividerValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV2, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV4, .@"=")) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const APB2TimFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => USART1SourcePCLK2 = true,
                        .RCC_USART1CLKSOURCE_SYSCLK => USART1SourceSys = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART1SourcePCLK2 = true;
                    break :blk .RCC_USART1CLKSOURCE_PCLK2;
                };
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                const conf_item = config.USART2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK1 => USART2SourcePCLK1 = true,
                        .RCC_USART2CLKSOURCE_SYSCLK => USART2SourceSys = true,
                        .RCC_USART2CLKSOURCE_HSI => USART2SourceHSI = true,
                        .RCC_USART2CLKSOURCE_LSE => USART2SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART2SourcePCLK1 = true;
                    break :blk .RCC_USART2CLKSOURCE_PCLK1;
                };
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const USART3CLockSelectionValue: ?USART3CLockSelectionList = blk: {
                const conf_item = config.USART3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART3CLKSOURCE_PCLK1 => USART3SourcePCLK1 = true,
                        .RCC_USART3CLKSOURCE_SYSCLK => USART3SourceSys = true,
                        .RCC_USART3CLKSOURCE_HSI => USART3SourceHSI = true,
                        .RCC_USART3CLKSOURCE_LSE => USART3SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART3SourcePCLK1 = true;
                    break :blk .RCC_USART3CLKSOURCE_PCLK1;
                };
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const USART6CLockSelectionValue: ?USART6CLockSelectionList = blk: {
                const conf_item = config.USART6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART6CLKSOURCE_PCLK2 => USART6SourcePCLK1 = true,
                        .RCC_USART6CLKSOURCE_SYSCLK => USART6SourceSys = true,
                        .RCC_USART6CLKSOURCE_HSI => USART6SourceHSI = true,
                        .RCC_USART6CLKSOURCE_LSE => USART6SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART6SourcePCLK1 = true;
                    break :blk .RCC_USART6CLKSOURCE_PCLK2;
                };
            };
            const USART6Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const UART4CLockSelectionValue: ?UART4CLockSelectionList = blk: {
                const conf_item = config.UART4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => UART4SourcePCLK1 = true,
                        .RCC_UART4CLKSOURCE_SYSCLK => UART4Sourcesys = true,
                        .RCC_UART4CLKSOURCE_HSI => UART4SourceHSI = true,
                        .RCC_UART4CLKSOURCE_LSE => UART4SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    UART4SourcePCLK1 = true;
                    break :blk .RCC_UART4CLKSOURCE_PCLK1;
                };
            };
            const UART4Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const UART5CLockSelectionValue: ?UART5CLockSelectionList = blk: {
                const conf_item = config.UART5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => UART5SourcePCLK1 = true,
                        .RCC_UART5CLKSOURCE_SYSCLK => UART5Sourcesys = true,
                        .RCC_UART5CLKSOURCE_HSI => UART5SourceHSI = true,
                        .RCC_UART5CLKSOURCE_LSE => UART5SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    UART5SourcePCLK1 = true;
                    break :blk .RCC_UART5CLKSOURCE_PCLK1;
                };
            };
            const UART5Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const UART7CLockSelectionValue: ?UART7CLockSelectionList = blk: {
                const conf_item = config.UART7CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART7CLKSOURCE_PCLK1 => UART7SourcePCLK1 = true,
                        .RCC_UART7CLKSOURCE_SYSCLK => UART7Sourcesys = true,
                        .RCC_UART7CLKSOURCE_HSI => UART7SourceHSI = true,
                        .RCC_UART7CLKSOURCE_LSE => UART7SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    UART7SourcePCLK1 = true;
                    break :blk .RCC_UART7CLKSOURCE_PCLK1;
                };
            };
            const UART7Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const UART8CLockSelectionValue: ?UART8CLockSelectionList = blk: {
                const conf_item = config.UART8CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART8CLKSOURCE_PCLK1 => UART8SourcePCLK1 = true,
                        .RCC_UART8CLKSOURCE_SYSCLK => UART8Sourcesys = true,
                        .RCC_UART8CLKSOURCE_HSI => UART8SourceHSI = true,
                        .RCC_UART8CLKSOURCE_LSE => UART8SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    UART8SourcePCLK1 = true;
                    break :blk .RCC_UART8CLKSOURCE_PCLK1;
                };
            };
            const UART8Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK => {},
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSI_Div_CECValue: ?f32 = blk: {
                break :blk 488;
            };
            const CECClockSelectionValue: ?CECClockSelectionList = blk: {
                const conf_item = config.CECClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_HSI => CECSourceHSI = true,
                        .RCC_CECCLKSOURCE_LSE => CECSourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    CECSourceHSI = true;
                    break :blk .RCC_CECCLKSOURCE_HSI;
                };
            };
            const CECFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 50) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLN",
                            "Else",
                            "No Extra Log",
                            50,
                            val,
                        });
                    }
                    if (val > 432) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLN",
                            "Else",
                            "No Extra Log",
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLPValue: ?PLLPList = blk: {
                const conf_item = config.PLLP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV2 => {},
                        .RCC_PLLP_DIV4 => {},
                        .RCC_PLLP_DIV6 => {},
                        .RCC_PLLP_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLP_DIV2;
            };
            const PLLQValue: ?f32 = blk: {
                const config_val = config.PLLQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLQ",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 15) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLQoutputFreq_ValueValue: ?f32 = blk: {
                if ((USBSourceisPLL and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC and SDMMC1SourceCK48)))) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLSAINValue: ?f32 = blk: {
                const config_val = config.PLLSAIN;
                if (config_val) |val| {
                    if (val < 50) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIN",
                            "Else",
                            "No Extra Log",
                            50,
                            val,
                        });
                    }
                    if (val > 432) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIN",
                            "Else",
                            "No Extra Log",
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLSAIPValue: ?PLLSAIPList = blk: {
                const conf_item = config.PLLSAIP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAIP_DIV2 => {},
                        .RCC_PLLSAIP_DIV4 => {},
                        .RCC_PLLSAIP_DIV6 => {},
                        .RCC_PLLSAIP_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSAIP_DIV2;
            };
            const PLLSAIoutputFreq_ValueValue: ?f32 = blk: {
                if ((((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC or (SDMMC1SourceCK48 and config.flags.SDMMC1Used_ForRCC)) and USBSourceisPLLSAI))) {
                    PLLSAIoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLSAIQValue: ?f32 = blk: {
                const config_val = config.PLLSAIQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQ",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 15) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLSAIQDivValue: ?f32 = blk: {
                const config_val = config.PLLSAIQDiv;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQDiv",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 32) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQDiv",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLSAIRValue: ?f32 = blk: {
                const config_val = config.PLLSAIR;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIR",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIR",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLSAIRDivValue: ?PLLSAIRDivList = blk: {
                const conf_item = config.PLLSAIRDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAIDIVR_2 => {},
                        .RCC_PLLSAIDIVR_4 => {},
                        .RCC_PLLSAIDIVR_8 => {},
                        .RCC_PLLSAIDIVR_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSAIDIVR_2;
            };
            const PLLI2SNValue: ?f32 = blk: {
                const config_val = config.PLLI2SN;
                if (config_val) |val| {
                    if (val < 50) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SN",
                            "Else",
                            "No Extra Log",
                            50,
                            val,
                        });
                    }
                    if (val > 432) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SN",
                            "Else",
                            "No Extra Log",
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLI2SPValue: ?PLLI2SPList = blk: {
                const conf_item = config.PLLI2SP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV2 => PLLI2SDiv2 = true,
                        .RCC_PLLP_DIV4 => PLLI2SDiv4 = true,
                        .RCC_PLLP_DIV6 => PLLI2SDiv6 = true,
                        .RCC_PLLP_DIV8 => PLLI2SDiv8 = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLI2SDiv2 = true;
                    break :blk .RCC_PLLP_DIV2;
                };
            };
            const PLLI2SQValue: ?f32 = blk: {
                const config_val = config.PLLI2SQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQ",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 15) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLI2SQDivValue: ?f32 = blk: {
                const config_val = config.PLLI2SQDiv;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQDiv",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 32) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQDiv",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLI2SRValue: ?f32 = blk: {
                const config_val = config.PLLI2SR;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SR",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SR",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLI2SRoutputFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or (I2SSourceIsPLLI2SR and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC))) {
                    PLLI2SRoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLUsedValue: ?f32 = blk: {
                if ((SysSourceIsPLLclk) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and (config.flags.MCO1Config or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MCO1_REQUIRED_TIM11")))) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (USBSourceisPLL and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC and SDMMC1SourceCK48)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLSAIUsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or ((SAI1SourcePLLSAI and (config.flags.SAI1Used_ForRCC)) or (SAI2SourcePLLSAI and config.flags.SAI2Used_ForRCC)) or (((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC or (SDMMC1SourceCK48 and config.flags.SDMMC1Used_ForRCC)) and USBSourceisPLLSAI))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLI2SUsedValue: ?f32 = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or ((SAI1SourcePLLI2S and (config.flags.SAI1Used_ForRCC)) or (SAI2SourcePLLI2S and config.flags.SAI2Used_ForRCC)) or (I2SSourceIsPLLI2SR and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or config.flags.SPDIFRXUsed_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAIUsedValue), PLLSAIUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"=")) {
                    VCOInputFreq_ValueLimit = .{
                        .min = 9.5e5,
                        .max = 2.1e6,
                    };

                    break :blk null;
                }
                break :blk 1e6;
            };
            const VCOOutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLCLKFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 2.4e7,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLQCLKFreq_ValueValue: ?f32 = blk: {
                if ((USBSourceisPLL and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC and SDMMC1SourceCK48)))) {
                    PLLQCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCOSAIOutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLSAIUsedValue), PLLSAIUsedValue, 1, .@"=")) {
                    VCOSAIOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLSAIPCLKFreq_ValueValue: ?f32 = blk: {
                if ((((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC or (SDMMC1SourceCK48 and config.flags.SDMMC1Used_ForRCC)) and USBSourceisPLLSAI))) {
                    PLLSAIPCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLSAIQCLKFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI and (config.flags.SAI1Used_ForRCC)) or (SAI2SourcePLLSAI and config.flags.SAI2Used_ForRCC))) {
                    PLLSAIQCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLSAIRCLKFreq_ValueValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    PLLSAIRCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const VCOI2SOutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"=")) {
                    VCOI2SOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLI2SPCLKFreq_ValueValue: ?f32 = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC) {
                    PLLI2SPCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLI2SQCLKFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLI2S and (config.flags.SAI1Used_ForRCC)) or (SAI2SourcePLLI2S and config.flags.SAI2Used_ForRCC))) {
                    PLLI2SQCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLI2SRCLKFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or (I2SSourceIsPLLI2SR and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC))) {
                    PLLI2SRCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@">")))) {
                    const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE1;
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value > 180000000))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(@TypeOf(PWREXT_OverDriveValue), PWREXT_OverDriveValue, .PWREXT_OverDrive_DESACTIVATED, .@"=")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">"))))) {
                    const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE1;
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWR_Regulator_Voltage_Scale", "((PWREXT_OverDrive=PWREXT_OverDrive_DESACTIVATED)&((HCLKFreq_Value > 168000000)))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value > 144000000)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                }
                const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                if (conf_item) |item| {
                    switch (item) {
                        .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                    }
                }

                break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE3;
            };
            const PWREXT_OverDriveValue: ?PWREXT_OverDriveList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@">")) or (check_ref(@TypeOf(APB1Freq_ValueValue), APB1Freq_ValueValue, 45000000, .@">")) or (check_ref(@TypeOf(APB2Freq_ValueValue), APB2Freq_ValueValue, 90000000, .@">"))) {
                    const item: PWREXT_OverDriveList = .PWREXT_OverDrive_ACTIVATED;
                    const conf_item = config.extra.PWREXT_OverDrive;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWREXT_OverDrive", "(HCLKFreq_Value > 180000000)|(APB1Freq_Value > 45000000)|(APB2Freq_Value > 90000000) ", "No Extra Log", "PWREXT_OverDrive_ACTIVATED", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.7, .@">")) and (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")))) {
                    const item: PWREXT_OverDriveList = .PWREXT_OverDrive_DESACTIVATED;
                    const conf_item = config.extra.PWREXT_OverDrive;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWREXT_OverDrive", "((VDD_VALUE>1.7)&(VDD_VALUE<2.1))", "No Extra Log", "PWREXT_OverDrive_DESACTIVATED", i });
                        }
                    }
                    break :blk item;
                } else if (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")) {
                    const item: PWREXT_OverDriveList = .PWREXT_OverDrive_DESACTIVATED;
                    const conf_item = config.extra.PWREXT_OverDrive;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWREXT_OverDrive", "PWR_Regulator_Voltage_Scale = PWR_REGULATOR_VOLTAGE_SCALE3", "No Extra Log", "PWREXT_OverDrive_DESACTIVATED", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.PWREXT_OverDrive;
                if (conf_item) |item| {
                    switch (item) {
                        .PWREXT_OverDrive_DESACTIVATED => {},
                        .PWREXT_OverDrive_ACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .PWREXT_OverDrive_DESACTIVATED;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PWREXT_OverDriveValue), PWREXT_OverDriveValue, .PWREXT_OverDrive_ACTIVATED, .@"="))) {
                    const config_val = config.extra.VDD_VALUE;
                    if (config_val) |val| {
                        if (val < 2.1e0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VDD_VALUE",
                                "(PWREXT_OverDrive=PWREXT_OverDrive_ACTIVATED) ",
                                "No Extra Log",
                                2.1e0,
                                val,
                            });
                        }
                        if (val > 3.6e0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VDD_VALUE",
                                "(PWREXT_OverDrive=PWREXT_OverDrive_ACTIVATED) ",
                                "No Extra Log",
                                3.6e0,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 3.3;
                }
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.8e0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "VDD_VALUE",
                            "Else",
                            "No Extra Log",
                            1.8e0,
                            val,
                        });
                    }
                    if (val > 3.6e0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "VDD_VALUE",
                            "Else",
                            "No Extra Log",
                            3.6e0,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 3.3;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) &  ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 30000000)|(HCLKFreq_Value =30000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 24000000)|(HCLKFreq_Value =24000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 22000000)|(HCLKFreq_Value= 22000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8))   & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 20000000)|(HCLKFreq_Value =20000000))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7))  & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 ))) & ((HCLKFreq_Value > 30000000) &  ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 ))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 24000000) &  ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value= 48000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 ))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 22000000) &  ((HCLKFreq_Value < 44000000)|(HCLKFreq_Value =44000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  ))  & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 20000000) &  ((HCLKFreq_Value < 40000000)|(HCLKFreq_Value=40000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7 )) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 ))) & ((HCLKFreq_Value > 60000000) & ((HCLKFreq_Value < 90000000)|(HCLKFreq_Value = 90000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4  ))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 48000000) & ((HCLKFreq_Value < 72000000)|(HCLKFreq_Value = 72000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1  ))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 44000000) & ((HCLKFreq_Value < 66000000)|(HCLKFreq_Value= 66000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8   ))   &((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 40000000) & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 )))&  ((HCLKFreq_Value > 90000000) & ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 72000000) & ((HCLKFreq_Value < 96000000)|(HCLKFreq_Value=   96000000 ))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 66000000) & ((HCLKFreq_Value < 88000000)|(HCLKFreq_Value =  88000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 60000000) & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value= 80000000   ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6  ))) & ((HCLKFreq_Value > 120000000) &  ((HCLKFreq_Value < 150000000)|(HCLKFreq_Value= 150000000 ))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) &  ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7 ))) & ((HCLKFreq_Value > 96000000) &   ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) &  ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4 ))) & ((HCLKFreq_Value > 88000000) &   ((HCLKFreq_Value < 110000000)|(HCLKFreq_Value= 110000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1 ))) & ((HCLKFreq_Value > 80000000) &   ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value =100000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_5;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6  ))) & ((HCLKFreq_Value > 150000000) &  ((HCLKFreq_Value < 180000000)|(HCLKFreq_Value= 180000000 ))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) &   ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7 ))) & ((HCLKFreq_Value > 120000000) & ((HCLKFreq_Value < 144000000)|(HCLKFreq_Value =144000000  ))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) &   ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4 ))) & ((HCLKFreq_Value > 110000000) & ((HCLKFreq_Value < 132000000)|(HCLKFreq_Value = 132000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) &    ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 100000000) & ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_5", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 210000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 210000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_6;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) &  ((HCLKFreq_Value > 180000000) &  ((HCLKFreq_Value < 210000000)|(HCLKFreq_Value= 210000000 ))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 144000000) & ((HCLKFreq_Value < 168000000)|(HCLKFreq_Value = 168000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 132000000) & ((HCLKFreq_Value < 154000000)|(HCLKFreq_Value = 154000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 120000000) & ((HCLKFreq_Value < 140000000)|(HCLKFreq_Value = 140000000))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_6", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 210000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 192000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 192000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_7;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) &  ((HCLKFreq_Value > 210000000) & ((HCLKFreq_Value < 216000000)|(HCLKFreq_Value = 216000000 ))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 168000000) & ((HCLKFreq_Value < 192000000)|(HCLKFreq_Value = 192000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 154000000) & ((HCLKFreq_Value < 176000000)|(HCLKFreq_Value = 176000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 140000000) & ((HCLKFreq_Value < 160000000)|(HCLKFreq_Value = 160000000))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_7", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 192000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 198000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 198000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 180000000, .@"="))))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_8;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 192000000) & ((HCLKFreq_Value < 216000000)|(HCLKFreq_Value = 216000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 176000000)& ((HCLKFreq_Value < 198000000)|(HCLKFreq_Value = 198000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 160000000) & ((HCLKFreq_Value < 180000000)|(HCLKFreq_Value = 180000000))))ªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_8", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 198000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 216000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_9;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 198000000)& ((HCLKFreq_Value < 216000000)|(HCLKFreq_Value = 216000000))))ªªªª", "No Extra Log", "FLASH_LATENCY_9", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.FLatency;
                if (conf_item) |item| {
                    switch (item) {
                        .FLASH_LATENCY_0 => {},
                        .FLASH_LATENCY_1 => {},
                        .FLASH_LATENCY_2 => {},
                        .FLASH_LATENCY_3 => {},
                        .FLASH_LATENCY_4 => {},
                        .FLASH_LATENCY_5 => {},
                        .FLASH_LATENCY_6 => {},
                        .FLASH_LATENCY_7 => {},
                        .FLASH_LATENCY_8 => {},
                        .FLASH_LATENCY_9 => {},
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((USART1SourceHSI and config.flags.USART1Used_ForRCC) or (USART2SourceHSI and config.flags.USART2Used_ForRCC) or (USART3SourceHSI and config.flags.USART3Used_ForRCC) or (USART6SourceHSI and config.flags.USART6Used_ForRCC) or (UART4SourceHSI and config.flags.UART4Used_ForRCC) or (UART5SourceHSI and config.flags.UART5Used_ForRCC) or (UART7SourceHSI and config.flags.UART7Used_ForRCC) or (UART8SourceHSI and config.flags.UART8Used_ForRCC) or (LPTIM1SOURCEHSI and config.flags.LPTIMUsed_ForRCC) or (I2C1SourceHSI and config.flags.I2C1Used_ForRCC) or (I2C2SourceHSI and config.flags.I2C2Used_ForRCC) or (I2C3SourceHSI and config.flags.I2C3Used_ForRCC) or (I2C4SourceHSI and config.flags.I2C4Used_ForRCC) or (CECSourceHSI and config.flags.CECUsed_ForRCC) or ((check_MCU("PLLSourceHSI")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAIUsedValue), PLLSAIUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and (((config.flags.MCO1Config or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MCO1_REQUIRED_TIM11"))))))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(HSIUsedValue), HSIUsedValue, 1, .@"=")) {
                    const config_val = config.extra.HSICalibrationValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSICalibrationValue",
                                "HSIUsed=1",
                                "HSI used",
                                0,
                                val,
                            });
                        }
                        if (val > 31) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSICalibrationValue",
                                "HSIUsed=1",
                                "HSI used",
                                31,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
                }
                const config_val = config.extra.HSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 31) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            31,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const HSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.HSE_Timout;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_Timout",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 1073741823) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_Timout",
                            "Else",
                            "No Extra Log",
                            1073741823,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 100;
            };
            const LSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.LSE_Timout;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSE_Timout",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 1073741823) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSE_Timout",
                            "Else",
                            "No Extra Log",
                            1073741823,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 5000;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSE_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or (CECSourceLSE and config.flags.CECUsed_ForRCC) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (USART2SourceLSE and config.flags.USART2Used_ForRCC) or (USART3SourceLSE and config.flags.USART3Used_ForRCC) or (USART6SourceLSE and config.flags.USART6Used_ForRCC) or (UART4SourceLSE and config.flags.UART4Used_ForRCC) or (UART5SourceLSE and config.flags.UART5Used_ForRCC) or (UART7SourceLSE and config.flags.UART7Used_ForRCC) or (UART8SourceLSE and config.flags.UART8Used_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIMUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and (config.flags.MCO1Config or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MCO1_REQUIRED_TIM11")))) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSE_Drive_CapabilityValue: ?LSE_Drive_CapabilityList = blk: {
                if (config.flags.LSEOscillator and (check_ref(@TypeOf(LSEUsedValue), LSEUsedValue, 1, .@"="))) {
                    const conf_item = config.extra.LSE_Drive_Capability;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LSEDRIVE_LOW => {},
                            .RCC_LSEDRIVE_MEDIUMLOW => {},
                            .RCC_LSEDRIVE_MEDIUMHIGH => {},
                            .RCC_LSEDRIVE_HIGH => {},
                        }
                    }

                    break :blk conf_item orelse null;
                }
                if (config.extra.LSE_Drive_Capability) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "LSE_Drive_Capability", "Else", "No Extra Log" });
                }
                break :blk null;
            };
            const LSIEnableValue: ?LSIEnableList = blk: {
                const item: LSIEnableList = .true;
                break :blk item;
            };
            const ExtClockEnableValue: ?ExtClockEnableList = blk: {
                if (config.flags.AudioClockConfig) {
                    const item: ExtClockEnableList = .true;
                    break :blk item;
                }
                const item: ExtClockEnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDGUsed_ForRCC) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1Used_ForRCC) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
                break :blk item;
            };
            const I2C2EnableValue: ?I2C2EnableList = blk: {
                if (config.flags.I2C2Used_ForRCC) {
                    const item: I2C2EnableList = .true;
                    break :blk item;
                }
                const item: I2C2EnableList = .false;
                break :blk item;
            };
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3Used_ForRCC) {
                    const item: I2C3EnableList = .true;
                    break :blk item;
                }
                const item: I2C3EnableList = .false;
                break :blk item;
            };
            const I2C4EnableValue: ?I2C4EnableList = blk: {
                if (config.flags.I2C4Used_ForRCC) {
                    const item: I2C4EnableList = .true;
                    break :blk item;
                }
                const item: I2C4EnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const SDMMCEnableValue: ?SDMMCEnableList = blk: {
                if (config.flags.SDMMC1Used_ForRCC) {
                    const item: SDMMCEnableList = .true;
                    break :blk item;
                }
                const item: SDMMCEnableList = .false;
                break :blk item;
            };
            const RNGEnableValue: ?RNGEnableList = blk: {
                if (config.flags.RNGUsed_ForRCC) {
                    const item: RNGEnableList = .true;
                    break :blk item;
                }
                const item: RNGEnableList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const SPDIFEnableValue: ?SPDIFEnableList = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC) {
                    const item: SPDIFEnableList = .true;
                    break :blk item;
                }
                const item: SPDIFEnableList = .false;
                break :blk item;
            };
            const SAI1EnableValue: ?SAI1EnableList = blk: {
                if ((config.flags.SAI1Used_ForRCC)) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                }
                const item: SAI1EnableList = .false;
                break :blk item;
            };
            const SAI2EnableValue: ?SAI2EnableList = blk: {
                if (config.flags.SAI2Used_ForRCC) {
                    const item: SAI2EnableList = .true;
                    break :blk item;
                }
                const item: SAI2EnableList = .false;
                break :blk item;
            };
            const I2SEnableValue: ?I2SEnableList = blk: {
                if (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) {
                    const item: I2SEnableList = .true;
                    break :blk item;
                }
                const item: I2SEnableList = .false;
                break :blk item;
            };
            const MCO1OutPutEnableValue: ?MCO1OutPutEnableList = blk: {
                if (config.flags.MCO1Config or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MCO1_REQUIRED_TIM11"))) {
                    const item: MCO1OutPutEnableList = .true;
                    break :blk item;
                }
                const item: MCO1OutPutEnableList = .false;
                break :blk item;
            };
            const MCO2OutPutEnableValue: ?MCO2OutPutEnableList = blk: {
                if (config.flags.MCO2Config) {
                    const item: MCO2OutPutEnableList = .true;
                    break :blk item;
                }
                const item: MCO2OutPutEnableList = .false;
                break :blk item;
            };
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1Used_ForRCC) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const USART2EnableValue: ?USART2EnableList = blk: {
                if (config.flags.USART2Used_ForRCC) {
                    const item: USART2EnableList = .true;
                    break :blk item;
                }
                const item: USART2EnableList = .false;
                break :blk item;
            };
            const USART3EnableValue: ?USART3EnableList = blk: {
                if (config.flags.USART3Used_ForRCC) {
                    const item: USART3EnableList = .true;
                    break :blk item;
                }
                const item: USART3EnableList = .false;
                break :blk item;
            };
            const USART6EnableValue: ?USART6EnableList = blk: {
                if (config.flags.USART6Used_ForRCC) {
                    const item: USART6EnableList = .true;
                    break :blk item;
                }
                const item: USART6EnableList = .false;
                break :blk item;
            };
            const UART4EnableValue: ?UART4EnableList = blk: {
                if (config.flags.UART4Used_ForRCC) {
                    const item: UART4EnableList = .true;
                    break :blk item;
                }
                const item: UART4EnableList = .false;
                break :blk item;
            };
            const UART5EnableValue: ?UART5EnableList = blk: {
                if (config.flags.UART5Used_ForRCC) {
                    const item: UART5EnableList = .true;
                    break :blk item;
                }
                const item: UART5EnableList = .false;
                break :blk item;
            };
            const UART7EnableValue: ?UART7EnableList = blk: {
                if (config.flags.UART7Used_ForRCC) {
                    const item: UART7EnableList = .true;
                    break :blk item;
                }
                const item: UART7EnableList = .false;
                break :blk item;
            };
            const UART8EnableValue: ?UART8EnableList = blk: {
                if (config.flags.UART8Used_ForRCC) {
                    const item: UART8EnableList = .true;
                    break :blk item;
                }
                const item: UART8EnableList = .false;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIMUsed_ForRCC) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const CECEnableValue: ?CECEnableList = blk: {
                if (config.flags.CECUsed_ForRCC) {
                    const item: CECEnableList = .true;
                    break :blk item;
                }
                const item: CECEnableList = .false;
                break :blk item;
            };
            const MCO2I2SEnableValue: ?MCO2I2SEnableList = blk: {
                if ((config.flags.MCO2Config)) {
                    const item: MCO2I2SEnableList = .true;
                    break :blk item;
                }
                const item: MCO2I2SEnableList = .false;
                break :blk item;
            };
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
                break :blk item;
            };
            const EnableLSEValue: ?EnableLSEList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: EnableLSEList = .true;
                    break :blk item;
                }
                const item: EnableLSEList = .false;
                break :blk item;
            };
            const HSEUsedValue: ?f32 = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11"))) or ((config.flags.RTCUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_MCU("PLLSourceHSE")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAIUsedValue), PLLSAIUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and ((config.flags.MCO1Config or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MCO1_REQUIRED_TIM11"))))) or (((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_HSE, .@"=")) or (MCOSourceIsPLLI2SP and (check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")))) and (config.flags.MCO2Config))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSI_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or (LPTIM1SOURCELSI and config.flags.LPTIMUsed_ForRCC) or (config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEOSC = ClockNode{
                .name = "HSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIRC = ClockNode{
                .name = "LSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSEOSC = ClockNode{
                .name = "LSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var SysClkSource = ClockNode{
                .name = "SysClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var SysCLKOutput = ClockNode{
                .name = "SysCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM = ClockNode{
                .name = "PLLM",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSERTCDevisor = ClockNode{
                .name = "HSERTCDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var RTCClkSource = ClockNode{
                .name = "RTCClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var RTCOutput = ClockNode{
                .name = "RTCOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var IWDGOutput = ClockNode{
                .name = "IWDGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C1Mult = ClockNode{
                .name = "I2C1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C1output = ClockNode{
                .name = "I2C1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C2Mult = ClockNode{
                .name = "I2C2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C2output = ClockNode{
                .name = "I2C2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3Mult = ClockNode{
                .name = "I2C3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3output = ClockNode{
                .name = "I2C3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C4Mult = ClockNode{
                .name = "I2C4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C4output = ClockNode{
                .name = "I2C4output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL48Mult = ClockNode{
                .name = "PLL48Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGoutput = ClockNode{
                .name = "RNGoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBoutput = ClockNode{
                .name = "USBoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var LCDTFTKOutput = ClockNode{
                .name = "LCDTFTKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPDIFoutput = ClockNode{
                .name = "SPDIFoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1Mult = ClockNode{
                .name = "SAI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1output = ClockNode{
                .name = "SAI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2Mult = ClockNode{
                .name = "SAI2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2output = ClockNode{
                .name = "SAI2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2SMult = ClockNode{
                .name = "I2SMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2Soutput = ClockNode{
                .name = "I2Soutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMCMult = ClockNode{
                .name = "SDMMCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMCoutput = ClockNode{
                .name = "SDMMCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var EthernetPtpOutput = ClockNode{
                .name = "EthernetPtpOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO1Mult = ClockNode{
                .name = "MCO1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO1Div = ClockNode{
                .name = "MCO1Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO1Pin = ClockNode{
                .name = "MCO1Pin",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO2Mult = ClockNode{
                .name = "MCO2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO2Div = ClockNode{
                .name = "MCO2Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCO2Pin = ClockNode{
                .name = "MCO2Pin",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBPrescaler = ClockNode{
                .name = "AHBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBOutput = ClockNode{
                .name = "AHBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLKOutput = ClockNode{
                .name = "HCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CortexPrescaler = ClockNode{
                .name = "CortexPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var CortexSysOutput = ClockNode{
                .name = "CortexSysOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var FCLKCortexOutput = ClockNode{
                .name = "FCLKCortexOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1Prescaler = ClockNode{
                .name = "APB1Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1Output = ClockNode{
                .name = "APB1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescalerAPB1 = ClockNode{
                .name = "TimPrescalerAPB1",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescOut1 = ClockNode{
                .name = "TimPrescOut1",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB2Prescaler = ClockNode{
                .name = "APB2Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB2Output = ClockNode{
                .name = "APB2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescalerAPB2 = ClockNode{
                .name = "TimPrescalerAPB2",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescOut2 = ClockNode{
                .name = "TimPrescOut2",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART1Mult = ClockNode{
                .name = "USART1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART1output = ClockNode{
                .name = "USART1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART2Mult = ClockNode{
                .name = "USART2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART2output = ClockNode{
                .name = "USART2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART3Mult = ClockNode{
                .name = "USART3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART3output = ClockNode{
                .name = "USART3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART6Mult = ClockNode{
                .name = "USART6Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART6output = ClockNode{
                .name = "USART6output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART4Mult = ClockNode{
                .name = "UART4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART4output = ClockNode{
                .name = "UART4output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART5Mult = ClockNode{
                .name = "UART5Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART5output = ClockNode{
                .name = "UART5output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART7Mult = ClockNode{
                .name = "UART7Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART7output = ClockNode{
                .name = "UART7output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART8Mult = ClockNode{
                .name = "UART8Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART8output = ClockNode{
                .name = "UART8output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1Mult = ClockNode{
                .name = "LPTIM1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1Output = ClockNode{
                .name = "LPTIM1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIDivCEC = ClockNode{
                .name = "HSIDivCEC",
                .nodetype = .off,
                .parents = &.{},
            };

            var CECMult = ClockNode{
                .name = "CECMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CECOutput = ClockNode{
                .name = "CECOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLN = ClockNode{
                .name = "PLLN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLP = ClockNode{
                .name = "PLLP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQ = ClockNode{
                .name = "PLLQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQoutput = ClockNode{
                .name = "PLLQoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIN = ClockNode{
                .name = "PLLSAIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIP = ClockNode{
                .name = "PLLSAIP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIoutput = ClockNode{
                .name = "PLLSAIoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQ = ClockNode{
                .name = "PLLSAIQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQDiv = ClockNode{
                .name = "PLLSAIQDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIR = ClockNode{
                .name = "PLLSAIR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIRDiv = ClockNode{
                .name = "PLLSAIRDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SN = ClockNode{
                .name = "PLLI2SN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SP = ClockNode{
                .name = "PLLI2SP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQ = ClockNode{
                .name = "PLLI2SQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQDiv = ClockNode{
                .name = "PLLI2SQDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SR = ClockNode{
                .name = "PLLI2SR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SRoutput = ClockNode{
                .name = "PLLI2SRoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput = ClockNode{
                .name = "VCOInput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOOutput = ClockNode{
                .name = "VCOOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLCLK = ClockNode{
                .name = "PLLCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQCLK = ClockNode{
                .name = "PLLQCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOSAIOutput = ClockNode{
                .name = "VCOSAIOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIPCLK = ClockNode{
                .name = "PLLSAIPCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQCLK = ClockNode{
                .name = "PLLSAIQCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIRCLK = ClockNode{
                .name = "PLLSAIRCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOI2SOutput = ClockNode{
                .name = "VCOI2SOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SPCLK = ClockNode{
                .name = "PLLI2SPCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQCLK = ClockNode{
                .name = "PLLI2SQCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SRCLK = ClockNode{
                .name = "PLLI2SRCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            const HSIRC_clk_value = HSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIRC",
                "Else",
                "No Extra Log",
                "HSI_VALUE",
            });
            HSIRC.nodetype = .source;
            HSIRC.value = HSIRC_clk_value;

            const HSEOSC_clk_value = HSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSEOSC",
                "Else",
                "No Extra Log",
                "HSE_VALUE",
            });
            HSEOSC.nodetype = .source;
            HSEOSC.value = HSEOSC_clk_value;
            if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIRC",
                    "Else",
                    "No Extra Log",
                    "LSI_VALUE",
                });
                LSIRC.nodetype = .source;
                LSIRC.value = LSIRC_clk_value;
            }

            const LSEOSC_clk_value = LSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "LSEOSC",
                "Else",
                "No Extra Log",
                "LSE_VALUE",
            });
            LSEOSC.nodetype = .source;
            LSEOSC.value = LSEOSC_clk_value;
            if (check_ref(@TypeOf(ExtClockEnableValue), ExtClockEnableValue, .true, .@"=")) {
                const I2S_CKIN_clk_value = EXTERNAL_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2S_CKIN",
                    "Else",
                    "No Extra Log",
                    "EXTERNAL_CLOCK_VALUE",
                });
                I2S_CKIN.nodetype = .source;
                I2S_CKIN.value = I2S_CKIN_clk_value;
            }

            const SysClkSource_clk_value = SYSCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SysClkSource",
                "Else",
                "No Extra Log",
                "SYSCLKSource",
            });
            const SysClkSourceparents = [_]*const ClockNode{
                &HSIRC,
                &HSEOSC,
                &PLLP,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};

            const PLLSource_clk_value = PLLSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSource",
                "Else",
                "No Extra Log",
                "PLLSource",
            });
            const PLLSourceparents = [_]*const ClockNode{
                &HSIRC,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            const PLLM_clk_value = PLLMValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLM",
                "Else",
                "No Extra Log",
                "PLLM",
            });
            PLLM.nodetype = .div;
            PLLM.value = PLLM_clk_value;
            PLLM.parents = &.{&PLLSource};
            if (check_ref(@TypeOf(EnableHSERTCDevisorValue), EnableHSERTCDevisorValue, .true, .@"=")) {
                const HSERTCDevisor_clk_value = RCC_RTC_Clock_Source_FROM_HSEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSERTCDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_RTC_Clock_Source_FROM_HSE",
                });
                HSERTCDevisor.nodetype = .div;
                HSERTCDevisor.value = HSERTCDevisor_clk_value.get();
                HSERTCDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                const RTCClkSource_clk_value = RTCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RTCClkSource",
                    "Else",
                    "No Extra Log",
                    "RTCClockSelection",
                });
                const RTCClkSourceparents = [_]*const ClockNode{
                    &HSERTCDevisor,
                    &LSEOSC,
                    &LSIRC,
                };
                RTCClkSource.nodetype = .multi;
                RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RTCFreq_ValueValue);
                RTCOutput.limit = RTCFreq_ValueLimit;
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                const I2C1Mult_clk_value = I2C1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C1Mult",
                    "Else",
                    "No Extra Log",
                    "I2C1CLockSelection",
                });
                const I2C1Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
                const I2C2Mult_clk_value = I2C2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C2Mult",
                    "Else",
                    "No Extra Log",
                    "I2C2CLockSelection",
                });
                const I2C2Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                };
                I2C2Mult.nodetype = .multi;
                I2C2Mult.parents = &.{I2C2Multparents[I2C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C2Freq_ValueValue);
                I2C2output.nodetype = .output;
                I2C2output.parents = &.{&I2C2Mult};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                const I2C3Mult_clk_value = I2C3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C3Mult",
                    "Else",
                    "No Extra Log",
                    "I2C3CLockSelection",
                });
                const I2C3Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C3Freq_ValueValue);
                I2C3output.nodetype = .output;
                I2C3output.parents = &.{&I2C3Mult};
            }
            if (check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=")) {
                const I2C4Mult_clk_value = I2C4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C4Mult",
                    "Else",
                    "No Extra Log",
                    "I2C4CLockSelection",
                });
                const I2C4Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                };
                I2C4Mult.nodetype = .multi;
                I2C4Mult.parents = &.{I2C4Multparents[I2C4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C4Freq_ValueValue);
                I2C4output.nodetype = .output;
                I2C4output.parents = &.{&I2C4Mult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const PLL48Mult_clk_value = PLL48CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL48Mult",
                    "Else",
                    "No Extra Log",
                    "PLL48CLockSelection",
                });
                const PLL48Multparents = [_]*const ClockNode{
                    &PLLQ,
                    &PLLSAIP,
                };
                PLL48Mult.nodetype = .multi;
                PLL48Mult.parents = &.{PLL48Multparents[PLL48Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&PLL48Mult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.limit = USBFreq_ValueLimit;
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&PLL48Mult};
            }
            if (check_MCU("LTDC_Exist")) {
                if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(LCDTFToutputFreq_ValueValue);
                    LCDTFTKOutput.limit = LCDTFToutputFreq_ValueLimit;
                    LCDTFTKOutput.nodetype = .output;
                    LCDTFTKOutput.parents = &.{&PLLSAIRDiv};
                }
            }
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPDIFRXFreq_ValueValue);
                SPDIFoutput.limit = SPDIFRXFreq_ValueLimit;
                SPDIFoutput.nodetype = .output;
                SPDIFoutput.parents = &.{&PLLI2SP};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                const SAI1Mult_clk_value = SAI1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1Mult",
                    "Else",
                    "No Extra Log",
                    "SAI1CLockSelection",
                });
                const SAI1Multparents = [_]*const ClockNode{
                    &PLLSAIQDiv,
                    &PLLI2SQDiv,
                    &I2S_CKIN,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1Freq_ValueValue);
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                const SAI2Mult_clk_value = SAI2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI2Mult",
                    "Else",
                    "No Extra Log",
                    "SAI2CLockSelection",
                });
                const SAI2Multparents = [_]*const ClockNode{
                    &PLLSAIQDiv,
                    &PLLI2SQDiv,
                    &I2S_CKIN,
                };
                SAI2Mult.nodetype = .multi;
                SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2Freq_ValueValue);
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
            }
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=")) {
                const I2SMult_clk_value = I2SCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2SMult",
                    "Else",
                    "No Extra Log",
                    "I2SCLockSelection",
                });
                const I2SMultparents = [_]*const ClockNode{
                    &PLLI2SR,
                    &I2S_CKIN,
                };
                I2SMult.nodetype = .multi;
                I2SMult.parents = &.{I2SMultparents[I2SMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2SFreq_ValueValue);
                I2Soutput.nodetype = .output;
                I2Soutput.parents = &.{&I2SMult};
            }
            if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                const SDMMCMult_clk_value = SDMMCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMCMult",
                    "Else",
                    "No Extra Log",
                    "SDMMCClockSelection",
                });
                const SDMMCMultparents = [_]*const ClockNode{
                    &PLL48Mult,
                    &SysCLKOutput,
                };
                SDMMCMult.nodetype = .multi;
                SDMMCMult.parents = &.{SDMMCMultparents[SDMMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMCFreq_ValueValue);
                SDMMCoutput.limit = SDMMCFreq_ValueLimit;
                SDMMCoutput.nodetype = .output;
                SDMMCoutput.parents = &.{&SDMMCMult};
            }

            std.mem.doNotOptimizeAway(EthernetFreq_ValueValue);
            EthernetPtpOutput.nodetype = .output;
            EthernetPtpOutput.parents = &.{&AHBOutput};
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                const MCO1Mult_clk_value = RCC_MCO1SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO1Mult",
                    "Else",
                    "No Extra Log",
                    "RCC_MCO1Source",
                });
                const MCO1Multparents = [_]*const ClockNode{
                    &LSEOSC,
                    &HSEOSC,
                    &HSIRC,
                    &PLLP,
                };
                MCO1Mult.nodetype = .multi;
                MCO1Mult.parents = &.{MCO1Multparents[MCO1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                const MCO1Div_clk_value = RCC_MCODiv1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO1Div",
                    "Else",
                    "No Extra Log",
                    "RCC_MCODiv1",
                });
                MCO1Div.nodetype = .div;
                MCO1Div.value = MCO1Div_clk_value.get();
                MCO1Div.parents = &.{&MCO1Mult};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCO1Pin.nodetype = .output;
                MCO1Pin.parents = &.{&MCO1Div};
            }
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=")) {
                const MCO2Mult_clk_value = RCC_MCO2SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO2Mult",
                    "Else",
                    "No Extra Log",
                    "RCC_MCO2Source",
                });
                const MCO2Multparents = [_]*const ClockNode{
                    &SysClkSource,
                    &PLLI2SR,
                    &HSEOSC,
                    &PLLP,
                };
                MCO2Mult.nodetype = .multi;
                MCO2Mult.parents = &.{MCO2Multparents[MCO2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=")) {
                const MCO2Div_clk_value = RCC_MCODiv2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO2Div",
                    "Else",
                    "No Extra Log",
                    "RCC_MCODiv2",
                });
                MCO2Div.nodetype = .div;
                MCO2Div.value = MCO2Div_clk_value.get();
                MCO2Div.parents = &.{&MCO2Mult};
            }
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO2PinFreq_ValueValue);
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }

            const AHBPrescaler_clk_value = AHBCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AHBPrescaler",
                "Else",
                "No Extra Log",
                "AHBCLKDivider",
            });
            AHBPrescaler.nodetype = .div;
            AHBPrescaler.value = AHBPrescaler_clk_value.get();
            AHBPrescaler.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};

            const CortexPrescaler_clk_value = Cortex_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CortexPrescaler",
                "Else",
                "No Extra Log",
                "Cortex_Div",
            });
            CortexPrescaler.nodetype = .div;
            CortexPrescaler.value = CortexPrescaler_clk_value.get();
            CortexPrescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
            FCLKCortexOutput.nodetype = .output;
            FCLKCortexOutput.parents = &.{&AHBOutput};

            const APB1Prescaler_clk_value = APB1CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB1Prescaler",
                "Else",
                "No Extra Log",
                "APB1CLKDivider",
            });
            APB1Prescaler.nodetype = .div;
            APB1Prescaler.value = APB1Prescaler_clk_value.get();
            APB1Prescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB1Freq_ValueValue);
            APB1Output.limit = APB1Freq_ValueLimit;
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&APB1Prescaler};

            const TimPrescalerAPB1_clk_value = APB1TimCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimPrescalerAPB1",
                "Else",
                "No Extra Log",
                "APB1TimCLKDivider",
            });
            TimPrescalerAPB1.nodetype = .mul;
            TimPrescalerAPB1.value = TimPrescalerAPB1_clk_value;
            TimPrescalerAPB1.parents = &.{&APB1Prescaler};

            std.mem.doNotOptimizeAway(APB1TimFreq_ValueValue);
            TimPrescOut1.nodetype = .output;
            TimPrescOut1.parents = &.{&TimPrescalerAPB1};

            const APB2Prescaler_clk_value = APB2CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB2Prescaler",
                "Else",
                "No Extra Log",
                "APB2CLKDivider",
            });
            APB2Prescaler.nodetype = .div;
            APB2Prescaler.value = APB2Prescaler_clk_value.get();
            APB2Prescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB2Freq_ValueValue);
            APB2Output.limit = APB2Freq_ValueLimit;
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&APB2Prescaler};

            const TimPrescalerAPB2_clk_value = APB2TimCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimPrescalerAPB2",
                "Else",
                "No Extra Log",
                "APB2TimCLKDivider",
            });
            TimPrescalerAPB2.nodetype = .mul;
            TimPrescalerAPB2.value = TimPrescalerAPB2_clk_value;
            TimPrescalerAPB2.parents = &.{&APB2Prescaler};

            std.mem.doNotOptimizeAway(APB2TimFreq_ValueValue);
            TimPrescOut2.nodetype = .output;
            TimPrescOut2.parents = &.{&TimPrescalerAPB2};
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                const USART1Mult_clk_value = USART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART1Mult",
                    "Else",
                    "No Extra Log",
                    "USART1CLockSelection",
                });
                const USART1Multparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                const USART2Mult_clk_value = USART2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART2Mult",
                    "Else",
                    "No Extra Log",
                    "USART2CLockSelection",
                });
                const USART2Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                USART2Mult.nodetype = .multi;
                USART2Mult.parents = &.{USART2Multparents[USART2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART2Freq_ValueValue);
                USART2output.nodetype = .output;
                USART2output.parents = &.{&USART2Mult};
            }
            if (check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=")) {
                const USART3Mult_clk_value = USART3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART3Mult",
                    "Else",
                    "No Extra Log",
                    "USART3CLockSelection",
                });
                const USART3Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                USART3Mult.nodetype = .multi;
                USART3Mult.parents = &.{USART3Multparents[USART3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART3Freq_ValueValue);
                USART3output.nodetype = .output;
                USART3output.parents = &.{&USART3Mult};
            }
            if (check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=")) {
                const USART6Mult_clk_value = USART6CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART6Mult",
                    "Else",
                    "No Extra Log",
                    "USART6CLockSelection",
                });
                const USART6Multparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                USART6Mult.nodetype = .multi;
                USART6Mult.parents = &.{USART6Multparents[USART6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART6Freq_ValueValue);
                USART6output.nodetype = .output;
                USART6output.parents = &.{&USART6Mult};
            }
            if (check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=")) {
                const UART4Mult_clk_value = UART4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART4Mult",
                    "Else",
                    "No Extra Log",
                    "UART4CLockSelection",
                });
                const UART4Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                UART4Mult.nodetype = .multi;
                UART4Mult.parents = &.{UART4Multparents[UART4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART4Freq_ValueValue);
                UART4output.nodetype = .output;
                UART4output.parents = &.{&UART4Mult};
            }
            if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                const UART5Mult_clk_value = UART5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART5Mult",
                    "Else",
                    "No Extra Log",
                    "UART5CLockSelection",
                });
                const UART5Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                UART5Mult.nodetype = .multi;
                UART5Mult.parents = &.{UART5Multparents[UART5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART5Freq_ValueValue);
                UART5output.nodetype = .output;
                UART5output.parents = &.{&UART5Mult};
            }
            if (check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=")) {
                const UART7Mult_clk_value = UART7CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART7Mult",
                    "Else",
                    "No Extra Log",
                    "UART7CLockSelection",
                });
                const UART7Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                UART7Mult.nodetype = .multi;
                UART7Mult.parents = &.{UART7Multparents[UART7Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART7Freq_ValueValue);
                UART7output.nodetype = .output;
                UART7output.parents = &.{&UART7Mult};
            }
            if (check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=")) {
                const UART8Mult_clk_value = UART8CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART8Mult",
                    "Else",
                    "No Extra Log",
                    "UART8CLockSelection",
                });
                const UART8Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                UART8Mult.nodetype = .multi;
                UART8Mult.parents = &.{UART8Multparents[UART8Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART8Freq_ValueValue);
                UART8output.nodetype = .output;
                UART8output.parents = &.{&UART8Mult};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                const LPTIM1Mult_clk_value = LPTIM1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM1Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM1CLockSelection",
                });
                const LPTIM1Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &LSIRC,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM1Mult.nodetype = .multi;
                LPTIM1Mult.parents = &.{LPTIM1Multparents[LPTIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM1Freq_ValueValue);
                LPTIM1Output.nodetype = .output;
                LPTIM1Output.parents = &.{&LPTIM1Mult};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const HSIDivCEC_clk_value = HSI_Div_CECValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIDivCEC",
                    "Else",
                    "No Extra Log",
                    "HSI_Div_CEC",
                });
                HSIDivCEC.nodetype = .div;
                HSIDivCEC.value = HSIDivCEC_clk_value;
                HSIDivCEC.parents = &.{&HSIRC};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CECMult_clk_value = CECClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CECMult",
                    "Else",
                    "No Extra Log",
                    "CECClockSelection",
                });
                const CECMultparents = [_]*const ClockNode{
                    &HSIDivCEC,
                    &LSEOSC,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CECFreq_ValueValue);
                CECOutput.nodetype = .output;
                CECOutput.parents = &.{&CECMult};
            }

            const PLLN_clk_value = PLLNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLN",
                "Else",
                "No Extra Log",
                "PLLN",
            });
            PLLN.nodetype = .mul;
            PLLN.value = PLLN_clk_value;
            PLLN.parents = &.{&PLLM};

            const PLLP_clk_value = PLLPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLP",
                "Else",
                "No Extra Log",
                "PLLP",
            });
            PLLP.nodetype = .div;
            PLLP.value = PLLP_clk_value.get();
            PLLP.parents = &.{&PLLN};
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const PLLQ_clk_value = PLLQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLQ",
                    "Else",
                    "No Extra Log",
                    "PLLQ",
                });
                PLLQ.nodetype = .div;
                PLLQ.value = PLLQ_clk_value;
                PLLQ.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLQoutputFreq_ValueValue);
                PLLQoutput.limit = PLLQoutputFreq_ValueLimit;
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLLQ};
            }

            const PLLSAIN_clk_value = PLLSAINValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAIN",
                "Else",
                "No Extra Log",
                "PLLSAIN",
            });
            PLLSAIN.nodetype = .mul;
            PLLSAIN.value = PLLSAIN_clk_value;
            PLLSAIN.parents = &.{&PLLM};
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const PLLSAIP_clk_value = PLLSAIPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIP",
                    "Else",
                    "No Extra Log",
                    "PLLSAIP",
                });
                PLLSAIP.nodetype = .div;
                PLLSAIP.value = PLLSAIP_clk_value.get();
                PLLSAIP.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLSAIoutputFreq_ValueValue);
                PLLSAIoutput.limit = PLLSAIoutputFreq_ValueLimit;
                PLLSAIoutput.nodetype = .output;
                PLLSAIoutput.parents = &.{&PLLSAIP};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAIQ_clk_value = PLLSAIQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIQ",
                    "Else",
                    "No Extra Log",
                    "PLLSAIQ",
                });
                PLLSAIQ.nodetype = .div;
                PLLSAIQ.value = PLLSAIQ_clk_value;
                PLLSAIQ.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAIQDiv_clk_value = PLLSAIQDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIQDiv",
                    "Else",
                    "No Extra Log",
                    "PLLSAIQDiv",
                });
                PLLSAIQDiv.nodetype = .div;
                PLLSAIQDiv.value = PLLSAIQDiv_clk_value;
                PLLSAIQDiv.parents = &.{&PLLSAIQ};
            }
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                const PLLSAIR_clk_value = PLLSAIRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIR",
                    "Else",
                    "No Extra Log",
                    "PLLSAIR",
                });
                PLLSAIR.nodetype = .div;
                PLLSAIR.value = PLLSAIR_clk_value;
                PLLSAIR.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                const PLLSAIRDiv_clk_value = PLLSAIRDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIRDiv",
                    "Else",
                    "No Extra Log",
                    "PLLSAIRDiv",
                });
                PLLSAIRDiv.nodetype = .div;
                PLLSAIRDiv.value = PLLSAIRDiv_clk_value.get();
                PLLSAIRDiv.parents = &.{&PLLSAIR};
            }

            const PLLI2SN_clk_value = PLLI2SNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLI2SN",
                "Else",
                "No Extra Log",
                "PLLI2SN",
            });
            PLLI2SN.nodetype = .mul;
            PLLI2SN.value = PLLI2SN_clk_value;
            PLLI2SN.parents = &.{&PLLM};
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=")) {
                const PLLI2SP_clk_value = PLLI2SPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SP",
                    "Else",
                    "No Extra Log",
                    "PLLI2SP",
                });
                PLLI2SP.nodetype = .div;
                PLLI2SP.value = PLLI2SP_clk_value.get();
                PLLI2SP.parents = &.{&PLLI2SN};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLI2SQ_clk_value = PLLI2SQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SQ",
                    "Else",
                    "No Extra Log",
                    "PLLI2SQ",
                });
                PLLI2SQ.nodetype = .div;
                PLLI2SQ.value = PLLI2SQ_clk_value;
                PLLI2SQ.parents = &.{&PLLI2SN};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLI2SQDiv_clk_value = PLLI2SQDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SQDiv",
                    "Else",
                    "No Extra Log",
                    "PLLI2SQDiv",
                });
                PLLI2SQDiv.nodetype = .div;
                PLLI2SQDiv.value = PLLI2SQDiv_clk_value;
                PLLI2SQDiv.parents = &.{&PLLI2SQ};
            }
            if (check_ref(@TypeOf(MCO2I2SEnableValue), MCO2I2SEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"="))
            {
                const PLLI2SR_clk_value = PLLI2SRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SR",
                    "Else",
                    "No Extra Log",
                    "PLLI2SR",
                });
                PLLI2SR.nodetype = .div;
                PLLI2SR.value = PLLI2SR_clk_value;
                PLLI2SR.parents = &.{&PLLI2SN};
            }
            if (check_ref(@TypeOf(MCO2I2SEnableValue), MCO2I2SEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLI2SRoutputFreq_ValueValue);
                PLLI2SRoutput.limit = PLLI2SRoutputFreq_ValueLimit;
                PLLI2SRoutput.nodetype = .output;
                PLLI2SRoutput.parents = &.{&PLLI2SR};
            }

            std.mem.doNotOptimizeAway(VCOInputFreq_ValueValue);
            VCOInput.limit = VCOInputFreq_ValueLimit;
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};

            std.mem.doNotOptimizeAway(VCOOutputFreq_ValueValue);
            VCOOutput.limit = VCOOutputFreq_ValueLimit;
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};

            std.mem.doNotOptimizeAway(PLLCLKFreq_ValueValue);
            PLLCLK.limit = PLLCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLP};

            std.mem.doNotOptimizeAway(PLLQCLKFreq_ValueValue);
            PLLQCLK.limit = PLLQCLKFreq_ValueLimit;
            PLLQCLK.nodetype = .output;
            PLLQCLK.parents = &.{&PLLQ};

            std.mem.doNotOptimizeAway(VCOSAIOutputFreq_ValueValue);
            VCOSAIOutput.limit = VCOSAIOutputFreq_ValueLimit;
            VCOSAIOutput.nodetype = .output;
            VCOSAIOutput.parents = &.{&PLLSAIN};

            std.mem.doNotOptimizeAway(PLLSAIPCLKFreq_ValueValue);
            PLLSAIPCLK.limit = PLLSAIPCLKFreq_ValueLimit;
            PLLSAIPCLK.nodetype = .output;
            PLLSAIPCLK.parents = &.{&PLLSAIP};

            std.mem.doNotOptimizeAway(PLLSAIQCLKFreq_ValueValue);
            PLLSAIQCLK.limit = PLLSAIQCLKFreq_ValueLimit;
            PLLSAIQCLK.nodetype = .output;
            PLLSAIQCLK.parents = &.{&PLLSAIQ};

            std.mem.doNotOptimizeAway(PLLSAIRCLKFreq_ValueValue);
            PLLSAIRCLK.limit = PLLSAIRCLKFreq_ValueLimit;
            PLLSAIRCLK.nodetype = .output;
            PLLSAIRCLK.parents = &.{&PLLSAIR};

            std.mem.doNotOptimizeAway(VCOI2SOutputFreq_ValueValue);
            VCOI2SOutput.limit = VCOI2SOutputFreq_ValueLimit;
            VCOI2SOutput.nodetype = .output;
            VCOI2SOutput.parents = &.{&PLLI2SN};

            std.mem.doNotOptimizeAway(PLLI2SPCLKFreq_ValueValue);
            PLLI2SPCLK.limit = PLLI2SPCLKFreq_ValueLimit;
            PLLI2SPCLK.nodetype = .output;
            PLLI2SPCLK.parents = &.{&PLLI2SP};

            std.mem.doNotOptimizeAway(PLLI2SQCLKFreq_ValueValue);
            PLLI2SQCLK.limit = PLLI2SQCLKFreq_ValueLimit;
            PLLI2SQCLK.nodetype = .output;
            PLLI2SQCLK.parents = &.{&PLLI2SQ};

            std.mem.doNotOptimizeAway(PLLI2SRCLKFreq_ValueValue);
            PLLI2SRCLK.limit = PLLI2SRCLKFreq_ValueLimit;
            PLLI2SRCLK.nodetype = .output;
            PLLI2SRCLK.parents = &.{&PLLI2SR};

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C2output = try I2C2output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.USART2output = try USART2output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART3output = try USART3output.get_output();
            out.USART3Mult = try USART3Mult.get_output();
            out.UART4output = try UART4output.get_output();
            out.UART4Mult = try UART4Mult.get_output();
            out.UART5output = try UART5output.get_output();
            out.UART5Mult = try UART5Mult.get_output();
            out.UART7output = try UART7output.get_output();
            out.UART7Mult = try UART7Mult.get_output();
            out.UART8output = try UART8output.get_output();
            out.UART8Mult = try UART8Mult.get_output();
            out.LPTIM1Output = try LPTIM1Output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.USART6output = try USART6output.get_output();
            out.USART6Mult = try USART6Mult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.EthernetPtpOutput = try EthernetPtpOutput.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SDMMCoutput = try SDMMCoutput.get_output();
            out.SDMMCMult = try SDMMCMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.PLL48Mult = try PLL48Mult.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLN = try PLLN.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.PLLI2SP = try PLLI2SP.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.PLLI2SQDiv = try PLLI2SQDiv.get_output();
            out.PLLI2SQ = try PLLI2SQ.get_output();
            out.I2Soutput = try I2Soutput.get_output();
            out.I2SMult = try I2SMult.get_output();
            out.PLLI2SRoutput = try PLLI2SRoutput.get_output();
            out.PLLI2SR = try PLLI2SR.get_output();
            out.PLLI2SN = try PLLI2SN.get_output();
            out.PLLSAIQDiv = try PLLSAIQDiv.get_output();
            out.PLLSAIQ = try PLLSAIQ.get_output();
            out.PLLSAIoutput = try PLLSAIoutput.get_output();
            out.PLLSAIP = try PLLSAIP.get_output();
            out.LCDTFTKOutput = try LCDTFTKOutput.get_output();
            out.PLLSAIRDiv = try PLLSAIRDiv.get_output();
            out.PLLSAIR = try PLLSAIR.get_output();
            out.PLLSAIN = try PLLSAIN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.CECOutput = try CECOutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.HSIDivCEC = try HSIDivCEC.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.PLLQCLK = try PLLQCLK.get_extra_output();
            out.VCOSAIOutput = try VCOSAIOutput.get_extra_output();
            out.PLLSAIPCLK = try PLLSAIPCLK.get_extra_output();
            out.PLLSAIQCLK = try PLLSAIQCLK.get_extra_output();
            out.PLLSAIRCLK = try PLLSAIRCLK.get_extra_output();
            out.VCOI2SOutput = try VCOI2SOutput.get_extra_output();
            out.PLLI2SPCLK = try PLLI2SPCLK.get_extra_output();
            out.PLLI2SQCLK = try PLLI2SQCLK.get_extra_output();
            out.PLLI2SRCLK = try PLLI2SRCLK.get_extra_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.PLL48CLockSelection = PLL48CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.I2SCLockSelection = I2SCLockSelectionValue;
            ref_out.SDMMCClockSelection = SDMMCClockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.USART3CLockSelection = USART3CLockSelectionValue;
            ref_out.USART6CLockSelection = USART6CLockSelectionValue;
            ref_out.UART4CLockSelection = UART4CLockSelectionValue;
            ref_out.UART5CLockSelection = UART5CLockSelectionValue;
            ref_out.UART7CLockSelection = UART7CLockSelectionValue;
            ref_out.UART8CLockSelection = UART8CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.HSI_Div_CEC = HSI_Div_CECValue;
            ref_out.CECClockSelection = CECClockSelectionValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLP = PLLPValue;
            ref_out.PLLQ = PLLQValue;
            ref_out.PLLSAIN = PLLSAINValue;
            ref_out.PLLSAIP = PLLSAIPValue;
            ref_out.PLLSAIQ = PLLSAIQValue;
            ref_out.PLLSAIQDiv = PLLSAIQDivValue;
            ref_out.PLLSAIR = PLLSAIRValue;
            ref_out.PLLSAIRDiv = PLLSAIRDivValue;
            ref_out.PLLI2SN = PLLI2SNValue;
            ref_out.PLLI2SP = PLLI2SPValue;
            ref_out.PLLI2SQ = PLLI2SQValue;
            ref_out.PLLI2SQDiv = PLLI2SQDivValue;
            ref_out.PLLI2SR = PLLI2SRValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.RCC_TIM_PRescaler_Selection = RCC_TIM_PRescaler_SelectionValue;
            ref_out.PWREXT_OverDrive = PWREXT_OverDriveValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.PLLSAIUsed = PLLSAIUsedValue;
            ref_out.PLLI2SUsed = PLLI2SUsedValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.I2C4Enable = I2C4EnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.SDMMCEnable = SDMMCEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.SPDIFEnable = SPDIFEnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.SAI2Enable = SAI2EnableValue;
            ref_out.I2SEnable = I2SEnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART3Enable = USART3EnableValue;
            ref_out.USART6Enable = USART6EnableValue;
            ref_out.UART4Enable = UART4EnableValue;
            ref_out.UART5Enable = UART5EnableValue;
            ref_out.UART7Enable = UART7EnableValue;
            ref_out.UART8Enable = UART8EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.CECEnable = CECEnableValue;
            ref_out.MCO2I2SEnable = MCO2I2SEnableValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.HSEUsed = HSEUsedValue;
            ref_out.LSIUsed = LSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
