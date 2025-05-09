const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

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
    /// 1.5 ADC cycles
    Cycles1_5 = 0x0,
    /// 3.5 ADC cycles
    Cycles3_5 = 0x1,
    /// 7.5 ADC cycles
    Cycles7_5 = 0x2,
    /// 12.5 ADC cycles
    Cycles12_5 = 0x3,
    /// 19.5 ADC cycles
    Cycles19_5 = 0x4,
    /// 39.5 ADC cycles
    Cycles39_5 = 0x5,
    /// 79.5 ADC cycles
    Cycles79_5 = 0x6,
    /// 160.5 ADC cycles
    Cycles160_5 = 0x7,
};

/// Analog to Digital Converter
pub const ADC = extern struct {
    /// ADC interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ADC ready flag
        ADRDY: u1,
        /// ADC group regular end of sampling flag
        EOSMP: u1,
        /// ADC group regular end of unitary conversion flag
        EOC: u1,
        /// ADC group regular end of sequence conversions flag
        EOS: u1,
        /// ADC group regular overrun flag
        OVR: u1,
        reserved7: u2 = 0,
        /// ADC analog watchdog 1 flag
        AWD1: u1,
        /// ADC analog watchdog 2 flag
        AWD2: u1,
        /// ADC analog watchdog 3 flag
        AWD3: u1,
        reserved11: u1 = 0,
        /// End Of Calibration flag
        EOCAL: u1,
        reserved13: u1 = 0,
        /// Channel Configuration Ready flag
        CCRDY: u1,
        padding: u18 = 0,
    }),
    /// ADC interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADC ready interrupt
        ADRDYIE: u1,
        /// ADC group regular end of sampling interrupt
        EOSMPIE: u1,
        /// ADC group regular end of unitary conversion interrupt
        EOCIE: u1,
        /// ADC group regular end of sequence conversions interrupt
        EOSIE: u1,
        /// ADC group regular overrun interrupt
        OVRIE: u1,
        reserved7: u2 = 0,
        /// ADC analog watchdog 1 interrupt
        AWD1IE: u1,
        /// ADC analog watchdog 2 interrupt
        AWD2IE: u1,
        /// ADC analog watchdog 3 interrupt
        AWD3IE: u1,
        reserved11: u1 = 0,
        /// End of calibration interrupt enable
        EOCALIE: u1,
        reserved13: u1 = 0,
        /// Channel Configuration Ready Interrupt enable
        CCRDYIE: u1,
        padding: u18 = 0,
    }),
    /// ADC control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADC enable
        ADEN: u1,
        /// ADC disable
        ADDIS: u1,
        /// ADC group regular conversion start
        ADSTART: u1,
        reserved4: u1 = 0,
        /// ADC group regular conversion stop
        ADSTP: u1,
        reserved28: u23 = 0,
        /// ADC voltage regulator enable
        ADVREGEN: u1,
        reserved31: u2 = 0,
        /// ADC calibration
        ADCAL: u1,
    }),
    /// ADC configuration register 1
    /// offset: 0x0c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// ADC DMA transfer enable
        DMAEN: u1,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        /// Scan sequence direction
        SCANDIR: u1,
        /// ADC data resolution
        RES: RES,
        /// ADC data alignement
        ALIGN: u1,
        /// ADC group regular external trigger source
        EXTSEL: u3,
        reserved10: u1 = 0,
        /// ADC group regular external trigger polarity
        EXTEN: u2,
        /// ADC group regular overrun configuration
        OVRMOD: u1,
        /// Continuous conversion
        CONT: u1,
        /// Wait conversion mode
        WAIT: u1,
        /// Auto-off mode
        AUTOFF: u1,
        /// ADC group regular sequencer discontinuous mode
        DISCEN: u1,
        reserved21: u4 = 0,
        /// Mode selection of the ADC_CHSELR register
        CHSELRMOD: u1,
        /// ADC analog watchdog 1 monitoring a single channel or all channels
        AWD1SGL: u1,
        /// ADC analog watchdog 1 enable on scope ADC group regular
        AWD1EN: u1,
        reserved26: u2 = 0,
        /// ADC analog watchdog 1 monitored channel selection
        AWDCH1CH: u5,
        padding: u1 = 0,
    }),
    /// ADC configuration register 2
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// ADC oversampler enable on scope ADC group regular
        OVSE: u1,
        reserved2: u1 = 0,
        /// ADC oversampling ratio
        OVSR: u3,
        /// ADC oversampling shift
        OVSS: u4,
        /// ADC oversampling discontinuous mode (triggered mode) for ADC group regular
        TOVS: u1,
        reserved29: u19 = 0,
        /// Low frequency trigger mode enable
        LFTRIG: u1,
        /// ADC clock mode
        CKMODE: u2,
    }),
    /// ADC sampling time register
    /// offset: 0x14
    SMPR: mmio.Mmio(packed struct(u32) {
        /// Sampling time selection
        SMP1: SAMPLE_TIME,
        reserved4: u1 = 0,
        /// Sampling time selection
        SMP2: SAMPLE_TIME,
        reserved8: u1 = 0,
        /// (1/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[0]": u1,
        /// (2/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[1]": u1,
        /// (3/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[2]": u1,
        /// (4/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[3]": u1,
        /// (5/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[4]": u1,
        /// (6/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[5]": u1,
        /// (7/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[6]": u1,
        /// (8/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[7]": u1,
        /// (9/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[8]": u1,
        /// (10/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[9]": u1,
        /// (11/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[10]": u1,
        /// (12/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[11]": u1,
        /// (13/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[12]": u1,
        /// (14/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[13]": u1,
        /// (15/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[14]": u1,
        /// (16/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[15]": u1,
        /// (17/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[16]": u1,
        /// (18/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[17]": u1,
        /// (19/19 of SMPSEL) Channel sampling time selection
        @"SMPSEL[18]": u1,
        padding: u5 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// watchdog threshold register
    /// offset: 0x20
    AWD1TR: mmio.Mmio(packed struct(u32) {
        /// ADC analog watchdog 1 threshold low
        LT1: u12,
        reserved16: u4 = 0,
        /// ADC analog watchdog 1 threshold high
        HT1: u12,
        padding: u4 = 0,
    }),
    /// watchdog threshold register
    /// offset: 0x24
    AWD2TR: mmio.Mmio(packed struct(u32) {
        /// ADC analog watchdog 2 threshold low
        LT2: u12,
        reserved16: u4 = 0,
        /// ADC analog watchdog 2 threshold high
        HT2: u12,
        padding: u4 = 0,
    }),
    /// channel selection register
    /// offset: 0x28
    CHSELR: mmio.Mmio(packed struct(u32) {
        /// Channel-x selection
        CHSEL: u19,
        padding: u13 = 0,
    }),
    /// watchdog threshold register
    /// offset: 0x2c
    AWD3TR: mmio.Mmio(packed struct(u32) {
        /// ADC analog watchdog 3 threshold high
        LT3: u12,
        reserved16: u4 = 0,
        /// ADC analog watchdog 3 threshold high
        HT3: u12,
        padding: u4 = 0,
    }),
    /// offset: 0x30
    reserved48: [16]u8,
    /// ADC group regular conversion data register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// ADC group regular conversion data
        regularDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [92]u8,
    /// ADC analog watchdog 2 configuration register
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        /// ADC analog watchdog 2 monitored channel selection
        AWD2CH: u19,
        padding: u13 = 0,
    }),
    /// ADC analog watchdog 3 configuration register
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        /// ADC analog watchdog 3 monitored channel selection
        AWD3CH: u19,
        padding: u13 = 0,
    }),
    /// offset: 0xa8
    reserved168: [12]u8,
    /// ADC calibration factors register
    /// offset: 0xb4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// ADC calibration factor in single-ended mode
        CALFACT: u7,
        padding: u25 = 0,
    }),
    /// offset: 0xb8
    reserved184: [592]u8,
    /// ADC common control register
    /// offset: 0x308
    CCR: mmio.Mmio(packed struct(u32) {
        reserved18: u18 = 0,
        /// ADC prescaler
        PRESC: u4,
        /// VREFINT enable
        VREFEN: u1,
        /// Temperature sensor enable
        TSEN: u1,
        /// VBAT enable
        VBATEN: u1,
        padding: u7 = 0,
    }),
};
