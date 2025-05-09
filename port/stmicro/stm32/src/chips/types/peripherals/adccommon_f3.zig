const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// ADC clock mode
pub const CKMODE = enum(u2) {
    /// Use Kernel Clock adc_ker_ck_input divided by PRESC. Asynchronous mode
    Asynchronous = 0x0,
    /// Use AHB clock rcc_hclk3. In this case rcc_hclk must equal sys_d1cpre_ck.
    SyncDiv1 = 0x1,
    /// Use AHB clock rcc_hclk3 divided by 2.
    SyncDiv2 = 0x2,
    /// Use AHB clock rcc_hclk3 divided by 4.
    SyncDiv4 = 0x3,
};

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circulator = 0x1,
};

/// Dual ADC mode selection
pub const DUAL = enum(u5) {
    /// Independent mode
    Independent = 0x0,
    /// Dual, combined regular simultaneous + injected simultaneous mode
    DualRJ = 0x1,
    /// Dual, combined regular simultaneous + alternate trigger mode
    DualRA = 0x2,
    /// Dual, combined injected simultaneous + fast interleaved mode
    DualIJ = 0x3,
    /// Dual, injected simultaneous mode only
    DualJ = 0x5,
    /// Dual, regular simultaneous mode only
    DualR = 0x6,
    /// dual, interleaved mode only
    DualI = 0x7,
    /// Dual, alternate trigger mode only
    DualA = 0x9,
    _,
};

/// Direct memory access mode for multi ADC mode
pub const MDMA = enum(u2) {
    /// MDMA mode disabled
    Disabled = 0x0,
    /// MDMA mode enabled for 12 and 10-bit resolution
    Bits12_10 = 0x2,
    /// MDMA mode enabled for 8 and 6-bit resolution
    Bits8_6 = 0x3,
    _,
};

/// ADC common registers
pub const ADC_COMMON = extern struct {
    /// ADC Common status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Master ADC ready
        ADRDY_MST: u1,
        /// End of sampling phase flag of the master ADC
        EOSMP_MST: u1,
        /// End of regular conversion of the master ADC
        EOC_MST: u1,
        /// End of regular sequence flag of the master ADC
        EOS_MST: u1,
        /// Overrun flag of the master ADC
        OVR_MST: u1,
        /// End of injected conversion of the master ADC
        JEOC_MST: u1,
        /// End of injected sequence flag of the master ADC
        JEOS: u1,
        /// (1/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[0]": u1,
        /// (2/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[1]": u1,
        /// (3/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[2]": u1,
        /// Injected context queue overflow flag of the master ADC
        JQOVF_MST: u1,
        reserved16: u5 = 0,
        /// Slave ADC ready
        ADRDY_SLV: u1,
        /// End of sampling phase flag of the slave ADC
        EOSMP_SLV: u1,
        /// End of regular conversion of the slave ADC
        EOC_SLV: u1,
        /// End of regular sequence flag of the slave ADC
        EOS_SLV: u1,
        /// Overrun flag of the slave ADC
        OVR_SLV: u1,
        /// End of injected conversion of the slave ADC
        JEOC_SLV: u1,
        /// End of injected sequence flag of the slave ADC
        JEOS_SLV: u1,
        /// (1/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[0]": u1,
        /// (2/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[1]": u1,
        /// (3/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[2]": u1,
        /// Injected context queue overflow flag of the slave ADC
        JQOVF_SLV: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// ADC common control register
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        /// Dual ADC mode selection
        DUAL: DUAL,
        reserved8: u3 = 0,
        /// Delay between 2 sampling phases
        DELAY: u4,
        reserved13: u1 = 0,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        /// Direct memory access mode for multi ADC mode
        MDMA: MDMA,
        /// ADC clock mode
        CKMODE: CKMODE,
        reserved22: u4 = 0,
        /// VREFINT enable
        VREFEN: u1,
        /// Temperature sensor enable
        TSEN: u1,
        /// VBAT enable
        VBATEN: u1,
        padding: u7 = 0,
    }),
    /// ADC common regular data register for dual and triple modes
    /// offset: 0x0c
    CDR: mmio.Mmio(packed struct(u32) {
        /// Regular data of the master ADC
        RDATA_MST: u16,
        /// Regular data of the master ADC
        RDATA_SLV: u16,
    }),
};
