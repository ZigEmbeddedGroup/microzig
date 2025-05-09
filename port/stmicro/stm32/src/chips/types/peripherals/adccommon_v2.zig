const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADCPRE = enum(u2) {
    /// PCLK2 divided by 2
    Div2 = 0x0,
    /// PCLK2 divided by 4
    Div4 = 0x1,
    /// PCLK2 divided by 6
    Div6 = 0x2,
    /// PCLK2 divided by 8
    Div8 = 0x3,
};

pub const DDS = enum(u1) {
    /// No new DMA request is issued after the last transfer
    Single = 0x0,
    /// DMA requests are issued as long as data are converted and DMA=01, 10 or 11
    Continuous = 0x1,
};

pub const DMA = enum(u2) {
    /// DMA mode disabled
    Disabled = 0x0,
    /// DMA mode 1 enabled (2 / 3 half-words one by one - 1 then 2 then 3)
    Mode1 = 0x1,
    /// DMA mode 2 enabled (2 / 3 half-words by pairs - 2&1 then 1&3 then 3&2)
    Mode2 = 0x2,
    /// DMA mode 3 enabled (2 / 3 half-words by pairs - 2&1 then 1&3 then 3&2)
    Mode3 = 0x3,
};

pub const MULTI = enum(u5) {
    /// All the ADCs independent: independent mode
    Independent = 0x0,
    /// Dual ADC1 and ADC2, combined regular and injected simultaneous mode
    DualRJ = 0x1,
    /// Dual ADC1 and ADC2, combined regular and alternate trigger mode
    DualRA = 0x2,
    /// Dual ADC1 and ADC2, injected simultaneous mode only
    DualJ = 0x5,
    /// Dual ADC1 and ADC2, regular simultaneous mode only
    DualR = 0x6,
    /// Dual ADC1 and ADC2, interleaved mode only
    DualI = 0x7,
    /// Dual ADC1 and ADC2, alternate trigger mode only
    DualA = 0x9,
    /// Triple ADC, regular and injected simultaneous mode
    TripleRJ = 0x11,
    /// Triple ADC, regular and alternate trigger mode
    TripleRA = 0x12,
    /// Triple ADC, injected simultaneous mode only
    TripleJ = 0x15,
    /// Triple ADC, regular simultaneous mode only
    TripleR = 0x16,
    /// Triple ADC, interleaved mode only
    TripleI = 0x17,
    /// Triple ADC, alternate trigger mode only
    TripleA = 0x18,
    _,
};

/// ADC common registers
pub const ADC_COMMON = extern struct {
    /// ADC Common status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of AWD) Analog watchdog event occurred
        @"AWD[0]": u1,
        /// (1/3 of EOC) End of conversion of ADC
        @"EOC[0]": u1,
        /// (1/3 of JEOC) Injected channel end of conversion of ADC
        @"JEOC[0]": u1,
        /// (1/3 of JSTRT) Injected channel conversion started
        @"JSTRT[0]": u1,
        /// (1/3 of STRT) regular channel conversion started
        @"STRT[0]": u1,
        /// (1/3 of OVR) Overrun occurred
        @"OVR[0]": u1,
        reserved8: u2 = 0,
        /// (2/3 of AWD) Analog watchdog event occurred
        @"AWD[1]": u1,
        /// (2/3 of EOC) End of conversion of ADC
        @"EOC[1]": u1,
        /// (2/3 of JEOC) Injected channel end of conversion of ADC
        @"JEOC[1]": u1,
        /// (2/3 of JSTRT) Injected channel conversion started
        @"JSTRT[1]": u1,
        /// (2/3 of STRT) regular channel conversion started
        @"STRT[1]": u1,
        /// (2/3 of OVR) Overrun occurred
        @"OVR[1]": u1,
        reserved16: u2 = 0,
        /// (3/3 of AWD) Analog watchdog event occurred
        @"AWD[2]": u1,
        /// (3/3 of EOC) End of conversion of ADC
        @"EOC[2]": u1,
        /// (3/3 of JEOC) Injected channel end of conversion of ADC
        @"JEOC[2]": u1,
        /// (3/3 of JSTRT) Injected channel conversion started
        @"JSTRT[2]": u1,
        /// (3/3 of STRT) regular channel conversion started
        @"STRT[2]": u1,
        /// (3/3 of OVR) Overrun occurred
        @"OVR[2]": u1,
        padding: u10 = 0,
    }),
    /// ADC common control register
    /// offset: 0x04
    CCR: mmio.Mmio(packed struct(u32) {
        /// Multi ADC mode selection
        MULTI: MULTI,
        reserved8: u3 = 0,
        /// Delay between 2 sampling phases
        DELAY: u4,
        reserved13: u1 = 0,
        /// DMA disable selection for multi-ADC mode
        DDS: DDS,
        /// Direct memory access mode for multi ADC mode
        DMA: DMA,
        /// ADC prescaler
        ADCPRE: ADCPRE,
        reserved22: u4 = 0,
        /// VBAT enable
        VBATE: u1,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1,
        padding: u8 = 0,
    }),
    /// ADC common regular data register for dual and triple modes
    /// offset: 0x08
    CDR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of DATA) 1st data item of a pair of regular conversions
        @"DATA[0]": u16,
        /// (2/2 of DATA) 1st data item of a pair of regular conversions
        @"DATA[1]": u16,
    }),
};
