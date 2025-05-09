const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const SDLEVEL = enum(u2) {
    Reset = 0x0,
    V1_8 = 0x1,
    V2_5 = 0x2,
    V2_5_ALT = 0x3,
};

pub const VOS = enum(u2) {
    Scale0 = 0x0,
    Scale3 = 0x1,
    Scale2 = 0x2,
    Scale1 = 0x3,
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

/// PWR
pub const PWR = extern struct {
    /// PWR control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power Deepsleep with SVOS3 (SVOS4 and SVOS5 always use low-power, regardless of the setting of this bit)
        LPDS: u1,
        reserved4: u3 = 0,
        /// Programmable voltage detector enable
        PVDE: u1,
        /// Programmable voltage detector level selection These bits select the voltage threshold detected by the PVD. Note: Refer to Section Electrical characteristics of the product datasheet for more details.
        PLS: u3,
        /// Disable backup domain write protection In reset state, the RCC_BDCR register, the RTC registers (including the backup registers), BREN and MOEN bits in PWR_CR2 register, are protected against parasitic write access. This bit must be set to enable write access to these registers.
        DBP: u1,
        /// Flash low-power mode in DStop mode This bit allows to obtain the best trade-off between low-power consumption and restart time when exiting from DStop mode. When it is set, the Flash memory enters low-power mode when D1 domain is in DStop mode.
        FLPS: u1,
        reserved14: u4 = 0,
        /// System Stop mode voltage scaling selection These bits control the VCORE voltage level in system Stop mode, to obtain the best trade-off between power consumption and performance.
        SVOS: u2,
        /// Peripheral voltage monitor on VDDA enable
        AVDEN: u1,
        /// Analog voltage detector level selection These bits select the voltage threshold detected by the AVD.
        ALS: u2,
        padding: u13 = 0,
    }),
    /// PWR control status register 1
    /// offset: 0x04
    CSR1: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Programmable voltage detect output This bit is set and cleared by hardware. It is valid only if the PVD has been enabled by the PVDE bit. Note: since the PVD is disabled in Standby mode, this bit is equal to 0 after Standby or reset until the PVDE bit is set.
        PVDO: u1,
        reserved13: u8 = 0,
        /// Voltage levels ready bit for currently used VOS and SDLEVEL This bit is set to 1 by hardware when the voltage regulator and the SD converter are both disabled and Bypass mode is selected in PWR control register 3 (PWR_CR3).
        ACTVOSRDY: u1,
        /// VOS currently applied for VCORE voltage scaling selection. These bits reflect the last VOS value applied to the PMU.
        ACTVOS: u2,
        /// Analog voltage detector output on VDDA This bit is set and cleared by hardware. It is valid only if AVD on VDDA is enabled by the AVDEN bit. Note: Since the AVD is disabled in Standby mode, this bit is equal to 0 after Standby or reset until the AVDEN bit is set.
        AVDO: u1,
        padding: u15 = 0,
    }),
    /// This register is not reset by wakeup from Standby mode, RESET signal and VDD POR. It is only reset by VSW POR and VSWRST reset. This register shall not be accessed when VSWRST bit in RCC_BDCR register resets the VSW domain.After reset, PWR_CR2 register is write-protected. Prior to modifying its content, the DBP bit in PWR_CR1 register must be set to disable the write protection.
    /// offset: 0x08
    CR2: mmio.Mmio(packed struct(u32) {
        /// Backup regulator enable When set, the Backup regulator (used to maintain the backup RAM content in Standby and VBAT modes) is enabled. If BREN is reset, the backup regulator is switched off. The backup RAM can still be used in Run and Stop modes. However, its content will be lost in Standby and VBAT modes. If BREN is set, the application must wait till the Backup Regulator Ready flag (BRRDY) is set to indicate that the data written into the SRAM will be maintained in Standby and VBAT modes.
        BREN: u1,
        reserved4: u3 = 0,
        /// VBAT and temperature monitoring enable When set, the VBAT supply and temperature monitoring is enabled.
        MONEN: u1,
        reserved16: u11 = 0,
        /// Backup regulator ready This bit is set by hardware to indicate that the Backup regulator is ready.
        BRRDY: u1,
        reserved20: u3 = 0,
        /// VBAT level monitoring versus low threshold
        VBATL: u1,
        /// VBAT level monitoring versus high threshold
        VBATH: u1,
        /// Temperature level monitoring versus low threshold
        TEMPL: u1,
        /// Temperature level monitoring versus high threshold
        TEMPH: u1,
        padding: u8 = 0,
    }),
    /// Reset only by POR only, not reset by wakeup from Standby mode and RESET pad. The lower byte of this register is written once after POR and shall be written before changing VOS level or ck_sys clock frequency. No limitation applies to the upper bytes.Programming data corresponding to an invalid combination of SDLEVEL, SDEXTHP, SDEN, LDOEN and BYPASS bits (see Table9) will be ignored: data will not be written, the written-once mechanism will lock the register and any further write access will be ignored. The default supply configuration will be kept and the ACTVOSRDY bit in PWR control status register 1 (PWR_CSR1) will go on indicating invalid voltage levels. The system shall be power cycled before writing a new value.
    /// offset: 0x0c
    CR3: mmio.Mmio(packed struct(u32) {
        /// Power management unit bypass
        BYPASS: u1,
        /// Low drop-out regulator enable
        LDOEN: u1,
        /// SD converter Enable
        SDEN: u1,
        /// Step-down converter forced ON and in High Power MR mode
        SDEXTHP: u1,
        /// Step-down converter voltage output level selection
        SDLEVEL: SDLEVEL,
        reserved8: u2 = 0,
        /// VBAT charging enable
        VBE: u1,
        /// VBAT charging resistor selection
        VBRS: u1,
        reserved16: u6 = 0,
        /// SMPS step-down converter external supply ready
        SDEXTRDY: u1,
        reserved24: u7 = 0,
        /// VDD33USB voltage level detector enable.
        USB33DEN: u1,
        /// USB regulator enable.
        USBREGEN: u1,
        /// USB supply ready.
        USB33RDY: u1,
        padding: u5 = 0,
    }),
    /// This register allows controlling CPU1 power.
    /// offset: 0x10
    CPUCR: mmio.Mmio(packed struct(u32) {
        /// D1 domain Power Down Deepsleep selection. This bit allows CPU1 to define the Deepsleep mode for D1 domain.
        PDDS_D1: u1,
        /// D2 domain Power Down Deepsleep. This bit allows CPU1 to define the Deepsleep mode for D2 domain.
        PDDS_D2: u1,
        /// System D3 domain Power Down Deepsleep. This bit allows CPU1 to define the Deepsleep mode for System D3 domain.
        PDDS_D3: u1,
        reserved5: u2 = 0,
        /// STOP flag This bit is set by hardware and cleared only by any reset or by setting the CPU1 CSSF bit.
        STOPF: u1,
        /// System Standby flag This bit is set by hardware and cleared only by a POR (Power-on Reset) or by setting the CPU1 CSSF bit
        SBF: u1,
        /// D1 domain DStandby flag This bit is set by hardware and cleared by any system reset or by setting the CPU1 CSSF bit. Once set, this bit can be cleared only when the D1 domain is no longer in DStandby mode.
        SBF_D1: u1,
        /// D2 domain DStandby flag This bit is set by hardware and cleared by any system reset or by setting the CPU1 CSSF bit. Once set, this bit can be cleared only when the D2 domain is no longer in DStandby mode.
        SBF_D2: u1,
        /// Clear D1 domain CPU1 Standby, Stop and HOLD flags (always read as 0) This bit is cleared to 0 by hardware.
        CSSF: u1,
        reserved11: u1 = 0,
        /// Keep system D3 domain in Run mode regardless of the CPU sub-systems modes
        RUN_D3: u1,
        padding: u20 = 0,
    }),
    /// offset: 0x14
    reserved20: [4]u8,
    /// This register allows controlling D3 domain power.Following reset VOSRDY will be read 1 by software
    /// offset: 0x18
    D3CR: mmio.Mmio(packed struct(u32) {
        reserved13: u13 = 0,
        /// VOS Ready bit for VCORE voltage scaling output selection. This bit is set to 1 by hardware when Bypass mode is selected in PWR control register 3 (PWR_CR3).
        VOSRDY: u1,
        /// Voltage scaling selection according to performance These bits control the VCORE voltage level and allow to obtains the best trade-off between power consumption and performance: When increasing the performance, the voltage scaling shall be changed before increasing the system frequency. When decreasing performance, the system frequency shall first be decreased before changing the voltage scaling.
        VOS: VOS,
        padding: u16 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// reset only by system reset, not reset by wakeup from Standby mode5 wait states are required when writing this register (when clearing a WKUPF bit in PWR_WKUPFR, the AHB write access will complete after the WKUPF has been cleared).
    /// offset: 0x20
    WKUPCR: mmio.Mmio(packed struct(u32) {
        /// Clear Wakeup pin flag for WKUP. These bits are always read as 0.
        WKUPC: u6,
        padding: u26 = 0,
    }),
    /// reset only by system reset, not reset by wakeup from Standby mode
    /// offset: 0x24
    WKUPFR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[0]": u1,
        /// (2/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[1]": u1,
        /// (3/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[2]": u1,
        /// (4/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[3]": u1,
        /// (5/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[4]": u1,
        /// (6/6 of WKUPF) Wakeup pin WKUPF flag. This bit is set by hardware and cleared only by a Reset pin or by setting the WKUPCn+1 bit in the PWR wakeup clear register (PWR_WKUPCR).
        @"WKUPF[5]": u1,
        padding: u26 = 0,
    }),
    /// Reset only by system reset, not reset by wakeup from Standby mode
    /// offset: 0x28
    WKUPEPR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[0]": u1,
        /// (2/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[1]": u1,
        /// (3/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[2]": u1,
        /// (4/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[3]": u1,
        /// (5/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[4]": u1,
        /// (6/6 of WKUPEN) Enable Wakeup Pin WKUPn+1 Each bit is set and cleared by software. Note: An additional wakeup event is detected if WKUPn+1 pin is enabled (by setting the WKUPENn+1 bit) when WKUPn+1 pin level is already high when WKUPPn+1 selects rising edge, or low when WKUPPn+1 selects falling edge.
        @"WKUPEN[5]": u1,
        reserved8: u2 = 0,
        /// (1/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[0]": u1,
        /// (2/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[1]": u1,
        /// (3/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[2]": u1,
        /// (4/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[3]": u1,
        /// (5/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[4]": u1,
        /// (6/6 of WKUPP) Wakeup pin polarity bit for WKUPn-7 These bits define the polarity used for event detection on WKUPn-7 external wakeup pin.
        @"WKUPP[5]": u1,
        reserved16: u2 = 0,
        /// (1/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[0]": WKUPPUPD,
        /// (2/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[1]": WKUPPUPD,
        /// (3/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[2]": WKUPPUPD,
        /// (4/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[3]": WKUPPUPD,
        /// (5/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[4]": WKUPPUPD,
        /// (6/6 of WKUPPUPD) Wakeup pin pull configuration
        @"WKUPPUPD[5]": WKUPPUPD,
        padding: u4 = 0,
    }),
};
