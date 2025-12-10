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
pub const PLLSAI1SourceList = enum {
    RCC_PLLSAI1SOURCE_MSI,
    RCC_PLLSAI1SOURCE_HSI,
    RCC_PLLSAI1SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSAI1SOURCE_MSI => 0,
            .RCC_PLLSAI1SOURCE_HSI => 1,
            .RCC_PLLSAI1SOURCE_HSE => 2,
        };
    }
};
pub const PLLSAI2SourceList = enum {
    RCC_PLLSAI2SOURCE_MSI,
    RCC_PLLSAI2SOURCE_HSI,
    RCC_PLLSAI2SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSAI2SOURCE_MSI => 0,
            .RCC_PLLSAI2SOURCE_HSI => 1,
            .RCC_PLLSAI2SOURCE_HSE => 2,
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
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK1,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_HSI,
    RCC_LPTIM2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM2CLKSOURCE_LSI => 1,
            .RCC_LPTIM2CLKSOURCE_HSI => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
        };
    }
};
pub const DFSDMCLockSelectionList = enum {
    RCC_DFSDM1CLKSOURCE_PCLK2,
    RCC_DFSDM1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1CLKSOURCE_PCLK2 => 0,
            .RCC_DFSDM1CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_PLLSAI1,
    RCC_ADCCLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_PLLSAI1 => 0,
            .RCC_ADCCLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const CK48CLockSelectionList = enum {
    RCC_USBCLKSOURCE_PLLSAI1,
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_MSI,
    RCC_USBCLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLLSAI1 => 0,
            .RCC_USBCLKSOURCE_PLL => 1,
            .RCC_USBCLKSOURCE_MSI => 2,
            .RCC_USBCLKSOURCE_HSI48 => 3,
        };
    }
};
pub const SDMMCClockSelectionList = enum {
    RCC_SDMMC1CLKSOURCE_PLLP,
    RCC_SDIOCLKSOURCE_CLK48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC1CLKSOURCE_PLLP => 0,
            .RCC_SDIOCLKSOURCE_CLK48 => 1,
        };
    }
};
pub const FDCANClockSelectionList = enum {
    RCC_FDCANCLKSOURCE_PLL,
    RCC_FDCANCLKSOURCE_PLLSAI1,
    RCC_FDCANCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_PLL => 0,
            .RCC_FDCANCLKSOURCE_PLLSAI1 => 1,
            .RCC_FDCANCLKSOURCE_HSE => 2,
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
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLLSAI1,
    RCC_SAI1CLKSOURCE_PLLSAI2,
    RCC_SAI1CLKSOURCE_PLL,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLLSAI1 => 0,
            .RCC_SAI1CLKSOURCE_PLLSAI2 => 1,
            .RCC_SAI1CLKSOURCE_PLL => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_HSI => 4,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLLSAI1,
    RCC_SAI2CLKSOURCE_PLLSAI2,
    RCC_SAI2CLKSOURCE_PLL,
    RCC_SAI2CLKSOURCE_PIN,
    RCC_SAI2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLLSAI1 => 0,
            .RCC_SAI2CLKSOURCE_PLLSAI2 => 1,
            .RCC_SAI2CLKSOURCE_PLL => 2,
            .RCC_SAI2CLKSOURCE_PIN => 3,
            .RCC_SAI2CLKSOURCE_HSI => 4,
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
pub const OCTOSPIMCLockSelectionList = enum {
    RCC_OSPICLKSOURCE_MSI,
    RCC_OSPICLKSOURCE_SYSCLK,
    RCC_OSPICLKSOURCE_PLL,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_OSPICLKSOURCE_MSI => 0,
            .RCC_OSPICLKSOURCE_SYSCLK => 1,
            .RCC_OSPICLKSOURCE_PLL => 2,
        };
    }
};
pub const LPTIM3CLockSelectionList = enum {
    RCC_LPTIM3CLKSOURCE_PCLK1,
    RCC_LPTIM3CLKSOURCE_LSI,
    RCC_LPTIM3CLKSOURCE_HSI,
    RCC_LPTIM3CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM3CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM3CLKSOURCE_LSI => 1,
            .RCC_LPTIM3CLKSOURCE_HSI => 2,
            .RCC_LPTIM3CLKSOURCE_LSE => 3,
        };
    }
};
pub const DFSDMAudioCLockSelectionList = enum {
    RCC_DFSDM1AUDIOCLKSOURCE_MSI,
    RCC_DFSDM1AUDIOCLKSOURCE_HSI,
    RCC_DFSDM1AUDIOCLKSOURCE_SAI1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1AUDIOCLKSOURCE_MSI => 0,
            .RCC_DFSDM1AUDIOCLKSOURCE_HSI => 1,
            .RCC_DFSDM1AUDIOCLKSOURCE_SAI1 => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSI,
    RCC_MCO1SOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLLCLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_MSI => 6,
            .RCC_MCO1SOURCE_HSI48 => 7,
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
pub const LSIDIVList = enum {
    RCC_LSI_DIV1,
    RCC_LSI_DIV128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_LSI_DIV1 => 1,
            .RCC_LSI_DIV128 => 128,
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
    RCC_PLLP_DIV7,
    RCC_PLLP_DIV17,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV7 => 7,
            .RCC_PLLP_DIV17 => 17,
        };
    }
};
pub const PLLQList = enum {
    RCC_PLLQ_DIV2,
    RCC_PLLQ_DIV4,
    RCC_PLLQ_DIV6,
    RCC_PLLQ_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLQ_DIV2 => 2,
            .RCC_PLLQ_DIV4 => 4,
            .RCC_PLLQ_DIV6 => 6,
            .RCC_PLLQ_DIV8 => 8,
        };
    }
};
pub const PLLRList = enum {
    RCC_PLLR_DIV2,
    RCC_PLLR_DIV4,
    RCC_PLLR_DIV6,
    RCC_PLLR_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLR_DIV2 => 2,
            .RCC_PLLR_DIV4 => 4,
            .RCC_PLLR_DIV6 => 6,
            .RCC_PLLR_DIV8 => 8,
        };
    }
};
pub const PLLSAI1PList = enum {
    RCC_PLLP_DIV7,
    RCC_PLLP_DIV17,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV7 => 7,
            .RCC_PLLP_DIV17 => 17,
        };
    }
};
pub const PLLSAI1QList = enum {
    RCC_PLLQ_DIV2,
    RCC_PLLQ_DIV4,
    RCC_PLLQ_DIV6,
    RCC_PLLQ_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLQ_DIV2 => 2,
            .RCC_PLLQ_DIV4 => 4,
            .RCC_PLLQ_DIV6 => 6,
            .RCC_PLLQ_DIV8 => 8,
        };
    }
};
pub const PLLSAI1RList = enum {
    RCC_PLLR_DIV2,
    RCC_PLLR_DIV4,
    RCC_PLLR_DIV6,
    RCC_PLLR_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLR_DIV2 => 2,
            .RCC_PLLR_DIV4 => 4,
            .RCC_PLLR_DIV6 => 6,
            .RCC_PLLR_DIV8 => 8,
        };
    }
};
pub const PLLSAI2PList = enum {
    RCC_PLLP_DIV7,
    RCC_PLLP_DIV17,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV7 => 7,
            .RCC_PLLP_DIV17 => 17,
        };
    }
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
    FLASH_LATENCY_5,
    FLASH_LATENCY_4,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE0,
};
pub const MSIAutoCalibrationList = enum {
    ENABLED,
    DISABLED,
};
pub const PrescalerList = enum {
    RCC_CRS_SYNC_DIV1,
    RCC_CRS_SYNC_DIV2,
    RCC_CRS_SYNC_DIV4,
    RCC_CRS_SYNC_DIV8,
    RCC_CRS_SYNC_DIV16,
    RCC_CRS_SYNC_DIV32,
    RCC_CRS_SYNC_DIV64,
    RCC_CRS_SYNC_DIV128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_CRS_SYNC_DIV1 => 1,
            .RCC_CRS_SYNC_DIV2 => 2,
            .RCC_CRS_SYNC_DIV4 => 4,
            .RCC_CRS_SYNC_DIV8 => 8,
            .RCC_CRS_SYNC_DIV16 => 16,
            .RCC_CRS_SYNC_DIV32 => 32,
            .RCC_CRS_SYNC_DIV64 => 64,
            .RCC_CRS_SYNC_DIV128 => 128,
        };
    }
};
pub const SourceList = enum {
    RCC_CRS_SYNC_SOURCE_GPIO,
    RCC_CRS_SYNC_SOURCE_LSE,
    RCC_CRS_SYNC_SOURCE_USB,
};
pub const PolarityList = enum {
    RCC_CRS_SYNC_POLARITY_RISING,
    RCC_CRS_SYNC_POLARITY_FALLING,
};
pub const ReloadValueTypeList = enum {
    UserValue,
    automatic,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const EnableCRSList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const SDMMCEnableList = enum {
    true,
    false,
};
pub const LSIEnableList = enum {
    true,
};
pub const EnableExtClockForSAI1List = enum {
    true,
    false,
};
pub const EnableExtClockForSAI2List = enum {
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
pub const USART2EnableList = enum {
    true,
    false,
};
pub const USART3EnableList = enum {
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
pub const DFSDMEnableList = enum {
    true,
    false,
};
pub const DFSDMAudioEnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const FDCANEnableList = enum {
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
pub const SAI1EnableList = enum {
    true,
    false,
};
pub const SAI2EnableList = enum {
    true,
    false,
};
pub const I2C4EnableList = enum {
    true,
    false,
};
pub const OCTOSPIMEnableList = enum {
    true,
    false,
};
pub const LPTIM3EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const UCPDEnableList = enum {
    true,
    false,
};
pub const LSEStateList = enum {
    RCC_LSE_BYPASS_RTC_ONLY,
    RCC_LSE_ON_RTC_ONLY,
    RCC_LSE_BYPASS,
    RCC_LSE_ON,
    RCC_LSE_OFF,
};
pub const EnableCSSLSEList = enum {
    true,
    false,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            RCC_TZ_PRIV: bool = false,
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            LSEByPassRTC: bool = false,
            LSEOscillatorRTC: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            SAI2EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USBUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            USE_ADC2: bool = false,
            RTCUsed_ForRCC: bool = false,
            LCDUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            UCPD1_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            MSIAutoCalibration: ?MSIAutoCalibrationList = null,
            Prescaler: ?PrescalerList = null,
            Polarity: ?PolarityList = null,
            ReloadValueType: ?ReloadValueTypeList = null,
            ReloadValue: ?u32 = null,
            GPIOFsync: ?u32 = null,
            ErrorLimitValue: ?u32 = null,
            HSI48CalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSIDIV: ?LSIDIVList = null,
            LSE_VALUE: ?f32 = null,
            MSIClockRange: ?MSIClockRangeList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLSAI1Source: ?PLLSAI1SourceList = null,
            PLLSAI2Source: ?PLLSAI2SourceList = null,
            PLLM: ?u32 = null,
            PLLSAI1M: ?u32 = null,
            PLLSAI2M: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART3CLockSelection: ?USART3CLockSelectionList = null,
            UART4CLockSelection: ?UART4CLockSelectionList = null,
            UART5CLockSelection: ?UART5CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            CK48CLockSelection: ?CK48CLockSelectionList = null,
            SDMMCClockSelection: ?SDMMCClockSelectionList = null,
            FDCANClockSelection: ?FDCANClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            DFSDMAudioCLockSelection: ?DFSDMAudioCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?PLLQList = null,
            PLLR: ?PLLRList = null,
            PLLSAI1N: ?u32 = null,
            PLLSAI1P: ?PLLSAI1PList = null,
            PLLSAI1Q: ?PLLSAI1QList = null,
            PLLSAI1R: ?PLLSAI1RList = null,
            PLLSAI2N: ?u32 = null,
            PLLSAI2P: ?PLLSAI2PList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            CRSCLKoutput: f32 = 0,
            HSI48RC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSIDIV: f32 = 0,
            LSEOSC: f32 = 0,
            MSIRC: f32 = 0,
            SAI1_EXT: f32 = 0,
            SAI2_EXT: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLSAI1Source: f32 = 0,
            PLLSAI2Source: f32 = 0,
            PLLM: f32 = 0,
            PLLSAI1M: f32 = 0,
            PLLSAI2M: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            LCDOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2output: f32 = 0,
            USART3Mult: f32 = 0,
            USART3output: f32 = 0,
            UART4Mult: f32 = 0,
            UART4output: f32 = 0,
            UART5Mult: f32 = 0,
            UART5output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            DFSDMMult: f32 = 0,
            DFSDMoutput: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CK48Mult: f32 = 0,
            CK48output: f32 = 0,
            RNGoutput: f32 = 0,
            SDMMC1Mult: f32 = 0,
            SDMMCC1Output: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANOutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
            I2C4Mult: f32 = 0,
            I2C4output: f32 = 0,
            OCTOSPIMMult: f32 = 0,
            OCTOSPIMoutput: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            DFSDMAudioMult: f32 = 0,
            DFSDMAudiooutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
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
            UCPD1Output: f32 = 0,
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLPoutput: f32 = 0,
            PLLQ: f32 = 0,
            PLLQoutput: f32 = 0,
            PLLR: f32 = 0,
            PLLSAI1N: f32 = 0,
            PLLSAI1P: f32 = 0,
            PLLSAI1Poutput: f32 = 0,
            PLLSAI1Q: f32 = 0,
            PLLSAI1Qoutput: f32 = 0,
            PLLSAI1R: f32 = 0,
            PLLSAI1Routput: f32 = 0,
            PLLSAI2N: f32 = 0,
            PLLSAI2P: f32 = 0,
            PLLSAI2Poutput: f32 = 0,
            MSI: f32 = 0,
            VCOInput: f32 = 0,
            VCOInput2: f32 = 0,
            VCOInput3: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            VCOSAI1Output: f32 = 0,
            VCOSAI2Output: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSIDIV: ?LSIDIVList = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            EXTERNALSAI1_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNALSAI2_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLSAI1Source: ?PLLSAI1SourceList = null, //from RCC Clock Config
            PLLSAI2Source: ?PLLSAI2SourceList = null, //from RCC Clock Config
            PLLM: ?f32 = null, //from RCC Clock Config
            PLLSAI1M: ?f32 = null, //from RCC Clock Config
            PLLSAI2M: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from extra RCC references
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from extra RCC references
            USART3CLockSelection: ?USART3CLockSelectionList = null, //from extra RCC references
            UART4CLockSelection: ?UART4CLockSelectionList = null, //from extra RCC references
            UART5CLockSelection: ?UART5CLockSelectionList = null, //from extra RCC references
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from extra RCC references
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from extra RCC references
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from extra RCC references
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            CK48CLockSelection: ?CK48CLockSelectionList = null, //from RCC Clock Config
            SDMMCClockSelection: ?SDMMCClockSelectionList = null, //from RCC Clock Config
            FDCANClockSelection: ?FDCANClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from extra RCC references
            DFSDMAudioCLockSelection: ?DFSDMAudioCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from extra RCC references
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from extra RCC references
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
            PLLSAI1N: ?f32 = null, //from RCC Clock Config
            PLLSAI1P: ?PLLSAI1PList = null, //from RCC Clock Config
            PLLSAI1Q: ?PLLSAI1QList = null, //from RCC Clock Config
            PLLSAI1R: ?PLLSAI1RList = null, //from RCC Clock Config
            PLLSAI2N: ?f32 = null, //from RCC Clock Config
            PLLSAI2P: ?PLLSAI2PList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            MSIAutoCalibration: ?MSIAutoCalibrationList = null, //from RCC Advanced Config
            Prescaler: ?PrescalerList = null, //from RCC Advanced Config
            Source: ?SourceList = null, //from RCC Advanced Config
            Polarity: ?PolarityList = null, //from RCC Advanced Config
            ReloadValueType: ?ReloadValueTypeList = null, //from RCC Advanced Config
            ReloadValue: ?f32 = null, //from RCC Advanced Config
            Fsync: ?f32 = null, //from RCC Advanced Config
            LSEFsync: ?f32 = null, //from RCC Advanced Config
            GPIOFsync: ?f32 = null, //from RCC Advanced Config
            USBFsync: ?f32 = null, //from RCC Advanced Config
            ErrorLimitValue: ?f32 = null, //from RCC Advanced Config
            HSI48CalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            EnableCRS: ?EnableCRSList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            SDMMCEnable: ?SDMMCEnableList = null, //from extra RCC references
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            EnableExtClockForSAI1: ?EnableExtClockForSAI1List = null, //from extra RCC references
            EnableExtClockForSAI2: ?EnableExtClockForSAI2List = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            EnableHSELCDDevisor: ?EnableHSELCDDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART3Enable: ?USART3EnableList = null, //from extra RCC references
            UART4Enable: ?UART4EnableList = null, //from extra RCC references
            UART5Enable: ?UART5EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            DFSDMEnable: ?DFSDMEnableList = null, //from extra RCC references
            DFSDMAudioEnable: ?DFSDMAudioEnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            SAI2Enable: ?SAI2EnableList = null, //from extra RCC references
            I2C4Enable: ?I2C4EnableList = null, //from extra RCC references
            OCTOSPIMEnable: ?OCTOSPIMEnableList = null, //from extra RCC references
            LPTIM3Enable: ?LPTIM3EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            UCPDEnable: ?UCPDEnableList = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            PLLSAI1Used: ?f32 = null, //from extra RCC references
            PLLSAI2Used: ?f32 = null, //from extra RCC references
            LSEState: ?LSEStateList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
            MSIUsed: ?f32 = null, //from extra RCC references
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

            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var PLLSOURCE_MSI: bool = false;
            var PLLSOURCE_HSI: bool = false;
            var PLLSOURCE_HSE: bool = false;
            var PLLSAI1SourceMSI: bool = false;
            var PLLSAI1SourceHSI: bool = false;
            var PLLSAI1SourceHSE: bool = false;
            var PLLSAI2SourceMSI: bool = false;
            var PLLSAI2SourceHSI: bool = false;
            var PLLSAI2SourceHSE: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
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
            var UART4SourcePCLK1: bool = false;
            var UART4Sourcesys: bool = false;
            var UART4SourceHSI: bool = false;
            var UART4SourceLSE: bool = false;
            var UART5SourcePCLK1: bool = false;
            var UART5Sourcesys: bool = false;
            var UART5SourceHSI: bool = false;
            var UART5SourceLSE: bool = false;
            var LPUART1SourcePCLK1: bool = false;
            var LPUART1SourceSys: bool = false;
            var LPUART1SourceHSI: bool = false;
            var LPUART1SourceLSE: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2SOURCEHSI: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var DFSDMSourcePCLK: bool = false;
            var DFSDMSourceSys: bool = false;
            var ADCSourcePLLSAI1R: bool = false;
            var ADCSourceSys: bool = false;
            var CK48SourcePLLSAI1: bool = false;
            var CK48SourcePLLCLK: bool = false;
            var CK48SourceMSI: bool = false;
            var CK48SourceHSI48: bool = false;
            var SDMMC1SourceIsPllP: bool = false;
            var SDMMC1SourceIsClock48: bool = false;
            var FDCANSourcePLL: bool = false;
            var FDCANSourcePLLSAI1: bool = false;
            var FDCANSourceHSE: bool = false;
            var I2C1SourcePCLK1: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C2SourcePCLK1: bool = false;
            var I2C2SourceSys: bool = false;
            var I2C2SourceHSI: bool = false;
            var I2C3SourcePCLK1: bool = false;
            var I2C3SourceSys: bool = false;
            var I2C3SourceHSI: bool = false;
            var SAI1SourcePLLSAI1P: bool = false;
            var SAI1SourcePLLSAI2P: bool = false;
            var SAI1SourcePLLP: bool = false;
            var SAI1SourceEXT: bool = false;
            var SAI1SourceHSI: bool = false;
            var SAI2SourcePLLSAI1P: bool = false;
            var SAI2SourcePLLSAI2P: bool = false;
            var SAI2SourcePLLP: bool = false;
            var SAI2SourceEXT: bool = false;
            var SAI2SourceHSI: bool = false;
            var I2C4SourcePCLK1: bool = false;
            var I2C4SourceSys: bool = false;
            var I2C4SourceHSI: bool = false;
            var OCTOSPIMSourceMSI: bool = false;
            var OCTOSPIMSourceSYS: bool = false;
            var OCTOSPIMSourcePLL: bool = false;
            var LPTIM3SOURCELSI: bool = false;
            var LPTIM3SOURCEHSI: bool = false;
            var LPTIM3SOURCELSE: bool = false;
            var DFSDMAudioSourceMSI: bool = false;
            var DFSDMAudioSourceHSI: bool = false;
            var DFSDMAudioSourceSAI: bool = false;
            var MCOSourceLSE: bool = false;
            var MCOSourceLSI: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceHSI: bool = false;
            var MCOSourcePLL: bool = false;
            var MCOSourcesys: bool = false;
            var MCOSourceMSI: bool = false;
            var MCOSourceHSI48: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
            var scale0: bool = false;
            var MSIAutoCalibrationON: bool = false;
            var RccCrsSyncDiv1: bool = false;
            var RccCrsSyncDiv2: bool = false;
            var RccCrsSyncDiv4: bool = false;
            var RccCrsSyncDiv8: bool = false;
            var RccCrsSyncDiv16: bool = false;
            var RccCrsSyncDiv32: bool = false;
            var RccCrsSyncDiv64: bool = false;
            var RccCrsSyncDiv128: bool = false;
            var UserDefinedReload: bool = false;
            var AutomaticRelaod: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var SDMMCFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var PLLPoutputFreq_ValueLimit: Limit = .{};
            var PLLQoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1PoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1QoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1RoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI2PoutputFreq_ValueLimit: Limit = .{};
            var VCOInputFreq_ValueLimit: Limit = .{};
            var VCOInput2Freq_ValueLimit: Limit = .{};
            var VCOInput3Freq_ValueLimit: Limit = .{};
            var VCOOutputFreq_ValueLimit: Limit = .{};
            var PLLRCLKFreq_ValueLimit: Limit = .{};
            var VCOSAI1OutputFreq_ValueLimit: Limit = .{};
            var VCOSAI2OutputFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const CRSFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 0e0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass  ",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 4.8e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass  ",
                                "HSE in bypass Mode",
                                4.8e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 16000000;
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
                    if (val > 4.8e7) {
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
                            4.8e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 16000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI_VALUE;
                if (config_val) |val| {
                    if (val < 3.104e4) {
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
                            3.104e4,
                            val,
                        });
                    }
                    if (val > 3.296e4) {
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
                            3.296e4,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32000;
            };
            const LSIDIVValue: ?LSIDIVList = blk: {
                const conf_item = config.LSIDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSI_DIV1 => {},
                        .RCC_LSI_DIV128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_LSI_DIV1;
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
                break :blk config_val orelse 32768;
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
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.71e0) {
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
                            1.71e0,
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">"))) {
                    SYSCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.1e8,
                };

                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if ((SysSourceMSI and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@"=")))) or (SysSourceHSE and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 26000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 26000000, .@"="))))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale2 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE2;
                    };
                } else if ((SysSourceMSI and check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@">")) or (SysSourceHSE and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 26000000, .@">")) and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE0
                                , .{ "PWR_Regulator_Voltage_Scale", "(SysSourceMSI & SYSCLKFreq_VALUE >24000000)|(SysSourceHSE & (SYSCLKFreq_VALUE >26000000) & (SYSCLKFreq_VALUE <48000000) | (SYSCLKFreq_VALUE =48000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                } else if (SysSourceHSI) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale2 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE2;
                    };
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale2 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE2;
                    };
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE0
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value < 80000000) | (HCLKFreq_Value = 80000000)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                }
                scale0 = true;
                const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE0;
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
                        , .{ "PWR_Regulator_Voltage_Scale", "Else", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
                    }
                }
                break :blk item;
            };
            const MSIClockRangeValue: ?MSIClockRangeList = blk: {
                if (scale2 and SysSourceHSE) {
                    const conf_item = config.MSIClockRange;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MSIRANGE_0 => {},
                            .RCC_MSIRANGE_1 => {},
                            .RCC_MSIRANGE_2 => {},
                            .RCC_MSIRANGE_3 => {},
                            .RCC_MSIRANGE_4 => {},
                            .RCC_MSIRANGE_5 => {},
                            .RCC_MSIRANGE_6 => {},
                            .RCC_MSIRANGE_7 => {},
                            .RCC_MSIRANGE_8 => {},
                            .RCC_MSIRANGE_9 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MSIRANGE_0
                                    \\ - RCC_MSIRANGE_1
                                    \\ - RCC_MSIRANGE_2
                                    \\ - RCC_MSIRANGE_3
                                    \\ - RCC_MSIRANGE_4
                                    \\ - RCC_MSIRANGE_5
                                    \\ - RCC_MSIRANGE_6
                                    \\ - RCC_MSIRANGE_7
                                    \\ - RCC_MSIRANGE_8
                                    \\ - RCC_MSIRANGE_9
                                , .{ "MSIClockRange", "scale2 &SysSourceHSE", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MSIRANGE_6;
                }
                const conf_item = config.MSIClockRange;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSIRANGE_0 => {},
                        .RCC_MSIRANGE_1 => {},
                        .RCC_MSIRANGE_2 => {},
                        .RCC_MSIRANGE_3 => {},
                        .RCC_MSIRANGE_4 => {},
                        .RCC_MSIRANGE_5 => {},
                        .RCC_MSIRANGE_6 => {},
                        .RCC_MSIRANGE_7 => {},
                        .RCC_MSIRANGE_8 => {},
                        .RCC_MSIRANGE_9 => {},
                        .RCC_MSIRANGE_10 => {},
                        .RCC_MSIRANGE_11 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MSIRANGE_6;
            };
            const EXTERNALSAI1_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 4.8e4;
            };
            const EXTERNALSAI2_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 4.8e4;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_MSI => PLLSOURCE_MSI = true,
                        .RCC_PLLSOURCE_HSI => PLLSOURCE_HSI = true,
                        .RCC_PLLSOURCE_HSE => PLLSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSOURCE_MSI = true;
                    break :blk .RCC_PLLSOURCE_MSI;
                };
            };
            const PLLSAI1SourceValue: ?PLLSAI1SourceList = blk: {
                const conf_item = config.PLLSAI1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAI1SOURCE_MSI => PLLSAI1SourceMSI = true,
                        .RCC_PLLSAI1SOURCE_HSI => PLLSAI1SourceHSI = true,
                        .RCC_PLLSAI1SOURCE_HSE => PLLSAI1SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSAI1SourceMSI = true;
                    break :blk .RCC_PLLSAI1SOURCE_MSI;
                };
            };
            const PLLSAI2SourceValue: ?PLLSAI2SourceList = blk: {
                const conf_item = config.PLLSAI2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAI2SOURCE_MSI => PLLSAI2SourceMSI = true,
                        .RCC_PLLSAI2SOURCE_HSI => PLLSAI2SourceHSI = true,
                        .RCC_PLLSAI2SOURCE_HSE => PLLSAI2SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSAI2SourceMSI = true;
                    break :blk .RCC_PLLSAI2SOURCE_MSI;
                };
            };
            const PLLMValue: ?f32 = blk: {
                const config_val = config.PLLM;
                if (config_val) |val| {
                    if (val < 1) {
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
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
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
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLSAI1MValue: ?f32 = blk: {
                const config_val = config.PLLSAI1M;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI1M",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI1M",
                            "Else",
                            "No Extra Log",
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLSAI2MValue: ?f32 = blk: {
                const config_val = config.PLLSAI2M;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI2M",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI2M",
                            "Else",
                            "No Extra Log",
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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

                break :blk conf_item orelse {
                    RTCSourceLSI = true;
                    break :blk .RCC_RTCCLKSOURCE_LSI;
                };
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const LCDFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.USART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART1CLKSOURCE_PCLK2 => USART1SourcePCLK2 = true,
                            .RCC_USART1CLKSOURCE_SYSCLK => USART1SourceSys = true,
                            .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART1CLKSOURCE_PCLK2
                                    \\ - RCC_USART1CLKSOURCE_SYSCLK
                                    \\ - RCC_USART1CLKSOURCE_HSI
                                , .{ "USART1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART1SourcePCLK2 = true;
                        break :blk .RCC_USART1CLKSOURCE_PCLK2;
                    };
                }
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
                break :blk 4e6;
            };
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.USART2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART2CLKSOURCE_PCLK1 => USART2SourcePCLK1 = true,
                            .RCC_USART2CLKSOURCE_SYSCLK => USART2SourceSys = true,
                            .RCC_USART2CLKSOURCE_HSI => USART2SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART2CLKSOURCE_PCLK1
                                    \\ - RCC_USART2CLKSOURCE_SYSCLK
                                    \\ - RCC_USART2CLKSOURCE_HSI
                                , .{ "USART2CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART2SourcePCLK1 = true;
                        break :blk .RCC_USART2CLKSOURCE_PCLK1;
                    };
                }
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
                break :blk 4e6;
            };
            const USART3CLockSelectionValue: ?USART3CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.USART3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART3CLKSOURCE_PCLK1 => USART3SourcePCLK1 = true,
                            .RCC_USART3CLKSOURCE_SYSCLK => USART3SourceSys = true,
                            .RCC_USART3CLKSOURCE_HSI => USART3SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART3CLKSOURCE_PCLK1
                                    \\ - RCC_USART3CLKSOURCE_SYSCLK
                                    \\ - RCC_USART3CLKSOURCE_HSI
                                , .{ "USART3CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART3SourcePCLK1 = true;
                        break :blk .RCC_USART3CLKSOURCE_PCLK1;
                    };
                }
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
                break :blk 4e6;
            };
            const UART4CLockSelectionValue: ?UART4CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.UART4CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_UART4CLKSOURCE_PCLK1 => UART4SourcePCLK1 = true,
                            .RCC_UART4CLKSOURCE_SYSCLK => UART4Sourcesys = true,
                            .RCC_UART4CLKSOURCE_HSI => UART4SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_UART4CLKSOURCE_PCLK1
                                    \\ - RCC_UART4CLKSOURCE_SYSCLK
                                    \\ - RCC_UART4CLKSOURCE_HSI
                                , .{ "UART4CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        UART4SourcePCLK1 = true;
                        break :blk .RCC_UART4CLKSOURCE_PCLK1;
                    };
                }
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
                break :blk 4e6;
            };
            const UART5CLockSelectionValue: ?UART5CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.UART5CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_UART5CLKSOURCE_PCLK1 => UART5SourcePCLK1 = true,
                            .RCC_UART5CLKSOURCE_SYSCLK => UART5Sourcesys = true,
                            .RCC_UART5CLKSOURCE_HSI => UART5SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_UART5CLKSOURCE_PCLK1
                                    \\ - RCC_UART5CLKSOURCE_SYSCLK
                                    \\ - RCC_UART5CLKSOURCE_HSI
                                , .{ "UART5CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        UART5SourcePCLK1 = true;
                        break :blk .RCC_UART5CLKSOURCE_PCLK1;
                    };
                }
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
                break :blk 4e6;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPUART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPUART1CLKSOURCE_PCLK1 => LPUART1SourcePCLK1 = true,
                            .RCC_LPUART1CLKSOURCE_SYSCLK => LPUART1SourceSys = true,
                            .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPUART1CLKSOURCE_PCLK1
                                    \\ - RCC_LPUART1CLKSOURCE_SYSCLK
                                    \\ - RCC_LPUART1CLKSOURCE_HSI
                                , .{ "LPUART1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPUART1SourcePCLK1 = true;
                        break :blk .RCC_LPUART1CLKSOURCE_PCLK1;
                    };
                }
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
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM1CLKSOURCE_PCLK1 => {},
                            .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                            .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM1CLKSOURCE_PCLK1
                                    \\ - RCC_LPTIM1CLKSOURCE_LSI
                                    \\ - RCC_LPTIM1CLKSOURCE_HSI
                                , .{ "LPTIM1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK1;
                }
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
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                            .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                            .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM2CLKSOURCE_PCLK1
                                    \\ - RCC_LPTIM2CLKSOURCE_LSI
                                    \\ - RCC_LPTIM2CLKSOURCE_HSI
                                , .{ "LPTIM2CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
                }
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                        .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const DFSDMCLockSelectionValue: ?DFSDMCLockSelectionList = blk: {
                const conf_item = config.DFSDMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1CLKSOURCE_PCLK2 => DFSDMSourcePCLK = true,
                        .RCC_DFSDM1CLKSOURCE_SYSCLK => DFSDMSourceSys = true,
                    }
                }

                break :blk conf_item orelse {
                    DFSDMSourcePCLK = true;
                    break :blk .RCC_DFSDM1CLKSOURCE_PCLK2;
                };
            };
            const DFSDMFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_PLLSAI1 => ADCSourcePLLSAI1R = true,
                        .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                    }
                }

                break :blk conf_item orelse {
                    ADCSourcePLLSAI1R = true;
                    break :blk .RCC_ADCCLKSOURCE_PLLSAI1;
                };
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                ADCFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.1e8,
                };

                break :blk null;
            };
            const CK48CLockSelectionValue: ?CK48CLockSelectionList = blk: {
                const conf_item = config.CK48CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLLSAI1 => CK48SourcePLLSAI1 = true,
                        .RCC_USBCLKSOURCE_PLL => CK48SourcePLLCLK = true,
                        .RCC_USBCLKSOURCE_MSI => CK48SourceMSI = true,
                        .RCC_USBCLKSOURCE_HSI48 => CK48SourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    CK48SourcePLLSAI1 = true;
                    break :blk .RCC_USBCLKSOURCE_PLLSAI1;
                };
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USBUsed_ForRCC) {
                    break :blk 4.8e7;
                }
                break :blk 1.6e7;
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                RNGFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };
            const SDMMCClockSelectionValue: ?SDMMCClockSelectionList = blk: {
                const conf_item = config.SDMMCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC1CLKSOURCE_PLLP => SDMMC1SourceIsPllP = true,
                        .RCC_SDIOCLKSOURCE_CLK48 => SDMMC1SourceIsClock48 = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1SourceIsPllP = true;
                    break :blk .RCC_SDMMC1CLKSOURCE_PLLP;
                };
            };
            const SDMMCFreq_ValueValue: ?f32 = blk: {
                SDMMCFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };
            const FDCANClockSelectionValue: ?FDCANClockSelectionList = blk: {
                const conf_item = config.FDCANClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_PLL => FDCANSourcePLL = true,
                        .RCC_FDCANCLKSOURCE_PLLSAI1 => FDCANSourcePLLSAI1 = true,
                        .RCC_FDCANCLKSOURCE_HSE => FDCANSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    FDCANSourcePLL = true;
                    break :blk .RCC_FDCANCLKSOURCE_PLL;
                };
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                break :blk 4e6;
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
                break :blk 4e6;
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
                break :blk 4e6;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLLSAI1 => SAI1SourcePLLSAI1P = true,
                        .RCC_SAI1CLKSOURCE_PLLSAI2 => SAI1SourcePLLSAI2P = true,
                        .RCC_SAI1CLKSOURCE_PLL => SAI1SourcePLLP = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                        .RCC_SAI1CLKSOURCE_HSI => SAI1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1SourcePLLSAI1P = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLLSAI1;
                };
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                break :blk 2.285714e6;
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLLSAI1 => SAI2SourcePLLSAI1P = true,
                        .RCC_SAI2CLKSOURCE_PLLSAI2 => SAI2SourcePLLSAI2P = true,
                        .RCC_SAI2CLKSOURCE_PLL => SAI2SourcePLLP = true,
                        .RCC_SAI2CLKSOURCE_PIN => SAI2SourceEXT = true,
                        .RCC_SAI2CLKSOURCE_HSI => SAI2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2SourcePLLSAI1P = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLLSAI1;
                };
            };
            const SAI2Freq_ValueValue: ?f32 = blk: {
                break :blk 2.285714e6;
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
                break :blk 4e6;
            };
            const OCTOSPIMCLockSelectionValue: ?OCTOSPIMCLockSelectionList = blk: {
                const conf_item = config.OCTOSPIMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_OSPICLKSOURCE_MSI => OCTOSPIMSourceMSI = true,
                        .RCC_OSPICLKSOURCE_SYSCLK => OCTOSPIMSourceSYS = true,
                        .RCC_OSPICLKSOURCE_PLL => OCTOSPIMSourcePLL = true,
                    }
                }

                break :blk conf_item orelse {
                    OCTOSPIMSourceSYS = true;
                    break :blk .RCC_OSPICLKSOURCE_SYSCLK;
                };
            };
            const OCTOSPIMFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM3CLKSOURCE_PCLK1 => {},
                            .RCC_LPTIM3CLKSOURCE_LSI => LPTIM3SOURCELSI = true,
                            .RCC_LPTIM3CLKSOURCE_HSI => LPTIM3SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM3CLKSOURCE_PCLK1
                                    \\ - RCC_LPTIM3CLKSOURCE_LSI
                                    \\ - RCC_LPTIM3CLKSOURCE_HSI
                                , .{ "LPTIM3CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPTIM3CLKSOURCE_PCLK1;
                }
                const conf_item = config.LPTIM3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM3CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM3CLKSOURCE_LSI => LPTIM3SOURCELSI = true,
                        .RCC_LPTIM3CLKSOURCE_HSI => LPTIM3SOURCEHSI = true,
                        .RCC_LPTIM3CLKSOURCE_LSE => LPTIM3SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM3CLKSOURCE_PCLK1;
            };
            const LPTIM3Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const DFSDMAudioCLockSelectionValue: ?DFSDMAudioCLockSelectionList = blk: {
                const conf_item = config.DFSDMAudioCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1AUDIOCLKSOURCE_MSI => DFSDMAudioSourceMSI = true,
                        .RCC_DFSDM1AUDIOCLKSOURCE_HSI => DFSDMAudioSourceHSI = true,
                        .RCC_DFSDM1AUDIOCLKSOURCE_SAI1 => DFSDMAudioSourceSAI = true,
                    }
                }

                break :blk conf_item orelse {
                    DFSDMAudioSourceMSI = true;
                    break :blk .RCC_DFSDM1AUDIOCLKSOURCE_MSI;
                };
            };
            const DFSDMAudioFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.RCC_MCO1Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => MCOSourcesys = true,
                            .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                            .RCC_MCO1SOURCE_MSI => MCOSourceMSI = true,
                            .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                            .RCC_MCO1SOURCE_PLLCLK => MCOSourcePLL = true,
                            .RCC_MCO1SOURCE_LSI => MCOSourceLSI = true,
                            .RCC_MCO1SOURCE_HSI48 => MCOSourceHSI48 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MCO1SOURCE_SYSCLK
                                    \\ - RCC_MCO1SOURCE_HSI
                                    \\ - RCC_MCO1SOURCE_MSI
                                    \\ - RCC_MCO1SOURCE_HSE
                                    \\ - RCC_MCO1SOURCE_PLLCLK
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_HSI48
                                , .{ "RCC_MCO1Source", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        MCOSourcesys = true;
                        break :blk .RCC_MCO1SOURCE_SYSCLK;
                    };
                }
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => MCOSourcesys = true,
                        .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                        .RCC_MCO1SOURCE_MSI => MCOSourceMSI = true,
                        .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                        .RCC_MCO1SOURCE_PLLCLK => MCOSourcePLL = true,
                        .RCC_MCO1SOURCE_LSE => MCOSourceLSE = true,
                        .RCC_MCO1SOURCE_LSI => MCOSourceLSI = true,
                        .RCC_MCO1SOURCE_HSI48 => MCOSourceHSI48 = true,
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
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    LSCOSSourceLSI = true;
                    const item: LSCOSource1List = .RCC_LSCOSOURCE_LSI;
                    const conf_item = config.LSCOSource1;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSCOSource1", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", "RCC_LSCOSOURCE_LSI", i });
                        }
                    }
                    break :blk item;
                }
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
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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

                break :blk conf_item orelse {
                    AHBCLKDivider1 = true;
                    break :blk .RCC_SYSCLK_DIV1;
                };
            };
            const PWRFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                break :blk 4e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.1e8,
                };

                break :blk null;
            };
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const APB1TimFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                    .max = 1.1e8,
                };

                break :blk null;
            };
            const APB2TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const APB2TimFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const UCPD1outputFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 8) {
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
                            8,
                            val,
                        });
                    }
                    if (val > 86) {
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
                            86,
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
                        .RCC_PLLP_DIV7 => {},
                        .RCC_PLLP_DIV17 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const PLLPoutputFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLP and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLP and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SDMMC1SourceIsPllP and config.flags.SDMMC1Used_ForRCC))) {
                    PLLPoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
            };
            const PLLQValue: ?PLLQList = blk: {
                const conf_item = config.PLLQ;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLQ_DIV2 => {},
                        .RCC_PLLQ_DIV4 => {},
                        .RCC_PLLQ_DIV6 => {},
                        .RCC_PLLQ_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLQ_DIV2;
            };
            const PLLQoutputFreq_ValueValue: ?f32 = blk: {
                if ((FDCANSourcePLL and config.flags.FDCAN1Used_ForRCC) or ((config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC) and CK48SourcePLLCLK) or ((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) and OCTOSPIMSourcePLL) or (CK48SourcePLLCLK and SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const PLLRValue: ?PLLRList = blk: {
                const conf_item = config.PLLR;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLR_DIV2 => {},
                        .RCC_PLLR_DIV4 => {},
                        .RCC_PLLR_DIV6 => {},
                        .RCC_PLLR_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLR_DIV2;
            };
            const PLLSAI1NValue: ?f32 = blk: {
                const config_val = config.PLLSAI1N;
                if (config_val) |val| {
                    if (val < 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI1N",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                    if (val > 86) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI1N",
                            "Else",
                            "No Extra Log",
                            86,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 8;
            };
            const PLLSAI1PValue: ?PLLSAI1PList = blk: {
                const conf_item = config.PLLSAI1P;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV7 => {},
                        .RCC_PLLP_DIV17 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const PLLSAI1PoutputFreq_ValueValue: ?f32 = blk: {
                if ((FDCANSourcePLLSAI1 and config.flags.FDCAN1Used_ForRCC) or ((SAI1SourcePLLSAI1P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMAudioSourceSAI))) or (SAI2SourcePLLSAI1P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    PLLSAI1PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
            };
            const PLLSAI1QValue: ?PLLSAI1QList = blk: {
                const conf_item = config.PLLSAI1Q;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLQ_DIV2 => {},
                        .RCC_PLLQ_DIV4 => {},
                        .RCC_PLLQ_DIV6 => {},
                        .RCC_PLLQ_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLQ_DIV2;
            };
            const PLLSAI1QoutputFreq_ValueValue: ?f32 = blk: {
                if (((config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC) and CK48SourcePLLSAI1) or (CK48SourcePLLSAI1 and SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) {
                    PLLSAI1QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const PLLSAI1RValue: ?PLLSAI1RList = blk: {
                const conf_item = config.PLLSAI1R;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLR_DIV2 => {},
                        .RCC_PLLR_DIV4 => {},
                        .RCC_PLLR_DIV6 => {},
                        .RCC_PLLR_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLR_DIV2;
            };
            const PLLSAI1RoutputFreq_ValueValue: ?f32 = blk: {
                if ((ADCSourcePLLSAI1R and ((config.flags.USE_ADC1 or config.flags.USE_ADC2)))) {
                    PLLSAI1RoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const PLLSAI2NValue: ?f32 = blk: {
                const config_val = config.PLLSAI2N;
                if (config_val) |val| {
                    if (val < 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI2N",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                    if (val > 86) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI2N",
                            "Else",
                            "No Extra Log",
                            86,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 8;
            };
            const PLLSAI2PValue: ?PLLSAI2PList = blk: {
                const conf_item = config.PLLSAI2P;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV7 => {},
                        .RCC_PLLP_DIV17 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const PLLSAI2PoutputFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI2P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLSAI2P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    PLLSAI2PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
            };
            const MSI_VALUEValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (FDCANSourcePLL and config.flags.FDCAN1Used_ForRCC or ((CK48SourcePLLCLK and SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC) or (SDMMC1SourceIsPllP and config.flags.SDMMC1Used_ForRCC) or (SAI1SourcePLLP and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLP and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SysSourcePLL) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or (CK48SourcePLLCLK and (config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC) or OCTOSPIMSourcePLL and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) {
                    VCOInputFreq_ValueLimit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLLSAI1UsedValue: ?f32 = blk: {
                if ((FDCANSourcePLLSAI1 and config.flags.FDCAN1Used_ForRCC) or ((SAI1SourcePLLSAI1P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (DFSDMAudioSourceSAI and config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and SAI1SourcePLLSAI1P) or (SAI2SourcePLLSAI1P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC))) or (ADCSourcePLLSAI1R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (CK48SourcePLLSAI1 and (config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC)) or (CK48SourcePLLSAI1 and SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput2Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLSAI1UsedValue), PLLSAI1UsedValue, 1, .@"="))) {
                    VCOInput2Freq_ValueLimit = .{
                        .min = 2.66e6,
                        .max = 8e6,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLLSAI2UsedValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI2P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (DFSDMAudioSourceSAI and config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and SAI1SourcePLLSAI2P) or (SAI2SourcePLLSAI2P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLSAI2UsedValue), PLLSAI2UsedValue, 1, .@"="))) {
                    VCOInput3Freq_ValueLimit = .{
                        .min = 2.66e6,
                        .max = 8e6,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const VCOOutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = 6.4e7,
                        .max = 3.44e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
            };
            const PLLRCLKFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLRCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const VCOSAI1OutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLSAI1UsedValue), PLLSAI1UsedValue, 1, .@"=")) {
                    VCOSAI1OutputFreq_ValueLimit = .{
                        .min = 6.4e7,
                        .max = 3.44e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
            };
            const VCOSAI2OutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLSAI2UsedValue), PLLSAI2UsedValue, 1, .@"=")) {
                    VCOSAI2OutputFreq_ValueLimit = .{
                        .min = 6.4e7,
                        .max = 3.44e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_0 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_0
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 8000000)|(HCLKFreq_Value= 8000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value= 16000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 26000000)|(HCLKFreq_Value= 26000000 )))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<"))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_0 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_0
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 20000000) |(HCLKFreq_Value < 20000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 40000000)|(HCLKFreq_Value= 40000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value= 80000000 )))", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale0 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                , .{ "FLatency", "(scale0 & ((HCLKFreq_Value < 40000000)|(HCLKFreq_Value= 40000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale0 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale0 & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale0 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                , .{ "FLatency", "(scale0 & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value= 80000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale0 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_4 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_4
                                , .{ "FLatency", "(scale0 & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value= 100000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_4;
                }
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
                        , .{ "FLatency", "Else", "No Extra Log", "FLASH_LATENCY_5", i });
                    }
                }
                break :blk item;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
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
                    if (val > 127) {
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const LSEStateValue: ?LSEStateList = blk: {
                if (config.flags.LSEByPassRTC) {
                    const item: LSEStateList = .RCC_LSE_BYPASS_RTC_ONLY;
                    const conf_item = config.LSEState;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSEState", "LSEByPassRTC", "LSE BYPass for RTC only", "RCC_LSE_BYPASS_RTC_ONLY", i });
                        }
                    }
                    break :blk item;
                } else if (config.flags.LSEOscillatorRTC) {
                    const item: LSEStateList = .RCC_LSE_ON_RTC_ONLY;
                    const conf_item = config.LSEState;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSEState", "LSEOscillatorRTC", "Lse on for RTC only", "RCC_LSE_ON_RTC_ONLY", i });
                        }
                    }
                    break :blk item;
                } else if (config.flags.LSEByPass) {
                    const item: LSEStateList = .RCC_LSE_BYPASS;
                    const conf_item = config.LSEState;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSEState", "LSEByPass", "LSE BYPass", "RCC_LSE_BYPASS", i });
                        }
                    }
                    break :blk item;
                } else if (config.flags.LSEOscillator) {
                    const item: LSEStateList = .RCC_LSE_ON;
                    const conf_item = config.LSEState;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSEState", "LSEOscillator", "LSE ON", "RCC_LSE_ON", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.LSEState;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSE_OFF => {},
                        .RCC_LSE_ON => {},
                        .RCC_LSE_BYPASS => {},
                        .RCC_LSE_BYPASS_RTC_ONLY => {},
                        .RCC_LSE_ON_RTC_ONLY => {},
                    }
                }

                break :blk conf_item orelse .RCC_LSE_OFF;
            };
            const MSIAutoCalibrationValue: ?MSIAutoCalibrationList = blk: {
                if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourceMSI or ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourcePLLCLK and check_MCU("PLLSourceMSI")) or ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourcePLLSAI1 and PLLSAI1SourceMSI)) or SDMMC1SourceIsPllP and config.flags.SDMMC1Used_ForRCC and check_MCU("PLLSourceMSI")) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .ENABLED;
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & ((USBUsed_ForRCC |(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC)) & CK48SourceMSI|((USBUsed_ForRCC |(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC))&CK48SourcePLLCLK&PLLSourceMSI)|((USBUsed_ForRCC |(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC))&CK48SourcePLLSAI1&PLLSAI1SourceMSI)) | SDMMC1SourceIsPllP & SDMMC1Used_ForRCC &PLLSourceMSI", "No Extra Log", "ENABLED", i });
                        }
                    }
                    break :blk item;
                } else if ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourceMSI or ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourcePLLCLK and check_MCU("PLLSourceMSI")) or ((config.flags.USBUsed_ForRCC or (SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC)) and CK48SourcePLLSAI1 and PLLSAI1SourceMSI) or SDMMC1SourceIsPllP and config.flags.SDMMC1Used_ForRCC and check_MCU("PLLSourceMSI")) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .ENABLED;
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
                            , .{ "MSIAutoCalibration", "(USBUsed_ForRCC|(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC)) & CK48SourceMSI|((USBUsed_ForRCC |(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC))&CK48SourcePLLCLK&PLLSourceMSI)|((USBUsed_ForRCC |(SDMMC1SourceIsClock48 & SDMMC1Used_ForRCC))&CK48SourcePLLSAI1&PLLSAI1SourceMSI) | SDMMC1SourceIsPllP & SDMMC1Used_ForRCC &PLLSourceMSI", "No Extra Log", "ENABLED", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.MSIAutoCalibration;
                if (conf_item) |item| {
                    switch (item) {
                        .DISABLED => {},
                        .ENABLED => MSIAutoCalibrationON = true,
                    }
                }

                break :blk conf_item orelse .DISABLED;
            };
            const PrescalerValue: ?PrescalerList = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.Prescaler) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Prescaler", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                }
                const conf_item = config.extra.Prescaler;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CRS_SYNC_DIV1 => RccCrsSyncDiv1 = true,
                        .RCC_CRS_SYNC_DIV2 => RccCrsSyncDiv2 = true,
                        .RCC_CRS_SYNC_DIV4 => RccCrsSyncDiv4 = true,
                        .RCC_CRS_SYNC_DIV8 => RccCrsSyncDiv8 = true,
                        .RCC_CRS_SYNC_DIV16 => RccCrsSyncDiv16 = true,
                        .RCC_CRS_SYNC_DIV32 => RccCrsSyncDiv32 = true,
                        .RCC_CRS_SYNC_DIV64 => RccCrsSyncDiv64 = true,
                        .RCC_CRS_SYNC_DIV128 => RccCrsSyncDiv128 = true,
                    }
                }

                break :blk conf_item orelse {
                    RccCrsSyncDiv1 = true;
                    break :blk .RCC_CRS_SYNC_DIV1;
                };
            };
            const SourceValue: ?SourceList = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceGPIO) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_GPIO;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceLSE) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_LSE;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB;
                    break :blk item;
                }
                const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB;
                break :blk item;
            };
            const PolarityValue: ?PolarityList = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.Polarity) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Polarity", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                }
                const conf_item = config.extra.Polarity;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CRS_SYNC_POLARITY_RISING => {},
                        .RCC_CRS_SYNC_POLARITY_FALLING => {},
                    }
                }

                break :blk conf_item orelse .RCC_CRS_SYNC_POLARITY_RISING;
            };
            const ReloadValueTypeValue: ?ReloadValueTypeList = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.ReloadValueType) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValueType", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                }
                const conf_item = config.extra.ReloadValueType;
                if (conf_item) |item| {
                    switch (item) {
                        .UserValue => UserDefinedReload = true,
                        .automatic => AutomaticRelaod = true,
                    }
                }

                break :blk conf_item orelse {
                    AutomaticRelaod = true;
                    break :blk .automatic;
                };
            };
            const ReloadValueValue: ?f32 = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.ReloadValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValue", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                } else if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.ReloadValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValue", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                } else if (AutomaticRelaod) {
                    if (config.extra.ReloadValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValue", "AutomaticRelaod", "No Extra Log" });
                    }
                    break :blk null;
                } else if (UserDefinedReload and config.flags.CRSActivatedSourceGPIO) {
                    const config_val = config.extra.ReloadValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceGPIO ",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                        if (val > 65535) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceGPIO ",
                                "No Extra Log",
                                65535,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
                } else if (UserDefinedReload and config.flags.CRSActivatedSourceLSE) {
                    const config_val = config.extra.ReloadValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceLSE ",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                        if (val > 65535) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceLSE ",
                                "No Extra Log",
                                65535,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1463;
                } else if (UserDefinedReload and config.flags.CRSActivatedSourceUSB) {
                    const config_val = config.extra.ReloadValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceUSB ",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                        if (val > 65535) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "ReloadValue",
                                "UserDefinedReload & CRSActivatedSourceUSB ",
                                "No Extra Log",
                                65535,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 47999;
                }
                const config_val = config.extra.ReloadValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "ReloadValue",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 65535) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "ReloadValue",
                            "Else",
                            "No Extra Log",
                            65535,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else null;
            };
            const FsyncValue: ?f32 = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    break :blk null;
                }
                break :blk null;
            };
            const LSEFsyncValue: ?f32 = blk: {
                if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv1) {
                    const val: ?f32 = LSE_VALUEValue;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv2) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 2, .@"/", "LSEFsync", "LSE_VALUE", "2");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv4) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 4, .@"/", "LSEFsync", "LSE_VALUE", "4");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv8) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 8, .@"/", "LSEFsync", "LSE_VALUE", "8");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv16) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 16, .@"/", "LSEFsync", "LSE_VALUE", "16");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv32) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 32, .@"/", "LSEFsync", "LSE_VALUE", "32");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv64) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 64, .@"/", "LSEFsync", "LSE_VALUE", "64");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv128) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 128, .@"/", "LSEFsync", "LSE_VALUE", "128");
                    break :blk val;
                }
                break :blk null;
            };
            const GPIOFsyncValue: ?f32 = blk: {
                if (config.flags.CRSActivatedSourceGPIO) {
                    const config_val = config.extra.GPIOFsync;
                    if (config_val) |val| {
                        if (val < 1) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "GPIOFsync",
                                "CRSActivatedSourceGPIO",
                                "No Extra Log",
                                1,
                                val,
                            });
                        }
                        if (val > 48000000) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "GPIOFsync",
                                "CRSActivatedSourceGPIO",
                                "No Extra Log",
                                48000000,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
                }
                break :blk null;
            };
            const USBFsyncValue: ?f32 = blk: {
                if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv1) {
                    const val: ?f32 = @min(1000, std.math.floatMax(f32));
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv2) {
                    const val: ?f32 = 1000 / 2;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv4) {
                    const val: ?f32 = 1000 / 4;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv8) {
                    const val: ?f32 = 1000 / 8;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv16) {
                    const val: ?f32 = 1000 / 16;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv32) {
                    const val: ?f32 = 1000 / 32;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv64) {
                    const val: ?f32 = 1000 / 64;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv128) {
                    const val: ?f32 = 1000 / 128;
                    break :blk val;
                }
                break :blk null;
            };
            const ErrorLimitValueValue: ?f32 = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.ErrorLimitValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ErrorLimitValue", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                }
                const config_val = config.extra.ErrorLimitValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "ErrorLimitValue",
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
                            "ErrorLimitValue",
                            "Else",
                            "No Extra Log",
                            255,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 34;
            };
            const HSI48CalibrationValueValue: ?f32 = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.HSI48CalibrationValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "HSI48CalibrationValue", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                }
                const config_val = config.extra.HSI48CalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSI48CalibrationValue",
                            "Else",
                            "No Extra Log",
                            0,
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
                            "HSI48CalibrationValue",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
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
            const MSIUsedValue: ?f32 = blk: {
                if ((CK48SourceMSI and SDMMC1SourceIsClock48 and config.flags.SDMMC1Used_ForRCC) or (OCTOSPIMSourceMSI and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (DFSDMAudioSourceMSI and (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (check_MCU("SEM2RCC_MSI_REQUIRED_TIM17") and check_MCU("TIM17") and check_MCU("Semaphore_input_Channel1TIM17")) or (CK48SourceMSI and (config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC)) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or check_MCU("PLLSourceMSI") and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or (PLLSAI1SourceMSI and check_ref(@TypeOf(PLLSAI1UsedValue), PLLSAI1UsedValue, 1, .@"=")) or (PLLSAI2SourceMSI and check_ref(@TypeOf(PLLSAI2UsedValue), PLLSAI2UsedValue, 1, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((MSIAutoCalibrationON and check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=") and (config.flags.LSEByPass or config.flags.LSEOscillator or config.flags.LSEByPassRTC or config.flags.LSEOscillatorRTC)) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (USART2SourceLSE and config.flags.USART2Used_ForRCC) or (USART3SourceLSE and config.flags.USART3Used_ForRCC) or (UART4SourceLSE and config.flags.UART4Used_ForRCC) or (UART5SourceLSE and config.flags.UART5Used_ForRCC) or (LPUART1SourceLSE and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCELSE and config.flags.LPTIM2Used_ForRCC) or (LPTIM3SOURCELSE and config.flags.LPTIM3Used_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSE_Drive_CapabilityValue: ?LSE_Drive_CapabilityList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEOscillatorRTC) and (check_ref(@TypeOf(LSEUsedValue), LSEUsedValue, 1, .@"="))) {
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
            const EnableCRSValue: ?EnableCRSList = blk: {
                if (config.flags.CRSActivatedSourceGPIO or config.flags.CRSActivatedSourceLSE or config.flags.CRSActivatedSourceUSB) {
                    const item: EnableCRSList = .true;
                    break :blk item;
                }
                const item: EnableCRSList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USBUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
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
            const LSIEnableValue: ?LSIEnableList = blk: {
                const item: LSIEnableList = .true;
                break :blk item;
            };
            const EnableExtClockForSAI1Value: ?EnableExtClockForSAI1List = blk: {
                if (config.flags.SAI1EXTCLK) {
                    const item: EnableExtClockForSAI1List = .true;
                    break :blk item;
                }
                const item: EnableExtClockForSAI1List = .false;
                break :blk item;
            };
            const EnableExtClockForSAI2Value: ?EnableExtClockForSAI2List = blk: {
                if (config.flags.SAI2EXTCLK) {
                    const item: EnableExtClockForSAI2List = .true;
                    break :blk item;
                }
                const item: EnableExtClockForSAI2List = .false;
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
                if (config.flags.RTCUsed_ForRCC) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCDUsed_ForRCC) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
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
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUARTUsed_ForRCC) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1Used_ForRCC) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const LPTIM2EnableValue: ?LPTIM2EnableList = blk: {
                if (config.flags.LPTIM2Used_ForRCC) {
                    const item: LPTIM2EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM2EnableList = .false;
                break :blk item;
            };
            const DFSDMEnableValue: ?DFSDMEnableList = blk: {
                if (config.flags.DFSDM1Used_ForRCC) {
                    const item: DFSDMEnableList = .true;
                    break :blk item;
                }
                const item: DFSDMEnableList = .false;
                break :blk item;
            };
            const DFSDMAudioEnableValue: ?DFSDMAudioEnableList = blk: {
                if (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")) {
                    const item: DFSDMAudioEnableList = .true;
                    break :blk item;
                }
                const item: DFSDMAudioEnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1Used_ForRCC) {
                    const item: FDCANEnableList = .true;
                    break :blk item;
                }
                const item: FDCANEnableList = .false;
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
            const SAI1EnableValue: ?SAI1EnableList = blk: {
                if ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                }
                const item: SAI1EnableList = .false;
                break :blk item;
            };
            const SAI2EnableValue: ?SAI2EnableList = blk: {
                if (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC) {
                    const item: SAI2EnableList = .true;
                    break :blk item;
                }
                const item: SAI2EnableList = .false;
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
            const OCTOSPIMEnableValue: ?OCTOSPIMEnableList = blk: {
                if (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) {
                    const item: OCTOSPIMEnableList = .true;
                    break :blk item;
                }
                const item: OCTOSPIMEnableList = .false;
                break :blk item;
            };
            const LPTIM3EnableValue: ?LPTIM3EnableList = blk: {
                if (config.flags.LPTIM3Used_ForRCC) {
                    const item: LPTIM3EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM3EnableList = .false;
                break :blk item;
            };
            const LSCOEnableValue: ?LSCOEnableList = blk: {
                if (config.flags.LSCOConfig) {
                    const item: LSCOEnableList = .true;
                    break :blk item;
                }
                const item: LSCOEnableList = .false;
                break :blk item;
            };
            const UCPDEnableValue: ?UCPDEnableList = blk: {
                if (config.flags.UCPD1_Used) {
                    const item: UCPDEnableList = .true;
                    break :blk item;
                }
                const item: UCPDEnableList = .false;
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

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var CRSCLKoutput = ClockNode{
                .name = "CRSCLKoutput",
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

            var LSIDIV = ClockNode{
                .name = "LSIDIV",
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

            var SAI1_EXT = ClockNode{
                .name = "SAI1_EXT",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2_EXT = ClockNode{
                .name = "SAI2_EXT",
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

            var PLLSAI1Source = ClockNode{
                .name = "PLLSAI1Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2Source = ClockNode{
                .name = "PLLSAI2Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM = ClockNode{
                .name = "PLLM",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1M = ClockNode{
                .name = "PLLSAI1M",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2M = ClockNode{
                .name = "PLLSAI2M",
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

            var DFSDMMult = ClockNode{
                .name = "DFSDMMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMoutput = ClockNode{
                .name = "DFSDMoutput",
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

            var CK48Mult = ClockNode{
                .name = "CK48Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CK48output = ClockNode{
                .name = "CK48output",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGoutput = ClockNode{
                .name = "RNGoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC1Mult = ClockNode{
                .name = "SDMMC1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMCC1Output = ClockNode{
                .name = "SDMMCC1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var FDCANMult = ClockNode{
                .name = "FDCANMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var FDCANOutput = ClockNode{
                .name = "FDCANOutput",
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

            var OCTOSPIMMult = ClockNode{
                .name = "OCTOSPIMMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var OCTOSPIMoutput = ClockNode{
                .name = "OCTOSPIMoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM3Mult = ClockNode{
                .name = "LPTIM3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM3output = ClockNode{
                .name = "LPTIM3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMAudioMult = ClockNode{
                .name = "DFSDMAudioMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMAudiooutput = ClockNode{
                .name = "DFSDMAudiooutput",
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

            var UCPD1Output = ClockNode{
                .name = "UCPD1Output",
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

            var PLLSAI1N = ClockNode{
                .name = "PLLSAI1N",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1P = ClockNode{
                .name = "PLLSAI1P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1Poutput = ClockNode{
                .name = "PLLSAI1Poutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1Q = ClockNode{
                .name = "PLLSAI1Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1Qoutput = ClockNode{
                .name = "PLLSAI1Qoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1R = ClockNode{
                .name = "PLLSAI1R",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI1Routput = ClockNode{
                .name = "PLLSAI1Routput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2N = ClockNode{
                .name = "PLLSAI2N",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2P = ClockNode{
                .name = "PLLSAI2P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2Poutput = ClockNode{
                .name = "PLLSAI2Poutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSI = ClockNode{
                .name = "MSI",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput = ClockNode{
                .name = "VCOInput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput2 = ClockNode{
                .name = "VCOInput2",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput3 = ClockNode{
                .name = "VCOInput3",
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

            var VCOSAI1Output = ClockNode{
                .name = "VCOSAI1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOSAI2Output = ClockNode{
                .name = "VCOSAI2Output",
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
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CRSFreq_ValueValue);
                CRSCLKoutput.nodetype = .output;
                CRSCLKoutput.parents = &.{&HSI48RC};
            }
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                const HSI48RC_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            }

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

            const LSIDIV_clk_value = LSIDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "LSIDIV",
                "Else",
                "No Extra Log",
                "LSIDIV",
            });
            LSIDIV.nodetype = .div;
            LSIDIV.value = LSIDIV_clk_value.get();
            LSIDIV.parents = &.{&LSIRC};

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
            if (check_ref(@TypeOf(EnableExtClockForSAI1Value), EnableExtClockForSAI1Value, .true, .@"=")) {
                const SAI1_EXT_clk_value = EXTERNALSAI1_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1_EXT",
                    "Else",
                    "No Extra Log",
                    "EXTERNALSAI1_CLOCK_VALUE",
                });
                SAI1_EXT.nodetype = .source;
                SAI1_EXT.value = SAI1_EXT_clk_value;
            }
            if (check_ref(@TypeOf(EnableExtClockForSAI2Value), EnableExtClockForSAI2Value, .true, .@"=")) {
                const SAI2_EXT_clk_value = EXTERNALSAI2_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI2_EXT",
                    "Else",
                    "No Extra Log",
                    "EXTERNALSAI2_CLOCK_VALUE",
                });
                SAI2_EXT.nodetype = .source;
                SAI2_EXT.value = SAI2_EXT_clk_value;
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
                &HSEOSC,
                &PLLR,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
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
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            const PLLSAI1Source_clk_value = PLLSAI1SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAI1Source",
                "Else",
                "No Extra Log",
                "PLLSAI1Source",
            });
            const PLLSAI1Sourceparents = [_]*const ClockNode{
                &MSIRC,
                &HSIRC,
                &HSEOSC,
            };
            PLLSAI1Source.nodetype = .multi;
            PLLSAI1Source.parents = &.{PLLSAI1Sourceparents[PLLSAI1Source_clk_value.get()]};

            const PLLSAI2Source_clk_value = PLLSAI2SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAI2Source",
                "Else",
                "No Extra Log",
                "PLLSAI2Source",
            });
            const PLLSAI2Sourceparents = [_]*const ClockNode{
                &MSIRC,
                &HSIRC,
                &HSEOSC,
            };
            PLLSAI2Source.nodetype = .multi;
            PLLSAI2Source.parents = &.{PLLSAI2Sourceparents[PLLSAI2Source_clk_value.get()]};

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

            const PLLSAI1M_clk_value = PLLSAI1MValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAI1M",
                "Else",
                "No Extra Log",
                "PLLSAI1M",
            });
            PLLSAI1M.nodetype = .div;
            PLLSAI1M.value = PLLSAI1M_clk_value;
            PLLSAI1M.parents = &.{&PLLSAI1Source};

            const PLLSAI2M_clk_value = PLLSAI2MValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAI2M",
                "Else",
                "No Extra Log",
                "PLLSAI2M",
            });
            PLLSAI2M.nodetype = .div;
            PLLSAI2M.value = PLLSAI2M_clk_value;
            PLLSAI2M.parents = &.{&PLLSAI2Source};
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
                    &LSIDIV,
                };
                RTCClkSource.nodetype = .multi;
                RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RTCFreq_ValueValue);
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LCDFreq_ValueValue);
                LCDOutput.nodetype = .output;
                LCDOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
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
            if ((check_MCU("UART5_Exist"))) {
                if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                    const UART5Mult_clk_value = UART5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "UART5Mult",
                        "(UART5_Exist)",
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
            }
            if ((check_MCU("UART5_Exist"))) {
                if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(UART5Freq_ValueValue);
                    UART5output.nodetype = .output;
                    UART5output.parents = &.{&UART5Mult};
                }
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                const LPUART1Mult_clk_value = LPUART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Prescaler,
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
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
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
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM2Mult.nodetype = .multi;
                LPTIM2Mult.parents = &.{LPTIM2Multparents[LPTIM2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM2Freq_ValueValue);
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"="))
            {
                const DFSDMMult_clk_value = DFSDMCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDMMult",
                    "Else",
                    "No Extra Log",
                    "DFSDMCLockSelection",
                });
                const DFSDMMultparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                };
                DFSDMMult.nodetype = .multi;
                DFSDMMult.parents = &.{DFSDMMultparents[DFSDMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DFSDMFreq_ValueValue);
                DFSDMoutput.nodetype = .output;
                DFSDMoutput.parents = &.{&DFSDMMult};
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
                    &PLLSAI1R,
                    &SysCLKOutput,
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
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
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
                    &PLLSAI1Q,
                    &PLLQ,
                    &MSIRC,
                    &HSI48RC,
                };
                CK48Mult.nodetype = .multi;
                CK48Mult.parents = &.{CK48Multparents[CK48Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                CK48output.nodetype = .output;
                CK48output.parents = &.{&CK48Mult};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&CK48Mult};
            }
            if ((check_MCU("SDMMC1_Exist"))) {
                if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                    const SDMMC1Mult_clk_value = SDMMCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SDMMC1Mult",
                        "(SDMMC1_Exist)",
                        "No Extra Log",
                        "SDMMCClockSelection",
                    });
                    const SDMMC1Multparents = [_]*const ClockNode{
                        &PLLP,
                        &CK48Mult,
                    };
                    SDMMC1Mult.nodetype = .multi;
                    SDMMC1Mult.parents = &.{SDMMC1Multparents[SDMMC1Mult_clk_value.get()]};
                }
            }
            if ((check_MCU("SDMMC1_Exist"))) {
                if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SDMMCFreq_ValueValue);
                    SDMMCC1Output.limit = SDMMCFreq_ValueLimit;
                    SDMMCC1Output.nodetype = .output;
                    SDMMCC1Output.parents = &.{&SDMMC1Mult};
                }
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                const FDCANMult_clk_value = FDCANClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FDCANMult",
                    "Else",
                    "No Extra Log",
                    "FDCANClockSelection",
                });
                const FDCANMultparents = [_]*const ClockNode{
                    &PLLQ,
                    &PLLSAI1P,
                    &HSEOSC,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                FDCANOutput.nodetype = .output;
                FDCANOutput.parents = &.{&FDCANMult};
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
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"="))
            {
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
                    &PLLSAI1P,
                    &PLLSAI2P,
                    &PLLP,
                    &SAI1_EXT,
                    &HSIRC,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"="))
            {
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
                    &PLLSAI1P,
                    &PLLSAI2P,
                    &PLLP,
                    &SAI2_EXT,
                    &HSIRC,
                };
                SAI2Mult.nodetype = .multi;
                SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2Freq_ValueValue);
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
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
            if (check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=")) {
                const OCTOSPIMMult_clk_value = OCTOSPIMCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "OCTOSPIMMult",
                    "Else",
                    "No Extra Log",
                    "OCTOSPIMCLockSelection",
                });
                const OCTOSPIMMultparents = [_]*const ClockNode{
                    &MSIRC,
                    &SysCLKOutput,
                    &PLLQ,
                };
                OCTOSPIMMult.nodetype = .multi;
                OCTOSPIMMult.parents = &.{OCTOSPIMMultparents[OCTOSPIMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OCTOSPIMFreq_ValueValue);
                OCTOSPIMoutput.nodetype = .output;
                OCTOSPIMoutput.parents = &.{&OCTOSPIMMult};
            }
            if (check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=")) {
                const LPTIM3Mult_clk_value = LPTIM3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM3Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM3CLockSelection",
                });
                const LPTIM3Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM3Mult.nodetype = .multi;
                LPTIM3Mult.parents = &.{LPTIM3Multparents[LPTIM3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM3Freq_ValueValue);
                LPTIM3output.nodetype = .output;
                LPTIM3output.parents = &.{&LPTIM3Mult};
            }
            if (check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"=")) {
                const DFSDMAudioMult_clk_value = DFSDMAudioCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDMAudioMult",
                    "Else",
                    "No Extra Log",
                    "DFSDMAudioCLockSelection",
                });
                const DFSDMAudioMultparents = [_]*const ClockNode{
                    &MSIRC,
                    &HSIRC,
                    &SAI1Mult,
                };
                DFSDMAudioMult.nodetype = .multi;
                DFSDMAudioMult.parents = &.{DFSDMAudioMultparents[DFSDMAudioMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMAudioFreq_ValueValue);
                DFSDMAudiooutput.nodetype = .output;
                DFSDMAudiooutput.parents = &.{&DFSDMAudioMult};
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
                    &LSIDIV,
                    &HSEOSC,
                    &HSIRC,
                    &PLLR,
                    &SysCLKOutput,
                    &MSIRC,
                    &HSI48RC,
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
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
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
                    &LSIDIV,
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

            std.mem.doNotOptimizeAway(PWRFreq_ValueValue);
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};

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
            if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UCPD1outputFreq_ValueValue);
                UCPD1Output.nodetype = .output;
                UCPD1Output.parents = &.{&HSIRC};
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
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
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
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLPoutputFreq_ValueValue);
                PLLPoutput.limit = PLLPoutputFreq_ValueLimit;
                PLLPoutput.nodetype = .output;
                PLLPoutput.parents = &.{&PLLP};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
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
                PLLQ.value = PLLQ_clk_value.get();
                PLLQ.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLQoutputFreq_ValueValue);
                PLLQoutput.limit = PLLQoutputFreq_ValueLimit;
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLLQ};
            }

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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                const PLLSAI1N_clk_value = PLLSAI1NValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI1N",
                    "Else",
                    "No Extra Log",
                    "PLLSAI1N",
                });
                PLLSAI1N.nodetype = .mul;
                PLLSAI1N.value = PLLSAI1N_clk_value;
                PLLSAI1N.parents = &.{&PLLSAI1M};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                const PLLSAI1P_clk_value = PLLSAI1PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI1P",
                    "Else",
                    "No Extra Log",
                    "PLLSAI1P",
                });
                PLLSAI1P.nodetype = .div;
                PLLSAI1P.value = PLLSAI1P_clk_value.get();
                PLLSAI1P.parents = &.{&PLLSAI1N};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLSAI1PoutputFreq_ValueValue);
                PLLSAI1Poutput.limit = PLLSAI1PoutputFreq_ValueLimit;
                PLLSAI1Poutput.nodetype = .output;
                PLLSAI1Poutput.parents = &.{&PLLSAI1P};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                const PLLSAI1Q_clk_value = PLLSAI1QValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI1Q",
                    "Else",
                    "No Extra Log",
                    "PLLSAI1Q",
                });
                PLLSAI1Q.nodetype = .div;
                PLLSAI1Q.value = PLLSAI1Q_clk_value.get();
                PLLSAI1Q.parents = &.{&PLLSAI1N};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLSAI1QoutputFreq_ValueValue);
                PLLSAI1Qoutput.limit = PLLSAI1QoutputFreq_ValueLimit;
                PLLSAI1Qoutput.nodetype = .output;
                PLLSAI1Qoutput.parents = &.{&PLLSAI1Q};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const PLLSAI1R_clk_value = PLLSAI1RValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI1R",
                    "Else",
                    "No Extra Log",
                    "PLLSAI1R",
                });
                PLLSAI1R.nodetype = .div;
                PLLSAI1R.value = PLLSAI1R_clk_value.get();
                PLLSAI1R.parents = &.{&PLLSAI1N};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PLLSAI1RoutputFreq_ValueValue);
                PLLSAI1Routput.limit = PLLSAI1RoutputFreq_ValueLimit;
                PLLSAI1Routput.nodetype = .output;
                PLLSAI1Routput.parents = &.{&PLLSAI1R};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAI2N_clk_value = PLLSAI2NValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI2N",
                    "Else",
                    "No Extra Log",
                    "PLLSAI2N",
                });
                PLLSAI2N.nodetype = .mul;
                PLLSAI2N.value = PLLSAI2N_clk_value;
                PLLSAI2N.parents = &.{&PLLSAI2M};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAI2P_clk_value = PLLSAI2PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI2P",
                    "Else",
                    "No Extra Log",
                    "PLLSAI2P",
                });
                PLLSAI2P.nodetype = .div;
                PLLSAI2P.value = PLLSAI2P_clk_value.get();
                PLLSAI2P.parents = &.{&PLLSAI2N};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLSAI2PoutputFreq_ValueValue);
                PLLSAI2Poutput.limit = PLLSAI2PoutputFreq_ValueLimit;
                PLLSAI2Poutput.nodetype = .output;
                PLLSAI2Poutput.parents = &.{&PLLSAI2P};
            }

            std.mem.doNotOptimizeAway(MSI_VALUEValue);
            MSI.nodetype = .output;
            MSI.parents = &.{&MSIRC};

            std.mem.doNotOptimizeAway(VCOInputFreq_ValueValue);
            VCOInput.limit = VCOInputFreq_ValueLimit;
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};

            std.mem.doNotOptimizeAway(VCOInput2Freq_ValueValue);
            VCOInput2.limit = VCOInput2Freq_ValueLimit;
            VCOInput2.nodetype = .output;
            VCOInput2.parents = &.{&PLLSAI1M};

            std.mem.doNotOptimizeAway(VCOInput3Freq_ValueValue);
            VCOInput3.limit = VCOInput3Freq_ValueLimit;
            VCOInput3.nodetype = .output;
            VCOInput3.parents = &.{&PLLSAI2M};

            std.mem.doNotOptimizeAway(VCOOutputFreq_ValueValue);
            VCOOutput.limit = VCOOutputFreq_ValueLimit;
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};

            std.mem.doNotOptimizeAway(PLLRCLKFreq_ValueValue);
            PLLCLK.limit = PLLRCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLR};

            std.mem.doNotOptimizeAway(VCOSAI1OutputFreq_ValueValue);
            VCOSAI1Output.limit = VCOSAI1OutputFreq_ValueLimit;
            VCOSAI1Output.nodetype = .output;
            VCOSAI1Output.parents = &.{&PLLSAI1N};

            std.mem.doNotOptimizeAway(VCOSAI2OutputFreq_ValueValue);
            VCOSAI2Output.limit = VCOSAI2OutputFreq_ValueLimit;
            VCOSAI2Output.nodetype = .output;
            VCOSAI2Output.parents = &.{&PLLSAI2N};

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.USART2output = try USART2output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART3output = try USART3output.get_output();
            out.USART3Mult = try USART3Mult.get_output();
            out.UART4output = try UART4output.get_output();
            out.UART4Mult = try UART4Mult.get_output();
            out.UART5output = try UART5output.get_output();
            out.UART5Mult = try UART5Mult.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C2output = try I2C2output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.DFSDMoutput = try DFSDMoutput.get_output();
            out.DFSDMMult = try DFSDMMult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.OCTOSPIMoutput = try OCTOSPIMoutput.get_output();
            out.OCTOSPIMMult = try OCTOSPIMMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.CK48output = try CK48output.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.SDMMCC1Output = try SDMMCC1Output.get_output();
            out.SDMMC1Mult = try SDMMC1Mult.get_output();
            out.CK48Mult = try CK48Mult.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.FDCANOutput = try FDCANOutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.DFSDMAudiooutput = try DFSDMAudiooutput.get_output();
            out.DFSDMAudioMult = try DFSDMAudioMult.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLR = try PLLR.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.PLLSAI1Qoutput = try PLLSAI1Qoutput.get_output();
            out.PLLSAI1Q = try PLLSAI1Q.get_output();
            out.PLLSAI1Poutput = try PLLSAI1Poutput.get_output();
            out.PLLSAI1P = try PLLSAI1P.get_output();
            out.PLLSAI1Routput = try PLLSAI1Routput.get_output();
            out.PLLSAI1R = try PLLSAI1R.get_output();
            out.PLLSAI1N = try PLLSAI1N.get_output();
            out.PLLSAI1M = try PLLSAI1M.get_output();
            out.PLLSAI1Source = try PLLSAI1Source.get_output();
            out.PLLSAI2Poutput = try PLLSAI2Poutput.get_output();
            out.PLLSAI2P = try PLLSAI2P.get_output();
            out.PLLSAI2N = try PLLSAI2N.get_output();
            out.PLLSAI2M = try PLLSAI2M.get_output();
            out.PLLSAI2Source = try PLLSAI2Source.get_output();
            out.UCPD1Output = try UCPD1Output.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.CRSCLKoutput = try CRSCLKoutput.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.LCDOutput = try LCDOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIDIV = try LSIDIV.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.SAI1_EXT = try SAI1_EXT.get_output();
            out.SAI2_EXT = try SAI2_EXT.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.MSI = try MSI.get_extra_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOInput2 = try VCOInput2.get_extra_output();
            out.VCOInput3 = try VCOInput3.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.VCOSAI1Output = try VCOSAI1Output.get_extra_output();
            out.VCOSAI2Output = try VCOSAI2Output.get_extra_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSIDIV = LSIDIVValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.EXTERNALSAI1_CLOCK_VALUE = EXTERNALSAI1_CLOCK_VALUEValue;
            ref_out.EXTERNALSAI2_CLOCK_VALUE = EXTERNALSAI2_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLSAI1Source = PLLSAI1SourceValue;
            ref_out.PLLSAI2Source = PLLSAI2SourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.PLLSAI1M = PLLSAI1MValue;
            ref_out.PLLSAI2M = PLLSAI2MValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.USART3CLockSelection = USART3CLockSelectionValue;
            ref_out.UART4CLockSelection = UART4CLockSelectionValue;
            ref_out.UART5CLockSelection = UART5CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.DFSDMCLockSelection = DFSDMCLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.CK48CLockSelection = CK48CLockSelectionValue;
            ref_out.SDMMCClockSelection = SDMMCClockSelectionValue;
            ref_out.FDCANClockSelection = FDCANClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.DFSDMAudioCLockSelection = DFSDMAudioCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
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
            ref_out.PLLSAI1N = PLLSAI1NValue;
            ref_out.PLLSAI1P = PLLSAI1PValue;
            ref_out.PLLSAI1Q = PLLSAI1QValue;
            ref_out.PLLSAI1R = PLLSAI1RValue;
            ref_out.PLLSAI2N = PLLSAI2NValue;
            ref_out.PLLSAI2P = PLLSAI2PValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.MSIAutoCalibration = MSIAutoCalibrationValue;
            ref_out.Prescaler = PrescalerValue;
            ref_out.Source = SourceValue;
            ref_out.Polarity = PolarityValue;
            ref_out.ReloadValueType = ReloadValueTypeValue;
            ref_out.ReloadValue = ReloadValueValue;
            ref_out.Fsync = FsyncValue;
            ref_out.LSEFsync = LSEFsyncValue;
            ref_out.GPIOFsync = GPIOFsyncValue;
            ref_out.USBFsync = USBFsyncValue;
            ref_out.ErrorLimitValue = ErrorLimitValueValue;
            ref_out.HSI48CalibrationValue = HSI48CalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.EnableCRS = EnableCRSValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.SDMMCEnable = SDMMCEnableValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.EnableExtClockForSAI1 = EnableExtClockForSAI1Value;
            ref_out.EnableExtClockForSAI2 = EnableExtClockForSAI2Value;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.EnableHSELCDDevisor = EnableHSELCDDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART3Enable = USART3EnableValue;
            ref_out.UART4Enable = UART4EnableValue;
            ref_out.UART5Enable = UART5EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.DFSDMEnable = DFSDMEnableValue;
            ref_out.DFSDMAudioEnable = DFSDMAudioEnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.SAI2Enable = SAI2EnableValue;
            ref_out.I2C4Enable = I2C4EnableValue;
            ref_out.OCTOSPIMEnable = OCTOSPIMEnableValue;
            ref_out.LPTIM3Enable = LPTIM3EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.UCPDEnable = UCPDEnableValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.PLLSAI1Used = PLLSAI1UsedValue;
            ref_out.PLLSAI2Used = PLLSAI2UsedValue;
            ref_out.LSEState = LSEStateValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.MSIUsed = MSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
