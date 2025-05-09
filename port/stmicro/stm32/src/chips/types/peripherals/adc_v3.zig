const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circular = 0x1,
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
    /// 2.5 ADC cycles
    Cycles2_5 = 0x0,
    /// 6.5 ADC cycles
    Cycles6_5 = 0x1,
    /// 12.5 ADC cycles
    Cycles12_5 = 0x2,
    /// 24.5 ADC cycles
    Cycles24_5 = 0x3,
    /// 47.5 ADC cycles
    Cycles47_5 = 0x4,
    /// 92.5 ADC cycles
    Cycles92_5 = 0x5,
    /// 247.5 ADC cycles
    Cycles247_5 = 0x6,
    /// 640.5 ADC cycles
    Cycles640_5 = 0x7,
};

/// Analog-to-Digital Converter
pub const ADC = extern struct {
    /// interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ADRDY
        ADRDY: u1,
        /// EOSMP
        EOSMP: u1,
        /// EOC
        EOC: u1,
        /// EOS
        EOS: u1,
        /// OVR
        OVR: u1,
        /// JEOC
        JEOC: u1,
        /// JEOS
        JEOS: u1,
        /// (1/3 of AWD) AWD1
        @"AWD[0]": u1,
        /// (2/3 of AWD) AWD1
        @"AWD[1]": u1,
        /// (3/3 of AWD) AWD1
        @"AWD[2]": u1,
        /// JQOVF
        JQOVF: u1,
        padding: u21 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADRDYIE
        ADRDYIE: u1,
        /// EOSMPIE
        EOSMPIE: u1,
        /// EOCIE
        EOCIE: u1,
        /// EOSIE
        EOSIE: u1,
        /// OVRIE
        OVRIE: u1,
        /// JEOCIE
        JEOCIE: u1,
        /// JEOSIE
        JEOSIE: u1,
        /// AWD1IE
        AWD1IE: u1,
        /// AWD2IE
        AWD2IE: u1,
        /// AWD3IE
        AWD3IE: u1,
        /// JQOVFIE
        JQOVFIE: u1,
        padding: u21 = 0,
    }),
    /// control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADEN
        ADEN: u1,
        /// ADDIS
        ADDIS: u1,
        /// ADSTART
        ADSTART: u1,
        /// JADSTART
        JADSTART: u1,
        /// ADSTP
        ADSTP: u1,
        /// JADSTP
        JADSTP: u1,
        reserved28: u22 = 0,
        /// ADVREGEN
        ADVREGEN: u1,
        /// DEEPPWD
        DEEPPWD: u1,
        /// ADCALDIF
        ADCALDIF: u1,
        /// ADCAL
        ADCAL: u1,
    }),
    /// configuration register
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// DMAEN
        DMAEN: u1,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        reserved3: u1 = 0,
        /// RES
        RES: RES,
        /// ALIGN
        ALIGN: u1,
        /// EXTSEL
        EXTSEL: u4,
        /// EXTEN
        EXTEN: u2,
        /// OVRMOD
        OVRMOD: u1,
        /// CONT
        CONT: u1,
        /// AUTDLY
        AUTDLY: u1,
        /// AUTOFF
        AUTOFF: u1,
        /// DISCEN
        DISCEN: u1,
        /// DISCNUM
        DISCNUM: u3,
        /// JDISCEN
        JDISCEN: u1,
        /// JQM
        JQM: u1,
        /// AWD1SGL
        AWD1SGL: u1,
        /// AWD1EN
        AWD1EN: u1,
        /// JAWD1EN
        JAWD1EN: u1,
        /// JAUTO
        JAUTO: u1,
        /// AWDCH1CH
        AWDCH1CH: u5,
        padding: u1 = 0,
    }),
    /// configuration register
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// DMAEN
        ROVSE: u1,
        /// DMACFG
        JOVSE: u1,
        /// RES
        OVSR: u3,
        /// ALIGN
        OVSS: u4,
        /// EXTSEL
        TOVS: u1,
        /// EXTEN
        ROVSM: u1,
        padding: u21 = 0,
    }),
    /// sample time register 1
    /// offset: 0x14
    SMPR: [2]mmio.Mmio(packed struct(u32) {
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
    /// offset: 0x1c
    reserved28: [4]u8,
    /// watchdog threshold register 1
    /// offset: 0x20
    TR: [3]mmio.Mmio(packed struct(u32) {
        /// LT1
        LT: u12,
        reserved16: u4 = 0,
        /// HT1
        HT: u12,
        padding: u4 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// regular sequence register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// Regular channel sequence length
        L: u4,
        reserved6: u2 = 0,
        /// (1/4 of SQ) SQ1
        @"SQ[0]": u5,
        reserved12: u1 = 0,
        /// (2/4 of SQ) SQ1
        @"SQ[1]": u5,
        reserved18: u1 = 0,
        /// (3/4 of SQ) SQ1
        @"SQ[2]": u5,
        reserved24: u1 = 0,
        /// (4/4 of SQ) SQ1
        @"SQ[3]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x34
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) SQ5
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) SQ5
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) SQ5
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) SQ5
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) SQ5
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x38
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) SQ10
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) SQ10
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) SQ10
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) SQ10
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) SQ10
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 4
    /// offset: 0x3c
    SQR4: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SQ) SQ15
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/2 of SQ) SQ15
        @"SQ[1]": u5,
        padding: u21 = 0,
    }),
    /// regular Data Register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// regularDATA
        regularDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [8]u8,
    /// injected sequence register
    /// offset: 0x4c
    JSQR: mmio.Mmio(packed struct(u32) {
        /// JL
        JL: u2,
        /// JEXTSEL
        JEXTSEL: u4,
        /// JEXTEN
        JEXTEN: u2,
        /// (1/4 of JSQ) JSQ1
        @"JSQ[0]": u5,
        reserved14: u1 = 0,
        /// (2/4 of JSQ) JSQ1
        @"JSQ[1]": u5,
        reserved20: u1 = 0,
        /// (3/4 of JSQ) JSQ1
        @"JSQ[2]": u5,
        reserved26: u1 = 0,
        /// (4/4 of JSQ) JSQ1
        @"JSQ[3]": u5,
        padding: u1 = 0,
    }),
    /// offset: 0x50
    reserved80: [16]u8,
    /// offset register 1
    /// offset: 0x60
    OFR: [4]mmio.Mmio(packed struct(u32) {
        OFFSET: u12,
        reserved26: u14 = 0,
        OFFSET_CH: u5,
        OFFSET_EN: u1,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// injected data registers
    /// offset: 0x80
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// JDATA1
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// Analog Watchdog 2 Configuration Register
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// AWD2CH
        AWD2CH: u18,
        padding: u13 = 0,
    }),
    /// Analog Watchdog 3 Configuration Register
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// AWD3CH
        AWD3CH: u18,
        padding: u13 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// Differential Mode Selection Register 2
    /// offset: 0xb0
    DIFSEL: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_1_15: u15,
        /// Differential mode for channels 18 to 16
        DIFSEL_16_18: u3,
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
