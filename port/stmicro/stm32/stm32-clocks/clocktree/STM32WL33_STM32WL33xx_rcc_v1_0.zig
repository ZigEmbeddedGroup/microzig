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

pub const RC64MPLLSourceList = enum {
    RCC_LSCOSOURCE_HSI,
    RCC_LSCOSOURCE_PLL64,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LSCOSOURCE_HSI => 0,
            .RCC_LSCOSOURCE_PLL64 => 1,
        };
    }
};
pub const ROOTClkSourceList = enum {
    RCC_SYSCLKSOURCE_DIRECT_HSE,
    RCC_SYSCLKSOURCE_RC64MPLL,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_DIRECT_HSE => 0,
            .RCC_SYSCLKSOURCE_RC64MPLL => 1,
        };
    }
};
pub const ClkROOTDIVSourceList = enum {
    CLK16MHzDiv2,
    CLK16MHzDiv4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .CLK16MHzDiv2 => 0,
            .CLK16MHzDiv4 => 1,
        };
    }
};
pub const ClkSMPSDIVSourceList = enum {
    RCC_SMPSCLK_DIV4,
    RCC_SMPSCLK_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SMPSCLK_DIV4 => 0,
            .RCC_SMPSCLK_DIV2 => 1,
        };
    }
};
pub const ClkKRMSourceList = enum {
    SMPSDIVCLK,
    CLK_SPMS_KRM,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SMPSDIVCLK => 0,
            .CLK_SPMS_KRM => 1,
        };
    }
};
pub const LPUARTClockSelectionList = enum {
    RCC_LPUART1_CLKSOURCE_LSE,
    RCC_LPUART1_CLKSOURCE_16M,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1_CLKSOURCE_LSE => 0,
            .RCC_LPUART1_CLKSOURCE_16M => 1,
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
pub const CLKSYSMultSourceList = enum {
    ROOTCLK48Prescaler,
    ROOTCLK64Prescaler,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .ROOTCLK48Prescaler => 0,
            .ROOTCLK64Prescaler => 1,
        };
    }
};
pub const CLKSPI3I2SMultSourceList = enum {
    RCC_SPI3I2S_CLKSOURCE_CLK_ROOT_DIV,
    RCC_SPI3I2S_CLKSOURCE_CLK_ROOT,
    RCC_SPI3I2S_CLKSOURCE_CLK_RC64MPLL,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3I2S_CLKSOURCE_CLK_ROOT_DIV => 0,
            .RCC_SPI3I2S_CLKSOURCE_CLK_ROOT => 1,
            .RCC_SPI3I2S_CLKSOURCE_CLK_RC64MPLL => 2,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_DIV512,
    RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSE,
    RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_DIV512 => 0,
            .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSE => 1,
            .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSI => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCOSOURCE_ADC,
    RCC_MCOSOURCE_SMPS,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_HSE,
    RCC_MCOSOURCE_RC64MPLL,
    RCC_MCOSOURCE_HSI64M_DIV2048,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCOSOURCE_ADC => 0,
            .RCC_MCOSOURCE_SMPS => 1,
            .RCC_MCO1SOURCE_SYSCLK => 2,
            .RCC_MCO1SOURCE_HSE => 3,
            .RCC_MCOSOURCE_RC64MPLL => 4,
            .RCC_MCOSOURCE_HSI64M_DIV2048 => 5,
        };
    }
};
pub const HSE_VALUEList = enum {
    @"48000000",
    @"50000000",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"48000000" => 48000000,
            .@"50000000" => 50000000,
        };
    }
};
pub const CLK_SPMS_KRM_DIVList = enum {
    @"8",
    @"9",
    @"10",
    @"11",
    @"12",
    @"13",
    @"14",
    @"15",
    @"16",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"8" => 8,
            .@"9" => 9,
            .@"10" => 10,
            .@"11" => 11,
            .@"12" => 12,
            .@"13" => 13,
            .@"14" => 14,
            .@"15" => 15,
            .@"16" => 16,
        };
    }
};
pub const SYSCLK48DividerList = enum {
    RCC_DIRECT_HSE_DIV1,
    RCC_DIRECT_HSE_DIV2,
    RCC_DIRECT_HSE_DIV3,
    RCC_DIRECT_HSE_DIV6,
    RCC_DIRECT_HSE_DIV12,
    RCC_DIRECT_HSE_DIV24,
    RCC_DIRECT_HSE_DIV48,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_DIRECT_HSE_DIV1 => 1,
            .RCC_DIRECT_HSE_DIV2 => 2,
            .RCC_DIRECT_HSE_DIV3 => 3,
            .RCC_DIRECT_HSE_DIV6 => 6,
            .RCC_DIRECT_HSE_DIV12 => 12,
            .RCC_DIRECT_HSE_DIV24 => 24,
            .RCC_DIRECT_HSE_DIV48 => 48,
        };
    }
};
pub const SYSCLK64DividerList = enum {
    RCC_RC64MPLL_DIV1,
    RCC_RC64MPLL_DIV2,
    RCC_RC64MPLL_DIV4,
    RCC_RC64MPLL_DIV8,
    RCC_RC64MPLL_DIV16,
    RCC_RC64MPLL_DIV32,
    RCC_RC64MPLL_DIV64,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_RC64MPLL_DIV1 => 1,
            .RCC_RC64MPLL_DIV2 => 2,
            .RCC_RC64MPLL_DIV4 => 4,
            .RCC_RC64MPLL_DIV8 => 8,
            .RCC_RC64MPLL_DIV16 => 16,
            .RCC_RC64MPLL_DIV32 => 32,
            .RCC_RC64MPLL_DIV64 => 64,
        };
    }
};
pub const RCC_MCODivList = enum {
    RCC_MCODIV_1,
    RCC_MCODIV_2,
    RCC_MCODIV_4,
    RCC_MCODIV_8,
    RCC_MCODIV_16,
    RCC_MCODIV_32,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_16 => 16,
            .RCC_MCODIV_32 => 32,
        };
    }
};
pub const INSTRUCTION_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const FLatencyList = enum {
    FLASH_WAIT_STATES_0,
    FLASH_WAIT_STATES_1,
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const SysSourceHSEEnableList = enum {
    true,
    false,
};
pub const SYSCLK64EnableList = enum {
    true,
    false,
};
pub const SPI3EnableList = enum {
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
pub const MRSUBGEnableList = enum {
    true,
    false,
};
pub const LPAWUREnableList = enum {
    true,
    false,
};
pub const LCDEnableList = enum {
    true,
    false,
};
pub const LCSCEnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            MR_BLE_Used: bool = false,
            ADC_Used: bool = false,
            LCSC_Used: bool = false,
            LCD_Used: bool = false,
            LPAWUR_Used: bool = false,
            LPUART1_Used: bool = false,
            SPI3_Used: bool = false,
            I2S3_Used: bool = false,
            MRSUBG_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_current_control: ?u32 = null,
            HSE_Capacitor_Tuning: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?HSE_VALUEList = null,
            LSE_VALUE: ?f32 = null,
            RC64MPLLSource: ?RC64MPLLSourceList = null,
            ROOTClkSource: ?ROOTClkSourceList = null,
            ClkROOTDIVSource: ?ClkROOTDIVSourceList = null,
            ClkSMPSDIVSource: ?ClkSMPSDIVSourceList = null,
            CLK_SPMS_KRM_DIV: ?CLK_SPMS_KRM_DIVList = null,
            ClkKRMSource: ?ClkKRMSourceList = null,
            LPUARTClockSelection: ?LPUARTClockSelectionList = null,
            LSCOSource1: ?LSCOSource1List = null,
            SYSCLK48Divider: ?SYSCLK48DividerList = null,
            SYSCLK64Divider: ?SYSCLK64DividerList = null,
            CLKSYSMultSource: ?CLKSYSMultSourceList = null,
            CLKSPI3I2SMultSource: ?CLKSPI3I2SMultSourceList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            PLL64RC: f32 = 0,
            HSEOSC: f32 = 0,
            LSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            RC64MPLL: f32 = 0,
            ROOTClkSource: f32 = 0,
            ROOTCLKOutput: f32 = 0,
            TimerOutput: f32 = 0,
            CLK_ROOT_DIV3: f32 = 0,
            CLK_ROOT_DIV4: f32 = 0,
            CLKROOTDIVSource: f32 = 0,
            ClkROOTDIVOutput: f32 = 0,
            ClkSMPSDiv4: f32 = 0,
            ClkSMPSDiv2: f32 = 0,
            ClkSMPSDIV: f32 = 0,
            CLK_SPMS_KRM_DIV: f32 = 0,
            ClkKRM: f32 = 0,
            ClkSMPSOutput: f32 = 0,
            LPUARTMult: f32 = 0,
            ClkLPUARTOutput: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            Div2: f32 = 0,
            ROOTCLK48Prescaler: f32 = 0,
            ROOTCLK64Prescaler: f32 = 0,
            CLKSYSMult: f32 = 0,
            CLKSYSOutput: f32 = 0,
            CLKSPI3I2SMult: f32 = 0,
            CLKSPI3I2SOutput: f32 = 0,
            CLKROOTCDevisorON512: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSE_VALUE: ?HSE_VALUEList = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            RC64MPLLSource: ?RC64MPLLSourceList = null, //from RCC Clock Config
            ROOTClkSource: ?ROOTClkSourceList = null, //from RCC Clock Config
            ClkROOTDIV_Div3: ?f32 = null, //from RCC Clock Config
            ClkROOTDIV_Div4: ?f32 = null, //from RCC Clock Config
            ClkROOTDIVSource: ?ClkROOTDIVSourceList = null, //from RCC Clock Config
            CLK_SMPS_Div4: ?f32 = null, //from RCC Clock Config
            CLK_SMPS_Div2: ?f32 = null, //from RCC Clock Config
            ClkSMPSDIVSource: ?ClkSMPSDIVSourceList = null, //from RCC Clock Config
            CLK_SPMS_KRM_DIV: ?CLK_SPMS_KRM_DIVList = null, //from RCC Clock Config
            ClkKRMSource: ?ClkKRMSourceList = null, //from RCC Clock Config
            LPUARTClockSelection: ?LPUARTClockSelectionList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            Div2: ?f32 = null, //from RCC Clock Config
            SYSCLK48Divider: ?SYSCLK48DividerList = null, //from RCC Clock Config
            SYSCLK64Divider: ?SYSCLK64DividerList = null, //from RCC Clock Config
            CLKSYSMultSource: ?CLKSYSMultSourceList = null, //from RCC Clock Config
            CLKSPI3I2SMultSource: ?CLKSPI3I2SMultSourceList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIV: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_current_control: ?f32 = null, //from RCC Advanced Config
            HSE_Capacitor_Tuning: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            SysSourceHSEEnable: ?SysSourceHSEEnableList = null, //from extra RCC references
            SYSCLK64Enable: ?SYSCLK64EnableList = null, //from extra RCC references
            SPI3Enable: ?SPI3EnableList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            MRSUBGEnable: ?MRSUBGEnableList = null, //from extra RCC references
            LPAWUREnable: ?LPAWUREnableList = null, //from extra RCC references
            LCDEnable: ?LCDEnableList = null, //from extra RCC references
            LCSCEnable: ?LCSCEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
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

            var RCCLSCOSOURCEHSI: bool = false;
            var RCCLSCOSOURCEPLL64: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourceRC64: bool = false;
            var SysSourceMSI: bool = false;
            var SysSourceHSI: bool = false;
            var RCCSMPSCLKDIV4: bool = false;
            var RCCSMPSCLKDIV2: bool = false;
            var SMPSDIVCLK: bool = false;
            var CLKSPMSKRM: bool = false;
            var LPUART1CLKSOURCELSE: bool = false;
            var LPUART1CLKSOURCE16M: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var SYSCLKPrescaler48: bool = false;
            var SYSCLKPrescaler64: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_32M: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_16M: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_64M: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var MCOSourceADC: bool = false;
            var MCOSourceSMPS: bool = false;
            var MCOSourceSYSCLK: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceRC64MPLL: bool = false;
            var MCOSourceCLK16: bool = false;
            var SysCLKFreq_VALUELimit: Limit = .{};
            var ClkROOTDIVFreq_VALUELimit: Limit = .{};
            var ClkSMPSFreq_VALUELimit: Limit = .{};
            var LPUARTFreq_VALUELimit: Limit = .{};
            var CLKSYSFreq_VALUELimit: Limit = .{};
            var CLKSPI3I2SFreq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 64000000;
            };
            const PLL64_VALUEValue: ?f32 = blk: {
                break :blk 64000000;
            };
            const HSE_VALUEValue: ?HSE_VALUEList = blk: {
                const conf_item = config.HSE_VALUE;
                if (conf_item) |item| {
                    switch (item) {
                        .@"48000000" => {},
                        .@"50000000" => {},
                    }
                }

                break :blk conf_item orelse .@"48000000";
            };
            const LSE_VALUEValue: ?f32 = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass)) {
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
                                "(LSEOscillator|LSEByPass)",
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
                    if (val < 1e3) {
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
                            1e3,
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
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 32000;
            };
            const RC64MPLLSourceValue: ?RC64MPLLSourceList = blk: {
                const conf_item = config.RC64MPLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_HSI => RCCLSCOSOURCEHSI = true,
                        .RCC_LSCOSOURCE_PLL64 => RCCLSCOSOURCEPLL64 = true,
                    }
                }

                break :blk conf_item orelse .RCC_LSCOSOURCE_HSI;
            };
            const ROOTClkSourceValue: ?ROOTClkSourceList = blk: {
                const conf_item = config.ROOTClkSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_DIRECT_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_RC64MPLL => SysSourceRC64 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLKSOURCE_RC64MPLL;
            };
            const SysCLKFreq_VALUEValue: ?f32 = blk: {
                SysCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const ClkROOTDIV_Div3Value: ?f32 = blk: {
                break :blk 3;
            };
            const ClkROOTDIV_Div4Value: ?f32 = blk: {
                break :blk 4;
            };
            const ClkROOTDIVSourceValue: ?ClkROOTDIVSourceList = blk: {
                const conf_item = config.ClkROOTDIVSource;
                if (conf_item) |item| {
                    switch (item) {
                        .CLK16MHzDiv2 => SysSourceMSI = true,
                        .CLK16MHzDiv4 => SysSourceHSI = true,
                    }
                }

                break :blk conf_item orelse .CLK16MHzDiv4;
            };
            const ClkROOTDIVFreq_VALUEValue: ?f32 = blk: {
                ClkROOTDIVFreq_VALUELimit = .{
                    .min = 1.2e7,
                    .max = 3.2e7,
                };
                break :blk null;
            };
            const CLK_SMPS_Div4Value: ?f32 = blk: {
                break :blk 4;
            };
            const CLK_SMPS_Div2Value: ?f32 = blk: {
                break :blk 2;
            };
            const ClkSMPSDIVSourceValue: ?ClkSMPSDIVSourceList = blk: {
                const conf_item = config.ClkSMPSDIVSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SMPSCLK_DIV4 => RCCSMPSCLKDIV4 = true,
                        .RCC_SMPSCLK_DIV2 => RCCSMPSCLKDIV2 = true,
                    }
                }

                break :blk conf_item orelse .RCC_SMPSCLK_DIV2;
            };
            const CLK_SPMS_KRM_DIVValue: ?CLK_SPMS_KRM_DIVList = blk: {
                const conf_item = config.CLK_SPMS_KRM_DIV;
                if (conf_item) |item| {
                    switch (item) {
                        .@"8" => {},
                        .@"9" => {},
                        .@"10" => {},
                        .@"11" => {},
                        .@"12" => {},
                        .@"13" => {},
                        .@"14" => {},
                        .@"15" => {},
                        .@"16" => {},
                    }
                }

                break :blk conf_item orelse .@"8";
            };
            const ClkKRMSourceValue: ?ClkKRMSourceList = blk: {
                const conf_item = config.ClkKRMSource;
                if (conf_item) |item| {
                    switch (item) {
                        .SMPSDIVCLK => SMPSDIVCLK = true,
                        .CLK_SPMS_KRM => CLKSPMSKRM = true,
                    }
                }

                break :blk conf_item orelse .SMPSDIVCLK;
            };
            const ClkSMPSFreq_VALUEValue: ?f32 = blk: {
                ClkSMPSFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const LPUARTClockSelectionValue: ?LPUARTClockSelectionList = blk: {
                const conf_item = config.LPUARTClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1_CLKSOURCE_LSE => LPUART1CLKSOURCELSE = true,
                        .RCC_LPUART1_CLKSOURCE_16M => LPUART1CLKSOURCE16M = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1_CLKSOURCE_16M;
            };
            const LPUARTFreq_VALUEValue: ?f32 = blk: {
                LPUARTFreq_VALUELimit = .{
                    .min = null,
                    .max = 3.2e7,
                };
                break :blk null;
            };
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                const conf_item = config.LSCOSource1;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_LSI => LSCOSSourceLSI = true,
                        .RCC_LSCOSOURCE_LSE => LSCOSSourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LSCOSOURCE_LSI;
            };
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const Div2Value: ?f32 = blk: {
                break :blk 2;
            };
            const SYSCLK48DividerValue: ?SYSCLK48DividerList = blk: {
                const conf_item = config.SYSCLK48Divider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DIRECT_HSE_DIV1 => {},
                        .RCC_DIRECT_HSE_DIV2 => {},
                        .RCC_DIRECT_HSE_DIV3 => {},
                        .RCC_DIRECT_HSE_DIV6 => {},
                        .RCC_DIRECT_HSE_DIV12 => {},
                        .RCC_DIRECT_HSE_DIV24 => {},
                        .RCC_DIRECT_HSE_DIV48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_DIRECT_HSE_DIV1;
            };
            const SYSCLK64DividerValue: ?SYSCLK64DividerList = blk: {
                const conf_item = config.SYSCLK64Divider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RC64MPLL_DIV1 => {},
                        .RCC_RC64MPLL_DIV2 => {},
                        .RCC_RC64MPLL_DIV4 => {},
                        .RCC_RC64MPLL_DIV8 => {},
                        .RCC_RC64MPLL_DIV16 => {},
                        .RCC_RC64MPLL_DIV32 => {},
                        .RCC_RC64MPLL_DIV64 => {},
                    }
                }

                break :blk conf_item orelse .RCC_RC64MPLL_DIV1;
            };
            const CLKSYSMultSourceValue: ?CLKSYSMultSourceList = blk: {
                const conf_item = config.CLKSYSMultSource;
                if (conf_item) |item| {
                    switch (item) {
                        .ROOTCLK48Prescaler => SYSCLKPrescaler48 = true,
                        .ROOTCLK64Prescaler => SYSCLKPrescaler64 = true,
                    }
                }

                break :blk conf_item orelse .ROOTCLK64Prescaler;
            };
            const CLKSYSFreq_VALUEValue: ?f32 = blk: {
                if (config.flags.MR_BLE_Used and check_MCU("RFCLK16M")) {
                    CLKSYSFreq_VALUELimit = .{
                        .min = 1.6e7,
                        .max = 6.4e7,
                    };
                    break :blk null;
                } else if (config.flags.MR_BLE_Used and check_MCU("RFCLK32M")) {
                    CLKSYSFreq_VALUELimit = .{
                        .min = 3.2e7,
                        .max = 6.4e7,
                    };
                    break :blk null;
                } else if (config.flags.ADC_Used) {
                    CLKSYSFreq_VALUELimit = .{
                        .min = 8e6,
                        .max = 6.4e7,
                    };
                    break :blk null;
                }
                CLKSYSFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const CLKSPI3I2SMultSourceValue: ?CLKSPI3I2SMultSourceList = blk: {
                const conf_item = config.CLKSPI3I2SMultSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3I2S_CLKSOURCE_CLK_ROOT => RCC_SPI3I2S_CLKSOURCE_32M = true,
                        .RCC_SPI3I2S_CLKSOURCE_CLK_ROOT_DIV => RCC_SPI3I2S_CLKSOURCE_16M = true,
                        .RCC_SPI3I2S_CLKSOURCE_CLK_RC64MPLL => RCC_SPI3I2S_CLKSOURCE_64M = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI3I2S_CLKSOURCE_CLK_RC64MPLL;
            };
            const CLKSPI3I2SFreq_VALUEValue: ?f32 = blk: {
                CLKSPI3I2SFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIVValue: ?f32 = blk: {
                break :blk 512;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_DIV512 => RTCSourceHSE = true,
                        .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSI => RTCSourceLSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_RTC_WDG_SUBG_LPAWUR_LCD_LCSC_CLKSOURCE_LSI;
            };
            const RTCFreq_ValueValue: ?f32 = blk: {
                RTCFreq_ValueLimit = .{
                    .min = 0e0,
                    .max = 1e6,
                };
                break :blk null;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCOSOURCE_ADC => MCOSourceADC = true,
                        .RCC_MCOSOURCE_SMPS => MCOSourceSMPS = true,
                        .RCC_MCO1SOURCE_SYSCLK => MCOSourceSYSCLK = true,
                        .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                        .RCC_MCOSOURCE_RC64MPLL => MCOSourceRC64MPLL = true,
                        .RCC_MCOSOURCE_HSI64M_DIV2048 => MCOSourceCLK16 = true,
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
                        .RCC_MCODIV_32 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4000000;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                const config_val = config.extra.VDD_VALUE;
                if (config_val) |val| {
                    if (val < 1.65e0) {
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
                            1.65e0,
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
            const FLatencyValue: ?FLatencyList = blk: {
                if ((check_ref(@TypeOf(SysCLKFreq_VALUEValue), SysCLKFreq_VALUEValue, 32000000, .@"="))) {
                    const item: FLatencyList = .FLASH_WAIT_STATES_0;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_WAIT_STATES_1;
                break :blk item;
            };
            const PREFETCH_ENABLEValue: ?PREFETCH_ENABLEList = blk: {
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
            const HSIUsedValue: ?f32 = blk: {
                if ((RCCLSCOSOURCEHSI)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(HSIUsedValue), HSIUsedValue, 1, .@"=")) {
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
                                "HSIUsed=1",
                                "HSI used",
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
                                "HSICalibrationValue",
                                "HSIUsed=1",
                                "HSI used",
                                31,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
                }
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
                    if (val > 31) {
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
                            31,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const HSE_current_controlValue: ?f32 = blk: {
                if (config.flags.HSEOscillator) {
                    const config_val = config.extra.HSE_current_control;
                    if (config_val) |val| {
                        if (val < 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_current_control",
                                "HSEOscillator",
                                "HSE used",
                                0,
                                val,
                            });
                        }
                        if (val > 40) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_current_control",
                                "HSEOscillator",
                                "HSE used",
                                40,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 40;
                }
                const config_val = config.extra.HSE_current_control;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_current_control",
                            "Else",
                            "No Extra Log",
                            0,
                            val,
                        });
                    }
                    if (val > 40) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_current_control",
                            "Else",
                            "No Extra Log",
                            40,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 40;
            };
            const HSE_Capacitor_TuningValue: ?f32 = blk: {
                if (config.flags.HSEOscillator) {
                    const config_val = config.extra.HSE_Capacitor_Tuning;
                    if (config_val) |val| {
                        if (val < 0) {
                            try comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Underflow Value - min: {d} found: {d}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_Capacitor_Tuning",
                                "HSEOscillator",
                                "HSE used",
                                0,
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
                                "HSE_Capacitor_Tuning",
                                "HSEOscillator",
                                "HSE used",
                                63,
                                val,
                            });
                        }
                    }
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 32;
                }
                const config_val = config.extra.HSE_Capacitor_Tuning;
                if (config_val) |val| {
                    if (val < 0) {
                        try comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_Capacitor_Tuning",
                            "Else",
                            "No Extra Log",
                            0,
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
                            "HSE_Capacitor_Tuning",
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
            const LSE_Drive_CapabilityValue: ?LSE_Drive_CapabilityList = blk: {
                if (config.flags.LSEOscillator or config.flags.LSEByPass) {
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if (config.flags.HSEOscillator) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUART1_Used) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
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
            const SysSourceHSEEnableValue: ?SysSourceHSEEnableList = blk: {
                if (SysSourceHSE) {
                    const item: SysSourceHSEEnableList = .true;
                    break :blk item;
                }
                const item: SysSourceHSEEnableList = .false;
                break :blk item;
            };
            const SYSCLK64EnableValue: ?SYSCLK64EnableList = blk: {
                if (SysSourceRC64) {
                    const item: SYSCLK64EnableList = .true;
                    break :blk item;
                }
                const item: SYSCLK64EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3_Used or config.flags.I2S3_Used) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
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
            const MRSUBGEnableValue: ?MRSUBGEnableList = blk: {
                if (config.flags.MRSUBG_Used) {
                    const item: MRSUBGEnableList = .true;
                    break :blk item;
                }
                const item: MRSUBGEnableList = .false;
                break :blk item;
            };
            const LPAWUREnableValue: ?LPAWUREnableList = blk: {
                if (config.flags.LPAWUR_Used) {
                    const item: LPAWUREnableList = .true;
                    break :blk item;
                }
                const item: LPAWUREnableList = .false;
                break :blk item;
            };
            const LCDEnableValue: ?LCDEnableList = blk: {
                if (config.flags.LCD_Used) {
                    const item: LCDEnableList = .true;
                    break :blk item;
                }
                const item: LCDEnableList = .false;
                break :blk item;
            };
            const LCSCEnableValue: ?LCSCEnableList = blk: {
                if (config.flags.LCSC_Used) {
                    const item: LCSCEnableList = .true;
                    break :blk item;
                }
                const item: LCSCEnableList = .false;
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

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL64RC = ClockNode{
                .name = "PLL64RC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEOSC = ClockNode{
                .name = "HSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSEOSC = ClockNode{
                .name = "LSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIRC = ClockNode{
                .name = "LSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var RC64MPLL = ClockNode{
                .name = "RC64MPLL",
                .nodetype = .off,
                .parents = &.{},
            };

            var ROOTClkSource = ClockNode{
                .name = "ROOTClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var ROOTCLKOutput = ClockNode{
                .name = "ROOTCLKOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimerOutput = ClockNode{
                .name = "TimerOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK_ROOT_DIV3 = ClockNode{
                .name = "CLK_ROOT_DIV3",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK_ROOT_DIV4 = ClockNode{
                .name = "CLK_ROOT_DIV4",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKROOTDIVSource = ClockNode{
                .name = "CLKROOTDIVSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkROOTDIVOutput = ClockNode{
                .name = "ClkROOTDIVOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkSMPSDiv4 = ClockNode{
                .name = "ClkSMPSDiv4",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkSMPSDiv2 = ClockNode{
                .name = "ClkSMPSDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkSMPSDIV = ClockNode{
                .name = "ClkSMPSDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK_SPMS_KRM_DIV = ClockNode{
                .name = "CLK_SPMS_KRM_DIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkKRM = ClockNode{
                .name = "ClkKRM",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkSMPSOutput = ClockNode{
                .name = "ClkSMPSOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUARTMult = ClockNode{
                .name = "LPUARTMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ClkLPUARTOutput = ClockNode{
                .name = "ClkLPUARTOutput",
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

            var Div2 = ClockNode{
                .name = "Div2",
                .nodetype = .off,
                .parents = &.{},
            };

            var ROOTCLK48Prescaler = ClockNode{
                .name = "ROOTCLK48Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var ROOTCLK64Prescaler = ClockNode{
                .name = "ROOTCLK64Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKSYSMult = ClockNode{
                .name = "CLKSYSMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKSYSOutput = ClockNode{
                .name = "CLKSYSOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKSPI3I2SMult = ClockNode{
                .name = "CLKSPI3I2SMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKSPI3I2SOutput = ClockNode{
                .name = "CLKSPI3I2SOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKROOTCDevisorON512 = ClockNode{
                .name = "CLKROOTCDevisorON512",
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
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const PLL64RC_clk_value = PLL64_VALUEValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL64RC",
                    "Else",
                    "No Extra Log",
                    "PLL64_VALUE",
                });
                PLL64RC.nodetype = .source;
                PLL64RC.value = PLL64RC_clk_value;
            }

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
            HSEOSC.value = HSEOSC_clk_value.get();

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

            const RC64MPLL_clk_value = RC64MPLLSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "RC64MPLL",
                "Else",
                "No Extra Log",
                "RC64MPLLSource",
            });
            const RC64MPLLparents = [_]*const ClockNode{
                &HSIRC,
                &PLL64RC,
            };
            RC64MPLL.nodetype = .multi;
            RC64MPLL.parents = &.{RC64MPLLparents[RC64MPLL_clk_value.get()]};

            const ROOTClkSource_clk_value = ROOTClkSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ROOTClkSource",
                "Else",
                "No Extra Log",
                "ROOTClkSource",
            });
            const ROOTClkSourceparents = [_]*const ClockNode{
                &HSEOSC,
                &RC64MPLL,
            };
            ROOTClkSource.nodetype = .multi;
            ROOTClkSource.parents = &.{ROOTClkSourceparents[ROOTClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SysCLKFreq_VALUEValue);
            ROOTCLKOutput.limit = SysCLKFreq_VALUELimit;
            ROOTCLKOutput.nodetype = .output;
            ROOTCLKOutput.parents = &.{&ROOTClkSource};

            std.mem.doNotOptimizeAway(SysCLKFreq_VALUEValue);
            TimerOutput.limit = SysCLKFreq_VALUELimit;
            TimerOutput.nodetype = .output;
            TimerOutput.parents = &.{&ROOTCLKOutput};

            const CLK_ROOT_DIV3_clk_value = ClkROOTDIV_Div3Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK_ROOT_DIV3",
                "Else",
                "No Extra Log",
                "ClkROOTDIV_Div3",
            });
            CLK_ROOT_DIV3.nodetype = .div;
            CLK_ROOT_DIV3.value = CLK_ROOT_DIV3_clk_value;
            CLK_ROOT_DIV3.parents = &.{&ROOTCLKOutput};

            const CLK_ROOT_DIV4_clk_value = ClkROOTDIV_Div4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK_ROOT_DIV4",
                "Else",
                "No Extra Log",
                "ClkROOTDIV_Div4",
            });
            CLK_ROOT_DIV4.nodetype = .div;
            CLK_ROOT_DIV4.value = CLK_ROOT_DIV4_clk_value;
            CLK_ROOT_DIV4.parents = &.{&ROOTCLKOutput};

            const CLKROOTDIVSource_clk_value = ClkROOTDIVSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLKROOTDIVSource",
                "Else",
                "No Extra Log",
                "ClkROOTDIVSource",
            });
            const CLKROOTDIVSourceparents = [_]*const ClockNode{
                &CLK_ROOT_DIV3,
                &CLK_ROOT_DIV4,
            };
            CLKROOTDIVSource.nodetype = .multi;
            CLKROOTDIVSource.parents = &.{CLKROOTDIVSourceparents[CLKROOTDIVSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(ClkROOTDIVFreq_VALUEValue);
            ClkROOTDIVOutput.limit = ClkROOTDIVFreq_VALUELimit;
            ClkROOTDIVOutput.nodetype = .output;
            ClkROOTDIVOutput.parents = &.{&CLKROOTDIVSource};

            const ClkSMPSDiv4_clk_value = CLK_SMPS_Div4Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ClkSMPSDiv4",
                "Else",
                "No Extra Log",
                "CLK_SMPS_Div4",
            });
            ClkSMPSDiv4.nodetype = .div;
            ClkSMPSDiv4.value = ClkSMPSDiv4_clk_value;
            ClkSMPSDiv4.parents = &.{&ClkROOTDIVOutput};

            const ClkSMPSDiv2_clk_value = CLK_SMPS_Div2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ClkSMPSDiv2",
                "Else",
                "No Extra Log",
                "CLK_SMPS_Div2",
            });
            ClkSMPSDiv2.nodetype = .div;
            ClkSMPSDiv2.value = ClkSMPSDiv2_clk_value;
            ClkSMPSDiv2.parents = &.{&ClkROOTDIVOutput};

            const ClkSMPSDIV_clk_value = ClkSMPSDIVSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ClkSMPSDIV",
                "Else",
                "No Extra Log",
                "ClkSMPSDIVSource",
            });
            const ClkSMPSDIVparents = [_]*const ClockNode{
                &ClkSMPSDiv4,
                &ClkSMPSDiv2,
            };
            ClkSMPSDIV.nodetype = .multi;
            ClkSMPSDIV.parents = &.{ClkSMPSDIVparents[ClkSMPSDIV_clk_value.get()]};

            const CLK_SPMS_KRM_DIV_clk_value = CLK_SPMS_KRM_DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK_SPMS_KRM_DIV",
                "Else",
                "No Extra Log",
                "CLK_SPMS_KRM_DIV",
            });
            CLK_SPMS_KRM_DIV.nodetype = .div;
            CLK_SPMS_KRM_DIV.value = CLK_SPMS_KRM_DIV_clk_value.get();
            CLK_SPMS_KRM_DIV.parents = &.{&ROOTCLKOutput};

            const ClkKRM_clk_value = ClkKRMSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ClkKRM",
                "Else",
                "No Extra Log",
                "ClkKRMSource",
            });
            const ClkKRMparents = [_]*const ClockNode{
                &ClkSMPSDIV,
                &CLK_SPMS_KRM_DIV,
            };
            ClkKRM.nodetype = .multi;
            ClkKRM.parents = &.{ClkKRMparents[ClkKRM_clk_value.get()]};

            std.mem.doNotOptimizeAway(ClkSMPSFreq_VALUEValue);
            ClkSMPSOutput.limit = ClkSMPSFreq_VALUELimit;
            ClkSMPSOutput.nodetype = .output;
            ClkSMPSOutput.parents = &.{&ClkKRM};
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                const LPUARTMult_clk_value = LPUARTClockSelectionValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUARTMult",
                    "Else",
                    "No Extra Log",
                    "LPUARTClockSelection",
                });
                const LPUARTMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &ClkROOTDIVOutput,
                };
                LPUARTMult.nodetype = .multi;
                LPUARTMult.parents = &.{LPUARTMultparents[LPUARTMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LPUARTFreq_VALUEValue);
                ClkLPUARTOutput.limit = LPUARTFreq_VALUELimit;
                ClkLPUARTOutput.nodetype = .output;
                ClkLPUARTOutput.parents = &.{&LPUARTMult};
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                const LSCOMult_clk_value = LSCOSource1Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSCOMult",
                    "Else",
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
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(LSCOPinFreq_ValueValue);
                LSCOOutput.nodetype = .output;
                LSCOOutput.parents = &.{&LSCOMult};
            }

            const Div2_clk_value = Div2Value orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "Div2",
                "Else",
                "No Extra Log",
                "Div2",
            });
            Div2.nodetype = .div;
            Div2.value = Div2_clk_value;
            Div2.parents = &.{&ROOTCLKOutput};
            if (check_ref(@TypeOf(SysSourceHSEEnableValue), SysSourceHSEEnableValue, .true, .@"=")) {
                const ROOTCLK48Prescaler_clk_value = SYSCLK48DividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ROOTCLK48Prescaler",
                    "Else",
                    "No Extra Log",
                    "SYSCLK48Divider",
                });
                ROOTCLK48Prescaler.nodetype = .div;
                ROOTCLK48Prescaler.value = ROOTCLK48Prescaler_clk_value.get();
                ROOTCLK48Prescaler.parents = &.{&ROOTCLKOutput};
            }
            if (check_ref(@TypeOf(SYSCLK64EnableValue), SYSCLK64EnableValue, .true, .@"=")) {
                const ROOTCLK64Prescaler_clk_value = SYSCLK64DividerValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ROOTCLK64Prescaler",
                    "Else",
                    "No Extra Log",
                    "SYSCLK64Divider",
                });
                ROOTCLK64Prescaler.nodetype = .div;
                ROOTCLK64Prescaler.value = ROOTCLK64Prescaler_clk_value.get();
                ROOTCLK64Prescaler.parents = &.{&ROOTCLKOutput};
            }

            const CLKSYSMult_clk_value = CLKSYSMultSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLKSYSMult",
                "Else",
                "No Extra Log",
                "CLKSYSMultSource",
            });
            const CLKSYSMultparents = [_]*const ClockNode{
                &ROOTCLK48Prescaler,
                &ROOTCLK64Prescaler,
            };
            CLKSYSMult.nodetype = .multi;
            CLKSYSMult.parents = &.{CLKSYSMultparents[CLKSYSMult_clk_value.get()]};

            std.mem.doNotOptimizeAway(CLKSYSFreq_VALUEValue);
            CLKSYSOutput.limit = CLKSYSFreq_VALUELimit;
            CLKSYSOutput.nodetype = .output;
            CLKSYSOutput.parents = &.{&CLKSYSMult};
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                const CLKSPI3I2SMult_clk_value = CLKSPI3I2SMultSourceValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLKSPI3I2SMult",
                    "Else",
                    "No Extra Log",
                    "CLKSPI3I2SMultSource",
                });
                const CLKSPI3I2SMultparents = [_]*const ClockNode{
                    &ClkROOTDIVOutput,
                    &Div2,
                    &RC64MPLL,
                };
                CLKSPI3I2SMult.nodetype = .multi;
                CLKSPI3I2SMult.parents = &.{CLKSPI3I2SMultparents[CLKSPI3I2SMult_clk_value.get()]};
            }

            std.mem.doNotOptimizeAway(CLKSPI3I2SFreq_VALUEValue);
            CLKSPI3I2SOutput.limit = CLKSPI3I2SFreq_VALUELimit;
            CLKSPI3I2SOutput.nodetype = .output;
            CLKSPI3I2SOutput.parents = &.{&CLKSPI3I2SMult};

            const CLKROOTCDevisorON512_clk_value = RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIVValue orelse try comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLKROOTCDevisorON512",
                "Else",
                "No Extra Log",
                "RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIV",
            });
            CLKROOTCDevisorON512.nodetype = .div;
            CLKROOTCDevisorON512.value = CLKROOTCDevisorON512_clk_value;
            CLKROOTCDevisorON512.parents = &.{&ClkROOTDIVOutput};
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MRSUBGEnableValue), MRSUBGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPAWUREnableValue), LPAWUREnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCSCEnableValue), LCSCEnableValue, .true, .@"="))
            {
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
                    &CLKROOTCDevisorON512,
                    &LSEOSC,
                    &LSIRC,
                };
                RTCClkSource.nodetype = .multi;
                RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MRSUBGEnableValue), MRSUBGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LPAWUREnableValue), LPAWUREnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCDEnableValue), LCDEnableValue, .true, .@"=") or
                check_ref(@TypeOf(LCSCEnableValue), LCSCEnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(RTCFreq_ValueValue);
                RTCOutput.limit = RTCFreq_ValueLimit;
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
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
                    &ClkROOTDIVOutput,
                    &ClkSMPSOutput,
                    &ROOTCLKOutput,
                    &HSEOSC,
                    &RC64MPLL,
                    &CLKROOTCDevisorON512,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCODiv_clk_value = RCC_MCODivValue orelse try comptime_fail_or_error(error.InvalidClockValue,
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
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
            }

            out.HSIRC = try HSIRC.get_output();
            out.PLL64RC = try PLL64RC.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.RC64MPLL = try RC64MPLL.get_output();
            out.ROOTClkSource = try ROOTClkSource.get_output();
            out.ROOTCLKOutput = try ROOTCLKOutput.get_output();
            out.TimerOutput = try TimerOutput.get_output();
            out.CLK_ROOT_DIV3 = try CLK_ROOT_DIV3.get_output();
            out.CLK_ROOT_DIV4 = try CLK_ROOT_DIV4.get_output();
            out.CLKROOTDIVSource = try CLKROOTDIVSource.get_output();
            out.ClkROOTDIVOutput = try ClkROOTDIVOutput.get_output();
            out.ClkSMPSDiv4 = try ClkSMPSDiv4.get_output();
            out.ClkSMPSDiv2 = try ClkSMPSDiv2.get_output();
            out.ClkSMPSDIV = try ClkSMPSDIV.get_output();
            out.CLK_SPMS_KRM_DIV = try CLK_SPMS_KRM_DIV.get_output();
            out.ClkKRM = try ClkKRM.get_output();
            out.ClkSMPSOutput = try ClkSMPSOutput.get_output();
            out.LPUARTMult = try LPUARTMult.get_output();
            out.ClkLPUARTOutput = try ClkLPUARTOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.Div2 = try Div2.get_output();
            out.ROOTCLK48Prescaler = try ROOTCLK48Prescaler.get_output();
            out.ROOTCLK64Prescaler = try ROOTCLK64Prescaler.get_output();
            out.CLKSYSMult = try CLKSYSMult.get_output();
            out.CLKSYSOutput = try CLKSYSOutput.get_output();
            out.CLKSPI3I2SMult = try CLKSPI3I2SMult.get_output();
            out.CLKSPI3I2SOutput = try CLKSPI3I2SOutput.get_output();
            out.CLKROOTCDevisorON512 = try CLKROOTCDevisorON512.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOPin = try MCOPin.get_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.RC64MPLLSource = RC64MPLLSourceValue;
            ref_out.ROOTClkSource = ROOTClkSourceValue;
            ref_out.ClkROOTDIV_Div3 = ClkROOTDIV_Div3Value;
            ref_out.ClkROOTDIV_Div4 = ClkROOTDIV_Div4Value;
            ref_out.ClkROOTDIVSource = ClkROOTDIVSourceValue;
            ref_out.CLK_SMPS_Div4 = CLK_SMPS_Div4Value;
            ref_out.CLK_SMPS_Div2 = CLK_SMPS_Div2Value;
            ref_out.ClkSMPSDIVSource = ClkSMPSDIVSourceValue;
            ref_out.CLK_SPMS_KRM_DIV = CLK_SPMS_KRM_DIVValue;
            ref_out.ClkKRMSource = ClkKRMSourceValue;
            ref_out.LPUARTClockSelection = LPUARTClockSelectionValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.Div2 = Div2Value;
            ref_out.SYSCLK48Divider = SYSCLK48DividerValue;
            ref_out.SYSCLK64Divider = SYSCLK64DividerValue;
            ref_out.CLKSYSMultSource = CLKSYSMultSourceValue;
            ref_out.CLKSPI3I2SMultSource = CLKSPI3I2SMultSourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIV = RCC_RTC_Clock_Source_FROM_CLK_ROOT_DIVValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.HSE_current_control = HSE_current_controlValue;
            ref_out.HSE_Capacitor_Tuning = HSE_Capacitor_TuningValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.SysSourceHSEEnable = SysSourceHSEEnableValue;
            ref_out.SYSCLK64Enable = SYSCLK64EnableValue;
            ref_out.SPI3Enable = SPI3EnableValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.MRSUBGEnable = MRSUBGEnableValue;
            ref_out.LPAWUREnable = LPAWUREnableValue;
            ref_out.LCDEnable = LCDEnableValue;
            ref_out.LCSCEnable = LCSCEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.HSIUsed = HSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
