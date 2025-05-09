const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Hardware semaphore.
pub const HSEM = extern struct {
    /// HSEM register HSEM_R%s HSEM_R31.
    /// offset: 0x00
    R: [16]mmio.Mmio(packed struct(u32) {
        /// Semaphore ProcessID.
        PROCID: u8,
        /// COREID.
        COREID: u4,
        reserved31: u19 = 0,
        /// Lock indication.
        LOCK: u1,
    }),
    /// offset: 0x40
    reserved64: [64]u8,
    /// HSEM Read lock register.
    /// offset: 0x80
    RLR: [16]mmio.Mmio(packed struct(u32) {
        /// Semaphore ProcessID.
        PROCID: u8,
        /// COREID.
        COREID: u4,
        reserved31: u19 = 0,
        /// Lock indication.
        LOCK: u1,
    }),
    /// offset: 0xc0
    reserved192: [64]u8,
    /// HSEM Interrupt enable register.
    /// offset: 0x100
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[0]": u1,
        /// (2/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[1]": u1,
        /// (3/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[2]": u1,
        /// (4/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[3]": u1,
        /// (5/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[4]": u1,
        /// (6/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[5]": u1,
        /// (7/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[6]": u1,
        /// (8/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[7]": u1,
        /// (9/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[8]": u1,
        /// (10/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[9]": u1,
        /// (11/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[10]": u1,
        /// (12/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[11]": u1,
        /// (13/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[12]": u1,
        /// (14/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[13]": u1,
        /// (15/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[14]": u1,
        /// (16/16 of ISE) Interrupt semaphore x enable bit.
        @"ISE[15]": u1,
        padding: u16 = 0,
    }),
    /// HSEM Interrupt clear register.
    /// offset: 0x104
    ICR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[0]": u1,
        /// (2/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[1]": u1,
        /// (3/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[2]": u1,
        /// (4/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[3]": u1,
        /// (5/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[4]": u1,
        /// (6/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[5]": u1,
        /// (7/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[6]": u1,
        /// (8/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[7]": u1,
        /// (9/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[8]": u1,
        /// (10/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[9]": u1,
        /// (11/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[10]": u1,
        /// (12/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[11]": u1,
        /// (13/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[12]": u1,
        /// (14/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[13]": u1,
        /// (15/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[14]": u1,
        /// (16/16 of ISC) Interrupt semaphore x clear bit.
        @"ISC[15]": u1,
        padding: u16 = 0,
    }),
    /// HSEM Interrupt status register.
    /// offset: 0x108
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[0]": u1,
        /// (2/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[1]": u1,
        /// (3/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[2]": u1,
        /// (4/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[3]": u1,
        /// (5/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[4]": u1,
        /// (6/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[5]": u1,
        /// (7/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[6]": u1,
        /// (8/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[7]": u1,
        /// (9/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[8]": u1,
        /// (10/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[9]": u1,
        /// (11/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[10]": u1,
        /// (12/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[11]": u1,
        /// (13/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[12]": u1,
        /// (14/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[13]": u1,
        /// (15/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[14]": u1,
        /// (16/16 of ISF) Interrupt semaphore x status bit before enable (mask).
        @"ISF[15]": u1,
        padding: u16 = 0,
    }),
    /// HSEM Masked interrupt status register.
    /// offset: 0x10c
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[0]": u1,
        /// (2/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[1]": u1,
        /// (3/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[2]": u1,
        /// (4/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[3]": u1,
        /// (5/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[4]": u1,
        /// (6/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[5]": u1,
        /// (7/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[6]": u1,
        /// (8/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[7]": u1,
        /// (9/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[8]": u1,
        /// (10/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[9]": u1,
        /// (11/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[10]": u1,
        /// (12/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[11]": u1,
        /// (13/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[12]": u1,
        /// (14/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[13]": u1,
        /// (15/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[14]": u1,
        /// (16/16 of MISF) masked interrupt semaphore x status bit after enable (mask).
        @"MISF[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x110
    reserved272: [48]u8,
    /// HSEM Clear register.
    /// offset: 0x140
    CR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// COREID.
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
