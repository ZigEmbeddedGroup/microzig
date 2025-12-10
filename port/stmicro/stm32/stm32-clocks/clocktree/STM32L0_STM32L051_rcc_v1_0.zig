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
    RCC_PLLSOURCE_HSE,
    RCC_PLLSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSE => 0,
            .RCC_PLLSOURCE_HSI => 1,
        };
    }
};
pub const LptimClockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    RCC_LPTIM1CLKSOURCE_PCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_LSI => 0,
            .RCC_LPTIM1CLKSOURCE_HSI => 1,
            .RCC_LPTIM1CLKSOURCE_LSE => 2,
            .RCC_LPTIM1CLKSOURCE_PCLK => 3,
        };
    }
};
pub const Lpuart1ClockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK1,
    RCC_LPUART1CLKSOURCE_LSE,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK1 => 0,
            .RCC_LPUART1CLKSOURCE_LSE => 1,
            .RCC_LPUART1CLKSOURCE_HSI => 2,
            .RCC_LPUART1CLKSOURCE_SYSCLK => 3,
        };
    }
};
pub const Usart2ClockSelectionList = enum {
    RCC_USART2CLKSOURCE_SYSCLK,
    RCC_USART2CLKSOURCE_HSI,
    RCC_USART2CLKSOURCE_LSE,
    RCC_USART2CLKSOURCE_PCLK1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_SYSCLK => 0,
            .RCC_USART2CLKSOURCE_HSI => 1,
            .RCC_USART2CLKSOURCE_LSE => 2,
            .RCC_USART2CLKSOURCE_PCLK1 => 3,
        };
    }
};
pub const Usart1ClockSelectionList = enum {
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
pub const I2c1ClockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_HSI,
    RCC_I2C1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_HSI => 1,
            .RCC_I2C1CLKSOURCE_SYSCLK => 2,
        };
    }
};
pub const I2c3ClockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK1,
    RCC_I2C3CLKSOURCE_HSI,
    RCC_I2C3CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK1 => 0,
            .RCC_I2C3CLKSOURCE_HSI => 1,
            .RCC_I2C3CLKSOURCE_SYSCLK => 2,
        };
    }
};
pub const RCC_MCOSourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSI,
    RCC_MCO1SOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLLCLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_MSI => 6,
            .RCC_MCO1SOURCE_HSI48 => 7,
        };
    }
};
pub const HSI48MClockSelectionList = enum {
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL => 0,
            .RCC_USBCLKSOURCE_HSI48 => 1,
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
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MSIRANGE_0 => 65536,
            .RCC_MSIRANGE_1 => 131072,
            .RCC_MSIRANGE_2 => 262144,
            .RCC_MSIRANGE_3 => 524288,
            .RCC_MSIRANGE_4 => 1048000,
            .RCC_MSIRANGE_5 => 2097000,
            .RCC_MSIRANGE_6 => 4194000,
        };
    }
};
pub const HSIRCDivList = enum {
    @"1",
    @"4",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"1" => 1,
            .@"4" => 4,
        };
    }
};
pub const RCC_RTC_Clock_Source_FROM_HSEList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV2,
    RCC_RTCCLKSOURCE_HSE_DIV4,
    RCC_RTCCLKSOURCE_HSE_DIV8,
    RCC_RTCCLKSOURCE_HSE_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV2 => 2,
            .RCC_RTCCLKSOURCE_HSE_DIV4 => 4,
            .RCC_RTCCLKSOURCE_HSE_DIV8 => 8,
            .RCC_RTCCLKSOURCE_HSE_DIV16 => 16,
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
pub const TimPrescalerList = enum {
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
pub const PLLMULList = enum {
    RCC_PLLMUL_3,
    RCC_PLLMUL_4,
    RCC_PLLMUL_6,
    RCC_PLLMUL_8,
    RCC_PLLMUL_12,
    RCC_PLLMUL_16,
    RCC_PLLMUL_24,
    RCC_PLLMUL_32,
    RCC_PLLMUL_48,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLMUL_3 => 3,
            .RCC_PLLMUL_4 => 4,
            .RCC_PLLMUL_6 => 6,
            .RCC_PLLMUL_8 => 8,
            .RCC_PLLMUL_12 => 12,
            .RCC_PLLMUL_16 => 16,
            .RCC_PLLMUL_24 => 24,
            .RCC_PLLMUL_32 => 32,
            .RCC_PLLMUL_48 => 48,
        };
    }
};
pub const PLLDIVList = enum {
    RCC_PLLDIV_2,
    RCC_PLLDIV_3,
    RCC_PLLDIV_4,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLDIV_2 => 2,
            .RCC_PLLDIV_3 => 3,
            .RCC_PLLDIV_4 => 4,
        };
    }
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const INSTRUCTION_CACHE_ENABLEList = enum {
    @"0",
    @"1",
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE3,
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
pub const EnableHSERTCDevisorList = enum {
    true,
    false,
};
pub const EnableHSELCDDevisorList = enum {
    true,
    false,
};
pub const LPTIMEnableList = enum {
    true,
    false,
};
pub const LPUARTEnableList = enum {
    true,
    false,
};
pub const USART2EnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
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
pub const ADCEnableList = enum {
    true,
    false,
};
pub const EnableCSSLSEList = enum {
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
pub const @"48MEnableList" = enum {
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
            MCOConfig: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            USBUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            LCDUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            LPTIMUsed_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            ADCUsed_ForRCC: bool = false,
            CSSEnabled: bool = false,
            Semaphore_ETRpinUsedTIM22: bool = false,
            Semaphore_ETRpinUsedTIM21: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
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
        };
        pub const Config = struct {
            MSIClockRange: ?MSIClockRangeList = null,
            HSIRCDiv: ?HSIRCDivList = null,
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            TimPrescaler: ?TimPrescalerList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            LptimClockSelection: ?LptimClockSelectionList = null,
            Lpuart1ClockSelection: ?Lpuart1ClockSelectionList = null,
            Usart2ClockSelection: ?Usart2ClockSelectionList = null,
            Usart1ClockSelection: ?Usart1ClockSelectionList = null,
            I2c1ClockSelection: ?I2c1ClockSelectionList = null,
            I2c3ClockSelection: ?I2c3ClockSelectionList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            HSI48MClockSelection: ?HSI48MClockSelectionList = null,
            PLLMUL: ?PLLMULList = null,
            PLLDIV: ?PLLDIVList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            MSIRC: f32 = 0,
            HSI48RC: f32 = 0,
            HSIRCDiv: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            LCDOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            SysClkSource: f32 = 0,
            PLLSource: f32 = 0,
            AHBPrescaler: f32 = 0,
            SysCLKOutput: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            TIMPrescaler: f32 = 0,
            TIMOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            PeriphPrescaler: f32 = 0,
            PeriphPrescOutput: f32 = 0,
            LPTIMMult: f32 = 0,
            LPTIMOutput: f32 = 0,
            LPUARTMult: f32 = 0,
            LPUARTOutput: f32 = 0,
            USART2Mult: f32 = 0,
            USART2Output: f32 = 0,
            USART1Mult: f32 = 0,
            USART1Output: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1Output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3Output: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            HSI48MUL: f32 = 0,
            @"48USBOutput": f32 = 0,
            @"48RNGOutput": f32 = 0,
            ADCOutput: f32 = 0,
            VCOIIuput: f32 = 0,
            PLLMUL: f32 = 0,
            PLLDIV: f32 = 0,
            DIV2USB: f32 = 0,
            HSI: f32 = 0,
            MSI: f32 = 0,
            HSE_RTC: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            @"48CLK": f32 = 0,
            TIMCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            HSIRCDiv: ?HSIRCDivList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            TimPrescaler: ?TimPrescalerList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            LptimClockSelection: ?LptimClockSelectionList = null, //from RCC Clock Config
            Lpuart1ClockSelection: ?Lpuart1ClockSelectionList = null, //from RCC Clock Config
            Usart2ClockSelection: ?Usart2ClockSelectionList = null, //from RCC Clock Config
            Usart1ClockSelection: ?Usart1ClockSelectionList = null, //from RCC Clock Config
            I2c1ClockSelection: ?I2c1ClockSelectionList = null, //from RCC Clock Config
            I2c3ClockSelection: ?I2c3ClockSelectionList = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            HSI48MClockSelection: ?HSI48MClockSelectionList = null, //from RCC Clock Config
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            PLLDIV: ?PLLDIVList = null, //from RCC Clock Config
            DIV2USB: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
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
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            EnableHSELCDDevisor: ?EnableHSELCDDevisorList = null, //from extra RCC references
            LPTIMEnable: ?LPTIMEnableList = null, //from extra RCC references
            LPUARTEnable: ?LPUARTEnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            @"48MEnable": ?@"48MEnableList" = null, //from extra RCC references
            LSIUsed: ?f32 = null, //from extra RCC references
            HSI48Used: ?f32 = null, //from extra RCC references
            MSIUsed: ?f32 = null, //from extra RCC references
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
            var HSEscale: bool = false;
            var PLLscale: bool = false;
            var LPTIMSOURCELSI: bool = false;
            var LPTIMSOURCEHSI: bool = false;
            var LPTIMSOURCELSE: bool = false;
            var LPUART1SourceLSE: bool = false;
            var LPUART1SourceHSI: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C3SourceHSI: bool = false;
            var MCOSourcePLL: bool = false;
            var MCOSource_HSI48: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var APB2CLKDivider1: bool = false;
            var FLASH_LATENCY1: bool = false;
            var scale1: bool = false;
            var scale2: bool = false;
            var scale11: bool = false;
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
            var RCC_LSECSS_ENABLED: bool = false;
            var RTCFreq_ValueLimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var @"48USBFreq_ValueLimit": Limit = .{};
            var @"48RNGFreq_ValueLimit": Limit = .{};
            var VCOInputFreq_ValueLimit: Limit = .{};
            var RTCHSEDivFreq_ValueLimit: Limit = .{};
            var VCOOutputFreq_ValueLimit: Limit = .{};
            var PLLCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI16_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const MSIClockRangeValue: ?MSIClockRangeList = blk: {
                const conf_item = config.MSIClockRange;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MSIRANGE_0 => {},
                        .RCC_MSIRANGE_1 => {},
                        .RCC_MSIRANGE_2 => {},
                        .RCC_MSIRANGE_3 => {},
                        .RCC_MSIRANGE_4 => {},
                        .RCC_MSIRANGE_5 => {},
                        .RCC_MSIRANGE_6 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MSIRANGE_5;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const HSIRCDivValue: ?HSIRCDivList = blk: {
                const conf_item = config.HSIRCDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"4" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_MSI => SysSourceMSI = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => HSEscale = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => PLLscale = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceMSI = true;
                    break :blk .RCC_SYSCLKSOURCE_MSI;
                };
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@">")))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value > 16000000))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@">")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale11 = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value > 8000000))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                } else if ((((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 4200000, .@">"))))) {
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
                                , .{ "PWR_Regulator_Voltage_Scale", "(((HCLKFreq_Value > 4200000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                }
                const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                if (conf_item) |item| {
                    switch (item) {
                        .PWR_REGULATOR_VOLTAGE_SCALE3 => scale3 = true,
                        .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                        .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                    }
                }

                break :blk conf_item orelse {
                    scale1 = true;
                    break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                };
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if ((((PLLscale) or config.flags.CSSEnabled)) and config.flags.HSEByPass) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(((PLLscale)|CSSEnabled)) & HSEByPass  ",
                                "HSE in bypass Mode",
                                1e6,
                                val,
                            });
                        }
                        if (val > 3.2e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "(((PLLscale)|CSSEnabled)) & HSEByPass  ",
                                "HSE in bypass Mode",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (HSEscale and config.flags.HSEByPass and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"="))) {
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
                                "HSEscale & HSEByPass & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE3) ",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 8e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEscale & HSEByPass & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE3) ",
                                "HSE in bypass Mode",
                                8e6,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (HSEscale and config.flags.HSEByPass and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"="))) {
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
                                "HSEscale & HSEByPass & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE2) ",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 1.6e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEscale & HSEByPass & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE2) ",
                                "HSE in bypass Mode",
                                1.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (config.flags.HSEByPass) {
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
                                "HSEByPass  ",
                                "HSE in bypass Mode",
                                0e0,
                                val,
                            });
                        }
                        if (val > 3.2e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass  ",
                                "HSE in bypass Mode",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (check_MCU("DIE447") and HSEscale and config.flags.HSEOscillator and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"="))) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "DIE447&HSEscale & HSEOscillator & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE3) ",
                                "HSE in bypass Mode",
                                1e6,
                                val,
                            });
                        }
                        if (val > 8e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "DIE447&HSEscale & HSEOscillator & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE3) ",
                                "HSE in bypass Mode",
                                8e6,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (check_MCU("DIE447") and HSEscale and config.flags.HSEOscillator and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"="))) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "DIE447&HSEscale & HSEOscillator & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE2) ",
                                "HSE in bypass Mode",
                                1e6,
                                val,
                            });
                        }
                        if (val > 1.6e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "DIE447&HSEscale & HSEOscillator & (PWR_Regulator_Voltage_Scale=PWR_REGULATOR_VOLTAGE_SCALE2) ",
                                "HSE in bypass Mode",
                                1.6e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                } else if (config.flags.HSEOscillator) {
                    const config_val = config.HSE_VALUE;
                    if (config_val) |val| {
                        if (val < 1e6) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEOscillator",
                                "HSE in bypass Mode",
                                1e6,
                                val,
                            });
                        }
                        if (val > 2.5e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEOscillator",
                                "HSE in bypass Mode",
                                2.5e7,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 8000000;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 1e6) {
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
                            1e6,
                            val,
                        });
                    }
                    if (val > 2.5e7) {
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
                            2.5e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 8000000;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.7e4;
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
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1_directTIM21")))) {
                    const conf_item = config.RTCClockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .HSERTCDevisor => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - HSERTCDevisor
                                , .{ "RTCClockSelection", "((HSEByPass|HSEOscillator)&(SEM2RCC_HSE_REQUIRED_TIM21 & TIM21 & Semaphore_input_Channel1_directTIM21) )", "RTC Mux should have HSE as input when TIM21 remap is used", item });
                            },
                        }
                    }

                    break :blk conf_item orelse null;
                }
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
            const RTCEnableValue: ?RTCEnableList = blk: {
                if ((check_MCU("SEM2RCC_HSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.RTCUsed_ForRCC) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")))) {
                    RTCFreq_ValueLimit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                break :blk 3.7e4;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCDUsed_ForRCC) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const LCDFreq_ValueValue: ?f32 = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")))) {
                    break :blk 1e6;
                }
                break :blk 3.2e4;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?RCC_RTC_Clock_Source_FROM_HSEList = blk: {
                const conf_item = config.RCC_RTC_Clock_Source_FROM_HSE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_HSE_DIV2 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV4 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV8 => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_HSE_DIV2;
            };
            const HSI48MClockSelectionValue: ?HSI48MClockSelectionList = blk: {
                const conf_item = config.HSI48MClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL => {},
                        .RCC_USBCLKSOURCE_HSI48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_USBCLKSOURCE_PLL;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if ((config.flags.USBUsed_ForRCC and (check_ref(@TypeOf(HSI48MClockSelectionValue), HSI48MClockSelectionValue, .RCC_USBCLKSOURCE_PLL, .@"=")))) {
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
                            , .{ "PLLSource", "(USBUsed_ForRCC&(HSI48MClockSelection=RCC_USBCLKSOURCE_PLL)) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                if ((config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC) and (config.flags.RTCUsed_ForRCC > 32000000)) {
                    const min: ?f32 = RTCFreq_ValueValue;
                    const max: ?f32 = @min(32000000, std.math.floatMax(f32));
                    SYSCLKFreq_VALUELimit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const TimPrescalerValue: ?TimPrescalerList = blk: {
                const conf_item = config.TimPrescaler;
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
            const TimerFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
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
                if (config.flags.USBUsed_ForRCC) {
                    APB1Freq_ValueLimit = .{
                        .min = 1e7,
                        .max = 3.2e7,
                    };

                    break :blk null;
                }
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 3.2e7,
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
                break :blk 1.6e7;
            };
            const APB2CLKDividerValue: ?APB2CLKDividerList = blk: {
                const conf_item = config.APB2CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => APB2CLKDivider1 = true,
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    APB2CLKDivider1 = true;
                    break :blk .RCC_HCLK_DIV1;
                };
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 3.2e7,
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
                break :blk 1.6e7;
            };
            const LptimClockSelectionValue: ?LptimClockSelectionList = blk: {
                const conf_item = config.LptimClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK => {},
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIMSOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIMSOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIMSOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK;
            };
            const LPTIMFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const Lpuart1ClockSelectionValue: ?Lpuart1ClockSelectionList = blk: {
                const conf_item = config.Lpuart1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK1 => {},
                        .RCC_LPUART1CLKSOURCE_SYSCLK => {},
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK1;
            };
            const LPUARTFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const Usart2ClockSelectionValue: ?Usart2ClockSelectionList = blk: {
                const conf_item = config.Usart2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK1 => {},
                        .RCC_USART2CLKSOURCE_SYSCLK => {},
                        .RCC_USART2CLKSOURCE_HSI => {},
                        .RCC_USART2CLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_USART2CLKSOURCE_PCLK1;
            };
            const USART2Freq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const Usart1ClockSelectionValue: ?Usart1ClockSelectionList = blk: {
                const conf_item = config.Usart1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => {},
                        .RCC_USART1CLKSOURCE_SYSCLK => {},
                        .RCC_USART1CLKSOURCE_HSI => {},
                        .RCC_USART1CLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const I2c1ClockSelectionValue: ?I2c1ClockSelectionList = blk: {
                const conf_item = config.I2c1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => {},
                        .RCC_I2C1CLKSOURCE_SYSCLK => {},
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const I2c3ClockSelectionValue: ?I2c3ClockSelectionList = blk: {
                const conf_item = config.I2c3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK1 => {},
                        .RCC_I2C3CLKSOURCE_SYSCLK => {},
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK1;
            };
            const I2C3Freq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const RCC_MCOSourceValue: ?RCC_MCOSourceList = blk: {
                if (check_MCU("STM32L0x0_Value_Line")) {
                    const conf_item = config.RCC_MCOSource;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => {},
                            .RCC_MCO1SOURCE_HSI => {},
                            .RCC_MCO1SOURCE_MSI => {},
                            .RCC_MCO1SOURCE_HSE => {},
                            .RCC_MCO1SOURCE_PLLCLK => MCOSourcePLL = true,
                            .RCC_MCO1SOURCE_LSI => {},
                            .RCC_MCO1SOURCE_LSE => {},
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
                                    \\ - RCC_MCO1SOURCE_PLLCLK
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_LSE
                                , .{ "RCC_MCOSource", "STM32L0x0_Value_Line", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
                }
                const conf_item = config.RCC_MCOSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_MSI => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_PLLCLK => MCOSourcePLL = true,
                        .RCC_MCO1SOURCE_LSI => {},
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_HSI48 => MCOSource_HSI48 = true,
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
            const MCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const @"48USBFreq_ValueValue": ?f32 = blk: {
                @"48USBFreq_ValueLimit" = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };

                break :blk null;
            };
            const @"48RNGFreq_ValueValue": ?f32 = blk: {
                @"48RNGFreq_ValueLimit" = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const PLLUsedValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig)) or ((config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC) and (check_ref(@TypeOf(HSI48MClockSelectionValue), HSI48MClockSelectionValue, .RCC_USBCLKSOURCE_PLL, .@"=")))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOInputFreq_ValueLimit = .{
                        .min = 2e6,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                break :blk 1.6e7;
            };
            const PLLMULValue: ?PLLMULList = blk: {
                const conf_item = config.PLLMUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLMUL_3 => {},
                        .RCC_PLLMUL_4 => {},
                        .RCC_PLLMUL_6 => {},
                        .RCC_PLLMUL_8 => {},
                        .RCC_PLLMUL_12 => {},
                        .RCC_PLLMUL_16 => {},
                        .RCC_PLLMUL_24 => {},
                        .RCC_PLLMUL_32 => {},
                        .RCC_PLLMUL_48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLMUL_3;
            };
            const PLLDIVValue: ?PLLDIVList = blk: {
                const conf_item = config.PLLDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLDIV_2 => {},
                        .RCC_PLLDIV_3 => {},
                        .RCC_PLLDIV_4 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLDIV_2;
            };
            const DIV2USBValue: ?f32 = blk: {
                break :blk 2;
            };
            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const MSI_VALUEValue: ?f32 = blk: {
                break :blk 2.097e6;
            };
            const RTCHSEDivFreq_ValueValue: ?f32 = blk: {
                if (check_MCU("STM32L0x0_Value_Line")) {
                    break :blk 4e6;
                }
                RTCHSEDivFreq_ValueLimit = .{
                    .min = 0e0,
                    .max = 1e6,
                };

                break :blk null;
            };
            const VCOOutputFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE1, .@"=")))) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"=")))) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")))) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                break :blk 4.8e7;
            };
            const PLLCLKFreq_ValueValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE1, .@"=")))) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 2e6,
                        .max = 3.2e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"=")))) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 2e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")))) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 2e6,
                        .max = 4e6,
                    };

                    break :blk null;
                }
                PLLCLKFreq_ValueLimit = .{
                    .min = 2e6,
                    .max = null,
                };

                break :blk null;
            };
            const @"48CLKFreq_ValueValue": ?f32 = blk: {
                if (((check_ref(@TypeOf(HSI48MClockSelectionValue), HSI48MClockSelectionValue, .RCC_USBCLKSOURCE_PLL, .@"=")) and config.flags.USBUsed_ForRCC)) {
                    break :blk 4.8e7;
                }
                break :blk 2.4e7;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@">"))) {
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
                                "(HCLKFreq_Value > 16000000)",
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
                                "(HCLKFreq_Value > 16000000)",
                                "No Extra Log",
                                3.6e0,
                                val,
                            });
                        }
                    }
                    break :blk config_val orelse 3.3;
                }
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.65e0) {
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
                            1.65e0,
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
            const DATA_CACHE_ENABLEValue: ?DATA_CACHE_ENABLEList = blk: {
                const conf_item = config.extra.DATA_CACHE_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const PREFETCH_ENABLEValue: ?PREFETCH_ENABLEList = blk: {
                const conf_item = config.extra.PREFETCH_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"0";
            };
            const INSTRUCTION_CACHE_ENABLEValue: ?INSTRUCTION_CACHE_ENABLEList = blk: {
                const conf_item = config.extra.INSTRUCTION_CACHE_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"0" => {},
                        .@"1" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 4200000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 4200000, .@"="))))) and (scale3)) or (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@"="))))) and (scale2)) or (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"="))))) and (scale1 or scale11))) {
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
                            , .{ "FLatency", "   (((HCLKFreq_Value > 0) & ((HCLKFreq_Value <  4200000)|((HCLKFreq_Value =4200000))))& (scale3))|   (((HCLKFreq_Value > 0) & ((HCLKFreq_Value <  8000000)|((HCLKFreq_Value =8000000))))& (scale2))|   (((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 16000000)|((HCLKFreq_Value =16000000))))& (scale1|scale11))", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if ((((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 8000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"="))))) and (scale2)) or (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"="))))) and (scale1 or scale11))) {
                    FLASH_LATENCY1 = true;
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
                            , .{ "FLatency", "   (((HCLKFreq_Value > 8000000) & ((HCLKFreq_Value <  16000000)|((HCLKFreq_Value =16000000))))& (scale2))|   (((HCLKFreq_Value > 16000000) & ((HCLKFreq_Value <  32000000)|((HCLKFreq_Value =32000000))))& (scale1|scale11)) ", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.FLatency;
                if (conf_item) |item| {
                    switch (item) {
                        .FLASH_LATENCY_0 => {},
                        .FLASH_LATENCY_1 => FLASH_LATENCY1 = true,
                    }
                }

                break :blk conf_item orelse .FLASH_LATENCY_0;
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
                    if (val > 31) {
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
                            31,
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
                    if (val > 255) {
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
                            255,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
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
            const LSEUsedValue: ?f32 = blk: {
                if (((check_MCU("Semaphore_ClockSourceETRMode2TIM2") or check_MCU("Semaphore_TriggerSourceETRTIM2") or check_MCU("Semaphore_ETRasClearingSourceTIM2")) and check_MCU("TIM2") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM2")) or ((check_MCU("Semaphore_ClockSourceETRMode2TIM22") or check_MCU("Semaphore_TriggerSourceETRTIM22") or check_MCU("Semaphore_ETRasClearingSourceTIM22")) and check_MCU("TIM22") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM22")) or ((check_MCU("Semaphore_ClockSourceETRMode2TIM21") or check_MCU("Semaphore_TriggerSourceETRTIM21") or check_MCU("Semaphore_ETRasClearingSourceTIM21")) and check_MCU("TIM21") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM21")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or (config.flags.CRSActivatedSourceLSE or (config.flags.USART1Used_ForRCC and (check_ref(@TypeOf(Usart1ClockSelectionValue), Usart1ClockSelectionValue, .RCC_USART1CLKSOURCE_LSE, .@"="))) or (config.flags.USART2Used_ForRCC and (check_ref(@TypeOf(Usart2ClockSelectionValue), Usart2ClockSelectionValue, .RCC_USART2CLKSOURCE_LSE, .@"="))) or (config.flags.LPTIMUsed_ForRCC and LPTIMSOURCELSE) or (config.flags.LPUARTUsed_ForRCC and LPUART1SourceLSE) or (check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig)) or (check_MCU("SEMAPHORE_LSE_SELECTED") and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
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
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDGUsed_ForRCC) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass)) or (check_MCU("SEM2RCC_HSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21"))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
                break :blk item;
            };
            const EnableHSELCDDevisorValue: ?EnableHSELCDDevisorList = blk: {
                if (config.flags.LCDUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSELCDDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSELCDDevisorList = .false;
                break :blk item;
            };
            const LPTIMEnableValue: ?LPTIMEnableList = blk: {
                if (config.flags.LPTIMUsed_ForRCC) {
                    const item: LPTIMEnableList = .true;
                    break :blk item;
                }
                const item: LPTIMEnableList = .false;
                break :blk item;
            };
            const LPUARTEnableValue: ?LPUARTEnableList = blk: {
                if (config.flags.LPUARTUsed_ForRCC) {
                    const item: LPUARTEnableList = .true;
                    break :blk item;
                }
                const item: LPUARTEnableList = .false;
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
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1Used_ForRCC) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
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
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3Used_ForRCC) {
                    const item: I2C3EnableList = .true;
                    break :blk item;
                }
                const item: I2C3EnableList = .false;
                break :blk item;
            };
            const MCOEnableValue: ?MCOEnableList = blk: {
                if ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USBUsed_ForRCC) {
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
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.ADCUsed_ForRCC) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass) or (check_MCU("SEM2RCC_HSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21"))) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC or (check_MCU("SEM2RCC_HSE_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21"))) and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
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
            const @"48MEnableValue": ?@"48MEnableList" = blk: {
                if (config.flags.RNGUsed_ForRCC or config.flags.USBUsed_ForRCC) {
                    const item: @"48MEnableList" = .true;
                    break :blk item;
                }
                const item: @"48MEnableList" = .false;
                break :blk item;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSI_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or ((config.flags.LPTIMUsed_ForRCC and LPTIMSOURCELSI) or config.flags.IWDGUsed_ForRCC or (config.flags.USART1Used_ForRCC and (false)) or (check_MCU("SEMAPHORE_LSI_SELECTED") and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC)) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSI48UsedValue: ?f32 = blk: {
                if ((check_MCU("Semaphore_TIM2_L0_ETR_REMAPTIM2") and (check_MCU("SEM2RCC_HSI48_REQUIRED_TIM2"))) or (config.flags.Semaphore_ETRpinUsedTIM22 and (check_MCU("SEM2RCC_HSI48_REQUIRED_TIM22"))) or (config.flags.Semaphore_ETRpinUsedTIM21 and (check_MCU("SEM2RCC_HSI48_REQUIRED_TIM21"))) or (check_MCU("Semaphore_TIM3_L0_ETR_REMAPTIM3") and check_MCU("SEM2RCC_HSI48_REQUIRED_TIM3")) or ((config.flags.USBUsed_ForRCC or config.flags.RNGUsed_ForRCC) and (check_ref(@TypeOf(HSI48MClockSelectionValue), HSI48MClockSelectionValue, .RCC_USBCLKSOURCE_HSI48, .@"="))) or ((MCOSource_HSI48) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_MSI_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM21") and check_MCU("TIM21") and check_MCU("Semaphore_input_Channel1TIM21")) or config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSIRC = ClockNode{
                .name = "MSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSI48RC = ClockNode{
                .name = "HSI48RC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIRCDiv = ClockNode{
                .name = "HSIRCDiv",
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

            var LCDOutput = ClockNode{
                .name = "LCDOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var IWDGOutput = ClockNode{
                .name = "IWDGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSERTCDevisor = ClockNode{
                .name = "HSERTCDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var SysClkSource = ClockNode{
                .name = "SysClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBPrescaler = ClockNode{
                .name = "AHBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var SysCLKOutput = ClockNode{
                .name = "SysCLKOutput",
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

            var TIMPrescaler = ClockNode{
                .name = "TIMPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMOutput = ClockNode{
                .name = "TIMOutput",
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

            var TimPrescOut = ClockNode{
                .name = "TimPrescOut",
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

            var PeriphPrescaler = ClockNode{
                .name = "PeriphPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var PeriphPrescOutput = ClockNode{
                .name = "PeriphPrescOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIMMult = ClockNode{
                .name = "LPTIMMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIMOutput = ClockNode{
                .name = "LPTIMOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUARTMult = ClockNode{
                .name = "LPUARTMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUARTOutput = ClockNode{
                .name = "LPUARTOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART2Mult = ClockNode{
                .name = "USART2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART2Output = ClockNode{
                .name = "USART2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART1Mult = ClockNode{
                .name = "USART1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART1Output = ClockNode{
                .name = "USART1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C1Mult = ClockNode{
                .name = "I2C1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C1Output = ClockNode{
                .name = "I2C1Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3Mult = ClockNode{
                .name = "I2C3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3Output = ClockNode{
                .name = "I2C3Output",
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

            var HSI48MUL = ClockNode{
                .name = "HSI48MUL",
                .nodetype = .off,
                .parents = &.{},
            };

            var @"48USBOutput" = ClockNode{
                .name = "48USBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var @"48RNGOutput" = ClockNode{
                .name = "48RNGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCOutput = ClockNode{
                .name = "ADCOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOIIuput = ClockNode{
                .name = "VCOIIuput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLMUL = ClockNode{
                .name = "PLLMUL",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDIV = ClockNode{
                .name = "PLLDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var DIV2USB = ClockNode{
                .name = "DIV2USB",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSI = ClockNode{
                .name = "HSI",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSI = ClockNode{
                .name = "MSI",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSE_RTC = ClockNode{
                .name = "HSE_RTC",
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

            var @"48CLK" = ClockNode{
                .name = "48CLK",
                .nodetype = .off,
                .parents = &.{},
            };
            if ((check_MCU("LQFP32") or check_MCU("UFQFPN32") or check_MCU("WLCSP36")) and !((check_MCU("STM32L0x1") or check_MCU("STM32L0x0_Value_Line")) and (check_MCU("DIE425") or check_MCU("DIE457")))) {
                const HSIRC_clk_value = HSI16_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIRC",
                    "(LQFP32|UFQFPN32|WLCSP36)&!((STM32L0x1|STM32L0x0_Value_Line) &(DIE425|DIE457))",
                    "No Extra Log",
                    "HSI16_VALUE",
                });
                HSIRC.nodetype = .source;
                HSIRC.value = HSIRC_clk_value;
            }

            const HSIRC_clk_value = HSI16_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIRC",
                "Else",
                "No Extra Log",
                "HSI16_VALUE",
            });
            HSIRC.nodetype = .source;
            HSIRC.value = HSIRC_clk_value;

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
            if (!check_MCU("STM32L0x1") and !check_MCU("STM32L0x0_Value_Line")) {
                const HSI48RC_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSI48RC",
                    "!STM32L0x1 & !STM32L0x0_Value_Line",
                    "No Extra Log",
                    "HSI48_VALUE",
                });
                HSI48RC.nodetype = .source;
                HSI48RC.value = HSI48RC_clk_value;
            }
            if ((check_MCU("LQFP32") or check_MCU("UFQFPN32") or check_MCU("WLCSP36")) and !((check_MCU("DIE425") or check_MCU("DIE457")))) {
                const HSIRCDiv_clk_value = HSIRCDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSIRCDiv",
                    "(LQFP32|UFQFPN32|WLCSP36)&!((DIE425|DIE457))",
                    "No Extra Log",
                    "HSIRCDiv",
                });
                HSIRCDiv.nodetype = .div;
                HSIRCDiv.value = HSIRCDiv_clk_value.get();
                HSIRCDiv.parents = &.{&HSIRC};
            }

            const HSIRCDiv_clk_value = HSIRCDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIRCDiv",
                "Else",
                "No Extra Log",
                "HSIRCDiv",
            });
            HSIRCDiv.nodetype = .div;
            HSIRCDiv.value = HSIRCDiv_clk_value.get();
            HSIRCDiv.parents = &.{&HSIRC};
            if ((!check_MCU("LQFP32") and !check_MCU("UFQFPN32") and !check_MCU("WLCSP36")) or (check_MCU("DIE425") or check_MCU("DIE457"))) {
                const HSEOSC_clk_value = HSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEOSC",
                    "(!LQFP32 & !UFQFPN32 & !WLCSP36) |(DIE425|DIE457)",
                    "No Extra Log",
                    "HSE_VALUE",
                });
                HSEOSC.nodetype = .source;
                HSEOSC.value = HSEOSC_clk_value;
            }
            if ((!check_MCU("LQFP32") and !check_MCU("UFQFPN32") and !check_MCU("WLCSP36")) or (check_MCU("DIE425") or check_MCU("DIE457"))) {
                const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIRC",
                    "(!LQFP32 & !UFQFPN32 & !WLCSP36)|(DIE425|DIE457)",
                    "No Extra Log",
                    "LSI_VALUE",
                });
                LSIRC.nodetype = .source;
                LSIRC.value = LSIRC_clk_value;
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
            if ((check_MCU("LQFP32") or check_MCU("UFQFPN32") or check_MCU("WLCSP36")) and !((check_MCU("DIE425") or check_MCU("DIE457")))) {
                const LSEOSC_clk_value = LSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSEOSC",
                    "(LQFP32|UFQFPN32|WLCSP36)&!((DIE425|DIE457))",
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
            if ((!check_MCU("LQFP32") and !check_MCU("UFQFPN32") and !check_MCU("WLCSP36")) or (check_MCU("DIE425") or check_MCU("DIE457"))) {
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
                        "(!LQFP32 & !UFQFPN32 & !WLCSP36)|(DIE425|DIE457)",
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
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LCDFreq_ValueValue);
                LCDOutput.nodetype = .output;
                LCDOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(WatchDogFreq_ValueValue);
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }
            if ((!check_MCU("LQFP32") and !check_MCU("UFQFPN32") and !check_MCU("WLCSP36")) or (check_MCU("DIE425") or check_MCU("DIE457"))) {
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
                        "(!LQFP32 & !UFQFPN32 & !WLCSP36)|(DIE425|DIE457)",
                        "No Extra Log",
                        "RCC_RTC_Clock_Source_FROM_HSE",
                    });
                    HSERTCDevisor.nodetype = .div;
                    HSERTCDevisor.value = HSERTCDevisor_clk_value.get();
                    HSERTCDevisor.parents = &.{&HSEOSC};
                }
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
                &MSIRC,
                &HSIRCDiv,
                &HSEOSC,
                &PLLDIV,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

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
                &HSEOSC,
                &HSIRCDiv,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

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

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};

            const TIMPrescaler_clk_value = TimPrescalerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TIMPrescaler",
                "Else",
                "No Extra Log",
                "TimPrescaler",
            });
            TIMPrescaler.nodetype = .div;
            TIMPrescaler.value = TIMPrescaler_clk_value.get();
            TIMPrescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(TimerFreq_ValueValue);
            TIMOutput.nodetype = .output;
            TIMOutput.parents = &.{&TIMPrescaler};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
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
            TimPrescOut.nodetype = .output;
            TimPrescOut.parents = &.{&TimPrescalerAPB1};

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

            const PeriphPrescaler_clk_value = APB2TimCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PeriphPrescaler",
                "Else",
                "No Extra Log",
                "APB2TimCLKDivider",
            });
            PeriphPrescaler.nodetype = .mul;
            PeriphPrescaler.value = PeriphPrescaler_clk_value;
            PeriphPrescaler.parents = &.{&APB2Prescaler};

            std.mem.doNotOptimizeAway(APB2TimFreq_ValueValue);
            PeriphPrescOutput.nodetype = .output;
            PeriphPrescOutput.parents = &.{&PeriphPrescaler};
            if (!check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(LPTIMEnableValue), LPTIMEnableValue, .true, .@"=")) {
                    const LPTIMMult_clk_value = LptimClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LPTIMMult",
                        "!LPUART1_Exist",
                        "No Extra Log",
                        "LptimClockSelection",
                    });
                    const LPTIMMultparents = [_]*const ClockNode{
                        &LSIRC,
                        &HSIRCDiv,
                        &LSEOSC,
                        &APB1Prescaler,
                    };
                    LPTIMMult.nodetype = .multi;
                    LPTIMMult.parents = &.{LPTIMMultparents[LPTIMMult_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(LPTIMEnableValue), LPTIMEnableValue, .true, .@"=")) {
                const LPTIMMult_clk_value = LptimClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIMMult",
                    "Else",
                    "No Extra Log",
                    "LptimClockSelection",
                });
                const LPTIMMultparents = [_]*const ClockNode{
                    &LSIRC,
                    &HSIRCDiv,
                    &LSEOSC,
                    &APB1Prescaler,
                };
                LPTIMMult.nodetype = .multi;
                LPTIMMult.parents = &.{LPTIMMultparents[LPTIMMult_clk_value.get()]};
            }
            if (!check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(LPTIMEnableValue), LPTIMEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(LPTIMFreq_ValueValue);
                    LPTIMOutput.nodetype = .output;
                    LPTIMOutput.parents = &.{&LPTIMMult};
                }
            }
            if (check_ref(@TypeOf(LPTIMEnableValue), LPTIMEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTIMFreq_ValueValue);
                LPTIMOutput.nodetype = .output;
                LPTIMOutput.parents = &.{&LPTIMMult};
            }
            if (check_ref(@TypeOf(LPUARTEnableValue), LPUARTEnableValue, .true, .@"=")) {
                const LPUARTMult_clk_value = Lpuart1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUARTMult",
                    "Else",
                    "No Extra Log",
                    "Lpuart1ClockSelection",
                });
                const LPUARTMultparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &LSEOSC,
                    &HSIRCDiv,
                    &SysCLKOutput,
                };
                LPUARTMult.nodetype = .multi;
                LPUARTMult.parents = &.{LPUARTMultparents[LPUARTMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUARTEnableValue), LPUARTEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUARTFreq_ValueValue);
                LPUARTOutput.nodetype = .output;
                LPUARTOutput.parents = &.{&LPUARTMult};
            }
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                const USART2Mult_clk_value = Usart2ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART2Mult",
                    "Else",
                    "No Extra Log",
                    "Usart2ClockSelection",
                });
                const USART2Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &HSIRCDiv,
                    &LSEOSC,
                    &APB1Prescaler,
                };
                USART2Mult.nodetype = .multi;
                USART2Mult.parents = &.{USART2Multparents[USART2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART2Freq_ValueValue);
                USART2Output.nodetype = .output;
                USART2Output.parents = &.{&USART2Mult};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                const USART1Mult_clk_value = Usart1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART1Mult",
                    "Else",
                    "No Extra Log",
                    "Usart1ClockSelection",
                });
                const USART1Multparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                    &HSIRCDiv,
                    &LSEOSC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1Output.nodetype = .output;
                USART1Output.parents = &.{&USART1Mult};
            }
            if (!check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                    const I2C1Mult_clk_value = I2c1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "I2C1Mult",
                        "!LPUART1_Exist",
                        "No Extra Log",
                        "I2c1ClockSelection",
                    });
                    const I2C1Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &HSIRCDiv,
                        &SysCLKOutput,
                    };
                    I2C1Mult.nodetype = .multi;
                    I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                const I2C1Mult_clk_value = I2c1ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C1Mult",
                    "Else",
                    "No Extra Log",
                    "I2c1ClockSelection",
                });
                const I2C1Multparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &HSIRCDiv,
                    &SysCLKOutput,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (!check_MCU("LPUART1_Exist")) {
                if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                    I2C1Output.nodetype = .output;
                    I2C1Output.parents = &.{&I2C1Mult};
                }
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1Output.nodetype = .output;
                I2C1Output.parents = &.{&I2C1Mult};
            }
            if (check_MCU("I2C3_Exist")) {
                if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                    const I2C3Mult_clk_value = I2c3ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "I2C3Mult",
                        "I2C3_Exist",
                        "No Extra Log",
                        "I2c3ClockSelection",
                    });
                    const I2C3Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &HSIRCDiv,
                        &SysCLKOutput,
                    };
                    I2C3Mult.nodetype = .multi;
                    I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
                }
            }
            if (check_MCU("I2C3_Exist")) {
                if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(I2C3Freq_ValueValue);
                    I2C3Output.nodetype = .output;
                    I2C3Output.parents = &.{&I2C3Mult};
                }
            }
            if ((check_MCU("LQFP32") or check_MCU("UFQFPN32") or check_MCU("WLCSP36")) and (check_MCU("STM32L0x1") or check_MCU("STM32L0x0_Value_Line")) and !(check_MCU("DIE425") or check_MCU("DIE457"))) {
                if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                    const MCOMult_clk_value = RCC_MCOSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "MCOMult",
                        "(LQFP32 | UFQFPN32|WLCSP36)&(STM32L0x1 |STM32L0x0_Value_Line) &!(DIE425|DIE457)",
                        "No Extra Log",
                        "RCC_MCOSource",
                    });
                    const MCOMultparents = [_]*const ClockNode{
                        &LSEOSC,
                        &LSIRC,
                        &HSEOSC,
                        &HSIRCDiv,
                        &PLLDIV,
                        &SysCLKOutput,
                        &MSIRC,
                        &HSI48RC,
                    };
                    MCOMult.nodetype = .multi;
                    MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCOMult_clk_value = RCC_MCOSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCOMult",
                    "Else",
                    "No Extra Log",
                    "RCC_MCOSource",
                });
                const MCOMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &LSIRC,
                    &HSEOSC,
                    &HSIRCDiv,
                    &PLLDIV,
                    &SysCLKOutput,
                    &MSIRC,
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
                std.mem.doNotOptimizeAway(MCOPinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const HSI48MUL_clk_value = HSI48MClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSI48MUL",
                    "Else",
                    "No Extra Log",
                    "HSI48MClockSelection",
                });
                const HSI48MULparents = [_]*const ClockNode{
                    &DIV2USB,
                    &HSI48RC,
                };
                HSI48MUL.nodetype = .multi;
                HSI48MUL.parents = &.{HSI48MULparents[HSI48MUL_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(@"48USBFreq_ValueValue");
                @"48USBOutput".limit = @"48USBFreq_ValueLimit";
                @"48USBOutput".nodetype = .output;
                @"48USBOutput".parents = &.{&HSI48MUL};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(@"48RNGFreq_ValueValue");
                @"48RNGOutput".limit = @"48RNGFreq_ValueLimit";
                @"48RNGOutput".nodetype = .output;
                @"48RNGOutput".parents = &.{&HSI48MUL};
            }
            if (!(check_MCU("STM32L0x1") or check_MCU("STM32L0x0_Value_Line"))) {
                if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                    ADCOutput.nodetype = .output;
                    ADCOutput.parents = &.{&HSIRCDiv};
                }
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                ADCOutput.nodetype = .output;
                ADCOutput.parents = &.{&HSIRCDiv};
            }

            std.mem.doNotOptimizeAway(VCOInputFreq_ValueValue);
            VCOIIuput.limit = VCOInputFreq_ValueLimit;
            VCOIIuput.nodetype = .output;
            VCOIIuput.parents = &.{&PLLSource};

            const PLLMUL_clk_value = PLLMULValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLMUL",
                "Else",
                "No Extra Log",
                "PLLMUL",
            });
            PLLMUL.nodetype = .mul;
            PLLMUL.value = PLLMUL_clk_value.get();
            PLLMUL.parents = &.{&VCOIIuput};

            const PLLDIV_clk_value = PLLDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLDIV",
                "Else",
                "No Extra Log",
                "PLLDIV",
            });
            PLLDIV.nodetype = .div;
            PLLDIV.value = PLLDIV_clk_value.get();
            PLLDIV.parents = &.{&PLLMUL};
            if ((!check_MCU("STM32L0x1") and !check_MCU("STM32L0x0_Value_Line"))) {
                if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                    check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
                {
                    const DIV2USB_clk_value = DIV2USBValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "DIV2USB",
                        "(!STM32L0x1 & !STM32L0x0_Value_Line)",
                        "No Extra Log",
                        "DIV2USB",
                    });
                    DIV2USB.nodetype = .div;
                    DIV2USB.value = DIV2USB_clk_value;
                    DIV2USB.parents = &.{&PLLMUL};
                }
            }

            std.mem.doNotOptimizeAway(HSI_VALUEValue);
            HSI.nodetype = .output;
            HSI.parents = &.{&HSIRCDiv};

            std.mem.doNotOptimizeAway(MSI_VALUEValue);
            MSI.nodetype = .output;
            MSI.parents = &.{&MSIRC};

            std.mem.doNotOptimizeAway(RTCHSEDivFreq_ValueValue);
            HSE_RTC.limit = RTCHSEDivFreq_ValueLimit;
            HSE_RTC.nodetype = .output;
            HSE_RTC.parents = &.{&HSERTCDevisor};

            std.mem.doNotOptimizeAway(VCOOutputFreq_ValueValue);
            VCOOutput.limit = VCOOutputFreq_ValueLimit;
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLMUL};

            std.mem.doNotOptimizeAway(PLLCLKFreq_ValueValue);
            PLLCLK.limit = PLLCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLDIV};

            std.mem.doNotOptimizeAway(@"48CLKFreq_ValueValue");
            @"48CLK".nodetype = .output;
            @"48CLK".parents = &.{&DIV2USB};

            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.TIMOutput = try TIMOutput.get_output();
            out.TIMPrescaler = try TIMPrescaler.get_output();
            out.TimPrescOut = try TimPrescOut.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.LPTIMOutput = try LPTIMOutput.get_output();
            out.LPTIMMult = try LPTIMMult.get_output();
            out.LPUARTOutput = try LPUARTOutput.get_output();
            out.LPUARTMult = try LPUARTMult.get_output();
            out.USART2Output = try USART2Output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.I2C1Output = try I2C1Output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C3Output = try I2C3Output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.PeriphPrescOutput = try PeriphPrescOutput.get_output();
            out.PeriphPrescaler = try PeriphPrescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.USART1Output = try USART1Output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.PLLDIV = try PLLDIV.get_output();
            out.@"48USBOutput" = try @"48USBOutput".get_output();
            out.@"48RNGOutput" = try @"48RNGOutput".get_output();
            out.HSI48MUL = try HSI48MUL.get_output();
            out.DIV2USB = try DIV2USB.get_output();
            out.PLLMUL = try PLLMUL.get_output();
            out.VCOIIuput = try VCOIIuput.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.ADCOutput = try ADCOutput.get_output();
            out.HSIRCDiv = try HSIRCDiv.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.HSI48RC = try HSI48RC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.LCDOutput = try LCDOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.HSI = try HSI.get_extra_output();
            out.MSI = try MSI.get_extra_output();
            out.HSE_RTC = try HSE_RTC.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.@"48CLK" = try @"48CLK".get_extra_output();
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.HSIRCDiv = HSIRCDivValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.TimPrescaler = TimPrescalerValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.LptimClockSelection = LptimClockSelectionValue;
            ref_out.Lpuart1ClockSelection = Lpuart1ClockSelectionValue;
            ref_out.Usart2ClockSelection = Usart2ClockSelectionValue;
            ref_out.Usart1ClockSelection = Usart1ClockSelectionValue;
            ref_out.I2c1ClockSelection = I2c1ClockSelectionValue;
            ref_out.I2c3ClockSelection = I2c3ClockSelectionValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.HSI48MClockSelection = HSI48MClockSelectionValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.PLLDIV = PLLDIVValue;
            ref_out.DIV2USB = DIV2USBValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
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
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.EnableHSELCDDevisor = EnableHSELCDDevisorValue;
            ref_out.LPTIMEnable = LPTIMEnableValue;
            ref_out.LPUARTEnable = LPUARTEnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.@"48MEnable" = @"48MEnableValue";
            ref_out.LSIUsed = LSIUsedValue;
            ref_out.HSI48Used = HSI48UsedValue;
            ref_out.MSIUsed = MSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
