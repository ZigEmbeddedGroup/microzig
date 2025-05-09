const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DUALMOD = enum(u4) {
    /// Independent mode.
    Independent = 0x0,
    /// Combined regular simultaneous + injected simultaneous mode
    RegularInjected = 0x1,
    /// Combined regular simultaneous + alternate trigger mode
    RegularAlternateTrigger = 0x2,
    /// Combined injected simultaneous + fast interleaved mode
    InjectedFastInterleaved = 0x3,
    /// Combined injected simultaneous + slow Interleaved mode
    InjectedSlowInterleaved = 0x4,
    /// Injected simultaneous mode only
    Injected = 0x5,
    /// Regular simultaneous mode only
    Regular = 0x6,
    /// Fast interleaved mode only
    FastInterleaved = 0x7,
    /// Slow interleaved mode only
    SlowInterleaved = 0x8,
    /// Alternate trigger mode only
    AlternateTrigger = 0x9,
    _,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 1.5 cycles
    Cycles1_5 = 0x0,
    /// 7.5 cycles
    Cycles7_5 = 0x1,
    /// 13.5 cycles
    Cycles13_5 = 0x2,
    /// 28.5 cycles
    Cycles28_5 = 0x3,
    /// 41.5 cycles
    Cycles41_5 = 0x4,
    /// 55.5 cycles
    Cycles55_5 = 0x5,
    /// 71.5 cycles
    Cycles71_5 = 0x6,
    /// 239.5 cycles
    Cycles239_5 = 0x7,
};

/// Analog-to-digital converter
pub const ADC = extern struct {
    /// status register
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog flag
        AWD: u1,
        /// Regular channel end of conversion
        EOC: u1,
        /// Injected channel end of conversion
        JEOC: u1,
        /// Injected channel start flag
        JSTRT: u1,
        /// Regular channel start flag
        STRT: u1,
        padding: u27 = 0,
    }),
    /// control register 1
    /// offset: 0x04
    CR1: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog channel select bits
        AWDCH: u5,
        /// Interrupt enable for EOC
        EOCIE: u1,
        /// Analog watchdog interrupt enable
        AWDIE: u1,
        /// Interrupt enable for injected channels
        JEOCIE: u1,
        /// Scan mode
        SCAN: u1,
        /// Enable the watchdog on a single channel in scan mode
        AWDSGL: u1,
        /// Automatic injected group conversion
        JAUTO: u1,
        /// Discontinuous mode on regular channels
        DISCEN: u1,
        /// Discontinuous mode on injected channels
        JDISCEN: u1,
        /// Discontinuous mode channel count
        DISCNUM: u3,
        /// Dual mode selection
        DUALMOD: DUALMOD,
        reserved22: u2 = 0,
        /// Analog watchdog enable on injected channels
        JAWDEN: u1,
        /// Analog watchdog enable on regular channels
        AWDEN: u1,
        padding: u8 = 0,
    }),
    /// control register 2
    /// offset: 0x08
    CR2: mmio.Mmio(packed struct(u32) {
        /// A/D Converter ON / OFF
        ADON: u1,
        /// Continuous conversion
        CONT: u1,
        /// A/D Calibration
        CAL: u1,
        /// Reset calibration
        RSTCAL: u1,
        reserved8: u4 = 0,
        /// Direct memory access mode (for single ADC mode)
        DMA: u1,
        reserved11: u2 = 0,
        /// Data alignment
        ALIGN: u1,
        /// External event select for injected group
        JEXTSEL: u3,
        /// External trigger conversion mode for injected channels
        JEXTTRIG: u1,
        reserved17: u1 = 0,
        /// External event select for regular group
        EXTSEL: u3,
        /// External trigger conversion mode for regular channels
        EXTTRIG: u1,
        /// Start conversion of injected channels
        JSWSTART: u1,
        /// Start conversion of regular channels
        SWSTART: u1,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1,
        padding: u8 = 0,
    }),
    /// sample time register 1
    /// offset: 0x0c
    SMPR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of SMP) Channel x sample time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/8 of SMP) Channel x sample time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/8 of SMP) Channel x sample time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/8 of SMP) Channel x sample time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/8 of SMP) Channel x sample time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/8 of SMP) Channel x sample time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/8 of SMP) Channel x sample time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/8 of SMP) Channel x sample time selection
        @"SMP[7]": SAMPLE_TIME,
        padding: u8 = 0,
    }),
    /// sample time register 2
    /// offset: 0x10
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) Channel 0 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) Channel 0 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) Channel 0 sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) Channel 0 sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) Channel 0 sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) Channel 0 sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) Channel 0 sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) Channel 0 sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) Channel 0 sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) Channel 0 sampling time selection
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// injected channel data offset register x
    /// offset: 0x14
    JOFR: [4]mmio.Mmio(packed struct(u32) {
        /// Data offset for injected channel x
        JOFFSET: u12,
        padding: u20 = 0,
    }),
    /// watchdog higher threshold register
    /// offset: 0x24
    HTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog higher threshold
        HT: u12,
        padding: u20 = 0,
    }),
    /// watchdog lower threshold register
    /// offset: 0x28
    LTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog lower threshold
        LT: u12,
        padding: u20 = 0,
    }),
    /// regular sequence register 1
    /// offset: 0x2c
    SQR1: mmio.Mmio(packed struct(u32) {
        /// (1/4 of SQ) 13th to 16th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/4 of SQ) 13th to 16th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/4 of SQ) 13th to 16th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/4 of SQ) 13th to 16th conversion in regular sequence
        @"SQ[3]": u5,
        /// Regular channel sequence length
        L: u4,
        padding: u8 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x30
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 7th to 12th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x34
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 1st to 6th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// injected sequence register
    /// offset: 0x38
    JSQR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of JSQ) 1st conversion in injected sequence
        @"JSQ[0]": u5,
        /// (2/4 of JSQ) 1st conversion in injected sequence
        @"JSQ[1]": u5,
        /// (3/4 of JSQ) 1st conversion in injected sequence
        @"JSQ[2]": u5,
        /// (4/4 of JSQ) 1st conversion in injected sequence
        @"JSQ[3]": u5,
        /// Injected sequence length
        JL: u2,
        padding: u10 = 0,
    }),
    /// injected data register x
    /// offset: 0x3c
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// regular data register
    /// offset: 0x4c
    DR: mmio.Mmio(packed struct(u32) {
        /// Regular data
        DATA: u16,
        /// ADC2 data
        ADC2DATA: u16,
    }),
};
