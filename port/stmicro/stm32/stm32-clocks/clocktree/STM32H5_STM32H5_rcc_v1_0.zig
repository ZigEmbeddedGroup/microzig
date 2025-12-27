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
pub const UART7CLockSelectionList = enum {
    RCC_UART7CLKSOURCE_PCLK1,
    RCC_UART7CLKSOURCE_PLL2Q,
    RCC_UART7CLKSOURCE_HSI,
    RCC_UART7CLKSOURCE_LSE,
    RCC_UART7CLKSOURCE_CSI,
    RCC_UART7CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART7CLKSOURCE_PCLK1 => 0,
            .RCC_UART7CLKSOURCE_PLL2Q => 1,
            .RCC_UART7CLKSOURCE_HSI => 2,
            .RCC_UART7CLKSOURCE_LSE => 3,
            .RCC_UART7CLKSOURCE_CSI => 4,
            .RCC_UART7CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const UART9CLockSelectionList = enum {
    RCC_UART9CLKSOURCE_PCLK1,
    RCC_UART9CLKSOURCE_PLL2Q,
    RCC_UART9CLKSOURCE_HSI,
    RCC_UART9CLKSOURCE_LSE,
    RCC_UART9CLKSOURCE_CSI,
    RCC_UART9CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART9CLKSOURCE_PCLK1 => 0,
            .RCC_UART9CLKSOURCE_PLL2Q => 1,
            .RCC_UART9CLKSOURCE_HSI => 2,
            .RCC_UART9CLKSOURCE_LSE => 3,
            .RCC_UART9CLKSOURCE_CSI => 4,
            .RCC_UART9CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const UART8CLockSelectionList = enum {
    RCC_UART8CLKSOURCE_PCLK1,
    RCC_UART8CLKSOURCE_PLL2Q,
    RCC_UART8CLKSOURCE_HSI,
    RCC_UART8CLKSOURCE_LSE,
    RCC_UART8CLKSOURCE_CSI,
    RCC_UART8CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART8CLKSOURCE_PCLK1 => 0,
            .RCC_UART8CLKSOURCE_PLL2Q => 1,
            .RCC_UART8CLKSOURCE_HSI => 2,
            .RCC_UART8CLKSOURCE_LSE => 3,
            .RCC_UART8CLKSOURCE_CSI => 4,
            .RCC_UART8CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const USART10CLockSelectionList = enum {
    RCC_USART10CLKSOURCE_PCLK1,
    RCC_USART10CLKSOURCE_PLL2Q,
    RCC_USART10CLKSOURCE_HSI,
    RCC_USART10CLKSOURCE_LSE,
    RCC_USART10CLKSOURCE_CSI,
    RCC_USART10CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART10CLKSOURCE_PCLK1 => 0,
            .RCC_USART10CLKSOURCE_PLL2Q => 1,
            .RCC_USART10CLKSOURCE_HSI => 2,
            .RCC_USART10CLKSOURCE_LSE => 3,
            .RCC_USART10CLKSOURCE_CSI => 4,
            .RCC_USART10CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const USART11CLockSelectionList = enum {
    RCC_USART11CLKSOURCE_PCLK1,
    RCC_USART11CLKSOURCE_PLL2Q,
    RCC_USART11CLKSOURCE_HSI,
    RCC_USART11CLKSOURCE_LSE,
    RCC_USART11CLKSOURCE_CSI,
    RCC_USART11CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART11CLKSOURCE_PCLK1 => 0,
            .RCC_USART11CLKSOURCE_PLL2Q => 1,
            .RCC_USART11CLKSOURCE_HSI => 2,
            .RCC_USART11CLKSOURCE_LSE => 3,
            .RCC_USART11CLKSOURCE_CSI => 4,
            .RCC_USART11CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const UART12CLockSelectionList = enum {
    RCC_UART12CLKSOURCE_PCLK1,
    RCC_UART12CLKSOURCE_PLL2Q,
    RCC_UART12CLKSOURCE_HSI,
    RCC_UART12CLKSOURCE_LSE,
    RCC_UART12CLKSOURCE_CSI,
    RCC_UART12CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART12CLKSOURCE_PCLK1 => 0,
            .RCC_UART12CLKSOURCE_PLL2Q => 1,
            .RCC_UART12CLKSOURCE_HSI => 2,
            .RCC_UART12CLKSOURCE_LSE => 3,
            .RCC_UART12CLKSOURCE_CSI => 4,
            .RCC_UART12CLKSOURCE_PLL3Q => 5,
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
pub const SDMMC2ClockSelectionList = enum {
    RCC_SDMMC2CLKSOURCE_PLL1Q,
    RCC_SDMMC2CLKSOURCE_PLL2R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC2CLKSOURCE_PLL1Q => 0,
            .RCC_SDMMC2CLKSOURCE_PLL2R => 1,
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
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL2P,
    RCC_SAI1CLKSOURCE_PLL3P,
    RCC_SAI1CLKSOURCE_PLL1Q,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL2P => 0,
            .RCC_SAI1CLKSOURCE_PLL3P => 1,
            .RCC_SAI1CLKSOURCE_PLL1Q => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_CLKP => 4,
        };
    }
};
pub const SAI2CLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLL2P,
    RCC_SAI2CLKSOURCE_PLL3P,
    RCC_SAI2CLKSOURCE_PLL1Q,
    RCC_SAI2CLKSOURCE_PIN,
    RCC_SAI2CLKSOURCE_CLKP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLL2P => 0,
            .RCC_SAI2CLKSOURCE_PLL3P => 1,
            .RCC_SAI2CLKSOURCE_PLL1Q => 2,
            .RCC_SAI2CLKSOURCE_PIN => 3,
            .RCC_SAI2CLKSOURCE_CLKP => 4,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_PCLK3,
    RCC_I2C4CLKSOURCE_PLL3R,
    RCC_I2C4CLKSOURCE_HSI,
    RCC_I2C4CLKSOURCE_CSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_PCLK3 => 0,
            .RCC_I2C4CLKSOURCE_PLL3R => 1,
            .RCC_I2C4CLKSOURCE_HSI => 2,
            .RCC_I2C4CLKSOURCE_CSI => 3,
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
pub const LPTIM3CLockSelectionList = enum {
    RCC_LPTIM3CLKSOURCE_PCLK3,
    RCC_LPTIM3CLKSOURCE_PLL2P,
    RCC_LPTIM3CLKSOURCE_LSE,
    RCC_LPTIM3CLKSOURCE_LSI,
    RCC_LPTIM3CLKSOURCE_CLKP,
    RCC_LPTIM3CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM3CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM3CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM3CLKSOURCE_LSE => 2,
            .RCC_LPTIM3CLKSOURCE_LSI => 3,
            .RCC_LPTIM3CLKSOURCE_CLKP => 4,
            .RCC_LPTIM3CLKSOURCE_PLL3R => 5,
        };
    }
};
pub const LPTIM4CLockSelectionList = enum {
    RCC_LPTIM4CLKSOURCE_PCLK3,
    RCC_LPTIM4CLKSOURCE_PLL2P,
    RCC_LPTIM4CLKSOURCE_LSE,
    RCC_LPTIM4CLKSOURCE_LSI,
    RCC_LPTIM4CLKSOURCE_CLKP,
    RCC_LPTIM4CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM4CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM4CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM4CLKSOURCE_LSE => 2,
            .RCC_LPTIM4CLKSOURCE_LSI => 3,
            .RCC_LPTIM4CLKSOURCE_CLKP => 4,
            .RCC_LPTIM4CLKSOURCE_PLL3R => 5,
        };
    }
};
pub const LPTIM5CLockSelectionList = enum {
    RCC_LPTIM5CLKSOURCE_PCLK3,
    RCC_LPTIM5CLKSOURCE_PLL2P,
    RCC_LPTIM5CLKSOURCE_LSE,
    RCC_LPTIM5CLKSOURCE_LSI,
    RCC_LPTIM5CLKSOURCE_CLKP,
    RCC_LPTIM5CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM5CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM5CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM5CLKSOURCE_LSE => 2,
            .RCC_LPTIM5CLKSOURCE_LSI => 3,
            .RCC_LPTIM5CLKSOURCE_CLKP => 4,
            .RCC_LPTIM5CLKSOURCE_PLL3R => 5,
        };
    }
};
pub const LPTIM6CLockSelectionList = enum {
    RCC_LPTIM6CLKSOURCE_PCLK3,
    RCC_LPTIM6CLKSOURCE_PLL2P,
    RCC_LPTIM6CLKSOURCE_LSE,
    RCC_LPTIM6CLKSOURCE_LSI,
    RCC_LPTIM6CLKSOURCE_CLKP,
    RCC_LPTIM6CLKSOURCE_PLL3R,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM6CLKSOURCE_PCLK3 => 0,
            .RCC_LPTIM6CLKSOURCE_PLL2P => 1,
            .RCC_LPTIM6CLKSOURCE_LSE => 2,
            .RCC_LPTIM6CLKSOURCE_LSI => 3,
            .RCC_LPTIM6CLKSOURCE_CLKP => 4,
            .RCC_LPTIM6CLKSOURCE_PLL3R => 5,
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
pub const SPI5CLockSelectionList = enum {
    RCC_SPI5CLKSOURCE_PCLK3,
    RCC_SPI5CLKSOURCE_PLL2Q,
    RCC_SPI5CLKSOURCE_HSI,
    RCC_SPI5CLKSOURCE_CSI,
    RCC_SPI5CLKSOURCE_HSE,
    RCC_SPI5CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI5CLKSOURCE_PCLK3 => 0,
            .RCC_SPI5CLKSOURCE_PLL2Q => 1,
            .RCC_SPI5CLKSOURCE_HSI => 2,
            .RCC_SPI5CLKSOURCE_CSI => 3,
            .RCC_SPI5CLKSOURCE_HSE => 4,
            .RCC_SPI5CLKSOURCE_PLL3Q => 5,
        };
    }
};
pub const SPI6CLockSelectionList = enum {
    RCC_SPI6CLKSOURCE_PCLK2,
    RCC_SPI6CLKSOURCE_PLL2Q,
    RCC_SPI6CLKSOURCE_HSI,
    RCC_SPI6CLKSOURCE_CSI,
    RCC_SPI6CLKSOURCE_HSE,
    RCC_SPI6CLKSOURCE_PLL3Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_PCLK2 => 0,
            .RCC_SPI6CLKSOURCE_PLL2Q => 1,
            .RCC_SPI6CLKSOURCE_HSI => 2,
            .RCC_SPI6CLKSOURCE_CSI => 3,
            .RCC_SPI6CLKSOURCE_HSE => 4,
            .RCC_SPI6CLKSOURCE_PLL3Q => 5,
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
pub const SDMMC2EnableList = enum {
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
pub const UART7EnableList = enum {
    true,
    false,
};
pub const UART9EnableList = enum {
    true,
    false,
};
pub const UART8EnableList = enum {
    true,
    false,
};
pub const USART10EnableList = enum {
    true,
    false,
};
pub const USART11EnableList = enum {
    true,
    false,
};
pub const UART12EnableList = enum {
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
pub const ETHEnableList = enum {
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
pub const I3C1EnableList = enum {
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
pub const LPTIM4EnableList = enum {
    true,
    false,
};
pub const LPTIM5EnableList = enum {
    true,
    false,
};
pub const LPTIM6EnableList = enum {
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
pub const SPI5EnableList = enum {
    true,
    false,
};
pub const SPI6EnableList = enum {
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
            LSEDIGByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            MCO2Config: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            RNGUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART9Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            USART10Used_ForRCC: bool = false,
            USART11Used_ForRCC: bool = false,
            UART12Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            I3C1Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            LPTIM6Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            DAC1_Used: bool = false,
            ADC1_Used: bool = false,
            ADC2_Used: bool = false,
            LCDUsed_ForRCC: bool = false,
            UCPD_Used: bool = false,
            OCTOSPI1_Used: bool = false,
            SAI2_Used: bool = false,
            SAI1_Used: bool = false,
            LPTIM6_Used: bool = false,
            USB_Used: bool = false,
            SDMMC1_Used: bool = false,
            SDMMC2_Used: bool = false,
            HDMI_CEC_Used: bool = false,
            ETH_Used: bool = false,
            FDCAN2_Used: bool = false,
            SPI1_Used: bool = false,
            I2S1_Used: bool = false,
            SPI2_Used: bool = false,
            I2S2_Used: bool = false,
            SPI3_Used: bool = false,
            I2S3_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM2_Used: bool = false,
            LPTIM3_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM5_Used: bool = false,
            FDCAN1_Used: bool = false,
            OCTOSPI2_Used: bool = false,
            RNG_Used: bool = false,
            USART1_Used: bool = false,
            USART2_Used: bool = false,
            USART3_Used: bool = false,
            UART4_Used: bool = false,
            UART5_Used: bool = false,
            USART6_Used: bool = false,
            USART7_Used: bool = false,
            USART9_Used: bool = false,
            UART8_Used: bool = false,
            USART10_Used: bool = false,
            USART11_Used: bool = false,
            UART12_Used: bool = false,
            LPUART1_Used: bool = false,
            SPI4_Used: bool = false,
            SPI5_Used: bool = false,
            SPI6_Used: bool = false,
            DAC2_Used: bool = false,
            UART7_Used: bool = false,
            UART9_Used: bool = false,
            USART10__Used: bool = false,
            I3C1_Used: bool = false,
            I2C4_Used: bool = false,
            I2C3_Used: bool = false,
            I2C2_Used: bool = false,
            I2C1_Used: bool = false,
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
            EnbaleCSS: ?EnbaleCSSList = null,
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
            UART7CLockSelection: ?UART7CLockSelectionList = null,
            UART9CLockSelection: ?UART9CLockSelectionList = null,
            UART8CLockSelection: ?UART8CLockSelectionList = null,
            USART10CLockSelection: ?USART10CLockSelectionList = null,
            USART11CLockSelection: ?USART11CLockSelectionList = null,
            UART12CLockSelection: ?UART12CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            DACLowPowerCLockSelection: ?DACLowPowerCLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null,
            SDMMC2ClockSelection: ?SDMMC2ClockSelectionList = null,
            FDCANClockSelection: ?FDCANClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            SAI2CLockSelection: ?SAI2CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            I3C1CLockSelection: ?I3C1CLockSelectionList = null,
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            LPTIM4CLockSelection: ?LPTIM4CLockSelectionList = null,
            LPTIM5CLockSelection: ?LPTIM5CLockSelectionList = null,
            LPTIM6CLockSelection: ?LPTIM6CLockSelectionList = null,
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
            SPI5CLockSelection: ?SPI5CLockSelectionList = null,
            SPI6CLockSelection: ?SPI6CLockSelectionList = null,
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
            UART7Mult: f32 = 0,
            UART7output: f32 = 0,
            UART9Mult: f32 = 0,
            UART9output: f32 = 0,
            UART8Mult: f32 = 0,
            UART8output: f32 = 0,
            USART10Mult: f32 = 0,
            USART10output: f32 = 0,
            USART11Mult: f32 = 0,
            USART11output: f32 = 0,
            UART12Mult: f32 = 0,
            UART12output: f32 = 0,
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
            ETHoutput: f32 = 0,
            USBoutput: f32 = 0,
            SDMMC1Mult: f32 = 0,
            SDMMC1Output: f32 = 0,
            SDMMC2Mult: f32 = 0,
            SDMMC2Output: f32 = 0,
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
            I3C1Mult: f32 = 0,
            I3C1output: f32 = 0,
            OCTOSPIMMult: f32 = 0,
            OCTOSPIMoutput: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            LPTIM4Mult: f32 = 0,
            LPTIM4output: f32 = 0,
            LPTIM5Mult: f32 = 0,
            LPTIM5output: f32 = 0,
            LPTIM6Mult: f32 = 0,
            LPTIM6output: f32 = 0,
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
            SPI5Mult: f32 = 0,
            SPI5output: f32 = 0,
            SPI6Mult: f32 = 0,
            SPI6output: f32 = 0,
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
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
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
            RNGUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            USART6Used_ForRCC: bool = false,
            UART7Used_ForRCC: bool = false,
            UART9Used_ForRCC: bool = false,
            UART8Used_ForRCC: bool = false,
            USART10Used_ForRCC: bool = false,
            USART11Used_ForRCC: bool = false,
            UART12Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            USE_ADC1: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            USE_ADC2: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            FDCAN1Used_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            SAI2_SAIBUsed_ForRCC: bool = false,
            SAI2_SAIAUsed_ForRCC: bool = false,
            I2C4Used_ForRCC: bool = false,
            I3C1Used_ForRCC: bool = false,
            OCTOSPI1Used_ForRCC: bool = false,
            OCTOSPI2Used_ForRCC: bool = false,
            LPTIM3Used_ForRCC: bool = false,
            LPTIM4Used_ForRCC: bool = false,
            LPTIM5Used_ForRCC: bool = false,
            LPTIM6Used_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            SPI4Used_ForRCC: bool = false,
            SPI5Used_ForRCC: bool = false,
            SPI6Used_ForRCC: bool = false,
            SPI2Used_ForRCC: bool = false,
            DAC1_Used: bool = false,
            ADC1_Used: bool = false,
            ADC2_Used: bool = false,
            LCDUsed_ForRCC: bool = false,
            UCPD_Used: bool = false,
            OCTOSPI1_Used: bool = false,
            SAI2_Used: bool = false,
            SAI1_Used: bool = false,
            LPTIM6_Used: bool = false,
            USB_Used: bool = false,
            SDMMC1_Used: bool = false,
            SDMMC2_Used: bool = false,
            HDMI_CEC_Used: bool = false,
            ETH_Used: bool = false,
            FDCAN2_Used: bool = false,
            SPI1_Used: bool = false,
            I2S1_Used: bool = false,
            SPI2_Used: bool = false,
            I2S2_Used: bool = false,
            SPI3_Used: bool = false,
            I2S3_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM2_Used: bool = false,
            LPTIM3_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM5_Used: bool = false,
            FDCAN1_Used: bool = false,
            OCTOSPI2_Used: bool = false,
            RNG_Used: bool = false,
            USART1_Used: bool = false,
            USART2_Used: bool = false,
            USART3_Used: bool = false,
            UART4_Used: bool = false,
            UART5_Used: bool = false,
            USART6_Used: bool = false,
            USART7_Used: bool = false,
            USART9_Used: bool = false,
            UART8_Used: bool = false,
            USART10_Used: bool = false,
            USART11_Used: bool = false,
            UART12_Used: bool = false,
            LPUART1_Used: bool = false,
            SPI4_Used: bool = false,
            SPI5_Used: bool = false,
            SPI6_Used: bool = false,
            DAC2_Used: bool = false,
            UART7_Used: bool = false,
            UART9_Used: bool = false,
            USART10__Used: bool = false,
            I3C1_Used: bool = false,
            I2C4_Used: bool = false,
            I2C3_Used: bool = false,
            I2C2_Used: bool = false,
            I2C1_Used: bool = false,
            EnableCRS: bool = false,
            USBEnable: bool = false,
            RNGEnable: bool = false,
            MCOEnable: bool = false,
            SDMMC1Enable: bool = false,
            SDMMC2Enable: bool = false,
            LSIEnable: bool = false,
            EnableExtClockForSAI1: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            CECEnable: bool = false,
            USART1Enable: bool = false,
            USART2Enable: bool = false,
            USART3Enable: bool = false,
            UART4Enable: bool = false,
            UART5Enable: bool = false,
            USART6Enable: bool = false,
            UART7Enable: bool = false,
            UART9Enable: bool = false,
            UART8Enable: bool = false,
            USART10Enable: bool = false,
            USART11Enable: bool = false,
            UART12Enable: bool = false,
            LPUART1Enable: bool = false,
            LPTIM1Enable: bool = false,
            LPTIM2Enable: bool = false,
            DACEnable: bool = false,
            ADCEnable: bool = false,
            ETHEnable: bool = false,
            FDCANEnable: bool = false,
            I2C1Enable: bool = false,
            I2C2Enable: bool = false,
            I2C3Enable: bool = false,
            SAI1Enable: bool = false,
            SAI2Enable: bool = false,
            I2C4Enable: bool = false,
            I3C1Enable: bool = false,
            OCTOSPIMEnable: bool = false,
            LPTIM3Enable: bool = false,
            LPTIM4Enable: bool = false,
            LPTIM5Enable: bool = false,
            LPTIM6Enable: bool = false,
            MCO2Enable: bool = false,
            LSCOEnable: bool = false,
            CKPEREnable: bool = false,
            SystickEnable: bool = false,
            UCPDEnable: bool = false,
            SPI1Enable: bool = false,
            SPI3Enable: bool = false,
            SPI4Enable: bool = false,
            SPI5Enable: bool = false,
            SPI6Enable: bool = false,
            SPI2Enable: bool = false,
            PLL1QUsed: bool = false,
            PLL2PUsed: bool = false,
            PLL2QUsed: bool = false,
            PLL2RUsed: bool = false,
            PLL3PUsed: bool = false,
            PLL3QUsed: bool = false,
            PLLUsed: bool = false,
            PLL2Used: bool = false,
            PLL3Used: bool = false,
            PLL1PUsed: bool = false,
            LSEUsed: bool = false,
            EnableCSSLSE: bool = false,
            EnbaleCSS: bool = false,
            PLL3RUsed: bool = false,
            PLL1RUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSIDiv: ?HSIDivList = null, //from RCC Clock Config
            HSI48_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            CSI_VALUE: ?f32 = null, //from RCC Clock Config
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
            UART7CLockSelection: ?UART7CLockSelectionList = null, //from RCC Clock Config
            UART9CLockSelection: ?UART9CLockSelectionList = null, //from RCC Clock Config
            UART8CLockSelection: ?UART8CLockSelectionList = null, //from RCC Clock Config
            USART10CLockSelection: ?USART10CLockSelectionList = null, //from RCC Clock Config
            USART11CLockSelection: ?USART11CLockSelectionList = null, //from RCC Clock Config
            UART12CLockSelection: ?UART12CLockSelectionList = null, //from RCC Clock Config
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            DACLowPowerCLockSelection: ?DACLowPowerCLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null, //from RCC Clock Config
            SDMMC2ClockSelection: ?SDMMC2ClockSelectionList = null, //from RCC Clock Config
            FDCANClockSelection: ?FDCANClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from RCC Clock Config
            SAI2CLockSelection: ?SAI2CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            I3C1CLockSelection: ?I3C1CLockSelectionList = null, //from RCC Clock Config
            OCTOSPIMCLockSelection: ?OCTOSPIMCLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from RCC Clock Config
            LPTIM4CLockSelection: ?LPTIM4CLockSelectionList = null, //from RCC Clock Config
            LPTIM5CLockSelection: ?LPTIM5CLockSelectionList = null, //from RCC Clock Config
            LPTIM6CLockSelection: ?LPTIM6CLockSelectionList = null, //from RCC Clock Config
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
            SPI5CLockSelection: ?SPI5CLockSelectionList = null, //from RCC Clock Config
            SPI6CLockSelection: ?SPI6CLockSelectionList = null, //from RCC Clock Config
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
            var UART7_PLL2: bool = false;
            var UART7_HSI: bool = false;
            var UART7_LSE: bool = false;
            var UART7_CSI: bool = false;
            var UART7_PLL3: bool = false;
            var UART9_PLL2: bool = false;
            var UART9_HSI: bool = false;
            var UART9_LSE: bool = false;
            var UART9_CSI: bool = false;
            var UART9_PLL3: bool = false;
            var UART8_PLL2: bool = false;
            var UART8_HSI: bool = false;
            var UART8_LSE: bool = false;
            var UART8_CSI: bool = false;
            var UART8_PLL3: bool = false;
            var USART10_PLL2: bool = false;
            var USART10_HSI: bool = false;
            var USART10_LSE: bool = false;
            var USART10_CSI: bool = false;
            var USART10_PLL3: bool = false;
            var USART11_PLL2: bool = false;
            var USART11_HSI: bool = false;
            var USART11_LSE: bool = false;
            var USART11_CSI: bool = false;
            var USART11_PLL3: bool = false;
            var UART12_PLL2: bool = false;
            var UART12_HSI: bool = false;
            var UART12_LSE: bool = false;
            var UART12_CSI: bool = false;
            var UART12_PLL3: bool = false;
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
            var SDMMC2SourceIsPllQ: bool = false;
            var SDMMC2_PLL2: bool = false;
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
            var SAI1SourcePLL2P: bool = false;
            var SAI1SourcePLL3P: bool = false;
            var SAI1SourcePLL1Q: bool = false;
            var SAI1SourceEXT: bool = false;
            var SAI1_CLKP: bool = false;
            var SAI2SourcePLL2P: bool = false;
            var SAI2SourcePLL3P: bool = false;
            var SAI2SourcePLL1Q: bool = false;
            var SAI2SourceEXT: bool = false;
            var SAI2_CLKP: bool = false;
            var I2C4_PLL3: bool = false;
            var I2C4SourceHSI: bool = false;
            var I2C4SourceCSI: bool = false;
            var I3C1_PLL3: bool = false;
            var I3C1SourceHSI: bool = false;
            var OCTOSPI_PLL1Q: bool = false;
            var OCTOSPI_PLL2R: bool = false;
            var OSPI_CLKP: bool = false;
            var LPTIM3_PLL2: bool = false;
            var LPTIM3SOURCELSE: bool = false;
            var LPTIM3SOURCELSI: bool = false;
            var LPTIM3_CLKP: bool = false;
            var LPTIM3_PLL3: bool = false;
            var LPTIM4_PLL2: bool = false;
            var LPTIM4SOURCELSE: bool = false;
            var LPTIM4SOURCELSI: bool = false;
            var LPTIM4_CLKP: bool = false;
            var LPTIM4_PLL3: bool = false;
            var LPTIM5_PLL2: bool = false;
            var LPTIM5SOURCELSE: bool = false;
            var LPTIM5SOURCELSI: bool = false;
            var LPTIM5_CLKP: bool = false;
            var LPTIM5_PLL3: bool = false;
            var LPTIM6_PLL2: bool = false;
            var LPTIM6SOURCELSE: bool = false;
            var LPTIM6SOURCELSI: bool = false;
            var LPTIM6_CLKP: bool = false;
            var LPTIM6_PLL3: bool = false;
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
            var SPI5_PLL2: bool = false;
            var SPI5_HSI: bool = false;
            var SPI5_CSI: bool = false;
            var SPI5_HSE: bool = false;
            var SPI5_PLL3: bool = false;
            var SPI6_PLL2: bool = false;
            var SPI6_HSI: bool = false;
            var SPI6_CSI: bool = false;
            var SPI6_HSE: bool = false;
            var SPI6_PLL3: bool = false;
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

            var UART7Mult = ClockNode{
                .name = "UART7Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART7output = ClockNode{
                .name = "UART7output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART9Mult = ClockNode{
                .name = "UART9Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART9output = ClockNode{
                .name = "UART9output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART8Mult = ClockNode{
                .name = "UART8Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART8output = ClockNode{
                .name = "UART8output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART10Mult = ClockNode{
                .name = "USART10Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART10output = ClockNode{
                .name = "USART10output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART11Mult = ClockNode{
                .name = "USART11Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART11output = ClockNode{
                .name = "USART11output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART12Mult = ClockNode{
                .name = "UART12Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART12output = ClockNode{
                .name = "UART12output",
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

            var ETHoutput = ClockNode{
                .name = "ETHoutput",
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

            var SDMMC2Mult = ClockNode{
                .name = "SDMMC2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDMMC2Output = ClockNode{
                .name = "SDMMC2Output",
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

            var LPTIM4Mult = ClockNode{
                .name = "LPTIM4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM4output = ClockNode{
                .name = "LPTIM4output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM5Mult = ClockNode{
                .name = "LPTIM5Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM5output = ClockNode{
                .name = "LPTIM5output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM6Mult = ClockNode{
                .name = "LPTIM6Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM6output = ClockNode{
                .name = "LPTIM6output",
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
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

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
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
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
                    CEC_LSI = true;
                    break :blk .RCC_CECCLKSOURCE_LSI;
                };
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
            const UART7CLockSelectionValue: ?UART7CLockSelectionList = blk: {
                const conf_item = config.UART7CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART7CLKSOURCE_PCLK1 => {},
                        .RCC_UART7CLKSOURCE_PLL2Q => UART7_PLL2 = true,
                        .RCC_UART7CLKSOURCE_PLL3Q => UART7_PLL3 = true,
                        .RCC_UART7CLKSOURCE_HSI => UART7_HSI = true,
                        .RCC_UART7CLKSOURCE_LSE => UART7_LSE = true,
                        .RCC_UART7CLKSOURCE_CSI => UART7_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART7CLKSOURCE_PCLK1;
            };
            const UART9CLockSelectionValue: ?UART9CLockSelectionList = blk: {
                const conf_item = config.UART9CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART9CLKSOURCE_PCLK1 => {},
                        .RCC_UART9CLKSOURCE_PLL2Q => UART9_PLL2 = true,
                        .RCC_UART9CLKSOURCE_PLL3Q => UART9_PLL3 = true,
                        .RCC_UART9CLKSOURCE_HSI => UART9_HSI = true,
                        .RCC_UART9CLKSOURCE_LSE => UART9_LSE = true,
                        .RCC_UART9CLKSOURCE_CSI => UART9_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART9CLKSOURCE_PCLK1;
            };
            const UART8CLockSelectionValue: ?UART8CLockSelectionList = blk: {
                const conf_item = config.UART8CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART8CLKSOURCE_PCLK1 => {},
                        .RCC_UART8CLKSOURCE_PLL2Q => UART8_PLL2 = true,
                        .RCC_UART8CLKSOURCE_PLL3Q => UART8_PLL3 = true,
                        .RCC_UART8CLKSOURCE_HSI => UART8_HSI = true,
                        .RCC_UART8CLKSOURCE_LSE => UART8_LSE = true,
                        .RCC_UART8CLKSOURCE_CSI => UART8_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART8CLKSOURCE_PCLK1;
            };
            const USART10CLockSelectionValue: ?USART10CLockSelectionList = blk: {
                const conf_item = config.USART10CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART10CLKSOURCE_PCLK1 => {},
                        .RCC_USART10CLKSOURCE_PLL2Q => USART10_PLL2 = true,
                        .RCC_USART10CLKSOURCE_PLL3Q => USART10_PLL3 = true,
                        .RCC_USART10CLKSOURCE_HSI => USART10_HSI = true,
                        .RCC_USART10CLKSOURCE_LSE => USART10_LSE = true,
                        .RCC_USART10CLKSOURCE_CSI => USART10_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART10CLKSOURCE_PCLK1;
            };
            const USART11CLockSelectionValue: ?USART11CLockSelectionList = blk: {
                const conf_item = config.USART11CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART11CLKSOURCE_PCLK1 => {},
                        .RCC_USART11CLKSOURCE_PLL2Q => USART11_PLL2 = true,
                        .RCC_USART11CLKSOURCE_PLL3Q => USART11_PLL3 = true,
                        .RCC_USART11CLKSOURCE_HSI => USART11_HSI = true,
                        .RCC_USART11CLKSOURCE_LSE => USART11_LSE = true,
                        .RCC_USART11CLKSOURCE_CSI => USART11_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART11CLKSOURCE_PCLK1;
            };
            const UART12CLockSelectionValue: ?UART12CLockSelectionList = blk: {
                const conf_item = config.UART12CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART12CLKSOURCE_PCLK1 => {},
                        .RCC_UART12CLKSOURCE_PLL2Q => UART12_PLL2 = true,
                        .RCC_UART12CLKSOURCE_PLL3Q => UART12_PLL3 = true,
                        .RCC_UART12CLKSOURCE_HSI => UART12_HSI = true,
                        .RCC_UART12CLKSOURCE_LSE => UART12_LSE = true,
                        .RCC_UART12CLKSOURCE_CSI => UART12_CSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART12CLKSOURCE_PCLK1;
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
            const SDMMC2ClockSelectionValue: ?SDMMC2ClockSelectionList = blk: {
                const conf_item = config.SDMMC2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC2CLKSOURCE_PLL1Q => SDMMC2SourceIsPllQ = true,
                        .RCC_SDMMC2CLKSOURCE_PLL2R => SDMMC2_PLL2 = true,
                    }
                }

                break :blk conf_item orelse {
                    SDMMC2SourceIsPllQ = true;
                    break :blk .RCC_SDMMC2CLKSOURCE_PLL1Q;
                };
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
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL2P => SAI1SourcePLL2P = true,
                        .RCC_SAI1CLKSOURCE_PLL3P => SAI1SourcePLL3P = true,
                        .RCC_SAI1CLKSOURCE_PLL1Q => SAI1SourcePLL1Q = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                        .RCC_SAI1CLKSOURCE_CLKP => SAI1_CLKP = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI1SourcePLL2P = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLL2P;
                };
            };
            const SAI2CLockSelectionValue: ?SAI2CLockSelectionList = blk: {
                const conf_item = config.SAI2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLL2P => SAI2SourcePLL2P = true,
                        .RCC_SAI2CLKSOURCE_PLL3P => SAI2SourcePLL3P = true,
                        .RCC_SAI2CLKSOURCE_PLL1Q => SAI2SourcePLL1Q = true,
                        .RCC_SAI2CLKSOURCE_PIN => SAI2SourceEXT = true,
                        .RCC_SAI2CLKSOURCE_CLKP => SAI2_CLKP = true,
                    }
                }

                break :blk conf_item orelse {
                    SAI2SourcePLL2P = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLL2P;
                };
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_PCLK3 => {},
                        .RCC_I2C4CLKSOURCE_PLL3R => I2C4_PLL3 = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4SourceHSI = true,
                        .RCC_I2C4CLKSOURCE_CSI => I2C4SourceCSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C4CLKSOURCE_PCLK3;
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
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
                const conf_item = config.LPTIM3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM3CLKSOURCE_LSI => LPTIM3SOURCELSI = true,
                        .RCC_LPTIM3CLKSOURCE_PCLK3 => {},
                        .RCC_LPTIM3CLKSOURCE_LSE => LPTIM3SOURCELSE = true,
                        .RCC_LPTIM3CLKSOURCE_PLL2P => LPTIM3_PLL2 = true,
                        .RCC_LPTIM3CLKSOURCE_PLL3R => LPTIM3_PLL3 = true,
                        .RCC_LPTIM3CLKSOURCE_CLKP => LPTIM3_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM3CLKSOURCE_PCLK3;
            };
            const LPTIM4CLockSelectionValue: ?LPTIM4CLockSelectionList = blk: {
                const conf_item = config.LPTIM4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM4CLKSOURCE_LSI => LPTIM4SOURCELSI = true,
                        .RCC_LPTIM4CLKSOURCE_PCLK3 => {},
                        .RCC_LPTIM4CLKSOURCE_LSE => LPTIM4SOURCELSE = true,
                        .RCC_LPTIM4CLKSOURCE_PLL2P => LPTIM4_PLL2 = true,
                        .RCC_LPTIM4CLKSOURCE_PLL3R => LPTIM4_PLL3 = true,
                        .RCC_LPTIM4CLKSOURCE_CLKP => LPTIM4_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM4CLKSOURCE_PCLK3;
            };
            const LPTIM5CLockSelectionValue: ?LPTIM5CLockSelectionList = blk: {
                const conf_item = config.LPTIM5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM5CLKSOURCE_LSI => LPTIM5SOURCELSI = true,
                        .RCC_LPTIM5CLKSOURCE_PCLK3 => {},
                        .RCC_LPTIM5CLKSOURCE_LSE => LPTIM5SOURCELSE = true,
                        .RCC_LPTIM5CLKSOURCE_PLL2P => LPTIM5_PLL2 = true,
                        .RCC_LPTIM5CLKSOURCE_PLL3R => LPTIM5_PLL3 = true,
                        .RCC_LPTIM5CLKSOURCE_CLKP => LPTIM5_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM5CLKSOURCE_PCLK3;
            };
            const LPTIM6CLockSelectionValue: ?LPTIM6CLockSelectionList = blk: {
                const conf_item = config.LPTIM6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM6CLKSOURCE_LSI => LPTIM6SOURCELSI = true,
                        .RCC_LPTIM6CLKSOURCE_PCLK3 => {},
                        .RCC_LPTIM6CLKSOURCE_LSE => LPTIM6SOURCELSE = true,
                        .RCC_LPTIM6CLKSOURCE_PLL2P => LPTIM6_PLL2 = true,
                        .RCC_LPTIM6CLKSOURCE_PLL3R => LPTIM6_PLL3 = true,
                        .RCC_LPTIM6CLKSOURCE_CLKP => LPTIM6_CLKP = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM6CLKSOURCE_PCLK3;
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
            const hsidivToUCPDValue: ?f32 = blk: {
                break :blk 4;
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
            const SPI5CLockSelectionValue: ?SPI5CLockSelectionList = blk: {
                const conf_item = config.SPI5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI5CLKSOURCE_PCLK3 => {},
                        .RCC_SPI5CLKSOURCE_PLL2Q => SPI5_PLL2 = true,
                        .RCC_SPI5CLKSOURCE_PLL3Q => SPI5_PLL3 = true,
                        .RCC_SPI5CLKSOURCE_HSI => SPI5_HSI = true,
                        .RCC_SPI5CLKSOURCE_CSI => SPI5_CSI = true,
                        .RCC_SPI5CLKSOURCE_HSE => SPI5_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI5CLKSOURCE_PCLK3;
            };
            const SPI6CLockSelectionValue: ?SPI6CLockSelectionList = blk: {
                const conf_item = config.SPI6CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI6CLKSOURCE_PCLK2 => {},
                        .RCC_SPI6CLKSOURCE_PLL2Q => SPI6_PLL2 = true,
                        .RCC_SPI6CLKSOURCE_PLL3Q => SPI6_PLL3 = true,
                        .RCC_SPI6CLKSOURCE_HSI => SPI6_HSI = true,
                        .RCC_SPI6CLKSOURCE_CSI => SPI6_CSI = true,
                        .RCC_SPI6CLKSOURCE_HSE => SPI6_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI6CLKSOURCE_PCLK2;
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
                    if (val > 255) {
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
                            255,
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
            const LSEUsedValue: ?f32 = blk: {
                if ((LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig))) {
                    break :blk 1;
                } else if (config.flags.RTCUsed_ForRCC and RTCSourceLSE or config.flags.USART1_Used and USART1_LSE or config.flags.USART2_Used and USART2_LSE or config.flags.USART3_Used and USART3_LSE or config.flags.UART4_Used and UART4_LSE or config.flags.UART5_Used and UART5_LSE or config.flags.USART6_Used and USART6_LSE or config.flags.UART7_Used and UART7_LSE) {
                    break :blk 1;
                } else if (config.flags.UART9_Used and UART9_LSE or config.flags.UART8_Used and UART8_LSE or config.flags.USART10_Used and USART10_LSE or config.flags.USART11_Used and USART11_LSE or config.flags.UART12_Used and UART12_LSE or config.flags.LPUART1_Used and LPUART1_LSE or LPTIM1SOURCELSE and config.flags.LPTIM1_Used or LPTIM2SOURCELSE and config.flags.LPTIM2_Used) {
                    break :blk 1;
                } else if (DAC1LPCLKSOURCE_LSE and (config.flags.DAC1_Used or config.flags.DAC2_Used) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (check_MCU("Semaphore_input_Channel1TIM16") and check_MCU("TIM16") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or LPTIM3SOURCELSE and config.flags.LPTIM3_Used or LPTIM4SOURCELSE and config.flags.LPTIM4_Used or LPTIM5SOURCELSE and config.flags.LPTIM5_Used or LPTIM6SOURCELSE and config.flags.LPTIM6_Used or RNGCLKSOURCE_LSE and config.flags.RNG_Used or LSCOSSourceLSE and config.flags.LSCOConfig or CLKSOURCE_LSE or CEC_LSE and config.flags.HDMI_CEC_Used) {
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
            const SDMMC1EnableValue: ?SDMMC1EnableList = blk: {
                if (config.flags.SDMMC1_Used) {
                    const item: SDMMC1EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC1EnableList = .false;
                break :blk item;
            };
            const SDMMC2EnableValue: ?SDMMC2EnableList = blk: {
                if (config.flags.SDMMC2_Used) {
                    const item: SDMMC2EnableList = .true;
                    break :blk item;
                }
                const item: SDMMC2EnableList = .false;
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
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass))) {
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
            const CECEnableValue: ?CECEnableList = blk: {
                if (config.flags.HDMI_CEC_Used) {
                    const item: CECEnableList = .true;
                    break :blk item;
                }
                const item: CECEnableList = .false;
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
            const USART6EnableValue: ?USART6EnableList = blk: {
                if (config.flags.USART6Used_ForRCC) {
                    const item: USART6EnableList = .true;
                    break :blk item;
                }
                const item: USART6EnableList = .false;
                break :blk item;
            };
            const UART7EnableValue: ?UART7EnableList = blk: {
                if (config.flags.UART7Used_ForRCC) {
                    const item: UART7EnableList = .true;
                    break :blk item;
                }
                const item: UART7EnableList = .false;
                break :blk item;
            };
            const UART9EnableValue: ?UART9EnableList = blk: {
                if (config.flags.UART9Used_ForRCC) {
                    const item: UART9EnableList = .true;
                    break :blk item;
                }
                const item: UART9EnableList = .false;
                break :blk item;
            };
            const UART8EnableValue: ?UART8EnableList = blk: {
                if (config.flags.UART8Used_ForRCC) {
                    const item: UART8EnableList = .true;
                    break :blk item;
                }
                const item: UART8EnableList = .false;
                break :blk item;
            };
            const USART10EnableValue: ?USART10EnableList = blk: {
                if (config.flags.USART10Used_ForRCC) {
                    const item: USART10EnableList = .true;
                    break :blk item;
                } else if (config.flags.USART10Used_ForRCC) {
                    const item: USART10EnableList = .true;
                    break :blk item;
                }
                const item: USART10EnableList = .false;
                break :blk item;
            };
            const USART11EnableValue: ?USART11EnableList = blk: {
                if (config.flags.USART11Used_ForRCC) {
                    const item: USART11EnableList = .true;
                    break :blk item;
                }
                const item: USART11EnableList = .false;
                break :blk item;
            };
            const UART12EnableValue: ?UART12EnableList = blk: {
                if (config.flags.UART12Used_ForRCC) {
                    const item: UART12EnableList = .true;
                    break :blk item;
                }
                const item: UART12EnableList = .false;
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
                if ((config.flags.USE_ADC1 and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (config.flags.USE_ADC2 and config.flags.ADC2UsedAsynchronousCLK_ForRCC)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const ETHEnableValue: ?ETHEnableList = blk: {
                if (config.flags.ETH_Used) {
                    const item: ETHEnableList = .true;
                    break :blk item;
                }
                const item: ETHEnableList = .false;
                break :blk item;
            };
            const FDCANEnableValue: ?FDCANEnableList = blk: {
                if (config.flags.FDCAN1Used_ForRCC or config.flags.FDCAN2_Used) {
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
            const I3C1EnableValue: ?I3C1EnableList = blk: {
                if (config.flags.I3C1Used_ForRCC) {
                    const item: I3C1EnableList = .true;
                    break :blk item;
                }
                const item: I3C1EnableList = .false;
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
            const LPTIM4EnableValue: ?LPTIM4EnableList = blk: {
                if (config.flags.LPTIM4Used_ForRCC) {
                    const item: LPTIM4EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM4EnableList = .false;
                break :blk item;
            };
            const LPTIM5EnableValue: ?LPTIM5EnableList = blk: {
                if (config.flags.LPTIM5Used_ForRCC) {
                    const item: LPTIM5EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM5EnableList = .false;
                break :blk item;
            };
            const LPTIM6EnableValue: ?LPTIM6EnableList = blk: {
                if (config.flags.LPTIM6Used_ForRCC) {
                    const item: LPTIM6EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM6EnableList = .false;
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
                if ((config.flags.SPI1_Used or config.flags.I2S1_Used) or (config.flags.SPI2_Used or config.flags.I2S2_Used) or (config.flags.SPI3_Used or config.flags.I2S3_Used) or config.flags.LPTIM1_Used or config.flags.LPTIM2_Used or config.flags.LPTIM3_Used or config.flags.LPTIM4_Used or config.flags.LPTIM5_Used or config.flags.LPTIM6_Used or config.flags.SAI1_Used or config.flags.SAI2_Used or config.flags.OCTOSPI1_Used) {
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
                if ((config.flags.UCPD_Used)) {
                    const item: UCPDEnableList = .true;
                    break :blk item;
                }
                const item: UCPDEnableList = .false;
                break :blk item;
            };
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.SPI1Used_ForRCC or config.flags.I2S1_Used) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3Used_ForRCC or config.flags.I2S3_Used) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
                break :blk item;
            };
            const SPI4EnableValue: ?SPI4EnableList = blk: {
                if (config.flags.SPI4Used_ForRCC) {
                    const item: SPI4EnableList = .true;
                    break :blk item;
                }
                const item: SPI4EnableList = .false;
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
            const SPI6EnableValue: ?SPI6EnableList = blk: {
                if (config.flags.SPI6Used_ForRCC) {
                    const item: SPI6EnableList = .true;
                    break :blk item;
                }
                const item: SPI6EnableList = .false;
                break :blk item;
            };
            const SPI2EnableValue: ?SPI2EnableList = blk: {
                if (config.flags.SPI2Used_ForRCC or config.flags.I2S2_Used) {
                    const item: SPI2EnableList = .true;
                    break :blk item;
                }
                const item: SPI2EnableList = .false;
                break :blk item;
            };
            const PLL1QUsedValue: ?f32 = blk: {
                if (config.flags.ETH_Used or USBSourcePLL1Q and config.flags.USB_Used or SDMMC1SourceIsPllQ and config.flags.SDMMC1_Used or SDMMC2SourceIsPllQ and config.flags.SDMMC2_Used or FDCAN_PLL1Q and (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used) or SAI1SourcePLL1Q and config.flags.SAI1_Used or SAI2SourcePLL1Q and config.flags.SAI2_Used or OCTOSPI_PLL1Q and (config.flags.OCTOSPI1_Used or config.flags.OCTOSPI2_Used) or RNGCLKSOURCE_PLL1Q and config.flags.RNG_Used or MCO1_PLL1QCLK and ((check_MCU("Semaphore_input_Channel1TIM17") and check_MCU("TIM17") and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or config.flags.MCOConfig) or SPI1_PLL1 and (config.flags.SPI1_Used or config.flags.I2S1_Used) or SPI3_PLL1 and (config.flags.SPI3_Used or config.flags.I2S3_Used) or SPI2_PLL1 and (config.flags.SPI2_Used or config.flags.I2S2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2PUsedValue: ?f32 = blk: {
                if (config.flags.LPTIM2_Used and LPTIM2_PLL2 or config.flags.LPTIM1_Used and LPTIM1_PLL2 or config.flags.SAI1_Used and SAI1SourcePLL2P or config.flags.SAI2_Used and SAI2SourcePLL2P or config.flags.LPTIM3_Used and LPTIM3_PLL2 or config.flags.LPTIM4_Used and LPTIM4_PLL2 or config.flags.LPTIM5_Used and LPTIM5_PLL2 or config.flags.LPTIM6_Used and LPTIM6_PLL2 or config.flags.MCO2Config and MCO2_PLL2PCLK or (config.flags.SPI1_Used or config.flags.I2S1_Used) and SPI1_PLL2 or (config.flags.SPI3_Used or config.flags.I2S3_Used) and SPI3_PLL2 or (config.flags.SPI2_Used or config.flags.I2S2_Used) and SPI2_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2QUsedValue: ?f32 = blk: {
                if (config.flags.USART1_Used and USART1_PLL2 or config.flags.USART2_Used and USART2_PLL2 or config.flags.USART3_Used and USART3_PLL2 or config.flags.UART4_Used and UART4_PLL2 or config.flags.UART5_Used and UART5_PLL2 or config.flags.USART6_Used and USART6_PLL2 or config.flags.USART7_Used and UART7_PLL2 or config.flags.USART9_Used and UART9_PLL2 or config.flags.UART8_Used and UART8_PLL2 or config.flags.USART10_Used and USART10_PLL2 or config.flags.USART11_Used and USART11_PLL2 or config.flags.UART12_Used and UART12_PLL2 or config.flags.LPUART1_Used and LPUART1_PLL2 or (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used) and FDCAN_PLL2Q or config.flags.SPI4_Used and SPI4_PLL2 or config.flags.SPI5_Used and SPI5_PLL2 or config.flags.SPI6_Used and SPI6_PLL2) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2RUsedValue: ?f32 = blk: {
                if (ADCSourcePLL2R and (config.flags.ADC1_Used and config.flags.ADC1UsedAsynchronousCLK_ForRCC or config.flags.ADC2_Used and config.flags.ADC2UsedAsynchronousCLK_ForRCC or config.flags.DAC1_Used or config.flags.DAC2_Used) or SDMMC1_PLL2 and config.flags.SDMMC1_Used or SDMMC2_PLL2 and config.flags.SDMMC2_Used or OCTOSPI_PLL2R and (config.flags.OCTOSPI1_Used or config.flags.OCTOSPI2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3PUsedValue: ?f32 = blk: {
                if (SAI1SourcePLL3P and config.flags.SAI1_Used or SAI2SourcePLL3P and config.flags.SAI2_Used or SPI1_PLL3 and (config.flags.SPI1_Used or config.flags.I2S1_Used) or SPI3_PLL3 and (config.flags.SPI3_Used or config.flags.I2S3_Used) or SPI2_PLL3 and (config.flags.SPI2_Used or config.flags.I2S2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3QUsedValue: ?f32 = blk: {
                if (USART1_PLL3 and config.flags.USART1_Used or USART2_PLL3 and config.flags.USART2_Used or USART3_PLL3 and config.flags.USART3_Used or UART4_PLL3 and config.flags.UART4_Used or UART5_PLL3 and config.flags.UART5_Used or USART6_PLL3 and config.flags.USART6_Used or UART7_PLL3 and config.flags.UART7_Used or UART9_PLL3 and config.flags.UART9_Used or UART8_PLL3 and config.flags.UART8_Used or USART10_PLL3 and config.flags.USART10__Used or USART11_PLL3 and config.flags.USART11_Used or UART12_PLL3 and config.flags.UART12_Used or LPUART1_PLL3 and config.flags.LPUART1_Used or USBSourcePLL3Q and config.flags.USB_Used or SPI4_PLL3 and config.flags.SPI4_Used or SPI5_PLL3 and config.flags.SPI5_Used or SPI6_PLL3 and config.flags.SPI6_Used) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if (MCO2_PLL1PCLK and config.flags.MCO2Config or SysSourcePLL) {
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
            const PLL2UsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3RUsedValue: ?f32 = blk: {
                if (LPTIM1_PLL3 and config.flags.LPTIM1_Used or LPTIM2_PLL3 and config.flags.LPTIM2_Used or I2C1_PLL3 and config.flags.I2C1_Used or I2C2_PLL3 and config.flags.I2C2_Used or I2C3_PLL3 and config.flags.I2C3_Used or I2C4_PLL3 and config.flags.I2C4_Used or I3C1_PLL3 and config.flags.I3C1_Used or LPTIM3_PLL3 and config.flags.LPTIM3_Used or LPTIM4_PLL3 and config.flags.LPTIM4_Used or LPTIM5_PLL3 and config.flags.LPTIM5_Used or LPTIM6_PLL3 and config.flags.LPTIM6_Used) {
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
                CRSCLKoutput.nodetype = .output;
                CRSCLKoutput.parents = &.{&HSI48RC};
            }
            if (check_ref(@TypeOf(EnableCRSValue), EnableCRSValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if (check_MCU("HDMI_CEC_Exist")) {
                if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                    const CSIdivTohdmi_clk_value = CSIdivTohdmiValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "CSIdivTohdmi",
                        "HDMI_CEC_Exist",
                        "No Extra Log",
                        "CSIdivTohdmi",
                    });
                    CSIdivTohdmi.nodetype = .div;
                    CSIdivTohdmi.value = CSIdivTohdmi_clk_value;
                    CSIdivTohdmi.parents = &.{&CSIRC};
                }
            }
            if (check_MCU("HDMI_CEC_Exist")) {
                if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                    const CECMult_clk_value = CECCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "CECMult",
                        "HDMI_CEC_Exist",
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
            }
            if (check_MCU("HDMI_CEC_Exist")) {
                if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                    CECoutput.nodetype = .output;
                    CECoutput.parents = &.{&CECMult};
                }
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
                USART6output.nodetype = .output;
                USART6output.parents = &.{&USART6Mult};
            }
            if (check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=")) {
                const UART7Mult_clk_value = UART7CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART7Mult",
                    "Else",
                    "No Extra Log",
                    "UART7CLockSelection",
                });
                const UART7Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
                };
                UART7Mult.nodetype = .multi;
                UART7Mult.parents = &.{UART7Multparents[UART7Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=")) {
                UART7output.nodetype = .output;
                UART7output.parents = &.{&UART7Mult};
            }
            if (check_MCU("UART9_Exist")) {
                if (check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=")) {
                    const UART9Mult_clk_value = UART9CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "UART9Mult",
                        "UART9_Exist",
                        "No Extra Log",
                        "UART9CLockSelection",
                    });
                    const UART9Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &PLL2Q,
                        &HSIDiv,
                        &LSEOSC,
                        &CSIRC,
                        &PLL3Q,
                    };
                    UART9Mult.nodetype = .multi;
                    UART9Mult.parents = &.{UART9Multparents[UART9Mult_clk_value.get()]};
                }
            }
            if (check_MCU("UART9_Exist")) {
                if (check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=")) {
                    UART9output.nodetype = .output;
                    UART9output.parents = &.{&UART9Mult};
                }
            }
            if (check_MCU("UART8_Exist")) {
                if (check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=")) {
                    const UART8Mult_clk_value = UART8CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "UART8Mult",
                        "UART8_Exist",
                        "No Extra Log",
                        "UART8CLockSelection",
                    });
                    const UART8Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &PLL2Q,
                        &HSIDiv,
                        &LSEOSC,
                        &CSIRC,
                        &PLL3Q,
                    };
                    UART8Mult.nodetype = .multi;
                    UART8Mult.parents = &.{UART8Multparents[UART8Mult_clk_value.get()]};
                }
            }
            if (check_MCU("UART8_Exist")) {
                if (check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=")) {
                    UART8output.nodetype = .output;
                    UART8output.parents = &.{&UART8Mult};
                }
            }
            if (check_MCU("USART10_Exist")) {
                if (check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=")) {
                    const USART10Mult_clk_value = USART10CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "USART10Mult",
                        "USART10_Exist",
                        "No Extra Log",
                        "USART10CLockSelection",
                    });
                    const USART10Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &PLL2Q,
                        &HSIDiv,
                        &LSEOSC,
                        &CSIRC,
                        &PLL3Q,
                    };
                    USART10Mult.nodetype = .multi;
                    USART10Mult.parents = &.{USART10Multparents[USART10Mult_clk_value.get()]};
                }
            }
            if (check_MCU("USART10_Exist")) {
                if (check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=")) {
                    USART10output.nodetype = .output;
                    USART10output.parents = &.{&USART10Mult};
                }
            }
            if (check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=")) {
                const USART11Mult_clk_value = USART11CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART11Mult",
                    "Else",
                    "No Extra Log",
                    "USART11CLockSelection",
                });
                const USART11Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &PLL2Q,
                    &HSIDiv,
                    &LSEOSC,
                    &CSIRC,
                    &PLL3Q,
                };
                USART11Mult.nodetype = .multi;
                USART11Mult.parents = &.{USART11Multparents[USART11Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=")) {
                USART11output.nodetype = .output;
                USART11output.parents = &.{&USART11Mult};
            }
            if (check_MCU("UART12_Exist")) {
                if (check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=")) {
                    const UART12Mult_clk_value = UART12CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "UART12Mult",
                        "UART12_Exist",
                        "No Extra Log",
                        "UART12CLockSelection",
                    });
                    const UART12Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &PLL2Q,
                        &HSIDiv,
                        &LSEOSC,
                        &CSIRC,
                        &PLL3Q,
                    };
                    UART12Mult.nodetype = .multi;
                    UART12Mult.parents = &.{UART12Multparents[UART12Mult_clk_value.get()]};
                }
            }
            if (check_MCU("UART12_Exist")) {
                if (check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=")) {
                    UART12output.nodetype = .output;
                    UART12output.parents = &.{&UART12Mult};
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
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_MCU("USB_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                    const CK48Mult_clk_value = USBCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "CK48Mult",
                        "USB_Exist",
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
            }
            if (check_MCU("ETH_Exist")) {
                if (check_ref(@TypeOf(ETHEnableValue), ETHEnableValue, .true, .@"=")) {
                    ETHoutput.nodetype = .output;
                    ETHoutput.parents = &.{&PLL1Q};
                }
            }
            if (check_MCU("USB_Exist")) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
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
                    SDMMC1Output.nodetype = .output;
                    SDMMC1Output.parents = &.{&SDMMC1Mult};
                }
            }
            if (check_MCU("SDMMC2_Exist")) {
                if (check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=")) {
                    const SDMMC2Mult_clk_value = SDMMC2ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SDMMC2Mult",
                        "SDMMC2_Exist",
                        "No Extra Log",
                        "SDMMC2ClockSelection",
                    });
                    const SDMMC2Multparents = [_]*const ClockNode{
                        &PLL1Q,
                        &PLL2R,
                    };
                    SDMMC2Mult.nodetype = .multi;
                    SDMMC2Mult.parents = &.{SDMMC2Multparents[SDMMC2Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SDMMC2_Exist")) {
                if (check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=")) {
                    SDMMC2Output.nodetype = .output;
                    SDMMC2Output.parents = &.{&SDMMC2Mult};
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
                I2C3output.nodetype = .output;
                I2C3output.parents = &.{&I2C3Mult};
            }
            if (check_MCU("SAI1_Exist")) {
                if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                    const SAI1Mult_clk_value = SAI1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SAI1Mult",
                        "SAI1_Exist",
                        "No Extra Log",
                        "SAI1CLockSelection",
                    });
                    const SAI1Multparents = [_]*const ClockNode{
                        &PLL2P,
                        &PLL3P,
                        &PLL1Q,
                        &AUDIOCLK,
                        &CKPERMult,
                    };
                    SAI1Mult.nodetype = .multi;
                    SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SAI1_Exist")) {
                if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                    SAI1output.nodetype = .output;
                    SAI1output.parents = &.{&SAI1Mult};
                }
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
                        &PLL1Q,
                        &AUDIOCLK,
                        &CKPERMult,
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
                    &APB3Output,
                    &PLL3R,
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
                I3C1output.nodetype = .output;
                I3C1output.parents = &.{&I3C1Mult};
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
                    &APB3Output,
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
                };
                LPTIM3Mult.nodetype = .multi;
                LPTIM3Mult.parents = &.{LPTIM3Multparents[LPTIM3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=")) {
                LPTIM3output.nodetype = .output;
                LPTIM3output.parents = &.{&LPTIM3Mult};
            }
            if (check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=")) {
                const LPTIM4Mult_clk_value = LPTIM4CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM4Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM4CLockSelection",
                });
                const LPTIM4Multparents = [_]*const ClockNode{
                    &APB3Output,
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
                };
                LPTIM4Mult.nodetype = .multi;
                LPTIM4Mult.parents = &.{LPTIM4Multparents[LPTIM4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=")) {
                LPTIM4output.nodetype = .output;
                LPTIM4output.parents = &.{&LPTIM4Mult};
            }
            if (check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=")) {
                const LPTIM5Mult_clk_value = LPTIM5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM5Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM5CLockSelection",
                });
                const LPTIM5Multparents = [_]*const ClockNode{
                    &APB3Output,
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
                };
                LPTIM5Mult.nodetype = .multi;
                LPTIM5Mult.parents = &.{LPTIM5Multparents[LPTIM5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=")) {
                LPTIM5output.nodetype = .output;
                LPTIM5output.parents = &.{&LPTIM5Mult};
            }
            if (check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=")) {
                const LPTIM6Mult_clk_value = LPTIM6CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM6Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM6CLockSelection",
                });
                const LPTIM6Multparents = [_]*const ClockNode{
                    &APB3Output,
                    &PLL2P,
                    &LSEOSC,
                    &LSIRC,
                    &CKPERMult,
                    &PLL3R,
                };
                LPTIM6Mult.nodetype = .multi;
                LPTIM6Mult.parents = &.{LPTIM6Multparents[LPTIM6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=")) {
                LPTIM6output.nodetype = .output;
                LPTIM6output.parents = &.{&LPTIM6Mult};
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
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
            }
            if (!(check_MCU("STM32H503EBYx") or check_MCU("STM32H503KBUx"))) {
                if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                    const LSCOMult_clk_value = LSCOSource1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSCOMult",
                        "!(STM32H503EBYx | STM32H503KBUx)",
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
            }
            if (!(check_MCU("STM32H503EBYx") or check_MCU("STM32H503KBUx"))) {
                if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
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
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};
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
                CortexSysOutput.nodetype = .output;
                CortexSysOutput.parents = &.{&CortexCLockSelection};
            }
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
                    SPI4output.nodetype = .output;
                    SPI4output.parents = &.{&SPI4Mult};
                }
            }
            if (check_MCU("SPI5_Exist")) {
                if (check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=")) {
                    const SPI5Mult_clk_value = SPI5CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SPI5Mult",
                        "SPI5_Exist",
                        "No Extra Log",
                        "SPI5CLockSelection",
                    });
                    const SPI5Multparents = [_]*const ClockNode{
                        &APB3Output,
                        &PLL2Q,
                        &HSIDiv,
                        &CSIRC,
                        &HSEOSC,
                        &PLL3Q,
                    };
                    SPI5Mult.nodetype = .multi;
                    SPI5Mult.parents = &.{SPI5Multparents[SPI5Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SPI5_Exist")) {
                if (check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=")) {
                    SPI5output.nodetype = .output;
                    SPI5output.parents = &.{&SPI5Mult};
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
                    &APB2Prescaler,
                    &PLL2Q,
                    &HSIDiv,
                    &CSIRC,
                    &HSEOSC,
                    &PLL3Q,
                };
                SPI6Mult.nodetype = .multi;
                SPI6Mult.parents = &.{SPI6Multparents[SPI6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=")) {
                SPI6output.nodetype = .output;
                SPI6output.parents = &.{&SPI6Mult};
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
            if (check_ref(@TypeOf(ETHEnableValue), ETHEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(ETHEnableValue), ETHEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"="))
            {
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
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=") or
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
            PLL2FRACN.nodetype = .source;
            PLL2FRACN.value = PLL2FRACN_clk_value;
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=") or
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
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
            {
                PLL2Poutput.nodetype = .output;
                PLL2Poutput.parents = &.{&PLL2P};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"="))
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
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FDCANEnableValue), FDCANEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"="))
            {
                PLL2Qoutput.nodetype = .output;
                PLL2Qoutput.parents = &.{&PLL2Q};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(DACEnableValue), DACEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
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
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OCTOSPIMEnableValue), OCTOSPIMEnableValue, .true, .@"="))
            {
                PLL2Routput.nodetype = .output;
                PLL2Routput.parents = &.{&PLL2R};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
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
            PLL3FRACN.nodetype = .source;
            PLL3FRACN.value = PLL3FRACN_clk_value;
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI2EnableValue), SAI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI2EnableValue), SPI2EnableValue, .true, .@"="))
            {
                PLL3Poutput.nodetype = .output;
                PLL3Poutput.parents = &.{&PLL3P};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART6EnableValue), USART6EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"="))
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
                check_ref(@TypeOf(UART7EnableValue), UART7EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART9EnableValue), UART9EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART8EnableValue), UART8EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART10EnableValue), USART10EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USART11EnableValue), USART11EnableValue, .true, .@"=") or
                check_ref(@TypeOf(UART12EnableValue), UART12EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI4EnableValue), SPI4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI5EnableValue), SPI5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SPI6EnableValue), SPI6EnableValue, .true, .@"="))
            {
                PLL3Qoutput.nodetype = .output;
                PLL3Qoutput.parents = &.{&PLL3Q};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"="))
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
                check_ref(@TypeOf(I2C4EnableValue), I2C4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(I3C1EnableValue), I3C1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM3EnableValue), LPTIM3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM4EnableValue), LPTIM4EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM5EnableValue), LPTIM5EnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPTIM6EnableValue), LPTIM6EnableValue, .true, .@"="))
            {
                PLL3Routput.nodetype = .output;
                PLL3Routput.parents = &.{&PLL3R};
            }
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};
            VCOInput2.nodetype = .output;
            VCOInput2.parents = &.{&PLL2M};
            VCOInput3.nodetype = .output;
            VCOInput3.parents = &.{&PLL3M};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};
            PLLPCLK.nodetype = .output;
            PLLPCLK.parents = &.{&PLL1P};
            VCOPLL2Output.nodetype = .output;
            VCOPLL2Output.parents = &.{&PLL2N};
            VCOPLL3Output.nodetype = .output;
            VCOPLL3Output.parents = &.{&PLL3N};

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                RTCOutput.limit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF CECFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    CECoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    CECoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    CECoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    CECoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                CECoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART3output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART4Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART4output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART5Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART5output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART5output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART6Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART6output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART6output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART6output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART6output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART6output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART7Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART7output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART7output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART7output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART7output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART7output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART9Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART9output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART9output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART9output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART9output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART9output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART8Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART8output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART8output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART8output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART8output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART8output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART10Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART10output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART10output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART10output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART10output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART10output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART11Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART11output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART11output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    USART11output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    USART11output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                USART11output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF UART12Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    UART12output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    UART12output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    UART12output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    UART12output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                UART12output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPUART1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPUART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF DACFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    DACoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    DACoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    DACoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    DACoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                DACoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                if (scale1 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and config.flags.DAC1_Used and !config.flags.ADC1_Used and !config.flags.ADC2_Used) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                } else if (scale1) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                ADCoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF ETHFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    ETHoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ETHoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    ETHoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    ETHoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                ETHoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USBFreq_Value VALUE
            _ = blk: {
                USBoutput.limit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SDMMC1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SDMMC1Output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMC1Output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SDMMC1Output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    SDMMC1Output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                SDMMC1Output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SDMMC2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SDMMC2Output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SDMMC2Output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SDMMC2Output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    SDMMC2Output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                SDMMC2Output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF FDCANFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    FDCANOutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                FDCANOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                I2C1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C2output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                I2C2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                I2C3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SAI1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                SAI1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SAI2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    SAI2output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                SAI2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C4Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I2C4output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                I2C4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I3C1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I3C1output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I3C1output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    I3C1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    I3C1output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                I3C1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF OCTOSPIMFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    OCTOSPIMoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                OCTOSPIMoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM3output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM4Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM4output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM4output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM4output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM4output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM5Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM5output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM5output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM5output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM5output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM5output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM6Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM6output.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM6output.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3) {
                    LPTIM6output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0) {
                    LPTIM6output.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                LPTIM6output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                if (scale1) {
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
                } else if (scale0) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                RNGoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF CKPERFreq_Value VALUE
            _ = blk: {
                CKPERoutput.limit = .{
                    .min = null,
                    .max = 6.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PWRFreq_Value VALUE
            _ = blk: {
                PWRCLKoutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHBFreq_Value VALUE
            _ = blk: {
                HCLKOutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CortexFreq_Value VALUE
            _ = blk: {
                CortexSysOutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF FCLKCortexFreq_Value VALUE
            _ = blk: {
                FCLKCortexOutput.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1TimFreq_Value VALUE
            _ = blk: {
                TimPrescOut1.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB3Freq_Value VALUE
            _ = blk: {
                APB3Output.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2TimFreq_Value VALUE
            _ = blk: {
                TimPrescOut2.limit = .{
                    .min = null,
                    .max = 2.5e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI4Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI4output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI4output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI4output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI4output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI4output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI5Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI5output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI5output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI5output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI5output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI5output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI6Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI6output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI6output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                } else if (scale3) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 5e7,
                    };

                    break :blk null;
                } else if (scale0) {
                    SPI2output.limit = .{
                        .min = null,
                        .max = 1.25e8,
                    };

                    break :blk null;
                }
                SPI2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF PLLQoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=")) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2PUsedValue), PLL2PUsedValue, 1, .@"=")) {
                    PLL2Poutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                PLL2Poutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLL2QoutputFreq_Value VALUE
            _ = blk: {
                if (scale1 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2QUsedValue), PLL2QUsedValue, 1, .@"=")) {
                    PLL2Qoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL2RUsedValue), PLL2RUsedValue, 1, .@"=")) {
                    PLL2Routput.limit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3PUsedValue), PLL3PUsedValue, 1, .@"=")) {
                    PLL3Poutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .max = 2e8,
                    };

                    break :blk null;
                } else if (scale2 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 1.5e8,
                    };

                    break :blk null;
                } else if (scale3 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale0 and check_ref(@TypeOf(PLL3QUsedValue), PLL3QUsedValue, 1, .@"=")) {
                    PLL3Qoutput.limit = .{
                        .min = null,
                        .max = 2.5e8,
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
                        .min = 1e6,
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
                        .min = 1e6,
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
                        .min = 1e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput3.value = 4000000;
                break :blk null;
            };
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<")) or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL1_VCIRANGE_3;
                break :blk item;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL1_VCI_RangeValue), PLL1_VCI_RangeValue, .RCC_PLL1_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                VCOOutput.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF PLLPoutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=")) {
                    PLLPCLK.limit = .{
                        .min = null,
                        .max = 2.5e8,
                    };

                    break :blk null;
                }
                PLLPCLK.value = 4571429;
                break :blk null;
            };
            const PLL2_VCI_RangeValue: ?PLL2_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 1000000, .@"="))) and (check_ref(?f32, VCOInput2.get_as_ref(), 2000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput2.get_as_ref(), 2000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 2000000, .@"="))) and (check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput2.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput2.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput2.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL2_VCI_RangeList = .RCC_PLL2_VCIRANGE_3;
                break :blk item;
            };

            //POST CLOCK REF VCOPLL2OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL2_VCI_RangeValue), PLL2_VCI_RangeValue, .RCC_PLL2_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2Output.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    VCOPLL2Output.limit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                VCOPLL2Output.value = 32000000;
                break :blk null;
            };
            const PLL3_VCI_RangeValue: ?PLL3_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"="))) and (check_ref(?f32, VCOInput3.get_as_ref(), 16000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_1;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_2;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput3.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput3.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput3.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_3;
                    break :blk item;
                }
                const item: PLL3_VCI_RangeList = .RCC_PLL3_VCIRANGE_3;
                break :blk item;
            };

            //POST CLOCK REF VCOPLL3OutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLL3_VCI_RangeValue), PLL3_VCI_RangeValue, .RCC_PLL3_VCIRANGE_0, .@"=")) and check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3Output.limit = .{
                        .min = 1.5e8,
                        .max = 4.2e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    VCOPLL3Output.limit = .{
                        .min = 1.28e8,
                        .max = 5.6e8,
                    };

                    break :blk null;
                }
                VCOPLL3Output.value = 32000000;
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale3 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 20000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 20000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if ((scale3 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 40000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 40000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if ((scale3 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 60000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 60000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if ((scale3 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 80000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 80000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if ((scale3 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 100000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 100000000, .@"="))))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale2 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 30000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 30000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale2 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 60000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 60000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale2 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 90000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 90000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale2 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 120000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 120000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale2 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 150000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 150000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale1 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 34000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 34000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale1 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 68000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 68000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale1 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 102000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 102000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale1 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 136000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 136000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale1 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 170000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 170000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale1 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 200000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 200000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_5;
                    break :blk item;
                } else if (scale0 and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 42000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 42000000, .@"=")))) {
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (scale0 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 84000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 84000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                } else if (scale0 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 126000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 126000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_2;
                    break :blk item;
                } else if (scale0 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 168000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 168000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_3;
                    break :blk item;
                } else if (scale0 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 210000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 210000000, .@"="))) {
                    const item: FLatencyList = .FLASH_LATENCY_4;
                    break :blk item;
                } else if (scale0 and (check_ref(?f32, SysCLKOutput.get_as_ref(), 250000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 250000000, .@"="))) {
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
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 100000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 100000000, .@"=")))) {
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
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 150000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 150000000, .@"="))) and (check_ref(?f32, SysCLKOutput.get_as_ref(), 100000000, .@">"))) {
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
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 200000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 200000000, .@"="))) and (check_ref(?f32, SysCLKOutput.get_as_ref(), 150000000, .@">"))) {
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
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 250000000, .@"<")) or (check_ref(?f32, SysCLKOutput.get_as_ref(), 250000000, .@"="))) and (check_ref(?f32, SysCLKOutput.get_as_ref(), 200000000, .@">"))) {
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
                } else if ((check_ref(?f32, SysCLKOutput.get_as_ref(), 250000000, .@">"))) {
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
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
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
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
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
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.CSIRC = try CSIRC.get_output();
            out.AUDIOCLK = try AUDIOCLK.get_output();
            out.CECoutput = try CECoutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.CSIdivTohdmi = try CSIdivTohdmi.get_output();
            out.USART6output = try USART6output.get_output();
            out.USART6Mult = try USART6Mult.get_output();
            out.UART7output = try UART7output.get_output();
            out.UART7Mult = try UART7Mult.get_output();
            out.UART9output = try UART9output.get_output();
            out.UART9Mult = try UART9Mult.get_output();
            out.UART8output = try UART8output.get_output();
            out.UART8Mult = try UART8Mult.get_output();
            out.USART10output = try USART10output.get_output();
            out.USART10Mult = try USART10Mult.get_output();
            out.USART11output = try USART11output.get_output();
            out.USART11Mult = try USART11Mult.get_output();
            out.UART12output = try UART12output.get_output();
            out.UART12Mult = try UART12Mult.get_output();
            out.DACoutput = try DACoutput.get_output();
            out.DACMult = try DACMult.get_output();
            out.ETHoutput = try ETHoutput.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.SDMMC2Output = try SDMMC2Output.get_output();
            out.SDMMC2Mult = try SDMMC2Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.I3C1output = try I3C1output.get_output();
            out.I3C1Mult = try I3C1Mult.get_output();
            out.LPTIM4output = try LPTIM4output.get_output();
            out.LPTIM4Mult = try LPTIM4Mult.get_output();
            out.LPTIM5output = try LPTIM5output.get_output();
            out.LPTIM5Mult = try LPTIM5Mult.get_output();
            out.LPTIM6output = try LPTIM6output.get_output();
            out.LPTIM6Mult = try LPTIM6Mult.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.APB3Output = try APB3Output.get_output();
            out.APB3Prescaler = try APB3Prescaler.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.SPI4output = try SPI4output.get_output();
            out.SPI4Mult = try SPI4Mult.get_output();
            out.SPI5output = try SPI5output.get_output();
            out.SPI5Mult = try SPI5Mult.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.SPI2output = try SPI2output.get_output();
            out.SPI2Mult = try SPI2Mult.get_output();
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
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSIDiv = HSIDivValue;
            ref_out.HSI48_VALUE = HSI48_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.CSI_VALUE = CSI_VALUEValue;
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
            ref_out.UART7CLockSelection = UART7CLockSelectionValue;
            ref_out.UART9CLockSelection = UART9CLockSelectionValue;
            ref_out.UART8CLockSelection = UART8CLockSelectionValue;
            ref_out.USART10CLockSelection = USART10CLockSelectionValue;
            ref_out.USART11CLockSelection = USART11CLockSelectionValue;
            ref_out.UART12CLockSelection = UART12CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.DACLowPowerCLockSelection = DACLowPowerCLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.SDMMC1ClockSelection = SDMMC1ClockSelectionValue;
            ref_out.SDMMC2ClockSelection = SDMMC2ClockSelectionValue;
            ref_out.FDCANClockSelection = FDCANClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.SAI2CLockSelection = SAI2CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.I3C1CLockSelection = I3C1CLockSelectionValue;
            ref_out.OCTOSPIMCLockSelection = OCTOSPIMCLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.LPTIM4CLockSelection = LPTIM4CLockSelectionValue;
            ref_out.LPTIM5CLockSelection = LPTIM5CLockSelectionValue;
            ref_out.LPTIM6CLockSelection = LPTIM6CLockSelectionValue;
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
            ref_out.SPI5CLockSelection = SPI5CLockSelectionValue;
            ref_out.SPI6CLockSelection = SPI6CLockSelectionValue;
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
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEDIGByPass = config.flags.HSEDIGByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEDIGByPass = config.flags.LSEDIGByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCOConfig = config.flags.MCOConfig;
            ref_out.flags.MCO2Config = config.flags.MCO2Config;
            ref_out.flags.LSCOConfig = config.flags.LSCOConfig;
            ref_out.flags.SAI1EXTCLK = config.flags.SAI1EXTCLK;
            ref_out.flags.CRSActivatedSourceGPIO = config.flags.CRSActivatedSourceGPIO;
            ref_out.flags.CRSActivatedSourceLSE = config.flags.CRSActivatedSourceLSE;
            ref_out.flags.CRSActivatedSourceUSB = config.flags.CRSActivatedSourceUSB;
            ref_out.flags.RNGUsed_ForRCC = config.flags.RNGUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.USART1Used_ForRCC = config.flags.USART1Used_ForRCC;
            ref_out.flags.USART2Used_ForRCC = config.flags.USART2Used_ForRCC;
            ref_out.flags.USART3Used_ForRCC = config.flags.USART3Used_ForRCC;
            ref_out.flags.UART4Used_ForRCC = config.flags.UART4Used_ForRCC;
            ref_out.flags.UART5Used_ForRCC = config.flags.UART5Used_ForRCC;
            ref_out.flags.USART6Used_ForRCC = config.flags.USART6Used_ForRCC;
            ref_out.flags.UART7Used_ForRCC = config.flags.UART7Used_ForRCC;
            ref_out.flags.UART9Used_ForRCC = config.flags.UART9Used_ForRCC;
            ref_out.flags.UART8Used_ForRCC = config.flags.UART8Used_ForRCC;
            ref_out.flags.USART10Used_ForRCC = config.flags.USART10Used_ForRCC;
            ref_out.flags.USART11Used_ForRCC = config.flags.USART11Used_ForRCC;
            ref_out.flags.UART12Used_ForRCC = config.flags.UART12Used_ForRCC;
            ref_out.flags.LPUARTUsed_ForRCC = config.flags.LPUARTUsed_ForRCC;
            ref_out.flags.LPTIM1Used_ForRCC = config.flags.LPTIM1Used_ForRCC;
            ref_out.flags.LPTIM2Used_ForRCC = config.flags.LPTIM2Used_ForRCC;
            ref_out.flags.USE_ADC1 = config.flags.USE_ADC1;
            ref_out.flags.ADC1UsedAsynchronousCLK_ForRCC = config.flags.ADC1UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USE_ADC2 = config.flags.USE_ADC2;
            ref_out.flags.ADC2UsedAsynchronousCLK_ForRCC = config.flags.ADC2UsedAsynchronousCLK_ForRCC;
            ref_out.flags.FDCAN1Used_ForRCC = config.flags.FDCAN1Used_ForRCC;
            ref_out.flags.I2C1Used_ForRCC = config.flags.I2C1Used_ForRCC;
            ref_out.flags.I2C2Used_ForRCC = config.flags.I2C2Used_ForRCC;
            ref_out.flags.I2C3Used_ForRCC = config.flags.I2C3Used_ForRCC;
            ref_out.flags.SAI1_SAIBUsed_ForRCC = config.flags.SAI1_SAIBUsed_ForRCC;
            ref_out.flags.SAI1_SAIAUsed_ForRCC = config.flags.SAI1_SAIAUsed_ForRCC;
            ref_out.flags.SAI2_SAIBUsed_ForRCC = config.flags.SAI2_SAIBUsed_ForRCC;
            ref_out.flags.SAI2_SAIAUsed_ForRCC = config.flags.SAI2_SAIAUsed_ForRCC;
            ref_out.flags.I2C4Used_ForRCC = config.flags.I2C4Used_ForRCC;
            ref_out.flags.I3C1Used_ForRCC = config.flags.I3C1Used_ForRCC;
            ref_out.flags.OCTOSPI1Used_ForRCC = config.flags.OCTOSPI1Used_ForRCC;
            ref_out.flags.OCTOSPI2Used_ForRCC = config.flags.OCTOSPI2Used_ForRCC;
            ref_out.flags.LPTIM3Used_ForRCC = config.flags.LPTIM3Used_ForRCC;
            ref_out.flags.LPTIM4Used_ForRCC = config.flags.LPTIM4Used_ForRCC;
            ref_out.flags.LPTIM5Used_ForRCC = config.flags.LPTIM5Used_ForRCC;
            ref_out.flags.LPTIM6Used_ForRCC = config.flags.LPTIM6Used_ForRCC;
            ref_out.flags.SPI1Used_ForRCC = config.flags.SPI1Used_ForRCC;
            ref_out.flags.SPI3Used_ForRCC = config.flags.SPI3Used_ForRCC;
            ref_out.flags.SPI4Used_ForRCC = config.flags.SPI4Used_ForRCC;
            ref_out.flags.SPI5Used_ForRCC = config.flags.SPI5Used_ForRCC;
            ref_out.flags.SPI6Used_ForRCC = config.flags.SPI6Used_ForRCC;
            ref_out.flags.SPI2Used_ForRCC = config.flags.SPI2Used_ForRCC;
            ref_out.flags.DAC1_Used = config.flags.DAC1_Used;
            ref_out.flags.ADC1_Used = config.flags.ADC1_Used;
            ref_out.flags.ADC2_Used = config.flags.ADC2_Used;
            ref_out.flags.LCDUsed_ForRCC = config.flags.LCDUsed_ForRCC;
            ref_out.flags.UCPD_Used = config.flags.UCPD_Used;
            ref_out.flags.OCTOSPI1_Used = config.flags.OCTOSPI1_Used;
            ref_out.flags.SAI2_Used = config.flags.SAI2_Used;
            ref_out.flags.SAI1_Used = config.flags.SAI1_Used;
            ref_out.flags.LPTIM6_Used = config.flags.LPTIM6_Used;
            ref_out.flags.USB_Used = config.flags.USB_Used;
            ref_out.flags.SDMMC1_Used = config.flags.SDMMC1_Used;
            ref_out.flags.SDMMC2_Used = config.flags.SDMMC2_Used;
            ref_out.flags.HDMI_CEC_Used = config.flags.HDMI_CEC_Used;
            ref_out.flags.ETH_Used = config.flags.ETH_Used;
            ref_out.flags.FDCAN2_Used = config.flags.FDCAN2_Used;
            ref_out.flags.SPI1_Used = config.flags.SPI1_Used;
            ref_out.flags.I2S1_Used = config.flags.I2S1_Used;
            ref_out.flags.SPI2_Used = config.flags.SPI2_Used;
            ref_out.flags.I2S2_Used = config.flags.I2S2_Used;
            ref_out.flags.SPI3_Used = config.flags.SPI3_Used;
            ref_out.flags.I2S3_Used = config.flags.I2S3_Used;
            ref_out.flags.LPTIM1_Used = config.flags.LPTIM1_Used;
            ref_out.flags.LPTIM2_Used = config.flags.LPTIM2_Used;
            ref_out.flags.LPTIM3_Used = config.flags.LPTIM3_Used;
            ref_out.flags.LPTIM4_Used = config.flags.LPTIM4_Used;
            ref_out.flags.LPTIM5_Used = config.flags.LPTIM5_Used;
            ref_out.flags.FDCAN1_Used = config.flags.FDCAN1_Used;
            ref_out.flags.OCTOSPI2_Used = config.flags.OCTOSPI2_Used;
            ref_out.flags.RNG_Used = config.flags.RNG_Used;
            ref_out.flags.USART1_Used = config.flags.USART1_Used;
            ref_out.flags.USART2_Used = config.flags.USART2_Used;
            ref_out.flags.USART3_Used = config.flags.USART3_Used;
            ref_out.flags.UART4_Used = config.flags.UART4_Used;
            ref_out.flags.UART5_Used = config.flags.UART5_Used;
            ref_out.flags.USART6_Used = config.flags.USART6_Used;
            ref_out.flags.USART7_Used = config.flags.USART7_Used;
            ref_out.flags.USART9_Used = config.flags.USART9_Used;
            ref_out.flags.UART8_Used = config.flags.UART8_Used;
            ref_out.flags.USART10_Used = config.flags.USART10_Used;
            ref_out.flags.USART11_Used = config.flags.USART11_Used;
            ref_out.flags.UART12_Used = config.flags.UART12_Used;
            ref_out.flags.LPUART1_Used = config.flags.LPUART1_Used;
            ref_out.flags.SPI4_Used = config.flags.SPI4_Used;
            ref_out.flags.SPI5_Used = config.flags.SPI5_Used;
            ref_out.flags.SPI6_Used = config.flags.SPI6_Used;
            ref_out.flags.DAC2_Used = config.flags.DAC2_Used;
            ref_out.flags.UART7_Used = config.flags.UART7_Used;
            ref_out.flags.UART9_Used = config.flags.UART9_Used;
            ref_out.flags.USART10__Used = config.flags.USART10__Used;
            ref_out.flags.I3C1_Used = config.flags.I3C1_Used;
            ref_out.flags.I2C4_Used = config.flags.I2C4_Used;
            ref_out.flags.I2C3_Used = config.flags.I2C3_Used;
            ref_out.flags.I2C2_Used = config.flags.I2C2_Used;
            ref_out.flags.I2C1_Used = config.flags.I2C1_Used;
            ref_out.flags.EnableCRS = check_ref(?EnableCRSList, EnableCRSValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.RNGEnable = check_ref(?RNGEnableList, RNGEnableValue, .true, .@"=");
            ref_out.flags.MCOEnable = check_ref(?MCOEnableList, MCOEnableValue, .true, .@"=");
            ref_out.flags.SDMMC1Enable = check_ref(?SDMMC1EnableList, SDMMC1EnableValue, .true, .@"=");
            ref_out.flags.SDMMC2Enable = check_ref(?SDMMC2EnableList, SDMMC2EnableValue, .true, .@"=");
            ref_out.flags.LSIEnable = check_ref(?LSIEnableList, LSIEnableValue, .true, .@"=");
            ref_out.flags.EnableExtClockForSAI1 = check_ref(?EnableExtClockForSAI1List, EnableExtClockForSAI1Value, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.CECEnable = check_ref(?CECEnableList, CECEnableValue, .true, .@"=");
            ref_out.flags.USART1Enable = check_ref(?USART1EnableList, USART1EnableValue, .true, .@"=");
            ref_out.flags.USART2Enable = check_ref(?USART2EnableList, USART2EnableValue, .true, .@"=");
            ref_out.flags.USART3Enable = check_ref(?USART3EnableList, USART3EnableValue, .true, .@"=");
            ref_out.flags.UART4Enable = check_ref(?UART4EnableList, UART4EnableValue, .true, .@"=");
            ref_out.flags.UART5Enable = check_ref(?UART5EnableList, UART5EnableValue, .true, .@"=");
            ref_out.flags.USART6Enable = check_ref(?USART6EnableList, USART6EnableValue, .true, .@"=");
            ref_out.flags.UART7Enable = check_ref(?UART7EnableList, UART7EnableValue, .true, .@"=");
            ref_out.flags.UART9Enable = check_ref(?UART9EnableList, UART9EnableValue, .true, .@"=");
            ref_out.flags.UART8Enable = check_ref(?UART8EnableList, UART8EnableValue, .true, .@"=");
            ref_out.flags.USART10Enable = check_ref(?USART10EnableList, USART10EnableValue, .true, .@"=");
            ref_out.flags.USART11Enable = check_ref(?USART11EnableList, USART11EnableValue, .true, .@"=");
            ref_out.flags.UART12Enable = check_ref(?UART12EnableList, UART12EnableValue, .true, .@"=");
            ref_out.flags.LPUART1Enable = check_ref(?LPUART1EnableList, LPUART1EnableValue, .true, .@"=");
            ref_out.flags.LPTIM1Enable = check_ref(?LPTIM1EnableList, LPTIM1EnableValue, .true, .@"=");
            ref_out.flags.LPTIM2Enable = check_ref(?LPTIM2EnableList, LPTIM2EnableValue, .true, .@"=");
            ref_out.flags.DACEnable = check_ref(?DACEnableList, DACEnableValue, .true, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.ETHEnable = check_ref(?ETHEnableList, ETHEnableValue, .true, .@"=");
            ref_out.flags.FDCANEnable = check_ref(?FDCANEnableList, FDCANEnableValue, .true, .@"=");
            ref_out.flags.I2C1Enable = check_ref(?I2C1EnableList, I2C1EnableValue, .true, .@"=");
            ref_out.flags.I2C2Enable = check_ref(?I2C2EnableList, I2C2EnableValue, .true, .@"=");
            ref_out.flags.I2C3Enable = check_ref(?I2C3EnableList, I2C3EnableValue, .true, .@"=");
            ref_out.flags.SAI1Enable = check_ref(?SAI1EnableList, SAI1EnableValue, .true, .@"=");
            ref_out.flags.SAI2Enable = check_ref(?SAI2EnableList, SAI2EnableValue, .true, .@"=");
            ref_out.flags.I2C4Enable = check_ref(?I2C4EnableList, I2C4EnableValue, .true, .@"=");
            ref_out.flags.I3C1Enable = check_ref(?I3C1EnableList, I3C1EnableValue, .true, .@"=");
            ref_out.flags.OCTOSPIMEnable = check_ref(?OCTOSPIMEnableList, OCTOSPIMEnableValue, .true, .@"=");
            ref_out.flags.LPTIM3Enable = check_ref(?LPTIM3EnableList, LPTIM3EnableValue, .true, .@"=");
            ref_out.flags.LPTIM4Enable = check_ref(?LPTIM4EnableList, LPTIM4EnableValue, .true, .@"=");
            ref_out.flags.LPTIM5Enable = check_ref(?LPTIM5EnableList, LPTIM5EnableValue, .true, .@"=");
            ref_out.flags.LPTIM6Enable = check_ref(?LPTIM6EnableList, LPTIM6EnableValue, .true, .@"=");
            ref_out.flags.MCO2Enable = check_ref(?MCO2EnableList, MCO2EnableValue, .true, .@"=");
            ref_out.flags.LSCOEnable = check_ref(?LSCOEnableList, LSCOEnableValue, .true, .@"=");
            ref_out.flags.CKPEREnable = check_ref(?CKPEREnableList, CKPEREnableValue, .true, .@"=");
            ref_out.flags.SystickEnable = check_ref(?SystickEnableList, SystickEnableValue, .true, .@"=");
            ref_out.flags.UCPDEnable = check_ref(?UCPDEnableList, UCPDEnableValue, .true, .@"=");
            ref_out.flags.SPI1Enable = check_ref(?SPI1EnableList, SPI1EnableValue, .true, .@"=");
            ref_out.flags.SPI3Enable = check_ref(?SPI3EnableList, SPI3EnableValue, .true, .@"=");
            ref_out.flags.SPI4Enable = check_ref(?SPI4EnableList, SPI4EnableValue, .true, .@"=");
            ref_out.flags.SPI5Enable = check_ref(?SPI5EnableList, SPI5EnableValue, .true, .@"=");
            ref_out.flags.SPI6Enable = check_ref(?SPI6EnableList, SPI6EnableValue, .true, .@"=");
            ref_out.flags.SPI2Enable = check_ref(?SPI2EnableList, SPI2EnableValue, .true, .@"=");
            ref_out.flags.PLL1QUsed = check_ref(?f32, PLL1QUsedValue, 1, .@"=");
            ref_out.flags.PLL2PUsed = check_ref(?f32, PLL2PUsedValue, 1, .@"=");
            ref_out.flags.PLL2QUsed = check_ref(?f32, PLL2QUsedValue, 1, .@"=");
            ref_out.flags.PLL2RUsed = check_ref(?f32, PLL2RUsedValue, 1, .@"=");
            ref_out.flags.PLL3PUsed = check_ref(?f32, PLL3PUsedValue, 1, .@"=");
            ref_out.flags.PLL3QUsed = check_ref(?f32, PLL3QUsedValue, 1, .@"=");
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.PLL2Used = check_ref(?f32, PLL2UsedValue, 1, .@"=");
            ref_out.flags.PLL3Used = check_ref(?f32, PLL3UsedValue, 1, .@"=");
            ref_out.flags.PLL1PUsed = check_ref(?f32, PLL1PUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.EnableCSSLSE = check_ref(?EnableCSSLSEList, EnableCSSLSEValue, .true, .@"=");
            ref_out.flags.EnbaleCSS = check_ref(?EnbaleCSSList, EnbaleCSSValue, .true, .@"=");
            ref_out.flags.PLL3RUsed = check_ref(?f32, PLL3RUsedValue, 1, .@"=");
            ref_out.flags.PLL1RUsed = check_ref(?f32, PLL1RUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
