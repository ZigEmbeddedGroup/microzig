const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Tamper and backup registers
pub const TAMP = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPE) TAMPE
        @"TAMPE[0]": u1,
        /// (2/8 of TAMPE) TAMPE
        @"TAMPE[1]": u1,
        /// (3/8 of TAMPE) TAMPE
        @"TAMPE[2]": u1,
        /// (4/8 of TAMPE) TAMPE
        @"TAMPE[3]": u1,
        /// (5/8 of TAMPE) TAMPE
        @"TAMPE[4]": u1,
        /// (6/8 of TAMPE) TAMPE
        @"TAMPE[5]": u1,
        /// (7/8 of TAMPE) TAMPE
        @"TAMPE[6]": u1,
        /// (8/8 of TAMPE) TAMPE
        @"TAMPE[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of ITAMPE) ITAMPE
        @"ITAMPE[0]": u1,
        /// (2/8 of ITAMPE) ITAMPE
        @"ITAMPE[1]": u1,
        /// (3/8 of ITAMPE) ITAMPE
        @"ITAMPE[2]": u1,
        /// (4/8 of ITAMPE) ITAMPE
        @"ITAMPE[3]": u1,
        /// (5/8 of ITAMPE) ITAMPE
        @"ITAMPE[4]": u1,
        /// (6/8 of ITAMPE) ITAMPE
        @"ITAMPE[5]": u1,
        /// (7/8 of ITAMPE) ITAMPE
        @"ITAMPE[6]": u1,
        /// (8/8 of ITAMPE) ITAMPE
        @"ITAMPE[7]": u1,
        padding: u8 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[0]": u1,
        /// (2/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[1]": u1,
        /// (3/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[2]": u1,
        /// (4/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[3]": u1,
        /// (5/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[4]": u1,
        /// (6/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[5]": u1,
        /// (7/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[6]": u1,
        /// (8/8 of TAMPNOER) Tamper X no erase
        @"TAMPNOER[7]": u1,
        reserved16: u8 = 0,
        /// (1/3 of TAMPMSK) Tamper X mask
        @"TAMPMSK[0]": u1,
        /// (2/3 of TAMPMSK) Tamper X mask
        @"TAMPMSK[1]": u1,
        /// (3/3 of TAMPMSK) Tamper X mask
        @"TAMPMSK[2]": u1,
        reserved23: u4 = 0,
        /// BKERASE
        BKERASE: u1,
        /// (1/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[0]": u1,
        /// (2/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[1]": u1,
        /// (3/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[2]": u1,
        /// (4/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[3]": u1,
        /// (5/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[4]": u1,
        /// (6/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[5]": u1,
        /// (7/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[6]": u1,
        /// (8/8 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[7]": u1,
    }),
    /// control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[0]": u1,
        /// (2/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[1]": u1,
        /// (3/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[2]": u1,
        /// (4/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[3]": u1,
        /// (5/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[4]": u1,
        /// (6/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[5]": u1,
        /// (7/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[6]": u1,
        /// (8/8 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[7]": u1,
        padding: u24 = 0,
    }),
    /// TAMP filter control register
    /// offset: 0x0c
    FLTCR: mmio.Mmio(packed struct(u32) {
        /// TAMPFREQ
        TAMPFREQ: u3,
        /// TAMPFLT
        TAMPFLT: u2,
        /// TAMPPRCH
        TAMPPRCH: u2,
        /// TAMPPUDIS
        TAMPPUDIS: u1,
        padding: u24 = 0,
    }),
    /// TAMP active tamper control register 1
    /// offset: 0x10
    ATCR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPAM) TAMPAM
        @"TAMPAM[0]": u1,
        /// (2/8 of TAMPAM) TAMPAM
        @"TAMPAM[1]": u1,
        /// (3/8 of TAMPAM) TAMPAM
        @"TAMPAM[2]": u1,
        /// (4/8 of TAMPAM) TAMPAM
        @"TAMPAM[3]": u1,
        /// (5/8 of TAMPAM) TAMPAM
        @"TAMPAM[4]": u1,
        /// (6/8 of TAMPAM) TAMPAM
        @"TAMPAM[5]": u1,
        /// (7/8 of TAMPAM) TAMPAM
        @"TAMPAM[6]": u1,
        /// (8/8 of TAMPAM) TAMPAM
        @"TAMPAM[7]": u1,
        /// (1/4 of ATOSEL) ATOSEL
        @"ATOSEL[0]": u2,
        /// (2/4 of ATOSEL) ATOSEL
        @"ATOSEL[1]": u2,
        /// (3/4 of ATOSEL) ATOSEL
        @"ATOSEL[2]": u2,
        /// (4/4 of ATOSEL) ATOSEL
        @"ATOSEL[3]": u2,
        /// ATCKSEL
        ATCKSEL: u2,
        reserved24: u6 = 0,
        /// ATPER
        ATPER: u2,
        reserved30: u4 = 0,
        /// ATOSHARE
        ATOSHARE: u1,
        /// FLTEN
        FLTEN: u1,
    }),
    /// TAMP active tamper seed register
    /// offset: 0x14
    ATSEEDR: mmio.Mmio(packed struct(u32) {
        /// Pseudo-random generator seed value
        SEED: u32,
    }),
    /// TAMP active tamper output register
    /// offset: 0x18
    ATOR: mmio.Mmio(packed struct(u32) {
        /// Pseudo-random generator value
        PRNG: u8,
        reserved14: u6 = 0,
        /// Seed running flag
        SEEDF: u1,
        /// Active tamper initialization status
        INITS: u1,
        padding: u16 = 0,
    }),
    /// TAMP active tamper control register 2
    /// offset: 0x1c
    ATCR2: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// (1/8 of ATOSEL) ATOSEL
        @"ATOSEL[0]": u3,
        /// (2/8 of ATOSEL) ATOSEL
        @"ATOSEL[1]": u3,
        /// (3/8 of ATOSEL) ATOSEL
        @"ATOSEL[2]": u3,
        /// (4/8 of ATOSEL) ATOSEL
        @"ATOSEL[3]": u3,
        /// (5/8 of ATOSEL) ATOSEL
        @"ATOSEL[4]": u3,
        /// (6/8 of ATOSEL) ATOSEL
        @"ATOSEL[5]": u3,
        /// (7/8 of ATOSEL) ATOSEL
        @"ATOSEL[6]": u3,
        /// (8/8 of ATOSEL) ATOSEL
        @"ATOSEL[7]": u3,
    }),
    /// TAMP secure mode register
    /// offset: 0x20
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Backup registers read/write protection offset
        BKPRWDPROT: u8,
        reserved16: u8 = 0,
        /// Backup registers write protection offset
        BKPWDPROT: u8,
        reserved31: u7 = 0,
        /// Tamper protection
        TAMPDPROT: u1,
    }),
    /// TAMP privilege mode control register
    /// offset: 0x24
    PRIVCR: mmio.Mmio(packed struct(u32) {
        reserved29: u29 = 0,
        /// Backup registers zone 1 privilege protection
        BKPRWPRIV: u1,
        /// Backup registers zone 2 privilege protection
        BKPWPRIV: u1,
        /// Tamper privilege protection
        TAMPPRIV: u1,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// TAMP interrupt enable register
    /// offset: 0x2c
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[0]": u1,
        /// (2/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[1]": u1,
        /// (3/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[2]": u1,
        /// (4/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[3]": u1,
        /// (5/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[4]": u1,
        /// (6/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[5]": u1,
        /// (7/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[6]": u1,
        /// (8/8 of TAMPIE) Tamper X interrupt enable
        @"TAMPIE[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[0]": u1,
        /// (2/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[1]": u1,
        /// (3/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[2]": u1,
        /// (4/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[3]": u1,
        /// (5/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[4]": u1,
        /// (6/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[5]": u1,
        /// (7/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[6]": u1,
        /// (8/8 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[7]": u1,
        padding: u8 = 0,
    }),
    /// TAMP status register
    /// offset: 0x30
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPF) Tamper X detection flag
        @"TAMPF[0]": u1,
        /// (2/8 of TAMPF) Tamper X detection flag
        @"TAMPF[1]": u1,
        /// (3/8 of TAMPF) Tamper X detection flag
        @"TAMPF[2]": u1,
        /// (4/8 of TAMPF) Tamper X detection flag
        @"TAMPF[3]": u1,
        /// (5/8 of TAMPF) Tamper X detection flag
        @"TAMPF[4]": u1,
        /// (6/8 of TAMPF) Tamper X detection flag
        @"TAMPF[5]": u1,
        /// (7/8 of TAMPF) Tamper X detection flag
        @"TAMPF[6]": u1,
        /// (8/8 of TAMPF) Tamper X detection flag
        @"TAMPF[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[0]": u1,
        /// (2/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[1]": u1,
        /// (3/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[2]": u1,
        /// (4/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[3]": u1,
        /// (5/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[4]": u1,
        /// (6/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[5]": u1,
        /// (7/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[6]": u1,
        /// (8/8 of ITAMPF) Internal tamper X detection flag
        @"ITAMPF[7]": u1,
        padding: u8 = 0,
    }),
    /// TAMP masked interrupt status register
    /// offset: 0x34
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[0]": u1,
        /// (2/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[1]": u1,
        /// (3/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[2]": u1,
        /// (4/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[3]": u1,
        /// (5/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[4]": u1,
        /// (6/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[5]": u1,
        /// (7/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[6]": u1,
        /// (8/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[7]": u1,
        padding: u8 = 0,
    }),
    /// TAMP secure masked interrupt status register
    /// offset: 0x38
    SMISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[0]": u1,
        /// (2/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[1]": u1,
        /// (3/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[2]": u1,
        /// (4/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[3]": u1,
        /// (5/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[4]": u1,
        /// (6/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[5]": u1,
        /// (7/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[6]": u1,
        /// (8/8 of ITAMPMF) Internal tamper X interrupt masked flag
        @"ITAMPMF[7]": u1,
        padding: u8 = 0,
    }),
    /// TAMP status clear register
    /// offset: 0x3c
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[0]": u1,
        /// (2/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[1]": u1,
        /// (3/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[2]": u1,
        /// (4/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[3]": u1,
        /// (5/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[4]": u1,
        /// (6/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[5]": u1,
        /// (7/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[6]": u1,
        /// (8/8 of CTAMPF) Clear tamper X detection flag
        @"CTAMPF[7]": u1,
        reserved16: u8 = 0,
        /// (1/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[0]": u1,
        /// (2/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[1]": u1,
        /// (3/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[2]": u1,
        /// (4/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[3]": u1,
        /// (5/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[4]": u1,
        /// (6/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[5]": u1,
        /// (7/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[6]": u1,
        /// (8/8 of CITAMPF) Clear internal tamper X detection flag
        @"CITAMPF[7]": u1,
        padding: u8 = 0,
    }),
    /// TAMP monotonic counter register
    /// offset: 0x40
    COUNTR: mmio.Mmio(packed struct(u32) {
        /// COUNT
        COUNT: u32,
    }),
    /// offset: 0x44
    reserved68: [12]u8,
    /// TAMP configuration register
    /// offset: 0x50
    CFGR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TMONEN
        TMONEN: u1,
        /// VMONEN
        VMONEN: u1,
        /// WUTMONEN
        WUTMONEN: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x54
    reserved84: [172]u8,
    /// TAMP backup register
    /// offset: 0x100
    BKPR: [32]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
};
