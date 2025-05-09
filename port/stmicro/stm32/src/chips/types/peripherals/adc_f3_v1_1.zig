const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADC_CFG = enum(u1) {
    /// Bank A selected for channels ADC_IN0..31
    BANK_A = 0x0,
    /// Bank B selected for channels ADC_IN0..31b
    BANK_B = 0x1,
};

pub const DELS = enum(u3) {
    /// No Delay
    NO_DELAY = 0x0,
    /// Until the converted data have been read
    AFTER_READ = 0x1,
    /// Delay 7 APB clock cycles after the conversion
    DELAY_7_CLK = 0x2,
    /// Delay 16 APB clock cycles after the conversion
    DELAY_15_CLK = 0x3,
    /// Delay 31 APB clock cycles after the conversion
    DELAY_31_CLK = 0x4,
    /// Delay 63 APB clock cycles after the conversion
    DELAY_63_CLK = 0x5,
    /// Delay 127 APB clock cycles after the conversion
    DELAY_127_CLK = 0x6,
    /// Delay 255 APB clock cycles after the conversion
    DELAY_255_CLK = 0x7,
};

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

pub const EXTEN = enum(u2) {
    /// Trigger detection disabled
    DISABLED = 0x0,
    /// Trigger detection on the rising edge
    RISING = 0x1,
    /// Trigger detection on the falling edge
    FALLING = 0x2,
    /// Trigger detection on both edges
    BOTH = 0x3,
};

pub const EXTSEL = enum(u4) {
    /// Timer 9 CC2 event
    TIM9_CC2 = 0x0,
    /// Timer 9 TRGO event
    TIM9_TRGO = 0x1,
    /// Timer 2 CC3 event
    TIM2_CC3 = 0x2,
    /// Timer 2 CC2 event
    TIM2_CC2 = 0x3,
    /// Timer 3 TRGO event
    TIM3_TRGO = 0x4,
    /// Timer 4 CC4 event
    TIM4_CC4 = 0x5,
    /// Timer 2 TRGO event
    TIM2_TRGO = 0x6,
    /// Timer 3 CC1 event
    TIM3_CC1 = 0x7,
    /// Timer 3 CC3 event
    TIM3_CC3 = 0x8,
    /// Timer 4 TRGO event
    TIM4_TRGO = 0x9,
    /// Timer 6 TRGO event
    TIM6_TRGO = 0xa,
    /// External interrupt line 11
    EXTI_LINE11 = 0xf,
    _,
};

