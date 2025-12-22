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
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,
    RCC_SYSCLKSOURCE_PLLRCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_HSE => 1,
            .RCC_SYSCLKSOURCE_PLLCLK => 2,
            .RCC_SYSCLKSOURCE_PLLRCLK => 3,
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
pub const CECClockSelectionList = enum {
    RCC_CECCLKSOURCE_HSI,
    RCC_CECCLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CECCLKSOURCE_HSI => 0,
            .RCC_CECCLKSOURCE_LSE => 1,
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
pub const USBCLockSelectionList = enum {
    RCC_CLK48CLKSOURCE_PLLQ,
    RCC_CLK48CLKSOURCE_PLLSAIP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_CLK48CLKSOURCE_PLLQ => 0,
            .RCC_CLK48CLKSOURCE_PLLSAIP => 1,
        };
    }
};
pub const SPDIFCLockSelectionList = enum {
    RCC_SPDIFRXCLKSOURCE_PLLR,
    RCC_SPDIFRXCLKSOURCE_PLLI2SP,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPDIFRXCLKSOURCE_PLLR => 0,
            .RCC_SPDIFRXCLKSOURCE_PLLI2SP => 1,
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
pub const SAIACLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_EXT,
    RCC_SAI1CLKSOURCE_PLLR,
    RCC_SAI1CLKSOURCE_PLLI2S,
    RCC_SAI1CLKSOURCE_PLLSAI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_EXT => 0,
            .RCC_SAI1CLKSOURCE_PLLR => 1,
            .RCC_SAI1CLKSOURCE_PLLI2S => 2,
            .RCC_SAI1CLKSOURCE_PLLSAI => 3,
        };
    }
};
pub const SAIBCLockSelectionList = enum {
    RCC_SAI2CLKSOURCE_PLLSRC,
    RCC_SAI2CLKSOURCE_PLLR,
    RCC_SAI2CLKSOURCE_PLLI2S,
    RCC_SAI2CLKSOURCE_PLLSAI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI2CLKSOURCE_PLLSRC => 0,
            .RCC_SAI2CLKSOURCE_PLLR => 1,
            .RCC_SAI2CLKSOURCE_PLLI2S => 2,
            .RCC_SAI2CLKSOURCE_PLLSAI => 3,
        };
    }
};
pub const I2S1CLockSelectionList = enum {
    RCC_I2SAPB1CLKSOURCE_PLLSRC,
    RCC_I2SAPB1CLKSOURCE_PLLR,
    RCC_I2SAPB1CLKSOURCE_EXT,
    RCC_I2SAPB1CLKSOURCE_PLLI2S,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SAPB1CLKSOURCE_PLLSRC => 0,
            .RCC_I2SAPB1CLKSOURCE_PLLR => 1,
            .RCC_I2SAPB1CLKSOURCE_EXT => 2,
            .RCC_I2SAPB1CLKSOURCE_PLLI2S => 3,
        };
    }
};
pub const I2S2CLockSelectionList = enum {
    RCC_I2SAPB2CLKSOURCE_PLLSRC,
    RCC_I2SAPB2CLKSOURCE_PLLR,
    RCC_I2SAPB2CLKSOURCE_EXT,
    RCC_I2SAPB2CLKSOURCE_PLLI2S,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SAPB2CLKSOURCE_PLLSRC => 0,
            .RCC_I2SAPB2CLKSOURCE_PLLR => 1,
            .RCC_I2SAPB2CLKSOURCE_EXT => 2,
            .RCC_I2SAPB2CLKSOURCE_PLLI2S => 3,
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
pub const PLLSAIPList = enum {
    RCC_PLLSAIP_DIV2,
    RCC_PLLSAIP_DIV4,
    RCC_PLLSAIP_DIV6,
    RCC_PLLSAIP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLSAIP_DIV2 => 2,
            .RCC_PLLSAIP_DIV4 => 4,
            .RCC_PLLSAIP_DIV6 => 6,
            .RCC_PLLSAIP_DIV8 => 8,
        };
    }
};
pub const PLLI2SPList = enum {
    RCC_PLLI2SP_DIV2,
    RCC_PLLI2SP_DIV4,
    RCC_PLLI2SP_DIV6,
    RCC_PLLI2SP_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLI2SP_DIV2 => 2,
            .RCC_PLLI2SP_DIV4 => 4,
            .RCC_PLLI2SP_DIV6 => 6,
            .RCC_PLLI2SP_DIV8 => 8,
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
pub const PWREXT_OverDriveList = enum {
    PWREXT_OverDrive_ACTIVATED,
    PWREXT_OverDrive_DESACTIVATED,
};
pub const ExtClockEnableList = enum {
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
pub const EnableFMPI2C1List = enum {
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
pub const EnableSPDIFList = enum {
    true,
    false,
};
pub const EnableSAIAList = enum {
    true,
    false,
};
pub const EnableSAIBList = enum {
    true,
    false,
};
pub const EnableI2S1List = enum {
    true,
    false,
};
pub const EnableI2S2List = enum {
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
            SDIOUsed_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            SAI1Used_ForRCC: bool = false,
            SAI2Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            FMPI2C1Used_ForRCC: bool = false,
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
            PWREXT_OverDrive: ?PWREXT_OverDriveList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?u32 = null,
            PLLSAIM: ?u32 = null,
            PLLI2SM: ?u32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null,
            CECClockSelection: ?CECClockSelectionList = null,
            FMPI2C1Selection: ?FMPI2C1SelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null,
            SDIOCLockSelection: ?SDIOCLockSelectionList = null,
            SAIACLockSelection: ?SAIACLockSelectionList = null,
            SAIBCLockSelection: ?SAIBCLockSelectionList = null,
            I2S1CLockSelection: ?I2S1CLockSelectionList = null,
            I2S2CLockSelection: ?I2S2CLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?u32 = null,
            PLLR: ?u32 = null,
            PLLSAIN: ?u32 = null,
            PLLSAIP: ?PLLSAIPList = null,
            PLLSAIQ: ?u32 = null,
            PLLSAIQDiv: ?u32 = null,
            PLLI2SN: ?u32 = null,
            PLLI2SP: ?PLLI2SPList = null,
            PLLI2SQ: ?u32 = null,
            PLLI2SQDiv: ?u32 = null,
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
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            PLLSAIM: f32 = 0,
            PLLI2SM: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            HSIDivCEC: f32 = 0,
            CECMult: f32 = 0,
            CECOutput: f32 = 0,
            FMPI2C1Mult: f32 = 0,
            FMPI2C1output: f32 = 0,
            USBMult: f32 = 0,
            USBoutput: f32 = 0,
            SPDIFMult: f32 = 0,
            SPDIFoutput: f32 = 0,
            SDIOMult: f32 = 0,
            SDIOoutput: f32 = 0,
            SAIAMult: f32 = 0,
            SAIAoutput: f32 = 0,
            SAIBMult: f32 = 0,
            SAIBoutput: f32 = 0,
            I2S1Mult: f32 = 0,
            I2S1output: f32 = 0,
            I2S2Mult: f32 = 0,
            I2S2output: f32 = 0,
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
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLQ: f32 = 0,
            PLLR: f32 = 0,
            PLLSAIN: f32 = 0,
            PLLSAIP: f32 = 0,
            PLLSAIoutput: f32 = 0,
            PLLSAIQ: f32 = 0,
            PLLSAIQDiv: f32 = 0,
            PLLI2SN: f32 = 0,
            PLLI2SP: f32 = 0,
            PLLI2Soutput: f32 = 0,
            PLLI2SQ: f32 = 0,
            PLLI2SQDiv: f32 = 0,
            PLLI2SR: f32 = 0,
            VCOInput: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            PLLQCLK: f32 = 0,
            PLLRCLK: f32 = 0,
            VCOSAIInput: f32 = 0,
            VCOSAIOutput: f32 = 0,
            PLLSAIPCLK: f32 = 0,
            PLLSAIQCLK: f32 = 0,
            VCOI2SInput: f32 = 0,
            VCOI2SOutput: f32 = 0,
            PLLI2SPCLK: f32 = 0,
            PLLI2SRCLK: f32 = 0,
            PLLI2SQCLK: f32 = 0,
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
            USB_OTG_FSUsed_ForRCC: bool = false,
            USB_OTG_HSEmbeddedPHYUsed_ForRCC: bool = false,
            USB_OTG_HSUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            SPDIFRXUsed_ForRCC: bool = false,
            SAI1Used_ForRCC: bool = false,
            SAI2Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            I2S1Used_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            FMPI2C1Used_ForRCC: bool = false,
            PLLUsed: bool = false,
            ExtClockEnable: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            CECEnable: bool = false,
            EnableFMPI2C1: bool = false,
            EnableUSB: bool = false,
            EnableSDIO: bool = false,
            EnableSPDIF: bool = false,
            EnableSAIA: bool = false,
            EnableSAIB: bool = false,
            EnableI2S1: bool = false,
            EnableI2S2: bool = false,
            MCO1OutPutEnable: bool = false,
            MCO2OutPutEnable: bool = false,
            EnableHSE: bool = false,
            EnableLSERTC: bool = false,
            EnableLSE: bool = false,
            HSEUsed: bool = false,
            LSEUsed: bool = false,
            HSIUsed: bool = false,
            LSIUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?f32 = null, //from RCC Clock Config
            PLLSAIM: ?f32 = null, //from RCC Clock Config
            PLLI2SM: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null, //from extra RCC references
            HSI_Div_CEC: ?f32 = null, //from RCC Clock Config
            CECClockSelection: ?CECClockSelectionList = null, //from RCC Clock Config
            FMPI2C1Selection: ?FMPI2C1SelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            SPDIFCLockSelection: ?SPDIFCLockSelectionList = null, //from RCC Clock Config
            SDIOCLockSelection: ?SDIOCLockSelectionList = null, //from RCC Clock Config
            SAIACLockSelection: ?SAIACLockSelectionList = null, //from RCC Clock Config
            SAIBCLockSelection: ?SAIBCLockSelectionList = null, //from RCC Clock Config
            I2S1CLockSelection: ?I2S1CLockSelectionList = null, //from RCC Clock Config
            I2S2CLockSelection: ?I2S2CLockSelectionList = null, //from RCC Clock Config
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
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLP: ?PLLPList = null, //from RCC Clock Config
            PLLQ: ?f32 = null, //from RCC Clock Config
            PLLR: ?f32 = null, //from RCC Clock Config
            PLLSAIN: ?f32 = null, //from RCC Clock Config
            PLLSAIP: ?PLLSAIPList = null, //from RCC Clock Config
            PLLSAIQ: ?f32 = null, //from RCC Clock Config
            PLLSAIQDiv: ?f32 = null, //from RCC Clock Config
            PLLI2SN: ?f32 = null, //from RCC Clock Config
            PLLI2SP: ?PLLI2SPList = null, //from RCC Clock Config
            PLLI2SQ: ?f32 = null, //from RCC Clock Config
            PLLI2SQDiv: ?f32 = null, //from RCC Clock Config
            PLLI2SR: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            RCC_TIM_PRescaler_Selection: ?RCC_TIM_PRescaler_SelectionList = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            PWREXT_OverDrive: ?PWREXT_OverDriveList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
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

            var SysSourceIsHSI: bool = false;
            var SysSourceIsHSE: bool = false;
            var SysSourceIsPLLclk: bool = false;
            var SysSourceIsPLLR: bool = false;
            var USBSourceisPLLQ: bool = false;
            var USBSourceisPLLSAIP: bool = false;
            var SPDIFSourceisPLLR: bool = false;
            var SPDIFSourceisPLLI2SP: bool = false;
            var SDIOSourceIsSysclk: bool = false;
            var SDIOSourceIsClock48: bool = false;
            var SAIASourceIsIsExt: bool = false;
            var SAIASourceIsPLLR: bool = false;
            var SAIASourceIsPLLI2SQ: bool = false;
            var SAIASourceIsPLLSAI: bool = false;
            var SAIBSourceIsPllSRC: bool = false;
            var SAIBSourceIsPLLR: bool = false;
            var SAIBSourceIsPLLI2SQ: bool = false;
            var SAIBSourceIsPLLSAI: bool = false;
            var I2S1SourceIsPllsrc: bool = false;
            var I2S1SourceIsPllR: bool = false;
            var I2S1SourceIsEXT: bool = false;
            var I2S1SourceIsPLLI2SR: bool = false;
            var I2S2SourceIsPllsrc: bool = false;
            var I2S2SourceIsPllR: bool = false;
            var I2S2SourceIsEXT: bool = false;
            var I2S2SourceIsPLLI2SR: bool = false;
            var MCOSourceIsPLLI2SP: bool = false;
            var HCLKDiv1: bool = false;
            var TimPrescalerEnabled: bool = false;

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

            var PLLM = ClockNode{
                .name = "PLLM",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIM = ClockNode{
                .name = "PLLSAIM",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SM = ClockNode{
                .name = "PLLI2SM",
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

            var HSIDivCEC = ClockNode{
                .name = "HSIDivCEC",
                .nodetype = .off,
                .parents = &.{},
            };

            var CECMult = ClockNode{
                .name = "CECMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CECOutput = ClockNode{
                .name = "CECOutput",
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

            var SAIAMult = ClockNode{
                .name = "SAIAMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAIAoutput = ClockNode{
                .name = "SAIAoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAIBMult = ClockNode{
                .name = "SAIBMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAIBoutput = ClockNode{
                .name = "SAIBoutput",
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

            var PLLR = ClockNode{
                .name = "PLLR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIN = ClockNode{
                .name = "PLLSAIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIP = ClockNode{
                .name = "PLLSAIP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIoutput = ClockNode{
                .name = "PLLSAIoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQ = ClockNode{
                .name = "PLLSAIQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQDiv = ClockNode{
                .name = "PLLSAIQDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SN = ClockNode{
                .name = "PLLI2SN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SP = ClockNode{
                .name = "PLLI2SP",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2Soutput = ClockNode{
                .name = "PLLI2Soutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQ = ClockNode{
                .name = "PLLI2SQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQDiv = ClockNode{
                .name = "PLLI2SQDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SR = ClockNode{
                .name = "PLLI2SR",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOInput = ClockNode{
                .name = "VCOInput",
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

            var PLLQCLK = ClockNode{
                .name = "PLLQCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLRCLK = ClockNode{
                .name = "PLLRCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOSAIInput = ClockNode{
                .name = "VCOSAIInput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOSAIOutput = ClockNode{
                .name = "VCOSAIOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIPCLK = ClockNode{
                .name = "PLLSAIPCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQCLK = ClockNode{
                .name = "PLLSAIQCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOI2SInput = ClockNode{
                .name = "VCOI2SInput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOI2SOutput = ClockNode{
                .name = "VCOI2SOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SPCLK = ClockNode{
                .name = "PLLI2SPCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SRCLK = ClockNode{
                .name = "PLLI2SRCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQCLK = ClockNode{
                .name = "PLLI2SQCLK",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 25000000;
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SysSourceIsHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceIsHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourceIsPLLclk = true,
                        .RCC_SYSCLKSOURCE_PLLRCLK => SysSourceIsPLLR = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceIsHSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
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
            const PLLSAIMValue: ?f32 = blk: {
                const config_val = config.PLLSAIM;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIM",
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
                            "PLLSAIM",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
            const HSI_Div_CECValue: ?f32 = blk: {
                break :blk 488;
            };
            const CECClockSelectionValue: ?CECClockSelectionList = blk: {
                const conf_item = config.CECClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CECCLKSOURCE_HSI => {},
                        .RCC_CECCLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_CECCLKSOURCE_HSI;
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
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_CLK48CLKSOURCE_PLLSAIP => USBSourceisPLLSAIP = true,
                        .RCC_CLK48CLKSOURCE_PLLQ => USBSourceisPLLQ = true,
                    }
                }

                break :blk conf_item orelse {
                    USBSourceisPLLQ = true;
                    break :blk .RCC_CLK48CLKSOURCE_PLLQ;
                };
            };
            const SPDIFCLockSelectionValue: ?SPDIFCLockSelectionList = blk: {
                const conf_item = config.SPDIFCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPDIFRXCLKSOURCE_PLLR => SPDIFSourceisPLLR = true,
                        .RCC_SPDIFRXCLKSOURCE_PLLI2SP => SPDIFSourceisPLLI2SP = true,
                    }
                }

                break :blk conf_item orelse {
                    SPDIFSourceisPLLR = true;
                    break :blk .RCC_SPDIFRXCLKSOURCE_PLLR;
                };
            };
            const SDIOCLockSelectionValue: ?SDIOCLockSelectionList = blk: {
                const conf_item = config.SDIOCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDIOCLKSOURCE_CLK48 => SDIOSourceIsClock48 = true,
                        .RCC_SDIOCLKSOURCE_SYSCLK => SDIOSourceIsSysclk = true,
                    }
                }

                break :blk conf_item orelse {
                    SDIOSourceIsClock48 = true;
                    break :blk .RCC_SDIOCLKSOURCE_CLK48;
                };
            };
            const SAIACLockSelectionValue: ?SAIACLockSelectionList = blk: {
                const conf_item = config.SAIACLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_EXT => SAIASourceIsIsExt = true,
                        .RCC_SAI1CLKSOURCE_PLLR => SAIASourceIsPLLR = true,
                        .RCC_SAI1CLKSOURCE_PLLI2S => SAIASourceIsPLLI2SQ = true,
                        .RCC_SAI1CLKSOURCE_PLLSAI => SAIASourceIsPLLSAI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAIASourceIsPLLSAI = true;
                    break :blk .RCC_SAI1CLKSOURCE_PLLSAI;
                };
            };
            const SAIBCLockSelectionValue: ?SAIBCLockSelectionList = blk: {
                const conf_item = config.SAIBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI2CLKSOURCE_PLLSRC => SAIBSourceIsPllSRC = true,
                        .RCC_SAI2CLKSOURCE_PLLR => SAIBSourceIsPLLR = true,
                        .RCC_SAI2CLKSOURCE_PLLI2S => SAIBSourceIsPLLI2SQ = true,
                        .RCC_SAI2CLKSOURCE_PLLSAI => SAIBSourceIsPLLSAI = true,
                    }
                }

                break :blk conf_item orelse {
                    SAIBSourceIsPLLSAI = true;
                    break :blk .RCC_SAI2CLKSOURCE_PLLSAI;
                };
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

                break :blk conf_item orelse {
                    I2S1SourceIsPLLI2SR = true;
                    break :blk .RCC_I2SAPB1CLKSOURCE_PLLI2S;
                };
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

                break :blk conf_item orelse {
                    I2S2SourceIsPLLI2SR = true;
                    break :blk .RCC_I2SAPB2CLKSOURCE_PLLI2S;
                };
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
            const PLLSAINValue: ?f32 = blk: {
                const config_val = config.PLLSAIN;
                if (config_val) |val| {
                    if (val < 50) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIN",
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
                            "PLLSAIN",
                            "Else",
                            "No Extra Log",
                            432,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 192;
            };
            const PLLSAIPValue: ?PLLSAIPList = blk: {
                const conf_item = config.PLLSAIP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAIP_DIV2 => {},
                        .RCC_PLLSAIP_DIV4 => {},
                        .RCC_PLLSAIP_DIV6 => {},
                        .RCC_PLLSAIP_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSAIP_DIV2;
            };
            const PLLSAIQValue: ?f32 = blk: {
                const config_val = config.PLLSAIQ;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQ",
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
                            "PLLSAIQ",
                            "Else",
                            "No Extra Log",
                            15,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLLSAIQDivValue: ?f32 = blk: {
                const config_val = config.PLLSAIQDiv;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIQDiv",
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
                            "PLLSAIQDiv",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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
            const PLLI2SPValue: ?PLLI2SPList = blk: {
                const conf_item = config.PLLI2SP;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLI2SP_DIV2 => {},
                        .RCC_PLLI2SP_DIV4 => {},
                        .RCC_PLLI2SP_DIV6 => {},
                        .RCC_PLLI2SP_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLI2SP_DIV2;
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
            const PLLI2SQDivValue: ?f32 = blk: {
                const config_val = config.PLLI2SQDiv;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SQDiv",
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
                            "PLLI2SQDiv",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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
            var VDD_VALUEValue: ?f32 = if (config.extra.VDD_VALUE) |i| i else 3.3;
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
            const HSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.HSE_Timout;
                if (config_val) |val| {
                    if (val < 0) {
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
                            0,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 100;
            };
            const LSE_TimoutValue: ?f32 = blk: {
                const config_val = config.extra.LSE_Timout;
                if (config_val) |val| {
                    if (val < 0) {
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
                            0,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 5000;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const ExtClockEnableValue: ?ExtClockEnableList = blk: {
                if (config.flags.AudioClockConfig) {
                    const item: ExtClockEnableList = .true;
                    break :blk item;
                }
                const item: ExtClockEnableList = .false;
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
            const CECEnableValue: ?CECEnableList = blk: {
                if (config.flags.CECUsed_ForRCC) {
                    const item: CECEnableList = .true;
                    break :blk item;
                }
                const item: CECEnableList = .false;
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
            const EnableSPDIFValue: ?EnableSPDIFList = blk: {
                if (config.flags.SPDIFRXUsed_ForRCC) {
                    const item: EnableSPDIFList = .true;
                    break :blk item;
                }
                const item: EnableSPDIFList = .false;
                break :blk item;
            };
            const EnableSAIAValue: ?EnableSAIAList = blk: {
                if (config.flags.SAI1Used_ForRCC) {
                    const item: EnableSAIAList = .true;
                    break :blk item;
                }
                const item: EnableSAIAList = .false;
                break :blk item;
            };
            const EnableSAIBValue: ?EnableSAIBList = blk: {
                if (config.flags.SAI2Used_ForRCC) {
                    const item: EnableSAIBList = .true;
                    break :blk item;
                }
                const item: EnableSAIBList = .false;
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
            const EnableI2S2Value: ?EnableI2S2List = blk: {
                if (config.flags.I2S1Used_ForRCC) {
                    const item: EnableI2S2List = .true;
                    break :blk item;
                }
                const item: EnableI2S2List = .false;
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
            const HSEUsedValue: ?f32 = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11"))) or (config.flags.RTCUsed_ForRCC and !((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or SysSourceIsPLLR or SysSourceIsPLLclk or ((SAIASourceIsPLLR or SAIASourceIsPLLI2SQ or SAIASourceIsPLLSAI) and config.flags.SAI1Used_ForRCC) or ((SAIBSourceIsPLLR or SAIBSourceIsPLLI2SQ or SAIBSourceIsPllSRC or SAIBSourceIsPLLSAI) and config.flags.SAI2Used_ForRCC) or ((I2S1SourceIsPllR or I2S1SourceIsPLLI2SR or I2S1SourceIsPllsrc) and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or ((I2S2SourceIsPllR or I2S2SourceIsPLLI2SR or I2S2SourceIsPllsrc) and config.flags.I2S1Used_ForRCC))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and (config.flags.MCO1Config)) or (((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_HSE, .@"=")) or (MCOSourceIsPLLI2SP and (check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")))) and (config.flags.MCO2Config))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSE_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and config.flags.RTCUsed_ForRCC) or ((check_ref(@TypeOf(CECClockSelectionValue), CECClockSelectionValue, .RCC_CECCLKSOURCE_LSE, .@"=")) and config.flags.CECUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((((MCOSourceIsPLLI2SP and (check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI, .@"=")))) and (config.flags.MCO2Config)) or ((check_ref(@TypeOf(FMPI2C1SelectionValue), FMPI2C1SelectionValue, .RCC_FMPI2C1CLKSOURCE_HSI, .@"=")) and config.flags.FMPI2C1Used_ForRCC) or ((check_ref(@TypeOf(CECClockSelectionValue), CECClockSelectionValue, .RCC_CECCLKSOURCE_HSI, .@"=")) and config.flags.CECUsed_ForRCC) or (check_MCU("PLLSourceHSI") and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or SysSourceIsPLLR or SysSourceIsPLLclk or ((SAIASourceIsPLLR or SAIASourceIsPLLI2SQ or SAIASourceIsPLLSAI) and config.flags.SAI1Used_ForRCC) or ((SAIBSourceIsPLLR or SAIBSourceIsPLLI2SQ or SAIBSourceIsPllSRC or SAIBSourceIsPLLSAI) and config.flags.SAI2Used_ForRCC) or ((I2S1SourceIsPllR or I2S1SourceIsPLLI2SR or I2S1SourceIsPllsrc) and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or ((I2S2SourceIsPllR or I2S2SourceIsPLLI2SR or I2S2SourceIsPllsrc) and config.flags.I2S1Used_ForRCC) or (config.flags.SPDIFRXUsed_ForRCC and (SPDIFSourceisPLLI2SP or SPDIFSourceisPLLR)))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and (config.flags.MCO1Config))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSI_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
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

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
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
                &PLLR,
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

            const PLLSAIM_clk_value = PLLSAIMValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAIM",
                "Else",
                "No Extra Log",
                "PLLSAIM",
            });
            PLLSAIM.nodetype = .div;
            PLLSAIM.value = PLLSAIM_clk_value;
            PLLSAIM.parents = &.{&PLLSource};

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
            PLLI2SM.parents = &.{&PLLSource};
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
            }

            const HSIDivCEC_clk_value = HSI_Div_CECValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIDivCEC",
                "Else",
                "No Extra Log",
                "HSI_Div_CEC",
            });
            HSIDivCEC.nodetype = .div;
            HSIDivCEC.value = HSIDivCEC_clk_value;
            HSIDivCEC.parents = &.{&HSIRC};
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                const CECMult_clk_value = CECClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CECMult",
                    "Else",
                    "No Extra Log",
                    "CECClockSelection",
                });
                const CECMultparents = [_]*const ClockNode{
                    &HSIDivCEC,
                    &LSEOSC,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                CECOutput.nodetype = .output;
                CECOutput.parents = &.{&CECMult};
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
                FMPI2C1output.nodetype = .output;
                FMPI2C1output.parents = &.{&FMPI2C1Mult};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"="))
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
                    &PLLSAIP,
                };
                USBMult.nodetype = .multi;
                USBMult.parents = &.{USBMultparents[USBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=")) {
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(EnableSPDIFValue), EnableSPDIFValue, .true, .@"=")) {
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
                    &PLLR,
                    &PLLI2SP,
                };
                SPDIFMult.nodetype = .multi;
                SPDIFMult.parents = &.{SPDIFMultparents[SPDIFMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSPDIFValue), EnableSPDIFValue, .true, .@"=")) {
                SPDIFoutput.nodetype = .output;
                SPDIFoutput.parents = &.{&SPDIFMult};
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
                SDIOoutput.nodetype = .output;
                SDIOoutput.parents = &.{&SDIOMult};
            }
            if (check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"=")) {
                const SAIAMult_clk_value = SAIACLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAIAMult",
                    "Else",
                    "No Extra Log",
                    "SAIACLockSelection",
                });
                const SAIAMultparents = [_]*const ClockNode{
                    &I2S_CKIN,
                    &PLLR,
                    &PLLI2SQDiv,
                    &PLLSAIQDiv,
                };
                SAIAMult.nodetype = .multi;
                SAIAMult.parents = &.{SAIAMultparents[SAIAMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"=")) {
                SAIAoutput.nodetype = .output;
                SAIAoutput.parents = &.{&SAIAMult};
            }
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=")) {
                const SAIBMult_clk_value = SAIBCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAIBMult",
                    "Else",
                    "No Extra Log",
                    "SAIBCLockSelection",
                });
                const SAIBMultparents = [_]*const ClockNode{
                    &PLLSource,
                    &PLLR,
                    &PLLI2SQDiv,
                    &PLLSAIQDiv,
                };
                SAIBMult.nodetype = .multi;
                SAIBMult.parents = &.{SAIBMultparents[SAIBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=")) {
                SAIBoutput.nodetype = .output;
                SAIBoutput.parents = &.{&SAIBMult};
            }
            if (check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=")) {
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
                    &PLLSource,
                    &PLLR,
                    &I2S_CKIN,
                    &PLLI2SR,
                };
                I2S1Mult.nodetype = .multi;
                I2S1Mult.parents = &.{I2S1Multparents[I2S1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=")) {
                I2S1output.nodetype = .output;
                I2S1output.parents = &.{&I2S1Mult};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=")) {
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
                    &PLLSource,
                    &PLLR,
                    &I2S_CKIN,
                    &PLLI2SR,
                };
                I2S2Mult.nodetype = .multi;
                I2S2Mult.parents = &.{I2S2Multparents[I2S2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=")) {
                I2S2output.nodetype = .output;
                I2S2output.parents = &.{&I2S2Mult};
            }
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
            PWRCLKoutput.nodetype = .output;
            PWRCLKoutput.parents = &.{&SysCLKOutput};
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};
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
            CortexSysOutput.nodetype = .output;
            CortexSysOutput.parents = &.{&CortexPrescaler};
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
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"="))
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

            const PLLSAIN_clk_value = PLLSAINValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLSAIN",
                "Else",
                "No Extra Log",
                "PLLSAIN",
            });
            PLLSAIN.nodetype = .mul;
            PLLSAIN.value = PLLSAIN_clk_value;
            PLLSAIN.parents = &.{&PLLSAIM};
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"="))
            {
                const PLLSAIP_clk_value = PLLSAIPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIP",
                    "Else",
                    "No Extra Log",
                    "PLLSAIP",
                });
                PLLSAIP.nodetype = .div;
                PLLSAIP.value = PLLSAIP_clk_value.get();
                PLLSAIP.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(EnableUSBValue), EnableUSBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSDIOValue), EnableSDIOValue, .true, .@"="))
            {
                PLLSAIoutput.nodetype = .output;
                PLLSAIoutput.parents = &.{&PLLSAIP};
            }
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"="))
            {
                const PLLSAIQ_clk_value = PLLSAIQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIQ",
                    "Else",
                    "No Extra Log",
                    "PLLSAIQ",
                });
                PLLSAIQ.nodetype = .div;
                PLLSAIQ.value = PLLSAIQ_clk_value;
                PLLSAIQ.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"="))
            {
                const PLLSAIQDiv_clk_value = PLLSAIQDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIQDiv",
                    "Else",
                    "No Extra Log",
                    "PLLSAIQDiv",
                });
                PLLSAIQDiv.nodetype = .div;
                PLLSAIQDiv.value = PLLSAIQDiv_clk_value;
                PLLSAIQDiv.parents = &.{&PLLSAIQ};
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
            if (check_ref(@TypeOf(EnableSPDIFValue), EnableSPDIFValue, .true, .@"=")) {
                const PLLI2SP_clk_value = PLLI2SPValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SP",
                    "Else",
                    "No Extra Log",
                    "PLLI2SP",
                });
                PLLI2SP.nodetype = .div;
                PLLI2SP.value = PLLI2SP_clk_value.get();
                PLLI2SP.parents = &.{&PLLI2SN};
            }
            if (check_ref(@TypeOf(EnableSPDIFValue), EnableSPDIFValue, .true, .@"=")) {
                PLLI2Soutput.nodetype = .output;
                PLLI2Soutput.parents = &.{&PLLI2SP};
            }
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"="))
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
            if (check_ref(@TypeOf(EnableSAIBValue), EnableSAIBValue, .true, .@"=") or
                check_ref(@TypeOf(EnableSAIAValue), EnableSAIAValue, .true, .@"="))
            {
                const PLLI2SQDiv_clk_value = PLLI2SQDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SQDiv",
                    "Else",
                    "No Extra Log",
                    "PLLI2SQDiv",
                });
                PLLI2SQDiv.nodetype = .div;
                PLLI2SQDiv.value = PLLI2SQDiv_clk_value;
                PLLI2SQDiv.parents = &.{&PLLI2SQ};
            }
            if (check_ref(@TypeOf(EnableI2S2Value), EnableI2S2Value, .true, .@"=") or
                check_ref(@TypeOf(EnableI2S1Value), EnableI2S1Value, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"="))
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
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLP};
            PLLQCLK.nodetype = .output;
            PLLQCLK.parents = &.{&PLLQ};
            PLLRCLK.nodetype = .output;
            PLLRCLK.parents = &.{&PLLR};
            VCOSAIInput.nodetype = .output;
            VCOSAIInput.parents = &.{&PLLSAIM};
            VCOSAIOutput.nodetype = .output;
            VCOSAIOutput.parents = &.{&PLLSAIN};
            PLLSAIPCLK.nodetype = .output;
            PLLSAIPCLK.parents = &.{&PLLSAIP};
            PLLSAIQCLK.nodetype = .output;
            PLLSAIQCLK.parents = &.{&PLLSAIQ};
            VCOI2SInput.nodetype = .output;
            VCOI2SInput.parents = &.{&PLLI2SM};
            VCOI2SOutput.nodetype = .output;
            VCOI2SOutput.parents = &.{&PLLI2SN};
            PLLI2SPCLK.nodetype = .output;
            PLLI2SPCLK.parents = &.{&PLLI2SP};
            PLLI2SRCLK.nodetype = .output;
            PLLI2SRCLK.parents = &.{&PLLI2SR};
            PLLI2SQCLK.nodetype = .output;
            PLLI2SQCLK.parents = &.{&PLLI2SQ};

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 1.8e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                if ((!(check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) {
                    RTCOutput.limit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                RTCOutput.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF USBFreq_Value VALUE
            _ = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    USBoutput.limit = .{
                        .min = 4.788e7,
                        .max = 4.812e7,
                    };

                    break :blk null;
                }
                USBoutput.value = 48000000;
                break :blk null;
            };

            //POST CLOCK REF SPDIFRXFreq_Value VALUE
            _ = blk: {
                SPDIFoutput.limit = .{
                    .min = 5.632e6,
                    .max = null,
                };

                break :blk null;
            };

            //POST CLOCK REF SDIOFreq_Value VALUE
            _ = blk: {
                SDIOoutput.limit = .{
                    .min = null,
                    .max = 4.8e7,
                };

                break :blk null;
            };

            //POST CLOCK REF I2S1Freq_Value VALUE
            _ = blk: {
                I2S1output.limit = .{
                    .min = null,
                    .max = 1.92e8,
                };

                break :blk null;
            };

            //POST CLOCK REF I2S2Freq_Value VALUE
            _ = blk: {
                I2S2output.limit = .{
                    .min = null,
                    .max = 1.92e8,
                };

                break :blk null;
            };

            //POST CLOCK REF MCO1PinFreq_Value VALUE
            _ = blk: {
                MCO1Pin.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF MCO2PinFreq_Value VALUE
            _ = blk: {
                MCO2Pin.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                if ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_HSUsed_ForRCC)) {
                    AHBOutput.limit = .{
                        .min = 3e7,
                        .max = 1.8e8,
                    };

                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    AHBOutput.limit = .{
                        .min = 1.42e7,
                        .max = 1.8e8,
                    };

                    break :blk null;
                }
                AHBOutput.limit = .{
                    .min = null,
                    .max = 1.8e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                if (config.flags.RTCUsed_ForRCC) {
                    const min: ?f32 = try math_op(?f32, RTCOutput.get_as_ref(), 4, .@"*", "APB1Freq_Value", "RTCOutput", "4");
                    const max: ?f32 = @min(45000000, std.math.floatMax(f32));
                    APB1Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value*4",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                APB1Output.limit = .{
                    .min = null,
                    .max = 4.5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 9e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PLLSAIoutputFreq_Value VALUE
            _ = blk: {
                if ((USBSourceisPLLSAIP and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC)))) {
                    PLLSAIoutput.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLSAIoutput.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLI2SoutputFreq_Value VALUE
            _ = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or SPDIFSourceisPLLI2SP and config.flags.SPDIFRXUsed_ForRCC) {
                    PLLI2Soutput.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLI2Soutput.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or (SysSourceIsPLLclk or SysSourceIsPLLR) or ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC) and USBSourceisPLLQ) or (USBSourceisPLLQ and SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC) or ((config.flags.SAI1Used_ForRCC) and SAIASourceIsPLLR) or ((config.flags.SAI2Used_ForRCC) and SAIBSourceIsPLLR) or (((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or config.flags.I2S1Used_ForRCC) and (I2S1SourceIsPllR or I2S2SourceIsPllR)) or (config.flags.SPDIFRXUsed_ForRCC and SPDIFSourceisPLLR)) {
                    VCOInput.limit = .{
                        .min = 9.5e5,
                        .max = 2.1e6,
                    };

                    break :blk null;
                }
                VCOInput.value = 1000000;
                break :blk null;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or (SysSourceIsPLLclk or SysSourceIsPLLR) or ((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC) and USBSourceisPLLQ) or (USBSourceisPLLQ and SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC) or ((config.flags.SAI1Used_ForRCC) and SAIASourceIsPLLR) or ((config.flags.SAI2Used_ForRCC) and SAIBSourceIsPLLR) or (((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or config.flags.I2S1Used_ForRCC) and (I2S1SourceIsPllR or I2S2SourceIsPllR)) or (config.flags.SPDIFRXUsed_ForRCC and SPDIFSourceisPLLR)) {
                    VCOOutput.limit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                VCOOutput.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF PLLCLKFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or SysSourceIsPLLclk) {
                    PLLCLK.limit = .{
                        .min = 2.4e7,
                        .max = 1.8e8,
                    };

                    break :blk null;
                }
                PLLCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLQCLKFreq_Value VALUE
            _ = blk: {
                if (((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC)) and USBSourceisPLLQ)) {
                    PLLQCLK.limit = .{
                        .min = null,
                        .max = 7.5e7,
                    };

                    break :blk null;
                }
                PLLQCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLRCLKFreq_Value VALUE
            _ = blk: {
                if (SysSourceIsPLLR or ((config.flags.SAI1Used_ForRCC) and SAIASourceIsPLLR) or ((config.flags.SAI2Used_ForRCC) and SAIBSourceIsPLLR) or (((config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) or config.flags.I2S1Used_ForRCC) and (I2S1SourceIsPllR or I2S2SourceIsPllR)) or (config.flags.SPDIFRXUsed_ForRCC and SPDIFSourceisPLLR)) {
                    PLLRCLK.limit = .{
                        .min = 2.4e7,
                        .max = 1.8e8,
                    };

                    break :blk null;
                }
                PLLRCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VCOSAIInputFreq_Value VALUE
            _ = blk: {
                if ((USBSourceisPLLSAIP and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC))) or (SAIASourceIsPLLSAI and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLSAI and config.flags.SAI2Used_ForRCC)) {
                    VCOSAIInput.limit = .{
                        .min = 9.5e5,
                        .max = 2.1e6,
                    };

                    break :blk null;
                }
                VCOSAIInput.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF VCOSAIOutputFreq_Value VALUE
            _ = blk: {
                if ((USBSourceisPLLSAIP and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC))) or (SAIASourceIsPLLSAI and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLSAI and config.flags.SAI2Used_ForRCC)) {
                    VCOSAIOutput.limit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                VCOSAIOutput.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF PLLSAIPCLKFreq_Value VALUE
            _ = blk: {
                if ((USBSourceisPLLSAIP and (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or (SDIOSourceIsClock48 and config.flags.SDIOUsed_ForRCC)))) {
                    PLLSAIPCLK.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLSAIPCLK.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF PLLSAIQCLKFreq_Value VALUE
            _ = blk: {
                if ((SAIASourceIsPLLSAI and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLSAI and config.flags.SAI2Used_ForRCC)) {
                    PLLSAIQCLK.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLSAIQCLK.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF VCOI2SInputFreq_Value VALUE
            _ = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or (SPDIFSourceisPLLI2SP and config.flags.SPDIFRXUsed_ForRCC) or (I2S1SourceIsPLLI2SR and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or (I2S2SourceIsPLLI2SR and config.flags.I2S1Used_ForRCC) or (SAIASourceIsPLLI2SQ and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLI2SQ and config.flags.SAI2Used_ForRCC)) {
                    VCOI2SInput.limit = .{
                        .min = 9.5e5,
                        .max = 2.1e6,
                    };

                    break :blk null;
                }
                VCOI2SInput.value = 192000000;
                break :blk null;
            };

            //POST CLOCK REF VCOI2SOutputFreq_Value VALUE
            _ = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or (SPDIFSourceisPLLI2SP and config.flags.SPDIFRXUsed_ForRCC) or (I2S1SourceIsPLLI2SR and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or (I2S2SourceIsPLLI2SR and config.flags.I2S1Used_ForRCC) or (SAIASourceIsPLLI2SQ and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLI2SQ and config.flags.SAI2Used_ForRCC)) {
                    VCOI2SOutput.limit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };

                    break :blk null;
                }
                VCOI2SOutput.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLI2SPCLKFreq_Value VALUE
            _ = blk: {
                if ((config.flags.MCO2Config and MCOSourceIsPLLI2SP) or SPDIFSourceisPLLI2SP and config.flags.SPDIFRXUsed_ForRCC) {
                    PLLI2SPCLK.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLI2SPCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLI2SRCLKFreq_Value VALUE
            _ = blk: {
                if ((I2S1SourceIsPLLI2SR and (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC)) or (I2S2SourceIsPLLI2SR and config.flags.I2S1Used_ForRCC)) {
                    PLLI2SRCLK.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLI2SRCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF PLLI2SQCLKFreq_Value VALUE
            _ = blk: {
                if ((SAIASourceIsPLLI2SQ and config.flags.SAI1Used_ForRCC) or (SAIBSourceIsPLLI2SQ and config.flags.SAI2Used_ForRCC)) {
                    PLLI2SQCLK.limit = .{
                        .min = null,
                        .max = 2.16e8,
                    };

                    break :blk null;
                }
                PLLI2SQCLK.value = 96000000;
                break :blk null;
            };

            //POST CLOCK REF VDD_VALUE VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(config.extra.PWREXT_OverDrive), config.extra.PWREXT_OverDrive, .PWREXT_OverDrive_ACTIVATED, .@"="))) {
                    const config_val = config.extra.VDD_VALUE;
                    if (config_val) |val| {
                        if (val < 2.1e0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VDD_VALUE",
                                "(PWREXT_OverDrive=PWREXT_OverDrive_ACTIVATED) ",
                                "No Extra Log",
                                2.1e0,
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
                                "(PWREXT_OverDrive=PWREXT_OverDrive_ACTIVATED) ",
                                "No Extra Log",
                                3.6e0,
                                val,
                            });
                        }
                    }
                    VDD_VALUEValue = config_val orelse 3.3;

                    break :blk null;
                }
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
                VDD_VALUEValue = config_val orelse 3.3;

                break :blk null;
            };
            const PREFETCH_ENABLEValue: ?PREFETCH_ENABLEList = blk: {
                if ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) and (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<"))) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"=")))) {
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
                            , .{ "PREFETCH_ENABLE", "(((VDD_VALUE > 1.8) & (VDD_VALUE < 2.1))|(VDD_VALUE=1.8))", "No Extra Log", "0", i });
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
            const FLatencyValue: ?FLatencyList = blk: {
                if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 30000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 30000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 22000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 22000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 20000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 20000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6))) &  ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 30000000)|(HCLKFreq_Value =30000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 24000000)|(HCLKFreq_Value =24000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 22000000)|(HCLKFreq_Value= 22000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8))   & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 0) & ((HCLKFreq_Value < 20000000)|(HCLKFreq_Value =20000000))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 30000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 22000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 44000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 44000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 20000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 40000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 40000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7))  & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 ))) & ((HCLKFreq_Value > 30000000) &  ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 ))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 24000000) &  ((HCLKFreq_Value < 48000000)|(HCLKFreq_Value= 48000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 ))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 22000000) &  ((HCLKFreq_Value < 44000000)|(HCLKFreq_Value =44000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  ))  & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 20000000) &  ((HCLKFreq_Value < 40000000)|(HCLKFreq_Value=40000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 90000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 90000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 72000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 72000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 44000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 66000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 66000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 40000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7 )) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 ))) & ((HCLKFreq_Value > 60000000) & ((HCLKFreq_Value < 90000000)|(HCLKFreq_Value = 90000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4  ))  & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 48000000) & ((HCLKFreq_Value < 72000000)|(HCLKFreq_Value = 72000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1  ))  & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 44000000) & ((HCLKFreq_Value < 66000000)|(HCLKFreq_Value= 66000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8   ))   &((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 40000000) & ((HCLKFreq_Value < 60000000)|(HCLKFreq_Value= 60000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_2", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 90000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 72000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 66000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 88000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 88000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 60000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 80000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 80000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) & ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6 )))&  ((HCLKFreq_Value > 90000000) & ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 72000000) & ((HCLKFreq_Value < 96000000)|(HCLKFreq_Value=   96000000 ))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 66000000) & ((HCLKFreq_Value < 88000000)|(HCLKFreq_Value =  88000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) & ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 60000000) & ((HCLKFreq_Value < 80000000)|(HCLKFreq_Value= 80000000   ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_3", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 88000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 110000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 110000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 80000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6  ))) & ((HCLKFreq_Value > 120000000) &  ((HCLKFreq_Value < 150000000)|(HCLKFreq_Value= 150000000 ))))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) &  ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7 ))) & ((HCLKFreq_Value > 96000000) &   ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) &  ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4 ))) & ((HCLKFreq_Value > 88000000) &   ((HCLKFreq_Value < 110000000)|(HCLKFreq_Value= 110000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1 ))) & ((HCLKFreq_Value > 80000000) &   ((HCLKFreq_Value < 100000000)|(HCLKFreq_Value =100000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_4", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (check_ref(?f32, AHBOutput.get_as_ref(), 150000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 110000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 132000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 132000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@"="))))))
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.7)|(VDD_VALUE = 2.7)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE =3.6   ))) &  (HCLKFreq_Value > 150000000))|\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4 )) &   ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7 ))) & ((HCLKFreq_Value > 120000000) & ((HCLKFreq_Value < 144000000)|(HCLKFreq_Value =144000000  ))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1 )) &   ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4 ))) & ((HCLKFreq_Value > 110000000) & ((HCLKFreq_Value < 132000000)|(HCLKFreq_Value = 132000000 ))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8  )) &    ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 100000000) & ((HCLKFreq_Value < 120000000)|(HCLKFreq_Value = 120000000 ))))ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_5", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 168000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 168000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 132000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 154000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 154000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 140000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 140000000, .@"="))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & ((HCLKFreq_Value > 144000000) & ((HCLKFreq_Value < 168000000)|(HCLKFreq_Value = 168000000))))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 132000000) & ((HCLKFreq_Value < 154000000)|(HCLKFreq_Value = 154000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 120000000) & ((HCLKFreq_Value < 140000000)|(HCLKFreq_Value = 140000000))))ªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_6", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and (check_ref(?f32, AHBOutput.get_as_ref(), 168000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 154000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 176000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 176000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(?f32, AHBOutput.get_as_ref(), 140000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@"="))))))
                {
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.4)|(VDD_VALUE= 2.4)) & ((VDD_VALUE < 2.7)|(VDD_VALUE = 2.7))) & (HCLKFreq_Value >  168000000))|\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & ((HCLKFreq_Value > 154000000) & ((HCLKFreq_Value < 176000000)|(HCLKFreq_Value = 176000000))))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & ((HCLKFreq_Value > 140000000) & ((HCLKFreq_Value < 160000000)|(HCLKFreq_Value = 160000000))))ªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_7", i });
                        }
                    }
                    break :blk item;
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and (check_ref(?f32, AHBOutput.get_as_ref(), 176000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and (check_ref(?f32, AHBOutput.get_as_ref(), 160000000, .@">"))))
                {
                    const item: FLatencyList = .FLASH_LATENCY_8;
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
                            , .{ "FLatency", "\r\n\t\t((((VDD_VALUE > 2.1)|(VDD_VALUE= 2.1)) & ((VDD_VALUE < 2.4)|(VDD_VALUE = 2.4))) & (HCLKFreq_Value > 176000000))|\r\n\t\t((((VDD_VALUE > 1.8)|(VDD_VALUE=1.8)) &  ((VDD_VALUE < 2.1)|(VDD_VALUE = 2.1))) & (HCLKFreq_Value > 160000000))ªªªªªªªª", "No Extra Log", "FLASH_LATENCY_8", i });
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
            const PWREXT_OverDriveValue: ?PWREXT_OverDriveList = blk: {
                if ((check_ref(?f32, AHBOutput.get_as_ref(), 168000000, .@">"))) {
                    const item: PWREXT_OverDriveList = .PWREXT_OverDrive_ACTIVATED;
                    const conf_item = config.extra.PWREXT_OverDrive;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWREXT_OverDrive", "(HCLKFreq_Value > 168000000) ", "No Extra Log", "PWREXT_OverDrive_ACTIVATED", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.7, .@">")) and (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")))) {
                    const item: PWREXT_OverDriveList = .PWREXT_OverDrive_DESACTIVATED;
                    const conf_item = config.extra.PWREXT_OverDrive;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "PWREXT_OverDrive", "((VDD_VALUE>1.7)&(VDD_VALUE<2.1))", "No Extra Log", "PWREXT_OverDrive_DESACTIVATED", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.PWREXT_OverDrive;
                if (conf_item) |item| {
                    switch (item) {
                        .PWREXT_OverDrive_DESACTIVATED => {},
                        .PWREXT_OverDrive_ACTIVATED => {},
                    }
                }

                break :blk conf_item orelse .PWREXT_OverDrive_DESACTIVATED;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(?f32, AHBOutput.get_as_ref(), 168000000, .@">")))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value > 168000000))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(@TypeOf(PWREXT_OverDriveValue), PWREXT_OverDriveValue, .PWREXT_OverDrive_DESACTIVATED, .@"=")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@">")) or (check_ref(?f32, AHBOutput.get_as_ref(), 144000000, .@"="))))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((PWREXT_OverDrive=PWREXT_OverDrive_DESACTIVATED)&((HCLKFreq_Value > 144000000)|(HCLKFreq_Value=144000000)))", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if ((check_ref(?f32, AHBOutput.get_as_ref(), 120000000, .@">"))) {
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
                                , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value > 120000000)", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE2;
                }
                const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                if (conf_item) |item| {
                    switch (item) {
                        .PWR_REGULATOR_VOLTAGE_SCALE3 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE2 => {},
                        .PWR_REGULATOR_VOLTAGE_SCALE1 => {},
                    }
                }

                break :blk conf_item orelse .PWR_REGULATOR_VOLTAGE_SCALE3;
            };

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.FMPI2C1output = try FMPI2C1output.get_output();
            out.FMPI2C1Mult = try FMPI2C1Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.SDIOoutput = try SDIOoutput.get_output();
            out.SDIOMult = try SDIOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.USBMult = try USBMult.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.PLLP = try PLLP.get_output();
            out.SAIAoutput = try SAIAoutput.get_output();
            out.SAIAMult = try SAIAMult.get_output();
            out.SAIBoutput = try SAIBoutput.get_output();
            out.SAIBMult = try SAIBMult.get_output();
            out.I2S1output = try I2S1output.get_output();
            out.I2S1Mult = try I2S1Mult.get_output();
            out.I2S2output = try I2S2output.get_output();
            out.I2S2Mult = try I2S2Mult.get_output();
            out.SPDIFoutput = try SPDIFoutput.get_output();
            out.SPDIFMult = try SPDIFMult.get_output();
            out.PLLR = try PLLR.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSAIQDiv = try PLLSAIQDiv.get_output();
            out.PLLSAIQ = try PLLSAIQ.get_output();
            out.PLLSAIoutput = try PLLSAIoutput.get_output();
            out.PLLSAIP = try PLLSAIP.get_output();
            out.PLLSAIN = try PLLSAIN.get_output();
            out.PLLSAIM = try PLLSAIM.get_output();
            out.PLLI2Soutput = try PLLI2Soutput.get_output();
            out.PLLI2SP = try PLLI2SP.get_output();
            out.PLLI2SQDiv = try PLLI2SQDiv.get_output();
            out.PLLI2SQ = try PLLI2SQ.get_output();
            out.PLLI2SR = try PLLI2SR.get_output();
            out.PLLI2SN = try PLLI2SN.get_output();
            out.PLLI2SM = try PLLI2SM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.CECOutput = try CECOutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.HSIDivCEC = try HSIDivCEC.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.PLLQCLK = try PLLQCLK.get_extra_output();
            out.PLLRCLK = try PLLRCLK.get_extra_output();
            out.VCOSAIInput = try VCOSAIInput.get_extra_output();
            out.VCOSAIOutput = try VCOSAIOutput.get_extra_output();
            out.PLLSAIPCLK = try PLLSAIPCLK.get_extra_output();
            out.PLLSAIQCLK = try PLLSAIQCLK.get_extra_output();
            out.VCOI2SInput = try VCOI2SInput.get_extra_output();
            out.VCOI2SOutput = try VCOI2SOutput.get_extra_output();
            out.PLLI2SPCLK = try PLLI2SPCLK.get_extra_output();
            out.PLLI2SRCLK = try PLLI2SRCLK.get_extra_output();
            out.PLLI2SQCLK = try PLLI2SQCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.PLLSAIM = PLLSAIMValue;
            ref_out.PLLI2SM = PLLI2SMValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RCC_RTC_Clock_Source = RCC_RTC_Clock_SourceValue;
            ref_out.HSI_Div_CEC = HSI_Div_CECValue;
            ref_out.CECClockSelection = CECClockSelectionValue;
            ref_out.FMPI2C1Selection = FMPI2C1SelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.SPDIFCLockSelection = SPDIFCLockSelectionValue;
            ref_out.SDIOCLockSelection = SDIOCLockSelectionValue;
            ref_out.SAIACLockSelection = SAIACLockSelectionValue;
            ref_out.SAIBCLockSelection = SAIBCLockSelectionValue;
            ref_out.I2S1CLockSelection = I2S1CLockSelectionValue;
            ref_out.I2S2CLockSelection = I2S2CLockSelectionValue;
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
            ref_out.PLLN = PLLNValue;
            ref_out.PLLP = PLLPValue;
            ref_out.PLLQ = PLLQValue;
            ref_out.PLLR = PLLRValue;
            ref_out.PLLSAIN = PLLSAINValue;
            ref_out.PLLSAIP = PLLSAIPValue;
            ref_out.PLLSAIQ = PLLSAIQValue;
            ref_out.PLLSAIQDiv = PLLSAIQDivValue;
            ref_out.PLLI2SN = PLLI2SNValue;
            ref_out.PLLI2SP = PLLI2SPValue;
            ref_out.PLLI2SQ = PLLI2SQValue;
            ref_out.PLLI2SQDiv = PLLI2SQDivValue;
            ref_out.PLLI2SR = PLLI2SRValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.RCC_TIM_PRescaler_Selection = RCC_TIM_PRescaler_SelectionValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.PWREXT_OverDrive = PWREXT_OverDriveValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCO1Config = config.flags.MCO1Config;
            ref_out.flags.MCO2Config = config.flags.MCO2Config;
            ref_out.flags.AudioClockConfig = config.flags.AudioClockConfig;
            ref_out.flags.USB_OTG_FSUsed_ForRCC = config.flags.USB_OTG_FSUsed_ForRCC;
            ref_out.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC = config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC;
            ref_out.flags.USB_OTG_HSUsed_ForRCC = config.flags.USB_OTG_HSUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.SDIOUsed_ForRCC = config.flags.SDIOUsed_ForRCC;
            ref_out.flags.SPDIFRXUsed_ForRCC = config.flags.SPDIFRXUsed_ForRCC;
            ref_out.flags.SAI1Used_ForRCC = config.flags.SAI1Used_ForRCC;
            ref_out.flags.SAI2Used_ForRCC = config.flags.SAI2Used_ForRCC;
            ref_out.flags.I2S2Used_ForRCC = config.flags.I2S2Used_ForRCC;
            ref_out.flags.I2S3Used_ForRCC = config.flags.I2S3Used_ForRCC;
            ref_out.flags.I2S1Used_ForRCC = config.flags.I2S1Used_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.CECUsed_ForRCC = config.flags.CECUsed_ForRCC;
            ref_out.flags.FMPI2C1Used_ForRCC = config.flags.FMPI2C1Used_ForRCC;
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.ExtClockEnable = check_ref(?ExtClockEnableList, ExtClockEnableValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.CECEnable = check_ref(?CECEnableList, CECEnableValue, .true, .@"=");
            ref_out.flags.EnableFMPI2C1 = check_ref(?EnableFMPI2C1List, EnableFMPI2C1Value, .true, .@"=");
            ref_out.flags.EnableUSB = check_ref(?EnableUSBList, EnableUSBValue, .true, .@"=");
            ref_out.flags.EnableSDIO = check_ref(?EnableSDIOList, EnableSDIOValue, .true, .@"=");
            ref_out.flags.EnableSPDIF = check_ref(?EnableSPDIFList, EnableSPDIFValue, .true, .@"=");
            ref_out.flags.EnableSAIA = check_ref(?EnableSAIAList, EnableSAIAValue, .true, .@"=");
            ref_out.flags.EnableSAIB = check_ref(?EnableSAIBList, EnableSAIBValue, .true, .@"=");
            ref_out.flags.EnableI2S1 = check_ref(?EnableI2S1List, EnableI2S1Value, .true, .@"=");
            ref_out.flags.EnableI2S2 = check_ref(?EnableI2S2List, EnableI2S2Value, .true, .@"=");
            ref_out.flags.MCO1OutPutEnable = check_ref(?MCO1OutPutEnableList, MCO1OutPutEnableValue, .true, .@"=");
            ref_out.flags.MCO2OutPutEnable = check_ref(?MCO2OutPutEnableList, MCO2OutPutEnableValue, .true, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.HSEUsed = check_ref(?f32, HSEUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            ref_out.flags.LSIUsed = check_ref(?f32, LSIUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
