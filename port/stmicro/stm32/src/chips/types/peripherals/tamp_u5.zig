const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ATCKSEL = enum(u3) {
    /// RTCCLK is selected
    Div1 = 0x0,
    /// RTCCLK/2 is selected when (PREDIV_A+1) = 128 (actually selects 1st flip flop output)
    Div2 = 0x1,
    /// RTCCLK/4 is selected when (PREDIV_A+1) = 128 (actually selects 2nd flip flop output)
    Div4 = 0x2,
    /// RTCCLK/128 is selected when (PREDIV_A+1) = 128 (actually selects 7th flip flop output)
    Div128 = 0x7,
    _,
};

pub const TAMPFLT = enum(u2) {
    /// Tamper event is activated on edge of INx input transitions to the active level (no internal pull-up on INx input).
    NoFilter = 0x0,
    /// Tamper event is activated after 2 consecutive samples at the active level.
    Filter2 = 0x1,
    /// Tamper event is activated after 4 consecutive samples at the active level.
    Filter4 = 0x2,
    /// Tamper event is activated after 8 consecutive samples at the active level.
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
    /// If TAMPFLT 00 Tamper 2 input staying low triggers a tamper detection event.
    FilteredLowOrUnfilteredHigh = 0x0,
    /// If TAMPFLT 00 Tamper 2 input staying high triggers a tamper detection event.
    FilteredHighOrUnfilteredLow = 0x1,
};

