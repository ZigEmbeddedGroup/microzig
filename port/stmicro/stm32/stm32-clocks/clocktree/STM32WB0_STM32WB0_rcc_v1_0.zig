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
pub const SYSCLKSourceList = enum {
    RCC_SYSCLKSOURCE_DIRECT_HSE,
    RCC_SYSCLKSOURCE_RC64MPLL,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_DIRECT_HSE => 0,
            .RCC_SYSCLKSOURCE_RC64MPLL => 1,
        };
    }
};
pub const Clk16MHzSourceList = enum {
    CLK16MHzDiv2,
    CLK16MHzDiv4,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .CLK16MHzDiv2 => 0,
            .CLK16MHzDiv4 => 1,
        };
    }
};
pub const ClkSMPSSourceList = enum {
    RCC_SMPSCLK_DIV4,
    RCC_SMPSCLK_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SMPSCLK_DIV4 => 0,
            .RCC_SMPSCLK_DIV2 => 1,
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
pub const Clk32MHzSourceList = enum {
    SysCLKOutput,
    CLK32MHzDiv2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SysCLKOutput => 0,
            .CLK32MHzDiv2 => 1,
        };
    }
};
pub const BLEMultSourceList = enum {
    RCC_RF_CLK_16M,
    RCC_RF_CLK_32M,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RF_CLK_16M => 0,
            .RCC_RF_CLK_32M => 1,
        };
    }
};
pub const CLKSYSMultSourceList = enum {
    SYSCLK32Prescaler,
    SYSCLK64Prescaler,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .SYSCLK32Prescaler => 0,
            .SYSCLK64Prescaler => 1,
        };
    }
};
pub const CLKI2S3MultSourceList = enum {
    RCC_SPI3I2S_CLKSOURCE_32M,
    RCC_SPI3I2S_CLKSOURCE_16M,
    RCC_SPI3I2S_CLKSOURCE_64M,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3I2S_CLKSOURCE_32M => 0,
            .RCC_SPI3I2S_CLKSOURCE_16M => 1,
            .RCC_SPI3I2S_CLKSOURCE_64M => 2,
        };
    }
};
pub const CLKI2S2MultSourceList = enum {
    RCC_SPI2I2S_CLKSOURCE_32M,
    RCC_SPI2I2S_CLKSOURCE_16M,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI2I2S_CLKSOURCE_32M => 0,
            .RCC_SPI2I2S_CLKSOURCE_16M => 1,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTC_WDG_BLEWKUP_CLKSOURCE_HSI64M_DIV2048,
    RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSE,
    RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_HSI64M_DIV2048 => 0,
            .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSE => 1,
            .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSI => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCOSOURCE_ADC,
    RCC_MCOSOURCE_SMPS,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCOSOURCE_HSI64M_DIV2048,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCOSOURCE_ADC => 0,
            .RCC_MCOSOURCE_SMPS => 1,
            .RCC_MCO1SOURCE_SYSCLK => 2,
            .RCC_MCO1SOURCE_HSE => 3,
            .RCC_MCO1SOURCE_HSI => 4,
            .RCC_MCOSOURCE_HSI64M_DIV2048 => 5,
        };
    }
};
pub const SYSCLK32DividerList = enum {
    RCC_DIRECT_HSE_DIV1,
    RCC_DIRECT_HSE_DIV2,
    RCC_DIRECT_HSE_DIV4,
    RCC_DIRECT_HSE_DIV8,
    RCC_DIRECT_HSE_DIV16,
    RCC_DIRECT_HSE_DIV32,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_DIRECT_HSE_DIV1 => 1,
            .RCC_DIRECT_HSE_DIV2 => 2,
            .RCC_DIRECT_HSE_DIV4 => 4,
            .RCC_DIRECT_HSE_DIV8 => 8,
            .RCC_DIRECT_HSE_DIV16 => 16,
            .RCC_DIRECT_HSE_DIV32 => 32,
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
    FLASH_WAIT_STATES_1,
    FLASH_WAIT_STATES_0,
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const DATA_CACHE_ENABLEList = enum {
    @"1",
    @"0",
};
pub const HSE_current_controlList = enum {
    RCC_HSE_CURRENTMAX_0,
    RCC_HSE_CURRENTMAX_1,
    RCC_HSE_CURRENTMAX_2,
    RCC_HSE_CURRENTMAX_3,
    RCC_HSE_CURRENTMAX_4,
    RCC_HSE_CURRENTMAX_5,
    RCC_HSE_CURRENTMAX_6,
    RCC_HSE_CURRENTMAX_7,
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
pub const EnableLSIList = enum {
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
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const RADIOEnableList = enum {
    true,
    false,
};
pub const I2S3EnableList = enum {
    true,
    false,
};
pub const I2S2EnableList = enum {
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
pub const RADIO_TIMEREnableList = enum {
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
            RADIO_Used: bool = false,
            ADC_Used: bool = false,
            IWDG_Used: bool = false,
            I2S2_Used: bool = false,
            I2S3_Used: bool = false,
            RADIO_TIMER_Used: bool = false,
            LPUART1_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_current_control: ?HSE_current_controlList = null,
            HSE_Capacitor_Tuning: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            RC64MPLLSource: ?RC64MPLLSourceList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            Clk16MHzSource: ?Clk16MHzSourceList = null,
            ClkSMPSSource: ?ClkSMPSSourceList = null,
            LPUARTClockSelection: ?LPUARTClockSelectionList = null,
            LSCOSource1: ?LSCOSource1List = null,
            Clk32MHzSource: ?Clk32MHzSourceList = null,
            BLEMultSource: ?BLEMultSourceList = null,
            SYSCLK32Divider: ?SYSCLK32DividerList = null,
            SYSCLK64Divider: ?SYSCLK64DividerList = null,
            CLKSYSMultSource: ?CLKSYSMultSourceList = null,
            CLKI2S3MultSource: ?CLKI2S3MultSourceList = null,
            CLKI2S2MultSource: ?CLKI2S2MultSourceList = null,
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
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            TimerOutput: f32 = 0,
            CLK16MHzDiv2: f32 = 0,
            CLK16MHzDiv4: f32 = 0,
            CLK16MHzSource: f32 = 0,
            Clk16MHzOutput: f32 = 0,
            ClkSMPSDiv4: f32 = 0,
            ClkSMPSDiv2: f32 = 0,
            ClkSMPS: f32 = 0,
            ClkSMPSOutput: f32 = 0,
            LPUARTMult: f32 = 0,
            ClkLPUARTOutput: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            CLK32MHzDiv1: f32 = 0,
            CLK32MHzDiv2: f32 = 0,
            CLK32MHzSource: f32 = 0,
            Clk32MHzOutput: f32 = 0,
            BLEMult: f32 = 0,
            BLEOutput: f32 = 0,
            SYSCLK32Prescaler: f32 = 0,
            SYSCLK64Prescaler: f32 = 0,
            CLKSYSMult: f32 = 0,
            CLKSYSOutput: f32 = 0,
            CLKI2S3Mult: f32 = 0,
            CLKI2S3Output: f32 = 0,
            CLKI2S2Output: f32 = 0,
            CLKI2S2Mult: f32 = 0,
            CLK16RTCDevisor: f32 = 0,
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
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            RC64MPLLSource: ?RC64MPLLSourceList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            CLK_16MHz_Div2: ?f32 = null, //from RCC Clock Config
            CLK_16MHz_Div4: ?f32 = null, //from RCC Clock Config
            Clk16MHzSource: ?Clk16MHzSourceList = null, //from RCC Clock Config
            CLK_SMPS_Div4: ?f32 = null, //from RCC Clock Config
            CLK_SMPS_Div2: ?f32 = null, //from RCC Clock Config
            ClkSMPSSource: ?ClkSMPSSourceList = null, //from RCC Clock Config
            LPUARTClockSelection: ?LPUARTClockSelectionList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            CLK_32MHz_Div1: ?f32 = null, //from RCC Clock Config
            CLK_32MHz_Div2: ?f32 = null, //from RCC Clock Config
            Clk32MHzSource: ?Clk32MHzSourceList = null, //from RCC Clock Config
            BLEMultSource: ?BLEMultSourceList = null, //from RCC Clock Config
            SYSCLK32Divider: ?SYSCLK32DividerList = null, //from RCC Clock Config
            SYSCLK64Divider: ?SYSCLK64DividerList = null, //from RCC Clock Config
            CLKSYSMultSource: ?CLKSYSMultSourceList = null, //from RCC Clock Config
            CLKI2S3MultSource: ?CLKI2S3MultSourceList = null, //from RCC Clock Config
            CLKI2S2MultSource: ?CLKI2S2MultSourceList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_CLK_16MHz: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_current_control: ?HSE_current_controlList = null, //from RCC Advanced Config
            HSE_Capacitor_Tuning: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            EnableLSI: ?EnableLSIList = null, //from extra RCC references
            SysSourceHSEEnable: ?SysSourceHSEEnableList = null, //from extra RCC references
            SYSCLK64Enable: ?SYSCLK64EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            RADIOEnable: ?RADIOEnableList = null, //from extra RCC references
            I2S3Enable: ?I2S3EnableList = null, //from extra RCC references
            I2S2Enable: ?I2S2EnableList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            RADIO_TIMEREnable: ?RADIO_TIMEREnableList = null, //from extra RCC references
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
            var LPUART1CLKSOURCELSE: bool = false;
            var LPUART1CLKSOURCE16M: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var RFCLK16M: bool = false;
            var RFCLK32M: bool = false;
            var SYSCLKPrescaler32: bool = false;
            var SYSCLKPrescaler64: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_32M: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_16M: bool = false;
            var RCC_SPI3I2S_CLKSOURCE_64M: bool = false;
            var RCC_SPI2I2S_CLKSOURCE_32M: bool = false;
            var RCC_SPI2I2S_CLKSOURCE_16M: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var MCOSourceADC: bool = false;
            var MCOSourceSMPS: bool = false;
            var MCOSourceSYSCLK: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceHSI: bool = false;
            var MCOSourceCLK16: bool = false;
            var SysCLKFreq_VALUELimit: Limit = .{};
            var ClkSMPSFreq_VALUELimit: Limit = .{};
            var LPUARTFreq_VALUELimit: Limit = .{};
            var BLEFreq_VALUELimit: Limit = .{};
            var CLKSYSFreq_VALUELimit: Limit = .{};
            var CLKI2S3Freq_VALUELimit: Limit = .{};
            var CLKI2S2Freq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 6.4e7;
            };
            const PLL64_VALUEValue: ?f32 = blk: {
                break :blk 6.4e7;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEOscillator) {
                    if (config.HSE_VALUE) |val| {
                        if (val != 3.2e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed Value: {e} found: {e}
                                \\note: some values are fixed depending on the clock configuration.
                                \\
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEOscillator",
                                "HSE enabled",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    break :blk 3.2e7;
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
                    if (val > 3.2e7) {
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
                            3.2e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32000000;
            };
            const LSE_VALUEValue: ?f32 = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass)) {
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
                                "(LSEOscillator|LSEByPass)",
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
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const RC64MPLLSourceValue: ?RC64MPLLSourceList = blk: {
                const conf_item = config.RC64MPLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSCOSOURCE_HSI => RCCLSCOSOURCEHSI = true,
                        .RCC_LSCOSOURCE_PLL64 => RCCLSCOSOURCEPLL64 = true,
                    }
                }

                break :blk conf_item orelse {
                    RCCLSCOSOURCEHSI = true;
                    break :blk .RCC_LSCOSOURCE_HSI;
                };
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_DIRECT_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_RC64MPLL => SysSourceRC64 = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceRC64 = true;
                    break :blk .RCC_SYSCLKSOURCE_RC64MPLL;
                };
            };
            const SysCLKFreq_VALUEValue: ?f32 = blk: {
                SysCLKFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const CLK_16MHz_Div2Value: ?f32 = blk: {
                break :blk 2;
            };
            const CLK_16MHz_Div4Value: ?f32 = blk: {
                break :blk 4;
            };
            const Clk16MHzSourceValue: ?Clk16MHzSourceList = blk: {
                const conf_item = config.Clk16MHzSource;
                if (conf_item) |item| {
                    switch (item) {
                        .CLK16MHzDiv2 => SysSourceMSI = true,
                        .CLK16MHzDiv4 => SysSourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceHSI = true;
                    break :blk .CLK16MHzDiv4;
                };
            };
            const Clk16MHzFreq_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const CLK_SMPS_Div4Value: ?f32 = blk: {
                break :blk 4;
            };
            const CLK_SMPS_Div2Value: ?f32 = blk: {
                break :blk 2;
            };
            const ClkSMPSSourceValue: ?ClkSMPSSourceList = blk: {
                const conf_item = config.ClkSMPSSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SMPSCLK_DIV2 => {},
                        .RCC_SMPSCLK_DIV4 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SMPSCLK_DIV4;
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

                break :blk conf_item orelse {
                    LPUART1CLKSOURCE16M = true;
                    break :blk .RCC_LPUART1_CLKSOURCE_16M;
                };
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

                break :blk conf_item orelse {
                    LSCOSSourceLSI = true;
                    break :blk .RCC_LSCOSOURCE_LSI;
                };
            };
            const LSCOPinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const CLK_32MHz_Div1Value: ?f32 = blk: {
                break :blk 1;
            };
            const CLK_32MHz_Div2Value: ?f32 = blk: {
                break :blk 2;
            };
            const Clk32MHzSourceValue: ?Clk32MHzSourceList = blk: {
                const conf_item = config.Clk32MHzSource;
                if (conf_item) |item| {
                    switch (item) {
                        .SysCLKOutput => SysSourceMSI = true,
                        .CLK32MHzDiv2 => SysSourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceHSI = true;
                    break :blk .CLK32MHzDiv2;
                };
            };
            const Clk32MHzFreq_VALUEValue: ?f32 = blk: {
                break :blk 3.2e7;
            };
            const BLEMultSourceValue: ?BLEMultSourceList = blk: {
                const conf_item = config.BLEMultSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RF_CLK_16M => RFCLK16M = true,
                        .RCC_RF_CLK_32M => RFCLK32M = true,
                    }
                }

                break :blk conf_item orelse {
                    RFCLK32M = true;
                    break :blk .RCC_RF_CLK_32M;
                };
            };
            const BLEFreq_VALUEValue: ?f32 = blk: {
                BLEFreq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const SYSCLK32DividerValue: ?SYSCLK32DividerList = blk: {
                const conf_item = config.SYSCLK32Divider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_DIRECT_HSE_DIV1 => {},
                        .RCC_DIRECT_HSE_DIV2 => {},
                        .RCC_DIRECT_HSE_DIV4 => {},
                        .RCC_DIRECT_HSE_DIV8 => {},
                        .RCC_DIRECT_HSE_DIV16 => {},
                        .RCC_DIRECT_HSE_DIV32 => {},
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
                        .SYSCLK32Prescaler => SYSCLKPrescaler32 = true,
                        .SYSCLK64Prescaler => SYSCLKPrescaler64 = true,
                    }
                }

                break :blk conf_item orelse {
                    SYSCLKPrescaler64 = true;
                    break :blk .SYSCLK64Prescaler;
                };
            };
            const CLKSYSFreq_VALUEValue: ?f32 = blk: {
                if (config.flags.RADIO_Used and RFCLK16M) {
                    CLKSYSFreq_VALUELimit = .{
                        .min = 1.6e7,
                        .max = 6.4e7,
                    };
                    break :blk null;
                } else if (config.flags.RADIO_Used and RFCLK32M) {
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
            const CLKI2S3MultSourceValue: ?CLKI2S3MultSourceList = blk: {
                if (check_MCU("I2S2_Exist")) {
                    const conf_item = config.CLKI2S3MultSource;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SPI3I2S_CLKSOURCE_32M => RCC_SPI3I2S_CLKSOURCE_32M = true,
                            .RCC_SPI3I2S_CLKSOURCE_16M => RCC_SPI3I2S_CLKSOURCE_16M = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SPI3I2S_CLKSOURCE_32M
                                    \\ - RCC_SPI3I2S_CLKSOURCE_16M
                                , .{ "CLKI2S3MultSource", "I2S2_Exist", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse null;
                }
                const conf_item = config.CLKI2S3MultSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3I2S_CLKSOURCE_32M => RCC_SPI3I2S_CLKSOURCE_32M = true,
                        .RCC_SPI3I2S_CLKSOURCE_16M => RCC_SPI3I2S_CLKSOURCE_16M = true,
                        .RCC_SPI3I2S_CLKSOURCE_64M => RCC_SPI3I2S_CLKSOURCE_64M = true,
                    }
                }

                break :blk conf_item orelse {
                    RCC_SPI3I2S_CLKSOURCE_64M = true;
                    break :blk .RCC_SPI3I2S_CLKSOURCE_64M;
                };
            };
            const CLKI2S3Freq_VALUEValue: ?f32 = blk: {
                CLKI2S3Freq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const CLKI2S2Freq_VALUEValue: ?f32 = blk: {
                CLKI2S2Freq_VALUELimit = .{
                    .min = null,
                    .max = 6.4e7,
                };
                break :blk null;
            };
            const CLKI2S2MultSourceValue: ?CLKI2S2MultSourceList = blk: {
                const conf_item = config.CLKI2S2MultSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI2I2S_CLKSOURCE_32M => RCC_SPI2I2S_CLKSOURCE_32M = true,
                        .RCC_SPI2I2S_CLKSOURCE_16M => RCC_SPI2I2S_CLKSOURCE_16M = true,
                    }
                }

                break :blk conf_item orelse {
                    RCC_SPI2I2S_CLKSOURCE_32M = true;
                    break :blk .RCC_SPI2I2S_CLKSOURCE_32M;
                };
            };
            const RCC_RTC_Clock_Source_FROM_CLK_16MHzValue: ?f32 = blk: {
                break :blk 512;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_HSI64M_DIV2048 => RTCSourceHSE = true,
                        .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSI => RTCSourceLSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RTCSourceLSI = true;
                    break :blk .RCC_RTC_WDG_BLEWKUP_CLKSOURCE_LSI;
                };
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
                        .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                        .RCC_MCOSOURCE_HSI64M_DIV2048 => MCOSourceCLK16 = true,
                    }
                }

                break :blk conf_item orelse {
                    MCOSourceSYSCLK = true;
                    break :blk .RCC_MCO1SOURCE_SYSCLK;
                };
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
                break :blk 4e6;
            };
            const VDD_VALUEValue: ?f32 = blk: {
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
                if ((check_ref(@TypeOf(CLKSYSFreq_VALUEValue), CLKSYSFreq_VALUEValue, 64000000, .@"="))) {
                    const item: FLatencyList = .FLASH_WAIT_STATES_1;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_WAIT_STATES_0;
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
                if ((config.flags.MCOConfig and MCOSourceHSI) or (RCCLSCOSOURCEHSI)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSICalibrationValueValue: ?f32 = blk: {
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
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 16;
            };
            const HSE_current_controlValue: ?HSE_current_controlList = blk: {
                if (config.flags.HSEOscillator) {
                    const conf_item = config.extra.HSE_current_control;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_HSE_CURRENTMAX_0 => {},
                            .RCC_HSE_CURRENTMAX_1 => {},
                            .RCC_HSE_CURRENTMAX_2 => {},
                            .RCC_HSE_CURRENTMAX_3 => {},
                            .RCC_HSE_CURRENTMAX_4 => {},
                            .RCC_HSE_CURRENTMAX_5 => {},
                            .RCC_HSE_CURRENTMAX_6 => {},
                            .RCC_HSE_CURRENTMAX_7 => {},
                        }
                    }

                    break :blk conf_item orelse .RCC_HSE_CURRENTMAX_3;
                }
                if (config.extra.HSE_current_control) |_| {
                    return comptime_fail_or_error(error.InvalidConfig,
                        \\
                        \\Error on {s} | expr: {s} diagnostic: {s} 
                        \\Value should be null.
                        \\note: some configurations are invalid in certain cases.
                        \\
                        \\
                    , .{ "HSE_current_control", "Else", "No Extra Log" });
                }
                break :blk null;
            };
            const HSE_Capacitor_TuningValue: ?f32 = blk: {
                if (config.flags.HSEOscillator) {
                    const config_val = config.extra.HSE_Capacitor_Tuning;
                    if (config_val) |val| {
                        if (val < 0) {
                            return comptime_fail_or_error(error.InvalidConfig,
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
                            return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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
                        return comptime_fail_or_error(error.InvalidConfig,
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

                    break :blk conf_item orelse .RCC_LSEDRIVE_MEDIUMLOW;
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if (config.flags.HSEOscillator) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const EnableLSIValue: ?EnableLSIList = blk: {
                if (!(config.flags.LSEOscillator or config.flags.LSEByPass) or !config.flags.RADIO_TIMER_Used) {
                    const item: EnableLSIList = .true;
                    break :blk item;
                }
                const item: EnableLSIList = .false;
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
            const RADIOEnableValue: ?RADIOEnableList = blk: {
                if (config.flags.RADIO_Used) {
                    const item: RADIOEnableList = .true;
                    break :blk item;
                }
                const item: RADIOEnableList = .false;
                break :blk item;
            };
            const I2S3EnableValue: ?I2S3EnableList = blk: {
                if (config.flags.I2S3_Used) {
                    const item: I2S3EnableList = .true;
                    break :blk item;
                }
                const item: I2S3EnableList = .false;
                break :blk item;
            };
            const I2S2EnableValue: ?I2S2EnableList = blk: {
                if (config.flags.I2S2_Used) {
                    const item: I2S2EnableList = .true;
                    break :blk item;
                }
                const item: I2S2EnableList = .false;
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
                if (config.flags.IWDG_Used) {
                    const item: IWDGEnableList = .true;
                    break :blk item;
                }
                const item: IWDGEnableList = .false;
                break :blk item;
            };
            const RADIO_TIMEREnableValue: ?RADIO_TIMEREnableList = blk: {
                if (config.flags.RADIO_TIMER_Used) {
                    const item: RADIO_TIMEREnableList = .true;
                    break :blk item;
                }
                const item: RADIO_TIMEREnableList = .false;
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

            var TimerOutput = ClockNode{
                .name = "TimerOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK16MHzDiv2 = ClockNode{
                .name = "CLK16MHzDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK16MHzDiv4 = ClockNode{
                .name = "CLK16MHzDiv4",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK16MHzSource = ClockNode{
                .name = "CLK16MHzSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var Clk16MHzOutput = ClockNode{
                .name = "Clk16MHzOutput",
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

            var ClkSMPS = ClockNode{
                .name = "ClkSMPS",
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

            var CLK32MHzDiv1 = ClockNode{
                .name = "CLK32MHzDiv1",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK32MHzDiv2 = ClockNode{
                .name = "CLK32MHzDiv2",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK32MHzSource = ClockNode{
                .name = "CLK32MHzSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var Clk32MHzOutput = ClockNode{
                .name = "Clk32MHzOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var BLEMult = ClockNode{
                .name = "BLEMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var BLEOutput = ClockNode{
                .name = "BLEOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSCLK32Prescaler = ClockNode{
                .name = "SYSCLK32Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSCLK64Prescaler = ClockNode{
                .name = "SYSCLK64Prescaler",
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

            var CLKI2S3Mult = ClockNode{
                .name = "CLKI2S3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKI2S3Output = ClockNode{
                .name = "CLKI2S3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKI2S2Output = ClockNode{
                .name = "CLKI2S2Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLKI2S2Mult = ClockNode{
                .name = "CLKI2S2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var CLK16RTCDevisor = ClockNode{
                .name = "CLK16RTCDevisor",
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
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const PLL64RC_clk_value = PLL64_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(EnableLSIValue), EnableLSIValue, .true, .@"=")) {
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

            const RC64MPLL_clk_value = RC64MPLLSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                &HSEOSC,
                &RC64MPLL,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(SysCLKFreq_VALUEValue);
            SysCLKOutput.limit = SysCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};

            std.mem.doNotOptimizeAway(SysCLKFreq_VALUEValue);
            TimerOutput.limit = SysCLKFreq_VALUELimit;
            TimerOutput.nodetype = .output;
            TimerOutput.parents = &.{&SysCLKOutput};
            if (check_ref(@TypeOf(SysSourceHSEEnableValue), SysSourceHSEEnableValue, .true, .@"=")) {
                const CLK16MHzDiv2_clk_value = CLK_16MHz_Div2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLK16MHzDiv2",
                    "Else",
                    "No Extra Log",
                    "CLK_16MHz_Div2",
                });
                CLK16MHzDiv2.nodetype = .div;
                CLK16MHzDiv2.value = CLK16MHzDiv2_clk_value;
                CLK16MHzDiv2.parents = &.{&SysCLKOutput};
            }
            if (check_ref(@TypeOf(SYSCLK64EnableValue), SYSCLK64EnableValue, .true, .@"=")) {
                const CLK16MHzDiv4_clk_value = CLK_16MHz_Div4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLK16MHzDiv4",
                    "Else",
                    "No Extra Log",
                    "CLK_16MHz_Div4",
                });
                CLK16MHzDiv4.nodetype = .div;
                CLK16MHzDiv4.value = CLK16MHzDiv4_clk_value;
                CLK16MHzDiv4.parents = &.{&SysCLKOutput};
            }

            const CLK16MHzSource_clk_value = Clk16MHzSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK16MHzSource",
                "Else",
                "No Extra Log",
                "Clk16MHzSource",
            });
            const CLK16MHzSourceparents = [_]*const ClockNode{
                &CLK16MHzDiv2,
                &CLK16MHzDiv4,
            };
            CLK16MHzSource.nodetype = .multi;
            CLK16MHzSource.parents = &.{CLK16MHzSourceparents[CLK16MHzSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(Clk16MHzFreq_VALUEValue);
            Clk16MHzOutput.nodetype = .output;
            Clk16MHzOutput.parents = &.{&CLK16MHzSource};

            const ClkSMPSDiv4_clk_value = CLK_SMPS_Div4Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            ClkSMPSDiv4.parents = &.{&Clk16MHzOutput};

            const ClkSMPSDiv2_clk_value = CLK_SMPS_Div2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            ClkSMPSDiv2.parents = &.{&Clk16MHzOutput};

            const ClkSMPS_clk_value = ClkSMPSSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "ClkSMPS",
                "Else",
                "No Extra Log",
                "ClkSMPSSource",
            });
            const ClkSMPSparents = [_]*const ClockNode{
                &ClkSMPSDiv4,
                &ClkSMPSDiv2,
            };
            ClkSMPS.nodetype = .multi;
            ClkSMPS.parents = &.{ClkSMPSparents[ClkSMPS_clk_value.get()]};

            std.mem.doNotOptimizeAway(ClkSMPSFreq_VALUEValue);
            ClkSMPSOutput.limit = ClkSMPSFreq_VALUELimit;
            ClkSMPSOutput.nodetype = .output;
            ClkSMPSOutput.parents = &.{&ClkSMPS};
            if (!check_MCU("I2S2_Exist")) {
                if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                    const LPUARTMult_clk_value = LPUARTClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LPUARTMult",
                        "!I2S2_Exist",
                        "No Extra Log",
                        "LPUARTClockSelection",
                    });
                    const LPUARTMultparents = [_]*const ClockNode{
                        &LSEOSC,
                        &Clk16MHzOutput,
                    };
                    LPUARTMult.nodetype = .multi;
                    LPUARTMult.parents = &.{LPUARTMultparents[LPUARTMult_clk_value.get()]};
                }
            }
            if (!check_MCU("I2S2_Exist")) {
                if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                    std.mem.doNotOptimizeAway(LPUARTFreq_VALUEValue);
                    ClkLPUARTOutput.limit = LPUARTFreq_VALUELimit;
                    ClkLPUARTOutput.nodetype = .output;
                    ClkLPUARTOutput.parents = &.{&LPUARTMult};
                }
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                const LSCOMult_clk_value = LSCOSource1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
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
            if (check_ref(@TypeOf(SysSourceHSEEnableValue), SysSourceHSEEnableValue, .true, .@"=")) {
                const CLK32MHzDiv1_clk_value = CLK_32MHz_Div1Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLK32MHzDiv1",
                    "Else",
                    "No Extra Log",
                    "CLK_32MHz_Div1",
                });
                CLK32MHzDiv1.nodetype = .div;
                CLK32MHzDiv1.value = CLK32MHzDiv1_clk_value;
                CLK32MHzDiv1.parents = &.{&SysCLKOutput};
            }
            if (check_ref(@TypeOf(SYSCLK64EnableValue), SYSCLK64EnableValue, .true, .@"=")) {
                const CLK32MHzDiv2_clk_value = CLK_32MHz_Div2Value orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLK32MHzDiv2",
                    "Else",
                    "No Extra Log",
                    "CLK_32MHz_Div2",
                });
                CLK32MHzDiv2.nodetype = .div;
                CLK32MHzDiv2.value = CLK32MHzDiv2_clk_value;
                CLK32MHzDiv2.parents = &.{&SysCLKOutput};
            }

            const CLK32MHzSource_clk_value = Clk32MHzSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK32MHzSource",
                "Else",
                "No Extra Log",
                "Clk32MHzSource",
            });
            const CLK32MHzSourceparents = [_]*const ClockNode{
                &CLK32MHzDiv1,
                &CLK32MHzDiv2,
            };
            CLK32MHzSource.nodetype = .multi;
            CLK32MHzSource.parents = &.{CLK32MHzSourceparents[CLK32MHzSource_clk_value.get()]};

            std.mem.doNotOptimizeAway(Clk32MHzFreq_VALUEValue);
            Clk32MHzOutput.nodetype = .output;
            Clk32MHzOutput.parents = &.{&CLK32MHzSource};
            if (check_ref(@TypeOf(RADIOEnableValue), RADIOEnableValue, .true, .@"=")) {
                const BLEMult_clk_value = BLEMultSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "BLEMult",
                    "Else",
                    "No Extra Log",
                    "BLEMultSource",
                });
                const BLEMultparents = [_]*const ClockNode{
                    &Clk16MHzOutput,
                    &Clk32MHzOutput,
                };
                BLEMult.nodetype = .multi;
                BLEMult.parents = &.{BLEMultparents[BLEMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RADIOEnableValue), RADIOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(BLEFreq_VALUEValue);
                BLEOutput.limit = BLEFreq_VALUELimit;
                BLEOutput.nodetype = .output;
                BLEOutput.parents = &.{&BLEMult};
            }
            if (check_ref(@TypeOf(SysSourceHSEEnableValue), SysSourceHSEEnableValue, .true, .@"=")) {
                const SYSCLK32Prescaler_clk_value = SYSCLK32DividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SYSCLK32Prescaler",
                    "Else",
                    "No Extra Log",
                    "SYSCLK32Divider",
                });
                SYSCLK32Prescaler.nodetype = .div;
                SYSCLK32Prescaler.value = SYSCLK32Prescaler_clk_value.get();
                SYSCLK32Prescaler.parents = &.{&SysCLKOutput};
            }
            if (check_ref(@TypeOf(SYSCLK64EnableValue), SYSCLK64EnableValue, .true, .@"=")) {
                const SYSCLK64Prescaler_clk_value = SYSCLK64DividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SYSCLK64Prescaler",
                    "Else",
                    "No Extra Log",
                    "SYSCLK64Divider",
                });
                SYSCLK64Prescaler.nodetype = .div;
                SYSCLK64Prescaler.value = SYSCLK64Prescaler_clk_value.get();
                SYSCLK64Prescaler.parents = &.{&SysCLKOutput};
            }

            const CLKSYSMult_clk_value = CLKSYSMultSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                &SYSCLK32Prescaler,
                &SYSCLK64Prescaler,
            };
            CLKSYSMult.nodetype = .multi;
            CLKSYSMult.parents = &.{CLKSYSMultparents[CLKSYSMult_clk_value.get()]};

            std.mem.doNotOptimizeAway(CLKSYSFreq_VALUEValue);
            CLKSYSOutput.limit = CLKSYSFreq_VALUELimit;
            CLKSYSOutput.nodetype = .output;
            CLKSYSOutput.parents = &.{&CLKSYSMult};
            if (check_MCU("I2S2_Exist")) {
                if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                    const CLKI2S3Mult_clk_value = CLKI2S3MultSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "CLKI2S3Mult",
                        "I2S2_Exist",
                        "No Extra Log",
                        "CLKI2S3MultSource",
                    });
                    const CLKI2S3Multparents = [_]*const ClockNode{
                        &Clk32MHzOutput,
                        &Clk16MHzOutput,
                    };
                    CLKI2S3Mult.nodetype = .multi;
                    CLKI2S3Mult.parents = &.{CLKI2S3Multparents[CLKI2S3Mult_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                const CLKI2S3Mult_clk_value = CLKI2S3MultSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLKI2S3Mult",
                    "Else",
                    "No Extra Log",
                    "CLKI2S3MultSource",
                });
                const CLKI2S3Multparents = [_]*const ClockNode{
                    &Clk32MHzOutput,
                    &Clk16MHzOutput,
                    &RC64MPLL,
                };
                CLKI2S3Mult.nodetype = .multi;
                CLKI2S3Mult.parents = &.{CLKI2S3Multparents[CLKI2S3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2S3EnableValue), I2S3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CLKI2S3Freq_VALUEValue);
                CLKI2S3Output.limit = CLKI2S3Freq_VALUELimit;
                CLKI2S3Output.nodetype = .output;
                CLKI2S3Output.parents = &.{&CLKI2S3Mult};
            }
            if (check_ref(@TypeOf(I2S2EnableValue), I2S2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CLKI2S2Freq_VALUEValue);
                CLKI2S2Output.limit = CLKI2S2Freq_VALUELimit;
                CLKI2S2Output.nodetype = .output;
                CLKI2S2Output.parents = &.{&CLKI2S2Mult};
            }
            if (check_ref(@TypeOf(I2S2EnableValue), I2S2EnableValue, .true, .@"=")) {
                const CLKI2S2Mult_clk_value = CLKI2S2MultSourceValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CLKI2S2Mult",
                    "Else",
                    "No Extra Log",
                    "CLKI2S2MultSource",
                });
                const CLKI2S2Multparents = [_]*const ClockNode{
                    &Clk32MHzOutput,
                    &Clk16MHzOutput,
                };
                CLKI2S2Mult.nodetype = .multi;
                CLKI2S2Mult.parents = &.{CLKI2S2Multparents[CLKI2S2Mult_clk_value.get()]};
            }

            const CLK16RTCDevisor_clk_value = RCC_RTC_Clock_Source_FROM_CLK_16MHzValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "CLK16RTCDevisor",
                "Else",
                "No Extra Log",
                "RCC_RTC_Clock_Source_FROM_CLK_16MHz",
            });
            CLK16RTCDevisor.nodetype = .div;
            CLK16RTCDevisor.value = CLK16RTCDevisor_clk_value;
            CLK16RTCDevisor.parents = &.{&Clk16MHzOutput};
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RADIO_TIMEREnableValue), RADIO_TIMEREnableValue, .true, .@"="))
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
                    &CLK16RTCDevisor,
                    &LSEOSC,
                    &LSIRC,
                };
                RTCClkSource.nodetype = .multi;
                RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(RADIO_TIMEREnableValue), RADIO_TIMEREnableValue, .true, .@"="))
            {
                std.mem.doNotOptimizeAway(RTCFreq_ValueValue);
                RTCOutput.limit = RTCFreq_ValueLimit;
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
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
                    &Clk16MHzOutput,
                    &ClkSMPSOutput,
                    &CLKSYSOutput,
                    &HSEOSC,
                    &HSIRC,
                    &CLK16RTCDevisor,
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
                std.mem.doNotOptimizeAway(MCO1PinFreq_ValueValue);
                MCOPin.nodetype = .output;
                MCOPin.parents = &.{&MCODiv};
            }

            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.ClkSMPSOutput = try ClkSMPSOutput.get_output();
            out.ClkSMPS = try ClkSMPS.get_output();
            out.ClkSMPSDiv4 = try ClkSMPSDiv4.get_output();
            out.ClkSMPSDiv2 = try ClkSMPSDiv2.get_output();
            out.ClkLPUARTOutput = try ClkLPUARTOutput.get_output();
            out.LPUARTMult = try LPUARTMult.get_output();
            out.BLEOutput = try BLEOutput.get_output();
            out.BLEMult = try BLEMult.get_output();
            out.CLKI2S3Output = try CLKI2S3Output.get_output();
            out.CLKI2S3Mult = try CLKI2S3Mult.get_output();
            out.CLKI2S2Output = try CLKI2S2Output.get_output();
            out.CLKI2S2Mult = try CLKI2S2Mult.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.CLK16RTCDevisor = try CLK16RTCDevisor.get_output();
            out.Clk16MHzOutput = try Clk16MHzOutput.get_output();
            out.CLK16MHzSource = try CLK16MHzSource.get_output();
            out.CLK16MHzDiv2 = try CLK16MHzDiv2.get_output();
            out.CLK16MHzDiv4 = try CLK16MHzDiv4.get_output();
            out.Clk32MHzOutput = try Clk32MHzOutput.get_output();
            out.CLK32MHzSource = try CLK32MHzSource.get_output();
            out.CLK32MHzDiv2 = try CLK32MHzDiv2.get_output();
            out.CLK32MHzDiv1 = try CLK32MHzDiv1.get_output();
            out.CLKSYSOutput = try CLKSYSOutput.get_output();
            out.CLKSYSMult = try CLKSYSMult.get_output();
            out.SYSCLK32Prescaler = try SYSCLK32Prescaler.get_output();
            out.SYSCLK64Prescaler = try SYSCLK64Prescaler.get_output();
            out.TimerOutput = try TimerOutput.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.PLL64RC = try PLL64RC.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.RC64MPLL = try RC64MPLL.get_output();
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.RC64MPLLSource = RC64MPLLSourceValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.CLK_16MHz_Div2 = CLK_16MHz_Div2Value;
            ref_out.CLK_16MHz_Div4 = CLK_16MHz_Div4Value;
            ref_out.Clk16MHzSource = Clk16MHzSourceValue;
            ref_out.CLK_SMPS_Div4 = CLK_SMPS_Div4Value;
            ref_out.CLK_SMPS_Div2 = CLK_SMPS_Div2Value;
            ref_out.ClkSMPSSource = ClkSMPSSourceValue;
            ref_out.LPUARTClockSelection = LPUARTClockSelectionValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.CLK_32MHz_Div1 = CLK_32MHz_Div1Value;
            ref_out.CLK_32MHz_Div2 = CLK_32MHz_Div2Value;
            ref_out.Clk32MHzSource = Clk32MHzSourceValue;
            ref_out.BLEMultSource = BLEMultSourceValue;
            ref_out.SYSCLK32Divider = SYSCLK32DividerValue;
            ref_out.SYSCLK64Divider = SYSCLK64DividerValue;
            ref_out.CLKSYSMultSource = CLKSYSMultSourceValue;
            ref_out.CLKI2S3MultSource = CLKI2S3MultSourceValue;
            ref_out.CLKI2S2MultSource = CLKI2S2MultSourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_CLK_16MHz = RCC_RTC_Clock_Source_FROM_CLK_16MHzValue;
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
            ref_out.EnableLSI = EnableLSIValue;
            ref_out.SysSourceHSEEnable = SysSourceHSEEnableValue;
            ref_out.SYSCLK64Enable = SYSCLK64EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.RADIOEnable = RADIOEnableValue;
            ref_out.I2S3Enable = I2S3EnableValue;
            ref_out.I2S2Enable = I2S2EnableValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.RADIO_TIMEREnable = RADIO_TIMEREnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.HSIUsed = HSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
