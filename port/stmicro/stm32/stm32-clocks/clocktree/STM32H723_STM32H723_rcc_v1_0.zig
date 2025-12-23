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
pub const SAI4BCLockSelectionList = enum {
    RCC_SAI4BCLKSOURCE_PLL,
    RCC_SAI4BCLKSOURCE_PLL2,
    RCC_SAI4BCLKSOURCE_PLL3,
    RCC_SAI4BCLKSOURCE_PIN,
    RCC_SAI4BCLKSOURCE_CLKP,
    RCC_SAI4BCLKSOURCE_SPDIF,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI4BCLKSOURCE_PLL => 0,
            .RCC_SAI4BCLKSOURCE_PLL2 => 1,
            .RCC_SAI4BCLKSOURCE_PLL3 => 2,
            .RCC_SAI4BCLKSOURCE_PIN => 3,
            .RCC_SAI4BCLKSOURCE_CLKP => 4,
            .RCC_SAI4BCLKSOURCE_SPDIF => 5,
        };
    }
};
pub const SAI4ACLockSelectionList = enum {
    RCC_SAI4ACLKSOURCE_PLL,
    RCC_SAI4ACLKSOURCE_PLL2,
    RCC_SAI4ACLKSOURCE_PLL3,
    RCC_SAI4ACLKSOURCE_PIN,
    RCC_SAI4ACLKSOURCE_CLKP,
    RCC_SAI4ACLKSOURCE_SPDIF,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI4ACLKSOURCE_PLL => 0,
            .RCC_SAI4ACLKSOURCE_PLL2 => 1,
            .RCC_SAI4ACLKSOURCE_PLL3 => 2,
            .RCC_SAI4ACLKSOURCE_PIN => 3,
            .RCC_SAI4ACLKSOURCE_CLKP => 4,
            .RCC_SAI4ACLKSOURCE_SPDIF => 5,
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
    RCC_I2C1235CLKSOURCE_D2PCLK1,
    RCC_I2C1235CLKSOURCE_PLL3,
    RCC_I2C1235CLKSOURCE_HSI,
    RCC_I2C1235CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1235CLKSOURCE_D2PCLK1 => 0,
            .RCC_I2C1235CLKSOURCE_PLL3 => 1,
            .RCC_I2C1235CLKSOURCE_HSI => 2,
            .RCC_I2C1235CLKSOURCE_CSI => 3,
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
    RCC_LPTIM345CLKSOURCE_D3PCLK1,
    RCC_LPTIM345CLKSOURCE_PLL2,
    RCC_LPTIM345CLKSOURCE_PLL3,
    RCC_LPTIM345CLKSOURCE_LSE,
    RCC_LPTIM345CLKSOURCE_LSI,
    RCC_LPTIM345CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM345CLKSOURCE_D3PCLK1 => 0,
            .RCC_LPTIM345CLKSOURCE_PLL2 => 1,
            .RCC_LPTIM345CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM345CLKSOURCE_LSE => 3,
            .RCC_LPTIM345CLKSOURCE_LSI => 4,
            .RCC_LPTIM345CLKSOURCE_CLKP => 5,
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
    RCC_SPI6CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_D3PCLK1 => 0,
            .RCC_SPI6CLKSOURCE_PLL2 => 1,
            .RCC_SPI6CLKSOURCE_PLL3 => 2,
            .RCC_SPI6CLKSOURCE_HSI => 3,
            .RCC_SPI6CLKSOURCE_CSI => 4,
            .RCC_SPI6CLKSOURCE_HSE => 5,
            .RCC_SPI6CLKSOURCE_PIN => 6,
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
pub const HRTIMCLockSelectionList = enum {
    RCC_HRTIM1CLK_TIMCLK,
    RCC_HRTIM1CLK_CPUCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_HRTIM1CLK_TIMCLK => 0,
            .RCC_HRTIM1CLK_CPUCLK => 1,
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
pub const D1CPREList = enum {
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
pub const D1PPREList = enum {
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
pub const D2PPRE1List = enum {
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
pub const D2PPRE2List = enum {
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
pub const D3PPREList = enum {
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
    PWR_REGULATOR_VOLTAGE_SCALE3,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE0,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
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
pub const TraceEnableList = enum {
    auto,
};
pub const MCO1OutPutEnableList = enum {
    true,
    false,
};
pub const MCO2OutPutEnableList = enum {
    true,
    false,
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
pub const SAI4AEnableList = enum {
    true,
    false,
};
pub const SAI4BEnableList = enum {
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
pub const OCTOSPIEnableList = enum {
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
pub const USART16EnableList = enum {
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
pub const I2C1235EnableList = enum {
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
pub const CECEnableList = enum {
    true,
    false,
};
pub const HRTIMEnableList = enum {
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
pub const EnbaleCSSList = enum {
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
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI3_SAIAUsed_ForRCC: bool = false,
            SAI3_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            SAI4_SAIBUsed_ForRCC: bool = false,
            SAI4_SAIAUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SPDIFRX1Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            FDCAN3Used_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC3: bool = false,
            ADC3UsedAsynchronousCLK_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART10Used_ForRCC: bool = false,
            UART9Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            I2S6Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C5Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            RBGEnable: bool = false,
            LTDCUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            SWPMI1Used_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            HRTIMUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null,
            VDD_VALUE: ?f32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
            Prescaler: ?PrescalerList = null,
            Polarity: ?PolarityList = null,
            ReloadValueType: ?ReloadValueTypeList = null,
            ReloadValue: ?u32 = null,
            Fsync: ?f32 = null,
            ErrorLimitValue: ?u32 = null,
            HSI48CalibrationValue: ?u32 = null,
            CSICalibrationValue: ?u32 = null,
            HSICalibrationValue: ?u32 = null,
            EnbaleCSS: ?EnbaleCSSList = null,
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
            D1CPRE: ?D1CPREList = null,
            Cortex_Div: ?Cortex_DivList = null,
            HPRE: ?HPREList = null,
            D1PPRE: ?D1PPREList = null,
            D2PPRE1: ?D2PPRE1List = null,
            D2PPRE2: ?D2PPRE2List = null,
            D3PPRE: ?D3PPREList = null,
            PLLSource: ?PLLSourceList = null,
            CKPERSourceSelection: ?CKPERSourceSelectionList = null,
            DIVM1: ?u32 = null,
            DIVM2: ?u32 = null,
            DIVM3: ?u32 = null,
            DIVN1: ?u32 = null,
            PLLFRACN: ?u32 = null,
            DIVP1: ?u32 = null,
            DIVQ1: ?u32 = null,
            DIVR1: ?u32 = null,
            DIVN2: ?u32 = null,
            PLL2FRACN: ?u32 = null,
            DIVP2: ?u32 = null,
            DIVQ2: ?u32 = null,
            DIVR2: ?u32 = null,
            DIVN3: ?u32 = null,
            DIVP3: ?u32 = null,
            PLL3FRACN: ?u32 = null,
            DIVQ3: ?u32 = null,
            DIVR3: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            SPI123CLockSelection: ?SPI123CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI4BCLockSelection: ?SAI4BCLockSelectionList = null,
            SAI4ACLockSelection: ?SAI4ACLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            I2C123CLockSelection: ?I2C123CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            QSPICLockSelection: ?QSPICLockSelectionList = null,
            FMCCLockSelection: ?FMCCLockSelectionList = null,
            SWPCLockSelection: ?SWPCLockSelectionList = null,
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null,
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null,
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
            HRTIMCLockSelection: ?HRTIMCLockSelectionList = null,
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
            HSI48: f32 = 0,
            I2S_CKIN: f32 = 0,
            traceClkSource: f32 = 0,
            TraceCLKOutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            D1CPRE: f32 = 0,
            D1CPREOutput: f32 = 0,
            CpuClockOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            HPRE: f32 = 0,
            AHBOutput: f32 = 0,
            AXIClockOutput: f32 = 0,
            HCLK3Output: f32 = 0,
            D1PPRE: f32 = 0,
            APB3Output: f32 = 0,
            D2PPRE1: f32 = 0,
            Tim1Mul: f32 = 0,
            Tim1Output: f32 = 0,
            AHB12Output: f32 = 0,
            APB1Output: f32 = 0,
            D2PPRE2: f32 = 0,
            APB2Output: f32 = 0,
            Tim2Mul: f32 = 0,
            Tim2Output: f32 = 0,
            AHB4Output: f32 = 0,
            D3PPRE: f32 = 0,
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
            DIVP3: f32 = 0,
            PLL3FRACN: f32 = 0,
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
            SPI123Mult: f32 = 0,
            SPI123output: f32 = 0,
            SAI1Mult: f32 = 0,
            DFSDMACLKoutput: f32 = 0,
            SAI1output: f32 = 0,
            SAI4BMult: f32 = 0,
            SAI4Boutput: f32 = 0,
            SAI4AMult: f32 = 0,
            SAI4Aoutput: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            I2C1235Mult: f32 = 0,
            I2C1235output: f32 = 0,
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
            SPI45Mult: f32 = 0,
            SPI45output: f32 = 0,
            USBMult: f32 = 0,
            USBoutput: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CECCSIDevisor: f32 = 0,
            CECMult: f32 = 0,
            CECoutput: f32 = 0,
            HrtimMult: f32 = 0,
            HRTIMoutput: f32 = 0,
            VCOInput: f32 = 0,
            VCO2Input: f32 = 0,
            VCO3Input: f32 = 0,
            VCO1Output: f32 = 0,
            PLL1CLK: f32 = 0,
            VCO2Output: f32 = 0,
            VCO3Output: f32 = 0,
        };
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
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
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI3_SAIAUsed_ForRCC: bool = false,
            SAI3_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            SAI4_SAIBUsed_ForRCC: bool = false,
            SAI4_SAIAUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SPDIFRX1Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            FDCAN3Used_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC3: bool = false,
            ADC3UsedAsynchronousCLK_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART10Used_ForRCC: bool = false,
            UART9Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            I2S6Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C5Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            RBGEnable: bool = false,
            LTDCUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            SWPMI1Used_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            HRTIMUsed_ForRCC: bool = false,
            LSIEnable: bool = false,
            ExtClockEnable: bool = false,
            MCO1OutPutEnable: bool = false,
            MCO2OutPutEnable: bool = false,
            cKPerEnable: bool = false,
            SAI1Enable: bool = false,
            RNGEnable: bool = false,
            SDMMC1Enable: bool = false,
            SAI4AEnable: bool = false,
            SAI4BEnable: bool = false,
            USBEnable: bool = false,
            SPI123Enable: bool = false,
            SPDIFEnable: bool = false,
            FDCANEnable: bool = false,
            FMCEnable: bool = false,
            OCTOSPIEnable: bool = false,
            TraceEnablePll: bool = false,
            LPTIM2Enable: bool = false,
            LPTIM345Enable: bool = false,
            ADCEnable: bool = false,
            LPTIM1Enable: bool = false,
            SPI6Enable: bool = false,
            LPUART1Enable: bool = false,
            USART234578Enable: bool = false,
            USART16Enable: bool = false,
            SPI45Enable: bool = false,
            LTDCEnable: bool = false,
            I2C4Enable: bool = false,
            I2C1235Enable: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            EnableDFSDMAudio: bool = false,
            SWPEnable: bool = false,
            DFSDMEnable: bool = false,
            CECEnable: bool = false,
            HRTIMEnable: bool = false,
            LSEUsed: bool = false,
            PLLUsed: bool = false,
            PLL2Used: bool = false,
            PLL3Used: bool = false,
            CSIUsed: bool = false,
            HSIUsed: bool = false,
            EnableHSE: bool = false,
            EnableLSERTC: bool = false,
            EnableLSE: bool = false,
            MCO2I2SEnable: bool = false,
            EnbaleCSS: bool = false,
            cKPerUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSIDiv: ?HSIDivList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            CSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSI48_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            traceClkSource: ?traceClkSourceList = null, //from extra RCC references
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            D1CPRE: ?D1CPREList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            HPRE: ?HPREList = null, //from RCC Clock Config
            D1PPRE: ?D1PPREList = null, //from RCC Clock Config
            D2PPRE1: ?D2PPRE1List = null, //from RCC Clock Config
            Tim1Mul: ?f32 = null, //from RCC Clock Config
            D2PPRE2: ?D2PPRE2List = null, //from RCC Clock Config
            Tim2Mul: ?f32 = null, //from RCC Clock Config
            D3PPRE: ?D3PPREList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            CKPERSourceSelection: ?CKPERSourceSelectionList = null, //from RCC Clock Config
            DIVM1: ?f32 = null, //from RCC Clock Config
            DIVM2: ?f32 = null, //from RCC Clock Config
            DIVM3: ?f32 = null, //from RCC Clock Config
            DIVN1: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            DIVP1: ?f32 = null, //from RCC Clock Config
            DIVQ1: ?f32 = null, //from RCC Clock Config
            DIVR1: ?f32 = null, //from RCC Clock Config
            DIVN2: ?f32 = null, //from RCC Clock Config
            PLL2FRACN: ?f32 = null, //from RCC Clock Config
            DIVP2: ?f32 = null, //from RCC Clock Config
            DIVQ2: ?f32 = null, //from RCC Clock Config
            DIVR2: ?f32 = null, //from RCC Clock Config
            DIVN3: ?f32 = null, //from RCC Clock Config
            DIVP3: ?f32 = null, //from RCC Clock Config
            PLL3FRACN: ?f32 = null, //from RCC Clock Config
            DIVQ3: ?f32 = null, //from RCC Clock Config
            DIVR3: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            SPI123CLockSelection: ?SPI123CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI4BCLockSelection: ?SAI4BCLockSelectionList = null, //from RCC Clock Config
            SAI4ACLockSelection: ?SAI4ACLockSelectionList = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            I2C123CLockSelection: ?I2C123CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            QSPICLockSelection: ?QSPICLockSelectionList = null, //from RCC Clock Config
            FMCCLockSelection: ?FMCCLockSelectionList = null, //from RCC Clock Config
            SWPCLockSelection: ?SWPCLockSelectionList = null, //from RCC Clock Config
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null, //from RCC Clock Config
            DFSDMCLockSelection: ?DFSDMCLockSelectionList = null, //from RCC Clock Config
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
            RCC_CEC_FROM_CSI: ?f32 = null, //from RCC Clock Config
            CECCLockSelection: ?CECCLockSelectionList = null, //from RCC Clock Config
            HRTIMCLockSelection: ?HRTIMCLockSelectionList = null, //from RCC Clock Config
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

            var TRACECLKSOURCE_HSI: bool = false;
            var TRACECLKSOURCE_CSI: bool = false;
            var TRACECLKSOURCE_HSE: bool = false;
            var TRACECLKSOURCE_PLLCLK: bool = false;
            var SYSCLKSOURCE_HSI: bool = false;
            var SYSCLKSOURCE_CSI: bool = false;
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
            var SAI4BCLKSOURCE_PLLQ1: bool = false;
            var SAI4BCLKSOURCE_PLLP2: bool = false;
            var SAI4BCLKSOURCE_PLLP3: bool = false;
            var SAI4BCLKSOURCE_CKIN: bool = false;
            var SAI4BCLKSOURCE_PER: bool = false;
            var SAI4BCLKSOURCE_SPDIF: bool = false;
            var SAI4ACLKSOURCE_PLLQ1: bool = false;
            var SAI4ACLKSOURCE_PLLP2: bool = false;
            var SAI4ACLKSOURCE_PLLP3: bool = false;
            var SAI4ACLKSOURCE_CKIN: bool = false;
            var SAI4ACLKSOURCE_PER: bool = false;
            var SAI4ACLKSOURCE_SPDIF: bool = false;
            var RNGCLKSOURCE_RC48: bool = false;
            var RNGCLKSOURCE_PLLQ1: bool = false;
            var RNGCLKSOURCE_LSE: bool = false;
            var RNGCLKSOURCE_LSI: bool = false;
            var I2C1235CLKSOURCE_PCLK1: bool = false;
            var I2C1235CLKSOURCE_PLLR3: bool = false;
            var I2C1235CLKSOURCE_HSI: bool = false;
            var I2C1235CLKSOURCE_CSI: bool = false;
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
            var USART16CLKSOURCE_PCLK2: bool = false;
            var USART16CLKSOURCE_PLLQ2: bool = false;
            var USART16CLKSOURCE_PLLQ3: bool = false;
            var USART16CLKSOURCE_HSI: bool = false;
            var USART16CLKSOURCE_CSI: bool = false;
            var USART16CLKSOURCE_LSE: bool = false;
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
            var SPI6CLKSOURCE_PIN: bool = false;
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
            var HRTIMCLKSOURCE_PCLK2: bool = false;
            var HRTIMCLKSOURCE_CPU1: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var D2PPRE1_1: bool = false;
            var D2PPRE1_2: bool = false;
            var D2PPRE1_4: bool = false;
            var D2PPRE2_1: bool = false;
            var D2PPRE2_2: bool = false;
            var D2PPRE2_4: bool = false;
            var TimPrescalerEnabled: bool = false;
            var scale3: bool = false;
            var scale2: bool = false;
            var scale1: bool = false;
            var scale0: bool = false;
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

            var HSI48 = ClockNode{
                .name = "HSI48",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
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

            var D1CPRE = ClockNode{
                .name = "D1CPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var D1CPREOutput = ClockNode{
                .name = "D1CPREOutput",
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

            var D1PPRE = ClockNode{
                .name = "D1PPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3Output = ClockNode{
                .name = "APB3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var D2PPRE1 = ClockNode{
                .name = "D2PPRE1",
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

            var D2PPRE2 = ClockNode{
                .name = "D2PPRE2",
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

            var D3PPRE = ClockNode{
                .name = "D3PPRE",
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

            var DIVP3 = ClockNode{
                .name = "DIVP3",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3FRACN = ClockNode{
                .name = "PLL3FRACN",
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

            var SAI4BMult = ClockNode{
                .name = "SAI4BMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI4Boutput = ClockNode{
                .name = "SAI4Boutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI4AMult = ClockNode{
                .name = "SAI4AMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI4Aoutput = ClockNode{
                .name = "SAI4Aoutput",
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

            var I2C1235Mult = ClockNode{
                .name = "I2C1235Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C1235output = ClockNode{
                .name = "I2C1235output",
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

            var CECCSIDevisor = ClockNode{
                .name = "CECCSIDevisor",
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

            var HrtimMult = ClockNode{
                .name = "HrtimMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var HRTIMoutput = ClockNode{
                .name = "HRTIMoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput = ClockNode{
                .name = "VCOInput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO2Input = ClockNode{
                .name = "VCO2Input",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO3Input = ClockNode{
                .name = "VCO3Input",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO1Output = ClockNode{
                .name = "VCO1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1CLK = ClockNode{
                .name = "PLL1CLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO2Output = ClockNode{
                .name = "VCO2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO3Output = ClockNode{
                .name = "VCO3Output",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 6.4e7;
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
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 25000000;
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
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const CSI_VALUEValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
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

                break :blk conf_item orelse {
                    SYSCLKSOURCE_HSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
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

                break :blk conf_item orelse {
                    MCO1SOURCE_HSI = true;
                    break :blk .RCC_MCO1SOURCE_HSI;
                };
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

                break :blk conf_item orelse {
                    MCO2SOURCE_SYSCLK = true;
                    break :blk .RCC_MCO2SOURCE_SYSCLK;
                };
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
            const D1CPREValue: ?D1CPREList = blk: {
                const conf_item = config.D1CPRE;
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
                        .SYSTICK_CLKSOURCE_HCLK => HCLKDiv1 = true,
                        .SYSTICK_CLKSOURCE_HCLK_DIV8 => {},
                    }
                }

                break :blk conf_item orelse {
                    HCLKDiv1 = true;
                    break :blk .SYSTICK_CLKSOURCE_HCLK;
                };
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
            const D1PPREValue: ?D1PPREList = blk: {
                const conf_item = config.D1PPRE;
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
            const D2PPRE1Value: ?D2PPRE1List = blk: {
                const conf_item = config.D2PPRE1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB1_DIV1 => D2PPRE1_1 = true,
                        .RCC_APB1_DIV2 => D2PPRE1_2 = true,
                        .RCC_APB1_DIV4 => D2PPRE1_4 = true,
                        .RCC_APB1_DIV8 => {},
                        .RCC_APB1_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    D2PPRE1_1 = true;
                    break :blk .RCC_APB1_DIV1;
                };
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
                if (((D2PPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((D2PPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((D2PPRE1_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((D2PPRE1_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const D2PPRE2Value: ?D2PPRE2List = blk: {
                const conf_item = config.D2PPRE2;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB2_DIV1 => D2PPRE2_1 = true,
                        .RCC_APB2_DIV2 => D2PPRE2_2 = true,
                        .RCC_APB2_DIV4 => D2PPRE2_4 = true,
                        .RCC_APB2_DIV8 => {},
                        .RCC_APB2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    D2PPRE2_1 = true;
                    break :blk .RCC_APB2_DIV1;
                };
            };
            const Tim2MulValue: ?f32 = blk: {
                if (((D2PPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DESACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((D2PPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((D2PPRE2_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((D2PPRE2_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const D3PPREValue: ?D3PPREList = blk: {
                const conf_item = config.D3PPRE;
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
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL => USBCLKSOURCE_PLL1Q = true,
                        .RCC_USBCLKSOURCE_PLL3 => USBCLKSOURCE_PLL3Q = true,
                        .RCC_USBCLKSOURCE_HSI48 => USBCLKSOURCE_RC48 = true,
                    }
                }

                break :blk conf_item orelse {
                    USBCLKSOURCE_PLL1Q = true;
                    break :blk .RCC_USBCLKSOURCE_PLL;
                };
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if (((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) and (USBCLKSOURCE_PLL3Q or USBCLKSOURCE_PLL1Q))) {
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
                            , .{ "PLLSource", "((USB_OTG_FSUsed_ForRCC|USB_OTG_HSUsed_ForRCC|USB_OTG_HSEmbeddedPHYUsed_ForRCC)& (USBCLKSOURCE_PLL3Q|USBCLKSOURCE_PLL1Q)) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
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

                break :blk conf_item orelse {
                    PERSOURCE_HSI = true;
                    break :blk .RCC_CLKPSOURCE_HSI;
                };
            };
            const DIVM1Value: ?f32 = blk: {
                const config_val = config.DIVM1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                    if (val < 4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN1",
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
                            "DIVN1",
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
            const DIVP1Value: ?f32 = blk: {
                const config_val = config.DIVP1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP1",
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
                            "DIVP1",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVQ1Value: ?f32 = blk: {
                const config_val = config.DIVQ1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVR1Value: ?f32 = blk: {
                const config_val = config.DIVR1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVN2Value: ?f32 = blk: {
                const config_val = config.DIVN2;
                if (config_val) |val| {
                    if (val < 4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN2",
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
                            "DIVN2",
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
            const DIVP2Value: ?f32 = blk: {
                const config_val = config.DIVP2;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVQ2Value: ?f32 = blk: {
                const config_val = config.DIVQ2;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVR2Value: ?f32 = blk: {
                const config_val = config.DIVR2;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVN3Value: ?f32 = blk: {
                const config_val = config.DIVN3;
                if (config_val) |val| {
                    if (val < 4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN3",
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
                            "DIVN3",
                            "Else",
                            "No Extra Log",
                            512,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const DIVP3Value: ?f32 = blk: {
                const config_val = config.DIVP3;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const PLL3FRACNValue: ?f32 = blk: {
                const config_val = config.PLL3FRACN;
                PLL3FRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVQ3Value: ?f32 = blk: {
                const config_val = config.DIVQ3;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const DIVR3Value: ?f32 = blk: {
                const config_val = config.DIVR3;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        .HSERTCDevisor => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
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

                break :blk conf_item orelse {
                    SPI123CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SPI123CLKSOURCE_PLL;
                };
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

                break :blk conf_item orelse {
                    SAI1CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLL;
                };
            };
            const SAI4BCLockSelectionValue: ?SAI4BCLockSelectionList = blk: {
                const conf_item = config.SAI4BCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI4BCLKSOURCE_PLL => SAI4BCLKSOURCE_PLLQ1 = true,
                        .RCC_SAI4BCLKSOURCE_PLL2 => SAI4BCLKSOURCE_PLLP2 = true,
                        .RCC_SAI4BCLKSOURCE_PLL3 => SAI4BCLKSOURCE_PLLP3 = true,
                        .RCC_SAI4BCLKSOURCE_PIN => SAI4BCLKSOURCE_CKIN = true,
                        .RCC_SAI4BCLKSOURCE_CLKP => SAI4BCLKSOURCE_PER = true,
                        .RCC_SAI4BCLKSOURCE_SPDIF => SAI4BCLKSOURCE_SPDIF = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI4BCLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SAI4BCLKSOURCE_PLL;
                };
            };
            const SAI4ACLockSelectionValue: ?SAI4ACLockSelectionList = blk: {
                const conf_item = config.SAI4ACLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI4ACLKSOURCE_PLL => SAI4ACLKSOURCE_PLLQ1 = true,
                        .RCC_SAI4ACLKSOURCE_PLL2 => SAI4ACLKSOURCE_PLLP2 = true,
                        .RCC_SAI4ACLKSOURCE_PLL3 => SAI4ACLKSOURCE_PLLP3 = true,
                        .RCC_SAI4ACLKSOURCE_PIN => SAI4ACLKSOURCE_CKIN = true,
                        .RCC_SAI4ACLKSOURCE_CLKP => SAI4ACLKSOURCE_PER = true,
                        .RCC_SAI4ACLKSOURCE_SPDIF => SAI4ACLKSOURCE_SPDIF = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI4ACLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SAI4ACLKSOURCE_PLL;
                };
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

                break :blk conf_item orelse {
                    RNGCLKSOURCE_RC48 = true;
                    break :blk .RCC_RNGCLKSOURCE_HSI48;
                };
            };
            const I2C123CLockSelectionValue: ?I2C123CLockSelectionList = blk: {
                const conf_item = config.I2C123CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1235CLKSOURCE_D2PCLK1 => I2C1235CLKSOURCE_PCLK1 = true,
                        .RCC_I2C1235CLKSOURCE_PLL3 => I2C1235CLKSOURCE_PLLR3 = true,
                        .RCC_I2C1235CLKSOURCE_HSI => I2C1235CLKSOURCE_HSI = true,
                        .RCC_I2C1235CLKSOURCE_CSI => I2C1235CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C1235CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_I2C1235CLKSOURCE_D2PCLK1;
                };
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

                break :blk conf_item orelse {
                    I2C4CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_I2C4CLKSOURCE_D3PCLK1;
                };
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

                break :blk conf_item orelse {
                    SPDIFCLKSOURCE_PLL1Q = true;
                    break :blk .RCC_SPDIFRXCLKSOURCE_PLL;
                };
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

                break :blk conf_item orelse null;
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

                break :blk conf_item orelse {
                    FMCCLKSOURCE_HCLK3 = true;
                    break :blk .RCC_FMCCLKSOURCE_D1HCLK;
                };
            };
            const SWPCLockSelectionValue: ?SWPCLockSelectionList = blk: {
                const conf_item = config.SWPCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SWPMI1CLKSOURCE_D2PCLK1 => SWPCLKSOURCE_HCLK1 = true,
                        .RCC_SWPMI1CLKSOURCE_HSI => SWPCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SWPCLKSOURCE_HCLK1 = true;
                    break :blk .RCC_SWPMI1CLKSOURCE_D2PCLK1;
                };
            };
            const SDMMC1CLockSelectionValue: ?SDMMC1CLockSelectionList = blk: {
                const conf_item = config.SDMMC1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMCCLKSOURCE_PLL => SDMMC1CLKSOURCE_PLL1Q = true,
                        .RCC_SDMMCCLKSOURCE_PLL2 => SDMMC1CLKSOURCE_PLL2R = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1CLKSOURCE_PLL1Q = true;
                    break :blk .RCC_SDMMCCLKSOURCE_PLL;
                };
            };
            const DFSDMCLockSelectionValue: ?DFSDMCLockSelectionList = blk: {
                const conf_item = config.DFSDMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1CLKSOURCE_D2PCLK1 => DFSDMCLKSOURCE_PCLK2 = true,
                        .RCC_DFSDM1CLKSOURCE_SYS => DFSDMCLKSOURCE_SYS = true,
                    }
                }

                break :blk conf_item orelse {
                    DFSDMCLKSOURCE_PCLK2 = true;
                    break :blk .RCC_DFSDM1CLKSOURCE_D2PCLK1;
                };
            };
            const USART16CLockSelectionValue: ?USART16CLockSelectionList = blk: {
                const conf_item = config.USART16CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART16910CLKSOURCE_D2PCLK2 => USART16CLKSOURCE_PCLK2 = true,
                        .RCC_USART16910CLKSOURCE_PLL2 => USART16CLKSOURCE_PLLQ2 = true,
                        .RCC_USART16910CLKSOURCE_PLL3 => USART16CLKSOURCE_PLLQ3 = true,
                        .RCC_USART16910CLKSOURCE_HSI => USART16CLKSOURCE_HSI = true,
                        .RCC_USART16910CLKSOURCE_CSI => USART16CLKSOURCE_CSI = true,
                        .RCC_USART16910CLKSOURCE_LSE => USART16CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART16CLKSOURCE_PCLK2 = true;
                    break :blk .RCC_USART16910CLKSOURCE_D2PCLK2;
                };
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

                break :blk conf_item orelse {
                    USART2CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_USART234578CLKSOURCE_D2PCLK1;
                };
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

                break :blk conf_item orelse {
                    LPUART1CLKSOURCE_PCLK3 = true;
                    break :blk .RCC_LPUART1CLKSOURCE_D3PCLK1;
                };
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

                break :blk conf_item orelse {
                    LPTIM1CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_LPTIM1CLKSOURCE_D2PCLK1;
                };
            };
            const LPTIM345CLockSelectionValue: ?LPTIM345CLockSelectionList = blk: {
                const conf_item = config.LPTIM345CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM345CLKSOURCE_D3PCLK1 => LPTIM345CLKSOURCE_PCLK4 = true,
                        .RCC_LPTIM345CLKSOURCE_PLL2 => LPTIM345CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM345CLKSOURCE_PLL3 => LPTIM345CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM345CLKSOURCE_LSE => LPTIM345CLKSOURCE_LSE = true,
                        .RCC_LPTIM345CLKSOURCE_LSI => LPTIM345CLKSOURCE_LSI = true,
                        .RCC_LPTIM345CLKSOURCE_CLKP => LPTIM345CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM345CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_LPTIM345CLKSOURCE_D3PCLK1;
                };
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

                break :blk conf_item orelse {
                    LPTIM2CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_LPTIM2CLKSOURCE_D3PCLK1;
                };
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
                        .RCC_SPI6CLKSOURCE_PIN => SPI6CLKSOURCE_PIN = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI6CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_SPI6CLKSOURCE_D3PCLK1;
                };
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

                break :blk conf_item orelse {
                    SPI45CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_SPI45CLKSOURCE_D2PCLK1;
                };
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

                break :blk conf_item orelse {
                    FDCANCLKSOURCE_PLL1Q = true;
                    break :blk .RCC_FDCANCLKSOURCE_PLL;
                };
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

                break :blk conf_item orelse {
                    ADCCLKSOURCE_PLL2P = true;
                    break :blk .RCC_ADCCLKSOURCE_PLL2;
                };
            };
            const RCC_CEC_FROM_CSIValue: ?f32 = blk: {
                break :blk 122;
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

                break :blk conf_item orelse {
                    CECCLKSOURCE_LSI = true;
                    break :blk .RCC_CECCLKSOURCE_LSI;
                };
            };
            const HRTIMCLockSelectionValue: ?HRTIMCLockSelectionList = blk: {
                const conf_item = config.HRTIMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HRTIM1CLK_TIMCLK => HRTIMCLKSOURCE_PCLK2 = true,
                        .RCC_HRTIM1CLK_CPUCLK => HRTIMCLKSOURCE_CPU1 = true,
                    }
                }

                break :blk conf_item orelse {
                    HRTIMCLKSOURCE_PCLK2 = true;
                    break :blk .RCC_HRTIM1CLK_TIMCLK;
                };
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.62e0) {
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
                            1.62e0,
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
                if (config.flags.CRSActivatedSourceLSE or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC)) or (config.flags.MCO1Config and MCO1SOURCE_LSE) or (LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1Used_ForRCC) or (CECCLKSOURCE_LSE and config.flags.CECUsed_ForRCC) or (RNGCLKSOURCE_LSE and config.flags.RNGUsed_ForRCC) or (LPTIM2CLKSOURCE_LSE and config.flags.LPTIM2Used_ForRCC) or (LPUART1CLKSOURCE_LSE and config.flags.LPUARTUsed_ForRCC) or (USART16CLKSOURCE_LSE and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_LSE and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPTIM345CLKSOURCE_LSE and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC))) {
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
            const PrescalerValue: ?PrescalerList = blk: {
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.Prescaler) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
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

                break :blk conf_item orelse {
                    RccCrsSyncDiv1 = true;
                    break :blk .RCC_CRS_SYNC_DIV1;
                };
            };
            const SourceValue: ?SourceList = blk: {
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    break :blk null;
                } else if (config.flags.CRSActivatedSourceLSE) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_LSE;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) {
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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

                break :blk conf_item orelse {
                    AutomaticRelaod = true;
                    break :blk .automatic;
                };
            };
            var ReloadValueValue: ?f32 = if (config.extra.ReloadValue) |i| @as(f32, @floatFromInt(i)) else 0;
            var FsyncValue: ?f32 = if (config.extra.Fsync) |i| i else 1;
            var ErrorLimitValueValue: ?f32 = if (config.extra.ErrorLimitValue) |i| @as(f32, @floatFromInt(i)) else 34;
            var HSI48CalibrationValueValue: ?f32 = if (config.extra.HSI48CalibrationValue) |i| @as(f32, @floatFromInt(i)) else 32;
            var CSICalibrationValueValue: ?f32 = if (config.extra.CSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 16;
            var HSICalibrationValueValue: ?f32 = if (config.extra.HSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 64;
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
            const TraceEnableValue: ?TraceEnableList = blk: {
                const item: TraceEnableList = .auto;
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
            const cKPerEnableValue: ?cKPerEnableList = blk: {
                if (((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (config.flags.FMCUsed_ForRCC) or (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1"))) or (config.flags.LPTIM1Used_ForRCC) or (config.flags.SAI4_SAIBUsed_ForRCC) or (config.flags.SAI4_SAIAUsed_ForRCC) or (((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (config.flags.LPTIM2Used_ForRCC) or (config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) {
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
            const SAI4AEnableValue: ?SAI4AEnableList = blk: {
                if (config.flags.SAI4_SAIAUsed_ForRCC) {
                    const item: SAI4AEnableList = .true;
                    break :blk item;
                }
                const item: SAI4AEnableList = .false;
                break :blk item;
            };
            const SAI4BEnableValue: ?SAI4BEnableList = blk: {
                if (config.flags.SAI4_SAIBUsed_ForRCC) {
                    const item: SAI4BEnableList = .true;
                    break :blk item;
                }
                const item: SAI4BEnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
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
                if ((config.flags.SPDIFRX1Used_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC or config.flags.SAI4_SAIAUsed_ForRCC)) {
                    const item: SPDIFEnableList = .true;
                    break :blk item;
                }
                const item: SPDIFEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC) {
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
            const OCTOSPIEnableValue: ?OCTOSPIEnableList = blk: {
                if ((config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) {
                    const item: OCTOSPIEnableList = .true;
                    break :blk item;
                }
                const item: OCTOSPIEnableList = .false;
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
                if (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) {
                    const item: LPTIM345EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM345EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)) {
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
                if ((config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) {
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
            const USART16EnableValue: ?USART16EnableList = blk: {
                if (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC) {
                    const item: USART16EnableList = .true;
                    break :blk item;
                }
                const item: USART16EnableList = .false;
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
            const I2C1235EnableValue: ?I2C1235EnableList = blk: {
                if (config.flags.I2C1Used_ForRCC or config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC) {
                    const item: I2C1235EnableList = .true;
                    break :blk item;
                }
                const item: I2C1235EnableList = .false;
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
            const CECEnableValue: ?CECEnableList = blk: {
                if (config.flags.CECUsed_ForRCC) {
                    const item: CECEnableList = .true;
                    break :blk item;
                }
                const item: CECEnableList = .false;
                break :blk item;
            };
            const HRTIMEnableValue: ?HRTIMEnableList = blk: {
                if (config.flags.HRTIMUsed_ForRCC) {
                    const item: HRTIMEnableList = .true;
                    break :blk item;
                }
                const item: HRTIMEnableList = .false;
                break :blk item;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_PLLCLK and (check_MCU("SWD") or check_MCU("JTAG")) or (SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLQ1") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLQ1 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLQ1 and config.flags.SAI4_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP2") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP2 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP2 and config.flags.SAI4_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (USART16CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or (SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP3") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP3 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP3 and config.flags.SAI4_SAIAUsed_ForRCC) or (USART16CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (I2C1235CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const cKPerUsedValue: ?f32 = blk: {
                if ((QSPICLKSOURCE_PER and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PER and config.flags.FMCUsed_ForRCC) or (SAI1CLKSOURCE_PER and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (LPTIM1CLKSOURCE_PER and config.flags.LPTIM1Used_ForRCC) or (SAI4BCLKSOURCE_PER and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PER and config.flags.SAI4_SAIAUsed_ForRCC) or (ADCCLKSOURCE_PER and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (LPTIM2CLKSOURCE_PER and config.flags.LPTIM2Used_ForRCC) or (SPI123CLKSOURCE_PER and (config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PER") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (LPTIM345CLKSOURCE_PER and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const CSIUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_CSI and (check_MCU("SWD") or check_MCU("JTAG")) or (config.flags.MCO2Config and MCO2SOURCE_CSI) or (check_MCU("PLLSOURCE_CSI") and ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) or (config.flags.MCO2Config and MCO2SOURCE_PLL2PCLK))) or (PERSOURCE_CSI and (check_ref(@TypeOf(cKPerUsedValue), cKPerUsedValue, 1, .@"="))) or (SYSCLKSOURCE_CSI) or (I2C4CLKSOURCE_CSI and config.flags.I2C4Used_ForRCC) or (I2C1235CLKSOURCE_CSI and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (USART16CLKSOURCE_CSI and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_CSI and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPUART1CLKSOURCE_CSI and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_CSI and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_CSI and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (CECCLKSOURCE_CSI and config.flags.CECUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if (TRACECLKSOURCE_HSI and (check_MCU("SWD") or check_MCU("JTAG")) or (config.flags.MCO1Config and MCO1SOURCE_HSI) or (check_MCU("PLLSOURCE_HSI") and ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) or (config.flags.MCO2Config and MCO2SOURCE_PLL2PCLK))) or (PERSOURCE_HSI and (check_ref(@TypeOf(cKPerUsedValue), cKPerUsedValue, 1, .@"="))) or (SYSCLKSOURCE_HSI) or (I2C4CLKSOURCE_HSI and config.flags.I2C4Used_ForRCC) or (I2C1235CLKSOURCE_HSI and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (SPDIFCLKSOURCE_HSI and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (SWPCLKSOURCE_HSI and config.flags.SWPMI1Used_ForRCC) or (USART16CLKSOURCE_HSI and (config.flags.USART1Used_ForRCC or config.flags.USART6Used_ForRCC or config.flags.UART9Used_ForRCC or config.flags.USART10Used_ForRCC)) or (USART2CLKSOURCE_HSI and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPUART1CLKSOURCE_HSI and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_HSI and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_HSI and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
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
            const EnbaleCSSValue: ?EnbaleCSSList = blk: {
                if ((((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"="))) and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
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

            const HSIDiv_clk_value = HSIDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
                if (config.flags.HSEByPass) {
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
                                "HSEByPass",
                                "HSEByPass",
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
                                "HSEByPass",
                                "HSEByPass",
                                5e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 25000000;

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
                HSEOSC.value = config_val orelse 25000000;

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

            const CSIRC_clk_value = CSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            const HSI48_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSI48",
                "Else",
                "No Extra Log",
                "HSI48_VALUE",
            });
            HSI48.nodetype = .source;
            HSI48.value = HSI48_clk_value;
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
            if (check_ref(@TypeOf(TraceEnableValue), TraceEnableValue, .auto, .@"=")) {
                const traceClkSource_clk_value = traceClkSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(TraceEnableValue), TraceEnableValue, .auto, .@"=")) {
                TraceCLKOutput.nodetype = .output;
                TraceCLKOutput.parents = &.{&traceClkSource};
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
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
                &DIVP1,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
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
                    &HSIDiv,
                    &HSI48,
                    &DIVQ1,
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
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }

            const D1CPRE_clk_value = D1CPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "D1CPRE",
                "Else",
                "No Extra Log",
                "D1CPRE",
            });
            D1CPRE.nodetype = .div;
            D1CPRE.value = D1CPRE_clk_value.get();
            D1CPRE.parents = &.{&SysCLKOutput};
            D1CPREOutput.nodetype = .output;
            D1CPREOutput.parents = &.{&D1CPRE};
            CpuClockOutput.nodetype = .output;
            CpuClockOutput.parents = &.{&D1CPRE};

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
            CortexPrescaler.parents = &.{&D1CPRE};
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            const HPRE_clk_value = HPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            HPRE.parents = &.{&D1CPRE};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&HPRE};
            AXIClockOutput.nodetype = .output;
            AXIClockOutput.parents = &.{&AHBOutput};
            HCLK3Output.nodetype = .output;
            HCLK3Output.parents = &.{&AHBOutput};

            const D1PPRE_clk_value = D1PPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "D1PPRE",
                "Else",
                "No Extra Log",
                "D1PPRE",
            });
            D1PPRE.nodetype = .div;
            D1PPRE.value = D1PPRE_clk_value.get();
            D1PPRE.parents = &.{&AHBOutput};
            APB3Output.nodetype = .output;
            APB3Output.parents = &.{&D1PPRE};

            const D2PPRE1_clk_value = D2PPRE1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "D2PPRE1",
                "Else",
                "No Extra Log",
                "D2PPRE1",
            });
            D2PPRE1.nodetype = .div;
            D2PPRE1.value = D2PPRE1_clk_value.get();
            D2PPRE1.parents = &.{&AHBOutput};

            const Tim1Mul_clk_value = Tim1MulValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            Tim1Mul.parents = &.{&D2PPRE1};
            Tim1Output.nodetype = .output;
            Tim1Output.parents = &.{&Tim1Mul};
            AHB12Output.nodetype = .output;
            AHB12Output.parents = &.{&AHBOutput};
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&D2PPRE1};

            const D2PPRE2_clk_value = D2PPRE2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "D2PPRE2",
                "Else",
                "No Extra Log",
                "D2PPRE2",
            });
            D2PPRE2.nodetype = .div;
            D2PPRE2.value = D2PPRE2_clk_value.get();
            D2PPRE2.parents = &.{&AHBOutput};
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&D2PPRE2};

            const Tim2Mul_clk_value = Tim2MulValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            Tim2Mul.parents = &.{&D2PPRE2};
            Tim2Output.nodetype = .output;
            Tim2Output.parents = &.{&Tim2Mul};
            AHB4Output.nodetype = .output;
            AHB4Output.parents = &.{&AHBOutput};

            const D3PPRE_clk_value = D3PPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "D3PPRE",
                "Else",
                "No Extra Log",
                "D3PPRE",
            });
            D3PPRE.nodetype = .div;
            D3PPRE.value = D3PPRE_clk_value.get();
            D3PPRE.parents = &.{&AHBOutput};
            APB4Output.nodetype = .output;
            APB4Output.parents = &.{&D3PPRE};

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
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};
            if (check_ref(@TypeOf(cKPerEnableValue), cKPerEnableValue, .true, .@"=")) {
                const CKPERSource_clk_value = CKPERSourceSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                CKPERoutput.nodetype = .output;
                CKPERoutput.parents = &.{&CKPERSource};
            }

            const DIVM1_clk_value = DIVM1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            const DIVM2_clk_value = DIVM2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            const DIVM3_clk_value = DIVM3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            const DIVN1_clk_value = DIVN1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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

            const DIVP1_clk_value = DIVP1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            DIVP1.value = DIVP1_clk_value;
            DIVP1.parents = &.{&DIVN1};
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                config.flags.RBGEnable or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"="))
            {
                const DIVQ1_clk_value = DIVQ1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                config.flags.RBGEnable or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"="))
            {
                DIVQ1output.nodetype = .output;
                DIVQ1output.parents = &.{&DIVQ1};
            }
            if (check_ref(@TypeOf(TraceEnablePllValue), TraceEnablePllValue, .true, .@"=")) {
                const DIVR1_clk_value = DIVR1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                DIVR1output.nodetype = .output;
                DIVR1output.parents = &.{&DIVR1};
            }

            const DIVN2_clk_value = DIVN2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                const DIVP2_clk_value = DIVP2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                DIVP2output.nodetype = .output;
                DIVP2output.parents = &.{&DIVP2};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                const DIVQ2_clk_value = DIVQ2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                DIVQ2output.nodetype = .output;
                DIVQ2output.parents = &.{&DIVQ2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                const DIVR2_clk_value = DIVR2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                DIVR2output.nodetype = .output;
                DIVR2output.parents = &.{&DIVR2};
            }

            const DIVN3_clk_value = DIVN3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                const DIVP3_clk_value = DIVP3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"="))
            {
                DIVP3output.nodetype = .output;
                DIVP3output.parents = &.{&DIVP3};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                const DIVQ3_clk_value = DIVQ3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                DIVQ3output.nodetype = .output;
                DIVQ3output.parents = &.{&DIVQ3};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1235EnableValue), I2C1235EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                const DIVR3_clk_value = DIVR3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                LTDCOutput.nodetype = .output;
                LTDCOutput.parents = &.{&DIVR3};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1235EnableValue), I2C1235EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                DIVR3output.nodetype = .output;
                DIVR3output.parents = &.{&DIVR3};
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if (check_ref(@TypeOf(SPI123EnableValue), SPI123EnableValue, .true, .@"=")) {
                const SPI123Mult_clk_value = SPI123CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                SPI123output.nodetype = .output;
                SPI123output.parents = &.{&SPI123Mult};
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
                DFSDMACLKoutput.nodetype = .output;
                DFSDMACLKoutput.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=")) {
                const SAI4BMult_clk_value = SAI4BCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI4BMult",
                    "Else",
                    "No Extra Log",
                    "SAI4BCLockSelection",
                });
                const SAI4BMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                    &SPDIFMult,
                };
                SAI4BMult.nodetype = .multi;
                SAI4BMult.parents = &.{SAI4BMultparents[SAI4BMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI4BEnableValue), SAI4BEnableValue, .true, .@"=")) {
                SAI4Boutput.nodetype = .output;
                SAI4Boutput.parents = &.{&SAI4BMult};
            }
            if (check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=")) {
                const SAI4AMult_clk_value = SAI4ACLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI4AMult",
                    "Else",
                    "No Extra Log",
                    "SAI4ACLockSelection",
                });
                const SAI4AMultparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                    &SPDIFMult,
                };
                SAI4AMult.nodetype = .multi;
                SAI4AMult.parents = &.{SAI4AMultparents[SAI4AMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI4AEnableValue), SAI4AEnableValue, .true, .@"=")) {
                SAI4Aoutput.nodetype = .output;
                SAI4Aoutput.parents = &.{&SAI4AMult};
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
                    &HSI48,
                    &DIVQ1,
                    &LSEOSC,
                    &LSIRC,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&RNGMult};
            }
            if (check_ref(@TypeOf(I2C1235EnableValue), I2C1235EnableValue, .true, .@"=")) {
                const I2C1235Mult_clk_value = I2C123CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C1235Mult",
                    "Else",
                    "No Extra Log",
                    "I2C123CLockSelection",
                });
                const I2C1235Multparents = [_]*const ClockNode{
                    &D2PPRE1,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C1235Mult.nodetype = .multi;
                I2C1235Mult.parents = &.{I2C1235Multparents[I2C1235Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1235EnableValue), I2C1235EnableValue, .true, .@"=")) {
                I2C1235output.nodetype = .output;
                I2C1235output.parents = &.{&I2C1235Mult};
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
                    &D3PPRE,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C4Mult.nodetype = .multi;
                I2C4Mult.parents = &.{I2C4Multparents[I2C4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=")) {
                I2C4output.nodetype = .output;
                I2C4output.parents = &.{&I2C4Mult};
            }
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=")) {
                const SPDIFMult_clk_value = SPDIFCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                SPDIFoutput.nodetype = .output;
                SPDIFoutput.parents = &.{&SPDIFMult};
            }
            if (check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"=")) {
                const QSPIMult_clk_value = QSPICLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(OCTOSPIEnableValue), OCTOSPIEnableValue, .true, .@"=")) {
                QSPIoutput.nodetype = .output;
                QSPIoutput.parents = &.{&QSPIMult};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                const FMCMult_clk_value = FMCCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
            }
            if (check_ref(@TypeOf(SWPEnableValue), SWPEnableValue, .true, .@"=")) {
                const SWPMult_clk_value = SWPCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D2PPRE1,
                    &HSIDiv,
                };
                SWPMult.nodetype = .multi;
                SWPMult.parents = &.{SWPMultparents[SWPMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SWPEnableValue), SWPEnableValue, .true, .@"=")) {
                SWPoutput.nodetype = .output;
                SWPoutput.parents = &.{&SWPMult};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                const SDMMCMult_clk_value = SDMMC1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                SDMMCoutput.nodetype = .output;
                SDMMCoutput.parents = &.{&SDMMCMult};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
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
                    &D2PPRE2,
                    &SysCLKOutput,
                };
                DFSDMMult.nodetype = .multi;
                DFSDMMult.parents = &.{DFSDMMultparents[DFSDMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
                DFSDMoutput.nodetype = .output;
                DFSDMoutput.parents = &.{&DFSDMMult};
            }
            if (check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=")) {
                const USART16Mult_clk_value = USART16CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D2PPRE2,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &LSEOSC,
                };
                USART16Mult.nodetype = .multi;
                USART16Mult.parents = &.{USART16Multparents[USART16Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART16EnableValue), USART16EnableValue, .true, .@"=")) {
                USART16output.nodetype = .output;
                USART16output.parents = &.{&USART16Mult};
            }
            if (check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=")) {
                const USART234578Mult_clk_value = USART234578CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D2PPRE1,
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
                USART234578output.nodetype = .output;
                USART234578output.parents = &.{&USART234578Mult};
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
                    &D1PPRE,
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
                    &D2PPRE1,
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
                LPTIM1output.nodetype = .output;
                LPTIM1output.parents = &.{&LPTIM1Mult};
            }
            if (check_ref(@TypeOf(LPTIM345EnableValue), LPTIM345EnableValue, .true, .@"=")) {
                const LPTIM345Mult_clk_value = LPTIM345CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D3PPRE,
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
                LPTIM345output.nodetype = .output;
                LPTIM345output.parents = &.{&LPTIM345Mult};
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
                    &D3PPRE,
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
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=")) {
                const SPI6Mult_clk_value = SPI6CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D3PPRE,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                    &I2S_CKIN,
                };
                SPI6Mult.nodetype = .multi;
                SPI6Mult.parents = &.{SPI6Multparents[SPI6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=")) {
                SPI6output.nodetype = .output;
                SPI6output.parents = &.{&SPI6Mult};
            }
            if (check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=")) {
                const SPI45Mult_clk_value = Spi45ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &D2PPRE2,
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
                SPI45output.nodetype = .output;
                SPI45output.parents = &.{&SPI45Mult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const USBMult_clk_value = USBCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &HSI48,
                };
                USBMult.nodetype = .multi;
                USBMult.parents = &.{USBMultparents[USBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                const FDCANMult_clk_value = FDCANCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                FDCANoutput.nodetype = .output;
                FDCANoutput.parents = &.{&FDCANMult};
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
                    &DIVP2,
                    &DIVR3,
                    &CKPERSource,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CECCSIDevisor_clk_value = RCC_CEC_FROM_CSIValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CECCSIDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_CEC_FROM_CSI",
                });
                CECCSIDevisor.nodetype = .div;
                CECCSIDevisor.value = CECCSIDevisor_clk_value;
                CECCSIDevisor.parents = &.{&CSIRC};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CECMult_clk_value = CECCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &CECCSIDevisor,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                CECoutput.nodetype = .output;
                CECoutput.parents = &.{&CECMult};
            }
            if (check_ref(@TypeOf(HRTIMEnableValue), HRTIMEnableValue, .true, .@"=")) {
                const HrtimMult_clk_value = HRTIMCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HrtimMult",
                    "Else",
                    "No Extra Log",
                    "HRTIMCLockSelection",
                });
                const HrtimMultparents = [_]*const ClockNode{
                    &Tim2Output,
                    &D1CPRE,
                };
                HrtimMult.nodetype = .multi;
                HrtimMult.parents = &.{HrtimMultparents[HrtimMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(HRTIMEnableValue), HRTIMEnableValue, .true, .@"=")) {
                HRTIMoutput.nodetype = .output;
                HRTIMoutput.parents = &.{&HrtimMult};
            }
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&DIVM1};
            VCO2Input.nodetype = .output;
            VCO2Input.parents = &.{&DIVM2};
            VCO3Input.nodetype = .output;
            VCO3Input.parents = &.{&DIVM3};
            VCO1Output.nodetype = .output;
            VCO1Output.parents = &.{&DIVN1};
            PLL1CLK.nodetype = .output;
            PLL1CLK.parents = &.{&DIVP1};
            VCO2Output.nodetype = .output;
            VCO2Output.parents = &.{&DIVN2};
            VCO3Output.nodetype = .output;
            VCO3Output.parents = &.{&DIVN3};

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 5.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF D1CPREFreq_Value VALUE
            _ = blk: {
                D1CPREOutput.limit = .{
                    .min = null,
                    .max = 5.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CpuClockFreq_Value VALUE
            _ = blk: {
                CpuClockOutput.limit = .{
                    .min = null,
                    .max = 5.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CortexFreq_Value VALUE
            _ = blk: {
                CortexSysOutput.limit = .{
                    .min = null,
                    .max = 5.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AXIClockFreq_Value VALUE
            _ = blk: {
                AXIClockOutput.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLK3ClockFreq_Value VALUE
            _ = blk: {
                HCLK3Output.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB3Freq_Value VALUE
            _ = blk: {
                APB3Output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB12Freq_Value VALUE
            _ = blk: {
                AHB12Output.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB4Freq_Value VALUE
            _ = blk: {
                AHB4Output.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB4Freq_Value VALUE
            _ = blk: {
                APB4Output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DIVQ1Freq_Value VALUE
            _ = blk: {
                if ((SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLQ1") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLQ1 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLQ1 and config.flags.SAI4_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) {
                    DIVQ1output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVQ1output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP2Freq_Value VALUE
            _ = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP2") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP2 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP2 and config.flags.SAI4_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)))) {
                    DIVP2output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVP2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ2Freq_Value VALUE
            _ = blk: {
                if ((USART16CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) {
                    DIVQ2output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVQ2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVR2Freq_Value VALUE
            _ = blk: {
                if ((SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    DIVR2output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVR2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP3Freq_Value VALUE
            _ = blk: {
                if ((SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP3") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP3 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP3 and config.flags.SAI4_SAIAUsed_ForRCC)) {
                    DIVP3output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVP3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ3Freq_Value VALUE
            _ = blk: {
                if ((USART16CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) {
                    DIVQ3output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVQ3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF LTDCFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    LTDCOutput.limit = .{
                        .min = null,
                        .max = 1.66e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    LTDCOutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LTDCOutput.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    LTDCOutput.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                }
                LTDCOutput.limit = .{
                    .min = null,
                    .max = 1.66e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DIVR3Freq_Value VALUE
            _ = blk: {
                if ((I2C1235CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)))) {
                    DIVR3output.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                DIVR3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF SPI123Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SPI123output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI123output.limit = .{
                        .min = null,
                        .max = 1.8e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI123output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI123output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SPI123output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DFSDMACLkFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    DFSDMACLKoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    DFSDMACLKoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    DFSDMACLKoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    DFSDMACLKoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                DFSDMACLKoutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI1Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.66e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.13e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SAI1output.limit = .{
                    .min = null,
                    .max = 1.66e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI4BFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SAI4Boutput.limit = .{
                        .min = null,
                        .max = 1.66e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SAI4Boutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI4Boutput.limit = .{
                        .min = null,
                        .max = 1.13e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI4Boutput.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SAI4Boutput.limit = .{
                    .min = null,
                    .max = 1.66e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI4AFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SAI4Aoutput.limit = .{
                        .min = null,
                        .max = 1.66e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SAI4Aoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI4Aoutput.limit = .{
                        .min = null,
                        .max = 1.13e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI4Aoutput.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SAI4Aoutput.limit = .{
                    .min = null,
                    .max = 1.66e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                RNGoutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF I2C123Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    I2C1235output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C1235output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1235output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C1235output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                I2C1235output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF I2C4Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                I2C4output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPDIFRXFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SPDIFoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPDIFoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPDIFoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPDIFoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                SPDIFoutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF QSPIFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    QSPIoutput.limit = .{
                        .min = null,
                        .max = 3.33e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    QSPIoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    QSPIoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    QSPIoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                QSPIoutput.limit = .{
                    .min = null,
                    .max = 3.33e8,
                };

                break :blk null;
            };

            //POST CLOCK REF FMCFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    FMCoutput.limit = .{
                        .min = null,
                        .max = 2.75e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    FMCoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FMCoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    FMCoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                FMCoutput.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SWPMI1Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SWPoutput.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SWPoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SWPoutput.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SWPoutput.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                SWPoutput.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SDMMCFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SDMMCoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SDMMCoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMCoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SDMMCoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                }
                SDMMCoutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DFSDMFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    DFSDMoutput.limit = .{
                        .min = null,
                        .max = 2.75e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    DFSDMoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    DFSDMoutput.limit = .{
                        .min = null,
                        .max = 1.4e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    DFSDMoutput.limit = .{
                        .min = null,
                        .max = 8.5e7,
                    };

                    break :blk null;
                }
                DFSDMoutput.limit = .{
                    .min = null,
                    .max = 2.75e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART16Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    USART16output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    USART16output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART16output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART16output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                USART16output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART234578Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    USART234578output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    USART234578output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART234578output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART234578output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                USART234578output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPUART1Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                LPUART1output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM1Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                LPTIM1output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM345Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    LPTIM345output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPTIM345output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM345output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM345output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                LPTIM345output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM2Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 4.3e7,
                    };

                    break :blk null;
                }
                LPTIM2output.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI6Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 1.8e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SPI6output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI45Freq_Value VALUE
            _ = blk: {
                if (scale0) {
                    SPI45output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    SPI45output.limit = .{
                        .min = null,
                        .max = 1.8e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI45output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI45output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                SPI45output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USBFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    USBoutput.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    USBoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2 or scale3) {
                    USBoutput.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                }
                USBoutput.limit = .{
                    .min = null,
                    .max = 1.25e8,
                };

                break :blk null;
            };

            //POST CLOCK REF FDCANFreq_Value VALUE
            _ = blk: {
                if (scale0) {
                    FDCANoutput.limit = .{
                        .min = null,
                        .max = 1.375e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    FDCANoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FDCANoutput.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    FDCANoutput.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                }
                FDCANoutput.limit = .{
                    .min = null,
                    .max = 1.375e8,
                };

                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                if (scale0 or scale1) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.6e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 6e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 4e7,
                    };

                    break :blk null;
                }
                ADCoutput.limit = .{
                    .min = null,
                    .max = 1.6e8,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOInput1Freq_Value VALUE
            _ = blk: {
                if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLQ1") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLQ1 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLQ1 and config.flags.SAI4_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) {
                    VCOInput.limit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput2Freq_Value VALUE
            _ = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP2") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP2 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP2 and config.flags.SAI4_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (USART16CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    VCO2Input.limit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCO2Input.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput3Freq_Value VALUE
            _ = blk: {
                if ((SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP3") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP3 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP3 and config.flags.SAI4_SAIAUsed_ForRCC) or (USART16CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (I2C1235CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)))) {
                    VCO3Input.limit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCO3Input.value = 96000000;
                break :blk null;
            };
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL1VCIRANGE_3;
                break :blk item;
            };
            const PLL1_VCO_SELValue: ?PLL1_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL1_VCI_RangeValue), PLL1_VCI_RangeValue, .RCC_PLL1VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCO_SELList = .RCC_PLL1VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCO_SELList = .RCC_PLL1VCOWIDE;
                    break :blk item;
                }
                const item: PLL1_VCO_SELList = .RCC_PLL1VCOWIDE;
                break :blk item;
            };

            //POST CLOCK REF VCO1OutputFreq_Value VALUE
            _ = blk: {
                if (((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLQ1") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLQ1 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLQ1 and config.flags.SAI4_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) and (check_ref(@TypeOf(PLL1_VCO_SELValue), PLL1_VCO_SELValue, .RCC_PLL1VCOWIDE, .@"="))) {
                    VCO1Output.limit = .{
                        .min = 1.92e8,
                        .max = 8.36e8,
                    };

                    break :blk null;
                } else if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SPI123CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLQ1") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLQ1 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLQ1 and config.flags.SAI4_SAIAUsed_ForRCC) or (RNGCLKSOURCE_PLLQ1 and config.flags.RNGUsed_ForRCC) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL1Q and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL1Q and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC)) or (USBCLKSOURCE_PLL1Q and config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC))) {
                    VCO1Output.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                }
                VCO1Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP1Freq_Value VALUE
            _ = blk: {
                if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1QCLK, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config)) {
                    PLL1CLK.limit = .{
                        .min = null,
                        .max = 8.36e8,
                    };

                    break :blk null;
                }
                PLL1CLK.value = 96000000;
                break :blk null;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCO2Input.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 1600000, .@"<")) and ((check_ref(?f32, VCO2Input.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCO2Input.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLL2VCIRANGE_3;
                break :blk item;
            };
            const PLL2_VCO_SELValue: ?PLL2_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL2_VCI_RangeValue), PLL2_VCI_RangeValue, .RCC_PLL2VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL2VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL2VCOWIDE;
                    break :blk item;
                }
                const item: PLL2_VCO_SELList = .RCC_PLL2VCOWIDE;
                break :blk item;
            };

            //POST CLOCK REF VCO2OutputFreq_Value VALUE
            _ = blk: {
                if ((((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP2") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP2 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP2 and config.flags.SAI4_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (USART16CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) and (check_ref(@TypeOf(PLL2_VCO_SELValue), PLL2_VCO_SELValue, .RCC_PLL2VCOWIDE, .@"="))) {
                    VCO2Output.limit = .{
                        .min = 1.92e8,
                        .max = 8.36e8,
                    };

                    break :blk null;
                } else if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI123CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP2") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP2 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP2 and config.flags.SAI4_SAIAUsed_ForRCC) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLP2 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLP2 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))) or (USART16CLKSOURCE_PLLQ2 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (FDCANCLKSOURCE_PLL2Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC or config.flags.FDCAN3Used_ForRCC)) or (SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (QSPICLKSOURCE_PLL2R and (config.flags.OCTOSPI1Used_ForRCC or config.flags.OCTOSPI2Used_ForRCC)) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC) or (SDMMC1CLKSOURCE_PLL2R and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    VCO2Output.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                }
                VCO2Output.value = 96000000;
                break :blk null;
            };
            const PLL3_VCI_RangeValue: ?PLL3_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCO3Input.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCO3Input.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCO3Input.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCO3Input.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLL3VCIRANGE_3;
                break :blk item;
            };
            const PLL3_VCO_SELValue: ?PLL3_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL3_VCI_RangeValue), PLL3_VCI_RangeValue, .RCC_PLL3VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL3VCOMEDIUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL3VCOWIDE;
                    break :blk item;
                }
                const item: PLL3_VCO_SELList = .RCC_PLL3VCOWIDE;
                break :blk item;
            };

            //POST CLOCK REF VCO3OutputFreq_Value VALUE
            _ = blk: {
                if (((SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP3") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP3 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP3 and config.flags.SAI4_SAIAUsed_ForRCC) or (USART16CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (I2C1235CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC)))) and (check_ref(@TypeOf(PLL3_VCO_SELValue), PLL3_VCO_SELValue, .RCC_PLL3VCOWIDE, .@"="))) {
                    VCO3Output.limit = .{
                        .min = 1.92e8,
                        .max = 8.36e8,
                    };

                    break :blk null;
                } else if (((SPI123CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (check_MCU("SAI23CLKSOURCE_PLLP3") and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1")))) or (SAI4BCLKSOURCE_PLLP3 and config.flags.SAI4_SAIBUsed_ForRCC) or (SAI4ACLKSOURCE_PLLP3 and config.flags.SAI4_SAIAUsed_ForRCC) or (USART16CLKSOURCE_PLLQ3 and (config.flags.USART6Used_ForRCC or config.flags.USART1Used_ForRCC or config.flags.USART10Used_ForRCC or config.flags.UART9Used_ForRCC)) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBCLKSOURCE_PLL3Q and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC)) or (I2C1235CLKSOURCE_PLLR3 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC or config.flags.I2C1Used_ForRCC)) or (I2C4CLKSOURCE_PLLR3 and config.flags.I2C4Used_ForRCC) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRX1Used_ForRCC or (config.flags.SAI4_SAIBUsed_ForRCC and SAI4BCLKSOURCE_SPDIF or config.flags.SAI4_SAIAUsed_ForRCC and SAI4ACLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM345CLKSOURCE_PLLR3 and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPTIM2CLKSOURCE_PLLR3 and config.flags.LPTIM2Used_ForRCC) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC3 and config.flags.ADC3UsedAsynchronousCLK_ForRCC))))) {
                    VCO3Output.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                }
                VCO3Output.value = 96000000;
                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(?f32, AHBOutput.get_as_ref(), 85000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 85000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE3;
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"="))) and (check_ref(?f32, AHBOutput.get_as_ref(), 85000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@"="))) and (check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 275000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 275000000, .@"="))) and (check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale0 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE0;
                    };
                } else if ((check_ref(?f32, AHBOutput.get_as_ref(), 275000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale0 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE0;
                    };
                }
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale3 and (((check_ref(?f32, AHBOutput.get_as_ref(), 35000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 35000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale3 and (((check_ref(?f32, AHBOutput.get_as_ref(), 70000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 70000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale3 and (((check_ref(?f32, AHBOutput.get_as_ref(), 85000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 85000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale2 and (((check_ref(?f32, AHBOutput.get_as_ref(), 50000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 50000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale2 and (((check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale2 and (((check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale1 and (((check_ref(?f32, AHBOutput.get_as_ref(), 67000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 67000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale1 and (((check_ref(?f32, AHBOutput.get_as_ref(), 133000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 133000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale1 and (((check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale0 and (((check_ref(?f32, AHBOutput.get_as_ref(), 70000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 70000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale0 and (((check_ref(?f32, AHBOutput.get_as_ref(), 140000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 140000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale0 and (((check_ref(?f32, AHBOutput.get_as_ref(), 210000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 210000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale0 and (((check_ref(?f32, AHBOutput.get_as_ref(), 275000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 275000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_LATENCY_0;
                break :blk item;
            };

            //POST CLOCK REF ReloadValue VALUE
            _ = blk: {
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.ReloadValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.Fsync) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.ErrorLimitValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                if (!config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB and !config.flags.CRSActivatedSourceGPIO) {
                    if (config.extra.HSI48CalibrationValue) |_| {
                        return comptime_fail_or_error(error.InvalidConfig,
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

            //POST CLOCK REF CSICalibrationValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(CSIUsedValue), CSIUsedValue, 1, .@"=")) {
                    const config_val = config.extra.CSICalibrationValue;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
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
                            return comptime_fail_or_error(error.InvalidConfig,
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
                    CSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

                    break :blk null;
                }
                const config_val = config.extra.CSICalibrationValue;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                CSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

                break :blk null;
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
                        if (val > 127) {
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
                                127,
                                val,
                            });
                        }
                    }
                    HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 64;

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
                HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 64;

                break :blk null;
            };

            out.CpuClockOutput = try CpuClockOutput.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.D1CPREOutput = try D1CPREOutput.get_output();
            out.HRTIMoutput = try HRTIMoutput.get_output();
            out.HrtimMult = try HrtimMult.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.D1PPRE = try D1PPRE.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.Tim1Output = try Tim1Output.get_output();
            out.Tim1Mul = try Tim1Mul.get_output();
            out.SWPoutput = try SWPoutput.get_output();
            out.SWPMult = try SWPMult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.I2C1235output = try I2C1235output.get_output();
            out.I2C1235Mult = try I2C1235Mult.get_output();
            out.USART234578output = try USART234578output.get_output();
            out.USART234578Mult = try USART234578Mult.get_output();
            out.D2PPRE1 = try D2PPRE1.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.DFSDMoutput = try DFSDMoutput.get_output();
            out.DFSDMMult = try DFSDMMult.get_output();
            out.SPI45output = try SPI45output.get_output();
            out.SPI45Mult = try SPI45Mult.get_output();
            out.USART16output = try USART16output.get_output();
            out.USART16Mult = try USART16Mult.get_output();
            out.Tim2Output = try Tim2Output.get_output();
            out.Tim2Mul = try Tim2Mul.get_output();
            out.D2PPRE2 = try D2PPRE2.get_output();
            out.AXIClockOutput = try AXIClockOutput.get_output();
            out.QSPIoutput = try QSPIoutput.get_output();
            out.QSPIMult = try QSPIMult.get_output();
            out.FMCoutput = try FMCoutput.get_output();
            out.FMCMult = try FMCMult.get_output();
            out.HCLK3Output = try HCLK3Output.get_output();
            out.AHB4Output = try AHB4Output.get_output();
            out.AHB12Output = try AHB12Output.get_output();
            out.APB4Output = try APB4Output.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.LPTIM345output = try LPTIM345output.get_output();
            out.LPTIM345Mult = try LPTIM345Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.D3PPRE = try D3PPRE.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.HPRE = try HPRE.get_output();
            out.D1CPRE = try D1CPRE.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.DIVP1 = try DIVP1.get_output();
            out.SDMMCoutput = try SDMMCoutput.get_output();
            out.SDMMCMult = try SDMMCMult.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.SAI4Boutput = try SAI4Boutput.get_output();
            out.SAI4BMult = try SAI4BMult.get_output();
            out.SAI4Aoutput = try SAI4Aoutput.get_output();
            out.SAI4AMult = try SAI4AMult.get_output();
            out.SPDIFMult = try SPDIFMult.get_output();
            out.SPI123output = try SPI123output.get_output();
            out.SPI123Mult = try SPI123Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.DFSDMACLKoutput = try DFSDMACLKoutput.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.USBMult = try USBMult.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.DIVQ1output = try DIVQ1output.get_output();
            out.DIVQ1 = try DIVQ1.get_output();
            out.DIVR1output = try DIVR1output.get_output();
            out.TraceCLKOutput = try TraceCLKOutput.get_output();
            out.traceClkSource = try traceClkSource.get_output();
            out.DIVR1 = try DIVR1.get_output();
            out.DIVN1 = try DIVN1.get_output();
            out.DIVM1 = try DIVM1.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.DIVP2output = try DIVP2output.get_output();
            out.DIVP2 = try DIVP2.get_output();
            out.DIVQ2output = try DIVQ2output.get_output();
            out.DIVQ2 = try DIVQ2.get_output();
            out.DIVR2output = try DIVR2output.get_output();
            out.DIVR2 = try DIVR2.get_output();
            out.DIVN2 = try DIVN2.get_output();
            out.DIVM2 = try DIVM2.get_output();
            out.DIVP3output = try DIVP3output.get_output();
            out.DIVP3 = try DIVP3.get_output();
            out.DIVQ3output = try DIVQ3output.get_output();
            out.DIVQ3 = try DIVQ3.get_output();
            out.DIVR3output = try DIVR3output.get_output();
            out.LTDCOutput = try LTDCOutput.get_output();
            out.DIVR3 = try DIVR3.get_output();
            out.DIVN3 = try DIVN3.get_output();
            out.DIVM3 = try DIVM3.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.CKPERoutput = try CKPERoutput.get_output();
            out.CKPERSource = try CKPERSource.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.CECoutput = try CECoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CECCSIDevisor = try CECCSIDevisor.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.HSI48 = try HSI48.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.PLL2FRACN = try PLL2FRACN.get_output();
            out.PLL3FRACN = try PLL3FRACN.get_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCO2Input = try VCO2Input.get_extra_output();
            out.VCO3Input = try VCO3Input.get_extra_output();
            out.VCO1Output = try VCO1Output.get_extra_output();
            out.PLL1CLK = try PLL1CLK.get_extra_output();
            out.VCO2Output = try VCO2Output.get_extra_output();
            out.VCO3Output = try VCO3Output.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSIDiv = HSIDivValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.CSI_VALUE = CSI_VALUEValue;
            ref_out.HSI48_VALUE = HSI48_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.traceClkSource = traceClkSourceValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.D1CPRE = D1CPREValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.HPRE = HPREValue;
            ref_out.D1PPRE = D1PPREValue;
            ref_out.D2PPRE1 = D2PPRE1Value;
            ref_out.Tim1Mul = Tim1MulValue;
            ref_out.D2PPRE2 = D2PPRE2Value;
            ref_out.Tim2Mul = Tim2MulValue;
            ref_out.D3PPRE = D3PPREValue;
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
            ref_out.DIVP3 = DIVP3Value;
            ref_out.PLL3FRACN = PLL3FRACNValue;
            ref_out.DIVQ3 = DIVQ3Value;
            ref_out.DIVR3 = DIVR3Value;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.SPI123CLockSelection = SPI123CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI4BCLockSelection = SAI4BCLockSelectionValue;
            ref_out.SAI4ACLockSelection = SAI4ACLockSelectionValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.I2C123CLockSelection = I2C123CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.QSPICLockSelection = QSPICLockSelectionValue;
            ref_out.FMCCLockSelection = FMCCLockSelectionValue;
            ref_out.SWPCLockSelection = SWPCLockSelectionValue;
            ref_out.SDMMC1CLockSelection = SDMMC1CLockSelectionValue;
            ref_out.DFSDMCLockSelection = DFSDMCLockSelectionValue;
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
            ref_out.RCC_CEC_FROM_CSI = RCC_CEC_FROM_CSIValue;
            ref_out.CECCLockSelection = CECCLockSelectionValue;
            ref_out.HRTIMCLockSelection = HRTIMCLockSelectionValue;
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
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCO1Config = config.flags.MCO1Config;
            ref_out.flags.MCO2Config = config.flags.MCO2Config;
            ref_out.flags.AudioClockConfig = config.flags.AudioClockConfig;
            ref_out.flags.CRSActivatedSourceGPIO = config.flags.CRSActivatedSourceGPIO;
            ref_out.flags.CRSActivatedSourceLSE = config.flags.CRSActivatedSourceLSE;
            ref_out.flags.CRSActivatedSourceUSB = config.flags.CRSActivatedSourceUSB;
            ref_out.flags.USB_OTG_FSUsed_ForRCC = config.flags.USB_OTG_FSUsed_ForRCC;
            ref_out.flags.USB_OTG_HSUsed_ForRCC = config.flags.USB_OTG_HSUsed_ForRCC;
            ref_out.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC = config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC;
            ref_out.flags.I2S1Used_ForRCC = config.flags.I2S1Used_ForRCC;
            ref_out.flags.I2S2Used_ForRCC = config.flags.I2S2Used_ForRCC;
            ref_out.flags.I2S3Used_ForRCC = config.flags.I2S3Used_ForRCC;
            ref_out.flags.SPI1Used_ForRCC = config.flags.SPI1Used_ForRCC;
            ref_out.flags.SPI2Used_ForRCC = config.flags.SPI2Used_ForRCC;
            ref_out.flags.SPI3Used_ForRCC = config.flags.SPI3Used_ForRCC;
            ref_out.flags.SAI2_SAIAUsed_ForRCC = config.flags.SAI2_SAIAUsed_ForRCC;
            ref_out.flags.SAI2_SAIBUsed_ForRCC = config.flags.SAI2_SAIBUsed_ForRCC;
            ref_out.flags.SAI3_SAIAUsed_ForRCC = config.flags.SAI3_SAIAUsed_ForRCC;
            ref_out.flags.SAI3_SAIBUsed_ForRCC = config.flags.SAI3_SAIBUsed_ForRCC;
            ref_out.flags.SAI1_SAIAUsed_ForRCC = config.flags.SAI1_SAIAUsed_ForRCC;
            ref_out.flags.SAI1_SAIBUsed_ForRCC = config.flags.SAI1_SAIBUsed_ForRCC;
            ref_out.flags.DFSDM1Used_ForRCC = config.flags.DFSDM1Used_ForRCC;
            ref_out.flags.SAI4_SAIBUsed_ForRCC = config.flags.SAI4_SAIBUsed_ForRCC;
            ref_out.flags.SAI4_SAIAUsed_ForRCC = config.flags.SAI4_SAIAUsed_ForRCC;
            ref_out.flags.RNGUsed_ForRCC = config.flags.RNGUsed_ForRCC;
            ref_out.flags.SPDIFRX1Used_ForRCC = config.flags.SPDIFRX1Used_ForRCC;
            ref_out.flags.OCTOSPI1Used_ForRCC = config.flags.OCTOSPI1Used_ForRCC;
            ref_out.flags.OCTOSPI2Used_ForRCC = config.flags.OCTOSPI2Used_ForRCC;
            ref_out.flags.FMCUsed_ForRCC = config.flags.FMCUsed_ForRCC;
            ref_out.flags.SDMMC1Used_ForRCC = config.flags.SDMMC1Used_ForRCC;
            ref_out.flags.SDMMC2Used_ForRCC = config.flags.SDMMC2Used_ForRCC;
            ref_out.flags.FDCAN1Used_ForRCC = config.flags.FDCAN1Used_ForRCC;
            ref_out.flags.FDCAN2Used_ForRCC = config.flags.FDCAN2Used_ForRCC;
            ref_out.flags.FDCAN3Used_ForRCC = config.flags.FDCAN3Used_ForRCC;
            ref_out.flags.LPTIM1Used_ForRCC = config.flags.LPTIM1Used_ForRCC;
            ref_out.flags.LPTIM3Used_ForRCC = config.flags.LPTIM3Used_ForRCC;
            ref_out.flags.LPTIM4Used_ForRCC = config.flags.LPTIM4Used_ForRCC;
            ref_out.flags.LPTIM5Used_ForRCC = config.flags.LPTIM5Used_ForRCC;
            ref_out.flags.LPTIM2Used_ForRCC = config.flags.LPTIM2Used_ForRCC;
            ref_out.flags.USE_ADC1 = config.flags.USE_ADC1;
            ref_out.flags.ADC1UsedAsynchronousCLK_ForRCC = config.flags.ADC1UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC2 = config.flags.USE_ADC2;
            ref_out.flags.ADC2UsedAsynchronousCLK_ForRCC = config.flags.ADC2UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC3 = config.flags.USE_ADC3;
            ref_out.flags.ADC3UsedAsynchronousCLK_ForRCC = config.flags.ADC3UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USART6Used_ForRCC = config.flags.USART6Used_ForRCC;
            ref_out.flags.USART1Used_ForRCC = config.flags.USART1Used_ForRCC;
            ref_out.flags.USART10Used_ForRCC = config.flags.USART10Used_ForRCC;
            ref_out.flags.UART9Used_ForRCC = config.flags.UART9Used_ForRCC;
            ref_out.flags.USART3Used_ForRCC = config.flags.USART3Used_ForRCC;
            ref_out.flags.USART2Used_ForRCC = config.flags.USART2Used_ForRCC;
            ref_out.flags.UART4Used_ForRCC = config.flags.UART4Used_ForRCC;
            ref_out.flags.UART7Used_ForRCC = config.flags.UART7Used_ForRCC;
            ref_out.flags.UART8Used_ForRCC = config.flags.UART8Used_ForRCC;
            ref_out.flags.UART5Used_ForRCC = config.flags.UART5Used_ForRCC;
            ref_out.flags.LPUARTUsed_ForRCC = config.flags.LPUARTUsed_ForRCC;
            ref_out.flags.SPI6Used_ForRCC = config.flags.SPI6Used_ForRCC;
            ref_out.flags.I2S6Used_ForRCC = config.flags.I2S6Used_ForRCC;
            ref_out.flags.SPI4Used_ForRCC = config.flags.SPI4Used_ForRCC;
            ref_out.flags.SPI5Used_ForRCC = config.flags.SPI5Used_ForRCC;
            ref_out.flags.I2C2Used_ForRCC = config.flags.I2C2Used_ForRCC;
            ref_out.flags.I2C3Used_ForRCC = config.flags.I2C3Used_ForRCC;
            ref_out.flags.I2C5Used_ForRCC = config.flags.I2C5Used_ForRCC;
            ref_out.flags.I2C1Used_ForRCC = config.flags.I2C1Used_ForRCC;
            ref_out.flags.I2C4Used_ForRCC = config.flags.I2C4Used_ForRCC;
            ref_out.flags.RBGEnable = config.flags.RBGEnable;
            ref_out.flags.LTDCUsed_ForRCC = config.flags.LTDCUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.SWPMI1Used_ForRCC = config.flags.SWPMI1Used_ForRCC;
            ref_out.flags.CECUsed_ForRCC = config.flags.CECUsed_ForRCC;
            ref_out.flags.HRTIMUsed_ForRCC = config.flags.HRTIMUsed_ForRCC;
            ref_out.flags.LSIEnable = check_ref(?LSIEnableList, LSIEnableValue, .true, .@"=");
            ref_out.flags.ExtClockEnable = check_ref(?ExtClockEnableList, ExtClockEnableValue, .true, .@"=");
            std.mem.doNotOptimizeAway(TraceEnableValue);
            ref_out.flags.MCO1OutPutEnable = check_ref(?MCO1OutPutEnableList, MCO1OutPutEnableValue, .true, .@"=");
            ref_out.flags.MCO2OutPutEnable = check_ref(?MCO2OutPutEnableList, MCO2OutPutEnableValue, .true, .@"=");
            ref_out.flags.cKPerEnable = check_ref(?cKPerEnableList, cKPerEnableValue, .true, .@"=");
            ref_out.flags.SAI1Enable = check_ref(?SAI1EnableList, SAI1EnableValue, .true, .@"=");
            ref_out.flags.RNGEnable = check_ref(?RNGEnableList, RNGEnableValue, .true, .@"=");
            ref_out.flags.SDMMC1Enable = check_ref(?SDMMC1EnableList, SDMMC1EnableValue, .true, .@"=");
            ref_out.flags.SAI4AEnable = check_ref(?SAI4AEnableList, SAI4AEnableValue, .true, .@"=");
            ref_out.flags.SAI4BEnable = check_ref(?SAI4BEnableList, SAI4BEnableValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.SPI123Enable = check_ref(?SPI123EnableList, SPI123EnableValue, .true, .@"=");
            ref_out.flags.SPDIFEnable = check_ref(?SPDIFEnableList, SPDIFEnableValue, .true, .@"=");
            ref_out.flags.FDCANEnable = check_ref(?FDCANEnableList, FDCANEnableValue, .true, .@"=");
            ref_out.flags.FMCEnable = check_ref(?FMCEnableList, FMCEnableValue, .true, .@"=");
            ref_out.flags.OCTOSPIEnable = check_ref(?OCTOSPIEnableList, OCTOSPIEnableValue, .true, .@"=");
            ref_out.flags.TraceEnablePll = check_ref(?TraceEnablePllList, TraceEnablePllValue, .true, .@"=");
            ref_out.flags.LPTIM2Enable = check_ref(?LPTIM2EnableList, LPTIM2EnableValue, .true, .@"=");
            ref_out.flags.LPTIM345Enable = check_ref(?LPTIM345EnableList, LPTIM345EnableValue, .true, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.LPTIM1Enable = check_ref(?LPTIM1EnableList, LPTIM1EnableValue, .true, .@"=");
            ref_out.flags.SPI6Enable = check_ref(?SPI6EnableList, SPI6EnableValue, .true, .@"=");
            ref_out.flags.LPUART1Enable = check_ref(?LPUART1EnableList, LPUART1EnableValue, .true, .@"=");
            ref_out.flags.USART234578Enable = check_ref(?USART234578EnableList, USART234578EnableValue, .true, .@"=");
            ref_out.flags.USART16Enable = check_ref(?USART16EnableList, USART16EnableValue, .true, .@"=");
            ref_out.flags.SPI45Enable = check_ref(?SPI45EnableList, SPI45EnableValue, .true, .@"=");
            ref_out.flags.LTDCEnable = check_ref(?LTDCEnableList, LTDCEnableValue, .true, .@"=");
            ref_out.flags.I2C4Enable = check_ref(?I2C4EnableList, I2C4EnableValue, .true, .@"=");
            ref_out.flags.I2C1235Enable = check_ref(?I2C1235EnableList, I2C1235EnableValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.EnableDFSDMAudio = check_ref(?EnableDFSDMAudioList, EnableDFSDMAudioValue, .true, .@"=");
            ref_out.flags.SWPEnable = check_ref(?SWPEnableList, SWPEnableValue, .true, .@"=");
            ref_out.flags.DFSDMEnable = check_ref(?DFSDMEnableList, DFSDMEnableValue, .true, .@"=");
            ref_out.flags.CECEnable = check_ref(?CECEnableList, CECEnableValue, .true, .@"=");
            ref_out.flags.HRTIMEnable = check_ref(?HRTIMEnableList, HRTIMEnableValue, .true, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.PLL2Used = check_ref(?f32, PLL2UsedValue, 1, .@"=");
            ref_out.flags.PLL3Used = check_ref(?f32, PLL3UsedValue, 1, .@"=");
            ref_out.flags.CSIUsed = check_ref(?f32, CSIUsedValue, 1, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.MCO2I2SEnable = check_ref(?MCO2I2SEnableList, MCO2I2SEnableValue, .true, .@"=");
            ref_out.flags.EnbaleCSS = check_ref(?EnbaleCSSList, EnbaleCSSValue, .true, .@"=");
            ref_out.flags.cKPerUsed = check_ref(?f32, cKPerUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
