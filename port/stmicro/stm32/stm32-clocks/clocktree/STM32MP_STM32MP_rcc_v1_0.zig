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

pub const MCUCLKSourceList = enum {
    RCC_MCUSSOURCE_HSI,
    RCC_MCUSSOURCE_CSI,
    RCC_MCUSSOURCE_HSE,
    RCC_MCUSSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCUSSOURCE_HSI => 0,
            .RCC_MCUSSOURCE_CSI => 1,
            .RCC_MCUSSOURCE_HSE => 2,
            .RCC_MCUSSOURCE_PLL3 => 3,
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
    RCC_MCO2SOURCE_MCU,
    RCC_MCO2SOURCE_PLL4,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_MPU => 0,
            .RCC_MCO2SOURCE_AXI => 1,
            .RCC_MCO2SOURCE_MCU => 2,
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
pub const DSICLockSelectionList = enum {
    RCC_DSICLKSOURCE_PLL4,
    RCC_DSICLKSOURCE_PHY,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DSICLKSOURCE_PLL4 => 0,
            .RCC_DSICLKSOURCE_PHY => 1,
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
pub const I2C35CLockSelectionList = enum {
    RCC_I2C35CLKSOURCE_PCLK1,
    RCC_I2C35CLKSOURCE_PLL4,
    RCC_I2C35CLKSOURCE_HSI,
    RCC_I2C35CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C35CLKSOURCE_PCLK1 => 0,
            .RCC_I2C35CLKSOURCE_PLL4 => 1,
            .RCC_I2C35CLKSOURCE_HSI => 2,
            .RCC_I2C35CLKSOURCE_CSI => 3,
        };
    }
};
pub const I2C46CLockSelectionList = enum {
    RCC_I2C46CLKSOURCE_PCLK5,
    RCC_I2C46CLKSOURCE_PLL3,
    RCC_I2C46CLKSOURCE_HSI,
    RCC_I2C46CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C46CLKSOURCE_PCLK5 => 0,
            .RCC_I2C46CLKSOURCE_PLL3 => 1,
            .RCC_I2C46CLKSOURCE_HSI => 2,
            .RCC_I2C46CLKSOURCE_CSI => 3,
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
pub const SDMMC12CLockSelectionList = enum {
    RCC_SDMMC12CLKSOURCE_HCLK6,
    RCC_SDMMC12CLKSOURCE_PLL3,
    RCC_SDMMC12CLKSOURCE_PLL4,
    RCC_SDMMC12CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC12CLKSOURCE_HCLK6 => 0,
            .RCC_SDMMC12CLKSOURCE_PLL3 => 1,
            .RCC_SDMMC12CLKSOURCE_PLL4 => 2,
            .RCC_SDMMC12CLKSOURCE_HSI => 3,
        };
    }
};
pub const SDMMC3CLockSelectionList = enum {
    RCC_SDMMC3CLKSOURCE_HCLK2,
    RCC_SDMMC3CLKSOURCE_PLL3,
    RCC_SDMMC3CLKSOURCE_PLL4,
    RCC_SDMMC3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC3CLKSOURCE_HCLK2 => 0,
            .RCC_SDMMC3CLKSOURCE_PLL3 => 1,
            .RCC_SDMMC3CLKSOURCE_PLL4 => 2,
            .RCC_SDMMC3CLKSOURCE_HSI => 3,
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
pub const LPTIM23CLockSelectionList = enum {
    RCC_LPTIM23CLKSOURCE_PCLK3,
    RCC_LPTIM23CLKSOURCE_PLL4,
    RCC_LPTIM23CLKSOURCE_PER,
    RCC_LPTIM23CLKSOURCE_LSE,
    RCC_LPTIM23CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM23CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM23CLKSOURCE_PLL4 => 1,
            .RCC_LPTIM23CLKSOURCE_PER => 2,
            .RCC_LPTIM23CLKSOURCE_LSE => 3,
            .RCC_LPTIM23CLKSOURCE_LSI => 4,
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
    RCC_USART1CLKSOURCE_PCLK5,
    RCC_USART1CLKSOURCE_PLL4,
    RCC_USART1CLKSOURCE_PLL3,
    RCC_USART1CLKSOURCE_HSE,
    RCC_USART1CLKSOURCE_CSI,
    RCC_USART1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK5 => 0,
            .RCC_USART1CLKSOURCE_PLL4 => 1,
            .RCC_USART1CLKSOURCE_PLL3 => 2,
            .RCC_USART1CLKSOURCE_HSE => 3,
            .RCC_USART1CLKSOURCE_CSI => 4,
            .RCC_USART1CLKSOURCE_HSI => 5,
        };
    }
};
pub const USART24CLockSelectionList = enum {
    RCC_UART24CLKSOURCE_PCLK1,
    RCC_UART24CLKSOURCE_PLL4,
    RCC_UART24CLKSOURCE_HSE,
    RCC_UART24CLKSOURCE_CSI,
    RCC_UART24CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART24CLKSOURCE_PCLK1 => 0,
            .RCC_UART24CLKSOURCE_PLL4 => 1,
            .RCC_UART24CLKSOURCE_HSE => 2,
            .RCC_UART24CLKSOURCE_CSI => 3,
            .RCC_UART24CLKSOURCE_HSI => 4,
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
    RCC_RNG1CLKSOURCE_LSE,
    RCC_RNG1CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNG1CLKSOURCE_CSI => 0,
            .RCC_RNG1CLKSOURCE_PLL4 => 1,
            .RCC_RNG1CLKSOURCE_LSE => 2,
            .RCC_RNG1CLKSOURCE_LSI => 3,
        };
    }
};
pub const RNG2CLockSelectionList = enum {
    RCC_RNG2CLKSOURCE_CSI,
    RCC_RNG2CLKSOURCE_PLL4,
    RCC_RNG2CLKSOURCE_LSE,
    RCC_RNG2CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNG2CLKSOURCE_CSI => 0,
            .RCC_RNG2CLKSOURCE_PLL4 => 1,
            .RCC_RNG2CLKSOURCE_LSE => 2,
            .RCC_RNG2CLKSOURCE_LSI => 3,
        };
    }
};
pub const SPI6CLockSelectionList = enum {
    RCC_SPI6CLKSOURCE_PCLK5,
    RCC_SPI6CLKSOURCE_PLL4,
    RCC_SPI6CLKSOURCE_PLL3,
    RCC_SPI6CLKSOURCE_HSI,
    RCC_SPI6CLKSOURCE_CSI,
    RCC_SPI6CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_PCLK5 => 0,
            .RCC_SPI6CLKSOURCE_PLL4 => 1,
            .RCC_SPI6CLKSOURCE_PLL3 => 2,
            .RCC_SPI6CLKSOURCE_HSI => 3,
            .RCC_SPI6CLKSOURCE_CSI => 4,
            .RCC_SPI6CLKSOURCE_HSE => 5,
        };
    }
};
pub const SPI45CLockSelectionList = enum {
    RCC_SPI45CLKSOURCE_PCLK2,
    RCC_SPI45CLKSOURCE_PLL4,
    RCC_SPI45CLKSOURCE_HSI,
    RCC_SPI45CLKSOURCE_CSI,
    RCC_SPI45CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI45CLKSOURCE_PCLK2 => 0,
            .RCC_SPI45CLKSOURCE_PLL4 => 1,
            .RCC_SPI45CLKSOURCE_HSI => 2,
            .RCC_SPI45CLKSOURCE_CSI => 3,
            .RCC_SPI45CLKSOURCE_HSE => 4,
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
pub const SAI4CLockSelectionList = enum {
    RCC_SAI4CLKSOURCE_PLL4,
    RCC_SAI4CLKSOURCE_PLL3_Q,
    RCC_SAI4CLKSOURCE_I2SCKIN,
    RCC_SAI4CLKSOURCE_PER,
    RCC_SAI4CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI4CLKSOURCE_PLL4 => 0,
            .RCC_SAI4CLKSOURCE_PLL3_Q => 1,
            .RCC_SAI4CLKSOURCE_I2SCKIN => 2,
            .RCC_SAI4CLKSOURCE_PER => 3,
            .RCC_SAI4CLKSOURCE_PLL3_R => 4,
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
pub const SAI3CLockSelectionList = enum {
    RCC_SAI3CLKSOURCE_PLL4,
    RCC_SAI3CLKSOURCE_PLL3_Q,
    RCC_SAI3CLKSOURCE_I2SCKIN,
    RCC_SAI3CLKSOURCE_PER,
    RCC_SAI3CLKSOURCE_PLL3_R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI3CLKSOURCE_PLL4 => 0,
            .RCC_SAI3CLKSOURCE_PLL3_Q => 1,
            .RCC_SAI3CLKSOURCE_I2SCKIN => 2,
            .RCC_SAI3CLKSOURCE_PER => 3,
            .RCC_SAI3CLKSOURCE_PLL3_R => 4,
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
    RCC_ETHCLKSOURCE_PLL4,
    RCC_ETHCLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETHCLKSOURCE_PLL4 => 0,
            .RCC_ETHCLKSOURCE_PLL3 => 1,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_PLL4,
    RCC_ADCCLKSOURCE_PER,
    RCC_ADCCLKSOURCE_PLL3,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_PLL4 => 0,
            .RCC_ADCCLKSOURCE_PER => 1,
            .RCC_ADCCLKSOURCE_PLL3 => 2,
        };
    }
};
pub const CECCLockSelectionList = enum {
    CSICECDevisor,
    RCC_CECCLKSOURCE_LSE,
    RCC_CECCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .CSICECDevisor => 0,
            .RCC_CECCLKSOURCE_LSE => 1,
            .RCC_CECCLKSOURCE_LSI => 2,
        };
    }
};
pub const USBPHYCLKSourceList = enum {
    HSEUSBPHYDevisor,
    RCC_USBPHYCLKSOURCE_HSE,
    RCC_USBPHYCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .HSEUSBPHYDevisor => 0,
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
pub const MCU_DivList = enum {
    RCC_MCU_DIV1,
    RCC_MCU_DIV2,
    RCC_MCU_DIV4,
    RCC_MCU_DIV8,
    RCC_MCU_DIV16,
    RCC_MCU_DIV32,
    RCC_MCU_DIV64,
    RCC_MCU_DIV128,
    RCC_MCU_DIV256,
    RCC_MCU_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCU_DIV1 => 1,
            .RCC_MCU_DIV2 => 2,
            .RCC_MCU_DIV4 => 4,
            .RCC_MCU_DIV8 => 8,
            .RCC_MCU_DIV16 => 16,
            .RCC_MCU_DIV32 => 32,
            .RCC_MCU_DIV64 => 64,
            .RCC_MCU_DIV128 => 128,
            .RCC_MCU_DIV256 => 256,
            .RCC_MCU_DIV512 => 512,
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
pub const RCC_CEC_Clock_Source_FROM_CSIList = enum {
    RCC_CECCLKSOURCE_CSI122,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_CECCLKSOURCE_CSI122 => 122,
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
pub const RCC_TIM_G1_PRescaler_SelectionList = enum {
    RCC_TIMG1PRES_ACTIVATED,
    RCC_TIMG1PRES_DEACTIVATED,
};
pub const RCC_TIM_G2_PRescaler_SelectionList = enum {
    RCC_TIMG2PRES_ACTIVATED,
    RCC_TIMG2PRES_DEACTIVATED,
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
pub const GPUEnableList = enum {
    true,
    false,
};
pub const DDREnableList = enum {
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
pub const ETH1EnableList = enum {
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
pub const I2C46EnableList = enum {
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
pub const SAI3EnableList = enum {
    true,
    false,
};
pub const SAI4EnableList = enum {
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
pub const SPI6EnableList = enum {
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
pub const SPI45EnableList = enum {
    true,
    false,
};
pub const FDCANEnableList = enum {
    true,
    false,
};
pub const SDMMC12EnableList = enum {
    true,
    false,
};
pub const SDMMC3EnableList = enum {
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
pub const EnablePLLRDSIList = enum {
    false,
};
pub const EnableHSEDSIList = enum {
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
pub const USART24EnableList = enum {
    true,
    false,
};
pub const LPTIM23EnableList = enum {
    true,
    false,
};
pub const USART6EnableList = enum {
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
pub const I2C35EnableList = enum {
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
pub const RNG2EnableList = enum {
    true,
    false,
};
pub const DCMIEnableList = enum {
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
pub const CECEnableList = enum {
    true,
    false,
};
pub const EnableHSEUSBPHYDevisorList = enum {
    true,
    false,
};
pub const Max650List = enum {
    true,
    false,
};
pub const EnableLSERTCList = enum {
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
            DSIUsed_ForRCC: bool = false,
            GPUUsed_ForRCC: bool = false,
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
            ETHUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
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
            LTDCUsed_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C5Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            RNG1Used_ForRCC: bool = false,
            RNG2Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            I2C6Used_ForRCC: bool = false,
            DCMIUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null,
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null,
            VDD_VALUE: ?f32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
            PLL1UserDefinedConfig: ?PLL1UserDefinedConfigList = null,
        };
        pub const Config = struct {
            HSIDivValue: ?HSIDivValueList = null,
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            MCUCLKSource: ?MCUCLKSourceList = null,
            MPUCLKSource: ?MPUCLKSourceList = null,
            CKPERCLKSource: ?CKPERCLKSourceList = null,
            AXICLKSource: ?AXICLKSourceList = null,
            AXI_Div: ?AXI_DivList = null,
            APB4DIV: ?APB4DIVList = null,
            APB5DIV: ?APB5DIVList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            MCU_Div: ?MCU_DivList = null,
            Cortex_Div: ?Cortex_DivList = null,
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
            DSICLockSelection: ?DSICLockSelectionList = null,
            DSITX_Div: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            I2C12CLockSelection: ?I2C12CLockSelectionList = null,
            I2C35CLockSelection: ?I2C35CLockSelectionList = null,
            I2C46CLockSelection: ?I2C46CLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            QSPICLockSelection: ?QSPICLockSelectionList = null,
            FMCCLockSelection: ?FMCCLockSelectionList = null,
            SDMMC12CLockSelection: ?SDMMC12CLockSelectionList = null,
            SDMMC3CLockSelection: ?SDMMC3CLockSelectionList = null,
            STGENCLockSelection: ?STGENCLockSelectionList = null,
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null,
            LPTIM23CLockSelection: ?LPTIM23CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USART24CLockSelection: ?USART24CLockSelectionList = null,
            USART35CLockSelection: ?USART35CLockSelectionList = null,
            USART6CLockSelection: ?USART6CLockSelectionList = null,
            UART78CLockSelection: ?UART78CLockSelectionList = null,
            RNG1CLockSelection: ?RNG1CLockSelectionList = null,
            RNG2CLockSelection: ?RNG2CLockSelectionList = null,
            SPI6CLockSelection: ?SPI6CLockSelectionList = null,
            SPI45CLockSelection: ?SPI45CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            SAI4CLockSelection: ?SAI4CLockSelectionList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI23CLockSelection: ?SPI23CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI3CLockSelection: ?SAI3CLockSelectionList = null,
            FDCANCLockSelection: ?FDCANCLockSelectionList = null,
            ETH1CLockSelection: ?ETH1CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            CECCLockSelection: ?CECCLockSelectionList = null,
            USBPHYCLKSource: ?USBPHYCLKSourceList = null,
            USBOCLKSource: ?USBOCLKSourceList = null,
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
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            MCUDIV: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            McuClockOutput: f32 = 0,
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
            PLL4DSIInput: f32 = 0,
            DIVQ4: f32 = 0,
            DIVQ4output: f32 = 0,
            DIVR4: f32 = 0,
            DIVR4output: f32 = 0,
            DCMI: f32 = 0,
            DSIPHYPrescaler: f32 = 0,
            DSIMult: f32 = 0,
            DSIoutput: f32 = 0,
            DSITXPrescaler: f32 = 0,
            DSITXCLKEsc: f32 = 0,
            DSIPixel: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            I2C12Mult: f32 = 0,
            I2C12output: f32 = 0,
            I2C35Mult: f32 = 0,
            I2C35output: f32 = 0,
            I2C46Mult: f32 = 0,
            I2C46output: f32 = 0,
            SPDIFMult: f32 = 0,
            SPDIFoutput: f32 = 0,
            QSPIMult: f32 = 0,
            QSPIoutput: f32 = 0,
            FMCMult: f32 = 0,
            FMCoutput: f32 = 0,
            SDMMC12Mult: f32 = 0,
            SDMMC12output: f32 = 0,
            SDMMC3Mult: f32 = 0,
            SDMMC3output: f32 = 0,
            STGENMult: f32 = 0,
            STGENoutput: f32 = 0,
            LPTIM45Mult: f32 = 0,
            LPTIM45output: f32 = 0,
            LPTIM23Mult: f32 = 0,
            LPTIM23output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USART24Mult: f32 = 0,
            USART24output: f32 = 0,
            USART35Mult: f32 = 0,
            USART35output: f32 = 0,
            USART6Mult: f32 = 0,
            USART6output: f32 = 0,
            UART78Mult: f32 = 0,
            USART78output: f32 = 0,
            RNG1Mult: f32 = 0,
            RNG1output: f32 = 0,
            RNG2Mult: f32 = 0,
            RNG2output: f32 = 0,
            SPI6Mult: f32 = 0,
            SPI6output: f32 = 0,
            SPI45Mult: f32 = 0,
            SPI45output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
            SAI4Mult: f32 = 0,
            SAI4output: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI23Mult: f32 = 0,
            SPI23output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            DFSDF1Audiooutput: f32 = 0,
            SAI3Mult: f32 = 0,
            SAI3output: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            ETH1Mult: f32 = 0,
            ETH1output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            CSICECDevisor: f32 = 0,
            CECMult: f32 = 0,
            CECoutput: f32 = 0,
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
            PLLDSIIDF: f32 = 0,
            PLLDSIMultiplicator: f32 = 0,
            PLLDSINDIV: f32 = 0,
            VCOoutput: f32 = 0,
            PLLDSIDevisor: f32 = 0,
            PLLDSIODF: f32 = 0,
            PLLDSIoutput: f32 = 0,
            DSIPHYCLK: f32 = 0,
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
            MCUDIVCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSIDivValue: ?HSIDivValueList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            CSI_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            MCUCLKSource: ?MCUCLKSourceList = null, //from RCC Clock Config
            MPUCLKSource: ?MPUCLKSourceList = null, //from RCC Clock Config
            CKPERCLKSource: ?CKPERCLKSourceList = null, //from RCC Clock Config
            AXICLKSource: ?AXICLKSourceList = null, //from RCC Clock Config
            AXI_Div: ?AXI_DivList = null, //from RCC Clock Config
            APB4DIV: ?APB4DIVList = null, //from RCC Clock Config
            APB5DIV: ?APB5DIVList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            MCU_Div: ?MCU_DivList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
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
            DSIPHY_Div: ?f32 = null, //from RCC Clock Config
            DSICLockSelection: ?DSICLockSelectionList = null, //from RCC Clock Config
            DSITX_Div: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            I2C12CLockSelection: ?I2C12CLockSelectionList = null, //from RCC Clock Config
            I2C35CLockSelection: ?I2C35CLockSelectionList = null, //from RCC Clock Config
            I2C46CLockSelection: ?I2C46CLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            QSPICLockSelection: ?QSPICLockSelectionList = null, //from RCC Clock Config
            FMCCLockSelection: ?FMCCLockSelectionList = null, //from RCC Clock Config
            SDMMC12CLockSelection: ?SDMMC12CLockSelectionList = null, //from RCC Clock Config
            SDMMC3CLockSelection: ?SDMMC3CLockSelectionList = null, //from RCC Clock Config
            STGENCLockSelection: ?STGENCLockSelectionList = null, //from RCC Clock Config
            LPTIM45CLockSelection: ?LPTIM45CLockSelectionList = null, //from RCC Clock Config
            LPTIM23CLockSelection: ?LPTIM23CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USART24CLockSelection: ?USART24CLockSelectionList = null, //from RCC Clock Config
            USART35CLockSelection: ?USART35CLockSelectionList = null, //from RCC Clock Config
            USART6CLockSelection: ?USART6CLockSelectionList = null, //from RCC Clock Config
            UART78CLockSelection: ?UART78CLockSelectionList = null, //from RCC Clock Config
            RNG1CLockSelection: ?RNG1CLockSelectionList = null, //from RCC Clock Config
            RNG2CLockSelection: ?RNG2CLockSelectionList = null, //from RCC Clock Config
            SPI6CLockSelection: ?SPI6CLockSelectionList = null, //from RCC Clock Config
            SPI45CLockSelection: ?SPI45CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            SAI4CLockSelection: ?SAI4CLockSelectionList = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI23CLockSelection: ?SPI23CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI3CLockSelection: ?SAI3CLockSelectionList = null, //from RCC Clock Config
            FDCANCLockSelection: ?FDCANCLockSelectionList = null, //from RCC Clock Config
            ETH1CLockSelection: ?ETH1CLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            RCC_CEC_Clock_Source_FROM_CSI: ?RCC_CEC_Clock_Source_FROM_CSIList = null, //from RCC Clock Config
            CECCLockSelection: ?CECCLockSelectionList = null, //from RCC Clock Config
            RCC_USBPHY_Clock_Source_FROM_HSE: ?RCC_USBPHY_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            USBPHYCLKSource: ?USBPHYCLKSourceList = null, //from RCC Clock Config
            USB_PHY_VALUE: ?f32 = null, //from RCC Clock Config
            USBOCLKSource: ?USBOCLKSourceList = null, //from RCC Clock Config
            PLLDSIIDF: ?PLLDSIIDFList = null, //from RCC Clock Config
            PLLDSIMult: ?f32 = null, //from RCC Clock Config
            PLLDSINDIV: ?f32 = null, //from RCC Clock Config
            PLLDSIDev: ?f32 = null, //from RCC Clock Config
            PLLDSIODF: ?PLLDSIODFList = null, //from RCC Clock Config
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null, //from RCC Advanced Config
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null, //from RCC Advanced Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
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
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            PLL1UserDefinedConfigEnable: ?PLL1UserDefinedConfigEnableList = null, //from extra RCC references
            cKPerEnable: ?cKPerEnableList = null, //from extra RCC references
            DACEnable: ?DACEnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            DFSDMEnable: ?DFSDMEnableList = null, //from extra RCC references
            GPUEnable: ?GPUEnableList = null, //from extra RCC references
            DDREnable: ?DDREnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            ETH1Enable: ?ETH1EnableList = null, //from extra RCC references
            EnableDFSDMAudio: ?EnableDFSDMAudioList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            I2C46Enable: ?I2C46EnableList = null, //from extra RCC references
            SPDIFEnable: ?SPDIFEnableList = null, //from extra RCC references
            SAI2Enable: ?SAI2EnableList = null, //from extra RCC references
            SAI3Enable: ?SAI3EnableList = null, //from extra RCC references
            SAI4Enable: ?SAI4EnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            LPTIM45Enable: ?LPTIM45EnableList = null, //from extra RCC references
            SPI6Enable: ?SPI6EnableList = null, //from extra RCC references
            SPI1Enable: ?SPI1EnableList = null, //from extra RCC references
            SPI23Enable: ?SPI23EnableList = null, //from extra RCC references
            SPI45Enable: ?SPI45EnableList = null, //from extra RCC references
            FDCANEnable: ?FDCANEnableList = null, //from extra RCC references
            SDMMC12Enable: ?SDMMC12EnableList = null, //from extra RCC references
            SDMMC3Enable: ?SDMMC3EnableList = null, //from extra RCC references
            QuadSPIEnable: ?QuadSPIEnableList = null, //from extra RCC references
            FMCEnable: ?FMCEnableList = null, //from extra RCC references
            LTDCEnable: ?LTDCEnableList = null, //from extra RCC references
            EnablePLLRDSI: ?EnablePLLRDSIList = null, //from extra RCC references
            EnableHSEDSI: ?EnableHSEDSIList = null, //from extra RCC references
            UART78Enable: ?UART78EnableList = null, //from extra RCC references
            USART35Enable: ?USART35EnableList = null, //from extra RCC references
            USART24Enable: ?USART24EnableList = null, //from extra RCC references
            LPTIM23Enable: ?LPTIM23EnableList = null, //from extra RCC references
            USART6Enable: ?USART6EnableList = null, //from extra RCC references
            EnableUSBOFS: ?EnableUSBOFSList = null, //from extra RCC references
            EnableUSBOHS: ?EnableUSBOHSList = null, //from extra RCC references
            I2C35Enable: ?I2C35EnableList = null, //from extra RCC references
            I2C12Enable: ?I2C12EnableList = null, //from extra RCC references
            RNG1Enable: ?RNG1EnableList = null, //from extra RCC references
            RNG2Enable: ?RNG2EnableList = null, //from extra RCC references
            DCMIEnable: ?DCMIEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            STGENEnable: ?STGENEnableList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
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
            if (@inComptime()) @setEvalBranchQuota(10000);
            var out = Clock_Output{};
            var ref_out = Config_Output{};
            ref_out.flags = config.flags;

            //Semaphores flags

            var MCUCLKSOURCE_HSI: bool = false;
            var MCUCLKSOURCE_CSI: bool = false;
            var MCUCLKSOURCE_HSE: bool = false;
            var MCUCLKSOURCE_PLL3: bool = false;
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
            var MCO2SOURCE_MPU: bool = false;
            var MCO2SOURCE_AXI: bool = false;
            var MCO2SOURCE_MCU: bool = false;
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
            var DSICLKSOURCE_PLL4: bool = false;
            var DSISourceisDSIPHY: bool = false;
            var RTCCLKSOURCE_HSE_DIV: bool = false;
            var RTCCLKSOURCE_LSE: bool = false;
            var RTCCLKSOURCE_LSI: bool = false;
            var I2C12CLKSOURCE_BCLK: bool = false;
            var I2C12CLKSOURCE_PLL4: bool = false;
            var I2C12CLKSOURCE_HSI: bool = false;
            var I2C12CLKSOURCE_CSI: bool = false;
            var I2C35CLKSOURCE_BCLK: bool = false;
            var I2C35CLKSOURCE_PLL4: bool = false;
            var I2C35CLKSOURCE_HSI: bool = false;
            var I2C35CLKSOURCE_CSI: bool = false;
            var I2C46CLKSOURCE_BCLK: bool = false;
            var I2C46CLKSOURCE_PLL3: bool = false;
            var I2C46CLKSOURCE_HSI: bool = false;
            var I2C46CLKSOURCE_CSI: bool = false;
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
            var SDMMC12CLKSOURCE_BCLK: bool = false;
            var SDMMC12CLKSOURCE_PLL3: bool = false;
            var SDMMC12CLKSOURCE_PLL4: bool = false;
            var SDMMC12CLKSOURCE_HSI: bool = false;
            var SDMMC3CLKSOURCE_BCLK: bool = false;
            var SDMMC3CLKSOURCE_PLL3: bool = false;
            var SDMMC3CLKSOURCE_PLL4: bool = false;
            var SDMMC3CLKSOURCE_HSI: bool = false;
            var STGENCLKSOURCE_HSI: bool = false;
            var STGENCLKSOURCE_HSE: bool = false;
            var LPTIM45CLKSOURCE_BCLK: bool = false;
            var LPTIM45CLKSOURCE_PLL4: bool = false;
            var LPTIM45CLKSOURCE_PLL3: bool = false;
            var LPTIM45CLKSOURCE_LSE: bool = false;
            var LPTIM45CLKSOURCE_LSI: bool = false;
            var LPTIM45CLKSOURCE_PER: bool = false;
            var LPTIM23CLKSOURCE_BCLK: bool = false;
            var LPTIM23CLKSOURCE_PLL4: bool = false;
            var LPTIM23CLKSOURCE_PER: bool = false;
            var LPTIM23CLKSOURCE_LSE: bool = false;
            var LPTIM23CLKSOURCE_LSI: bool = false;
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
            var UART24CLKSOURCE_BCLK: bool = false;
            var UART24CLKSOURCE_PLL4: bool = false;
            var UART24CLKSOURCE_HSE: bool = false;
            var UART24CLKSOURCE_CSI: bool = false;
            var UART24CLKSOURCE_HSI: bool = false;
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
            var RNG1CLKSOURCE_LSE: bool = false;
            var RNG1CLKSOURCE_LSI: bool = false;
            var RNG2CLKSOURCE_CSI: bool = false;
            var RNG2CLKSOURCE_PLL4: bool = false;
            var RNG2CLKSOURCE_LSE: bool = false;
            var RNG2CLKSOURCE_LSI: bool = false;
            var SPI6CLKSOURCE_BCLK: bool = false;
            var SPI6CLKSOURCE_PLL4: bool = false;
            var SPI6CLKSOURCE_PLL3: bool = false;
            var SPI6CLKSOURCE_HSI: bool = false;
            var SPI6CLKSOURCE_CSI: bool = false;
            var SPI6CLKSOURCE_HSE: bool = false;
            var SPI45CLKSOURCE_BCLK: bool = false;
            var SPI45CLKSOURCE_PLL4: bool = false;
            var SPI45CLKSOURCE_HSI: bool = false;
            var SPI45CLKSOURCE_CSI: bool = false;
            var SPI45CLKSOURCE_HSE: bool = false;
            var SAI2CLKSOURCE_PLL4: bool = false;
            var SAI2CLKSOURCE_PLL3: bool = false;
            var SAI2CLKSOURCE_I2SCKIN: bool = false;
            var SAI2CLKSOURCE_PER: bool = false;
            var SAI2CLKSOURCE_SPDIF: bool = false;
            var SAI2CLKSOURCE_PLL3_R: bool = false;
            var SAI4CLKSOURCE_PLL4: bool = false;
            var SAI4CLKSOURCE_PLL3: bool = false;
            var SAI4CLKSOURCE_I2SCKIN: bool = false;
            var SAI4CLKSOURCE_PER: bool = false;
            var SAI4CLKSOURCE_PLL3_R: bool = false;
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
            var SAI3CLKSOURCE_PLL4: bool = false;
            var SAI3CLKSOURCE_PLL3: bool = false;
            var SAI3CLKSOURCE_I2SCKIN: bool = false;
            var SAI3CLKSOURCE_PER: bool = false;
            var SAI3CLKSOURCE_PLL3_R: bool = false;
            var FDCANCLKSOURCE_HSE: bool = false;
            var FDCANCLKSOURCE_PLL3: bool = false;
            var FDCANCLKSOURCE_PLL4: bool = false;
            var FDCANCLKSOURCE_PLL4_R: bool = false;
            var ETHCLKSOURCE_PLL4: bool = false;
            var ETHCLKSOURCE_PLL3: bool = false;
            var ADCCLKSOURCE_PLL4: bool = false;
            var ADCCLKSOURCE_PER: bool = false;
            var ADCCLKSOURCE_PLL3: bool = false;
            var CECCLKSOURCE_LSE: bool = false;
            var CECCLKSOURCE_LSI: bool = false;
            var USBPHYCLKSOURCE_HSE: bool = false;
            var USBPHYCLKSOURCE_PLL4: bool = false;
            var USBOCLKSOURCE_PLL4: bool = false;
            var USBOCLKSOURCE_PHY: bool = false;
            var HCLKDiv1: bool = false;
            var APB1DIV_1: bool = false;
            var APB1DIV_2: bool = false;
            var APB1DIV_4: bool = false;
            var APB2DIV_1: bool = false;
            var APB2DIV_2: bool = false;
            var APB2DIV_4: bool = false;
            var TimG1PrescalerEnabled: bool = false;
            var TimG2PrescalerEnabled: bool = false;

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

            var MCUDIV = ClockNode{
                .name = "MCUDIV",
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

            var McuClockOutput = ClockNode{
                .name = "McuClockOutput",
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

            var PLL4DSIInput = ClockNode{
                .name = "PLL4DSIInput",
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

            var DCMI = ClockNode{
                .name = "DCMI",
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

            var DSIPixel = ClockNode{
                .name = "DSIPixel",
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

            var I2C35Mult = ClockNode{
                .name = "I2C35Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C35output = ClockNode{
                .name = "I2C35output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C46Mult = ClockNode{
                .name = "I2C46Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C46output = ClockNode{
                .name = "I2C46output",
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

            var SDMMC12Mult = ClockNode{
                .name = "SDMMC12Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC12output = ClockNode{
                .name = "SDMMC12output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC3Mult = ClockNode{
                .name = "SDMMC3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC3output = ClockNode{
                .name = "SDMMC3output",
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

            var USART24Mult = ClockNode{
                .name = "USART24Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART24output = ClockNode{
                .name = "USART24output",
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

            var RNG2Mult = ClockNode{
                .name = "RNG2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNG2output = ClockNode{
                .name = "RNG2output",
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

            var SAI4Mult = ClockNode{
                .name = "SAI4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI4output = ClockNode{
                .name = "SAI4output",
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

            var SAI3Mult = ClockNode{
                .name = "SAI3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI3output = ClockNode{
                .name = "SAI3output",
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

            var CSICECDevisor = ClockNode{
                .name = "CSICECDevisor",
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

            var DSIPHYCLK = ClockNode{
                .name = "DSIPHYCLK",
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

            var MCUDIVCLK = ClockNode{
                .name = "MCUDIVCLK",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

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
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 24000000;
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const CSI_VALUEValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const MCUCLKSourceValue: ?MCUCLKSourceList = blk: {
                const conf_item = config.MCUCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCUSSOURCE_HSI => MCUCLKSOURCE_HSI = true,
                        .RCC_MCUSSOURCE_CSI => MCUCLKSOURCE_CSI = true,
                        .RCC_MCUSSOURCE_HSE => MCUCLKSOURCE_HSE = true,
                        .RCC_MCUSSOURCE_PLL3 => MCUCLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    MCUCLKSOURCE_HSI = true;
                    break :blk .RCC_MCUSSOURCE_HSI;
                };
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
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_MPU => MCO2SOURCE_MPU = true,
                        .RCC_MCO2SOURCE_AXI => MCO2SOURCE_AXI = true,
                        .RCC_MCO2SOURCE_MCU => MCO2SOURCE_MCU = true,
                        .RCC_MCO2SOURCE_PLL4 => MCO2SOURCE_PLL4 = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SOURCE_HSE = true,
                        .RCC_MCO2SOURCE_HSI => MCO2SOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    MCO2SOURCE_MPU = true;
                    break :blk .RCC_MCO2SOURCE_MPU;
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
                        .RCC_MCODIV_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCU_DivValue: ?MCU_DivList = blk: {
                const conf_item = config.MCU_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCU_DIV1 => {},
                        .RCC_MCU_DIV2 => {},
                        .RCC_MCU_DIV4 => {},
                        .RCC_MCU_DIV8 => {},
                        .RCC_MCU_DIV16 => {},
                        .RCC_MCU_DIV32 => {},
                        .RCC_MCU_DIV64 => {},
                        .RCC_MCU_DIV128 => {},
                        .RCC_MCU_DIV256 => {},
                        .RCC_MCU_DIV512 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCU_DIV1;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
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
            const DIVN1Value: ?f32 = if (config.DIVN1) |i| @as(f32, @floatFromInt(i)) else 25;
            const PLL1FRACVValue: ?f32 = if (config.PLL1FRACV) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const FreqCk2Value: ?f32 = blk: {
                break :blk 2;
            };
            const DIVN2Value: ?f32 = if (config.DIVN2) |i| @as(f32, @floatFromInt(i)) else 25;
            const PLL2FRACVValue: ?f32 = if (config.PLL2FRACV) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const DIVN3Value: ?f32 = if (config.DIVN3) |i| @as(f32, @floatFromInt(i)) else 25;
            const PLL3FRACVValue: ?f32 = if (config.PLL3FRACV) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const DIVN4Value: ?f32 = if (config.DIVN4) |i| @as(f32, @floatFromInt(i)) else 25;
            const PLL4FRACVValue: ?f32 = if (config.PLL4FRACV) |i| @as(f32, @floatFromInt(i)) else 0;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const DSIPHY_DivValue: ?f32 = blk: {
                break :blk 8;
            };
            const DSICLockSelectionValue: ?DSICLockSelectionList = blk: {
                const conf_item = config.DSICLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DSICLKSOURCE_PLL4 => DSICLKSOURCE_PLL4 = true,
                        .RCC_DSICLKSOURCE_PHY => DSISourceisDSIPHY = true,
                    }
                }

                break :blk conf_item orelse {
                    DSISourceisDSIPHY = true;
                    break :blk .RCC_DSICLKSOURCE_PHY;
                };
            };
            const DSITX_DivValue: ?f32 = blk: {
                const config_val = config.DSITX_Div;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
            const I2C35CLockSelectionValue: ?I2C35CLockSelectionList = blk: {
                const conf_item = config.I2C35CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C35CLKSOURCE_PCLK1 => I2C35CLKSOURCE_BCLK = true,
                        .RCC_I2C35CLKSOURCE_PLL4 => I2C35CLKSOURCE_PLL4 = true,
                        .RCC_I2C35CLKSOURCE_HSI => I2C35CLKSOURCE_HSI = true,
                        .RCC_I2C35CLKSOURCE_CSI => I2C35CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C35CLKSOURCE_BCLK = true;
                    break :blk .RCC_I2C35CLKSOURCE_PCLK1;
                };
            };
            const I2C46CLockSelectionValue: ?I2C46CLockSelectionList = blk: {
                const conf_item = config.I2C46CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C46CLKSOURCE_PCLK5 => I2C46CLKSOURCE_BCLK = true,
                        .RCC_I2C46CLKSOURCE_PLL3 => I2C46CLKSOURCE_PLL3 = true,
                        .RCC_I2C46CLKSOURCE_HSI => I2C46CLKSOURCE_HSI = true,
                        .RCC_I2C46CLKSOURCE_CSI => I2C46CLKSOURCE_CSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C46CLKSOURCE_BCLK = true;
                    break :blk .RCC_I2C46CLKSOURCE_PCLK5;
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
            const SDMMC12CLockSelectionValue: ?SDMMC12CLockSelectionList = blk: {
                const conf_item = config.SDMMC12CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC12CLKSOURCE_HCLK6 => SDMMC12CLKSOURCE_BCLK = true,
                        .RCC_SDMMC12CLKSOURCE_PLL3 => SDMMC12CLKSOURCE_PLL3 = true,
                        .RCC_SDMMC12CLKSOURCE_PLL4 => SDMMC12CLKSOURCE_PLL4 = true,
                        .RCC_SDMMC12CLKSOURCE_HSI => SDMMC12CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC12CLKSOURCE_BCLK = true;
                    break :blk .RCC_SDMMC12CLKSOURCE_HCLK6;
                };
            };
            const SDMMC3CLockSelectionValue: ?SDMMC3CLockSelectionList = blk: {
                const conf_item = config.SDMMC3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC3CLKSOURCE_HCLK2 => SDMMC3CLKSOURCE_BCLK = true,
                        .RCC_SDMMC3CLKSOURCE_PLL3 => SDMMC3CLKSOURCE_PLL3 = true,
                        .RCC_SDMMC3CLKSOURCE_PLL4 => SDMMC3CLKSOURCE_PLL4 = true,
                        .RCC_SDMMC3CLKSOURCE_HSI => SDMMC3CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC3CLKSOURCE_BCLK = true;
                    break :blk .RCC_SDMMC3CLKSOURCE_HCLK2;
                };
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
            const LPTIM23CLockSelectionValue: ?LPTIM23CLockSelectionList = blk: {
                const conf_item = config.LPTIM23CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM23CLKSOURCE_PCLK3 => LPTIM23CLKSOURCE_BCLK = true,
                        .RCC_LPTIM23CLKSOURCE_PLL4 => LPTIM23CLKSOURCE_PLL4 = true,
                        .RCC_LPTIM23CLKSOURCE_PER => LPTIM23CLKSOURCE_PER = true,
                        .RCC_LPTIM23CLKSOURCE_LSE => LPTIM23CLKSOURCE_LSE = true,
                        .RCC_LPTIM23CLKSOURCE_LSI => LPTIM23CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    LPTIM23CLKSOURCE_BCLK = true;
                    break :blk .RCC_LPTIM23CLKSOURCE_PCLK3;
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
                        .RCC_USART1CLKSOURCE_PCLK5 => USART1CLKSOURCE_BCLK = true,
                        .RCC_USART1CLKSOURCE_PLL4 => USART1CLKSOURCE_PLL4 = true,
                        .RCC_USART1CLKSOURCE_PLL3 => USART1CLKSOURCE_PLL3 = true,
                        .RCC_USART1CLKSOURCE_HSE => USART1CLKSOURCE_HSE = true,
                        .RCC_USART1CLKSOURCE_CSI => USART1CLKSOURCE_CSI = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    USART1CLKSOURCE_BCLK = true;
                    break :blk .RCC_USART1CLKSOURCE_PCLK5;
                };
            };
            const USART24CLockSelectionValue: ?USART24CLockSelectionList = blk: {
                const conf_item = config.USART24CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART24CLKSOURCE_PCLK1 => UART24CLKSOURCE_BCLK = true,
                        .RCC_UART24CLKSOURCE_PLL4 => UART24CLKSOURCE_PLL4 = true,
                        .RCC_UART24CLKSOURCE_HSE => UART24CLKSOURCE_HSE = true,
                        .RCC_UART24CLKSOURCE_CSI => UART24CLKSOURCE_CSI = true,
                        .RCC_UART24CLKSOURCE_HSI => UART24CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse {
                    UART24CLKSOURCE_BCLK = true;
                    break :blk .RCC_UART24CLKSOURCE_PCLK1;
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
            const RNG1CLockSelectionValue: ?RNG1CLockSelectionList = blk: {
                const conf_item = config.RNG1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNG1CLKSOURCE_CSI => RNG1CLKSOURCE_CSI = true,
                        .RCC_RNG1CLKSOURCE_PLL4 => RNG1CLKSOURCE_PLL4 = true,
                        .RCC_RNG1CLKSOURCE_LSE => RNG1CLKSOURCE_LSE = true,
                        .RCC_RNG1CLKSOURCE_LSI => RNG1CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RNG1CLKSOURCE_CSI = true;
                    break :blk .RCC_RNG1CLKSOURCE_CSI;
                };
            };
            const RNG2CLockSelectionValue: ?RNG2CLockSelectionList = blk: {
                const conf_item = config.RNG2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNG2CLKSOURCE_CSI => RNG2CLKSOURCE_CSI = true,
                        .RCC_RNG2CLKSOURCE_PLL4 => RNG2CLKSOURCE_PLL4 = true,
                        .RCC_RNG2CLKSOURCE_LSE => RNG2CLKSOURCE_LSE = true,
                        .RCC_RNG2CLKSOURCE_LSI => RNG2CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RNG2CLKSOURCE_CSI = true;
                    break :blk .RCC_RNG2CLKSOURCE_CSI;
                };
            };
            const SPI6CLockSelectionValue: ?SPI6CLockSelectionList = blk: {
                const conf_item = config.SPI6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI6CLKSOURCE_PCLK5 => SPI6CLKSOURCE_BCLK = true,
                        .RCC_SPI6CLKSOURCE_PLL4 => SPI6CLKSOURCE_PLL4 = true,
                        .RCC_SPI6CLKSOURCE_PLL3 => SPI6CLKSOURCE_PLL3 = true,
                        .RCC_SPI6CLKSOURCE_HSI => SPI6CLKSOURCE_HSI = true,
                        .RCC_SPI6CLKSOURCE_CSI => SPI6CLKSOURCE_CSI = true,
                        .RCC_SPI6CLKSOURCE_HSE => SPI6CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI6CLKSOURCE_BCLK = true;
                    break :blk .RCC_SPI6CLKSOURCE_PCLK5;
                };
            };
            const SPI45CLockSelectionValue: ?SPI45CLockSelectionList = blk: {
                const conf_item = config.SPI45CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI45CLKSOURCE_PCLK2 => SPI45CLKSOURCE_BCLK = true,
                        .RCC_SPI45CLKSOURCE_PLL4 => SPI45CLKSOURCE_PLL4 = true,
                        .RCC_SPI45CLKSOURCE_HSI => SPI45CLKSOURCE_HSI = true,
                        .RCC_SPI45CLKSOURCE_CSI => SPI45CLKSOURCE_CSI = true,
                        .RCC_SPI45CLKSOURCE_HSE => SPI45CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse {
                    SPI45CLKSOURCE_BCLK = true;
                    break :blk .RCC_SPI45CLKSOURCE_PCLK2;
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
            const SAI4CLockSelectionValue: ?SAI4CLockSelectionList = blk: {
                const conf_item = config.SAI4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI4CLKSOURCE_PLL4 => SAI4CLKSOURCE_PLL4 = true,
                        .RCC_SAI4CLKSOURCE_PLL3_Q => SAI4CLKSOURCE_PLL3 = true,
                        .RCC_SAI4CLKSOURCE_I2SCKIN => SAI4CLKSOURCE_I2SCKIN = true,
                        .RCC_SAI4CLKSOURCE_PER => SAI4CLKSOURCE_PER = true,
                        .RCC_SAI4CLKSOURCE_PLL3_R => SAI4CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI4CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SAI4CLKSOURCE_PLL4;
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
            const SAI3CLockSelectionValue: ?SAI3CLockSelectionList = blk: {
                const conf_item = config.SAI3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI3CLKSOURCE_PLL4 => SAI3CLKSOURCE_PLL4 = true,
                        .RCC_SAI3CLKSOURCE_PLL3_Q => SAI3CLKSOURCE_PLL3 = true,
                        .RCC_SAI3CLKSOURCE_I2SCKIN => SAI3CLKSOURCE_I2SCKIN = true,
                        .RCC_SAI3CLKSOURCE_PER => SAI3CLKSOURCE_PER = true,
                        .RCC_SAI3CLKSOURCE_PLL3_R => SAI3CLKSOURCE_PLL3_R = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI3CLKSOURCE_PLL4 = true;
                    break :blk .RCC_SAI3CLKSOURCE_PLL4;
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
            const ETH1CLockSelectionValue: ?ETH1CLockSelectionList = blk: {
                const conf_item = config.ETH1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETHCLKSOURCE_PLL4 => ETHCLKSOURCE_PLL4 = true,
                        .RCC_ETHCLKSOURCE_PLL3 => ETHCLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ETHCLKSOURCE_PLL4 = true;
                    break :blk .RCC_ETHCLKSOURCE_PLL4;
                };
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_PLL4 => ADCCLKSOURCE_PLL4 = true,
                        .RCC_ADCCLKSOURCE_PER => ADCCLKSOURCE_PER = true,
                        .RCC_ADCCLKSOURCE_PLL3 => ADCCLKSOURCE_PLL3 = true,
                    }
                }

                break :blk conf_item orelse {
                    ADCCLKSOURCE_PLL4 = true;
                    break :blk .RCC_ADCCLKSOURCE_PLL4;
                };
            };
            const RCC_CEC_Clock_Source_FROM_CSIValue: ?RCC_CEC_Clock_Source_FROM_CSIList = blk: {
                const item: RCC_CEC_Clock_Source_FROM_CSIList = .RCC_CECCLKSOURCE_CSI122;
                break :blk item;
            };
            const CECCLockSelectionValue: ?CECCLockSelectionList = blk: {
                const conf_item = config.CECCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_LSE => CECCLKSOURCE_LSE = true,
                        .RCC_CECCLKSOURCE_LSI => CECCLKSOURCE_LSI = true,
                        .CSICECDevisor => {},
                    }
                }

                break :blk conf_item orelse {
                    CECCLKSOURCE_LSE = true;
                    break :blk .RCC_CECCLKSOURCE_LSE;
                };
            };
            const RCC_USBPHY_Clock_Source_FROM_HSEValue: ?RCC_USBPHY_Clock_Source_FROM_HSEList = blk: {
                const item: RCC_USBPHY_Clock_Source_FROM_HSEList = .RCC_USBPHYCLKSOURCE_HSE2;
                break :blk item;
            };
            const USBPHYCLKSourceValue: ?USBPHYCLKSourceList = blk: {
                const conf_item = config.USBPHYCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBPHYCLKSOURCE_HSE => USBPHYCLKSOURCE_HSE = true,
                        .RCC_USBPHYCLKSOURCE_PLL4 => USBPHYCLKSOURCE_PLL4 = true,
                        .HSEUSBPHYDevisor => {},
                    }
                }

                break :blk conf_item orelse {
                    USBPHYCLKSOURCE_PLL4 = true;
                    break :blk .RCC_USBPHYCLKSOURCE_PLL4;
                };
            };
            const USB_PHY_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                if (check_MCU("CRSActivatedSourceLSE") or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC)) or (config.flags.MCO1Config and MCO1SOURCE_LSE) or (CECCLKSOURCE_LSE and config.flags.CECUsed_ForRCC) or (LPTIM23CLKSOURCE_LSE and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC)) or (LPTIM45CLKSOURCE_LSE and (config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC)) or RNG1CLKSOURCE_LSE and config.flags.RNG1Used_ForRCC or RNG2CLKSOURCE_LSE and config.flags.RNG2Used_ForRCC or LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1Used_ForRCC) {
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
            const PLL2UsedValue: ?f32 = blk: {
                if (AXISSOURCE_PLL2 or check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3") or config.flags.GPUUsed_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (ADCCLKSOURCE_PLL3 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) or SPI1CLKSOURCE_PLL3_R and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL3_R and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SPI23CLKSOURCE_PLL3 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or ETHCLKSOURCE_PLL3 and config.flags.ETHUsed_ForRCC or SPI1CLKSOURCE_PLL3 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or MCUCLKSOURCE_PLL3 or I2C46CLKSOURCE_PLL3 and config.flags.I2C4Used_ForRCC or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL3 or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) and SDMMC12CLKSOURCE_PLL3 or SDMMC3CLKSOURCE_PLL3 and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL3 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL3 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC or SPI6CLKSOURCE_PLL3 and config.flags.SPI6Used_ForRCC or SAI2CLKSOURCE_PLL3 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI1CLKSOURCE_PLL3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or SAI3CLKSOURCE_PLL3 and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or FDCANCLKSOURCE_PLL3 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or SAI1CLKSOURCE_PLL3_R and ((config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC) or SAI2CLKSOURCE_PLL3_R and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI3CLKSOURCE_PLL3_R and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or SAI4CLKSOURCE_PLL3_R and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedValue: ?f32 = blk: {
                if (ETHCLKSOURCE_PLL4 and config.flags.ETHUsed_ForRCC or config.flags.MCO2Config and MCO2SOURCE_PLL4 or config.flags.LTDCUsed_ForRCC or config.flags.DSIUsed_ForRCC and DSICLKSOURCE_PLL4 or I2C12CLKSOURCE_PLL4 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC) or I2C35CLKSOURCE_PLL4 and (config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC) or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL4 or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) and SDMMC12CLKSOURCE_PLL4 or SDMMC3CLKSOURCE_PLL4 and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL4 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM23CLKSOURCE_PLL4 and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC) or LPTIM1CLKSOURCE_PLL4 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC or UART24CLKSOURCE_PLL4 and (config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC) or UART35CLKSOURCE_PLL4 and (config.flags.USART3Used_ForRCC or config.flags.UART5Used_ForRCC) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC or UART78CLKSOURCE_PLL4 and (config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC or RNG2CLKSOURCE_PLL4 and config.flags.RNG2Used_ForRCC or SPI6CLKSOURCE_PLL4 and config.flags.SPI6Used_ForRCC or SPI45CLKSOURCE_PLL4 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_PLL4 or SAI4CLKSOURCE_PLL4 and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or SPI1CLKSOURCE_PLL4 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL4 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SAI1CLKSOURCE_PLL4 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or SAI3CLKSOURCE_PLL4 and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or (FDCANCLKSOURCE_PLL4 or FDCANCLKSOURCE_PLL4_R) and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or ADCCLKSOURCE_PLL4 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or USBPHYCLKSOURCE_PLL4 and USBOCLKSOURCE_PHY and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or USBOCLKSOURCE_PLL4 and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
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
                if (config.flags.LPTIM1Used_ForRCC or config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC or config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC or config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC or config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC or check_MCU("QSPI_Selected") or (config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or config.flags.FMCUsed_ForRCC or config.flags.LPTIM3Used_ForRCC or config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) {
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
            const GPUEnableValue: ?GPUEnableList = blk: {
                if (config.flags.GPUUsed_ForRCC) {
                    const item: GPUEnableList = .true;
                    break :blk item;
                }
                const item: GPUEnableList = .false;
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
            const ETH1EnableValue: ?ETH1EnableList = blk: {
                if (config.flags.ETHUsed_ForRCC) {
                    const item: ETH1EnableList = .true;
                    break :blk item;
                }
                const item: ETH1EnableList = .false;
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
            const I2C46EnableValue: ?I2C46EnableList = blk: {
                if (config.flags.I2C4Used_ForRCC or config.flags.I2C6Used_ForRCC) {
                    const item: I2C46EnableList = .true;
                    break :blk item;
                }
                const item: I2C46EnableList = .false;
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
            const SAI3EnableValue: ?SAI3EnableList = blk: {
                if (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) {
                    const item: SAI3EnableList = .true;
                    break :blk item;
                }
                const item: SAI3EnableList = .false;
                break :blk item;
            };
            const SAI4EnableValue: ?SAI4EnableList = blk: {
                if (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) {
                    const item: SAI4EnableList = .true;
                    break :blk item;
                }
                const item: SAI4EnableList = .false;
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
            const SPI6EnableValue: ?SPI6EnableList = blk: {
                if (config.flags.SPI6Used_ForRCC) {
                    const item: SPI6EnableList = .true;
                    break :blk item;
                }
                const item: SPI6EnableList = .false;
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
            const SPI45EnableValue: ?SPI45EnableList = blk: {
                if (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC) {
                    const item: SPI45EnableList = .true;
                    break :blk item;
                }
                const item: SPI45EnableList = .false;
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
            const SDMMC12EnableValue: ?SDMMC12EnableList = blk: {
                if (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) {
                    const item: SDMMC12EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC12EnableList = .false;
                break :blk item;
            };
            const SDMMC3EnableValue: ?SDMMC3EnableList = blk: {
                if (config.flags.SDMMC3Used_ForRCC) {
                    const item: SDMMC3EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC3EnableList = .false;
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
            const EnablePLLRDSIValue: ?EnablePLLRDSIList = blk: {
                const item: EnablePLLRDSIList = .false;
                break :blk item;
            };
            const EnableHSEDSIValue: ?EnableHSEDSIList = blk: {
                if (((config.flags.DSIUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass))) {
                    const item: EnableHSEDSIList = .true;
                    break :blk item;
                }
                const item: EnableHSEDSIList = .false;
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
            const USART24EnableValue: ?USART24EnableList = blk: {
                if (config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC) {
                    const item: USART24EnableList = .true;
                    break :blk item;
                }
                const item: USART24EnableList = .false;
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
            const USART6EnableValue: ?USART6EnableList = blk: {
                if (config.flags.USART6Used_ForRCC) {
                    const item: USART6EnableList = .true;
                    break :blk item;
                }
                const item: USART6EnableList = .false;
                break :blk item;
            };
            const EnableUSBOFSValue: ?EnableUSBOFSList = blk: {
                if ((config.flags.USB_OTG_FSUsed_ForRCC)) {
                    const item: EnableUSBOFSList = .true;
                    break :blk item;
                }
                const item: EnableUSBOFSList = .false;
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
            const I2C35EnableValue: ?I2C35EnableList = blk: {
                if (config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC) {
                    const item: I2C35EnableList = .true;
                    break :blk item;
                }
                const item: I2C35EnableList = .false;
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
            const RNG2EnableValue: ?RNG2EnableList = blk: {
                if (config.flags.RNG2Used_ForRCC) {
                    const item: RNG2EnableList = .true;
                    break :blk item;
                }
                const item: RNG2EnableList = .false;
                break :blk item;
            };
            const DCMIEnableValue: ?DCMIEnableList = blk: {
                if (config.flags.DCMIUsed_ForRCC) {
                    const item: DCMIEnableList = .true;
                    break :blk item;
                }
                const item: DCMIEnableList = .false;
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
            const STGENEnableValue: ?STGENEnableList = blk: {
                const item: STGENEnableList = .true;
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
            const EnableHSEUSBPHYDevisorValue: ?EnableHSEUSBPHYDevisorList = blk: {
                if ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEUSBPHYDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSEUSBPHYDevisorList = .false;
                break :blk item;
            };
            const Max650Value: ?Max650List = blk: {
                if (check_MCU("STM32MP153AAAx") or check_MCU("STM32MP151AAAx") or check_MCU("STM32MP157AAAx") or check_MCU("STM32MP153CAAx") or check_MCU("STM32MP151CAAx") or check_MCU("STM32MP157CAAx")) {
                    const item: Max650List = .true;
                    break :blk item;
                } else if (check_MCU("STM32MP151AABx") or check_MCU("STM32MP151AACx") or check_MCU("STM32MP151AADx") or check_MCU("STM32MP153AABx")) {
                    const item: Max650List = .true;
                    break :blk item;
                } else if (check_MCU("STM32MP153AACx") or check_MCU("STM32MP153AADx") or check_MCU("STM32MP157AABx") or check_MCU("STM32MP157AACx") or check_MCU("STM32MP157AADx")) {
                    const item: Max650List = .true;
                    break :blk item;
                } else if (check_MCU("STM32MP151CABx") or check_MCU("STM32MP151CACx") or check_MCU("STM32MP151CADx") or check_MCU("STM32MP153CABx")) {
                    const item: Max650List = .true;
                    break :blk item;
                } else if (check_MCU("STM32MP153CACx") or check_MCU("STM32MP153CADx") or check_MCU("STM32MP157CABx") or check_MCU("STM32MP157CACx") or check_MCU("STM32MP157CADx")) {
                    const item: Max650List = .true;
                    break :blk item;
                }
                const item: Max650List = .false;
                break :blk item;
            };
            const PLL2RUsedValue: ?f32 = blk: {
                if (check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if (ADCCLKSOURCE_PLL3 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or SPI23CLKSOURCE_PLL3 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or ETHCLKSOURCE_PLL3 and config.flags.ETHUsed_ForRCC or SPI1CLKSOURCE_PLL3 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or I2C46CLKSOURCE_PLL3 and config.flags.I2C4Used_ForRCC or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL3 or LPTIM45CLKSOURCE_PLL3 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL3 and config.flags.LPTIM1Used_ForRCC or USART1CLKSOURCE_PLL3 and config.flags.USART1Used_ForRCC or SPI6CLKSOURCE_PLL3 and config.flags.SPI6Used_ForRCC or SAI2CLKSOURCE_PLL3 and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI1CLKSOURCE_PLL3 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or SAI3CLKSOURCE_PLL3 and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or FDCANCLKSOURCE_PLL3 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if (SPI1CLKSOURCE_PLL3_R and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL3_R and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or SAI1CLKSOURCE_PLL3_R and ((config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC) or SAI2CLKSOURCE_PLL3_R and (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) or SAI3CLKSOURCE_PLL3_R and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or SAI4CLKSOURCE_PLL3_R and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or QSPICLKSOURCE_PLL3 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL3 and config.flags.FMCUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) and SDMMC12CLKSOURCE_PLL3 or SDMMC3CLKSOURCE_PLL3 and config.flags.SDMMC3Used_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4PUsedValue: ?f32 = blk: {
                if (ETHCLKSOURCE_PLL4 and config.flags.ETHUsed_ForRCC or config.flags.MCO2Config and MCO2SOURCE_PLL4 or config.flags.DSIUsed_ForRCC and DSICLKSOURCE_PLL4 or (((config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_SPDIF) or config.flags.SPDIFRXUsed_ForRCC) and SPDIFRXCLKSOURCE_PLL4 or QSPICLKSOURCE_PLL4 and check_MCU("QSPI_Selected") or FMCCLKSOURCE_PLL4 and config.flags.FMCUsed_ForRCC or (config.flags.SDMMC1Used_ForRCC or config.flags.SDMMC2Used_ForRCC) and SDMMC12CLKSOURCE_PLL4 or SDMMC3CLKSOURCE_PLL4 and config.flags.SDMMC3Used_ForRCC or LPTIM45CLKSOURCE_PLL4 and (config.flags.LPTIM4Used_ForRCC or config.flags.LPTIM5Used_ForRCC) or LPTIM1CLKSOURCE_PLL4 and config.flags.LPTIM1Used_ForRCC or SPI1CLKSOURCE_PLL4 and (config.flags.SPI1Used_ForRCC or config.flags.I2S1Used_ForRCC) or SPI23CLKSOURCE_PLL4 and (config.flags.SPI2Used_ForRCC or config.flags.SPI3Used_ForRCC or config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4QUsedValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or LPTIM23CLKSOURCE_PLL4 and (config.flags.LPTIM2Used_ForRCC or config.flags.LPTIM3Used_ForRCC) or USART1CLKSOURCE_PLL4 and config.flags.USART1Used_ForRCC or UART24CLKSOURCE_PLL4 and (config.flags.USART2Used_ForRCC or config.flags.UART4Used_ForRCC) or UART35CLKSOURCE_PLL4 and (config.flags.USART3Used_ForRCC or config.flags.UART5Used_ForRCC) or USART6CLKSOURCE_PLL4 and config.flags.USART6Used_ForRCC or UART78CLKSOURCE_PLL4 and (config.flags.UART7Used_ForRCC or config.flags.UART8Used_ForRCC) or FDCANCLKSOURCE_PLL4 and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or SAI3CLKSOURCE_PLL4 and (config.flags.SAI3_SAIAUsed_ForRCC or config.flags.SAI3_SAIBUsed_ForRCC) or SAI4CLKSOURCE_PLL4 and (config.flags.SAI4_SAIAUsed_ForRCC or config.flags.SAI4_SAIBUsed_ForRCC) or (config.flags.SAI2_SAIAUsed_ForRCC or config.flags.SAI2_SAIBUsed_ForRCC) and SAI2CLKSOURCE_PLL4 or SAI1CLKSOURCE_PLL4 and (config.flags.SAI1_SAIAUsed_ForRCC or config.flags.SAI1_SAIBUsed_ForRCC or config.flags.DFSDM1Used_ForRCC and (check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") or check_MCU("DFSDM1_LINUX"))) or SPI45CLKSOURCE_PLL4 and (config.flags.SPI4Used_ForRCC or config.flags.SPI5Used_ForRCC) or SPI6CLKSOURCE_PLL4 and config.flags.SPI6Used_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4RUsedValue: ?f32 = blk: {
                if (ADCCLKSOURCE_PLL4 and ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC)) or FDCANCLKSOURCE_PLL4_R and (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2Used_ForRCC) or I2C12CLKSOURCE_PLL4 and (config.flags.I2C2Used_ForRCC or config.flags.I2C3Used_ForRCC or config.flags.I2C1Used_ForRCC) or I2C35CLKSOURCE_PLL4 and (config.flags.I2C3Used_ForRCC or config.flags.I2C5Used_ForRCC) or RNG1CLKSOURCE_PLL4 and config.flags.RNG1Used_ForRCC or RNG2CLKSOURCE_PLL4 and config.flags.RNG2Used_ForRCC or USBOCLKSOURCE_PLL4 and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC) or USBPHYCLKSOURCE_PLL4 and USBOCLKSOURCE_PHY and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if (AXISSOURCE_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if (MCUCLKSOURCE_PLL3) {
                    break :blk 1;
                }
                break :blk 0;
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
                if (AXISSOURCE_PLL2 or check_MCU("DDR3") or check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedTFAValue: ?f32 = blk: {
                if (MCUCLKSOURCE_PLL3 or (FMCCLKSOURCE_PLL3 and check_MCU("FMC_BOOTLOADER")) or (I2C46CLKSOURCE_PLL3 and (check_MCU("I2C4_BOOTLOADER") or check_MCU("I2C6_BOOTLOADER"))) or (QSPICLKSOURCE_PLL3 and check_MCU("QUADSPI_BOOTLOADER")) or (SDMMC12CLKSOURCE_PLL3 and (check_MCU("SDMMC1_BOOTLOADER") or check_MCU("SDMMC2_BOOTLOADER"))) or (SDMMC3CLKSOURCE_PLL3 and check_MCU("SDMMC3_BOOTLOADER")) or (USART1CLKSOURCE_PLL3 and check_MCU("USART1_BOOTLOADER"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedA7Value: ?f32 = blk: {
                if (ADCCLKSOURCE_PLL3 and (check_MCU("ADC1_LINUX") or check_MCU("ADC2_LINUX") or check_MCU("ADC1_CUBE") or check_MCU("ADC2_CUBE")) or (SPI1CLKSOURCE_PLL3_R or SPI1CLKSOURCE_PLL3) and (check_MCU("SPI1_LINUX") or check_MCU("I2S1_LINUX") or check_MCU("SPI1_CUBE")) or (SPI23CLKSOURCE_PLL3_R or SPI23CLKSOURCE_PLL3) and (check_MCU("SPI2_LINUX") or check_MCU("SPI3_LINUX") or check_MCU("I2S2_LINUX") or check_MCU("I2S3_LINUX") or check_MCU("SPI2_CUBE") or check_MCU("SPI3_CUBE")) or SPI6CLKSOURCE_PLL3 and (check_MCU("SPI6_LINUX") or check_MCU("SPI6_SECURE_OS")) or ETHCLKSOURCE_PLL3 and check_MCU("ETH1_LINUX") or MCUCLKSOURCE_PLL3 or SPDIFRXCLKSOURCE_PLL3 and (check_MCU("SPDIFRX_LINUX") or check_MCU("SPDIFRX_CUBE")) or QSPICLKSOURCE_PLL3 and (check_MCU("QUADSPI_LINUX") or check_MCU("QUADSPI_CUBE")) or FMCCLKSOURCE_PLL3 and (check_MCU("FMC_LINUX") or check_MCU("FMC_CUBE")) or SDMMC12CLKSOURCE_PLL3 and (check_MCU("SDMMC1_LINUX") or check_MCU("SDMMC2_LINUX")) or SDMMC3CLKSOURCE_PLL3 and (check_MCU("SDMMC3_LINUX") or check_MCU("SDMMC3_CUBE")) or LPTIM45CLKSOURCE_PLL3 and (check_MCU("LPTIM4_LINUX") or check_MCU("LPTIM5_LINUX") or check_MCU("LPTIM4_CUBE") or check_MCU("LPTIM5_CUBE")) or LPTIM1CLKSOURCE_PLL3 and (check_MCU("LPTIM1_LINUX") or check_MCU("LPTIM1_CUBE")) or USART1CLKSOURCE_PLL3 and (check_MCU("USART1_SECURE_OS") or check_MCU("USART1_LINUX")) or FDCANCLKSOURCE_PLL3 and (check_MCU("FDCAN1_LINUX") or check_MCU("FDCAN2_LINUX") or check_MCU("FDCAN1_CUBE") or check_MCU("FDCAN2_CUBE")) or (SAI1CLKSOURCE_PLL3_R or SAI1CLKSOURCE_PLL3) and (check_MCU("SAI1_LINUX") or check_MCU("DFSDM1_LINUX") or check_MCU("SAI1_CUBE") or check_MCU("DFSDM1_CUBE")) or (SAI3CLKSOURCE_PLL3_R or SAI3CLKSOURCE_PLL3) and (check_MCU("SAI3_LINUX") or check_MCU("SAI3_CUBE")) or (SAI4CLKSOURCE_PLL3_R or SAI4CLKSOURCE_PLL3) and (check_MCU("SAI4_LINUX") or check_MCU("SAI4_CUBE")) or (SAI2CLKSOURCE_PLL3_R or SAI2CLKSOURCE_PLL3 or (SAI2CLKSOURCE_SPDIF and SPDIFRXCLKSOURCE_PLL3)) and (check_MCU("SAI2_LINUX") or check_MCU("SAI2_CUBE")) or I2C46CLKSOURCE_PLL3 and (check_MCU("I2C4_LINUX") or check_MCU("I2C4_SECURE_OS") or check_MCU("I2C6_LINUX") or check_MCU("I2C6_SECURE_OS"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedTFAValue: ?f32 = blk: {
                if ((FMCCLKSOURCE_PLL4 and check_MCU("FMC_BOOTLOADER")) or (QSPICLKSOURCE_PLL4 and check_MCU("QUADSPI_BOOTLOADER")) or (SDMMC12CLKSOURCE_PLL4 and (check_MCU("SDMMC1_BOOTLOADER") or check_MCU("SDMMC2_BOOTLOADER"))) or (SDMMC3CLKSOURCE_PLL4 and check_MCU("SDMMC3_BOOTLOADER")) or (USART1CLKSOURCE_PLL4 and check_MCU("USART1_BOOTLOADER")) or (UART24CLKSOURCE_PLL4 and (check_MCU("USART2_BOOTLOADER") or check_MCU("UART4_BOOTLOADER"))) or (UART35CLKSOURCE_PLL4 and (check_MCU("USART3_BOOTLOADER") or check_MCU("UART5_BOOTLOADER"))) or (USART6CLKSOURCE_PLL4 and check_MCU("USART6_BOOTLOADER")) or (UART78CLKSOURCE_PLL4 and (check_MCU("UART7_BOOTLOADER") or check_MCU("UART8_BOOTLOADER"))) or (USBOCLKSOURCE_PLL4 and check_MCU("USB_OTG_HS_BOOTLOADER")) or (USBPHYCLKSOURCE_PLL4 and USBOCLKSOURCE_PHY and check_MCU("USB_OTG_HS_BOOTLOADER"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedA7Value: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC or DSICLKSOURCE_PLL4 and check_MCU("DSI_LINUX") or check_MCU("I2C4CLKSOURCE_PLL4R") and config.flags.I2C4Used_ForRCC and (check_MCU("I2C4_LINUX") or check_MCU("I2C4_SECURE_OS")) or ETHCLKSOURCE_PLL4 and check_MCU("ETH1_LINUX") or I2C12CLKSOURCE_PLL4 and (check_MCU("I2C2_LINUX") or check_MCU("I2C1_LINUX") or check_MCU("I2C2_CUBE") or check_MCU("I2C1_CUBE")) or I2C35CLKSOURCE_PLL4 and (check_MCU("I2C3_LINUX") or check_MCU("I2C5_LINUX") or check_MCU("I2C3_CUBE") or check_MCU("I2C5_CUBE")) or SPDIFRXCLKSOURCE_PLL4 and (check_MCU("SPDIFRX_LINUX") or check_MCU("SPDIFRX_CUBE")) or QSPICLKSOURCE_PLL4 and (check_MCU("QUADSPI_LINUX") or check_MCU("QUADSPI_CUBE")) or FMCCLKSOURCE_PLL4 and (check_MCU("FMC_LINUX") or check_MCU("FMC_CUBE")) or SDMMC12CLKSOURCE_PLL4 and (check_MCU("SDMMC1_LINUX") or check_MCU("SDMMC2_LINUX")) or SDMMC3CLKSOURCE_PLL4 and (check_MCU("SDMMC3_LINUX") or check_MCU("SDMMC3_CUBE")) or LPTIM45CLKSOURCE_PLL4 and (check_MCU("LPTIM4_LINUX") or check_MCU("LPTIM5_LINUX") or check_MCU("LPTIM4_CUBE") or check_MCU("LPTIM5_CUBE")) or LPTIM23CLKSOURCE_PLL4 and (check_MCU("LPTIM2_LINUX") or check_MCU("LPTIM3_LINUX") or check_MCU("LPTIM2_CUBE") or check_MCU("LPTIM3_CUBE")) or LPTIM1CLKSOURCE_PLL4 and (check_MCU("LPTIM1_LINUX") or check_MCU("LPTIM1_CUBE")) or USART1CLKSOURCE_PLL4 and (check_MCU("USART1_SECURE_OS") or check_MCU("USART1_LINUX")) or UART24CLKSOURCE_PLL4 and (check_MCU("USART2_LINUX") or check_MCU("UART4_LINUX") or check_MCU("USART2_CUBE") or check_MCU("UART4_CUBE")) or UART35CLKSOURCE_PLL4 and (check_MCU("USART3_LINUX") or check_MCU("UART5_LINUX") or check_MCU("USART3_CUBE") or check_MCU("UART5_CUBE")) or USART6CLKSOURCE_PLL4 and (check_MCU("USART6_LINUX") or check_MCU("USART6_CUBE")) or UART78CLKSOURCE_PLL4 and (check_MCU("UART7_LINUX") or check_MCU("UART8_LINUX") or check_MCU("UART7_CUBE") or check_MCU("UART8_CUBE")) or RNG1CLKSOURCE_PLL4 and (check_MCU("RNG1_LINUX") or check_MCU("RNG1_SECURE_OS")) or RNG2CLKSOURCE_PLL4 and check_MCU("RNG2_CUBE") or SPI45CLKSOURCE_PLL4 and (check_MCU("SPI4_LINUX") or check_MCU("SPI5_LINUX") or check_MCU("SPI4_CUBE") or check_MCU("SPI5_CUBE")) or (SAI2CLKSOURCE_PLL4 or (SAI2CLKSOURCE_SPDIF and SPDIFRXCLKSOURCE_PLL4)) and (check_MCU("SAI2_LINUX") or check_MCU("SAI2_CUBE")) or SPI1CLKSOURCE_PLL4 and (check_MCU("SPI1_LINUX") or check_MCU("I2S1_LINUX") or check_MCU("SPI1_CUBE")) or SPI23CLKSOURCE_PLL4 and (check_MCU("SPI2_LINUX") or check_MCU("SPI3_LINUX") or check_MCU("I2S2_LINUX") or check_MCU("I2S3_LINUX") or check_MCU("SPI2_CUBE") or check_MCU("SPI3_CUBE")) or SAI1CLKSOURCE_PLL4 and (check_MCU("SAI1_LINUX") or check_MCU("DFSDM1_LINUX") or check_MCU("SAI1_CUBE") or check_MCU("DFSDM1_CUBE")) or SAI3CLKSOURCE_PLL4 and (check_MCU("SAI3_LINUX") or check_MCU("SAI3_CUBE")) or SAI4CLKSOURCE_PLL4 and (check_MCU("SAI4_LINUX") or check_MCU("SAI4_CUBE")) or (FDCANCLKSOURCE_PLL4 or FDCANCLKSOURCE_PLL4_R) and (check_MCU("FDCAN1_LINUX") or check_MCU("FDCAN2_LINUX") or check_MCU("FDCAN1_CUBE") or check_MCU("FDCAN2_CUBE")) or ADCCLKSOURCE_PLL4 and (check_MCU("ADC1_LINUX") or check_MCU("ADC2_LINUX") or check_MCU("ADC1_CUBE") or check_MCU("ADC2_CUBE")) or USBOCLKSOURCE_PLL4 and check_MCU("USB_OTG_HS_LINUX") or USBPHYCLKSOURCE_PLL4 and USBOCLKSOURCE_PHY and (check_MCU("USB_OTG_HS_LINUX") or check_MCU("USBH_HS1_LINUX") or check_MCU("USBH_HS2_LINUX"))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.LSEOscillator or config.flags.LSEByPass or config.flags.LSEDIGByPass)) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
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

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
                if (config.flags.HSEByPass or config.flags.HSEOscillator or config.flags.HSEDIGByPass) {
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
                                "HSEByPass  | HSEOscillator|HSEDIGByPass",
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
                                "HSEByPass  | HSEOscillator|HSEDIGByPass",
                                "HSE in bypass Mode",
                                4.8e7,
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
                HSEOSC.value = config_val orelse 24000000;

                break :blk null;
            };
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

            const SysClkSource_clk_value = MCUCLKSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SysClkSource",
                "Else",
                "No Extra Log",
                "MCUCLKSource",
            });
            const SysClkSourceparents = [_]*const ClockNode{
                &HSIDiv,
                &CSIRC,
                &HSEOSC,
                &DIVP3,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
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
            AXICLKOutput.nodetype = .output;
            AXICLKOutput.parents = &.{&AXIMult};
            if (check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=")) {
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
            AXIOutput.nodetype = .output;
            AXIOutput.parents = &.{&AXIDIV};
            Hclk5Output.nodetype = .output;
            Hclk5Output.parents = &.{&AXIDIV};
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
            APB5DIVOutput.nodetype = .output;
            APB5DIVOutput.parents = &.{&APB5DIV};
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
                    &MPUMult,
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
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }

            const MCUDIV_clk_value = MCU_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "MCUDIV",
                "Else",
                "No Extra Log",
                "MCU_Div",
            });
            MCUDIV.nodetype = .div;
            MCUDIV.value = MCUDIV_clk_value.get();
            MCUDIV.parents = &.{&SysCLKOutput};

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
            CortexPrescaler.parents = &.{&MCUDIV};
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};
            McuClockOutput.nodetype = .output;
            McuClockOutput.parents = &.{&MCUDIV};

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
            APB3DIV.parents = &.{&MCUDIV};
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
            APB1DIV.parents = &.{&MCUDIV};

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
            Tim1Output.nodetype = .output;
            Tim1Output.parents = &.{&Tim1Mul};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&MCUDIV};
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
            APB2DIV.parents = &.{&MCUDIV};

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
            Tim2Output.nodetype = .output;
            Tim2Output.parents = &.{&Tim2Mul};
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&APB2DIV};
            if (check_ref(@TypeOf(DFSDMEnableValue), DFSDMEnableValue, .true, .@"=")) {
                DFSDM1Output.nodetype = .output;
                DFSDM1Output.parents = &.{&MCUDIV};
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
            const PLL1MODEValue: ?PLL1MODEList = blk: {
                if (check_ref(@TypeOf(PLL1CSGValue), PLL1CSGValue, .true, .@"=")) {
                    const item: PLL1MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                }
                const item: PLL1MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };

            //POST CLOCK REF DIVN1 VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1MODEValue), PLL1MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL1MODEValue), PLL1MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
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
                                "PLL1MODE = RCC_PLL_INTEGER | PLL1MODE = RCC_PLL_SPREAD_SPECTRUM",
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
                                "PLL1MODE = RCC_PLL_INTEGER | PLL1MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                100,
                                val,
                            });
                        }
                    }
                    DIVN1.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL1MODEValue), PLL1MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
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
                                "PLL1MODE = RCC_PLL_FRACTIONAL",
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
                                "PLL1MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                512,
                                val,
                            });
                        }
                    }
                    DIVN1.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                }
            };
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

            //POST CLOCK REF PLL1FRACV VALUE
            _ = blk: {
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
                    PLL1FRACV.limit = .{
                        .min = 0,
                        .max = 0,
                    };
                    PLL1FRACV.value = 0;
                    break :blk null;
                }
                const config_val = config.PLL1FRACV;
                PLL1FRACV.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                PLL1FRACV.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };
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
            const PLL2MODEValue: ?PLL2MODEList = blk: {
                if (check_ref(@TypeOf(PLL2CSGValue), PLL2CSGValue, .true, .@"=")) {
                    const item: PLL2MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                }
                const item: PLL2MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };

            //POST CLOCK REF DIVN2 VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
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
                                "PLL2MODE = RCC_PLL_INTEGER  | PLL2MODE = RCC_PLL_SPREAD_SPECTRUM",
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
                                "PLL2MODE = RCC_PLL_INTEGER  | PLL2MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                100,
                                val,
                            });
                        }
                    }
                    DIVN2.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
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
                                "PLL2MODE = RCC_PLL_FRACTIONAL",
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
                                "PLL2MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                512,
                                val,
                            });
                        }
                    }
                    DIVN2.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                }
            };

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

            //POST CLOCK REF PLL2FRACV VALUE
            _ = blk: {
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
                    PLL2FRACV.limit = .{
                        .min = 0,
                        .max = 0,
                    };
                    PLL2FRACV.value = 0;
                    break :blk null;
                }
                const config_val = config.PLL2FRACV;
                PLL2FRACV.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                PLL2FRACV.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };

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
            if (check_ref(@TypeOf(GPUEnableValue), GPUEnableValue, .true, .@"=")) {
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
            if (check_ref(@TypeOf(GPUEnableValue), GPUEnableValue, .true, .@"=")) {
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
                DIVR2output.nodetype = .output;
                DIVR2output.parents = &.{&DIVR2};
            }
            const PLL3MODEValue: ?PLL3MODEList = blk: {
                if (check_MCU("PLL3CSG")) {
                    const item: PLL3MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                } else if (check_MCU("PLL3CSG")) {
                    const item: PLL3MODEList = .RCC_PLL_SPREAD_SPECTRUM;
                    break :blk item;
                }
                const item: PLL3MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };

            //POST CLOCK REF DIVN3 VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
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
                                "PLL3MODE = RCC_PLL_INTEGER  | PLL3MODE = RCC_PLL_SPREAD_SPECTRUM",
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
                                "PLL3MODE = RCC_PLL_INTEGER  | PLL3MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                200,
                                val,
                            });
                        }
                    }
                    DIVN3.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
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
                                "PLL3MODE = RCC_PLL_FRACTIONAL",
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
                                "PLL3MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                512,
                                val,
                            });
                        }
                    }
                    DIVN3.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                }
            };

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

            //POST CLOCK REF PLL3FRACV VALUE
            _ = blk: {
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
                    PLL3FRACV.limit = .{
                        .min = 0,
                        .max = 0,
                    };
                    PLL3FRACV.value = 0;
                    break :blk null;
                }
                const config_val = config.PLL3FRACV;
                PLL3FRACV.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                PLL3FRACV.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };

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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C46EnableValue), I2C46EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"="))
            {
                DIVQ3output.nodetype = .output;
                DIVQ3output.parents = &.{&DIVQ3};
            }
            if (check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                LTDCOutput.nodetype = .output;
                LTDCOutput.parents = &.{&DIVQ4};
            }
            if (check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"="))
            {
                DIVR3output.nodetype = .output;
                DIVR3output.parents = &.{&DIVR3};
            }
            const PLL4MODEValue: ?PLL4MODEList = blk: {
                const item: PLL4MODEList = .RCC_PLL_FRACTIONAL;
                break :blk item;
            };

            //POST CLOCK REF DIVN4 VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_INTEGER, .@"=") or false) {
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
                                "PLL4MODE = RCC_PLL_INTEGER  | PLL4MODE = RCC_PLL_SPREAD_SPECTRUM",
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
                                "PLL4MODE = RCC_PLL_INTEGER  | PLL4MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                200,
                                val,
                            });
                        }
                    }
                    DIVN4.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
                    const config_val = config.DIVN4;
                    if (config_val) |val| {
                        if (val < 4) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "DIVN4",
                                "PLL4MODE = RCC_PLL_FRACTIONAL",
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
                                "DIVN4",
                                "PLL4MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                512,
                                val,
                            });
                        }
                    }
                    DIVN4.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;

                    break :blk null;
                }
            };

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

            //POST CLOCK REF PLL4FRACV VALUE
            _ = blk: {
                if (false) {
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
                    PLL4FRACV.limit = .{
                        .min = 0,
                        .max = 0,
                    };
                    PLL4FRACV.value = 0;
                    break :blk null;
                }
                const config_val = config.PLL4FRACV;
                PLL4FRACV.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                PLL4FRACV.value = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };

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
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(QuadSPIEnableValue), QuadSPIEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPDIFEnableValue), SPDIFEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM45EnableValue), LPTIM45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI23EnableValue), SPI23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"="))
            {
                DIVP4output.nodetype = .output;
                DIVP4output.parents = &.{&DIVP4};
            }
            if (check_ref(@TypeOf(EnablePLLRDSIValue), EnablePLLRDSIValue, .false, .@"=")) {
                PLL4DSIInput.nodetype = .output;
                PLL4DSIInput.parents = &.{&DIVP4};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART24EnableValue), USART24EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=") or
                check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART78EnableValue), UART78EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART35EnableValue), USART35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART24EnableValue), USART24EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI45EnableValue), SPI45EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"="))
            {
                DIVQ4output.nodetype = .output;
                DIVQ4output.parents = &.{&DIVQ4};
            }
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(I2C35EnableValue), I2C35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG2EnableValue), RNG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"=") or
                check_ref(@TypeOf(I2C35EnableValue), I2C35EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C12EnableValue), I2C12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNG2EnableValue), RNG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"="))
            {
                DIVR4output.nodetype = .output;
                DIVR4output.parents = &.{&DIVR4};
            }
            if (check_ref(@TypeOf(DCMIEnableValue), DCMIEnableValue, .true, .@"=")) {
                DCMI.nodetype = .output;
                DCMI.parents = &.{&AHBOutput};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const DSIPHYPrescaler_clk_value = DSIPHY_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DSIPHYPrescaler",
                    "Else",
                    "No Extra Log",
                    "DSIPHY_Div",
                });
                DSIPHYPrescaler.nodetype = .div;
                DSIPHYPrescaler.value = DSIPHYPrescaler_clk_value;
                DSIPHYPrescaler.parents = &.{&PLLDSIODF};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const DSIMult_clk_value = DSICLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DSIMult",
                    "Else",
                    "No Extra Log",
                    "DSICLockSelection",
                });
                const DSIMultparents = [_]*const ClockNode{
                    &PLL4DSIInput,
                    &DSIPHYPrescaler,
                };
                DSIMult.nodetype = .multi;
                DSIMult.parents = &.{DSIMultparents[DSIMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                DSIoutput.nodetype = .output;
                DSIoutput.parents = &.{&DSIMult};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const DSITXPrescaler_clk_value = DSITX_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DSITXPrescaler",
                    "Else",
                    "No Extra Log",
                    "DSITX_Div",
                });
                DSITXPrescaler.nodetype = .div;
                DSITXPrescaler.value = DSITXPrescaler_clk_value;
                DSITXPrescaler.parents = &.{&DSIMult};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                DSITXCLKEsc.nodetype = .output;
                DSITXCLKEsc.parents = &.{&DSITXPrescaler};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                DSIPixel.nodetype = .output;
                DSIPixel.parents = &.{&DIVQ4};
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
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
                I2C12output.nodetype = .output;
                I2C12output.parents = &.{&I2C12Mult};
            }
            if (check_ref(@TypeOf(I2C35EnableValue), I2C35EnableValue, .true, .@"=")) {
                const I2C35Mult_clk_value = I2C35CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C35Mult",
                    "Else",
                    "No Extra Log",
                    "I2C35CLockSelection",
                });
                const I2C35Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVR4,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C35Mult.nodetype = .multi;
                I2C35Mult.parents = &.{I2C35Multparents[I2C35Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C35EnableValue), I2C35EnableValue, .true, .@"=")) {
                I2C35output.nodetype = .output;
                I2C35output.parents = &.{&I2C35Mult};
            }
            if (check_ref(@TypeOf(I2C46EnableValue), I2C46EnableValue, .true, .@"=")) {
                const I2C46Mult_clk_value = I2C46CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C46Mult",
                    "Else",
                    "No Extra Log",
                    "I2C46CLockSelection",
                });
                const I2C46Multparents = [_]*const ClockNode{
                    &APB5DIV,
                    &DIVQ3,
                    &HSIDiv,
                    &CSIRC,
                };
                I2C46Mult.nodetype = .multi;
                I2C46Mult.parents = &.{I2C46Multparents[I2C46Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C46EnableValue), I2C46EnableValue, .true, .@"=")) {
                I2C46output.nodetype = .output;
                I2C46output.parents = &.{&I2C46Mult};
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
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
            }
            if (check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=")) {
                const SDMMC12Mult_clk_value = SDMMC12CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC12Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC12CLockSelection",
                });
                const SDMMC12Multparents = [_]*const ClockNode{
                    &Hclk6Output,
                    &DIVR3,
                    &DIVP4,
                    &HSIDiv,
                };
                SDMMC12Mult.nodetype = .multi;
                SDMMC12Mult.parents = &.{SDMMC12Multparents[SDMMC12Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC12EnableValue), SDMMC12EnableValue, .true, .@"=")) {
                SDMMC12output.nodetype = .output;
                SDMMC12output.parents = &.{&SDMMC12Mult};
            }
            if (check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=")) {
                const SDMMC3Mult_clk_value = SDMMC3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC3Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC3CLockSelection",
                });
                const SDMMC3Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &DIVR3,
                    &DIVP4,
                    &HSIDiv,
                };
                SDMMC3Mult.nodetype = .multi;
                SDMMC3Mult.parents = &.{SDMMC3Multparents[SDMMC3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SDMMC3EnableValue), SDMMC3EnableValue, .true, .@"=")) {
                SDMMC3output.nodetype = .output;
                SDMMC3output.parents = &.{&SDMMC3Mult};
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
                LPTIM45output.nodetype = .output;
                LPTIM45output.parents = &.{&LPTIM45Mult};
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
                    &APB3DIV,
                    &DIVQ4,
                    &CKPERCLKOutput,
                    &LSEOSC,
                    &LSIRC,
                };
                LPTIM23Mult.nodetype = .multi;
                LPTIM23Mult.parents = &.{LPTIM23Multparents[LPTIM23Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM23EnableValue), LPTIM23EnableValue, .true, .@"=")) {
                LPTIM23output.nodetype = .output;
                LPTIM23output.parents = &.{&LPTIM23Mult};
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
                        &APB5DIV,
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
                    USART1output.nodetype = .output;
                    USART1output.parents = &.{&USART1Mult};
                }
            }
            if (check_ref(@TypeOf(USART24EnableValue), USART24EnableValue, .true, .@"=")) {
                const USART24Mult_clk_value = USART24CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART24Mult",
                    "Else",
                    "No Extra Log",
                    "USART24CLockSelection",
                });
                const USART24Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVQ4,
                    &HSEOSC,
                    &CSIRC,
                    &HSIDiv,
                };
                USART24Mult.nodetype = .multi;
                USART24Mult.parents = &.{USART24Multparents[USART24Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART24EnableValue), USART24EnableValue, .true, .@"=")) {
                USART24output.nodetype = .output;
                USART24output.parents = &.{&USART24Mult};
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
                        &LSEOSC,
                        &LSIRC,
                    };
                    RNG1Mult.nodetype = .multi;
                    RNG1Mult.parents = &.{RNG1Multparents[RNG1Mult_clk_value.get()]};
                }
            }
            if ((check_MCU("RNG1_Exist"))) {
                if (check_ref(@TypeOf(RNG1EnableValue), RNG1EnableValue, .true, .@"=")) {
                    RNG1output.nodetype = .output;
                    RNG1output.parents = &.{&RNG1Mult};
                }
            }
            if ((check_MCU("RNG2_Exist"))) {
                if (check_ref(@TypeOf(RNG2EnableValue), RNG2EnableValue, .true, .@"=")) {
                    const RNG2Mult_clk_value = RNG2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RNG2Mult",
                        "(RNG2_Exist)",
                        "No Extra Log",
                        "RNG2CLockSelection",
                    });
                    const RNG2Multparents = [_]*const ClockNode{
                        &CSIRC,
                        &DIVR4,
                        &LSEOSC,
                        &LSIRC,
                    };
                    RNG2Mult.nodetype = .multi;
                    RNG2Mult.parents = &.{RNG2Multparents[RNG2Mult_clk_value.get()]};
                }
            }
            if ((check_MCU("RNG2_Exist"))) {
                if (check_ref(@TypeOf(RNG2EnableValue), RNG2EnableValue, .true, .@"=")) {
                    RNG2output.nodetype = .output;
                    RNG2output.parents = &.{&RNG2Mult};
                }
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
                    &APB5DIV,
                    &DIVQ4,
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
                const SPI45Mult_clk_value = SPI45CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI45Mult",
                    "Else",
                    "No Extra Log",
                    "SPI45CLockSelection",
                });
                const SPI45Multparents = [_]*const ClockNode{
                    &APB1DIV,
                    &DIVQ4,
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
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
            }
            if (check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=")) {
                const SAI4Mult_clk_value = SAI4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI4Mult",
                    "Else",
                    "No Extra Log",
                    "SAI4CLockSelection",
                });
                const SAI4Multparents = [_]*const ClockNode{
                    &DIVQ4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &DIVR3,
                };
                SAI4Mult.nodetype = .multi;
                SAI4Mult.parents = &.{SAI4Multparents[SAI4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI4EnableValue), SAI4EnableValue, .true, .@"=")) {
                SAI4output.nodetype = .output;
                SAI4output.parents = &.{&SAI4Mult};
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
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=")) {
                DFSDF1Audiooutput.nodetype = .output;
                DFSDF1Audiooutput.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=")) {
                const SAI3Mult_clk_value = SAI3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI3Mult",
                    "Else",
                    "No Extra Log",
                    "SAI3CLockSelection",
                });
                const SAI3Multparents = [_]*const ClockNode{
                    &DIVQ4,
                    &DIVQ3,
                    &I2S_CKIN,
                    &CKPERCLKOutput,
                    &DIVR3,
                };
                SAI3Mult.nodetype = .multi;
                SAI3Mult.parents = &.{SAI3Multparents[SAI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAI3EnableValue), SAI3EnableValue, .true, .@"=")) {
                SAI3output.nodetype = .output;
                SAI3output.parents = &.{&SAI3Mult};
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
                    &DIVQ3,
                    &DIVQ4,
                    &DIVR4,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=")) {
                FDCANoutput.nodetype = .output;
                FDCANoutput.parents = &.{&FDCANMult};
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
                    &DIVR4,
                    &CKPERCLKOutput,
                    &DIVQ3,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CSICECDevisor_clk_value = RCC_CEC_Clock_Source_FROM_CSIValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CSICECDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_CEC_Clock_Source_FROM_CSI",
                });
                CSICECDevisor.nodetype = .div;
                CSICECDevisor.value = CSICECDevisor_clk_value.get();
                CSICECDevisor.parents = &.{&CSIRC};
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
                    &CSICECDevisor,
                    &LSEOSC,
                    &LSIRC,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                CECoutput.nodetype = .output;
                CECoutput.parents = &.{&CECMult};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                DDRPHYC.nodetype = .output;
                DDRPHYC.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                PUBL.nodetype = .output;
                PUBL.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
                DDRC.nodetype = .output;
                DDRC.parents = &.{&DIVR2};
            }
            if (check_ref(@TypeOf(DDREnableValue), DDREnableValue, .true, .@"=")) {
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
                    &HSEUSBPHYDevisor,
                    &HSEOSC,
                    &DIVR4,
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
            if (check_ref(@TypeOf(EnableUSBOFSValue), EnableUSBOFSValue, .true, .@"=") or
                check_ref(@TypeOf(EnableUSBOHSValue), EnableUSBOHSValue, .true, .@"="))
            {
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
                USBOFSCLKOutput.nodetype = .output;
                USBOFSCLKOutput.parents = &.{&USBOCLKMux};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLDSIIDF_clk_value = PLLDSIIDFValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLDSIIDF",
                    "Else",
                    "No Extra Log",
                    "PLLDSIIDF",
                });
                PLLDSIIDF.nodetype = .div;
                PLLDSIIDF.value = PLLDSIIDF_clk_value.get();
                PLLDSIIDF.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLDSIMultiplicator_clk_value = PLLDSIMultValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLDSIMultiplicator",
                    "Else",
                    "No Extra Log",
                    "PLLDSIMult",
                });
                PLLDSIMultiplicator.nodetype = .mul;
                PLLDSIMultiplicator.value = PLLDSIMultiplicator_clk_value;
                PLLDSIMultiplicator.parents = &.{&PLLDSIIDF};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLDSINDIV_clk_value = PLLDSINDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLDSINDIV",
                    "Else",
                    "No Extra Log",
                    "PLLDSINDIV",
                });
                PLLDSINDIV.nodetype = .mul;
                PLLDSINDIV.value = PLLDSINDIV_clk_value;
                PLLDSINDIV.parents = &.{&PLLDSIMultiplicator};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                VCOoutput.nodetype = .output;
                VCOoutput.parents = &.{&PLLDSINDIV};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLDSIDevisor_clk_value = PLLDSIDevValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLDSIDevisor",
                    "Else",
                    "No Extra Log",
                    "PLLDSIDev",
                });
                PLLDSIDevisor.nodetype = .div;
                PLLDSIDevisor.value = PLLDSIDevisor_clk_value;
                PLLDSIDevisor.parents = &.{&VCOoutput};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                const PLLDSIODF_clk_value = PLLDSIODFValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLDSIODF",
                    "Else",
                    "No Extra Log",
                    "PLLDSIODF",
                });
                PLLDSIODF.nodetype = .div;
                PLLDSIODF.value = PLLDSIODF_clk_value.get();
                PLLDSIODF.parents = &.{&PLLDSIDevisor};
            }
            if (check_ref(@TypeOf(EnableHSEDSIValue), EnableHSEDSIValue, .true, .@"=")) {
                PLLDSIoutput.nodetype = .output;
                PLLDSIoutput.parents = &.{&PLLDSIODF};
            }
            DSIPHYCLK.nodetype = .output;
            DSIPHYCLK.parents = &.{&DSIPHYPrescaler};
            HSIDivClk.nodetype = .output;
            HSIDivClk.parents = &.{&HSIDiv};
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&DIVM1};
            VCO2Input.nodetype = .output;
            VCO2Input.parents = &.{&DIVM2};
            VCO3Input.nodetype = .output;
            VCO3Input.parents = &.{&DIVM3};
            VCO4Input.nodetype = .output;
            VCO4Input.parents = &.{&DIVM4};
            VCO1Output.nodetype = .output;
            VCO1Output.parents = &.{&DIVN1};
            PLL1CLK.nodetype = .output;
            PLL1CLK.parents = &.{&DIVP1};
            VCO2Output.nodetype = .output;
            VCO2Output.parents = &.{&DIVN2};
            PLL2CLK.nodetype = .output;
            PLL2CLK.parents = &.{&DIVP2};
            VCO3Output.nodetype = .output;
            VCO3Output.parents = &.{&DIVN3};
            VCO4Output.nodetype = .output;
            VCO4Output.parents = &.{&DIVN4};
            PLL3CLK.nodetype = .output;
            PLL3CLK.parents = &.{&DIVP3};
            MCUDIVCLK.nodetype = .output;
            MCUDIVCLK.parents = &.{&MCUDIV};

            //POST CLOCK REF MCUCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF MPUCLKFreq_VALUE VALUE
            _ = blk: {
                if (check_ref(@TypeOf(Max650Value), Max650Value, .false, .@"=")) {
                    MPUCLKOutput.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                MPUCLKOutput.limit = .{
                    .min = null,
                    .max = 6.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AXICLKFreq_VALUE VALUE
            _ = blk: {
                AXICLKOutput.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AXIDIVFreq_Value VALUE
            _ = blk: {
                AXIOutput.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF Hclk5DIVFreq_Value VALUE
            _ = blk: {
                Hclk5Output.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF Hclk6DIVFreq_Value VALUE
            _ = blk: {
                Hclk6Output.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB4Freq_Value VALUE
            _ = blk: {
                APB4DIVOutput.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB5DIVClockFreq_Value VALUE
            _ = blk: {
                APB5DIVOutput.limit = .{
                    .min = null,
                    .max = 6.7e7,
                };

                break :blk null;
            };

            //POST CLOCK REF MCUClockFreq_Value VALUE
            _ = blk: {
                McuClockOutput.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB3Freq_Value VALUE
            _ = blk: {
                APB3Output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF Tim1OutputFreq_Value VALUE
            _ = blk: {
                Tim1Output.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB1234Freq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF Tim2OutputFreq_Value VALUE
            _ = blk: {
                Tim2Output.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DFSDMFreq_Value VALUE
            _ = blk: {
                if (config.flags.DFSDM1Used_ForRCC) {
                    DFSDM1Output.limit = .{
                        .min = null,
                        .max = 2.09e8,
                    };

                    break :blk null;
                }
                DFSDM1Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ2Freq_Value VALUE
            _ = blk: {
                DIVQ2output.limit = .{
                    .min = null,
                    .max = 5.33e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DIVR2Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"="))) {
                    DIVR2output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVR2output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ3Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"="))) {
                    DIVQ3output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVQ3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF LTDCFreq_Value VALUE
            _ = blk: {
                LTDCOutput.limit = .{
                    .min = null,
                    .max = 9e7,
                };

                break :blk null;
            };

            //POST CLOCK REF DIVR3Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3RUsedValue), PLL3RUsedValue, 1, .@"="))) {
                    DIVR3output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVR3output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP4Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL4PUsedValue), PLL4PUsedValue, 1, .@"="))) {
                    DIVP4output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVP4output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVQ4Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL4QUsedValue), PLL4QUsedValue, 1, .@"="))) {
                    DIVQ4output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVQ4output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVR4Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL4RUsedValue), PLL4RUsedValue, 1, .@"="))) {
                    DIVR4output.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                DIVR4output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DCMIFreq_Value VALUE
            _ = blk: {
                const min: ?f32 = null;
                const max: ?f32 = @min(83600000, std.math.floatMax(f32));
                DCMI.limit = .{
                    .min = min,
                    .max = max,
                    .min_expr = "null",
                    .max_expr = "null",
                };
                break :blk null;
            };

            //POST CLOCK REF DSIFreq_Value VALUE
            _ = blk: {
                if (config.flags.DSIUsed_ForRCC) {
                    DSIoutput.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                DSIoutput.limit = .{
                    .min = null,
                    .max = 1.25e8,
                };

                break :blk null;
            };

            //POST CLOCK REF DSITXEscFreq_Value VALUE
            _ = blk: {
                DSITXCLKEsc.limit = .{
                    .min = null,
                    .max = 2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF DSIPixelFreq_Value VALUE
            _ = blk: {
                DSIPixel.limit = .{
                    .min = null,
                    .max = 9e7,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                RTCOutput.limit = .{
                    .min = null,
                    .max = 4e6,
                };

                break :blk null;
            };

            //POST CLOCK REF I2C12Freq_Value VALUE
            _ = blk: {
                I2C12output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF I2C35Freq_Value VALUE
            _ = blk: {
                I2C35output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF I2C46Freq_Value VALUE
            _ = blk: {
                I2C46output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPDIFRXFreq_Value VALUE
            _ = blk: {
                SPDIFoutput.limit = .{
                    .min = null,
                    .max = 2e8,
                };

                break :blk null;
            };

            //POST CLOCK REF QSPIFreq_Value VALUE
            _ = blk: {
                QSPIoutput.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF FMCFreq_Value VALUE
            _ = blk: {
                FMCoutput.limit = .{
                    .min = null,
                    .max = 2.665e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SDMMC12Freq_Value VALUE
            _ = blk: {
                SDMMC12output.limit = .{
                    .min = null,
                    .max = 2e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SDMMC3Freq_Value VALUE
            _ = blk: {
                SDMMC3output.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            //POST CLOCK REF STGENFreq_Value VALUE
            _ = blk: {
                STGENoutput.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM45Freq_Value VALUE
            _ = blk: {
                LPTIM45output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM23Freq_Value VALUE
            _ = blk: {
                LPTIM23output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF LPTIM1Freq_Value VALUE
            _ = blk: {
                LPTIM1output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART1Freq_Value VALUE
            _ = blk: {
                USART1output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART24Freq_Value VALUE
            _ = blk: {
                USART24output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART35Freq_Value VALUE
            _ = blk: {
                USART35output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF USART6Freq_Value VALUE
            _ = blk: {
                USART6output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF UART78Freq_Value VALUE
            _ = blk: {
                USART78output.limit = .{
                    .min = null,
                    .max = 1.045e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RNG1Freq_Value VALUE
            _ = blk: {
                RNG1output.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF RNG2Freq_Value VALUE
            _ = blk: {
                RNG2output.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI6Freq_Value VALUE
            _ = blk: {
                SPI6output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI45Freq_Value VALUE
            _ = blk: {
                SPI45output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI2Freq_Value VALUE
            _ = blk: {
                SAI2output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI4Freq_Value VALUE
            _ = blk: {
                SAI4output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI1Freq_Value VALUE
            _ = blk: {
                SPI1output.limit = .{
                    .min = null,
                    .max = 2e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI23Freq_Value VALUE
            _ = blk: {
                SPI23output.limit = .{
                    .min = null,
                    .max = 2e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI1Freq_Value VALUE
            _ = blk: {
                SAI1output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SAI3Freq_Value VALUE
            _ = blk: {
                SAI3output.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF FDCANFreq_Value VALUE
            _ = blk: {
                FDCANoutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF ETHFreq_Value VALUE
            _ = blk: {
                ETH1output.limit = .{
                    .min = null,
                    .max = 1.25e8,
                };

                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                ADCoutput.limit = .{
                    .min = null,
                    .max = 1.3325e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CECFreq_Value VALUE
            _ = blk: {
                CECoutput.limit = .{
                    .min = null,
                    .max = 1e6,
                };

                break :blk null;
            };

            //POST CLOCK REF DDRCFreq_Value VALUE
            _ = blk: {
                if (check_MCU("DDR3")) {
                    DDRC.limit = .{
                        .min = 3e8,
                        .max = 5.33e8,
                    };

                    break :blk null;
                } else if (check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    DDRC.limit = .{
                        .min = 1e7,
                        .max = 5.33e8,
                    };

                    break :blk null;
                }
                DDRC.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF DDRPERFMFreq_Value VALUE
            _ = blk: {
                if (check_MCU("DDR3")) {
                    DDRPERFM.limit = .{
                        .min = 3e8,
                        .max = 5.33e8,
                    };

                    break :blk null;
                } else if (check_MCU("LPDDR2") or check_MCU("LPDDR3")) {
                    DDRPERFM.limit = .{
                        .min = 1e7,
                        .max = 5.33e8,
                    };

                    break :blk null;
                }
                DDRPERFM.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF USBOHSFreq_Value VALUE
            _ = blk: {
                USBOFSCLKOutput.limit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PLLDSIVCOFreq_Value VALUE
            _ = blk: {
                VCOoutput.limit = .{
                    .min = 1e9,
                    .max = 2e9,
                };

                break :blk null;
            };

            //POST CLOCK REF PLLDSIFreq_Value VALUE
            _ = blk: {
                PLLDSIoutput.limit = .{
                    .min = 6.25e7,
                    .max = 1e9,
                };

                break :blk null;
            };

            //POST CLOCK REF DSI_VALUE VALUE
            _ = blk: {
                DSIPHYCLK.limit = .{
                    .min = null,
                    .max = 1.25e9,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOInput1Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    VCOInput.limit = .{
                        .min = 8e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput2Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCO2Input.limit = .{
                        .min = 8e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCO2Input.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput3Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCO3Input.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCO3Input.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInput4Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL4UsedValue), PLL4UsedValue, 1, .@"="))) {
                    VCO4Input.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCO4Input.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCO1OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    VCO1Output.limit = .{
                        .min = 8e8,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                VCO1Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP1Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL1UsedValue), PLL1UsedValue, 1, .@"="))) {
                    PLL1CLK.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                PLL1CLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCO2OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"="))) {
                    VCO2Output.limit = .{
                        .min = 8e8,
                        .max = 1.6e9,
                    };

                    break :blk null;
                }
                VCO2Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP2Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"="))) {
                    PLL2CLK.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                PLL2CLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCO3OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"="))) {
                    VCO3Output.limit = .{
                        .min = 4e8,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                VCO3Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCO4OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL4UsedValue), PLL4UsedValue, 1, .@"="))) {
                    VCO4Output.limit = .{
                        .min = 4e8,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                VCO4Output.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF DIVP3Freq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"="))) {
                    PLL3CLK.limit = .{
                        .min = null,
                        .max = 8e8,
                    };

                    break :blk null;
                }
                PLL3CLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF MCUDIVCLKFreq_Value VALUE
            _ = blk: {
                MCUDIVCLK.limit = .{
                    .min = null,
                    .max = 2.09e8,
                };

                break :blk null;
            };

            out.McuClockOutput = try McuClockOutput.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.LPTIM23output = try LPTIM23output.get_output();
            out.LPTIM23Mult = try LPTIM23Mult.get_output();
            out.LPTIM45output = try LPTIM45output.get_output();
            out.LPTIM45Mult = try LPTIM45Mult.get_output();
            out.APB3DIV = try APB3DIV.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.Tim1Output = try Tim1Output.get_output();
            out.Tim1Mul = try Tim1Mul.get_output();
            out.I2C12output = try I2C12output.get_output();
            out.I2C12Mult = try I2C12Mult.get_output();
            out.I2C35output = try I2C35output.get_output();
            out.I2C35Mult = try I2C35Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.USART24output = try USART24output.get_output();
            out.USART24Mult = try USART24Mult.get_output();
            out.USART35output = try USART35output.get_output();
            out.USART35Mult = try USART35Mult.get_output();
            out.USART78output = try USART78output.get_output();
            out.UART78Mult = try UART78Mult.get_output();
            out.APB1DIV = try APB1DIV.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.Tim2Output = try Tim2Output.get_output();
            out.Tim2Mul = try Tim2Mul.get_output();
            out.SPI45output = try SPI45output.get_output();
            out.SPI45Mult = try SPI45Mult.get_output();
            out.USART6output = try USART6output.get_output();
            out.USART6Mult = try USART6Mult.get_output();
            out.APB2DIV = try APB2DIV.get_output();
            out.SDMMC3output = try SDMMC3output.get_output();
            out.SDMMC3Mult = try SDMMC3Mult.get_output();
            out.DCMI = try DCMI.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.DFSDM1Output = try DFSDM1Output.get_output();
            out.MCUDIV = try MCUDIV.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.DIVP3 = try DIVP3.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.I2C46output = try I2C46output.get_output();
            out.I2C46Mult = try I2C46Mult.get_output();
            out.DIVQ3output = try DIVQ3output.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.DFSDF1Audiooutput = try DFSDF1Audiooutput.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI3output = try SAI3output.get_output();
            out.SAI3Mult = try SAI3Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.SPI23output = try SPI23output.get_output();
            out.SPI23Mult = try SPI23Mult.get_output();
            out.SAI4output = try SAI4output.get_output();
            out.SAI4Mult = try SAI4Mult.get_output();
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
            out.SDMMC12output = try SDMMC12output.get_output();
            out.SDMMC12Mult = try SDMMC12Mult.get_output();
            out.DIVR3 = try DIVR3.get_output();
            out.DIVN3 = try DIVN3.get_output();
            out.DIVM3 = try DIVM3.get_output();
            out.PLL3Source = try PLL3Source.get_output();
            out.DIVP4output = try DIVP4output.get_output();
            out.PLL4DSIInput = try PLL4DSIInput.get_output();
            out.DIVP4 = try DIVP4.get_output();
            out.DIVQ4output = try DIVQ4output.get_output();
            out.LTDCOutput = try LTDCOutput.get_output();
            out.DSIPixel = try DSIPixel.get_output();
            out.DIVQ4 = try DIVQ4.get_output();
            out.DIVR4output = try DIVR4output.get_output();
            out.RNG1output = try RNG1output.get_output();
            out.RNG1Mult = try RNG1Mult.get_output();
            out.RNG2output = try RNG2output.get_output();
            out.RNG2Mult = try RNG2Mult.get_output();
            out.USBPHYCLKOutput = try USBPHYCLKOutput.get_output();
            out.USBPHYCLKMux = try USBPHYCLKMux.get_output();
            out.USBOFSCLKOutput = try USBOFSCLKOutput.get_output();
            out.USBOCLKMux = try USBOCLKMux.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
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
            out.CECoutput = try CECoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.DACCLKOutput = try DACCLKOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSICECDevisor = try CSICECDevisor.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.PLL1FRACV = try PLL1FRACV.get_output();
            out.PLL2FRACV = try PLL2FRACV.get_output();
            out.PLL3FRACV = try PLL3FRACV.get_output();
            out.PLL4FRACV = try PLL4FRACV.get_output();
            out.DSIoutput = try DSIoutput.get_output();
            out.DSITXCLKEsc = try DSITXCLKEsc.get_output();
            out.DSITXPrescaler = try DSITXPrescaler.get_output();
            out.DSIMult = try DSIMult.get_output();
            out.DSIPHYPrescaler = try DSIPHYPrescaler.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.PUBL = try PUBL.get_output();
            out.DDRC = try DDRC.get_output();
            out.DDRPERFM = try DDRPERFM.get_output();
            out.USBPHYRC = try USBPHYRC.get_output();
            out.PLLDSIoutput = try PLLDSIoutput.get_output();
            out.PLLDSIODF = try PLLDSIODF.get_output();
            out.PLLDSIDevisor = try PLLDSIDevisor.get_output();
            out.VCOoutput = try VCOoutput.get_output();
            out.PLLDSINDIV = try PLLDSINDIV.get_output();
            out.PLLDSIMultiplicator = try PLLDSIMultiplicator.get_output();
            out.PLLDSIIDF = try PLLDSIIDF.get_output();
            out.DSIPHYCLK = try DSIPHYCLK.get_extra_output();
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
            out.MCUDIVCLK = try MCUDIVCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSIDivValue = HSIDivValueValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.CSI_VALUE = CSI_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.MCUCLKSource = MCUCLKSourceValue;
            ref_out.MPUCLKSource = MPUCLKSourceValue;
            ref_out.CKPERCLKSource = CKPERCLKSourceValue;
            ref_out.AXICLKSource = AXICLKSourceValue;
            ref_out.AXI_Div = AXI_DivValue;
            ref_out.APB4DIV = APB4DIVValue;
            ref_out.APB5DIV = APB5DIVValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.MCU_Div = MCU_DivValue;
            ref_out.Cortex_Div = Cortex_DivValue;
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
            ref_out.DSIPHY_Div = DSIPHY_DivValue;
            ref_out.DSICLockSelection = DSICLockSelectionValue;
            ref_out.DSITX_Div = DSITX_DivValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.I2C12CLockSelection = I2C12CLockSelectionValue;
            ref_out.I2C35CLockSelection = I2C35CLockSelectionValue;
            ref_out.I2C46CLockSelection = I2C46CLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.QSPICLockSelection = QSPICLockSelectionValue;
            ref_out.FMCCLockSelection = FMCCLockSelectionValue;
            ref_out.SDMMC12CLockSelection = SDMMC12CLockSelectionValue;
            ref_out.SDMMC3CLockSelection = SDMMC3CLockSelectionValue;
            ref_out.STGENCLockSelection = STGENCLockSelectionValue;
            ref_out.LPTIM45CLockSelection = LPTIM45CLockSelectionValue;
            ref_out.LPTIM23CLockSelection = LPTIM23CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USART24CLockSelection = USART24CLockSelectionValue;
            ref_out.USART35CLockSelection = USART35CLockSelectionValue;
            ref_out.USART6CLockSelection = USART6CLockSelectionValue;
            ref_out.UART78CLockSelection = UART78CLockSelectionValue;
            ref_out.RNG1CLockSelection = RNG1CLockSelectionValue;
            ref_out.RNG2CLockSelection = RNG2CLockSelectionValue;
            ref_out.SPI6CLockSelection = SPI6CLockSelectionValue;
            ref_out.SPI45CLockSelection = SPI45CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.SAI4CLockSelection = SAI4CLockSelectionValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI23CLockSelection = SPI23CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI3CLockSelection = SAI3CLockSelectionValue;
            ref_out.FDCANCLockSelection = FDCANCLockSelectionValue;
            ref_out.ETH1CLockSelection = ETH1CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.RCC_CEC_Clock_Source_FROM_CSI = RCC_CEC_Clock_Source_FROM_CSIValue;
            ref_out.CECCLockSelection = CECCLockSelectionValue;
            ref_out.RCC_USBPHY_Clock_Source_FROM_HSE = RCC_USBPHY_Clock_Source_FROM_HSEValue;
            ref_out.USBPHYCLKSource = USBPHYCLKSourceValue;
            ref_out.USB_PHY_VALUE = USB_PHY_VALUEValue;
            ref_out.USBOCLKSource = USBOCLKSourceValue;
            ref_out.PLLDSIIDF = PLLDSIIDFValue;
            ref_out.PLLDSIMult = PLLDSIMultValue;
            ref_out.PLLDSINDIV = PLLDSINDIVValue;
            ref_out.PLLDSIDev = PLLDSIDevValue;
            ref_out.PLLDSIODF = PLLDSIODFValue;
            ref_out.RCC_TIM_G1_PRescaler_Selection = RCC_TIM_G1_PRescaler_SelectionValue;
            ref_out.RCC_TIM_G2_PRescaler_Selection = RCC_TIM_G2_PRescaler_SelectionValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
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
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.PLL1UserDefinedConfigEnable = PLL1UserDefinedConfigEnableValue;
            ref_out.cKPerEnable = cKPerEnableValue;
            ref_out.DACEnable = DACEnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.DFSDMEnable = DFSDMEnableValue;
            ref_out.GPUEnable = GPUEnableValue;
            ref_out.DDREnable = DDREnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.ETH1Enable = ETH1EnableValue;
            ref_out.EnableDFSDMAudio = EnableDFSDMAudioValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.I2C46Enable = I2C46EnableValue;
            ref_out.SPDIFEnable = SPDIFEnableValue;
            ref_out.SAI2Enable = SAI2EnableValue;
            ref_out.SAI3Enable = SAI3EnableValue;
            ref_out.SAI4Enable = SAI4EnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.LPTIM45Enable = LPTIM45EnableValue;
            ref_out.SPI6Enable = SPI6EnableValue;
            ref_out.SPI1Enable = SPI1EnableValue;
            ref_out.SPI23Enable = SPI23EnableValue;
            ref_out.SPI45Enable = SPI45EnableValue;
            ref_out.FDCANEnable = FDCANEnableValue;
            ref_out.SDMMC12Enable = SDMMC12EnableValue;
            ref_out.SDMMC3Enable = SDMMC3EnableValue;
            ref_out.QuadSPIEnable = QuadSPIEnableValue;
            ref_out.FMCEnable = FMCEnableValue;
            ref_out.LTDCEnable = LTDCEnableValue;
            ref_out.EnablePLLRDSI = EnablePLLRDSIValue;
            ref_out.EnableHSEDSI = EnableHSEDSIValue;
            ref_out.UART78Enable = UART78EnableValue;
            ref_out.USART35Enable = USART35EnableValue;
            ref_out.USART24Enable = USART24EnableValue;
            ref_out.LPTIM23Enable = LPTIM23EnableValue;
            ref_out.USART6Enable = USART6EnableValue;
            ref_out.EnableUSBOFS = EnableUSBOFSValue;
            ref_out.EnableUSBOHS = EnableUSBOHSValue;
            ref_out.I2C35Enable = I2C35EnableValue;
            ref_out.I2C12Enable = I2C12EnableValue;
            ref_out.RNG1Enable = RNG1EnableValue;
            ref_out.RNG2Enable = RNG2EnableValue;
            ref_out.DCMIEnable = DCMIEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.STGENEnable = STGENEnableValue;
            ref_out.CECEnable = CECEnableValue;
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
            ref_out.MCO2I2SEnable = MCO2I2SEnableValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
