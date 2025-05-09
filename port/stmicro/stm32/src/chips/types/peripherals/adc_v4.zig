const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCALDIF = enum(u1) {
    /// Calibration for single-ended mode
    SingleEnded = 0x0,
    /// Calibration for differential mode
    Differential = 0x1,
};

pub const ADSTP = enum(u1) {
    /// Stop conversion of channel
    Stop = 0x1,
    _,
};

pub const AWD1SGL = enum(u1) {
    /// Analog watchdog 1 enabled on all channels
    All = 0x0,
    /// Analog watchdog 1 enabled on single channel selected in AWD1CH
    Single = 0x1,
};

pub const BOOST = enum(u2) {
    /// Boost mode used when clock ≤ 6.25 MHz
    LT6_25 = 0x0,
    /// Boost mode used when 6.25 MHz < clock ≤ 12.5 MHz
    LT12_5 = 0x1,
    /// Boost mode used when 12.5 MHz < clock ≤ 25.0 MHz
    LT25 = 0x2,
    /// Boost mode used when 25.0 MHz < clock ≤ 50.0 MHz
    LT50 = 0x3,
};

pub const DIFSEL = enum(u1) {
    /// Input channel is configured in single-ended mode
    SingleEnded = 0x0,
    /// Input channel is configured in differential mode
    Differential = 0x1,
};

