const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const LPMS = enum(u3) {
    /// Stop 0 mode
    Stop0 = 0x0,
    /// Stop 1 mode
    Stop1 = 0x1,
    /// Stop 2 mode
    Stop2 = 0x2,
    /// Standby mode
    Standby = 0x3,
    /// Shutdown mode
    Shutdown = 0x4,
    _,
};

pub const LPR = enum(u1) {
    /// Voltage regulator in Main mode
    MainMode = 0x0,
    /// Voltage regulator in low-power mode
    LowPowerMode = 0x1,
};

pub const PLS = enum(u3) {
    /// 2.0V
    V2_0 = 0x0,
    /// 2.2V
    V2_2 = 0x1,
    /// 2.4V
    V2_4 = 0x2,
    /// 2.5V
    V2_5 = 0x3,
    /// 2.6V
    V2_6 = 0x4,
    /// 2.8V
    V2_8 = 0x5,
    /// 2.9V
    V2_9 = 0x6,
    /// External input analog voltage PVD_IN (compared internally to VREFINT)
    External = 0x7,
};

pub const RRS = enum(u2) {
    /// SRAM2 powered off in Standby mode (SRAM2 content lost)
    PowerOff = 0x0,
    /// SRAM2 powered by the low-power regulator in Standby mode (SRAM2 content kept)
    OnLPR = 0x1,
    /// Only the upper 4 Kbytes of SRAM2 are powered by the low-power regulator in Standby mode (upper 4 Kbytes of SRAM2 content 0x2003 F000 - 0x2003 FFFF is kept).
    OnLPRTop4kb = 0x2,
    _,
};

