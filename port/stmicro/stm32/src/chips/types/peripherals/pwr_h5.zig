const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ALS = enum(u2) {
    /// AVD level0 (VAVD0 ~ 1.7 V)
    Level0 = 0x0,
    /// AVD level1 (VAVD1 ~ 2.1 V)
    Level1 = 0x1,
    /// AVD level2 (VAVD2 ~ 2.5 V)
    Level2 = 0x2,
    /// AVD level3 (VAVD3 ~ 2.8 V)
    Level3 = 0x3,
};

pub const LPMS = enum(u1) {
    /// Keeps Stop mode when entering DeepSleep.
    Stop = 0x0,
    /// Allows Standby mode when entering DeepSleep.
    Standby = 0x1,
};

pub const PLS = enum(u3) {
    /// PVD level0 (VPVD0 ~ 1.95 V)
    Level0 = 0x0,
    /// PVD level1 (VPVD1 ~ 2.10 V)
    Level1 = 0x1,
    /// PVD level2 (VPVD2 ~ 2.25 V)
    Level2 = 0x2,
    /// PVD level3 (VPVD3 ~ 2.40 V)
    Level3 = 0x3,
    /// PVD level4 (VPVD4 ~ 2.55 V)
    Level4 = 0x4,
    /// PVD level5 (VPVD5 ~ 2.70 V)
    Level5 = 0x5,
    /// PVD level6 (VPVD6 ~ 2.85 V)
    Level6 = 0x6,
    /// PVD_IN pin
    PVDInPin = 0x7,
};

pub const PowerModeInStopMode = enum(u1) {
    /// Remains in normal mode when the system enters Stop mode (quick restart time).
    Normal = 0x0,
    /// Enters low-power mode when the system enters Stop mode (low-power consumption).
    LowPower = 0x1,
};

pub const Retention = enum(u1) {
    /// Content is lost.
    Lost = 0x0,
    /// Content is preserved.
    Preserved = 0x1,
};

pub const SVOS = enum(u2) {
    /// SVOS5 scale 5
    Scale5 = 0x1,
    /// SVOS4 scale 4
    Scale4 = 0x2,
    /// SVOS3 scale 3 (default)
    Scale3 = 0x3,
    _,
};

pub const ShutOff = enum(u1) {
    /// Content is kept.
    Kept = 0x0,
    /// Content is lost.
    Lost = 0x1,
};

pub const VBRS = enum(u1) {
    /// Charge VBAT through a 5 kΩ resistor.
    R5kOhm = 0x0,
    /// Charge VBAT through a 1.5 kΩ resistor.
    R1_5kOhm = 0x1,
};

pub const VOS = enum(u2) {
    Scale3 = 0x0,
    Scale2 = 0x1,
    Scale1 = 0x2,
    Scale0 = 0x3,
};

pub const WUPP = enum(u1) {
    /// detection on high level (rising edge)
    High = 0x0,
    /// detection on low level (falling edge)
    Low = 0x1,
};

pub const WUPPUPD = enum(u2) {
    NoPullUp = 0x0,
    PullUp = 0x1,
    PullDown = 0x2,
    _,
};

