const std = @import("std");
const clock = @import("clocknodes.zig");
const ClockNode = clock.ClockNode;
const ClockNodeTypes = clock.ClockNodesTypes;
const ClockState = clock.ClockState;
const ClockError = clock.ClockError;

pub const LSE_VALUEConf = enum(u32) {
    _,
    pub fn get(num: @This()) f32 {
        const val: u32 = @intFromEnum(num);
        return @as(f32, @floatFromInt(val));
    }
};
pub const HSE_VALUEConf = enum(u32) {
    _,
    pub fn get(num: @This()) f32 {
        const val: u32 = @intFromEnum(num);
        return @as(f32, @floatFromInt(val));
    }
};
pub const Prediv2Conf = enum {
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
            .RCC_HSE_PREDIV2_DIV12 => 12,
            .RCC_HSE_PREDIV2_DIV16 => 16,
            .RCC_HSE_PREDIV2_DIV1 => 1,
            .RCC_HSE_PREDIV2_DIV6 => 6,
            .RCC_HSE_PREDIV2_DIV9 => 9,
            .RCC_HSE_PREDIV2_DIV15 => 15,
            .RCC_HSE_PREDIV2_DIV3 => 3,
            .RCC_HSE_PREDIV2_DIV5 => 5,
            .RCC_HSE_PREDIV2_DIV4 => 4,
            .RCC_HSE_PREDIV2_DIV13 => 13,
            .RCC_HSE_PREDIV2_DIV7 => 7,
            .RCC_HSE_PREDIV2_DIV10 => 10,
            .RCC_HSE_PREDIV2_DIV2 => 2,
            .RCC_HSE_PREDIV2_DIV11 => 11,
            .RCC_HSE_PREDIV2_DIV8 => 8,
            .RCC_HSE_PREDIV2_DIV14 => 14,
        };
    }
};
pub const PLL2MulConf = enum {
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
            .RCC_PLL2_MUL20 => 20,
            .RCC_PLL2_MUL16 => 16,
            .RCC_PLL2_MUL10 => 10,
            .RCC_PLL2_MUL8 => 8,
            .RCC_PLL2_MUL14 => 14,
            .RCC_PLL2_MUL12 => 12,
            .RCC_PLL2_MUL11 => 11,
            .RCC_PLL2_MUL9 => 9,
            .RCC_PLL2_MUL13 => 13,
        };
    }
};
pub const PLL3MulConf = enum {
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
            .RCC_PLLI2S_MUL14 => 14,
            .RCC_PLLI2S_MUL11 => 11,
            .RCC_PLLI2S_MUL9 => 9,
            .RCC_PLLI2S_MUL8 => 8,
            .RCC_PLLI2S_MUL13 => 13,
            .RCC_PLLI2S_MUL20 => 20,
            .RCC_PLLI2S_MUL12 => 12,
            .RCC_PLLI2S_MUL10 => 10,
            .RCC_PLLI2S_MUL16 => 16,
        };
    }
};
pub const SYSCLKSourceConf = enum {
    RCC_SYSCLKSOURCE_HSI,
    RCC_SYSCLKSOURCE_HSE,
    RCC_SYSCLKSOURCE_PLLCLK,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const I2S2ClockSelectionConf = enum {
    RCC_I2S2CLKSOURCE_SYSCLK,
    RCC_I2S2CLKSOURCE_PLLI2S_VCO,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const I2S3ClockSelectionConf = enum {
    RCC_I2S3CLKSOURCE_SYSCLK,
    RCC_I2S3CLKSOURCE_PLLI2S_VCO,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const RTCClockSelectionConf = enum {
    RCC_RTCCLKSOURCE_HSE_DIV128,
    RCC_RTCCLKSOURCE_LSE,
    RCC_RTCCLKSOURCE_LSI,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const RCC_MCOMult_Clock_Source_FROM_PLL3MULConf = enum {
    RCC_MCO1SOURCE_PLL3CLK,
    RCC_MCO1SOURCE_PLL3CLK_DIV2,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_MCO1SOURCE_PLL3CLK => 1,
            .RCC_MCO1SOURCE_PLL3CLK_DIV2 => 2,
        };
    }
};
pub const RCC_MCOSourceConf = enum {
    RCC_MCO1SOURCE_HSE,
    RCC_MCO1SOURCE_HSI,
    RCC_MCO1SOURCE_SYSCLK,
    RCC_MCO1SOURCE_PLLCLK,
    RCC_MCO1SOURCE_PLL2CLK,
    MCOPLL3Div,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const AHBCLKDividerConf = enum {
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
            .RCC_SYSCLK_DIV64 => 64,
            .RCC_SYSCLK_DIV2 => 2,
            .RCC_SYSCLK_DIV512 => 512,
            .RCC_SYSCLK_DIV16 => 16,
            .RCC_SYSCLK_DIV1 => 1,
            .RCC_SYSCLK_DIV4 => 4,
            .RCC_SYSCLK_DIV8 => 8,
            .RCC_SYSCLK_DIV256 => 256,
            .RCC_SYSCLK_DIV128 => 128,
        };
    }
};
pub const TimSys_DivConf = enum {
    SYSTICK_CLKSOURCE_HCLK,
    SYSTICK_CLKSOURCE_HCLK_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .SYSTICK_CLKSOURCE_HCLK => 1,
            .SYSTICK_CLKSOURCE_HCLK_DIV8 => 8,
        };
    }
};
pub const APB1CLKDividerConf = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV16 => 16,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV1 => 1,
        };
    }
};
pub const APB2CLKDividerConf = enum {
    RCC_HCLK_DIV1,
    RCC_HCLK_DIV2,
    RCC_HCLK_DIV4,
    RCC_HCLK_DIV8,
    RCC_HCLK_DIV16,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_HCLK_DIV16 => 16,
            .RCC_HCLK_DIV2 => 2,
            .RCC_HCLK_DIV8 => 8,
            .RCC_HCLK_DIV4 => 4,
            .RCC_HCLK_DIV1 => 1,
        };
    }
};
pub const ADCPrescConf = enum {
    RCC_ADCPCLK2_DIV2,
    RCC_ADCPCLK2_DIV4,
    RCC_ADCPCLK2_DIV6,
    RCC_ADCPCLK2_DIV8,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_ADCPCLK2_DIV6 => 6,
            .RCC_ADCPCLK2_DIV8 => 8,
            .RCC_ADCPCLK2_DIV2 => 2,
            .RCC_ADCPCLK2_DIV4 => 4,
        };
    }
};
pub const Prediv1SourceConf = enum {
    RCC_PREDIV1_SOURCE_HSE,
    RCC_PREDIV1_SOURCE_PLL2,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const HSEDivPLLConf = enum {
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
            .RCC_HSE_PREDIV_DIV16 => 16,
            .RCC_HSE_PREDIV_DIV5 => 5,
            .RCC_HSE_PREDIV_DIV14 => 14,
            .RCC_HSE_PREDIV_DIV13 => 13,
            .RCC_HSE_PREDIV_DIV8 => 8,
            .RCC_HSE_PREDIV_DIV2 => 2,
            .RCC_HSE_PREDIV_DIV10 => 10,
            .RCC_HSE_PREDIV_DIV6 => 6,
            .RCC_HSE_PREDIV_DIV9 => 9,
            .RCC_HSE_PREDIV_DIV3 => 3,
            .RCC_HSE_PREDIV_DIV15 => 15,
            .RCC_HSE_PREDIV_DIV12 => 12,
            .RCC_HSE_PREDIV_DIV11 => 11,
            .RCC_HSE_PREDIV_DIV1 => 1,
            .RCC_HSE_PREDIV_DIV4 => 4,
            .RCC_HSE_PREDIV_DIV7 => 7,
        };
    }
};
pub const PLLSourceVirtualConf = enum {
    RCC_PLLSOURCE_HSI_DIV2,
    RCC_PLLSOURCE_HSE,

    pub fn get(self: @This()) usize {
        return @intFromEnum(self);
    }
};
pub const PLLMULConf = enum {
    RCC_PLL_MUL4,
    RCC_PLL_MUL5,
    RCC_PLL_MUL6,
    RCC_PLL_MUL6_5,
    RCC_PLL_MUL7,
    RCC_PLL_MUL8,
    RCC_PLL_MUL9,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_PLL_MUL7 => 7,
            .RCC_PLL_MUL9 => 9,
            .RCC_PLL_MUL6_5 => 6.5,
            .RCC_PLL_MUL6 => 6,
            .RCC_PLL_MUL5 => 5,
            .RCC_PLL_MUL4 => 4,
            .RCC_PLL_MUL8 => 8,
        };
    }
};
pub const USBPrescalerConf = enum {
    RCC_USBCLKSOURCE_PLL_DIV2,
    RCC_USBCLKSOURCE_PLL_DIV3,
    pub fn get(self: @This()) f32 {
        return switch (self) {
            .RCC_USBCLKSOURCE_PLL_DIV2 => 2,
            .RCC_USBCLKSOURCE_PLL_DIV3 => 3,
        };
    }
};
pub const HSE_TimoutConf = enum(u32) {
    _,
    pub fn get(num: @This()) f32 {
        const val: u32 = @intFromEnum(num);
        return @as(f32, @floatFromInt(val));
    }
};
pub const LSE_TimoutConf = enum(u32) {
    _,
    pub fn get(num: @This()) f32 {
        const val: u32 = @intFromEnum(num);
        return @as(f32, @floatFromInt(val));
    }
};
pub const HSICalibrationValueConf = enum(u32) {
    _,
    pub fn get(num: @This()) f32 {
        const val: u32 = @intFromEnum(num);
        return @as(f32, @floatFromInt(val));
    }
};
pub const Config = struct {
    LSEOSC: ?LSE_VALUEConf = null,
    HSEOSC: ?HSE_VALUEConf = null,
    Prediv2: ?Prediv2Conf = null,
    PLL2Mul: ?PLL2MulConf = null,
    PLL3Mul: ?PLL3MulConf = null,
    SysClkSource: ?SYSCLKSourceConf = null,
    I2S2Mult: ?I2S2ClockSelectionConf = null,
    I2S3Mult: ?I2S3ClockSelectionConf = null,
    RTCClkSource: ?RTCClockSelectionConf = null,
    MCOPLL3Div: ?RCC_MCOMult_Clock_Source_FROM_PLL3MULConf = null,
    MCOMult: ?RCC_MCOSourceConf = null,
    AHBPrescaler: ?AHBCLKDividerConf = null,
    TimSysPresc: ?TimSys_DivConf = null,
    APB1Prescaler: ?APB1CLKDividerConf = null,
    APB2Prescaler: ?APB2CLKDividerConf = null,
    ADCprescaler: ?ADCPrescConf = null,
    Prediv1Source: ?Prediv1SourceConf = null,
    PreDiv1: ?HSEDivPLLConf = null,
    PLLSource: ?PLLSourceVirtualConf = null,
    PLLMUL: ?PLLMULConf = null,
    USBPrescaler: ?USBPrescalerConf = null,
    HSE_Timout: ?HSE_TimoutConf = null,
    LSE_Timout: ?LSE_TimoutConf = null,
    HSICalibrationValue: ?HSICalibrationValueConf = null,
};