pub const VOS = enum(u2) {
    /// Range 0
    Range0 = 0x0,
    /// Range 1
    Range1 = 0x1,
    /// Range 2
    Range2 = 0x2,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// Power control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection
        LPMS: LPMS,
        reserved8: u5 = 0,
        /// Disable backup domain write protection
        DBP: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        reserved14: u3 = 0,
        /// Low-power run
        LPR: LPR,
        padding: u17 = 0,
    }),
    /// Power control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Power voltage detector enable
        PVDE: u1,
        /// Power voltage detector level selection
        PLS: PLS,
        /// Peripheral voltage monitoring 1 enable: VDDUSB vs. 1.2V
        PVME1: u1,
        /// Peripheral voltage monitoring 2 enable: VDDIO2 vs. 0.9V
        PVME2: u1,
        /// Peripheral voltage monitoring 3 enable: VDDA vs. 1.62V
        PVME3: u1,
        /// Peripheral voltage monitoring 4 enable: VDDA vs. 2.2V
        PVME4: u1,
        reserved9: u1 = 0,
        /// VDDIO2 Independent I/Os supply valid
        IOSV: u1,
        /// VDDUSB USB supply valid
        USV: u1,
        padding: u21 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of EWUP) Enable Wakeup pin WKUP
        @"EWUP[0]": u1,
        /// (2/5 of EWUP) Enable Wakeup pin WKUP
        @"EWUP[1]": u1,
        /// (3/5 of EWUP) Enable Wakeup pin WKUP
        @"EWUP[2]": u1,
        /// (4/5 of EWUP) Enable Wakeup pin WKUP
        @"EWUP[3]": u1,
        /// (5/5 of EWUP) Enable Wakeup pin WKUP
        @"EWUP[4]": u1,
        reserved8: u3 = 0,
        /// SRAM2 retention in Standby mode
        RRS: RRS,
        /// Apply pull-up and pull-down configuration
        APC: u1,
        /// ULPMEN
        ULPMEN: u1,
        reserved13: u1 = 0,
        /// UCPD_STDBY
        UCPD_STDBY: u1,
        /// UCPD_DBDIS
        UCPD_DBDIS: u1,
        padding: u17 = 0,
    }),
    /// Power control register 4
    /// offset: 0x0c
    CR4: mmio.Mmio(packed struct(u32) {
        /// Wakeup pin WKUP1 polarity
        WP1: u1,
        /// Wakeup pin WKUP2 polarity
        WP2: u1,
        /// Wakeup pin WKUP3 polarity
        WP3: u1,
        /// Wakeup pin WKUP4 polarity
        WP4: u1,
        /// Wakeup pin WKUP5 polarity
        WP5: u1,
        reserved8: u3 = 0,
        /// VBAT battery charging enable
        VBE: u1,
        /// VBAT battery charging resistor selection
        VBRS: u1,
        reserved12: u2 = 0,
        /// SMPSBYP
        SMPSBYP: u1,
        /// EXTSMPSEN
        EXTSMPSEN: u1,
        /// SMPSFSTEN
        SMPSFSTEN: u1,
        /// SMPSLPEN
        SMPSLPEN: u1,
        padding: u16 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag 1
        CWUF1: u1,
        /// Wakeup flag 2
        CWUF2: u1,
        /// Wakeup flag 3
        CWUF3: u1,
        /// Wakeup flag 4
        CWUF4: u1,
        /// Wakeup flag 5
        CWUF5: u1,
        reserved8: u3 = 0,
        /// Standby flag
        CSBF: u1,
        reserved15: u6 = 0,
        /// Wakeup flag internal
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// Power status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// Low-power regulator started
        REGLPS: u1,
        /// Low-power regulator flag
        REGLPF: u1,
        /// Voltage scaling flag
        VOSF: u1,
        /// Power voltage detector output
        PVDO: u1,
        /// Peripheral voltage monitoring output: VDDUSB vs. 1.2 V
        PVMO1: u1,
        /// Peripheral voltage monitoring output: VDDIO2 vs. 0.9 V
        PVMO2: u1,
        /// Peripheral voltage monitoring output: VDDA vs. 1.62 V
        PVMO3: u1,
        /// Peripheral voltage monitoring output: VDDA vs. 2.2 V
        PVMO4: u1,
        padding: u16 = 0,
    }),
    /// Power status clear register
    /// offset: 0x18
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/5 of CWUF) Clear wakeup flag
        @"CWUF[0]": u1,
        /// (2/5 of CWUF) Clear wakeup flag
        @"CWUF[1]": u1,
        /// (3/5 of CWUF) Clear wakeup flag
        @"CWUF[2]": u1,
        /// (4/5 of CWUF) Clear wakeup flag
        @"CWUF[3]": u1,
        /// (5/5 of CWUF) Clear wakeup flag
        @"CWUF[4]": u1,
        reserved8: u3 = 0,
        /// Clear standby flag
        SBF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// Power Port A pull-up control register
    /// offset: 0x20
    PUCR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of P) Port pull bit y (y=0..15)
        @"P[0]": u1,
        /// (2/16 of P) Port pull bit y (y=0..15)
        @"P[1]": u1,
        /// (3/16 of P) Port pull bit y (y=0..15)
        @"P[2]": u1,
        /// (4/16 of P) Port pull bit y (y=0..15)
        @"P[3]": u1,
        /// (5/16 of P) Port pull bit y (y=0..15)
        @"P[4]": u1,
        /// (6/16 of P) Port pull bit y (y=0..15)
        @"P[5]": u1,
        /// (7/16 of P) Port pull bit y (y=0..15)
        @"P[6]": u1,
        /// (8/16 of P) Port pull bit y (y=0..15)
        @"P[7]": u1,
        /// (9/16 of P) Port pull bit y (y=0..15)
        @"P[8]": u1,
        /// (10/16 of P) Port pull bit y (y=0..15)
        @"P[9]": u1,
        /// (11/16 of P) Port pull bit y (y=0..15)
        @"P[10]": u1,
        /// (12/16 of P) Port pull bit y (y=0..15)
        @"P[11]": u1,
        /// (13/16 of P) Port pull bit y (y=0..15)
        @"P[12]": u1,
        /// (14/16 of P) Port pull bit y (y=0..15)
        @"P[13]": u1,
        /// (15/16 of P) Port pull bit y (y=0..15)
        @"P[14]": u1,
        /// (16/16 of P) Port pull bit y (y=0..15)
        @"P[15]": u1,
        padding: u16 = 0,
    }),
    /// Power Port A pull-down control register
    /// offset: 0x24
    PDCR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of P) Port pull bit y (y=0..15)
        @"P[0]": u1,
        /// (2/16 of P) Port pull bit y (y=0..15)
        @"P[1]": u1,
        /// (3/16 of P) Port pull bit y (y=0..15)
        @"P[2]": u1,
        /// (4/16 of P) Port pull bit y (y=0..15)
        @"P[3]": u1,
        /// (5/16 of P) Port pull bit y (y=0..15)
        @"P[4]": u1,
        /// (6/16 of P) Port pull bit y (y=0..15)
        @"P[5]": u1,
        /// (7/16 of P) Port pull bit y (y=0..15)
        @"P[6]": u1,
        /// (8/16 of P) Port pull bit y (y=0..15)
        @"P[7]": u1,
        /// (9/16 of P) Port pull bit y (y=0..15)
        @"P[8]": u1,
        /// (10/16 of P) Port pull bit y (y=0..15)
        @"P[9]": u1,
        /// (11/16 of P) Port pull bit y (y=0..15)
        @"P[10]": u1,
        /// (12/16 of P) Port pull bit y (y=0..15)
        @"P[11]": u1,
        /// (13/16 of P) Port pull bit y (y=0..15)
        @"P[12]": u1,
        /// (14/16 of P) Port pull bit y (y=0..15)
        @"P[13]": u1,
        /// (15/16 of P) Port pull bit y (y=0..15)
        @"P[14]": u1,
        /// (16/16 of P) Port pull bit y (y=0..15)
        @"P[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x28
    reserved40: [80]u8,
    /// Power secure configuration register
    /// offset: 0x78
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// WKUP1 pin security
        WUP1SEC: u1,
        /// WKUP2 pin security
        WUP2SEC: u1,
        /// WKUP3 pin security
        WUP3SEC: u1,
        /// WKUP4 pin security
        WUP4SEC: u1,
        /// WKUP5 pin security
        WUP5SEC: u1,
        reserved8: u3 = 0,
        /// LPMSEC
        LPMSEC: u1,
        /// VDMSEC
        VDMSEC: u1,
        /// VBSEC
        VBSEC: u1,
        /// APCSEC
        APCSEC: u1,
        padding: u20 = 0,
    }),
    /// offset: 0x7c
    reserved124: [4]u8,
    /// Power privilege configuration register
    /// offset: 0x80
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// PRIV
        PRIV: u1,
        padding: u31 = 0,
    }),
};
