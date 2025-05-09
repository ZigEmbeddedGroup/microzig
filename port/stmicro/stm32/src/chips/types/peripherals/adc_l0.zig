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

pub const CKMODE = enum(u2) {
    /// Asynchronous clock mode
    ADCCLK = 0x0,
    /// Synchronous clock mode (PCLK/2)
    PCLK_Div2 = 0x1,
    /// Sychronous clock mode (PCLK/4)
    PCLK_Div4 = 0x2,
    /// Synchronous clock mode (PCLK)
    PCLK = 0x3,
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

pub const OVRMOD = enum(u1) {
    /// ADC_DR register is preserved with the old data when an overrun is detected
    Preserved = 0x0,
    /// ADC_DR register is overwritten with the last conversion result when an overrun is detected
    Overwritten = 0x1,
};

pub const PRESC = enum(u4) {
    /// Input ADC clock not divided.
    Div1 = 0x0,
    /// Input ADC clock divided by 2.
    Div2 = 0x1,
    /// Input ADC clock divided by 4.
    Div4 = 0x2,
    /// Input ADC clock divided by 6.
    Div6 = 0x3,
    /// Input ADC clock divided by 8.
    Div8 = 0x4,
    /// Input ADC clock divided by 10.
    Div10 = 0x5,
    /// Input ADC clock divided by 12.
    Div12 = 0x6,
    /// Input ADC clock divided by 16.
    Div16 = 0x7,
    /// Input ADC clock divided by 32.
    Div32 = 0x8,
    /// Input ADC clock divided by 64.
    Div64 = 0x9,
    /// Input ADC clock divided by 128.
    Div128 = 0xa,
    /// Input ADC clock divided by 256.
    Div256 = 0xb,
    _,
};

pub const RES = enum(u2) {
    /// 12-bit (14 ADCCLK cycles)
    Bits12 = 0x0,
    /// 10-bit (13 ADCCLK cycles)
    Bits10 = 0x1,
    /// 8-bit (11 ADCCLK cycles)
    Bits8 = 0x2,
    /// 6-bit (9 ADCCLK cycles)
    Bits6 = 0x3,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 1.5 cycles
    Cycles1_5 = 0x0,
    /// 3.5 cycles
    Cycles3_5 = 0x1,
    /// 7.5 cycles
    Cycles7_5 = 0x2,
    /// 12.5 cycles
    Cycles12_5 = 0x3,
    /// 19.5 cycles
    Cycles19_5 = 0x4,
    /// 39.5 cycles
    Cycles39_5 = 0x5,
    /// 79.5 cycles
    Cycles79_5 = 0x6,
    /// 160.5 cycles
    Cycles160_5 = 0x7,
};

pub const SCANDIR = enum(u1) {
    /// Upward scan (from CHSEL0 to CHSEL18)
    Upward = 0x0,
    /// Backward scan (from CHSEL18 to CHSEL0)
    Backward = 0x1,
};

/// Analog-to-digital converter
pub const ADC = extern struct {
    /// interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ADC ready
        ADRDY: u1,
        /// End of sampling flag
        EOSMP: u1,
        /// End of conversion flag
        EOC: u1,
        /// End of sequence flag
        EOS: u1,
        /// ADC overrun
        OVR: u1,
        reserved7: u2 = 0,
        /// Analog watchdog flag
        AWD: u1,
        reserved11: u3 = 0,
        /// End Of Calibration flag
        EOCAL: u1,
        padding: u20 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADC ready interrupt enable
        ADRDYIE: u1,
        /// End of sampling flag interrupt enable
        EOSMPIE: u1,
        /// End of conversion interrupt enable
        EOCIE: u1,
        /// End of conversion sequence interrupt enable
        EOSIE: u1,
        /// Overrun interrupt enable
        OVRIE: u1,
        reserved7: u2 = 0,
        /// Analog watchdog interrupt enable
        AWDIE: u1,
        reserved11: u3 = 0,
        /// End of calibration interrupt enable.
        EOCALIE: u1,
        padding: u20 = 0,
    }),
    /// control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADC enable command
        ADEN: u1,
        /// ADC disable command
        ADDIS: u1,
        /// ADC start conversion command
        ADSTART: u1,
        reserved4: u1 = 0,
        /// ADC stop conversion command
        ADSTP: u1,
        reserved28: u23 = 0,
        /// ADC Voltage Regulator Enable.
        ADVREGEN: u1,
        reserved31: u2 = 0,
        /// ADC calibration
        ADCAL: u1,
    }),
    /// configuration register 1
    /// offset: 0x0c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Direct memory access enable
        DMAEN: u1,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        /// Scan sequence direction
        SCANDIR: SCANDIR,
        /// Data resolution
        RES: RES,
        /// Data alignment
        ALIGN: ALIGN,
        /// External trigger selection
        EXTSEL: u3,
        reserved10: u1 = 0,
        /// External trigger enable and polarity selection
        EXTEN: EXTEN,
        /// Overrun management mode
        OVRMOD: OVRMOD,
        /// Continuous conversion
        CONT: u1,
        /// Wait conversion mode
        WAIT: u1,
        /// Auto-off mode
        AUTOFF: u1,
        /// Discontinuous mode
        DISCEN: u1,
        reserved22: u5 = 0,
        /// Enable the watchdog on a single channel or on all channels
        AWDSGL: AWDSGL,
        /// Analog watchdog enable
        AWDEN: u1,
        reserved26: u2 = 0,
        /// Analog watchdog channel selection
        AWDCH: u5,
        padding: u1 = 0,
    }),
    /// configuration register 2
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Oversampler Enable.
        OVSE: u1,
        reserved2: u1 = 0,
        /// Oversampling ratio.
        OVSR: u3,
        /// Oversampling shift.
        OVSS: u4,
        /// Triggered Oversampling.
        TOVS: u1,
        reserved30: u20 = 0,
        /// ADC clock mode
        CKMODE: CKMODE,
    }),
    /// sampling time register
    /// offset: 0x14
    SMPR: mmio.Mmio(packed struct(u32) {
        /// Sampling time selection
        SMP: SAMPLE_TIME,
        padding: u29 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// watchdog threshold register
    /// offset: 0x20
    TR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog lower threshold
        LT: u12,
        reserved16: u4 = 0,
        /// Analog watchdog higher threshold
        HT: u12,
        padding: u4 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// channel selection register
    /// offset: 0x28
    CHSELR: mmio.Mmio(packed struct(u32) {
        /// (1/19 of CHSEL x) Channel-x selection
        @"CHSEL x[0]": u1,
        /// (2/19 of CHSEL x) Channel-x selection
        @"CHSEL x[1]": u1,
        /// (3/19 of CHSEL x) Channel-x selection
        @"CHSEL x[2]": u1,
        /// (4/19 of CHSEL x) Channel-x selection
        @"CHSEL x[3]": u1,
        /// (5/19 of CHSEL x) Channel-x selection
        @"CHSEL x[4]": u1,
        /// (6/19 of CHSEL x) Channel-x selection
        @"CHSEL x[5]": u1,
        /// (7/19 of CHSEL x) Channel-x selection
        @"CHSEL x[6]": u1,
        /// (8/19 of CHSEL x) Channel-x selection
        @"CHSEL x[7]": u1,
        /// (9/19 of CHSEL x) Channel-x selection
        @"CHSEL x[8]": u1,
        /// (10/19 of CHSEL x) Channel-x selection
        @"CHSEL x[9]": u1,
        /// (11/19 of CHSEL x) Channel-x selection
        @"CHSEL x[10]": u1,
        /// (12/19 of CHSEL x) Channel-x selection
        @"CHSEL x[11]": u1,
        /// (13/19 of CHSEL x) Channel-x selection
        @"CHSEL x[12]": u1,
        /// (14/19 of CHSEL x) Channel-x selection
        @"CHSEL x[13]": u1,
        /// (15/19 of CHSEL x) Channel-x selection
        @"CHSEL x[14]": u1,
        /// (16/19 of CHSEL x) Channel-x selection
        @"CHSEL x[15]": u1,
        /// (17/19 of CHSEL x) Channel-x selection
        @"CHSEL x[16]": u1,
        /// (18/19 of CHSEL x) Channel-x selection
        @"CHSEL x[17]": u1,
        /// (19/19 of CHSEL x) Channel-x selection
        @"CHSEL x[18]": u1,
        padding: u13 = 0,
    }),
    /// offset: 0x2c
    reserved44: [20]u8,
    /// data register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// Converted data
        DATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [112]u8,
    /// ADC Calibration factor.
    /// offset: 0xb4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// Calibration factor.
        CALFACT: u7,
        padding: u25 = 0,
    }),
    /// offset: 0xb8
    reserved184: [592]u8,
    /// common configuration register
    /// offset: 0x308
    CCR: mmio.Mmio(packed struct(u32) {
        reserved18: u18 = 0,
        /// ADC prescaler.
        PRESC: PRESC,
        /// VREFINT enable
        VREFEN: u1,
        /// Temperature sensor enable
        TSEN: u1,
        reserved25: u1 = 0,
        /// Low Frequency Mode enable
        LFMEN: u1,
        padding: u6 = 0,
    }),
};
