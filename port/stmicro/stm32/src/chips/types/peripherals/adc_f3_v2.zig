const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DISCNUM = enum(u3) {
    /// 1 conversions are discontinued and the conversion is carried out on one channel
    DISCNUM_1 = 0x0,
    /// 2 conversion is discontinued and the conversions are carried out on 2 channels
    DISCNUM_2 = 0x1,
    /// 3 conversions are discontinued and the conversions are carried out on 3 channels
    DISCNUM_3 = 0x2,
    /// 4 conversions are discontinued and the conversions are carried out on 4 channels
    DISCNUM_4 = 0x3,
    /// 5 conversions are discontinued and the conversions are carried out on 5 channels
    DISCNUM_5 = 0x4,
    /// 6 conversions are discontinued and the conversions are carried out on 6 channels
    DISCNUM_6 = 0x5,
    /// 7 conversions are discontinued and the conversions are carried out on 7 channels
    DISCNUM_7 = 0x6,
    /// 8 conversions are discontinued and the conversions are carried out on 8 channels
    DISCNUM_8 = 0x7,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 1.5 ADC clock cycles
    Cycles1_5 = 0x0,
    /// 7.5 ADC clock cycles
    Cycles7_5 = 0x1,
    /// 13.5 ADC clock cycles
    Cycles13_5 = 0x2,
    /// 28.5 ADC clock cycles
    Cycles28_5 = 0x3,
    /// 41.5 ADC clock cycles
    Cycles41_5 = 0x4,
    /// 55.5 ADC clock cycles
    Cycles55_5 = 0x5,
    /// 71.5 ADC clock cycles
    Cycles71_5 = 0x6,
    /// 239.5 ADC clock cycles
    Cycles239_5 = 0x7,
};

