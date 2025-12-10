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
pub const PLLSourceList = enum {
    RCC_PLL1_SOURCE_CSI,
    RCC_PLL1_SOURCE_HSI,
    RCC_PLL1_SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL1_SOURCE_CSI => 0,
            .RCC_PLL1_SOURCE_HSI => 1,
            .RCC_PLL1_SOURCE_HSE => 2,
        };
    }
};
pub const PLL2SourceList = enum {
    RCC_PLL2_SOURCE_CSI,
    RCC_PLL2_SOURCE_HSI,
    RCC_PLL2_SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL2_SOURCE_CSI => 0,
            .RCC_PLL2_SOURCE_HSI => 1,
            .RCC_PLL2_SOURCE_HSE => 2,
        };
    }
};
pub const PLL3SourceList = enum {
    RCC_PLL3_SOURCE_CSI,
    RCC_PLL3_SOURCE_HSI,
    RCC_PLL3_SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL3_SOURCE_CSI => 0,
            .RCC_PLL3_SOURCE_HSI => 1,
            .RCC_PLL3_SOURCE_HSE => 2,
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
pub const CECCLockSelectionList = enum {
    RCC_CECCLKSOURCE_LSE,
    RCC_CECCLKSOURCE_CSI_DIV122,
    RCC_CECCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CECCLKSOURCE_LSE => 0,
            .RCC_CECCLKSOURCE_CSI_DIV122 => 1,
            .RCC_CECCLKSOURCE_LSI => 2,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK2,
    RCC_USART1CLKSOURCE_PLL2Q,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_LSE,
    RCC_USART1CLKSOURCE_CSI,
    RCC_USART1CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_PLL2Q => 1,
            .RCC_USART1CLKSOURCE_HSI => 2,
            .RCC_USART1CLKSOURCE_LSE => 3,
            .RCC_USART1CLKSOURCE_CSI => 4,
            .RCC_USART1CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const USART2CLockSelectionList = enum {
    RCC_USART2CLKSOURCE_PCLK1,
    RCC_USART2CLKSOURCE_PLL2Q,
    RCC_USART2CLKSOURCE_HSI,
    RCC_USART2CLKSOURCE_LSE,
    RCC_USART2CLKSOURCE_CSI,
    RCC_USART2CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_PCLK1 => 0,
            .RCC_USART2CLKSOURCE_PLL2Q => 1,
            .RCC_USART2CLKSOURCE_HSI => 2,
            .RCC_USART2CLKSOURCE_LSE => 3,
            .RCC_USART2CLKSOURCE_CSI => 4,
            .RCC_USART2CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const USART3CLockSelectionList = enum {
    RCC_USART3CLKSOURCE_PCLK1,
    RCC_USART3CLKSOURCE_PLL2Q,
    RCC_USART3CLKSOURCE_HSI,
    RCC_USART3CLKSOURCE_LSE,
    RCC_USART3CLKSOURCE_CSI,
    RCC_USART3CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART3CLKSOURCE_PCLK1 => 0,
            .RCC_USART3CLKSOURCE_PLL2Q => 1,
            .RCC_USART3CLKSOURCE_HSI => 2,
            .RCC_USART3CLKSOURCE_LSE => 3,
            .RCC_USART3CLKSOURCE_CSI => 4,
            .RCC_USART3CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const UART4CLockSelectionList = enum {
    RCC_UART4CLKSOURCE_PCLK1,
    RCC_UART4CLKSOURCE_PLL2Q,
    RCC_UART4CLKSOURCE_HSI,
    RCC_UART4CLKSOURCE_LSE,
    RCC_UART4CLKSOURCE_CSI,
    RCC_UART4CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_PCLK1 => 0,
            .RCC_UART4CLKSOURCE_PLL2Q => 1,
            .RCC_UART4CLKSOURCE_HSI => 2,
            .RCC_UART4CLKSOURCE_LSE => 3,
            .RCC_UART4CLKSOURCE_CSI => 4,
            .RCC_UART4CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const UART5CLockSelectionList = enum {
    RCC_UART5CLKSOURCE_PCLK1,
    RCC_UART5CLKSOURCE_PLL2Q,
    RCC_UART5CLKSOURCE_HSI,
    RCC_UART5CLKSOURCE_LSE,
    RCC_UART5CLKSOURCE_CSI,
    RCC_UART5CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART5CLKSOURCE_PCLK1 => 0,
            .RCC_UART5CLKSOURCE_PLL2Q => 1,
            .RCC_UART5CLKSOURCE_HSI => 2,
            .RCC_UART5CLKSOURCE_LSE => 3,
            .RCC_UART5CLKSOURCE_CSI => 4,
            .RCC_UART5CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const USART6CLockSelectionList = enum {
    RCC_USART6CLKSOURCE_PCLK1,
    RCC_USART6CLKSOURCE_PLL2Q,
    RCC_USART6CLKSOURCE_HSI,
    RCC_USART6CLKSOURCE_LSE,
    RCC_USART6CLKSOURCE_CSI,
    RCC_USART6CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART6CLKSOURCE_PCLK1 => 0,
            .RCC_USART6CLKSOURCE_PLL2Q => 1,
            .RCC_USART6CLKSOURCE_HSI => 2,
            .RCC_USART6CLKSOURCE_LSE => 3,
            .RCC_USART6CLKSOURCE_CSI => 4,
            .RCC_USART6CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK3,
    RCC_LPUART1CLKSOURCE_PLL2Q,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_LSE,
    RCC_LPUART1CLKSOURCE_CSI,
    RCC_LPUART1CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK3 => 0,
            .RCC_LPUART1CLKSOURCE_PLL2Q => 1,
            .RCC_LPUART1CLKSOURCE_HSI => 2,
            .RCC_LPUART1CLKSOURCE_LSE => 3,
            .RCC_LPUART1CLKSOURCE_CSI => 4,
            .RCC_LPUART1CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK3,
    RCC_LPTIM1CLKSOURCE_PLL2P,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_CLKP,
    RCC_LPTIM1CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM1CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM1CLKSOURCE_LSE => 2,
            .RCC_LPTIM1CLKSOURCE_LSI => 3,
            .RCC_LPTIM1CLKSOURCE_CLKP => 4,
            .RCC_LPTIM1CLKSOURCE_PLL3R => 5,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK1,
    RCC_LPTIM2CLKSOURCE_PLL2P,
    RCC_LPTIM2CLKSOURCE_LSE,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_CLKP,
    RCC_LPTIM2CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM2CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM2CLKSOURCE_LSE => 2,
            .RCC_LPTIM2CLKSOURCE_LSI => 3,
            .RCC_LPTIM2CLKSOURCE_CLKP => 4,
            .RCC_LPTIM2CLKSOURCE_PLL3R => 5,
        };
    }
};
pub const DACLowPowerCLockSelectionList = enum {
    RCC_DACLPCLKSOURCE_LSE,
    RCC_DACLPCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DACLPCLKSOURCE_LSE => 0,
            .RCC_DACLPCLKSOURCE_LSI => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCDACCLKSOURCE_HCLK,
    RCC_ADCDACCLKSOURCE_SYSCLK,
    RCC_ADCDACCLKSOURCE_PLL2R,
    RCC_ADCDACCLKSOURCE_HSE,
    RCC_ADCDACCLKSOURCE_HSI,
    RCC_ADCDACCLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCDACCLKSOURCE_HCLK => 0,
            .RCC_ADCDACCLKSOURCE_SYSCLK => 1,
            .RCC_ADCDACCLKSOURCE_PLL2R => 2,
            .RCC_ADCDACCLKSOURCE_HSE => 3,
            .RCC_ADCDACCLKSOURCE_HSI => 4,
            .RCC_ADCDACCLKSOURCE_CSI => 5,
        };
    }
};
pub const USBCLockSelectionList = enum {
    RCC_USBCLKSOURCE_PLL3Q,
    RCC_USBCLKSOURCE_PLL1Q,
    RCC_USBCLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL3Q => 0,
            .RCC_USBCLKSOURCE_PLL1Q => 1,
            .RCC_USBCLKSOURCE_HSI48 => 2,
        };
    }
};
pub const SDMMC1ClockSelectionList = enum {
    RCC_SDMMC1CLKSOURCE_PLL1Q,
    RCC_SDMMC1CLKSOURCE_PLL2R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC1CLKSOURCE_PLL1Q => 0,
            .RCC_SDMMC1CLKSOURCE_PLL2R => 1,
        };
    }
};
pub const FDCANClockSelectionList = enum {
    RCC_FDCANCLKSOURCE_PLL1Q,
    RCC_FDCANCLKSOURCE_PLL2Q,
    RCC_FDCANCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_PLL1Q => 0,
            .RCC_FDCANCLKSOURCE_PLL2Q => 1,
            .RCC_FDCANCLKSOURCE_HSE => 2,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_PLL3R,
    RCC_I2C1CLKSOURCE_HSI,
    RCC_I2C1CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_PLL3R => 1,
            .RCC_I2C1CLKSOURCE_HSI => 2,
            .RCC_I2C1CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C2CLockSelectionList = enum {
    RCC_I2C2CLKSOURCE_PCLK1,
    RCC_I2C2CLKSOURCE_PLL3R,
    RCC_I2C2CLKSOURCE_HSI,
    RCC_I2C2CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_PCLK1 => 0,
            .RCC_I2C2CLKSOURCE_PLL3R => 1,
            .RCC_I2C2CLKSOURCE_HSI => 2,
            .RCC_I2C2CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK3,
    RCC_I2C3CLKSOURCE_PLL3R,
    RCC_I2C3CLKSOURCE_HSI,
    RCC_I2C3CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK3 => 0,
            .RCC_I2C3CLKSOURCE_PLL3R => 1,
            .RCC_I2C3CLKSOURCE_HSI => 2,
            .RCC_I2C3CLKSOURCE_CSI => 3,
        };
    }
};
pub const I3C1CLockSelectionList = enum {
    RCC_I3C1CLKSOURCE_PCLK1,
    RCC_I3C1CLKSOURCE_PLL3R,
    RCC_I3C1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C1CLKSOURCE_PCLK1 => 0,
            .RCC_I3C1CLKSOURCE_PLL3R => 1,
            .RCC_I3C1CLKSOURCE_HSI => 2,
        };
    }
};
pub const I3C2CLockSelectionList = enum {
    RCC_I3C2CLKSOURCE_PCLK3,
    RCC_I3C2CLKSOURCE_PLL3R,
    RCC_I3C2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C2CLKSOURCE_PCLK3 => 0,
            .RCC_I3C2CLKSOURCE_PLL3R => 1,
            .RCC_I3C2CLKSOURCE_HSI => 2,
        };
    }
};
pub const OCTOSPIMCLockSelectionList = enum {
    RCC_OSPICLKSOURCE_HCLK,
    RCC_OSPICLKSOURCE_PLL1Q,
    RCC_OSPICLKSOURCE_PLL2R,
    RCC_OSPICLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_OSPICLKSOURCE_HCLK => 0,
            .RCC_OSPICLKSOURCE_PLL1Q => 1,
            .RCC_OSPICLKSOURCE_PLL2R => 2,
            .RCC_OSPICLKSOURCE_CLKP => 3,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_HSI48,
    RCC_RNGCLKSOURCE_PLL1Q,
    RCC_RNGCLKSOURCE_LSE,
    RCC_RNGCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_HSI48 => 0,
            .RCC_RNGCLKSOURCE_PLL1Q => 1,
            .RCC_RNGCLKSOURCE_LSE => 2,
            .RCC_RNGCLKSOURCE_LSI => 3,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLL1Q,
    RCC_MCO1SOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_HSI => 2,
            .RCC_MCO1SOURCE_PLL1Q => 3,
            .RCC_MCO1SOURCE_HSI48 => 4,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_LSI,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_CSI,
    RCC_MCO2SOURCE_PLL1P,
    RCC_MCO2SOURCE_PLL2P,
    RCC_MCO2SOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_LSI => 0,
            .RCC_MCO2SOURCE_HSE => 1,
            .RCC_MCO2SOURCE_CSI => 2,
            .RCC_MCO2SOURCE_PLL1P => 3,
            .RCC_MCO2SOURCE_PLL2P => 4,
            .RCC_MCO2SOURCE_SYSCLK => 5,
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
pub const CKPERSourceSelectionList = enum {
    RCC_CLKPSOURCE_HSI,
    RCC_CLKPSOURCE_HSE,
    RCC_CLKPSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLKPSOURCE_HSI => 0,
            .RCC_CLKPSOURCE_HSE => 1,
            .RCC_CLKPSOURCE_CSI => 2,
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
    RCC_SPI1CLKSOURCE_PLL1Q,
    RCC_SPI1CLKSOURCE_PLL2P,
    RCC_SPI1CLKSOURCE_PLL3P,
    RCC_SPI1CLKSOURCE_PIN,
    RCC_SPI1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PLL1Q => 0,
            .RCC_SPI1CLKSOURCE_PLL2P => 1,
            .RCC_SPI1CLKSOURCE_PLL3P => 2,
            .RCC_SPI1CLKSOURCE_PIN => 3,
            .RCC_SPI1CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SPI3CLockSelectionList = enum {
    RCC_SPI3CLKSOURCE_PLL1Q,
    RCC_SPI3CLKSOURCE_PLL2P,
    RCC_SPI3CLKSOURCE_PLL3P,
    RCC_SPI3CLKSOURCE_PIN,
    RCC_SPI3CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3CLKSOURCE_PLL1Q => 0,
            .RCC_SPI3CLKSOURCE_PLL2P => 1,
            .RCC_SPI3CLKSOURCE_PLL3P => 2,
            .RCC_SPI3CLKSOURCE_PIN => 3,
            .RCC_SPI3CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SPI4CLockSelectionList = enum {
    RCC_SPI4CLKSOURCE_PCLK2,
    RCC_SPI4CLKSOURCE_PLL2Q,
    RCC_SPI4CLKSOURCE_HSI,
    RCC_SPI4CLKSOURCE_CSI,
    RCC_SPI4CLKSOURCE_HSE,
    RCC_SPI4CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI4CLKSOURCE_PCLK2 => 0,
            .RCC_SPI4CLKSOURCE_PLL2Q => 1,
            .RCC_SPI4CLKSOURCE_HSI => 2,
            .RCC_SPI4CLKSOURCE_CSI => 3,
            .RCC_SPI4CLKSOURCE_HSE => 4,
            .RCC_SPI4CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const SPI2CLockSelectionList = enum {
    RCC_SPI2CLKSOURCE_PLL1Q,
    RCC_SPI2CLKSOURCE_PLL2P,
    RCC_SPI2CLKSOURCE_PLL3P,
    RCC_SPI2CLKSOURCE_PIN,
    RCC_SPI2CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI2CLKSOURCE_PLL1Q => 0,
            .RCC_SPI2CLKSOURCE_PLL2P => 1,
            .RCC_SPI2CLKSOURCE_PLL3P => 2,
            .RCC_SPI2CLKSOURCE_PIN => 3,
            .RCC_SPI2CLKSOURCE_CLKP => 4,
        };
    }
};
pub const HSIDivList = enum {
    RCC_HSI_DIV1,
    RCC_HSI_DIV2,
    RCC_HSI_DIV4,
    RCC_HSI_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSI_DIV1 => 1,
            .RCC_HSI_DIV2 => 2,
            .RCC_HSI_DIV4 => 4,
            .RCC_HSI_DIV8 => 8,
        };
    }
};
pub const RCC_RTC_Clock_Source_FROM_HSEList = enum {
    RCC_RTC_HSE_NOCLOCK,
    RCC_RTC_HSE_DIV2,
    RCC_RTC_HSE_DIV3,
    RCC_RTC_HSE_DIV4,
    RCC_RTC_HSE_DIV5,
    RCC_RTC_HSE_DIV6,
    RCC_RTC_HSE_DIV7,
    RCC_RTC_HSE_DIV8,
    RCC_RTC_HSE_DIV9,
    RCC_RTC_HSE_DIV10,
    RCC_RTC_HSE_DIV11,
    RCC_RTC_HSE_DIV12,
    RCC_RTC_HSE_DIV13,
    RCC_RTC_HSE_DIV14,
    RCC_RTC_HSE_DIV15,
    RCC_RTC_HSE_DIV16,
    RCC_RTC_HSE_DIV17,
    RCC_RTC_HSE_DIV18,
    RCC_RTC_HSE_DIV19,
    RCC_RTC_HSE_DIV20,
    RCC_RTC_HSE_DIV21,
    RCC_RTC_HSE_DIV22,
    RCC_RTC_HSE_DIV23,
    RCC_RTC_HSE_DIV24,
    RCC_RTC_HSE_DIV25,
    RCC_RTC_HSE_DIV26,
    RCC_RTC_HSE_DIV27,
    RCC_RTC_HSE_DIV28,
    RCC_RTC_HSE_DIV29,
    RCC_RTC_HSE_DIV30,
    RCC_RTC_HSE_DIV31,
    RCC_RTC_HSE_DIV32,
    RCC_RTC_HSE_DIV33,
    RCC_RTC_HSE_DIV34,
    RCC_RTC_HSE_DIV35,
    RCC_RTC_HSE_DIV36,
    RCC_RTC_HSE_DIV37,
    RCC_RTC_HSE_DIV38,
    RCC_RTC_HSE_DIV39,
    RCC_RTC_HSE_DIV40,
    RCC_RTC_HSE_DIV41,
    RCC_RTC_HSE_DIV42,
    RCC_RTC_HSE_DIV43,
    RCC_RTC_HSE_DIV44,
    RCC_RTC_HSE_DIV45,
    RCC_RTC_HSE_DIV46,
    RCC_RTC_HSE_DIV47,
    RCC_RTC_HSE_DIV48,
    RCC_RTC_HSE_DIV49,
    RCC_RTC_HSE_DIV50,
    RCC_RTC_HSE_DIV51,
    RCC_RTC_HSE_DIV52,
    RCC_RTC_HSE_DIV53,
    RCC_RTC_HSE_DIV54,
    RCC_RTC_HSE_DIV55,
    RCC_RTC_HSE_DIV56,
    RCC_RTC_HSE_DIV57,
    RCC_RTC_HSE_DIV58,
    RCC_RTC_HSE_DIV59,
    RCC_RTC_HSE_DIV60,
    RCC_RTC_HSE_DIV61,
    RCC_RTC_HSE_DIV62,
    RCC_RTC_HSE_DIV63,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_RTC_HSE_NOCLOCK => 1,
            .RCC_RTC_HSE_DIV2 => 2,
            .RCC_RTC_HSE_DIV3 => 3,
            .RCC_RTC_HSE_DIV4 => 4,
            .RCC_RTC_HSE_DIV5 => 5,
            .RCC_RTC_HSE_DIV6 => 6,
            .RCC_RTC_HSE_DIV7 => 7,
            .RCC_RTC_HSE_DIV8 => 8,
            .RCC_RTC_HSE_DIV9 => 9,
            .RCC_RTC_HSE_DIV10 => 10,
            .RCC_RTC_HSE_DIV11 => 11,
            .RCC_RTC_HSE_DIV12 => 12,
            .RCC_RTC_HSE_DIV13 => 13,
            .RCC_RTC_HSE_DIV14 => 14,
            .RCC_RTC_HSE_DIV15 => 15,
            .RCC_RTC_HSE_DIV16 => 16,
            .RCC_RTC_HSE_DIV17 => 17,
            .RCC_RTC_HSE_DIV18 => 18,
            .RCC_RTC_HSE_DIV19 => 19,
            .RCC_RTC_HSE_DIV20 => 20,
            .RCC_RTC_HSE_DIV21 => 21,
            .RCC_RTC_HSE_DIV22 => 22,
            .RCC_RTC_HSE_DIV23 => 23,
            .RCC_RTC_HSE_DIV24 => 24,
            .RCC_RTC_HSE_DIV25 => 25,
            .RCC_RTC_HSE_DIV26 => 26,
            .RCC_RTC_HSE_DIV27 => 27,
            .RCC_RTC_HSE_DIV28 => 28,
            .RCC_RTC_HSE_DIV29 => 29,
            .RCC_RTC_HSE_DIV30 => 30,
            .RCC_RTC_HSE_DIV31 => 31,
            .RCC_RTC_HSE_DIV32 => 32,
            .RCC_RTC_HSE_DIV33 => 33,
            .RCC_RTC_HSE_DIV34 => 34,
            .RCC_RTC_HSE_DIV35 => 35,
            .RCC_RTC_HSE_DIV36 => 36,
            .RCC_RTC_HSE_DIV37 => 37,
            .RCC_RTC_HSE_DIV38 => 38,
            .RCC_RTC_HSE_DIV39 => 39,
            .RCC_RTC_HSE_DIV40 => 40,
            .RCC_RTC_HSE_DIV41 => 41,
            .RCC_RTC_HSE_DIV42 => 42,
            .RCC_RTC_HSE_DIV43 => 43,
            .RCC_RTC_HSE_DIV44 => 44,
            .RCC_RTC_HSE_DIV45 => 45,
            .RCC_RTC_HSE_DIV46 => 46,
            .RCC_RTC_HSE_DIV47 => 47,
            .RCC_RTC_HSE_DIV48 => 48,
            .RCC_RTC_HSE_DIV49 => 49,
            .RCC_RTC_HSE_DIV50 => 50,
            .RCC_RTC_HSE_DIV51 => 51,
            .RCC_RTC_HSE_DIV52 => 52,
            .RCC_RTC_HSE_DIV53 => 53,
            .RCC_RTC_HSE_DIV54 => 54,
            .RCC_RTC_HSE_DIV55 => 55,
            .RCC_RTC_HSE_DIV56 => 56,
            .RCC_RTC_HSE_DIV57 => 57,
            .RCC_RTC_HSE_DIV58 => 58,
            .RCC_RTC_HSE_DIV59 => 59,
            .RCC_RTC_HSE_DIV60 => 60,
            .RCC_RTC_HSE_DIV61 => 61,
            .RCC_RTC_HSE_DIV62 => 62,
            .RCC_RTC_HSE_DIV63 => 63,
        };
    }
};
pub const RCC_MCODivList = enum {
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
pub const RCC_MCO2DivList = enum {
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
pub const PLL1PList = enum {
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
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
    FLASH_LATENCY_4,
    FLASH_LATENCY_5,
};
pub const Flash_DelayList = enum {
    FLASH_PROGRAMMING_DELAY_0,
    FLASH_PROGRAMMING_DELAY_1,
    FLASH_PROGRAMMING_DELAY_2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .FLASH_PROGRAMMING_DELAY_0 => 0,
            .FLASH_PROGRAMMING_DELAY_1 => 1,
            .FLASH_PROGRAMMING_DELAY_2 => 2,
        };
    }
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE3,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE0,
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
pub const PLL1_VCI_RangeList = enum {
    RCC_PLL1_VCIRANGE_0,
    RCC_PLL1_VCIRANGE_1,
    RCC_PLL1_VCIRANGE_2,
    RCC_PLL1_VCIRANGE_3,
};
pub const PLL2_VCI_RangeList = enum {
    RCC_PLL2_VCIRANGE_0,
    RCC_PLL2_VCIRANGE_1,
    RCC_PLL2_VCIRANGE_2,
    RCC_PLL2_VCIRANGE_3,
};
pub const PLL3_VCI_RangeList = enum {
    RCC_PLL3_VCIRANGE_0,
    RCC_PLL3_VCIRANGE_1,
    RCC_PLL3_VCIRANGE_2,
    RCC_PLL3_VCIRANGE_3,
};
pub const RCC_TIM_PRescaler_SelectionList = enum {
    RCC_TIMPRES_ACTIVATED,
    RCC_TIMPRES_DESACTIVATED,
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
pub const SDMMC1EnableList = enum {
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
pub const CECEnableList = enum {
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
pub const USART6EnableList = enum {
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
pub const I3C1EnableList = enum {
    true,
    false,
};
pub const I3C2EnableList = enum {
    true,
    false,
};
pub const OCTOSPIMEnableList = enum {
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
pub const CKPEREnableList = enum {
    true,
    false,
};
pub const SystickEnableList = enum {
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
pub const SPI4EnableList = enum {
    true,
    false,
};
pub const SPI2EnableList = enum {
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
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEDIGByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            MCO2Config: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            LPTIM3Enable: bool = false,
            LPTIM4Enable: bool = false,
            LPTIM5Enable: bool = false,
            LPTIM6Enable: bool = false,
            DAC1_Used: bool = false,
            ADC1_Used: bool = false,
            ADC2_Used: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            SPI4_Used: bool = false,
            UCPD1_Used: bool = false,
            I2S3_Used: bool = false,
            SPI3_Used: bool = false,
            I2S2_Used: bool = false,
            SPI2_Used: bool = false,
            I2S1_Used: bool = false,
            SPI1_Used: bool = false,
            OCTOSPI1_Used: bool = false,
            USB_Used: bool = false,
            RNG_Used: bool = false,
            SDMMC1_Used: bool = false,
            RTC_Used: bool = false,
            IWDG_Used: bool = false,
            CEC_Used: bool = false,
            USART1_Used: bool = false,
            USART2_Used: bool = false,
            USART3_Used: bool = false,
            UART4_Used: bool = false,
            UART5_Used: bool = false,
            USART6_Used: bool = false,
            LPUART1_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM2_Used: bool = false,
            FDCAN1_Used: bool = false,
            FDCAN2_Used: bool = false,
            I2C1_Used: bool = false,
            I2C2_Used: bool = false,
            I2C3_Used: bool = false,
            I3C1_Used: bool = false,
            I3C2_Used: bool = false,
            DAC2_Used: bool = false,
            OCTOSPI2_Used: bool = false,
            SAI1_Used: bool = false,
            SAI2_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            HSICalibrationValue: ?u32 = null,
            CSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
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
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null,
        };
        pub const Config = struct {
            HSIDiv: ?HSIDivList = null,
            HSE_VALUE: ?f32 = null,
            LSI_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLL2Source: ?PLL2SourceList = null,
            PLL3Source: ?PLL3SourceList = null,
            PLLM: ?u32 = null,
            PLL2M: ?u32 = null,
            PLL3M: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            CECCLockSelection: ?CECCLockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART3CLockSelection: ?USART3CLockSelectionList = null,
            UART4CLockSelection: ?UART4CLockSelectionList = null,
            UART5CLockSelection: ?UART5CLockSelectionList = null,
            USART6CLockSelection: ?USART6CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            DACLowPowerCLockSelection: ?DACLowPowerCLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null,
            FDCANClockSelection: ?FDCANClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            I3C1CLockSelection: ?I3C1CLockSelectionList = null,
            I3C2CLockSelection: ?I3C2CLockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCO2Div: ?RCC_MCO2DivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            CKPERSourceSelection: ?CKPERSourceSelectionList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            CortexCLockSelection: ?CortexCLockSelectionList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            APB3CLKDivider: ?APB3CLKDividerList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI3CLockSelection: ?SPI3CLockSelectionList = null,
            SPI4CLockSelection: ?SPI4CLockSelectionList = null,
            SPI2CLockSelection: ?SPI2CLockSelectionList = null,
            PLLN: ?u32 = null,
            PLLFRACN: ?u32 = null,
            PLL1P: ?PLL1PList = null,
            PLL1Q: ?u32 = null,
            PLL1R: ?u32 = null,
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
            HSIDiv: f32 = 0,
            CRSCLKoutput: f32 = 0,
            HSI48RC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            CSIRC: f32 = 0,
            AUDIOCLK: f32 = 0,
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
            CSIdivTohdmi: f32 = 0,
            CECMult: f32 = 0,
            CECoutput: f32 = 0,
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
            USART6Mult: f32 = 0,
            USART6output: f32 = 0,
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
            USBoutput: f32 = 0,
            SDMMC1Mult: f32 = 0,
            SDMMC1Output: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANOutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            I3C1Mult: f32 = 0,
            I3C1output: f32 = 0,
            I3C2Mult: f32 = 0,
            I3C2output: f32 = 0,
            OCTOSPIMMult: f32 = 0,
            OCTOSPIMoutput: f32 = 0,
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
            CKPERMult: f32 = 0,
            CKPERoutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            PWRCLKoutput: f32 = 0,
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
            hsidivToUCPD: f32 = 0,
            UCPD1Output: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI3Mult: f32 = 0,
            SPI3output: f32 = 0,
            SPI4Mult: f32 = 0,
            SPI4output: f32 = 0,
            SPI2Mult: f32 = 0,
            SPI2output: f32 = 0,
            PLLN: f32 = 0,
            PLLFRACN: f32 = 0,
            PLL1P: f32 = 0,
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
            LSI: f32 = 0,
            PLLSRC: f32 = 0,
            VCOInput: f32 = 0,
            VCOInput2: f32 = 0,
            VCOInput3: f32 = 0,
            VCOOutput: f32 = 0,
            PLLPCLK: f32 = 0,
            VCOPLL2Output: f32 = 0,
            VCOPLL3Output: f32 = 0,
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
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLL2Source: ?PLL2SourceList = null, //from RCC Clock Config
            PLL3Source: ?PLL3SourceList = null, //from RCC Clock Config
            PLLM: ?f32 = null, //from RCC Clock Config
            PLL2M: ?f32 = null, //from RCC Clock Config
            PLL3M: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            CSIdivTohdmi: ?f32 = null, //from RCC Clock Config
            CECCLockSelection: ?CECCLockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from RCC Clock Config
            USART3CLockSelection: ?USART3CLockSelectionList = null, //from RCC Clock Config
            UART4CLockSelection: ?UART4CLockSelectionList = null, //from RCC Clock Config
            UART5CLockSelection: ?UART5CLockSelectionList = null, //from RCC Clock Config
            USART6CLockSelection: ?USART6CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            DACLowPowerCLockSelection: ?DACLowPowerCLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null, //from RCC Clock Config
            FDCANClockSelection: ?FDCANClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            I3C1CLockSelection: ?I3C1CLockSelectionList = null, //from RCC Clock Config
            I3C2CLockSelection: ?I3C2CLockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCO2Div: ?RCC_MCO2DivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            CKPERSourceSelection: ?CKPERSourceSelectionList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            CortexCLockSelection: ?CortexCLockSelectionList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB3CLKDivider: ?APB3CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            hsidivToUCPD: ?f32 = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI3CLockSelection: ?SPI3CLockSelectionList = null, //from RCC Clock Config
            SPI4CLockSelection: ?SPI4CLockSelectionList = null, //from RCC Clock Config
            SPI2CLockSelection: ?SPI2CLockSelectionList = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            PLL1P: ?PLL1PList = null, //from RCC Clock Config
            PLL1Q: ?f32 = null, //from RCC Clock Config
            PLL1R: ?f32 = null, //from RCC Clock Config
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
            Flash_Delay: ?Flash_DelayList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            CSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
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
            PLL1_VCI_Range: ?PLL1_VCI_RangeList = null, //from RCC Advanced Config
            PLL2_VCI_Range: ?PLL2_VCI_RangeList = null, //from RCC Advanced Config
            PLL3_VCI_Range: ?PLL3_VCI_RangeList = null, //from RCC Advanced Config
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null, //from RCC Advanced Config
            EnableCRS: ?EnableCRSList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            SDMMC1Enable: ?SDMMC1EnableList = null, //from extra RCC references
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            EnableExtClockForSAI1: ?EnableExtClockForSAI1List = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART3Enable: ?USART3EnableList = null, //from extra RCC references
            UART4Enable: ?UART4EnableList = null, //from extra RCC references
            UART5Enable: ?UART5EnableList = null, //from extra RCC references
            USART6Enable: ?USART6EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            DACEnable: ?DACEnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            I3C1Enable: ?I3C1EnableList = null, //from extra RCC references
            I3C2Enable: ?I3C2EnableList = null, //from extra RCC references
            OCTOSPIMEnable: ?OCTOSPIMEnableList = null, //from extra RCC references
            MCO2Enable: ?MCO2EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            CKPEREnable: ?CKPEREnableList = null, //from extra RCC references
            SystickEnable: ?SystickEnableList = null, //from extra RCC references
            UCPDEnable: ?UCPDEnableList = null, //from extra RCC references
            SPI1Enable: ?SPI1EnableList = null, //from extra RCC references
            SPI3Enable: ?SPI3EnableList = null, //from extra RCC references
            SPI4Enable: ?SPI4EnableList = null, //from extra RCC references
            SPI2Enable: ?SPI2EnableList = null, //from extra RCC references
            PLL1QUsed: ?f32 = null, //from extra RCC references
            PLL2PUsed: ?f32 = null, //from extra RCC references
            PLL2QUsed: ?f32 = null, //from extra RCC references
            PLL2RUsed: ?f32 = null, //from extra RCC references
            PLL3PUsed: ?f32 = null, //from extra RCC references
            PLL3QUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            PLL2Used: ?f32 = null, //from extra RCC references
            PLL3Used: ?f32 = null, //from extra RCC references
            PLL1PUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
            PLL3RUsed: ?f32 = null, //from extra RCC references
            PLL1RUsed: ?f32 = null, //from extra RCC references
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

            var SysSourceHSI: bool = false;
            var SysSourceCSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var PLLSourceCSI: bool = false;
            var PLLSourceHSI: bool = false;
            var PLLSourceHSE: bool = false;
            var PLL2SourceCSI: bool = false;
            var PLL2SourceHSI: bool = false;
            var PLL2SourceHSE: bool = false;
            var PLL3SourceCSI: bool = false;
            var PLL3SourceHSI: bool = false;
            var PLL3SourceHSE: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var CEC_LSE: bool = false;
            var CEC_CSI: bool = false;
            var CEC_LSI: bool = false;
            var USART1_PLL2: bool = false;
            var USART1_HSI: bool = false;
            var USART1_LSE: bool = false;
            var USART1_CSI: bool = false;
            var USART1_PLL3: bool = false;
            var USART2_PLL2: bool = false;
            var USART2_HSI: bool = false;
            var USART2_LSE: bool = false;
            var USART2_CSI: bool = false;
            var USART2_PLL3: bool = false;
            var USART3_PLL2: bool = false;
            var USART3_HSI: bool = false;
            var USART3_LSE: bool = false;
            var USART3_CSI: bool = false;
            var USART3_PLL3: bool = false;
            var UART4_PLL2: bool = false;
            var UART4_HSI: bool = false;
            var UART4_LSE: bool = false;
            var UART4_CSI: bool = false;
            var UART4_PLL3: bool = false;
            var UART5_PLL2: bool = false;
            var UART5_HSI: bool = false;
            var UART5_LSE: bool = false;
            var UART5_CSI: bool = false;
            var UART5_PLL3: bool = false;
            var USART6_PLL2: bool = false;
            var USART6_HSI: bool = false;
            var USART6_LSE: bool = false;
            var USART6_CSI: bool = false;
            var USART6_PLL3: bool = false;
            var LPUART1_PLL2: bool = false;
            var LPUART1_HSI: bool = false;
            var LPUART1_LSE: bool = false;
            var LPUART1_CSI: bool = false;
            var LPUART1_PLL3: bool = false;
            var LPTIM1_PLL2: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1_CLKP: bool = false;
            var LPTIM1_PLL3: bool = false;
            var LPTIM2_PLL2: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2_CLKP: bool = false;
            var LPTIM2_PLL3: bool = false;
            var DAC1LPCLKSOURCE_LSE: bool = false;
            var DAC1LPCLKSOURCE_LSI: bool = false;
            var ADCSourceSys: bool = false;
            var ADCSourcePLL2R: bool = false;
            var ADCSourceHSE: bool = false;
            var ADCSourceHSI: bool = false;
            var ADCSourceCSI: bool = false;
            var USBSourcePLL3Q: bool = false;
            var USBSourcePLL1Q: bool = false;
            var USBSourceHSI48: bool = false;
            var SDMMC1SourceIsPllQ: bool = false;
            var SDMMC1_PLL2: bool = false;
            var FDCAN_PLL1Q: bool = false;
            var FDCAN_PLL2Q: bool = false;
            var FDCAN_HSE: bool = false;
            var I2C1_PLL3: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C1SourceCSI: bool = false;
            var I2C2_PLL3: bool = false;
            var I2C2SourceHSI: bool = false;
            var I2C2SourceCSI: bool = false;
            var I2C3_PLL3: bool = false;
            var I2C3SourceHSI: bool = false;
            var I2C3SourceCSI: bool = false;
            var I3C1_PLL3: bool = false;
            var I3C1SourceHSI: bool = false;
            var I3C2_PLL3: bool = false;
            var I3C2SourceHSI: bool = false;
            var OCTOSPI_PLL1Q: bool = false;
            var OCTOSPI_PLL2R: bool = false;
            var OSPI_CLKP: bool = false;
            var RNGCLKSOURCE_HSI48: bool = false;
            var RNGCLKSOURCE_PLL1Q: bool = false;
            var RNGCLKSOURCE_LSE: bool = false;
            var RNGCLKSOURCE_LSI: bool = false;
            var MCO1_PLL1QCLK: bool = false;
            var MCO2_LSI: bool = false;
            var MCO2_HSE: bool = false;
            var MCO2_CSI: bool = false;
            var MCO2_PLL1PCLK: bool = false;
            var MCO2_PLL2PCLK: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var CKPER_HSI: bool = false;
            var CKPER_HSE: bool = false;
            var CKPER_CSI: bool = false;
            var CLKSOURCE_HCLK_1_8: bool = false;
            var CLKSOURCE_LSE: bool = false;
            var CLKSOURCE_LSI: bool = false;
            var SPI1_PLL1: bool = false;
            var SPI1_PLL2: bool = false;
            var SPI1_PLL3: bool = false;
            var SPI1_CLKP: bool = false;
            var SPI3_PLL1: bool = false;
            var SPI3_PLL2: bool = false;
            var SPI3_PLL3: bool = false;
            var SPI3_CLKP: bool = false;
            var SPI4_PLL2: bool = false;
            var SPI4_HSI: bool = false;
            var SPI4_CSI: bool = false;
            var SPI4_HSE: bool = false;
            var SPI4_PLL3: bool = false;
            var SPI2_PLL1: bool = false;
            var SPI2_PLL2: bool = false;
            var SPI2_PLL3: bool = false;
            var SPI2_CLKP: bool = false;
            var AHBCLKDivider1: bool = false;
            var CLKSOURCE_HCLK: bool = false;
            var CLKSOURCE_HCLK_DIV8: bool = false;
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
            var TimPrescalerEnabled: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var CECFreq_ValueLimit: Limit = .{};
            var USART1Freq_ValueLimit: Limit = .{};
            var USART2Freq_ValueLimit: Limit = .{};
            var USART3Freq_ValueLimit: Limit = .{};
            var UART4Freq_ValueLimit: Limit = .{};
            var UART5Freq_ValueLimit: Limit = .{};
            var USART6Freq_ValueLimit: Limit = .{};
            var LPUART1Freq_ValueLimit: Limit = .{};
            var LPTIM1Freq_ValueLimit: Limit = .{};
            var LPTIM2Freq_ValueLimit: Limit = .{};
            var DACFreq_ValueLimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var USBFreq_ValueLimit: Limit = .{};
            var SDMMC1Freq_ValueLimit: Limit = .{};
            var FDCANFreq_ValueLimit: Limit = .{};
            var I2C1Freq_ValueLimit: Limit = .{};
            var I2C2Freq_ValueLimit: Limit = .{};
            var I2C3Freq_ValueLimit: Limit = .{};
            var I3C1Freq_ValueLimit: Limit = .{};
            var I3C2Freq_ValueLimit: Limit = .{};
            var OCTOSPIMFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var CKPERFreq_ValueLimit: Limit = .{};
            var PWRFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var AHBFreq_ValueLimit: Limit = .{};
            var CortexFreq_ValueLimit: Limit = .{};
            var FCLKCortexFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB1TimFreq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var APB3Freq_ValueLimit: Limit = .{};
            var APB2TimFreq_ValueLimit: Limit = .{};
            var SPI1Freq_ValueLimit: Limit = .{};
            var SPI3Freq_ValueLimit: Limit = .{};
            var SPI4Freq_ValueLimit: Limit = .{};
            var SPI2Freq_ValueLimit: Limit = .{};
            var PLLFRACNLimit: Limit = .{};
            var PLLQoutputFreq_ValueLimit: Limit = .{};
            var PLL2FRACNLimit: Limit = .{};
            var PLL2PoutputFreq_ValueLimit: Limit = .{};
            var PLL2QoutputFreq_ValueLimit: Limit = .{};
            var PLL2RoutputFreq_ValueLimit: Limit = .{};
            var PLL3FRACNLimit: Limit = .{};
            var PLL3PoutputFreq_ValueLimit: Limit = .{};
            var PLL3QoutputFreq_ValueLimit: Limit = .{};
            var VCOInputFreq_ValueLimit: Limit = .{};
            var VCOInput2Freq_ValueLimit: Limit = .{};
            var VCOInput3Freq_ValueLimit: Limit = .{};
            var VCOOutputFreq_ValueLimit: Limit = .{};
            var PLLPoutputFreq_ValueLimit: Limit = .{};
            var VCOPLL2OutputFreq_ValueLimit: Limit = .{};
            var VCOPLL3OutputFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 6.4e7;
            };
            const HSIDivValue: ?HSIDivList = blk: {
                const conf_item = config.HSIDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSI_DIV1 => {},
                        .RCC_HSI_DIV2 => {},
                        .RCC_HSI_DIV4 => {},
                        .RCC_HSI_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSI_DIV2;
            };
            const CRSFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass or config.flags.HSEDIGByPass) {
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
                break :blk config_val orelse 25000000;
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
            const CSI_VALUEValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_CSI => SysSourceCSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourcePLL = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceHSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL1_SOURCE_CSI => PLLSourceCSI = true,
                        .RCC_PLL1_SOURCE_HSI => PLLSourceHSI = true,
                        .RCC_PLL1_SOURCE_HSE => PLLSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSourceCSI = true;
                    break :blk .RCC_PLL1_SOURCE_CSI;
                };
            };
            const PLL2SourceValue: ?PLL2SourceList = blk: {
                const conf_item = config.PLL2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL2_SOURCE_CSI => PLL2SourceCSI = true,
                        .RCC_PLL2_SOURCE_HSI => PLL2SourceHSI = true,
                        .RCC_PLL2_SOURCE_HSE => PLL2SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL2SourceCSI = true;
                    break :blk .RCC_PLL2_SOURCE_CSI;
                };
            };
            const PLL3SourceValue: ?PLL3SourceList = blk: {
                const conf_item = config.PLL3Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL3_SOURCE_CSI => PLL3SourceCSI = true,
                        .RCC_PLL3_SOURCE_HSI => PLL3SourceHSI = true,
                        .RCC_PLL3_SOURCE_HSE => PLL3SourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL3SourceCSI = true;
                    break :blk .RCC_PLL3_SOURCE_CSI;
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
                    if (val > 63) {
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
                            63,
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
                    if (val > 63) {
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
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?RCC_RTC_Clock_Source_FROM_HSEList = blk: {
                const conf_item = config.RCC_RTC_Clock_Source_FROM_HSE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTC_HSE_NOCLOCK => {},
                        .RCC_RTC_HSE_DIV2 => {},
                        .RCC_RTC_HSE_DIV3 => {},
                        .RCC_RTC_HSE_DIV4 => {},
                        .RCC_RTC_HSE_DIV5 => {},
                        .RCC_RTC_HSE_DIV6 => {},
                        .RCC_RTC_HSE_DIV7 => {},
                        .RCC_RTC_HSE_DIV8 => {},
                        .RCC_RTC_HSE_DIV9 => {},
                        .RCC_RTC_HSE_DIV10 => {},
                        .RCC_RTC_HSE_DIV11 => {},
                        .RCC_RTC_HSE_DIV12 => {},
                        .RCC_RTC_HSE_DIV13 => {},
                        .RCC_RTC_HSE_DIV14 => {},
                        .RCC_RTC_HSE_DIV15 => {},
                        .RCC_RTC_HSE_DIV16 => {},
                        .RCC_RTC_HSE_DIV17 => {},
                        .RCC_RTC_HSE_DIV18 => {},
                        .RCC_RTC_HSE_DIV19 => {},
                        .RCC_RTC_HSE_DIV20 => {},
                        .RCC_RTC_HSE_DIV21 => {},
                        .RCC_RTC_HSE_DIV22 => {},
                        .RCC_RTC_HSE_DIV23 => {},
                        .RCC_RTC_HSE_DIV24 => {},
                        .RCC_RTC_HSE_DIV25 => {},
                        .RCC_RTC_HSE_DIV26 => {},
                        .RCC_RTC_HSE_DIV27 => {},
                        .RCC_RTC_HSE_DIV28 => {},
                        .RCC_RTC_HSE_DIV29 => {},
                        .RCC_RTC_HSE_DIV30 => {},
                        .RCC_RTC_HSE_DIV31 => {},
                        .RCC_RTC_HSE_DIV32 => {},
                        .RCC_RTC_HSE_DIV33 => {},
                        .RCC_RTC_HSE_DIV34 => {},
                        .RCC_RTC_HSE_DIV35 => {},
                        .RCC_RTC_HSE_DIV36 => {},
                        .RCC_RTC_HSE_DIV37 => {},
                        .RCC_RTC_HSE_DIV38 => {},
                        .RCC_RTC_HSE_DIV39 => {},
                        .RCC_RTC_HSE_DIV40 => {},
                        .RCC_RTC_HSE_DIV41 => {},
                        .RCC_RTC_HSE_DIV42 => {},
                        .RCC_RTC_HSE_DIV43 => {},
                        .RCC_RTC_HSE_DIV44 => {},
                        .RCC_RTC_HSE_DIV45 => {},
                        .RCC_RTC_HSE_DIV46 => {},
                        .RCC_RTC_HSE_DIV47 => {},
                        .RCC_RTC_HSE_DIV48 => {},
                        .RCC_RTC_HSE_DIV49 => {},
                        .RCC_RTC_HSE_DIV50 => {},
                        .RCC_RTC_HSE_DIV51 => {},
                        .RCC_RTC_HSE_DIV52 => {},
                        .RCC_RTC_HSE_DIV53 => {},
                        .RCC_RTC_HSE_DIV54 => {},
                        .RCC_RTC_HSE_DIV55 => {},
                        .RCC_RTC_HSE_DIV56 => {},
                        .RCC_RTC_HSE_DIV57 => {},
                        .RCC_RTC_HSE_DIV58 => {},
                        .RCC_RTC_HSE_DIV59 => {},
                        .RCC_RTC_HSE_DIV60 => {},
                        .RCC_RTC_HSE_DIV61 => {},
                        .RCC_RTC_HSE_DIV62 => {},
                        .RCC_RTC_HSE_DIV63 => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTC_HSE_NOCLOCK;
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
                    .max = 5e7,
                };

                break :blk null;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const CSIdivTohdmiValue: ?f32 = blk: {
                break :blk 122;
            };
            const CECCLockSelectionValue: ?CECCLockSelectionList = blk: {
                const conf_item = config.CECCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_LSE => CEC_LSE = true,
                        .RCC_CECCLKSOURCE_CSI_DIV122 => CEC_CSI = true,
                        .RCC_CECCLKSOURCE_LSI => CEC_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    CEC_LSE = true;
                    break :blk .RCC_CECCLKSOURCE_LSE;
                };
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 100000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 100000000, .@"=")))) {
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
                } else if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 150000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 150000000, .@"="))) and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 100000000, .@">"))) {
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
                } else if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 200000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 200000000, .@"="))) and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 150000000, .@">"))) {
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
                } else if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 250000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 250000000, .@"="))) and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 200000000, .@">"))) {
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
                } else if ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 250000000, .@">"))) {
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
            const CECFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    CECFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => {},
                        .RCC_USART1CLKSOURCE_PLL2Q => USART1_PLL2 = true,
                        .RCC_USART1CLKSOURCE_PLL3Q => USART1_PLL3 = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1_HSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1_LSE = true,
                        .RCC_USART1CLKSOURCE_CSI => USART1_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                const conf_item = config.USART2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK1 => {},
                        .RCC_USART2CLKSOURCE_PLL2Q => USART2_PLL2 = true,
                        .RCC_USART2CLKSOURCE_PLL3Q => USART2_PLL3 = true,
                        .RCC_USART2CLKSOURCE_HSI => USART2_HSI = true,
                        .RCC_USART2CLKSOURCE_LSE => USART2_LSE = true,
                        .RCC_USART2CLKSOURCE_CSI => USART2_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART2CLKSOURCE_PCLK1;
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USART3CLockSelectionValue: ?USART3CLockSelectionList = blk: {
                const conf_item = config.USART3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART3CLKSOURCE_PCLK1 => {},
                        .RCC_USART3CLKSOURCE_PLL2Q => USART3_PLL2 = true,
                        .RCC_USART3CLKSOURCE_PLL3Q => USART3_PLL3 = true,
                        .RCC_USART3CLKSOURCE_HSI => USART3_HSI = true,
                        .RCC_USART3CLKSOURCE_LSE => USART3_LSE = true,
                        .RCC_USART3CLKSOURCE_CSI => USART3_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART3CLKSOURCE_PCLK1;
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const UART4CLockSelectionValue: ?UART4CLockSelectionList = blk: {
                const conf_item = config.UART4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => {},
                        .RCC_UART4CLKSOURCE_PLL2Q => UART4_PLL2 = true,
                        .RCC_UART4CLKSOURCE_HSI => UART4_HSI = true,
                        .RCC_UART4CLKSOURCE_LSE => UART4_LSE = true,
                        .RCC_UART4CLKSOURCE_CSI => UART4_CSI = true,
                        .RCC_UART4CLKSOURCE_PLL3Q => UART4_PLL3 = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART4CLKSOURCE_PCLK1;
            };
            const UART4Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART4Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const UART5CLockSelectionValue: ?UART5CLockSelectionList = blk: {
                const conf_item = config.UART5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => {},
                        .RCC_UART5CLKSOURCE_PLL2Q => UART5_PLL2 = true,
                        .RCC_UART5CLKSOURCE_HSI => UART5_HSI = true,
                        .RCC_UART5CLKSOURCE_LSE => UART5_LSE = true,
                        .RCC_UART5CLKSOURCE_CSI => UART5_CSI = true,
                        .RCC_UART5CLKSOURCE_PLL3Q => UART5_PLL3 = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
            };
            const UART5Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART5Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USART6CLockSelectionValue: ?USART6CLockSelectionList = blk: {
                const conf_item = config.USART6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART6CLKSOURCE_PCLK1 => {},
                        .RCC_USART6CLKSOURCE_PLL2Q => USART6_PLL2 = true,
                        .RCC_USART6CLKSOURCE_PLL3Q => USART6_PLL3 = true,
                        .RCC_USART6CLKSOURCE_HSI => USART6_HSI = true,
                        .RCC_USART6CLKSOURCE_LSE => USART6_LSE = true,
                        .RCC_USART6CLKSOURCE_CSI => USART6_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART6CLKSOURCE_PCLK1;
            };
            const USART6Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    USART6Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART6Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART6Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART6Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_LPUART1CLKSOURCE_PLL2Q => LPUART1_PLL2 = true,
                        .RCC_LPUART1CLKSOURCE_PLL3Q => LPUART1_PLL3 = true,
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1_HSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1_LSE = true,
                        .RCC_LPUART1CLKSOURCE_CSI => LPUART1_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK3;
            };
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPUART1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_CLKP => LPTIM1_CLKP = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                        .RCC_LPTIM1CLKSOURCE_PCLK3 => {},
                        .RCC_LPTIM1CLKSOURCE_PLL2P => LPTIM1_PLL2 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL3R => LPTIM1_PLL3 = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK3;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                        .RCC_LPTIM2CLKSOURCE_PLL2P => LPTIM2_PLL2 = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                        .RCC_LPTIM2CLKSOURCE_PLL3R => LPTIM2_PLL3 = true,
                        .RCC_LPTIM2CLKSOURCE_CLKP => LPTIM2_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const DACLowPowerCLockSelectionValue: ?DACLowPowerCLockSelectionList = blk: {
                const conf_item = config.DACLowPowerCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DACLPCLKSOURCE_LSE => DAC1LPCLKSOURCE_LSE = true,
                        .RCC_DACLPCLKSOURCE_LSI => DAC1LPCLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    DAC1LPCLKSOURCE_LSE = true;
                    break :blk .RCC_DACLPCLKSOURCE_LSE;
                };
            };
            const DACFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    DACFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    DACFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    DACFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    DACFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_ADCDACCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        .RCC_ADCDACCLKSOURCE_PLL2R => ADCSourcePLL2R = true,
                        .RCC_ADCDACCLKSOURCE_HSE => ADCSourceHSE = true,
                        .RCC_ADCDACCLKSOURCE_HSI => ADCSourceHSI = true,
                        .RCC_ADCDACCLKSOURCE_CSI => ADCSourceCSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADCDACCLKSOURCE_HCLK;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                if (scale1 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    ADCFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL3Q => USBSourcePLL3Q = true,
                        .RCC_USBCLKSOURCE_PLL1Q => USBSourcePLL1Q = true,
                        .RCC_USBCLKSOURCE_HSI48 => USBSourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    USBSourceHSI48 = true;
                    break :blk .RCC_USBCLKSOURCE_HSI48;
                };
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                USBFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };
            const SDMMC1ClockSelectionValue: ?SDMMC1ClockSelectionList = blk: {
                const conf_item = config.SDMMC1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC1CLKSOURCE_PLL1Q => SDMMC1SourceIsPllQ = true,
                        .RCC_SDMMC1CLKSOURCE_PLL2R => SDMMC1_PLL2 = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1SourceIsPllQ = true;
                    break :blk .RCC_SDMMC1CLKSOURCE_PLL1Q;
                };
            };
            const SDMMC1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SDMMC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SDMMC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    SDMMC1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const FDCANClockSelectionValue: ?FDCANClockSelectionList = blk: {
                const conf_item = config.FDCANClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_PLL1Q => FDCAN_PLL1Q = true,
                        .RCC_FDCANCLKSOURCE_PLL2Q => FDCAN_PLL2Q = true,
                        .RCC_FDCANCLKSOURCE_HSE => FDCAN_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    FDCAN_HSE = true;
                    break :blk .RCC_FDCANCLKSOURCE_HSE;
                };
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    FDCANFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_I2C1CLKSOURCE_PLL3R => I2C1_PLL3 = true,
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                        .RCC_I2C1CLKSOURCE_CSI => I2C1SourceCSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_I2C2CLKSOURCE_PLL3R => I2C2_PLL3 = true,
                        .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                        .RCC_I2C2CLKSOURCE_CSI => I2C2SourceCSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C2CLKSOURCE_PCLK1;
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_I2C3CLKSOURCE_PLL3R => I2C3_PLL3 = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                        .RCC_I2C3CLKSOURCE_CSI => I2C3SourceCSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK3;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C3Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_I3C1CLKSOURCE_PLL3R => I3C1_PLL3 = true,
                        .RCC_I3C1CLKSOURCE_HSI => I3C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C1CLKSOURCE_PCLK1;
            };
            const I3C1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I3C1Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const I3C2CLockSelectionValue: ?I3C2CLockSelectionList = blk: {
                const conf_item = config.I3C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I3C2CLKSOURCE_PCLK3 => {},
                        .RCC_I3C2CLKSOURCE_PLL3R => I3C2_PLL3 = true,
                        .RCC_I3C2CLKSOURCE_HSI => I3C2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C2CLKSOURCE_PCLK3;
            };
            const I3C2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I3C2Freq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const OCTOSPIMCLockSelectionValue: ?OCTOSPIMCLockSelectionList = blk: {
                const conf_item = config.OCTOSPIMCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_OSPICLKSOURCE_HCLK => {},
                        .RCC_OSPICLKSOURCE_PLL1Q => OCTOSPI_PLL1Q = true,
                        .RCC_OSPICLKSOURCE_PLL2R => OCTOSPI_PLL2R = true,
                        .RCC_OSPICLKSOURCE_CLKP => OSPI_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_OSPICLKSOURCE_HCLK;
            };
            const OCTOSPIMFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    OCTOSPIMFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .RCC_RNGCLKSOURCE_PLL1Q => RNGCLKSOURCE_PLL1Q = true,
                        .RCC_RNGCLKSOURCE_LSE => RNGCLKSOURCE_LSE = true,
                        .RCC_RNGCLKSOURCE_LSI => RNGCLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RNGCLKSOURCE_HSI48 = true;
                    break :blk .RCC_RNGCLKSOURCE_HSI48;
                };
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    RNGFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_PLL1Q => MCO1_PLL1QCLK = true,
                        .RCC_MCO1SOURCE_HSI48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_HSI;
            };
            const RCC_MCODivValue: ?RCC_MCODivList = blk: {
                const conf_item = config.RCC_MCODiv;
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
                break :blk 4e6;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_LSI => MCO2_LSI = true,
                        .RCC_MCO2SOURCE_HSE => MCO2_HSE = true,
                        .RCC_MCO2SOURCE_CSI => MCO2_CSI = true,
                        .RCC_MCO2SOURCE_PLL1P => MCO2_PLL1PCLK = true,
                        .RCC_MCO2SOURCE_PLL2P => MCO2_PLL2PCLK = true,
                        .RCC_MCO2SOURCE_SYSCLK => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO2SOURCE_SYSCLK;
            };
            const RCC_MCO2DivValue: ?RCC_MCO2DivList = blk: {
                const conf_item = config.RCC_MCO2Div;
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

                break :blk conf_item orelse {
                    LSCOSSourceLSI = true;
                    break :blk .RCC_LSCOSOURCE_LSI;
                };
            };
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const CKPERSourceSelectionValue: ?CKPERSourceSelectionList = blk: {
                const conf_item = config.CKPERSourceSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLKPSOURCE_HSI => CKPER_HSI = true,
                        .RCC_CLKPSOURCE_CSI => CKPER_CSI = true,
                        .RCC_CLKPSOURCE_HSE => CKPER_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    CKPER_HSI = true;
                    break :blk .RCC_CLKPSOURCE_HSI;
                };
            };
            const CKPERFreq_ValueValue: ?f32 = blk: {
                CKPERFreq_ValueLimit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
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
                PWRFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                AHBFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
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
            const CortexFreq_ValueValue: ?f32 = blk: {
                CortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                FCLKCortexFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
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
                    .max = 2.5e8,
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
                APB1TimFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
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
                    .max = 2.5e8,
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
                    .max = 2.5e8,
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
                APB2TimFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };
            const hsidivToUCPDValue: ?f32 = blk: {
                break :blk 4;
            };
            const UCPD1outputFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PLL1Q => SPI1_PLL1 = true,
                        .RCC_SPI1CLKSOURCE_PLL2P => SPI1_PLL2 = true,
                        .RCC_SPI1CLKSOURCE_PLL3P => SPI1_PLL3 = true,
                        .RCC_SPI1CLKSOURCE_PIN => {},
                        .RCC_SPI1CLKSOURCE_CLKP => SPI1_CLKP = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI1_PLL1 = true;
                    break :blk .RCC_SPI1CLKSOURCE_PLL1Q;
                };
            };
            const SPI1Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SPI3CLockSelectionValue: ?SPI3CLockSelectionList = blk: {
                const conf_item = config.SPI3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3CLKSOURCE_PLL1Q => SPI3_PLL1 = true,
                        .RCC_SPI3CLKSOURCE_PLL2P => SPI3_PLL2 = true,
                        .RCC_SPI3CLKSOURCE_PLL3P => SPI3_PLL3 = true,
                        .RCC_SPI3CLKSOURCE_PIN => {},
                        .RCC_SPI3CLKSOURCE_CLKP => SPI3_CLKP = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI3_PLL1 = true;
                    break :blk .RCC_SPI3CLKSOURCE_PLL1Q;
                };
            };
            const SPI3Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI3Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SPI4CLockSelectionValue: ?SPI4CLockSelectionList = blk: {
                const conf_item = config.SPI4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI4CLKSOURCE_PCLK2 => {},
                        .RCC_SPI4CLKSOURCE_PLL2Q => SPI4_PLL2 = true,
                        .RCC_SPI4CLKSOURCE_HSI => SPI4_HSI = true,
                        .RCC_SPI4CLKSOURCE_CSI => SPI4_CSI = true,
                        .RCC_SPI4CLKSOURCE_HSE => SPI4_HSE = true,
                        .RCC_SPI4CLKSOURCE_PLL3Q => SPI4_PLL3 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI4CLKSOURCE_PCLK2;
            };
            const SPI4Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI4Freq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI4Freq_ValueLimit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI4Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const SPI2CLockSelectionValue: ?SPI2CLockSelectionList = blk: {
                const conf_item = config.SPI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI2CLKSOURCE_PLL1Q => SPI2_PLL1 = true,
                        .RCC_SPI2CLKSOURCE_PLL2P => SPI2_PLL2 = true,
                        .RCC_SPI2CLKSOURCE_PLL3P => SPI2_PLL3 = true,
                        .RCC_SPI2CLKSOURCE_PIN => {},
                        .RCC_SPI2CLKSOURCE_CLKP => SPI2_CLKP = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI2_PLL1 = true;
                    break :blk .RCC_SPI2CLKSOURCE_PLL1Q;
                };
            };
            const SPI2Freq_ValueValue: ?f32 = blk: {
                if (scale1) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI2Freq_ValueLimit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                break :blk 4e6;
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
                PLLFRACNLimit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PLL1PValue: ?PLL1PList = blk: {
                const conf_item = config.PLL1P;
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
            const PLL1QUsedValue: ?f32 = blk: {
                if (USBSourcePLL1Q and config.flags.USB_Used or SDMMC1SourceIsPllQ and config.flags.SDMMC1_Used or FDCAN_PLL1Q and (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used) or OCTOSPI_PLL1Q and config.flags.OCTOSPI1_Used or RNGCLKSOURCE_PLL1Q and config.flags.RNG_Used or MCO1_PLL1QCLK and config.flags.MCOConfig or SPI1_PLL1 and (config.flags.SPI1_Used or config.flags.I2S1_Used) or SPI3_PLL1 and (config.flags.SPI3_Used or config.flags.I2S3_Used) or SPI2_PLL1 and (config.flags.SPI2_Used or config.flags.I2S2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLQoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const PLL1RValue: ?f32 = blk: {
                const config_val = config.PLL1R;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1R",
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
                            "PLL1R",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                PLL2FRACNLimit = .{
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
            const PLL2PUsedValue: ?f32 = blk: {
                if (config.flags.LPTIM2_Used and LPTIM2_PLL2 or config.flags.LPTIM1_Used and LPTIM1_PLL2 or (config.flags.SPI1_Used or config.flags.I2S1_Used) and SPI1_PLL2 or (config.flags.SPI3_Used or config.flags.I2S3_Used) and SPI3_PLL2 or (config.flags.SPI2_Used or config.flags.I2S2_Used) and SPI2_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2PoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
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
            const PLL2QUsedValue: ?f32 = blk: {
                if (config.flags.USART1_Used and USART1_PLL2 or config.flags.USART2_Used and USART2_PLL2 or config.flags.USART3_Used and USART3_PLL2 or config.flags.UART4_Used and UART4_PLL2 or config.flags.UART5_Used and UART5_PLL2 or config.flags.USART6_Used and USART6_PLL2 or config.flags.LPUART1_Used and LPUART1_PLL2 or (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used) and FDCAN_PLL2Q or config.flags.SPI4_Used and SPI4_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2QoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
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
            const PLL2RUsedValue: ?f32 = blk: {
                if (ADCSourcePLL2R and (config.flags.ADC1_Used and config.flags.ADC1UsedAsynchronousCLK_ForRCC or config.flags.ADC2_Used and config.flags.ADC2UsedAsynchronousCLK_ForRCC or config.flags.DAC1_Used or config.flags.DAC2_Used) or SDMMC1_PLL2 and config.flags.SDMMC1_Used or OCTOSPI_PLL2R and (config.flags.OCTOSPI1_Used or config.flags.OCTOSPI2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2RoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2RoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2RoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2RoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2RoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
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
                PLL3FRACNLimit = .{
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
            const PLL3PUsedValue: ?f32 = blk: {
                if (check_MCU("SAI1SourcePLL3P") and config.flags.SAI1_Used or check_MCU("SAI2SourcePLL3P") and config.flags.SAI2_Used or SPI1_PLL3 and (config.flags.SPI1_Used or config.flags.I2S1_Used) or SPI3_PLL3 and (config.flags.SPI3_Used or config.flags.I2S3_Used) or SPI2_PLL3 and (config.flags.SPI2_Used or config.flags.I2S2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3PoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3PoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
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
            const PLL3QUsedValue: ?f32 = blk: {
                if (USART1_PLL3 and config.flags.USART1_Used or USART2_PLL3 and config.flags.USART2_Used or USART3_PLL3 and config.flags.USART3_Used or UART4_PLL3 and config.flags.UART4_Used or UART5_PLL3 and config.flags.UART5_Used or USART6_PLL3 and config.flags.USART6_Used or LPUART1_PLL3 and config.flags.LPUART1_Used or USBSourcePLL3Q and config.flags.USB_Used or SPI4_PLL3 and config.flags.SPI4_Used) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3QoutputFreq_ValueValue: ?f32 = blk: {
                if (scale1 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3QoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
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
            const PLL3RoutputFreq_ValueValue: ?f32 = blk: {
                break :blk 4.571429e6;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if (SysSourcePLL) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1RUsedValue: ?f32 = blk: {
                break :blk 0;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) {
                    VCOInputFreq_ValueLimit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput2Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCOInput2Freq_ValueLimit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if (LPTIM1_PLL3 and config.flags.LPTIM1_Used or LPTIM2_PLL3 and config.flags.LPTIM2_Used or I2C1_PLL3 and config.flags.I2C1_Used or I2C2_PLL3 and config.flags.I2C2_Used or I2C3_PLL3 and config.flags.I2C3_Used or I3C1_PLL3 and config.flags.I3C1_Used) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCOInput3Freq_ValueLimit = .{
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 1000000, .@">") or (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 2000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 2000000, .@">") or (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 2000000, .@"="))) and (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 4000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 8000000, .@"="))) and (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 8000000, .@"<")) or (check_ref(@TypeOf(VCOInputFreq_ValueValue), VCOInputFreq_ValueValue, 8000000, .@"="))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_3;
                break :blk item;
            };
            const VCOOutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL1_VCI_RangeValue), PLL1_VCI_RangeValue, .RCC_PLL1_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
            };
            const PLLPoutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLLPoutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                break :blk 4.571429e6;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 1000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 2000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 8000000, .@"="))) and ((check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(VCOInput2Freq_ValueValue), VCOInput2Freq_ValueValue, 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_3;
                break :blk item;
            };
            const VCOPLL2OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2_VCI_RangeValue), PLL2_VCI_RangeValue, .RCC_PLL2_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2OutputFreq_ValueLimit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2OutputFreq_ValueLimit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
            };
            const PLL3_VCI_RangeValue: ?PLL3_VCI_RangeList = blk: {
                if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 16000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 4000000, .@"="))) and (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@">") or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 8000000, .@"="))) and ((check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(VCOInput3Freq_ValueValue), VCOInput3Freq_ValueValue, 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_3;
                break :blk item;
            };
            const VCOPLL3OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3_VCI_RangeValue), PLL3_VCI_RangeValue, .RCC_PLL3_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3OutputFreq_ValueLimit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3OutputFreq_ValueLimit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                break :blk 3.2e7;
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
                if ((scale3 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 20000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 20000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale3 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 40000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 40000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale3 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 60000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 60000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale3 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 80000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 80000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if ((scale3 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 100000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 100000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale2 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 30000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 30000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale2 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 60000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 60000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale2 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 90000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 90000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale2 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 120000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 120000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale2 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 150000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 150000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale1 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 34000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 34000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale1 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 68000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 68000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale1 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 102000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 102000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale1 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 136000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 136000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale1 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 170000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 170000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale1 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 200000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 200000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_5;
                    break :blk item;
                } else if (scale0 and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 42000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 42000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale0 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 84000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 84000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale0 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 126000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 126000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale0 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 168000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 168000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale0 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 210000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 210000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale0 and (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 250000000, .@"<")) or (check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 250000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_5;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_LATENCY_0;
                break :blk item;
            };
            const Flash_DelayValue: ?Flash_DelayList = blk: {
                if ((check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_0, .@"=")) or (check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_1, .@"="))) {
                    const item: Flash_DelayList = .FLASH_PROGRAMMING_DELAY_0;
                    break :blk item;
                } else if ((check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_2, .@"=")) or (check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_3, .@"="))) {
                    const item: Flash_DelayList = .FLASH_PROGRAMMING_DELAY_1;
                    break :blk item;
                } else if ((check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_4, .@"=")) or (check_ref(@TypeOf(FLatencyValue), FLatencyValue, .FLASH_LATENCY_5, .@"="))) {
                    const item: Flash_DelayList = .FLASH_PROGRAMMING_DELAY_2;
                    break :blk item;
                }
                break :blk null;
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
            const CSICalibrationValueValue: ?f32 = blk: {
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
                    if (val > 63) {
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
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
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
                    if (val > 127) {
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
                            127,
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
            const LSEUsedValue: ?f32 = blk: {
                if ((LSCOSSourceLSE and config.flags.LSCOConfig) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and config.flags.MCOConfig)) {
                    break :blk 1;
                } else if (config.flags.RTC_Used and RTCSourceLSE or config.flags.USART1_Used and USART1_LSE or config.flags.USART2_Used and USART2_LSE or config.flags.USART3_Used and USART3_LSE or config.flags.UART4_Used and UART4_LSE or config.flags.UART5_Used and UART5_LSE or config.flags.USART6_Used and USART6_LSE) {
                    break :blk 1;
                } else if (config.flags.LPUART1_Used and LPUART1_LSE or LPTIM1SOURCELSE and config.flags.LPTIM1_Used or LPTIM2SOURCELSE and config.flags.LPTIM2_Used) {
                    break :blk 1;
                } else if (DAC1LPCLKSOURCE_LSE and config.flags.DAC1_Used or RNGCLKSOURCE_LSE and config.flags.RNG_Used or CLKSOURCE_LSE or CEC_LSE and config.flags.CEC_Used) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSE_Drive_CapabilityValue: ?LSE_Drive_CapabilityList = blk: {
                if ((config.flags.LSEOscillator) and (check_ref(@TypeOf(LSEUsedValue), LSEUsedValue, 1, .@"="))) {
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
                if (config.flags.USB_Used) {
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const SDMMC1EnableValue: ?SDMMC1EnableList = blk: {
                if (config.flags.SDMMC1_Used) {
                    const item: SDMMC1EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC1EnableList = .false;
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
            const CECEnableValue: ?CECEnableList = blk: {
                if (config.flags.CEC_Used) {
                    const item: CECEnableList = .true;
                    break :blk item;
                }
                const item: CECEnableList = .false;
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
            const USART2EnableValue: ?USART2EnableList = blk: {
                if (config.flags.USART2_Used) {
                    const item: USART2EnableList = .true;
                    break :blk item;
                }
                const item: USART2EnableList = .false;
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
            const UART5EnableValue: ?UART5EnableList = blk: {
                if (config.flags.UART5_Used) {
                    const item: UART5EnableList = .true;
                    break :blk item;
                }
                const item: UART5EnableList = .false;
                break :blk item;
            };
            const USART6EnableValue: ?USART6EnableList = blk: {
                if (config.flags.USART6_Used) {
                    const item: USART6EnableList = .true;
                    break :blk item;
                }
                const item: USART6EnableList = .false;
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
            const DACEnableValue: ?DACEnableList = blk: {
                if (check_MCU("DAC1")) {
                    const item: DACEnableList = .true;
                    break :blk item;
                }
                const item: DACEnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.ADC1_Used) or (config.flags.ADC2_Used)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used) {
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
            const OCTOSPIMEnableValue: ?OCTOSPIMEnableList = blk: {
                if (config.flags.OCTOSPI1_Used) {
                    const item: OCTOSPIMEnableList = .true;
                    break :blk item;
                }
                const item: OCTOSPIMEnableList = .false;
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
            const LSCOEnableValue: ?LSCOEnableList = blk: {
                if (config.flags.LSCOConfig) {
                    const item: LSCOEnableList = .true;
                    break :blk item;
                }
                const item: LSCOEnableList = .false;
                break :blk item;
            };
            const CKPEREnableValue: ?CKPEREnableList = blk: {
                if ((config.flags.SPI1_Used or config.flags.I2S1_Used) or (config.flags.SPI2_Used or config.flags.I2S2_Used) or (config.flags.SPI3_Used or config.flags.I2S3_Used) or config.flags.LPTIM1_Used or config.flags.LPTIM2_Used or config.flags.OCTOSPI1_Used) {
                    const item: CKPEREnableList = .true;
                    break :blk item;
                }
                const item: CKPEREnableList = .false;
                break :blk item;
            };
            const SystickEnableValue: ?SystickEnableList = blk: {
                if (check_MCU("Systick_External")) {
                    const item: SystickEnableList = .true;
                    break :blk item;
                }
                const item: SystickEnableList = .false;
                break :blk item;
            };
            const UCPDEnableValue: ?UCPDEnableList = blk: {
                if ((config.flags.UCPD1_Used)) {
                    const item: UCPDEnableList = .true;
                    break :blk item;
                }
                const item: UCPDEnableList = .false;
                break :blk item;
            };
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.SPI1_Used or config.flags.I2S1_Used) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3_Used or config.flags.I2S3_Used) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
                break :blk item;
            };
            const SPI4EnableValue: ?SPI4EnableList = blk: {
                if (config.flags.SPI4_Used) {
                    const item: SPI4EnableList = .true;
                    break :blk item;
                }
                const item: SPI4EnableList = .false;
                break :blk item;
            };
            const SPI2EnableValue: ?SPI2EnableList = blk: {
                if (config.flags.SPI2_Used or config.flags.I2S2_Used) {
                    const item: SPI2EnableList = .true;
                    break :blk item;
                }
                const item: SPI2EnableList = .false;
                break :blk item;
            };
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((RTCSourceLSE and config.flags.RTC_Used)) {
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

            var HSIDiv = ClockNode{
                .name = "HSIDiv",
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

            var CSIRC = ClockNode{
                .name = "CSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var AUDIOCLK = ClockNode{
                .name = "AUDIOCLK",
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

            var CSIdivTohdmi = ClockNode{
                .name = "CSIdivTohdmi",
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

            var SDMMC1Output = ClockNode{
                .name = "SDMMC1Output",
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

            var CKPERMult = ClockNode{
                .name = "CKPERMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CKPERoutput = ClockNode{
                .name = "CKPERoutput",
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

            var hsidivToUCPD = ClockNode{
                .name = "hsidivToUCPD",
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

            var SPI4Mult = ClockNode{
                .name = "SPI4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI4output = ClockNode{
                .name = "SPI4output",
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

            var PLLPCLK = ClockNode{
                .name = "PLLPCLK",
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
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CRSFreq_ValueValue);
                CRSCLKoutput.nodetype = .output;
                CRSCLKoutput.parents = &.{&HSI48RC};
            }
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(EnableExtClockForSAI1Value), EnableExtClockForSAI1Value, .true, .@"=")) {
                const AUDIOCLK_clk_value = EXTERNAL_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "AUDIOCLK",
                    "Else",
                    "No Extra Log",
                    "EXTERNAL_CLOCK_VALUE",
                });
                AUDIOCLK.nodetype = .source;
                AUDIOCLK.value = AUDIOCLK_clk_value;
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
                &PLL1P,
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
                &CSIRC,
                &HSIDiv,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

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
                &CSIRC,
                &HSIDiv,
                &HSEOSC,
            };
            PLL2Source.nodetype = .multi;
            PLL2Source.parents = &.{PLL2Sourceparents[PLL2Source_clk_value.get()]};

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
                &CSIRC,
                &HSIDiv,
                &HSEOSC,
            };
            PLL3Source.nodetype = .multi;
            PLL3Source.parents = &.{PLL3Sourceparents[PLL3Source_clk_value.get()]};

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
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CSIdivTohdmi_clk_value = CSIdivTohdmiValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CSIdivTohdmi",
                    "Else",
                    "No Extra Log",
                    "CSIdivTohdmi",
                });
                CSIdivTohdmi.nodetype = .div;
                CSIdivTohdmi.value = CSIdivTohdmi_clk_value;
                CSIdivTohdmi.parents = &.{&CSIRC};
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
                    &CSIdivTohdmi,
                    &LSIRC,
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
                };
                USART2Mult.nodetype = .multi;
                USART2Mult.parents = &.{USART2Multparents[USART2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART2Freq_ValueValue);
                USART2output.limit = USART2Freq_ValueLimit;
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
                };
                UART5Mult.nodetype = .multi;
                UART5Mult.parents = &.{UART5Multparents[UART5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART5Freq_ValueValue);
                UART5output.limit = UART5Freq_ValueLimit;
                UART5output.nodetype = .output;
                UART5output.parents = &.{&UART5Mult};
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
                    &APB1Prescaler,
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
                };
                USART6Mult.nodetype = .multi;
                USART6Mult.parents = &.{USART6Multparents[USART6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART6Freq_ValueValue);
                USART6output.limit = USART6Freq_ValueLimit;
                USART6output.nodetype = .output;
                USART6output.parents = &.{&USART6Mult};
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
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
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
                    &APB3Output,
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
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
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
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
                const DACMult_clk_value = DACLowPowerCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DACMult",
                    "Else",
                    "No Extra Log",
                    "DACLowPowerCLockSelection",
                });
                const DACMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &LSIRC,
                };
                DACMult.nodetype = .multi;
                DACMult.parents = &.{DACMultparents[DACMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DACFreq_ValueValue);
                DACoutput.limit = DACFreq_ValueLimit;
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
                    &HSIDiv,
                    &CSIRC,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                ADCoutput.limit = ADCFreq_ValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const CK48Mult_clk_value = USBCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CK48Mult",
                    "Else",
                    "No Extra Log",
                    "USBCLockSelection",
                });
                const CK48Multparents = [_]*const ClockNode{
                    &PLL3Q,
                    &PLL1Q,
                    &HSI48RC,
                };
                CK48Mult.nodetype = .multi;
                CK48Mult.parents = &.{CK48Multparents[CK48Mult_clk_value.get()]};
            }
            if (check_MCU("USB_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                    USBoutput.limit = USBFreq_ValueLimit;
                    USBoutput.nodetype = .output;
                    USBoutput.parents = &.{&CK48Mult};
                }
            }
            if (check_MCU("SDMMC1_Exist")) {
                if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                    const SDMMC1Mult_clk_value = SDMMC1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SDMMC1Mult",
                        "SDMMC1_Exist",
                        "No Extra Log",
                        "SDMMC1ClockSelection",
                    });
                    const SDMMC1Multparents = [_]*const ClockNode{
                        &PLL1Q,
                        &PLL2R,
                    };
                    SDMMC1Mult.nodetype = .multi;
                    SDMMC1Mult.parents = &.{SDMMC1Multparents[SDMMC1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SDMMC1_Exist")) {
                if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SDMMC1Freq_ValueValue);
                    SDMMC1Output.limit = SDMMC1Freq_ValueLimit;
                    SDMMC1Output.nodetype = .output;
                    SDMMC1Output.parents = &.{&SDMMC1Mult};
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
                    &PLL1Q,
                    &PLL2Q,
                    &HSEOSC,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_MCU("FDCAN1_Exist")) {
                if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                    FDCANOutput.limit = FDCANFreq_ValueLimit;
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
                    &PLL3R,
                    &HSIDiv,
                    &CSIRC,
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
                    &PLL3R,
                    &HSIDiv,
                    &CSIRC,
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
                    &PLL3R,
                    &HSIDiv,
                    &CSIRC,
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
                    &PLL3R,
                    &HSIDiv,
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
                    &APB3Prescaler,
                    &PLL3R,
                    &HSIDiv,
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
                    &AHBOutput,
                    &PLL1Q,
                    &PLL2R,
                    &CKPERMult,
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
                    &PLL1Q,
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
                    &HSEOSC,
                    &HSIDiv,
                    &PLL1Q,
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
                    &LSIRC,
                    &HSEOSC,
                    &CSIRC,
                    &PLL1P,
                    &PLL2P,
                    &SysCLKOutput,
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
                    &LSIRC,
                    &LSEOSC,
                };
                LSCOMult.nodetype = .multi;
                LSCOMult.parents = &.{LSCOMultparents[LSCOMult_clk_value.get()]};
            }
            if (!(check_MCU("STM32H503EBYx") or check_MCU("STM32H503KBUx"))) {
                if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(LSCOPinFreq_ValueValue);
                    LSCOOutput.nodetype = .output;
                    LSCOOutput.parents = &.{&LSCOMult};
                }
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=")) {
                const CKPERMult_clk_value = CKPERSourceSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CKPERMult",
                    "Else",
                    "No Extra Log",
                    "CKPERSourceSelection",
                });
                const CKPERMultparents = [_]*const ClockNode{
                    &HSIDiv,
                    &HSEOSC,
                    &CSIRC,
                };
                CKPERMult.nodetype = .multi;
                CKPERMult.parents = &.{CKPERMultparents[CKPERMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CKPERFreq_ValueValue);
                CKPERoutput.limit = CKPERFreq_ValueLimit;
                CKPERoutput.nodetype = .output;
                CKPERoutput.parents = &.{&CKPERMult};
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
            if (check_ref(@TypeOf(SystickEnableValue), SystickEnableValue, .true, .@"=")) {
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
            if (check_ref(@TypeOf(SystickEnableValue), SystickEnableValue, .true, .@"=")) {
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
                    &LSIRC,
                };
                CortexCLockSelection.nodetype = .multi;
                CortexCLockSelection.parents = &.{CortexCLockSelectionparents[CortexCLockSelection_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SystickEnableValue), SystickEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
                CortexSysOutput.limit = CortexFreq_ValueLimit;
                CortexSysOutput.nodetype = .output;
                CortexSysOutput.parents = &.{&CortexCLockSelection};
            }

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
            if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                const hsidivToUCPD_clk_value = hsidivToUCPDValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "hsidivToUCPD",
                    "Else",
                    "No Extra Log",
                    "hsidivToUCPD",
                });
                hsidivToUCPD.nodetype = .div;
                hsidivToUCPD.value = hsidivToUCPD_clk_value;
                hsidivToUCPD.parents = &.{&HSIDiv};
            }
            if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UCPD1outputFreq_ValueValue);
                UCPD1Output.nodetype = .output;
                UCPD1Output.parents = &.{&hsidivToUCPD};
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
                    &PLL1Q,
                    &PLL2P,
                    &PLL3P,
                    &AUDIOCLK,
                    &CKPERMult,
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
                    &PLL1Q,
                    &PLL2P,
                    &PLL3P,
                    &AUDIOCLK,
                    &CKPERMult,
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
            if (check_MCU("SPI4_Exist")) {
                if (check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=")) {
                    const SPI4Mult_clk_value = SPI4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SPI4Mult",
                        "SPI4_Exist",
                        "No Extra Log",
                        "SPI4CLockSelection",
                    });
                    const SPI4Multparents = [_]*const ClockNode{
                        &APB2Prescaler,
                        &PLL2Q,
                        &HSIDiv,
                        &CSIRC,
                        &HSEOSC,
                        &PLL3Q,
                    };
                    SPI4Mult.nodetype = .multi;
                    SPI4Mult.parents = &.{SPI4Multparents[SPI4Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SPI4_Exist")) {
                if (check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SPI4Freq_ValueValue);
                    SPI4output.limit = SPI4Freq_ValueLimit;
                    SPI4output.nodetype = .output;
                    SPI4output.parents = &.{&SPI4Mult};
                }
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
                    &PLL1Q,
                    &PLL2P,
                    &PLL3P,
                    &AUDIOCLK,
                    &CKPERMult,
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
            PLLFRACN.limit = PLLFRACNLimit;
            PLLFRACN.nodetype = .source;
            PLLFRACN.value = PLLFRACN_clk_value;

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
            PLL1P.value = PLL1P_clk_value.get();
            PLL1P.parents = &.{&PLLN};
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLQoutputFreq_ValueValue);
                PLLQoutput.limit = PLLQoutputFreq_ValueLimit;
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLL1Q};
            }
            if (false) {
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
                PLL1R.value = PLL1R_clk_value;
                PLL1R.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
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
            PLL2FRACN.limit = PLL2FRACNLimit;
            PLL2FRACN.nodetype = .source;
            PLL2FRACN.value = PLL2FRACN_clk_value;
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                config.flags.LPTIM3Enable or
                config.flags.LPTIM4Enable or
                config.flags.LPTIM5Enable or
                config.flags.LPTIM6Enable or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                config.flags.LPTIM3Enable or
                config.flags.LPTIM4Enable or
                config.flags.LPTIM5Enable or
                config.flags.LPTIM6Enable or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL2PoutputFreq_ValueValue);
                PLL2Poutput.limit = PLL2PoutputFreq_ValueLimit;
                PLL2Poutput.nodetype = .output;
                PLL2Poutput.parents = &.{&PLL2P};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL2QoutputFreq_ValueValue);
                PLL2Qoutput.limit = PLL2QoutputFreq_ValueLimit;
                PLL2Qoutput.nodetype = .output;
                PLL2Qoutput.parents = &.{&PLL2Q};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL2RoutputFreq_ValueValue);
                PLL2Routput.limit = PLL2RoutputFreq_ValueLimit;
                PLL2Routput.nodetype = .output;
                PLL2Routput.parents = &.{&PLL2R};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C2EnableValue), I3C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
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
            PLL3FRACN.limit = PLL3FRACNLimit;
            PLL3FRACN.nodetype = .source;
            PLL3FRACN.value = PLL3FRACN_clk_value;
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL3PoutputFreq_ValueValue);
                PLL3Poutput.limit = PLL3PoutputFreq_ValueLimit;
                PLL3Poutput.nodetype = .output;
                PLL3Poutput.parents = &.{&PLL3P};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL3QoutputFreq_ValueValue);
                PLL3Qoutput.limit = PLL3QoutputFreq_ValueLimit;
                PLL3Qoutput.nodetype = .output;
                PLL3Qoutput.parents = &.{&PLL3Q};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C2EnableValue), I3C2EnableValue, .true, .@"="))
            {
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
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C2EnableValue), I3C2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLL3RoutputFreq_ValueValue);
                PLL3Routput.nodetype = .output;
                PLL3Routput.parents = &.{&PLL3R};
            }

            std.mem.doNotOptimizeAway(VCOInputFreq_ValueValue);
            VCOInput.limit = VCOInputFreq_ValueLimit;
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};

            std.mem.doNotOptimizeAway(VCOInput2Freq_ValueValue);
            VCOInput2.limit = VCOInput2Freq_ValueLimit;
            VCOInput2.nodetype = .output;
            VCOInput2.parents = &.{&PLL2M};

            std.mem.doNotOptimizeAway(VCOInput3Freq_ValueValue);
            VCOInput3.limit = VCOInput3Freq_ValueLimit;
            VCOInput3.nodetype = .output;
            VCOInput3.parents = &.{&PLL3M};

            std.mem.doNotOptimizeAway(VCOOutputFreq_ValueValue);
            VCOOutput.limit = VCOOutputFreq_ValueLimit;
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};

            std.mem.doNotOptimizeAway(PLLPoutputFreq_ValueValue);
            PLLPCLK.limit = PLLPoutputFreq_ValueLimit;
            PLLPCLK.nodetype = .output;
            PLLPCLK.parents = &.{&PLL1P};

            std.mem.doNotOptimizeAway(VCOPLL2OutputFreq_ValueValue);
            VCOPLL2Output.limit = VCOPLL2OutputFreq_ValueLimit;
            VCOPLL2Output.nodetype = .output;
            VCOPLL2Output.parents = &.{&PLL2N};

            std.mem.doNotOptimizeAway(VCOPLL3OutputFreq_ValueValue);
            VCOPLL3Output.limit = VCOPLL3OutputFreq_ValueLimit;
            VCOPLL3Output.nodetype = .output;
            VCOPLL3Output.parents = &.{&PLL3N};

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
            out.OCTOSPIMoutput = try OCTOSPIMoutput.get_output();
            out.OCTOSPIMMult = try OCTOSPIMMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.SDMMC1Output = try SDMMC1Output.get_output();
            out.SDMMC1Mult = try SDMMC1Mult.get_output();
            out.CK48Mult = try CK48Mult.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.FDCANOutput = try FDCANOutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.PLL1Q = try PLL1Q.get_output();
            out.PLL1P = try PLL1P.get_output();
            out.PLL1R = try PLL1R.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
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
            out.hsidivToUCPD = try hsidivToUCPD.get_output();
            out.CKPERoutput = try CKPERoutput.get_output();
            out.CKPERMult = try CKPERMult.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.CRSCLKoutput = try CRSCLKoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI2output = try SPI2output.get_output();
            out.SPI2Mult = try SPI2Mult.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.AUDIOCLK = try AUDIOCLK.get_output();
            out.CECoutput = try CECoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.CSIdivTohdmi = try CSIdivTohdmi.get_output();
            out.USART6output = try USART6output.get_output();
            out.USART6Mult = try USART6Mult.get_output();
            out.DACoutput = try DACoutput.get_output();
            out.DACMult = try DACMult.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.I3C1output = try I3C1output.get_output();
            out.I3C1Mult = try I3C1Mult.get_output();
            out.I3C2output = try I3C2output.get_output();
            out.I3C2Mult = try I3C2Mult.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.APB3Prescaler = try APB3Prescaler.get_output();
            out.SPI4output = try SPI4output.get_output();
            out.SPI4Mult = try SPI4Mult.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.PLL2FRACN = try PLL2FRACN.get_output();
            out.PLL3FRACN = try PLL3FRACN.get_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOInput2 = try VCOInput2.get_extra_output();
            out.VCOInput3 = try VCOInput3.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLPCLK = try PLLPCLK.get_extra_output();
            out.VCOPLL2Output = try VCOPLL2Output.get_extra_output();
            out.VCOPLL3Output = try VCOPLL3Output.get_extra_output();
            ref_out.HSIDiv = HSIDivValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLL2Source = PLL2SourceValue;
            ref_out.PLL3Source = PLL3SourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.PLL2M = PLL2MValue;
            ref_out.PLL3M = PLL3MValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.CSIdivTohdmi = CSIdivTohdmiValue;
            ref_out.CECCLockSelection = CECCLockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.USART3CLockSelection = USART3CLockSelectionValue;
            ref_out.UART4CLockSelection = UART4CLockSelectionValue;
            ref_out.UART5CLockSelection = UART5CLockSelectionValue;
            ref_out.USART6CLockSelection = USART6CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.DACLowPowerCLockSelection = DACLowPowerCLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.SDMMC1ClockSelection = SDMMC1ClockSelectionValue;
            ref_out.FDCANClockSelection = FDCANClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.I3C1CLockSelection = I3C1CLockSelectionValue;
            ref_out.I3C2CLockSelection = I3C2CLockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCO2Div = RCC_MCO2DivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.CKPERSourceSelection = CKPERSourceSelectionValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.CortexCLockSelection = CortexCLockSelectionValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB3CLKDivider = APB3CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.hsidivToUCPD = hsidivToUCPDValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI3CLockSelection = SPI3CLockSelectionValue;
            ref_out.SPI4CLockSelection = SPI4CLockSelectionValue;
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
            ref_out.Flash_Delay = Flash_DelayValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.CSICalibrationValue = CSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
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
            ref_out.PLL1_VCI_Range = PLL1_VCI_RangeValue;
            ref_out.PLL2_VCI_Range = PLL2_VCI_RangeValue;
            ref_out.PLL3_VCI_Range = PLL3_VCI_RangeValue;
            ref_out.RCC_TIM_PRescaler_Selection = RCC_TIM_PRescaler_SelectionValue;
            ref_out.EnableCRS = EnableCRSValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.SDMMC1Enable = SDMMC1EnableValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.EnableExtClockForSAI1 = EnableExtClockForSAI1Value;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.CECEnable = CECEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART3Enable = USART3EnableValue;
            ref_out.UART4Enable = UART4EnableValue;
            ref_out.UART5Enable = UART5EnableValue;
            ref_out.USART6Enable = USART6EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.DACEnable = DACEnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.I3C1Enable = I3C1EnableValue;
            ref_out.I3C2Enable = I3C2EnableValue;
            ref_out.OCTOSPIMEnable = OCTOSPIMEnableValue;
            ref_out.MCO2Enable = MCO2EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.CKPEREnable = CKPEREnableValue;
            ref_out.SystickEnable = SystickEnableValue;
            ref_out.UCPDEnable = UCPDEnableValue;
            ref_out.SPI1Enable = SPI1EnableValue;
            ref_out.SPI3Enable = SPI3EnableValue;
            ref_out.SPI4Enable = SPI4EnableValue;
            ref_out.SPI2Enable = SPI2EnableValue;
            ref_out.PLL1QUsed = PLL1QUsedValue;
            ref_out.PLL2PUsed = PLL2PUsedValue;
            ref_out.PLL2QUsed = PLL2QUsedValue;
            ref_out.PLL2RUsed = PLL2RUsedValue;
            ref_out.PLL3PUsed = PLL3PUsedValue;
            ref_out.PLL3QUsed = PLL3QUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.PLL2Used = PLL2UsedValue;
            ref_out.PLL3Used = PLL3UsedValue;
            ref_out.PLL1PUsed = PLL1PUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.PLL3RUsed = PLL3RUsedValue;
            ref_out.PLL1RUsed = PLL1RUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
