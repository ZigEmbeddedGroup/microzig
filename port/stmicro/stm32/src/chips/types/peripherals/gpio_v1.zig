const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const CNF_IN = enum(u2) {
    /// Analog mode
    Analog = 0x0,
    /// Floating input (reset state)
    Floating = 0x1,
    /// Input with pull-up/pull-down
    Pull = 0x2,
    _,
};

pub const CNF_OUT = enum(u2) {
    /// Push-Pull mode
    PushPull = 0x0,
    /// Open Drain-Mode
    OpenDrain = 0x1,
    /// Alternate Function Push-Pull Mode
    AltPushPull = 0x2,
    /// Alternate Function Open-Drain Mode
    AltOpenDrain = 0x3,
};

pub const IDR = enum(u1) {
    /// Input is logic low
    Low = 0x0,
    /// Input is logic high
    High = 0x1,
};

pub const MODE = enum(u2) {
    /// Input mode (reset state)
    Input = 0x0,
    /// Output mode 10 MHz
    Output10Mhz = 0x1,
    /// Output mode 2 MHz
    Output2Mhz = 0x2,
    /// Output mode 50 MHz
    Output50Mhz = 0x3,
};

pub const ODR = enum(u1) {
    /// Set output to logic low
    Low = 0x0,
    /// Set output to logic high
    High = 0x1,
};

