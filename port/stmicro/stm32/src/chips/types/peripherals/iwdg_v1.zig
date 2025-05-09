const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const KEY = enum(u16) {
    /// Enable access to PR, RLR and WINR registers (0x5555)
    Enable = 0x5555,
    /// Reset the watchdog value (0xAAAA)
    Reset = 0xaaaa,
    /// Start the watchdog (0xCCCC)
    Start = 0xcccc,
    _,
};

pub const PR = enum(u3) {
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
    /// Divider /256
    DivideBy256bis = 0x7,
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
        padding: u29 = 0,
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
        padding: u30 = 0,
    }),
};
