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
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_PLLCLK => 0,
            .RCC_MCO1SOURCE_HSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_SYSCLK => 3,
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
pub const HSEDivPLLList = enum {
    RCC_HSE_PREDIV_DIV1,
    RCC_HSE_PREDIV_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSE_PREDIV_DIV1 => 1,
            .RCC_HSE_PREDIV_DIV2 => 2,
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
pub const USBPrescalerList = enum {
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_PLL_DIV1_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL => 1,
            .RCC_USBCLKSOURCE_PLL_DIV1_5 => 1.5,
        };
    }
};
pub const PLLMULList = enum {
    RCC_PLL_MUL2,
    RCC_PLL_MUL3,
    RCC_PLL_MUL4,
    RCC_PLL_MUL5,
    RCC_PLL_MUL6,
    RCC_PLL_MUL7,
    RCC_PLL_MUL8,
    RCC_PLL_MUL9,
    RCC_PLL_MUL10,
    RCC_PLL_MUL11,
    RCC_PLL_MUL12,
    RCC_PLL_MUL13,
    RCC_PLL_MUL14,
    RCC_PLL_MUL15,
    RCC_PLL_MUL16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL_MUL2 => 2,
            .RCC_PLL_MUL3 => 3,
            .RCC_PLL_MUL4 => 4,
            .RCC_PLL_MUL5 => 5,
            .RCC_PLL_MUL6 => 6,
            .RCC_PLL_MUL7 => 7,
            .RCC_PLL_MUL8 => 8,
            .RCC_PLL_MUL9 => 9,
            .RCC_PLL_MUL10 => 10,
            .RCC_PLL_MUL11 => 11,
            .RCC_PLL_MUL12 => 12,
            .RCC_PLL_MUL13 => 13,
            .RCC_PLL_MUL14 => 14,
            .RCC_PLL_MUL15 => 15,
            .RCC_PLL_MUL16 => 16,
        };
    }
};
pub const PREFETCH_ENABLEList = enum {
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
pub const MCOEnableList = enum {
    true,
    false,
};
pub const SDIOEnableList = enum {
    true,
    false,
};
pub const FSMCEnableList = enum {
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
pub const EnableMCOMultDivisorList = enum {
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
            USBUsed_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            SDIOUsed_ForRCC: bool = false,
            FSMCUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            USE_ADC2: bool = false,
            USE_ADC3: bool = false,
            MCOUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
        };
        pub const Config = struct {
            LSE_VALUE: ?f32 = null,
            HSE_VALUE: ?f32 = null,
            HSEDivPLL: ?HSEDivPLLList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            TimSys_Div: ?TimSys_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            ADCPresc: ?ADCPrescList = null,
            USBPrescaler: ?USBPrescalerList = null,
            PLLSource: ?PLLSourceList = null,
            PLLMUL: ?PLLMULList = null,
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
            HSEDivPLL: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            I2S2ClkOutput: f32 = 0,
            I2S3ClkOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            MCOMultDivisor: f32 = 0,
            MCOMult: f32 = 0,
            MCOoutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKDiv2: f32 = 0,
            SDIOHCLKDiv2: f32 = 0,
            HCLKOutput: f32 = 0,
            FSMClkOutput: f32 = 0,
            SDIOClkOutput: f32 = 0,
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
            USBPrescaler: f32 = 0,
            USBoutput: f32 = 0,
            PLLSource: f32 = 0,
            VCO2output: f32 = 0,
            PLLMUL: f32 = 0,
            PLLCLK_MCO: f32 = 0,
            PLLCLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSIDivPLL: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            HSEDivPLL: ?HSEDivPLLList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCOMult_Clock_Source_FROM_PLLMUL: ?f32 = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            HCLKDiv2: ?f32 = null, //from RCC Clock Config
            TimSys_Div: ?TimSys_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            ADCPresc: ?ADCPrescList = null, //from RCC Clock Config
            USBPrescaler: ?USBPrescalerList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            PLLUsed: ?f32 = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            I2S2Enable: ?I2S2EnableList = null, //from extra RCC references
            I2S3Enable: ?I2S3EnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            SDIOEnable: ?SDIOEnableList = null, //from extra RCC references
            FSMCEnable: ?FSMCEnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            EnableMCOMultDivisor: ?EnableMCOMultDivisorList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            HSEUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            LSIUsed: ?f32 = null, //from extra RCC references
            HSIUsed: ?f32 = null, //from extra RCC references
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

            var HCLKDiv1: bool = false;
            var FLASH_LATENCY0: bool = false;
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var MCOFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var ADCFreqValueLimit: Limit = .{};
            var USBFreq_ValueLimit: Limit = .{};
            var VCOOutput2Freq_ValueLimit: Limit = .{};
            var PLLCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const FLITFCLKFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const HSIDivPLLValue: ?f32 = blk: {
                break :blk 2;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 4e4;
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
                                "HSEByPass",
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
                    if (val > 1.6e7) {
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
                            1.6e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 8000000;
            };
            const HSEDivPLLValue: ?HSEDivPLLList = blk: {
                const conf_item = config.HSEDivPLL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSE_PREDIV_DIV1 => {},
                        .RCC_HSE_PREDIV_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSE_PREDIV_DIV1;
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                if (check_MCU("STM32F101")) {
                    SYSCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 3.6e7,
                    };
                    break :blk null;
                } else if (check_MCU("STM32F102")) {
                    SYSCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };
                    break :blk null;
                }
                SYSCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 7.2e7,
                };
                break :blk null;
            };
            const I2S2Freq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const I2S3Freq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
            const RTCFreq_ValueValue: ?f32 = blk: {
                if ((!(check_MCU("RCC_RTC_Clock_Source")) and !(check_MCU("RCC_RTC_Clock_Source")))) {
                    RTCFreq_ValueLimit = .{
                        .min = null,
                        .max = 1e6,
                    };
                    break :blk null;
                }
                break :blk 4e4;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 4e4;
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
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
            };
            const MCOFreq_ValueValue: ?f32 = blk: {
                MCOFreq_ValueLimit = .{
                    .min = null,
                    .max = 5e7,
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
            const HCLKFreq_ValueValue: ?f32 = blk: {
                if (check_MCU("STM32F101")) {
                    HCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 3.6e7,
                    };
                    break :blk null;
                } else if (check_MCU("STM32F102")) {
                    HCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };
                    break :blk null;
                }
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 7.2e7,
                };
                break :blk null;
            };
            const HCLKDiv2Value: ?f32 = blk: {
                break :blk 2;
            };
            const SDIOHCLKDiv2FreqValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const FSMCFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const SDIOFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
            const TimSysFreq_ValueValue: ?f32 = blk: {
                break :blk 1e6;
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
                        .max = 3.6e7,
                    };
                    break :blk null;
                } else if (check_MCU("STM32F101") or check_MCU("STM32F103")) {
                    APB1Freq_ValueLimit = .{
                        .min = null,
                        .max = 3.6e7,
                    };
                    break :blk null;
                }
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 2.4e7,
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
                break :blk 8e6;
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
                if (check_MCU("STM32F101")) {
                    APB2Freq_ValueLimit = .{
                        .min = null,
                        .max = 3.6e7,
                    };
                    break :blk null;
                } else if (check_MCU("STM32F102")) {
                    APB2Freq_ValueLimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };
                    break :blk null;
                }
                APB2Freq_ValueLimit = .{
                    .min = null,
                    .max = 7.2e7,
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
                break :blk 8e6;
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
            const ADCFreqValueValue: ?f32 = blk: {
                ADCFreqValueLimit = .{
                    .min = null,
                    .max = 1.4e7,
                };
                break :blk null;
            };
            const USBPrescalerValue: ?USBPrescalerList = blk: {
                const conf_item = config.USBPrescaler;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_PLL => {},
                        .RCC_USBCLKSOURCE_PLL_DIV1_5 => {},
                    }
                }

                break :blk conf_item orelse .RCC_USBCLKSOURCE_PLL;
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                USBFreq_ValueLimit = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };
                break :blk null;
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
                        .RCC_PLLSOURCE_HSI_DIV2 => {},
                        .RCC_PLLSOURCE_HSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI_DIV2;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLLCLK, .@"=")) and config.flags.MCOConfig) or config.flags.USBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const VCOOutput2Freq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput2Freq_ValueLimit = .{
                        .min = 1e6,
                        .max = 2.5e7,
                    };
                    break :blk null;
                }
                break :blk 4e6;
            };
            const PLLMULValue: ?PLLMULList = blk: {
                const conf_item = config.PLLMUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLL_MUL2 => {},
                        .RCC_PLL_MUL3 => {},
                        .RCC_PLL_MUL4 => {},
                        .RCC_PLL_MUL5 => {},
                        .RCC_PLL_MUL6 => {},
                        .RCC_PLL_MUL7 => {},
                        .RCC_PLL_MUL8 => {},
                        .RCC_PLL_MUL9 => {},
                        .RCC_PLL_MUL10 => {},
                        .RCC_PLL_MUL11 => {},
                        .RCC_PLL_MUL12 => {},
                        .RCC_PLL_MUL13 => {},
                        .RCC_PLL_MUL14 => {},
                        .RCC_PLL_MUL15 => {},
                        .RCC_PLL_MUL16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLL_MUL2;
            };
            const PLLMCOFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const PLLCLKFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") and check_MCU("STM32F102")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 1.6e7,
                        .max = 4.8e7,
                    };
                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") and check_MCU("STM32F101")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 1.6e7,
                        .max = 3.6e7,
                    };
                    break :blk null;
                } else if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=") and check_MCU("STM32F103")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = null,
                        .max = 7.2e7,
                    };
                    break :blk null;
                }
                break :blk 8e6;
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
            const FLatencyValue: ?FLatencyList = blk: {
                if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 0, .@">")) and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@"<")) or ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@"=")))))) {
                    FLASH_LATENCY0 = true;
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 24000000, .@">")) and ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"<")) or ((check_ref(@TypeOf(SYSCLKFreq_VALUEValue), SYSCLKFreq_VALUEValue, 48000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_LATENCY_2;
                break :blk item;
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const SDIOEnableValue: ?SDIOEnableList = blk: {
                if ((config.flags.SDIOUsed_ForRCC)) {
                    const item: SDIOEnableList = .true;
                    break :blk item;
                }
                const item: SDIOEnableList = .false;
                break :blk item;
            };
            const FSMCEnableValue: ?FSMCEnableList = blk: {
                if ((config.flags.FSMCUsed_ForRCC)) {
                    const item: FSMCEnableList = .true;
                    break :blk item;
                }
                const item: FSMCEnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (config.flags.USE_ADC1 or config.flags.USE_ADC2 or config.flags.USE_ADC3) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
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
            const EnableMCOMultDivisorValue: ?EnableMCOMultDivisorList = blk: {
                if (config.flags.MCOUsed_ForRCC) {
                    const item: EnableMCOMultDivisorList = .true;
                    break :blk item;
                }
                const item: EnableMCOMultDivisorList = .false;
                break :blk item;
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
                if (((config.flags.RTCUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and config.flags.MCOConfig)) {
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
                if (((check_MCU("SEM2RCC_LSI_REQUIRED_TIM5") and check_MCU("TIM5") and check_MCU("Semaphore_input_Channel4TIM5")) or config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and config.flags.RTCUsed_ForRCC))) {
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

            var HSEDivPLL = ClockNode{
                .name = "HSEDivPLL",
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

            var I2S2ClkOutput = ClockNode{
                .name = "I2S2ClkOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S3ClkOutput = ClockNode{
                .name = "I2S3ClkOutput",
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

            var HCLKDiv2 = ClockNode{
                .name = "HCLKDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDIOHCLKDiv2 = ClockNode{
                .name = "SDIOHCLKDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var HCLKOutput = ClockNode{
                .name = "HCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var FSMClkOutput = ClockNode{
                .name = "FSMClkOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDIOClkOutput = ClockNode{
                .name = "SDIOClkOutput",
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

            var PLLCLK_MCO = ClockNode{
                .name = "PLLCLK_MCO",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLCLK = ClockNode{
                .name = "PLLCLK",
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

            std.mem.doNotOptimizeAway(FLITFCLKFreq_ValueValue);
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
            if (check_MCU("VFQFPN36")) {
                const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIRC",
                    "VFQFPN36",
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
            if (!check_MCU("VFQFPN36")) {
                if (check_ref(@TypeOf(EnableLSEValue), EnableLSEValue, .true, .@"=")) {
                    const LSEOSC_clk_value = LSE_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSEOSC",
                        "!VFQFPN36",
                        "No Extra Log",
                        "LSE_VALUE",
                    });
                    LSEOSC.nodetype = .source;
                    LSEOSC.value = LSEOSC_clk_value;
                }
            }
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
                const HSEDivPLL_clk_value = HSEDivPLLValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEDivPLL",
                    "Else",
                    "No Extra Log",
                    "HSEDivPLL",
                });
                HSEDivPLL.nodetype = .div;
                HSEDivPLL.value = HSEDivPLL_clk_value.get();
                HSEDivPLL.parents = &.{&HSEOSC};
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

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            if (check_MCU("I2S2_Exist")) {
                if (check_ref(@TypeOf(I2S2EnableValue), I2S2EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(I2S2Freq_ValueValue);
                    I2S2ClkOutput.nodetype = .output;
                    I2S2ClkOutput.parents = &.{&SysCLKOutput};
                }
            }
            if (check_MCU("I2S3_Exist")) {
                if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(I2S3Freq_ValueValue);
                    I2S3ClkOutput.nodetype = .output;
                    I2S3ClkOutput.parents = &.{&SysCLKOutput};
                }
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
            if (check_MCU("VFQFPN36")) {
                if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(RTCFreq_ValueValue);
                    RTCOutput.limit = RTCFreq_ValueLimit;
                    RTCOutput.nodetype = .output;
                    RTCOutput.parents = &.{&RTCClkSource};
                }
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
                    &MCOMultDivisor,
                    &HSIRC,
                    &HSEOSC,
                    &SysCLKOutput,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCOFreq_ValueValue);
                MCOoutput.limit = MCOFreq_ValueLimit;
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

            std.mem.doNotOptimizeAway(HCLKFreq_ValueValue);
            AHBOutput.limit = HCLKFreq_ValueLimit;
            AHBOutput.nodetype = .output;
            AHBOutput.parents = &.{&AHBPrescaler};
            if (check_MCU("SDIO_Exist")) {
                const HCLKDiv2_clk_value = HCLKDiv2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HCLKDiv2",
                    "SDIO_Exist",
                    "No Extra Log",
                    "HCLKDiv2",
                });
                HCLKDiv2.nodetype = .div;
                HCLKDiv2.value = HCLKDiv2_clk_value;
                HCLKDiv2.parents = &.{&AHBOutput};
            }
            if (check_MCU("SDIO_Exist")) {
                if (check_ref(@TypeOf(SDIOEnableValue), SDIOEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SDIOHCLKDiv2FreqValueValue);
                    SDIOHCLKDiv2.nodetype = .output;
                    SDIOHCLKDiv2.parents = &.{&HCLKDiv2};
                }
            }

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};
            if (check_MCU("FSMC_Exist")) {
                if (check_ref(@TypeOf(FSMCEnableValue), FSMCEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(FSMCFreq_ValueValue);
                    FSMClkOutput.nodetype = .output;
                    FSMClkOutput.parents = &.{&AHBOutput};
                }
            }
            if (check_MCU("SDIO_Exist")) {
                if (check_ref(@TypeOf(SDIOEnableValue), SDIOEnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(SDIOFreq_ValueValue);
                    SDIOClkOutput.nodetype = .output;
                    SDIOClkOutput.parents = &.{&AHBOutput};
                }
            }

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
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

            std.mem.doNotOptimizeAway(TimSysFreq_ValueValue);
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
            if (!(check_MCU("STM32F101") and !check_MCU("DIE430") or check_MCU("STM32F102"))) {
                const TimPrescalerAPB2_clk_value = APB2TimCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TimPrescalerAPB2",
                    "!(STM32F101&!DIE430|STM32F102)",
                    "No Extra Log",
                    "APB2TimCLKDivider",
                });
                TimPrescalerAPB2.nodetype = .mul;
                TimPrescalerAPB2.value = TimPrescalerAPB2_clk_value;
                TimPrescalerAPB2.parents = &.{&APB2Prescaler};
            }
            if (!(check_MCU("STM32F101") and !check_MCU("DIE430") or check_MCU("STM32F102"))) {
                std.mem.doNotOptimizeAway(APB2TimFreq_ValueValue);
                TimPrescOut2.nodetype = .output;
                TimPrescOut2.parents = &.{&TimPrescalerAPB2};
            }
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
                std.mem.doNotOptimizeAway(ADCFreqValueValue);
                ADCoutput.limit = ADCFreqValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCprescaler};
            }
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
                USBPrescaler.parents = &.{&PLLMUL};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.limit = USBFreq_ValueLimit;
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBPrescaler};
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
                &HSEDivPLL,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(VCOOutput2Freq_ValueValue);
            VCO2output.limit = VCOOutput2Freq_ValueLimit;
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

            std.mem.doNotOptimizeAway(PLLMCOFreq_ValueValue);
            PLLCLK_MCO.nodetype = .output;
            PLLCLK_MCO.parents = &.{&MCOMultDivisor};

            std.mem.doNotOptimizeAway(PLLCLKFreq_ValueValue);
            PLLCLK.limit = PLLCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLMUL};

            out.USBoutput = try USBoutput.get_output();
            out.USBPrescaler = try USBPrescaler.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.FSMClkOutput = try FSMClkOutput.get_output();
            out.SDIOClkOutput = try SDIOClkOutput.get_output();
            out.SDIOHCLKDiv2 = try SDIOHCLKDiv2.get_output();
            out.HCLKDiv2 = try HCLKDiv2.get_output();
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
            out.I2S2ClkOutput = try I2S2ClkOutput.get_output();
            out.I2S3ClkOutput = try I2S3ClkOutput.get_output();
            out.MCOoutput = try MCOoutput.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.MCOMultDivisor = try MCOMultDivisor.get_output();
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
            out.HSEDivPLL = try HSEDivPLL.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.PLLCLK_MCO = try PLLCLK_MCO.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSIDivPLL = HSIDivPLLValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.HSEDivPLL = HSEDivPLLValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_MCOMult_Clock_Source_FROM_PLLMUL = RCC_MCOMult_Clock_Source_FROM_PLLMULValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.HCLKDiv2 = HCLKDiv2Value;
            ref_out.TimSys_Div = TimSys_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.ADCPresc = ADCPrescValue;
            ref_out.USBPrescaler = USBPrescalerValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.I2S2Enable = I2S2EnableValue;
            ref_out.I2S3Enable = I2S3EnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.SDIOEnable = SDIOEnableValue;
            ref_out.FSMCEnable = FSMCEnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.EnableMCOMultDivisor = EnableMCOMultDivisorValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.HSEUsed = HSEUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.LSIUsed = LSIUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
