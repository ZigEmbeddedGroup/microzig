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

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circular = 0x1,
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

pub const IDLEVALUE = enum(u4) {
    /// Dummy channel selection is 0x13
    H13 = 0x0,
    /// Dummy channel selection is 0x1F
    H1F = 0x1,
    _,
};

pub const MDMA = enum(u2) {
    /// Without data packing, CDR/CDR2 not used
    NoPack = 0x0,
    /// CDR formatted for 32-bit down to 10-bit resolution
    Format32to10 = 0x2,
    /// CDR formatted for 8-bit resolution
    Format8 = 0x3,
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

/// ADC common registers
pub const ADC_COMMON = extern struct {
    /// common status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// Master ADC ready This bit is a copy of the ADRDY bit in the corresponding ADC_ISR register.
        ADRDY_MST: u1,
        /// End of Sampling phase flag of the master ADC This bit is a copy of the EOSMP bit in the corresponding ADC_ISR register.
        EOSMP_MST: u1,
        /// End of regular conversion of the master ADC This bit is a copy of the EOC bit in the corresponding ADC_ISR register.
        EOC_MST: u1,
        /// End of regular sequence flag of the master ADC This bit is a copy of the EOS bit in the corresponding ADC_ISR register.
        EOS_MST: u1,
        /// Overrun flag of the master ADC This bit is a copy of the OVR bit in the corresponding ADC_ISR register.
        OVR_MST: u1,
        /// End of injected conversion flag of the master ADC This bit is a copy of the JEOC bit in the corresponding ADC_ISR register.
        JEOC_MST: u1,
        /// End of injected sequence flag of the master ADC This bit is a copy of the JEOS bit in the corresponding ADC_ISR register.
        JEOS_MST: u1,
        /// (1/3 of AWD_MST) Analog watchdog 1 flag of the master ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_MST[0]": u1,
        /// (2/3 of AWD_MST) Analog watchdog 1 flag of the master ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_MST[1]": u1,
        /// (3/3 of AWD_MST) Analog watchdog 1 flag of the master ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_MST[2]": u1,
        /// Injected Context Queue Overflow flag of the master ADC This bit is a copy of the JQOVF bit in the corresponding ADC_ISR register.
        JQOVF_MST: u1,
        reserved16: u5 = 0,
        /// Slave ADC ready This bit is a copy of the ADRDY bit in the corresponding ADC_ISR register.
        ADRDY_SLV: u1,
        /// End of Sampling phase flag of the slave ADC This bit is a copy of the EOSMP2 bit in the corresponding ADC_ISR register.
        EOSMP_SLV: u1,
        /// End of regular conversion of the slave ADC This bit is a copy of the EOC bit in the corresponding ADC_ISR register.
        EOC_SLV: u1,
        /// End of regular sequence flag of the slave ADC. This bit is a copy of the EOS bit in the corresponding ADC_ISR register.
        EOS_SLV: u1,
        /// Overrun flag of the slave ADC This bit is a copy of the OVR bit in the corresponding ADC_ISR register.
        OVR_SLV: u1,
        /// End of injected conversion flag of the slave ADC This bit is a copy of the JEOC bit in the corresponding ADC_ISR register.
        JEOC_SLV: u1,
        /// End of injected sequence flag of the slave ADC This bit is a copy of the JEOS bit in the corresponding ADC_ISR register.
        JEOS_SLV: u1,
        /// (1/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_SLV[0]": u1,
        /// (2/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_SLV[1]": u1,
        /// (3/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC This bit is a copy of the AWD1 bit in the corresponding ADC_ISR register.
        @"AWD_SLV[2]": u1,
        /// Injected Context Queue Overflow flag of the slave ADC This bit is a copy of the JQOVF bit in the corresponding ADC_ISR register.
        JQOVF_SLV: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// common control register
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        /// Dual ADC mode selection These bits are written by software to select the operating mode. 0 value means Independent Mode. Values 00001 to 01001 means Dual mode, master and slave ADCs are working together. All other combinations are reserved and must not be programmed Note: The software is allowed to write these bits only when the ADCs are disabled (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        DUAL: DUAL,
        reserved8: u3 = 0,
        /// Delay between 2 sampling phases These bits are set and cleared by software. These bits are used in dual interleaved modes. Refer to for the value of ADC resolution versus DELAY bits values. Note: The software is allowed to write these bits only when the ADCs are disabled (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        DELAY: u4,
        reserved13: u1 = 0,
        /// DMA configuration (for dual ADC mode) This bit is set and cleared by software to select between two DMA modes of operation and is effective only when DMAEN = 1. For more details, refer to Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        DMACFG: DMACFG,
        /// Direct memory access mode for dual ADC mode This bitfield is set and cleared by software. Refer to the DMA controller section for more details. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        MDMA: MDMA,
        /// ADC clock mode These bits are set and cleared by software to define the ADC clock scheme (which is common to both master and slave ADCs): In all synchronous clock modes, there is no jitter in the delay from a timer trigger to the start of a conversion. Note: The software is allowed to write these bits only when the ADCs are disabled (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        CKMODE: CKMODE,
        /// ADC prescaler These bits are set and cleared by software to select the frequency of the clock to the ADC. The clock is common for all the ADCs. other: reserved Note: The software is allowed to write these bits only when the ADC is disabled (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0). The ADC prescaler value is applied only when CKMODE[1:0] = 0b00.
        PRESC: PRESC,
        /// VREFINT enable This bit is set and cleared by software to enable/disable the VREFINT channel
        VREFEN: u1,
        /// VSENSE enable This bit is set and cleared by software to control VSENSE
        TSEN: u1,
        /// VBAT enable This bit is set and cleared by software to control
        VBATEN: u1,
        padding: u7 = 0,
    }),
    /// common regular data register for dual mode
    /// offset: 0x0c
    CDR: mmio.Mmio(packed struct(u32) {
        /// Regular data of the master ADC. In dual mode, these bits contain the regular data of the master ADC. Refer to . The data alignment is applied as described in offset (ADC_DR, OFFSET, OFFSET_CH, ALIGN)) In MDMA = 0b11 mode, bits 15:8 contains SLV_ADC_DR[7:0], bits 7:0 contains MST_ADC_DR[7:0].
        RDATA_MST: u16,
        /// Regular data of the slave ADC In dual mode, these bits contain the regular data of the slave ADC. Refer to Dual ADC modes. The data alignment is applied as described in offset (ADC_DR, OFFSET, OFFSET_CH, ALIGN)).
        RDATA_SLV: u16,
    }),
    /// offset: 0x10
    reserved16: [224]u8,
    /// hardware configuration register
    /// offset: 0xf0
    HWCFGR0: mmio.Mmio(packed struct(u32) {
        /// Number of ADCs implemented
        ADCNUM: u4,
        /// Number of pipeline stages
        MULPIPE: u4,
        /// Number of option bits 0002: 2 option bits implemented in the ADC option register (ADC_OR) at address offset 0xC8.
        OPBITS: u4,
        /// Idle value for non-selected channels
        IDLEVALUE: IDLEVALUE,
        padding: u16 = 0,
    }),
    /// version register
    /// offset: 0xf4
    VERR: mmio.Mmio(packed struct(u32) {
        /// Minor revision These bits returns the ADC IP minor revision 0002: Major revision = X.2.
        MINREV: u4,
        /// Major revision These bits returns the ADC IP major revision
        MAJREV: u4,
        padding: u24 = 0,
    }),
    /// identification register
    /// offset: 0xf8
    IPDR: u32,
    /// size identification register
    /// offset: 0xfc
    SIDR: u32,
};
