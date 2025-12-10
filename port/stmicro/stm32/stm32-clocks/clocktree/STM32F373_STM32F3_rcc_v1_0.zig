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
pub const RCC_MCOSourceList = enum {
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_PLLCLK_DIV2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_SYSCLK => 0,
            .RCC_MCO1SOURCE_HSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_LSI => 3,
            .RCC_MCO1SOURCE_LSE => 4,
            .RCC_MCO1SOURCE_PLLCLK_DIV2 => 5,
        };
    }
};
pub const I2c1ClockSelectionList = enum {
    RCC_I2C1CLKSOURCE_HSI,
    RCC_I2C1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_HSI => 0,
            .RCC_I2C1CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const I2c2ClockSelectionList = enum {
    RCC_I2C2CLKSOURCE_HSI,
    RCC_I2C2CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C2CLKSOURCE_HSI => 0,
            .RCC_I2C2CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const Usart1ClockSelectionList = enum {
    RCC_USART1CLKSOURCE_SYSCLK,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_LSE,
    RCC_USART1CLKSOURCE_PCLK2,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_SYSCLK => 0,
            .RCC_USART1CLKSOURCE_HSI => 1,
            .RCC_USART1CLKSOURCE_LSE => 2,
            .RCC_USART1CLKSOURCE_PCLK2 => 3,
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
pub const Usart3ClockSelectionList = enum {
    RCC_USART3CLKSOURCE_SYSCLK,
    RCC_USART3CLKSOURCE_HSI,
    RCC_USART3CLKSOURCE_LSE,
    RCC_USART3CLKSOURCE_PCLK1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART3CLKSOURCE_SYSCLK => 0,
            .RCC_USART3CLKSOURCE_HSI => 1,
            .RCC_USART3CLKSOURCE_LSE => 2,
            .RCC_USART3CLKSOURCE_PCLK1 => 3,
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
pub const RCC_PLLsource_Clock_Source_FROM_HSEList = enum {
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
pub const PRESCALERUSBList = enum {
    RCC_USBCLKSOURCE_PLL,
    RCC_USBCLKSOURCE_PLL_DIV1_5,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL => 1,
            .RCC_USBCLKSOURCE_PLL_DIV1_5 => 1.5,
        };
    }
};
pub const SDADCPrescList = enum {
    RCC_SDADCSYSCLK_DIV2,
    RCC_SDADCSYSCLK_DIV4,
    RCC_SDADCSYSCLK_DIV6,
    RCC_SDADCSYSCLK_DIV8,
    RCC_SDADCSYSCLK_DIV10,
    RCC_SDADCSYSCLK_DIV12,
    RCC_SDADCSYSCLK_DIV14,
    RCC_SDADCSYSCLK_DIV16,
    RCC_SDADCSYSCLK_DIV20,
    RCC_SDADCSYSCLK_DIV24,
    RCC_SDADCSYSCLK_DIV28,
    RCC_SDADCSYSCLK_DIV32,
    RCC_SDADCSYSCLK_DIV36,
    RCC_SDADCSYSCLK_DIV40,
    RCC_SDADCSYSCLK_DIV44,
    RCC_SDADCSYSCLK_DIV48,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_SDADCSYSCLK_DIV2 => 2,
            .RCC_SDADCSYSCLK_DIV4 => 4,
            .RCC_SDADCSYSCLK_DIV6 => 6,
            .RCC_SDADCSYSCLK_DIV8 => 8,
            .RCC_SDADCSYSCLK_DIV10 => 10,
            .RCC_SDADCSYSCLK_DIV12 => 12,
            .RCC_SDADCSYSCLK_DIV14 => 14,
            .RCC_SDADCSYSCLK_DIV16 => 16,
            .RCC_SDADCSYSCLK_DIV20 => 20,
            .RCC_SDADCSYSCLK_DIV24 => 24,
            .RCC_SDADCSYSCLK_DIV28 => 28,
            .RCC_SDADCSYSCLK_DIV32 => 32,
            .RCC_SDADCSYSCLK_DIV36 => 36,
            .RCC_SDADCSYSCLK_DIV40 => 40,
            .RCC_SDADCSYSCLK_DIV44 => 44,
            .RCC_SDADCSYSCLK_DIV48 => 48,
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
pub const ADCPrescList = enum {
    RCC_ADC1PCLK2_DIV2,
    RCC_ADC1PCLK2_DIV4,
    RCC_ADC1PCLK2_DIV6,
    RCC_ADC1PCLK2_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADC1PCLK2_DIV2 => 2,
            .RCC_ADC1PCLK2_DIV4 => 4,
            .RCC_ADC1PCLK2_DIV6 => 6,
            .RCC_ADC1PCLK2_DIV8 => 8,
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
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_LOW,
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const EnableLSEList = enum {
    true,
    false,
};
pub const CECEnableList = enum {
    true,
    false,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
    true,
    false,
};
pub const SDADCEnableList = enum {
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
pub const MCOEnableList = enum {
    true,
    false,
};
pub const ADC1EnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const I2C2EnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const USART2EnableList = enum {
    true,
    false,
};
pub const USART3EnableList = enum {
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
            AudioClockConfig: bool = false,
            USBUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            CECUsed_ForRCC: bool = false,
            USE_SDADC1: bool = false,
            USE_SDADC2: bool = false,
            USE_SDADC3: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USE_ADC1: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            CSSEnabled: bool = false,
            MCOUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            VDD_VALUE: ?f32 = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            LSE_VALUE: ?f32 = null,
            CECClockSelection: ?CECClockSelectionList = null,
            HSE_VALUE: ?f32 = null,
            RCC_PLLsource_Clock_Source_FROM_HSE: ?RCC_PLLsource_Clock_Source_FROM_HSEList = null,
            PRESCALERUSB: ?PRESCALERUSBList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            SDADCPresc: ?SDADCPrescList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            ADCPresc: ?ADCPrescList = null,
            I2c1ClockSelection: ?I2c1ClockSelectionList = null,
            I2c2ClockSelection: ?I2c2ClockSelectionList = null,
            Usart1ClockSelection: ?Usart1ClockSelectionList = null,
            Usart2ClockSelection: ?Usart2ClockSelectionList = null,
            Usart3ClockSelection: ?Usart3ClockSelectionList = null,
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
            HSIRCDiv: f32 = 0,
            HSICECDiv: f32 = 0,
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            CECMult: f32 = 0,
            CECOutput: f32 = 0,
            HSEOSC: f32 = 0,
            HSEPLLsourceDevisor: f32 = 0,
            PRESCALERUSB: f32 = 0,
            USBoutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            SDADCPresc: f32 = 0,
            SDADCoutput: f32 = 0,
            PWROutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
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
            ADCPresc: f32 = 0,
            ADCoutput: f32 = 0,
            APB2Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1Output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2Output: f32 = 0,
            USART1Mult: f32 = 0,
            USART1Output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2Output: f32 = 0,
            USART3Mult: f32 = 0,
            USART3Output: f32 = 0,
            PLLSource: f32 = 0,
            VCO2output: f32 = 0,
            PLLMUL: f32 = 0,
            HSI_CEC: f32 = 0,
            HSI_PLL: f32 = 0,
            HSE_PLL: f32 = 0,
            HSE_RTC: f32 = 0,
            PLLCLK_MCO: f32 = 0,
            PLLCLK: f32 = 0,
            Tim2CLK: f32 = 0,
            I2C2CLK: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSIRCDiv: ?f32 = null, //from RCC Clock Config
            HSICECDiv: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            CECClockSelection: ?CECClockSelectionList = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_PLLsource_Clock_Source_FROM_HSE: ?RCC_PLLsource_Clock_Source_FROM_HSEList = null, //from RCC Clock Config
            PRESCALERUSB: ?PRESCALERUSBList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from RCC Clock Config
            SDADCPresc: ?SDADCPrescList = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCOMult_Clock_Source_FROM_PLLMUL: ?f32 = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            ADCPresc: ?ADCPrescList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            I2c1ClockSelection: ?I2c1ClockSelectionList = null, //from RCC Clock Config
            I2c2ClockSelection: ?I2c2ClockSelectionList = null, //from RCC Clock Config
            Usart1ClockSelection: ?Usart1ClockSelectionList = null, //from RCC Clock Config
            Usart2ClockSelection: ?Usart2ClockSelectionList = null, //from RCC Clock Config
            Usart3ClockSelection: ?Usart3ClockSelectionList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            LSEUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            EnableLSE: ?EnableLSEList = null, //from extra RCC references
            CECEnable: ?CECEnableList = null, //from extra RCC references
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            USBEnable: ?USBEnableList = null, //from extra RCC references
            SDADCEnable: ?SDADCEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            ADC1Enable: ?ADC1EnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C2Enable: ?I2C2EnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART3Enable: ?USART3EnableList = null, //from extra RCC references
            EnableMCOMultDivisor: ?EnableMCOMultDivisorList = null, //from extra RCC references
            EnableLSERTC: ?EnableLSERTCList = null, //from extra RCC references
            HSEUsed: ?f32 = null, //from extra RCC references
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

            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C2SourceHSI: bool = false;
            var HSEDiv1: bool = false;
            var HSEDiv2: bool = false;
            var HSEDiv3: bool = false;
            var HSEDiv4: bool = false;
            var HSEDiv5: bool = false;
            var HSEDiv6: bool = false;
            var HSEDiv7: bool = false;
            var HSEDiv8: bool = false;
            var HSEDiv9: bool = false;
            var HSEDiv10: bool = false;
            var HSEDiv11: bool = false;
            var HSEDiv12: bool = false;
            var HSEDiv13: bool = false;
            var HSEDiv14: bool = false;
            var HSEDiv15: bool = false;
            var HSEDiv16: bool = false;
            var HCLKDiv1: bool = false;
            var FLASH_LATENCY0: bool = false;
            var USBFreq_ValueLimit: Limit = .{};
            var SDADCoutputFreq_ValueLimit: Limit = .{};
            var RTCFreq_ValueLimit: Limit = .{};
            var HCLKFreq_ValueLimit: Limit = .{};
            var APB1Freq_ValueLimit: Limit = .{};
            var APB2Freq_ValueLimit: Limit = .{};
            var VCOOutput2Freq_ValueLimit: Limit = .{};
            var PLLCLKFreq_ValueLimit: Limit = .{};
            //Ref Values

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const FLITFCLKFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const HSIRCDivValue: ?f32 = blk: {
                break :blk 2;
            };
            const HSICECDivValue: ?f32 = blk: {
                break :blk 244;
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
            const CECFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2786e4;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                const conf_item = config.SYSCLKSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSCLKSOURCE_HSI => SysSourceHSI = true,
                        .RCC_SYSCLKSOURCE_HSE => SysSourceHSE = true,
                        .RCC_SYSCLKSOURCE_PLLCLK => SysSourcePLL = true,
                    }
                }

                break :blk conf_item orelse {
                    SysSourceHSI = true;
                    break :blk .RCC_SYSCLKSOURCE_HSI;
                };
            };
            const RCC_MCOSourceValue: ?RCC_MCOSourceList = blk: {
                const conf_item = config.RCC_MCOSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_HSE => {},
                        .RCC_MCO1SOURCE_LSI => {},
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_PLLCLK_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (((check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_PLLCLK_DIV2, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig)) or config.flags.USBUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSE_VALUEValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) or (config.flags.CSSEnabled))) and config.flags.HSEByPass) {
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
                                "(((PLLUsed=1)|(CSSEnabled))) & HSEByPass ",
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
                                "(((PLLUsed=1)|(CSSEnabled))) & HSEByPass ",
                                "HSE in bypass Mode",
                                3.2e7,
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
                                "HSEByPass",
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
                                "HSEByPass",
                                "HSE in bypass Mode",
                                3.2e7,
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
                break :blk config_val orelse 8000000;
            };
            const RCC_PLLsource_Clock_Source_FROM_HSEValue: ?RCC_PLLsource_Clock_Source_FROM_HSEList = blk: {
                const conf_item = config.RCC_PLLsource_Clock_Source_FROM_HSE;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSE_PREDIV_DIV1 => HSEDiv1 = true,
                        .RCC_HSE_PREDIV_DIV2 => HSEDiv2 = true,
                        .RCC_HSE_PREDIV_DIV3 => HSEDiv3 = true,
                        .RCC_HSE_PREDIV_DIV4 => HSEDiv4 = true,
                        .RCC_HSE_PREDIV_DIV5 => HSEDiv5 = true,
                        .RCC_HSE_PREDIV_DIV6 => HSEDiv6 = true,
                        .RCC_HSE_PREDIV_DIV7 => HSEDiv7 = true,
                        .RCC_HSE_PREDIV_DIV8 => HSEDiv8 = true,
                        .RCC_HSE_PREDIV_DIV9 => HSEDiv9 = true,
                        .RCC_HSE_PREDIV_DIV10 => HSEDiv10 = true,
                        .RCC_HSE_PREDIV_DIV11 => HSEDiv11 = true,
                        .RCC_HSE_PREDIV_DIV12 => HSEDiv12 = true,
                        .RCC_HSE_PREDIV_DIV13 => HSEDiv13 = true,
                        .RCC_HSE_PREDIV_DIV14 => HSEDiv14 = true,
                        .RCC_HSE_PREDIV_DIV15 => HSEDiv15 = true,
                        .RCC_HSE_PREDIV_DIV16 => HSEDiv16 = true,
                    }
                }

                break :blk conf_item orelse {
                    HSEDiv1 = true;
                    break :blk .RCC_HSE_PREDIV_DIV1;
                };
            };
            const PRESCALERUSBValue: ?PRESCALERUSBList = blk: {
                const conf_item = config.PRESCALERUSB;
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
            const SYSCLKFreq_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const SDADCPrescValue: ?SDADCPrescList = blk: {
                const conf_item = config.SDADCPresc;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SDADCSYSCLK_DIV2 => {},
                        .RCC_SDADCSYSCLK_DIV4 => {},
                        .RCC_SDADCSYSCLK_DIV6 => {},
                        .RCC_SDADCSYSCLK_DIV8 => {},
                        .RCC_SDADCSYSCLK_DIV10 => {},
                        .RCC_SDADCSYSCLK_DIV12 => {},
                        .RCC_SDADCSYSCLK_DIV14 => {},
                        .RCC_SDADCSYSCLK_DIV16 => {},
                        .RCC_SDADCSYSCLK_DIV20 => {},
                        .RCC_SDADCSYSCLK_DIV24 => {},
                        .RCC_SDADCSYSCLK_DIV28 => {},
                        .RCC_SDADCSYSCLK_DIV32 => {},
                        .RCC_SDADCSYSCLK_DIV36 => {},
                        .RCC_SDADCSYSCLK_DIV40 => {},
                        .RCC_SDADCSYSCLK_DIV44 => {},
                        .RCC_SDADCSYSCLK_DIV48 => {},
                    }
                }

                break :blk conf_item orelse .RCC_SDADCSYSCLK_DIV2;
            };
            const SDADCoutputFreq_ValueValue: ?f32 = blk: {
                SDADCoutputFreq_ValueLimit = .{
                    .min = 5e5,
                    .max = 6e6,
                };

                break :blk null;
            };
            const PWRFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 32;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_LSE => {},
                        .RCC_RTCCLKSOURCE_LSI => {},
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => {},
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
            const MCOFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
                HCLKFreq_ValueLimit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };
            const AHBFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const FCLKCortexFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
                } else if (config.flags.RTCUsed_ForRCC and !config.flags.USBUsed_ForRCC) {
                    const min: ?f32 = RTCFreq_ValueValue;
                    const max: ?f32 = @min(36000000, std.math.floatMax(f32));
                    APB1Freq_ValueLimit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                APB1Freq_ValueLimit = .{
                    .min = null,
                    .max = 3.6e7,
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
            const ADCPrescValue: ?ADCPrescList = blk: {
                const conf_item = config.ADCPresc;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADC1PCLK2_DIV2 => {},
                        .RCC_ADC1PCLK2_DIV4 => {},
                        .RCC_ADC1PCLK2_DIV6 => {},
                        .RCC_ADC1PCLK2_DIV8 => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADC1PCLK2_DIV2;
            };
            const ADCoutputFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const APB2Freq_ValueValue: ?f32 = blk: {
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
            const I2c1ClockSelectionValue: ?I2c1ClockSelectionList = blk: {
                const conf_item = config.I2c1ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_SYSCLK => {},
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C1SourceHSI = true;
                    break :blk .RCC_I2C1CLKSOURCE_HSI;
                };
            };
            const I2C1Freq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const I2c2ClockSelectionValue: ?I2c2ClockSelectionList = blk: {
                const conf_item = config.I2c2ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C2CLKSOURCE_SYSCLK => {},
                        .RCC_I2C2CLKSOURCE_HSI => I2C2SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C2SourceHSI = true;
                    break :blk .RCC_I2C2CLKSOURCE_HSI;
                };
            };
            const I2C2Freq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
                break :blk 8e6;
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
                break :blk 8e6;
            };
            const Usart3ClockSelectionValue: ?Usart3ClockSelectionList = blk: {
                const conf_item = config.Usart3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART3CLKSOURCE_PCLK1 => {},
                        .RCC_USART3CLKSOURCE_SYSCLK => {},
                        .RCC_USART3CLKSOURCE_HSI => {},
                        .RCC_USART3CLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_USART3CLKSOURCE_PCLK1;
            };
            const USART3Freq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
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
            const VCOOutput2Freq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput2Freq_ValueLimit = .{
                        .min = 1e6,
                        .max = 2.4e7,
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
            const HSICECFreq_ValueValue: ?f32 = blk: {
                break :blk 3.2786e4;
            };
            const HSIPLLFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const HSEPLLFreq_ValueValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const RTCHSEDivFreq_ValueValue: ?f32 = blk: {
                break :blk 2.5e5;
            };
            const PLLMCOFreq_ValueValue: ?f32 = blk: {
                break :blk 4e6;
            };
            const PLLCLKFreq_ValueValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLKFreq_ValueLimit = .{
                        .min = 1.6e7,
                        .max = 7.2e7,
                    };

                    break :blk null;
                }
                break :blk 8e6;
            };
            const VDD_VALUEValue: ?f32 = blk: {
                if (!check_MCU("STM32F3x8")) {
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
                                "!STM32F3x8",
                                "HCLK2 not changed",
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
                                "!STM32F3x8",
                                "HCLK2 not changed",
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
                    if (val > 1.95e0) {
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
                            1.95e0,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 1.8;
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
            const FLatencyValue: ?FLatencyList = blk: {
                if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 0, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@"=")))))) {
                    FLASH_LATENCY0 = true;
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 24000000, .@">")) and ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"<")) or ((check_ref(@TypeOf(HCLKFreq_ValueValue), HCLKFreq_ValueValue, 48000000, .@"=")))))) {
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
            const LSEUsedValue: ?f32 = blk: {
                if (((config.flags.USART1Used_ForRCC and (check_ref(@TypeOf(Usart1ClockSelectionValue), Usart1ClockSelectionValue, .RCC_USART1CLKSOURCE_LSE, .@"="))) or (config.flags.USART2Used_ForRCC and (check_ref(@TypeOf(Usart2ClockSelectionValue), Usart2ClockSelectionValue, .RCC_USART2CLKSOURCE_LSE, .@"="))) or (config.flags.USART3Used_ForRCC and (check_ref(@TypeOf(Usart3ClockSelectionValue), Usart3ClockSelectionValue, .RCC_USART3CLKSOURCE_LSE, .@"="))) or (config.flags.CECUsed_ForRCC and (check_ref(@TypeOf(CECClockSelectionValue), CECClockSelectionValue, .RCC_CECCLKSOURCE_LSE, .@"="))) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig)) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=") and config.flags.RTCUsed_ForRCC))) {
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
            const EnableLSEValue: ?EnableLSEList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: EnableLSEList = .true;
                    break :blk item;
                }
                const item: EnableLSEList = .false;
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
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
            const SDADCEnableValue: ?SDADCEnableList = blk: {
                if (config.flags.USE_SDADC1 or config.flags.USE_SDADC2 or config.flags.USE_SDADC3) {
                    const item: SDADCEnableList = .true;
                    break :blk item;
                }
                const item: SDADCEnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERTCDevisorList = .true;
                    break :blk item;
                } else if (config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass)) {
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
                if ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const ADC1EnableValue: ?ADC1EnableList = blk: {
                if (config.flags.USE_ADC1) {
                    const item: ADC1EnableList = .true;
                    break :blk item;
                }
                const item: ADC1EnableList = .false;
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
            const I2C2EnableValue: ?I2C2EnableList = blk: {
                if (config.flags.I2C2Used_ForRCC) {
                    const item: I2C2EnableList = .true;
                    break :blk item;
                }
                const item: I2C2EnableList = .false;
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
            const USART2EnableValue: ?USART2EnableList = blk: {
                if (config.flags.USART2Used_ForRCC) {
                    const item: USART2EnableList = .true;
                    break :blk item;
                }
                const item: USART2EnableList = .false;
                break :blk item;
            };
            const USART3EnableValue: ?USART3EnableList = blk: {
                if (config.flags.USART3Used_ForRCC) {
                    const item: USART3EnableList = .true;
                    break :blk item;
                }
                const item: USART3EnableList = .false;
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
                if (config.flags.RTCUsed_ForRCC and (config.flags.LSEOscillator or config.flags.LSEByPass)) {
                    const item: EnableLSERTCList = .true;
                    break :blk item;
                }
                const item: EnableLSERTCList = .false;
                break :blk item;
            };
            const HSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_HSE_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or ((config.flags.RTCUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC)) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (config.flags.CECUsed_ForRCC and (check_ref(@TypeOf(CECClockSelectionValue), CECClockSelectionValue, .RCC_CECCLKSOURCE_HSI, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM14") and check_MCU("TIM14") and check_MCU("Semaphore_input_Channel1TIM14")) or config.flags.MCOConfig)) or (config.flags.USART1Used_ForRCC and (check_ref(@TypeOf(Usart1ClockSelectionValue), Usart1ClockSelectionValue, .RCC_USART1CLKSOURCE_HSI, .@"="))) or (config.flags.USART2Used_ForRCC and (check_ref(@TypeOf(Usart2ClockSelectionValue), Usart2ClockSelectionValue, .RCC_USART2CLKSOURCE_HSI, .@"="))) or (config.flags.USART3Used_ForRCC and (check_ref(@TypeOf(Usart3ClockSelectionValue), Usart3ClockSelectionValue, .RCC_USART3CLKSOURCE_HSI, .@"="))) or (config.flags.I2C1Used_ForRCC and (I2C1SourceHSI)) or (config.flags.I2C2Used_ForRCC and (I2C2SourceHSI)))) {
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

            var HSIRCDiv = ClockNode{
                .name = "HSIRCDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSICECDiv = ClockNode{
                .name = "HSICECDiv",
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

            var HSEOSC = ClockNode{
                .name = "HSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSEPLLsourceDevisor = ClockNode{
                .name = "HSEPLLsourceDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var PRESCALERUSB = ClockNode{
                .name = "PRESCALERUSB",
                .nodetype = .off,
                .parents = &.{},
            };

            var USBoutput = ClockNode{
                .name = "USBoutput",
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

            var SDADCPresc = ClockNode{
                .name = "SDADCPresc",
                .nodetype = .off,
                .parents = &.{},
            };

            var SDADCoutput = ClockNode{
                .name = "SDADCoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PWROutput = ClockNode{
                .name = "PWROutput",
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

            var ADCPresc = ClockNode{
                .name = "ADCPresc",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADCoutput = ClockNode{
                .name = "ADCoutput",
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

            var I2C2Mult = ClockNode{
                .name = "I2C2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C2Output = ClockNode{
                .name = "I2C2Output",
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

            var USART3Mult = ClockNode{
                .name = "USART3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART3Output = ClockNode{
                .name = "USART3Output",
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

            var HSI_CEC = ClockNode{
                .name = "HSI_CEC",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSI_PLL = ClockNode{
                .name = "HSI_PLL",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSE_PLL = ClockNode{
                .name = "HSE_PLL",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSE_RTC = ClockNode{
                .name = "HSE_RTC",
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
            HSIRCDiv.value = HSIRCDiv_clk_value;
            HSIRCDiv.parents = &.{&HSIRC};

            const HSICECDiv_clk_value = HSICECDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "HSICECDiv",
                "Else",
                "No Extra Log",
                "HSICECDiv",
            });
            HSICECDiv.nodetype = .div;
            HSICECDiv.value = HSICECDiv_clk_value;
            HSICECDiv.parents = &.{&HSIRC};

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
                    &HSICECDiv,
                    &LSEOSC,
                };
                CECMult.nodetype = .multi;
                CECMult.parents = &.{CECMultparents[CECMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(CECEnableValue), CECEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(CECFreq_ValueValue);
                CECOutput.nodetype = .output;
                CECOutput.parents = &.{&CECMult};
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
                const HSEPLLsourceDevisor_clk_value = RCC_PLLsource_Clock_Source_FROM_HSEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSEPLLsourceDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_PLLsource_Clock_Source_FROM_HSE",
                });
                HSEPLLsourceDevisor.nodetype = .div;
                HSEPLLsourceDevisor.value = HSEPLLsourceDevisor_clk_value.get();
                HSEPLLsourceDevisor.parents = &.{&HSEOSC};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                const PRESCALERUSB_clk_value = PRESCALERUSBValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PRESCALERUSB",
                    "Else",
                    "No Extra Log",
                    "PRESCALERUSB",
                });
                PRESCALERUSB.nodetype = .div;
                PRESCALERUSB.value = PRESCALERUSB_clk_value.get();
                PRESCALERUSB.parents = &.{&PLLMUL};
            }
            if (check_ref(@TypeOf(USBEnableValue), USBEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USBFreq_ValueValue);
                USBoutput.limit = USBFreq_ValueLimit;
                USBoutput.nodetype = .output;
                USBoutput.parents = &.{&PRESCALERUSB};
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
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
            if (check_ref(@TypeOf(SDADCEnableValue), SDADCEnableValue, .true, .@"=")) {
                const SDADCPresc_clk_value = SDADCPrescValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SDADCPresc",
                    "Else",
                    "No Extra Log",
                    "SDADCPresc",
                });
                SDADCPresc.nodetype = .div;
                SDADCPresc.value = SDADCPresc_clk_value.get();
                SDADCPresc.parents = &.{&SysCLKOutput};
            }
            if (check_ref(@TypeOf(SDADCEnableValue), SDADCEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(SDADCoutputFreq_ValueValue);
                SDADCoutput.limit = SDADCoutputFreq_ValueLimit;
                SDADCoutput.nodetype = .output;
                SDADCoutput.parents = &.{&SDADCPresc};
            }

            std.mem.doNotOptimizeAway(PWRFreq_ValueValue);
            PWROutput.nodetype = .output;
            PWROutput.parents = &.{&SysCLKOutput};
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
                    &SysCLKOutput,
                    &HSIRC,
                    &HSEOSC,
                    &LSIRC,
                    &LSEOSC,
                    &MCOMultDivisor,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(MCOFreq_ValueValue);
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

            std.mem.doNotOptimizeAway(AHBFreq_ValueValue);
            HCLKOutput.nodetype = .output;
            HCLKOutput.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(FCLKCortexFreq_ValueValue);
            FCLKCortexOutput.nodetype = .output;
            FCLKCortexOutput.parents = &.{&AHBOutput};

            const TimSysPresc_clk_value = Cortex_DivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TimSysPresc",
                "Else",
                "No Extra Log",
                "Cortex_Div",
            });
            TimSysPresc.nodetype = .div;
            TimSysPresc.value = TimSysPresc_clk_value.get();
            TimSysPresc.parents = &.{&AHBOutput};

            std.mem.doNotOptimizeAway(CortexFreq_ValueValue);
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
            if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=")) {
                const ADCPresc_clk_value = ADCPrescValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADCPresc",
                    "Else",
                    "No Extra Log",
                    "ADCPresc",
                });
                ADCPresc.nodetype = .div;
                ADCPresc.value = ADCPresc_clk_value.get();
                ADCPresc.parents = &.{&APB2Prescaler};
            }
            if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(ADCoutputFreq_ValueValue);
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCPresc};
            }

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
                    &HSIRC,
                    &SysCLKOutput,
                };
                I2C1Mult.nodetype = .multi;
                I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C1Freq_ValueValue);
                I2C1Output.nodetype = .output;
                I2C1Output.parents = &.{&I2C1Mult};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
                const I2C2Mult_clk_value = I2c2ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C2Mult",
                    "Else",
                    "No Extra Log",
                    "I2c2ClockSelection",
                });
                const I2C2Multparents = [_]*const ClockNode{
                    &HSIRC,
                    &SysCLKOutput,
                };
                I2C2Mult.nodetype = .multi;
                I2C2Mult.parents = &.{I2C2Multparents[I2C2Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C2EnableValue), I2C2EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(I2C2Freq_ValueValue);
                I2C2Output.nodetype = .output;
                I2C2Output.parents = &.{&I2C2Mult};
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
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                    &APB2Prescaler,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART1Freq_ValueValue);
                USART1Output.nodetype = .output;
                USART1Output.parents = &.{&USART1Mult};
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
                    &HSIRC,
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
            if (check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=")) {
                const USART3Mult_clk_value = Usart3ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "USART3Mult",
                    "Else",
                    "No Extra Log",
                    "Usart3ClockSelection",
                });
                const USART3Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                    &APB1Prescaler,
                };
                USART3Mult.nodetype = .multi;
                USART3Mult.parents = &.{USART3Multparents[USART3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART3EnableValue), USART3EnableValue, .true, .@"=")) {
                std.mem.doNotOptimizeAway(USART3Freq_ValueValue);
                USART3Output.nodetype = .output;
                USART3Output.parents = &.{&USART3Mult};
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
                &HSIRCDiv,
                &HSEPLLsourceDevisor,
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

            std.mem.doNotOptimizeAway(HSICECFreq_ValueValue);
            HSI_CEC.nodetype = .output;
            HSI_CEC.parents = &.{&HSICECDiv};

            std.mem.doNotOptimizeAway(HSIPLLFreq_ValueValue);
            HSI_PLL.nodetype = .output;
            HSI_PLL.parents = &.{&HSIRCDiv};

            std.mem.doNotOptimizeAway(HSEPLLFreq_ValueValue);
            HSE_PLL.nodetype = .output;
            HSE_PLL.parents = &.{&HSEPLLsourceDevisor};

            std.mem.doNotOptimizeAway(RTCHSEDivFreq_ValueValue);
            HSE_RTC.nodetype = .output;
            HSE_RTC.parents = &.{&HSERTCDevisor};

            std.mem.doNotOptimizeAway(PLLMCOFreq_ValueValue);
            PLLCLK_MCO.nodetype = .output;
            PLLCLK_MCO.parents = &.{&MCOMultDivisor};

            std.mem.doNotOptimizeAway(PLLCLKFreq_ValueValue);
            PLLCLK.limit = PLLCLKFreq_ValueLimit;
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLMUL};

            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.TimSysOutput = try TimSysOutput.get_output();
            out.TimSysPresc = try TimSysPresc.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.USART2Output = try USART2Output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART3Output = try USART3Output.get_output();
            out.USART3Mult = try USART3Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.USART1Output = try USART1Output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCPresc = try ADCPresc.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.MCOoutput = try MCOoutput.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.I2C1Output = try I2C1Output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C2Output = try I2C2Output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.SDADCoutput = try SDADCoutput.get_output();
            out.SDADCPresc = try SDADCPresc.get_output();
            out.PWROutput = try PWROutput.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.MCOMultDivisor = try MCOMultDivisor.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.PRESCALERUSB = try PRESCALERUSB.get_output();
            out.PLLMUL = try PLLMUL.get_output();
            out.VCO2output = try VCO2output.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.HSIRCDiv = try HSIRCDiv.get_output();
            out.CECOutput = try CECOutput.get_output();
            out.CECMult = try CECMult.get_output();
            out.HSICECDiv = try HSICECDiv.get_output();
            out.FLITFCLKoutput = try FLITFCLKoutput.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEPLLsourceDevisor = try HSEPLLsourceDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.HSI_CEC = try HSI_CEC.get_extra_output();
            out.HSI_PLL = try HSI_PLL.get_extra_output();
            out.HSE_PLL = try HSE_PLL.get_extra_output();
            out.HSE_RTC = try HSE_RTC.get_extra_output();
            out.PLLCLK_MCO = try PLLCLK_MCO.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSIRCDiv = HSIRCDivValue;
            ref_out.HSICECDiv = HSICECDivValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.CECClockSelection = CECClockSelectionValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.RCC_PLLsource_Clock_Source_FROM_HSE = RCC_PLLsource_Clock_Source_FROM_HSEValue;
            ref_out.PRESCALERUSB = PRESCALERUSBValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.SDADCPresc = SDADCPrescValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_MCOMult_Clock_Source_FROM_PLLMUL = RCC_MCOMult_Clock_Source_FROM_PLLMULValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.ADCPresc = ADCPrescValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.I2c1ClockSelection = I2c1ClockSelectionValue;
            ref_out.I2c2ClockSelection = I2c2ClockSelectionValue;
            ref_out.Usart1ClockSelection = Usart1ClockSelectionValue;
            ref_out.Usart2ClockSelection = Usart2ClockSelectionValue;
            ref_out.Usart3ClockSelection = Usart3ClockSelectionValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.EnableLSE = EnableLSEValue;
            ref_out.CECEnable = CECEnableValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.USBEnable = USBEnableValue;
            ref_out.SDADCEnable = SDADCEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.ADC1Enable = ADC1EnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C2Enable = I2C2EnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART3Enable = USART3EnableValue;
            ref_out.EnableMCOMultDivisor = EnableMCOMultDivisorValue;
            ref_out.EnableLSERTC = EnableLSERTCValue;
            ref_out.HSEUsed = HSEUsedValue;
            ref_out.LSIUsed = LSIUsedValue;
            ref_out.HSIUsed = HSIUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
