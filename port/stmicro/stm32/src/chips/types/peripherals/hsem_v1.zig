const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Hardware semaphore (HSEM).
pub const HSEM = extern struct {
    /// HSEM register HSEM_R%s HSEM_R31.
    /// offset: 0x00
    R: [32]mmio.Mmio(packed struct(u32) {
        /// Semaphore ProcessID.
        PROCID: u8,
        /// Semaphore COREID.
        COREID: u4,
        reserved31: u19 = 0,
        /// Lock indication.
        LOCK: u1,
    }),
    /// HSEM Read lock register.
    /// offset: 0x80
    RLR: [32]mmio.Mmio(packed struct(u32) {
        /// Semaphore ProcessID.
        PROCID: u8,
        /// Semaphore COREID.
        COREID: u4,
        reserved31: u19 = 0,
        /// Lock indication.
        LOCK: u1,
    }),
    /// HSEM Interrupt enable register.
    /// offset: 0x100
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[0]": u1,
        /// (2/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[1]": u1,
        /// (3/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[2]": u1,
        /// (4/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[3]": u1,
        /// (5/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[4]": u1,
        /// (6/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[5]": u1,
        /// (7/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[6]": u1,
        /// (8/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[7]": u1,
        /// (9/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[8]": u1,
        /// (10/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[9]": u1,
        /// (11/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[10]": u1,
        /// (12/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[11]": u1,
        /// (13/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[12]": u1,
        /// (14/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[13]": u1,
        /// (15/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[14]": u1,
        /// (16/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[15]": u1,
        /// (17/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[16]": u1,
        /// (18/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[17]": u1,
        /// (19/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[18]": u1,
        /// (20/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[19]": u1,
        /// (21/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[20]": u1,
        /// (22/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[21]": u1,
        /// (23/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[22]": u1,
        /// (24/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[23]": u1,
        /// (25/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[24]": u1,
        /// (26/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[25]": u1,
        /// (27/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[26]": u1,
        /// (28/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[27]": u1,
        /// (29/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[28]": u1,
        /// (30/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[29]": u1,
        /// (31/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[30]": u1,
        /// (32/32 of ISE) Interrupt semaphore x enable bit.
        @"ISE[31]": u1,
    }),
    /// HSEM Interrupt clear register.
    /// offset: 0x104
    ICR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[0]": u1,
        /// (2/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[1]": u1,
        /// (3/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[2]": u1,
        /// (4/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[3]": u1,
        /// (5/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[4]": u1,
        /// (6/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[5]": u1,
        /// (7/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[6]": u1,
        /// (8/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[7]": u1,
        /// (9/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[8]": u1,
        /// (10/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[9]": u1,
        /// (11/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[10]": u1,
        /// (12/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[11]": u1,
        /// (13/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[12]": u1,
        /// (14/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[13]": u1,
        /// (15/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[14]": u1,
        /// (16/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[15]": u1,
        /// (17/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[16]": u1,
        /// (18/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[17]": u1,
        /// (19/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[18]": u1,
        /// (20/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[19]": u1,
        /// (21/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[20]": u1,
        /// (22/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[21]": u1,
        /// (23/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[22]": u1,
        /// (24/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[23]": u1,
        /// (25/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[24]": u1,
        /// (26/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[25]": u1,
        /// (27/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[26]": u1,
        /// (28/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[27]": u1,
        /// (29/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[28]": u1,
        /// (30/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[29]": u1,
        /// (31/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[30]": u1,
        /// (32/32 of ISC) Interrupt semaphore x clear bit.
        @"ISC[31]": u1,
    }),
    /// HSEM Interrupt status register.
    /// offset: 0x108
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[0]": u1,
        /// (2/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[1]": u1,
        /// (3/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[2]": u1,
        /// (4/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[3]": u1,
        /// (5/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[4]": u1,
        /// (6/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[5]": u1,
        /// (7/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[6]": u1,
        /// (8/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[7]": u1,
        /// (9/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[8]": u1,
        /// (10/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[9]": u1,
        /// (11/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[10]": u1,
        /// (12/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[11]": u1,
        /// (13/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[12]": u1,
        /// (14/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[13]": u1,
        /// (15/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[14]": u1,
        /// (16/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[15]": u1,
        /// (17/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[16]": u1,
        /// (18/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[17]": u1,
        /// (19/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[18]": u1,
        /// (20/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[19]": u1,
        /// (21/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[20]": u1,
        /// (22/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[21]": u1,
        /// (23/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[22]": u1,
        /// (24/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[23]": u1,
        /// (25/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[24]": u1,
        /// (26/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[25]": u1,
        /// (27/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[26]": u1,
        /// (28/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[27]": u1,
        /// (29/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[28]": u1,
        /// (30/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[29]": u1,
        /// (31/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[30]": u1,
        /// (32/32 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[31]": u1,
    }),
    /// HSEM Masked interrupt status register.
    /// offset: 0x10c
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[0]": u1,
        /// (2/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[1]": u1,
        /// (3/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[2]": u1,
        /// (4/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[3]": u1,
        /// (5/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[4]": u1,
        /// (6/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[5]": u1,
        /// (7/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[6]": u1,
        /// (8/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[7]": u1,
        /// (9/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[8]": u1,
        /// (10/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[9]": u1,
        /// (11/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[10]": u1,
        /// (12/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[11]": u1,
        /// (13/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[12]": u1,
        /// (14/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[13]": u1,
        /// (15/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[14]": u1,
        /// (16/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[15]": u1,
        /// (17/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[16]": u1,
        /// (18/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[17]": u1,
        /// (19/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[18]": u1,
        /// (20/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[19]": u1,
        /// (21/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[20]": u1,
        /// (22/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[21]": u1,
        /// (23/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[22]": u1,
        /// (24/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[23]": u1,
        /// (25/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[24]": u1,
        /// (26/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[25]": u1,
        /// (27/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[26]": u1,
        /// (28/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[27]": u1,
        /// (29/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[28]": u1,
        /// (30/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[29]": u1,
        /// (31/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[30]": u1,
        /// (32/32 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[31]": u1,
    }),
    /// offset: 0x110
    reserved272: [48]u8,
    /// HSEM Clear register.
    /// offset: 0x140
    CR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// COREID of semaphores to be cleared.
        COREID: u4,
        reserved16: u4 = 0,
        /// Semaphore clear Key.
        KEY: u16,
    }),
    /// HSEM Interrupt clear register.
    /// offset: 0x144
    KEYR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Semaphore Clear Key.
        KEY: u16,
    }),
};
