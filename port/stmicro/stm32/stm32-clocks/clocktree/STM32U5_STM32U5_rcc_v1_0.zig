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

pub const SAESSourceList = enum {
    RCC_SAESCLKSOURCE_SHSI,
    RCC_SAESCLKSOURCE_SHSI_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAESCLKSOURCE_SHSI => 0,
            .RCC_SAESCLKSOURCE_SHSI_DIV2 => 1,
        };
    }
};
pub const RCC_Stop_WakeUpClockList = enum {
    RCC_STOP_WAKEUPCLOCK_MSI,
    RCC_STOP_WAKEUPCLOCK_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_STOP_WAKEUPCLOCK_MSI => 0,
            .RCC_STOP_WAKEUPCLOCK_HSI => 1,
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
pub const PLL2SourceList = enum {
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
pub const PLL3SourceList = enum {
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
    RCC_LPUART1CLKSOURCE_PCLK3,
    RCC_LPUART1CLKSOURCE_SYSCLK,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_LSE,
    RCC_LPUART1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK3 => 0,
            .RCC_LPUART1CLKSOURCE_SYSCLK => 1,
            .RCC_LPUART1CLKSOURCE_HSI => 2,
            .RCC_LPUART1CLKSOURCE_LSE => 3,
            .RCC_LPUART1CLKSOURCE_MSIK => 4,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_MSIK,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_MSIK => 0,
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
pub const DACCLockSelectionList = enum {
    RCC_DAC1CLKSOURCE_LSE,
    RCC_DAC1CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DAC1CLKSOURCE_LSE => 0,
            .RCC_DAC1CLKSOURCE_LSI => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCDACCLKSOURCE_HCLK,
    RCC_ADCDACCLKSOURCE_SYSCLK,
    RCC_ADCDACCLKSOURCE_PLL2,
    RCC_ADCDACCLKSOURCE_HSE,
    RCC_ADCDACCLKSOURCE_HSI,
    RCC_ADCDACCLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCDACCLKSOURCE_HCLK => 0,
            .RCC_ADCDACCLKSOURCE_SYSCLK => 1,
            .RCC_ADCDACCLKSOURCE_PLL2 => 2,
            .RCC_ADCDACCLKSOURCE_HSE => 3,
            .RCC_ADCDACCLKSOURCE_HSI => 4,
            .RCC_ADCDACCLKSOURCE_MSIK => 5,
        };
    }
};
pub const CK48CLockSelectionList = enum {
    RCC_CLK48CLKSOURCE_PLL2,
    RCC_CLK48CLKSOURCE_PLL1,
    RCC_CLK48CLKSOURCE_MSIK,
    RCC_CLK48CLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLK48CLKSOURCE_PLL2 => 0,
            .RCC_CLK48CLKSOURCE_PLL1 => 1,
            .RCC_CLK48CLKSOURCE_MSIK => 2,
            .RCC_CLK48CLKSOURCE_HSI48 => 3,
        };
    }
};
pub const SDMMCClockSelectionList = enum {
    RCC_SDMMCCLKSOURCE_PLL1,
    RCC_SDMMCCLKSOURCE_CLK48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMCCLKSOURCE_PLL1 => 0,
            .RCC_SDMMCCLKSOURCE_CLK48 => 1,
        };
    }
};
pub const FDCANClockSelectionList = enum {
    RCC_FDCAN1CLKSOURCE_PLL1,
    RCC_FDCAN1CLKSOURCE_PLL2,
    RCC_FDCAN1CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCAN1CLKSOURCE_PLL1 => 0,
            .RCC_FDCAN1CLKSOURCE_PLL2 => 1,
            .RCC_FDCAN1CLKSOURCE_HSE => 2,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_SYSCLK,
    RCC_I2C1CLKSOURCE_HSI,
    RCC_I2C1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_SYSCLK => 1,
            .RCC_I2C1CLKSOURCE_HSI => 2,
            .RCC_I2C1CLKSOURCE_MSIK => 3,
        };
    }
};
pub const I2C2CLockSelectionList = enum {
    RCC_I2C2CLKSOURCE_PCLK1,
    RCC_I2C2CLKSOURCE_SYSCLK,
    RCC_I2C2CLKSOURCE_HSI,
    RCC_I2C2CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_PCLK1 => 0,
            .RCC_I2C2CLKSOURCE_SYSCLK => 1,
            .RCC_I2C2CLKSOURCE_HSI => 2,
            .RCC_I2C2CLKSOURCE_MSIK => 3,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK3,
    RCC_I2C3CLKSOURCE_SYSCLK,
    RCC_I2C3CLKSOURCE_HSI,
    RCC_I2C3CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK3 => 0,
            .RCC_I2C3CLKSOURCE_SYSCLK => 1,
            .RCC_I2C3CLKSOURCE_HSI => 2,
            .RCC_I2C3CLKSOURCE_MSIK => 3,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL2,
    RCC_SAI1CLKSOURCE_PLL3,
    RCC_SAI1CLKSOURCE_PLL1,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL2 => 0,
            .RCC_SAI1CLKSOURCE_PLL3 => 1,
            .RCC_SAI1CLKSOURCE_PLL1 => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_HSI => 4,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLL2,
    RCC_SAI2CLKSOURCE_PLL3,
    RCC_SAI2CLKSOURCE_PLL1,
    RCC_SAI2CLKSOURCE_PIN,
    RCC_SAI2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLL2 => 0,
            .RCC_SAI2CLKSOURCE_PLL3 => 1,
            .RCC_SAI2CLKSOURCE_PLL1 => 2,
            .RCC_SAI2CLKSOURCE_PIN => 3,
            .RCC_SAI2CLKSOURCE_HSI => 4,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_PCLK1,
    RCC_I2C4CLKSOURCE_SYSCLK,
    RCC_I2C4CLKSOURCE_HSI,
    RCC_I2C4CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_PCLK1 => 0,
            .RCC_I2C4CLKSOURCE_SYSCLK => 1,
            .RCC_I2C4CLKSOURCE_HSI => 2,
            .RCC_I2C4CLKSOURCE_MSIK => 3,
        };
    }
};
pub const MdfClockSelectionList = enum {
    RCC_MDF1CLKSOURCE_HCLK,
    RCC_MDF1CLKSOURCE_PLL1,
    RCC_MDF1CLKSOURCE_PLL3,
    RCC_MDF1CLKSOURCE_PIN,
    RCC_MDF1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MDF1CLKSOURCE_HCLK => 0,
            .RCC_MDF1CLKSOURCE_PLL1 => 1,
            .RCC_MDF1CLKSOURCE_PLL3 => 2,
            .RCC_MDF1CLKSOURCE_PIN => 3,
            .RCC_MDF1CLKSOURCE_MSIK => 4,
        };
    }
};
pub const AdfClockSelectionList = enum {
    RCC_ADF1CLKSOURCE_HCLK,
    RCC_ADF1CLKSOURCE_PLL1,
    RCC_ADF1CLKSOURCE_PLL3,
    RCC_ADF1CLKSOURCE_PIN,
    RCC_ADF1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADF1CLKSOURCE_HCLK => 0,
            .RCC_ADF1CLKSOURCE_PLL1 => 1,
            .RCC_ADF1CLKSOURCE_PLL3 => 2,
            .RCC_ADF1CLKSOURCE_PIN => 3,
            .RCC_ADF1CLKSOURCE_MSIK => 4,
        };
    }
};
pub const OCTOSPIMCLockSelectionList = enum {
    RCC_OSPICLKSOURCE_MSIK,
    RCC_OSPICLKSOURCE_SYSCLK,
    RCC_OSPICLKSOURCE_PLL1,
    RCC_OSPICLKSOURCE_PLL2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_OSPICLKSOURCE_MSIK => 0,
            .RCC_OSPICLKSOURCE_SYSCLK => 1,
            .RCC_OSPICLKSOURCE_PLL1 => 2,
            .RCC_OSPICLKSOURCE_PLL2 => 3,
        };
    }
};
pub const LPTIM3CLockSelectionList = enum {
    RCC_LPTIM34CLKSOURCE_MSIK,
    RCC_LPTIM34CLKSOURCE_LSI,
    RCC_LPTIM34CLKSOURCE_HSI,
    RCC_LPTIM34CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM34CLKSOURCE_MSIK => 0,
            .RCC_LPTIM34CLKSOURCE_LSI => 1,
            .RCC_LPTIM34CLKSOURCE_HSI => 2,
            .RCC_LPTIM34CLKSOURCE_LSE => 3,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_HSI48,
    RCC_RNGCLKSOURCE_HSI48_DIV2,
    RCC_RNGCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_HSI48 => 0,
            .RCC_RNGCLKSOURCE_HSI48_DIV2 => 1,
            .RCC_RNGCLKSOURCE_HSI => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLL1CLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSI,
    RCC_MCO1SOURCE_HSI48,
    RCC_MCO1SOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLL1CLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_MSI => 6,
            .RCC_MCO1SOURCE_HSI48 => 7,
            .RCC_MCO1SOURCE_MSIK => 8,
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
pub const CortexCLockSelectionList = enum {
    SYSTICK_CLKSOURCE_HCLK_1_8,
    SYSTICK_CLKSOURCE_LSE,
    SYSTICK_CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SYSTICK_CLKSOURCE_HCLK_1_8 => 0,
            .SYSTICK_CLKSOURCE_LSE => 1,
            .SYSTICK_CLKSOURCE_LSI => 2,
        };
    }
};
pub const SPI1CLockSelectionList = enum {
    RCC_SPI1CLKSOURCE_PCLK2,
    RCC_SPI1CLKSOURCE_SYSCLK,
    RCC_SPI1CLKSOURCE_HSI,
    RCC_SPI1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PCLK2 => 0,
            .RCC_SPI1CLKSOURCE_SYSCLK => 1,
            .RCC_SPI1CLKSOURCE_HSI => 2,
            .RCC_SPI1CLKSOURCE_MSIK => 3,
        };
    }
};
pub const SPI3CLockSelectionList = enum {
    RCC_SPI3CLKSOURCE_PCLK3,
    RCC_SPI3CLKSOURCE_SYSCLK,
    RCC_SPI3CLKSOURCE_HSI,
    RCC_SPI3CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3CLKSOURCE_PCLK3 => 0,
            .RCC_SPI3CLKSOURCE_SYSCLK => 1,
            .RCC_SPI3CLKSOURCE_HSI => 2,
            .RCC_SPI3CLKSOURCE_MSIK => 3,
        };
    }
};
pub const SPI2CLockSelectionList = enum {
    RCC_SPI2CLKSOURCE_PCLK1,
    RCC_SPI2CLKSOURCE_SYSCLK,
    RCC_SPI2CLKSOURCE_HSI,
    RCC_SPI2CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI2CLKSOURCE_PCLK1 => 0,
            .RCC_SPI2CLKSOURCE_SYSCLK => 1,
            .RCC_SPI2CLKSOURCE_HSI => 2,
            .RCC_SPI2CLKSOURCE_MSIK => 3,
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
    RCC_MSIRANGE_12,
    RCC_MSIRANGE_13,
    RCC_MSIRANGE_14,
    RCC_MSIRANGE_15,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSIRANGE_0 => 48000000,
            .RCC_MSIRANGE_1 => 24000000,
            .RCC_MSIRANGE_2 => 16000000,
            .RCC_MSIRANGE_3 => 12000000,
            .RCC_MSIRANGE_4 => 4000000,
            .RCC_MSIRANGE_5 => 2000000,
            .RCC_MSIRANGE_6 => 1330000,
            .RCC_MSIRANGE_7 => 1000000,
            .RCC_MSIRANGE_8 => 3072000,
            .RCC_MSIRANGE_9 => 1536000,
            .RCC_MSIRANGE_10 => 1024000,
            .RCC_MSIRANGE_11 => 768000,
            .RCC_MSIRANGE_12 => 400000,
            .RCC_MSIRANGE_13 => 200000,
            .RCC_MSIRANGE_14 => 133000,
            .RCC_MSIRANGE_15 => 100000,
        };
    }
};
pub const MSIKClockRangeList = enum {
    RCC_MSIKRANGE_0,
    RCC_MSIKRANGE_1,
    RCC_MSIKRANGE_2,
    RCC_MSIKRANGE_3,
    RCC_MSIKRANGE_4,
    RCC_MSIKRANGE_5,
    RCC_MSIKRANGE_6,
    RCC_MSIKRANGE_7,
    RCC_MSIKRANGE_8,
    RCC_MSIKRANGE_9,
    RCC_MSIKRANGE_10,
    RCC_MSIKRANGE_11,
    RCC_MSIKRANGE_12,
    RCC_MSIKRANGE_13,
    RCC_MSIKRANGE_14,
    RCC_MSIKRANGE_15,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSIKRANGE_0 => 48000000,
            .RCC_MSIKRANGE_1 => 24000000,
            .RCC_MSIKRANGE_2 => 16000000,
            .RCC_MSIKRANGE_3 => 12000000,
            .RCC_MSIKRANGE_4 => 4000000,
            .RCC_MSIKRANGE_5 => 2000000,
            .RCC_MSIKRANGE_6 => 1330000,
            .RCC_MSIKRANGE_7 => 1000000,
            .RCC_MSIKRANGE_8 => 3072000,
            .RCC_MSIKRANGE_9 => 1536000,
            .RCC_MSIKRANGE_10 => 1024000,
            .RCC_MSIKRANGE_11 => 768000,
            .RCC_MSIKRANGE_12 => 400000,
            .RCC_MSIKRANGE_13 => 200000,
            .RCC_MSIKRANGE_14 => 133000,
            .RCC_MSIKRANGE_15 => 100000,
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
pub const APB3CLKDividerList = enum {
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
pub const PLL1RList = enum {
    @"1",
    @"2",
    @"4",
    @"6",
    @"8",
    @"10",
    @"12",
    @"14",
    @"16",
    @"18",
    @"20",
    @"22",
    @"24",
    @"26",
    @"28",
    @"30",
    @"32",
    @"34",
    @"36",
    @"38",
    @"40",
    @"42",
    @"44",
    @"46",
    @"48",
    @"50",
    @"52",
    @"54",
    @"56",
    @"58",
    @"60",
    @"62",
    @"64",
    @"66",
    @"68",
    @"70",
    @"72",
    @"74",
    @"76",
    @"78",
    @"80",
    @"82",
    @"84",
    @"86",
    @"88",
    @"90",
    @"92",
    @"94",
    @"96",
    @"98",
    @"100",
    @"102",
    @"104",
    @"106",
    @"108",
    @"110",
    @"112",
    @"114",
    @"116",
    @"118",
    @"120",
    @"122",
    @"124",
    @"126",
    @"128",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"1" => 1,
            .@"2" => 2,
            .@"4" => 4,
            .@"6" => 6,
            .@"8" => 8,
            .@"10" => 10,
            .@"12" => 12,
            .@"14" => 14,
            .@"16" => 16,
            .@"18" => 18,
            .@"20" => 20,
            .@"22" => 22,
            .@"24" => 24,
            .@"26" => 26,
            .@"28" => 28,
            .@"30" => 30,
            .@"32" => 32,
            .@"34" => 34,
            .@"36" => 36,
            .@"38" => 38,
            .@"40" => 40,
            .@"42" => 42,
            .@"44" => 44,
            .@"46" => 46,
            .@"48" => 48,
            .@"50" => 50,
            .@"52" => 52,
            .@"54" => 54,
            .@"56" => 56,
            .@"58" => 58,
            .@"60" => 60,
            .@"62" => 62,
            .@"64" => 64,
            .@"66" => 66,
            .@"68" => 68,
            .@"70" => 70,
            .@"72" => 72,
            .@"74" => 74,
            .@"76" => 76,
            .@"78" => 78,
            .@"80" => 80,
            .@"82" => 82,
            .@"84" => 84,
            .@"86" => 86,
            .@"88" => 88,
            .@"90" => 90,
            .@"92" => 92,
            .@"94" => 94,
            .@"96" => 96,
            .@"98" => 98,
            .@"100" => 100,
            .@"102" => 102,
            .@"104" => 104,
            .@"106" => 106,
            .@"108" => 108,
            .@"110" => 110,
            .@"112" => 112,
            .@"114" => 114,
            .@"116" => 116,
            .@"118" => 118,
            .@"120" => 120,
            .@"122" => 122,
            .@"124" => 124,
            .@"126" => 126,
            .@"128" => 128,
        };
    }
};
pub const FLatencyList = enum {
    FLASH_LATENCY_4,
    FLASH_LATENCY_1,
    FLASH_LATENCY_0,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE4,
    PWR_REGULATOR_VOLTAGE_SCALE3,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
};
pub const MSIAutoCalibrationList = enum {
    PLLMODE_MSIS,
    PLLMODE_MSIK,
    DISABLED,
};
pub const MSIPLLFASTList = enum {
    true,
    false,
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
pub const PLL1MBOOSTList = enum {
    RCC_PLLMBOOST_DIV1,
    RCC_PLLMBOOST_DIV2,
    RCC_PLLMBOOST_DIV4,
    RCC_PLLMBOOST_DIV6,
    RCC_PLLMBOOST_DIV8,
    RCC_PLLMBOOST_DIV10,
    RCC_PLLMBOOST_DIV12,
    RCC_PLLMBOOST_DIV14,
    RCC_PLLMBOOST_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLMBOOST_DIV1 => 1,
            .RCC_PLLMBOOST_DIV2 => 2,
            .RCC_PLLMBOOST_DIV4 => 4,
            .RCC_PLLMBOOST_DIV6 => 6,
            .RCC_PLLMBOOST_DIV8 => 8,
            .RCC_PLLMBOOST_DIV10 => 10,
            .RCC_PLLMBOOST_DIV12 => 12,
            .RCC_PLLMBOOST_DIV14 => 14,
            .RCC_PLLMBOOST_DIV16 => 16,
        };
    }
};
pub const PLL1_VCI_RangeList = enum {
    RCC_PLLVCIRANGE_0,
    RCC_PLLVCIRANGE_1,
};
pub const PLL2_VCI_RangeList = enum {
    RCC_PLLVCIRANGE_0,
    RCC_PLLVCIRANGE_1,
};
pub const PLL3_VCI_RangeList = enum {
    RCC_PLLVCIRANGE_0,
    RCC_PLLVCIRANGE_1,
};
pub const MSIKERONList = enum {
    true,
    false,
};
pub const HSIKERONList = enum {
    true,
    false,
};
pub const EnableCRSList = enum {
    true,
    false,
};
pub const RNGEnableLPBAMList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const SDMMCEnableLPBAMList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const EnableSAESList = enum {
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
pub const notInLPBAMList = enum {
    false,
    true,
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
pub const DACEnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const SDMMCEnableList = enum {
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
pub const MDF1EnableList = enum {
    true,
    false,
};
pub const ADF1EnableList = enum {
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
pub const RNGEnableList = enum {
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
pub const SPI1EnableList = enum {
    true,
    false,
};
pub const SPI3EnableList = enum {
    true,
    false,
};
pub const SPI2EnableList = enum {
    true,
    false,
};
pub const SAI1EnableLPBAMList = enum {
    true,
    false,
};
pub const SAI2EnableLPBAMList = enum {
    true,
    false,
};
pub const MDF1EnableLPBAMList = enum {
    true,
    false,
};
pub const ADF1EnableLPBAMList = enum {
    true,
    false,
};
pub const FDCANEnableLPBAMList = enum {
    true,
    false,
};
pub const OCTOSPIMEnableLPBAMList = enum {
    true,
    false,
};
pub const ADCEnableLPBAMList = enum {
    true,
    false,
};
pub const DACEnableLPBAMList = enum {
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
pub const EnbaleCSSList = enum {
    true,
    false,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEByPass: bool = false,
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            LSEByPassRTC: bool = false,
            LSEOscillatorRTC: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
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
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC4: bool = false,
            ADCUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            notUsed: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM3_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM2_Used: bool = false,
            UCPD1_Used: bool = false,
            ADF1_Used: bool = false,
            MDF1_Used: bool = false,
            SAES_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            LSEState: ?LSEStateList = null,
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            MSIAutoCalibration: ?MSIAutoCalibrationList = null,
            MSIPLLFAST: ?MSIPLLFASTList = null,
            Prescaler: ?PrescalerList = null,
            Polarity: ?PolarityList = null,
            ReloadValueType: ?ReloadValueTypeList = null,
            ReloadValue: ?u32 = null,
            Fsync: ?f32 = null,
            ErrorLimitValue: ?u32 = null,
            HSI48CalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
            PLL1MBOOST: ?PLL1MBOOSTList = null,
            MSIKERON: ?MSIKERONList = null,
            HSIKERON: ?HSIKERONList = null,
            EnbaleCSS: ?EnbaleCSSList = null,
        };
        pub const Config = struct {
            SAESSource: ?SAESSourceList = null,
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSIDIV: ?LSIDIVList = null,
            LSE_VALUE: ?f32 = null,
            MSIClockRange: ?MSIClockRangeList = null,
            MSIKClockRange: ?MSIKClockRangeList = null,
            RCC_Stop_WakeUpClock: ?RCC_Stop_WakeUpClockList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLL2Source: ?PLL2SourceList = null,
            PLL3Source: ?PLL3SourceList = null,
            PLLM: ?u32 = null,
            PLL2M: ?u32 = null,
            PLL3M: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART3CLockSelection: ?USART3CLockSelectionList = null,
            UART4CLockSelection: ?UART4CLockSelectionList = null,
            UART5CLockSelection: ?UART5CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            DACCLockSelection: ?DACCLockSelectionList = null,
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
            MdfClockSelection: ?MdfClockSelectionList = null,
            AdfClockSelection: ?AdfClockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            CortexCLockSelection: ?CortexCLockSelectionList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            APB3CLKDivider: ?APB3CLKDividerList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI3CLockSelection: ?SPI3CLockSelectionList = null,
            SPI2CLockSelection: ?SPI2CLockSelectionList = null,
            PLLN: ?u32 = null,
            PLLFRACN: ?u32 = null,
            PLL1P: ?u32 = null,
            PLL1Q: ?u32 = null,
            PLL1R: ?PLL1RList = null,
            PLL2N: ?u32 = null,
            PLL2FRACN: ?u32 = null,
            PLL2P: ?u32 = null,
            PLL2Q: ?u32 = null,
            PLL2R: ?u32 = null,
            PLL3N: ?u32 = null,
            PLL3FRACN: ?u32 = null,
            PLL3P: ?u32 = null,
            PLL3Q: ?u32 = null,
            PLL3R: ?u32 = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            CRSCLKoutput: f32 = 0,
            HSI48RC: f32 = 0,
            SHSIRC: f32 = 0,
            SHSIDiv: f32 = 0,
            SAESMult: f32 = 0,
            SAESoutput: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSIDIV: f32 = 0,
            LSEOSC: f32 = 0,
            MSIRC: f32 = 0,
            MSIKRC: f32 = 0,
            SAI1_EXT: f32 = 0,
            RCC_Stop_WakeUpClock: f32 = 0,
            WakeUpClockOutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLL2Source: f32 = 0,
            PLL3Source: f32 = 0,
            PLLM: f32 = 0,
            PLL2M: f32 = 0,
            PLL3M: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
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
            DACMult: f32 = 0,
            DACoutput: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CK48Mult: f32 = 0,
            CK48output: f32 = 0,
            USBoutput: f32 = 0,
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
            MDF1Mult: f32 = 0,
            MDF1output: f32 = 0,
            ADF1Mult: f32 = 0,
            ADF1output: f32 = 0,
            OCTOSPIMMult: f32 = 0,
            OCTOSPIMoutput: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            HSI48DivToRNG: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexCLockSelection: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            APB3Prescaler: f32 = 0,
            APB3Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            UCPD1Output: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI3Mult: f32 = 0,
            SPI3output: f32 = 0,
            SPI2Mult: f32 = 0,
            SPI2output: f32 = 0,
            PLLN: f32 = 0,
            PLLFRACN: f32 = 0,
            PLL1P: f32 = 0,
            PLLPoutput: f32 = 0,
            PLL1Q: f32 = 0,
            PLLQoutput: f32 = 0,
            PLL1R: f32 = 0,
            PLL2N: f32 = 0,
            PLL2FRACN: f32 = 0,
            PLL2P: f32 = 0,
            PLL2Poutput: f32 = 0,
            PLL2Q: f32 = 0,
            PLL2Qoutput: f32 = 0,
            PLL2R: f32 = 0,
            PLL2Routput: f32 = 0,
            PLL3N: f32 = 0,
            PLL3FRACN: f32 = 0,
            PLL3P: f32 = 0,
            PLL3Poutput: f32 = 0,
            PLL3Q: f32 = 0,
            PLL3Qoutput: f32 = 0,
            PLL3R: f32 = 0,
            PLL3Routput: f32 = 0,
            MSIS: f32 = 0,
            PLLSRC: f32 = 0,
            VCOInput: f32 = 0,
            VCOInput2: f32 = 0,
            VCOInput3: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            VCOPLL2Output: f32 = 0,
            VCOPLL3Output: f32 = 0,
            LSIclk: f32 = 0,
        };
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
            HSEByPass: bool = false,
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            LSEByPassRTC: bool = false,
            LSEOscillatorRTC: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
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
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC4: bool = false,
            ADCUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            notUsed: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM3_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM2_Used: bool = false,
            UCPD1_Used: bool = false,
            ADF1_Used: bool = false,
            MDF1_Used: bool = false,
            SAES_Used: bool = false,
            EnableCRS: bool = false,
            RNGEnableLPBAM: bool = false,
            MCOEnable: bool = false,
            SDMMCEnableLPBAM: bool = false,
            USBEnable: bool = false,
            EnableSAES: bool = false,
            LSIEnable: bool = false,
            EnableExtClockForSAI1: bool = false,
            EnableHSERTCDevisor: bool = false,
            EnableHSELCDDevisor: bool = false,
            RTCEnable: bool = false,
            LCDEnable: bool = false,
            IWDGEnable: bool = false,
            USART1Enable: bool = false,
            USART2Enable: bool = false,
            USART3Enable: bool = false,
            UART4Enable: bool = false,
            UART5Enable: bool = false,
            LPUART1Enable: bool = false,
            LPTIM1Enable: bool = false,
            LPTIM2Enable: bool = false,
            DACEnable: bool = false,
            ADCEnable: bool = false,
            SDMMCEnable: bool = false,
            FDCANEnable: bool = false,
            I2C1Enable: bool = false,
            I2C2Enable: bool = false,
            I2C3Enable: bool = false,
            SAI1Enable: bool = false,
            SAI2Enable: bool = false,
            I2C4Enable: bool = false,
            MDF1Enable: bool = false,
            ADF1Enable: bool = false,
            OCTOSPIMEnable: bool = false,
            LPTIM3Enable: bool = false,
            RNGEnable: bool = false,
            LSCOEnable: bool = false,
            UCPDEnable: bool = false,
            SPI1Enable: bool = false,
            SPI3Enable: bool = false,
            SPI2Enable: bool = false,
            SAI1EnableLPBAM: bool = false,
            SAI2EnableLPBAM: bool = false,
            MDF1EnableLPBAM: bool = false,
            ADF1EnableLPBAM: bool = false,
            FDCANEnableLPBAM: bool = false,
            OCTOSPIMEnableLPBAM: bool = false,
            ADCEnableLPBAM: bool = false,
            DACEnableLPBAM: bool = false,
            PLL1PUsed: bool = false,
            PLL1QUsed: bool = false,
            PLL2PUsed: bool = false,
            PLL2QUsed: bool = false,
            PLL2RUsed: bool = false,
            PLL3PUsed: bool = false,
            PLL3QUsed: bool = false,
            PLLUsed: bool = false,
            PLL2Used: bool = false,
            PLL3Used: bool = false,
            FullHSI48Used: bool = false,
            MSIKUsed: bool = false,
            MSISUsed: bool = false,
            LSEUsed: bool = false,
            EnableCSSLSE: bool = false,
            EnbaleCSS: bool = false,
            PLL1RUsed: bool = false,
            MSIUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSI48_VALUE: ?f32 = null, //from RCC Clock Config
            SHSI_VALUE: ?f32 = null, //from RCC Clock Config
            SHSIDiv: ?f32 = null, //from RCC Clock Config
            SAESSource: ?SAESSourceList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSIDIV: ?LSIDIVList = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            MSIKClockRange: ?MSIKClockRangeList = null, //from RCC Clock Config
            EXTERNALSAI1_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_Stop_WakeUpClock: ?RCC_Stop_WakeUpClockList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLL2Source: ?PLL2SourceList = null, //from RCC Clock Config
            PLL3Source: ?PLL3SourceList = null, //from RCC Clock Config
            PLLM: ?f32 = null, //from RCC Clock Config
            PLL2M: ?f32 = null, //from RCC Clock Config
            PLL3M: ?f32 = null, //from RCC Clock Config
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
            DACCLockSelection: ?DACCLockSelectionList = null, //from extra RCC references
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
            MdfClockSelection: ?MdfClockSelectionList = null, //from RCC Clock Config
            AdfClockSelection: ?AdfClockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from extra RCC references
            HSI48DivToRNG: ?f32 = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from extra RCC references
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from extra RCC references
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            CortexCLockSelection: ?CortexCLockSelectionList = null, //from extra RCC references
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB3CLKDivider: ?APB3CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI3CLockSelection: ?SPI3CLockSelectionList = null, //from RCC Clock Config
            SPI2CLockSelection: ?SPI2CLockSelectionList = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            PLL1P: ?f32 = null, //from RCC Clock Config
            PLL1Q: ?f32 = null, //from RCC Clock Config
            PLL1R: ?PLL1RList = null, //from RCC Clock Config
            PLL2N: ?f32 = null, //from RCC Clock Config
            PLL2FRACN: ?f32 = null, //from RCC Clock Config
            PLL2P: ?f32 = null, //from RCC Clock Config
            PLL2Q: ?f32 = null, //from RCC Clock Config
            PLL2R: ?f32 = null, //from RCC Clock Config
            PLL3N: ?f32 = null, //from RCC Clock Config
            PLL3FRACN: ?f32 = null, //from RCC Clock Config
            PLL3P: ?f32 = null, //from RCC Clock Config
            PLL3Q: ?f32 = null, //from RCC Clock Config
            PLL3R: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            MSIAutoCalibration: ?MSIAutoCalibrationList = null, //from RCC Advanced Config
            MSIPLLFAST: ?MSIPLLFASTList = null, //from RCC Advanced Config
            Prescaler: ?PrescalerList = null, //from RCC Advanced Config
            Source: ?SourceList = null, //from RCC Advanced Config
            Polarity: ?PolarityList = null, //from RCC Advanced Config
            ReloadValueType: ?ReloadValueTypeList = null, //from RCC Advanced Config
            ReloadValue: ?f32 = null, //from RCC Advanced Config
            Fsync: ?f32 = null, //from RCC Advanced Config
            ErrorLimitValue: ?f32 = null, //from RCC Advanced Config
            HSI48CalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            PLL1MBOOST: ?PLL1MBOOSTList = null, //from RCC Advanced Config
            PLL1_VCI_Range: ?PLL1_VCI_RangeList = null, //from RCC Advanced Config
            PLL2_VCI_Range: ?PLL2_VCI_RangeList = null, //from RCC Advanced Config
            PLL3_VCI_Range: ?PLL3_VCI_RangeList = null, //from RCC Advanced Config
            MSIKERON: ?MSIKERONList = null, //from RCC Advanced Config
            HSIKERON: ?HSIKERONList = null, //from RCC Advanced Config
            notInLPBAM: ?notInLPBAMList = null, //from extra RCC references
            LSEState: ?LSEStateList = null, //from RCC Advanced Config
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

            //Semaphores flags

            var WakeUpClockMSI: bool = false;
            var WakeUpClockHSI: bool = false;
            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var PLLSourceMSI: bool = false;
            var PLLSourceHSI: bool = false;
            var PLLSourceHSE: bool = false;
            var PLL2SourceMSI: bool = false;
            var PLL2SourceHSI: bool = false;
            var PLL2SourceHSE: bool = false;
            var PLL3SourceMSI: bool = false;
            var PLL3SourceHSI: bool = false;
            var PLL3SourceHSE: bool = false;
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
            var UART5Sourcesys: bool = false;
            var UART5SourceHSI: bool = false;
            var UART5SourceLSE: bool = false;
            var LPUART1SourceHSI: bool = false;
            var LPUART1SourceLSE: bool = false;
            var LPUART1SourceMSIK: bool = false;
            var LPTIM1CLKSOURCE_MSIK: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2SOURCEHSI: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var DAC1CLKSOURCE_LSE: bool = false;
            var DAC1CLKSOURCE_LSI: bool = false;
            var ADCSourceSys: bool = false;
            var ADCSourcePLL2R: bool = false;
            var ADCSourceHSE: bool = false;
            var ADCSourceHSI: bool = false;
            var ADCSourceMSIK: bool = false;
            var CK48SourcePLL2Q: bool = false;
            var CK48SourcePLL1Q: bool = false;
            var CLK48CLKSOURCE_MSIK: bool = false;
            var CK48SourceHSI48: bool = false;
            var SDMMC1SourceIsPllP: bool = false;
            var SDMMC1SourceIsClock48: bool = false;
            var FDCANSourcePLL1Q: bool = false;
            var FDCANSourcePLL2P: bool = false;
            var FDCANSourceHSE: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C1CLKSOURCE_MSIK: bool = false;
            var I2C2SourceSys: bool = false;
            var I2C2SourceHSI: bool = false;
            var I2C2CLKSOURCE_MSIK: bool = false;
            var I2C3SourceSys: bool = false;
            var I2C3SourceHSI: bool = false;
            var I2C3CLKSOURCE_MSIK: bool = false;
            var SAI1SourcePLL2P: bool = false;
            var SAI1SourcePLL3P: bool = false;
            var SAI1SourcePLL1P: bool = false;
            var SAI1SourceEXT: bool = false;
            var SAI1SourceHSI: bool = false;
            var SAI2SourcePLL2P: bool = false;
            var SAI2SourcePLL3P: bool = false;
            var SAI2SourcePLL1P: bool = false;
            var SAI2SourceEXT: bool = false;
            var SAI2SourceHSI: bool = false;
            var I2C4SourceSys: bool = false;
            var I2C4SourceHSI: bool = false;
            var I2C4CLKSOURCE_MSIK: bool = false;
            var MDF1CLKSOURCE_PLL1P: bool = false;
            var MDF1CLKSOURCE_PLL3Q: bool = false;
            var MDF1CLKSOURCE_MSIK: bool = false;
            var ADF1CLKSOURCE_PLL1P: bool = false;
            var ADF1CLKSOURCE_PLL3Q: bool = false;
            var ADF1CLKSOURCE_MSIK: bool = false;
            var OCTOSPIMSourceMSIK: bool = false;
            var OCTOSPIMSourceSYS: bool = false;
            var OCTOSPIMSourcePLL1Q: bool = false;
            var OCTOSPIMSourcePLL2Q: bool = false;
            var LPTIM34CLKSOURCE_MSIK: bool = false;
            var LPTIM3SOURCELSI: bool = false;
            var LPTIM3SOURCEHSI: bool = false;
            var LPTIM3SOURCELSE: bool = false;
            var RNGCLKSOURCE_HSI48: bool = false;
            var RNGCLKSOURCE_HSI48DIV2: bool = false;
            var RNGCLKSOURCE_HSI: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var MCO1SOURCE_PLLR: bool = false;
            var MCO1SOURCE_MSIK: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var CLKSOURCE_HCLK_1_8: bool = false;
            var CLKSOURCE_LSE: bool = false;
            var CLKSOURCE_LSI: bool = false;
            var SPI1CLKSOURCE_HSI: bool = false;
            var SPI1CLKSOURCE_MSIK: bool = false;
            var SPI3CLKSOURCE_HSI: bool = false;
            var SPI3CLKSOURCE_MSIK: bool = false;
            var SPI2CLKSOURCE_HSI: bool = false;
            var SPI2CLKSOURCE_MSIK: bool = false;
            var LSI_DIV1: bool = false;
            var LSI_DIV128: bool = false;
            var MSIS48: bool = false;
            var MSIK48: bool = false;
            var AHBCLKDivider1: bool = false;
            var CLKSOURCE_HCLK: bool = false;
            var CLKSOURCE_HCLK_DIV8: bool = false;
            var scale4: bool = false;
            var scale3: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
            var MSIAutoCalibrationON: bool = false;
            var MSIKAutoCalibrationON: bool = false;
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
            var hsikeron_ENABLED: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;
            var CSSEnabled: bool = false;

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

            var SHSIRC = ClockNode{
                .name = "SHSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var SHSIDiv = ClockNode{
                .name = "SHSIDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAESMult = ClockNode{
                .name = "SAESMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAESoutput = ClockNode{
                .name = "SAESoutput",
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

            var MSIKRC = ClockNode{
                .name = "MSIKRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1_EXT = ClockNode{
                .name = "SAI1_EXT",
                .nodetype = .off,
                .parents = &.{},
            };

            var RCC_Stop_WakeUpClock = ClockNode{
                .name = "RCC_Stop_WakeUpClock",
                .nodetype = .off,
                .parents = &.{},
            };

            var WakeUpClockOutput = ClockNode{
                .name = "WakeUpClockOutput",
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

            var PLL2Source = ClockNode{
                .name = "PLL2Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Source = ClockNode{
                .name = "PLL3Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM = ClockNode{
                .name = "PLLM",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2M = ClockNode{
                .name = "PLL2M",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3M = ClockNode{
                .name = "PLL3M",
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

            var DACMult = ClockNode{
                .name = "DACMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DACoutput = ClockNode{
                .name = "DACoutput",
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

            var USBoutput = ClockNode{
                .name = "USBoutput",
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

            var MDF1Mult = ClockNode{
                .name = "MDF1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MDF1output = ClockNode{
                .name = "MDF1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADF1Mult = ClockNode{
                .name = "ADF1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADF1output = ClockNode{
                .name = "ADF1output",
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

            var HSI48DivToRNG = ClockNode{
                .name = "HSI48DivToRNG",
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

            var CortexCLockSelection = ClockNode{
                .name = "CortexCLockSelection",
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

            var APB3Prescaler = ClockNode{
                .name = "APB3Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3Output = ClockNode{
                .name = "APB3Output",
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

            var SPI1Mult = ClockNode{
                .name = "SPI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI1output = ClockNode{
                .name = "SPI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI3Mult = ClockNode{
                .name = "SPI3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI3output = ClockNode{
                .name = "SPI3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI2Mult = ClockNode{
                .name = "SPI2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI2output = ClockNode{
                .name = "SPI2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLN = ClockNode{
                .name = "PLLN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLFRACN = ClockNode{
                .name = "PLLFRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1P = ClockNode{
                .name = "PLL1P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLPoutput = ClockNode{
                .name = "PLLPoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1Q = ClockNode{
                .name = "PLL1Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQoutput = ClockNode{
                .name = "PLLQoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1R = ClockNode{
                .name = "PLL1R",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2N = ClockNode{
                .name = "PLL2N",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2FRACN = ClockNode{
                .name = "PLL2FRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2P = ClockNode{
                .name = "PLL2P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Poutput = ClockNode{
                .name = "PLL2Poutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Q = ClockNode{
                .name = "PLL2Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Qoutput = ClockNode{
                .name = "PLL2Qoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2R = ClockNode{
                .name = "PLL2R",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Routput = ClockNode{
                .name = "PLL2Routput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3N = ClockNode{
                .name = "PLL3N",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3FRACN = ClockNode{
                .name = "PLL3FRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3P = ClockNode{
                .name = "PLL3P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Poutput = ClockNode{
                .name = "PLL3Poutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Q = ClockNode{
                .name = "PLL3Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Qoutput = ClockNode{
                .name = "PLL3Qoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3R = ClockNode{
                .name = "PLL3R",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Routput = ClockNode{
                .name = "PLL3Routput",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSIS = ClockNode{
                .name = "MSIS",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSRC = ClockNode{
                .name = "PLLSRC",
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

            var VCOPLL2Output = ClockNode{
                .name = "VCOPLL2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOPLL3Output = ClockNode{
                .name = "VCOPLL3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIclk = ClockNode{
                .name = "LSIclk",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const SHSI_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const SHSIDivValue: ?f32 = blk: {
                break :blk 2;
            };
            const SAESSourceValue: ?SAESSourceList = blk: {
                const conf_item = config.SAESSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAESCLKSOURCE_SHSI => {},
                        .RCC_SAESCLKSOURCE_SHSI_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SAESCLKSOURCE_SHSI;
            };
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 16000000;
            const LSI_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI_VALUE;
                if (config_val) |val| {
                    if (val < 3.14e4) {
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
                            3.14e4,
                            val,
                        });
                    }
                    if (val > 3.26e4) {
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
                            3.26e4,
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
                        .RCC_LSI_DIV1 => LSI_DIV1 = true,
                        .RCC_LSI_DIV128 => LSI_DIV128 = true,
                    }
                }

                break :blk conf_item orelse {
                    LSI_DIV1 = true;
                    break :blk .RCC_LSI_DIV1;
                };
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const MSIClockRangeValue: ?MSIClockRangeList = blk: {
                if (!check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.MSIClockRange;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MSIRANGE_0 => MSIS48 = true,
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
                            .RCC_MSIRANGE_12 => {},
                            .RCC_MSIRANGE_13 => {},
                            .RCC_MSIRANGE_14 => {},
                            .RCC_MSIRANGE_15 => {},
                        }
                    }

                    break :blk conf_item orelse .RCC_MSIRANGE_4;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.MSIClockRange;
                    if (conf_item) |item| {
                        switch (item) {
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
                            .RCC_MSIRANGE_12 => {},
                            .RCC_MSIRANGE_13 => {},
                            .RCC_MSIRANGE_14 => {},
                            .RCC_MSIRANGE_15 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MSIRANGE_1
                                    \\ - RCC_MSIRANGE_2
                                    \\ - RCC_MSIRANGE_3
                                    \\ - RCC_MSIRANGE_4
                                    \\ - RCC_MSIRANGE_5
                                    \\ - RCC_MSIRANGE_6
                                    \\ - RCC_MSIRANGE_7
                                    \\ - RCC_MSIRANGE_8
                                    \\ - RCC_MSIRANGE_9
                                    \\ - RCC_MSIRANGE_10
                                    \\ - RCC_MSIRANGE_11
                                    \\ - RCC_MSIRANGE_12
                                    \\ - RCC_MSIRANGE_13
                                    \\ - RCC_MSIRANGE_14
                                    \\ - RCC_MSIRANGE_15
                                , .{ "MSIClockRange", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MSIRANGE_4;
                }
                break :blk null;
            };
            const MSIKClockRangeValue: ?MSIKClockRangeList = blk: {
                if (!check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.MSIKClockRange;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MSIKRANGE_0 => MSIK48 = true,
                            .RCC_MSIKRANGE_1 => {},
                            .RCC_MSIKRANGE_2 => {},
                            .RCC_MSIKRANGE_3 => {},
                            .RCC_MSIKRANGE_4 => {},
                            .RCC_MSIKRANGE_5 => {},
                            .RCC_MSIKRANGE_6 => {},
                            .RCC_MSIKRANGE_7 => {},
                            .RCC_MSIKRANGE_8 => {},
                            .RCC_MSIKRANGE_9 => {},
                            .RCC_MSIKRANGE_10 => {},
                            .RCC_MSIKRANGE_11 => {},
                            .RCC_MSIKRANGE_12 => {},
                            .RCC_MSIKRANGE_13 => {},
                            .RCC_MSIKRANGE_14 => {},
                            .RCC_MSIKRANGE_15 => {},
                        }
                    }

                    break :blk conf_item orelse .RCC_MSIKRANGE_4;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.MSIKClockRange;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MSIKRANGE_1 => {},
                            .RCC_MSIKRANGE_2 => {},
                            .RCC_MSIKRANGE_3 => {},
                            .RCC_MSIKRANGE_4 => {},
                            .RCC_MSIKRANGE_5 => {},
                            .RCC_MSIKRANGE_6 => {},
                            .RCC_MSIKRANGE_7 => {},
                            .RCC_MSIKRANGE_8 => {},
                            .RCC_MSIKRANGE_9 => {},
                            .RCC_MSIKRANGE_10 => {},
                            .RCC_MSIKRANGE_11 => {},
                            .RCC_MSIKRANGE_12 => {},
                            .RCC_MSIKRANGE_13 => {},
                            .RCC_MSIKRANGE_14 => {},
                            .RCC_MSIKRANGE_15 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MSIKRANGE_1
                                    \\ - RCC_MSIKRANGE_2
                                    \\ - RCC_MSIKRANGE_3
                                    \\ - RCC_MSIKRANGE_4
                                    \\ - RCC_MSIKRANGE_5
                                    \\ - RCC_MSIKRANGE_6
                                    \\ - RCC_MSIKRANGE_7
                                    \\ - RCC_MSIKRANGE_8
                                    \\ - RCC_MSIKRANGE_9
                                    \\ - RCC_MSIKRANGE_10
                                    \\ - RCC_MSIKRANGE_11
                                    \\ - RCC_MSIKRANGE_12
                                    \\ - RCC_MSIKRANGE_13
                                    \\ - RCC_MSIKRANGE_14
                                    \\ - RCC_MSIKRANGE_15
                                , .{ "MSIKClockRange", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MSIKRANGE_4;
                }
                break :blk null;
            };
            const EXTERNALSAI1_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 4.8e4;
            };
            const RCC_Stop_WakeUpClockValue: ?RCC_Stop_WakeUpClockList = blk: {
                const conf_item = config.RCC_Stop_WakeUpClock;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_STOP_WAKEUPCLOCK_MSI => WakeUpClockMSI = true,
                        .RCC_STOP_WAKEUPCLOCK_HSI => WakeUpClockHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    WakeUpClockMSI = true;
                    break :blk .RCC_STOP_WAKEUPCLOCK_MSI;
                };
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
                        .RCC_PLLSOURCE_MSI => PLLSourceMSI = true,
                        .RCC_PLLSOURCE_HSI => PLLSourceHSI = true,
                        .RCC_PLLSOURCE_HSE => PLLSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSourceMSI = true;
                    break :blk .RCC_PLLSOURCE_MSI;
                };
            };
            const PLL2SourceValue: ?PLL2SourceList = blk: {
                const conf_item = config.PLL2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_MSI => PLL2SourceMSI = true,
                        .RCC_PLLSOURCE_HSI => PLL2SourceHSI = true,
                        .RCC_PLLSOURCE_HSE => PLL2SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL2SourceMSI = true;
                    break :blk .RCC_PLLSOURCE_MSI;
                };
            };
            const PLL3SourceValue: ?PLL3SourceList = blk: {
                const conf_item = config.PLL3Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_MSI => PLL3SourceMSI = true,
                        .RCC_PLLSOURCE_HSI => PLL3SourceHSI = true,
                        .RCC_PLLSOURCE_HSE => PLL3SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL3SourceMSI = true;
                    break :blk .RCC_PLLSOURCE_MSI;
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
            const PLL2MValue: ?f32 = blk: {
                const config_val = config.PLL2M;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2M",
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
                            "PLL2M",
                            "Else",
                            "No Extra Log",
                            16,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLL3MValue: ?f32 = blk: {
                const config_val = config.PLL3M;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3M",
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
                            "PLL3M",
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
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    USART1SourceHSI = true;
                    const item: USART1CLockSelectionList = .RCC_USART1CLKSOURCE_HSI;
                    const conf_item = config.USART1CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "USART1CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", "RCC_USART1CLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.USART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                            .RCC_USART1CLKSOURCE_LSE => USART1SourceLSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART1CLKSOURCE_HSI
                                    \\ - RCC_USART1CLKSOURCE_LSE
                                , .{ "USART1CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART1SourceHSI = true;
                        break :blk .RCC_USART1CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
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
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    USART2SourceHSI = true;
                    const item: USART2CLockSelectionList = .RCC_USART2CLKSOURCE_HSI;
                    const conf_item = config.USART2CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "USART2CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", "RCC_USART2CLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.USART2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART2CLKSOURCE_HSI => USART2SourceHSI = true,
                            .RCC_USART2CLKSOURCE_LSE => USART2SourceLSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART2CLKSOURCE_HSI
                                    \\ - RCC_USART2CLKSOURCE_LSE
                                , .{ "USART2CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART2SourceHSI = true;
                        break :blk .RCC_USART2CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
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
            const USART3CLockSelectionValue: ?USART3CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    USART3SourceHSI = true;
                    const item: USART3CLockSelectionList = .RCC_USART3CLKSOURCE_HSI;
                    const conf_item = config.USART3CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "USART3CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", "RCC_USART3CLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.USART3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART3CLKSOURCE_HSI => USART3SourceHSI = true,
                            .RCC_USART3CLKSOURCE_LSE => USART3SourceLSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART3CLKSOURCE_HSI
                                    \\ - RCC_USART3CLKSOURCE_LSE
                                , .{ "USART3CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART3SourceHSI = true;
                        break :blk .RCC_USART3CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
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
            const UART4CLockSelectionValue: ?UART4CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    UART4SourceHSI = true;
                    const item: UART4CLockSelectionList = .RCC_UART4CLKSOURCE_HSI;
                    const conf_item = config.UART4CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "UART4CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", "RCC_UART4CLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.UART4CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_UART4CLKSOURCE_HSI => UART4SourceHSI = true,
                            .RCC_UART4CLKSOURCE_LSE => UART4SourceLSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_UART4CLKSOURCE_HSI
                                    \\ - RCC_UART4CLKSOURCE_LSE
                                , .{ "UART4CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        UART4SourceHSI = true;
                        break :blk .RCC_UART4CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
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
            const UART5CLockSelectionValue: ?UART5CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    UART5SourceHSI = true;
                    const item: UART5CLockSelectionList = .RCC_UART5CLKSOURCE_HSI;
                    const conf_item = config.UART5CLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "UART5CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", "RCC_UART5CLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.UART5CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_UART5CLKSOURCE_HSI => UART5SourceHSI = true,
                            .RCC_UART5CLKSOURCE_LSE => UART5SourceLSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_UART5CLKSOURCE_HSI
                                    \\ - RCC_UART5CLKSOURCE_LSE
                                , .{ "UART5CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        UART5SourceHSI = true;
                        break :blk .RCC_UART5CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.UART5CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_UART5CLKSOURCE_PCLK1 => {},
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

                    break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
                }
                const conf_item = config.UART5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => {},
                        .RCC_UART5CLKSOURCE_SYSCLK => UART5Sourcesys = true,
                        .RCC_UART5CLKSOURCE_HSI => UART5SourceHSI = true,
                        .RCC_UART5CLKSOURCE_LSE => UART5SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPUART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                            .RCC_LPUART1CLKSOURCE_MSIK => LPUART1SourceMSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPUART1CLKSOURCE_HSI
                                    \\ - RCC_LPUART1CLKSOURCE_MSIK
                                , .{ "LPUART1CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPUART1SourceHSI = true;
                        break :blk .RCC_LPUART1CLKSOURCE_HSI;
                    };
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.LPUART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                            .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                            .RCC_LPUART1CLKSOURCE_MSIK => LPUART1SourceMSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPUART1CLKSOURCE_HSI
                                    \\ - RCC_LPUART1CLKSOURCE_LSE
                                    \\ - RCC_LPUART1CLKSOURCE_MSIK
                                , .{ "LPUART1CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPUART1SourceHSI = true;
                        break :blk .RCC_LPUART1CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPUART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPUART1CLKSOURCE_PCLK3 => {},
                            .RCC_LPUART1CLKSOURCE_SYSCLK => {},
                            .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                            .RCC_LPUART1CLKSOURCE_MSIK => LPUART1SourceMSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPUART1CLKSOURCE_PCLK3
                                    \\ - RCC_LPUART1CLKSOURCE_SYSCLK
                                    \\ - RCC_LPUART1CLKSOURCE_HSI
                                    \\ - RCC_LPUART1CLKSOURCE_MSIK
                                , .{ "LPUART1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK3;
                }
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK3 => {},
                        .RCC_LPUART1CLKSOURCE_SYSCLK => {},
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                        .RCC_LPUART1CLKSOURCE_MSIK => LPUART1SourceMSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK3;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM1CLKSOURCE_MSIK => LPTIM1CLKSOURCE_MSIK = true,
                            .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                            .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM1CLKSOURCE_MSIK
                                    \\ - RCC_LPTIM1CLKSOURCE_LSI
                                    \\ - RCC_LPTIM1CLKSOURCE_HSI
                                , .{ "LPTIM1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPTIM1CLKSOURCE_MSIK = true;
                        break :blk .RCC_LPTIM1CLKSOURCE_MSIK;
                    };
                }
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_MSIK => LPTIM1CLKSOURCE_MSIK = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM1CLKSOURCE_MSIK = true;
                    break :blk .RCC_LPTIM1CLKSOURCE_MSIK;
                };
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF") and (config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                            .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM2CLKSOURCE_LSI
                                    \\ - RCC_LPTIM2CLKSOURCE_HSI
                                , .{ "LPTIM2CLockSelection", "S_LPBAM_CONF & (LSEOscillatorRTC|LSEByPassRTC)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPTIM2SOURCEHSI = true;
                        break :blk .RCC_LPTIM2CLKSOURCE_HSI;
                    };
                } else if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.LPTIM2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                            .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                            .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM2CLKSOURCE_LSI
                                    \\ - RCC_LPTIM2CLKSOURCE_HSI
                                    \\ - RCC_LPTIM2CLKSOURCE_LSE
                                , .{ "LPTIM2CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPTIM2SOURCEHSI = true;
                        break :blk .RCC_LPTIM2CLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
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
            const DACCLockSelectionValue: ?DACCLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    DAC1CLKSOURCE_LSI = true;
                    const item: DACCLockSelectionList = .RCC_DAC1CLKSOURCE_LSI;
                    const conf_item = config.DACCLockSelection;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "DACCLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", "RCC_DAC1CLKSOURCE_LSI", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.DACCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DAC1CLKSOURCE_LSE => DAC1CLKSOURCE_LSE = true,
                        .RCC_DAC1CLKSOURCE_LSI => DAC1CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    DAC1CLKSOURCE_LSI = true;
                    break :blk .RCC_DAC1CLKSOURCE_LSI;
                };
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.ADCCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_ADCDACCLKSOURCE_HSE => ADCSourceHSE = true,
                            .RCC_ADCDACCLKSOURCE_HSI => ADCSourceHSI = true,
                            .RCC_ADCDACCLKSOURCE_MSIK => ADCSourceMSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_ADCDACCLKSOURCE_HSE
                                    \\ - RCC_ADCDACCLKSOURCE_HSI
                                    \\ - RCC_ADCDACCLKSOURCE_MSIK
                                , .{ "ADCCLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        ADCSourceHSI = true;
                        break :blk .RCC_ADCDACCLKSOURCE_HSI;
                    };
                }
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCDACCLKSOURCE_HCLK => {},
                        .RCC_ADCDACCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        .RCC_ADCDACCLKSOURCE_PLL2 => ADCSourcePLL2R = true,
                        .RCC_ADCDACCLKSOURCE_HSE => ADCSourceHSE = true,
                        .RCC_ADCDACCLKSOURCE_HSI => ADCSourceHSI = true,
                        .RCC_ADCDACCLKSOURCE_MSIK => ADCSourceMSIK = true,
                    }
                }

                break :blk conf_item orelse {
                    ADCSourceHSI = true;
                    break :blk .RCC_ADCDACCLKSOURCE_HSI;
                };
            };
            const CK48CLockSelectionValue: ?CK48CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.CK48CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_CLK48CLKSOURCE_PLL2 => CK48SourcePLL2Q = true,
                            .RCC_CLK48CLKSOURCE_PLL1 => CK48SourcePLL1Q = true,
                            .RCC_CLK48CLKSOURCE_MSIK => CLK48CLKSOURCE_MSIK = true,
                            .RCC_CLK48CLKSOURCE_HSI48 => CK48SourceHSI48 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        CLK48CLKSOURCE_MSIK = true;
                        break :blk .RCC_CLK48CLKSOURCE_MSIK;
                    };
                }
                const conf_item = config.CK48CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLK48CLKSOURCE_PLL2 => CK48SourcePLL2Q = true,
                        .RCC_CLK48CLKSOURCE_PLL1 => CK48SourcePLL1Q = true,
                        .RCC_CLK48CLKSOURCE_MSIK => CLK48CLKSOURCE_MSIK = true,
                        .RCC_CLK48CLKSOURCE_HSI48 => CK48SourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    CK48SourceHSI48 = true;
                    break :blk .RCC_CLK48CLKSOURCE_HSI48;
                };
            };
            const SDMMCClockSelectionValue: ?SDMMCClockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.SDMMCClockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SDMMCCLKSOURCE_PLL1 => SDMMC1SourceIsPllP = true,
                            .RCC_SDMMCCLKSOURCE_CLK48 => SDMMC1SourceIsClock48 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        SDMMC1SourceIsClock48 = true;
                        break :blk .RCC_SDMMCCLKSOURCE_CLK48;
                    };
                }
                const conf_item = config.SDMMCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMCCLKSOURCE_PLL1 => SDMMC1SourceIsPllP = true,
                        .RCC_SDMMCCLKSOURCE_CLK48 => SDMMC1SourceIsClock48 = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1SourceIsPllP = true;
                    break :blk .RCC_SDMMCCLKSOURCE_PLL1;
                };
            };
            const FDCANClockSelectionValue: ?FDCANClockSelectionList = blk: {
                const conf_item = config.FDCANClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCAN1CLKSOURCE_PLL1 => FDCANSourcePLL1Q = true,
                        .RCC_FDCAN1CLKSOURCE_PLL2 => FDCANSourcePLL2P = true,
                        .RCC_FDCAN1CLKSOURCE_HSE => FDCANSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    FDCANSourcePLL1Q = true;
                    break :blk .RCC_FDCAN1CLKSOURCE_PLL1;
                };
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.I2C1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                            .RCC_I2C1CLKSOURCE_MSIK => I2C1CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_I2C1CLKSOURCE_HSI
                                    \\ - RCC_I2C1CLKSOURCE_MSIK
                                , .{ "I2C1CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        I2C1SourceHSI = true;
                        break :blk .RCC_I2C1CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => {},
                        .RCC_I2C1CLKSOURCE_SYSCLK => I2C1SourceSys = true,
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                        .RCC_I2C1CLKSOURCE_MSIK => I2C1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C2CLockSelectionValue: ?I2C2CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.I2C2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                            .RCC_I2C2CLKSOURCE_MSIK => I2C2CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_I2C2CLKSOURCE_HSI
                                    \\ - RCC_I2C2CLKSOURCE_MSIK
                                , .{ "I2C2CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        I2C2SourceHSI = true;
                        break :blk .RCC_I2C2CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.I2C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_PCLK1 => {},
                        .RCC_I2C2CLKSOURCE_SYSCLK => I2C2SourceSys = true,
                        .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                        .RCC_I2C2CLKSOURCE_MSIK => I2C2CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C2CLKSOURCE_PCLK1;
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.I2C3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                            .RCC_I2C3CLKSOURCE_MSIK => I2C3CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_I2C3CLKSOURCE_HSI
                                    \\ - RCC_I2C3CLKSOURCE_MSIK
                                , .{ "I2C3CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        I2C3SourceHSI = true;
                        break :blk .RCC_I2C3CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK3 => {},
                        .RCC_I2C3CLKSOURCE_SYSCLK => I2C3SourceSys = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                        .RCC_I2C3CLKSOURCE_MSIK => I2C3CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK3;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL2 => SAI1SourcePLL2P = true,
                        .RCC_SAI1CLKSOURCE_PLL3 => SAI1SourcePLL3P = true,
                        .RCC_SAI1CLKSOURCE_PLL1 => SAI1SourcePLL1P = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                        .RCC_SAI1CLKSOURCE_HSI => SAI1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1SourcePLL2P = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLL2;
                };
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLL2 => SAI2SourcePLL2P = true,
                        .RCC_SAI2CLKSOURCE_PLL3 => SAI2SourcePLL3P = true,
                        .RCC_SAI2CLKSOURCE_PLL1 => SAI2SourcePLL1P = true,
                        .RCC_SAI2CLKSOURCE_PIN => SAI2SourceEXT = true,
                        .RCC_SAI2CLKSOURCE_HSI => SAI2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2SourcePLL2P = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLL2;
                };
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.I2C4CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_I2C4CLKSOURCE_HSI => I2C4SourceHSI = true,
                            .RCC_I2C4CLKSOURCE_MSIK => I2C4CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_I2C4CLKSOURCE_HSI
                                    \\ - RCC_I2C4CLKSOURCE_MSIK
                                , .{ "I2C4CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        I2C4SourceHSI = true;
                        break :blk .RCC_I2C4CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_PCLK1 => {},
                        .RCC_I2C4CLKSOURCE_SYSCLK => I2C4SourceSys = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4SourceHSI = true,
                        .RCC_I2C4CLKSOURCE_MSIK => I2C4CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C4CLKSOURCE_PCLK1;
            };
            const MdfClockSelectionValue: ?MdfClockSelectionList = blk: {
                const conf_item = config.MdfClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MDF1CLKSOURCE_HCLK => {},
                        .RCC_MDF1CLKSOURCE_PLL1 => MDF1CLKSOURCE_PLL1P = true,
                        .RCC_MDF1CLKSOURCE_PLL3 => MDF1CLKSOURCE_PLL3Q = true,
                        .RCC_MDF1CLKSOURCE_PIN => {},
                        .RCC_MDF1CLKSOURCE_MSIK => MDF1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_MDF1CLKSOURCE_HCLK;
            };
            const AdfClockSelectionValue: ?AdfClockSelectionList = blk: {
                const conf_item = config.AdfClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADF1CLKSOURCE_HCLK => {},
                        .RCC_ADF1CLKSOURCE_PLL1 => ADF1CLKSOURCE_PLL1P = true,
                        .RCC_ADF1CLKSOURCE_PLL3 => ADF1CLKSOURCE_PLL3Q = true,
                        .RCC_ADF1CLKSOURCE_PIN => {},
                        .RCC_ADF1CLKSOURCE_MSIK => ADF1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADF1CLKSOURCE_HCLK;
            };
            const OCTOSPIMCLockSelectionValue: ?OCTOSPIMCLockSelectionList = blk: {
                const conf_item = config.OCTOSPIMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_OSPICLKSOURCE_MSIK => OCTOSPIMSourceMSIK = true,
                        .RCC_OSPICLKSOURCE_SYSCLK => OCTOSPIMSourceSYS = true,
                        .RCC_OSPICLKSOURCE_PLL1 => OCTOSPIMSourcePLL1Q = true,
                        .RCC_OSPICLKSOURCE_PLL2 => OCTOSPIMSourcePLL2Q = true,
                    }
                }

                break :blk conf_item orelse {
                    OCTOSPIMSourceSYS = true;
                    break :blk .RCC_OSPICLKSOURCE_SYSCLK;
                };
            };
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM34CLKSOURCE_MSIK => LPTIM34CLKSOURCE_MSIK = true,
                            .RCC_LPTIM34CLKSOURCE_LSI => LPTIM3SOURCELSI = true,
                            .RCC_LPTIM34CLKSOURCE_HSI => LPTIM3SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM34CLKSOURCE_MSIK
                                    \\ - RCC_LPTIM34CLKSOURCE_LSI
                                    \\ - RCC_LPTIM34CLKSOURCE_HSI
                                , .{ "LPTIM3CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        LPTIM34CLKSOURCE_MSIK = true;
                        break :blk .RCC_LPTIM34CLKSOURCE_MSIK;
                    };
                }
                const conf_item = config.LPTIM3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM34CLKSOURCE_MSIK => LPTIM34CLKSOURCE_MSIK = true,
                        .RCC_LPTIM34CLKSOURCE_LSI => LPTIM3SOURCELSI = true,
                        .RCC_LPTIM34CLKSOURCE_HSI => LPTIM3SOURCEHSI = true,
                        .RCC_LPTIM34CLKSOURCE_LSE => LPTIM3SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM34CLKSOURCE_MSIK = true;
                    break :blk .RCC_LPTIM34CLKSOURCE_MSIK;
                };
            };
            const HSI48DivToRNGValue: ?f32 = blk: {
                break :blk 2;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_HSI48 => RNGCLKSOURCE_HSI48 = true,
                        .RCC_RNGCLKSOURCE_HSI48_DIV2 => RNGCLKSOURCE_HSI48DIV2 = true,
                        .RCC_RNGCLKSOURCE_HSI => RNGCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RNGCLKSOURCE_HSI48 = true;
                    break :blk .RCC_RNGCLKSOURCE_HSI48;
                };
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.RCC_MCO1Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => {},
                            .RCC_MCO1SOURCE_HSI => {},
                            .RCC_MCO1SOURCE_MSI => {},
                            .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                            .RCC_MCO1SOURCE_PLL1CLK => MCO1SOURCE_PLLR = true,
                            .RCC_MCO1SOURCE_LSI => {},
                            .RCC_MCO1SOURCE_HSI48 => {},
                            .RCC_MCO1SOURCE_MSIK => MCO1SOURCE_MSIK = true,
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
                                    \\ - RCC_MCO1SOURCE_PLL1CLK
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_HSI48
                                    \\ - RCC_MCO1SOURCE_MSIK
                                , .{ "RCC_MCO1Source", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
                }
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_MSI => {},
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_PLL1CLK => MCO1SOURCE_PLLR = true,
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_LSI => {},
                        .RCC_MCO1SOURCE_HSI48 => {},
                        .RCC_MCO1SOURCE_MSIK => MCO1SOURCE_MSIK = true,
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
            const Cortex_DivValue: ?Cortex_DivList = blk: {
                const conf_item = config.Cortex_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .SYSTICK_CLKSOURCE_HCLK => CLKSOURCE_HCLK = true,
                        .SYSTICK_CLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_DIV8 = true,
                    }
                }

                break :blk conf_item orelse {
                    CLKSOURCE_HCLK = true;
                    break :blk .SYSTICK_CLKSOURCE_HCLK;
                };
            };
            const CortexCLockSelectionValue: ?CortexCLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.CortexCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .SYSTICK_CLKSOURCE_HCLK_1_8 => CLKSOURCE_HCLK_1_8 = true,
                            .SYSTICK_CLKSOURCE_LSI => CLKSOURCE_LSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - SYSTICK_CLKSOURCE_HCLK_1_8
                                    \\ - SYSTICK_CLKSOURCE_LSI
                                , .{ "CortexCLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        CLKSOURCE_HCLK_1_8 = true;
                        break :blk .SYSTICK_CLKSOURCE_HCLK_1_8;
                    };
                }
                const conf_item = config.CortexCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .SYSTICK_CLKSOURCE_HCLK_1_8 => CLKSOURCE_HCLK_1_8 = true,
                        .SYSTICK_CLKSOURCE_LSE => CLKSOURCE_LSE = true,
                        .SYSTICK_CLKSOURCE_LSI => CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    CLKSOURCE_HCLK_1_8 = true;
                    break :blk .SYSTICK_CLKSOURCE_HCLK_1_8;
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
            const APB3CLKDividerValue: ?APB3CLKDividerList = blk: {
                const conf_item = config.APB3CLKDivider;
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
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.SPI1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SPI1CLKSOURCE_HSI => SPI1CLKSOURCE_HSI = true,
                            .RCC_SPI1CLKSOURCE_MSIK => SPI1CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SPI1CLKSOURCE_HSI
                                    \\ - RCC_SPI1CLKSOURCE_MSIK
                                , .{ "SPI1CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SPI1CLKSOURCE_HSI = true;
                        break :blk .RCC_SPI1CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PCLK2 => {},
                        .RCC_SPI1CLKSOURCE_SYSCLK => {},
                        .RCC_SPI1CLKSOURCE_HSI => SPI1CLKSOURCE_HSI = true,
                        .RCC_SPI1CLKSOURCE_MSIK => SPI1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI1CLKSOURCE_SYSCLK;
            };
            const SPI3CLockSelectionValue: ?SPI3CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.SPI3CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SPI3CLKSOURCE_HSI => SPI3CLKSOURCE_HSI = true,
                            .RCC_SPI3CLKSOURCE_MSIK => SPI3CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SPI3CLKSOURCE_HSI
                                    \\ - RCC_SPI3CLKSOURCE_MSIK
                                , .{ "SPI3CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SPI3CLKSOURCE_HSI = true;
                        break :blk .RCC_SPI3CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.SPI3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3CLKSOURCE_PCLK3 => {},
                        .RCC_SPI3CLKSOURCE_SYSCLK => {},
                        .RCC_SPI3CLKSOURCE_HSI => SPI3CLKSOURCE_HSI = true,
                        .RCC_SPI3CLKSOURCE_MSIK => SPI3CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI3CLKSOURCE_SYSCLK;
            };
            const SPI2CLockSelectionValue: ?SPI2CLockSelectionList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const conf_item = config.SPI2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SPI2CLKSOURCE_HSI => SPI2CLKSOURCE_HSI = true,
                            .RCC_SPI2CLKSOURCE_MSIK => SPI2CLKSOURCE_MSIK = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SPI2CLKSOURCE_HSI
                                    \\ - RCC_SPI2CLKSOURCE_MSIK
                                , .{ "SPI2CLockSelection", "S_LPBAM_CONF", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SPI2CLKSOURCE_HSI = true;
                        break :blk .RCC_SPI2CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.SPI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI2CLKSOURCE_PCLK1 => {},
                        .RCC_SPI2CLKSOURCE_SYSCLK => {},
                        .RCC_SPI2CLKSOURCE_HSI => SPI2CLKSOURCE_HSI = true,
                        .RCC_SPI2CLKSOURCE_MSIK => SPI2CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI2CLKSOURCE_SYSCLK;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 4) {
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
                            4,
                            val,
                        });
                    }
                    if (val > 512) {
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
                            512,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLLFRACNValue: ?f32 = blk: {
                const config_val = config.PLLFRACN;
                PLLFRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PLL1PValue: ?f32 = blk: {
                const config_val = config.PLL1P;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1P",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1P",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL1QValue: ?f32 = blk: {
                const config_val = config.PLL1Q;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1Q",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1Q",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL1RValue: ?PLL1RList = blk: {
                const conf_item = config.PLL1R;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"2" => {},
                        .@"4" => {},
                        .@"6" => {},
                        .@"8" => {},
                        .@"10" => {},
                        .@"12" => {},
                        .@"14" => {},
                        .@"16" => {},
                        .@"18" => {},
                        .@"20" => {},
                        .@"22" => {},
                        .@"24" => {},
                        .@"26" => {},
                        .@"28" => {},
                        .@"30" => {},
                        .@"32" => {},
                        .@"34" => {},
                        .@"36" => {},
                        .@"38" => {},
                        .@"40" => {},
                        .@"42" => {},
                        .@"44" => {},
                        .@"46" => {},
                        .@"48" => {},
                        .@"50" => {},
                        .@"52" => {},
                        .@"54" => {},
                        .@"56" => {},
                        .@"58" => {},
                        .@"60" => {},
                        .@"62" => {},
                        .@"64" => {},
                        .@"66" => {},
                        .@"68" => {},
                        .@"70" => {},
                        .@"72" => {},
                        .@"74" => {},
                        .@"76" => {},
                        .@"78" => {},
                        .@"80" => {},
                        .@"82" => {},
                        .@"84" => {},
                        .@"86" => {},
                        .@"88" => {},
                        .@"90" => {},
                        .@"92" => {},
                        .@"94" => {},
                        .@"96" => {},
                        .@"98" => {},
                        .@"100" => {},
                        .@"102" => {},
                        .@"104" => {},
                        .@"106" => {},
                        .@"108" => {},
                        .@"110" => {},
                        .@"112" => {},
                        .@"114" => {},
                        .@"116" => {},
                        .@"118" => {},
                        .@"120" => {},
                        .@"122" => {},
                        .@"124" => {},
                        .@"126" => {},
                        .@"128" => {},
                    }
                }

                break :blk conf_item orelse .@"2";
            };
            const PLL2NValue: ?f32 = blk: {
                const config_val = config.PLL2N;
                if (config_val) |val| {
                    if (val < 4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2N",
                            "Else",
                            "No Extra Log",
                            4,
                            val,
                        });
                    }
                    if (val > 512) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2N",
                            "Else",
                            "No Extra Log",
                            512,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLL2FRACNValue: ?f32 = blk: {
                const config_val = config.PLL2FRACN;
                PLL2FRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PLL2PValue: ?f32 = blk: {
                const config_val = config.PLL2P;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2P",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2P",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL2QValue: ?f32 = blk: {
                const config_val = config.PLL2Q;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2Q",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2Q",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL2RValue: ?f32 = blk: {
                const config_val = config.PLL2R;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2R",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2R",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3NValue: ?f32 = blk: {
                const config_val = config.PLL3N;
                if (config_val) |val| {
                    if (val < 4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3N",
                            "Else",
                            "No Extra Log",
                            4,
                            val,
                        });
                    }
                    if (val > 512) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3N",
                            "Else",
                            "No Extra Log",
                            512,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLL3FRACNValue: ?f32 = blk: {
                const config_val = config.PLL3FRACN;
                PLL3FRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PLL3PValue: ?f32 = blk: {
                const config_val = config.PLL3P;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3P",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3P",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3QValue: ?f32 = blk: {
                const config_val = config.PLL3Q;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3Q",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3Q",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3RValue: ?f32 = blk: {
                const config_val = config.PLL3R;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3R",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3R",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
                    if (val > 31) {
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
                            31,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const LSEStateValue: ?LSEStateList = blk: {
                if (config.flags.LSEByPassRTC) {
                    const item: LSEStateList = .RCC_LSE_BYPASS_RTC_ONLY;
                    const conf_item = config.extra.LSEState;
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
                    const conf_item = config.extra.LSEState;
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
                    const conf_item = config.extra.LSEState;
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
                    const conf_item = config.extra.LSEState;
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
                const conf_item = config.extra.LSEState;
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
                if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and (((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CK48SourcePLL1Q and PLLSourceMSI) or ((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CK48SourcePLL2Q and PLL2SourceMSI))) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .PLLMODE_MSIS;
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & (((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC)))&CK48SourcePLL1Q&PLLSourceMSI)|((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC)))&CK48SourcePLL2Q&PLL2SourceMSI))", "No Extra Log", "PLLMODE_MSIS", i });
                        }
                    }
                    break :blk item;
                } else if ((((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CK48SourcePLL1Q and PLLSourceMSI) or ((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CK48SourcePLL2Q and PLL2SourceMSI))) {
                    MSIAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .PLLMODE_MSIS;
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
                            , .{ "MSIAutoCalibration", "(((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC)))&CK48SourcePLL1Q&PLLSourceMSI)|((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC)))&CK48SourcePLL2Q&PLL2SourceMSI))", "No Extra Log", "PLLMODE_MSIS", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and ((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CLK48CLKSOURCE_MSIK)) {
                    MSIKAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .PLLMODE_MSIK;
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & ((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC))) & CLK48CLKSOURCE_MSIK)", "No Extra Log", "PLLMODE_MSIK", i });
                        }
                    }
                    break :blk item;
                } else if (((config.flags.USB_OTG_FSUsed_ForRCC or (SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and CLK48CLKSOURCE_MSIK)) {
                    MSIKAutoCalibrationON = true;
                    const item: MSIAutoCalibrationList = .PLLMODE_MSIK;
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
                            , .{ "MSIAutoCalibration", "((USB_OTG_FSUsed_ForRCC |(SDMMC1SourceIsClock48 & (SDMMC1Used_ForRCC | SDMMC2Used_ForRCC))) & CLK48CLKSOURCE_MSIK)", "No Extra Log", "PLLMODE_MSIK", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.MSIAutoCalibration;
                if (conf_item) |item| {
                    switch (item) {
                        .DISABLED => {},
                        .PLLMODE_MSIK => MSIKAutoCalibrationON = true,
                        .PLLMODE_MSIS => MSIAutoCalibrationON = true,
                    }
                }

                break :blk conf_item orelse .DISABLED;
            };
            const MSIPLLFASTValue: ?MSIPLLFASTList = blk: {
                if (MSIAutoCalibrationON or MSIKAutoCalibrationON) {
                    const conf_item = config.extra.MSIPLLFAST;
                    if (conf_item) |item| {
                        switch (item) {
                            .true => {},
                            .false => {},
                        }
                    }

                    break :blk conf_item orelse .false;
                }
                const item: MSIPLLFASTList = .false;
                const conf_item = config.extra.MSIPLLFAST;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "MSIPLLFAST", "Else", "No Extra Log", "false", i });
                    }
                }
                break :blk item;
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
            var ReloadValueValue: ?f32 = if (config.extra.ReloadValue) |i| @as(f32, @floatFromInt(i)) else 0;
            var FsyncValue: ?f32 = if (config.extra.Fsync) |i| i else 1;
            var ErrorLimitValueValue: ?f32 = if (config.extra.ErrorLimitValue) |i| @as(f32, @floatFromInt(i)) else 34;
            var HSI48CalibrationValueValue: ?f32 = if (config.extra.HSI48CalibrationValue) |i| @as(f32, @floatFromInt(i)) else 32;
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
            const MSIKUsedValue: ?f32 = blk: {
                if (I2C1CLKSOURCE_MSIK and config.flags.I2C1Used_ForRCC or I2C4CLKSOURCE_MSIK and config.flags.I2C4Used_ForRCC or I2C2CLKSOURCE_MSIK and config.flags.I2C2Used_ForRCC or I2C3CLKSOURCE_MSIK and config.flags.I2C3Used_ForRCC or MDF1CLKSOURCE_MSIK and config.flags.MDF1_Used or ADF1CLKSOURCE_MSIK and config.flags.ADF1_Used or ADCSourceMSIK and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or check_MCU("DAC1") or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC4 and config.flags.ADCUsed_ForRCC)) or LPTIM1CLKSOURCE_MSIK and config.flags.LPTIM1Used_ForRCC or LPTIM34CLKSOURCE_MSIK and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC) or LPUART1SourceMSIK and config.flags.LPUARTUsed_ForRCC or SPI1CLKSOURCE_MSIK and config.flags.SPI1Used_ForRCC or SPI2CLKSOURCE_MSIK and config.flags.SPI2Used_ForRCC or SPI3CLKSOURCE_MSIK and config.flags.SPI3Used_ForRCC or (CLK48CLKSOURCE_MSIK and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (OCTOSPIMSourceMSIK and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (CLK48CLKSOURCE_MSIK and config.flags.USB_OTG_FSUsed_ForRCC) or (MCO1SOURCE_MSIK and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if (MDF1CLKSOURCE_PLL1P and config.flags.MDF1_Used or ADF1CLKSOURCE_PLL1P and config.flags.ADF1_Used or (SDMMC1SourceIsPllP and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (SAI2SourcePLL1P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)) or (SAI1SourcePLL1P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1QUsedValue: ?f32 = blk: {
                if (((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) and OCTOSPIMSourcePLL1Q) or FDCANSourcePLL1Q and config.flags.FDCAN1Used_ForRCC or (CK48SourcePLL1Q and config.flags.USB_OTG_FSUsed_ForRCC) or (CK48SourcePLL1Q and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1RUsedValue: ?f32 = blk: {
                if (((SysSourcePLL) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1CLK, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if ((FDCANSourcePLL2P and config.flags.FDCAN1Used_ForRCC) or ((SAI1SourcePLL2P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (SAI2SourcePLL2P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2QUsedValue: ?f32 = blk: {
                if ((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) and OCTOSPIMSourcePLL2Q or (CK48SourcePLL2Q and config.flags.USB_OTG_FSUsed_ForRCC) or (CK48SourcePLL2Q and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2RUsedValue: ?f32 = blk: {
                if ((ADCSourcePLL2R and check_MCU("DAC1")) or (ADCSourcePLL2R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC4 and config.flags.ADCUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if (((SAI1SourcePLL3P and (config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) or (SAI2SourcePLL3P and (config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if ((MDF1CLKSOURCE_PLL3Q and config.flags.MDF1_Used) or (ADF1CLKSOURCE_PLL3Q and config.flags.ADF1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSISUsedValue: ?f32 = blk: {
                if (WakeUpClockMSI and check_MCU("S_LPBAM_CONF")) {
                    break :blk 1;
                } else if (!check_MCU("S_LPBAM_CONF") and ((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or PLLSourceMSI and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or (PLL2SourceMSI and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) or (PLL3SourceMSI and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIUsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(MSIKUsedValue), MSIKUsedValue, 1, .@"=") or check_ref(@TypeOf(MSISUsedValue), MSISUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if (CLKSOURCE_LSE or DAC1CLKSOURCE_LSE and check_MCU("DAC1") or ((MSIAutoCalibrationON or MSIKAutoCalibrationON) and check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=") and (config.flags.LSEByPass or config.flags.LSEByPassRTC or config.flags.LSEOscillator or config.flags.LSEOscillatorRTC)) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (USART2SourceLSE and config.flags.USART2Used_ForRCC) or (USART3SourceLSE and config.flags.USART3Used_ForRCC) or (UART4SourceLSE and config.flags.UART4Used_ForRCC) or (UART5SourceLSE and config.flags.UART5Used_ForRCC) or (LPUART1SourceLSE and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCELSE and config.flags.LPTIM2Used_ForRCC) or (LPTIM3SOURCELSE and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC)) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig)) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
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
            const PLL1MBOOSTValue: ?PLL1MBOOSTList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    if (config.extra.PLL1MBOOST) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "PLL1MBOOST", "S_LPBAM_CONF", "PLL used" });
                    }
                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const conf_item = config.extra.PLL1MBOOST;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_PLLMBOOST_DIV1 => {},
                            .RCC_PLLMBOOST_DIV2 => {},
                            .RCC_PLLMBOOST_DIV4 => {},
                            .RCC_PLLMBOOST_DIV6 => {},
                            .RCC_PLLMBOOST_DIV8 => {},
                            .RCC_PLLMBOOST_DIV10 => {},
                            .RCC_PLLMBOOST_DIV12 => {},
                            .RCC_PLLMBOOST_DIV14 => {},
                            .RCC_PLLMBOOST_DIV16 => {},
                        }
                    }

                    break :blk conf_item orelse .RCC_PLLMBOOST_DIV1;
                }
                if (config.extra.PLL1MBOOST) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "PLL1MBOOST", "Else", "No Extra Log" });
                }
                break :blk null;
            };
            const MSIKERONValue: ?MSIKERONList = blk: {
                if (config.flags.LPTIM1_Used and LPTIM1CLKSOURCE_MSIK or (config.flags.LPTIM3_Used or config.flags.LPTIM4_Used) and LPTIM34CLKSOURCE_MSIK) {
                    const item: MSIKERONList = .true;
                    const conf_item = config.extra.MSIKERON;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "MSIKERON", "LPTIM1_Used & LPTIM1CLKSOURCE_MSIK | (LPTIM3_Used | LPTIM4_Used) & LPTIM34CLKSOURCE_MSIK", "No Extra Log", "true", i });
                        }
                    }
                    break :blk item;
                }
                if (config.extra.MSIKERON) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "MSIKERON", "Else", "No Extra Log" });
                }
                break :blk null;
            };
            const HSIKERONValue: ?HSIKERONList = blk: {
                if (config.flags.LPTIM1_Used and LPTIM1SOURCEHSI or config.flags.LPTIM2_Used and LPTIM2SOURCEHSI or (config.flags.LPTIM3_Used or config.flags.LPTIM4_Used) and LPTIM3SOURCEHSI) {
                    hsikeron_ENABLED = true;
                    const item: HSIKERONList = .true;
                    const conf_item = config.extra.HSIKERON;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "HSIKERON", "LPTIM1_Used & LPTIM1SOURCEHSI | LPTIM2_Used & LPTIM2SOURCEHSI | (LPTIM3_Used | LPTIM4_Used) & LPTIM3SOURCEHSI", "No Extra Log", "true", i });
                        }
                    }
                    break :blk item;
                }
                if (config.extra.HSIKERON) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "HSIKERON", "Else", "No Extra Log" });
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
            const RNGEnableLPBAMValue: ?RNGEnableLPBAMList = blk: {
                if (config.flags.RNGUsed_ForRCC and !check_MCU("S_LPBAM_CONF")) {
                    const item: RNGEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: RNGEnableLPBAMList = .false;
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
            const SDMMCEnableLPBAMValue: ?SDMMCEnableLPBAMList = blk: {
                if ((config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) and !check_MCU("S_LPBAM_CONF")) {
                    const item: SDMMCEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: SDMMCEnableLPBAMList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC and !check_MCU("S_LPBAM_CONF")) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const EnableSAESValue: ?EnableSAESList = blk: {
                if (config.flags.SAES_Used) {
                    const item: EnableSAESList = .true;
                    break :blk item;
                }
                const item: EnableSAESList = .false;
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
            const notInLPBAMValue: ?notInLPBAMList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    const item: notInLPBAMList = .false;
                    break :blk item;
                }
                const item: notInLPBAMList = .true;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const EnableHSELCDDevisorValue: ?EnableHSELCDDevisorList = blk: {
                if (config.flags.LCDUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
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
            const DACEnableValue: ?DACEnableList = blk: {
                if (check_MCU("DAC1")) {
                    const item: DACEnableList = .true;
                    break :blk item;
                }
                const item: DACEnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC4 and config.flags.ADCUsed_ForRCC)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
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
                if ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) {
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
            const MDF1EnableValue: ?MDF1EnableList = blk: {
                if (config.flags.MDF1_Used) {
                    const item: MDF1EnableList = .true;
                    break :blk item;
                }
                const item: MDF1EnableList = .false;
                break :blk item;
            };
            const ADF1EnableValue: ?ADF1EnableList = blk: {
                if (config.flags.ADF1_Used) {
                    const item: ADF1EnableList = .true;
                    break :blk item;
                }
                const item: ADF1EnableList = .false;
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
                if ((config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC)) {
                    const item: LPTIM3EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM3EnableList = .false;
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
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.SPI1Used_ForRCC) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3Used_ForRCC) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
                break :blk item;
            };
            const SPI2EnableValue: ?SPI2EnableList = blk: {
                if (config.flags.SPI2Used_ForRCC) {
                    const item: SPI2EnableList = .true;
                    break :blk item;
                }
                const item: SPI2EnableList = .false;
                break :blk item;
            };
            const SAI1EnableLPBAMValue: ?SAI1EnableLPBAMList = blk: {
                if ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC) and !check_MCU("S_LPBAM_CONF")) {
                    const item: SAI1EnableLPBAMList = .true;
                    break :blk item;
                }
                const item: SAI1EnableLPBAMList = .false;
                break :blk item;
            };
            const SAI2EnableLPBAMValue: ?SAI2EnableLPBAMList = blk: {
                if ((config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC) and !check_MCU("S_LPBAM_CONF")) {
                    const item: SAI2EnableLPBAMList = .true;
                    break :blk item;
                }
                const item: SAI2EnableLPBAMList = .false;
                break :blk item;
            };
            const MDF1EnableLPBAMValue: ?MDF1EnableLPBAMList = blk: {
                if (config.flags.MDF1_Used and !check_MCU("S_LPBAM_CONF")) {
                    const item: MDF1EnableLPBAMList = .true;
                    break :blk item;
                }
                const item: MDF1EnableLPBAMList = .false;
                break :blk item;
            };
            const ADF1EnableLPBAMValue: ?ADF1EnableLPBAMList = blk: {
                if (config.flags.ADF1_Used and !check_MCU("S_LPBAM_CONF")) {
                    const item: ADF1EnableLPBAMList = .true;
                    break :blk item;
                }
                const item: ADF1EnableLPBAMList = .false;
                break :blk item;
            };
            const FDCANEnableLPBAMValue: ?FDCANEnableLPBAMList = blk: {
                if (config.flags.FDCAN1Used_ForRCC and !check_MCU("S_LPBAM_CONF")) {
                    const item: FDCANEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: FDCANEnableLPBAMList = .false;
                break :blk item;
            };
            const OCTOSPIMEnableLPBAMValue: ?OCTOSPIMEnableLPBAMList = blk: {
                if ((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) and !check_MCU("S_LPBAM_CONF")) {
                    const item: OCTOSPIMEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: OCTOSPIMEnableLPBAMList = .false;
                break :blk item;
            };
            const ADCEnableLPBAMValue: ?ADCEnableLPBAMList = blk: {
                if (((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC4 and config.flags.ADCUsed_ForRCC)) and !check_MCU("S_LPBAM_CONF")) {
                    const item: ADCEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: ADCEnableLPBAMList = .false;
                break :blk item;
            };
            const DACEnableLPBAMValue: ?DACEnableLPBAMList = blk: {
                if (check_MCU("DAC1") and !check_MCU("S_LPBAM_CONF")) {
                    const item: DACEnableLPBAMList = .true;
                    break :blk item;
                }
                const item: DACEnableLPBAMList = .false;
                break :blk item;
            };
            const FullHSI48UsedValue: ?f32 = blk: {
                if (RNGCLKSOURCE_HSI48 and config.flags.RNGUsed_ForRCC or (CK48SourceHSI48 and SDMMC1SourceIsClock48 and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or config.flags.CRSActivatedSourceGPIO or config.flags.CRSActivatedSourceLSE or config.flags.CRSActivatedSourceUSB or (CK48SourceHSI48 and config.flags.USB_OTG_FSUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI48, .@"=")) and ((((check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig))))) {
                    break :blk 1;
                }
                break :blk 0;
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
            const EnbaleCSSValue: ?EnbaleCSSList = blk: {
                if (((PLLSourceHSE and SysSourcePLL) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"="))) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const conf_item = config.extra.EnbaleCSS;
                    if (conf_item) |item| {
                        switch (item) {
                            .true => CSSEnabled = true,
                            .false => {},
                        }
                    }

                    break :blk conf_item orelse .false;
                }
                const item: EnbaleCSSList = .false;
                const conf_item = config.extra.EnbaleCSS;
                if (conf_item) |i| {
                    if (item != i) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed List Value: {s} found {any}
                            \\note: the current condition limits the choice to only one list item,
                            \\select the expected option or leave the value as null.
                            \\
                        , .{ "EnbaleCSS", "Else", "No Extra Log", "false", i });
                    }
                }
                break :blk item;
            };
            if (!check_MCU("S_LPBAM_CONF")) {
                const HSIRC_clk_value = HSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIRC",
                    "!S_LPBAM_CONF",
                    "No Extra Log",
                    "HSI_VALUE",
                });
                HSIRC.nodetype = .source;
                HSIRC.value = HSIRC_clk_value;
            }

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
                CRSCLKoutput.nodetype = .output;
                CRSCLKoutput.parents = &.{&HSI48RC};
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=") or
                    check_ref(@TypeOf(RNGEnableLPBAMValue), RNGEnableLPBAMValue, .true, .@"=") or
                    check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                    check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                    check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"="))
                {
                    const HSI48RC_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "HSI48RC",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "HSI48_VALUE",
                    });
                    HSI48RC.nodetype = .source;
                    HSI48RC.value = HSI48RC_clk_value;
                }
            }
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableLPBAMValue), RNGEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"="))
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
            if (check_MCU("SAES_Exist")) {
                if (check_ref(@TypeOf(EnableSAESValue), EnableSAESValue, .true, .@"=")) {
                    const SHSIRC_clk_value = SHSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SHSIRC",
                        "SAES_Exist",
                        "No Extra Log",
                        "SHSI_VALUE",
                    });
                    SHSIRC.nodetype = .source;
                    SHSIRC.value = SHSIRC_clk_value;
                }
            }
            if (check_MCU("SAES_Exist")) {
                if (check_ref(@TypeOf(EnableSAESValue), EnableSAESValue, .true, .@"=")) {
                    const SHSIDiv_clk_value = SHSIDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SHSIDiv",
                        "SAES_Exist",
                        "No Extra Log",
                        "SHSIDiv",
                    });
                    SHSIDiv.nodetype = .div;
                    SHSIDiv.value = SHSIDiv_clk_value;
                    SHSIDiv.parents = &.{&SHSIRC};
                }
            }
            if (check_MCU("SAES_Exist")) {
                if (check_ref(@TypeOf(EnableSAESValue), EnableSAESValue, .true, .@"=")) {
                    const SAESMult_clk_value = SAESSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SAESMult",
                        "SAES_Exist",
                        "No Extra Log",
                        "SAESSource",
                    });
                    const SAESMultparents = [_]*const ClockNode{
                        &SHSIRC,
                        &SHSIDiv,
                    };
                    SAESMult.nodetype = .multi;
                    SAESMult.parents = &.{SAESMultparents[SAESMult_clk_value.get()]};
                }
            }
            if (check_MCU("SAES_Exist")) {
                if (check_ref(@TypeOf(EnableSAESValue), EnableSAESValue, .true, .@"=")) {
                    SAESoutput.nodetype = .output;
                    SAESoutput.parents = &.{&SAESMult};
                }
            }

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
                if ((config.flags.HSEByPass or config.flags.HSEDIGByPass) and scale4) {
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
                                "(HSEByPass  | HSEDIGByPass) & scale4",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 2.4e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(HSEByPass  | HSEDIGByPass) & scale4",
                                "HSE in bypass Mode",
                                2.4e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 16000000;

                    break :blk null;
                } else if (config.flags.HSEByPass or config.flags.HSEDIGByPass) {
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
                                "HSEByPass  | HSEDIGByPass",
                                "HSE in bypass Mode",
                                0e0,
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
                                "HSEByPass  | HSEDIGByPass",
                                "HSE in bypass Mode",
                                5e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 16000000;

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
                    if (val > 5e7) {
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
                            5e7,
                            val,
                        });
                    }
                }
                HSEOSC.value = config_val orelse 16000000;

                break :blk null;
            };
            if (!check_MCU("S_LPBAM_CONF")) {
                const HSEOSC_clk_value = HSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEOSC",
                    "!S_LPBAM_CONF",
                    "No Extra Log",
                    "HSE_VALUE",
                });
                HSEOSC.nodetype = .source;
                HSEOSC.value = HSEOSC_clk_value;
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
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                    const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSIRC",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "LSI_VALUE",
                    });
                    LSIRC.nodetype = .source;
                    LSIRC.value = LSIRC_clk_value;
                }
            }
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

            //POST CLOCK REF LSE_VALUE VALUE
            _ = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEOscillatorRTC)) {
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
                                "(LSEOscillator | LSEOscillatorRTC)",
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
                    if (val < 5e3) {
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
                            5e3,
                            val,
                        });
                    }
                    if (val > 4e4) {
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
                            4e4,
                            val,
                        });
                    }
                }
                LSEOSC.value = config_val orelse 32768;

                break :blk null;
            };
            if (!check_MCU("S_LPBAM_CONF")) {
                const LSEOSC_clk_value = LSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSEOSC",
                    "!S_LPBAM_CONF",
                    "No Extra Log",
                    "LSE_VALUE",
                });
                LSEOSC.nodetype = .source;
                LSEOSC.value = LSEOSC_clk_value;
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
            if (!check_MCU("S_LPBAM_CONF")) {
                const MSIRC_clk_value = MSIClockRangeValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MSIRC",
                    "!S_LPBAM_CONF",
                    "No Extra Log",
                    "MSIClockRange",
                });
                MSIRC.nodetype = .source;
                MSIRC.value = MSIRC_clk_value.get();
            }

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

            const MSIKRC_clk_value = MSIKClockRangeValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSIKRC",
                "Else",
                "No Extra Log",
                "MSIKClockRange",
            });
            MSIKRC.nodetype = .source;
            MSIKRC.value = MSIKRC_clk_value.get();
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
            if (check_MCU("S_LPBAM_CONF")) {
                const RCC_Stop_WakeUpClock_clk_value = RCC_Stop_WakeUpClockValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RCC_Stop_WakeUpClock",
                    "S_LPBAM_CONF",
                    "No Extra Log",
                    "RCC_Stop_WakeUpClock",
                });
                const RCC_Stop_WakeUpClockparents = [_]*const ClockNode{
                    &MSIRC,
                    &HSIRC,
                };
                RCC_Stop_WakeUpClock.nodetype = .multi;
                RCC_Stop_WakeUpClock.parents = &.{RCC_Stop_WakeUpClockparents[RCC_Stop_WakeUpClock_clk_value.get()]};
            }
            if (check_MCU("S_LPBAM_CONF")) {
                WakeUpClockOutput.nodetype = .output;
                WakeUpClockOutput.parents = &.{&RCC_Stop_WakeUpClock};
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                    const SysClkSource_clk_value = SYSCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SysClkSource",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "SYSCLKSource",
                    });
                    const SysClkSourceparents = [_]*const ClockNode{
                        &MSIRC,
                        &HSIRC,
                        &HSEOSC,
                        &PLL1R,
                    };
                    SysClkSource.nodetype = .multi;
                    SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
                    &PLL1R,
                };
                SysClkSource.nodetype = .multi;
                SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                SysCLKOutput.nodetype = .output;
                SysCLKOutput.parents = &.{&SysClkSource};
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                    const PLLSource_clk_value = PLLSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLLSource",
                        "!S_LPBAM_CONF",
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
                }
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                    const PLL2Source_clk_value = PLL2SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLL2Source",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "PLL2Source",
                    });
                    const PLL2Sourceparents = [_]*const ClockNode{
                        &MSIRC,
                        &HSIRC,
                        &HSEOSC,
                    };
                    PLL2Source.nodetype = .multi;
                    PLL2Source.parents = &.{PLL2Sourceparents[PLL2Source_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL2Source_clk_value = PLL2SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2Source",
                    "Else",
                    "No Extra Log",
                    "PLL2Source",
                });
                const PLL2Sourceparents = [_]*const ClockNode{
                    &MSIRC,
                    &HSIRC,
                    &HSEOSC,
                };
                PLL2Source.nodetype = .multi;
                PLL2Source.parents = &.{PLL2Sourceparents[PLL2Source_clk_value.get()]};
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                    const PLL3Source_clk_value = PLL3SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "PLL3Source",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "PLL3Source",
                    });
                    const PLL3Sourceparents = [_]*const ClockNode{
                        &MSIRC,
                        &HSIRC,
                        &HSEOSC,
                    };
                    PLL3Source.nodetype = .multi;
                    PLL3Source.parents = &.{PLL3Sourceparents[PLL3Source_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL3Source_clk_value = PLL3SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3Source",
                    "Else",
                    "No Extra Log",
                    "PLL3Source",
                });
                const PLL3Sourceparents = [_]*const ClockNode{
                    &MSIRC,
                    &HSIRC,
                    &HSEOSC,
                };
                PLL3Source.nodetype = .multi;
                PLL3Source.parents = &.{PLL3Sourceparents[PLL3Source_clk_value.get()]};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL2M_clk_value = PLL2MValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2M",
                    "Else",
                    "No Extra Log",
                    "PLL2M",
                });
                PLL2M.nodetype = .div;
                PLL2M.value = PLL2M_clk_value;
                PLL2M.parents = &.{&PLL2Source};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL3M_clk_value = PLL3MValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3M",
                    "Else",
                    "No Extra Log",
                    "PLL3M",
                });
                PLL3M.nodetype = .div;
                PLL3M.value = PLL3M_clk_value;
                PLL3M.parents = &.{&PLL3Source};
            }
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIDIV};
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
            if (check_MCU("USART2_Exist")) {
                if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                    const USART2Mult_clk_value = USART2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "USART2Mult",
                        "USART2_Exist",
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
            }
            if (check_MCU("USART2_Exist")) {
                if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                    USART2output.nodetype = .output;
                    USART2output.parents = &.{&USART2Mult};
                }
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
                UART4output.nodetype = .output;
                UART4output.parents = &.{&UART4Mult};
            }
            if (check_MCU("UART5_Exist")) {
                if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                    const UART5Mult_clk_value = UART5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "UART5Mult",
                        "UART5_Exist",
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
            if (check_MCU("UART5_Exist")) {
                if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
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
                    &APB3Output,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                    &MSIKRC,
                };
                LPUART1Mult.nodetype = .multi;
                LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
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
                    &MSIKRC,
                    &LSIDIV,
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
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=")) {
                const DACMult_clk_value = DACCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DACMult",
                    "Else",
                    "No Extra Log",
                    "DACCLockSelection",
                });
                const DACMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &LSIDIV,
                };
                DACMult.nodetype = .multi;
                DACMult.parents = &.{DACMultparents[DACMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=")) {
                DACoutput.nodetype = .output;
                DACoutput.parents = &.{&DACMult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"="))
            {
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
                    &AHBOutput,
                    &SysCLKOutput,
                    &PLL2R,
                    &HSEOSC,
                    &HSIRC,
                    &MSIKRC,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"="))
            {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_MCU("SDMMC1_Exist") or check_MCU("SDMMC2_Exist") or check_MCU("USB_OTG_FS_Exist") or check_MCU("USB_DRD_FS_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                    check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
                {
                    const CK48Mult_clk_value = CK48CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "CK48Mult",
                        "SDMMC1_Exist | SDMMC2_Exist | USB_OTG_FS_Exist|USB_DRD_FS_Exist",
                        "No Extra Log",
                        "CK48CLockSelection",
                    });
                    const CK48Multparents = [_]*const ClockNode{
                        &PLL2Q,
                        &PLL1Q,
                        &MSIKRC,
                        &HSI48RC,
                    };
                    CK48Mult.nodetype = .multi;
                    CK48Mult.parents = &.{CK48Multparents[CK48Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SDMMC1_Exist") or check_MCU("SDMMC2_Exist") or check_MCU("USB_OTG_FS_Exist") or check_MCU("USB_DRD_FS_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                    check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
                {
                    CK48output.nodetype = .output;
                    CK48output.parents = &.{&CK48Mult};
                }
            }
            if (check_MCU("USB_OTG_FS_Exist") or check_MCU("USB_DRD_FS_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                    USBoutput.nodetype = .output;
                    USBoutput.parents = &.{&CK48Mult};
                }
            }
            if (check_MCU("SDMMC1_Exist") or check_MCU("SDMMC2_Exist")) {
                if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                    const SDMMC1Mult_clk_value = SDMMCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SDMMC1Mult",
                        "SDMMC1_Exist | SDMMC2_Exist",
                        "No Extra Log",
                        "SDMMCClockSelection",
                    });
                    const SDMMC1Multparents = [_]*const ClockNode{
                        &PLL1P,
                        &CK48Mult,
                    };
                    SDMMC1Mult.nodetype = .multi;
                    SDMMC1Mult.parents = &.{SDMMC1Multparents[SDMMC1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SDMMC1_Exist") or check_MCU("SDMMC2_Exist")) {
                if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                    SDMMCC1Output.nodetype = .output;
                    SDMMCC1Output.parents = &.{&SDMMC1Mult};
                }
            }
            if (check_MCU("FDCAN1_Exist")) {
                if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                    const FDCANMult_clk_value = FDCANClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "FDCANMult",
                        "FDCAN1_Exist",
                        "No Extra Log",
                        "FDCANClockSelection",
                    });
                    const FDCANMultparents = [_]*const ClockNode{
                        &PLL1Q,
                        &PLL2P,
                        &HSEOSC,
                    };
                    FDCANMult.nodetype = .multi;
                    FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
                }
            }
            if (check_MCU("FDCAN1_Exist")) {
                if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                    FDCANOutput.nodetype = .output;
                    FDCANOutput.parents = &.{&FDCANMult};
                }
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
                    &MSIKRC,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
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
                    &MSIKRC,
                };
                I2C2Mult.nodetype = .multi;
                I2C2Mult.parents = &.{I2C2Multparents[I2C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
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
                    &APB3Output,
                    &SysCLKOutput,
                    &HSIRC,
                    &MSIKRC,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                I2C3output.nodetype = .output;
                I2C3output.parents = &.{&I2C3Mult};
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
                    &PLL2P,
                    &PLL3P,
                    &PLL1P,
                    &SAI1_EXT,
                    &HSIRC,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_MCU("SAI2_Exist")) {
                if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                    const SAI2Mult_clk_value = SAI2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SAI2Mult",
                        "SAI2_Exist",
                        "No Extra Log",
                        "SAI2CLockSelection",
                    });
                    const SAI2Multparents = [_]*const ClockNode{
                        &PLL2P,
                        &PLL3P,
                        &PLL1P,
                        &SAI1_EXT,
                        &HSIRC,
                    };
                    SAI2Mult.nodetype = .multi;
                    SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SAI2_Exist")) {
                if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                    SAI2output.nodetype = .output;
                    SAI2output.parents = &.{&SAI2Mult};
                }
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
                    &MSIKRC,
                };
                I2C4Mult.nodetype = .multi;
                I2C4Mult.parents = &.{I2C4Multparents[I2C4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=")) {
                I2C4output.nodetype = .output;
                I2C4output.parents = &.{&I2C4Mult};
            }
            if (check_ref(@TypeOf(MDF1EnableValue), MDF1EnableValue, .true, .@"=")) {
                const MDF1Mult_clk_value = MdfClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MDF1Mult",
                    "Else",
                    "No Extra Log",
                    "MdfClockSelection",
                });
                const MDF1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &PLL1P,
                    &PLL3Q,
                    &SAI1_EXT,
                    &MSIKRC,
                };
                MDF1Mult.nodetype = .multi;
                MDF1Mult.parents = &.{MDF1Multparents[MDF1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MDF1EnableValue), MDF1EnableValue, .true, .@"=")) {
                MDF1output.nodetype = .output;
                MDF1output.parents = &.{&MDF1Mult};
            }
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=")) {
                const ADF1Mult_clk_value = AdfClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADF1Mult",
                    "Else",
                    "No Extra Log",
                    "AdfClockSelection",
                });
                const ADF1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &PLL1P,
                    &PLL3Q,
                    &SAI1_EXT,
                    &MSIKRC,
                };
                ADF1Mult.nodetype = .multi;
                ADF1Mult.parents = &.{ADF1Multparents[ADF1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=")) {
                ADF1output.nodetype = .output;
                ADF1output.parents = &.{&ADF1Mult};
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
                    &MSIKRC,
                    &SysCLKOutput,
                    &PLL1Q,
                    &PLL2Q,
                };
                OCTOSPIMMult.nodetype = .multi;
                OCTOSPIMMult.parents = &.{OCTOSPIMMultparents[OCTOSPIMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=")) {
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
                    &MSIKRC,
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM3Mult.nodetype = .multi;
                LPTIM3Mult.parents = &.{LPTIM3Multparents[LPTIM3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=")) {
                LPTIM3output.nodetype = .output;
                LPTIM3output.parents = &.{&LPTIM3Mult};
            }
            if (check_ref(@TypeOf(RNGEnableLPBAMValue), RNGEnableLPBAMValue, .true, .@"=")) {
                const HSI48DivToRNG_clk_value = HSI48DivToRNGValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSI48DivToRNG",
                    "Else",
                    "No Extra Log",
                    "HSI48DivToRNG",
                });
                HSI48DivToRNG.nodetype = .div;
                HSI48DivToRNG.value = HSI48DivToRNG_clk_value;
                HSI48DivToRNG.parents = &.{&HSI48RC};
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
                    &HSI48RC,
                    &HSI48DivToRNG,
                    &HSIRC,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&RNGMult};
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
                    &PLL1R,
                    &SysCLKOutput,
                    &MSIRC,
                    &HSI48RC,
                    &MSIKRC,
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
                LSCOOutput.nodetype = .output;
                LSCOOutput.parents = &.{&LSCOMult};
            }
            if (!check_MCU("S_LPBAM_CONF")) {
                if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                    const AHBPrescaler_clk_value = AHBCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "AHBPrescaler",
                        "!S_LPBAM_CONF",
                        "No Extra Log",
                        "AHBCLKDivider",
                    });
                    AHBPrescaler.nodetype = .div;
                    AHBPrescaler.value = AHBPrescaler_clk_value.get();
                    AHBPrescaler.parents = &.{&SysCLKOutput};
                }
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                AHBOutput.nodetype = .output;
                AHBOutput.parents = &.{&AHBPrescaler};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                HCLKOutput.nodetype = .output;
                HCLKOutput.parents = &.{&AHBOutput};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const CortexCLockSelection_clk_value = CortexCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CortexCLockSelection",
                    "Else",
                    "No Extra Log",
                    "CortexCLockSelection",
                });
                const CortexCLockSelectionparents = [_]*const ClockNode{
                    &CortexPrescaler,
                    &LSEOSC,
                    &LSIDIV,
                };
                CortexCLockSelection.nodetype = .multi;
                CortexCLockSelection.parents = &.{CortexCLockSelectionparents[CortexCLockSelection_clk_value.get()]};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                CortexSysOutput.nodetype = .output;
                CortexSysOutput.parents = &.{&CortexCLockSelection};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                FCLKCortexOutput.nodetype = .output;
                FCLKCortexOutput.parents = &.{&AHBOutput};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                APB1Output.nodetype = .output;
                APB1Output.parents = &.{&APB1Prescaler};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                TimPrescOut1.nodetype = .output;
                TimPrescOut1.parents = &.{&TimPrescalerAPB1};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                APB2Output.nodetype = .output;
                APB2Output.parents = &.{&APB2Prescaler};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const APB3Prescaler_clk_value = APB3CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "APB3Prescaler",
                    "Else",
                    "No Extra Log",
                    "APB3CLKDivider",
                });
                APB3Prescaler.nodetype = .div;
                APB3Prescaler.value = APB3Prescaler_clk_value.get();
                APB3Prescaler.parents = &.{&AHBOutput};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                APB3Output.nodetype = .output;
                APB3Output.parents = &.{&APB3Prescaler};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                TimPrescOut2.nodetype = .output;
                TimPrescOut2.parents = &.{&TimPrescalerAPB2};
            }
            if (check_MCU("UCPD1_Exist")) {
                if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                    UCPD1Output.nodetype = .output;
                    UCPD1Output.parents = &.{&HSIRC};
                }
            }
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                const SPI1Mult_clk_value = SPI1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI1Mult",
                    "Else",
                    "No Extra Log",
                    "SPI1CLockSelection",
                });
                const SPI1Multparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &MSIKRC,
                };
                SPI1Mult.nodetype = .multi;
                SPI1Mult.parents = &.{SPI1Multparents[SPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                SPI1output.nodetype = .output;
                SPI1output.parents = &.{&SPI1Mult};
            }
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                const SPI3Mult_clk_value = SPI3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI3Mult",
                    "Else",
                    "No Extra Log",
                    "SPI3CLockSelection",
                });
                const SPI3Multparents = [_]*const ClockNode{
                    &APB3Output,
                    &SysCLKOutput,
                    &HSIRC,
                    &MSIKRC,
                };
                SPI3Mult.nodetype = .multi;
                SPI3Mult.parents = &.{SPI3Multparents[SPI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                SPI3output.nodetype = .output;
                SPI3output.parents = &.{&SPI3Mult};
            }
            if (check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=")) {
                const SPI2Mult_clk_value = SPI2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI2Mult",
                    "Else",
                    "No Extra Log",
                    "SPI2CLockSelection",
                });
                const SPI2Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &MSIKRC,
                };
                SPI2Mult.nodetype = .multi;
                SPI2Mult.parents = &.{SPI2Multparents[SPI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=")) {
                SPI2output.nodetype = .output;
                SPI2output.parents = &.{&SPI2Mult};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
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
                PLLN.nodetype = .mulfrac;
                PLLN.value = PLLN_clk_value;
                PLLN.parents = &.{ &PLLM, &PLLFRACN };
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLLFRACN_clk_value = PLLFRACNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLFRACN",
                    "Else",
                    "No Extra Log",
                    "PLLFRACN",
                });
                PLLFRACN.nodetype = .source;
                PLLFRACN.value = PLLFRACN_clk_value;
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(MDF1EnableLPBAMValue), MDF1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableLPBAMValue), ADF1EnableLPBAMValue, .true, .@"="))
            {
                const PLL1P_clk_value = PLL1PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1P",
                    "Else",
                    "No Extra Log",
                    "PLL1P",
                });
                PLL1P.nodetype = .div;
                PLL1P.value = PLL1P_clk_value;
                PLL1P.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(MDF1EnableLPBAMValue), MDF1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableLPBAMValue), ADF1EnableLPBAMValue, .true, .@"="))
            {
                PLLPoutput.nodetype = .output;
                PLLPoutput.parents = &.{&PLL1P};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableLPBAMValue), FDCANEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableLPBAMValue), OCTOSPIMEnableLPBAMValue, .true, .@"="))
            {
                const PLL1Q_clk_value = PLL1QValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1Q",
                    "Else",
                    "No Extra Log",
                    "PLL1Q",
                });
                PLL1Q.nodetype = .div;
                PLL1Q.value = PLL1Q_clk_value;
                PLL1Q.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableLPBAMValue), FDCANEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableLPBAMValue), OCTOSPIMEnableLPBAMValue, .true, .@"="))
            {
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLL1Q};
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL1R_clk_value = PLL1RValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1R",
                    "Else",
                    "No Extra Log",
                    "PLL1R",
                });
                PLL1R.nodetype = .div;
                PLL1R.value = PLL1R_clk_value.get();
                PLL1R.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableLPBAMValue), FDCANEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableLPBAMValue), ADCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableLPBAMValue), DACEnableLPBAMValue, .true, .@"="))
            {
                const PLL2N_clk_value = PLL2NValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2N",
                    "Else",
                    "No Extra Log",
                    "PLL2N",
                });
                PLL2N.nodetype = .mulfrac;
                PLL2N.value = PLL2N_clk_value;
                PLL2N.parents = &.{ &PLL2M, &PLL2FRACN };
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL2FRACN_clk_value = PLL2FRACNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2FRACN",
                    "Else",
                    "No Extra Log",
                    "PLL2FRACN",
                });
                PLL2FRACN.nodetype = .source;
                PLL2FRACN.value = PLL2FRACN_clk_value;
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableLPBAMValue), FDCANEnableLPBAMValue, .true, .@"="))
            {
                const PLL2P_clk_value = PLL2PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2P",
                    "Else",
                    "No Extra Log",
                    "PLL2P",
                });
                PLL2P.nodetype = .div;
                PLL2P.value = PLL2P_clk_value;
                PLL2P.parents = &.{&PLL2N};
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableLPBAMValue), FDCANEnableLPBAMValue, .true, .@"="))
            {
                PLL2Poutput.nodetype = .output;
                PLL2Poutput.parents = &.{&PLL2P};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableLPBAMValue), OCTOSPIMEnableLPBAMValue, .true, .@"="))
            {
                const PLL2Q_clk_value = PLL2QValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2Q",
                    "Else",
                    "No Extra Log",
                    "PLL2Q",
                });
                PLL2Q.nodetype = .div;
                PLL2Q.value = PLL2Q_clk_value;
                PLL2Q.parents = &.{&PLL2N};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableLPBAMValue), SDMMCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableLPBAMValue), OCTOSPIMEnableLPBAMValue, .true, .@"="))
            {
                PLL2Qoutput.nodetype = .output;
                PLL2Qoutput.parents = &.{&PLL2Q};
            }
            if (check_ref(@TypeOf(ADCEnableLPBAMValue), ADCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableLPBAMValue), DACEnableLPBAMValue, .true, .@"="))
            {
                const PLL2R_clk_value = PLL2RValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2R",
                    "Else",
                    "No Extra Log",
                    "PLL2R",
                });
                PLL2R.nodetype = .div;
                PLL2R.value = PLL2R_clk_value;
                PLL2R.parents = &.{&PLL2N};
            }
            if (check_ref(@TypeOf(ADCEnableLPBAMValue), ADCEnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableLPBAMValue), DACEnableLPBAMValue, .true, .@"="))
            {
                PLL2Routput.nodetype = .output;
                PLL2Routput.parents = &.{&PLL2R};
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(MDF1EnableLPBAMValue), MDF1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableLPBAMValue), ADF1EnableLPBAMValue, .true, .@"="))
            {
                const PLL3N_clk_value = PLL3NValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3N",
                    "Else",
                    "No Extra Log",
                    "PLL3N",
                });
                PLL3N.nodetype = .mulfrac;
                PLL3N.value = PLL3N_clk_value;
                PLL3N.parents = &.{ &PLL3M, &PLL3FRACN };
            }
            if (check_ref(@TypeOf(notInLPBAMValue), notInLPBAMValue, .true, .@"=")) {
                const PLL3FRACN_clk_value = PLL3FRACNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3FRACN",
                    "Else",
                    "No Extra Log",
                    "PLL3FRACN",
                });
                PLL3FRACN.nodetype = .source;
                PLL3FRACN.value = PLL3FRACN_clk_value;
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"="))
            {
                const PLL3P_clk_value = PLL3PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3P",
                    "Else",
                    "No Extra Log",
                    "PLL3P",
                });
                PLL3P.nodetype = .div;
                PLL3P.value = PLL3P_clk_value;
                PLL3P.parents = &.{&PLL3N};
            }
            if (check_ref(@TypeOf(SAI1EnableLPBAMValue), SAI1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableLPBAMValue), SAI2EnableLPBAMValue, .true, .@"="))
            {
                PLL3Poutput.nodetype = .output;
                PLL3Poutput.parents = &.{&PLL3P};
            }
            if (check_ref(@TypeOf(MDF1EnableLPBAMValue), MDF1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableLPBAMValue), ADF1EnableLPBAMValue, .true, .@"="))
            {
                const PLL3Q_clk_value = PLL3QValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3Q",
                    "Else",
                    "No Extra Log",
                    "PLL3Q",
                });
                PLL3Q.nodetype = .div;
                PLL3Q.value = PLL3Q_clk_value;
                PLL3Q.parents = &.{&PLL3N};
            }
            if (check_ref(@TypeOf(MDF1EnableLPBAMValue), MDF1EnableLPBAMValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableLPBAMValue), ADF1EnableLPBAMValue, .true, .@"="))
            {
                PLL3Qoutput.nodetype = .output;
                PLL3Qoutput.parents = &.{&PLL3Q};
            }
            if (config.flags.notUsed) {
                const PLL3R_clk_value = PLL3RValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3R",
                    "Else",
                    "No Extra Log",
                    "PLL3R",
                });
                PLL3R.nodetype = .div;
                PLL3R.value = PLL3R_clk_value;
                PLL3R.parents = &.{&PLL3N};
            }
            if (config.flags.notUsed) {
                PLL3Routput.nodetype = .output;
                PLL3Routput.parents = &.{&PLL3R};
            }
            MSIS.nodetype = .output;
            MSIS.parents = &.{&MSIRC};
            PLLSRC.nodetype = .output;
            PLLSRC.parents = &.{&PLLSource};
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};
            VCOInput2.nodetype = .output;
            VCOInput2.parents = &.{&PLL2M};
            VCOInput3.nodetype = .output;
            VCOInput3.parents = &.{&PLL3M};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLL1R};
            VCOPLL2Output.nodetype = .output;
            VCOPLL2Output.parents = &.{&PLL2N};
            VCOPLL3Output.nodetype = .output;
            VCOPLL3Output.parents = &.{&PLL3N};
            LSIclk.nodetype = .output;
            LSIclk.parents = &.{&LSIDIV};

            //POST CLOCK REF WakeUpClockFreq_VALUE VALUE
            _ = blk: {
                WakeUpClockOutput.limit = .{
                    .min = null,
                    .max = 2.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                if (scale1) {
                    SysCLKOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SysCLKOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SysCLKOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    SysCLKOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                SysCLKOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                RTCOutput.limit = .{
                    .min = null,
                    .max = 1.5625e6,
                };

                break :blk null;
            };

            //POST CLOCK REF USART1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                USART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART2Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                USART2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART3Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                USART3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART4Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                UART4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART5Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                UART5output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPUART1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                LPUART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                LPTIM1output.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM2Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                LPTIM2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                ADCoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF CK48Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    CK48output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    CK48output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    CK48output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    CK48output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                CK48output.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SDMMCFreq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SDMMCC1Output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SDMMCC1Output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMCC1Output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SDMMCC1Output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SDMMCC1Output.limit = .{
                    .min = null,
                    .max = 5.5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF FDCANFreq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                FDCANOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                I2C1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C2Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                I2C2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C3Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                I2C3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SAI1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SAI1output.value = 2285714;
                break :blk null;
            };

            //POST CLOCK REF SAI2Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SAI2output.value = 2285714;
                break :blk null;
            };

            //POST CLOCK REF I2C4Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                I2C4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF MDF1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    MDF1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    MDF1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    MDF1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    MDF1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                MDF1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF ADF1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    ADF1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    ADF1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADF1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    ADF1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                ADF1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF OCTOSPIMFreq_Value VALUE
            _ = blk: {
                if (OCTOSPIMSourcePLL1Q or OCTOSPIMSourcePLL2Q) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                OCTOSPIMoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM3Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                LPTIM3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                RNGoutput.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    AHBOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    AHBOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    AHBOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    AHBOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                AHBOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF AHBFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    HCLKOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    HCLKOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    HCLKOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    HCLKOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                HCLKOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF CortexFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                CortexSysOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF FCLKCortexFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    FCLKCortexOutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FCLKCortexOutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    FCLKCortexOutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    FCLKCortexOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                FCLKCortexOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    APB1Output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    APB1Output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    APB1Output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    APB1Output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                APB1Output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF APB1TimFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    TimPrescOut1.limit = .{
                        .min = null,
                        .max = 3.2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    TimPrescOut1.limit = .{
                        .min = null,
                        .max = 2.2e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    TimPrescOut1.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale4) {
                    TimPrescOut1.limit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                TimPrescOut1.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    APB2Output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    APB2Output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    APB2Output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    APB2Output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                APB2Output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF APB3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    APB3Output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    APB3Output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    APB3Output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                } else if (scale4) {
                    APB3Output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                APB3Output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF APB2TimFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    TimPrescOut2.limit = .{
                        .min = null,
                        .max = 3.2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    TimPrescOut2.limit = .{
                        .min = null,
                        .max = 2.2e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    TimPrescOut2.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale4) {
                    TimPrescOut2.limit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                TimPrescOut2.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI1Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SPI1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI3Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SPI3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI2Freq_Value VALUE
            _ = blk: {
                if (scale4 or check_MCU("S_LPBAM_CONF")) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                SPI2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF PLLPoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLLPoutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLLQoutputFreq_Value VALUE
            _ = blk: {
                if (OCTOSPIMSourcePLL1Q and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale1 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLLQoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF PLL2PoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLL2Poutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLL2QoutputFreq_Value VALUE
            _ = blk: {
                if (OCTOSPIMSourcePLL2Q and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale1 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLL2Qoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF PLL2RoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLL2Routput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF PLL3PoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLL3Poutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLL3QoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLL3Qoutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF VCOInputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) {
                    VCOInput.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput2Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCOInput2.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput2.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput3Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCOInput3.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput3.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if ((scale1 or scale2) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 1.28e8,
                        .max = 5.44e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 1.28e8,
                        .max = 3.3e8,
                    };

                    break :blk null;
                }
                VCOOutput.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF PLLRCLKFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 1.1e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 5.5e7,
                    };

                    break :blk null;
                }
                PLLCLK.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF VCOPLL2OutputFreq_Value VALUE
            _ = blk: {
                if ((scale1 or scale2) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2Output.limit = .{
                        .min = 1.28e8,
                        .max = 5.44e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2Output.limit = .{
                        .min = 1.28e8,
                        .max = 3.3e8,
                    };

                    break :blk null;
                }
                VCOPLL2Output.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF VCOPLL3OutputFreq_Value VALUE
            _ = blk: {
                if ((scale1 or scale2) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3Output.limit = .{
                        .min = 1.28e8,
                        .max = 5.44e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3Output.limit = .{
                        .min = 1.28e8,
                        .max = 3.3e8,
                    };

                    break :blk null;
                }
                VCOPLL3Output.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF LSIDIV_VALUE VALUE
            _ = blk: {
                LSIclk.limit = .{
                    .min = 2.45e2,
                    .max = 3.26e4,
                };

                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
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
                            , .{ "FLatency", "S_LPBAM_CONF", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if ((scale4 and ((check_ref(?f32, AHBOutput.get_as_ref(), 12000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 12000000, .@"="))))) {
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
                                , .{ "FLatency", "(scale4 & ((HCLKFreq_Value < 12000000)|(HCLKFreq_Value= 12000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale4 and ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale4 & ((HCLKFreq_Value < 24000000)|(HCLKFreq_Value= 24000000 )))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if ((scale3 and ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"="))))) {
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
                                , .{ "FLatency", "(scale3 & ((HCLKFreq_Value < 24000000)|(HCLKFreq_Value= 24000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale3 and ((check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                , .{ "FLatency", "(scale3 & ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value= 48000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale3 and ((check_ref(?f32, AHBOutput.get_as_ref(), 55000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 55000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale3 & ((HCLKFreq_Value < 55000000)|(HCLKFreq_Value= 55000000)))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 30000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 30000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_0
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 30000000)|(HCLKFreq_Value= 30000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 90000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 90000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 90000000)|(HCLKFreq_Value= 90000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 110000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 110000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 110000000)|(HCLKFreq_Value= 110000000)))", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 64000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 64000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
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
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 64000000) |(HCLKFreq_Value = 64000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 96000000) |(HCLKFreq_Value = 96000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 128000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 128000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_3 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_3
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 128000000) |(HCLKFreq_Value = 128000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 160000000) |(HCLKFreq_Value = 160000000)))", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                }
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
                        , .{ "FLatency", "Else", "No Extra Log", "FLASH_LATENCY_0", i });
                    }
                }
                break :blk item;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    if (config.extra.PWR_Regulator_Voltage_Scale) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "PWR_Regulator_Voltage_Scale", "S_LPBAM_CONF", "No Extra Log" });
                    }
                    break :blk null;
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"="))) and !(check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=") or check_ref(@TypeOf(FullHSI48UsedValue), FullHSI48UsedValue, 1, .@"=") or (check_ref(@TypeOf(MSIKClockRangeValue), MSIKClockRangeValue, .RCC_MSIKRANGE_0, .@"=")) and check_ref(@TypeOf(MSIKUsedValue), MSIKUsedValue, 1, .@"=") or (check_ref(@TypeOf(MSIClockRangeValue), MSIClockRangeValue, .RCC_MSIRANGE_0, .@"=")) and check_ref(@TypeOf(MSISUsedValue), MSISUsedValue, 1, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE4 => scale4 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale4 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE4;
                    };
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE3
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "((SYSCLKFreq_VALUE <24000000) | (SYSCLKFreq_VALUE =24000000))", "Range 4 is not allowed when using PLLs, HSI48 not devided by 2 or MSKI/MSIS having 48 MHz", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale3 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE3;
                    };
                } else if ((SysSourceHSE and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 55000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 55000000, .@"="))))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE3
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(SysSourceHSE & ((SYSCLKFreq_VALUE <55000000) | (SYSCLKFreq_VALUE =55000000)))", "Range 4 is not allowed when using PLLs, HSI48 not devided by 2 or MSKI/MSIS having 48 MHz", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale3 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE3;
                    };
                } else if ((check_ref(?f32, SysCLKOutput.get_as_ref(), 55000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 55000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE3
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(SYSCLKFreq_VALUE < 55000000) | (SYSCLKFreq_VALUE = 55000000)", "Range 4 is not allowed when using PLLs, HSI48 not devided by 2 or MSKI/MSIS having 48 MHz", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale3 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE3;
                    };
                } else if ((check_ref(?f32, SysCLKOutput.get_as_ref(), 110000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 110000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(SYSCLKFreq_VALUE < 110000000) | (SYSCLKFreq_VALUE = 110000000)", "Range 4 is not allowed when using PLLs, HSI48 not devided by 2 or MSKI/MSIS having 48 MHz", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale2 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE2;
                    };
                }
                scale1 = true;
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
                        , .{ "PWR_Regulator_Voltage_Scale", "Else", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                    }
                }
                break :blk item;
            };

            //POST CLOCK REF ReloadValue VALUE
            _ = blk: {
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
                    ReloadValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                    break :blk null;
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
                    ReloadValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 1463;

                    break :blk null;
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
                    ReloadValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 47999;

                    break :blk null;
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
                ReloadValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else null;

                break :blk null;
            };

            //POST CLOCK REF Fsync VALUE
            _ = blk: {
                if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
                    if (config.extra.Fsync) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Fsync", "!CRSActivatedSourceGPIO & !CRSActivatedSourceLSE & !CRSActivatedSourceUSB", "No Extra Log" });
                    }
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceGPIO) {
                    const config_val = config.extra.Fsync;
                    if (config_val) |val| {
                        if (val < 1) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "Fsync",
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
                                "Fsync",
                                "CRSActivatedSourceGPIO",
                                "No Extra Log",
                                48000000,
                                val,
                            });
                        }
                    }
                    FsyncValue = if (config_val) |i| i else 1;

                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv1) {
                    const val: ?f32 = LSEOSC.get_as_ref();
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv2) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 2, .@"/", "Fsync", "LSE_VALUE", "2");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv4) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 4, .@"/", "Fsync", "LSE_VALUE", "4");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv8) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 8, .@"/", "Fsync", "LSE_VALUE", "8");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv16) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 16, .@"/", "Fsync", "LSE_VALUE", "16");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv32) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 32, .@"/", "Fsync", "LSE_VALUE", "32");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv64) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 64, .@"/", "Fsync", "LSE_VALUE", "64");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv128) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 128, .@"/", "Fsync", "LSE_VALUE", "128");
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv1) {
                    const val: ?f32 = @min(1000, std.math.floatMax(f32));
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv2) {
                    const val: ?f32 = 1000 / 2;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv4) {
                    const val: ?f32 = 1000 / 4;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv8) {
                    const val: ?f32 = 1000 / 8;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv16) {
                    const val: ?f32 = 1000 / 16;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv32) {
                    const val: ?f32 = 1000 / 32;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv64) {
                    const val: ?f32 = 1000 / 64;
                    FsyncValue = val;
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv128) {
                    const val: ?f32 = 1000 / 128;
                    FsyncValue = val;
                    break :blk null;
                }
                if (config.extra.Fsync) |val| {
                    if (val != 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {d} found: {d}
                            \\note: some values are fixed depending on the clock configuration
                            \\
                        , .{
                            "Fsync",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                }
                FsyncValue = 0;
                break :blk null;
            };

            //POST CLOCK REF ErrorLimitValue VALUE
            _ = blk: {
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
                ErrorLimitValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 34;

                break :blk null;
            };

            //POST CLOCK REF HSI48CalibrationValue VALUE
            _ = blk: {
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
                HSI48CalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;

                break :blk null;
            };
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    break :blk null;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLLVCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                break :blk item;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    break :blk null;
                } else if (((check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLLVCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput2.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput2.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                break :blk item;
            };
            const PLL3_VCI_RangeValue: ?PLL3_VCI_RangeList = blk: {
                if (check_MCU("S_LPBAM_CONF")) {
                    break :blk null;
                } else if (((check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLLVCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput3.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput3.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLLVCIRANGE_1;
                break :blk item;
            };

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexCLockSelection = try CortexCLockSelection.get_output();
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
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
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
            out.PLL1Q = try PLL1Q.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.MDF1output = try MDF1output.get_output();
            out.MDF1Mult = try MDF1Mult.get_output();
            out.ADF1output = try ADF1output.get_output();
            out.ADF1Mult = try ADF1Mult.get_output();
            out.PLL1P = try PLL1P.get_output();
            out.PLL1R = try PLL1R.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.PLL2Qoutput = try PLL2Qoutput.get_output();
            out.PLL2Q = try PLL2Q.get_output();
            out.PLL2Poutput = try PLL2Poutput.get_output();
            out.PLL2P = try PLL2P.get_output();
            out.PLL2Routput = try PLL2Routput.get_output();
            out.PLL2R = try PLL2R.get_output();
            out.PLL2N = try PLL2N.get_output();
            out.PLL2M = try PLL2M.get_output();
            out.PLL2Source = try PLL2Source.get_output();
            out.PLL3Poutput = try PLL3Poutput.get_output();
            out.PLL3P = try PLL3P.get_output();
            out.PLL3Qoutput = try PLL3Qoutput.get_output();
            out.PLL3Q = try PLL3Q.get_output();
            out.PLL3Routput = try PLL3Routput.get_output();
            out.PLL3R = try PLL3R.get_output();
            out.PLL3N = try PLL3N.get_output();
            out.PLL3M = try PLL3M.get_output();
            out.PLL3Source = try PLL3Source.get_output();
            out.UCPD1Output = try UCPD1Output.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.CRSCLKoutput = try CRSCLKoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.SAESoutput = try SAESoutput.get_output();
            out.SAESMult = try SAESMult.get_output();
            out.SHSIDiv = try SHSIDiv.get_output();
            out.SHSIRC = try SHSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIDIV = try LSIDIV.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.MSIKRC = try MSIKRC.get_output();
            out.SAI1_EXT = try SAI1_EXT.get_output();
            out.WakeUpClockOutput = try WakeUpClockOutput.get_output();
            out.RCC_Stop_WakeUpClock = try RCC_Stop_WakeUpClock.get_output();
            out.DACMult = try DACMult.get_output();
            out.DACoutput = try DACoutput.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.HSI48DivToRNG = try HSI48DivToRNG.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.APB3Prescaler = try APB3Prescaler.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.SPI2output = try SPI2output.get_output();
            out.SPI2Mult = try SPI2Mult.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.PLL2FRACN = try PLL2FRACN.get_output();
            out.PLL3FRACN = try PLL3FRACN.get_output();
            out.MSIS = try MSIS.get_extra_output();
            out.PLLSRC = try PLLSRC.get_extra_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOInput2 = try VCOInput2.get_extra_output();
            out.VCOInput3 = try VCOInput3.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.VCOPLL2Output = try VCOPLL2Output.get_extra_output();
            out.VCOPLL3Output = try VCOPLL3Output.get_extra_output();
            out.LSIclk = try LSIclk.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSI48_VALUE = HSI48_VALUEValue;
            ref_out.SHSI_VALUE = SHSI_VALUEValue;
            ref_out.SHSIDiv = SHSIDivValue;
            ref_out.SAESSource = SAESSourceValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSIDIV = LSIDIVValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.MSIKClockRange = MSIKClockRangeValue;
            ref_out.EXTERNALSAI1_CLOCK_VALUE = EXTERNALSAI1_CLOCK_VALUEValue;
            ref_out.RCC_Stop_WakeUpClock = RCC_Stop_WakeUpClockValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLL2Source = PLL2SourceValue;
            ref_out.PLL3Source = PLL3SourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.PLL2M = PLL2MValue;
            ref_out.PLL3M = PLL3MValue;
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
            ref_out.DACCLockSelection = DACCLockSelectionValue;
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
            ref_out.MdfClockSelection = MdfClockSelectionValue;
            ref_out.AdfClockSelection = AdfClockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.HSI48DivToRNG = HSI48DivToRNGValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.CortexCLockSelection = CortexCLockSelectionValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB3CLKDivider = APB3CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI3CLockSelection = SPI3CLockSelectionValue;
            ref_out.SPI2CLockSelection = SPI2CLockSelectionValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLFRACN = PLLFRACNValue;
            ref_out.PLL1P = PLL1PValue;
            ref_out.PLL1Q = PLL1QValue;
            ref_out.PLL1R = PLL1RValue;
            ref_out.PLL2N = PLL2NValue;
            ref_out.PLL2FRACN = PLL2FRACNValue;
            ref_out.PLL2P = PLL2PValue;
            ref_out.PLL2Q = PLL2QValue;
            ref_out.PLL2R = PLL2RValue;
            ref_out.PLL3N = PLL3NValue;
            ref_out.PLL3FRACN = PLL3FRACNValue;
            ref_out.PLL3P = PLL3PValue;
            ref_out.PLL3Q = PLL3QValue;
            ref_out.PLL3R = PLL3RValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.MSIAutoCalibration = MSIAutoCalibrationValue;
            ref_out.MSIPLLFAST = MSIPLLFASTValue;
            ref_out.Prescaler = PrescalerValue;
            ref_out.Source = SourceValue;
            ref_out.Polarity = PolarityValue;
            ref_out.ReloadValueType = ReloadValueTypeValue;
            ref_out.ReloadValue = ReloadValueValue;
            ref_out.Fsync = FsyncValue;
            ref_out.ErrorLimitValue = ErrorLimitValueValue;
            ref_out.HSI48CalibrationValue = HSI48CalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.PLL1MBOOST = PLL1MBOOSTValue;
            ref_out.PLL1_VCI_Range = PLL1_VCI_RangeValue;
            ref_out.PLL2_VCI_Range = PLL2_VCI_RangeValue;
            ref_out.PLL3_VCI_Range = PLL3_VCI_RangeValue;
            ref_out.MSIKERON = MSIKERONValue;
            ref_out.HSIKERON = HSIKERONValue;
            ref_out.notInLPBAM = notInLPBAMValue;
            ref_out.LSEState = LSEStateValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEDIGByPass = config.flags.HSEDIGByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.LSEByPassRTC = config.flags.LSEByPassRTC;
            ref_out.flags.LSEOscillatorRTC = config.flags.LSEOscillatorRTC;
            ref_out.flags.MCOConfig = config.flags.MCOConfig;
            ref_out.flags.LSCOConfig = config.flags.LSCOConfig;
            ref_out.flags.SAI1EXTCLK = config.flags.SAI1EXTCLK;
            ref_out.flags.CRSActivatedSourceGPIO = config.flags.CRSActivatedSourceGPIO;
            ref_out.flags.CRSActivatedSourceLSE = config.flags.CRSActivatedSourceLSE;
            ref_out.flags.CRSActivatedSourceUSB = config.flags.CRSActivatedSourceUSB;
            ref_out.flags.USB_OTG_FSUsed_ForRCC = config.flags.USB_OTG_FSUsed_ForRCC;
            ref_out.flags.SDMMC1Used_ForRCC = config.flags.SDMMC1Used_ForRCC;
            ref_out.flags.SDMMC2Used_ForRCC = config.flags.SDMMC2Used_ForRCC;
            ref_out.flags.RNGUsed_ForRCC = config.flags.RNGUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.LCDUsed_ForRCC = config.flags.LCDUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.USART1Used_ForRCC = config.flags.USART1Used_ForRCC;
            ref_out.flags.USART2Used_ForRCC = config.flags.USART2Used_ForRCC;
            ref_out.flags.USART3Used_ForRCC = config.flags.USART3Used_ForRCC;
            ref_out.flags.UART4Used_ForRCC = config.flags.UART4Used_ForRCC;
            ref_out.flags.UART5Used_ForRCC = config.flags.UART5Used_ForRCC;
            ref_out.flags.LPUARTUsed_ForRCC = config.flags.LPUARTUsed_ForRCC;
            ref_out.flags.LPTIM1Used_ForRCC = config.flags.LPTIM1Used_ForRCC;
            ref_out.flags.LPTIM2Used_ForRCC = config.flags.LPTIM2Used_ForRCC;
            ref_out.flags.USE_ADC1 = config.flags.USE_ADC1;
            ref_out.flags.ADC1UsedAsynchronousCLK_ForRCC = config.flags.ADC1UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC2 = config.flags.USE_ADC2;
            ref_out.flags.ADC2UsedAsynchronousCLK_ForRCC = config.flags.ADC2UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC4 = config.flags.USE_ADC4;
            ref_out.flags.ADCUsed_ForRCC = config.flags.ADCUsed_ForRCC;
            ref_out.flags.FDCAN1Used_ForRCC = config.flags.FDCAN1Used_ForRCC;
            ref_out.flags.I2C1Used_ForRCC = config.flags.I2C1Used_ForRCC;
            ref_out.flags.I2C2Used_ForRCC = config.flags.I2C2Used_ForRCC;
            ref_out.flags.I2C3Used_ForRCC = config.flags.I2C3Used_ForRCC;
            ref_out.flags.SAI1_SAIBUsed_ForRCC = config.flags.SAI1_SAIBUsed_ForRCC;
            ref_out.flags.SAI1_SAIAUsed_ForRCC = config.flags.SAI1_SAIAUsed_ForRCC;
            ref_out.flags.SAI2_SAIBUsed_ForRCC = config.flags.SAI2_SAIBUsed_ForRCC;
            ref_out.flags.SAI2_SAIAUsed_ForRCC = config.flags.SAI2_SAIAUsed_ForRCC;
            ref_out.flags.I2C4Used_ForRCC = config.flags.I2C4Used_ForRCC;
            ref_out.flags.OCTOSPI1Used_ForRCC = config.flags.OCTOSPI1Used_ForRCC;
            ref_out.flags.OCTOSPI2Used_ForRCC = config.flags.OCTOSPI2Used_ForRCC;
            ref_out.flags.LPTIM3Used_ForRCC = config.flags.LPTIM3Used_ForRCC;
            ref_out.flags.LPTIM4Used_ForRCC = config.flags.LPTIM4Used_ForRCC;
            ref_out.flags.SPI1Used_ForRCC = config.flags.SPI1Used_ForRCC;
            ref_out.flags.SPI3Used_ForRCC = config.flags.SPI3Used_ForRCC;
            ref_out.flags.SPI2Used_ForRCC = config.flags.SPI2Used_ForRCC;
            ref_out.flags.notUsed = config.flags.notUsed;
            ref_out.flags.LPTIM1_Used = config.flags.LPTIM1_Used;
            ref_out.flags.LPTIM3_Used = config.flags.LPTIM3_Used;
            ref_out.flags.LPTIM4_Used = config.flags.LPTIM4_Used;
            ref_out.flags.LPTIM2_Used = config.flags.LPTIM2_Used;
            ref_out.flags.UCPD1_Used = config.flags.UCPD1_Used;
            ref_out.flags.ADF1_Used = config.flags.ADF1_Used;
            ref_out.flags.MDF1_Used = config.flags.MDF1_Used;
            ref_out.flags.SAES_Used = config.flags.SAES_Used;
            ref_out.flags.EnableCRS = check_ref(?EnableCRSList, EnableCRSValue, .true, .@"=");
            ref_out.flags.RNGEnableLPBAM = check_ref(?RNGEnableLPBAMList, RNGEnableLPBAMValue, .true, .@"=");
            ref_out.flags.MCOEnable = check_ref(?MCOEnableList, MCOEnableValue, .true, .@"=");
            ref_out.flags.SDMMCEnableLPBAM = check_ref(?SDMMCEnableLPBAMList, SDMMCEnableLPBAMValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.EnableSAES = check_ref(?EnableSAESList, EnableSAESValue, .true, .@"=");
            ref_out.flags.LSIEnable = check_ref(?LSIEnableList, LSIEnableValue, .true, .@"=");
            ref_out.flags.EnableExtClockForSAI1 = check_ref(?EnableExtClockForSAI1List, EnableExtClockForSAI1Value, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.EnableHSELCDDevisor = check_ref(?EnableHSELCDDevisorList, EnableHSELCDDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.LCDEnable = check_ref(?LCDEnableList, LCDEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.USART1Enable = check_ref(?USART1EnableList, USART1EnableValue, .true, .@"=");
            ref_out.flags.USART2Enable = check_ref(?USART2EnableList, USART2EnableValue, .true, .@"=");
            ref_out.flags.USART3Enable = check_ref(?USART3EnableList, USART3EnableValue, .true, .@"=");
            ref_out.flags.UART4Enable = check_ref(?UART4EnableList, UART4EnableValue, .true, .@"=");
            ref_out.flags.UART5Enable = check_ref(?UART5EnableList, UART5EnableValue, .true, .@"=");
            ref_out.flags.LPUART1Enable = check_ref(?LPUART1EnableList, LPUART1EnableValue, .true, .@"=");
            ref_out.flags.LPTIM1Enable = check_ref(?LPTIM1EnableList, LPTIM1EnableValue, .true, .@"=");
            ref_out.flags.LPTIM2Enable = check_ref(?LPTIM2EnableList, LPTIM2EnableValue, .true, .@"=");
            ref_out.flags.DACEnable = check_ref(?DACEnableList, DACEnableValue, .true, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.SDMMCEnable = check_ref(?SDMMCEnableList, SDMMCEnableValue, .true, .@"=");
            ref_out.flags.FDCANEnable = check_ref(?FDCANEnableList, FDCANEnableValue, .true, .@"=");
            ref_out.flags.I2C1Enable = check_ref(?I2C1EnableList, I2C1EnableValue, .true, .@"=");
            ref_out.flags.I2C2Enable = check_ref(?I2C2EnableList, I2C2EnableValue, .true, .@"=");
            ref_out.flags.I2C3Enable = check_ref(?I2C3EnableList, I2C3EnableValue, .true, .@"=");
            ref_out.flags.SAI1Enable = check_ref(?SAI1EnableList, SAI1EnableValue, .true, .@"=");
            ref_out.flags.SAI2Enable = check_ref(?SAI2EnableList, SAI2EnableValue, .true, .@"=");
            ref_out.flags.I2C4Enable = check_ref(?I2C4EnableList, I2C4EnableValue, .true, .@"=");
            ref_out.flags.MDF1Enable = check_ref(?MDF1EnableList, MDF1EnableValue, .true, .@"=");
            ref_out.flags.ADF1Enable = check_ref(?ADF1EnableList, ADF1EnableValue, .true, .@"=");
            ref_out.flags.OCTOSPIMEnable = check_ref(?OCTOSPIMEnableList, OCTOSPIMEnableValue, .true, .@"=");
            ref_out.flags.LPTIM3Enable = check_ref(?LPTIM3EnableList, LPTIM3EnableValue, .true, .@"=");
            ref_out.flags.RNGEnable = check_ref(?RNGEnableList, RNGEnableValue, .true, .@"=");
            ref_out.flags.LSCOEnable = check_ref(?LSCOEnableList, LSCOEnableValue, .true, .@"=");
            ref_out.flags.UCPDEnable = check_ref(?UCPDEnableList, UCPDEnableValue, .true, .@"=");
            ref_out.flags.SPI1Enable = check_ref(?SPI1EnableList, SPI1EnableValue, .true, .@"=");
            ref_out.flags.SPI3Enable = check_ref(?SPI3EnableList, SPI3EnableValue, .true, .@"=");
            ref_out.flags.SPI2Enable = check_ref(?SPI2EnableList, SPI2EnableValue, .true, .@"=");
            ref_out.flags.SAI1EnableLPBAM = check_ref(?SAI1EnableLPBAMList, SAI1EnableLPBAMValue, .true, .@"=");
            ref_out.flags.SAI2EnableLPBAM = check_ref(?SAI2EnableLPBAMList, SAI2EnableLPBAMValue, .true, .@"=");
            ref_out.flags.MDF1EnableLPBAM = check_ref(?MDF1EnableLPBAMList, MDF1EnableLPBAMValue, .true, .@"=");
            ref_out.flags.ADF1EnableLPBAM = check_ref(?ADF1EnableLPBAMList, ADF1EnableLPBAMValue, .true, .@"=");
            ref_out.flags.FDCANEnableLPBAM = check_ref(?FDCANEnableLPBAMList, FDCANEnableLPBAMValue, .true, .@"=");
            ref_out.flags.OCTOSPIMEnableLPBAM = check_ref(?OCTOSPIMEnableLPBAMList, OCTOSPIMEnableLPBAMValue, .true, .@"=");
            ref_out.flags.ADCEnableLPBAM = check_ref(?ADCEnableLPBAMList, ADCEnableLPBAMValue, .true, .@"=");
            ref_out.flags.DACEnableLPBAM = check_ref(?DACEnableLPBAMList, DACEnableLPBAMValue, .true, .@"=");
            ref_out.flags.PLL1PUsed = check_ref(?f32, PLL1PUsedValue, 1, .@"=");
            ref_out.flags.PLL1QUsed = check_ref(?f32, PLL1QUsedValue, 1, .@"=");
            ref_out.flags.PLL2PUsed = check_ref(?f32, PLL2PUsedValue, 1, .@"=");
            ref_out.flags.PLL2QUsed = check_ref(?f32, PLL2QUsedValue, 1, .@"=");
            ref_out.flags.PLL2RUsed = check_ref(?f32, PLL2RUsedValue, 1, .@"=");
            ref_out.flags.PLL3PUsed = check_ref(?f32, PLL3PUsedValue, 1, .@"=");
            ref_out.flags.PLL3QUsed = check_ref(?f32, PLL3QUsedValue, 1, .@"=");
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.PLL2Used = check_ref(?f32, PLL2UsedValue, 1, .@"=");
            ref_out.flags.PLL3Used = check_ref(?f32, PLL3UsedValue, 1, .@"=");
            ref_out.flags.FullHSI48Used = check_ref(?f32, FullHSI48UsedValue, 1, .@"=");
            ref_out.flags.MSIKUsed = check_ref(?f32, MSIKUsedValue, 1, .@"=");
            ref_out.flags.MSISUsed = check_ref(?f32, MSISUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.EnableCSSLSE = check_ref(?EnableCSSLSEList, EnableCSSLSEValue, .true, .@"=");
            ref_out.flags.EnbaleCSS = check_ref(?EnbaleCSSList, EnbaleCSSValue, .true, .@"=");
            ref_out.flags.PLL1RUsed = check_ref(?f32, PLL1RUsedValue, 1, .@"=");
            ref_out.flags.MSIUsed = check_ref(?f32, MSIUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
