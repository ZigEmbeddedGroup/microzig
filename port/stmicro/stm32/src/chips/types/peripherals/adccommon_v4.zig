const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CKMODE = enum(u2) {
    /// Use Kernel Clock adc_ker_ck_input divided by PRESC. Asynchronous to AHB clock
    Asynchronous = 0x0,
    /// Use AHB clock rcc_hclk3. In this case rcc_hclk must equal sys_d1cpre_ck
    SyncDiv1 = 0x1,
    /// Use AHB clock rcc_hclk3 divided by 2
    SyncDiv2 = 0x2,
    /// Use AHB clock rcc_hclk3 divided by 4
    SyncDiv4 = 0x3,
};

pub const DAMDF = enum(u2) {
    /// Without data packing, CDR/CDR2 not used
    NoPack = 0x0,
    /// CDR formatted for 32-bit down to 10-bit resolution
    Format32to10 = 0x2,
    /// CDR formatted for 8-bit resolution
    Format8 = 0x3,
    _,
};

pub const DUAL = enum(u5) {
    /// Independent mode
    Independent = 0x0,
    /// Dual, combined regular simultaneous + injected simultaneous mode
    DualRJ = 0x1,
    /// Dual, combined regular simultaneous + alternate trigger mode
    DualRA = 0x2,
    /// Dual, combined interleaved mode + injected simultaneous mode
    DualIJ = 0x3,
    /// Dual, injected simultaneous mode only
    DualJ = 0x5,
    /// Dual, regular simultaneous mode only
    DualR = 0x6,
    /// Dual, interleaved mode only
    DualI = 0x7,
    /// Dual, alternate trigger mode only
    DualA = 0x9,
    _,
};

pub const PRESC = enum(u4) {
    /// adc_ker_ck_input not divided
    Div1 = 0x0,
    /// adc_ker_ck_input divided by 2
    Div2 = 0x1,
    /// adc_ker_ck_input divided by 4
    Div4 = 0x2,
    /// adc_ker_ck_input divided by 6
    Div6 = 0x3,
    /// adc_ker_ck_input divided by 8
    Div8 = 0x4,
    /// adc_ker_ck_input divided by 10
    Div10 = 0x5,
    /// adc_ker_ck_input divided by 12
    Div12 = 0x6,
    /// adc_ker_ck_input divided by 16
    Div16 = 0x7,
    /// adc_ker_ck_input divided by 32
    Div32 = 0x8,
    /// adc_ker_ck_input divided by 64
    Div64 = 0x9,
    /// adc_ker_ck_input divided by 128
    Div128 = 0xa,
    /// adc_ker_ck_input divided by 256
    Div256 = 0xb,
    _,
};

/// Analog-to-Digital Converter
pub const ADC_COMMON = extern struct {
    /// ADC Common status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Master ADC ready
        ADRDY_MST: u1,
        /// End of Sampling phase flag of the master ADC
        EOSMP_MST: u1,
        /// End of regular conversion of the master ADC
        EOC_MST: u1,
        /// End of regular sequence flag of the master ADC
        EOS_MST: u1,
        /// Overrun flag of the master ADC
        OVR_MST: u1,
        /// End of injected conversion flag of the master ADC
        JEOC_MST: u1,
        /// End of injected sequence flag of the master ADC
        JEOS_MST: u1,
        /// (1/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[0]": u1,
        /// (2/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[1]": u1,
        /// (3/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[2]": u1,
        /// Injected Context Queue Overflow flag of the master ADC
        JQOVF_MST: u1,
        reserved16: u5 = 0,
        /// Slave ADC ready
        ADRDY_SLV: u1,
        /// End of Sampling phase flag of the slave ADC
        EOSMP_SLV: u1,
        /// End of regular conversion of the slave ADC
        EOC_SLV: u1,
        /// End of regular sequence flag of the slave ADC
        EOS_SLV: u1,
        /// Overrun flag of the slave ADC
        OVR_SLV: u1,
        /// End of injected conversion flag of the slave ADC
        JEOC_SLV: u1,
        /// End of injected sequence flag of the slave ADC
        JEOS_SLV: u1,
        /// (1/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[0]": u1,
        /// (2/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[1]": u1,
        /// (3/3 of AWD_SLV) Analog watchdog flag of the slave ADC
        @"AWD_SLV[2]": u1,
        /// Injected Context Queue Overflow flag of the slave ADC
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
        reserved14: u2 = 0,
        /// Dual ADC Mode Data Format
        DAMDF: DAMDF,
        /// ADC clock mode
        CKMODE: CKMODE,
        /// ADC prescaler
        PRESC: PRESC,
        /// VREFINT enable
        VREFEN: u1,
        /// Temperature sensor enable
        VSENSEEN: u1,
        /// VBAT enable
        VBATEN: u1,
        padding: u7 = 0,
    }),
    /// ADC common regular data register for dual and triple modes
    /// offset: 0x0c
    CDR: mmio.Mmio(packed struct(u32) {
        /// Regular data of the master ADC
        RDATA_MST: u16,
        /// Regular data of the slave ADC
        RDATA_SLV: u16,
    }),
    /// ADC x common regular data register for 32-bit dual mode
    /// offset: 0x10
    CDR2: mmio.Mmio(packed struct(u32) {
        /// Regular data of the master/slave alternated ADCs
        RDATA_ALT: u32,
    }),
};
