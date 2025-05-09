const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// DSIHOST1.
pub const DSIHOST = extern struct {
    /// DSI Host version register.
    /// offset: 0x00
    VR: mmio.Mmio(packed struct(u32) {
        /// VERSION.
        VERSION: u32,
    }),
    /// DSI Host control register.
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// EN.
        EN: u1,
        padding: u31 = 0,
    }),
    /// DSI Host clock control register.
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        /// TXECKDIV.
        TXECKDIV: u8,
        /// TOCKDIV.
        TOCKDIV: u8,
        padding: u16 = 0,
    }),
    /// DSI Host LTDC VCID register.
    /// offset: 0x0c
    LVCIDR: mmio.Mmio(packed struct(u32) {
        /// VCID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC color coding register.
    /// offset: 0x10
    LCOLCR: mmio.Mmio(packed struct(u32) {
        /// COLC.
        COLC: u4,
        reserved8: u4 = 0,
        /// LPE.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// DSI Host LTDC polarity configuration register.
    /// offset: 0x14
    LPCR: mmio.Mmio(packed struct(u32) {
        /// DEP.
        DEP: u1,
        /// VSP.
        VSP: u1,
        /// HSP.
        HSP: u1,
        padding: u29 = 0,
    }),
    /// DSI Host low-power mode configuration register.
    /// offset: 0x18
    LPMCR: mmio.Mmio(packed struct(u32) {
        /// VLPSIZE.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// LPSIZE.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x1c
    reserved28: [16]u8,
    /// DSI Host protocol configuration register.
    /// offset: 0x2c
    PCR: mmio.Mmio(packed struct(u32) {
        /// ETTXE.
        ETTXE: u1,
        /// ETRXE.
        ETRXE: u1,
        /// BTAE.
        BTAE: u1,
        /// ECCRXE.
        ECCRXE: u1,
        /// CRCRXE.
        CRCRXE: u1,
        padding: u27 = 0,
    }),
    /// DSI Host generic VCID register.
    /// offset: 0x30
    GVCIDR: mmio.Mmio(packed struct(u32) {
        /// VCID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host mode configuration register.
    /// offset: 0x34
    MCR: mmio.Mmio(packed struct(u32) {
        /// CMDM.
        CMDM: u1,
        padding: u31 = 0,
    }),
    /// DSI Host video mode configuration register.
    /// offset: 0x38
    VMCR: mmio.Mmio(packed struct(u32) {
        /// VMT.
        VMT: u2,
        reserved8: u6 = 0,
        /// LPVSAE.
        LPVSAE: u1,
        /// LPVBPE.
        LPVBPE: u1,
        /// LPVFPE.
        LPVFPE: u1,
        /// LPVAE.
        LPVAE: u1,
        /// LPHBPE.
        LPHBPE: u1,
        /// LPHFPE.
        LPHFPE: u1,
        /// FBTAAE.
        FBTAAE: u1,
        /// LPCE.
        LPCE: u1,
        /// PGE.
        PGE: u1,
        reserved20: u3 = 0,
        /// PGM.
        PGM: u1,
        reserved24: u3 = 0,
        /// PGO.
        PGO: u1,
        padding: u7 = 0,
    }),
    /// DSI Host video packet configuration register.
    /// offset: 0x3c
    VPCR: mmio.Mmio(packed struct(u32) {
        /// VPSIZE.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host video chunks configuration register.
    /// offset: 0x40
    VCCR: mmio.Mmio(packed struct(u32) {
        /// NUMC.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video null packet configuration register.
    /// offset: 0x44
    VNPCR: mmio.Mmio(packed struct(u32) {
        /// NPSIZE.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video HSA configuration register.
    /// offset: 0x48
    VHSACR: mmio.Mmio(packed struct(u32) {
        /// HSA.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video HBP configuration register.
    /// offset: 0x4c
    VHBPCR: mmio.Mmio(packed struct(u32) {
        /// HBP.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video line configuration register.
    /// offset: 0x50
    VLCR: mmio.Mmio(packed struct(u32) {
        /// HLINE.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host video VSA configuration register.
    /// offset: 0x54
    VVSACR: mmio.Mmio(packed struct(u32) {
        /// VSA.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VBP configuration register.
    /// offset: 0x58
    VVBPCR: mmio.Mmio(packed struct(u32) {
        /// VBP.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VFP configuration register.
    /// offset: 0x5c
    VVFPCR: mmio.Mmio(packed struct(u32) {
        /// VFP.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VA configuration register.
    /// offset: 0x60
    VVACR: mmio.Mmio(packed struct(u32) {
        /// VA.
        VA: u14,
        padding: u18 = 0,
    }),
    /// DSI Host LTDC command configuration register.
    /// offset: 0x64
    LCCR: mmio.Mmio(packed struct(u32) {
        /// CMDSIZE.
        CMDSIZE: u16,
        padding: u16 = 0,
    }),
    /// DSI Host command mode configuration register.
    /// offset: 0x68
    CMCR: mmio.Mmio(packed struct(u32) {
        /// TEARE.
        TEARE: u1,
        /// ARE.
        ARE: u1,
        reserved8: u6 = 0,
        /// GSW0TX.
        GSW0TX: u1,
        /// GSW1TX.
        GSW1TX: u1,
        /// GSW2TX.
        GSW2TX: u1,
        /// GSR0TX.
        GSR0TX: u1,
        /// GSR1TX.
        GSR1TX: u1,
        /// GSR2TX.
        GSR2TX: u1,
        /// GLWTX.
        GLWTX: u1,
        reserved16: u1 = 0,
        /// DSW0TX.
        DSW0TX: u1,
        /// DSW1TX.
        DSW1TX: u1,
        /// DSR0TX.
        DSR0TX: u1,
        /// DLWTX.
        DLWTX: u1,
        reserved24: u4 = 0,
        /// MRDPS.
        MRDPS: u1,
        padding: u7 = 0,
    }),
    /// DSI Host generic header configuration register.
    /// offset: 0x6c
    GHCR: mmio.Mmio(packed struct(u32) {
        /// DT.
        DT: u6,
        /// VCID.
        VCID: u2,
        /// WCLSB.
        WCLSB: u8,
        /// WCMSB.
        WCMSB: u8,
        padding: u8 = 0,
    }),
    /// DSI Host generic payload data register.
    /// offset: 0x70
    GPDR: mmio.Mmio(packed struct(u32) {
        /// DATA1.
        DATA1: u8,
        /// DATA2.
        DATA2: u8,
        /// DATA3.
        DATA3: u8,
        /// DATA4.
        DATA4: u8,
    }),
    /// DSI Host generic packet status register.
    /// offset: 0x74
    GPSR: mmio.Mmio(packed struct(u32) {
        /// CMDFE.
        CMDFE: u1,
        /// CMDFF.
        CMDFF: u1,
        /// PWRFE.
        PWRFE: u1,
        /// PWRFF.
        PWRFF: u1,
        /// PRDFE.
        PRDFE: u1,
        /// PRDFF.
        PRDFF: u1,
        /// RCB.
        RCB: u1,
        padding: u25 = 0,
    }),
    /// DSI Host timeout counter configuration register 0.
    /// offset: 0x78
    TCCR0: mmio.Mmio(packed struct(u32) {
        /// LPRX_TOCNT.
        LPRX_TOCNT: u16,
        /// HSTX_TOCNT.
        HSTX_TOCNT: u16,
    }),
    /// DSI Host timeout counter configuration register 1.
    /// offset: 0x7c
    TCCR1: mmio.Mmio(packed struct(u32) {
        /// HSRD_TOCNT.
        HSRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 2.
    /// offset: 0x80
    TCCR2: mmio.Mmio(packed struct(u32) {
        /// LPRD_TOCNT.
        LPRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 3.
    /// offset: 0x84
    TCCR3: mmio.Mmio(packed struct(u32) {
        /// HSWR_TOCNT.
        HSWR_TOCNT: u16,
        reserved24: u8 = 0,
        /// PM.
        PM: u1,
        padding: u7 = 0,
    }),
    /// DSI Host timeout counter configuration register 4.
    /// offset: 0x88
    TCCR4: mmio.Mmio(packed struct(u32) {
        /// LPWR_TOCNT.
        LPWR_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host timeout counter configuration register 5.
    /// offset: 0x8c
    TCCR5: mmio.Mmio(packed struct(u32) {
        /// BTA_TOCNT.
        BTA_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// DSI Host clock lane configuration register.
    /// offset: 0x94
    CLCR: mmio.Mmio(packed struct(u32) {
        /// DPCC.
        DPCC: u1,
        /// ACR.
        ACR: u1,
        padding: u30 = 0,
    }),
    /// DSI Host clock lane timer configuration register.
    /// offset: 0x98
    CLTCR: mmio.Mmio(packed struct(u32) {
        /// LP2HS_TIME.
        LP2HS_TIME: u10,
        reserved16: u6 = 0,
        /// HS2LP_TIME.
        HS2LP_TIME: u10,
        padding: u6 = 0,
    }),
    /// DSI Host data lane timer configuration register.
    /// offset: 0x9c
    DLTCR: mmio.Mmio(packed struct(u32) {
        /// LP2HS_TIME.
        LP2HS_TIME: u10,
        reserved16: u6 = 0,
        /// HS2LP_TIME.
        HS2LP_TIME: u10,
        padding: u6 = 0,
    }),
    /// DSI Host PHY control register.
    /// offset: 0xa0
    PCTLR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// DEN.
        DEN: u1,
        /// CKE.
        CKE: u1,
        padding: u29 = 0,
    }),
    /// DSI Host PHY configuration register.
    /// offset: 0xa4
    PCONFR: mmio.Mmio(packed struct(u32) {
        /// NL.
        NL: u2,
        reserved8: u6 = 0,
        /// SW_TIME.
        SW_TIME: u8,
        padding: u16 = 0,
    }),
    /// DSI Host PHY ULPS control register.
    /// offset: 0xa8
    PUCR: mmio.Mmio(packed struct(u32) {
        /// URCL.
        URCL: u1,
        /// UECL.
        UECL: u1,
        /// URDL.
        URDL: u1,
        /// UEDL.
        UEDL: u1,
        padding: u28 = 0,
    }),
    /// DSI Host PHY TX triggers configuration register.
    /// offset: 0xac
    PTTCR: mmio.Mmio(packed struct(u32) {
        /// TX_TRIG.
        TX_TRIG: u4,
        padding: u28 = 0,
    }),
    /// DSI Host PHY status register.
    /// offset: 0xb0
    PSR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PD.
        PD: u1,
        /// PSSC.
        PSSC: u1,
        /// UANC.
        UANC: u1,
        /// PSS0.
        PSS0: u1,
        /// UAN0.
        UAN0: u1,
        /// RUE0.
        RUE0: u1,
        /// PSS1.
        PSS1: u1,
        /// UAN1.
        UAN1: u1,
        padding: u23 = 0,
    }),
    /// offset: 0xb4
    reserved180: [8]u8,
    /// DSI Host interrupt and status register 0.
    /// offset: 0xbc
    ISR0: mmio.Mmio(packed struct(u32) {
        /// AE0.
        AE0: u1,
        /// AE1.
        AE1: u1,
        /// AE2.
        AE2: u1,
        /// AE3.
        AE3: u1,
        /// AE4.
        AE4: u1,
        /// AE5.
        AE5: u1,
        /// AE6.
        AE6: u1,
        /// AE7.
        AE7: u1,
        /// AE8.
        AE8: u1,
        /// AE9.
        AE9: u1,
        /// AE10.
        AE10: u1,
        /// AE11.
        AE11: u1,
        /// AE12.
        AE12: u1,
        /// AE13.
        AE13: u1,
        /// AE14.
        AE14: u1,
        /// AE15.
        AE15: u1,
        /// PE0.
        PE0: u1,
        /// PE1.
        PE1: u1,
        /// PE2.
        PE2: u1,
        /// PE3.
        PE3: u1,
        /// PE4.
        PE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host interrupt and status register 1.
    /// offset: 0xc0
    ISR1: mmio.Mmio(packed struct(u32) {
        /// TOHSTX.
        TOHSTX: u1,
        /// TOLPRX.
        TOLPRX: u1,
        /// ECCSE.
        ECCSE: u1,
        /// ECCME.
        ECCME: u1,
        /// CRCE.
        CRCE: u1,
        /// PSE.
        PSE: u1,
        /// EOTPE.
        EOTPE: u1,
        /// LPWRE.
        LPWRE: u1,
        /// GCWRE.
        GCWRE: u1,
        /// GPWRE.
        GPWRE: u1,
        /// GPTXE.
        GPTXE: u1,
        /// GPRDE.
        GPRDE: u1,
        /// GPRXE.
        GPRXE: u1,
        padding: u19 = 0,
    }),
    /// DSI Host interrupt enable register 0.
    /// offset: 0xc4
    IER0: mmio.Mmio(packed struct(u32) {
        /// AE0IE.
        AE0IE: u1,
        /// AE1IE.
        AE1IE: u1,
        /// AE2IE.
        AE2IE: u1,
        /// AE3IE.
        AE3IE: u1,
        /// AE4IE.
        AE4IE: u1,
        /// AE5IE.
        AE5IE: u1,
        /// AE6IE.
        AE6IE: u1,
        /// AE7IE.
        AE7IE: u1,
        /// AE8IE.
        AE8IE: u1,
        /// AE9IE.
        AE9IE: u1,
        /// AE10IE.
        AE10IE: u1,
        /// AE11IE.
        AE11IE: u1,
        /// AE12IE.
        AE12IE: u1,
        /// AE13IE.
        AE13IE: u1,
        /// AE14IE.
        AE14IE: u1,
        /// AE15IE.
        AE15IE: u1,
        /// PE0IE.
        PE0IE: u1,
        /// PE1IE.
        PE1IE: u1,
        /// PE2IE.
        PE2IE: u1,
        /// PE3IE.
        PE3IE: u1,
        /// PE4IE.
        PE4IE: u1,
        padding: u11 = 0,
    }),
    /// DSI Host interrupt enable register 1.
    /// offset: 0xc8
    IER1: mmio.Mmio(packed struct(u32) {
        /// TOHSTXIE.
        TOHSTXIE: u1,
        /// TOLPRXIE.
        TOLPRXIE: u1,
        /// ECCSEIE.
        ECCSEIE: u1,
        /// ECCMEIE.
        ECCMEIE: u1,
        /// CRCEIE.
        CRCEIE: u1,
        /// PSEIE.
        PSEIE: u1,
        /// EOTPEIE.
        EOTPEIE: u1,
        /// LPWREIE.
        LPWREIE: u1,
        /// GCWREIE.
        GCWREIE: u1,
        /// GPWREIE.
        GPWREIE: u1,
        /// GPTXEIE.
        GPTXEIE: u1,
        /// GPRDEIE.
        GPRDEIE: u1,
        /// GPRXEIE.
        GPRXEIE: u1,
        padding: u19 = 0,
    }),
    /// offset: 0xcc
    reserved204: [12]u8,
    /// DSI Host force interrupt register 0.
    /// offset: 0xd8
    FIR0: mmio.Mmio(packed struct(u32) {
        /// FAE0.
        FAE0: u1,
        /// FAE1.
        FAE1: u1,
        /// FAE2.
        FAE2: u1,
        /// FAE3.
        FAE3: u1,
        /// FAE4.
        FAE4: u1,
        /// FAE5.
        FAE5: u1,
        /// FAE6.
        FAE6: u1,
        /// FAE7.
        FAE7: u1,
        /// FAE8.
        FAE8: u1,
        /// FAE9.
        FAE9: u1,
        /// FAE10.
        FAE10: u1,
        /// FAE11.
        FAE11: u1,
        /// FAE12.
        FAE12: u1,
        /// FAE13.
        FAE13: u1,
        /// FAE14.
        FAE14: u1,
        /// FAE15.
        FAE15: u1,
        /// FPE0.
        FPE0: u1,
        /// FPE1.
        FPE1: u1,
        /// FPE2.
        FPE2: u1,
        /// FPE3.
        FPE3: u1,
        /// FPE4.
        FPE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host force interrupt register 1.
    /// offset: 0xdc
    FIR1: mmio.Mmio(packed struct(u32) {
        /// FTOHSTX.
        FTOHSTX: u1,
        /// FTOLPRX.
        FTOLPRX: u1,
        /// FECCSE.
        FECCSE: u1,
        /// FECCME.
        FECCME: u1,
        /// FCRCE.
        FCRCE: u1,
        /// FPSE.
        FPSE: u1,
        /// FEOTPE.
        FEOTPE: u1,
        /// FLPWRE.
        FLPWRE: u1,
        /// FGCWRE.
        FGCWRE: u1,
        /// FGPWRE.
        FGPWRE: u1,
        /// FGPTXE.
        FGPTXE: u1,
        /// FGPRDE.
        FGPRDE: u1,
        /// FGPRXE.
        FGPRXE: u1,
        padding: u19 = 0,
    }),
    /// offset: 0xe0
    reserved224: [20]u8,
    /// DSI Host data lane timer read configuration register.
    /// offset: 0xf4
    DLTRCR: mmio.Mmio(packed struct(u32) {
        /// MRD_TIME.
        MRD_TIME: u15,
        padding: u17 = 0,
    }),
    /// offset: 0xf8
    reserved248: [8]u8,
    /// DSI Host video shadow control register.
    /// offset: 0x100
    VSCR: mmio.Mmio(packed struct(u32) {
        /// EN.
        EN: u1,
        reserved8: u7 = 0,
        /// UR.
        UR: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x104
    reserved260: [8]u8,
    /// DSI Host LTDC current VCID register.
    /// offset: 0x10c
    LCVCIDR: mmio.Mmio(packed struct(u32) {
        /// VCID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC current color coding register.
    /// offset: 0x110
    LCCCR: mmio.Mmio(packed struct(u32) {
        /// COLC.
        COLC: u4,
        reserved8: u4 = 0,
        /// LPE.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x114
    reserved276: [4]u8,
    /// DSI Host low-power mode current configuration register.
    /// offset: 0x118
    LPMCCR: mmio.Mmio(packed struct(u32) {
        /// VLPSIZE.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// LPSIZE.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x11c
    reserved284: [28]u8,
    /// DSI Host video mode current configuration register.
    /// offset: 0x138
    VMCCR: mmio.Mmio(packed struct(u32) {
        /// VMT.
        VMT: u2,
        /// LPVSAE.
        LPVSAE: u1,
        /// LPVBPE.
        LPVBPE: u1,
        /// LPVFPE.
        LPVFPE: u1,
        /// LPVAE.
        LPVAE: u1,
        /// LPHBPE.
        LPHBPE: u1,
        /// LPHFE.
        LPHFE: u1,
        /// FBTAAE.
        FBTAAE: u1,
        /// LPCE.
        LPCE: u1,
        padding: u22 = 0,
    }),
    /// DSI Host video packet current configuration register.
    /// offset: 0x13c
    VPCCR: mmio.Mmio(packed struct(u32) {
        /// VPSIZE.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host video chunks current configuration register.
    /// offset: 0x140
    VCCCR: mmio.Mmio(packed struct(u32) {
        /// NUMC.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video null packet current configuration register.
    /// offset: 0x144
    VNPCCR: mmio.Mmio(packed struct(u32) {
        /// NPSIZE.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host video HSA current configuration register.
    /// offset: 0x148
    VHSACCR: mmio.Mmio(packed struct(u32) {
        /// HSA.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video HBP current configuration register.
    /// offset: 0x14c
    VHBPCCR: mmio.Mmio(packed struct(u32) {
        /// HBP.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host video line current configuration register.
    /// offset: 0x150
    VLCCR: mmio.Mmio(packed struct(u32) {
        /// HLINE.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host video VSA current configuration register.
    /// offset: 0x154
    VVSACCR: mmio.Mmio(packed struct(u32) {
        /// VSA.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VBP current configuration register.
    /// offset: 0x158
    VVBPCCR: mmio.Mmio(packed struct(u32) {
        /// VBP.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VFP current configuration register.
    /// offset: 0x15c
    VVFPCCR: mmio.Mmio(packed struct(u32) {
        /// VFP.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host video VA current configuration register.
    /// offset: 0x160
    VVACCR: mmio.Mmio(packed struct(u32) {
        /// VA.
        VA: u14,
        padding: u18 = 0,
    }),
    /// offset: 0x164
    reserved356: [668]u8,
    /// DSI wrapper configuration register.
    /// offset: 0x400
    WCFGR: mmio.Mmio(packed struct(u32) {
        /// DSIM.
        DSIM: u1,
        /// COLMUX.
        COLMUX: u3,
        /// TESRC.
        TESRC: u1,
        /// TEPOL.
        TEPOL: u1,
        /// AR.
        AR: u1,
        /// VSPOL.
        VSPOL: u1,
        padding: u24 = 0,
    }),
    /// DSI wrapper control register.
    /// offset: 0x404
    WCR: mmio.Mmio(packed struct(u32) {
        /// COLM.
        COLM: u1,
        /// SHTDN.
        SHTDN: u1,
        /// LTDCEN.
        LTDCEN: u1,
        /// DSIEN.
        DSIEN: u1,
        padding: u28 = 0,
    }),
    /// DSI wrapper interrupt enable register.
    /// offset: 0x408
    WIER: mmio.Mmio(packed struct(u32) {
        /// TEIE.
        TEIE: u1,
        /// ERIE.
        ERIE: u1,
        reserved9: u7 = 0,
        /// PLLLIE.
        PLLLIE: u1,
        /// PLLUIE.
        PLLUIE: u1,
        reserved13: u2 = 0,
        /// RRIE.
        RRIE: u1,
        padding: u18 = 0,
    }),
    /// DSI wrapper interrupt and status register.
    /// offset: 0x40c
    WISR: mmio.Mmio(packed struct(u32) {
        /// TEIF.
        TEIF: u1,
        /// ERIF.
        ERIF: u1,
        /// BUSY.
        BUSY: u1,
        reserved8: u5 = 0,
        /// PLLLS.
        PLLLS: u1,
        /// PLLLIF.
        PLLLIF: u1,
        /// PLLUIF.
        PLLUIF: u1,
        reserved12: u1 = 0,
        /// RRS.
        RRS: u1,
        /// RRIF.
        RRIF: u1,
        padding: u18 = 0,
    }),
    /// DSI wrapper interrupt flag clear register.
    /// offset: 0x410
    WIFCR: mmio.Mmio(packed struct(u32) {
        /// CTEIF.
        CTEIF: u1,
        /// CERIF.
        CERIF: u1,
        reserved9: u7 = 0,
        /// CPLLLIF.
        CPLLLIF: u1,
        /// CPLLUIF.
        CPLLUIF: u1,
        reserved13: u2 = 0,
        /// CRRIF.
        CRRIF: u1,
        padding: u18 = 0,
    }),
    /// offset: 0x414
    reserved1044: [4]u8,
    /// DSI wrapper PHY configuration register 0.
    /// offset: 0x418
    WPCR0: mmio.Mmio(packed struct(u32) {
        /// UIX4.
        UIX4: u6,
        /// SWCL.
        SWCL: u1,
        /// SWDL0.
        SWDL0: u1,
        /// SWDL1.
        SWDL1: u1,
        /// HSICL.
        HSICL: u1,
        /// HSIDL0.
        HSIDL0: u1,
        /// HSIDL1.
        HSIDL1: u1,
        /// FTXSMCL.
        FTXSMCL: u1,
        /// FTXSMDL.
        FTXSMDL: u1,
        /// CDOFFDL.
        CDOFFDL: u1,
        reserved16: u1 = 0,
        /// TDDL.
        TDDL: u1,
        padding: u15 = 0,
    }),
    /// This register shall be programmed only when DSI is stopped (CR. DSIEN=0 and CR.EN = 0).
    /// offset: 0x41c
    WPCR1: mmio.Mmio(packed struct(u32) {
        /// SKEWCL.
        SKEWCL: u2,
        /// SKEWDL.
        SKEWDL: u2,
        reserved6: u2 = 0,
        /// LPTXSRCL.
        LPTXSRCL: u2,
        /// LPTXSRDL.
        LPTXSRDL: u2,
        reserved12: u2 = 0,
        /// SDDCCL.
        SDDCCL: u1,
        /// SDDCDL.
        SDDCDL: u1,
        reserved16: u2 = 0,
        /// HSTXSRUCL.
        HSTXSRUCL: u1,
        /// HSTXSRDCL.
        HSTXSRDCL: u1,
        /// HSTXSRUDL.
        HSTXSRUDL: u1,
        /// HSTXSRDDL.
        HSTXSRDDL: u1,
        padding: u12 = 0,
    }),
    /// offset: 0x420
    reserved1056: [16]u8,
    /// DSI wrapper regulator and PLL control register.
    /// offset: 0x430
    WRPCR: mmio.Mmio(packed struct(u32) {
        /// PLLEN.
        PLLEN: u1,
        reserved2: u1 = 0,
        /// NDIV.
        NDIV: u7,
        reserved11: u2 = 0,
        /// IDF.
        IDF: u4,
        reserved16: u1 = 0,
        /// ODF.
        ODF: u2,
        reserved24: u6 = 0,
        /// REGEN.
        REGEN: u1,
        reserved28: u3 = 0,
        /// BGREN.
        BGREN: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x434
    reserved1076: [956]u8,
    /// DSI Host hardware configuration register.
    /// offset: 0x7f0
    HWCFGR: mmio.Mmio(packed struct(u32) {
        /// TECHNO.
        TECHNO: u4,
        /// FIFOSIZE.
        FIFOSIZE: u12,
        padding: u16 = 0,
    }),
    /// DSI Host version register.
    /// offset: 0x7f4
    VERR: mmio.Mmio(packed struct(u32) {
        /// MINREV.
        MINREV: u4,
        /// MAJREV.
        MAJREV: u4,
        padding: u24 = 0,
    }),
    /// DSI Host identification register.
    /// offset: 0x7f8
    IPIDR: mmio.Mmio(packed struct(u32) {
        /// ID.
        ID: u32,
    }),
    /// DSI Host size identification register.
    /// offset: 0x7fc
    SIDR: mmio.Mmio(packed struct(u32) {
        /// SID.
        SID: u32,
    }),
};
