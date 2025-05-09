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
        reserved8: u5 = 0,
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
        /// Power voltage detector level selection
        PLS: u3,
        /// Peripheral voltage monitoring 1 enable: VDDA vs. COMP min voltage
        PVMEN1: u1,
        /// Peripheral voltage monitoring 2 enable: VDDA vs. Fast DAC min voltage
        PVMEN2: u1,
        /// Peripheral voltage monitoring 3 enable: VDDA vs. ADC min voltage 1.62V
        PVMEN3: u1,
        /// Peripheral voltage monitoring 4 enable: VDDA vs. OPAMP/DAC min voltage
        PVMEN4: u1,
        padding: u24 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// Enable Wakeup pin WKUP1
        EWUP1: u1,
        /// Enable Wakeup pin WKUP2
        EWUP2: u1,
        /// Enable Wakeup pin WKUP3
        EWUP3: u1,
        /// Enable Wakeup pin WKUP4
        EWUP4: u1,
        /// Enable Wakeup pin WKUP5
        EWUP5: u1,
        reserved8: u3 = 0,
        /// SRAM2 retention in Standby mode
        RRS: u1,
        reserved10: u1 = 0,
        /// Apply pull-up and pull-down configuration
        APC: u1,
        reserved13: u2 = 0,
        /// STDBY
        UCPD1_STDBY: u1,
        /// DBDIS
        UCPD1_DBDIS: u1,
        /// Enable external WakeUp line
        EIWUL: u1,
        padding: u16 = 0,
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
        padding: u22 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag 1
        WUF1: u1,
        /// Wakeup flag 2
        WUF2: u1,
        /// Wakeup flag 3
        WUF3: u1,
        /// Wakeup flag 4
        WUF4: u1,
        /// Wakeup flag 5
        WUF5: u1,
        reserved8: u3 = 0,
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
        /// Clear wakeup flag 1
        CWUF1: u1,
        /// Clear wakeup flag 2
        CWUF2: u1,
        /// Clear wakeup flag 3
        CWUF3: u1,
        /// Clear wakeup flag 4
        CWUF4: u1,
        /// Clear wakeup flag 5
        CWUF5: u1,
        reserved8: u3 = 0,
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
    /// offset: 0x28
    reserved40: [88]u8,
    /// Power control register 5
    /// offset: 0x80
    CR5: mmio.Mmio(packed struct(u32) {
        /// Main regular range 1 mode
        R1MODE: u1,
        padding: u31 = 0,
    }),
};
