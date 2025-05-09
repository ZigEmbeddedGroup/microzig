const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CDS = enum(u1) {
    /// CPU is running or in sleep
    RunningOrSleep = 0x0,
    /// CPU is in Deep-Sleep
    DeepSleep = 0x1,
};

pub const FPDR = enum(u1) {
    /// Flash memory in Idle mode when system is in LPRun mode
    Idle = 0x0,
    /// Flash memory in Power-down mode when system is in LPRun mode
    PowerDown = 0x1,
};

pub const FPDS = enum(u1) {
    /// Flash memory in Idle mode when system is in LPSleep mode
    Idle = 0x0,
    /// Flash memory in Power-down mode when system is in LPSleep mode
    PowerDown = 0x1,
};

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
    /// Voltage regulator in Main mode in Low-power run mode
    MainMode = 0x0,
    /// Voltage regulator in low-power mode in Low-power run mode
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

pub const SUBGHZSPINSSSEL = enum(u1) {
    /// sub-GHz SPI NSS signal driven from PWR_SUBGHZSPICR.NSS (RFBUSYMS functionality enabled)
    SUBGHZSPICR = 0x0,
    /// sub-GHz SPI NSS signal driven from LPTIM3_OUT (RFBUSYMS functionality disabled)
    LPTIM3 = 0x1,
};

pub const VBRS = enum(u1) {
    /// VBAT charging through a 5 kΩ resistor
    R5k = 0x0,
    /// VBAT charging through a 1.5 kΩ resistor
    R1_5k = 0x1,
};

pub const VOS = enum(u2) {
    /// 1.2 V (range 1)
    Range1 = 0x1,
    /// 1.0 V (range 2)
    Range2 = 0x2,
    _,
};

pub const WP = enum(u1) {
    /// Detection on high level (rising edge)
    RisingEdge = 0x0,
    /// Detection on low level (falling edge)
    FallingEdge = 0x1,
};

