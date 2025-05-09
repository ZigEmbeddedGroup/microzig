const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ACTVOS = enum(u2) {
    /// Range 4 (lowest power)
    Range4 = 0x0,
    /// Range 3
    Range3 = 0x1,
    /// Range 2
    Range2 = 0x2,
    /// Range 1 (highest frequency)
    Range1 = 0x3,
};

pub const FLASHFWU = enum(u1) {
    /// Flash memory enters low-power mode in Stop 0 and Stop 1 modes (lower-power consumption).
    LowPower = 0x0,
    /// Flash memory remains in normal mode in Stop 0 and Stop 1 modes (faster wakeup time).
    Normal = 0x1,
};

pub const LPMS = enum(u3) {
    /// Stop 0 mode
    Stop0 = 0x0,
    /// Stop 1 mode
    Stop1 = 0x1,
    /// Stop 2 mode
    Stop2 = 0x2,
    /// Stop 3 mode
    Stop3 = 0x3,
    _,
};

pub const PDS = enum(u1) {
    /// Content retained in Stop modes
    Retained = 0x0,
    /// Content lost in Stop modes
    Lost = 0x1,
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

pub const REGSEL = enum(u1) {
    /// LDO selected
    LDO = 0x0,
    /// SMPS selected
    SMPS = 0x1,
};

pub const SRAMFWU = enum(u1) {
    /// SRAM4 enters low-power mode in Stop 0, 1 and 2 modes (source biasing for lower-power consumption).
    B_0x0 = 0x0,
    /// SRAM4 remains in normal mode in Stop 0, 1 and 2 modes (higher consumption but no SRAM4 wakeup time).
    B_0x1 = 0x1,
};

pub const SRAMPD = enum(u1) {
    /// SRAM1 powered on
    PoweredOn = 0x0,
    /// SRAM1 powered off
    PoweredOff = 0x1,
};

pub const TEMPH = enum(u1) {
    /// Temperature < high threshold
    B_0x0 = 0x0,
    /// Temperature ≥ high threshold
    B_0x1 = 0x1,
};

pub const TEMPL = enum(u1) {
    /// Temperature > low threshold
    B_0x0 = 0x0,
    /// Temperature ≤ low threshold
    B_0x1 = 0x1,
};

pub const VBATH = enum(u1) {
    /// Backup domain voltage level < high threshold
    B_0x0 = 0x0,
    /// Backup domain voltage level ≥ high threshold
    B_0x1 = 0x1,
};

pub const VBE = enum(u1) {
    /// VBAT battery charging disabled
    B_0x0 = 0x0,
    /// VBAT battery charging enabled
    B_0x1 = 0x1,
};

pub const VBRS = enum(u1) {
    /// Charge VBAT through a 5 kΩ resistor
    B_0x0 = 0x0,
    /// Charge VBAT through a 1.5 kΩ resistor
    B_0x1 = 0x1,
};

pub const VOS = enum(u2) {
    /// Range 4 (lowest power)
    Range4 = 0x0,
    /// Range 3
    Range3 = 0x1,
    /// Range 2
    Range2 = 0x2,
    /// Range 1 (highest frequency). This value cannot be written when VCOREMEN = 1 in TAMP_OR register.
    Range1 = 0x3,
};

pub const WUPP = enum(u1) {
    /// Detection on high level (rising edge)
    High = 0x0,
    /// Detection on low level (falling edge)
    Low = 0x1,
};

pub const WUSEL = enum(u2) {
    /// WKUP7_0
    B_0x0 = 0x0,
    /// WKUP7_1
    B_0x1 = 0x1,
    /// WKUP7_2
    B_0x2 = 0x2,
    /// WKUP7_3
    B_0x3 = 0x3,
};

/// Power control
pub const PWR = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection These bits select the low-power mode entered when the CPU enters the Deepsleep mode. 10x: Standby mode (Standby mode also entered if LPMS=11X in CR1 with BREN=1 in BDCR1) 11x: Shutdown mode if BREN = 0 in BDCR1
        LPMS: LPMS,
        reserved5: u2 = 0,
        /// SRAM2 page 1 retention in Stop 3 and Standby modes This bit is used to keep the SRAM2 page 1 content in Stop 3 and Standby modes. The SRAM2 page 1 corresponds to the first 8 Kbytes of the SRAM2 (from SRAM2 base address to SRAM2 base address + 0x1FFF). Note: This bit has no effect in Shutdown mode.
        RRSB1: u1,
        /// SRAM2 page 2 retention in Stop 3 and Standby modes This bit is used to keep the SRAM2 page 2 content in Stop 3 and Standby modes. The SRAM2 page 2 corresponds to the last 56 Kbytes of the SRAM2 (from SRAM2 base address + 0x2000 to SRAM2 base address + 0xFFFF). Note: This bit has no effect in Shutdown mode.
        RRSB2: u1,
        /// BOR ultra-low power mode This bit is used to reduce the consumption by configuring the BOR in discontinuous mode. This bit must be set to reach the lowest power consumption in the low-power modes.
        ULPMEN: u1,
        /// SRAM1 power down This bit is used to reduce the consumption by powering off the SRAM1.
        SRAM1PD: SRAMPD,
        /// SRAM2 power down This bit is used to reduce the consumption by powering off the SRAM2.
        SRAM2PD: SRAMPD,
        /// SRAM3 power down This bit is used to reduce the consumption by powering off the SRAM3.
        SRAM3PD: SRAMPD,
        /// SRAM4 power down This bit is used to reduce the consumption by powering off the SRAM4.
        SRAM4PD: SRAMPD,
        padding: u20 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// SRAM1 page 1 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM1PDS1: PDS,
        /// SRAM1 page 2 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM1PDS2: PDS,
        /// SRAM1 page 3 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM1PDS3: PDS,
        reserved4: u1 = 0,
        /// SRAM2 page 1 (8 Kbytes) power-down in Stop modes (Stop 0, 1, 2) Note: The SRAM2 page 1 retention in Stop 3 is controlled by RRSB1 bit in CR1.
        SRAM2PDS1: PDS,
        /// SRAM2 page 2 (56 Kbytes) power-down in Stop modes (Stop 0, 1, 2) Note: The SRAM2 page 2 retention in Stop 3 is controlled by RRSB2 bit in CR1.
        SRAM2PDS2: PDS,
        /// SRAM4 power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM4PDS: PDS,
        reserved8: u1 = 0,
        /// ICACHE SRAM power-down in Stop modes (Stop 0, 1, 2, 3)
        ICRAMPDS: PDS,
        /// DCACHE1 SRAM power-down in Stop modes (Stop 0, 1, 2, 3)
        DC1RAMPDS: PDS,
        /// DMA2D SRAM power-down in Stop modes (Stop 0, 1, 2, 3)
        DMA2DRAMPDS: PDS,
        /// FMAC, FDCAN and USB peripherals SRAM power-down in Stop modes (Stop0,1,2,3)
        PRAMPDS: PDS,
        /// PKA SRAM power-down
        PKARAMPDS: PDS,
        /// SRAM4 fast wakeup from Stop 0, Stop 1 and Stop 2 modes This bit is used to obtain the best trade-off between low-power consumption and wakeup time. SRAM4 wakeup time increases the wakeup time when exiting Stop 0, 1 and 2 modes, and also increases the LPDMA access time to SRAM4 during Stop modes.
        SRAM4FWU: SRAMFWU,
        /// Flash memory fast wakeup from Stop 0 and Stop 1 modes This bit is used to obtain the best trade-off between low-power consumption and wakeup time when exiting the Stop 0 or Stop 1 modes. When this bit is set, the Flash memory remains in normal mode in Stop 0 and Stop 1 modes, which offers a faster startup time with higher consumption.
        FLASHFWU: FLASHFWU,
        reserved16: u1 = 0,
        /// SRAM3 page 1 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS1: PDS,
        /// SRAM3 page 2 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS2: PDS,
        /// SRAM3 page 3 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS3: PDS,
        /// SRAM3 page 4 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS4: PDS,
        /// SRAM3 page 5 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS5: PDS,
        /// SRAM3 page 6 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS6: PDS,
        /// SRAM3 page 7 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS7: PDS,
        /// SRAM3 page 8 (64 Kbytes) power-down in Stop modes (Stop 0, 1, 2, 3)
        SRAM3PDS8: PDS,
        reserved31: u7 = 0,
        /// SmartRun domain in Run mode
        SRDRUN: u1,
    }),
    /// control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Regulator selection Note: REGSEL is reserved and must be kept at reset value in packages without SMPS.
        REGSEL: REGSEL,
        /// Fast soft start
        FSTEN: u1,
        padding: u29 = 0,
    }),
    /// voltage scaling register
    /// offset: 0x0c
    VOSR: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// EPOD booster ready This bit is set to 1 by hardware when the power booster startup time is reached. The system clock frequency can be switched higher than 50 MHz only after this bit is set.
        BOOSTRDY: u1,
        /// Ready bit for VCORE voltage scaling output selection
        VOSRDY: u1,
        /// Voltage scaling range selection This field is protected against non-secure access when SYSCLKSEC=1 in RCC_SECCFGR. It is protected against unprivileged access when SYSCLKSEC=1 in RCC_SECCFGR and SPRIV=1 in PRIVCFGR, or when SYSCLKSEC=0 and NSPRIV=1.
        VOS: VOS,
        /// EPOD booster enable
        BOOSTEN: u1,
        padding: u13 = 0,
    }),
    /// supply voltage monitoring control register
    /// offset: 0x10
    SVMCR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Power voltage detector enable
        PVDE: u1,
        /// Power voltage detector level selection These bits select the voltage threshold detected by the power voltage detector:
        PVDLS: PVDLS,
        reserved24: u16 = 0,
        /// VDDUSB independent USB voltage monitor enable
        UVMEN: u1,
        /// VDDIO2 independent I/Os voltage monitor enable
        IO2VMEN: u1,
        /// VDDA independent analog supply voltage monitor 1 enable (1.6V threshold)
        AVM1EN: u1,
        /// VDDA independent analog supply voltage monitor 2 enable (1.8V threshold)
        AVM2EN: u1,
        /// VDDUSB independent USB supply valid
        USV: u1,
        /// VDDIO2 independent I/Os supply valid This bit is used to validate the VDDIO2 supply for electrical and logical isolation purpose. Setting this bit is mandatory to use PG[15:2]. If VDDIO2 is not always present in the application, the VDDIO2 voltage monitor can be used to determine whether this supply is ready or not.
        IO2SV: u1,
        /// VDDA independent analog supply valid
        ASV: u1,
        padding: u1 = 0,
    }),
    /// wakeup control register 1
    /// offset: 0x14
    WUCR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[0]": u1,
        /// (2/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[1]": u1,
        /// (3/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[2]": u1,
        /// (4/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[3]": u1,
        /// (5/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[4]": u1,
        /// (6/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[5]": u1,
        /// (7/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[6]": u1,
        /// (8/8 of WUPEN) Wakeup pin WKUP1 enable
        @"WUPEN[7]": u1,
        padding: u24 = 0,
    }),
    /// wakeup control register 2
    /// offset: 0x18
    WUCR2: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[0]": WUPP,
        /// (2/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[1]": WUPP,
        /// (3/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[2]": WUPP,
        /// (4/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[3]": WUPP,
        /// (5/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[4]": WUPP,
        /// (6/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[5]": WUPP,
        /// (7/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[6]": WUPP,
        /// (8/8 of WUPP) Wakeup pin WKUP1 polarity. This bit must be configured when WUPEN1 = 0.
        @"WUPP[7]": WUPP,
        padding: u24 = 0,
    }),
    /// wakeup control register 3
    /// offset: 0x1c
    WUCR3: mmio.Mmio(packed struct(u32) {
        /// Wakeup pin WKUP1 selection This field must be configured when WUPEN1 = 0.
        WUSEL1: WUSEL,
        /// Wakeup pin WKUP2 selection This field must be configured when WUPEN2 = 0.
        WUSEL2: WUSEL,
        /// Wakeup pin WKUP3 selection This field must be configured when WUPEN3 = 0.
        WUSEL3: WUSEL,
        /// Wakeup pin WKUP4 selection This field must be configured when WUPEN4 = 0.
        WUSEL4: WUSEL,
        /// Wakeup pin WKUP5 selection This field must be configured when WUPEN5 = 0.
        WUSEL5: WUSEL,
        /// Wakeup pin WKUP6 selection This field must be configured when WUPEN6 = 0.
        WUSEL6: WUSEL,
        /// Wakeup pin WKUP7 selection This field must be configured when WUPEN7 = 0.
        WUSEL7: WUSEL,
        /// Wakeup pin WKUP8 selection This field must be configured when WUPEN8 = 0.
        WUSEL8: WUSEL,
        padding: u16 = 0,
    }),
    /// Backup domain control register 1
    /// offset: 0x20
    BDCR1: mmio.Mmio(packed struct(u32) {
        /// Backup RAM retention in Standby and VBAT modes When this bit is set, the backup RAM content is kept in Standby and VBAT modes. If BREN is reset, the backup RAM can still be used in Run, Sleep and Stop modes. However, its content is lost in Standby, Shutdown and VBAT modes. This bit can be written only when the regulator is LDO, which must be configured before switching to SMPS. Note: Backup RAM cannot be preserved in Shutdown mode.
        BREN: u1,
        reserved4: u3 = 0,
        /// Backup domain voltage and temperature monitoring enable
        MONEN: u1,
        padding: u27 = 0,
    }),
    /// Backup domain control register 2
    /// offset: 0x24
    BDCR2: mmio.Mmio(packed struct(u32) {
        /// VBAT charging enable
        VBE: VBE,
        /// VBAT charging resistor selection
        VBRS: VBRS,
        padding: u30 = 0,
    }),
    /// disable Backup domain register
    /// offset: 0x28
    DBPCR: mmio.Mmio(packed struct(u32) {
        /// Disable Backup domain write protection In reset state, all registers and SRAM in Backup domain are protected against parasitic write access. This bit must be set to enable the write access to these registers.
        DBP: u1,
        padding: u31 = 0,
    }),
    /// USB Type-C™ and Power Delivery register
    /// offset: 0x2c
    UCPDR: mmio.Mmio(packed struct(u32) {
        /// UCPD dead battery disable After exiting reset, the USB Type-C “dead battery” behavior is enabled, which may have a pull-down effect on CC1 and CC2 pins. It is recommended to disable it in all cases, either to stop this pull-down or to handover control to the UCPD (the UCPD must be initialized before doing the disable).
        UCPD_DBDIS: u1,
        /// UCPD Standby mode When set, this bit is used to memorize the UCPD configuration in Standby mode. This bit must be written to 1 just before entering Standby mode when using UCPD. It must be written to 0 after exiting the Standby mode and before writing any UCPD registers.
        UCPD_STBY: u1,
        padding: u30 = 0,
    }),
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
        /// Voltage detection and monitoring secure protection
        VDMSEC: u1,
        /// Backup domain secure protection
        VBSEC: u1,
        /// Pull-up/pull-down secure protection
        APCSEC: u1,
        padding: u16 = 0,
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
        /// Clear Stop and Standby flags This bit is protected against non-secure access when LPMSEC=1 in SECCFGR. This bit is protected against unprivileged access when LPMSEC=1 and SPRIV=1 in PRIVCFGR, or when LPMSEC=0 and NSPRIV=1. Writing 1 to this bit clears the STOPF and SBF flags.
        CSSF: u1,
        /// Stop flag This bit is set by hardware when the device enters a Stop mode, and is cleared by software by writing 1 to the CSSF bit.
        STOPF: u1,
        /// Standby flag This bit is set by hardware when the device enters the Standby mode, and is cleared by writing 1 to the CSSF bit, or by a power-on reset. It is not cleared by the system reset.
        SBF: u1,
        padding: u29 = 0,
    }),
    /// offset: 0x3c
    SVMSR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Regulator selection
        REGS: REGSEL,
        reserved4: u2 = 0,
        /// VDD voltage detector output
        PVDO: PVDO,
        reserved15: u10 = 0,
        /// Voltage level ready for currently used VOS
        ACTVOSRDY: u1,
        /// VOS currently applied to VCORE This field provides the last VOS value.
        ACTVOS: ACTVOS,
        reserved24: u6 = 0,
        /// VDDUSB ready
        VDDUSBRDY: u1,
        /// VDDIO2 ready
        VDDIO2RDY: u1,
        /// VDDA ready versus 1.6V voltage monitor
        VDDA1RDY: u1,
        /// VDDA ready versus 1.8V voltage monitor
        VDDA2RDY: u1,
        padding: u4 = 0,
    }),
    /// Backup domain status register
    /// offset: 0x40
    BDSR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Backup domain voltage level monitoring versus high threshold
        VBATH: VBATH,
        /// Temperature level monitoring versus low threshold
        TEMPL: TEMPL,
        /// Temperature level monitoring versus high threshold
        TEMPH: TEMPH,
        padding: u28 = 0,
    }),
    /// wakeup status register
    /// offset: 0x44
    WUSR: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag 1 This bit is set when a wakeup event is detected on WKUP1 pin. This bit is cleared by writing 1 in the CWUF1 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN1=0.
        WUF1: u1,
        /// Wakeup flag 2 This bit is set when a wakeup event is detected on WKUP2 pin. This bit is cleared by writing 1 in the CWUF2 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN2=0.
        WUF2: u1,
        /// Wakeup flag 3 This bit is set when a wakeup event is detected on WKUP3 pin. This bit is cleared by writing 1 in the CWUF3 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN3=0.
        WUF3: u1,
        /// Wakeup flag 4 This bit is set when a wakeup event is detected on WKUP4 pin. This bit is cleared by writing 1 in the CWUF4 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN4=0.
        WUF4: u1,
        /// Wakeup flag 5 This bit is set when a wakeup event is detected on WKUP5 pin. This bit is cleared by writing 1 in the CWUF5 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN5=0.
        WUF5: u1,
        /// Wakeup flag 6 This bit is set when a wakeup event is detected on WKUP6 pin. This bit is cleared by writing 1 in the CWUF6 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN6=0. If WUSEL=11, this bit is cleared by hardware when all internal wakeup source are cleared.
        WUF6: u1,
        /// Wakeup flag 7 This bit is set when a wakeup event is detected on WKUP7 pin. This bit is cleared by writing 1 in the CWUF7 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN7=0. If WUSEL=11, this bit is cleared by hardware when all internal wakeup source are cleared.
        WUF7: u1,
        /// Wakeup flag 8 This bit is set when a wakeup event is detected on WKUP8 pin. This bit is cleared by writing 1 in the CWUF8 bit of WUSCR when WUSEL ≠ 11, or by hardware when WUPEN8=0. If WUSEL=11, this bit is cleared by hardware when all internal wakeup source are cleared.
        WUF8: u1,
        padding: u24 = 0,
    }),
    /// wakeup status clear register
    /// offset: 0x48
    WUSCR: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag 1 Writing 1 to this bit clears the WUF1 flag in WUSR.
        CWUF1: u1,
        /// Wakeup flag 2 Writing 1 to this bit clears the WUF2 flag in WUSR.
        CWUF2: u1,
        /// Wakeup flag 3 Writing 1 to this bit clears the WUF3 flag in WUSR.
        CWUF3: u1,
        /// Wakeup flag 4 Writing 1 to this bit clears the WUF4 flag in WUSR.
        CWUF4: u1,
        /// Wakeup flag 5 Writing 1 to this bit clears the WUF5 flag in WUSR.
        CWUF5: u1,
        /// Wakeup flag 6 Writing 1 to this bit clears the WUF6 flag in WUSR.
        CWUF6: u1,
        /// Wakeup flag 7 Writing 1 to this bit clears the WUF7 flag in WUSR.
        CWUF7: u1,
        /// Wakeup flag 8 Writing 1 to this bit clears the WUF8 flag in WUSR.
        CWUF8: u1,
        padding: u24 = 0,
    }),
    /// apply pull configuration register
    /// offset: 0x4c
    APCR: mmio.Mmio(packed struct(u32) {
        /// Apply pull-up and pull-down configuration When this bit is set, the I/O pull-up and pull-down configurations defined in PUCRx and PDCRx are applied. When this bit is cleared, PUCRx and PDCRx are not applied to the I/Os.
        APC: u1,
        padding: u31 = 0,
    }),
    /// Power Port pull-up control register
    /// offset: 0x50
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
    /// offset: 0x54
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
