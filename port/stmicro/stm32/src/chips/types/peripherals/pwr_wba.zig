const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ACTVOS = enum(u1) {
    /// Range 2 (lowest power)
    Range2 = 0x0,
    /// Range 1 (highest frequency)
    Range1 = 0x1,
};

pub const FLASHFWU = enum(u1) {
    /// Flash memory enters low-power mode in Stop 0 and Stop 1 modes (lower-power consumption).
    LowPower = 0x0,
    /// Flash memory remains in normal mode in Stop 0 and Stop 1 modes (faster wakeup time).
    Normal = 0x1,
};

pub const ICRAMPDS = enum(u1) {
    /// ICACHE SRAM content retained in Stop modes
    Retained = 0x0,
    /// ICACHE SRAM content lost in Stop modes
    NotRetained = 0x1,
};

pub const LPMS = enum(u3) {
    /// Stop 0 mode
    Stop0 = 0x0,
    /// Stop 1 mode
    Stop1 = 0x1,
    _,
};

pub const MODE = enum(u2) {
    /// 2.4 GHz RADIO deep sleep mode
    DeepSleep = 0x0,
    /// 2.4 GHz RADIO sleep mode
    Sleep = 0x1,
    _,
};

pub const PVDLS = enum(u3) {
    /// VPVD0 around 2.0 V
    v20 = 0x0,
    /// VPVD1 around 2.2 V
    v22 = 0x1,
    /// VPVD2 around 2.4 V
    v24 = 0x2,
    /// VPVD3 around 2.5 V
    v25 = 0x3,
    /// VPVD4 around 2.6 V
    v26 = 0x4,
    /// VPVD5 around 2.8 V
    v28 = 0x5,
    /// VPVD6 around 2.9 V
    v29 = 0x6,
    /// External input analog voltage PVD_IN (compared internally to VREFINT)
    pvd_in = 0x7,
};

pub const PVDO = enum(u1) {
    /// VDD is equal or above the PVD threshold selected by PVDLS[2:0].
    AboveOrEqual = 0x0,
    /// VDD is below the PVD threshold selected by PVDLS[2:0].
    Below = 0x1,
};

pub const SRAMPDS = enum(u1) {
    /// SRAM1 content retained in Stop modes
    PoweredOn = 0x0,
    /// SRAM1 content lost in Stop modes
    PoweredOff = 0x1,
};

pub const VOS = enum(u1) {
    /// Range 2 (lowest power)
    Range2 = 0x0,
    /// Range 1 (highest frequency).
    Range1 = 0x1,
};

pub const WUPP = enum(u1) {
    /// Detection on high level (rising edge)
    High = 0x0,
    /// Detection on low level (falling edge)
    Low = 0x1,
};

pub const WUSEL = enum(u2) {
    /// reserved
    B_0x0 = 0x0,
    /// WKUP3_1
    B_0x1 = 0x1,
    /// WKUP3_2
    B_0x2 = 0x2,
    /// reserved
    B_0x3 = 0x3,
};

