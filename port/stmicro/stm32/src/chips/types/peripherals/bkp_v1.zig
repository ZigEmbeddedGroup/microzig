const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ASOS = enum(u1) {
    /// RTC Alarm pulse output selected
    Alarm = 0x0,
    /// RTC Second pulse output selected
    Second = 0x1,
};

pub const TPAL = enum(u1) {
    /// A high level on the TAMPER pin resets all data backup registers (if TPE bit is set)
    High = 0x0,
    /// A low level on the TAMPER pin resets all data backup registers (if TPE bit is set)
    Low = 0x1,
};

/// Backup registers
pub const BKP = extern struct {
    /// Data register
    /// offset: 0x00
    DR: mmio.Mmio(packed struct(u32) {
        /// Backup data
        D: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x04
    reserved4: [40]u8,
    /// RTC clock calibration register
    /// offset: 0x2c
    RTCCR: mmio.Mmio(packed struct(u32) {
        /// Calibration value
        CAL: u7,
        /// Calibration Clock Output
        CCO: u1,
        /// Alarm or second output enable
        ASOE: u1,
        /// Alarm or second output selection
        ASOS: ASOS,
        padding: u22 = 0,
    }),
    /// Control register
    /// offset: 0x30
    CR: mmio.Mmio(packed struct(u32) {
        /// Tamper pin enable
        TPE: u1,
        /// Tamper pin active level
        TPAL: TPAL,
        padding: u30 = 0,
    }),
    /// Control/status register
    /// offset: 0x34
    CSR: mmio.Mmio(packed struct(u32) {
        /// Clear Tamper event
        CTE: u1,
        /// Clear Tamper Interrupt
        CTI: u1,
        /// Tamper Pin interrupt enable
        TPIE: u1,
        reserved8: u5 = 0,
        /// Tamper Event Flag
        TEF: u1,
        /// Tamper Interrupt Flag
        TIF: u1,
        padding: u22 = 0,
    }),
};
