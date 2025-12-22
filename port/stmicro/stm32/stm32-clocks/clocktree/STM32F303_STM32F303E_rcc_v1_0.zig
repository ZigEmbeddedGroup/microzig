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
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_LSE,
    RCC_MCO1SOURCE_HSE,
    MCOMultDivisor,
    RCC_MCO1SOURCE_LSI,
    RCC_MCO1SOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_MCO1SOURCE_HSI => 0,
            .RCC_MCO1SOURCE_LSE => 1,
            .RCC_MCO1SOURCE_HSE => 2,
            .MCOMultDivisor => 3,
            .RCC_MCO1SOURCE_LSI => 4,
            .RCC_MCO1SOURCE_SYSCLK => 5,
        };
    }
};
pub const TIM2SelectionList = enum {
    RCC_TIM2CLK_PLLCLK,
    RCC_TIM2CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM2CLK_PLLCLK => 0,
            .RCC_TIM2CLK_HCLK => 1,
        };
    }
};
pub const TIM34SelectionList = enum {
    RCC_TIM34CLK_PLLCLK,
    RCC_TIM34CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM34CLK_PLLCLK => 0,
            .RCC_TIM34CLK_HCLK => 1,
        };
    }
};
pub const TIM1SelectionList = enum {
    RCC_TIM1CLK_PLLCLK,
    RCC_TIM1CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM1CLK_PLLCLK => 0,
            .RCC_TIM1CLK_HCLK => 1,
        };
    }
};
pub const TIM8SelectionList = enum {
    RCC_TIM8CLK_PLLCLK,
    RCC_TIM8CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM8CLK_PLLCLK => 0,
            .RCC_TIM8CLK_HCLK => 1,
        };
    }
};
pub const TIM15SelectionList = enum {
    RCC_TIM15CLK_PLLCLK,
    RCC_TIM15CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM15CLK_PLLCLK => 0,
            .RCC_TIM15CLK_HCLK => 1,
        };
    }
};
pub const TIM16SelectionList = enum {
    RCC_TIM16CLK_PLLCLK,
    RCC_TIM16CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM16CLK_PLLCLK => 0,
            .RCC_TIM16CLK_HCLK => 1,
        };
    }
};
pub const TIM17SelectionList = enum {
    RCC_TIM17CLK_PLLCLK,
    RCC_TIM17CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM17CLK_PLLCLK => 0,
            .RCC_TIM17CLK_HCLK => 1,
        };
    }
};
pub const TIM20SelectionList = enum {
    RCC_TIM20CLK_PLLCLK,
    RCC_TIM20CLK_HCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_TIM20CLK_PLLCLK => 0,
            .RCC_TIM20CLK_HCLK => 1,
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
pub const I2c3ClockSelectionList = enum {
    RCC_I2C3CLKSOURCE_HSI,
    RCC_I2C3CLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2C3CLKSOURCE_HSI => 0,
            .RCC_I2C3CLKSOURCE_SYSCLK => 1,
        };
    }
};
pub const I2SClockSourceList = enum {
    RCC_I2SCLKSOURCE_EXT,
    RCC_I2SCLKSOURCE_SYSCLK,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_I2SCLKSOURCE_EXT => 0,
            .RCC_I2SCLKSOURCE_SYSCLK => 1,
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
pub const Uart4ClockSelectionList = enum {
    RCC_UART4CLKSOURCE_SYSCLK,
    RCC_UART4CLKSOURCE_HSI,
    RCC_UART4CLKSOURCE_LSE,
    RCC_UART4CLKSOURCE_PCLK1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART4CLKSOURCE_SYSCLK => 0,
            .RCC_UART4CLKSOURCE_HSI => 1,
            .RCC_UART4CLKSOURCE_LSE => 2,
            .RCC_UART4CLKSOURCE_PCLK1 => 3,
        };
    }
};
pub const Uart5ClockSelectionList = enum {
    RCC_UART5CLKSOURCE_SYSCLK,
    RCC_UART5CLKSOURCE_HSI,
    RCC_UART5CLKSOURCE_LSE,
    RCC_UART5CLKSOURCE_PCLK1,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_UART5CLKSOURCE_SYSCLK => 0,
            .RCC_UART5CLKSOURCE_HSI => 1,
            .RCC_UART5CLKSOURCE_LSE => 2,
            .RCC_UART5CLKSOURCE_PCLK1 => 3,
        };
    }
};
pub const PLLSourceList = enum {
    RCC_PLLSOURCE_HSI,
    RCC_PLLSOURCE_HSE,
    pub fn get(self: @This()) usize {
        return switch (self) {
            .RCC_PLLSOURCE_HSI => 2,
            .RCC_PLLSOURCE_HSE => 1,
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
pub const RCC_MCOMult_Clock_Source_FROM_PLLMULList = enum {
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_PLLCLK_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO1SOURCE_PLLCLK => 1,
            .RCC_MCO1SOURCE_PLLCLK_DIV2 => 2,
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
pub const ADC12PRESList = enum {
    RCC_ADC12PLLCLK_DIV1,
    RCC_ADC12PLLCLK_DIV2,
    RCC_ADC12PLLCLK_DIV4,
    RCC_ADC12PLLCLK_DIV6,
    RCC_ADC12PLLCLK_DIV8,
    RCC_ADC12PLLCLK_DIV10,
    RCC_ADC12PLLCLK_DIV12,
    RCC_ADC12PLLCLK_DIV16,
    RCC_ADC12PLLCLK_DIV32,
    RCC_ADC12PLLCLK_DIV64,
    RCC_ADC12PLLCLK_DIV128,
    RCC_ADC12PLLCLK_DIV256,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADC12PLLCLK_DIV1 => 1,
            .RCC_ADC12PLLCLK_DIV2 => 2,
            .RCC_ADC12PLLCLK_DIV4 => 4,
            .RCC_ADC12PLLCLK_DIV6 => 6,
            .RCC_ADC12PLLCLK_DIV8 => 8,
            .RCC_ADC12PLLCLK_DIV10 => 10,
            .RCC_ADC12PLLCLK_DIV12 => 12,
            .RCC_ADC12PLLCLK_DIV16 => 16,
            .RCC_ADC12PLLCLK_DIV32 => 32,
            .RCC_ADC12PLLCLK_DIV64 => 64,
            .RCC_ADC12PLLCLK_DIV128 => 128,
            .RCC_ADC12PLLCLK_DIV256 => 256,
        };
    }
};
pub const ADC34PRESList = enum {
    RCC_ADC34PLLCLK_DIV1,
    RCC_ADC34PLLCLK_DIV2,
    RCC_ADC34PLLCLK_DIV4,
    RCC_ADC34PLLCLK_DIV6,
    RCC_ADC34PLLCLK_DIV8,
    RCC_ADC34PLLCLK_DIV10,
    RCC_ADC34PLLCLK_DIV12,
    RCC_ADC34PLLCLK_DIV16,
    RCC_ADC34PLLCLK_DIV32,
    RCC_ADC34PLLCLK_DIV64,
    RCC_ADC34PLLCLK_DIV128,
    RCC_ADC34PLLCLK_DIV256,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADC34PLLCLK_DIV1 => 1,
            .RCC_ADC34PLLCLK_DIV2 => 2,
            .RCC_ADC34PLLCLK_DIV4 => 4,
            .RCC_ADC34PLLCLK_DIV6 => 6,
            .RCC_ADC34PLLCLK_DIV8 => 8,
            .RCC_ADC34PLLCLK_DIV10 => 10,
            .RCC_ADC34PLLCLK_DIV12 => 12,
            .RCC_ADC34PLLCLK_DIV16 => 16,
            .RCC_ADC34PLLCLK_DIV32 => 32,
            .RCC_ADC34PLLCLK_DIV64 => 64,
            .RCC_ADC34PLLCLK_DIV128 => 128,
            .RCC_ADC34PLLCLK_DIV256 => 256,
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
pub const PLLDividerList = enum {
    RCC_PREDIV_DIV1,
    RCC_PREDIV_DIV2,
    RCC_PREDIV_DIV3,
    RCC_PREDIV_DIV4,
    RCC_PREDIV_DIV5,
    RCC_PREDIV_DIV6,
    RCC_PREDIV_DIV7,
    RCC_PREDIV_DIV8,
    RCC_PREDIV_DIV9,
    RCC_PREDIV_DIV10,
    RCC_PREDIV_DIV11,
    RCC_PREDIV_DIV12,
    RCC_PREDIV_DIV13,
    RCC_PREDIV_DIV14,
    RCC_PREDIV_DIV15,
    RCC_PREDIV_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PREDIV_DIV1 => 1,
            .RCC_PREDIV_DIV2 => 2,
            .RCC_PREDIV_DIV3 => 3,
            .RCC_PREDIV_DIV4 => 4,
            .RCC_PREDIV_DIV5 => 5,
            .RCC_PREDIV_DIV6 => 6,
            .RCC_PREDIV_DIV7 => 7,
            .RCC_PREDIV_DIV8 => 8,
            .RCC_PREDIV_DIV9 => 9,
            .RCC_PREDIV_DIV10 => 10,
            .RCC_PREDIV_DIV11 => 11,
            .RCC_PREDIV_DIV12 => 12,
            .RCC_PREDIV_DIV13 => 13,
            .RCC_PREDIV_DIV14 => 14,
            .RCC_PREDIV_DIV15 => 15,
            .RCC_PREDIV_DIV16 => 16,
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
pub const EnableHSEList = enum {
    true,
    false,
};
pub const USBEnableList = enum {
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
pub const ADC2EnableList = enum {
    true,
    false,
};
pub const ADC3EnableList = enum {
    true,
    false,
};
pub const ADC4EnableList = enum {
    true,
    false,
};
pub const Tim2EnableList = enum {
    true,
    false,
};
pub const Tim3EnableList = enum {
    true,
    false,
};
pub const Tim4EnableList = enum {
    true,
    false,
};
pub const Tim1EnableList = enum {
    true,
    false,
};
pub const Tim8EnableList = enum {
    true,
    false,
};
pub const Tim15EnableList = enum {
    true,
    false,
};
pub const Tim16EnableList = enum {
    true,
    false,
};
pub const Tim17EnableList = enum {
    true,
    false,
};
pub const Tim20EnableList = enum {
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
pub const I2C3EnableList = enum {
    true,
    false,
};
pub const ExtClockEnableList = enum {
    true,
    false,
};
pub const I2SEnableList = enum {
    false,
    true,
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
pub const UART4EnableList = enum {
    true,
    false,
};
pub const UART5EnableList = enum {
    true,
    false,
};
pub const EnableHSIRTCDevisorList = enum {
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
pub const FLITFCLKFEnableList = enum {
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
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            ADC3UsedAsynchronousCLK_ForRCC: bool = false,
            ADC4UsedAsynchronousCLK_ForRCC: bool = false,
            USBUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            MCOUsed_ForRCC: bool = false,
            FLITFUsed_ForRCC: bool = false,
        };
        //optional extra configurations
        pub const ExtraConfig = struct {
            I2SEnable: ?I2SEnableList = null,
            VDD_VALUE: ?f32 = null,
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null,
            HSICalibrationValue: ?u32 = null,
            HSE_Timout: ?u32 = null,
            LSE_Timout: ?u32 = null,
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null,
        };
        pub const Config = struct {
            LSE_VALUE: ?f32 = null,
            HSE_VALUE: ?f32 = null,
            PRESCALERUSB: ?PRESCALERUSBList = null,
            SYSCLKSource: ?SYSCLKSourceList = null,
            RTCClockSelection: ?RTCClockSelectionList = null,
            RCC_MCOMult_Clock_Source_FROM_PLLMUL: ?RCC_MCOMult_Clock_Source_FROM_PLLMULList = null,
            RCC_MCOSource: ?RCC_MCOSourceList = null,
            RCC_MCODiv: ?RCC_MCODivList = null,
            AHBCLKDivider: ?AHBCLKDividerList = null,
            Cortex_Div: ?Cortex_DivList = null,
            ADC12PRES: ?ADC12PRESList = null,
            ADC34PRES: ?ADC34PRESList = null,
            APB1CLKDivider: ?APB1CLKDividerList = null,
            APB2CLKDivider: ?APB2CLKDividerList = null,
            TIM2Selection: ?TIM2SelectionList = null,
            TIM34Selection: ?TIM34SelectionList = null,
            TIM1Selection: ?TIM1SelectionList = null,
            TIM8Selection: ?TIM8SelectionList = null,
            TIM15Selection: ?TIM15SelectionList = null,
            TIM16Selection: ?TIM16SelectionList = null,
            TIM17Selection: ?TIM17SelectionList = null,
            TIM20Selection: ?TIM20SelectionList = null,
            I2c1ClockSelection: ?I2c1ClockSelectionList = null,
            I2c2ClockSelection: ?I2c2ClockSelectionList = null,
            I2c3ClockSelection: ?I2c3ClockSelectionList = null,
            I2SClockSource: ?I2SClockSourceList = null,
            Usart1ClockSelection: ?Usart1ClockSelectionList = null,
            Usart2ClockSelection: ?Usart2ClockSelectionList = null,
            Usart3ClockSelection: ?Usart3ClockSelectionList = null,
            Uart4ClockSelection: ?Uart4ClockSelectionList = null,
            Uart5ClockSelection: ?Uart5ClockSelectionList = null,
            PLLSource: ?PLLSourceList = null,
            PLLDivider: ?PLLDividerList = null,
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
            LSIRC: f32 = 0,
            LSEOSC: f32 = 0,
            HSEOSC: f32 = 0,
            PRESCALERUSB: f32 = 0,
            USBoutput: f32 = 0,
            SysClkSource: f32 = 0,
            SysCLKOutput: f32 = 0,
            HSERTCDevisor: f32 = 0,
            RTCClkSource: f32 = 0,
            RTCOutput: f32 = 0,
            IWDGOutput: f32 = 0,
            MCOMultDivisor: f32 = 0,
            MCOMult: f32 = 0,
            MCODivisor: f32 = 0,
            MCOoutput: f32 = 0,
            AHBPrescaler: f32 = 0,
            AHBOutput: f32 = 0,
            HCLKOutput: f32 = 0,
            FCLKCortexOutput: f32 = 0,
            CortexPrescaler: f32 = 0,
            CortexSysOutput: f32 = 0,
            ADC12PRES: f32 = 0,
            ADC12output: f32 = 0,
            ADC34PRES: f32 = 0,
            ADC34output: f32 = 0,
            APB1Prescaler: f32 = 0,
            APB1Output: f32 = 0,
            TimPrescalerAPB1: f32 = 0,
            TimPrescOut1: f32 = 0,
            APB2Prescaler: f32 = 0,
            APB2Output: f32 = 0,
            TimPrescalerAPB2: f32 = 0,
            TimPrescOut2: f32 = 0,
            TIMMUL: f32 = 0,
            TIMMUX2: f32 = 0,
            TIM2out: f32 = 0,
            TIMMUX3: f32 = 0,
            TIM3out: f32 = 0,
            TIMMUX1: f32 = 0,
            TIM1out: f32 = 0,
            TIMMUX8: f32 = 0,
            TIM8out: f32 = 0,
            TIMMUX15: f32 = 0,
            TIM15out: f32 = 0,
            TIMMUX16: f32 = 0,
            TIM16out: f32 = 0,
            TIMMUX17: f32 = 0,
            TIM17out: f32 = 0,
            TIMMUX20: f32 = 0,
            TIM20out: f32 = 0,
            I2C1Mult: f32 = 0,
            I2C1Output: f32 = 0,
            I2C2Mult: f32 = 0,
            I2C2Output: f32 = 0,
            I2C3Mult: f32 = 0,
            I2C3Output: f32 = 0,
            I2S_CKIN: f32 = 0,
            I2SSrc: f32 = 0,
            I2SClocksOutput: f32 = 0,
            USART1Mult: f32 = 0,
            USART1Output: f32 = 0,
            USART2Mult: f32 = 0,
            USART2Output: f32 = 0,
            USART3Mult: f32 = 0,
            USART3Output: f32 = 0,
            UART4Mult: f32 = 0,
            UART4Output: f32 = 0,
            UART5Mult: f32 = 0,
            UART5Output: f32 = 0,
            PLLSource: f32 = 0,
            PLLDiv: f32 = 0,
            VCO2output: f32 = 0,
            PLLMUL: f32 = 0,
            HSI_PLL: f32 = 0,
            HSE_RTC: f32 = 0,
            PLLCLK_MCO: f32 = 0,
            PLLCLK: f32 = 0,
        };
        /// Flag Configuration output after processing the clock tree.
        pub const Flag_Output = struct {
            HSEByPass: bool = false,
            HSEOscillator: bool = false,
            LSEByPass: bool = false,
            LSEOscillator: bool = false,
            MCOConfig: bool = false,
            AudioClockConfig: bool = false,
            ADC1UsedAsynchronousCLK_ForRCC: bool = false,
            ADC2UsedAsynchronousCLK_ForRCC: bool = false,
            ADC3UsedAsynchronousCLK_ForRCC: bool = false,
            ADC4UsedAsynchronousCLK_ForRCC: bool = false,
            USBUsed_ForRCC: bool = false,
            RTCUsed_ForRCC: bool = false,
            USART1Used_ForRCC: bool = false,
            USART2Used_ForRCC: bool = false,
            USART3Used_ForRCC: bool = false,
            UART4Used_ForRCC: bool = false,
            UART5Used_ForRCC: bool = false,
            IWDGUsed_ForRCC: bool = false,
            I2C1Used_ForRCC: bool = false,
            I2C2Used_ForRCC: bool = false,
            I2C3Used_ForRCC: bool = false,
            I2S2Used_ForRCC: bool = false,
            I2S3Used_ForRCC: bool = false,
            MCOUsed_ForRCC: bool = false,
            FLITFUsed_ForRCC: bool = false,
            LSEUsed: bool = false,
            PLLUsed: bool = false,
            EnableLSE: bool = false,
            EnableHSE: bool = false,
            USBEnable: bool = false,
            EnableHSERTCDevisor: bool = false,
            RTCEnable: bool = false,
            IWDGEnable: bool = false,
            MCOEnable: bool = false,
            ADC1Enable: bool = false,
            ADC2Enable: bool = false,
            ADC3Enable: bool = false,
            ADC4Enable: bool = false,
            Tim2Enable: bool = false,
            Tim3Enable: bool = false,
            Tim4Enable: bool = false,
            Tim1Enable: bool = false,
            Tim8Enable: bool = false,
            Tim15Enable: bool = false,
            Tim16Enable: bool = false,
            Tim17Enable: bool = false,
            Tim20Enable: bool = false,
            I2C1Enable: bool = false,
            I2C2Enable: bool = false,
            I2C3Enable: bool = false,
            ExtClockEnable: bool = false,
            I2SEnable: bool = false,
            USART1Enable: bool = false,
            USART2Enable: bool = false,
            USART3Enable: bool = false,
            UART4Enable: bool = false,
            UART5Enable: bool = false,
            EnableHSIRTCDevisor: bool = false,
            EnableMCOMultDivisor: bool = false,
            EnableLSERTC: bool = false,
            FLITFCLKFEnable: bool = false,
            HSEUsed: bool = false,
            LSIUsed: bool = false,
            HSIUsed: bool = false,
        };
        /// Configuration output after processing the clock tree.
        /// Values marked as null indicate that the RCC configuration should remain at its reset value.
        pub const Config_Output = struct {
            flags: Flag_Output = .{},
            HSI_VALUE: ?f32 = null, //from RCC Clock Config
            HSIRCDiv: ?f32 = null, //from RCC Clock Config
            LSI_VALUE: ?f32 = null, //from RCC Clock Config
            LSE_VALUE: ?f32 = null, //from RCC Clock Config
            HSE_VALUE: ?f32 = null, //from RCC Clock Config
            PRESCALERUSB: ?PRESCALERUSBList = null, //from RCC Clock Config
            SYSCLKSource: ?SYSCLKSourceList = null, //from extra RCC references
            RCC_RTC_Clock_Source_FROM_HSE: ?f32 = null, //from RCC Clock Config
            RTCClockSelection: ?RTCClockSelectionList = null, //from RCC Clock Config
            RCC_MCOMult_Clock_Source_FROM_PLLMUL: ?RCC_MCOMult_Clock_Source_FROM_PLLMULList = null, //from RCC Clock Config
            RCC_MCOSource: ?RCC_MCOSourceList = null, //from RCC Clock Config
            RCC_MCODiv: ?RCC_MCODivList = null, //from RCC Clock Config
            AHBCLKDivider: ?AHBCLKDividerList = null, //from RCC Clock Config
            Cortex_Div: ?Cortex_DivList = null, //from RCC Clock Config
            ADC12PRES: ?ADC12PRESList = null, //from RCC Clock Config
            ADC34PRES: ?ADC34PRESList = null, //from RCC Clock Config
            APB1CLKDivider: ?APB1CLKDividerList = null, //from RCC Clock Config
            APB1TimCLKDivider: ?f32 = null, //from RCC Clock Config
            APB2CLKDivider: ?APB2CLKDividerList = null, //from RCC Clock Config
            APB2TimCLKDivider: ?f32 = null, //from RCC Clock Config
            TIMMUL: ?f32 = null, //from RCC Clock Config
            TIM2Selection: ?TIM2SelectionList = null, //from RCC Clock Config
            TIM34Selection: ?TIM34SelectionList = null, //from RCC Clock Config
            TIM1Selection: ?TIM1SelectionList = null, //from RCC Clock Config
            TIM8Selection: ?TIM8SelectionList = null, //from RCC Clock Config
            TIM15Selection: ?TIM15SelectionList = null, //from RCC Clock Config
            TIM16Selection: ?TIM16SelectionList = null, //from RCC Clock Config
            TIM17Selection: ?TIM17SelectionList = null, //from RCC Clock Config
            TIM20Selection: ?TIM20SelectionList = null, //from RCC Clock Config
            I2c1ClockSelection: ?I2c1ClockSelectionList = null, //from RCC Clock Config
            I2c2ClockSelection: ?I2c2ClockSelectionList = null, //from RCC Clock Config
            I2c3ClockSelection: ?I2c3ClockSelectionList = null, //from RCC Clock Config
            EXTERNAL_CLOCK_VALUE: ?f32 = null, //from RCC Clock Config
            I2SClockSource: ?I2SClockSourceList = null, //from RCC Clock Config
            Usart1ClockSelection: ?Usart1ClockSelectionList = null, //from RCC Clock Config
            Usart2ClockSelection: ?Usart2ClockSelectionList = null, //from RCC Clock Config
            Usart3ClockSelection: ?Usart3ClockSelectionList = null, //from RCC Clock Config
            Uart4ClockSelection: ?Uart4ClockSelectionList = null, //from RCC Clock Config
            Uart5ClockSelection: ?Uart5ClockSelectionList = null, //from RCC Clock Config
            PLLSource: ?PLLSourceList = null, //from extra RCC references
            PLLDivider: ?PLLDividerList = null, //from RCC Clock Config
            PLLMUL: ?PLLMULList = null, //from RCC Clock Config
            VDD_VALUE: ?f32 = null, //from RCC Advanced Config
            PREFETCH_ENABLE: ?PREFETCH_ENABLEList = null, //from RCC Advanced Config
            FLatency: ?FLatencyList = null, //from RCC Advanced Config
            HSICalibrationValue: ?f32 = null, //from RCC Advanced Config
            HSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Timout: ?f32 = null, //from RCC Advanced Config
            LSE_Drive_Capability: ?LSE_Drive_CapabilityList = null, //from RCC Advanced Config
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

            var SysSourceHSI: bool = false;
            var SysSourceHSE: bool = false;
            var SysSourcePLL: bool = false;
            var TIM2SourcePLL: bool = false;
            var TIM34SourcePLL: bool = false;
            var TIM1SourcePLL: bool = false;
            var TIM8SourcePLL: bool = false;
            var TIM15SourcePLL: bool = false;
            var TIM16SourcePLL: bool = false;
            var TIM17SourcePLL: bool = false;
            var TIM20SourcePLL: bool = false;
            var I2C1SourceHSI: bool = false;
            var I2C2SourceHSI: bool = false;
            var I2C3SourceHSI: bool = false;
            var I2SSourceIsExt: bool = false;
            var I2SSourceIsSys: bool = false;
            var AHBCLKDivider1: bool = false;
            var HCLKDiv1: bool = false;
            var APB1DIV1: bool = false;
            var APB2DIV1: bool = false;
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

            var HSIRCDiv = ClockNode{
                .name = "HSIRCDiv",
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

            var MCODivisor = ClockNode{
                .name = "MCODivisor",
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

            var ADC12PRES = ClockNode{
                .name = "ADC12PRES",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC12output = ClockNode{
                .name = "ADC12output",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC34PRES = ClockNode{
                .name = "ADC34PRES",
                .nodetype = .off,
                .parents = &.{},
            };

            var ADC34output = ClockNode{
                .name = "ADC34output",
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

            var TIMMUL = ClockNode{
                .name = "TIMMUL",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX2 = ClockNode{
                .name = "TIMMUX2",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM2out = ClockNode{
                .name = "TIM2out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX3 = ClockNode{
                .name = "TIMMUX3",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM3out = ClockNode{
                .name = "TIM3out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX1 = ClockNode{
                .name = "TIMMUX1",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM1out = ClockNode{
                .name = "TIM1out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX8 = ClockNode{
                .name = "TIMMUX8",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM8out = ClockNode{
                .name = "TIM8out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX15 = ClockNode{
                .name = "TIMMUX15",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM15out = ClockNode{
                .name = "TIM15out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX16 = ClockNode{
                .name = "TIMMUX16",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM16out = ClockNode{
                .name = "TIM16out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX17 = ClockNode{
                .name = "TIMMUX17",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM17out = ClockNode{
                .name = "TIM17out",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIMMUX20 = ClockNode{
                .name = "TIMMUX20",
                .nodetype = .off,
                .parents = &.{},
            };

            var TIM20out = ClockNode{
                .name = "TIM20out",
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

            var I2C3Mult = ClockNode{
                .name = "I2C3Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2C3Output = ClockNode{
                .name = "I2C3Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2S_CKIN = ClockNode{
                .name = "I2S_CKIN",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2SSrc = ClockNode{
                .name = "I2SSrc",
                .nodetype = .off,
                .parents = &.{},
            };

            var I2SClocksOutput = ClockNode{
                .name = "I2SClocksOutput",
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

            var UART4Mult = ClockNode{
                .name = "UART4Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART4Output = ClockNode{
                .name = "UART4Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART5Mult = ClockNode{
                .name = "UART5Mult",
                .nodetype = .off,
                .parents = &.{},
            };

            var UART5Output = ClockNode{
                .name = "UART5Output",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLSource = ClockNode{
                .name = "PLLSource",
                .nodetype = .off,
                .parents = &.{},
            };

            var PLLDiv = ClockNode{
                .name = "PLLDiv",
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

            var HSI_PLL = ClockNode{
                .name = "HSI_PLL",
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
            //Pre clock reference values
            //the following references can and/or should be validated before defining the clocks

            const HSI_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const HSIRCDivValue: ?f32 = blk: {
                break :blk 2;
            };
            const LSI_VALUEValue: ?f32 = blk: {
                break :blk 4e4;
            };
            const LSE_VALUEValue: ?f32 = if (config.LSE_VALUE) |i| i else 32768;
            const HSE_VALUEValue: ?f32 = if (config.HSE_VALUE) |i| i else 8000000;
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
            const TIM2SelectionValue: ?TIM2SelectionList = blk: {
                const conf_item = config.TIM2Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM2CLK_HCLK => {},
                        .RCC_TIM2CLK_PLLCLK => TIM2SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM2CLK_HCLK;
            };
            const TIM34SelectionValue: ?TIM34SelectionList = blk: {
                const conf_item = config.TIM34Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM34CLK_HCLK => {},
                        .RCC_TIM34CLK_PLLCLK => TIM34SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM34CLK_HCLK;
            };
            const TIM1SelectionValue: ?TIM1SelectionList = blk: {
                const conf_item = config.TIM1Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM1CLK_HCLK => {},
                        .RCC_TIM1CLK_PLLCLK => TIM1SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM1CLK_HCLK;
            };
            const TIM8SelectionValue: ?TIM8SelectionList = blk: {
                const conf_item = config.TIM8Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM8CLK_HCLK => {},
                        .RCC_TIM8CLK_PLLCLK => TIM8SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM8CLK_HCLK;
            };
            const TIM15SelectionValue: ?TIM15SelectionList = blk: {
                const conf_item = config.TIM15Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM15CLK_HCLK => {},
                        .RCC_TIM15CLK_PLLCLK => TIM15SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM15CLK_HCLK;
            };
            const TIM16SelectionValue: ?TIM16SelectionList = blk: {
                const conf_item = config.TIM16Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM16CLK_HCLK => {},
                        .RCC_TIM16CLK_PLLCLK => TIM16SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM16CLK_HCLK;
            };
            const TIM17SelectionValue: ?TIM17SelectionList = blk: {
                const conf_item = config.TIM17Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM17CLK_HCLK => {},
                        .RCC_TIM17CLK_PLLCLK => TIM17SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM17CLK_HCLK;
            };
            const TIM20SelectionValue: ?TIM20SelectionList = blk: {
                const conf_item = config.TIM20Selection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_TIM20CLK_HCLK => {},
                        .RCC_TIM20CLK_PLLCLK => TIM20SourcePLL = true,
                    }
                }

                break :blk conf_item orelse .RCC_TIM20CLK_HCLK;
            };
            const SYSCLKSourceValue: ?SYSCLKSourceList = blk: {
                if ((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4"))) or (TIM1SourcePLL and check_MCU("TIM1")) or (TIM8SourcePLL and check_MCU("TIM8")) or (TIM15SourcePLL and check_MCU("TIM15")) or (TIM16SourcePLL and check_MCU("TIM16")) or (TIM17SourcePLL and check_MCU("TIM17")) or (TIM20SourcePLL and check_MCU("TIM20"))) {
                    SysSourcePLL = true;
                    const item: SYSCLKSourceList = .RCC_SYSCLKSOURCE_PLLCLK;
                    const conf_item = config.SYSCLKSource;
                    if (conf_item) |i| {
                        if (item != i) {
                            return comptime_fail_or_error(error.InvalidConfig,
                                \\
                                \\Error on {s} | expr: {s} diagnostic: {s} 
                                \\Expected Fixed List Value: {s} found {any}
                                \\note: the current condition limits the choice to only one list item,
                                \\select the expected option or leave the value as null.
                                \\
                            , .{ "SYSCLKSource", "(TIM2SourcePLL &TIM2)|(TIM34SourcePLL &(TIM3|TIM4))|(TIM1SourcePLL &TIM1)|(TIM8SourcePLL &TIM8)|(TIM15SourcePLL &TIM15)|(TIM16SourcePLL &TIM16)|(TIM17SourcePLL &TIM17)|(TIM20SourcePLL &TIM20)", "PLL Clock must be selected", "RCC_SYSCLKSOURCE_PLLCLK", i });
                        }
                    }
                    break :blk item;
                }
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
            const RCC_MCOMult_Clock_Source_FROM_PLLMULValue: ?RCC_MCOMult_Clock_Source_FROM_PLLMULList = blk: {
                const conf_item = config.RCC_MCOMult_Clock_Source_FROM_PLLMUL;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_MCO1SOURCE_PLLCLK => {},
                        .RCC_MCO1SOURCE_PLLCLK_DIV2 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCO1SOURCE_PLLCLK;
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
                        .MCOMultDivisor => {},
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
                        .RCC_MCODIV_64 => {},
                        .RCC_MCODIV_128 => {},
                    }
                }

                break :blk conf_item orelse .RCC_MCODIV_1;
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
            const ADC12PRESValue: ?ADC12PRESList = blk: {
                const conf_item = config.ADC12PRES;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADC12PLLCLK_DIV1 => {},
                        .RCC_ADC12PLLCLK_DIV2 => {},
                        .RCC_ADC12PLLCLK_DIV4 => {},
                        .RCC_ADC12PLLCLK_DIV6 => {},
                        .RCC_ADC12PLLCLK_DIV8 => {},
                        .RCC_ADC12PLLCLK_DIV10 => {},
                        .RCC_ADC12PLLCLK_DIV12 => {},
                        .RCC_ADC12PLLCLK_DIV16 => {},
                        .RCC_ADC12PLLCLK_DIV32 => {},
                        .RCC_ADC12PLLCLK_DIV64 => {},
                        .RCC_ADC12PLLCLK_DIV128 => {},
                        .RCC_ADC12PLLCLK_DIV256 => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADC12PLLCLK_DIV1;
            };
            const ADC34PRESValue: ?ADC34PRESList = blk: {
                const conf_item = config.ADC34PRES;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_ADC34PLLCLK_DIV1 => {},
                        .RCC_ADC34PLLCLK_DIV2 => {},
                        .RCC_ADC34PLLCLK_DIV4 => {},
                        .RCC_ADC34PLLCLK_DIV6 => {},
                        .RCC_ADC34PLLCLK_DIV8 => {},
                        .RCC_ADC34PLLCLK_DIV10 => {},
                        .RCC_ADC34PLLCLK_DIV12 => {},
                        .RCC_ADC34PLLCLK_DIV16 => {},
                        .RCC_ADC34PLLCLK_DIV32 => {},
                        .RCC_ADC34PLLCLK_DIV64 => {},
                        .RCC_ADC34PLLCLK_DIV128 => {},
                        .RCC_ADC34PLLCLK_DIV256 => {},
                    }
                }

                break :blk conf_item orelse .RCC_ADC34PLLCLK_DIV1;
            };
            const APB1CLKDividerValue: ?APB1CLKDividerList = blk: {
                const conf_item = config.APB1CLKDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_HCLK_DIV1 => APB1DIV1 = true,
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    APB1DIV1 = true;
                    break :blk .RCC_HCLK_DIV1;
                };
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
                        .RCC_HCLK_DIV1 => APB2DIV1 = true,
                        .RCC_HCLK_DIV2 => {},
                        .RCC_HCLK_DIV4 => {},
                        .RCC_HCLK_DIV8 => {},
                        .RCC_HCLK_DIV16 => {},
                    }
                }

                break :blk conf_item orelse {
                    APB2DIV1 = true;
                    break :blk .RCC_HCLK_DIV1;
                };
            };
            const APB2TimCLKDividerValue: ?f32 = blk: {
                if (check_ref(@TypeOf(APB2CLKDividerValue), APB2CLKDividerValue, .RCC_HCLK_DIV1, .@"=")) {
                    break :blk 1;
                }
                break :blk 2;
            };
            const TIMMULValue: ?f32 = blk: {
                break :blk 2;
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
            const I2c3ClockSelectionValue: ?I2c3ClockSelectionList = blk: {
                const conf_item = config.I2c3ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2C3CLKSOURCE_SYSCLK => {},
                        .RCC_I2C3CLKSOURCE_HSI => I2C3SourceHSI = true,
                    }
                }

                break :blk conf_item orelse {
                    I2C3SourceHSI = true;
                    break :blk .RCC_I2C3CLKSOURCE_HSI;
                };
            };
            const EXTERNAL_CLOCK_VALUEValue: ?f32 = blk: {
                break :blk 8e6;
            };
            const I2SClockSourceValue: ?I2SClockSourceList = blk: {
                const conf_item = config.I2SClockSource;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_I2SCLKSOURCE_SYSCLK => I2SSourceIsSys = true,
                        .RCC_I2SCLKSOURCE_EXT => I2SSourceIsExt = true,
                    }
                }

                break :blk conf_item orelse {
                    I2SSourceIsSys = true;
                    break :blk .RCC_I2SCLKSOURCE_SYSCLK;
                };
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
            const Uart4ClockSelectionValue: ?Uart4ClockSelectionList = blk: {
                const conf_item = config.Uart4ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART4CLKSOURCE_PCLK1 => {},
                        .RCC_UART4CLKSOURCE_SYSCLK => {},
                        .RCC_UART4CLKSOURCE_HSI => {},
                        .RCC_UART4CLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_UART4CLKSOURCE_PCLK1;
            };
            const Uart5ClockSelectionValue: ?Uart5ClockSelectionList = blk: {
                const conf_item = config.Uart5ClockSelection;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_UART5CLKSOURCE_PCLK1 => {},
                        .RCC_UART5CLKSOURCE_SYSCLK => {},
                        .RCC_UART5CLKSOURCE_HSI => {},
                        .RCC_UART5CLKSOURCE_LSE => {},
                    }
                }

                break :blk conf_item orelse .RCC_UART5CLKSOURCE_PCLK1;
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
                        .RCC_PLLSOURCE_HSI => {},
                    }
                }

                break :blk conf_item orelse .RCC_PLLSOURCE_HSI;
            };
            const PLLDividerValue: ?PLLDividerList = blk: {
                const conf_item = config.PLLDivider;
                if (conf_item) |item| {
                    switch (item) {
                        .RCC_PREDIV_DIV1 => {},
                        .RCC_PREDIV_DIV2 => {},
                        .RCC_PREDIV_DIV3 => {},
                        .RCC_PREDIV_DIV4 => {},
                        .RCC_PREDIV_DIV5 => {},
                        .RCC_PREDIV_DIV6 => {},
                        .RCC_PREDIV_DIV7 => {},
                        .RCC_PREDIV_DIV8 => {},
                        .RCC_PREDIV_DIV9 => {},
                        .RCC_PREDIV_DIV10 => {},
                        .RCC_PREDIV_DIV11 => {},
                        .RCC_PREDIV_DIV12 => {},
                        .RCC_PREDIV_DIV13 => {},
                        .RCC_PREDIV_DIV14 => {},
                        .RCC_PREDIV_DIV15 => {},
                        .RCC_PREDIV_DIV16 => {},
                    }
                }

                break :blk conf_item orelse .RCC_PREDIV_DIV1;
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
                if (!AHBCLKDivider1) {
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
                            , .{ "PREFETCH_ENABLE", "!AHBCLKDivider1", "No Extra Log", "1", i });
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
                if (((config.flags.USART1Used_ForRCC and (check_ref(@TypeOf(Usart1ClockSelectionValue), Usart1ClockSelectionValue, .RCC_USART1CLKSOURCE_LSE, .@"="))) or (config.flags.USART2Used_ForRCC and (check_ref(@TypeOf(Usart2ClockSelectionValue), Usart2ClockSelectionValue, .RCC_USART2CLKSOURCE_LSE, .@"="))) or (config.flags.USART3Used_ForRCC and (check_ref(@TypeOf(Usart3ClockSelectionValue), Usart3ClockSelectionValue, .RCC_USART3CLKSOURCE_LSE, .@"="))) or (config.flags.UART4Used_ForRCC and (check_ref(@TypeOf(Uart4ClockSelectionValue), Uart4ClockSelectionValue, .RCC_UART4CLKSOURCE_LSE, .@"="))) or (config.flags.UART5Used_ForRCC and (check_ref(@TypeOf(Uart5ClockSelectionValue), Uart5ClockSelectionValue, .RCC_UART5CLKSOURCE_LSE, .@"="))) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSE, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig)) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=") and config.flags.RTCUsed_ForRCC))) {
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
            const PLLUsedValue: ?f32 = blk: {
                if (((check_MCU("TIM1") and check_ref(@TypeOf(TIM1SelectionValue), TIM1SelectionValue, .RCC_TIM1CLK_PLLCLK, .@"=")) or (check_MCU("TIM8") and check_ref(@TypeOf(TIM8SelectionValue), TIM8SelectionValue, .RCC_TIM8CLK_PLLCLK, .@"=")) or (check_MCU("TIM15") and check_ref(@TypeOf(TIM15SelectionValue), TIM15SelectionValue, .RCC_TIM15CLK_PLLCLK, .@"=")) or (check_MCU("TIM16") and TIM16SourcePLL) or (check_MCU("TIM17") and check_ref(@TypeOf(TIM17SelectionValue), TIM17SelectionValue, .RCC_TIM17CLK_PLLCLK, .@"=")) or (check_MCU("TIM20") and check_ref(@TypeOf(TIM20SelectionValue), TIM20SelectionValue, .RCC_TIM20CLK_PLLCLK, .@"=")) or (check_MCU("TIM2") and check_ref(@TypeOf(TIM2SelectionValue), TIM2SelectionValue, .RCC_TIM2CLK_PLLCLK, .@"=")) or ((check_MCU("TIM3") or check_MCU("TIM4")) and check_ref(@TypeOf(TIM34SelectionValue), TIM34SelectionValue, .RCC_TIM34CLK_PLLCLK, .@"=")) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_PLLCLK, .@"=")) or ((false or false) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig)) or config.flags.USBUsed_ForRCC or (check_MCU("channelSelectedADC1") and config.flags.ADC1UsedAsynchronousCLK_ForRCC) or (check_MCU("channelSelectedADC2") and config.flags.ADC2UsedAsynchronousCLK_ForRCC) or (check_MCU("channelSelectedADC3") and config.flags.ADC3UsedAsynchronousCLK_ForRCC) or (check_MCU("channelSelectedADC4") and config.flags.ADC4UsedAsynchronousCLK_ForRCC))) {
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
            const USBEnableValue: ?USBEnableList = blk: {
                if (config.flags.USBUsed_ForRCC) {
                    const item: USBEnableList = .true;
                    break :blk item;
                }
                const item: USBEnableList = .false;
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
                if ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig) {
                    const item: MCOEnableList = .true;
                    break :blk item;
                }
                const item: MCOEnableList = .false;
                break :blk item;
            };
            const ADC1EnableValue: ?ADC1EnableList = blk: {
                if (check_MCU("channelSelectedADC1") and config.flags.ADC1UsedAsynchronousCLK_ForRCC) {
                    const item: ADC1EnableList = .true;
                    break :blk item;
                }
                const item: ADC1EnableList = .false;
                break :blk item;
            };
            const ADC2EnableValue: ?ADC2EnableList = blk: {
                if (check_MCU("channelSelectedADC2") and config.flags.ADC2UsedAsynchronousCLK_ForRCC) {
                    const item: ADC2EnableList = .true;
                    break :blk item;
                }
                const item: ADC2EnableList = .false;
                break :blk item;
            };
            const ADC3EnableValue: ?ADC3EnableList = blk: {
                if ((check_MCU("channelSelectedADC3") and config.flags.ADC3UsedAsynchronousCLK_ForRCC)) {
                    const item: ADC3EnableList = .true;
                    break :blk item;
                }
                const item: ADC3EnableList = .false;
                break :blk item;
            };
            const ADC4EnableValue: ?ADC4EnableList = blk: {
                if (check_MCU("channelSelectedADC4") and config.flags.ADC4UsedAsynchronousCLK_ForRCC) {
                    const item: ADC4EnableList = .true;
                    break :blk item;
                }
                const item: ADC4EnableList = .false;
                break :blk item;
            };
            const Tim2EnableValue: ?Tim2EnableList = blk: {
                if (check_MCU("TIM2")) {
                    const item: Tim2EnableList = .true;
                    break :blk item;
                }
                const item: Tim2EnableList = .false;
                break :blk item;
            };
            const Tim3EnableValue: ?Tim3EnableList = blk: {
                if (check_MCU("TIM3")) {
                    const item: Tim3EnableList = .true;
                    break :blk item;
                }
                const item: Tim3EnableList = .false;
                break :blk item;
            };
            const Tim4EnableValue: ?Tim4EnableList = blk: {
                if (check_MCU("TIM4")) {
                    const item: Tim4EnableList = .true;
                    break :blk item;
                }
                const item: Tim4EnableList = .false;
                break :blk item;
            };
            const Tim1EnableValue: ?Tim1EnableList = blk: {
                if (check_MCU("TIM1")) {
                    const item: Tim1EnableList = .true;
                    break :blk item;
                }
                const item: Tim1EnableList = .false;
                break :blk item;
            };
            const Tim8EnableValue: ?Tim8EnableList = blk: {
                if (check_MCU("TIM8")) {
                    const item: Tim8EnableList = .true;
                    break :blk item;
                }
                const item: Tim8EnableList = .false;
                break :blk item;
            };
            const Tim15EnableValue: ?Tim15EnableList = blk: {
                if (check_MCU("TIM15")) {
                    const item: Tim15EnableList = .true;
                    break :blk item;
                }
                const item: Tim15EnableList = .false;
                break :blk item;
            };
            const Tim16EnableValue: ?Tim16EnableList = blk: {
                if (check_MCU("TIM16")) {
                    const item: Tim16EnableList = .true;
                    break :blk item;
                }
                const item: Tim16EnableList = .false;
                break :blk item;
            };
            const Tim17EnableValue: ?Tim17EnableList = blk: {
                if (check_MCU("TIM17")) {
                    const item: Tim17EnableList = .true;
                    break :blk item;
                }
                const item: Tim17EnableList = .false;
                break :blk item;
            };
            const Tim20EnableValue: ?Tim20EnableList = blk: {
                if (check_MCU("TIM20")) {
                    const item: Tim20EnableList = .true;
                    break :blk item;
                }
                const item: Tim20EnableList = .false;
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
            const I2C3EnableValue: ?I2C3EnableList = blk: {
                if (config.flags.I2C3Used_ForRCC) {
                    const item: I2C3EnableList = .true;
                    break :blk item;
                }
                const item: I2C3EnableList = .false;
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
            const I2SEnableValue: ?I2SEnableList = blk: {
                if (!config.flags.I2S2Used_ForRCC and !config.flags.I2S3Used_ForRCC) {
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
                            , .{ "I2SEnable", "!I2S2Used_ForRCC & !I2S3Used_ForRCC", "I2S ip not used", "false", i });
                        }
                    }
                    break :blk item;
                } else if (config.flags.I2S2Used_ForRCC or config.flags.I2S3Used_ForRCC) {
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
                            , .{ "I2SEnable", "I2S2Used_ForRCC | I2S3Used_ForRCC", "I2S ip used", "true", i });
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
            const UART4EnableValue: ?UART4EnableList = blk: {
                if (config.flags.UART4Used_ForRCC) {
                    const item: UART4EnableList = .true;
                    break :blk item;
                }
                const item: UART4EnableList = .false;
                break :blk item;
            };
            const UART5EnableValue: ?UART5EnableList = blk: {
                if (config.flags.UART5Used_ForRCC) {
                    const item: UART5EnableList = .true;
                    break :blk item;
                }
                const item: UART5EnableList = .false;
                break :blk item;
            };
            const EnableHSIRTCDevisorValue: ?EnableHSIRTCDevisorList = blk: {
                if (config.flags.RTCUsed_ForRCC) {
                    const item: EnableHSIRTCDevisorList = .true;
                    break :blk item;
                }
                const item: EnableHSIRTCDevisorList = .false;
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
            const FLITFCLKFEnableValue: ?FLITFCLKFEnableList = blk: {
                if (config.flags.FLITFUsed_ForRCC) {
                    const item: FLITFCLKFEnableList = .true;
                    break :blk item;
                }
                const item: FLITFCLKFEnableList = .false;
                break :blk item;
            };
            const HSEUsedValue: ?f32 = blk: {
                if ((check_MCU("SEM2RCC_HSE_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or ((config.flags.RTCUsed_ForRCC) and !((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSE, .@"=")) or (check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")))) or ((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSE, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSE, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSE, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const LSIUsedValue: ?f32 = blk: {
                if ((config.flags.IWDGUsed_ForRCC or ((check_ref(@TypeOf(RTCClockSelectionValue), RTCClockSelectionValue, .RCC_RTCCLKSOURCE_LSI, .@"=")) and (config.flags.RTCUsed_ForRCC)) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_LSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig)))) {
                    break :blk 1;
                }
                break :blk 0;
            };
            const HSIUsedValue: ?f32 = blk: {
                if ((((check_ref(@TypeOf(PLLSourceValue), PLLSourceValue, .RCC_PLLSOURCE_HSI, .@"=")) and (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"="))) or (check_ref(@TypeOf(SYSCLKSourceValue), SYSCLKSourceValue, .RCC_SYSCLKSOURCE_HSI, .@"=")) or ((check_ref(@TypeOf(RCC_MCOSourceValue), RCC_MCOSourceValue, .RCC_MCO1SOURCE_HSI, .@"=")) and ((check_MCU("SEM2RCC_MCO_REQUIRED_TIM16") and check_MCU("TIM16") and check_MCU("Semaphore_input_Channel1TIM16")) or config.flags.MCOConfig)) or (config.flags.USART1Used_ForRCC and (check_ref(@TypeOf(Usart1ClockSelectionValue), Usart1ClockSelectionValue, .RCC_USART1CLKSOURCE_HSI, .@"="))) or (config.flags.USART2Used_ForRCC and (check_ref(@TypeOf(Usart2ClockSelectionValue), Usart2ClockSelectionValue, .RCC_USART2CLKSOURCE_HSI, .@"="))) or (config.flags.USART3Used_ForRCC and (check_ref(@TypeOf(Usart3ClockSelectionValue), Usart3ClockSelectionValue, .RCC_USART3CLKSOURCE_HSI, .@"="))) or (config.flags.UART4Used_ForRCC and (check_ref(@TypeOf(Uart4ClockSelectionValue), Uart4ClockSelectionValue, .RCC_UART4CLKSOURCE_HSI, .@"="))) or (config.flags.UART5Used_ForRCC and (check_ref(@TypeOf(Uart5ClockSelectionValue), Uart5ClockSelectionValue, .RCC_UART5CLKSOURCE_HSI, .@"="))) or (config.flags.I2C1Used_ForRCC and (I2C1SourceHSI)) or (config.flags.I2C2Used_ForRCC and (I2C2SourceHSI)) or (config.flags.I2C3Used_ForRCC and (I2C3SourceHSI)))) {
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
                    HSEOSC.value = config_val orelse 8000000;

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
            SysCLKOutput.nodetype = .output;
            SysCLKOutput.parents = &.{&SysClkSource};
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
                MCOMultDivisor.value = MCOMultDivisor_clk_value.get();
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
                    &HSIRC,
                    &LSEOSC,
                    &HSEOSC,
                    &MCOMultDivisor,
                    &LSIRC,
                    &SysCLKOutput,
                };
                MCOMult.nodetype = .multi;
                MCOMult.parents = &.{MCOMultparents[MCOMult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                const MCODivisor_clk_value = RCC_MCODivValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "MCODivisor",
                    "Else",
                    "No Extra Log",
                    "RCC_MCODiv",
                });
                MCODivisor.nodetype = .div;
                MCODivisor.value = MCODivisor_clk_value.get();
                MCODivisor.parents = &.{&MCOMult};
            }
            if (check_ref(@TypeOf(MCOEnableValue), MCOEnableValue, .true, .@"=")) {
                MCOoutput.nodetype = .output;
                MCOoutput.parents = &.{&MCODivisor};
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
            if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"="))
            {
                const ADC12PRES_clk_value = ADC12PRESValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADC12PRES",
                    "Else",
                    "No Extra Log",
                    "ADC12PRES",
                });
                ADC12PRES.nodetype = .div;
                ADC12PRES.value = ADC12PRES_clk_value.get();
                ADC12PRES.parents = &.{&PLLMUL};
            }
            if (check_ref(@TypeOf(ADC1EnableValue), ADC1EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC2EnableValue), ADC2EnableValue, .true, .@"="))
            {
                ADC12output.nodetype = .output;
                ADC12output.parents = &.{&ADC12PRES};
            }
            if (check_ref(@TypeOf(ADC3EnableValue), ADC3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC4EnableValue), ADC4EnableValue, .true, .@"="))
            {
                const ADC34PRES_clk_value = ADC34PRESValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "ADC34PRES",
                    "Else",
                    "No Extra Log",
                    "ADC34PRES",
                });
                ADC34PRES.nodetype = .div;
                ADC34PRES.value = ADC34PRES_clk_value.get();
                ADC34PRES.parents = &.{&PLLMUL};
            }
            if (check_ref(@TypeOf(ADC3EnableValue), ADC3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(ADC4EnableValue), ADC4EnableValue, .true, .@"="))
            {
                ADC34output.nodetype = .output;
                ADC34output.parents = &.{&ADC34PRES};
            }

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

            const TIMMUL_clk_value = TIMMULValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "TIMMUL",
                "Else",
                "No Extra Log",
                "TIMMUL",
            });
            TIMMUL.nodetype = .mul;
            TIMMUL.value = TIMMUL_clk_value;
            TIMMUL.parents = &.{&PLLMUL};
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim2EnableValue), Tim2EnableValue, .true, .@"=")) {
                    const TIMMUX2_clk_value = TIM2SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "TIMMUX2",
                        "ADC3_Exist",
                        "No Extra Log",
                        "TIM2Selection",
                    });
                    const TIMMUX2parents = [_]*const ClockNode{
                        &TIMMUL,
                        &TimPrescOut1,
                    };
                    TIMMUX2.nodetype = .multi;
                    TIMMUX2.parents = &.{TIMMUX2parents[TIMMUX2_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(Tim2EnableValue), Tim2EnableValue, .true, .@"=")) {
                const TIMMUX2_clk_value = TIM2SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX2",
                    "Else",
                    "No Extra Log",
                    "TIM2Selection",
                });
                const TIMMUX2parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut1,
                };
                TIMMUX2.nodetype = .multi;
                TIMMUX2.parents = &.{TIMMUX2parents[TIMMUX2_clk_value.get()]};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim2EnableValue), Tim2EnableValue, .true, .@"=")) {
                    TIM2out.nodetype = .output;
                    TIM2out.parents = &.{&TIMMUX2};
                }
            }
            if (check_ref(@TypeOf(Tim2EnableValue), Tim2EnableValue, .true, .@"=")) {
                TIM2out.nodetype = .output;
                TIM2out.parents = &.{&TIMMUX2};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim3EnableValue), Tim3EnableValue, .true, .@"=") or
                    check_ref(@TypeOf(Tim4EnableValue), Tim4EnableValue, .true, .@"="))
                {
                    const TIMMUX3_clk_value = TIM34SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "TIMMUX3",
                        "ADC3_Exist",
                        "No Extra Log",
                        "TIM34Selection",
                    });
                    const TIMMUX3parents = [_]*const ClockNode{
                        &TIMMUL,
                        &TimPrescOut1,
                    };
                    TIMMUX3.nodetype = .multi;
                    TIMMUX3.parents = &.{TIMMUX3parents[TIMMUX3_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(Tim3EnableValue), Tim3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(Tim4EnableValue), Tim4EnableValue, .true, .@"="))
            {
                const TIMMUX3_clk_value = TIM34SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX3",
                    "Else",
                    "No Extra Log",
                    "TIM34Selection",
                });
                const TIMMUX3parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut1,
                };
                TIMMUX3.nodetype = .multi;
                TIMMUX3.parents = &.{TIMMUX3parents[TIMMUX3_clk_value.get()]};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim3EnableValue), Tim3EnableValue, .true, .@"=") or
                    check_ref(@TypeOf(Tim4EnableValue), Tim4EnableValue, .true, .@"="))
                {
                    TIM3out.nodetype = .output;
                    TIM3out.parents = &.{&TIMMUX3};
                }
            }
            if (check_ref(@TypeOf(Tim3EnableValue), Tim3EnableValue, .true, .@"=") or
                check_ref(@TypeOf(Tim4EnableValue), Tim4EnableValue, .true, .@"="))
            {
                TIM3out.nodetype = .output;
                TIM3out.parents = &.{&TIMMUX3};
            }
            if (check_ref(@TypeOf(Tim1EnableValue), Tim1EnableValue, .true, .@"=")) {
                const TIMMUX1_clk_value = TIM1SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX1",
                    "Else",
                    "No Extra Log",
                    "TIM1Selection",
                });
                const TIMMUX1parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX1.nodetype = .multi;
                TIMMUX1.parents = &.{TIMMUX1parents[TIMMUX1_clk_value.get()]};
            }
            if (check_ref(@TypeOf(Tim1EnableValue), Tim1EnableValue, .true, .@"=")) {
                TIM1out.nodetype = .output;
                TIM1out.parents = &.{&TIMMUX1};
            }
            if (check_ref(@TypeOf(Tim8EnableValue), Tim8EnableValue, .true, .@"=")) {
                const TIMMUX8_clk_value = TIM8SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX8",
                    "Else",
                    "No Extra Log",
                    "TIM8Selection",
                });
                const TIMMUX8parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX8.nodetype = .multi;
                TIMMUX8.parents = &.{TIMMUX8parents[TIMMUX8_clk_value.get()]};
            }
            if (check_ref(@TypeOf(Tim8EnableValue), Tim8EnableValue, .true, .@"=")) {
                TIM8out.nodetype = .output;
                TIM8out.parents = &.{&TIMMUX8};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim15EnableValue), Tim15EnableValue, .true, .@"=")) {
                    const TIMMUX15_clk_value = TIM15SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "TIMMUX15",
                        "ADC3_Exist",
                        "No Extra Log",
                        "TIM15Selection",
                    });
                    const TIMMUX15parents = [_]*const ClockNode{
                        &TIMMUL,
                        &TimPrescOut2,
                    };
                    TIMMUX15.nodetype = .multi;
                    TIMMUX15.parents = &.{TIMMUX15parents[TIMMUX15_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(Tim15EnableValue), Tim15EnableValue, .true, .@"=")) {
                const TIMMUX15_clk_value = TIM15SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX15",
                    "Else",
                    "No Extra Log",
                    "TIM15Selection",
                });
                const TIMMUX15parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX15.nodetype = .multi;
                TIMMUX15.parents = &.{TIMMUX15parents[TIMMUX15_clk_value.get()]};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim15EnableValue), Tim15EnableValue, .true, .@"=")) {
                    TIM15out.nodetype = .output;
                    TIM15out.parents = &.{&TIMMUX15};
                }
            }
            if (check_ref(@TypeOf(Tim15EnableValue), Tim15EnableValue, .true, .@"=")) {
                TIM15out.nodetype = .output;
                TIM15out.parents = &.{&TIMMUX15};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim16EnableValue), Tim16EnableValue, .true, .@"=")) {
                    const TIMMUX16_clk_value = TIM16SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "TIMMUX16",
                        "ADC3_Exist",
                        "No Extra Log",
                        "TIM16Selection",
                    });
                    const TIMMUX16parents = [_]*const ClockNode{
                        &TIMMUL,
                        &TimPrescOut2,
                    };
                    TIMMUX16.nodetype = .multi;
                    TIMMUX16.parents = &.{TIMMUX16parents[TIMMUX16_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(Tim16EnableValue), Tim16EnableValue, .true, .@"=")) {
                const TIMMUX16_clk_value = TIM16SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX16",
                    "Else",
                    "No Extra Log",
                    "TIM16Selection",
                });
                const TIMMUX16parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX16.nodetype = .multi;
                TIMMUX16.parents = &.{TIMMUX16parents[TIMMUX16_clk_value.get()]};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim16EnableValue), Tim16EnableValue, .true, .@"=")) {
                    TIM16out.nodetype = .output;
                    TIM16out.parents = &.{&TIMMUX16};
                }
            }
            if (check_ref(@TypeOf(Tim16EnableValue), Tim16EnableValue, .true, .@"=")) {
                TIM16out.nodetype = .output;
                TIM16out.parents = &.{&TIMMUX16};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim17EnableValue), Tim17EnableValue, .true, .@"=")) {
                    const TIMMUX17_clk_value = TIM17SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                        \\Error on Clock {s} | expr: {s} diagnostic: {s}
                        \\Clock is active but the reference value {s} is null
                        \\note: check the flags and configurations associated with this clock
                        \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                    , .{
                        "TIMMUX17",
                        "ADC3_Exist",
                        "No Extra Log",
                        "TIM17Selection",
                    });
                    const TIMMUX17parents = [_]*const ClockNode{
                        &TIMMUL,
                        &TimPrescOut2,
                    };
                    TIMMUX17.nodetype = .multi;
                    TIMMUX17.parents = &.{TIMMUX17parents[TIMMUX17_clk_value.get()]};
                }
            }
            if (check_ref(@TypeOf(Tim17EnableValue), Tim17EnableValue, .true, .@"=")) {
                const TIMMUX17_clk_value = TIM17SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX17",
                    "Else",
                    "No Extra Log",
                    "TIM17Selection",
                });
                const TIMMUX17parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX17.nodetype = .multi;
                TIMMUX17.parents = &.{TIMMUX17parents[TIMMUX17_clk_value.get()]};
            }
            if (check_MCU("ADC3_Exist")) {
                if (check_ref(@TypeOf(Tim17EnableValue), Tim17EnableValue, .true, .@"=")) {
                    TIM17out.nodetype = .output;
                    TIM17out.parents = &.{&TIMMUX17};
                }
            }
            if (check_ref(@TypeOf(Tim17EnableValue), Tim17EnableValue, .true, .@"=")) {
                TIM17out.nodetype = .output;
                TIM17out.parents = &.{&TIMMUX17};
            }
            if (check_ref(@TypeOf(Tim20EnableValue), Tim20EnableValue, .true, .@"=")) {
                const TIMMUX20_clk_value = TIM20SelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "TIMMUX20",
                    "Else",
                    "No Extra Log",
                    "TIM20Selection",
                });
                const TIMMUX20parents = [_]*const ClockNode{
                    &TIMMUL,
                    &TimPrescOut2,
                };
                TIMMUX20.nodetype = .multi;
                TIMMUX20.parents = &.{TIMMUX20parents[TIMMUX20_clk_value.get()]};
            }
            if (check_ref(@TypeOf(Tim20EnableValue), Tim20EnableValue, .true, .@"=")) {
                TIM20out.nodetype = .output;
                TIM20out.parents = &.{&TIMMUX20};
            }
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
                I2C2Output.nodetype = .output;
                I2C2Output.parents = &.{&I2C2Mult};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                const I2C3Mult_clk_value = I2c3ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "I2C3Mult",
                    "Else",
                    "No Extra Log",
                    "I2c3ClockSelection",
                });
                const I2C3Multparents = [_]*const ClockNode{
                    &HSIRC,
                    &SysCLKOutput,
                };
                I2C3Mult.nodetype = .multi;
                I2C3Mult.parents = &.{I2C3Multparents[I2C3Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2C3EnableValue), I2C3EnableValue, .true, .@"=")) {
                I2C3Output.nodetype = .output;
                I2C3Output.parents = &.{&I2C3Mult};
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
                    &SysCLKOutput,
                };
                I2SSrc.nodetype = .multi;
                I2SSrc.parents = &.{I2SSrcparents[I2SSrc_clk_value.get()]};
            }
            if (check_ref(@TypeOf(I2SEnableValue), I2SEnableValue, .true, .@"=")) {
                I2SClocksOutput.nodetype = .output;
                I2SClocksOutput.parents = &.{&I2SSrc};
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
                USART3Output.nodetype = .output;
                USART3Output.parents = &.{&USART3Mult};
            }
            if (check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=")) {
                const UART4Mult_clk_value = Uart4ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART4Mult",
                    "Else",
                    "No Extra Log",
                    "Uart4ClockSelection",
                });
                const UART4Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                    &APB1Prescaler,
                };
                UART4Mult.nodetype = .multi;
                UART4Mult.parents = &.{UART4Multparents[UART4Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART4EnableValue), UART4EnableValue, .true, .@"=")) {
                UART4Output.nodetype = .output;
                UART4Output.parents = &.{&UART4Mult};
            }
            if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                const UART5Mult_clk_value = Uart5ClockSelectionValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                    \\Error on Clock {s} | expr: {s} diagnostic: {s}
                    \\Clock is active but the reference value {s} is null
                    \\note: check the flags and configurations associated with this clock
                    \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
                , .{
                    "UART5Mult",
                    "Else",
                    "No Extra Log",
                    "Uart5ClockSelection",
                });
                const UART5Multparents = [_]*const ClockNode{
                    &SysCLKOutput,
                    &HSIRC,
                    &LSEOSC,
                    &APB1Prescaler,
                };
                UART5Mult.nodetype = .multi;
                UART5Mult.parents = &.{UART5Multparents[UART5Mult_clk_value.get()]};
            }
            if (check_ref(@TypeOf(UART5EnableValue), UART5EnableValue, .true, .@"=")) {
                UART5Output.nodetype = .output;
                UART5Output.parents = &.{&UART5Mult};
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
                &HSEOSC,
                &HSIRC,
            };
            PLLSource.nodetype = .multi;
            PLLSource.parents = &.{PLLSourceparents[PLLSource_clk_value.get()]};

            const PLLDiv_clk_value = PLLDividerValue orelse return comptime_fail_or_error(error.InvalidClockValue,
                \\Error on Clock {s} | expr: {s} diagnostic: {s}
                \\Clock is active but the reference value {s} is null
                \\note: check the flags and configurations associated with this clock
                \\note2: actually I'm not sure if null values and clock nodes should be treated as errors.
            , .{
                "PLLDiv",
                "Else",
                "No Extra Log",
                "PLLDivider",
            });
            PLLDiv.nodetype = .div;
            PLLDiv.value = PLLDiv_clk_value.get();
            PLLDiv.parents = &.{&PLLSource};
            VCO2output.nodetype = .output;
            VCO2output.parents = &.{&PLLDiv};

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
            HSI_PLL.nodetype = .output;
            HSI_PLL.parents = &.{&HSIRCDiv};
            HSE_RTC.nodetype = .output;
            HSE_RTC.parents = &.{&HSERTCDevisor};
            PLLCLK_MCO.nodetype = .output;
            PLLCLK_MCO.parents = &.{&MCOMultDivisor};
            PLLCLK.nodetype = .output;
            PLLCLK.parents = &.{&PLLMUL};

            //POST CLOCK REF USBFreq_Value VALUE
            _ = blk: {
                USBoutput.limit = .{
                    .min = 4.788e7,
                    .max = 4.812e7,
                };

                break :blk null;
            };

            //POST CLOCK REF SYSCLKFreq_VALUE VALUE
            _ = blk: {
                if ((TIM1SourcePLL and check_MCU("TIM1")) and (check_MCU("DIE422"))) {
                    const min: ?f32 = try math_op(?f32, TIM1out.get_as_ref(), 2, .@"/", "SYSCLKFreq_VALUE", "TIM1out", "2");
                    const max: ?f32 = null;
                    SysCLKOutput.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=TIM1Freq_Value/2",
                        .max_expr = "null",
                    };
                    break :blk null;
                } else if ((TIM1SourcePLL and check_MCU("TIM1")) and (check_MCU("DIE438") or check_MCU("DIE439"))) {
                    const min: ?f32 = try math_op(?f32, TIM1out.get_as_ref(), 4, .@"/", "SYSCLKFreq_VALUE", "TIM1out", "4");
                    const max: ?f32 = null;
                    SysCLKOutput.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=TIM1Freq_Value/4",
                        .max_expr = "null",
                    };
                    break :blk null;
                } else if ((TIM8SourcePLL and check_MCU("TIM8")) and (check_MCU("DIE422"))) {
                    const min: ?f32 = try math_op(?f32, TIM8out.get_as_ref(), 2, .@"/", "SYSCLKFreq_VALUE", "TIM8out", "2");
                    const max: ?f32 = null;
                    SysCLKOutput.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=TIM8Freq_Value/2",
                        .max_expr = "null",
                    };
                    break :blk null;
                } else if ((TIM8SourcePLL and check_MCU("TIM8")) and (check_MCU("DIE438") or check_MCU("DIE439"))) {
                    const min: ?f32 = try math_op(?f32, TIM8out.get_as_ref(), 4, .@"/", "SYSCLKFreq_VALUE", "TIM8out", "4");
                    const max: ?f32 = null;
                    SysCLKOutput.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=TIM8Freq_Value/4",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                SysCLKOutput.value = 8000000;
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

            //POST CLOCK REF HCLKFreq_Value VALUE
            _ = blk: {
                AHBOutput.limit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB1Freq_Value VALUE
            _ = blk: {
                if (config.flags.USBUsed_ForRCC and ((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4")))) and ((try math_op(?f32, SysCLKOutput.get_as_ref(), 2, .@"/", "APB1Freq_Value", "SysCLKOutput", "2")) < 10000000)) {
                    APB1Output.limit = .{
                        .min = 1e7,
                        .max = 3.6e7,
                    };

                    break :blk null;
                } else if (config.flags.USBUsed_ForRCC and ((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4")))) and ((try math_op(?f32, SysCLKOutput.get_as_ref(), 2, .@"/", "APB1Freq_Value", "SysCLKOutput", "2")) > 10000000)) {
                    const min: ?f32 = try math_op(?f32, SysCLKOutput.get_as_ref(), 2, .@"/", "APB1Freq_Value", "SysCLKOutput", "2");
                    const max: ?f32 = SysCLKOutput.get_as_ref();
                    APB1Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=SYSCLKFreq_VALUE/2",
                        .max_expr = "=SYSCLKFreq_VALUE",
                    };
                    break :blk null;
                } else if (!config.flags.USBUsed_ForRCC and ((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4"))))) {
                    const min: ?f32 = try math_op(?f32, SysCLKOutput.get_as_ref(), 2, .@"/", "APB1Freq_Value", "SysCLKOutput", "2");
                    const max: ?f32 = @min(36000000, std.math.floatMax(f32));
                    APB1Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=SYSCLKFreq_VALUE/2",
                        .max_expr = "null",
                    };
                    break :blk null;
                } else if (config.flags.USBUsed_ForRCC and !((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4"))))) {
                    APB1Output.limit = .{
                        .min = 1e7,
                        .max = 3.6e7,
                    };

                    break :blk null;
                } else if (config.flags.RTCUsed_ForRCC and !config.flags.USBUsed_ForRCC and !((TIM2SourcePLL and check_MCU("TIM2")) or (TIM34SourcePLL and (check_MCU("TIM3") or check_MCU("TIM4"))))) {
                    const min: ?f32 = RTCOutput.get_as_ref();
                    const max: ?f32 = @min(36000000, std.math.floatMax(f32));
                    APB1Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=RTCFreq_Value",
                        .max_expr = "null",
                    };
                    break :blk null;
                }
                APB1Output.limit = .{
                    .min = null,
                    .max = 3.6e7,
                };

                break :blk null;
            };

            //POST CLOCK REF APB2Freq_Value VALUE
            _ = blk: {
                if (((TIM20SourcePLL and check_MCU("TIM20")) or (TIM1SourcePLL and check_MCU("TIM1")) or (TIM8SourcePLL and check_MCU("TIM8")) or (TIM15SourcePLL and check_MCU("TIM15")) or (TIM16SourcePLL and check_MCU("TIM16")) or (TIM17SourcePLL and check_MCU("TIM17")))) {
                    const min: ?f32 = try math_op(?f32, SysCLKOutput.get_as_ref(), 2, .@"/", "APB2Freq_Value", "SysCLKOutput", "2");
                    const max: ?f32 = SysCLKOutput.get_as_ref();
                    APB2Output.limit = .{
                        .min = min,
                        .max = max,
                        .min_expr = "=SYSCLKFreq_VALUE/2",
                        .max_expr = "=SYSCLKFreq_VALUE",
                    };
                    break :blk null;
                }
                APB2Output.limit = .{
                    .min = null,
                    .max = 7.2e7,
                };

                break :blk null;
            };

            //POST CLOCK REF VCOOutput2Freq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    VCO2output.limit = .{
                        .min = 1e6,
                        .max = 2.4e7,
                    };

                    break :blk null;
                }
                VCO2output.value = 4000000;
                break :blk null;
            };

            //POST CLOCK REF PLLCLKFreq_Value VALUE
            _ = blk: {
                if (check_ref(@TypeOf(PLLUsedValue), PLLUsedValue, 1, .@"=")) {
                    PLLCLK.limit = .{
                        .min = 1.6e7,
                        .max = 7.2e7,
                    };

                    break :blk null;
                }
                PLLCLK.value = 8000000;
                break :blk null;
            };
            const FLatencyValue: ?FLatencyList = blk: {
                if (((check_ref(?f32, AHBOutput.get_as_ref(), 0, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"<")) or ((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@"=")))))) {
                    FLASH_LATENCY0 = true;
                    const item: FLatencyList = .FLASH_LATENCY_0;
                    break :blk item;
                } else if (((check_ref(?f32, AHBOutput.get_as_ref(), 24000000, .@">")) and ((check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"<")) or ((check_ref(?f32, AHBOutput.get_as_ref(), 48000000, .@"=")))))) {
                    const item: FLatencyList = .FLASH_LATENCY_1;
                    break :blk item;
                }
                const item: FLatencyList = .FLASH_LATENCY_2;
                break :blk item;
            };

            out.FCLKCortexOutput = try FCLKCortexOutput.get_output();
            out.HCLKOutput = try HCLKOutput.get_output();
            out.CortexSysOutput = try CortexSysOutput.get_output();
            out.CortexPrescaler = try CortexPrescaler.get_output();
            out.TIM2out = try TIM2out.get_output();
            out.TIMMUX2 = try TIMMUX2.get_output();
            out.TIM3out = try TIM3out.get_output();
            out.TIMMUX3 = try TIMMUX3.get_output();
            out.TimPrescOut1 = try TimPrescOut1.get_output();
            out.TimPrescalerAPB1 = try TimPrescalerAPB1.get_output();
            out.APB1Output = try APB1Output.get_output();
            out.USART2Output = try USART2Output.get_output();
            out.USART2Mult = try USART2Mult.get_output();
            out.USART3Output = try USART3Output.get_output();
            out.USART3Mult = try USART3Mult.get_output();
            out.UART4Output = try UART4Output.get_output();
            out.UART4Mult = try UART4Mult.get_output();
            out.UART5Output = try UART5Output.get_output();
            out.UART5Mult = try UART5Mult.get_output();
            out.APB1Prescaler = try APB1Prescaler.get_output();
            out.TIM1out = try TIM1out.get_output();
            out.TIMMUX1 = try TIMMUX1.get_output();
            out.TIM8out = try TIM8out.get_output();
            out.TIMMUX8 = try TIMMUX8.get_output();
            out.TIM15out = try TIM15out.get_output();
            out.TIMMUX15 = try TIMMUX15.get_output();
            out.TIM16out = try TIM16out.get_output();
            out.TIMMUX16 = try TIMMUX16.get_output();
            out.TIM17out = try TIM17out.get_output();
            out.TIMMUX17 = try TIMMUX17.get_output();
            out.TIM20out = try TIM20out.get_output();
            out.TIMMUX20 = try TIMMUX20.get_output();
            out.TimPrescOut2 = try TimPrescOut2.get_output();
            out.TimPrescalerAPB2 = try TimPrescalerAPB2.get_output();
            out.APB2Output = try APB2Output.get_output();
            out.USART1Output = try USART1Output.get_output();
            out.USART1Mult = try USART1Mult.get_output();
            out.APB2Prescaler = try APB2Prescaler.get_output();
            out.AHBOutput = try AHBOutput.get_output();
            out.AHBPrescaler = try AHBPrescaler.get_output();
            out.MCOoutput = try MCOoutput.get_output();
            out.MCODivisor = try MCODivisor.get_output();
            out.MCOMult = try MCOMult.get_output();
            out.I2C1Output = try I2C1Output.get_output();
            out.I2C1Mult = try I2C1Mult.get_output();
            out.I2C2Output = try I2C2Output.get_output();
            out.I2C2Mult = try I2C2Mult.get_output();
            out.I2C3Output = try I2C3Output.get_output();
            out.I2C3Mult = try I2C3Mult.get_output();
            out.I2SClocksOutput = try I2SClocksOutput.get_output();
            out.I2SSrc = try I2SSrc.get_output();
            out.SysCLKOutput = try SysCLKOutput.get_output();
            out.SysClkSource = try SysClkSource.get_output();
            out.MCOMultDivisor = try MCOMultDivisor.get_output();
            out.USBoutput = try USBoutput.get_output();
            out.PRESCALERUSB = try PRESCALERUSB.get_output();
            out.ADC34output = try ADC34output.get_output();
            out.ADC34PRES = try ADC34PRES.get_output();
            out.ADC12output = try ADC12output.get_output();
            out.ADC12PRES = try ADC12PRES.get_output();
            out.TIMMUL = try TIMMUL.get_output();
            out.PLLMUL = try PLLMUL.get_output();
            out.VCO2output = try VCO2output.get_output();
            out.PLLDiv = try PLLDiv.get_output();
            out.PLLSource = try PLLSource.get_output();
            out.HSIRCDiv = try HSIRCDiv.get_output();
            out.FLITFCLKoutput = try FLITFCLKoutput.get_output();
            out.HSIRC = try HSIRC.get_output();
            out.IWDGOutput = try IWDGOutput.get_output();
            out.RTCOutput = try RTCOutput.get_output();
            out.RTCClkSource = try RTCClkSource.get_output();
            out.LSIRC = try LSIRC.get_output();
            out.LSEOSC = try LSEOSC.get_output();
            out.HSERTCDevisor = try HSERTCDevisor.get_output();
            out.HSEOSC = try HSEOSC.get_output();
            out.I2S_CKIN = try I2S_CKIN.get_output();
            out.HSI_PLL = try HSI_PLL.get_extra_output();
            out.HSE_RTC = try HSE_RTC.get_extra_output();
            out.PLLCLK_MCO = try PLLCLK_MCO.get_extra_output();
            out.PLLCLK = try PLLCLK.get_extra_output();
            ref_out.HSI_VALUE = HSI_VALUEValue;
            ref_out.HSIRCDiv = HSIRCDivValue;
            ref_out.LSI_VALUE = LSI_VALUEValue;
            ref_out.LSE_VALUE = LSE_VALUEValue;
            ref_out.HSE_VALUE = HSE_VALUEValue;
            ref_out.PRESCALERUSB = PRESCALERUSBValue;
            ref_out.SYSCLKSource = SYSCLKSourceValue;
            ref_out.RCC_RTC_Clock_Source_FROM_HSE = RCC_RTC_Clock_Source_FROM_HSEValue;
            ref_out.RTCClockSelection = RTCClockSelectionValue;
            ref_out.RCC_MCOMult_Clock_Source_FROM_PLLMUL = RCC_MCOMult_Clock_Source_FROM_PLLMULValue;
            ref_out.RCC_MCOSource = RCC_MCOSourceValue;
            ref_out.RCC_MCODiv = RCC_MCODivValue;
            ref_out.AHBCLKDivider = AHBCLKDividerValue;
            ref_out.Cortex_Div = Cortex_DivValue;
            ref_out.ADC12PRES = ADC12PRESValue;
            ref_out.ADC34PRES = ADC34PRESValue;
            ref_out.APB1CLKDivider = APB1CLKDividerValue;
            ref_out.APB1TimCLKDivider = APB1TimCLKDividerValue;
            ref_out.APB2CLKDivider = APB2CLKDividerValue;
            ref_out.APB2TimCLKDivider = APB2TimCLKDividerValue;
            ref_out.TIMMUL = TIMMULValue;
            ref_out.TIM2Selection = TIM2SelectionValue;
            ref_out.TIM34Selection = TIM34SelectionValue;
            ref_out.TIM1Selection = TIM1SelectionValue;
            ref_out.TIM8Selection = TIM8SelectionValue;
            ref_out.TIM15Selection = TIM15SelectionValue;
            ref_out.TIM16Selection = TIM16SelectionValue;
            ref_out.TIM17Selection = TIM17SelectionValue;
            ref_out.TIM20Selection = TIM20SelectionValue;
            ref_out.I2c1ClockSelection = I2c1ClockSelectionValue;
            ref_out.I2c2ClockSelection = I2c2ClockSelectionValue;
            ref_out.I2c3ClockSelection = I2c3ClockSelectionValue;
            ref_out.EXTERNAL_CLOCK_VALUE = EXTERNAL_CLOCK_VALUEValue;
            ref_out.I2SClockSource = I2SClockSourceValue;
            ref_out.Usart1ClockSelection = Usart1ClockSelectionValue;
            ref_out.Usart2ClockSelection = Usart2ClockSelectionValue;
            ref_out.Usart3ClockSelection = Usart3ClockSelectionValue;
            ref_out.Uart4ClockSelection = Uart4ClockSelectionValue;
            ref_out.Uart5ClockSelection = Uart5ClockSelectionValue;
            ref_out.PLLSource = PLLSourceValue;
            ref_out.PLLDivider = PLLDividerValue;
            ref_out.PLLMUL = PLLMULValue;
            ref_out.VDD_VALUE = VDD_VALUEValue;
            ref_out.PREFETCH_ENABLE = PREFETCH_ENABLEValue;
            ref_out.FLatency = FLatencyValue;
            ref_out.HSICalibrationValue = HSICalibrationValueValue;
            ref_out.HSE_Timout = HSE_TimoutValue;
            ref_out.LSE_Timout = LSE_TimoutValue;
            ref_out.LSE_Drive_Capability = LSE_Drive_CapabilityValue;
            ref_out.flags.HSEByPass = config.flags.HSEByPass;
            ref_out.flags.HSEOscillator = config.flags.HSEOscillator;
            ref_out.flags.LSEByPass = config.flags.LSEByPass;
            ref_out.flags.LSEOscillator = config.flags.LSEOscillator;
            ref_out.flags.MCOConfig = config.flags.MCOConfig;
            ref_out.flags.AudioClockConfig = config.flags.AudioClockConfig;
            ref_out.flags.ADC1UsedAsynchronousCLK_ForRCC = config.flags.ADC1UsedAsynchronousCLK_ForRCC;
            ref_out.flags.ADC2UsedAsynchronousCLK_ForRCC = config.flags.ADC2UsedAsynchronousCLK_ForRCC;
            ref_out.flags.ADC3UsedAsynchronousCLK_ForRCC = config.flags.ADC3UsedAsynchronousCLK_ForRCC;
            ref_out.flags.ADC4UsedAsynchronousCLK_ForRCC = config.flags.ADC4UsedAsynchronousCLK_ForRCC;
            ref_out.flags.USBUsed_ForRCC = config.flags.USBUsed_ForRCC;
            ref_out.flags.RTCUsed_ForRCC = config.flags.RTCUsed_ForRCC;
            ref_out.flags.USART1Used_ForRCC = config.flags.USART1Used_ForRCC;
            ref_out.flags.USART2Used_ForRCC = config.flags.USART2Used_ForRCC;
            ref_out.flags.USART3Used_ForRCC = config.flags.USART3Used_ForRCC;
            ref_out.flags.UART4Used_ForRCC = config.flags.UART4Used_ForRCC;
            ref_out.flags.UART5Used_ForRCC = config.flags.UART5Used_ForRCC;
            ref_out.flags.IWDGUsed_ForRCC = config.flags.IWDGUsed_ForRCC;
            ref_out.flags.I2C1Used_ForRCC = config.flags.I2C1Used_ForRCC;
            ref_out.flags.I2C2Used_ForRCC = config.flags.I2C2Used_ForRCC;
            ref_out.flags.I2C3Used_ForRCC = config.flags.I2C3Used_ForRCC;
            ref_out.flags.I2S2Used_ForRCC = config.flags.I2S2Used_ForRCC;
            ref_out.flags.I2S3Used_ForRCC = config.flags.I2S3Used_ForRCC;
            ref_out.flags.MCOUsed_ForRCC = config.flags.MCOUsed_ForRCC;
            ref_out.flags.FLITFUsed_ForRCC = config.flags.FLITFUsed_ForRCC;
            ref_out.flags.LSEUsed = check_ref(?f32, LSEUsedValue, 1, .@"=");
            ref_out.flags.PLLUsed = check_ref(?f32, PLLUsedValue, 1, .@"=");
            ref_out.flags.EnableLSE = check_ref(?EnableLSEList, EnableLSEValue, .true, .@"=");
            ref_out.flags.EnableHSE = check_ref(?EnableHSEList, EnableHSEValue, .true, .@"=");
            ref_out.flags.USBEnable = check_ref(?USBEnableList, USBEnableValue, .true, .@"=");
            ref_out.flags.EnableHSERTCDevisor = check_ref(?EnableHSERTCDevisorList, EnableHSERTCDevisorValue, .true, .@"=");
            ref_out.flags.RTCEnable = check_ref(?RTCEnableList, RTCEnableValue, .true, .@"=");
            ref_out.flags.IWDGEnable = check_ref(?IWDGEnableList, IWDGEnableValue, .true, .@"=");
            ref_out.flags.MCOEnable = check_ref(?MCOEnableList, MCOEnableValue, .true, .@"=");
            ref_out.flags.ADC1Enable = check_ref(?ADC1EnableList, ADC1EnableValue, .true, .@"=");
            ref_out.flags.ADC2Enable = check_ref(?ADC2EnableList, ADC2EnableValue, .true, .@"=");
            ref_out.flags.ADC3Enable = check_ref(?ADC3EnableList, ADC3EnableValue, .true, .@"=");
            ref_out.flags.ADC4Enable = check_ref(?ADC4EnableList, ADC4EnableValue, .true, .@"=");
            ref_out.flags.Tim2Enable = check_ref(?Tim2EnableList, Tim2EnableValue, .true, .@"=");
            ref_out.flags.Tim3Enable = check_ref(?Tim3EnableList, Tim3EnableValue, .true, .@"=");
            ref_out.flags.Tim4Enable = check_ref(?Tim4EnableList, Tim4EnableValue, .true, .@"=");
            ref_out.flags.Tim1Enable = check_ref(?Tim1EnableList, Tim1EnableValue, .true, .@"=");
            ref_out.flags.Tim8Enable = check_ref(?Tim8EnableList, Tim8EnableValue, .true, .@"=");
            ref_out.flags.Tim15Enable = check_ref(?Tim15EnableList, Tim15EnableValue, .true, .@"=");
            ref_out.flags.Tim16Enable = check_ref(?Tim16EnableList, Tim16EnableValue, .true, .@"=");
            ref_out.flags.Tim17Enable = check_ref(?Tim17EnableList, Tim17EnableValue, .true, .@"=");
            ref_out.flags.Tim20Enable = check_ref(?Tim20EnableList, Tim20EnableValue, .true, .@"=");
            ref_out.flags.I2C1Enable = check_ref(?I2C1EnableList, I2C1EnableValue, .true, .@"=");
            ref_out.flags.I2C2Enable = check_ref(?I2C2EnableList, I2C2EnableValue, .true, .@"=");
            ref_out.flags.I2C3Enable = check_ref(?I2C3EnableList, I2C3EnableValue, .true, .@"=");
            ref_out.flags.ExtClockEnable = check_ref(?ExtClockEnableList, ExtClockEnableValue, .true, .@"=");
            ref_out.flags.I2SEnable = check_ref(?I2SEnableList, I2SEnableValue, .true, .@"=");
            ref_out.flags.USART1Enable = check_ref(?USART1EnableList, USART1EnableValue, .true, .@"=");
            ref_out.flags.USART2Enable = check_ref(?USART2EnableList, USART2EnableValue, .true, .@"=");
            ref_out.flags.USART3Enable = check_ref(?USART3EnableList, USART3EnableValue, .true, .@"=");
            ref_out.flags.UART4Enable = check_ref(?UART4EnableList, UART4EnableValue, .true, .@"=");
            ref_out.flags.UART5Enable = check_ref(?UART5EnableList, UART5EnableValue, .true, .@"=");
            ref_out.flags.EnableHSIRTCDevisor = check_ref(?EnableHSIRTCDevisorList, EnableHSIRTCDevisorValue, .true, .@"=");
            ref_out.flags.EnableMCOMultDivisor = check_ref(?EnableMCOMultDivisorList, EnableMCOMultDivisorValue, .true, .@"=");
            ref_out.flags.EnableLSERTC = check_ref(?EnableLSERTCList, EnableLSERTCValue, .true, .@"=");
            ref_out.flags.FLITFCLKFEnable = check_ref(?FLITFCLKFEnableList, FLITFCLKFEnableValue, .true, .@"=");
            ref_out.flags.HSEUsed = check_ref(?f32, HSEUsedValue, 1, .@"=");
            ref_out.flags.LSIUsed = check_ref(?f32, LSIUsedValue, 1, .@"=");
            ref_out.flags.HSIUsed = check_ref(?f32, HSIUsedValue, 1, .@"=");
            return Tree_Output{
                .clock = out,
                .config = ref_out,
            };
        }
    };
}
