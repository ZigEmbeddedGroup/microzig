const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const KEY = enum(u16) {
    /// Enable access to PR, RLR and WINR registers (0x5555)
    Enable = 0x5555,
    /// Reset the watchdog value (0xAAAA)
    Reset = 0xaaaa,
    /// Start the watchdog (0xCCCC)
    Start = 0xcccc,
    _,
};

pub const PR = enum(u4) {
    /// Divider /4
    DivideBy4 = 0x0,
    /// Divider /8
    DivideBy8 = 0x1,
    /// Divider /16
    DivideBy16 = 0x2,
    /// Divider /32
    DivideBy32 = 0x3,
    /// Divider /64
    DivideBy64 = 0x4,
    /// Divider /128
    DivideBy128 = 0x5,
    /// Divider /256
    DivideBy256 = 0x6,
    /// Divider /512
    DivideBy512 = 0x7,
    /// Divider /1024
    DivideBy1024 = 0x8,
    _,
};

/// Independent watchdog
pub const IWDG = extern struct {
    /// Key register
    /// offset: 0x00
    KR: mmio.Mmio(packed struct(u32) {
        /// Key value (write only, read 0000h)
        KEY: KEY,
        padding: u16 = 0,
    }),
    /// Prescaler register
    /// offset: 0x04
    PR: mmio.Mmio(packed struct(u32) {
        /// Prescaler divider
        PR: PR,
        padding: u28 = 0,
    }),
    /// Reload register
    /// offset: 0x08
    RLR: mmio.Mmio(packed struct(u32) {
        /// Watchdog counter reload value
        RL: u12,
        padding: u20 = 0,
    }),
    /// Status register
    /// offset: 0x0c
    SR: mmio.Mmio(packed struct(u32) {
        /// Watchdog prescaler value update
        PVU: u1,
        /// Watchdog counter reload value update
        RVU: u1,
        /// Watchdog counter window value update
        WVU: u1,
        /// Watchdog interrupt comparator value update This bit is set by hardware to indicate that an update of the interrupt comparator value (EWIT[11:0]) or an update of the EWIE is ongoing. It is reset by hardware when the update operation is completed in the VDD voltage domain (takes up to three periods of the IWDG kernel clock iwdg_ker_ck). The EWIT[11:0] and EWIE fields can be updated only when EWU bit is reset.
        EWU: u1,
        reserved14: u10 = 0,
        /// Watchdog early interrupt flag This bit is set to ‘1’ by hardware in order to indicate that an early interrupt is pending. This bit must be cleared by the software by writing the bit EWIC of IWDG_EWCR register to ‘1’.
        EWIF: u1,
        padding: u17 = 0,
    }),
    /// Window register
    /// offset: 0x10
    WINR: mmio.Mmio(packed struct(u32) {
        /// Watchdog counter window value
        WIN: u12,
        padding: u20 = 0,
    }),
    /// IWDG early wakeup interrupt register.
    /// offset: 0x14
    EWCR: mmio.Mmio(packed struct(u32) {
        /// Watchdog counter window value These bits are write access protected (see ). They are written by software to define at which position of the IWDCNT down-counter the early wakeup interrupt must be generated. The early interrupt is generated when the IWDCNT is lower or equal to EWIT[11:0] - 1. EWIT[11:0] must be bigger than 1. An interrupt is generated only if EWIE = 1. The EWU bit in the must be reset to be able to change the reload value. Note: Reading this register returns the Early wakeup comparator value and the Interrupt enable bit from the VDD voltage domain. This value may not be up to date/valid if a write operation to this register is ongoing, hence the value read from this register is valid only when the EWU bit in the is reset.
        EWIT: u12,
        reserved14: u2 = 0,
        /// Watchdog early interrupt acknowledge The software must write a 1 into this bit in order to acknowledge the early wakeup interrupt and to clear the EWIF flag. Writing 0 has not effect, reading this flag returns a 0.
        EWIC: u1,
        /// Watchdog early interrupt enable Set and reset by software. The EWU bit in the must be reset to be able to change the value of this bit.
        EWIE: u1,
        padding: u16 = 0,
    }),
};
