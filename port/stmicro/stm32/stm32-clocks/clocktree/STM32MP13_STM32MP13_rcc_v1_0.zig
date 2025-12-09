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

pub const MLAHBCLKSourceList = enum {
    RCC_MLAHBSSOURCE_HSI,
    RCC_MLAHBSSOURCE_CSI,
    RCC_MLAHBSSOURCE_HSE,
    RCC_MLAHBSSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MLAHBSSOURCE_HSI => 0,
            .RCC_MLAHBSSOURCE_CSI => 1,
            .RCC_MLAHBSSOURCE_HSE => 2,
            .RCC_MLAHBSSOURCE_PLL3 => 3,
        };
    }
};
pub const MPUCLKSourceList = enum {
    RCC_MPUSOURCE_PLL1,
    RCC_MPUSOURCE_MPUDIV,
    RCC_MPUSOURCE_HSE,
    RCC_MPUSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MPUSOURCE_PLL1 => 0,
            .RCC_MPUSOURCE_MPUDIV => 1,
            .RCC_MPUSOURCE_HSE => 2,
            .RCC_MPUSOURCE_HSI => 3,
        };
    }
};
pub const CKPERCLKSourceList = enum {
    RCC_CKPERCLKSOURCE_HSI,
    RCC_CKPERCLKSOURCE_CSI,
    RCC_CKPERCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CKPERCLKSOURCE_HSI => 0,
            .RCC_CKPERCLKSOURCE_CSI => 1,
            .RCC_CKPERCLKSOURCE_HSE => 2,
        };
    }
};
pub const AXICLKSourceList = enum {
    RCC_AXISSOURCE_HSE,
    RCC_AXISSOURCE_HSI,
    RCC_AXISSOURCE_PLL2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_AXISSOURCE_HSE => 0,
            .RCC_AXISSOURCE_HSI => 1,
            .RCC_AXISSOURCE_PLL2 => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_CSI,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_HSI => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_CSI => 2,
            .RCC_MCO1SOURCE_LSI => 3,
            .RCC_MCO1SOURCE_LSE => 4,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_MPU,
    RCC_MCO2SOURCE_AXI,
    RCC_MCO2SOURCE_MLAHB,
    RCC_MCO2SOURCE_PLL4,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_MPU => 0,
            .RCC_MCO2SOURCE_AXI => 1,
            .RCC_MCO2SOURCE_MLAHB => 2,
            .RCC_MCO2SOURCE_PLL4 => 3,
            .RCC_MCO2SOURCE_HSE => 4,
            .RCC_MCO2SOURCE_HSI => 5,
        };
    }
};
pub const PLL12SourceList = enum {
    RCC_PLL12SOURCE_HSI,
    RCC_PLL12SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL12SOURCE_HSI => 0,
            .RCC_PLL12SOURCE_HSE => 1,
        };
    }
};
pub const PLL3SourceList = enum {
    RCC_PLL3SOURCE_HSI,
    RCC_PLL3SOURCE_CSI,
    RCC_PLL3SOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL3SOURCE_HSI => 0,
            .RCC_PLL3SOURCE_CSI => 1,
            .RCC_PLL3SOURCE_HSE => 2,
        };
    }
};
pub const PLL4SourceList = enum {
    RCC_PLL4SOURCE_HSI,
    RCC_PLL4SOURCE_CSI,
    RCC_PLL4SOURCE_HSE,
    RCC_PLL4SOURCE_I2S_CKIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLL4SOURCE_HSI => 0,
            .RCC_PLL4SOURCE_CSI => 1,
            .RCC_PLL4SOURCE_HSE => 2,
            .RCC_PLL4SOURCE_I2S_CKIN => 3,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV => 0,
            .RCC_RTCCLKSOURCE_LSE => 1,
            .RCC_RTCCLKSOURCE_LSI => 2,
        };
    }
};
pub const I2C12CLockSelectionList = enum {
    RCC_I2C12CLKSOURCE_PCLK1,
    RCC_I2C12CLKSOURCE_PLL4,
    RCC_I2C12CLKSOURCE_HSI,
    RCC_I2C12CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C12CLKSOURCE_PCLK1 => 0,
            .RCC_I2C12CLKSOURCE_PLL4 => 1,
            .RCC_I2C12CLKSOURCE_HSI => 2,
            .RCC_I2C12CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK6,
    RCC_I2C3CLKSOURCE_PLL4,
    RCC_I2C3CLKSOURCE_HSI,
    RCC_I2C3CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK6 => 0,
            .RCC_I2C3CLKSOURCE_PLL4 => 1,
            .RCC_I2C3CLKSOURCE_HSI => 2,
            .RCC_I2C3CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_PCLK6,
    RCC_I2C4CLKSOURCE_PLL4,
    RCC_I2C4CLKSOURCE_HSI,
    RCC_I2C4CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_PCLK6 => 0,
            .RCC_I2C4CLKSOURCE_PLL4 => 1,
            .RCC_I2C4CLKSOURCE_HSI => 2,
            .RCC_I2C4CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C5CLockSelectionList = enum {
    RCC_I2C5CLKSOURCE_PCLK6,
    RCC_I2C5CLKSOURCE_PLL4,
    RCC_I2C5CLKSOURCE_HSI,
    RCC_I2C5CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C5CLKSOURCE_PCLK6 => 0,
            .RCC_I2C5CLKSOURCE_PLL4 => 1,
            .RCC_I2C5CLKSOURCE_HSI => 2,
            .RCC_I2C5CLKSOURCE_CSI => 3,
        };
    }
};
pub const SPDIFCLockSelectionList = enum {
    RCC_SPDIFRXCLKSOURCE_PLL4,
    RCC_SPDIFRXCLKSOURCE_PLL3,
    RCC_SPDIFRXCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPDIFRXCLKSOURCE_PLL4 => 0,
            .RCC_SPDIFRXCLKSOURCE_PLL3 => 1,
            .RCC_SPDIFRXCLKSOURCE_HSI => 2,
        };
    }
};
pub const QSPICLockSelectionList = enum {
    RCC_QSPICLKSOURCE_ACLK,
    RCC_QSPICLKSOURCE_PLL4,
    RCC_QSPICLKSOURCE_PLL3,
    RCC_QSPICLKSOURCE_PER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_QSPICLKSOURCE_ACLK => 0,
            .RCC_QSPICLKSOURCE_PLL4 => 1,
            .RCC_QSPICLKSOURCE_PLL3 => 2,
            .RCC_QSPICLKSOURCE_PER => 3,
        };
    }
};
pub const FMCCLockSelectionList = enum {
    RCC_FMCCLKSOURCE_ACLK,
    RCC_FMCCLKSOURCE_PLL3,
    RCC_FMCCLKSOURCE_PLL4,
    RCC_FMCCLKSOURCE_PER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FMCCLKSOURCE_ACLK => 0,
            .RCC_FMCCLKSOURCE_PLL3 => 1,
            .RCC_FMCCLKSOURCE_PLL4 => 2,
            .RCC_FMCCLKSOURCE_PER => 3,
        };
    }
};
pub const SDMMC1CLockSelectionList = enum {
    RCC_SDMMC1CLKSOURCE_HCLK6,
    RCC_SDMMC1CLKSOURCE_PLL3,
    RCC_SDMMC1CLKSOURCE_PLL4,
    RCC_SDMMC1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC1CLKSOURCE_HCLK6 => 0,
            .RCC_SDMMC1CLKSOURCE_PLL3 => 1,
            .RCC_SDMMC1CLKSOURCE_PLL4 => 2,
            .RCC_SDMMC1CLKSOURCE_HSI => 3,
        };
    }
};
pub const SDMMC2CLockSelectionList = enum {
    RCC_SDMMC2CLKSOURCE_HCLK6,
    RCC_SDMMC2CLKSOURCE_PLL3,
    RCC_SDMMC2CLKSOURCE_PLL4,
    RCC_SDMMC2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC2CLKSOURCE_HCLK6 => 0,
            .RCC_SDMMC2CLKSOURCE_PLL3 => 1,
            .RCC_SDMMC2CLKSOURCE_PLL4 => 2,
            .RCC_SDMMC2CLKSOURCE_HSI => 3,
        };
    }
};
pub const STGENCLockSelectionList = enum {
    RCC_STGENCLKSOURCE_HSI,
    RCC_STGENCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_STGENCLKSOURCE_HSI => 0,
            .RCC_STGENCLKSOURCE_HSE => 1,
        };
    }
};
pub const LPTIM45CLockSelectionList = enum {
    RCC_LPTIM45CLKSOURCE_PCLK3,
    RCC_LPTIM45CLKSOURCE_PLL4,
    RCC_LPTIM45CLKSOURCE_PLL3,
    RCC_LPTIM45CLKSOURCE_LSE,
    RCC_LPTIM45CLKSOURCE_LSI,
    RCC_LPTIM45CLKSOURCE_PER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM45CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM45CLKSOURCE_PLL4 => 1,
            .RCC_LPTIM45CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM45CLKSOURCE_LSE => 3,
            .RCC_LPTIM45CLKSOURCE_LSI => 4,
            .RCC_LPTIM45CLKSOURCE_PER => 5,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK3,
    RCC_LPTIM2CLKSOURCE_PLL4,
    RCC_LPTIM2CLKSOURCE_PER,
    RCC_LPTIM2CLKSOURCE_LSE,
    RCC_LPTIM2CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM2CLKSOURCE_PLL4 => 1,
            .RCC_LPTIM2CLKSOURCE_PER => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
            .RCC_LPTIM2CLKSOURCE_LSI => 4,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK1,
    RCC_LPTIM1CLKSOURCE_PLL4,
    RCC_LPTIM1CLKSOURCE_PLL3,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_PER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_PLL4 => 1,
            .RCC_LPTIM1CLKSOURCE_PLL3 => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
            .RCC_LPTIM1CLKSOURCE_LSI => 4,
            .RCC_LPTIM1CLKSOURCE_PER => 5,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK6,
    RCC_USART1CLKSOURCE_PLL4,
    RCC_USART1CLKSOURCE_PLL3,
    RCC_USART1CLKSOURCE_HSE,
    RCC_USART1CLKSOURCE_CSI,
    RCC_USART1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK6 => 0,
            .RCC_USART1CLKSOURCE_PLL4 => 1,
            .RCC_USART1CLKSOURCE_PLL3 => 2,
            .RCC_USART1CLKSOURCE_HSE => 3,
            .RCC_USART1CLKSOURCE_CSI => 4,
            .RCC_USART1CLKSOURCE_HSI => 5,
        };
    }
};
pub const USART2CLockSelectionList = enum {
    RCC_USART2CLKSOURCE_PCLK6,
    RCC_USART2CLKSOURCE_PLL4,
    RCC_USART2CLKSOURCE_HSE,
    RCC_USART2CLKSOURCE_CSI,
    RCC_USART2CLKSOURCE_HSI,
    RCC_USART2CLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_PCLK6 => 0,
            .RCC_USART2CLKSOURCE_PLL4 => 1,
            .RCC_USART2CLKSOURCE_HSE => 2,
            .RCC_USART2CLKSOURCE_CSI => 3,
            .RCC_USART2CLKSOURCE_HSI => 4,
            .RCC_USART2CLKSOURCE_PLL3 => 5,
        };
    }
};
pub const USART35CLockSelectionList = enum {
    RCC_UART35CLKSOURCE_PCLK1,
    RCC_UART35CLKSOURCE_PLL4,
    RCC_UART35CLKSOURCE_HSE,
    RCC_UART35CLKSOURCE_CSI,
    RCC_UART35CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART35CLKSOURCE_PCLK1 => 0,
            .RCC_UART35CLKSOURCE_PLL4 => 1,
            .RCC_UART35CLKSOURCE_HSE => 2,
            .RCC_UART35CLKSOURCE_CSI => 3,
            .RCC_UART35CLKSOURCE_HSI => 4,
        };
    }
};
pub const USART6CLockSelectionList = enum {
    RCC_USART6CLKSOURCE_PCLK2,
    RCC_USART6CLKSOURCE_PLL4,
    RCC_USART6CLKSOURCE_HSE,
    RCC_USART6CLKSOURCE_CSI,
    RCC_USART6CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART6CLKSOURCE_PCLK2 => 0,
            .RCC_USART6CLKSOURCE_PLL4 => 1,
            .RCC_USART6CLKSOURCE_HSE => 2,
            .RCC_USART6CLKSOURCE_CSI => 3,
            .RCC_USART6CLKSOURCE_HSI => 4,
        };
    }
};
pub const UART78CLockSelectionList = enum {
    RCC_UART78CLKSOURCE_PCLK1,
    RCC_UART78CLKSOURCE_PLL4,
    RCC_UART78CLKSOURCE_HSE,
    RCC_UART78CLKSOURCE_CSI,
    RCC_UART78CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART78CLKSOURCE_PCLK1 => 0,
            .RCC_UART78CLKSOURCE_PLL4 => 1,
            .RCC_UART78CLKSOURCE_HSE => 2,
            .RCC_UART78CLKSOURCE_CSI => 3,
            .RCC_UART78CLKSOURCE_HSI => 4,
        };
    }
};
pub const RNG1CLockSelectionList = enum {
    RCC_RNG1CLKSOURCE_CSI,
    RCC_RNG1CLKSOURCE_PLL4,
    RCC_RNG1CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNG1CLKSOURCE_CSI => 0,
            .RCC_RNG1CLKSOURCE_PLL4 => 1,
            .RCC_RNG1CLKSOURCE_LSI => 2,
        };
    }
};
pub const DCMICLockSelectionList = enum {
    RCC_DCMIPPCLKSOURCE_ACLK,
    RCC_DCMIPPCLKSOURCE_PLL2,
    RCC_DCMIPPCLKSOURCE_PLL4,
    RCC_DCMIPPCLKSOURCE_PER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DCMIPPCLKSOURCE_ACLK => 0,
            .RCC_DCMIPPCLKSOURCE_PLL2 => 1,
            .RCC_DCMIPPCLKSOURCE_PLL4 => 2,
            .RCC_DCMIPPCLKSOURCE_PER => 3,
        };
    }
};
pub const SAESCLockSelectionList = enum {
    RCC_SAESCLKSOURCE_ACLK,
    RCC_SAESCLKSOURCE_PER,
    RCC_SAESCLKSOURCE_PLL4,
    RCC_SAESCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAESCLKSOURCE_ACLK => 0,
            .RCC_SAESCLKSOURCE_PER => 1,
            .RCC_SAESCLKSOURCE_PLL4 => 2,
            .RCC_SAESCLKSOURCE_LSI => 3,
        };
    }
};
pub const LPTIM3CLockSelectionList = enum {
    RCC_LPTIM3CLKSOURCE_PCLK3,
    RCC_LPTIM3CLKSOURCE_PLL4,
    RCC_LPTIM3CLKSOURCE_PER,
    RCC_LPTIM3CLKSOURCE_LSE,
    RCC_LPTIM3CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM3CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM3CLKSOURCE_PLL4 => 1,
            .RCC_LPTIM3CLKSOURCE_PER => 2,
            .RCC_LPTIM3CLKSOURCE_LSE => 3,
            .RCC_LPTIM3CLKSOURCE_LSI => 4,
        };
    }
};
pub const SPI4CLockSelectionList = enum {
    RCC_SPI4CLKSOURCE_PCLK6,
    RCC_SPI4CLKSOURCE_PLL4,
    RCC_SPI4CLKSOURCE_HSI,
    RCC_SPI4CLKSOURCE_CSI,
    RCC_SPI4CLKSOURCE_HSE,
    RCC_SPI4CLKSOURCE_I2SCKIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI4CLKSOURCE_PCLK6 => 0,
            .RCC_SPI4CLKSOURCE_PLL4 => 1,
            .RCC_SPI4CLKSOURCE_HSI => 2,
            .RCC_SPI4CLKSOURCE_CSI => 3,
            .RCC_SPI4CLKSOURCE_HSE => 4,
            .RCC_SPI4CLKSOURCE_I2SCKIN => 5,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLL4,
    RCC_SAI2CLKSOURCE_PLL3_Q,
    RCC_SAI2CLKSOURCE_I2SCKIN,
    RCC_SAI2CLKSOURCE_PER,
    RCC_SAI2CLKSOURCE_SPDIF,
    RCC_SAI2CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLL4 => 0,
            .RCC_SAI2CLKSOURCE_PLL3_Q => 1,
            .RCC_SAI2CLKSOURCE_I2SCKIN => 2,
            .RCC_SAI2CLKSOURCE_PER => 3,
            .RCC_SAI2CLKSOURCE_SPDIF => 4,
            .RCC_SAI2CLKSOURCE_PLL3_R => 5,
        };
    }
};
pub const USART4CLockSelectionList = enum {
    RCC_UART4CLKSOURCE_PCLK1,
    RCC_UART4CLKSOURCE_PLL4,
    RCC_UART4CLKSOURCE_HSE,
    RCC_UART4CLKSOURCE_CSI,
    RCC_UART4CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_PCLK1 => 0,
            .RCC_UART4CLKSOURCE_PLL4 => 1,
            .RCC_UART4CLKSOURCE_HSE => 2,
            .RCC_UART4CLKSOURCE_CSI => 3,
            .RCC_UART4CLKSOURCE_HSI => 4,
        };
    }
};
pub const SPI1CLockSelectionList = enum {
    RCC_SPI1CLKSOURCE_PLL4,
    RCC_SPI1CLKSOURCE_PLL3_Q,
    RCC_SPI1CLKSOURCE_I2SCKIN,
    RCC_SPI1CLKSOURCE_PER,
    RCC_SPI1CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PLL4 => 0,
            .RCC_SPI1CLKSOURCE_PLL3_Q => 1,
            .RCC_SPI1CLKSOURCE_I2SCKIN => 2,
            .RCC_SPI1CLKSOURCE_PER => 3,
            .RCC_SPI1CLKSOURCE_PLL3_R => 4,
        };
    }
};
pub const SPI23CLockSelectionList = enum {
    RCC_SPI23CLKSOURCE_PLL4,
    RCC_SPI23CLKSOURCE_PLL3_Q,
    RCC_SPI23CLKSOURCE_I2SCKIN,
    RCC_SPI23CLKSOURCE_PER,
    RCC_SPI23CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI23CLKSOURCE_PLL4 => 0,
            .RCC_SPI23CLKSOURCE_PLL3_Q => 1,
            .RCC_SPI23CLKSOURCE_I2SCKIN => 2,
            .RCC_SPI23CLKSOURCE_PER => 3,
            .RCC_SPI23CLKSOURCE_PLL3_R => 4,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL4,
    RCC_SAI1CLKSOURCE_PLL3_Q,
    RCC_SAI1CLKSOURCE_I2SCKIN,
    RCC_SAI1CLKSOURCE_PER,
    RCC_SAI1CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL4 => 0,
            .RCC_SAI1CLKSOURCE_PLL3_Q => 1,
            .RCC_SAI1CLKSOURCE_I2SCKIN => 2,
            .RCC_SAI1CLKSOURCE_PER => 3,
            .RCC_SAI1CLKSOURCE_PLL3_R => 4,
        };
    }
};
pub const SPI5CLockSelectionList = enum {
    RCC_SPI5CLKSOURCE_PCLK6,
    RCC_SPI5CLKSOURCE_PLL4,
    RCC_SPI5CLKSOURCE_HSI,
    RCC_SPI5CLKSOURCE_CSI,
    RCC_SPI5CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI5CLKSOURCE_PCLK6 => 0,
            .RCC_SPI5CLKSOURCE_PLL4 => 1,
            .RCC_SPI5CLKSOURCE_HSI => 2,
            .RCC_SPI5CLKSOURCE_CSI => 3,
            .RCC_SPI5CLKSOURCE_HSE => 4,
        };
    }
};
pub const FDCANCLockSelectionList = enum {
    RCC_FDCANCLKSOURCE_HSE,
    RCC_FDCANCLKSOURCE_PLL3,
    RCC_FDCANCLKSOURCE_PLL4_Q,
    RCC_FDCANCLKSOURCE_PLL4_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_HSE => 0,
            .RCC_FDCANCLKSOURCE_PLL3 => 1,
            .RCC_FDCANCLKSOURCE_PLL4_Q => 2,
            .RCC_FDCANCLKSOURCE_PLL4_R => 3,
        };
    }
};
pub const ETH1CLockSelectionList = enum {
    RCC_ETH1CLKSOURCE_PLL4,
    RCC_ETH1CLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETH1CLKSOURCE_PLL4 => 0,
            .RCC_ETH1CLKSOURCE_PLL3 => 1,
        };
    }
};
pub const ETH2CLockSelectionList = enum {
    RCC_ETH2CLKSOURCE_PLL4,
    RCC_ETH2CLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETH2CLKSOURCE_PLL4 => 0,
            .RCC_ETH2CLKSOURCE_PLL3 => 1,
        };
    }
};
pub const ADC2CLockSelectionList = enum {
    RCC_ADC2CLKSOURCE_PLL4,
    RCC_ADC2CLKSOURCE_PER,
    RCC_ADC2CLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADC2CLKSOURCE_PLL4 => 0,
            .RCC_ADC2CLKSOURCE_PER => 1,
            .RCC_ADC2CLKSOURCE_PLL3 => 2,
        };
    }
};
pub const ADC1CLockSelectionList = enum {
    RCC_ADC1CLKSOURCE_PLL4,
    RCC_ADC1CLKSOURCE_PER,
    RCC_ADC1CLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADC1CLKSOURCE_PLL4 => 0,
            .RCC_ADC1CLKSOURCE_PER => 1,
            .RCC_ADC1CLKSOURCE_PLL3 => 2,
        };
    }
};
pub const USBPHYCLKSourceList = enum {
    RCC_USBPHYCLKSOURCE_HSE2,
    RCC_USBPHYCLKSOURCE_HSE,
    RCC_USBPHYCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBPHYCLKSOURCE_HSE2 => 0,
            .RCC_USBPHYCLKSOURCE_HSE => 1,
            .RCC_USBPHYCLKSOURCE_PLL4 => 2,
        };
    }
};
pub const USBOCLKSourceList = enum {
    RCC_USBOCLKSOURCE_PLL4,
    RCC_USBOCLKSOURCE_PHY,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBOCLKSOURCE_PLL4 => 0,
            .RCC_USBOCLKSOURCE_PHY => 1,
        };
    }
};
pub const HSIDivValueList = enum {
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
pub const AXI_DivList = enum {
    RCC_AXI_DIV1,
    RCC_AXI_DIV2,
    RCC_AXI_DIV3,
    RCC_AXI_DIV4,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_AXI_DIV1 => 1,
            .RCC_AXI_DIV2 => 2,
            .RCC_AXI_DIV3 => 3,
            .RCC_AXI_DIV4 => 4,
        };
    }
};
pub const APB4DIVList = enum {
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
pub const APB5DIVList = enum {
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
pub const APB6DIVList = enum {
    RCC_APB6_DIV1,
    RCC_APB6_DIV2,
    RCC_APB6_DIV4,
    RCC_APB6_DIV8,
    RCC_APB6_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB6_DIV1 => 1,
            .RCC_APB6_DIV2 => 2,
            .RCC_APB6_DIV4 => 4,
            .RCC_APB6_DIV8 => 8,
            .RCC_APB6_DIV16 => 16,
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
    RCC_MCODIV_16,
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
            .RCC_MCODIV_16 => 16,
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
    RCC_MCODIV_16,
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
            .RCC_MCODIV_16 => 16,
        };
    }
};
pub const MLAHB_DivList = enum {
    RCC_MLAHB_DIV1,
    RCC_MLAHB_DIV2,
    RCC_MLAHB_DIV4,
    RCC_MLAHB_DIV8,
    RCC_MLAHB_DIV16,
    RCC_MLAHB_DIV32,
    RCC_MLAHB_DIV64,
    RCC_MLAHB_DIV128,
    RCC_MLAHB_DIV256,
    RCC_MLAHB_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MLAHB_DIV1 => 1,
            .RCC_MLAHB_DIV2 => 2,
            .RCC_MLAHB_DIV4 => 4,
            .RCC_MLAHB_DIV8 => 8,
            .RCC_MLAHB_DIV16 => 16,
            .RCC_MLAHB_DIV32 => 32,
            .RCC_MLAHB_DIV64 => 64,
            .RCC_MLAHB_DIV128 => 128,
            .RCC_MLAHB_DIV256 => 256,
            .RCC_MLAHB_DIV512 => 512,
        };
    }
};
pub const APB3DIVList = enum {
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
pub const APB1DIVList = enum {
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
pub const APB2DIVList = enum {
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
pub const MPU_DivList = enum {
    RCC_MPU_DIV_OFF,
    RCC_MPU_DIV2,
    RCC_MPU_DIV4,
    RCC_MPU_DIV8,
    RCC_MPU_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MPU_DIV_OFF => 1,
            .RCC_MPU_DIV2 => 2,
            .RCC_MPU_DIV4 => 4,
            .RCC_MPU_DIV8 => 8,
            .RCC_MPU_DIV16 => 16,
        };
    }
};
pub const RCC_USBPHY_Clock_Source_FROM_HSEList = enum {
    RCC_USBPHYCLKSOURCE_HSE2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBPHYCLKSOURCE_HSE2 => 2,
        };
    }
};
pub const USBPHYFreq_ValueList = enum {
    @"19200000",
    @"24000000",
    @"26000000",
    @"30000000",
    @"38400000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"19200000" => 19200000,
            .@"24000000" => 24000000,
            .@"26000000" => 26000000,
            .@"30000000" => 30000000,
            .@"38400000" => 38400000,
        };
    }
};
pub const RCC_TIM_G1_PRescaler_SelectionList = enum {
    RCC_TIMG1PRES_ACTIVATED,
    RCC_TIMG1PRES_DEACTIVATED,
};
pub const RCC_TIM_G2_PRescaler_SelectionList = enum {
    RCC_TIMG2PRES_ACTIVATED,
    RCC_TIMG2PRES_DEACTIVATED,
};
pub const RCC_TIM_G3_PRescaler_SelectionList = enum {
    RCC_TIMG3PRES_ACTIVATED,
    RCC_TIMG3PRES_DEACTIVATED,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const PLL1UserDefinedConfigList = enum {
    false,
    true,
};
pub const PLL1MODEList = enum {
    RCC_PLL_SPREAD_SPECTRUM,
    RCC_PLL_INTEGER,
    RCC_PLL_FRACTIONAL,
};
pub const PLL2MODEList = enum {
    RCC_PLL_SPREAD_SPECTRUM,
    RCC_PLL_INTEGER,
    RCC_PLL_FRACTIONAL,
};
pub const PLL3MODEList = enum {
    RCC_PLL_SPREAD_SPECTRUM,
    RCC_PLL_INTEGER,
    RCC_PLL_FRACTIONAL,
};
pub const PLL4MODEList = enum {
    RCC_PLL_SPREAD_SPECTRUM,
    RCC_PLL_INTEGER,
    RCC_PLL_FRACTIONAL,
};
pub const PLL1CSGList = enum {
    true,
    false,
};
pub const PLL2CSGList = enum {
    true,
    false,
};
pub const PLL3CSGList = enum {
    true,
    false,
};
pub const PLL4CSGList = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const EnableLSEList = enum {
    true,
    false,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const PLL1UserDefinedConfigEnableList = enum {
    true,
    false,
};
pub const cKPerEnableList = enum {
    true,
    false,
};
pub const DACEnableList = enum {
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
pub const DFSDMEnableList = enum {
    true,
    false,
};
pub const DCMIEnableList = enum {
    true,
    false,
};
pub const DDREnableList = enum {
    true,
    false,
};
pub const USART2EnableList = enum {
    true,
    false,
};
pub const ADC2EnableList = enum {
    true,
    false,
};
pub const ADC1EnableList = enum {
    true,
    false,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const ETH1EnableList = enum {
    true,
    false,
};
pub const ETH2EnableList = enum {
    true,
    false,
};
pub const EnableDFSDMAudioList = enum {
    true,
    false,
};
pub const SAI1EnableList = enum {
    true,
    false,
};
pub const SPDIFEnableList = enum {
    true,
    false,
};
pub const SAI2EnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const LPTIM45EnableList = enum {
    true,
    false,
};
pub const SPI1EnableList = enum {
    true,
    false,
};
pub const SPI23EnableList = enum {
    true,
    false,
};
pub const SPI4EnableList = enum {
    true,
    false,
};
pub const FDCANEnableList = enum {
    true,
    false,
};
pub const SDMMC1EnableList = enum {
    true,
    false,
};
pub const SDMMC2EnableList = enum {
    true,
    false,
};
pub const QuadSPIEnableList = enum {
    true,
    false,
};
pub const FMCEnableList = enum {
    true,
    false,
};
pub const LTDCEnableList = enum {
    true,
    false,
};
pub const USART4EnableList = enum {
    true,
    false,
};
pub const SPI5EnableList = enum {
    true,
    false,
};
pub const UART78EnableList = enum {
    true,
    false,
};
pub const USART35EnableList = enum {
    true,
    false,
};
pub const LPTIM2EnableList = enum {
    true,
    false,
};
pub const LPTIM3EnableList = enum {
    true,
    false,
};
pub const USART6EnableList = enum {
    true,
    false,
};
pub const SAESEnableList = enum {
    true,
    false,
};
pub const I2C4EnableList = enum {
    true,
    false,
};
pub const I2C5EnableList = enum {
    true,
    false,
};
pub const EnableUSBOHSList = enum {
    true,
    false,
};
pub const EnableUSBHSList = enum {
    true,
    false,
};
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const I2C12EnableList = enum {
    true,
    false,
};
pub const RNG1EnableList = enum {
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
pub const STGENEnableList = enum {
    true,
};
pub const EnableHSEUSBPHYDevisorList = enum {
    true,
    false,
};
pub const Max650List = enum {
    false,
    true,
};
pub const EnableLSERTCList = enum {
    true,
    false,
};
pub const CECEnableList = enum {
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
            HSEDIGByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEDIGByPass: bool = false,
            LSEOscillator: bool = false,
            MCO1Config: bool = false,
            DT_MCO1: bool = false,
            MCO2Config: bool = false,
            DT_MCO2: bool = false,
            AudioClockConfig: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            GPUUsed_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            FMCUsed_ForRCC: bool = false,
            SDMMC1Used_ForRCC: bool = false,
            SDMMC2Used_ForRCC: bool = false,
            SDMMC3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI3_SAIAUsed_ForRCC: bool = false,
            SAI3_SAIBUsed_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            FDCAN2Used_ForRCC: bool = false,
            SAI4_SAIAUsed_ForRCC: bool = false,
            SAI4_SAIBUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C5Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            RNG1Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            I2S4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            DCMIPP_Used: bool = false,
            ETH1_Used: bool = false,
            ETH2_Used: bool = false,
            SAES_Used: bool = false,
            USBH_HS1_Used: bool = false,
            USBH_HS2_Used: bool = false,
            RTC_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            HSICalibrationValue: ?u32 = null,
            CSICalibrationValue: ?u32 = null,
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null,
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null,
            RCC_TIM_G3_PRescaler_Selection: ?RCC_TIM_G3_PRescaler_SelectionList = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
            PLL1UserDefinedConfig: ?PLL1UserDefinedConfigList = null,
        };
        pub const Config = struct {
            HSIDivValue: ?HSIDivValueList = null,
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            MLAHBCLKSource: ?MLAHBCLKSourceList = null,
            MPUCLKSource: ?MPUCLKSourceList = null,
            CKPERCLKSource: ?CKPERCLKSourceList = null,
            AXICLKSource: ?AXICLKSourceList = null,
            AXI_Div: ?AXI_DivList = null,
            APB4DIV: ?APB4DIVList = null,
            APB5DIV: ?APB5DIVList = null,
            APB6DIV: ?APB6DIVList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            MLAHB_Div: ?MLAHB_DivList = null,
            APB3DIV: ?APB3DIVList = null,
            APB1DIV: ?APB1DIVList = null,
            APB2DIV: ?APB2DIVList = null,
            PLL12Source: ?PLL12SourceList = null,
            DIVM1: ?u32 = null,
            DIVM2: ?u32 = null,
            PLL3Source: ?PLL3SourceList = null,
            DIVM3: ?u32 = null,
            PLL4Source: ?PLL4SourceList = null,
            DIVM4: ?u32 = null,
            MPU_Div: ?MPU_DivList = null,
            DIVN1: ?u32 = null,
            PLL1FRACV: ?u32 = null,
            DIVP1: ?u32 = null,
            DIVQ1: ?u32 = null,
            DIVR1: ?u32 = null,
            DIVN2: ?u32 = null,
            PLL2FRACV: ?u32 = null,
            DIVP2: ?u32 = null,
            DIVQ2: ?u32 = null,
            DIVR2: ?u32 = null,
            DIVN3: ?u32 = null,
            PLL3FRACV: ?u32 = null,
            DIVP3: ?u32 = null,
            DIVQ3: ?u32 = null,
            DIVR3: ?u32 = null,
            DIVN4: ?u32 = null,
            PLL4FRACV: ?u32 = null,
            DIVP4: ?u32 = null,
            DIVQ4: ?u32 = null,
            DIVR4: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            I2C12CLockSelection: ?I2C12CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            I2C5CLockSelection: ?I2C5CLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            QSPICLockSelection: ?QSPICLockSelectionList = null,
            FMCCLockSelection: ?FMCCLockSelectionList = null,
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null,
            SDMMC2CLockSelection: ?SDMMC2CLockSelectionList = null,
            STGENCLockSelection: ?STGENCLockSelectionList = null,
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART35CLockSelection: ?USART35CLockSelectionList = null,
            USART6CLockSelection: ?USART6CLockSelectionList = null,
            UART78CLockSelection: ?UART78CLockSelectionList = null,
            RNG1CLockSelection: ?RNG1CLockSelectionList = null,
            DCMICLockSelection: ?DCMICLockSelectionList = null,
            SAESCLockSelection: ?SAESCLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            SPI4CLockSelection: ?SPI4CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            USART4CLockSelection: ?USART4CLockSelectionList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI23CLockSelection: ?SPI23CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SPI5CLockSelection: ?SPI5CLockSelectionList = null,
            FDCANCLockSelection: ?FDCANCLockSelectionList = null,
            ETH1CLockSelection: ?ETH1CLockSelectionList = null,
            ETH2CLockSelection: ?ETH2CLockSelectionList = null,
            ADC2CLockSelection: ?ADC2CLockSelectionList = null,
            ADC1CLockSelection: ?ADC1CLockSelectionList = null,
            USBPHYCLKSource: ?USBPHYCLKSourceList = null,
            USBOCLKSource: ?USBOCLKSourceList = null,
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
            I2S_CKIN: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            MPUMult: f32 = 0,
            MPUCLKOutput: f32 = 0,
            CKPERMult: f32 = 0,
            CKPERCLKOutput: f32 = 0,
            AXIMult: f32 = 0,
            AXICLKOutput: f32 = 0,
            DACCLKOutput: f32 = 0,
            AXIDIV: f32 = 0,
            AXIOutput: f32 = 0,
            Hclk5Output: f32 = 0,
            Hclk6Output: f32 = 0,
            APB4DIV: f32 = 0,
            APB4DIVOutput: f32 = 0,
            APB5DIV: f32 = 0,
            APB5DIVOutput: f32 = 0,
            APB6DIV: f32 = 0,
            Tim3Mul: f32 = 0,
            Tim3Output: f32 = 0,
            APB6DIVOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            MLAHBDIV: f32 = 0,
            MLAHBClockOutput: f32 = 0,
            APB3DIV: f32 = 0,
            APB3Output: f32 = 0,
            APB1DIV: f32 = 0,
            Tim1Mul: f32 = 0,
            Tim1Output: f32 = 0,
            AHBOutput: f32 = 0,
            APB1Output: f32 = 0,
            APB2DIV: f32 = 0,
            Tim2Mul: f32 = 0,
            Tim2Output: f32 = 0,
            APB2Output: f32 = 0,
            DFSDM1Output: f32 = 0,
            PLL12Source: f32 = 0,
            DIVM1: f32 = 0,
            DIVM2: f32 = 0,
            PLL3Source: f32 = 0,
            DIVM3: f32 = 0,
            PLL4Source: f32 = 0,
            DIVM4: f32 = 0,
            MPUDIV: f32 = 0,
            FreqCk1: f32 = 0,
            DIVN1: f32 = 0,
            PLL1FRACV: f32 = 0,
            DIVN1Mul2Div2: f32 = 0,
            DIVP1: f32 = 0,
            DIVQ1: f32 = 0,
            DIVQ1output: f32 = 0,
            DIVR1: f32 = 0,
            DIVR1output: f32 = 0,
            FreqCk2: f32 = 0,
            DIVN2: f32 = 0,
            PLL2FRACV: f32 = 0,
            DIVN2Mul2Div2: f32 = 0,
            DIVP2: f32 = 0,
            DIVQ2: f32 = 0,
            DIVQ2output: f32 = 0,
            DIVR2: f32 = 0,
            DIVR2output: f32 = 0,
            DIVN3: f32 = 0,
            PLL3FRACV: f32 = 0,
            DIVP3: f32 = 0,
            DIVQ3: f32 = 0,
            DIVQ3output: f32 = 0,
            DIVR3: f32 = 0,
            LTDCOutput: f32 = 0,
            DIVR3output: f32 = 0,
            DIVN4: f32 = 0,
            PLL4FRACV: f32 = 0,
            DIVP4: f32 = 0,
            DIVP4output: f32 = 0,
            DIVQ4: f32 = 0,
            DIVQ4output: f32 = 0,
            DIVR4: f32 = 0,
            DIVR4output: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            I2C12Mult: f32 = 0,
            I2C12output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            I2C4Mult: f32 = 0,
            I2C4output: f32 = 0,
            I2C5Mult: f32 = 0,
            I2C5output: f32 = 0,
            SPDIFMult: f32 = 0,
            SPDIFoutput: f32 = 0,
            QSPIMult: f32 = 0,
            QSPIoutput: f32 = 0,
            FMCMult: f32 = 0,
            FMCoutput: f32 = 0,
            SDMMC1Mult: f32 = 0,
            SDMMC1output: f32 = 0,
            SDMMC2Mult: f32 = 0,
            SDMMC2output: f32 = 0,
            STGENMult: f32 = 0,
            STGENoutput: f32 = 0,
            LPTIM45Mult: f32 = 0,
            LPTIM45output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2output: f32 = 0,
            USART35Mult: f32 = 0,
            USART35output: f32 = 0,
            USART6Mult: f32 = 0,
            USART6output: f32 = 0,
            UART78Mult: f32 = 0,
            USART78output: f32 = 0,
            RNG1Mult: f32 = 0,
            RNG1output: f32 = 0,
            DCMIMult: f32 = 0,
            DCMIoutput: f32 = 0,
            SAESMult: f32 = 0,
            SAESoutput: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            SPI4Mult: f32 = 0,
            SPI4output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
            USART4Mult: f32 = 0,
            USART4output: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI23Mult: f32 = 0,
            SPI23output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            DFSDF1Audiooutput: f32 = 0,
            SPI5Mult: f32 = 0,
            SPI5output: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            ETH1Mult: f32 = 0,
            ETH1output: f32 = 0,
            ETH2Mult: f32 = 0,
            ETH2output: f32 = 0,
            ADC2Mult: f32 = 0,
            ADC2output: f32 = 0,
            ADC1Mult: f32 = 0,
            ADC1output: f32 = 0,
            DDRPHYC: f32 = 0,
            PUBL: f32 = 0,
            DDRC: f32 = 0,
            DDRPERFM: f32 = 0,
            HSEUSBPHYDevisor: f32 = 0,
            USBPHYCLKMux: f32 = 0,
            USBPHYCLKOutput: f32 = 0,
            USBPHYRC: f32 = 0,
            USBOCLKMux: f32 = 0,
            USBOFSCLKOutput: f32 = 0,
            HSIDivClk: f32 = 0,
            VCOInput: f32 = 0,
            VCO2Input: f32 = 0,
            VCO3Input: f32 = 0,
            VCO4Input: f32 = 0,
            VCO1Output: f32 = 0,
            PLL1CLK: f32 = 0,
            VCO2Output: f32 = 0,
            PLL2CLK: f32 = 0,
            VCO3Output: f32 = 0,
            VCO4Output: f32 = 0,
            PLL3CLK: f32 = 0,
            MLAHBDIVCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSIDivValue: ?HSIDivValueList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            MLAHBCLKSource: ?MLAHBCLKSourceList = null, //from RCC Clock Config
            MPUCLKSource: ?MPUCLKSourceList = null, //from RCC Clock Config
            CKPERCLKSource: ?CKPERCLKSourceList = null, //from RCC Clock Config
            AXICLKSource: ?AXICLKSourceList = null, //from RCC Clock Config
            AXI_Div: ?AXI_DivList = null, //from RCC Clock Config
            APB4DIV: ?APB4DIVList = null, //from RCC Clock Config
            APB5DIV: ?APB5DIVList = null, //from RCC Clock Config
            APB6DIV: ?APB6DIVList = null, //from RCC Clock Config
            Tim3Mul: ?f32 = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            MLAHB_Div: ?MLAHB_DivList = null, //from RCC Clock Config
            APB3DIV: ?APB3DIVList = null, //from RCC Clock Config
            APB1DIV: ?APB1DIVList = null, //from RCC Clock Config
            Tim1Mul: ?f32 = null, //from RCC Clock Config
            APB2DIV: ?APB2DIVList = null, //from RCC Clock Config
            Tim2Mul: ?f32 = null, //from RCC Clock Config
            PLL12Source: ?PLL12SourceList = null, //from RCC Clock Config
            DIVM1: ?f32 = null, //from RCC Clock Config
            DIVM2: ?f32 = null, //from RCC Clock Config
            PLL3Source: ?PLL3SourceList = null, //from RCC Clock Config
            DIVM3: ?f32 = null, //from RCC Clock Config
            PLL4Source: ?PLL4SourceList = null, //from RCC Clock Config
            DIVM4: ?f32 = null, //from RCC Clock Config
            MPU_Div: ?MPU_DivList = null, //from RCC Clock Config
            FreqCk1: ?f32 = null, //from RCC Clock Config
            DIVN1: ?f32 = null, //from RCC Clock Config
            PLL1FRACV: ?f32 = null, //from RCC Clock Config
            VCO1DIV2: ?f32 = null, //from RCC Clock Config
            DIVP1: ?f32 = null, //from RCC Clock Config
            DIVQ1: ?f32 = null, //from RCC Clock Config
            DIVR1: ?f32 = null, //from RCC Clock Config
            FreqCk2: ?f32 = null, //from RCC Clock Config
            DIVN2: ?f32 = null, //from RCC Clock Config
            PLL2FRACV: ?f32 = null, //from RCC Clock Config
            VCO2DIV2: ?f32 = null, //from RCC Clock Config
            DIVP2: ?f32 = null, //from RCC Clock Config
            DIVQ2: ?f32 = null, //from RCC Clock Config
            DIVR2: ?f32 = null, //from RCC Clock Config
            DIVN3: ?f32 = null, //from RCC Clock Config
            PLL3FRACV: ?f32 = null, //from RCC Clock Config
            DIVP3: ?f32 = null, //from RCC Clock Config
            DIVQ3: ?f32 = null, //from RCC Clock Config
            DIVR3: ?f32 = null, //from RCC Clock Config
            DIVN4: ?f32 = null, //from RCC Clock Config
            PLL4FRACV: ?f32 = null, //from RCC Clock Config
            DIVP4: ?f32 = null, //from RCC Clock Config
            DIVQ4: ?f32 = null, //from RCC Clock Config
            DIVR4: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            I2C12CLockSelection: ?I2C12CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            I2C5CLockSelection: ?I2C5CLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            QSPICLockSelection: ?QSPICLockSelectionList = null, //from RCC Clock Config
            FMCCLockSelection: ?FMCCLockSelectionList = null, //from RCC Clock Config
            SDMMC1CLockSelection: ?SDMMC1CLockSelectionList = null, //from RCC Clock Config
            SDMMC2CLockSelection: ?SDMMC2CLockSelectionList = null, //from RCC Clock Config
            STGENCLockSelection: ?STGENCLockSelectionList = null, //from RCC Clock Config
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from RCC Clock Config
            USART35CLockSelection: ?USART35CLockSelectionList = null, //from RCC Clock Config
            USART6CLockSelection: ?USART6CLockSelectionList = null, //from RCC Clock Config
            UART78CLockSelection: ?UART78CLockSelectionList = null, //from RCC Clock Config
            RNG1CLockSelection: ?RNG1CLockSelectionList = null, //from RCC Clock Config
            DCMICLockSelection: ?DCMICLockSelectionList = null, //from RCC Clock Config
            SAESCLockSelection: ?SAESCLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from RCC Clock Config
            SPI4CLockSelection: ?SPI4CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            USART4CLockSelection: ?USART4CLockSelectionList = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI23CLockSelection: ?SPI23CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SPI5CLockSelection: ?SPI5CLockSelectionList = null, //from RCC Clock Config
            FDCANCLockSelection: ?FDCANCLockSelectionList = null, //from RCC Clock Config
            ETH1CLockSelection: ?ETH1CLockSelectionList = null, //from RCC Clock Config
            ETH2CLockSelection: ?ETH2CLockSelectionList = null, //from RCC Clock Config
            ADC2CLockSelection: ?ADC2CLockSelectionList = null, //from RCC Clock Config
            ADC1CLockSelection: ?ADC1CLockSelectionList = null, //from RCC Clock Config
            RCC_USBPHY_Clock_Source_FROM_HSE: ?RCC_USBPHY_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            USBPHYCLKSource: ?USBPHYCLKSourceList = null, //from RCC Clock Config
            USBOCLKSource: ?USBOCLKSourceList = null, //from RCC Clock Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            CSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null, //from RCC Advanced Config
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null, //from RCC Advanced Config
            RCC_TIM_G3_PRescaler_Selection: ?RCC_TIM_G3_PRescaler_SelectionList = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            PLL1UserDefinedConfig: ?PLL1UserDefinedConfigList = null, //from RCC Advanced Config
            PLL1Used: ?f32 = null, //from extra RCC references
            PLL2Used: ?f32 = null, //from extra RCC references
            PLL3Used: ?f32 = null, //from extra RCC references
            PLL4Used: ?f32 = null, //from extra RCC references
            PLL1MODE: ?PLL1MODEList = null, //from extra RCC references
            PLL2MODE: ?PLL2MODEList = null, //from extra RCC references
            PLL3MODE: ?PLL3MODEList = null, //from extra RCC references
            PLL4MODE: ?PLL4MODEList = null, //from extra RCC references
            PLL1CSG: ?PLL1CSGList = null, //from extra RCC references
            PLL2CSG: ?PLL2CSGList = null, //from extra RCC references
            PLL3CSG: ?PLL3CSGList = null, //from extra RCC references
            PLL4CSG: ?PLL4CSGList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            PLL1UserDefinedConfigEnable: ?PLL1UserDefinedConfigEnableList = null, //from extra RCC references
            cKPerEnable: ?cKPerEnableList = null, //from extra RCC references
            DACEnable: ?DACEnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            DFSDMEnable: ?DFSDMEnableList = null, //from extra RCC references
            DCMIEnable: ?DCMIEnableList = null, //from extra RCC references
            DDREnable: ?DDREnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            ADC2Enable: ?ADC2EnableList = null, //from extra RCC references
            ADC1Enable: ?ADC1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            ETH1Enable: ?ETH1EnableList = null, //from extra RCC references
            ETH2Enable: ?ETH2EnableList = null, //from extra RCC references
            EnableDFSDMAudio: ?EnableDFSDMAudioList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            SPDIFEnable: ?SPDIFEnableList = null, //from extra RCC references
            SAI2Enable: ?SAI2EnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            LPTIM45Enable: ?LPTIM45EnableList = null, //from extra RCC references
            SPI1Enable: ?SPI1EnableList = null, //from extra RCC references
            SPI23Enable: ?SPI23EnableList = null, //from extra RCC references
            SPI4Enable: ?SPI4EnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            SDMMC1Enable: ?SDMMC1EnableList = null, //from extra RCC references
            SDMMC2Enable: ?SDMMC2EnableList = null, //from extra RCC references
            QuadSPIEnable: ?QuadSPIEnableList = null, //from extra RCC references
            FMCEnable: ?FMCEnableList = null, //from extra RCC references
            LTDCEnable: ?LTDCEnableList = null, //from extra RCC references
            USART4Enable: ?USART4EnableList = null, //from extra RCC references
            SPI5Enable: ?SPI5EnableList = null, //from extra RCC references
            UART78Enable: ?UART78EnableList = null, //from extra RCC references
            USART35Enable: ?USART35EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            LPTIM3Enable: ?LPTIM3EnableList = null, //from extra RCC references
            USART6Enable: ?USART6EnableList = null, //from extra RCC references
            SAESEnable: ?SAESEnableList = null, //from extra RCC references
            I2C4Enable: ?I2C4EnableList = null, //from extra RCC references
            I2C5Enable: ?I2C5EnableList = null, //from extra RCC references
            EnableUSBOHS: ?EnableUSBOHSList = null, //from extra RCC references
            EnableUSBHS: ?EnableUSBHSList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            I2C12Enable: ?I2C12EnableList = null, //from extra RCC references
            RNG1Enable: ?RNG1EnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            STGENEnable: ?STGENEnableList = null, //from extra RCC references
            EnableHSEUSBPHYDevisor: ?EnableHSEUSBPHYDevisorList = null, //from extra RCC references
            Max650: ?Max650List = null, //from extra RCC references
            PLL2RUsed: ?f32 = null, //from extra RCC references
            PLL3QUsed: ?f32 = null, //from extra RCC references
            PLL3RUsed: ?f32 = null, //from extra RCC references
            PLL4PUsed: ?f32 = null, //from extra RCC references
            PLL4QUsed: ?f32 = null, //from extra RCC references
            PLL4RUsed: ?f32 = null, //from extra RCC references
            PLL2PUsed: ?f32 = null, //from extra RCC references
            PLL3PUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            PLL1UsedTFA: ?f32 = null, //from extra RCC references
            PLL1UsedA7: ?f32 = null, //from extra RCC references
            PLL2UsedTFA: ?f32 = null, //from extra RCC references
            PLL2UsedA7: ?f32 = null, //from extra RCC references
            PLL3UsedTFA: ?f32 = null, //from extra RCC references
            PLL3UsedA7: ?f32 = null, //from extra RCC references
            PLL4UsedTFA: ?f32 = null, //from extra RCC references
            PLL4UsedA7: ?f32 = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
            MCO2I2SEnable: ?MCO2I2SEnableList = null, //from extra RCC references
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

            var MLAHBS_HSI: bool = false;
            var MLAHBS_CSI: bool = false;
            var MLAHBS_HSE: bool = false;
            var MLAHBS_PLL3: bool = false;
            var MPUSOURCE_PLL1: bool = false;
            var MPUSOURCE_MPUDIV: bool = false;
            var MPUSOURCE_HSE: bool = false;
            var MPUSOURCE_HSI: bool = false;
            var CKPERCLKSOURCE_HSI: bool = false;
            var CKPERCLKSOURCE_CSI: bool = false;
            var CKPERCLKSOURCE_HSE: bool = false;
            var AXISSOURCE_HSE: bool = false;
            var AXISSOURCE_HSI: bool = false;
            var AXISSOURCE_PLL2: bool = false;
            var MCO1SOURCE_HSI: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var MCO1SOURCE_CSI: bool = false;
            var MCO1SOURCE_LSI: bool = false;
            var MCO1SOURCE_LSE: bool = false;
            var MCO2SOURCE_PLL4: bool = false;
            var MCO2SOURCE_HSE: bool = false;
            var MCO2SOURCE_HSI: bool = false;
            var PLL12SOURCE_HSI: bool = false;
            var PLL12SOURCE_HSE: bool = false;
            var PLL3SOURCE_HSI: bool = false;
            var PLL3SOURCE_CSI: bool = false;
            var PLL3SOURCE_HSE: bool = false;
            var PLL4SOURCE_HSI: bool = false;
            var PLL4SOURCE_CSI: bool = false;
            var PLL4SOURCE_HSE: bool = false;
            var PLL4SOURCE_I2S_CKIN: bool = false;
            var RTCCLKSOURCE_HSE_DIV: bool = false;
            var RTCCLKSOURCE_LSE: bool = false;
            var RTCCLKSOURCE_LSI: bool = false;
            var I2C12CLKSOURCE_BCLK: bool = false;
            var I2C12CLKSOURCE_PLL4: bool = false;
            var I2C12CLKSOURCE_HSI: bool = false;
            var I2C12CLKSOURCE_CSI: bool = false;
            var I2C3CLKSOURCE_PCLK6: bool = false;
            var I2C3CLKSOURCE_PLL4: bool = false;
            var I2C3CLKSOURCE_HSI: bool = false;
            var I2C3CLKSOURCE_CSI: bool = false;
            var I2C4CLKSOURCE_BCLK: bool = false;
            var I2C4CLKSOURCE_PLL4R: bool = false;
            var I2C4CLKSOURCE_HSI: bool = false;
            var I2C4CLKSOURCE_CSI: bool = false;
            var I2C5CLKSOURCE_PCLK6: bool = false;
            var I2C5CLKSOURCE_PLL4: bool = false;
            var I2C5CLKSOURCE_HSI: bool = false;
            var I2C5CLKSOURCE_CSI: bool = false;
            var SPDIFRXCLKSOURCE_PLL4: bool = false;
            var SPDIFRXCLKSOURCE_PLL3: bool = false;
            var SPDIFRXCLKSOURCE_HSI: bool = false;
            var QSPICLKSOURCE_BCLK: bool = false;
            var QSPICLKSOURCE_PLL4: bool = false;
            var QSPICLKSOURCE_PLL3: bool = false;
            var QSPICLKSOURCE_PER: bool = false;
            var FMCCLKSOURCE_BCLK: bool = false;
            var FMCCLKSOURCE_PLL3: bool = false;
            var FMCCLKSOURCE_PLL4: bool = false;
            var FMCCLKSOURCE_PER: bool = false;
            var SDMMC1CLKSOURCE_PLL3: bool = false;
            var SDMMC1CLKSOURCE_PLL4: bool = false;
            var SDMMC1CLKSOURCE_HSI: bool = false;
            var SDMMC2CLKSOURCE_PLL3: bool = false;
            var SDMMC2CLKSOURCE_PLL4: bool = false;
            var SDMMC2CLKSOURCE_HSI: bool = false;
            var STGENCLKSOURCE_HSI: bool = false;
            var STGENCLKSOURCE_HSE: bool = false;
            var LPTIM45CLKSOURCE_BCLK: bool = false;
            var LPTIM45CLKSOURCE_PLL4: bool = false;
            var LPTIM45CLKSOURCE_PLL3: bool = false;
            var LPTIM45CLKSOURCE_LSE: bool = false;
            var LPTIM45CLKSOURCE_LSI: bool = false;
            var LPTIM45CLKSOURCE_PER: bool = false;
            var LPTIM2CLKSOURCE_BCLK: bool = false;
            var LPTIM2CLKSOURCE_PLL4: bool = false;
            var LPTIM2CLKSOURCE_PER: bool = false;
            var LPTIM2CLKSOURCE_LSE: bool = false;
            var LPTIM2CLKSOURCE_LSI: bool = false;
            var LPTIM1CLKSOURCE_BCLK: bool = false;
            var LPTIM1CLKSOURCE_PLL4: bool = false;
            var LPTIM1CLKSOURCE_PLL3: bool = false;
            var LPTIM1CLKSOURCE_LSE: bool = false;
            var LPTIM1CLKSOURCE_LSI: bool = false;
            var LPTIM1CLKSOURCE_PER: bool = false;
            var USART1CLKSOURCE_BCLK: bool = false;
            var USART1CLKSOURCE_PLL4: bool = false;
            var USART1CLKSOURCE_PLL3: bool = false;
            var USART1CLKSOURCE_HSE: bool = false;
            var USART1CLKSOURCE_CSI: bool = false;
            var USART1CLKSOURCE_HSI: bool = false;
            var UART2_PLL4: bool = false;
            var UART2_HSE: bool = false;
            var UART2_CSI: bool = false;
            var UART2_HSI: bool = false;
            var UART2_PLL3Q: bool = false;
            var UART35CLKSOURCE_BCLK: bool = false;
            var UART35CLKSOURCE_PLL4: bool = false;
            var UART35CLKSOURCE_HSE: bool = false;
            var UART35CLKSOURCE_CSI: bool = false;
            var UART35CLKSOURCE_HSI: bool = false;
            var USART6CLKSOURCE_BCLK: bool = false;
            var USART6CLKSOURCE_PLL4: bool = false;
            var USART6CLKSOURCE_HSE: bool = false;
            var USART6CLKSOURCE_CSI: bool = false;
            var USART6CLKSOURCE_HSI: bool = false;
            var UART78CLKSOURCE_BCLK: bool = false;
            var UART78CLKSOURCE_PLL4: bool = false;
            var UART78CLKSOURCE_HSE: bool = false;
            var UART78CLKSOURCE_CSI: bool = false;
            var UART78CLKSOURCE_HSI: bool = false;
            var RNG1CLKSOURCE_CSI: bool = false;
            var RNG1CLKSOURCE_PLL4: bool = false;
            var RNG1CLKSOURCE_LSI: bool = false;
            var DCMICLKSOURCE_PLL2Q: bool = false;
            var DCMICLKSOURCE_PLL4P: bool = false;
            var DCMICLKSOURCE_CKPER: bool = false;
            var SAES_CKPER: bool = false;
            var SAES_PLL4R: bool = false;
            var SAES_LSI: bool = false;
            var LPTIM3CLKSOURCE_BCLK: bool = false;
            var LPTIM3CLKSOURCE_PLL4: bool = false;
            var LPTIM3CLKSOURCE_PER: bool = false;
            var LPTIM3CLKSOURCE_LSE: bool = false;
            var LPTIM3CLKSOURCE_LSI: bool = false;
            var SPI4CLKSOURCE_PLL4: bool = false;
            var SPI4CLKSOURCE_HSI: bool = false;
            var SPI4CLKSOURCE_CSI: bool = false;
            var SPI4CLKSOURCE_HSE: bool = false;
            var SPI4_I2SCKIN: bool = false;
            var SAI2CLKSOURCE_PLL4: bool = false;
            var SAI2CLKSOURCE_PLL3: bool = false;
            var SAI2CLKSOURCE_I2SCKIN: bool = false;
            var SAI2CLKSOURCE_PER: bool = false;
            var SAI2CLKSOURCE_SPDIF: bool = false;
            var SAI2CLKSOURCE_PLL3_R: bool = false;
            var UART4_PCLK1: bool = false;
            var UART4_PLL4: bool = false;
            var UART4_HSE: bool = false;
            var UART4_CSI: bool = false;
            var UART4_HSI: bool = false;
            var SPI1CLKSOURCE_PLL4: bool = false;
            var SPI1CLKSOURCE_PLL3: bool = false;
            var SPI1CLKSOURCE_I2SCKIN: bool = false;
            var SPI1CLKSOURCE_PER: bool = false;
            var SPI1CLKSOURCE_PLL3_R: bool = false;
            var SPI23CLKSOURCE_PLL4: bool = false;
            var SPI23CLKSOURCE_PLL3: bool = false;
            var SPI23CLKSOURCE_I2SCKIN: bool = false;
            var SPI23CLKSOURCE_PER: bool = false;
            var SPI23CLKSOURCE_PLL3_R: bool = false;
            var SAI1CLKSOURCE_PLL4: bool = false;
            var SAI1CLKSOURCE_PLL3: bool = false;
            var SAI1CLKSOURCE_I2SCKIN: bool = false;
            var SAI1CLKSOURCE_PER: bool = false;
            var SAI1CLKSOURCE_PLL3_R: bool = false;
            var SPI5CLKSOURCE_PLL4: bool = false;
            var SPI5CLKSOURCE_HSI: bool = false;
            var SPI5CLKSOURCE_CSI: bool = false;
            var SPI5CLKSOURCE_HSE: bool = false;
            var FDCANCLKSOURCE_HSE: bool = false;
            var FDCANCLKSOURCE_PLL3: bool = false;
            var FDCANCLKSOURCE_PLL4: bool = false;
            var FDCANCLKSOURCE_PLL4_R: bool = false;
            var ETHCLKSOURCE_PLL4: bool = false;
            var ETHCLKSOURCE_PLL3: bool = false;
            var ETH2CLKSOURCE_PLL4: bool = false;
            var ETH2CLKSOURCE_PLL3: bool = false;
            var ADC2CLKSOURCE_PLL4: bool = false;
            var ADC2CLKSOURCE_PER: bool = false;
            var ADC2CLKSOURCE_PLL3: bool = false;
            var ADC1CLKSOURCE_PLL4: bool = false;
            var ADC1CLKSOURCE_PER: bool = false;
            var ADC1CLKSOURCE_PLL3: bool = false;
            var USBPHYCLKSOURCE_HSE2: bool = false;
            var USBPHYCLKSOURCE_HSE: bool = false;
            var USBPHYCLKSOURCE_PLL4: bool = false;
            var USBOCLKSOURCE_PLL4: bool = false;
            var USBOCLKSOURCE_PHY: bool = false;
            var APB6DIV_1: bool = false;
            var APB6DIV_2: bool = false;
            var APB6DIV_4: bool = false;
            var APB1DIV_1: bool = false;
            var APB1DIV_2: bool = false;
            var APB1DIV_4: bool = false;
            var APB2DIV_1: bool = false;
            var APB2DIV_2: bool = false;
            var APB2DIV_4: bool = false;
            var TimG1PrescalerEnabled: bool = false;
            var TimG2PrescalerEnabled: bool = false;
            var TimG3PrescalerEnabled: bool = false;
            var MLAHBCLKFreq_VALUELimit: Limit = .{};
            var MPUCLKFreq_VALUELimit: Limit = .{};
            var AXICLKFreq_VALUELimit: Limit = .{};
            var AXIDIVFreq_ValueLimit: Limit = .{};
            var Hclk5DIVFreq_ValueLimit: Limit = .{};
            var Hclk6DIVFreq_ValueLimit: Limit = .{};
            var APB4Freq_ValueLimit: Limit = .{};
            var APB5DIVClockFreq_ValueLimit: Limit = .{};
            var Tim3OutputFreq_ValueLimit: Limit = .{};
            var APB6Freq_ValueLimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var APB3Freq_ValueLimit: Limit = .{};
            var Tim1OutputFreq_ValueLimit: Limit = .{};
            var AHB124Freq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var Tim2OutputFreq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var DFSDMFreq_ValueLimit: Limit = .{};
            var DIVQ2Freq_ValueLimit: Limit = .{};
            var DIVR2Freq_ValueLimit: Limit = .{};
            var DIVQ3Freq_ValueLimit: Limit = .{};
            var LTDCFreq_ValueLimit: Limit = .{};
            var DIVR3Freq_ValueLimit: Limit = .{};
            var DIVP4Freq_ValueLimit: Limit = .{};
            var DIVQ4Freq_ValueLimit: Limit = .{};
            var DIVR4Freq_ValueLimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var I2C12Freq_ValueLimit: Limit = .{};
            var I2C3Freq_ValueLimit: Limit = .{};
            var I2C4Freq_ValueLimit: Limit = .{};
            var I2C5Freq_ValueLimit: Limit = .{};
            var SPDIFRXFreq_ValueLimit: Limit = .{};
            var QSPIFreq_ValueLimit: Limit = .{};
            var FMCFreq_ValueLimit: Limit = .{};
            var SDMMC1Freq_ValueLimit: Limit = .{};
            var SDMMC2Freq_ValueLimit: Limit = .{};
            var STGENFreq_ValueLimit: Limit = .{};
            var LPTIM45Freq_ValueLimit: Limit = .{};
            var LPTIM2Freq_ValueLimit: Limit = .{};
            var LPTIM1Freq_ValueLimit: Limit = .{};
            var USART1Freq_ValueLimit: Limit = .{};
            var USART2Freq_ValueLimit: Limit = .{};
            var USART35Freq_ValueLimit: Limit = .{};
            var USART6Freq_ValueLimit: Limit = .{};
            var UART78Freq_ValueLimit: Limit = .{};
            var RNG1Freq_ValueLimit: Limit = .{};
            var DCMIFreq_ValueLimit: Limit = .{};
            var SAESFreq_ValueLimit: Limit = .{};
            var LPTIM3Freq_ValueLimit: Limit = .{};
            var SPI4Freq_ValueLimit: Limit = .{};
            var SAI2Freq_ValueLimit: Limit = .{};
            var USART4Freq_ValueLimit: Limit = .{};
            var SPI1Freq_ValueLimit: Limit = .{};
            var SPI23Freq_ValueLimit: Limit = .{};
            var SAI1Freq_ValueLimit: Limit = .{};
            var DFSDFAFreq_ValueLimit: Limit = .{};
            var SPI5Freq_ValueLimit: Limit = .{};
            var FDCANFreq_ValueLimit: Limit = .{};
            var ETHFreq_ValueLimit: Limit = .{};
            var ETH2Freq_ValueLimit: Limit = .{};
            var ADC2Freq_ValueLimit: Limit = .{};
            var ADC1Freq_ValueLimit: Limit = .{};
            var DDRCFreq_ValueLimit: Limit = .{};
            var DDRPERFMFreq_ValueLimit: Limit = .{};
            var VCOInput1Freq_ValueLimit: Limit = .{};
            var VCOInput2Freq_ValueLimit: Limit = .{};
            var VCOInput3Freq_ValueLimit: Limit = .{};
            var VCOInput4Freq_ValueLimit: Limit = .{};
            var VCO1OutputFreq_ValueLimit: Limit = .{};
            var DIVP1Freq_ValueLimit: Limit = .{};
            var VCO2OutputFreq_ValueLimit: Limit = .{};
            var DIVP2Freq_ValueLimit: Limit = .{};
            var VCO3OutputFreq_ValueLimit: Limit = .{};
            var VCO4OutputFreq_ValueLimit: Limit = .{};
            var DIVP3Freq_ValueLimit: Limit = .{};
            var MLAHBDIVCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 6.4e7;
            };
            const HSIDivValueValue: ?HSIDivValueList = blk: {
                const conf_item = config.HSIDivValue;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSI_DIV1 => {},
                        .RCC_HSI_DIV2 => {},
                        .RCC_HSI_DIV4 => {},
                        .RCC_HSI_DIV8 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass or config.flags.HSEOscillator or config.flags.HSEDIGByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 8e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass  | HSEOscillator|HSEDIGByPass",
                                "HSE in bypass Mode",
                                8e6,
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
                                "HSEByPass  | HSEOscillator|HSEDIGByPass",
                                "HSE in bypass Mode",
                                4.8e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 24000000;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 8e6) {
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
                            8e6,
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
                break :blk config_val orelse 24000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
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
                break :blk config_val orelse 32768;
            };
            const CSI_VALUEValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const MLAHBCLKSourceValue: ?MLAHBCLKSourceList = blk: {
                const conf_item = config.MLAHBCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MLAHBSSOURCE_HSI => MLAHBS_HSI = true,
                        .RCC_MLAHBSSOURCE_CSI => MLAHBS_CSI = true,
                        .RCC_MLAHBSSOURCE_HSE => MLAHBS_HSE = true,
                        .RCC_MLAHBSSOURCE_PLL3 => MLAHBS_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    MLAHBS_HSI = true;
                    break :blk .RCC_MLAHBSSOURCE_HSI;
                };
            };
            const MLAHBCLKFreq_VALUEValue: ?f32 = blk: {
                MLAHBCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const MPUCLKSourceValue: ?MPUCLKSourceList = blk: {
                const conf_item = config.MPUCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MPUSOURCE_PLL1 => MPUSOURCE_PLL1 = true,
                        .RCC_MPUSOURCE_MPUDIV => MPUSOURCE_MPUDIV = true,
                        .RCC_MPUSOURCE_HSE => MPUSOURCE_HSE = true,
                        .RCC_MPUSOURCE_HSI => MPUSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    MPUSOURCE_HSI = true;
                    break :blk .RCC_MPUSOURCE_HSI;
                };
            };
            const Max650Value: ?Max650List = blk: {
                if (check_MCU("STM32MP133DAFx") or check_MCU("STM32MP133DAEx") or check_MCU("STM32MP131DAGx") or check_MCU("STM32MP131DAFx") or check_MCU("STM32MP131FAEx") or check_MCU("STM32MP131FAFx") or check_MCU("STM32MP131FAGx") or check_MCU("STM32MP133FAEx") or check_MCU("STM32MP133FAFx") or check_MCU("STM32MP133FAGx") or check_MCU("STM32MP135DAGx") or check_MCU("STM32MP135DAFx") or check_MCU("STM32MP135DAEx") or check_MCU("STM32MP133DAGx") or check_MCU("STM32MP131DAEx")) {
                    const item: Max650List = .false;
                    break :blk item;
                }
                const item: Max650List = .true;
                break :blk item;
            };
            const MPUCLKFreq_VALUEValue: ?f32 = blk: {
                if (check_ref(@TypeOf(Max650Value), Max650Value, .false, .@"=")) {
                    MPUCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 1e9,
                    };
                    break :blk null;
                }
                MPUCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.5e8,
                };
                break :blk null;
            };
            const CKPERCLKSourceValue: ?CKPERCLKSourceList = blk: {
                const conf_item = config.CKPERCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CKPERCLKSOURCE_HSI => CKPERCLKSOURCE_HSI = true,
                        .RCC_CKPERCLKSOURCE_CSI => CKPERCLKSOURCE_CSI = true,
                        .RCC_CKPERCLKSOURCE_HSE => CKPERCLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    CKPERCLKSOURCE_HSI = true;
                    break :blk .RCC_CKPERCLKSOURCE_HSI;
                };
            };
            const CKPERCLKFreq_VALUEValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const AXICLKSourceValue: ?AXICLKSourceList = blk: {
                const conf_item = config.AXICLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_AXISSOURCE_HSE => AXISSOURCE_HSE = true,
                        .RCC_AXISSOURCE_HSI => AXISSOURCE_HSI = true,
                        .RCC_AXISSOURCE_PLL2 => AXISSOURCE_PLL2 = true,
                    }
                }

                break :blk conf_item orelse {
                    AXISSOURCE_HSI = true;
                    break :blk .RCC_AXISSOURCE_HSI;
                };
            };
            const AXICLKFreq_VALUEValue: ?f32 = blk: {
                AXICLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const DACCLKFreq_VALUEValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const AXI_DivValue: ?AXI_DivList = blk: {
                const conf_item = config.AXI_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_AXI_DIV1 => {},
                        .RCC_AXI_DIV2 => {},
                        .RCC_AXI_DIV3 => {},
                        .RCC_AXI_DIV4 => {},
                    }
                }

                break :blk conf_item orelse .RCC_AXI_DIV1;
            };
            const AXIDIVFreq_ValueValue: ?f32 = blk: {
                AXIDIVFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const Hclk5DIVFreq_ValueValue: ?f32 = blk: {
                Hclk5DIVFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const Hclk6DIVFreq_ValueValue: ?f32 = blk: {
                Hclk6DIVFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const APB4DIVValue: ?APB4DIVList = blk: {
                const conf_item = config.APB4DIV;
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
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const APB5DIVValue: ?APB5DIVList = blk: {
                const conf_item = config.APB5DIV;
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
            const APB5DIVClockFreq_ValueValue: ?f32 = blk: {
                APB5DIVClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 6.7e7,
                };
                break :blk null;
            };
            const APB6DIVValue: ?APB6DIVList = blk: {
                const conf_item = config.APB6DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB6_DIV1 => APB6DIV_1 = true,
                        .RCC_APB6_DIV2 => APB6DIV_2 = true,
                        .RCC_APB6_DIV4 => APB6DIV_4 = true,
                        .RCC_APB6_DIV8 => {},
                        .RCC_APB6_DIV16 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const RCC_TIM_G3_PRescaler_SelectionValue: ?RCC_TIM_G3_PRescaler_SelectionList = blk: {
                const conf_item = config.extra.RCC_TIM_G3_PRescaler_Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMG3PRES_ACTIVATED => TimG3PrescalerEnabled = true,
                        .RCC_TIMG3PRES_DEACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMG3PRES_DEACTIVATED;
            };
            const Tim3MulValue: ?f32 = blk: {
                if (((APB6DIV_1) and (check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_DEACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_DEACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB6DIV_1) and (check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((APB6DIV_2) and (check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB6DIV_4) and (check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_G3_PRescaler_SelectionValue), RCC_TIM_G3_PRescaler_SelectionValue, .RCC_TIMG3PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const Tim3OutputFreq_ValueValue: ?f32 = blk: {
                Tim3OutputFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const APB6Freq_ValueValue: ?f32 = blk: {
                APB6Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_HSI => MCO1SOURCE_HSI = true,
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_CSI => MCO1SOURCE_CSI = true,
                        .RCC_MCO1SOURCE_LSI => MCO1SOURCE_LSI = true,
                        .RCC_MCO1SOURCE_LSE => MCO1SOURCE_LSE = true,
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
                        .RCC_MCODIV_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_MPU => {},
                        .RCC_MCO2SOURCE_AXI => {},
                        .RCC_MCO2SOURCE_MLAHB => {},
                        .RCC_MCO2SOURCE_PLL4 => MCO2SOURCE_PLL4 = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SOURCE_HSE = true,
                        .RCC_MCO2SOURCE_HSI => MCO2SOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_MCO2SOURCE_MPU;
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
                        .RCC_MCODIV_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const MLAHB_DivValue: ?MLAHB_DivList = blk: {
                const conf_item = config.MLAHB_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MLAHB_DIV1 => {},
                        .RCC_MLAHB_DIV2 => {},
                        .RCC_MLAHB_DIV4 => {},
                        .RCC_MLAHB_DIV8 => {},
                        .RCC_MLAHB_DIV16 => {},
                        .RCC_MLAHB_DIV32 => {},
                        .RCC_MLAHB_DIV64 => {},
                        .RCC_MLAHB_DIV128 => {},
                        .RCC_MLAHB_DIV256 => {},
                        .RCC_MLAHB_DIV512 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MLAHB_DIV1;
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const APB3DIVValue: ?APB3DIVList = blk: {
                const conf_item = config.APB3DIV;
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
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const APB1DIVValue: ?APB1DIVList = blk: {
                const conf_item = config.APB1DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB1_DIV1 => APB1DIV_1 = true,
                        .RCC_APB1_DIV2 => APB1DIV_2 = true,
                        .RCC_APB1_DIV4 => APB1DIV_4 = true,
                        .RCC_APB1_DIV8 => {},
                        .RCC_APB1_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    APB1DIV_1 = true;
                    break :blk .RCC_APB1_DIV1;
                };
            };
            const RCC_TIM_G1_PRescaler_SelectionValue: ?RCC_TIM_G1_PRescaler_SelectionList = blk: {
                const conf_item = config.extra.RCC_TIM_G1_PRescaler_Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMG1PRES_ACTIVATED => TimG1PrescalerEnabled = true,
                        .RCC_TIMG1PRES_DEACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMG1PRES_DEACTIVATED;
            };
            const Tim1MulValue: ?f32 = blk: {
                if (((APB1DIV_1) and (check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_DEACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_DEACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB1DIV_1) and (check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((APB1DIV_2) and (check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB1DIV_4) and (check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_G1_PRescaler_SelectionValue), RCC_TIM_G1_PRescaler_SelectionValue, .RCC_TIMG1PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const Tim1OutputFreq_ValueValue: ?f32 = blk: {
                Tim1OutputFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const AHB124Freq_ValueValue: ?f32 = blk: {
                AHB124Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const APB1Freq_ValueValue: ?f32 = blk: {
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const APB2DIVValue: ?APB2DIVList = blk: {
                const conf_item = config.APB2DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB2_DIV1 => APB2DIV_1 = true,
                        .RCC_APB2_DIV2 => APB2DIV_2 = true,
                        .RCC_APB2_DIV4 => APB2DIV_4 = true,
                        .RCC_APB2_DIV8 => {},
                        .RCC_APB2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    APB2DIV_1 = true;
                    break :blk .RCC_APB2_DIV1;
                };
            };
            const RCC_TIM_G2_PRescaler_SelectionValue: ?RCC_TIM_G2_PRescaler_SelectionList = blk: {
                const conf_item = config.extra.RCC_TIM_G2_PRescaler_Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMG2PRES_ACTIVATED => TimG2PrescalerEnabled = true,
                        .RCC_TIMG2PRES_DEACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMG2PRES_DEACTIVATED;
            };
            const Tim2MulValue: ?f32 = blk: {
                if (((APB2DIV_1) and (check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_DEACTIVATED, .@"=")))) {
                    break :blk 1;
                } else if ((check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_DEACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB2DIV_1) and (check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_ACTIVATED, .@"="))) {
                    break :blk 1;
                } else if ((APB2DIV_2) and (check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_ACTIVATED, .@"="))) {
                    break :blk 2;
                } else if ((APB2DIV_4) and (check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                } else if ((check_ref(@TypeOf(RCC_TIM_G2_PRescaler_SelectionValue), RCC_TIM_G2_PRescaler_SelectionValue, .RCC_TIMG2PRES_ACTIVATED, .@"="))) {
                    break :blk 4;
                }
                break :blk 2;
            };
            const Tim2OutputFreq_ValueValue: ?f32 = blk: {
                Tim2OutputFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
                break :blk null;
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const DFSDMFreq_ValueValue: ?f32 = blk: {
                if (config.flags.DFSDM1Used_ForRCC) {
                    DFSDMFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.09e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL12SourceValue: ?PLL12SourceList = blk: {
                const conf_item = config.PLL12Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL12SOURCE_HSI => PLL12SOURCE_HSI = true,
                        .RCC_PLL12SOURCE_HSE => PLL12SOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL12SOURCE_HSI = true;
                    break :blk .RCC_PLL12SOURCE_HSI;
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
                    if (val > 64) {
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
                            64,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                    if (val > 64) {
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
                            64,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL3SourceValue: ?PLL3SourceList = blk: {
                const conf_item = config.PLL3Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL3SOURCE_HSI => PLL3SOURCE_HSI = true,
                        .RCC_PLL3SOURCE_CSI => PLL3SOURCE_CSI = true,
                        .RCC_PLL3SOURCE_HSE => PLL3SOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL3SOURCE_HSI = true;
                    break :blk .RCC_PLL3SOURCE_HSI;
                };
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
                    if (val > 64) {
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
                            64,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL4SourceValue: ?PLL4SourceList = blk: {
                const conf_item = config.PLL4Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL4SOURCE_HSI => PLL4SOURCE_HSI = true,
                        .RCC_PLL4SOURCE_CSI => PLL4SOURCE_CSI = true,
                        .RCC_PLL4SOURCE_HSE => PLL4SOURCE_HSE = true,
                        .RCC_PLL4SOURCE_I2S_CKIN => PLL4SOURCE_I2S_CKIN = true,
                    }
                }

                break :blk conf_item orelse {
                    PLL4SOURCE_HSI = true;
                    break :blk .RCC_PLL4SOURCE_HSI;
                };
            };
            const DIVM4Value: ?f32 = blk: {
                const config_val = config.DIVM4;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVM4",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 64) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVM4",
                            "Else",
                            "No Extra Log",
                            64,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const MPU_DivValue: ?MPU_DivList = blk: {
                const conf_item = config.MPU_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MPU_DIV_OFF => {},
                        .RCC_MPU_DIV2 => {},
                        .RCC_MPU_DIV4 => {},
                        .RCC_MPU_DIV8 => {},
                        .RCC_MPU_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MPU_DIV2;
            };
            const FreqCk1Value: ?f32 = blk: {
                break :blk 2;
            };
            const DIVN1Value: ?f32 = blk: {
                const config_val = config.DIVN1;
                if (config_val) |val| {
                    if (val < 25) {
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
                            25,
                            val,
                        });
                    }
                    if (val > 100) {
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
                            100,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 50;
            };
            const PLL1CSGValue: ?PLL1CSGList = blk: {
                const conf_item = config.PLL1CSG;
                if (conf_item) |item| {
                    switch (item) {
                        .true => {},
                        .false => {},
                    }
                }

                break :blk conf_item orelse .false;
            };
            const PLL1MODEValue: ?PLL1MODEList = blk: {
                if (check_ref(@TypeOf(PLL1CSGValue), PLL1CSGValue, .true, .@"=")) {
                    const item: PLL1MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL1FRACVValue), PLL1FRACVValue, 0, .@"=")) {
                    const item: PLL1MODEList = .RCC_PLL_INTEGER;
                    break :blk item;
                }
                const item: PLL1MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };
            const PLL1FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL1MODEValue), PLL1MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL1FRACV) |val| {
                        if (val != 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {d} found: {d}
                                \\note: some values are fixed depending on the clock configuration
                                \\
                            , .{
                                "PLL1FRACV",
                                "PLL1MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                    }
                    break :blk 0;
                }
                const config_val = config.PLL1FRACV;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1FRACV",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1FRACV",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const VCO1DIV2Value: ?f32 = blk: {
                break :blk 2;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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
            const DIVQ1Freq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
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
            const DIVR1Freq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const FreqCk2Value: ?f32 = blk: {
                break :blk 2;
            };
            const DIVN2Value: ?f32 = blk: {
                const config_val = config.DIVN2;
                if (config_val) |val| {
                    if (val < 25) {
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
                            25,
                            val,
                        });
                    }
                    if (val > 100) {
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
                            100,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 100;
            };
            const PLL2CSGValue: ?PLL2CSGList = blk: {
                const conf_item = config.PLL2CSG;
                if (conf_item) |item| {
                    switch (item) {
                        .true => {},
                        .false => {},
                    }
                }

                break :blk conf_item orelse .false;
            };
            const PLL2MODEValue: ?PLL2MODEList = blk: {
                if (check_ref(@TypeOf(PLL2CSGValue), PLL2CSGValue, .true, .@"=")) {
                    const item: PLL2MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL2FRACVValue), PLL2FRACVValue, 0, .@"=")) {
                    const item: PLL2MODEList = .RCC_PLL_INTEGER;
                    break :blk item;
                }
                const item: PLL2MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };
            const PLL2FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL2FRACV) |val| {
                        if (val != 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {d} found: {d}
                                \\note: some values are fixed depending on the clock configuration
                                \\
                            , .{
                                "PLL2FRACV",
                                "PLL2MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                    }
                    break :blk 0;
                }
                const config_val = config.PLL2FRACV;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2FRACV",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2FRACV",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const VCO2DIV2Value: ?f32 = blk: {
                break :blk 2;
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
            const DIVQ2Freq_ValueValue: ?f32 = blk: {
                DIVQ2Freq_ValueLimit = .{
                    .min = null,
                    .max = 8e8,
                };
                break :blk null;
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
            const PLL2RUsedValue: ?f32 = blk: {
                if (check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR2Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"="))) {
                    DIVR2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const DIVN3Value: ?f32 = blk: {
                const config_val = config.DIVN3;
                if (config_val) |val| {
                    if (val < 25) {
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
                            25,
                            val,
                        });
                    }
                    if (val > 200) {
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
                            200,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 50;
            };
            const PLL3CSGValue: ?PLL3CSGList = blk: {
                const conf_item = config.PLL3CSG;
                if (conf_item) |item| {
                    switch (item) {
                        .true => {},
                        .false => {},
                    }
                }

                break :blk conf_item orelse .false;
            };
            const PLL3MODEValue: ?PLL3MODEList = blk: {
                if (check_ref(@TypeOf(PLL3CSGValue), PLL3CSGValue, .true, .@"=")) {
                    const item: PLL3MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL3FRACVValue), PLL3FRACVValue, 0, .@"=")) {
                    const item: PLL3MODEList = .RCC_PLL_INTEGER;
                    break :blk item;
                }
                const item: PLL3MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };
            const PLL3FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL3FRACV) |val| {
                        if (val != 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {d} found: {d}
                                \\note: some values are fixed depending on the clock configuration
                                \\
                            , .{
                                "PLL3FRACV",
                                "PLL3MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                    }
                    break :blk 0;
                }
                const config_val = config.PLL3FRACV;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3FRACV",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3FRACV",
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
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                const conf_item = config.USART2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK6 => {},
                        .RCC_USART2CLKSOURCE_PLL4 => UART2_PLL4 = true,
                        .RCC_USART2CLKSOURCE_HSE => UART2_HSE = true,
                        .RCC_USART2CLKSOURCE_CSI => UART2_CSI = true,
                        .RCC_USART2CLKSOURCE_HSI => UART2_HSI = true,
                        .RCC_USART2CLKSOURCE_PLL3 => UART2_PLL3Q = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART2CLKSOURCE_PCLK6;
            };
            const ADC1CLockSelectionValue: ?ADC1CLockSelectionList = blk: {
                const conf_item = config.ADC1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADC1CLKSOURCE_PLL4 => ADC1CLKSOURCE_PLL4 = true,
                        .RCC_ADC1CLKSOURCE_PER => ADC1CLKSOURCE_PER = true,
                        .RCC_ADC1CLKSOURCE_PLL3 => ADC1CLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ADC1CLKSOURCE_PLL4 = true;
                    break :blk .RCC_ADC1CLKSOURCE_PLL4;
                };
            };
            const ADC2CLockSelectionValue: ?ADC2CLockSelectionList = blk: {
                const conf_item = config.ADC2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADC2CLKSOURCE_PLL4 => ADC2CLKSOURCE_PLL4 = true,
                        .RCC_ADC2CLKSOURCE_PER => ADC2CLKSOURCE_PER = true,
                        .RCC_ADC2CLKSOURCE_PLL3 => ADC2CLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ADC2CLKSOURCE_PLL4 = true;
                    break :blk .RCC_ADC2CLKSOURCE_PLL4;
                };
            };
            const SPI23CLockSelectionValue: ?SPI23CLockSelectionList = blk: {
                const conf_item = config.SPI23CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI23CLKSOURCE_PLL4 => SPI23CLKSOURCE_PLL4 = true,
                        .RCC_SPI23CLKSOURCE_PLL3_Q => SPI23CLKSOURCE_PLL3 = true,
                        .RCC_SPI23CLKSOURCE_I2SCKIN => SPI23CLKSOURCE_I2SCKIN = true,
                        .RCC_SPI23CLKSOURCE_PER => SPI23CLKSOURCE_PER = true,
                        .RCC_SPI23CLKSOURCE_PLL3_R => SPI23CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI23CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SPI23CLKSOURCE_PLL4;
                };
            };
            const ETH1CLockSelectionValue: ?ETH1CLockSelectionList = blk: {
                const conf_item = config.ETH1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETH1CLKSOURCE_PLL4 => ETHCLKSOURCE_PLL4 = true,
                        .RCC_ETH1CLKSOURCE_PLL3 => ETHCLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ETHCLKSOURCE_PLL4 = true;
                    break :blk .RCC_ETH1CLKSOURCE_PLL4;
                };
            };
            const ETH2CLockSelectionValue: ?ETH2CLockSelectionList = blk: {
                const conf_item = config.ETH2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETH2CLKSOURCE_PLL4 => ETH2CLKSOURCE_PLL4 = true,
                        .RCC_ETH2CLKSOURCE_PLL3 => ETH2CLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ETH2CLKSOURCE_PLL4 = true;
                    break :blk .RCC_ETH2CLKSOURCE_PLL4;
                };
            };
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PLL4 => SPI1CLKSOURCE_PLL4 = true,
                        .RCC_SPI1CLKSOURCE_PLL3_Q => SPI1CLKSOURCE_PLL3 = true,
                        .RCC_SPI1CLKSOURCE_I2SCKIN => SPI1CLKSOURCE_I2SCKIN = true,
                        .RCC_SPI1CLKSOURCE_PER => SPI1CLKSOURCE_PER = true,
                        .RCC_SPI1CLKSOURCE_PLL3_R => SPI1CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI1CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SPI1CLKSOURCE_PLL4;
                };
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLL4 => SAI2CLKSOURCE_PLL4 = true,
                        .RCC_SAI2CLKSOURCE_PLL3_Q => SAI2CLKSOURCE_PLL3 = true,
                        .RCC_SAI2CLKSOURCE_I2SCKIN => SAI2CLKSOURCE_I2SCKIN = true,
                        .RCC_SAI2CLKSOURCE_PER => SAI2CLKSOURCE_PER = true,
                        .RCC_SAI2CLKSOURCE_SPDIF => SAI2CLKSOURCE_SPDIF = true,
                        .RCC_SAI2CLKSOURCE_PLL3_R => SAI2CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLL4;
                };
            };
            const SPDIFCLockSelectionValue: ?SPDIFCLockSelectionList = blk: {
                const conf_item = config.SPDIFCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPDIFRXCLKSOURCE_PLL4 => SPDIFRXCLKSOURCE_PLL4 = true,
                        .RCC_SPDIFRXCLKSOURCE_PLL3 => SPDIFRXCLKSOURCE_PLL3 = true,
                        .RCC_SPDIFRXCLKSOURCE_HSI => SPDIFRXCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SPDIFRXCLKSOURCE_PLL4 = true;
                    break :blk .RCC_SPDIFRXCLKSOURCE_PLL4;
                };
            };
            const LPTIM45CLockSelectionValue: ?LPTIM45CLockSelectionList = blk: {
                const conf_item = config.LPTIM45CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM45CLKSOURCE_PCLK3 => LPTIM45CLKSOURCE_BCLK = true,
                        .RCC_LPTIM45CLKSOURCE_PLL4 => LPTIM45CLKSOURCE_PLL4 = true,
                        .RCC_LPTIM45CLKSOURCE_PLL3 => LPTIM45CLKSOURCE_PLL3 = true,
                        .RCC_LPTIM45CLKSOURCE_LSE => LPTIM45CLKSOURCE_LSE = true,
                        .RCC_LPTIM45CLKSOURCE_LSI => LPTIM45CLKSOURCE_LSI = true,
                        .RCC_LPTIM45CLKSOURCE_PER => LPTIM45CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM45CLKSOURCE_BCLK = true;
                    break :blk .RCC_LPTIM45CLKSOURCE_PCLK3;
                };
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK1 => LPTIM1CLKSOURCE_BCLK = true,
                        .RCC_LPTIM1CLKSOURCE_PLL4 => LPTIM1CLKSOURCE_PLL4 = true,
                        .RCC_LPTIM1CLKSOURCE_PLL3 => LPTIM1CLKSOURCE_PLL3 = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1CLKSOURCE_LSE = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1CLKSOURCE_LSI = true,
                        .RCC_LPTIM1CLKSOURCE_PER => LPTIM1CLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM1CLKSOURCE_BCLK = true;
                    break :blk .RCC_LPTIM1CLKSOURCE_PCLK1;
                };
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK6 => USART1CLKSOURCE_BCLK = true,
                        .RCC_USART1CLKSOURCE_PLL4 => USART1CLKSOURCE_PLL4 = true,
                        .RCC_USART1CLKSOURCE_PLL3 => USART1CLKSOURCE_PLL3 = true,
                        .RCC_USART1CLKSOURCE_HSE => USART1CLKSOURCE_HSE = true,
                        .RCC_USART1CLKSOURCE_CSI => USART1CLKSOURCE_CSI = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    USART1CLKSOURCE_BCLK = true;
                    break :blk .RCC_USART1CLKSOURCE_PCLK6;
                };
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL4 => SAI1CLKSOURCE_PLL4 = true,
                        .RCC_SAI1CLKSOURCE_PLL3_Q => SAI1CLKSOURCE_PLL3 = true,
                        .RCC_SAI1CLKSOURCE_I2SCKIN => SAI1CLKSOURCE_I2SCKIN = true,
                        .RCC_SAI1CLKSOURCE_PER => SAI1CLKSOURCE_PER = true,
                        .RCC_SAI1CLKSOURCE_PLL3_R => SAI1CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLL4;
                };
            };
            const FDCANCLockSelectionValue: ?FDCANCLockSelectionList = blk: {
                const conf_item = config.FDCANCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_HSE => FDCANCLKSOURCE_HSE = true,
                        .RCC_FDCANCLKSOURCE_PLL3 => FDCANCLKSOURCE_PLL3 = true,
                        .RCC_FDCANCLKSOURCE_PLL4_Q => FDCANCLKSOURCE_PLL4 = true,
                        .RCC_FDCANCLKSOURCE_PLL4_R => FDCANCLKSOURCE_PLL4_R = true,
                    }
                }

                break :blk conf_item orelse {
                    FDCANCLKSOURCE_HSE = true;
                    break :blk .RCC_FDCANCLKSOURCE_HSE;
                };
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if (UART2_PLL3Q and config.flags.USART2Used_ForRCC or ADC1CLKSOURCE_PLL3 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or ADC2CLKSOURCE_PLL3 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or SPI23CLKSOURCE_PLL3 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or ETHCLKSOURCE_PLL3 and config.flags.ETH1_Used or ETH2CLKSOURCE_PLL3 and config.flags.ETH2_Used or SPI1CLKSOURCE_PLL3 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL3 or LPTIM45CLKSOURCE_PLL3 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL3 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC or check_MCU("SPI6CLKSOURCE_PLL3") and config.flags.SPI6Used_ForRCC or SAI2CLKSOURCE_PLL3 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI1CLKSOURCE_PLL3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or check_MCU("SAI3CLKSOURCE_PLL3") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or FDCANCLKSOURCE_PLL3 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVQ3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"="))) {
                    DIVQ3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
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
            const LTDCFreq_ValueValue: ?f32 = blk: {
                LTDCFreq_ValueLimit = .{
                    .min = null,
                    .max = 9e7,
                };
                break :blk null;
            };
            const QSPICLockSelectionValue: ?QSPICLockSelectionList = blk: {
                const conf_item = config.QSPICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_QSPICLKSOURCE_ACLK => QSPICLKSOURCE_BCLK = true,
                        .RCC_QSPICLKSOURCE_PLL4 => QSPICLKSOURCE_PLL4 = true,
                        .RCC_QSPICLKSOURCE_PLL3 => QSPICLKSOURCE_PLL3 = true,
                        .RCC_QSPICLKSOURCE_PER => QSPICLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    QSPICLKSOURCE_BCLK = true;
                    break :blk .RCC_QSPICLKSOURCE_ACLK;
                };
            };
            const FMCCLockSelectionValue: ?FMCCLockSelectionList = blk: {
                const conf_item = config.FMCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FMCCLKSOURCE_ACLK => FMCCLKSOURCE_BCLK = true,
                        .RCC_FMCCLKSOURCE_PLL3 => FMCCLKSOURCE_PLL3 = true,
                        .RCC_FMCCLKSOURCE_PLL4 => FMCCLKSOURCE_PLL4 = true,
                        .RCC_FMCCLKSOURCE_PER => FMCCLKSOURCE_PER = true,
                    }
                }

                break :blk conf_item orelse {
                    FMCCLKSOURCE_BCLK = true;
                    break :blk .RCC_FMCCLKSOURCE_ACLK;
                };
            };
            const SDMMC1CLockSelectionValue: ?SDMMC1CLockSelectionList = blk: {
                const conf_item = config.SDMMC1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC1CLKSOURCE_HCLK6 => {},
                        .RCC_SDMMC1CLKSOURCE_PLL3 => SDMMC1CLKSOURCE_PLL3 = true,
                        .RCC_SDMMC1CLKSOURCE_PLL4 => SDMMC1CLKSOURCE_PLL4 = true,
                        .RCC_SDMMC1CLKSOURCE_HSI => SDMMC1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDMMC1CLKSOURCE_HCLK6;
            };
            const SDMMC2CLockSelectionValue: ?SDMMC2CLockSelectionList = blk: {
                const conf_item = config.SDMMC2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC2CLKSOURCE_HCLK6 => {},
                        .RCC_SDMMC2CLKSOURCE_PLL3 => SDMMC2CLKSOURCE_PLL3 = true,
                        .RCC_SDMMC2CLKSOURCE_PLL4 => SDMMC2CLKSOURCE_PLL4 = true,
                        .RCC_SDMMC2CLKSOURCE_HSI => SDMMC2CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDMMC2CLKSOURCE_HCLK6;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if (SPI1CLKSOURCE_PLL3_R and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL3_R and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SAI1CLKSOURCE_PLL3_R and ((config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC) or SAI2CLKSOURCE_PLL3_R and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or check_MCU("SAI3CLKSOURCE_PLL3_R") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or check_MCU("SAI4CLKSOURCE_PLL3_R") and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL3 or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL3 or check_MCU("SDMMC3CLKSOURCE_PLL3") and config.flags.SDMMC3Used_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"="))) {
                    DIVR3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const DIVN4Value: ?f32 = blk: {
                const config_val = config.DIVN4;
                if (config_val) |val| {
                    if (val < 25) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN4",
                            "Else",
                            "No Extra Log",
                            25,
                            val,
                        });
                    }
                    if (val > 200) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVN4",
                            "Else",
                            "No Extra Log",
                            200,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 50;
            };
            const PLL4CSGValue: ?PLL4CSGList = blk: {
                const conf_item = config.PLL4CSG;
                if (conf_item) |item| {
                    switch (item) {
                        .true => {},
                        .false => {},
                    }
                }

                break :blk conf_item orelse .false;
            };
            const PLL4MODEValue: ?PLL4MODEList = blk: {
                if (check_ref(@TypeOf(PLL4CSGValue), PLL4CSGValue, .true, .@"=")) {
                    const item: PLL4MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                } else if (check_ref(@TypeOf(PLL4FRACVValue), PLL4FRACVValue, 0, .@"=")) {
                    const item: PLL4MODEList = .RCC_PLL_INTEGER;
                    break :blk item;
                }
                const item: PLL4MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };
            const PLL4FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL4FRACV) |val| {
                        if (val != 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {d} found: {d}
                                \\note: some values are fixed depending on the clock configuration
                                \\
                            , .{
                                "PLL4FRACV",
                                "PLL4MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                0,
                                val,
                            });
                        }
                    }
                    break :blk 0;
                }
                const config_val = config.PLL4FRACV;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL4FRACV",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 8191) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL4FRACV",
                            "Else",
                            "No Extra Log",
                            8191,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const DIVP4Value: ?f32 = blk: {
                const config_val = config.DIVP4;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVP4",
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
                            "DIVP4",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const DCMICLockSelectionValue: ?DCMICLockSelectionList = blk: {
                const conf_item = config.DCMICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DCMIPPCLKSOURCE_ACLK => {},
                        .RCC_DCMIPPCLKSOURCE_PLL2 => DCMICLKSOURCE_PLL2Q = true,
                        .RCC_DCMIPPCLKSOURCE_PLL4 => DCMICLKSOURCE_PLL4P = true,
                        .RCC_DCMIPPCLKSOURCE_PER => DCMICLKSOURCE_CKPER = true,
                    }
                }

                break :blk conf_item orelse .RCC_DCMIPPCLKSOURCE_ACLK;
            };
            const PLL4PUsedValue: ?f32 = blk: {
                if (ETHCLKSOURCE_PLL4 and config.flags.ETH1_Used or ETH2CLKSOURCE_PLL4 and config.flags.ETH2_Used or DCMICLKSOURCE_PLL4P and config.flags.DCMIPP_Used or config.flags.MCO2Config and MCO2SOURCE_PLL4 or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL4 or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL4 or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL4 or check_MCU("SDMMC3CLKSOURCE_PLL4") and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL4 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL4 and config.flags.LPTIM1Used_ForRCC or SPI1CLKSOURCE_PLL4 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL4 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVP4Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL4PUsedValue), PLL4PUsedValue, 1, .@"="))) {
                    DIVP4Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const DIVQ4Value: ?f32 = blk: {
                const config_val = config.DIVQ4;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVQ4",
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
                            "DIVQ4",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK3 => LPTIM2CLKSOURCE_BCLK = true,
                        .RCC_LPTIM2CLKSOURCE_PLL4 => LPTIM2CLKSOURCE_PLL4 = true,
                        .RCC_LPTIM2CLKSOURCE_PER => LPTIM2CLKSOURCE_PER = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2CLKSOURCE_LSE = true,
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM2CLKSOURCE_BCLK = true;
                    break :blk .RCC_LPTIM2CLKSOURCE_PCLK3;
                };
            };
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
                const conf_item = config.LPTIM3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM3CLKSOURCE_PCLK3 => LPTIM3CLKSOURCE_BCLK = true,
                        .RCC_LPTIM3CLKSOURCE_PLL4 => LPTIM3CLKSOURCE_PLL4 = true,
                        .RCC_LPTIM3CLKSOURCE_PER => LPTIM3CLKSOURCE_PER = true,
                        .RCC_LPTIM3CLKSOURCE_LSE => LPTIM3CLKSOURCE_LSE = true,
                        .RCC_LPTIM3CLKSOURCE_LSI => LPTIM3CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM3CLKSOURCE_BCLK = true;
                    break :blk .RCC_LPTIM3CLKSOURCE_PCLK3;
                };
            };
            const USART4CLockSelectionValue: ?USART4CLockSelectionList = blk: {
                const conf_item = config.USART4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => UART4_PCLK1 = true,
                        .RCC_UART4CLKSOURCE_PLL4 => UART4_PLL4 = true,
                        .RCC_UART4CLKSOURCE_HSE => UART4_HSE = true,
                        .RCC_UART4CLKSOURCE_CSI => UART4_CSI = true,
                        .RCC_UART4CLKSOURCE_HSI => UART4_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    UART4_PCLK1 = true;
                    break :blk .RCC_UART4CLKSOURCE_PCLK1;
                };
            };
            const USART35CLockSelectionValue: ?USART35CLockSelectionList = blk: {
                const conf_item = config.USART35CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART35CLKSOURCE_PCLK1 => UART35CLKSOURCE_BCLK = true,
                        .RCC_UART35CLKSOURCE_PLL4 => UART35CLKSOURCE_PLL4 = true,
                        .RCC_UART35CLKSOURCE_HSE => UART35CLKSOURCE_HSE = true,
                        .RCC_UART35CLKSOURCE_CSI => UART35CLKSOURCE_CSI = true,
                        .RCC_UART35CLKSOURCE_HSI => UART35CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    UART35CLKSOURCE_BCLK = true;
                    break :blk .RCC_UART35CLKSOURCE_PCLK1;
                };
            };
            const USART6CLockSelectionValue: ?USART6CLockSelectionList = blk: {
                const conf_item = config.USART6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART6CLKSOURCE_PCLK2 => USART6CLKSOURCE_BCLK = true,
                        .RCC_USART6CLKSOURCE_PLL4 => USART6CLKSOURCE_PLL4 = true,
                        .RCC_USART6CLKSOURCE_HSE => USART6CLKSOURCE_HSE = true,
                        .RCC_USART6CLKSOURCE_CSI => USART6CLKSOURCE_CSI = true,
                        .RCC_USART6CLKSOURCE_HSI => USART6CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    USART6CLKSOURCE_BCLK = true;
                    break :blk .RCC_USART6CLKSOURCE_PCLK2;
                };
            };
            const UART78CLockSelectionValue: ?UART78CLockSelectionList = blk: {
                const conf_item = config.UART78CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART78CLKSOURCE_PCLK1 => UART78CLKSOURCE_BCLK = true,
                        .RCC_UART78CLKSOURCE_PLL4 => UART78CLKSOURCE_PLL4 = true,
                        .RCC_UART78CLKSOURCE_HSE => UART78CLKSOURCE_HSE = true,
                        .RCC_UART78CLKSOURCE_CSI => UART78CLKSOURCE_CSI = true,
                        .RCC_UART78CLKSOURCE_HSI => UART78CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    UART78CLKSOURCE_BCLK = true;
                    break :blk .RCC_UART78CLKSOURCE_PCLK1;
                };
            };
            const SPI4CLockSelectionValue: ?SPI4CLockSelectionList = blk: {
                const conf_item = config.SPI4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI4CLKSOURCE_PCLK6 => {},
                        .RCC_SPI4CLKSOURCE_PLL4 => SPI4CLKSOURCE_PLL4 = true,
                        .RCC_SPI4CLKSOURCE_HSI => SPI4CLKSOURCE_HSI = true,
                        .RCC_SPI4CLKSOURCE_CSI => SPI4CLKSOURCE_CSI = true,
                        .RCC_SPI4CLKSOURCE_HSE => SPI4CLKSOURCE_HSE = true,
                        .RCC_SPI4CLKSOURCE_I2SCKIN => SPI4_I2SCKIN = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI4CLKSOURCE_PCLK6;
            };
            const SPI5CLockSelectionValue: ?SPI5CLockSelectionList = blk: {
                const conf_item = config.SPI5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI5CLKSOURCE_PCLK6 => {},
                        .RCC_SPI5CLKSOURCE_PLL4 => SPI5CLKSOURCE_PLL4 = true,
                        .RCC_SPI5CLKSOURCE_HSI => SPI5CLKSOURCE_HSI = true,
                        .RCC_SPI5CLKSOURCE_CSI => SPI5CLKSOURCE_CSI = true,
                        .RCC_SPI5CLKSOURCE_HSE => SPI5CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI5CLKSOURCE_PCLK6;
            };
            const PLL4QUsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or LPTIM2CLKSOURCE_PLL4 and config.flags.LPTIM2Used_ForRCC or LPTIM3CLKSOURCE_PLL4 and config.flags.LPTIM3Used_ForRCC or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC or UART2_PLL4 and config.flags.USART2Used_ForRCC or UART4_PLL4 and config.flags.UART4Used_ForRCC or UART35CLKSOURCE_PLL4 and (config.flags.USART3Used_ForRCC or config.flags.UART5Used_ForRCC) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC or UART78CLKSOURCE_PLL4 and (config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) or FDCANCLKSOURCE_PLL4 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or check_MCU("SAI3CLKSOURCE_PLL4") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or check_MCU("SAI4CLKSOURCE_PLL4") and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_PLL4 or SAI1CLKSOURCE_PLL4 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or SPI4CLKSOURCE_PLL4 and (config.flags.SPI4Used_ForRCC or config.flags.I2S4Used_ForRCC) or SPI5CLKSOURCE_PLL4 and config.flags.SPI5Used_ForRCC or check_MCU("SPI6CLKSOURCE_PLL4") and config.flags.SPI6Used_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVQ4Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL4QUsedValue), PLL4QUsedValue, 1, .@"="))) {
                    DIVQ4Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const DIVR4Value: ?f32 = blk: {
                const config_val = config.DIVR4;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "DIVR4",
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
                            "DIVR4",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const SAESCLockSelectionValue: ?SAESCLockSelectionList = blk: {
                const conf_item = config.SAESCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAESCLKSOURCE_ACLK => {},
                        .RCC_SAESCLKSOURCE_PER => SAES_CKPER = true,
                        .RCC_SAESCLKSOURCE_PLL4 => SAES_PLL4R = true,
                        .RCC_SAESCLKSOURCE_LSI => SAES_LSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAESCLKSOURCE_ACLK;
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_PCLK6 => I2C4CLKSOURCE_BCLK = true,
                        .RCC_I2C4CLKSOURCE_PLL4 => I2C4CLKSOURCE_PLL4R = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4CLKSOURCE_HSI = true,
                        .RCC_I2C4CLKSOURCE_CSI => I2C4CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C4CLKSOURCE_BCLK = true;
                    break :blk .RCC_I2C4CLKSOURCE_PCLK6;
                };
            };
            const I2C12CLockSelectionValue: ?I2C12CLockSelectionList = blk: {
                const conf_item = config.I2C12CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C12CLKSOURCE_PCLK1 => I2C12CLKSOURCE_BCLK = true,
                        .RCC_I2C12CLKSOURCE_PLL4 => I2C12CLKSOURCE_PLL4 = true,
                        .RCC_I2C12CLKSOURCE_HSI => I2C12CLKSOURCE_HSI = true,
                        .RCC_I2C12CLKSOURCE_CSI => I2C12CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C12CLKSOURCE_BCLK = true;
                    break :blk .RCC_I2C12CLKSOURCE_PCLK1;
                };
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK6 => I2C3CLKSOURCE_PCLK6 = true,
                        .RCC_I2C3CLKSOURCE_PLL4 => I2C3CLKSOURCE_PLL4 = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3CLKSOURCE_HSI = true,
                        .RCC_I2C3CLKSOURCE_CSI => I2C3CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C3CLKSOURCE_PCLK6 = true;
                    break :blk .RCC_I2C3CLKSOURCE_PCLK6;
                };
            };
            const I2C5CLockSelectionValue: ?I2C5CLockSelectionList = blk: {
                const conf_item = config.I2C5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C5CLKSOURCE_PCLK6 => I2C5CLKSOURCE_PCLK6 = true,
                        .RCC_I2C5CLKSOURCE_PLL4 => I2C5CLKSOURCE_PLL4 = true,
                        .RCC_I2C5CLKSOURCE_HSI => I2C5CLKSOURCE_HSI = true,
                        .RCC_I2C5CLKSOURCE_CSI => I2C5CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C5CLKSOURCE_PCLK6 = true;
                    break :blk .RCC_I2C5CLKSOURCE_PCLK6;
                };
            };
            const RNG1CLockSelectionValue: ?RNG1CLockSelectionList = blk: {
                const conf_item = config.RNG1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNG1CLKSOURCE_CSI => RNG1CLKSOURCE_CSI = true,
                        .RCC_RNG1CLKSOURCE_PLL4 => RNG1CLKSOURCE_PLL4 = true,
                        .RCC_RNG1CLKSOURCE_LSI => RNG1CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RNG1CLKSOURCE_CSI = true;
                    break :blk .RCC_RNG1CLKSOURCE_CSI;
                };
            };
            const USBOCLKSourceValue: ?USBOCLKSourceList = blk: {
                const conf_item = config.USBOCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBOCLKSOURCE_PLL4 => USBOCLKSOURCE_PLL4 = true,
                        .RCC_USBOCLKSOURCE_PHY => USBOCLKSOURCE_PHY = true,
                    }
                }

                break :blk conf_item orelse {
                    USBOCLKSOURCE_PLL4 = true;
                    break :blk .RCC_USBOCLKSOURCE_PLL4;
                };
            };
            const USBPHYCLKSourceValue: ?USBPHYCLKSourceList = blk: {
                const conf_item = config.USBPHYCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBPHYCLKSOURCE_HSE2 => USBPHYCLKSOURCE_HSE2 = true,
                        .RCC_USBPHYCLKSOURCE_HSE => USBPHYCLKSOURCE_HSE = true,
                        .RCC_USBPHYCLKSOURCE_PLL4 => USBPHYCLKSOURCE_PLL4 = true,
                    }
                }

                break :blk conf_item orelse {
                    USBPHYCLKSOURCE_PLL4 = true;
                    break :blk .RCC_USBPHYCLKSOURCE_PLL4;
                };
            };
            const PLL4RUsedValue: ?f32 = blk: {
                if (SAES_PLL4R and config.flags.SAES_Used or ADC1CLKSOURCE_PLL4 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or I2C4CLKSOURCE_PLL4R and config.flags.I2C4Used_ForRCC or ADC2CLKSOURCE_PLL4 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or FDCANCLKSOURCE_PLL4_R and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or I2C12CLKSOURCE_PLL4 and (config.flags.I2C2Used_ForRCC or config.flags.I2C1Used_ForRCC) or I2C3CLKSOURCE_PLL4 and config.flags.I2C3Used_ForRCC or I2C5CLKSOURCE_PLL4 and config.flags.I2C5Used_ForRCC or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC or USBOCLKSOURCE_PLL4 and (config.flags.USB_OTG_HSUsed_ForRCC) or USBPHYCLKSOURCE_PLL4 and (config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USBH_HS1_Used or config.flags.USBH_HS2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVR4Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL4RUsedValue), PLL4RUsedValue, 1, .@"="))) {
                    DIVR4Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                const config_val = config.RCC_RTC_Clock_Source_FROM_HSE;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "RCC_RTC_Clock_Source_FROM_HSE",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 64) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "RCC_RTC_Clock_Source_FROM_HSE",
                            "Else",
                            "No Extra Log",
                            64,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_HSE_DIV => RTCCLKSOURCE_HSE_DIV = true,
                        .RCC_RTCCLKSOURCE_LSE => RTCCLKSOURCE_LSE = true,
                        .RCC_RTCCLKSOURCE_LSI => RTCCLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RTCCLKSOURCE_LSI = true;
                    break :blk .RCC_RTCCLKSOURCE_LSI;
                };
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                RTCFreq_ValueLimit = .{
                    .min = null,
                    .max = 4e6,
                };
                break :blk null;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const I2C12Freq_ValueValue: ?f32 = blk: {
                I2C12Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                I2C3Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const I2C4Freq_ValueValue: ?f32 = blk: {
                I2C4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const I2C5Freq_ValueValue: ?f32 = blk: {
                I2C5Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const SPDIFRXFreq_ValueValue: ?f32 = blk: {
                SPDIFRXFreq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const QSPIFreq_ValueValue: ?f32 = blk: {
                QSPIFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const FMCFreq_ValueValue: ?f32 = blk: {
                FMCFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.665e8,
                };
                break :blk null;
            };
            const SDMMC1Freq_ValueValue: ?f32 = blk: {
                SDMMC1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.66e8,
                };
                break :blk null;
            };
            const SDMMC2Freq_ValueValue: ?f32 = blk: {
                SDMMC2Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.66e8,
                };
                break :blk null;
            };
            const STGENCLockSelectionValue: ?STGENCLockSelectionList = blk: {
                const conf_item = config.STGENCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_STGENCLKSOURCE_HSI => STGENCLKSOURCE_HSI = true,
                        .RCC_STGENCLKSOURCE_HSE => STGENCLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    STGENCLKSOURCE_HSI = true;
                    break :blk .RCC_STGENCLKSOURCE_HSI;
                };
            };
            const STGENFreq_ValueValue: ?f32 = blk: {
                STGENFreq_ValueLimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const LPTIM45Freq_ValueValue: ?f32 = blk: {
                LPTIM45Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                LPTIM2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                LPTIM1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                USART1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                USART2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const USART35Freq_ValueValue: ?f32 = blk: {
                USART35Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const USART6Freq_ValueValue: ?f32 = blk: {
                USART6Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const UART78Freq_ValueValue: ?f32 = blk: {
                UART78Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const RNG1Freq_ValueValue: ?f32 = blk: {
                RNG1Freq_ValueLimit = .{
                    .min = null,
                    .max = 3.6e8,
                };
                break :blk null;
            };
            const DCMIFreq_ValueValue: ?f32 = blk: {
                DCMIFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.66e8,
                };
                break :blk null;
            };
            const SAESFreq_ValueValue: ?f32 = blk: {
                SAESFreq_ValueLimit = .{
                    .min = null,
                    .max = 3.6e8,
                };
                break :blk null;
            };
            const LPTIM3Freq_ValueValue: ?f32 = blk: {
                LPTIM3Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const SPI4Freq_ValueValue: ?f32 = blk: {
                SPI4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const SAI2Freq_ValueValue: ?f32 = blk: {
                SAI2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const USART4Freq_ValueValue: ?f32 = blk: {
                USART4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.045e8,
                };
                break :blk null;
            };
            const SPI1Freq_ValueValue: ?f32 = blk: {
                SPI1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SPI23Freq_ValueValue: ?f32 = blk: {
                SPI23Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                SAI1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const DFSDFAFreq_ValueValue: ?f32 = blk: {
                DFSDFAFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.33e8,
                };
                break :blk null;
            };
            const SPI5Freq_ValueValue: ?f32 = blk: {
                SPI5Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                FDCANFreq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const ETHFreq_ValueValue: ?f32 = blk: {
                ETHFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.25e8,
                };
                break :blk null;
            };
            const ETH2Freq_ValueValue: ?f32 = blk: {
                ETH2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.25e8,
                };
                break :blk null;
            };
            const ADC2Freq_ValueValue: ?f32 = blk: {
                ADC2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const ADC1Freq_ValueValue: ?f32 = blk: {
                ADC1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.3325e8,
                };
                break :blk null;
            };
            const DDRPHYFreq_ValueValue: ?f32 = blk: {
                break :blk 1e7;
            };
            const PUBLFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const DDRCFreq_ValueValue: ?f32 = blk: {
                if (check_MCU("DDR3")) {
                    DDRCFreq_ValueLimit = .{
                        .min = 3e8,
                        .max = 5.33e8,
                    };
                    break :blk null;
                } else if (check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    DDRCFreq_ValueLimit = .{
                        .min = 1e7,
                        .max = 5.33e8,
                    };
                    break :blk null;
                }
                break :blk 3.2e4;
            };
            const DDRPERFMFreq_ValueValue: ?f32 = blk: {
                if (check_MCU("DDR3")) {
                    DDRPERFMFreq_ValueLimit = .{
                        .min = 3e8,
                        .max = 5.33e8,
                    };
                    break :blk null;
                } else if (check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    DDRPERFMFreq_ValueLimit = .{
                        .min = 1e7,
                        .max = 5.33e8,
                    };
                    break :blk null;
                }
                break :blk 3.2e4;
            };
            const RCC_USBPHY_Clock_Source_FROM_HSEValue: ?RCC_USBPHY_Clock_Source_FROM_HSEList = blk: {
                const item: RCC_USBPHY_Clock_Source_FROM_HSEList = .RCC_USBPHYCLKSOURCE_HSE2;
                break :blk item;
            };
            const USBPHYFreq_ValueValue: ?USBPHYFreq_ValueList = blk: {
                const conf_item = config.USBPHYFreq_Value;

                break :blk conf_item orelse .@"19200000";
            };
            const USB_PHY_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const USBOHSFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const HSIDivClkFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLL1UserDefinedConfigValue: ?PLL1UserDefinedConfigList = blk: {
                const conf_item = config.extra.PLL1UserDefinedConfig;
                if (conf_item) |item| {
                    switch (item) {
                        .false => {},
                        .true => {},
                    }
                }

                break :blk conf_item orelse .false;
            };
            const PLL1UsedValue: ?f32 = blk: {
                if ((MPUSOURCE_PLL1 or MPUSOURCE_MPUDIV) and (check_ref(@TypeOf(PLL1UserDefinedConfigValue), PLL1UserDefinedConfigValue, .true, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput1Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    VCOInput1Freq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.6e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (DCMICLKSOURCE_PLL2Q and config.flags.DCMIPP_Used or AXISSOURCE_PLL2 or check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3") or config.flags.GPUUsed_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput2Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCOInput2Freq_ValueLimit = .{
                        .min = 8e6,
                        .max = 1.6e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (UART2_PLL3Q and config.flags.USART2Used_ForRCC or ADC1CLKSOURCE_PLL3 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or ADC2CLKSOURCE_PLL3 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or SPI1CLKSOURCE_PLL3_R and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL3_R and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SPI23CLKSOURCE_PLL3 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or ETHCLKSOURCE_PLL3 and config.flags.ETH1_Used or ETH2CLKSOURCE_PLL3 and config.flags.ETH2_Used or SPI1CLKSOURCE_PLL3 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or MLAHBS_PLL3 or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL3 or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL3 or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL3 or check_MCU("SDMMC3CLKSOURCE_PLL3") and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL3 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL3 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC or check_MCU("SPI6CLKSOURCE_PLL3") and config.flags.SPI6Used_ForRCC or SAI2CLKSOURCE_PLL3 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI1CLKSOURCE_PLL3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or check_MCU("SAI3CLKSOURCE_PLL3") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or FDCANCLKSOURCE_PLL3 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or SAI1CLKSOURCE_PLL3_R and ((config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC) or SAI2CLKSOURCE_PLL3_R and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or check_MCU("SAI3CLKSOURCE_PLL3_R") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or check_MCU("SAI4CLKSOURCE_PLL3_R") and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCOInput3Freq_ValueLimit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL4UsedValue: ?f32 = blk: {
                if (SAES_PLL4R and config.flags.SAES_Used or DCMICLKSOURCE_PLL4P and config.flags.DCMIPP_Used or I2C4CLKSOURCE_PLL4R and config.flags.I2C4Used_ForRCC or ETHCLKSOURCE_PLL4 and config.flags.ETH1_Used or ETH2CLKSOURCE_PLL4 and config.flags.ETH2_Used or config.flags.MCO2Config and MCO2SOURCE_PLL4 or config.flags.LTDCUsed_ForRCC or I2C12CLKSOURCE_PLL4 and (config.flags.I2C2Used_ForRCC or config.flags.I2C1Used_ForRCC) or I2C3CLKSOURCE_PLL4 and config.flags.I2C3Used_ForRCC or I2C5CLKSOURCE_PLL4 and config.flags.I2C5Used_ForRCC or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL4 or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL4 or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL4 or check_MCU("SDMMC3CLKSOURCE_PLL4") and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL4 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM2CLKSOURCE_PLL4 and config.flags.LPTIM2Used_ForRCC or LPTIM3CLKSOURCE_PLL4 and config.flags.LPTIM3Used_ForRCC or LPTIM1CLKSOURCE_PLL4 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC or UART2_PLL4 and config.flags.USART2Used_ForRCC or UART4_PLL4 and config.flags.UART4Used_ForRCC or UART35CLKSOURCE_PLL4 and (config.flags.USART3Used_ForRCC or config.flags.UART5Used_ForRCC) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC or UART78CLKSOURCE_PLL4 and (config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC or check_MCU("SPI6CLKSOURCE_PLL4") and config.flags.SPI6Used_ForRCC or SPI4CLKSOURCE_PLL4 and (config.flags.SPI4Used_ForRCC or config.flags.I2S4Used_ForRCC) or SPI5CLKSOURCE_PLL4 and config.flags.SPI5Used_ForRCC or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_PLL4 or check_MCU("SAI4CLKSOURCE_PLL4") and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or SPI1CLKSOURCE_PLL4 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL4 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SAI1CLKSOURCE_PLL4 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or check_MCU("SAI3CLKSOURCE_PLL4") and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or (FDCANCLKSOURCE_PLL4 or FDCANCLKSOURCE_PLL4_R) and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or ADC1CLKSOURCE_PLL4 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or ADC2CLKSOURCE_PLL4 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or USBPHYCLKSOURCE_PLL4 and (config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USBH_HS1_Used or config.flags.USBH_HS2_Used) or USBOCLKSOURCE_PLL4 and (config.flags.USB_OTG_HSUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInput4Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL4UsedValue), PLL4UsedValue, 1, .@"="))) {
                    VCOInput4Freq_ValueLimit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCO1OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    VCO1OutputFreq_ValueLimit = .{
                        .min = 9.92e8,
                        .max = 2e9,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const DIVP1Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    DIVP1Freq_ValueLimit = .{
                        .min = null,
                        .max = 1e9,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCO2OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCO2OutputFreq_ValueLimit = .{
                        .min = 8e8,
                        .max = 1.6e9,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if (AXISSOURCE_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVP2Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"="))) {
                    DIVP2Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCO3OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCO3OutputFreq_ValueLimit = .{
                        .min = 4e8,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCO4OutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL4UsedValue), PLL4UsedValue, 1, .@"="))) {
                    VCO4OutputFreq_ValueLimit = .{
                        .min = 4e8,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if (MLAHBS_PLL3) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const DIVP3Freq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"="))) {
                    DIVP3Freq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const MLAHBDIVCLKFreq_ValueValue: ?f32 = blk: {
                MLAHBDIVCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.09e8,
                };
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
                if (check_MCU("CRSActivatedSourceLSE") or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTC_Used)) or (config.flags.MCO1Config and MCO1SOURCE_LSE) or (check_MCU("CECCLKSOURCE_LSE") and config.flags.CECUsed_ForRCC) or (LPTIM2CLKSOURCE_LSE and (config.flags.LPTIM2Used_ForRCC)) or (LPTIM3CLKSOURCE_LSE and config.flags.LPTIM3Used_ForRCC) or (LPTIM45CLKSOURCE_LSE and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1Used_ForRCC) {
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
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
            const ExtClockEnableValue: ?ExtClockEnableList = blk: {
                if (config.flags.AudioClockConfig) {
                    const item: ExtClockEnableList = .true;
                    break :blk item;
                }
                const item: ExtClockEnableList = .false;
                break :blk item;
            };
            const PLL1UserDefinedConfigEnableValue: ?PLL1UserDefinedConfigEnableList = blk: {
                if (check_ref(@TypeOf(PLL1UserDefinedConfigValue), PLL1UserDefinedConfigValue, .true, .@"=")) {
                    const item: PLL1UserDefinedConfigEnableList = .true;
                    break :blk item;
                }
                const item: PLL1UserDefinedConfigEnableList = .false;
                break :blk item;
            };
            const cKPerEnableValue: ?cKPerEnableList = blk: {
                if (config.flags.SAES_Used or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX")) or config.flags.DCMIPP_Used or config.flags.LPTIM1Used_ForRCC or config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.LPTIM2Used_ForRCC or check_MCU("QSPI_Selected") or (config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or config.flags.FMCUsed_ForRCC or config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) {
                    const item: cKPerEnableList = .true;
                    break :blk item;
                }
                const item: cKPerEnableList = .false;
                break :blk item;
            };
            const DACEnableValue: ?DACEnableList = blk: {
                if (check_MCU("DAC")) {
                    const item: DACEnableList = .true;
                    break :blk item;
                }
                const item: DACEnableList = .false;
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
            const DFSDMEnableValue: ?DFSDMEnableList = blk: {
                if (config.flags.DFSDM1Used_ForRCC) {
                    const item: DFSDMEnableList = .true;
                    break :blk item;
                }
                const item: DFSDMEnableList = .false;
                break :blk item;
            };
            const DCMIEnableValue: ?DCMIEnableList = blk: {
                if (config.flags.DCMIPP_Used) {
                    const item: DCMIEnableList = .true;
                    break :blk item;
                }
                const item: DCMIEnableList = .false;
                break :blk item;
            };
            const DDREnableValue: ?DDREnableList = blk: {
                if (check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    const item: DDREnableList = .true;
                    break :blk item;
                }
                const item: DDREnableList = .false;
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
            const ADC2EnableValue: ?ADC2EnableList = blk: {
                if ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) {
                    const item: ADC2EnableList = .true;
                    break :blk item;
                }
                const item: ADC2EnableList = .false;
                break :blk item;
            };
            const ADC1EnableValue: ?ADC1EnableList = blk: {
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) {
                    const item: ADC1EnableList = .true;
                    break :blk item;
                }
                const item: ADC1EnableList = .false;
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
            const ETH1EnableValue: ?ETH1EnableList = blk: {
                if (config.flags.ETH1_Used) {
                    const item: ETH1EnableList = .true;
                    break :blk item;
                }
                const item: ETH1EnableList = .false;
                break :blk item;
            };
            const ETH2EnableValue: ?ETH2EnableList = blk: {
                if (config.flags.ETH2_Used) {
                    const item: ETH2EnableList = .true;
                    break :blk item;
                }
                const item: ETH2EnableList = .false;
                break :blk item;
            };
            const EnableDFSDMAudioValue: ?EnableDFSDMAudioList = blk: {
                if (config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) {
                    const item: EnableDFSDMAudioList = .true;
                    break :blk item;
                }
                const item: EnableDFSDMAudioList = .false;
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
            const SPDIFEnableValue: ?SPDIFEnableList = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC) {
                    const item: SPDIFEnableList = .true;
                    break :blk item;
                }
                const item: SPDIFEnableList = .false;
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
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1Used_ForRCC) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const LPTIM45EnableValue: ?LPTIM45EnableList = blk: {
                if (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) {
                    const item: LPTIM45EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM45EnableList = .false;
                break :blk item;
            };
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if ((config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC)) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI23EnableValue: ?SPI23EnableList = blk: {
                if (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) {
                    const item: SPI23EnableList = .true;
                    break :blk item;
                }
                const item: SPI23EnableList = .false;
                break :blk item;
            };
            const SPI4EnableValue: ?SPI4EnableList = blk: {
                if ((config.flags.SPI4Used_ForRCC or config.flags.I2S4Used_ForRCC)) {
                    const item: SPI4EnableList = .true;
                    break :blk item;
                }
                const item: SPI4EnableList = .false;
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
            const SDMMC1EnableValue: ?SDMMC1EnableList = blk: {
                if (config.flags.SDMMC1Used_ForRCC) {
                    const item: SDMMC1EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC1EnableList = .false;
                break :blk item;
            };
            const SDMMC2EnableValue: ?SDMMC2EnableList = blk: {
                if (config.flags.SDMMC2Used_ForRCC) {
                    const item: SDMMC2EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC2EnableList = .false;
                break :blk item;
            };
            const QuadSPIEnableValue: ?QuadSPIEnableList = blk: {
                if (check_MCU("QSPI_Selected")) {
                    const item: QuadSPIEnableList = .true;
                    break :blk item;
                }
                const item: QuadSPIEnableList = .false;
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
            const LTDCEnableValue: ?LTDCEnableList = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    const item: LTDCEnableList = .true;
                    break :blk item;
                }
                const item: LTDCEnableList = .false;
                break :blk item;
            };
            const USART4EnableValue: ?USART4EnableList = blk: {
                if (config.flags.UART4Used_ForRCC) {
                    const item: USART4EnableList = .true;
                    break :blk item;
                }
                const item: USART4EnableList = .false;
                break :blk item;
            };
            const SPI5EnableValue: ?SPI5EnableList = blk: {
                if (config.flags.SPI5Used_ForRCC) {
                    const item: SPI5EnableList = .true;
                    break :blk item;
                }
                const item: SPI5EnableList = .false;
                break :blk item;
            };
            const UART78EnableValue: ?UART78EnableList = blk: {
                if (config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) {
                    const item: UART78EnableList = .true;
                    break :blk item;
                }
                const item: UART78EnableList = .false;
                break :blk item;
            };
            const USART35EnableValue: ?USART35EnableList = blk: {
                if (config.flags.USART3Used_ForRCC or config.flags.UART5Used_ForRCC) {
                    const item: USART35EnableList = .true;
                    break :blk item;
                }
                const item: USART35EnableList = .false;
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
            const LPTIM3EnableValue: ?LPTIM3EnableList = blk: {
                if (config.flags.LPTIM3Used_ForRCC) {
                    const item: LPTIM3EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM3EnableList = .false;
                break :blk item;
            };
            const USART6EnableValue: ?USART6EnableList = blk: {
                if (config.flags.USART6Used_ForRCC) {
                    const item: USART6EnableList = .true;
                    break :blk item;
                }
                const item: USART6EnableList = .false;
                break :blk item;
            };
            const SAESEnableValue: ?SAESEnableList = blk: {
                if (config.flags.SAES_Used) {
                    const item: SAESEnableList = .true;
                    break :blk item;
                }
                const item: SAESEnableList = .false;
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
            const I2C5EnableValue: ?I2C5EnableList = blk: {
                if (config.flags.I2C5Used_ForRCC) {
                    const item: I2C5EnableList = .true;
                    break :blk item;
                }
                const item: I2C5EnableList = .false;
                break :blk item;
            };
            const EnableUSBOHSValue: ?EnableUSBOHSList = blk: {
                if ((config.flags.USB_OTG_HSUsed_ForRCC)) {
                    const item: EnableUSBOHSList = .true;
                    break :blk item;
                }
                const item: EnableUSBOHSList = .false;
                break :blk item;
            };
            const EnableUSBHSValue: ?EnableUSBHSList = blk: {
                if (config.flags.USBH_HS1_Used or config.flags.USBH_HS2_Used) {
                    const item: EnableUSBHSList = .true;
                    break :blk item;
                }
                const item: EnableUSBHSList = .false;
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
            const I2C12EnableValue: ?I2C12EnableList = blk: {
                if (config.flags.I2C1Used_ForRCC or config.flags.I2C2Used_ForRCC) {
                    const item: I2C12EnableList = .true;
                    break :blk item;
                }
                const item: I2C12EnableList = .false;
                break :blk item;
            };
            const RNG1EnableValue: ?RNG1EnableList = blk: {
                if (config.flags.RNG1Used_ForRCC) {
                    const item: RNG1EnableList = .true;
                    break :blk item;
                }
                const item: RNG1EnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTC_Used) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
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
                if (config.flags.IWDGUsed_ForRCC) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const STGENEnableValue: ?STGENEnableList = blk: {
                const item: STGENEnableList = .true;
                break :blk item;
            };
            const EnableHSEUSBPHYDevisorValue: ?EnableHSEUSBPHYDevisorList = blk: {
                if ((config.flags.USB_OTG_HSUsed_ForRCC or config.flags.USBH_HS1_Used or config.flags.USBH_HS2_Used) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEUSBPHYDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSEUSBPHYDevisorList = .false;
                break :blk item;
            };
            const PLL1UsedTFAValue: ?f32 = blk: {
                if ((MPUSOURCE_PLL1 or MPUSOURCE_MPUDIV) and (check_ref(@TypeOf(PLL1UserDefinedConfigValue), PLL1UserDefinedConfigValue, .true, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1UsedA7Value: ?f32 = blk: {
                if ((MPUSOURCE_PLL1 or MPUSOURCE_MPUDIV) and (check_ref(@TypeOf(PLL1UserDefinedConfigValue), PLL1UserDefinedConfigValue, .true, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedTFAValue: ?f32 = blk: {
                if (AXISSOURCE_PLL2 or check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedA7Value: ?f32 = blk: {
                if (DCMICLKSOURCE_PLL2Q and config.flags.DCMIPP_Used and check_MCU("DCMIPP_LINUX") or AXISSOURCE_PLL2 or check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedTFAValue: ?f32 = blk: {
                if (UART2_PLL3Q and config.flags.USART2Used_ForRCC and check_MCU("USART2_BOOTLOADER") or MLAHBS_PLL3 or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") and check_MCU("QUADSPI_BOOTLOADER") or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC and check_MCU("FMC_BOOTLOADER") or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL3 and check_MCU("SDMMC1_BOOTLOADER") or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL3 and check_MCU("SDMMC2_BOOTLOADER") or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC and check_MCU("USART1_BOOTLOADER")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedA7Value: ?f32 = blk: {
                if (UART2_PLL3Q and config.flags.USART2Used_ForRCC and (check_MCU("USART2_SECURE_OS") or check_MCU("USART2_LINUX")) or ADC1CLKSOURCE_PLL3 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) and (check_MCU("ADC1_LINUX") or check_MCU("ADC1_SECURE_OS")) or ADC2CLKSOURCE_PLL3 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) and (check_MCU("ADC2_LINUX") or check_MCU("ADC2_SECURE_OS")) or SPI1CLKSOURCE_PLL3_R and ((config.flags.SPI1Used_ForRCC and check_MCU("SPI1_LINUX")) or (config.flags.I2S1Used_ForRCC and check_MCU("I2S1_LINUX"))) or SPI23CLKSOURCE_PLL3_R and ((config.flags.SPI2Used_ForRCC and check_MCU("SPI2_LINUX")) or (config.flags.SPI3Used_ForRCC and check_MCU("SPI3_LINUX")) or (config.flags.I2S2Used_ForRCC and check_MCU("I2S2_LINUX")) or (config.flags.I2S3Used_ForRCC and check_MCU("I2S3_LINUX"))) or SPI23CLKSOURCE_PLL3 and ((config.flags.SPI2Used_ForRCC and check_MCU("SPI2_LINUX")) or (config.flags.SPI3Used_ForRCC and check_MCU("SPI3_LINUX")) or (config.flags.I2S2Used_ForRCC and check_MCU("I2S2_LINUX")) or (config.flags.I2S3Used_ForRCC and check_MCU("I2S3_LINUX"))) or ETHCLKSOURCE_PLL3 and config.flags.ETH1_Used and (check_MCU("ETH1_LINUX") or check_MCU("ETH1_SECURE_OS")) or ETH2CLKSOURCE_PLL3 and config.flags.ETH2_Used and (check_MCU("ETH2_LINUX") or check_MCU("ETH2_SECURE_OS")) or SPI1CLKSOURCE_PLL3 and ((config.flags.SPI1Used_ForRCC and check_MCU("SPI1_LINUX")) or (config.flags.I2S1Used_ForRCC and check_MCU("I2S1_LINUX"))) or MLAHBS_PLL3 or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL3 and check_MCU("SPDIFRX_LINUX") or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") and (check_MCU("QUADSPI_SECURE_OS") or check_MCU("QUADSPI_LINUX")) or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC and (check_MCU("FMC_SECURE_OS") or check_MCU("FMC_LINUX")) or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL3 and (check_MCU("SDMMC1_SECURE_OS") or check_MCU("SDMMC1_LINUX")) or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL3 and (check_MCU("SDMMC2_SECURE_OS") or check_MCU("SDMMC2_LINUX")) or LPTIM45CLKSOURCE_PLL3 and ((config.flags.LPTIM4Used_ForRCC and check_MCU("LPTIM4_LINUX")) or (config.flags.LPTIM5Used_ForRCC and check_MCU("LPTIM5_LINUX"))) or LPTIM1CLKSOURCE_PLL3 and config.flags.LPTIM1Used_ForRCC and check_MCU("LPTIM1_LINUX") or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC and (check_MCU("USART1_SECURE_OS") or check_MCU("USART1_LINUX")) or SAI2CLKSOURCE_PLL3 and ((config.flags.SAI2_SAIAUsed_ForRCC and check_MCU("SAI2_LINUX")) or (config.flags.SAI2_SAIBUsed_ForRCC and check_MCU("SAI2_LINUX"))) or SAI1CLKSOURCE_PLL3 and ((config.flags.SAI1_SAIAUsed_ForRCC and check_MCU("SAI1_LINUX")) or (config.flags.SAI1_SAIBUsed_ForRCC and check_MCU("SAI1_LINUX")) or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or FDCANCLKSOURCE_PLL3 and ((config.flags.FDCAN1Used_ForRCC and check_MCU("FDCAN1_LINUX")) or (config.flags.FDCAN2Used_ForRCC and check_MCU("FDCAN2_LINUX"))) or SAI1CLKSOURCE_PLL3_R and ((config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or (config.flags.SAI1_SAIAUsed_ForRCC and check_MCU("SAI1_LINUX")) or (config.flags.SAI1_SAIBUsed_ForRCC and check_MCU("SAI1_LINUX"))) or SAI2CLKSOURCE_PLL3_R and ((config.flags.SAI2_SAIAUsed_ForRCC and check_MCU("SAI2_LINUX")) or (config.flags.SAI2_SAIBUsed_ForRCC and check_MCU("SAI2_LINUX")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedTFAValue: ?f32 = blk: {
                if (SAES_PLL4R and config.flags.SAES_Used and check_MCU("SAES_BOOTLOADER") or I2C4CLKSOURCE_PLL4R and config.flags.I2C4Used_ForRCC and check_MCU("I2C4_BOOTLOADER") or I2C3CLKSOURCE_PLL4 and config.flags.I2C3Used_ForRCC and check_MCU("I2C3_BOOTLOADER") or I2C5CLKSOURCE_PLL4 and config.flags.I2C5Used_ForRCC and check_MCU("I2C5_BOOTLOADER") or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") and check_MCU("QUADSPI_BOOTLOADER") or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC and check_MCU("FMC_BOOTLOADER") or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL4 and check_MCU("SDMMC1_BOOTLOADER") or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL4 and check_MCU("SDMMC2_BOOTLOADER") or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC and check_MCU("USART1_BOOTLOADER") or UART2_PLL4 and config.flags.USART2Used_ForRCC and check_MCU("USART2_BOOTLOADER") or UART4_PLL4 and config.flags.UART4Used_ForRCC and check_MCU("UART4_BOOTLOADER") or UART35CLKSOURCE_PLL4 and ((config.flags.USART3Used_ForRCC and check_MCU("USART3_BOOTLOADER")) or (config.flags.UART5Used_ForRCC and check_MCU("UART5_BOOTLOADER"))) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC and check_MCU("USART6_BOOTLOADER") or UART78CLKSOURCE_PLL4 and ((config.flags.UART7Used_ForRCC and check_MCU("UART7_BOOTLOADER")) or (config.flags.UART8Used_ForRCC and check_MCU("UART8_BOOTLOADER"))) or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC and check_MCU("RNG1_BOOTLOADER") or USBOCLKSOURCE_PLL4 and config.flags.USB_OTG_HSUsed_ForRCC and check_MCU("USB_OTG_HS_BOOTLOADER") or USBPHYCLKSOURCE_PLL4 and config.flags.USB_OTG_HSUsed_ForRCC and USBOCLKSOURCE_PHY and check_MCU("USB_OTG_HS_BOOTLOADER")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedA7Value: ?f32 = blk: {
                if (SAES_PLL4R and config.flags.SAES_Used and (check_MCU("SAES_LINUX") or check_MCU("SAES_SECURE_OS")) or DCMICLKSOURCE_PLL4P and config.flags.DCMIPP_Used and check_MCU("DCMIPP_LINUX") or I2C4CLKSOURCE_PLL4R and config.flags.I2C4Used_ForRCC and (check_MCU("I2C4_LINUX") or check_MCU("I2C4_SECURE_OS")) or ETHCLKSOURCE_PLL4 and config.flags.ETH1_Used and (check_MCU("ETH1_LINUX") or check_MCU("ETH1_SECURE_OS")) or ETH2CLKSOURCE_PLL4 and config.flags.ETH2_Used and (check_MCU("ETH2_LINUX") or check_MCU("ETH2_SECURE_OS")) or I2C12CLKSOURCE_PLL4 and ((config.flags.I2C2Used_ForRCC and check_MCU("I2C2_LINUX")) or (config.flags.I2C1Used_ForRCC and check_MCU("I2C1_LINUX"))) or I2C3CLKSOURCE_PLL4 and config.flags.I2C3Used_ForRCC and (check_MCU("I2C3_LINUX") or check_MCU("I2C3_SECURE_OS")) or I2C5CLKSOURCE_PLL4 and config.flags.I2C5Used_ForRCC and (check_MCU("I2C5_LINUX") or check_MCU("I2C5_SECURE_OS")) or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL4 and check_MCU("SPDIFRX_LINUX") or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") and (check_MCU("QUADSPI_SECURE_OS") or check_MCU("QUADSPI_LINUX")) or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC and (check_MCU("FMC_SECURE_OS") or check_MCU("FMC_LINUX")) or config.flags.SDMMC1Used_ForRCC and SDMMC1CLKSOURCE_PLL4 and (check_MCU("SDMMC1_SECURE_OS") or check_MCU("SDMMC1_LINUX")) or config.flags.SDMMC2Used_ForRCC and SDMMC2CLKSOURCE_PLL4 and (check_MCU("SDMMC2_SECURE_OS") or check_MCU("SDMMC2_LINUX")) or LPTIM45CLKSOURCE_PLL4 and ((config.flags.LPTIM4Used_ForRCC and check_MCU("LPTIM4_LINUX")) or (config.flags.LPTIM5Used_ForRCC and check_MCU("LPTIM5_LINUX"))) or LPTIM2CLKSOURCE_PLL4 and config.flags.LPTIM2Used_ForRCC and (check_MCU("LPTIM2_LINUX") or check_MCU("LPTIM2_SECURE_OS")) or LPTIM3CLKSOURCE_PLL4 and config.flags.LPTIM3Used_ForRCC and (check_MCU("LPTIM3_LINUX") or check_MCU("LPTIM3_SECURE_OS")) or LPTIM1CLKSOURCE_PLL4 and config.flags.LPTIM1Used_ForRCC and check_MCU("LPTIM1_LINUX") or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC and (check_MCU("USART1_SECURE_OS") or check_MCU("USART1_LINUX")) or UART2_PLL4 and config.flags.USART2Used_ForRCC and (check_MCU("USART2_SECURE_OS") or check_MCU("USART2_LINUX")) or UART4_PLL4 and config.flags.UART4Used_ForRCC and check_MCU("UART4_LINUX") or UART35CLKSOURCE_PLL4 and ((config.flags.USART3Used_ForRCC and check_MCU("USART3_LINUX")) or (config.flags.UART5Used_ForRCC and check_MCU("UART5_LINUX"))) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC and check_MCU("USART6_LINUX") or UART78CLKSOURCE_PLL4 and ((config.flags.UART7Used_ForRCC and check_MCU("UART7_LINUX")) or (config.flags.UART8Used_ForRCC and check_MCU("UART8_LINUX"))) or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC and (check_MCU("RNG1_LINUX") or check_MCU("RNG1_SECURE_OS")) or SPI4CLKSOURCE_PLL4 and ((config.flags.SPI4Used_ForRCC and (check_MCU("SPI4_SECURE_OS") or check_MCU("SPI4_LINUX"))) or (config.flags.I2S4Used_ForRCC and check_MCU("I2S4_SECURE_OS") or check_MCU("I2S4_LINUX"))) or SPI5CLKSOURCE_PLL4 and config.flags.SPI5Used_ForRCC and (check_MCU("SPI5_SECURE_OS") or check_MCU("SPI5_LINUX")) or ((config.flags.SAI2_SAIAUsed_ForRCC and check_MCU("SAI2_LINUX")) or (config.flags.SAI2_SAIBUsed_ForRCC and check_MCU("SAI2_LINUX"))) and SAI2CLKSOURCE_PLL4 or SPI1CLKSOURCE_PLL4 and ((config.flags.SPI1Used_ForRCC and check_MCU("SPI1_LINUX")) or (config.flags.I2S1Used_ForRCC and check_MCU("I2S1_LINUX"))) or SPI23CLKSOURCE_PLL4 and ((config.flags.SPI2Used_ForRCC and check_MCU("SPI2_LINUX")) or (config.flags.SPI3Used_ForRCC and check_MCU("SPI3_LINUX")) or (config.flags.I2S2Used_ForRCC and check_MCU("I2S2_LINUX")) or (config.flags.I2S3Used_ForRCC and check_MCU("I2S3_LINUX"))) or SAI1CLKSOURCE_PLL4 and ((config.flags.SAI1_SAIAUsed_ForRCC and check_MCU("SAI1_LINUX")) or (config.flags.SAI1_SAIBUsed_ForRCC and check_MCU("SAI1_LINUX")) or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or (FDCANCLKSOURCE_PLL4 or FDCANCLKSOURCE_PLL4_R) and ((config.flags.FDCAN1Used_ForRCC and check_MCU("FDCAN1_LINUX")) or (config.flags.FDCAN2Used_ForRCC and check_MCU("FDCAN2_LINUX"))) or ADC1CLKSOURCE_PLL4 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) and (check_MCU("ADC1_LINUX") or check_MCU("ADC1_SECURE_OS")) or ADC2CLKSOURCE_PLL4 and ((config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) and (check_MCU("ADC2_LINUX") or check_MCU("ADC2_SECURE_OS")) or USBPHYCLKSOURCE_PLL4 and ((config.flags.USB_OTG_HSUsed_ForRCC and (check_MCU("USB_OTG_HS_LINUX") or check_MCU("USB_OTG_HS_SECURE_OS")) and USBOCLKSOURCE_PHY) or (config.flags.USBH_HS1_Used and check_MCU("USBH_HS1_LINUX")) or (config.flags.USBH_HS2_Used and check_MCU("USBH_HS2_LINUX"))) or USBOCLKSOURCE_PLL4 and (config.flags.USB_OTG_HSUsed_ForRCC) and (check_MCU("USB_OTG_HS_LINUX") or check_MCU("USB_OTG_HS_SECURE_OS"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTC_Used) and (config.flags.LSEOscillator or config.flags.LSEByPass or config.flags.LSEDIGByPass)) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
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

            var MPUMult = ClockNode{
                .name = "MPUMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MPUCLKOutput = ClockNode{
                .name = "MPUCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CKPERMult = ClockNode{
                .name = "CKPERMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CKPERCLKOutput = ClockNode{
                .name = "CKPERCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXIMult = ClockNode{
                .name = "AXIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXICLKOutput = ClockNode{
                .name = "AXICLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DACCLKOutput = ClockNode{
                .name = "DACCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXIDIV = ClockNode{
                .name = "AXIDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXIOutput = ClockNode{
                .name = "AXIOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var Hclk5Output = ClockNode{
                .name = "Hclk5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var Hclk6Output = ClockNode{
                .name = "Hclk6Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB4DIV = ClockNode{
                .name = "APB4DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB4DIVOutput = ClockNode{
                .name = "APB4DIVOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB5DIV = ClockNode{
                .name = "APB5DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB5DIVOutput = ClockNode{
                .name = "APB5DIVOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB6DIV = ClockNode{
                .name = "APB6DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim3Mul = ClockNode{
                .name = "Tim3Mul",
                .nodetype = .off,
                .parents = &.{},
            };

            var Tim3Output = ClockNode{
                .name = "Tim3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB6DIVOutput = ClockNode{
                .name = "APB6DIVOutput",
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

            var MLAHBDIV = ClockNode{
                .name = "MLAHBDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var MLAHBClockOutput = ClockNode{
                .name = "MLAHBClockOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3DIV = ClockNode{
                .name = "APB3DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB3Output = ClockNode{
                .name = "APB3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1DIV = ClockNode{
                .name = "APB1DIV",
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

            var AHBOutput = ClockNode{
                .name = "AHBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1Output = ClockNode{
                .name = "APB1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB2DIV = ClockNode{
                .name = "APB2DIV",
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

            var APB2Output = ClockNode{
                .name = "APB2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDM1Output = ClockNode{
                .name = "DFSDM1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL12Source = ClockNode{
                .name = "PLL12Source",
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

            var PLL3Source = ClockNode{
                .name = "PLL3Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVM3 = ClockNode{
                .name = "DIVM3",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL4Source = ClockNode{
                .name = "PLL4Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVM4 = ClockNode{
                .name = "DIVM4",
                .nodetype = .off,
                .parents = &.{},
            };

            var MPUDIV = ClockNode{
                .name = "MPUDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var FreqCk1 = ClockNode{
                .name = "FreqCk1",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN1 = ClockNode{
                .name = "DIVN1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1FRACV = ClockNode{
                .name = "PLL1FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN1Mul2Div2 = ClockNode{
                .name = "DIVN1Mul2Div2",
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

            var FreqCk2 = ClockNode{
                .name = "FreqCk2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN2 = ClockNode{
                .name = "DIVN2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2FRACV = ClockNode{
                .name = "PLL2FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVN2Mul2Div2 = ClockNode{
                .name = "DIVN2Mul2Div2",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP2 = ClockNode{
                .name = "DIVP2",
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

            var PLL3FRACV = ClockNode{
                .name = "PLL3FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP3 = ClockNode{
                .name = "DIVP3",
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

            var DIVN4 = ClockNode{
                .name = "DIVN4",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL4FRACV = ClockNode{
                .name = "PLL4FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP4 = ClockNode{
                .name = "DIVP4",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVP4output = ClockNode{
                .name = "DIVP4output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ4 = ClockNode{
                .name = "DIVQ4",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVQ4output = ClockNode{
                .name = "DIVQ4output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR4 = ClockNode{
                .name = "DIVR4",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIVR4output = ClockNode{
                .name = "DIVR4output",
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

            var I2C12Mult = ClockNode{
                .name = "I2C12Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C12output = ClockNode{
                .name = "I2C12output",
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

            var I2C5Mult = ClockNode{
                .name = "I2C5Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C5output = ClockNode{
                .name = "I2C5output",
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

            var SDMMC1Mult = ClockNode{
                .name = "SDMMC1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC1output = ClockNode{
                .name = "SDMMC1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC2Mult = ClockNode{
                .name = "SDMMC2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC2output = ClockNode{
                .name = "SDMMC2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var STGENMult = ClockNode{
                .name = "STGENMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var STGENoutput = ClockNode{
                .name = "STGENoutput",
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

            var USART35Mult = ClockNode{
                .name = "USART35Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART35output = ClockNode{
                .name = "USART35output",
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

            var UART78Mult = ClockNode{
                .name = "UART78Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART78output = ClockNode{
                .name = "USART78output",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNG1Mult = ClockNode{
                .name = "RNG1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNG1output = ClockNode{
                .name = "RNG1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DCMIMult = ClockNode{
                .name = "DCMIMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DCMIoutput = ClockNode{
                .name = "DCMIoutput",
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

            var USART4Mult = ClockNode{
                .name = "USART4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART4output = ClockNode{
                .name = "USART4output",
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

            var DFSDF1Audiooutput = ClockNode{
                .name = "DFSDF1Audiooutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI5Mult = ClockNode{
                .name = "SPI5Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI5output = ClockNode{
                .name = "SPI5output",
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

            var ETH2Mult = ClockNode{
                .name = "ETH2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ETH2output = ClockNode{
                .name = "ETH2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC2Mult = ClockNode{
                .name = "ADC2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC2output = ClockNode{
                .name = "ADC2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC1Mult = ClockNode{
                .name = "ADC1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC1output = ClockNode{
                .name = "ADC1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var DDRPHYC = ClockNode{
                .name = "DDRPHYC",
                .nodetype = .off,
                .parents = &.{},
            };

            var PUBL = ClockNode{
                .name = "PUBL",
                .nodetype = .off,
                .parents = &.{},
            };

            var DDRC = ClockNode{
                .name = "DDRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var DDRPERFM = ClockNode{
                .name = "DDRPERFM",
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

            var HSIDivClk = ClockNode{
                .name = "HSIDivClk",
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

            var VCO4Input = ClockNode{
                .name = "VCO4Input",
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

            var PLL2CLK = ClockNode{
                .name = "PLL2CLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO3Output = ClockNode{
                .name = "VCO3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO4Output = ClockNode{
                .name = "VCO4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3CLK = ClockNode{
                .name = "PLL3CLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var MLAHBDIVCLK = ClockNode{
                .name = "MLAHBDIVCLK",
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

            const HSIDiv_clk_value = HSIDivValueValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIDiv",
                "Else",
                "No Extra Log",
                "HSIDivValue",
            });
            HSIDiv.nodetype = .div;
            HSIDiv.value = HSIDiv_clk_value.get();
            HSIDiv.parents = &.{&HSIRC};
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
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
            }

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
            if (check_ref(@TypeOf(EnableLSEValue), EnableLSEValue, .true, .@"=")) {
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
            }

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

            const SysClkSource_clk_value = MLAHBCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SysClkSource",
                "Else",
                "No Extra Log",
                "MLAHBCLKSource",
            });
            const SysClkSourceparents = [_]*const ClockNode{
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
                &DIVP3,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(MLAHBCLKFreq_VALUEValue);
            SysCLKOutput.limit = MLAHBCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
                const MPUMult_clk_value = MPUCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MPUMult",
                    "Else",
                    "No Extra Log",
                    "MPUCLKSource",
                });
                const MPUMultparents = [_]*const ClockNode{
                    &DIVP1,
                    &MPUDIV,
                    &HSEOSC,
                    &HSIDiv,
                };
                MPUMult.nodetype = .multi;
                MPUMult.parents = &.{MPUMultparents[MPUMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MPUCLKFreq_VALUEValue);
                MPUCLKOutput.limit = MPUCLKFreq_VALUELimit;
                MPUCLKOutput.nodetype = .output;
                MPUCLKOutput.parents = &.{&MPUMult};
            }
            if (check_ref(@TypeOf(cKPerEnableValue), cKPerEnableValue, .true, .@"=")) {
                const CKPERMult_clk_value = CKPERCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CKPERMult",
                    "Else",
                    "No Extra Log",
                    "CKPERCLKSource",
                });
                const CKPERMultparents = [_]*const ClockNode{
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                };
                CKPERMult.nodetype = .multi;
                CKPERMult.parents = &.{CKPERMultparents[CKPERMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(cKPerEnableValue), cKPerEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CKPERCLKFreq_VALUEValue);
                CKPERCLKOutput.nodetype = .output;
                CKPERCLKOutput.parents = &.{&CKPERMult};
            }

            const AXIMult_clk_value = AXICLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AXIMult",
                "Else",
                "No Extra Log",
                "AXICLKSource",
            });
            const AXIMultparents = [_]*const ClockNode{
                &HSEOSC,
                &HSIDiv,
                &DIVP2,
            };
            AXIMult.nodetype = .multi;
            AXIMult.parents = &.{AXIMultparents[AXIMult_clk_value.get()]};

            std.mem.doNotOptimizeAway(AXICLKFreq_VALUEValue);
            AXICLKOutput.limit = AXICLKFreq_VALUELimit;
            AXICLKOutput.nodetype = .output;
            AXICLKOutput.parents = &.{&AXIMult};
            if (check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DACCLKFreq_VALUEValue);
                DACCLKOutput.nodetype = .output;
                DACCLKOutput.parents = &.{&LSIRC};
            }

            const AXIDIV_clk_value = AXI_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AXIDIV",
                "Else",
                "No Extra Log",
                "AXI_Div",
            });
            AXIDIV.nodetype = .div;
            AXIDIV.value = AXIDIV_clk_value.get();
            AXIDIV.parents = &.{&AXICLKOutput};

            std.mem.doNotOptimizeAway(AXIDIVFreq_ValueValue);
            AXIOutput.limit = AXIDIVFreq_ValueLimit;
            AXIOutput.nodetype = .output;
            AXIOutput.parents = &.{&AXIDIV};

            std.mem.doNotOptimizeAway(Hclk5DIVFreq_ValueValue);
            Hclk5Output.limit = Hclk5DIVFreq_ValueLimit;
            Hclk5Output.nodetype = .output;
            Hclk5Output.parents = &.{&AXIDIV};

            std.mem.doNotOptimizeAway(Hclk6DIVFreq_ValueValue);
            Hclk6Output.limit = Hclk6DIVFreq_ValueLimit;
            Hclk6Output.nodetype = .output;
            Hclk6Output.parents = &.{&AXIDIV};

            const APB4DIV_clk_value = APB4DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB4DIV",
                "Else",
                "No Extra Log",
                "APB4DIV",
            });
            APB4DIV.nodetype = .div;
            APB4DIV.value = APB4DIV_clk_value.get();
            APB4DIV.parents = &.{&AXIDIV};

            std.mem.doNotOptimizeAway(APB4Freq_ValueValue);
            APB4DIVOutput.limit = APB4Freq_ValueLimit;
            APB4DIVOutput.nodetype = .output;
            APB4DIVOutput.parents = &.{&APB4DIV};

            const APB5DIV_clk_value = APB5DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB5DIV",
                "Else",
                "No Extra Log",
                "APB5DIV",
            });
            APB5DIV.nodetype = .div;
            APB5DIV.value = APB5DIV_clk_value.get();
            APB5DIV.parents = &.{&AXIDIV};

            std.mem.doNotOptimizeAway(APB5DIVClockFreq_ValueValue);
            APB5DIVOutput.limit = APB5DIVClockFreq_ValueLimit;
            APB5DIVOutput.nodetype = .output;
            APB5DIVOutput.parents = &.{&APB5DIV};

            const APB6DIV_clk_value = APB6DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB6DIV",
                "Else",
                "No Extra Log",
                "APB6DIV",
            });
            APB6DIV.nodetype = .div;
            APB6DIV.value = APB6DIV_clk_value.get();
            APB6DIV.parents = &.{&MLAHBDIV};

            const Tim3Mul_clk_value = Tim3MulValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "Tim3Mul",
                "Else",
                "No Extra Log",
                "Tim3Mul",
            });
            Tim3Mul.nodetype = .mul;
            Tim3Mul.value = Tim3Mul_clk_value;
            Tim3Mul.parents = &.{&APB6DIV};

            std.mem.doNotOptimizeAway(Tim3OutputFreq_ValueValue);
            Tim3Output.limit = Tim3OutputFreq_ValueLimit;
            Tim3Output.nodetype = .output;
            Tim3Output.parents = &.{&Tim3Mul};

            std.mem.doNotOptimizeAway(APB6Freq_ValueValue);
            APB6DIVOutput.limit = APB6Freq_ValueLimit;
            APB6DIVOutput.nodetype = .output;
            APB6DIVOutput.parents = &.{&APB6DIV};
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
                    &CSIRC,
                    &LSIRC,
                    &LSEOSC,
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
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
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
                    &MPUCLKOutput,
                    &AXIDIV,
                    &SysCLKOutput,
                    &DIVP4,
                    &HSEOSC,
                    &HSIDiv,
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
                std.mem.doNotOptimizeAway(MCO2PinFreq_ValueValue);
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }

            const MLAHBDIV_clk_value = MLAHB_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MLAHBDIV",
                "Else",
                "No Extra Log",
                "MLAHB_Div",
            });
            MLAHBDIV.nodetype = .div;
            MLAHBDIV.value = MLAHBDIV_clk_value.get();
            MLAHBDIV.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            MLAHBClockOutput.limit = SYSCLKFreq_VALUELimit;
            MLAHBClockOutput.nodetype = .output;
            MLAHBClockOutput.parents = &.{&MLAHBDIV};

            const APB3DIV_clk_value = APB3DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB3DIV",
                "Else",
                "No Extra Log",
                "APB3DIV",
            });
            APB3DIV.nodetype = .div;
            APB3DIV.value = APB3DIV_clk_value.get();
            APB3DIV.parents = &.{&MLAHBDIV};

            std.mem.doNotOptimizeAway(APB3Freq_ValueValue);
            APB3Output.limit = APB3Freq_ValueLimit;
            APB3Output.nodetype = .output;
            APB3Output.parents = &.{&APB3DIV};

            const APB1DIV_clk_value = APB1DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB1DIV",
                "Else",
                "No Extra Log",
                "APB1DIV",
            });
            APB1DIV.nodetype = .div;
            APB1DIV.value = APB1DIV_clk_value.get();
            APB1DIV.parents = &.{&MLAHBDIV};

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
            Tim1Mul.parents = &.{&APB1DIV};

            std.mem.doNotOptimizeAway(Tim1OutputFreq_ValueValue);
            Tim1Output.limit = Tim1OutputFreq_ValueLimit;
            Tim1Output.nodetype = .output;
            Tim1Output.parents = &.{&Tim1Mul};

            std.mem.doNotOptimizeAway(AHB124Freq_ValueValue);
            AHBOutput.limit = AHB124Freq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&MLAHBDIV};

            std.mem.doNotOptimizeAway(APB1Freq_ValueValue);
            APB1Output.limit = APB1Freq_ValueLimit;
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&APB1DIV};

            const APB2DIV_clk_value = APB2DIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB2DIV",
                "Else",
                "No Extra Log",
                "APB2DIV",
            });
            APB2DIV.nodetype = .div;
            APB2DIV.value = APB2DIV_clk_value.get();
            APB2DIV.parents = &.{&MLAHBDIV};

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
            Tim2Mul.parents = &.{&APB2DIV};

            std.mem.doNotOptimizeAway(Tim2OutputFreq_ValueValue);
            Tim2Output.limit = Tim2OutputFreq_ValueLimit;
            Tim2Output.nodetype = .output;
            Tim2Output.parents = &.{&Tim2Mul};

            std.mem.doNotOptimizeAway(APB2Freq_ValueValue);
            APB2Output.limit = APB2Freq_ValueLimit;
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&APB2DIV};
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMFreq_ValueValue);
                DFSDM1Output.limit = DFSDMFreq_ValueLimit;
                DFSDM1Output.nodetype = .output;
                DFSDM1Output.parents = &.{&MLAHBDIV};
            }

            const PLL12Source_clk_value = PLL12SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL12Source",
                "Else",
                "No Extra Log",
                "PLL12Source",
            });
            const PLL12Sourceparents = [_]*const ClockNode{
                &HSIDiv,
                &HSEOSC,
            };
            PLL12Source.nodetype = .multi;
            PLL12Source.parents = &.{PLL12Sourceparents[PLL12Source_clk_value.get()]};
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
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
                DIVM1.parents = &.{&PLL12Source};
            }

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
            DIVM2.parents = &.{&PLL12Source};

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
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
            };
            PLL3Source.nodetype = .multi;
            PLL3Source.parents = &.{PLL3Sourceparents[PLL3Source_clk_value.get()]};

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
            DIVM3.parents = &.{&PLL3Source};

            const PLL4Source_clk_value = PLL4SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL4Source",
                "Else",
                "No Extra Log",
                "PLL4Source",
            });
            const PLL4Sourceparents = [_]*const ClockNode{
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
                &I2S_CKIN,
            };
            PLL4Source.nodetype = .multi;
            PLL4Source.parents = &.{PLL4Sourceparents[PLL4Source_clk_value.get()]};

            const DIVM4_clk_value = DIVM4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVM4",
                "Else",
                "No Extra Log",
                "DIVM4",
            });
            DIVM4.nodetype = .div;
            DIVM4.value = DIVM4_clk_value;
            DIVM4.parents = &.{&PLL4Source};
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
                const MPUDIV_clk_value = MPU_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MPUDIV",
                    "Else",
                    "No Extra Log",
                    "MPU_Div",
                });
                MPUDIV.nodetype = .div;
                MPUDIV.value = MPUDIV_clk_value.get();
                MPUDIV.parents = &.{&DIVP1};
            }

            const FreqCk1_clk_value = FreqCk1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FreqCk1",
                "Else",
                "No Extra Log",
                "FreqCk1",
            });
            FreqCk1.nodetype = .mul;
            FreqCk1.value = FreqCk1_clk_value;
            FreqCk1.parents = &.{&DIVM1};
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
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
                DIVN1.parents = &.{ &FreqCk1, &PLL1FRACV };
            }
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
                const PLL1FRACV_clk_value = PLL1FRACVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1FRACV",
                    "Else",
                    "No Extra Log",
                    "PLL1FRACV",
                });
                PLL1FRACV.nodetype = .source;
                PLL1FRACV.value = PLL1FRACV_clk_value;
            }
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
                const DIVN1Mul2Div2_clk_value = VCO1DIV2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVN1Mul2Div2",
                    "Else",
                    "No Extra Log",
                    "VCO1DIV2",
                });
                DIVN1Mul2Div2.nodetype = .div;
                DIVN1Mul2Div2.value = DIVN1Mul2Div2_clk_value;
                DIVN1Mul2Div2.parents = &.{&DIVN1};
            }
            if (check_ref(@TypeOf(PLL1UserDefinedConfigEnableValue), PLL1UserDefinedConfigEnableValue, .true, .@"=")) {
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
                DIVP1.parents = &.{&DIVN1Mul2Div2};
            }
            if (false) {
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
                DIVQ1.parents = &.{&DIVN1Mul2Div2};
            }
            if (false) {
                std.mem.doNotOptimizeAway(DIVQ1Freq_ValueValue);
                DIVQ1output.nodetype = .output;
                DIVQ1output.parents = &.{&DIVQ1};
            }
            if (false) {
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
                DIVR1.parents = &.{&DIVN1Mul2Div2};
            }
            if (false) {
                std.mem.doNotOptimizeAway(DIVR1Freq_ValueValue);
                DIVR1output.nodetype = .output;
                DIVR1output.parents = &.{&DIVR1};
            }

            const FreqCk2_clk_value = FreqCk2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FreqCk2",
                "Else",
                "No Extra Log",
                "FreqCk2",
            });
            FreqCk2.nodetype = .mul;
            FreqCk2.value = FreqCk2_clk_value;
            FreqCk2.parents = &.{&DIVM2};

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
            DIVN2.parents = &.{ &FreqCk2, &PLL2FRACV };

            const PLL2FRACV_clk_value = PLL2FRACVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL2FRACV",
                "Else",
                "No Extra Log",
                "PLL2FRACV",
            });
            PLL2FRACV.nodetype = .source;
            PLL2FRACV.value = PLL2FRACV_clk_value;

            const DIVN2Mul2Div2_clk_value = VCO2DIV2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVN2Mul2Div2",
                "Else",
                "No Extra Log",
                "VCO2DIV2",
            });
            DIVN2Mul2Div2.nodetype = .div;
            DIVN2Mul2Div2.value = DIVN2Mul2Div2_clk_value;
            DIVN2Mul2Div2.parents = &.{&DIVN2};

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
            DIVP2.parents = &.{&DIVN2Mul2Div2};
            if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=")) {
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
                DIVQ2.parents = &.{&DIVN2Mul2Div2};
            }
            if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DIVQ2Freq_ValueValue);
                DIVQ2output.limit = DIVQ2Freq_ValueLimit;
                DIVQ2output.nodetype = .output;
                DIVQ2output.parents = &.{&DIVQ2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
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
                DIVR2.parents = &.{&DIVN2Mul2Div2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DIVR2Freq_ValueValue);
                DIVR2output.limit = DIVR2Freq_ValueLimit;
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
            DIVN3.parents = &.{ &DIVM3, &PLL3FRACV };

            const PLL3FRACV_clk_value = PLL3FRACVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL3FRACV",
                "Else",
                "No Extra Log",
                "PLL3FRACV",
            });
            PLL3FRACV.nodetype = .source;
            PLL3FRACV.value = PLL3FRACV_clk_value;

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
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ETH2EnableValue), ETH2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVQ3Freq_ValueValue);
                DIVQ3output.limit = DIVQ3Freq_ValueLimit;
                DIVQ3output.nodetype = .output;
                DIVQ3output.parents = &.{&DIVQ3};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"="))
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
            if (check_MCU("LTDC_Exist")) {
                if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(LTDCFreq_ValueValue);
                    LTDCOutput.limit = LTDCFreq_ValueLimit;
                    LTDCOutput.nodetype = .output;
                    LTDCOutput.parents = &.{&DIVQ4};
                }
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVR3Freq_ValueValue);
                DIVR3output.limit = DIVR3Freq_ValueLimit;
                DIVR3output.nodetype = .output;
                DIVR3output.parents = &.{&DIVR3};
            }

            const DIVN4_clk_value = DIVN4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "DIVN4",
                "Else",
                "No Extra Log",
                "DIVN4",
            });
            DIVN4.nodetype = .mulfrac;
            DIVN4.value = DIVN4_clk_value;
            DIVN4.parents = &.{ &DIVM4, &PLL4FRACV };

            const PLL4FRACV_clk_value = PLL4FRACVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL4FRACV",
                "Else",
                "No Extra Log",
                "PLL4FRACV",
            });
            PLL4FRACV.nodetype = .source;
            PLL4FRACV.value = PLL4FRACV_clk_value;
            if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ETH2EnableValue), ETH2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"="))
            {
                const DIVP4_clk_value = DIVP4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVP4",
                    "Else",
                    "No Extra Log",
                    "DIVP4",
                });
                DIVP4.nodetype = .div;
                DIVP4.value = DIVP4_clk_value;
                DIVP4.parents = &.{&DIVN4};
            }
            if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVP4Freq_ValueValue);
                DIVP4output.limit = DIVP4Freq_ValueLimit;
                DIVP4output.nodetype = .output;
                DIVP4output.parents = &.{&DIVP4};
            }
            if (check_ref(@TypeOf(USART4EnableValue), USART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"="))
            {
                const DIVQ4_clk_value = DIVQ4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVQ4",
                    "Else",
                    "No Extra Log",
                    "DIVQ4",
                });
                DIVQ4.nodetype = .div;
                DIVQ4.value = DIVQ4_clk_value;
                DIVQ4.parents = &.{&DIVN4};
            }
            if (check_ref(@TypeOf(USART4EnableValue), USART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVQ4Freq_ValueValue);
                DIVQ4output.limit = DIVQ4Freq_ValueLimit;
                DIVQ4output.nodetype = .output;
                DIVQ4output.parents = &.{&DIVQ4};
            }
            if (check_ref(@TypeOf(SAESEnableValue), SAESEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C5EnableValue), I2C5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBHSValue), EnableUSBHSValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"="))
            {
                const DIVR4_clk_value = DIVR4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DIVR4",
                    "Else",
                    "No Extra Log",
                    "DIVR4",
                });
                DIVR4.nodetype = .div;
                DIVR4.value = DIVR4_clk_value;
                DIVR4.parents = &.{&DIVN4};
            }
            if (check_ref(@TypeOf(SAESEnableValue), SAESEnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C5EnableValue), I2C5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBHSValue), EnableUSBHSValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(DIVR4Freq_ValueValue);
                DIVR4output.limit = DIVR4Freq_ValueLimit;
                DIVR4output.nodetype = .output;
                DIVR4output.parents = &.{&DIVR4};
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
            if (check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=")) {
                const I2C12Mult_clk_value = I2C12CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C12Mult",
                    "Else",
                    "No Extra Log",
                    "I2C12CLockSelection",
                });
                const I2C12Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVR4,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C12Mult.nodetype = .multi;
                I2C12Mult.parents = &.{I2C12Multparents[I2C12Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C12Freq_ValueValue);
                I2C12output.limit = I2C12Freq_ValueLimit;
                I2C12output.nodetype = .output;
                I2C12output.parents = &.{&I2C12Mult};
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
                    &APB6DIV,
                    &DIVR4,
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
                    &APB6DIV,
                    &DIVR4,
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
            if (check_ref(@TypeOf(I2C5EnableValue), I2C5EnableValue, .true, .@"=")) {
                const I2C5Mult_clk_value = I2C5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C5Mult",
                    "Else",
                    "No Extra Log",
                    "I2C5CLockSelection",
                });
                const I2C5Multparents = [_]*const ClockNode{
                    &APB6DIV,
                    &DIVR4,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C5Mult.nodetype = .multi;
                I2C5Mult.parents = &.{I2C5Multparents[I2C5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C5EnableValue), I2C5EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C5Freq_ValueValue);
                I2C5output.limit = I2C5Freq_ValueLimit;
                I2C5output.nodetype = .output;
                I2C5output.parents = &.{&I2C5Mult};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"="))
            {
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
                    &DIVP4,
                    &DIVQ3,
                    &HSIDiv,
                };
                SPDIFMult.nodetype = .multi;
                SPDIFMult.parents = &.{SPDIFMultparents[SPDIFMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(SPDIFRXFreq_ValueValue);
                SPDIFoutput.limit = SPDIFRXFreq_ValueLimit;
                SPDIFoutput.nodetype = .output;
                SPDIFoutput.parents = &.{&SPDIFMult};
            }
            if (check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=")) {
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
                    &AXIOutput,
                    &DIVP4,
                    &DIVR3,
                    &CKPERCLKOutput,
                };
                QSPIMult.nodetype = .multi;
                QSPIMult.parents = &.{QSPIMultparents[QSPIMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(QSPIFreq_ValueValue);
                QSPIoutput.limit = QSPIFreq_ValueLimit;
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
                    &AXIOutput,
                    &DIVR3,
                    &DIVP4,
                    &CKPERCLKOutput,
                };
                FMCMult.nodetype = .multi;
                FMCMult.parents = &.{FMCMultparents[FMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FMCFreq_ValueValue);
                FMCoutput.limit = FMCFreq_ValueLimit;
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                const SDMMC1Mult_clk_value = SDMMC1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC1Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC1CLockSelection",
                });
                const SDMMC1Multparents = [_]*const ClockNode{
                    &Hclk6Output,
                    &DIVR3,
                    &DIVP4,
                    &HSIDiv,
                };
                SDMMC1Mult.nodetype = .multi;
                SDMMC1Mult.parents = &.{SDMMC1Multparents[SDMMC1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMC1Freq_ValueValue);
                SDMMC1output.limit = SDMMC1Freq_ValueLimit;
                SDMMC1output.nodetype = .output;
                SDMMC1output.parents = &.{&SDMMC1Mult};
            }
            if (check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=")) {
                const SDMMC2Mult_clk_value = SDMMC2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC2Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC2CLockSelection",
                });
                const SDMMC2Multparents = [_]*const ClockNode{
                    &Hclk6Output,
                    &DIVR3,
                    &DIVP4,
                    &HSIDiv,
                };
                SDMMC2Mult.nodetype = .multi;
                SDMMC2Mult.parents = &.{SDMMC2Multparents[SDMMC2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDMMC2Freq_ValueValue);
                SDMMC2output.limit = SDMMC2Freq_ValueLimit;
                SDMMC2output.nodetype = .output;
                SDMMC2output.parents = &.{&SDMMC2Mult};
            }
            if (check_ref(@TypeOf(STGENEnableValue), STGENEnableValue, .true, .@"=")) {
                const STGENMult_clk_value = STGENCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "STGENMult",
                    "Else",
                    "No Extra Log",
                    "STGENCLockSelection",
                });
                const STGENMultparents = [_]*const ClockNode{
                    &HSIDiv,
                    &HSEOSC,
                };
                STGENMult.nodetype = .multi;
                STGENMult.parents = &.{STGENMultparents[STGENMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(STGENEnableValue), STGENEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(STGENFreq_ValueValue);
                STGENoutput.limit = STGENFreq_ValueLimit;
                STGENoutput.nodetype = .output;
                STGENoutput.parents = &.{&STGENMult};
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
                    &APB3DIV,
                    &DIVP4,
                    &DIVQ3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERCLKOutput,
                };
                LPTIM45Mult.nodetype = .multi;
                LPTIM45Mult.parents = &.{LPTIM45Multparents[LPTIM45Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM45Freq_ValueValue);
                LPTIM45output.limit = LPTIM45Freq_ValueLimit;
                LPTIM45output.nodetype = .output;
                LPTIM45output.parents = &.{&LPTIM45Mult};
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
                    &APB3DIV,
                    &DIVQ4,
                    &CKPERCLKOutput,
                    &LSEOSC,
                    &LSIRC,
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
                    &APB1DIV,
                    &DIVP4,
                    &DIVQ3,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERCLKOutput,
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
            if ((check_MCU("USART1_Exist"))) {
                if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                    const USART1Mult_clk_value = USART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "USART1Mult",
                        "(USART1_Exist)",
                        "No Extra Log",
                        "USART1CLockSelection",
                    });
                    const USART1Multparents = [_]*const ClockNode{
                        &APB6DIV,
                        &DIVQ4,
                        &DIVQ3,
                        &HSEOSC,
                        &CSIRC,
                        &HSIDiv,
                    };
                    USART1Mult.nodetype = .multi;
                    USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
                }
            }
            if ((check_MCU("USART1_Exist"))) {
                if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                    USART1output.limit = USART1Freq_ValueLimit;
                    USART1output.nodetype = .output;
                    USART1output.parents = &.{&USART1Mult};
                }
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
                    &APB6DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
                    &DIVQ3,
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
            if (check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=")) {
                const USART35Mult_clk_value = USART35CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART35Mult",
                    "Else",
                    "No Extra Log",
                    "USART35CLockSelection",
                });
                const USART35Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
                };
                USART35Mult.nodetype = .multi;
                USART35Mult.parents = &.{USART35Multparents[USART35Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART35Freq_ValueValue);
                USART35output.limit = USART35Freq_ValueLimit;
                USART35output.nodetype = .output;
                USART35output.parents = &.{&USART35Mult};
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
                    &APB2DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
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
            if (check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=")) {
                const UART78Mult_clk_value = UART78CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART78Mult",
                    "Else",
                    "No Extra Log",
                    "UART78CLockSelection",
                });
                const UART78Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
                };
                UART78Mult.nodetype = .multi;
                UART78Mult.parents = &.{UART78Multparents[UART78Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART78Freq_ValueValue);
                USART78output.limit = UART78Freq_ValueLimit;
                USART78output.nodetype = .output;
                USART78output.parents = &.{&UART78Mult};
            }
            if ((check_MCU("RNG1_Exist"))) {
                if (check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=")) {
                    const RNG1Mult_clk_value = RNG1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RNG1Mult",
                        "(RNG1_Exist)",
                        "No Extra Log",
                        "RNG1CLockSelection",
                    });
                    const RNG1Multparents = [_]*const ClockNode{
                        &CSIRC,
                        &DIVR4,
                        &LSIRC,
                    };
                    RNG1Mult.nodetype = .multi;
                    RNG1Mult.parents = &.{RNG1Multparents[RNG1Mult_clk_value.get()]};
                }
            }
            if ((check_MCU("RNG1_Exist"))) {
                if (check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(RNG1Freq_ValueValue);
                    RNG1output.limit = RNG1Freq_ValueLimit;
                    RNG1output.nodetype = .output;
                    RNG1output.parents = &.{&RNG1Mult};
                }
            }
            if ((check_MCU("DCMIPP_Exist"))) {
                if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=")) {
                    const DCMIMult_clk_value = DCMICLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "DCMIMult",
                        "(DCMIPP_Exist)",
                        "No Extra Log",
                        "DCMICLockSelection",
                    });
                    const DCMIMultparents = [_]*const ClockNode{
                        &AXIOutput,
                        &DIVQ2,
                        &DIVP4,
                        &CKPERCLKOutput,
                    };
                    DCMIMult.nodetype = .multi;
                    DCMIMult.parents = &.{DCMIMultparents[DCMIMult_clk_value.get()]};
                }
            }
            if ((check_MCU("DCMIPP_Exist"))) {
                if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(DCMIFreq_ValueValue);
                    DCMIoutput.limit = DCMIFreq_ValueLimit;
                    DCMIoutput.nodetype = .output;
                    DCMIoutput.parents = &.{&DCMIMult};
                }
            }
            if ((check_MCU("SAES_Exist"))) {
                if (check_ref(@TypeOf(SAESEnableValue), SAESEnableValue, .true, .@"=")) {
                    const SAESMult_clk_value = SAESCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SAESMult",
                        "(SAES_Exist)",
                        "No Extra Log",
                        "SAESCLockSelection",
                    });
                    const SAESMultparents = [_]*const ClockNode{
                        &AXIOutput,
                        &CKPERCLKOutput,
                        &DIVR4,
                        &LSIRC,
                    };
                    SAESMult.nodetype = .multi;
                    SAESMult.parents = &.{SAESMultparents[SAESMult_clk_value.get()]};
                }
            }
            if ((check_MCU("SAES_Exist"))) {
                if (check_ref(@TypeOf(SAESEnableValue), SAESEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SAESFreq_ValueValue);
                    SAESoutput.limit = SAESFreq_ValueLimit;
                    SAESoutput.nodetype = .output;
                    SAESoutput.parents = &.{&SAESMult};
                }
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
                    &APB3DIV,
                    &DIVQ4,
                    &CKPERCLKOutput,
                    &LSEOSC,
                    &LSIRC,
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
            if (check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=")) {
                const SPI4Mult_clk_value = SPI4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI4Mult",
                    "Else",
                    "No Extra Log",
                    "SPI4CLockSelection",
                });
                const SPI4Multparents = [_]*const ClockNode{
                    &APB6DIV,
                    &DIVQ4,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                    &I2S_CKIN,
                };
                SPI4Mult.nodetype = .multi;
                SPI4Mult.parents = &.{SPI4Multparents[SPI4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI4Freq_ValueValue);
                SPI4output.limit = SPI4Freq_ValueLimit;
                SPI4output.nodetype = .output;
                SPI4output.parents = &.{&SPI4Mult};
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
                    &DIVQ4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &SPDIFMult,
                    &DIVR3,
                };
                SAI2Mult.nodetype = .multi;
                SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2Freq_ValueValue);
                SAI2output.limit = SAI2Freq_ValueLimit;
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
            }
            if (check_ref(@TypeOf(USART4EnableValue), USART4EnableValue, .true, .@"=")) {
                const USART4Mult_clk_value = USART4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART4Mult",
                    "Else",
                    "No Extra Log",
                    "USART4CLockSelection",
                });
                const USART4Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
                };
                USART4Mult.nodetype = .multi;
                USART4Mult.parents = &.{USART4Multparents[USART4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART4EnableValue), USART4EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART4Freq_ValueValue);
                USART4output.limit = USART4Freq_ValueLimit;
                USART4output.nodetype = .output;
                USART4output.parents = &.{&USART4Mult};
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
                    &DIVP4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &DIVR3,
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
                    &DIVP4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &DIVR3,
                };
                SPI23Mult.nodetype = .multi;
                SPI23Mult.parents = &.{SPI23Multparents[SPI23Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI23Freq_ValueValue);
                SPI23output.limit = SPI23Freq_ValueLimit;
                SPI23output.nodetype = .output;
                SPI23output.parents = &.{&SPI23Mult};
            }
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"="))
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
                    &DIVQ4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &DIVR3,
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
            if (check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDFAFreq_ValueValue);
                DFSDF1Audiooutput.limit = DFSDFAFreq_ValueLimit;
                DFSDF1Audiooutput.nodetype = .output;
                DFSDF1Audiooutput.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=")) {
                const SPI5Mult_clk_value = SPI5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI5Mult",
                    "Else",
                    "No Extra Log",
                    "SPI5CLockSelection",
                });
                const SPI5Multparents = [_]*const ClockNode{
                    &APB6DIV,
                    &DIVQ4,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                };
                SPI5Mult.nodetype = .multi;
                SPI5Mult.parents = &.{SPI5Multparents[SPI5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI5Freq_ValueValue);
                SPI5output.limit = SPI5Freq_ValueLimit;
                SPI5output.nodetype = .output;
                SPI5output.parents = &.{&SPI5Mult};
            }
            if (check_MCU("FDCAN1_Exist") or check_MCU("FDCAN2_Exist")) {
                if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                    const FDCANMult_clk_value = FDCANCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "FDCANMult",
                        "FDCAN1_Exist | FDCAN2_Exist",
                        "No Extra Log",
                        "FDCANCLockSelection",
                    });
                    const FDCANMultparents = [_]*const ClockNode{
                        &HSEOSC,
                        &DIVQ3,
                        &DIVQ4,
                        &DIVR4,
                    };
                    FDCANMult.nodetype = .multi;
                    FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
                }
            }
            if (check_MCU("FDCAN1_Exist") or check_MCU("FDCAN2_Exist")) {
                if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                    FDCANoutput.limit = FDCANFreq_ValueLimit;
                    FDCANoutput.nodetype = .output;
                    FDCANoutput.parents = &.{&FDCANMult};
                }
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
                    &DIVP4,
                    &DIVQ3,
                };
                ETH1Mult.nodetype = .multi;
                ETH1Mult.parents = &.{ETH1Multparents[ETH1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ETHFreq_ValueValue);
                ETH1output.limit = ETHFreq_ValueLimit;
                ETH1output.nodetype = .output;
                ETH1output.parents = &.{&ETH1Mult};
            }
            if (check_MCU("ETH2_Exist")) {
                if (check_ref(@TypeOf(ETH2EnableValue), ETH2EnableValue, .true, .@"=")) {
                    const ETH2Mult_clk_value = ETH2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "ETH2Mult",
                        "ETH2_Exist",
                        "No Extra Log",
                        "ETH2CLockSelection",
                    });
                    const ETH2Multparents = [_]*const ClockNode{
                        &DIVP4,
                        &DIVQ3,
                    };
                    ETH2Mult.nodetype = .multi;
                    ETH2Mult.parents = &.{ETH2Multparents[ETH2Mult_clk_value.get()]};
                }
            }
            if (check_MCU("ETH2_Exist")) {
                if (check_ref(@TypeOf(ETH2EnableValue), ETH2EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(ETH2Freq_ValueValue);
                    ETH2output.limit = ETH2Freq_ValueLimit;
                    ETH2output.nodetype = .output;
                    ETH2output.parents = &.{&ETH2Mult};
                }
            }
            if (check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=")) {
                const ADC2Mult_clk_value = ADC2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADC2Mult",
                    "Else",
                    "No Extra Log",
                    "ADC2CLockSelection",
                });
                const ADC2Multparents = [_]*const ClockNode{
                    &DIVR4,
                    &CKPERCLKOutput,
                    &DIVQ3,
                };
                ADC2Mult.nodetype = .multi;
                ADC2Mult.parents = &.{ADC2Multparents[ADC2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADC2Freq_ValueValue);
                ADC2output.limit = ADC2Freq_ValueLimit;
                ADC2output.nodetype = .output;
                ADC2output.parents = &.{&ADC2Mult};
            }
            if (check_MCU("ADC1_Exist")) {
                if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=")) {
                    const ADC1Mult_clk_value = ADC1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "ADC1Mult",
                        "ADC1_Exist",
                        "No Extra Log",
                        "ADC1CLockSelection",
                    });
                    const ADC1Multparents = [_]*const ClockNode{
                        &DIVR4,
                        &CKPERCLKOutput,
                        &DIVQ3,
                    };
                    ADC1Mult.nodetype = .multi;
                    ADC1Mult.parents = &.{ADC1Multparents[ADC1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("ADC1_Exist")) {
                if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(ADC1Freq_ValueValue);
                    ADC1output.limit = ADC1Freq_ValueLimit;
                    ADC1output.nodetype = .output;
                    ADC1output.parents = &.{&ADC1Mult};
                }
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DDRPHYFreq_ValueValue);
                DDRPHYC.nodetype = .output;
                DDRPHYC.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PUBLFreq_ValueValue);
                PUBL.nodetype = .output;
                PUBL.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DDRCFreq_ValueValue);
                DDRC.limit = DDRCFreq_ValueLimit;
                DDRC.nodetype = .output;
                DDRC.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DDRPERFMFreq_ValueValue);
                DDRPERFM.limit = DDRPERFMFreq_ValueLimit;
                DDRPERFM.nodetype = .output;
                DDRPERFM.parents = &.{&DIVR2};
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
            if (check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBHSValue), EnableUSBHSValue, .true, .@"="))
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
                    &HSEUSBPHYDevisor,
                    &HSEOSC,
                    &DIVR4,
                };
                USBPHYCLKMux.nodetype = .multi;
                USBPHYCLKMux.parents = &.{USBPHYCLKMuxparents[USBPHYCLKMux_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBHSValue), EnableUSBHSValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(USBPHYFreq_ValueValue);
                USBPHYCLKOutput.nodetype = .output;
                USBPHYCLKOutput.parents = &.{&USBPHYCLKMux};
            }
            if (check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=")) {
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
                const USBOCLKMux_clk_value = USBOCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBOCLKMux",
                    "Else",
                    "No Extra Log",
                    "USBOCLKSource",
                });
                const USBOCLKMuxparents = [_]*const ClockNode{
                    &DIVR4,
                    &USBPHYRC,
                };
                USBOCLKMux.nodetype = .multi;
                USBOCLKMux.parents = &.{USBOCLKMuxparents[USBOCLKMux_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBOHSFreq_ValueValue);
                USBOFSCLKOutput.nodetype = .output;
                USBOFSCLKOutput.parents = &.{&USBOCLKMux};
            }

            std.mem.doNotOptimizeAway(HSIDivClkFreq_ValueValue);
            HSIDivClk.nodetype = .output;
            HSIDivClk.parents = &.{&HSIDiv};

            std.mem.doNotOptimizeAway(VCOInput1Freq_ValueValue);
            VCOInput.limit = VCOInput1Freq_ValueLimit;
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&DIVM1};

            std.mem.doNotOptimizeAway(VCOInput2Freq_ValueValue);
            VCO2Input.limit = VCOInput2Freq_ValueLimit;
            VCO2Input.nodetype = .output;
            VCO2Input.parents = &.{&DIVM2};

            std.mem.doNotOptimizeAway(VCOInput3Freq_ValueValue);
            VCO3Input.limit = VCOInput3Freq_ValueLimit;
            VCO3Input.nodetype = .output;
            VCO3Input.parents = &.{&DIVM3};

            std.mem.doNotOptimizeAway(VCOInput4Freq_ValueValue);
            VCO4Input.limit = VCOInput4Freq_ValueLimit;
            VCO4Input.nodetype = .output;
            VCO4Input.parents = &.{&DIVM4};

            std.mem.doNotOptimizeAway(VCO1OutputFreq_ValueValue);
            VCO1Output.limit = VCO1OutputFreq_ValueLimit;
            VCO1Output.nodetype = .output;
            VCO1Output.parents = &.{&DIVN1};

            std.mem.doNotOptimizeAway(DIVP1Freq_ValueValue);
            PLL1CLK.limit = DIVP1Freq_ValueLimit;
            PLL1CLK.nodetype = .output;
            PLL1CLK.parents = &.{&DIVP1};

            std.mem.doNotOptimizeAway(VCO2OutputFreq_ValueValue);
            VCO2Output.limit = VCO2OutputFreq_ValueLimit;
            VCO2Output.nodetype = .output;
            VCO2Output.parents = &.{&DIVN2};

            std.mem.doNotOptimizeAway(DIVP2Freq_ValueValue);
            PLL2CLK.limit = DIVP2Freq_ValueLimit;
            PLL2CLK.nodetype = .output;
            PLL2CLK.parents = &.{&DIVP2};

            std.mem.doNotOptimizeAway(VCO3OutputFreq_ValueValue);
            VCO3Output.limit = VCO3OutputFreq_ValueLimit;
            VCO3Output.nodetype = .output;
            VCO3Output.parents = &.{&DIVN3};

            std.mem.doNotOptimizeAway(VCO4OutputFreq_ValueValue);
            VCO4Output.limit = VCO4OutputFreq_ValueLimit;
            VCO4Output.nodetype = .output;
            VCO4Output.parents = &.{&DIVN4};

            std.mem.doNotOptimizeAway(DIVP3Freq_ValueValue);
            PLL3CLK.limit = DIVP3Freq_ValueLimit;
            PLL3CLK.nodetype = .output;
            PLL3CLK.parents = &.{&DIVP3};

            std.mem.doNotOptimizeAway(MLAHBDIVCLKFreq_ValueValue);
            MLAHBDIVCLK.limit = MLAHBDIVCLKFreq_ValueLimit;
            MLAHBDIVCLK.nodetype = .output;
            MLAHBDIVCLK.parents = &.{&MLAHBDIV};

            out.MLAHBClockOutput = try MLAHBClockOutput.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.LPTIM45output = try LPTIM45output.get_output();
            out.LPTIM45Mult = try LPTIM45Mult.get_output();
            out.APB3DIV = try APB3DIV.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.Tim1Output = try Tim1Output.get_output();
            out.Tim1Mul = try Tim1Mul.get_output();
            out.I2C12output = try I2C12output.get_output();
            out.I2C12Mult = try I2C12Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.USART2output = try USART2output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART35output = try USART35output.get_output();
            out.USART35Mult = try USART35Mult.get_output();
            out.USART78output = try USART78output.get_output();
            out.UART78Mult = try UART78Mult.get_output();
            out.APB1DIV = try APB1DIV.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.Tim2Output = try Tim2Output.get_output();
            out.Tim2Mul = try Tim2Mul.get_output();
            out.SPI4output = try SPI4output.get_output();
            out.SPI4Mult = try SPI4Mult.get_output();
            out.USART6output = try USART6output.get_output();
            out.USART6Mult = try USART6Mult.get_output();
            out.APB2DIV = try APB2DIV.get_output();
            out.APB6DIVOutput = try APB6DIVOutput.get_output();
            out.Tim3Output = try Tim3Output.get_output();
            out.Tim3Mul = try Tim3Mul.get_output();
            out.APB6DIV = try APB6DIV.get_output();
            out.SDMMC2output = try SDMMC2output.get_output();
            out.SDMMC2Mult = try SDMMC2Mult.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.DFSDM1Output = try DFSDM1Output.get_output();
            out.MLAHBDIV = try MLAHBDIV.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.DIVP3 = try DIVP3.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.DIVQ3output = try DIVQ3output.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.DFSDF1Audiooutput = try DFSDF1Audiooutput.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.SPI23output = try SPI23output.get_output();
            out.SPI23Mult = try SPI23Mult.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.SPDIFMult = try SPDIFMult.get_output();
            out.ETH1output = try ETH1output.get_output();
            out.ETH1Mult = try ETH1Mult.get_output();
            out.DIVQ3 = try DIVQ3.get_output();
            out.DIVR3output = try DIVR3output.get_output();
            out.FMCoutput = try FMCoutput.get_output();
            out.FMCMult = try FMCMult.get_output();
            out.QSPIoutput = try QSPIoutput.get_output();
            out.QSPIMult = try QSPIMult.get_output();
            out.SDMMC1output = try SDMMC1output.get_output();
            out.SDMMC1Mult = try SDMMC1Mult.get_output();
            out.DIVR3 = try DIVR3.get_output();
            out.DIVN3 = try DIVN3.get_output();
            out.DIVM3 = try DIVM3.get_output();
            out.PLL3Source = try PLL3Source.get_output();
            out.DIVP4output = try DIVP4output.get_output();
            out.DIVP4 = try DIVP4.get_output();
            out.DIVQ4output = try DIVQ4output.get_output();
            out.LTDCOutput = try LTDCOutput.get_output();
            out.DIVQ4 = try DIVQ4.get_output();
            out.DIVR4output = try DIVR4output.get_output();
            out.RNG1output = try RNG1output.get_output();
            out.RNG1Mult = try RNG1Mult.get_output();
            out.USBPHYCLKOutput = try USBPHYCLKOutput.get_output();
            out.USBPHYCLKMux = try USBPHYCLKMux.get_output();
            out.USBOFSCLKOutput = try USBOFSCLKOutput.get_output();
            out.USBOCLKMux = try USBOCLKMux.get_output();
            out.ADC2output = try ADC2output.get_output();
            out.ADC2Mult = try ADC2Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.I2C5output = try I2C5output.get_output();
            out.I2C5Mult = try I2C5Mult.get_output();
            out.DIVR4 = try DIVR4.get_output();
            out.DIVN4 = try DIVN4.get_output();
            out.DIVM4 = try DIVM4.get_output();
            out.PLL4Source = try PLL4Source.get_output();
            out.MPUCLKOutput = try MPUCLKOutput.get_output();
            out.MPUMult = try MPUMult.get_output();
            out.MPUDIV = try MPUDIV.get_output();
            out.DIVP1 = try DIVP1.get_output();
            out.DIVQ1output = try DIVQ1output.get_output();
            out.DIVQ1 = try DIVQ1.get_output();
            out.DIVR1output = try DIVR1output.get_output();
            out.DIVR1 = try DIVR1.get_output();
            out.DIVN1Mul2Div2 = try DIVN1Mul2Div2.get_output();
            out.DIVN1 = try DIVN1.get_output();
            out.FreqCk1 = try FreqCk1.get_output();
            out.DIVM1 = try DIVM1.get_output();
            out.AXIOutput = try AXIOutput.get_output();
            out.Hclk5Output = try Hclk5Output.get_output();
            out.Hclk6Output = try Hclk6Output.get_output();
            out.APB4DIVOutput = try APB4DIVOutput.get_output();
            out.APB4DIV = try APB4DIV.get_output();
            out.APB5DIVOutput = try APB5DIVOutput.get_output();
            out.APB5DIV = try APB5DIV.get_output();
            out.AXIDIV = try AXIDIV.get_output();
            out.AXICLKOutput = try AXICLKOutput.get_output();
            out.AXIMult = try AXIMult.get_output();
            out.DIVP2 = try DIVP2.get_output();
            out.DIVQ2output = try DIVQ2output.get_output();
            out.DCMIoutput = try DCMIoutput.get_output();
            out.DCMIMult = try DCMIMult.get_output();
            out.DIVQ2 = try DIVQ2.get_output();
            out.DIVR2output = try DIVR2output.get_output();
            out.DDRPHYC = try DDRPHYC.get_output();
            out.DIVR2 = try DIVR2.get_output();
            out.DIVN2Mul2Div2 = try DIVN2Mul2Div2.get_output();
            out.DIVN2 = try DIVN2.get_output();
            out.FreqCk2 = try FreqCk2.get_output();
            out.DIVM2 = try DIVM2.get_output();
            out.PLL12Source = try PLL12Source.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.CKPERCLKOutput = try CKPERCLKOutput.get_output();
            out.CKPERMult = try CKPERMult.get_output();
            out.STGENoutput = try STGENoutput.get_output();
            out.STGENMult = try STGENMult.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEUSBPHYDevisor = try HSEUSBPHYDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.ADC1output = try ADC1output.get_output();
            out.ADC1Mult = try ADC1Mult.get_output();
            out.DACCLKOutput = try DACCLKOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.PLL1FRACV = try PLL1FRACV.get_output();
            out.PLL2FRACV = try PLL2FRACV.get_output();
            out.PLL3FRACV = try PLL3FRACV.get_output();
            out.PLL4FRACV = try PLL4FRACV.get_output();
            out.SAESoutput = try SAESoutput.get_output();
            out.SAESMult = try SAESMult.get_output();
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.USART4output = try USART4output.get_output();
            out.USART4Mult = try USART4Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SPI5output = try SPI5output.get_output();
            out.SPI5Mult = try SPI5Mult.get_output();
            out.ETH2output = try ETH2output.get_output();
            out.ETH2Mult = try ETH2Mult.get_output();
            out.PUBL = try PUBL.get_output();
            out.DDRC = try DDRC.get_output();
            out.DDRPERFM = try DDRPERFM.get_output();
            out.USBPHYRC = try USBPHYRC.get_output();
            out.HSIDivClk = try HSIDivClk.get_extra_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCO2Input = try VCO2Input.get_extra_output();
            out.VCO3Input = try VCO3Input.get_extra_output();
            out.VCO4Input = try VCO4Input.get_extra_output();
            out.VCO1Output = try VCO1Output.get_extra_output();
            out.PLL1CLK = try PLL1CLK.get_extra_output();
            out.VCO2Output = try VCO2Output.get_extra_output();
            out.PLL2CLK = try PLL2CLK.get_extra_output();
            out.VCO3Output = try VCO3Output.get_extra_output();
            out.VCO4Output = try VCO4Output.get_extra_output();
            out.PLL3CLK = try PLL3CLK.get_extra_output();
            out.MLAHBDIVCLK = try MLAHBDIVCLK.get_extra_output();
            ref_out.HSIDivValue = HSIDivValueValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.MLAHBCLKSource = MLAHBCLKSourceValue;
            ref_out.MPUCLKSource = MPUCLKSourceValue;
            ref_out.CKPERCLKSource = CKPERCLKSourceValue;
            ref_out.AXICLKSource = AXICLKSourceValue;
            ref_out.AXI_Div = AXI_DivValue;
            ref_out.APB4DIV = APB4DIVValue;
            ref_out.APB5DIV = APB5DIVValue;
            ref_out.APB6DIV = APB6DIVValue;
            ref_out.Tim3Mul = Tim3MulValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.MLAHB_Div = MLAHB_DivValue;
            ref_out.APB3DIV = APB3DIVValue;
            ref_out.APB1DIV = APB1DIVValue;
            ref_out.Tim1Mul = Tim1MulValue;
            ref_out.APB2DIV = APB2DIVValue;
            ref_out.Tim2Mul = Tim2MulValue;
            ref_out.PLL12Source = PLL12SourceValue;
            ref_out.DIVM1 = DIVM1Value;
            ref_out.DIVM2 = DIVM2Value;
            ref_out.PLL3Source = PLL3SourceValue;
            ref_out.DIVM3 = DIVM3Value;
            ref_out.PLL4Source = PLL4SourceValue;
            ref_out.DIVM4 = DIVM4Value;
            ref_out.MPU_Div = MPU_DivValue;
            ref_out.FreqCk1 = FreqCk1Value;
            ref_out.DIVN1 = DIVN1Value;
            ref_out.PLL1FRACV = PLL1FRACVValue;
            ref_out.VCO1DIV2 = VCO1DIV2Value;
            ref_out.DIVP1 = DIVP1Value;
            ref_out.DIVQ1 = DIVQ1Value;
            ref_out.DIVR1 = DIVR1Value;
            ref_out.FreqCk2 = FreqCk2Value;
            ref_out.DIVN2 = DIVN2Value;
            ref_out.PLL2FRACV = PLL2FRACVValue;
            ref_out.VCO2DIV2 = VCO2DIV2Value;
            ref_out.DIVP2 = DIVP2Value;
            ref_out.DIVQ2 = DIVQ2Value;
            ref_out.DIVR2 = DIVR2Value;
            ref_out.DIVN3 = DIVN3Value;
            ref_out.PLL3FRACV = PLL3FRACVValue;
            ref_out.DIVP3 = DIVP3Value;
            ref_out.DIVQ3 = DIVQ3Value;
            ref_out.DIVR3 = DIVR3Value;
            ref_out.DIVN4 = DIVN4Value;
            ref_out.PLL4FRACV = PLL4FRACVValue;
            ref_out.DIVP4 = DIVP4Value;
            ref_out.DIVQ4 = DIVQ4Value;
            ref_out.DIVR4 = DIVR4Value;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.I2C12CLockSelection = I2C12CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.I2C5CLockSelection = I2C5CLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.QSPICLockSelection = QSPICLockSelectionValue;
            ref_out.FMCCLockSelection = FMCCLockSelectionValue;
            ref_out.SDMMC1CLockSelection = SDMMC1CLockSelectionValue;
            ref_out.SDMMC2CLockSelection = SDMMC2CLockSelectionValue;
            ref_out.STGENCLockSelection = STGENCLockSelectionValue;
            ref_out.LPTIM45CLockSelection = LPTIM45CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.USART35CLockSelection = USART35CLockSelectionValue;
            ref_out.USART6CLockSelection = USART6CLockSelectionValue;
            ref_out.UART78CLockSelection = UART78CLockSelectionValue;
            ref_out.RNG1CLockSelection = RNG1CLockSelectionValue;
            ref_out.DCMICLockSelection = DCMICLockSelectionValue;
            ref_out.SAESCLockSelection = SAESCLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.SPI4CLockSelection = SPI4CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.USART4CLockSelection = USART4CLockSelectionValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI23CLockSelection = SPI23CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SPI5CLockSelection = SPI5CLockSelectionValue;
            ref_out.FDCANCLockSelection = FDCANCLockSelectionValue;
            ref_out.ETH1CLockSelection = ETH1CLockSelectionValue;
            ref_out.ETH2CLockSelection = ETH2CLockSelectionValue;
            ref_out.ADC2CLockSelection = ADC2CLockSelectionValue;
            ref_out.ADC1CLockSelection = ADC1CLockSelectionValue;
            ref_out.RCC_USBPHY_Clock_Source_FROM_HSE = RCC_USBPHY_Clock_Source_FROM_HSEValue;
            ref_out.USBPHYCLKSource = USBPHYCLKSourceValue;
            ref_out.USBOCLKSource = USBOCLKSourceValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.CSICalibrationValue = CSICalibrationValueValue;
            ref_out.RCC_TIM_G1_PRescaler_Selection = RCC_TIM_G1_PRescaler_SelectionValue;
            ref_out.RCC_TIM_G2_PRescaler_Selection = RCC_TIM_G2_PRescaler_SelectionValue;
            ref_out.RCC_TIM_G3_PRescaler_Selection = RCC_TIM_G3_PRescaler_SelectionValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.PLL1UserDefinedConfig = PLL1UserDefinedConfigValue;
            ref_out.PLL1Used = PLL1UsedValue;
            ref_out.PLL2Used = PLL2UsedValue;
            ref_out.PLL3Used = PLL3UsedValue;
            ref_out.PLL4Used = PLL4UsedValue;
            ref_out.PLL1MODE = PLL1MODEValue;
            ref_out.PLL2MODE = PLL2MODEValue;
            ref_out.PLL3MODE = PLL3MODEValue;
            ref_out.PLL4MODE = PLL4MODEValue;
            ref_out.PLL1CSG = PLL1CSGValue;
            ref_out.PLL2CSG = PLL2CSGValue;
            ref_out.PLL3CSG = PLL3CSGValue;
            ref_out.PLL4CSG = PLL4CSGValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.PLL1UserDefinedConfigEnable = PLL1UserDefinedConfigEnableValue;
            ref_out.cKPerEnable = cKPerEnableValue;
            ref_out.DACEnable = DACEnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.DFSDMEnable = DFSDMEnableValue;
            ref_out.DCMIEnable = DCMIEnableValue;
            ref_out.DDREnable = DDREnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.ADC2Enable = ADC2EnableValue;
            ref_out.ADC1Enable = ADC1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.ETH1Enable = ETH1EnableValue;
            ref_out.ETH2Enable = ETH2EnableValue;
            ref_out.EnableDFSDMAudio = EnableDFSDMAudioValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.SPDIFEnable = SPDIFEnableValue;
            ref_out.SAI2Enable = SAI2EnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.LPTIM45Enable = LPTIM45EnableValue;
            ref_out.SPI1Enable = SPI1EnableValue;
            ref_out.SPI23Enable = SPI23EnableValue;
            ref_out.SPI4Enable = SPI4EnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.SDMMC1Enable = SDMMC1EnableValue;
            ref_out.SDMMC2Enable = SDMMC2EnableValue;
            ref_out.QuadSPIEnable = QuadSPIEnableValue;
            ref_out.FMCEnable = FMCEnableValue;
            ref_out.LTDCEnable = LTDCEnableValue;
            ref_out.USART4Enable = USART4EnableValue;
            ref_out.SPI5Enable = SPI5EnableValue;
            ref_out.UART78Enable = UART78EnableValue;
            ref_out.USART35Enable = USART35EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.LPTIM3Enable = LPTIM3EnableValue;
            ref_out.USART6Enable = USART6EnableValue;
            ref_out.SAESEnable = SAESEnableValue;
            ref_out.I2C4Enable = I2C4EnableValue;
            ref_out.I2C5Enable = I2C5EnableValue;
            ref_out.EnableUSBOHS = EnableUSBOHSValue;
            ref_out.EnableUSBHS = EnableUSBHSValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.I2C12Enable = I2C12EnableValue;
            ref_out.RNG1Enable = RNG1EnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.STGENEnable = STGENEnableValue;
            ref_out.EnableHSEUSBPHYDevisor = EnableHSEUSBPHYDevisorValue;
            ref_out.Max650 = Max650Value;
            ref_out.PLL2RUsed = PLL2RUsedValue;
            ref_out.PLL3QUsed = PLL3QUsedValue;
            ref_out.PLL3RUsed = PLL3RUsedValue;
            ref_out.PLL4PUsed = PLL4PUsedValue;
            ref_out.PLL4QUsed = PLL4QUsedValue;
            ref_out.PLL4RUsed = PLL4RUsedValue;
            ref_out.PLL2PUsed = PLL2PUsedValue;
            ref_out.PLL3PUsed = PLL3PUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.PLL1UsedTFA = PLL1UsedTFAValue;
            ref_out.PLL1UsedA7 = PLL1UsedA7Value;
            ref_out.PLL2UsedTFA = PLL2UsedTFAValue;
            ref_out.PLL2UsedA7 = PLL2UsedA7Value;
            ref_out.PLL3UsedTFA = PLL3UsedTFAValue;
            ref_out.PLL3UsedA7 = PLL3UsedA7Value;
            ref_out.PLL4UsedTFA = PLL4UsedTFAValue;
            ref_out.PLL4UsedA7 = PLL4UsedA7Value;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.CECEnable = CECEnableValue;
            ref_out.MCO2I2SEnable = MCO2I2SEnableValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
