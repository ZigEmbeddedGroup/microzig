const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ALIGN = enum(u1) {
    /// Right alignment
    Right = 0x0,
    /// Left alignment
    Left = 0x1,
};

pub const AWDSGL = enum(u1) {
    /// Analog watchdog enabled on all channels
    AllChannels = 0x0,
    /// Analog watchdog enabled on a single channel
    SingleChannel = 0x1,
};

pub const DDS = enum(u1) {
    /// No new DMA request is issued after the last transfer
    Single = 0x0,
    /// DMA requests are issued as long as data are converted and DMA=1
    Continuous = 0x1,
};

pub const EOCS = enum(u1) {
    /// The EOC bit is set at the end of each sequence of regular conversions
    EachSequence = 0x0,
    /// The EOC bit is set at the end of each regular conversion
    EachConversion = 0x1,
};

pub const EXTEN = enum(u2) {
    /// Trigger detection disabled
    Disabled = 0x0,
    /// Trigger detection on the rising edge
    RisingEdge = 0x1,
    /// Trigger detection on the falling edge
    FallingEdge = 0x2,
    /// Trigger detection on both the rising and falling edges
    BothEdges = 0x3,
};

pub const JEXTEN = enum(u2) {
    /// Trigger detection disabled
    Disabled = 0x0,
    /// Trigger detection on the rising edge
    RisingEdge = 0x1,
    /// Trigger detection on the falling edge
    FallingEdge = 0x2,
    /// Trigger detection on both the rising and falling edges
    BothEdges = 0x3,
};

pub const RES = enum(u2) {
    /// 12-bit (15 ADCCLK cycles)
    Bits12 = 0x0,
    /// 10-bit (13 ADCCLK cycles)
    Bits10 = 0x1,
    /// 8-bit (11 ADCCLK cycles)
    Bits8 = 0x2,
    /// 6-bit (9 ADCCLK cycles)
    Bits6 = 0x3,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 3 cycles
    Cycles3 = 0x0,
    /// 15 cycles
    Cycles15 = 0x1,
    /// 28 cycles
    Cycles28 = 0x2,
    /// 56 cycles
    Cycles56 = 0x3,
    /// 84 cycles
    Cycles84 = 0x4,
    /// 112 cycles
    Cycles112 = 0x5,
    /// 144 cycles
    Cycles144 = 0x6,
    /// 480 cycles
    Cycles480 = 0x7,
};

pub const SMPR_SMPx_x = enum(u32) {
    /// 3 cycles
    Cycles3 = 0x0,
    /// 15 cycles
    Cycles15 = 0x1,
    /// 28 cycles
    Cycles28 = 0x2,
    /// 56 cycles
    Cycles56 = 0x3,
    /// 84 cycles
    Cycles84 = 0x4,
    /// 112 cycles
    Cycles112 = 0x5,
    /// 144 cycles
    Cycles144 = 0x6,
    /// 480 cycles
    Cycles480 = 0x7,
    _,
};

/// Analog-to-digital converter
pub const ADC = extern struct {
    /// status register
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog event occurred
        AWD: u1,
        /// Regular channel end of conversion
        EOC: u1,
        /// Injected channel end of conversion
        JEOC: u1,
        /// Injected channel conversion has started
        JSTRT: u1,
        /// Regular channel conversion has started
        STRT: u1,
        /// Overrun occurred
        OVR: u1,
        padding: u26 = 0,
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
        AWDSGL: AWDSGL,
        /// Automatic injected group conversion
        JAUTO: u1,
        /// Discontinuous mode on regular channels
        DISCEN: u1,
        /// Discontinuous mode on injected channels
        JDISCEN: u1,
        /// Discontinuous mode channel count
        DISCNUM: u3,
        reserved22: u6 = 0,
        /// Analog watchdog enable on injected channels
        JAWDEN: u1,
        /// Analog watchdog enable on regular channels
        AWDEN: u1,
        /// Resolution
        RES: RES,
        /// Overrun interrupt enable
        OVRIE: u1,
        padding: u5 = 0,
    }),
    /// control register 2
    /// offset: 0x08
    CR2: mmio.Mmio(packed struct(u32) {
        /// A/D Converter ON / OFF
        ADON: u1,
        /// Continuous conversion
        CONT: u1,
        reserved8: u6 = 0,
        /// Direct memory access mode (for single ADC mode)
        DMA: u1,
        /// DMA disable selection (for single ADC mode)
        DDS: DDS,
        /// End of conversion selection
        EOCS: EOCS,
        /// Data alignment
        ALIGN: ALIGN,
        reserved16: u4 = 0,
        /// External event select for injected group
        JEXTSEL: u4,
        /// External trigger enable for injected channels
        JEXTEN: JEXTEN,
        /// Start conversion of injected channels
        JSWSTART: u1,
        reserved24: u1 = 0,
        /// External event select for regular group
        EXTSEL: u4,
        /// External trigger enable for regular channels
        EXTEN: EXTEN,
        /// Start conversion of regular channels
        SWSTART: u1,
        padding: u1 = 0,
    }),
    /// sample time register 1
    /// offset: 0x0c
    SMPR1: mmio.Mmio(packed struct(u32) {
        /// (1/9 of SMP) Channel 10 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/9 of SMP) Channel 10 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/9 of SMP) Channel 10 sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/9 of SMP) Channel 10 sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/9 of SMP) Channel 10 sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/9 of SMP) Channel 10 sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/9 of SMP) Channel 10 sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/9 of SMP) Channel 10 sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/9 of SMP) Channel 10 sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        padding: u5 = 0,
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
        /// (1/4 of SQ) 13th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/4 of SQ) 13th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/4 of SQ) 13th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/4 of SQ) 13th conversion in regular sequence
        @"SQ[3]": u5,
        /// Regular channel sequence length
        L: u4,
        padding: u8 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x30
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 7th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 7th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 7th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 7th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 7th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 7th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x34
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 1st conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 1st conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 1st conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 1st conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 1st conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 1st conversion in regular sequence
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
        padding: u16 = 0,
    }),
};
