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
    RCC_SYSCLKSOURCE_LSE,
    RCC_SYSCLKSOURCE_MSI,
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    RCC_SYSCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_LSE => 0,
            .RCC_SYSCLKSOURCE_MSI => 1,
            .RCC_SYSCLKSOURCE_HSI => 2,
            .RCC_SYSCLKSOURCE_HSE => 3,
            .RCC_SYSCLKSOURCE_PLLCLK => 4,
            .RCC_SYSCLKSOURCE_LSI => 5,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_MSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_HSE => 1,
            .RCC_PLLSOURCE_MSI => 2,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV32,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV32 => 0,
            .RCC_RTCCLKSOURCE_LSE => 1,
            .RCC_RTCCLKSOURCE_LSI => 2,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK1,
    RCC_USART1CLKSOURCE_SYSCLK,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK1 => 0,
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
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK1,
    RCC_LPUART1CLKSOURCE_SYSCLK,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK1 => 0,
            .RCC_LPUART1CLKSOURCE_SYSCLK => 1,
            .RCC_LPUART1CLKSOURCE_HSI => 2,
            .RCC_LPUART1CLKSOURCE_LSE => 3,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK1,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_LSI => 1,
            .RCC_LPTIM1CLKSOURCE_LSE => 2,
            .RCC_LPTIM1CLKSOURCE_HSI => 3,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK1,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_LSE,
    RCC_LPTIM2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM2CLKSOURCE_LSI => 1,
            .RCC_LPTIM2CLKSOURCE_LSE => 2,
            .RCC_LPTIM2CLKSOURCE_HSI => 3,
        };
    }
};
pub const LPUART2CLockSelectionList = enum {
    RCC_LPUART2CLKSOURCE_PCLK1,
    RCC_LPUART2CLKSOURCE_SYSCLK,
    RCC_LPUART2CLKSOURCE_HSI,
    RCC_LPUART2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART2CLKSOURCE_PCLK1 => 0,
            .RCC_LPUART2CLKSOURCE_SYSCLK => 1,
            .RCC_LPUART2CLKSOURCE_HSI => 2,
            .RCC_LPUART2CLKSOURCE_LSE => 3,
        };
    }
};
pub const TIM1CLockSelectionList = enum {
    RCC_TIM1CLKSOURCE_PCLK1,
    RCC_TIM1CLKSOURCE_PLLQ,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM1CLKSOURCE_PCLK1 => 0,
            .RCC_TIM1CLKSOURCE_PLLQ => 1,
        };
    }
};
pub const TIM15CLockSelectionList = enum {
    RCC_TIM15CLKSOURCE_PCLK1,
    RCC_TIM15CLKSOURCE_PLLQ,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM15CLKSOURCE_PCLK1 => 0,
            .RCC_TIM15CLKSOURCE_PLLQ => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_SYSCLK,
    RCC_ADCCLKSOURCE_HSI,
    RCC_ADCCLKSOURCE_PLLP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_SYSCLK => 0,
            .RCC_ADCCLKSOURCE_HSI => 1,
            .RCC_ADCCLKSOURCE_PLLP => 2,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_MSI,
    RCC_RNGCLKSOURCE_PLLQ,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_MSI => 0,
            .RCC_RNGCLKSOURCE_PLLQ => 1,
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
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSI48,
    RCC_MCO1SOURCE_PLLR,
    RCC_MCO1SOURCE_MSI,
    RCC_MCO1SOURCE_RTC_ALT,
    RCC_MCO1SOURCE_RTC_WAKEUP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_SYSCLK => 2,
            .RCC_MCO1SOURCE_HSE => 3,
            .RCC_MCO1SOURCE_HSI => 4,
            .RCC_MCO1SOURCE_HSI48 => 5,
            .RCC_MCO1SOURCE_PLLR => 6,
            .RCC_MCO1SOURCE_MSI => 7,
            .RCC_MCO1SOURCE_RTC_ALT => 8,
            .RCC_MCO1SOURCE_RTC_WAKEUP => 9,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_LSE,
    RCC_MCO2SOURCE_LSI,
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_HSI,
    RCC_MCO2SOURCE_HSI48,
    RCC_MCO2SOURCE_PLLR,
    RCC_MCO2SOURCE_MSI,
    RCC_MCO2SOURCE_RTC_ALT,
    RCC_MCO2SOURCE_RTC_WAKEUP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_LSE => 0,
            .RCC_MCO2SOURCE_LSI => 1,
            .RCC_MCO2SOURCE_SYSCLK => 2,
            .RCC_MCO2SOURCE_HSE => 3,
            .RCC_MCO2SOURCE_HSI => 4,
            .RCC_MCO2SOURCE_HSI48 => 5,
            .RCC_MCO2SOURCE_PLLR => 6,
            .RCC_MCO2SOURCE_MSI => 7,
            .RCC_MCO2SOURCE_RTC_ALT => 8,
            .RCC_MCO2SOURCE_RTC_WAKEUP => 9,
        };
    }
};
pub const LSCOSource1List = enum {
    RCC_LSCOSOURCE_LSI,
    RCC_LSCOSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LSCOSOURCE_LSI => 0,
            .RCC_LSCOSOURCE_LSE => 1,
        };
    }
};
pub const MSIClockRangeValList = enum {
    RCC_MSIRANGE_11,
    RCC_MSIRANGE_10,
    RCC_MSIRANGE_9,
    RCC_MSIRANGE_8,
    RCC_MSIRANGE_7,
    RCC_MSIRANGE_6,
    RCC_MSIRANGE_5,
    RCC_MSIRANGE_4,
    RCC_MSIRANGE_3,
    RCC_MSIRANGE_2,
    RCC_MSIRANGE_1,
    RCC_MSIRANGE_0,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSIRANGE_11 => 48000,
            .RCC_MSIRANGE_10 => 32000,
            .RCC_MSIRANGE_9 => 24000,
            .RCC_MSIRANGE_8 => 16000,
            .RCC_MSIRANGE_7 => 8000,
            .RCC_MSIRANGE_6 => 4000,
            .RCC_MSIRANGE_5 => 2000,
            .RCC_MSIRANGE_4 => 1000,
            .RCC_MSIRANGE_3 => 800,
            .RCC_MSIRANGE_2 => 400,
            .RCC_MSIRANGE_1 => 200,
            .RCC_MSIRANGE_0 => 100,
        };
    }
};
pub const PLLMList = enum {
    RCC_PLLM_DIV1,
    RCC_PLLM_DIV2,
    RCC_PLLM_DIV3,
    RCC_PLLM_DIV4,
    RCC_PLLM_DIV5,
    RCC_PLLM_DIV6,
    RCC_PLLM_DIV7,
    RCC_PLLM_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLM_DIV1 => 1,
            .RCC_PLLM_DIV2 => 2,
            .RCC_PLLM_DIV3 => 3,
            .RCC_PLLM_DIV4 => 4,
            .RCC_PLLM_DIV5 => 5,
            .RCC_PLLM_DIV6 => 6,
            .RCC_PLLM_DIV7 => 7,
            .RCC_PLLM_DIV8 => 8,
        };
    }
};
pub const RCC_MCODivList = enum {
    RCC_MCO1DIV_1,
    RCC_MCO1DIV_2,
    RCC_MCO1DIV_4,
    RCC_MCO1DIV_8,
    RCC_MCO1DIV_16,
    RCC_MCO1DIV_32,
    RCC_MCO1DIV_64,
    RCC_MCO1DIV_128,
    RCC_MCO1DIV_256,
    RCC_MCO1DIV_512,
    RCC_MCO1DIV_1024,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO1DIV_1 => 1,
            .RCC_MCO1DIV_2 => 2,
            .RCC_MCO1DIV_4 => 4,
            .RCC_MCO1DIV_8 => 8,
            .RCC_MCO1DIV_16 => 16,
            .RCC_MCO1DIV_32 => 32,
            .RCC_MCO1DIV_64 => 64,
            .RCC_MCO1DIV_128 => 128,
            .RCC_MCO1DIV_256 => 256,
            .RCC_MCO1DIV_512 => 512,
            .RCC_MCO1DIV_1024 => 1024,
        };
    }
};
pub const RCC_MCO2DivList = enum {
    RCC_MCO2DIV_1,
    RCC_MCO2DIV_2,
    RCC_MCO2DIV_4,
    RCC_MCO2DIV_8,
    RCC_MCO2DIV_16,
    RCC_MCO2DIV_32,
    RCC_MCO2DIV_64,
    RCC_MCO2DIV_128,
    RCC_MCO2DIV_256,
    RCC_MCO2DIV_512,
    RCC_MCO2DIV_1024,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO2DIV_1 => 1,
            .RCC_MCO2DIV_2 => 2,
            .RCC_MCO2DIV_4 => 4,
            .RCC_MCO2DIV_8 => 8,
            .RCC_MCO2DIV_16 => 16,
            .RCC_MCO2DIV_32 => 32,
            .RCC_MCO2DIV_64 => 64,
            .RCC_MCO2DIV_128 => 128,
            .RCC_MCO2DIV_256 => 256,
            .RCC_MCO2DIV_512 => 512,
            .RCC_MCO2DIV_1024 => 1024,
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
pub const PLLPList = enum {
    RCC_PLLP_DIV2,
    RCC_PLLP_DIV3,
    RCC_PLLP_DIV4,
    RCC_PLLP_DIV5,
    RCC_PLLP_DIV6,
    RCC_PLLP_DIV7,
    RCC_PLLP_DIV8,
    RCC_PLLP_DIV9,
    RCC_PLLP_DIV10,
    RCC_PLLP_DIV11,
    RCC_PLLP_DIV12,
    RCC_PLLP_DIV13,
    RCC_PLLP_DIV14,
    RCC_PLLP_DIV15,
    RCC_PLLP_DIV16,
    RCC_PLLP_DIV17,
    RCC_PLLP_DIV18,
    RCC_PLLP_DIV19,
    RCC_PLLP_DIV20,
    RCC_PLLP_DIV21,
    RCC_PLLP_DIV22,
    RCC_PLLP_DIV23,
    RCC_PLLP_DIV24,
    RCC_PLLP_DIV25,
    RCC_PLLP_DIV26,
    RCC_PLLP_DIV27,
    RCC_PLLP_DIV28,
    RCC_PLLP_DIV29,
    RCC_PLLP_DIV30,
    RCC_PLLP_DIV31,
    RCC_PLLP_DIV32,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV2 => 2,
            .RCC_PLLP_DIV3 => 3,
            .RCC_PLLP_DIV4 => 4,
            .RCC_PLLP_DIV5 => 5,
            .RCC_PLLP_DIV6 => 6,
            .RCC_PLLP_DIV7 => 7,
            .RCC_PLLP_DIV8 => 8,
            .RCC_PLLP_DIV9 => 9,
            .RCC_PLLP_DIV10 => 10,
            .RCC_PLLP_DIV11 => 11,
            .RCC_PLLP_DIV12 => 12,
            .RCC_PLLP_DIV13 => 13,
            .RCC_PLLP_DIV14 => 14,
            .RCC_PLLP_DIV15 => 15,
            .RCC_PLLP_DIV16 => 16,
            .RCC_PLLP_DIV17 => 17,
            .RCC_PLLP_DIV18 => 18,
            .RCC_PLLP_DIV19 => 19,
            .RCC_PLLP_DIV20 => 20,
            .RCC_PLLP_DIV21 => 21,
            .RCC_PLLP_DIV22 => 22,
            .RCC_PLLP_DIV23 => 23,
            .RCC_PLLP_DIV24 => 24,
            .RCC_PLLP_DIV25 => 25,
            .RCC_PLLP_DIV26 => 26,
            .RCC_PLLP_DIV27 => 27,
            .RCC_PLLP_DIV28 => 28,
            .RCC_PLLP_DIV29 => 29,
            .RCC_PLLP_DIV30 => 30,
            .RCC_PLLP_DIV31 => 31,
            .RCC_PLLP_DIV32 => 32,
        };
    }
};
pub const PLLQList = enum {
    RCC_PLLQ_DIV2,
    RCC_PLLQ_DIV3,
    RCC_PLLQ_DIV4,
    RCC_PLLQ_DIV5,
    RCC_PLLQ_DIV6,
    RCC_PLLQ_DIV7,
    RCC_PLLQ_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLQ_DIV2 => 2,
            .RCC_PLLQ_DIV3 => 3,
            .RCC_PLLQ_DIV4 => 4,
            .RCC_PLLQ_DIV5 => 5,
            .RCC_PLLQ_DIV6 => 6,
            .RCC_PLLQ_DIV7 => 7,
            .RCC_PLLQ_DIV8 => 8,
        };
    }
};
pub const PLLRList = enum {
    RCC_PLLR_DIV2,
    RCC_PLLR_DIV3,
    RCC_PLLR_DIV4,
    RCC_PLLR_DIV5,
    RCC_PLLR_DIV6,
    RCC_PLLR_DIV7,
    RCC_PLLR_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLR_DIV2 => 2,
            .RCC_PLLR_DIV3 => 3,
            .RCC_PLLR_DIV4 => 4,
            .RCC_PLLR_DIV5 => 5,
            .RCC_PLLR_DIV6 => 6,
            .RCC_PLLR_DIV7 => 7,
            .RCC_PLLR_DIV8 => 8,
        };
    }
};
pub const INSTRUCTION_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
};
pub const MSIAutoCalibrationList = enum {
    DISABLED,
    ENABLED,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const EnableHSERTCDevisorList = enum {
    true,
    false,
};
pub const EnableHSELCDDevisorList = enum {
    true,
    false,
};
pub const RTCEnableList = enum {
    true,
    false,
};
pub const LCDEnableList = enum {
    true,
    false,
};
pub const EnableRTCWKUPList = enum {
    true,
    false,
};
pub const IWDGEnableList = enum {
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
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const LPTIM2EnableList = enum {
    true,
    false,
};
pub const LPUART2EnableList = enum {
    true,
    false,
};
pub const TIM1EnableList = enum {
    true,
    false,
};
pub const TIM15EnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const MCO2EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const EnableCSSLSEList = enum {
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
            LSEByPassRTC: bool = false,
            LSEOscillatorRTC: bool = false,
            MCOConfig: bool = false,
            MCO2Config: bool = false,
            LSCOConfig: bool = false,
            ADC1_Used: bool = false,
            RNG_Used: bool = false,
            USB_Used: bool = false,
            I2C3_Used: bool = false,
            I2C1_Used: bool = false,
            LPUART2_Used: bool = false,
            LPTIM2_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPUART1_Used: bool = false,
            RTC_Used: bool = false,
            LCD_Used: bool = false,
            IWDG_Used: bool = false,
            USART1_Used: bool = false,
            USART2_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            MSIAutoCalibration: ?MSIAutoCalibrationList = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            MSIClockRangeVal: ?MSIClockRangeValList = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?PLLMList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            LPUART2CLockSelection: ?LPUART2CLockSelectionList = null,
            TIM1CLockSelection: ?TIM1CLockSelectionList = null,
            TIM15CLockSelection: ?TIM15CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCO2Div: ?RCC_MCO2DivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?PLLQList = null,
            PLLR: ?PLLRList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSI48RC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            MSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            RTCWkupOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            LPUART2Mult: f32 = 0,
            LPUART2output: f32 = 0,
            TIM1Mult: f32 = 0,
            TIM1output: f32 = 0,
            TIM15Mult: f32 = 0,
            TIM15output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            PWRCLKoutput: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APBPrescaler: f32 = 0,
            APBOutput: f32 = 0,
            TimPrescalerAPB: f32 = 0,
            TimPrescOut1: f32 = 0,
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLPoutput: f32 = 0,
            PLLQ: f32 = 0,
            PLLQoutput: f32 = 0,
            PLLR: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRangeVal: ?MSIClockRangeValList = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?PLLMList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            LPUART2CLockSelection: ?LPUART2CLockSelectionList = null, //from RCC Clock Config
            TIM1CLockSelection: ?TIM1CLockSelectionList = null, //from extra RCC references
            TIM15CLockSelection: ?TIM15CLockSelectionList = null, //from extra RCC references
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCO2Div: ?RCC_MCO2DivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLP: ?PLLPList = null, //from RCC Clock Config
            PLLQ: ?PLLQList = null, //from RCC Clock Config
            PLLR: ?PLLRList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            MSIAutoCalibration: ?MSIAutoCalibrationList = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            SYSCLKFreq_VALUE1: ?f32 = null, //from extra RCC references
            SYSCLKFreq_VALUE2: ?f32 = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            EnableHSELCDDevisor: ?EnableHSELCDDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            EnableRTCWKUP: ?EnableRTCWKUPList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            LPUART2Enable: ?LPUART2EnableList = null, //from extra RCC references
            TIM1Enable: ?TIM1EnableList = null, //from extra RCC references
            TIM15Enable: ?TIM15EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            MCO2Enable: ?MCO2EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            MSIUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
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

            var SysSourceLse: bool = false;
            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var SysSourceLsi: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var USART1SourcePCLK1: bool = false;
            var USART1SourceSys: bool = false;
            var USART1SourceHSI: bool = false;
            var USART1SourceLSE: bool = false;
            var USART2SourcePCLK1: bool = false;
            var USART2SourceSys: bool = false;
            var USART2SourceHSI: bool = false;
            var USART2SourceLSE: bool = false;
            var LPUART1SourcePCLK1: bool = false;
            var LPUART1SourceSys: bool = false;
            var LPUART1SourceHSI: bool = false;
            var LPUART1SourceLSE: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var LPTIM2SOURCEHSI: bool = false;
            var LPUART2SourcePCLK1: bool = false;
            var LPUART2SourceSys: bool = false;
            var LPUART2SourceHSI: bool = false;
            var LPUART2SourceLSE: bool = false;
            var TIM1SOURCEPclk: bool = false;
            var TIM1SOURCEPll: bool = false;
            var TIM15SOURCEPclk: bool = false;
            var TIM15SOURCEPll: bool = false;
            var ADCSourceSys: bool = false;
            var ADCSourceHsi: bool = false;
            var ADCSourcePllp: bool = false;
            var RNGClockisMsi: bool = false;
            var RNGClockisPll: bool = false;
            var I2C1SourcePCLK1: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C3SourcePCLK1: bool = false;
            var I2C3SourceSys: bool = false;
            var I2C3SourceHSI: bool = false;
            var MCOSourceLSE: bool = false;
            var MCOSourceLSI: bool = false;
            var MCOSourcesys: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceHSI: bool = false;
            var MCO1SOURCE_HSI48: bool = false;
            var MCOSourcePLL: bool = false;
            var MCO1SOURCE_MSI: bool = false;
            var MCO1SOURCE_RTCCLK: bool = false;
            var MCO1SOURCE_RTC_WKUP: bool = false;
            var MCO2SourceLSE: bool = false;
            var MCO2SourceLSI: bool = false;
            var MCO2Sourcesys: bool = false;
            var MCO2SourceHSE: bool = false;
            var MCO2SourceHSI: bool = false;
            var MCO2SOURCE_HSI48: bool = false;
            var MCO2SourcePLL: bool = false;
            var MCO2SOURCE_MSI: bool = false;
            var MCO2SOURCE_RTCCLK: bool = false;
            var MCO2SOURCE_RTC_WKUP: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var PLLQ2: bool = false;
            var PLLQ3: bool = false;
            var PLLQ4: bool = false;
            var PLLQ5: bool = false;
            var PLLQ6: bool = false;
            var PLLQ7: bool = false;
            var PLLQ8: bool = false;
            var PLLR2: bool = false;
            var PLLR3: bool = false;
            var PLLR4: bool = false;
            var PLLR5: bool = false;
            var PLLR6: bool = false;
            var PLLR7: bool = false;
            var PLLR8: bool = false;
            var FLASH_LATENCY1: bool = false;
            var FLASH_LATENCY2: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
            var MSIAutoCalibrationON: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;
            var LSI_VALUELimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var TIM1Freq_ValueLimit: Limit = .{};
            var TIM15Freq_ValueLimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var PWRFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var AHBFreq_ValueLimit: Limit = .{};
            var CortexFreq_ValueLimit: Limit = .{};
            var FCLKCortexFreq_ValueLimit: Limit = .{};
            var APBFreq_ValueLimit: Limit = .{};
            var PLLPoutputFreq_ValueLimit: Limit = .{};
            var PLLQoutputFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 16000000;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 48000000;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if ((config.flags.HSEByPass or config.flags.HSEOscillator) and scale1) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 4e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass|HSEOscillator) & scale1 ",
                                "HSE in bypass Mode",
                                4e6,
                                val,
                            });
                        }
                        if (val > 4.8e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass|HSEOscillator) & scale1 ",
                                "HSE in bypass Mode",
                                4.8e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 4000000;
                } else if ((config.flags.HSEByPass or config.flags.HSEOscillator) and scale2) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 4e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass|HSEOscillator) & scale2 ",
                                "HSE in bypass Mode",
                                4e6,
                                val,
                            });
                        }
                        if (val > 1.9e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass|HSEOscillator) & scale2 ",
                                "HSE in bypass Mode",
                                1.9e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 4000000;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 4e6) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 4.8e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_VALUE",
                            "Else",
                            "No Extra Log",
                            4.8e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 4000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                LSI_VALUELimit = .{
                    .min = 3.04e4,
                    .max = 3.36e4,
                };
                break :blk null;
            };
            const MSIClockRangeValValue: ?MSIClockRangeValList = blk: {
                const conf_item = config.MSIClockRangeVal;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSIRANGE_11 => {},
                        .RCC_MSIRANGE_10 => {},
                        .RCC_MSIRANGE_9 => {},
                        .RCC_MSIRANGE_8 => {},
                        .RCC_MSIRANGE_7 => {},
                        .RCC_MSIRANGE_6 => {},
                        .RCC_MSIRANGE_5 => {},
                        .RCC_MSIRANGE_4 => {},
                        .RCC_MSIRANGE_3 => {},
                        .RCC_MSIRANGE_2 => {},
                        .RCC_MSIRANGE_1 => {},
                        .RCC_MSIRANGE_0 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MSIRANGE_6;
            };
            const LSE_VALUEValue: ?f32 = blk: {
                if (config.flags.LSEOscillator) {
                    if (config.LSE_VALUE) |val| {
                        if (val != 3.2768e4) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    break :blk 32768;
                }
                const config_val = config.LSE_VALUE;
                if (config_val) |val| {
                    if (val < 1e3) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSE_VALUE",
                            "Else",
                            "No Extra Log",
                            1e3,
                            val,
                        });
                    }
                    if (val > 1e6) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_LSE => SysSourceLse = true,
                        .RCC_SYSCLKSOURCE_MSI => SysSourceMSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourcePLL = true,
                        .RCC_SYSCLKSOURCE_LSI => SysSourceLsi = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => {},
                        .RCC_PLLSOURCE_HSE => {},
                        .RCC_PLLSOURCE_MSI => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const PLLMValue: ?PLLMList = blk: {
                const conf_item = config.PLLM;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLM_DIV1 => {},
                        .RCC_PLLM_DIV2 => {},
                        .RCC_PLLM_DIV3 => {},
                        .RCC_PLLM_DIV4 => {},
                        .RCC_PLLM_DIV5 => {},
                        .RCC_PLLM_DIV6 => {},
                        .RCC_PLLM_DIV7 => {},
                        .RCC_PLLM_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLM_DIV1;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 32;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => RTCSourceHSE = true,
                        .RCC_RTCCLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTCCLKSOURCE_LSI => RTCSourceLSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTC_Used and check_MCU("CodegenConfigPeriph")) {
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
                break :blk 32000;
            };
            const RTCWUPFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK1 => USART1SourcePCLK1 = true,
                        .RCC_USART1CLKSOURCE_SYSCLK => USART1SourceSys = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK1;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_USART2CLKSOURCE_PCLK1;
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK1 => LPUART1SourcePCLK1 = true,
                        .RCC_LPUART1CLKSOURCE_SYSCLK => LPUART1SourceSys = true,
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK1;
            };
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK1;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                        .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const LPUART2CLockSelectionValue: ?LPUART2CLockSelectionList = blk: {
                const conf_item = config.LPUART2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART2CLKSOURCE_PCLK1 => LPUART2SourcePCLK1 = true,
                        .RCC_LPUART2CLKSOURCE_SYSCLK => LPUART2SourceSys = true,
                        .RCC_LPUART2CLKSOURCE_HSI => LPUART2SourceHSI = true,
                        .RCC_LPUART2CLKSOURCE_LSE => LPUART2SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART2CLKSOURCE_PCLK1;
            };
            const LPUART2Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const SYSCLKFreq_VALUE1Value: ?f32 = blk: {
                const min: ?f32 = null;
                const max: ?f32 = null;
                const val: ?f32 = try math_op(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 1000000, .@"/", "SYSCLKFreq_VALUE1", "SYSCLKFreq_VALUE", "1000000");

                if (val) |actual| {
                    if (max) |m| {
                        if (actual > m) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: null({e}) found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{ "SYSCLKFreq_VALUE1", "Else", "No Extra Log", m, actual });
                        }
                    }
                    if (min) |m| {
                        if (actual < m) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: null({e}) found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{ "SYSCLKFreq_VALUE1", "Else", "No Extra Log", m, actual });
                        }
                    }
                }
                break :blk val;
            };
            const SYSCLKFreq_VALUE2Value: ?f32 = blk: {
                const min: ?f32 = null;
                const max: ?f32 = null;
                const val: ?f32 = try math_op(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 1000000, .@"/", "SYSCLKFreq_VALUE2", "SYSCLKFreq_VALUE", "1000000");

                if (val) |actual| {
                    if (max) |m| {
                        if (actual > m) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: null({e}) found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{ "SYSCLKFreq_VALUE2", "Else", "No Extra Log", m, actual });
                        }
                    }
                    if (min) |m| {
                        if (actual < m) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: null({e}) found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{ "SYSCLKFreq_VALUE2", "Else", "No Extra Log", m, actual });
                        }
                    }
                }
                break :blk val;
            };
            const TIM1CLockSelectionValue: ?TIM1CLockSelectionList = blk: {
                if (!(((PLLR2 and PLLQ2) or (PLLR3 and PLLQ3) or (PLLR4 and (PLLQ4 or PLLQ2)) or (PLLR5 and PLLQ5) or (PLLR6 and (PLLQ3 or PLLQ2 or PLLQ6)) or (PLLR7 and PLLQ7) or (PLLR8 and (PLLQ8 or PLLQ4 or PLLQ2))) and (check_ref(@TypeOf(SYSCLKFreq_VALUE1Value), SYSCLKFreq_VALUE1Value, .SYSCLKFreq_VALUE2, .@"=")) and SysSourcePLL)) {
                    TIM1SOURCEPclk = true;
                    const item: TIM1CLockSelectionList = .RCC_TIM1CLKSOURCE_PCLK1;
                    const conf_item = config.TIM1CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "TIM1CLockSelection", "!(((PLLR2 & PLLQ2) |(PLLR3 & PLLQ3) | (PLLR4 & (PLLQ4 | PLLQ2)) | (PLLR5 & PLLQ5) | (PLLR6 & (PLLQ3 | PLLQ2 | PLLQ6)) | (PLLR7 & PLLQ7) | (PLLR8 & (PLLQ8 | PLLQ4 | PLLQ2))) & (SYSCLKFreq_VALUE1=SYSCLKFreq_VALUE2) & SysSourcePLL)", "When TIM1/TIM15 derives from PLLQ, they can be only an integer multiple of PCLK and must be aligned with it.", "RCC_TIM1CLKSOURCE_PCLK1", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.TIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM1CLKSOURCE_PCLK1 => TIM1SOURCEPclk = true,
                        .RCC_TIM1CLKSOURCE_PLLQ => TIM1SOURCEPll = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM1CLKSOURCE_PCLK1;
            };
            const APBTimFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const TIM1Freq_ValueValue: ?f32 = blk: {
                const min: ?f32 = null;
                const max: ?f32 = null;
                TIM1Freq_ValueLimit = .{
                    .min = min,
                    .max = max,
                    .min_expr = "null",
                    .max_expr = "null",
                };
                break :blk null;
            };
            const TIM15CLockSelectionValue: ?TIM15CLockSelectionList = blk: {
                if (!(((PLLR2 and PLLQ2) or (PLLR3 and PLLQ3) or (PLLR4 and (PLLQ4 or PLLQ2)) or (PLLR5 and PLLQ5) or (PLLR6 and (PLLQ3 or PLLQ2 or PLLQ6)) or (PLLR7 and PLLQ7) or (PLLR8 and (PLLQ8 or PLLQ4 or PLLQ2))) and (check_ref(@TypeOf(SYSCLKFreq_VALUE1Value), SYSCLKFreq_VALUE1Value, .SYSCLKFreq_VALUE2, .@"=")) and SysSourcePLL)) {
                    TIM15SOURCEPclk = true;
                    const item: TIM15CLockSelectionList = .RCC_TIM15CLKSOURCE_PCLK1;
                    const conf_item = config.TIM15CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "TIM15CLockSelection", "!(((PLLR2 & PLLQ2) |(PLLR3 & PLLQ3) | (PLLR4 & (PLLQ4 | PLLQ2)) | (PLLR5 & PLLQ5) | (PLLR6 & (PLLQ3 | PLLQ2 | PLLQ6)) | (PLLR7 & PLLQ7) | (PLLR8 & (PLLQ8 | PLLQ4 | PLLQ2))) & (SYSCLKFreq_VALUE1=SYSCLKFreq_VALUE2) & SysSourcePLL)", "When TIM1/TIM15 derives from PLLQ, they can be only an integer multiple of PCLK and must be aligned with it.", "RCC_TIM15CLKSOURCE_PCLK1", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.TIM15CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM15CLKSOURCE_PCLK1 => TIM15SOURCEPclk = true,
                        .RCC_TIM15CLKSOURCE_PLLQ => TIM15SOURCEPll = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM15CLKSOURCE_PCLK1;
            };
            const TIM15Freq_ValueValue: ?f32 = blk: {
                const min: ?f32 = null;
                const max: ?f32 = null;
                TIM15Freq_ValueLimit = .{
                    .min = min,
                    .max = max,
                    .min_expr = "null",
                    .max_expr = "null",
                };
                break :blk null;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        .RCC_ADCCLKSOURCE_HSI => ADCSourceHsi = true,
                        .RCC_ADCCLKSOURCE_PLLP => ADCSourcePllp = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADCCLKSOURCE_SYSCLK;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.22e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 4e7,
                    };
                    break :blk null;
                }
                ADCFreq_ValueLimit = .{
                    .min = null,
                    .max = 8e7,
                };
                break :blk null;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_MSI => RNGClockisMsi = true,
                        .RCC_RNGCLKSOURCE_PLLQ => RNGClockisPll = true,
                    }
                }

                break :blk conf_item orelse .RCC_RNGCLKSOURCE_MSI;
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                RNGFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
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

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK1;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_LSE => MCOSourceLSE = true,
                        .RCC_MCO1SOURCE_LSI => MCOSourceLSI = true,
                        .RCC_MCO1SOURCE_SYSCLK => MCOSourcesys = true,
                        .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                        .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                        .RCC_MCO1SOURCE_HSI48 => MCO1SOURCE_HSI48 = true,
                        .RCC_MCO1SOURCE_PLLR => MCOSourcePLL = true,
                        .RCC_MCO1SOURCE_MSI => MCO1SOURCE_MSI = true,
                        .RCC_MCO1SOURCE_RTC_ALT => MCO1SOURCE_RTCCLK = true,
                        .RCC_MCO1SOURCE_RTC_WAKEUP => MCO1SOURCE_RTC_WKUP = true,
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
            };
            const RCC_MCODivValue: ?RCC_MCODivList = blk: {
                const conf_item = config.RCC_MCODiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1DIV_1 => {},
                        .RCC_MCO1DIV_2 => {},
                        .RCC_MCO1DIV_4 => {},
                        .RCC_MCO1DIV_8 => {},
                        .RCC_MCO1DIV_16 => {},
                        .RCC_MCO1DIV_32 => {},
                        .RCC_MCO1DIV_64 => {},
                        .RCC_MCO1DIV_128 => {},
                        .RCC_MCO1DIV_256 => {},
                        .RCC_MCO1DIV_512 => {},
                        .RCC_MCO1DIV_1024 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1DIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_LSE => MCO2SourceLSE = true,
                        .RCC_MCO2SOURCE_LSI => MCO2SourceLSI = true,
                        .RCC_MCO2SOURCE_SYSCLK => MCO2Sourcesys = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SourceHSE = true,
                        .RCC_MCO2SOURCE_HSI => MCO2SourceHSI = true,
                        .RCC_MCO2SOURCE_HSI48 => MCO2SOURCE_HSI48 = true,
                        .RCC_MCO2SOURCE_PLLR => MCO2SourcePLL = true,
                        .RCC_MCO2SOURCE_MSI => MCO2SOURCE_MSI = true,
                        .RCC_MCO2SOURCE_RTC_ALT => MCO2SOURCE_RTCCLK = true,
                        .RCC_MCO2SOURCE_RTC_WAKEUP => MCO2SOURCE_RTC_WKUP = true,
                    }
                }

                break :blk conf_item orelse .RCC_MCO2SOURCE_SYSCLK;
            };
            const RCC_MCO2DivValue: ?RCC_MCO2DivList = blk: {
                const conf_item = config.RCC_MCO2Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2DIV_1 => {},
                        .RCC_MCO2DIV_2 => {},
                        .RCC_MCO2DIV_4 => {},
                        .RCC_MCO2DIV_8 => {},
                        .RCC_MCO2DIV_16 => {},
                        .RCC_MCO2DIV_32 => {},
                        .RCC_MCO2DIV_64 => {},
                        .RCC_MCO2DIV_128 => {},
                        .RCC_MCO2DIV_256 => {},
                        .RCC_MCO2DIV_512 => {},
                        .RCC_MCO2DIV_1024 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO2DIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                const conf_item = config.LSCOSource1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_LSI => LSCOSSourceLSI = true,
                        .RCC_LSCOSOURCE_LSE => LSCOSSourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LSCOSOURCE_LSI;
            };
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const AHBCLKDividerValue: ?AHBCLKDividerList = blk: {
                const conf_item = config.AHBCLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLK_DIV1 => AHBCLKDivider1 = true,
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
            const PWRFreq_ValueValue: ?f32 = blk: {
                PWRFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                AHBFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
            };
            const Cortex_DivValue: ?Cortex_DivList = blk: {
                const conf_item = config.Cortex_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .SYSTICK_CLKSOURCE_HCLK => HCLKDiv1 = true,
                        .SYSTICK_CLKSOURCE_HCLK_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .SYSTICK_CLKSOURCE_HCLK;
            };
            const CortexFreq_ValueValue: ?f32 = blk: {
                CortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                FCLKCortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.6e7,
                };
                break :blk null;
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
            const APBFreq_ValueValue: ?f32 = blk: {
                APBFreq_ValueLimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 4) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLN",
                            "Else",
                            "No Extra Log",
                            4,
                            val,
                        });
                    }
                    if (val > 127) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLN",
                            "Else",
                            "No Extra Log",
                            127,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
            };
            const PLLPValue: ?PLLPList = blk: {
                const conf_item = config.PLLP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV2 => {},
                        .RCC_PLLP_DIV3 => {},
                        .RCC_PLLP_DIV4 => {},
                        .RCC_PLLP_DIV5 => {},
                        .RCC_PLLP_DIV6 => {},
                        .RCC_PLLP_DIV7 => {},
                        .RCC_PLLP_DIV8 => {},
                        .RCC_PLLP_DIV9 => {},
                        .RCC_PLLP_DIV10 => {},
                        .RCC_PLLP_DIV11 => {},
                        .RCC_PLLP_DIV12 => {},
                        .RCC_PLLP_DIV13 => {},
                        .RCC_PLLP_DIV14 => {},
                        .RCC_PLLP_DIV15 => {},
                        .RCC_PLLP_DIV16 => {},
                        .RCC_PLLP_DIV17 => {},
                        .RCC_PLLP_DIV18 => {},
                        .RCC_PLLP_DIV19 => {},
                        .RCC_PLLP_DIV20 => {},
                        .RCC_PLLP_DIV21 => {},
                        .RCC_PLLP_DIV22 => {},
                        .RCC_PLLP_DIV23 => {},
                        .RCC_PLLP_DIV24 => {},
                        .RCC_PLLP_DIV25 => {},
                        .RCC_PLLP_DIV26 => {},
                        .RCC_PLLP_DIV27 => {},
                        .RCC_PLLP_DIV28 => {},
                        .RCC_PLLP_DIV29 => {},
                        .RCC_PLLP_DIV30 => {},
                        .RCC_PLLP_DIV31 => {},
                        .RCC_PLLP_DIV32 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLP_DIV2;
            };
            const PLLPoutputFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.ADC1_Used and ADCSourcePllp) and scale1) {
                    PLLPoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.22e8,
                    };
                    break :blk null;
                } else if ((config.flags.ADC1_Used and ADCSourcePllp) and scale2) {
                    PLLPoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 4e7,
                    };
                    break :blk null;
                }
                break :blk 16000000;
            };
            const PLLQValue: ?PLLQList = blk: {
                const conf_item = config.PLLQ;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLQ_DIV2 => PLLQ2 = true,
                        .RCC_PLLQ_DIV3 => PLLQ3 = true,
                        .RCC_PLLQ_DIV4 => PLLQ4 = true,
                        .RCC_PLLQ_DIV5 => PLLQ5 = true,
                        .RCC_PLLQ_DIV6 => PLLQ6 = true,
                        .RCC_PLLQ_DIV7 => PLLQ7 = true,
                        .RCC_PLLQ_DIV8 => PLLQ8 = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLQ_DIV2;
            };
            const PLLQoutputFreq_ValueValue: ?f32 = blk: {
                if (((RNGClockisPll and config.flags.RNG_Used) or (TIM15SOURCEPll and check_MCU("TIM15")) or (TIM1SOURCEPll and check_MCU("TIM1")) or (config.flags.USB_Used and check_MCU("USBCLKSOURCE_PLL"))) and scale1) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 5.6e7,
                    };
                    break :blk null;
                } else if (((RNGClockisPll and config.flags.RNG_Used) or (TIM15SOURCEPll and check_MCU("TIM15")) or (TIM1SOURCEPll and check_MCU("TIM1")) or (config.flags.USB_Used and check_MCU("USBCLKSOURCE_PLL"))) and scale2) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.9e7,
                    };
                    break :blk null;
                }
                break :blk 16000000;
            };
            const PLLRValue: ?PLLRList = blk: {
                const conf_item = config.PLLR;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLR_DIV2 => PLLR2 = true,
                        .RCC_PLLR_DIV3 => PLLR3 = true,
                        .RCC_PLLR_DIV4 => PLLR4 = true,
                        .RCC_PLLR_DIV5 => PLLR5 = true,
                        .RCC_PLLR_DIV6 => PLLR6 = true,
                        .RCC_PLLR_DIV7 => PLLR7 = true,
                        .RCC_PLLR_DIV8 => PLLR8 = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLR_DIV2;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.71e0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "VDD_VALUE",
                            "Else",
                            "No Extra Log",
                            1.71e0,
                            val,
                        });
                    }
                    if (val > 3.6e0) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
            const INSTRUCTION_CACHE_ENABLEValue: ?INSTRUCTION_CACHE_ENABLEList = blk: {
                const conf_item = config.extra.INSTRUCTION_CACHE_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const PREFETCH_ENABLEValue: ?PREFETCH_ENABLEList = blk: {
                const conf_item = config.extra.PREFETCH_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"0";
            };
            const DATA_CACHE_ENABLEValue: ?DATA_CACHE_ENABLEList = blk: {
                const conf_item = config.extra.DATA_CACHE_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale2 & ((HCLKFreq_Value < 8000000)|(HCLKFreq_Value= 8000000 ))", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale2 & ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value= 16000000))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 18000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 18000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale2 & ((HCLKFreq_Value < 18000000)|(HCLKFreq_Value= 18000000))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if (scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale1 &((HCLKFreq_Value < 24000000)|(HCLKFreq_Value= 24000000 ))", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale1 & ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value= 48000000))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if (scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 56000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 56000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "FLatency", "scale1 &((HCLKFreq_Value < 56000000)|(HCLKFreq_Value= 56000000 ))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.FLatency;
                if (conf_item) |item| {
                    switch (item) {
                        .FLASH_LATENCY_0 => {},
                        .FLASH_LATENCY_1 => FLASH_LATENCY1 = true,
                        .FLASH_LATENCY_2 => FLASH_LATENCY2 = true,
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
                const config_val = config.extra.HSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 127) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            127,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 64;
            };
            const MSICalibrationValueValue: ?f32 = blk: {
                const config_val = config.extra.MSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "MSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 255) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "MSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            255,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 18;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                } else if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@">")))) {
                    scale1 = true;
                    const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE1;
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value > 16000000))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                }
                break :blk null;
            };
            const HSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.HSE_Timout;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
            const PLLUsedValue: ?f32 = blk: {
                if ((config.flags.ADC1_Used and ADCSourcePllp) or (check_MCU("TIM15") and TIM15SOURCEPll) or (check_MCU("TIM1") and TIM1SOURCEPll) or (SysSourcePLL) or (MCOSourcePLL and config.flags.MCOConfig) or (MCO2SourcePLL and config.flags.MCO2Config) or (RNGClockisPll and config.flags.RNG_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIUsedValue: ?f32 = blk: {
                if ((config.flags.RNG_Used and RNGClockisMsi) or (SysSourceMSI) or (config.flags.MCOConfig and MCO1SOURCE_MSI) or (config.flags.MCO2Config and MCO2SOURCE_MSI) or (check_MCU("PLLSourceMSI") and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIAutoCalibrationValue: ?MSIAutoCalibrationList = blk: {
                if ((check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=")) and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const conf_item = config.extra.MSIAutoCalibration;
                    if (conf_item) |item| {
                        switch (item) {
                            .DISABLED => {},
                            .ENABLED => MSIAutoCalibrationON = true,
                        }
                    }

                    break :blk conf_item orelse .DISABLED;
                }
                const item: MSIAutoCalibrationList = .DISABLED;
                const conf_item = config.extra.MSIAutoCalibration;
                if (conf_item) |i| {
                    if (item != i) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "MSIAutoCalibration", "Else", "No Extra Log", "DISABLED", i });
                    }
                }
                break :blk item;
            };
            const LSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.LSE_Timout;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                if ((MSIAutoCalibrationON and check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=") and (config.flags.LSEByPass or config.flags.LSEOscillator)) or (SysSourceLse) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (USART1SourceLSE and config.flags.USART1_Used) or (USART2SourceLSE and config.flags.USART2_Used) or (LPUART1SourceLSE and config.flags.LPUART1_Used) or (LPUART2SourceLSE and config.flags.LPUART2_Used) or (LPTIM1SOURCELSE and config.flags.LPTIM1_Used) or (LPTIM2SOURCELSE and config.flags.LPTIM2_Used) or (MCOSourceLSE and config.flags.MCOConfig) or (MCO2SourceLSE and config.flags.MCO2Config) or (RTCSourceLSE and config.flags.RTC_Used)) {
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

                    break :blk conf_item orelse .false;
                }
                if (config.extra.LSE_Drive_Capability) |_| {
                    try comptime_fail_or_error(error.InvalidConfig,
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
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTC_Used and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const EnableHSELCDDevisorValue: ?EnableHSELCDDevisorList = blk: {
                if (config.flags.LCD_Used and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSELCDDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSELCDDevisorList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCD_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const EnableRTCWKUPValue: ?EnableRTCWKUPList = blk: {
                if (config.flags.RTC_Used and check_MCU("RTC_WAKEUP_INTERRUPT") and check_MCU("CodegenConfigPeriph")) {
                    const item: EnableRTCWKUPList = .true;
                    break :blk item;
                }
                const item: EnableRTCWKUPList = .false;
                break :blk item;
            };
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDG_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const USART2EnableValue: ?USART2EnableList = blk: {
                if (config.flags.USART2_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: USART2EnableList = .true;
                    break :blk item;
                }
                const item: USART2EnableList = .false;
                break :blk item;
            };
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUART1_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const LPTIM2EnableValue: ?LPTIM2EnableList = blk: {
                if (config.flags.LPTIM2_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: LPTIM2EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM2EnableList = .false;
                break :blk item;
            };
            const LPUART2EnableValue: ?LPUART2EnableList = blk: {
                if (config.flags.LPUART2_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: LPUART2EnableList = .true;
                    break :blk item;
                }
                const item: LPUART2EnableList = .false;
                break :blk item;
            };
            const TIM1EnableValue: ?TIM1EnableList = blk: {
                if (check_MCU("TIM1") and check_MCU("CodegenConfigPeriph")) {
                    const item: TIM1EnableList = .true;
                    break :blk item;
                }
                const item: TIM1EnableList = .false;
                break :blk item;
            };
            const TIM15EnableValue: ?TIM15EnableList = blk: {
                if (check_MCU("TIM15") and check_MCU("CodegenConfigPeriph")) {
                    const item: TIM15EnableList = .true;
                    break :blk item;
                }
                const item: TIM15EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.ADC1_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const RNGEnableValue: ?RNGEnableList = blk: {
                if (config.flags.RNG_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: RNGEnableList = .true;
                    break :blk item;
                }
                const item: RNGEnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
                break :blk item;
            };
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3_Used and check_MCU("CodegenConfigPeriph")) {
                    const item: I2C3EnableList = .true;
                    break :blk item;
                }
                const item: I2C3EnableList = .false;
                break :blk item;
            };
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (config.flags.MCOConfig and check_MCU("CodegenConfigPeriph")) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const MCO2EnableValue: ?MCO2EnableList = blk: {
                if (config.flags.MCO2Config and check_MCU("CodegenConfigPeriph")) {
                    const item: MCO2EnableList = .true;
                    break :blk item;
                }
                const item: MCO2EnableList = .false;
                break :blk item;
            };
            const LSCOEnableValue: ?LSCOEnableList = blk: {
                if (config.flags.LSCOConfig and check_MCU("CodegenConfigPeriph")) {
                    const item: LSCOEnableList = .true;
                    break :blk item;
                }
                const item: LSCOEnableList = .false;
                break :blk item;
            };
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and config.flags.RTC_Used)) {
                    const conf_item = config.EnableCSSLSE;
                    if (conf_item) |item| {
                        switch (item) {
                            .true => RCC_LSECSS_ENABLED = true,
                            .false => {},
                        }
                    }

                    break :blk conf_item orelse .false;
                }
                const item: EnableCSSLSEList = .false;
                const conf_item = config.EnableCSSLSE;
                if (conf_item) |i| {
                    if (item != i) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "EnableCSSLSE", "Else", "No Extra Log", "false", i });
                    }
                }
                break :blk item;
            };

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSI48RC = ClockNode{
                .name = "HSI48RC",
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

            var MSIRC = ClockNode{
                .name = "MSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSEOSC = ClockNode{
                .name = "LSEOSC",
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

            var RTCWkupOutput = ClockNode{
                .name = "RTCWkupOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var IWDGOutput = ClockNode{
                .name = "IWDGOutput",
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

            var LPUART1Mult = ClockNode{
                .name = "LPUART1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUART1output = ClockNode{
                .name = "LPUART1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1Mult = ClockNode{
                .name = "LPTIM1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1output = ClockNode{
                .name = "LPTIM1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM2Mult = ClockNode{
                .name = "LPTIM2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM2output = ClockNode{
                .name = "LPTIM2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUART2Mult = ClockNode{
                .name = "LPUART2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUART2output = ClockNode{
                .name = "LPUART2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM1Mult = ClockNode{
                .name = "TIM1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM1output = ClockNode{
                .name = "TIM1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM15Mult = ClockNode{
                .name = "TIM15Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM15output = ClockNode{
                .name = "TIM15output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCMult = ClockNode{
                .name = "ADCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGMult = ClockNode{
                .name = "RNGMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGoutput = ClockNode{
                .name = "RNGoutput",
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

            var MCOMult = ClockNode{
                .name = "MCOMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCODiv = ClockNode{
                .name = "MCODiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCOPin = ClockNode{
                .name = "MCOPin",
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

            var LSCOMult = ClockNode{
                .name = "LSCOMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSCOOutput = ClockNode{
                .name = "LSCOOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBPrescaler = ClockNode{
                .name = "AHBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var PWRCLKoutput = ClockNode{
                .name = "PWRCLKoutput",
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

            var APBPrescaler = ClockNode{
                .name = "APBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APBOutput = ClockNode{
                .name = "APBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescalerAPB = ClockNode{
                .name = "TimPrescalerAPB",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescOut1 = ClockNode{
                .name = "TimPrescOut1",
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

            var PLLPoutput = ClockNode{
                .name = "PLLPoutput",
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

            var PLLR = ClockNode{
                .name = "PLLR",
                .nodetype = .off,
                .parents = &.{},
            };

            const HSIRC_clk_value = HSI_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const HSI48RC_clk_value = HSI48_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSI48RC",
                "Else",
                "No Extra Log",
                "HSI48_VALUE",
            });
            HSI48RC.nodetype = .source;
            HSI48RC.value = HSI48RC_clk_value;

            const HSEOSC_clk_value = HSE_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const LSIRC_clk_value = LSI_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const MSIRC_clk_value = MSIClockRangeValValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSIRC",
                "Else",
                "No Extra Log",
                "MSIClockRangeVal",
            });
            MSIRC.nodetype = .source;
            MSIRC.value = MSIRC_clk_value.get();

            const LSEOSC_clk_value = LSE_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const SysClkSource_clk_value = SYSCLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &LSEOSC,
                &MSIRC,
                &HSIRC,
                &HSEOSC,
                &PLLR,
                &LSIRC,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};

            const PLLSource_clk_value = PLLSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &MSIRC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            const PLLM_clk_value = PLLMValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            PLLM.value = PLLM_clk_value.get();
            PLLM.parents = &.{&PLLSource};
            if (check_ref(@TypeOf(EnableHSERTCDevisorValue), EnableHSERTCDevisorValue, .true, .@"=") or
                check_ref(@TypeOf(EnableHSELCDDevisorValue), EnableHSELCDDevisorValue, .true, .@"="))
            {
                const HSERTCDevisor_clk_value = RCC_RTC_Clock_Source_FROM_HSEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                HSERTCDevisor.value = HSERTCDevisor_clk_value;
                HSERTCDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"="))
            {
                const RTCClkSource_clk_value = RTCClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(EnableRTCWKUPValue), EnableRTCWKUPValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RTCWUPFreq_ValueValue);
                RTCWkupOutput.nodetype = .output;
                RTCWkupOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                const USART1Mult_clk_value = USART1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
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
                const USART2Mult_clk_value = USART2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
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
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                const LPUART1Mult_clk_value = LPUART1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUART1Mult",
                    "Else",
                    "No Extra Log",
                    "LPUART1CLockSelection",
                });
                const LPUART1Multparents = [_]*const ClockNode{
                    &APBPrescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                LPUART1Mult.nodetype = .multi;
                LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUART1Freq_ValueValue);
                LPUART1output.nodetype = .output;
                LPUART1output.parents = &.{&LPUART1Mult};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                const LPTIM1Mult_clk_value = LPTIM1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
                    &LSIRC,
                    &LSEOSC,
                    &HSIRC,
                };
                LPTIM1Mult.nodetype = .multi;
                LPTIM1Mult.parents = &.{LPTIM1Multparents[LPTIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM1Freq_ValueValue);
                LPTIM1output.nodetype = .output;
                LPTIM1output.parents = &.{&LPTIM1Mult};
            }
            if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                const LPTIM2Mult_clk_value = LPTIM2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM2Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM2CLockSelection",
                });
                const LPTIM2Multparents = [_]*const ClockNode{
                    &APBPrescaler,
                    &LSIRC,
                    &LSEOSC,
                    &HSIRC,
                };
                LPTIM2Mult.nodetype = .multi;
                LPTIM2Mult.parents = &.{LPTIM2Multparents[LPTIM2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM2Freq_ValueValue);
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(LPUART2EnableValue), LPUART2EnableValue, .true, .@"=")) {
                const LPUART2Mult_clk_value = LPUART2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUART2Mult",
                    "Else",
                    "No Extra Log",
                    "LPUART2CLockSelection",
                });
                const LPUART2Multparents = [_]*const ClockNode{
                    &APBPrescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                LPUART2Mult.nodetype = .multi;
                LPUART2Mult.parents = &.{LPUART2Multparents[LPUART2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART2EnableValue), LPUART2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUART2Freq_ValueValue);
                LPUART2output.nodetype = .output;
                LPUART2output.parents = &.{&LPUART2Mult};
            }
            if (check_ref(@TypeOf(TIM1EnableValue), TIM1EnableValue, .true, .@"=")) {
                const TIM1Mult_clk_value = TIM1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIM1Mult",
                    "Else",
                    "No Extra Log",
                    "TIM1CLockSelection",
                });
                const TIM1Multparents = [_]*const ClockNode{
                    &TimPrescalerAPB,
                    &PLLQ,
                };
                TIM1Mult.nodetype = .multi;
                TIM1Mult.parents = &.{TIM1Multparents[TIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(TIM1EnableValue), TIM1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(TIM1Freq_ValueValue);
                TIM1output.limit = TIM1Freq_ValueLimit;
                TIM1output.nodetype = .output;
                TIM1output.parents = &.{&TIM1Mult};
            }
            if (check_ref(@TypeOf(TIM15EnableValue), TIM15EnableValue, .true, .@"=")) {
                const TIM15Mult_clk_value = TIM15CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIM15Mult",
                    "Else",
                    "No Extra Log",
                    "TIM15CLockSelection",
                });
                const TIM15Multparents = [_]*const ClockNode{
                    &TimPrescalerAPB,
                    &PLLQ,
                };
                TIM15Mult.nodetype = .multi;
                TIM15Mult.parents = &.{TIM15Multparents[TIM15Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(TIM15EnableValue), TIM15EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(TIM15Freq_ValueValue);
                TIM15output.limit = TIM15Freq_ValueLimit;
                TIM15output.nodetype = .output;
                TIM15output.parents = &.{&TIM15Mult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const ADCMult_clk_value = ADCCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADCMult",
                    "Else",
                    "No Extra Log",
                    "ADCCLockSelection",
                });
                const ADCMultparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &HSIRC,
                    &PLLP,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                ADCoutput.limit = ADCFreq_ValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const RNGMult_clk_value = RNGCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RNGMult",
                    "Else",
                    "No Extra Log",
                    "RNGCLockSelection",
                });
                const RNGMultparents = [_]*const ClockNode{
                    &MSIRC,
                    &PLLQ,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&RNGoutput};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                const I2C1Mult_clk_value = I2C1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
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
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                const I2C3Mult_clk_value = I2C3CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
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
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCOMult_clk_value = RCC_MCO1SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCOMult",
                    "Else",
                    "No Extra Log",
                    "RCC_MCO1Source",
                });
                const MCOMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &LSIRC,
                    &SysCLKOutput,
                    &HSEOSC,
                    &HSIRC,
                    &HSI48RC,
                    &PLLR,
                    &MSIRC,
                    &RTCClkSource,
                    &RTCWkupOutput,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCODiv_clk_value = RCC_MCODivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCODiv",
                    "Else",
                    "No Extra Log",
                    "RCC_MCODiv",
                });
                MCODiv.nodetype = .div;
                MCODiv.value = MCODiv_clk_value.get();
                MCODiv.parents = &.{&MCOMult};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                const MCO2Mult_clk_value = RCC_MCO2SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &LSEOSC,
                    &LSIRC,
                    &SysCLKOutput,
                    &HSEOSC,
                    &HSIRC,
                    &HSI48RC,
                    &PLLR,
                    &MSIRC,
                    &RTCClkSource,
                    &RTCWkupOutput,
                };
                MCO2Mult.nodetype = .multi;
                MCO2Mult.parents = &.{MCO2Multparents[MCO2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                const MCO2Div_clk_value = RCC_MCO2DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO2Div",
                    "Else",
                    "No Extra Log",
                    "RCC_MCO2Div",
                });
                MCO2Div.nodetype = .div;
                MCO2Div.value = MCO2Div_clk_value.get();
                MCO2Div.parents = &.{&MCO2Mult};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO2PinFreq_ValueValue);
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                const LSCOMult_clk_value = LSCOSource1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSCOMult",
                    "Else",
                    "No Extra Log",
                    "LSCOSource1",
                });
                const LSCOMultparents = [_]*const ClockNode{
                    &LSIRC,
                    &LSEOSC,
                };
                LSCOMult.nodetype = .multi;
                LSCOMult.parents = &.{LSCOMultparents[LSCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LSCOPinFreq_ValueValue);
                LSCOOutput.nodetype = .output;
                LSCOOutput.parents = &.{&LSCOMult};
            }

            const AHBPrescaler_clk_value = AHBCLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            std.mem.doNotOptimizeAway(PWRFreq_ValueValue);
            PWRCLKoutput.limit = PWRFreq_ValueLimit;
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.limit = AHBFreq_ValueLimit;
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};

            const CortexPrescaler_clk_value = Cortex_DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            CortexSysOutput.limit = CortexFreq_ValueLimit;
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
            FCLKCortexOutput.limit = FCLKCortexFreq_ValueLimit;
            FCLKCortexOutput.nodetype = .output;
            FCLKCortexOutput.parents = &.{&AHBOutput};

            const APBPrescaler_clk_value = APB1CLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APBPrescaler",
                "Else",
                "No Extra Log",
                "APB1CLKDivider",
            });
            APBPrescaler.nodetype = .div;
            APBPrescaler.value = APBPrescaler_clk_value.get();
            APBPrescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APBFreq_ValueValue);
            APBOutput.limit = APBFreq_ValueLimit;
            APBOutput.nodetype = .output;
            APBOutput.parents = &.{&APBPrescaler};

            const TimPrescalerAPB_clk_value = APB1TimCLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimPrescalerAPB",
                "Else",
                "No Extra Log",
                "APB1TimCLKDivider",
            });
            TimPrescalerAPB.nodetype = .mul;
            TimPrescalerAPB.value = TimPrescalerAPB_clk_value;
            TimPrescalerAPB.parents = &.{&APBPrescaler};

            std.mem.doNotOptimizeAway(APBTimFreq_ValueValue);
            TimPrescOut1.nodetype = .output;
            TimPrescOut1.parents = &.{&TimPrescalerAPB};

            const PLLN_clk_value = PLLNValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const PLLP_clk_value = PLLPValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PLLPoutputFreq_ValueValue);
                PLLPoutput.limit = PLLPoutputFreq_ValueLimit;
                PLLPoutput.nodetype = .output;
                PLLPoutput.parents = &.{&PLLP};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(TIM1EnableValue), TIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(TIM15EnableValue), TIM15EnableValue, .true, .@"="))
            {
                const PLLQ_clk_value = PLLQValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                PLLQ.value = PLLQ_clk_value.get();
                PLLQ.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(TIM1EnableValue), TIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(TIM15EnableValue), TIM15EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLQoutputFreq_ValueValue);
                PLLQoutput.limit = PLLQoutputFreq_ValueLimit;
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLLQ};
            }

            const PLLR_clk_value = PLLRValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLR",
                "Else",
                "No Extra Log",
                "PLLR",
            });
            PLLR.nodetype = .div;
            PLLR.value = PLLR_clk_value.get();
            PLLR.parents = &.{&PLLN};

            out.HSIRC = try HSIRC.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.PLLM = try PLLM.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCWkupOutput = try RTCWkupOutput.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART2output = try USART2output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPUART2Mult = try LPUART2Mult.get_output();
            out.LPUART2output = try LPUART2output.get_output();
            out.TIM1Mult = try TIM1Mult.get_output();
            out.TIM1output = try TIM1output.get_output();
            out.TIM15Mult = try TIM15Mult.get_output();
            out.TIM15output = try TIM15output.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APBPrescaler = try APBPrescaler.get_output();
            out.APBOutput = try APBOutput.get_output();
            out.TimPrescalerAPB = try TimPrescalerAPB.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLLR = try PLLR.get_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.MSIClockRangeVal = MSIClockRangeValValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.LPUART2CLockSelection = LPUART2CLockSelectionValue;
            ref_out.TIM1CLockSelection = TIM1CLockSelectionValue;
            ref_out.TIM15CLockSelection = TIM15CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCO2Div = RCC_MCO2DivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLP = PLLPValue;
            ref_out.PLLQ = PLLQValue;
            ref_out.PLLR = PLLRValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.MSIAutoCalibration = MSIAutoCalibrationValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.SYSCLKFreq_VALUE1 = SYSCLKFreq_VALUE1Value;
            ref_out.SYSCLKFreq_VALUE2 = SYSCLKFreq_VALUE2Value;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.EnableHSELCDDevisor = EnableHSELCDDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.EnableRTCWKUP = EnableRTCWKUPValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.LPUART2Enable = LPUART2EnableValue;
            ref_out.TIM1Enable = TIM1EnableValue;
            ref_out.TIM15Enable = TIM15EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.MCO2Enable = MCO2EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.MSIUsed = MSIUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.PLLUsed = PLLUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
