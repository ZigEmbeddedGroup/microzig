const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const IDR = enum(u1) {
    /// Input is logic low
    Low = 0x0,
    /// Input is logic high
    High = 0x1,
};

pub const MODER = enum(u2) {
    /// Input mode (reset state)
    Input = 0x0,
    /// General purpose output mode
    Output = 0x1,
    /// Alternate function mode
    Alternate = 0x2,
    /// Analog mode
    Analog = 0x3,
};

pub const ODR = enum(u1) {
    /// Set output to logic low
    Low = 0x0,
    /// Set output to logic high
    High = 0x1,
};

pub const OSPEEDR = enum(u2) {
    /// Low speed
    LowSpeed = 0x0,
    /// Medium speed
    MediumSpeed = 0x1,
    /// High speed
    HighSpeed = 0x2,
    /// Very high speed
    VeryHighSpeed = 0x3,
};

pub const OT = enum(u1) {
    /// Output push-pull (reset state)
    PushPull = 0x0,
    /// Output open-drain
    OpenDrain = 0x1,
};

pub const PUPDR = enum(u2) {
    /// No pull-up, pull-down
    Floating = 0x0,
    /// Pull-up
    PullUp = 0x1,
    /// Pull-down
    PullDown = 0x2,
    _,
};

/// General-purpose I/Os
pub const GPIO = extern struct {
    /// GPIO port mode register
    /// offset: 0x00
    MODER: mmio.Mmio(packed struct(u32) {
        /// (1/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[0]": MODER,
        /// (2/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[1]": MODER,
        /// (3/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[2]": MODER,
        /// (4/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[3]": MODER,
        /// (5/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[4]": MODER,
        /// (6/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[5]": MODER,
        /// (7/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[6]": MODER,
        /// (8/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[7]": MODER,
        /// (9/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[8]": MODER,
        /// (10/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[9]": MODER,
        /// (11/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[10]": MODER,
        /// (12/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[11]": MODER,
        /// (13/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[12]": MODER,
        /// (14/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[13]": MODER,
        /// (15/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[14]": MODER,
        /// (16/16 of MODER) Port x configuration bits (y = 0..15)
        @"MODER[15]": MODER,
    }),
    /// GPIO port output type register
    /// offset: 0x04
    OTYPER: mmio.Mmio(packed struct(u32) {
        /// (1/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[0]": OT,
        /// (2/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[1]": OT,
        /// (3/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[2]": OT,
        /// (4/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[3]": OT,
        /// (5/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[4]": OT,
        /// (6/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[5]": OT,
        /// (7/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[6]": OT,
        /// (8/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[7]": OT,
        /// (9/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[8]": OT,
        /// (10/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[9]": OT,
        /// (11/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[10]": OT,
        /// (12/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[11]": OT,
        /// (13/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[12]": OT,
        /// (14/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[13]": OT,
        /// (15/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[14]": OT,
        /// (16/16 of OT) Port x configuration bits (y = 0..15)
        @"OT[15]": OT,
        padding: u16 = 0,
    }),
    /// GPIO port output speed register
    /// offset: 0x08
    OSPEEDR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[0]": OSPEEDR,
        /// (2/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[1]": OSPEEDR,
        /// (3/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[2]": OSPEEDR,
        /// (4/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[3]": OSPEEDR,
        /// (5/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[4]": OSPEEDR,
        /// (6/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[5]": OSPEEDR,
        /// (7/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[6]": OSPEEDR,
        /// (8/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[7]": OSPEEDR,
        /// (9/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[8]": OSPEEDR,
        /// (10/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[9]": OSPEEDR,
        /// (11/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[10]": OSPEEDR,
        /// (12/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[11]": OSPEEDR,
        /// (13/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[12]": OSPEEDR,
        /// (14/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[13]": OSPEEDR,
        /// (15/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[14]": OSPEEDR,
        /// (16/16 of OSPEEDR) Port x configuration bits (y = 0..15)
        @"OSPEEDR[15]": OSPEEDR,
    }),
    /// GPIO port pull-up/pull-down register
    /// offset: 0x0c
    PUPDR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[0]": PUPDR,
        /// (2/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[1]": PUPDR,
        /// (3/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[2]": PUPDR,
        /// (4/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[3]": PUPDR,
        /// (5/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[4]": PUPDR,
        /// (6/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[5]": PUPDR,
        /// (7/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[6]": PUPDR,
        /// (8/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[7]": PUPDR,
        /// (9/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[8]": PUPDR,
        /// (10/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[9]": PUPDR,
        /// (11/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[10]": PUPDR,
        /// (12/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[11]": PUPDR,
        /// (13/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[12]": PUPDR,
        /// (14/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[13]": PUPDR,
        /// (15/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[14]": PUPDR,
        /// (16/16 of PUPDR) Port x configuration bits (y = 0..15)
        @"PUPDR[15]": PUPDR,
    }),
    /// GPIO port input data register
    /// offset: 0x10
    IDR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of IDR) Port input data (y = 0..15)
        @"IDR[0]": IDR,
        /// (2/16 of IDR) Port input data (y = 0..15)
        @"IDR[1]": IDR,
        /// (3/16 of IDR) Port input data (y = 0..15)
        @"IDR[2]": IDR,
        /// (4/16 of IDR) Port input data (y = 0..15)
        @"IDR[3]": IDR,
        /// (5/16 of IDR) Port input data (y = 0..15)
        @"IDR[4]": IDR,
        /// (6/16 of IDR) Port input data (y = 0..15)
        @"IDR[5]": IDR,
        /// (7/16 of IDR) Port input data (y = 0..15)
        @"IDR[6]": IDR,
        /// (8/16 of IDR) Port input data (y = 0..15)
        @"IDR[7]": IDR,
        /// (9/16 of IDR) Port input data (y = 0..15)
        @"IDR[8]": IDR,
        /// (10/16 of IDR) Port input data (y = 0..15)
        @"IDR[9]": IDR,
        /// (11/16 of IDR) Port input data (y = 0..15)
        @"IDR[10]": IDR,
        /// (12/16 of IDR) Port input data (y = 0..15)
        @"IDR[11]": IDR,
        /// (13/16 of IDR) Port input data (y = 0..15)
        @"IDR[12]": IDR,
        /// (14/16 of IDR) Port input data (y = 0..15)
        @"IDR[13]": IDR,
        /// (15/16 of IDR) Port input data (y = 0..15)
        @"IDR[14]": IDR,
        /// (16/16 of IDR) Port input data (y = 0..15)
        @"IDR[15]": IDR,
        padding: u16 = 0,
    }),
    /// GPIO port output data register
    /// offset: 0x14
    ODR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of ODR) Port output data (y = 0..15)
        @"ODR[0]": ODR,
        /// (2/16 of ODR) Port output data (y = 0..15)
        @"ODR[1]": ODR,
        /// (3/16 of ODR) Port output data (y = 0..15)
        @"ODR[2]": ODR,
        /// (4/16 of ODR) Port output data (y = 0..15)
        @"ODR[3]": ODR,
        /// (5/16 of ODR) Port output data (y = 0..15)
        @"ODR[4]": ODR,
        /// (6/16 of ODR) Port output data (y = 0..15)
        @"ODR[5]": ODR,
        /// (7/16 of ODR) Port output data (y = 0..15)
        @"ODR[6]": ODR,
        /// (8/16 of ODR) Port output data (y = 0..15)
        @"ODR[7]": ODR,
        /// (9/16 of ODR) Port output data (y = 0..15)
        @"ODR[8]": ODR,
        /// (10/16 of ODR) Port output data (y = 0..15)
        @"ODR[9]": ODR,
        /// (11/16 of ODR) Port output data (y = 0..15)
        @"ODR[10]": ODR,
        /// (12/16 of ODR) Port output data (y = 0..15)
        @"ODR[11]": ODR,
        /// (13/16 of ODR) Port output data (y = 0..15)
        @"ODR[12]": ODR,
        /// (14/16 of ODR) Port output data (y = 0..15)
        @"ODR[13]": ODR,
        /// (15/16 of ODR) Port output data (y = 0..15)
        @"ODR[14]": ODR,
        /// (16/16 of ODR) Port output data (y = 0..15)
        @"ODR[15]": ODR,
        padding: u16 = 0,
    }),
    /// GPIO port bit set/reset register
    /// offset: 0x18
    BSRR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of BS) Port x set bit y (y= 0..15)
        @"BS[0]": u1,
        /// (2/16 of BS) Port x set bit y (y= 0..15)
        @"BS[1]": u1,
        /// (3/16 of BS) Port x set bit y (y= 0..15)
        @"BS[2]": u1,
        /// (4/16 of BS) Port x set bit y (y= 0..15)
        @"BS[3]": u1,
        /// (5/16 of BS) Port x set bit y (y= 0..15)
        @"BS[4]": u1,
        /// (6/16 of BS) Port x set bit y (y= 0..15)
        @"BS[5]": u1,
        /// (7/16 of BS) Port x set bit y (y= 0..15)
        @"BS[6]": u1,
        /// (8/16 of BS) Port x set bit y (y= 0..15)
        @"BS[7]": u1,
        /// (9/16 of BS) Port x set bit y (y= 0..15)
        @"BS[8]": u1,
        /// (10/16 of BS) Port x set bit y (y= 0..15)
        @"BS[9]": u1,
        /// (11/16 of BS) Port x set bit y (y= 0..15)
        @"BS[10]": u1,
        /// (12/16 of BS) Port x set bit y (y= 0..15)
        @"BS[11]": u1,
        /// (13/16 of BS) Port x set bit y (y= 0..15)
        @"BS[12]": u1,
        /// (14/16 of BS) Port x set bit y (y= 0..15)
        @"BS[13]": u1,
        /// (15/16 of BS) Port x set bit y (y= 0..15)
        @"BS[14]": u1,
        /// (16/16 of BS) Port x set bit y (y= 0..15)
        @"BS[15]": u1,
        /// (1/16 of BR) Port x set bit y (y= 0..15)
        @"BR[0]": u1,
        /// (2/16 of BR) Port x set bit y (y= 0..15)
        @"BR[1]": u1,
        /// (3/16 of BR) Port x set bit y (y= 0..15)
        @"BR[2]": u1,
        /// (4/16 of BR) Port x set bit y (y= 0..15)
        @"BR[3]": u1,
        /// (5/16 of BR) Port x set bit y (y= 0..15)
        @"BR[4]": u1,
        /// (6/16 of BR) Port x set bit y (y= 0..15)
        @"BR[5]": u1,
        /// (7/16 of BR) Port x set bit y (y= 0..15)
        @"BR[6]": u1,
        /// (8/16 of BR) Port x set bit y (y= 0..15)
        @"BR[7]": u1,
        /// (9/16 of BR) Port x set bit y (y= 0..15)
        @"BR[8]": u1,
        /// (10/16 of BR) Port x set bit y (y= 0..15)
        @"BR[9]": u1,
        /// (11/16 of BR) Port x set bit y (y= 0..15)
        @"BR[10]": u1,
        /// (12/16 of BR) Port x set bit y (y= 0..15)
        @"BR[11]": u1,
        /// (13/16 of BR) Port x set bit y (y= 0..15)
        @"BR[12]": u1,
        /// (14/16 of BR) Port x set bit y (y= 0..15)
        @"BR[13]": u1,
        /// (15/16 of BR) Port x set bit y (y= 0..15)
        @"BR[14]": u1,
        /// (16/16 of BR) Port x set bit y (y= 0..15)
        @"BR[15]": u1,
    }),
    /// GPIO port configuration lock register
    /// offset: 0x1c
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
    /// GPIO alternate function registers. The register described in the datasheet as AFRL is index 0 in this array, and AFRH is index 1. Note that when operating on AFRH, you need to subtract 8 from any operations on the field array it contains -- the alternate function for pin 9 is at index 1, for instance.
    /// offset: 0x20
    AFR: [2]mmio.Mmio(packed struct(u32) {
        /// (1/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[0]": u4,
        /// (2/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[1]": u4,
        /// (3/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[2]": u4,
        /// (4/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[3]": u4,
        /// (5/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[4]": u4,
        /// (6/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[5]": u4,
        /// (7/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[6]": u4,
        /// (8/8 of AFR) Alternate function selection for one of the pins controlled by this register (0-7).
        @"AFR[7]": u4,
    }),
};
