const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

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
        /// (1/3 of ENSD) ENable SD1 ADC
        @"ENSD[0]": u1,
        /// (2/3 of ENSD) ENable SD1 ADC
        @"ENSD[1]": u1,
        /// (3/3 of ENSD) ENable SD1 ADC
        @"ENSD[2]": u1,
        padding: u20 = 0,
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
        /// Internal voltage reference ready flag
        VREFINTRDYF: u1,
        reserved8: u4 = 0,
        /// (1/2 of EWUP) Enable WKUP1 pin
        @"EWUP[0]": u1,
        /// (2/2 of EWUP) Enable WKUP1 pin
        @"EWUP[1]": u1,
        padding: u22 = 0,
    }),
};
