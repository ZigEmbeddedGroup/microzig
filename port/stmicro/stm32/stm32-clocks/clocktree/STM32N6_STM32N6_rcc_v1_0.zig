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

pub const IC1CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC2CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC3CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC4CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC5CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC6CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC7CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC8CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC9CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC10CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC11CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC12CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC13CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC14CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC15CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC16CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC17CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC18CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC19CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const IC20CLKSourceList = enum {
    RCC_ICCLKSOURCE_PLL1,
    RCC_ICCLKSOURCE_PLL2,
    RCC_ICCLKSOURCE_PLL3,
    RCC_ICCLKSOURCE_PLL4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ICCLKSOURCE_PLL1 => 0,
            .RCC_ICCLKSOURCE_PLL2 => 1,
            .RCC_ICCLKSOURCE_PLL3 => 2,
            .RCC_ICCLKSOURCE_PLL4 => 3,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_MSI,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_IC5,
    RCC_MCO1SOURCE_IC10,
    RCC_MCO1SOURCE_SYSA,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_HSI => 0,
            .RCC_MCO1SOURCE_LSE => 1,
            .RCC_MCO1SOURCE_MSI => 2,
            .RCC_MCO1SOURCE_LSI => 3,
            .RCC_MCO1SOURCE_HSE => 4,
            .RCC_MCO1SOURCE_IC5 => 5,
            .RCC_MCO1SOURCE_IC10 => 6,
            .RCC_MCO1SOURCE_SYSA => 7,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_HSI,
    RCC_MCO2SOURCE_LSE,
    RCC_MCO2SOURCE_MSI,
    RCC_MCO2SOURCE_LSI,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_IC15,
    RCC_MCO2SOURCE_IC20,
    RCC_MCO2SOURCE_SYSB,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_HSI => 0,
            .RCC_MCO2SOURCE_LSE => 1,
            .RCC_MCO2SOURCE_MSI => 2,
            .RCC_MCO2SOURCE_LSI => 3,
            .RCC_MCO2SOURCE_HSE => 4,
            .RCC_MCO2SOURCE_IC15 => 5,
            .RCC_MCO2SOURCE_IC20 => 6,
            .RCC_MCO2SOURCE_SYSB => 7,
        };
    }
};
pub const CKPERSourceSelectionList = enum {
    RCC_CLKPCLKSOURCE_HSI,
    RCC_CLKPCLKSOURCE_MSI,
    RCC_CLKPCLKSOURCE_HSE,
    RCC_CLKPCLKSOURCE_IC5,
    RCC_CLKPCLKSOURCE_IC10,
    RCC_CLKPCLKSOURCE_IC15,
    RCC_CLKPCLKSOURCE_IC19,
    RCC_CLKPCLKSOURCE_IC20,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLKPCLKSOURCE_HSI => 0,
            .RCC_CLKPCLKSOURCE_MSI => 1,
            .RCC_CLKPCLKSOURCE_HSE => 2,
            .RCC_CLKPCLKSOURCE_IC5 => 3,
            .RCC_CLKPCLKSOURCE_IC10 => 4,
            .RCC_CLKPCLKSOURCE_IC15 => 5,
            .RCC_CLKPCLKSOURCE_IC19 => 6,
            .RCC_CLKPCLKSOURCE_IC20 => 7,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_HCLK,
    RCC_ADCCLKSOURCE_CLKP,
    RCC_ADCCLKSOURCE_IC7,
    RCC_ADCCLKSOURCE_IC8,
    RCC_ADCCLKSOURCE_MSI,
    RCC_ADCCLKSOURCE_HSI,
    RCC_ADCCLKSOURCE_PIN,
    RCC_ADCCLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_HCLK => 0,
            .RCC_ADCCLKSOURCE_CLKP => 1,
            .RCC_ADCCLKSOURCE_IC7 => 2,
            .RCC_ADCCLKSOURCE_IC8 => 3,
            .RCC_ADCCLKSOURCE_MSI => 4,
            .RCC_ADCCLKSOURCE_HSI => 5,
            .RCC_ADCCLKSOURCE_PIN => 6,
            .RCC_ADCCLKSOURCE_TIMG => 7,
        };
    }
};
pub const ADF1ClockSelectionList = enum {
    RCC_ADF1CLKSOURCE_HCLK,
    RCC_ADF1CLKSOURCE_CLKP,
    RCC_ADF1CLKSOURCE_IC7,
    RCC_ADF1CLKSOURCE_IC8,
    RCC_ADF1CLKSOURCE_MSI,
    RCC_ADF1CLKSOURCE_HSI,
    RCC_ADF1CLKSOURCE_PIN,
    RCC_ADF1CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADF1CLKSOURCE_HCLK => 0,
            .RCC_ADF1CLKSOURCE_CLKP => 1,
            .RCC_ADF1CLKSOURCE_IC7 => 2,
            .RCC_ADF1CLKSOURCE_IC8 => 3,
            .RCC_ADF1CLKSOURCE_MSI => 4,
            .RCC_ADF1CLKSOURCE_HSI => 5,
            .RCC_ADF1CLKSOURCE_PIN => 6,
            .RCC_ADF1CLKSOURCE_TIMG => 7,
        };
    }
};
pub const MDF1ClockSelectionList = enum {
    RCC_MDF1CLKSOURCE_HCLK,
    RCC_MDF1CLKSOURCE_CLKP,
    RCC_MDF1CLKSOURCE_IC7,
    RCC_MDF1CLKSOURCE_IC8,
    RCC_MDF1CLKSOURCE_MSI,
    RCC_MDF1CLKSOURCE_HSI,
    RCC_MDF1CLKSOURCE_PIN,
    RCC_MDF1CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MDF1CLKSOURCE_HCLK => 0,
            .RCC_MDF1CLKSOURCE_CLKP => 1,
            .RCC_MDF1CLKSOURCE_IC7 => 2,
            .RCC_MDF1CLKSOURCE_IC8 => 3,
            .RCC_MDF1CLKSOURCE_MSI => 4,
            .RCC_MDF1CLKSOURCE_HSI => 5,
            .RCC_MDF1CLKSOURCE_PIN => 6,
            .RCC_MDF1CLKSOURCE_TIMG => 7,
        };
    }
};
pub const PSSIClockSelectionList = enum {
    RCC_PSSICLKSOURCE_HCLK,
    RCC_PSSICLKSOURCE_CLKP,
    RCC_PSSICLKSOURCE_IC20,
    RCC_PSSICLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PSSICLKSOURCE_HCLK => 0,
            .RCC_PSSICLKSOURCE_CLKP => 1,
            .RCC_PSSICLKSOURCE_IC20 => 2,
            .RCC_PSSICLKSOURCE_HSI => 3,
        };
    }
};
pub const FDCANClockSelectionList = enum {
    RCC_FDCANCLKSOURCE_PCLK1,
    RCC_FDCANCLKSOURCE_CLKP,
    RCC_FDCANCLKSOURCE_IC19,
    RCC_FDCANCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FDCANCLKSOURCE_PCLK1 => 0,
            .RCC_FDCANCLKSOURCE_CLKP => 1,
            .RCC_FDCANCLKSOURCE_IC19 => 2,
            .RCC_FDCANCLKSOURCE_HSE => 3,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_CLKP,
    RCC_I2C1CLKSOURCE_IC10,
    RCC_I2C1CLKSOURCE_IC15,
    RCC_I2C1CLKSOURCE_MSI,
    RCC_I2C1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_CLKP => 1,
            .RCC_I2C1CLKSOURCE_IC10 => 2,
            .RCC_I2C1CLKSOURCE_IC15 => 3,
            .RCC_I2C1CLKSOURCE_MSI => 4,
            .RCC_I2C1CLKSOURCE_HSI => 5,
        };
    }
};
pub const I2C2CLockSelectionList = enum {
    RCC_I2C2CLKSOURCE_PCLK1,
    RCC_I2C2CLKSOURCE_CLKP,
    RCC_I2C2CLKSOURCE_IC10,
    RCC_I2C2CLKSOURCE_IC15,
    RCC_I2C2CLKSOURCE_MSI,
    RCC_I2C2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_PCLK1 => 0,
            .RCC_I2C2CLKSOURCE_CLKP => 1,
            .RCC_I2C2CLKSOURCE_IC10 => 2,
            .RCC_I2C2CLKSOURCE_IC15 => 3,
            .RCC_I2C2CLKSOURCE_MSI => 4,
            .RCC_I2C2CLKSOURCE_HSI => 5,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK1,
    RCC_I2C3CLKSOURCE_CLKP,
    RCC_I2C3CLKSOURCE_IC10,
    RCC_I2C3CLKSOURCE_IC15,
    RCC_I2C3CLKSOURCE_MSI,
    RCC_I2C3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK1 => 0,
            .RCC_I2C3CLKSOURCE_CLKP => 1,
            .RCC_I2C3CLKSOURCE_IC10 => 2,
            .RCC_I2C3CLKSOURCE_IC15 => 3,
            .RCC_I2C3CLKSOURCE_MSI => 4,
            .RCC_I2C3CLKSOURCE_HSI => 5,
        };
    }
};
pub const I2C4CLockSelectionList = enum {
    RCC_I2C4CLKSOURCE_PCLK1,
    RCC_I2C4CLKSOURCE_CLKP,
    RCC_I2C4CLKSOURCE_IC10,
    RCC_I2C4CLKSOURCE_IC15,
    RCC_I2C4CLKSOURCE_MSI,
    RCC_I2C4CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C4CLKSOURCE_PCLK1 => 0,
            .RCC_I2C4CLKSOURCE_CLKP => 1,
            .RCC_I2C4CLKSOURCE_IC10 => 2,
            .RCC_I2C4CLKSOURCE_IC15 => 3,
            .RCC_I2C4CLKSOURCE_MSI => 4,
            .RCC_I2C4CLKSOURCE_HSI => 5,
        };
    }
};
pub const I3C1CLockSelectionList = enum {
    RCC_I3C1CLKSOURCE_PCLK1,
    RCC_I3C1CLKSOURCE_CLKP,
    RCC_I3C1CLKSOURCE_IC10,
    RCC_I3C1CLKSOURCE_IC15,
    RCC_I3C1CLKSOURCE_MSI,
    RCC_I3C1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C1CLKSOURCE_PCLK1 => 0,
            .RCC_I3C1CLKSOURCE_CLKP => 1,
            .RCC_I3C1CLKSOURCE_IC10 => 2,
            .RCC_I3C1CLKSOURCE_IC15 => 3,
            .RCC_I3C1CLKSOURCE_MSI => 4,
            .RCC_I3C1CLKSOURCE_HSI => 5,
        };
    }
};
pub const I3C2CLockSelectionList = enum {
    RCC_I3C2CLKSOURCE_PCLK1,
    RCC_I3C2CLKSOURCE_CLKP,
    RCC_I3C2CLKSOURCE_IC10,
    RCC_I3C2CLKSOURCE_IC15,
    RCC_I3C2CLKSOURCE_MSI,
    RCC_I3C2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I3C2CLKSOURCE_PCLK1 => 0,
            .RCC_I3C2CLKSOURCE_CLKP => 1,
            .RCC_I3C2CLKSOURCE_IC10 => 2,
            .RCC_I3C2CLKSOURCE_IC15 => 3,
            .RCC_I3C2CLKSOURCE_MSI => 4,
            .RCC_I3C2CLKSOURCE_HSI => 5,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK1,
    RCC_LPTIM1CLKSOURCE_CLKP,
    RCC_LPTIM1CLKSOURCE_IC15,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM1CLKSOURCE_CLKP => 1,
            .RCC_LPTIM1CLKSOURCE_IC15 => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
            .RCC_LPTIM1CLKSOURCE_LSI => 4,
            .RCC_LPTIM1CLKSOURCE_TIMG => 5,
        };
    }
};
pub const LPTIM3CLockSelectionList = enum {
    RCC_LPTIM3CLKSOURCE_PCLK4,
    RCC_LPTIM3CLKSOURCE_CLKP,
    RCC_LPTIM3CLKSOURCE_IC15,
    RCC_LPTIM3CLKSOURCE_LSE,
    RCC_LPTIM3CLKSOURCE_LSI,
    RCC_LPTIM3CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM3CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM3CLKSOURCE_CLKP => 1,
            .RCC_LPTIM3CLKSOURCE_IC15 => 2,
            .RCC_LPTIM3CLKSOURCE_LSE => 3,
            .RCC_LPTIM3CLKSOURCE_LSI => 4,
            .RCC_LPTIM3CLKSOURCE_TIMG => 5,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK4,
    RCC_LPTIM2CLKSOURCE_CLKP,
    RCC_LPTIM2CLKSOURCE_IC15,
    RCC_LPTIM2CLKSOURCE_LSE,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM2CLKSOURCE_CLKP => 1,
            .RCC_LPTIM2CLKSOURCE_IC15 => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
            .RCC_LPTIM2CLKSOURCE_LSI => 4,
            .RCC_LPTIM2CLKSOURCE_TIMG => 5,
        };
    }
};
pub const LPTIM4CLockSelectionList = enum {
    RCC_LPTIM4CLKSOURCE_PCLK4,
    RCC_LPTIM4CLKSOURCE_CLKP,
    RCC_LPTIM4CLKSOURCE_IC15,
    RCC_LPTIM4CLKSOURCE_LSE,
    RCC_LPTIM4CLKSOURCE_LSI,
    RCC_LPTIM4CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM4CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM4CLKSOURCE_CLKP => 1,
            .RCC_LPTIM4CLKSOURCE_IC15 => 2,
            .RCC_LPTIM4CLKSOURCE_LSE => 3,
            .RCC_LPTIM4CLKSOURCE_LSI => 4,
            .RCC_LPTIM4CLKSOURCE_TIMG => 5,
        };
    }
};
pub const LPTIM5CLockSelectionList = enum {
    RCC_LPTIM5CLKSOURCE_PCLK4,
    RCC_LPTIM5CLKSOURCE_CLKP,
    RCC_LPTIM5CLKSOURCE_IC15,
    RCC_LPTIM5CLKSOURCE_LSE,
    RCC_LPTIM5CLKSOURCE_LSI,
    RCC_LPTIM5CLKSOURCE_TIMG,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM5CLKSOURCE_PCLK4 => 0,
            .RCC_LPTIM5CLKSOURCE_CLKP => 1,
            .RCC_LPTIM5CLKSOURCE_IC15 => 2,
            .RCC_LPTIM5CLKSOURCE_LSE => 3,
            .RCC_LPTIM5CLKSOURCE_LSI => 4,
            .RCC_LPTIM5CLKSOURCE_TIMG => 5,
        };
    }
};
pub const LTDCClockSelectionList = enum {
    RCC_LTDCCLKSOURCE_PCLK5,
    RCC_LTDCCLKSOURCE_CLKP,
    RCC_LTDCCLKSOURCE_IC16,
    RCC_LTDCCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LTDCCLKSOURCE_PCLK5 => 0,
            .RCC_LTDCCLKSOURCE_CLKP => 1,
            .RCC_LTDCCLKSOURCE_IC16 => 2,
            .RCC_LTDCCLKSOURCE_HSI => 3,
        };
    }
};
pub const DCMIPPClockSelectionList = enum {
    RCC_DCMIPPCLKSOURCE_PCLK5,
    RCC_DCMIPPCLKSOURCE_CLKP,
    RCC_DCMIPPCLKSOURCE_IC17,
    RCC_DCMIPPCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DCMIPPCLKSOURCE_PCLK5 => 0,
            .RCC_DCMIPPCLKSOURCE_CLKP => 1,
            .RCC_DCMIPPCLKSOURCE_IC17 => 2,
            .RCC_DCMIPPCLKSOURCE_HSI => 3,
        };
    }
};
pub const FMCClockSelectionList = enum {
    RCC_FMCCLKSOURCE_HCLK,
    RCC_FMCCLKSOURCE_CLKP,
    RCC_FMCCLKSOURCE_IC3,
    RCC_FMCCLKSOURCE_IC4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FMCCLKSOURCE_HCLK => 0,
            .RCC_FMCCLKSOURCE_CLKP => 1,
            .RCC_FMCCLKSOURCE_IC3 => 2,
            .RCC_FMCCLKSOURCE_IC4 => 3,
        };
    }
};
pub const SAI1ClockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PCLK2,
    RCC_SAI1CLKSOURCE_CLKP,
    RCC_SAI1CLKSOURCE_IC7,
    RCC_SAI1CLKSOURCE_IC8,
    RCC_SAI1CLKSOURCE_MSI,
    RCC_SAI1CLKSOURCE_HSI,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_SPDIFRX1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PCLK2 => 0,
            .RCC_SAI1CLKSOURCE_CLKP => 1,
            .RCC_SAI1CLKSOURCE_IC7 => 2,
            .RCC_SAI1CLKSOURCE_IC8 => 3,
            .RCC_SAI1CLKSOURCE_MSI => 4,
            .RCC_SAI1CLKSOURCE_HSI => 5,
            .RCC_SAI1CLKSOURCE_PIN => 6,
            .RCC_SAI1CLKSOURCE_SPDIFRX1 => 7,
        };
    }
};
pub const SAI2ClockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PCLK2,
    RCC_SAI2CLKSOURCE_CLKP,
    RCC_SAI2CLKSOURCE_IC7,
    RCC_SAI2CLKSOURCE_IC8,
    RCC_SAI2CLKSOURCE_MSI,
    RCC_SAI2CLKSOURCE_HSI,
    RCC_SAI2CLKSOURCE_PIN,
    RCC_SAI2CLKSOURCE_SPDIFRX1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PCLK2 => 0,
            .RCC_SAI2CLKSOURCE_CLKP => 1,
            .RCC_SAI2CLKSOURCE_IC7 => 2,
            .RCC_SAI2CLKSOURCE_IC8 => 3,
            .RCC_SAI2CLKSOURCE_MSI => 4,
            .RCC_SAI2CLKSOURCE_HSI => 5,
            .RCC_SAI2CLKSOURCE_PIN => 6,
            .RCC_SAI2CLKSOURCE_SPDIFRX1 => 7,
        };
    }
};
pub const USART1ClockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK2,
    RCC_USART1CLKSOURCE_CLKP,
    RCC_USART1CLKSOURCE_IC9,
    RCC_USART1CLKSOURCE_IC14,
    RCC_USART1CLKSOURCE_LSE,
    RCC_USART1CLKSOURCE_MSI,
    RCC_USART1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_CLKP => 1,
            .RCC_USART1CLKSOURCE_IC9 => 2,
            .RCC_USART1CLKSOURCE_IC14 => 3,
            .RCC_USART1CLKSOURCE_LSE => 4,
            .RCC_USART1CLKSOURCE_MSI => 5,
            .RCC_USART1CLKSOURCE_HSI => 6,
        };
    }
};
pub const USART2ClockSelectionList = enum {
    RCC_USART2CLKSOURCE_PCLK1,
    RCC_USART2CLKSOURCE_CLKP,
    RCC_USART2CLKSOURCE_IC9,
    RCC_USART2CLKSOURCE_IC14,
    RCC_USART2CLKSOURCE_LSE,
    RCC_USART2CLKSOURCE_MSI,
    RCC_USART2CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_PCLK1 => 0,
            .RCC_USART2CLKSOURCE_CLKP => 1,
            .RCC_USART2CLKSOURCE_IC9 => 2,
            .RCC_USART2CLKSOURCE_IC14 => 3,
            .RCC_USART2CLKSOURCE_LSE => 4,
            .RCC_USART2CLKSOURCE_MSI => 5,
            .RCC_USART2CLKSOURCE_HSI => 6,
        };
    }
};
pub const USART3ClockSelectionList = enum {
    RCC_USART3CLKSOURCE_PCLK1,
    RCC_USART3CLKSOURCE_CLKP,
    RCC_USART3CLKSOURCE_IC9,
    RCC_USART3CLKSOURCE_IC14,
    RCC_USART3CLKSOURCE_LSE,
    RCC_USART3CLKSOURCE_MSI,
    RCC_USART3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART3CLKSOURCE_PCLK1 => 0,
            .RCC_USART3CLKSOURCE_CLKP => 1,
            .RCC_USART3CLKSOURCE_IC9 => 2,
            .RCC_USART3CLKSOURCE_IC14 => 3,
            .RCC_USART3CLKSOURCE_LSE => 4,
            .RCC_USART3CLKSOURCE_MSI => 5,
            .RCC_USART3CLKSOURCE_HSI => 6,
        };
    }
};
pub const UART4ClockSelectionList = enum {
    RCC_UART4CLKSOURCE_PCLK1,
    RCC_UART4CLKSOURCE_CLKP,
    RCC_UART4CLKSOURCE_IC9,
    RCC_UART4CLKSOURCE_IC14,
    RCC_UART4CLKSOURCE_LSE,
    RCC_UART4CLKSOURCE_MSI,
    RCC_UART4CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_PCLK1 => 0,
            .RCC_UART4CLKSOURCE_CLKP => 1,
            .RCC_UART4CLKSOURCE_IC9 => 2,
            .RCC_UART4CLKSOURCE_IC14 => 3,
            .RCC_UART4CLKSOURCE_LSE => 4,
            .RCC_UART4CLKSOURCE_MSI => 5,
            .RCC_UART4CLKSOURCE_HSI => 6,
        };
    }
};
pub const UART5ClockSelectionList = enum {
    RCC_UART5CLKSOURCE_PCLK1,
    RCC_UART5CLKSOURCE_CLKP,
    RCC_UART5CLKSOURCE_IC9,
    RCC_UART5CLKSOURCE_IC14,
    RCC_UART5CLKSOURCE_LSE,
    RCC_UART5CLKSOURCE_MSI,
    RCC_UART5CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART5CLKSOURCE_PCLK1 => 0,
            .RCC_UART5CLKSOURCE_CLKP => 1,
            .RCC_UART5CLKSOURCE_IC9 => 2,
            .RCC_UART5CLKSOURCE_IC14 => 3,
            .RCC_UART5CLKSOURCE_LSE => 4,
            .RCC_UART5CLKSOURCE_MSI => 5,
            .RCC_UART5CLKSOURCE_HSI => 6,
        };
    }
};
pub const USART6ClockSelectionList = enum {
    RCC_USART6CLKSOURCE_PCLK2,
    RCC_USART6CLKSOURCE_CLKP,
    RCC_USART6CLKSOURCE_IC9,
    RCC_USART6CLKSOURCE_IC14,
    RCC_USART6CLKSOURCE_LSE,
    RCC_USART6CLKSOURCE_MSI,
    RCC_USART6CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART6CLKSOURCE_PCLK2 => 0,
            .RCC_USART6CLKSOURCE_CLKP => 1,
            .RCC_USART6CLKSOURCE_IC9 => 2,
            .RCC_USART6CLKSOURCE_IC14 => 3,
            .RCC_USART6CLKSOURCE_LSE => 4,
            .RCC_USART6CLKSOURCE_MSI => 5,
            .RCC_USART6CLKSOURCE_HSI => 6,
        };
    }
};
pub const UART7ClockSelectionList = enum {
    RCC_UART7CLKSOURCE_PCLK1,
    RCC_UART7CLKSOURCE_CLKP,
    RCC_UART7CLKSOURCE_IC9,
    RCC_UART7CLKSOURCE_IC14,
    RCC_UART7CLKSOURCE_LSE,
    RCC_UART7CLKSOURCE_MSI,
    RCC_UART7CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART7CLKSOURCE_PCLK1 => 0,
            .RCC_UART7CLKSOURCE_CLKP => 1,
            .RCC_UART7CLKSOURCE_IC9 => 2,
            .RCC_UART7CLKSOURCE_IC14 => 3,
            .RCC_UART7CLKSOURCE_LSE => 4,
            .RCC_UART7CLKSOURCE_MSI => 5,
            .RCC_UART7CLKSOURCE_HSI => 6,
        };
    }
};
pub const UART8ClockSelectionList = enum {
    RCC_UART8CLKSOURCE_PCLK1,
    RCC_UART8CLKSOURCE_CLKP,
    RCC_UART8CLKSOURCE_IC9,
    RCC_UART8CLKSOURCE_IC14,
    RCC_UART8CLKSOURCE_LSE,
    RCC_UART8CLKSOURCE_MSI,
    RCC_UART8CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART8CLKSOURCE_PCLK1 => 0,
            .RCC_UART8CLKSOURCE_CLKP => 1,
            .RCC_UART8CLKSOURCE_IC9 => 2,
            .RCC_UART8CLKSOURCE_IC14 => 3,
            .RCC_UART8CLKSOURCE_LSE => 4,
            .RCC_UART8CLKSOURCE_MSI => 5,
            .RCC_UART8CLKSOURCE_HSI => 6,
        };
    }
};
pub const UART9ClockSelectionList = enum {
    RCC_UART9CLKSOURCE_PCLK2,
    RCC_UART9CLKSOURCE_CLKP,
    RCC_UART9CLKSOURCE_IC9,
    RCC_UART9CLKSOURCE_IC14,
    RCC_UART9CLKSOURCE_LSE,
    RCC_UART9CLKSOURCE_MSI,
    RCC_UART9CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART9CLKSOURCE_PCLK2 => 0,
            .RCC_UART9CLKSOURCE_CLKP => 1,
            .RCC_UART9CLKSOURCE_IC9 => 2,
            .RCC_UART9CLKSOURCE_IC14 => 3,
            .RCC_UART9CLKSOURCE_LSE => 4,
            .RCC_UART9CLKSOURCE_MSI => 5,
            .RCC_UART9CLKSOURCE_HSI => 6,
        };
    }
};
pub const LPUART1ClockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK4,
    RCC_LPUART1CLKSOURCE_CLKP,
    RCC_LPUART1CLKSOURCE_IC9,
    RCC_LPUART1CLKSOURCE_IC14,
    RCC_LPUART1CLKSOURCE_LSE,
    RCC_LPUART1CLKSOURCE_MSI,
    RCC_LPUART1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK4 => 0,
            .RCC_LPUART1CLKSOURCE_CLKP => 1,
            .RCC_LPUART1CLKSOURCE_IC9 => 2,
            .RCC_LPUART1CLKSOURCE_IC14 => 3,
            .RCC_LPUART1CLKSOURCE_LSE => 4,
            .RCC_LPUART1CLKSOURCE_MSI => 5,
            .RCC_LPUART1CLKSOURCE_HSI => 6,
        };
    }
};
pub const USART10ClockSelectionList = enum {
    RCC_USART10CLKSOURCE_PCLK2,
    RCC_USART10CLKSOURCE_CLKP,
    RCC_USART10CLKSOURCE_IC9,
    RCC_USART10CLKSOURCE_IC14,
    RCC_USART10CLKSOURCE_LSE,
    RCC_USART10CLKSOURCE_MSI,
    RCC_USART10CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART10CLKSOURCE_PCLK2 => 0,
            .RCC_USART10CLKSOURCE_CLKP => 1,
            .RCC_USART10CLKSOURCE_IC9 => 2,
            .RCC_USART10CLKSOURCE_IC14 => 3,
            .RCC_USART10CLKSOURCE_LSE => 4,
            .RCC_USART10CLKSOURCE_MSI => 5,
            .RCC_USART10CLKSOURCE_HSI => 6,
        };
    }
};
pub const SPI1ClockSelectionList = enum {
    RCC_SPI1CLKSOURCE_PCLK2,
    RCC_SPI1CLKSOURCE_CLKP,
    RCC_SPI1CLKSOURCE_IC8,
    RCC_SPI1CLKSOURCE_IC9,
    RCC_SPI1CLKSOURCE_MSI,
    RCC_SPI1CLKSOURCE_HSI,
    RCC_SPI1CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PCLK2 => 0,
            .RCC_SPI1CLKSOURCE_CLKP => 1,
            .RCC_SPI1CLKSOURCE_IC8 => 2,
            .RCC_SPI1CLKSOURCE_IC9 => 3,
            .RCC_SPI1CLKSOURCE_MSI => 4,
            .RCC_SPI1CLKSOURCE_HSI => 5,
            .RCC_SPI1CLKSOURCE_PIN => 6,
        };
    }
};
pub const SPI2ClockSelectionList = enum {
    RCC_SPI2CLKSOURCE_PCLK1,
    RCC_SPI2CLKSOURCE_CLKP,
    RCC_SPI2CLKSOURCE_IC8,
    RCC_SPI2CLKSOURCE_IC9,
    RCC_SPI2CLKSOURCE_MSI,
    RCC_SPI2CLKSOURCE_HSI,
    RCC_SPI2CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI2CLKSOURCE_PCLK1 => 0,
            .RCC_SPI2CLKSOURCE_CLKP => 1,
            .RCC_SPI2CLKSOURCE_IC8 => 2,
            .RCC_SPI2CLKSOURCE_IC9 => 3,
            .RCC_SPI2CLKSOURCE_MSI => 4,
            .RCC_SPI2CLKSOURCE_HSI => 5,
            .RCC_SPI2CLKSOURCE_PIN => 6,
        };
    }
};
pub const SPI3ClockSelectionList = enum {
    RCC_SPI3CLKSOURCE_PCLK1,
    RCC_SPI3CLKSOURCE_CLKP,
    RCC_SPI3CLKSOURCE_IC8,
    RCC_SPI3CLKSOURCE_IC9,
    RCC_SPI3CLKSOURCE_MSI,
    RCC_SPI3CLKSOURCE_HSI,
    RCC_SPI3CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3CLKSOURCE_PCLK1 => 0,
            .RCC_SPI3CLKSOURCE_CLKP => 1,
            .RCC_SPI3CLKSOURCE_IC8 => 2,
            .RCC_SPI3CLKSOURCE_IC9 => 3,
            .RCC_SPI3CLKSOURCE_MSI => 4,
            .RCC_SPI3CLKSOURCE_HSI => 5,
            .RCC_SPI3CLKSOURCE_PIN => 6,
        };
    }
};
pub const SPI4ClockSelectionList = enum {
    RCC_SPI4CLKSOURCE_PCLK2,
    RCC_SPI4CLKSOURCE_CLKP,
    RCC_SPI4CLKSOURCE_IC9,
    RCC_SPI4CLKSOURCE_IC14,
    RCC_SPI4CLKSOURCE_MSI,
    RCC_SPI4CLKSOURCE_HSI,
    RCC_SPI4CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI4CLKSOURCE_PCLK2 => 0,
            .RCC_SPI4CLKSOURCE_CLKP => 1,
            .RCC_SPI4CLKSOURCE_IC9 => 2,
            .RCC_SPI4CLKSOURCE_IC14 => 3,
            .RCC_SPI4CLKSOURCE_MSI => 4,
            .RCC_SPI4CLKSOURCE_HSI => 5,
            .RCC_SPI4CLKSOURCE_HSE => 6,
        };
    }
};
pub const SPI5ClockSelectionList = enum {
    RCC_SPI5CLKSOURCE_PCLK2,
    RCC_SPI5CLKSOURCE_CLKP,
    RCC_SPI5CLKSOURCE_IC9,
    RCC_SPI5CLKSOURCE_IC14,
    RCC_SPI5CLKSOURCE_MSI,
    RCC_SPI5CLKSOURCE_HSI,
    RCC_SPI5CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI5CLKSOURCE_PCLK2 => 0,
            .RCC_SPI5CLKSOURCE_CLKP => 1,
            .RCC_SPI5CLKSOURCE_IC9 => 2,
            .RCC_SPI5CLKSOURCE_IC14 => 3,
            .RCC_SPI5CLKSOURCE_MSI => 4,
            .RCC_SPI5CLKSOURCE_HSI => 5,
            .RCC_SPI5CLKSOURCE_HSE => 6,
        };
    }
};
pub const SPI6ClockSelectionList = enum {
    RCC_SPI6CLKSOURCE_PCLK4,
    RCC_SPI6CLKSOURCE_CLKP,
    RCC_SPI6CLKSOURCE_IC8,
    RCC_SPI6CLKSOURCE_IC9,
    RCC_SPI6CLKSOURCE_MSI,
    RCC_SPI6CLKSOURCE_HSI,
    RCC_SPI6CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI6CLKSOURCE_PCLK4 => 0,
            .RCC_SPI6CLKSOURCE_CLKP => 1,
            .RCC_SPI6CLKSOURCE_IC8 => 2,
            .RCC_SPI6CLKSOURCE_IC9 => 3,
            .RCC_SPI6CLKSOURCE_MSI => 4,
            .RCC_SPI6CLKSOURCE_HSI => 5,
            .RCC_SPI6CLKSOURCE_PIN => 6,
        };
    }
};
pub const XSPI1ClockSelectionList = enum {
    RCC_XSPI1CLKSOURCE_HCLK,
    RCC_XSPI1CLKSOURCE_CLKP,
    RCC_XSPI1CLKSOURCE_IC3,
    RCC_XSPI1CLKSOURCE_IC4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_XSPI1CLKSOURCE_HCLK => 0,
            .RCC_XSPI1CLKSOURCE_CLKP => 1,
            .RCC_XSPI1CLKSOURCE_IC3 => 2,
            .RCC_XSPI1CLKSOURCE_IC4 => 3,
        };
    }
};
pub const XSPI2ClockSelectionList = enum {
    RCC_XSPI2CLKSOURCE_HCLK,
    RCC_XSPI2CLKSOURCE_CLKP,
    RCC_XSPI2CLKSOURCE_IC3,
    RCC_XSPI2CLKSOURCE_IC4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_XSPI2CLKSOURCE_HCLK => 0,
            .RCC_XSPI2CLKSOURCE_CLKP => 1,
            .RCC_XSPI2CLKSOURCE_IC3 => 2,
            .RCC_XSPI2CLKSOURCE_IC4 => 3,
        };
    }
};
pub const OTGHS1ClockSelectionList = enum {
    RCC_USBPHY1REFCLKSOURCE_OTGPHY1,
    RCC_USBPHY1REFCLKSOURCE_HSE_DIRECT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBPHY1REFCLKSOURCE_OTGPHY1 => 0,
            .RCC_USBPHY1REFCLKSOURCE_HSE_DIRECT => 1,
        };
    }
};
pub const OTGHS2ClockSelectionList = enum {
    RCC_USBPHY2REFCLKSOURCE_OTGPHY2,
    RCC_USBPHY2REFCLKSOURCE_HSE_DIRECT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBPHY2REFCLKSOURCE_OTGPHY2 => 0,
            .RCC_USBPHY2REFCLKSOURCE_HSE_DIRECT => 1,
        };
    }
};
pub const XSPI3ClockSelectionList = enum {
    RCC_XSPI3CLKSOURCE_HCLK,
    RCC_XSPI3CLKSOURCE_CLKP,
    RCC_XSPI3CLKSOURCE_IC3,
    RCC_XSPI3CLKSOURCE_IC4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_XSPI3CLKSOURCE_HCLK => 0,
            .RCC_XSPI3CLKSOURCE_CLKP => 1,
            .RCC_XSPI3CLKSOURCE_IC3 => 2,
            .RCC_XSPI3CLKSOURCE_IC4 => 3,
        };
    }
};
pub const OTGPHY1ClockSelectionList = enum {
    RCC_USBOTGHS1CLKSOURCE_HSE_DIRECT,
    RCC_USBOTGHS1CLKSOURCE_CLKP,
    RCC_USBOTGHS1CLKSOURCE_IC15,
    RCC_USBOTGHS1CLKSOURCE_HSE_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBOTGHS1CLKSOURCE_HSE_DIRECT => 0,
            .RCC_USBOTGHS1CLKSOURCE_CLKP => 1,
            .RCC_USBOTGHS1CLKSOURCE_IC15 => 2,
            .RCC_USBOTGHS1CLKSOURCE_HSE_DIV2 => 3,
        };
    }
};
pub const OTGPHY2ClockSelectionList = enum {
    RCC_USBOTGHS2CLKSOURCE_HSE_DIRECT,
    RCC_USBOTGHS2CLKSOURCE_CLKP,
    RCC_USBOTGHS2CLKSOURCE_IC15,
    RCC_USBOTGHS2CLKSOURCE_HSE_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBOTGHS2CLKSOURCE_HSE_DIRECT => 0,
            .RCC_USBOTGHS2CLKSOURCE_CLKP => 1,
            .RCC_USBOTGHS2CLKSOURCE_IC15 => 2,
            .RCC_USBOTGHS2CLKSOURCE_HSE_DIV2 => 3,
        };
    }
};
pub const SDMMC1ClockSelectionList = enum {
    RCC_SDMMC1CLKSOURCE_HCLK,
    RCC_SDMMC1CLKSOURCE_CLKP,
    RCC_SDMMC1CLKSOURCE_IC4,
    RCC_SDMMC1CLKSOURCE_IC5,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC1CLKSOURCE_HCLK => 0,
            .RCC_SDMMC1CLKSOURCE_CLKP => 1,
            .RCC_SDMMC1CLKSOURCE_IC4 => 2,
            .RCC_SDMMC1CLKSOURCE_IC5 => 3,
        };
    }
};
pub const SDMMC2ClockSelectionList = enum {
    RCC_SDMMC2CLKSOURCE_HCLK,
    RCC_SDMMC2CLKSOURCE_CLKP,
    RCC_SDMMC2CLKSOURCE_IC4,
    RCC_SDMMC2CLKSOURCE_IC5,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDMMC2CLKSOURCE_HCLK => 0,
            .RCC_SDMMC2CLKSOURCE_CLKP => 1,
            .RCC_SDMMC2CLKSOURCE_IC4 => 2,
            .RCC_SDMMC2CLKSOURCE_IC5 => 3,
        };
    }
};
pub const ETH1ClockSelectionList = enum {
    RCC_ETH1CLKSOURCE_HCLK,
    RCC_ETH1CLKSOURCE_CLKP,
    RCC_ETH1CLKSOURCE_IC12,
    RCC_ETH1CLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ETH1CLKSOURCE_HCLK => 0,
            .RCC_ETH1CLKSOURCE_CLKP => 1,
            .RCC_ETH1CLKSOURCE_IC12 => 2,
            .RCC_ETH1CLKSOURCE_HSE => 3,
        };
    }
};
pub const SPDIFRX1ClockSelectionList = enum {
    RCC_SPDIFRX1CLKSOURCE_PCLK1,
    RCC_SPDIFRX1CLKSOURCE_CLKP,
    RCC_SPDIFRX1CLKSOURCE_IC7,
    RCC_SPDIFRX1CLKSOURCE_IC8,
    RCC_SPDIFRX1CLKSOURCE_MSI,
    RCC_SPDIFRX1CLKSOURCE_HSI,
    RCC_SPDIFRX1CLKSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPDIFRX1CLKSOURCE_PCLK1 => 0,
            .RCC_SPDIFRX1CLKSOURCE_CLKP => 1,
            .RCC_SPDIFRX1CLKSOURCE_IC7 => 2,
            .RCC_SPDIFRX1CLKSOURCE_IC8 => 3,
            .RCC_SPDIFRX1CLKSOURCE_MSI => 4,
            .RCC_SPDIFRX1CLKSOURCE_HSI => 5,
            .RCC_SPDIFRX1CLKSOURCE_PIN => 6,
        };
    }
};
pub const SYSBCLKSourceList = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_MSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_IC2_IC6_IC11,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_MSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
            .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => 3,
        };
    }
};
pub const SYSCCLKSourceList = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_MSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_IC2_IC6_IC11,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_MSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
            .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => 3,
        };
    }
};
pub const SYSDCLKSourceList = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_MSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_IC2_IC6_IC11,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_MSI => 1,
            .RCC_SYSCLKSOURCE_HSE => 2,
            .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => 3,
        };
    }
};
pub const CPUCLKSourceList = enum {
    RCC_CPUCLKSOURCE_HSI,
    RCC_CPUCLKSOURCE_MSI,
    RCC_CPUCLKSOURCE_HSE,
    RCC_CPUCLKSOURCE_IC1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CPUCLKSOURCE_HSI => 0,
            .RCC_CPUCLKSOURCE_MSI => 1,
            .RCC_CPUCLKSOURCE_HSE => 2,
            .RCC_CPUCLKSOURCE_IC1 => 3,
        };
    }
};
pub const PLL1SourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_MSI,
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_MSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
            .RCC_PLLSOURCE_PIN => 3,
        };
    }
};
pub const PLL2SourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_MSI,
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_MSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
            .RCC_PLLSOURCE_PIN => 3,
        };
    }
};
pub const PLL3SourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_MSI,
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_MSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
            .RCC_PLLSOURCE_PIN => 3,
        };
    }
};
pub const PLL4SourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_MSI,
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_PIN,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_MSI => 1,
            .RCC_PLLSOURCE_HSE => 2,
            .RCC_PLLSOURCE_PIN => 3,
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
pub const HSIDiv4List = enum {
    @"4",
};
pub const HSE_DivList = enum {
    @"1",
    @"2",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"1" => 1,
            .@"2" => 2,
        };
    }
};
pub const HSE_Div2List = enum {
    @"2",
};
pub const MSIClockRangeList = enum {
    RCC_MSI_FREQ_16MHZ,
    RCC_MSI_FREQ_4MHZ,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSI_FREQ_16MHZ => 16,
            .RCC_MSI_FREQ_4MHZ => 4,
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
pub const OTGPHY1Freq_ValueList = enum {
    @"19200000",
    @"20000000",
    @"24000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"19200000" => 19200000,
            .@"20000000" => 20000000,
            .@"24000000" => 24000000,
        };
    }
};
pub const OTGPHY2Freq_ValueList = enum {
    @"19200000",
    @"20000000",
    @"24000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"19200000" => 19200000,
            .@"20000000" => 20000000,
            .@"24000000" => 24000000,
        };
    }
};
pub const TPIUPrescalerList = enum {
    @"8",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"8" => 8,
        };
    }
};
pub const Cortex_DivList = enum {
    @"8",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"8" => 8,
        };
    }
};
pub const HPRE_DivList = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    RCC_HCLK_DIV32,
    RCC_HCLK_DIV64,
    RCC_HCLK_DIV128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV1 => 1,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV16 => 16,
            .RCC_HCLK_DIV32 => 32,
            .RCC_HCLK_DIV64 => 64,
            .RCC_HCLK_DIV128 => 128,
        };
    }
};
pub const APB4DIVList = enum {
    RCC_APB4_DIV1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB4_DIV1 => 1,
        };
    }
};
pub const APB5DIVList = enum {
    RCC_APB5_DIV1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB5_DIV1 => 1,
        };
    }
};
pub const TIMGDIVList = enum {
    RCC_TIMPRES_DIV1,
    RCC_TIMPRES_DIV2,
    RCC_TIMPRES_DIV4,
    RCC_TIMPRES_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_TIMPRES_DIV1 => 1,
            .RCC_TIMPRES_DIV2 => 2,
            .RCC_TIMPRES_DIV4 => 4,
            .RCC_TIMPRES_DIV8 => 8,
        };
    }
};
pub const APB1DIVList = enum {
    RCC_APB1_DIV1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB1_DIV1 => 1,
        };
    }
};
pub const APB2DIVList = enum {
    RCC_APB2_DIV1,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB2_DIV1 => 1,
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
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE0,
    PWR_REGULATOR_VOLTAGE_SCALE1,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
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
pub const EnableUCPD1List = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const OTG1EnableList = enum {
    true,
    false,
};
pub const OTG2EnableList = enum {
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
pub const XSPI1EnableList = enum {
    true,
    false,
};
pub const XSPI2EnableList = enum {
    true,
    false,
};
pub const XSPI3EnableList = enum {
    true,
    false,
};
pub const FMCEnableList = enum {
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
pub const CKPEREnableList = enum {
    true,
    false,
};
pub const MCO1OutPutEnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const EnableADF1List = enum {
    true,
    false,
};
pub const EnableMDF1List = enum {
    true,
    false,
};
pub const EnableSAI1List = enum {
    true,
    false,
};
pub const EnableSAI2List = enum {
    true,
    false,
};
pub const EnableSPDIFRXList = enum {
    true,
    false,
};
pub const EnableSPI1List = enum {
    true,
    false,
};
pub const EnableSPI2List = enum {
    true,
    false,
};
pub const EnableSPI3List = enum {
    true,
    false,
};
pub const EnableSPI6List = enum {
    true,
    false,
};
pub const EnableSPI4List = enum {
    true,
    false,
};
pub const EnableSPI5List = enum {
    true,
    false,
};
pub const EnableLPUART1List = enum {
    true,
    false,
};
pub const EnableUSART1List = enum {
    true,
    false,
};
pub const EnableUSART2List = enum {
    true,
    false,
};
pub const EnableUSART3List = enum {
    true,
    false,
};
pub const EnableUSART6List = enum {
    true,
    false,
};
pub const EnableUSART10List = enum {
    true,
    false,
};
pub const EnableUART4List = enum {
    true,
    false,
};
pub const EnableUART5List = enum {
    true,
    false,
};
pub const EnableUART7List = enum {
    true,
    false,
};
pub const EnableUART8List = enum {
    true,
    false,
};
pub const EnableUART9List = enum {
    true,
    false,
};
pub const EnableI2C1List = enum {
    true,
    false,
};
pub const EnableI2C2List = enum {
    true,
    false,
};
pub const EnableI2C3List = enum {
    true,
    false,
};
pub const EnableI2C4List = enum {
    true,
    false,
};
pub const EnableI3C1List = enum {
    true,
    false,
};
pub const EnableI3C2List = enum {
    true,
    false,
};
pub const ETH1EnableList = enum {
    true,
    false,
};
pub const MCO2OutPutEnableList = enum {
    true,
    false,
};
pub const EnableLPTIM1List = enum {
    true,
    false,
};
pub const EnableLPTIM2List = enum {
    true,
    false,
};
pub const EnableLPTIM3List = enum {
    true,
    false,
};
pub const EnableLPTIM4List = enum {
    true,
    false,
};
pub const EnableLPTIM5List = enum {
    true,
    false,
};
pub const EnableLTDCList = enum {
    true,
    false,
};
pub const EnableDCMIList = enum {
    true,
    false,
};
pub const EnableCSIList = enum {
    true,
    false,
};
pub const EnableFDCAN123List = enum {
    true,
    false,
};
pub const PSSIEnableList = enum {
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
pub const EnableLSERTCList = enum {
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
            IWDG_Used: bool = false,
            UCPD1_Used: bool = false,
            USB1_OTG_HS_Used: bool = false,
            USB2_OTG_HS_Used: bool = false,
            XSPI1_Used: bool = false,
            XSPI2_Used: bool = false,
            XSPI3_Used: bool = false,
            FMC_Used: bool = false,
            SDMMC1_Used: bool = false,
            SDMMC2_Used: bool = false,
            LPUART1_Used: bool = false,
            ADC1_Used: bool = false,
            ADC2_Used: bool = false,
            ADF1_Used: bool = false,
            DCMI_Used: bool = false,
            DCMIPP_Used: bool = false,
            FDCAN1_Used: bool = false,
            FDCAN2_Used: bool = false,
            FDCAN3_Used: bool = false,
            I2C1_Used: bool = false,
            I2C2_Used: bool = false,
            I2C3_Used: bool = false,
            I2C4_Used: bool = false,
            I3C1_Used: bool = false,
            I3C2_Used: bool = false,
            MDF1_Used: bool = false,
            LPTIM1_Used: bool = false,
            LPTIM2_Used: bool = false,
            LPTIM3_Used: bool = false,
            LPTIM4_Used: bool = false,
            LPTIM5_Used: bool = false,
            LTDC_Used: bool = false,
            PSSI_Used: bool = false,
            SAI1_Used: bool = false,
            SAI2_Used: bool = false,
            SPDIFRX1_Used: bool = false,
            USART1_Used: bool = false,
            USART2_Used: bool = false,
            USART3_Used: bool = false,
            UART4_Used: bool = false,
            UART5_Used: bool = false,
            UART7_Used: bool = false,
            UART8_Used: bool = false,
            UART9_Used: bool = false,
            USART6_Used: bool = false,
            USART10_Used: bool = false,
            SPI1_Used: bool = false,
            SPI2_Used: bool = false,
            SPI3_Used: bool = false,
            SPI4_Used: bool = false,
            SPI5_Used: bool = false,
            SPI6_Used: bool = false,
            ETH1_Used: bool = false,
            I2S1_Used: bool = false,
            I2S2_Used: bool = false,
            I2S3_Used: bool = false,
            I2S6_Used: bool = false,
            CSI_Used: bool = false,
            RTC_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null,
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null,
            VDD_VALUE: ?f32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSIDiv: ?HSIDivList = null,
            HSE_VALUE: ?f32 = null,
            HSE_Div: ?HSE_DivList = null,
            LSE_VALUE: ?f32 = null,
            MSIClockRange: ?MSIClockRangeList = null,
            IC1CLKSource: ?IC1CLKSourceList = null,
            IC1Div: ?u32 = null,
            IC2CLKSource: ?IC2CLKSourceList = null,
            IC2Div: ?u32 = null,
            IC3CLKSource: ?IC3CLKSourceList = null,
            IC3Div: ?u32 = null,
            IC4CLKSource: ?IC4CLKSourceList = null,
            IC4Div: ?u32 = null,
            IC5CLKSource: ?IC5CLKSourceList = null,
            IC5Div: ?u32 = null,
            IC6CLKSource: ?IC6CLKSourceList = null,
            IC6Div: ?u32 = null,
            IC7CLKSource: ?IC7CLKSourceList = null,
            IC7Div: ?u32 = null,
            IC8CLKSource: ?IC8CLKSourceList = null,
            IC8Div: ?u32 = null,
            IC9CLKSource: ?IC9CLKSourceList = null,
            IC9Div: ?u32 = null,
            IC10CLKSource: ?IC10CLKSourceList = null,
            IC10Div: ?u32 = null,
            IC11CLKSource: ?IC11CLKSourceList = null,
            IC11Div: ?u32 = null,
            IC12CLKSource: ?IC12CLKSourceList = null,
            IC12Div: ?u32 = null,
            IC13CLKSource: ?IC13CLKSourceList = null,
            IC13Div: ?u32 = null,
            IC14CLKSource: ?IC14CLKSourceList = null,
            IC14Div: ?u32 = null,
            IC15CLKSource: ?IC15CLKSourceList = null,
            IC15Div: ?u32 = null,
            IC16CLKSource: ?IC16CLKSourceList = null,
            IC16Div: ?u32 = null,
            IC17CLKSource: ?IC17CLKSourceList = null,
            IC17Div: ?u32 = null,
            IC18CLKSource: ?IC18CLKSourceList = null,
            IC18Div: ?u32 = null,
            IC19CLKSource: ?IC19CLKSourceList = null,
            IC19Div: ?u32 = null,
            IC20CLKSource: ?IC20CLKSourceList = null,
            IC20Div: ?u32 = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            CKPERSourceSelection: ?CKPERSourceSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            ADCDIV: ?u32 = null,
            ADF1ClockSelection: ?ADF1ClockSelectionList = null,
            MDF1ClockSelection: ?MDF1ClockSelectionList = null,
            PSSIClockSelection: ?PSSIClockSelectionList = null,
            FDCANClockSelection: ?FDCANClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C2CLockSelection: ?I2C2CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            I2C4CLockSelection: ?I2C4CLockSelectionList = null,
            I3C1CLockSelection: ?I3C1CLockSelectionList = null,
            I3C2CLockSelection: ?I3C2CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            LPTIM4CLockSelection: ?LPTIM4CLockSelectionList = null,
            LPTIM5CLockSelection: ?LPTIM5CLockSelectionList = null,
            LTDCClockSelection: ?LTDCClockSelectionList = null,
            DCMIPPClockSelection: ?DCMIPPClockSelectionList = null,
            FMCClockSelection: ?FMCClockSelectionList = null,
            SAI1ClockSelection: ?SAI1ClockSelectionList = null,
            SAI2ClockSelection: ?SAI2ClockSelectionList = null,
            USART1ClockSelection: ?USART1ClockSelectionList = null,
            USART2ClockSelection: ?USART2ClockSelectionList = null,
            USART3ClockSelection: ?USART3ClockSelectionList = null,
            UART4ClockSelection: ?UART4ClockSelectionList = null,
            UART5ClockSelection: ?UART5ClockSelectionList = null,
            USART6ClockSelection: ?USART6ClockSelectionList = null,
            UART7ClockSelection: ?UART7ClockSelectionList = null,
            UART8ClockSelection: ?UART8ClockSelectionList = null,
            UART9ClockSelection: ?UART9ClockSelectionList = null,
            LPUART1ClockSelection: ?LPUART1ClockSelectionList = null,
            USART10ClockSelection: ?USART10ClockSelectionList = null,
            SPI1ClockSelection: ?SPI1ClockSelectionList = null,
            SPI2ClockSelection: ?SPI2ClockSelectionList = null,
            SPI3ClockSelection: ?SPI3ClockSelectionList = null,
            SPI4ClockSelection: ?SPI4ClockSelectionList = null,
            SPI5ClockSelection: ?SPI5ClockSelectionList = null,
            SPI6ClockSelection: ?SPI6ClockSelectionList = null,
            XSPI1ClockSelection: ?XSPI1ClockSelectionList = null,
            XSPI2ClockSelection: ?XSPI2ClockSelectionList = null,
            OTGHS1ClockSelection: ?OTGHS1ClockSelectionList = null,
            OTGHS2ClockSelection: ?OTGHS2ClockSelectionList = null,
            XSPI3ClockSelection: ?XSPI3ClockSelectionList = null,
            OTGPHY1ClockSelection: ?OTGPHY1ClockSelectionList = null,
            OTGPHY2ClockSelection: ?OTGPHY2ClockSelectionList = null,
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null,
            SDMMC2ClockSelection: ?SDMMC2ClockSelectionList = null,
            ETH1ClockSelection: ?ETH1ClockSelectionList = null,
            SPDIFRX1ClockSelection: ?SPDIFRX1ClockSelectionList = null,
            SYSBCLKSource: ?SYSBCLKSourceList = null,
            SYSCCLKSource: ?SYSCCLKSourceList = null,
            SYSDCLKSource: ?SYSDCLKSourceList = null,
            CPUCLKSource: ?CPUCLKSourceList = null,
            HPRE_Div: ?HPRE_DivList = null,
            TIMGDIV: ?TIMGDIVList = null,
            PLL1Source: ?PLL1SourceList = null,
            FREFDIV1: ?u32 = null,
            PLL2Source: ?PLL2SourceList = null,
            FREFDIV2: ?u32 = null,
            PLL3Source: ?PLL3SourceList = null,
            FREFDIV3: ?u32 = null,
            PLL4Source: ?PLL4SourceList = null,
            FREFDIV4: ?u32 = null,
            FBDIV1: ?u32 = null,
            PLL1FRACV: ?u32 = null,
            POSTDIV1_1: ?u32 = null,
            POSTDIV2_1: ?u32 = null,
            FBDIV2: ?u32 = null,
            PLL2FRACV: ?u32 = null,
            POSTDIV1_2: ?u32 = null,
            POSTDIV2_2: ?u32 = null,
            FBDIV3: ?u32 = null,
            PLL3FRACV: ?u32 = null,
            POSTDIV1_3: ?u32 = null,
            POSTDIV2_3: ?u32 = null,
            FBDIV4: ?u32 = null,
            PLL4FRACV: ?u32 = null,
            POSTDIV1_4: ?u32 = null,
            POSTDIV2_4: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSIDiv: f32 = 0,
            HSIDivOutput: f32 = 0,
            HSIDiv4: f32 = 0,
            UCPDOutput: f32 = 0,
            HSEOSC: f32 = 0,
            HSEOSCDIV: f32 = 0,
            HSEDIV: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            MSIRC: f32 = 0,
            I2S_CKIN: f32 = 0,
            IC1: f32 = 0,
            IC1Div: f32 = 0,
            IC1Output: f32 = 0,
            IC2: f32 = 0,
            IC2Div: f32 = 0,
            IC2Output: f32 = 0,
            IC3: f32 = 0,
            IC3Div: f32 = 0,
            IC3Output: f32 = 0,
            IC4: f32 = 0,
            IC4Div: f32 = 0,
            IC4Output: f32 = 0,
            IC5: f32 = 0,
            IC5Div: f32 = 0,
            IC5Output: f32 = 0,
            IC6: f32 = 0,
            IC6Div: f32 = 0,
            IC6Output: f32 = 0,
            IC7: f32 = 0,
            IC7Div: f32 = 0,
            IC7Output: f32 = 0,
            IC8: f32 = 0,
            IC8Div: f32 = 0,
            IC8Output: f32 = 0,
            IC9: f32 = 0,
            IC9Div: f32 = 0,
            IC9Output: f32 = 0,
            IC10: f32 = 0,
            IC10Div: f32 = 0,
            IC10Output: f32 = 0,
            IC11: f32 = 0,
            IC11Div: f32 = 0,
            IC11Output: f32 = 0,
            IC12: f32 = 0,
            IC12Div: f32 = 0,
            IC12Output: f32 = 0,
            IC13: f32 = 0,
            IC13Div: f32 = 0,
            IC13Output: f32 = 0,
            IC14: f32 = 0,
            IC14Div: f32 = 0,
            IC14Output: f32 = 0,
            IC15: f32 = 0,
            IC15Div: f32 = 0,
            IC15Output: f32 = 0,
            IC16: f32 = 0,
            IC16Div: f32 = 0,
            IC16Output: f32 = 0,
            IC17: f32 = 0,
            IC17Div: f32 = 0,
            IC17Output: f32 = 0,
            IC18: f32 = 0,
            IC18Div: f32 = 0,
            IC18Output: f32 = 0,
            IC19: f32 = 0,
            IC19Div: f32 = 0,
            IC19Output: f32 = 0,
            IC20: f32 = 0,
            IC20Div: f32 = 0,
            IC20Output: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            CKPERSource: f32 = 0,
            CKPERoutput: f32 = 0,
            ADCMult: f32 = 0,
            ADCDIV: f32 = 0,
            ADCoutput: f32 = 0,
            ADFMult: f32 = 0,
            ADFoutput: f32 = 0,
            MDF1Mult: f32 = 0,
            MDFoutput: f32 = 0,
            PSSIMult: f32 = 0,
            PSSIoutput: f32 = 0,
            FDCANMult: f32 = 0,
            FDCANoutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            I2C4Mult: f32 = 0,
            I2C4output: f32 = 0,
            I3C1Mult: f32 = 0,
            I3C1output: f32 = 0,
            I3C2Mult: f32 = 0,
            I3C2output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM3Mult: f32 = 0,
            LPTIM3output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            LPTIM4Mult: f32 = 0,
            LPTIM4output: f32 = 0,
            LPTIM5Mult: f32 = 0,
            LPTIM5output: f32 = 0,
            LTDCMult: f32 = 0,
            LTDCoutput: f32 = 0,
            DCMIPPMult: f32 = 0,
            DCMIPPoutput: f32 = 0,
            FMCMult: f32 = 0,
            FMCoutput: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            SAI2Mult: f32 = 0,
            SAI2output: f32 = 0,
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
            UART8Mult: f32 = 0,
            UART8output: f32 = 0,
            UART9Mult: f32 = 0,
            UART9output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            USART10Mult: f32 = 0,
            USART10output: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI2Mult: f32 = 0,
            SPI2output: f32 = 0,
            SPI3Mult: f32 = 0,
            SPI3output: f32 = 0,
            SPI4Mult: f32 = 0,
            SPI4output: f32 = 0,
            SPI5Mult: f32 = 0,
            SPI5output: f32 = 0,
            SPI6Mult: f32 = 0,
            SPI6output: f32 = 0,
            XSPI1Mult: f32 = 0,
            XSPI1output: f32 = 0,
            XSPI2Mult: f32 = 0,
            XSPI2output: f32 = 0,
            OTGHS1Mult: f32 = 0,
            OTGHS1output: f32 = 0,
            OTGHS2Mult: f32 = 0,
            OTGHS2output: f32 = 0,
            XSPI3Mult: f32 = 0,
            XSPI3output: f32 = 0,
            OTGPHY1Mult: f32 = 0,
            OTGPHY1output: f32 = 0,
            OTGPHY2Mult: f32 = 0,
            OTGPHY2output: f32 = 0,
            SDMMC1Mult: f32 = 0,
            SDMMC1output: f32 = 0,
            SDMMC2Mult: f32 = 0,
            SDMMC2output: f32 = 0,
            ETH1Mult: f32 = 0,
            ETH1output: f32 = 0,
            SPDIFRX1Mult: f32 = 0,
            SPDIFRX1output: f32 = 0,
            SYSBClkSource: f32 = 0,
            SYSCClkSource: f32 = 0,
            SYSDClkSource: f32 = 0,
            SYSBCLKOutput: f32 = 0,
            SYSCCLKOutput: f32 = 0,
            SYSDCLKOutput: f32 = 0,
            SYSAClkSource: f32 = 0,
            TPIUPrescaler: f32 = 0,
            TPIUOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            CpuClockOutput: f32 = 0,
            AXIClockOutput: f32 = 0,
            HPREDiv: f32 = 0,
            APB4DIV: f32 = 0,
            APB4Output: f32 = 0,
            APB5DIV: f32 = 0,
            APB5Output: f32 = 0,
            TIMGDIV: f32 = 0,
            TIMGOutput: f32 = 0,
            APB1DIV: f32 = 0,
            AHBOutput: f32 = 0,
            APB1Output: f32 = 0,
            APB2DIV: f32 = 0,
            APB2Output: f32 = 0,
            PLL1Source: f32 = 0,
            FREFDIV1: f32 = 0,
            PLL2Source: f32 = 0,
            FREFDIV2: f32 = 0,
            PLL3Source: f32 = 0,
            FREFDIV3: f32 = 0,
            PLL4Source: f32 = 0,
            FREFDIV4: f32 = 0,
            FBDIV1: f32 = 0,
            PLL1FRACV: f32 = 0,
            POSTDIV1_1: f32 = 0,
            POSTDIV2_1: f32 = 0,
            FOUTPOSTDIV1: f32 = 0,
            FBDIV2: f32 = 0,
            PLL2FRACV: f32 = 0,
            POSTDIV1_2: f32 = 0,
            POSTDIV2_2: f32 = 0,
            FOUTPOSTDIV2: f32 = 0,
            FBDIV3: f32 = 0,
            PLL3FRACV: f32 = 0,
            POSTDIV1_3: f32 = 0,
            POSTDIV2_3: f32 = 0,
            FOUTPOSTDIV3: f32 = 0,
            FBDIV4: f32 = 0,
            PLL4FRACV: f32 = 0,
            POSTDIV1_4: f32 = 0,
            POSTDIV2_4: f32 = 0,
            FOUTPOSTDIV4: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSIDiv: ?HSIDivList = null, //from RCC Clock Config
            HSIDiv4: ?HSIDiv4List = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_Div: ?HSE_DivList = null, //from RCC Clock Config
            HSE_Div2: ?HSE_Div2List = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            IC1CLKSource: ?IC1CLKSourceList = null, //from RCC Clock Config
            IC1Div: ?f32 = null, //from RCC Clock Config
            IC2CLKSource: ?IC2CLKSourceList = null, //from RCC Clock Config
            IC2Div: ?f32 = null, //from RCC Clock Config
            IC3CLKSource: ?IC3CLKSourceList = null, //from RCC Clock Config
            IC3Div: ?f32 = null, //from RCC Clock Config
            IC4CLKSource: ?IC4CLKSourceList = null, //from RCC Clock Config
            IC4Div: ?f32 = null, //from RCC Clock Config
            IC5CLKSource: ?IC5CLKSourceList = null, //from RCC Clock Config
            IC5Div: ?f32 = null, //from RCC Clock Config
            IC6CLKSource: ?IC6CLKSourceList = null, //from RCC Clock Config
            IC6Div: ?f32 = null, //from RCC Clock Config
            IC7CLKSource: ?IC7CLKSourceList = null, //from RCC Clock Config
            IC7Div: ?f32 = null, //from RCC Clock Config
            IC8CLKSource: ?IC8CLKSourceList = null, //from RCC Clock Config
            IC8Div: ?f32 = null, //from RCC Clock Config
            IC9CLKSource: ?IC9CLKSourceList = null, //from RCC Clock Config
            IC9Div: ?f32 = null, //from RCC Clock Config
            IC10CLKSource: ?IC10CLKSourceList = null, //from RCC Clock Config
            IC10Div: ?f32 = null, //from RCC Clock Config
            IC11CLKSource: ?IC11CLKSourceList = null, //from RCC Clock Config
            IC11Div: ?f32 = null, //from RCC Clock Config
            IC12CLKSource: ?IC12CLKSourceList = null, //from RCC Clock Config
            IC12Div: ?f32 = null, //from RCC Clock Config
            IC13CLKSource: ?IC13CLKSourceList = null, //from RCC Clock Config
            IC13Div: ?f32 = null, //from RCC Clock Config
            IC14CLKSource: ?IC14CLKSourceList = null, //from RCC Clock Config
            IC14Div: ?f32 = null, //from RCC Clock Config
            IC15CLKSource: ?IC15CLKSourceList = null, //from RCC Clock Config
            IC15Div: ?f32 = null, //from RCC Clock Config
            IC16CLKSource: ?IC16CLKSourceList = null, //from RCC Clock Config
            IC16Div: ?f32 = null, //from RCC Clock Config
            IC17CLKSource: ?IC17CLKSourceList = null, //from RCC Clock Config
            IC17Div: ?f32 = null, //from RCC Clock Config
            IC18CLKSource: ?IC18CLKSourceList = null, //from RCC Clock Config
            IC18Div: ?f32 = null, //from RCC Clock Config
            IC19CLKSource: ?IC19CLKSourceList = null, //from RCC Clock Config
            IC19Div: ?f32 = null, //from RCC Clock Config
            IC20CLKSource: ?IC20CLKSourceList = null, //from RCC Clock Config
            IC20Div: ?f32 = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            CKPERSourceSelection: ?CKPERSourceSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            ADCDIV: ?f32 = null, //from RCC Clock Config
            ADF1ClockSelection: ?ADF1ClockSelectionList = null, //from RCC Clock Config
            MDF1ClockSelection: ?MDF1ClockSelectionList = null, //from RCC Clock Config
            PSSIClockSelection: ?PSSIClockSelectionList = null, //from RCC Clock Config
            FDCANClockSelection: ?FDCANClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C2CLockSelection: ?I2C2CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            I2C4CLockSelection: ?I2C4CLockSelectionList = null, //from RCC Clock Config
            I3C1CLockSelection: ?I3C1CLockSelectionList = null, //from RCC Clock Config
            I3C2CLockSelection: ?I3C2CLockSelectionList = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            LPTIM3CLockSelection: ?LPTIM3CLockSelectionList = null, //from RCC Clock Config
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from RCC Clock Config
            LPTIM4CLockSelection: ?LPTIM4CLockSelectionList = null, //from RCC Clock Config
            LPTIM5CLockSelection: ?LPTIM5CLockSelectionList = null, //from RCC Clock Config
            LTDCClockSelection: ?LTDCClockSelectionList = null, //from RCC Clock Config
            DCMIPPClockSelection: ?DCMIPPClockSelectionList = null, //from RCC Clock Config
            FMCClockSelection: ?FMCClockSelectionList = null, //from RCC Clock Config
            SAI1ClockSelection: ?SAI1ClockSelectionList = null, //from RCC Clock Config
            SAI2ClockSelection: ?SAI2ClockSelectionList = null, //from RCC Clock Config
            USART1ClockSelection: ?USART1ClockSelectionList = null, //from RCC Clock Config
            USART2ClockSelection: ?USART2ClockSelectionList = null, //from RCC Clock Config
            USART3ClockSelection: ?USART3ClockSelectionList = null, //from RCC Clock Config
            UART4ClockSelection: ?UART4ClockSelectionList = null, //from RCC Clock Config
            UART5ClockSelection: ?UART5ClockSelectionList = null, //from RCC Clock Config
            USART6ClockSelection: ?USART6ClockSelectionList = null, //from RCC Clock Config
            UART7ClockSelection: ?UART7ClockSelectionList = null, //from RCC Clock Config
            UART8ClockSelection: ?UART8ClockSelectionList = null, //from RCC Clock Config
            UART9ClockSelection: ?UART9ClockSelectionList = null, //from RCC Clock Config
            LPUART1ClockSelection: ?LPUART1ClockSelectionList = null, //from RCC Clock Config
            USART10ClockSelection: ?USART10ClockSelectionList = null, //from RCC Clock Config
            SPI1ClockSelection: ?SPI1ClockSelectionList = null, //from RCC Clock Config
            SPI2ClockSelection: ?SPI2ClockSelectionList = null, //from RCC Clock Config
            SPI3ClockSelection: ?SPI3ClockSelectionList = null, //from RCC Clock Config
            SPI4ClockSelection: ?SPI4ClockSelectionList = null, //from RCC Clock Config
            SPI5ClockSelection: ?SPI5ClockSelectionList = null, //from RCC Clock Config
            SPI6ClockSelection: ?SPI6ClockSelectionList = null, //from RCC Clock Config
            XSPI1ClockSelection: ?XSPI1ClockSelectionList = null, //from RCC Clock Config
            XSPI2ClockSelection: ?XSPI2ClockSelectionList = null, //from RCC Clock Config
            OTGHS1ClockSelection: ?OTGHS1ClockSelectionList = null, //from RCC Clock Config
            OTGHS2ClockSelection: ?OTGHS2ClockSelectionList = null, //from RCC Clock Config
            XSPI3ClockSelection: ?XSPI3ClockSelectionList = null, //from RCC Clock Config
            OTGPHY1ClockSelection: ?OTGPHY1ClockSelectionList = null, //from RCC Clock Config
            OTGPHY2ClockSelection: ?OTGPHY2ClockSelectionList = null, //from RCC Clock Config
            SDMMC1ClockSelection: ?SDMMC1ClockSelectionList = null, //from RCC Clock Config
            SDMMC2ClockSelection: ?SDMMC2ClockSelectionList = null, //from RCC Clock Config
            ETH1ClockSelection: ?ETH1ClockSelectionList = null, //from RCC Clock Config
            SPDIFRX1ClockSelection: ?SPDIFRX1ClockSelectionList = null, //from RCC Clock Config
            SYSBCLKSource: ?SYSBCLKSourceList = null, //from RCC Clock Config
            SYSCCLKSource: ?SYSCCLKSourceList = null, //from extra RCC references
            SYSDCLKSource: ?SYSDCLKSourceList = null, //from extra RCC references
            CPUCLKSource: ?CPUCLKSourceList = null, //from RCC Clock Config
            TPIUPrescaler: ?TPIUPrescalerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            HPRE_Div: ?HPRE_DivList = null, //from RCC Clock Config
            APB4DIV: ?APB4DIVList = null, //from RCC Clock Config
            APB5DIV: ?APB5DIVList = null, //from RCC Clock Config
            TIMGDIV: ?TIMGDIVList = null, //from RCC Clock Config
            APB1DIV: ?APB1DIVList = null, //from RCC Clock Config
            APB2DIV: ?APB2DIVList = null, //from RCC Clock Config
            PLL1Source: ?PLL1SourceList = null, //from RCC Clock Config
            FREFDIV1: ?f32 = null, //from RCC Clock Config
            PLL2Source: ?PLL2SourceList = null, //from RCC Clock Config
            FREFDIV2: ?f32 = null, //from RCC Clock Config
            PLL3Source: ?PLL3SourceList = null, //from RCC Clock Config
            FREFDIV3: ?f32 = null, //from RCC Clock Config
            PLL4Source: ?PLL4SourceList = null, //from RCC Clock Config
            FREFDIV4: ?f32 = null, //from RCC Clock Config
            FBDIV1: ?f32 = null, //from RCC Clock Config
            PLL1FRACV: ?f32 = null, //from RCC Clock Config
            POSTDIV1_1: ?f32 = null, //from RCC Clock Config
            POSTDIV2_1: ?f32 = null, //from RCC Clock Config
            FBDIV2: ?f32 = null, //from RCC Clock Config
            PLL2FRACV: ?f32 = null, //from RCC Clock Config
            POSTDIV1_2: ?f32 = null, //from RCC Clock Config
            POSTDIV2_2: ?f32 = null, //from RCC Clock Config
            FBDIV3: ?f32 = null, //from RCC Clock Config
            PLL3FRACV: ?f32 = null, //from RCC Clock Config
            POSTDIV1_3: ?f32 = null, //from RCC Clock Config
            POSTDIV2_3: ?f32 = null, //from RCC Clock Config
            FBDIV4: ?f32 = null, //from RCC Clock Config
            PLL4FRACV: ?f32 = null, //from RCC Clock Config
            POSTDIV1_4: ?f32 = null, //from RCC Clock Config
            POSTDIV2_4: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            RCC_TIM_G1_PRescaler_Selection: ?RCC_TIM_G1_PRescaler_SelectionList = null, //from RCC Advanced Config
            RCC_TIM_G2_PRescaler_Selection: ?RCC_TIM_G2_PRescaler_SelectionList = null, //from RCC Advanced Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            PLL1MODE: ?PLL1MODEList = null, //from extra RCC references
            PLL2MODE: ?PLL2MODEList = null, //from extra RCC references
            PLL3MODE: ?PLL3MODEList = null, //from extra RCC references
            PLL4MODE: ?PLL4MODEList = null, //from extra RCC references
            PLL1CSG: ?PLL1CSGList = null, //from extra RCC references
            PLL2CSG: ?PLL2CSGList = null, //from extra RCC references
            PLL3CSG: ?PLL3CSGList = null, //from extra RCC references
            PLL4CSG: ?PLL4CSGList = null, //from extra RCC references
            EnableUCPD1: ?EnableUCPD1List = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            OTG1Enable: ?OTG1EnableList = null, //from extra RCC references
            OTG2Enable: ?OTG2EnableList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            XSPI1Enable: ?XSPI1EnableList = null, //from extra RCC references
            XSPI2Enable: ?XSPI2EnableList = null, //from extra RCC references
            XSPI3Enable: ?XSPI3EnableList = null, //from extra RCC references
            FMCEnable: ?FMCEnableList = null, //from extra RCC references
            SDMMC1Enable: ?SDMMC1EnableList = null, //from extra RCC references
            SDMMC2Enable: ?SDMMC2EnableList = null, //from extra RCC references
            CKPEREnable: ?CKPEREnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            EnableADF1: ?EnableADF1List = null, //from extra RCC references
            EnableMDF1: ?EnableMDF1List = null, //from extra RCC references
            EnableSAI1: ?EnableSAI1List = null, //from extra RCC references
            EnableSAI2: ?EnableSAI2List = null, //from extra RCC references
            EnableSPDIFRX: ?EnableSPDIFRXList = null, //from extra RCC references
            EnableSPI1: ?EnableSPI1List = null, //from extra RCC references
            EnableSPI2: ?EnableSPI2List = null, //from extra RCC references
            EnableSPI3: ?EnableSPI3List = null, //from extra RCC references
            EnableSPI6: ?EnableSPI6List = null, //from extra RCC references
            EnableSPI4: ?EnableSPI4List = null, //from extra RCC references
            EnableSPI5: ?EnableSPI5List = null, //from extra RCC references
            EnableLPUART1: ?EnableLPUART1List = null, //from extra RCC references
            EnableUSART1: ?EnableUSART1List = null, //from extra RCC references
            EnableUSART2: ?EnableUSART2List = null, //from extra RCC references
            EnableUSART3: ?EnableUSART3List = null, //from extra RCC references
            EnableUSART6: ?EnableUSART6List = null, //from extra RCC references
            EnableUSART10: ?EnableUSART10List = null, //from extra RCC references
            EnableUART4: ?EnableUART4List = null, //from extra RCC references
            EnableUART5: ?EnableUART5List = null, //from extra RCC references
            EnableUART7: ?EnableUART7List = null, //from extra RCC references
            EnableUART8: ?EnableUART8List = null, //from extra RCC references
            EnableUART9: ?EnableUART9List = null, //from extra RCC references
            EnableI2C1: ?EnableI2C1List = null, //from extra RCC references
            EnableI2C2: ?EnableI2C2List = null, //from extra RCC references
            EnableI2C3: ?EnableI2C3List = null, //from extra RCC references
            EnableI2C4: ?EnableI2C4List = null, //from extra RCC references
            EnableI3C1: ?EnableI3C1List = null, //from extra RCC references
            EnableI3C2: ?EnableI3C2List = null, //from extra RCC references
            ETH1Enable: ?ETH1EnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            EnableLPTIM1: ?EnableLPTIM1List = null, //from extra RCC references
            EnableLPTIM2: ?EnableLPTIM2List = null, //from extra RCC references
            EnableLPTIM3: ?EnableLPTIM3List = null, //from extra RCC references
            EnableLPTIM4: ?EnableLPTIM4List = null, //from extra RCC references
            EnableLPTIM5: ?EnableLPTIM5List = null, //from extra RCC references
            EnableLTDC: ?EnableLTDCList = null, //from extra RCC references
            EnableDCMI: ?EnableDCMIList = null, //from extra RCC references
            EnableCSI: ?EnableCSIList = null, //from extra RCC references
            EnableFDCAN123: ?EnableFDCAN123List = null, //from extra RCC references
            PSSIEnable: ?PSSIEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            PLL1Used: ?f32 = null, //from extra RCC references
            PLL2Used: ?f32 = null, //from extra RCC references
            PLL3Used: ?f32 = null, //from extra RCC references
            PLL4Used: ?f32 = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            IC1Used: ?f32 = null, //from extra RCC references
            IC2Used: ?f32 = null, //from extra RCC references
            IC3Used: ?f32 = null, //from extra RCC references
            IC4Used: ?f32 = null, //from extra RCC references
            IC5Used: ?f32 = null, //from extra RCC references
            IC6Used: ?f32 = null, //from extra RCC references
            IC7Used: ?f32 = null, //from extra RCC references
            IC8Used: ?f32 = null, //from extra RCC references
            IC9Used: ?f32 = null, //from extra RCC references
            IC10Used: ?f32 = null, //from extra RCC references
            IC11Used: ?f32 = null, //from extra RCC references
            IC12Used: ?f32 = null, //from extra RCC references
            IC14Used: ?f32 = null, //from extra RCC references
            IC15Used: ?f32 = null, //from extra RCC references
            IC16Used: ?f32 = null, //from extra RCC references
            IC17Used: ?f32 = null, //from extra RCC references
            IC18Used: ?f32 = null, //from extra RCC references
            IC19Used: ?f32 = null, //from extra RCC references
            IC20Used: ?f32 = null, //from extra RCC references
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

            var HSIDiv1: bool = false;
            var IC1_PLL1: bool = false;
            var IC1_PLL2: bool = false;
            var IC1_PLL3: bool = false;
            var IC1_PLL4: bool = false;
            var IC2_PLL1: bool = false;
            var IC2_PLL2: bool = false;
            var IC2_PLL3: bool = false;
            var IC2_PLL4: bool = false;
            var IC3_PLL1: bool = false;
            var IC3_PLL2: bool = false;
            var IC3_PLL3: bool = false;
            var IC3_PLL4: bool = false;
            var IC4_PLL1: bool = false;
            var IC4_PLL2: bool = false;
            var IC4_PLL3: bool = false;
            var IC4_PLL4: bool = false;
            var IC5_PLL1: bool = false;
            var IC5_PLL2: bool = false;
            var IC5_PLL3: bool = false;
            var IC5_PLL4: bool = false;
            var IC6_PLL1: bool = false;
            var IC6_PLL2: bool = false;
            var IC6_PLL3: bool = false;
            var IC6_PLL4: bool = false;
            var IC7_PLL1: bool = false;
            var IC7_PLL2: bool = false;
            var IC7_PLL3: bool = false;
            var IC7_PLL4: bool = false;
            var IC8_PLL1: bool = false;
            var IC8_PLL2: bool = false;
            var IC8_PLL3: bool = false;
            var IC8_PLL4: bool = false;
            var IC9_PLL1: bool = false;
            var IC9_PLL2: bool = false;
            var IC9_PLL3: bool = false;
            var IC9_PLL4: bool = false;
            var IC10_PLL1: bool = false;
            var IC10_PLL2: bool = false;
            var IC10_PLL3: bool = false;
            var IC10_PLL4: bool = false;
            var IC11_PLL1: bool = false;
            var IC11_PLL2: bool = false;
            var IC11_PLL3: bool = false;
            var IC11_PLL4: bool = false;
            var IC12_PLL1: bool = false;
            var IC12_PLL2: bool = false;
            var IC12_PLL3: bool = false;
            var IC12_PLL4: bool = false;
            var IC13_PLL1: bool = false;
            var IC13_PLL2: bool = false;
            var IC13_PLL3: bool = false;
            var IC13_PLL4: bool = false;
            var IC14_PLL1: bool = false;
            var IC14_PLL2: bool = false;
            var IC14_PLL3: bool = false;
            var IC14_PLL4: bool = false;
            var IC15_PLL1: bool = false;
            var IC15_PLL2: bool = false;
            var IC15_PLL3: bool = false;
            var IC15_PLL4: bool = false;
            var IC16_PLL1: bool = false;
            var IC16_PLL2: bool = false;
            var IC16_PLL3: bool = false;
            var IC16_PLL4: bool = false;
            var IC17_PLL1: bool = false;
            var IC17_PLL2: bool = false;
            var IC17_PLL3: bool = false;
            var IC17_PLL4: bool = false;
            var IC18_PLL1: bool = false;
            var IC18_PLL2: bool = false;
            var IC18_PLL3: bool = false;
            var IC18_PLL4: bool = false;
            var IC19_PLL1: bool = false;
            var IC19_PLL2: bool = false;
            var IC19_PLL3: bool = false;
            var IC19_PLL4: bool = false;
            var IC20_PLL1: bool = false;
            var IC20_PLL2: bool = false;
            var IC20_PLL3: bool = false;
            var IC20_PLL4: bool = false;
            var MCO1SOURCE_HSI: bool = false;
            var MCO1SOURCE_LSE: bool = false;
            var MCO1SOURCE_MSI: bool = false;
            var MCO1SOURCE_LSI: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var MCO1SOURCE_IC5: bool = false;
            var MCO1SOURCE_IC10: bool = false;
            var MCO2SOURCE_HSI: bool = false;
            var MCO2SOURCE_LSE: bool = false;
            var MCO2SOURCE_MSI: bool = false;
            var MCO2SOURCE_LSI: bool = false;
            var MCO2SOURCE_HSE: bool = false;
            var MCO2SOURCE_IC15: bool = false;
            var MCO2SOURCE_IC20: bool = false;
            var CLKPCLKSOURCE_HSI: bool = false;
            var CLKPCLKSOURCE_MSI: bool = false;
            var CLKPCLKSOURCE_HSE: bool = false;
            var CLKPCLKSOURCE_IC5: bool = false;
            var CLKPCLKSOURCE_IC10: bool = false;
            var CLKPCLKSOURCE_IC15: bool = false;
            var CLKPCLKSOURCE_IC19: bool = false;
            var CLKPCLKSOURCE_IC20: bool = false;
            var ADCCLKSOURCE_IC7: bool = false;
            var ADCCLKSOURCE_IC8: bool = false;
            var ADCCLKSOURCE_MSI: bool = false;
            var ADCCLKSOURCE_HSI: bool = false;
            var ADF1CLKSOURCE_IC7: bool = false;
            var ADF1CLKSOURCE_IC8: bool = false;
            var ADF1CLKSOURCE_MSI: bool = false;
            var ADF1CLKSOURCE_HSI: bool = false;
            var MDF1CLKSOURCE_IC7: bool = false;
            var MDF1CLKSOURCE_IC8: bool = false;
            var MDF1CLKSOURCE_MSI: bool = false;
            var MDF1CLKSOURCE_HSI: bool = false;
            var PSSICLKSOURCE_IC20: bool = false;
            var PSSICLKSOURCE_HSI: bool = false;
            var FDCANCLKSOURCE_IC19: bool = false;
            var FDCANCLKSOURCE_HSE: bool = false;
            var I2C1CLKSOURCE_IC10: bool = false;
            var I2C1CLKSOURCE_IC15: bool = false;
            var I2C1CLKSOURCE_MSI: bool = false;
            var I2C1CLKSOURCE_HSI: bool = false;
            var I2C2CLKSOURCE_IC10: bool = false;
            var I2C2CLKSOURCE_IC15: bool = false;
            var I2C2CLKSOURCE_MSI: bool = false;
            var I2C2CLKSOURCE_HSI: bool = false;
            var I2C3CLKSOURCE_IC10: bool = false;
            var I2C3CLKSOURCE_IC15: bool = false;
            var I2C3CLKSOURCE_MSI: bool = false;
            var I2C3CLKSOURCE_HSI: bool = false;
            var I2C4CLKSOURCE_IC10: bool = false;
            var I2C4CLKSOURCE_IC15: bool = false;
            var I2C4CLKSOURCE_MSI: bool = false;
            var I2C4CLKSOURCE_HSI: bool = false;
            var I3C1CLKSOURCE_IC10: bool = false;
            var I3C1CLKSOURCE_IC15: bool = false;
            var I3C1CLKSOURCE_MSI: bool = false;
            var I3C1CLKSOURCE_HSI: bool = false;
            var I3C2CLKSOURCE_IC10: bool = false;
            var I3C2CLKSOURCE_IC15: bool = false;
            var I3C2CLKSOURCE_MSI: bool = false;
            var I3C2CLKSOURCE_HSI: bool = false;
            var LPTIM1CLKSOURCE_IC15: bool = false;
            var LPTIM1CLKSOURCE_LSE: bool = false;
            var LPTIM1CLKSOURCE_LSI: bool = false;
            var LPTIM3CLKSOURCE_IC15: bool = false;
            var LPTIM3CLKSOURCE_LSE: bool = false;
            var LPTIM3CLKSOURCE_LSI: bool = false;
            var LPTIM2CLKSOURCE_IC15: bool = false;
            var LPTIM2CLKSOURCE_LSE: bool = false;
            var LPTIM2CLKSOURCE_LSI: bool = false;
            var LPTIM4CLKSOURCE_IC15: bool = false;
            var LPTIM4CLKSOURCE_LSE: bool = false;
            var LPTIM4CLKSOURCE_LSI: bool = false;
            var LPTIM5CLKSOURCE_IC15: bool = false;
            var LPTIM5CLKSOURCE_LSE: bool = false;
            var LPTIM5CLKSOURCE_LSI: bool = false;
            var LTDCCLKSOURCE_IC16: bool = false;
            var LTDCCLKSOURCE_HSI: bool = false;
            var DCMIPPCLKSOURCE_IC17: bool = false;
            var DCMIPPCLKSOURCE_HSI: bool = false;
            var FMCCLKSOURCE_IC3: bool = false;
            var FMCCLKSOURCE_IC4: bool = false;
            var SAI1CLKSOURCE_IC7: bool = false;
            var SAI1CLKSOURCE_IC8: bool = false;
            var SAI1CLKSOURCE_MSI: bool = false;
            var SAI1CLKSOURCE_HSI: bool = false;
            var SAI2CLKSOURCE_IC7: bool = false;
            var SAI2CLKSOURCE_IC8: bool = false;
            var SAI2CLKSOURCE_MSI: bool = false;
            var SAI2CLKSOURCE_HSI: bool = false;
            var USART1CLKSOURCE_IC9: bool = false;
            var USART1CLKSOURCE_IC14: bool = false;
            var USART1CLKSOURCE_LSE: bool = false;
            var USART1CLKSOURCE_MSI: bool = false;
            var USART1CLKSOURCE_HSI: bool = false;
            var USART2CLKSOURCE_IC9: bool = false;
            var USART2CLKSOURCE_IC14: bool = false;
            var USART2CLKSOURCE_LSE: bool = false;
            var USART2CLKSOURCE_MSI: bool = false;
            var USART2CLKSOURCE_HSI: bool = false;
            var USART3CLKSOURCE_IC9: bool = false;
            var USART3CLKSOURCE_IC14: bool = false;
            var USART3CLKSOURCE_LSE: bool = false;
            var USART3CLKSOURCE_MSI: bool = false;
            var USART3CLKSOURCE_HSI: bool = false;
            var UART4CLKSOURCE_IC9: bool = false;
            var UART4CLKSOURCE_IC14: bool = false;
            var UART4CLKSOURCE_LSE: bool = false;
            var UART4CLKSOURCE_MSI: bool = false;
            var UART4CLKSOURCE_HSI: bool = false;
            var UART5CLKSOURCE_IC9: bool = false;
            var UART5CLKSOURCE_IC14: bool = false;
            var UART5CLKSOURCE_LSE: bool = false;
            var UART5CLKSOURCE_MSI: bool = false;
            var UART5CLKSOURCE_HSI: bool = false;
            var USART6CLKSOURCE_IC9: bool = false;
            var USART6CLKSOURCE_IC14: bool = false;
            var USART6CLKSOURCE_LSE: bool = false;
            var USART6CLKSOURCE_MSI: bool = false;
            var USART6CLKSOURCE_HSI: bool = false;
            var UART7CLKSOURCE_IC9: bool = false;
            var UART7CLKSOURCE_IC14: bool = false;
            var UART7CLKSOURCE_LSE: bool = false;
            var UART7CLKSOURCE_MSI: bool = false;
            var UART7CLKSOURCE_HSI: bool = false;
            var UART8CLKSOURCE_IC9: bool = false;
            var UART8CLKSOURCE_IC14: bool = false;
            var UART8CLKSOURCE_LSE: bool = false;
            var UART8CLKSOURCE_MSI: bool = false;
            var UART8CLKSOURCE_HSI: bool = false;
            var UART9CLKSOURCE_IC9: bool = false;
            var UART9CLKSOURCE_IC14: bool = false;
            var UART9CLKSOURCE_LSE: bool = false;
            var UART9CLKSOURCE_MSI: bool = false;
            var UART9CLKSOURCE_HSI: bool = false;
            var LPUART1CLKSOURCE_IC9: bool = false;
            var LPUART1CLKSOURCE_IC14: bool = false;
            var LPUART1CLKSOURCE_LSE: bool = false;
            var LPUART1CLKSOURCE_MSI: bool = false;
            var LPUART1CLKSOURCE_HSI: bool = false;
            var USART10CLKSOURCE_IC9: bool = false;
            var USART10CLKSOURCE_IC14: bool = false;
            var USART10CLKSOURCE_LSE: bool = false;
            var USART10CLKSOURCE_MSI: bool = false;
            var USART10CLKSOURCE_HSI: bool = false;
            var SPI1CLKSOURCE_IC8: bool = false;
            var SPI1CLKSOURCE_IC9: bool = false;
            var SPI1CLKSOURCE_MSI: bool = false;
            var SPI1CLKSOURCE_HSI: bool = false;
            var SPI2CLKSOURCE_IC8: bool = false;
            var SPI2CLKSOURCE_IC9: bool = false;
            var SPI2CLKSOURCE_MSI: bool = false;
            var SPI2CLKSOURCE_HSI: bool = false;
            var SPI3CLKSOURCE_IC8: bool = false;
            var SPI3CLKSOURCE_IC9: bool = false;
            var SPI3CLKSOURCE_MSI: bool = false;
            var SPI3CLKSOURCE_HSI: bool = false;
            var SPI4CLKSOURCE_MSI: bool = false;
            var SPI4CLKSOURCE_HSI: bool = false;
            var SPI4CLKSOURCE_HSE: bool = false;
            var SPI5CLKSOURCE_IC9: bool = false;
            var SPI5CLKSOURCE_IC14: bool = false;
            var SPI5CLKSOURCE_MSI: bool = false;
            var SPI5CLKSOURCE_HSI: bool = false;
            var SPI5CLKSOURCE_HSE: bool = false;
            var SPI6CLKSOURCE_IC8: bool = false;
            var SPI6CLKSOURCE_IC9: bool = false;
            var SPI6CLKSOURCE_MSI: bool = false;
            var SPI6CLKSOURCE_HSI: bool = false;
            var XSPI1CLKSOURCE_IC3: bool = false;
            var XSPI1CLKSOURCE_IC4: bool = false;
            var XSPI2CLKSOURCE_IC3: bool = false;
            var XSPI2CLKSOURCE_IC4: bool = false;
            var OTGHS1CLKSOURCE_PHY: bool = false;
            var OTGHS1CLKSOURCE_HSE: bool = false;
            var OTGHS2CLKSOURCE_PHY: bool = false;
            var OTGHS2CLKSOURCE_HSE: bool = false;
            var XSPI3CLKSOURCE_IC3: bool = false;
            var XSPI3CLKSOURCE_IC4: bool = false;
            var OTGPHY1CLKSOURCE_HSE_DIV2: bool = false;
            var OTGPHY1CLKSOURCE_IC15: bool = false;
            var OTGPHY1CLKSOURCE_HSE_OSC: bool = false;
            var OTGPHY2CLKSOURCE_HSE_DIV2: bool = false;
            var OTGPHY2CLKSOURCE_IC15: bool = false;
            var OTGPHY2CLKSOURCE_HSE_OSC: bool = false;
            var SDMMC1CLKSOURCE_IC4: bool = false;
            var SDMMC1CLKSOURCE_IC5: bool = false;
            var SDMMC2CLKSOURCE_IC4: bool = false;
            var SDMMC2CLKSOURCE_IC5: bool = false;
            var ETH1CLKSOURCE_IC12: bool = false;
            var ETH1CLKSOURCE_HSE: bool = false;
            var SPDIFRX1CLKSOURCE_IC7: bool = false;
            var SPDIFRX1CLKSOURCE_IC8: bool = false;
            var SPDIFRX1CLKSOURCE_MSI: bool = false;
            var SPDIFRX1CLKSOURCE_HSI: bool = false;
            var SYSBCLKSOURCE_HSI: bool = false;
            var SYSBCLKSOURCE_MSI: bool = false;
            var SYSBCLKSOURCE_HSE: bool = false;
            var SYSBCLKSOURCE_IC2_IC6_IC11: bool = false;
            var SYSCCLKSOURCE_HSI: bool = false;
            var SYSCCLKSOURCE_MSI: bool = false;
            var SYSCCLKSOURCE_HSE: bool = false;
            var SYSCCLKSOURCE_IC2_IC6_IC11: bool = false;
            var SYSDCLKSOURCE_HSI: bool = false;
            var SYSDCLKSOURCE_MSI: bool = false;
            var SYSDCLKSOURCE_HSE: bool = false;
            var SYSDCLKSOURCE_IC2_IC6_IC11: bool = false;
            var CPUCLKSOURCE_HSI: bool = false;
            var CPUCLKSOURCE_MSI: bool = false;
            var CPUCLKSOURCE_HSE: bool = false;
            var CPUCLKSOURCE_IC1: bool = false;
            var PLL1SOURCE_HSI: bool = false;
            var PLL1SOURCE_MSI: bool = false;
            var PLL1SOURCE_HSE: bool = false;
            var PLL1SOURCE_I2S: bool = false;
            var PLL2SOURCE_HSI: bool = false;
            var PLL2SOURCE_MSI: bool = false;
            var PLL2SOURCE_HSE: bool = false;
            var PLL2SOURCE_I2S: bool = false;
            var PLL3SOURCE_HSI: bool = false;
            var PLL3SOURCE_MSI: bool = false;
            var PLL3SOURCE_HSE: bool = false;
            var PLL3SOURCE_I2S: bool = false;
            var PLL4SOURCE_HSI: bool = false;
            var PLL4SOURCE_MSI: bool = false;
            var PLL4SOURCE_HSE: bool = false;
            var PLL4SOURCE_I2S: bool = false;
            var RTCCLKSOURCE_HSE_DIV: bool = false;
            var RTCCLKSOURCE_LSE: bool = false;
            var RTCCLKSOURCE_LSI: bool = false;
            var TimG1PrescalerEnabled: bool = false;
            var TimG2PrescalerEnabled: bool = false;
            var scale0: bool = false;
            var scale1: bool = false;
            var UCPDFreq_ValueLimit: Limit = .{};
            var IC1Freq_VALUELimit: Limit = .{};
            var IC2Freq_VALUELimit: Limit = .{};
            var IC3Freq_VALUELimit: Limit = .{};
            var IC4Freq_VALUELimit: Limit = .{};
            var IC5Freq_VALUELimit: Limit = .{};
            var IC6Freq_VALUELimit: Limit = .{};
            var IC7Freq_VALUELimit: Limit = .{};
            var IC8Freq_VALUELimit: Limit = .{};
            var IC9Freq_VALUELimit: Limit = .{};
            var IC10Freq_VALUELimit: Limit = .{};
            var IC11Freq_VALUELimit: Limit = .{};
            var IC12Freq_VALUELimit: Limit = .{};
            var IC13Freq_VALUELimit: Limit = .{};
            var IC14Freq_VALUELimit: Limit = .{};
            var IC15Freq_VALUELimit: Limit = .{};
            var IC16Freq_VALUELimit: Limit = .{};
            var IC17Freq_VALUELimit: Limit = .{};
            var IC18Freq_VALUELimit: Limit = .{};
            var IC19Freq_VALUELimit: Limit = .{};
            var IC20Freq_VALUELimit: Limit = .{};
            var ADC12Freq_ValueLimit: Limit = .{};
            var LPTIM1Freq_ValueLimit: Limit = .{};
            var LPTIM3Freq_ValueLimit: Limit = .{};
            var LPTIM2Freq_ValueLimit: Limit = .{};
            var LPTIM4Freq_ValueLimit: Limit = .{};
            var LPTIM5Freq_ValueLimit: Limit = .{};
            var SAI1Freq_ValueLimit: Limit = .{};
            var SAI2Freq_ValueLimit: Limit = .{};
            var USART1Freq_ValueLimit: Limit = .{};
            var USART2Freq_ValueLimit: Limit = .{};
            var USART3Freq_ValueLimit: Limit = .{};
            var UART4Freq_ValueLimit: Limit = .{};
            var UART5Freq_ValueLimit: Limit = .{};
            var USART6Freq_ValueLimit: Limit = .{};
            var UART7Freq_ValueLimit: Limit = .{};
            var UART8Freq_ValueLimit: Limit = .{};
            var UART9Freq_ValueLimit: Limit = .{};
            var LPUART1Freq_ValueLimit: Limit = .{};
            var USART10Freq_ValueLimit: Limit = .{};
            var SPI1Freq_ValueLimit: Limit = .{};
            var SPI2Freq_ValueLimit: Limit = .{};
            var SPI3Freq_ValueLimit: Limit = .{};
            var SPI4Freq_ValueLimit: Limit = .{};
            var SPI5Freq_ValueLimit: Limit = .{};
            var SPI6Freq_ValueLimit: Limit = .{};
            var OTGHS1Freq_ValueLimit: Limit = .{};
            var OTGHS2Freq_ValueLimit: Limit = .{};
            var SDMMC1Freq_ValueLimit: Limit = .{};
            var SDMMC2Freq_ValueLimit: Limit = .{};
            var SPDIFRX1Freq_ValueLimit: Limit = .{};
            var SYSBCLKFreq_VALUELimit: Limit = .{};
            var SYSCCLKFreq_VALUELimit: Limit = .{};
            var SYSDCLKFreq_VALUELimit: Limit = .{};
            var CpuClockFreq_ValueLimit: Limit = .{};
            var AXIClockFreq_ValueLimit: Limit = .{};
            var APB4Freq_ValueLimit: Limit = .{};
            var APB5Freq_ValueLimit: Limit = .{};
            var TIMGFreq_ValueLimit: Limit = .{};
            var AHB1234Freq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var FOUTPOSTDIV1Freq_ValueLimit: Limit = .{};
            var FOUTPOSTDIV2Freq_ValueLimit: Limit = .{};
            var FOUTPOSTDIV3Freq_ValueLimit: Limit = .{};
            var FOUTPOSTDIV4Freq_ValueLimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 64000000;
            };
            const HSIDivValue: ?HSIDivList = blk: {
                const conf_item = config.HSIDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSI_DIV1 => HSIDiv1 = true,
                        .RCC_HSI_DIV2 => {},
                        .RCC_HSI_DIV4 => {},
                        .RCC_HSI_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSI_DIV1;
            };
            const HSIDiv_VALUEValue: ?f32 = blk: {
                break :blk 64000000;
            };
            const HSIDiv4Value: ?HSIDiv4List = blk: {
                const item: HSIDiv4List = .@"4";
                break :blk item;
            };
            const UCPDFreq_ValueValue: ?f32 = blk: {
                UCPDFreq_ValueLimit = .{
                    .min = null,
                    .max = 2.5e7,
                };
                break :blk null;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass or config.flags.HSEOscillator or config.flags.HSEDIGByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 8e6) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                    break :blk config_val orelse 48000000;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 8e6) {
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
                            8e6,
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
                break :blk config_val orelse 48000000;
            };
            const HSE_DivValue: ?HSE_DivList = blk: {
                const conf_item = config.HSE_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"2" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const HSE_Div2Value: ?HSE_Div2List = blk: {
                const item: HSE_Div2List = .@"2";
                break :blk item;
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
            const MSIClockRangeValue: ?MSIClockRangeList = blk: {
                const conf_item = config.MSIClockRange;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSI_FREQ_16MHZ => {},
                        .RCC_MSI_FREQ_4MHZ => {},
                    }
                }

                break :blk conf_item orelse .RCC_MSI_FREQ_16MHZ;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 12288000;
            };
            const IC1CLKSourceValue: ?IC1CLKSourceList = blk: {
                const conf_item = config.IC1CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC1_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC1_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC1_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC1_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC1DivValue: ?f32 = blk: {
                const config_val = config.IC1Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC1Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC1Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 3;
            };
            const IC1Freq_VALUEValue: ?f32 = blk: {
                IC1Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC2CLKSourceValue: ?IC2CLKSourceList = blk: {
                const conf_item = config.IC2CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC2_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC2_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC2_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC2_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC2DivValue: ?f32 = blk: {
                const config_val = config.IC2Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC2Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC2Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
            };
            const IC2Freq_VALUEValue: ?f32 = blk: {
                IC2Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC3CLKSourceValue: ?IC3CLKSourceList = blk: {
                const conf_item = config.IC3CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC3_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC3_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC3_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC3_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC3DivValue: ?f32 = blk: {
                const config_val = config.IC3Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC3Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC3Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC3Freq_VALUEValue: ?f32 = blk: {
                IC3Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC4CLKSourceValue: ?IC4CLKSourceList = blk: {
                const conf_item = config.IC4CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC4_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC4_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC4_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC4_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC4DivValue: ?f32 = blk: {
                const config_val = config.IC4Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC4Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC4Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC4Freq_VALUEValue: ?f32 = blk: {
                IC4Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC5CLKSourceValue: ?IC5CLKSourceList = blk: {
                const conf_item = config.IC5CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC5_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC5_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC5_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC5_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC5DivValue: ?f32 = blk: {
                const config_val = config.IC5Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC5Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC5Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC5Freq_VALUEValue: ?f32 = blk: {
                IC5Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC6CLKSourceValue: ?IC6CLKSourceList = blk: {
                const conf_item = config.IC6CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC6_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC6_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC6_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC6_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC6DivValue: ?f32 = blk: {
                const config_val = config.IC6Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC6Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC6Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
            };
            const IC6Freq_VALUEValue: ?f32 = blk: {
                IC6Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC7CLKSourceValue: ?IC7CLKSourceList = blk: {
                const conf_item = config.IC7CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC7_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC7_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC7_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC7_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL2;
            };
            const IC7DivValue: ?f32 = blk: {
                const config_val = config.IC7Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC7Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC7Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC7Freq_VALUEValue: ?f32 = blk: {
                IC7Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC8CLKSourceValue: ?IC8CLKSourceList = blk: {
                const conf_item = config.IC8CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC8_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC8_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC8_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC8_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL2;
            };
            const IC8DivValue: ?f32 = blk: {
                const config_val = config.IC8Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC8Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC8Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC8Freq_VALUEValue: ?f32 = blk: {
                IC8Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC9CLKSourceValue: ?IC9CLKSourceList = blk: {
                const conf_item = config.IC9CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC9_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC9_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC9_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC9_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL2;
            };
            const IC9DivValue: ?f32 = blk: {
                const config_val = config.IC9Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC9Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC9Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC9Freq_VALUEValue: ?f32 = blk: {
                IC9Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC10CLKSourceValue: ?IC10CLKSourceList = blk: {
                const conf_item = config.IC10CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC10_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC10_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC10_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC10_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL2;
            };
            const IC10DivValue: ?f32 = blk: {
                const config_val = config.IC10Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC10Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC10Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC10Freq_VALUEValue: ?f32 = blk: {
                IC10Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC11CLKSourceValue: ?IC11CLKSourceList = blk: {
                const conf_item = config.IC11CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC11_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC11_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC11_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC11_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL1;
            };
            const IC11DivValue: ?f32 = blk: {
                const config_val = config.IC11Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC11Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC11Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
            };
            const IC11Freq_VALUEValue: ?f32 = blk: {
                IC11Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC12CLKSourceValue: ?IC12CLKSourceList = blk: {
                const conf_item = config.IC12CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC12_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC12_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC12_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC12_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL3;
            };
            const IC12DivValue: ?f32 = blk: {
                const config_val = config.IC12Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC12Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC12Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC12Freq_VALUEValue: ?f32 = blk: {
                IC12Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC13CLKSourceValue: ?IC13CLKSourceList = blk: {
                const conf_item = config.IC13CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC13_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC13_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC13_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC13_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL3;
            };
            const IC13DivValue: ?f32 = blk: {
                const config_val = config.IC13Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC13Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC13Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC13Freq_VALUEValue: ?f32 = blk: {
                IC13Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC14CLKSourceValue: ?IC14CLKSourceList = blk: {
                const conf_item = config.IC14CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC14_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC14_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC14_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC14_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL3;
            };
            const IC14DivValue: ?f32 = blk: {
                const config_val = config.IC14Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC14Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC14Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC14Freq_VALUEValue: ?f32 = blk: {
                IC14Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC15CLKSourceValue: ?IC15CLKSourceList = blk: {
                const conf_item = config.IC15CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC15_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC15_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC15_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC15_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL3;
            };
            const IC15DivValue: ?f32 = blk: {
                const config_val = config.IC15Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC15Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC15Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC15Freq_VALUEValue: ?f32 = blk: {
                IC15Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC16CLKSourceValue: ?IC16CLKSourceList = blk: {
                const conf_item = config.IC16CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC16_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC16_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC16_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC16_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL4;
            };
            const IC16DivValue: ?f32 = blk: {
                const config_val = config.IC16Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC16Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC16Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC16Freq_VALUEValue: ?f32 = blk: {
                IC16Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC17CLKSourceValue: ?IC17CLKSourceList = blk: {
                const conf_item = config.IC17CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC17_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC17_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC17_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC17_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL4;
            };
            const IC17DivValue: ?f32 = blk: {
                const config_val = config.IC17Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC17Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC17Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC17Freq_VALUEValue: ?f32 = blk: {
                IC17Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC18CLKSourceValue: ?IC18CLKSourceList = blk: {
                const conf_item = config.IC18CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC18_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC18_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC18_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC18_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL4;
            };
            const IC18DivValue: ?f32 = blk: {
                const config_val = config.IC18Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC18Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC18Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC18Freq_VALUEValue: ?f32 = blk: {
                IC18Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC19CLKSourceValue: ?IC19CLKSourceList = blk: {
                const conf_item = config.IC19CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC19_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC19_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC19_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC19_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL4;
            };
            const IC19DivValue: ?f32 = blk: {
                const config_val = config.IC19Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC19Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC19Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC19Freq_VALUEValue: ?f32 = blk: {
                IC19Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const IC20CLKSourceValue: ?IC20CLKSourceList = blk: {
                const conf_item = config.IC20CLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ICCLKSOURCE_PLL1 => IC20_PLL1 = true,
                        .RCC_ICCLKSOURCE_PLL2 => IC20_PLL2 = true,
                        .RCC_ICCLKSOURCE_PLL3 => IC20_PLL3 = true,
                        .RCC_ICCLKSOURCE_PLL4 => IC20_PLL4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_ICCLKSOURCE_PLL4;
            };
            const IC20DivValue: ?f32 = blk: {
                const config_val = config.IC20Div;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC20Div",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "IC20Div",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const IC20Freq_VALUEValue: ?f32 = blk: {
                IC20Freq_VALUELimit = .{
                    .min = null,
                    .max = 1.6e9,
                };
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_HSI => MCO1SOURCE_HSI = true,
                        .RCC_MCO1SOURCE_LSE => MCO1SOURCE_LSE = true,
                        .RCC_MCO1SOURCE_MSI => MCO1SOURCE_MSI = true,
                        .RCC_MCO1SOURCE_LSI => MCO1SOURCE_LSI = true,
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_IC5 => MCO1SOURCE_IC5 = true,
                        .RCC_MCO1SOURCE_IC10 => MCO1SOURCE_IC10 = true,
                        .RCC_MCO1SOURCE_SYSA => {},
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
                        .RCC_MCODIV_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_HSI => MCO2SOURCE_HSI = true,
                        .RCC_MCO2SOURCE_LSE => MCO2SOURCE_LSE = true,
                        .RCC_MCO2SOURCE_MSI => MCO2SOURCE_MSI = true,
                        .RCC_MCO2SOURCE_LSI => MCO2SOURCE_LSI = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SOURCE_HSE = true,
                        .RCC_MCO2SOURCE_IC15 => MCO2SOURCE_IC15 = true,
                        .RCC_MCO2SOURCE_IC20 => MCO2SOURCE_IC20 = true,
                        .RCC_MCO2SOURCE_SYSB => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO2SOURCE_HSI;
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
                break :blk 4000000;
            };
            const CKPERSourceSelectionValue: ?CKPERSourceSelectionList = blk: {
                const conf_item = config.CKPERSourceSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLKPCLKSOURCE_HSI => CLKPCLKSOURCE_HSI = true,
                        .RCC_CLKPCLKSOURCE_MSI => CLKPCLKSOURCE_MSI = true,
                        .RCC_CLKPCLKSOURCE_HSE => CLKPCLKSOURCE_HSE = true,
                        .RCC_CLKPCLKSOURCE_IC5 => CLKPCLKSOURCE_IC5 = true,
                        .RCC_CLKPCLKSOURCE_IC10 => CLKPCLKSOURCE_IC10 = true,
                        .RCC_CLKPCLKSOURCE_IC15 => CLKPCLKSOURCE_IC15 = true,
                        .RCC_CLKPCLKSOURCE_IC19 => CLKPCLKSOURCE_IC19 = true,
                        .RCC_CLKPCLKSOURCE_IC20 => CLKPCLKSOURCE_IC20 = true,
                    }
                }

                break :blk conf_item orelse .RCC_CLKPSOURCE_HSI;
            };
            const CKPERFreq_ValueValue: ?f32 = blk: {
                break :blk 12288000;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_HCLK => {},
                        .RCC_ADCCLKSOURCE_CLKP => {},
                        .RCC_ADCCLKSOURCE_IC7 => ADCCLKSOURCE_IC7 = true,
                        .RCC_ADCCLKSOURCE_IC8 => ADCCLKSOURCE_IC8 = true,
                        .RCC_ADCCLKSOURCE_MSI => ADCCLKSOURCE_MSI = true,
                        .RCC_ADCCLKSOURCE_HSI => ADCCLKSOURCE_HSI = true,
                        .RCC_ADCCLKSOURCE_PIN => {},
                        .RCC_ADCCLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADCCLKSOURCE_HCLK;
            };
            const ADCDIVValue: ?f32 = blk: {
                const config_val = config.ADCDIV;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "ADCDIV",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 256) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "ADCDIV",
                            "Else",
                            "No Extra Log",
                            256,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const ADC12Freq_ValueValue: ?f32 = blk: {
                ADC12Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.33e8,
                };
                break :blk null;
            };
            const ADF1ClockSelectionValue: ?ADF1ClockSelectionList = blk: {
                const conf_item = config.ADF1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADF1CLKSOURCE_HCLK => {},
                        .RCC_ADF1CLKSOURCE_CLKP => {},
                        .RCC_ADF1CLKSOURCE_IC7 => ADF1CLKSOURCE_IC7 = true,
                        .RCC_ADF1CLKSOURCE_IC8 => ADF1CLKSOURCE_IC8 = true,
                        .RCC_ADF1CLKSOURCE_MSI => ADF1CLKSOURCE_MSI = true,
                        .RCC_ADF1CLKSOURCE_HSI => ADF1CLKSOURCE_HSI = true,
                        .RCC_ADF1CLKSOURCE_PIN => {},
                        .RCC_ADF1CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADF1CLKSOURCE_HCLK;
            };
            const ADFFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const MDF1ClockSelectionValue: ?MDF1ClockSelectionList = blk: {
                const conf_item = config.MDF1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MDF1CLKSOURCE_HCLK => {},
                        .RCC_MDF1CLKSOURCE_CLKP => {},
                        .RCC_MDF1CLKSOURCE_IC7 => MDF1CLKSOURCE_IC7 = true,
                        .RCC_MDF1CLKSOURCE_IC8 => MDF1CLKSOURCE_IC8 = true,
                        .RCC_MDF1CLKSOURCE_MSI => MDF1CLKSOURCE_MSI = true,
                        .RCC_MDF1CLKSOURCE_HSI => MDF1CLKSOURCE_HSI = true,
                        .RCC_MDF1CLKSOURCE_PIN => {},
                        .RCC_MDF1CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_MDF1CLKSOURCE_HCLK;
            };
            const MDFFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const PSSIClockSelectionValue: ?PSSIClockSelectionList = blk: {
                const conf_item = config.PSSIClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PSSICLKSOURCE_HCLK => {},
                        .RCC_PSSICLKSOURCE_CLKP => {},
                        .RCC_PSSICLKSOURCE_IC20 => PSSICLKSOURCE_IC20 = true,
                        .RCC_PSSICLKSOURCE_HSI => PSSICLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_PSSICLKSOURCE_HCLK;
            };
            const PSSIFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const FDCANClockSelectionValue: ?FDCANClockSelectionList = blk: {
                const conf_item = config.FDCANClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FDCANCLKSOURCE_PCLK1 => {},
                        .RCC_FDCANCLKSOURCE_CLKP => {},
                        .RCC_FDCANCLKSOURCE_IC19 => FDCANCLKSOURCE_IC19 = true,
                        .RCC_FDCANCLKSOURCE_HSE => FDCANCLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_FDCANCLKSOURCE_PCLK1;
            };
            const FDCANFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => {},
                        .RCC_I2C1CLKSOURCE_CLKP => {},
                        .RCC_I2C1CLKSOURCE_IC10 => I2C1CLKSOURCE_IC10 = true,
                        .RCC_I2C1CLKSOURCE_IC15 => I2C1CLKSOURCE_IC15 = true,
                        .RCC_I2C1CLKSOURCE_MSI => I2C1CLKSOURCE_MSI = true,
                        .RCC_I2C1CLKSOURCE_HSI => I2C1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I2C2CLockSelectionValue: ?I2C2CLockSelectionList = blk: {
                const conf_item = config.I2C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_PCLK1 => {},
                        .RCC_I2C2CLKSOURCE_CLKP => {},
                        .RCC_I2C2CLKSOURCE_IC10 => I2C2CLKSOURCE_IC10 = true,
                        .RCC_I2C2CLKSOURCE_IC15 => I2C2CLKSOURCE_IC15 = true,
                        .RCC_I2C2CLKSOURCE_MSI => I2C2CLKSOURCE_MSI = true,
                        .RCC_I2C2CLKSOURCE_HSI => I2C2CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C2CLKSOURCE_PCLK1;
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK1 => {},
                        .RCC_I2C3CLKSOURCE_CLKP => {},
                        .RCC_I2C3CLKSOURCE_IC10 => I2C3CLKSOURCE_IC10 = true,
                        .RCC_I2C3CLKSOURCE_IC15 => I2C3CLKSOURCE_IC15 = true,
                        .RCC_I2C3CLKSOURCE_MSI => I2C3CLKSOURCE_MSI = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK1;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I2C4CLockSelectionValue: ?I2C4CLockSelectionList = blk: {
                const conf_item = config.I2C4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C4CLKSOURCE_PCLK1 => {},
                        .RCC_I2C4CLKSOURCE_CLKP => {},
                        .RCC_I2C4CLKSOURCE_IC10 => I2C4CLKSOURCE_IC10 = true,
                        .RCC_I2C4CLKSOURCE_IC15 => I2C4CLKSOURCE_IC15 = true,
                        .RCC_I2C4CLKSOURCE_MSI => I2C4CLKSOURCE_MSI = true,
                        .RCC_I2C4CLKSOURCE_HSI => I2C4CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C4CLKSOURCE_PCLK1;
            };
            const I2C4Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I3C1CLockSelectionValue: ?I3C1CLockSelectionList = blk: {
                const conf_item = config.I3C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I3C1CLKSOURCE_PCLK1 => {},
                        .RCC_I3C1CLKSOURCE_CLKP => {},
                        .RCC_I3C1CLKSOURCE_IC10 => I3C1CLKSOURCE_IC10 = true,
                        .RCC_I3C1CLKSOURCE_IC15 => I3C1CLKSOURCE_IC15 = true,
                        .RCC_I3C1CLKSOURCE_MSI => I3C1CLKSOURCE_MSI = true,
                        .RCC_I3C1CLKSOURCE_HSI => I3C1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C1CLKSOURCE_PCLK1;
            };
            const I3C1Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const I3C2CLockSelectionValue: ?I3C2CLockSelectionList = blk: {
                const conf_item = config.I3C2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I3C2CLKSOURCE_PCLK1 => {},
                        .RCC_I3C2CLKSOURCE_CLKP => {},
                        .RCC_I3C2CLKSOURCE_IC10 => I3C2CLKSOURCE_IC10 = true,
                        .RCC_I3C2CLKSOURCE_IC15 => I3C2CLKSOURCE_IC15 = true,
                        .RCC_I3C2CLKSOURCE_MSI => I3C2CLKSOURCE_MSI = true,
                        .RCC_I3C2CLKSOURCE_HSI => I3C2CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I3C2CLKSOURCE_PCLK1;
            };
            const I3C2Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM1CLKSOURCE_CLKP => {},
                        .RCC_LPTIM1CLKSOURCE_IC15 => LPTIM1CLKSOURCE_IC15 = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1CLKSOURCE_LSE = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1CLKSOURCE_LSI = true,
                        .RCC_LPTIM1CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK1;
            };
            const LPTIM1Freq_ValueValue: ?f32 = blk: {
                LPTIM1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const LPTIM3CLockSelectionValue: ?LPTIM3CLockSelectionList = blk: {
                const conf_item = config.LPTIM3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM3CLKSOURCE_PCLK4 => {},
                        .RCC_LPTIM3CLKSOURCE_CLKP => {},
                        .RCC_LPTIM3CLKSOURCE_IC15 => LPTIM3CLKSOURCE_IC15 = true,
                        .RCC_LPTIM3CLKSOURCE_LSE => LPTIM3CLKSOURCE_LSE = true,
                        .RCC_LPTIM3CLKSOURCE_LSI => LPTIM3CLKSOURCE_LSI = true,
                        .RCC_LPTIM3CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM3CLKSOURCE_PCLK4;
            };
            const LPTIM3Freq_ValueValue: ?f32 = blk: {
                LPTIM3Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK4 => {},
                        .RCC_LPTIM2CLKSOURCE_CLKP => {},
                        .RCC_LPTIM2CLKSOURCE_IC15 => LPTIM2CLKSOURCE_IC15 = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2CLKSOURCE_LSE = true,
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2CLKSOURCE_LSI = true,
                        .RCC_LPTIM2CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK4;
            };
            const LPTIM2Freq_ValueValue: ?f32 = blk: {
                LPTIM2Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const LPTIM4CLockSelectionValue: ?LPTIM4CLockSelectionList = blk: {
                const conf_item = config.LPTIM4CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM4CLKSOURCE_PCLK4 => {},
                        .RCC_LPTIM4CLKSOURCE_CLKP => {},
                        .RCC_LPTIM4CLKSOURCE_IC15 => LPTIM4CLKSOURCE_IC15 = true,
                        .RCC_LPTIM4CLKSOURCE_LSE => LPTIM4CLKSOURCE_LSE = true,
                        .RCC_LPTIM4CLKSOURCE_LSI => LPTIM4CLKSOURCE_LSI = true,
                        .RCC_LPTIM4CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM4CLKSOURCE_PCLK4;
            };
            const LPTIM4Freq_ValueValue: ?f32 = blk: {
                LPTIM4Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const LPTIM5CLockSelectionValue: ?LPTIM5CLockSelectionList = blk: {
                const conf_item = config.LPTIM5CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM5CLKSOURCE_PCLK4 => {},
                        .RCC_LPTIM5CLKSOURCE_CLKP => {},
                        .RCC_LPTIM5CLKSOURCE_IC15 => LPTIM5CLKSOURCE_IC15 = true,
                        .RCC_LPTIM5CLKSOURCE_LSE => LPTIM5CLKSOURCE_LSE = true,
                        .RCC_LPTIM5CLKSOURCE_LSI => LPTIM5CLKSOURCE_LSI = true,
                        .RCC_LPTIM5CLKSOURCE_TIMG => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM5CLKSOURCE_PCLK4;
            };
            const LPTIM5Freq_ValueValue: ?f32 = blk: {
                LPTIM5Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const LTDCClockSelectionValue: ?LTDCClockSelectionList = blk: {
                const conf_item = config.LTDCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LTDCCLKSOURCE_PCLK5 => {},
                        .RCC_LTDCCLKSOURCE_CLKP => {},
                        .RCC_LTDCCLKSOURCE_IC16 => LTDCCLKSOURCE_IC16 = true,
                        .RCC_LTDCCLKSOURCE_HSI => LTDCCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_LTDCCLKSOURCE_PCLK5;
            };
            const LTDCFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const DCMIPPClockSelectionValue: ?DCMIPPClockSelectionList = blk: {
                const conf_item = config.DCMIPPClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DCMIPPCLKSOURCE_PCLK5 => {},
                        .RCC_DCMIPPCLKSOURCE_CLKP => {},
                        .RCC_DCMIPPCLKSOURCE_IC17 => DCMIPPCLKSOURCE_IC17 = true,
                        .RCC_DCMIPPCLKSOURCE_HSI => DCMIPPCLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_DCMIPPCLKSOURCE_PCLK5;
            };
            const DCMIPPFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const FMCClockSelectionValue: ?FMCClockSelectionList = blk: {
                const conf_item = config.FMCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FMCCLKSOURCE_HCLK => {},
                        .RCC_FMCCLKSOURCE_CLKP => {},
                        .RCC_FMCCLKSOURCE_IC3 => FMCCLKSOURCE_IC3 = true,
                        .RCC_FMCCLKSOURCE_IC4 => FMCCLKSOURCE_IC4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_FMCCLKSOURCE_HCLK;
            };
            const FMCFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SAI1ClockSelectionValue: ?SAI1ClockSelectionList = blk: {
                const conf_item = config.SAI1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PCLK2 => {},
                        .RCC_SAI1CLKSOURCE_CLKP => {},
                        .RCC_SAI1CLKSOURCE_IC7 => SAI1CLKSOURCE_IC7 = true,
                        .RCC_SAI1CLKSOURCE_IC8 => SAI1CLKSOURCE_IC8 = true,
                        .RCC_SAI1CLKSOURCE_MSI => SAI1CLKSOURCE_MSI = true,
                        .RCC_SAI1CLKSOURCE_HSI => SAI1CLKSOURCE_HSI = true,
                        .RCC_SAI1CLKSOURCE_PIN => {},
                        .RCC_SAI1CLKSOURCE_SPDIFRX1 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SAI1CLKSOURCE_PCLK2;
            };
            const SAI1Freq_ValueValue: ?f32 = blk: {
                SAI1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SAI2ClockSelectionValue: ?SAI2ClockSelectionList = blk: {
                const conf_item = config.SAI2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PCLK2 => {},
                        .RCC_SAI2CLKSOURCE_CLKP => {},
                        .RCC_SAI2CLKSOURCE_IC7 => SAI2CLKSOURCE_IC7 = true,
                        .RCC_SAI2CLKSOURCE_IC8 => SAI2CLKSOURCE_IC8 = true,
                        .RCC_SAI2CLKSOURCE_MSI => SAI2CLKSOURCE_MSI = true,
                        .RCC_SAI2CLKSOURCE_HSI => SAI2CLKSOURCE_HSI = true,
                        .RCC_SAI2CLKSOURCE_PIN => {},
                        .RCC_SAI2CLKSOURCE_SPDIFRX1 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SAI2CLKSOURCE_PCLK2;
            };
            const SAI2Freq_ValueValue: ?f32 = blk: {
                SAI2Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const USART1ClockSelectionValue: ?USART1ClockSelectionList = blk: {
                const conf_item = config.USART1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => {},
                        .RCC_USART1CLKSOURCE_CLKP => {},
                        .RCC_USART1CLKSOURCE_IC9 => USART1CLKSOURCE_IC9 = true,
                        .RCC_USART1CLKSOURCE_IC14 => USART1CLKSOURCE_IC14 = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1CLKSOURCE_LSE = true,
                        .RCC_USART1CLKSOURCE_MSI => USART1CLKSOURCE_MSI = true,
                        .RCC_USART1CLKSOURCE_HSI => USART1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                USART1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const USART2ClockSelectionValue: ?USART2ClockSelectionList = blk: {
                const conf_item = config.USART2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK1 => {},
                        .RCC_USART2CLKSOURCE_CLKP => {},
                        .RCC_USART2CLKSOURCE_IC9 => USART2CLKSOURCE_IC9 = true,
                        .RCC_USART2CLKSOURCE_IC14 => USART2CLKSOURCE_IC14 = true,
                        .RCC_USART2CLKSOURCE_LSE => USART2CLKSOURCE_LSE = true,
                        .RCC_USART2CLKSOURCE_MSI => USART2CLKSOURCE_MSI = true,
                        .RCC_USART2CLKSOURCE_HSI => USART2CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART2CLKSOURCE_PCLK1;
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                USART2Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const USART3ClockSelectionValue: ?USART3ClockSelectionList = blk: {
                const conf_item = config.USART3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART3CLKSOURCE_PCLK1 => {},
                        .RCC_USART3CLKSOURCE_CLKP => {},
                        .RCC_USART3CLKSOURCE_IC9 => USART3CLKSOURCE_IC9 = true,
                        .RCC_USART3CLKSOURCE_IC14 => USART3CLKSOURCE_IC14 = true,
                        .RCC_USART3CLKSOURCE_LSE => USART3CLKSOURCE_LSE = true,
                        .RCC_USART3CLKSOURCE_MSI => USART3CLKSOURCE_MSI = true,
                        .RCC_USART3CLKSOURCE_HSI => USART3CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART3CLKSOURCE_PCLK1;
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                USART3Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const UART4ClockSelectionValue: ?UART4ClockSelectionList = blk: {
                const conf_item = config.UART4ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => {},
                        .RCC_UART4CLKSOURCE_CLKP => {},
                        .RCC_UART4CLKSOURCE_IC9 => UART4CLKSOURCE_IC9 = true,
                        .RCC_UART4CLKSOURCE_IC14 => UART4CLKSOURCE_IC14 = true,
                        .RCC_UART4CLKSOURCE_LSE => UART4CLKSOURCE_LSE = true,
                        .RCC_UART4CLKSOURCE_MSI => UART4CLKSOURCE_MSI = true,
                        .RCC_UART4CLKSOURCE_HSI => UART4CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART4CLKSOURCE_PCLK1;
            };
            const UART4Freq_ValueValue: ?f32 = blk: {
                UART4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const UART5ClockSelectionValue: ?UART5ClockSelectionList = blk: {
                const conf_item = config.UART5ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => {},
                        .RCC_UART5CLKSOURCE_CLKP => {},
                        .RCC_UART5CLKSOURCE_IC9 => UART5CLKSOURCE_IC9 = true,
                        .RCC_UART5CLKSOURCE_IC14 => UART5CLKSOURCE_IC14 = true,
                        .RCC_UART5CLKSOURCE_LSE => UART5CLKSOURCE_LSE = true,
                        .RCC_UART5CLKSOURCE_MSI => UART5CLKSOURCE_MSI = true,
                        .RCC_UART5CLKSOURCE_HSI => UART5CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
            };
            const UART5Freq_ValueValue: ?f32 = blk: {
                UART5Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const USART6ClockSelectionValue: ?USART6ClockSelectionList = blk: {
                const conf_item = config.USART6ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART6CLKSOURCE_PCLK2 => {},
                        .RCC_USART6CLKSOURCE_CLKP => {},
                        .RCC_USART6CLKSOURCE_IC9 => USART6CLKSOURCE_IC9 = true,
                        .RCC_USART6CLKSOURCE_IC14 => USART6CLKSOURCE_IC14 = true,
                        .RCC_USART6CLKSOURCE_LSE => USART6CLKSOURCE_LSE = true,
                        .RCC_USART6CLKSOURCE_MSI => USART6CLKSOURCE_MSI = true,
                        .RCC_USART6CLKSOURCE_HSI => USART6CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART6CLKSOURCE_PCLK2;
            };
            const USART6Freq_ValueValue: ?f32 = blk: {
                USART6Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const UART7ClockSelectionValue: ?UART7ClockSelectionList = blk: {
                const conf_item = config.UART7ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART7CLKSOURCE_PCLK1 => {},
                        .RCC_UART7CLKSOURCE_CLKP => {},
                        .RCC_UART7CLKSOURCE_IC9 => UART7CLKSOURCE_IC9 = true,
                        .RCC_UART7CLKSOURCE_IC14 => UART7CLKSOURCE_IC14 = true,
                        .RCC_UART7CLKSOURCE_LSE => UART7CLKSOURCE_LSE = true,
                        .RCC_UART7CLKSOURCE_MSI => UART7CLKSOURCE_MSI = true,
                        .RCC_UART7CLKSOURCE_HSI => UART7CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART7CLKSOURCE_PCLK1;
            };
            const UART7Freq_ValueValue: ?f32 = blk: {
                UART7Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const UART8ClockSelectionValue: ?UART8ClockSelectionList = blk: {
                const conf_item = config.UART8ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART8CLKSOURCE_PCLK1 => {},
                        .RCC_UART8CLKSOURCE_CLKP => {},
                        .RCC_UART8CLKSOURCE_IC9 => UART8CLKSOURCE_IC9 = true,
                        .RCC_UART8CLKSOURCE_IC14 => UART8CLKSOURCE_IC14 = true,
                        .RCC_UART8CLKSOURCE_LSE => UART8CLKSOURCE_LSE = true,
                        .RCC_UART8CLKSOURCE_MSI => UART8CLKSOURCE_MSI = true,
                        .RCC_UART8CLKSOURCE_HSI => UART8CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART8CLKSOURCE_PCLK1;
            };
            const UART8Freq_ValueValue: ?f32 = blk: {
                UART8Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const UART9ClockSelectionValue: ?UART9ClockSelectionList = blk: {
                const conf_item = config.UART9ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART9CLKSOURCE_PCLK2 => {},
                        .RCC_UART9CLKSOURCE_CLKP => {},
                        .RCC_UART9CLKSOURCE_IC9 => UART9CLKSOURCE_IC9 = true,
                        .RCC_UART9CLKSOURCE_IC14 => UART9CLKSOURCE_IC14 = true,
                        .RCC_UART9CLKSOURCE_LSE => UART9CLKSOURCE_LSE = true,
                        .RCC_UART9CLKSOURCE_MSI => UART9CLKSOURCE_MSI = true,
                        .RCC_UART9CLKSOURCE_HSI => UART9CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_UART9CLKSOURCE_PCLK2;
            };
            const UART9Freq_ValueValue: ?f32 = blk: {
                UART9Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const LPUART1ClockSelectionValue: ?LPUART1ClockSelectionList = blk: {
                const conf_item = config.LPUART1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK4 => {},
                        .RCC_LPUART1CLKSOURCE_CLKP => {},
                        .RCC_LPUART1CLKSOURCE_IC9 => LPUART1CLKSOURCE_IC9 = true,
                        .RCC_LPUART1CLKSOURCE_IC14 => LPUART1CLKSOURCE_IC14 = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1CLKSOURCE_LSE = true,
                        .RCC_LPUART1CLKSOURCE_MSI => LPUART1CLKSOURCE_MSI = true,
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK2;
            };
            const LPUART1Freq_ValueValue: ?f32 = blk: {
                LPUART1Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const USART10ClockSelectionValue: ?USART10ClockSelectionList = blk: {
                const conf_item = config.USART10ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART10CLKSOURCE_PCLK2 => {},
                        .RCC_USART10CLKSOURCE_CLKP => {},
                        .RCC_USART10CLKSOURCE_IC9 => USART10CLKSOURCE_IC9 = true,
                        .RCC_USART10CLKSOURCE_IC14 => USART10CLKSOURCE_IC14 = true,
                        .RCC_USART10CLKSOURCE_LSE => USART10CLKSOURCE_LSE = true,
                        .RCC_USART10CLKSOURCE_MSI => USART10CLKSOURCE_MSI = true,
                        .RCC_USART10CLKSOURCE_HSI => USART10CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART10CLKSOURCE_PCLK2;
            };
            const USART10Freq_ValueValue: ?f32 = blk: {
                USART10Freq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const SPI1ClockSelectionValue: ?SPI1ClockSelectionList = blk: {
                const conf_item = config.SPI1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PCLK2 => {},
                        .RCC_SPI1CLKSOURCE_CLKP => {},
                        .RCC_SPI1CLKSOURCE_IC8 => SPI1CLKSOURCE_IC8 = true,
                        .RCC_SPI1CLKSOURCE_IC9 => SPI1CLKSOURCE_IC9 = true,
                        .RCC_SPI1CLKSOURCE_MSI => SPI1CLKSOURCE_MSI = true,
                        .RCC_SPI1CLKSOURCE_HSI => SPI1CLKSOURCE_HSI = true,
                        .RCC_SPI1CLKSOURCE_PIN => {},
                    }
                }

                break :blk conf_item orelse .RCC_SPI1CLKSOURCE_PCLK2;
            };
            const SPI1Freq_ValueValue: ?f32 = blk: {
                SPI1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SPI2ClockSelectionValue: ?SPI2ClockSelectionList = blk: {
                const conf_item = config.SPI2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI2CLKSOURCE_PCLK1 => {},
                        .RCC_SPI2CLKSOURCE_CLKP => {},
                        .RCC_SPI2CLKSOURCE_IC8 => SPI2CLKSOURCE_IC8 = true,
                        .RCC_SPI2CLKSOURCE_IC9 => SPI2CLKSOURCE_IC9 = true,
                        .RCC_SPI2CLKSOURCE_MSI => SPI2CLKSOURCE_MSI = true,
                        .RCC_SPI2CLKSOURCE_HSI => SPI2CLKSOURCE_HSI = true,
                        .RCC_SPI2CLKSOURCE_PIN => {},
                    }
                }

                break :blk conf_item orelse .RCC_SPI2CLKSOURCE_PCLK1;
            };
            const SPI2Freq_ValueValue: ?f32 = blk: {
                SPI2Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SPI3ClockSelectionValue: ?SPI3ClockSelectionList = blk: {
                const conf_item = config.SPI3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3CLKSOURCE_PCLK1 => {},
                        .RCC_SPI3CLKSOURCE_CLKP => {},
                        .RCC_SPI3CLKSOURCE_IC8 => SPI3CLKSOURCE_IC8 = true,
                        .RCC_SPI3CLKSOURCE_IC9 => SPI3CLKSOURCE_IC9 = true,
                        .RCC_SPI3CLKSOURCE_MSI => SPI3CLKSOURCE_MSI = true,
                        .RCC_SPI3CLKSOURCE_HSI => SPI3CLKSOURCE_HSI = true,
                        .RCC_SPI3CLKSOURCE_PIN => {},
                    }
                }

                break :blk conf_item orelse .RCC_SPI3CLKSOURCE_PCLK1;
            };
            const SPI3Freq_ValueValue: ?f32 = blk: {
                SPI3Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SPI4ClockSelectionValue: ?SPI4ClockSelectionList = blk: {
                const conf_item = config.SPI4ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI4CLKSOURCE_PCLK2 => {},
                        .RCC_SPI4CLKSOURCE_CLKP => {},
                        .RCC_SPI4CLKSOURCE_IC9 => {},
                        .RCC_SPI4CLKSOURCE_IC14 => {},
                        .RCC_SPI4CLKSOURCE_MSI => SPI4CLKSOURCE_MSI = true,
                        .RCC_SPI4CLKSOURCE_HSI => SPI4CLKSOURCE_HSI = true,
                        .RCC_SPI4CLKSOURCE_HSE => SPI4CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI4CLKSOURCE_PCLK2;
            };
            const SPI4Freq_ValueValue: ?f32 = blk: {
                SPI4Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.33e8,
                };
                break :blk null;
            };
            const SPI5ClockSelectionValue: ?SPI5ClockSelectionList = blk: {
                const conf_item = config.SPI5ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI5CLKSOURCE_PCLK2 => {},
                        .RCC_SPI5CLKSOURCE_CLKP => {},
                        .RCC_SPI5CLKSOURCE_IC9 => SPI5CLKSOURCE_IC9 = true,
                        .RCC_SPI5CLKSOURCE_IC14 => SPI5CLKSOURCE_IC14 = true,
                        .RCC_SPI5CLKSOURCE_MSI => SPI5CLKSOURCE_MSI = true,
                        .RCC_SPI5CLKSOURCE_HSI => SPI5CLKSOURCE_HSI = true,
                        .RCC_SPI5CLKSOURCE_HSE => SPI5CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI5CLKSOURCE_PCLK2;
            };
            const SPI5Freq_ValueValue: ?f32 = blk: {
                SPI5Freq_ValueLimit = .{
                    .min = null,
                    .max = 1.33e8,
                };
                break :blk null;
            };
            const SPI6ClockSelectionValue: ?SPI6ClockSelectionList = blk: {
                const conf_item = config.SPI6ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI6CLKSOURCE_PCLK4 => {},
                        .RCC_SPI6CLKSOURCE_CLKP => {},
                        .RCC_SPI6CLKSOURCE_IC8 => SPI6CLKSOURCE_IC8 = true,
                        .RCC_SPI6CLKSOURCE_IC9 => SPI6CLKSOURCE_IC9 = true,
                        .RCC_SPI6CLKSOURCE_MSI => SPI6CLKSOURCE_MSI = true,
                        .RCC_SPI6CLKSOURCE_HSI => SPI6CLKSOURCE_HSI = true,
                        .RCC_SPI6CLKSOURCE_PIN => {},
                    }
                }

                break :blk conf_item orelse .RCC_SPI6CLKSOURCE_PCLK4;
            };
            const SPI6Freq_ValueValue: ?f32 = blk: {
                SPI6Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const XSPI1ClockSelectionValue: ?XSPI1ClockSelectionList = blk: {
                const conf_item = config.XSPI1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_XSPI1CLKSOURCE_HCLK => {},
                        .RCC_XSPI1CLKSOURCE_CLKP => {},
                        .RCC_XSPI1CLKSOURCE_IC3 => XSPI1CLKSOURCE_IC3 = true,
                        .RCC_XSPI1CLKSOURCE_IC4 => XSPI1CLKSOURCE_IC4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_XSPI1CLKSOURCE_HCLK;
            };
            const XSPI1Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const XSPI2ClockSelectionValue: ?XSPI2ClockSelectionList = blk: {
                const conf_item = config.XSPI2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_XSPI2CLKSOURCE_HCLK => {},
                        .RCC_XSPI2CLKSOURCE_CLKP => {},
                        .RCC_XSPI2CLKSOURCE_IC3 => XSPI2CLKSOURCE_IC3 = true,
                        .RCC_XSPI2CLKSOURCE_IC4 => XSPI2CLKSOURCE_IC4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_XSPI2CLKSOURCE_HCLK;
            };
            const XSPI2Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const OTGHS1ClockSelectionValue: ?OTGHS1ClockSelectionList = blk: {
                const conf_item = config.OTGHS1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBPHY1REFCLKSOURCE_OTGPHY1 => OTGHS1CLKSOURCE_PHY = true,
                        .RCC_USBPHY1REFCLKSOURCE_HSE_DIRECT => OTGHS1CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USBPHY1REFCLKSOURCE_OTGPHY1;
            };
            const OTGHS1Freq_ValueValue: ?f32 = blk: {
                OTGHS1Freq_ValueLimit = .{
                    .min = null,
                    .max = 6e7,
                };
                break :blk null;
            };
            const OTGHS2ClockSelectionValue: ?OTGHS2ClockSelectionList = blk: {
                const conf_item = config.OTGHS2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBPHY2REFCLKSOURCE_OTGPHY2 => OTGHS2CLKSOURCE_PHY = true,
                        .RCC_USBPHY2REFCLKSOURCE_HSE_DIRECT => OTGHS2CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USBPHY2REFCLKSOURCE_OTGPHY2;
            };
            const OTGHS2Freq_ValueValue: ?f32 = blk: {
                OTGHS2Freq_ValueLimit = .{
                    .min = null,
                    .max = 6e7,
                };
                break :blk null;
            };
            const XSPI3ClockSelectionValue: ?XSPI3ClockSelectionList = blk: {
                const conf_item = config.XSPI3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_XSPI3CLKSOURCE_HCLK => {},
                        .RCC_XSPI3CLKSOURCE_CLKP => {},
                        .RCC_XSPI3CLKSOURCE_IC3 => XSPI3CLKSOURCE_IC3 = true,
                        .RCC_XSPI3CLKSOURCE_IC4 => XSPI3CLKSOURCE_IC4 = true,
                    }
                }

                break :blk conf_item orelse .RCC_XSPI3CLKSOURCE_HCLK;
            };
            const XSPI3Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const OTGPHY1ClockSelectionValue: ?OTGPHY1ClockSelectionList = blk: {
                const conf_item = config.OTGPHY1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBOTGHS1CLKSOURCE_HSE_DIRECT => OTGPHY1CLKSOURCE_HSE_DIV2 = true,
                        .RCC_USBOTGHS1CLKSOURCE_CLKP => {},
                        .RCC_USBOTGHS1CLKSOURCE_IC15 => OTGPHY1CLKSOURCE_IC15 = true,
                        .RCC_USBOTGHS1CLKSOURCE_HSE_DIV2 => OTGPHY1CLKSOURCE_HSE_OSC = true,
                    }
                }

                break :blk conf_item orelse .RCC_USBOTGHS1CLKSOURCE_HSE_DIV2;
            };
            const OTGPHY1Freq_ValueValue: ?OTGPHY1Freq_ValueList = blk: {
                const conf_item = config.OTGPHY1Freq_Value;

                break :blk conf_item orelse .@"19200000";
            };
            const OTGPHY2ClockSelectionValue: ?OTGPHY2ClockSelectionList = blk: {
                const conf_item = config.OTGPHY2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBOTGHS2CLKSOURCE_HSE_DIRECT => OTGPHY2CLKSOURCE_HSE_DIV2 = true,
                        .RCC_USBOTGHS2CLKSOURCE_CLKP => {},
                        .RCC_USBOTGHS2CLKSOURCE_IC15 => OTGPHY2CLKSOURCE_IC15 = true,
                        .RCC_USBOTGHS2CLKSOURCE_HSE_DIV2 => OTGPHY2CLKSOURCE_HSE_OSC = true,
                    }
                }

                break :blk conf_item orelse .RCC_USBOTGHS2CLKSOURCE_HSE_DIV2;
            };
            const OTGPHY2Freq_ValueValue: ?OTGPHY2Freq_ValueList = blk: {
                const conf_item = config.OTGPHY2Freq_Value;

                break :blk conf_item orelse .@"19200000";
            };
            const SDMMC1ClockSelectionValue: ?SDMMC1ClockSelectionList = blk: {
                const conf_item = config.SDMMC1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC1CLKSOURCE_HCLK => {},
                        .RCC_SDMMC1CLKSOURCE_CLKP => {},
                        .RCC_SDMMC1CLKSOURCE_IC4 => SDMMC1CLKSOURCE_IC4 = true,
                        .RCC_SDMMC1CLKSOURCE_IC5 => SDMMC1CLKSOURCE_IC5 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDMMC1CLKSOURCE_HCLK;
            };
            const SDMMC1Freq_ValueValue: ?f32 = blk: {
                SDMMC1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.08e8,
                };
                break :blk null;
            };
            const SDMMC2ClockSelectionValue: ?SDMMC2ClockSelectionList = blk: {
                const conf_item = config.SDMMC2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDMMC2CLKSOURCE_HCLK => {},
                        .RCC_SDMMC2CLKSOURCE_CLKP => {},
                        .RCC_SDMMC2CLKSOURCE_IC4 => SDMMC2CLKSOURCE_IC4 = true,
                        .RCC_SDMMC2CLKSOURCE_IC5 => SDMMC2CLKSOURCE_IC5 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDMMC2CLKSOURCE_HCLK;
            };
            const SDMMC2Freq_ValueValue: ?f32 = blk: {
                SDMMC2Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.08e8,
                };
                break :blk null;
            };
            const ETH1ClockSelectionValue: ?ETH1ClockSelectionList = blk: {
                const conf_item = config.ETH1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ETH1CLKSOURCE_HCLK => {},
                        .RCC_ETH1CLKSOURCE_CLKP => {},
                        .RCC_ETH1CLKSOURCE_IC12 => ETH1CLKSOURCE_IC12 = true,
                        .RCC_ETH1CLKSOURCE_HSE => ETH1CLKSOURCE_HSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_ETH1CLKSOURCE_HCLK;
            };
            const ETH1Freq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const SPDIFRX1ClockSelectionValue: ?SPDIFRX1ClockSelectionList = blk: {
                const conf_item = config.SPDIFRX1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPDIFRX1CLKSOURCE_PCLK1 => {},
                        .RCC_SPDIFRX1CLKSOURCE_CLKP => {},
                        .RCC_SPDIFRX1CLKSOURCE_IC7 => SPDIFRX1CLKSOURCE_IC7 = true,
                        .RCC_SPDIFRX1CLKSOURCE_IC8 => SPDIFRX1CLKSOURCE_IC8 = true,
                        .RCC_SPDIFRX1CLKSOURCE_MSI => SPDIFRX1CLKSOURCE_MSI = true,
                        .RCC_SPDIFRX1CLKSOURCE_HSI => SPDIFRX1CLKSOURCE_HSI = true,
                        .RCC_SPDIFRX1CLKSOURCE_PIN => {},
                    }
                }

                break :blk conf_item orelse .RCC_SPDIFRX1CLKSOURCE_PCLK1;
            };
            const SPDIFRX1Freq_ValueValue: ?f32 = blk: {
                SPDIFRX1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const SYSBCLKSourceValue: ?SYSBCLKSourceList = blk: {
                const conf_item = config.SYSBCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SYSBCLKSOURCE_HSI = true,
                        .RCC_SYSCLKSOURCE_MSI => SYSBCLKSOURCE_MSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SYSBCLKSOURCE_HSE = true,
                        .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => SYSBCLKSOURCE_IC2_IC6_IC11 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSCCLKSourceValue: ?SYSCCLKSourceList = blk: {
                if (SYSBCLKSOURCE_HSI) {
                    const item: SYSCCLKSourceList = .RCC_SYSCLKSOURCE_HSI;
                    const conf_item = config.SYSCCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSCCLKSource", "SYSBCLKSOURCE_HSI", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_MSI) {
                    const item: SYSCCLKSourceList = .RCC_SYSCLKSOURCE_MSI;
                    const conf_item = config.SYSCCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSCCLKSource", "SYSBCLKSOURCE_MSI", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_MSI", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_HSE) {
                    const item: SYSCCLKSourceList = .RCC_SYSCLKSOURCE_HSE;
                    const conf_item = config.SYSCCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSCCLKSource", "SYSBCLKSOURCE_HSE", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_IC2_IC6_IC11) {
                    const item: SYSCCLKSourceList = .RCC_SYSCLKSOURCE_IC2_IC6_IC11;
                    const conf_item = config.SYSCCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSCCLKSource", "SYSBCLKSOURCE_IC2_IC6_IC11", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_IC2_IC6_IC11", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.SYSCCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SYSCCLKSOURCE_HSI = true,
                        .RCC_SYSCLKSOURCE_MSI => SYSCCLKSOURCE_MSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SYSCCLKSOURCE_HSE = true,
                        .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => SYSCCLKSOURCE_IC2_IC6_IC11 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSDCLKSourceValue: ?SYSDCLKSourceList = blk: {
                if (SYSBCLKSOURCE_HSI) {
                    const item: SYSDCLKSourceList = .RCC_SYSCLKSOURCE_HSI;
                    const conf_item = config.SYSDCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSDCLKSource", "SYSBCLKSOURCE_HSI", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_HSI", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_MSI) {
                    const item: SYSDCLKSourceList = .RCC_SYSCLKSOURCE_MSI;
                    const conf_item = config.SYSDCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSDCLKSource", "SYSBCLKSOURCE_MSI", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_MSI", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_HSE) {
                    const item: SYSDCLKSourceList = .RCC_SYSCLKSOURCE_HSE;
                    const conf_item = config.SYSDCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSDCLKSource", "SYSBCLKSOURCE_HSE", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                } else if (SYSBCLKSOURCE_IC2_IC6_IC11) {
                    const item: SYSDCLKSourceList = .RCC_SYSCLKSOURCE_IC2_IC6_IC11;
                    const conf_item = config.SYSDCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSDCLKSource", "SYSBCLKSOURCE_IC2_IC6_IC11", "SYSB, SYSC and SYSD must have the same clock source", "RCC_SYSCLKSOURCE_IC2_IC6_IC11", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.SYSDCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SYSDCLKSOURCE_HSI = true,
                        .RCC_SYSCLKSOURCE_MSI => SYSDCLKSOURCE_MSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SYSDCLKSOURCE_HSE = true,
                        .RCC_SYSCLKSOURCE_IC2_IC6_IC11 => SYSDCLKSOURCE_IC2_IC6_IC11 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSBCLKFreq_VALUEValue: ?f32 = blk: {
                SYSBCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const SYSCCLKFreq_VALUEValue: ?f32 = blk: {
                if (scale0) {
                    SYSCCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 1e9,
                    };
                    break :blk null;
                }
                SYSCCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 8e8,
                };
                break :blk null;
            };
            const SYSDCLKFreq_VALUEValue: ?f32 = blk: {
                if (scale0) {
                    SYSDCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 9e8,
                    };
                    break :blk null;
                }
                SYSDCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 8e8,
                };
                break :blk null;
            };
            const CPUCLKSourceValue: ?CPUCLKSourceList = blk: {
                const conf_item = config.CPUCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CPUCLKSOURCE_HSI => CPUCLKSOURCE_HSI = true,
                        .RCC_CPUCLKSOURCE_MSI => CPUCLKSOURCE_MSI = true,
                        .RCC_CPUCLKSOURCE_HSE => CPUCLKSOURCE_HSE = true,
                        .RCC_CPUCLKSOURCE_IC1 => CPUCLKSOURCE_IC1 = true,
                    }
                }

                break :blk conf_item orelse .RCC_CPUCLKSOURCE_HSI;
            };
            const TPIUPrescalerValue: ?TPIUPrescalerList = blk: {
                const item: TPIUPrescalerList = .@"8";
                break :blk item;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const Cortex_DivValue: ?Cortex_DivList = blk: {
                const item: Cortex_DivList = .@"8";
                break :blk item;
            };
            const CortexFreq_ValueValue: ?f32 = blk: {
                break :blk 96000000;
            };
            const CpuClockFreq_ValueValue: ?f32 = blk: {
                if (scale0) {
                    CpuClockFreq_ValueLimit = .{
                        .min = null,
                        .max = 8e8,
                    };
                    break :blk null;
                }
                CpuClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 6e8,
                };
                break :blk null;
            };
            const AXIClockFreq_ValueValue: ?f32 = blk: {
                AXIClockFreq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const HPRE_DivValue: ?HPRE_DivList = blk: {
                const conf_item = config.HPRE_Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => {},
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                        .RCC_HCLK_DIV32 => {},
                        .RCC_HCLK_DIV64 => {},
                        .RCC_HCLK_DIV128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HCLK_DIV2;
            };
            const APB4DIVValue: ?APB4DIVList = blk: {
                const item: APB4DIVList = .RCC_APB4_DIV1;
                break :blk item;
            };
            const APB4Freq_ValueValue: ?f32 = blk: {
                APB4Freq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const APB5DIVValue: ?APB5DIVList = blk: {
                const item: APB5DIVList = .RCC_APB5_DIV1;
                break :blk item;
            };
            const APB5Freq_ValueValue: ?f32 = blk: {
                APB5Freq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const TIMGDIVValue: ?TIMGDIVList = blk: {
                const conf_item = config.TIMGDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIMPRES_DIV1 => {},
                        .RCC_TIMPRES_DIV2 => {},
                        .RCC_TIMPRES_DIV4 => {},
                        .RCC_TIMPRES_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_TIMPRES_DIV1;
            };
            const TIMGFreq_ValueValue: ?f32 = blk: {
                TIMGFreq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const APB1DIVValue: ?APB1DIVList = blk: {
                const item: APB1DIVList = .RCC_APB1_DIV1;
                break :blk item;
            };
            const AHB1234Freq_ValueValue: ?f32 = blk: {
                AHB1234Freq_ValueLimit = .{
                    .min = null,
                    .max = 2e8,
                };
                break :blk null;
            };
            const APB1Freq_ValueValue: ?f32 = blk: {
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const APB2DIVValue: ?APB2DIVList = blk: {
                const item: APB2DIVList = .RCC_APB2_DIV1;
                break :blk item;
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 4e8,
                };
                break :blk null;
            };
            const PLL1SourceValue: ?PLL1SourceList = blk: {
                const conf_item = config.PLL1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLL1SOURCE_HSI = true,
                        .RCC_PLLSOURCE_MSI => PLL1SOURCE_MSI = true,
                        .RCC_PLLSOURCE_HSE => PLL1SOURCE_HSE = true,
                        .RCC_PLLSOURCE_PIN => PLL1SOURCE_I2S = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const FREFDIV1Value: ?f32 = blk: {
                const config_val = config.FREFDIV1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FREFDIV1",
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
                            "FREFDIV1",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLL2SourceValue: ?PLL2SourceList = blk: {
                const conf_item = config.PLL2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLL2SOURCE_HSI = true,
                        .RCC_PLLSOURCE_MSI => PLL2SOURCE_MSI = true,
                        .RCC_PLLSOURCE_HSE => PLL2SOURCE_HSE = true,
                        .RCC_PLLSOURCE_PIN => PLL2SOURCE_I2S = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const FREFDIV2Value: ?f32 = blk: {
                const config_val = config.FREFDIV2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FREFDIV2",
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
                            "FREFDIV2",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLL3SourceValue: ?PLL3SourceList = blk: {
                const conf_item = config.PLL3Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLL3SOURCE_HSI = true,
                        .RCC_PLLSOURCE_MSI => PLL3SOURCE_MSI = true,
                        .RCC_PLLSOURCE_HSE => PLL3SOURCE_HSE = true,
                        .RCC_PLLSOURCE_PIN => PLL3SOURCE_I2S = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const FREFDIV3Value: ?f32 = blk: {
                const config_val = config.FREFDIV3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FREFDIV3",
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
                            "FREFDIV3",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const PLL4SourceValue: ?PLL4SourceList = blk: {
                const conf_item = config.PLL4Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLL4SOURCE_HSI = true,
                        .RCC_PLLSOURCE_MSI => PLL4SOURCE_MSI = true,
                        .RCC_PLLSOURCE_HSE => PLL4SOURCE_HSE = true,
                        .RCC_PLLSOURCE_PIN => PLL4SOURCE_I2S = true,
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const FREFDIV4Value: ?f32 = blk: {
                const config_val = config.FREFDIV4;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FREFDIV4",
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
                            "FREFDIV4",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const FBDIV1Value: ?f32 = blk: {
                const config_val = config.FBDIV1;
                if (config_val) |val| {
                    if (val < 10) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV1",
                            "Else",
                            "No Extra Log",
                            10,
                            val,
                        });
                    }
                    if (val > 2500) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV1",
                            "Else",
                            "No Extra Log",
                            2500,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
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
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 16777215) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1FRACV",
                            "Else",
                            "No Extra Log",
                            16777215,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const POSTDIV1_1Value: ?f32 = blk: {
                const config_val = config.POSTDIV1_1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_1",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const POSTDIV2_1Value: ?f32 = blk: {
                const config_val = config.POSTDIV2_1;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_1",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_1",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const FOUTPOSTDIV1Freq_ValueValue: ?f32 = blk: {
                FOUTPOSTDIV1Freq_ValueLimit = .{
                    .min = 1.6e7,
                    .max = 3.2e9,
                };
                break :blk null;
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
            const PLL2FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL2FRACV) |val| {
                        if (val != 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 16777215) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL2FRACV",
                            "Else",
                            "No Extra Log",
                            16777215,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const FBDIV2Value: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    const config_val = config.FBDIV2;
                    if (config_val) |val| {
                        if (val < 10) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV2",
                                "PLL2MODE = RCC_PLL_INTEGER  | PLL2MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                10,
                                val,
                            });
                        }
                        if (val > 2500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV2",
                                "PLL2MODE = RCC_PLL_INTEGER  | PLL2MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                2500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                } else if (check_ref(@TypeOf(PLL2MODEValue), PLL2MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
                    const config_val = config.FBDIV2;
                    if (config_val) |val| {
                        if (val < 20) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV2",
                                "PLL2MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                20,
                                val,
                            });
                        }
                        if (val > 500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV2",
                                "PLL2MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                }
                const config_val = config.FBDIV2;
                if (config_val) |val| {
                    if (val < 20) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV2",
                            "Else",
                            "No Extra Log",
                            20,
                            val,
                        });
                    }
                    if (val > 500) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV2",
                            "Else",
                            "No Extra Log",
                            500,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
            };
            const POSTDIV1_2Value: ?f32 = blk: {
                const config_val = config.POSTDIV1_2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_2",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const POSTDIV2_2Value: ?f32 = blk: {
                const config_val = config.POSTDIV2_2;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_2",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_2",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const FOUTPOSTDIV2Freq_ValueValue: ?f32 = blk: {
                FOUTPOSTDIV2Freq_ValueLimit = .{
                    .min = 1.6e7,
                    .max = 3.2e9,
                };
                break :blk null;
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
            const PLL3FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL3FRACV) |val| {
                        if (val != 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 16777215) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL3FRACV",
                            "Else",
                            "No Extra Log",
                            16777215,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const FBDIV3Value: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    const config_val = config.FBDIV3;
                    if (config_val) |val| {
                        if (val < 10) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV3",
                                "PLL3MODE = RCC_PLL_INTEGER  | PLL3MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                10,
                                val,
                            });
                        }
                        if (val > 2500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV3",
                                "PLL3MODE = RCC_PLL_INTEGER  | PLL3MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                2500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                } else if (check_ref(@TypeOf(PLL3MODEValue), PLL3MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
                    const config_val = config.FBDIV3;
                    if (config_val) |val| {
                        if (val < 20) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV3",
                                "PLL3MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                20,
                                val,
                            });
                        }
                        if (val > 500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV3",
                                "PLL3MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                }
                const config_val = config.FBDIV3;
                if (config_val) |val| {
                    if (val < 20) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV3",
                            "Else",
                            "No Extra Log",
                            20,
                            val,
                        });
                    }
                    if (val > 500) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV3",
                            "Else",
                            "No Extra Log",
                            500,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
            };
            const POSTDIV1_3Value: ?f32 = blk: {
                const config_val = config.POSTDIV1_3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_3",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const POSTDIV2_3Value: ?f32 = blk: {
                const config_val = config.POSTDIV2_3;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_3",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_3",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const FOUTPOSTDIV3Freq_ValueValue: ?f32 = blk: {
                FOUTPOSTDIV3Freq_ValueLimit = .{
                    .min = 1.6e7,
                    .max = 3.2e9,
                };
                break :blk null;
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
            const PLL4FRACVValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    if (config.PLL4FRACV) |val| {
                        if (val != 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
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
                        try comptime_fail_or_error(error.InvalidConfig,
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
                    if (val > 16777215) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL4FRACV",
                            "Else",
                            "No Extra Log",
                            16777215,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const FBDIV4Value: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_INTEGER, .@"=") or check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_SPREAD_SPECTRUM, .@"=")) {
                    const config_val = config.FBDIV4;
                    if (config_val) |val| {
                        if (val < 10) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV4",
                                "PLL4MODE = RCC_PLL_INTEGER  | PLL4MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                10,
                                val,
                            });
                        }
                        if (val > 2500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV4",
                                "PLL4MODE = RCC_PLL_INTEGER  | PLL4MODE = RCC_PLL_SPREAD_SPECTRUM",
                                "No Extra Log",
                                2500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                } else if (check_ref(@TypeOf(PLL4MODEValue), PLL4MODEValue, .RCC_PLL_FRACTIONAL, .@"=")) {
                    const config_val = config.FBDIV4;
                    if (config_val) |val| {
                        if (val < 20) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV4",
                                "PLL4MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                20,
                                val,
                            });
                        }
                        if (val > 500) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "FBDIV4",
                                "PLL4MODE = RCC_PLL_FRACTIONAL",
                                "No Extra Log",
                                500,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
                }
                const config_val = config.FBDIV4;
                if (config_val) |val| {
                    if (val < 20) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV4",
                            "Else",
                            "No Extra Log",
                            20,
                            val,
                        });
                    }
                    if (val > 500) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "FBDIV4",
                            "Else",
                            "No Extra Log",
                            500,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 25;
            };
            const POSTDIV1_4Value: ?f32 = blk: {
                const config_val = config.POSTDIV1_4;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_4",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV1_4",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const POSTDIV2_4Value: ?f32 = blk: {
                const config_val = config.POSTDIV2_4;
                if (config_val) |val| {
                    if (val < 1) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_4",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 7) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "POSTDIV2_4",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const FOUTPOSTDIV4Freq_ValueValue: ?f32 = blk: {
                FOUTPOSTDIV4Freq_ValueLimit = .{
                    .min = 1.6e7,
                    .max = 3.2e9,
                };
                break :blk null;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                const config_val = config.RCC_RTC_Clock_Source_FROM_HSE;
                if (config_val) |val| {
                    if (val < 2) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "RCC_RTC_Clock_Source_FROM_HSE",
                            "Else",
                            "No Extra Log",
                            2,
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
                            "RCC_RTC_Clock_Source_FROM_HSE",
                            "Else",
                            "No Extra Log",
                            63,
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

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                RTCFreq_ValueLimit = .{
                    .min = null,
                    .max = 4e6,
                };
                break :blk null;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 32000;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const MSICalibrationValueValue: ?f32 = blk: {
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
                    if (val > 31) {
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
                            31,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 600000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 600000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE0 => scale0 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                } else if (((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 800000000, .@"<")) or (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 800000000, .@"="))) and (check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 600000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((CpuClockFreq_Value < 800000000)|(CpuClockFreq_Value = 800000000)) & (CpuClockFreq_Value > 600000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(CpuClockFreq_ValueValue), CpuClockFreq_ValueValue, 800000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "(CpuClockFreq_Value > 800000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE0", i });
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
                if ((USART1CLKSOURCE_LSE and config.flags.USART1_Used) or (USART2CLKSOURCE_LSE and config.flags.USART2_Used) or (USART3CLKSOURCE_LSE and config.flags.USART3_Used) or (UART4CLKSOURCE_LSE and config.flags.UART4_Used) or (UART5CLKSOURCE_LSE and config.flags.UART5_Used) or (USART6CLKSOURCE_LSE and config.flags.USART6_Used) or (UART7CLKSOURCE_LSE and config.flags.UART7_Used) or (UART8CLKSOURCE_LSE and config.flags.UART8_Used) or (UART9CLKSOURCE_LSE and config.flags.UART9_Used) or (USART10CLKSOURCE_LSE and config.flags.USART10_Used) or (LPUART1CLKSOURCE_LSE and config.flags.LPUART1_Used) or (LPTIM1CLKSOURCE_LSE and config.flags.LPTIM1_Used) or (LPTIM2CLKSOURCE_LSE and config.flags.LPTIM2_Used) or (LPTIM3CLKSOURCE_LSE and config.flags.LPTIM3_Used) or (LPTIM4CLKSOURCE_LSE and config.flags.LPTIM4_Used) or (LPTIM5CLKSOURCE_LSE and config.flags.LPTIM5_Used) or (MCO1SOURCE_LSE and config.flags.MCO1Config) or (MCO2SOURCE_LSE and config.flags.MCO2Config) or (RTCCLKSOURCE_LSE and config.flags.RTC_Used)) {
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
            const EnableUCPD1Value: ?EnableUCPD1List = blk: {
                if (config.flags.UCPD1_Used) {
                    const item: EnableUCPD1List = .true;
                    break :blk item;
                }
                const item: EnableUCPD1List = .false;
                break :blk item;
            };
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass or config.flags.HSEDIGByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const OTG1EnableValue: ?OTG1EnableList = blk: {
                if (config.flags.USB1_OTG_HS_Used) {
                    const item: OTG1EnableList = .true;
                    break :blk item;
                }
                const item: OTG1EnableList = .false;
                break :blk item;
            };
            const OTG2EnableValue: ?OTG2EnableList = blk: {
                if (config.flags.USB2_OTG_HS_Used) {
                    const item: OTG2EnableList = .true;
                    break :blk item;
                }
                const item: OTG2EnableList = .false;
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
            const XSPI1EnableValue: ?XSPI1EnableList = blk: {
                if (config.flags.XSPI1_Used) {
                    const item: XSPI1EnableList = .true;
                    break :blk item;
                }
                const item: XSPI1EnableList = .false;
                break :blk item;
            };
            const XSPI2EnableValue: ?XSPI2EnableList = blk: {
                if (config.flags.XSPI2_Used) {
                    const item: XSPI2EnableList = .true;
                    break :blk item;
                }
                const item: XSPI2EnableList = .false;
                break :blk item;
            };
            const XSPI3EnableValue: ?XSPI3EnableList = blk: {
                if (config.flags.XSPI3_Used) {
                    const item: XSPI3EnableList = .true;
                    break :blk item;
                }
                const item: XSPI3EnableList = .false;
                break :blk item;
            };
            const FMCEnableValue: ?FMCEnableList = blk: {
                if (config.flags.FMC_Used) {
                    const item: FMCEnableList = .true;
                    break :blk item;
                }
                const item: FMCEnableList = .false;
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
            const CKPEREnableValue: ?CKPEREnableList = blk: {
                if (config.flags.USB1_OTG_HS_Used or config.flags.USB2_OTG_HS_Used or config.flags.LPUART1_Used or config.flags.SDMMC1_Used or config.flags.SDMMC2_Used or config.flags.ADC1_Used or config.flags.ADC2_Used or config.flags.ADF1_Used or config.flags.DCMI_Used or config.flags.DCMIPP_Used or config.flags.FDCAN1_Used or config.flags.FDCAN2_Used or config.flags.FDCAN3_Used or config.flags.FMC_Used or config.flags.I2C1_Used or config.flags.I2C2_Used or config.flags.I2C3_Used or config.flags.I2C4_Used or config.flags.I3C1_Used or config.flags.I3C2_Used or config.flags.MDF1_Used or config.flags.LPTIM1_Used or config.flags.LPTIM2_Used or config.flags.LPTIM3_Used or config.flags.LPTIM4_Used or config.flags.LPTIM5_Used or config.flags.LTDC_Used or config.flags.PSSI_Used or config.flags.SAI1_Used or config.flags.SAI2_Used or config.flags.SPDIFRX1_Used or config.flags.XSPI1_Used or config.flags.XSPI2_Used or config.flags.XSPI3_Used or config.flags.USART1_Used or config.flags.USART2_Used or config.flags.USART3_Used or config.flags.UART4_Used or config.flags.UART5_Used or config.flags.UART7_Used or config.flags.UART8_Used or config.flags.UART9_Used or config.flags.USART6_Used or config.flags.USART10_Used or config.flags.SPI1_Used or config.flags.SPI2_Used or config.flags.SPI3_Used or config.flags.SPI4_Used or config.flags.SPI5_Used or config.flags.SPI6_Used or config.flags.ETH1_Used) {
                    const item: CKPEREnableList = .true;
                    break :blk item;
                }
                const item: CKPEREnableList = .false;
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
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.ADC1_Used or config.flags.ADC2_Used) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const EnableADF1Value: ?EnableADF1List = blk: {
                if (config.flags.ADF1_Used) {
                    const item: EnableADF1List = .true;
                    break :blk item;
                }
                const item: EnableADF1List = .false;
                break :blk item;
            };
            const EnableMDF1Value: ?EnableMDF1List = blk: {
                if (config.flags.MDF1_Used) {
                    const item: EnableMDF1List = .true;
                    break :blk item;
                }
                const item: EnableMDF1List = .false;
                break :blk item;
            };
            const EnableSAI1Value: ?EnableSAI1List = blk: {
                if (config.flags.SAI1_Used) {
                    const item: EnableSAI1List = .true;
                    break :blk item;
                }
                const item: EnableSAI1List = .false;
                break :blk item;
            };
            const EnableSAI2Value: ?EnableSAI2List = blk: {
                if (config.flags.SAI2_Used) {
                    const item: EnableSAI2List = .true;
                    break :blk item;
                }
                const item: EnableSAI2List = .false;
                break :blk item;
            };
            const EnableSPDIFRXValue: ?EnableSPDIFRXList = blk: {
                if (config.flags.SPDIFRX1_Used) {
                    const item: EnableSPDIFRXList = .true;
                    break :blk item;
                }
                const item: EnableSPDIFRXList = .false;
                break :blk item;
            };
            const EnableSPI1Value: ?EnableSPI1List = blk: {
                if (config.flags.SPI1_Used or config.flags.I2S1_Used) {
                    const item: EnableSPI1List = .true;
                    break :blk item;
                }
                const item: EnableSPI1List = .false;
                break :blk item;
            };
            const EnableSPI2Value: ?EnableSPI2List = blk: {
                if (config.flags.SPI2_Used or config.flags.I2S2_Used) {
                    const item: EnableSPI2List = .true;
                    break :blk item;
                }
                const item: EnableSPI2List = .false;
                break :blk item;
            };
            const EnableSPI3Value: ?EnableSPI3List = blk: {
                if (config.flags.SPI3_Used or config.flags.I2S3_Used) {
                    const item: EnableSPI3List = .true;
                    break :blk item;
                }
                const item: EnableSPI3List = .false;
                break :blk item;
            };
            const EnableSPI6Value: ?EnableSPI6List = blk: {
                if (config.flags.SPI6_Used or config.flags.I2S6_Used) {
                    const item: EnableSPI6List = .true;
                    break :blk item;
                }
                const item: EnableSPI6List = .false;
                break :blk item;
            };
            const EnableSPI4Value: ?EnableSPI4List = blk: {
                if (config.flags.SPI4_Used) {
                    const item: EnableSPI4List = .true;
                    break :blk item;
                }
                const item: EnableSPI4List = .false;
                break :blk item;
            };
            const EnableSPI5Value: ?EnableSPI5List = blk: {
                if (config.flags.SPI5_Used) {
                    const item: EnableSPI5List = .true;
                    break :blk item;
                }
                const item: EnableSPI5List = .false;
                break :blk item;
            };
            const EnableLPUART1Value: ?EnableLPUART1List = blk: {
                if (config.flags.LPUART1_Used) {
                    const item: EnableLPUART1List = .true;
                    break :blk item;
                } else if (config.flags.LPUART1_Used) {
                    const item: EnableLPUART1List = .true;
                    break :blk item;
                }
                const item: EnableLPUART1List = .false;
                break :blk item;
            };
            const EnableUSART1Value: ?EnableUSART1List = blk: {
                if (config.flags.USART1_Used) {
                    const item: EnableUSART1List = .true;
                    break :blk item;
                }
                const item: EnableUSART1List = .false;
                break :blk item;
            };
            const EnableUSART2Value: ?EnableUSART2List = blk: {
                if (config.flags.USART2_Used) {
                    const item: EnableUSART2List = .true;
                    break :blk item;
                }
                const item: EnableUSART2List = .false;
                break :blk item;
            };
            const EnableUSART3Value: ?EnableUSART3List = blk: {
                if (config.flags.USART3_Used) {
                    const item: EnableUSART3List = .true;
                    break :blk item;
                }
                const item: EnableUSART3List = .false;
                break :blk item;
            };
            const EnableUSART6Value: ?EnableUSART6List = blk: {
                if (config.flags.USART6_Used) {
                    const item: EnableUSART6List = .true;
                    break :blk item;
                }
                const item: EnableUSART6List = .false;
                break :blk item;
            };
            const EnableUSART10Value: ?EnableUSART10List = blk: {
                if (config.flags.USART10_Used) {
                    const item: EnableUSART10List = .true;
                    break :blk item;
                }
                const item: EnableUSART10List = .false;
                break :blk item;
            };
            const EnableUART4Value: ?EnableUART4List = blk: {
                if (config.flags.UART4_Used) {
                    const item: EnableUART4List = .true;
                    break :blk item;
                }
                const item: EnableUART4List = .false;
                break :blk item;
            };
            const EnableUART5Value: ?EnableUART5List = blk: {
                if (config.flags.UART5_Used) {
                    const item: EnableUART5List = .true;
                    break :blk item;
                }
                const item: EnableUART5List = .false;
                break :blk item;
            };
            const EnableUART7Value: ?EnableUART7List = blk: {
                if (config.flags.UART7_Used) {
                    const item: EnableUART7List = .true;
                    break :blk item;
                }
                const item: EnableUART7List = .false;
                break :blk item;
            };
            const EnableUART8Value: ?EnableUART8List = blk: {
                if (config.flags.UART8_Used) {
                    const item: EnableUART8List = .true;
                    break :blk item;
                }
                const item: EnableUART8List = .false;
                break :blk item;
            };
            const EnableUART9Value: ?EnableUART9List = blk: {
                if (config.flags.UART9_Used) {
                    const item: EnableUART9List = .true;
                    break :blk item;
                }
                const item: EnableUART9List = .false;
                break :blk item;
            };
            const EnableI2C1Value: ?EnableI2C1List = blk: {
                if (config.flags.I2C1_Used) {
                    const item: EnableI2C1List = .true;
                    break :blk item;
                }
                const item: EnableI2C1List = .false;
                break :blk item;
            };
            const EnableI2C2Value: ?EnableI2C2List = blk: {
                if (config.flags.I2C2_Used) {
                    const item: EnableI2C2List = .true;
                    break :blk item;
                }
                const item: EnableI2C2List = .false;
                break :blk item;
            };
            const EnableI2C3Value: ?EnableI2C3List = blk: {
                if (config.flags.I2C3_Used) {
                    const item: EnableI2C3List = .true;
                    break :blk item;
                }
                const item: EnableI2C3List = .false;
                break :blk item;
            };
            const EnableI2C4Value: ?EnableI2C4List = blk: {
                if (config.flags.I2C4_Used) {
                    const item: EnableI2C4List = .true;
                    break :blk item;
                }
                const item: EnableI2C4List = .false;
                break :blk item;
            };
            const EnableI3C1Value: ?EnableI3C1List = blk: {
                if (config.flags.I3C1_Used) {
                    const item: EnableI3C1List = .true;
                    break :blk item;
                }
                const item: EnableI3C1List = .false;
                break :blk item;
            };
            const EnableI3C2Value: ?EnableI3C2List = blk: {
                if (config.flags.I3C2_Used) {
                    const item: EnableI3C2List = .true;
                    break :blk item;
                }
                const item: EnableI3C2List = .false;
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
            const MCO2OutPutEnableValue: ?MCO2OutPutEnableList = blk: {
                if (config.flags.MCO2Config) {
                    const item: MCO2OutPutEnableList = .true;
                    break :blk item;
                }
                const item: MCO2OutPutEnableList = .false;
                break :blk item;
            };
            const EnableLPTIM1Value: ?EnableLPTIM1List = blk: {
                if (config.flags.LPTIM1_Used) {
                    const item: EnableLPTIM1List = .true;
                    break :blk item;
                }
                const item: EnableLPTIM1List = .false;
                break :blk item;
            };
            const EnableLPTIM2Value: ?EnableLPTIM2List = blk: {
                if (config.flags.LPTIM2_Used) {
                    const item: EnableLPTIM2List = .true;
                    break :blk item;
                }
                const item: EnableLPTIM2List = .false;
                break :blk item;
            };
            const EnableLPTIM3Value: ?EnableLPTIM3List = blk: {
                if (config.flags.LPTIM3_Used) {
                    const item: EnableLPTIM3List = .true;
                    break :blk item;
                }
                const item: EnableLPTIM3List = .false;
                break :blk item;
            };
            const EnableLPTIM4Value: ?EnableLPTIM4List = blk: {
                if (config.flags.LPTIM4_Used) {
                    const item: EnableLPTIM4List = .true;
                    break :blk item;
                }
                const item: EnableLPTIM4List = .false;
                break :blk item;
            };
            const EnableLPTIM5Value: ?EnableLPTIM5List = blk: {
                if (config.flags.LPTIM5_Used) {
                    const item: EnableLPTIM5List = .true;
                    break :blk item;
                }
                const item: EnableLPTIM5List = .false;
                break :blk item;
            };
            const EnableLTDCValue: ?EnableLTDCList = blk: {
                if (config.flags.LTDC_Used) {
                    const item: EnableLTDCList = .true;
                    break :blk item;
                }
                const item: EnableLTDCList = .false;
                break :blk item;
            };
            const EnableDCMIValue: ?EnableDCMIList = blk: {
                if (config.flags.DCMI_Used or config.flags.DCMIPP_Used) {
                    const item: EnableDCMIList = .true;
                    break :blk item;
                }
                const item: EnableDCMIList = .false;
                break :blk item;
            };
            const EnableCSIValue: ?EnableCSIList = blk: {
                if (config.flags.CSI_Used) {
                    const item: EnableCSIList = .true;
                    break :blk item;
                }
                const item: EnableCSIList = .false;
                break :blk item;
            };
            const EnableFDCAN123Value: ?EnableFDCAN123List = blk: {
                if (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used or config.flags.FDCAN3_Used) {
                    const item: EnableFDCAN123List = .true;
                    break :blk item;
                }
                const item: EnableFDCAN123List = .false;
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
                if (config.flags.IWDG_Used) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const IC1UsedValue: ?f32 = blk: {
                if (CPUCLKSOURCE_IC1) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC2UsedValue: ?f32 = blk: {
                if (SYSBCLKSOURCE_IC2_IC6_IC11) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC3UsedValue: ?f32 = blk: {
                if ((FMCCLKSOURCE_IC3 and config.flags.FMC_Used) or (XSPI1CLKSOURCE_IC3 and config.flags.XSPI1_Used) or (XSPI2CLKSOURCE_IC3 and config.flags.XSPI2_Used) or (XSPI3CLKSOURCE_IC3 and config.flags.XSPI3_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC4UsedValue: ?f32 = blk: {
                if ((SDMMC1CLKSOURCE_IC4 and config.flags.SDMMC1_Used) or (SDMMC2CLKSOURCE_IC4 and config.flags.SDMMC2_Used) or (FMCCLKSOURCE_IC4 and config.flags.FMC_Used) or (XSPI1CLKSOURCE_IC4 and config.flags.XSPI1_Used) or (XSPI2CLKSOURCE_IC4 and config.flags.XSPI2_Used) or (XSPI3CLKSOURCE_IC4 and config.flags.XSPI3_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC5UsedValue: ?f32 = blk: {
                if ((SDMMC1CLKSOURCE_IC5 and config.flags.SDMMC1_Used) or (SDMMC2CLKSOURCE_IC5 and config.flags.SDMMC2_Used) or (CLKPCLKSOURCE_IC5) or (MCO1SOURCE_IC5 and config.flags.MCO1Config)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC6UsedValue: ?f32 = blk: {
                if ((SYSCCLKSOURCE_IC2_IC6_IC11)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC7UsedValue: ?f32 = blk: {
                if ((ADCCLKSOURCE_IC7 and (config.flags.ADC1_Used or config.flags.ADC2_Used)) or (ADF1CLKSOURCE_IC7 and config.flags.ADF1_Used) or (MDF1CLKSOURCE_IC7 and config.flags.MDF1_Used) or (SAI1CLKSOURCE_IC7 and config.flags.SAI1_Used) or (SAI2CLKSOURCE_IC7 and config.flags.SAI2_Used) or (SPDIFRX1CLKSOURCE_IC7 and config.flags.SPDIFRX1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC8UsedValue: ?f32 = blk: {
                if ((SPI1CLKSOURCE_IC8 and config.flags.SPI1_Used) or (SPI2CLKSOURCE_IC8 and config.flags.SPI2_Used) or (SPI3CLKSOURCE_IC8 and config.flags.SPI3_Used) or (SPI6CLKSOURCE_IC8 and config.flags.SPI6_Used) or (ADCCLKSOURCE_IC8 and (config.flags.ADC1_Used or config.flags.ADC2_Used)) or (ADF1CLKSOURCE_IC8 and config.flags.ADF1_Used) or (MDF1CLKSOURCE_IC8 and config.flags.MDF1_Used) or (SAI1CLKSOURCE_IC8 and config.flags.SAI1_Used) or (SAI2CLKSOURCE_IC8 and config.flags.SAI2_Used) or (SPDIFRX1CLKSOURCE_IC8 and config.flags.SPDIFRX1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC9UsedValue: ?f32 = blk: {
                if ((SPI1CLKSOURCE_IC9 and config.flags.SPI1_Used) or (SPI2CLKSOURCE_IC9 and config.flags.SPI2_Used) or (SPI3CLKSOURCE_IC9 and config.flags.SPI3_Used) or (check_MCU("SPI4CLKSOURCE_IC9") and config.flags.SPI4_Used) or (SPI5CLKSOURCE_IC9 and config.flags.SPI5_Used) or (SPI6CLKSOURCE_IC9 and config.flags.SPI6_Used) or (LPUART1CLKSOURCE_IC9 and config.flags.LPUART1_Used) or (USART1CLKSOURCE_IC9 and config.flags.USART1_Used) or (USART2CLKSOURCE_IC9 and config.flags.USART2_Used) or (USART3CLKSOURCE_IC9 and config.flags.USART3_Used) or (UART4CLKSOURCE_IC9 and config.flags.UART4_Used) or (UART5CLKSOURCE_IC9 and config.flags.UART5_Used) or (USART6CLKSOURCE_IC9 and config.flags.USART6_Used) or (UART7CLKSOURCE_IC9 and config.flags.UART7_Used) or (UART8CLKSOURCE_IC9 and config.flags.UART8_Used) or (UART9CLKSOURCE_IC9 and config.flags.UART9_Used) or (USART10CLKSOURCE_IC9 and config.flags.USART10_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC10UsedValue: ?f32 = blk: {
                if ((MCO1SOURCE_IC10 and config.flags.MCO1Config) or (CLKPCLKSOURCE_IC10) or (I2C1CLKSOURCE_IC10 and config.flags.I2C1_Used) or (I2C2CLKSOURCE_IC10 and config.flags.I2C2_Used) or (I2C3CLKSOURCE_IC10 and config.flags.I2C3_Used) or (I2C4CLKSOURCE_IC10 and config.flags.I2C4_Used) or (I3C1CLKSOURCE_IC10 and config.flags.I3C1_Used) or (I3C2CLKSOURCE_IC10 and config.flags.I3C2_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC11UsedValue: ?f32 = blk: {
                if ((SYSDCLKSOURCE_IC2_IC6_IC11)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC12UsedValue: ?f32 = blk: {
                if ((ETH1CLKSOURCE_IC12 and config.flags.ETH1_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC14UsedValue: ?f32 = blk: {
                if ((check_MCU("SPI4CLKSOURCE_IC14") and config.flags.SPI4_Used) or (SPI5CLKSOURCE_IC14 and config.flags.SPI5_Used) or (LPUART1CLKSOURCE_IC14 and config.flags.LPUART1_Used) or (USART1CLKSOURCE_IC14 and config.flags.USART1_Used) or (USART2CLKSOURCE_IC14 and config.flags.USART2_Used) or (USART3CLKSOURCE_IC14 and config.flags.USART3_Used) or (UART4CLKSOURCE_IC14 and config.flags.UART4_Used) or (UART5CLKSOURCE_IC14 and config.flags.UART5_Used) or (USART6CLKSOURCE_IC14 and config.flags.USART6_Used) or (UART7CLKSOURCE_IC14 and config.flags.UART7_Used) or (UART8CLKSOURCE_IC14 and config.flags.UART8_Used) or (UART9CLKSOURCE_IC14 and config.flags.UART9_Used) or (USART10CLKSOURCE_IC14 and config.flags.USART10_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC15UsedValue: ?f32 = blk: {
                if ((MCO2SOURCE_IC15 and config.flags.MCO2Config) or (CLKPCLKSOURCE_IC15) or (I2C1CLKSOURCE_IC15 and config.flags.I2C1_Used) or (I2C2CLKSOURCE_IC15 and config.flags.I2C2_Used) or (I2C3CLKSOURCE_IC15 and config.flags.I2C3_Used) or (I2C4CLKSOURCE_IC15 and config.flags.I2C4_Used) or (I3C1CLKSOURCE_IC15 and config.flags.I3C1_Used) or (I3C2CLKSOURCE_IC15 and config.flags.I3C2_Used) or (LPTIM1CLKSOURCE_IC15 and config.flags.LPTIM1_Used) or (LPTIM2CLKSOURCE_IC15 and config.flags.LPTIM2_Used) or (LPTIM3CLKSOURCE_IC15 and config.flags.LPTIM3_Used) or (LPTIM4CLKSOURCE_IC15 and config.flags.LPTIM4_Used) or (LPTIM5CLKSOURCE_IC15 and config.flags.LPTIM5_Used) or (OTGPHY1CLKSOURCE_IC15 and OTGHS1CLKSOURCE_PHY and config.flags.USB1_OTG_HS_Used) or (OTGPHY2CLKSOURCE_IC15 and OTGHS2CLKSOURCE_PHY and config.flags.USB2_OTG_HS_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC16UsedValue: ?f32 = blk: {
                if ((LTDCCLKSOURCE_IC16 and config.flags.LTDC_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC17UsedValue: ?f32 = blk: {
                if ((DCMIPPCLKSOURCE_IC17 and (config.flags.DCMI_Used or config.flags.DCMIPP_Used))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC18UsedValue: ?f32 = blk: {
                if ((config.flags.CSI_Used)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC19UsedValue: ?f32 = blk: {
                if ((CLKPCLKSOURCE_IC19) or (FDCANCLKSOURCE_IC19 and (config.flags.FDCAN1_Used or config.flags.FDCAN2_Used or config.flags.FDCAN3_Used))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const IC20UsedValue: ?f32 = blk: {
                if ((CLKPCLKSOURCE_IC20) or (PSSICLKSOURCE_IC20 and config.flags.PSSI_Used) or (MCO2SOURCE_IC20 and config.flags.MCO2Config)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1UsedValue: ?f32 = blk: {
                if ((IC1_PLL1 and check_ref(@TypeOf(IC1UsedValue), IC1UsedValue, 1, .@"=")) or (IC2_PLL1 and check_ref(@TypeOf(IC2UsedValue), IC2UsedValue, 1, .@"=")) or (IC3_PLL1 and check_ref(@TypeOf(IC3UsedValue), IC3UsedValue, 1, .@"=")) or (IC4_PLL1 and check_ref(@TypeOf(IC4UsedValue), IC4UsedValue, 1, .@"=")) or (IC5_PLL1 and check_ref(@TypeOf(IC5UsedValue), IC5UsedValue, 1, .@"=")) or (IC6_PLL1 and check_ref(@TypeOf(IC6UsedValue), IC6UsedValue, 1, .@"=")) or (IC7_PLL1 and check_ref(@TypeOf(IC7UsedValue), IC7UsedValue, 1, .@"=")) or (IC8_PLL1 and check_ref(@TypeOf(IC8UsedValue), IC8UsedValue, 1, .@"=")) or (IC9_PLL1 and check_ref(@TypeOf(IC9UsedValue), IC9UsedValue, 1, .@"=")) or (IC10_PLL1 and check_ref(@TypeOf(IC10UsedValue), IC10UsedValue, 1, .@"=")) or (IC11_PLL1 and check_ref(@TypeOf(IC11UsedValue), IC11UsedValue, 1, .@"=")) or (IC12_PLL1 and check_ref(@TypeOf(IC12UsedValue), IC12UsedValue, 1, .@"=")) or (IC14_PLL1 and check_ref(@TypeOf(IC14UsedValue), IC14UsedValue, 1, .@"=")) or (IC15_PLL1 and check_ref(@TypeOf(IC15UsedValue), IC15UsedValue, 1, .@"=")) or (IC16_PLL1 and check_ref(@TypeOf(IC16UsedValue), IC16UsedValue, 1, .@"=")) or (IC17_PLL1 and check_ref(@TypeOf(IC17UsedValue), IC17UsedValue, 1, .@"=")) or (IC18_PLL1 and check_ref(@TypeOf(IC18UsedValue), IC18UsedValue, 1, .@"=")) or (IC19_PLL1 and check_ref(@TypeOf(IC19UsedValue), IC19UsedValue, 1, .@"=")) or (IC20_PLL1 and check_ref(@TypeOf(IC20UsedValue), IC20UsedValue, 1, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if ((IC1_PLL2 and check_ref(@TypeOf(IC1UsedValue), IC1UsedValue, 1, .@"=")) or (IC2_PLL2 and check_ref(@TypeOf(IC2UsedValue), IC2UsedValue, 1, .@"=")) or (IC3_PLL2 and check_ref(@TypeOf(IC3UsedValue), IC3UsedValue, 1, .@"=")) or (IC4_PLL2 and check_ref(@TypeOf(IC4UsedValue), IC4UsedValue, 1, .@"=")) or (IC5_PLL2 and check_ref(@TypeOf(IC5UsedValue), IC5UsedValue, 1, .@"=")) or (IC6_PLL2 and check_ref(@TypeOf(IC6UsedValue), IC6UsedValue, 1, .@"=")) or (IC7_PLL2 and check_ref(@TypeOf(IC7UsedValue), IC7UsedValue, 1, .@"=")) or (IC8_PLL2 and check_ref(@TypeOf(IC8UsedValue), IC8UsedValue, 1, .@"=")) or (IC9_PLL2 and check_ref(@TypeOf(IC9UsedValue), IC9UsedValue, 1, .@"=")) or (IC10_PLL2 and check_ref(@TypeOf(IC10UsedValue), IC10UsedValue, 1, .@"=")) or (IC11_PLL2 and check_ref(@TypeOf(IC11UsedValue), IC11UsedValue, 1, .@"=")) or (IC12_PLL2 and check_ref(@TypeOf(IC12UsedValue), IC12UsedValue, 1, .@"=")) or (IC14_PLL2 and check_ref(@TypeOf(IC14UsedValue), IC14UsedValue, 1, .@"=")) or (IC15_PLL2 and check_ref(@TypeOf(IC15UsedValue), IC15UsedValue, 1, .@"=")) or (IC16_PLL2 and check_ref(@TypeOf(IC16UsedValue), IC16UsedValue, 1, .@"=")) or (IC17_PLL2 and check_ref(@TypeOf(IC17UsedValue), IC17UsedValue, 1, .@"=")) or (IC18_PLL2 and check_ref(@TypeOf(IC18UsedValue), IC18UsedValue, 1, .@"=")) or (IC19_PLL2 and check_ref(@TypeOf(IC19UsedValue), IC19UsedValue, 1, .@"=")) or (IC20_PLL2 and check_ref(@TypeOf(IC20UsedValue), IC20UsedValue, 1, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if ((IC1_PLL3 and check_ref(@TypeOf(IC1UsedValue), IC1UsedValue, 1, .@"=")) or (IC2_PLL3 and check_ref(@TypeOf(IC2UsedValue), IC2UsedValue, 1, .@"=")) or (IC3_PLL3 and check_ref(@TypeOf(IC3UsedValue), IC3UsedValue, 1, .@"=")) or (IC4_PLL3 and check_ref(@TypeOf(IC4UsedValue), IC4UsedValue, 1, .@"=")) or (IC5_PLL3 and check_ref(@TypeOf(IC5UsedValue), IC5UsedValue, 1, .@"=")) or (IC6_PLL3 and check_ref(@TypeOf(IC6UsedValue), IC6UsedValue, 1, .@"=")) or (IC7_PLL3 and check_ref(@TypeOf(IC7UsedValue), IC7UsedValue, 1, .@"=")) or (IC8_PLL3 and check_ref(@TypeOf(IC8UsedValue), IC8UsedValue, 1, .@"=")) or (IC9_PLL3 and check_ref(@TypeOf(IC9UsedValue), IC9UsedValue, 1, .@"=")) or (IC10_PLL3 and check_ref(@TypeOf(IC10UsedValue), IC10UsedValue, 1, .@"=")) or (IC11_PLL3 and check_ref(@TypeOf(IC11UsedValue), IC11UsedValue, 1, .@"=")) or (IC12_PLL3 and check_ref(@TypeOf(IC12UsedValue), IC12UsedValue, 1, .@"=")) or (IC14_PLL3 and check_ref(@TypeOf(IC14UsedValue), IC14UsedValue, 1, .@"=")) or (IC15_PLL3 and check_ref(@TypeOf(IC15UsedValue), IC15UsedValue, 1, .@"=")) or (IC16_PLL3 and check_ref(@TypeOf(IC16UsedValue), IC16UsedValue, 1, .@"=")) or (IC17_PLL3 and check_ref(@TypeOf(IC17UsedValue), IC17UsedValue, 1, .@"=")) or (IC18_PLL3 and check_ref(@TypeOf(IC18UsedValue), IC18UsedValue, 1, .@"=")) or (IC19_PLL3 and check_ref(@TypeOf(IC19UsedValue), IC19UsedValue, 1, .@"=")) or (IC20_PLL3 and check_ref(@TypeOf(IC20UsedValue), IC20UsedValue, 1, .@"="))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL4UsedValue: ?f32 = blk: {
                if ((IC1_PLL4 and check_ref(@TypeOf(IC1UsedValue), IC1UsedValue, 1, .@"=")) or (IC2_PLL4 and check_ref(@TypeOf(IC2UsedValue), IC2UsedValue, 1, .@"=")) or (IC3_PLL4 and check_ref(@TypeOf(IC3UsedValue), IC3UsedValue, 1, .@"=")) or (IC4_PLL4 and check_ref(@TypeOf(IC4UsedValue), IC4UsedValue, 1, .@"=")) or (IC5_PLL4 and check_ref(@TypeOf(IC5UsedValue), IC5UsedValue, 1, .@"=")) or (IC6_PLL4 and check_ref(@TypeOf(IC6UsedValue), IC6UsedValue, 1, .@"=")) or (IC7_PLL4 and check_ref(@TypeOf(IC7UsedValue), IC7UsedValue, 1, .@"=")) or (IC8_PLL4 and check_ref(@TypeOf(IC8UsedValue), IC8UsedValue, 1, .@"=")) or (IC9_PLL4 and check_ref(@TypeOf(IC9UsedValue), IC9UsedValue, 1, .@"=")) or (IC10_PLL4 and check_ref(@TypeOf(IC10UsedValue), IC10UsedValue, 1, .@"=")) or (IC11_PLL4 and check_ref(@TypeOf(IC11UsedValue), IC11UsedValue, 1, .@"=")) or (IC12_PLL4 and check_ref(@TypeOf(IC12UsedValue), IC12UsedValue, 1, .@"=")) or (IC14_PLL4 and check_ref(@TypeOf(IC14UsedValue), IC14UsedValue, 1, .@"=")) or (IC15_PLL4 and check_ref(@TypeOf(IC15UsedValue), IC15UsedValue, 1, .@"=")) or (IC16_PLL4 and check_ref(@TypeOf(IC16UsedValue), IC16UsedValue, 1, .@"=")) or (IC17_PLL4 and check_ref(@TypeOf(IC17UsedValue), IC17UsedValue, 1, .@"=")) or (IC18_PLL4 and check_ref(@TypeOf(IC18UsedValue), IC18UsedValue, 1, .@"=")) or (IC19_PLL4 and check_ref(@TypeOf(IC19UsedValue), IC19UsedValue, 1, .@"=")) or (IC20_PLL4 and check_ref(@TypeOf(IC20UsedValue), IC20UsedValue, 1, .@"="))) {
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

            var HSIDivOutput = ClockNode{
                .name = "HSIDivOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIDiv4 = ClockNode{
                .name = "HSIDiv4",
                .nodetype = .off,
                .parents = &.{},
            };

            var UCPDOutput = ClockNode{
                .name = "UCPDOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEOSC = ClockNode{
                .name = "HSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEOSCDIV = ClockNode{
                .name = "HSEOSCDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEDIV = ClockNode{
                .name = "HSEDIV",
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

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC1 = ClockNode{
                .name = "IC1",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC1Div = ClockNode{
                .name = "IC1Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC1Output = ClockNode{
                .name = "IC1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC2 = ClockNode{
                .name = "IC2",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC2Div = ClockNode{
                .name = "IC2Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC2Output = ClockNode{
                .name = "IC2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC3 = ClockNode{
                .name = "IC3",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC3Div = ClockNode{
                .name = "IC3Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC3Output = ClockNode{
                .name = "IC3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC4 = ClockNode{
                .name = "IC4",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC4Div = ClockNode{
                .name = "IC4Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC4Output = ClockNode{
                .name = "IC4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC5 = ClockNode{
                .name = "IC5",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC5Div = ClockNode{
                .name = "IC5Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC5Output = ClockNode{
                .name = "IC5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC6 = ClockNode{
                .name = "IC6",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC6Div = ClockNode{
                .name = "IC6Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC6Output = ClockNode{
                .name = "IC6Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC7 = ClockNode{
                .name = "IC7",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC7Div = ClockNode{
                .name = "IC7Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC7Output = ClockNode{
                .name = "IC7Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC8 = ClockNode{
                .name = "IC8",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC8Div = ClockNode{
                .name = "IC8Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC8Output = ClockNode{
                .name = "IC8Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC9 = ClockNode{
                .name = "IC9",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC9Div = ClockNode{
                .name = "IC9Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC9Output = ClockNode{
                .name = "IC9Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC10 = ClockNode{
                .name = "IC10",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC10Div = ClockNode{
                .name = "IC10Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC10Output = ClockNode{
                .name = "IC10Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC11 = ClockNode{
                .name = "IC11",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC11Div = ClockNode{
                .name = "IC11Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC11Output = ClockNode{
                .name = "IC11Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC12 = ClockNode{
                .name = "IC12",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC12Div = ClockNode{
                .name = "IC12Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC12Output = ClockNode{
                .name = "IC12Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC13 = ClockNode{
                .name = "IC13",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC13Div = ClockNode{
                .name = "IC13Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC13Output = ClockNode{
                .name = "IC13Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC14 = ClockNode{
                .name = "IC14",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC14Div = ClockNode{
                .name = "IC14Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC14Output = ClockNode{
                .name = "IC14Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC15 = ClockNode{
                .name = "IC15",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC15Div = ClockNode{
                .name = "IC15Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC15Output = ClockNode{
                .name = "IC15Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC16 = ClockNode{
                .name = "IC16",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC16Div = ClockNode{
                .name = "IC16Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC16Output = ClockNode{
                .name = "IC16Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC17 = ClockNode{
                .name = "IC17",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC17Div = ClockNode{
                .name = "IC17Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC17Output = ClockNode{
                .name = "IC17Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC18 = ClockNode{
                .name = "IC18",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC18Div = ClockNode{
                .name = "IC18Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC18Output = ClockNode{
                .name = "IC18Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC19 = ClockNode{
                .name = "IC19",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC19Div = ClockNode{
                .name = "IC19Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC19Output = ClockNode{
                .name = "IC19Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC20 = ClockNode{
                .name = "IC20",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC20Div = ClockNode{
                .name = "IC20Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var IC20Output = ClockNode{
                .name = "IC20Output",
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

            var ADCMult = ClockNode{
                .name = "ADCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCDIV = ClockNode{
                .name = "ADCDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
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

            var MDF1Mult = ClockNode{
                .name = "MDF1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MDFoutput = ClockNode{
                .name = "MDFoutput",
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

            var LTDCMult = ClockNode{
                .name = "LTDCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LTDCoutput = ClockNode{
                .name = "LTDCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DCMIPPMult = ClockNode{
                .name = "DCMIPPMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DCMIPPoutput = ClockNode{
                .name = "DCMIPPoutput",
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

            var OTGHS1Mult = ClockNode{
                .name = "OTGHS1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGHS1output = ClockNode{
                .name = "OTGHS1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGHS2Mult = ClockNode{
                .name = "OTGHS2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGHS2output = ClockNode{
                .name = "OTGHS2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var XSPI3Mult = ClockNode{
                .name = "XSPI3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var XSPI3output = ClockNode{
                .name = "XSPI3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGPHY1Mult = ClockNode{
                .name = "OTGPHY1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGPHY1output = ClockNode{
                .name = "OTGPHY1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGPHY2Mult = ClockNode{
                .name = "OTGPHY2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var OTGPHY2output = ClockNode{
                .name = "OTGPHY2output",
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

            var SPDIFRX1Mult = ClockNode{
                .name = "SPDIFRX1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPDIFRX1output = ClockNode{
                .name = "SPDIFRX1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSBClkSource = ClockNode{
                .name = "SYSBClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSCClkSource = ClockNode{
                .name = "SYSCClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSDClkSource = ClockNode{
                .name = "SYSDClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSBCLKOutput = ClockNode{
                .name = "SYSBCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSCCLKOutput = ClockNode{
                .name = "SYSCCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSDCLKOutput = ClockNode{
                .name = "SYSDCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSAClkSource = ClockNode{
                .name = "SYSAClkSource",
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

            var CpuClockOutput = ClockNode{
                .name = "CpuClockOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AXIClockOutput = ClockNode{
                .name = "AXIClockOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HPREDiv = ClockNode{
                .name = "HPREDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB4DIV = ClockNode{
                .name = "APB4DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB4Output = ClockNode{
                .name = "APB4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB5DIV = ClockNode{
                .name = "APB5DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB5Output = ClockNode{
                .name = "APB5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMGDIV = ClockNode{
                .name = "TIMGDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMGOutput = ClockNode{
                .name = "TIMGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB1DIV = ClockNode{
                .name = "APB1DIV",
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

            var APB2Output = ClockNode{
                .name = "APB2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1Source = ClockNode{
                .name = "PLL1Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var FREFDIV1 = ClockNode{
                .name = "FREFDIV1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Source = ClockNode{
                .name = "PLL2Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var FREFDIV2 = ClockNode{
                .name = "FREFDIV2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Source = ClockNode{
                .name = "PLL3Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var FREFDIV3 = ClockNode{
                .name = "FREFDIV3",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL4Source = ClockNode{
                .name = "PLL4Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var FREFDIV4 = ClockNode{
                .name = "FREFDIV4",
                .nodetype = .off,
                .parents = &.{},
            };

            var FBDIV1 = ClockNode{
                .name = "FBDIV1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1FRACV = ClockNode{
                .name = "PLL1FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV1_1 = ClockNode{
                .name = "POSTDIV1_1",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV2_1 = ClockNode{
                .name = "POSTDIV2_1",
                .nodetype = .off,
                .parents = &.{},
            };

            var FOUTPOSTDIV1 = ClockNode{
                .name = "FOUTPOSTDIV1",
                .nodetype = .off,
                .parents = &.{},
            };

            var FBDIV2 = ClockNode{
                .name = "FBDIV2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2FRACV = ClockNode{
                .name = "PLL2FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV1_2 = ClockNode{
                .name = "POSTDIV1_2",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV2_2 = ClockNode{
                .name = "POSTDIV2_2",
                .nodetype = .off,
                .parents = &.{},
            };

            var FOUTPOSTDIV2 = ClockNode{
                .name = "FOUTPOSTDIV2",
                .nodetype = .off,
                .parents = &.{},
            };

            var FBDIV3 = ClockNode{
                .name = "FBDIV3",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3FRACV = ClockNode{
                .name = "PLL3FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV1_3 = ClockNode{
                .name = "POSTDIV1_3",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV2_3 = ClockNode{
                .name = "POSTDIV2_3",
                .nodetype = .off,
                .parents = &.{},
            };

            var FOUTPOSTDIV3 = ClockNode{
                .name = "FOUTPOSTDIV3",
                .nodetype = .off,
                .parents = &.{},
            };

            var FBDIV4 = ClockNode{
                .name = "FBDIV4",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL4FRACV = ClockNode{
                .name = "PLL4FRACV",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV1_4 = ClockNode{
                .name = "POSTDIV1_4",
                .nodetype = .off,
                .parents = &.{},
            };

            var POSTDIV2_4 = ClockNode{
                .name = "POSTDIV2_4",
                .nodetype = .off,
                .parents = &.{},
            };

            var FOUTPOSTDIV4 = ClockNode{
                .name = "FOUTPOSTDIV4",
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

            std.mem.doNotOptimizeAway(HSIDiv_VALUEValue);
            HSIDivOutput.nodetype = .output;
            HSIDivOutput.parents = &.{&HSIDiv};

            const HSIDiv4_clk_value = HSIDiv4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIDiv4",
                "Else",
                "No Extra Log",
                "HSIDiv4",
            });
            HSIDiv4.nodetype = .div;
            HSIDiv4.value = HSIDiv4_clk_value.get();
            HSIDiv4.parents = &.{&HSIRC};
            if (check_ref(@TypeOf(EnableUCPD1Value), EnableUCPD1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UCPDFreq_ValueValue);
                UCPDOutput.limit = UCPDFreq_ValueLimit;
                UCPDOutput.nodetype = .output;
                UCPDOutput.parents = &.{&HSIDiv4};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
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
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"="))
            {
                const HSEOSCDIV_clk_value = HSE_DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEOSCDIV",
                    "Else",
                    "No Extra Log",
                    "HSE_Div",
                });
                HSEOSCDIV.nodetype = .div;
                HSEOSCDIV.value = HSEOSCDIV_clk_value.get();
                HSEOSCDIV.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"="))
            {
                const HSEDIV_clk_value = HSE_Div2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEDIV",
                    "Else",
                    "No Extra Log",
                    "HSE_Div2",
                });
                HSEDIV.nodetype = .div;
                HSEDIV.value = HSEDIV_clk_value.get();
                HSEDIV.parents = &.{&HSEOSC};
            }

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
            if (check_ref(@TypeOf(EnableLSEValue), EnableLSEValue, .true, .@"=")) {
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
            }

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

            const IC1_clk_value = IC1CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC1",
                "Else",
                "No Extra Log",
                "IC1CLKSource",
            });
            const IC1parents = [_]*const ClockNode{
                &FOUTPOSTDIV1,
                &FOUTPOSTDIV2,
                &FOUTPOSTDIV3,
                &FOUTPOSTDIV4,
            };
            IC1.nodetype = .multi;
            IC1.parents = &.{IC1parents[IC1_clk_value.get()]};

            const IC1Div_clk_value = IC1DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC1Div",
                "Else",
                "No Extra Log",
                "IC1Div",
            });
            IC1Div.nodetype = .div;
            IC1Div.value = IC1Div_clk_value;
            IC1Div.parents = &.{&IC1};

            std.mem.doNotOptimizeAway(IC1Freq_VALUEValue);
            IC1Output.limit = IC1Freq_VALUELimit;
            IC1Output.nodetype = .output;
            IC1Output.parents = &.{&IC1Div};

            const IC2_clk_value = IC2CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC2",
                "Else",
                "No Extra Log",
                "IC2CLKSource",
            });
            const IC2parents = [_]*const ClockNode{
                &FOUTPOSTDIV1,
                &FOUTPOSTDIV2,
                &FOUTPOSTDIV3,
                &FOUTPOSTDIV4,
            };
            IC2.nodetype = .multi;
            IC2.parents = &.{IC2parents[IC2_clk_value.get()]};

            const IC2Div_clk_value = IC2DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC2Div",
                "Else",
                "No Extra Log",
                "IC2Div",
            });
            IC2Div.nodetype = .div;
            IC2Div.value = IC2Div_clk_value;
            IC2Div.parents = &.{&IC2};

            std.mem.doNotOptimizeAway(IC2Freq_VALUEValue);
            IC2Output.limit = IC2Freq_VALUELimit;
            IC2Output.nodetype = .output;
            IC2Output.parents = &.{&IC2Div};
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"="))
            {
                const IC3_clk_value = IC3CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC3",
                    "Else",
                    "No Extra Log",
                    "IC3CLKSource",
                });
                const IC3parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC3.nodetype = .multi;
                IC3.parents = &.{IC3parents[IC3_clk_value.get()]};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"="))
            {
                const IC3Div_clk_value = IC3DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC3Div",
                    "Else",
                    "No Extra Log",
                    "IC3Div",
                });
                IC3Div.nodetype = .div;
                IC3Div.value = IC3Div_clk_value;
                IC3Div.parents = &.{&IC3};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC3Freq_VALUEValue);
                IC3Output.limit = IC3Freq_VALUELimit;
                IC3Output.nodetype = .output;
                IC3Output.parents = &.{&IC3Div};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                const IC4_clk_value = IC4CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC4",
                    "Else",
                    "No Extra Log",
                    "IC4CLKSource",
                });
                const IC4parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC4.nodetype = .multi;
                IC4.parents = &.{IC4parents[IC4_clk_value.get()]};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                const IC4Div_clk_value = IC4DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC4Div",
                    "Else",
                    "No Extra Log",
                    "IC4Div",
                });
                IC4Div.nodetype = .div;
                IC4Div.value = IC4Div_clk_value;
                IC4Div.parents = &.{&IC4};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC4Freq_VALUEValue);
                IC4Output.limit = IC4Freq_VALUELimit;
                IC4Output.nodetype = .output;
                IC4Output.parents = &.{&IC4Div};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                const IC5_clk_value = IC5CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC5",
                    "Else",
                    "No Extra Log",
                    "IC5CLKSource",
                });
                const IC5parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC5.nodetype = .multi;
                IC5.parents = &.{IC5parents[IC5_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                const IC5Div_clk_value = IC5DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC5Div",
                    "Else",
                    "No Extra Log",
                    "IC5Div",
                });
                IC5Div.nodetype = .div;
                IC5Div.value = IC5Div_clk_value;
                IC5Div.parents = &.{&IC5};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDMMC2EnableValue), SDMMC2EnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC5Freq_VALUEValue);
                IC5Output.limit = IC5Freq_VALUELimit;
                IC5Output.nodetype = .output;
                IC5Output.parents = &.{&IC5Div};
            }

            const IC6_clk_value = IC6CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC6",
                "Else",
                "No Extra Log",
                "IC6CLKSource",
            });
            const IC6parents = [_]*const ClockNode{
                &FOUTPOSTDIV1,
                &FOUTPOSTDIV2,
                &FOUTPOSTDIV3,
                &FOUTPOSTDIV4,
            };
            IC6.nodetype = .multi;
            IC6.parents = &.{IC6parents[IC6_clk_value.get()]};

            const IC6Div_clk_value = IC6DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC6Div",
                "Else",
                "No Extra Log",
                "IC6Div",
            });
            IC6Div.nodetype = .div;
            IC6Div.value = IC6Div_clk_value;
            IC6Div.parents = &.{&IC6};

            std.mem.doNotOptimizeAway(IC6Freq_VALUEValue);
            IC6Output.limit = IC6Freq_VALUELimit;
            IC6Output.nodetype = .output;
            IC6Output.parents = &.{&IC6Div};
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"="))
            {
                const IC7_clk_value = IC7CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC7",
                    "Else",
                    "No Extra Log",
                    "IC7CLKSource",
                });
                const IC7parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC7.nodetype = .multi;
                IC7.parents = &.{IC7parents[IC7_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"="))
            {
                const IC7Div_clk_value = IC7DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC7Div",
                    "Else",
                    "No Extra Log",
                    "IC7Div",
                });
                IC7Div.nodetype = .div;
                IC7Div.value = IC7Div_clk_value;
                IC7Div.parents = &.{&IC7};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC7Freq_VALUEValue);
                IC7Output.limit = IC7Freq_VALUELimit;
                IC7Output.nodetype = .output;
                IC7Output.parents = &.{&IC7Div};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"="))
            {
                const IC8_clk_value = IC8CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC8",
                    "Else",
                    "No Extra Log",
                    "IC8CLKSource",
                });
                const IC8parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC8.nodetype = .multi;
                IC8.parents = &.{IC8parents[IC8_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"="))
            {
                const IC8Div_clk_value = IC8DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC8Div",
                    "Else",
                    "No Extra Log",
                    "IC8Div",
                });
                IC8Div.nodetype = .div;
                IC8Div.value = IC8Div_clk_value;
                IC8Div.parents = &.{&IC8};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC8Freq_VALUEValue);
                IC8Output.limit = IC8Freq_VALUELimit;
                IC8Output.nodetype = .output;
                IC8Output.parents = &.{&IC8Div};
            }
            if (check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"="))
            {
                const IC9_clk_value = IC9CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC9",
                    "Else",
                    "No Extra Log",
                    "IC9CLKSource",
                });
                const IC9parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC9.nodetype = .multi;
                IC9.parents = &.{IC9parents[IC9_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"="))
            {
                const IC9Div_clk_value = IC9DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC9Div",
                    "Else",
                    "No Extra Log",
                    "IC9Div",
                });
                IC9Div.nodetype = .div;
                IC9Div.value = IC9Div_clk_value;
                IC9Div.parents = &.{&IC9};
            }
            if (check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC9Freq_VALUEValue);
                IC9Output.limit = IC9Freq_VALUELimit;
                IC9Output.nodetype = .output;
                IC9Output.parents = &.{&IC9Div};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"="))
            {
                const IC10_clk_value = IC10CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC10",
                    "Else",
                    "No Extra Log",
                    "IC10CLKSource",
                });
                const IC10parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC10.nodetype = .multi;
                IC10.parents = &.{IC10parents[IC10_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"="))
            {
                const IC10Div_clk_value = IC10DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC10Div",
                    "Else",
                    "No Extra Log",
                    "IC10Div",
                });
                IC10Div.nodetype = .div;
                IC10Div.value = IC10Div_clk_value;
                IC10Div.parents = &.{&IC10};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC10Freq_VALUEValue);
                IC10Output.limit = IC10Freq_VALUELimit;
                IC10Output.nodetype = .output;
                IC10Output.parents = &.{&IC10Div};
            }

            const IC11_clk_value = IC11CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC11",
                "Else",
                "No Extra Log",
                "IC11CLKSource",
            });
            const IC11parents = [_]*const ClockNode{
                &FOUTPOSTDIV1,
                &FOUTPOSTDIV2,
                &FOUTPOSTDIV3,
                &FOUTPOSTDIV4,
            };
            IC11.nodetype = .multi;
            IC11.parents = &.{IC11parents[IC11_clk_value.get()]};

            const IC11Div_clk_value = IC11DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "IC11Div",
                "Else",
                "No Extra Log",
                "IC11Div",
            });
            IC11Div.nodetype = .div;
            IC11Div.value = IC11Div_clk_value;
            IC11Div.parents = &.{&IC11};

            std.mem.doNotOptimizeAway(IC11Freq_VALUEValue);
            IC11Output.limit = IC11Freq_VALUELimit;
            IC11Output.nodetype = .output;
            IC11Output.parents = &.{&IC11Div};
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                const IC12_clk_value = IC12CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC12",
                    "Else",
                    "No Extra Log",
                    "IC12CLKSource",
                });
                const IC12parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC12.nodetype = .multi;
                IC12.parents = &.{IC12parents[IC12_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                const IC12Div_clk_value = IC12DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC12Div",
                    "Else",
                    "No Extra Log",
                    "IC12Div",
                });
                IC12Div.nodetype = .div;
                IC12Div.value = IC12Div_clk_value;
                IC12Div.parents = &.{&IC12};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(IC12Freq_VALUEValue);
                IC12Output.limit = IC12Freq_VALUELimit;
                IC12Output.nodetype = .output;
                IC12Output.parents = &.{&IC12Div};
            }
            if (false) {
                const IC13_clk_value = IC13CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC13",
                    "Else",
                    "No Extra Log",
                    "IC13CLKSource",
                });
                const IC13parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC13.nodetype = .multi;
                IC13.parents = &.{IC13parents[IC13_clk_value.get()]};
            }
            if (false) {
                const IC13Div_clk_value = IC13DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC13Div",
                    "Else",
                    "No Extra Log",
                    "IC13Div",
                });
                IC13Div.nodetype = .div;
                IC13Div.value = IC13Div_clk_value;
                IC13Div.parents = &.{&IC13};
            }
            if (false) {
                std.mem.doNotOptimizeAway(IC13Freq_VALUEValue);
                IC13Output.limit = IC13Freq_VALUELimit;
                IC13Output.nodetype = .output;
                IC13Output.parents = &.{&IC13Div};
            }
            if (check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"="))
            {
                const IC14_clk_value = IC14CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC14",
                    "Else",
                    "No Extra Log",
                    "IC14CLKSource",
                });
                const IC14parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC14.nodetype = .multi;
                IC14.parents = &.{IC14parents[IC14_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"="))
            {
                const IC14Div_clk_value = IC14DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC14Div",
                    "Else",
                    "No Extra Log",
                    "IC14Div",
                });
                IC14Div.nodetype = .div;
                IC14Div.value = IC14Div_clk_value;
                IC14Div.parents = &.{&IC14};
            }
            if (check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=") or
                check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC14Freq_VALUEValue);
                IC14Output.limit = IC14Freq_VALUELimit;
                IC14Output.nodetype = .output;
                IC14Output.parents = &.{&IC14Div};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM1Value), EnableLPTIM1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM2Value), EnableLPTIM2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM3Value), EnableLPTIM3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM4Value), EnableLPTIM4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM5Value), EnableLPTIM5Value, .true, .@"="))
            {
                const IC15_clk_value = IC15CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC15",
                    "Else",
                    "No Extra Log",
                    "IC15CLKSource",
                });
                const IC15parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC15.nodetype = .multi;
                IC15.parents = &.{IC15parents[IC15_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM1Value), EnableLPTIM1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM2Value), EnableLPTIM2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM3Value), EnableLPTIM3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM4Value), EnableLPTIM4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM5Value), EnableLPTIM5Value, .true, .@"="))
            {
                const IC15Div_clk_value = IC15DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC15Div",
                    "Else",
                    "No Extra Log",
                    "IC15Div",
                });
                IC15Div.nodetype = .div;
                IC15Div.value = IC15Div_clk_value;
                IC15Div.parents = &.{&IC15};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM1Value), EnableLPTIM1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM2Value), EnableLPTIM2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM3Value), EnableLPTIM3Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM4Value), EnableLPTIM4Value, .true, .@"=") or
                check_ref(@TypeOf(EnableLPTIM5Value), EnableLPTIM5Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC15Freq_VALUEValue);
                IC15Output.limit = IC15Freq_VALUELimit;
                IC15Output.nodetype = .output;
                IC15Output.parents = &.{&IC15Div};
            }
            if (check_ref(@TypeOf(EnableLTDCValue), EnableLTDCValue, .true, .@"=")) {
                const IC16_clk_value = IC16CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC16",
                    "Else",
                    "No Extra Log",
                    "IC16CLKSource",
                });
                const IC16parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC16.nodetype = .multi;
                IC16.parents = &.{IC16parents[IC16_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLTDCValue), EnableLTDCValue, .true, .@"=")) {
                const IC16Div_clk_value = IC16DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC16Div",
                    "Else",
                    "No Extra Log",
                    "IC16Div",
                });
                IC16Div.nodetype = .div;
                IC16Div.value = IC16Div_clk_value;
                IC16Div.parents = &.{&IC16};
            }
            if (check_ref(@TypeOf(EnableLTDCValue), EnableLTDCValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(IC16Freq_VALUEValue);
                IC16Output.limit = IC16Freq_VALUELimit;
                IC16Output.nodetype = .output;
                IC16Output.parents = &.{&IC16Div};
            }
            if (check_ref(@TypeOf(EnableDCMIValue), EnableDCMIValue, .true, .@"=")) {
                const IC17_clk_value = IC17CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC17",
                    "Else",
                    "No Extra Log",
                    "IC17CLKSource",
                });
                const IC17parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC17.nodetype = .multi;
                IC17.parents = &.{IC17parents[IC17_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDCMIValue), EnableDCMIValue, .true, .@"=")) {
                const IC17Div_clk_value = IC17DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC17Div",
                    "Else",
                    "No Extra Log",
                    "IC17Div",
                });
                IC17Div.nodetype = .div;
                IC17Div.value = IC17Div_clk_value;
                IC17Div.parents = &.{&IC17};
            }
            if (check_ref(@TypeOf(EnableDCMIValue), EnableDCMIValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(IC17Freq_VALUEValue);
                IC17Output.limit = IC17Freq_VALUELimit;
                IC17Output.nodetype = .output;
                IC17Output.parents = &.{&IC17Div};
            }
            if (check_ref(@TypeOf(EnableCSIValue), EnableCSIValue, .true, .@"=")) {
                const IC18_clk_value = IC18CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC18",
                    "Else",
                    "No Extra Log",
                    "IC18CLKSource",
                });
                const IC18parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC18.nodetype = .multi;
                IC18.parents = &.{IC18parents[IC18_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableCSIValue), EnableCSIValue, .true, .@"=")) {
                const IC18Div_clk_value = IC18DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC18Div",
                    "Else",
                    "No Extra Log",
                    "IC18Div",
                });
                IC18Div.nodetype = .div;
                IC18Div.value = IC18Div_clk_value;
                IC18Div.parents = &.{&IC18};
            }
            if (check_ref(@TypeOf(EnableCSIValue), EnableCSIValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(IC18Freq_VALUEValue);
                IC18Output.limit = IC18Freq_VALUELimit;
                IC18Output.nodetype = .output;
                IC18Output.parents = &.{&IC18Div};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableFDCAN123Value), EnableFDCAN123Value, .true, .@"="))
            {
                const IC19_clk_value = IC19CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC19",
                    "Else",
                    "No Extra Log",
                    "IC19CLKSource",
                });
                const IC19parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC19.nodetype = .multi;
                IC19.parents = &.{IC19parents[IC19_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableFDCAN123Value), EnableFDCAN123Value, .true, .@"="))
            {
                const IC19Div_clk_value = IC19DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC19Div",
                    "Else",
                    "No Extra Log",
                    "IC19Div",
                });
                IC19Div.nodetype = .div;
                IC19Div.value = IC19Div_clk_value;
                IC19Div.parents = &.{&IC19};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableFDCAN123Value), EnableFDCAN123Value, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC19Freq_VALUEValue);
                IC19Output.limit = IC19Freq_VALUELimit;
                IC19Output.nodetype = .output;
                IC19Output.parents = &.{&IC19Div};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"="))
            {
                const IC20_clk_value = IC20CLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC20",
                    "Else",
                    "No Extra Log",
                    "IC20CLKSource",
                });
                const IC20parents = [_]*const ClockNode{
                    &FOUTPOSTDIV1,
                    &FOUTPOSTDIV2,
                    &FOUTPOSTDIV3,
                    &FOUTPOSTDIV4,
                };
                IC20.nodetype = .multi;
                IC20.parents = &.{IC20parents[IC20_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"="))
            {
                const IC20Div_clk_value = IC20DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "IC20Div",
                    "Else",
                    "No Extra Log",
                    "IC20Div",
                });
                IC20Div.nodetype = .div;
                IC20Div.value = IC20Div_clk_value;
                IC20Div.parents = &.{&IC20};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(IC20Freq_VALUEValue);
                IC20Output.limit = IC20Freq_VALUELimit;
                IC20Output.nodetype = .output;
                IC20Output.parents = &.{&IC20Div};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
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
                    &HSIDivOutput,
                    &LSEOSC,
                    &MSIRC,
                    &LSIRC,
                    &HSEOSC,
                    &IC5Output,
                    &IC10Output,
                    &SYSAClkSource,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                const MCODiv_clk_value = RCC_MCODiv1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCODiv",
                    "Else",
                    "No Extra Log",
                    "RCC_MCODiv1",
                });
                MCODiv.nodetype = .div;
                MCODiv.value = MCODiv_clk_value.get();
                MCODiv.parents = &.{&MCOMult};
            }
            if (check_ref(@TypeOf(MCO1OutPutEnableValue), MCO1OutPutEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
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
                    &HSIDivOutput,
                    &LSEOSC,
                    &MSIRC,
                    &LSIRC,
                    &HSEOSC,
                    &IC15Output,
                    &IC20Output,
                    &SYSBClkSource,
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
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=")) {
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
                    &HSIRC,
                    &MSIRC,
                    &HSEOSC,
                    &IC5Output,
                    &IC10Output,
                    &IC15Output,
                    &IC19Output,
                    &IC20Output,
                };
                CKPERSource.nodetype = .multi;
                CKPERSource.parents = &.{CKPERSourceparents[CKPERSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CKPEREnableValue), CKPEREnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CKPERFreq_ValueValue);
                CKPERoutput.nodetype = .output;
                CKPERoutput.parents = &.{&CKPERSource};
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
                    &AHBOutput,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                    &TIMGOutput,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const ADCDIV_clk_value = ADCDIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADCDIV",
                    "Else",
                    "No Extra Log",
                    "ADCDIV",
                });
                ADCDIV.nodetype = .div;
                ADCDIV.value = ADCDIV_clk_value;
                ADCDIV.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADC12Freq_ValueValue);
                ADCoutput.limit = ADC12Freq_ValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCDIV};
            }
            if (check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=")) {
                const ADFMult_clk_value = ADF1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADFMult",
                    "Else",
                    "No Extra Log",
                    "ADF1ClockSelection",
                });
                const ADFMultparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                    &TIMGOutput,
                };
                ADFMult.nodetype = .multi;
                ADFMult.parents = &.{ADFMultparents[ADFMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableADF1Value), EnableADF1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADFFreq_ValueValue);
                ADFoutput.nodetype = .output;
                ADFoutput.parents = &.{&ADFMult};
            }
            if (check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=")) {
                const MDF1Mult_clk_value = MDF1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MDF1Mult",
                    "Else",
                    "No Extra Log",
                    "MDF1ClockSelection",
                });
                const MDF1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                    &TIMGOutput,
                };
                MDF1Mult.nodetype = .multi;
                MDF1Mult.parents = &.{MDF1Multparents[MDF1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableMDF1Value), EnableMDF1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MDFFreq_ValueValue);
                MDFoutput.nodetype = .output;
                MDFoutput.parents = &.{&MDF1Mult};
            }
            if (check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=")) {
                const PSSIMult_clk_value = PSSIClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PSSIMult",
                    "Else",
                    "No Extra Log",
                    "PSSIClockSelection",
                });
                const PSSIMultparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC20Output,
                    &HSIDivOutput,
                };
                PSSIMult.nodetype = .multi;
                PSSIMult.parents = &.{PSSIMultparents[PSSIMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(PSSIEnableValue), PSSIEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(PSSIFreq_ValueValue);
                PSSIoutput.nodetype = .output;
                PSSIoutput.parents = &.{&PSSIMult};
            }
            if (check_ref(@TypeOf(EnableFDCAN123Value), EnableFDCAN123Value, .true, .@"=")) {
                const FDCANMult_clk_value = FDCANClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC19Output,
                    &HSEOSC,
                };
                FDCANMult.nodetype = .multi;
                FDCANMult.parents = &.{FDCANMultparents[FDCANMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableFDCAN123Value), EnableFDCAN123Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FDCANFreq_ValueValue);
                FDCANoutput.nodetype = .output;
                FDCANoutput.parents = &.{&FDCANMult};
            }
            if (check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=")) {
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2C1Value), EnableI2C1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=")) {
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I2C2Mult.nodetype = .multi;
                I2C2Mult.parents = &.{I2C2Multparents[I2C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2C2Value), EnableI2C2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C2Freq_ValueValue);
                I2C2output.nodetype = .output;
                I2C2output.parents = &.{&I2C2Mult};
            }
            if (check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=")) {
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2C3Value), EnableI2C3Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C3Freq_ValueValue);
                I2C3output.nodetype = .output;
                I2C3output.parents = &.{&I2C3Mult};
            }
            if (check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=")) {
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I2C4Mult.nodetype = .multi;
                I2C4Mult.parents = &.{I2C4Multparents[I2C4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2C4Value), EnableI2C4Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C4Freq_ValueValue);
                I2C4output.nodetype = .output;
                I2C4output.parents = &.{&I2C4Mult};
            }
            if (check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=")) {
                const I3C1Mult_clk_value = I3C1CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I3C1Mult.nodetype = .multi;
                I3C1Mult.parents = &.{I3C1Multparents[I3C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI3C1Value), EnableI3C1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I3C1Freq_ValueValue);
                I3C1output.nodetype = .output;
                I3C1output.parents = &.{&I3C1Mult};
            }
            if (check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"=")) {
                const I3C2Mult_clk_value = I3C2CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC10Output,
                    &IC15Output,
                    &MSIRC,
                    &HSIDivOutput,
                };
                I3C2Mult.nodetype = .multi;
                I3C2Mult.parents = &.{I3C2Multparents[I3C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI3C2Value), EnableI3C2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I3C2Freq_ValueValue);
                I3C2output.nodetype = .output;
                I3C2output.parents = &.{&I3C2Mult};
            }
            if (check_ref(@TypeOf(EnableLPTIM1Value), EnableLPTIM1Value, .true, .@"=")) {
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
                    &APB1Output,
                    &CKPERoutput,
                    &IC15Output,
                    &LSEOSC,
                    &LSIRC,
                    &TIMGOutput,
                };
                LPTIM1Mult.nodetype = .multi;
                LPTIM1Mult.parents = &.{LPTIM1Multparents[LPTIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTIM1Value), EnableLPTIM1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM1Freq_ValueValue);
                LPTIM1output.limit = LPTIM1Freq_ValueLimit;
                LPTIM1output.nodetype = .output;
                LPTIM1output.parents = &.{&LPTIM1Mult};
            }
            if (check_ref(@TypeOf(EnableLPTIM3Value), EnableLPTIM3Value, .true, .@"=")) {
                const LPTIM3Mult_clk_value = LPTIM3CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB4Output,
                    &CKPERoutput,
                    &IC15Output,
                    &LSEOSC,
                    &LSIRC,
                    &TIMGOutput,
                };
                LPTIM3Mult.nodetype = .multi;
                LPTIM3Mult.parents = &.{LPTIM3Multparents[LPTIM3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTIM3Value), EnableLPTIM3Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM3Freq_ValueValue);
                LPTIM3output.limit = LPTIM3Freq_ValueLimit;
                LPTIM3output.nodetype = .output;
                LPTIM3output.parents = &.{&LPTIM3Mult};
            }
            if (check_ref(@TypeOf(EnableLPTIM2Value), EnableLPTIM2Value, .true, .@"=")) {
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
                    &APB4Output,
                    &CKPERoutput,
                    &IC15Output,
                    &LSEOSC,
                    &LSIRC,
                    &TIMGOutput,
                };
                LPTIM2Mult.nodetype = .multi;
                LPTIM2Mult.parents = &.{LPTIM2Multparents[LPTIM2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTIM2Value), EnableLPTIM2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM2Freq_ValueValue);
                LPTIM2output.limit = LPTIM2Freq_ValueLimit;
                LPTIM2output.nodetype = .output;
                LPTIM2output.parents = &.{&LPTIM2Mult};
            }
            if (check_ref(@TypeOf(EnableLPTIM4Value), EnableLPTIM4Value, .true, .@"=")) {
                const LPTIM4Mult_clk_value = LPTIM4CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB4Output,
                    &CKPERoutput,
                    &IC15Output,
                    &LSEOSC,
                    &LSIRC,
                    &TIMGOutput,
                };
                LPTIM4Mult.nodetype = .multi;
                LPTIM4Mult.parents = &.{LPTIM4Multparents[LPTIM4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTIM4Value), EnableLPTIM4Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM4Freq_ValueValue);
                LPTIM4output.limit = LPTIM4Freq_ValueLimit;
                LPTIM4output.nodetype = .output;
                LPTIM4output.parents = &.{&LPTIM4Mult};
            }
            if (check_ref(@TypeOf(EnableLPTIM5Value), EnableLPTIM5Value, .true, .@"=")) {
                const LPTIM5Mult_clk_value = LPTIM5CLockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                    &APB4Output,
                    &CKPERoutput,
                    &IC15Output,
                    &LSEOSC,
                    &LSIRC,
                    &TIMGOutput,
                };
                LPTIM5Mult.nodetype = .multi;
                LPTIM5Mult.parents = &.{LPTIM5Multparents[LPTIM5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTIM5Value), EnableLPTIM5Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIM5Freq_ValueValue);
                LPTIM5output.limit = LPTIM5Freq_ValueLimit;
                LPTIM5output.nodetype = .output;
                LPTIM5output.parents = &.{&LPTIM5Mult};
            }
            if (check_ref(@TypeOf(EnableLTDCValue), EnableLTDCValue, .true, .@"=")) {
                const LTDCMult_clk_value = LTDCClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LTDCMult",
                    "Else",
                    "No Extra Log",
                    "LTDCClockSelection",
                });
                const LTDCMultparents = [_]*const ClockNode{
                    &APB5Output,
                    &CKPERoutput,
                    &IC16Output,
                    &HSIDivOutput,
                };
                LTDCMult.nodetype = .multi;
                LTDCMult.parents = &.{LTDCMultparents[LTDCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLTDCValue), EnableLTDCValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LTDCFreq_ValueValue);
                LTDCoutput.nodetype = .output;
                LTDCoutput.parents = &.{&LTDCMult};
            }
            if (check_ref(@TypeOf(EnableDCMIValue), EnableDCMIValue, .true, .@"=")) {
                const DCMIPPMult_clk_value = DCMIPPClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DCMIPPMult",
                    "Else",
                    "No Extra Log",
                    "DCMIPPClockSelection",
                });
                const DCMIPPMultparents = [_]*const ClockNode{
                    &APB5Output,
                    &CKPERoutput,
                    &IC17Output,
                    &HSIDivOutput,
                };
                DCMIPPMult.nodetype = .multi;
                DCMIPPMult.parents = &.{DCMIPPMultparents[DCMIPPMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDCMIValue), EnableDCMIValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DCMIPPFreq_ValueValue);
                DCMIPPoutput.nodetype = .output;
                DCMIPPoutput.parents = &.{&DCMIPPMult};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                const FMCMult_clk_value = FMCClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FMCMult",
                    "Else",
                    "No Extra Log",
                    "FMCClockSelection",
                });
                const FMCMultparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC3Output,
                    &IC4Output,
                };
                FMCMult.nodetype = .multi;
                FMCMult.parents = &.{FMCMultparents[FMCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(FMCEnableValue), FMCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FMCFreq_ValueValue);
                FMCoutput.nodetype = .output;
                FMCoutput.parents = &.{&FMCMult};
            }
            if (check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=")) {
                const SAI1Mult_clk_value = SAI1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1Mult",
                    "Else",
                    "No Extra Log",
                    "SAI1ClockSelection",
                });
                const SAI1Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                    &SPDIFRX1Mult,
                };
                SAI1Mult.nodetype = .multi;
                SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAI1Value), EnableSAI1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1Freq_ValueValue);
                SAI1output.limit = SAI1Freq_ValueLimit;
                SAI1output.nodetype = .output;
                SAI1output.parents = &.{&SAI1Mult};
            }
            if (check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=")) {
                const SAI2Mult_clk_value = SAI2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI2Mult",
                    "Else",
                    "No Extra Log",
                    "SAI2ClockSelection",
                });
                const SAI2Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                    &SPDIFRX1Mult,
                };
                SAI2Mult.nodetype = .multi;
                SAI2Mult.parents = &.{SAI2Multparents[SAI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAI2Value), EnableSAI2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI2Freq_ValueValue);
                SAI2output.limit = SAI2Freq_ValueLimit;
                SAI2output.nodetype = .output;
                SAI2output.parents = &.{&SAI2Mult};
            }
            if (check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=")) {
                const USART1Mult_clk_value = USART1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART1Mult",
                    "Else",
                    "No Extra Log",
                    "USART1ClockSelection",
                });
                const USART1Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSART1Value), EnableUSART1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1output.limit = USART1Freq_ValueLimit;
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=")) {
                const USART2Mult_clk_value = USART2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART2Mult",
                    "Else",
                    "No Extra Log",
                    "USART2ClockSelection",
                });
                const USART2Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                USART2Mult.nodetype = .multi;
                USART2Mult.parents = &.{USART2Multparents[USART2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSART2Value), EnableUSART2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART2Freq_ValueValue);
                USART2output.limit = USART2Freq_ValueLimit;
                USART2output.nodetype = .output;
                USART2output.parents = &.{&USART2Mult};
            }
            if (check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=")) {
                const USART3Mult_clk_value = USART3ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART3Mult",
                    "Else",
                    "No Extra Log",
                    "USART3ClockSelection",
                });
                const USART3Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                USART3Mult.nodetype = .multi;
                USART3Mult.parents = &.{USART3Multparents[USART3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSART3Value), EnableUSART3Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART3Freq_ValueValue);
                USART3output.limit = USART3Freq_ValueLimit;
                USART3output.nodetype = .output;
                USART3output.parents = &.{&USART3Mult};
            }
            if (check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=")) {
                const UART4Mult_clk_value = UART4ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART4Mult",
                    "Else",
                    "No Extra Log",
                    "UART4ClockSelection",
                });
                const UART4Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                UART4Mult.nodetype = .multi;
                UART4Mult.parents = &.{UART4Multparents[UART4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUART4Value), EnableUART4Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART4Freq_ValueValue);
                UART4output.limit = UART4Freq_ValueLimit;
                UART4output.nodetype = .output;
                UART4output.parents = &.{&UART4Mult};
            }
            if (check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=")) {
                const UART5Mult_clk_value = UART5ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART5Mult",
                    "Else",
                    "No Extra Log",
                    "UART5ClockSelection",
                });
                const UART5Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                UART5Mult.nodetype = .multi;
                UART5Mult.parents = &.{UART5Multparents[UART5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUART5Value), EnableUART5Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART5Freq_ValueValue);
                UART5output.limit = UART5Freq_ValueLimit;
                UART5output.nodetype = .output;
                UART5output.parents = &.{&UART5Mult};
            }
            if (check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=")) {
                const USART6Mult_clk_value = USART6ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART6Mult",
                    "Else",
                    "No Extra Log",
                    "USART6ClockSelection",
                });
                const USART6Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                USART6Mult.nodetype = .multi;
                USART6Mult.parents = &.{USART6Multparents[USART6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSART6Value), EnableUSART6Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART6Freq_ValueValue);
                USART6output.limit = USART6Freq_ValueLimit;
                USART6output.nodetype = .output;
                USART6output.parents = &.{&USART6Mult};
            }
            if (check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=")) {
                const UART7Mult_clk_value = UART7ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART7Mult",
                    "Else",
                    "No Extra Log",
                    "UART7ClockSelection",
                });
                const UART7Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                UART7Mult.nodetype = .multi;
                UART7Mult.parents = &.{UART7Multparents[UART7Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUART7Value), EnableUART7Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART7Freq_ValueValue);
                UART7output.limit = UART7Freq_ValueLimit;
                UART7output.nodetype = .output;
                UART7output.parents = &.{&UART7Mult};
            }
            if (check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=")) {
                const UART8Mult_clk_value = UART8ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART8Mult",
                    "Else",
                    "No Extra Log",
                    "UART8ClockSelection",
                });
                const UART8Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                UART8Mult.nodetype = .multi;
                UART8Mult.parents = &.{UART8Multparents[UART8Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUART8Value), EnableUART8Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART8Freq_ValueValue);
                UART8output.limit = UART8Freq_ValueLimit;
                UART8output.nodetype = .output;
                UART8output.parents = &.{&UART8Mult};
            }
            if (check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"=")) {
                const UART9Mult_clk_value = UART9ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART9Mult",
                    "Else",
                    "No Extra Log",
                    "UART9ClockSelection",
                });
                const UART9Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                UART9Mult.nodetype = .multi;
                UART9Mult.parents = &.{UART9Multparents[UART9Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUART9Value), EnableUART9Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(UART9Freq_ValueValue);
                UART9output.limit = UART9Freq_ValueLimit;
                UART9output.nodetype = .output;
                UART9output.parents = &.{&UART9Mult};
            }
            if (check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=")) {
                const LPUART1Mult_clk_value = LPUART1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUART1Mult",
                    "Else",
                    "No Extra Log",
                    "LPUART1ClockSelection",
                });
                const LPUART1Multparents = [_]*const ClockNode{
                    &APB4Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                LPUART1Mult.nodetype = .multi;
                LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPUART1Value), EnableLPUART1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUART1Freq_ValueValue);
                LPUART1output.limit = LPUART1Freq_ValueLimit;
                LPUART1output.nodetype = .output;
                LPUART1output.parents = &.{&LPUART1Mult};
            }
            if (check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=")) {
                const USART10Mult_clk_value = USART10ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART10Mult",
                    "Else",
                    "No Extra Log",
                    "USART10ClockSelection",
                });
                const USART10Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &LSEOSC,
                    &MSIRC,
                    &HSIDivOutput,
                };
                USART10Mult.nodetype = .multi;
                USART10Mult.parents = &.{USART10Multparents[USART10Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSART10Value), EnableUSART10Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART10Freq_ValueValue);
                USART10output.limit = USART10Freq_ValueLimit;
                USART10output.nodetype = .output;
                USART10output.parents = &.{&USART10Mult};
            }
            if (check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=")) {
                const SPI1Mult_clk_value = SPI1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI1Mult",
                    "Else",
                    "No Extra Log",
                    "SPI1ClockSelection",
                });
                const SPI1Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC8Output,
                    &IC9Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                };
                SPI1Mult.nodetype = .multi;
                SPI1Mult.parents = &.{SPI1Multparents[SPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI1Value), EnableSPI1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI1Freq_ValueValue);
                SPI1output.limit = SPI1Freq_ValueLimit;
                SPI1output.nodetype = .output;
                SPI1output.parents = &.{&SPI1Mult};
            }
            if (check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=")) {
                const SPI2Mult_clk_value = SPI2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI2Mult",
                    "Else",
                    "No Extra Log",
                    "SPI2ClockSelection",
                });
                const SPI2Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC8Output,
                    &IC9Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                };
                SPI2Mult.nodetype = .multi;
                SPI2Mult.parents = &.{SPI2Multparents[SPI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI2Value), EnableSPI2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI2Freq_ValueValue);
                SPI2output.limit = SPI2Freq_ValueLimit;
                SPI2output.nodetype = .output;
                SPI2output.parents = &.{&SPI2Mult};
            }
            if (check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=")) {
                const SPI3Mult_clk_value = SPI3ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI3Mult",
                    "Else",
                    "No Extra Log",
                    "SPI3ClockSelection",
                });
                const SPI3Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC8Output,
                    &IC9Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                };
                SPI3Mult.nodetype = .multi;
                SPI3Mult.parents = &.{SPI3Multparents[SPI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI3Value), EnableSPI3Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI3Freq_ValueValue);
                SPI3output.limit = SPI3Freq_ValueLimit;
                SPI3output.nodetype = .output;
                SPI3output.parents = &.{&SPI3Mult};
            }
            if (check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=")) {
                const SPI4Mult_clk_value = SPI4ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI4Mult",
                    "Else",
                    "No Extra Log",
                    "SPI4ClockSelection",
                });
                const SPI4Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &HSEOSC,
                };
                SPI4Mult.nodetype = .multi;
                SPI4Mult.parents = &.{SPI4Multparents[SPI4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI4Value), EnableSPI4Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI4Freq_ValueValue);
                SPI4output.limit = SPI4Freq_ValueLimit;
                SPI4output.nodetype = .output;
                SPI4output.parents = &.{&SPI4Mult};
            }
            if (check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"=")) {
                const SPI5Mult_clk_value = SPI5ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI5Mult",
                    "Else",
                    "No Extra Log",
                    "SPI5ClockSelection",
                });
                const SPI5Multparents = [_]*const ClockNode{
                    &APB2Output,
                    &CKPERoutput,
                    &IC9Output,
                    &IC14Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &HSEOSC,
                };
                SPI5Mult.nodetype = .multi;
                SPI5Mult.parents = &.{SPI5Multparents[SPI5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI5Value), EnableSPI5Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI5Freq_ValueValue);
                SPI5output.limit = SPI5Freq_ValueLimit;
                SPI5output.nodetype = .output;
                SPI5output.parents = &.{&SPI5Mult};
            }
            if (check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"=")) {
                const SPI6Mult_clk_value = SPI6ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI6Mult",
                    "Else",
                    "No Extra Log",
                    "SPI6ClockSelection",
                });
                const SPI6Multparents = [_]*const ClockNode{
                    &APB4Output,
                    &CKPERoutput,
                    &IC8Output,
                    &IC9Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                };
                SPI6Mult.nodetype = .multi;
                SPI6Mult.parents = &.{SPI6Multparents[SPI6Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPI6Value), EnableSPI6Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPI6Freq_ValueValue);
                SPI6output.limit = SPI6Freq_ValueLimit;
                SPI6output.nodetype = .output;
                SPI6output.parents = &.{&SPI6Mult};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=")) {
                const XSPI1Mult_clk_value = XSPI1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "XSPI1Mult",
                    "Else",
                    "No Extra Log",
                    "XSPI1ClockSelection",
                });
                const XSPI1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC3Output,
                    &IC4Output,
                };
                XSPI1Mult.nodetype = .multi;
                XSPI1Mult.parents = &.{XSPI1Multparents[XSPI1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(XSPI1EnableValue), XSPI1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(XSPI1Freq_ValueValue);
                XSPI1output.nodetype = .output;
                XSPI1output.parents = &.{&XSPI1Mult};
            }
            if (check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=")) {
                const XSPI2Mult_clk_value = XSPI2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "XSPI2Mult",
                    "Else",
                    "No Extra Log",
                    "XSPI2ClockSelection",
                });
                const XSPI2Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC3Output,
                    &IC4Output,
                };
                XSPI2Mult.nodetype = .multi;
                XSPI2Mult.parents = &.{XSPI2Multparents[XSPI2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(XSPI2EnableValue), XSPI2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(XSPI2Freq_ValueValue);
                XSPI2output.nodetype = .output;
                XSPI2output.parents = &.{&XSPI2Mult};
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=")) {
                const OTGHS1Mult_clk_value = OTGHS1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "OTGHS1Mult",
                    "Else",
                    "No Extra Log",
                    "OTGHS1ClockSelection",
                });
                const OTGHS1Multparents = [_]*const ClockNode{
                    &OTGPHY1output,
                    &HSEOSCDIV,
                };
                OTGHS1Mult.nodetype = .multi;
                OTGHS1Mult.parents = &.{OTGHS1Multparents[OTGHS1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OTGHS1Freq_ValueValue);
                OTGHS1output.limit = OTGHS1Freq_ValueLimit;
                OTGHS1output.nodetype = .output;
                OTGHS1output.parents = &.{&OTGHS1Mult};
            }
            if (check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=")) {
                const OTGHS2Mult_clk_value = OTGHS2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "OTGHS2Mult",
                    "Else",
                    "No Extra Log",
                    "OTGHS2ClockSelection",
                });
                const OTGHS2Multparents = [_]*const ClockNode{
                    &OTGPHY2output,
                    &HSEOSCDIV,
                };
                OTGHS2Mult.nodetype = .multi;
                OTGHS2Mult.parents = &.{OTGHS2Multparents[OTGHS2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OTGHS2Freq_ValueValue);
                OTGHS2output.limit = OTGHS2Freq_ValueLimit;
                OTGHS2output.nodetype = .output;
                OTGHS2output.parents = &.{&OTGHS2Mult};
            }
            if (check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=")) {
                const XSPI3Mult_clk_value = XSPI3ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "XSPI3Mult",
                    "Else",
                    "No Extra Log",
                    "XSPI3ClockSelection",
                });
                const XSPI3Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC3Output,
                    &IC4Output,
                };
                XSPI3Mult.nodetype = .multi;
                XSPI3Mult.parents = &.{XSPI3Multparents[XSPI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(XSPI3EnableValue), XSPI3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(XSPI3Freq_ValueValue);
                XSPI3output.nodetype = .output;
                XSPI3output.parents = &.{&XSPI3Mult};
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=")) {
                const OTGPHY1Mult_clk_value = OTGPHY1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "OTGPHY1Mult",
                    "Else",
                    "No Extra Log",
                    "OTGPHY1ClockSelection",
                });
                const OTGPHY1Multparents = [_]*const ClockNode{
                    &HSEOSCDIV,
                    &CKPERoutput,
                    &IC15Output,
                    &HSEDIV,
                };
                OTGPHY1Mult.nodetype = .multi;
                OTGPHY1Mult.parents = &.{OTGPHY1Multparents[OTGPHY1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OTG1EnableValue), OTG1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OTGPHY1Freq_ValueValue);
                OTGPHY1output.nodetype = .output;
                OTGPHY1output.parents = &.{&OTGPHY1Mult};
            }
            if (check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=")) {
                const OTGPHY2Mult_clk_value = OTGPHY2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "OTGPHY2Mult",
                    "Else",
                    "No Extra Log",
                    "OTGPHY2ClockSelection",
                });
                const OTGPHY2Multparents = [_]*const ClockNode{
                    &HSEOSCDIV,
                    &CKPERoutput,
                    &IC15Output,
                    &HSEDIV,
                };
                OTGPHY2Mult.nodetype = .multi;
                OTGPHY2Mult.parents = &.{OTGPHY2Multparents[OTGPHY2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(OTG2EnableValue), OTG2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(OTGPHY2Freq_ValueValue);
                OTGPHY2output.nodetype = .output;
                OTGPHY2output.parents = &.{&OTGPHY2Mult};
            }
            if (check_ref(@TypeOf(SDMMC1EnableValue), SDMMC1EnableValue, .true, .@"=")) {
                const SDMMC1Mult_clk_value = SDMMC1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC1Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC1ClockSelection",
                });
                const SDMMC1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC4Output,
                    &IC5Output,
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
                const SDMMC2Mult_clk_value = SDMMC2ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDMMC2Mult",
                    "Else",
                    "No Extra Log",
                    "SDMMC2ClockSelection",
                });
                const SDMMC2Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC4Output,
                    &IC5Output,
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
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                const ETH1Mult_clk_value = ETH1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ETH1Mult",
                    "Else",
                    "No Extra Log",
                    "ETH1ClockSelection",
                });
                const ETH1Multparents = [_]*const ClockNode{
                    &AHBOutput,
                    &CKPERoutput,
                    &IC12Output,
                    &HSEOSC,
                };
                ETH1Mult.nodetype = .multi;
                ETH1Mult.parents = &.{ETH1Multparents[ETH1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ETH1EnableValue), ETH1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ETH1Freq_ValueValue);
                ETH1output.nodetype = .output;
                ETH1output.parents = &.{&ETH1Mult};
            }
            if (check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"=")) {
                const SPDIFRX1Mult_clk_value = SPDIFRX1ClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPDIFRX1Mult",
                    "Else",
                    "No Extra Log",
                    "SPDIFRX1ClockSelection",
                });
                const SPDIFRX1Multparents = [_]*const ClockNode{
                    &APB1Output,
                    &CKPERoutput,
                    &IC7Output,
                    &IC8Output,
                    &MSIRC,
                    &HSIDivOutput,
                    &I2S_CKIN,
                };
                SPDIFRX1Mult.nodetype = .multi;
                SPDIFRX1Mult.parents = &.{SPDIFRX1Multparents[SPDIFRX1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPDIFRXValue), EnableSPDIFRXValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SPDIFRX1Freq_ValueValue);
                SPDIFRX1output.limit = SPDIFRX1Freq_ValueLimit;
                SPDIFRX1output.nodetype = .output;
                SPDIFRX1output.parents = &.{&SPDIFRX1Mult};
            }

            const SYSBClkSource_clk_value = SYSBCLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SYSBClkSource",
                "Else",
                "No Extra Log",
                "SYSBCLKSource",
            });
            const SYSBClkSourceparents = [_]*const ClockNode{
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &IC2Output,
            };
            SYSBClkSource.nodetype = .multi;
            SYSBClkSource.parents = &.{SYSBClkSourceparents[SYSBClkSource_clk_value.get()]};

            const SYSCClkSource_clk_value = SYSCCLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SYSCClkSource",
                "Else",
                "No Extra Log",
                "SYSCCLKSource",
            });
            const SYSCClkSourceparents = [_]*const ClockNode{
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &IC6Output,
            };
            SYSCClkSource.nodetype = .multi;
            SYSCClkSource.parents = &.{SYSCClkSourceparents[SYSCClkSource_clk_value.get()]};

            const SYSDClkSource_clk_value = SYSDCLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SYSDClkSource",
                "Else",
                "No Extra Log",
                "SYSDCLKSource",
            });
            const SYSDClkSourceparents = [_]*const ClockNode{
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &IC11Output,
            };
            SYSDClkSource.nodetype = .multi;
            SYSDClkSource.parents = &.{SYSDClkSourceparents[SYSDClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSBCLKFreq_VALUEValue);
            SYSBCLKOutput.limit = SYSBCLKFreq_VALUELimit;
            SYSBCLKOutput.nodetype = .output;
            SYSBCLKOutput.parents = &.{&SYSBClkSource};

            std.mem.doNotOptimizeAway(SYSCCLKFreq_VALUEValue);
            SYSCCLKOutput.limit = SYSCCLKFreq_VALUELimit;
            SYSCCLKOutput.nodetype = .output;
            SYSCCLKOutput.parents = &.{&SYSCClkSource};

            std.mem.doNotOptimizeAway(SYSDCLKFreq_VALUEValue);
            SYSDCLKOutput.limit = SYSDCLKFreq_VALUELimit;
            SYSDCLKOutput.nodetype = .output;
            SYSDCLKOutput.parents = &.{&SYSDClkSource};

            const SYSAClkSource_clk_value = CPUCLKSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SYSAClkSource",
                "Else",
                "No Extra Log",
                "CPUCLKSource",
            });
            const SYSAClkSourceparents = [_]*const ClockNode{
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &IC1Output,
            };
            SYSAClkSource.nodetype = .multi;
            SYSAClkSource.parents = &.{SYSAClkSourceparents[SYSAClkSource_clk_value.get()]};

            const TPIUPrescaler_clk_value = TPIUPrescalerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TPIUPrescaler",
                "Else",
                "No Extra Log",
                "TPIUPrescaler",
            });
            TPIUPrescaler.nodetype = .div;
            TPIUPrescaler.value = TPIUPrescaler_clk_value.get();
            TPIUPrescaler.parents = &.{&SYSAClkSource};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            TPIUOutput.nodetype = .output;
            TPIUOutput.parents = &.{&TPIUPrescaler};

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
            CortexPrescaler.parents = &.{&SYSAClkSource};

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

            std.mem.doNotOptimizeAway(CpuClockFreq_ValueValue);
            CpuClockOutput.limit = CpuClockFreq_ValueLimit;
            CpuClockOutput.nodetype = .output;
            CpuClockOutput.parents = &.{&SYSAClkSource};

            std.mem.doNotOptimizeAway(AXIClockFreq_ValueValue);
            AXIClockOutput.limit = AXIClockFreq_ValueLimit;
            AXIClockOutput.nodetype = .output;
            AXIClockOutput.parents = &.{&SYSBClkSource};

            const HPREDiv_clk_value = HPRE_DivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HPREDiv",
                "Else",
                "No Extra Log",
                "HPRE_Div",
            });
            HPREDiv.nodetype = .div;
            HPREDiv.value = HPREDiv_clk_value.get();
            HPREDiv.parents = &.{&SYSBCLKOutput};

            const APB4DIV_clk_value = APB4DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            APB4DIV.parents = &.{&HPREDiv};

            std.mem.doNotOptimizeAway(APB4Freq_ValueValue);
            APB4Output.limit = APB4Freq_ValueLimit;
            APB4Output.nodetype = .output;
            APB4Output.parents = &.{&APB4DIV};

            const APB5DIV_clk_value = APB5DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            APB5DIV.parents = &.{&HPREDiv};

            std.mem.doNotOptimizeAway(APB5Freq_ValueValue);
            APB5Output.limit = APB5Freq_ValueLimit;
            APB5Output.nodetype = .output;
            APB5Output.parents = &.{&APB5DIV};

            const TIMGDIV_clk_value = TIMGDIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TIMGDIV",
                "Else",
                "No Extra Log",
                "TIMGDIV",
            });
            TIMGDIV.nodetype = .div;
            TIMGDIV.value = TIMGDIV_clk_value.get();
            TIMGDIV.parents = &.{&SYSBCLKOutput};

            std.mem.doNotOptimizeAway(TIMGFreq_ValueValue);
            TIMGOutput.limit = TIMGFreq_ValueLimit;
            TIMGOutput.nodetype = .output;
            TIMGOutput.parents = &.{&TIMGDIV};

            const APB1DIV_clk_value = APB1DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            APB1DIV.parents = &.{&HPREDiv};

            std.mem.doNotOptimizeAway(AHB1234Freq_ValueValue);
            AHBOutput.limit = AHB1234Freq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&HPREDiv};

            std.mem.doNotOptimizeAway(APB1Freq_ValueValue);
            APB1Output.limit = APB1Freq_ValueLimit;
            APB1Output.nodetype = .output;
            APB1Output.parents = &.{&APB1DIV};

            const APB2DIV_clk_value = APB2DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
            APB2DIV.parents = &.{&HPREDiv};

            std.mem.doNotOptimizeAway(APB2Freq_ValueValue);
            APB2Output.limit = APB2Freq_ValueLimit;
            APB2Output.nodetype = .output;
            APB2Output.parents = &.{&APB2DIV};

            const PLL1Source_clk_value = PLL1SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL1Source",
                "Else",
                "No Extra Log",
                "PLL1Source",
            });
            const PLL1Sourceparents = [_]*const ClockNode{
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &I2S_CKIN,
            };
            PLL1Source.nodetype = .multi;
            PLL1Source.parents = &.{PLL1Sourceparents[PLL1Source_clk_value.get()]};

            const FREFDIV1_clk_value = FREFDIV1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FREFDIV1",
                "Else",
                "No Extra Log",
                "FREFDIV1",
            });
            FREFDIV1.nodetype = .div;
            FREFDIV1.value = FREFDIV1_clk_value;
            FREFDIV1.parents = &.{&PLL1Source};

            const PLL2Source_clk_value = PLL2SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &I2S_CKIN,
            };
            PLL2Source.nodetype = .multi;
            PLL2Source.parents = &.{PLL2Sourceparents[PLL2Source_clk_value.get()]};

            const FREFDIV2_clk_value = FREFDIV2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FREFDIV2",
                "Else",
                "No Extra Log",
                "FREFDIV2",
            });
            FREFDIV2.nodetype = .div;
            FREFDIV2.value = FREFDIV2_clk_value;
            FREFDIV2.parents = &.{&PLL2Source};

            const PLL3Source_clk_value = PLL3SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &I2S_CKIN,
            };
            PLL3Source.nodetype = .multi;
            PLL3Source.parents = &.{PLL3Sourceparents[PLL3Source_clk_value.get()]};

            const FREFDIV3_clk_value = FREFDIV3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FREFDIV3",
                "Else",
                "No Extra Log",
                "FREFDIV3",
            });
            FREFDIV3.nodetype = .div;
            FREFDIV3.value = FREFDIV3_clk_value;
            FREFDIV3.parents = &.{&PLL3Source};

            const PLL4Source_clk_value = PLL4SourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                &HSIRC,
                &MSIRC,
                &HSEOSC,
                &I2S_CKIN,
            };
            PLL4Source.nodetype = .multi;
            PLL4Source.parents = &.{PLL4Sourceparents[PLL4Source_clk_value.get()]};

            const FREFDIV4_clk_value = FREFDIV4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FREFDIV4",
                "Else",
                "No Extra Log",
                "FREFDIV4",
            });
            FREFDIV4.nodetype = .div;
            FREFDIV4.value = FREFDIV4_clk_value;
            FREFDIV4.parents = &.{&PLL4Source};

            const FBDIV1_clk_value = FBDIV1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FBDIV1",
                "Else",
                "No Extra Log",
                "FBDIV1",
            });
            FBDIV1.nodetype = .mul;
            FBDIV1.value = FBDIV1_clk_value;
            FBDIV1.parents = &.{&FREFDIV1};

            const PLL1FRACV_clk_value = PLL1FRACVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const POSTDIV1_1_clk_value = POSTDIV1_1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV1_1",
                "Else",
                "No Extra Log",
                "POSTDIV1_1",
            });
            POSTDIV1_1.nodetype = .div;
            POSTDIV1_1.value = POSTDIV1_1_clk_value;
            POSTDIV1_1.parents = &.{&FBDIV1};

            const POSTDIV2_1_clk_value = POSTDIV2_1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV2_1",
                "Else",
                "No Extra Log",
                "POSTDIV2_1",
            });
            POSTDIV2_1.nodetype = .div;
            POSTDIV2_1.value = POSTDIV2_1_clk_value;
            POSTDIV2_1.parents = &.{&POSTDIV1_1};

            std.mem.doNotOptimizeAway(FOUTPOSTDIV1Freq_ValueValue);
            FOUTPOSTDIV1.limit = FOUTPOSTDIV1Freq_ValueLimit;
            FOUTPOSTDIV1.nodetype = .output;
            FOUTPOSTDIV1.parents = &.{&POSTDIV2_1};

            const FBDIV2_clk_value = FBDIV2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FBDIV2",
                "Else",
                "No Extra Log",
                "FBDIV2",
            });
            FBDIV2.nodetype = .mulfrac;
            FBDIV2.value = FBDIV2_clk_value;
            FBDIV2.parents = &.{ &FREFDIV2, &PLL2FRACV };

            const PLL2FRACV_clk_value = PLL2FRACVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const POSTDIV1_2_clk_value = POSTDIV1_2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV1_2",
                "Else",
                "No Extra Log",
                "POSTDIV1_2",
            });
            POSTDIV1_2.nodetype = .div;
            POSTDIV1_2.value = POSTDIV1_2_clk_value;
            POSTDIV1_2.parents = &.{&FBDIV2};

            const POSTDIV2_2_clk_value = POSTDIV2_2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV2_2",
                "Else",
                "No Extra Log",
                "POSTDIV2_2",
            });
            POSTDIV2_2.nodetype = .div;
            POSTDIV2_2.value = POSTDIV2_2_clk_value;
            POSTDIV2_2.parents = &.{&POSTDIV1_2};

            std.mem.doNotOptimizeAway(FOUTPOSTDIV2Freq_ValueValue);
            FOUTPOSTDIV2.limit = FOUTPOSTDIV2Freq_ValueLimit;
            FOUTPOSTDIV2.nodetype = .output;
            FOUTPOSTDIV2.parents = &.{&POSTDIV2_2};

            const FBDIV3_clk_value = FBDIV3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FBDIV3",
                "Else",
                "No Extra Log",
                "FBDIV3",
            });
            FBDIV3.nodetype = .mulfrac;
            FBDIV3.value = FBDIV3_clk_value;
            FBDIV3.parents = &.{ &FREFDIV3, &PLL3FRACV };

            const PLL3FRACV_clk_value = PLL3FRACVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const POSTDIV1_3_clk_value = POSTDIV1_3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV1_3",
                "Else",
                "No Extra Log",
                "POSTDIV1_3",
            });
            POSTDIV1_3.nodetype = .div;
            POSTDIV1_3.value = POSTDIV1_3_clk_value;
            POSTDIV1_3.parents = &.{&FBDIV3};

            const POSTDIV2_3_clk_value = POSTDIV2_3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV2_3",
                "Else",
                "No Extra Log",
                "POSTDIV2_3",
            });
            POSTDIV2_3.nodetype = .div;
            POSTDIV2_3.value = POSTDIV2_3_clk_value;
            POSTDIV2_3.parents = &.{&POSTDIV1_3};

            std.mem.doNotOptimizeAway(FOUTPOSTDIV3Freq_ValueValue);
            FOUTPOSTDIV3.limit = FOUTPOSTDIV3Freq_ValueLimit;
            FOUTPOSTDIV3.nodetype = .output;
            FOUTPOSTDIV3.parents = &.{&POSTDIV2_3};

            const FBDIV4_clk_value = FBDIV4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "FBDIV4",
                "Else",
                "No Extra Log",
                "FBDIV4",
            });
            FBDIV4.nodetype = .mulfrac;
            FBDIV4.value = FBDIV4_clk_value;
            FBDIV4.parents = &.{ &FREFDIV4, &PLL4FRACV };

            const PLL4FRACV_clk_value = PLL4FRACVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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

            const POSTDIV1_4_clk_value = POSTDIV1_4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV1_4",
                "Else",
                "No Extra Log",
                "POSTDIV1_4",
            });
            POSTDIV1_4.nodetype = .div;
            POSTDIV1_4.value = POSTDIV1_4_clk_value;
            POSTDIV1_4.parents = &.{&FBDIV4};

            const POSTDIV2_4_clk_value = POSTDIV2_4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "POSTDIV2_4",
                "Else",
                "No Extra Log",
                "POSTDIV2_4",
            });
            POSTDIV2_4.nodetype = .div;
            POSTDIV2_4.value = POSTDIV2_4_clk_value;
            POSTDIV2_4.parents = &.{&POSTDIV1_4};

            std.mem.doNotOptimizeAway(FOUTPOSTDIV4Freq_ValueValue);
            FOUTPOSTDIV4.limit = FOUTPOSTDIV4Freq_ValueLimit;
            FOUTPOSTDIV4.nodetype = .output;
            FOUTPOSTDIV4.parents = &.{&POSTDIV2_4};
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
                HSERTCDevisor.value = HSERTCDevisor_clk_value;
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
                RTCOutput.limit = RTCFreq_ValueLimit;
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }

            out.HSIRC = try HSIRC.get_output();
            out.HSIDiv = try HSIDiv.get_output();
            out.HSIDivOutput = try HSIDivOutput.get_output();
            out.HSIDiv4 = try HSIDiv4.get_output();
            out.UCPDOutput = try UCPDOutput.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.HSEOSCDIV = try HSEOSCDIV.get_output();
            out.HSEDIV = try HSEDIV.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.IC1 = try IC1.get_output();
            out.IC1Div = try IC1Div.get_output();
            out.IC1Output = try IC1Output.get_output();
            out.IC2 = try IC2.get_output();
            out.IC2Div = try IC2Div.get_output();
            out.IC2Output = try IC2Output.get_output();
            out.IC3 = try IC3.get_output();
            out.IC3Div = try IC3Div.get_output();
            out.IC3Output = try IC3Output.get_output();
            out.IC4 = try IC4.get_output();
            out.IC4Div = try IC4Div.get_output();
            out.IC4Output = try IC4Output.get_output();
            out.IC5 = try IC5.get_output();
            out.IC5Div = try IC5Div.get_output();
            out.IC5Output = try IC5Output.get_output();
            out.IC6 = try IC6.get_output();
            out.IC6Div = try IC6Div.get_output();
            out.IC6Output = try IC6Output.get_output();
            out.IC7 = try IC7.get_output();
            out.IC7Div = try IC7Div.get_output();
            out.IC7Output = try IC7Output.get_output();
            out.IC8 = try IC8.get_output();
            out.IC8Div = try IC8Div.get_output();
            out.IC8Output = try IC8Output.get_output();
            out.IC9 = try IC9.get_output();
            out.IC9Div = try IC9Div.get_output();
            out.IC9Output = try IC9Output.get_output();
            out.IC10 = try IC10.get_output();
            out.IC10Div = try IC10Div.get_output();
            out.IC10Output = try IC10Output.get_output();
            out.IC11 = try IC11.get_output();
            out.IC11Div = try IC11Div.get_output();
            out.IC11Output = try IC11Output.get_output();
            out.IC12 = try IC12.get_output();
            out.IC12Div = try IC12Div.get_output();
            out.IC12Output = try IC12Output.get_output();
            out.IC13 = try IC13.get_output();
            out.IC13Div = try IC13Div.get_output();
            out.IC13Output = try IC13Output.get_output();
            out.IC14 = try IC14.get_output();
            out.IC14Div = try IC14Div.get_output();
            out.IC14Output = try IC14Output.get_output();
            out.IC15 = try IC15.get_output();
            out.IC15Div = try IC15Div.get_output();
            out.IC15Output = try IC15Output.get_output();
            out.IC16 = try IC16.get_output();
            out.IC16Div = try IC16Div.get_output();
            out.IC16Output = try IC16Output.get_output();
            out.IC17 = try IC17.get_output();
            out.IC17Div = try IC17Div.get_output();
            out.IC17Output = try IC17Output.get_output();
            out.IC18 = try IC18.get_output();
            out.IC18Div = try IC18Div.get_output();
            out.IC18Output = try IC18Output.get_output();
            out.IC19 = try IC19.get_output();
            out.IC19Div = try IC19Div.get_output();
            out.IC19Output = try IC19Output.get_output();
            out.IC20 = try IC20.get_output();
            out.IC20Div = try IC20Div.get_output();
            out.IC20Output = try IC20Output.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.CKPERSource = try CKPERSource.get_output();
            out.CKPERoutput = try CKPERoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.ADCDIV = try ADCDIV.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADFMult = try ADFMult.get_output();
            out.ADFoutput = try ADFoutput.get_output();
            out.MDF1Mult = try MDF1Mult.get_output();
            out.MDFoutput = try MDFoutput.get_output();
            out.PSSIMult = try PSSIMult.get_output();
            out.PSSIoutput = try PSSIoutput.get_output();
            out.FDCANMult = try FDCANMult.get_output();
            out.FDCANoutput = try FDCANoutput.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.I2C2output = try I2C2output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.I2C4Mult = try I2C4Mult.get_output();
            out.I2C4output = try I2C4output.get_output();
            out.I3C1Mult = try I3C1Mult.get_output();
            out.I3C1output = try I3C1output.get_output();
            out.I3C2Mult = try I3C2Mult.get_output();
            out.I3C2output = try I3C2output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM3Mult = try LPTIM3Mult.get_output();
            out.LPTIM3output = try LPTIM3output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM4Mult = try LPTIM4Mult.get_output();
            out.LPTIM4output = try LPTIM4output.get_output();
            out.LPTIM5Mult = try LPTIM5Mult.get_output();
            out.LPTIM5output = try LPTIM5output.get_output();
            out.LTDCMult = try LTDCMult.get_output();
            out.LTDCoutput = try LTDCoutput.get_output();
            out.DCMIPPMult = try DCMIPPMult.get_output();
            out.DCMIPPoutput = try DCMIPPoutput.get_output();
            out.FMCMult = try FMCMult.get_output();
            out.FMCoutput = try FMCoutput.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI2Mult = try SAI2Mult.get_output();
            out.SAI2output = try SAI2output.get_output();
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
            out.USART6Mult = try USART6Mult.get_output();
            out.USART6output = try USART6output.get_output();
            out.UART7Mult = try UART7Mult.get_output();
            out.UART7output = try UART7output.get_output();
            out.UART8Mult = try UART8Mult.get_output();
            out.UART8output = try UART8output.get_output();
            out.UART9Mult = try UART9Mult.get_output();
            out.UART9output = try UART9output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.USART10Mult = try USART10Mult.get_output();
            out.USART10output = try USART10output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI2Mult = try SPI2Mult.get_output();
            out.SPI2output = try SPI2output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI4Mult = try SPI4Mult.get_output();
            out.SPI4output = try SPI4output.get_output();
            out.SPI5Mult = try SPI5Mult.get_output();
            out.SPI5output = try SPI5output.get_output();
            out.SPI6Mult = try SPI6Mult.get_output();
            out.SPI6output = try SPI6output.get_output();
            out.XSPI1Mult = try XSPI1Mult.get_output();
            out.XSPI1output = try XSPI1output.get_output();
            out.XSPI2Mult = try XSPI2Mult.get_output();
            out.XSPI2output = try XSPI2output.get_output();
            out.OTGHS1Mult = try OTGHS1Mult.get_output();
            out.OTGHS1output = try OTGHS1output.get_output();
            out.OTGHS2Mult = try OTGHS2Mult.get_output();
            out.OTGHS2output = try OTGHS2output.get_output();
            out.XSPI3Mult = try XSPI3Mult.get_output();
            out.XSPI3output = try XSPI3output.get_output();
            out.OTGPHY1Mult = try OTGPHY1Mult.get_output();
            out.OTGPHY1output = try OTGPHY1output.get_output();
            out.OTGPHY2Mult = try OTGPHY2Mult.get_output();
            out.OTGPHY2output = try OTGPHY2output.get_output();
            out.SDMMC1Mult = try SDMMC1Mult.get_output();
            out.SDMMC1output = try SDMMC1output.get_output();
            out.SDMMC2Mult = try SDMMC2Mult.get_output();
            out.SDMMC2output = try SDMMC2output.get_output();
            out.ETH1Mult = try ETH1Mult.get_output();
            out.ETH1output = try ETH1output.get_output();
            out.SPDIFRX1Mult = try SPDIFRX1Mult.get_output();
            out.SPDIFRX1output = try SPDIFRX1output.get_output();
            out.SYSBClkSource = try SYSBClkSource.get_output();
            out.SYSCClkSource = try SYSCClkSource.get_output();
            out.SYSDClkSource = try SYSDClkSource.get_output();
            out.SYSBCLKOutput = try SYSBCLKOutput.get_output();
            out.SYSCCLKOutput = try SYSCCLKOutput.get_output();
            out.SYSDCLKOutput = try SYSDCLKOutput.get_output();
            out.SYSAClkSource = try SYSAClkSource.get_output();
            out.TPIUPrescaler = try TPIUPrescaler.get_output();
            out.TPIUOutput = try TPIUOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CpuClockOutput = try CpuClockOutput.get_output();
            out.AXIClockOutput = try AXIClockOutput.get_output();
            out.HPREDiv = try HPREDiv.get_output();
            out.APB4DIV = try APB4DIV.get_output();
            out.APB4Output = try APB4Output.get_output();
            out.APB5DIV = try APB5DIV.get_output();
            out.APB5Output = try APB5Output.get_output();
            out.TIMGDIV = try TIMGDIV.get_output();
            out.TIMGOutput = try TIMGOutput.get_output();
            out.APB1DIV = try APB1DIV.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.APB2DIV = try APB2DIV.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.PLL1Source = try PLL1Source.get_output();
            out.FREFDIV1 = try FREFDIV1.get_output();
            out.PLL2Source = try PLL2Source.get_output();
            out.FREFDIV2 = try FREFDIV2.get_output();
            out.PLL3Source = try PLL3Source.get_output();
            out.FREFDIV3 = try FREFDIV3.get_output();
            out.PLL4Source = try PLL4Source.get_output();
            out.FREFDIV4 = try FREFDIV4.get_output();
            out.FBDIV1 = try FBDIV1.get_output();
            out.PLL1FRACV = try PLL1FRACV.get_output();
            out.POSTDIV1_1 = try POSTDIV1_1.get_output();
            out.POSTDIV2_1 = try POSTDIV2_1.get_output();
            out.FOUTPOSTDIV1 = try FOUTPOSTDIV1.get_output();
            out.FBDIV2 = try FBDIV2.get_output();
            out.PLL2FRACV = try PLL2FRACV.get_output();
            out.POSTDIV1_2 = try POSTDIV1_2.get_output();
            out.POSTDIV2_2 = try POSTDIV2_2.get_output();
            out.FOUTPOSTDIV2 = try FOUTPOSTDIV2.get_output();
            out.FBDIV3 = try FBDIV3.get_output();
            out.PLL3FRACV = try PLL3FRACV.get_output();
            out.POSTDIV1_3 = try POSTDIV1_3.get_output();
            out.POSTDIV2_3 = try POSTDIV2_3.get_output();
            out.FOUTPOSTDIV3 = try FOUTPOSTDIV3.get_output();
            out.FBDIV4 = try FBDIV4.get_output();
            out.PLL4FRACV = try PLL4FRACV.get_output();
            out.POSTDIV1_4 = try POSTDIV1_4.get_output();
            out.POSTDIV2_4 = try POSTDIV2_4.get_output();
            out.FOUTPOSTDIV4 = try FOUTPOSTDIV4.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            ref_out.HSIDiv = HSIDivValue;
            ref_out.HSIDiv4 = HSIDiv4Value;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.HSE_Div = HSE_DivValue;
            ref_out.HSE_Div2 = HSE_Div2Value;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.IC1CLKSource = IC1CLKSourceValue;
            ref_out.IC1Div = IC1DivValue;
            ref_out.IC2CLKSource = IC2CLKSourceValue;
            ref_out.IC2Div = IC2DivValue;
            ref_out.IC3CLKSource = IC3CLKSourceValue;
            ref_out.IC3Div = IC3DivValue;
            ref_out.IC4CLKSource = IC4CLKSourceValue;
            ref_out.IC4Div = IC4DivValue;
            ref_out.IC5CLKSource = IC5CLKSourceValue;
            ref_out.IC5Div = IC5DivValue;
            ref_out.IC6CLKSource = IC6CLKSourceValue;
            ref_out.IC6Div = IC6DivValue;
            ref_out.IC7CLKSource = IC7CLKSourceValue;
            ref_out.IC7Div = IC7DivValue;
            ref_out.IC8CLKSource = IC8CLKSourceValue;
            ref_out.IC8Div = IC8DivValue;
            ref_out.IC9CLKSource = IC9CLKSourceValue;
            ref_out.IC9Div = IC9DivValue;
            ref_out.IC10CLKSource = IC10CLKSourceValue;
            ref_out.IC10Div = IC10DivValue;
            ref_out.IC11CLKSource = IC11CLKSourceValue;
            ref_out.IC11Div = IC11DivValue;
            ref_out.IC12CLKSource = IC12CLKSourceValue;
            ref_out.IC12Div = IC12DivValue;
            ref_out.IC13CLKSource = IC13CLKSourceValue;
            ref_out.IC13Div = IC13DivValue;
            ref_out.IC14CLKSource = IC14CLKSourceValue;
            ref_out.IC14Div = IC14DivValue;
            ref_out.IC15CLKSource = IC15CLKSourceValue;
            ref_out.IC15Div = IC15DivValue;
            ref_out.IC16CLKSource = IC16CLKSourceValue;
            ref_out.IC16Div = IC16DivValue;
            ref_out.IC17CLKSource = IC17CLKSourceValue;
            ref_out.IC17Div = IC17DivValue;
            ref_out.IC18CLKSource = IC18CLKSourceValue;
            ref_out.IC18Div = IC18DivValue;
            ref_out.IC19CLKSource = IC19CLKSourceValue;
            ref_out.IC19Div = IC19DivValue;
            ref_out.IC20CLKSource = IC20CLKSourceValue;
            ref_out.IC20Div = IC20DivValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.CKPERSourceSelection = CKPERSourceSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.ADCDIV = ADCDIVValue;
            ref_out.ADF1ClockSelection = ADF1ClockSelectionValue;
            ref_out.MDF1ClockSelection = MDF1ClockSelectionValue;
            ref_out.PSSIClockSelection = PSSIClockSelectionValue;
            ref_out.FDCANClockSelection = FDCANClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C2CLockSelection = I2C2CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.I2C4CLockSelection = I2C4CLockSelectionValue;
            ref_out.I3C1CLockSelection = I3C1CLockSelectionValue;
            ref_out.I3C2CLockSelection = I3C2CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM3CLockSelection = LPTIM3CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.LPTIM4CLockSelection = LPTIM4CLockSelectionValue;
            ref_out.LPTIM5CLockSelection = LPTIM5CLockSelectionValue;
            ref_out.LTDCClockSelection = LTDCClockSelectionValue;
            ref_out.DCMIPPClockSelection = DCMIPPClockSelectionValue;
            ref_out.FMCClockSelection = FMCClockSelectionValue;
            ref_out.SAI1ClockSelection = SAI1ClockSelectionValue;
            ref_out.SAI2ClockSelection = SAI2ClockSelectionValue;
            ref_out.USART1ClockSelection = USART1ClockSelectionValue;
            ref_out.USART2ClockSelection = USART2ClockSelectionValue;
            ref_out.USART3ClockSelection = USART3ClockSelectionValue;
            ref_out.UART4ClockSelection = UART4ClockSelectionValue;
            ref_out.UART5ClockSelection = UART5ClockSelectionValue;
            ref_out.USART6ClockSelection = USART6ClockSelectionValue;
            ref_out.UART7ClockSelection = UART7ClockSelectionValue;
            ref_out.UART8ClockSelection = UART8ClockSelectionValue;
            ref_out.UART9ClockSelection = UART9ClockSelectionValue;
            ref_out.LPUART1ClockSelection = LPUART1ClockSelectionValue;
            ref_out.USART10ClockSelection = USART10ClockSelectionValue;
            ref_out.SPI1ClockSelection = SPI1ClockSelectionValue;
            ref_out.SPI2ClockSelection = SPI2ClockSelectionValue;
            ref_out.SPI3ClockSelection = SPI3ClockSelectionValue;
            ref_out.SPI4ClockSelection = SPI4ClockSelectionValue;
            ref_out.SPI5ClockSelection = SPI5ClockSelectionValue;
            ref_out.SPI6ClockSelection = SPI6ClockSelectionValue;
            ref_out.XSPI1ClockSelection = XSPI1ClockSelectionValue;
            ref_out.XSPI2ClockSelection = XSPI2ClockSelectionValue;
            ref_out.OTGHS1ClockSelection = OTGHS1ClockSelectionValue;
            ref_out.OTGHS2ClockSelection = OTGHS2ClockSelectionValue;
            ref_out.XSPI3ClockSelection = XSPI3ClockSelectionValue;
            ref_out.OTGPHY1ClockSelection = OTGPHY1ClockSelectionValue;
            ref_out.OTGPHY2ClockSelection = OTGPHY2ClockSelectionValue;
            ref_out.SDMMC1ClockSelection = SDMMC1ClockSelectionValue;
            ref_out.SDMMC2ClockSelection = SDMMC2ClockSelectionValue;
            ref_out.ETH1ClockSelection = ETH1ClockSelectionValue;
            ref_out.SPDIFRX1ClockSelection = SPDIFRX1ClockSelectionValue;
            ref_out.SYSBCLKSource = SYSBCLKSourceValue;
            ref_out.SYSCCLKSource = SYSCCLKSourceValue;
            ref_out.SYSDCLKSource = SYSDCLKSourceValue;
            ref_out.CPUCLKSource = CPUCLKSourceValue;
            ref_out.TPIUPrescaler = TPIUPrescalerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.HPRE_Div = HPRE_DivValue;
            ref_out.APB4DIV = APB4DIVValue;
            ref_out.APB5DIV = APB5DIVValue;
            ref_out.TIMGDIV = TIMGDIVValue;
            ref_out.APB1DIV = APB1DIVValue;
            ref_out.APB2DIV = APB2DIVValue;
            ref_out.PLL1Source = PLL1SourceValue;
            ref_out.FREFDIV1 = FREFDIV1Value;
            ref_out.PLL2Source = PLL2SourceValue;
            ref_out.FREFDIV2 = FREFDIV2Value;
            ref_out.PLL3Source = PLL3SourceValue;
            ref_out.FREFDIV3 = FREFDIV3Value;
            ref_out.PLL4Source = PLL4SourceValue;
            ref_out.FREFDIV4 = FREFDIV4Value;
            ref_out.FBDIV1 = FBDIV1Value;
            ref_out.PLL1FRACV = PLL1FRACVValue;
            ref_out.POSTDIV1_1 = POSTDIV1_1Value;
            ref_out.POSTDIV2_1 = POSTDIV2_1Value;
            ref_out.FBDIV2 = FBDIV2Value;
            ref_out.PLL2FRACV = PLL2FRACVValue;
            ref_out.POSTDIV1_2 = POSTDIV1_2Value;
            ref_out.POSTDIV2_2 = POSTDIV2_2Value;
            ref_out.FBDIV3 = FBDIV3Value;
            ref_out.PLL3FRACV = PLL3FRACVValue;
            ref_out.POSTDIV1_3 = POSTDIV1_3Value;
            ref_out.POSTDIV2_3 = POSTDIV2_3Value;
            ref_out.FBDIV4 = FBDIV4Value;
            ref_out.PLL4FRACV = PLL4FRACVValue;
            ref_out.POSTDIV1_4 = POSTDIV1_4Value;
            ref_out.POSTDIV2_4 = POSTDIV2_4Value;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
            ref_out.RCC_TIM_G1_PRescaler_Selection = RCC_TIM_G1_PRescaler_SelectionValue;
            ref_out.RCC_TIM_G2_PRescaler_Selection = RCC_TIM_G2_PRescaler_SelectionValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.PLL1MODE = PLL1MODEValue;
            ref_out.PLL2MODE = PLL2MODEValue;
            ref_out.PLL3MODE = PLL3MODEValue;
            ref_out.PLL4MODE = PLL4MODEValue;
            ref_out.PLL1CSG = PLL1CSGValue;
            ref_out.PLL2CSG = PLL2CSGValue;
            ref_out.PLL3CSG = PLL3CSGValue;
            ref_out.PLL4CSG = PLL4CSGValue;
            ref_out.EnableUCPD1 = EnableUCPD1Value;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.OTG1Enable = OTG1EnableValue;
            ref_out.OTG2Enable = OTG2EnableValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.XSPI1Enable = XSPI1EnableValue;
            ref_out.XSPI2Enable = XSPI2EnableValue;
            ref_out.XSPI3Enable = XSPI3EnableValue;
            ref_out.FMCEnable = FMCEnableValue;
            ref_out.SDMMC1Enable = SDMMC1EnableValue;
            ref_out.SDMMC2Enable = SDMMC2EnableValue;
            ref_out.CKPEREnable = CKPEREnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.EnableADF1 = EnableADF1Value;
            ref_out.EnableMDF1 = EnableMDF1Value;
            ref_out.EnableSAI1 = EnableSAI1Value;
            ref_out.EnableSAI2 = EnableSAI2Value;
            ref_out.EnableSPDIFRX = EnableSPDIFRXValue;
            ref_out.EnableSPI1 = EnableSPI1Value;
            ref_out.EnableSPI2 = EnableSPI2Value;
            ref_out.EnableSPI3 = EnableSPI3Value;
            ref_out.EnableSPI6 = EnableSPI6Value;
            ref_out.EnableSPI4 = EnableSPI4Value;
            ref_out.EnableSPI5 = EnableSPI5Value;
            ref_out.EnableLPUART1 = EnableLPUART1Value;
            ref_out.EnableUSART1 = EnableUSART1Value;
            ref_out.EnableUSART2 = EnableUSART2Value;
            ref_out.EnableUSART3 = EnableUSART3Value;
            ref_out.EnableUSART6 = EnableUSART6Value;
            ref_out.EnableUSART10 = EnableUSART10Value;
            ref_out.EnableUART4 = EnableUART4Value;
            ref_out.EnableUART5 = EnableUART5Value;
            ref_out.EnableUART7 = EnableUART7Value;
            ref_out.EnableUART8 = EnableUART8Value;
            ref_out.EnableUART9 = EnableUART9Value;
            ref_out.EnableI2C1 = EnableI2C1Value;
            ref_out.EnableI2C2 = EnableI2C2Value;
            ref_out.EnableI2C3 = EnableI2C3Value;
            ref_out.EnableI2C4 = EnableI2C4Value;
            ref_out.EnableI3C1 = EnableI3C1Value;
            ref_out.EnableI3C2 = EnableI3C2Value;
            ref_out.ETH1Enable = ETH1EnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.EnableLPTIM1 = EnableLPTIM1Value;
            ref_out.EnableLPTIM2 = EnableLPTIM2Value;
            ref_out.EnableLPTIM3 = EnableLPTIM3Value;
            ref_out.EnableLPTIM4 = EnableLPTIM4Value;
            ref_out.EnableLPTIM5 = EnableLPTIM5Value;
            ref_out.EnableLTDC = EnableLTDCValue;
            ref_out.EnableDCMI = EnableDCMIValue;
            ref_out.EnableCSI = EnableCSIValue;
            ref_out.EnableFDCAN123 = EnableFDCAN123Value;
            ref_out.PSSIEnable = PSSIEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.PLL1Used = PLL1UsedValue;
            ref_out.PLL2Used = PLL2UsedValue;
            ref_out.PLL3Used = PLL3UsedValue;
            ref_out.PLL4Used = PLL4UsedValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.IC1Used = IC1UsedValue;
            ref_out.IC2Used = IC2UsedValue;
            ref_out.IC3Used = IC3UsedValue;
            ref_out.IC4Used = IC4UsedValue;
            ref_out.IC5Used = IC5UsedValue;
            ref_out.IC6Used = IC6UsedValue;
            ref_out.IC7Used = IC7UsedValue;
            ref_out.IC8Used = IC8UsedValue;
            ref_out.IC9Used = IC9UsedValue;
            ref_out.IC10Used = IC10UsedValue;
            ref_out.IC11Used = IC11UsedValue;
            ref_out.IC12Used = IC12UsedValue;
            ref_out.IC14Used = IC14UsedValue;
            ref_out.IC15Used = IC15UsedValue;
            ref_out.IC16Used = IC16UsedValue;
            ref_out.IC17Used = IC17UsedValue;
            ref_out.IC18Used = IC18UsedValue;
            ref_out.IC19Used = IC19UsedValue;
            ref_out.IC20Used = IC20UsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
