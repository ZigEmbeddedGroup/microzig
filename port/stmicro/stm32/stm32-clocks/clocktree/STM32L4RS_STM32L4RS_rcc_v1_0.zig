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
pub const DFSDMCLockSelectionList = enum {
    RCC_DFSDM1CLKSOURCE_PCLK,
    RCC_DFSDM1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1CLKSOURCE_PCLK => 0,
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
pub const DSICLockSelectionList = enum {
    RCC_DSICLKSOURCE_PLLSAI2,
    RCC_DSICLKSOURCE_DSIPHY,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DSICLKSOURCE_PLLSAI2 => 0,
            .RCC_DSICLKSOURCE_DSIPHY => 1,
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
            .RCC_MSIRANGE_0 => 100,
            .RCC_MSIRANGE_1 => 200,
            .RCC_MSIRANGE_2 => 400,
            .RCC_MSIRANGE_3 => 800,
            .RCC_MSIRANGE_4 => 1000,
            .RCC_MSIRANGE_5 => 2000,
            .RCC_MSIRANGE_6 => 4000,
            .RCC_MSIRANGE_7 => 8000,
            .RCC_MSIRANGE_8 => 16000,
            .RCC_MSIRANGE_9 => 24000,
            .RCC_MSIRANGE_10 => 32000,
            .RCC_MSIRANGE_11 => 48000,
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
pub const PLLSAI2QList = enum {
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
pub const PLLSAI2RList = enum {
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
pub const LtdcClockSelectionList = enum {
    RCC_LTDCCLKSOURCE_PLLSAI2_DIV2,
    RCC_LTDCCLKSOURCE_PLLSAI2_DIV4,
    RCC_LTDCCLKSOURCE_PLLSAI2_DIV8,
    RCC_LTDCCLKSOURCE_PLLSAI2_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_LTDCCLKSOURCE_PLLSAI2_DIV2 => 2,
            .RCC_LTDCCLKSOURCE_PLLSAI2_DIV4 => 4,
            .RCC_LTDCCLKSOURCE_PLLSAI2_DIV8 => 8,
            .RCC_LTDCCLKSOURCE_PLLSAI2_DIV16 => 16,
        };
    }
};
pub const PLLDSIIDFList = enum {
    DSI_PLL_IN_DIV1,
    DSI_PLL_IN_DIV2,
    DSI_PLL_IN_DIV3,
    DSI_PLL_IN_DIV4,
    DSI_PLL_IN_DIV5,
    DSI_PLL_IN_DIV6,
    DSI_PLL_IN_DIV7,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .DSI_PLL_IN_DIV1 => 1,
            .DSI_PLL_IN_DIV2 => 2,
            .DSI_PLL_IN_DIV3 => 3,
            .DSI_PLL_IN_DIV4 => 4,
            .DSI_PLL_IN_DIV5 => 5,
            .DSI_PLL_IN_DIV6 => 6,
            .DSI_PLL_IN_DIV7 => 7,
        };
    }
};
pub const PLLDSIODFList = enum {
    DSI_PLL_OUT_DIV1,
    DSI_PLL_OUT_DIV2,
    DSI_PLL_OUT_DIV4,
    DSI_PLL_OUT_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .DSI_PLL_OUT_DIV1 => 1,
            .DSI_PLL_OUT_DIV2 => 2,
            .DSI_PLL_OUT_DIV4 => 4,
            .DSI_PLL_OUT_DIV8 => 8,
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
    FLASH_LATENCY_4,
    FLASH_LATENCY_5,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1_BOOST,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
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
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const EnableHSEDSIList = enum {
    true,
    false,
};
pub const LTDCEnableList = enum {
    true,
    false,
};
pub const LSEStateList = enum {
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
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            SAI2EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            DSIUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            USB_OTG_HSEmbeddedPHYUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
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
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            SWPMI1Used_ForRCC: bool = false,
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
            LSE_VALUE: ?f32 = null,
            MSIClockRange: ?MSIClockRangeList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM1: ?u32 = null,
            PLLM2: ?u32 = null,
            PLLM3: ?u32 = null,
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
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            DFSDMAudioCLockSelection: ?DFSDMAudioCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            DSICLockSelection: ?DSICLockSelectionList = null,
            DSITX_Div: ?u32 = null,
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
            PLLSAI2Q: ?PLLSAI2QList = null,
            PLLSAI2R: ?PLLSAI2RList = null,
            LtdcClockSelection: ?LtdcClockSelectionList = null,
            PLLDSIIDF: ?PLLDSIIDFList = null,
            PLLDSINDIV: ?u32 = null,
            PLLDSIODF: ?PLLDSIODFList = null,
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
            LSEOSC: f32 = 0,
            MSIRC: f32 = 0,
            SAI1_EXT: f32 = 0,
            SAI2_EXT: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM1: f32 = 0,
            PLLM2: f32 = 0,
            PLLM3: f32 = 0,
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
            DSIPHYPrescaler: f32 = 0,
            DSIMult: f32 = 0,
            DSIoutput: f32 = 0,
            DSITXPrescaler: f32 = 0,
            DSITXCLKEsc: f32 = 0,
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
            PLLSAI2Q: f32 = 0,
            PLLSAI2Qoutput: f32 = 0,
            PLLSAI2R: f32 = 0,
            PLLSAI2Routput: f32 = 0,
            PLLSAI2RDIVIDER: f32 = 0,
            LTDCCLK: f32 = 0,
            PLLDSIIDF: f32 = 0,
            PLLDSIMultiplicator: f32 = 0,
            PLLDSINDIV: f32 = 0,
            VCOoutput: f32 = 0,
            PLLDSIDevisor: f32 = 0,
            PLLDSIODF: f32 = 0,
            PLLDSIoutput: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            EXTERNALSAI1_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNALSAI2_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM1: ?f32 = null, //from RCC Clock Config
            PLLM2: ?f32 = null, //from RCC Clock Config
            PLLM3: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from RCC Clock Config
            USART3CLockSelection: ?USART3CLockSelectionList = null, //from RCC Clock Config
            UART4CLockSelection: ?UART4CLockSelectionList = null, //from RCC Clock Config
            UART5CLockSelection: ?UART5CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            CK48CLockSelection: ?CK48CLockSelectionList = null, //from RCC Clock Config
            SDMMCClockSelection: ?SDMMCClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            DFSDMAudioCLockSelection: ?DFSDMAudioCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            DSIPHY_Div: ?f32 = null, //from RCC Clock Config
            DSICLockSelection: ?DSICLockSelectionList = null, //from RCC Clock Config
            DSITX_Div: ?f32 = null, //from RCC Clock Config
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
            PLLSAI2Q: ?PLLSAI2QList = null, //from RCC Clock Config
            PLLSAI2R: ?PLLSAI2RList = null, //from RCC Clock Config
            LtdcClockSelection: ?LtdcClockSelectionList = null, //from RCC Clock Config
            PLLDSIIDF: ?PLLDSIIDFList = null, //from RCC Clock Config
            PLLDSIMult: ?f32 = null, //from RCC Clock Config
            PLLDSINDIV: ?f32 = null, //from RCC Clock Config
            PLLDSIDev: ?f32 = null, //from RCC Clock Config
            PLLDSIODF: ?PLLDSIODFList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
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
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            SAI2Enable: ?SAI2EnableList = null, //from extra RCC references
            I2C4Enable: ?I2C4EnableList = null, //from extra RCC references
            OCTOSPIMEnable: ?OCTOSPIMEnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            EnableHSEDSI: ?EnableHSEDSIList = null, //from extra RCC references
            LTDCEnable: ?LTDCEnableList = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            MSIUsed: ?f32 = null, //from extra RCC references
            LSEState: ?LSEStateList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            PLLSAI1Used: ?f32 = null, //from extra RCC references
            PLLSAI2Used: ?f32 = null, //from extra RCC references
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
            var DFSDMAudioSourceMSI: bool = false;
            var DFSDMAudioSourceHSI: bool = false;
            var DFSDMAudioSourceSAI: bool = false;
            var MCOSourcesys: bool = false;
            var MCOSourceHSI: bool = false;
            var MCOSourceMSI: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourcePLL: bool = false;
            var MCOSourceLSE: bool = false;
            var MCOSourceLSI: bool = false;
            var MCOSourceHSI48: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var DSISourceisPLLSAI2: bool = false;
            var DSISourceisDSIPHY: bool = false;
            var FLASH_LATENCY1: bool = false;
            var FLASH_LATENCY2: bool = false;
            var FLASH_LATENCY3: bool = false;
            var FLASH_LATENCY4: bool = false;
            var FLASH_LATENCY5: bool = false;
            var scale1boost: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
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
            var USBFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var DSIFreq_ValueLimit: Limit = .{};
            var DSITXEscFreq_ValueLimit: Limit = .{};
            var PLLPoutputFreq_ValueLimit: Limit = .{};
            var PLLQoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1PoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1QoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI1RoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI2PoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI2QoutputFreq_ValueLimit: Limit = .{};
            var PLLSAI2RoutputFreq_ValueLimit: Limit = .{};
            var LCDTFTFreq_ValueLimit: Limit = .{};
            var PLLDSIVCOFreq_ValueLimit: Limit = .{};
            var PLLDSIFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 16000000;
            };
            const CRSFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 48000000;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass and (scale2 and SysSourceHSE)) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 0e0) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass & (scale2 & SysSourceHSE)  ",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 2.6e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass & (scale2 & SysSourceHSE)  ",
                                "HSE in bypass Mode",
                                2.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (config.flags.HSEByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 0e0) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    break :blk config_val orelse 8000000;
                } else if (config.flags.HSEOscillator and (scale2 and SysSourceHSE)) {
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
                                "HSEOscillator & (scale2 & SysSourceHSE)  ",
                                "HSE in bypass Mode",
                                4e6,
                                val,
                            });
                        }
                        if (val > 2.6e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEOscillator & (scale2 & SysSourceHSE)  ",
                                "HSE in bypass Mode",
                                2.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
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
                break :blk config_val orelse 8000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 32000;
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
                                try comptime_fail_or_error(error.InvalidConfig,
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
                break :blk 2097000;
            };
            const EXTERNALSAI2_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 2097000;
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

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_MSI;
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">"))) {
                    SYSCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 4000000;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if ((config.flags.USB_OTG_FSUsed_ForRCC and (CK48SourcePLLCLK or CK48SourcePLLSAI1))) {
                    const conf_item = config.PLLSource;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_PLLSOURCE_HSE => {},
                            .RCC_PLLSOURCE_MSI => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_PLLSOURCE_HSE
                                    \\ - RCC_PLLSOURCE_MSI
                                , .{ "PLLSource", "(USB_OTG_FSUsed_ForRCC & (CK48SourcePLLCLK| CK48SourcePLLSAI1)) ", "PLL Mux should have HSE as input", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_PLLSOURCE_MSI;
                }
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
            const PLLM1Value: ?f32 = blk: {
                const config_val = config.PLLM1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM1",
                            "Else",
                            "No Extra Log",
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLM2Value: ?f32 = blk: {
                const config_val = config.PLLM2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM2",
                            "Else",
                            "No Extra Log",
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLLM3Value: ?f32 = blk: {
                const config_val = config.PLLM3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 16) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLM3",
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

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const LCDFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
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

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
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

                break :blk conf_item orelse .RCC_USART3CLKSOURCE_PCLK1;
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_UART4CLKSOURCE_PCLK1;
            };
            const UART4Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
            };
            const UART5Freq_ValueValue: ?f32 = blk: {
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
                        .RCC_LPTIM1CLKSOURCE_PCLK => {},
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const DFSDMCLockSelectionValue: ?DFSDMCLockSelectionList = blk: {
                const conf_item = config.DFSDMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1CLKSOURCE_PCLK => DFSDMSourcePCLK = true,
                        .RCC_DFSDM1CLKSOURCE_SYSCLK => DFSDMSourceSys = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM1CLKSOURCE_PCLK;
            };
            const DFSDMFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_PLLSAI1 => ADCSourcePLLSAI1R = true,
                        .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADCCLKSOURCE_PLLSAI1;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                if (scale2) {
                    ADCFreq_ValueLimit = .{
                        .min = 1.4e6,
                        .max = 2.6e7,
                    };
                    break :blk null;
                }
                ADCFreq_ValueLimit = .{
                    .min = 1.4e6,
                    .max = 1.2e8,
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

                break :blk conf_item orelse .RCC_USBCLKSOURCE_PLLSAI1;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    USBFreq_ValueLimit = .{
                        .min = 4.788e7,
                        .max = 4.812e7,
                    };
                    break :blk null;
                }
                USBFreq_ValueLimit = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };
                break :blk null;
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

                break :blk conf_item orelse .RCC_SDMMC1CLKSOURCE_PLLP;
            };
            const SDMMCFreq_ValueValue: ?f32 = blk: {
                break :blk 16000000;
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
            const I2C2CLockSelectionValue: ?I2C2CLockSelectionList = blk: {
                const conf_item = config.I2C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_PCLK1 => I2C2SourcePCLK1 = true,
                        .RCC_I2C2CLKSOURCE_SYSCLK => I2C2SourceSys = true,
                        .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C2CLKSOURCE_PCLK1;
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
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

                break :blk conf_item orelse .RCC_SAI1CLKSOURCE_PLLSAI1;
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                break :blk 2285714;
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

                break :blk conf_item orelse .RCC_SAI2CLKSOURCE_PLLSAI1;
            };
            const SAI2Freq_ValueValue: ?f32 = blk: {
                break :blk 2285714;
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

                break :blk conf_item orelse .RCC_I2C4CLKSOURCE_PCLK1;
            };
            const I2C4Freq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_OSPICLKSOURCE_SYSCLK;
            };
            const OCTOSPIMFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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

                break :blk conf_item orelse .RCC_DFSDM1AUDIOCLKSOURCE_MSI;
            };
            const DFSDMAudioFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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
                        .RCC_MCO1SOURCE_LSI => MCOSourceLSI = true,
                        .RCC_MCO1SOURCE_HSI48 => MCOSourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
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
                break :blk 4000000;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC and ((config.flags.USE_ADC1 and (!config.flags.ADC1UsedAsynchronousCLK_ForRCC) or config.flags.USE_ADC2 and (!config.flags.ADC2UsedAsynchronousCLK_ForRCC)))) {
                    HCLKFreq_ValueLimit = .{
                        .min = 1.42e7,
                        .max = 1.2e8,
                    };
                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 1.42e7,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.2e8,
                };
                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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
                break :blk 4000000;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
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
                    .max = 1.2e8,
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
                break :blk 4000000;
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
                    .max = 1.2e8,
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
                break :blk 4000000;
            };
            const DSIPHY_DivValue: ?f32 = blk: {
                break :blk 8;
            };
            const DSICLockSelectionValue: ?DSICLockSelectionList = blk: {
                const conf_item = config.DSICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DSICLKSOURCE_PLLSAI2 => DSISourceisPLLSAI2 = true,
                        .RCC_DSICLKSOURCE_DSIPHY => DSISourceisDSIPHY = true,
                    }
                }

                break :blk conf_item orelse .RCC_DSICLKSOURCE_DSIPHY;
            };
            const DSIFreq_ValueValue: ?f32 = blk: {
                if (config.flags.DSIUsed_ForRCC) {
                    DSIFreq_ValueLimit = .{
                        .min = null,
                        .max = 6.25e7,
                    };
                    break :blk null;
                }
                DSIFreq_ValueLimit = .{
                    .min = null,
                    .max = 6.25e7,
                };
                break :blk null;
            };
            const DSITX_DivValue: ?f32 = blk: {
                const config_val = config.DSITX_Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DSITX_Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 32) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DSITX_Div",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
            };
            const DSITXEscFreq_ValueValue: ?f32 = blk: {
                DSITXEscFreq_ValueLimit = .{
                    .min = null,
                    .max = 2e7,
                };
                break :blk null;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 8) {
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
                            8,
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
            const PLLPoutputFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLP and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLP and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SDMMC1SourceIsPllP and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)))) {
                    PLLPoutputFreq_ValueLimit = .{
                        .min = 2.064e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 4571429;
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
                if (((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC) and CK48SourcePLLCLK) or ((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) and OCTOSPIMSourcePLL) or (CK48SourcePLLCLK and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 16000000;
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 127) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI1N",
                            "Else",
                            "No Extra Log",
                            127,
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
            const PLLSAI1PoutputFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI1P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLSAI1P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    PLLSAI1PoutputFreq_ValueLimit = .{
                        .min = 2.064e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 4571429;
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
                if (((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC) and CK48SourcePLLSAI1) or (CK48SourcePLLSAI1 and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    PLLSAI1QoutputFreq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 16000000;
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
                if ((ADCSourcePLLSAI1R and (config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC or config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) {
                    PLLSAI1RoutputFreq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 16000000;
            };
            const PLLSAI2NValue: ?f32 = blk: {
                const config_val = config.PLLSAI2N;
                if (config_val) |val| {
                    if (val < 8) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 127) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAI2N",
                            "Else",
                            "No Extra Log",
                            127,
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
            const PLLSAI2PoutputFreq_ValueValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI2P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLSAI2P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    PLLSAI2PoutputFreq_ValueLimit = .{
                        .min = 2.064e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 4571429;
            };
            const PLLSAI2QValue: ?PLLSAI2QList = blk: {
                const conf_item = config.PLLSAI2Q;
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
            const PLLSAI2QoutputFreq_ValueValue: ?f32 = blk: {
                if (DSISourceisPLLSAI2 and config.flags.DSIUsed_ForRCC) {
                    PLLSAI2QoutputFreq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.2e8,
                    };
                    break :blk null;
                }
                break :blk 16000000;
            };
            const PLLSAI2RValue: ?PLLSAI2RList = blk: {
                const conf_item = config.PLLSAI2R;
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
            const PLLSAI2RoutputFreq_ValueValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    PLLSAI2RoutputFreq_ValueLimit = .{
                        .min = 8e6,
                        .max = 8e7,
                    };
                    break :blk null;
                }
                break :blk 16000000;
            };
            const LtdcClockSelectionValue: ?LtdcClockSelectionList = blk: {
                const conf_item = config.LtdcClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LTDCCLKSOURCE_PLLSAI2_DIV2 => {},
                        .RCC_LTDCCLKSOURCE_PLLSAI2_DIV4 => {},
                        .RCC_LTDCCLKSOURCE_PLLSAI2_DIV8 => {},
                        .RCC_LTDCCLKSOURCE_PLLSAI2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_LTDCCLKSOURCE_PLLSAI2_DIV2;
            };
            const LCDTFTFreq_ValueValue: ?f32 = blk: {
                LCDTFTFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.2e8,
                };
                break :blk null;
            };
            const PLLDSIIDFValue: ?PLLDSIIDFList = blk: {
                const conf_item = config.PLLDSIIDF;
                if (conf_item) |item| {
                    switch (item) {
                        .DSI_PLL_IN_DIV1 => {},
                        .DSI_PLL_IN_DIV2 => {},
                        .DSI_PLL_IN_DIV3 => {},
                        .DSI_PLL_IN_DIV4 => {},
                        .DSI_PLL_IN_DIV5 => {},
                        .DSI_PLL_IN_DIV6 => {},
                        .DSI_PLL_IN_DIV7 => {},
                    }
                }

                break :blk conf_item orelse .DSI_PLL_IN_DIV1;
            };
            const PLLDSIMultValue: ?f32 = blk: {
                break :blk 2;
            };
            const PLLDSINDIVValue: ?f32 = blk: {
                const config_val = config.PLLDSINDIV;
                if (config_val) |val| {
                    if (val < 10) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLDSINDIV",
                            "Else",
                            "No Extra Log",
                            10,
                            val,
                        });
                    }
                    if (val > 125) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLDSINDIV",
                            "Else",
                            "No Extra Log",
                            125,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 20;
            };
            const PLLDSIVCOFreq_ValueValue: ?f32 = blk: {
                PLLDSIVCOFreq_ValueLimit = .{
                    .min = 5e8,
                    .max = 1e9,
                };
                break :blk null;
            };
            const PLLDSIDevValue: ?f32 = blk: {
                break :blk 2;
            };
            const PLLDSIODFValue: ?PLLDSIODFList = blk: {
                const conf_item = config.PLLDSIODF;
                if (conf_item) |item| {
                    switch (item) {
                        .DSI_PLL_OUT_DIV1 => {},
                        .DSI_PLL_OUT_DIV2 => {},
                        .DSI_PLL_OUT_DIV4 => {},
                        .DSI_PLL_OUT_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .DSI_PLL_OUT_DIV1;
            };
            const PLLDSIFreq_ValueValue: ?f32 = blk: {
                PLLDSIFreq_ValueLimit = .{
                    .min = 8e7,
                    .max = 5e8,
                };
                break :blk null;
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
                if (((scale1 or scale1boost) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"=")))) or (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"="))))) {
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
                            , .{ "FLatency", "((scale1 | scale1boost) & ((HCLKFreq_Value < 20000000)|(HCLKFreq_Value= 20000000 )))|(scale2 & ((HCLKFreq_Value < 8000000)|(HCLKFreq_Value= 8000000 )))", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (((scale1 or scale1boost) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"=")))) or (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"="))))) {
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
                            , .{ "FLatency", "((scale1 | scale1boost) & ((HCLKFreq_Value < 40000000)|(HCLKFreq_Value= 40000000 )))|(scale2 & ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value= 16000000 )))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if (((scale1 or scale1boost) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"=")))) or (scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"="))))) {
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
                            , .{ "FLatency", "((scale1 | scale1boost) & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 )))|(scale2 & ((HCLKFreq_Value < 26000000)|(HCLKFreq_Value= 26000000 )))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if (((scale1 or scale1boost) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
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
                            , .{ "FLatency", "((scale1 | scale1boost) & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value= 80000000 )))", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1boost and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
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
                            , .{ "FLatency", "(scale1boost & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value= 100000000 )))", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1boost and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_5;
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
                            , .{ "FLatency", "(scale1boost & ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value= 120000000 )))", "No Extra Log", "FLASH_LATENCY_5", i });
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
                        .FLASH_LATENCY_3 => FLASH_LATENCY3 = true,
                        .FLASH_LATENCY_4 => FLASH_LATENCY4 = true,
                        .FLASH_LATENCY_5 => FLASH_LATENCY5 = true,
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (((CK48SourcePLLCLK and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (SDMMC1SourceIsPllP and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (SAI1SourcePLLP and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourcePLLP and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SysSourcePLL) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or (CK48SourcePLLCLK and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC) or OCTOSPIMSourcePLL and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLSAI1UsedValue: ?f32 = blk: {
                if (((SAI1SourcePLLSAI1P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (DFSDMAudioSourceSAI and config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and SAI1SourcePLLSAI1P) or (SAI2SourcePLLSAI1P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC))) or (ADCSourcePLLSAI1R and (config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC or config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or (CK48SourcePLLSAI1 and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC)) or (CK48SourcePLLSAI1 and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLSAI2UsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or (DSISourceisPLLSAI2 and config.flags.DSIUsed_ForRCC) or ((SAI1SourcePLLSAI2P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (DFSDMAudioSourceSAI and config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and SAI1SourcePLLSAI2P) or (SAI2SourcePLLSAI2P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((DFSDMAudioSourceSAI and SAI1SourceHSI and (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (DFSDMAudioSourceHSI and (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (SAI2SourceHSI and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SAI1SourceHSI and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (USART1SourceHSI and config.flags.USART1Used_ForRCC) or (USART2SourceHSI and config.flags.USART2Used_ForRCC) or (USART3SourceHSI and config.flags.USART3Used_ForRCC) or (UART4SourceHSI and config.flags.UART4Used_ForRCC) or (UART5SourceHSI and config.flags.UART5Used_ForRCC) or (LPUART1SourceHSI and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCEHSI and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCEHSI and config.flags.LPTIM2Used_ForRCC) or (I2C1SourceHSI and config.flags.I2C1Used_ForRCC) or (I2C2SourceHSI and config.flags.I2C2Used_ForRCC) or (I2C3SourceHSI and config.flags.I2C3Used_ForRCC) or (I2C4SourceHSI and config.flags.I2C4Used_ForRCC) or (check_MCU("SWPMISourceHSI") and config.flags.SWPMI1Used_ForRCC) or ((check_MCU("PLLSourceHSI")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAI1UsedValue), PLLSAI1UsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAI2UsedValue), PLLSAI2UsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and ((((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig))))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(HSIUsedValue), HSIUsedValue, 1, .@"=")) {
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
                                "HSIUsed=1",
                                "HSI used",
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
                                "HSIUsed=1",
                                "HSI used",
                                127,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 64;
                }
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
            const MSIUsedValue: ?f32 = blk: {
                if ((CK48SourceMSI and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (OCTOSPIMSourceMSI and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (DFSDMAudioSourceMSI and (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (check_MCU("SEM2RCC_MSI_REQUIRED_TIM17") and check_MCU("TIM17") and check_MCU("Semaphore_input_Channel1TIM17")) or (CK48SourceMSI and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC)) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or (check_MCU("PLLSourceMSI") and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAI1UsedValue), PLLSAI1UsedValue, 1, .@"=") or check_ref(@TypeOf(PLLSAI2UsedValue), PLLSAI2UsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSICalibrationValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=")) {
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
                                "MSIUsed=1",
                                "HSI used",
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
                                "MSIUsed=1",
                                "HSI used",
                                255,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
                }
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"<")) or check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE1_BOOST => scale1boost = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 26000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE1_BOOST => scale1boost = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1_BOOST
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value > 26000000) & ((HCLKFreq_Value < 80000000)|HCLKFreq_Value = 80000000)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                }
                scale1boost = true;
                const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE1_BOOST;
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
                        , .{ "PWR_Regulator_Voltage_Scale", "Else", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1_BOOST", i });
                    }
                }
                break :blk item;
            };
            const LSEStateValue: ?LSEStateList = blk: {
                if (config.flags.LSEByPass) {
                    const item: LSEStateList = .RCC_LSE_BYPASS;
                    const conf_item = config.LSEState;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    }
                }

                break :blk conf_item orelse .RCC_LSE_OFF;
            };
            const MSIAutoCalibrationValue: ?MSIAutoCalibrationList = blk: {
                if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and (CK48SourceMSI or (config.flags.USB_OTG_FSUsed_ForRCC and CK48SourcePLLCLK and check_MCU("PLLSourceMSI")) or (config.flags.USB_OTG_FSUsed_ForRCC and CK48SourcePLLSAI1 and check_MCU("PLLSourceMSI")))) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .ENABLED;
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & (CK48SourceMSI|(USB_OTG_FSUsed_ForRCC&CK48SourcePLLCLK&PLLSourceMSI)|(USB_OTG_FSUsed_ForRCC&CK48SourcePLLSAI1&PLLSourceMSI))", "No Extra Log", "ENABLED", i });
                        }
                    }
                    break :blk item;
                } else if (CK48SourceMSI or (config.flags.USB_OTG_FSUsed_ForRCC and CK48SourcePLLCLK and check_MCU("PLLSourceMSI")) or (config.flags.USB_OTG_FSUsed_ForRCC and CK48SourcePLLSAI1 and check_MCU("PLLSourceMSI"))) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .ENABLED;
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
                            , .{ "MSIAutoCalibration", "CK48SourceMSI|(USB_OTG_FSUsed_ForRCC&CK48SourcePLLCLK&PLLSourceMSI)|(USB_OTG_FSUsed_ForRCC&CK48SourcePLLSAI1&PLLSourceMSI)", "No Extra Log", "ENABLED", i });
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
                        try comptime_fail_or_error(error.InvalidConfig,
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

                break :blk conf_item orelse .RCC_CRS_SYNC_DIV1;
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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

                break :blk conf_item orelse .automatic;
            };
            const ReloadValueValue: ?f32 = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.ReloadValue) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i));
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                if ((MSIAutoCalibrationON and check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=") and (config.flags.LSEByPass or config.flags.LSEOscillator)) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (USART2SourceLSE and config.flags.USART2Used_ForRCC) or (USART3SourceLSE and config.flags.USART3Used_ForRCC) or (UART4SourceLSE and config.flags.UART4Used_ForRCC) or (UART5SourceLSE and config.flags.UART5Used_ForRCC) or (LPUART1SourceLSE and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCELSE and config.flags.LPTIM2Used_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
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
            const EnableCRSValue: ?EnableCRSList = blk: {
                if (config.flags.CRSActivatedSourceGPIO or config.flags.CRSActivatedSourceLSE or config.flags.CRSActivatedSourceUSB) {
                    const item: EnableCRSList = .true;
                    break :blk item;
                }
                const item: EnableCRSList = .false;
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
                if ((config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) {
                    const item: SDMMCEnableList = .true;
                    break :blk item;
                }
                const item: SDMMCEnableList = .false;
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
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC or config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
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
            const LSCOEnableValue: ?LSCOEnableList = blk: {
                if (config.flags.LSCOConfig) {
                    const item: LSCOEnableList = .true;
                    break :blk item;
                }
                const item: LSCOEnableList = .false;
                break :blk item;
            };
            const EnableHSEDSIValue: ?EnableHSEDSIList = blk: {
                if ((config.flags.DSIUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass) or ((config.flags.HSEOscillator or config.flags.HSEByPass) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11")))) {
                    const item: EnableHSEDSIList = .true;
                    break :blk item;
                }
                const item: EnableHSEDSIList = .false;
                break :blk item;
            };
            const LTDCEnableValue: ?LTDCEnableList = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    const item: LTDCEnableList = .true;
                    break :blk item;
                }
                const item: LTDCEnableList = .false;
                break :blk item;
            };
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
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

            var PLLM1 = ClockNode{
                .name = "PLLM1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM2 = ClockNode{
                .name = "PLLM2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM3 = ClockNode{
                .name = "PLLM3",
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

            var DSIPHYPrescaler = ClockNode{
                .name = "DSIPHYPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var DSIMult = ClockNode{
                .name = "DSIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DSIoutput = ClockNode{
                .name = "DSIoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DSITXPrescaler = ClockNode{
                .name = "DSITXPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var DSITXCLKEsc = ClockNode{
                .name = "DSITXCLKEsc",
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

            var PLLSAI2Q = ClockNode{
                .name = "PLLSAI2Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2Qoutput = ClockNode{
                .name = "PLLSAI2Qoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2R = ClockNode{
                .name = "PLLSAI2R",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2Routput = ClockNode{
                .name = "PLLSAI2Routput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAI2RDIVIDER = ClockNode{
                .name = "PLLSAI2RDIVIDER",
                .nodetype = .off,
                .parents = &.{},
            };

            var LTDCCLK = ClockNode{
                .name = "LTDCCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSIIDF = ClockNode{
                .name = "PLLDSIIDF",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSIMultiplicator = ClockNode{
                .name = "PLLDSIMultiplicator",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSINDIV = ClockNode{
                .name = "PLLDSINDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOoutput = ClockNode{
                .name = "VCOoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSIDevisor = ClockNode{
                .name = "PLLDSIDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSIODF = ClockNode{
                .name = "PLLDSIODF",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDSIoutput = ClockNode{
                .name = "PLLDSIoutput",
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
            }

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

            const MSIRC_clk_value = MSIClockRangeValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const SAI1_EXT_clk_value = EXTERNALSAI1_CLOCK_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const SAI2_EXT_clk_value = EXTERNALSAI2_CLOCK_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &MSIRC,
                &HSIRC,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            const PLLM1_clk_value = PLLM1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLM1",
                "Else",
                "No Extra Log",
                "PLLM1",
            });
            PLLM1.nodetype = .div;
            PLLM1.value = PLLM1_clk_value;
            PLLM1.parents = &.{&PLLSource};

            const PLLM2_clk_value = PLLM2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLM2",
                "Else",
                "No Extra Log",
                "PLLM2",
            });
            PLLM2.nodetype = .div;
            PLLM2.value = PLLM2_clk_value;
            PLLM2.parents = &.{&PLLSource};

            const PLLM3_clk_value = PLLM3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLM3",
                "Else",
                "No Extra Log",
                "PLLM3",
            });
            PLLM3.nodetype = .div;
            PLLM3.value = PLLM3_clk_value;
            PLLM3.parents = &.{&PLLSource};
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
                const USART3Mult_clk_value = USART3CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const UART4Mult_clk_value = UART4CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const UART5Mult_clk_value = UART5CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Prescaler,
                    &LSIRC,
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
                const DFSDMMult_clk_value = DFSDMCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Prescaler,
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
                const CK48Mult_clk_value = CK48CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                CK48output.limit = USBFreq_ValueLimit;
                CK48output.nodetype = .output;
                CK48output.parents = &.{&CK48Mult};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&CK48Mult};
            }
            if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                const SDMMC1Mult_clk_value = SDMMCClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC1Mult",
                    "Else",
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
            if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMCFreq_ValueValue);
                SDMMCC1Output.nodetype = .output;
                SDMMCC1Output.parents = &.{&SDMMC1Mult};
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
                const I2C2Mult_clk_value = I2C2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const SAI1Mult_clk_value = SAI1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const SAI2Mult_clk_value = SAI2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const I2C4Mult_clk_value = I2C4CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const OCTOSPIMMult_clk_value = OCTOSPIMCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(DFSDMAudioEnableValue), DFSDMAudioEnableValue, .true, .@"=")) {
                const DFSDMAudioMult_clk_value = DFSDMAudioCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
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
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
            FCLKCortexOutput.nodetype = .output;
            FCLKCortexOutput.parents = &.{&AHBOutput};

            const APB1Prescaler_clk_value = APB1CLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const TimPrescalerAPB1_clk_value = APB1TimCLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const APB2Prescaler_clk_value = APB2CLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const TimPrescalerAPB2_clk_value = APB2TimCLKDividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const DSIPHYPrescaler_clk_value = DSIPHY_DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "DSIPHYPrescaler",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "DSIPHY_Div",
                    });
                    DSIPHYPrescaler.nodetype = .div;
                    DSIPHYPrescaler.value = DSIPHYPrescaler_clk_value;
                    DSIPHYPrescaler.parents = &.{&PLLDSIODF};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const DSIMult_clk_value = DSICLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "DSIMult",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "DSICLockSelection",
                    });
                    const DSIMultparents = [_]*const ClockNode{
                        &PLLSAI2Q,
                        &DSIPHYPrescaler,
                    };
                    DSIMult.nodetype = .multi;
                    DSIMult.parents = &.{DSIMultparents[DSIMult_clk_value.get()]};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(DSIFreq_ValueValue);
                    DSIoutput.limit = DSIFreq_ValueLimit;
                    DSIoutput.nodetype = .output;
                    DSIoutput.parents = &.{&DSIMult};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const DSITXPrescaler_clk_value = DSITX_DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "DSITXPrescaler",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "DSITX_Div",
                    });
                    DSITXPrescaler.nodetype = .div;
                    DSITXPrescaler.value = DSITXPrescaler_clk_value;
                    DSITXPrescaler.parents = &.{&DSIMult};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(DSITXEscFreq_ValueValue);
                    DSITXCLKEsc.limit = DSITXEscFreq_ValueLimit;
                    DSITXCLKEsc.nodetype = .output;
                    DSITXCLKEsc.parents = &.{&DSITXPrescaler};
                }
            }

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
            PLLN.parents = &.{&PLLM1};
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
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
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                const PLLSAI1N_clk_value = PLLSAI1NValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                PLLSAI1N.parents = &.{&PLLM2};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAI1P_clk_value = PLLSAI1PValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
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
                const PLLSAI1Q_clk_value = PLLSAI1QValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                const PLLSAI1R_clk_value = PLLSAI1RValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAI2N_clk_value = PLLSAI2NValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                PLLSAI2N.parents = &.{&PLLM3};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                const PLLSAI2P_clk_value = PLLSAI2PValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLSAI2Q_clk_value = PLLSAI2QValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI2Q",
                    "Else",
                    "No Extra Log",
                    "PLLSAI2Q",
                });
                PLLSAI2Q.nodetype = .div;
                PLLSAI2Q.value = PLLSAI2Q_clk_value.get();
                PLLSAI2Q.parents = &.{&PLLSAI2N};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PLLSAI2QoutputFreq_ValueValue);
                PLLSAI2Qoutput.limit = PLLSAI2QoutputFreq_ValueLimit;
                PLLSAI2Qoutput.nodetype = .output;
                PLLSAI2Qoutput.parents = &.{&PLLSAI2Q};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                const PLLSAI2R_clk_value = PLLSAI2RValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI2R",
                    "Else",
                    "No Extra Log",
                    "PLLSAI2R",
                });
                PLLSAI2R.nodetype = .div;
                PLLSAI2R.value = PLLSAI2R_clk_value.get();
                PLLSAI2R.parents = &.{&PLLSAI2N};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PLLSAI2RoutputFreq_ValueValue);
                PLLSAI2Routput.limit = PLLSAI2RoutputFreq_ValueLimit;
                PLLSAI2Routput.nodetype = .output;
                PLLSAI2Routput.parents = &.{&PLLSAI2R};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                const PLLSAI2RDIVIDER_clk_value = LtdcClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAI2RDIVIDER",
                    "Else",
                    "No Extra Log",
                    "LtdcClockSelection",
                });
                PLLSAI2RDIVIDER.nodetype = .div;
                PLLSAI2RDIVIDER.value = PLLSAI2RDIVIDER_clk_value.get();
                PLLSAI2RDIVIDER.parents = &.{&PLLSAI2R};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LCDTFTFreq_ValueValue);
                LTDCCLK.limit = LCDTFTFreq_ValueLimit;
                LTDCCLK.nodetype = .output;
                LTDCCLK.parents = &.{&PLLSAI2RDIVIDER};
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const PLLDSIIDF_clk_value = PLLDSIIDFValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLDSIIDF",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "PLLDSIIDF",
                    });
                    PLLDSIIDF.nodetype = .div;
                    PLLDSIIDF.value = PLLDSIIDF_clk_value.get();
                    PLLDSIIDF.parents = &.{&HSEOSC};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const PLLDSIMultiplicator_clk_value = PLLDSIMultValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLDSIMultiplicator",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "PLLDSIMult",
                    });
                    PLLDSIMultiplicator.nodetype = .mul;
                    PLLDSIMultiplicator.value = PLLDSIMultiplicator_clk_value;
                    PLLDSIMultiplicator.parents = &.{&PLLDSIIDF};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const PLLDSINDIV_clk_value = PLLDSINDIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLDSINDIV",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "PLLDSINDIV",
                    });
                    PLLDSINDIV.nodetype = .mul;
                    PLLDSINDIV.value = PLLDSINDIV_clk_value;
                    PLLDSINDIV.parents = &.{&PLLDSIMultiplicator};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(PLLDSIVCOFreq_ValueValue);
                    VCOoutput.limit = PLLDSIVCOFreq_ValueLimit;
                    VCOoutput.nodetype = .output;
                    VCOoutput.parents = &.{&PLLDSINDIV};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const PLLDSIDevisor_clk_value = PLLDSIDevValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLDSIDevisor",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "PLLDSIDev",
                    });
                    PLLDSIDevisor.nodetype = .div;
                    PLLDSIDevisor.value = PLLDSIDevisor_clk_value;
                    PLLDSIDevisor.parents = &.{&VCOoutput};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    const PLLDSIODF_clk_value = PLLDSIODFValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLDSIODF",
                        "(DSIHOST_Exist)",
                        "No Extra Log",
                        "PLLDSIODF",
                    });
                    PLLDSIODF.nodetype = .div;
                    PLLDSIODF.value = PLLDSIODF_clk_value.get();
                    PLLDSIODF.parents = &.{&PLLDSIDevisor};
                }
            }
            if ((check_MCU("DSIHOST_Exist"))) {
                if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(PLLDSIFreq_ValueValue);
                    PLLDSIoutput.limit = PLLDSIFreq_ValueLimit;
                    PLLDSIoutput.nodetype = .output;
                    PLLDSIoutput.parents = &.{&PLLDSIODF};
                }
            }

            out.HSIRC = try HSIRC.get_output();
            out.CRSCLKoutput = try CRSCLKoutput.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.SAI1_EXT = try SAI1_EXT.get_output();
            out.SAI2_EXT = try SAI2_EXT.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.PLLM1 = try PLLM1.get_output();
            out.PLLM2 = try PLLM2.get_output();
            out.PLLM3 = try PLLM3.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.LCDOutput = try LCDOutput.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART2output = try USART2output.get_output();
            out.USART3Mult = try USART3Mult.get_output();
            out.USART3output = try USART3output.get_output();
            out.UART4Mult = try UART4Mult.get_output();
            out.UART4output = try UART4output.get_output();
            out.UART5Mult = try UART5Mult.get_output();
            out.UART5output = try UART5output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.DFSDMMult = try DFSDMMult.get_output();
            out.DFSDMoutput = try DFSDMoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.CK48Mult = try CK48Mult.get_output();
            out.CK48output = try CK48output.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.SDMMC1Mult = try SDMMC1Mult.get_output();
            out.SDMMCC1Output = try SDMMCC1Output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.I2C2output = try I2C2output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.OCTOSPIMMult = try OCTOSPIMMult.get_output();
            out.OCTOSPIMoutput = try OCTOSPIMoutput.get_output();
            out.DFSDMAudioMult = try DFSDMAudioMult.get_output();
            out.DFSDMAudiooutput = try DFSDMAudiooutput.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.DSIPHYPrescaler = try DSIPHYPrescaler.get_output();
            out.DSIMult = try DSIMult.get_output();
            out.DSIoutput = try DSIoutput.get_output();
            out.DSITXPrescaler = try DSITXPrescaler.get_output();
            out.DSITXCLKEsc = try DSITXCLKEsc.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLLR = try PLLR.get_output();
            out.PLLSAI1N = try PLLSAI1N.get_output();
            out.PLLSAI1P = try PLLSAI1P.get_output();
            out.PLLSAI1Poutput = try PLLSAI1Poutput.get_output();
            out.PLLSAI1Q = try PLLSAI1Q.get_output();
            out.PLLSAI1Qoutput = try PLLSAI1Qoutput.get_output();
            out.PLLSAI1R = try PLLSAI1R.get_output();
            out.PLLSAI1Routput = try PLLSAI1Routput.get_output();
            out.PLLSAI2N = try PLLSAI2N.get_output();
            out.PLLSAI2P = try PLLSAI2P.get_output();
            out.PLLSAI2Poutput = try PLLSAI2Poutput.get_output();
            out.PLLSAI2Q = try PLLSAI2Q.get_output();
            out.PLLSAI2Qoutput = try PLLSAI2Qoutput.get_output();
            out.PLLSAI2R = try PLLSAI2R.get_output();
            out.PLLSAI2Routput = try PLLSAI2Routput.get_output();
            out.PLLSAI2RDIVIDER = try PLLSAI2RDIVIDER.get_output();
            out.LTDCCLK = try LTDCCLK.get_output();
            out.PLLDSIIDF = try PLLDSIIDF.get_output();
            out.PLLDSIMultiplicator = try PLLDSIMultiplicator.get_output();
            out.PLLDSINDIV = try PLLDSINDIV.get_output();
            out.VCOoutput = try VCOoutput.get_output();
            out.PLLDSIDevisor = try PLLDSIDevisor.get_output();
            out.PLLDSIODF = try PLLDSIODF.get_output();
            out.PLLDSIoutput = try PLLDSIoutput.get_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.EXTERNALSAI1_CLOCK_VALUE = EXTERNALSAI1_CLOCK_VALUEValue;
            ref_out.EXTERNALSAI2_CLOCK_VALUE = EXTERNALSAI2_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM1 = PLLM1Value;
            ref_out.PLLM2 = PLLM2Value;
            ref_out.PLLM3 = PLLM3Value;
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
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
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
            ref_out.DSIPHY_Div = DSIPHY_DivValue;
            ref_out.DSICLockSelection = DSICLockSelectionValue;
            ref_out.DSITX_Div = DSITX_DivValue;
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
            ref_out.PLLSAI2Q = PLLSAI2QValue;
            ref_out.PLLSAI2R = PLLSAI2RValue;
            ref_out.LtdcClockSelection = LtdcClockSelectionValue;
            ref_out.PLLDSIIDF = PLLDSIIDFValue;
            ref_out.PLLDSIMult = PLLDSIMultValue;
            ref_out.PLLDSINDIV = PLLDSINDIVValue;
            ref_out.PLLDSIDev = PLLDSIDevValue;
            ref_out.PLLDSIODF = PLLDSIODFValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
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
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.SAI2Enable = SAI2EnableValue;
            ref_out.I2C4Enable = I2C4EnableValue;
            ref_out.OCTOSPIMEnable = OCTOSPIMEnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.EnableHSEDSI = EnableHSEDSIValue;
            ref_out.LTDCEnable = LTDCEnableValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.MSIUsed = MSIUsedValue;
            ref_out.LSEState = LSEStateValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.PLLSAI1Used = PLLSAI1UsedValue;
            ref_out.PLLSAI2Used = PLLSAI2UsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