/// Analog-to-Digital Converter
pub const ADC = extern struct {
    /// status register
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// analog watchdog flag
        AWD: u1,
        /// end of conversion
        EOC: u1,
        /// injected channel end of conversion
        JEOC: u1,
        /// injected channel start flag
        JSTRT: u1,
        /// regular channel start flag
        STRT: u1,
        /// overrun
        OVR: u1,
        padding: u26 = 0,
    }),
    /// control register 1
    /// offset: 0x04
    CR1: mmio.Mmio(packed struct(u32) {
        /// analog watchdog channel select bits
        AWDCH: u5,
        /// interrupt enable for EOC
        EOCIE: u1,
        /// analog watchdog interrupt enable
        AWDIE: u1,
        /// interrupt enable for injected channels
        JEOCIE: u1,
        /// scan mode
        SCAN: u1,
        /// enable the watchdog on a single channel in scan mode
        AWDSGL: u1,
        /// automatic injected group conversion
        JAUTO: u1,
        /// discontinuous mode on regular channels
        DISCEN: u1,
        /// discontinuous mode on injected channels
        JDISCEN: u1,
        /// discontinuous mode channel count
        DISCNUM: DISCNUM,
        reserved22: u6 = 0,
        /// analog watchdog enable on injected channels
        JAWDEN: u1,
        /// analog watchdog enable on regular channels
        AWDEN: u1,
        padding: u8 = 0,
    }),
    /// control register 2
    /// offset: 0x08
    CR2: mmio.Mmio(packed struct(u32) {
        /// A/D converter ON / OFF
        ADON: u1,
        /// Continuous conversion
        CONT: u1,
        /// A/D calibration
        CAL: u1,
        /// reset calibration
        RSTCAL: u1,
        reserved8: u4 = 0,
        /// DMA disable selection (for single ADC mode)
        DMA: u1,
        reserved11: u2 = 0,
        /// data alignment
        ALIGN: u1,
        /// external event select for injected group
        JEXTSEL: u3,
        /// external trigger conversion mode for injected channels
        JEXTTRIG: u1,
        reserved17: u1 = 0,
        /// external event select for regular group
        EXTSEL: u3,
        /// external trigger conversion mode for regular channels
        EXTTRIG: u1,
        /// start conversion of injected channels
        JSWSTART: u1,
        /// start conversion of regular channels
        SWSTART: u1,
        /// temperature sensor and VREFINT enable
        TSVREFE: u1,
        padding: u8 = 0,
    }),
    /// sample time register 1
    /// offset: 0x0c
    SMPR1: mmio.Mmio(packed struct(u32) {
        /// channel 10 sampling time selection
        SMP10: SAMPLE_TIME,
        /// channel 11 sampling time selection
        SMP11: SAMPLE_TIME,
        /// channel 12 sampling time selection
        SMP12: SAMPLE_TIME,
        /// channel 13 sampling time selection
        SMP13: SAMPLE_TIME,
        /// channel 14 sampling time selection
        SMP14: SAMPLE_TIME,
        /// channel 15 sampling time selection
        SMP15: SAMPLE_TIME,
        /// channel 16 sampling time selection
        SMP16: SAMPLE_TIME,
        /// channel 17 sampling time selection
        SMP17: SAMPLE_TIME,
        /// channel 18 sampling time selection
        SMP18: SAMPLE_TIME,
        padding: u5 = 0,
    }),
    /// sample time register 2
    /// offset: 0x10
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// channel 0 sampling time selection
        SMP0: SAMPLE_TIME,
        /// channel 1 sampling time selection
        SMP1: SAMPLE_TIME,
        /// channel 2 sampling time selection
        SMP2: SAMPLE_TIME,
        /// channel 3 sampling time selection
        SMP3: SAMPLE_TIME,
        /// channel 4 sampling time selection
        SMP4: SAMPLE_TIME,
        /// channel 5 sampling time selection
        SMP5: SAMPLE_TIME,
        /// channel 6 sampling time selection
        SMP6: SAMPLE_TIME,
        /// channel 7 sampling time selection
        SMP7: SAMPLE_TIME,
        /// channel 8 sampling time selection
        SMP8: SAMPLE_TIME,
        /// channel 9 sampling time selection
        SMP9: SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// injected channel data offset register 1
    /// offset: 0x14
    JOFR1: mmio.Mmio(packed struct(u32) {
        /// data offset for injected channel 1
        JOFFSET1: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 2
    /// offset: 0x18
    JOFR2: mmio.Mmio(packed struct(u32) {
        /// data offset for injected channel 2
        JOFFSET2: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 3
    /// offset: 0x1c
    JOFR3: mmio.Mmio(packed struct(u32) {
        /// data offset for injected channel 3
        JOFFSET3: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 4
    /// offset: 0x20
    JOFR4: mmio.Mmio(packed struct(u32) {
        /// data offset for injected channel 4
        JOFFSET4: u12,
        padding: u20 = 0,
    }),
    /// watchdog higher threshold register
    /// offset: 0x24
    HTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog high threshold
        HT: u12,
        padding: u20 = 0,
    }),
    /// watchdog lower threshold register
    /// offset: 0x28
    LTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog low threshold
        LT: u12,
        padding: u20 = 0,
    }),
    /// regular sequence register 1
    /// offset: 0x2c
    SQR1: mmio.Mmio(packed struct(u32) {
        /// 13th conversion in regular sequence
        SQ13: u5,
        /// 14th conversion in regular sequence
        SQ14: u5,
        /// 15th conversion in regular sequence
        SQ15: u5,
        /// 16th conversion in regular sequence
        SQ16: u5,
        /// regular channel sequence length
        L: u4,
        padding: u8 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x30
    SQR2: mmio.Mmio(packed struct(u32) {
        /// 7th conversion in regular sequence
        SQ7: u5,
        /// 8th conversion in regular sequence
        SQ8: u5,
        /// 9th conversion in regular sequence
        SQ9: u5,
        /// 10th conversion in regular sequence
        SQ10: u5,
        /// 11th conversion in regular sequence
        SQ11: u5,
        /// 12th conversion in regular sequence
        SQ12: u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x34
    SQR3: mmio.Mmio(packed struct(u32) {
        /// 1st conversion in regular sequence
        SQ1: u5,
        /// 2nd conversion in regular sequence
        SQ2: u5,
        /// 3rd conversion in regular sequence
        SQ3: u5,
        /// 4th conversion in regular sequence
        SQ4: u5,
        /// 5th conversion in regular sequence
        SQ5: u5,
        /// 6th conversion in regular sequence
        SQ6: u5,
        padding: u2 = 0,
    }),
    /// injected sequence register
    /// offset: 0x38
    JSQR: mmio.Mmio(packed struct(u32) {
        /// 1st conversion in injected sequence
        JSQ1: u5,
        /// 2nd conversion in injected sequence
        JSQ2: u5,
        /// 3rd conversion in injected sequence
        JSQ3: u5,
        /// 4th conversion in injected sequence
        JSQ4: u5,
        /// injected sequence length
        JL: u2,
        padding: u10 = 0,
    }),
    /// injected data register 1
    /// offset: 0x3c
    JDR1: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA1: u16,
        padding: u16 = 0,
    }),
    /// injected data register 2
    /// offset: 0x40
    JDR2: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA2: u16,
        padding: u16 = 0,
    }),
    /// injected data register 3
    /// offset: 0x44
    JDR3: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA3: u16,
        padding: u16 = 0,
    }),
    /// injected data register 4
    /// offset: 0x48
    JDR4: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA4: u16,
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