pub const ConfigWithRef = struct {
    LSE_VALUE: ?LSE_VALUEConf = null,
    HSE_VALUE: ?HSE_VALUEConf = null,
    Prediv2: ?Prediv2Conf = null,
    PLL2Mul: ?PLL2MulConf = null,
    PLL3Mul: ?PLL3MulConf = null,
    SYSCLKSource: ?SYSCLKSourceConf = null,
    I2S2ClockSelection: ?I2S2ClockSelectionConf = null,
    I2S3ClockSelection: ?I2S3ClockSelectionConf = null,
    RTCClockSelection: ?RTCClockSelectionConf = null,
    RCC_MCOMult_Clock_Source_FROM_PLL3MUL: ?RCC_MCOMult_Clock_Source_FROM_PLL3MULConf = null,
    RCC_MCOSource: ?RCC_MCOSourceConf = null,
    AHBCLKDivider: ?AHBCLKDividerConf = null,
    TimSys_Div: ?TimSys_DivConf = null,
    APB1CLKDivider: ?APB1CLKDividerConf = null,
    APB2CLKDivider: ?APB2CLKDividerConf = null,
    ADCPresc: ?ADCPrescConf = null,
    Prediv1Source: ?Prediv1SourceConf = null,
    HSEDivPLL: ?HSEDivPLLConf = null,
    PLLSourceVirtual: ?PLLSourceVirtualConf = null,
    PLLMUL: ?PLLMULConf = null,
    USBPrescaler: ?USBPrescalerConf = null,
    HSE_Timout: ?HSE_TimoutConf = null,
    LSE_Timout: ?LSE_TimoutConf = null,
    HSICalibrationValue: ?HSICalibrationValueConf = null,
    pub fn into_config(self: *const ConfigWithRef) Config {
        return .{
            .LSEOSC = self.LSE_VALUE,
            .HSEOSC = self.HSE_VALUE,
            .Prediv2 = self.Prediv2,
            .PLL2Mul = self.PLL2Mul,
            .PLL3Mul = self.PLL3Mul,
            .SysClkSource = self.SYSCLKSource,
            .I2S2Mult = self.I2S2ClockSelection,
            .I2S3Mult = self.I2S3ClockSelection,
            .RTCClkSource = self.RTCClockSelection,
            .MCOPLL3Div = self.RCC_MCOMult_Clock_Source_FROM_PLL3MUL,
            .MCOMult = self.RCC_MCOSource,
            .AHBPrescaler = self.AHBCLKDivider,
            .TimSysPresc = self.TimSys_Div,
            .APB1Prescaler = self.APB1CLKDivider,
            .APB2Prescaler = self.APB2CLKDivider,
            .ADCprescaler = self.ADCPresc,
            .Prediv1Source = self.Prediv1Source,
            .PreDiv1 = self.HSEDivPLL,
            .PLLSource = self.PLLSourceVirtual,
            .PLLMUL = self.PLLMUL,
            .USBPrescaler = self.USBPrescaler,
            .HSE_Timout = self.HSE_Timout,
            .LSE_Timout = self.LSE_Timout,
            .HSICalibrationValue = self.HSICalibrationValue,
        };
    }
};

