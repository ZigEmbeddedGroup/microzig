const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADVREGEN = enum(u2) {
    /// Intermediate state required when moving the ADC voltage regulator between states
    Intermediate = 0x0,
    /// ADC voltage regulator enabled
    Enabled = 0x1,
    /// ADC voltage regulator disabled
    Disabled = 0x2,
    _,
};

pub const ALIGN = enum(u1) {
    /// Right alignment
    Right = 0x0,
    /// Left alignment
    Left = 0x1,
};

pub const AWD1SGL = enum(u1) {
    /// Analog watchdog 1 enabled on all channels
    All = 0x0,
    /// Analog watchdog 1 enabled on single channel selected in AWD1CH
    Single = 0x1,
};

pub const DIFSEL_10 = enum(u1) {
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

pub const SAMPLE_TIME = enum(u3) {
    /// 1.5 ADC clock cycles
    Cycles1_5 = 0x0,
    /// 2.5 ADC clock cycles
    Cycles2_5 = 0x1,
    /// 4.5 ADC clock cycles
    Cycles4_5 = 0x2,
    /// 7.5 ADC clock cycles
    Cycles7_5 = 0x3,
    /// 19.5 ADC clock cycles
    Cycles19_5 = 0x4,
    /// 61.5 ADC clock cycles
    Cycles61_5 = 0x5,
    /// 181.5 ADC clock cycles
    Cycles181_5 = 0x6,
    /// 601.5 ADC clock cycles
    Cycles601_5 = 0x7,
};

/// Analog-to-Digital Converter
pub const ADC = extern struct {
    /// interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ADC Ready
        ADRDY: u1,
        /// End of sampling flag
        EOSMP: u1,
        /// End of conversion flag
        EOC: u1,
        /// End of regular sequence flag
        EOS: u1,
        /// ADC overrun
        OVR: u1,
        /// Injected channel end of conversion flag
        JEOC: u1,
        /// Injected channel end of sequence flag
        JEOS: u1,
        /// (1/3 of AWD) Analog watchdog flag
        @"AWD[0]": u1,
        /// (2/3 of AWD) Analog watchdog flag
        @"AWD[1]": u1,
        /// (3/3 of AWD) Analog watchdog flag
        @"AWD[2]": u1,
        /// Injected context queue overflow
        JQOVF: u1,
        padding: u21 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADC ready interrupt enable
        ADRDYIE: u1,
        /// End of sampling flag interrupt enable for regular conversions
        EOSMPIE: u1,
        /// End of regular conversion interrupt enable
        EOCIE: u1,
        /// End of regular sequence of conversions interrupt enable
        EOSIE: u1,
        /// Overrun interrupt enable
        OVRIE: u1,
        /// End of injected conversion interrupt enable
        JEOCIE: u1,
        /// End of injected sequence of conversions interrupt enable
        JEOSIE: u1,
        /// (1/3 of AWDIE) Analog watchdog X interrupt enable
        @"AWDIE[0]": u1,
        /// (2/3 of AWDIE) Analog watchdog X interrupt enable
        @"AWDIE[1]": u1,
        /// (3/3 of AWDIE) Analog watchdog X interrupt enable
        @"AWDIE[2]": u1,
        /// Injected context queue overflow interrupt enable
        JQOVFIE: u1,
        padding: u21 = 0,
    }),
    /// control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADC enable control
        ADEN: u1,
        /// ADC disable command
        ADDIS: u1,
        /// ADC start of regular conversion
        ADSTART: u1,
        /// ADC start of injected conversion
        JADSTART: u1,
        /// ADC stop of regular conversion command
        ADSTP: u1,
        /// ADC stop of injected conversion command
        JADSTP: u1,
        reserved28: u22 = 0,
        /// ADC voltage regulator enable
        ADVREGEN: ADVREGEN,
        /// Differential mode for calibration
        ADCALDIF: u1,
        /// ADC calibration
        ADCAL: u1,
    }),
    /// configuration register
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// Direct memory access enable
        DMAEN: u1,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        reserved3: u1 = 0,
        /// Data resolution
        RES: RES,
        /// Data alignment
        ALIGN: ALIGN,
        /// External trigger selection for regular group
        EXTSEL: u4,
        /// External trigger enable and polarity selection for regular channels
        EXTEN: EXTEN,
        /// Overrun Mode
        OVRMOD: u1,
        /// Continuous conversion
        CONT: u1,
        /// Delayed conversion mode
        AUTDLY: u1,
        reserved16: u1 = 0,
        /// Discontinuous mode for regular channels
        DISCEN: u1,
        /// Discontinuous mode channel count
        DISCNUM: u3,
        /// Discontinuous mode on injected channels
        JDISCEN: u1,
        /// JSQR queue mode
        JQM: JQM,
        /// Enable the watchdog 1 on a single channel or on all channels
        AWD1SGL: AWD1SGL,
        /// Analog watchdog 1 enable on regular channels
        AWD1EN: u1,
        /// Analog watchdog 1 enable on injected channels
        JAWD1EN: u1,
        /// Automatic injected group conversion
        JAUTO: u1,
        /// Analog watchdog 1 channel selection
        AWD1CH: u5,
        padding: u1 = 0,
    }),
    /// offset: 0x10
    reserved16: [4]u8,
    /// sample time register 1
    /// offset: 0x14
    SMPR1: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// (1/9 of SMP) Channel x sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/9 of SMP) Channel x sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/9 of SMP) Channel x sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/9 of SMP) Channel x sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/9 of SMP) Channel x sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/9 of SMP) Channel x sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/9 of SMP) Channel x sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/9 of SMP) Channel x sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/9 of SMP) Channel x sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// sample time register 2
    /// offset: 0x18
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// (1/9 of SMP) Channel x sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/9 of SMP) Channel x sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/9 of SMP) Channel x sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/9 of SMP) Channel x sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/9 of SMP) Channel x sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/9 of SMP) Channel x sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/9 of SMP) Channel x sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/9 of SMP) Channel x sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/9 of SMP) Channel x sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        padding: u5 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// watchdog threshold register 1
    /// offset: 0x20
    TR1: mmio.Mmio(packed struct(u32) {
        /// LT1
        LT1: u12,
        reserved16: u4 = 0,
        /// HT1
        HT1: u12,
        padding: u4 = 0,
    }),
    /// watchdog threshold register
    /// offset: 0x24
    TR2: mmio.Mmio(packed struct(u32) {
        /// LT2
        LT2: u8,
        reserved16: u8 = 0,
        /// HT2
        HT2: u8,
        padding: u8 = 0,
    }),
    /// watchdog threshold register 3
    /// offset: 0x28
    TR3: mmio.Mmio(packed struct(u32) {
        /// LT3
        LT3: u8,
        reserved16: u8 = 0,
        /// HT3
        HT3: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// regular sequence register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// Regular channel sequence length
        L: u4,
        reserved6: u2 = 0,
        /// (1/4 of SQ) X conversion in regular sequence
        @"SQ[0]": u5,
        reserved12: u1 = 0,
        /// (2/4 of SQ) X conversion in regular sequence
        @"SQ[1]": u5,
        reserved18: u1 = 0,
        /// (3/4 of SQ) X conversion in regular sequence
        @"SQ[2]": u5,
        reserved24: u1 = 0,
        /// (4/4 of SQ) X conversion in regular sequence
        @"SQ[3]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x34
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) X conversion in regular sequence
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) X conversion in regular sequence
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) X conversion in regular sequence
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) X conversion in regular sequence
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) X conversion in regular sequence
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x38
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) X conversion in regular sequence
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) X conversion in regular sequence
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) X conversion in regular sequence
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) X conversion in regular sequence
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) X conversion in regular sequence
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 4
    /// offset: 0x3c
    SQR4: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SQ) X conversion in regular sequence
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/2 of SQ) X conversion in regular sequence
        @"SQ[1]": u5,
        padding: u21 = 0,
    }),
    /// regular Data Register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// Regular data
        RDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [8]u8,
    /// injected sequence register
    /// offset: 0x4c
    JSQR: mmio.Mmio(packed struct(u32) {
        /// Injected channel sequence length
        JL: u2,
        /// External Trigger Selection for injected group
        JEXTSEL: u4,
        /// External Trigger Enable and Polarity Selection for injected channels
        JEXTEN: JEXTEN,
        /// (1/4 of JSQ) X conversion in the injected sequence
        @"JSQ[0]": u5,
        reserved14: u1 = 0,
        /// (2/4 of JSQ) X conversion in the injected sequence
        @"JSQ[1]": u5,
        reserved20: u1 = 0,
        /// (3/4 of JSQ) X conversion in the injected sequence
        @"JSQ[2]": u5,
        reserved26: u1 = 0,
        /// (4/4 of JSQ) X conversion in the injected sequence
        @"JSQ[3]": u5,
        padding: u1 = 0,
    }),
    /// offset: 0x50
    reserved80: [16]u8,
    /// offset register X
    /// offset: 0x60
    OFR: [4]mmio.Mmio(packed struct(u32) {
        /// Data offset y for the channel programmed into bits OFFSETy_CH
        OFFSET: u12,
        reserved26: u14 = 0,
        /// Data offset y for the channel programmed into bits OFFSETy_CH
        CH: u5,
        /// Offset y Enable
        EN: u1,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// injected data register X
    /// offset: 0x80
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// Analog Watchdog X Configuration Register
    /// offset: 0xa0
    AWDCR: [2]mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// (1/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[0]": u1,
        /// (2/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[1]": u1,
        /// (3/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[2]": u1,
        /// (4/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[3]": u1,
        /// (5/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[4]": u1,
        /// (6/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[5]": u1,
        /// (7/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[6]": u1,
        /// (8/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[7]": u1,
        /// (9/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[8]": u1,
        /// (10/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[9]": u1,
        /// (11/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[10]": u1,
        /// (12/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[11]": u1,
        /// (13/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[12]": u1,
        /// (14/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[13]": u1,
        /// (15/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[14]": u1,
        /// (16/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[15]": u1,
        /// (17/17 of AWD2CH0) AWD2CH
        @"AWD2CH0[16]": u1,
        padding: u14 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// Differential Mode Selection Register 2
    /// offset: 0xb0
    DIFSEL: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_10: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_11: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_12: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_13: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_14: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_15: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_16: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_17: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_18: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_19: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_110: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_111: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_112: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_113: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_114: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_115: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_116: DIFSEL_10,
        /// Differential mode for channels 15 to 1
        DIFSEL_117: DIFSEL_10,
        padding: u13 = 0,
    }),
    /// Calibration Factors
    /// offset: 0xb4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// CALFACT_S
        CALFACT_S: u7,
        reserved16: u9 = 0,
        /// CALFACT_D
        CALFACT_D: u7,
        padding: u9 = 0,
    }),
};
