const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// ADC.
pub const ADC = extern struct {
    /// ADC interrupt and status register.
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ADRDY.
        ADRDY: u1,
        /// EOSMP.
        EOSMP: u1,
        /// EOC.
        EOC: u1,
        /// EOS.
        EOS: u1,
        /// OVR.
        OVR: u1,
        reserved7: u2 = 0,
        /// AWD1.
        AWD1: u1,
        /// AWD2.
        AWD2: u1,
        /// AWD3.
        AWD3: u1,
        reserved11: u1 = 0,
        /// EOCAL.
        EOCAL: u1,
        /// LDORDY.
        LDORDY: u1,
        padding: u19 = 0,
    }),
    /// ADC interrupt enable register.
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADRDYIE.
        ADRDYIE: u1,
        /// EOSMPIE.
        EOSMPIE: u1,
        /// EOCIE.
        EOCIE: u1,
        /// EOSIE.
        EOSIE: u1,
        /// OVRIE.
        OVRIE: u1,
        reserved7: u2 = 0,
        /// AWD1IE.
        AWD1IE: u1,
        /// AWD2IE.
        AWD2IE: u1,
        /// AWD3IE.
        AWD3IE: u1,
        reserved11: u1 = 0,
        /// EOCALIE.
        EOCALIE: u1,
        /// LDORDYIE.
        LDORDYIE: u1,
        padding: u19 = 0,
    }),
    /// ADC control register.
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADEN.
        ADEN: u1,
        /// ADDIS.
        ADDIS: u1,
        /// ADSTART.
        ADSTART: u1,
        reserved4: u1 = 0,
        /// ADSTP.
        ADSTP: u1,
        reserved28: u23 = 0,
        /// ADVREGEN.
        ADVREGEN: u1,
        reserved31: u2 = 0,
        /// ADCAL.
        ADCAL: u1,
    }),
    /// ADC configuration register.
    /// offset: 0x0c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// DMAEN.
        DMAEN: u1,
        /// DMACFG.
        DMACFG: u1,
        /// RES.
        RES: u2,
        /// SCANDIR.
        SCANDIR: u1,
        /// ALIGN.
        ALIGN: u1,
        /// EXTSEL.
        EXTSEL: u3,
        reserved10: u1 = 0,
        /// EXTEN.
        EXTEN: u2,
        /// OVRMOD.
        OVRMOD: u1,
        /// CONT.
        CONT: u1,
        /// WAIT.
        WAIT: u1,
        reserved16: u1 = 0,
        /// DISCEN.
        DISCEN: u1,
        reserved21: u4 = 0,
        /// CHSELRMOD.
        CHSELRMOD: u1,
        /// AWD1SGL.
        AWD1SGL: u1,
        /// AWD1EN.
        AWD1EN: u1,
        reserved26: u2 = 0,
        /// AWD1CH.
        AWD1CH: u5,
        padding: u1 = 0,
    }),
    /// ADC configuration register 2.
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// OVSE.
        OVSE: u1,
        reserved2: u1 = 0,
        /// OVSR.
        OVSR: u3,
        /// OVSS.
        OVSS: u4,
        /// TOVS.
        TOVS: u1,
        reserved29: u19 = 0,
        /// LFTRIG.
        LFTRIG: u1,
        padding: u2 = 0,
    }),
    /// ADC sample time register.
    /// offset: 0x14
    SMPR: mmio.Mmio(packed struct(u32) {
        /// SMP1.
        SMP1: u3,
        reserved4: u1 = 0,
        /// SMP2.
        SMP2: u3,
        reserved8: u1 = 0,
        /// SMPSEL0.
        SMPSEL0: u1,
        /// SMPSEL1.
        SMPSEL1: u1,
        /// SMPSEL2.
        SMPSEL2: u1,
        /// SMPSEL3.
        SMPSEL3: u1,
        /// SMPSEL4.
        SMPSEL4: u1,
        /// SMPSEL5.
        SMPSEL5: u1,
        /// SMPSEL6.
        SMPSEL6: u1,
        /// SMPSEL7.
        SMPSEL7: u1,
        /// SMPSEL8.
        SMPSEL8: u1,
        /// SMPSEL9.
        SMPSEL9: u1,
        /// SMPSEL10.
        SMPSEL10: u1,
        /// SMPSEL11.
        SMPSEL11: u1,
        /// SMPSEL12.
        SMPSEL12: u1,
        /// SMPSEL13.
        SMPSEL13: u1,
        /// SMPSEL14.
        SMPSEL14: u1,
        /// SMPSEL15.
        SMPSEL15: u1,
        /// SMPSEL16.
        SMPSEL16: u1,
        /// SMPSEL17.
        SMPSEL17: u1,
        /// SMPSEL18.
        SMPSEL18: u1,
        /// SMPSEL19.
        SMPSEL19: u1,
        /// SMPSEL20.
        SMPSEL20: u1,
        /// SMPSEL21.
        SMPSEL21: u1,
        /// SMPSEL22.
        SMPSEL22: u1,
        /// SMPSEL23.
        SMPSEL23: u1,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// ADC watchdog threshold register.
    /// offset: 0x20
    AWD1TR: mmio.Mmio(packed struct(u32) {
        /// LT1.
        LT1: u12,
        reserved16: u4 = 0,
        /// HT1.
        HT1: u12,
        padding: u4 = 0,
    }),
    /// ADC watchdog threshold register.
    /// offset: 0x24
    AWD2TR: mmio.Mmio(packed struct(u32) {
        /// LT2.
        LT2: u12,
        reserved16: u4 = 0,
        /// HT2.
        HT2: u12,
        padding: u4 = 0,
    }),
    /// ADC channel selection register [alternate].
    /// offset: 0x28
    CHSELRMOD0: mmio.Mmio(packed struct(u32) {
        /// CHSEL.
        CHSEL: u24,
        padding: u8 = 0,
    }),
    /// ADC watchdog threshold register.
    /// offset: 0x2c
    AWD3TR: mmio.Mmio(packed struct(u32) {
        /// LT3.
        LT3: u12,
        reserved16: u4 = 0,
        /// HT3.
        HT3: u12,
        padding: u4 = 0,
    }),
    /// offset: 0x30
    reserved48: [16]u8,
    /// ADC data register.
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// DATA.
        DATA: u16,
        padding: u16 = 0,
    }),
    /// ADC data register.
    /// offset: 0x44
    PWRR: mmio.Mmio(packed struct(u32) {
        /// AUTOFF.
        AUTOFF: u1,
        /// DPD.
        DPD: u1,
        /// VREFPROT.
        VREFPROT: u1,
        /// VREFSECSMP.
        VREFSECSMP: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x48
    reserved72: [88]u8,
    /// ADC Analog Watchdog 2 Configuration register.
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        /// AWD2CH0.
        AWD2CH0: u1,
        /// AWD2CH1.
        AWD2CH1: u1,
        /// AWD2CH2.
        AWD2CH2: u1,
        /// AWD2CH3.
        AWD2CH3: u1,
        /// AWD2CH4.
        AWD2CH4: u1,
        /// AWD2CH5.
        AWD2CH5: u1,
        /// AWD2CH6.
        AWD2CH6: u1,
        /// AWD2CH7.
        AWD2CH7: u1,
        /// AWD2CH8.
        AWD2CH8: u1,
        /// AWD2CH9.
        AWD2CH9: u1,
        /// AWD2CH10.
        AWD2CH10: u1,
        /// AWD2CH11.
        AWD2CH11: u1,
        /// AWD2CH12.
        AWD2CH12: u1,
        /// AWD2CH13.
        AWD2CH13: u1,
        /// AWD2CH14.
        AWD2CH14: u1,
        /// AWD2CH15.
        AWD2CH15: u1,
        /// AWD2CH16.
        AWD2CH16: u1,
        /// AWD2CH17.
        AWD2CH17: u1,
        /// AWD2CH18.
        AWD2CH18: u1,
        /// AWD2CH19.
        AWD2CH19: u1,
        /// AWD2CH20.
        AWD2CH20: u1,
        /// AWD2CH21.
        AWD2CH21: u1,
        /// AWD2CH22.
        AWD2CH22: u1,
        /// AWD2CH23.
        AWD2CH23: u1,
        padding: u8 = 0,
    }),
    /// ADC Analog Watchdog 3 Configuration register.
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        /// AWD3CH0.
        AWD3CH0: u1,
        /// AWD3CH1.
        AWD3CH1: u1,
        /// AWD3CH2.
        AWD3CH2: u1,
        /// AWD3CH3.
        AWD3CH3: u1,
        /// AWD3CH4.
        AWD3CH4: u1,
        /// AWD3CH5.
        AWD3CH5: u1,
        /// AWD3CH6.
        AWD3CH6: u1,
        /// AWD3CH7.
        AWD3CH7: u1,
        /// AWD3CH8.
        AWD3CH8: u1,
        /// AWD3CH9.
        AWD3CH9: u1,
        /// AWD3CH10.
        AWD3CH10: u1,
        /// AWD3CH11.
        AWD3CH11: u1,
        /// AWD3CH12.
        AWD3CH12: u1,
        /// AWD3CH13.
        AWD3CH13: u1,
        /// AWD3CH14.
        AWD3CH14: u1,
        /// AWD3CH15.
        AWD3CH15: u1,
        /// AWD3CH16.
        AWD3CH16: u1,
        /// AWD3CH17.
        AWD3CH17: u1,
        /// AWD3CH18.
        AWD3CH18: u1,
        /// AWD3CH19.
        AWD3CH19: u1,
        /// AWD3CH20.
        AWD3CH20: u1,
        /// AWD3CH21.
        AWD3CH21: u1,
        /// AWD3CH22.
        AWD3CH22: u1,
        /// AWD3CH23.
        AWD3CH23: u1,
        padding: u8 = 0,
    }),
    /// offset: 0xa8
    reserved168: [28]u8,
    /// ADC Calibration factor.
    /// offset: 0xc4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// CALFACT.
        CALFACT: u7,
        padding: u25 = 0,
    }),
    /// offset: 0xc8
    reserved200: [8]u8,
    /// ADC option register.
    /// offset: 0xd0
    OR: mmio.Mmio(packed struct(u32) {
        /// CHN21SEL.
        CHN21SEL: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xd4
    reserved212: [564]u8,
    /// ADC common configuration register.
    /// offset: 0x308
    CCR: mmio.Mmio(packed struct(u32) {
        reserved18: u18 = 0,
        /// PRESC.
        PRESC: u4,
        /// VREFEN.
        VREFEN: u1,
        /// VSENSESEL.
        VSENSESEL: u1,
        /// VBATEN.
        VBATEN: u1,
        padding: u7 = 0,
    }),
};
