const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const RTOFF = enum(u1) {
    /// Last write operation on RTC registers is still ongoing
    Ongoing = 0x0,
    /// Last write operation on RTC registers terminated
    Terminated = 0x1,
};

/// Real-time clock
pub const RTC = extern struct {
    /// Control Register High
    /// offset: 0x00
    CRH: mmio.Mmio(packed struct(u32) {
        /// Second interrupt enable
        SECIE: u1,
        /// Alarm interrupt enable
        ALRIE: u1,
        /// Overflow interrupt enable
        OWIE: u1,
        padding: u29 = 0,
    }),
    /// Control Register Low
    /// offset: 0x04
    CRL: mmio.Mmio(packed struct(u32) {
        /// Second flag
        SECF: u1,
        /// Alarm flag
        ALRF: u1,
        /// Overflow flag
        OWF: u1,
        /// Registers synchronized flag
        RSF: u1,
        /// Enter configuration mode
        CNF: u1,
        /// RTC operation OFF
        RTOFF: RTOFF,
        padding: u26 = 0,
    }),
    /// Prescaler Load Register High
    /// offset: 0x08
    PRLH: mmio.Mmio(packed struct(u32) {
        /// Prescaler load register high
        PRLH: u4,
        padding: u28 = 0,
    }),
    /// Prescaler Load Register Low
    /// offset: 0x0c
    PRLL: mmio.Mmio(packed struct(u32) {
        /// Prescaler divider register low
        PRLL: u16,
        padding: u16 = 0,
    }),
    /// Prescaler Divider Register High
    /// offset: 0x10
    DIVH: mmio.Mmio(packed struct(u32) {
        /// Prescaler divider register high
        DIVH: u4,
        padding: u28 = 0,
    }),
    /// Prescaler Divider Register Low
    /// offset: 0x14
    DIVL: mmio.Mmio(packed struct(u32) {
        /// Prescaler divider register low
        DIVL: u16,
        padding: u16 = 0,
    }),
    /// Counter Register High
    /// offset: 0x18
    CNTH: mmio.Mmio(packed struct(u32) {
        /// Counter register high
        CNTH: u16,
        padding: u16 = 0,
    }),
    /// Counter Register Low
    /// offset: 0x1c
    CNTL: mmio.Mmio(packed struct(u32) {
        /// Counter register low
        CNTL: u16,
        padding: u16 = 0,
    }),
    /// Alarm Register High
    /// offset: 0x20
    ALRH: mmio.Mmio(packed struct(u32) {
        /// Alarm register high
        ALRH: u16,
        padding: u16 = 0,
    }),
    /// Alarm Register Low
    /// offset: 0x24
    ALRL: mmio.Mmio(packed struct(u32) {
        /// Alarm register low
        ALRL: u16,
        padding: u16 = 0,
    }),
};
