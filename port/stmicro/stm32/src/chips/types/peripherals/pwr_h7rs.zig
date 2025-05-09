const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ALS = enum(u2) {
    /// AVD level 1.
    Level1 = 0x0,
    /// AVD level 2.
    Level2 = 0x1,
    /// AVD level 3.
    Level3 = 0x2,
    /// AVD level 4.
    Level4 = 0x3,
};

pub const AVDO = enum(u1) {
    /// VDDA is equal or higher than the AVD threshold selected with the ALS[1:0] bits.
    AboveOrEqual = 0x0,
    /// VDDA is lower than the AVD threshold selected with the ALS[1:0] bits.
    Below = 0x1,
};

pub const PDDS = enum(u1) {
    /// Stop mode when device enters Deepsleep.
    Stop = 0x0,
    /// Standby mode when device enters Deepsleep.
    Standby = 0x1,
};

pub const PLS = enum(u3) {
    /// PVD level 1.
    Level1 = 0x0,
    /// PVD level 2.
    Level2 = 0x1,
    /// PVD level 3.
    Level3 = 0x2,
    /// PVD level 4.
    Level4 = 0x3,
    /// PVD level 5.
    Level5 = 0x4,
    /// PVD level 6.
    Level6 = 0x5,
    /// PVD level 7.
    Level7 = 0x6,
    /// External voltage level on PVD_IN pin, compared to internal VREFINT level.
    External = 0x7,
};

pub const PVDO = enum(u1) {
    /// VDD or PVD_IN voltage is equal or higher than the PVD threshold selected through the.
    AboveOrEqual = 0x0,
    /// VDD or PVD_IN voltage is lower than the PVD threshold selected through the PLS[2:0].
    Below = 0x1,
};

pub const RLPSN = enum(u1) {
    /// RAM enters to low power mode when system enters to STOP.
    LowPower = 0x0,
    /// RAM remains in normal mode when system enters to STOP.
    Normal = 0x1,
};

pub const SDLEVEL = enum(u1) {
    Reset = 0x0,
    V1_8 = 0x1,
};

pub const SVOS = enum(u1) {
    /// SVOS Low.
    Low = 0x0,
    /// SVOS High (default).
    High = 0x1,
};

pub const SYNC_ADC = enum(u1) {
    /// SD_Converter clock free running.
    FreeRunning = 0x0,
    /// SD_Converter clock synchronised to ADC.
    Synchronized = 0x1,
};

pub const UNLOCKED = enum(u1) {
    /// accessed locked: key was not written and after each register write access.
    Locked = 0x0,
    /// after key 0xCAFECAFE was written in this register.
    Unlocked = 0x1,
};

pub const VBRS = enum(u1) {
    /// Charge VBAT through a 5 k resistor.
    Ohm5k = 0x0,
    /// Charge VBAT through a 1.5 k resistor.
    Ohm1_5k = 0x1,
};

pub const VOS = enum(u1) {
    /// VOS Low level (default).
    Low = 0x0,
    /// VOS High level.
    High = 0x1,
};

pub const WKUPP = enum(u1) {
    /// Detection on high level (rising edge).
    High = 0x0,
    /// Detection on low level (falling edge).
    Low = 0x1,
};

pub const WKUPPUPD = enum(u2) {
    /// No pull-up.
    NoPull = 0x0,
    /// Pull-up.
    PullUp = 0x1,
    /// Pull-down.
    PullDown = 0x2,
    _,
};

pub const XSPICAP = enum(u2) {
    /// XSPI Capacitor OFF (default) note: to confirm with analog design.
    Disabled = 0x0,
    /// XSPI Capacitor set to 1/3.
    OneThird = 0x1,
    /// XSPI Capacitor set to 2/3.
    TwoThirds = 0x2,
    /// XSPI Capacitor set to full capacitance.
    Full = 0x3,
};

