const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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

pub const DIFSEL = enum(u1) {
    /// Input channel is configured in single-ended mode
    SingleEnded = 0x0,
    /// Input channel is configured in differential mode
    Differential = 0x1,
};

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circular = 0x1,
};

pub const DMAEN = enum(u1) {
    /// DMA disable
    Disable = 0x0,
    /// DMA enable
    Enable = 0x1,
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

pub const RES = enum(u2) {
    /// 12-bit resolution
    Bits12 = 0x0,
    /// 10-bit resolution
    Bits10 = 0x1,
    /// 8-bit resolution
    Bits8 = 0x2,
    /// 6-bit resolution
    Bits6 = 0x3,
};

pub const ROVSM = enum(u1) {
    /// Oversampling is temporary stopped and continued after injection sequence
    Continued = 0x0,
    /// Oversampling is aborted and resumed from start after injection sequence
    Resumed = 0x1,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 2.5 clock cycles
    Cycles2_5 = 0x0,
    /// 6.5 clock cycles
    Cycles6_5 = 0x1,
    /// 12.5 clock cycles
    Cycles12_5 = 0x2,
    /// 24.5 clock cycles
    Cycles24_5 = 0x3,
    /// 47.5 clock cycles
    Cycles47_5 = 0x4,
    /// 92.5 clock cycles
    Cycles92_5 = 0x5,
    /// 247.5 clock cycles
    Cycles247_5 = 0x6,
    /// 640.5 clock cycles
    Cycles640_5 = 0x7,
};

pub const TROVS = enum(u1) {
    /// All oversampled conversions for a channel are done consecutively following a trigger
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
        padding: u21 = 0,
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
        reserved28: u22 = 0,
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
        /// Direct memory access configuration
        DMACFG: DMACFG,
        reserved3: u2 = 0,
        /// data resolution
        RES: RES,
        /// external trigger selection for regular group
        EXTSEL: u5,
        /// external trigger enable and polarity selection for regular channels
        EXTEN: EXTEN,
        /// overrun mode
        OVRMOD: OVRMOD,
        /// Continuous conversion
        CONT: u1,
        /// delayed conversion mode
        AUTDLY: u1,
        /// data alignment
        ALIGN: u1,
        /// discontinuous mode for regular channels
        DISCEN: u1,
        /// discontinuous mode channel count
        DISCNUM: u3,
        /// discontinuous mode on injected channels
        JDISCEN: u1,
        /// JSQR queue mode
        JQM: JQM,
        /// enable the watchdog 1 on a single channel or on all channels
        AWD1SGL: AWD1SGL,
        /// analog watchdog 1 enable on regular channels
        AWD1EN: u1,
        /// analog watchdog 1 enable on injected channels
        JAWD1EN: u1,
        /// automatic injected group conversion
        JAUTO: u1,
        /// analog watchdog 1 channel selection
        AWD1CH: u5,
        /// injected queue disable
        JQDIS: u1,
    }),
    /// configuration register 2
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Regular Oversampling Enable
        ROVSE: u1,
        /// Injected Oversampling Enable
        JOVSE: u1,
        /// Oversampling ratio
        OVSR: u3,
        /// Oversampling shift
        OVSS: u4,
        /// Triggered Regular Oversampling
        TROVS: TROVS,
        /// Regular Oversampling mode
        ROVSM: ROVSM,
        reserved16: u5 = 0,
        /// Gain compensation mode
        GCOMP: u1,
        reserved25: u8 = 0,
        /// Software trigger bit for sampling time control trigger mode
        SWTRIG: u1,
        /// Bulb sampling mode
        BULB: u1,
        /// Sampling time control trigger mode
        SMPTRIG: u1,
        padding: u4 = 0,
    }),
    /// sampling time register 1
    /// offset: 0x14
    SMPR: mmio.Mmio(packed struct(u32) {
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
        reserved31: u1 = 0,
        /// Addition of one clock cycle to the sampling time
        SMPPLUS: u1,
    }),
    /// sampling time register 2
    /// offset: 0x18
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// (1/9 of SMP) channel n * 10 + x sampling time
        @"SMP[0]": SAMPLE_TIME,
        /// (2/9 of SMP) channel n * 10 + x sampling time
        @"SMP[1]": SAMPLE_TIME,
        /// (3/9 of SMP) channel n * 10 + x sampling time
        @"SMP[2]": SAMPLE_TIME,
        /// (4/9 of SMP) channel n * 10 + x sampling time
        @"SMP[3]": SAMPLE_TIME,
        /// (5/9 of SMP) channel n * 10 + x sampling time
        @"SMP[4]": SAMPLE_TIME,
        /// (6/9 of SMP) channel n * 10 + x sampling time
        @"SMP[5]": SAMPLE_TIME,
        /// (7/9 of SMP) channel n * 10 + x sampling time
        @"SMP[6]": SAMPLE_TIME,
        /// (8/9 of SMP) channel n * 10 + x sampling time
        @"SMP[7]": SAMPLE_TIME,
        /// (9/9 of SMP) channel n * 10 + x sampling time
        @"SMP[8]": SAMPLE_TIME,
        padding: u5 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// analog watchdog threshold register 1
    /// offset: 0x20
    TR1: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 1 lower threshold
        LT1: u12,
        /// analog watchdog filtering parameter
        AWDFILT: u3,
        reserved16: u1 = 0,
        /// analog watchdog 1 higher threshold
        HT1: u12,
        padding: u4 = 0,
    }),
    /// analog watchdog threshold register 2
    /// offset: 0x24
    TR2: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 2 lower threshold
        LT2: u8,
        reserved16: u8 = 0,
        /// analog watchdog 2 higher threshold
        HT2: u8,
        padding: u8 = 0,
    }),
    /// analog watchdog threshold register 3
    /// offset: 0x28
    TR3: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 3 lower threshold
        LT3: u8,
        reserved16: u8 = 0,
        /// analog watchdog 3 higher threshold
        HT3: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// group regular sequencer ranks register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// L
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
        /// (1/4 of JSQ) group injected sequencer rank 1-4
        @"JSQ[0]": u5,
        reserved15: u1 = 0,
        /// (2/4 of JSQ) group injected sequencer rank 1-4
        @"JSQ[1]": u5,
        reserved21: u1 = 0,
        /// (3/4 of JSQ) group injected sequencer rank 1-4
        @"JSQ[2]": u5,
        reserved27: u1 = 0,
        /// (4/4 of JSQ) group injected sequencer rank 1-4
        @"JSQ[3]": u5,
    }),
    /// offset: 0x50
    reserved80: [16]u8,
    /// offset number 1-4 register
    /// offset: 0x60
    OFR: [4]mmio.Mmio(packed struct(u32) {
        /// data offset
        OFFSET: u12,
        reserved24: u12 = 0,
        /// Positive offset
        OFFSETPOS: u1,
        /// Saturation enable
        SATEN: u1,
        /// Channel selection for the data offset
        OFFSET1_CH: u5,
        /// Offset enable
        OFFSET_EN: u1,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// group injected sequencer rank 1-4 register
    /// offset: 0x80
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// group injected sequencer rank conversion data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// analog watchdog 2 configuration register
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 2 channel selection
        AWD2CH: u19,
        padding: u13 = 0,
    }),
    /// analog watchdog 3 configuration register
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        /// analog watchdog 3 channel selection
        AWD3CH: u19,
        padding: u13 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// channel differential or single-ended mode selection register
    /// offset: 0xb0
    DIFSEL: mmio.Mmio(packed struct(u32) {
        /// (1/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[0]": DIFSEL,
        /// (2/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[1]": DIFSEL,
        /// (3/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[2]": DIFSEL,
        /// (4/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[3]": DIFSEL,
        /// (5/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[4]": DIFSEL,
        /// (6/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[5]": DIFSEL,
        /// (7/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[6]": DIFSEL,
        /// (8/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[7]": DIFSEL,
        /// (9/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[8]": DIFSEL,
        /// (10/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[9]": DIFSEL,
        /// (11/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[10]": DIFSEL,
        /// (12/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[11]": DIFSEL,
        /// (13/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[12]": DIFSEL,
        /// (14/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[13]": DIFSEL,
        /// (15/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[14]": DIFSEL,
        /// (16/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[15]": DIFSEL,
        /// (17/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[16]": DIFSEL,
        /// (18/18 of DIFSEL) channel differential or single-ended mode for channel
        @"DIFSEL[17]": DIFSEL,
        padding: u14 = 0,
    }),
    /// calibration factors register
    /// offset: 0xb4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// calibration factor in single-ended mode
        CALFACT_S: u7,
        reserved16: u9 = 0,
        /// calibration factor in differential mode
        CALFACT_D: u7,
        padding: u9 = 0,
    }),
    /// offset: 0xb8
    reserved184: [8]u8,
    /// Gain compensation register
    /// offset: 0xc0
    GCOMP: mmio.Mmio(packed struct(u32) {
        /// Gain compensation coefficient
        GCOMPCOEFF: u14,
        padding: u18 = 0,
    }),
};
