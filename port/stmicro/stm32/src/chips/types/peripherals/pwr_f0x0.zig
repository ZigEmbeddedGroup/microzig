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
        reserved8: u4 = 0,
        /// Disable backup domain write protection
        DBP: u1,
        padding: u23 = 0,
    }),
    /// power control/status register
    /// offset: 0x04
    CSR: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag
        WUF: u1,
        /// Standby flag
        SBF: u1,
        reserved8: u6 = 0,
        /// (1/8 of EWUP) Enable WKUP pin 1
        @"EWUP[0]": u1,
        /// (2/8 of EWUP) Enable WKUP pin 1
        @"EWUP[1]": u1,
        /// (3/8 of EWUP) Enable WKUP pin 1
        @"EWUP[2]": u1,
        /// (4/8 of EWUP) Enable WKUP pin 1
        @"EWUP[3]": u1,
        /// (5/8 of EWUP) Enable WKUP pin 1
        @"EWUP[4]": u1,
        /// (6/8 of EWUP) Enable WKUP pin 1
        @"EWUP[5]": u1,
        /// (7/8 of EWUP) Enable WKUP pin 1
        @"EWUP[6]": u1,
        /// (8/8 of EWUP) Enable WKUP pin 1
        @"EWUP[7]": u1,
        padding: u16 = 0,
    }),
};
