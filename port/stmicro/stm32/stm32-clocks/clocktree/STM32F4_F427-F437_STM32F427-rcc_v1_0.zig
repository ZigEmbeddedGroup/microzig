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
pub const I2SClockSourceList = enum {
    I2S_CLOCK_EXTERNAL,
    I2S_CLOCK_PLL,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .I2S_CLOCK_EXTERNAL => 0,
            .I2S_CLOCK_PLL => 1,
        };
    }
};
pub const SAIClockSource_BlockAList = enum {
    SAI_CLKSOURCE_PLLI2S,
    SAI_CLKSOURCE_EXT,
    SAI_CLKSOURCE_PLLSAI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SAI_CLKSOURCE_PLLI2S => 0,
            .SAI_CLKSOURCE_EXT => 1,
            .SAI_CLKSOURCE_PLLSAI => 2,
        };
    }
};
pub const SAIClockSource_BlockBList = enum {
    SAI_CLKSOURCE_PLLI2S,
    SAI_CLKSOURCE_EXT,
    SAI_CLKSOURCE_PLLSAI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SAI_CLKSOURCE_PLLI2S => 0,
            .SAI_CLKSOURCE_EXT => 1,
            .SAI_CLKSOURCE_PLLSAI => 2,
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
pub const PLLSAIDivRList = enum {
    RCC_PLLSAIDIVR_2,
    RCC_PLLSAIDIVR_4,
    RCC_PLLSAIDIVR_8,
    RCC_PLLSAIDIVR_16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLSAIDIVR_2 => 2,
            .RCC_PLLSAIDIVR_4 => 4,
            .RCC_PLLSAIDIVR_8 => 8,
            .RCC_PLLSAIDIVR_16 => 16,
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
pub const PWREXT_OverDriveList = enum {
    PWREXT_OverDrive_ACTIVATED,
    PWREXT_OverDrive_DESACTIVATED,
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
pub const USBFSEnableList = enum {
    true,
    false,
};
pub const USBHSEnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const SDIOEnableList = enum {
    true,
    false,
};
pub const I2SEnableList = enum {
    false,
    true,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const SAIAEnableList = enum {
    true,
    false,
};
pub const SAIBEnableList = enum {
    true,
    false,
};
pub const LTDCEnableList = enum {
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
pub const EnableExtClockForI2SList = enum {
    true,
    false,
};
pub const PLLI2SCLKSAIA_BEnableList = enum {
    true,
    false,
};
pub const EnableExtClockForSAIAList = enum {
    true,
    false,
};
pub const EnableExtClockForSAIBList = enum {
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
            ETHUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            I2SUsed_ForRCC: bool = false,
            SAIAUsed_ForRCC: bool = false,
            SAIBUsed_ForRCC: bool = false,
            LTDCUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            I2SEnable: ?I2SEnableList = null,
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
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?u32 = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            I2SClockSource: ?I2SClockSourceList = null,
            PLLI2SDivQ: ?u32 = null,
            SAIClockSource_BlockA: ?SAIClockSource_BlockAList = null,
            PLLSAIDivR: ?PLLSAIDivRList = null,
            PLLSAIDivQ: ?u32 = null,
            SAIClockSource_BlockB: ?SAIClockSource_BlockBList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv1: ?RCC_MCODiv1List = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCODiv2: ?RCC_MCODiv2List = null,
            PLLSAIN: ?u32 = null,
            PLLSAIR: ?u32 = null,
            PLLSAIQ: ?u32 = null,
            PLLN: ?u32 = null,
            PLLP: ?PLLPList = null,
            PLLQ: ?u32 = null,
            PLLI2SN: ?u32 = null,
            PLLI2SR: ?u32 = null,
            PLLI2SQ: ?u32 = null,
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
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            SysClkSource: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            AHBPrescaler: f32 = 0,
            SysCLKOutput: f32 = 0,
            EthernetPtpOutput: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            PeriphPrescaler: f32 = 0,
            PeriphPrescOutput: f32 = 0,
            USBOTGOutput: f32 = 0,
            I2SSrc: f32 = 0,
            I2S_CKIN: f32 = 0,
            I2SClocksOutput: f32 = 0,
            PLLI2SSAIDiv: f32 = 0,
            SAI_AMuxSrc: f32 = 0,
            SAI_ACLKOutput: f32 = 0,
            PLLSAILCDDiv: f32 = 0,
            @"LCD-TFTCLKOutput": f32 = 0,
            PLLSAISAIDiv: f32 = 0,
            SAI_BMuxSrc: f32 = 0,
            SAI_BCLKOutput: f32 = 0,
            MCO1Mult: f32 = 0,
            MCO1Div: f32 = 0,
            MCO1Pin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            PLLSAIN: f32 = 0,
            PLLSAIR: f32 = 0,
            PLLSAIQ: f32 = 0,
            PLLN: f32 = 0,
            PLLP: f32 = 0,
            PLLQ: f32 = 0,
            PLLI2SN: f32 = 0,
            PLLI2SR: f32 = 0,
            PLLI2SQ: f32 = 0,
            HSE_RTC: f32 = 0,
            VCOInput: f32 = 0,
            VCOOutput: f32 = 0,
            PLL48CLK: f32 = 0,
            PLLCLK: f32 = 0,
            PLLI2SCLK: f32 = 0,
            PLLSAICLK_I2S: f32 = 0,
            VCOI2SOutput: f32 = 0,
            VCOSAIOutput: f32 = 0,
            PLLLCDCLK: f32 = 0,
            PLLSAICLK_SAI: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source: ?RCC_RTC_Clock_SourceList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from RCC Clock Config
            PLLM: ?f32 = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            I2SClockSource: ?I2SClockSourceList = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            PLLI2SDivQ: ?f32 = null, //from RCC Clock Config
            SAIClockSource_BlockA: ?SAIClockSource_BlockAList = null, //from RCC Clock Config
            PLLSAIDivR: ?PLLSAIDivRList = null, //from RCC Clock Config
            PLLSAIDivQ: ?f32 = null, //from RCC Clock Config
            SAIClockSource_BlockB: ?SAIClockSource_BlockBList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv1: ?RCC_MCODiv1List = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCODiv2: ?RCC_MCODiv2List = null, //from RCC Clock Config
            PLLSAIN: ?f32 = null, //from RCC Clock Config
            PLLSAIR: ?f32 = null, //from RCC Clock Config
            PLLSAIQ: ?f32 = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLP: ?PLLPList = null, //from RCC Clock Config
            PLLQ: ?f32 = null, //from RCC Clock Config
            PLLI2SN: ?f32 = null, //from RCC Clock Config
            PLLI2SR: ?f32 = null, //from RCC Clock Config
            PLLI2SQ: ?f32 = null, //from RCC Clock Config
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
            PLLUsed: ?f32 = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            USBFSEnable: ?USBFSEnableList = null, //from extra RCC references
            USBHSEnable: ?USBHSEnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            SDIOEnable: ?SDIOEnableList = null, //from extra RCC references
            I2SEnable: ?I2SEnableList = null, //from RCC Advanced Config
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            SAIAEnable: ?SAIAEnableList = null, //from extra RCC references
            SAIBEnable: ?SAIBEnableList = null, //from extra RCC references
            LTDCEnable: ?LTDCEnableList = null, //from extra RCC references
            MCO1OutPutEnable: ?MCO1OutPutEnableList = null, //from extra RCC references
            MCO2OutPutEnable: ?MCO2OutPutEnableList = null, //from extra RCC references
            LSIUsed: ?f32 = null, //from extra RCC references
            HSEUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            EnableExtClockForI2S: ?EnableExtClockForI2SList = null, //from extra RCC references
            PLLI2SCLKSAIA_BEnable: ?PLLI2SCLKSAIA_BEnableList = null, //from extra RCC references
            EnableExtClockForSAIA: ?EnableExtClockForSAIAList = null, //from extra RCC references
            EnableExtClockForSAIB: ?EnableExtClockForSAIBList = null, //from extra RCC references
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

            var I2SSourceIsPll: bool = false;
            var SAISourceIsPllI2SA: bool = false;
            var SAISourceIsPllSAIA: bool = false;
            var SAISourceIsPllI2SB: bool = false;
            var SAISourceIsPllSAIB: bool = false;
            var HCLKDiv1: bool = false;
            var TimPrescalerEnabled: bool = false;
            var RTCFreq_ValueLimit: Limit = .{};
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var AHBFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var @"48MHZClocksFreq_ValueLimit": Limit = .{};
            var I2SClocksFreq_ValueLimit: Limit = .{};
            var MCO1PinFreq_ValueLimit: Limit = .{};
            var MCO2PinFreq_ValueLimit: Limit = .{};
            var RTCHSEDivFreq_ValueLimit: Limit = .{};
            var VCOInputFreq_ValueLimit: Limit = .{};
            var VCOOutputFreq_ValueLimit: Limit = .{};
            var PLLQCLKFreq_ValueLimit: Limit = .{};
            var PLLCLKFreq_ValueLimit: Limit = .{};
            var VcooutputI2SLimit: Limit = .{};
            var VcooutputI2SQLimit: Limit = .{};
            var VCOI2SOutputFreq_ValueLimit: Limit = .{};
            var VCOSAIOutputFreq_ValueLimit: Limit = .{};
            var VCOSAIOutputFreq_ValueRLimit: Limit = .{};
            var VCOSAIOutputFreq_ValueQLimit: Limit = .{};
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

                    break :blk conf_item orelse .RCC_RTCCLKSOURCE_HSE_DIV2;
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
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => {},
                        .RCC_SYSCLKSOURCE_HSE => {},
                        .RCC_SYSCLKSOURCE_PLLCLK => {},
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_HSI;
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 1.8e8,
                };
                break :blk null;
            };
            const EthernetFreq_ValueValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                if (config.flags.USB_OTG_HSUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 3e7,
                        .max = 1.8e8,
                    };
                    break :blk null;
                } else if (config.flags.ETHUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 2.5e7,
                        .max = 1.8e8,
                    };
                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    HCLKFreq_ValueLimit = .{
                        .min = 1.42e7,
                        .max = 1.8e8,
                    };
                    break :blk null;
                }
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.8e8,
                };
                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                AHBFreq_ValueLimit = .{
                    .min = 0e0,
                    .max = null,
                };
                break :blk null;
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
                    const max: ?f32 = @min(45000000, std.math.floatMax(f32));
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
                    .max = 4.5e7,
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
                    .max = 9e7,
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
            const @"48MHZClocksFreq_ValueValue": ?f32 = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    @"48MHZClocksFreq_ValueLimit" = .{
                        .min = 4.788e7,
                        .max = 4.812e7,
                    };
                    break :blk null;
                }
                @"48MHZClocksFreq_ValueLimit" = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
            };
            const I2SClockSourceValue: ?I2SClockSourceList = blk: {
                const conf_item = config.I2SClockSource;
                if (conf_item) |item| {
                    switch (item) {
                        .I2S_CLOCK_EXTERNAL => {},
                        .I2S_CLOCK_PLL => I2SSourceIsPll = true,
                    }
                }

                break :blk conf_item orelse {
                    I2SSourceIsPll = true;
                    break :blk .I2S_CLOCK_PLL;
                };
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const I2SClocksFreq_ValueValue: ?f32 = blk: {
                I2SClocksFreq_ValueLimit = .{
                    .min = null,
                    .max = 1.92e8,
                };
                break :blk null;
            };
            const PLLI2SDivQValue: ?f32 = blk: {
                const config_val = config.PLLI2SDivQ;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLI2SDivQ",
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
                            "PLLI2SDivQ",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const SAIClockSource_BlockAValue: ?SAIClockSource_BlockAList = blk: {
                const conf_item = config.SAIClockSource_BlockA;
                if (conf_item) |item| {
                    switch (item) {
                        .SAI_CLKSOURCE_PLLI2S => SAISourceIsPllI2SA = true,
                        .SAI_CLKSOURCE_EXT => {},
                        .SAI_CLKSOURCE_PLLSAI => SAISourceIsPllSAIA = true,
                    }
                }

                break :blk conf_item orelse {
                    SAISourceIsPllSAIA = true;
                    break :blk .SAI_CLKSOURCE_PLLSAI;
                };
            };
            const SAI_AClocksFreq_ValueValue: ?f32 = blk: {
                break :blk 1.225e7;
            };
            const PLLSAIDivRValue: ?PLLSAIDivRList = blk: {
                const conf_item = config.PLLSAIDivR;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSAIDIVR_2 => {},
                        .RCC_PLLSAIDIVR_4 => {},
                        .RCC_PLLSAIDIVR_8 => {},
                        .RCC_PLLSAIDIVR_16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSAIDIVR_2;
            };
            const LCDTFTFreq_ValueValue: ?f32 = blk: {
                break :blk 1.225e7;
            };
            const PLLSAIDivQValue: ?f32 = blk: {
                const config_val = config.PLLSAIDivQ;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIDivQ",
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
                            "PLLSAIDivQ",
                            "Else",
                            "No Extra Log",
                            32,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const SAIClockSource_BlockBValue: ?SAIClockSource_BlockBList = blk: {
                const conf_item = config.SAIClockSource_BlockB;
                if (conf_item) |item| {
                    switch (item) {
                        .SAI_CLKSOURCE_PLLI2S => SAISourceIsPllI2SB = true,
                        .SAI_CLKSOURCE_EXT => {},
                        .SAI_CLKSOURCE_PLLSAI => SAISourceIsPllSAIB = true,
                    }
                }

                break :blk conf_item orelse {
                    SAISourceIsPllSAIB = true;
                    break :blk .SAI_CLKSOURCE_PLLSAI;
                };
            };
            const SAI_BClocksFreq_ValueValue: ?f32 = blk: {
                break :blk 1.225e7;
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
                        .RCC_MCO2SOURCE_PLLI2SCLK => {},
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 49;
            };
            const PLLSAIRValue: ?f32 = blk: {
                const config_val = config.PLLSAIR;
                if (config_val) |val| {
                    if (val < 2) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLLSAIR",
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
                            "PLLSAIR",
                            "Else",
                            "No Extra Log",
                            7,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 4;
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
            const RTCHSEDivFreq_ValueValue: ?f32 = blk: {
                RTCHSEDivFreq_ValueLimit = .{
                    .min = null,
                    .max = 1e6,
                };
                break :blk null;
            };
            const PLLUsedValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCO1Config) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLCLK, .@"=")) and config.flags.MCO2Config) or config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.SDIOUsed_ForRCC or config.flags.RNGUsed_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOInputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") or ((I2SSourceIsPll and config.flags.I2SUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLI2SCLK, .@"=")) and config.flags.MCO2Config)) or (config.flags.SAIAUsed_ForRCC and (SAISourceIsPllI2SA or SAISourceIsPllSAIA)) or (config.flags.SAIBUsed_ForRCC and (SAISourceIsPllI2SB or SAISourceIsPllSAIB) or config.flags.LTDCUsed_ForRCC)) {
                    VCOInputFreq_ValueLimit = .{
                        .min = 9.5e5,
                        .max = 2.1e6,
                    };
                    break :blk null;
                }
                break :blk 1e6;
            };
            const VCOOutputFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };
                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PLLQCLKFreq_ValueValue: ?f32 = blk: {
                if (((config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC or config.flags.USB_OTG_FSUsed_ForRCC or config.flags.RNGUsed_ForRCC))) {
                    PLLQCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 7.5e7,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const PLLCLKFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 2.4e7,
                        .max = 1.8e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VcooutputI2SValue: ?f32 = blk: {
                if ((I2SSourceIsPll and config.flags.I2SUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLI2SCLK, .@"=")) and config.flags.MCO2Config)) {
                    VcooutputI2SLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VcooutputI2SQValue: ?f32 = blk: {
                if ((config.flags.SAIAUsed_ForRCC and SAISourceIsPllI2SA) or (config.flags.SAIBUsed_ForRCC and SAISourceIsPllI2SB)) {
                    VcooutputI2SQLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };
                    break :blk null;
                }
                break :blk 9.6e7;
            };
            const VCOI2SOutputFreq_ValueValue: ?f32 = blk: {
                if (((I2SSourceIsPll and config.flags.I2SUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_PLLI2SCLK, .@"=")) and config.flags.MCO2Config)) or (config.flags.SAIAUsed_ForRCC and SAISourceIsPllI2SA) or (config.flags.SAIBUsed_ForRCC and SAISourceIsPllI2SB)) {
                    VCOI2SOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };
                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const VCOSAIOutputFreq_ValueValue: ?f32 = blk: {
                if ((config.flags.SAIAUsed_ForRCC and SAISourceIsPllSAIA) or (config.flags.SAIBUsed_ForRCC and SAISourceIsPllSAIB) or config.flags.LTDCUsed_ForRCC) {
                    VCOSAIOutputFreq_ValueLimit = .{
                        .min = 1e8,
                        .max = 4.32e8,
                    };
                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const VCOSAIOutputFreq_ValueRValue: ?f32 = blk: {
                if (config.flags.LTDCUsed_ForRCC) {
                    VCOSAIOutputFreq_ValueRLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };
                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const VCOSAIOutputFreq_ValueQValue: ?f32 = blk: {
                if ((config.flags.SAIAUsed_ForRCC and SAISourceIsPllSAIA) or (config.flags.SAIBUsed_ForRCC and SAISourceIsPllSAIB)) {
                    VCOSAIOutputFreq_ValueQLimit = .{
                        .min = null,
                        .max = 2.16e8,
                    };
                    break :blk null;
                }
                break :blk 1.92e8;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">")))) {
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
                } else if (((check_ref(@TypeOf(PWREXT_OverDriveValue), PWREXT_OverDriveValue, .PWREXT_OverDrive_DESACTIVATED, .@"=")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@">")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@"="))))) {
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
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">"))) {
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
            const PWREXT_OverDriveValue: ?PWREXT_OverDriveList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">")) or (check_ref(@TypeOf(APB1Freq_ValueValue), APB1Freq_ValueValue, 42000000, .@">")) or (check_ref(@TypeOf(APB2Freq_ValueValue), APB2Freq_ValueValue, 84000000, .@">"))) {
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
                            , .{ "PWREXT_OverDrive", "(HCLKFreq_Value > 168000000)|(APB1Freq_Value > 42000000)|(APB2Freq_Value > 84000000) ", "No Extra Log", "PWREXT_OverDrive_ACTIVATED", i });
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
                } else if (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")) {
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
                            , .{ "PWREXT_OverDrive", "PWR_Regulator_Voltage_Scale = PWR_REGULATOR_VOLTAGE_SCALE3", "No Extra Log", "PWREXT_OverDrive_DESACTIVATED", i });
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
            const VDD_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(PWREXT_OverDriveValue), PWREXT_OverDriveValue, .PWREXT_OverDrive_ACTIVATED, .@"="))) {
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
                    break :blk config_val orelse 3.3;
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
                if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 30000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 22000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 20000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 44000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 40000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 90000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 72000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 66000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 60000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 96000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 88000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 80000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 150000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 110000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 100000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 144000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 132000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 120000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.7, .@"=")))) and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 168000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 154000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@"="))))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 140000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@"="))))))
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
                } else if (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.4, .@"=")))) and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 176000000, .@">"))) or
                    ((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@"=")))) and (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 160000000, .@">"))))
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
            const USBFSEnableValue: ?USBFSEnableList = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    const item: USBFSEnableList = .true;
                    break :blk item;
                }
                const item: USBFSEnableList = .false;
                break :blk item;
            };
            const USBHSEnableValue: ?USBHSEnableList = blk: {
                if (config.flags.USB_OTG_HSEmbeddedPHYUsed_ForRCC) {
                    const item: USBHSEnableList = .true;
                    break :blk item;
                }
                const item: USBHSEnableList = .false;
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
            const SDIOEnableValue: ?SDIOEnableList = blk: {
                if (config.flags.SDIOUsed_ForRCC) {
                    const item: SDIOEnableList = .true;
                    break :blk item;
                }
                const item: SDIOEnableList = .false;
                break :blk item;
            };
            const I2SEnableValue: ?I2SEnableList = blk: {
                if (!config.flags.I2SUsed_ForRCC) {
                    const item: I2SEnableList = .false;
                    const conf_item = config.extra.I2SEnable;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "I2SEnable", "!I2SUsed_ForRCC", "I2S ip not used", "false", i });
                        }
                    }
                    break :blk item;
                } else if (config.flags.I2SUsed_ForRCC) {
                    const item: I2SEnableList = .true;
                    const conf_item = config.extra.I2SEnable;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "I2SEnable", "I2SUsed_ForRCC", "I2S ip used", "true", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.extra.I2SEnable;
                if (conf_item) |item| {
                    switch (item) {
                        .true => {},
                        .false => {},
                    }
                }

                break :blk conf_item orelse .true;
            };
            const ExtClockEnableValue: ?ExtClockEnableList = blk: {
                if (config.flags.AudioClockConfig) {
                    const item: ExtClockEnableList = .true;
                    break :blk item;
                }
                const item: ExtClockEnableList = .false;
                break :blk item;
            };
            const SAIAEnableValue: ?SAIAEnableList = blk: {
                if (config.flags.SAIAUsed_ForRCC) {
                    const item: SAIAEnableList = .true;
                    break :blk item;
                }
                const item: SAIAEnableList = .false;
                break :blk item;
            };
            const SAIBEnableValue: ?SAIBEnableList = blk: {
                if (config.flags.SAIBUsed_ForRCC) {
                    const item: SAIBEnableList = .true;
                    break :blk item;
                }
                const item: SAIBEnableList = .false;
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
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSI_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSEUsedValue: ?f32 = blk: {
                if (((config.flags.HSEByPass or config.flags.HSEOscillator) and (check_MCU("SEM2RCC_HSE_REQUIRED_TIM11") and check_MCU("TIM11") and check_MCU("Semaphore_input_Channel1TIM11"))) or (config.flags.RTCUsed_ForRCC and !((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and (config.flags.MCO1Config)) or ((check_ref(@TypeOf(RCC_MCO2SourceValue), RCC_MCO2SourceValue, .RCC_MCO2SOURCE_HSE, .@"=")) and (config.flags.MCO2Config))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_LSE_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or (check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) or ((check_ref(@TypeOf(RCC_RTC_Clock_SourceValue), RCC_RTC_Clock_SourceValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and config.flags.RTCUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and (config.flags.MCO1Config)))) {
                    break :blk 1;
                }
                break :blk 0;
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
            const EnableExtClockForI2SValue: ?EnableExtClockForI2SList = blk: {
                if (config.flags.I2SUsed_ForRCC and config.flags.AudioClockConfig) {
                    const item: EnableExtClockForI2SList = .true;
                    break :blk item;
                }
                const item: EnableExtClockForI2SList = .false;
                break :blk item;
            };
            const PLLI2SCLKSAIA_BEnableValue: ?PLLI2SCLKSAIA_BEnableList = blk: {
                if (config.flags.SAIAUsed_ForRCC or config.flags.SAIBUsed_ForRCC or config.flags.I2SUsed_ForRCC) {
                    const item: PLLI2SCLKSAIA_BEnableList = .true;
                    break :blk item;
                }
                const item: PLLI2SCLKSAIA_BEnableList = .false;
                break :blk item;
            };
            const EnableExtClockForSAIAValue: ?EnableExtClockForSAIAList = blk: {
                if ((config.flags.SAIAUsed_ForRCC and config.flags.AudioClockConfig)) {
                    const item: EnableExtClockForSAIAList = .true;
                    break :blk item;
                }
                const item: EnableExtClockForSAIAList = .false;
                break :blk item;
            };
            const EnableExtClockForSAIBValue: ?EnableExtClockForSAIBList = blk: {
                if ((config.flags.SAIBUsed_ForRCC and config.flags.AudioClockConfig)) {
                    const item: EnableExtClockForSAIBList = .true;
                    break :blk item;
                }
                const item: EnableExtClockForSAIBList = .false;
                break :blk item;
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

            var PLLM = ClockNode{
                .name = "PLLM",
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

            var EthernetPtpOutput = ClockNode{
                .name = "EthernetPtpOutput",
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

            var USBOTGOutput = ClockNode{
                .name = "USBOTGOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2SSrc = ClockNode{
                .name = "I2SSrc",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2SClocksOutput = ClockNode{
                .name = "I2SClocksOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SSAIDiv = ClockNode{
                .name = "PLLI2SSAIDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI_AMuxSrc = ClockNode{
                .name = "SAI_AMuxSrc",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI_ACLKOutput = ClockNode{
                .name = "SAI_ACLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAILCDDiv = ClockNode{
                .name = "PLLSAILCDDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var @"LCD-TFTCLKOutput" = ClockNode{
                .name = "LCD-TFTCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAISAIDiv = ClockNode{
                .name = "PLLSAISAIDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI_BMuxSrc = ClockNode{
                .name = "SAI_BMuxSrc",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI_BCLKOutput = ClockNode{
                .name = "SAI_BCLKOutput",
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

            var PLLSAIN = ClockNode{
                .name = "PLLSAIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIR = ClockNode{
                .name = "PLLSAIR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAIQ = ClockNode{
                .name = "PLLSAIQ",
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

            var PLLI2SN = ClockNode{
                .name = "PLLI2SN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SR = ClockNode{
                .name = "PLLI2SR",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SQ = ClockNode{
                .name = "PLLI2SQ",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSE_RTC = ClockNode{
                .name = "HSE_RTC",
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

            var PLL48CLK = ClockNode{
                .name = "PLL48CLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLCLK = ClockNode{
                .name = "PLLCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLI2SCLK = ClockNode{
                .name = "PLLI2SCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAICLK_I2S = ClockNode{
                .name = "PLLSAICLK_I2S",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOI2SOutput = ClockNode{
                .name = "VCOI2SOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCOSAIOutput = ClockNode{
                .name = "VCOSAIOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLLCDCLK = ClockNode{
                .name = "PLLLCDCLK",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSAICLK_SAI = ClockNode{
                .name = "PLLSAICLK_SAI",
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

            std.mem.doNotOptimizeAway(EthernetFreq_ValueValue);
            EthernetPtpOutput.nodetype = .output;
            EthernetPtpOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.limit = AHBFreq_ValueLimit;
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
            if (check_ref(@TypeOf(USBFSEnableValue), USBFSEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBHSEnableValue), USBHSEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDIOEnableValue), SDIOEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(@"48MHZClocksFreq_ValueValue");
                USBOTGOutput.limit = @"48MHZClocksFreq_ValueLimit";
                USBOTGOutput.nodetype = .output;
                USBOTGOutput.parents = &.{&PLLQ};
            }
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=")) {
                const I2SSrc_clk_value = I2SClockSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2SSrc",
                    "Else",
                    "No Extra Log",
                    "I2SClockSource",
                });
                const I2SSrcparents = [_]*const ClockNode{
                    &I2S_CKIN,
                    &PLLI2SR,
                };
                I2SSrc.nodetype = .multi;
                I2SSrc.parents = &.{I2SSrcparents[I2SSrc_clk_value.get()]};
            }
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
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2SClocksFreq_ValueValue);
                I2SClocksOutput.limit = I2SClocksFreq_ValueLimit;
                I2SClocksOutput.nodetype = .output;
                I2SClocksOutput.parents = &.{&I2SSrc};
            }
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"="))
            {
                const PLLI2SSAIDiv_clk_value = PLLI2SDivQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLI2SSAIDiv",
                    "Else",
                    "No Extra Log",
                    "PLLI2SDivQ",
                });
                PLLI2SSAIDiv.nodetype = .div;
                PLLI2SSAIDiv.value = PLLI2SSAIDiv_clk_value;
                PLLI2SSAIDiv.parents = &.{&PLLI2SQ};
            }
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=")) {
                const SAI_AMuxSrc_clk_value = SAIClockSource_BlockAValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI_AMuxSrc",
                    "Else",
                    "No Extra Log",
                    "SAIClockSource_BlockA",
                });
                const SAI_AMuxSrcparents = [_]*const ClockNode{
                    &PLLI2SSAIDiv,
                    &I2S_CKIN,
                    &PLLSAISAIDiv,
                };
                SAI_AMuxSrc.nodetype = .multi;
                SAI_AMuxSrc.parents = &.{SAI_AMuxSrcparents[SAI_AMuxSrc_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI_AClocksFreq_ValueValue);
                SAI_ACLKOutput.nodetype = .output;
                SAI_ACLKOutput.parents = &.{&SAI_AMuxSrc};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                const PLLSAILCDDiv_clk_value = PLLSAIDivRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAILCDDiv",
                    "Else",
                    "No Extra Log",
                    "PLLSAIDivR",
                });
                PLLSAILCDDiv.nodetype = .div;
                PLLSAILCDDiv.value = PLLSAILCDDiv_clk_value.get();
                PLLSAILCDDiv.parents = &.{&PLLSAIR};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LCDTFTFreq_ValueValue);
                @"LCD-TFTCLKOutput".nodetype = .output;
                @"LCD-TFTCLKOutput".parents = &.{&PLLSAILCDDiv};
            }
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"="))
            {
                const PLLSAISAIDiv_clk_value = PLLSAIDivQValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAISAIDiv",
                    "Else",
                    "No Extra Log",
                    "PLLSAIDivQ",
                });
                PLLSAISAIDiv.nodetype = .div;
                PLLSAISAIDiv.value = PLLSAISAIDiv_clk_value;
                PLLSAISAIDiv.parents = &.{&PLLSAIQ};
            }
            if (check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"=")) {
                const SAI_BMuxSrc_clk_value = SAIClockSource_BlockBValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI_BMuxSrc",
                    "Else",
                    "No Extra Log",
                    "SAIClockSource_BlockB",
                });
                const SAI_BMuxSrcparents = [_]*const ClockNode{
                    &PLLI2SSAIDiv,
                    &I2S_CKIN,
                    &PLLSAISAIDiv,
                };
                SAI_BMuxSrc.nodetype = .multi;
                SAI_BMuxSrc.parents = &.{SAI_BMuxSrcparents[SAI_BMuxSrc_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SAI_BClocksFreq_ValueValue);
                SAI_BCLKOutput.nodetype = .output;
                SAI_BCLKOutput.parents = &.{&SAI_BMuxSrc};
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
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"="))
            {
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
                PLLSAIN.parents = &.{&PLLM};
            }
            if (check_ref(@TypeOf(LTDCEnableValue), LTDCEnableValue, .true, .@"=")) {
                const PLLSAIR_clk_value = PLLSAIRValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLLSAIR",
                    "Else",
                    "No Extra Log",
                    "PLLSAIR",
                });
                PLLSAIR.nodetype = .div;
                PLLSAIR.value = PLLSAIR_clk_value;
                PLLSAIR.parents = &.{&PLLSAIN};
            }
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(USBFSEnableValue), USBFSEnableValue, .true, .@"=") or
                check_ref(@TypeOf(USBHSEnableValue), USBHSEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDIOEnableValue), SDIOEnableValue, .true, .@"="))
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
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCO2OutPutEnableValue), MCO2OutPutEnableValue, .true, .@"="))
            {
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
                PLLI2SN.parents = &.{&PLLM};
            }
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=") or
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
            if (check_ref(@TypeOf(SAIAEnableValue), SAIAEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAIBEnableValue), SAIBEnableValue, .true, .@"="))
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

            std.mem.doNotOptimizeAway(RTCHSEDivFreq_ValueValue);
            HSE_RTC.limit = RTCHSEDivFreq_ValueLimit;
            HSE_RTC.nodetype = .output;
            HSE_RTC.parents = &.{&HSERTCDevisor};

            std.mem.doNotOptimizeAway(VCOInputFreq_ValueValue);
            VCOInput.limit = VCOInputFreq_ValueLimit;
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};

            std.mem.doNotOptimizeAway(VCOOutputFreq_ValueValue);
            VCOOutput.limit = VCOOutputFreq_ValueLimit;
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};

            std.mem.doNotOptimizeAway(PLLQCLKFreq_ValueValue);
            PLL48CLK.limit = PLLQCLKFreq_ValueLimit;
            PLL48CLK.nodetype = .output;
            PLL48CLK.parents = &.{&PLLQ};

            std.mem.doNotOptimizeAway(PLLCLKFreq_ValueValue);
            PLLCLK.limit = PLLCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLP};

            std.mem.doNotOptimizeAway(VcooutputI2SValue);
            PLLI2SCLK.limit = VcooutputI2SLimit;
            PLLI2SCLK.nodetype = .output;
            PLLI2SCLK.parents = &.{&PLLI2SR};

            std.mem.doNotOptimizeAway(VcooutputI2SQValue);
            PLLSAICLK_I2S.limit = VcooutputI2SQLimit;
            PLLSAICLK_I2S.nodetype = .output;
            PLLSAICLK_I2S.parents = &.{&PLLI2SQ};

            std.mem.doNotOptimizeAway(VCOI2SOutputFreq_ValueValue);
            VCOI2SOutput.limit = VCOI2SOutputFreq_ValueLimit;
            VCOI2SOutput.nodetype = .output;
            VCOI2SOutput.parents = &.{&PLLI2SN};

            std.mem.doNotOptimizeAway(VCOSAIOutputFreq_ValueValue);
            VCOSAIOutput.limit = VCOSAIOutputFreq_ValueLimit;
            VCOSAIOutput.nodetype = .output;
            VCOSAIOutput.parents = &.{&PLLSAIN};

            std.mem.doNotOptimizeAway(VCOSAIOutputFreq_ValueRValue);
            PLLLCDCLK.limit = VCOSAIOutputFreq_ValueRLimit;
            PLLLCDCLK.nodetype = .output;
            PLLLCDCLK.parents = &.{&PLLSAIR};

            std.mem.doNotOptimizeAway(VCOSAIOutputFreq_ValueQValue);
            PLLSAICLK_SAI.limit = VCOSAIOutputFreq_ValueQLimit;
            PLLSAICLK_SAI.nodetype = .output;
            PLLSAICLK_SAI.parents = &.{&PLLSAIQ};

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut = try TimPrescOut.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.PeriphPrescOutput = try PeriphPrescOutput.get_output();
            out.PeriphPrescaler = try PeriphPrescaler.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.EthernetPtpOutput = try EthernetPtpOutput.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.USBOTGOutput = try USBOTGOutput.get_output();
            out.PLLQ = try PLLQ.get_output();
            out.MCO1Pin = try MCO1Pin.get_output();
            out.MCO1Div = try MCO1Div.get_output();
            out.MCO1Mult = try MCO1Mult.get_output();
            out.PLLP = try PLLP.get_output();
            out.PLLN = try PLLN.get_output();
            out.SAI_ACLKOutput = try SAI_ACLKOutput.get_output();
            out.SAI_AMuxSrc = try SAI_AMuxSrc.get_output();
            out.SAI_BCLKOutput = try SAI_BCLKOutput.get_output();
            out.SAI_BMuxSrc = try SAI_BMuxSrc.get_output();
            out.PLLI2SSAIDiv = try PLLI2SSAIDiv.get_output();
            out.PLLI2SQ = try PLLI2SQ.get_output();
            out.I2SClocksOutput = try I2SClocksOutput.get_output();
            out.I2SSrc = try I2SSrc.get_output();
            out.PLLI2SR = try PLLI2SR.get_output();
            out.PLLI2SN = try PLLI2SN.get_output();
            out.PLLSAISAIDiv = try PLLSAISAIDiv.get_output();
            out.PLLSAIQ = try PLLSAIQ.get_output();
            out.@"LCD-TFTCLKOutput" = try @"LCD-TFTCLKOutput".get_output();
            out.PLLSAILCDDiv = try PLLSAILCDDiv.get_output();
            out.PLLSAIR = try PLLSAIR.get_output();
            out.PLLSAIN = try PLLSAIN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.HSE_RTC = try HSE_RTC.get_extra_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLL48CLK = try PLL48CLK.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.PLLI2SCLK = try PLLI2SCLK.get_extra_output();
            out.PLLSAICLK_I2S = try PLLSAICLK_I2S.get_extra_output();
            out.VCOI2SOutput = try VCOI2SOutput.get_extra_output();
            out.VCOSAIOutput = try VCOSAIOutput.get_extra_output();
            out.PLLLCDCLK = try PLLLCDCLK.get_extra_output();
            out.PLLSAICLK_SAI = try PLLSAICLK_SAI.get_extra_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.RCC_RTC_Clock_Source = RCC_RTC_Clock_SourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.I2SClockSource = I2SClockSourceValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.PLLI2SDivQ = PLLI2SDivQValue;
            ref_out.SAIClockSource_BlockA = SAIClockSource_BlockAValue;
            ref_out.PLLSAIDivR = PLLSAIDivRValue;
            ref_out.PLLSAIDivQ = PLLSAIDivQValue;
            ref_out.SAIClockSource_BlockB = SAIClockSource_BlockBValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv1 = RCC_MCODiv1Value;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCODiv2 = RCC_MCODiv2Value;
            ref_out.PLLSAIN = PLLSAINValue;
            ref_out.PLLSAIR = PLLSAIRValue;
            ref_out.PLLSAIQ = PLLSAIQValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLP = PLLPValue;
            ref_out.PLLQ = PLLQValue;
            ref_out.PLLI2SN = PLLI2SNValue;
            ref_out.PLLI2SR = PLLI2SRValue;
            ref_out.PLLI2SQ = PLLI2SQValue;
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
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.USBFSEnable = USBFSEnableValue;
            ref_out.USBHSEnable = USBHSEnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.SDIOEnable = SDIOEnableValue;
            ref_out.I2SEnable = I2SEnableValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.SAIAEnable = SAIAEnableValue;
            ref_out.SAIBEnable = SAIBEnableValue;
            ref_out.LTDCEnable = LTDCEnableValue;
            ref_out.MCO1OutPutEnable = MCO1OutPutEnableValue;
            ref_out.MCO2OutPutEnable = MCO2OutPutEnableValue;
            ref_out.LSIUsed = LSIUsedValue;
            ref_out.HSEUsed = HSEUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.EnableExtClockForI2S = EnableExtClockForI2SValue;
            ref_out.PLLI2SCLKSAIA_BEnable = PLLI2SCLKSAIA_BEnableValue;
            ref_out.EnableExtClockForSAIA = EnableExtClockForSAIAValue;
            ref_out.EnableExtClockForSAIB = EnableExtClockForSAIBValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
