const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const PDDS = enum(u1) {
    /// Enter Stop mode when the CPU enters deepsleep
    STOP_MODE = 0x0,
    /// Enter Standby mode when the CPU enters deepsleep
    STANDBY_MODE = 0x1,
};

pub const VOS = enum(u2) {
    /// Scale 3 mode (STM32F4[23] ONLY)
    SCALE3 = 0x1,
    /// Scale 2 mode
    SCALE2 = 0x2,
    /// Scale 1 mode (reset value)
    SCALE1 = 0x3,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// power control register
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power deep sleep
        LPDS: u1,
        /// Power down deepsleep
        PDDS: PDDS,
        /// Clear wakeup flag
        CWUF: u1,
        /// Clear standby flag
        CSBF: u1,
        /// Power voltage detector enable
        PVDE: u1,
        /// PVD level selection
        PLS: u3,
        /// Disable backup domain write protection
        DBP: u1,
        /// Flash power down in Stop mode
        FPDS: u1,
        /// Low-Power Regulator Low Voltage in deepsleep
        LPLVDS: u1,
        /// Main regulator low voltage in deepsleep mode
        MRLVDS: u1,
        reserved13: u1 = 0,
        /// ADCDC1
        ADCDC1: u1,
        /// Regulator voltage scaling output selection
        VOS: VOS,
        /// Over-drive enable (STM32F4[23] ONLY)
        ODEN: u1,
        /// Over-drive switching enabled (STM32F4[23] ONLY)
        ODSWEN: u1,
        /// Under-drive enable in stop mode (STM32F4[23] ONLY)
        UDEN: u2,
        /// Flash Memory Stop while System Run
        FMSSR: u1,
        /// Flash Interface Stop while System Run
        FISSR: u1,
        padding: u10 = 0,
    }),
    /// power control/status register
    /// offset: 0x04
    CSR1: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag
        WUF: u1,
        /// Standby flag
        SBF: u1,
        /// PVD output
        PVDO: u1,
        /// Backup regulator ready
        BRR: u1,
        reserved7: u3 = 0,
        /// Enable WKUP2 pin
        EWUP2: u1,
        /// Enable WKUP pin
        EWUP: u1,
        /// Backup regulator enable
        BRE: u1,
        reserved14: u4 = 0,
        /// Regulator voltage scaling output selection ready bit (STM32F4[23] ONLY)
        VOSRDY: u1,
        reserved16: u1 = 0,
        /// Over-drive mode ready (STM32F4[23] ONLY)
        ODRDY: u1,
        /// Over-drive mode switching ready (STM32F4[23] ONLY)
        ODSWRDY: u1,
        /// Under-drive ready flag
        UDRDY: u2,
        padding: u12 = 0,
    }),
};
