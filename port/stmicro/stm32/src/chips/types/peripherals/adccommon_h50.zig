const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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

pub const IDLEVALUE = enum(u4) {
    /// Dummy channel selection is 0x13
    H13 = 0x0,
    /// Dummy channel selection is 0x1F
    H1F = 0x1,
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
    /// offset: 0x00
    reserved0: [8]u8,
    /// common control register
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
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
    /// offset: 0x0c
    reserved12: [228]u8,
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
