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
    RCC_SYSCLKSOURCE_MSIS,
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_MSIS => 0,
            .RCC_SYSCLKSOURCE_HSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
        };
    }
};
pub const SPI1CLockSelectionList = enum {
    RCC_SPI1CLKSOURCE_PCLK2,
    RCC_SPI1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PCLK2 => 0,
            .RCC_SPI1CLKSOURCE_MSIK => 1,
        };
    }
};
pub const SPI3CLockSelectionList = enum {
    RCC_SPI3CLKSOURCE_PCLK1,
    RCC_SPI3CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3CLKSOURCE_PCLK1 => 0,
            .RCC_SPI3CLKSOURCE_MSIK => 1,
        };
    }
};
pub const SPI2CLockSelectionList = enum {
    RCC_SPI2CLKSOURCE_PCLK1,
    RCC_SPI2CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI2CLKSOURCE_PCLK1 => 0,
            .RCC_SPI2CLKSOURCE_MSIK => 1,
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
    RCC_USART1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_HSI => 1,
        };
    }
};
pub const USART3CLockSelectionList = enum {
    RCC_USART3CLKSOURCE_PCLK1,
    RCC_USART3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART3CLKSOURCE_PCLK1 => 0,
            .RCC_USART3CLKSOURCE_HSI => 1,
        };
    }
};
pub const UART4CLockSelectionList = enum {
    RCC_UART4CLKSOURCE_PCLK1,
    RCC_UART4CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_PCLK1 => 0,
            .RCC_UART4CLKSOURCE_HSI => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCDACCLKSOURCE_HCLK,
    RCC_ADCDACCLKSOURCE_HSE,
    RCC_ADCDACCLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCDACCLKSOURCE_HCLK => 0,
            .RCC_ADCDACCLKSOURCE_HSE => 1,
            .RCC_ADCDACCLKSOURCE_MSIK => 2,
        };
    }
};
pub const UART5CLockSelectionList = enum {
    RCC_UART5CLKSOURCE_PCLK1,
    RCC_UART5CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART5CLKSOURCE_PCLK1 => 0,
            .RCC_UART5CLKSOURCE_HSI => 1,
        };
    }
};
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK3,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_LSE,
    RCC_LPUART1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK3 => 0,
            .RCC_LPUART1CLKSOURCE_HSI => 1,
            .RCC_LPUART1CLKSOURCE_LSE => 2,
            .RCC_LPUART1CLKSOURCE_MSIK => 3,
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
    RCC_DAC1SHCLKSOURCE_LSE,
    RCC_DAC1SHCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DAC1SHCLKSOURCE_LSE => 0,
            .RCC_DAC1SHCLKSOURCE_LSI => 1,
        };
    }
};
pub const ICLKCLockSelectionList = enum {
    RCC_ICLKCLKSOURCE_SYSCLK,
    RCC_ICLKCLKSOURCE_MSIK,
    RCC_ICLKCLKSOURCE_HSE,
    RCC_ICLKCLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICLKCLKSOURCE_SYSCLK => 0,
            .RCC_ICLKCLKSOURCE_MSIK => 1,
            .RCC_ICLKCLKSOURCE_HSE => 2,
            .RCC_ICLKCLKSOURCE_HSI48 => 3,
        };
    }
};
pub const FDCANClockSelectionList = enum {
    RCC_FDCANCLKSOURCE_SYSCLK,
    RCC_FDCANCLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_SYSCLK => 0,
            .RCC_FDCANCLKSOURCE_MSIK => 1,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_MSIK => 1,
        };
    }
};
pub const I3C1CLockSelectionList = enum {
    RCC_I3C1CLKSOURCE_PCLK1,
    RCC_I3C1CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C1CLKSOURCE_PCLK1 => 0,
            .RCC_I3C1CLKSOURCE_MSIK => 1,
        };
    }
};
pub const I3C2CLockSelectionList = enum {
    RCC_I3C2CLKSOURCE_PCLK2,
    RCC_I3C2CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C2CLKSOURCE_PCLK2 => 0,
            .RCC_I3C2CLKSOURCE_MSIK => 1,
        };
    }
};
pub const I2C2CLockSelectionList = enum {
    RCC_I2C2CLKSOURCE_PCLK1,
    RCC_I2C2CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_PCLK1 => 0,
            .RCC_I2C2CLKSOURCE_MSIK => 1,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK3,
    RCC_I2C3CLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK3 => 0,
            .RCC_I2C3CLKSOURCE_MSIK => 1,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_MSIK,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_MSIK => 0,
            .RCC_SAI1CLKSOURCE_PIN => 1,
            .RCC_SAI1CLKSOURCE_HSE => 2,
        };
    }
};
pub const AdfClockSelectionList = enum {
    RCC_ADF1CLKSOURCE_HCLK,
    RCC_ADF1CLKSOURCE_PIN,
    RCC_ADF1CLKSOURCE_MSIK,
    RCC_ADF1CLKSOURCE_SAI1K,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADF1CLKSOURCE_HCLK => 0,
            .RCC_ADF1CLKSOURCE_PIN => 1,
            .RCC_ADF1CLKSOURCE_MSIK => 2,
            .RCC_ADF1CLKSOURCE_SAI1K => 3,
        };
    }
};
pub const OCTOSPIMCLockSelectionList = enum {
    RCC_OCTOSPICLKSOURCE_SYSCLK,
    RCC_OCTOSPICLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_OCTOSPICLKSOURCE_SYSCLK => 0,
            .RCC_OCTOSPICLKSOURCE_MSIK => 1,
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
    RCC_RNGCLKSOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_HSI48 => 0,
            .RCC_RNGCLKSOURCE_MSIK => 1,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSIS,
    RCC_MCO1SOURCE_HSI48,
    RCC_MCO1SOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_SYSCLK => 4,
            .RCC_MCO1SOURCE_MSIS => 5,
            .RCC_MCO1SOURCE_HSI48 => 6,
            .RCC_MCO1SOURCE_MSIK => 7,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_LSE,
    RCC_MCO2SOURCE_LSI,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_HSI,
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_MSIS,
    RCC_MCO2SOURCE_HSI48,
    RCC_MCO2SOURCE_MSIK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_LSE => 0,
            .RCC_MCO2SOURCE_LSI => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_HSI => 3,
            .RCC_MCO2SOURCE_SYSCLK => 4,
            .RCC_MCO2SOURCE_MSIS => 5,
            .RCC_MCO2SOURCE_HSI48 => 6,
            .RCC_MCO2SOURCE_MSIK => 7,
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
    RCC_SYSTICKCLKSOURCE_HCLK_DIV8,
    RCC_SYSTICKCLKSOURCE_LSE,
    RCC_SYSTICKCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => 0,
            .RCC_SYSTICKCLKSOURCE_LSE => 1,
            .RCC_SYSTICKCLKSOURCE_LSI => 2,
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
pub const MSIKSourceList = enum {
    RCC_MSI_RC0,
    RCC_MSI_RC1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSI_RC0 => 96,
            .RCC_MSI_RC1 => 24,
        };
    }
};
pub const MSISSourceList = enum {
    RCC_MSI_RC0,
    RCC_MSI_RC1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSI_RC0 => 96,
            .RCC_MSI_RC1 => 24,
        };
    }
};
pub const MSIKDIVList = enum {
    RCC_MSI_DIV1,
    RCC_MSI_DIV2,
    RCC_MSI_DIV4,
    RCC_MSI_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSI_DIV1 => 1,
            .RCC_MSI_DIV2 => 2,
            .RCC_MSI_DIV4 => 4,
            .RCC_MSI_DIV8 => 8,
        };
    }
};
pub const MSISDIVList = enum {
    RCC_MSI_DIV1,
    RCC_MSI_DIV2,
    RCC_MSI_DIV4,
    RCC_MSI_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSI_DIV1 => 1,
            .RCC_MSI_DIV2 => 2,
            .RCC_MSI_DIV4 => 4,
            .RCC_MSI_DIV8 => 8,
        };
    }
};
pub const ADC_DIVList = enum {
    RCC_ADCDACCLK_DIV1,
    RCC_ADCDACCLK_DIV2,
    RCC_ADCDACCLK_DIV4,
    RCC_ADCDACCLK_DIV8,
    RCC_ADCDACCLK_DIV16,
    RCC_ADCDACCLK_DIV32,
    RCC_ADCDACCLK_DIV64,
    RCC_ADCDACCLK_DIV128,
    RCC_ADCDACCLK_DIV256,
    RCC_ADCDACCLK_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADCDACCLK_DIV1 => 1,
            .RCC_ADCDACCLK_DIV2 => 2,
            .RCC_ADCDACCLK_DIV4 => 4,
            .RCC_ADCDACCLK_DIV8 => 8,
            .RCC_ADCDACCLK_DIV16 => 16,
            .RCC_ADCDACCLK_DIV32 => 32,
            .RCC_ADCDACCLK_DIV64 => 64,
            .RCC_ADCDACCLK_DIV128 => 128,
            .RCC_ADCDACCLK_DIV256 => 256,
            .RCC_ADCDACCLK_DIV512 => 512,
        };
    }
};
pub const USB_DIVList = enum {
    RCC_USB1CLKSOURCE_ICLK,
    RCC_USB1CLKSOURCE_ICLK_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USB1CLKSOURCE_ICLK => 1,
            .RCC_USB1CLKSOURCE_ICLK_DIV2 => 2,
        };
    }
};
pub const RCC_MCODivList = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_4,
    RCC_MCODIV_8,
    RCC_MCODIV_16,
    RCC_MCODIV_32,
    RCC_MCODIV_64,
    RCC_MCODIV_128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_16 => 16,
            .RCC_MCODIV_32 => 32,
            .RCC_MCODIV_64 => 64,
            .RCC_MCODIV_128 => 128,
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
    @"8",
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
pub const FLatencyList = enum {
    FLASH_LATENCY_2,
    FLASH_LATENCY_1,
    FLASH_LATENCY_0,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
};
pub const EPOD_Booster_SourceList = enum {
    RCC_EPODBOOSTER_SOURCE_MSIS,
    RCC_EPODBOOSTER_SOURCE_HSI,
    RCC_EPODBOOSTER_SOURCE_HSE,
};
pub const EPOD_Booster_DividerList = enum {
    RCC_EPODBOOSTER_DIV1,
    RCC_EPODBOOSTER_DIV2,
    RCC_EPODBOOSTER_DIV4,
    RCC_EPODBOOSTER_DIV6,
    RCC_EPODBOOSTER_DIV8,
    RCC_EPODBOOSTER_DIV10,
    RCC_EPODBOOSTER_DIV12,
    RCC_EPODBOOSTER_DIV14,
    RCC_EPODBOOSTER_DIV16,
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
pub const EnableCRSList = enum {
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
pub const USBEnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
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
pub const EnableHSERTCDevisorList = enum {
    true,
    false,
};
pub const RTCEnableList = enum {
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
pub const USART3EnableList = enum {
    true,
    false,
};
pub const UART4EnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const DACEnableList = enum {
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
pub const I3C1EnableList = enum {
    true,
    false,
};
pub const I3C2EnableList = enum {
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
pub const LSCOEnableList = enum {
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
pub const CortexCLockSelectionVirtualList = enum {
    RCC_SYSTICKCLKSOURCE_HCLK_DIV8,
    RCC_SYSTICKCLKSOURCE_LSI,
    RCC_SYSTICKCLKSOURCE_LSE,
};
pub const LSCOSource1VirtualList = enum {
    RCC_LSCOSOURCE_LSI,
    RCC_LSCOSOURCE_LSE,
};
pub const DACCLockSelectionVirtualList = enum {
    RCC_DAC1SHCLKSOURCE_LSI,
    RCC_DAC1SHCLKSOURCE_LSE,
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
            MCO2Config: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            LCDEnable: bool = false,
            USE_ADC1: bool = false,
            USE_ADC2: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            USB_OTG_FS_Used: bool = false,
            USB_Used: bool = false,
            SDMMC1_Used: bool = false,
            SDMMC2_Used: bool = false,
            RTC_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM3_Used: bool = false,
            OCTOSPI1_Used: bool = false,
            ADF1_Used: bool = false,
            I2C3_Used: bool = false,
            I2C2_Used: bool = false,
            I3C2_Used: bool = false,
            I3C1_Used: bool = false,
            RNG_Used: bool = false,
            SPI1_Used: bool = false,
            SPI3_Used: bool = false,
            SPI2_Used: bool = false,
            IWDG_Used: bool = false,
            USART1_Used: bool = false,
            USART3_Used: bool = false,
            UART4_Used: bool = false,
            UART5_Used: bool = false,
            LPUART1_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM2_Used: bool = false,
            FDCAN1_Used: bool = false,
            I2C1_Used: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            EPOD_Booster_Source: ?EPOD_Booster_SourceList = null,
            EPOD_Booster_Divider: ?EPOD_Booster_DividerList = null,
            Booster_Source: ?f32 = null,
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
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSIDIV: ?LSIDIVList = null,
            LSE_VALUE: ?f32 = null,
            MSIKSource: ?MSIKSourceList = null,
            MSISSource: ?MSISSourceList = null,
            MSIKDIV: ?MSIKDIVList = null,
            MSISDIV: ?MSISDIVList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI3CLockSelection: ?SPI3CLockSelectionList = null,
            SPI2CLockSelection: ?SPI2CLockSelectionList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART3CLockSelection: ?USART3CLockSelectionList = null,
            UART4CLockSelection: ?UART4CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            ADC_DIV: ?ADC_DIVList = null,
            UART5CLockSelection: ?UART5CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            DACCLockSelection: ?DACCLockSelectionList = null,
            ICLKCLockSelection: ?ICLKCLockSelectionList = null,
            USB_DIV: ?USB_DIVList = null,
            FDCANClockSelection: ?FDCANClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I3C1CLockSelection: ?I3C1CLockSelectionList = null,
            I3C2CLockSelection: ?I3C2CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            AdfClockSelection: ?AdfClockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCO2Div: ?RCC_MCO2DivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            CortexCLockSelection: ?CortexCLockSelectionList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            APB3CLKDivider: ?APB3CLKDividerList = null,
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
            MSIKSource: f32 = 0,
            MSISSource: f32 = 0,
            MSIKDIV: f32 = 0,
            MSISDIV: f32 = 0,
            MSISOutput: f32 = 0,
            SAI1_EXT: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI3Mult: f32 = 0,
            SPI3output: f32 = 0,
            SPI2Mult: f32 = 0,
            SPI2output: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART3Mult: f32 = 0,
            USART3output: f32 = 0,
            UART4Mult: f32 = 0,
            UART4output: f32 = 0,
            ADCMult: f32 = 0,
            ADCDiv: f32 = 0,
            ADCoutput: f32 = 0,
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
            ICLKMult: f32 = 0,
            SDMMC1Output: f32 = 0,
            USBDiv: f32 = 0,
            USBoutput: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANOutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I3C1Mult: f32 = 0,
            I3C1output: f32 = 0,
            I3C2Mult: f32 = 0,
            I3C2output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            ADF1Mult: f32 = 0,
            ADF1output: f32 = 0,
            OCTOSPIMMult: f32 = 0,
            OCTOSPIMoutput: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
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
            LSIclk: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSIDIV: ?LSIDIVList = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIKSource: ?MSIKSourceList = null, //from RCC Clock Config
            MSISSource: ?MSISSourceList = null, //from RCC Clock Config
            MSIKDIV: ?MSIKDIVList = null, //from RCC Clock Config
            MSISDIV: ?MSISDIVList = null, //from RCC Clock Config
            EXTERNALSAI1_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI3CLockSelection: ?SPI3CLockSelectionList = null, //from RCC Clock Config
            SPI2CLockSelection: ?SPI2CLockSelectionList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART3CLockSelection: ?USART3CLockSelectionList = null, //from RCC Clock Config
            UART4CLockSelection: ?UART4CLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            ADC_DIV: ?ADC_DIVList = null, //from RCC Clock Config
            UART5CLockSelection: ?UART5CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            DACCLockSelection: ?DACCLockSelectionList = null, //from RCC Clock Config
            ICLKCLockSelection: ?ICLKCLockSelectionList = null, //from RCC Clock Config
            USB_DIV: ?USB_DIVList = null, //from RCC Clock Config
            FDCANClockSelection: ?FDCANClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I3C1CLockSelection: ?I3C1CLockSelectionList = null, //from RCC Clock Config
            I3C2CLockSelection: ?I3C2CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            AdfClockSelection: ?AdfClockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCO2Div: ?RCC_MCO2DivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            CortexCLockSelection: ?CortexCLockSelectionList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB3CLKDivider: ?APB3CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            EPOD_Booster_Source: ?EPOD_Booster_SourceList = null, //from RCC Advanced Config
            EPOD_Booster_Divider: ?EPOD_Booster_DividerList = null, //from RCC Advanced Config
            Booster_Source: ?f32 = null, //from RCC Advanced Config
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
            EnableCRS: ?EnableCRSList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            MCO2Enable: ?MCO2EnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            EnableExtClockForSAI1: ?EnableExtClockForSAI1List = null, //from extra RCC references
            SPI1Enable: ?SPI1EnableList = null, //from extra RCC references
            SPI3Enable: ?SPI3EnableList = null, //from extra RCC references
            SPI2Enable: ?SPI2EnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART3Enable: ?USART3EnableList = null, //from extra RCC references
            UART4Enable: ?UART4EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            DACEnable: ?DACEnableList = null, //from extra RCC references
            UART5Enable: ?UART5EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            SDMMCEnable: ?SDMMCEnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I3C1Enable: ?I3C1EnableList = null, //from extra RCC references
            I3C2Enable: ?I3C2EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            ADF1Enable: ?ADF1EnableList = null, //from extra RCC references
            OCTOSPIMEnable: ?OCTOSPIMEnableList = null, //from extra RCC references
            LPTIM3Enable: ?LPTIM3EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            LSEState: ?LSEStateList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
            CortexCLockSelectionVirtual: ?CortexCLockSelectionVirtualList = null, //from extra RCC references
            LSCOSource1Virtual: ?LSCOSource1VirtualList = null, //from extra RCC references
            DACCLockSelectionVirtual: ?DACCLockSelectionVirtualList = null, //from extra RCC references
            MSIUsed: ?f32 = null, //from extra RCC references
            MSIKUsed: ?f32 = null, //from extra RCC references
            MSISUsed: ?f32 = null, //from extra RCC references
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
            var SPI1CLKSOURCE_MSIK: bool = false;
            var SPI3CLKSOURCE_MSIK: bool = false;
            var SPI2CLKSOURCE_MSIK: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var USART1SourcePCLK2: bool = false;
            var USART1SourceHSI: bool = false;
            var USART3SourcePCLK1: bool = false;
            var USART3SourceHSI: bool = false;
            var UART4SourcePCLK1: bool = false;
            var UART4SourceHSI: bool = false;
            var ADCSourceHSE: bool = false;
            var ADCSourceMSIK: bool = false;
            var UART5SourceHSI: bool = false;
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
            var ICLKSourceMSIK: bool = false;
            var ICLKSourceHSE: bool = false;
            var ICLKSourceHSI48: bool = false;
            var FDCANClkMSIK: bool = false;
            var I2C1CLKSOURCE_MSIK: bool = false;
            var I3C1CLKSOURCE_MSIK: bool = false;
            var I3C2CLKSOURCE_MSIK: bool = false;
            var I2C2CLKSOURCE_MSIK: bool = false;
            var I2C3CLKSOURCE_MSIK: bool = false;
            var SAI1ClkMSIK: bool = false;
            var SAI1ClkHSE: bool = false;
            var ADF1CLKSOURCE_MSIK: bool = false;
            var OCTOSPIMSourceSYS: bool = false;
            var OCTOSPIMSourceMSIK: bool = false;
            var LPTIM34CLKSOURCE_MSIK: bool = false;
            var LPTIM3SOURCELSI: bool = false;
            var LPTIM3SOURCEHSI: bool = false;
            var LPTIM3SOURCELSE: bool = false;
            var RNGCLKSOURCE_HSI48: bool = false;
            var RNGCLKSOURCE_MSIK: bool = false;
            var MCO1SOURCE_MSIK: bool = false;
            var MCO2SOURCE_MSIK: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var CLKSOURCE_HCLK_1_8: bool = false;
            var CLKSOURCE_LSE: bool = false;
            var CLKSOURCE_LSI: bool = false;
            var LSI_DIV1: bool = false;
            var LSI_DIV128: bool = false;
            var MSIKRC0: bool = false;
            var MSIKRC1: bool = false;
            var MSISRC0: bool = false;
            var MSISRC1: bool = false;
            var MSIKDIV1: bool = false;
            var MSIKDIV2: bool = false;
            var MSIKDIV4: bool = false;
            var MSIKDIV8: bool = false;
            var MSISDIV1: bool = false;
            var MSISDIV2: bool = false;
            var MSISDIV4: bool = false;
            var MSISDIV8: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
            var EPOD_MSIS: bool = false;
            var EPOD_HSI: bool = false;
            var EPOD_HSE: bool = false;
            var EPOD_DIV1: bool = false;
            var EPOD_DIV2: bool = false;
            var EPOD_DIV4: bool = false;
            var EPOD_DIV6: bool = false;
            var EPOD_DIV8: bool = false;
            var EPOD_DIV10: bool = false;
            var EPOD_DIV12: bool = false;
            var EPOD_DIV14: bool = false;
            var EPOD_DIV16: bool = false;
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
            var RCC_LSECSS_ENABLED: bool = false;
            var MSISFreq_ValueLimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var SPI1Freq_ValueLimit: Limit = .{};
            var SPI3Freq_ValueLimit: Limit = .{};
            var SPI2Freq_ValueLimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var USART1Freq_ValueLimit: Limit = .{};
            var USART3Freq_ValueLimit: Limit = .{};
            var UART4Freq_ValueLimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var UART5Freq_ValueLimit: Limit = .{};
            var LPUART1Freq_ValueLimit: Limit = .{};
            var LPTIM1Freq_ValueLimit: Limit = .{};
            var LPTIM2Freq_ValueLimit: Limit = .{};
            var SDMMCFreq_ValueLimit: Limit = .{};
            var FDCANFreq_ValueLimit: Limit = .{};
            var I2C1Freq_ValueLimit: Limit = .{};
            var I3C1Freq_ValueLimit: Limit = .{};
            var I3C2Freq_ValueLimit: Limit = .{};
            var I2C2Freq_ValueLimit: Limit = .{};
            var I2C3Freq_ValueLimit: Limit = .{};
            var SAI1Freq_ValueLimit: Limit = .{};
            var ADF1Freq_ValueLimit: Limit = .{};
            var OCTOSPIMFreq_ValueLimit: Limit = .{};
            var LPTIM3Freq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var AHBFreq_ValueLimit: Limit = .{};
            var CortexFreq_ValueLimit: Limit = .{};
            var FCLKCortexFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB1TimFreq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var APB3Freq_ValueLimit: Limit = .{};
            var APB2TimFreq_ValueLimit: Limit = .{};
            var LSIDIV_VALUELimit: Limit = .{};
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                } else if ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                }
                break :blk null;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (scale1) {
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
                                "scale1",
                                "HSE in bypass Mode",
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
                                "scale1",
                                "HSE in bypass Mode",
                                5e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 16000000;
                } else if (scale2) {
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
                                "scale2",
                                "HSE in bypass Mode",
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
                                "scale2",
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
                break :blk config_val orelse 16000000;
            };
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
            const LSE_VALUEValue: ?f32 = blk: {
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
                    break :blk 3.2768e4;
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
                break :blk config_val orelse 32768;
            };
            const MSIKSourceValue: ?MSIKSourceList = blk: {
                const conf_item = config.MSIKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSI_RC0 => MSIKRC0 = true,
                        .RCC_MSI_RC1 => MSIKRC1 = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const MSISSourceValue: ?MSISSourceList = blk: {
                const conf_item = config.MSISSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSI_RC0 => MSISRC0 = true,
                        .RCC_MSI_RC1 => MSISRC1 = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const MSIKDIVValue: ?MSIKDIVList = blk: {
                const conf_item = config.MSIKDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSI_DIV1 => MSIKDIV1 = true,
                        .RCC_MSI_DIV2 => MSIKDIV2 = true,
                        .RCC_MSI_DIV4 => MSIKDIV4 = true,
                        .RCC_MSI_DIV8 => MSIKDIV8 = true,
                    }
                }

                break :blk conf_item orelse {
                    MSIKDIV1 = true;
                    break :blk .RCC_MSI_DIV1;
                };
            };
            const MSISDIVValue: ?MSISDIVList = blk: {
                const conf_item = config.MSISDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSI_DIV1 => MSISDIV1 = true,
                        .RCC_MSI_DIV2 => MSISDIV2 = true,
                        .RCC_MSI_DIV4 => MSISDIV4 = true,
                        .RCC_MSI_DIV8 => MSISDIV8 = true,
                    }
                }

                break :blk conf_item orelse {
                    MSISDIV8 = true;
                    break :blk .RCC_MSI_DIV8;
                };
            };
            const MSISFreq_ValueValue: ?f32 = blk: {
                MSISFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const EXTERNALSAI1_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 4.8e4;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_MSIS => SysSourceMSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceMSI = true;
                    break :blk .RCC_SYSCLKSOURCE_MSIS;
                };
            };
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PCLK2 => {},
                        .RCC_SPI1CLKSOURCE_MSIK => SPI1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI1CLKSOURCE_PCLK2;
            };
            const SPI1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SPI3CLockSelectionValue: ?SPI3CLockSelectionList = blk: {
                const conf_item = config.SPI3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3CLKSOURCE_PCLK1 => {},
                        .RCC_SPI3CLKSOURCE_MSIK => SPI3CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI3CLKSOURCE_PCLK1;
            };
            const SPI3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SPI2CLockSelectionValue: ?SPI2CLockSelectionList = blk: {
                const conf_item = config.SPI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI2CLKSOURCE_PCLK1 => {},
                        .RCC_SPI2CLKSOURCE_MSIK => SPI2CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI2CLKSOURCE_PCLK1;
            };
            const SPI2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
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
                RTCFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.5625e6,
                };

                break :blk null;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => USART1SourcePCLK2 = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    USART1SourcePCLK2 = true;
                    break :blk .RCC_USART1CLKSOURCE_PCLK2;
                };
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USART3CLockSelectionValue: ?USART3CLockSelectionList = blk: {
                const conf_item = config.USART3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART3CLKSOURCE_PCLK1 => USART3SourcePCLK1 = true,
                        .RCC_USART3CLKSOURCE_HSI => USART3SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    USART3SourcePCLK1 = true;
                    break :blk .RCC_USART3CLKSOURCE_PCLK1;
                };
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const UART4CLockSelectionValue: ?UART4CLockSelectionList = blk: {
                const conf_item = config.UART4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => UART4SourcePCLK1 = true,
                        .RCC_UART4CLKSOURCE_HSI => UART4SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    UART4SourcePCLK1 = true;
                    break :blk .RCC_UART4CLKSOURCE_PCLK1;
                };
            };
            const UART4Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCDACCLKSOURCE_HCLK => {},
                        .RCC_ADCDACCLKSOURCE_HSE => ADCSourceHSE = true,
                        .RCC_ADCDACCLKSOURCE_MSIK => ADCSourceMSIK = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const ADC_DIVValue: ?ADC_DIVList = blk: {
                const conf_item = config.ADC_DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCDACCLK_DIV1 => {},
                        .RCC_ADCDACCLK_DIV2 => {},
                        .RCC_ADCDACCLK_DIV4 => {},
                        .RCC_ADCDACCLK_DIV8 => {},
                        .RCC_ADCDACCLK_DIV16 => {},
                        .RCC_ADCDACCLK_DIV32 => {},
                        .RCC_ADCDACCLK_DIV64 => {},
                        .RCC_ADCDACCLK_DIV128 => {},
                        .RCC_ADCDACCLK_DIV256 => {},
                        .RCC_ADCDACCLK_DIV512 => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADCDACCLK_DIV1;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const UART5CLockSelectionValue: ?UART5CLockSelectionList = blk: {
                const conf_item = config.UART5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => {},
                        .RCC_UART5CLKSOURCE_HSI => UART5SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
            };
            const UART5Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK3 => {},
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                        .RCC_LPUART1CLKSOURCE_MSIK => LPUART1SourceMSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK3;
            };
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
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
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                LPTIM1Freq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
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
                if (scale1) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const DACCLockSelectionValue: ?DACCLockSelectionList = blk: {
                const conf_item = config.DACCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DAC1SHCLKSOURCE_LSE => DAC1CLKSOURCE_LSE = true,
                        .RCC_DAC1SHCLKSOURCE_LSI => DAC1CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const DACFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const ICLKCLockSelectionValue: ?ICLKCLockSelectionList = blk: {
                const conf_item = config.ICLKCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICLKCLKSOURCE_SYSCLK => {},
                        .RCC_ICLKCLKSOURCE_MSIK => ICLKSourceMSIK = true,
                        .RCC_ICLKCLKSOURCE_HSE => ICLKSourceHSE = true,
                        .RCC_ICLKCLKSOURCE_HSI48 => ICLKSourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICLKCLKSOURCE_SYSCLK;
            };
            const SDMMCFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                SDMMCFreq_ValueLimit = .{
                    .min = null,
                    .max = 5.5e7,
                };

                break :blk null;
            };
            const USB_DIVValue: ?USB_DIVList = blk: {
                const conf_item = config.USB_DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USB1CLKSOURCE_ICLK => {},
                        .RCC_USB1CLKSOURCE_ICLK_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_USB1CLKSOURCE_ICLK;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const FDCANClockSelectionValue: ?FDCANClockSelectionList = blk: {
                const conf_item = config.FDCANClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_SYSCLK => {},
                        .RCC_FDCANCLKSOURCE_MSIK => FDCANClkMSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_FDCANCLKSOURCE_SYSCLK;
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => {},
                        .RCC_I2C1CLKSOURCE_MSIK => I2C1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I3C1CLockSelectionValue: ?I3C1CLockSelectionList = blk: {
                const conf_item = config.I3C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I3C1CLKSOURCE_PCLK1 => {},
                        .RCC_I3C1CLKSOURCE_MSIK => I3C1CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C1CLKSOURCE_PCLK1;
            };
            const I3C1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I3C2CLockSelectionValue: ?I3C2CLockSelectionList = blk: {
                const conf_item = config.I3C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I3C2CLKSOURCE_PCLK2 => {},
                        .RCC_I3C2CLKSOURCE_MSIK => I3C2CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C2CLKSOURCE_PCLK2;
            };
            const I3C2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I2C2CLockSelectionValue: ?I2C2CLockSelectionList = blk: {
                const conf_item = config.I2C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_PCLK1 => {},
                        .RCC_I2C2CLKSOURCE_MSIK => I2C2CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C2CLKSOURCE_PCLK1;
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK3 => {},
                        .RCC_I2C3CLKSOURCE_MSIK => I2C3CLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK3;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_MSIK => SAI1ClkMSIK = true,
                        .RCC_SAI1CLKSOURCE_PIN => {},
                        .RCC_SAI1CLKSOURCE_HSE => SAI1ClkHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1ClkMSIK = true;
                    break :blk .RCC_SAI1CLKSOURCE_MSIK;
                };
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 2.285714e6;
            };
            const AdfClockSelectionValue: ?AdfClockSelectionList = blk: {
                const conf_item = config.AdfClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADF1CLKSOURCE_HCLK => {},
                        .RCC_ADF1CLKSOURCE_PIN => {},
                        .RCC_ADF1CLKSOURCE_MSIK => ADF1CLKSOURCE_MSIK = true,
                        .RCC_ADF1CLKSOURCE_SAI1K => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADF1CLKSOURCE_HCLK;
            };
            const ADF1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    ADF1Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADF1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const OCTOSPIMCLockSelectionValue: ?OCTOSPIMCLockSelectionList = blk: {
                const conf_item = config.OCTOSPIMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_OCTOSPICLKSOURCE_SYSCLK => OCTOSPIMSourceSYS = true,
                        .RCC_OCTOSPICLKSOURCE_MSIK => OCTOSPIMSourceMSIK = true,
                    }
                }

                break :blk conf_item orelse {
                    OCTOSPIMSourceSYS = true;
                    break :blk .RCC_OCTOSPICLKSOURCE_SYSCLK;
                };
            };
            const OCTOSPIMFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
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
            const LPTIM3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPTIM3Freq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM3Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_HSI48 => RNGCLKSOURCE_HSI48 = true,
                        .RCC_RNGCLKSOURCE_MSIK => RNGCLKSOURCE_MSIK = true,
                    }
                }

                break :blk conf_item orelse {
                    RNGCLKSOURCE_HSI48 = true;
                    break :blk .RCC_RNGCLKSOURCE_HSI48;
                };
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                RNGFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_LSI => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_MSIS => {},
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
                        .RCC_MCODIV_32 => {},
                        .RCC_MCODIV_64 => {},
                        .RCC_MCODIV_128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_LSE => {},
                        .RCC_MCO2SOURCE_LSI => {},
                        .RCC_MCO2SOURCE_HSE => {},
                        .RCC_MCO2SOURCE_HSI => {},
                        .RCC_MCO2SOURCE_SYSCLK => {},
                        .RCC_MCO2SOURCE_MSIS => {},
                        .RCC_MCO2SOURCE_HSI48 => {},
                        .RCC_MCO2SOURCE_MSIK => MCO2SOURCE_MSIK = true,
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
                    }
                }

                break :blk conf_item orelse .RCC_MCO2DIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                const conf_item = config.LSCOSource1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_LSI => LSCOSSourceLSI = true,
                        .RCC_LSCOSOURCE_LSE => LSCOSSourceLSE = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                AHBFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const Cortex_DivValue: ?Cortex_DivList = blk: {
                const item: Cortex_DivList = .@"8";
                break :blk item;
            };
            const CortexCLockSelectionValue: ?CortexCLockSelectionList = blk: {
                const conf_item = config.CortexCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_1_8 = true,
                        .RCC_SYSTICKCLKSOURCE_LSE => CLKSOURCE_LSE = true,
                        .RCC_SYSTICKCLKSOURCE_LSI => CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const CortexFreq_ValueValue: ?f32 = blk: {
                CortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                FCLKCortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
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
            const APB1Freq_ValueValue: ?f32 = blk: {
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
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
                APB1TimFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
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
                    .max = 9.6e7,
                };

                break :blk null;
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
            const APB3Freq_ValueValue: ?f32 = blk: {
                APB3Freq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
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
                APB2TimFreq_ValueLimit = .{
                    .min = null,
                    .max = 9.6e7,
                };

                break :blk null;
            };
            const LSIDIV_VALUEValue: ?f32 = blk: {
                LSIDIV_VALUELimit = .{
                    .min = 2.45e2,
                    .max = 3.26e4,
                };

                break :blk null;
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
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"="))))) {
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
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 32000000)|(HCLKFreq_Value= 32000000 )))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale2 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value= 48000000)))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@"="))))) {
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
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 64000000) |(HCLKFreq_Value = 64000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale1 and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 96000000) |(HCLKFreq_Value = 96000000)))", "No Extra Log", "FLASH_LATENCY_2", i });
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
            const EPOD_Booster_SourceValue: ?EPOD_Booster_SourceList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">"))) {
                    const conf_item = config.extra.EPOD_Booster_Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_EPODBOOSTER_SOURCE_MSIS => EPOD_MSIS = true,
                            .RCC_EPODBOOSTER_SOURCE_HSI => EPOD_HSI = true,
                            .RCC_EPODBOOSTER_SOURCE_HSE => EPOD_HSE = true,
                        }
                    }

                    break :blk conf_item orelse {
                        EPOD_MSIS = true;
                        break :blk .RCC_EPODBOOSTER_SOURCE_MSIS;
                    };
                }
            };
            const EPOD_Booster_DividerValue: ?EPOD_Booster_DividerList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">")) and EPOD_MSIS) {
                    EPOD_DIV1 = true;
                    const item: EPOD_Booster_DividerList = .RCC_EPODBOOSTER_DIV1;
                    const conf_item = config.extra.EPOD_Booster_Divider;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "EPOD_Booster_Divider", "(HCLKFreq_Value > 24000000) & EPOD_MSIS", "No Extra Log", "RCC_EPODBOOSTER_DIV1", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">"))) {
                    const conf_item = config.extra.EPOD_Booster_Divider;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_EPODBOOSTER_DIV1 => EPOD_DIV1 = true,
                            .RCC_EPODBOOSTER_DIV2 => EPOD_DIV2 = true,
                            .RCC_EPODBOOSTER_DIV4 => EPOD_DIV4 = true,
                            .RCC_EPODBOOSTER_DIV6 => EPOD_DIV6 = true,
                            .RCC_EPODBOOSTER_DIV8 => EPOD_DIV8 = true,
                            .RCC_EPODBOOSTER_DIV10 => EPOD_DIV10 = true,
                            .RCC_EPODBOOSTER_DIV12 => EPOD_DIV12 = true,
                            .RCC_EPODBOOSTER_DIV14 => EPOD_DIV14 = true,
                            .RCC_EPODBOOSTER_DIV16 => EPOD_DIV16 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        EPOD_DIV1 = true;
                        break :blk .RCC_EPODBOOSTER_DIV1;
                    };
                }
            };
            const Booster_SourceValue: ?f32 = blk: {
                if (EPOD_MSIS) {
                    const min: ?f32 = null;
                    const max: ?f32 = null;
                    const val: ?f32 = MSISFreq_ValueValue orelse comptime_fail_or_error(error.NullReference,
                        \\Error on {s} | expr: {s} diagnostic: {s}
                        \\Expected value from: {s}, but it is undefined
                        \\note: some configurations are only valid if another configuration is applied.
                    , .{ "Booster_Source", "EPOD_MSIS", "No Extra Log", "MSISFreq_Value" });
                    if (val) |actual| {
                        if (max) |m| {
                            if (actual > m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Overflow Value - max: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_MSIS", "No Extra Log", m, actual });
                            }
                        }
                        if (min) |m| {
                            if (actual < m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Underflow Value - min: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_MSIS", "No Extra Log", m, actual });
                            }
                        }
                    }
                    break :blk val;
                } else if (EPOD_HSE) {
                    const min: ?f32 = null;
                    const max: ?f32 = null;
                    const val: ?f32 = HSE_VALUEValue orelse comptime_fail_or_error(error.NullReference,
                        \\Error on {s} | expr: {s} diagnostic: {s}
                        \\Expected value from: {s}, but it is undefined
                        \\note: some configurations are only valid if another configuration is applied.
                    , .{ "Booster_Source", "EPOD_HSE", "No Extra Log", "HSE_VALUE" });
                    if (val) |actual| {
                        if (max) |m| {
                            if (actual > m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Overflow Value - max: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_HSE", "No Extra Log", m, actual });
                            }
                        }
                        if (min) |m| {
                            if (actual < m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Underflow Value - min: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_HSE", "No Extra Log", m, actual });
                            }
                        }
                    }
                    break :blk val;
                } else if (EPOD_HSI) {
                    const min: ?f32 = null;
                    const max: ?f32 = null;
                    const val: ?f32 = HSI_VALUEValue orelse comptime_fail_or_error(error.NullReference,
                        \\Error on {s} | expr: {s} diagnostic: {s}
                        \\Expected value from: {s}, but it is undefined
                        \\note: some configurations are only valid if another configuration is applied.
                    , .{ "Booster_Source", "EPOD_HSI", "No Extra Log", "HSI_VALUE" });
                    if (val) |actual| {
                        if (max) |m| {
                            if (actual > m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Overflow Value - max: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_HSI", "No Extra Log", m, actual });
                            }
                        }
                        if (min) |m| {
                            if (actual < m) {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Underflow Value - min: null({e}) found: {e}
                                    \\note: ranges values may change depending on the configuration
                                    \\
                                , .{ "Booster_Source", "EPOD_HSI", "No Extra Log", m, actual });
                            }
                        }
                    }
                    break :blk val;
                }
                if (config.extra.Booster_Source) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "Booster_Source", "Else", "No Extra Log" });
                }
                break :blk null;
            };
            const LSEStateValue: ?LSEStateList = blk: {
                if (config.flags.LSEByPassRTC) {
                    const item: LSEStateList = .RCC_LSE_BYPASS_RTC_ONLY;
                    break :blk item;
                } else if (config.flags.LSEOscillatorRTC) {
                    const item: LSEStateList = .RCC_LSE_ON_RTC_ONLY;
                    break :blk item;
                } else if (config.flags.LSEByPass) {
                    const item: LSEStateList = .RCC_LSE_BYPASS;
                    break :blk item;
                } else if (config.flags.LSEOscillator) {
                    const item: LSEStateList = .RCC_LSE_ON;
                    break :blk item;
                }
                const item: LSEStateList = .RCC_LSE_OFF;
                break :blk item;
            };
            const MSIAutoCalibrationValue: ?MSIAutoCalibrationList = blk: {
                if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and ((((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CK48SourcePLL1Q") and check_MCU("PLLSourceMSI")) or (((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CK48SourcePLL2Q") and check_MCU("PLL2SourceMSI")))) {
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & ((((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used)))&CK48SourcePLL1Q&PLLSourceMSI)|(((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used)))&CK48SourcePLL2Q&PLL2SourceMSI))", "No Extra Log", "PLLMODE_MSIS", i });
                        }
                    }
                    break :blk item;
                } else if (((((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CK48SourcePLL1Q") and check_MCU("PLLSourceMSI")) or (((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CK48SourcePLL2Q") and check_MCU("PLL2SourceMSI")))) {
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
                            , .{ "MSIAutoCalibration", "((((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used)))&CK48SourcePLL1Q&PLLSourceMSI)|(((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used)))&CK48SourcePLL2Q&PLL2SourceMSI))", "No Extra Log", "PLLMODE_MSIS", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(LSEStateValue), LSEStateValue, .RCC_LSE_OFF, .@"=")) and (((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CLK48CLKSOURCE_MSIK"))) {
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
                            , .{ "MSIAutoCalibration", "(LSEState=RCC_LSE_OFF) & (((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used))) & CLK48CLKSOURCE_MSIK)", "No Extra Log", "PLLMODE_MSIK", i });
                        }
                    }
                    break :blk item;
                } else if ((((config.flags.USB_OTG_FS_Used or config.flags.USB_Used) or (check_MCU("SDMMC1SourceIsClock48") and (config.flags.SDMMC1_Used or config.flags.SDMMC2_Used))) and check_MCU("CLK48CLKSOURCE_MSIK"))) {
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
                            , .{ "MSIAutoCalibration", "(((USB_OTG_FS_Used | USB_Used) |(SDMMC1SourceIsClock48 & (SDMMC1_Used | SDMMC2_Used))) & CLK48CLKSOURCE_MSIK)", "No Extra Log", "PLLMODE_MSIK", i });
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
                if (MSIAutoCalibrationON) {
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
                    break :blk if (config_val) |i| i else 1;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv1) {
                    const val: ?f32 = LSE_VALUEValue;
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv2) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 2, .@"/", "Fsync", "LSE_VALUE", "2");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv4) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 4, .@"/", "Fsync", "LSE_VALUE", "4");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv8) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 8, .@"/", "Fsync", "LSE_VALUE", "8");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv16) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 16, .@"/", "Fsync", "LSE_VALUE", "16");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv32) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 32, .@"/", "Fsync", "LSE_VALUE", "32");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv64) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 64, .@"/", "Fsync", "LSE_VALUE", "64");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceLSE and RccCrsSyncDiv128) {
                    const val: ?f32 = try math_op(@TypeOf(LSE_VALUEValue), LSE_VALUEValue, 128, .@"/", "Fsync", "LSE_VALUE", "128");
                    break :blk val;
                } else if (config.flags.CRSActivatedSourceUSB and RccCrsSyncDiv1) {
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
                break :blk 0;
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
            const CortexCLockSelectionVirtualValue: ?CortexCLockSelectionVirtualList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.CortexCLockSelectionVirtual;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_1_8 = true,
                            .RCC_SYSTICKCLKSOURCE_LSI => CLKSOURCE_LSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SYSTICKCLKSOURCE_HCLK_DIV8
                                    \\ - RCC_SYSTICKCLKSOURCE_LSI
                                , .{ "CortexCLockSelectionVirtual", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        CLKSOURCE_HCLK_1_8 = true;
                        break :blk .RCC_SYSTICKCLKSOURCE_HCLK_DIV8;
                    };
                }
                const conf_item = config.CortexCLockSelectionVirtual;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_1_8 = true,
                        .RCC_SYSTICKCLKSOURCE_LSE => CLKSOURCE_LSE = true,
                        .RCC_SYSTICKCLKSOURCE_LSI => CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    CLKSOURCE_HCLK_1_8 = true;
                    break :blk .RCC_SYSTICKCLKSOURCE_HCLK_DIV8;
                };
            };
            const DACCLockSelectionVirtualValue: ?DACCLockSelectionVirtualList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    DAC1CLKSOURCE_LSI = true;
                    const item: DACCLockSelectionVirtualList = .RCC_DAC1SHCLKSOURCE_LSI;
                    const conf_item = config.DACCLockSelectionVirtual;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "DACCLockSelectionVirtual", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", "RCC_DAC1SHCLKSOURCE_LSI", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.DACCLockSelectionVirtual;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DAC1SHCLKSOURCE_LSE => DAC1CLKSOURCE_LSE = true,
                        .RCC_DAC1SHCLKSOURCE_LSI => DAC1CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    DAC1CLKSOURCE_LSI = true;
                    break :blk .RCC_DAC1SHCLKSOURCE_LSI;
                };
            };
            const MSIKUsedValue: ?f32 = blk: {
                if ((I2C1CLKSOURCE_MSIK and config.flags.I2C1_Used) or (I2C2CLKSOURCE_MSIK and config.flags.I2C2_Used) or (I2C3CLKSOURCE_MSIK and config.flags.I2C3_Used) or (ADF1CLKSOURCE_MSIK and config.flags.ADF1_Used) or ADCSourceMSIK and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or check_MCU("DAC1") or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or LPTIM1CLKSOURCE_MSIK and config.flags.LPTIM1_Used or LPTIM34CLKSOURCE_MSIK and (config.flags.LPTIM3_Used or config.flags.LPTIM4_Used) or LPUART1SourceMSIK and config.flags.LPUART1_Used or SPI1CLKSOURCE_MSIK and config.flags.SPI1_Used or SPI2CLKSOURCE_MSIK and config.flags.SPI2_Used or SPI3CLKSOURCE_MSIK and config.flags.SPI3_Used or (ICLKSourceMSIK and (config.flags.SDMMC1_Used or config.flags.USB_Used)) or (OCTOSPIMSourceMSIK and (config.flags.OCTOSPI1_Used)) or (MCO1SOURCE_MSIK and config.flags.MCOConfig) or (MCO2SOURCE_MSIK and config.flags.MCO2Config) or ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC) and SAI1ClkMSIK) or (I3C1CLKSOURCE_MSIK and config.flags.I3C1_Used) or (I3C2CLKSOURCE_MSIK and config.flags.I3C2_Used) or (OCTOSPIMSourceMSIK and config.flags.OCTOSPI1_Used) or (config.flags.FDCAN1_Used and FDCANClkMSIK)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSISUsedValue: ?f32 = blk: {
                if (SysSourceMSI or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_MSIS, .@"=")) and config.flags.MCOConfig) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_MSIS, .@"=")) and config.flags.MCO2Config)) {
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
            const LSCOSource1VirtualValue: ?LSCOSource1VirtualList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    LSCOSSourceLSI = true;
                    const item: LSCOSource1VirtualList = .RCC_LSCOSOURCE_LSI;
                    const conf_item = config.LSCOSource1Virtual;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSCOSource1Virtual", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is configured only for RTC", "RCC_LSCOSOURCE_LSI", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.LSCOSource1Virtual;
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
            const LSEUsedValue: ?f32 = blk: {
                if (CLKSOURCE_LSE or DAC1CLKSOURCE_LSE and check_MCU("DAC1") or ((MSIAutoCalibrationON or MSIKAutoCalibrationON) and check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=") and (config.flags.LSEByPass or config.flags.LSEByPassRTC or config.flags.LSEOscillator or config.flags.LSEOscillatorRTC)) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (LPUART1SourceLSE and config.flags.LPUART1_Used) or (LPTIM1SOURCELSE and config.flags.LPTIM1_Used) or (LPTIM2SOURCELSE and config.flags.LPTIM2_Used) or (LPTIM3SOURCELSE and (config.flags.LPTIM3_Used or config.flags.LPTIM4_Used)) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and config.flags.MCOConfig) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_LSE, .@"=")) and config.flags.MCO2Config) or (RTCSourceLSE and config.flags.RTC_Used)) {
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const MCO2EnableValue: ?MCO2EnableList = blk: {
                if (config.flags.MCO2Config) {
                    const item: MCO2EnableList = .true;
                    break :blk item;
                }
                const item: MCO2EnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if ((config.flags.USB_Used)) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const RNGEnableValue: ?RNGEnableList = blk: {
                if (config.flags.RNG_Used) {
                    const item: RNGEnableList = .true;
                    break :blk item;
                }
                const item: RNGEnableList = .false;
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
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.SPI1_Used) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3_Used) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
                break :blk item;
            };
            const SPI2EnableValue: ?SPI2EnableList = blk: {
                if (config.flags.SPI2_Used) {
                    const item: SPI2EnableList = .true;
                    break :blk item;
                }
                const item: SPI2EnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTC_Used and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTC_Used) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDG_Used) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1_Used) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const USART3EnableValue: ?USART3EnableList = blk: {
                if (config.flags.USART3_Used) {
                    const item: USART3EnableList = .true;
                    break :blk item;
                }
                const item: USART3EnableList = .false;
                break :blk item;
            };
            const UART4EnableValue: ?UART4EnableList = blk: {
                if (config.flags.UART4_Used) {
                    const item: UART4EnableList = .true;
                    break :blk item;
                }
                const item: UART4EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.USE_ADC1 or config.flags.USE_ADC2)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
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
            const UART5EnableValue: ?UART5EnableList = blk: {
                if (config.flags.UART5_Used) {
                    const item: UART5EnableList = .true;
                    break :blk item;
                }
                const item: UART5EnableList = .false;
                break :blk item;
            };
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUART1_Used) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1_Used) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const LPTIM2EnableValue: ?LPTIM2EnableList = blk: {
                if (config.flags.LPTIM2_Used) {
                    const item: LPTIM2EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM2EnableList = .false;
                break :blk item;
            };
            const SDMMCEnableValue: ?SDMMCEnableList = blk: {
                if ((config.flags.SDMMC1_Used)) {
                    const item: SDMMCEnableList = .true;
                    break :blk item;
                }
                const item: SDMMCEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1_Used) {
                    const item: FDCANEnableList = .true;
                    break :blk item;
                }
                const item: FDCANEnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1_Used) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
                break :blk item;
            };
            const I3C1EnableValue: ?I3C1EnableList = blk: {
                if (config.flags.I3C1_Used) {
                    const item: I3C1EnableList = .true;
                    break :blk item;
                }
                const item: I3C1EnableList = .false;
                break :blk item;
            };
            const I3C2EnableValue: ?I3C2EnableList = blk: {
                if (config.flags.I3C2_Used) {
                    const item: I3C2EnableList = .true;
                    break :blk item;
                }
                const item: I3C2EnableList = .false;
                break :blk item;
            };
            const I2C2EnableValue: ?I2C2EnableList = blk: {
                if (config.flags.I2C2_Used) {
                    const item: I2C2EnableList = .true;
                    break :blk item;
                }
                const item: I2C2EnableList = .false;
                break :blk item;
            };
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3_Used) {
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
            const ADF1EnableValue: ?ADF1EnableList = blk: {
                if (config.flags.ADF1_Used) {
                    const item: ADF1EnableList = .true;
                    break :blk item;
                }
                const item: ADF1EnableList = .false;
                break :blk item;
            };
            const OCTOSPIMEnableValue: ?OCTOSPIMEnableList = blk: {
                if (config.flags.OCTOSPI1_Used) {
                    const item: OCTOSPIMEnableList = .true;
                    break :blk item;
                }
                const item: OCTOSPIMEnableList = .false;
                break :blk item;
            };
            const LPTIM3EnableValue: ?LPTIM3EnableList = blk: {
                if ((config.flags.LPTIM3_Used or config.flags.LPTIM4_Used)) {
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
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if (RTCSourceLSE and config.flags.RTC_Used) {
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

            var MSIKSource = ClockNode{
                .name = "MSIKSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSISSource = ClockNode{
                .name = "MSISSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSIKDIV = ClockNode{
                .name = "MSIKDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSISDIV = ClockNode{
                .name = "MSISDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSISOutput = ClockNode{
                .name = "MSISOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1_EXT = ClockNode{
                .name = "SAI1_EXT",
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

            var ADCMult = ClockNode{
                .name = "ADCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCDiv = ClockNode{
                .name = "ADCDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
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

            var ICLKMult = ClockNode{
                .name = "ICLKMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC1Output = ClockNode{
                .name = "SDMMC1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBDiv = ClockNode{
                .name = "USBDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBoutput = ClockNode{
                .name = "USBoutput",
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

            var I3C1Mult = ClockNode{
                .name = "I3C1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I3C1output = ClockNode{
                .name = "I3C1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I3C2Mult = ClockNode{
                .name = "I3C2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I3C2output = ClockNode{
                .name = "I3C2output",
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

            var LSIclk = ClockNode{
                .name = "LSIclk",
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
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
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

            const MSIKSource_clk_value = MSIKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSIKSource",
                "Else",
                "No Extra Log",
                "MSIKSource",
            });
            MSIKSource.nodetype = .source;
            MSIKSource.value = MSIKSource_clk_value.get();

            const MSISSource_clk_value = MSISSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSISSource",
                "Else",
                "No Extra Log",
                "MSISSource",
            });
            MSISSource.nodetype = .source;
            MSISSource.value = MSISSource_clk_value.get();

            const MSIKDIV_clk_value = MSIKDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSIKDIV",
                "Else",
                "No Extra Log",
                "MSIKDIV",
            });
            MSIKDIV.nodetype = .div;
            MSIKDIV.value = MSIKDIV_clk_value.get();
            MSIKDIV.parents = &.{&MSIKSource};

            const MSISDIV_clk_value = MSISDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MSISDIV",
                "Else",
                "No Extra Log",
                "MSISDIV",
            });
            MSISDIV.nodetype = .div;
            MSISDIV.value = MSISDIV_clk_value.get();
            MSISDIV.parents = &.{&MSISSource};

            std.mem.doNotOptimizeAway(MSISFreq_ValueValue);
            MSISOutput.limit = MSISFreq_ValueLimit;
            MSISOutput.nodetype = .output;
            MSISOutput.parents = &.{&MSISDIV};
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
                &MSISOutput,
                &HSIRC,
                &HSEOSC,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
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
                    &MSIKDIV,
                };
                SPI1Mult.nodetype = .multi;
                SPI1Mult.parents = &.{SPI1Multparents[SPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI1Freq_ValueValue);
                SPI1output.limit = SPI1Freq_ValueLimit;
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
                    &APB1Prescaler,
                    &MSIKDIV,
                };
                SPI3Mult.nodetype = .multi;
                SPI3Mult.parents = &.{SPI3Multparents[SPI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI3Freq_ValueValue);
                SPI3output.limit = SPI3Freq_ValueLimit;
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
                    &MSIKDIV,
                };
                SPI2Mult.nodetype = .multi;
                SPI2Mult.parents = &.{SPI2Multparents[SPI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI2Freq_ValueValue);
                SPI2output.limit = SPI2Freq_ValueLimit;
                SPI2output.nodetype = .output;
                SPI2output.parents = &.{&SPI2Mult};
            }
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
                HSERTCDevisor.value = HSERTCDevisor_clk_value;
                HSERTCDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                config.flags.LCDEnable)
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
                RTCOutput.limit = RTCFreq_ValueLimit;
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
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
                    &HSIRC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1output.limit = USART1Freq_ValueLimit;
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
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
                    &HSIRC,
                };
                USART3Mult.nodetype = .multi;
                USART3Mult.parents = &.{USART3Multparents[USART3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART3Freq_ValueValue);
                USART3output.limit = USART3Freq_ValueLimit;
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
                    &HSIRC,
                };
                UART4Mult.nodetype = .multi;
                UART4Mult.parents = &.{UART4Multparents[UART4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART4Freq_ValueValue);
                UART4output.limit = UART4Freq_ValueLimit;
                UART4output.nodetype = .output;
                UART4output.parents = &.{&UART4Mult};
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
                    &HSEOSC,
                    &MSIKDIV,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"="))
            {
                const ADCDiv_clk_value = ADC_DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADCDiv",
                    "Else",
                    "No Extra Log",
                    "ADC_DIV",
                });
                ADCDiv.nodetype = .div;
                ADCDiv.value = ADCDiv_clk_value.get();
                ADCDiv.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                ADCoutput.limit = ADCFreq_ValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCDiv};
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
                        &HSIRC,
                    };
                    UART5Mult.nodetype = .multi;
                    UART5Mult.parents = &.{UART5Multparents[UART5Mult_clk_value.get()]};
                }
            }
            if (check_MCU("UART5_Exist")) {
                if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(UART5Freq_ValueValue);
                    UART5output.limit = UART5Freq_ValueLimit;
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
                    &HSIRC,
                    &LSEOSC,
                    &MSIKDIV,
                };
                LPUART1Mult.nodetype = .multi;
                LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUART1Freq_ValueValue);
                LPUART1output.limit = LPUART1Freq_ValueLimit;
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
                    &MSIKDIV,
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM1Mult.nodetype = .multi;
                LPTIM1Mult.parents = &.{LPTIM1Multparents[LPTIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM1Freq_ValueValue);
                LPTIM1output.limit = LPTIM1Freq_ValueLimit;
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
                LPTIM2output.limit = LPTIM2Freq_ValueLimit;
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
                std.mem.doNotOptimizeAway(DACFreq_ValueValue);
                DACoutput.nodetype = .output;
                DACoutput.parents = &.{&DACMult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"="))
            {
                const ICLKMult_clk_value = ICLKCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ICLKMult",
                    "Else",
                    "No Extra Log",
                    "ICLKCLockSelection",
                });
                const ICLKMultparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &MSIKDIV,
                    &HSEOSC,
                    &HSI48RC,
                };
                ICLKMult.nodetype = .multi;
                ICLKMult.parents = &.{ICLKMultparents[ICLKMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMCEnableValue), SDMMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMCFreq_ValueValue);
                SDMMC1Output.limit = SDMMCFreq_ValueLimit;
                SDMMC1Output.nodetype = .output;
                SDMMC1Output.parents = &.{&ICLKMult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const USBDiv_clk_value = USB_DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBDiv",
                    "Else",
                    "No Extra Log",
                    "USB_DIV",
                });
                USBDiv.nodetype = .div;
                USBDiv.value = USBDiv_clk_value.get();
                USBDiv.parents = &.{&ICLKMult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBDiv};
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
                    &SysCLKOutput,
                    &MSIKDIV,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                FDCANOutput.limit = FDCANFreq_ValueLimit;
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
                    &MSIKDIV,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1output.limit = I2C1Freq_ValueLimit;
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=")) {
                const I3C1Mult_clk_value = I3C1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I3C1Mult",
                    "Else",
                    "No Extra Log",
                    "I3C1CLockSelection",
                });
                const I3C1Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &MSIKDIV,
                };
                I3C1Mult.nodetype = .multi;
                I3C1Mult.parents = &.{I3C1Multparents[I3C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I3C1Freq_ValueValue);
                I3C1output.limit = I3C1Freq_ValueLimit;
                I3C1output.nodetype = .output;
                I3C1output.parents = &.{&I3C1Mult};
            }
            if (check_ref(@TypeOf(I3C2EnableValue), I3C2EnableValue, .true, .@"=")) {
                const I3C2Mult_clk_value = I3C2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I3C2Mult",
                    "Else",
                    "No Extra Log",
                    "I3C2CLockSelection",
                });
                const I3C2Multparents = [_]*const ClockNode{
                    &APB3Output,
                    &MSIKDIV,
                };
                I3C2Mult.nodetype = .multi;
                I3C2Mult.parents = &.{I3C2Multparents[I3C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I3C2EnableValue), I3C2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I3C2Freq_ValueValue);
                I3C2output.limit = I3C2Freq_ValueLimit;
                I3C2output.nodetype = .output;
                I3C2output.parents = &.{&I3C2Mult};
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
                    &MSIKDIV,
                };
                I2C2Mult.nodetype = .multi;
                I2C2Mult.parents = &.{I2C2Multparents[I2C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C2Freq_ValueValue);
                I2C2output.limit = I2C2Freq_ValueLimit;
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
                    &MSIKDIV,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C3Freq_ValueValue);
                I2C3output.limit = I2C3Freq_ValueLimit;
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
                    &MSIKDIV,
                    &SAI1_EXT,
                    &HSEOSC,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1Freq_ValueValue);
                SAI1output.limit = SAI1Freq_ValueLimit;
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
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
                    &SAI1_EXT,
                    &MSIKDIV,
                    &SAI1output,
                };
                ADF1Mult.nodetype = .multi;
                ADF1Mult.parents = &.{ADF1Multparents[ADF1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADF1Freq_ValueValue);
                ADF1output.limit = ADF1Freq_ValueLimit;
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
                    &SysCLKOutput,
                    &MSIKDIV,
                };
                OCTOSPIMMult.nodetype = .multi;
                OCTOSPIMMult.parents = &.{OCTOSPIMMultparents[OCTOSPIMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OCTOSPIMFreq_ValueValue);
                OCTOSPIMoutput.limit = OCTOSPIMFreq_ValueLimit;
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
                    &MSIKDIV,
                    &LSIDIV,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM3Mult.nodetype = .multi;
                LPTIM3Mult.parents = &.{LPTIM3Multparents[LPTIM3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM3Freq_ValueValue);
                LPTIM3output.limit = LPTIM3Freq_ValueLimit;
                LPTIM3output.nodetype = .output;
                LPTIM3output.parents = &.{&LPTIM3Mult};
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
                    &MSIKDIV,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
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
                    &SysCLKOutput,
                    &MSISDIV,
                    &HSI48RC,
                    &MSIKDIV,
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
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
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
                    &LSEOSC,
                    &LSIDIV,
                    &HSEOSC,
                    &HSIRC,
                    &SysCLKOutput,
                    &MSISDIV,
                    &HSI48RC,
                    &MSIKDIV,
                };
                MCO2Mult.nodetype = .multi;
                MCO2Mult.parents = &.{MCO2Multparents[MCO2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                const MCO2Div_clk_value = RCC_MCO2DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.limit = AHBFreq_ValueLimit;
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

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
            CortexSysOutput.limit = CortexFreq_ValueLimit;
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexCLockSelection};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
            FCLKCortexOutput.limit = FCLKCortexFreq_ValueLimit;
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
            TimPrescOut1.limit = APB1TimFreq_ValueLimit;
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

            std.mem.doNotOptimizeAway(APB3Freq_ValueValue);
            APB3Output.limit = APB3Freq_ValueLimit;
            APB3Output.nodetype = .output;
            APB3Output.parents = &.{&APB3Prescaler};

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
            TimPrescOut2.limit = APB2TimFreq_ValueLimit;
            TimPrescOut2.nodetype = .output;
            TimPrescOut2.parents = &.{&TimPrescalerAPB2};

            std.mem.doNotOptimizeAway(LSIDIV_VALUEValue);
            LSIclk.limit = LSIDIV_VALUELimit;
            LSIclk.nodetype = .output;
            LSIclk.parents = &.{&LSIDIV};

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexCLockSelection = try CortexCLockSelection.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
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
            out.FDCANOutput = try FDCANOutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.OCTOSPIMoutput = try OCTOSPIMoutput.get_output();
            out.OCTOSPIMMult = try OCTOSPIMMult.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.USBDiv = try USBDiv.get_output();
            out.SDMMC1Output = try SDMMC1Output.get_output();
            out.ICLKMult = try ICLKMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.CRSCLKoutput = try CRSCLKoutput.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCDiv = try ADCDiv.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.DACoutput = try DACoutput.get_output();
            out.DACMult = try DACMult.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIDIV = try LSIDIV.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I3C1output = try I3C1output.get_output();
            out.I3C1Mult = try I3C1Mult.get_output();
            out.I3C2output = try I3C2output.get_output();
            out.I3C2Mult = try I3C2Mult.get_output();
            out.ADF1output = try ADF1output.get_output();
            out.ADF1Mult = try ADF1Mult.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI2output = try SPI2output.get_output();
            out.SPI2Mult = try SPI2Mult.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.MSIKDIV = try MSIKDIV.get_output();
            out.MSIKSource = try MSIKSource.get_output();
            out.MSISDIV = try MSISDIV.get_output();
            out.MSISSource = try MSISSource.get_output();
            out.MSISOutput = try MSISOutput.get_output();
            out.SAI1_EXT = try SAI1_EXT.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.APB3Prescaler = try APB3Prescaler.get_output();
            out.LSIclk = try LSIclk.get_extra_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSIDIV = LSIDIVValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIKSource = MSIKSourceValue;
            ref_out.MSISSource = MSISSourceValue;
            ref_out.MSIKDIV = MSIKDIVValue;
            ref_out.MSISDIV = MSISDIVValue;
            ref_out.EXTERNALSAI1_CLOCK_VALUE = EXTERNALSAI1_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI3CLockSelection = SPI3CLockSelectionValue;
            ref_out.SPI2CLockSelection = SPI2CLockSelectionValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART3CLockSelection = USART3CLockSelectionValue;
            ref_out.UART4CLockSelection = UART4CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.ADC_DIV = ADC_DIVValue;
            ref_out.UART5CLockSelection = UART5CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.DACCLockSelection = DACCLockSelectionValue;
            ref_out.ICLKCLockSelection = ICLKCLockSelectionValue;
            ref_out.USB_DIV = USB_DIVValue;
            ref_out.FDCANClockSelection = FDCANClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I3C1CLockSelection = I3C1CLockSelectionValue;
            ref_out.I3C2CLockSelection = I3C2CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.AdfClockSelection = AdfClockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCO2Div = RCC_MCO2DivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.CortexCLockSelection = CortexCLockSelectionValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB3CLKDivider = APB3CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.EPOD_Booster_Source = EPOD_Booster_SourceValue;
            ref_out.EPOD_Booster_Divider = EPOD_Booster_DividerValue;
            ref_out.Booster_Source = Booster_SourceValue;
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
            ref_out.EnableCRS = EnableCRSValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.MCO2Enable = MCO2EnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.EnableExtClockForSAI1 = EnableExtClockForSAI1Value;
            ref_out.SPI1Enable = SPI1EnableValue;
            ref_out.SPI3Enable = SPI3EnableValue;
            ref_out.SPI2Enable = SPI2EnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART3Enable = USART3EnableValue;
            ref_out.UART4Enable = UART4EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.DACEnable = DACEnableValue;
            ref_out.UART5Enable = UART5EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.SDMMCEnable = SDMMCEnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I3C1Enable = I3C1EnableValue;
            ref_out.I3C2Enable = I3C2EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.ADF1Enable = ADF1EnableValue;
            ref_out.OCTOSPIMEnable = OCTOSPIMEnableValue;
            ref_out.LPTIM3Enable = LPTIM3EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.LSEState = LSEStateValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.CortexCLockSelectionVirtual = CortexCLockSelectionVirtualValue;
            ref_out.LSCOSource1Virtual = LSCOSource1VirtualValue;
            ref_out.DACCLockSelectionVirtual = DACCLockSelectionVirtualValue;
            ref_out.MSIUsed = MSIUsedValue;
            ref_out.MSIKUsed = MSIKUsedValue;
            ref_out.MSISUsed = MSISUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