/// Power control
pub const PWR = extern struct {
    /// Power control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection for CPU1
        LPMS: LPMS,
        /// sub-GHz SPI NSS source select
        SUBGHZSPINSSSEL: SUBGHZSPINSSSEL,
        /// Flash memory power down mode during LPRun for CPU1
        FPDR: FPDR,
        /// Flash memory power down mode during LPSleep for CPU1
        FPDS: FPDS,
        reserved8: u2 = 0,
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
        /// Power voltage detector level selection.
        PLS: PLS,
        reserved6: u2 = 0,
        /// Peripheral voltage monitoring 3 enable: VDDA vs. 1.62V
        PVME: u1,
        padding: u25 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/3 of EWUP) Enable Wakeup pin WKUP1 for CPU1
        @"EWUP[0]": u1,
        /// (2/3 of EWUP) Enable Wakeup pin WKUP1 for CPU1
        @"EWUP[1]": u1,
        /// (3/3 of EWUP) Enable Wakeup pin WKUP1 for CPU1
        @"EWUP[2]": u1,
        reserved7: u4 = 0,
        /// Ultra-low-power enable
        EULPEN: u1,
        /// Enable wakeup PVD for CPU1
        EWPVD: u1,
        /// SRAM2 retention in Standby mode
        RRS: u1,
        /// Apply pull-up and pull-down configuration from CPU1
        APC: u1,
        /// Enable Radio BUSY Wakeup from Standby for CPU1
        EWRFBUSY: u1,
        reserved13: u1 = 0,
        /// Wakeup for CPU1
        EWRFIRQ: u1,
        /// nable CPU2 Hold interrupt for CPU1
        EC2H: u1,
        /// Enable internal wakeup line for CPU1
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power control register 4
    /// offset: 0x0c
    CR4: mmio.Mmio(packed struct(u32) {
        /// (1/3 of WP) Wakeup pin WKUP1 polarity
        @"WP[0]": WP,
        /// (2/3 of WP) Wakeup pin WKUP1 polarity
        @"WP[1]": WP,
        /// (3/3 of WP) Wakeup pin WKUP1 polarity
        @"WP[2]": WP,
        reserved8: u5 = 0,
        /// VBAT battery charging enable
        VBE: u1,
        /// VBAT battery charging resistor selection
        VBRS: VBRS,
        reserved11: u1 = 0,
        /// Wakeup Radio BUSY polarity
        WRFBUSYP: u1,
        reserved15: u3 = 0,
        /// oot CPU2 after reset or wakeup from Stop or Standby modes.
        C2BOOT: u1,
        padding: u16 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// (1/3 of WUF) Wakeup flag 1
        @"WUF[0]": u1,
        /// (2/3 of WUF) Wakeup flag 1
        @"WUF[1]": u1,
        /// (3/3 of WUF) Wakeup flag 1
        @"WUF[2]": u1,
        reserved8: u5 = 0,
        /// Wakeup PVD flag
        WPVDF: u1,
        reserved11: u2 = 0,
        /// Radio BUSY wakeup flag
        WRFBUSYF: u1,
        reserved14: u2 = 0,
        /// PU2 Hold interrupt flag
        C2HF: u1,
        /// Internal wakeup interrupt flag
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// Power status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        /// PU2 boot/wakeup request source information
        C2BOOTS: u1,
        /// Radio BUSY signal status
        RFBUSYS: u1,
        /// Radio BUSY masked signal status
        RFBUSYMS: u1,
        /// SMPS ready flag
        SMPSRDY: u1,
        /// LDO ready flag
        LDORDY: u1,
        /// Radio end of life flag
        RFEOLF: u1,
        /// regulator2 low power flag
        REGMRS: u1,
        /// Flash ready
        FLASHRDY: u1,
        /// regulator1 started
        REGLPS: u1,
        /// regulator1 low power flag
        REGLPF: u1,
        /// Voltage scaling flag
        VOSF: u1,
        /// Power voltage detector output
        PVDO: u1,
        reserved14: u2 = 0,
        /// Peripheral voltage monitoring output: VDDA vs. 1.62 V
        PVMO: u1,
        padding: u17 = 0,
    }),
    /// Power status clear register
    /// offset: 0x18
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of CWUF) Clear wakeup flag 1
        @"CWUF[0]": u1,
        /// (2/3 of CWUF) Clear wakeup flag 1
        @"CWUF[1]": u1,
        /// (3/3 of CWUF) Clear wakeup flag 1
        @"CWUF[2]": u1,
        reserved8: u5 = 0,
        /// Clear wakeup PVD interrupt flag
        CWPVDF: u1,
        reserved11: u2 = 0,
        /// Clear wakeup Radio BUSY flag
        CWRFBUSYF: u1,
        reserved14: u2 = 0,
        /// lear CPU2 Hold interrupt flag
        CC2HF: u1,
        padding: u17 = 0,
    }),
    /// Power control register 5
    /// offset: 0x1c
    CR5: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// Enable Radio End Of Life detector enabled
        RFEOLEN: u1,
        /// Enable SMPS Step Down converter SMPS mode enabled.
        SMPSEN: u1,
        padding: u16 = 0,
    }),
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
    /// Power CPU2 control register 1 [dual core device only]
    /// offset: 0x80
    C2CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection for CPU2
        LPMS: u3,
        reserved4: u1 = 0,
        /// Flash memory power down mode during LPRun for CPU2
        FPDR: u1,
        /// Flash memory power down mode during LPSleep for CPU2
        FPDS: u1,
        padding: u26 = 0,
    }),
    /// Power CPU2 control register 3 [dual core device only]
    /// offset: 0x84
    C2CR3: mmio.Mmio(packed struct(u32) {
        /// (1/3 of EWUP) Enable Wakeup pin WKUP1 for CPU2
        @"EWUP[0]": u1,
        /// (2/3 of EWUP) Enable Wakeup pin WKUP1 for CPU2
        @"EWUP[1]": u1,
        /// (3/3 of EWUP) Enable Wakeup pin WKUP1 for CPU2
        @"EWUP[2]": u1,
        reserved8: u5 = 0,
        /// Enable wakeup PVD for CPU2
        EWPVD: u1,
        reserved10: u1 = 0,
        /// Apply pull-up and pull-down configuration for CPU2
        APC: u1,
        /// EWRFBUSY
        EWRFBUSY: u1,
        reserved13: u1 = 0,
        /// akeup for CPU2
        EWRFIRQ: u1,
        reserved15: u1 = 0,
        /// Enable internal wakeup line for CPU2
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power extended status and status clear register
    /// offset: 0x88
    EXTSCR: mmio.Mmio(packed struct(u32) {
        /// Clear CPU1 Stop Standby flags
        C1CSSF: u1,
        /// lear CPU2 Stop Standby flags
        C2CSSF: u1,
        reserved8: u6 = 0,
        /// System Standby flag for CPU1. (no core states retained)
        C1SBF: u1,
        /// System Stop2 flag for CPU1. (partial core states retained)
        C1STOP2F: u1,
        /// System Stop0, 1 flag for CPU1. (All core states retained)
        C1STOPF: u1,
        /// ystem Standby flag for CPU2. (no core states retained)
        C2SBF: u1,
        /// ystem Stop2 flag for CPU2. (partial core states retained)
        C2STOP2F: u1,
        /// ystem Stop0, 1 flag for CPU2. (All core states retained)
        C2STOPF: u1,
        /// CPU1 deepsleep mode
        C1DS: CDS,
        /// PU2 deepsleep mode
        C2DS: u1,
        padding: u16 = 0,
    }),
    /// Power security configuration register [dual core device only]
    /// offset: 0x8c
    SECCFGR: mmio.Mmio(packed struct(u32) {
        reserved15: u15 = 0,
        /// wakeup on CPU2 illegal access interrupt enable
        C2EWILA: u1,
        padding: u16 = 0,
    }),
    /// Power SPI3 control register
    /// offset: 0x90
    SUBGHZSPICR: mmio.Mmio(packed struct(u32) {
        reserved15: u15 = 0,
        /// sub-GHz SPI NSS control
        NSS: u1,
        padding: u16 = 0,
    }),
    /// offset: 0x94
    reserved148: [4]u8,
    /// RSS Command register [dual core device only]
    /// offset: 0x98
    RSSCMDR: mmio.Mmio(packed struct(u32) {
        /// RSS command
        RSSCMD: u8,
        padding: u24 = 0,
    }),
};
