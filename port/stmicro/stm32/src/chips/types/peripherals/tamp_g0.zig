const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Tamper and backup registers
pub const TAMP = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// (1/2 of TAMPE) Tamper detection on IN X enable
        @"TAMPE[0]": u1,
        /// (2/2 of TAMPE) Tamper detection on IN X enable
        @"TAMPE[1]": u1,
        reserved16: u14 = 0,
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
        /// (1/2 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[0]": u1,
        /// (2/2 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[1]": u1,
        reserved16: u14 = 0,
        /// (1/2 of TAMPMSK) Tamper X mask
        @"TAMPMSK[0]": u1,
        /// (2/2 of TAMPMSK) Tamper X mask
        @"TAMPMSK[1]": u1,
        reserved24: u6 = 0,
        /// (1/2 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[0]": u1,
        /// (2/2 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[1]": u1,
        padding: u6 = 0,
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
        /// (1/2 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[0]": u1,
        /// (2/2 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[1]": u1,
        reserved16: u14 = 0,
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
        /// (1/2 of TAMPF) Tamper X detection flag
        @"TAMPF[0]": u1,
        /// (2/2 of TAMPF) Tamper X detection flag
        @"TAMPF[1]": u1,
        reserved16: u14 = 0,
        /// (1/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[0]": u1,
        /// (2/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[1]": u1,
        /// (3/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[2]": u1,
        /// (4/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[3]": u1,
        /// (5/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[4]": u1,
        /// (6/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[5]": u1,
        /// (7/7 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[6]": u1,
        padding: u9 = 0,
    }),
    /// TAMP masked interrupt status register
    /// offset: 0x34
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[0]": u1,
        /// (2/2 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[1]": u1,
        reserved16: u14 = 0,
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
        /// (1/2 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[0]": u1,
        /// (2/2 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[1]": u1,
        reserved16: u14 = 0,
        /// (1/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[0]": u1,
        /// (2/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[1]": u1,
        /// (3/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[2]": u1,
        /// (4/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[3]": u1,
        /// (5/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[4]": u1,
        /// (6/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[5]": u1,
        /// (7/7 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[6]": u1,
        padding: u9 = 0,
    }),
    /// offset: 0x40
    reserved64: [192]u8,
    /// TAMP backup register
    /// offset: 0x100
    BKPR: [5]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
    /// offset: 0x114
    reserved276: [728]u8,
    /// TAMP hardware configuration register 2
    /// offset: 0x3ec
    HWCFGR2: mmio.Mmio(packed struct(u32) {
        /// PTIONREG_OUT
        PTIONREG_OUT: u8,
        /// TRUST_ZONE
        TRUST_ZONE: u4,
        padding: u20 = 0,
    }),
    /// TAMP hardware configuration register 1
    /// offset: 0x3f0
    HWCFGR1: mmio.Mmio(packed struct(u32) {
        /// BACKUP_REGS
        BACKUP_REGS: u8,
        /// TAMPER
        TAMPER: u4,
        /// ACTIVE_TAMPER
        ACTIVE_TAMPER: u4,
        /// INT_TAMPER
        INT_TAMPER: u16,
    }),
    /// EXTI IP Version register
    /// offset: 0x3f4
    VERR: mmio.Mmio(packed struct(u32) {
        /// Minor Revision number
        MINREV: u4,
        /// Major Revision number
        MAJREV: u4,
        padding: u24 = 0,
    }),
    /// EXTI Identification register
    /// offset: 0x3f8
    IPIDR: mmio.Mmio(packed struct(u32) {
        /// IP Identification
        IPID: u32,
    }),
    /// EXTI Size ID register
    /// offset: 0x3fc
    SIDR: mmio.Mmio(packed struct(u32) {
        /// Size Identification
        SID: u32,
    }),
};
