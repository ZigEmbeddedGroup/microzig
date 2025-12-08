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

pub const RCC_RTC_Clock_SourceList = enum {
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
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 0,
            .RCC_PLLSOURCE_HSE => 1,
        };
    }
};
pub const PLLI2SSourceList = enum {
    RCC_PLLI2SCLKSOURCE_PLLSRC,
    RCC_PLLI2SCLKSOURCE_EXT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLI2SCLKSOURCE_PLLSRC => 0,
            .RCC_PLLI2SCLKSOURCE_EXT => 1,
        };
    }
};
pub const SYSCLKSourceList = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_HSE => 1,
            .RCC_SYSCLKSOURCE_PLLCLK => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_HSE => 1,
            .RCC_MCO1SOURCE_HSI => 2,
            .RCC_MCO1SOURCE_PLLCLK => 3,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_PLLI2SCLK,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_PLLCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_SYSCLK => 0,
            .RCC_MCO2SOURCE_PLLI2SCLK => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_PLLCLK => 3,
        };
    }
};
pub const I2S1CLockSelectionList = enum {
    RCC_I2SAPB1CLKSOURCE_PLLR,
    RCC_I2SAPB1CLKSOURCE_PLLI2S,
    RCC_I2SAPB1CLKSOURCE_EXT,
    RCC_I2SAPB1CLKSOURCE_PLLSRC,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SAPB1CLKSOURCE_PLLR => 0,
            .RCC_I2SAPB1CLKSOURCE_PLLI2S => 1,
            .RCC_I2SAPB1CLKSOURCE_EXT => 2,
            .RCC_I2SAPB1CLKSOURCE_PLLSRC => 3,
        };
    }
};
pub const I2S2CLockSelectionList = enum {
    RCC_I2SAPB2CLKSOURCE_PLLR,
    RCC_I2SAPB2CLKSOURCE_PLLI2S,
    RCC_I2SAPB2CLKSOURCE_EXT,
    RCC_I2SAPB2CLKSOURCE_PLLSRC,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SAPB2CLKSOURCE_PLLR => 0,
            .RCC_I2SAPB2CLKSOURCE_PLLI2S => 1,
            .RCC_I2SAPB2CLKSOURCE_EXT => 2,
            .RCC_I2SAPB2CLKSOURCE_PLLSRC => 3,
        };
    }
};
pub const FMPI2C1SelectionList = enum {
    RCC_FMPI2C1CLKSOURCE_HSI,
    RCC_FMPI2C1CLKSOURCE_APB,
    RCC_FMPI2C1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_FMPI2C1CLKSOURCE_HSI => 0,
            .RCC_FMPI2C1CLKSOURCE_APB => 1,
            .RCC_FMPI2C1CLKSOURCE_SYSCLK => 2,
        };
    }
};
pub const DFSDMSelectionList = enum {
    RCC_DFSDM1CLKSOURCE_APB2,
    RCC_DFSDM1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1CLKSOURCE_APB2 => 0,
            .RCC_DFSDM1CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const USBCLockSelectionList = enum {
    RCC_CLK48CLKSOURCE_PLLQ,
    RCC_CLK48CLKSOURCE_PLLI2SQ,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLK48CLKSOURCE_PLLQ => 0,
            .RCC_CLK48CLKSOURCE_PLLI2SQ => 1,
        };
    }
};
pub const SDIOCLockSelectionList = enum {
    RCC_SDIOCLKSOURCE_SYSCLK,
    RCC_SDIOCLKSOURCE_CLK48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SDIOCLKSOURCE_SYSCLK => 0,
            .RCC_SDIOCLKSOURCE_CLK48 => 1,
        };
    }
};
pub const DFSDMAudioSelectionList = enum {
    RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB1,
    RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB1 => 0,
            .RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB2 => 1,
        };
    }
};
pub const DFSDM2AudioSelectionList = enum {
    RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB1,
    RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB1 => 0,
            .RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB2 => 1,
        };
    }
};
pub const SAI1ACLockSourceSelectionList = enum {
    RCC_SAIACLKSOURCE_PLLSRC,
    RCC_SAIACLKSOURCE_PLLR,
    RCC_SAIACLKSOURCE_PLLI2SR,
    RCC_SAIACLKSOURCE_EXT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAIACLKSOURCE_PLLSRC => 0,
            .RCC_SAIACLKSOURCE_PLLR => 1,
            .RCC_SAIACLKSOURCE_PLLI2SR => 2,
            .RCC_SAIACLKSOURCE_EXT => 3,
        };
    }
};
pub const SAI1BCLockSourceSelectionList = enum {
    RCC_SAIBCLKSOURCE_PLLSRC,
    RCC_SAIBCLKSOURCE_PLLR,
    RCC_SAIBCLKSOURCE_PLLI2SR,
    RCC_SAIBCLKSOURCE_EXT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAIBCLKSOURCE_PLLSRC => 0,
            .RCC_SAIBCLKSOURCE_PLLR => 1,
            .RCC_SAIBCLKSOURCE_PLLI2SR => 2,
            .RCC_SAIBCLKSOURCE_EXT => 3,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK => 0,
            .RCC_LPTIM1CLKSOURCE_LSI => 1,
            .RCC_LPTIM1CLKSOURCE_HSI => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
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
        };
    }
};
pub const RCC_MCODiv1List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
        };
    }
};
pub const RCC_MCODiv2List = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_3,
    RCC_MCODIV_4,
    RCC_MCODIV_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_3 => 3,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_5 => 5,
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
pub const PLLPList = enum {
    RCC_PLLP_DIV2,
    RCC_PLLP_DIV4,
    RCC_PLLP_DIV6,
    RCC_PLLP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLP_DIV2 => 2,
            .RCC_PLLP_DIV4 => 4,
            .RCC_PLLP_DIV6 => 6,
            .RCC_PLLP_DIV8 => 8,
        };
    }
};
pub const INSTRUCTION_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const PREFETCH_ENABLEList = enum {
    @"0",
    @"1",
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
    FLASH_LATENCY_3,
    FLASH_LATENCY_4,
    FLASH_LATENCY_5,
    FLASH_LATENCY_6,
    FLASH_LATENCY_7,
    FLASH_LATENCY_8,
};
pub const RCC_TIM_PRescaler_SelectionList = enum {
    RCC_TIMPRES_ACTIVATED,
    RCC_TIMPRES_DESACTIVATED,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE3,
};
pub const ExtClockEnableList = enum {
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
pub const EnableHSERTCDevisorList = enum {
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
pub const EnableI2S1List = enum {
    true,
    false,
};
pub const EnableDFSDMAudioList = enum {
    true,
    false,
};
pub const EnableDFSDM2AudioList = enum {
    true,
    false,
};
pub const EnableI2S2List = enum {
    true,
    false,
};
pub const EnableFMPI2C1List = enum {
    true,
    false,
};
pub const EnableDFSDMList = enum {
    true,
    false,
};
pub const EnableDFSDM2List = enum {
    true,
    false,
};
pub const EnableUSBList = enum {
    true,
    false,
};
pub const EnableSDIOList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const EnableSAI1AList = enum {
    true,
    false,
};
pub const EnableSAI1BList = enum {
    true,
    false,
};
pub const EnableLPTimerList = enum {
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
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCO1Config: bool = false,
            MCO2Config: bool = false,
            AudioClockConfig: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            USB_OTG_HSEmbeddedPHYUsed_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            DFSDM1Used_ForRCC: bool = false,
            DFSDM2Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            I2S4Used_ForRCC: bool = false,
            I2S5Used_ForRCC: bool = false,
            FMPI2C1Used_ForRCC: bool = false,
            SAI1Used_ForRCC: bool = false,
            SAIAUsed_ForRCC: bool = false,
            SAIBUsed_ForRCC: bool = false,
            LPTIMUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?u32 = null,
            PLLI2SSource: ?PLLI2SSourceList = null,
            PLLI2SM: ?u32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            I2S1CLockSelection: ?I2S1CLockSelectionList = null,
            I2S2CLockSelection: ?I2S2CLockSelectionList = null,
            FMPI2C1Selection: ?FMPI2C1SelectionList = null,
            DFSDMSelection: ?DFSDMSelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            SDIOCLockSelection: ?SDIOCLockSelectionList = null,
            DFSDMAudioSelection: ?DFSDMAudioSelectionList = null,
            DFSDM2AudioSelection: ?DFSDM2AudioSelectionList = null,
            SAI1ACLockSourceSelection: ?SAI1ACLockSourceSelectionList = null,
            PLLDivR: ?u32 = null,
            SAI1BCLockSourceSelection: ?SAI1BCLockSourceSelectionList = null,
            PLLI2SDivR: ?u32 = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?u32 = null,
            PLLR: ?u32 = null,
            PLLI2SN: ?u32 = null,
            PLLI2SQ: ?u32 = null,
            PLLI2SR: ?u32 = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            I2S_CKIN: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            PLLI2SSRC: f32 = 0,
            PLLI2SM: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            AHBPrescaler: f32 = 0,
            PWRCLKoutput: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            I2S1Mult: f32 = 0,
            I2S1output: f32 = 0,
            I2S2Mult: f32 = 0,
            I2S2output: f32 = 0,
            FMPI2C1Mult: f32 = 0,
            FMPI2C1output: f32 = 0,
            DFSDMMult: f32 = 0,
            DFSDMoutput: f32 = 0,
            DFSDM2output: f32 = 0,
            USBMult: f32 = 0,
            USBoutput: f32 = 0,
            RNGoutput: f32 = 0,
            SDIOMult: f32 = 0,
            SDIOoutput: f32 = 0,
            DFSDMAudioMult: f32 = 0,
            DFSDMAudiooutput: f32 = 0,
            DFSDM2AudioMult: f32 = 0,
            DFSDM2Audiooutput: f32 = 0,
            SAI1AMult: f32 = 0,
            SAI1Aoutput: f32 = 0,
            SAI1APrescaler: f32 = 0,
            SAI1BMult: f32 = 0,
            SAI1Boutput: f32 = 0,
            SAI1BPrescaler: f32 = 0,
            LPTimerMult: f32 = 0,
            LPTimeroutput: f32 = 0,
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLQ: f32 = 0,
            PLLQoutput: f32 = 0,
            PLLR: f32 = 0,
            PLLRoutput: f32 = 0,
            PLLI2SN: f32 = 0,
            PLLI2SQ: f32 = 0,
            PLLI2SQoutput: f32 = 0,
            PLLI2SR: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?f32 = null, //from RCC Clock Config
            PLLI2SSource: ?PLLI2SSourceList = null, //from RCC Clock Config
            PLLI2SM: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            I2S1CLockSelection: ?I2S1CLockSelectionList = null, //from RCC Clock Config
            I2S2CLockSelection: ?I2S2CLockSelectionList = null, //from RCC Clock Config
            FMPI2C1Selection: ?FMPI2C1SelectionList = null, //from RCC Clock Config
            DFSDMSelection: ?DFSDMSelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            SDIOCLockSelection: ?SDIOCLockSelectionList = null, //from RCC Clock Config
            DFSDMAudioSelection: ?DFSDMAudioSelectionList = null, //from RCC Clock Config
            DFSDM2AudioSelection: ?DFSDM2AudioSelectionList = null, //from RCC Clock Config
            SAI1ACLockSourceSelection: ?SAI1ACLockSourceSelectionList = null, //from RCC Clock Config
            PLLDivR: ?f32 = null, //from RCC Clock Config
            SAI1BCLockSourceSelection: ?SAI1BCLockSourceSelectionList = null, //from RCC Clock Config
            PLLI2SDivR: ?f32 = null, //from RCC Clock Config
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLP: ?PLLPList = null, //from RCC Clock Config
            PLLQ: ?f32 = null, //from RCC Clock Config
            PLLR: ?f32 = null, //from RCC Clock Config
            PLLI2SN: ?f32 = null, //from RCC Clock Config
            PLLI2SQ: ?f32 = null, //from RCC Clock Config
            PLLI2SR: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            EnableI2S1: ?EnableI2S1List = null, //from extra RCC references
            EnableDFSDMAudio: ?EnableDFSDMAudioList = null, //from extra RCC references
            EnableDFSDM2Audio: ?EnableDFSDM2AudioList = null, //from extra RCC references
            EnableI2S2: ?EnableI2S2List = null, //from extra RCC references
            EnableFMPI2C1: ?EnableFMPI2C1List = null, //from extra RCC references
            EnableDFSDM: ?EnableDFSDMList = null, //from extra RCC references
            EnableDFSDM2: ?EnableDFSDM2List = null, //from extra RCC references
            EnableUSB: ?EnableUSBList = null, //from extra RCC references
            EnableSDIO: ?EnableSDIOList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            EnableSAI1A: ?EnableSAI1AList = null, //from extra RCC references
            EnableSAI1B: ?EnableSAI1BList = null, //from extra RCC references
            EnableLPTimer: ?EnableLPTimerList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            HSEUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            LSIUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            PLLI2SUsed: ?f32 = null, //from extra RCC references
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

            var PLLSourceI2SPLL: bool = false;
            var PLLSourceI2SEXT: bool = false;
            var SysSourceIsHSI: bool = false;
            var SysSourceIsHSE: bool = false;
            var SysSourceIsPLLclk: bool = false;
            var MCOSourceIsPLLI2SP: bool = false;
            var I2S1SourceIsPllR: bool = false;
            var I2S1SourceIsPLLI2SR: bool = false;
            var I2S1SourceIsEXT: bool = false;
            var I2S1SourceIsPllsrc: bool = false;
            var I2S2SourceIsPllR: bool = false;
            var I2S2SourceIsPLLI2SR: bool = false;
            var I2S2SourceIsEXT: bool = false;
            var I2S2SourceIsPllsrc: bool = false;
            var DFSDMisAPB2: bool = false;
            var DFSDMissys: bool = false;
            var USBSourceisPLLQ: bool = false;
            var USBSourceisPLLI2SQ: bool = false;
            var SDIOSourceIsSysclk: bool = false;
            var SDIOSourceIsClock48: bool = false;
            var DFSDMADSourceI2S1: bool = false;
            var DFSDMADSourceI2S2: bool = false;
            var DFSDM2ADSourceI2S1: bool = false;
            var DFSDM2ADSourceI2S2: bool = false;
            var SAI1ASourceIsPllsrc: bool = false;
            var SAI1ASourceIsPllR: bool = false;
            var SAI1ASourceIsPLLI2SR: bool = false;
            var SAI1ASourceIsEXT: bool = false;
            var SAI1BSourceIsPllsrc: bool = false;
            var SAI1BSourceIsPllR: bool = false;
            var SAI1BSourceIsPLLI2SR: bool = false;
            var SAI1BSourceIsEXT: bool = false;
            var LPTimerSourceIsPclk: bool = false;
            var LPTimerSourceIsLSI: bool = false;
            var LPTimerSourceIsHSI: bool = false;
            var LPTimerSourceIsLSE: bool = false;
            var HCLKDiv1: bool = false;
            var TimPrescalerEnabled: bool = false;
            var RTCFreq_ValueLimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var MCO1PinFreq_ValueLimit: Limit = .{};
            var MCO2PinFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var USBFreq_ValueLimit: Limit = .{};
            var RNGFreq_ValueLimit: Limit = .{};
            var SDIOFreq_ValueLimit: Limit = .{};
            var PLLI2SQCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass) {
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
                                "HSEByPass",
                                "HSEByPass",
                                1e6,
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
                    if (val > 2.6e7) {
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
                            2.6e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 25000000;
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
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const RCC_RTC_Clock_SourceValue: ?RCC_RTC_Clock_SourceList = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11")))) {
                    const conf_item = config.RCC_RTC_Clock_Source;
                    if (conf_item) |item| {
                        switch (item) {
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                , .{ "RCC_RTC_Clock_Source", "((HSEByPass|HSEOscillator)&(SEM2RCC_HSE_REQUIRED_TIM11 & TIM11 & Semaphore_input_Channel1TIM11))", "RTC Mux should have HSE as input when TIM11 remap is used", item });
                            },
                        }
                    }

                    break :blk conf_item orelse null;
                }
                const conf_item = config.RCC_RTC_Clock_Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_LSE => {},
                        .RCC_RTCCLKSOURCE_LSI => {},
                        else => {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Option not available in this condition: {any}.
                                \\note: available options:
                                \\ - RCC_RTCCLKSOURCE_LSE
                                \\ - RCC_RTCCLKSOURCE_LSI
                            , .{ "RCC_RTC_Clock_Source", "Else", "No Extra Log", item });
                        },
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                if ((!(check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) {
                    RTCFreq_ValueLimit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };
                    break :blk null;
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

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_HSE_DIV2;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if (((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC))) {
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
                            , .{ "PLLSource", "((USB_OTG_FSUsed_ForRCC|USB_OTG_HSEmbeddedPHYUsed_ForRCC)) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
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
            const PLLMValue: ?f32 = blk: {
                const config_val = config.PLLM;
                if (config_val) |val| {
                    if (val < 2) {
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
                            2,
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const PLLI2SSourceValue: ?PLLI2SSourceList = blk: {
                const conf_item = config.PLLI2SSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLI2SCLKSOURCE_PLLSRC => PLLSourceI2SPLL = true,
                        .RCC_PLLI2SCLKSOURCE_EXT => PLLSourceI2SEXT = true,
                    }
                }

                break :blk conf_item;
            };
            const PLLI2SMValue: ?f32 = blk: {
                const config_val = config.PLLI2SM;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SM",
                            "Else",
                            "No Extra Log",
                            2,
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
                            "PLLI2SM",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SysSourceIsHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceIsHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourceIsPLLclk = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_PLLCLK => {},
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
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                MCO1PinFreq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_SYSCLK => {},
                        .RCC_MCO2SOURCE_PLLI2SCLK => MCOSourceIsPLLI2SP = true,
                        .RCC_MCO2SOURCE_HSE => {},
                        .RCC_MCO2SOURCE_PLLCLK => {},
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
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                MCO2PinFreq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
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
            const PWRFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    HCLKFreq_ValueLimit = .{
                        .min = 3e7,
                        .max = 1e8,
                    };
                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 1.42e7,
                        .max = 1e8,
                    };
                    break :blk null;
                }
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 1e8,
                };
                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
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
                break :blk 2e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
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
                if (config.flags.RTCUsed_ForRCC) {
                    const min: ?f32 = try math_op(@TypeOf(RTCFreq_ValueValue), RTCFreq_ValueValue, 4, .@"*", "APB1Freq_Value", "RTCFreq_Value", "4");
                    const max: ?f32 = @min(50000000, std.math.floatMax(f32));
                    APB1Freq_ValueLimit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value*4",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
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
                break :blk 1.6e7;
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
                    .max = 1e8,
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
                break :blk 1.6e7;
            };
            const I2S1CLockSelectionValue: ?I2S1CLockSelectionList = blk: {
                const conf_item = config.I2S1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2SAPB1CLKSOURCE_PLLSRC => I2S1SourceIsPllsrc = true,
                        .RCC_I2SAPB1CLKSOURCE_PLLR => I2S1SourceIsPllR = true,
                        .RCC_I2SAPB1CLKSOURCE_EXT => I2S1SourceIsEXT = true,
                        .RCC_I2SAPB1CLKSOURCE_PLLI2S => I2S1SourceIsPLLI2SR = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2SAPB1CLKSOURCE_PLLI2S;
            };
            const I2S1Freq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const I2S2CLockSelectionValue: ?I2S2CLockSelectionList = blk: {
                const conf_item = config.I2S2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2SAPB2CLKSOURCE_PLLSRC => I2S2SourceIsPllsrc = true,
                        .RCC_I2SAPB2CLKSOURCE_PLLR => I2S2SourceIsPllR = true,
                        .RCC_I2SAPB2CLKSOURCE_EXT => I2S2SourceIsEXT = true,
                        .RCC_I2SAPB2CLKSOURCE_PLLI2S => I2S2SourceIsPLLI2SR = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2SAPB2CLKSOURCE_PLLI2S;
            };
            const I2S2Freq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const FMPI2C1SelectionValue: ?FMPI2C1SelectionList = blk: {
                const conf_item = config.FMPI2C1Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_FMPI2C1CLKSOURCE_SYSCLK => {},
                        .RCC_FMPI2C1CLKSOURCE_HSI => {},
                        .RCC_FMPI2C1CLKSOURCE_APB => {},
                    }
                }

                break :blk conf_item orelse .RCC_FMPI2C1CLKSOURCE_APB;
            };
            const FMPI2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const DFSDMSelectionValue: ?DFSDMSelectionList = blk: {
                const conf_item = config.DFSDMSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1CLKSOURCE_APB2 => DFSDMisAPB2 = true,
                        .RCC_DFSDM1CLKSOURCE_SYSCLK => DFSDMissys = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM1CLKSOURCE_APB2;
            };
            const DFSDMFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const DFSDM2Freq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLK48CLKSOURCE_PLLQ => USBSourceisPLLQ = true,
                        .RCC_CLK48CLKSOURCE_PLLI2SQ => USBSourceisPLLI2SQ = true,
                    }
                }

                break :blk conf_item orelse .RCC_CLK48CLKSOURCE_PLLQ;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    USBFreq_ValueLimit = .{
                        .min = 4.788e7,
                        .max = 4.812e7,
                    };
                    break :blk null;
                }
                break :blk 4.8e7;
            };
            const RNGFreq_ValueValue: ?f32 = blk: {
                RNGFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };
                break :blk null;
            };
            const SDIOCLockSelectionValue: ?SDIOCLockSelectionList = blk: {
                const conf_item = config.SDIOCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDIOCLKSOURCE_CLK48 => SDIOSourceIsClock48 = true,
                        .RCC_SDIOCLKSOURCE_SYSCLK => SDIOSourceIsSysclk = true,
                    }
                }

                break :blk conf_item orelse .RCC_SDIOCLKSOURCE_CLK48;
            };
            const SDIOFreq_ValueValue: ?f32 = blk: {
                SDIOFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
                };
                break :blk null;
            };
            const DFSDMAudioSelectionValue: ?DFSDMAudioSelectionList = blk: {
                const conf_item = config.DFSDMAudioSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB1 => DFSDMADSourceI2S1 = true,
                        .RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB2 => DFSDMADSourceI2S2 = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM1AUDIOCLKSOURCE_I2SAPB1;
            };
            const DFSDMAudioFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const DFSDM2AudioSelectionValue: ?DFSDM2AudioSelectionList = blk: {
                const conf_item = config.DFSDM2AudioSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB1 => DFSDM2ADSourceI2S1 = true,
                        .RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB2 => DFSDM2ADSourceI2S2 = true,
                    }
                }

                break :blk conf_item orelse .RCC_DFSDM2AUDIOCLKSOURCE_I2SAPB1;
            };
            const DFSDM2AudioFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const SAI1ACLockSourceSelectionValue: ?SAI1ACLockSourceSelectionList = blk: {
                const conf_item = config.SAI1ACLockSourceSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAIACLKSOURCE_PLLSRC => SAI1ASourceIsPllsrc = true,
                        .RCC_SAIACLKSOURCE_PLLR => SAI1ASourceIsPllR = true,
                        .RCC_SAIACLKSOURCE_PLLI2SR => SAI1ASourceIsPLLI2SR = true,
                        .RCC_SAIACLKSOURCE_EXT => SAI1ASourceIsEXT = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAIACLKSOURCE_PLLSRC;
            };
            const SAI1AFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLLDivRValue: ?f32 = blk: {
                const config_val = config.PLLDivR;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLDivR",
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
                            "PLLDivR",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const SAI1BCLockSourceSelectionValue: ?SAI1BCLockSourceSelectionList = blk: {
                const conf_item = config.SAI1BCLockSourceSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAIBCLKSOURCE_PLLSRC => SAI1BSourceIsPllsrc = true,
                        .RCC_SAIBCLKSOURCE_PLLR => SAI1BSourceIsPllR = true,
                        .RCC_SAIBCLKSOURCE_PLLI2SR => SAI1BSourceIsPLLI2SR = true,
                        .RCC_SAIBCLKSOURCE_EXT => SAI1BSourceIsEXT = true,
                    }
                }

                break :blk conf_item orelse .RCC_SAIBCLKSOURCE_PLLSRC;
            };
            const SAI1BFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLLI2SDivRValue: ?f32 = blk: {
                const config_val = config.PLLI2SDivR;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SDivR",
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
                            "PLLI2SDivR",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_PCLK => LPTimerSourceIsPclk = true,
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTimerSourceIsLSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTimerSourceIsHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTimerSourceIsLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK;
            };
            const LPTimerFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 50) {
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
                            50,
                            val,
                        });
                    }
                    if (val > 432) {
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
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLPValue: ?PLLPList = blk: {
                const conf_item = config.PLLP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLP_DIV2 => {},
                        .RCC_PLLP_DIV4 => {},
                        .RCC_PLLP_DIV6 => {},
                        .RCC_PLLP_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLP_DIV2;
            };
            const PLLQValue: ?f32 = blk: {
                const config_val = config.PLLQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLQ",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 15) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLQoutputFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLLRValue: ?f32 = blk: {
                const config_val = config.PLLR;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLR",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLR",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLRoutputFreq_ValueValue: ?f32 = blk: {
                break :blk 9.6e7;
            };
            const PLLI2SNValue: ?f32 = blk: {
                const config_val = config.PLLI2SN;
                if (config_val) |val| {
                    if (val < 50) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SN",
                            "Else",
                            "No Extra Log",
                            50,
                            val,
                        });
                    }
                    if (val > 432) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SN",
                            "Else",
                            "No Extra Log",
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLI2SQValue: ?f32 = blk: {
                const config_val = config.PLLI2SQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQ",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 15) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLI2SQCLKFreq_ValueValue: ?f32 = blk: {
                if ((USBSourceisPLLI2SQ and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC)))) {
                    PLLI2SQCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLI2SRValue: ?f32 = blk: {
                const config_val = config.PLLI2SR;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SR",
                            "Else",
                            "No Extra Log",
                            2,
                            val,
                        });
                    }
                    if (val > 7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SR",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.7e0) {
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
                            1.7e0,
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
            const INSTRUCTION_CACHE_ENABLEValue: ?INSTRUCTION_CACHE_ENABLEList = blk: {
                const conf_item = config.extra.INSTRUCTION_CACHE_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
            };
            const PREFETCH_ENABLEValue: ?PREFETCH_ENABLEList = blk: {
                if ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<"))) {
                    const item: PREFETCH_ENABLEList = .@"0";
                    const conf_item = config.extra.PREFETCH_ENABLE;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PREFETCH_ENABLE", "(VDD_VALUE < 2.1)", "No Extra Log", "0", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.PREFETCH_ENABLE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"0" => {},
                    }
                }

                break :blk conf_item orelse .@"1";
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
            const FLatencyValue: ?FLatencyList = blk: {
                if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 25000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 25000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 18000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 18000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) & ((HCLKFreq_Value > 0) &((HCLKFreq_Value <  25000000)|(HCLKFreq_Value =25000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value <  20000000)|(HCLKFreq_Value =20000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value <  18000000)|(HCLKFreq_Value= 18000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value =16000000))))) ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 25000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 50000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 50000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 18000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 36000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 36000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 16000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) & ((HCLKFreq_Value > 25000000) & ((HCLKFreq_Value <  50000000)|(HCLKFreq_Value= 50000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value >  20000000) & ((HCLKFreq_Value <  40000000)|(HCLKFreq_Value= 40000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value >  18000000) & ((HCLKFreq_Value <  36000000)|(HCLKFreq_Value =36000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 16000000) & ((HCLKFreq_Value <  32000000)|(HCLKFreq_Value= 32000000)))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 50000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 75000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 75000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 36000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 54000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 54000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 32000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) & ((HCLKFreq_Value > 50000000) & ((HCLKFreq_Value <  75000000)|(HCLKFreq_Value= 75000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value >  40000000) & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value = 60000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value >  36000000) & ((HCLKFreq_Value < 54000000)|(HCLKFreq_Value=  54000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 32000000) & ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value=  48000000)))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 75000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 54000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6)))& ((HCLKFreq_Value >  75000000) & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value = 100000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value >60000000) & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value = 80000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) &  ((HCLKFreq_Value > 54000000) & ((HCLKFreq_Value < 72000000)|(HCLKFreq_Value = 72000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 48000000) & ((HCLKFreq_Value < 64000000)|(HCLKFreq_Value=  64000000))))) ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@">"))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value >  80000000) & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value = 100000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & (((HCLKFreq_Value > 72000000) )& ((HCLKFreq_Value < 90000000)|(HCLKFreq_Value = 90000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 64000000) & ((HCLKFreq_Value <  80000000)|(HCLKFreq_Value =80000000))))) ªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"=")))))))
                {
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
                            , .{ "FLatency", "(\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value >  90000000) & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value = 100000000))))|\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 80000000)& ((HCLKFreq_Value < 96000000)|(HCLKFreq_Value = 96000000)) ))) ªªªªªªªª", "No Extra Log", "FLASH_LATENCY_5", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"=")))))) {
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
                            , .{ "FLatency", "(\r\n\t\t\r\n\t\t((((VDD_VALUE > 1.71)|(VDD_VALUE=1.71)) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & (HCLKFreq_Value >  96000000) & ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value = 100000000))) )ªªªªªªªª", "No Extra Log", "FLASH_LATENCY_6", i });
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
                        .FLASH_LATENCY_8 => {},
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
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 84000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value  > 84000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 64000000, .@">"))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE2
                                    \\ - PWR_REGULATOR_VOLTAGE_SCALE1
                                , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value  > 64000000)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
                }
                const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                if (conf_item) |item| {
                    switch (item) {
                        .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                    }
                }

                break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE1;
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
            const ExtClockEnableValue: ?ExtClockEnableList = blk: {
                if (config.flags.AudioClockConfig) {
                    const item: ExtClockEnableList = .true;
                    break :blk item;
                }
                const item: ExtClockEnableList = .false;
                break :blk item;
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTCUsed_ForRCC or ((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11")))) {
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
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC) and (config.flags.HSEOscillator or config.flags.HSEByPass) or ((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11")))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
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
            const EnableI2S1Value: ?EnableI2S1List = blk: {
                if ((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) {
                    const item: EnableI2S1List = .true;
                    break :blk item;
                }
                const item: EnableI2S1List = .false;
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
            const EnableDFSDM2AudioValue: ?EnableDFSDM2AudioList = blk: {
                if (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2")) {
                    const item: EnableDFSDM2AudioList = .true;
                    break :blk item;
                }
                const item: EnableDFSDM2AudioList = .false;
                break :blk item;
            };
            const EnableI2S2Value: ?EnableI2S2List = blk: {
                if ((config.flags.I2S1Used_ForRCC or config.flags.I2S4Used_ForRCC or config.flags.I2S5Used_ForRCC)) {
                    const item: EnableI2S2List = .true;
                    break :blk item;
                }
                const item: EnableI2S2List = .false;
                break :blk item;
            };
            const EnableFMPI2C1Value: ?EnableFMPI2C1List = blk: {
                if (config.flags.FMPI2C1Used_ForRCC) {
                    const item: EnableFMPI2C1List = .true;
                    break :blk item;
                }
                const item: EnableFMPI2C1List = .false;
                break :blk item;
            };
            const EnableDFSDMValue: ?EnableDFSDMList = blk: {
                if (config.flags.DFSDM1Used_ForRCC) {
                    const item: EnableDFSDMList = .true;
                    break :blk item;
                }
                const item: EnableDFSDMList = .false;
                break :blk item;
            };
            const EnableDFSDM2Value: ?EnableDFSDM2List = blk: {
                if (config.flags.DFSDM2Used_ForRCC) {
                    const item: EnableDFSDM2List = .true;
                    break :blk item;
                }
                const item: EnableDFSDM2List = .false;
                break :blk item;
            };
            const EnableUSBValue: ?EnableUSBList = blk: {
                if ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC)) {
                    const item: EnableUSBList = .true;
                    break :blk item;
                }
                const item: EnableUSBList = .false;
                break :blk item;
            };
            const EnableSDIOValue: ?EnableSDIOList = blk: {
                if (config.flags.SDIOUsed_ForRCC) {
                    const item: EnableSDIOList = .true;
                    break :blk item;
                }
                const item: EnableSDIOList = .false;
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
            const EnableSAI1AValue: ?EnableSAI1AList = blk: {
                if (config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) {
                    const item: EnableSAI1AList = .true;
                    break :blk item;
                }
                const item: EnableSAI1AList = .false;
                break :blk item;
            };
            const EnableSAI1BValue: ?EnableSAI1BList = blk: {
                if (config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC) {
                    const item: EnableSAI1BList = .true;
                    break :blk item;
                }
                const item: EnableSAI1BList = .false;
                break :blk item;
            };
            const EnableLPTimerValue: ?EnableLPTimerList = blk: {
                if (config.flags.LPTIMUsed_ForRCC) {
                    const item: EnableLPTimerList = .true;
                    break :blk item;
                }
                const item: EnableLPTimerList = .false;
                break :blk item;
            };
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass) or ((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11")))) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11"))) or config.flags.RTCUsed_ForRCC) and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
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
            const PLLI2SUsedValue: ?f32 = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or (I2S1SourceIsPLLI2SR and ((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S1) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S1))) or (I2S2SourceIsPLLI2SR and ((config.flags.I2S1Used_ForRCC or config.flags.I2S4Used_ForRCC or config.flags.I2S5Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S2) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S2))) or ((config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.RNGUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC)) and USBSourceisPLLI2SQ) or SAI1ASourceIsPLLI2SR and (config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or SAI1BSourceIsPLLI2SR and (config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSEUsedValue: ?f32 = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11"))) or (config.flags.RTCUsed_ForRCC and !((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and ((((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SAI1ASourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or (SAI1BSourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) or config.flags.RNGUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (config.flags.SDIOUsed_ForRCC and SDIOSourceIsClock48) or SysSourceIsPLLclk or (check_MCU("PLLSourceHSE") and !I2S1SourceIsPLLI2SR and !I2S1SourceIsEXT and ((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S1) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S1))) or (check_MCU("PLLSourceHSE") and !I2S2SourceIsPLLI2SR and !I2S2SourceIsEXT and ((config.flags.I2S1Used_ForRCC or config.flags.I2S4Used_ForRCC or config.flags.I2S5Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S2) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S2))))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and (config.flags.MCO1Config)) or (((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_HSE, .@"=")) or (MCOSourceIsPLLI2SP and (check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")))) and (config.flags.MCO2Config)) or ((check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"=")) and PLLSourceI2SPLL and check_MCU("PLLSourceHSE")) or !SAI1ASourceIsEXT and !PLLSourceI2SEXT and check_MCU("PLLSourceHSE") and (config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or !SAI1BSourceIsEXT and !PLLSourceI2SEXT and check_MCU("PLLSourceHSE") and (config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSE_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or LPTimerSourceIsLSE and config.flags.LPTIMUsed_ForRCC or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and (config.flags.MCO1Config)) or ((check_MCU("RTCSourceLSE")) and config.flags.RTCUsed_ForRCC) or ((check_MCU("CECClockSelection")) and config.flags.CECUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(PLLI2SUsedValue), PLLI2SUsedValue, 1, .@"=")) and PLLSourceI2SPLL and check_MCU("PLLSourceHSI")) or (((MCOSourceIsPLLI2SP and (check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI, .@"=")))) and (config.flags.MCO2Config)) or ((check_ref(@TypeOf(FMPI2C1SelectionValue), FMPI2C1SelectionValue, .RCC_FMPI2C1CLKSOURCE_HSI, .@"=")) and config.flags.FMPI2C1Used_ForRCC) or (check_MCU("PLLSourceHSI") and ((((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SAI1ASourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or (SAI1BSourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) or config.flags.RNGUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (config.flags.SDIOUsed_ForRCC and SDIOSourceIsClock48) or (((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SAI1ASourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or (SAI1BSourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) or SysSourceIsPLLclk or (!I2S1SourceIsEXT and ((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S1) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S1))) or (!I2S2SourceIsEXT and ((config.flags.I2S1Used_ForRCC or config.flags.I2S4Used_ForRCC or config.flags.I2S5Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S2) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S2))))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or SAI1ASourceIsPllsrc and (config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or LPTimerSourceIsHSI and config.flags.LPTIMUsed_ForRCC or SAI1BSourceIsPllsrc and (config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and (config.flags.MCO1Config)) or !SAI1ASourceIsEXT and !PLLSourceI2SEXT and check_MCU("PLLSourceHSI") and (config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or !SAI1BSourceIsEXT and !PLLSourceI2SEXT and check_MCU("PLLSourceHSI") and (config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSI_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or config.flags.IWDGUsed_ForRCC or (LPTimerSourceIsLSI and config.flags.LPTIMUsed_ForRCC) or ((check_MCU("RTCSourceLSI")) and (config.flags.RTCUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLUsedValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or (SAI1ASourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIAUsed_ForRCC) or (SAI1BSourceIsPllR and config.flags.SAI1Used_ForRCC and config.flags.SAIBUsed_ForRCC)) or SysSourceIsPLLclk or (I2S1SourceIsPllR and ((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S1) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S1))) or (I2S2SourceIsPllR and ((config.flags.I2S1Used_ForRCC or config.flags.I2S4Used_ForRCC or config.flags.I2S5Used_ForRCC) or (config.flags.DFSDM1Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM1") and DFSDMADSourceI2S2) or (config.flags.DFSDM2Used_ForRCC and check_MCU("SEM2RCC_SAI1_CK_REQUIRED_DFSDM2") and DFSDM2ADSourceI2S2))) or (USBSourceisPLLQ and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (config.flags.SDIOUsed_ForRCC and SDIOSourceIsClock48)))) {
                    break :blk 1;
                }
                break :blk 0;
            };

            var HSIRC = ClockNode{
                .name = "HSIRC",
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

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
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

            var HSERTCDevisor = ClockNode{
                .name = "HSERTCDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLM = ClockNode{
                .name = "PLLM",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SSRC = ClockNode{
                .name = "PLLI2SSRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SM = ClockNode{
                .name = "PLLI2SM",
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

            var I2S1Mult = ClockNode{
                .name = "I2S1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S1output = ClockNode{
                .name = "I2S1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S2Mult = ClockNode{
                .name = "I2S2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S2output = ClockNode{
                .name = "I2S2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var FMPI2C1Mult = ClockNode{
                .name = "FMPI2C1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var FMPI2C1output = ClockNode{
                .name = "FMPI2C1output",
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

            var DFSDM2output = ClockNode{
                .name = "DFSDM2output",
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

            var RNGoutput = ClockNode{
                .name = "RNGoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDIOMult = ClockNode{
                .name = "SDIOMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDIOoutput = ClockNode{
                .name = "SDIOoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMAudioMult = ClockNode{
                .name = "DFSDMAudioMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDMAudiooutput = ClockNode{
                .name = "DFSDMAudiooutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDM2AudioMult = ClockNode{
                .name = "DFSDM2AudioMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var DFSDM2Audiooutput = ClockNode{
                .name = "DFSDM2Audiooutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1AMult = ClockNode{
                .name = "SAI1AMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1Aoutput = ClockNode{
                .name = "SAI1Aoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1APrescaler = ClockNode{
                .name = "SAI1APrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1BMult = ClockNode{
                .name = "SAI1BMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1Boutput = ClockNode{
                .name = "SAI1Boutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1BPrescaler = ClockNode{
                .name = "SAI1BPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTimerMult = ClockNode{
                .name = "LPTimerMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTimeroutput = ClockNode{
                .name = "LPTimeroutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLN = ClockNode{
                .name = "PLLN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLP = ClockNode{
                .name = "PLLP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQ = ClockNode{
                .name = "PLLQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQoutput = ClockNode{
                .name = "PLLQoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLR = ClockNode{
                .name = "PLLR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLRoutput = ClockNode{
                .name = "PLLRoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SN = ClockNode{
                .name = "PLLI2SN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQ = ClockNode{
                .name = "PLLI2SQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQoutput = ClockNode{
                .name = "PLLI2SQoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SR = ClockNode{
                .name = "PLLI2SR",
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
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                const RTCClkSource_clk_value = RCC_RTC_Clock_SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RTCClkSource",
                    "Else",
                    "No Extra Log",
                    "RCC_RTC_Clock_Source",
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
                &HSIRC,
                &HSEOSC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

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

            const PLLI2SSRC_clk_value = PLLI2SSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLI2SSRC",
                "Else",
                "No Extra Log",
                "PLLI2SSource",
            });
            const PLLI2SSRCparents = [_]*const ClockNode{
                &PLLSource,
                &I2S_CKIN,
            };
            PLLI2SSRC.nodetype = .multi;
            PLLI2SSRC.parents = &.{PLLI2SSRCparents[PLLI2SSRC_clk_value.get()]};

            const PLLI2SM_clk_value = PLLI2SMValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLI2SM",
                "Else",
                "No Extra Log",
                "PLLI2SM",
            });
            PLLI2SM.nodetype = .div;
            PLLI2SM.value = PLLI2SM_clk_value;
            PLLI2SM.parents = &.{&PLLI2SSRC};

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
                &HSIRC,
                &HSEOSC,
                &PLLP,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
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
                    &HSIRC,
                    &PLLP,
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
                MCO1Pin.limit = MCO1PinFreq_ValueLimit;
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
                    &SysClkSource,
                    &PLLI2SR,
                    &HSEOSC,
                    &PLLP,
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
                MCO2Pin.limit = MCO2PinFreq_ValueLimit;
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
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
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
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

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};

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
            TimPrescOut2.nodetype = .output;
            TimPrescOut2.parents = &.{&TimPrescalerAPB2};
            if (check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"="))
            {
                const I2S1Mult_clk_value = I2S1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2S1Mult",
                    "Else",
                    "No Extra Log",
                    "I2S1CLockSelection",
                });
                const I2S1Multparents = [_]*const ClockNode{
                    &PLLR,
                    &PLLI2SR,
                    &I2S_CKIN,
                    &PLLSource,
                };
                I2S1Mult.nodetype = .multi;
                I2S1Mult.parents = &.{I2S1Multparents[I2S1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2S1Freq_ValueValue);
                I2S1output.nodetype = .output;
                I2S1output.parents = &.{&I2S1Mult};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"="))
            {
                const I2S2Mult_clk_value = I2S2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2S2Mult",
                    "Else",
                    "No Extra Log",
                    "I2S2CLockSelection",
                });
                const I2S2Multparents = [_]*const ClockNode{
                    &PLLR,
                    &PLLI2SR,
                    &I2S_CKIN,
                    &PLLSource,
                };
                I2S2Mult.nodetype = .multi;
                I2S2Mult.parents = &.{I2S2Multparents[I2S2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2S2Freq_ValueValue);
                I2S2output.nodetype = .output;
                I2S2output.parents = &.{&I2S2Mult};
            }
            if (check_ref(@TypeOf(EnableFMPI2C1Value), EnableFMPI2C1Value, .true, .@"=")) {
                const FMPI2C1Mult_clk_value = FMPI2C1SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "FMPI2C1Mult",
                    "Else",
                    "No Extra Log",
                    "FMPI2C1Selection",
                });
                const FMPI2C1Multparents = [_]*const ClockNode{
                    &HSIRC,
                    &APB1Prescaler,
                    &SysCLKOutput,
                };
                FMPI2C1Mult.nodetype = .multi;
                FMPI2C1Mult.parents = &.{FMPI2C1Multparents[FMPI2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableFMPI2C1Value), EnableFMPI2C1Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(FMPI2C1Freq_ValueValue);
                FMPI2C1output.nodetype = .output;
                FMPI2C1output.parents = &.{&FMPI2C1Mult};
            }
            if (check_ref(@TypeOf(EnableDFSDMValue), EnableDFSDMValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2Value), EnableDFSDM2Value, .true, .@"="))
            {
                const DFSDMMult_clk_value = DFSDMSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDMMult",
                    "Else",
                    "No Extra Log",
                    "DFSDMSelection",
                });
                const DFSDMMultparents = [_]*const ClockNode{
                    &APB2Prescaler,
                    &SysCLKOutput,
                };
                DFSDMMult.nodetype = .multi;
                DFSDMMult.parents = &.{DFSDMMultparents[DFSDMMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDFSDMValue), EnableDFSDMValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMFreq_ValueValue);
                DFSDMoutput.nodetype = .output;
                DFSDMoutput.parents = &.{&DFSDMMult};
            }
            if (check_ref(@TypeOf(EnableDFSDM2Value), EnableDFSDM2Value, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDM2Freq_ValueValue);
                DFSDM2output.nodetype = .output;
                DFSDM2output.parents = &.{&DFSDMMult};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
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
                    &PLLQ,
                    &PLLI2SQ,
                };
                USBMult.nodetype = .multi;
                USBMult.parents = &.{USBMultparents[USBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.limit = USBFreq_ValueLimit;
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(RNGFreq_ValueValue);
                RNGoutput.limit = RNGFreq_ValueLimit;
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=")) {
                const SDIOMult_clk_value = SDIOCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDIOMult",
                    "Else",
                    "No Extra Log",
                    "SDIOCLockSelection",
                });
                const SDIOMultparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &USBMult,
                };
                SDIOMult.nodetype = .multi;
                SDIOMult.parents = &.{SDIOMultparents[SDIOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDIOFreq_ValueValue);
                SDIOoutput.limit = SDIOFreq_ValueLimit;
                SDIOoutput.nodetype = .output;
                SDIOoutput.parents = &.{&SDIOMult};
            }
            if (check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=")) {
                const DFSDMAudioMult_clk_value = DFSDMAudioSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDMAudioMult",
                    "Else",
                    "No Extra Log",
                    "DFSDMAudioSelection",
                });
                const DFSDMAudioMultparents = [_]*const ClockNode{
                    &I2S1Mult,
                    &I2S2Mult,
                };
                DFSDMAudioMult.nodetype = .multi;
                DFSDMAudioMult.parents = &.{DFSDMAudioMultparents[DFSDMAudioMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDMAudioFreq_ValueValue);
                DFSDMAudiooutput.nodetype = .output;
                DFSDMAudiooutput.parents = &.{&DFSDMAudioMult};
            }
            if (check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=")) {
                const DFSDM2AudioMult_clk_value = DFSDM2AudioSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "DFSDM2AudioMult",
                    "Else",
                    "No Extra Log",
                    "DFSDM2AudioSelection",
                });
                const DFSDM2AudioMultparents = [_]*const ClockNode{
                    &I2S1Mult,
                    &I2S2Mult,
                };
                DFSDM2AudioMult.nodetype = .multi;
                DFSDM2AudioMult.parents = &.{DFSDM2AudioMultparents[DFSDM2AudioMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(DFSDM2AudioFreq_ValueValue);
                DFSDM2Audiooutput.nodetype = .output;
                DFSDM2Audiooutput.parents = &.{&DFSDM2AudioMult};
            }
            if (check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=")) {
                const SAI1AMult_clk_value = SAI1ACLockSourceSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1AMult",
                    "Else",
                    "No Extra Log",
                    "SAI1ACLockSourceSelection",
                });
                const SAI1AMultparents = [_]*const ClockNode{
                    &PLLSource,
                    &SAI1APrescaler,
                    &SAI1BPrescaler,
                    &I2S_CKIN,
                };
                SAI1AMult.nodetype = .multi;
                SAI1AMult.parents = &.{SAI1AMultparents[SAI1AMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1AFreq_ValueValue);
                SAI1Aoutput.nodetype = .output;
                SAI1Aoutput.parents = &.{&SAI1AMult};
            }
            if (check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"="))
            {
                const SAI1APrescaler_clk_value = PLLDivRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1APrescaler",
                    "Else",
                    "No Extra Log",
                    "PLLDivR",
                });
                SAI1APrescaler.nodetype = .div;
                SAI1APrescaler.value = SAI1APrescaler_clk_value;
                SAI1APrescaler.parents = &.{&PLLR};
            }
            if (check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"=")) {
                const SAI1BMult_clk_value = SAI1BCLockSourceSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1BMult",
                    "Else",
                    "No Extra Log",
                    "SAI1BCLockSourceSelection",
                });
                const SAI1BMultparents = [_]*const ClockNode{
                    &PLLSource,
                    &SAI1APrescaler,
                    &SAI1BPrescaler,
                    &I2S_CKIN,
                };
                SAI1BMult.nodetype = .multi;
                SAI1BMult.parents = &.{SAI1BMultparents[SAI1BMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI1BFreq_ValueValue);
                SAI1Boutput.nodetype = .output;
                SAI1Boutput.parents = &.{&SAI1BMult};
            }
            if (check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"="))
            {
                const SAI1BPrescaler_clk_value = PLLI2SDivRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1BPrescaler",
                    "Else",
                    "No Extra Log",
                    "PLLI2SDivR",
                });
                SAI1BPrescaler.nodetype = .div;
                SAI1BPrescaler.value = SAI1BPrescaler_clk_value;
                SAI1BPrescaler.parents = &.{&PLLI2SR};
            }
            if (check_ref(@TypeOf(EnableLPTimerValue), EnableLPTimerValue, .true, .@"=")) {
                const LPTimerMult_clk_value = LPTIM1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTimerMult",
                    "Else",
                    "No Extra Log",
                    "LPTIM1CLockSelection",
                });
                const LPTimerMultparents = [_]*const ClockNode{
                    &APB1Prescaler,
                    &LSIRC,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTimerMult.nodetype = .multi;
                LPTimerMult.parents = &.{LPTimerMultparents[LPTimerMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableLPTimerValue), EnableLPTimerValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPTimerFreq_ValueValue);
                LPTimeroutput.nodetype = .output;
                LPTimeroutput.parents = &.{&LPTimerMult};
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
            PLLN.nodetype = .mul;
            PLLN.value = PLLN_clk_value;
            PLLN.parents = &.{&PLLM};

            const PLLP_clk_value = PLLPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLP",
                "Else",
                "No Extra Log",
                "PLLP",
            });
            PLLP.nodetype = .div;
            PLLP.value = PLLP_clk_value.get();
            PLLP.parents = &.{&PLLN};
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const PLLQ_clk_value = PLLQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLQ",
                    "Else",
                    "No Extra Log",
                    "PLLQ",
                });
                PLLQ.nodetype = .div;
                PLLQ.value = PLLQ_clk_value;
                PLLQ.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLQoutputFreq_ValueValue);
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLLQ};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"="))
            {
                const PLLR_clk_value = PLLRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLR",
                    "Else",
                    "No Extra Log",
                    "PLLR",
                });
                PLLR.nodetype = .div;
                PLLR.value = PLLR_clk_value;
                PLLR.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLRoutputFreq_ValueValue);
                PLLRoutput.nodetype = .output;
                PLLRoutput.parents = &.{&PLLR};
            }

            const PLLI2SN_clk_value = PLLI2SNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLI2SN",
                "Else",
                "No Extra Log",
                "PLLI2SN",
            });
            PLLI2SN.nodetype = .mul;
            PLLI2SN.value = PLLI2SN_clk_value;
            PLLI2SN.parents = &.{&PLLI2SM};
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                const PLLI2SQ_clk_value = PLLI2SQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SQ",
                    "Else",
                    "No Extra Log",
                    "PLLI2SQ",
                });
                PLLI2SQ.nodetype = .div;
                PLLI2SQ.value = PLLI2SQ_clk_value;
                PLLI2SQ.parents = &.{&PLLI2SN};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(PLLI2SQCLKFreq_ValueValue);
                PLLI2SQoutput.limit = PLLI2SQCLKFreq_ValueLimit;
                PLLI2SQoutput.nodetype = .output;
                PLLI2SQoutput.parents = &.{&PLLI2SQ};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDMAudioValue), EnableDFSDMAudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableDFSDM2AudioValue), EnableDFSDM2AudioValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1AValue), EnableSAI1AValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAI1BValue), EnableSAI1BValue, .true, .@"="))
            {
                const PLLI2SR_clk_value = PLLI2SRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SR",
                    "Else",
                    "No Extra Log",
                    "PLLI2SR",
                });
                PLLI2SR.nodetype = .div;
                PLLI2SR.value = PLLI2SR_clk_value;
                PLLI2SR.parents = &.{&PLLI2SN};
            }

            out.HSIRC = try HSIRC.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLI2SSRC = try PLLI2SSRC.get_output();
            out.PLLI2SM = try PLLI2SM.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.I2S1Mult = try I2S1Mult.get_output();
            out.I2S1output = try I2S1output.get_output();
            out.I2S2Mult = try I2S2Mult.get_output();
            out.I2S2output = try I2S2output.get_output();
            out.FMPI2C1Mult = try FMPI2C1Mult.get_output();
            out.FMPI2C1output = try FMPI2C1output.get_output();
            out.DFSDMMult = try DFSDMMult.get_output();
            out.DFSDMoutput = try DFSDMoutput.get_output();
            out.DFSDM2output = try DFSDM2output.get_output();
            out.USBMult = try USBMult.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.SDIOMult = try SDIOMult.get_output();
            out.SDIOoutput = try SDIOoutput.get_output();
            out.DFSDMAudioMult = try DFSDMAudioMult.get_output();
            out.DFSDMAudiooutput = try DFSDMAudiooutput.get_output();
            out.DFSDM2AudioMult = try DFSDM2AudioMult.get_output();
            out.DFSDM2Audiooutput = try DFSDM2Audiooutput.get_output();
            out.SAI1AMult = try SAI1AMult.get_output();
            out.SAI1Aoutput = try SAI1Aoutput.get_output();
            out.SAI1APrescaler = try SAI1APrescaler.get_output();
            out.SAI1BMult = try SAI1BMult.get_output();
            out.SAI1Boutput = try SAI1Boutput.get_output();
            out.SAI1BPrescaler = try SAI1BPrescaler.get_output();
            out.LPTimerMult = try LPTimerMult.get_output();
            out.LPTimeroutput = try LPTimeroutput.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLLR = try PLLR.get_output();
            out.PLLRoutput = try PLLRoutput.get_output();
            out.PLLI2SN = try PLLI2SN.get_output();
            out.PLLI2SQ = try PLLI2SQ.get_output();
            out.PLLI2SQoutput = try PLLI2SQoutput.get_output();
            out.PLLI2SR = try PLLI2SR.get_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.RCC_RTC_Clock_Source = RCC_RTC_Clock_SourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.PLLI2SSource = PLLI2SSourceValue;
            ref_out.PLLI2SM = PLLI2SMValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.I2S1CLockSelection = I2S1CLockSelectionValue;
            ref_out.I2S2CLockSelection = I2S2CLockSelectionValue;
            ref_out.FMPI2C1Selection = FMPI2C1SelectionValue;
            ref_out.DFSDMSelection = DFSDMSelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.SDIOCLockSelection = SDIOCLockSelectionValue;
            ref_out.DFSDMAudioSelection = DFSDMAudioSelectionValue;
            ref_out.DFSDM2AudioSelection = DFSDM2AudioSelectionValue;
            ref_out.SAI1ACLockSourceSelection = SAI1ACLockSourceSelectionValue;
            ref_out.PLLDivR = PLLDivRValue;
            ref_out.SAI1BCLockSourceSelection = SAI1BCLockSourceSelectionValue;
            ref_out.PLLI2SDivR = PLLI2SDivRValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLP = PLLPValue;
            ref_out.PLLQ = PLLQValue;
            ref_out.PLLR = PLLRValue;
            ref_out.PLLI2SN = PLLI2SNValue;
            ref_out.PLLI2SQ = PLLI2SQValue;
            ref_out.PLLI2SR = PLLI2SRValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.RCC_TIM_PRescaler_Selection = RCC_TIM_PRescaler_SelectionValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.EnableI2S1 = EnableI2S1Value;
            ref_out.EnableDFSDMAudio = EnableDFSDMAudioValue;
            ref_out.EnableDFSDM2Audio = EnableDFSDM2AudioValue;
            ref_out.EnableI2S2 = EnableI2S2Value;
            ref_out.EnableFMPI2C1 = EnableFMPI2C1Value;
            ref_out.EnableDFSDM = EnableDFSDMValue;
            ref_out.EnableDFSDM2 = EnableDFSDM2Value;
            ref_out.EnableUSB = EnableUSBValue;
            ref_out.EnableSDIO = EnableSDIOValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.EnableSAI1A = EnableSAI1AValue;
            ref_out.EnableSAI1B = EnableSAI1BValue;
            ref_out.EnableLPTimer = EnableLPTimerValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.HSEUsed = HSEUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.LSIUsed = LSIUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.PLLI2SUsed = PLLI2SUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
