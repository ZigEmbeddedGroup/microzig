const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Tamper and backup.
pub const TAMP = extern struct {
    /// TAMP control register 1.
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[0]": u1,
        /// (2/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[1]": u1,
        /// (3/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[2]": u1,
        /// (4/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[3]": u1,
        /// (5/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[4]": u1,
        /// (6/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[5]": u1,
        /// (7/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[6]": u1,
        /// (8/8 of TAMPE) Tamper detection on TAMP_INx enable. (x=1-8)
        @"TAMPE[7]": u1,
        reserved16: u8 = 0,
        /// Internal tamper 1 enable.
        ITAMP1E: u1,
        /// Internal tamper 2 enable.
        ITAMP2E: u1,
        /// Internal tamper 3 enable.
        ITAMP3E: u1,
        /// Internal tamper 4 enable.
        ITAMP4E: u1,
        /// Internal tamper 5 enable.
        ITAMP5E: u1,
        /// Internal tamper 6 enable.
        ITAMP6E: u1,
        /// Internal tamper 7 enable.
        ITAMP7E: u1,
        /// Internal tamper 8 enable.
        ITAMP8E: u1,
        /// Internal tamper 9 enable.
        ITAMP9E: u1,
        reserved26: u1 = 0,
        /// Internal tamper 11 enable.
        ITAMP11E: u1,
        /// Internal tamper 12 enable.
        ITAMP12E: u1,
        /// Internal tamper 13 enable.
        ITAMP13E: u1,
        reserved30: u1 = 0,
        /// Internal tamper 15 enable.
        ITAMP15E: u1,
        padding: u1 = 0,
    }),
    /// TAMP control register 2.
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[0]": u1,
        /// (2/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[1]": u1,
        /// (3/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[2]": u1,
        /// (4/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[3]": u1,
        /// (5/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[4]": u1,
        /// (6/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[5]": u1,
        /// (7/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[6]": u1,
        /// (8/8 of TAMPPOM) Tamper x potential mode. (x=1-8)
        @"TAMPPOM[7]": u1,
        reserved16: u8 = 0,
        /// (1/3 of TAMPMSK) Tamper x mask. The tamper x interrupt must not be enabled when TAMPxMSK is set. (x=1-3)
        @"TAMPMSK[0]": u1,
        /// (2/3 of TAMPMSK) Tamper x mask. The tamper x interrupt must not be enabled when TAMPxMSK is set. (x=1-3)
        @"TAMPMSK[1]": u1,
        /// (3/3 of TAMPMSK) Tamper x mask. The tamper x interrupt must not be enabled when TAMPxMSK is set. (x=1-3)
        @"TAMPMSK[2]": u1,
        reserved22: u3 = 0,
        /// Backup registers and device secrets access blocked.
        BKBLOCK: u1,
        /// Backup registers and device secrets erase Writing ‘1’ to this bit reset the backup registers and device secrets(1). Writing 0 has no effect. This bit is always read as 0.
        BKERASE: u1,
        /// (1/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[0]": u1,
        /// (2/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[1]": u1,
        /// (3/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[2]": u1,
        /// (4/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[3]": u1,
        /// (5/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[4]": u1,
        /// (6/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[5]": u1,
        /// (7/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[6]": u1,
        /// (8/8 of TAMPTRG) Active level for tamper x input If TAMPFLT = 00 Tamper x input rising edge triggers a tamper detection event. If TAMPFLT = 00 Tamper x input falling edge triggers a tamper detection event. (x=1-8)
        @"TAMPTRG[7]": u1,
    }),
    /// TAMP control register 3.
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// Internal tamper 1 potential mode.
        ITAMP1POM: u1,
        /// Internal tamper 2 potential mode.
        ITAMP2POM: u1,
        /// Internal tamper 3 potential mode.
        ITAMP3POM: u1,
        /// Internal tamper 4 potential mode.
        ITAMP4POM: u1,
        /// Internal tamper 5 potential mode.
        ITAMP5POM: u1,
        /// Internal tamper 6 potential mode.
        ITAMP6POM: u1,
        /// Internal tamper 7 potential mode.
        ITAMP7POM: u1,
        /// Internal tamper 8 potential mode.
        ITAMP8POM: u1,
        /// Internal tamper 9 potential mode.
        ITAMP9POM: u1,
        reserved10: u1 = 0,
        /// Internal tamper 11 potential mode.
        ITAMP11POM: u1,
        /// Internal tamper 12 potential mode.
        ITAMP12POM: u1,
        /// Internal tamper 13 potential mode.
        ITAMP13POM: u1,
        reserved14: u1 = 0,
        /// Internal tamper 15 potential mode.
        ITAMP15POM: u1,
        padding: u17 = 0,
    }),
    /// TAMP filter control register.
    /// offset: 0x0c
    FLTCR: mmio.Mmio(packed struct(u32) {
        /// Tamper sampling frequency Determines the frequency at which each of the TAMP_INx inputs are sampled.
        TAMPFREQ: u3,
        /// TAMP_INx filter count These bits determines the number of consecutive samples at the specified level (TAMP*TRG) needed to activate a tamper event. TAMPFLT is valid for each of the TAMP_INx inputs.
        TAMPFLT: u2,
        /// TAMP_INx precharge duration These bit determines the duration of time during which the pull-up/is activated before each sample. TAMPPRCH is valid for each of the TAMP_INx inputs.
        TAMPPRCH: u2,
        /// TAMP_INx pull-up disable This bit determines if each of the TAMPx pins are precharged before each sample.
        TAMPPUDIS: u1,
        padding: u24 = 0,
    }),
    /// TAMP active tamper control register 1.
    /// offset: 0x10
    ATCR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[0]": u1,
        /// (2/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[1]": u1,
        /// (3/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[2]": u1,
        /// (4/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[3]": u1,
        /// (5/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[4]": u1,
        /// (6/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[5]": u1,
        /// (7/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[6]": u1,
        /// (8/8 of TAMPAM) Tamper x active mode. (x=1-8)
        @"TAMPAM[7]": u1,
        /// (1/4 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. (x=1-4)
        @"ATOSEL[0]": u2,
        /// (2/4 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. (x=1-4)
        @"ATOSEL[1]": u2,
        /// (3/4 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. (x=1-4)
        @"ATOSEL[2]": u2,
        /// (4/4 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. (x=1-4)
        @"ATOSEL[3]": u2,
        /// Active tamper RTC asynchronous prescaler clock selection These bits selects the RTC asynchronous prescaler stage output.The selected clock is CK_ATPRE. fCK_ATPRE = fRTCCLK / 2ATCKSEL when (PREDIV_A+1) = 128. ... These bits can be written only when all active tampers are disabled. The write protection remains for up to 1.5 ck_atpre cycles after all the active tampers are disable.
        ATCKSEL: u3,
        reserved24: u5 = 0,
        /// Active tamper output change period The tamper output is changed every CK_ATPER = (2ATPER x CK_ATPRE) cycles. Refer to.
        ATPER: u3,
        reserved30: u3 = 0,
        /// Active tamper output sharing TAMP_IN1 is compared with TAMPOUTSEL1 TAMP_IN2 is compared with TAMPOUTSEL2 TAMP_IN3 is compared with TAMPOUTSEL3 TAMP_IN4 is compared with TAMPOUTSEL4 TAMP_IN5 is compared with TAMPOUTSEL5 TAMP_IN6 is compared with TAMPOUTSEL6 TAMP_IN7 is compared with TAMPOUTSEL7 TAMP_IN8 is compared with TAMPOUTSEL8.
        ATOSHARE: u1,
        /// Active tamper filter enable.
        FLTEN: u1,
    }),
    /// TAMP active tamper seed register.
    /// offset: 0x14
    ATSEEDR: u32,
    /// TAMP active tamper output register.
    /// offset: 0x18
    ATOR: mmio.Mmio(packed struct(u32) {
        /// Pseudo-random generator value This field provides the values of the PRNG output. Because of potential inconsistencies due to synchronization delays, PRNG must be read at least twice. The read value is correct if it is equal to previous read value. This field can only be read when the APB is in secure mode.
        PRNG: u8,
        reserved14: u6 = 0,
        /// Seed running flag This flag is set by hardware when a new seed is written in the TAMP_ATSEEDR. It is cleared by hardware when the PRNG has absorbed this new seed, and by system reset. The TAMP APB cock must not be switched off as long as SEEDF is set.
        SEEDF: u1,
        /// Active tamper initialization status This flag is set by hardware when the PRNG has absorbed the first 128-bit seed, meaning that the enabled active tampers are functional. This flag is cleared when the active tampers are disabled.
        INITS: u1,
        padding: u16 = 0,
    }),
    /// TAMP active tamper control register 2.
    /// offset: 0x1c
    ATCR2: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// (1/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[0]": u3,
        /// (2/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[1]": u3,
        /// (3/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[2]": u3,
        /// (4/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[3]": u3,
        /// (5/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[4]": u3,
        /// (6/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[5]": u3,
        /// (7/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[6]": u3,
        /// (8/8 of ATOSEL) Active tamper shared output x selection The selected output must be available in the package pinout. Bits 9:8 are the mirror of ATOSELx[1:0] in the TAMP_ATCR1, and so can also be read or written through TAMP_ATCR1. (x=1-8)
        @"ATOSEL[7]": u3,
    }),
    /// TAMP secure mode register.
    /// offset: 0x20
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// Backup registers read/write protection offset Protection zone 1 is defined for backup registers from TAMP_BKP0R to TAMP_BKPxR (x = BKPRWSEC-1, from 0 to 128). if TZEN=1, these backup registers can be read and written only with secure access. If TZEN=0: the protection zone 1 can be read and written with non-secure access. If BKPRWSEC = 0: there is no protection zone 1. If BKPRWPRIV is set, BKPRWSEC[7:0] can be written only in privileged mode.
        BKPRWSEC: u8,
        reserved15: u7 = 0,
        /// Monotonic counter 1 secure protection.
        CNT1SEC: u1,
        /// Backup registers write protection offset Protection zone 2 is defined for backup registers from TAMP_BKPyR (y = BKPRWSEC, from 0 to 128) to TAMP_BKPzR (z = BKPWSEC-1, from 0 to 128, BKPWSEC ≥ BKPRWSEC): if TZEN=1, these backup registers can be written only with secure access. They can be read with secure or non-secure access. Protection zone 3 defined for backup registers from TAMP_BKPtR (t = BKPWSEC, from 0 to 127). They can be read or written with secure or non-secure access. If TZEN=0: the protection zone 2 can be read and written with non-secure access. If BKPWSEC = 0 or if BKPWSEC ≤ BKPRWSEC: there is no protection zone 2. If BKPWPRIV is set, BKPRWSEC[7:0] can be written only in privileged mode.
        BKPWSEC: u8,
        reserved30: u6 = 0,
        /// Boot hardware key lock This bit can be read and can only be written to 1 by software. It is cleared by hardware together with the backup registers following a tamper detection event or when the readout protection (RDP) is disabled.
        BHKLOCK: u1,
        /// Tamper protection (excluding monotonic counters and backup registers) Note: Refer to for details on the read protection.
        TAMPSEC: u1,
    }),
    /// TAMP privilege mode control register.
    /// offset: 0x24
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        reserved15: u15 = 0,
        /// Monotonic counter 1 privilege protection.
        CNT1PRIV: u1,
        reserved29: u13 = 0,
        /// Backup registers zone 1 privilege protection.
        BKPRWPRIV: u1,
        /// Backup registers zone 2 privilege protection.
        BKPWPRIV: u1,
        /// Tamper privilege protection (excluding backup registers) Note: Refer to for details on the read protection.
        TAMPPRIV: u1,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// TAMP interrupt enable register.
    /// offset: 0x2c
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[0]": u1,
        /// (2/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[1]": u1,
        /// (3/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[2]": u1,
        /// (4/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[3]": u1,
        /// (5/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[4]": u1,
        /// (6/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[5]": u1,
        /// (7/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[6]": u1,
        /// (8/8 of TAMPIE) Tamper x interrupt enable. (x=1-8)
        @"TAMPIE[7]": u1,
        reserved16: u8 = 0,
        /// Internal tamper 1 interrupt enable.
        ITAMP1IE: u1,
        /// Internal tamper 2 interrupt enable.
        ITAMP2IE: u1,
        /// Internal tamper 3 interrupt enable.
        ITAMP3IE: u1,
        /// Internal tamper 4 interrupt enable.
        ITAMP4IE: u1,
        /// Internal tamper 5 interrupt enable.
        ITAMP5IE: u1,
        /// Internal tamper 6 interrupt enable.
        ITAMP6IE: u1,
        /// Internal tamper 7 interrupt enable.
        ITAMP7IE: u1,
        /// Internal tamper 8 interrupt enable.
        ITAMP8IE: u1,
        /// Internal tamper 9 interrupt enable.
        ITAMP9IE: u1,
        reserved26: u1 = 0,
        /// Internal tamper 11 interrupt enable.
        ITAMP11IE: u1,
        /// Internal tamper 12 interrupt enable.
        ITAMP12IE: u1,
        /// Internal tamper 13 interrupt enable.
        ITAMP13IE: u1,
        reserved30: u1 = 0,
        /// Internal tamper 15 interrupt enable.
        ITAMP15IE: u1,
        padding: u1 = 0,
    }),
    /// TAMP status register.
    /// offset: 0x30
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[0]": u1,
        /// (2/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[1]": u1,
        /// (3/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[2]": u1,
        /// (4/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[3]": u1,
        /// (5/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[4]": u1,
        /// (6/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[5]": u1,
        /// (7/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[6]": u1,
        /// (8/8 of TAMPF) TAMPx detection flag. This flag is set by hardware when a tamper detection event is detected on the TAMPx input. (x=1-8)
        @"TAMPF[7]": u1,
        reserved16: u8 = 0,
        /// Internal tamper 1 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 1.
        ITAMP1F: u1,
        /// Internal tamper 2 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 2.
        ITAMP2F: u1,
        /// Internal tamper 3 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 3.
        ITAMP3F: u1,
        /// Internal tamper 4 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 4.
        ITAMP4F: u1,
        /// Internal tamper 5 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 5.
        ITAMP5F: u1,
        /// Internal tamper 6 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 6.
        ITAMP6F: u1,
        /// Internal tamper 7 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 7.
        ITAMP7F: u1,
        /// Internal tamper 8 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 8.
        ITAMP8F: u1,
        /// Internal tamper 9 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 9.
        ITAMP9F: u1,
        reserved26: u1 = 0,
        /// Internal tamper 11 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 11.
        ITAMP11F: u1,
        /// Internal tamper 12 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 12.
        ITAMP12F: u1,
        /// Internal tamper 13 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 13.
        ITAMP13F: u1,
        reserved30: u1 = 0,
        /// Internal tamper 15 flag This flag is set by hardware when a tamper detection event is detected on the internal tamper 15.
        ITAMP15F: u1,
        padding: u1 = 0,
    }),
    /// TAMP non-secure masked interrupt status register.
    /// offset: 0x34
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) TAMP1 non-secure interrupt masked flag This flag is set by hardware when the tamper 1 non-secure interrupt is raised.
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// Internal tamper 1 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 1 non-secure interrupt is raised.
        ITAMP1MF: u1,
        /// Internal tamper 2 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 2 non-secure interrupt is raised.
        ITAMP2MF: u1,
        /// Internal tamper 3 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 3 non-secure interrupt is raised.
        ITAMP3MF: u1,
        /// Internal tamper 4 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 4 non-secure interrupt is raised.
        ITAMP4MF: u1,
        /// Internal tamper 5 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 5 non-secure interrupt is raised.
        ITAMP5MF: u1,
        /// Internal tamper 6 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 6 non-secure interrupt is raised.
        ITAMP6MF: u1,
        /// Internal tamper 7 tamper non-secure interrupt masked flag This flag is set by hardware when the internal tamper 7 non-secure interrupt is raised.
        ITAMP7MF: u1,
        /// Internal tamper 8 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 8 non-secure interrupt is raised.
        ITAMP8MF: u1,
        /// internal tamper 9 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 9 non-secure interrupt is raised.
        ITAMP9MF: u1,
        reserved26: u1 = 0,
        /// internal tamper 11 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 11 non-secure interrupt is raised.
        ITAMP11MF: u1,
        /// internal tamper 12 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 12 non-secure interrupt is raised.
        ITAMP12MF: u1,
        /// internal tamper 13 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 13 non-secure interrupt is raised.
        ITAMP13MF: u1,
        reserved30: u1 = 0,
        /// internal tamper 15 non-secure interrupt masked flag This flag is set by hardware when the internal tamper 15 non-secure interrupt is raised.
        ITAMP15MF: u1,
        padding: u1 = 0,
    }),
    /// TAMP secure masked interrupt status register.
    /// offset: 0x38
    SMISR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[0]": u1,
        /// (2/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[1]": u1,
        /// (3/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[2]": u1,
        /// (4/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[3]": u1,
        /// (5/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[4]": u1,
        /// (6/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[5]": u1,
        /// (7/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[6]": u1,
        /// (8/8 of TAMPMF) TAMPx secure interrupt masked flag. This flag is set by hardware when the tamper x secure interrupt is raised. (x=1-8)
        @"TAMPMF[7]": u1,
        reserved16: u8 = 0,
        /// Internal tamper 1 secure interrupt masked flag This flag is set by hardware when the internal tamper 1 secure interrupt is raised.
        ITAMP1MF: u1,
        /// Internal tamper 2 secure interrupt masked flag This flag is set by hardware when the internal tamper 2 secure interrupt is raised.
        ITAMP2MF: u1,
        /// Internal tamper 3 secure interrupt masked flag This flag is set by hardware when the internal tamper 3 secure interrupt is raised.
        ITAMP3MF: u1,
        /// Internal tamper 4 secure interrupt masked flag This flag is set by hardware when the internal tamper 4 secure interrupt is raised.
        ITAMP4MF: u1,
        /// Internal tamper 5 secure interrupt masked flag This flag is set by hardware when the internal tamper 5 secure interrupt is raised.
        ITAMP5MF: u1,
        /// Internal tamper 6 secure interrupt masked flag This flag is set by hardware when the internal tamper 6 secure interrupt is raised.
        ITAMP6MF: u1,
        /// Internal tamper 7 secure interrupt masked flag This flag is set by hardware when the internal tamper 7 secure interrupt is raised.
        ITAMP7MF: u1,
        /// Internal tamper 8 secure interrupt masked flag This flag is set by hardware when the internal tamper 8 secure interrupt is raised.
        ITAMP8MF: u1,
        /// internal tamper 9 secure interrupt masked flag This flag is set by hardware when the internal tamper 9 secure interrupt is raised.
        ITAMP9MF: u1,
        reserved26: u1 = 0,
        /// internal tamper 11 secure interrupt masked flag This flag is set by hardware when the internal tamper 11 secure interrupt is raised.
        ITAMP11MF: u1,
        /// internal tamper 12 secure interrupt masked flag This flag is set by hardware when the internal tamper 12 secure interrupt is raised.
        ITAMP12MF: u1,
        /// internal tamper 13 secure interrupt masked flag This flag is set by hardware when the internal tamper 13 secure interrupt is raised.
        ITAMP13MF: u1,
        reserved30: u1 = 0,
        /// internal tamper 15 secure interrupt masked flag This flag is set by hardware when the internal tamper 15 secure interrupt is raised.
        ITAMP15MF: u1,
        padding: u1 = 0,
    }),
    /// TAMP status clear register.
    /// offset: 0x3c
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[0]": u1,
        /// (2/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[1]": u1,
        /// (3/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[2]": u1,
        /// (4/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[3]": u1,
        /// (5/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[4]": u1,
        /// (6/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[5]": u1,
        /// (7/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[6]": u1,
        /// (8/8 of CTAMPF) Clear TAMPx detection flag. Writing 1 in this bit clears the TAMPxF bit in the TAMP_SR register. (x=1-8)
        @"CTAMPF[7]": u1,
        reserved16: u8 = 0,
        /// Clear ITAMP1 detection flag Writing 1 in this bit clears the ITAMP1F bit in the TAMP_SR register.
        CITAMP1F: u1,
        /// Clear ITAMP2 detection flag Writing 1 in this bit clears the ITAMP2F bit in the TAMP_SR register.
        CITAMP2F: u1,
        /// Clear ITAMP3 detection flag Writing 1 in this bit clears the ITAMP3F bit in the TAMP_SR register.
        CITAMP3F: u1,
        /// Clear ITAMP4 detection flag Writing 1 in this bit clears the ITAMP4F bit in the TAMP_SR register.
        CITAMP4F: u1,
        /// Clear ITAMP5 detection flag Writing 1 in this bit clears the ITAMP5F bit in the TAMP_SR register.
        CITAMP5F: u1,
        /// Clear ITAMP6 detection flag Writing 1 in this bit clears the ITAMP6F bit in the TAMP_SR register.
        CITAMP6F: u1,
        /// Clear ITAMP7 detection flag Writing 1 in this bit clears the ITAMP7F bit in the TAMP_SR register.
        CITAMP7F: u1,
        /// Clear ITAMP8 detection flag Writing 1 in this bit clears the ITAMP8F bit in the TAMP_SR register.
        CITAMP8F: u1,
        /// Clear ITAMP9 detection flag Writing 1 in this bit clears the ITAMP9F bit in the TAMP_SR register.
        CITAMP9F: u1,
        reserved26: u1 = 0,
        /// Clear ITAMP11 detection flag Writing 1 in this bit clears the ITAMP11F bit in the TAMP_SR register.
        CITAMP11F: u1,
        /// Clear ITAMP12 detection flag Writing 1 in this bit clears the ITAMP12F bit in the TAMP_SR register.
        CITAMP12F: u1,
        /// Clear ITAMP13 detection flag Writing 1 in this bit clears the ITAMP13F bit in the TAMP_SR register.
        CITAMP13F: u1,
        reserved30: u1 = 0,
        /// Clear ITAMP15 detection flag Writing 1 in this bit clears the ITAMP15F bit in the TAMP_SR register.
        CITAMP15F: u1,
        padding: u1 = 0,
    }),
    /// TAMP monotonic counter 1 register.
    /// offset: 0x40
    COUNT1R: u32,
    /// offset: 0x44
    reserved68: [12]u8,
    /// TAMP option register.
    /// offset: 0x50
    OR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TAMP_OUT3 mapping.
        OUT3_RMP: u2,
        /// TAMP_OUT5 mapping.
        OUT5_RMP: u1,
        reserved8: u4 = 0,
        /// TAMP_IN2 mapping.
        IN2_RMP: u1,
        /// TAMP_IN3 mapping.
        IN3_RMP: u1,
        /// TAMP_IN4 mapping.
        IN4_RMP: u1,
        padding: u21 = 0,
    }),
    /// TAMP resources protection configuration register.
    /// offset: 0x54
    RPCFGR: mmio.Mmio(packed struct(u32) {
        /// Configurable resource 0 protection.
        RPCFG0: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x58
    reserved88: [168]u8,
    /// TAMP backup x register. (x=0-31)
    /// offset: 0x100
    BKPR: [32]u32,
};
