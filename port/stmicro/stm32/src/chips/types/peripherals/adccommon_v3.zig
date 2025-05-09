const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circular = 0x1,
};

/// Analog-to-Digital Converter
pub const ADC_COMMON = extern struct {
    /// ADC Common status register
    /// offset: 0x00
    CSR: mmio.Mmio(packed struct(u32) {
        /// ADDRDY_MST
        ADDRDY_MST: u1,
        /// EOSMP_MST
        EOSMP_MST: u1,
        /// EOC_MST
        EOC_MST: u1,
        /// EOS_MST
        EOS_MST: u1,
        /// OVR_MST
        OVR_MST: u1,
        /// JEOC_MST
        JEOC_MST: u1,
        /// JEOS_MST
        JEOS_MST: u1,
        /// (1/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[0]": u1,
        /// (2/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[1]": u1,
        /// (3/3 of AWD_MST) Analog watchdog flag of the master ADC
        @"AWD_MST[2]": u1,
        /// JQOVF_MST
        JQOVF_MST: u1,
        reserved16: u5 = 0,
        /// ADRDY_SLV
        ADRDY_SLV: u1,
        /// EOSMP_SLV
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
        /// (1/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC
        @"AWD_SLV[0]": u1,
        /// (2/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC
        @"AWD_SLV[1]": u1,
        /// (3/3 of AWD_SLV) Analog watchdog 1 flag of the slave ADC
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
        /// Multi ADC mode selection
        MULT: u5,
        reserved8: u3 = 0,
        /// Delay between 2 sampling phases
        DELAY: u4,
        reserved13: u1 = 0,
        /// Direct memory access configuration
        DMACFG: DMACFG,
        /// Direct memory access mode for multi ADC mode
        MDMA: u2,
        /// ADC clock mode
        CKMODE: u2,
        reserved22: u4 = 0,
        /// VREFINT enable
        VREFEN: u1,
        /// CH18 selection (Vbat)
        CH18SEL: u1,
        /// CH17 selection (temperature)
        CH17SEL: u1,
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
};
