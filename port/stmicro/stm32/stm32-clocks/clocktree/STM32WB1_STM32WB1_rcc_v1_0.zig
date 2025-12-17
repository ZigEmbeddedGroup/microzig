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
const round = clock.round;

pub const LSISource1List = enum {
    RCC_LSCOSOURCE_LSI1,
    RCC_LSCOSOURCE_LSI2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LSCOSOURCE_LSI1 => 0,
            .RCC_LSCOSOURCE_LSI2 => 1,
        };
    }
};
pub const HCLKRFclockSelectionList = enum {
    RCC_HCLKRFCLKSOURCE_HSE,
    RCC_HCLKRFCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_HCLKRFCLKSOURCE_HSE => 0,
            .RCC_HCLKRFCLKSOURCE_HSI => 1,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK1,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_LSI => 1,
            .RCC_LPTIM1CLKSOURCE_HSI => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
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
pub const SYSCLKSourceList = enum {
    RCC_SYSCLKSOURCE_MSI,
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_MSI => 0,
            .RCC_SYSCLKSOURCE_HSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
            .RCC_SYSCLKSOURCE_PLLCLK => 3,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_MSI,
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_MSI => 0,
            .RCC_PLLSOURCE_HSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
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
pub const SMPSCLockSelectionList = enum {
    RCC_SMPSCLKSOURCE_MSI,
    RCC_SMPSCLKSOURCE_HSE,
    RCC_SMPSCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SMPSCLKSOURCE_MSI => 0,
            .RCC_SMPSCLKSOURCE_HSE => 1,
            .RCC_SMPSCLKSOURCE_HSI => 2,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_HSI,
    RCC_LPTIM2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK => 0,
            .RCC_LPTIM2CLKSOURCE_LSI => 1,
            .RCC_LPTIM2CLKSOURCE_HSI => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
        };
    }
};
pub const RFWKPClockSelectionList = enum {
    RCC_RFWKPCLKSOURCE_HSE_DIV1024,
    RCC_RFWKPCLKSOURCE_LSE,
    RCC_RFWKPCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RFWKPCLKSOURCE_HSE_DIV1024 => 0,
            .RCC_RFWKPCLKSOURCE_LSE => 1,
            .RCC_RFWKPCLKSOURCE_LSI => 2,
        };
    }
};
pub const CK48CLockSelectionList = enum {
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_MSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL => 0,
            .RCC_USBCLKSOURCE_MSI => 1,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_CLK48,
    RCC_RNGCLKSOURCE_LSI,
    RCC_RNGCLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_CLK48 => 0,
            .RCC_RNGCLKSOURCE_LSI => 1,
            .RCC_RNGCLKSOURCE_LSE => 2,
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
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_HSI,
    RCC_ADCCLKSOURCE_PLL,
    RCC_ADCCLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_HSI => 0,
            .RCC_ADCCLKSOURCE_PLL => 1,
            .RCC_ADCCLKSOURCE_SYSCLK => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI1,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI1 => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLLCLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_MSI => 6,
        };
    }
};
pub const MSIClockRangeList = enum {
    RCC_MSIRANGE_0,
    RCC_MSIRANGE_1,
    RCC_MSIRANGE_2,
    RCC_MSIRANGE_3,
    RCC_MSIRANGE_4,
    RCC_MSIRANGE_5,
    RCC_MSIRANGE_6,
    RCC_MSIRANGE_7,
    RCC_MSIRANGE_8,
    RCC_MSIRANGE_9,
    RCC_MSIRANGE_10,
    RCC_MSIRANGE_11,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSIRANGE_0 => 100000,
            .RCC_MSIRANGE_1 => 200000,
            .RCC_MSIRANGE_2 => 400000,
            .RCC_MSIRANGE_3 => 800000,
            .RCC_MSIRANGE_4 => 1000000,
            .RCC_MSIRANGE_5 => 2000000,
            .RCC_MSIRANGE_6 => 4000000,
            .RCC_MSIRANGE_7 => 8000000,
            .RCC_MSIRANGE_8 => 16000000,
            .RCC_MSIRANGE_9 => 24000000,
            .RCC_MSIRANGE_10 => 32000000,
            .RCC_MSIRANGE_11 => 48000000,
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
pub const SMPSDividerList = enum {
    @"1",
    @"2",
    @"3",
    @"4",
    @"6",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"1" => 1,
            .@"2" => 2,
            .@"3" => 3,
            .@"4" => 4,
            .@"6" => 6,
        };
    }
};
pub const SMPSFreq_ValueList = enum {
    @"4000000",
    @"8000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"4000000" => 4000000,
            .@"8000000" => 8000000,
        };
    }
};
pub const RCC_MCODivList = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_4,
    RCC_MCODIV_8,
    RCC_MCODIV_16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_16 => 16,
        };
    }
};
pub const AHB3CLKDividerList = enum {
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
pub const AHB2CLKDividerList = enum {
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
pub const Cortex2_DivList = enum {
    SYSTICK_CLKSOURCE_HCLK,
    SYSTICK_CLKSOURCE_HCLK_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .SYSTICK_CLKSOURCE_HCLK => 1,
            .SYSTICK_CLKSOURCE_HCLK_DIV8 => 8,
        };
    }
};
pub const Cortex2Freq_ValueList = enum {
    @"32000000",
    @"4000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"32000000" => 32000000,
            .@"4000000" => 4000000,
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
pub const SMPS1Freq_ValueList = enum {
    @"8000000",
    @"16000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"8000000" => 8000000,
            .@"16000000" => 16000000,
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
    FLASH_LATENCY_3,
};
pub const MSIAutoCalibrationList = enum {
    DISABLED,
    ENABLED,
};
pub const MSIOscStateList = enum {
    DISABLED,
    ENABLED,
};
pub const HSIOscStateList = enum {
    DISABLED,
    ENABLED,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const LSIEnableList = enum {
    true,
    false,
};
pub const EnableHSERFDevisorList = enum {
    true,
    false,
};
pub const EnableHCLKRList = enum {
    auto,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
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
pub const IWDGEnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const SMPSEnableList = enum {
    false,
    true,
};
pub const SMPSDivEnableList = enum {
    false,
    true,
};
pub const LPTIM2EnableList = enum {
    true,
    false,
};
pub const RFEnableList = enum {
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
pub const ADCEnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const EnableCSSLSEList = enum {
    true,
    false,
};
pub const Cortex2Freq_ValueUnion = union(enum) {
    float: f32,
    list: Cortex2Freq_ValueList,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEOscillator: bool = false,
            LSEOscillator: bool = false,
            HSEByPass: bool = false,
            LSEByPass: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            RFUsed_ForRCC: bool = false,
            SAI1Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            RNGUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            LCDUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC3: bool = false,
            ADC3UsedAsynchronousCLK_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            MSIOscState: ?MSIOscStateList = null,
            HSIOscState: ?HSIOscStateList = null,
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            MSIAutoCalibration: ?MSIAutoCalibrationList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSISource1: ?LSISource1List = null,
            LSE_VALUE: ?f32 = null,
            MSIClockRange: ?MSIClockRangeList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LSCOSource1: ?LSCOSource1List = null,
            HSEPRES: ?u32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?PLLMList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            SMPSCLockSelection: ?SMPSCLockSelectionList = null,
            SMPSDivider: ?SMPSDividerList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            RFWKPClockSelection: ?RFWKPClockSelectionList = null,
            CK48CLockSelection: ?CK48CLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            AHB3CLKDivider: ?AHB3CLKDividerList = null,
            AHB2CLKDivider: ?AHB2CLKDividerList = null,
            Cortex2_Div: ?Cortex2_DivList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
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
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSI2RC: f32 = 0,
            LSIMult: f32 = 0,
            LSEOSC: f32 = 0,
            MSIRC: f32 = 0,
            HCLKRFMultDiv: f32 = 0,
            HCLKRFMult: f32 = 0,
            HCLKRFOutput: f32 = 0,
            APB3Output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            HSEPRESC: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            LCDOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            SMPSMult: f32 = 0,
            SMPSDivider: f32 = 0,
            SMPSDiv2: f32 = 0,
            SMPSoutput: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            HSERFWKPDevisor: f32 = 0,
            RFWKPClkSource: f32 = 0,
            RFWKPOutput: f32 = 0,
            CK48Mult: f32 = 0,
            RNGDiv: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            AHB3Prescaler: f32 = 0,
            AHB3Output: f32 = 0,
            AHB2Prescaler: f32 = 0,
            FCLK2CortexOutput: f32 = 0,
            AHB2Output: f32 = 0,
            Cortex2Prescaler: f32 = 0,
            Cortex2SysOutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            PWRCLKoutput: f32 = 0,
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
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLPoutput: f32 = 0,
            PLLQ: f32 = 0,
            PLLQoutput: f32 = 0,
            PLLR: f32 = 0,
            LSI: f32 = 0,
            SMPSDivclk: f32 = 0,
            VCOInput: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI1_VALUE: ?f32 = null, //from RCC Clock Config
            LSI2_VALUE: ?f32 = null, //from RCC Clock Config
            LSISource1: ?LSISource1List = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            HCLKRFDiv: ?f32 = null, //from RCC Clock Config
            HCLKRFclockSelection: ?HCLKRFclockSelectionList = null, //from extra RCC references
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            HSEPRES: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?PLLMList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            SMPSCLockSelection: ?SMPSCLockSelectionList = null, //from extra RCC references
            SMPSDivider: ?SMPSDividerList = null, //from RCC Clock Config
            SMPSDiv2: ?f32 = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            RCC_RFWKP_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RFWKPClockSelection: ?RFWKPClockSelectionList = null, //from RCC Clock Config
            CK48CLockSelection: ?CK48CLockSelectionList = null, //from RCC Clock Config
            RNGDiv: ?f32 = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            AHB3CLKDivider: ?AHB3CLKDividerList = null, //from RCC Clock Config
            AHB2CLKDivider: ?AHB2CLKDividerList = null, //from RCC Clock Config
            Cortex2_Div: ?Cortex2_DivList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
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
            MSIAutoCalibration: ?MSIAutoCalibrationList = null, //from RCC Advanced Config
            MSIOscState: ?MSIOscStateList = null, //from RCC Advanced Config
            HSIOscState: ?HSIOscStateList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            EnableHSERFDevisor: ?EnableHSERFDevisorList = null, //from extra RCC references
            EnableHCLKR: ?EnableHCLKRList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            EnableHSELCDDevisor: ?EnableHSELCDDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            SMPSEnable: ?SMPSEnableList = null, //from extra RCC references
            SMPSDivEnable: ?SMPSDivEnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            RFEnable: ?RFEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            MSIUsed: ?f32 = null, //from extra RCC references
            MSIUsedForSys: ?f32 = null, //from extra RCC references
            HSIUsedForSys: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
        };

        pub const Tree_Output = struct {
            clock: Clock_Output,
            config: Config_Output,
        };

        fn check_MCU(comptime to_check: []const u8) bool {
            return mcu_data.get(to_check) != null;
        }
        pub fn get_clocks(config: Config) anyerror!Tree_Output {
            if (@inComptime()) @setEvalBranchQuota(10000);
            var out = Clock_Output{};
            var ref_out = Config_Output{};
            ref_out.flags = config.flags;

            //Semaphores flags

            var LSISourceLSI1: bool = false;
            var LSISourceLSI2: bool = false;
            var HCLKRFSourceHSE: bool = false;
            var HCLKRFSourceHSI: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var USART1SourcePCLK2: bool = false;
            var USART1SourceSys: bool = false;
            var USART1SourceHSI: bool = false;
            var USART1SourceLSE: bool = false;
            var LPUART1SourcePCLK1: bool = false;
            var LPUART1SourceSys: bool = false;
            var LPUART1SourceHSI: bool = false;
            var LPUART1SourceLSE: bool = false;
            var SMPSSourceMSI: bool = false;
            var SMPSSourceHSE: bool = false;
            var SMPSSourceHSI: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2SOURCEHSI: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var RFWKPSourceHSE: bool = false;
            var RFWKPSourceLSE: bool = false;
            var RFWKPSourceLSI: bool = false;
            var CK48SourcePLLCLK: bool = false;
            var CK48SourceMSI: bool = false;
            var RNGCLKSOURCE_CLK48: bool = false;
            var RNGCLKSOURCE_LSI: bool = false;
            var RNGCLKSOURCE_LSE: bool = false;
            var I2C1SourcePCLK1: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var ADCSourceHSI: bool = false;
            var ADCSourcePLL: bool = false;
            var ADCSourceSys: bool = false;
            var MCOSourceLSE: bool = false;
            var MCOSourceLSI: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceHSI: bool = false;
            var MCOSourcePLL: bool = false;
            var MCOSourcesys: bool = false;
            var MCOSourceMSI: bool = false;
            var MSIRANGE_0: bool = false;
            var MSIRANGE_1: bool = false;
            var MSIRANGE_2: bool = false;
            var MSIRANGE_3: bool = false;
            var MSIRANGE_4: bool = false;
            var MSIRANGE_5: bool = false;
            var MSIRANGE_6: bool = false;
            var MSIRANGE_7: bool = false;
            var MSIRANGE_8: bool = false;
            var MSIRANGE_9: bool = false;
            var MSIRANGE_10: bool = false;
            var MSIRANGE_11: bool = false;
            var HCLKDiv1: bool = false;
            var MSIAutoCalibrationON: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;

            //Clock node bases

            const dummy = ClockNode{
                .name = "dummy_clock",
                .nodetype = .off,
                .parents = &.{},
            };
            std.mem.doNotOptimizeAway(dummy);

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

            var LSI2RC = ClockNode{
                .name = "LSI2RC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIMult = ClockNode{
                .name = "LSIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSEOSC = ClockNode{
                .name = "LSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSIRC = ClockNode{
                .name = "MSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLKRFMultDiv = ClockNode{
                .name = "HCLKRFMultDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLKRFMult = ClockNode{
                .name = "HCLKRFMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLKRFOutput = ClockNode{
                .name = "HCLKRFOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3Output = ClockNode{
                .name = "APB3Output",
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

            var HSEPRESC = ClockNode{
                .name = "HSEPRESC",
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

            var LCDOutput = ClockNode{
                .name = "LCDOutput",
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

            var SMPSMult = ClockNode{
                .name = "SMPSMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SMPSDivider = ClockNode{
                .name = "SMPSDivider",
                .nodetype = .off,
                .parents = &.{},
            };

            var SMPSDiv2 = ClockNode{
                .name = "SMPSDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var SMPSoutput = ClockNode{
                .name = "SMPSoutput",
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

            var HSERFWKPDevisor = ClockNode{
                .name = "HSERFWKPDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var RFWKPClkSource = ClockNode{
                .name = "RFWKPClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var RFWKPOutput = ClockNode{
                .name = "RFWKPOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CK48Mult = ClockNode{
                .name = "CK48Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGDiv = ClockNode{
                .name = "RNGDiv",
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

            var AHB3Prescaler = ClockNode{
                .name = "AHB3Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB3Output = ClockNode{
                .name = "AHB3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB2Prescaler = ClockNode{
                .name = "AHB2Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var FCLK2CortexOutput = ClockNode{
                .name = "FCLK2CortexOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB2Output = ClockNode{
                .name = "AHB2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var Cortex2Prescaler = ClockNode{
                .name = "Cortex2Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var Cortex2SysOutput = ClockNode{
                .name = "Cortex2SysOutput",
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

            var LSI = ClockNode{
                .name = "LSI",
                .nodetype = .off,
                .parents = &.{},
            };

            var SMPSDivclk = ClockNode{
                .name = "SMPSDivclk",
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
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 32000000;
            const LSI1_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const LSI2_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const LSISource1Value: ?LSISource1List = blk: {
                const conf_item = config.LSISource1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_LSI1 => LSISourceLSI1 = true,
                        .RCC_LSCOSOURCE_LSI2 => LSISourceLSI2 = true,
                    }
                }

                break :blk conf_item orelse {
                    LSISourceLSI1 = true;
                    break :blk .RCC_LSCOSOURCE_LSI1;
                };
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const MSIClockRangeValue: ?MSIClockRangeList = blk: {
                const conf_item = config.MSIClockRange;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSIRANGE_0 => MSIRANGE_0 = true,
                        .RCC_MSIRANGE_1 => MSIRANGE_1 = true,
                        .RCC_MSIRANGE_2 => MSIRANGE_2 = true,
                        .RCC_MSIRANGE_3 => MSIRANGE_3 = true,
                        .RCC_MSIRANGE_4 => MSIRANGE_4 = true,
                        .RCC_MSIRANGE_5 => MSIRANGE_5 = true,
                        .RCC_MSIRANGE_6 => MSIRANGE_6 = true,
                        .RCC_MSIRANGE_7 => MSIRANGE_7 = true,
                        .RCC_MSIRANGE_8 => MSIRANGE_8 = true,
                        .RCC_MSIRANGE_9 => MSIRANGE_9 = true,
                        .RCC_MSIRANGE_10 => MSIRANGE_10 = true,
                        .RCC_MSIRANGE_11 => MSIRANGE_11 = true,
                    }
                }

                break :blk conf_item orelse {
                    MSIRANGE_6 = true;
                    break :blk .RCC_MSIRANGE_6;
                };
            };
            const HCLKRFDivValue: ?f32 = blk: {
                break :blk 2;
            };
            const HCLKRFclockSelectionValue: ?HCLKRFclockSelectionList = blk: {
                if ((config.flags.HSEByPass or config.flags.HSEOscillator)) {
                    HCLKRFSourceHSE = true;
                    const item: HCLKRFclockSelectionList = .RCC_HCLKRFCLKSOURCE_HSE;
                    break :blk item;
                }
                HCLKRFSourceHSI = true;
                const item: HCLKRFclockSelectionList = .RCC_HCLKRFCLKSOURCE_HSI;
                break :blk item;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK1;
            };
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                const conf_item = config.LSCOSource1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_LSI => LSCOSSourceLSI = true,
                        .RCC_LSCOSOURCE_LSE => LSCOSSourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    LSCOSSourceLSI = true;
                    break :blk .RCC_LSCOSOURCE_LSI;
                };
            };
            const HSEPRESValue: ?f32 = blk: {
                const config_val = config.HSEPRES;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSEPRES",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSEPRES",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_MSI => SysSourceMSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourcePLL = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceMSI = true;
                    break :blk .RCC_SYSCLKSOURCE_MSI;
                };
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_MSI => {},
                        .RCC_PLLSOURCE_HSI => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_MSI;
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
                        .RCC_RTCCLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTCCLKSOURCE_LSI => RTCSourceLSI = true,
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => RTCSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    RTCSourceLSI = true;
                    break :blk .RCC_RTCCLKSOURCE_LSI;
                };
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

                break :blk conf_item orelse {
                    LPUART1SourcePCLK1 = true;
                    break :blk .RCC_LPUART1CLKSOURCE_PCLK1;
                };
            };
            const SMPSDiv2Value: ?f32 = blk: {
                break :blk 2;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK => {},
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                        .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK;
            };
            const RCC_RFWKP_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 1024;
            };
            const RFWKPClockSelectionValue: ?RFWKPClockSelectionList = blk: {
                const conf_item = config.RFWKPClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RFWKPCLKSOURCE_LSE => RFWKPSourceLSE = true,
                        .RCC_RFWKPCLKSOURCE_HSE_DIV1024 => RFWKPSourceHSE = true,
                        .RCC_RFWKPCLKSOURCE_LSI => RFWKPSourceLSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RFWKPSourceLSI = true;
                    break :blk .RCC_RFWKPCLKSOURCE_LSI;
                };
            };
            const CK48CLockSelectionValue: ?CK48CLockSelectionList = blk: {
                const conf_item = config.CK48CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL => CK48SourcePLLCLK = true,
                        .RCC_USBCLKSOURCE_MSI => CK48SourceMSI = true,
                    }
                }

                break :blk conf_item orelse {
                    CK48SourceMSI = true;
                    break :blk .RCC_USBCLKSOURCE_MSI;
                };
            };
            const RNGDivValue: ?f32 = blk: {
                break :blk 3;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_CLK48 => RNGCLKSOURCE_CLK48 = true,
                        .RCC_RNGCLKSOURCE_LSI => RNGCLKSOURCE_LSI = true,
                        .RCC_RNGCLKSOURCE_LSE => RNGCLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse {
                    RNGCLKSOURCE_LSI = true;
                    break :blk .RCC_RNGCLKSOURCE_LSI;
                };
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
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                if (!check_MCU("STM32WBx0_Value_Line")) {
                    const conf_item = config.ADCCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_ADCCLKSOURCE_HSI => ADCSourceHSI = true,
                            .RCC_ADCCLKSOURCE_PLL => ADCSourcePLL = true,
                            .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        }
                    }

                    break :blk conf_item orelse {
                        ADCSourceHSI = true;
                        break :blk .RCC_ADCCLKSOURCE_HSI;
                    };
                } else if (check_MCU("STM32WBx0_Value_Line")) {
                    const conf_item = config.ADCCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_ADCCLKSOURCE_PLL => ADCSourcePLL = true,
                            .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_ADCCLKSOURCE_PLL
                                    \\ - RCC_ADCCLKSOURCE_SYSCLK
                                , .{ "ADCCLockSelection", "STM32WBx0_Value_Line", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        ADCSourceSys = true;
                        break :blk .RCC_ADCCLKSOURCE_SYSCLK;
                    };
                }
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => MCOSourcesys = true,
                        .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                        .RCC_MCO1SOURCE_MSI => MCOSourceMSI = true,
                        .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                        .RCC_MCO1SOURCE_PLLCLK => MCOSourcePLL = true,
                        .RCC_MCO1SOURCE_LSE => MCOSourceLSE = true,
                        .RCC_MCO1SOURCE_LSI1 => MCOSourceLSI = true,
                    }
                }

                break :blk conf_item orelse {
                    MCOSourcesys = true;
                    break :blk .RCC_MCO1SOURCE_SYSCLK;
                };
            };
            const RCC_MCODivValue: ?RCC_MCODivList = blk: {
                const conf_item = config.RCC_MCODiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCODIV_1 => {},
                        .RCC_MCODIV_2 => {},
                        .RCC_MCODIV_4 => {},
                        .RCC_MCODIV_8 => {},
                        .RCC_MCODIV_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const AHB3CLKDividerValue: ?AHB3CLKDividerList = blk: {
                const conf_item = config.AHB3CLKDivider;
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
            const AHB2CLKDividerValue: ?AHB2CLKDividerList = blk: {
                const conf_item = config.AHB2CLKDivider;
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
            const Cortex2_DivValue: ?Cortex2_DivList = blk: {
                const conf_item = config.Cortex2_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .SYSTICK_CLKSOURCE_HCLK => {},
                        .SYSTICK_CLKSOURCE_HCLK_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .SYSTICK_CLKSOURCE_HCLK;
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
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
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
            const APB2TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 6) {
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
                            6,
                            val,
                        });
                    }
                    if (val > 127) {
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
                            127,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 8;
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
                    }
                }

                break :blk conf_item orelse .RCC_PLLP_DIV2;
            };
            const PLLQValue: ?PLLQList = blk: {
                const conf_item = config.PLLQ;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLQ_DIV2 => {},
                        .RCC_PLLQ_DIV3 => {},
                        .RCC_PLLQ_DIV4 => {},
                        .RCC_PLLQ_DIV5 => {},
                        .RCC_PLLQ_DIV6 => {},
                        .RCC_PLLQ_DIV7 => {},
                        .RCC_PLLQ_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLQ_DIV2;
            };
            const PLLRValue: ?PLLRList = blk: {
                const conf_item = config.PLLR;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLR_DIV2 => {},
                        .RCC_PLLR_DIV3 => {},
                        .RCC_PLLR_DIV4 => {},
                        .RCC_PLLR_DIV5 => {},
                        .RCC_PLLR_DIV6 => {},
                        .RCC_PLLR_DIV7 => {},
                        .RCC_PLLR_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLR_DIV2;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.65e0) {
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
                            1.65e0,
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

                break :blk conf_item orelse .@"1";
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
            var HSICalibrationValueValue: ?f32 = if (config.extra.HSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 16;
            var MSICalibrationValueValue: ?f32 = if (config.extra.MSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 0;
            const PLLUsedValue: ?f32 = blk: {
                if ((ADCSourcePLL and config.flags.USE_ADC1) or (SysSourcePLL) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig)) or (CK48SourcePLLCLK and ((config.flags.RNGUsed_ForRCC and RNGCLKSOURCE_CLK48)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIUsedValue: ?f32 = blk: {
                if (((check_MCU("CodegenConfigPeriph")) and SMPSSourceMSI) or (check_MCU("SEM2RCC_MSI_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or (CK48SourceMSI and ((config.flags.RNGUsed_ForRCC and RNGCLKSOURCE_CLK48))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig)) or (check_MCU("PLLSourceMSI") and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")))) {
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

                    break :blk conf_item orelse {
                        MSIAutoCalibrationON = true;
                        break :blk .ENABLED;
                    };
                }
                const item: MSIAutoCalibrationList = .DISABLED;
                const conf_item = config.extra.MSIAutoCalibration;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const MSIUsedForSysValue: ?f32 = blk: {
                if (((check_MCU("PLLSourceMSI")) and (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIOscStateValue: ?MSIOscStateList = blk: {
                if (((check_MCU("CodegenConfigPeriph")) and (check_ref(@TypeOf(MSIUsedForSysValue), MSIUsedForSysValue, 0, .@"="))) or ((check_MCU("CodegenConfigPeriph")) and (check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 0, .@"=")))) {
                    const conf_item = config.extra.MSIOscState;
                    if (conf_item) |item| {
                        switch (item) {
                            .DISABLED => {},
                            .ENABLED => {},
                        }
                    }

                    break :blk conf_item orelse .ENABLED;
                }
                const item: MSIOscStateList = .ENABLED;
                const conf_item = config.extra.MSIOscState;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "MSIOscState", "Else", "No Extra Log", "ENABLED", i });
                    }
                }
                break :blk item;
            };
            const HSIUsedForSysValue: ?f32 = blk: {
                if (((check_MCU("PLLSourceHSI")) and (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if (ADCSourceHSI and config.flags.USE_ADC1 or (HCLKRFSourceHSI) or ((check_MCU("CodegenConfigPeriph")) and SMPSSourceHSI) or (USART1SourceHSI and config.flags.USART1Used_ForRCC) or (LPUART1SourceHSI and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCEHSI and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCEHSI and config.flags.LPTIM2Used_ForRCC) or (I2C1SourceHSI and config.flags.I2C1Used_ForRCC) or (check_MCU("I2C3SourceHSI") and config.flags.I2C3Used_ForRCC) or ((check_MCU("PLLSourceHSI")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and ((((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig))))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIOscStateValue: ?HSIOscStateList = blk: {
                if (((check_MCU("CodegenConfigPeriph")) and (check_ref(@TypeOf(HSIUsedForSysValue), HSIUsedForSysValue, 0, .@"="))) or ((check_MCU("CodegenConfigPeriph")) and (check_ref(@TypeOf(HSIUsedValue), HSIUsedValue, 0, .@"=")))) {
                    const conf_item = config.extra.HSIOscState;
                    if (conf_item) |item| {
                        switch (item) {
                            .DISABLED => {},
                            .ENABLED => {},
                        }
                    }

                    break :blk conf_item orelse .ENABLED;
                }
                const item: HSIOscStateList = .ENABLED;
                const conf_item = config.extra.HSIOscState;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "HSIOscState", "Else", "No Extra Log", "ENABLED", i });
                    }
                }
                break :blk item;
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
                if ((config.flags.RNGUsed_ForRCC and RNGCLKSOURCE_LSE) or MSIAutoCalibrationON or (config.flags.RFUsed_ForRCC and RFWKPSourceLSE) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (LPUART1SourceLSE and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCELSE and config.flags.LPTIM2Used_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig)) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
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

                    break :blk conf_item orelse .RCC_LSEDRIVE_MEDIUMHIGH;
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
                if (check_MCU("CodegenConfigPeriph")) {
                    const item: LSIEnableList = .true;
                    break :blk item;
                }
                const item: LSIEnableList = .false;
                break :blk item;
            };
            const EnableHSERFDevisorValue: ?EnableHSERFDevisorList = blk: {
                if (((config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERFDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERFDevisorList = .false;
                break :blk item;
            };
            const EnableHCLKRValue: ?EnableHCLKRList = blk: {
                const item: EnableHCLKRList = .auto;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1Used_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const EnableHSELCDDevisorValue: ?EnableHSELCDDevisorList = blk: {
                if (config.flags.LCDUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSELCDDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSELCDDevisorList = .false;
                break :blk item;
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTCUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCDUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDGUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1Used_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUARTUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
                break :blk item;
            };
            const SMPSEnableValue: ?SMPSEnableList = blk: {
                if (check_MCU("CodegenConfigPeriph")) {
                    const item: SMPSEnableList = .false;
                    break :blk item;
                }
                const item: SMPSEnableList = .true;
                break :blk item;
            };
            const SMPSDivEnableValue: ?SMPSDivEnableList = blk: {
                if (check_MCU("CodegenConfigPeriph")) {
                    const item: SMPSDivEnableList = .false;
                    break :blk item;
                }
                const item: SMPSDivEnableList = .true;
                break :blk item;
            };
            const LPTIM2EnableValue: ?LPTIM2EnableList = blk: {
                if (config.flags.LPTIM2Used_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: LPTIM2EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM2EnableList = .false;
                break :blk item;
            };
            const RFEnableValue: ?RFEnableList = blk: {
                if (config.flags.RFUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: RFEnableList = .true;
                    break :blk item;
                }
                const item: RFEnableList = .false;
                break :blk item;
            };
            const RNGEnableValue: ?RNGEnableList = blk: {
                if (config.flags.RNGUsed_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: RNGEnableList = .true;
                    break :blk item;
                }
                const item: RNGEnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1Used_ForRCC and check_MCU("CodegenConfigPeriph")) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)) and check_MCU("CodegenConfigPeriph")) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig) and check_MCU("CodegenConfigPeriph")) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
                    const conf_item = config.extra.EnableCSSLSE;
                    if (conf_item) |item| {
                        switch (item) {
                            .true => RCC_LSECSS_ENABLED = true,
                            .false => {},
                        }
                    }

                    break :blk conf_item orelse .false;
                }
                const item: EnableCSSLSEList = .false;
                const conf_item = config.extra.EnableCSSLSE;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
            if (!check_MCU("STM32WBx0_Value_Line")) {
                const HSIRC_clk_value = HSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIRC",
                    "!STM32WBx0_Value_Line",
                    "No Extra Log",
                    "HSI_VALUE",
                });
                HSIRC.nodetype = .source;
                HSIRC.value = HSIRC_clk_value;
            } else if (check_MCU("STM32WBx0_Value_Line")) {
                const HSIRC_clk_value = HSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIRC",
                    "STM32WBx0_Value_Line",
                    "No Extra Log",
                    "HSI_VALUE",
                });
                HSIRC.nodetype = .source;
                HSIRC.value = HSIRC_clk_value;
            }

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
                if (check_MCU("STM32WB1MMCHx")) {
                    if (config.HSE_VALUE) |val| {
                        if (val != 3.2e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {e} found: {e}
                                \\note: some values are fixed depending on the clock configuration.
                                \\
                                \\
                            , .{
                                "HSE_VALUE",
                                "STM32WB1MMCHx",
                                "No Extra Log",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = 32000000;
                    break :blk null;
                } else if ((config.flags.HSEByPass or config.flags.HSEOscillator) and config.flags.RFUsed_ForRCC) {
                    if (config.HSE_VALUE) |val| {
                        if (val != 3.2e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {e} found: {e}
                                \\note: some values are fixed depending on the clock configuration.
                                \\
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass | HSEOscillator)  & RFUsed_ForRCC",
                                "HSE for RF",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = 32000000;
                    break :blk null;
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
                    if (val > 3.2e7) {
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
                            3.2e7,
                            val,
                        });
                    }
                }
                HSEOSC.value = config_val orelse 8000000;

                break :blk null;
            };

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
            if (check_MCU("STM32WB1MMCHx")) {
                const LSIRC_clk_value = LSI1_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIRC",
                    "STM32WB1MMCHx",
                    "No Extra Log",
                    "LSI1_VALUE",
                });
                LSIRC.nodetype = .source;
                LSIRC.value = LSIRC_clk_value;
            } else if (!check_MCU("STM32WB1MMCHx")) {
                const LSIRC_clk_value = LSI1_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIRC",
                    "!STM32WB1MMCHx",
                    "No Extra Log",
                    "LSI1_VALUE",
                });
                LSIRC.nodetype = .source;
                LSIRC.value = LSIRC_clk_value;
            }

            const LSI2RC_clk_value = LSI2_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "LSI2RC",
                "Else",
                "No Extra Log",
                "LSI2_VALUE",
            });
            LSI2RC.nodetype = .source;
            LSI2RC.value = LSI2RC_clk_value;
            if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                const LSIMult_clk_value = LSISource1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIMult",
                    "Else",
                    "No Extra Log",
                    "LSISource1",
                });
                const LSIMultparents = [_]*const ClockNode{
                    &LSIRC,
                    &LSI2RC,
                };
                LSIMult.nodetype = .multi;
                LSIMult.parents = &.{LSIMultparents[LSIMult_clk_value.get()]};
            }

            //POST CLOCK REF LSE_VALUE VALUE
            _ = blk: {
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
                    LSEOSC.value = 32768;
                    break :blk null;
                }
                const config_val = config.LSE_VALUE;
                if (config_val) |val| {
                    if (val < 1e3) {
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
                            1e3,
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
                LSEOSC.value = config_val orelse 32768;

                break :blk null;
            };

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

            const MSIRC_clk_value = MSIClockRangeValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSIRC",
                "Else",
                "No Extra Log",
                "MSIClockRange",
            });
            MSIRC.nodetype = .source;
            MSIRC.value = MSIRC_clk_value.get();
            if (check_ref(@TypeOf(EnableHSERFDevisorValue), EnableHSERFDevisorValue, .true, .@"=")) {
                const HCLKRFMultDiv_clk_value = HCLKRFDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HCLKRFMultDiv",
                    "Else",
                    "No Extra Log",
                    "HCLKRFDiv",
                });
                HCLKRFMultDiv.nodetype = .div;
                HCLKRFMultDiv.value = HCLKRFMultDiv_clk_value;
                HCLKRFMultDiv.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(EnableHCLKRValue), EnableHCLKRValue, .auto, .@"=")) {
                const HCLKRFMult_clk_value = HCLKRFclockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HCLKRFMult",
                    "Else",
                    "No Extra Log",
                    "HCLKRFclockSelection",
                });
                const HCLKRFMultparents = [_]*const ClockNode{
                    &HCLKRFMultDiv,
                    &HSIRC,
                };
                HCLKRFMult.nodetype = .multi;
                HCLKRFMult.parents = &.{HCLKRFMultparents[HCLKRFMult_clk_value.get()]};
            }
            HCLKRFOutput.nodetype = .output;
            HCLKRFOutput.parents = &.{&HCLKRFMult};
            APB3Output.nodetype = .output;
            APB3Output.parents = &.{&HCLKRFMult};
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
                LPTIM1output.nodetype = .output;
                LPTIM1output.parents = &.{&LPTIM1Mult};
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                const LSCOMult_clk_value = LSCOSource1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                LSCOOutput.nodetype = .output;
                LSCOOutput.parents = &.{&LSCOMult};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const HSEPRESC_clk_value = HSEPRESValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEPRESC",
                    "Else",
                    "No Extra Log",
                    "HSEPRES",
                });
                HSEPRESC.nodetype = .div;
                HSEPRESC.value = HSEPRESC_clk_value;
                HSEPRESC.parents = &.{&HSEOSC};
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
                &MSIRC,
                &HSIRC,
                &HSEPRESC,
                &PLLR,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
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
                &MSIRC,
                &HSIRC,
                &HSEPRESC,
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
            PLLM.value = PLLM_clk_value.get();
            PLLM.parents = &.{&PLLSource};
            if (check_ref(@TypeOf(EnableHSERTCDevisorValue), EnableHSERTCDevisorValue, .true, .@"=") or
                check_ref(@TypeOf(EnableHSELCDDevisorValue), EnableHSELCDDevisorValue, .true, .@"="))
            {
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
                HSERTCDevisor.value = HSERTCDevisor_clk_value;
                HSERTCDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"="))
            {
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                LCDOutput.nodetype = .output;
                LCDOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
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
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                    const LPUART1Mult_clk_value = LPUART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LPUART1Mult",
                        "LPUART1_Exist",
                        "No Extra Log",
                        "LPUART1CLockSelection",
                    });
                    const LPUART1Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &SysCLKOutput,
                        &HSIRC,
                        &LSEOSC,
                    };
                    LPUART1Mult.nodetype = .multi;
                    LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                    LPUART1output.nodetype = .output;
                    LPUART1output.parents = &.{&LPUART1Mult};
                }
            }
            const SMPSCLockSelectionValue: ?SMPSCLockSelectionList = blk: {
                if (check_ref(@TypeOf(HSE_VALUEValue), HSE_VALUEValue, 32000000, .@"=") and (MSIRANGE_8 or MSIRANGE_9 or MSIRANGE_10 or MSIRANGE_11)) {
                    const conf_item = config.SMPSCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SMPSCLKSOURCE_MSI => SMPSSourceMSI = true,
                            .RCC_SMPSCLKSOURCE_HSE => SMPSSourceHSE = true,
                            .RCC_SMPSCLKSOURCE_HSI => SMPSSourceHSI = true,
                        }
                    }

                    break :blk conf_item orelse {
                        SMPSSourceHSI = true;
                        break :blk .RCC_SMPSCLKSOURCE_HSI;
                    };
                } else if (check_ref(@TypeOf(HSE_VALUEValue), HSE_VALUEValue, 32000000, .@"=")) {
                    const conf_item = config.SMPSCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SMPSCLKSOURCE_HSE => SMPSSourceHSE = true,
                            .RCC_SMPSCLKSOURCE_HSI => SMPSSourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SMPSCLKSOURCE_HSE
                                    \\ - RCC_SMPSCLKSOURCE_HSI
                                , .{ "SMPSCLockSelection", "HSE_VALUE=32000000", "SMPS CLock could not use MSI as clock source", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SMPSSourceHSI = true;
                        break :blk .RCC_SMPSCLKSOURCE_HSI;
                    };
                } else if ((MSIRANGE_8 or MSIRANGE_9 or MSIRANGE_10 or MSIRANGE_11)) {
                    const conf_item = config.SMPSCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SMPSCLKSOURCE_MSI => SMPSSourceMSI = true,
                            .RCC_SMPSCLKSOURCE_HSI => SMPSSourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SMPSCLKSOURCE_MSI
                                    \\ - RCC_SMPSCLKSOURCE_HSI
                                , .{ "SMPSCLockSelection", "(MSIRANGE_8 | MSIRANGE_9 | MSIRANGE_10 | MSIRANGE_11)", "SMPS could not use  HSE as a clock source", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SMPSSourceHSI = true;
                        break :blk .RCC_SMPSCLKSOURCE_HSI;
                    };
                } else if (!(check_ref(@TypeOf(HSE_VALUEValue), HSE_VALUEValue, 32000000, .@"=")) and !(MSIRANGE_8 or MSIRANGE_9 or MSIRANGE_10 or MSIRANGE_11)) {
                    SMPSSourceHSI = true;
                    const item: SMPSCLockSelectionList = .RCC_SMPSCLKSOURCE_HSI;
                    const conf_item = config.SMPSCLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SMPSCLockSelection", "!(HSE_VALUE=32000000) & !(MSIRANGE_8 | MSIRANGE_9 | MSIRANGE_10 | MSIRANGE_11)", "MSI should be greather than 16 Mhz OR HSE with 32 Mhz", "RCC_SMPSCLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                }
                break :blk null;
            };
            if (!check_MCU("STM32WBx0_Value_Line")) {
                if (check_ref(@TypeOf(SMPSEnableValue), SMPSEnableValue, .true, .@"=")) {
                    const SMPSMult_clk_value = SMPSCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SMPSMult",
                        "!STM32WBx0_Value_Line",
                        "No Extra Log",
                        "SMPSCLockSelection",
                    });
                    const SMPSMultparents = [_]*const ClockNode{
                        &MSIRC,
                        &HSEOSC,
                        &HSIRC,
                    };
                    SMPSMult.nodetype = .multi;
                    SMPSMult.parents = &.{SMPSMultparents[SMPSMult_clk_value.get()]};
                }
            }
            const SMPSDividerValue: ?SMPSDividerList = blk: {
                if (check_ref(@TypeOf(SMPSCLockSelectionValue), SMPSCLockSelectionValue, .RCC_SMPSCLKSOURCE_MSI, .@"=") and (MSIRANGE_9 or MSIRANGE_11)) {
                    const conf_item = config.SMPSDivider;
                    if (conf_item) |item| {
                        switch (item) {
                            .@"1" => {},
                            .@"2" => {},
                            .@"3" => {},
                            .@"4" => {},
                            .@"6" => {},
                        }
                    }

                    break :blk conf_item orelse .@"3";
                }
                const conf_item = config.SMPSDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"2" => {},
                        .@"3" => {},
                        .@"4" => {},
                        .@"6" => {},
                    }
                }

                break :blk conf_item orelse .@"2";
            };
            if (!check_MCU("STM32WBx0_Value_Line")) {
                if (check_ref(@TypeOf(SMPSDivEnableValue), SMPSDivEnableValue, .true, .@"=")) {
                    const SMPSDivider_clk_value = SMPSDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SMPSDivider",
                        "!STM32WBx0_Value_Line",
                        "No Extra Log",
                        "SMPSDivider",
                    });
                    SMPSDivider.nodetype = .div;
                    SMPSDivider.value = SMPSDivider_clk_value.get();
                    SMPSDivider.parents = &.{&SMPSMult};
                }
            }
            if (!check_MCU("STM32WBx0_Value_Line")) {
                if (check_ref(@TypeOf(SMPSEnableValue), SMPSEnableValue, .true, .@"=")) {
                    const SMPSDiv2_clk_value = SMPSDiv2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SMPSDiv2",
                        "!STM32WBx0_Value_Line",
                        "No Extra Log",
                        "SMPSDiv2",
                    });
                    SMPSDiv2.nodetype = .div;
                    SMPSDiv2.value = SMPSDiv2_clk_value;
                    SMPSDiv2.parents = &.{&SMPSDivider};
                }
            }
            if (!check_MCU("STM32WBx0_Value_Line")) {
                if (check_ref(@TypeOf(SMPSEnableValue), SMPSEnableValue, .true, .@"=")) {
                    SMPSoutput.nodetype = .output;
                    SMPSoutput.parents = &.{&SMPSDiv2};
                }
            }
            if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                const LPTIM2Mult_clk_value = LPTIM2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Prescaler,
                    &LSIRC,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM2Mult.nodetype = .multi;
                LPTIM2Mult.parents = &.{LPTIM2Multparents[LPTIM2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(EnableHSERFDevisorValue), EnableHSERFDevisorValue, .true, .@"=")) {
                const HSERFWKPDevisor_clk_value = RCC_RFWKP_Clock_Source_FROM_HSEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSERFWKPDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_RFWKP_Clock_Source_FROM_HSE",
                });
                HSERFWKPDevisor.nodetype = .div;
                HSERFWKPDevisor.value = HSERFWKPDevisor_clk_value;
                HSERFWKPDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                const RFWKPClkSource_clk_value = RFWKPClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RFWKPClkSource",
                    "Else",
                    "No Extra Log",
                    "RFWKPClockSelection",
                });
                const RFWKPClkSourceparents = [_]*const ClockNode{
                    &HSERFWKPDevisor,
                    &LSEOSC,
                    &LSIRC,
                };
                RFWKPClkSource.nodetype = .multi;
                RFWKPClkSource.parents = &.{RFWKPClkSourceparents[RFWKPClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                RFWKPOutput.nodetype = .output;
                RFWKPOutput.parents = &.{&RFWKPClkSource};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const CK48Mult_clk_value = CK48CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CK48Mult",
                    "Else",
                    "No Extra Log",
                    "CK48CLockSelection",
                });
                const CK48Multparents = [_]*const ClockNode{
                    &PLLQ,
                    &MSIRC,
                };
                CK48Mult.nodetype = .multi;
                CK48Mult.parents = &.{CK48Multparents[CK48Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const RNGDiv_clk_value = RNGDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RNGDiv",
                    "Else",
                    "No Extra Log",
                    "RNGDiv",
                });
                RNGDiv.nodetype = .div;
                RNGDiv.value = RNGDiv_clk_value;
                RNGDiv.parents = &.{&CK48Mult};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const RNGMult_clk_value = RNGCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &RNGDiv,
                    &LSIRC,
                    &LSEOSC,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&RNGMult};
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
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const ADCMult_clk_value = ADCCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &HSIRC,
                    &PLLP,
                    &SysCLKOutput,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCOMult_clk_value = RCC_MCO1SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &HSEOSC,
                    &HSIRC,
                    &PLLR,
                    &SysCLKOutput,
                    &MSIRC,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCODiv_clk_value = RCC_MCODivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
            }

            const AHB3Prescaler_clk_value = AHB3CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AHB3Prescaler",
                "Else",
                "No Extra Log",
                "AHB3CLKDivider",
            });
            AHB3Prescaler.nodetype = .div;
            AHB3Prescaler.value = AHB3Prescaler_clk_value.get();
            AHB3Prescaler.parents = &.{&SysCLKOutput};
            AHB3Output.nodetype = .output;
            AHB3Output.parents = &.{&AHB3Prescaler};

            const AHB2Prescaler_clk_value = AHB2CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AHB2Prescaler",
                "Else",
                "No Extra Log",
                "AHB2CLKDivider",
            });
            AHB2Prescaler.nodetype = .div;
            AHB2Prescaler.value = AHB2Prescaler_clk_value.get();
            AHB2Prescaler.parents = &.{&SysCLKOutput};
            FCLK2CortexOutput.nodetype = .output;
            FCLK2CortexOutput.parents = &.{&AHB2Prescaler};
            AHB2Output.nodetype = .output;
            AHB2Output.parents = &.{&AHB2Prescaler};

            const Cortex2Prescaler_clk_value = Cortex2_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "Cortex2Prescaler",
                "Else",
                "No Extra Log",
                "Cortex2_Div",
            });
            Cortex2Prescaler.nodetype = .div;
            Cortex2Prescaler.value = Cortex2Prescaler_clk_value.get();
            Cortex2Prescaler.parents = &.{&AHB2Prescaler};
            Cortex2SysOutput.nodetype = .output;
            Cortex2SysOutput.parents = &.{&Cortex2Prescaler};

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
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};
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
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};
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
            TimPrescOut2.nodetype = .output;
            TimPrescOut2.parents = &.{&TimPrescalerAPB2};

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
            PLLPoutput.nodetype = .output;
            PLLPoutput.parents = &.{&PLLP};

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
            PLLQ.value = PLLQ_clk_value.get();
            PLLQ.parents = &.{&PLLN};
            PLLQoutput.nodetype = .output;
            PLLQoutput.parents = &.{&PLLQ};

            const PLLR_clk_value = PLLRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            LSI.nodetype = .output;
            LSI.parents = &.{&LSIRC};
            SMPSDivclk.nodetype = .output;
            SMPSDivclk.parents = &.{&SMPSDivider};
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLR};

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")))) {
                    RTCOutput.limit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                RTCOutput.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF LCDFreq_Value VALUE
            _ = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")))) {
                    LCDOutput.limit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                LCDOutput.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                RNGoutput.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                ADCoutput.limit = .{
                    .min = 1.4e6,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLK3Freq_Value VALUE
            _ = blk: {
                AHB3Output.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF FCLK2Freq_Value VALUE
            _ = blk: {
                if (config.flags.RFUsed_ForRCC or check_MCU("S_BLE_HOST") or check_MCU("S_THREAD")) {
                    FCLK2CortexOutput.value = 32000000;
                    break :blk null;
                }
                FCLK2CortexOutput.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLK2Freq_Value VALUE
            _ = blk: {
                if (config.flags.RFUsed_ForRCC or check_MCU("S_BLE_HOST") or check_MCU("S_THREAD")) {
                    AHB2Output.value = 32000000;
                    break :blk null;
                }
                AHB2Output.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PWRFreq_Value VALUE
            _ = blk: {
                PWRCLKoutput.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PLLPoutputFreq_Value VALUE
            _ = blk: {
                if (((check_MCU("SAI1SourcePLLP") and (config.flags.SAI1Used_ForRCC))) or (ADCSourcePLL and config.flags.USE_ADC1)) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 6.4e7,
                    };

                    break :blk null;
                }
                PLLPoutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLLQoutputFreq_Value VALUE
            _ = blk: {
                if ((((config.flags.RNGUsed_ForRCC and RNGCLKSOURCE_CLK48)) and CK48SourcePLLCLK)) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 6.4e7,
                    };

                    break :blk null;
                }
                PLLQoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) {
                    VCOInput.limit = .{
                        .min = 2.66e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 9.6e7,
                        .max = 3.44e8,
                    };

                    break :blk null;
                }
                VCOOutput.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF PLLRCLKFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 6.4e7,
                    };

                    break :blk null;
                }
                PLLCLK.value = 16000000;
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (((check_ref(?f32, AHB3Output.get_as_ref(), 18000000, .@"<")) or (check_ref(?f32, AHB3Output.get_as_ref(), 18000000, .@"=")))) {
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
                            , .{ "FLatency", "((HCLK3Freq_Value < 18000000)|(HCLK3Freq_Value= 18000000 ))", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(?f32, AHB3Output.get_as_ref(), 36000000, .@"<")) or (check_ref(?f32, AHB3Output.get_as_ref(), 36000000, .@"=")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_0
                                , .{ "FLatency", "((HCLK3Freq_Value < 36000000)|(HCLK3Freq_Value= 36000000 ))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if (((check_ref(?f32, AHB3Output.get_as_ref(), 54000000, .@"<")) or (check_ref(?f32, AHB3Output.get_as_ref(), 54000000, .@"=")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_0
                                , .{ "FLatency", "((HCLK3Freq_Value < 54000000)|(HCLK3Freq_Value= 54000000 ))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if (((check_ref(?f32, AHB3Output.get_as_ref(), 64000000, .@"<")) or (check_ref(?f32, AHB3Output.get_as_ref(), 64000000, .@"=")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                }
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
                        , .{ "FLatency", "Else", "No Extra Log", "FLASH_LATENCY_3", i });
                    }
                }
                break :blk item;
            };

            //POST CLOCK REF HSICalibrationValue VALUE
            _ = blk: {
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
                    HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

                    break :blk null;
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
                HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

                break :blk null;
            };

            //POST CLOCK REF MSICalibrationValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=")) {
                    const config_val = config.extra.MSICalibrationValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "MSICalibrationValue",
                                "MSIUsed=1",
                                "HSI used",
                                0,
                                val,
                            });
                        }
                        if (val > 255) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "MSICalibrationValue",
                                "MSIUsed=1",
                                "HSI used",
                                255,
                                val,
                            });
                        }
                    }
                    MSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                    break :blk null;
                }
                const config_val = config.extra.MSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                MSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };

            out.RNGoutput = try RNGoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.RNGDiv = try RNGDiv.get_output();
            out.CK48Mult = try CK48Mult.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.PLLP = try PLLP.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.AHB2Output = try AHB2Output.get_output();
            out.Cortex2SysOutput = try Cortex2SysOutput.get_output();
            out.Cortex2Prescaler = try Cortex2Prescaler.get_output();
            out.FCLK2CortexOutput = try FCLK2CortexOutput.get_output();
            out.AHB2Prescaler = try AHB2Prescaler.get_output();
            out.AHB3Output = try AHB3Output.get_output();
            out.AHB3Prescaler = try AHB3Prescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.PLLR = try PLLR.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.HCLKRFOutput = try HCLKRFOutput.get_output();
            out.HCLKRFMult = try HCLKRFMult.get_output();
            out.SMPSoutput = try SMPSoutput.get_output();
            out.SMPSDiv2 = try SMPSDiv2.get_output();
            out.SMPSDivider = try SMPSDivider.get_output();
            out.SMPSMult = try SMPSMult.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.LCDOutput = try LCDOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HCLKRFMultDiv = try HCLKRFMultDiv.get_output();
            out.HSEPRESC = try HSEPRESC.get_output();
            out.RFWKPOutput = try RFWKPOutput.get_output();
            out.RFWKPClkSource = try RFWKPClkSource.get_output();
            out.HSERFWKPDevisor = try HSERFWKPDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIMult = try LSIMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSI2RC = try LSI2RC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.LSI = try LSI.get_extra_output();
            out.SMPSDivclk = try SMPSDivclk.get_extra_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI1_VALUE = LSI1_VALUEValue;
            ref_out.LSI2_VALUE = LSI2_VALUEValue;
            ref_out.LSISource1 = LSISource1Value;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.HCLKRFDiv = HCLKRFDivValue;
            ref_out.HCLKRFclockSelection = HCLKRFclockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.HSEPRES = HSEPRESValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.SMPSCLockSelection = SMPSCLockSelectionValue;
            ref_out.SMPSDivider = SMPSDividerValue;
            ref_out.SMPSDiv2 = SMPSDiv2Value;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.RCC_RFWKP_Clock_Source_FROM_HSE = RCC_RFWKP_Clock_Source_FROM_HSEValue;
            ref_out.RFWKPClockSelection = RFWKPClockSelectionValue;
            ref_out.CK48CLockSelection = CK48CLockSelectionValue;
            ref_out.RNGDiv = RNGDivValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.AHB3CLKDivider = AHB3CLKDividerValue;
            ref_out.AHB2CLKDivider = AHB2CLKDividerValue;
            ref_out.Cortex2_Div = Cortex2_DivValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
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
            ref_out.MSIAutoCalibration = MSIAutoCalibrationValue;
            ref_out.MSIOscState = MSIOscStateValue;
            ref_out.HSIOscState = HSIOscStateValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.EnableHSERFDevisor = EnableHSERFDevisorValue;
            ref_out.EnableHCLKR = EnableHCLKRValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.EnableHSELCDDevisor = EnableHSELCDDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.SMPSEnable = SMPSEnableValue;
            ref_out.SMPSDivEnable = SMPSDivEnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.RFEnable = RFEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.MSIUsed = MSIUsedValue;
            ref_out.MSIUsedForSys = MSIUsedForSysValue;
            ref_out.HSIUsedForSys = HSIUsedForSysValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
