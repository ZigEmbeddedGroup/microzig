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
    /// power control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
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
        padding: u22 = 0,
    }),
    /// power control/status register
    /// offset: 0x04
    CSR: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag
        WUF: u1,
        /// Standby flag
        SBF: u1,
        /// PVD output
        PVDO: u1,
        /// Backup regulator ready
        BRR: u1,
        reserved8: u4 = 0,
        /// Enable WKUP pin
        EWUP: u1,
        /// Backup regulator enable
        BRE: u1,
        padding: u22 = 0,
    }),
};
