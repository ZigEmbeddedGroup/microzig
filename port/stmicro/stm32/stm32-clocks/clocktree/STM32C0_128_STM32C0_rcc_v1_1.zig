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
    RCC_SYSCLKSOURCE_LSE,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_LSI,
    RCC_SYSCLKSOURCE_HSIUSB48,
    RCC_SYSCLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSCLKSOURCE_LSE => 0,
            .RCC_SYSCLKSOURCE_HSE => 1,
            .RCC_SYSCLKSOURCE_LSI => 2,
            .RCC_SYSCLKSOURCE_HSIUSB48 => 3,
            .RCC_SYSCLKSOURCE_HSI => 4,
        };
    }
};
pub const RTCClockSelectionList = enum {
    RCC_RTCCLKSOURCE_HSE_DIV32,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RTCCLKSOURCE_HSE_DIV32 => 0,
            .RCC_RTCCLKSOURCE_LSE => 1,
            .RCC_RTCCLKSOURCE_LSI => 2,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK1,
    RCC_USART1CLKSOURCE_SYSCLK,
    RCC_USART1CLKSOURCE_HSIKER,
    RCC_USART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK1 => 0,
            .RCC_USART1CLKSOURCE_SYSCLK => 1,
            .RCC_USART1CLKSOURCE_HSIKER => 2,
            .RCC_USART1CLKSOURCE_LSE => 3,
        };
    }
};
pub const USBCLockSelectionList = enum {
    RCC_USBCLKSOURCE_HSI48,
    RCC_USBCLKSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USBCLKSOURCE_HSI48 => 0,
            .RCC_USBCLKSOURCE_HSE => 1,
        };
    }
};
pub const I2S1CLockSelectionList = enum {
    RCC_I2S1CLKSOURCE_SYSCLK,
    RCC_I2S1CLKSOURCE_HSIKER,
    RCC_I2S1CLKSOURCE_EXT,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2S1CLKSOURCE_SYSCLK => 0,
            .RCC_I2S1CLKSOURCE_HSIKER => 1,
            .RCC_I2S1CLKSOURCE_EXT => 2,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_SYSCLK,
    RCC_ADCCLKSOURCE_HSIKER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_SYSCLK => 0,
            .RCC_ADCCLKSOURCE_HSIKER => 1,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_SYSCLK,
    RCC_I2C1CLKSOURCE_HSIKER,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_SYSCLK => 1,
            .RCC_I2C1CLKSOURCE_HSIKER => 2,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_SYSCLK => 4,
            .RCC_MCO1SOURCE_HSI48 => 5,
        };
    }
};
pub const RCC_MCO2SourceList = enum {
    RCC_MCO2SOURCE_LSE,
    RCC_MCO2SOURCE_LSI,
    RCC_MCO2SOURCE_HSE,
    RCC_MCO2SOURCE_HSI,
    RCC_MCO2SOURCE_SYSCLK,
    RCC_MCO2SOURCE_HSI48,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO2SOURCE_LSE => 0,
            .RCC_MCO2SOURCE_LSI => 1,
            .RCC_MCO2SOURCE_HSE => 2,
            .RCC_MCO2SOURCE_HSI => 3,
            .RCC_MCO2SOURCE_SYSCLK => 4,
            .RCC_MCO2SOURCE_HSI48 => 5,
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
pub const HSISYSCLKDividerList = enum {
    RCC_HSI_DIV1,
    RCC_HSI_DIV2,
    RCC_HSI_DIV4,
    RCC_HSI_DIV8,
    RCC_HSI_DIV16,
    RCC_HSI_DIV32,
    RCC_HSI_DIV64,
    RCC_HSI_DIV128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSI_DIV1 => 1,
            .RCC_HSI_DIV2 => 2,
            .RCC_HSI_DIV4 => 4,
            .RCC_HSI_DIV8 => 8,
            .RCC_HSI_DIV16 => 16,
            .RCC_HSI_DIV32 => 32,
            .RCC_HSI_DIV64 => 64,
            .RCC_HSI_DIV128 => 128,
        };
    }
};
pub const HSIKERCLKDividerList = enum {
    RCC_HSIKER_DIV1,
    RCC_HSIKER_DIV2,
    RCC_HSIKER_DIV3,
    RCC_HSIKER_DIV4,
    RCC_HSIKER_DIV5,
    RCC_HSIKER_DIV6,
    RCC_HSIKER_DIV7,
    RCC_HSIKER_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSIKER_DIV1 => 1,
            .RCC_HSIKER_DIV2 => 2,
            .RCC_HSIKER_DIV3 => 3,
            .RCC_HSIKER_DIV4 => 4,
            .RCC_HSIKER_DIV5 => 5,
            .RCC_HSIKER_DIV6 => 6,
            .RCC_HSIKER_DIV7 => 7,
            .RCC_HSIKER_DIV8 => 8,
        };
    }
};
pub const SYSDIVList = enum {
    RCC_SYSCLK_DIV1,
    RCC_SYSCLK_DIV2,
    RCC_SYSCLK_DIV3,
    RCC_SYSCLK_DIV4,
    RCC_SYSCLK_DIV5,
    RCC_SYSCLK_DIV6,
    RCC_SYSCLK_DIV7,
    RCC_SYSCLK_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_SYSCLK_DIV1 => 1,
            .RCC_SYSCLK_DIV2 => 2,
            .RCC_SYSCLK_DIV3 => 3,
            .RCC_SYSCLK_DIV4 => 4,
            .RCC_SYSCLK_DIV5 => 5,
            .RCC_SYSCLK_DIV6 => 6,
            .RCC_SYSCLK_DIV7 => 7,
            .RCC_SYSCLK_DIV8 => 8,
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
    RCC_MCODIV_64,
    RCC_MCODIV_128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCODIV_1 => 1,
            .RCC_MCODIV_2 => 2,
            .RCC_MCODIV_4 => 4,
            .RCC_MCODIV_8 => 8,
            .RCC_MCODIV_16 => 16,
            .RCC_MCODIV_32 => 32,
            .RCC_MCODIV_64 => 64,
            .RCC_MCODIV_128 => 128,
        };
    }
};
pub const RCC_MCO2DivList = enum {
    RCC_MCO2DIV_1,
    RCC_MCO2DIV_2,
    RCC_MCO2DIV_4,
    RCC_MCO2DIV_8,
    RCC_MCO2DIV_16,
    RCC_MCO2DIV_32,
    RCC_MCO2DIV_64,
    RCC_MCO2DIV_128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO2DIV_1 => 1,
            .RCC_MCO2DIV_2 => 2,
            .RCC_MCO2DIV_4 => 4,
            .RCC_MCO2DIV_8 => 8,
            .RCC_MCO2DIV_16 => 16,
            .RCC_MCO2DIV_32 => 32,
            .RCC_MCO2DIV_64 => 64,
            .RCC_MCO2DIV_128 => 128,
        };
    }
};
pub const AHBCLKDividerList = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    RCC_HCLK_DIV64,
    RCC_HCLK_DIV128,
    RCC_HCLK_DIV256,
    RCC_HCLK_DIV512,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV1 => 1,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV16 => 16,
            .RCC_HCLK_DIV64 => 64,
            .RCC_HCLK_DIV128 => 128,
            .RCC_HCLK_DIV256 => 256,
            .RCC_HCLK_DIV512 => 512,
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
    RCC_APB1_DIV1,
    RCC_APB1_DIV2,
    RCC_APB1_DIV4,
    RCC_APB1_DIV8,
    RCC_APB1_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_APB1_DIV1 => 1,
            .RCC_APB1_DIV2 => 2,
            .RCC_APB1_DIV4 => 4,
            .RCC_APB1_DIV8 => 8,
            .RCC_APB1_DIV16 => 16,
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
pub const USART1EnableList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const I2S1EnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const MCO2EnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const EnableCSSLSEList = enum {
    true,
    false,
};
pub fn ClockTree(comptime mcu_data: std.StaticStringMap(void)) type {
    return struct {
        pub const Flags = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            OSC_Enabled: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            OSC32_Enabled: bool = false,
            MCOConfig: bool = false,
            MCO2Config: bool = false,
            LSCOConfig: bool = false,
            AudioClockConfig: bool = false,
            CRSActivatedSourceGPIO: bool = false,
            CRSActivatedSourceLSE: bool = false,
            CRSActivatedSourceUSB: bool = false,
            I2C1_Used: bool = false,
            SPI1_Used: bool = false,
            I2S1_Used: bool = false,
            RTC_Used: bool = false,
            IWDG_Used: bool = false,
            USART1_Used: bool = false,
            USB_Used: bool = false,
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
            HSISYSCLKDivider: ?HSISYSCLKDividerList = null,
            HSIKERCLKDivider: ?HSIKERCLKDividerList = null,
            HSE_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            SYSDIV: ?SYSDIVList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            USBCLockSelection: ?USBCLockSelectionList = null,
            I2S1CLockSelection: ?I2S1CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            RCC_MCO2Source: ?RCC_MCO2SourceList = null,
            RCC_MCO2Div: ?RCC_MCO2DivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSIUSB48: f32 = 0,
            HSISYS: f32 = 0,
            HSIKER: f32 = 0,
            HSEOSC: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            SysClkSource: f32 = 0,
            SYSDIV: f32 = 0,
            SysCLKOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            USBMult: f32 = 0,
            USBoutput: f32 = 0,
            I2S1Mult: f32 = 0,
            I2S1output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2S_CKIN: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            MCO2Mult: f32 = 0,
            MCO2Div: f32 = 0,
            MCO2Pin: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            PWRCLKoutput: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APBPrescaler: f32 = 0,
            APBOutput: f32 = 0,
            TimPrescalerAPB: f32 = 0,
            TimPrescOut1: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSISYSCLKDivider: ?HSISYSCLKDividerList = null, //from RCC Clock Config
            HSIKERCLKDivider: ?HSIKERCLKDividerList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            SYSDIV: ?SYSDIVList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from RCC Clock Config
            USBCLockSelection: ?USBCLockSelectionList = null, //from RCC Clock Config
            I2S1CLockSelection: ?I2S1CLockSelectionList = null, //from RCC Clock Config
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            RCC_MCO2Source: ?RCC_MCO2SourceList = null, //from RCC Clock Config
            RCC_MCO2Div: ?RCC_MCO2DivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            INSTRUCTION_CACHE_ENABLE: ?INSTRUCTION_CACHE_ENABLEList = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            DATA_CACHE_ENABLE: ?DATA_CACHE_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
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
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            I2S1Enable: ?I2S1EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            ExtClockEnable: ?ExtClockEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            MCO2Enable: ?MCO2EnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
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

            var SysSourceLse: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourceLsi: bool = false;
            var SysSourceHSI48: bool = false;
            var SysSourceHSI: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var USART1SourcePCLK2: bool = false;
            var USART1SourceSys: bool = false;
            var USART1SourceHSI: bool = false;
            var USART1SourceLSE: bool = false;
            var USBSourceHSI: bool = false;
            var USBSourceHSE: bool = false;
            var I2S1SourceSysclk: bool = false;
            var I2S1SourceHsi: bool = false;
            var I2S1SourceExt: bool = false;
            var ADCSourceSys: bool = false;
            var ADCSourceHsi: bool = false;
            var I2C1SourcePCLK1: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var MCOSourceLSE: bool = false;
            var MCOSourceLSI: bool = false;
            var MCOSourceHSE: bool = false;
            var MCOSourceHSI: bool = false;
            var MCOSourcesys: bool = false;
            var MCOSourceHSI48: bool = false;
            var MCO2SourceLSE: bool = false;
            var MCO2SourceLSI: bool = false;
            var MCO2SourceHSE: bool = false;
            var MCO2SourceHSI: bool = false;
            var MCO2Sourcesys: bool = false;
            var MCO2SourceHSI48: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
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
            var SYSCLKFreq_VALUELimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var ADCFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APBFreq_ValueLimit: Limit = .{};
            var APBTimFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const HSI48_VALUEValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const HSISYSCLKDividerValue: ?HSISYSCLKDividerList = blk: {
                const conf_item = config.HSISYSCLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSI_DIV1 => {},
                        .RCC_HSI_DIV2 => {},
                        .RCC_HSI_DIV4 => {},
                        .RCC_HSI_DIV8 => {},
                        .RCC_HSI_DIV16 => {},
                        .RCC_HSI_DIV32 => {},
                        .RCC_HSI_DIV64 => {},
                        .RCC_HSI_DIV128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSI_DIV4;
            };
            const HSIKERCLKDividerValue: ?HSIKERCLKDividerList = blk: {
                const conf_item = config.HSIKERCLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSIKER_DIV1 => {},
                        .RCC_HSIKER_DIV2 => {},
                        .RCC_HSIKER_DIV3 => {},
                        .RCC_HSIKER_DIV4 => {},
                        .RCC_HSIKER_DIV5 => {},
                        .RCC_HSIKER_DIV6 => {},
                        .RCC_HSIKER_DIV7 => {},
                        .RCC_HSIKER_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_HSIKER_DIV3;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if (config.flags.HSEByPass or config.flags.HSEOscillator) {
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
                                "HSEByPass|HSEOscillator",
                                "HSE Mode",
                                4e6,
                                val,
                            });
                        }
                        if (val > 4.8e7) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Overflow Value - max: {e} found: {e}
                                \\note: ranges values may change depending on the configuration
                                \\
                            , .{
                                "HSE_VALUE",
                                "HSEByPass|HSEOscillator",
                                "HSE Mode",
                                4.8e7,
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
                    if (val > 4.8e7) {
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
                            4.8e7,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 8000000;
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
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_LSE => SysSourceLse = true,
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_LSI => SysSourceLsi = true,
                        .RCC_SYSCLKSOURCE_HSIUSB48 => SysSourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceHSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
            };
            const SYSDIVValue: ?SYSDIVList = blk: {
                const conf_item = config.SYSDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLK_DIV1 => {},
                        .RCC_SYSCLK_DIV2 => {},
                        .RCC_SYSCLK_DIV3 => {},
                        .RCC_SYSCLK_DIV4 => {},
                        .RCC_SYSCLK_DIV5 => {},
                        .RCC_SYSCLK_DIV6 => {},
                        .RCC_SYSCLK_DIV7 => {},
                        .RCC_SYSCLK_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SYSCLK_DIV1;
            };
            const VDD_VALUEValue: ?f32 = blk: {
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
                            "Else",
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
                            "Else",
                            "No Extra Log",
                            3.6e0,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 3.3;
            };
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                if ((check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 1.8, .@"<")) or (check_ref(@TypeOf(VDD_VALUEValue), VDD_VALUEValue, 2.1, .@">"))) {
                    SYSCLKFreq_VALUELimit = .{
                        .min = null,
                        .max = 4.8e7,
                    };
                    break :blk null;
                }
                break :blk 4e6;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 32;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTCCLKSOURCE_LSI => RTCSourceLSI = true,
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => RTCSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    RTCSourceLSI = true;
                    break :blk .RCC_RTCCLKSOURCE_LSI;
                };
            };
            const RTCEnableValue: ?RTCEnableList = blk: {
                if (config.flags.RTC_Used) {
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
                break :blk 3.2e4;
            };
            const WatchDogFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2e4;
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK1 => USART1SourcePCLK2 = true,
                        .RCC_USART1CLKSOURCE_SYSCLK => USART1SourceSys = true,
                        .RCC_USART1CLKSOURCE_HSIKER => USART1SourceHSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse null;
            };
            const USART1Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const USBCLockSelectionValue: ?USBCLockSelectionList = blk: {
                const conf_item = config.USBCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USBCLKSOURCE_HSI48 => USBSourceHSI = true,
                        .RCC_USBCLKSOURCE_HSE => USBSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USBSourceHSI = true;
                    break :blk .RCC_USBCLKSOURCE_HSI48;
                };
            };
            const USBFreq_ValueValue: ?f32 = blk: {
                break :blk 4.8e7;
            };
            const I2S1CLockSelectionValue: ?I2S1CLockSelectionList = blk: {
                const conf_item = config.I2S1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2S1CLKSOURCE_SYSCLK => I2S1SourceSysclk = true,
                        .RCC_I2S1CLKSOURCE_HSIKER => I2S1SourceHsi = true,
                        .RCC_I2S1CLKSOURCE_EXT => I2S1SourceExt = true,
                    }
                }

                break :blk conf_item orelse {
                    I2S1SourceSysclk = true;
                    break :blk .RCC_I2S1CLKSOURCE_SYSCLK;
                };
            };
            const I2S1Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        .RCC_ADCCLKSOURCE_HSIKER => ADCSourceHsi = true,
                    }
                }

                break :blk conf_item orelse {
                    ADCSourceSys = true;
                    break :blk .RCC_ADCCLKSOURCE_SYSCLK;
                };
            };
            const ADCFreq_ValueValue: ?f32 = blk: {
                ADCFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => I2C1SourcePCLK1 = true,
                        .RCC_I2C1CLKSOURCE_SYSCLK => I2C1SourceSys = true,
                        .RCC_I2C1CLKSOURCE_HSIKER => I2C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C1SourcePCLK1 = true;
                    break :blk .RCC_I2C1CLKSOURCE_PCLK1;
                };
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 1.2288e7;
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => MCOSourcesys = true,
                        .RCC_MCO1SOURCE_HSI => MCOSourceHSI = true,
                        .RCC_MCO1SOURCE_HSE => MCOSourceHSE = true,
                        .RCC_MCO1SOURCE_LSE => MCOSourceLSE = true,
                        .RCC_MCO1SOURCE_LSI => MCOSourceLSI = true,
                        .RCC_MCO1SOURCE_HSI48 => MCOSourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    MCOSourcesys = true;
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
                        .RCC_MCODIV_64 => {},
                        .RCC_MCODIV_128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
            };
            const MCO1PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const RCC_MCO2SourceValue: ?RCC_MCO2SourceList = blk: {
                const conf_item = config.RCC_MCO2Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2SOURCE_SYSCLK => MCO2Sourcesys = true,
                        .RCC_MCO2SOURCE_HSI => MCO2SourceHSI = true,
                        .RCC_MCO2SOURCE_HSE => MCO2SourceHSE = true,
                        .RCC_MCO2SOURCE_LSE => MCO2SourceLSE = true,
                        .RCC_MCO2SOURCE_LSI => MCO2SourceLSI = true,
                        .RCC_MCO2SOURCE_HSI48 => MCO2SourceHSI48 = true,
                    }
                }

                break :blk conf_item orelse {
                    MCO2Sourcesys = true;
                    break :blk .RCC_MCO2SOURCE_SYSCLK;
                };
            };
            const RCC_MCO2DivValue: ?RCC_MCO2DivList = blk: {
                const conf_item = config.RCC_MCO2Div;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO2DIV_1 => {},
                        .RCC_MCO2DIV_2 => {},
                        .RCC_MCO2DIV_4 => {},
                        .RCC_MCO2DIV_8 => {},
                        .RCC_MCO2DIV_16 => {},
                        .RCC_MCO2DIV_32 => {},
                        .RCC_MCO2DIV_64 => {},
                        .RCC_MCO2DIV_128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO2DIV_1;
            };
            const MCO2PinFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
            const AHBCLKDividerValue: ?AHBCLKDividerList = blk: {
                const conf_item = config.AHBCLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => AHBCLKDivider1 = true,
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                        .RCC_HCLK_DIV64 => {},
                        .RCC_HCLK_DIV128 => {},
                        .RCC_HCLK_DIV256 => {},
                        .RCC_HCLK_DIV512 => {},
                    }
                }

                break :blk conf_item orelse {
                    AHBCLKDivider1 = true;
                    break :blk .RCC_HCLK_DIV1;
                };
            };
            const PWRFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const HCLKFreq_ValueValue: ?f32 = blk: {
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
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
                break :blk 4e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const APB1CLKDividerValue: ?APB1CLKDividerList = blk: {
                const conf_item = config.APB1CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_APB1_DIV1 => {},
                        .RCC_APB1_DIV2 => {},
                        .RCC_APB1_DIV4 => {},
                        .RCC_APB1_DIV8 => {},
                        .RCC_APB1_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_APB1_DIV1;
            };
            const APBFreq_ValueValue: ?f32 = blk: {
                APBFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
            };
            const APB1TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB1CLKDividerValue), APB1CLKDividerValue, .RCC_APB1_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const APBTimFreq_ValueValue: ?f32 = blk: {
                APBTimFreq_ValueLimit = .{
                    .min = null,
                    .max = 4.8e7,
                };
                break :blk null;
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
            const FLatencyValue: ?FLatencyList = blk: {
                if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"="))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_0 => {},
                            .FLASH_LATENCY_1 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or (check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"="))) {
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
                            , .{ "FLatency", "(HCLKFreq_Value < 48000000) | (HCLKFreq_Value = 48000000)", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                }
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
                        , .{ "FLatency", "Else", "No Extra Log", "FLASH_LATENCY_0", i });
                    }
                }
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
                    if (val > 127) {
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
                            127,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 64;
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
                } else if (!config.flags.CRSActivatedSourceGPIO and !config.flags.CRSActivatedSourceLSE and !config.flags.CRSActivatedSourceUSB) {
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
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i));
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
                    break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
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
                if ((SysSourceLse) or (LSCOSSourceLSE and config.flags.LSCOConfig) or (USART1SourceLSE and config.flags.USART1_Used) or (MCOSourceLSE and config.flags.MCOConfig) or (MCO2SourceLSE and config.flags.MCO2Config) or (RTCSourceLSE and config.flags.RTC_Used)) {
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
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTC_Used and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERTCDevisorList = .false;
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
            const USART1EnableValue: ?USART1EnableList = blk: {
                if (config.flags.USART1_Used) {
                    const item: USART1EnableList = .true;
                    break :blk item;
                }
                const item: USART1EnableList = .false;
                break :blk item;
            };
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USB_Used) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
                break :blk item;
            };
            const I2S1EnableValue: ?I2S1EnableList = blk: {
                if (config.flags.I2S1_Used or config.flags.SPI1_Used) {
                    const item: I2S1EnableList = .true;
                    break :blk item;
                }
                const item: I2S1EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if (check_MCU("ADC1_USED")) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const I2C1EnableValue: ?I2C1EnableList = blk: {
                if (config.flags.I2C1_Used) {
                    const item: I2C1EnableList = .true;
                    break :blk item;
                }
                const item: I2C1EnableList = .false;
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if (config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const MCO2EnableValue: ?MCO2EnableList = blk: {
                if (config.flags.MCO2Config) {
                    const item: MCO2EnableList = .true;
                    break :blk item;
                }
                const item: MCO2EnableList = .false;
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
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and (config.flags.RTC_Used))) {
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

            var HSIRC = ClockNode{
                .name = "HSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIUSB48 = ClockNode{
                .name = "HSIUSB48",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSISYS = ClockNode{
                .name = "HSISYS",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSIKER = ClockNode{
                .name = "HSIKER",
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

            var SysClkSource = ClockNode{
                .name = "SysClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var SYSDIV = ClockNode{
                .name = "SYSDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var SysCLKOutput = ClockNode{
                .name = "SysCLKOutput",
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

            var ADCMult = ClockNode{
                .name = "ADCMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
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

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
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

            var APBPrescaler = ClockNode{
                .name = "APBPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APBOutput = ClockNode{
                .name = "APBOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescalerAPB = ClockNode{
                .name = "TimPrescalerAPB",
                .nodetype = .off,
                .parents = &.{},
            };

            var TimPrescOut1 = ClockNode{
                .name = "TimPrescOut1",
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

            const HSIUSB48_clk_value = HSI48_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIUSB48",
                "Else",
                "No Extra Log",
                "HSI48_VALUE",
            });
            HSIUSB48.nodetype = .source;
            HSIUSB48.value = HSIUSB48_clk_value;

            const HSISYS_clk_value = HSISYSCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSISYS",
                "Else",
                "No Extra Log",
                "HSISYSCLKDivider",
            });
            HSISYS.nodetype = .div;
            HSISYS.value = HSISYS_clk_value.get();
            HSISYS.parents = &.{&HSIRC};

            const HSIKER_clk_value = HSIKERCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSIKER",
                "Else",
                "No Extra Log",
                "HSIKERCLKDivider",
            });
            HSIKER.nodetype = .div;
            HSIKER.value = HSIKER_clk_value.get();
            HSIKER.parents = &.{&HSIRC};

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
                &LSEOSC,
                &HSEOSC,
                &LSIRC,
                &HSIUSB48,
                &HSISYS,
            };
            SysClkSource.nodetype = .multi;
            SysClkSource.parents = &.{SysClkSourceparents[SysClkSource_clk_value.get()]};

            const SYSDIV_clk_value = SYSDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "SYSDIV",
                "Else",
                "No Extra Log",
                "SYSDIV",
            });
            SYSDIV.nodetype = .div;
            SYSDIV.value = SYSDIV_clk_value.get();
            SYSDIV.parents = &.{&SysClkSource};

            std.mem.doNotOptimizeAway(SYSCLKFreq_VALUEValue);
            SysCLKOutput.limit = SYSCLKFreq_VALUELimit;
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SYSDIV};
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
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                const USART1Mult_clk_value = USART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART1Mult",
                    "Else",
                    "No Extra Log",
                    "USART1CLockSelection",
                });
                const USART1Multparents = [_]*const ClockNode{
                    &APBPrescaler,
                    &SysCLKOutput,
                    &HSIKER,
                    &LSEOSC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
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
                    &HSIUSB48,
                    &HSEOSC,
                };
                USBMult.nodetype = .multi;
                USBMult.parents = &.{USBMultparents[USBMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&USBMult};
            }
            if (check_ref(@TypeOf(I2S1EnableValue), I2S1EnableValue, .true, .@"=")) {
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
                    &SysCLKOutput,
                    &HSIKER,
                    &I2S_CKIN,
                };
                I2S1Mult.nodetype = .multi;
                I2S1Mult.parents = &.{I2S1Multparents[I2S1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2S1EnableValue), I2S1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2S1Freq_ValueValue);
                I2S1output.nodetype = .output;
                I2S1output.parents = &.{&I2S1Mult};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                const ADCMult_clk_value = ADCCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &SysCLKOutput,
                    &HSIKER,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADCFreq_ValueValue);
                ADCoutput.limit = ADCFreq_ValueLimit;
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                const I2C1Mult_clk_value = I2C1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
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
                    &APBPrescaler,
                    &SysCLKOutput,
                    &HSIKER,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1output.nodetype = .output;
                I2C1output.parents = &.{&I2C1Mult};
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
                    &LSEOSC,
                    &LSIRC,
                    &HSEOSC,
                    &HSIRC,
                    &SysCLKOutput,
                    &HSIUSB48,
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
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
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
                    &LSEOSC,
                    &LSIRC,
                    &HSEOSC,
                    &HSIRC,
                    &SysCLKOutput,
                    &HSIUSB48,
                };
                MCO2Mult.nodetype = .multi;
                MCO2Mult.parents = &.{MCO2Multparents[MCO2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                const MCO2Div_clk_value = RCC_MCO2DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCO2Div",
                    "Else",
                    "No Extra Log",
                    "RCC_MCO2Div",
                });
                MCO2Div.nodetype = .div;
                MCO2Div.value = MCO2Div_clk_value.get();
                MCO2Div.parents = &.{&MCO2Mult};
            }
            if (check_ref(@TypeOf(MCO2EnableValue), MCO2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCO2PinFreq_ValueValue);
                MCO2Pin.nodetype = .output;
                MCO2Pin.parents = &.{&MCO2Div};
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

            const APBPrescaler_clk_value = APB1CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APBPrescaler",
                "Else",
                "No Extra Log",
                "APB1CLKDivider",
            });
            APBPrescaler.nodetype = .div;
            APBPrescaler.value = APBPrescaler_clk_value.get();
            APBPrescaler.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(APBFreq_ValueValue);
            APBOutput.limit = APBFreq_ValueLimit;
            APBOutput.nodetype = .output;
            APBOutput.parents = &.{&APBPrescaler};

            const TimPrescalerAPB_clk_value = APB1TimCLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimPrescalerAPB",
                "Else",
                "No Extra Log",
                "APB1TimCLKDivider",
            });
            TimPrescalerAPB.nodetype = .mul;
            TimPrescalerAPB.value = TimPrescalerAPB_clk_value;
            TimPrescalerAPB.parents = &.{&APBPrescaler};

            std.mem.doNotOptimizeAway(APBTimFreq_ValueValue);
            TimPrescOut1.limit = APBTimFreq_ValueLimit;
            TimPrescOut1.nodetype = .output;
            TimPrescOut1.parents = &.{&TimPrescalerAPB};

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APBOutput = try APBOutput.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB = try TimPrescalerAPB.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.APBPrescaler = try APBPrescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.PWRCLKoutput = try PWRCLKoutput.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.I2S1output = try I2S1output.get_output();
            out.I2S1Mult = try I2S1Mult.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.MCO2Pin = try MCO2Pin.get_output();
            out.MCO2Div = try MCO2Div.get_output();
            out.MCO2Mult = try MCO2Mult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SYSDIV = try SYSDIV.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.HSISYS = try HSISYS.get_output();
            out.HSIKER = try HSIKER.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.USBMult = try USBMult.get_output();
            out.HSIUSB48 = try HSIUSB48.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            ref_out.HSISYSCLKDivider = HSISYSCLKDividerValue;
            ref_out.HSIKERCLKDivider = HSIKERCLKDividerValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.SYSDIV = SYSDIVValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.USBCLockSelection = USBCLockSelectionValue;
            ref_out.I2S1CLockSelection = I2S1CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.RCC_MCO2Source = RCC_MCO2SourceValue;
            ref_out.RCC_MCO2Div = RCC_MCO2DivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.INSTRUCTION_CACHE_ENABLE = INSTRUCTION_CACHE_ENABLEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.DATA_CACHE_ENABLE = DATA_CACHE_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
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
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.I2S1Enable = I2S1EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.ExtClockEnable = ExtClockEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.MCO2Enable = MCO2EnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