pub const ClockTree = struct {
    const this = @This();

    HSIRC: ClockNode,
    FLITFCLKoutput: ClockNode,
    HSIDivPLL: ClockNode,
    LSIRC: ClockNode,
    LSEOSC: ClockNode,
    HSEOSC: ClockNode,
    Prediv2: ClockNode,
    Prediv2output: ClockNode,
    PLL2Mul: ClockNode,
    PLL2VCOMul2: ClockNode,
    PLL2VCOoutput: ClockNode,
    PLL2CLKoutput: ClockNode,
    PLL3Mul: ClockNode,
    PLL3VCOMul2: ClockNode,
    PLL3VCOoutput: ClockNode,
    PLL3CLKoutput: ClockNode,
    SysClkSource: ClockNode,
    SysCLKOutput: ClockNode,
    I2S2Mult: ClockNode,
    I2S2Output: ClockNode,
    I2S3Mult: ClockNode,
    I2S3Output: ClockNode,
    HSERTCDevisor: ClockNode,
    RTCClkSource: ClockNode,
    RTCOutput: ClockNode,
    IWDGOutput: ClockNode,
    MCOPLL3Div: ClockNode,
    MCOMultDivisor: ClockNode,
    MCOMult: ClockNode,
    MCOoutput: ClockNode,
    AHBPrescaler: ClockNode,
    AHBOutput: ClockNode,
    HCLKOutput: ClockNode,
    FCLKCortexOutput: ClockNode,
    TimSysPresc: ClockNode,
    TimSysOutput: ClockNode,
    APB1Prescaler: ClockNode,
    APB1Output: ClockNode,
    TimPrescalerAPB1: ClockNode,
    TimPrescOut1: ClockNode,
    APB2Prescaler: ClockNode,
    APB2Output: ClockNode,
    TimPrescalerAPB2: ClockNode,
    TimPrescOut2: ClockNode,
    ADCprescaler: ClockNode,
    ADCoutput: ClockNode,
    Prediv1Source: ClockNode,
    PreDiv1: ClockNode,
    PLLSource: ClockNode,
    VCO2output: ClockNode,
    PLLMUL: ClockNode,
    PLLVCOMul2: ClockNode,
    USBPrescaler: ClockNode,
    USBoutput: ClockNode,
    HSE_Timout: ClockNodeTypes,
    LSE_Timout: ClockNodeTypes,
    HSICalibrationValue: ClockNodeTypes,

    pub fn init_comptime(comptime config: Config) this {
        const HSIRCval = ClockNodeTypes{
            .source = .{ .value = 8000000 },
        };
        const HSIRC: ClockNode = .{
            .name = "HSIRC",
            .Nodetype = HSIRCval,
        };
        const FLITFCLKoutputval = ClockNodeTypes{ .output = null };
        const FLITFCLKoutput: ClockNode = .{
            .name = "FLITFCLKoutput",
            .Nodetype = FLITFCLKoutputval,
            .parents = &[_]*const ClockNode{&HSIRC},
        };
        const HSIDivPLLval = ClockNodeTypes{
            .div = .{ .value = 2 },
        };
        const HSIDivPLL: ClockNode = .{
            .name = "HSIDivPLL",
            .Nodetype = HSIDivPLLval,
            .parents = &[_]*const ClockNode{&HSIRC},
        };
        const LSIRCval = ClockNodeTypes{
            .source = .{ .value = 40000 },
        };
        const LSIRC: ClockNode = .{
            .name = "LSIRC",
            .Nodetype = LSIRCval,
        };
        const LSEOSCval = ClockNodeTypes{
            .source = .{
                .value = if (config.LSEOSC) |val| val.get() else 32768,
                .limit = .{ .max = 1000000, .min = 0 },
            },
        };
        const LSEOSC: ClockNode = .{
            .name = "LSEOSC",
            .Nodetype = LSEOSCval,
        };
        const HSEOSCval = ClockNodeTypes{
            .source = .{
                .value = if (config.HSEOSC) |val| val.get() else 8000000,
                .limit = .{ .max = 25000000, .min = 3000000 },
            },
        };
        const HSEOSC: ClockNode = .{
            .name = "HSEOSC",
            .Nodetype = HSEOSCval,
        };
        const Prediv2val = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.Prediv2) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const Prediv2: ClockNode = .{
            .name = "Prediv2",
            .Nodetype = Prediv2val,
            .parents = &[_]*const ClockNode{&HSEOSC},
        };
        const Prediv2outputval = ClockNodeTypes{ .output = null };
        const Prediv2output: ClockNode = .{
            .name = "Prediv2output",
            .Nodetype = Prediv2outputval,
            .parents = &[_]*const ClockNode{&Prediv2},
        };
        const PLL2Mulval = ClockNodeTypes{ .mul = .{
            .value = inner: {
                if (config.PLL2Mul) |val| {
                    break :inner val.get();
                } else {
                    break :inner 8;
                }
            },
        } };
        const PLL2Mul: ClockNode = .{
            .name = "PLL2Mul",
            .Nodetype = PLL2Mulval,
            .parents = &[_]*const ClockNode{&Prediv2output},
        };
        const PLL2VCOMul2val = ClockNodeTypes{
            .mul = .{ .value = 2 },
        };
        const PLL2VCOMul2: ClockNode = .{
            .name = "PLL2VCOMul2",
            .Nodetype = PLL2VCOMul2val,
            .parents = &[_]*const ClockNode{&PLL2Mul},
        };
        const PLL2VCOoutputval = ClockNodeTypes{ .output = null };
        const PLL2VCOoutput: ClockNode = .{
            .name = "PLL2VCOoutput",
            .Nodetype = PLL2VCOoutputval,
            .parents = &[_]*const ClockNode{&PLL2VCOMul2},
        };
        const PLL2CLKoutputval = ClockNodeTypes{ .output = null };
        const PLL2CLKoutput: ClockNode = .{
            .name = "PLL2CLKoutput",
            .Nodetype = PLL2CLKoutputval,
            .parents = &[_]*const ClockNode{&PLL2Mul},
        };
        const PLL3Mulval = ClockNodeTypes{ .mul = .{
            .value = inner: {
                if (config.PLL3Mul) |val| {
                    break :inner val.get();
                } else {
                    break :inner 8;
                }
            },
        } };
        const PLL3Mul: ClockNode = .{
            .name = "PLL3Mul",
            .Nodetype = PLL3Mulval,
            .parents = &[_]*const ClockNode{&Prediv2output},
        };
        const PLL3VCOMul2val = ClockNodeTypes{
            .mul = .{ .value = 2 },
        };
        const PLL3VCOMul2: ClockNode = .{
            .name = "PLL3VCOMul2",
            .Nodetype = PLL3VCOMul2val,
            .parents = &[_]*const ClockNode{&PLL3Mul},
        };
        const PLL3VCOoutputval = ClockNodeTypes{ .output = null };
        const PLL3VCOoutput: ClockNode = .{
            .name = "PLL3VCOoutput",
            .Nodetype = PLL3VCOoutputval,
            .parents = &[_]*const ClockNode{&PLL3VCOMul2},
        };
        const PLL3CLKoutputval = ClockNodeTypes{ .output = null };
        const PLL3CLKoutput: ClockNode = .{
            .name = "PLL3CLKoutput",
            .Nodetype = PLL3CLKoutputval,
            .parents = &[_]*const ClockNode{&PLL3Mul},
        };
        const Prediv1Sourceval = ClockNodeTypes{
            .multi = inner: {
                if (config.Prediv1Source) |val| {
                    break :inner val.get();
                } else {
                    break :inner 0;
                }
            },
        };
        const Prediv1Source: ClockNode = .{
            .name = "Prediv1Source",
            .Nodetype = Prediv1Sourceval,

            .parents = &[_]*const ClockNode{
                &HSEOSC,
                &PLL2CLKoutput,
            },
        };
        const PreDiv1val = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.PreDiv1) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const PreDiv1: ClockNode = .{
            .name = "PreDiv1",
            .Nodetype = PreDiv1val,
            .parents = &[_]*const ClockNode{&Prediv1Source},
        };
        const PLLSourceval = ClockNodeTypes{
            .multi = inner: {
                if (config.PLLSource) |val| {
                    break :inner val.get();
                } else {
                    break :inner 0;
                }
            },
        };
        const PLLSource: ClockNode = .{
            .name = "PLLSource",
            .Nodetype = PLLSourceval,

            .parents = &[_]*const ClockNode{
                &HSIDivPLL,
                &PreDiv1,
            },
        };
        const VCO2outputval = ClockNodeTypes{ .output = null };
        const VCO2output: ClockNode = .{
            .name = "VCO2output",
            .Nodetype = VCO2outputval,
            .parents = &[_]*const ClockNode{&PLLSource},
        };
        const PLLMULval = ClockNodeTypes{ .mul = .{
            .value = inner: {
                if (config.PLLMUL) |val| {
                    break :inner val.get();
                } else {
                    break :inner 4;
                }
            },
        } };
        const PLLMUL: ClockNode = .{
            .name = "PLLMUL",
            .Nodetype = PLLMULval,
            .parents = &[_]*const ClockNode{&VCO2output},
        };
        const SysClkSourceval = ClockNodeTypes{
            .multi = inner: {
                if (config.SysClkSource) |val| {
                    break :inner val.get();
                } else {
                    break :inner 0;
                }
            },
        };
        const SysClkSource: ClockNode = .{
            .name = "SysClkSource",
            .Nodetype = SysClkSourceval,

            .parents = &[_]*const ClockNode{
                &HSIRC,
                &HSEOSC,
                &PLLMUL,
            },
        };
        const SysCLKOutputval = ClockNodeTypes{
            .output = .{ .max = 72000000, .min = 0 },
        };
        const SysCLKOutput: ClockNode = .{
            .name = "SysCLKOutput",
            .Nodetype = SysCLKOutputval,
            .parents = &[_]*const ClockNode{&SysClkSource},
        };
        const I2S2Multval = ClockNodeTypes{
            .multi = inner: {
                if (config.I2S2Mult) |val| {
                    break :inner val.get();
                } else {
                    break :inner 0;
                }
            },
        };
        const I2S2Mult: ClockNode = .{
            .name = "I2S2Mult",
            .Nodetype = I2S2Multval,

            .parents = &[_]*const ClockNode{
                &SysCLKOutput,
                &PLL3VCOoutput,
            },
        };
        const I2S2Outputval = ClockNodeTypes{ .output = null };
        const I2S2Output: ClockNode = .{
            .name = "I2S2Output",
            .Nodetype = I2S2Outputval,
            .parents = &[_]*const ClockNode{&I2S2Mult},
        };
        const I2S3Multval = ClockNodeTypes{
            .multi = inner: {
                if (config.I2S3Mult) |val| {
                    break :inner val.get();
                } else {
                    break :inner 0;
                }
            },
        };
        const I2S3Mult: ClockNode = .{
            .name = "I2S3Mult",
            .Nodetype = I2S3Multval,

            .parents = &[_]*const ClockNode{
                &SysCLKOutput,
                &PLL3VCOoutput,
            },
        };
        const I2S3Outputval = ClockNodeTypes{ .output = null };
        const I2S3Output: ClockNode = .{
            .name = "I2S3Output",
            .Nodetype = I2S3Outputval,
            .parents = &[_]*const ClockNode{&I2S3Mult},
        };
        const HSERTCDevisorval = ClockNodeTypes{
            .div = .{ .value = 128 },
        };
        const HSERTCDevisor: ClockNode = .{
            .name = "HSERTCDevisor",
            .Nodetype = HSERTCDevisorval,
            .parents = &[_]*const ClockNode{&HSEOSC},
        };
        const RTCClkSourceval = ClockNodeTypes{
            .multi = inner: {
                if (config.RTCClkSource) |val| {
                    break :inner val.get();
                } else {
                    break :inner 2;
                }
            },
        };
        const RTCClkSource: ClockNode = .{
            .name = "RTCClkSource",
            .Nodetype = RTCClkSourceval,

            .parents = &[_]*const ClockNode{
                &HSERTCDevisor,
                &LSEOSC,
                &LSIRC,
            },
        };
        const RTCOutputval = ClockNodeTypes{ .output = null };
        const RTCOutput: ClockNode = .{
            .name = "RTCOutput",
            .Nodetype = RTCOutputval,
            .parents = &[_]*const ClockNode{&RTCClkSource},
        };
        const IWDGOutputval = ClockNodeTypes{ .output = null };
        const IWDGOutput: ClockNode = .{
            .name = "IWDGOutput",
            .Nodetype = IWDGOutputval,
            .parents = &[_]*const ClockNode{&LSIRC},
        };
        const MCOPLL3Divval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.MCOPLL3Div) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const MCOPLL3Div: ClockNode = .{
            .name = "MCOPLL3Div",
            .Nodetype = MCOPLL3Divval,
            .parents = &[_]*const ClockNode{&PLL3CLKoutput},
        };
        const MCOMultDivisorval = ClockNodeTypes{
            .div = .{ .value = 2 },
        };
        const MCOMultDivisor: ClockNode = .{
            .name = "MCOMultDivisor",
            .Nodetype = MCOMultDivisorval,
            .parents = &[_]*const ClockNode{&PLLMUL},
        };
        const MCOMultval = ClockNodeTypes{
            .multi = inner: {
                if (config.MCOMult) |val| {
                    switch (val) {
                        .RCC_MCO1SOURCE_HSE,
                        .RCC_MCO1SOURCE_HSI,
                        .RCC_MCO1SOURCE_SYSCLK,
                        .RCC_MCO1SOURCE_PLLCLK,
                        .RCC_MCO1SOURCE_PLL2CLK,
                        => {
                            break :inner val.get();
                        },
                        else => {},
                    }
                    @compileError(std.fmt.comptimePrint("value {s} depends on an expression that returned false", .{@tagName(val)}));
                } else {
                    break :inner 2;
                }
            },
        };
        const MCOMult: ClockNode = .{
            .name = "MCOMult",
            .Nodetype = MCOMultval,

            .parents = &[_]*const ClockNode{
                &HSEOSC,
                &HSIRC,
                &SysCLKOutput,
                &MCOMultDivisor,
                &PLL2CLKoutput,
                &MCOPLL3Div,
            },
        };
        const MCOoutputval = ClockNodeTypes{
            .output = .{ .max = 50000000, .min = 0 },
        };
        const MCOoutput: ClockNode = .{
            .name = "MCOoutput",
            .Nodetype = MCOoutputval,
            .parents = &[_]*const ClockNode{&MCOMult},
        };
        const AHBPrescalerval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.AHBPrescaler) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const AHBPrescaler: ClockNode = .{
            .name = "AHBPrescaler",
            .Nodetype = AHBPrescalerval,
            .parents = &[_]*const ClockNode{&SysCLKOutput},
        };
        const AHBOutputval = ClockNodeTypes{
            .output = .{ .max = 72000000, .min = 0 },
        };
        const AHBOutput: ClockNode = .{
            .name = "AHBOutput",
            .Nodetype = AHBOutputval,
            .parents = &[_]*const ClockNode{&AHBPrescaler},
        };
        const HCLKOutputval = ClockNodeTypes{ .output = null };
        const HCLKOutput: ClockNode = .{
            .name = "HCLKOutput",
            .Nodetype = HCLKOutputval,
            .parents = &[_]*const ClockNode{&AHBOutput},
        };
        const FCLKCortexOutputval = ClockNodeTypes{ .output = null };
        const FCLKCortexOutput: ClockNode = .{
            .name = "FCLKCortexOutput",
            .Nodetype = FCLKCortexOutputval,
            .parents = &[_]*const ClockNode{&AHBOutput},
        };
        const TimSysPrescval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.TimSysPresc) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const TimSysPresc: ClockNode = .{
            .name = "TimSysPresc",
            .Nodetype = TimSysPrescval,
            .parents = &[_]*const ClockNode{&AHBOutput},
        };
        const TimSysOutputval = ClockNodeTypes{ .output = null };
        const TimSysOutput: ClockNode = .{
            .name = "TimSysOutput",
            .Nodetype = TimSysOutputval,
            .parents = &[_]*const ClockNode{&TimSysPresc},
        };
        const APB1Prescalerval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.APB1Prescaler) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const APB1Prescaler: ClockNode = .{
            .name = "APB1Prescaler",
            .Nodetype = APB1Prescalerval,
            .parents = &[_]*const ClockNode{&AHBOutput},
        };
        const APB1Outputval = ClockNodeTypes{
            .output = .{ .max = 36000000, .min = 0 },
        };
        const APB1Output: ClockNode = .{
            .name = "APB1Output",
            .Nodetype = APB1Outputval,
            .parents = &[_]*const ClockNode{&APB1Prescaler},
        };
        const TimPrescalerAPB1val = blk: {
            if (APB1Prescalerval.num_val() == 1) {
                break :blk ClockNodeTypes{
                    .mul = .{ .value = 1 },
                };
            } else {
                break :blk ClockNodeTypes{
                    .mul = .{ .value = 2 },
                };
            }
        };
        const TimPrescalerAPB1: ClockNode = .{
            .name = "TimPrescalerAPB1",
            .Nodetype = TimPrescalerAPB1val,
            .parents = &[_]*const ClockNode{&APB1Prescaler},
        };
        const TimPrescOut1val = ClockNodeTypes{ .output = null };
        const TimPrescOut1: ClockNode = .{
            .name = "TimPrescOut1",
            .Nodetype = TimPrescOut1val,
            .parents = &[_]*const ClockNode{&TimPrescalerAPB1},
        };
        const APB2Prescalerval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.APB2Prescaler) |val| {
                    break :inner val.get();
                } else {
                    break :inner 1;
                }
            },
        } };
        const APB2Prescaler: ClockNode = .{
            .name = "APB2Prescaler",
            .Nodetype = APB2Prescalerval,
            .parents = &[_]*const ClockNode{&AHBOutput},
        };
        const APB2Outputval = ClockNodeTypes{
            .output = .{ .max = 72000000, .min = 0 },
        };
        const APB2Output: ClockNode = .{
            .name = "APB2Output",
            .Nodetype = APB2Outputval,
            .parents = &[_]*const ClockNode{&APB2Prescaler},
        };
        const TimPrescalerAPB2val = blk: {
            if (APB2Prescalerval.num_val() == 1) {
                break :blk ClockNodeTypes{
                    .mul = .{ .value = 1 },
                };
            } else {
                break :blk ClockNodeTypes{
                    .mul = .{ .value = 2 },
                };
            }
        };
        const TimPrescalerAPB2: ClockNode = .{
            .name = "TimPrescalerAPB2",
            .Nodetype = TimPrescalerAPB2val,
            .parents = &[_]*const ClockNode{&APB2Prescaler},
        };
        const TimPrescOut2val = ClockNodeTypes{ .output = null };
        const TimPrescOut2: ClockNode = .{
            .name = "TimPrescOut2",
            .Nodetype = TimPrescOut2val,
            .parents = &[_]*const ClockNode{&TimPrescalerAPB2},
        };
        const ADCprescalerval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.ADCprescaler) |val| {
                    break :inner val.get();
                } else {
                    break :inner 2;
                }
            },
        } };
        const ADCprescaler: ClockNode = .{
            .name = "ADCprescaler",
            .Nodetype = ADCprescalerval,
            .parents = &[_]*const ClockNode{&APB2Prescaler},
        };
        const ADCoutputval = ClockNodeTypes{
            .output = .{ .max = 14000000, .min = 0 },
        };
        const ADCoutput: ClockNode = .{
            .name = "ADCoutput",
            .Nodetype = ADCoutputval,
            .parents = &[_]*const ClockNode{&ADCprescaler},
        };
        const PLLVCOMul2val = ClockNodeTypes{
            .mul = .{ .value = 2 },
        };
        const PLLVCOMul2: ClockNode = .{
            .name = "PLLVCOMul2",
            .Nodetype = PLLVCOMul2val,
            .parents = &[_]*const ClockNode{&PLLMUL},
        };
        const USBPrescalerval = ClockNodeTypes{ .div = .{
            .value = inner: {
                if (config.USBPrescaler) |val| {
                    break :inner val.get();
                } else {
                    break :inner 3;
                }
            },
        } };
        const USBPrescaler: ClockNode = .{
            .name = "USBPrescaler",
            .Nodetype = USBPrescalerval,
            .parents = &[_]*const ClockNode{&PLLVCOMul2},
        };
        const USBoutputval = ClockNodeTypes{
            .output = .{ .max = 48120000, .min = 47880000 },
        };
        const USBoutput: ClockNode = .{
            .name = "USBoutput",
            .Nodetype = USBoutputval,
            .parents = &[_]*const ClockNode{&USBPrescaler},
        };
        const HSE_Timoutval = ClockNodeTypes{
            .source = .{
                .value = if (config.HSE_Timout) |val| val.get() else 100,
                .limit = .{ .max = 4294967295, .min = 1 },
            },
        };
        const LSE_Timoutval = ClockNodeTypes{
            .source = .{
                .value = if (config.LSE_Timout) |val| val.get() else 5000,
                .limit = .{ .max = 4294967295, .min = 1 },
            },
        };
        const HSICalibrationValueval = ClockNodeTypes{
            .source = .{
                .value = if (config.HSICalibrationValue) |val| val.get() else 16,
                .limit = .{ .max = 31, .min = 0 },
            },
        };
        return .{
            .HSIRC = HSIRC,
            .FLITFCLKoutput = FLITFCLKoutput,
            .HSIDivPLL = HSIDivPLL,
            .LSIRC = LSIRC,
            .LSEOSC = LSEOSC,
            .HSEOSC = HSEOSC,
            .Prediv2 = Prediv2,
            .Prediv2output = Prediv2output,
            .PLL2Mul = PLL2Mul,
            .PLL2VCOMul2 = PLL2VCOMul2,
            .PLL2VCOoutput = PLL2VCOoutput,
            .PLL2CLKoutput = PLL2CLKoutput,
            .PLL3Mul = PLL3Mul,
            .PLL3VCOMul2 = PLL3VCOMul2,
            .PLL3VCOoutput = PLL3VCOoutput,
            .PLL3CLKoutput = PLL3CLKoutput,
            .SysClkSource = SysClkSource,
            .SysCLKOutput = SysCLKOutput,
            .I2S2Mult = I2S2Mult,
            .I2S2Output = I2S2Output,
            .I2S3Mult = I2S3Mult,
            .I2S3Output = I2S3Output,
            .HSERTCDevisor = HSERTCDevisor,
            .RTCClkSource = RTCClkSource,
            .RTCOutput = RTCOutput,
            .IWDGOutput = IWDGOutput,
            .MCOPLL3Div = MCOPLL3Div,
            .MCOMultDivisor = MCOMultDivisor,
            .MCOMult = MCOMult,
            .MCOoutput = MCOoutput,
            .AHBPrescaler = AHBPrescaler,
            .AHBOutput = AHBOutput,
            .HCLKOutput = HCLKOutput,
            .FCLKCortexOutput = FCLKCortexOutput,
            .TimSysPresc = TimSysPresc,
            .TimSysOutput = TimSysOutput,
            .APB1Prescaler = APB1Prescaler,
            .APB1Output = APB1Output,
            .TimPrescalerAPB1 = TimPrescalerAPB1,
            .TimPrescOut1 = TimPrescOut1,
            .APB2Prescaler = APB2Prescaler,
            .APB2Output = APB2Output,
            .TimPrescalerAPB2 = TimPrescalerAPB2,
            .TimPrescOut2 = TimPrescOut2,
            .ADCprescaler = ADCprescaler,
            .ADCoutput = ADCoutput,
            .Prediv1Source = Prediv1Source,
            .PreDiv1 = PreDiv1,
            .PLLSource = PLLSource,
            .VCO2output = VCO2output,
            .PLLMUL = PLLMUL,
            .PLLVCOMul2 = PLLVCOMul2,
            .USBPrescaler = USBPrescaler,
            .USBoutput = USBoutput,
            .HSE_Timout = HSE_Timoutval,
            .LSE_Timout = LSE_Timoutval,
            .HSICalibrationValue = HSICalibrationValueval,
        };
    }

    pub fn validate(comptime self: *const this) void {
        _ = self.I2S2Output.get_comptime();
        _ = self.I2S3Output.get_comptime();
        _ = self.AHBOutput.get_comptime();
        _ = self.HCLKOutput.get_comptime();
        _ = self.FCLKCortexOutput.get_comptime();
        _ = self.TimSysOutput.get_comptime();
        _ = self.APB1Output.get_comptime();
        _ = self.TimPrescOut1.get_comptime();
        _ = self.APB2Output.get_comptime();
        _ = self.TimPrescOut2.get_comptime();
        _ = self.ADCoutput.get_comptime();
        _ = self.USBoutput.get_comptime();
    }
};