/// Power control.
pub const PWR = extern struct {
    /// PWR power mode control register.
    /// offset: 0x00
    PMCR: mmio.Mmio(packed struct(u32) {
        /// low-power mode selection This bit defines the Deepsleep mode.
        LPMS: LPMS,
        reserved2: u1 = 0,
        /// system Stop mode voltage scaling selection These bits control the V_CORE voltage level in system Stop mode, to obtain the best trade-off between power consumption and performance.
        SVOS: SVOS,
        reserved7: u3 = 0,
        /// clear Standby and Stop flags (always read as 0) This bit is cleared to 0 by hardware.
        CSSF: u1,
        reserved9: u1 = 0,
        /// Flash memory low-power mode in Stop mode This bit is used to obtain the best trade-off between low-power consumption and restart time when exiting from Stop mode. When it is set, the Flash memory enters low-power mode when the CPU domain is in Stop mode. Note: When system enters stop mode with SVOS5 enabled, Flash memory is automatically forced in low-power mode.
        FLPS: PowerModeInStopMode,
        reserved12: u2 = 0,
        /// analog switch V_BOOST control This bit enables the booster to guarantee the analog switch AC performance when the V_DD supply voltage is below 2.7 V (reduction of the total harmonic distortion to have the same switch performance over the full supply voltage range) The V_DD supply voltage can be monitored through the PVD and the PLS bits.
        BOOSTE: u1,
        /// analog voltage ready This bit is only used when the analog switch boost needs to be enabled (see BOOSTE bit). It must be set by software when the expected V_DDA analog supply level is available. The correct analog supply level is indicated by the AVDO bit (PWR_VMSR register) after setting the AVDEN bit (PWR_VMCR register) and selecting the supply level to be monitored. (ALS bits).
        AVD_READY: u1,
        reserved16: u2 = 0,
        /// ETHERNET RAM shut-off in Stop mode.
        ETHERNETSO: ShutOff,
        reserved23: u6 = 0,
        /// AHB SRAM3 shut-off in Stop mode.
        SRAM3SO: ShutOff,
        /// AHB SRAM2 16-Kbyte shut-off in Stop mode.
        SRAM2_16SO: ShutOff,
        /// AHB SRAM2 48-Kbyte shut-off in Stop mode.
        SRAM2_48SO: ShutOff,
        /// AHB SRAM1 shut-off in Stop mode.
        SRAM1SO: ShutOff,
        padding: u5 = 0,
    }),
    /// PWR status register.
    /// offset: 0x04
    PMSR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Stop flag This bit is set by hardware and cleared only by any reset or by setting the CSSF bit.
        STOPF: u1,
        /// System standby flag This bit is set by hardware and cleared only by a POR or by setting the CSSF bit.
        SBF: u1,
        padding: u25 = 0,
    }),
    /// offset: 0x08
    reserved8: [8]u8,
    /// PWR voltage scaling control register.
    /// offset: 0x10
    VOSCR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// voltage scaling selection according to performance These bits control the V_CORE voltage level and allow to obtain the best trade-off between power consumption and performance: - In bypass mode, these bits must also be set according to the external provided core voltage level and related performance. - When increasing the performance, the voltage scaling must be changed before increasing the system frequency. - When decreasing performance, the system frequency must first be decreased before changing the voltage scaling.
        VOS: VOS,
        padding: u26 = 0,
    }),
    /// PWR voltage scaling status register.
    /// offset: 0x14
    VOSSR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Ready bit for V_CORE voltage scaling output selection.
        VOSRDY: u1,
        reserved13: u9 = 0,
        /// Voltage level ready for currently used VOS.
        ACTVOSRDY: u1,
        /// voltage output scaling currently applied to V_CORE This field provides the last VOS value.
        ACTVOS: VOS,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// PWR Backup domain control register.
    /// offset: 0x20
    BDCR: mmio.Mmio(packed struct(u32) {
        /// Backup RAM retention in Standby and V_BAT modes When this bit set, the backup regulator (used to maintain the backup RAM content in Standby and V_BAT modes) is enabled. If BREN is cleared, the backup regulator is switched off. The backup RAM can still be used in. Run and Stop modes. However its content is lost in Standby and V_BAT modes. If BREN is set, the application must wait till the backup regulator ready flag (BRRDY) is set to indicate that the data written into the SRAM is maintained in Standby and V_BAT modes.
        BREN: Retention,
        /// Backup domain voltage and temperature monitoring enable.
        MONEN: u1,
        reserved8: u6 = 0,
        /// V_BAT charging enable Note: Reset only by POR,.
        VBE: u1,
        /// V_BAT charging resistor selection.
        VBRS: VBRS,
        padding: u22 = 0,
    }),
    /// PWR Backup domain control register.
    /// offset: 0x24
    DBPCR: mmio.Mmio(packed struct(u32) {
        /// Disable Backup domain write protection In reset state, all registers and SRAM in Backup domain are protected against parasitic write. access. This bit must be set to enable write access to these registers.
        DBP: u1,
        padding: u31 = 0,
    }),
    /// PWR Backup domain status register.
    /// offset: 0x28
    BDSR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// backup regulator ready This bit is set by hardware to indicate that the backup regulator is ready.
        BRRDY: u1,
        reserved20: u3 = 0,
        /// V_BAT level monitoring versus low threshold.
        VBATL: u1,
        /// V_BAT level monitoring versus high threshold.
        VBATH: u1,
        /// temperature level monitoring versus low threshold.
        TEMPL: u1,
        /// temperature level monitoring versus high threshold.
        TEMPH: u1,
        padding: u8 = 0,
    }),
    /// PWR USB Type-C power delivery register.
    /// offset: 0x2c
    UCPDR: mmio.Mmio(packed struct(u32) {
        /// USB Type-C and power delivery dead battery disable After exiting reset, the USB Type-C “dead battery” behavior is enabled, which may have a pull-down effect on CC1 and CC2 pins. It is recommended to disable it in all case, either to stop this pull-down or to hand over control to the UCPD (which should therefore be initialized before doing the disable).
        UCPD_DBDIS: u1,
        /// USB Type-c and Power delivery Standby mode When set, this bit is used to memorize the UCPD configuration in Standby mode. This bit must be written to 1 just before entering Standby mode when using UCPD, and it must be written to 0 after exiting the standby mode and before writing any UCPD register.
        UCPD_STBY: u1,
        padding: u30 = 0,
    }),
    /// PWR supply configuration control register.
    /// offset: 0x30
    SCCR: mmio.Mmio(packed struct(u32) {
        /// power management unit bypass.
        BYPASS: u1,
        reserved8: u7 = 0,
        /// LDO enable The value is set by hardware when the package uses the LDO regulator.
        LDOEN: u1,
        /// SMPS enable The value is set by hardware when the package uses the SMPS regulator.
        SMPSEN: u1,
        padding: u22 = 0,
    }),
    /// PWR voltage monitor control register.
    /// offset: 0x34
    VMCR: mmio.Mmio(packed struct(u32) {
        /// PVD enable.
        PVDE: u1,
        /// programmable voltage detector (PVD) level selection These bits select the voltage threshold detected by the PVD.
        PLS: PLS,
        reserved8: u4 = 0,
        /// peripheral voltage monitor on V_DDA enable.
        AVDEN: u1,
        /// analog voltage detector (AVD) level selection These bits select the voltage threshold detected by the AVD.
        ALS: ALS,
        padding: u21 = 0,
    }),
    /// PWR USB supply control register.
    /// offset: 0x38
    USBSCR: mmio.Mmio(packed struct(u32) {
        reserved24: u24 = 0,
        /// V_DDUSB voltage level detector enable.
        USB33DEN: u1,
        /// independent USB supply valid This bit is used to validate the V_DDUSB supply for electrical and logical isolation purpose. Setting this bit is mandatory to use the USBFS peripheral. If V_DDUSB is not always present in the application, the V_DDUSB voltage monitor can be used to determine whether this supply is ready or not.
        USB33SV: u1,
        padding: u6 = 0,
    }),
    /// PWR voltage monitor status register.
    /// offset: 0x3c
    VMSR: mmio.Mmio(packed struct(u32) {
        reserved19: u19 = 0,
        /// analog voltage detector output on V_DDA This bit is set and cleared by hardware. It is valid only if AVD on VDDA is enabled by the AVDEN bit. Note: Since the AVD is disabled in Standby mode, this bit is equal to 0 after standby or reset until the AVDEN bit is set.
        AVDO: u1,
        /// voltage detector output on V_DDIO2 This bit is set and cleared by hardware.
        VDDIO2RDY: u1,
        reserved22: u1 = 0,
        /// programmable voltage detect output This bit is set and cleared by hardware. It is valid only if the PVD has been enabled by the PVDE bit. Note: Since the PVD is disabled in Standby mode, this bit is equal to 0 after Standby or reset until the PVDE bit is set.
        PVDO: u1,
        reserved24: u1 = 0,
        /// V_DDUSB ready.
        USB33RDY: u1,
        padding: u7 = 0,
    }),
    /// PWR wakeup status clear register.
    /// offset: 0x40
    WUSCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[0]": u1,
        /// (2/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[1]": u1,
        /// (3/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[2]": u1,
        /// (4/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[3]": u1,
        /// (5/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[4]": u1,
        /// (6/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[5]": u1,
        /// (7/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[6]": u1,
        /// (8/8 of CWUF) clear wakeup pin flag for WUFx These bits are always read as 0.
        @"CWUF[7]": u1,
        padding: u24 = 0,
    }),
    /// PWR wakeup status register.
    /// offset: 0x44
    WUSR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[0]": u1,
        /// (2/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[1]": u1,
        /// (3/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[2]": u1,
        /// (4/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[3]": u1,
        /// (5/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[4]": u1,
        /// (6/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[5]": u1,
        /// (7/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[6]": u1,
        /// (8/8 of WUF) wakeup pin WUFx flag This bit is set by hardware and cleared only by a RESET pin or by setting the CWUFx bit in PWR_WUSCR register.
        @"WUF[7]": u1,
        padding: u24 = 0,
    }),
    /// PWR wakeup configuration register.
    /// offset: 0x48
    WUCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[0]": u1,
        /// (2/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[1]": u1,
        /// (3/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[2]": u1,
        /// (4/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[3]": u1,
        /// (5/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[4]": u1,
        /// (6/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[5]": u1,
        /// (7/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[6]": u1,
        /// (8/8 of WUPEN) enable wakeup pin WUPx These bits are set and cleared by software. Note: an additional wakeup event is detected if WUPx pin is enabled (by setting the WUPENx bit) when WUPx pin level is already high when WUPPx selects rising edge, or low when WUPPx selects falling edge.
        @"WUPEN[7]": u1,
        /// (1/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[0]": WUPP,
        /// (2/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[1]": WUPP,
        /// (3/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[2]": WUPP,
        /// (4/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[3]": WUPP,
        /// (5/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[4]": WUPP,
        /// (6/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[5]": WUPP,
        /// (7/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[6]": WUPP,
        /// (8/8 of WUPP) wakeup pin polarity bit for WUPx These bits define the polarity used for event detection on WUPx external wakeup pin.
        @"WUPP[7]": WUPP,
        /// (1/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[0]": WUPPUPD,
        /// (2/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[1]": WUPPUPD,
        /// (3/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[2]": WUPPUPD,
        /// (4/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[3]": WUPPUPD,
        /// (5/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[4]": WUPPUPD,
        /// (6/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[5]": WUPPUPD,
        /// (7/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[6]": WUPPUPD,
        /// (8/8 of WUPPUPD) wakeup pin pull configuration for WKUPx These bits define the I/O pad pull configuration used when WUPENx = 1. The associated GPIO port pull configuration must be set to the same value or to 00. The wakeup pin pull configuration is kept in Standby mode.
        @"WUPPUPD[7]": WUPPUPD,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// PWR I/O retention register.
    /// offset: 0x50
    IORETR: mmio.Mmio(packed struct(u32) {
        /// IO retention enable: When entering into standby mode, the output is sampled, and apply to the output IO during the standby power mode. Note: the IO state is not retained if the DBG_STANDBY bit is set in DBGMCU_CR register.
        IORETEN: u1,
        reserved16: u15 = 0,
        /// IO retention enable for JTAG IOs when entering into standby mode, the output is sampled, and apply to the output IO during the standby power mode.
        JTAGIORETEN: u1,
        padding: u15 = 0,
    }),
    /// offset: 0x54
    reserved84: [172]u8,
    /// PWR security configuration register.
    /// offset: 0x100
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[0]": u1,
        /// (2/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[1]": u1,
        /// (3/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[2]": u1,
        /// (4/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[3]": u1,
        /// (5/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[4]": u1,
        /// (6/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[5]": u1,
        /// (7/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[6]": u1,
        /// (8/8 of WUPSEC) WUPx secure protection.
        @"WUPSEC[7]": u1,
        reserved11: u3 = 0,
        /// retention secure protection.
        RETSEC: u1,
        /// low-power modes secure protection.
        LPMSEC: u1,
        /// supply configuration and monitoring secure protection.
        SCMSEC: u1,
        /// backup domain secure protection.
        VBSEC: u1,
        /// voltage USB secure protection.
        VUSBSEC: u1,
        padding: u16 = 0,
    }),
    /// PWR privilege configuration register.
    /// offset: 0x104
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// PWR secure functions privilege configuration Set and reset by software. This bit can be written only by a secure privileged access.
        SPRIV: u1,
        /// PWR non-secure functions privilege configuration Set and reset by software. This bit can be written only by privileged access, secure or non-secure.
        NSPRIV: u1,
        padding: u30 = 0,
    }),
};
