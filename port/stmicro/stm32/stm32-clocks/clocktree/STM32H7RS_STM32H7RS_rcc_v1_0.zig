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
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSI48,
    RCC_MCO1SOURCE_PLL1Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_HSI => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_LSE => 2,
            .RCC_MCO1SOURCE_HSI48 => 3,
            .RCC_MCO1SOURCE_PLL1Q => 4,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_PLL2P,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_PLL1P,
    RCC_MCO2SOURCE_CSI,
    RCC_MCO2SOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_SYSCLK => 0,
            .RCC_MCO2SOURCE_PLL2P => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_PLL1P => 3,
            .RCC_MCO2SOURCE_CSI => 4,
            .RCC_MCO2SOURCE_LSI => 5,
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
pub const SPI23CLockSelectionList = enum {
    RCC_SPI23CLKSOURCE_PLL1Q,
    RCC_SPI23CLKSOURCE_PLL2P,
    RCC_SPI23CLKSOURCE_PLL3P,
    RCC_SPI23CLKSOURCE_PIN,
    RCC_SPI23CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI23CLKSOURCE_PLL1Q => 0,
            .RCC_SPI23CLKSOURCE_PLL2P => 1,
            .RCC_SPI23CLKSOURCE_PLL3P => 2,
            .RCC_SPI23CLKSOURCE_PIN => 3,
            .RCC_SPI23CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL1Q,
    RCC_SAI1CLKSOURCE_PLL2P,
    RCC_SAI1CLKSOURCE_PLL3P,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL1Q => 0,
            .RCC_SAI1CLKSOURCE_PLL2P => 1,
            .RCC_SAI1CLKSOURCE_PLL3P => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLL1Q,
    RCC_SAI2CLKSOURCE_PLL2P,
    RCC_SAI2CLKSOURCE_PLL3P,
    RCC_SAI2CLKSOURCE_PIN,
    RCC_SAI2CLKSOURCE_CLKP,
    RCC_SAI2CLKSOURCE_SPDIF,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLL1Q => 0,
            .RCC_SAI2CLKSOURCE_PLL2P => 1,
            .RCC_SAI2CLKSOURCE_PLL3P => 2,
            .RCC_SAI2CLKSOURCE_PIN => 3,
            .RCC_SAI2CLKSOURCE_CLKP => 4,
            .RCC_SAI2CLKSOURCE_SPDIF => 5,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1_I3C1CLKSOURCE_PCLK1,
    RCC_I2C1_I3C1CLKSOURCE_PLL3R,
    RCC_I2C1_I3C1CLKSOURCE_HSI,
    RCC_I2C1_I3C1CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1_I3C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1_I3C1CLKSOURCE_PLL3R => 1,
            .RCC_I2C1_I3C1CLKSOURCE_HSI => 2,
            .RCC_I2C1_I3C1CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C23CLockSelectionList = enum {
    RCC_I2C23CLKSOURCE_PCLK1,
    RCC_I2C23CLKSOURCE_PLL3R,
    RCC_I2C23CLKSOURCE_HSI,
    RCC_I2C23CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C23CLKSOURCE_PCLK1 => 0,
            .RCC_I2C23CLKSOURCE_PLL3R => 1,
            .RCC_I2C23CLKSOURCE_HSI => 2,
            .RCC_I2C23CLKSOURCE_CSI => 3,
        };
    }
};
pub const SPDIFCLockSelectionList = enum {
    RCC_SPDIFRXCLKSOURCE_PLL1Q,
    RCC_SPDIFRXCLKSOURCE_PLL2R,
    RCC_SPDIFRXCLKSOURCE_PLL3R,
    RCC_SPDIFRXCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPDIFRXCLKSOURCE_PLL1Q => 0,
            .RCC_SPDIFRXCLKSOURCE_PLL2R => 1,
            .RCC_SPDIFRXCLKSOURCE_PLL3R => 2,
            .RCC_SPDIFRXCLKSOURCE_HSI => 3,
        };
    }
};
pub const FmcClockSelectionList = enum {
    RCC_FMCCLKSOURCE_HCLK,
    RCC_FMCCLKSOURCE_PLL1Q,
    RCC_FMCCLKSOURCE_PLL2R,
    RCC_FMCCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FMCCLKSOURCE_HCLK => 0,
            .RCC_FMCCLKSOURCE_PLL1Q => 1,
            .RCC_FMCCLKSOURCE_PLL2R => 2,
            .RCC_FMCCLKSOURCE_HSI => 3,
        };
    }
};
pub const SDMMC1CLockSelectionList = enum {
    RCC_SDMMC12CLKSOURCE_PLL2S,
    RCC_SDMMC12CLKSOURCE_PLL2T,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC12CLKSOURCE_PLL2S => 0,
            .RCC_SDMMC12CLKSOURCE_PLL2T => 1,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK2,
    RCC_USART1CLKSOURCE_PLL2Q,
    RCC_USART1CLKSOURCE_PLL3Q,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_CSI,
    RCC_USART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_PLL2Q => 1,
            .RCC_USART1CLKSOURCE_PLL3Q => 2,
            .RCC_USART1CLKSOURCE_HSI => 3,
            .RCC_USART1CLKSOURCE_CSI => 4,
            .RCC_USART1CLKSOURCE_LSE => 5,
        };
    }
};
pub const Adf1ClockSelectionList = enum {
    RCC_ADF1CLKSOURCE_HCLK,
    RCC_ADF1CLKSOURCE_PLL2P,
    RCC_ADF1CLKSOURCE_PLL3P,
    RCC_ADF1CLKSOURCE_PIN,
    RCC_ADF1CLKSOURCE_CSI,
    RCC_ADF1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADF1CLKSOURCE_HCLK => 0,
            .RCC_ADF1CLKSOURCE_PLL2P => 1,
            .RCC_ADF1CLKSOURCE_PLL3P => 2,
            .RCC_ADF1CLKSOURCE_PIN => 3,
            .RCC_ADF1CLKSOURCE_CSI => 4,
            .RCC_ADF1CLKSOURCE_HSI => 5,
        };
    }
};
pub const USART234578CLockSelectionList = enum {
    RCC_USART234578CLKSOURCE_PCLK1,
    RCC_USART234578CLKSOURCE_PLL2Q,
    RCC_USART234578CLKSOURCE_PLL3Q,
    RCC_USART234578CLKSOURCE_HSI,
    RCC_USART234578CLKSOURCE_CSI,
    RCC_USART234578CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART234578CLKSOURCE_PCLK1 => 0,
            .RCC_USART234578CLKSOURCE_PLL2Q => 1,
            .RCC_USART234578CLKSOURCE_PLL3Q => 2,
            .RCC_USART234578CLKSOURCE_HSI => 3,
            .RCC_USART234578CLKSOURCE_CSI => 4,
            .RCC_USART234578CLKSOURCE_LSE => 5,
        };
    }
};
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK4,
    RCC_LPUART1CLKSOURCE_PLL2Q,
    RCC_LPUART1CLKSOURCE_PLL3Q,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_CSI,
    RCC_LPUART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK4 => 0,
            .RCC_LPUART1CLKSOURCE_PLL2Q => 1,
            .RCC_LPUART1CLKSOURCE_PLL3Q => 2,
            .RCC_LPUART1CLKSOURCE_HSI => 3,
            .RCC_LPUART1CLKSOURCE_CSI => 4,
            .RCC_LPUART1CLKSOURCE_LSE => 5,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK1,
    RCC_LPTIM1CLKSOURCE_PLL2P,
    RCC_LPTIM1CLKSOURCE_PLL3R,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM1CLKSOURCE_PLL3R => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
            .RCC_LPTIM1CLKSOURCE_LSI => 4,
            .RCC_LPTIM1CLKSOURCE_CLKP => 5,
        };
    }
};
pub const LPTIM23CLockSelectionList = enum {
    RCC_LPTIM23CLKSOURCE_PCLK4,
    RCC_LPTIM23CLKSOURCE_PLL2P,
    RCC_LPTIM23CLKSOURCE_PLL3R,
    RCC_LPTIM23CLKSOURCE_LSE,
    RCC_LPTIM23CLKSOURCE_LSI,
    RCC_LPTIM23CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM23CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM23CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM23CLKSOURCE_PLL3R => 2,
            .RCC_LPTIM23CLKSOURCE_LSE => 3,
            .RCC_LPTIM23CLKSOURCE_LSI => 4,
            .RCC_LPTIM23CLKSOURCE_CLKP => 5,
        };
    }
};
pub const LPTIM45CLockSelectionList = enum {
    RCC_LPTIM45CLKSOURCE_PCLK4,
    RCC_LPTIM45CLKSOURCE_PLL2P,
    RCC_LPTIM45CLKSOURCE_PLL3R,
    RCC_LPTIM45CLKSOURCE_LSE,
    RCC_LPTIM45CLKSOURCE_LSI,
    RCC_LPTIM45CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM45CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM45CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM45CLKSOURCE_PLL3R => 2,
            .RCC_LPTIM45CLKSOURCE_LSE => 3,
            .RCC_LPTIM45CLKSOURCE_LSI => 4,
            .RCC_LPTIM45CLKSOURCE_CLKP => 5,
        };
    }
};
pub const SPI6CLockSelectionList = enum {
    RCC_SPI6CLKSOURCE_PCLK4,
    RCC_SPI6CLKSOURCE_PLL2Q,
    RCC_SPI6CLKSOURCE_PLL3Q,
    RCC_SPI6CLKSOURCE_HSI,
    RCC_SPI6CLKSOURCE_CSI,
    RCC_SPI6CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_PCLK4 => 0,
            .RCC_SPI6CLKSOURCE_PLL2Q => 1,
            .RCC_SPI6CLKSOURCE_PLL3Q => 2,
            .RCC_SPI6CLKSOURCE_HSI => 3,
            .RCC_SPI6CLKSOURCE_CSI => 4,
            .RCC_SPI6CLKSOURCE_HSE => 5,
        };
    }
};
pub const Spi45ClockSelectionList = enum {
    RCC_SPI45CLKSOURCE_PCLK2,
    RCC_SPI45CLKSOURCE_PLL2Q,
    RCC_SPI45CLKSOURCE_PLL3Q,
    RCC_SPI45CLKSOURCE_HSI,
    RCC_SPI45CLKSOURCE_CSI,
    RCC_SPI45CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI45CLKSOURCE_PCLK2 => 0,
            .RCC_SPI45CLKSOURCE_PLL2Q => 1,
            .RCC_SPI45CLKSOURCE_PLL3Q => 2,
            .RCC_SPI45CLKSOURCE_HSI => 3,
            .RCC_SPI45CLKSOURCE_CSI => 4,
            .RCC_SPI45CLKSOURCE_HSE => 5,
        };
    }
};
pub const USBPHYCLKSourceList = enum {
    RCC_USBPHYCCLKSOURCE_HSE,
    RCC_USBPHYCCLKSOURCE_HSE_DIV2,
    RCC_USBPHYCCLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBPHYCCLKSOURCE_HSE => 0,
            .RCC_USBPHYCCLKSOURCE_HSE_DIV2 => 1,
            .RCC_USBPHYCCLKSOURCE_PLL3Q => 2,
        };
    }
};
pub const USBCLockSelectionList = enum {
    RCC_USBOTGFSCLKSOURCE_HSI48,
    RCC_USBOTGFSCLKSOURCE_PLL3Q,
    RCC_USBOTGFSCLKSOURCE_HSE,
    RCC_USBOTGFSCLKSOURCE_CLK48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBOTGFSCLKSOURCE_HSI48 => 0,
            .RCC_USBOTGFSCLKSOURCE_PLL3Q => 1,
            .RCC_USBOTGFSCLKSOURCE_HSE => 2,
            .RCC_USBOTGFSCLKSOURCE_CLK48 => 3,
        };
    }
};
pub const FDCANCLockSelectionList = enum {
    RCC_FDCANCLKSOURCE_HSE,
    RCC_FDCANCLKSOURCE_PLL1Q,
    RCC_FDCANCLKSOURCE_PLL2P,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_HSE => 0,
            .RCC_FDCANCLKSOURCE_PLL1Q => 1,
            .RCC_FDCANCLKSOURCE_PLL2P => 2,
        };
    }
};
pub const Xspi1ClockSelectionList = enum {
    RCC_XSPI1CLKSOURCE_HCLK,
    RCC_XSPI1CLKSOURCE_PLL2S,
    RCC_XSPI1CLKSOURCE_PLL2T,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_XSPI1CLKSOURCE_HCLK => 0,
            .RCC_XSPI1CLKSOURCE_PLL2S => 1,
            .RCC_XSPI1CLKSOURCE_PLL2T => 2,
        };
    }
};
pub const PSSICLockSelectionList = enum {
    RCC_PSSICLKSOURCE_PLL3R,
    RCC_PSSICLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PSSICLKSOURCE_PLL3R => 0,
            .RCC_PSSICLKSOURCE_CLKP => 1,
        };
    }
};
pub const Xspi2ClockSelectionList = enum {
    RCC_XSPI2CLKSOURCE_HCLK,
    RCC_XSPI2CLKSOURCE_PLL2S,
    RCC_XSPI2CLKSOURCE_PLL2T,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_XSPI2CLKSOURCE_HCLK => 0,
            .RCC_XSPI2CLKSOURCE_PLL2S => 1,
            .RCC_XSPI2CLKSOURCE_PLL2T => 2,
        };
    }
};
pub const ETHPHYCLockSelectionList = enum {
    RCC_ETH1PHYCLKSOURCE_HSE,
    RCC_ETH1PHYCLKSOURCE_PLL3S,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETH1PHYCLKSOURCE_HSE => 0,
            .RCC_ETH1PHYCLKSOURCE_PLL3S => 1,
        };
    }
};
pub const ETH1CLockSelectionList = enum {
    RCC_ETH1REFCLKSOURCE_PHY,
    RCC_ETH1REFCLKSOURCE_HSE,
    RCC_ETH1REFCLKSOURCE_ETH,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETH1REFCLKSOURCE_PHY => 0,
            .RCC_ETH1REFCLKSOURCE_HSE => 1,
            .RCC_ETH1REFCLKSOURCE_ETH => 2,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_PLL2P,
    RCC_ADCCLKSOURCE_PLL3R,
    RCC_ADCCLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_PLL2P => 0,
            .RCC_ADCCLKSOURCE_PLL3R => 1,
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
pub const CPREList = enum {
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
pub const TPIUList = enum {
    RCC_TPIU_DIV,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_TPIU_DIV => 3,
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
pub const BMPREList = enum {
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
pub const PPRE5List = enum {
    RCC_APB5_DIV1,
    RCC_APB5_DIV2,
    RCC_APB5_DIV4,
    RCC_APB5_DIV8,
    RCC_APB5_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB5_DIV1 => 1,
            .RCC_APB5_DIV2 => 2,
            .RCC_APB5_DIV4 => 4,
            .RCC_APB5_DIV8 => 8,
            .RCC_APB5_DIV16 => 16,
        };
    }
};
pub const PPRE1List = enum {
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
pub const PPRE2List = enum {
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
pub const PPRE4List = enum {
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
pub const HSIDivToUCPDList = enum {
    RCC_UCPDCLKSOURCE_HSI4,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_UCPDCLKSOURCE_HSI4 => 4,
        };
    }
};
pub const RCC_USBPHY_Clock_Source_FROM_HSEList = enum {
    RCC_USBPHYCCLKSOURCE_HSE_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBPHYCCLKSOURCE_HSE_DIV2 => 2,
        };
    }
};
pub const USBPHYFreq_ValueList = enum {
    @"16000000",
    @"19200000",
    @"20000000",
    @"24000000",
    @"26000000",
    @"32000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"16000000" => 16000000,
            .@"19200000" => 19200000,
            .@"20000000" => 20000000,
            .@"24000000" => 24000000,
            .@"26000000" => 26000000,
            .@"32000000" => 32000000,
        };
    }
};
pub const CSI_DIVList = enum {
    RCC_CECCLKSOURCE_CSI,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_CECCLKSOURCE_CSI => 122,
        };
    }
};
pub const RCC_TIM_PRescaler_SelectionList = enum {
    RCC_TIMPRES_ACTIVATED,
    RCC_TIMPRES_DISABLE,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
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
    FLASH_LATENCY_7,
    FLASH_LATENCY_6,
    FLASH_LATENCY_5,
    FLASH_LATENCY_4,
    FLASH_LATENCY_3,
    FLASH_LATENCY_2,
    FLASH_LATENCY_1,
    FLASH_LATENCY_0,
};
pub const PLL1_VCI_RangeList = enum {
    RCC_PLL_VCOINPUT_RANGE0,
    RCC_PLL_VCOINPUT_RANGE1,
    RCC_PLL_VCOINPUT_RANGE2,
    RCC_PLL_VCOINPUT_RANGE3,
};
pub const PLL2_VCI_RangeList = enum {
    RCC_PLL_VCOINPUT_RANGE0,
    RCC_PLL_VCOINPUT_RANGE1,
    RCC_PLL_VCOINPUT_RANGE2,
    RCC_PLL_VCOINPUT_RANGE3,
};
pub const PLL3_VCI_RangeList = enum {
    RCC_PLL_VCOINPUT_RANGE0,
    RCC_PLL_VCOINPUT_RANGE1,
    RCC_PLL_VCOINPUT_RANGE2,
    RCC_PLL_VCOINPUT_RANGE3,
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
    RCC_CRS_SYNC_SOURCE_USB_OTG_FS,
    RCC_CRS_SYNC_SOURCE_USB_OTG_HS,
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
    RCC_PLL_VCO_LOW,
    RCC_PLL_VCO_HIGH,
};
pub const PLL2_VCO_SELList = enum {
    RCC_PLL_VCO_LOW,
    RCC_PLL_VCO_HIGH,
};
pub const PLL3_VCO_SELList = enum {
    RCC_PLL_VCO_LOW,
    RCC_PLL_VCO_HIGH,
};
pub const LSIEnableList = enum {
    true,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const DigExtClockEnableList = enum {
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
pub const cKPerEnableList = enum {
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
pub const SPI1EnableList = enum {
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
pub const SPI23EnableList = enum {
    true,
    false,
};
pub const ADF1EnableList = enum {
    true,
    false,
};
pub const LPTIM45EnableList = enum {
    true,
    false,
};
pub const LPTIM23EnableList = enum {
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
pub const USART1EnableList = enum {
    true,
    false,
};
pub const SPI45EnableList = enum {
    true,
    false,
};
pub const SDMMC1EnableList = enum {
    true,
    false,
};
pub const OCSPI1EnableList = enum {
    true,
    false,
};
pub const OCSPI2EnableList = enum {
    true,
    false,
};
pub const EnableUSBOFSList = enum {
    true,
    false,
};
pub const EnableUSBOHSList = enum {
    true,
    false,
};
pub const I2C23EnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const PSSIEnableList = enum {
    true,
    false,
};
pub const LTDCEnableList = enum {
    true,
    false,
};
pub const ETH1EnableDivList = enum {
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
pub const UCPDEnableList = enum {
    true,
    false,
};
pub const EnableHSEUSBPHYDevisorList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const DTSEnableList = enum {
    true,
    false,
};
pub const ETHClockEnableList = enum {
    true,
    false,
};
pub const ETH1EnableList = enum {
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
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEByPass: bool = false,
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEDIGByPass: bool = false,
            LSEOscillator: bool = false,
            MCO1Config: bool = false,
            MCO2Config: bool = false,
            AudioClockConfig: bool = false,
            DigitalClockConfig: bool = false,
            ETHClockConfig: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            I2S6Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            USB_OTG_FS_Used: bool = false,
            USB_OTG_HS_Used: bool = false,
            DTS_Used: bool = false,
            ADF1_Used: bool = false,
            XSPI1_Used: bool = false,
            XSPI2_Used: bool = false,
            I2C2_Used: bool = false,
            I2C3_Used: bool = false,
            I2C1_Used: bool = false,
            I3C1_Used: bool = false,
            PSSI_Used: bool = false,
            ETH_Used: bool = false,
            UCPD1_Used: bool = false,
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
            CPRE: ?CPREList = null,
            Cortex_Div: ?Cortex_DivList = null,
            BMPRE: ?BMPREList = null,
            PPRE5: ?PPRE5List = null,
            PPRE1: ?PPRE1List = null,
            PPRE2: ?PPRE2List = null,
            PPRE4: ?PPRE4List = null,
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
            DIVS1: ?u32 = null,
            DIVT1: ?u32 = null,
            DIVN2: ?u32 = null,
            PLL2FRACN: ?u32 = null,
            DIVP2: ?u32 = null,
            DIVQ2: ?u32 = null,
            DIVR2: ?u32 = null,
            DIVS2: ?u32 = null,
            DIVT2: ?u32 = null,
            DIVN3: ?u32 = null,
            PLL3FRACN: ?u32 = null,
            DIVP3: ?u32 = null,
            DIVQ3: ?u32 = null,
            DIVR3: ?u32 = null,
            DIVS3: ?u32 = null,
            DIVT3: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI23CLockSelection: ?SPI23CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C23CLockSelection: ?I2C23CLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            FmcClockSelection: ?FmcClockSelectionList = null,
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            Adf1ClockSelection: ?Adf1ClockSelectionList = null,
            USART234578CLockSelection: ?USART234578CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM23CLockSelection: ?LPTIM23CLockSelectionList = null,
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null,
            SPI6CLockSelection: ?SPI6CLockSelectionList = null,
            Spi45ClockSelection: ?Spi45ClockSelectionList = null,
            USBPHYCLKSource: ?USBPHYCLKSourceList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            FDCANCLockSelection: ?FDCANCLockSelectionList = null,
            Xspi1ClockSelection: ?Xspi1ClockSelectionList = null,
            PSSICLockSelection: ?PSSICLockSelectionList = null,
            Xspi2ClockSelection: ?Xspi2ClockSelectionList = null,
            ETHPHYCLockSelection: ?ETHPHYCLockSelectionList = null,
            ETH1CLockSelection: ?ETH1CLockSelectionList = null,
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
            Dig_CKIN: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            CPRE: f32 = 0,
            CPREOutput: f32 = 0,
            TPIUPrescaler: f32 = 0,
            TPIUOutput: f32 = 0,
            CpuClockOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            BMPRE: f32 = 0,
            AHBOutput: f32 = 0,
            AXIClockOutput: f32 = 0,
            AHB5Output: f32 = 0,
            PPRE5: f32 = 0,
            APB5Output: f32 = 0,
            AHB1234Output: f32 = 0,
            PPRE1: f32 = 0,
            APB1Output: f32 = 0,
            Tim1Mul: f32 = 0,
            Tim1Output: f32 = 0,
            PPRE2: f32 = 0,
            APB2Output: f32 = 0,
            Tim2Mul: f32 = 0,
            Tim2Output: f32 = 0,
            PPRE4: f32 = 0,
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
            DIVS1: f32 = 0,
            DIVS1output: f32 = 0,
            DIVT1: f32 = 0,
            DIVT1output: f32 = 0,
            DIVN2: f32 = 0,
            PLL2FRACN: f32 = 0,
            DIVP2: f32 = 0,
            DIVP2output: f32 = 0,
            DIVQ2: f32 = 0,
            DIVQ2output: f32 = 0,
            DIVR2: f32 = 0,
            DIVR2output: f32 = 0,
            DIVS2: f32 = 0,
            DIVS2output: f32 = 0,
            DIVT2: f32 = 0,
            DIVT2output: f32 = 0,
            DIVN3: f32 = 0,
            PLL3FRACN: f32 = 0,
            DIVP3: f32 = 0,
            DIVP3output: f32 = 0,
            DIVQ3: f32 = 0,
            DIVQ3output: f32 = 0,
            DIVR3: f32 = 0,
            DIVR3output: f32 = 0,
            DIVS3: f32 = 0,
            DIVS3output: f32 = 0,
            DIVT3: f32 = 0,
            DIVT3output: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            UCPDoutput: f32 = 0,
            HSI_DIV: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI23Mult: f32 = 0,
            SPI23output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C23Mult: f32 = 0,
            I2C23output: f32 = 0,
            SPDIFMult: f32 = 0,
            SPDIFoutput: f32 = 0,
            LTDCOutput: f32 = 0,
            FMCMult: f32 = 0,
            FMCoutput: f32 = 0,
            SDMMCMult: f32 = 0,
            SDMMCoutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            ADFMult: f32 = 0,
            ADFoutput: f32 = 0,
            USART234578Mult: f32 = 0,
            USART234578output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM23Mult: f32 = 0,
            LPTIM23output: f32 = 0,
            LPTIM45Mult: f32 = 0,
            LPTIM45output: f32 = 0,
            SPI6Mult: f32 = 0,
            SPI6output: f32 = 0,
            SPI45Mult: f32 = 0,
            SPI45output: f32 = 0,
            HSEUSBPHYDevisor: f32 = 0,
            USBPHYCLKMux: f32 = 0,
            USBPHYCLKOutput: f32 = 0,
            USBPHYRC: f32 = 0,
            USBPHYRC60: f32 = 0,
            USBOCLKMux: f32 = 0,
            USBOFSCLKOutput: f32 = 0,
            RNGOutput: f32 = 0,
            DTSOutput: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            XSPI1Mult: f32 = 0,
            XSPI1output: f32 = 0,
            PSSIMult: f32 = 0,
            PSSIoutput: f32 = 0,
            XSPI2Mult: f32 = 0,
            XSPI2output: f32 = 0,
            ETHPHYMult: f32 = 0,
            ETHPHYoutput: f32 = 0,
            ETH1Mult: f32 = 0,
            ETH1output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CECMult: f32 = 0,
            CECoutput: f32 = 0,
            CSICECDevisor: f32 = 0,
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
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEDIGByPass: bool = false,
            LSEOscillator: bool = false,
            MCO1Config: bool = false,
            MCO2Config: bool = false,
            AudioClockConfig: bool = false,
            DigitalClockConfig: bool = false,
            ETHClockConfig: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            I2S6Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            USB_OTG_FS_Used: bool = false,
            USB_OTG_HS_Used: bool = false,
            DTS_Used: bool = false,
            ADF1_Used: bool = false,
            XSPI1_Used: bool = false,
            XSPI2_Used: bool = false,
            I2C2_Used: bool = false,
            I2C3_Used: bool = false,
            I2C1_Used: bool = false,
            I3C1_Used: bool = false,
            PSSI_Used: bool = false,
            ETH_Used: bool = false,
            UCPD1_Used: bool = false,
            LSIEnable: bool = false,
            ExtClockEnable: bool = false,
            DigExtClockEnable: bool = false,
            MCO1OutPutEnable: bool = false,
            MCO2OutPutEnable: bool = false,
            cKPerEnable: bool = false,
            SAI1Enable: bool = false,
            SAI2Enable: bool = false,
            SPI1Enable: bool = false,
            SPDIFEnable: bool = false,
            FDCANEnable: bool = false,
            FMCEnable: bool = false,
            SPI23Enable: bool = false,
            ADF1Enable: bool = false,
            LPTIM45Enable: bool = false,
            LPTIM23Enable: bool = false,
            ADCEnable: bool = false,
            LPTIM1Enable: bool = false,
            SPI6Enable: bool = false,
            LPUART1Enable: bool = false,
            USART234578Enable: bool = false,
            USART1Enable: bool = false,
            SPI45Enable: bool = false,
            SDMMC1Enable: bool = false,
            OCSPI1Enable: bool = false,
            OCSPI2Enable: bool = false,
            EnableUSBOFS: bool = false,
            EnableUSBOHS: bool = false,
            I2C23Enable: bool = false,
            I2C1Enable: bool = false,
            PSSIEnable: bool = false,
            LTDCEnable: bool = false,
            ETH1EnableDiv: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            UCPDEnable: bool = false,
            EnableHSEUSBPHYDevisor: bool = false,
            RNGEnable: bool = false,
            DTSEnable: bool = false,
            ETHClockEnable: bool = false,
            ETH1Enable: bool = false,
            CECEnable: bool = false,
            PLL1QUsed: bool = false,
            PLL2PUsed: bool = false,
            PLL2QUsed: bool = false,
            PLL2RUsed: bool = false,
            PLL2SUsed: bool = false,
            PLL2TUsed: bool = false,
            PLL3PUsed: bool = false,
            PLL3QUsed: bool = false,
            PLL3RUsed: bool = false,
            PLL3SUsed: bool = false,
            PLL1Used: bool = false,
            PLL2Used: bool = false,
            PLL3Used: bool = false,
            PLL1PUsed: bool = false,
            LSEUsed: bool = false,
            HSIUsed: bool = false,
            EnableHSE: bool = false,
            EnableLSERTC: bool = false,
            EnableLSE: bool = false,
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
            DIGITAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            CPRE: ?CPREList = null, //from RCC Clock Config
            TPIU: ?TPIUList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            BMPRE: ?BMPREList = null, //from RCC Clock Config
            PPRE5: ?PPRE5List = null, //from RCC Clock Config
            PPRE1: ?PPRE1List = null, //from RCC Clock Config
            Tim1Mul: ?f32 = null, //from RCC Clock Config
            PPRE2: ?PPRE2List = null, //from RCC Clock Config
            Tim2Mul: ?f32 = null, //from RCC Clock Config
            PPRE4: ?PPRE4List = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from RCC Clock Config
            CKPERSourceSelection: ?CKPERSourceSelectionList = null, //from RCC Clock Config
            DIVM1: ?f32 = null, //from RCC Clock Config
            DIVM2: ?f32 = null, //from RCC Clock Config
            DIVM3: ?f32 = null, //from RCC Clock Config
            DIVN1: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            DIVP1: ?DIVP1List = null, //from RCC Clock Config
            DIVQ1: ?f32 = null, //from RCC Clock Config
            DIVR1: ?f32 = null, //from RCC Clock Config
            DIVS1: ?f32 = null, //from RCC Clock Config
            DIVT1: ?f32 = null, //from RCC Clock Config
            DIVN2: ?f32 = null, //from RCC Clock Config
            PLL2FRACN: ?f32 = null, //from RCC Clock Config
            DIVP2: ?f32 = null, //from RCC Clock Config
            DIVQ2: ?f32 = null, //from RCC Clock Config
            DIVR2: ?f32 = null, //from RCC Clock Config
            DIVS2: ?f32 = null, //from RCC Clock Config
            DIVT2: ?f32 = null, //from RCC Clock Config
            DIVN3: ?f32 = null, //from RCC Clock Config
            PLL3FRACN: ?f32 = null, //from RCC Clock Config
            DIVP3: ?f32 = null, //from RCC Clock Config
            DIVQ3: ?f32 = null, //from RCC Clock Config
            DIVR3: ?f32 = null, //from RCC Clock Config
            DIVS3: ?f32 = null, //from RCC Clock Config
            DIVT3: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            HSIDivToUCPD: ?HSIDivToUCPDList = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI23CLockSelection: ?SPI23CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C23CLockSelection: ?I2C23CLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            FmcClockSelection: ?FmcClockSelectionList = null, //from RCC Clock Config
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            Adf1ClockSelection: ?Adf1ClockSelectionList = null, //from RCC Clock Config
            USART234578CLockSelection: ?USART234578CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM23CLockSelection: ?LPTIM23CLockSelectionList = null, //from RCC Clock Config
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null, //from RCC Clock Config
            SPI6CLockSelection: ?SPI6CLockSelectionList = null, //from RCC Clock Config
            Spi45ClockSelection: ?Spi45ClockSelectionList = null, //from RCC Clock Config
            RCC_USBPHY_Clock_Source_FROM_HSE: ?RCC_USBPHY_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            USBPHYCLKSource: ?USBPHYCLKSourceList = null, //from RCC Clock Config
            USB_PHY_VALUE: ?f32 = null, //from RCC Clock Config
            USB_PHY_VALUE60: ?f32 = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            FDCANCLockSelection: ?FDCANCLockSelectionList = null, //from RCC Clock Config
            Xspi1ClockSelection: ?Xspi1ClockSelectionList = null, //from RCC Clock Config
            PSSICLockSelection: ?PSSICLockSelectionList = null, //from RCC Clock Config
            Xspi2ClockSelection: ?Xspi2ClockSelectionList = null, //from RCC Clock Config
            ETHPHYCLockSelection: ?ETHPHYCLockSelectionList = null, //from RCC Clock Config
            ETH1CLockSelection: ?ETH1CLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            CECCLockSelection: ?CECCLockSelectionList = null, //from RCC Clock Config
            CSI_DIV: ?CSI_DIVList = null, //from RCC Clock Config
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

            var SYSCLKSOURCE_HSI: bool = false;
            var SYSCLKSOURCE_CSI: bool = false;
            var SYSCLKSOURCE_HSE: bool = false;
            var SYSCLKSOURCE_PLLCLK: bool = false;
            var MCO1SOURCE_HSI: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var MCO1SOURCE_LSE: bool = false;
            var MCO1SOURCE_RC48: bool = false;
            var MCO1SOURCE_PLLCLK: bool = false;
            var MCO2SOURCE_SYSCLK: bool = false;
            var MCO2SOURCE_PLL2PCLK: bool = false;
            var MCO2SOURCE_HSE: bool = false;
            var MCO2SOURCE_PLLCLK: bool = false;
            var MCO2SOURCE_CSI: bool = false;
            var MCO2SOURCE_LSI: bool = false;
            var PLLSOURCE_HSI: bool = false;
            var PLLSOURCE_CSI: bool = false;
            var PLLSOURCE_HSE: bool = false;
            var PERSOURCE_HSI: bool = false;
            var PERSOURCE_CSI: bool = false;
            var PERSOURCE_HSE: bool = false;
            var SPI1CLKSOURCE_PLLQ1: bool = false;
            var SPI1CLKSOURCE_PLLP2: bool = false;
            var SPI1CLKSOURCE_PLLP3: bool = false;
            var SPI1CLKSOURCE_CKIN: bool = false;
            var SPI1CLKSOURCE_PER: bool = false;
            var SPI23CLKSOURCE_PLLQ1: bool = false;
            var SPI23CLKSOURCE_PLLP2: bool = false;
            var SPI23CLKSOURCE_PLLP3: bool = false;
            var SPI23CLKSOURCE_CKIN: bool = false;
            var SPI23CLKSOURCE_PER: bool = false;
            var SAI1CLKSOURCE_PLLQ1: bool = false;
            var SAI1CLKSOURCE_PLLP2: bool = false;
            var SAI1CLKSOURCE_PLLP3: bool = false;
            var SAI1CLKSOURCE_CKIN: bool = false;
            var SAI1CLKSOURCE_PER: bool = false;
            var SAI2CLKSOURCE_PLLQ1: bool = false;
            var SAI2CLKSOURCE_PLLP2: bool = false;
            var SAI2CLKSOURCE_PLLP3: bool = false;
            var SAI2CLKSOURCE_CKIN: bool = false;
            var SAI2CLKSOURCE_PER: bool = false;
            var SAI2CLKSOURCE_SPDIF: bool = false;
            var I2C1CLKSOURCE_PCLK1: bool = false;
            var I2C1CLKSOURCE_PLLR3: bool = false;
            var I2C1CLKSOURCE_HSI: bool = false;
            var I2C1CLKSOURCE_CSI: bool = false;
            var I2C23CLKSOURCE_PCLK1: bool = false;
            var I2C23CLKSOURCE_PLLR3: bool = false;
            var I2C23CLKSOURCE_HSI: bool = false;
            var I2C23CLKSOURCE_CSI: bool = false;
            var SPDIFCLKSOURCE_PLL1Q: bool = false;
            var SPDIFCLKSOURCE_PLL2R: bool = false;
            var SPDIFCLKSOURCE_PLL3R: bool = false;
            var SPDIFCLKSOURCE_HSI: bool = false;
            var FMCCLKSOURCE_HCLK5: bool = false;
            var FMCCLKSOURCE_PLL1Q: bool = false;
            var FMCCLKSOURCE_PLL2R: bool = false;
            var FMCCLKSOURCE_HSI: bool = false;
            var SDMMC1CLKSOURCE_PLL2S: bool = false;
            var SDMMC1CLKSOURCE_PLL2T: bool = false;
            var USART1CLKSOURCE_PCLK2: bool = false;
            var USART1CLKSOURCE_PLLQ2: bool = false;
            var USART1CLKSOURCE_PLLQ3: bool = false;
            var USART1CLKSOURCE_HSI: bool = false;
            var USART1CLKSOURCE_CSI: bool = false;
            var USART1CLKSOURCE_LSE: bool = false;
            var ADFCLKSOURCE_HCLK1: bool = false;
            var ADFCLKSOURCE_PLL2P: bool = false;
            var ADFCLKSOURCE_PLL3P: bool = false;
            var ADFCLKSOURCE_CKIN: bool = false;
            var ADFCLKSOURCE_CSI: bool = false;
            var ADFCLKSOURCE_HSI: bool = false;
            var USART2CLKSOURCE_PCLK1: bool = false;
            var USART2CLKSOURCE_PLLQ2: bool = false;
            var USART2CLKSOURCE_PLLQ3: bool = false;
            var USART2CLKSOURCE_HSI: bool = false;
            var USART2CLKSOURCE_CSI: bool = false;
            var USART2CLKSOURCE_LSE: bool = false;
            var LPUART1CLKSOURCE_PCLK4: bool = false;
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
            var LPTIM23CLKSOURCE_PCLK4: bool = false;
            var LPTIM23CLKSOURCE_PLLP2: bool = false;
            var LPTIM23CLKSOURCE_PLLR3: bool = false;
            var LPTIM23CLKSOURCE_LSE: bool = false;
            var LPTIM23CLKSOURCE_LSI: bool = false;
            var LPTIM23CLKSOURCE_PER: bool = false;
            var LPTIM45CLKSOURCE_PCLK4: bool = false;
            var LPTIM45CLKSOURCE_PLLP2: bool = false;
            var LPTIM45CLKSOURCE_PLLR3: bool = false;
            var LPTIM45CLKSOURCE_LSE: bool = false;
            var LPTIM45CLKSOURCE_LSI: bool = false;
            var LPTIM45CLKSOURCE_PER: bool = false;
            var SPI6CLKSOURCE_PCLK4: bool = false;
            var SPI6CLKSOURCE_PLLQ2: bool = false;
            var SPI6CLKSOURCE_PLLQ3: bool = false;
            var SPI6CLKSOURCE_HSI: bool = false;
            var SPI6CLKSOURCE_CSI: bool = false;
            var SPI6CLKSOURCE_HSE: bool = false;
            var SPI45CLKSOURCE_PCLK2: bool = false;
            var SPI45CLKSOURCE_PLLQ2: bool = false;
            var SPI45CLKSOURCE_PLLQ3: bool = false;
            var SPI45CLKSOURCE_HSI: bool = false;
            var SPI45CLKSOURCE_CSI: bool = false;
            var SPI45CLKSOURCE_HSE: bool = false;
            var USBPHYCLKSOURCE_HSE: bool = false;
            var USBPHYCLKSOURCE_HSE2: bool = false;
            var USBPHYCLKSOURCE_PLL3Q: bool = false;
            var USBOCLKSOURCE_RC48: bool = false;
            var USBOCLKSOURCE_PLL3Q: bool = false;
            var USBOCLKSOURCE_HSE: bool = false;
            var USBOCLKSOURCE_PHY: bool = false;
            var FDCANCLKSOURCE_HSE: bool = false;
            var FDCANCLKSOURCE_PLL1Q: bool = false;
            var FDCANCLKSOURCE_PLL2P: bool = false;
            var OSPI1CLKSOURCE_HCLK5: bool = false;
            var OSPI1CLKSOURCE_PLL2S: bool = false;
            var OSPI1CLKSOURCE_PLL2T: bool = false;
            var PSSICLKSOURCE_PLL3R: bool = false;
            var PSSICLKSOURCE_PER: bool = false;
            var OSPI2CLKSOURCE_HCLK5: bool = false;
            var OSPI2CLKSOURCE_PLL2S: bool = false;
            var OSPI2CLKSOURCE_PLL2T: bool = false;
            var ETHPHYCLKSOURCE_HSE: bool = false;
            var ETHPHYCLKSOURCE_PLL3S: bool = false;
            var ETH1CLKSOURCE_ETHPHY: bool = false;
            var ETH1CLKSOURCE_HSE: bool = false;
            var ETH1CLKSOURCE_EXT: bool = false;
            var ADCCLKSOURCE_PLL2P: bool = false;
            var ADCCLKSOURCE_PLL3R: bool = false;
            var ADCCLKSOURCE_PER: bool = false;
            var CECCLKSOURCE_LSE: bool = false;
            var CECCLKSOURCE_LSI: bool = false;
            var CECCLKSOURCE_CSI122: bool = false;
            var HCLKDiv1: bool = false;
            var PPRE1_1: bool = false;
            var PPRE1_2: bool = false;
            var PPRE1_4: bool = false;
            var PPRE2_1: bool = false;
            var PPRE2_2: bool = false;
            var PPRE2_4: bool = false;
            var TimPrescalerEnabled: bool = false;
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

            var Dig_CKIN = ClockNode{
                .name = "Dig_CKIN",
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

            var CPRE = ClockNode{
                .name = "CPRE",
                .nodetype = .off,
                .parents = &.{},
            };

            var CPREOutput = ClockNode{
                .name = "CPREOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var TPIUPrescaler = ClockNode{
                .name = "TPIUPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var TPIUOutput = ClockNode{
                .name = "TPIUOutput",
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

            var BMPRE = ClockNode{
                .name = "BMPRE",
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

            var AHB5Output = ClockNode{
                .name = "AHB5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PPRE5 = ClockNode{
                .name = "PPRE5",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB5Output = ClockNode{
                .name = "APB5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB1234Output = ClockNode{
                .name = "AHB1234Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PPRE1 = ClockNode{
                .name = "PPRE1",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1Output = ClockNode{
                .name = "APB1Output",
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

            var PPRE2 = ClockNode{
                .name = "PPRE2",
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

            var PPRE4 = ClockNode{
                .name = "PPRE4",
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

            var DIVS1 = ClockNode{
                .name = "DIVS1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVS1output = ClockNode{
                .name = "DIVS1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT1 = ClockNode{
                .name = "DIVT1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT1output = ClockNode{
                .name = "DIVT1output",
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

            var DIVS2 = ClockNode{
                .name = "DIVS2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVS2output = ClockNode{
                .name = "DIVS2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT2 = ClockNode{
                .name = "DIVT2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT2output = ClockNode{
                .name = "DIVT2output",
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

            var DIVR3output = ClockNode{
                .name = "DIVR3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVS3 = ClockNode{
                .name = "DIVS3",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVS3output = ClockNode{
                .name = "DIVS3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT3 = ClockNode{
                .name = "DIVT3",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVT3output = ClockNode{
                .name = "DIVT3output",
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

            var UCPDoutput = ClockNode{
                .name = "UCPDoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSI_DIV = ClockNode{
                .name = "HSI_DIV",
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

            var SPI23Mult = ClockNode{
                .name = "SPI23Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI23output = ClockNode{
                .name = "SPI23output",
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

            var I2C23Mult = ClockNode{
                .name = "I2C23Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C23output = ClockNode{
                .name = "I2C23output",
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

            var LTDCOutput = ClockNode{
                .name = "LTDCOutput",
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

            var ADFMult = ClockNode{
                .name = "ADFMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADFoutput = ClockNode{
                .name = "ADFoutput",
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

            var LPTIM23Mult = ClockNode{
                .name = "LPTIM23Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM23output = ClockNode{
                .name = "LPTIM23output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM45Mult = ClockNode{
                .name = "LPTIM45Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM45output = ClockNode{
                .name = "LPTIM45output",
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

            var HSEUSBPHYDevisor = ClockNode{
                .name = "HSEUSBPHYDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBPHYCLKMux = ClockNode{
                .name = "USBPHYCLKMux",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBPHYCLKOutput = ClockNode{
                .name = "USBPHYCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBPHYRC = ClockNode{
                .name = "USBPHYRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBPHYRC60 = ClockNode{
                .name = "USBPHYRC60",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBOCLKMux = ClockNode{
                .name = "USBOCLKMux",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBOFSCLKOutput = ClockNode{
                .name = "USBOFSCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGOutput = ClockNode{
                .name = "RNGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DTSOutput = ClockNode{
                .name = "DTSOutput",
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

            var XSPI1Mult = ClockNode{
                .name = "XSPI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var XSPI1output = ClockNode{
                .name = "XSPI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PSSIMult = ClockNode{
                .name = "PSSIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var PSSIoutput = ClockNode{
                .name = "PSSIoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var XSPI2Mult = ClockNode{
                .name = "XSPI2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var XSPI2output = ClockNode{
                .name = "XSPI2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ETHPHYMult = ClockNode{
                .name = "ETHPHYMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ETHPHYoutput = ClockNode{
                .name = "ETHPHYoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var ETH1Mult = ClockNode{
                .name = "ETH1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ETH1output = ClockNode{
                .name = "ETH1output",
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

            var CSICECDevisor = ClockNode{
                .name = "CSICECDevisor",
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
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 24000000;
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
            const DIGITAL_CLOCK_VALUEValue: ?f32 = blk: {
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
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_HSI => MCO1SOURCE_HSI = true,
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_LSE => MCO1SOURCE_LSE = true,
                        .RCC_MCO1SOURCE_HSI48 => MCO1SOURCE_RC48 = true,
                        .RCC_MCO1SOURCE_PLL1Q => MCO1SOURCE_PLLCLK = true,
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
                        .RCC_MCO2SOURCE_PLL2P => MCO2SOURCE_PLL2PCLK = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SOURCE_HSE = true,
                        .RCC_MCO2SOURCE_PLL1P => MCO2SOURCE_PLLCLK = true,
                        .RCC_MCO2SOURCE_CSI => MCO2SOURCE_CSI = true,
                        .RCC_MCO2SOURCE_LSI => MCO2SOURCE_LSI = true,
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
            const CPREValue: ?CPREList = blk: {
                const conf_item = config.CPRE;
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
            const TPIUValue: ?TPIUList = blk: {
                const item: TPIUList = .RCC_TPIU_DIV;
                break :blk item;
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
            const BMPREValue: ?BMPREList = blk: {
                const conf_item = config.BMPRE;
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
            const PPRE5Value: ?PPRE5List = blk: {
                const conf_item = config.PPRE5;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB5_DIV1 => {},
                        .RCC_APB5_DIV2 => {},
                        .RCC_APB5_DIV4 => {},
                        .RCC_APB5_DIV8 => {},
                        .RCC_APB5_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB5_DIV1;
            };
            const PPRE1Value: ?PPRE1List = blk: {
                const conf_item = config.PPRE1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB1_DIV1 => PPRE1_1 = true,
                        .RCC_APB1_DIV2 => PPRE1_2 = true,
                        .RCC_APB1_DIV4 => PPRE1_4 = true,
                        .RCC_APB1_DIV8 => {},
                        .RCC_APB1_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    PPRE1_1 = true;
                    break :blk .RCC_APB1_DIV1;
                };
            };
            const RCC_TIM_PRescaler_SelectionValue: ?RCC_TIM_PRescaler_SelectionList = blk: {
                const conf_item = config.extra.RCC_TIM_PRescaler_Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMPRES_ACTIVATED => TimPrescalerEnabled = true,
                        .RCC_TIMPRES_DISABLE => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMPRES_DISABLE;
            };
            const Tim1MulValue: ?f32 = blk: {
                if (((PPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DISABLE, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DISABLE, .@"="))) {
                    break :blk 2;
                } else if ((PPRE1_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((PPRE1_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((PPRE1_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const PPRE2Value: ?PPRE2List = blk: {
                const conf_item = config.PPRE2;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB2_DIV1 => PPRE2_1 = true,
                        .RCC_APB2_DIV2 => PPRE2_2 = true,
                        .RCC_APB2_DIV4 => PPRE2_4 = true,
                        .RCC_APB2_DIV8 => {},
                        .RCC_APB2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    PPRE2_1 = true;
                    break :blk .RCC_APB2_DIV1;
                };
            };
            const Tim2MulValue: ?f32 = blk: {
                if (((PPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DISABLE, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_DISABLE, .@"="))) {
                    break :blk 2;
                } else if ((PPRE2_1) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((PPRE2_2) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((PPRE2_4) and (check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_PRescaler_SelectionValue), RCC_TIM_PRescaler_SelectionValue, .RCC_TIMPRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const PPRE4Value: ?PPRE4List = blk: {
                const conf_item = config.PPRE4;
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
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLLSOURCE_HSI = true,
                        .RCC_PLLSOURCE_CSI => PLLSOURCE_CSI = true,
                        .RCC_PLLSOURCE_HSE => PLLSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSOURCE_HSI = true;
                    break :blk .RCC_PLLSOURCE_HSI;
                };
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
                    if (val < 8) {
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
                            8,
                            val,
                        });
                    }
                    if (val > 420) {
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
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 128;
            };
            const PLLFRACNValue: ?f32 = blk: {
                const config_val = config.PLLFRACN;
                PLLFRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVP1Value: ?DIVP1List = blk: {
                const conf_item = config.DIVP1;
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
            const DIVS1Value: ?f32 = blk: {
                const config_val = config.DIVS1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS1",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVT1Value: ?f32 = blk: {
                const config_val = config.DIVT1;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT1",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVN2Value: ?f32 = blk: {
                const config_val = config.DIVN2;
                if (config_val) |val| {
                    if (val < 8) {
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
                            8,
                            val,
                        });
                    }
                    if (val > 420) {
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
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 128;
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
            const DIVS2Value: ?f32 = blk: {
                const config_val = config.DIVS2;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS2",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVT2Value: ?f32 = blk: {
                const config_val = config.DIVT2;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT2",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVN3Value: ?f32 = blk: {
                const config_val = config.DIVN3;
                if (config_val) |val| {
                    if (val < 12) {
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
                            12,
                            val,
                        });
                    }
                    if (val > 420) {
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
                            420,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 128;
            };
            const PLL3FRACNValue: ?f32 = blk: {
                const config_val = config.PLL3FRACN;
                PLL3FRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const DIVS3Value: ?f32 = blk: {
                const config_val = config.DIVS3;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVS3",
                            "Else",
                            "No Extra Log",
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DIVT3Value: ?f32 = blk: {
                const config_val = config.DIVT3;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVT3",
                            "Else",
                            "No Extra Log",
                            8,
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
            const HSIDivToUCPDValue: ?HSIDivToUCPDList = blk: {
                const item: HSIDivToUCPDList = .RCC_UCPDCLKSOURCE_HSI4;
                break :blk item;
            };
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PLL1Q => SPI1CLKSOURCE_PLLQ1 = true,
                        .RCC_SPI1CLKSOURCE_PLL2P => SPI1CLKSOURCE_PLLP2 = true,
                        .RCC_SPI1CLKSOURCE_PLL3P => SPI1CLKSOURCE_PLLP3 = true,
                        .RCC_SPI1CLKSOURCE_PIN => SPI1CLKSOURCE_CKIN = true,
                        .RCC_SPI1CLKSOURCE_CLKP => SPI1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI1CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SPI1CLKSOURCE_PLL1Q;
                };
            };
            const SPI23CLockSelectionValue: ?SPI23CLockSelectionList = blk: {
                const conf_item = config.SPI23CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI23CLKSOURCE_PLL1Q => SPI23CLKSOURCE_PLLQ1 = true,
                        .RCC_SPI23CLKSOURCE_PLL2P => SPI23CLKSOURCE_PLLP2 = true,
                        .RCC_SPI23CLKSOURCE_PLL3P => SPI23CLKSOURCE_PLLP3 = true,
                        .RCC_SPI23CLKSOURCE_PIN => SPI23CLKSOURCE_CKIN = true,
                        .RCC_SPI23CLKSOURCE_CLKP => SPI23CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI23CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SPI23CLKSOURCE_PLL1Q;
                };
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL1Q => SAI1CLKSOURCE_PLLQ1 = true,
                        .RCC_SAI1CLKSOURCE_PLL2P => SAI1CLKSOURCE_PLLP2 = true,
                        .RCC_SAI1CLKSOURCE_PLL3P => SAI1CLKSOURCE_PLLP3 = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1CLKSOURCE_CKIN = true,
                        .RCC_SAI1CLKSOURCE_CLKP => SAI1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLL1Q;
                };
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLL1Q => SAI2CLKSOURCE_PLLQ1 = true,
                        .RCC_SAI2CLKSOURCE_PLL2P => SAI2CLKSOURCE_PLLP2 = true,
                        .RCC_SAI2CLKSOURCE_PLL3P => SAI2CLKSOURCE_PLLP3 = true,
                        .RCC_SAI2CLKSOURCE_PIN => SAI2CLKSOURCE_CKIN = true,
                        .RCC_SAI2CLKSOURCE_CLKP => SAI2CLKSOURCE_PER = true,
                        .RCC_SAI2CLKSOURCE_SPDIF => SAI2CLKSOURCE_SPDIF = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2CLKSOURCE_PLLQ1 = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLL1Q;
                };
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1_I3C1CLKSOURCE_PCLK1 => I2C1CLKSOURCE_PCLK1 = true,
                        .RCC_I2C1_I3C1CLKSOURCE_PLL3R => I2C1CLKSOURCE_PLLR3 = true,
                        .RCC_I2C1_I3C1CLKSOURCE_HSI => I2C1CLKSOURCE_HSI = true,
                        .RCC_I2C1_I3C1CLKSOURCE_CSI => I2C1CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C1CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_I2C1_I3C1CLKSOURCE_PCLK1;
                };
            };
            const I2C23CLockSelectionValue: ?I2C23CLockSelectionList = blk: {
                const conf_item = config.I2C23CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C23CLKSOURCE_PCLK1 => I2C23CLKSOURCE_PCLK1 = true,
                        .RCC_I2C23CLKSOURCE_PLL3R => I2C23CLKSOURCE_PLLR3 = true,
                        .RCC_I2C23CLKSOURCE_HSI => I2C23CLKSOURCE_HSI = true,
                        .RCC_I2C23CLKSOURCE_CSI => I2C23CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C23CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_I2C23CLKSOURCE_PCLK1;
                };
            };
            const SPDIFCLockSelectionValue: ?SPDIFCLockSelectionList = blk: {
                const conf_item = config.SPDIFCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPDIFRXCLKSOURCE_PLL1Q => SPDIFCLKSOURCE_PLL1Q = true,
                        .RCC_SPDIFRXCLKSOURCE_PLL2R => SPDIFCLKSOURCE_PLL2R = true,
                        .RCC_SPDIFRXCLKSOURCE_PLL3R => SPDIFCLKSOURCE_PLL3R = true,
                        .RCC_SPDIFRXCLKSOURCE_HSI => SPDIFCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SPDIFCLKSOURCE_PLL1Q = true;
                    break :blk .RCC_SPDIFRXCLKSOURCE_PLL1Q;
                };
            };
            const FmcClockSelectionValue: ?FmcClockSelectionList = blk: {
                const conf_item = config.FmcClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FMCCLKSOURCE_HCLK => FMCCLKSOURCE_HCLK5 = true,
                        .RCC_FMCCLKSOURCE_PLL1Q => FMCCLKSOURCE_PLL1Q = true,
                        .RCC_FMCCLKSOURCE_PLL2R => FMCCLKSOURCE_PLL2R = true,
                        .RCC_FMCCLKSOURCE_HSI => FMCCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    FMCCLKSOURCE_HCLK5 = true;
                    break :blk .RCC_FMCCLKSOURCE_HCLK;
                };
            };
            const SDMMC1CLockSelectionValue: ?SDMMC1CLockSelectionList = blk: {
                const conf_item = config.SDMMC1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC12CLKSOURCE_PLL2S => SDMMC1CLKSOURCE_PLL2S = true,
                        .RCC_SDMMC12CLKSOURCE_PLL2T => SDMMC1CLKSOURCE_PLL2T = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC1CLKSOURCE_PLL2S = true;
                    break :blk .RCC_SDMMC12CLKSOURCE_PLL2S;
                };
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => USART1CLKSOURCE_PCLK2 = true,
                        .RCC_USART1CLKSOURCE_PLL2Q => USART1CLKSOURCE_PLLQ2 = true,
                        .RCC_USART1CLKSOURCE_PLL3Q => USART1CLKSOURCE_PLLQ3 = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1CLKSOURCE_HSI = true,
                        .RCC_USART1CLKSOURCE_CSI => USART1CLKSOURCE_CSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART1CLKSOURCE_PCLK2 = true;
                    break :blk .RCC_USART1CLKSOURCE_PCLK2;
                };
            };
            const Adf1ClockSelectionValue: ?Adf1ClockSelectionList = blk: {
                const conf_item = config.Adf1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADF1CLKSOURCE_HCLK => ADFCLKSOURCE_HCLK1 = true,
                        .RCC_ADF1CLKSOURCE_PLL2P => ADFCLKSOURCE_PLL2P = true,
                        .RCC_ADF1CLKSOURCE_PLL3P => ADFCLKSOURCE_PLL3P = true,
                        .RCC_ADF1CLKSOURCE_PIN => ADFCLKSOURCE_CKIN = true,
                        .RCC_ADF1CLKSOURCE_CSI => ADFCLKSOURCE_CSI = true,
                        .RCC_ADF1CLKSOURCE_HSI => ADFCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    ADFCLKSOURCE_HCLK1 = true;
                    break :blk .RCC_ADF1CLKSOURCE_HCLK;
                };
            };
            const USART234578CLockSelectionValue: ?USART234578CLockSelectionList = blk: {
                const conf_item = config.USART234578CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART234578CLKSOURCE_PCLK1 => USART2CLKSOURCE_PCLK1 = true,
                        .RCC_USART234578CLKSOURCE_PLL2Q => USART2CLKSOURCE_PLLQ2 = true,
                        .RCC_USART234578CLKSOURCE_PLL3Q => USART2CLKSOURCE_PLLQ3 = true,
                        .RCC_USART234578CLKSOURCE_HSI => USART2CLKSOURCE_HSI = true,
                        .RCC_USART234578CLKSOURCE_CSI => USART2CLKSOURCE_CSI = true,
                        .RCC_USART234578CLKSOURCE_LSE => USART2CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART2CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_USART234578CLKSOURCE_PCLK1;
                };
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK4 => LPUART1CLKSOURCE_PCLK4 = true,
                        .RCC_LPUART1CLKSOURCE_PLL2Q => LPUART1CLKSOURCE_PLL2Q = true,
                        .RCC_LPUART1CLKSOURCE_PLL3Q => LPUART1CLKSOURCE_PLL3Q = true,
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1CLKSOURCE_HSI = true,
                        .RCC_LPUART1CLKSOURCE_CSI => LPUART1CLKSOURCE_CSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1CLKSOURCE_LSE = true,
                    }
                }

                break :blk conf_item orelse {
                    LPUART1CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_LPUART1CLKSOURCE_PCLK4;
                };
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK1 => LPTIM1CLKSOURCE_PCLK1 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL2P => LPTIM1CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL3R => LPTIM1CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1CLKSOURCE_LSE = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1CLKSOURCE_LSI = true,
                        .RCC_LPTIM1CLKSOURCE_CLKP => LPTIM1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM1CLKSOURCE_PCLK1 = true;
                    break :blk .RCC_LPTIM1CLKSOURCE_PCLK1;
                };
            };
            const LPTIM23CLockSelectionValue: ?LPTIM23CLockSelectionList = blk: {
                const conf_item = config.LPTIM23CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM23CLKSOURCE_PCLK4 => LPTIM23CLKSOURCE_PCLK4 = true,
                        .RCC_LPTIM23CLKSOURCE_PLL2P => LPTIM23CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM23CLKSOURCE_PLL3R => LPTIM23CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM23CLKSOURCE_LSE => LPTIM23CLKSOURCE_LSE = true,
                        .RCC_LPTIM23CLKSOURCE_LSI => LPTIM23CLKSOURCE_LSI = true,
                        .RCC_LPTIM23CLKSOURCE_CLKP => LPTIM23CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM23CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_LPTIM23CLKSOURCE_PCLK4;
                };
            };
            const LPTIM45CLockSelectionValue: ?LPTIM45CLockSelectionList = blk: {
                const conf_item = config.LPTIM45CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM45CLKSOURCE_PCLK4 => LPTIM45CLKSOURCE_PCLK4 = true,
                        .RCC_LPTIM45CLKSOURCE_PLL2P => LPTIM45CLKSOURCE_PLLP2 = true,
                        .RCC_LPTIM45CLKSOURCE_PLL3R => LPTIM45CLKSOURCE_PLLR3 = true,
                        .RCC_LPTIM45CLKSOURCE_LSE => LPTIM45CLKSOURCE_LSE = true,
                        .RCC_LPTIM45CLKSOURCE_LSI => LPTIM45CLKSOURCE_LSI = true,
                        .RCC_LPTIM45CLKSOURCE_CLKP => LPTIM45CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM45CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_LPTIM45CLKSOURCE_PCLK4;
                };
            };
            const SPI6CLockSelectionValue: ?SPI6CLockSelectionList = blk: {
                const conf_item = config.SPI6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI6CLKSOURCE_PCLK4 => SPI6CLKSOURCE_PCLK4 = true,
                        .RCC_SPI6CLKSOURCE_PLL2Q => SPI6CLKSOURCE_PLLQ2 = true,
                        .RCC_SPI6CLKSOURCE_PLL3Q => SPI6CLKSOURCE_PLLQ3 = true,
                        .RCC_SPI6CLKSOURCE_HSI => SPI6CLKSOURCE_HSI = true,
                        .RCC_SPI6CLKSOURCE_CSI => SPI6CLKSOURCE_CSI = true,
                        .RCC_SPI6CLKSOURCE_HSE => SPI6CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI6CLKSOURCE_PCLK4 = true;
                    break :blk .RCC_SPI6CLKSOURCE_PCLK4;
                };
            };
            const Spi45ClockSelectionValue: ?Spi45ClockSelectionList = blk: {
                const conf_item = config.Spi45ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI45CLKSOURCE_PCLK2 => SPI45CLKSOURCE_PCLK2 = true,
                        .RCC_SPI45CLKSOURCE_PLL2Q => SPI45CLKSOURCE_PLLQ2 = true,
                        .RCC_SPI45CLKSOURCE_PLL3Q => SPI45CLKSOURCE_PLLQ3 = true,
                        .RCC_SPI45CLKSOURCE_HSI => SPI45CLKSOURCE_HSI = true,
                        .RCC_SPI45CLKSOURCE_CSI => SPI45CLKSOURCE_CSI = true,
                        .RCC_SPI45CLKSOURCE_HSE => SPI45CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI45CLKSOURCE_PCLK2 = true;
                    break :blk .RCC_SPI45CLKSOURCE_PCLK2;
                };
            };
            const RCC_USBPHY_Clock_Source_FROM_HSEValue: ?RCC_USBPHY_Clock_Source_FROM_HSEList = blk: {
                const item: RCC_USBPHY_Clock_Source_FROM_HSEList = .RCC_USBPHYCCLKSOURCE_HSE_DIV2;
                break :blk item;
            };
            const USBPHYCLKSourceValue: ?USBPHYCLKSourceList = blk: {
                const conf_item = config.USBPHYCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBPHYCCLKSOURCE_HSE => USBPHYCLKSOURCE_HSE = true,
                        .RCC_USBPHYCCLKSOURCE_HSE_DIV2 => USBPHYCLKSOURCE_HSE2 = true,
                        .RCC_USBPHYCCLKSOURCE_PLL3Q => USBPHYCLKSOURCE_PLL3Q = true,
                    }
                }

                break :blk conf_item orelse {
                    USBPHYCLKSOURCE_HSE = true;
                    break :blk .RCC_USBPHYCCLKSOURCE_HSE;
                };
            };
            const USB_PHY_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const USB_PHY_VALUE60Value: ?f32 = blk: {
                break :blk 6e7;
            };
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBOTGFSCLKSOURCE_HSI48 => USBOCLKSOURCE_RC48 = true,
                        .RCC_USBOTGFSCLKSOURCE_PLL3Q => USBOCLKSOURCE_PLL3Q = true,
                        .RCC_USBOTGFSCLKSOURCE_HSE => USBOCLKSOURCE_HSE = true,
                        .RCC_USBOTGFSCLKSOURCE_CLK48 => USBOCLKSOURCE_PHY = true,
                    }
                }

                break :blk conf_item orelse {
                    USBOCLKSOURCE_RC48 = true;
                    break :blk .RCC_USBOTGFSCLKSOURCE_HSI48;
                };
            };
            const FDCANCLockSelectionValue: ?FDCANCLockSelectionList = blk: {
                const conf_item = config.FDCANCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_HSE => FDCANCLKSOURCE_HSE = true,
                        .RCC_FDCANCLKSOURCE_PLL1Q => FDCANCLKSOURCE_PLL1Q = true,
                        .RCC_FDCANCLKSOURCE_PLL2P => FDCANCLKSOURCE_PLL2P = true,
                    }
                }

                break :blk conf_item orelse {
                    FDCANCLKSOURCE_HSE = true;
                    break :blk .RCC_FDCANCLKSOURCE_HSE;
                };
            };
            const Xspi1ClockSelectionValue: ?Xspi1ClockSelectionList = blk: {
                const conf_item = config.Xspi1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_XSPI1CLKSOURCE_HCLK => OSPI1CLKSOURCE_HCLK5 = true,
                        .RCC_XSPI1CLKSOURCE_PLL2S => OSPI1CLKSOURCE_PLL2S = true,
                        .RCC_XSPI1CLKSOURCE_PLL2T => OSPI1CLKSOURCE_PLL2T = true,
                    }
                }

                break :blk conf_item orelse {
                    OSPI1CLKSOURCE_HCLK5 = true;
                    break :blk .RCC_XSPI1CLKSOURCE_HCLK;
                };
            };
            const PSSICLockSelectionValue: ?PSSICLockSelectionList = blk: {
                const conf_item = config.PSSICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PSSICLKSOURCE_PLL3R => PSSICLKSOURCE_PLL3R = true,
                        .RCC_PSSICLKSOURCE_CLKP => PSSICLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    PSSICLKSOURCE_PLL3R = true;
                    break :blk .RCC_PSSICLKSOURCE_PLL3R;
                };
            };
            const Xspi2ClockSelectionValue: ?Xspi2ClockSelectionList = blk: {
                const conf_item = config.Xspi2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_XSPI2CLKSOURCE_HCLK => OSPI2CLKSOURCE_HCLK5 = true,
                        .RCC_XSPI2CLKSOURCE_PLL2S => OSPI2CLKSOURCE_PLL2S = true,
                        .RCC_XSPI2CLKSOURCE_PLL2T => OSPI2CLKSOURCE_PLL2T = true,
                    }
                }

                break :blk conf_item orelse {
                    OSPI2CLKSOURCE_HCLK5 = true;
                    break :blk .RCC_XSPI2CLKSOURCE_HCLK;
                };
            };
            const ETHPHYCLockSelectionValue: ?ETHPHYCLockSelectionList = blk: {
                const conf_item = config.ETHPHYCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETH1PHYCLKSOURCE_HSE => ETHPHYCLKSOURCE_HSE = true,
                        .RCC_ETH1PHYCLKSOURCE_PLL3S => ETHPHYCLKSOURCE_PLL3S = true,
                    }
                }

                break :blk conf_item orelse {
                    ETHPHYCLKSOURCE_HSE = true;
                    break :blk .RCC_ETH1PHYCLKSOURCE_HSE;
                };
            };
            const ETH1CLockSelectionValue: ?ETH1CLockSelectionList = blk: {
                const conf_item = config.ETH1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETH1REFCLKSOURCE_ETH => ETH1CLKSOURCE_EXT = true,
                        .RCC_ETH1REFCLKSOURCE_HSE => ETH1CLKSOURCE_HSE = true,
                        .RCC_ETH1REFCLKSOURCE_PHY => ETH1CLKSOURCE_ETHPHY = true,
                    }
                }

                break :blk conf_item orelse {
                    ETH1CLKSOURCE_ETHPHY = true;
                    break :blk .RCC_ETH1REFCLKSOURCE_PHY;
                };
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_PLL2P => ADCCLKSOURCE_PLL2P = true,
                        .RCC_ADCCLKSOURCE_PLL3R => ADCCLKSOURCE_PLL3R = true,
                        .RCC_ADCCLKSOURCE_CLKP => ADCCLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    ADCCLKSOURCE_PLL2P = true;
                    break :blk .RCC_ADCCLKSOURCE_PLL2P;
                };
            };
            const CECCLockSelectionValue: ?CECCLockSelectionList = blk: {
                const conf_item = config.CECCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_LSE => CECCLKSOURCE_LSE = true,
                        .RCC_CECCLKSOURCE_LSI => CECCLKSOURCE_LSI = true,
                        .RCC_CECCLKSOURCE_CSI => CECCLKSOURCE_CSI122 = true,
                    }
                }

                break :blk conf_item orelse {
                    CECCLKSOURCE_LSE = true;
                    break :blk .RCC_CECCLKSOURCE_LSE;
                };
            };
            const CSI_DIVValue: ?CSI_DIVList = blk: {
                const item: CSI_DIVList = .RCC_CECCLKSOURCE_CSI;
                break :blk item;
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
                if (config.flags.CRSActivatedSourceLSE or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC)) or (config.flags.MCO1Config and MCO1SOURCE_LSE) or (LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1Used_ForRCC) or (CECCLKSOURCE_LSE and config.flags.CECUsed_ForRCC) or (LPTIM45CLKSOURCE_LSE and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (LPUART1CLKSOURCE_LSE and config.flags.LPUARTUsed_ForRCC) or (USART1CLKSOURCE_LSE and config.flags.USART1Used_ForRCC) or (USART2CLKSOURCE_LSE and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPTIM23CLKSOURCE_LSE and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC))) {
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
                } else if (config.flags.CRSActivatedSourceGPIO) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_PIN;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceLSE) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_LSE;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB and (config.flags.USB_OTG_FS_Used)) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB_OTG_FS;
                    break :blk item;
                } else if (config.flags.CRSActivatedSourceUSB and (config.flags.USB_OTG_HS_Used)) {
                    const item: SourceList = .RCC_CRS_SYNC_SOURCE_USB_OTG_HS;
                    break :blk item;
                }
                break :blk null;
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
            const DigExtClockEnableValue: ?DigExtClockEnableList = blk: {
                if (config.flags.DigitalClockConfig) {
                    const item: DigExtClockEnableList = .true;
                    break :blk item;
                }
                const item: DigExtClockEnableList = .false;
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
                if (((config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC)) or (config.flags.LPTIM1Used_ForRCC) or ((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) or (config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or (config.flags.SPI1Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S1Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC)) {
                    const item: cKPerEnableList = .true;
                    break :blk item;
                }
                const item: cKPerEnableList = .false;
                break :blk item;
            };
            const SAI1EnableValue: ?SAI1EnableList = blk: {
                if (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                }
                const item: SAI1EnableList = .false;
                break :blk item;
            };
            const SAI2EnableValue: ?SAI2EnableList = blk: {
                if (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) {
                    const item: SAI2EnableList = .true;
                    break :blk item;
                }
                const item: SAI2EnableList = .false;
                break :blk item;
            };
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.I2S1Used_ForRCC or config.flags.SPI1Used_ForRCC) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPDIFEnableValue: ?SPDIFEnableList = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) {
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
            const SPI23EnableValue: ?SPI23EnableList = blk: {
                if (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC) {
                    const item: SPI23EnableList = .true;
                    break :blk item;
                }
                const item: SPI23EnableList = .false;
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
            const LPTIM45EnableValue: ?LPTIM45EnableList = blk: {
                if ((config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) {
                    const item: LPTIM45EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM45EnableList = .false;
                break :blk item;
            };
            const LPTIM23EnableValue: ?LPTIM23EnableList = blk: {
                if (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC) {
                    const item: LPTIM23EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM23EnableList = .false;
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
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1Used_ForRCC) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
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
            const SDMMC1EnableValue: ?SDMMC1EnableList = blk: {
                if (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) {
                    const item: SDMMC1EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC1EnableList = .false;
                break :blk item;
            };
            const OCSPI1EnableValue: ?OCSPI1EnableList = blk: {
                if (config.flags.XSPI1_Used) {
                    const item: OCSPI1EnableList = .true;
                    break :blk item;
                }
                const item: OCSPI1EnableList = .false;
                break :blk item;
            };
            const OCSPI2EnableValue: ?OCSPI2EnableList = blk: {
                if (config.flags.XSPI2_Used) {
                    const item: OCSPI2EnableList = .true;
                    break :blk item;
                }
                const item: OCSPI2EnableList = .false;
                break :blk item;
            };
            const EnableUSBOFSValue: ?EnableUSBOFSList = blk: {
                if ((config.flags.USB_OTG_FS_Used)) {
                    const item: EnableUSBOFSList = .true;
                    break :blk item;
                }
                const item: EnableUSBOFSList = .false;
                break :blk item;
            };
            const EnableUSBOHSValue: ?EnableUSBOHSList = blk: {
                if ((config.flags.USB_OTG_HS_Used)) {
                    const item: EnableUSBOHSList = .true;
                    break :blk item;
                }
                const item: EnableUSBOHSList = .false;
                break :blk item;
            };
            const I2C23EnableValue: ?I2C23EnableList = blk: {
                if ((config.flags.I2C2_Used or config.flags.I2C3_Used)) {
                    const item: I2C23EnableList = .true;
                    break :blk item;
                }
                const item: I2C23EnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1_Used or config.flags.I3C1_Used) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
                break :blk item;
            };
            const PSSIEnableValue: ?PSSIEnableList = blk: {
                if (config.flags.PSSI_Used) {
                    const item: PSSIEnableList = .true;
                    break :blk item;
                }
                const item: PSSIEnableList = .false;
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
            const ETH1EnableDivValue: ?ETH1EnableDivList = blk: {
                if (config.flags.ETH_Used) {
                    const item: ETH1EnableDivList = .true;
                    break :blk item;
                }
                const item: ETH1EnableDivList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
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
            const UCPDEnableValue: ?UCPDEnableList = blk: {
                if (config.flags.UCPD1_Used) {
                    const item: UCPDEnableList = .true;
                    break :blk item;
                }
                const item: UCPDEnableList = .false;
                break :blk item;
            };
            const EnableHSEUSBPHYDevisorValue: ?EnableHSEUSBPHYDevisorList = blk: {
                if ((config.flags.USB_OTG_FS_Used or config.flags.USB_OTG_HS_Used) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEUSBPHYDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSEUSBPHYDevisorList = .false;
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
            const DTSEnableValue: ?DTSEnableList = blk: {
                if (config.flags.DTS_Used and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: DTSEnableList = .true;
                    break :blk item;
                }
                const item: DTSEnableList = .false;
                break :blk item;
            };
            const ETHClockEnableValue: ?ETHClockEnableList = blk: {
                if (config.flags.ETHClockConfig and config.flags.ETH_Used) {
                    const item: ETHClockEnableList = .true;
                    break :blk item;
                }
                const item: ETHClockEnableList = .false;
                break :blk item;
            };
            const ETH1EnableValue: ?ETH1EnableList = blk: {
                if (config.flags.ETH_Used) {
                    const item: ETH1EnableList = .true;
                    break :blk item;
                }
                const item: ETH1EnableList = .false;
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
            const PLL1QUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1Q, .@"=")) and (config.flags.MCO1Config)) or (SPI1CLKSOURCE_PLLQ1 and (config.flags.I2S1Used_ForRCC or config.flags.SPI1Used_ForRCC)) or (SPI23CLKSOURCE_PLLQ1 and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLQ1 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC)) or (SAI2CLKSOURCE_PLLQ1 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) or (SPDIFCLKSOURCE_PLL1Q and (config.flags.SPDIFRXUsed_ForRCC or ((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF))) or (FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (FDCANCLKSOURCE_PLL1Q and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if (((MCO2SOURCE_PLL2PCLK) and (config.flags.MCO2Config)) or (SPI1CLKSOURCE_PLLP2 and (config.flags.I2S1Used_ForRCC or config.flags.SPI1Used_ForRCC)) or (SPI23CLKSOURCE_PLLP2 and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP2 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC)) or (SAI2CLKSOURCE_PLLP2 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) or (LPTIM1CLKSOURCE_PLLP2 and config.flags.LPTIM1Used_ForRCC) or (LPTIM23CLKSOURCE_PLLP2 and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC)) or (LPTIM45CLKSOURCE_PLLP2 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (ADCCLKSOURCE_PLL2P and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (FDCANCLKSOURCE_PLL2P and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) or (ADFCLKSOURCE_PLL2P and config.flags.ADF1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2QUsedValue: ?f32 = blk: {
                if ((USART1CLKSOURCE_PLLQ2 and config.flags.USART1Used_ForRCC) or (USART2CLKSOURCE_PLLQ2 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL2Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ2 and config.flags.SPI6Used_ForRCC) or (SPI45CLKSOURCE_PLLQ2 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2RUsedValue: ?f32 = blk: {
                if ((SPDIFCLKSOURCE_PLL2R and (config.flags.SPDIFRXUsed_ForRCC or ((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF))) or (FMCCLKSOURCE_PLL2R and config.flags.FMCUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2SUsedValue: ?f32 = blk: {
                if ((OSPI1CLKSOURCE_PLL2S and config.flags.XSPI1_Used) or (OSPI2CLKSOURCE_PLL2S and config.flags.XSPI2_Used) or (SDMMC1CLKSOURCE_PLL2S and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2TUsedValue: ?f32 = blk: {
                if ((OSPI1CLKSOURCE_PLL2T and config.flags.XSPI1_Used) or (OSPI2CLKSOURCE_PLL2T and config.flags.XSPI2_Used) or (SDMMC1CLKSOURCE_PLL2T and (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if ((SPI1CLKSOURCE_PLLP3 and (config.flags.I2S1Used_ForRCC or config.flags.SPI1Used_ForRCC)) or (SPI23CLKSOURCE_PLLP3 and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (SAI1CLKSOURCE_PLLP3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC)) or (SAI2CLKSOURCE_PLLP3 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) or (ADFCLKSOURCE_PLL2P and config.flags.ADF1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if ((FMCCLKSOURCE_PLL1Q and config.flags.FMCUsed_ForRCC) or (USART1CLKSOURCE_PLLQ3 and config.flags.USART1Used_ForRCC) or (USART2CLKSOURCE_PLLQ3 and (config.flags.USART3Used_ForRCC or config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC or config.flags.UART5Used_ForRCC)) or (LPUART1CLKSOURCE_PLL3Q and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_PLLQ3 and config.flags.SPI6Used_ForRCC) or (SPI45CLKSOURCE_PLLQ3 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (USBPHYCLKSOURCE_PLL3Q and config.flags.USB_OTG_HS_Used) or (config.flags.USB_OTG_FS_Used and (USBOCLKSOURCE_PLL3Q or (USBOCLKSOURCE_PHY and USBPHYCLKSOURCE_PLL3Q)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if ((config.flags.PSSI_Used and PSSICLKSOURCE_PLL3R) or config.flags.LTDCUsed_ForRCC or (I2C1CLKSOURCE_PLLR3 and (config.flags.I2C1_Used or config.flags.I3C1_Used)) or (I2C23CLKSOURCE_PLLR3 and (config.flags.I2C2_Used or config.flags.I2C3_Used)) or (SPDIFCLKSOURCE_PLL3R and (config.flags.SPDIFRXUsed_ForRCC or ((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF))) or (LPTIM1CLKSOURCE_PLLR3 and config.flags.LPTIM1Used_ForRCC) or (LPTIM23CLKSOURCE_PLLR3 and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC)) or (LPTIM45CLKSOURCE_PLLR3 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (ADCCLKSOURCE_PLL3R and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3SUsedValue: ?f32 = blk: {
                if (ETHPHYCLKSOURCE_PLL3S and config.flags.ETH_Used and ETH1CLKSOURCE_ETHPHY and config.flags.ETHClockConfig) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if ((SYSCLKSOURCE_PLLCLK) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLL1P, .@"=")) and config.flags.MCO2Config)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1UsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL2SUsedValue), PLL2SUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL2TUsedValue), PLL2TUsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) or (check_ref(@TypeOf(PLL3SUsedValue), PLL3SUsedValue, 1, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const cKPerUsedValue: ?f32 = blk: {
                if (((SAI1CLKSOURCE_PER and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC)) or (LPTIM1CLKSOURCE_PER and config.flags.LPTIM1Used_ForRCC) or (SAI2CLKSOURCE_PER and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC)) or (ADCCLKSOURCE_PER and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC))) or (LPTIM45CLKSOURCE_PER and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or (SPI1CLKSOURCE_PER and (config.flags.I2S1Used_ForRCC or config.flags.SPI1Used_ForRCC)) or (SPI23CLKSOURCE_PER and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC)) or (LPTIM23CLKSOURCE_PER and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((FMCCLKSOURCE_HSI and config.flags.FMCUsed_ForRCC) or (config.flags.MCO1Config and MCO1SOURCE_HSI) or (PLLSOURCE_HSI and ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) or (config.flags.MCO2Config and MCO2SOURCE_PLL2PCLK))) or (PERSOURCE_HSI and (check_ref(@TypeOf(cKPerUsedValue), cKPerUsedValue, 1, .@"="))) or (SYSCLKSOURCE_HSI) or (I2C23CLKSOURCE_HSI and (config.flags.I2C2_Used or config.flags.I2C3_Used)) or (I2C1CLKSOURCE_HSI and (config.flags.I2C1_Used or config.flags.I3C1_Used)) or (SPDIFCLKSOURCE_HSI and (config.flags.SPDIFRXUsed_ForRCC or ((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF))) or (USART1CLKSOURCE_HSI and config.flags.USART1Used_ForRCC) or (USART2CLKSOURCE_HSI and (config.flags.USART2Used_ForRCC or config.flags.USART3Used_ForRCC or config.flags.UART4Used_ForRCC or config.flags.UART5Used_ForRCC or config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC)) or (LPUART1CLKSOURCE_HSI and config.flags.LPUARTUsed_ForRCC) or (SPI6CLKSOURCE_HSI and (config.flags.SPI6Used_ForRCC or config.flags.I2S6Used_ForRCC)) or (SPI45CLKSOURCE_HSI and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC)) or (ADFCLKSOURCE_HSI and config.flags.ADF1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.LSEOscillator or config.flags.LSEByPass or config.flags.LSEDIGByPass)) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
                break :blk item;
            };
            const EnableLSEValue: ?EnableLSEList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass or config.flags.LSEDIGByPass)) {
                    const item: EnableLSEList = .true;
                    break :blk item;
                }
                const item: EnableLSEList = .false;
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
                                "HSEByPass|HSEDIGByPass",
                                "HSEByPass",
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
                                "HSEByPass|HSEDIGByPass",
                                "HSEByPass",
                                5e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 24000000;

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
                HSEOSC.value = config_val orelse 24000000;

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

            const RC48_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(DigExtClockEnableValue), DigExtClockEnableValue, .true, .@"=")) {
                const Dig_CKIN_clk_value = DIGITAL_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "Dig_CKIN",
                    "Else",
                    "No Extra Log",
                    "DIGITAL_CLOCK_VALUE",
                });
                Dig_CKIN.nodetype = .source;
                Dig_CKIN.value = Dig_CKIN_clk_value;
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
                    &HSIDiv,
                    &HSEOSC,
                    &LSEOSC,
                    &RC48,
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

            const CPRE_clk_value = CPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CPRE",
                "Else",
                "No Extra Log",
                "CPRE",
            });
            CPRE.nodetype = .div;
            CPRE.value = CPRE_clk_value.get();
            CPRE.parents = &.{&SysCLKOutput};
            CPREOutput.nodetype = .output;
            CPREOutput.parents = &.{&CPRE};

            const TPIUPrescaler_clk_value = TPIUValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TPIUPrescaler",
                "Else",
                "No Extra Log",
                "TPIU",
            });
            TPIUPrescaler.nodetype = .div;
            TPIUPrescaler.value = TPIUPrescaler_clk_value.get();
            TPIUPrescaler.parents = &.{&CPREOutput};
            TPIUOutput.nodetype = .output;
            TPIUOutput.parents = &.{&TPIUPrescaler};
            CpuClockOutput.nodetype = .output;
            CpuClockOutput.parents = &.{&CPREOutput};

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
            CortexPrescaler.parents = &.{&CPREOutput};
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            const BMPRE_clk_value = BMPREValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "BMPRE",
                "Else",
                "No Extra Log",
                "BMPRE",
            });
            BMPRE.nodetype = .div;
            BMPRE.value = BMPRE_clk_value.get();
            BMPRE.parents = &.{&CPREOutput};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&BMPRE};
            AXIClockOutput.nodetype = .output;
            AXIClockOutput.parents = &.{&AHBOutput};
            AHB5Output.nodetype = .output;
            AHB5Output.parents = &.{&AHBOutput};

            const PPRE5_clk_value = PPRE5Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PPRE5",
                "Else",
                "No Extra Log",
                "PPRE5",
            });
            PPRE5.nodetype = .div;
            PPRE5.value = PPRE5_clk_value.get();
            PPRE5.parents = &.{&AHBOutput};
            APB5Output.nodetype = .output;
            APB5Output.parents = &.{&PPRE5};
            AHB1234Output.nodetype = .output;
            AHB1234Output.parents = &.{&AHBOutput};

            const PPRE1_clk_value = PPRE1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PPRE1",
                "Else",
                "No Extra Log",
                "PPRE1",
            });
            PPRE1.nodetype = .div;
            PPRE1.value = PPRE1_clk_value.get();
            PPRE1.parents = &.{&AHBOutput};
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&PPRE1};

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
            Tim1Mul.parents = &.{&PPRE1};
            Tim1Output.nodetype = .output;
            Tim1Output.parents = &.{&Tim1Mul};

            const PPRE2_clk_value = PPRE2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PPRE2",
                "Else",
                "No Extra Log",
                "PPRE2",
            });
            PPRE2.nodetype = .div;
            PPRE2.value = PPRE2_clk_value.get();
            PPRE2.parents = &.{&AHBOutput};
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&PPRE2};

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
            Tim2Mul.parents = &.{&PPRE2};
            Tim2Output.nodetype = .output;
            Tim2Output.parents = &.{&Tim2Mul};

            const PPRE4_clk_value = PPRE4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PPRE4",
                "Else",
                "No Extra Log",
                "PPRE4",
            });
            PPRE4.nodetype = .div;
            PPRE4.value = PPRE4_clk_value.get();
            PPRE4.parents = &.{&AHBOutput};
            APB4Output.nodetype = .output;
            APB4Output.parents = &.{&PPRE4};

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
            DIVP1.value = DIVP1_clk_value.get();
            DIVP1.parents = &.{&DIVN1};
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"="))
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
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"="))
            {
                DIVQ1output.nodetype = .output;
                DIVQ1output.parents = &.{&DIVQ1};
            }

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
            DIVR1output.nodetype = .output;
            DIVR1output.parents = &.{&DIVR1};

            const DIVS1_clk_value = DIVS1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVS1",
                "Else",
                "No Extra Log",
                "DIVS1",
            });
            DIVS1.nodetype = .div;
            DIVS1.value = DIVS1_clk_value;
            DIVS1.parents = &.{&DIVN1};
            DIVS1output.nodetype = .output;
            DIVS1output.parents = &.{&DIVS1};

            const DIVT1_clk_value = DIVT1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVT1",
                "Else",
                "No Extra Log",
                "DIVT1",
            });
            DIVT1.nodetype = .div;
            DIVT1.value = DIVT1_clk_value;
            DIVT1.parents = &.{&DIVN1};
            DIVT1output.nodetype = .output;
            DIVT1output.parents = &.{&DIVT1};

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
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"="))
            {
                DIVP2output.nodetype = .output;
                DIVP2output.parents = &.{&DIVP2};
            }
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"="))
            {
                DIVQ2output.nodetype = .output;
                DIVQ2output.parents = &.{&DIVQ2};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
                DIVR2output.nodetype = .output;
                DIVR2output.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"="))
            {
                const DIVS2_clk_value = DIVS2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVS2",
                    "Else",
                    "No Extra Log",
                    "DIVS2",
                });
                DIVS2.nodetype = .div;
                DIVS2.value = DIVS2_clk_value;
                DIVS2.parents = &.{&DIVN2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"="))
            {
                DIVS2output.nodetype = .output;
                DIVS2output.parents = &.{&DIVS2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"="))
            {
                const DIVT2_clk_value = DIVT2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVT2",
                    "Else",
                    "No Extra Log",
                    "DIVT2",
                });
                DIVT2.nodetype = .div;
                DIVT2.value = DIVT2_clk_value;
                DIVT2.parents = &.{&DIVN2};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"="))
            {
                DIVT2output.nodetype = .output;
                DIVT2output.parents = &.{&DIVT2};
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
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"="))
            {
                DIVP3output.nodetype = .output;
                DIVP3output.parents = &.{&DIVP3};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"="))
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
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART234578EnableValue), USART234578EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"="))
            {
                DIVQ3output.nodetype = .output;
                DIVQ3output.parents = &.{&DIVQ3};
            }
            if (check_ref(@TypeOf(I2C23EnableValue), I2C23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(I2C23EnableValue), I2C23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"="))
            {
                DIVR3output.nodetype = .output;
                DIVR3output.parents = &.{&DIVR3};
            }
            if (check_ref(@TypeOf(ETH1EnableDivValue), ETH1EnableDivValue, .true, .@"=")) {
                const DIVS3_clk_value = DIVS3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVS3",
                    "Else",
                    "No Extra Log",
                    "DIVS3",
                });
                DIVS3.nodetype = .div;
                DIVS3.value = DIVS3_clk_value;
                DIVS3.parents = &.{&DIVN3};
            }
            if (check_ref(@TypeOf(ETH1EnableDivValue), ETH1EnableDivValue, .true, .@"=")) {
                DIVS3output.nodetype = .output;
                DIVS3output.parents = &.{&DIVS3};
            }
            if (false) {
                const DIVT3_clk_value = DIVT3Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVT3",
                    "Else",
                    "No Extra Log",
                    "DIVT3",
                });
                DIVT3.nodetype = .div;
                DIVT3.value = DIVT3_clk_value;
                DIVT3.parents = &.{&DIVN3};
            }
            if (false) {
                DIVT3output.nodetype = .output;
                DIVT3output.parents = &.{&DIVT3};
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
            if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                UCPDoutput.nodetype = .output;
                UCPDoutput.parents = &.{&HSI_DIV};
            }
            if (check_ref(@TypeOf(UCPDEnableValue), UCPDEnableValue, .true, .@"=")) {
                const HSI_DIV_clk_value = HSIDivToUCPDValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSI_DIV",
                    "Else",
                    "No Extra Log",
                    "HSIDivToUCPD",
                });
                HSI_DIV.nodetype = .div;
                HSI_DIV.value = HSI_DIV_clk_value.get();
                HSI_DIV.parents = &.{&HSIRC};
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
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                };
                SPI1Mult.nodetype = .multi;
                SPI1Mult.parents = &.{SPI1Multparents[SPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                SPI1output.nodetype = .output;
                SPI1output.parents = &.{&SPI1Mult};
            }
            if (check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=")) {
                const SPI23Mult_clk_value = SPI23CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI23Mult",
                    "Else",
                    "No Extra Log",
                    "SPI23CLockSelection",
                });
                const SPI23Multparents = [_]*const ClockNode{
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                };
                SPI23Mult.nodetype = .multi;
                SPI23Mult.parents = &.{SPI23Multparents[SPI23Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=")) {
                SPI23output.nodetype = .output;
                SPI23output.parents = &.{&SPI23Mult};
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
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
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
                    &DIVQ1,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CKPERSource,
                    &SPDIFMult,
                };
                SAI2Mult.nodetype = .multi;
                SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
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
                    &PPRE1,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(I2C23EnableValue), I2C23EnableValue, .true, .@"=")) {
                const I2C23Mult_clk_value = I2C23CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C23Mult",
                    "Else",
                    "No Extra Log",
                    "I2C23CLockSelection",
                });
                const I2C23Multparents = [_]*const ClockNode{
                    &PPRE1,
                    &DIVR3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C23Mult.nodetype = .multi;
                I2C23Mult.parents = &.{I2C23Multparents[I2C23Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C23EnableValue), I2C23EnableValue, .true, .@"=")) {
                I2C23output.nodetype = .output;
                I2C23output.parents = &.{&I2C23Mult};
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
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                LTDCOutput.nodetype = .output;
                LTDCOutput.parents = &.{&DIVR3};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                const FMCMult_clk_value = FmcClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FMCMult",
                    "Else",
                    "No Extra Log",
                    "FmcClockSelection",
                });
                const FMCMultparents = [_]*const ClockNode{
                    &AHB5Output,
                    &DIVQ1,
                    &DIVR2,
                    &HSIRC,
                };
                FMCMult.nodetype = .multi;
                FMCMult.parents = &.{FMCMultparents[FMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
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
                    &DIVS2,
                    &DIVT2,
                };
                SDMMCMult.nodetype = .multi;
                SDMMCMult.parents = &.{SDMMCMultparents[SDMMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                SDMMCoutput.nodetype = .output;
                SDMMCoutput.parents = &.{&SDMMCMult};
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
                    &PPRE2,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &LSEOSC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=")) {
                const ADFMult_clk_value = Adf1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADFMult",
                    "Else",
                    "No Extra Log",
                    "Adf1ClockSelection",
                });
                const ADFMultparents = [_]*const ClockNode{
                    &AHBOutput,
                    &DIVP2,
                    &DIVP3,
                    &I2S_CKIN,
                    &CSIRC,
                    &HSIDiv,
                };
                ADFMult.nodetype = .multi;
                ADFMult.parents = &.{ADFMultparents[ADFMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADF1EnableValue), ADF1EnableValue, .true, .@"=")) {
                ADFoutput.nodetype = .output;
                ADFoutput.parents = &.{&ADFMult};
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
                    &PPRE1,
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
                    &PPRE4,
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
                    &PPRE1,
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
            if (check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=")) {
                const LPTIM23Mult_clk_value = LPTIM23CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM23Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM23CLockSelection",
                });
                const LPTIM23Multparents = [_]*const ClockNode{
                    &PPRE4,
                    &DIVP2,
                    &DIVR3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERSource,
                };
                LPTIM23Mult.nodetype = .multi;
                LPTIM23Mult.parents = &.{LPTIM23Multparents[LPTIM23Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=")) {
                LPTIM23output.nodetype = .output;
                LPTIM23output.parents = &.{&LPTIM23Mult};
            }
            if (check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=")) {
                const LPTIM45Mult_clk_value = LPTIM45CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM45Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM45CLockSelection",
                });
                const LPTIM45Multparents = [_]*const ClockNode{
                    &PPRE4,
                    &DIVP2,
                    &DIVR3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERSource,
                };
                LPTIM45Mult.nodetype = .multi;
                LPTIM45Mult.parents = &.{LPTIM45Multparents[LPTIM45Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=")) {
                LPTIM45output.nodetype = .output;
                LPTIM45output.parents = &.{&LPTIM45Mult};
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
                    &PPRE4,
                    &DIVQ2,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
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
                    &PPRE2,
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
            if (check_ref(@TypeOf(EnableHSEUSBPHYDevisorValue), EnableHSEUSBPHYDevisorValue, .true, .@"=")) {
                const HSEUSBPHYDevisor_clk_value = RCC_USBPHY_Clock_Source_FROM_HSEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEUSBPHYDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_USBPHY_Clock_Source_FROM_HSE",
                });
                HSEUSBPHYDevisor.nodetype = .div;
                HSEUSBPHYDevisor.value = HSEUSBPHYDevisor_clk_value.get();
                HSEUSBPHYDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"="))
            {
                const USBPHYCLKMux_clk_value = USBPHYCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBPHYCLKMux",
                    "Else",
                    "No Extra Log",
                    "USBPHYCLKSource",
                });
                const USBPHYCLKMuxparents = [_]*const ClockNode{
                    &HSEOSC,
                    &HSEUSBPHYDevisor,
                    &DIVQ3,
                };
                USBPHYCLKMux.nodetype = .multi;
                USBPHYCLKMux.parents = &.{USBPHYCLKMuxparents[USBPHYCLKMux_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"="))
            {
                USBPHYCLKOutput.nodetype = .output;
                USBPHYCLKOutput.parents = &.{&USBPHYCLKMux};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"="))
            {
                const USBPHYRC_clk_value = USB_PHY_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBPHYRC",
                    "Else",
                    "No Extra Log",
                    "USB_PHY_VALUE",
                });
                USBPHYRC.nodetype = .source;
                USBPHYRC.value = USBPHYRC_clk_value;
            }
            if (check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=")) {
                const USBPHYRC60_clk_value = USB_PHY_VALUE60Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBPHYRC60",
                    "Else",
                    "No Extra Log",
                    "USB_PHY_VALUE60",
                });
                USBPHYRC60.nodetype = .source;
                USBPHYRC60.value = USBPHYRC60_clk_value;
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=")) {
                const USBOCLKMux_clk_value = USBCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBOCLKMux",
                    "Else",
                    "No Extra Log",
                    "USBCLockSelection",
                });
                const USBOCLKMuxparents = [_]*const ClockNode{
                    &RC48,
                    &DIVQ3,
                    &HSEOSC,
                    &USBPHYRC,
                };
                USBOCLKMux.nodetype = .multi;
                USBOCLKMux.parents = &.{USBOCLKMuxparents[USBOCLKMux_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=")) {
                USBOFSCLKOutput.nodetype = .output;
                USBOFSCLKOutput.parents = &.{&USBOCLKMux};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                RNGOutput.nodetype = .output;
                RNGOutput.parents = &.{&RC48};
            }
            if (check_ref(@TypeOf(DTSEnableValue), DTSEnableValue, .true, .@"=")) {
                DTSOutput.nodetype = .output;
                DTSOutput.parents = &.{&LSEOSC};
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
                    &DIVP2,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                FDCANoutput.nodetype = .output;
                FDCANoutput.parents = &.{&FDCANMult};
            }
            if (check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=")) {
                const XSPI1Mult_clk_value = Xspi1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "XSPI1Mult",
                    "Else",
                    "No Extra Log",
                    "Xspi1ClockSelection",
                });
                const XSPI1Multparents = [_]*const ClockNode{
                    &AHB5Output,
                    &DIVS2,
                    &DIVT2,
                };
                XSPI1Mult.nodetype = .multi;
                XSPI1Mult.parents = &.{XSPI1Multparents[XSPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCSPI1EnableValue), OCSPI1EnableValue, .true, .@"=")) {
                XSPI1output.nodetype = .output;
                XSPI1output.parents = &.{&XSPI1Mult};
            }
            if (check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=")) {
                const PSSIMult_clk_value = PSSICLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PSSIMult",
                    "Else",
                    "No Extra Log",
                    "PSSICLockSelection",
                });
                const PSSIMultparents = [_]*const ClockNode{
                    &DIVR3,
                    &CKPERSource,
                };
                PSSIMult.nodetype = .multi;
                PSSIMult.parents = &.{PSSIMultparents[PSSIMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=")) {
                PSSIoutput.nodetype = .output;
                PSSIoutput.parents = &.{&PSSIMult};
            }
            if (check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"=")) {
                const XSPI2Mult_clk_value = Xspi2ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "XSPI2Mult",
                    "Else",
                    "No Extra Log",
                    "Xspi2ClockSelection",
                });
                const XSPI2Multparents = [_]*const ClockNode{
                    &AHB5Output,
                    &DIVS2,
                    &DIVT2,
                };
                XSPI2Mult.nodetype = .multi;
                XSPI2Mult.parents = &.{XSPI2Multparents[XSPI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OCSPI2EnableValue), OCSPI2EnableValue, .true, .@"=")) {
                XSPI2output.nodetype = .output;
                XSPI2output.parents = &.{&XSPI2Mult};
            }
            if (check_ref(@TypeOf(ETHClockEnableValue), ETHClockEnableValue, .true, .@"=")) {
                const ETHPHYMult_clk_value = ETHPHYCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ETHPHYMult",
                    "Else",
                    "No Extra Log",
                    "ETHPHYCLockSelection",
                });
                const ETHPHYMultparents = [_]*const ClockNode{
                    &HSEOSC,
                    &DIVS3,
                };
                ETHPHYMult.nodetype = .multi;
                ETHPHYMult.parents = &.{ETHPHYMultparents[ETHPHYMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ETHClockEnableValue), ETHClockEnableValue, .true, .@"=")) {
                ETHPHYoutput.nodetype = .output;
                ETHPHYoutput.parents = &.{&ETHPHYMult};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                const ETH1Mult_clk_value = ETH1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ETH1Mult",
                    "Else",
                    "No Extra Log",
                    "ETH1CLockSelection",
                });
                const ETH1Multparents = [_]*const ClockNode{
                    &Dig_CKIN,
                    &HSEOSC,
                    &ETHPHYMult,
                };
                ETH1Mult.nodetype = .multi;
                ETH1Mult.parents = &.{ETH1Multparents[ETH1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                ETH1output.nodetype = .output;
                ETH1output.parents = &.{&ETH1Mult};
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
                    &CSICECDevisor,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                CECoutput.nodetype = .output;
                CECoutput.parents = &.{&CECMult};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CSICECDevisor_clk_value = CSI_DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CSICECDevisor",
                    "Else",
                    "No Extra Log",
                    "CSI_DIV",
                });
                CSICECDevisor.nodetype = .div;
                CSICECDevisor.value = CSICECDevisor_clk_value.get();
                CSICECDevisor.parents = &.{&CSIRC};
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
                    .max = 6e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CPREFreq_Value VALUE
            _ = blk: {
                CPREOutput.limit = .{
                    .min = null,
                    .max = 6e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CpuClockFreq_Value VALUE
            _ = blk: {
                CpuClockOutput.limit = .{
                    .min = null,
                    .max = 6e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CortexFreq_Value VALUE
            _ = blk: {
                CortexSysOutput.limit = .{
                    .min = null,
                    .max = 6e8,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 3e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AXIClockFreq_Value VALUE
            _ = blk: {
                AXIClockOutput.limit = .{
                    .min = null,
                    .max = 3e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB5ClockFreq_Value VALUE
            _ = blk: {
                AHB5Output.limit = .{
                    .min = null,
                    .max = 3e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB5Freq_Value VALUE
            _ = blk: {
                APB5Output.limit = .{
                    .min = null,
                    .max = 1.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB1234Freq_Value VALUE
            _ = blk: {
                AHB1234Output.limit = .{
                    .min = null,
                    .max = 3e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 1.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 1.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB4Freq_Value VALUE
            _ = blk: {
                APB4Output.limit = .{
                    .min = null,
                    .max = 1.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DIVQ1Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    DIVQ1output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVQ1output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    DIVP2output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVP2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    DIVQ2output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVQ2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVR2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    DIVR2output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVR2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVS2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2SUsedValue), PLL2SUsedValue, 1, .@"=")) {
                    DIVS2output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVS2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVT2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2TUsedValue), PLL2TUsedValue, 1, .@"=")) {
                    DIVT2output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVT2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP3Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    DIVP3output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVP3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ3Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    DIVQ3output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVQ3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVR3Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"=")) {
                    DIVR3output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVR3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVS3Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3SUsedValue), PLL3SUsedValue, 1, .@"=")) {
                    DIVS3output.limit = .{
                        .min = null,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                DIVS3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF SDMMCFreq_Value VALUE
            _ = blk: {
                SDMMCoutput.limit = .{
                    .min = null,
                    .max = 2e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                RNGOutput.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF DTSFreq_Value VALUE
            _ = blk: {
                DTSOutput.limit = .{
                    .min = null,
                    .max = 9e7,
                };

                break :blk null;
            };

            //POST CLOCK REF ETHPHYFreq_Value VALUE
            _ = blk: {
                ETHPHYoutput.limit = .{
                    .min = 2.5e7,
                    .max = 5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOInput1Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
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
                if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
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
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
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
                if (((check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE1;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE2;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                break :blk item;
            };
            const PLL1_VCO_SELValue: ?PLL1_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL1_VCI_RangeValue), PLL1_VCI_RangeValue, .RCC_PLL_VCOINPUT_RANGE0, .@"=")) and check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCO_SELList = .RCC_PLL_VCO_LOW;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
                    const item: PLL1_VCO_SELList = .RCC_PLL_VCO_HIGH;
                    break :blk item;
                }
                const item: PLL1_VCO_SELList = .RCC_PLL_VCO_HIGH;
                break :blk item;
            };

            //POST CLOCK REF VCO1OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) and (check_ref(@TypeOf(PLL1_VCO_SELValue), PLL1_VCO_SELValue, .RCC_PLL_VCO_HIGH, .@"="))) {
                    VCO1Output.limit = .{
                        .min = 4e8,
                        .max = 1.6e9,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"=")) {
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
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLL1CLK.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                PLL1CLK.value = 96000000;
                break :blk null;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCO2Input.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE0;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE1;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE2;
                    break :blk item;
                } else if (((check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCO2Input.get_as_ref(), 8000000, .@"="))) and (check_ref(?f32, VCO2Input.get_as_ref(), 1600000, .@"<")) and ((check_ref(?f32, VCO2Input.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCO2Input.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                break :blk item;
            };
            const PLL2_VCO_SELValue: ?PLL2_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL2_VCI_RangeValue), PLL2_VCI_RangeValue, .RCC_PLL_VCOINPUT_RANGE0, .@"=")) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL_VCO_LOW;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCO_SELList = .RCC_PLL_VCO_HIGH;
                    break :blk item;
                }
                const item: PLL2_VCO_SELList = .RCC_PLL_VCO_HIGH;
                break :blk item;
            };

            //POST CLOCK REF VCO2OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) and (check_ref(@TypeOf(PLL2_VCO_SELValue), PLL2_VCO_SELValue, .RCC_PLL_VCO_HIGH, .@"="))) {
                    VCO2Output.limit = .{
                        .min = 4e8,
                        .max = 1.6e9,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
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
                    const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE0;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE1;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE2;
                    break :blk item;
                } else if (((check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCO3Input.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCO3Input.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCO3Input.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE3;
                break :blk item;
            };
            const PLL3_VCO_SELValue: ?PLL3_VCO_SELList = blk: {
                if ((check_ref(@TypeOf(PLL3_VCI_RangeValue), PLL3_VCI_RangeValue, .RCC_PLL_VCOINPUT_RANGE0, .@"=")) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL_VCO_LOW;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCO_SELList = .RCC_PLL_VCO_HIGH;
                    break :blk item;
                }
                const item: PLL3_VCO_SELList = .RCC_PLL_VCO_HIGH;
                break :blk item;
            };

            //POST CLOCK REF VCO3OutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=") and (check_ref(@TypeOf(PLL3_VCO_SELValue), PLL3_VCO_SELValue, .RCC_PLL_VCO_HIGH, .@"="))) {
                    VCO3Output.limit = .{
                        .min = 4e8,
                        .max = 1.6e9,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
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
                if (((check_ref(?f32, CpuClockOutput.get_as_ref(), 400000000, .@"<")) or (check_ref(?f32, CpuClockOutput.get_as_ref(), 400000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                } else if (((check_ref(?f32, CpuClockOutput.get_as_ref(), 600000000, .@"<")) or (check_ref(?f32, CpuClockOutput.get_as_ref(), 600000000, .@"="))) and (check_ref(?f32, CpuClockOutput.get_as_ref(), 400000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((CpuClockFreq_Value < 600000000)|(CpuClockFreq_Value = 600000000)) & (CpuClockFreq_Value > 400000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(?f32, CpuClockOutput.get_as_ref(), 600000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "(CpuClockFreq_Value > 600000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
                        }
                    }
                    break :blk item;
                }
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 280000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 280000000))", "No Extra Log", "FLASH_LATENCY_7", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 240000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 240000000))", "No Extra Log", "FLASH_LATENCY_6", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 200000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 200000000))", "No Extra Log", "FLASH_LATENCY_5", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 160000000))", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 120000000))", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 80000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 80000000))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((scale0 and (check_ref(?f32, AHBOutput.get_as_ref(), 40000000, .@">")))) {
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
                            , .{ "FLatency", "(scale0 &  (HCLKFreq_Value > 40000000))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 216000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 216000000))", "No Extra Log", "FLASH_LATENCY_6", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 180000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 180000000))", "No Extra Log", "FLASH_LATENCY_5", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 144000000))", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 108000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 108000000))", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 72000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 72000000))", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and (check_ref(?f32, AHBOutput.get_as_ref(), 36000000, .@">")))) {
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
                            , .{ "FLatency", "(scale1 &  (HCLKFreq_Value > 36000000))", "No Extra Log", "FLASH_LATENCY_1", i });
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
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
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

            out.TPIUOutput = try TPIUOutput.get_output();
            out.TPIUPrescaler = try TPIUPrescaler.get_output();
            out.CpuClockOutput = try CpuClockOutput.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.AXIClockOutput = try AXIClockOutput.get_output();
            out.XSPI1output = try XSPI1output.get_output();
            out.XSPI1Mult = try XSPI1Mult.get_output();
            out.XSPI2output = try XSPI2output.get_output();
            out.XSPI2Mult = try XSPI2Mult.get_output();
            out.FMCoutput = try FMCoutput.get_output();
            out.FMCMult = try FMCMult.get_output();
            out.AHB5Output = try AHB5Output.get_output();
            out.APB5Output = try APB5Output.get_output();
            out.PPRE5 = try PPRE5.get_output();
            out.AHB1234Output = try AHB1234Output.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.Tim1Output = try Tim1Output.get_output();
            out.Tim1Mul = try Tim1Mul.get_output();
            out.SPI45output = try SPI45output.get_output();
            out.SPI45Mult = try SPI45Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.USART234578output = try USART234578output.get_output();
            out.USART234578Mult = try USART234578Mult.get_output();
            out.PPRE1 = try PPRE1.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.Tim2Output = try Tim2Output.get_output();
            out.Tim2Mul = try Tim2Mul.get_output();
            out.PPRE2 = try PPRE2.get_output();
            out.APB4Output = try APB4Output.get_output();
            out.PPRE4 = try PPRE4.get_output();
            out.ADFoutput = try ADFoutput.get_output();
            out.ADFMult = try ADFMult.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.BMPRE = try BMPRE.get_output();
            out.CPREOutput = try CPREOutput.get_output();
            out.CPRE = try CPRE.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.DIVP1 = try DIVP1.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.SPDIFMult = try SPDIFMult.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI23output = try SPI23output.get_output();
            out.SPI23Mult = try SPI23Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.DIVQ1output = try DIVQ1output.get_output();
            out.DIVQ1 = try DIVQ1.get_output();
            out.DIVR1output = try DIVR1output.get_output();
            out.DIVR1 = try DIVR1.get_output();
            out.DIVS1output = try DIVS1output.get_output();
            out.DIVS1 = try DIVS1.get_output();
            out.DIVT1output = try DIVT1output.get_output();
            out.DIVT1 = try DIVT1.get_output();
            out.DIVN1 = try DIVN1.get_output();
            out.DIVM1 = try DIVM1.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.LPTIM23output = try LPTIM23output.get_output();
            out.LPTIM23Mult = try LPTIM23Mult.get_output();
            out.LPTIM45output = try LPTIM45output.get_output();
            out.LPTIM45Mult = try LPTIM45Mult.get_output();
            out.DIVP2output = try DIVP2output.get_output();
            out.DIVP2 = try DIVP2.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.DIVQ2output = try DIVQ2output.get_output();
            out.DIVQ2 = try DIVQ2.get_output();
            out.DIVR2output = try DIVR2output.get_output();
            out.DIVR2 = try DIVR2.get_output();
            out.DIVS2output = try DIVS2output.get_output();
            out.SDMMCoutput = try SDMMCoutput.get_output();
            out.SDMMCMult = try SDMMCMult.get_output();
            out.DIVS2 = try DIVS2.get_output();
            out.DIVT2output = try DIVT2output.get_output();
            out.DIVT2 = try DIVT2.get_output();
            out.DIVN2 = try DIVN2.get_output();
            out.DIVM2 = try DIVM2.get_output();
            out.DIVP3output = try DIVP3output.get_output();
            out.DIVP3 = try DIVP3.get_output();
            out.DIVQ3output = try DIVQ3output.get_output();
            out.USBPHYCLKOutput = try USBPHYCLKOutput.get_output();
            out.USBOFSCLKOutput = try USBOFSCLKOutput.get_output();
            out.USBOCLKMux = try USBOCLKMux.get_output();
            out.USBPHYRC = try USBPHYRC.get_output();
            out.USBPHYRC60 = try USBPHYRC60.get_output();
            out.USBPHYCLKMux = try USBPHYCLKMux.get_output();
            out.DIVQ3 = try DIVQ3.get_output();
            out.DIVR3output = try DIVR3output.get_output();
            out.I2C23output = try I2C23output.get_output();
            out.I2C23Mult = try I2C23Mult.get_output();
            out.PSSIoutput = try PSSIoutput.get_output();
            out.PSSIMult = try PSSIMult.get_output();
            out.LTDCOutput = try LTDCOutput.get_output();
            out.DIVR3 = try DIVR3.get_output();
            out.DIVN3 = try DIVN3.get_output();
            out.DIVM3 = try DIVM3.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.CKPERoutput = try CKPERoutput.get_output();
            out.CKPERSource = try CKPERSource.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.UCPDoutput = try UCPDoutput.get_output();
            out.HSI_DIV = try HSI_DIV.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEUSBPHYDevisor = try HSEUSBPHYDevisor.get_output();
            out.ETHPHYoutput = try ETHPHYoutput.get_output();
            out.ETH1output = try ETH1output.get_output();
            out.ETH1Mult = try ETH1Mult.get_output();
            out.ETHPHYMult = try ETHPHYMult.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.CECoutput = try CECoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.DTSOutput = try DTSOutput.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSICECDevisor = try CSICECDevisor.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.RNGOutput = try RNGOutput.get_output();
            out.RC48 = try RC48.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.Dig_CKIN = try Dig_CKIN.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.PLL2FRACN = try PLL2FRACN.get_output();
            out.PLL3FRACN = try PLL3FRACN.get_output();
            out.DIVS3output = try DIVS3output.get_output();
            out.DIVS3 = try DIVS3.get_output();
            out.DIVT3output = try DIVT3output.get_output();
            out.DIVT3 = try DIVT3.get_output();
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
            ref_out.DIGITAL_CLOCK_VALUE = DIGITAL_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.CPRE = CPREValue;
            ref_out.TPIU = TPIUValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.BMPRE = BMPREValue;
            ref_out.PPRE5 = PPRE5Value;
            ref_out.PPRE1 = PPRE1Value;
            ref_out.Tim1Mul = Tim1MulValue;
            ref_out.PPRE2 = PPRE2Value;
            ref_out.Tim2Mul = Tim2MulValue;
            ref_out.PPRE4 = PPRE4Value;
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
            ref_out.DIVS1 = DIVS1Value;
            ref_out.DIVT1 = DIVT1Value;
            ref_out.DIVN2 = DIVN2Value;
            ref_out.PLL2FRACN = PLL2FRACNValue;
            ref_out.DIVP2 = DIVP2Value;
            ref_out.DIVQ2 = DIVQ2Value;
            ref_out.DIVR2 = DIVR2Value;
            ref_out.DIVS2 = DIVS2Value;
            ref_out.DIVT2 = DIVT2Value;
            ref_out.DIVN3 = DIVN3Value;
            ref_out.PLL3FRACN = PLL3FRACNValue;
            ref_out.DIVP3 = DIVP3Value;
            ref_out.DIVQ3 = DIVQ3Value;
            ref_out.DIVR3 = DIVR3Value;
            ref_out.DIVS3 = DIVS3Value;
            ref_out.DIVT3 = DIVT3Value;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.HSIDivToUCPD = HSIDivToUCPDValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI23CLockSelection = SPI23CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C23CLockSelection = I2C23CLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.FmcClockSelection = FmcClockSelectionValue;
            ref_out.SDMMC1CLockSelection = SDMMC1CLockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.Adf1ClockSelection = Adf1ClockSelectionValue;
            ref_out.USART234578CLockSelection = USART234578CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM23CLockSelection = LPTIM23CLockSelectionValue;
            ref_out.LPTIM45CLockSelection = LPTIM45CLockSelectionValue;
            ref_out.SPI6CLockSelection = SPI6CLockSelectionValue;
            ref_out.Spi45ClockSelection = Spi45ClockSelectionValue;
            ref_out.RCC_USBPHY_Clock_Source_FROM_HSE = RCC_USBPHY_Clock_Source_FROM_HSEValue;
            ref_out.USBPHYCLKSource = USBPHYCLKSourceValue;
            ref_out.USB_PHY_VALUE = USB_PHY_VALUEValue;
            ref_out.USB_PHY_VALUE60 = USB_PHY_VALUE60Value;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.FDCANCLockSelection = FDCANCLockSelectionValue;
            ref_out.Xspi1ClockSelection = Xspi1ClockSelectionValue;
            ref_out.PSSICLockSelection = PSSICLockSelectionValue;
            ref_out.Xspi2ClockSelection = Xspi2ClockSelectionValue;
            ref_out.ETHPHYCLockSelection = ETHPHYCLockSelectionValue;
            ref_out.ETH1CLockSelection = ETH1CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.CECCLockSelection = CECCLockSelectionValue;
            ref_out.CSI_DIV = CSI_DIVValue;
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
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.PLL1_VCO_SEL = PLL1_VCO_SELValue;
            ref_out.PLL2_VCO_SEL = PLL2_VCO_SELValue;
            ref_out.PLL3_VCO_SEL = PLL3_VCO_SELValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEDIGByPass = config.flags.HSEDIGByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEDIGByPass = config.flags.LSEDIGByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCO1Config = config.flags.MCO1Config;
            ref_out.flags.MCO2Config = config.flags.MCO2Config;
            ref_out.flags.AudioClockConfig = config.flags.AudioClockConfig;
            ref_out.flags.DigitalClockConfig = config.flags.DigitalClockConfig;
            ref_out.flags.ETHClockConfig = config.flags.ETHClockConfig;
            ref_out.flags.CRSActivatedSourceGPIO = config.flags.CRSActivatedSourceGPIO;
            ref_out.flags.CRSActivatedSourceLSE = config.flags.CRSActivatedSourceLSE;
            ref_out.flags.CRSActivatedSourceUSB = config.flags.CRSActivatedSourceUSB;
            ref_out.flags.SAI1_SAIAUsed_ForRCC = config.flags.SAI1_SAIAUsed_ForRCC;
            ref_out.flags.SAI1_SAIBUsed_ForRCC = config.flags.SAI1_SAIBUsed_ForRCC;
            ref_out.flags.LPTIM1Used_ForRCC = config.flags.LPTIM1Used_ForRCC;
            ref_out.flags.SAI2_SAIAUsed_ForRCC = config.flags.SAI2_SAIAUsed_ForRCC;
            ref_out.flags.SAI2_SAIBUsed_ForRCC = config.flags.SAI2_SAIBUsed_ForRCC;
            ref_out.flags.USE_ADC1 = config.flags.USE_ADC1;
            ref_out.flags.ADC1UsedAsynchronousCLK_ForRCC = config.flags.ADC1UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC2 = config.flags.USE_ADC2;
            ref_out.flags.ADC2UsedAsynchronousCLK_ForRCC = config.flags.ADC2UsedAsynchronousCLK_ForRCC;
            ref_out.flags.LPTIM4Used_ForRCC = config.flags.LPTIM4Used_ForRCC;
            ref_out.flags.LPTIM5Used_ForRCC = config.flags.LPTIM5Used_ForRCC;
            ref_out.flags.SPI1Used_ForRCC = config.flags.SPI1Used_ForRCC;
            ref_out.flags.SPI2Used_ForRCC = config.flags.SPI2Used_ForRCC;
            ref_out.flags.SPI3Used_ForRCC = config.flags.SPI3Used_ForRCC;
            ref_out.flags.I2S1Used_ForRCC = config.flags.I2S1Used_ForRCC;
            ref_out.flags.I2S2Used_ForRCC = config.flags.I2S2Used_ForRCC;
            ref_out.flags.I2S3Used_ForRCC = config.flags.I2S3Used_ForRCC;
            ref_out.flags.LPTIM2Used_ForRCC = config.flags.LPTIM2Used_ForRCC;
            ref_out.flags.LPTIM3Used_ForRCC = config.flags.LPTIM3Used_ForRCC;
            ref_out.flags.SPDIFRXUsed_ForRCC = config.flags.SPDIFRXUsed_ForRCC;
            ref_out.flags.FDCAN1Used_ForRCC = config.flags.FDCAN1Used_ForRCC;
            ref_out.flags.FDCAN2Used_ForRCC = config.flags.FDCAN2Used_ForRCC;
            ref_out.flags.FMCUsed_ForRCC = config.flags.FMCUsed_ForRCC;
            ref_out.flags.SPI6Used_ForRCC = config.flags.SPI6Used_ForRCC;
            ref_out.flags.I2S6Used_ForRCC = config.flags.I2S6Used_ForRCC;
            ref_out.flags.LPUARTUsed_ForRCC = config.flags.LPUARTUsed_ForRCC;
            ref_out.flags.USART2Used_ForRCC = config.flags.USART2Used_ForRCC;
            ref_out.flags.USART3Used_ForRCC = config.flags.USART3Used_ForRCC;
            ref_out.flags.UART4Used_ForRCC = config.flags.UART4Used_ForRCC;
            ref_out.flags.UART5Used_ForRCC = config.flags.UART5Used_ForRCC;
            ref_out.flags.UART7Used_ForRCC = config.flags.UART7Used_ForRCC;
            ref_out.flags.UART8Used_ForRCC = config.flags.UART8Used_ForRCC;
            ref_out.flags.USART1Used_ForRCC = config.flags.USART1Used_ForRCC;
            ref_out.flags.SPI4Used_ForRCC = config.flags.SPI4Used_ForRCC;
            ref_out.flags.SPI5Used_ForRCC = config.flags.SPI5Used_ForRCC;
            ref_out.flags.SDMMC1Used_ForRCC = config.flags.SDMMC1Used_ForRCC;
            ref_out.flags.SDMMC2Used_ForRCC = config.flags.SDMMC2Used_ForRCC;
            ref_out.flags.LTDCUsed_ForRCC = config.flags.LTDCUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.RNGUsed_ForRCC = config.flags.RNGUsed_ForRCC;
            ref_out.flags.CECUsed_ForRCC = config.flags.CECUsed_ForRCC;
            ref_out.flags.USB_OTG_FS_Used = config.flags.USB_OTG_FS_Used;
            ref_out.flags.USB_OTG_HS_Used = config.flags.USB_OTG_HS_Used;
            ref_out.flags.DTS_Used = config.flags.DTS_Used;
            ref_out.flags.ADF1_Used = config.flags.ADF1_Used;
            ref_out.flags.XSPI1_Used = config.flags.XSPI1_Used;
            ref_out.flags.XSPI2_Used = config.flags.XSPI2_Used;
            ref_out.flags.I2C2_Used = config.flags.I2C2_Used;
            ref_out.flags.I2C3_Used = config.flags.I2C3_Used;
            ref_out.flags.I2C1_Used = config.flags.I2C1_Used;
            ref_out.flags.I3C1_Used = config.flags.I3C1_Used;
            ref_out.flags.PSSI_Used = config.flags.PSSI_Used;
            ref_out.flags.ETH_Used = config.flags.ETH_Used;
            ref_out.flags.UCPD1_Used = config.flags.UCPD1_Used;
            ref_out.flags.LSIEnable = check_ref(?LSIEnableList, LSIEnableValue, .true, .@"=");
            ref_out.flags.ExtClockEnable = check_ref(?ExtClockEnableList, ExtClockEnableValue, .true, .@"=");
            ref_out.flags.DigExtClockEnable = check_ref(?DigExtClockEnableList, DigExtClockEnableValue, .true, .@"=");
            ref_out.flags.MCO1OutPutEnable = check_ref(?MCO1OutPutEnableList, MCO1OutPutEnableValue, .true, .@"=");
            ref_out.flags.MCO2OutPutEnable = check_ref(?MCO2OutPutEnableList, MCO2OutPutEnableValue, .true, .@"=");
            ref_out.flags.cKPerEnable = check_ref(?cKPerEnableList, cKPerEnableValue, .true, .@"=");
            ref_out.flags.SAI1Enable = check_ref(?SAI1EnableList, SAI1EnableValue, .true, .@"=");
            ref_out.flags.SAI2Enable = check_ref(?SAI2EnableList, SAI2EnableValue, .true, .@"=");
            ref_out.flags.SPI1Enable = check_ref(?SPI1EnableList, SPI1EnableValue, .true, .@"=");
            ref_out.flags.SPDIFEnable = check_ref(?SPDIFEnableList, SPDIFEnableValue, .true, .@"=");
            ref_out.flags.FDCANEnable = check_ref(?FDCANEnableList, FDCANEnableValue, .true, .@"=");
            ref_out.flags.FMCEnable = check_ref(?FMCEnableList, FMCEnableValue, .true, .@"=");
            ref_out.flags.SPI23Enable = check_ref(?SPI23EnableList, SPI23EnableValue, .true, .@"=");
            ref_out.flags.ADF1Enable = check_ref(?ADF1EnableList, ADF1EnableValue, .true, .@"=");
            ref_out.flags.LPTIM45Enable = check_ref(?LPTIM45EnableList, LPTIM45EnableValue, .true, .@"=");
            ref_out.flags.LPTIM23Enable = check_ref(?LPTIM23EnableList, LPTIM23EnableValue, .true, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.LPTIM1Enable = check_ref(?LPTIM1EnableList, LPTIM1EnableValue, .true, .@"=");
            ref_out.flags.SPI6Enable = check_ref(?SPI6EnableList, SPI6EnableValue, .true, .@"=");
            ref_out.flags.LPUART1Enable = check_ref(?LPUART1EnableList, LPUART1EnableValue, .true, .@"=");
            ref_out.flags.USART234578Enable = check_ref(?USART234578EnableList, USART234578EnableValue, .true, .@"=");
            ref_out.flags.USART1Enable = check_ref(?USART1EnableList, USART1EnableValue, .true, .@"=");
            ref_out.flags.SPI45Enable = check_ref(?SPI45EnableList, SPI45EnableValue, .true, .@"=");
            ref_out.flags.SDMMC1Enable = check_ref(?SDMMC1EnableList, SDMMC1EnableValue, .true, .@"=");
            ref_out.flags.OCSPI1Enable = check_ref(?OCSPI1EnableList, OCSPI1EnableValue, .true, .@"=");
            ref_out.flags.OCSPI2Enable = check_ref(?OCSPI2EnableList, OCSPI2EnableValue, .true, .@"=");
            ref_out.flags.EnableUSBOFS = check_ref(?EnableUSBOFSList, EnableUSBOFSValue, .true, .@"=");
            ref_out.flags.EnableUSBOHS = check_ref(?EnableUSBOHSList, EnableUSBOHSValue, .true, .@"=");
            ref_out.flags.I2C23Enable = check_ref(?I2C23EnableList, I2C23EnableValue, .true, .@"=");
            ref_out.flags.I2C1Enable = check_ref(?I2C1EnableList, I2C1EnableValue, .true, .@"=");
            ref_out.flags.PSSIEnable = check_ref(?PSSIEnableList, PSSIEnableValue, .true, .@"=");
            ref_out.flags.LTDCEnable = check_ref(?LTDCEnableList, LTDCEnableValue, .true, .@"=");
            ref_out.flags.ETH1EnableDiv = check_ref(?ETH1EnableDivList, ETH1EnableDivValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.UCPDEnable = check_ref(?UCPDEnableList, UCPDEnableValue, .true, .@"=");
            ref_out.flags.EnableHSEUSBPHYDevisor = check_ref(?EnableHSEUSBPHYDevisorList, EnableHSEUSBPHYDevisorValue, .true, .@"=");
            ref_out.flags.RNGEnable = check_ref(?RNGEnableList, RNGEnableValue, .true, .@"=");
            ref_out.flags.DTSEnable = check_ref(?DTSEnableList, DTSEnableValue, .true, .@"=");
            ref_out.flags.ETHClockEnable = check_ref(?ETHClockEnableList, ETHClockEnableValue, .true, .@"=");
            ref_out.flags.ETH1Enable = check_ref(?ETH1EnableList, ETH1EnableValue, .true, .@"=");
            ref_out.flags.CECEnable = check_ref(?CECEnableList, CECEnableValue, .true, .@"=");
            ref_out.flags.PLL1QUsed = check_ref(?f32, PLL1QUsedValue, 1, .@"=");
            ref_out.flags.PLL2PUsed = check_ref(?f32, PLL2PUsedValue, 1, .@"=");
            ref_out.flags.PLL2QUsed = check_ref(?f32, PLL2QUsedValue, 1, .@"=");
            ref_out.flags.PLL2RUsed = check_ref(?f32, PLL2RUsedValue, 1, .@"=");
            ref_out.flags.PLL2SUsed = check_ref(?f32, PLL2SUsedValue, 1, .@"=");
            ref_out.flags.PLL2TUsed = check_ref(?f32, PLL2TUsedValue, 1, .@"=");
            ref_out.flags.PLL3PUsed = check_ref(?f32, PLL3PUsedValue, 1, .@"=");
            ref_out.flags.PLL3QUsed = check_ref(?f32, PLL3QUsedValue, 1, .@"=");
            ref_out.flags.PLL3RUsed = check_ref(?f32, PLL3RUsedValue, 1, .@"=");
            ref_out.flags.PLL3SUsed = check_ref(?f32, PLL3SUsedValue, 1, .@"=");
            ref_out.flags.PLL1Used = check_ref(?f32, PLL1UsedValue, 1, .@"=");
            ref_out.flags.PLL2Used = check_ref(?f32, PLL2UsedValue, 1, .@"=");
            ref_out.flags.PLL3Used = check_ref(?f32, PLL3UsedValue, 1, .@"=");
            ref_out.flags.PLL1PUsed = check_ref(?f32, PLL1PUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.cKPerUsed = check_ref(?f32, cKPerUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
