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
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_HSI => 0,
            .RCC_SYSCLKSOURCE_HSE => 1,
            .RCC_SYSCLKSOURCE_PLLCLK => 2,
        };
    }
};
pub const I2S2ClockSelectionList = enum {
    RCC_I2S2CLKSOURCE_SYSCLK,
    RCC_I2S2CLKSOURCE_PLLI2S_VCO,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2S2CLKSOURCE_SYSCLK => 0,
            .RCC_I2S2CLKSOURCE_PLLI2S_VCO => 1,
        };
    }
};
pub const I2S3ClockSelectionList = enum {
    RCC_I2S3CLKSOURCE_SYSCLK,
    RCC_I2S3CLKSOURCE_PLLI2S_VCO,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2S3CLKSOURCE_SYSCLK => 0,
            .RCC_I2S3CLKSOURCE_PLLI2S_VCO => 1,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV128,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV128 => 0,
            .RCC_RTCCLKSOURCE_LSE => 1,
            .RCC_RTCCLKSOURCE_LSI => 2,
        };
    }
};
pub const RCC_MCOSourceList = enum {
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_PLL2CLK,
    MCOPLL3Div,
    RCC_MCO1SOURCE_EXT_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_HSE => 0,
            .RCC_MCO1SOURCE_HSI => 1,
            .RCC_MCO1SOURCE_SYSCLK => 2,
            .RCC_MCO1SOURCE_PLLCLK => 3,
            .RCC_MCO1SOURCE_PLL2CLK => 4,
            .MCOPLL3Div => 5,
            .RCC_MCO1SOURCE_EXT_HSE => 6,
        };
    }
};
pub const Prediv1SourceList = enum {
    RCC_PREDIV1_SOURCE_HSE,
    RCC_PREDIV1_SOURCE_PLL2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PREDIV1_SOURCE_HSE => 0,
            .RCC_PREDIV1_SOURCE_PLL2 => 1,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI_DIV2,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI_DIV2 => 0,
            .RCC_PLLSOURCE_HSE => 1,
        };
    }
};
pub const Prediv2List = enum {
    RCC_HSE_PREDIV2_DIV1,
    RCC_HSE_PREDIV2_DIV2,
    RCC_HSE_PREDIV2_DIV3,
    RCC_HSE_PREDIV2_DIV4,
    RCC_HSE_PREDIV2_DIV5,
    RCC_HSE_PREDIV2_DIV6,
    RCC_HSE_PREDIV2_DIV7,
    RCC_HSE_PREDIV2_DIV8,
    RCC_HSE_PREDIV2_DIV9,
    RCC_HSE_PREDIV2_DIV10,
    RCC_HSE_PREDIV2_DIV11,
    RCC_HSE_PREDIV2_DIV12,
    RCC_HSE_PREDIV2_DIV13,
    RCC_HSE_PREDIV2_DIV14,
    RCC_HSE_PREDIV2_DIV15,
    RCC_HSE_PREDIV2_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSE_PREDIV2_DIV1 => 1,
            .RCC_HSE_PREDIV2_DIV2 => 2,
            .RCC_HSE_PREDIV2_DIV3 => 3,
            .RCC_HSE_PREDIV2_DIV4 => 4,
            .RCC_HSE_PREDIV2_DIV5 => 5,
            .RCC_HSE_PREDIV2_DIV6 => 6,
            .RCC_HSE_PREDIV2_DIV7 => 7,
            .RCC_HSE_PREDIV2_DIV8 => 8,
            .RCC_HSE_PREDIV2_DIV9 => 9,
            .RCC_HSE_PREDIV2_DIV10 => 10,
            .RCC_HSE_PREDIV2_DIV11 => 11,
            .RCC_HSE_PREDIV2_DIV12 => 12,
            .RCC_HSE_PREDIV2_DIV13 => 13,
            .RCC_HSE_PREDIV2_DIV14 => 14,
            .RCC_HSE_PREDIV2_DIV15 => 15,
            .RCC_HSE_PREDIV2_DIV16 => 16,
        };
    }
};
pub const PLL2MulList = enum {
    RCC_PLL2_MUL8,
    RCC_PLL2_MUL9,
    RCC_PLL2_MUL10,
    RCC_PLL2_MUL11,
    RCC_PLL2_MUL12,
    RCC_PLL2_MUL13,
    RCC_PLL2_MUL14,
    RCC_PLL2_MUL16,
    RCC_PLL2_MUL20,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL2_MUL8 => 8,
            .RCC_PLL2_MUL9 => 9,
            .RCC_PLL2_MUL10 => 10,
            .RCC_PLL2_MUL11 => 11,
            .RCC_PLL2_MUL12 => 12,
            .RCC_PLL2_MUL13 => 13,
            .RCC_PLL2_MUL14 => 14,
            .RCC_PLL2_MUL16 => 16,
            .RCC_PLL2_MUL20 => 20,
        };
    }
};
pub const PLL3MulList = enum {
    RCC_PLLI2S_MUL8,
    RCC_PLLI2S_MUL9,
    RCC_PLLI2S_MUL10,
    RCC_PLLI2S_MUL11,
    RCC_PLLI2S_MUL12,
    RCC_PLLI2S_MUL13,
    RCC_PLLI2S_MUL14,
    RCC_PLLI2S_MUL16,
    RCC_PLLI2S_MUL20,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLLI2S_MUL8 => 8,
            .RCC_PLLI2S_MUL9 => 9,
            .RCC_PLLI2S_MUL10 => 10,
            .RCC_PLLI2S_MUL11 => 11,
            .RCC_PLLI2S_MUL12 => 12,
            .RCC_PLLI2S_MUL13 => 13,
            .RCC_PLLI2S_MUL14 => 14,
            .RCC_PLLI2S_MUL16 => 16,
            .RCC_PLLI2S_MUL20 => 20,
        };
    }
};
pub const RCC_MCOMult_Clock_Source_FROM_PLL3MULList = enum {
    RCC_MCO1SOURCE_PLL3CLK,
    RCC_MCO1SOURCE_PLL3CLK_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO1SOURCE_PLL3CLK => 1,
            .RCC_MCO1SOURCE_PLL3CLK_DIV2 => 2,
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
pub const TimSys_DivList = enum {
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
pub const ADCPrescList = enum {
    RCC_ADCPCLK2_DIV2,
    RCC_ADCPCLK2_DIV4,
    RCC_ADCPCLK2_DIV6,
    RCC_ADCPCLK2_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADCPCLK2_DIV2 => 2,
            .RCC_ADCPCLK2_DIV4 => 4,
            .RCC_ADCPCLK2_DIV6 => 6,
            .RCC_ADCPCLK2_DIV8 => 8,
        };
    }
};
pub const HSEDivPLLList = enum {
    RCC_HSE_PREDIV_DIV1,
    RCC_HSE_PREDIV_DIV2,
    RCC_HSE_PREDIV_DIV3,
    RCC_HSE_PREDIV_DIV4,
    RCC_HSE_PREDIV_DIV5,
    RCC_HSE_PREDIV_DIV6,
    RCC_HSE_PREDIV_DIV7,
    RCC_HSE_PREDIV_DIV8,
    RCC_HSE_PREDIV_DIV9,
    RCC_HSE_PREDIV_DIV10,
    RCC_HSE_PREDIV_DIV11,
    RCC_HSE_PREDIV_DIV12,
    RCC_HSE_PREDIV_DIV13,
    RCC_HSE_PREDIV_DIV14,
    RCC_HSE_PREDIV_DIV15,
    RCC_HSE_PREDIV_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSE_PREDIV_DIV1 => 1,
            .RCC_HSE_PREDIV_DIV2 => 2,
            .RCC_HSE_PREDIV_DIV3 => 3,
            .RCC_HSE_PREDIV_DIV4 => 4,
            .RCC_HSE_PREDIV_DIV5 => 5,
            .RCC_HSE_PREDIV_DIV6 => 6,
            .RCC_HSE_PREDIV_DIV7 => 7,
            .RCC_HSE_PREDIV_DIV8 => 8,
            .RCC_HSE_PREDIV_DIV9 => 9,
            .RCC_HSE_PREDIV_DIV10 => 10,
            .RCC_HSE_PREDIV_DIV11 => 11,
            .RCC_HSE_PREDIV_DIV12 => 12,
            .RCC_HSE_PREDIV_DIV13 => 13,
            .RCC_HSE_PREDIV_DIV14 => 14,
            .RCC_HSE_PREDIV_DIV15 => 15,
            .RCC_HSE_PREDIV_DIV16 => 16,
        };
    }
};
pub const PLLMULList = enum {
    RCC_PLL_MUL4,
    RCC_PLL_MUL5,
    RCC_PLL_MUL6,
    RCC_PLL_MUL6_5,
    RCC_PLL_MUL7,
    RCC_PLL_MUL8,
    RCC_PLL_MUL9,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL_MUL4 => 4,
            .RCC_PLL_MUL5 => 5,
            .RCC_PLL_MUL6 => 6,
            .RCC_PLL_MUL6_5 => 6.5,
            .RCC_PLL_MUL7 => 7,
            .RCC_PLL_MUL8 => 8,
            .RCC_PLL_MUL9 => 9,
        };
    }
};
pub const USBPrescalerList = enum {
    RCC_USBCLKSOURCE_PLL_DIV2,
    RCC_USBCLKSOURCE_PLL_DIV3,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL_DIV2 => 2,
            .RCC_USBCLKSOURCE_PLL_DIV3 => 3,
        };
    }
};
pub const INSTRUCTION_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const FLatencyList = enum {
    FLASH_LATENCY_0,
    FLASH_LATENCY_1,
    FLASH_LATENCY_2,
};
pub const EnableLSEList = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const I2S2EnableList = enum {
    false,
    true,
};
pub const I2S3EnableList = enum {
    false,
    true,
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
pub const EnableHSEMCODevisorList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
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
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            ETHUsed_ForRCC: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            USE_ADC2: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
        };
        pub const Config = struct {
            LSE_VALUE: ?f32 = null,
            HSE_VALUE: ?f32 = null,
            Prediv2: ?Prediv2List = null,
            PLL2Mul: ?PLL2MulList = null,
            PLL3Mul: ?PLL3MulList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            I2S2ClockSelection: ?I2S2ClockSelectionList = null,
            I2S3ClockSelection: ?I2S3ClockSelectionList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_MCOMult_Clock_Source_FROM_PLL3MUL: ?RCC_MCOMult_Clock_Source_FROM_PLL3MULList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            TimSys_Div: ?TimSys_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            ADCPresc: ?ADCPrescList = null,
            Prediv1Source: ?Prediv1SourceList = null,
            HSEDivPLL: ?HSEDivPLLList = null,
            PLLSource: ?PLLSourceList = null,
            PLLMUL: ?PLLMULList = null,
            USBPrescaler: ?USBPrescalerList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            FLITFCLKoutput: f32 = 0,
            HSIDivPLL: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            HSEOSC: f32 = 0,
            Prediv2: f32 = 0,
            Prediv2output: f32 = 0,
            PLL2Mul: f32 = 0,
            PLL2VCOMul2: f32 = 0,
            PLL2VCOoutput: f32 = 0,
            PLL2CLKoutput: f32 = 0,
            PLL3Mul: f32 = 0,
            PLL3VCOMul2: f32 = 0,
            PLL3VCOoutput: f32 = 0,
            PLL3CLKoutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            I2S2Mult: f32 = 0,
            I2S2Output: f32 = 0,
            I2S3Mult: f32 = 0,
            I2S3Output: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            MCOPLL3Div: f32 = 0,
            MCOMultDivisor: f32 = 0,
            MCOMult: f32 = 0,
            MCOoutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            TimSysPresc: f32 = 0,
            TimSysOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            ADCprescaler: f32 = 0,
            ADCoutput: f32 = 0,
            Prediv1Source: f32 = 0,
            PreDiv1: f32 = 0,
            PLLSource: f32 = 0,
            VCO2output: f32 = 0,
            PLLMUL: f32 = 0,
            PLLVCOMul2: f32 = 0,
            USBPrescaler: f32 = 0,
            USBoutput: f32 = 0,
            PLLCLK: f32 = 0,
        };
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            ETHUsed_ForRCC: bool = false,
            USB_OTG_FSUsed_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            USE_ADC2: bool = false,
            PLLUsed: bool = false,
            EnableLSE: bool = false,
            EnableHSE: bool = false,
            I2S2Enable: bool = false,
            I2S3Enable: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            EnableHSEMCODevisor: bool = false,
            MCOEnable: bool = false,
            ADCEnable: bool = false,
            USBEnable: bool = false,
            PLL2Used: bool = false,
            PLL3Used: bool = false,
            EnableLSERTC: bool = false,
            HSEUsed: bool = false,
            LSEUsed: bool = false,
            LSIUsed: bool = false,
            HSIUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSIDivPLL: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            Prediv2: ?Prediv2List = null, //from RCC Clock Config
            PLL2Mul: ?PLL2MulList = null, //from RCC Clock Config
            PLL2VCOMul2: ?f32 = null, //from RCC Clock Config
            PLL3Mul: ?PLL3MulList = null, //from RCC Clock Config
            PLL3VCOMul2: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            I2S2ClockSelection: ?I2S2ClockSelectionList = null, //from RCC Clock Config
            I2S3ClockSelection: ?I2S3ClockSelectionList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCOMult_Clock_Source_FROM_PLL3MUL: ?RCC_MCOMult_Clock_Source_FROM_PLL3MULList = null, //from RCC Clock Config
            RCC_MCOMult_Clock_Source_FROM_PLLMUL: ?f32 = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            TimSys_Div: ?TimSys_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            ADCPresc: ?ADCPrescList = null, //from RCC Clock Config
            Prediv1Source: ?Prediv1SourceList = null, //from RCC Clock Config
            HSEDivPLL: ?HSEDivPLLList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            PLLVCOMul2: ?f32 = null, //from RCC Clock Config
            USBPrescaler: ?USBPrescalerList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
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

            var HCLKDiv1: bool = false;
            var FLASH_LATENCY0: bool = false;

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

            var FLITFCLKoutput = ClockNode{
                .name = "FLITFCLKoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIDivPLL = ClockNode{
                .name = "HSIDivPLL",
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

            var HSEOSC = ClockNode{
                .name = "HSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var Prediv2 = ClockNode{
                .name = "Prediv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var Prediv2output = ClockNode{
                .name = "Prediv2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2Mul = ClockNode{
                .name = "PLL2Mul",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2VCOMul2 = ClockNode{
                .name = "PLL2VCOMul2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2VCOoutput = ClockNode{
                .name = "PLL2VCOoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL2CLKoutput = ClockNode{
                .name = "PLL2CLKoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3Mul = ClockNode{
                .name = "PLL3Mul",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3VCOMul2 = ClockNode{
                .name = "PLL3VCOMul2",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3VCOoutput = ClockNode{
                .name = "PLL3VCOoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL3CLKoutput = ClockNode{
                .name = "PLL3CLKoutput",
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

            var I2S2Mult = ClockNode{
                .name = "I2S2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S2Output = ClockNode{
                .name = "I2S2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S3Mult = ClockNode{
                .name = "I2S3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S3Output = ClockNode{
                .name = "I2S3Output",
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

            var MCOPLL3Div = ClockNode{
                .name = "MCOPLL3Div",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCOMultDivisor = ClockNode{
                .name = "MCOMultDivisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCOMult = ClockNode{
                .name = "MCOMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var MCOoutput = ClockNode{
                .name = "MCOoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHBPrescaler = ClockNode{
                .name = "AHBPrescaler",
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

            var FCLKCortexOutput = ClockNode{
                .name = "FCLKCortexOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimSysPresc = ClockNode{
                .name = "TimSysPresc",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimSysOutput = ClockNode{
                .name = "TimSysOutput",
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

            var ADCprescaler = ClockNode{
                .name = "ADCprescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var Prediv1Source = ClockNode{
                .name = "Prediv1Source",
                .nodetype = .off,
                .parents = &.{},
            };

            var PreDiv1 = ClockNode{
                .name = "PreDiv1",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var VCO2output = ClockNode{
                .name = "VCO2output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLMUL = ClockNode{
                .name = "PLLMUL",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLVCOMul2 = ClockNode{
                .name = "PLLVCOMul2",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBPrescaler = ClockNode{
                .name = "USBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBoutput = ClockNode{
                .name = "USBoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLCLK = ClockNode{
                .name = "PLLCLK",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const HSIDivPLLValue: ?f32 = blk: {
                break :blk 2;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 4e4;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 8000000;
            const Prediv2Value: ?Prediv2List = blk: {
                const conf_item = config.Prediv2;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSE_PREDIV2_DIV1 => {},
                        .RCC_HSE_PREDIV2_DIV2 => {},
                        .RCC_HSE_PREDIV2_DIV3 => {},
                        .RCC_HSE_PREDIV2_DIV4 => {},
                        .RCC_HSE_PREDIV2_DIV5 => {},
                        .RCC_HSE_PREDIV2_DIV6 => {},
                        .RCC_HSE_PREDIV2_DIV7 => {},
                        .RCC_HSE_PREDIV2_DIV8 => {},
                        .RCC_HSE_PREDIV2_DIV9 => {},
                        .RCC_HSE_PREDIV2_DIV10 => {},
                        .RCC_HSE_PREDIV2_DIV11 => {},
                        .RCC_HSE_PREDIV2_DIV12 => {},
                        .RCC_HSE_PREDIV2_DIV13 => {},
                        .RCC_HSE_PREDIV2_DIV14 => {},
                        .RCC_HSE_PREDIV2_DIV15 => {},
                        .RCC_HSE_PREDIV2_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSE_PREDIV2_DIV1;
            };
            const PLL2MulValue: ?PLL2MulList = blk: {
                const conf_item = config.PLL2Mul;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL2_MUL8 => {},
                        .RCC_PLL2_MUL9 => {},
                        .RCC_PLL2_MUL10 => {},
                        .RCC_PLL2_MUL11 => {},
                        .RCC_PLL2_MUL12 => {},
                        .RCC_PLL2_MUL13 => {},
                        .RCC_PLL2_MUL14 => {},
                        .RCC_PLL2_MUL16 => {},
                        .RCC_PLL2_MUL20 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLL2_MUL8;
            };
            const PLL2VCOMul2Value: ?f32 = blk: {
                break :blk 2;
            };
            const PLL3MulValue: ?PLL3MulList = blk: {
                const conf_item = config.PLL3Mul;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLI2S_MUL8 => {},
                        .RCC_PLLI2S_MUL9 => {},
                        .RCC_PLLI2S_MUL10 => {},
                        .RCC_PLLI2S_MUL11 => {},
                        .RCC_PLLI2S_MUL12 => {},
                        .RCC_PLLI2S_MUL13 => {},
                        .RCC_PLLI2S_MUL14 => {},
                        .RCC_PLLI2S_MUL16 => {},
                        .RCC_PLLI2S_MUL20 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLI2S_MUL8;
            };
            const PLL3VCOMul2Value: ?f32 = blk: {
                break :blk 2;
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
            const I2S2ClockSelectionValue: ?I2S2ClockSelectionList = blk: {
                const conf_item = config.I2S2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2S2CLKSOURCE_SYSCLK => {},
                        .RCC_I2S2CLKSOURCE_PLLI2S_VCO => {},
                    }
                }

                break :blk conf_item orelse .RCC_I2S2CLKSOURCE_SYSCLK;
            };
            const I2S3ClockSelectionValue: ?I2S3ClockSelectionList = blk: {
                const conf_item = config.I2S3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2S3CLKSOURCE_SYSCLK => {},
                        .RCC_I2S3CLKSOURCE_PLLI2S_VCO => {},
                    }
                }

                break :blk conf_item orelse .RCC_I2S3CLKSOURCE_SYSCLK;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 128;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_LSE => {},
                        .RCC_RTCCLKSOURCE_LSI => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_RTCCLKSOURCE_LSI;
            };
            const RCC_MCOMult_Clock_Source_FROM_PLL3MULValue: ?RCC_MCOMult_Clock_Source_FROM_PLL3MULList = blk: {
                const conf_item = config.RCC_MCOMult_Clock_Source_FROM_PLL3MUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_PLL3CLK => {},
                        .RCC_MCO1SOURCE_PLL3CLK_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_PLL3CLK;
            };
            const RCC_MCOMult_Clock_Source_FROM_PLLMULValue: ?f32 = blk: {
                break :blk 2;
            };
            const RCC_MCOSourceValue: ?RCC_MCOSourceList = blk: {
                const conf_item = config.RCC_MCOSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_PLLCLK => {},
                        .RCC_MCO1SOURCE_PLL2CLK => {},
                        .RCC_MCO1SOURCE_EXT_HSE => {},
                        .MCOPLL3Div => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
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
            const TimSys_DivValue: ?TimSys_DivList = blk: {
                const conf_item = config.TimSys_Div;
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
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
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
                if (check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const ADCPrescValue: ?ADCPrescList = blk: {
                const conf_item = config.ADCPresc;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCPCLK2_DIV2 => {},
                        .RCC_ADCPCLK2_DIV4 => {},
                        .RCC_ADCPCLK2_DIV6 => {},
                        .RCC_ADCPCLK2_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADCPCLK2_DIV2;
            };
            const Prediv1SourceValue: ?Prediv1SourceList = blk: {
                const conf_item = config.Prediv1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PREDIV1_SOURCE_PLL2 => {},
                        .RCC_PREDIV1_SOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PREDIV1_SOURCE_HSE;
            };
            const HSEDivPLLValue: ?HSEDivPLLList = blk: {
                const conf_item = config.HSEDivPLL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSE_PREDIV_DIV1 => {},
                        .RCC_HSE_PREDIV_DIV2 => {},
                        .RCC_HSE_PREDIV_DIV3 => {},
                        .RCC_HSE_PREDIV_DIV4 => {},
                        .RCC_HSE_PREDIV_DIV5 => {},
                        .RCC_HSE_PREDIV_DIV6 => {},
                        .RCC_HSE_PREDIV_DIV7 => {},
                        .RCC_HSE_PREDIV_DIV8 => {},
                        .RCC_HSE_PREDIV_DIV9 => {},
                        .RCC_HSE_PREDIV_DIV10 => {},
                        .RCC_HSE_PREDIV_DIV11 => {},
                        .RCC_HSE_PREDIV_DIV12 => {},
                        .RCC_HSE_PREDIV_DIV13 => {},
                        .RCC_HSE_PREDIV_DIV14 => {},
                        .RCC_HSE_PREDIV_DIV15 => {},
                        .RCC_HSE_PREDIV_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSE_PREDIV_DIV1;
            };
            const PLLSourceValue: ?PLLSourceList = blk: {
                if ((config.flags.USB_OTG_FSUsed_ForRCC)) {
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
                            , .{ "PLLSource", "(USB_OTG_FSUsed_ForRCC) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
                        }
                    }
                    break :blk item;
                }
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI_DIV2 => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI_DIV2;
            };
            const PLLMULValue: ?PLLMULList = blk: {
                const conf_item = config.PLLMUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL_MUL4 => {},
                        .RCC_PLL_MUL5 => {},
                        .RCC_PLL_MUL6 => {},
                        .RCC_PLL_MUL6_5 => {},
                        .RCC_PLL_MUL7 => {},
                        .RCC_PLL_MUL8 => {},
                        .RCC_PLL_MUL9 => {},
                    }
                }

                break :blk conf_item orelse null;
            };
            const PLLVCOMul2Value: ?f32 = blk: {
                break :blk 2;
            };
            const USBPrescalerValue: ?USBPrescalerList = blk: {
                const conf_item = config.USBPrescaler;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL_DIV2 => {},
                        .RCC_USBCLKSOURCE_PLL_DIV3 => {},
                    }
                }

                break :blk conf_item orelse .RCC_USBCLKSOURCE_PLL_DIV3;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 2e0) {
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
                            2e0,
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
                if (!check_ref(@TypeOf(AHBCLKDividerValue), AHBCLKDividerValue, .RCC_SYSCLK_DIV1, .@"=")) {
                    const item: PREFETCH_ENABLEList = .@"1";
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
                            , .{ "PREFETCH_ENABLE", "!AHBCLKDivider=RCC_SYSCLK_DIV1", "No Extra Log", "1", i });
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
            const PLLUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCOConfig) or config.flags.USB_OTG_FSUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableLSEValue: ?EnableLSEList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: EnableLSEList = .true;
                    break :blk item;
                }
                const item: EnableLSEList = .false;
                break :blk item;
            };
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const I2S2EnableValue: ?I2S2EnableList = blk: {
                if (!config.flags.I2S2Used_ForRCC) {
                    const item: I2S2EnableList = .false;
                    break :blk item;
                } else if (config.flags.I2S2Used_ForRCC) {
                    const item: I2S2EnableList = .true;
                    break :blk item;
                }
                break :blk null;
            };
            const I2S3EnableValue: ?I2S3EnableList = blk: {
                if (!config.flags.I2S3Used_ForRCC) {
                    const item: I2S3EnableList = .false;
                    break :blk item;
                } else if (config.flags.I2S3Used_ForRCC) {
                    const item: I2S3EnableList = .true;
                    break :blk item;
                }
                break :blk null;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                } else if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
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
            const EnableHSEMCODevisorValue: ?EnableHSEMCODevisorList = blk: {
                if ((config.flags.MCOConfig and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSEMCODevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSEMCODevisorList = .false;
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
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.USE_ADC1 or config.flags.USE_ADC2) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const PLL2UsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(Prediv1SourceValue), Prediv1SourceValue, .RCC_PREDIV1_SOURCE_PLL2, .@"="))) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLL2CLK, .@"=")) and config.flags.MCOConfig)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL3UsedValue: ?f32 = blk: {
                if (((config.flags.I2S2Used_ForRCC and (check_ref(@TypeOf(I2S2ClockSelectionValue), I2S2ClockSelectionValue, .RCC_I2S2CLKSOURCE_PLLI2S_VCO, .@"="))) or (config.flags.I2S3Used_ForRCC and (check_ref(@TypeOf(I2S3ClockSelectionValue), I2S3ClockSelectionValue, .RCC_I2S3CLKSOURCE_PLLI2S_VCO, .@"=")))) or (((false) or (false)) and config.flags.MCOConfig)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.LSEOscillator or config.flags.LSEByPass))) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
                break :blk item;
            };
            const HSEUsedValue: ?f32 = blk: {
                if (((config.flags.I2S2Used_ForRCC and (check_ref(@TypeOf(I2S2ClockSelectionValue), I2S2ClockSelectionValue, .RCC_I2S2CLKSOURCE_PLLI2S_VCO, .@"="))) or (config.flags.I2S3Used_ForRCC and (check_ref(@TypeOf(I2S3ClockSelectionValue), I2S3ClockSelectionValue, .RCC_I2S3CLKSOURCE_PLLI2S_VCO, .@"=")))) or ((config.flags.RTCUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or (((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) or (false) or (false) or (check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLL2CLK, .@"=")) or (check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_EXT_HSE, .@"="))) and config.flags.MCOConfig)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and config.flags.RTCUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and config.flags.RTCUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI_DIV2, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and config.flags.MCOConfig))) {
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
            FLITFCLKoutput.nodetype = .output;
            FLITFCLKoutput.parents = &.{&HSIRC};

            const HSIDivPLL_clk_value = HSIDivPLLValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIDivPLL",
                "Else",
                "No Extra Log",
                "HSIDivPLL",
            });
            HSIDivPLL.nodetype = .div;
            HSIDivPLL.value = HSIDivPLL_clk_value;
            HSIDivPLL.parents = &.{&HSIRC};

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
                                "HSE in bypass Mode",
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
                                "HSE in bypass Mode",
                                5e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 8000000;

                    break :blk null;
                }
                const config_val = config.HSE_VALUE;
                if (config_val) |val| {
                    if (val < 3e6) {
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
                            3e6,
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
                HSEOSC.value = config_val orelse 8000000;

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
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const Prediv2_clk_value = Prediv2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "Prediv2",
                    "Else",
                    "No Extra Log",
                    "Prediv2",
                });
                Prediv2.nodetype = .div;
                Prediv2.value = Prediv2_clk_value.get();
                Prediv2.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                Prediv2output.nodetype = .output;
                Prediv2output.parents = &.{&Prediv2};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const PLL2Mul_clk_value = PLL2MulValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL2Mul",
                    "Else",
                    "No Extra Log",
                    "PLL2Mul",
                });
                PLL2Mul.nodetype = .mul;
                PLL2Mul.value = PLL2Mul_clk_value.get();
                PLL2Mul.parents = &.{&Prediv2output};
            }

            const PLL2VCOMul2_clk_value = PLL2VCOMul2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL2VCOMul2",
                "Else",
                "No Extra Log",
                "PLL2VCOMul2",
            });
            PLL2VCOMul2.nodetype = .mul;
            PLL2VCOMul2.value = PLL2VCOMul2_clk_value;
            PLL2VCOMul2.parents = &.{&PLL2Mul};
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                PLL2VCOoutput.nodetype = .output;
                PLL2VCOoutput.parents = &.{&PLL2VCOMul2};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                PLL2CLKoutput.nodetype = .output;
                PLL2CLKoutput.parents = &.{&PLL2Mul};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const PLL3Mul_clk_value = PLL3MulValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL3Mul",
                    "Else",
                    "No Extra Log",
                    "PLL3Mul",
                });
                PLL3Mul.nodetype = .mul;
                PLL3Mul.value = PLL3Mul_clk_value.get();
                PLL3Mul.parents = &.{&Prediv2output};
            }

            const PLL3VCOMul2_clk_value = PLL3VCOMul2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL3VCOMul2",
                "Else",
                "No Extra Log",
                "PLL3VCOMul2",
            });
            PLL3VCOMul2.nodetype = .mul;
            PLL3VCOMul2.value = PLL3VCOMul2_clk_value;
            PLL3VCOMul2.parents = &.{&PLL3Mul};
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                PLL3VCOoutput.nodetype = .output;
                PLL3VCOoutput.parents = &.{&PLL3VCOMul2};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                PLL3CLKoutput.nodetype = .output;
                PLL3CLKoutput.parents = &.{&PLL3Mul};
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
                &PLLMUL,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            if (check_ref(@TypeOf(I2S2EnableValue), I2S2EnableValue, .true, .@"=")) {
                const I2S2Mult_clk_value = I2S2ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2S2Mult",
                    "Else",
                    "No Extra Log",
                    "I2S2ClockSelection",
                });
                const I2S2Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &PLL3VCOoutput,
                };
                I2S2Mult.nodetype = .multi;
                I2S2Mult.parents = &.{I2S2Multparents[I2S2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2S2EnableValue), I2S2EnableValue, .true, .@"=")) {
                I2S2Output.nodetype = .output;
                I2S2Output.parents = &.{&I2S2Mult};
            }
            if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                const I2S3Mult_clk_value = I2S3ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2S3Mult",
                    "Else",
                    "No Extra Log",
                    "I2S3ClockSelection",
                });
                const I2S3Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &PLL3VCOoutput,
                };
                I2S3Mult.nodetype = .multi;
                I2S3Mult.parents = &.{I2S3Multparents[I2S3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                I2S3Output.nodetype = .output;
                I2S3Output.parents = &.{&I2S3Mult};
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
            if (check_ref(@TypeOf(EnableHSEMCODevisorValue), EnableHSEMCODevisorValue, .true, .@"=")) {
                const MCOPLL3Div_clk_value = RCC_MCOMult_Clock_Source_FROM_PLL3MULValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCOPLL3Div",
                    "Else",
                    "No Extra Log",
                    "RCC_MCOMult_Clock_Source_FROM_PLL3MUL",
                });
                MCOPLL3Div.nodetype = .div;
                MCOPLL3Div.value = MCOPLL3Div_clk_value.get();
                MCOPLL3Div.parents = &.{&PLL3CLKoutput};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCOMultDivisor_clk_value = RCC_MCOMult_Clock_Source_FROM_PLLMULValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCOMultDivisor",
                    "Else",
                    "No Extra Log",
                    "RCC_MCOMult_Clock_Source_FROM_PLLMUL",
                });
                MCOMultDivisor.nodetype = .div;
                MCOMultDivisor.value = MCOMultDivisor_clk_value;
                MCOMultDivisor.parents = &.{&PLLMUL};
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
                    &HSEOSC,
                    &HSIRC,
                    &SysCLKOutput,
                    &MCOMultDivisor,
                    &PLL2CLKoutput,
                    &MCOPLL3Div,
                    &HSEOSC,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                MCOoutput.nodetype = .output;
                MCOoutput.parents = &.{&MCOMult};
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
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};
            FCLKCortexOutput.nodetype = .output;
            FCLKCortexOutput.parents = &.{&AHBOutput};

            const TimSysPresc_clk_value = TimSys_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimSysPresc",
                "Else",
                "No Extra Log",
                "TimSys_Div",
            });
            TimSysPresc.nodetype = .div;
            TimSysPresc.value = TimSysPresc_clk_value.get();
            TimSysPresc.parents = &.{&AHBOutput};
            TimSysOutput.nodetype = .output;
            TimSysOutput.parents = &.{&TimSysPresc};

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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const ADCprescaler_clk_value = ADCPrescValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADCprescaler",
                    "Else",
                    "No Extra Log",
                    "ADCPresc",
                });
                ADCprescaler.nodetype = .div;
                ADCprescaler.value = ADCprescaler_clk_value.get();
                ADCprescaler.parents = &.{&APB2Prescaler};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCprescaler};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const Prediv1Source_clk_value = Prediv1SourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "Prediv1Source",
                    "Else",
                    "No Extra Log",
                    "Prediv1Source",
                });
                const Prediv1Sourceparents = [_]*const ClockNode{
                    &HSEOSC,
                    &PLL2CLKoutput,
                };
                Prediv1Source.nodetype = .multi;
                Prediv1Source.parents = &.{Prediv1Sourceparents[Prediv1Source_clk_value.get()]};
            }
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const PreDiv1_clk_value = HSEDivPLLValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PreDiv1",
                    "Else",
                    "No Extra Log",
                    "HSEDivPLL",
                });
                PreDiv1.nodetype = .div;
                PreDiv1.value = PreDiv1_clk_value.get();
                PreDiv1.parents = &.{&Prediv1Source};
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
                &HSIDivPLL,
                &PreDiv1,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};
            VCO2output.nodetype = .output;
            VCO2output.parents = &.{&PLLSource};

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
            PLLMUL.parents = &.{&VCO2output};

            const PLLVCOMul2_clk_value = PLLVCOMul2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLVCOMul2",
                "Else",
                "No Extra Log",
                "PLLVCOMul2",
            });
            PLLVCOMul2.nodetype = .mul;
            PLLVCOMul2.value = PLLVCOMul2_clk_value;
            PLLVCOMul2.parents = &.{&PLLMUL};
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const USBPrescaler_clk_value = USBPrescalerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USBPrescaler",
                    "Else",
                    "No Extra Log",
                    "USBPrescaler",
                });
                USBPrescaler.nodetype = .div;
                USBPrescaler.value = USBPrescaler_clk_value.get();
                USBPrescaler.parents = &.{&PLLVCOMul2};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBPrescaler};
            }
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLMUL};

            //POST CLOCK REF Prediv2FreqValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=") or check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    Prediv2output.limit = .{
                        .min = 3e6,
                        .max = 5e6,
                    };

                    break :blk null;
                }
                Prediv2output.value = 8000000;
                break :blk null;
            };

            //POST CLOCK REF PLL2VCOoutputFreqValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    PLL2VCOoutput.limit = .{
                        .min = 8e7,
                        .max = 1.48e8,
                    };

                    break :blk null;
                }
                PLL2VCOoutput.value = 128000000;
                break :blk null;
            };

            //POST CLOCK REF PLL2CLKoutputFreqValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL2UsedValue), PLL2UsedValue, 1, .@"=")) {
                    PLL2CLKoutput.limit = .{
                        .min = 4e7,
                        .max = 7.4e7,
                    };

                    break :blk null;
                }
                PLL2CLKoutput.value = 64000000;
                break :blk null;
            };

            //POST CLOCK REF PLL3VCOoutputFreqValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    PLL3VCOoutput.limit = .{
                        .min = 8e7,
                        .max = 1.48e8,
                    };

                    break :blk null;
                }
                PLL3VCOoutput.value = 128000000;
                break :blk null;
            };

            //POST CLOCK REF PLL3CLKoutputFreqValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL3UsedValue), PLL3UsedValue, 1, .@"=")) {
                    PLL3CLKoutput.limit = .{
                        .min = 4e7,
                        .max = 7.4e7,
                    };

                    break :blk null;
                }
                PLL3CLKoutput.value = 64000000;
                break :blk null;
            };

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                if ((!(check_MCU("RCC_RTC_Clock_Source")) and !(check_MCU("RCC_RTC_Clock_Source")))) {
                    RTCOutput.limit = .{
                        .min = null,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                RTCOutput.value = 40000;
                break :blk null;
            };

            //POST CLOCK REF MCOFreq_Value VALUE
            _ = blk: {
                MCOoutput.limit = .{
                    .min = null,
                    .max = 5e7,
                };

                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                if (config.flags.ETHUsed_ForRCC) {
                    AHBOutput.limit = .{
                        .min = 2.5e7,
                        .max = 7.2e7,
                    };

                    break :blk null;
                } else if (config.flags.USB_OTG_FSUsed_ForRCC) {
                    AHBOutput.limit = .{
                        .min = 1.42e7,
                        .max = 7.2e7,
                    };

                    break :blk null;
                }
                AHBOutput.limit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 3.6e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF ADCFreqValue VALUE
            _ = blk: {
                ADCoutput.limit = .{
                    .min = null,
                    .max = 1.4e7,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOOutput2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCO2output.limit = .{
                        .min = 3e6,
                        .max = 1.2e7,
                    };

                    break :blk null;
                }
                VCO2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USBFreq_Value VALUE
            _ = blk: {
                USBoutput.limit = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };

                break :blk null;
            };

            //POST CLOCK REF PLLCLKFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = 1.8e7,
                        .max = 7.2e7,
                    };

                    break :blk null;
                }
                PLLCLK.value = 8000000;
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"<")) or ((check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@"=")))))) {
                    FLASH_LATENCY0 = true;
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (((check_ref(?f32, SysCLKOutput.get_as_ref(), 24000000, .@">")) and ((check_ref(?f32, SysCLKOutput.get_as_ref(), 48000000, .@"<")) or ((check_ref(?f32, SysCLKOutput.get_as_ref(), 48000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_LATENCY_2;
                break :blk item;
            };

            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.TimSysOutput = try TimSysOutput.get_output();
            out.TimSysPresc = try TimSysPresc.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCprescaler = try ADCprescaler.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.I2S2Output = try I2S2Output.get_output();
            out.I2S2Mult = try I2S2Mult.get_output();
            out.I2S3Output = try I2S3Output.get_output();
            out.I2S3Mult = try I2S3Mult.get_output();
            out.MCOoutput = try MCOoutput.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.MCOMultDivisor = try MCOMultDivisor.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.USBPrescaler = try USBPrescaler.get_output();
            out.PLLVCOMul2 = try PLLVCOMul2.get_output();
            out.PLLMUL = try PLLMUL.get_output();
            out.VCO2output = try VCO2output.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.HSIDivPLL = try HSIDivPLL.get_output();
            out.FLITFCLKoutput = try FLITFCLKoutput.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.PreDiv1 = try PreDiv1.get_output();
            out.Prediv1Source = try Prediv1Source.get_output();
            out.PLL2CLKoutput = try PLL2CLKoutput.get_output();
            out.PLL2VCOoutput = try PLL2VCOoutput.get_output();
            out.PLL2VCOMul2 = try PLL2VCOMul2.get_output();
            out.PLL2Mul = try PLL2Mul.get_output();
            out.PLL3VCOoutput = try PLL3VCOoutput.get_output();
            out.PLL3VCOMul2 = try PLL3VCOMul2.get_output();
            out.MCOPLL3Div = try MCOPLL3Div.get_output();
            out.PLL3CLKoutput = try PLL3CLKoutput.get_output();
            out.PLL3Mul = try PLL3Mul.get_output();
            out.Prediv2output = try Prediv2output.get_output();
            out.Prediv2 = try Prediv2.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSIDivPLL = HSIDivPLLValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.Prediv2 = Prediv2Value;
            ref_out.PLL2Mul = PLL2MulValue;
            ref_out.PLL2VCOMul2 = PLL2VCOMul2Value;
            ref_out.PLL3Mul = PLL3MulValue;
            ref_out.PLL3VCOMul2 = PLL3VCOMul2Value;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.I2S2ClockSelection = I2S2ClockSelectionValue;
            ref_out.I2S3ClockSelection = I2S3ClockSelectionValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_MCOMult_Clock_Source_FROM_PLL3MUL = RCC_MCOMult_Clock_Source_FROM_PLL3MULValue;
            ref_out.RCC_MCOMult_Clock_Source_FROM_PLLMUL = RCC_MCOMult_Clock_Source_FROM_PLLMULValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.TimSys_Div = TimSys_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.ADCPresc = ADCPrescValue;
            ref_out.Prediv1Source = Prediv1SourceValue;
            ref_out.HSEDivPLL = HSEDivPLLValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.PLLVCOMul2 = PLLVCOMul2Value;
            ref_out.USBPrescaler = USBPrescalerValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCOConfig = config.flags.MCOConfig;
            ref_out.flags.ETHUsed_ForRCC = config.flags.ETHUsed_ForRCC;
            ref_out.flags.USB_OTG_FSUsed_ForRCC = config.flags.USB_OTG_FSUsed_ForRCC;
            ref_out.flags.I2S2Used_ForRCC = config.flags.I2S2Used_ForRCC;
            ref_out.flags.I2S3Used_ForRCC = config.flags.I2S3Used_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.USE_ADC1 = config.flags.USE_ADC1;
            ref_out.flags.USE_ADC2 = config.flags.USE_ADC2;
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.I2S2Enable = check_ref(?I2S2EnableList, I2S2EnableValue, .true, .@"=");
            ref_out.flags.I2S3Enable = check_ref(?I2S3EnableList, I2S3EnableValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.EnableHSEMCODevisor = check_ref(?EnableHSEMCODevisorList, EnableHSEMCODevisorValue, .true, .@"=");
            ref_out.flags.MCOEnable = check_ref(?MCOEnableList, MCOEnableValue, .true, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.PLL2Used = check_ref(?f32, PLL2UsedValue, 1, .@"=");
            ref_out.flags.PLL3Used = check_ref(?f32, PLL3UsedValue, 1, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.HSEUsed = check_ref(?f32, HSEUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.LSIUsed = check_ref(?f32, LSIUsedValue, 1, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
