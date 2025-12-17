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

pub const RSTClockSelectionList = enum {
    RCC_RADIOSTCLKSOURCE_HSE_DIV1000,
    RCC_RADIOSTCLKSOURCE_LSE,
    RCC_RADIOSTCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RADIOSTCLKSOURCE_HSE_DIV1000 => 0,
            .RCC_RADIOSTCLKSOURCE_LSE => 1,
            .RCC_RADIOSTCLKSOURCE_LSI => 2,
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
pub const USART2CLockSelectionList = enum {
    RCC_USART2CLKSOURCE_PCLK1,
    RCC_USART2CLKSOURCE_SYSCLK,
    RCC_USART2CLKSOURCE_HSI,
    RCC_USART2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART2CLKSOURCE_PCLK1 => 0,
            .RCC_USART2CLKSOURCE_SYSCLK => 1,
            .RCC_USART2CLKSOURCE_HSI => 2,
            .RCC_USART2CLKSOURCE_LSE => 3,
        };
    }
};
pub const USART1CLockSelectionList = enum {
    RCC_USART1CLKSOURCE_PCLK2,
    RCC_USART1CLKSOURCE_SYSCLK,
    RCC_USART1CLKSOURCE_HSI,
    RCC_USART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_USART1CLKSOURCE_PCLK2 => 0,
            .RCC_USART1CLKSOURCE_SYSCLK => 1,
            .RCC_USART1CLKSOURCE_HSI => 2,
            .RCC_USART1CLKSOURCE_LSE => 3,
        };
    }
};
pub const LPUART1CLockSelectionList = enum {
    RCC_LPUART1CLKSOURCE_PCLK7,
    RCC_LPUART1CLKSOURCE_SYSCLK,
    RCC_LPUART1CLKSOURCE_HSI,
    RCC_LPUART1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPUART1CLKSOURCE_PCLK7 => 0,
            .RCC_LPUART1CLKSOURCE_SYSCLK => 1,
            .RCC_LPUART1CLKSOURCE_HSI => 2,
            .RCC_LPUART1CLKSOURCE_LSE => 3,
        };
    }
};
pub const LPTIM1CLockSelectionList = enum {
    RCC_LPTIM1CLKSOURCE_PCLK7,
    RCC_LPTIM1CLKSOURCE_LSI,
    RCC_LPTIM1CLKSOURCE_HSI,
    RCC_LPTIM1CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM1CLKSOURCE_PCLK7 => 0,
            .RCC_LPTIM1CLKSOURCE_LSI => 1,
            .RCC_LPTIM1CLKSOURCE_HSI => 2,
            .RCC_LPTIM1CLKSOURCE_LSE => 3,
        };
    }
};
pub const LPTIM2CLockSelectionList = enum {
    RCC_LPTIM2CLKSOURCE_PCLK1,
    RCC_LPTIM2CLKSOURCE_LSI,
    RCC_LPTIM2CLKSOURCE_HSI,
    RCC_LPTIM2CLKSOURCE_LSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_LPTIM2CLKSOURCE_PCLK1 => 0,
            .RCC_LPTIM2CLKSOURCE_LSI => 1,
            .RCC_LPTIM2CLKSOURCE_HSI => 2,
            .RCC_LPTIM2CLKSOURCE_LSE => 3,
        };
    }
};
pub const ADCCLockSelectionList = enum {
    RCC_ADCCLKSOURCE_HCLK,
    RCC_ADCCLKSOURCE_SYSCLK,
    RCC_ADCCLKSOURCE_HSE,
    RCC_ADCCLKSOURCE_HSI,
    RCC_ADCCLKSOURCE_PLL1P,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ADCCLKSOURCE_HCLK => 0,
            .RCC_ADCCLKSOURCE_SYSCLK => 1,
            .RCC_ADCCLKSOURCE_HSE => 2,
            .RCC_ADCCLKSOURCE_HSI => 3,
            .RCC_ADCCLKSOURCE_PLL1P => 4,
        };
    }
};
pub const ASClockSelectionList = enum {
    RCC_ASCLKSOURCE_PLL1P,
    RCC_ASCLKSOURCE_PLL1Q,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_ASCLKSOURCE_PLL1P => 0,
            .RCC_ASCLKSOURCE_PLL1Q => 1,
        };
    }
};
pub const I2C1CLockSelectionList = enum {
    RCC_I2C1CLKSOURCE_PCLK1,
    RCC_I2C1CLKSOURCE_SYSCLK,
    RCC_I2C1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C1CLKSOURCE_PCLK1 => 0,
            .RCC_I2C1CLKSOURCE_SYSCLK => 1,
            .RCC_I2C1CLKSOURCE_HSI => 2,
        };
    }
};
pub const I2C3CLockSelectionList = enum {
    RCC_I2C3CLKSOURCE_PCLK7,
    RCC_I2C3CLKSOURCE_SYSCLK,
    RCC_I2C3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_PCLK7 => 0,
            .RCC_I2C3CLKSOURCE_SYSCLK => 1,
            .RCC_I2C3CLKSOURCE_HSI => 2,
        };
    }
};
pub const SAI1CLockSelectionList = enum {
    RCC_SAI1CLKSOURCE_PLL1P,
    RCC_SAI1CLKSOURCE_HSI,
    RCC_SAI1CLKSOURCE_PLL1Q,
    RCC_SAI1CLKSOURCE_PIN,
    RCC_SAI1CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SAI1CLKSOURCE_PLL1P => 0,
            .RCC_SAI1CLKSOURCE_HSI => 1,
            .RCC_SAI1CLKSOURCE_PLL1Q => 2,
            .RCC_SAI1CLKSOURCE_PIN => 3,
            .RCC_SAI1CLKSOURCE_SYSCLK => 4,
        };
    }
};
pub const RNGCLockSelectionList = enum {
    RCC_RNGCLKSOURCE_LSE,
    RCC_RNGCLKSOURCE_PLL1Q,
    RCC_RNGCLKSOURCE_HSI,
    RCC_RNGCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_RNGCLKSOURCE_LSE => 0,
            .RCC_RNGCLKSOURCE_PLL1Q => 1,
            .RCC_RNGCLKSOURCE_HSI => 2,
            .RCC_RNGCLKSOURCE_LSI => 3,
        };
    }
};
pub const RCC_MCO1SourceList = enum {
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_PLL1RCLK,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_PLL1PCLK,
    RCC_MCO1SOURCE_PLL1QCLK,
    RCC_MCO1SOURCE_HCLK5,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_LSE => 0,
            .RCC_MCO1SOURCE_LSI => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .RCC_MCO1SOURCE_HSI => 3,
            .RCC_MCO1SOURCE_PLL1RCLK => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
            .RCC_MCO1SOURCE_PLL1PCLK => 6,
            .RCC_MCO1SOURCE_PLL1QCLK => 7,
            .RCC_MCO1SOURCE_HCLK5 => 8,
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
pub const CortexCLockSelectionList = enum {
    RCC_SYSTICKCLKSOURCE_HCLK_DIV8,
    RCC_SYSTICKCLKSOURCE_LSE,
    RCC_SYSTICKCLKSOURCE_LSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => 0,
            .RCC_SYSTICKCLKSOURCE_LSE => 1,
            .RCC_SYSTICKCLKSOURCE_LSI => 2,
        };
    }
};
pub const SPI1CLockSelectionList = enum {
    RCC_SPI1CLKSOURCE_PCLK2,
    RCC_SPI1CLKSOURCE_SYSCLK,
    RCC_SPI1CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI1CLKSOURCE_PCLK2 => 0,
            .RCC_SPI1CLKSOURCE_SYSCLK => 1,
            .RCC_SPI1CLKSOURCE_HSI => 2,
        };
    }
};
pub const SPI3CLockSelectionList = enum {
    RCC_SPI3CLKSOURCE_PCLK7,
    RCC_SPI3CLKSOURCE_SYSCLK,
    RCC_SPI3CLKSOURCE_HSI,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_SPI3CLKSOURCE_PCLK7 => 0,
            .RCC_SPI3CLKSOURCE_SYSCLK => 1,
            .RCC_SPI3CLKSOURCE_HSI => 2,
        };
    }
};
pub const HseDivList = enum {
    RCC_HSE_DIV1,
    RCC_HSE_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HSE_DIV1 => 1,
            .RCC_HSE_DIV2 => 2,
        };
    }
};
pub const LSIDIVList = enum {
    RCC_LSI_DIV1,
    RCC_LSI_DIV128,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_LSI_DIV1 => 1,
            .RCC_LSI_DIV128 => 128,
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
pub const AHB5CLKDividerList = enum {
    DIV1,
    DIV2,
    DIV3,
    DIV4,
    DIV6,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .DIV1 => 1,
            .DIV2 => 2,
            .DIV3 => 3,
            .DIV4 => 4,
            .DIV6 => 6,
        };
    }
};
pub const AHBCLKDividerList = enum {
    RCC_SYSCLK_DIV1,
    RCC_SYSCLK_DIV2,
    RCC_SYSCLK_DIV4,
    RCC_SYSCLK_DIV8,
    RCC_SYSCLK_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_SYSCLK_DIV1 => 1,
            .RCC_SYSCLK_DIV2 => 2,
            .RCC_SYSCLK_DIV4 => 4,
            .RCC_SYSCLK_DIV8 => 8,
            .RCC_SYSCLK_DIV16 => 16,
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
pub const APB7CLKDividerList = enum {
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
pub const PLL1PList = enum {
    @"1",
    @"2",
    @"4",
    @"6",
    @"8",
    @"10",
    @"12",
    @"14",
    @"16",
    @"18",
    @"20",
    @"22",
    @"24",
    @"26",
    @"28",
    @"30",
    @"32",
    @"34",
    @"36",
    @"38",
    @"40",
    @"42",
    @"44",
    @"46",
    @"48",
    @"50",
    @"52",
    @"54",
    @"56",
    @"58",
    @"60",
    @"62",
    @"64",
    @"66",
    @"68",
    @"70",
    @"72",
    @"74",
    @"76",
    @"78",
    @"80",
    @"82",
    @"84",
    @"86",
    @"88",
    @"90",
    @"92",
    @"94",
    @"96",
    @"98",
    @"100",
    @"102",
    @"104",
    @"106",
    @"108",
    @"110",
    @"112",
    @"114",
    @"116",
    @"118",
    @"120",
    @"122",
    @"124",
    @"126",
    @"128",
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .@"1" => 1,
            .@"2" => 2,
            .@"4" => 4,
            .@"6" => 6,
            .@"8" => 8,
            .@"10" => 10,
            .@"12" => 12,
            .@"14" => 14,
            .@"16" => 16,
            .@"18" => 18,
            .@"20" => 20,
            .@"22" => 22,
            .@"24" => 24,
            .@"26" => 26,
            .@"28" => 28,
            .@"30" => 30,
            .@"32" => 32,
            .@"34" => 34,
            .@"36" => 36,
            .@"38" => 38,
            .@"40" => 40,
            .@"42" => 42,
            .@"44" => 44,
            .@"46" => 46,
            .@"48" => 48,
            .@"50" => 50,
            .@"52" => 52,
            .@"54" => 54,
            .@"56" => 56,
            .@"58" => 58,
            .@"60" => 60,
            .@"62" => 62,
            .@"64" => 64,
            .@"66" => 66,
            .@"68" => 68,
            .@"70" => 70,
            .@"72" => 72,
            .@"74" => 74,
            .@"76" => 76,
            .@"78" => 78,
            .@"80" => 80,
            .@"82" => 82,
            .@"84" => 84,
            .@"86" => 86,
            .@"88" => 88,
            .@"90" => 90,
            .@"92" => 92,
            .@"94" => 94,
            .@"96" => 96,
            .@"98" => 98,
            .@"100" => 100,
            .@"102" => 102,
            .@"104" => 104,
            .@"106" => 106,
            .@"108" => 108,
            .@"110" => 110,
            .@"112" => 112,
            .@"114" => 114,
            .@"116" => 116,
            .@"118" => 118,
            .@"120" => 120,
            .@"122" => 122,
            .@"124" => 124,
            .@"126" => 126,
            .@"128" => 128,
        };
    }
};
pub const PREFETCH_ENABLEList = enum {
    @"1",
    @"0",
};
pub const FLatencyList = enum {
    FLASH_LATENCY_1,
    FLASH_LATENCY_0,
    FLASH_LATENCY_3,
    FLASH_LATENCY_2,
};
pub const PWR_Regulator_Voltage_ScaleList = enum {
    PWR_REGULATOR_VOLTAGE_SCALE1,
    PWR_REGULATOR_VOLTAGE_SCALE2,
};
pub const LSE_TrimmingList = enum {
    RCC_LSETRIMMING_R,
    RCC_LSETRIMMING_1_2_R,
    RCC_LSETRIMMING_2_3_R,
    RCC_LSETRIMMING_3_4_R,
};
pub const LSE_Drive_CapabilityList = enum {
    RCC_LSEDRIVE_MEDIUMLOW,
    RCC_LSEDRIVE_MEDIUMHIGH,
    RCC_LSEDRIVE_HIGH,
};
pub const PLL1_VCI_RangeList = enum {
    RCC_PLL_VCOINPUT_RANGE0,
    RCC_PLL_VCOINPUT_RANGE1,
};
pub const EnableHSEList = enum {
    true,
    false,
};
pub const LSIEnableList = enum {
    true,
};
pub const EnableExtClockForSAI1List = enum {
    true,
    false,
};
pub const EnableHSERFDevisorList = enum {
    true,
    false,
};
pub const RFEnableList = enum {
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
pub const USART2EnableList = enum {
    true,
    false,
};
pub const USART1EnableList = enum {
    true,
    false,
};
pub const LPUART1EnableList = enum {
    true,
    false,
};
pub const LPTIM1EnableList = enum {
    true,
    false,
};
pub const LPTIM2EnableList = enum {
    true,
    false,
};
pub const ADCEnableList = enum {
    true,
    false,
};
pub const ASEnableList = enum {
    true,
    false,
};
pub const I2C1EnableList = enum {
    true,
    false,
};
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const SAI1EnableList = enum {
    true,
    false,
};
pub const RNGEnableList = enum {
    true,
    false,
};
pub const MCOEnableList = enum {
    true,
    false,
};
pub const LSCOEnableList = enum {
    true,
    false,
};
pub const SAESEnableList = enum {
    true,
    false,
};
pub const SystickEnableList = enum {
    true,
    false,
};
pub const SPI1EnableList = enum {
    true,
    false,
};
pub const SPI3EnableList = enum {
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
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            LSEByPassRTC: bool = false,
            LSEOscillatorRTC: bool = false,
            MCOConfig: bool = false,
            LSCOConfig: bool = false,
            SAI1EXTCLK: bool = false,
            AUDIOSYNC: bool = false,
            RTCUsed_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            LPUARTUsed_ForRCC: bool = false,
            LPTIM1Used_ForRCC: bool = false,
            LPTIM2Used_ForRCC: bool = false,
            USE_ADC4: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            SAI1_SAIBUsed_ForRCC: bool = false,
            SAI1_SAIAUsed_ForRCC: bool = false,
            RNGUsed_ForRCC: bool = false,
            SPI1Used_ForRCC: bool = false,
            SPI3Used_ForRCC: bool = false,
            PLLRUsed: bool = false,
            RF_Used: bool = false,
            LPTIM2_UsedUsed_ForRCC: bool = false,
            SAES_Used: bool = false,
            RNG_Used: bool = false,
            ADC4_Used: bool = false,
            TIM17_Used: bool = false,
            TIM16_Used: bool = false,
            SAI1_Used: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            EnableCSSLSE: ?EnableCSSLSEList = null,
            VDD_VALUE: ?f32 = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            FLatency: ?FLatencyList = null,
            HSICalibrationValue: ?u32 = null,
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            HSE_Trimming: ?u32 = null,
            LSE_Trimming: ?LSE_TrimmingList = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            HSE_VALUE: ?f32 = null,
            HseDiv: ?HseDivList = null,
            LSI_VALUE: ?f32 = null,
            LSIDIV: ?LSIDIVList = null,
            LSI2_VALUE: ?f32 = null,
            LSE_VALUE: ?f32 = null,
            RSTClockSelection: ?RSTClockSelectionList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            PLLSource: ?PLLSourceList = null,
            PLLM: ?u32 = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            USART2CLockSelection: ?USART2CLockSelectionList = null,
            USART1CLockSelection: ?USART1CLockSelectionList = null,
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null,
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null,
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null,
            ADCCLockSelection: ?ADCCLockSelectionList = null,
            ASClockSelection: ?ASClockSelectionList = null,
            I2C1CLockSelection: ?I2C1CLockSelectionList = null,
            I2C3CLockSelection: ?I2C3CLockSelectionList = null,
            SAI1CLockSelection: ?SAI1CLockSelectionList = null,
            RNGCLockSelection: ?RNGCLockSelectionList = null,
            RCC_MCO1Source: ?RCC_MCO1SourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            LSCOSource1: ?LSCOSource1List = null,
            AHB5CLKDivider: ?AHB5CLKDividerList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            CortexCLockSelection: ?CortexCLockSelectionList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            APB7CLKDivider: ?APB7CLKDividerList = null,
            SPI1CLockSelection: ?SPI1CLockSelectionList = null,
            SPI3CLockSelection: ?SPI3CLockSelectionList = null,
            PLLN: ?u32 = null,
            PLLFRACN: ?u32 = null,
            PLL1P: ?PLL1PList = null,
            PLL1Q: ?u32 = null,
            PLL1R: ?u32 = null,
            extra: ExtraConfig = .{},
            flags: Flags = .{},
        };
        ///output of clock values after processing
        ///Note: outputs marked as 0 may indicate a disabled clock or an actual output value of 0.
        pub const Clock_Output = struct {
            HSIRC: f32 = 0,
            HSEOSC: f32 = 0,
            HseDiv: f32 = 0,
            LSIRC: f32 = 0,
            LSIOut: f32 = 0,
            LSI2RC: f32 = 0,
            LSIDIV: f32 = 0,
            LSEOSC: f32 = 0,
            SAI1_EXT: f32 = 0,
            HSERSTDevisor: f32 = 0,
            RSTClkSource: f32 = 0,
            RSTOutput: f32 = 0,
            RSTRFOutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            PLLSource: f32 = 0,
            PLLM: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            USART2Mult: f32 = 0,
            USART2output: f32 = 0,
            USART1Mult: f32 = 0,
            USART1output: f32 = 0,
            LPUART1Mult: f32 = 0,
            LPUART1output: f32 = 0,
            LPTIM1Mult: f32 = 0,
            LPTIM1output: f32 = 0,
            LPTIM2Mult: f32 = 0,
            LPTIM2output: f32 = 0,
            ADCMult: f32 = 0,
            ADCoutput: f32 = 0,
            ASMult: f32 = 0,
            ASoutput: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3output: f32 = 0,
            SAI1Mult: f32 = 0,
            SAI1output: f32 = 0,
            pllqDivToRNG: f32 = 0,
            RNGMult: f32 = 0,
            RNGoutput: f32 = 0,
            MCOMult: f32 = 0,
            MCODiv: f32 = 0,
            MCOPin: f32 = 0,
            LSCOMult: f32 = 0,
            LSCOOutput: f32 = 0,
            AHB5Prescaler: f32 = 0,
            AHB5Output: f32 = 0,
            SAESOutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            HCLK4Output: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexCLockSelection: f32 = 0,
            CortexSysOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            APB7Prescaler: f32 = 0,
            APB7Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            SPI1Mult: f32 = 0,
            SPI1output: f32 = 0,
            SPI3Mult: f32 = 0,
            SPI3output: f32 = 0,
            PLLN: f32 = 0,
            PLLFRACN: f32 = 0,
            PLL1P: f32 = 0,
            PLLPoutput: f32 = 0,
            PLL1Q: f32 = 0,
            PLLQoutput: f32 = 0,
            PLL1R: f32 = 0,
            VCOInput: f32 = 0,
            VCOOutput: f32 = 0,
            PLLCLK: f32 = 0,
            LSI1: f32 = 0,
            HSESYS: f32 = 0,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flags = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            HseDiv: ?HseDivList = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSIDIV: ?LSIDIVList = null, //from RCC Clock Config
            LSI2_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            EXTERNALSAI1_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            RCC_RST_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RSTClockSelection: ?RSTClockSelectionList = null, //from extra RCC references
            SYSCLKSource: ?SYSCLKSourceList = null, //from extra RCC references
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLM: ?f32 = null, //from RCC Clock Config
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            USART2CLockSelection: ?USART2CLockSelectionList = null, //from extra RCC references
            USART1CLockSelection: ?USART1CLockSelectionList = null, //from extra RCC references
            LPUART1CLockSelection: ?LPUART1CLockSelectionList = null, //from extra RCC references
            LPTIM1CLockSelection: ?LPTIM1CLockSelectionList = null, //from extra RCC references
            LPTIM2CLockSelection: ?LPTIM2CLockSelectionList = null, //from extra RCC references
            ADCCLockSelection: ?ADCCLockSelectionList = null, //from extra RCC references
            ASClockSelection: ?ASClockSelectionList = null, //from RCC Clock Config
            I2C1CLockSelection: ?I2C1CLockSelectionList = null, //from RCC Clock Config
            I2C3CLockSelection: ?I2C3CLockSelectionList = null, //from RCC Clock Config
            SAI1CLockSelection: ?SAI1CLockSelectionList = null, //from extra RCC references
            pllqDivToRNG: ?f32 = null, //from RCC Clock Config
            RNGCLockSelection: ?RNGCLockSelectionList = null, //from extra RCC references
            RCC_MCO1Source: ?RCC_MCO1SourceList = null, //from extra RCC references
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            LSCOSource1: ?LSCOSource1List = null, //from extra RCC references
            AHB5CLKDivider: ?AHB5CLKDividerList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?f32 = null, //from RCC Clock Config
            CortexCLockSelection: ?CortexCLockSelectionList = null, //from extra RCC references
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB7CLKDivider: ?APB7CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            SPI1CLockSelection: ?SPI1CLockSelectionList = null, //from RCC Clock Config
            SPI3CLockSelection: ?SPI3CLockSelectionList = null, //from RCC Clock Config
            PLLN: ?f32 = null, //from RCC Clock Config
            PLLFRACN: ?f32 = null, //from RCC Clock Config
            PLL1P: ?PLL1PList = null, //from RCC Clock Config
            PLL1Q: ?f32 = null, //from RCC Clock Config
            PLL1R: ?f32 = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            PWR_Regulator_Voltage_Scale: ?PWR_Regulator_Voltage_ScaleList = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            HSE_Trimming: ?f32 = null, //from RCC Advanced Config
            LSE_Trimming: ?LSE_TrimmingList = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
            PLL1_VCI_Range: ?PLL1_VCI_RangeList = null, //from RCC Advanced Config
            EnableHSE: ?EnableHSEList = null, //from extra RCC references
            LSIEnable: ?LSIEnableList = null, //from extra RCC references
            EnableExtClockForSAI1: ?EnableExtClockForSAI1List = null, //from extra RCC references
            EnableHSERFDevisor: ?EnableHSERFDevisorList = null, //from extra RCC references
            RFEnable: ?RFEnableList = null, //from extra RCC references
            EnableHSERTCDevisor: ?EnableHSERTCDevisorList = null, //from extra RCC references
            RTCEnable: ?RTCEnableList = null, //from extra RCC references
            IWDGEnable: ?IWDGEnableList = null, //from extra RCC references
            USART2Enable: ?USART2EnableList = null, //from extra RCC references
            USART1Enable: ?USART1EnableList = null, //from extra RCC references
            LPUART1Enable: ?LPUART1EnableList = null, //from extra RCC references
            LPTIM1Enable: ?LPTIM1EnableList = null, //from extra RCC references
            LPTIM2Enable: ?LPTIM2EnableList = null, //from extra RCC references
            ADCEnable: ?ADCEnableList = null, //from extra RCC references
            ASEnable: ?ASEnableList = null, //from extra RCC references
            I2C1Enable: ?I2C1EnableList = null, //from extra RCC references
            I2C3Enable: ?I2C3EnableList = null, //from extra RCC references
            SAI1Enable: ?SAI1EnableList = null, //from extra RCC references
            RNGEnable: ?RNGEnableList = null, //from extra RCC references
            MCOEnable: ?MCOEnableList = null, //from extra RCC references
            LSCOEnable: ?LSCOEnableList = null, //from extra RCC references
            SAESEnable: ?SAESEnableList = null, //from extra RCC references
            SystickEnable: ?SystickEnableList = null, //from extra RCC references
            SPI1Enable: ?SPI1EnableList = null, //from extra RCC references
            SPI3Enable: ?SPI3EnableList = null, //from extra RCC references
            PLL1PUsed: ?f32 = null, //from extra RCC references
            PLL1QUsed: ?f32 = null, //from extra RCC references
            PLLUsed: ?f32 = null, //from extra RCC references
            LSEUsed: ?f32 = null, //from extra RCC references
            EnableCSSLSE: ?EnableCSSLSEList = null, //from RCC Advanced Config
            PLL1RUsed: ?f32 = null, //from extra RCC references
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
            ref_out.flags = config.flags;

            //Semaphores flags

            var RST_HSE: bool = false;
            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var PLLSourceHSI: bool = false;
            var PLLSourceHSE: bool = false;
            var RTCSourceHSE: bool = false;
            var RTCSourceLSE: bool = false;
            var RTCSourceLSI: bool = false;
            var USART2SourcePCLK1: bool = false;
            var USART2SourceSys: bool = false;
            var USART2SourceHSI: bool = false;
            var USART2SourceLSE: bool = false;
            var USART1SourceHSI: bool = false;
            var USART1SourceLSE: bool = false;
            var LPUART1SourceHSI: bool = false;
            var LPUART1SourceLSE: bool = false;
            var LPTIM1SOURCELSI: bool = false;
            var LPTIM1SOURCEHSI: bool = false;
            var LPTIM1SOURCELSE: bool = false;
            var LPTIM2SOURCELSI: bool = false;
            var LPTIM2SOURCEHSI: bool = false;
            var LPTIM2SOURCELSE: bool = false;
            var ADCSourceSys: bool = false;
            var ADCSourceHSE: bool = false;
            var ADCSourceHSI: bool = false;
            var adc_pll1p: bool = false;
            var ASPLL1P: bool = false;
            var ASPLL1Q: bool = false;
            var I2C1SourceSys: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C3SourceSys: bool = false;
            var I2C3SourceHSI: bool = false;
            var SAI1SourcePLL1P: bool = false;
            var SAI1SourceHSI: bool = false;
            var sai1_pll1q: bool = false;
            var SAI1SourceEXT: bool = false;
            var rng_pll1q: bool = false;
            var RNGCLKSOURCE_HSI: bool = false;
            var MCO1SOURCE_HSE: bool = false;
            var mco1_pll1r: bool = false;
            var mco1_pll1p: bool = false;
            var mco1_pll1q: bool = false;
            var LSCOSSourceLSI: bool = false;
            var LSCOSSourceLSE: bool = false;
            var CLKSOURCE_HCLK_1_8: bool = false;
            var CLKSOURCE_LSE: bool = false;
            var CLKSOURCE_LSI: bool = false;
            var SPI1CLKSOURCE_HSI: bool = false;
            var SPI3CLKSOURCE_HSI: bool = false;
            var hsepres: bool = false;
            var LSI_DIV1: bool = false;
            var LSI_DIV128: bool = false;
            var AHB5_1: bool = false;
            var AHB5_2: bool = false;
            var AHB5_3: bool = false;
            var AHB5_4: bool = false;
            var AHB5_6: bool = false;
            var AHBCLKDivider1: bool = false;
            var scale1: bool = false;
            var scale2: bool = false;
            var LSE_R: bool = false;
            var RCC_LSECSS_ENABLED: bool = false;

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

            var HseDiv = ClockNode{
                .name = "HseDiv",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIRC = ClockNode{
                .name = "LSIRC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIOut = ClockNode{
                .name = "LSIOut",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSI2RC = ClockNode{
                .name = "LSI2RC",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSIDIV = ClockNode{
                .name = "LSIDIV",
                .nodetype = .off,
                .parents = &.{},
            };

            var LSEOSC = ClockNode{
                .name = "LSEOSC",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1_EXT = ClockNode{
                .name = "SAI1_EXT",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSERSTDevisor = ClockNode{
                .name = "HSERSTDevisor",
                .nodetype = .off,
                .parents = &.{},
            };

            var RSTClkSource = ClockNode{
                .name = "RSTClkSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var RSTOutput = ClockNode{
                .name = "RSTOutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var RSTRFOutput = ClockNode{
                .name = "RSTRFOutput",
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

            var USART2Mult = ClockNode{
                .name = "USART2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var USART2output = ClockNode{
                .name = "USART2output",
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

            var LPUART1Mult = ClockNode{
                .name = "LPUART1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPUART1output = ClockNode{
                .name = "LPUART1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1Mult = ClockNode{
                .name = "LPTIM1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM1output = ClockNode{
                .name = "LPTIM1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM2Mult = ClockNode{
                .name = "LPTIM2Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var LPTIM2output = ClockNode{
                .name = "LPTIM2output",
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

            var ASMult = ClockNode{
                .name = "ASMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var ASoutput = ClockNode{
                .name = "ASoutput",
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

            var I2C3Mult = ClockNode{
                .name = "I2C3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3output = ClockNode{
                .name = "I2C3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1Mult = ClockNode{
                .name = "SAI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAI1output = ClockNode{
                .name = "SAI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var pllqDivToRNG = ClockNode{
                .name = "pllqDivToRNG",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGMult = ClockNode{
                .name = "RNGMult",
                .nodetype = .off,
                .parents = &.{},
            };

            var RNGoutput = ClockNode{
                .name = "RNGoutput",
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

            var AHB5Prescaler = ClockNode{
                .name = "AHB5Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var AHB5Output = ClockNode{
                .name = "AHB5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SAESOutput = ClockNode{
                .name = "SAESOutput",
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

            var HCLK4Output = ClockNode{
                .name = "HCLK4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var CortexPrescaler = ClockNode{
                .name = "CortexPrescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var CortexCLockSelection = ClockNode{
                .name = "CortexCLockSelection",
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

            var APB7Prescaler = ClockNode{
                .name = "APB7Prescaler",
                .nodetype = .off,
                .parents = &.{},
            };

            var APB7Output = ClockNode{
                .name = "APB7Output",
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

            var SPI1Mult = ClockNode{
                .name = "SPI1Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI1output = ClockNode{
                .name = "SPI1output",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI3Mult = ClockNode{
                .name = "SPI3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var SPI3output = ClockNode{
                .name = "SPI3output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLN = ClockNode{
                .name = "PLLN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLFRACN = ClockNode{
                .name = "PLLFRACN",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1P = ClockNode{
                .name = "PLL1P",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLPoutput = ClockNode{
                .name = "PLLPoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1Q = ClockNode{
                .name = "PLL1Q",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLQoutput = ClockNode{
                .name = "PLLQoutput",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLL1R = ClockNode{
                .name = "PLL1R",
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

            var LSI1 = ClockNode{
                .name = "LSI1",
                .nodetype = .off,
                .parents = &.{},
            };

            var HSESYS = ClockNode{
                .name = "HSESYS",
                .nodetype = .off,
                .parents = &.{},
            };
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 1.6e7;
            };
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 32000000;
            const HseDivValue: ?HseDivList = blk: {
                const conf_item = config.HseDiv;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HSE_DIV1 => {},
                        .RCC_HSE_DIV2 => hsepres = true,
                    }
                }

                break :blk conf_item orelse .RCC_HSE_DIV1;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI_VALUE;
                if (config_val) |val| {
                    if (val < 3.14e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI_VALUE",
                            "Else",
                            "No Extra Log",
                            3.14e4,
                            val,
                        });
                    }
                    if (val > 3.26e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI_VALUE",
                            "Else",
                            "No Extra Log",
                            3.26e4,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32000;
            };
            const LSIDIVValue: ?LSIDIVList = blk: {
                const conf_item = config.LSIDIV;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSI_DIV1 => LSI_DIV1 = true,
                        .RCC_LSI_DIV128 => LSI_DIV128 = true,
                    }
                }

                break :blk conf_item orelse {
                    LSI_DIV1 = true;
                    break :blk .RCC_LSI_DIV1;
                };
            };
            const LSI2_VALUEValue: ?f32 = blk: {
                const config_val = config.LSI2_VALUE;
                if (config_val) |val| {
                    if (val < 3.14e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI2_VALUE",
                            "Else",
                            "No Extra Log",
                            3.14e4,
                            val,
                        });
                    }
                    if (val > 3.26e4) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {e} found: {e}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "LSI2_VALUE",
                            "Else",
                            "No Extra Log",
                            3.26e4,
                            val,
                        });
                    }
                }
                break :blk config_val orelse 32000;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const EXTERNALSAI1_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 4.8e4;
            };
            const RCC_RST_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 1000;
            };
            const RSTClockSelectionValue: ?RSTClockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.RSTClockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_RADIOSTCLKSOURCE_HSE_DIV1000 => RST_HSE = true,
                            .RCC_RADIOSTCLKSOURCE_LSI => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_RADIOSTCLKSOURCE_HSE_DIV1000
                                    \\ - RCC_RADIOSTCLKSOURCE_LSI
                                , .{ "RSTClockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        RST_HSE = true;
                        break :blk .RCC_RADIOSTCLKSOURCE_HSE_DIV1000;
                    };
                }
                const conf_item = config.RSTClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RADIOSTCLKSOURCE_HSE_DIV1000 => RST_HSE = true,
                        .RCC_RADIOSTCLKSOURCE_LSE => {},
                        .RCC_RADIOSTCLKSOURCE_LSI => {},
                    }
                }

                break :blk conf_item orelse {
                    RST_HSE = true;
                    break :blk .RCC_RADIOSTCLKSOURCE_HSE_DIV1000;
                };
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
            const PLLSourceValue: ?PLLSourceList = blk: {
                const conf_item = config.PLLSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PLLSOURCE_HSI => PLLSourceHSI = true,
                        .RCC_PLLSOURCE_HSE => PLLSourceHSE = true,
                    }
                }

                break :blk conf_item orelse {
                    PLLSourceHSI = true;
                    break :blk .RCC_PLLSOURCE_HSI;
                };
            };
            const PLLMValue: ?f32 = blk: {
                const config_val = config.PLLM;
                if (config_val) |val| {
                    if (val < 1) {
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
                            1,
                            val,
                        });
                    }
                    if (val > 8) {
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
                            8,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 1;
            };
            const RCC_RTC_Clock_Source_FROM_HSEValue: ?f32 = blk: {
                break :blk 32;
            };
            const RTCClockSelectionValue: ?RTCClockSelectionList = blk: {
                const conf_item = config.RTCClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RTCCLKSOURCE_HSE_DIV32 => RTCSourceHSE = true,
                        .RCC_RTCCLKSOURCE_LSE => RTCSourceLSE = true,
                        .RCC_RTCCLKSOURCE_LSI => RTCSourceLSI = true,
                    }
                }

                break :blk conf_item orelse {
                    RTCSourceLSI = true;
                    break :blk .RCC_RTCCLKSOURCE_LSI;
                };
            };
            const USART2CLockSelectionValue: ?USART2CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.USART2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART2CLKSOURCE_PCLK1 => USART2SourcePCLK1 = true,
                            .RCC_USART2CLKSOURCE_SYSCLK => USART2SourceSys = true,
                            .RCC_USART2CLKSOURCE_HSI => USART2SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART2CLKSOURCE_PCLK1
                                    \\ - RCC_USART2CLKSOURCE_SYSCLK
                                    \\ - RCC_USART2CLKSOURCE_HSI
                                , .{ "USART2CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        USART2SourcePCLK1 = true;
                        break :blk .RCC_USART2CLKSOURCE_PCLK1;
                    };
                }
                const conf_item = config.USART2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART2CLKSOURCE_PCLK1 => USART2SourcePCLK1 = true,
                        .RCC_USART2CLKSOURCE_SYSCLK => USART2SourceSys = true,
                        .RCC_USART2CLKSOURCE_HSI => USART2SourceHSI = true,
                        .RCC_USART2CLKSOURCE_LSE => USART2SourceLSE = true,
                    }
                }

                break :blk conf_item orelse {
                    USART2SourcePCLK1 = true;
                    break :blk .RCC_USART2CLKSOURCE_PCLK1;
                };
            };
            const USART1CLockSelectionValue: ?USART1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.USART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_USART1CLKSOURCE_PCLK2 => {},
                            .RCC_USART1CLKSOURCE_SYSCLK => {},
                            .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_USART1CLKSOURCE_PCLK2
                                    \\ - RCC_USART1CLKSOURCE_SYSCLK
                                    \\ - RCC_USART1CLKSOURCE_HSI
                                , .{ "USART1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
                }
                const conf_item = config.USART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_USART1CLKSOURCE_PCLK2 => {},
                        .RCC_USART1CLKSOURCE_SYSCLK => {},
                        .RCC_USART1CLKSOURCE_HSI => USART1SourceHSI = true,
                        .RCC_USART1CLKSOURCE_LSE => USART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_USART1CLKSOURCE_PCLK2;
            };
            const LPUART1CLockSelectionValue: ?LPUART1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPUART1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPUART1CLKSOURCE_PCLK7 => {},
                            .RCC_LPUART1CLKSOURCE_SYSCLK => {},
                            .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPUART1CLKSOURCE_PCLK7
                                    \\ - RCC_LPUART1CLKSOURCE_SYSCLK
                                    \\ - RCC_LPUART1CLKSOURCE_HSI
                                , .{ "LPUART1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK7;
                }
                const conf_item = config.LPUART1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPUART1CLKSOURCE_PCLK7 => {},
                        .RCC_LPUART1CLKSOURCE_SYSCLK => {},
                        .RCC_LPUART1CLKSOURCE_HSI => LPUART1SourceHSI = true,
                        .RCC_LPUART1CLKSOURCE_LSE => LPUART1SourceLSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPUART1CLKSOURCE_PCLK7;
            };
            const LPTIM1CLockSelectionValue: ?LPTIM1CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                            .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                            .RCC_LPTIM1CLKSOURCE_PCLK7 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM1CLKSOURCE_LSI
                                    \\ - RCC_LPTIM1CLKSOURCE_HSI
                                    \\ - RCC_LPTIM1CLKSOURCE_PCLK7
                                , .{ "LPTIM1CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK7;
                }
                const conf_item = config.LPTIM1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM1CLKSOURCE_LSI => LPTIM1SOURCELSI = true,
                        .RCC_LPTIM1CLKSOURCE_HSI => LPTIM1SOURCEHSI = true,
                        .RCC_LPTIM1CLKSOURCE_LSE => LPTIM1SOURCELSE = true,
                        .RCC_LPTIM1CLKSOURCE_PCLK7 => {},
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM1CLKSOURCE_PCLK7;
            };
            const LPTIM2CLockSelectionValue: ?LPTIM2CLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.LPTIM2CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                            .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                            .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_LPTIM2CLKSOURCE_PCLK1
                                    \\ - RCC_LPTIM2CLKSOURCE_LSI
                                    \\ - RCC_LPTIM2CLKSOURCE_HSI
                                , .{ "LPTIM2CLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
                }
                const conf_item = config.LPTIM2CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LPTIM2CLKSOURCE_PCLK1 => {},
                        .RCC_LPTIM2CLKSOURCE_LSI => LPTIM2SOURCELSI = true,
                        .RCC_LPTIM2CLKSOURCE_HSI => LPTIM2SOURCEHSI = true,
                        .RCC_LPTIM2CLKSOURCE_LSE => LPTIM2SOURCELSE = true,
                    }
                }

                break :blk conf_item orelse .RCC_LPTIM2CLKSOURCE_PCLK1;
            };
            const ADCCLockSelectionValue: ?ADCCLockSelectionList = blk: {
                if (scale2) {
                    const conf_item = config.ADCCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_ADCCLKSOURCE_HCLK => {},
                            .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                            .RCC_ADCCLKSOURCE_HSE => ADCSourceHSE = true,
                            .RCC_ADCCLKSOURCE_HSI => ADCSourceHSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_ADCCLKSOURCE_HCLK
                                    \\ - RCC_ADCCLKSOURCE_SYSCLK
                                    \\ - RCC_ADCCLKSOURCE_HSE
                                    \\ - RCC_ADCCLKSOURCE_HSI
                                , .{ "ADCCLockSelection", "scale2", "PLL is not allowed in range 2", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_ADCCLKSOURCE_HCLK;
                }
                const conf_item = config.ADCCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADCCLKSOURCE_HCLK => {},
                        .RCC_ADCCLKSOURCE_SYSCLK => ADCSourceSys = true,
                        .RCC_ADCCLKSOURCE_HSE => ADCSourceHSE = true,
                        .RCC_ADCCLKSOURCE_HSI => ADCSourceHSI = true,
                        .RCC_ADCCLKSOURCE_PLL1P => adc_pll1p = true,
                    }
                }

                break :blk conf_item orelse .RCC_ADCCLKSOURCE_HCLK;
            };
            const ASClockSelectionValue: ?ASClockSelectionList = blk: {
                const conf_item = config.ASClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ASCLKSOURCE_PLL1P => ASPLL1P = true,
                        .RCC_ASCLKSOURCE_PLL1Q => ASPLL1Q = true,
                    }
                }

                break :blk conf_item orelse {
                    ASPLL1P = true;
                    break :blk .RCC_ASCLKSOURCE_PLL1P;
                };
            };
            const I2C1CLockSelectionValue: ?I2C1CLockSelectionList = blk: {
                const conf_item = config.I2C1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C1CLKSOURCE_PCLK1 => {},
                        .RCC_I2C1CLKSOURCE_SYSCLK => I2C1SourceSys = true,
                        .RCC_I2C1CLKSOURCE_HSI => I2C1SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C1CLKSOURCE_PCLK1;
            };
            const I2C3CLockSelectionValue: ?I2C3CLockSelectionList = blk: {
                const conf_item = config.I2C3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_PCLK7 => {},
                        .RCC_I2C3CLKSOURCE_SYSCLK => I2C3SourceSys = true,
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_I2C3CLKSOURCE_PCLK7;
            };
            const SAI1CLockSelectionValue: ?SAI1CLockSelectionList = blk: {
                if (scale2) {
                    const conf_item = config.SAI1CLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                            .RCC_SAI1CLKSOURCE_HSI => SAI1SourceHSI = true,
                            .RCC_SAI1CLKSOURCE_SYSCLK => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SAI1CLKSOURCE_PIN
                                    \\ - RCC_SAI1CLKSOURCE_HSI
                                    \\ - RCC_SAI1CLKSOURCE_SYSCLK
                                , .{ "SAI1CLockSelection", "scale2", "PLL is not allowed in range 2", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        SAI1SourceHSI = true;
                        break :blk .RCC_SAI1CLKSOURCE_HSI;
                    };
                }
                const conf_item = config.SAI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SAI1CLKSOURCE_PLL1P => SAI1SourcePLL1P = true,
                        .RCC_SAI1CLKSOURCE_PIN => SAI1SourceEXT = true,
                        .RCC_SAI1CLKSOURCE_HSI => SAI1SourceHSI = true,
                        .RCC_SAI1CLKSOURCE_PLL1Q => sai1_pll1q = true,
                        .RCC_SAI1CLKSOURCE_SYSCLK => {},
                    }
                }

                break :blk conf_item orelse {
                    SAI1SourceHSI = true;
                    break :blk .RCC_SAI1CLKSOURCE_HSI;
                };
            };
            const pllqDivToRNGValue: ?f32 = blk: {
                break :blk 2;
            };
            const RNGCLockSelectionValue: ?RNGCLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and !scale2) {
                    const conf_item = config.RNGCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_RNGCLKSOURCE_PLL1Q => rng_pll1q = true,
                            .RCC_RNGCLKSOURCE_HSI => RNGCLKSOURCE_HSI = true,
                            .RCC_RNGCLKSOURCE_LSI => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_RNGCLKSOURCE_PLL1Q
                                    \\ - RCC_RNGCLKSOURCE_HSI
                                    \\ - RCC_RNGCLKSOURCE_LSI
                                , .{ "RNGCLockSelection", "(LSEOscillatorRTC|LSEByPassRTC) & !scale2", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        RNGCLKSOURCE_HSI = true;
                        break :blk .RCC_RNGCLKSOURCE_HSI;
                    };
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and scale2) {
                    const conf_item = config.RNGCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_RNGCLKSOURCE_HSI => RNGCLKSOURCE_HSI = true,
                            .RCC_RNGCLKSOURCE_LSI => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_RNGCLKSOURCE_HSI
                                    \\ - RCC_RNGCLKSOURCE_LSI
                                , .{ "RNGCLockSelection", "(LSEOscillatorRTC|LSEByPassRTC) & scale2", "LSE only for RTC or PLL in range 2", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        RNGCLKSOURCE_HSI = true;
                        break :blk .RCC_RNGCLKSOURCE_HSI;
                    };
                } else if (!(config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and scale2) {
                    const conf_item = config.RNGCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_RNGCLKSOURCE_LSE => {},
                            .RCC_RNGCLKSOURCE_HSI => RNGCLKSOURCE_HSI = true,
                            .RCC_RNGCLKSOURCE_LSI => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_RNGCLKSOURCE_LSE
                                    \\ - RCC_RNGCLKSOURCE_HSI
                                    \\ - RCC_RNGCLKSOURCE_LSI
                                , .{ "RNGCLockSelection", "!(LSEOscillatorRTC|LSEByPassRTC) & scale2", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        RNGCLKSOURCE_HSI = true;
                        break :blk .RCC_RNGCLKSOURCE_HSI;
                    };
                }
                const conf_item = config.RNGCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_RNGCLKSOURCE_LSE => {},
                        .RCC_RNGCLKSOURCE_PLL1Q => rng_pll1q = true,
                        .RCC_RNGCLKSOURCE_HSI => RNGCLKSOURCE_HSI = true,
                        .RCC_RNGCLKSOURCE_LSI => {},
                    }
                }

                break :blk conf_item orelse {
                    RNGCLKSOURCE_HSI = true;
                    break :blk .RCC_RNGCLKSOURCE_HSI;
                };
            };
            const RCC_MCO1SourceValue: ?RCC_MCO1SourceList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and scale2) {
                    const conf_item = config.RCC_MCO1Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => {},
                            .RCC_MCO1SOURCE_HSI => {},
                            .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                            .RCC_MCO1SOURCE_LSI => {},
                            .RCC_MCO1SOURCE_HCLK5 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MCO1SOURCE_SYSCLK
                                    \\ - RCC_MCO1SOURCE_HSI
                                    \\ - RCC_MCO1SOURCE_HSE
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_HCLK5
                                , .{ "RCC_MCO1Source", "(LSEOscillatorRTC|LSEByPassRTC) & scale2", "LSE only for RTC or PLL in range 2", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
                } else if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and !scale2) {
                    const conf_item = config.RCC_MCO1Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => {},
                            .RCC_MCO1SOURCE_HSI => {},
                            .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                            .RCC_MCO1SOURCE_PLL1RCLK => mco1_pll1r = true,
                            .RCC_MCO1SOURCE_LSI => {},
                            .RCC_MCO1SOURCE_PLL1PCLK => mco1_pll1p = true,
                            .RCC_MCO1SOURCE_PLL1QCLK => mco1_pll1q = true,
                            .RCC_MCO1SOURCE_HCLK5 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MCO1SOURCE_SYSCLK
                                    \\ - RCC_MCO1SOURCE_HSI
                                    \\ - RCC_MCO1SOURCE_HSE
                                    \\ - RCC_MCO1SOURCE_PLL1RCLK
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_PLL1PCLK
                                    \\ - RCC_MCO1SOURCE_PLL1QCLK
                                    \\ - RCC_MCO1SOURCE_HCLK5
                                , .{ "RCC_MCO1Source", "(LSEOscillatorRTC|LSEByPassRTC) & !scale2", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
                } else if (!(config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC) and scale2) {
                    const conf_item = config.RCC_MCO1Source;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_MCO1SOURCE_SYSCLK => {},
                            .RCC_MCO1SOURCE_HSI => {},
                            .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                            .RCC_MCO1SOURCE_LSE => {},
                            .RCC_MCO1SOURCE_LSI => {},
                            .RCC_MCO1SOURCE_HCLK5 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_MCO1SOURCE_SYSCLK
                                    \\ - RCC_MCO1SOURCE_HSI
                                    \\ - RCC_MCO1SOURCE_HSE
                                    \\ - RCC_MCO1SOURCE_LSE
                                    \\ - RCC_MCO1SOURCE_LSI
                                    \\ - RCC_MCO1SOURCE_HCLK5
                                , .{ "RCC_MCO1Source", "!(LSEOscillatorRTC|LSEByPassRTC) & scale2", "PLL not allowed in range 2", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .RCC_MCO1SOURCE_SYSCLK;
                }
                const conf_item = config.RCC_MCO1Source;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_SYSCLK => {},
                        .RCC_MCO1SOURCE_HSI => {},
                        .RCC_MCO1SOURCE_HSE => MCO1SOURCE_HSE = true,
                        .RCC_MCO1SOURCE_PLL1RCLK => mco1_pll1r = true,
                        .RCC_MCO1SOURCE_LSE => {},
                        .RCC_MCO1SOURCE_LSI => {},
                        .RCC_MCO1SOURCE_PLL1PCLK => mco1_pll1p = true,
                        .RCC_MCO1SOURCE_PLL1QCLK => mco1_pll1q = true,
                        .RCC_MCO1SOURCE_HCLK5 => {},
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
            const LSCOSource1Value: ?LSCOSource1List = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    LSCOSSourceLSI = true;
                    const item: LSCOSource1List = .RCC_LSCOSOURCE_LSI;
                    const conf_item = config.LSCOSource1;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "LSCOSource1", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", "RCC_LSCOSOURCE_LSI", i });
                        }
                    }
                    break :blk item;
                }
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
            const AHB5CLKDividerValue: ?AHB5CLKDividerList = blk: {
                if (SysSourcePLL) {
                    const conf_item = config.AHB5CLKDivider;
                    if (conf_item) |item| {
                        switch (item) {
                            .DIV1 => AHB5_1 = true,
                            .DIV2 => AHB5_2 = true,
                            .DIV3 => AHB5_3 = true,
                            .DIV4 => AHB5_4 = true,
                            .DIV6 => AHB5_6 = true,
                        }
                    }

                    break :blk conf_item orelse null;
                }
                const conf_item = config.AHB5CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .DIV1 => AHB5_1 = true,
                        .DIV2 => AHB5_2 = true,
                        else => {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Option not available in this condition: {any}.
                                \\note: available options:
                                \\ - DIV1
                                \\ - DIV2
                            , .{ "AHB5CLKDivider", "Else", "No Extra Log", item });
                        },
                    }
                }

                break :blk conf_item orelse null;
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
                    }
                }

                break :blk conf_item orelse {
                    AHBCLKDivider1 = true;
                    break :blk .RCC_SYSCLK_DIV1;
                };
            };
            const Cortex_DivValue: ?f32 = blk: {
                break :blk 8;
            };
            const CortexCLockSelectionValue: ?CortexCLockSelectionList = blk: {
                if ((config.flags.LSEOscillatorRTC or config.flags.LSEByPassRTC)) {
                    const conf_item = config.CortexCLockSelection;
                    if (conf_item) |item| {
                        switch (item) {
                            .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_1_8 = true,
                            .RCC_SYSTICKCLKSOURCE_LSI => CLKSOURCE_LSI = true,
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - RCC_SYSTICKCLKSOURCE_HCLK_DIV8
                                    \\ - RCC_SYSTICKCLKSOURCE_LSI
                                , .{ "CortexCLockSelection", "(LSEOscillatorRTC|LSEByPassRTC)", "LSE is only for RTC", item });
                            },
                        }
                    }

                    break :blk conf_item orelse {
                        CLKSOURCE_HCLK_1_8 = true;
                        break :blk .RCC_SYSTICKCLKSOURCE_HCLK_DIV8;
                    };
                }
                const conf_item = config.CortexCLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SYSTICKCLKSOURCE_HCLK_DIV8 => CLKSOURCE_HCLK_1_8 = true,
                        .RCC_SYSTICKCLKSOURCE_LSE => CLKSOURCE_LSE = true,
                        .RCC_SYSTICKCLKSOURCE_LSI => CLKSOURCE_LSI = true,
                    }
                }

                break :blk conf_item orelse {
                    CLKSOURCE_HCLK_1_8 = true;
                    break :blk .RCC_SYSTICKCLKSOURCE_HCLK_DIV8;
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
            const APB7CLKDividerValue: ?APB7CLKDividerList = blk: {
                const conf_item = config.APB7CLKDivider;
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
            const SPI1CLockSelectionValue: ?SPI1CLockSelectionList = blk: {
                const conf_item = config.SPI1CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI1CLKSOURCE_PCLK2 => {},
                        .RCC_SPI1CLKSOURCE_SYSCLK => {},
                        .RCC_SPI1CLKSOURCE_HSI => SPI1CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI1CLKSOURCE_PCLK2;
            };
            const SPI3CLockSelectionValue: ?SPI3CLockSelectionList = blk: {
                const conf_item = config.SPI3CLockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_SPI3CLKSOURCE_PCLK7 => {},
                        .RCC_SPI3CLKSOURCE_SYSCLK => {},
                        .RCC_SPI3CLKSOURCE_HSI => SPI3CLKSOURCE_HSI = true,
                    }
                }

                break :blk conf_item orelse .RCC_SPI3CLKSOURCE_PCLK7;
            };
            const PLLNValue: ?f32 = blk: {
                const config_val = config.PLLN;
                if (config_val) |val| {
                    if (val < 4) {
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
                            4,
                            val,
                        });
                    }
                    if (val > 512) {
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
                            512,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 129;
            };
            const PLLFRACNValue: ?f32 = blk: {
                const config_val = config.PLLFRACN;
                PLLFRACN.limit = .{
                    .min = 0,
                    .max = 8191,
                };

                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const PLL1PValue: ?PLL1PList = blk: {
                const conf_item = config.PLL1P;
                if (conf_item) |item| {
                    switch (item) {
                        .@"1" => {},
                        .@"2" => {},
                        .@"4" => {},
                        .@"6" => {},
                        .@"8" => {},
                        .@"10" => {},
                        .@"12" => {},
                        .@"14" => {},
                        .@"16" => {},
                        .@"18" => {},
                        .@"20" => {},
                        .@"22" => {},
                        .@"24" => {},
                        .@"26" => {},
                        .@"28" => {},
                        .@"30" => {},
                        .@"32" => {},
                        .@"34" => {},
                        .@"36" => {},
                        .@"38" => {},
                        .@"40" => {},
                        .@"42" => {},
                        .@"44" => {},
                        .@"46" => {},
                        .@"48" => {},
                        .@"50" => {},
                        .@"52" => {},
                        .@"54" => {},
                        .@"56" => {},
                        .@"58" => {},
                        .@"60" => {},
                        .@"62" => {},
                        .@"64" => {},
                        .@"66" => {},
                        .@"68" => {},
                        .@"70" => {},
                        .@"72" => {},
                        .@"74" => {},
                        .@"76" => {},
                        .@"78" => {},
                        .@"80" => {},
                        .@"82" => {},
                        .@"84" => {},
                        .@"86" => {},
                        .@"88" => {},
                        .@"90" => {},
                        .@"92" => {},
                        .@"94" => {},
                        .@"96" => {},
                        .@"98" => {},
                        .@"100" => {},
                        .@"102" => {},
                        .@"104" => {},
                        .@"106" => {},
                        .@"108" => {},
                        .@"110" => {},
                        .@"112" => {},
                        .@"114" => {},
                        .@"116" => {},
                        .@"118" => {},
                        .@"120" => {},
                        .@"122" => {},
                        .@"124" => {},
                        .@"126" => {},
                        .@"128" => {},
                    }
                }

                break :blk conf_item orelse .@"2";
            };
            const PLL1QValue: ?f32 = blk: {
                const config_val = config.PLL1Q;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1Q",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1Q",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
            };
            const PLL1RValue: ?f32 = blk: {
                const config_val = config.PLL1R;
                if (config_val) |val| {
                    if (val < 1) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1R",
                            "Else",
                            "No Extra Log",
                            1,
                            val,
                        });
                    }
                    if (val > 128) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Overflow Value - max: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "PLL1R",
                            "Else",
                            "No Extra Log",
                            128,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 2;
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
            const HSE_TrimmingValue: ?f32 = blk: {
                const config_val = config.extra.HSE_Trimming;
                if (config_val) |val| {
                    if (val < 0) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Underflow Value - min: {d} found: {d}
                            \\note: ranges values may change depending on the configuration
                            \\
                        , .{
                            "HSE_Trimming",
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
                            "HSE_Trimming",
                            "Else",
                            "No Extra Log",
                            63,
                            val,
                        });
                    }
                }
                break :blk if (config_val) |i| @as(f32, @floatFromInt(i)) else 0;
            };
            const LSE_TrimmingValue: ?LSE_TrimmingList = blk: {
                const conf_item = config.extra.LSE_Trimming;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_LSETRIMMING_R => LSE_R = true,
                        .RCC_LSETRIMMING_1_2_R => {},
                        .RCC_LSETRIMMING_2_3_R => {},
                        .RCC_LSETRIMMING_3_4_R => {},
                    }
                }

                break :blk conf_item orelse {
                    LSE_R = true;
                    break :blk .RCC_LSETRIMMING_R;
                };
            };
            const LSEUsedValue: ?f32 = blk: {
                if (check_MCU("RNGCLKSOURCE_LSE") and config.flags.RNG_Used or check_MCU("RST_LSE") and config.flags.RF_Used or CLKSOURCE_LSE or (LSCOSSourceLSE and config.flags.LSCOConfig) or (check_MCU("Semaphore_input_Channel1TIM16") and config.flags.TIM16_Used and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM16")) or (check_MCU("SEM2RCC_LSE_REQUIRED_TIM2") and check_MCU("Semaphore_TIM2_L4_ETR_REMAPTIM2") and check_MCU("TIM2")) or (check_MCU("Semaphore_input_Channel1_directTIM15") and check_MCU("TIM15") and check_MCU("SEM2RCC_LSE_REQUIRED1_TIM15")) or (USART1SourceLSE and config.flags.USART1Used_ForRCC) or (USART2SourceLSE and config.flags.USART2Used_ForRCC) or (LPUART1SourceLSE and config.flags.LPUARTUsed_ForRCC) or (LPTIM1SOURCELSE and config.flags.LPTIM1Used_ForRCC) or (LPTIM2SOURCELSE and config.flags.LPTIM2_UsedUsed_ForRCC) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and config.flags.TIM17_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or (check_MCU("Semaphore_input_Channel1TIM16") and config.flags.TIM16_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig)) or (RTCSourceLSE and config.flags.RTCUsed_ForRCC)) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSE_Drive_CapabilityValue: ?LSE_Drive_CapabilityList = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEOscillatorRTC) and (check_ref(@TypeOf(LSEUsedValue), LSEUsedValue, 1, .@"="))) {
                    const conf_item = config.extra.LSE_Drive_Capability;
                    if (conf_item) |item| {
                        switch (item) {
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
            const EnableHSEValue: ?EnableHSEList = blk: {
                if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
                    const item: EnableHSEList = .true;
                    break :blk item;
                }
                const item: EnableHSEList = .false;
                break :blk item;
            };
            const LSIEnableValue: ?LSIEnableList = blk: {
                const item: LSIEnableList = .true;
                break :blk item;
            };
            const EnableExtClockForSAI1Value: ?EnableExtClockForSAI1List = blk: {
                if (config.flags.SAI1EXTCLK) {
                    const item: EnableExtClockForSAI1List = .true;
                    break :blk item;
                } else if (config.flags.SAI1EXTCLK) {
                    const item: EnableExtClockForSAI1List = .true;
                    break :blk item;
                }
                const item: EnableExtClockForSAI1List = .false;
                break :blk item;
            };
            const EnableHSERFDevisorValue: ?EnableHSERFDevisorList = blk: {
                if (config.flags.RF_Used and ((config.flags.HSEOscillator or config.flags.HSEByPass))) {
                    const item: EnableHSERFDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSERFDevisorList = .false;
                break :blk item;
            };
            const RFEnableValue: ?RFEnableList = blk: {
                if (config.flags.RF_Used) {
                    const item: RFEnableList = .true;
                    break :blk item;
                }
                const item: RFEnableList = .false;
                break :blk item;
            };
            const EnableHSERTCDevisorValue: ?EnableHSERTCDevisorList = blk: {
                if ((config.flags.RTCUsed_ForRCC and (config.flags.HSEOscillator or config.flags.HSEByPass))) {
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
            const USART2EnableValue: ?USART2EnableList = blk: {
                if (config.flags.USART2Used_ForRCC) {
                    const item: USART2EnableList = .true;
                    break :blk item;
                }
                const item: USART2EnableList = .false;
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
            const LPUART1EnableValue: ?LPUART1EnableList = blk: {
                if (config.flags.LPUARTUsed_ForRCC) {
                    const item: LPUART1EnableList = .true;
                    break :blk item;
                }
                const item: LPUART1EnableList = .false;
                break :blk item;
            };
            const LPTIM1EnableValue: ?LPTIM1EnableList = blk: {
                if (config.flags.LPTIM1Used_ForRCC) {
                    const item: LPTIM1EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM1EnableList = .false;
                break :blk item;
            };
            const LPTIM2EnableValue: ?LPTIM2EnableList = blk: {
                if (config.flags.LPTIM2Used_ForRCC) {
                    const item: LPTIM2EnableList = .true;
                    break :blk item;
                }
                const item: LPTIM2EnableList = .false;
                break :blk item;
            };
            const ADCEnableValue: ?ADCEnableList = blk: {
                if ((config.flags.USE_ADC4 and config.flags.ADC4_Used)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                } else if ((config.flags.USE_ADC4 and config.flags.ADC4_Used)) {
                    const item: ADCEnableList = .true;
                    break :blk item;
                }
                const item: ADCEnableList = .false;
                break :blk item;
            };
            const ASEnableValue: ?ASEnableList = blk: {
                if (config.flags.AUDIOSYNC) {
                    const item: ASEnableList = .true;
                    break :blk item;
                }
                const item: ASEnableList = .false;
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
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3Used_ForRCC) {
                    const item: I2C3EnableList = .true;
                    break :blk item;
                }
                const item: I2C3EnableList = .false;
                break :blk item;
            };
            const SAI1EnableValue: ?SAI1EnableList = blk: {
                if ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                } else if ((config.flags.SAI1_SAIBUsed_ForRCC or config.flags.SAI1_SAIAUsed_ForRCC)) {
                    const item: SAI1EnableList = .true;
                    break :blk item;
                }
                const item: SAI1EnableList = .false;
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
            const MCOEnableValue: ?MCOEnableList = blk: {
                if ((check_MCU("Semaphore_input_Channel1TIM17") and config.flags.TIM17_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or (check_MCU("Semaphore_input_Channel1TIM16") and config.flags.TIM16_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
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
            const SAESEnableValue: ?SAESEnableList = blk: {
                if (config.flags.SAES_Used) {
                    const item: SAESEnableList = .true;
                    break :blk item;
                }
                const item: SAESEnableList = .false;
                break :blk item;
            };
            const SystickEnableValue: ?SystickEnableList = blk: {
                if (check_MCU("Systick_External")) {
                    const item: SystickEnableList = .true;
                    break :blk item;
                }
                const item: SystickEnableList = .false;
                break :blk item;
            };
            const SPI1EnableValue: ?SPI1EnableList = blk: {
                if (config.flags.SPI1Used_ForRCC) {
                    const item: SPI1EnableList = .true;
                    break :blk item;
                }
                const item: SPI1EnableList = .false;
                break :blk item;
            };
            const SPI3EnableValue: ?SPI3EnableList = blk: {
                if (config.flags.SPI3Used_ForRCC) {
                    const item: SPI3EnableList = .true;
                    break :blk item;
                }
                const item: SPI3EnableList = .false;
                break :blk item;
            };
            const PLL1PUsedValue: ?f32 = blk: {
                if (SAI1SourcePLL1P and config.flags.SAI1_Used or config.flags.MCOConfig and mco1_pll1p or config.flags.ADC4_Used and adc_pll1p) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1QUsedValue: ?f32 = blk: {
                if (config.flags.MCOConfig and mco1_pll1q or sai1_pll1q and config.flags.SAI1_Used or rng_pll1q and config.flags.RNG_Used) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLL1RUsedValue: ?f32 = blk: {
                if (((SysSourcePLL) or ((check_ref(@TypeOf(RCC_MCO1SourceValue), RCC_MCO1SourceValue, .RCC_MCO1SOURCE_PLL1RCLK, .@"=")) and ((check_MCU("Semaphore_input_Channel1TIM17") and config.flags.TIM17_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM17")) or (check_MCU("Semaphore_input_Channel1TIM16") and config.flags.TIM16_Used and check_MCU("SEM2RCC_MCO_REQUIRED_TIM16")) or config.flags.MCOConfig)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const PLLUsedValue: ?f32 = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=") or check_ref(@TypeOf(PLL1RUsedValue), PLL1RUsedValue, 1, .@"=")) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const EnableCSSLSEValue: ?EnableCSSLSEList = blk: {
                if ((((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"="))) and config.flags.RTCUsed_ForRCC)) {
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
                if ((check_MCU("STM32WBA5MJGHx"))) {
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
                                "(STM32WBA5MJGHx)",
                                "HSE in Crystal/Bypass Mode",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = 32000000;
                    break :blk null;
                } else if ((config.flags.HSEOscillator or config.flags.HSEByPass)) {
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
                                "(HSEOscillator|HSEByPass)",
                                "HSE in Crystal/Bypass Mode",
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
                                "(HSEOscillator|HSEByPass)",
                                "HSE in Crystal/Bypass Mode",
                                3.2e7,
                                val,
                            });
                        }
                    }
                    HSEOSC.value = config_val orelse 16000000;

                    break :blk null;
                }
                if (config.HSE_VALUE) |val| {
                    if (val != 1.6e7) {
                        return comptime_fail_or_error(error.InvalidConfig,
                            \\
                            \\Error on {s} | expr: {s} diagnostic: {s} 
                            \\Expected Fixed Value: {e} found: {e}
                            \\note: some values are fixed depending on the clock configuration.
                            \\
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
                HSEOSC.value = 16000000;
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
            if (check_ref(@TypeOf(EnableHSEValue), EnableHSEValue, .true, .@"=")) {
                const HseDiv_clk_value = HseDivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HseDiv",
                    "Else",
                    "No Extra Log",
                    "HseDiv",
                });
                HseDiv.nodetype = .div;
                HseDiv.value = HseDiv_clk_value.get();
                HseDiv.parents = &.{&HSEOSC};
            }
            if (!check_MCU("STM32WBAx4") and !check_MCU("STM32WBAx5")) {
                if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                    const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSIRC",
                        "!STM32WBAx4 & !STM32WBAx5",
                        "No Extra Log",
                        "LSI_VALUE",
                    });
                    LSIRC.nodetype = .source;
                    LSIRC.value = LSIRC_clk_value;
                }
            } else if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5")) {
                if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                    const LSIRC_clk_value = LSI_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSIRC",
                        "STM32WBAx4|STM32WBAx5",
                        "No Extra Log",
                        "LSI_VALUE",
                    });
                    LSIRC.nodetype = .source;
                    LSIRC.value = LSIRC_clk_value;
                }
            }
            if (!check_MCU("STM32WBAx4") and !check_MCU("STM32WBAx5")) {
                const LSIOut_clk_value = LSIDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIOut",
                    "!STM32WBAx4 & !STM32WBAx5",
                    "No Extra Log",
                    "LSIDIV",
                });
                LSIOut.nodetype = .div;
                LSIOut.value = LSIOut_clk_value.get();
                LSIOut.parents = &.{&LSIRC};
            } else if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5")) {
                const LSIOut_clk_value = LSIDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIOut",
                    "STM32WBAx4|STM32WBAx5",
                    "No Extra Log",
                    "LSIDIV",
                });
                LSIOut.nodetype = .div;
                LSIOut.value = LSIOut_clk_value.get();
                LSIOut.parents = &.{&LSIDIV};
            }
            if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5")) {
                if (check_ref(@TypeOf(LSIEnableValue), LSIEnableValue, .true, .@"=")) {
                    const LSI2RC_clk_value = LSI2_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LSI2RC",
                        "STM32WBAx4|STM32WBAx5",
                        "No Extra Log",
                        "LSI2_VALUE",
                    });
                    LSI2RC.nodetype = .source;
                    LSI2RC.value = LSI2RC_clk_value;
                }
            }
            if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5")) {
                const LSIDIV_clk_value = LSIDIVValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LSIDIV",
                    "STM32WBAx4|STM32WBAx5",
                    "No Extra Log",
                    "LSIDIV",
                });
                LSIDIV.nodetype = .div;
                LSIDIV.value = LSIDIV_clk_value.get();
                LSIDIV.parents = &.{&LSIRC};
            }

            //POST CLOCK REF LSE_VALUE VALUE
            _ = blk: {
                if ((config.flags.LSEOscillator or config.flags.LSEOscillatorRTC)) {
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
                                "(LSEOscillator | LSEOscillatorRTC)",
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
            if (check_ref(@TypeOf(EnableExtClockForSAI1Value), EnableExtClockForSAI1Value, .true, .@"=")) {
                const SAI1_EXT_clk_value = EXTERNALSAI1_CLOCK_VALUEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SAI1_EXT",
                    "Else",
                    "No Extra Log",
                    "EXTERNALSAI1_CLOCK_VALUE",
                });
                SAI1_EXT.nodetype = .source;
                SAI1_EXT.value = SAI1_EXT_clk_value;
            }
            if (check_ref(@TypeOf(EnableHSERFDevisorValue), EnableHSERFDevisorValue, .true, .@"=")) {
                const HSERSTDevisor_clk_value = RCC_RST_Clock_Source_FROM_HSEValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "HSERSTDevisor",
                    "Else",
                    "No Extra Log",
                    "RCC_RST_Clock_Source_FROM_HSE",
                });
                HSERSTDevisor.nodetype = .div;
                HSERSTDevisor.value = HSERSTDevisor_clk_value;
                HSERSTDevisor.parents = &.{&HSEOSC};
            }
            if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5") or check_MCU("STM32WBAx0")) {
                if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                    const RSTClkSource_clk_value = RSTClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RSTClkSource",
                        "STM32WBAx4|STM32WBAx5|STM32WBAx0",
                        "No Extra Log",
                        "RSTClockSelection",
                    });
                    const RSTClkSourceparents = [_]*const ClockNode{
                        &HSERSTDevisor,
                        &LSEOSC,
                        &LSIOut,
                    };
                    RSTClkSource.nodetype = .multi;
                    RSTClkSource.parents = &.{RSTClkSourceparents[RSTClkSource_clk_value.get()]};
                }
            } else if (!check_MCU("STM32WBAx4") and !check_MCU("STM32WBAx5") and !check_MCU("STM32WBAx0")) {
                if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                    const RSTClkSource_clk_value = RSTClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RSTClkSource",
                        "!STM32WBAx4 & !STM32WBAx5 & !STM32WBAx0",
                        "No Extra Log",
                        "RSTClockSelection",
                    });
                    const RSTClkSourceparents = [_]*const ClockNode{
                        &HSERSTDevisor,
                        &LSEOSC,
                    };
                    RSTClkSource.nodetype = .multi;
                    RSTClkSource.parents = &.{RSTClkSourceparents[RSTClkSource_clk_value.get()]};
                }
            }
            if (!check_MCU("STM32WBAx4") and !check_MCU("STM32WBAx5") and !check_MCU("STM32WBAx0")) {
                if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                    RSTOutput.nodetype = .output;
                    RSTOutput.parents = &.{&RSTClkSource};
                }
            }
            if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                RSTOutput.nodetype = .output;
                RSTOutput.parents = &.{&RSTClkSource};
            }
            if (check_ref(@TypeOf(RFEnableValue), RFEnableValue, .true, .@"=")) {
                RSTRFOutput.nodetype = .output;
                RSTRFOutput.parents = &.{&HSEOSC};
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
                &HseDiv,
                &PLL1R,
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
                &HseDiv,
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
            if (!check_MCU("STM32WBAx4") and !check_MCU("STM32WBAx5")) {
                if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                    const RTCClkSource_clk_value = RTCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RTCClkSource",
                        "!STM32WBAx4& !STM32WBAx5",
                        "No Extra Log",
                        "RTCClockSelection",
                    });
                    const RTCClkSourceparents = [_]*const ClockNode{
                        &HSERTCDevisor,
                        &LSEOSC,
                        &LSIOut,
                    };
                    RTCClkSource.nodetype = .multi;
                    RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
                }
            } else if (check_MCU("STM32WBAx4") or check_MCU("STM32WBAx5")) {
                if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                    const RTCClkSource_clk_value = RTCClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "RTCClkSource",
                        "STM32WBAx4|STM32WBAx5",
                        "No Extra Log",
                        "RTCClockSelection",
                    });
                    const RTCClkSourceparents = [_]*const ClockNode{
                        &HSERTCDevisor,
                        &LSEOSC,
                        &LSIOut,
                    };
                    RTCClkSource.nodetype = .multi;
                    RTCClkSource.parents = &.{RTCClkSourceparents[RTCClkSource_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(RTCEnableValue), RTCEnableValue, .true, .@"=")) {
                RTCOutput.nodetype = .output;
                RTCOutput.parents = &.{&RTCClkSource};
            }
            if (check_ref(@TypeOf(IWDGEnableValue), IWDGEnableValue, .true, .@"=")) {
                IWDGOutput.nodetype = .output;
                IWDGOutput.parents = &.{&LSIOut};
            }
            if (check_MCU("USART2_Exist")) {
                if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                    const USART2Mult_clk_value = USART2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "USART2Mult",
                        "USART2_Exist",
                        "No Extra Log",
                        "USART2CLockSelection",
                    });
                    const USART2Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &SysCLKOutput,
                        &HSIRC,
                        &LSEOSC,
                    };
                    USART2Mult.nodetype = .multi;
                    USART2Mult.parents = &.{USART2Multparents[USART2Mult_clk_value.get()]};
                }
            }
            if (check_MCU("USART2_Exist")) {
                if (check_ref(@TypeOf(USART2EnableValue), USART2EnableValue, .true, .@"=")) {
                    USART2output.nodetype = .output;
                    USART2output.parents = &.{&USART2Mult};
                }
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
                    &APB2Prescaler,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                USART1Mult.nodetype = .multi;
                USART1Mult.parents = &.{USART1Multparents[USART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(USART1EnableValue), USART1EnableValue, .true, .@"=")) {
                USART1output.nodetype = .output;
                USART1output.parents = &.{&USART1Mult};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                const LPUART1Mult_clk_value = LPUART1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPUART1Mult",
                    "Else",
                    "No Extra Log",
                    "LPUART1CLockSelection",
                });
                const LPUART1Multparents = [_]*const ClockNode{
                    &APB7Output,
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                };
                LPUART1Mult.nodetype = .multi;
                LPUART1Mult.parents = &.{LPUART1Multparents[LPUART1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPUART1EnableValue), LPUART1EnableValue, .true, .@"=")) {
                LPUART1output.nodetype = .output;
                LPUART1output.parents = &.{&LPUART1Mult};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                const LPTIM1Mult_clk_value = LPTIM1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "LPTIM1Mult",
                    "Else",
                    "No Extra Log",
                    "LPTIM1CLockSelection",
                });
                const LPTIM1Multparents = [_]*const ClockNode{
                    &APB7Output,
                    &LSIOut,
                    &HSIRC,
                    &LSEOSC,
                };
                LPTIM1Mult.nodetype = .multi;
                LPTIM1Mult.parents = &.{LPTIM1Multparents[LPTIM1Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LPTIM1EnableValue), LPTIM1EnableValue, .true, .@"=")) {
                LPTIM1output.nodetype = .output;
                LPTIM1output.parents = &.{&LPTIM1Mult};
            }
            if (check_MCU("LPTIM2_Exist")) {
                if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                    const LPTIM2Mult_clk_value = LPTIM2CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "LPTIM2Mult",
                        "LPTIM2_Exist",
                        "No Extra Log",
                        "LPTIM2CLockSelection",
                    });
                    const LPTIM2Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &LSIOut,
                        &HSIRC,
                        &LSEOSC,
                    };
                    LPTIM2Mult.nodetype = .multi;
                    LPTIM2Mult.parents = &.{LPTIM2Multparents[LPTIM2Mult_clk_value.get()]};
                }
            }
            if (check_MCU("LPTIM2_Exist")) {
                if (check_ref(@TypeOf(LPTIM2EnableValue), LPTIM2EnableValue, .true, .@"=")) {
                    LPTIM2output.nodetype = .output;
                    LPTIM2output.parents = &.{&LPTIM2Mult};
                }
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
                    &AHBOutput,
                    &SysCLKOutput,
                    &HSEOSC,
                    &HSIRC,
                    &PLL1P,
                };
                ADCMult.nodetype = .multi;
                ADCMult.parents = &.{ADCMultparents[ADCMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=")) {
                ADCoutput.nodetype = .output;
                ADCoutput.parents = &.{&ADCMult};
            }
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=")) {
                const ASMult_clk_value = ASClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ASMult",
                    "Else",
                    "No Extra Log",
                    "ASClockSelection",
                });
                const ASMultparents = [_]*const ClockNode{
                    &PLL1P,
                    &PLL1Q,
                };
                ASMult.nodetype = .multi;
                ASMult.parents = &.{ASMultparents[ASMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=")) {
                ASoutput.nodetype = .output;
                ASoutput.parents = &.{&ASMult};
            }
            if (check_MCU("I2C1_Exist")) {
                if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                    const I2C1Mult_clk_value = I2C1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "I2C1Mult",
                        "I2C1_Exist",
                        "No Extra Log",
                        "I2C1CLockSelection",
                    });
                    const I2C1Multparents = [_]*const ClockNode{
                        &APB1Prescaler,
                        &SysCLKOutput,
                        &HSIRC,
                    };
                    I2C1Mult.nodetype = .multi;
                    I2C1Mult.parents = &.{I2C1Multparents[I2C1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("I2C1_Exist")) {
                if (check_ref(@TypeOf(I2C1EnableValue), I2C1EnableValue, .true, .@"=")) {
                    I2C1output.nodetype = .output;
                    I2C1output.parents = &.{&I2C1Mult};
                }
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                const I2C3Mult_clk_value = I2C3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C3Mult",
                    "Else",
                    "No Extra Log",
                    "I2C3CLockSelection",
                });
                const I2C3Multparents = [_]*const ClockNode{
                    &APB7Output,
                    &SysCLKOutput,
                    &HSIRC,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                I2C3output.nodetype = .output;
                I2C3output.parents = &.{&I2C3Mult};
            }
            if (check_MCU("SAI1_Exist")) {
                if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                    const SAI1Mult_clk_value = SAI1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SAI1Mult",
                        "SAI1_Exist",
                        "No Extra Log",
                        "SAI1CLockSelection",
                    });
                    const SAI1Multparents = [_]*const ClockNode{
                        &PLL1P,
                        &HSIRC,
                        &PLL1Q,
                        &SAI1_EXT,
                        &SysCLKOutput,
                    };
                    SAI1Mult.nodetype = .multi;
                    SAI1Mult.parents = &.{SAI1Multparents[SAI1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SAI1_Exist")) {
                if (check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=")) {
                    SAI1output.nodetype = .output;
                    SAI1output.parents = &.{&SAI1Mult};
                }
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const pllqDivToRNG_clk_value = pllqDivToRNGValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "pllqDivToRNG",
                    "Else",
                    "No Extra Log",
                    "pllqDivToRNG",
                });
                pllqDivToRNG.nodetype = .div;
                pllqDivToRNG.value = pllqDivToRNG_clk_value;
                pllqDivToRNG.parents = &.{&PLL1Q};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                const RNGMult_clk_value = RNGCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "RNGMult",
                    "Else",
                    "No Extra Log",
                    "RNGCLockSelection",
                });
                const RNGMultparents = [_]*const ClockNode{
                    &LSEOSC,
                    &pllqDivToRNG,
                    &HSIRC,
                    &LSIOut,
                };
                RNGMult.nodetype = .multi;
                RNGMult.parents = &.{RNGMultparents[RNGMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=")) {
                RNGoutput.nodetype = .output;
                RNGoutput.parents = &.{&RNGMult};
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
                    &LSIOut,
                    &HSEOSC,
                    &HSIRC,
                    &PLL1R,
                    &SysCLKOutput,
                    &PLL1P,
                    &PLL1Q,
                    &AHB5Output,
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
                    &LSIOut,
                    &LSEOSC,
                };
                LSCOMult.nodetype = .multi;
                LSCOMult.parents = &.{LSCOMultparents[LSCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(LSCOEnableValue), LSCOEnableValue, .true, .@"=")) {
                LSCOOutput.nodetype = .output;
                LSCOOutput.parents = &.{&LSCOMult};
            }

            const AHB5Prescaler_clk_value = AHB5CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "AHB5Prescaler",
                "Else",
                "No Extra Log",
                "AHB5CLKDivider",
            });
            AHB5Prescaler.nodetype = .div;
            AHB5Prescaler.value = AHB5Prescaler_clk_value.get();
            AHB5Prescaler.parents = &.{&SysCLKOutput};
            AHB5Output.nodetype = .output;
            AHB5Output.parents = &.{&AHB5Prescaler};
            if (check_MCU("SAES_Exist")) {
                if (check_ref(@TypeOf(SAESEnableValue), SAESEnableValue, .true, .@"=")) {
                    SAESOutput.nodetype = .output;
                    SAESOutput.parents = &.{&AHBOutput};
                }
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
            HCLK4Output.nodetype = .output;
            HCLK4Output.parents = &.{&AHBOutput};

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
            CortexPrescaler.value = CortexPrescaler_clk_value;
            CortexPrescaler.parents = &.{&AHBOutput};
            if (check_ref(@TypeOf(SystickEnableValue), SystickEnableValue, .true, .@"=")) {
                const CortexCLockSelection_clk_value = CortexCLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "CortexCLockSelection",
                    "Else",
                    "No Extra Log",
                    "CortexCLockSelection",
                });
                const CortexCLockSelectionparents = [_]*const ClockNode{
                    &CortexPrescaler,
                    &LSEOSC,
                    &LSIOut,
                };
                CortexCLockSelection.nodetype = .multi;
                CortexCLockSelection.parents = &.{CortexCLockSelectionparents[CortexCLockSelection_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SystickEnableValue), SystickEnableValue, .true, .@"=")) {
                CortexSysOutput.nodetype = .output;
                CortexSysOutput.parents = &.{&CortexCLockSelection};
            }
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

            const APB7Prescaler_clk_value = APB7CLKDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "APB7Prescaler",
                "Else",
                "No Extra Log",
                "APB7CLKDivider",
            });
            APB7Prescaler.nodetype = .div;
            APB7Prescaler.value = APB7Prescaler_clk_value.get();
            APB7Prescaler.parents = &.{&AHBOutput};
            APB7Output.nodetype = .output;
            APB7Output.parents = &.{&APB7Prescaler};

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
            if (check_MCU("SPI1_Exist")) {
                if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                    const SPI1Mult_clk_value = SPI1CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "SPI1Mult",
                        "SPI1_Exist",
                        "No Extra Log",
                        "SPI1CLockSelection",
                    });
                    const SPI1Multparents = [_]*const ClockNode{
                        &APB2Prescaler,
                        &SysCLKOutput,
                        &HSIRC,
                    };
                    SPI1Mult.nodetype = .multi;
                    SPI1Mult.parents = &.{SPI1Multparents[SPI1Mult_clk_value.get()]};
                }
            }
            if (check_MCU("SPI1_Exist")) {
                if (check_ref(@TypeOf(SPI1EnableValue), SPI1EnableValue, .true, .@"=")) {
                    SPI1output.nodetype = .output;
                    SPI1output.parents = &.{&SPI1Mult};
                }
            }
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                const SPI3Mult_clk_value = SPI3CLockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "SPI3Mult",
                    "Else",
                    "No Extra Log",
                    "SPI3CLockSelection",
                });
                const SPI3Multparents = [_]*const ClockNode{
                    &APB7Output,
                    &SysCLKOutput,
                    &HSIRC,
                };
                SPI3Mult.nodetype = .multi;
                SPI3Mult.parents = &.{SPI3Multparents[SPI3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(SPI3EnableValue), SPI3EnableValue, .true, .@"=")) {
                SPI3output.nodetype = .output;
                SPI3output.parents = &.{&SPI3Mult};
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
            PLLN.nodetype = .mulfrac;
            PLLN.value = PLLN_clk_value;
            PLLN.parents = &.{ &PLLM, &PLLFRACN };

            const PLLFRACN_clk_value = PLLFRACNValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLFRACN",
                "Else",
                "No Extra Log",
                "PLLFRACN",
            });
            PLLFRACN.nodetype = .source;
            PLLFRACN.value = PLLFRACN_clk_value;
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"="))
            {
                const PLL1P_clk_value = PLL1PValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1P",
                    "Else",
                    "No Extra Log",
                    "PLL1P",
                });
                PLL1P.nodetype = .div;
                PLL1P.value = PLL1P_clk_value.get();
                PLL1P.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADCEnableValue), ADCEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"="))
            {
                PLLPoutput.nodetype = .output;
                PLLPoutput.parents = &.{&PLL1P};
            }
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"="))
            {
                const PLL1Q_clk_value = PLL1QValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "PLL1Q",
                    "Else",
                    "No Extra Log",
                    "PLL1Q",
                });
                PLL1Q.nodetype = .div;
                PLL1Q.value = PLL1Q_clk_value;
                PLL1Q.parents = &.{&PLLN};
            }
            if (check_ref(@TypeOf(ASEnableValue), ASEnableValue, .true, .@"=") or
                check_ref(@TypeOf(SAI1EnableValue), SAI1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(RNGEnableValue), RNGEnableValue, .true, .@"=") or
                check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"="))
            {
                PLLQoutput.nodetype = .output;
                PLLQoutput.parents = &.{&PLL1Q};
            }

            const PLL1R_clk_value = PLL1RValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLL1R",
                "Else",
                "No Extra Log",
                "PLL1R",
            });
            PLL1R.nodetype = .div;
            PLL1R.value = PLL1R_clk_value;
            PLL1R.parents = &.{&PLLN};
            VCOInput.nodetype = .output;
            VCOInput.parents = &.{&PLLM};
            VCOOutput.nodetype = .output;
            VCOOutput.parents = &.{&PLLN};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLL1R};
            LSI1.nodetype = .output;
            LSI1.parents = &.{&LSIRC};
            HSESYS.nodetype = .output;
            HSESYS.parents = &.{&HseDiv};

            //POST CLOCK REF RSTFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    RSTOutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    RSTOutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                RSTOutput.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF RSTRFFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    RSTRFOutput.limit = .{
                        .min = null,
                        .max = 3.2e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    RSTRFOutput.limit = .{
                        .min = null,
                        .max = 3.2e7,
                    };

                    break :blk null;
                }
                RSTRFOutput.value = 32000;
                break :blk null;
            };

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                SysCLKOutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF RTCFreq_Value VALUE
            _ = blk: {
                RTCOutput.limit = .{
                    .min = null,
                    .max = 1.5625e6,
                };

                break :blk null;
            };

            //POST CLOCK REF USART2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART2output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                USART2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF USART1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    USART1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                USART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPUART1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPUART1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                LPUART1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                LPTIM1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF LPTIM2Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    LPTIM2output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                LPTIM2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };
            const PWR_Regulator_Voltage_ScaleValue: ?PWR_Regulator_Voltage_ScaleList = blk: {
                if (((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"="))) and config.flags.RF_Used and RST_HSE) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "((HCLKFreq_Value < 16000000) | (HCLKFreq_Value=16000000)) & RF_Used & RST_HSE", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"=")))) {
                    const conf_item = config.extra.PWR_Regulator_Voltage_Scale;
                    if (conf_item) |item| {
                        switch (item) {
                            .PWR_REGULATOR_VOLTAGE_SCALE2 => scale2 = true,
                            .PWR_REGULATOR_VOLTAGE_SCALE1 => scale1 = true,
                        }
                    }

                    break :blk conf_item orelse {
                        scale2 = true;
                        break :blk .PWR_REGULATOR_VOLTAGE_SCALE2;
                    };
                } else if ((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@">"))) {
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
                            , .{ "PWR_Regulator_Voltage_Scale", "(HCLKFreq_Value > 16000000)", "No Extra Log", "PWR_REGULATOR_VOLTAGE_SCALE1", i });
                        }
                    }
                    break :blk item;
                }
                break :blk null;
            };

            //POST CLOCK REF ADCFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ADCoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                ADCoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF ASFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    ASoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    ASoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                ASoutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                I2C1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF I2C3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    I2C3output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                I2C3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SAI1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SAI1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                SAI1output.value = 2285714;
                break :blk null;
            };

            //POST CLOCK REF RNGFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 4.8e7,
                    };

                    break :blk null;
                } else if (scale2) {
                    RNGoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                RNGoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF MCO1PinFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    MCOPin.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    MCOPin.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                MCOPin.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF AHB5Freq_Value VALUE
            _ = blk: {
                AHB5Output.limit = .{
                    .min = null,
                    .max = 3.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SAESFreq_Value VALUE
            _ = blk: {
                SAESOutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHBFreq_Value VALUE
            _ = blk: {
                HCLKOutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF AHB4Freq_Value VALUE
            _ = blk: {
                HCLK4Output.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF CortexFreq_Value VALUE
            _ = blk: {
                if (scale1) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    CortexSysOutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                CortexSysOutput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF FCLKCortexFreq_Value VALUE
            _ = blk: {
                FCLKCortexOutput.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                APB1Output.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1TimFreq_Value VALUE
            _ = blk: {
                TimPrescOut1.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                APB2Output.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB7Freq_Value VALUE
            _ = blk: {
                APB7Output.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2TimFreq_Value VALUE
            _ = blk: {
                TimPrescOut2.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };

            //POST CLOCK REF SPI1Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI1output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                SPI1output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF SPI3Freq_Value VALUE
            _ = blk: {
                if (scale1) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (scale2) {
                    SPI3output.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                SPI3output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF PLLPoutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=") and scale1) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL1PUsedValue), PLL1PUsedValue, 1, .@"=") and scale2) {
                    PLLPoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                PLLPoutput.value = 4571429;
                break :blk null;
            };

            //POST CLOCK REF PLLQoutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=") and scale1) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (check_ref(@TypeOf(PLL1QUsedValue), PLL1QUsedValue, 1, .@"=") and scale2) {
                    PLLQoutput.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                PLLQoutput.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF VCOInputFreq_Value VALUE
            _ = blk: {
                if ((check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) {
                    VCOInput.limit = .{
                        .min = 4e6,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                VCOInput.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF VCOOutputFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCOOutput.limit = .{
                        .min = 1.28e8,
                        .max = 5.44e8,
                    };

                    break :blk null;
                }
                VCOOutput.value = 32000000;
                break :blk null;
            };

            //POST CLOCK REF PLLRCLKFreq_Value VALUE
            _ = blk: {
                if (config.flags.PLLRUsed and scale1) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 1e8,
                    };

                    break :blk null;
                } else if (config.flags.PLLRUsed and scale2) {
                    PLLCLK.limit = .{
                        .min = null,
                        .max = 1.6e7,
                    };

                    break :blk null;
                }
                PLLCLK.value = 16000000;
                break :blk null;
            };

            //POST CLOCK REF LSI1_VALUE VALUE
            _ = blk: {
                LSI1.limit = .{
                    .min = 3.14e4,
                    .max = 3.26e4,
                };

                break :blk null;
            };

            //POST CLOCK REF HSESYSFreq_VALUE VALUE
            _ = blk: {
                HSESYS.limit = .{
                    .min = null,
                    .max = 1e8,
                };

                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 8000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_1
                                    \\ - FLASH_LATENCY_0
                                , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 8000000)|(HCLKFreq_Value=8000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale2 and ((check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 16000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale2 & ((HCLKFreq_Value < 16000000)|(HCLKFreq_Value=16000000 )))", "No Extra Log", "FLASH_LATENCY_1", i });
                        }
                    }
                    break :blk item;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 32000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            .FLASH_LATENCY_0 => {},
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_0;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 64000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 64000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            .FLASH_LATENCY_1 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                    \\ - FLASH_LATENCY_1
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 64000000) |(HCLKFreq_Value=64000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_1;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 96000000, .@"="))))) {
                    const conf_item = config.extra.FLatency;
                    if (conf_item) |item| {
                        switch (item) {
                            .FLASH_LATENCY_3 => {},
                            .FLASH_LATENCY_2 => {},
                            else => {
                                return comptime_fail_or_error(error.InvalidConfig,
                                    \\
                                    \\Error on {s} | expr: {s} diagnostic: {s} 
                                    \\Option not available in this condition: {any}.
                                    \\note: available options:
                                    \\ - FLASH_LATENCY_3
                                    \\ - FLASH_LATENCY_2
                                , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 96000000) |(HCLKFreq_Value=96000000)))", "No Extra Log", item });
                            },
                        }
                    }

                    break :blk conf_item orelse .FLASH_LATENCY_2;
                } else if ((scale1 and ((check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"<")) or (check_ref(?f32, AHBOutput.get_as_ref(), 100000000, .@"="))))) {
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
                            , .{ "FLatency", "(scale1 & ((HCLKFreq_Value < 100000000) |(HCLKFreq_Value=100000000)))", "No Extra Log", "FLASH_LATENCY_3", i });
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
            const PLL1_VCI_RangeValue: ?PLL1_VCI_RangeList = blk: {
                if (((check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 4000000, .@"="))) and (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"<"))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE0;
                    break :blk item;
                } else if (((check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@">") or (check_ref(?f32, VCOInput.get_as_ref(), 8000000, .@"="))) and ((check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"<")) or (check_ref(?f32, VCOInput.get_as_ref(), 16000000, .@"=")))) and check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE1;
                    break :blk item;
                }
                const item: PLL1_VCI_RangeList = .RCC_PLL_VCOINPUT_RANGE1;
                break :blk item;
            };

            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexCLockSelection = try CortexCLockSelection.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.HCLK4Output = try HCLK4Output.get_output();
            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.USART2output = try USART2output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.LPTIM2output = try LPTIM2output.get_output();
            out.LPTIM2Mult = try LPTIM2Mult.get_output();
            out.I2C1output = try I2C1output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.USART1output = try USART1output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.SPI1output = try SPI1output.get_output();
            out.SPI1Mult = try SPI1Mult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.APB7Output = try APB7Output.get_output();
            out.APB7Prescaler = try APB7Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.LPUART1output = try LPUART1output.get_output();
            out.LPUART1Mult = try LPUART1Mult.get_output();
            out.I2C3output = try I2C3output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.ADCoutput = try ADCoutput.get_output();
            out.ADCMult = try ADCMult.get_output();
            out.MCOPin = try MCOPin.get_output();
            out.MCODiv = try MCODiv.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.PLLQoutput = try PLLQoutput.get_output();
            out.PLL1Q = try PLL1Q.get_output();
            out.PLLPoutput = try PLLPoutput.get_output();
            out.PLL1P = try PLL1P.get_output();
            out.PLL1R = try PLL1R.get_output();
            out.PLLN = try PLLN.get_output();
            out.PLLM = try PLLM.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.LPTIM1output = try LPTIM1output.get_output();
            out.LPTIM1Mult = try LPTIM1Mult.get_output();
            out.SAI1output = try SAI1output.get_output();
            out.SAI1Mult = try SAI1Mult.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.RSTOutput = try RSTOutput.get_output();
            out.RSTClkSource = try RSTClkSource.get_output();
            out.HSERSTDevisor = try HSERSTDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.HseDiv = try HseDiv.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.LSCOOutput = try LSCOOutput.get_output();
            out.LSCOMult = try LSCOMult.get_output();
            out.LSIOut = try LSIOut.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSI2RC = try LSI2RC.get_output();
            out.LSIDIV = try LSIDIV.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.SAI1_EXT = try SAI1_EXT.get_output();
            out.RSTRFOutput = try RSTRFOutput.get_output();
            out.ASoutput = try ASoutput.get_output();
            out.ASMult = try ASMult.get_output();
            out.RNGoutput = try RNGoutput.get_output();
            out.RNGMult = try RNGMult.get_output();
            out.pllqDivToRNG = try pllqDivToRNG.get_output();
            out.AHB5Output = try AHB5Output.get_output();
            out.AHB5Prescaler = try AHB5Prescaler.get_output();
            out.SAESOutput = try SAESOutput.get_output();
            out.SPI3output = try SPI3output.get_output();
            out.SPI3Mult = try SPI3Mult.get_output();
            out.PLLFRACN = try PLLFRACN.get_output();
            out.VCOInput = try VCOInput.get_extra_output();
            out.VCOOutput = try VCOOutput.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            out.LSI1 = try LSI1.get_extra_output();
            out.HSESYS = try HSESYS.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.HseDiv = HseDivValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSIDIV = LSIDIVValue;
            ref_out.LSI2_VALUE = LSI2_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.EXTERNALSAI1_CLOCK_VALUE = EXTERNALSAI1_CLOCK_VALUEValue;
            ref_out.RCC_RST_Clock_Source_FROM_HSE = RCC_RST_Clock_Source_FROM_HSEValue;
            ref_out.RSTClockSelection = RSTClockSelectionValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLM = PLLMValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.USART2CLockSelection = USART2CLockSelectionValue;
            ref_out.USART1CLockSelection = USART1CLockSelectionValue;
            ref_out.LPUART1CLockSelection = LPUART1CLockSelectionValue;
            ref_out.LPTIM1CLockSelection = LPTIM1CLockSelectionValue;
            ref_out.LPTIM2CLockSelection = LPTIM2CLockSelectionValue;
            ref_out.ADCCLockSelection = ADCCLockSelectionValue;
            ref_out.ASClockSelection = ASClockSelectionValue;
            ref_out.I2C1CLockSelection = I2C1CLockSelectionValue;
            ref_out.I2C3CLockSelection = I2C3CLockSelectionValue;
            ref_out.SAI1CLockSelection = SAI1CLockSelectionValue;
            ref_out.pllqDivToRNG = pllqDivToRNGValue;
            ref_out.RNGCLockSelection = RNGCLockSelectionValue;
            ref_out.RCC_MCO1Source = RCC_MCO1SourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.LSCOSource1 = LSCOSource1Value;
            ref_out.AHB5CLKDivider = AHB5CLKDividerValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.CortexCLockSelection = CortexCLockSelectionValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB7CLKDivider = APB7CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.SPI1CLockSelection = SPI1CLockSelectionValue;
            ref_out.SPI3CLockSelection = SPI3CLockSelectionValue;
            ref_out.PLLN = PLLNValue;
            ref_out.PLLFRACN = PLLFRACNValue;
            ref_out.PLL1P = PLL1PValue;
            ref_out.PLL1Q = PLL1QValue;
            ref_out.PLL1R = PLL1RValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.PWR_Regulator_Voltage_Scale = PWR_Regulator_Voltage_ScaleValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.HSE_Trimming = HSE_TrimmingValue;
            ref_out.LSE_Trimming = LSE_TrimmingValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.PLL1_VCI_Range = PLL1_VCI_RangeValue;
            ref_out.EnableHSE = EnableHSEValue;
            ref_out.LSIEnable = LSIEnableValue;
            ref_out.EnableExtClockForSAI1 = EnableExtClockForSAI1Value;
            ref_out.EnableHSERFDevisor = EnableHSERFDevisorValue;
            ref_out.RFEnable = RFEnableValue;
            ref_out.EnableHSERTCDevisor = EnableHSERTCDevisorValue;
            ref_out.RTCEnable = RTCEnableValue;
            ref_out.IWDGEnable = IWDGEnableValue;
            ref_out.USART2Enable = USART2EnableValue;
            ref_out.USART1Enable = USART1EnableValue;
            ref_out.LPUART1Enable = LPUART1EnableValue;
            ref_out.LPTIM1Enable = LPTIM1EnableValue;
            ref_out.LPTIM2Enable = LPTIM2EnableValue;
            ref_out.ADCEnable = ADCEnableValue;
            ref_out.ASEnable = ASEnableValue;
            ref_out.I2C1Enable = I2C1EnableValue;
            ref_out.I2C3Enable = I2C3EnableValue;
            ref_out.SAI1Enable = SAI1EnableValue;
            ref_out.RNGEnable = RNGEnableValue;
            ref_out.MCOEnable = MCOEnableValue;
            ref_out.LSCOEnable = LSCOEnableValue;
            ref_out.SAESEnable = SAESEnableValue;
            ref_out.SystickEnable = SystickEnableValue;
            ref_out.SPI1Enable = SPI1EnableValue;
            ref_out.SPI3Enable = SPI3EnableValue;
            ref_out.PLL1PUsed = PLL1PUsedValue;
            ref_out.PLL1QUsed = PLL1QUsedValue;
            ref_out.PLLUsed = PLLUsedValue;
            ref_out.LSEUsed = LSEUsedValue;
            ref_out.EnableCSSLSE = EnableCSSLSEValue;
            ref_out.PLL1RUsed = PLL1RUsedValue;
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
