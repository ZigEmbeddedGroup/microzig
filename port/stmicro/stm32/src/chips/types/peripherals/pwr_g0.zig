const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const VOS = enum(u2) {
    Range1 = 0x1,
    Range2 = 0x2,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// Power control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection
        LPMS: u3,
        /// Flash memory powered down during Stop mode
        FPD_STOP: u1,
        /// Flash memory powered down during Low-power run mode
        FPD_LPRUN: u1,
        /// Flash memory powered down during Low-power sleep mode
        FPD_LPSLP: u1,
        reserved8: u2 = 0,
        /// Disable backup domain write protection
        DBP: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        reserved14: u3 = 0,
        /// Low-power run
        LPR: u1,
        padding: u17 = 0,
    }),
    /// Power control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Power voltage detector enable
        PVDE: u1,
        /// Power voltage detector falling threshold selection
        PVDFT: u3,
        /// Power voltage detector rising threshold selection
        PVDRT: u3,
        padding: u25 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/6 of EWUP) Enable Wakeup pin
        @"EWUP[0]": u1,
        /// (2/6 of EWUP) Enable Wakeup pin
        @"EWUP[1]": u1,
        /// (3/6 of EWUP) Enable Wakeup pin
        @"EWUP[2]": u1,
        /// (4/6 of EWUP) Enable Wakeup pin
        @"EWUP[3]": u1,
        /// (5/6 of EWUP) Enable Wakeup pin
        @"EWUP[4]": u1,
        /// (6/6 of EWUP) Enable Wakeup pin
        @"EWUP[5]": u1,
        reserved8: u2 = 0,
        /// SRAM retention in Standby mode
        RRS: u1,
        /// Enable the periodical sampling mode for PDR detection
        ULPEN: u1,
        /// Apply pull-up and pull-down configuration
        APC: u1,
        reserved15: u4 = 0,
        /// Enable internal wakeup line
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power control register 4
    /// offset: 0x0c
    CR4: mmio.Mmio(packed struct(u32) {
        /// (1/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[0]": u1,
        /// (2/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[1]": u1,
        /// (3/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[2]": u1,
        /// (4/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[3]": u1,
        /// (5/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[4]": u1,
        /// (6/6 of WP) Wakeup pin WKUP1 polarity
        @"WP[5]": u1,
        reserved8: u2 = 0,
        /// VBAT battery charging enable
        VBE: u1,
        /// VBAT battery charging resistor selection
        VBRS: u1,
        padding: u22 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// (1/6 of WUF) Wakeup flag
        @"WUF[0]": u1,
        /// (2/6 of WUF) Wakeup flag
        @"WUF[1]": u1,
        /// (3/6 of WUF) Wakeup flag
        @"WUF[2]": u1,
        /// (4/6 of WUF) Wakeup flag
        @"WUF[3]": u1,
        /// (5/6 of WUF) Wakeup flag
        @"WUF[4]": u1,
        /// (6/6 of WUF) Wakeup flag
        @"WUF[5]": u1,
        reserved8: u2 = 0,
        /// Standby flag
        SBF: u1,
        reserved15: u6 = 0,
        /// Wakeup flag internal
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// Power status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Flash ready flag
        FLASH_RDY: u1,
        /// Low-power regulator started
        REGLPS: u1,
        /// Low-power regulator flag
        REGLPF: u1,
        /// Voltage scaling flag
        VOSF: u1,
        /// Power voltage detector output
        PVDO: u1,
        padding: u20 = 0,
    }),
    /// Power status clear register
    /// offset: 0x18
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CWUF) Clear Wakeup flag
        @"CWUF[0]": u1,
        /// (2/6 of CWUF) Clear Wakeup flag
        @"CWUF[1]": u1,
        /// (3/6 of CWUF) Clear Wakeup flag
        @"CWUF[2]": u1,
        /// (4/6 of CWUF) Clear Wakeup flag
        @"CWUF[3]": u1,
        /// (5/6 of CWUF) Clear Wakeup flag
        @"CWUF[4]": u1,
        /// (6/6 of CWUF) Clear Wakeup flag
        @"CWUF[5]": u1,
        reserved8: u2 = 0,
        /// Clear standby flag
        CSBF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// Power Port pull-up control register
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
    /// Power Port pull-down control register
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
};
