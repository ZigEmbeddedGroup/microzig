const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const CLKDIV = enum(u4) {
    /// Internal RNG clock after divider is similar to incoming RNG clock
    NoDiv = 0x0,
    /// Divide RNG clock by 2^1
    Div_2_1 = 0x1,
    /// Divide RNG clock by 2^2
    Div_2_2 = 0x2,
    /// Divide RNG clock by 2^3
    Div_2_3 = 0x3,
    /// Divide RNG clock by 2^4
    Div_2_4 = 0x4,
    /// Divide RNG clock by 2^5
    Div_2_5 = 0x5,
    /// Divide RNG clock by 2^6
    Div_2_6 = 0x6,
    /// Divide RNG clock by 2^7
    Div_2_7 = 0x7,
    /// Divide RNG clock by 2^8
    Div_2_8 = 0x8,
    /// Divide RNG clock by 2^9
    Div_2_9 = 0x9,
    /// Divide RNG clock by 2^10
    Div_2_10 = 0xa,
    /// Divide RNG clock by 2^11
    Div_2_11 = 0xb,
    /// Divide RNG clock by 2^12
    Div_2_12 = 0xc,
    /// Divide RNG clock by 2^13
    Div_2_13 = 0xd,
    /// Divide RNG clock by 2^14
    Div_2_14 = 0xe,
    /// Divide RNG clock by 2^15
    Div_2_15 = 0xf,
};

pub const HTCFG = enum(u32) {
    /// Recommended value for RNG certification (0x0000_AA74)
    Recommended = 0xaa74,
    /// Magic number to be written before any write (0x1759_0ABC)
    Magic = 0x17590abc,
    _,
};

pub const NISTC = enum(u1) {
    /// Hardware default values for NIST compliant RNG. In this configuration per 128-bit output two conditioning loops are performed and 256 bits of noise source are used
    Default = 0x0,
    /// Custom values for NIST compliant RNG
    Custom = 0x1,
};

pub const RNG_CONFIG1 = enum(u6) {
    /// Recommended value for config A (NIST certifiable)
    ConfigA = 0xf,
    /// Recommended value for config B (not NIST certifiable)
    ConfigB = 0x18,
    _,
};

pub const RNG_CONFIG2 = enum(u3) {
    /// Recommended value for config A and B
    ConfigA_B = 0x0,
    _,
};

pub const RNG_CONFIG3 = enum(u4) {
    /// Recommended value for config B (not NIST certifiable)
    ConfigB = 0x0,
    /// Recommended value for config A (NIST certifiable)
    ConfigA = 0xd,
    _,
};

/// Random number generator
pub const RNG = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Random number generator enable
        RNGEN: u1,
        /// Interrupt enable
        IE: u1,
        reserved5: u1 = 0,
        /// Clock error detection
        CED: u1,
        reserved7: u1 = 0,
        /// Auto reset disable
        ARDIS: u1,
        /// RNG configuration 3
        RNG_CONFIG3: RNG_CONFIG3,
        /// Non NIST compliant
        NISTC: NISTC,
        /// RNG configuration 2
        RNG_CONFIG2: RNG_CONFIG2,
        /// Clock divider factor
        CLKDIV: CLKDIV,
        /// RNG configuration 1
        RNG_CONFIG1: RNG_CONFIG1,
        reserved30: u4 = 0,
        /// Conditioning soft reset
        CONDRST: u1,
        /// Config Lock
        CONFIGLOCK: u1,
    }),
    /// status register
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// Data ready
        DRDY: u1,
        /// Clock error current status
        CECS: u1,
        /// Seed error current status
        SECS: u1,
        reserved5: u2 = 0,
        /// Clock error interrupt status
        CEIS: u1,
        /// Seed error interrupt status
        SEIS: u1,
        padding: u25 = 0,
    }),
    /// data register
    /// offset: 0x08
    DR: u32,
    /// offset: 0x0c
    reserved12: [4]u8,
    /// health test control register
    /// offset: 0x10
    HTCR: mmio.Mmio(packed struct(u32) {
        /// Health test configuration
        HTCFG: HTCFG,
    }),
};