pub const DMNGT = enum(u2) {
    /// Store output data in DR only
    DR = 0x0,
    /// DMA One Shot Mode selected
    DMA_OneShot = 0x1,
    /// DFSDM mode selected
    DFSDM = 0x2,
    /// DMA Circular Mode selected
    DMA_Circular = 0x3,
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

pub const JQM = enum(u1) {
    /// JSQR Mode 0: Queue maintains the last written configuration into JSQR
    Mode0 = 0x0,
    /// JSQR Mode 1: An empty queue disables software and hardware triggers of the injected sequence
    Mode1 = 0x1,
};

pub const OVRMOD = enum(u1) {
    /// Preserve DR register when an overrun is detected
    Preserve = 0x0,
    /// Overwrite DR register when an overrun is detected
    Overwrite = 0x1,
};

pub const PCSEL = enum(u1) {
    /// Input channel x is not pre-selected
    NotPreselected = 0x0,
    /// Pre-select input channel x
    Preselected = 0x1,
};

pub const RES = enum(u3) {
    /// 16-bit resolution
    Bits16 = 0x0,
    /// 14-bit resolution in legacy mode (not optimized power consumption)
    Bits14 = 0x1,
    /// 12-bit resolution in legacy mode (not optimized power consumption)
    Bits12 = 0x2,
    /// 10-bit resolution
    Bits10 = 0x3,
    /// 14-bit resolution
    Bits14V = 0x5,
    /// 12-bit resolution
    Bits12V = 0x6,
    /// 8-bit resolution
    Bits8 = 0x7,
    _,
};

pub const ROVSM = enum(u1) {
    /// Oversampling is temporary stopped and continued after injection sequence
    Continued = 0x0,
    /// Oversampling is aborted and resumed from start after injection sequence
    Resumed = 0x1,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 1.5 clock cycles
    Cycles1_5 = 0x0,
    /// 2.5 clock cycles
    Cycles2_5 = 0x1,
    /// 8.5 clock cycles
    Cycles8_5 = 0x2,
    /// 16.5 clock cycles
    Cycles16_5 = 0x3,
    /// 32.5 clock cycles
    Cycles32_5 = 0x4,
    /// 64.5 clock cycles
    Cycles64_5 = 0x5,
    /// 387.5 clock cycles
    Cycles387_5 = 0x6,
    /// 810.5 clock cycles
    Cycles810_5 = 0x7,
};

pub const TROVS = enum(u1) {
    /// All oversampled conversions for a channel are run following a trigger
    Automatic = 0x0,
    /// Each oversampled conversion for a channel needs a new trigger
    Triggered = 0x1,
};

/// Analog to Digital Converter
pub const ADC = extern struct {
    /// interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ready flag
        ADRDY: u1,
        /// group regular end of sampling flag
        EOSMP: u1,
        /// group regular end of unitary conversion flag
        EOC: u1,
        /// group regular end of sequence conversions flag
        EOS: u1,
        /// group regular overrun flag
        OVR: u1,
        /// group injected end of unitary conversion flag
        JEOC: u1,
        /// group injected end of sequence conversions flag
        JEOS: u1,
        /// analog watchdog 1 flag
        AWD1: u1,
        /// analog watchdog 2 flag
        AWD2: u1,
        /// analog watchdog 3 flag
        AWD3: u1,
        /// group injected contexts queue overflow flag
        JQOVF: u1,
        reserved12: u1 = 0,
        /// ADC LDO output voltage ready (not always available)
        LDORDY: u1,
        padding: u19 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ready interrupt
        ADRDYIE: u1,
        /// group regular end of sampling interrupt
        EOSMPIE: u1,
        /// group regular end of unitary conversion interrupt
        EOCIE: u1,
        /// group regular end of sequence conversions interrupt
        EOSIE: u1,
        /// group regular overrun interrupt
        OVRIE: u1,
        /// group injected end of unitary conversion interrupt
        JEOCIE: u1,
        /// group injected end of sequence conversions interrupt
        JEOSIE: u1,
        /// analog watchdog 1 interrupt
        AWD1IE: u1,
        /// analog watchdog 2 interrupt
        AWD2IE: u1,
        /// analog watchdog 3 interrupt
        AWD3IE: u1,
        /// group injected contexts queue overflow interrupt
        JQOVFIE: u1,
        padding: u21 = 0,
    }),
    /// control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// enable
        ADEN: u1,
        /// disable
        ADDIS: u1,
        /// group regular conversion start
        ADSTART: u1,
        /// group injected conversion start
        JADSTART: u1,
        /// group regular conversion stop
        ADSTP: ADSTP,
        /// group injected conversion stop
        JADSTP: ADSTP,
        reserved8: u2 = 0,
        /// Boost mode control
        BOOST: BOOST,
        reserved16: u6 = 0,
        /// Linearity calibration
        ADCALLIN: u1,
        reserved22: u5 = 0,
        /// Linearity calibration ready Word 1
        LINCALRDYW1: u1,
        /// Linearity calibration ready Word 2
        LINCALRDYW2: u1,
        /// Linearity calibration ready Word 3
        LINCALRDYW3: u1,
        /// Linearity calibration ready Word 4
        LINCALRDYW4: u1,
        /// Linearity calibration ready Word 5
        LINCALRDYW5: u1,
        /// Linearity calibration ready Word 6
        LINCALRDYW6: u1,
        /// voltage regulator enable
        ADVREGEN: u1,
        /// deep power down enable
        DEEPPWD: u1,
        /// differential mode for calibration
        ADCALDIF: ADCALDIF,
        /// calibration
        ADCAL: u1,
    }),
    /// configuration register 1
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// DMA transfer enable
        DMNGT: DMNGT,
        /// data resolution
        RES: RES,
        /// group regular external trigger source
        EXTSEL: u5,
        /// group regular external trigger polarity
        EXTEN: EXTEN,
        /// group regular overrun configuration
        OVRMOD: OVRMOD,
        /// Continuous conversion
        CONT: u1,
        /// low power auto wait
        AUTDLY: u1,
        reserved16: u1 = 0,
        /// group regular sequencer discontinuous mode
        DISCEN: u1,
        /// group regular sequencer discontinuous number of ranks
        DISCNUM: u3,
        /// group injected sequencer discontinuous mode
        JDISCEN: u1,
        /// group injected contexts queue mode
        JQM: JQM,
        /// analog watchdog 1 monitoring a single channel or all channels
        AWD1SGL: AWD1SGL,
        /// analog watchdog 1 enable on scope group regular
        AWD1EN: u1,
        /// analog watchdog 1 enable on scope group injected
        JAWD1EN: u1,
        /// group injected automatic trigger mode
        JAUTO: u1,
        /// analog watchdog 1 monitored channel selection
        AWD1CH: u5,
        /// group injected contexts queue disable
        JQDIS: u1,
    }),
    /// configuration register 2
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// oversampler enable on scope group regular
        ROVSE: u1,
        /// oversampler enable on scope group injected
        JOVSE: u1,
        reserved5: u3 = 0,
        /// oversampling shift
        OVSS: u4,
        /// oversampling discontinuous mode (triggered mode) for group regular
        TROVS: TROVS,
        /// Regular Oversampling mode
        ROVSM: ROVSM,
        /// Right-shift data after Offset 1 correction
        RSHIFT1: u1,
        /// Right-shift data after Offset 2 correction
        RSHIFT2: u1,
        /// Right-shift data after Offset 3 correction
        RSHIFT3: u1,
        /// Right-shift data after Offset 4 correction
        RSHIFT4: u1,
        reserved16: u1 = 0,
        /// Oversampling ratio
        OSVR: u10,
        reserved28: u2 = 0,
        /// Left shift factor
        LSHIFT: u4,
    }),
    /// sampling time register 1-2
    /// offset: 0x14
    SMPR: [2]mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) channel n * 10 + x sampling time
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) channel n * 10 + x sampling time
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) channel n * 10 + x sampling time
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) channel n * 10 + x sampling time
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) channel n * 10 + x sampling time
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) channel n * 10 + x sampling time
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) channel n * 10 + x sampling time
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) channel n * 10 + x sampling time
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) channel n * 10 + x sampling time
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) channel n * 10 + x sampling time
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// pre channel selection register
    /// offset: 0x1c
    PCSEL: mmio.Mmio(packed struct(u32) {
        /// (1/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[0]": PCSEL,
        /// (2/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[1]": PCSEL,
        /// (3/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[2]": PCSEL,
        /// (4/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[3]": PCSEL,
        /// (5/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[4]": PCSEL,
        /// (6/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[5]": PCSEL,
        /// (7/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[6]": PCSEL,
        /// (8/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[7]": PCSEL,
        /// (9/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[8]": PCSEL,
        /// (10/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[9]": PCSEL,
        /// (11/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[10]": PCSEL,
        /// (12/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[11]": PCSEL,
        /// (13/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[12]": PCSEL,
        /// (14/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[13]": PCSEL,
        /// (15/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[14]": PCSEL,
        /// (16/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[15]": PCSEL,
        /// (17/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[16]": PCSEL,
        /// (18/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[17]": PCSEL,
        /// (19/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[18]": PCSEL,
        /// (20/20 of PCSEL) Channel x (VINP[i]) pre selection
        @"PCSEL[19]": PCSEL,
        padding: u12 = 0,
    }),
    /// analog watchdog 1 threshold register
    /// offset: 0x20
    LTR1: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 1 threshold low
        LTR1: u26,
        padding: u6 = 0,
    }),
    /// analog watchdog 2 threshold register
    /// offset: 0x24
    HTR1: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 2 threshold low
        HTR1: u26,
        padding: u6 = 0,
    }),
    /// offset: 0x28
    reserved40: [8]u8,
    /// group regular sequencer ranks register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// L3
        L: u4,
        reserved6: u2 = 0,
        /// (1/4 of SQ) group regular sequencer rank 1-4
        @"SQ[0]": u5,
        reserved12: u1 = 0,
        /// (2/4 of SQ) group regular sequencer rank 1-4
        @"SQ[1]": u5,
        reserved18: u1 = 0,
        /// (3/4 of SQ) group regular sequencer rank 1-4
        @"SQ[2]": u5,
        reserved24: u1 = 0,
        /// (4/4 of SQ) group regular sequencer rank 1-4
        @"SQ[3]": u5,
        padding: u3 = 0,
    }),
    /// group regular sequencer ranks register 2
    /// offset: 0x34
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) group regular sequencer rank 5-9
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) group regular sequencer rank 5-9
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) group regular sequencer rank 5-9
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) group regular sequencer rank 5-9
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) group regular sequencer rank 5-9
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// group regular sequencer ranks register 3
    /// offset: 0x38
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) group regular sequencer rank 10-14
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) group regular sequencer rank 10-14
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) group regular sequencer rank 10-14
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) group regular sequencer rank 10-14
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) group regular sequencer rank 10-14
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// group regular sequencer ranks register 4
    /// offset: 0x3c
    SQR4: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SQ) group regular sequencer rank 15-16
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/2 of SQ) group regular sequencer rank 15-16
        @"SQ[1]": u5,
        padding: u21 = 0,
    }),
    /// group regular conversion data register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// group regular conversion data
        RDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [8]u8,
    /// group injected sequencer register
    /// offset: 0x4c
    JSQR: mmio.Mmio(packed struct(u32) {
        /// group injected sequencer scan length
        JL: u2,
        /// group injected external trigger source
        JEXTSEL: u5,
        /// group injected external trigger polarity
        JEXTEN: JEXTEN,
        /// (1/4 of JSQ1) group injected sequencer rank 1-4
        @"JSQ1[0]": u5,
        reserved15: u1 = 0,
        /// (2/4 of JSQ1) group injected sequencer rank 1-4
        @"JSQ1[1]": u5,
        reserved21: u1 = 0,
        /// (3/4 of JSQ1) group injected sequencer rank 1-4
        @"JSQ1[2]": u5,
        reserved27: u1 = 0,
        /// (4/4 of JSQ1) group injected sequencer rank 1-4
        @"JSQ1[3]": u5,
    }),
    /// offset: 0x50
    reserved80: [16]u8,
    /// offset number 1-4 register
    /// offset: 0x60
    OFR: [4]mmio.Mmio(packed struct(u32) {
        /// offset number x offset level
        OFFSET1: u26,
        /// offset number x channel selection
        OFFSET1_CH: u5,
        /// Signed saturation enable
        SSATE: u1,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// group injected sequencer rank 1-4 register
    /// offset: 0x80
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// group injected sequencer rank 1 conversion data
        JDATA: u32,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// analog watchdog 2 configuration register
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        /// (1/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[0]": u1,
        /// (2/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[1]": u1,
        /// (3/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[2]": u1,
        /// (4/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[3]": u1,
        /// (5/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[4]": u1,
        /// (6/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[5]": u1,
        /// (7/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[6]": u1,
        /// (8/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[7]": u1,
        /// (9/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[8]": u1,
        /// (10/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[9]": u1,
        /// (11/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[10]": u1,
        /// (12/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[11]": u1,
        /// (13/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[12]": u1,
        /// (14/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[13]": u1,
        /// (15/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[14]": u1,
        /// (16/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[15]": u1,
        /// (17/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[16]": u1,
        /// (18/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[17]": u1,
        /// (19/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[18]": u1,
        /// (20/20 of AWD2CH) analog watchdog 2 monitored channel selection
        @"AWD2CH[19]": u1,
        padding: u12 = 0,
    }),
    /// analog watchdog 3 configuration register
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// (1/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[0]": u1,
        /// (2/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[1]": u1,
        /// (3/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[2]": u1,
        /// (4/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[3]": u1,
        /// (5/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[4]": u1,
        /// (6/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[5]": u1,
        /// (7/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[6]": u1,
        /// (8/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[7]": u1,
        /// (9/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[8]": u1,
        /// (10/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[9]": u1,
        /// (11/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[10]": u1,
        /// (12/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[11]": u1,
        /// (13/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[12]": u1,
        /// (14/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[13]": u1,
        /// (15/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[14]": u1,
        /// (16/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[15]": u1,
        /// (17/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[16]": u1,
        /// (18/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[17]": u1,
        /// (19/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[18]": u1,
        /// (20/20 of AWD3CH) analog watchdog 3 monitored channel selection
        @"AWD3CH[19]": u1,
        padding: u11 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// watchdog lower threshold register 2
    /// offset: 0xb0
    LTR2: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 2 lower threshold
        LTR2: u26,
        padding: u6 = 0,
    }),
    /// watchdog higher threshold register 2
    /// offset: 0xb4
    HTR2: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 2 higher threshold
        HTR2: u26,
        padding: u6 = 0,
    }),
    /// watchdog lower threshold register 3
    /// offset: 0xb8
    LTR3: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 3 lower threshold
        LTR3: u26,
        padding: u6 = 0,
    }),
    /// watchdog higher threshold register 3
    /// offset: 0xbc
    HTR3: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 3 higher threshold
        HTR3: u26,
        padding: u6 = 0,
    }),
    /// channel differential or single-ended mode selection register
    /// offset: 0xc0
    DIFSEL: mmio.Mmio(packed struct(u32) {
        /// (1/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[0]": DIFSEL,
        /// (2/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[1]": DIFSEL,
        /// (3/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[2]": DIFSEL,
        /// (4/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[3]": DIFSEL,
        /// (5/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[4]": DIFSEL,
        /// (6/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[5]": DIFSEL,
        /// (7/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[6]": DIFSEL,
        /// (8/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[7]": DIFSEL,
        /// (9/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[8]": DIFSEL,
        /// (10/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[9]": DIFSEL,
        /// (11/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[10]": DIFSEL,
        /// (12/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[11]": DIFSEL,
        /// (13/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[12]": DIFSEL,
        /// (14/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[13]": DIFSEL,
        /// (15/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[14]": DIFSEL,
        /// (16/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[15]": DIFSEL,
        /// (17/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[16]": DIFSEL,
        /// (18/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[17]": DIFSEL,
        /// (19/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[18]": DIFSEL,
        /// (20/20 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[19]": DIFSEL,
        padding: u12 = 0,
    }),
    /// calibration factors register
    /// offset: 0xc4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// calibration factor in single-ended mode
        CALFACT_S: u11,
        reserved16: u5 = 0,
        /// calibration factor in differential mode
        CALFACT_D: u11,
        padding: u5 = 0,
    }),
    /// Calibration Factor register 2
    /// offset: 0xc8
    CALFACT2: mmio.Mmio(packed struct(u32) {
        /// Linearity Calibration Factor
        LINCALFACT: u30,
        padding: u2 = 0,
    }),
};