pub const JEXTSEL = enum(u4) {
    /// Timer 9 CC1 event
    TIM9_CC1 = 0x0,
    /// Timer 9 TRGO event
    TIM9_TRGO = 0x1,
    /// Timer 2 TRGO event
    TIM2_TRGO = 0x2,
    /// Timer 2 CC1 event
    TIM2_CC1 = 0x3,
    /// Timer 3 CC4 event
    TIM3_CC4 = 0x4,
    /// Timer 4 TRGO event
    TIM4_TRGO = 0x5,
    /// Timer 4 CC1 event
    TIM4_CC1 = 0x6,
    /// Timer 4 CC2 event
    TIM4_CC2 = 0x7,
    /// Timer 4 CC3 event
    TIM4_CC3 = 0x8,
    /// Timer 4 CC3 event
    TIM10_CC1 = 0x9,
    /// Timer 7 TRGO event
    TIM7_TRGO = 0xa,
    /// External interrupt line 15
    EXTI_LINE15 = 0xf,
    _,
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
    /// 4 ADC clock cycles
    Cycles4 = 0x0,
    /// 9 ADC clock cycles
    Cycles9 = 0x1,
    /// 16 ADC clock cycles
    Cycles16 = 0x2,
    /// 24 ADC clock cycles
    Cycles24 = 0x3,
    /// 48 ADC clock cycles
    Cycles48 = 0x4,
    /// 96 ADC clock cycles
    Cycles96 = 0x5,
    /// 192 ADC clock cycles
    Cycles192 = 0x6,
    /// 384 ADC clock cycles
    Cycles384 = 0x7,
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
        /// Overrun
        OVR: u1,
        /// ADC ON status
        ADONS: u1,
        reserved8: u1 = 0,
        /// Regular channel not ready
        RCNR: u1,
        /// Injected channel not ready
        JCNR: u1,
        padding: u22 = 0,
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
        DISCNUM: DISCNUM,
        /// Power down during the delay phase
        PDD: u1,
        /// Power down during the idle phase
        PDI: u1,
        reserved22: u4 = 0,
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
        /// ADC configuration
        ADC_CFG: ADC_CFG,
        reserved4: u1 = 0,
        /// Delay selection
        DELS: DELS,
        reserved8: u1 = 0,
        /// Direct memory access mode
        DMA: u1,
        /// DMA disable selection
        DDS: u1,
        /// End of conversion selection
        EOCS: u1,
        /// Data alignment
        ALIGN: u1,
        reserved16: u4 = 0,
        /// External event select for injected group
        JEXTSEL: JEXTSEL,
        /// External trigger enable for injected channels
        JEXTEN: EXTEN,
        /// Start conversion of injected channels
        JSWSTART: u1,
        reserved24: u1 = 0,
        /// External event select for regular group
        EXTSEL: EXTSEL,
        /// External trigger enable for regular channels
        EXTEN: EXTEN,
        /// Start conversion of regular channels
        SWSTART: u1,
        padding: u1 = 0,
    }),
    /// sample time register 1
    /// offset: 0x0c
    SMPR1: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) channel 20-29 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) channel 20-29 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) channel 20-29 sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) channel 20-29 sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) channel 20-29 sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) channel 20-29 sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) channel 20-29 sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) channel 20-29 sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) channel 20-29 sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) channel 20-29 sampling time selection
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// sample time register 2
    /// offset: 0x10
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) channel 10-19 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) channel 10-19 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) channel 10-19 sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) channel 10-19 sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) channel 10-19 sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) channel 10-19 sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) channel 10-19 sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) channel 10-19 sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) channel 10-19 sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) channel 10-19 sampling time selection
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// sample time register 3
    /// offset: 0x14
    SMPR3: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) channel 0-9 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) channel 0-9 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) channel 0-9 sampling time selection
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) channel 0-9 sampling time selection
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) channel 0-9 sampling time selection
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) channel 0-9 sampling time selection
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) channel 0-9 sampling time selection
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) channel 0-9 sampling time selection
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) channel 0-9 sampling time selection
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) channel 0-9 sampling time selection
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// injected channel data offset register 1
    /// offset: 0x18
    JOFR1: mmio.Mmio(packed struct(u32) {
        /// Data offset for injected channel x
        JOFFSET1: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 2
    /// offset: 0x1c
    JOFR2: mmio.Mmio(packed struct(u32) {
        /// Data offset for injected channel x
        JOFFSET2: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 3
    /// offset: 0x20
    JOFR3: mmio.Mmio(packed struct(u32) {
        /// Data offset for injected channel x
        JOFFSET3: u12,
        padding: u20 = 0,
    }),
    /// injected channel data offset register 4
    /// offset: 0x24
    JOFR4: mmio.Mmio(packed struct(u32) {
        /// Data offset for injected channel x
        JOFFSET4: u12,
        padding: u20 = 0,
    }),
    /// watchdog higher threshold register
    /// offset: 0x28
    HTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog higher threshold
        HT: u12,
        padding: u20 = 0,
    }),
    /// watchdog lower threshold register
    /// offset: 0x2c
    LTR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog lower threshold
        LT: u12,
        padding: u20 = 0,
    }),
    /// regular sequence register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// (1/4 of SQ) 25th-29th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/4 of SQ) 25th-29th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/4 of SQ) 25th-29th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/4 of SQ) 25th-29th conversion in regular sequence
        @"SQ[3]": u5,
        /// Regular channel sequence length
        L: u4,
        padding: u8 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x34
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 19th-24th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x38
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 13th-18th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 4
    /// offset: 0x3c
    SQR4: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 7th-12th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// regular sequence register 5
    /// offset: 0x40
    SQR5: mmio.Mmio(packed struct(u32) {
        /// (1/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[0]": u5,
        /// (2/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[1]": u5,
        /// (3/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[2]": u5,
        /// (4/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[3]": u5,
        /// (5/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[4]": u5,
        /// (6/6 of SQ) 1st-6th conversion in regular sequence
        @"SQ[5]": u5,
        padding: u2 = 0,
    }),
    /// injected sequence register
    /// offset: 0x44
    JSQR: mmio.Mmio(packed struct(u32) {
        /// 1st conversion in injected sequence
        JSQ1: u5,
        /// 2nd conversion in injected sequence
        JSQ2: u5,
        /// 3rd conversion in injected sequence
        JSQ3: u5,
        /// 4th conversion in injected sequence
        JSQ4: u5,
        /// Injected sequence length
        JL: u2,
        padding: u10 = 0,
    }),
    /// injected data register x1
    /// offset: 0x48
    JDR1: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// injected data register 2
    /// offset: 0x4c
    JDR2: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// injected data register 3
    /// offset: 0x50
    JDR3: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// injected data register 4
    /// offset: 0x54
    JDR4: mmio.Mmio(packed struct(u32) {
        /// Injected data
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// regular data register
    /// offset: 0x58
    DR: mmio.Mmio(packed struct(u32) {
        /// Regular data
        rdata: u16,
        padding: u16 = 0,
    }),
    /// sample time register 0
    /// offset: 0x5c
    SMPR0: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SMP) channel 30-31 sampling time selection
        @"SMP[0]": SAMPLE_TIME,
        /// (2/2 of SMP) channel 30-31 sampling time selection
        @"SMP[1]": SAMPLE_TIME,
        padding: u26 = 0,
    }),
    /// offset: 0x60
    reserved96: [672]u8,
    /// ADC common status register
    /// offset: 0x300
    CSR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog flag of the ADC
        AWD1: u1,
        /// End of conversion of the ADC
        EOC1: u1,
        /// Injected channel end of conversion of the ADC
        JEOC1: u1,
        /// Injected channel Start flag of the ADC
        JSTRT1: u1,
        /// Regular channel Start flag of the ADC
        STRT1: u1,
        /// Overrun flag of the ADC
        OVR1: u1,
        /// ADON Status of ADC1
        ADONS1: u1,
        padding: u25 = 0,
    }),
    /// ADC common control register
    /// offset: 0x304
    CCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// ADC prescaler
        ADCPRE: u2,
        reserved23: u5 = 0,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1,
        padding: u8 = 0,
    }),
};
