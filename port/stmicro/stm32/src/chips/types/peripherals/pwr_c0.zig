const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// PWR address block description
pub const PWR = extern struct {
    /// PWR control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection These bits select the low-power mode entered when CPU enters deepsleep mode. 1XX: Shutdown mode
        LPMS: u3,
        /// Flash memory powered down during Stop mode This bit determines whether the Flash memory is put in power-down mode or remains in idle mode when the device enters Stop mode.
        FPD_STOP: u1,
        reserved5: u1 = 0,
        /// Flash memory powered down during Sleep mode This bit determines whether the Flash memory is put in power-down mode or remains in idle mode when the device enters Sleep mode.
        FPD_SLP: u1,
        padding: u26 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// PWR control register 3
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
        reserved10: u4 = 0,
        /// Apply pull-up and pull-down configuration This bit determines whether the I/O pull-up and pull-down configurations defined in the PWR_PUCRx and PWR_PDCRx registers are applied.
        APC: u1,
        reserved15: u4 = 0,
        /// Enable internal wakeup line When set, a rising edge on the internal wakeup line triggers a wakeup event.
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// PWR control register 4
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
        padding: u26 = 0,
    }),
    /// PWR status register 1
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
        /// Standby/Shutdown flag This bit is set by hardware when the device enters Standby or Shutdown mode and is cleared by setting the CSBF bit in the PWR_SCR register, or by a power-on reset. It is not cleared by the system reset.
        SBF: u1,
        reserved15: u6 = 0,
        /// Wakeup flag internal This bit is set when a wakeup condition is detected on the internal wakeup line. It is cleared when all internal wakeup sources are cleared.
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// PWR status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Flash ready flag This bit is set by hardware to indicate when the Flash memory is ready to be accessed after wakeup from power-down. To place the Flash memory in power-down, set either FPD_SLP or FPD_STP bit. Note: If the system boots from SRAM, the user application must wait till FLASH_RDY bit is set, prior to jumping to Flash memory.
        FLASH_RDY: u1,
        padding: u24 = 0,
    }),
    /// PWR status clear register
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
        /// Clear standby flag Setting this bit clears the SBF flag in the PWR_SR1 register.
        CSBF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// PWR Port pull-up control register
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
    /// PWR Port pull-down control register
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
