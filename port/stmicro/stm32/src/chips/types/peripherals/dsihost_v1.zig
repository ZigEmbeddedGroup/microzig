const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// DSI Host.
pub const DSIHOST = extern struct {
    /// DSI Host Version Register.
    /// offset: 0x00
    VR: mmio.Mmio(packed struct(u32) {
        /// Version of the DSI Host.
        VERSION: u32,
    }),
    /// DSI Host Control Register.
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Enable.
        EN: u1,
        padding: u31 = 0,
    }),
    /// DSI HOST Clock Control Register.
    /// offset: 0x08
    CCR: mmio.Mmio(packed struct(u32) {
        /// TX Escape Clock Division.
        TXECKDIV: u8,
        /// Timeout Clock Division.
        TOCKDIV: u8,
        padding: u16 = 0,
    }),
    /// DSI Host LTDC VCID Register.
    /// offset: 0x0c
    LVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual Channel ID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC Color Coding Register.
    /// offset: 0x10
    LCOLCR: mmio.Mmio(packed struct(u32) {
        /// Color Coding.
        COLC: u4,
        reserved8: u4 = 0,
        /// Loosely Packet Enable.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// DSI Host LTDC Polarity Configuration Register.
    /// offset: 0x14
    LPCR: mmio.Mmio(packed struct(u32) {
        /// Data Enable Polarity.
        DEP: u1,
        /// VSYNC Polarity.
        VSP: u1,
        /// HSYNC Polarity.
        HSP: u1,
        padding: u29 = 0,
    }),
    /// DSI Host Low-Power mode Configuration Register.
    /// offset: 0x18
    LPMCR: mmio.Mmio(packed struct(u32) {
        /// VACT Largest Packet Size.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// Largest Packet Size.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x1c
    reserved28: [16]u8,
    /// DSI Host Protocol Configuration Register.
    /// offset: 0x2c
    PCR: mmio.Mmio(packed struct(u32) {
        /// EoTp Transmission Enable.
        ETTXE: u1,
        /// EoTp Reception Enable.
        ETRXE: u1,
        /// Bus Turn Around Enable.
        BTAE: u1,
        /// ECC Reception Enable.
        ECCRXE: u1,
        /// CRC Reception Enable.
        CRCRXE: u1,
        padding: u27 = 0,
    }),
    /// DSI Host Generic VCID Register.
    /// offset: 0x30
    GVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual Channel ID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host mode Configuration Register.
    /// offset: 0x34
    MCR: mmio.Mmio(packed struct(u32) {
        /// Command mode.
        CMDM: u1,
        padding: u31 = 0,
    }),
    /// DSI Host Video mode Configuration Register.
    /// offset: 0x38
    VMCR: mmio.Mmio(packed struct(u32) {
        /// Video mode Type.
        VMT: u2,
        reserved8: u6 = 0,
        /// Low-Power Vertical Sync Active Enable.
        LPVSAE: u1,
        /// Low-power Vertical Back-Porch Enable.
        LPVBPE: u1,
        /// Low-power Vertical Front-porch Enable.
        LPVFPE: u1,
        /// Low-Power Vertical Active Enable.
        LPVAE: u1,
        /// Low-Power Horizontal Back-Porch Enable.
        LPHBPE: u1,
        /// Low-Power Horizontal Front-Porch Enable.
        LPHFPE: u1,
        /// Frame Bus-Turn-Around Acknowledge Enable.
        FBTAAE: u1,
        /// Low-Power Command Enable.
        LPCE: u1,
        /// Pattern Generator Enable.
        PGE: u1,
        reserved20: u3 = 0,
        /// Pattern Generator mode.
        PGM: u1,
        reserved24: u3 = 0,
        /// Pattern Generator Orientation.
        PGO: u1,
        padding: u7 = 0,
    }),
    /// DSI Host Video Packet Configuration Register.
    /// offset: 0x3c
    VPCR: mmio.Mmio(packed struct(u32) {
        /// Video Packet Size.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host Video Chunks Configuration Register.
    /// offset: 0x40
    VCCR: mmio.Mmio(packed struct(u32) {
        /// Number of Chunks.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host Video Null Packet Configuration Register.
    /// offset: 0x44
    VNPCR: mmio.Mmio(packed struct(u32) {
        /// Null Packet Size.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host Video HSA Configuration Register.
    /// offset: 0x48
    VHSACR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Synchronism Active duration.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host Video HBP Configuration Register.
    /// offset: 0x4c
    VHBPCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Back-Porch duration.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host Video Line Configuration Register.
    /// offset: 0x50
    VLCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Line duration.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host Video VSA Configuration Register.
    /// offset: 0x54
    VVSACR: mmio.Mmio(packed struct(u32) {
        /// Vertical Synchronism Active duration.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VBP Configuration Register.
    /// offset: 0x58
    VVBPCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Back-Porch duration.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VFP Configuration Register.
    /// offset: 0x5c
    VVFPCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Front-Porch duration.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VA Configuration Register.
    /// offset: 0x60
    VVACR: mmio.Mmio(packed struct(u32) {
        /// Vertical Active duration.
        VA: u14,
        padding: u18 = 0,
    }),
    /// DSI Host LTDC Command Configuration Register.
    /// offset: 0x64
    LCCR: mmio.Mmio(packed struct(u32) {
        /// Command Size.
        CMDSIZE: u16,
        padding: u16 = 0,
    }),
    /// DSI Host Command mode Configuration Register.
    /// offset: 0x68
    CMCR: mmio.Mmio(packed struct(u32) {
        /// Tearing Effect Acknowledge Request Enable.
        TEARE: u1,
        /// Acknowledge Request Enable.
        ARE: u1,
        reserved8: u6 = 0,
        /// Generic Short Write Zero parameters Transmission.
        GSW0TX: u1,
        /// Generic Short Write One parameters Transmission.
        GSW1TX: u1,
        /// Generic Short Write Two parameters Transmission.
        GSW2TX: u1,
        /// Generic Short Read Zero parameters Transmission.
        GSR0TX: u1,
        /// Generic Short Read One parameters Transmission.
        GSR1TX: u1,
        /// Generic Short Read Two parameters Transmission.
        GSR2TX: u1,
        /// Generic Long Write Transmission.
        GLWTX: u1,
        reserved16: u1 = 0,
        /// DCS Short Write Zero parameter Transmission.
        DSW0TX: u1,
        /// DCS Short Read One parameter Transmission.
        DSW1TX: u1,
        /// DCS Short Read Zero parameter Transmission.
        DSR0TX: u1,
        /// DCS Long Write Transmission.
        DLWTX: u1,
        reserved24: u4 = 0,
        /// Maximum Read Packet Size.
        MRDPS: u1,
        padding: u7 = 0,
    }),
    /// DSI Host Generic Header Configuration Register.
    /// offset: 0x6c
    GHCR: mmio.Mmio(packed struct(u32) {
        /// Type.
        DT: u6,
        /// Channel.
        VCID: u2,
        /// WordCount LSB.
        WCLSB: u8,
        /// WordCount MSB.
        WCMSB: u8,
        padding: u8 = 0,
    }),
    /// DSI Host Generic Payload Data Register.
    /// offset: 0x70
    GPDR: mmio.Mmio(packed struct(u32) {
        /// Payload Byte 1.
        DATA1: u8,
        /// Payload Byte 2.
        DATA2: u8,
        /// Payload Byte 3.
        DATA3: u8,
        /// Payload Byte 4.
        DATA4: u8,
    }),
    /// DSI Host Generic Packet Status Register.
    /// offset: 0x74
    GPSR: mmio.Mmio(packed struct(u32) {
        /// Command FIFO Empty.
        CMDFE: u1,
        /// Command FIFO Full.
        CMDFF: u1,
        /// Payload Write FIFO Empty.
        PWRFE: u1,
        /// Payload Write FIFO Full.
        PWRFF: u1,
        /// Payload Read FIFO Empty.
        PRDFE: u1,
        /// Payload Read FIFO Full.
        PRDFF: u1,
        /// Read Command Busy.
        RCB: u1,
        padding: u25 = 0,
    }),
    /// DSI Host Timeout Counter Configuration Register 0.
    /// offset: 0x78
    TCCR0: mmio.Mmio(packed struct(u32) {
        /// Low-power Reception Timeout Counter.
        LPRX_TOCNT: u16,
        /// High-Speed Transmission Timeout Counter.
        HSTX_TOCNT: u16,
    }),
    /// DSI Host Timeout Counter Configuration Register 1.
    /// offset: 0x7c
    TCCR1: mmio.Mmio(packed struct(u32) {
        /// High-Speed Read Timeout Counter.
        HSRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host Timeout Counter Configuration Register 2.
    /// offset: 0x80
    TCCR2: mmio.Mmio(packed struct(u32) {
        /// Low-Power Read Timeout Counter.
        LPRD_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host Timeout Counter Configuration Register 3.
    /// offset: 0x84
    TCCR3: mmio.Mmio(packed struct(u32) {
        /// High-Speed Write Timeout Counter.
        HSWR_TOCNT: u16,
        reserved24: u8 = 0,
        /// Presp mode.
        PM: u1,
        padding: u7 = 0,
    }),
    /// DSI Host Timeout Counter Configuration Register 4.
    /// offset: 0x88
    TCCR4: mmio.Mmio(packed struct(u32) {
        /// Low-Power Write Timeout Counter.
        LSWR_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// DSI Host Timeout Counter Configuration Register 5.
    /// offset: 0x8c
    TCCR5: mmio.Mmio(packed struct(u32) {
        /// Bus-Turn-Around Timeout Counter.
        BTA_TOCNT: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// DSI Host Clock Lane Configuration Register.
    /// offset: 0x94
    CLCR: mmio.Mmio(packed struct(u32) {
        /// D-PHY Clock Control.
        DPCC: u1,
        /// Automatic Clock lane Control.
        ACR: u1,
        padding: u30 = 0,
    }),
    /// DSI Host Clock Lane Timer Configuration Register.
    /// offset: 0x98
    CLTCR: mmio.Mmio(packed struct(u32) {
        /// Low-Power to High-Speed Time.
        LP2HS_TIME: u10,
        reserved16: u6 = 0,
        /// High-Speed to Low-Power Time.
        HS2LP_TIME: u10,
        padding: u6 = 0,
    }),
    /// DSI Host Data Lane Timer Configuration Register.
    /// offset: 0x9c
    DLTCR: mmio.Mmio(packed struct(u32) {
        /// Maximum Read Time.
        MRD_TIME: u15,
        reserved16: u1 = 0,
        /// Low-Power To High-Speed Time.
        LP2HS_TIME: u8,
        /// High-Speed To Low-Power Time.
        HS2LP_TIME: u8,
    }),
    /// DSI Host PHY Control Register.
    /// offset: 0xa0
    PCTLR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Digital Enable.
        DEN: u1,
        /// Clock Enable.
        CKE: u1,
        padding: u29 = 0,
    }),
    /// DSI Host PHY Configuration Register.
    /// offset: 0xa4
    PCONFR: mmio.Mmio(packed struct(u32) {
        /// Number of Lanes.
        NL: u2,
        reserved8: u6 = 0,
        /// Stop Wait Time.
        SW_TIME: u8,
        padding: u16 = 0,
    }),
    /// DSI Host PHY ULPS Control Register.
    /// offset: 0xa8
    PUCR: mmio.Mmio(packed struct(u32) {
        /// ULPS Request on Clock Lane.
        URCL: u1,
        /// ULPS Exit on Clock Lane.
        UECL: u1,
        /// ULPS Request on Data Lane.
        URDL: u1,
        /// ULPS Exit on Data Lane.
        UEDL: u1,
        padding: u28 = 0,
    }),
    /// DSI Host PHY TX Triggers Configuration Register.
    /// offset: 0xac
    PTTCR: mmio.Mmio(packed struct(u32) {
        /// Transmission Trigger.
        TX_TRIG: u4,
        padding: u28 = 0,
    }),
    /// DSI Host PHY Status Register.
    /// offset: 0xb0
    PSR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PHY Direction.
        PD: u1,
        /// PHY Stop State Clock lane.
        PSSC: u1,
        /// ULPS Active Not Clock lane.
        UANC: u1,
        /// PHY Stop State lane 0.
        PSS0: u1,
        /// ULPS Active Not lane 1.
        UAN0: u1,
        /// RX ULPS Escape lane 0.
        RUE0: u1,
        /// PHY Stop State lane 1.
        PSS1: u1,
        /// ULPS Active Not lane 1.
        UAN1: u1,
        padding: u23 = 0,
    }),
    /// offset: 0xb4
    reserved180: [8]u8,
    /// DSI Host Interrupt & Status Register 0.
    /// offset: 0xbc
    ISR0: mmio.Mmio(packed struct(u32) {
        /// Acknowledge Error 0.
        AE0: u1,
        /// Acknowledge Error 1.
        AE1: u1,
        /// Acknowledge Error 2.
        AE2: u1,
        /// Acknowledge Error 3.
        AE3: u1,
        /// Acknowledge Error 4.
        AE4: u1,
        /// Acknowledge Error 5.
        AE5: u1,
        /// Acknowledge Error 6.
        AE6: u1,
        /// Acknowledge Error 7.
        AE7: u1,
        /// Acknowledge Error 8.
        AE8: u1,
        /// Acknowledge Error 9.
        AE9: u1,
        /// Acknowledge Error 10.
        AE10: u1,
        /// Acknowledge Error 11.
        AE11: u1,
        /// Acknowledge Error 12.
        AE12: u1,
        /// Acknowledge Error 13.
        AE13: u1,
        /// Acknowledge Error 14.
        AE14: u1,
        /// Acknowledge Error 15.
        AE15: u1,
        /// PHY Error 0.
        PE0: u1,
        /// PHY Error 1.
        PE1: u1,
        /// PHY Error 2.
        PE2: u1,
        /// PHY Error 3.
        PE3: u1,
        /// PHY Error 4.
        PE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host Interrupt & Status Register 1.
    /// offset: 0xc0
    ISR1: mmio.Mmio(packed struct(u32) {
        /// Timeout High-Speed Transmission.
        TOHSTX: u1,
        /// Timeout Low-Power Reception.
        TOLPRX: u1,
        /// ECC Single-bit Error.
        ECCSE: u1,
        /// ECC Multi-bit Error.
        ECCME: u1,
        /// CRC Error.
        CRCE: u1,
        /// Packet Size Error.
        PSE: u1,
        /// EoTp Error.
        EOTPE: u1,
        /// LTDC Payload Write Error.
        LPWRE: u1,
        /// Generic Command Write Error.
        GCWRE: u1,
        /// Generic Payload Write Error.
        GPWRE: u1,
        /// Generic Payload Transmit Error.
        GPTXE: u1,
        /// Generic Payload Read Error.
        GPRDE: u1,
        /// Generic Payload Receive Error.
        GPRXE: u1,
        padding: u19 = 0,
    }),
    /// DSI Host Interrupt Enable Register 0.
    /// offset: 0xc4
    IER0: mmio.Mmio(packed struct(u32) {
        /// Acknowledge Error 0 Interrupt Enable.
        AE0IE: u1,
        /// Acknowledge Error 1 Interrupt Enable.
        AE1IE: u1,
        /// Acknowledge Error 2 Interrupt Enable.
        AE2IE: u1,
        /// Acknowledge Error 3 Interrupt Enable.
        AE3IE: u1,
        /// Acknowledge Error 4 Interrupt Enable.
        AE4IE: u1,
        /// Acknowledge Error 5 Interrupt Enable.
        AE5IE: u1,
        /// Acknowledge Error 6 Interrupt Enable.
        AE6IE: u1,
        /// Acknowledge Error 7 Interrupt Enable.
        AE7IE: u1,
        /// Acknowledge Error 8 Interrupt Enable.
        AE8IE: u1,
        /// Acknowledge Error 9 Interrupt Enable.
        AE9IE: u1,
        /// Acknowledge Error 10 Interrupt Enable.
        AE10IE: u1,
        /// Acknowledge Error 11 Interrupt Enable.
        AE11IE: u1,
        /// Acknowledge Error 12 Interrupt Enable.
        AE12IE: u1,
        /// Acknowledge Error 13 Interrupt Enable.
        AE13IE: u1,
        /// Acknowledge Error 14 Interrupt Enable.
        AE14IE: u1,
        /// Acknowledge Error 15 Interrupt Enable.
        AE15IE: u1,
        /// PHY Error 0 Interrupt Enable.
        PE0IE: u1,
        /// PHY Error 1 Interrupt Enable.
        PE1IE: u1,
        /// PHY Error 2 Interrupt Enable.
        PE2IE: u1,
        /// PHY Error 3 Interrupt Enable.
        PE3IE: u1,
        /// PHY Error 4 Interrupt Enable.
        PE4IE: u1,
        padding: u11 = 0,
    }),
    /// DSI Host Interrupt Enable Register 1.
    /// offset: 0xc8
    IER1: mmio.Mmio(packed struct(u32) {
        /// Timeout High-Speed Transmission Interrupt Enable.
        TOHSTXIE: u1,
        /// Timeout Low-Power Reception Interrupt Enable.
        TOLPRXIE: u1,
        /// ECC Single-bit Error Interrupt Enable.
        ECCSEIE: u1,
        /// ECC Multi-bit Error Interrupt Enable.
        ECCMEIE: u1,
        /// CRC Error Interrupt Enable.
        CRCEIE: u1,
        /// Packet Size Error Interrupt Enable.
        PSEIE: u1,
        /// EoTp Error Interrupt Enable.
        EOTPEIE: u1,
        /// LTDC Payload Write Error Interrupt Enable.
        LPWREIE: u1,
        /// Generic Command Write Error Interrupt Enable.
        GCWREIE: u1,
        /// Generic Payload Write Error Interrupt Enable.
        GPWREIE: u1,
        /// Generic Payload Transmit Error Interrupt Enable.
        GPTXEIE: u1,
        /// Generic Payload Read Error Interrupt Enable.
        GPRDEIE: u1,
        /// Generic Payload Receive Error Interrupt Enable.
        GPRXEIE: u1,
        padding: u19 = 0,
    }),
    /// offset: 0xcc
    reserved204: [12]u8,
    /// DSI Host Force Interrupt Register 0.
    /// offset: 0xd8
    FIR0: mmio.Mmio(packed struct(u32) {
        /// Force Acknowledge Error 0.
        FAE0: u1,
        /// Force Acknowledge Error 1.
        FAE1: u1,
        /// Force Acknowledge Error 2.
        FAE2: u1,
        /// Force Acknowledge Error 3.
        FAE3: u1,
        /// Force Acknowledge Error 4.
        FAE4: u1,
        /// Force Acknowledge Error 5.
        FAE5: u1,
        /// Force Acknowledge Error 6.
        FAE6: u1,
        /// Force Acknowledge Error 7.
        FAE7: u1,
        /// Force Acknowledge Error 8.
        FAE8: u1,
        /// Force Acknowledge Error 9.
        FAE9: u1,
        /// Force Acknowledge Error 10.
        FAE10: u1,
        /// Force Acknowledge Error 11.
        FAE11: u1,
        /// Force Acknowledge Error 12.
        FAE12: u1,
        /// Force Acknowledge Error 13.
        FAE13: u1,
        /// Force Acknowledge Error 14.
        FAE14: u1,
        /// Force Acknowledge Error 15.
        FAE15: u1,
        /// Force PHY Error 0.
        FPE0: u1,
        /// Force PHY Error 1.
        FPE1: u1,
        /// Force PHY Error 2.
        FPE2: u1,
        /// Force PHY Error 3.
        FPE3: u1,
        /// Force PHY Error 4.
        FPE4: u1,
        padding: u11 = 0,
    }),
    /// DSI Host Force Interrupt Register 1.
    /// offset: 0xdc
    FIR1: mmio.Mmio(packed struct(u32) {
        /// Force Timeout High-Speed Transmission.
        FTOHSTX: u1,
        /// Force Timeout Low-Power Reception.
        FTOLPRX: u1,
        /// Force ECC Single-bit Error.
        FECCSE: u1,
        /// Force ECC Multi-bit Error.
        FECCME: u1,
        /// Force CRC Error.
        FCRCE: u1,
        /// Force Packet Size Error.
        FPSE: u1,
        /// Force EoTp Error.
        FEOTPE: u1,
        /// Force LTDC Payload Write Error.
        FLPWRE: u1,
        /// Force Generic Command Write Error.
        FGCWRE: u1,
        /// Force Generic Payload Write Error.
        FGPWRE: u1,
        /// Force Generic Payload Transmit Error.
        FGPTXE: u1,
        /// Force Generic Payload Read Error.
        FGPRDE: u1,
        /// Force Generic Payload Receive Error.
        FGPRXE: u1,
        padding: u19 = 0,
    }),
    /// offset: 0xe0
    reserved224: [32]u8,
    /// DSI Host Video Shadow Control Register.
    /// offset: 0x100
    VSCR: mmio.Mmio(packed struct(u32) {
        /// Enable.
        EN: u1,
        reserved8: u7 = 0,
        /// Update Register.
        UR: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x104
    reserved260: [8]u8,
    /// DSI Host LTDC Current VCID Register.
    /// offset: 0x10c
    LCVCIDR: mmio.Mmio(packed struct(u32) {
        /// Virtual Channel ID.
        VCID: u2,
        padding: u30 = 0,
    }),
    /// DSI Host LTDC Current Color Coding Register.
    /// offset: 0x110
    LCCCR: mmio.Mmio(packed struct(u32) {
        /// Color Coding.
        COLC: u4,
        reserved8: u4 = 0,
        /// Loosely Packed Enable.
        LPE: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x114
    reserved276: [4]u8,
    /// DSI Host Low-Power mode Current Configuration Register.
    /// offset: 0x118
    LPMCCR: mmio.Mmio(packed struct(u32) {
        /// VACT Largest Packet Size.
        VLPSIZE: u8,
        reserved16: u8 = 0,
        /// Largest Packet Size.
        LPSIZE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x11c
    reserved284: [28]u8,
    /// DSI Host Video mode Current Configuration Register.
    /// offset: 0x138
    VMCCR: mmio.Mmio(packed struct(u32) {
        /// Video mode Type.
        VMT: u2,
        /// Low-Power Vertical Sync time Enable.
        LPVSAE: u1,
        /// Low-power Vertical Back-Porch Enable.
        LPVBPE: u1,
        /// Low-power Vertical Front-Porch Enable.
        LPVFPE: u1,
        /// Low-Power Vertical Active Enable.
        LPVAE: u1,
        /// Low-power Horizontal Back-Porch Enable.
        LPHBPE: u1,
        /// Low-Power Horizontal Front-Porch Enable.
        LPHFE: u1,
        /// Frame BTA Acknowledge Enable.
        FBTAAE: u1,
        /// Low-Power Command Enable.
        LPCE: u1,
        padding: u22 = 0,
    }),
    /// DSI Host Video Packet Current Configuration Register.
    /// offset: 0x13c
    VPCCR: mmio.Mmio(packed struct(u32) {
        /// Video Packet Size.
        VPSIZE: u14,
        padding: u18 = 0,
    }),
    /// DSI Host Video Chunks Current Configuration Register.
    /// offset: 0x140
    VCCCR: mmio.Mmio(packed struct(u32) {
        /// Number of Chunks.
        NUMC: u13,
        padding: u19 = 0,
    }),
    /// DSI Host Video Null Packet Current Configuration Register.
    /// offset: 0x144
    VNPCCR: mmio.Mmio(packed struct(u32) {
        /// Null Packet Size.
        NPSIZE: u13,
        padding: u19 = 0,
    }),
    /// DSI Host Video HSA Current Configuration Register.
    /// offset: 0x148
    VHSACCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Synchronism Active duration.
        HSA: u12,
        padding: u20 = 0,
    }),
    /// DSI Host Video HBP Current Configuration Register.
    /// offset: 0x14c
    VHBPCCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Back-Porch duration.
        HBP: u12,
        padding: u20 = 0,
    }),
    /// DSI Host Video Line Current Configuration Register.
    /// offset: 0x150
    VLCCR: mmio.Mmio(packed struct(u32) {
        /// Horizontal Line duration.
        HLINE: u15,
        padding: u17 = 0,
    }),
    /// DSI Host Video VSA Current Configuration Register.
    /// offset: 0x154
    VVSACCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Synchronism Active duration.
        VSA: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VBP Current Configuration Register.
    /// offset: 0x158
    VVBPCCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Back-Porch duration.
        VBP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VFP Current Configuration Register.
    /// offset: 0x15c
    VVFPCCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Front-Porch duration.
        VFP: u10,
        padding: u22 = 0,
    }),
    /// DSI Host Video VA Current Configuration Register.
    /// offset: 0x160
    VVACCR: mmio.Mmio(packed struct(u32) {
        /// Vertical Active duration.
        VA: u14,
        padding: u18 = 0,
    }),
    /// offset: 0x164
    reserved356: [668]u8,
    /// DSI Wrapper Configuration Register.
    /// offset: 0x400
    WCFGR: mmio.Mmio(packed struct(u32) {
        /// DSI Mode.
        DSIM: u1,
        /// Color Multiplexing.
        COLMUX: u3,
        /// TE Source.
        TESRC: u1,
        /// TE Polarity.
        TEPOL: u1,
        /// Automatic Refresh.
        AR: u1,
        /// VSync Polarity.
        VSPOL: u1,
        padding: u24 = 0,
    }),
    /// DSI Wrapper Control Register.
    /// offset: 0x404
    WCR: mmio.Mmio(packed struct(u32) {
        /// Color Mode.
        COLM: u1,
        /// Shutdown.
        SHTDN: u1,
        /// LTDC Enable.
        LTDCEN: u1,
        /// DSI Enable.
        DSIEN: u1,
        padding: u28 = 0,
    }),
    /// DSI Wrapper Interrupt Enable Register.
    /// offset: 0x408
    WIER: mmio.Mmio(packed struct(u32) {
        /// Tearing Effect Interrupt Enable.
        TEIE: u1,
        /// End of Refresh Interrupt Enable.
        ERIE: u1,
        reserved9: u7 = 0,
        /// PLL Lock Interrupt Enable.
        PLLLIE: u1,
        /// PLL Unlock Interrupt Enable.
        PLLUIE: u1,
        reserved13: u2 = 0,
        /// Regulator Ready Interrupt Enable.
        RRIE: u1,
        padding: u18 = 0,
    }),
    /// DSI Wrapper Interrupt & Status Register.
    /// offset: 0x40c
    WISR: mmio.Mmio(packed struct(u32) {
        /// Tearing Effect Interrupt Flag.
        TEIF: u1,
        /// End of Refresh Interrupt Flag.
        ERIF: u1,
        /// Busy Flag.
        BUSY: u1,
        reserved8: u5 = 0,
        /// PLL Lock Status.
        PLLLS: u1,
        /// PLL Lock Interrupt Flag.
        PLLLIF: u1,
        /// PLL Unlock Interrupt Flag.
        PLLUIF: u1,
        reserved12: u1 = 0,
        /// Regulator Ready Status.
        RRS: u1,
        /// Regulator Ready Interrupt Flag.
        RRIF: u1,
        padding: u18 = 0,
    }),
    /// DSI Wrapper Interrupt Flag Clear Register.
    /// offset: 0x410
    WIFCR: mmio.Mmio(packed struct(u32) {
        /// Clear Tearing Effect Interrupt Flag.
        CTEIF: u1,
        /// Clear End of Refresh Interrupt Flag.
        CERIF: u1,
        reserved9: u7 = 0,
        /// Clear PLL Lock Interrupt Flag.
        CPLLLIF: u1,
        /// Clear PLL Unlock Interrupt Flag.
        CPLLUIF: u1,
        reserved13: u2 = 0,
        /// Clear Regulator Ready Interrupt Flag.
        CRRIF: u1,
        padding: u18 = 0,
    }),
    /// offset: 0x414
    reserved1044: [4]u8,
    /// DSI Wrapper PHY Configuration Register 0.
    /// offset: 0x418
    WPCR0: mmio.Mmio(packed struct(u32) {
        /// Unit Interval multiplied by 4.
        UIX4: u6,
        /// Swap Clock Lane pins.
        SWCL: u1,
        /// Swap Data Lane 0 pins.
        SWDL0: u1,
        /// Swap Data Lane 1 pins.
        SWDL1: u1,
        /// Invert Hight-Speed data signal on Clock Lane.
        HSICL: u1,
        /// Invert the Hight-Speed data signal on Data Lane 0.
        HSIDL0: u1,
        /// Invert the High-Speed data signal on Data Lane 1.
        HSIDL1: u1,
        /// Force in TX Stop Mode the Clock Lane.
        FTXSMCL: u1,
        /// Force in TX Stop Mode the Data Lanes.
        FTXSMDL: u1,
        /// Contention Detection OFF on Data Lanes.
        CDOFFDL: u1,
        reserved16: u1 = 0,
        /// Turn Disable Data Lanes.
        TDDL: u1,
        reserved18: u1 = 0,
        /// Pull-Down Enable.
        PDEN: u1,
        /// custom time for tCLK-PREPARE Enable.
        TCLKPREPEN: u1,
        /// custom time for tCLK-ZERO Enable.
        TCLKZEROEN: u1,
        /// custom time for tHS-PREPARE Enable.
        THSPREPEN: u1,
        /// custom time for tHS-TRAIL Enable.
        THSTRAILEN: u1,
        /// custom time for tHS-ZERO Enable.
        THSZEROEN: u1,
        /// custom time for tLPX for Data lanes Enable.
        TLPXDEN: u1,
        /// custom time for tHS-EXIT Enable.
        THSEXITEN: u1,
        /// custom time for tLPX for Clock lane Enable.
        TLPXCEN: u1,
        /// custom time for tCLK-POST Enable.
        TCLKPOSTEN: u1,
        padding: u4 = 0,
    }),
    /// DSI Wrapper PHY Configuration Register 1.
    /// offset: 0x41c
    WPCR1: mmio.Mmio(packed struct(u32) {
        /// High-Speed Transmission Delay on Clock Lane.
        HSTXDCL: u2,
        /// High-Speed Transmission Delay on Data Lanes.
        HSTXDLL: u2,
        reserved6: u2 = 0,
        /// Low-Power transmission Slew Rate Compensation on Clock Lane.
        LPSRCL: u2,
        /// Low-Power transmission Slew Rate Compensation on Data Lanes.
        LPSRDL: u2,
        reserved12: u2 = 0,
        /// SDD Control.
        SDCC: u1,
        reserved16: u3 = 0,
        /// High-Speed Transmission Slew Rate Control on Clock Lane.
        HSTXSRCCL: u2,
        /// High-Speed Transmission Slew Rate Control on Data Lanes.
        HSTXSRCDL: u2,
        reserved22: u2 = 0,
        /// Forces LP Receiver in Low-Power Mode.
        FLPRXLPM: u1,
        reserved25: u2 = 0,
        /// Low-Power RX low-pass Filtering Tuning.
        LPRXFT: u2,
        padding: u5 = 0,
    }),
    /// DSI Wrapper PHY Configuration Register 2.
    /// offset: 0x420
    WPCR2: mmio.Mmio(packed struct(u32) {
        /// tCLK-PREPARE.
        TCLKPREP: u8,
        /// tCLK-ZERO.
        TCLKZEO: u8,
        /// tHS-PREPARE.
        THSPREP: u8,
        /// tHSTRAIL.
        THSTRAIL: u8,
    }),
    /// DSI Wrapper PHY Configuration Register 3.
    /// offset: 0x424
    WPCR3: mmio.Mmio(packed struct(u32) {
        /// tHS-ZERO.
        THSZERO: u8,
        /// tLPX for Data lanes.
        TLPXD: u8,
        /// tHSEXIT.
        THSEXIT: u8,
        /// tLPXC for Clock lane.
        TLPXC: u8,
    }),
    /// DSI Wrapper PHY Configuration Register 4.
    /// offset: 0x428
    WPCR4: mmio.Mmio(packed struct(u32) {
        /// tCLK-POST.
        TCLKPOST: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x42c
    reserved1068: [4]u8,
    /// DSI Wrapper Regulator and PLL Control Register.
    /// offset: 0x430
    WRPCR: mmio.Mmio(packed struct(u32) {
        /// PLL Enable.
        PLLEN: u1,
        reserved2: u1 = 0,
        /// PLL Loop Division Factor.
        NDIV: u7,
        reserved11: u2 = 0,
        /// PLL Input Division Factor.
        IDF: u4,
        reserved16: u1 = 0,
        /// PLL Output Division Factor.
        ODF: u2,
        reserved24: u6 = 0,
        /// Regulator Enable.
        REGEN: u1,
        padding: u7 = 0,
    }),
};
