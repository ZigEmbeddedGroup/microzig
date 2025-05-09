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
    /// Scale 3 mode
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
        reserved3: u1 = 0,
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
        /// Low-power regulator in deepsleep under-drive mode
        LPUDS: u1,
        /// Main regulator in deepsleep under-drive mode
        MRUDS: u1,
        reserved13: u1 = 0,
        /// ADCDC1
        ADCDC1: u1,
        /// Regulator voltage scaling output selection
        VOS: VOS,
        /// Over-drive enable
        ODEN: u1,
        /// Over-drive switching enabled
        ODSWEN: u1,
        /// Under-drive enable in stop mode
        UDEN: u2,
        padding: u12 = 0,
    }),
    /// power control/status register
    /// offset: 0x04
    CSR1: mmio.Mmio(packed struct(u32) {
        /// Wakeup internal flag
        WUIF: u1,
        /// Standby flag
        SBF: u1,
        /// PVD output
        PVDO: u1,
        /// Backup regulator ready
        BRR: u1,
        reserved8: u4 = 0,
        /// Enable internal wakeup
        EIWUP: u1,
        /// Backup regulator enable
        BRE: u1,
        reserved14: u4 = 0,
        /// Regulator voltage scaling output selection ready bit
        VOSRDY: u1,
        reserved16: u1 = 0,
        /// Over-drive mode ready
        ODRDY: u1,
        /// Over-drive mode switching ready
        ODSWRDY: u1,
        /// Under-drive ready flag
        UDRDY: u2,
        padding: u12 = 0,
    }),
    /// power control register
    /// offset: 0x08
    CR2: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[0]": u1,
        /// (2/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[1]": u1,
        /// (3/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[2]": u1,
        /// (4/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[3]": u1,
        /// (5/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[4]": u1,
        /// (6/6 of CWUPF) Clear Wakeup Pin flag for PA0
        @"CWUPF[5]": u1,
        reserved8: u2 = 0,
        /// (1/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[0]": u1,
        /// (2/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[1]": u1,
        /// (3/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[2]": u1,
        /// (4/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[3]": u1,
        /// (5/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[4]": u1,
        /// (6/6 of WUPP) Wakeup pin polarity bit for PA0
        @"WUPP[5]": u1,
        padding: u18 = 0,
    }),
    /// power control/status register
    /// offset: 0x0c
    CSR2: mmio.Mmio(packed struct(u32) {
        /// (1/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[0]": u1,
        /// (2/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[1]": u1,
        /// (3/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[2]": u1,
        /// (4/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[3]": u1,
        /// (5/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[4]": u1,
        /// (6/6 of WUPF) Wakeup Pin flag for PA0
        @"WUPF[5]": u1,
        reserved8: u2 = 0,
        /// (1/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[0]": u1,
        /// (2/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[1]": u1,
        /// (3/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[2]": u1,
        /// (4/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[3]": u1,
        /// (5/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[4]": u1,
        /// (6/6 of EWUP) Enable Wakeup pin for PA0
        @"EWUP[5]": u1,
        padding: u18 = 0,
    }),
};