/// Power control.
pub const PWR = extern struct {
    /// PWR control register 1.
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// System Stop mode voltage scaling selection.
        SVOS: SVOS,
        reserved4: u3 = 0,
        /// Programmable voltage detector enable.
        PVDE: u1,
        /// Programmable voltage detector level selection These bits select the voltage threshold detected by the PVD. Note: Refer to Section Electrical characteristics of the product datasheet for more details.
        PLS: PLS,
        /// Disable backup domain write protection In reset state, the RCC_BDCR register, the RTC registers (including the backup registers), BREN and MOEN bits in the PWR_CSR1 register, are protected against parasitic write access. This bit must be set to enable write access to these registers.
        DBP: u1,
        /// Flash low-power mode in Stop mode This bit allows to obtain the best trade-off between low-power consumption and restart time when exiting from Stop mode. When it is set, the Flash memory enters low-power mode when device is in Stop mode. consumption).
        FLPS: u1,
        /// RAM low power mode disable in STOP. When set the RAMs will not enter to low power mode when the system enters to STOP.
        RLPSN: RLPSN,
        /// analog switch VBoost control This bit enables the booster to guarantee the analog switch AC performance when the VDD supply voltage is below 2.7 V (reduction of the total harmonic distortion to have the same switch performance over the full supply voltage range) The VDD supply voltage can be monitored through the PVD and the PLS bits.
        BOOSTE: u1,
        /// analog voltage ready This bit is only used when the analog switch boost needs to be enabled (see BOOSTE bit). It must be set by software when the expected VDDA analog supply level is available. The correct analog supply level is indicated by the AVDO bit (PWR_CSR1 register) after setting the AVDEN bit and selecting the supply level to be monitored (ALS bits).
        AVDREADY: u1,
        /// Peripheral voltage monitor on VDDA enable.
        AVDEN: u1,
        /// Analog voltage detector level selection These bits select the voltage threshold detected by the AVD. Note: Refer to Section Electrical characteristics of the product datasheet for more details.
        ALS: ALS,
        padding: u16 = 0,
    }),
    /// PWR control status register 1.
    /// offset: 0x04
    SR1: mmio.Mmio(packed struct(u32) {
        /// VOS currently applied for V<sub>CORE</sub> voltage scaling selection. These bit reflect the last VOS value applied to the PMU.
        ACTVOS: u1,
        /// Voltage levels ready bit for currently used ACTVOS and SDHILEVEL This bit is set to 1 by hardware when the voltage regulator and the SMPS step-down converter are both disabled and Bypass mode is selected in PWR control register 2 (PWR_CSR2).
        ACTVOSRDY: u1,
        reserved4: u2 = 0,
        /// Programmable voltage detect output This bit is set and cleared by hardware. It is valid only if the PVD has been enabled by the PVDE bit. PLS[2:0] bits. bits. Note: Since the PVD is disabled in Standby mode, this bit is equal to 0 after Standby or reset until the PVDE bit is set.
        PVDO: PVDO,
        reserved13: u8 = 0,
        /// Analog voltage detector output on VDDA This bit is set and cleared by hardware. It is valid only if AVD on VDDA is enabled by the AVDEN bit. Note: Since the AVD is disabled in Standby mode, this bit is equal to 0 after Standby or reset until the AVDEN bit is set.
        AVDO: AVDO,
        padding: u18 = 0,
    }),
    /// PWR control status register 1.
    /// offset: 0x08
    CSR1: mmio.Mmio(packed struct(u32) {
        /// Backup regulator enable When set, the backup regulator (used to maintain the backup RAM content in Standby and V<sub>BAT</sub> modes) is enabled. If BREN is reset, the backup regulator is switched off. The backup RAM can still be used in Run and Stop modes. However, its content will be lost in Standby and V<sub>BAT</sub> modes. If BREN is set, the application must wait till the backup regulator ready flag (BRRDY) is set to indicate that the data written into the SRAM will be maintained in Standby and V<sub>BAT</sub> modes.
        BREN: u1,
        reserved4: u3 = 0,
        /// V<sub>BAT</sub> and temperature monitoring enable When set, the V<sub>BAT</sub> supply and temperature monitoring is enabled. Note: V<sub>BAT</sub> and temperature monitoring are only available when the backup regulator is enabled (BREN bit set to 1).
        MONEN: u1,
        reserved16: u11 = 0,
        /// Backup regulator ready This bit is set by hardware to indicate that the backup regulator is ready.
        BRRDY: u1,
        reserved20: u3 = 0,
        /// V<sub>BAT</sub> level monitoring versus low threshold.
        VBATL: u1,
        /// V<sub>BAT</sub> level monitoring versus high threshold.
        VBATH: u1,
        /// Temperature level monitoring versus low threshold.
        TEMPL: u1,
        /// Temperature level monitoring versus high threshold.
        TEMPH: u1,
        padding: u8 = 0,
    }),
    /// PWR control register 2.
    /// offset: 0x0c
    CSR2: mmio.Mmio(packed struct(u32) {
        /// Power management unit bypass Note: Illegal combinations of SDHILEVEL, SMPSEXTHP, SDEN, LDOEN and BYPASS are described in Table 41.
        BYPASS: u1,
        /// Low drop-out regulator enable Note: Illegal combinations of SDHILEVEL, SMPSEXTHP, SDEN, LDOEN and BYPASS are described in Table 41.
        LDOEN: u1,
        /// SMPS step-down converter enable Note: Illegal combinations of SDHILEVEL, SMPSEXTHP, SDEN, LDOEN and BYPASS are described in Table 41.
        SDEN: u1,
        /// SMPS external power delivery selection Note: Illegal combinations of SDHILEVEL, SMPSEXTHP, SDEN, LDOEN and BYPASS are described in Table 41.
        SDEXTHP: u1,
        /// SMPS step-down converter voltage output for LDO or external supply This bit is used when both the LDO and SMPS step-down converter are enabled with SDEN and LDOEN enabled or when SMPSEXTHP is enabled. In this case SDHILEVEL has to be set to 1 to confirm the regulator settings.
        SDLEVEL: SDLEVEL,
        reserved8: u3 = 0,
        /// VBAT charging enable.
        VBE: u1,
        /// VBAT charging resistor selection.
        VBRS: VBRS,
        /// XSPI port 1 capacitor control bits see the product datasheet for more details.
        XSPICAP1: XSPICAP,
        /// XSPI port 2 capacitor control bits see the product datasheet for more details.
        XSPICAP2: XSPICAP,
        /// EN_XSPIM1: this bit allow the SW to enable the XSPI interface. The XSPIM_P1 supply must be stable prior to setting this bit.
        EN_XSPIM1: u1,
        /// EN_XSPIM2: this bit allows the SW to enable the XSPI interface, when available. The XSPIM_P2 supply must be stable prior to setting this bit. It should also be set when FMC is used.
        EN_XSPIM2: u1,
        /// SMPS step-down converter external supply ready This bit is set by hardware to indicate that the external supply from the SMPS step-down converter is ready.
        SDEXTRDY: u1,
        reserved24: u7 = 0,
        /// VDD33_USB voltage level detector enable.
        USB33DEN: u1,
        /// USB regulator enable.
        USBREGEN: u1,
        /// USB supply ready.
        USB33RDY: u1,
        /// USB HS regulator enable.
        USBHSREGEN: u1,
        padding: u4 = 0,
    }),
    /// PWR CPU control register 3.
    /// offset: 0x10
    CSR3: mmio.Mmio(packed struct(u32) {
        /// Power Down Deepsleep. This bit allows CPU to define the Deepsleep mode.
        PDDS: PDDS,
        /// Clear Standby and Stop flags (always read as 0) This bit is cleared to 0 by hardware.
        CSSF: u1,
        reserved8: u6 = 0,
        /// STOP flag This bit is set by hardware and cleared only by any reset or by setting the CPU CSSF bit.
        STOPF: u1,
        /// System Standby flag This bit is set by hardware and cleared only by a POR (Power-on Reset) or by setting the CPU CSSF bit.
        SBF: u1,
        padding: u22 = 0,
    }),
    /// PWR control status register 4.
    /// offset: 0x14
    CSR4: mmio.Mmio(packed struct(u32) {
        /// Voltage scaling selection according to performance These bits control the V<sub>CORE</sub> voltage level and allow to obtains the best trade-off between power consumption and performance: When increasing the performance, the voltage scaling must be changed before increasing the system frequency. When decreasing performance, the system frequency must first be decreased before changing the voltage scaling. Note: Refer to Section Electrical characteristics of the product datasheet for more details.
        VOS: VOS,
        /// VOS Ready bit.
        VOSRDY: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// PWR wakeup clear register.
    /// offset: 0x20
    WKUPCR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of WKUPC) Clear Wakeup pin flag for WKUP1 These bits are always read as 0.
        @"WKUPC[0]": u1,
        /// (2/4 of WKUPC) Clear Wakeup pin flag for WKUP1 These bits are always read as 0.
        @"WKUPC[1]": u1,
        /// (3/4 of WKUPC) Clear Wakeup pin flag for WKUP1 These bits are always read as 0.
        @"WKUPC[2]": u1,
        /// (4/4 of WKUPC) Clear Wakeup pin flag for WKUP1 These bits are always read as 0.
        @"WKUPC[3]": u1,
        padding: u28 = 0,
    }),
    /// PWR wakeup flag register.
    /// offset: 0x24
    WKUPFR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of WKUPF) Wakeup pin WKUP flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPC1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[0]": u1,
        /// (2/4 of WKUPF) Wakeup pin WKUP flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPC1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[1]": u1,
        /// (3/4 of WKUPF) Wakeup pin WKUP flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPC1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[2]": u1,
        /// (4/4 of WKUPF) Wakeup pin WKUP flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPC1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[3]": u1,
        padding: u28 = 0,
    }),
    /// PWR wakeup enable and polarity register.
    /// offset: 0x28
    WKUPEPR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of WKUPEN) Enable Wakeup Pin WKUPn, (n = 4, 3, 2, 1) Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn bit) when WKUPn pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn selects falling edge.
        @"WKUPEN[0]": u1,
        /// (2/4 of WKUPEN) Enable Wakeup Pin WKUPn, (n = 4, 3, 2, 1) Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn bit) when WKUPn pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn selects falling edge.
        @"WKUPEN[1]": u1,
        /// (3/4 of WKUPEN) Enable Wakeup Pin WKUPn, (n = 4, 3, 2, 1) Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn bit) when WKUPn pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn selects falling edge.
        @"WKUPEN[2]": u1,
        /// (4/4 of WKUPEN) Enable Wakeup Pin WKUPn, (n = 4, 3, 2, 1) Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn bit) when WKUPn pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn selects falling edge.
        @"WKUPEN[3]": u1,
        reserved8: u4 = 0,
        /// (1/4 of WKUPP) Wakeup pin polarity bit for WKUPn, (n = 4, 3, 2, 1) These bits define the polarity used for event detection on WKUPn external wakeup pin.
        @"WKUPP[0]": WKUPP,
        /// (2/4 of WKUPP) Wakeup pin polarity bit for WKUPn, (n = 4, 3, 2, 1) These bits define the polarity used for event detection on WKUPn external wakeup pin.
        @"WKUPP[1]": WKUPP,
        /// (3/4 of WKUPP) Wakeup pin polarity bit for WKUPn, (n = 4, 3, 2, 1) These bits define the polarity used for event detection on WKUPn external wakeup pin.
        @"WKUPP[2]": WKUPP,
        /// (4/4 of WKUPP) Wakeup pin polarity bit for WKUPn, (n = 4, 3, 2, 1) These bits define the polarity used for event detection on WKUPn external wakeup pin.
        @"WKUPP[3]": WKUPP,
        reserved16: u4 = 0,
        /// (1/4 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[0]": WKUPPUPD,
        /// (2/4 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[1]": WKUPPUPD,
        /// (3/4 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[2]": WKUPPUPD,
        /// (4/4 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[3]": WKUPPUPD,
        padding: u8 = 0,
    }),
    /// PWR USB Type-C and Power Delivery register.
    /// offset: 0x2c
    UCPDR: mmio.Mmio(packed struct(u32) {
        /// UCPD dead battery disable.
        UCPD_DBDIS: u1,
        /// UCPD Standby mode When set, this bit is used to memorize the UCPD configuration in Standby mode. This bit must be written to 1 just before entering Standby mode when using UCPD. It must be written to 0 after exiting the Standby mode and before writing any UCPD registers.
        UCPD_STBY: u1,
        padding: u30 = 0,
    }),
    /// PWR apply pull configuration register.
    /// offset: 0x30
    APCR: mmio.Mmio(packed struct(u32) {
        /// Apply pull-up and pull-down configuration When this bit is set, the I/O pull-up and pull-down configurations defined in PO5_PUPD, PN7_PUPD bits and PUCRx, PDCRx registers are applied in Standby mode even after wakeup until APC bit is reset to 0. When this bit is cleared, the I/O pull-up or pull-down configurations defined in PO5_PUPD, PN7_PUPD bits and PUCRx and PDCRx registers are not applied in Standby mode and IO becomes Hi-Z.
        APC: u1,
        reserved16: u15 = 0,
        /// Port N bit 7 pull-up/down configuration When this bit is set, a weak pull-up or pull-down resistor is applied on PN7 following inverse logic applied on PN6. If the PUN6 bit in PWR_PUCRN register is set and APC bit is set the week pull-down is applied on PN7. If the PDN6 bit in PWR_PDCRN register is set and APC bit is set the week pull-up is applied on PN7.
        PN7_PUPD: u1,
        /// Port O bit 5 pull-up/down configuration When this bit is set, a weak pull-up or pull down resistor is applied on PO5 following inverse logic applied on PO4. If the PUO4 bit in PWR_PUCRO register is set and APC bit is set the week pull-down is applied on PO5. If the PDO4 bit in PWR_PDCRO register is set and APC bit is set the week pull-up is applied on PO5..
        PO5_PUPD: u1,
        reserved28: u10 = 0,
        /// Port PB6 I3C pull-up bit When I3C is used on PB6, when set, this bit activates the pull-up on I3C1_SCL (PB6) in standby mode.
        I3CPB6_PU: u1,
        /// Port PB7 I3C pull-up bit When I3C is used on PB7, when set, this bit activates the pull-up on I3C1_SDA (PB7) in standby mode.
        I3CPB7_PU: u1,
        /// Port PB8 I3C pull-up bit When I3C is used on PB8, when set, this bit activates the pull-up on I3C1_SCL (PB8) in standby mode.
        I3CPB8_PU: u1,
        /// Port PB9 I3C pull-up bit When I3C is used on PB9, when set, this bit activates the pull-up on I3C1_SDA (PB9) in standby mode.
        I3CPB9_PU: u1,
    }),
    /// PWR port N pull-up control register.
    /// offset: 0x34
    PUCRN: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Port N pull-up bit 1 When set, each bit activates the pull-up on PN1 when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding PD1 bit is also set.
        PUN1: u1,
        reserved6: u4 = 0,
        /// Port N pull-up bit 6 When set activates the pull-up on PN6 when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding PDN6 bit is also set.
        PUN6: u1,
        reserved12: u5 = 0,
        /// Port N pull-up bit 12 When set, each bit activates the pull-up on PN12 when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding PD12 bit is also set.
        PUN12: u1,
        padding: u19 = 0,
    }),
    /// PWR port N pull-down control register.
    /// offset: 0x38
    PDCRN: mmio.Mmio(packed struct(u32) {
        /// Port N pull-down bit 0 When set activates the pull-down on PN0 when the APC bit is set in PWR_APCR.
        PDN0: u1,
        /// Port N pull-down bit 1 When set activates the pull-down on PN1 when the APC bit is set in PWR_APCR.
        PDN1: u1,
        /// Port N PN2 to PN5 pull-down activation When set, four pull-down resistors are activated on PN2 to PN5 when the APC bit is set in PWR_APCR.
        PDN2N5: u1,
        reserved6: u3 = 0,
        /// Port N pull-down bit 6 When set activates the pull-down on PN6 when the APC bit is set in PWR_APCR.
        PDN6: u1,
        reserved8: u1 = 0,
        /// Port N - PN8 to PN11 pull-down activation When set, four pull-down resistors are activated on PN8 to PN11 when the APC bit is set in PWR_APCR.
        PDN8N11: u1,
        reserved12: u3 = 0,
        /// Port N pull-down bit 12 When set activates the pull-down on PN12 when the APC bit is set in PWR_APCR.
        PDN12: u1,
        padding: u19 = 0,
    }),
    /// PWR port O pull-up control register.
    /// offset: 0x3c
    PUCRO: mmio.Mmio(packed struct(u32) {
        /// (n = 1 to 0) Port O pull-up bits When set, each bit activates the pull-up on POy when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding bits in PWR_PDCRO is also set.
        PUO0: u1,
        /// (n = 1 to 0) Port O pull-up bits When set, each bit activates the pull-up on POy when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding bits in PWR_PDCRO is also set.
        PUO1: u1,
        reserved4: u2 = 0,
        /// Port O pull-up bit 4 When set activates the pull-up on PO4 when the APC bit is set in PWR_APCR. The pull-up is not activated if the corresponding bits PDO4 in PWR_PDCRO is also set.
        PUO4: u1,
        padding: u27 = 0,
    }),
    /// PWR port O pull-down control register.
    /// offset: 0x40
    PDCRO: mmio.Mmio(packed struct(u32) {
        /// Port O pull-down bit y When set, each bit activates the pull-down on POy when the APC bit is set in PWR_APCR.
        PDO0: u1,
        /// Port O pull-down bit y When set, each bit activates the pull-down on POy when the APC bit is set in PWR_APCR.
        PDO1: u1,
        /// Port O pull-down bit y When set, each bit activates the pull-down on POy when the APC bit is set in PWR_APCR.
        PDO2: u1,
        /// Port O pull-down bit y When set, each bit activates the pull-down on POy when the APC bit is set in PWR_APCR.
        PDO3: u1,
        /// Port O pull-down bit y When set, each bit activates the pull-down on POy when the APC bit is set in PWR_APCR.
        PDO4: u1,
        padding: u27 = 0,
    }),
    /// PWR port P pull-down control register.
    /// offset: 0x44
    PDCRP: mmio.Mmio(packed struct(u32) {
        /// Port P0-P3 pull-down activation When set, four pull-down resistors are activated on P0 to P3 when the APC bit is set in PWR_APCR.
        PDP0P3: u1,
        reserved4: u3 = 0,
        /// Port P4-P7 pull-down activation When set, four pull-down resitors are activated on P4 to P7 when the APC bit is set in PWR_APCR.
        PDP4P7: u1,
        reserved8: u3 = 0,
        /// Port P8-P11 pull-down activation When set, four pull-down resistors are activated on P8 to P11 when the APC bit is set in PWR_APCR.
        PDP8P11: u1,
        reserved12: u3 = 0,
        /// Port P12-P15 pull-down activation When set, four pull-down resistors are activated on P8 to P11 when the APC bit is set in PWR_APCR.
        PDP12P15: u1,
        padding: u19 = 0,
    }),
    /// offset: 0x48
    reserved72: [8]u8,
    /// PWR debug register 1.
    /// offset: 0x50
    PDR1: mmio.Mmio(packed struct(u32) {
        /// Debug Register Unlocked.
        UNLOCKED: UNLOCKED,
        reserved3: u2 = 0,
        /// Step down converter force PWM mode.
        SDFPWMEN: u1,
        reserved16: u12 = 0,
        /// (Non-User bit).
        SYNC_ADC: SYNC_ADC,
        padding: u15 = 0,
    }),
};