/// Tamper and backup registers
pub const TAMP = extern struct {
    /// TAMP control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[0]": u1,
        /// (2/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[1]": u1,
        /// (3/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[2]": u1,
        /// (4/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[3]": u1,
        /// (5/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[4]": u1,
        /// (6/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[5]": u1,
        /// (7/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[6]": u1,
        /// (8/8 of TAMPE) Tamper detection on INx enable
        @"TAMPE[7]": u1,
        reserved16: u8 = 0,
        /// (1/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[0]": u1,
        /// (2/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[1]": u1,
        /// (3/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[2]": u1,
        /// (4/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[3]": u1,
        /// (5/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[4]": u1,
        /// (6/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[5]": u1,
        /// (7/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[6]": u1,
        /// (8/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[7]": u1,
        /// (9/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[8]": u1,
        /// (10/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[9]": u1,
        /// (11/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[10]": u1,
        /// (12/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[11]": u1,
        /// (13/13 of ITAMPE) Internal tamper X enable
        @"ITAMPE[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP control register 2
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
        /// (1/3 of TAMPMSK) Tamper X mask. The tamper 1 interrupt must not be enabled when TAMP1MSK is set.
        @"TAMPMSK[0]": u1,
        /// (2/3 of TAMPMSK) Tamper X mask. The tamper 1 interrupt must not be enabled when TAMP1MSK is set.
        @"TAMPMSK[1]": u1,
        /// (3/3 of TAMPMSK) Tamper X mask. The tamper 1 interrupt must not be enabled when TAMP1MSK is set.
        @"TAMPMSK[2]": u1,
        reserved22: u3 = 0,
        /// Backup registers and device secrets access blocked
        BKBLOCK: u1,
        /// Backup registers and device secrets erase. Writing '1 to this bit reset the backup registers and device secrets(1). Writing 0 has no effect. This bit is always read as 0.
        BKERASE: u1,
        /// (1/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[0]": TAMPTRG,
        /// (2/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[1]": TAMPTRG,
        /// (3/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[2]": TAMPTRG,
        /// (4/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[3]": TAMPTRG,
        /// (5/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[4]": TAMPTRG,
        /// (6/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[5]": TAMPTRG,
        /// (7/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[6]": TAMPTRG,
        /// (8/8 of TAMPTRG) Active level for tamper 1 input.
        @"TAMPTRG[7]": TAMPTRG,
    }),
    /// TAMP control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// (1/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[0]": u1,
        /// (2/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[1]": u1,
        /// (3/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[2]": u1,
        /// (4/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[3]": u1,
        /// (5/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[4]": u1,
        /// (6/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[5]": u1,
        /// (7/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[6]": u1,
        /// (8/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[7]": u1,
        /// (9/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[8]": u1,
        /// (10/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[9]": u1,
        /// (11/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[10]": u1,
        /// (12/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[11]": u1,
        /// (13/13 of ITAMPNOER) Internal Tamper X no erase
        @"ITAMPNOER[12]": u1,
        padding: u19 = 0,
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
    /// TAMP active tamper control register 1
    /// offset: 0x10
    ATCR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[0]": u1,
        /// (2/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[1]": u1,
        /// (3/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[2]": u1,
        /// (4/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[3]": u1,
        /// (5/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[4]": u1,
        /// (6/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[5]": u1,
        /// (7/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[6]": u1,
        /// (8/8 of TAMPAM) Tamper X active mode
        @"TAMPAM[7]": u1,
        /// (1/4 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout
        @"ATOSEL[0]": u2,
        /// (2/4 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout
        @"ATOSEL[1]": u2,
        /// (3/4 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout
        @"ATOSEL[2]": u2,
        /// (4/4 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout
        @"ATOSEL[3]": u2,
        /// Active tamper RTC asynchronous prescaler clock selection. These bits selects the RTC asynchronous prescaler stage output.The selected clock is CK_ATPRE.. fCK_ATPRE = fRTCCLK / 2ATCKSEL when (PREDIV_A+1) = 128.. .... These bits can be written only when all active tampers are disabled. The write protection remains for up to 1.5 ck_atpre cycles after all the active tampers are disable.
        ATCKSEL: ATCKSEL,
        reserved24: u5 = 0,
        /// Active tamper output change period. The tamper output is changed every CK_ATPER = (2ATPER x CK_ATPRE) cycles. Refer to .
        ATPER: u3,
        reserved30: u3 = 0,
        /// Active tamper output sharing. IN1 is compared with TAMPOUTSEL1. IN2 is compared with TAMPOUTSEL2. IN3 is compared with TAMPOUTSEL3. IN4 is compared with TAMPOUTSEL4. IN5 is compared with TAMPOUTSEL5. IN6 is compared with TAMPOUTSEL6. IN7 is compared with TAMPOUTSEL7. IN8 is compared with TAMPOUTSEL8
        ATOSHARE: u1,
        /// Active tamper filter enable
        FLTEN: u1,
    }),
    /// TAMP active tamper seed register
    /// offset: 0x14
    ATSEEDR: mmio.Mmio(packed struct(u32) {
        /// Pseudo-random generator seed value. This register must be written four times with 32-bit values to provide the 128-bit seed to the PRNG. Writing to this register automatically sends the seed value to the PRNG.
        SEED: u32,
    }),
    /// TAMP active tamper output register
    /// offset: 0x18
    ATOR: mmio.Mmio(packed struct(u32) {
        /// Pseudo-random generator value. This field provides the values of the PRNG output. Because of potential inconsistencies due to synchronization delays, PRNG must be read at least twice. The read value is correct if it is equal to previous read value. This field can only be read when the APB is in secure mode.
        PRNG: u8,
        reserved14: u6 = 0,
        /// Seed running flag. This flag is set by hardware when a new seed is written in the ATSEEDR. It is cleared by hardware when the PRNG has absorbed this new seed, and by system reset. The TAMP APB cock must not be switched off as long as SEEDF is set.
        SEEDF: u1,
        /// Active tamper initialization status. This flag is set by hardware when the PRNG has absorbed the first 128-bit seed, meaning that the enabled active tampers are functional. This flag is cleared when the active tampers are disabled.
        INITS: u1,
        padding: u16 = 0,
    }),
    /// TAMP active tamper control register 2
    /// offset: 0x1c
    ATCR2: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// (1/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[0]": u3,
        /// (2/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[1]": u3,
        /// (3/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[2]": u3,
        /// (4/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[3]": u3,
        /// (5/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[4]": u3,
        /// (6/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[5]": u3,
        /// (7/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[6]": u3,
        /// (8/8 of ATOSEL) Active tamper shared output X selection. The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSEL1[1:0] in the ATCR1, and so can also be read or. written through ATCR1.
        @"ATOSEL[7]": u3,
    }),
    /// TAMP secure mode register
    /// offset: 0x20
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// Backup registers read/write protection offset. Protection zone 1 is defined for backup registers from BKP0R to BKPxR (x = BKPRWSEC-1, from 0 to 128). if TZEN=1, these backup registers can be read and written only with secure access. If TZEN=0: the protection zone 1 can be read and written with non-secure access. If BKPRWSEC = 0: there is no protection zone 1. If BKPRWPRIV is set, BKPRWSEC[7:0] can be written only in privileged mode.
        BKPRWSEC: u8,
        reserved15: u7 = 0,
        /// Monotonic counter 1 secure protection
        CNT1SEC: u1,
        /// Backup registers write protection offset. Protection zone 2 is defined for backup registers from BKPyR (y = BKPRWSEC, from 0 to 128) to BKPzR (z = BKPWSEC-1, from 0 to 128, BKPWSECBKPRWSEC): if TZEN=1, these backup registers can be written only with secure access. They can be read with secure or non-secure access. Protection zone 3 defined for backup registers from BKPtR (t = BKPWSEC, from 0 to 127). They can be read or written with secure or non-secure access. If TZEN=0: the protection zone 2 can be read and written with non-secure access. If BKPWSEC = 0 or if BKPWSEC BKPRWSEC: there is no protection zone 2. If BKPWPRIV is set, BKPRWSEC[7:0] can be written only in privileged mode.
        BKPWSEC: u8,
        reserved30: u6 = 0,
        /// Boot hardware key lock. This bit can be read and can only be written to 1 by software. It is cleared by hardware together with the backup registers following a tamper detection event or when the readout protection (RDP) is disabled.
        BHKLOCK: u1,
        /// Tamper protection (excluding monotonic counters and backup registers). Note: Refer to for details on the read protection.
        TAMPSEC: u1,
    }),
    /// TAMP privilege mode control register
    /// offset: 0x24
    PRIVCR: mmio.Mmio(packed struct(u32) {
        reserved15: u15 = 0,
        /// Monotonic counter 1 privilege protection
        CNT1PRIV: u1,
        reserved29: u13 = 0,
        /// Backup registers zone 1 privilege protection
        BKPRWPRIV: u1,
        /// Backup registers zone 2 privilege protection
        BKPWPRIV: u1,
        /// Tamper privilege protection (excluding backup registers). Note: Refer to for details on the read protection.
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
        /// (1/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[0]": u1,
        /// (2/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[1]": u1,
        /// (3/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[2]": u1,
        /// (4/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[3]": u1,
        /// (5/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[4]": u1,
        /// (6/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[5]": u1,
        /// (7/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[6]": u1,
        /// (8/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[7]": u1,
        /// (9/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[8]": u1,
        /// (10/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[9]": u1,
        /// (11/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[10]": u1,
        /// (12/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[11]": u1,
        /// (13/13 of ITAMPIE) Internal tamper X interrupt enable
        @"ITAMPIE[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP status register
    /// offset: 0x30
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[0]": u1,
        /// (2/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[1]": u1,
        /// (3/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[2]": u1,
        /// (4/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[3]": u1,
        /// (5/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[4]": u1,
        /// (6/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[5]": u1,
        /// (7/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[6]": u1,
        /// (8/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input.
        @"TAMPF[7]": u1,
        reserved16: u8 = 0,
        /// (1/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[0]": u1,
        /// (2/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[1]": u1,
        /// (3/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[2]": u1,
        /// (4/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[3]": u1,
        /// (5/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[4]": u1,
        /// (6/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[5]": u1,
        /// (7/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[6]": u1,
        /// (8/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[7]": u1,
        /// (9/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[8]": u1,
        /// (10/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[9]": u1,
        /// (11/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[10]": u1,
        /// (12/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[11]": u1,
        /// (13/13 of ITAMPF) Internal tamper X flag. This flag is set by hardware when a tamper detection event is detected on the internal tamper X.
        @"ITAMPF[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP non-secure masked interrupt status register
    /// offset: 0x34
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) TAMPx non-secure interrupt masked flag. This flag is set by hardware when the tamper X non-secure interrupt is raised.
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// (1/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[0]": u1,
        /// (2/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[1]": u1,
        /// (3/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[2]": u1,
        /// (4/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[3]": u1,
        /// (5/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[4]": u1,
        /// (6/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[5]": u1,
        /// (7/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[6]": u1,
        /// (8/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[7]": u1,
        /// (9/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[8]": u1,
        /// (10/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[9]": u1,
        /// (11/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[10]": u1,
        /// (12/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[11]": u1,
        /// (13/13 of ITAMPMF) Internal tamper X non-secure interrupt masked flag. This flag is set by hardware when the internal tamper X non-secure interrupt is raised.
        @"ITAMPMF[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP secure masked interrupt status register
    /// offset: 0x38
    SMISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper X secure interrupt is raised.
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// (1/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[0]": u1,
        /// (2/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[1]": u1,
        /// (3/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[2]": u1,
        /// (4/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[3]": u1,
        /// (5/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[4]": u1,
        /// (6/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[5]": u1,
        /// (7/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[6]": u1,
        /// (8/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[7]": u1,
        /// (9/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[8]": u1,
        /// (10/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[9]": u1,
        /// (11/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[10]": u1,
        /// (12/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[11]": u1,
        /// (13/13 of ITAMPMF) Internal tamper X secure interrupt masked flag. This flag is set by hardware when the internal tamper X secure interrupt is raised.
        @"ITAMPMF[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP status clear register
    /// offset: 0x3c
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[0]": u1,
        /// (2/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[1]": u1,
        /// (3/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[2]": u1,
        /// (4/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[3]": u1,
        /// (5/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[4]": u1,
        /// (6/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[5]": u1,
        /// (7/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[6]": u1,
        /// (8/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the SR register.
        @"CTAMPF[7]": u1,
        reserved16: u8 = 0,
        /// (1/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[0]": u1,
        /// (2/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[1]": u1,
        /// (3/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[2]": u1,
        /// (4/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[3]": u1,
        /// (5/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[4]": u1,
        /// (6/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[5]": u1,
        /// (7/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[6]": u1,
        /// (8/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[7]": u1,
        /// (9/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[8]": u1,
        /// (10/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[9]": u1,
        /// (11/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[10]": u1,
        /// (12/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[11]": u1,
        /// (13/13 of CITAMPF) Clear ITAMPx detection flag. Writing 1 in this bit clears the ITAMPxF bit in the SR register.
        @"CITAMPF[12]": u1,
        padding: u3 = 0,
    }),
    /// TAMP monotonic counter 1 register
    /// offset: 0x40
    COUNTR: mmio.Mmio(packed struct(u32) {
        /// This register is read-only only and is incremented by one when a write access is done to this register. This register cannot roll-over and is frozen when reaching the maximum value.
        COUNT: u32,
    }),
    /// offset: 0x44
    reserved68: [16]u8,
    /// TAMP erase configuration register
    /// offset: 0x54
    ERCFGR: mmio.Mmio(packed struct(u32) {
        /// Configurable device secrets configuration
        ERCFG0: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x58
    reserved88: [168]u8,
    /// TAMP backup X register
    /// offset: 0x100
    BKPR: [32]mmio.Mmio(packed struct(u32) {
        /// The application can write or read data to and from these registers. In the default (ERASE) configuration this register is reset on a tamper detection event. It is forced to reset value as long as there is at least one internal or external tamper flag being set. This register is also reset when the readout protection (RDP) is disabled.
        BKP: u32,
    }),
};
