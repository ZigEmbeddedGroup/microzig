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
pub const RCC_MCOSourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_MSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLLCLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_MSI => 6,
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
    RCC_PLL_MUL3,
    RCC_PLL_MUL4,
    RCC_PLL_MUL6,
    RCC_PLL_MUL8,
    RCC_PLL_MUL12,
    RCC_PLL_MUL16,
    RCC_PLL_MUL24,
    RCC_PLL_MUL32,
    RCC_PLL_MUL48,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL_MUL3 => 3,
            .RCC_PLL_MUL4 => 4,
            .RCC_PLL_MUL6 => 6,
            .RCC_PLL_MUL8 => 8,
            .RCC_PLL_MUL12 => 12,
            .RCC_PLL_MUL16 => 16,
            .RCC_PLL_MUL24 => 24,
            .RCC_PLL_MUL32 => 32,
            .RCC_PLL_MUL48 => 48,
        };
    }
};
pub const PLLDIVList = enum {
    RCC_PLL_DIV2,
    RCC_PLL_DIV3,
    RCC_PLL_DIV4,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL_DIV2 => 2,
            .RCC_PLL_DIV3 => 3,
            .RCC_PLL_DIV4 => 4,
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
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE2,
    PWR_REGULATOR_VOLTAGE_SCALE3,
};
pub const RTCEnableList = enum {
    true,
    false,
};
pub const LCDEnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
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
pub const IWDGEnableList = enum {
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
pub const SDIOEnableList = enum {
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
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            RTCUsed_ForRCC: bool = false,
            LCDUsed_ForRCC: bool = false,
            USBUsed_ForRCC: bool = false,
            USE_ADC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CSSEnabled: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            MSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
        };
        pub const Config = struct {
            MSIClockRange: ?MSIClockRangeList = null,
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            TimPrescaler: ?TimPrescalerList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            PLLSource: ?PLLSourceList = null,
            PLLMUL: ?PLLMULList = null,
            PLLDIV: ?PLLDIVList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            ADCOutput: f32 = 0,
            MSIRC: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            LCDOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PWROutput: f32 = 0,
            AHBPrescaler: f32 = 0,
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
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            PLLSource: f32 = 0,
            VCOIIuput: f32 = 0,
            PLLMUL: f32 = 0,
            USBPres: f32 = 0,
            PLLDIV: f32 = 0,
            USBOutput: f32 = 0,
            MSI: f32 = 0,
            HSE_RTC: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            TIMCLK: f32 = 0,
        };
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            RTCUsed_ForRCC: bool = false,
            LCDUsed_ForRCC: bool = false,
            USBUsed_ForRCC: bool = false,
            USE_ADC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            CSSEnabled: bool = false,
            RTCEnable: bool = false,
            LCDEnable: bool = false,
            HSIUsed: bool = false,
            PLLUsed: bool = false,
            MSIUsed: bool = false,
            ADCEnable: bool = false,
            EnableHSERTCDevisor: bool = false,
            EnableHSELCDDevisor: bool = false,
            IWDGEnable: bool = false,
            MCOEnable: bool = false,
            USBEnable: bool = false,
            SDIOEnable: bool = false,
            EnableCSSLSE: bool = false,
            EnableHSE: bool = false,
            EnableLSERTC: bool = false,
            EnableLSE: bool = false,
            HSEUsed: bool = false,
            LSEUsed: bool = false,
            LSIUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            MSIClockRange: ?MSIClockRangeList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?RCC_RTC_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            TimPrescaler: ?TimPrescalerList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            DIV2USB: ?f32 = null, //from RCC Clock Config
            PLLDIV: ?PLLDIVList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            MSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
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

            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var HSEscale: bool = false;
            var PLLscale: bool = false;
            var MCOSourcePLL: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var FLASH_LATENCY1: bool = false;
            var scale1: bool = false;
            var scale2: bool = false;
            var scale11: bool = false;
            var scale3: bool = false;
            var NVICusedCssLSE: bool = false;

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

            var ADCOutput = ClockNode{
                .name = "ADCOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var MSIRC = ClockNode{
                .name = "MSIRC",
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

            var PWROutput = ClockNode{
                .name = "PWROutput",
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

            var PLLSource = ClockNode{
                .name = "PLLSource",
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

            var USBPres = ClockNode{
                .name = "USBPres",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDIV = ClockNode{
                .name = "PLLDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBOutput = ClockNode{
                .name = "USBOutput",
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
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
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
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 24000000;
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.7e4;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
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
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11"))) {
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
                                , .{ "RTCClockSelection", "(Semaphore_input_Channel1TIM11 & TIM11 & SEM2RCC_HSE_REQUIRED_TIM11)", "RTC Mux should have HSE as input when TIM11 remap is used", item });
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
            const RCC_MCOSourceValue: ?RCC_MCOSourceList = blk: {
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
            const PLLSourceValue: ?PLLSourceList = blk: {
                if ((config.flags.USBUsed_ForRCC)) {
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
                            , .{ "PLLSource", "(USBUsed_ForRCC) ", "PLL Mux should have HSE as input", "RCC_PLLSOURCE_HSE", i });
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
            const PLLMULValue: ?PLLMULList = blk: {
                const conf_item = config.PLLMUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL_MUL3 => {},
                        .RCC_PLL_MUL4 => {},
                        .RCC_PLL_MUL6 => {},
                        .RCC_PLL_MUL8 => {},
                        .RCC_PLL_MUL12 => {},
                        .RCC_PLL_MUL16 => {},
                        .RCC_PLL_MUL24 => {},
                        .RCC_PLL_MUL32 => {},
                        .RCC_PLL_MUL48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLL_MUL3;
            };
            const DIV2USBValue: ?f32 = blk: {
                break :blk 2;
            };
            const PLLDIVValue: ?PLLDIVList = blk: {
                const conf_item = config.PLLDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL_DIV2 => {},
                        .RCC_PLL_DIV3 => {},
                        .RCC_PLL_DIV4 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLL_DIV2;
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
            var HSICalibrationValueValue: ?f32 = if (config.extra.HSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 16;
            var MSICalibrationValueValue: ?f32 = if (config.extra.MSICalibrationValue) |i| @as(f32, @floatFromInt(i)) else 0;
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
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11")) or config.flags.RTCUsed_ForRCC) {
                    const item: RTCEnableList = .true;
                    break :blk item;
                }
                const item: RTCEnableList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCDUsed_ForRCC) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const PLLUsedValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCOConfig) or config.flags.USBUsed_ForRCC or config.flags.SDIOUsed_ForRCC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if (((check_MCU("HSIusedPLL")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and (config.flags.MCOConfig)) or config.flags.USE_ADC) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const MSIUsedValue: ?f32 = blk: {
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_MSI_REQUIRED_TIM11")) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_MSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_MSI, .@"=")) and config.flags.MCOConfig)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.USE_ADC) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11")) or (config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
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
            const IWDGEnableValue: ?IWDGEnableList = blk: {
                if (config.flags.IWDGUsed_ForRCC) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
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
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USBUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
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
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
                    const conf_item = config.extra.EnableCSSLSE;
                    if (conf_item) |item| {
                        switch (item) {
                            .true => NVICusedCssLSE = true,
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
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11")) or (config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSERTCValue: ?EnableLSERTCList = blk: {
                if ((config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC or (check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11"))) and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
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
                if ((check_MCU("Semaphore_input_Channel1TIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_HSE_REQUIRED_TIM11")) or ((config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and (config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSEUsedValue: ?f32 = blk: {
                if ((check_MCU("Semaphore_TI1_TIM10L1RemapTIM10") and check_MCU("TIM10") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM10")) or ((check_MCU("Semaphore_ClockSourceETRMode2TIM10") or check_MCU("Semaphore_TriggerSourceETRTIM10") or check_MCU("Semaphore_ETRasClearingSourceTIM10")) and !check_MCU("Semaphore_TIM10_ETR_Remap_TGOTIM10") and check_MCU("TIM10") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM10")) or ((check_MCU("Semaphore_ClockSourceETRMode2TIM11") or check_MCU("Semaphore_TriggerSourceETRTIM11") or check_MCU("Semaphore_ETRasClearingSourceTIM11")) and !check_MCU("Semaphore_TIM11_ETR_Remap_TGOTIM11") and check_MCU("TIM11") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM11")) or ((check_MCU("Semaphore_input_Channel1TIM9") and check_MCU("TIM9") and check_MCU("SEM2RCC_LSE_REQUIRED_TIM9")) and (config.flags.LSEByPass or config.flags.LSEOscillator)) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and config.flags.MCOConfig) or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((check_MCU("Semaphore_TI1_TIM10L1RemapTIM10") and check_MCU("TIM10") and check_MCU("SEM2RCC_LSI_REQUIRED_TIM10")) or (config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC)) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSI, .@"=")) and (config.flags.MCOConfig)))) {
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
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCOutput.nodetype = .output;
                ADCOutput.parents = &.{&HSIRC};
            }

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

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@">")))) {
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
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@">")))) {
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
                } else if ((((check_ref(?f32, AHBOutput.get_as_ref(), 4200000, .@">")))) and check_MCU("STM32L162")) {
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
                                , .{ "PWR_Regulator_Voltage_Scale", "(((HCLKFreq_Value > 4200000))) & STM32L162", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        scale1 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE1;
                    };
                } else if ((((check_ref(?f32, AHBOutput.get_as_ref(), 4000000, .@">")))) and !check_MCU("STM32L162")) {
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
                                , .{ "PWR_Regulator_Voltage_Scale", "(((HCLKFreq_Value > 4000000))) & !STM32L162", "No Extra Log", item });
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

            //POST CLOCK REF HSE_VALUE VALUE
            _ = blk: {
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
                    HSEOSC.value = config_val orelse 24000000;

                    break :blk null;
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
                    HSEOSC.value = config_val orelse 24000000;

                    break :blk null;
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
                    HSEOSC.value = config_val orelse 24000000;

                    break :blk null;
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
                    HSEOSC.value = config_val orelse 24000000;

                    break :blk null;
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
                    if (val > 2.4e7) {
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
                            2.4e7,
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
                    "Else",
                    "No Extra Log",
                    "RCC_RTC_Clock_Source_FROM_HSE",
                });
                HSERTCDevisor.nodetype = .div;
                HSERTCDevisor.value = HSERTCDevisor_clk_value.get();
                HSERTCDevisor.parents = &.{&HSEOSC};
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
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")) {
                LCDOutput.nodetype = .output;
                LCDOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIRC};
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
                &HSIRC,
                &HSEOSC,
                &PLLDIV,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            PWROutput.nodetype = .output;
            PWROutput.parents = &.{&SysCLKOutput};

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
            TIMOutput.nodetype = .output;
            TIMOutput.parents = &.{&TIMPrescaler};
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
            PeriphPrescOutput.nodetype = .output;
            PeriphPrescOutput.parents = &.{&PeriphPrescaler};
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
                    &HSIRC,
                    &PLLDIV,
                    &SysCLKOutput,
                    &MSIRC,
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
                &HSIRC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};
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

            const USBPres_clk_value = DIV2USBValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "USBPres",
                "Else",
                "No Extra Log",
                "DIV2USB",
            });
            USBPres.nodetype = .div;
            USBPres.value = USBPres_clk_value;
            USBPres.parents = &.{&PLLMUL};

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
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SDIOEnableValue), SDIOEnableValue, .true, .@"="))
            {
                USBOutput.nodetype = .output;
                USBOutput.parents = &.{&USBPres};
            }
            MSI.nodetype = .output;
            MSI.parents = &.{&MSIRC};
            HSE_RTC.nodetype = .output;
            HSE_RTC.parents = &.{&HSERTCDevisor};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLMUL};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLDIV};

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")))) {
                    RTCOutput.limit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                RTCOutput.value = 37000;
                break :blk null;
            };

            //POST CLOCK REF LCDFreq_Value VALUE
            _ = blk: {
                if ((!(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) and !(check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=")))) {
                    LCDOutput.limit = .{
                        .min = 0e0,
                        .max = 1e6,
                    };

                    break :blk null;
                }
                LCDOutput.value = 37000;
                break :blk null;
            };

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                if (config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC) {
                    const min: ?f32 = RTCOutput.get_as_ref();
                    const max: ?f32 = @min(32000000, std.math.floatMax(f32));
                    SysCLKOutput.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                if ((config.flags.RTCUsed_ForRCC or config.flags.LCDUsed_ForRCC) and !config.flags.USBUsed_ForRCC) {
                    const min: ?f32 = RTCOutput.get_as_ref();
                    const max: ?f32 = @min(32000000, std.math.floatMax(f32));
                    APB1Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value",
                        .max_expr = "null",
                    };
                    break :blk null;
                } else if (config.flags.USBUsed_ForRCC) {
                    APB1Output.limit = .{
                        .min = 1e7,
                        .max = 3.2e7,
                    };

                    break :blk null;
                }
                APB1Output.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOInputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOIIuput.limit = .{
                        .min = 2e6,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                VCOIIuput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF 48MHZClocksFreq_Value VALUE
            _ = blk: {
                USBOutput.limit = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCHSEDivFreq_Value VALUE
            _ = blk: {
                HSE_RTC.limit = .{
                    .min = 0e0,
                    .max = 1e6,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE1, .@"="))) {
                    VCOOutput.limit = .{
                        .min = null,
                        .max = 9.6e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"=")))) {
                    VCOOutput.limit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")))) {
                    VCOOutput.limit = .{
                        .min = null,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                VCOOutput.value = 48000000;
                break :blk null;
            };

            //POST CLOCK REF PLLCLKFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and (check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE1, .@"="))) {
                    PLLCLK.limit = .{
                        .min = 2e6,
                        .max = 3.2e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE2, .@"=")))) {
                    PLLCLK.limit = .{
                        .min = 2e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                } else if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) and ((check_ref(@TypeOf(PWR_Regulator_Voltage_ScaleValue), PWR_Regulator_Voltage_ScaleValue, .PWR_REGULATOR_VOLTAGE_SCALE3, .@"=")))) {
                    PLLCLK.limit = .{
                        .min = 2e6,
                        .max = 4e6,
                    };

                    break :blk null;
                }
                PLLCLK.limit = .{
                    .min = 2e6,
                    .max = null,
                };

                break :blk null;
            };

            //POST CLOCK REF VDD_VALUE VALUE
            _ = blk: {
                if (check_MCU("STM32L100_Value_Line") and !check_MCU("DIE427")) {
                    const config_val = config.extra.VDD_VALUE;
                    if (config_val) |val| {
                        if (val < 1.8e0) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "VDD_VALUE",
                                " STM32L100_Value_Line & !DIE427",
                                "No Extra Log",
                                1.8e0,
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
                                " STM32L100_Value_Line & !DIE427",
                                "No Extra Log",
                                3.6e0,
                                val,
                            });
                        }
                    }
                    VDD_VALUEValue = config_val orelse 3.3;

                    break :blk null;
                } else if ((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@">")) and (!check_MCU("STM32L100_Value_Line") or check_MCU("DIE427"))) {
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
                                "(HCLKFreq_Value > 16000000) & (!STM32L100_Value_Line | DIE427)",
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
                                "(HCLKFreq_Value > 16000000) & (!STM32L100_Value_Line | DIE427)",
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
                VDD_VALUEValue = config_val orelse 3.3;

                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"="))))) and (scale1 or scale11)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (((check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"="))))) and (scale2)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_MCU("DIE416") or check_MCU("STM32L162")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 2100000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 2100000, .@"="))))) and (scale3)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (!(check_MCU("DIE416") or check_MCU("STM32L162")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 4200000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 4200000, .@"="))))) and (scale3)))
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 1.71)|(VDD_VALUE= 1.71)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6 ))) & (   ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value= 16000000 )))) & (scale1|scale11))|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  ((HCLKFreq_Value < 8000000)|(HCLKFreq_Value =8000000 )))) &(scale2) )|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  (DIE416|STM32L162) &((HCLKFreq_Value < 2100000)|(HCLKFreq_Value =2100000 )))) &(scale3) )|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  !(DIE416|STM32L162) &((HCLKFreq_Value < 4200000)|(HCLKFreq_Value =4200000 )))) &(scale3) )ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_0", i });
                        }
                    }
                    break :blk item;
                } else if ((((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.71, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (((check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"="))))) and (scale1 or scale11)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"="))))) and (scale2)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and ((check_MCU("DIE416") or check_MCU("STM32L162")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 4200000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 4200000, .@"="))))) and (scale3)) or
                    (((((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@">")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.65, .@"="))) and ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 3.6, .@"=")))) and (!(check_MCU("DIE416") or check_MCU("STM32L162")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"="))))) and (scale3)))
                {
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
                            , .{ "FLatency", "\r\n\t\t(((((VDD_VALUE > 1.71)|(VDD_VALUE= 1.71)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6 ))) & (   ((HCLKFreq_Value < 32000000)|(HCLKFreq_Value= 32000000 )))) & (scale1|scale11))|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value =16000000 )))) &(scale2) )|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  (DIE416|STM32L162) &((HCLKFreq_Value < 4200000)|(HCLKFreq_Value =4200000 )))) &(scale3) )|\r\n\t\t(((((VDD_VALUE > 1.65)|(VDD_VALUE=1.65)) &  ((VDD_VALUE < 3.6)|(VDD_VALUE = 3.6))) & (  !(DIE416|STM32L162) &((HCLKFreq_Value < 8000000)|(HCLKFreq_Value =8000000 )))) &(scale3) )ªªªªªªªªªªªªªªªª", "No Extra Log", "FLASH_LATENCY_1", i });
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
                        if (val > 31) {
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
                                31,
                                val,
                            });
                        }
                    }
                    HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

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
                HSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;

                break :blk null;
            };

            //POST CLOCK REF MSICalibrationValue VALUE
            _ = blk: {
                if (check_ref(@TypeOf(MSIUsedValue), MSIUsedValue, 1, .@"=")) {
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
                                "MSIUsed=1",
                                "HSI used",
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
                                "MSIUsed=1",
                                "HSI used",
                                255,
                                val,
                            });
                        }
                    }
                    MSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                    break :blk null;
                }
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
                MSICalibrationValueValue = if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;

                break :blk null;
            };

            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.TIMOutput = try TIMOutput.get_output();
            out.TIMPrescaler = try TIMPrescaler.get_output();
            out.TimPrescOut = try TimPrescOut.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.PeriphPrescOutput = try PeriphPrescOutput.get_output();
            out.PeriphPrescaler = try PeriphPrescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.PWROutput = try PWROutput.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.PLLDIV = try PLLDIV.get_output();
            out.USBOutput = try USBOutput.get_output();
            out.USBPres = try USBPres.get_output();
            out.PLLMUL = try PLLMUL.get_output();
            out.VCOIIuput = try VCOIIuput.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.ADCOutput = try ADCOutput.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.MSIRC = try MSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.LCDOutput = try LCDOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.MSI = try MSI.get_extra_output();
            out.HSE_RTC = try HSE_RTC.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.MSIClockRange = MSIClockRangeValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.TimPrescaler = TimPrescalerValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.DIV2USB = DIV2USBValue;
            ref_out.PLLDIV = PLLDIVValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.MSICalibrationValue = MSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCOConfig = config.flags.MCOConfig;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.LCDUsed_ForRCC = config.flags.LCDUsed_ForRCC;
            ref_out.flags.USBUsed_ForRCC = config.flags.USBUsed_ForRCC;
            ref_out.flags.USE_ADC = config.flags.USE_ADC;
            ref_out.flags.SDIOUsed_ForRCC = config.flags.SDIOUsed_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.CSSEnabled = config.flags.CSSEnabled;
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.LCDEnable = check_ref(?LCDEnableList, LCDEnableValue, .true, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.MSIUsed = check_ref(?f32, MSIUsedValue, 1, .@"=");
            ref_out.flags.ADCEnable = check_ref(?ADCEnableList, ADCEnableValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.EnableHSELCDDevisor = check_ref(?EnableHSELCDDevisorList, EnableHSELCDDevisorValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.MCOEnable = check_ref(?MCOEnableList, MCOEnableValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.SDIOEnable = check_ref(?SDIOEnableList, SDIOEnableValue, .true, .@"=");
            ref_out.flags.EnableCSSLSE = check_ref(?EnableCSSLSEList, EnableCSSLSEValue, .true, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.HSEUsed = check_ref(?f32, HSEUsedValue, 1, .@"=");
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.LSIUsed = check_ref(?f32, LSIUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
