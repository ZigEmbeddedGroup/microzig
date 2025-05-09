const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const BKERASE = enum(u1) {
    /// Reset backup registers
    Reset = 0x1,
    _,
};

pub const TAMPFLT = enum(u2) {
    /// Tamper event is activated on edge of TAMP_INx input transitions to the active level (no internal pull-up on TAMP_INx input)"
    NoFilter = 0x0,
    /// Tamper event is activated after 2 consecutive samples at the active level"
    Filter2 = 0x1,
    /// Tamper event is activated after 4 consecutive samples at the active level"
    Filter4 = 0x2,
    /// Tamper event is activated after 8 consecutive samples at the active level"
    Filter8 = 0x3,
};

pub const TAMPFREQ = enum(u3) {
    /// RTCCLK / 32768 (1 Hz when RTCCLK = 32768 Hz)
    Hz_1 = 0x0,
    /// RTCCLK / 16384 (2 Hz when RTCCLK = 32768 Hz)
    Hz_2 = 0x1,
    /// RTCCLK / 8192 (4 Hz when RTCCLK = 32768 Hz)
    Hz_4 = 0x2,
    /// RTCCLK / 4096 (8 Hz when RTCCLK = 32768 Hz)
    Hz_8 = 0x3,
    /// RTCCLK / 2048 (16 Hz when RTCCLK = 32768 Hz)
    Hz_16 = 0x4,
    /// RTCCLK / 1024 (32 Hz when RTCCLK = 32768 Hz)
    Hz_32 = 0x5,
    /// RTCCLK / 512 (64 Hz when RTCCLK = 32768 Hz)
    Hz_64 = 0x6,
    /// RTCCLK / 256 (128 Hz when RTCCLK = 32768 Hz)
    Hz_128 = 0x7,
};

pub const TAMPMSK = enum(u1) {
    /// Tamper x event generates a trigger event and TAMPxF must be cleared by software to allow next tamper event detection
    ResetBySoftware = 0x0,
    /// Tamper x event generates a trigger event. TAMPxF is masked and internally cleared by hardware. The backup registers are not erased. The tamper x interrupt must not be enabled when TAMP3MSK is set
    ResetByHardware = 0x1,
};

pub const TAMPPRCH = enum(u2) {
    /// 1 RTCCLK cycle
    Cycles1 = 0x0,
    /// 2 RTCCLK cycles
    Cycles2 = 0x1,
    /// 4 RTCCLK cycles
    Cycles4 = 0x2,
    /// 8 RTCCLK cycles
    Cycles8 = 0x3,
};

pub const TAMPTRG = enum(u1) {
    /// If TAMPFLT != 00 Tamper x input staying low triggers a tamper detection event. If TAMPFLT = 00 Tamper x input rising edge and high level triggers a tamper detection event
    FilteredLowOrUnfilteredHigh = 0x0,
    /// If TAMPFLT != 00 Tamper x input staying high triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge and low level triggers a tamper detection event
    FilteredHighOrUnfilteredLow = 0x1,
};

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
        /// (1/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[0]": u1,
        /// (2/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[1]": u1,
        /// (3/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[2]": u1,
        /// (4/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[3]": u1,
        /// (5/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[4]": u1,
        /// (6/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[5]": u1,
        /// (7/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[6]": u1,
        /// (8/8 of ITAMPE) Internal tamper X enable
        @"ITAMPE[7]": u1,
        padding: u8 = 0,
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
        /// (1/3 of TAMPMSK) Tamper X mask. The tamper X interrupt must not be enabled when TAMPMSK is set.
        @"TAMPMSK[0]": TAMPMSK,
        /// (2/3 of TAMPMSK) Tamper X mask. The tamper X interrupt must not be enabled when TAMPMSK is set.
        @"TAMPMSK[1]": TAMPMSK,
        /// (3/3 of TAMPMSK) Tamper X mask. The tamper X interrupt must not be enabled when TAMPMSK is set.
        @"TAMPMSK[2]": TAMPMSK,
        reserved23: u4 = 0,
        /// Backup registers erase
        BKERASE: BKERASE,
        /// (1/3 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[0]": TAMPTRG,
        /// (2/3 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[1]": TAMPTRG,
        /// (3/3 of TAMPTRG) Active level for tamper X input
        @"TAMPTRG[2]": TAMPTRG,
        padding: u5 = 0,
    }),
    /// TAMP control register 3
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
        /// Tamper sampling frequency. Determines the frequency at which each of the INx inputs are sampled.
        TAMPFREQ: TAMPFREQ,
        /// INx filter count. These bits determines the number of consecutive samples at the specified level (TAMP*TRG) needed to activate a tamper event. TAMPFLT is valid for each of the INx inputs.
        TAMPFLT: TAMPFLT,
        /// INx precharge duration. These bit determines the duration of time during which the pull-up/is activated before each sample. TAMPPRCH is valid for each of the INx inputs.
        TAMPPRCH: TAMPPRCH,
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
        /// (1/3 of TAMPF) Tamper X detection flag
        @"TAMPF[0]": u1,
        /// (2/3 of TAMPF) Tamper X detection flag
        @"TAMPF[1]": u1,
        /// (3/3 of TAMPF) Tamper X detection flag
        @"TAMPF[2]": u1,
        reserved16: u13 = 0,
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
        /// (1/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[0]": u1,
        /// (2/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[1]": u1,
        /// (3/3 of TAMPMF) Tamper X interrupt masked flag
        @"TAMPMF[2]": u1,
        reserved16: u13 = 0,
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
    /// monotonic counter register
    /// offset: 0x40
    COUNTR: mmio.Mmio(packed struct(u32) {
        /// COUNT
        COUNT: u32,
    }),
    /// offset: 0x44
    reserved68: [188]u8,
    /// TAMP backup register
    /// offset: 0x100
    BKPR: [20]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
};