/// Power control
pub const PWR = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection These bits select the low-power mode entered when the CPU enters the SleepDeep mode. 10x: Standby mode others reserved
        LPMS: LPMS,
        reserved5: u2 = 0,
        /// SRAM2 retention in Standby mode This bit is used to keep the SRAM2 content in Standby retention mode.
        R2RSB1: u1,
        reserved7: u1 = 0,
        /// BOR0 ultra-low-power mode. This bit is used to reduce the consumption by configuring the BOR0 in discontinuous mode for Stop 1 and Standby modes. Discontinuous mode is only available when BOR levels 1 to 4 and PVD are disabled. Note: This bit must be set to reach the lowest power consumption in the low-power modes. Note: This bit must not be set together with autonomous peripherals using HSI as kernel clock. Note: When BOR level 1 to 4 or PVD is enabled continuous mode applies independent from ULPMEN.
        ULPMEN: u1,
        reserved9: u1 = 0,
        /// 2.4 GHz RADIO SRAMs (RXTXRAM and Sequence RAM) and Sleep clock retention in Standby mode. This bit is used to keep the 2.4 GHz RADIO SRAMs content in Standby retention mode and the 2.4 GHz RADIO sleep timer counter operational.
        RADIORSB: u1,
        reserved12: u2 = 0,
        /// SRAM1 retention in Standby mode This bit is used to keep the SRAM1 content in Standby retention mode.
        R1RSB1: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// SRAM1 power-down in Stop modes (Stop 0, 1) Note: The SRAM1 retention in Standby mode is controlled by R1RSB1 bit in CR1.
        SRAM1PDS1: SRAMPDS,
        reserved4: u3 = 0,
        /// SRAM2 power-down in Stop modes (Stop 0, 1) Note: The SRAM2 retention in Standby mode is controlled by R2RSB1 bit in CR1.
        SRAM2PDS1: SRAMPDS,
        reserved8: u3 = 0,
        /// ICACHE SRAM power-down in Stop modes (Stop 0, 1)
        ICRAMPDS: ICRAMPDS,
        reserved14: u5 = 0,
        /// Flash memory fast wakeup from Stop modes (Stop 0, 1) This bit is used to obtain the best trade-off between low-power consumption and wakeup time when exiting the Stop 0 or Stop 1 modes. When this bit is set, the Flash memory remains in normal mode in Stop 0 and Stop 1 modes, which offers a faster startup time with higher consumption.
        FLASHFWU: FLASHFWU,
        padding: u17 = 0,
    }),
    /// control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Fast soft start
        FSTEN: u1,
        padding: u29 = 0,
    }),
    /// voltage scaling register
    /// offset: 0x0c
    VOSR: mmio.Mmio(packed struct(u32) {
        reserved15: u15 = 0,
        /// Ready bit for V<sub>CORE</sub> voltage scaling output selection Set and cleared by hardware. When decreasing the voltage scaling range, VOSRDY must be one before increasing the SYSCLK frequency.
        VOSRDY: u1,
        /// Voltage scaling range selection Set a and cleared by software. Cleared by hardware when entering Stop 1 mode. Access can be secured by RCC SYSCLKSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        VOS: VOS,
        padding: u15 = 0,
    }),
    /// supply voltage monitoring control register
    /// offset: 0x10
    SVMCR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Programmable voltage detector enable
        PVDE: u1,
        /// Programmable voltage detector level selection These bits select the voltage threshold detected by the programmable voltage detector:
        PVDLS: PVDLS,
        padding: u24 = 0,
    }),
    /// wakeup control register 1
    /// offset: 0x14
    WUCR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[0]": u1,
        /// (2/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[1]": u1,
        /// (3/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[2]": u1,
        /// (4/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[3]": u1,
        /// (5/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[4]": u1,
        /// (6/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[5]": u1,
        /// (7/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[6]": u1,
        /// (8/8 of WUPEN) Wakeup and interrupt pin WKUP1 enable Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPEN[7]": u1,
        padding: u24 = 0,
    }),
    /// wakeup control register 2
    /// offset: 0x18
    WUCR2: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[0]": WUPP,
        /// (2/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[1]": WUPP,
        /// (3/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[2]": WUPP,
        /// (4/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[3]": WUPP,
        /// (5/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[4]": WUPP,
        /// (6/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[5]": WUPP,
        /// (7/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[6]": WUPP,
        /// (8/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        @"WUPP[7]": WUPP,
        padding: u24 = 0,
    }),
    /// wakeup control register 3
    /// offset: 0x1c
    WUCR3: mmio.Mmio(packed struct(u32) {
        /// Wakeup and interrupt pin WKUP1 selection This field must be configured when WUPEN1 = 0. Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL1: WUSEL,
        /// Wakeup and interrupt pin WKUP2 selection This field must be configured when WUPEN2 = 0. Access can be secured by WUP2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL2: WUSEL,
        /// Wakeup and interrupt pin WKUP3 selection This field must be configured when WUPEN3 = 0. Access can be secured by WUP3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL3: WUSEL,
        /// Wakeup and interrupt pin WKUP4 selection This field must be configured when WUPEN4 = 0. Access can be secured by WUP4SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL4: WUSEL,
        /// Wakeup and interrupt pin WKUP5 selection This field must be configured when WUPEN5 = 0. Access can be secured by WUP5SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL5: WUSEL,
        /// Wakeup and interrupt pin WKUP6 selection This field must be configured when WUPEN6 = 0. Access can be secured by WUP6SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL6: WUSEL,
        /// Wakeup and interrupt pin WKUP7 selection This field must be configured when WUPEN7 = 0. Access can be secured by WUP7SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL7: WUSEL,
        /// Wakeup and interrupt pin WKUP8 selection This field must be configured when WUPEN8 = 0. Access can be secured by WUP8SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV.
        WUSEL8: WUSEL,
        padding: u16 = 0,
    }),
    /// offset: 0x20
    reserved32: [8]u8,
    /// disable Backup domain register
    /// offset: 0x28
    DBPCR: mmio.Mmio(packed struct(u32) {
        /// Disable Backup domain write protection In reset state, all registers and SRAM in Backup domain are protected against parasitic write access. This bit must be set to enable the write access to these registers.
        DBP: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// security configuration register
    /// offset: 0x30
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[0]": u1,
        /// (2/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[1]": u1,
        /// (3/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[2]": u1,
        /// (4/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[3]": u1,
        /// (5/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[4]": u1,
        /// (6/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[5]": u1,
        /// (7/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[6]": u1,
        /// (8/8 of WUP1SEC) WUP1 secure protection
        @"WUP1SEC[7]": u1,
        reserved12: u4 = 0,
        /// Low-power modes secure protection
        LPMSEC: u1,
        /// Voltage detection secure protection
        VDMSEC: u1,
        /// Backup domain secure protection
        VBSEC: u1,
        padding: u17 = 0,
    }),
    /// privilege control register
    /// offset: 0x34
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// secure functions privilege configuration This bit is set and reset by software. It can be written only by a secure privileged access.
        SPRIV: u1,
        /// non-secure functions privilege configuration This bit is set and reset by software. It can be written only by privileged access, secure or non-secure.
        NSPRIV: u1,
        padding: u30 = 0,
    }),
    /// status register
    /// offset: 0x38
    SR: mmio.Mmio(packed struct(u32) {
        /// Clear Stop and Standby flags Access can be secured by LPMSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the STOPF and SBF flags.
        CSSF: u1,
        /// Stop flag This bit is set by hardware when the device enters a Stop or Standby mode at the same time as the sysclk has been set by hardware to select HSI. It’s cleared by software by writing 1 to the CSSF bit and by hardware when SBF is set.
        STOPF: u1,
        /// Standby flag This bit is set by hardware when the device enters the Standby mode and the CPU restart from its reset vector. It’s cleared by writing 1 to the CSSF bit, or by a power-on reset. It is not cleared by the system reset.
        SBF: u1,
        padding: u29 = 0,
    }),
    /// supply voltage monitoring status register
    /// offset: 0x3c
    SVMSR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Programmable voltage detector output
        PVDO: PVDO,
        reserved15: u10 = 0,
        /// Voltage level ready for currently used VOS
        ACTVOSRDY: u1,
        /// VOS currently applied to V<sub>CORE</sub> This field provides the last VOS value.
        ACTVOS: ACTVOS,
        padding: u15 = 0,
    }),
    /// offset: 0x40
    reserved64: [4]u8,
    /// wakeup status register
    /// offset: 0x44
    WUSR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[0]": u1,
        /// (2/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[1]": u1,
        /// (3/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[2]": u1,
        /// (4/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[3]": u1,
        /// (5/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[4]": u1,
        /// (6/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[5]": u1,
        /// (7/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[6]": u1,
        /// (8/8 of WUF) Wakeup and interrupt pending flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR or by hardware when WUPEN1 = 0.
        @"WUF[7]": u1,
        padding: u24 = 0,
    }),
    /// wakeup status clear register
    /// offset: 0x48
    WUSCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[0]": u1,
        /// (2/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[1]": u1,
        /// (3/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[2]": u1,
        /// (4/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[3]": u1,
        /// (5/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[4]": u1,
        /// (6/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[5]": u1,
        /// (7/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[6]": u1,
        /// (8/8 of CWUF) Clear wakeup flag 1 Access can be secured by WUP1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with SPRIV or when non-secure with NSPRIV. Writing 1 to this bit clears the WUF1 flag in WUSR.
        @"CWUF[7]": u1,
        padding: u24 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// port Standby IO retention enable register
    /// offset: 0x50
    IORETENR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[0]": u1,
        /// (2/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[1]": u1,
        /// (3/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[2]": u1,
        /// (4/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[3]": u1,
        /// (5/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[4]": u1,
        /// (6/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[5]": u1,
        /// (7/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[6]": u1,
        /// (8/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[7]": u1,
        /// (9/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[8]": u1,
        /// (10/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[9]": u1,
        /// (11/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[10]": u1,
        /// (12/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[11]": u1,
        /// (13/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[12]": u1,
        /// (14/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[13]": u1,
        /// (15/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[14]": u1,
        /// (16/16 of EN) Port A Standby GPIO retention enable Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV. When set, each bit enables the Standby GPIO retention feature for PAy
        @"EN[15]": u1,
        padding: u16 = 0,
    }),
    /// port Standby IO retention status register
    /// offset: 0x54
    IORETRA: mmio.Mmio(packed struct(u32) {
        /// (1/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[0]": u1,
        /// (2/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[1]": u1,
        /// (3/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[2]": u1,
        /// (4/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[3]": u1,
        /// (5/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[4]": u1,
        /// (6/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[5]": u1,
        /// (7/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[6]": u1,
        /// (8/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[7]": u1,
        /// (9/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[8]": u1,
        /// (10/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[9]": u1,
        /// (11/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[10]": u1,
        /// (12/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[11]": u1,
        /// (13/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[12]": u1,
        /// (14/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[13]": u1,
        /// (15/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[14]": u1,
        /// (16/16 of RET) Port A Standby GPIO retention active Access can be protected by GPIOA SECy, privilege protection is controlled by SPRIV or NSPRIV.
        @"RET[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x58
    reserved88: [168]u8,
    /// 2.4 GHz RADIO status and control register
    /// offset: 0x100
    RADIOSCR: mmio.Mmio(packed struct(u32) {
        /// 2.4 GHz RADIO operating mode. 1x: 2.4 GHz RADIO active mode
        MODE: MODE,
        /// 2.4 GHz RADIO PHY operating mode
        PHYMODE: u1,
        /// 2.4 GHz RADIO encryption function operating mode
        ENCMODE: u1,
        reserved8: u4 = 0,
        /// 2.4 GHz RADIO VDDHPA control word. Bits [3:0] see Table 81: PA output power table format for definition. Bit [4] rf_event.
        RFVDDHPA: u5,
        reserved15: u2 = 0,
        /// Ready bit for V<sub>DDHPA</sub> voltage level when selecting VDDRFPA input. Note: REGPARDYVDDRFPA does not allow to detect correct V<sub>DDHPA</sub> voltage level when request to lower the level.
        REGPARDYVDDRFPA: u1,
        padding: u16 = 0,
    }),
};