/// General purpose I/O
pub const GPIO = extern struct {
    /// Port configuration register low (GPIOn_CRL)
    /// offset: 0x00
    CR: [2]mmio.Mmio(packed struct(u32) {
        /// (1/8 of MODE) Port n mode bits
        @"MODE[0]": MODE,
        /// (1/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[0]": CNF_IN,
        /// (2/8 of MODE) Port n mode bits
        @"MODE[1]": MODE,
        /// (2/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[1]": CNF_IN,
        /// (3/8 of MODE) Port n mode bits
        @"MODE[2]": MODE,
        /// (3/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[2]": CNF_IN,
        /// (4/8 of MODE) Port n mode bits
        @"MODE[3]": MODE,
        /// (4/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[3]": CNF_IN,
        /// (5/8 of MODE) Port n mode bits
        @"MODE[4]": MODE,
        /// (5/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[4]": CNF_IN,
        /// (6/8 of MODE) Port n mode bits
        @"MODE[5]": MODE,
        /// (6/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[5]": CNF_IN,
        /// (7/8 of MODE) Port n mode bits
        @"MODE[6]": MODE,
        /// (7/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[6]": CNF_IN,
        /// (8/8 of MODE) Port n mode bits
        @"MODE[7]": MODE,
        /// (8/8 of CNF_IN) Port n configuration bits, for input mode
        @"CNF_IN[7]": CNF_IN,
    }),
    /// Port input data register (GPIOn_IDR)
    /// offset: 0x08
    IDR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of IDR) Port input data
        @"IDR[0]": IDR,
        /// (2/16 of IDR) Port input data
        @"IDR[1]": IDR,
        /// (3/16 of IDR) Port input data
        @"IDR[2]": IDR,
        /// (4/16 of IDR) Port input data
        @"IDR[3]": IDR,
        /// (5/16 of IDR) Port input data
        @"IDR[4]": IDR,
        /// (6/16 of IDR) Port input data
        @"IDR[5]": IDR,
        /// (7/16 of IDR) Port input data
        @"IDR[6]": IDR,
        /// (8/16 of IDR) Port input data
        @"IDR[7]": IDR,
        /// (9/16 of IDR) Port input data
        @"IDR[8]": IDR,
        /// (10/16 of IDR) Port input data
        @"IDR[9]": IDR,
        /// (11/16 of IDR) Port input data
        @"IDR[10]": IDR,
        /// (12/16 of IDR) Port input data
        @"IDR[11]": IDR,
        /// (13/16 of IDR) Port input data
        @"IDR[12]": IDR,
        /// (14/16 of IDR) Port input data
        @"IDR[13]": IDR,
        /// (15/16 of IDR) Port input data
        @"IDR[14]": IDR,
        /// (16/16 of IDR) Port input data
        @"IDR[15]": IDR,
        padding: u16 = 0,
    }),
    /// Port output data register (GPIOn_ODR)
    /// offset: 0x0c
    ODR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of ODR) Port output data
        @"ODR[0]": ODR,
        /// (2/16 of ODR) Port output data
        @"ODR[1]": ODR,
        /// (3/16 of ODR) Port output data
        @"ODR[2]": ODR,
        /// (4/16 of ODR) Port output data
        @"ODR[3]": ODR,
        /// (5/16 of ODR) Port output data
        @"ODR[4]": ODR,
        /// (6/16 of ODR) Port output data
        @"ODR[5]": ODR,
        /// (7/16 of ODR) Port output data
        @"ODR[6]": ODR,
        /// (8/16 of ODR) Port output data
        @"ODR[7]": ODR,
        /// (9/16 of ODR) Port output data
        @"ODR[8]": ODR,
        /// (10/16 of ODR) Port output data
        @"ODR[9]": ODR,
        /// (11/16 of ODR) Port output data
        @"ODR[10]": ODR,
        /// (12/16 of ODR) Port output data
        @"ODR[11]": ODR,
        /// (13/16 of ODR) Port output data
        @"ODR[12]": ODR,
        /// (14/16 of ODR) Port output data
        @"ODR[13]": ODR,
        /// (15/16 of ODR) Port output data
        @"ODR[14]": ODR,
        /// (16/16 of ODR) Port output data
        @"ODR[15]": ODR,
        padding: u16 = 0,
    }),
    /// Port bit set/reset register (GPIOn_BSRR)
    /// offset: 0x10
    BSRR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of BS) Set bit
        @"BS[0]": u1,
        /// (2/16 of BS) Set bit
        @"BS[1]": u1,
        /// (3/16 of BS) Set bit
        @"BS[2]": u1,
        /// (4/16 of BS) Set bit
        @"BS[3]": u1,
        /// (5/16 of BS) Set bit
        @"BS[4]": u1,
        /// (6/16 of BS) Set bit
        @"BS[5]": u1,
        /// (7/16 of BS) Set bit
        @"BS[6]": u1,
        /// (8/16 of BS) Set bit
        @"BS[7]": u1,
        /// (9/16 of BS) Set bit
        @"BS[8]": u1,
        /// (10/16 of BS) Set bit
        @"BS[9]": u1,
        /// (11/16 of BS) Set bit
        @"BS[10]": u1,
        /// (12/16 of BS) Set bit
        @"BS[11]": u1,
        /// (13/16 of BS) Set bit
        @"BS[12]": u1,
        /// (14/16 of BS) Set bit
        @"BS[13]": u1,
        /// (15/16 of BS) Set bit
        @"BS[14]": u1,
        /// (16/16 of BS) Set bit
        @"BS[15]": u1,
        /// (1/16 of BR) Reset bit
        @"BR[0]": u1,
        /// (2/16 of BR) Reset bit
        @"BR[1]": u1,
        /// (3/16 of BR) Reset bit
        @"BR[2]": u1,
        /// (4/16 of BR) Reset bit
        @"BR[3]": u1,
        /// (5/16 of BR) Reset bit
        @"BR[4]": u1,
        /// (6/16 of BR) Reset bit
        @"BR[5]": u1,
        /// (7/16 of BR) Reset bit
        @"BR[6]": u1,
        /// (8/16 of BR) Reset bit
        @"BR[7]": u1,
        /// (9/16 of BR) Reset bit
        @"BR[8]": u1,
        /// (10/16 of BR) Reset bit
        @"BR[9]": u1,
        /// (11/16 of BR) Reset bit
        @"BR[10]": u1,
        /// (12/16 of BR) Reset bit
        @"BR[11]": u1,
        /// (13/16 of BR) Reset bit
        @"BR[12]": u1,
        /// (14/16 of BR) Reset bit
        @"BR[13]": u1,
        /// (15/16 of BR) Reset bit
        @"BR[14]": u1,
        /// (16/16 of BR) Reset bit
        @"BR[15]": u1,
    }),
    /// Port bit reset register (GPIOn_BRR)
    /// offset: 0x14
    BRR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of BR) Reset bit
        @"BR[0]": u1,
        /// (2/16 of BR) Reset bit
        @"BR[1]": u1,
        /// (3/16 of BR) Reset bit
        @"BR[2]": u1,
        /// (4/16 of BR) Reset bit
        @"BR[3]": u1,
        /// (5/16 of BR) Reset bit
        @"BR[4]": u1,
        /// (6/16 of BR) Reset bit
        @"BR[5]": u1,
        /// (7/16 of BR) Reset bit
        @"BR[6]": u1,
        /// (8/16 of BR) Reset bit
        @"BR[7]": u1,
        /// (9/16 of BR) Reset bit
        @"BR[8]": u1,
        /// (10/16 of BR) Reset bit
        @"BR[9]": u1,
        /// (11/16 of BR) Reset bit
        @"BR[10]": u1,
        /// (12/16 of BR) Reset bit
        @"BR[11]": u1,
        /// (13/16 of BR) Reset bit
        @"BR[12]": u1,
        /// (14/16 of BR) Reset bit
        @"BR[13]": u1,
        /// (15/16 of BR) Reset bit
        @"BR[14]": u1,
        /// (16/16 of BR) Reset bit
        @"BR[15]": u1,
        padding: u16 = 0,
    }),
    /// Port configuration lock register
    /// offset: 0x18
    LCKR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of LCK) Port configuration locked
        @"LCK[0]": u1,
        /// (2/16 of LCK) Port configuration locked
        @"LCK[1]": u1,
        /// (3/16 of LCK) Port configuration locked
        @"LCK[2]": u1,
        /// (4/16 of LCK) Port configuration locked
        @"LCK[3]": u1,
        /// (5/16 of LCK) Port configuration locked
        @"LCK[4]": u1,
        /// (6/16 of LCK) Port configuration locked
        @"LCK[5]": u1,
        /// (7/16 of LCK) Port configuration locked
        @"LCK[6]": u1,
        /// (8/16 of LCK) Port configuration locked
        @"LCK[7]": u1,
        /// (9/16 of LCK) Port configuration locked
        @"LCK[8]": u1,
        /// (10/16 of LCK) Port configuration locked
        @"LCK[9]": u1,
        /// (11/16 of LCK) Port configuration locked
        @"LCK[10]": u1,
        /// (12/16 of LCK) Port configuration locked
        @"LCK[11]": u1,
        /// (13/16 of LCK) Port configuration locked
        @"LCK[12]": u1,
        /// (14/16 of LCK) Port configuration locked
        @"LCK[13]": u1,
        /// (15/16 of LCK) Port configuration locked
        @"LCK[14]": u1,
        /// (16/16 of LCK) Port configuration locked
        @"LCK[15]": u1,
        /// Port configuration lock key active
        LCKK: u1,
        padding: u15 = 0,
    }),
};
