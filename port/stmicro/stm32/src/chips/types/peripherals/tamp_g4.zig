const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Tamper and backup registers
pub const TAMP = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TAMPE) Tamper detection on IN X enable
        @"TAMPE[0]": u1,
        /// (2/3 of TAMPE) Tamper detection on IN X enable
        @"TAMPE[1]": u1,
        /// (3/3 of TAMPE) Tamper detection on IN X enable
        @"TAMPE[2]": u1,
        reserved16: u13 = 0,
        /// (1/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[0]": u1,
        /// (2/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[1]": u1,
        /// (3/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[2]": u1,
        /// (4/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[3]": u1,
        /// (5/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[4]": u1,
        /// (6/6 of ITAMPE) Internal tamper X enable
        @"ITAMPE[5]": u1,
        padding: u10 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[0]": u1,
        /// (2/3 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[1]": u1,
        /// (3/3 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[2]": u1,
        reserved16: u13 = 0,
        /// (1/3 of TAMPMSK) Tamper X mask.
        @"TAMPMSK[0]": u1,
        /// (2/3 of TAMPMSK) Tamper X mask.
        @"TAMPMSK[1]": u1,
        /// (3/3 of TAMPMSK) Tamper X mask.
        @"TAMPMSK[2]": u1,
        reserved24: u5 = 0,
        /// (1/3 of TAMPTRG) Active level for tamper X input.
        @"TAMPTRG[0]": u1,
        /// (2/3 of TAMPTRG) Active level for tamper X input.
        @"TAMPTRG[1]": u1,
        /// (3/3 of TAMPTRG) Active level for tamper X input.
        @"TAMPTRG[2]": u1,
        padding: u5 = 0,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// TAMP filter control register
    /// offset: 0x0c
    FLTCR: mmio.Mmio(packed struct(u32) {
        /// Tamper sampling frequency. Determines the frequency at which each of the INx inputs are sampled.
        TAMPFREQ: u3,
        /// INx filter count. These bits determines the number of consecutive samples at the specified level (TAMP*TRG) needed to activate a tamper event. TAMPFLT is valid for each of the INx inputs.
        TAMPFLT: u2,
        /// INx precharge duration. These bit determines the duration of time during which the pull-up/is activated before each sample. TAMPPRCH is valid for each of the INx inputs.
        TAMPPRCH: u2,
        /// INx pull-up disable. This bit determines if each of the TAMPx pins are precharged before each sample.
        TAMPPUDIS: u1,
        padding: u24 = 0,
    }),
    /// offset: 0x10
    reserved16: [28]u8,
    /// TAMP interrupt enable register
    /// offset: 0x2c
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[0]": u1,
        /// (2/3 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[1]": u1,
        /// (3/3 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[2]": u1,
        reserved16: u13 = 0,
        /// (1/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[0]": u1,
        /// (2/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[1]": u1,
        /// (3/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[2]": u1,
        /// (4/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[3]": u1,
        /// (5/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[4]": u1,
        /// (6/6 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[5]": u1,
        padding: u10 = 0,
    }),
    /// TAMP status register
    /// offset: 0x30
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TAMPF) Tamper X detection flag
        @"TAMPF[0]": u1,
        /// (2/3 of TAMPF) Tamper X detection flag
        @"TAMPF[1]": u1,
        /// (3/3 of TAMPF) Tamper X detection flag
        @"TAMPF[2]": u1,
        reserved16: u13 = 0,
        /// (1/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[0]": u1,
        /// (2/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[1]": u1,
        /// (3/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[2]": u1,
        /// (4/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[3]": u1,
        /// (5/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[4]": u1,
        /// (6/6 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[5]": u1,
        padding: u10 = 0,
    }),
    /// TAMP masked interrupt status register
    /// offset: 0x34
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[0]": u1,
        /// (2/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[1]": u1,
        /// (3/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[2]": u1,
        reserved16: u13 = 0,
        /// (1/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[0]": u1,
        /// (2/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[1]": u1,
        /// (3/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[2]": u1,
        /// (4/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[3]": u1,
        /// (5/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[4]": u1,
        /// (6/6 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[5]": u1,
        padding: u10 = 0,
    }),
    /// offset: 0x38
    reserved56: [4]u8,
    /// TAMP status clear register
    /// offset: 0x3c
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[0]": u1,
        /// (2/3 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[1]": u1,
        /// (3/3 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[2]": u1,
        reserved16: u13 = 0,
        /// (1/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[0]": u1,
        /// (2/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[1]": u1,
        /// (3/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[2]": u1,
        /// (4/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[3]": u1,
        /// (5/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[4]": u1,
        /// (6/6 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[5]": u1,
        padding: u10 = 0,
    }),
    /// offset: 0x40
    reserved64: [192]u8,
    /// TAMP backup register
    /// offset: 0x100
    BKPR: [32]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
};
