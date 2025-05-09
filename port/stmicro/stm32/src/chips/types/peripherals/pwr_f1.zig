const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const PDDS = enum(u1) {
    /// Enter Stop mode when the CPU enters deepsleep
    STOP_MODE = 0x0,
    /// Enter Standby mode when the CPU enters deepsleep
    STANDBY_MODE = 0x1,
};

/// Power control
pub const PWR = extern struct {
    /// Power control register (PWR_CR)
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Low Power Deep Sleep
        LPDS: u1,
        /// Power Down Deep Sleep
        PDDS: PDDS,
        /// Clear Wake-up Flag
        CWUF: u1,
        /// Clear STANDBY Flag
        CSBF: u1,
        /// Power Voltage Detector Enable
        PVDE: u1,
        /// PVD Level Selection
        PLS: u3,
        /// Disable Backup Domain write protection
        DBP: u1,
        padding: u23 = 0,
    }),
    /// Power control register (PWR_CR)
    /// offset: 0x04
    CSR: mmio.Mmio(packed struct(u32) {
        /// Wake-Up Flag
        WUF: u1,
        /// STANDBY Flag
        SBF: u1,
        /// PVD Output
        PVDO: u1,
        reserved8: u5 = 0,
        /// Enable WKUP pin
        EWUP: u1,
        padding: u23 = 0,
    }),
};
