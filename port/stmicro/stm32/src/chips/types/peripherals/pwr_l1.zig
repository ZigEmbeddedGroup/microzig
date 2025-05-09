const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const PDDS = enum(u1) {
    /// Enter Stop mode when the CPU enters deepsleep
    STOP_MODE = 0x0,
    /// Enter Standby mode when the CPU enters deepsleep
    STANDBY_MODE = 0x1,
};

pub const VOS = enum(u2) {
    /// Range 1
    Range1 = 0x1,
    /// Range 2
    Range2 = 0x2,
    /// Range 3
    Range3 = 0x3,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// power control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Low-power deep sleep
        LPSDSR: u1,
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
        /// Ultralow power mode
        ULP: u1,
        /// Fast wakeup
        FWU: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        reserved14: u1 = 0,
        /// Low power run mode
        LPRUN: u1,
        padding: u17 = 0,
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
        /// Internal voltage reference (VREFINT) ready flag
        VREFINTRDYF: u1,
        /// Voltage Scaling select flag
        VOSF: u1,
        /// Regulator LP flag
        REGLPF: u1,
        reserved8: u2 = 0,
        /// (1/3 of EWUP) Enable WKUP pin 1
        @"EWUP[0]": u1,
        /// (2/3 of EWUP) Enable WKUP pin 1
        @"EWUP[1]": u1,
        /// (3/3 of EWUP) Enable WKUP pin 1
        @"EWUP[2]": u1,
        padding: u21 = 0,
    }),
};
