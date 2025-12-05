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
    RCC_SYSCLKSOURCE_CSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_CSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
            .RCC_SYSCLKSOURCE_PLLCLK => 3,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSI48,
    RCC_MCO1SOURCE_PLL1QCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_HSI => 2,
            .RCC_MCO1SOURCE_HSI48 => 3,
            .RCC_MCO1SOURCE_PLL1QCLK => 4,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_PLL2PCLK,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_PLLCLK,
    RCC_MCO2SOURCE_CSICLK,
    RCC_MCO2SOURCE_LSICLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_SYSCLK => 0,
            .RCC_MCO2SOURCE_PLL2PCLK => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_PLLCLK => 3,
            .RCC_MCO2SOURCE_CSICLK => 4,
            .RCC_MCO2SOURCE_LSICLK => 5,
        };
    }
};
pub const traceClkSourceList = enum {
    RCC_TRACECLKSOURCE_HSI,
    RCC_TRACECLKSOURCE_CSI,
    RCC_TRACECLKSOURCE_HSE,
    RCC_TRACECLKSOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TRACECLKSOURCE_HSI => 0,
            .RCC_TRACECLKSOURCE_CSI => 1,
            .RCC_TRACECLKSOURCE_HSE => 2,
            .RCC_TRACECLKSOURCE_PLLCLK => 3,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_CSI,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_CSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
        };
    }
};
pub const CKPERSourceSelectionList = enum {
    RCC_CLKPSOURCE_HSI,
    RCC_CLKPSOURCE_CSI,
    RCC_CLKPSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLKPSOURCE_HSI => 0,
            .RCC_CLKPSOURCE_CSI => 1,
            .RCC_CLKPSOURCE_HSE => 2,
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
pub const SPI123CLockSelectionList = enum {
    RCC_SPI123CLKSOURCE_PLL,
    RCC_SPI123CLKSOURCE_PLL2,
    RCC_SPI123CLKSOURCE_PLL3,
    RCC_SPI123CLKSOURCE_PIN,
    RCC_SPI123CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI123CLKSOURCE_PLL => 0,
            .RCC_SPI123CLKSOURCE_PLL2 => 1,
            .RCC_SPI123CLKSOURCE_PLL3 => 2,
            .RCC_SPI123CLKSOURCE_PIN => 3,
            .RCC_SPI123CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL,
    RCC_SAI1CLKSOURCE_PLL2,
    RCC_SAI1CLKSOURCE_PLL3,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL => 0,
            .RCC_SAI1CLKSOURCE_PLL2 => 1,
            .RCC_SAI1CLKSOURCE_PLL3 => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SAI2BCLockSelectionList = enum {
    RCC_SAI2BCLKSOURCE_PLL,
    RCC_SAI2BCLKSOURCE_PLL2,
    RCC_SAI2BCLKSOURCE_PLL3,
    RCC_SAI2BCLKSOURCE_PIN,
    RCC_SAI2BCLKSOURCE_CLKP,
    RCC_SAI2BCLKSOURCE_SPDIF,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2BCLKSOURCE_PLL => 0,
            .RCC_SAI2BCLKSOURCE_PLL2 => 1,
            .RCC_SAI2BCLKSOURCE_PLL3 => 2,
            .RCC_SAI2BCLKSOURCE_PIN => 3,
            .RCC_SAI2BCLKSOURCE_CLKP => 4,
            .RCC_SAI2BCLKSOURCE_SPDIF => 5,
        };
    }
};
pub const SAI2ACLockSelectionList = enum {
    RCC_SAI2ACLKSOURCE_PLL,
    RCC_SAI2ACLKSOURCE_PLL2,
    RCC_SAI2ACLKSOURCE_PLL3,
    RCC_SAI2ACLKSOURCE_PIN,
    RCC_SAI2ACLKSOURCE_CLKP,
    RCC_SAI2ACLKSOURCE_SPDIF,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2ACLKSOURCE_PLL => 0,
            .RCC_SAI2ACLKSOURCE_PLL2 => 1,
            .RCC_SAI2ACLKSOURCE_PLL3 => 2,
            .RCC_SAI2ACLKSOURCE_PIN => 3,
            .RCC_SAI2ACLKSOURCE_CLKP => 4,
            .RCC_SAI2ACLKSOURCE_SPDIF => 5,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_HSI48,
    RCC_RNGCLKSOURCE_PLL,
    RCC_RNGCLKSOURCE_LSE,
    RCC_RNGCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_HSI48 => 0,
            .RCC_RNGCLKSOURCE_PLL => 1,
            .RCC_RNGCLKSOURCE_LSE => 2,
            .RCC_RNGCLKSOURCE_LSI => 3,
        };
    }
};
pub const I2C123CLockSelectionList = enum {
    RCC_I2C123CLKSOURCE_D2PCLK1,
    RCC_I2C123CLKSOURCE_PLL3,
    RCC_I2C123CLKSOURCE_HSI,
    RCC_I2C123CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C123CLKSOURCE_D2PCLK1 => 0,
            .RCC_I2C123CLKSOURCE_PLL3 => 1,
            .RCC_I2C123CLKSOURCE_HSI => 2,
            .RCC_I2C123CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_D3PCLK1,
    RCC_I2C4CLKSOURCE_PLL3,
    RCC_I2C4CLKSOURCE_HSI,
    RCC_I2C4CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_D3PCLK1 => 0,
            .RCC_I2C4CLKSOURCE_PLL3 => 1,
            .RCC_I2C4CLKSOURCE_HSI => 2,
            .RCC_I2C4CLKSOURCE_CSI => 3,
        };
    }
};
pub const SPDIFCLockSelectionList = enum {
    RCC_SPDIFRXCLKSOURCE_PLL,
    RCC_SPDIFRXCLKSOURCE_PLL2,
    RCC_SPDIFRXCLKSOURCE_PLL3,
    RCC_SPDIFRXCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPDIFRXCLKSOURCE_PLL => 0,
            .RCC_SPDIFRXCLKSOURCE_PLL2 => 1,
            .RCC_SPDIFRXCLKSOURCE_PLL3 => 2,
            .RCC_SPDIFRXCLKSOURCE_HSI => 3,
        };
    }
};
pub const QSPICLockSelectionList = enum {
    RCC_OSPICLKSOURCE_D1HCLK,
    RCC_OSPICLKSOURCE_PLL,
    RCC_OSPICLKSOURCE_PLL2,
    RCC_OSPICLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_OSPICLKSOURCE_D1HCLK => 0,
            .RCC_OSPICLKSOURCE_PLL => 1,
            .RCC_OSPICLKSOURCE_PLL2 => 2,
            .RCC_OSPICLKSOURCE_CLKP => 3,
        };
    }
};
pub const FMCCLockSelectionList = enum {
    RCC_FMCCLKSOURCE_D1HCLK,
    RCC_FMCCLKSOURCE_PLL,
    RCC_FMCCLKSOURCE_PLL2,
    RCC_FMCCLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FMCCLKSOURCE_D1HCLK => 0,
            .RCC_FMCCLKSOURCE_PLL => 1,
            .RCC_FMCCLKSOURCE_PLL2 => 2,
            .RCC_FMCCLKSOURCE_CLKP => 3,
        };
    }
};
pub const SWPCLockSelectionList = enum {
    RCC_SWPMI1CLKSOURCE_D2PCLK1,
    RCC_SWPMI1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SWPMI1CLKSOURCE_D2PCLK1 => 0,
            .RCC_SWPMI1CLKSOURCE_HSI => 1,
        };
    }
};
pub const SDMMC1CLockSelectionList = enum {
    RCC_SDMMCCLKSOURCE_PLL,
    RCC_SDMMCCLKSOURCE_PLL2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMCCLKSOURCE_PLL => 0,
            .RCC_SDMMCCLKSOURCE_PLL2 => 1,
        };
    }
};
pub const DFSDMCLockSelectionList = enum {
    RCC_DFSDM1CLKSOURCE_D2PCLK1,
    RCC_DFSDM1CLKSOURCE_SYS,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1CLKSOURCE_D2PCLK1 => 0,
            .RCC_DFSDM1CLKSOURCE_SYS => 1,
        };
    }
};
pub const DFSDM2CLockSelectionList = enum {
    RCC_DFSDM2CLKSOURCE_SRDPCLK1,
    RCC_DFSDM2CLKSOURCE_SYS,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM2CLKSOURCE_SRDPCLK1 => 0,
            .RCC_DFSDM2CLKSOURCE_SYS => 1,
        };
    }
};
pub const USART16CLockSelectionList = enum {
    RCC_USART16910CLKSOURCE_D2PCLK2,
    RCC_USART16910CLKSOURCE_PLL2,
    RCC_USART16910CLKSOURCE_PLL3,
    RCC_USART16910CLKSOURCE_HSI,
    RCC_USART16910CLKSOURCE_CSI,
    RCC_USART16910CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART16910CLKSOURCE_D2PCLK2 => 0,
            .RCC_USART16910CLKSOURCE_PLL2 => 1,
            .RCC_USART16910CLKSOURCE_PLL3 => 2,
            .RCC_USART16910CLKSOURCE_HSI => 3,
            .RCC_USART16910CLKSOURCE_CSI => 4,
            .RCC_USART16910CLKSOURCE_LSE => 5,
        };
    }
};
pub const USART234578CLockSelectionList = enum {
    RCC_USART234578CLKSOURCE_D2PCLK1,
    RCC_USART234578CLKSOURCE_PLL2,
    RCC_USART234578CLKSOURCE_PLL3,
    RCC_USART234578CLKSOURCE_HSI,
    RCC_USART234578CLKSOURCE_CSI,
    RCC_USART234578CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART234578CLKSOURCE_D2PCLK1 => 0,
            .RCC_USART234578CLKSOURCE_PLL2 => 1,
            .RCC_USART234578CLKSOURCE_PLL3 => 2,
            .RCC_USART234578CLKSOURCE_HSI => 3,
            .RCC_USART234578CLKSOURCE_CSI => 4,
            .RCC_USART234578CLKSOURCE_LSE => 5,
        };
    }
};
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_D3PCLK1,
    RCC_LPUART1CLKSOURCE_PLL2,
    RCC_LPUART1CLKSOURCE_PLL3,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_CSI,
    RCC_LPUART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_D3PCLK1 => 0,
            .RCC_LPUART1CLKSOURCE_PLL2 => 1,
            .RCC_LPUART1CLKSOURCE_PLL3 => 2,
            .RCC_LPUART1CLKSOURCE_HSI => 3,
            .RCC_LPUART1CLKSOURCE_CSI => 4,
            .RCC_LPUART1CLKSOURCE_LSE => 5,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_D2PCLK1,
    RCC_LPTIM1CLKSOURCE_PLL2,
    RCC_LPTIM1CLKSOURCE_PLL3,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_D2PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_PLL2 => 1,
            .RCC_LPTIM1CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
            .RCC_LPTIM1CLKSOURCE_LSI => 4,
            .RCC_LPTIM1CLKSOURCE_CLKP => 5,
        };
    }
};
pub const LPTIM345CLockSelectionList = enum {
    RCC_LPTIM3CLKSOURCE_D3PCLK1,
    RCC_LPTIM3CLKSOURCE_PLL2,
    RCC_LPTIM3CLKSOURCE_PLL3,
    RCC_LPTIM3CLKSOURCE_LSE,
    RCC_LPTIM3CLKSOURCE_LSI,
    RCC_LPTIM3CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM3CLKSOURCE_D3PCLK1 => 0,
            .RCC_LPTIM3CLKSOURCE_PLL2 => 1,
            .RCC_LPTIM3CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM3CLKSOURCE_LSE => 3,
            .RCC_LPTIM3CLKSOURCE_LSI => 4,
            .RCC_LPTIM3CLKSOURCE_CLKP => 5,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_D3PCLK1,
    RCC_LPTIM2CLKSOURCE_PLL2,
    RCC_LPTIM2CLKSOURCE_PLL3,
    RCC_LPTIM2CLKSOURCE_LSE,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_D3PCLK1 => 0,
            .RCC_LPTIM2CLKSOURCE_PLL2 => 1,
            .RCC_LPTIM2CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
            .RCC_LPTIM2CLKSOURCE_LSI => 4,
            .RCC_LPTIM2CLKSOURCE_CLKP => 5,
        };
    }
};
pub const SPI6CLockSelectionList = enum {
    RCC_SPI6CLKSOURCE_D3PCLK1,
    RCC_SPI6CLKSOURCE_PLL2,
    RCC_SPI6CLKSOURCE_PLL3,
    RCC_SPI6CLKSOURCE_HSI,
    RCC_SPI6CLKSOURCE_CSI,
    RCC_SPI6CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_D3PCLK1 => 0,
            .RCC_SPI6CLKSOURCE_PLL2 => 1,
            .RCC_SPI6CLKSOURCE_PLL3 => 2,
            .RCC_SPI6CLKSOURCE_HSI => 3,
            .RCC_SPI6CLKSOURCE_CSI => 4,
            .RCC_SPI6CLKSOURCE_HSE => 5,
        };
    }
};
pub const Spi45ClockSelectionList = enum {
    RCC_SPI45CLKSOURCE_D2PCLK1,
    RCC_SPI45CLKSOURCE_PLL2,
    RCC_SPI45CLKSOURCE_PLL3,
    RCC_SPI45CLKSOURCE_HSI,
    RCC_SPI45CLKSOURCE_CSI,
    RCC_SPI45CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI45CLKSOURCE_D2PCLK1 => 0,
            .RCC_SPI45CLKSOURCE_PLL2 => 1,
            .RCC_SPI45CLKSOURCE_PLL3 => 2,
            .RCC_SPI45CLKSOURCE_HSI => 3,
            .RCC_SPI45CLKSOURCE_CSI => 4,
            .RCC_SPI45CLKSOURCE_HSE => 5,
        };
    }
};
pub const USBCLockSelectionList = enum {
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_PLL3,
    RCC_USBCLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL => 0,
            .RCC_USBCLKSOURCE_PLL3 => 1,
            .RCC_USBCLKSOURCE_HSI48 => 2,
        };
    }
};
pub const FDCANCLockSelectionList = enum {
    RCC_FDCANCLKSOURCE_HSE,
    RCC_FDCANCLKSOURCE_PLL,
    RCC_FDCANCLKSOURCE_PLL2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_HSE => 0,
            .RCC_FDCANCLKSOURCE_PLL => 1,
            .RCC_FDCANCLKSOURCE_PLL2 => 2,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_PLL2,
    RCC_ADCCLKSOURCE_PLL3,
    RCC_ADCCLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_PLL2 => 0,
            .RCC_ADCCLKSOURCE_PLL3 => 1,
            .RCC_ADCCLKSOURCE_CLKP => 2,
        };
    }
};
pub const CECCLockSelectionList = enum {
    RCC_CECCLKSOURCE_LSE,
    RCC_CECCLKSOURCE_LSI,
    RCC_CECCLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CECCLKSOURCE_LSE => 0,
            .RCC_CECCLKSOURCE_LSI => 1,
            .RCC_CECCLKSOURCE_CSI => 2,
        };
    }
};
pub const HSIDivList = enum {
    RCC_PLLSAIDIVR_1,
    RCC_PLLSAIDIVR_2,
    RCC_PLLSAIDIVR_4,
    RCC_PLLSAIDIVR_8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLSAIDIVR_1 => 1,
            .RCC_PLLSAIDIVR_2 => 2,
            .RCC_PLLSAIDIVR_4 => 4,
            .RCC_PLLSAIDIVR_8 => 8,
        };
    }
};
pub const RCC_MCODiv1List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    RCC_MCODIV_6,
    RCC_MCODIV_7,
    RCC_MCODIV_8,
    RCC_MCODIV_9,
    RCC_MCODIV_10,
    RCC_MCODIV_11,
    RCC_MCODIV_12,
    RCC_MCODIV_13,
    RCC_MCODIV_14,
    RCC_MCODIV_15,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
            .RCC_MCODIV_6 => 6,
            .RCC_MCODIV_7 => 7,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_9 => 9,
            .RCC_MCODIV_10 => 10,
            .RCC_MCODIV_11 => 11,
            .RCC_MCODIV_12 => 12,
            .RCC_MCODIV_13 => 13,
            .RCC_MCODIV_14 => 14,
            .RCC_MCODIV_15 => 15,
        };
    }
};
pub const RCC_MCODiv2List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    RCC_MCODIV_6,
    RCC_MCODIV_7,
    RCC_MCODIV_8,
    RCC_MCODIV_9,
    RCC_MCODIV_10,
    RCC_MCODIV_11,
    RCC_MCODIV_12,
    RCC_MCODIV_13,
    RCC_MCODIV_14,
    RCC_MCODIV_15,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
            .RCC_MCODIV_6 => 6,
            .RCC_MCODIV_7 => 7,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_9 => 9,
            .RCC_MCODIV_10 => 10,
            .RCC_MCODIV_11 => 11,
            .RCC_MCODIV_12 => 12,
            .RCC_MCODIV_13 => 13,
            .RCC_MCODIV_14 => 14,
            .RCC_MCODIV_15 => 15,
        };
    }
};
pub const CDCPREList = enum {
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
pub const HPREList = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    RCC_HCLK_DIV64,
    RCC_HCLK_DIV128,
    RCC_HCLK_DIV256,
    RCC_HCLK_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV1 => 1,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV16 => 16,
            .RCC_HCLK_DIV64 => 64,
            .RCC_HCLK_DIV128 => 128,
            .RCC_HCLK_DIV256 => 256,
            .RCC_HCLK_DIV512 => 512,
        };
    }
};
pub const CDPPREList = enum {
    RCC_APB3_DIV1,
    RCC_APB3_DIV2,
    RCC_APB3_DIV4,
    RCC_APB3_DIV8,
    RCC_APB3_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB3_DIV1 => 1,
            .RCC_APB3_DIV2 => 2,
            .RCC_APB3_DIV4 => 4,
            .RCC_APB3_DIV8 => 8,
            .RCC_APB3_DIV16 => 16,
        };
    }
};
pub const CDPPRE1List = enum {
    RCC_APB1_DIV1,
    RCC_APB1_DIV2,
    RCC_APB1_DIV4,
    RCC_APB1_DIV8,
    RCC_APB1_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB1_DIV1 => 1,
            .RCC_APB1_DIV2 => 2,
            .RCC_APB1_DIV4 => 4,
            .RCC_APB1_DIV8 => 8,
            .RCC_APB1_DIV16 => 16,
        };
    }
};
pub const CDPPRE2List = enum {
    RCC_APB2_DIV1,
    RCC_APB2_DIV2,
    RCC_APB2_DIV4,
    RCC_APB2_DIV8,
    RCC_APB2_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB2_DIV1 => 1,
            .RCC_APB2_DIV2 => 2,
            .RCC_APB2_DIV4 => 4,
            .RCC_APB2_DIV8 => 8,
            .RCC_APB2_DIV16 => 16,
        };
    }
};
pub const SRDPPREList = enum {
    RCC_APB4_DIV1,
    RCC_APB4_DIV2,
    RCC_APB4_DIV4,
    RCC_APB4_DIV8,
    RCC_APB4_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB4_DIV1 => 1,
            .RCC_APB4_DIV2 => 2,
            .RCC_APB4_DIV4 => 4,
            .RCC_APB4_DIV8 => 8,
            .RCC_APB4_DIV16 => 16,
        };
    }
};
pub const DIVP1List = enum {
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
    RCC_RTCCLKSOURCE_HSE_DIV32,
    RCC_RTCCLKSOURCE_HSE_DIV33,
    RCC_RTCCLKSOURCE_HSE_DIV34,
    RCC_RTCCLKSOURCE_HSE_DIV35,
    RCC_RTCCLKSOURCE_HSE_DIV36,
    RCC_RTCCLKSOURCE_HSE_DIV37,
    RCC_RTCCLKSOURCE_HSE_DIV38,
    RCC_RTCCLKSOURCE_HSE_DIV39,
    RCC_RTCCLKSOURCE_HSE_DIV40,
    RCC_RTCCLKSOURCE_HSE_DIV41,
    RCC_RTCCLKSOURCE_HSE_DIV42,
    RCC_RTCCLKSOURCE_HSE_DIV43,
    RCC_RTCCLKSOURCE_HSE_DIV44,
    RCC_RTCCLKSOURCE_HSE_DIV45,
    RCC_RTCCLKSOURCE_HSE_DIV46,
    RCC_RTCCLKSOURCE_HSE_DIV47,
    RCC_RTCCLKSOURCE_HSE_DIV48,
    RCC_RTCCLKSOURCE_HSE_DIV49,
    RCC_RTCCLKSOURCE_HSE_DIV50,
    RCC_RTCCLKSOURCE_HSE_DIV51,
    RCC_RTCCLKSOURCE_HSE_DIV52,
    RCC_RTCCLKSOURCE_HSE_DIV53,
    RCC_RTCCLKSOURCE_HSE_DIV54,
    RCC_RTCCLKSOURCE_HSE_DIV55,
    RCC_RTCCLKSOURCE_HSE_DIV56,
    RCC_RTCCLKSOURCE_HSE_DIV57,
    RCC_RTCCLKSOURCE_HSE_DIV58,
    RCC_RTCCLKSOURCE_HSE_DIV59,
    RCC_RTCCLKSOURCE_HSE_DIV60,
    RCC_RTCCLKSOURCE_HSE_DIV61,
    RCC_RTCCLKSOURCE_HSE_DIV62,
    RCC_RTCCLKSOURCE_HSE_DIV63,
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
            .RCC_RTCCLKSOURCE_HSE_DIV32 => 32,
            .RCC_RTCCLKSOURCE_HSE_DIV33 => 33,
            .RCC_RTCCLKSOURCE_HSE_DIV34 => 34,
            .RCC_RTCCLKSOURCE_HSE_DIV35 => 35,
            .RCC_RTCCLKSOURCE_HSE_DIV36 => 36,
            .RCC_RTCCLKSOURCE_HSE_DIV37 => 37,
            .RCC_RTCCLKSOURCE_HSE_DIV38 => 38,
            .RCC_RTCCLKSOURCE_HSE_DIV39 => 39,
            .RCC_RTCCLKSOURCE_HSE_DIV40 => 40,
            .RCC_RTCCLKSOURCE_HSE_DIV41 => 41,
            .RCC_RTCCLKSOURCE_HSE_DIV42 => 42,
            .RCC_RTCCLKSOURCE_HSE_DIV43 => 43,
            .RCC_RTCCLKSOURCE_HSE_DIV44 => 44,
            .RCC_RTCCLKSOURCE_HSE_DIV45 => 45,
            .RCC_RTCCLKSOURCE_HSE_DIV46 => 46,
            .RCC_RTCCLKSOURCE_HSE_DIV47 => 47,
            .RCC_RTCCLKSOURCE_HSE_DIV48 => 48,
            .RCC_RTCCLKSOURCE_HSE_DIV49 => 49,
            .RCC_RTCCLKSOURCE_HSE_DIV50 => 50,
            .RCC_RTCCLKSOURCE_HSE_DIV51 => 51,
            .RCC_RTCCLKSOURCE_HSE_DIV52 => 52,
            .RCC_RTCCLKSOURCE_HSE_DIV53 => 53,
            .RCC_RTCCLKSOURCE_HSE_DIV54 => 54,
            .RCC_RTCCLKSOURCE_HSE_DIV55 => 55,
            .RCC_RTCCLKSOURCE_HSE_DIV56 => 56,
            .RCC_RTCCLKSOURCE_HSE_DIV57 => 57,
            .RCC_RTCCLKSOURCE_HSE_DIV58 => 58,
            .RCC_RTCCLKSOURCE_HSE_DIV59 => 59,
            .RCC_RTCCLKSOURCE_HSE_DIV60 => 60,
            .RCC_RTCCLKSOURCE_HSE_DIV61 => 61,
            .RCC_RTCCLKSOURCE_HSE_DIV62 => 62,
            .RCC_RTCCLKSOURCE_HSE_DIV63 => 63,
        };
    }
};
pub const RCC_TIM_PRescaler_SelectionList = enum {
    RCC_TIMPRES_ACTIVATED,
    RCC_TIMPRES_DESACTIVATED,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE0,
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
pub const FLatencyList = enum {
    FLASH_LATENCY_6,
    FLASH_LATENCY_5,
    FLASH_LATENCY_4,
    FLASH_LATENCY_3,
    FLASH_LATENCY_2,
    FLASH_LATENCY_1,
    FLASH_LATENCY_0,
};
pub const PLL1_VCI_RangeList = enum {
    RCC_PLL1VCIRANGE_0,
    RCC_PLL1VCIRANGE_1,
    RCC_PLL1VCIRANGE_2,
    RCC_PLL1VCIRANGE_3,
};
pub const PLL2_VCI_RangeList = enum {
    RCC_PLL2VCIRANGE_0,
    RCC_PLL2VCIRANGE_1,
    RCC_PLL2VCIRANGE_2,
    RCC_PLL2VCIRANGE_3,
};
pub const PLL3_VCI_RangeList = enum {
    RCC_PLL3VCIRANGE_0,
    RCC_PLL3VCIRANGE_1,
    RCC_PLL3VCIRANGE_2,
    RCC_PLL3VCIRANGE_3,
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
    RCC_CRS_SYNC_SOURCE_PIN,
    RCC_CRS_SYNC_SOURCE_LSE,
    RCC_CRS_SYNC_SOURCE_USB2,
    RCC_CRS_SYNC_SOURCE_USB1,
};
pub const PolarityList = enum {
    RCC_CRS_SYNC_POLARITY_RISING,
    RCC_CRS_SYNC_POLARITY_FALLING,
};
pub const ReloadValueTypeList = enum {
    UserValue,
    automatic,
};
pub const PLL1_VCO_SELList = enum {
    RCC_PLL1VCOMEDIUM,
    RCC_PLL1VCOWIDE,
};
pub const PLL2_VCO_SELList = enum {
    RCC_PLL2VCOMEDIUM,
    RCC_PLL2VCOWIDE,
};
pub const PLL3_VCO_SELList = enum {
    RCC_PLL3VCOMEDIUM,
    RCC_PLL3VCOWIDE,
};
pub const LSIEnableList = enum {
    true,
};
pub const ExtClockEnableList = enum {
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
pub const TraceEnableList = enum {
    auto,
};
pub const cKPerEnableList = enum {
    true,
    false,
};
pub const SAI1EnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const SDMMC1EnableList = enum {
    true,
    false,
};
pub const SAI2AEnableList = enum {
    true,
    false,
};
pub const SAI2BEnableList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const SPI123EnableList = enum {
    true,
    false,
};
pub const SPDIFEnableList = enum {
    true,
    false,
};
pub const FDCANEnableList = enum {
    true,
    false,
};
pub const FMCEnableList = enum {
    true,
    false,
};
pub const OCSPIEnableList = enum {
    true,
    false,
};
pub const TraceEnablePllList = enum {
    true,
    false,
};
pub const LPTIM2EnableList = enum {
    true,
    false,
};
pub const LPTIM345EnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const SPI6EnableList = enum {
    true,
    false,
};
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const USART234578EnableList = enum {
    true,
    false,
};
pub const USART16910EnableList = enum {
    true,
    false,
};
pub const SPI45EnableList = enum {
    true,
    false,
};
pub const LTDCEnableList = enum {
    true,
    false,
};
pub const I2C4EnableList = enum {
    true,
    false,
};
pub const I2C123EnableList = enum {
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
pub const DAC1EnableList = enum {
    true,
    false,
};
pub const DAC2EnableList = enum {
    true,
    false,
};
pub const EnableDFSDMAudioList = enum {
    true,
    false,
};
pub const SWPEnableList = enum {
    true,
    false,
};
pub const DFSDMEnableList = enum {
    true,
    false,
};
pub const DFSDM2EnableList = enum {
    true,
    false,
};
pub const SPI6OutputEnableList = enum {
    true,
    false,
};
pub const EnableDFSDM2AudioList = enum {
    true,
    false,
};
pub const CECEnableList = enum {
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
pub const MCO2I2SEnableList = enum {
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
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            USB_OTG_HSEmbeddedPHYUsed_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            RBGEnable: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            I2S6Used_ForRCC: bool = false,
            DFSDM2Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            USART10Used_ForRCC: bool = false,
            UART9Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            SWPMI1Used_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null,
            VDD_VALUE: ?f32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
            FLatency: ?FLatencyList = null,
            Prescaler: ?PrescalerList = null,
            Polarity: ?PolarityList = null,
            ReloadValueType: ?ReloadValueTypeList = null,
            ReloadValue: ?u32 = null,
            Fsync: ?f32 = null,
            ErrorLimitValue: ?u32 = null,
            HSI48CalibrationValue: ?u32 = null,
            CSICalibrationValue: ?u32 = null,
            HSICalibrationValue: ?u32 = null,
        };
        pub const Config = struct {
            HSIDiv: ?HSIDivList = null,
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            CDCPRE: ?CDCPREList = null,
            Cortex_Div: ?Cortex_DivList = null,
            HPRE: ?HPREList = null,
            CDPPRE: ?CDPPREList = null,
            CDPPRE1: ?CDPPRE1List = null,
            CDPPRE2: ?CDPPRE2List = null,
            SRDPPRE: ?SRDPPREList = null,
            PLLSource: ?PLLSourceList = null,
            CKPERSourceSelection: ?CKPERSourceSelectionList = null,
            DIVM1: ?u32 = null,
            DIVM2: ?u32 = null,
            DIVM3: ?u32 = null,
            DIVN1: ?u32 = null,
            PLLFRACN: ?u32 = null,
            DIVP1: ?DIVP1List = null,
            DIVQ1: ?u32 = null,
            DIVR1: ?u32 = null,
            DIVN2: ?u32 = null,
            PLL2FRACN: ?u32 = null,
            DIVP2: ?u32 = null,
            DIVQ2: ?u32 = null,
            DIVR2: ?u32 = null,
            DIVN3: ?u32 = null,
            PLL3FRACN: ?u32 = null,
            DIVP3: ?u32 = null,
            DIVQ3: ?u32 = null,
            DIVR3: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            SPI123CLockSelection: ?SPI123CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2BCLockSelection: ?SAI2BCLockSelectionList = null,
            SAI2ACLockSelection: ?SAI2ACLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            I2C123CLockSelection: ?I2C123CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            QSPICLockSelection: ?QSPICLockSelectionList = null,
            FMCCLockSelection: ?FMCCLockSelectionList = null,
            SWPCLockSelection: ?SWPCLockSelectionList = null,
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null,
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null,
            DFSDM2CLockSelection: ?DFSDM2CLockSelectionList = null,
            USART16CLockSelection: ?USART16CLockSelectionList = null,
            USART234578CLockSelection: ?USART234578CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM345CLockSelection: ?LPTIM345CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            SPI6CLockSelection: ?SPI6CLockSelectionList = null,
            Spi45ClockSelection: ?Spi45ClockSelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            FDCANCLockSelection: ?FDCANCLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            CECCLockSelection: ?CECCLockSelectionList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSIDiv: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            CSIRC: f32 = 0,
            RC48: f32 = 0,
            I2S_CKIN: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            traceClkSource: f32 = 0,
            TraceCLKOutput: f32 = 0,
            CDCPRE: f32 = 0,
            CDCPREOutput: f32 = 0,
            CpuClockOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            HPRE: f32 = 0,
            AHBOutput: f32 = 0,
            AXIClockOutput: f32 = 0,
            HCLK3Output: f32 = 0,
            CDPPRE: f32 = 0,
            APB3Output: f32 = 0,
            CDPPRE1: f32 = 0,
            Tim1Mul: f32 = 0,
            Tim1Output: f32 = 0,
            AHB12Output: f32 = 0,
            APB1Output: f32 = 0,
            CDPPRE2: f32 = 0,
            APB2Output: f32 = 0,
            Tim2Mul: f32 = 0,
            Tim2Output: f32 = 0,
            AHB4Output: f32 = 0,
            SRDPPRE: f32 = 0,
            APB4Output: f32 = 0,
            PLLSource: f32 = 0,
            CKPERSource: f32 = 0,
            CKPERoutput: f32 = 0,
            DIVM1: f32 = 0,
            DIVM2: f32 = 0,
            DIVM3: f32 = 0,
            DIVN1: f32 = 0,
            PLLFRACN: f32 = 0,
            DIVP1: f32 = 0,
            DIVQ1: f32 = 0,
            DIVQ1output: f32 = 0,
            DIVR1: f32 = 0,
            DIVR1output: f32 = 0,
            DIVN2: f32 = 0,
            PLL2FRACN: f32 = 0,
            DIVP2: f32 = 0,
            DIVP2output: f32 = 0,
            DIVQ2: f32 = 0,
            DIVQ2output: f32 = 0,
            DIVR2: f32 = 0,
            DIVR2output: f32 = 0,
            DIVN3: f32 = 0,
            PLL3FRACN: f32 = 0,
            DIVP3: f32 = 0,
            DIVP3output: f32 = 0,
            DIVQ3: f32 = 0,
            DIVQ3output: f32 = 0,
            DIVR3: f32 = 0,
            LTDCOutput: f32 = 0,
            DIVR3output: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            DAC1Output: f32 = 0,
            DAC2Output: f32 = 0,
            SPI123Mult: f32 = 0,
            SPI123output: f32 = 0,
            SAI1Mult: f32 = 0,
            DFSDMACLKoutput: f32 = 0,
            SAI1output: f32 = 0,
            SAI2BMult: f32 = 0,
            SAI2Boutput: f32 = 0,
            SAI2AMult: f32 = 0,
            SAI2Aoutput: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            I2C123Mult: f32 = 0,
            I2C123output: f32 = 0,
            I2C4Mult: f32 = 0,
            I2C4output: f32 = 0,
            SPDIFMult: f32 = 0,
            SPDIFoutput: f32 = 0,
            QSPIMult: f32 = 0,
            QSPIoutput: f32 = 0,
            FMCMult: f32 = 0,
            FMCoutput: f32 = 0,
            SWPMult: f32 = 0,
            SWPoutput: f32 = 0,
            SDMMCMult: f32 = 0,
            SDMMCoutput: f32 = 0,
            DFSDMMult: f32 = 0,
            DFSDMoutput: f32 = 0,
            DFSDM2Mult: f32 = 0,
            DFSDM2output: f32 = 0,
            USART16Mult: f32 = 0,
            USART16output: f32 = 0,
            USART234578Mult: f32 = 0,
            USART234578output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM345Mult: f32 = 0,
            LPTIM345output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            SPI6Mult: f32 = 0,
            SPI6output: f32 = 0,
            DFSDM2ACLKoutput: f32 = 0,
            SPI45Mult: f32 = 0,
            SPI45output: f32 = 0,
            USBMult: f32 = 0,
            USBoutput: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CECMult: f32 = 0,
            CECoutput: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSIDiv: ?HSIDivList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            traceClkSource: ?traceClkSourceList = null, //from extra RCC references
            CDCPRE: ?CDCPREList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            HPRE: ?HPREList = null, //from RCC Clock Config
            CDPPRE: ?CDPPREList = null, //from RCC Clock Config
            CDPPRE1: ?CDPPRE1List = null, //from RCC Clock Config
            Tim1Mul: ?f32 = null, //from RCC Clock Config
            CDPPRE2: ?CDPPRE2List = null, //from RCC Clock Config
            Tim2Mul: ?f32 = null, //from RCC Clock Config
            SRDPPRE: ?SRDPPREList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            CKPERSourceSelection: ?CKPERSourceSelectionList = null, //from RCC Clock Config
            DIVM1: ?f32 = null, //from RCC Clock Config
            DIVM2: ?f32 = null, //from RCC Clock Config
            DIVM3: ?f32 = null, //from RCC Clock Config
            DIVN1: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            DIVP1: ?DIVP1List = null, //from RCC Clock Config
            DIVQ1: ?f32 = null, //from RCC Clock Config
            DIVR1: ?f32 = null, //from RCC Clock Config
            DIVN2: ?f32 = null, //from RCC Clock Config
            PLL2FRACN: ?f32 = null, //from RCC Clock Config
            DIVP2: ?f32 = null, //from RCC Clock Config
            DIVQ2: ?f32 = null, //from RCC Clock Config
            DIVR2: ?f32 = null, //from RCC Clock Config
            DIVN3: ?f32 = null, //from RCC Clock Config
            PLL3FRACN: ?f32 = null, //from RCC Clock Config
            DIVP3: ?f32 = null, //from RCC Clock Config
            DIVQ3: ?f32 = null, //from RCC Clock Config
            DIVR3: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            SPI123CLockSelection: ?SPI123CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2BCLockSelection: ?SAI2BCLockSelectionList = null, //from RCC Clock Config
            SAI2ACLockSelection: ?SAI2ACLockSelectionList = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            I2C123CLockSelection: ?I2C123CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            QSPICLockSelection: ?QSPICLockSelectionList = null, //from RCC Clock Config
            FMCCLockSelection: ?FMCCLockSelectionList = null, //from RCC Clock Config
            SWPCLockSelection: ?SWPCLockSelectionList = null, //from RCC Clock Config
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null, //from RCC Clock Config
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null, //from RCC Clock Config
            DFSDM2CLockSelection: ?DFSDM2CLockSelectionList = null, //from RCC Clock Config
            USART16CLockSelection: ?USART16CLockSelectionList = null, //from RCC Clock Config
            USART234578CLockSelection: ?USART234578CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM345CLockSelection: ?LPTIM345CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            SPI6CLockSelection: ?SPI6CLockSelectionList = null, //from RCC Clock Config
            Spi45ClockSelection: ?Spi45ClockSelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            FDCANCLockSelection: ?FDCANCLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            CECCLockSelection: ?CECCLockSelectionList = null, //from RCC Clock Config
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null, //from RCC Advanced Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            PLL1_VCI_Range: ?PLL1_VCI_RangeList = null, //from RCC Advanced Config
            PLL2_VCI_Range: ?PLL2_VCI_RangeList = null, //from RCC Advanced Config
            PLL3_VCI_Range: ?PLL3_VCI_RangeList = null, //from RCC Advanced Config
            Prescaler: ?PrescalerList = null, //from RCC Advanced Config
            Source: ?SourceList = null, //from RCC Advanced Config
            Polarity: ?PolarityList = null, //from RCC Advanced Config
            ReloadValueType: ?ReloadValueTypeList = null, //from RCC Advanced Config
            ReloadValue: ?f32 = null, //from RCC Advanced Config
            Fsync: ?f32 = null, //from RCC Advanced Config
            ErrorLimitValue: ?f32 = null, //from RCC Advanced Config
            HSI48CalibrationValue: ?f32 = null, //from RCC Advanced Config
            CSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PLL1_VCO_SEL: ?PLL1_VCO_SELList = null, //from RCC Advanced Config
            PLL2_VCO_SEL: ?PLL2_VCO_SELList = null, //from RCC Advanced Config
            PLL3_VCO_SEL: ?PLL3_VCO_SELList = null, //from RCC Advanced Config
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            TraceEnable: ?TraceEnableList = null, //from extra RCC references
            cKPerEnable: ?cKPerEnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            SDMMC1Enable: ?SDMMC1EnableList = null, //from extra RCC references
            SAI2AEnable: ?SAI2AEnableList = null, //from extra RCC references
            SAI2BEnable: ?SAI2BEnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            SPI123Enable: ?SPI123EnableList = null, //from extra RCC references
            SPDIFEnable: ?SPDIFEnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            FMCEnable: ?FMCEnableList = null, //from extra RCC references
            OCSPIEnable: ?OCSPIEnableList = null, //from extra RCC references
            TraceEnablePll: ?TraceEnablePllList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            LPTIM345Enable: ?LPTIM345EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            SPI6Enable: ?SPI6EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            USART234578Enable: ?USART234578EnableList = null, //from extra RCC references
            USART16910Enable: ?USART16910EnableList = null, //from extra RCC references
            SPI45Enable: ?SPI45EnableList = null, //from extra RCC references
            LTDCEnable: ?LTDCEnableList = null, //from extra RCC references
            I2C4Enable: ?I2C4EnableList = null, //from extra RCC references
            I2C123Enable: ?I2C123EnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            DAC1Enable: ?DAC1EnableList = null, //from extra RCC references
            DAC2Enable: ?DAC2EnableList = null, //from extra RCC references
            EnableDFSDMAudio: ?EnableDFSDMAudioList = null, //from extra RCC references
            SWPEnable: ?SWPEnableList = null, //from extra RCC references
            DFSDMEnable: ?DFSDMEnableList = null, //from extra RCC references
            DFSDM2Enable: ?DFSDM2EnableList = null, //from extra RCC references
            SPI6OutputEnable: ?SPI6OutputEnableList = null, //from extra RCC references
            EnableDFSDM2Audio: ?EnableDFSDM2AudioList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
            PLL1QUsed: ?f32 = null, //from extra RCC references
            PLL1PUsed: ?f32 = null, //from extra RCC references
            PLL1RUsed: ?f32 = null, //from extra RCC references
            PLL2PUsed: ?f32 = null, //from extra RCC references
            PLL2QUsed: ?f32 = null, //from extra RCC references
            PLL2RUsed: ?f32 = null, //from extra RCC references
            PLL3PUsed: ?f32 = null, //from extra RCC references
            PLL3QUsed: ?f32 = null, //from extra RCC references
            PLL3RUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            VCOInput1Freq_Value: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            VCOInput2Freq_Value: ?f32 = null, //from extra RCC references
            PLL2Used: ?f32 = null, //from extra RCC references
            VCOInput3Freq_Value: ?f32 = null, //from extra RCC references
            PLL3Used: ?f32 = null, //from extra RCC references
            CSIUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            VCO1OutputFreq_Value: ?f32 = null, //from extra RCC references
            VCO2OutputFreq_Value: ?f32 = null, //from extra RCC references
            VCO3OutputFreq_Value: ?f32 = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            MCO2I2SEnable: ?MCO2I2SEnableList = null, //from extra RCC references
            cKPerUsed: ?f32 = null, //from extra RCC references
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

            var SYSCLKSOURCE_CSI: bool = false;
            var SYSCLKSOURCE_HSI: bool = false;
            var SYSCLKSOURCE_HSE: bool = false;
            var SYSCLKSOURCE_PLLCLK: bool = false;
            var MCO1SOURCE_LSE: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var MCO1SOURCE_HSI: bool = false;
            var MCO1SOURCE_RC48: bool = false;
            var MCO1SOURCE_PLLCLK: bool = false;
            var MCO2SOURCE_SYSCLK: bool = false;
            var MCO2SOURCE_PLL2PCLK: bool = false;
            var MCO2SOURCE_HSE: bool = false;
            var MCO2SOURCE_PLLCLK: bool = false;
            var MCO2SOURCE_CSI: bool = false;
            var MCO2SOURCE_LSI: bool = false;
            var TRACECLKSOURCE_HSI: bool = false;
            var TRACECLKSOURCE_CSI: bool = false;
            var TRACECLKSOURCE_HSE: bool = false;
            var TRACECLKSOURCE_PLLCLK: bool = false;
            var HCLKDiv1: bool = false;
            var CDPPRE1_1: bool = false;
            var CDPPRE1_2: bool = false;
            var CDPPRE1_4: bool = false;
            var CDPPRE2_1: bool = false;
            var CDPPRE2_2: bool = false;
            var CDPPRE2_4: bool = false;
            var PERSOURCE_HSI: bool = false;
            var PERSOURCE_CSI: bool = false;
            var PERSOURCE_HSE: bool = false;
            var SPI123CLKSOURCE_PLLQ1: bool = false;
            var SPI123CLKSOURCE_PLLP2: bool = false;
            var SPI123CLKSOURCE_PLLP3: bool = false;
            var SPI123CLKSOURCE_CKIN: bool = false;
            var SPI123CLKSOURCE_PER: bool = false;
            var SAI1CLKSOURCE_PLLQ1: bool = false;
            var SAI1CLKSOURCE_PLLP2: bool = false;
            var SAI1CLKSOURCE_PLLP3: bool = false;
            var SAI1CLKSOURCE_CKIN: bool = false;
            var SAI1CLKSOURCE_PER: bool = false;
            var SAI2BCLKSOURCE_PLLQ1: bool = false;
            var SAI2BCLKSOURCE_PLLP2: bool = false;
            var SAI2BCLKSOURCE_PLLP3: bool = false;
            var SAI2BCLKSOURCE_CKIN: bool = false;
            var SAI2BCLKSOURCE_PER: bool = false;
            var SAI2BCLKSOURCE_SPDIF: bool = false;
            var SAI2ACLKSOURCE_PLLQ1: bool = false;
            var SAI2ACLKSOURCE_PLLP2: bool = false;
            var SAI2ACLKSOURCE_PLLP3: bool = false;
            var SAI2ACLKSOURCE_CKIN: bool = false;
            var SAI2ACLKSOURCE_PER: bool = false;
            var SAI2ACLKSOURCE_SPDIF: bool = false;
            var RNGCLKSOURCE_RC48: bool = false;
            var RNGCLKSOURCE_PLLQ1: bool = false;
            var RNGCLKSOURCE_LSE: bool = false;
            var RNGCLKSOURCE_LSI: bool = false;
            var I2C123CLKSOURCE_PCLK1: bool = false;
            var I2C123CLKSOURCE_PLLR3: bool = false;
            var I2C123CLKSOURCE_HSI: bool = false;
            var I2C123CLKSOURCE_CSI: bool = false;
            var I2C4CLKSOURCE_PCLK4: bool = false;
            var I2C4CLKSOURCE_PLLR3: bool = false;
            var I2C4CLKSOURCE_HSI: bool = false;
            var I2C4CLKSOURCE_CSI: bool = false;
            var SPDIFCLKSOURCE_PLL1Q: bool = false;
            var SPDIFCLKSOURCE_PLL2R: bool = false;
            var SPDIFCLKSOURCE_PLL3R: bool = false;
            var SPDIFCLKSOURCE_HSI: bool = false;
            var QSPICLKSOURCE_HCLK3: bool = false;
            var QSPICLKSOURCE_PLL1Q: bool = false;
            var QSPICLKSOURCE_PLL2R: bool = false;
            var QSPICLKSOURCE_PER: bool = false;
            var FMCCLKSOURCE_HCLK3: bool = false;
            var FMCCLKSOURCE_PLL1Q: bool = false;
            var FMCCLKSOURCE_PLL2R: bool = false;
            var FMCCLKSOURCE_PER: bool = false;
            var SWPCLKSOURCE_HCLK1: bool = false;
            var SWPCLKSOURCE_HSI: bool = false;
            var SDMMC1CLKSOURCE_PLL1Q: bool = false;
            var SDMMC1CLKSOURCE_PLL2R: bool = false;
            var DFSDMCLKSOURCE_PCLK2: bool = false;
            var DFSDMCLKSOURCE_SYS: bool = false;
            var DFSDM2CLKSOURCE_SRDPCLK1: bool = false;
            var DFSDM2CLKSOURCE_SYS: bool = false;
            var USART16910CLKSOURCE_PCLK2: bool = false;
            var USART16910CLKSOURCE_PLLQ2: bool = false;
            var USART16910CLKSOURCE_PLLQ3: bool = false;
            var USART16910CLKSOURCE_HSI: bool = false;
            var USART16910CLKSOURCE_CSI: bool = false;
            var USART16910CLKSOURCE_LSE: bool = false;
            var USART2CLKSOURCE_PCLK1: bool = false;
            var USART2CLKSOURCE_PLLQ2: bool = false;
            var USART2CLKSOURCE_PLLQ3: bool = false;
            var USART2CLKSOURCE_HSI: bool = false;
            var USART2CLKSOURCE_CSI: bool = false;
            var USART2CLKSOURCE_LSE: bool = false;
            var LPUART1CLKSOURCE_PCLK3: bool = false;
            var LPUART1CLKSOURCE_PLL2Q: bool = false;
            var LPUART1CLKSOURCE_PLL3Q: bool = false;
            var LPUART1CLKSOURCE_HSI: bool = false;
            var LPUART1CLKSOURCE_CSI: bool = false;
            var LPUART1CLKSOURCE_LSE: bool = false;
            var LPTIM1CLKSOURCE_PCLK1: bool = false;
            var LPTIM1CLKSOURCE_PLLP2: bool = false;
            var LPTIM1CLKSOURCE_PLLR3: bool = false;
            var LPTIM1CLKSOURCE_LSE: bool = false;
            var LPTIM1CLKSOURCE_LSI: bool = false;
            var LPTIM1CLKSOURCE_PER: bool = false;
            var LPTIM345CLKSOURCE_PCLK4: bool = false;
            var LPTIM345CLKSOURCE_PLLP2: bool = false;
            var LPTIM345CLKSOURCE_PLLR3: bool = false;
            var LPTIM345CLKSOURCE_LSE: bool = false;
            var LPTIM345CLKSOURCE_LSI: bool = false;
            var LPTIM345CLKSOURCE_PER: bool = false;
            var LPTIM2CLKSOURCE_PCLK4: bool = false;
            var LPTIM2CLKSOURCE_PLLP2: bool = false;
            var LPTIM2CLKSOURCE_PLLR3: bool = false;
            var LPTIM2CLKSOURCE_LSE: bool = false;
            var LPTIM2CLKSOURCE_LSI: bool = false;
            var LPTIM2CLKSOURCE_PER: bool = false;
            var SPI6CLKSOURCE_PCLK4: bool = false;
            var SPI6CLKSOURCE_PLLQ2: bool = false;
            var SPI6CLKSOURCE_PLLQ3: bool = false;
            var SPI6CLKSOURCE_HSI: bool = false;
            var SPI6CLKSOURCE_CSI: bool = false;
            var SPI6CLKSOURCE_HSE: bool = false;
            var SPI45CLKSOURCE_PCLK1: bool = false;
            var SPI45CLKSOURCE_PLLQ2: bool = false;
            var SPI45CLKSOURCE_PLLQ3: bool = false;
            var SPI45CLKSOURCE_HSI: bool = false;
            var SPI45CLKSOURCE_CSI: bool = false;
            var SPI45CLKSOURCE_HSE: bool = false;
            var USBCLKSOURCE_PLL1Q: bool = false;
            var USBCLKSOURCE_PLL3Q: bool = false;
            var USBCLKSOURCE_RC48: bool = false;
            var FDCANCLKSOURCE_HSE: bool = false;
            var FDCANCLKSOURCE_PLL1Q: bool = false;
            var FDCANCLKSOURCE_PLL2Q: bool = false;
            var ADCCLKSOURCE_PLL2P: bool = false;
            var ADCCLKSOURCE_PLL3R: bool = false;
            var ADCCLKSOURCE_PER: bool = false;
            var CECCLKSOURCE_LSE: bool = false;
            var CECCLKSOURCE_LSI: bool = false;
            var CECCLKSOURCE_CSI: bool = false;
            var TimPrescalerEnabled: bool = false;
            var scale0: bool = false;
            var scale1: bool = false;
            var scale2: bool = false;
            var scale3: bool = false;
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
            var pll1meduim: bool = false;
            var pll1wide: bool = false;
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var TraceFreq_ValueLimit: Limit = .{};
            var CDCPREFreq_ValueLimit: Limit = .{};
            var CpuClockFreq_ValueLimit: Limit = .{};
            var CortexFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var AXIClockFreq_ValueLimit: Limit = .{};
            var HCLK3ClockFreq_ValueLimit: Limit = .{};
            var APB3Freq_ValueLimit: Limit = .{};
            var AHB12Freq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var APB4Freq_ValueLimit: Limit = .{};
            var DIVQ1Freq_ValueLimit: Limit = .{};
            var DIVR1Freq_ValueLimit: Limit = .{};
            var DIVP2Freq_ValueLimit: Limit = .{};
            var DIVQ2Freq_ValueLimit: Limit = .{};
            var DIVR2Freq_ValueLimit: Limit = .{};
            var DIVP3Freq_ValueLimit: Limit = .{};
            var DIVQ3Freq_ValueLimit: Limit = .{};
            var LTDCFreq_ValueLimit: Limit = .{};
            var DIVR3Freq_ValueLimit: Limit = .{};
            var DAC1Freq_ValueLimit: Limit = .{};
            var DAC2Freq_ValueLimit: Limit = .{};
            var SPI123Freq_ValueLimit: Limit = .{};
            var SAI1Freq_ValueLimit: Limit = .{};
            var SAI2BFreq_ValueLimit: Limit = .{};
            var SAI2AFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var I2C123Freq_ValueLimit: Limit = .{};
            var I2C4Freq_ValueLimit: Limit = .{};
            var SPDIFRXFreq_ValueLimit: Limit = .{};
            var QSPIFreq_ValueLimit: Limit = .{};
            var SDMMCFreq_ValueLimit: Limit = .{};
            var DFSDMFreq_ValueLimit: Limit = .{};
            var DFSDM2Freq_ValueLimit: Limit = .{};
            var USART16Freq_ValueLimit: Limit = .{};
            var USART234578Freq_ValueLimit: Limit = .{};
            var LPUART1Freq_ValueLimit: Limit = .{};
            var LPTIM1Freq_ValueLimit: Limit = .{};
            var LPTIM345Freq_ValueLimit: Limit = .{};
            var LPTIM2Freq_ValueLimit: Limit = .{};
            var SPI6Freq_ValueLimit: Limit = .{};
            var USBFreq_ValueLimit: Limit = .{};
            var FDCANFreq_ValueLimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var CECFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 64000000;
            };
            const HSIDivValue: ?HSIDivList = blk: {
                const conf_item = config.HSIDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAIDIVR_1 => {},
                        .RCC_PLLSAIDIVR_2 => {},
                        .RCC_PLLSAIDIVR_4 => {},
                        .RCC_PLLSAIDIVR_8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSAIDIVR_1;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass) {
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
                                "HSEByPass",
                                "HSEByPass",
                                0e0,
                                val,
                            });
                        }
                        if (val > 5e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    break :blk config_val orelse 24000000;
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
                    if (val > 5e7) {
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
                            5e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 24000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI_VALUE;
                if (config_val) |val| {
                    if (val < 3.14e4) {
                        try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val < 0e0) {
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
                            0e0,
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
            const CSI_VALUEValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 48000000;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 12288000;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_CSI => SYSCLKSOURCE_CSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SYSCLKSOURCE_HSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SYSCLKSOURCE_HSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SYSCLKSOURCE_PLLCLK = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_LSE => MCO1SOURCE_LSE = true,
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_HSI => MCO1SOURCE_HSI = true,
                        .RCC_MCO1SOURCE_HSI48 => MCO1SOURCE_RC48 = true,
                        .RCC_MCO1SOURCE_PLL1QCLK => MCO1SOURCE_PLLCLK = true,
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
                        .RCC_MCODIV_6 => {},
                        .RCC_MCODIV_7 => {},
                        .RCC_MCODIV_8 => {},
                        .RCC_MCODIV_9 => {},
                        .RCC_MCODIV_10 => {},
                        .RCC_MCODIV_11 => {},
                        .RCC_MCODIV_12 => {},
                        .RCC_MCODIV_13 => {},
                        .RCC_MCODIV_14 => {},
                        .RCC_MCODIV_15 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_SYSCLK => MCO2SOURCE_SYSCLK = true,
                        .RCC_MCO2SOURCE_PLL2PCLK => MCO2SOURCE_PLL2PCLK = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SOURCE_HSE = true,
                        .RCC_MCO2SOURCE_PLLCLK => MCO2SOURCE_PLLCLK = true,
                        .RCC_MCO2SOURCE_CSICLK => MCO2SOURCE_CSI = true,
                        .RCC_MCO2SOURCE_LSICLK => MCO2SOURCE_LSI = true,
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
                        .RCC_MCODIV_6 => {},
                        .RCC_MCODIV_7 => {},
                        .RCC_MCODIV_8 => {},
                        .RCC_MCODIV_9 => {},
                        .RCC_MCODIV_10 => {},
                        .RCC_MCODIV_11 => {},
                        .RCC_MCODIV_12 => {},
                        .RCC_MCODIV_13 => {},
                        .RCC_MCODIV_14 => {},
                        .RCC_MCODIV_15 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const traceClkSourceValue: ?traceClkSourceList = blk: {
                if (!(check_MCU("SWD") or check_MCU("JTAG")) or SYSCLKSOURCE_HSI) {
                    TRACECLKSOURCE_HSI = true;
                    const item: traceClkSourceList = .RCC_TRACECLKSOURCE_HSI;
                    break :blk item;
                } else if (SYSCLKSOURCE_CSI) {
                    TRACECLKSOURCE_CSI = true;
                    const item: traceClkSourceList = .RCC_TRACECLKSOURCE_CSI;
                    break :blk item;
                } else if (SYSCLKSOURCE_HSE) {
                    TRACECLKSOURCE_HSE = true;
                    const item: traceClkSourceList = .RCC_TRACECLKSOURCE_HSE;
                    break :blk item;
                } else if (SYSCLKSOURCE_PLLCLK) {
                    TRACECLKSOURCE_PLLCLK = true;
                    const item: traceClkSourceList = .RCC_TRACECLKSOURCE_PLLCLK;
                    break :blk item;
                }
                break :blk null;
            };
            const TraceFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    TraceFreq_ValueLimit = .{
                        .min = null,
                        .max = 4e7,
                    };
                    break :blk null;
                } else if (scale1) {
                    TraceFreq_ValueLimit = .{
                        .min = null,
                        .max = 3.5e7,
                    };
                    break :blk null;
                } else if (scale2) {
                    TraceFreq_ValueLimit = .{
                        .min = null,
                        .max = 4e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    TraceFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const CDCPREValue: ?CDCPREList = blk: {
                const conf_item = config.CDCPRE;
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
            const CDCPREFreq_ValueValue: ?f32 = blk: {
                CDCPREFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const CpuClockFreq_ValueValue: ?f32 = blk: {
                CpuClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
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
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const HPREValue: ?HPREList = blk: {
                const conf_item = config.HPRE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => {},
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                        .RCC_HCLK_DIV64 => {},
                        .RCC_HCLK_DIV128 => {},
                        .RCC_HCLK_DIV256 => {},
                        .RCC_HCLK_DIV512 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HCLK_DIV1;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const AXIClockFreq_ValueValue: ?f32 = blk: {
                AXIClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const HCLK3ClockFreq_ValueValue: ?f32 = blk: {
                HCLK3ClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const CDPPREValue: ?CDPPREList = blk: {
                const conf_item = config.CDPPRE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB3_DIV1 => {},
                        .RCC_APB3_DIV2 => {},
                        .RCC_APB3_DIV4 => {},
                        .RCC_APB3_DIV8 => {},
                        .RCC_APB3_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB3_DIV1;
            };
            const APB3Freq_ValueValue: ?f32 = blk: {
                APB3Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.4e8,
                };
                break :blk null;
            };
            const CDPPRE1Value: ?CDPPRE1List = blk: {
                const conf_item = config.CDPPRE1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB1_DIV1 => CDPPRE1_1 = true,
                        .RCC_APB1_DIV2 => CDPPRE1_2 = true,
                        .RCC_APB1_DIV4 => CDPPRE1_4 = true,
                        .RCC_APB1_DIV8 => {},
                        .RCC_APB1_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB1_DIV1;
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
            const Tim1MulValue: ?f32 = blk: {
                if (((CDPPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((CDPPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((CDPPRE1_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((CDPPRE1_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const Tim1OutputFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const AHB12Freq_ValueValue: ?f32 = blk: {
                AHB12Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.8e8,
                };
                break :blk null;
            };
            const APB1Freq_ValueValue: ?f32 = blk: {
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.4e8,
                };
                break :blk null;
            };
            const CDPPRE2Value: ?CDPPRE2List = blk: {
                const conf_item = config.CDPPRE2;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB2_DIV1 => CDPPRE2_1 = true,
                        .RCC_APB2_DIV2 => CDPPRE2_2 = true,
                        .RCC_APB2_DIV4 => CDPPRE2_4 = true,
                        .RCC_APB2_DIV8 => {},
                        .RCC_APB2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB2_DIV1;
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.4e8,
                };
                break :blk null;
            };
            const Tim2MulValue: ?f32 = blk: {
                if (((CDPPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((CDPPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((CDPPRE2_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((CDPPRE2_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const Tim2OutputFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const AHB4Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SRDPPREValue: ?SRDPPREList = blk: {
                const conf_item = config.SRDPPRE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB4_DIV1 => {},
                        .RCC_APB4_DIV2 => {},
                        .RCC_APB4_DIV4 => {},
                        .RCC_APB4_DIV8 => {},
                        .RCC_APB4_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB4_DIV1;
            };
            const APB4Freq_ValueValue: ?f32 = blk: {
                APB4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.4e8,
                };
                break :blk null;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if ((((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) and (USBCLKSOURCE_PLL3Q or USBCLKSOURCE_PLL1Q))) {
                    const item: PLLSourceList = .RCC_PLLSOURCE_HSE;
                    const conf_item = config.PLLSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PLLSource", "(((USB_OTG_FSUsed_ForRCC | USB_OTG_HSUsed_ForRCC)|USB_OTG_HSEmbeddedPHYUsed_ForRCC)& (USBCLKSOURCE_PLL3Q|USBCLKSOURCE_PLL1Q)) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => {},
                        .RCC_PLLSOURCE_CSI => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const CKPERSourceSelectionValue: ?CKPERSourceSelectionList = blk: {
                const conf_item = config.CKPERSourceSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLKPSOURCE_HSI => PERSOURCE_HSI = true,
                        .RCC_CLKPSOURCE_CSI => PERSOURCE_CSI = true,
                        .RCC_CLKPSOURCE_HSE => PERSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_CLKPSOURCE_HSI;
            };
            const CKPERFreq_ValueValue: ?f32 = blk: {
                break :blk 12288000;
            };
            const DIVM1Value: ?f32 = blk: {
                const config_val = config.DIVM1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVM1",
                            "Else",
                            "No Extra Log",
                            1,
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
                            "DIVM1",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
            };
            const DIVM2Value: ?f32 = blk: {
                const config_val = config.DIVM2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVM2",
                            "Else",
                            "No Extra Log",
                            1,
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
                            "DIVM2",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
            };
            const DIVM3Value: ?f32 = blk: {
                const config_val = config.DIVM3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVM3",
                            "Else",
                            "No Extra Log",
                            1,
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
                            "DIVM3",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
            };
            const DIVN1Value: ?f32 = blk: {
                const config_val = config.DIVN1;
                if (config_val) |val| {
                    if (val < 8) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN1",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                    if (val > 420) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN1",
                            "Else",
                            "No Extra Log",
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLLFRACNValue: ?f32 = blk: {
                const config_val = config.PLLFRACN;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLFRACN",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLFRACN",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVP1Value: ?DIVP1List = blk: {
                const conf_item = config.DIVP1;
                if (conf_item) |item| {
                    switch (item) {
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
            const DIVQ1Value: ?f32 = blk: {
                const config_val = config.DIVQ1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ1",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL1QUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLQ1 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLQ1 and config.flags.SAI2_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVQ1Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    DIVQ1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    DIVQ1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    DIVQ1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    DIVQ1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVR1Value: ?f32 = blk: {
                const config_val = config.DIVR1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR1",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL1RUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_PLLCLK and (check_MCU("SWD") or check_MCU("JTAG"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR1Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    DIVR1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    DIVR1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    DIVR1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    DIVR1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVN2Value: ?f32 = blk: {
                const config_val = config.DIVN2;
                if (config_val) |val| {
                    if (val < 8) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN2",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                    if (val > 420) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN2",
                            "Else",
                            "No Extra Log",
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLL2FRACNValue: ?f32 = blk: {
                const config_val = config.PLL2FRACN;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2FRACN",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2FRACN",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVP2Value: ?f32 = blk: {
                const config_val = config.DIVP2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP2",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP2 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP2 and config.flags.SAI2_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVP2Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    DIVP2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    DIVP2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    DIVP2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0) {
                    DIVP2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVQ2Value: ?f32 = blk: {
                const config_val = config.DIVQ2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ2",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL2QUsedValue: ?f32 = blk: {
                if ((USART16910CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVQ2Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    DIVQ2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    DIVQ2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    DIVQ2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    DIVQ2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVR2Value: ?f32 = blk: {
                const config_val = config.DIVR2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR2",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL2RUsedValue: ?f32 = blk: {
                if ((SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR2Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    DIVR2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    DIVR2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    DIVR2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    DIVR2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVN3Value: ?f32 = blk: {
                const config_val = config.DIVN3;
                if (config_val) |val| {
                    if (val < 8) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN3",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                    if (val > 420) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN3",
                            "Else",
                            "No Extra Log",
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLL3FRACNValue: ?f32 = blk: {
                const config_val = config.PLL3FRACN;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3FRACN",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3FRACN",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVP3Value: ?f32 = blk: {
                const config_val = config.DIVP3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP3",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if ((SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP3 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP3 and config.flags.SAI2_SAIAUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVP3Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    DIVP3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    DIVP3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    DIVP3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    DIVP3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVQ3Value: ?f32 = blk: {
                const config_val = config.DIVQ3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ3",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if ((USART16910CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVQ3Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    DIVQ3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    DIVQ3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    DIVQ3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    DIVQ3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DIVR3Value: ?f32 = blk: {
                const config_val = config.DIVR3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR3",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const LTDCFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    LTDCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    LTDCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    LTDCFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    LTDCFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or (I2C123CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR3Freq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    DIVR3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    DIVR3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    DIVR3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    DIVR3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                }
                break :blk 96000000;
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
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV33 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV34 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV35 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV36 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV37 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV38 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV39 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV40 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV41 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV42 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV43 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV44 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV45 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV46 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV47 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV48 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV49 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV50 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV51 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV52 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV53 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV54 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV55 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV56 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV57 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV58 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV59 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV60 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV61 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV62 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV63 => {},
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

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const DAC1Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    DAC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    DAC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    DAC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    DAC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 32000;
            };
            const DAC2Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    DAC2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    DAC2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    DAC2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    DAC2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 32000;
            };
            const SPI123CLockSelectionValue: ?SPI123CLockSelectionList = blk: {
                const conf_item = config.SPI123CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI123CLKSOURCE_PLL => SPI123CLKSOURCE_PLLQ1 = true,
                        .RCC_SPI123CLKSOURCE_PLL2 => SPI123CLKSOURCE_PLLP2 = true,
                        .RCC_SPI123CLKSOURCE_PLL3 => SPI123CLKSOURCE_PLLP3 = true,
                        .RCC_SPI123CLKSOURCE_PIN => SPI123CLKSOURCE_CKIN = true,
                        .RCC_SPI123CLKSOURCE_CLKP => SPI123CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI123CLKSOURCE_PLL;
            };
            const SPI123Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SPI123Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SPI123Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SPI123Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    SPI123Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL => SAI1CLKSOURCE_PLLQ1 = true,
                        .RCC_SAI1CLKSOURCE_PLL2 => SAI1CLKSOURCE_PLLP2 = true,
                        .RCC_SAI1CLKSOURCE_PLL3 => SAI1CLKSOURCE_PLLP3 = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1CLKSOURCE_CKIN = true,
                        .RCC_SAI1CLKSOURCE_CLKP => SAI1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAI1CLKSOURCE_PLL;
            };
            const DFSDMACLkFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    SAI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const SAI2BCLockSelectionValue: ?SAI2BCLockSelectionList = blk: {
                const conf_item = config.SAI2BCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2BCLKSOURCE_PLL => SAI2BCLKSOURCE_PLLQ1 = true,
                        .RCC_SAI2BCLKSOURCE_PLL2 => SAI2BCLKSOURCE_PLLP2 = true,
                        .RCC_SAI2BCLKSOURCE_PLL3 => SAI2BCLKSOURCE_PLLP3 = true,
                        .RCC_SAI2BCLKSOURCE_PIN => SAI2BCLKSOURCE_CKIN = true,
                        .RCC_SAI2BCLKSOURCE_CLKP => SAI2BCLKSOURCE_PER = true,
                        .RCC_SAI2BCLKSOURCE_SPDIF => SAI2BCLKSOURCE_SPDIF = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAI2BCLKSOURCE_PLL;
            };
            const SAI2BFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SAI2BFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SAI2BFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SAI2BFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    SAI2BFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const SAI2ACLockSelectionValue: ?SAI2ACLockSelectionList = blk: {
                const conf_item = config.SAI2ACLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2ACLKSOURCE_PLL => SAI2ACLKSOURCE_PLLQ1 = true,
                        .RCC_SAI2ACLKSOURCE_PLL2 => SAI2ACLKSOURCE_PLLP2 = true,
                        .RCC_SAI2ACLKSOURCE_PLL3 => SAI2ACLKSOURCE_PLLP3 = true,
                        .RCC_SAI2ACLKSOURCE_PIN => SAI2ACLKSOURCE_CKIN = true,
                        .RCC_SAI2ACLKSOURCE_CLKP => SAI2ACLKSOURCE_PER = true,
                        .RCC_SAI2ACLKSOURCE_SPDIF => SAI2ACLKSOURCE_SPDIF = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAI2ACLKSOURCE_PLL;
            };
            const SAI2AFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SAI2AFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SAI2AFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SAI2AFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    SAI2AFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_HSI48 => RNGCLKSOURCE_RC48 = true,
                        .RCC_RNGCLKSOURCE_PLL => RNGCLKSOURCE_PLLQ1 = true,
                        .RCC_RNGCLKSOURCE_LSE => RNGCLKSOURCE_LSE = true,
                        .RCC_RNGCLKSOURCE_LSI => RNGCLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_RNGCLKSOURCE_HSI48;
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const I2C123CLockSelectionValue: ?I2C123CLockSelectionList = blk: {
                const conf_item = config.I2C123CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C123CLKSOURCE_D2PCLK1 => I2C123CLKSOURCE_PCLK1 = true,
                        .RCC_I2C123CLKSOURCE_PLL3 => I2C123CLKSOURCE_PLLR3 = true,
                        .RCC_I2C123CLKSOURCE_HSI => I2C123CLKSOURCE_HSI = true,
                        .RCC_I2C123CLKSOURCE_CSI => I2C123CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C123CLKSOURCE_D2PCLK1;
            };
            const I2C123Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    I2C123Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    I2C123Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    I2C123Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    I2C123Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_D3PCLK1 => I2C4CLKSOURCE_PCLK4 = true,
                        .RCC_I2C4CLKSOURCE_PLL3 => I2C4CLKSOURCE_PLLR3 = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4CLKSOURCE_HSI = true,
                        .RCC_I2C4CLKSOURCE_CSI => I2C4CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C4CLKSOURCE_D3PCLK1;
            };
            const I2C4Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    I2C4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    I2C4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    I2C4Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    I2C4Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const SPDIFCLockSelectionValue: ?SPDIFCLockSelectionList = blk: {
                const conf_item = config.SPDIFCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPDIFRXCLKSOURCE_PLL => SPDIFCLKSOURCE_PLL1Q = true,
                        .RCC_SPDIFRXCLKSOURCE_PLL2 => SPDIFCLKSOURCE_PLL2R = true,
                        .RCC_SPDIFRXCLKSOURCE_PLL3 => SPDIFCLKSOURCE_PLL3R = true,
                        .RCC_SPDIFRXCLKSOURCE_HSI => SPDIFCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPDIFRXCLKSOURCE_PLL;
            };
            const SPDIFRXFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SPDIFRXFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SPDIFRXFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SPDIFRXFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    SPDIFRXFreq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const QSPICLockSelectionValue: ?QSPICLockSelectionList = blk: {
                const conf_item = config.QSPICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_OSPICLKSOURCE_D1HCLK => QSPICLKSOURCE_HCLK3 = true,
                        .RCC_OSPICLKSOURCE_PLL => QSPICLKSOURCE_PLL1Q = true,
                        .RCC_OSPICLKSOURCE_PLL2 => QSPICLKSOURCE_PLL2R = true,
                        .RCC_OSPICLKSOURCE_CLKP => QSPICLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_QSPICLKSOURCE_D1HCLK;
            };
            const QSPIFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    QSPIFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    QSPIFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    QSPIFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    QSPIFreq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const FMCCLockSelectionValue: ?FMCCLockSelectionList = blk: {
                const conf_item = config.FMCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FMCCLKSOURCE_D1HCLK => FMCCLKSOURCE_HCLK3 = true,
                        .RCC_FMCCLKSOURCE_PLL => FMCCLKSOURCE_PLL1Q = true,
                        .RCC_FMCCLKSOURCE_PLL2 => FMCCLKSOURCE_PLL2R = true,
                        .RCC_FMCCLKSOURCE_CLKP => FMCCLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_FMCCLKSOURCE_D1HCLK;
            };
            const FMCFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SWPCLockSelectionValue: ?SWPCLockSelectionList = blk: {
                const conf_item = config.SWPCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SWPMI1CLKSOURCE_D2PCLK1 => SWPCLKSOURCE_HCLK1 = true,
                        .RCC_SWPMI1CLKSOURCE_HSI => SWPCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SWPMI1CLKSOURCE_D2PCLK1;
            };
            const SWPMI1Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SDMMC1CLockSelectionValue: ?SDMMC1CLockSelectionList = blk: {
                const conf_item = config.SDMMC1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMCCLKSOURCE_PLL => SDMMC1CLKSOURCE_PLL1Q = true,
                        .RCC_SDMMCCLKSOURCE_PLL2 => SDMMC1CLKSOURCE_PLL2R = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDMMCCLKSOURCE_PLL;
            };
            const SDMMCFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    SDMMCFreq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DFSDMCLockSelectionValue: ?DFSDMCLockSelectionList = blk: {
                const conf_item = config.DFSDMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1CLKSOURCE_D2PCLK1 => DFSDMCLKSOURCE_PCLK2 = true,
                        .RCC_DFSDM1CLKSOURCE_SYS => DFSDMCLKSOURCE_SYS = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM1CLKSOURCE_D2PCLK1;
            };
            const DFSDMFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    DFSDMFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    DFSDMFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    DFSDMFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    DFSDMFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DFSDM2CLockSelectionValue: ?DFSDM2CLockSelectionList = blk: {
                const conf_item = config.DFSDM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM2CLKSOURCE_SRDPCLK1 => DFSDM2CLKSOURCE_SRDPCLK1 = true,
                        .RCC_DFSDM2CLKSOURCE_SYS => DFSDM2CLKSOURCE_SYS = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM1CLKSOURCE_D2PCLK1;
            };
            const DFSDM2Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    DFSDM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    DFSDM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    DFSDM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    DFSDM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const USART16CLockSelectionValue: ?USART16CLockSelectionList = blk: {
                const conf_item = config.USART16CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART16910CLKSOURCE_D2PCLK2 => USART16910CLKSOURCE_PCLK2 = true,
                        .RCC_USART16910CLKSOURCE_PLL2 => USART16910CLKSOURCE_PLLQ2 = true,
                        .RCC_USART16910CLKSOURCE_PLL3 => USART16910CLKSOURCE_PLLQ3 = true,
                        .RCC_USART16910CLKSOURCE_HSI => USART16910CLKSOURCE_HSI = true,
                        .RCC_USART16910CLKSOURCE_CSI => USART16910CLKSOURCE_CSI = true,
                        .RCC_USART16910CLKSOURCE_LSE => USART16910CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART16910CLKSOURCE_D2PCLK2;
            };
            const USART16Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    USART16Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    USART16Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    USART16Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    USART16Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const USART234578CLockSelectionValue: ?USART234578CLockSelectionList = blk: {
                const conf_item = config.USART234578CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART234578CLKSOURCE_D2PCLK1 => USART2CLKSOURCE_PCLK1 = true,
                        .RCC_USART234578CLKSOURCE_PLL2 => USART2CLKSOURCE_PLLQ2 = true,
                        .RCC_USART234578CLKSOURCE_PLL3 => USART2CLKSOURCE_PLLQ3 = true,
                        .RCC_USART234578CLKSOURCE_HSI => USART2CLKSOURCE_HSI = true,
                        .RCC_USART234578CLKSOURCE_CSI => USART2CLKSOURCE_CSI = true,
                        .RCC_USART234578CLKSOURCE_LSE => USART2CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART234578CLKSOURCE_D2PCLK1;
            };
            const USART234578Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    USART234578Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    USART234578Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    USART234578Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    USART234578Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_D3PCLK1 => LPUART1CLKSOURCE_PCLK3 = true,
                        .RCC_LPUART1CLKSOURCE_PLL2 => LPUART1CLKSOURCE_PLL2Q = true,
                        .RCC_LPUART1CLKSOURCE_PLL3 => LPUART1CLKSOURCE_PLL3Q = true,
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1CLKSOURCE_HSI = true,
                        .RCC_LPUART1CLKSOURCE_CSI => LPUART1CLKSOURCE_CSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_D3PCLK1;
            };
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_D2PCLK1 => LPTIM1CLKSOURCE_PCLK1 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL2 => LPTIM1CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL3 => LPTIM1CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1CLKSOURCE_LSE = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1CLKSOURCE_LSI = true,
                        .RCC_LPTIM1CLKSOURCE_CLKP => LPTIM1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_D2PCLK1;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const LPTIM345CLockSelectionValue: ?LPTIM345CLockSelectionList = blk: {
                const conf_item = config.LPTIM345CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM3CLKSOURCE_D3PCLK1 => LPTIM345CLKSOURCE_PCLK4 = true,
                        .RCC_LPTIM3CLKSOURCE_PLL2 => LPTIM345CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM3CLKSOURCE_PLL3 => LPTIM345CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM3CLKSOURCE_LSE => LPTIM345CLKSOURCE_LSE = true,
                        .RCC_LPTIM3CLKSOURCE_LSI => LPTIM345CLKSOURCE_LSI = true,
                        .RCC_LPTIM3CLKSOURCE_CLKP => LPTIM345CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM3CLKSOURCE_D3PCLK1;
            };
            const LPTIM345Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    LPTIM345Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    LPTIM345Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    LPTIM345Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    LPTIM345Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_D3PCLK1 => LPTIM2CLKSOURCE_PCLK4 = true,
                        .RCC_LPTIM2CLKSOURCE_PLL2 => LPTIM2CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM2CLKSOURCE_PLL3 => LPTIM2CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2CLKSOURCE_LSE = true,
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2CLKSOURCE_LSI = true,
                        .RCC_LPTIM2CLKSOURCE_CLKP => LPTIM2CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_D3PCLK1;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const SPI6CLockSelectionValue: ?SPI6CLockSelectionList = blk: {
                const conf_item = config.SPI6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI6CLKSOURCE_D3PCLK1 => SPI6CLKSOURCE_PCLK4 = true,
                        .RCC_SPI6CLKSOURCE_PLL2 => SPI6CLKSOURCE_PLLQ2 = true,
                        .RCC_SPI6CLKSOURCE_PLL3 => SPI6CLKSOURCE_PLLQ3 = true,
                        .RCC_SPI6CLKSOURCE_HSI => SPI6CLKSOURCE_HSI = true,
                        .RCC_SPI6CLKSOURCE_CSI => SPI6CLKSOURCE_CSI = true,
                        .RCC_SPI6CLKSOURCE_HSE => SPI6CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI6CLKSOURCE_D3PCLK1;
            };
            const SPI6Freq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    SPI6Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.8e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    SPI6Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.25e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    SPI6Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.6e8,
                    };
                    break :blk null;
                } else if (scale3) {
                    SPI6Freq_ValueLimit = .{
                        .min = null,
                        .max = 8.8e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const DFSDM2ACLkFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const Spi45ClockSelectionValue: ?Spi45ClockSelectionList = blk: {
                const conf_item = config.Spi45ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI45CLKSOURCE_D2PCLK1 => SPI45CLKSOURCE_PCLK1 = true,
                        .RCC_SPI45CLKSOURCE_PLL2 => SPI45CLKSOURCE_PLLQ2 = true,
                        .RCC_SPI45CLKSOURCE_PLL3 => SPI45CLKSOURCE_PLLQ3 = true,
                        .RCC_SPI45CLKSOURCE_HSI => SPI45CLKSOURCE_HSI = true,
                        .RCC_SPI45CLKSOURCE_CSI => SPI45CLKSOURCE_CSI = true,
                        .RCC_SPI45CLKSOURCE_HSE => SPI45CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI45CLKSOURCE_D2PCLK1;
            };
            const SPI45Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL => USBCLKSOURCE_PLL1Q = true,
                        .RCC_USBCLKSOURCE_PLL3 => USBCLKSOURCE_PLL3Q = true,
                        .RCC_USBCLKSOURCE_HSI48 => USBCLKSOURCE_RC48 = true,
                    }
                }

                break :blk conf_item orelse .RCC_USBCLKSOURCE_PLL;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                USBFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
            };
            const FDCANCLockSelectionValue: ?FDCANCLockSelectionList = blk: {
                const conf_item = config.FDCANCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_HSE => FDCANCLKSOURCE_HSE = true,
                        .RCC_FDCANCLKSOURCE_PLL => FDCANCLKSOURCE_PLL1Q = true,
                        .RCC_FDCANCLKSOURCE_PLL2 => FDCANCLKSOURCE_PLL2Q = true,
                    }
                }

                break :blk conf_item orelse .RCC_FDCANCLKSOURCE_PLL;
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.4e8,
                    };
                    break :blk null;
                } else if (scale1) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.125e8,
                    };
                    break :blk null;
                } else if (scale2) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_PLL2 => ADCCLKSOURCE_PLL2P = true,
                        .RCC_ADCCLKSOURCE_PLL3 => ADCCLKSOURCE_PLL3R = true,
                        .RCC_ADCCLKSOURCE_CLKP => ADCCLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADCCLKSOURCE_PLL2;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                ADCFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };
                break :blk null;
            };
            const CECCLockSelectionValue: ?CECCLockSelectionList = blk: {
                const conf_item = config.CECCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_LSE => CECCLKSOURCE_LSE = true,
                        .RCC_CECCLKSOURCE_LSI => CECCLKSOURCE_LSI = true,
                        .RCC_CECCLKSOURCE_CSI => CECCLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_CECCLKSOURCE_LSI;
            };
            const CECFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 6.6e7,
                    };
                    break :blk null;
                } else if (scale1) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 6.6e7,
                    };
                    break :blk null;
                } else if (scale2) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 6.6e7,
                    };
                    break :blk null;
                } else if (scale3) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.4e7,
                    };
                    break :blk null;
                }
                break :blk 96000000;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.62e0) {
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
                            1.62e0,
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
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if ((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 88000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 88000000, .@"="))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE3;
                } else if (((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 160000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 160000000, .@"="))) and (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 88000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                } else if (((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 225000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 225000000, .@"="))) and (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 160000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                } else if (((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 280000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 280000000, .@"="))) and (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 225000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE0;
                } else if ((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 280000000, .@">"))) {
                    scale0 = true;
                    const item: PWR_Regulator_Voltage_ScaleList = .PWR_REGULATOR_VOLTAGE_SCALE0;
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
                            , .{ "PWR_Regulator_Voltage_Scale", "(CpuClockFreq_Value > 280000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
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
                if (config.flags.CRSActivatedSourceLSE or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC)) or (config.flags.MCO1Config and MCO1SOURCE_LSE) or (LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1Used_ForRCC) or (CECCLKSOURCE_LSE and config.flags.CECUsed_ForRCC) or (RNGCLKSOURCE_LSE and config.flags.RNGUsed_ForRCC) or (LPTIM2CLKSOURCE_LSE and config.flags.LPTIM2Used_ForRCC) or (LPUART1CLKSOURCE_LSE and config.flags.LPUARTUsed_ForRCC) or (USART16910CLKSOURCE_LSE and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_LSE and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPTIM345CLKSOURCE_LSE and (config.flags.LPTIM3Used_ForRCC))) {
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
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 252000000, .@">")))) {
                    const item: FLatencyList = .FLASH_LATENCY_6;
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 252000000))", "No Extra Log", "FLASH_LATENCY_6", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 210000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 210000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_5;
                } else if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 168000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_4;
                } else if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 126000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 126000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 84000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 84000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale0 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 42000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 42000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale1 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 190000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 190000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_5;
                } else if ((scale1 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 152000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 152000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_4;
                } else if ((scale1 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 114000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 114000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale1 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 76000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 76000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale1 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 38000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 38000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale2 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 136000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale2 &  (HCLKFreq_Value > 136000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_4;
                } else if ((scale2 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 102000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale2 &  (HCLKFreq_Value > 102000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale2 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 68000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale2 &  (HCLKFreq_Value > 68000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale2 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 34000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale2 &  (HCLKFreq_Value > 34000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale3 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale3 &  (HCLKFreq_Value > 66000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_3;
                } else if ((scale3 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale3 &  (HCLKFreq_Value > 44000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale3 and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@">")))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_4 => {},
                            .FLASH_LATENCY_5 => {},
                            .FLASH_LATENCY_6 => {},
                            else => {
                                try comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_4
                                    \\ - FLASH_LATENCY_5
                                    \\ - FLASH_LATENCY_6
                                , .{ "FLatency", "(scale3 &  (HCLKFreq_Value > 22000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
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
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
            };
            const VCOInput1Freq_ValueValue: ?f32 = blk: {
                if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2ACLKSOURCE_PLLQ1 and config.flags.SAI2_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))) {
                    const config_val = config.VCOInput1Freq_Value;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput1Freq_Value",
                                "(SYSCLKSOURCE_PLLCLK)|((RCC_MCO1Source=RCC_MCO1SOURCE_PLL1QCLK)& (MCO1Config))|((RCC_MCO2Source=RCC_MCO2SOURCE_PLLCLK)& MCO2Config)|(SPI123CLKSOURCE_PLLQ1&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLQ1& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2ACLKSOURCE_PLLQ1&SAI2_SAIAUsed_ForRCC )|(RNGCLKSOURCE_PLLQ1&RNGUsed_ForRCC)|(SPDIFCLKSOURCE_PLL1Q& (SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL1Q & (OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL1Q& FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL1Q&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC ))|(USBCLKSOURCE_PLL1Q & (USB_OTG_FSUsed_ForRCC | USB_OTG_HSUsed_ForRCC)|USB_OTG_HSEmbeddedPHYUsed_ForRCC)|(FDCANCLKSOURCE_PLL1Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))",
                                "No Extra Log",
                                1e6,
                                val,
                            });
                        }
                        if (val > 1.6e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput1Freq_Value",
                                "(SYSCLKSOURCE_PLLCLK)|((RCC_MCO1Source=RCC_MCO1SOURCE_PLL1QCLK)& (MCO1Config))|((RCC_MCO2Source=RCC_MCO2SOURCE_PLLCLK)& MCO2Config)|(SPI123CLKSOURCE_PLLQ1&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLQ1& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2ACLKSOURCE_PLLQ1&SAI2_SAIAUsed_ForRCC )|(RNGCLKSOURCE_PLLQ1&RNGUsed_ForRCC)|(SPDIFCLKSOURCE_PLL1Q& (SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL1Q & (OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL1Q& FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL1Q&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC ))|(USBCLKSOURCE_PLL1Q & (USB_OTG_FSUsed_ForRCC | USB_OTG_HSUsed_ForRCC)|USB_OTG_HSEmbeddedPHYUsed_ForRCC)|(FDCANCLKSOURCE_PLL1Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))",
                                "No Extra Log",
                                1.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCOInput1Freq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCOInput1Freq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_PLLCLK and (check_MCU("SWD") or check_MCU("JTAG")) or (SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLQ1 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLQ1 and config.flags.SAI2_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 2000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 2000000, .@">") or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 2000000, .@"="))) and (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 4000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 8000000, .@"="))) and ((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 16000000, .@"=")))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                break :blk item;
            };
            const VCOInput2Freq_ValueValue: ?f32 = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP2 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP2 and config.flags.SAI2_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (USART16910CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    const config_val = config.VCOInput2Freq_Value;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput2Freq_Value",
                                " ((MCO2SOURCE_PLL2PCLK)& (MCO2Config))|(SPI123CLKSOURCE_PLLP2&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLP2& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLP2&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLP2&SAI2_SAIAUsed_ForRCC ) |(LPTIM1CLKSOURCE_PLLP2 & LPTIM1Used_ForRCC)|(LPTIM345CLKSOURCE_PLLP2&(LPTIM3Used_ForRCC))|(LPTIM2CLKSOURCE_PLLP2&LPTIM2Used_ForRCC)|(ADCCLKSOURCE_PLL2P&((USE_ADC1&ADC1UsedAsynchronousCLK_ForRCC)|(USE_ADC2&ADC2UsedAsynchronousCLK_ForRCC)))|(USART16910CLKSOURCE_PLLQ2&(USART6Used_ForRCC|USART1Used_ForRCC|UART9Used_ForRCC|USART10Used_ForRCC))|(USART2CLKSOURCE_PLLQ2& (USART3Used_ForRCC|USART2Used_ForRCC|UART4Used_ForRCC|UART7Used_ForRCC|UART8Used_ForRCC|UART5Used_ForRCC))|(LPUART1CLKSOURCE_PLL2Q&LPUARTUsed_ForRCC)|(SPI6CLKSOURCE_PLLQ2&(SPI6Used_ForRCC|(DFSDM2Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM2)))|(SPI45CLKSOURCE_PLLQ2&(SPI4Used_ForRCC|SPI5Used_ForRCC))|(FDCANCLKSOURCE_PLL2Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))|(SPDIFCLKSOURCE_PLL2R&(SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL2R&(OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL2R&FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL2R&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC))",
                                "No Extra Log",
                                1e6,
                                val,
                            });
                        }
                        if (val > 1.6e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput2Freq_Value",
                                " ((MCO2SOURCE_PLL2PCLK)& (MCO2Config))|(SPI123CLKSOURCE_PLLP2&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLP2& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLP2&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLP2&SAI2_SAIAUsed_ForRCC ) |(LPTIM1CLKSOURCE_PLLP2 & LPTIM1Used_ForRCC)|(LPTIM345CLKSOURCE_PLLP2&(LPTIM3Used_ForRCC))|(LPTIM2CLKSOURCE_PLLP2&LPTIM2Used_ForRCC)|(ADCCLKSOURCE_PLL2P&((USE_ADC1&ADC1UsedAsynchronousCLK_ForRCC)|(USE_ADC2&ADC2UsedAsynchronousCLK_ForRCC)))|(USART16910CLKSOURCE_PLLQ2&(USART6Used_ForRCC|USART1Used_ForRCC|UART9Used_ForRCC|USART10Used_ForRCC))|(USART2CLKSOURCE_PLLQ2& (USART3Used_ForRCC|USART2Used_ForRCC|UART4Used_ForRCC|UART7Used_ForRCC|UART8Used_ForRCC|UART5Used_ForRCC))|(LPUART1CLKSOURCE_PLL2Q&LPUARTUsed_ForRCC)|(SPI6CLKSOURCE_PLLQ2&(SPI6Used_ForRCC|(DFSDM2Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM2)))|(SPI45CLKSOURCE_PLLQ2&(SPI4Used_ForRCC|SPI5Used_ForRCC))|(FDCANCLKSOURCE_PLL2Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))|(SPDIFCLKSOURCE_PLL2R&(SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL2R&(OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL2R&FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL2R&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC))",
                                "No Extra Log",
                                1.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCOInput2Freq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCOInput2Freq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP2 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP2 and config.flags.SAI2_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (USART16910CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1600000, .@"<")) and ((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                break :blk item;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or (SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP3 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP3 and config.flags.SAI2_SAIAUsed_ForRCC) or (USART16910CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (I2C123CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput3Freq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const config_val = config.VCOInput3Freq_Value;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput3Freq_Value",
                                "PLL3Used=1",
                                "No Extra Log",
                                1e6,
                                val,
                            });
                        }
                        if (val > 1.6e7) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCOInput3Freq_Value",
                                "PLL3Used=1",
                                "No Extra Log",
                                1.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCOInput3Freq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCOInput3Freq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLL3_VCI_RangeValue: ?PLL3_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 2000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 2000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 2000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"="))) and ((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                break :blk item;
            };
            const PrescalerValue: ?PrescalerList = blk: {
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.Prescaler) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Prescaler", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceGPIO) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_PIN;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceLSE) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_LSE;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB2;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB and (config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB1;
                    break :blk item;
                }
                const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB1;
                break :blk item;
            };
            const PolarityValue: ?PolarityList = blk: {
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.Polarity) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Polarity", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.ReloadValueType) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValueType", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.ReloadValue) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ReloadValue", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.Fsync) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "Fsync", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
                    }
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceGPIO) {
                    const config_val = config.extra.Fsync;
                    if (config_val) |val| {
                        if (val < 1) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.ErrorLimitValue) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "ErrorLimitValue", "!CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.HSI48CalibrationValue) |_| {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Value should be null.
                            \\note: some configurations are invalid in certain cases.
                            \\
                            \\
                        , .{ "HSI48CalibrationValue", " !CRSActivatedSourceLSE & !CRSActivatedSourceUSB & !CRSActivatedSourceGPIO", "No Extra Log" });
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
            const cKPerUsedValue: ?f32 = blk: {
                if ((QSPICLKSOURCE_PER and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PER and config.flags.FMCUsed_ForRCC) or (SAI1CLKSOURCE_PER and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (LPTIM1CLKSOURCE_PER and config.flags.LPTIM1Used_ForRCC) or (SAI2BCLKSOURCE_PER and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PER and config.flags.SAI2_SAIAUsed_ForRCC) or (ADCCLKSOURCE_PER and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (LPTIM2CLKSOURCE_PER and config.flags.LPTIM2Used_ForRCC) or (SPI123CLKSOURCE_PER and (config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (LPTIM345CLKSOURCE_PER and (config.flags.LPTIM3Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const CSIUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_CSI and (check_MCU("SWD") or check_MCU("JTAG")) or (config.flags.MCO2Config and MCO2SOURCE_CSI) or (check_MCU("PLLSOURCE_CSI") and ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) or (config.flags.MCO2Config and MCO2SOURCE_PLL2PCLK))) or (PERSOURCE_CSI and (check_ref(@TypeOf(cKPerUsedValue), cKPerUsedValue, 1, .@"="))) or (SYSCLKSOURCE_CSI) or (I2C4CLKSOURCE_CSI and config.flags.I2C4Used_ForRCC) or (I2C123CLKSOURCE_CSI and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (USART16910CLKSOURCE_CSI and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_CSI and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPUART1CLKSOURCE_CSI and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_CSI and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_CSI and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (CECCLKSOURCE_CSI and config.flags.CECUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const CSICalibrationValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(CSIUsedValue), CSIUsedValue, 1, .@"=")) {
                    const config_val = config.extra.CSICalibrationValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "CSICalibrationValue",
                                "CSIUsed=1",
                                "CSI used",
                                0,
                                val,
                            });
                        }
                        if (val > 31) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "CSICalibrationValue",
                                "CSIUsed=1",
                                "CSI used",
                                31,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
                }
                const config_val = config.extra.CSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "CSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 31) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "CSICalibrationValue",
                            "Else",
                            "No Extra Log",
                            31,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const HSIUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_HSI and (check_MCU("SWD") or check_MCU("JTAG")) or (config.flags.MCO1Config and MCO1SOURCE_HSI) or (check_MCU("PLLSOURCE_HSI") and ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) or (config.flags.MCO2Config and MCO2SOURCE_PLL2PCLK))) or (PERSOURCE_HSI and (check_ref(@TypeOf(cKPerUsedValue), cKPerUsedValue, 1, .@"="))) or (SYSCLKSOURCE_HSI) or (I2C4CLKSOURCE_HSI and config.flags.I2C4Used_ForRCC) or (I2C123CLKSOURCE_HSI and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (SPDIFCLKSOURCE_HSI and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (SWPCLKSOURCE_HSI and config.flags.SWPMI1Used_ForRCC) or (USART16910CLKSOURCE_HSI and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_HSI and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPUART1CLKSOURCE_HSI and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_HSI and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_HSI and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC))) {
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
            const VCO1OutputFreq_ValueValue: ?f32 = blk: {
                if ((((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLQ1 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLQ1 and config.flags.SAI2_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))))) {
                    const config_val = config.VCO1OutputFreq_Value;
                    if (config_val) |val| {
                        if (val < 1.28e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO1OutputFreq_Value",
                                "(((SYSCLKSOURCE_PLLCLK)|((RCC_MCO1Source=RCC_MCO1SOURCE_PLL1QCLK)& (MCO1Config))|((RCC_MCO2Source=RCC_MCO2SOURCE_PLLCLK)& MCO2Config)|(SPI123CLKSOURCE_PLLQ1&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLQ1& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLQ1&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLQ1&SAI2_SAIAUsed_ForRCC )|(RNGCLKSOURCE_PLLQ1&RNGUsed_ForRCC)|(SPDIFCLKSOURCE_PLL1Q& (SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL1Q & (OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL1Q& FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL1Q&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC) )|(USBCLKSOURCE_PLL1Q & (USB_OTG_FSUsed_ForRCC | USB_OTG_HSUsed_ForRCC)|USB_OTG_HSEmbeddedPHYUsed_ForRCC)|(FDCANCLKSOURCE_PLL1Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))))",
                                "No Extra Log",
                                1.28e8,
                                val,
                            });
                        }
                        if (val > 5.6e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO1OutputFreq_Value",
                                "(((SYSCLKSOURCE_PLLCLK)|((RCC_MCO1Source=RCC_MCO1SOURCE_PLL1QCLK)& (MCO1Config))|((RCC_MCO2Source=RCC_MCO2SOURCE_PLLCLK)& MCO2Config)|(SPI123CLKSOURCE_PLLQ1&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLQ1& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLQ1&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLQ1&SAI2_SAIAUsed_ForRCC )|(RNGCLKSOURCE_PLLQ1&RNGUsed_ForRCC)|(SPDIFCLKSOURCE_PLL1Q& (SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL1Q & (OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL1Q& FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL1Q&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC) )|(USBCLKSOURCE_PLL1Q & (USB_OTG_FSUsed_ForRCC | USB_OTG_HSUsed_ForRCC)|USB_OTG_HSEmbeddedPHYUsed_ForRCC)|(FDCANCLKSOURCE_PLL1Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))))",
                                "No Extra Log",
                                5.6e8,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCO1OutputFreq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCO1OutputFreq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLL1_VCO_SELValue: ?PLL1_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput1Freq_ValueValue), VCOInput1Freq_ValueValue, 2000000, .@"<")) and ((check_ref(@TypeOf(VCO1OutputFreq_ValueValue), VCO1OutputFreq_ValueValue, 150000000, .@">")) or (check_ref(@TypeOf(VCO1OutputFreq_ValueValue), VCO1OutputFreq_ValueValue, 150000000, .@"="))) and ((check_ref(@TypeOf(VCO1OutputFreq_ValueValue), VCO1OutputFreq_ValueValue, 420000000, .@">") or (check_ref(@TypeOf(VCO1OutputFreq_ValueValue), VCO1OutputFreq_ValueValue, 420000000, .@"=")))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    pll1meduim = true;
                    const item: PLL1_VCO_SELList = .RCC_PLL1VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    pll1wide = true;
                    const item: PLL1_VCO_SELList = .RCC_PLL1VCOWIDE;
                    break :blk item;
                }
                const item: PLL1_VCO_SELList = .RCC_PLL1VCOWIDE;
                break :blk item;
            };
            const VCO2OutputFreq_ValueValue: ?f32 = blk: {
                if ((((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI2BCLKSOURCE_PLLP2 and config.flags.SAI2_SAIBUsed_ForRCC) or (SAI2ACLKSOURCE_PLLP2 and config.flags.SAI2_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (USART16910CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")))) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC and SAI2ACLKSOURCE_SPDIF) or (config.flags.SAI2_SAIBUsed_ForRCC and SAI2BCLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)))) {
                    const config_val = config.VCO2OutputFreq_Value;
                    if (config_val) |val| {
                        if (val < 1.28e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO2OutputFreq_Value",
                                " (((MCO2SOURCE_PLL2PCLK)& (MCO2Config))|(SPI123CLKSOURCE_PLLP2&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLP2& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLP2&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLP2&SAI2_SAIAUsed_ForRCC ) |(LPTIM1CLKSOURCE_PLLP2 & LPTIM1Used_ForRCC)|(LPTIM345CLKSOURCE_PLLP2&(LPTIM3Used_ForRCC))|(LPTIM2CLKSOURCE_PLLP2&LPTIM2Used_ForRCC)|(ADCCLKSOURCE_PLL2P&((USE_ADC1&ADC1UsedAsynchronousCLK_ForRCC)|(USE_ADC2&ADC2UsedAsynchronousCLK_ForRCC)))|(USART16910CLKSOURCE_PLLQ2&(USART6Used_ForRCC|USART1Used_ForRCC|UART9Used_ForRCC|USART10Used_ForRCC))|(USART2CLKSOURCE_PLLQ2& (USART3Used_ForRCC|USART2Used_ForRCC|UART4Used_ForRCC|UART7Used_ForRCC|UART8Used_ForRCC|UART5Used_ForRCC))|(LPUART1CLKSOURCE_PLL2Q&LPUARTUsed_ForRCC)|(SPI6CLKSOURCE_PLLQ2&(SPI6Used_ForRCC|(DFSDM2Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM2)))|(SPI45CLKSOURCE_PLLQ2&(SPI4Used_ForRCC|SPI5Used_ForRCC))|(FDCANCLKSOURCE_PLL2Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))|(SPDIFCLKSOURCE_PLL2R&(SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL2R&(OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL2R&FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL2R&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC)))",
                                "No Extra Log",
                                1.28e8,
                                val,
                            });
                        }
                        if (val > 5.6e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO2OutputFreq_Value",
                                " (((MCO2SOURCE_PLL2PCLK)& (MCO2Config))|(SPI123CLKSOURCE_PLLP2&(I2S1Used_ForRCC|I2S2Used_ForRCC|I2S3Used_ForRCC|SPI1Used_ForRCC|SPI2Used_ForRCC|SPI3Used_ForRCC))|(SAI1CLKSOURCE_PLLP2& (SAI1_SAIAUsed_ForRCC|SAI1_SAIBUsed_ForRCC|(DFSDM1Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM1)))|(SAI2BCLKSOURCE_PLLP2&SAI2_SAIBUsed_ForRCC )|(SAI2ACLKSOURCE_PLLP2&SAI2_SAIAUsed_ForRCC ) |(LPTIM1CLKSOURCE_PLLP2 & LPTIM1Used_ForRCC)|(LPTIM345CLKSOURCE_PLLP2&(LPTIM3Used_ForRCC))|(LPTIM2CLKSOURCE_PLLP2&LPTIM2Used_ForRCC)|(ADCCLKSOURCE_PLL2P&((USE_ADC1&ADC1UsedAsynchronousCLK_ForRCC)|(USE_ADC2&ADC2UsedAsynchronousCLK_ForRCC)))|(USART16910CLKSOURCE_PLLQ2&(USART6Used_ForRCC|USART1Used_ForRCC|UART9Used_ForRCC|USART10Used_ForRCC))|(USART2CLKSOURCE_PLLQ2& (USART3Used_ForRCC|USART2Used_ForRCC|UART4Used_ForRCC|UART7Used_ForRCC|UART8Used_ForRCC|UART5Used_ForRCC))|(LPUART1CLKSOURCE_PLL2Q&LPUARTUsed_ForRCC)|(SPI6CLKSOURCE_PLLQ2&(SPI6Used_ForRCC|(DFSDM2Used_ForRCC & SEM2RCC_SAI1_CK_REQUIRED_DFSDM2)))|(SPI45CLKSOURCE_PLLQ2&(SPI4Used_ForRCC|SPI5Used_ForRCC))|(FDCANCLKSOURCE_PLL2Q&(FDCAN1Used_ForRCC|FDCAN2Used_ForRCC))|(SPDIFCLKSOURCE_PLL2R&(SPDIFRXUsed_ForRCC|(SAI2_SAIAUsed_ForRCC & SAI2ACLKSOURCE_SPDIF) | (SAI2_SAIBUsed_ForRCC & SAI2BCLKSOURCE_SPDIF)))|(QSPICLKSOURCE_PLL2R&(OCTOSPI1Used_ForRCC | OCTOSPI2Used_ForRCC))|(FMCCLKSOURCE_PLL2R&FMCUsed_ForRCC)|(SDMMC1CLKSOURCE_PLL2R&(SDMMC1Used_ForRCC|SDMMC2Used_ForRCC)))",
                                "No Extra Log",
                                5.6e8,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCO2OutputFreq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCO2OutputFreq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLL2_VCO_SELValue: ?PLL2_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@"<")) and ((check_ref(@TypeOf(VCO2OutputFreq_ValueValue), VCO2OutputFreq_ValueValue, 150000000, .@">")) or (check_ref(@TypeOf(VCO2OutputFreq_ValueValue), VCO2OutputFreq_ValueValue, 150000000, .@"="))) and ((check_ref(@TypeOf(VCO2OutputFreq_ValueValue), VCO2OutputFreq_ValueValue, 420000000, .@">") or (check_ref(@TypeOf(VCO2OutputFreq_ValueValue), VCO2OutputFreq_ValueValue, 420000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL2VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL2VCOWIDE;
                    break :blk item;
                }
                const item: PLL2_VCO_SELList = .RCC_PLL2VCOWIDE;
                break :blk item;
            };
            const VCO3OutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const config_val = config.VCO3OutputFreq_Value;
                    if (config_val) |val| {
                        if (val < 1.28e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO3OutputFreq_Value",
                                "PLL3Used=1",
                                "No Extra Log",
                                1.28e8,
                                val,
                            });
                        }
                        if (val > 5.6e8) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VCO3OutputFreq_Value",
                                "PLL3Used=1",
                                "No Extra Log",
                                5.6e8,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 96000000;
                }
                if (config.VCO3OutputFreq_Value) |val| {
                    if (val != 9.6e7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
                            \\
                        , .{
                            "VCO3OutputFreq_Value",
                            "Else",
                            "No Extra Log",
                            9.6e7,
                            val,
                        });
                    }
                }
                break :blk 96000000;
            };
            const PLL3_VCO_SELValue: ?PLL3_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 2000000, .@"<")) and ((check_ref(@TypeOf(VCO3OutputFreq_ValueValue), VCO3OutputFreq_ValueValue, 150000000, .@">")) or (check_ref(@TypeOf(VCO3OutputFreq_ValueValue), VCO3OutputFreq_ValueValue, 150000000, .@"="))) and ((check_ref(@TypeOf(VCO3OutputFreq_ValueValue), VCO3OutputFreq_ValueValue, 420000000, .@">") or (check_ref(@TypeOf(VCO3OutputFreq_ValueValue), VCO3OutputFreq_ValueValue, 420000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL3VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL3VCOWIDE;
                    break :blk item;
                }
                const item: PLL3_VCO_SELList = .RCC_PLL3VCOWIDE;
                break :blk item;
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
            const MCO1OutPutEnableValue: ?MCO1OutPutEnableList = blk: {
                if (config.flags.MCO1Config) {
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
            const TraceEnableValue: ?TraceEnableList = blk: {
                const item: TraceEnableList = .auto;
                break :blk item;
            };
            const cKPerEnableValue: ?cKPerEnableList = blk: {
                if (((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (config.flags.FMCUsed_ForRCC) or (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (config.flags.LPTIM1Used_ForRCC) or (config.flags.SAI2_SAIBUsed_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC) or (((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (config.flags.LPTIM2Used_ForRCC) or (config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or (config.flags.LPTIM3Used_ForRCC)) {
                    const item: cKPerEnableList = .true;
                    break :blk item;
                }
                const item: cKPerEnableList = .false;
                break :blk item;
            };
            const SAI1EnableValue: ?SAI1EnableList = blk: {
                if (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                }
                const item: SAI1EnableList = .false;
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
            const SDMMC1EnableValue: ?SDMMC1EnableList = blk: {
                if (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) {
                    const item: SDMMC1EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC1EnableList = .false;
                break :blk item;
            };
            const SAI2AEnableValue: ?SAI2AEnableList = blk: {
                if (config.flags.SAI2_SAIAUsed_ForRCC) {
                    const item: SAI2AEnableList = .true;
                    break :blk item;
                }
                const item: SAI2AEnableList = .false;
                break :blk item;
            };
            const SAI2BEnableValue: ?SAI2BEnableList = blk: {
                if (config.flags.SAI2_SAIBUsed_ForRCC) {
                    const item: SAI2BEnableList = .true;
                    break :blk item;
                }
                const item: SAI2BEnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const SPI123EnableValue: ?SPI123EnableList = blk: {
                if (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC) {
                    const item: SPI123EnableList = .true;
                    break :blk item;
                }
                const item: SPI123EnableList = .false;
                break :blk item;
            };
            const SPDIFEnableValue: ?SPDIFEnableList = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) {
                    const item: SPDIFEnableList = .true;
                    break :blk item;
                }
                const item: SPDIFEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) {
                    const item: FDCANEnableList = .true;
                    break :blk item;
                }
                const item: FDCANEnableList = .false;
                break :blk item;
            };
            const FMCEnableValue: ?FMCEnableList = blk: {
                if (config.flags.FMCUsed_ForRCC) {
                    const item: FMCEnableList = .true;
                    break :blk item;
                }
                const item: FMCEnableList = .false;
                break :blk item;
            };
            const OCSPIEnableValue: ?OCSPIEnableList = blk: {
                if (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC) {
                    const item: OCSPIEnableList = .true;
                    break :blk item;
                }
                const item: OCSPIEnableList = .false;
                break :blk item;
            };
            const TraceEnablePllValue: ?TraceEnablePllList = blk: {
                if (check_MCU("SWD") or check_MCU("JTAG")) {
                    const item: TraceEnablePllList = .true;
                    break :blk item;
                }
                const item: TraceEnablePllList = .false;
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
            const LPTIM345EnableValue: ?LPTIM345EnableList = blk: {
                if (config.flags.LPTIM3Used_ForRCC) {
                    const item: LPTIM345EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM345EnableList = .false;
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
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1Used_ForRCC) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const SPI6EnableValue: ?SPI6EnableList = blk: {
                if ((config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2"))) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2"))) {
                    const item: SPI6EnableList = .true;
                    break :blk item;
                }
                const item: SPI6EnableList = .false;
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
            const USART234578EnableValue: ?USART234578EnableList = blk: {
                if (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) {
                    const item: USART234578EnableList = .true;
                    break :blk item;
                }
                const item: USART234578EnableList = .false;
                break :blk item;
            };
            const USART16910EnableValue: ?USART16910EnableList = blk: {
                if (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC) {
                    const item: USART16910EnableList = .true;
                    break :blk item;
                }
                const item: USART16910EnableList = .false;
                break :blk item;
            };
            const SPI45EnableValue: ?SPI45EnableList = blk: {
                if (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC) {
                    const item: SPI45EnableList = .true;
                    break :blk item;
                }
                const item: SPI45EnableList = .false;
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
            const I2C4EnableValue: ?I2C4EnableList = blk: {
                if (config.flags.I2C4Used_ForRCC) {
                    const item: I2C4EnableList = .true;
                    break :blk item;
                }
                const item: I2C4EnableList = .false;
                break :blk item;
            };
            const I2C123EnableValue: ?I2C123EnableList = blk: {
                if (config.flags.I2C1Used_ForRCC or config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC) {
                    const item: I2C123EnableList = .true;
                    break :blk item;
                }
                const item: I2C123EnableList = .false;
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
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTCUsed_ForRCC) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
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
            const DAC1EnableValue: ?DAC1EnableList = blk: {
                if (check_MCU("DAC1")) {
                    const item: DAC1EnableList = .true;
                    break :blk item;
                }
                const item: DAC1EnableList = .false;
                break :blk item;
            };
            const DAC2EnableValue: ?DAC2EnableList = blk: {
                if (check_MCU("DAC2")) {
                    const item: DAC2EnableList = .true;
                    break :blk item;
                }
                const item: DAC2EnableList = .false;
                break :blk item;
            };
            const EnableDFSDMAudioValue: ?EnableDFSDMAudioList = blk: {
                if (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")) {
                    const item: EnableDFSDMAudioList = .true;
                    break :blk item;
                }
                const item: EnableDFSDMAudioList = .false;
                break :blk item;
            };
            const SWPEnableValue: ?SWPEnableList = blk: {
                if (config.flags.SWPMI1Used_ForRCC) {
                    const item: SWPEnableList = .true;
                    break :blk item;
                }
                const item: SWPEnableList = .false;
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
            const DFSDM2EnableValue: ?DFSDM2EnableList = blk: {
                if (config.flags.DFSDM2Used_ForRCC) {
                    const item: DFSDM2EnableList = .true;
                    break :blk item;
                }
                const item: DFSDM2EnableList = .false;
                break :blk item;
            };
            const SPI6OutputEnableValue: ?SPI6OutputEnableList = blk: {
                if (config.flags.SPI6Used_ForRCC) {
                    const item: SPI6OutputEnableList = .true;
                    break :blk item;
                }
                const item: SPI6OutputEnableList = .false;
                break :blk item;
            };
            const EnableDFSDM2AudioValue: ?EnableDFSDM2AudioList = blk: {
                if (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")) {
                    const item: EnableDFSDM2AudioList = .true;
                    break :blk item;
                }
                const item: EnableDFSDM2AudioList = .false;
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
            const MCO2I2SEnableValue: ?MCO2I2SEnableList = blk: {
                if ((config.flags.MCO2Config)) {
                    const item: MCO2I2SEnableList = .true;
                    break :blk item;
                }
                const item: MCO2I2SEnableList = .false;
                break :blk item;
            };

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIDiv = ClockNode{
                .name = "HSIDiv",
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

            var CSIRC = ClockNode{
                .name = "CSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var RC48 = ClockNode{
                .name = "RC48",
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

            var traceClkSource = ClockNode{
                .name = "traceClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var TraceCLKOutput = ClockNode{
                .name = "TraceCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CDCPRE = ClockNode{
                .name = "CDCPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var CDCPREOutput = ClockNode{
                .name = "CDCPREOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CpuClockOutput = ClockNode{
                .name = "CpuClockOutput",
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

            var HPRE = ClockNode{
                .name = "HPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBOutput = ClockNode{
                .name = "AHBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXIClockOutput = ClockNode{
                .name = "AXIClockOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLK3Output = ClockNode{
                .name = "HCLK3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CDPPRE = ClockNode{
                .name = "CDPPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3Output = ClockNode{
                .name = "APB3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CDPPRE1 = ClockNode{
                .name = "CDPPRE1",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim1Mul = ClockNode{
                .name = "Tim1Mul",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim1Output = ClockNode{
                .name = "Tim1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB12Output = ClockNode{
                .name = "AHB12Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1Output = ClockNode{
                .name = "APB1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CDPPRE2 = ClockNode{
                .name = "CDPPRE2",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB2Output = ClockNode{
                .name = "APB2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim2Mul = ClockNode{
                .name = "Tim2Mul",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim2Output = ClockNode{
                .name = "Tim2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB4Output = ClockNode{
                .name = "AHB4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SRDPPRE = ClockNode{
                .name = "SRDPPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB4Output = ClockNode{
                .name = "APB4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var CKPERSource = ClockNode{
                .name = "CKPERSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var CKPERoutput = ClockNode{
                .name = "CKPERoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVM1 = ClockNode{
                .name = "DIVM1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVM2 = ClockNode{
                .name = "DIVM2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVM3 = ClockNode{
                .name = "DIVM3",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN1 = ClockNode{
                .name = "DIVN1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLFRACN = ClockNode{
                .name = "PLLFRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP1 = ClockNode{
                .name = "DIVP1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ1 = ClockNode{
                .name = "DIVQ1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ1output = ClockNode{
                .name = "DIVQ1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR1 = ClockNode{
                .name = "DIVR1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR1output = ClockNode{
                .name = "DIVR1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN2 = ClockNode{
                .name = "DIVN2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2FRACN = ClockNode{
                .name = "PLL2FRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP2 = ClockNode{
                .name = "DIVP2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP2output = ClockNode{
                .name = "DIVP2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ2 = ClockNode{
                .name = "DIVQ2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ2output = ClockNode{
                .name = "DIVQ2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR2 = ClockNode{
                .name = "DIVR2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR2output = ClockNode{
                .name = "DIVR2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN3 = ClockNode{
                .name = "DIVN3",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3FRACN = ClockNode{
                .name = "PLL3FRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP3 = ClockNode{
                .name = "DIVP3",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP3output = ClockNode{
                .name = "DIVP3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ3 = ClockNode{
                .name = "DIVQ3",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ3output = ClockNode{
                .name = "DIVQ3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR3 = ClockNode{
                .name = "DIVR3",
                .nodetype = .off,
                .parents = &.{},
            };

            var LTDCOutput = ClockNode{
                .name = "LTDCOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR3output = ClockNode{
                .name = "DIVR3output",
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

            var DAC1Output = ClockNode{
                .name = "DAC1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DAC2Output = ClockNode{
                .name = "DAC2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI123Mult = ClockNode{
                .name = "SPI123Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI123output = ClockNode{
                .name = "SPI123output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1Mult = ClockNode{
                .name = "SAI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMACLKoutput = ClockNode{
                .name = "DFSDMACLKoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1output = ClockNode{
                .name = "SAI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2BMult = ClockNode{
                .name = "SAI2BMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2Boutput = ClockNode{
                .name = "SAI2Boutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2AMult = ClockNode{
                .name = "SAI2AMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI2Aoutput = ClockNode{
                .name = "SAI2Aoutput",
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

            var I2C123Mult = ClockNode{
                .name = "I2C123Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C123output = ClockNode{
                .name = "I2C123output",
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

            var SPDIFMult = ClockNode{
                .name = "SPDIFMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPDIFoutput = ClockNode{
                .name = "SPDIFoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var QSPIMult = ClockNode{
                .name = "QSPIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var QSPIoutput = ClockNode{
                .name = "QSPIoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var FMCMult = ClockNode{
                .name = "FMCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var FMCoutput = ClockNode{
                .name = "FMCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SWPMult = ClockNode{
                .name = "SWPMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SWPoutput = ClockNode{
                .name = "SWPoutput",
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

            var DFSDM2Mult = ClockNode{
                .name = "DFSDM2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDM2output = ClockNode{
                .name = "DFSDM2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART16Mult = ClockNode{
                .name = "USART16Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART16output = ClockNode{
                .name = "USART16output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART234578Mult = ClockNode{
                .name = "USART234578Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART234578output = ClockNode{
                .name = "USART234578output",
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

            var LPTIM345Mult = ClockNode{
                .name = "LPTIM345Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM345output = ClockNode{
                .name = "LPTIM345output",
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

            var SPI6Mult = ClockNode{
                .name = "SPI6Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI6output = ClockNode{
                .name = "SPI6output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDM2ACLKoutput = ClockNode{
                .name = "DFSDM2ACLKoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI45Mult = ClockNode{
                .name = "SPI45Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI45output = ClockNode{
                .name = "SPI45output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBMult = ClockNode{
                .name = "USBMult",
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

            var FDCANoutput = ClockNode{
                .name = "FDCANoutput",
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

            var CECMult = ClockNode{
                .name = "CECMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CECoutput = ClockNode{
                .name = "CECoutput",
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

            const HSIDiv_clk_value = HSIDivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIDiv",
                "Else",
                "No Extra Log",
                "HSIDiv",
            });
            HSIDiv.nodetype = .div;
            HSIDiv.value = HSIDiv_clk_value.get();
            HSIDiv.parents = &.{&HSIRC};

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
            if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
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
            }

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

            const CSIRC_clk_value = CSI_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CSIRC",
                "Else",
                "No Extra Log",
                "CSI_VALUE",
            });
            CSIRC.nodetype = .source;
            CSIRC.value = CSIRC_clk_value;

            const RC48_clk_value = HSI48_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "RC48",
                "Else",
                "No Extra Log",
                "HSI48_VALUE",
            });
            RC48.nodetype = .source;
            RC48.value = RC48_clk_value;
            if (check_ref(@TypeOf(ExtClockEnableValue), ExtClockEnableValue, .true, .@"=")) {
                const I2S_CKIN_clk_value = EXTERNAL_CLOCK_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
                &DIVP1,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                const MCO1Mult_clk_value = RCC_MCO1SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &HSIDiv,
                    &RC48,
                    &DIVQ1,
                };
                MCO1Mult.nodetype = .multi;
                MCO1Mult.parents = &.{MCO1Multparents[MCO1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                const MCO1Div_clk_value = RCC_MCODiv1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &SysCLKOutput,
                    &DIVP2,
                    &HSEOSC,
                    &DIVP1,
                    &CSIRC,
                    &LSIRC,
                };
                MCO2Mult.nodetype = .multi;
                MCO2Mult.parents = &.{MCO2Multparents[MCO2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=")) {
                const MCO2Div_clk_value = RCC_MCODiv2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(TraceEnableValue), TraceEnableValue, .true, .@"=")) {
                const traceClkSource_clk_value = traceClkSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "traceClkSource",
                    "Else",
                    "No Extra Log",
                    "traceClkSource",
                });
                const traceClkSourceparents = [_]*const ClockNode{
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                    &DIVR1,
                };
                traceClkSource.nodetype = .multi;
                traceClkSource.parents = &.{traceClkSourceparents[traceClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(TraceEnableValue), TraceEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(TraceFreq_ValueValue);
                TraceCLKOutput.limit = TraceFreq_ValueLimit;
                TraceCLKOutput.nodetype = .output;
                TraceCLKOutput.parents = &.{&traceClkSource};
            }

            const CDCPRE_clk_value = CDCPREValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CDCPRE",
                "Else",
                "No Extra Log",
                "CDCPRE",
            });
            CDCPRE.nodetype = .div;
            CDCPRE.value = CDCPRE_clk_value.get();
            CDCPRE.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(CDCPREFreq_ValueValue);
            CDCPREOutput.limit = CDCPREFreq_ValueLimit;
            CDCPREOutput.nodetype = .output;
            CDCPREOutput.parents = &.{&CDCPRE};

            std.mem.doNotOptimizeAway(CpuClockFreq_ValueValue);
            CpuClockOutput.limit = CpuClockFreq_ValueLimit;
            CpuClockOutput.nodetype = .output;
            CpuClockOutput.parents = &.{&CDCPREOutput};

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
            CortexPrescaler.parents = &.{&CDCPREOutput};

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
            CortexSysOutput.limit = CortexFreq_ValueLimit;
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            const HPRE_clk_value = HPREValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HPRE",
                "Else",
                "No Extra Log",
                "HPRE",
            });
            HPRE.nodetype = .div;
            HPRE.value = HPRE_clk_value.get();
            HPRE.parents = &.{&CDCPREOutput};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&HPRE};

            std.mem.doNotOptimizeAway(AXIClockFreq_ValueValue);
            AXIClockOutput.limit = AXIClockFreq_ValueLimit;
            AXIClockOutput.nodetype = .output;
            AXIClockOutput.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(HCLK3ClockFreq_ValueValue);
            HCLK3Output.limit = HCLK3ClockFreq_ValueLimit;
            HCLK3Output.nodetype = .output;
            HCLK3Output.parents = &.{&AHBOutput};

            const CDPPRE_clk_value = CDPPREValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CDPPRE",
                "Else",
                "No Extra Log",
                "CDPPRE",
            });
            CDPPRE.nodetype = .div;
            CDPPRE.value = CDPPRE_clk_value.get();
            CDPPRE.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB3Freq_ValueValue);
            APB3Output.limit = APB3Freq_ValueLimit;
            APB3Output.nodetype = .output;
            APB3Output.parents = &.{&CDPPRE};

            const CDPPRE1_clk_value = CDPPRE1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CDPPRE1",
                "Else",
                "No Extra Log",
                "CDPPRE1",
            });
            CDPPRE1.nodetype = .div;
            CDPPRE1.value = CDPPRE1_clk_value.get();
            CDPPRE1.parents = &.{&AHBOutput};

            const Tim1Mul_clk_value = Tim1MulValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "Tim1Mul",
                "Else",
                "No Extra Log",
                "Tim1Mul",
            });
            Tim1Mul.nodetype = .mul;
            Tim1Mul.value = Tim1Mul_clk_value;
            Tim1Mul.parents = &.{&CDPPRE1};

            std.mem.doNotOptimizeAway(Tim1OutputFreq_ValueValue);
            Tim1Output.nodetype = .output;
            Tim1Output.parents = &.{&Tim1Mul};

            std.mem.doNotOptimizeAway(AHB12Freq_ValueValue);
            AHB12Output.limit = AHB12Freq_ValueLimit;
            AHB12Output.nodetype = .output;
            AHB12Output.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB1Freq_ValueValue);
            APB1Output.limit = APB1Freq_ValueLimit;
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&CDPPRE1};

            const CDPPRE2_clk_value = CDPPRE2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CDPPRE2",
                "Else",
                "No Extra Log",
                "CDPPRE2",
            });
            CDPPRE2.nodetype = .div;
            CDPPRE2.value = CDPPRE2_clk_value.get();
            CDPPRE2.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB2Freq_ValueValue);
            APB2Output.limit = APB2Freq_ValueLimit;
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&CDPPRE2};

            const Tim2Mul_clk_value = Tim2MulValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "Tim2Mul",
                "Else",
                "No Extra Log",
                "Tim2Mul",
            });
            Tim2Mul.nodetype = .mul;
            Tim2Mul.value = Tim2Mul_clk_value;
            Tim2Mul.parents = &.{&CDPPRE2};

            std.mem.doNotOptimizeAway(Tim2OutputFreq_ValueValue);
            Tim2Output.nodetype = .output;
            Tim2Output.parents = &.{&Tim2Mul};

            std.mem.doNotOptimizeAway(AHB4Freq_ValueValue);
            AHB4Output.nodetype = .output;
            AHB4Output.parents = &.{&AHBOutput};

            const SRDPPRE_clk_value = SRDPPREValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SRDPPRE",
                "Else",
                "No Extra Log",
                "SRDPPRE",
            });
            SRDPPRE.nodetype = .div;
            SRDPPRE.value = SRDPPRE_clk_value.get();
            SRDPPRE.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APB4Freq_ValueValue);
            APB4Output.limit = APB4Freq_ValueLimit;
            APB4Output.nodetype = .output;
            APB4Output.parents = &.{&SRDPPRE};

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
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};
            if (check_ref(@TypeOf(cKPerEnableValue), cKPerEnableValue, .true, .@"=")) {
                const CKPERSource_clk_value = CKPERSourceSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CKPERSource",
                    "Else",
                    "No Extra Log",
                    "CKPERSourceSelection",
                });
                const CKPERSourceparents = [_]*const ClockNode{
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                };
                CKPERSource.nodetype = .multi;
                CKPERSource.parents = &.{CKPERSourceparents[CKPERSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(cKPerEnableValue), cKPerEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CKPERFreq_ValueValue);
                CKPERoutput.nodetype = .output;
                CKPERoutput.parents = &.{&CKPERSource};
            }

            const DIVM1_clk_value = DIVM1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVM1",
                "Else",
                "No Extra Log",
                "DIVM1",
            });
            DIVM1.nodetype = .div;
            DIVM1.value = DIVM1_clk_value;
            DIVM1.parents = &.{&PLLSource};

            const DIVM2_clk_value = DIVM2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVM2",
                "Else",
                "No Extra Log",
                "DIVM2",
            });
            DIVM2.nodetype = .div;
            DIVM2.value = DIVM2_clk_value;
            DIVM2.parents = &.{&PLLSource};

            const DIVM3_clk_value = DIVM3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVM3",
                "Else",
                "No Extra Log",
                "DIVM3",
            });
            DIVM3.nodetype = .div;
            DIVM3.value = DIVM3_clk_value;
            DIVM3.parents = &.{&PLLSource};

            const DIVN1_clk_value = DIVN1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVN1",
                "Else",
                "No Extra Log",
                "DIVN1",
            });
            DIVN1.nodetype = .mulfrac;
            DIVN1.value = DIVN1_clk_value;
            DIVN1.parents = &.{ &DIVM1, &PLLFRACN };

            const PLLFRACN_clk_value = PLLFRACNValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const DIVP1_clk_value = DIVP1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVP1",
                "Else",
                "No Extra Log",
                "DIVP1",
            });
            DIVP1.nodetype = .div;
            DIVP1.value = DIVP1_clk_value.get();
            DIVP1.parents = &.{&DIVN1};
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                config.flags.RBGEnable or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"="))
            {
                const DIVQ1_clk_value = DIVQ1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVQ1",
                    "Else",
                    "No Extra Log",
                    "DIVQ1",
                });
                DIVQ1.nodetype = .div;
                DIVQ1.value = DIVQ1_clk_value;
                DIVQ1.parents = &.{&DIVN1};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                config.flags.RBGEnable or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVQ1Freq_ValueValue);
                DIVQ1output.limit = DIVQ1Freq_ValueLimit;
                DIVQ1output.nodetype = .output;
                DIVQ1output.parents = &.{&DIVQ1};
            }
            if (check_ref(@TypeOf(TraceEnablePllValue), TraceEnablePllValue, .true, .@"=")) {
                const DIVR1_clk_value = DIVR1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVR1",
                    "Else",
                    "No Extra Log",
                    "DIVR1",
                });
                DIVR1.nodetype = .div;
                DIVR1.value = DIVR1_clk_value;
                DIVR1.parents = &.{&DIVN1};
            }
            if (check_ref(@TypeOf(TraceEnablePllValue), TraceEnablePllValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DIVR1Freq_ValueValue);
                DIVR1output.limit = DIVR1Freq_ValueLimit;
                DIVR1output.nodetype = .output;
                DIVR1output.parents = &.{&DIVR1};
            }

            const DIVN2_clk_value = DIVN2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVN2",
                "Else",
                "No Extra Log",
                "DIVN2",
            });
            DIVN2.nodetype = .mulfrac;
            DIVN2.value = DIVN2_clk_value;
            DIVN2.parents = &.{ &DIVM2, &PLL2FRACN };

            const PLL2FRACN_clk_value = PLL2FRACNValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                const DIVP2_clk_value = DIVP2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVP2",
                    "Else",
                    "No Extra Log",
                    "DIVP2",
                });
                DIVP2.nodetype = .div;
                DIVP2.value = DIVP2_clk_value;
                DIVP2.parents = &.{&DIVN2};
            }
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVP2Freq_ValueValue);
                DIVP2output.limit = DIVP2Freq_ValueLimit;
                DIVP2output.nodetype = .output;
                DIVP2output.parents = &.{&DIVP2};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                const DIVQ2_clk_value = DIVQ2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVQ2",
                    "Else",
                    "No Extra Log",
                    "DIVQ2",
                });
                DIVQ2.nodetype = .div;
                DIVQ2.value = DIVQ2_clk_value;
                DIVQ2.parents = &.{&DIVN2};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVQ2Freq_ValueValue);
                DIVQ2output.limit = DIVQ2Freq_ValueLimit;
                DIVQ2output.nodetype = .output;
                DIVQ2output.parents = &.{&DIVQ2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                const DIVR2_clk_value = DIVR2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVR2",
                    "Else",
                    "No Extra Log",
                    "DIVR2",
                });
                DIVR2.nodetype = .div;
                DIVR2.value = DIVR2_clk_value;
                DIVR2.parents = &.{&DIVN2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVR2Freq_ValueValue);
                DIVR2output.limit = DIVR2Freq_ValueLimit;
                DIVR2output.nodetype = .output;
                DIVR2output.parents = &.{&DIVR2};
            }

            const DIVN3_clk_value = DIVN3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVN3",
                "Else",
                "No Extra Log",
                "DIVN3",
            });
            DIVN3.nodetype = .mulfrac;
            DIVN3.value = DIVN3_clk_value;
            DIVN3.parents = &.{ &DIVM3, &PLL3FRACN };

            const PLL3FRACN_clk_value = PLL3FRACNValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                const DIVP3_clk_value = DIVP3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVP3",
                    "Else",
                    "No Extra Log",
                    "DIVP3",
                });
                DIVP3.nodetype = .div;
                DIVP3.value = DIVP3_clk_value;
                DIVP3.parents = &.{&DIVN3};
            }
            if (check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVP3Freq_ValueValue);
                DIVP3output.limit = DIVP3Freq_ValueLimit;
                DIVP3output.nodetype = .output;
                DIVP3output.parents = &.{&DIVP3};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                const DIVQ3_clk_value = DIVQ3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVQ3",
                    "Else",
                    "No Extra Log",
                    "DIVQ3",
                });
                DIVQ3.nodetype = .div;
                DIVQ3.value = DIVQ3_clk_value;
                DIVQ3.parents = &.{&DIVN3};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVQ3Freq_ValueValue);
                DIVQ3output.limit = DIVQ3Freq_ValueLimit;
                DIVQ3output.nodetype = .output;
                DIVQ3output.parents = &.{&DIVQ3};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C123EnableValue), I2C123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                const DIVR3_clk_value = DIVR3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVR3",
                    "Else",
                    "No Extra Log",
                    "DIVR3",
                });
                DIVR3.nodetype = .div;
                DIVR3.value = DIVR3_clk_value;
                DIVR3.parents = &.{&DIVN3};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LTDCFreq_ValueValue);
                LTDCOutput.limit = LTDCFreq_ValueLimit;
                LTDCOutput.nodetype = .output;
                LTDCOutput.parents = &.{&DIVR3};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C123EnableValue), I2C123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVR3Freq_ValueValue);
                DIVR3output.limit = DIVR3Freq_ValueLimit;
                DIVR3output.nodetype = .output;
                DIVR3output.parents = &.{&DIVR3};
            }
            if (check_ref(@TypeOf(EnableHSERTCDevisorValue), EnableHSERTCDevisorValue, .true, .@"=")) {
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
                HSERTCDevisor.value = HSERTCDevisor_clk_value.get();
                HSERTCDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
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
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(DAC1EnableValue), DAC1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DAC1Freq_ValueValue);
                DAC1Output.limit = DAC1Freq_ValueLimit;
                DAC1Output.nodetype = .output;
                DAC1Output.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(DAC2EnableValue), DAC2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DAC2Freq_ValueValue);
                DAC2Output.limit = DAC2Freq_ValueLimit;
                DAC2Output.nodetype = .output;
                DAC2Output.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=")) {
                const SPI123Mult_clk_value = SPI123CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI123Mult",
                    "Else",
                    "No Extra Log",
                    "SPI123CLockSelection",
                });
                const SPI123Multparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                };
                SPI123Mult.nodetype = .multi;
                SPI123Mult.parents = &.{SPI123Multparents[SPI123Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI123Freq_ValueValue);
                SPI123output.limit = SPI123Freq_ValueLimit;
                SPI123output.nodetype = .output;
                SPI123output.parents = &.{&SPI123Mult};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
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
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMACLkFreq_ValueValue);
                DFSDMACLKoutput.nodetype = .output;
                DFSDMACLKoutput.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1Freq_ValueValue);
                SAI1output.limit = SAI1Freq_ValueLimit;
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=")) {
                const SAI2BMult_clk_value = SAI2BCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI2BMult",
                    "Else",
                    "No Extra Log",
                    "SAI2BCLockSelection",
                });
                const SAI2BMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                    &SPDIFMult,
                };
                SAI2BMult.nodetype = .multi;
                SAI2BMult.parents = &.{SAI2BMultparents[SAI2BMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2BEnableValue), SAI2BEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2BFreq_ValueValue);
                SAI2Boutput.limit = SAI2BFreq_ValueLimit;
                SAI2Boutput.nodetype = .output;
                SAI2Boutput.parents = &.{&SAI2BMult};
            }
            if (check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=")) {
                const SAI2AMult_clk_value = SAI2ACLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI2AMult",
                    "Else",
                    "No Extra Log",
                    "SAI2ACLockSelection",
                });
                const SAI2AMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                    &SPDIFMult,
                };
                SAI2AMult.nodetype = .multi;
                SAI2AMult.parents = &.{SAI2AMultparents[SAI2AMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2AEnableValue), SAI2AEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2AFreq_ValueValue);
                SAI2Aoutput.limit = SAI2AFreq_ValueLimit;
                SAI2Aoutput.nodetype = .output;
                SAI2Aoutput.parents = &.{&SAI2AMult};
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
                    &RC48,
                    &DIVQ1,
                    &LSEOSC,
                    &LSIRC,
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
            if (check_ref(@TypeOf(I2C123EnableValue), I2C123EnableValue, .true, .@"=")) {
                const I2C123Mult_clk_value = I2C123CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C123Mult",
                    "Else",
                    "No Extra Log",
                    "I2C123CLockSelection",
                });
                const I2C123Multparents = [_]*const ClockNode{
                    &CDPPRE1,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C123Mult.nodetype = .multi;
                I2C123Mult.parents = &.{I2C123Multparents[I2C123Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C123EnableValue), I2C123EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C123Freq_ValueValue);
                I2C123output.limit = I2C123Freq_ValueLimit;
                I2C123output.nodetype = .output;
                I2C123output.parents = &.{&I2C123Mult};
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
                    &SRDPPRE,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C4Mult.nodetype = .multi;
                I2C4Mult.parents = &.{I2C4Multparents[I2C4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C4Freq_ValueValue);
                I2C4output.limit = I2C4Freq_ValueLimit;
                I2C4output.nodetype = .output;
                I2C4output.parents = &.{&I2C4Mult};
            }
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=")) {
                const SPDIFMult_clk_value = SPDIFCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPDIFMult",
                    "Else",
                    "No Extra Log",
                    "SPDIFCLockSelection",
                });
                const SPDIFMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVR2,
                    &DIVR3,
                    &HSIDiv,
                };
                SPDIFMult.nodetype = .multi;
                SPDIFMult.parents = &.{SPDIFMultparents[SPDIFMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPDIFRXFreq_ValueValue);
                SPDIFoutput.limit = SPDIFRXFreq_ValueLimit;
                SPDIFoutput.nodetype = .output;
                SPDIFoutput.parents = &.{&SPDIFMult};
            }
            if (check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"=")) {
                const QSPIMult_clk_value = QSPICLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "QSPIMult",
                    "Else",
                    "No Extra Log",
                    "QSPICLockSelection",
                });
                const QSPIMultparents = [_]*const ClockNode{
                    &HCLK3Output,
                    &DIVQ1,
                    &DIVR2,
                    &CKPERSource,
                };
                QSPIMult.nodetype = .multi;
                QSPIMult.parents = &.{QSPIMultparents[QSPIMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCSPIEnableValue), OCSPIEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(QSPIFreq_ValueValue);
                QSPIoutput.limit = QSPIFreq_ValueLimit;
                QSPIoutput.nodetype = .output;
                QSPIoutput.parents = &.{&QSPIMult};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                const FMCMult_clk_value = FMCCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FMCMult",
                    "Else",
                    "No Extra Log",
                    "FMCCLockSelection",
                });
                const FMCMultparents = [_]*const ClockNode{
                    &HCLK3Output,
                    &DIVQ1,
                    &DIVR2,
                    &CKPERSource,
                };
                FMCMult.nodetype = .multi;
                FMCMult.parents = &.{FMCMultparents[FMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FMCFreq_ValueValue);
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
            }
            if (check_ref(@TypeOf(SWPEnableValue), SWPEnableValue, .true, .@"=")) {
                const SWPMult_clk_value = SWPCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SWPMult",
                    "Else",
                    "No Extra Log",
                    "SWPCLockSelection",
                });
                const SWPMultparents = [_]*const ClockNode{
                    &CDPPRE1,
                    &HSIDiv,
                };
                SWPMult.nodetype = .multi;
                SWPMult.parents = &.{SWPMultparents[SWPMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SWPEnableValue), SWPEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SWPMI1Freq_ValueValue);
                SWPoutput.nodetype = .output;
                SWPoutput.parents = &.{&SWPMult};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                const SDMMCMult_clk_value = SDMMC1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMCMult",
                    "Else",
                    "No Extra Log",
                    "SDMMC1CLockSelection",
                });
                const SDMMCMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVR2,
                };
                SDMMCMult.nodetype = .multi;
                SDMMCMult.parents = &.{SDMMCMultparents[SDMMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMCFreq_ValueValue);
                SDMMCoutput.limit = SDMMCFreq_ValueLimit;
                SDMMCoutput.nodetype = .output;
                SDMMCoutput.parents = &.{&SDMMCMult};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
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
                    &CDPPRE2,
                    &SysCLKOutput,
                };
                DFSDMMult.nodetype = .multi;
                DFSDMMult.parents = &.{DFSDMMultparents[DFSDMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMFreq_ValueValue);
                DFSDMoutput.limit = DFSDMFreq_ValueLimit;
                DFSDMoutput.nodetype = .output;
                DFSDMoutput.parents = &.{&DFSDMMult};
            }
            if (check_ref(@TypeOf(DFSDM2EnableValue), DFSDM2EnableValue, .true, .@"=")) {
                const DFSDM2Mult_clk_value = DFSDM2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDM2Mult",
                    "Else",
                    "No Extra Log",
                    "DFSDM2CLockSelection",
                });
                const DFSDM2Multparents = [_]*const ClockNode{
                    &SRDPPRE,
                    &SysCLKOutput,
                };
                DFSDM2Mult.nodetype = .multi;
                DFSDM2Mult.parents = &.{DFSDM2Multparents[DFSDM2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DFSDM2EnableValue), DFSDM2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDM2Freq_ValueValue);
                DFSDM2output.limit = DFSDM2Freq_ValueLimit;
                DFSDM2output.nodetype = .output;
                DFSDM2output.parents = &.{&DFSDM2Mult};
            }
            if (check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=")) {
                const USART16Mult_clk_value = USART16CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART16Mult",
                    "Else",
                    "No Extra Log",
                    "USART16CLockSelection",
                });
                const USART16Multparents = [_]*const ClockNode{
                    &CDPPRE2,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &LSEOSC,
                };
                USART16Mult.nodetype = .multi;
                USART16Mult.parents = &.{USART16Multparents[USART16Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART16910EnableValue), USART16910EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART16Freq_ValueValue);
                USART16output.limit = USART16Freq_ValueLimit;
                USART16output.nodetype = .output;
                USART16output.parents = &.{&USART16Mult};
            }
            if (check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=")) {
                const USART234578Mult_clk_value = USART234578CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART234578Mult",
                    "Else",
                    "No Extra Log",
                    "USART234578CLockSelection",
                });
                const USART234578Multparents = [_]*const ClockNode{
                    &CDPPRE1,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &LSEOSC,
                };
                USART234578Mult.nodetype = .multi;
                USART234578Mult.parents = &.{USART234578Multparents[USART234578Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART234578Freq_ValueValue);
                USART234578output.limit = USART234578Freq_ValueLimit;
                USART234578output.nodetype = .output;
                USART234578output.parents = &.{&USART234578Mult};
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
                    &CDPPRE,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &LSEOSC,
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
                    &CDPPRE1,
                    &DIVP2,
                    &DIVR3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERSource,
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
            if (check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=")) {
                const LPTIM345Mult_clk_value = LPTIM345CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM345Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM345CLockSelection",
                });
                const LPTIM345Multparents = [_]*const ClockNode{
                    &SRDPPRE,
                    &DIVP2,
                    &DIVR3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERSource,
                };
                LPTIM345Mult.nodetype = .multi;
                LPTIM345Mult.parents = &.{LPTIM345Multparents[LPTIM345Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM345Freq_ValueValue);
                LPTIM345output.limit = LPTIM345Freq_ValueLimit;
                LPTIM345output.nodetype = .output;
                LPTIM345output.parents = &.{&LPTIM345Mult};
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
                    &SRDPPRE,
                    &DIVP2,
                    &DIVR3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERSource,
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
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=")) {
                const SPI6Mult_clk_value = SPI6CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI6Mult",
                    "Else",
                    "No Extra Log",
                    "SPI6CLockSelection",
                });
                const SPI6Multparents = [_]*const ClockNode{
                    &SRDPPRE,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                };
                SPI6Mult.nodetype = .multi;
                SPI6Mult.parents = &.{SPI6Multparents[SPI6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI6OutputEnableValue), SPI6OutputEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI6Freq_ValueValue);
                SPI6output.limit = SPI6Freq_ValueLimit;
                SPI6output.nodetype = .output;
                SPI6output.parents = &.{&SPI6Mult};
            }
            if (check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDM2ACLkFreq_ValueValue);
                DFSDM2ACLKoutput.nodetype = .output;
                DFSDM2ACLKoutput.parents = &.{&SPI6Mult};
            }
            if (check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=")) {
                const SPI45Mult_clk_value = Spi45ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI45Mult",
                    "Else",
                    "No Extra Log",
                    "Spi45ClockSelection",
                });
                const SPI45Multparents = [_]*const ClockNode{
                    &CDPPRE1,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                };
                SPI45Mult.nodetype = .multi;
                SPI45Mult.parents = &.{SPI45Multparents[SPI45Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI45Freq_ValueValue);
                SPI45output.nodetype = .output;
                SPI45output.parents = &.{&SPI45Mult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const USBMult_clk_value = USBCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBMult",
                    "Else",
                    "No Extra Log",
                    "USBCLockSelection",
                });
                const USBMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVQ3,
                    &RC48,
                };
                USBMult.nodetype = .multi;
                USBMult.parents = &.{USBMultparents[USBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.limit = USBFreq_ValueLimit;
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                const FDCANMult_clk_value = FDCANCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FDCANMult",
                    "Else",
                    "No Extra Log",
                    "FDCANCLockSelection",
                });
                const FDCANMultparents = [_]*const ClockNode{
                    &HSEOSC,
                    &DIVQ1,
                    &DIVQ2,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                FDCANoutput.limit = FDCANFreq_ValueLimit;
                FDCANoutput.nodetype = .output;
                FDCANoutput.parents = &.{&FDCANMult};
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
                    &DIVP2,
                    &DIVR3,
                    &CKPERSource,
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
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CECMult_clk_value = CECCLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CECMult",
                    "Else",
                    "No Extra Log",
                    "CECCLockSelection",
                });
                const CECMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &LSIRC,
                    &CSIRC,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CECFreq_ValueValue);
                CECoutput.limit = CECFreq_ValueLimit;
                CECoutput.nodetype = .output;
                CECoutput.parents = &.{&CECMult};
            }

            out.HSIRC = try HSIRC.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.RC48 = try RC48.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.traceClkSource = try traceClkSource.get_output();
            out.TraceCLKOutput = try TraceCLKOutput.get_output();
            out.CDCPRE = try CDCPRE.get_output();
            out.CDCPREOutput = try CDCPREOutput.get_output();
            out.CpuClockOutput = try CpuClockOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.HPRE = try HPRE.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AXIClockOutput = try AXIClockOutput.get_output();
            out.HCLK3Output = try HCLK3Output.get_output();
            out.CDPPRE = try CDPPRE.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.CDPPRE1 = try CDPPRE1.get_output();
            out.Tim1Mul = try Tim1Mul.get_output();
            out.Tim1Output = try Tim1Output.get_output();
            out.AHB12Output = try AHB12Output.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.CDPPRE2 = try CDPPRE2.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.Tim2Mul = try Tim2Mul.get_output();
            out.Tim2Output = try Tim2Output.get_output();
            out.AHB4Output = try AHB4Output.get_output();
            out.SRDPPRE = try SRDPPRE.get_output();
            out.APB4Output = try APB4Output.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.CKPERSource = try CKPERSource.get_output();
            out.CKPERoutput = try CKPERoutput.get_output();
            out.DIVM1 = try DIVM1.get_output();
            out.DIVM2 = try DIVM2.get_output();
            out.DIVM3 = try DIVM3.get_output();
            out.DIVN1 = try DIVN1.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.DIVP1 = try DIVP1.get_output();
            out.DIVQ1 = try DIVQ1.get_output();
            out.DIVQ1output = try DIVQ1output.get_output();
            out.DIVR1 = try DIVR1.get_output();
            out.DIVR1output = try DIVR1output.get_output();
            out.DIVN2 = try DIVN2.get_output();
            out.PLL2FRACN = try PLL2FRACN.get_output();
            out.DIVP2 = try DIVP2.get_output();
            out.DIVP2output = try DIVP2output.get_output();
            out.DIVQ2 = try DIVQ2.get_output();
            out.DIVQ2output = try DIVQ2output.get_output();
            out.DIVR2 = try DIVR2.get_output();
            out.DIVR2output = try DIVR2output.get_output();
            out.DIVN3 = try DIVN3.get_output();
            out.PLL3FRACN = try PLL3FRACN.get_output();
            out.DIVP3 = try DIVP3.get_output();
            out.DIVP3output = try DIVP3output.get_output();
            out.DIVQ3 = try DIVQ3.get_output();
            out.DIVQ3output = try DIVQ3output.get_output();
            out.DIVR3 = try DIVR3.get_output();
            out.LTDCOutput = try LTDCOutput.get_output();
            out.DIVR3output = try DIVR3output.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.DAC1Output = try DAC1Output.get_output();
            out.DAC2Output = try DAC2Output.get_output();
            out.SPI123Mult = try SPI123Mult.get_output();
            out.SPI123output = try SPI123output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.DFSDMACLKoutput = try DFSDMACLKoutput.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI2BMult = try SAI2BMult.get_output();
            out.SAI2Boutput = try SAI2Boutput.get_output();
            out.SAI2AMult = try SAI2AMult.get_output();
            out.SAI2Aoutput = try SAI2Aoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.I2C123Mult = try I2C123Mult.get_output();
            out.I2C123output = try I2C123output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.SPDIFMult = try SPDIFMult.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.QSPIMult = try QSPIMult.get_output();
            out.QSPIoutput = try QSPIoutput.get_output();
            out.FMCMult = try FMCMult.get_output();
            out.FMCoutput = try FMCoutput.get_output();
            out.SWPMult = try SWPMult.get_output();
            out.SWPoutput = try SWPoutput.get_output();
            out.SDMMCMult = try SDMMCMult.get_output();
            out.SDMMCoutput = try SDMMCoutput.get_output();
            out.DFSDMMult = try DFSDMMult.get_output();
            out.DFSDMoutput = try DFSDMoutput.get_output();
            out.DFSDM2Mult = try DFSDM2Mult.get_output();
            out.DFSDM2output = try DFSDM2output.get_output();
            out.USART16Mult = try USART16Mult.get_output();
            out.USART16output = try USART16output.get_output();
            out.USART234578Mult = try USART234578Mult.get_output();
            out.USART234578output = try USART234578output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM345Mult = try LPTIM345Mult.get_output();
            out.LPTIM345output = try LPTIM345output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.DFSDM2ACLKoutput = try DFSDM2ACLKoutput.get_output();
            out.SPI45Mult = try SPI45Mult.get_output();
            out.SPI45output = try SPI45output.get_output();
            out.USBMult = try USBMult.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.CECoutput = try CECoutput.get_output();
            ref_out.HSIDiv = HSIDivValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.traceClkSource = traceClkSourceValue;
            ref_out.CDCPRE = CDCPREValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.HPRE = HPREValue;
            ref_out.CDPPRE = CDPPREValue;
            ref_out.CDPPRE1 = CDPPRE1Value;
            ref_out.Tim1Mul = Tim1MulValue;
            ref_out.CDPPRE2 = CDPPRE2Value;
            ref_out.Tim2Mul = Tim2MulValue;
            ref_out.SRDPPRE = SRDPPREValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.CKPERSourceSelection = CKPERSourceSelectionValue;
            ref_out.DIVM1 = DIVM1Value;
            ref_out.DIVM2 = DIVM2Value;
            ref_out.DIVM3 = DIVM3Value;
            ref_out.DIVN1 = DIVN1Value;
            ref_out.PLLFRACN = PLLFRACNValue;
            ref_out.DIVP1 = DIVP1Value;
            ref_out.DIVQ1 = DIVQ1Value;
            ref_out.DIVR1 = DIVR1Value;
            ref_out.DIVN2 = DIVN2Value;
            ref_out.PLL2FRACN = PLL2FRACNValue;
            ref_out.DIVP2 = DIVP2Value;
            ref_out.DIVQ2 = DIVQ2Value;
            ref_out.DIVR2 = DIVR2Value;
            ref_out.DIVN3 = DIVN3Value;
            ref_out.PLL3FRACN = PLL3FRACNValue;
            ref_out.DIVP3 = DIVP3Value;
            ref_out.DIVQ3 = DIVQ3Value;
            ref_out.DIVR3 = DIVR3Value;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.SPI123CLockSelection = SPI123CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2BCLockSelection = SAI2BCLockSelectionValue;
            ref_out.SAI2ACLockSelection = SAI2ACLockSelectionValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.I2C123CLockSelection = I2C123CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.QSPICLockSelection = QSPICLockSelectionValue;
            ref_out.FMCCLockSelection = FMCCLockSelectionValue;
            ref_out.SWPCLockSelection = SWPCLockSelectionValue;
            ref_out.SDMMC1CLockSelection = SDMMC1CLockSelectionValue;
            ref_out.DFSDMCLockSelection = DFSDMCLockSelectionValue;
            ref_out.DFSDM2CLockSelection = DFSDM2CLockSelectionValue;
            ref_out.USART16CLockSelection = USART16CLockSelectionValue;
            ref_out.USART234578CLockSelection = USART234578CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM345CLockSelection = LPTIM345CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.SPI6CLockSelection = SPI6CLockSelectionValue;
            ref_out.Spi45ClockSelection = Spi45ClockSelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.FDCANCLockSelection = FDCANCLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.CECCLockSelection = CECCLockSelectionValue;
            ref_out.RCC_TIM_PRescaler_Selection = RCC_TIM_PRescaler_SelectionValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.PLL1_VCI_Range = PLL1_VCI_RangeValue;
            ref_out.PLL2_VCI_Range = PLL2_VCI_RangeValue;
            ref_out.PLL3_VCI_Range = PLL3_VCI_RangeValue;
            ref_out.Prescaler = PrescalerValue;
            ref_out.Source = SourceValue;
            ref_out.Polarity = PolarityValue;
            ref_out.ReloadValueType = ReloadValueTypeValue;
            ref_out.ReloadValue = ReloadValueValue;
            ref_out.Fsync = FsyncValue;
            ref_out.ErrorLimitValue = ErrorLimitValueValue;
            ref_out.HSI48CalibrationValue = HSI48CalibrationValueValue;
            ref_out.CSICalibrationValue = CSICalibrationValueValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.PLL1_VCO_SEL = PLL1_VCO_SELValue;
            ref_out.PLL2_VCO_SEL = PLL2_VCO_SELValue;
            ref_out.PLL3_VCO_SEL = PLL3_VCO_SELValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.TraceEnable = TraceEnableValue;
            ref_out.cKPerEnable = cKPerEnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.SDMMC1Enable = SDMMC1EnableValue;
            ref_out.SAI2AEnable = SAI2AEnableValue;
            ref_out.SAI2BEnable = SAI2BEnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.SPI123Enable = SPI123EnableValue;
            ref_out.SPDIFEnable = SPDIFEnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.FMCEnable = FMCEnableValue;
            ref_out.OCSPIEnable = OCSPIEnableValue;
            ref_out.TraceEnablePll = TraceEnablePllValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.LPTIM345Enable = LPTIM345EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.SPI6Enable = SPI6EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.USART234578Enable = USART234578EnableValue;
            ref_out.USART16910Enable = USART16910EnableValue;
            ref_out.SPI45Enable = SPI45EnableValue;
            ref_out.LTDCEnable = LTDCEnableValue;
            ref_out.I2C4Enable = I2C4EnableValue;
            ref_out.I2C123Enable = I2C123EnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.DAC1Enable = DAC1EnableValue;
            ref_out.DAC2Enable = DAC2EnableValue;
            ref_out.EnableDFSDMAudio = EnableDFSDMAudioValue;
            ref_out.SWPEnable = SWPEnableValue;
            ref_out.DFSDMEnable = DFSDMEnableValue;
            ref_out.DFSDM2Enable = DFSDM2EnableValue;
            ref_out.SPI6OutputEnable = SPI6OutputEnableValue;
            ref_out.EnableDFSDM2Audio = EnableDFSDM2AudioValue;
            ref_out.CECEnable = CECEnableValue;
            ref_out.PLL1QUsed = PLL1QUsedValue;
            ref_out.PLL1PUsed = PLL1PUsedValue;
            ref_out.PLL1RUsed = PLL1RUsedValue;
            ref_out.PLL2PUsed = PLL2PUsedValue;
            ref_out.PLL2QUsed = PLL2QUsedValue;
            ref_out.PLL2RUsed = PLL2RUsedValue;
            ref_out.PLL3PUsed = PLL3PUsedValue;
            ref_out.PLL3QUsed = PLL3QUsedValue;
            ref_out.PLL3RUsed = PLL3RUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.VCOInput1Freq_Value = VCOInput1Freq_ValueValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.VCOInput2Freq_Value = VCOInput2Freq_ValueValue;
            ref_out.PLL2Used = PLL2UsedValue;
            ref_out.VCOInput3Freq_Value = VCOInput3Freq_ValueValue;
            ref_out.PLL3Used = PLL3UsedValue;
            ref_out.CSIUsed = CSIUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.VCO1OutputFreq_Value = VCO1OutputFreq_ValueValue;
            ref_out.VCO2OutputFreq_Value = VCO2OutputFreq_ValueValue;
            ref_out.VCO3OutputFreq_Value = VCO3OutputFreq_ValueValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.MCO2I2SEnable = MCO2I2SEnableValue;
            ref_out.cKPerUsed = cKPerUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
