// generated using svd2zig.py
// DO NOT EDIT
// based on STM32F303 version 1.4
const microzig_mmio = @import("microzig-mmio");
const mmio = microzig_mmio.mmio;
const MMIO = microzig_mmio.MMIO;
const Name = "STM32F303";

/// General-purpose I/Os
pub const GPIOA = extern struct {
    pub const Address: u32 = 0x48000000;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OT0: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT1: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT2: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT3: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT4: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT5: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT6: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT7: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT8: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT9: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT10: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT11: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT12: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT13: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT14: u1 = 0,
        /// Port x configuration bits (y = 0..15)
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOB = extern struct {
    pub const Address: u32 = 0x48000400;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOC = extern struct {
    pub const Address: u32 = 0x48000800;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOD = extern struct {
    pub const Address: u32 = 0x48000c00;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOE = extern struct {
    pub const Address: u32 = 0x48001000;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOF = extern struct {
    pub const Address: u32 = 0x48001400;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOG = extern struct {
    pub const Address: u32 = 0x48001800;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose I/Os
pub const GPIOH = extern struct {
    pub const Address: u32 = 0x48001c00;

    /// GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        MODER0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        MODER15: u2 = 0,
    });

    /// GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        /// Port x configuration bit 0
        OT0: u1 = 0,
        /// Port x configuration bit 1
        OT1: u1 = 0,
        /// Port x configuration bit 2
        OT2: u1 = 0,
        /// Port x configuration bit 3
        OT3: u1 = 0,
        /// Port x configuration bit 4
        OT4: u1 = 0,
        /// Port x configuration bit 5
        OT5: u1 = 0,
        /// Port x configuration bit 6
        OT6: u1 = 0,
        /// Port x configuration bit 7
        OT7: u1 = 0,
        /// Port x configuration bit 8
        OT8: u1 = 0,
        /// Port x configuration bit 9
        OT9: u1 = 0,
        /// Port x configuration bit 10
        OT10: u1 = 0,
        /// Port x configuration bit 11
        OT11: u1 = 0,
        /// Port x configuration bit 12
        OT12: u1 = 0,
        /// Port x configuration bit 13
        OT13: u1 = 0,
        /// Port x configuration bit 14
        OT14: u1 = 0,
        /// Port x configuration bit 15
        OT15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        OSPEEDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        OSPEEDR15: u2 = 0,
    });

    /// GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port x configuration bits (y = 0..15)
        PUPDR0: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR1: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR2: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR3: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR4: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR5: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR6: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR7: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR8: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR9: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR10: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR11: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR12: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR13: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR14: u2 = 0,
        /// Port x configuration bits (y = 0..15)
        PUPDR15: u2 = 0,
    });

    /// GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        /// Port input data (y = 0..15)
        IDR0: u1 = 0,
        /// Port input data (y = 0..15)
        IDR1: u1 = 0,
        /// Port input data (y = 0..15)
        IDR2: u1 = 0,
        /// Port input data (y = 0..15)
        IDR3: u1 = 0,
        /// Port input data (y = 0..15)
        IDR4: u1 = 0,
        /// Port input data (y = 0..15)
        IDR5: u1 = 0,
        /// Port input data (y = 0..15)
        IDR6: u1 = 0,
        /// Port input data (y = 0..15)
        IDR7: u1 = 0,
        /// Port input data (y = 0..15)
        IDR8: u1 = 0,
        /// Port input data (y = 0..15)
        IDR9: u1 = 0,
        /// Port input data (y = 0..15)
        IDR10: u1 = 0,
        /// Port input data (y = 0..15)
        IDR11: u1 = 0,
        /// Port input data (y = 0..15)
        IDR12: u1 = 0,
        /// Port input data (y = 0..15)
        IDR13: u1 = 0,
        /// Port input data (y = 0..15)
        IDR14: u1 = 0,
        /// Port input data (y = 0..15)
        IDR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        /// Port output data (y = 0..15)
        ODR0: u1 = 0,
        /// Port output data (y = 0..15)
        ODR1: u1 = 0,
        /// Port output data (y = 0..15)
        ODR2: u1 = 0,
        /// Port output data (y = 0..15)
        ODR3: u1 = 0,
        /// Port output data (y = 0..15)
        ODR4: u1 = 0,
        /// Port output data (y = 0..15)
        ODR5: u1 = 0,
        /// Port output data (y = 0..15)
        ODR6: u1 = 0,
        /// Port output data (y = 0..15)
        ODR7: u1 = 0,
        /// Port output data (y = 0..15)
        ODR8: u1 = 0,
        /// Port output data (y = 0..15)
        ODR9: u1 = 0,
        /// Port output data (y = 0..15)
        ODR10: u1 = 0,
        /// Port output data (y = 0..15)
        ODR11: u1 = 0,
        /// Port output data (y = 0..15)
        ODR12: u1 = 0,
        /// Port output data (y = 0..15)
        ODR13: u1 = 0,
        /// Port output data (y = 0..15)
        ODR14: u1 = 0,
        /// Port output data (y = 0..15)
        ODR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// Port x set bit y (y= 0..15)
        BR0: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    });

    /// GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// Lok Key
        LCKK: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL0: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4 = 0,
        /// Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4 = 0,
    });

    /// GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH8: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4 = 0,
        /// Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4 = 0,
    });

    /// Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        /// Port x Reset bit y
        BR0: u1 = 0,
        /// Port x Reset bit y
        BR1: u1 = 0,
        /// Port x Reset bit y
        BR2: u1 = 0,
        /// Port x Reset bit y
        BR3: u1 = 0,
        /// Port x Reset bit y
        BR4: u1 = 0,
        /// Port x Reset bit y
        BR5: u1 = 0,
        /// Port x Reset bit y
        BR6: u1 = 0,
        /// Port x Reset bit y
        BR7: u1 = 0,
        /// Port x Reset bit y
        BR8: u1 = 0,
        /// Port x Reset bit y
        BR9: u1 = 0,
        /// Port x Reset bit y
        BR10: u1 = 0,
        /// Port x Reset bit y
        BR11: u1 = 0,
        /// Port x Reset bit y
        BR12: u1 = 0,
        /// Port x Reset bit y
        BR13: u1 = 0,
        /// Port x Reset bit y
        BR14: u1 = 0,
        /// Port x Reset bit y
        BR15: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Touch sensing controller
pub const TSC = extern struct {
    pub const Address: u32 = 0x40024000;

    /// control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// Touch sensing controller enable
        TSCE: u1 = 0,
        /// Start a new acquisition
        START: u1 = 0,
        /// Acquisition mode
        AM: u1 = 0,
        /// Synchronization pin polarity
        SYNCPOL: u1 = 0,
        /// I/O Default mode
        IODEF: u1 = 0,
        /// Max count value
        MCV: u3 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// pulse generator prescaler
        PGPSC: u3 = 0,
        /// Spread spectrum prescaler
        SSPSC: u1 = 0,
        /// Spread spectrum enable
        SSE: u1 = 0,
        /// Spread spectrum deviation
        SSD: u7 = 0,
        /// Charge transfer pulse low
        CTPL: u4 = 0,
        /// Charge transfer pulse high
        CTPH: u4 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        /// End of acquisition interrupt enable
        EOAIE: u1 = 0,
        /// Max count error interrupt enable
        MCEIE: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt clear register
    pub const ICR = mmio(Address + 0x00000008, 32, packed struct {
        /// End of acquisition interrupt clear
        EOAIC: u1 = 0,
        /// Max count error interrupt clear
        MCEIC: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt status register
    pub const ISR = mmio(Address + 0x0000000c, 32, packed struct {
        /// End of acquisition flag
        EOAF: u1 = 0,
        /// Max count error flag
        MCEF: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O hysteresis control register
    pub const IOHCR = mmio(Address + 0x00000010, 32, packed struct {
        /// G1_IO1 Schmitt trigger hysteresis mode
        G1_IO1: u1 = 0,
        /// G1_IO2 Schmitt trigger hysteresis mode
        G1_IO2: u1 = 0,
        /// G1_IO3 Schmitt trigger hysteresis mode
        G1_IO3: u1 = 0,
        /// G1_IO4 Schmitt trigger hysteresis mode
        G1_IO4: u1 = 0,
        /// G2_IO1 Schmitt trigger hysteresis mode
        G2_IO1: u1 = 0,
        /// G2_IO2 Schmitt trigger hysteresis mode
        G2_IO2: u1 = 0,
        /// G2_IO3 Schmitt trigger hysteresis mode
        G2_IO3: u1 = 0,
        /// G2_IO4 Schmitt trigger hysteresis mode
        G2_IO4: u1 = 0,
        /// G3_IO1 Schmitt trigger hysteresis mode
        G3_IO1: u1 = 0,
        /// G3_IO2 Schmitt trigger hysteresis mode
        G3_IO2: u1 = 0,
        /// G3_IO3 Schmitt trigger hysteresis mode
        G3_IO3: u1 = 0,
        /// G3_IO4 Schmitt trigger hysteresis mode
        G3_IO4: u1 = 0,
        /// G4_IO1 Schmitt trigger hysteresis mode
        G4_IO1: u1 = 0,
        /// G4_IO2 Schmitt trigger hysteresis mode
        G4_IO2: u1 = 0,
        /// G4_IO3 Schmitt trigger hysteresis mode
        G4_IO3: u1 = 0,
        /// G4_IO4 Schmitt trigger hysteresis mode
        G4_IO4: u1 = 0,
        /// G5_IO1 Schmitt trigger hysteresis mode
        G5_IO1: u1 = 0,
        /// G5_IO2 Schmitt trigger hysteresis mode
        G5_IO2: u1 = 0,
        /// G5_IO3 Schmitt trigger hysteresis mode
        G5_IO3: u1 = 0,
        /// G5_IO4 Schmitt trigger hysteresis mode
        G5_IO4: u1 = 0,
        /// G6_IO1 Schmitt trigger hysteresis mode
        G6_IO1: u1 = 0,
        /// G6_IO2 Schmitt trigger hysteresis mode
        G6_IO2: u1 = 0,
        /// G6_IO3 Schmitt trigger hysteresis mode
        G6_IO3: u1 = 0,
        /// G6_IO4 Schmitt trigger hysteresis mode
        G6_IO4: u1 = 0,
        /// G7_IO1 Schmitt trigger hysteresis mode
        G7_IO1: u1 = 0,
        /// G7_IO2 Schmitt trigger hysteresis mode
        G7_IO2: u1 = 0,
        /// G7_IO3 Schmitt trigger hysteresis mode
        G7_IO3: u1 = 0,
        /// G7_IO4 Schmitt trigger hysteresis mode
        G7_IO4: u1 = 0,
        /// G8_IO1 Schmitt trigger hysteresis mode
        G8_IO1: u1 = 0,
        /// G8_IO2 Schmitt trigger hysteresis mode
        G8_IO2: u1 = 0,
        /// G8_IO3 Schmitt trigger hysteresis mode
        G8_IO3: u1 = 0,
        /// G8_IO4 Schmitt trigger hysteresis mode
        G8_IO4: u1 = 0,
    });

    /// I/O analog switch control register
    pub const IOASCR = mmio(Address + 0x00000018, 32, packed struct {
        /// G1_IO1 analog switch enable
        G1_IO1: u1 = 0,
        /// G1_IO2 analog switch enable
        G1_IO2: u1 = 0,
        /// G1_IO3 analog switch enable
        G1_IO3: u1 = 0,
        /// G1_IO4 analog switch enable
        G1_IO4: u1 = 0,
        /// G2_IO1 analog switch enable
        G2_IO1: u1 = 0,
        /// G2_IO2 analog switch enable
        G2_IO2: u1 = 0,
        /// G2_IO3 analog switch enable
        G2_IO3: u1 = 0,
        /// G2_IO4 analog switch enable
        G2_IO4: u1 = 0,
        /// G3_IO1 analog switch enable
        G3_IO1: u1 = 0,
        /// G3_IO2 analog switch enable
        G3_IO2: u1 = 0,
        /// G3_IO3 analog switch enable
        G3_IO3: u1 = 0,
        /// G3_IO4 analog switch enable
        G3_IO4: u1 = 0,
        /// G4_IO1 analog switch enable
        G4_IO1: u1 = 0,
        /// G4_IO2 analog switch enable
        G4_IO2: u1 = 0,
        /// G4_IO3 analog switch enable
        G4_IO3: u1 = 0,
        /// G4_IO4 analog switch enable
        G4_IO4: u1 = 0,
        /// G5_IO1 analog switch enable
        G5_IO1: u1 = 0,
        /// G5_IO2 analog switch enable
        G5_IO2: u1 = 0,
        /// G5_IO3 analog switch enable
        G5_IO3: u1 = 0,
        /// G5_IO4 analog switch enable
        G5_IO4: u1 = 0,
        /// G6_IO1 analog switch enable
        G6_IO1: u1 = 0,
        /// G6_IO2 analog switch enable
        G6_IO2: u1 = 0,
        /// G6_IO3 analog switch enable
        G6_IO3: u1 = 0,
        /// G6_IO4 analog switch enable
        G6_IO4: u1 = 0,
        /// G7_IO1 analog switch enable
        G7_IO1: u1 = 0,
        /// G7_IO2 analog switch enable
        G7_IO2: u1 = 0,
        /// G7_IO3 analog switch enable
        G7_IO3: u1 = 0,
        /// G7_IO4 analog switch enable
        G7_IO4: u1 = 0,
        /// G8_IO1 analog switch enable
        G8_IO1: u1 = 0,
        /// G8_IO2 analog switch enable
        G8_IO2: u1 = 0,
        /// G8_IO3 analog switch enable
        G8_IO3: u1 = 0,
        /// G8_IO4 analog switch enable
        G8_IO4: u1 = 0,
    });

    /// I/O sampling control register
    pub const IOSCR = mmio(Address + 0x00000020, 32, packed struct {
        /// G1_IO1 sampling mode
        G1_IO1: u1 = 0,
        /// G1_IO2 sampling mode
        G1_IO2: u1 = 0,
        /// G1_IO3 sampling mode
        G1_IO3: u1 = 0,
        /// G1_IO4 sampling mode
        G1_IO4: u1 = 0,
        /// G2_IO1 sampling mode
        G2_IO1: u1 = 0,
        /// G2_IO2 sampling mode
        G2_IO2: u1 = 0,
        /// G2_IO3 sampling mode
        G2_IO3: u1 = 0,
        /// G2_IO4 sampling mode
        G2_IO4: u1 = 0,
        /// G3_IO1 sampling mode
        G3_IO1: u1 = 0,
        /// G3_IO2 sampling mode
        G3_IO2: u1 = 0,
        /// G3_IO3 sampling mode
        G3_IO3: u1 = 0,
        /// G3_IO4 sampling mode
        G3_IO4: u1 = 0,
        /// G4_IO1 sampling mode
        G4_IO1: u1 = 0,
        /// G4_IO2 sampling mode
        G4_IO2: u1 = 0,
        /// G4_IO3 sampling mode
        G4_IO3: u1 = 0,
        /// G4_IO4 sampling mode
        G4_IO4: u1 = 0,
        /// G5_IO1 sampling mode
        G5_IO1: u1 = 0,
        /// G5_IO2 sampling mode
        G5_IO2: u1 = 0,
        /// G5_IO3 sampling mode
        G5_IO3: u1 = 0,
        /// G5_IO4 sampling mode
        G5_IO4: u1 = 0,
        /// G6_IO1 sampling mode
        G6_IO1: u1 = 0,
        /// G6_IO2 sampling mode
        G6_IO2: u1 = 0,
        /// G6_IO3 sampling mode
        G6_IO3: u1 = 0,
        /// G6_IO4 sampling mode
        G6_IO4: u1 = 0,
        /// G7_IO1 sampling mode
        G7_IO1: u1 = 0,
        /// G7_IO2 sampling mode
        G7_IO2: u1 = 0,
        /// G7_IO3 sampling mode
        G7_IO3: u1 = 0,
        /// G7_IO4 sampling mode
        G7_IO4: u1 = 0,
        /// G8_IO1 sampling mode
        G8_IO1: u1 = 0,
        /// G8_IO2 sampling mode
        G8_IO2: u1 = 0,
        /// G8_IO3 sampling mode
        G8_IO3: u1 = 0,
        /// G8_IO4 sampling mode
        G8_IO4: u1 = 0,
    });

    /// I/O channel control register
    pub const IOCCR = mmio(Address + 0x00000028, 32, packed struct {
        /// G1_IO1 channel mode
        G1_IO1: u1 = 0,
        /// G1_IO2 channel mode
        G1_IO2: u1 = 0,
        /// G1_IO3 channel mode
        G1_IO3: u1 = 0,
        /// G1_IO4 channel mode
        G1_IO4: u1 = 0,
        /// G2_IO1 channel mode
        G2_IO1: u1 = 0,
        /// G2_IO2 channel mode
        G2_IO2: u1 = 0,
        /// G2_IO3 channel mode
        G2_IO3: u1 = 0,
        /// G2_IO4 channel mode
        G2_IO4: u1 = 0,
        /// G3_IO1 channel mode
        G3_IO1: u1 = 0,
        /// G3_IO2 channel mode
        G3_IO2: u1 = 0,
        /// G3_IO3 channel mode
        G3_IO3: u1 = 0,
        /// G3_IO4 channel mode
        G3_IO4: u1 = 0,
        /// G4_IO1 channel mode
        G4_IO1: u1 = 0,
        /// G4_IO2 channel mode
        G4_IO2: u1 = 0,
        /// G4_IO3 channel mode
        G4_IO3: u1 = 0,
        /// G4_IO4 channel mode
        G4_IO4: u1 = 0,
        /// G5_IO1 channel mode
        G5_IO1: u1 = 0,
        /// G5_IO2 channel mode
        G5_IO2: u1 = 0,
        /// G5_IO3 channel mode
        G5_IO3: u1 = 0,
        /// G5_IO4 channel mode
        G5_IO4: u1 = 0,
        /// G6_IO1 channel mode
        G6_IO1: u1 = 0,
        /// G6_IO2 channel mode
        G6_IO2: u1 = 0,
        /// G6_IO3 channel mode
        G6_IO3: u1 = 0,
        /// G6_IO4 channel mode
        G6_IO4: u1 = 0,
        /// G7_IO1 channel mode
        G7_IO1: u1 = 0,
        /// G7_IO2 channel mode
        G7_IO2: u1 = 0,
        /// G7_IO3 channel mode
        G7_IO3: u1 = 0,
        /// G7_IO4 channel mode
        G7_IO4: u1 = 0,
        /// G8_IO1 channel mode
        G8_IO1: u1 = 0,
        /// G8_IO2 channel mode
        G8_IO2: u1 = 0,
        /// G8_IO3 channel mode
        G8_IO3: u1 = 0,
        /// G8_IO4 channel mode
        G8_IO4: u1 = 0,
    });

    /// I/O group control status register
    pub const IOGCSR = mmio(Address + 0x00000030, 32, packed struct {
        /// Analog I/O group x enable
        G1E: u1 = 0,
        /// Analog I/O group x enable
        G2E: u1 = 0,
        /// Analog I/O group x enable
        G3E: u1 = 0,
        /// Analog I/O group x enable
        G4E: u1 = 0,
        /// Analog I/O group x enable
        G5E: u1 = 0,
        /// Analog I/O group x enable
        G6E: u1 = 0,
        /// Analog I/O group x enable
        G7E: u1 = 0,
        /// Analog I/O group x enable
        G8E: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Analog I/O group x status
        G1S: u1 = 0,
        /// Analog I/O group x status
        G2S: u1 = 0,
        /// Analog I/O group x status
        G3S: u1 = 0,
        /// Analog I/O group x status
        G4S: u1 = 0,
        /// Analog I/O group x status
        G5S: u1 = 0,
        /// Analog I/O group x status
        G6S: u1 = 0,
        /// Analog I/O group x status
        G7S: u1 = 0,
        /// Analog I/O group x status
        G8S: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG1CR = mmio(Address + 0x00000034, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG2CR = mmio(Address + 0x00000038, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG3CR = mmio(Address + 0x0000003c, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG4CR = mmio(Address + 0x00000040, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG5CR = mmio(Address + 0x00000044, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG6CR = mmio(Address + 0x00000048, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG7CR = mmio(Address + 0x0000004c, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I/O group x counter register
    pub const IOG8CR = mmio(Address + 0x00000050, 32, packed struct {
        /// Counter value
        CNT: u14 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// cyclic redundancy check calculation unit
pub const CRC = extern struct {
    pub const Address: u32 = 0x40023000;

    /// Data register
    pub const DR = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Independent data register
    pub const IDR = mmio(Address + 0x00000004, 32, packed struct {
        /// General-purpose 8-bit data register bits
        IDR: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        /// reset bit
        RESET: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Polynomial size
        POLYSIZE: u2 = 0,
        /// Reverse input data
        REV_IN: u2 = 0,
        /// Reverse output data
        REV_OUT: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Initial CRC value
    pub const INIT = @intToPtr(*volatile u32, Address + 0x00000010);

    /// CRC polynomial
    pub const POL = @intToPtr(*volatile u32, Address + 0x00000014);
};

/// Flash
pub const Flash = extern struct {
    pub const Address: u32 = 0x40022000;

    /// Flash access control register
    pub const ACR = mmio(Address + 0x00000000, 32, packed struct {
        reserved1: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Flash key register
    pub const KEYR = mmio(Address + 0x00000004, 32, packed struct {
        /// Flash Key
        FKEYR: u32 = 0,
    });

    /// Flash option key register
    pub const OPTKEYR = @intToPtr(*volatile u32, Address + 0x00000008);

    /// Flash status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Busy
        BSY: u1 = 0,
        reserved1: u1 = 0,
        /// Programming error
        PGERR: u1 = 0,
        reserved2: u1 = 0,
        /// Write protection error
        WRPRT: u1 = 0,
        /// End of operation
        EOP: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Flash control register
    pub const CR = mmio(Address + 0x00000010, 32, packed struct {
        /// Programming
        PG: u1 = 0,
        /// Page erase
        PER: u1 = 0,
        /// Mass erase
        MER: u1 = 0,
        reserved1: u1 = 0,
        /// Option byte programming
        OPTPG: u1 = 0,
        /// Option byte erase
        OPTER: u1 = 0,
        /// Start
        STRT: u1 = 0,
        /// Lock
        LOCK: u1 = 0,
        reserved2: u1 = 0,
        /// Option bytes write enable
        OPTWRE: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        reserved3: u1 = 0,
        /// End of operation interrupt enable
        EOPIE: u1 = 0,
        /// Force option byte loading
        FORCE_OPTLOAD: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Flash address register
    pub const AR = mmio(Address + 0x00000014, 32, packed struct {
        /// Flash address
        FAR: u32 = 0,
    });

    /// Option byte register
    pub const OBR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Option byte error
        OPTERR: u1 = 0,
        /// Level 1 protection status
        LEVEL1_PROT: u1 = 0,
        /// Level 2 protection status
        LEVEL2_PROT: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved6: u1 = 0,
        reserved7: u1 = 0,
    });

    /// Write protection register
    pub const WRPR = mmio(Address + 0x00000020, 32, packed struct {
        /// Write protect
        WRP: u32 = 0,
    });
};

/// Reset and clock control
pub const RCC = extern struct {
    pub const Address: u32 = 0x40021000;

    /// Clock control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// Internal High Speed clock enable
        HSION: u1 = 0,
        /// Internal High Speed clock ready flag
        HSIRDY: u1 = 0,
        reserved1: u1 = 0,
        /// Internal High Speed clock trimming
        HSITRIM: u5 = 0,
        /// Internal High Speed clock Calibration
        HSICAL: u8 = 0,
        /// External High Speed clock enable
        HSEON: u1 = 0,
        /// External High Speed clock ready flag
        HSERDY: u1 = 0,
        /// External High Speed clock Bypass
        HSEBYP: u1 = 0,
        /// Clock Security System enable
        CSSON: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// PLL enable
        PLLON: u1 = 0,
        /// PLL clock ready flag
        PLLRDY: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock configuration register (RCC_CFGR)
    pub const CFGR = mmio(Address + 0x00000004, 32, packed struct {
        /// System clock Switch
        SW: u2 = 0,
        /// System Clock Switch Status
        SWS: u2 = 0,
        /// AHB prescaler
        HPRE: u4 = 0,
        /// APB Low speed prescaler (APB1)
        PPRE1: u3 = 0,
        /// APB high speed prescaler (APB2)
        PPRE2: u3 = 0,
        reserved1: u1 = 0,
        /// PLL entry clock source
        PLLSRC: u2 = 0,
        /// HSE divider for PLL entry
        PLLXTPRE: u1 = 0,
        /// PLL Multiplication Factor
        PLLMUL: u4 = 0,
        /// USB prescaler
        USBPRES: u1 = 0,
        /// I2S external clock source selection
        I2SSRC: u1 = 0,
        /// Microcontroller clock output
        MCO: u3 = 0,
        reserved2: u1 = 0,
        /// Microcontroller Clock Output Flag
        MCOF: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock interrupt register (RCC_CIR)
    pub const CIR = mmio(Address + 0x00000008, 32, packed struct {
        /// LSI Ready Interrupt flag
        LSIRDYF: u1 = 0,
        /// LSE Ready Interrupt flag
        LSERDYF: u1 = 0,
        /// HSI Ready Interrupt flag
        HSIRDYF: u1 = 0,
        /// HSE Ready Interrupt flag
        HSERDYF: u1 = 0,
        /// PLL Ready Interrupt flag
        PLLRDYF: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Clock Security System Interrupt flag
        CSSF: u1 = 0,
        /// LSI Ready Interrupt Enable
        LSIRDYIE: u1 = 0,
        /// LSE Ready Interrupt Enable
        LSERDYIE: u1 = 0,
        /// HSI Ready Interrupt Enable
        HSIRDYIE: u1 = 0,
        /// HSE Ready Interrupt Enable
        HSERDYIE: u1 = 0,
        /// PLL Ready Interrupt Enable
        PLLRDYIE: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// LSI Ready Interrupt Clear
        LSIRDYC: u1 = 0,
        /// LSE Ready Interrupt Clear
        LSERDYC: u1 = 0,
        /// HSI Ready Interrupt Clear
        HSIRDYC: u1 = 0,
        /// HSE Ready Interrupt Clear
        HSERDYC: u1 = 0,
        /// PLL Ready Interrupt Clear
        PLLRDYC: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// Clock security system interrupt clear
        CSSC: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB2 peripheral reset register (RCC_APB2RSTR)
    pub const APB2RSTR = mmio(Address + 0x0000000c, 32, packed struct {
        /// SYSCFG and COMP reset
        SYSCFGRST: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// TIM1 timer reset
        TIM1RST: u1 = 0,
        /// SPI 1 reset
        SPI1RST: u1 = 0,
        /// TIM8 timer reset
        TIM8RST: u1 = 0,
        /// USART1 reset
        USART1RST: u1 = 0,
        reserved11: u1 = 0,
        /// TIM15 timer reset
        TIM15RST: u1 = 0,
        /// TIM16 timer reset
        TIM16RST: u1 = 0,
        /// TIM17 timer reset
        TIM17RST: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB1 peripheral reset register (RCC_APB1RSTR)
    pub const APB1RSTR = mmio(Address + 0x00000010, 32, packed struct {
        /// Timer 2 reset
        TIM2RST: u1 = 0,
        /// Timer 3 reset
        TIM3RST: u1 = 0,
        /// Timer 14 reset
        TIM4RST: u1 = 0,
        reserved1: u1 = 0,
        /// Timer 6 reset
        TIM6RST: u1 = 0,
        /// Timer 7 reset
        TIM7RST: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Window watchdog reset
        WWDGRST: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// SPI2 reset
        SPI2RST: u1 = 0,
        /// SPI3 reset
        SPI3RST: u1 = 0,
        reserved9: u1 = 0,
        /// USART 2 reset
        USART2RST: u1 = 0,
        /// USART3 reset
        USART3RST: u1 = 0,
        /// UART 4 reset
        UART4RST: u1 = 0,
        /// UART 5 reset
        UART5RST: u1 = 0,
        /// I2C1 reset
        I2C1RST: u1 = 0,
        /// I2C2 reset
        I2C2RST: u1 = 0,
        /// USB reset
        USBRST: u1 = 0,
        reserved10: u1 = 0,
        /// CAN reset
        CANRST: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// Power interface reset
        PWRRST: u1 = 0,
        /// DAC interface reset
        DACRST: u1 = 0,
        /// I2C3 reset
        I2C3RST: u1 = 0,
        padding1: u1 = 0,
    });

    /// AHB Peripheral Clock enable register (RCC_AHBENR)
    pub const AHBENR = mmio(Address + 0x00000014, 32, packed struct {
        /// DMA1 clock enable
        DMAEN: u1 = 0,
        /// DMA2 clock enable
        DMA2EN: u1 = 0,
        /// SRAM interface clock enable
        SRAMEN: u1 = 0,
        reserved1: u1 = 0,
        /// FLITF clock enable
        FLITFEN: u1 = 0,
        /// FMC clock enable
        FMCEN: u1 = 0,
        /// CRC clock enable
        CRCEN: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// IO port H clock enable
        IOPHEN: u1 = 0,
        /// I/O port A clock enable
        IOPAEN: u1 = 0,
        /// I/O port B clock enable
        IOPBEN: u1 = 0,
        /// I/O port C clock enable
        IOPCEN: u1 = 0,
        /// I/O port D clock enable
        IOPDEN: u1 = 0,
        /// I/O port E clock enable
        IOPEEN: u1 = 0,
        /// I/O port F clock enable
        IOPFEN: u1 = 0,
        /// I/O port G clock enable
        IOPGEN: u1 = 0,
        /// Touch sensing controller clock enable
        TSCEN: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        /// ADC1 and ADC2 clock enable
        ADC12EN: u1 = 0,
        /// ADC3 and ADC4 clock enable
        ADC34EN: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB2 peripheral clock enable register (RCC_APB2ENR)
    pub const APB2ENR = mmio(Address + 0x00000018, 32, packed struct {
        /// SYSCFG clock enable
        SYSCFGEN: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// TIM1 Timer clock enable
        TIM1EN: u1 = 0,
        /// SPI 1 clock enable
        SPI1EN: u1 = 0,
        /// TIM8 Timer clock enable
        TIM8EN: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1 = 0,
        reserved11: u1 = 0,
        /// TIM15 timer clock enable
        TIM15EN: u1 = 0,
        /// TIM16 timer clock enable
        TIM16EN: u1 = 0,
        /// TIM17 timer clock enable
        TIM17EN: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB1 peripheral clock enable register (RCC_APB1ENR)
    pub const APB1ENR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Timer 2 clock enable
        TIM2EN: u1 = 0,
        /// Timer 3 clock enable
        TIM3EN: u1 = 0,
        /// Timer 4 clock enable
        TIM4EN: u1 = 0,
        reserved1: u1 = 0,
        /// Timer 6 clock enable
        TIM6EN: u1 = 0,
        /// Timer 7 clock enable
        TIM7EN: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Window watchdog clock enable
        WWDGEN: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// SPI 2 clock enable
        SPI2EN: u1 = 0,
        /// SPI 3 clock enable
        SPI3EN: u1 = 0,
        reserved9: u1 = 0,
        /// USART 2 clock enable
        USART2EN: u1 = 0,
        /// USART 3 clock enable
        USART3EN: u1 = 0,
        /// USART 4 clock enable
        USART4EN: u1 = 0,
        /// USART 5 clock enable
        USART5EN: u1 = 0,
        /// I2C 1 clock enable
        I2C1EN: u1 = 0,
        /// I2C 2 clock enable
        I2C2EN: u1 = 0,
        /// USB clock enable
        USBEN: u1 = 0,
        reserved10: u1 = 0,
        /// CAN clock enable
        CANEN: u1 = 0,
        /// DAC2 interface clock enable
        DAC2EN: u1 = 0,
        reserved11: u1 = 0,
        /// Power interface clock enable
        PWREN: u1 = 0,
        /// DAC interface clock enable
        DACEN: u1 = 0,
        /// I2C3 clock enable
        I2C3EN: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup domain control register (RCC_BDCR)
    pub const BDCR = mmio(Address + 0x00000020, 32, packed struct {
        /// External Low Speed oscillator enable
        LSEON: u1 = 0,
        /// External Low Speed oscillator ready
        LSERDY: u1 = 0,
        /// External Low Speed oscillator bypass
        LSEBYP: u1 = 0,
        /// LSE oscillator drive capability
        LSEDRV: u2 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// RTC clock source selection
        RTCSEL: u2 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// RTC clock enable
        RTCEN: u1 = 0,
        /// Backup domain software reset
        BDRST: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control/status register (RCC_CSR)
    pub const CSR = mmio(Address + 0x00000024, 32, packed struct {
        /// Internal low speed oscillator enable
        LSION: u1 = 0,
        /// Internal low speed oscillator ready
        LSIRDY: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Remove reset flag
        RMVF: u1 = 0,
        /// Option byte loader reset flag
        OBLRSTF: u1 = 0,
        /// PIN reset flag
        PINRSTF: u1 = 0,
        /// POR/PDR reset flag
        PORRSTF: u1 = 0,
        /// Software reset flag
        SFTRSTF: u1 = 0,
        /// Independent watchdog reset flag
        IWDGRSTF: u1 = 0,
        /// Window watchdog reset flag
        WWDGRSTF: u1 = 0,
        /// Low-power reset flag
        LPWRRSTF: u1 = 0,
    });

    /// AHB peripheral reset register
    pub const AHBRSTR = mmio(Address + 0x00000028, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// FMC reset
        FMCRST: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// I/O port H reset
        IOPHRST: u1 = 0,
        /// I/O port A reset
        IOPARST: u1 = 0,
        /// I/O port B reset
        IOPBRST: u1 = 0,
        /// I/O port C reset
        IOPCRST: u1 = 0,
        /// I/O port D reset
        IOPDRST: u1 = 0,
        /// I/O port E reset
        IOPERST: u1 = 0,
        /// I/O port F reset
        IOPFRST: u1 = 0,
        /// Touch sensing controller reset
        IOPGRST: u1 = 0,
        /// Touch sensing controller reset
        TSCRST: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        /// ADC1 and ADC2 reset
        ADC12RST: u1 = 0,
        /// ADC3 and ADC4 reset
        ADC34RST: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock configuration register 2
    pub const CFGR2 = mmio(Address + 0x0000002c, 32, packed struct {
        /// PREDIV division factor
        PREDIV: u4 = 0,
        /// ADC1 and ADC2 prescaler
        ADC12PRES: u5 = 0,
        /// ADC3 and ADC4 prescaler
        ADC34PRES: u5 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock configuration register 3
    pub const CFGR3 = mmio(Address + 0x00000030, 32, packed struct {
        /// USART1 clock source selection
        USART1SW: u2 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// I2C1 clock source selection
        I2C1SW: u1 = 0,
        /// I2C2 clock source selection
        I2C2SW: u1 = 0,
        /// I2C3 clock source selection
        I2C3SW: u1 = 0,
        reserved3: u1 = 0,
        /// Timer1 clock source selection
        TIM1SW: u1 = 0,
        /// Timer8 clock source selection
        TIM8SW: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// USART2 clock source selection
        USART2SW: u2 = 0,
        /// USART3 clock source selection
        USART3SW: u2 = 0,
        /// UART4 clock source selection
        UART4SW: u2 = 0,
        /// UART5 clock source selection
        UART5SW: u2 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// DMA controller 1
pub const DMA1 = extern struct {
    pub const Address: u32 = 0x40020000;

    /// DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        /// Channel 1 Global interrupt flag
        GIF1: u1 = 0,
        /// Channel 1 Transfer Complete flag
        TCIF1: u1 = 0,
        /// Channel 1 Half Transfer Complete flag
        HTIF1: u1 = 0,
        /// Channel 1 Transfer Error flag
        TEIF1: u1 = 0,
        /// Channel 2 Global interrupt flag
        GIF2: u1 = 0,
        /// Channel 2 Transfer Complete flag
        TCIF2: u1 = 0,
        /// Channel 2 Half Transfer Complete flag
        HTIF2: u1 = 0,
        /// Channel 2 Transfer Error flag
        TEIF2: u1 = 0,
        /// Channel 3 Global interrupt flag
        GIF3: u1 = 0,
        /// Channel 3 Transfer Complete flag
        TCIF3: u1 = 0,
        /// Channel 3 Half Transfer Complete flag
        HTIF3: u1 = 0,
        /// Channel 3 Transfer Error flag
        TEIF3: u1 = 0,
        /// Channel 4 Global interrupt flag
        GIF4: u1 = 0,
        /// Channel 4 Transfer Complete flag
        TCIF4: u1 = 0,
        /// Channel 4 Half Transfer Complete flag
        HTIF4: u1 = 0,
        /// Channel 4 Transfer Error flag
        TEIF4: u1 = 0,
        /// Channel 5 Global interrupt flag
        GIF5: u1 = 0,
        /// Channel 5 Transfer Complete flag
        TCIF5: u1 = 0,
        /// Channel 5 Half Transfer Complete flag
        HTIF5: u1 = 0,
        /// Channel 5 Transfer Error flag
        TEIF5: u1 = 0,
        /// Channel 6 Global interrupt flag
        GIF6: u1 = 0,
        /// Channel 6 Transfer Complete flag
        TCIF6: u1 = 0,
        /// Channel 6 Half Transfer Complete flag
        HTIF6: u1 = 0,
        /// Channel 6 Transfer Error flag
        TEIF6: u1 = 0,
        /// Channel 7 Global interrupt flag
        GIF7: u1 = 0,
        /// Channel 7 Transfer Complete flag
        TCIF7: u1 = 0,
        /// Channel 7 Half Transfer Complete flag
        HTIF7: u1 = 0,
        /// Channel 7 Transfer Error flag
        TEIF7: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        /// Channel 1 Global interrupt clear
        CGIF1: u1 = 0,
        /// Channel 1 Transfer Complete clear
        CTCIF1: u1 = 0,
        /// Channel 1 Half Transfer clear
        CHTIF1: u1 = 0,
        /// Channel 1 Transfer Error clear
        CTEIF1: u1 = 0,
        /// Channel 2 Global interrupt clear
        CGIF2: u1 = 0,
        /// Channel 2 Transfer Complete clear
        CTCIF2: u1 = 0,
        /// Channel 2 Half Transfer clear
        CHTIF2: u1 = 0,
        /// Channel 2 Transfer Error clear
        CTEIF2: u1 = 0,
        /// Channel 3 Global interrupt clear
        CGIF3: u1 = 0,
        /// Channel 3 Transfer Complete clear
        CTCIF3: u1 = 0,
        /// Channel 3 Half Transfer clear
        CHTIF3: u1 = 0,
        /// Channel 3 Transfer Error clear
        CTEIF3: u1 = 0,
        /// Channel 4 Global interrupt clear
        CGIF4: u1 = 0,
        /// Channel 4 Transfer Complete clear
        CTCIF4: u1 = 0,
        /// Channel 4 Half Transfer clear
        CHTIF4: u1 = 0,
        /// Channel 4 Transfer Error clear
        CTEIF4: u1 = 0,
        /// Channel 5 Global interrupt clear
        CGIF5: u1 = 0,
        /// Channel 5 Transfer Complete clear
        CTCIF5: u1 = 0,
        /// Channel 5 Half Transfer clear
        CHTIF5: u1 = 0,
        /// Channel 5 Transfer Error clear
        CTEIF5: u1 = 0,
        /// Channel 6 Global interrupt clear
        CGIF6: u1 = 0,
        /// Channel 6 Transfer Complete clear
        CTCIF6: u1 = 0,
        /// Channel 6 Half Transfer clear
        CHTIF6: u1 = 0,
        /// Channel 6 Transfer Error clear
        CTEIF6: u1 = 0,
        /// Channel 7 Global interrupt clear
        CGIF7: u1 = 0,
        /// Channel 7 Transfer Complete clear
        CTCIF7: u1 = 0,
        /// Channel 7 Half Transfer clear
        CHTIF7: u1 = 0,
        /// Channel 7 Transfer Error clear
        CTEIF7: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });
};

/// DMA controller 1
pub const DMA2 = extern struct {
    pub const Address: u32 = 0x40020400;

    /// DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        /// Channel 1 Global interrupt flag
        GIF1: u1 = 0,
        /// Channel 1 Transfer Complete flag
        TCIF1: u1 = 0,
        /// Channel 1 Half Transfer Complete flag
        HTIF1: u1 = 0,
        /// Channel 1 Transfer Error flag
        TEIF1: u1 = 0,
        /// Channel 2 Global interrupt flag
        GIF2: u1 = 0,
        /// Channel 2 Transfer Complete flag
        TCIF2: u1 = 0,
        /// Channel 2 Half Transfer Complete flag
        HTIF2: u1 = 0,
        /// Channel 2 Transfer Error flag
        TEIF2: u1 = 0,
        /// Channel 3 Global interrupt flag
        GIF3: u1 = 0,
        /// Channel 3 Transfer Complete flag
        TCIF3: u1 = 0,
        /// Channel 3 Half Transfer Complete flag
        HTIF3: u1 = 0,
        /// Channel 3 Transfer Error flag
        TEIF3: u1 = 0,
        /// Channel 4 Global interrupt flag
        GIF4: u1 = 0,
        /// Channel 4 Transfer Complete flag
        TCIF4: u1 = 0,
        /// Channel 4 Half Transfer Complete flag
        HTIF4: u1 = 0,
        /// Channel 4 Transfer Error flag
        TEIF4: u1 = 0,
        /// Channel 5 Global interrupt flag
        GIF5: u1 = 0,
        /// Channel 5 Transfer Complete flag
        TCIF5: u1 = 0,
        /// Channel 5 Half Transfer Complete flag
        HTIF5: u1 = 0,
        /// Channel 5 Transfer Error flag
        TEIF5: u1 = 0,
        /// Channel 6 Global interrupt flag
        GIF6: u1 = 0,
        /// Channel 6 Transfer Complete flag
        TCIF6: u1 = 0,
        /// Channel 6 Half Transfer Complete flag
        HTIF6: u1 = 0,
        /// Channel 6 Transfer Error flag
        TEIF6: u1 = 0,
        /// Channel 7 Global interrupt flag
        GIF7: u1 = 0,
        /// Channel 7 Transfer Complete flag
        TCIF7: u1 = 0,
        /// Channel 7 Half Transfer Complete flag
        HTIF7: u1 = 0,
        /// Channel 7 Transfer Error flag
        TEIF7: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        /// Channel 1 Global interrupt clear
        CGIF1: u1 = 0,
        /// Channel 1 Transfer Complete clear
        CTCIF1: u1 = 0,
        /// Channel 1 Half Transfer clear
        CHTIF1: u1 = 0,
        /// Channel 1 Transfer Error clear
        CTEIF1: u1 = 0,
        /// Channel 2 Global interrupt clear
        CGIF2: u1 = 0,
        /// Channel 2 Transfer Complete clear
        CTCIF2: u1 = 0,
        /// Channel 2 Half Transfer clear
        CHTIF2: u1 = 0,
        /// Channel 2 Transfer Error clear
        CTEIF2: u1 = 0,
        /// Channel 3 Global interrupt clear
        CGIF3: u1 = 0,
        /// Channel 3 Transfer Complete clear
        CTCIF3: u1 = 0,
        /// Channel 3 Half Transfer clear
        CHTIF3: u1 = 0,
        /// Channel 3 Transfer Error clear
        CTEIF3: u1 = 0,
        /// Channel 4 Global interrupt clear
        CGIF4: u1 = 0,
        /// Channel 4 Transfer Complete clear
        CTCIF4: u1 = 0,
        /// Channel 4 Half Transfer clear
        CHTIF4: u1 = 0,
        /// Channel 4 Transfer Error clear
        CTEIF4: u1 = 0,
        /// Channel 5 Global interrupt clear
        CGIF5: u1 = 0,
        /// Channel 5 Transfer Complete clear
        CTCIF5: u1 = 0,
        /// Channel 5 Half Transfer clear
        CHTIF5: u1 = 0,
        /// Channel 5 Transfer Error clear
        CTEIF5: u1 = 0,
        /// Channel 6 Global interrupt clear
        CGIF6: u1 = 0,
        /// Channel 6 Transfer Complete clear
        CTCIF6: u1 = 0,
        /// Channel 6 Half Transfer clear
        CHTIF6: u1 = 0,
        /// Channel 6 Transfer Error clear
        CTEIF6: u1 = 0,
        /// Channel 7 Global interrupt clear
        CGIF7: u1 = 0,
        /// Channel 7 Transfer Complete clear
        CTCIF7: u1 = 0,
        /// Channel 7 Half Transfer clear
        CHTIF7: u1 = 0,
        /// Channel 7 Transfer Error clear
        CTEIF7: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });

    /// DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        /// Channel enable
        EN: u1 = 0,
        /// Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// Half Transfer interrupt enable
        HTIE: u1 = 0,
        /// Transfer error interrupt enable
        TEIE: u1 = 0,
        /// Data transfer direction
        DIR: u1 = 0,
        /// Circular mode
        CIRC: u1 = 0,
        /// Peripheral increment mode
        PINC: u1 = 0,
        /// Memory increment mode
        MINC: u1 = 0,
        /// Peripheral size
        PSIZE: u2 = 0,
        /// Memory size
        MSIZE: u2 = 0,
        /// Channel Priority level
        PL: u2 = 0,
        /// Memory to memory mode
        MEM2MEM: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        /// Number of data to transfer
        NDT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        /// Peripheral address
        PA: u32 = 0,
    });

    /// DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        /// Memory address
        MA: u32 = 0,
    });
};

/// General purpose timer
pub const TIM2 = extern struct {
    pub const Address: u32 = 0x40000000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit3
        SMS_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        reserved2: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        reserved3: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// Output compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// Output compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        O24CE: u1 = 0,
        /// Output compare 3 mode bit3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 4 mode bit3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved4: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4NP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// Low counter value
        CNTL: u16 = 0,
        /// High counter value
        CNTH: u15 = 0,
        /// if IUFREMAP=0 than CNT with read write access else UIFCPY with read only
        /// access
        CNT_or_UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Low Auto-reload value
        ARRL: u16 = 0,
        /// High Auto-reload value
        ARRH: u16 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Low Capture/Compare 1 value
        CCR1L: u16 = 0,
        /// High Capture/Compare 1 value (on TIM2)
        CCR1H: u16 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Low Capture/Compare 2 value
        CCR2L: u16 = 0,
        /// High Capture/Compare 2 value (on TIM2)
        CCR2H: u16 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Low Capture/Compare value
        CCR3L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR3H: u16 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Low Capture/Compare value
        CCR4L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR4H: u16 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General purpose timer
pub const TIM3 = extern struct {
    pub const Address: u32 = 0x40000400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit3
        SMS_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        reserved2: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        reserved3: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// Output compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// Output compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        O24CE: u1 = 0,
        /// Output compare 3 mode bit3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 4 mode bit3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved4: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4NP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// Low counter value
        CNTL: u16 = 0,
        /// High counter value
        CNTH: u15 = 0,
        /// if IUFREMAP=0 than CNT with read write access else UIFCPY with read only
        /// access
        CNT_or_UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Low Auto-reload value
        ARRL: u16 = 0,
        /// High Auto-reload value
        ARRH: u16 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Low Capture/Compare 1 value
        CCR1L: u16 = 0,
        /// High Capture/Compare 1 value (on TIM2)
        CCR1H: u16 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Low Capture/Compare 2 value
        CCR2L: u16 = 0,
        /// High Capture/Compare 2 value (on TIM2)
        CCR2H: u16 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Low Capture/Compare value
        CCR3L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR3H: u16 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Low Capture/Compare value
        CCR4L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR4H: u16 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General purpose timer
pub const TIM4 = extern struct {
    pub const Address: u32 = 0x40000800;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit3
        SMS_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        reserved2: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        reserved3: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output compare 1 mode
        OC1M: u3 = 0,
        /// Output compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output compare 2 mode
        OC2M: u3 = 0,
        /// Output compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        O24CE: u1 = 0,
        /// Output compare 3 mode bit3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 4 mode bit3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved4: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4NP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// Low counter value
        CNTL: u16 = 0,
        /// High counter value
        CNTH: u15 = 0,
        /// if IUFREMAP=0 than CNT with read write access else UIFCPY with read only
        /// access
        CNT_or_UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Low Auto-reload value
        ARRL: u16 = 0,
        /// High Auto-reload value
        ARRH: u16 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Low Capture/Compare 1 value
        CCR1L: u16 = 0,
        /// High Capture/Compare 1 value (on TIM2)
        CCR1H: u16 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Low Capture/Compare 2 value
        CCR2L: u16 = 0,
        /// High Capture/Compare 2 value (on TIM2)
        CCR2H: u16 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Low Capture/Compare value
        CCR3L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR3H: u16 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Low Capture/Compare value
        CCR4L: u16 = 0,
        /// High Capture/Compare value (on TIM2)
        CCR4H: u16 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General purpose timers
pub const TIM15 = extern struct {
    pub const Address: u32 = 0x40014000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved4: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// Output Idle state 2
        OIS2: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        reserved1: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Slave mode selection bit 3
        SMS_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output Compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output Compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        reserved2: u1 = 0,
        /// Output Compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Output Compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PSC: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// General-purpose-timers
pub const TIM16 = extern struct {
    pub const Address: u32 = 0x40014400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved4: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        reserved4: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 mode
        OC1M_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF Copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// option register
    pub const OR = @intToPtr(*volatile u32, Address + 0x00000050);
};

/// General purpose timer
pub const TIM17 = extern struct {
    pub const Address: u32 = 0x40014800;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved4: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        reserved4: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 mode
        OC1M_3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PSC: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF Copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART1 = extern struct {
    pub const Address: u32 = 0x40013800;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// USART enable
        UE: u1 = 0,
        /// USART enable in Stop mode
        UESM: u1 = 0,
        /// Receiver enable
        RE: u1 = 0,
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Receiver wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// Mute mode enable
        MME: u1 = 0,
        /// Character match interrupt enable
        CMIE: u1 = 0,
        /// Oversampling mode
        OVER8: u1 = 0,
        /// Driver Enable deassertion time
        DEDT: u5 = 0,
        /// Driver Enable assertion time
        DEAT: u5 = 0,
        /// Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// End of Block interrupt enable
        EOBIE: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// LIN break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved5: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        /// Swap TX/RX pins
        SWAP: u1 = 0,
        /// RX pin active level inversion
        RXINV: u1 = 0,
        /// TX pin active level inversion
        TXINV: u1 = 0,
        /// Binary data inversion
        DATAINV: u1 = 0,
        /// Most significant bit first
        MSBFIRST: u1 = 0,
        /// Auto baud rate enable
        ABREN: u1 = 0,
        /// Auto baud rate mode
        ABRMOD: u2 = 0,
        /// Receiver timeout enable
        RTOEN: u1 = 0,
        /// Address of the USART node
        ADD0: u4 = 0,
        /// Address of the USART node
        ADD4: u4 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTS enable
        RTSE: u1 = 0,
        /// CTS enable
        CTSE: u1 = 0,
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// One sample bit method enable
        ONEBIT: u1 = 0,
        /// Overrun Disable
        OVRDIS: u1 = 0,
        /// DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// Driver enable mode
        DEM: u1 = 0,
        /// Driver enable polarity selection
        DEP: u1 = 0,
        reserved1: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        /// Prescaler value
        PSC: u8 = 0,
        /// Guard time value
        GT: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        /// Receiver timeout value
        RTO: u24 = 0,
        /// Block Length
        BLEN: u8 = 0,
    });

    /// Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        /// Auto baud rate request
        ABRRQ: u1 = 0,
        /// Send break request
        SBKRQ: u1 = 0,
        /// Mute mode request
        MMRQ: u1 = 0,
        /// Receive data flush request
        RXFRQ: u1 = 0,
        /// Transmit data flush request
        TXFRQ: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise detected flag
        NF: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// Idle line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBDF: u1 = 0,
        /// CTS interrupt flag
        CTSIF: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
        /// Receiver timeout
        RTOF: u1 = 0,
        /// End of block flag
        EOBF: u1 = 0,
        reserved1: u1 = 0,
        /// Auto baud rate error
        ABRE: u1 = 0,
        /// Auto baud rate flag
        ABRF: u1 = 0,
        /// Busy flag
        BUSY: u1 = 0,
        /// character match flag
        CMF: u1 = 0,
        /// Send break flag
        SBKF: u1 = 0,
        /// Receiver wakeup from Mute mode
        RWU: u1 = 0,
        /// Wakeup from Stop mode flag
        WUF: u1 = 0,
        /// Transmit enable acknowledge flag
        TEACK: u1 = 0,
        /// Receive enable acknowledge flag
        REACK: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        /// Parity error clear flag
        PECF: u1 = 0,
        /// Framing error clear flag
        FECF: u1 = 0,
        /// Noise detected clear flag
        NCF: u1 = 0,
        /// Overrun error clear flag
        ORECF: u1 = 0,
        /// Idle line detected clear flag
        IDLECF: u1 = 0,
        reserved1: u1 = 0,
        /// Transmission complete clear flag
        TCCF: u1 = 0,
        reserved2: u1 = 0,
        /// LIN break detection clear flag
        LBDCF: u1 = 0,
        /// CTS clear flag
        CTSCF: u1 = 0,
        reserved3: u1 = 0,
        /// Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// End of timeout clear flag
        EOBCF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Character match clear flag
        CMCF: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        /// Receive data value
        RDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        /// Transmit data value
        TDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART2 = extern struct {
    pub const Address: u32 = 0x40004400;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// USART enable
        UE: u1 = 0,
        /// USART enable in Stop mode
        UESM: u1 = 0,
        /// Receiver enable
        RE: u1 = 0,
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Receiver wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// Mute mode enable
        MME: u1 = 0,
        /// Character match interrupt enable
        CMIE: u1 = 0,
        /// Oversampling mode
        OVER8: u1 = 0,
        /// Driver Enable deassertion time
        DEDT: u5 = 0,
        /// Driver Enable assertion time
        DEAT: u5 = 0,
        /// Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// End of Block interrupt enable
        EOBIE: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// LIN break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved5: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        /// Swap TX/RX pins
        SWAP: u1 = 0,
        /// RX pin active level inversion
        RXINV: u1 = 0,
        /// TX pin active level inversion
        TXINV: u1 = 0,
        /// Binary data inversion
        DATAINV: u1 = 0,
        /// Most significant bit first
        MSBFIRST: u1 = 0,
        /// Auto baud rate enable
        ABREN: u1 = 0,
        /// Auto baud rate mode
        ABRMOD: u2 = 0,
        /// Receiver timeout enable
        RTOEN: u1 = 0,
        /// Address of the USART node
        ADD0: u4 = 0,
        /// Address of the USART node
        ADD4: u4 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTS enable
        RTSE: u1 = 0,
        /// CTS enable
        CTSE: u1 = 0,
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// One sample bit method enable
        ONEBIT: u1 = 0,
        /// Overrun Disable
        OVRDIS: u1 = 0,
        /// DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// Driver enable mode
        DEM: u1 = 0,
        /// Driver enable polarity selection
        DEP: u1 = 0,
        reserved1: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        /// Prescaler value
        PSC: u8 = 0,
        /// Guard time value
        GT: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        /// Receiver timeout value
        RTO: u24 = 0,
        /// Block Length
        BLEN: u8 = 0,
    });

    /// Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        /// Auto baud rate request
        ABRRQ: u1 = 0,
        /// Send break request
        SBKRQ: u1 = 0,
        /// Mute mode request
        MMRQ: u1 = 0,
        /// Receive data flush request
        RXFRQ: u1 = 0,
        /// Transmit data flush request
        TXFRQ: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise detected flag
        NF: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// Idle line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBDF: u1 = 0,
        /// CTS interrupt flag
        CTSIF: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
        /// Receiver timeout
        RTOF: u1 = 0,
        /// End of block flag
        EOBF: u1 = 0,
        reserved1: u1 = 0,
        /// Auto baud rate error
        ABRE: u1 = 0,
        /// Auto baud rate flag
        ABRF: u1 = 0,
        /// Busy flag
        BUSY: u1 = 0,
        /// character match flag
        CMF: u1 = 0,
        /// Send break flag
        SBKF: u1 = 0,
        /// Receiver wakeup from Mute mode
        RWU: u1 = 0,
        /// Wakeup from Stop mode flag
        WUF: u1 = 0,
        /// Transmit enable acknowledge flag
        TEACK: u1 = 0,
        /// Receive enable acknowledge flag
        REACK: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        /// Parity error clear flag
        PECF: u1 = 0,
        /// Framing error clear flag
        FECF: u1 = 0,
        /// Noise detected clear flag
        NCF: u1 = 0,
        /// Overrun error clear flag
        ORECF: u1 = 0,
        /// Idle line detected clear flag
        IDLECF: u1 = 0,
        reserved1: u1 = 0,
        /// Transmission complete clear flag
        TCCF: u1 = 0,
        reserved2: u1 = 0,
        /// LIN break detection clear flag
        LBDCF: u1 = 0,
        /// CTS clear flag
        CTSCF: u1 = 0,
        reserved3: u1 = 0,
        /// Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// End of timeout clear flag
        EOBCF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Character match clear flag
        CMCF: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        /// Receive data value
        RDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        /// Transmit data value
        TDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART3 = extern struct {
    pub const Address: u32 = 0x40004800;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// USART enable
        UE: u1 = 0,
        /// USART enable in Stop mode
        UESM: u1 = 0,
        /// Receiver enable
        RE: u1 = 0,
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Receiver wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// Mute mode enable
        MME: u1 = 0,
        /// Character match interrupt enable
        CMIE: u1 = 0,
        /// Oversampling mode
        OVER8: u1 = 0,
        /// Driver Enable deassertion time
        DEDT: u5 = 0,
        /// Driver Enable assertion time
        DEAT: u5 = 0,
        /// Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// End of Block interrupt enable
        EOBIE: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// LIN break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved5: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        /// Swap TX/RX pins
        SWAP: u1 = 0,
        /// RX pin active level inversion
        RXINV: u1 = 0,
        /// TX pin active level inversion
        TXINV: u1 = 0,
        /// Binary data inversion
        DATAINV: u1 = 0,
        /// Most significant bit first
        MSBFIRST: u1 = 0,
        /// Auto baud rate enable
        ABREN: u1 = 0,
        /// Auto baud rate mode
        ABRMOD: u2 = 0,
        /// Receiver timeout enable
        RTOEN: u1 = 0,
        /// Address of the USART node
        ADD0: u4 = 0,
        /// Address of the USART node
        ADD4: u4 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTS enable
        RTSE: u1 = 0,
        /// CTS enable
        CTSE: u1 = 0,
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// One sample bit method enable
        ONEBIT: u1 = 0,
        /// Overrun Disable
        OVRDIS: u1 = 0,
        /// DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// Driver enable mode
        DEM: u1 = 0,
        /// Driver enable polarity selection
        DEP: u1 = 0,
        reserved1: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        /// Prescaler value
        PSC: u8 = 0,
        /// Guard time value
        GT: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        /// Receiver timeout value
        RTO: u24 = 0,
        /// Block Length
        BLEN: u8 = 0,
    });

    /// Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        /// Auto baud rate request
        ABRRQ: u1 = 0,
        /// Send break request
        SBKRQ: u1 = 0,
        /// Mute mode request
        MMRQ: u1 = 0,
        /// Receive data flush request
        RXFRQ: u1 = 0,
        /// Transmit data flush request
        TXFRQ: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise detected flag
        NF: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// Idle line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBDF: u1 = 0,
        /// CTS interrupt flag
        CTSIF: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
        /// Receiver timeout
        RTOF: u1 = 0,
        /// End of block flag
        EOBF: u1 = 0,
        reserved1: u1 = 0,
        /// Auto baud rate error
        ABRE: u1 = 0,
        /// Auto baud rate flag
        ABRF: u1 = 0,
        /// Busy flag
        BUSY: u1 = 0,
        /// character match flag
        CMF: u1 = 0,
        /// Send break flag
        SBKF: u1 = 0,
        /// Receiver wakeup from Mute mode
        RWU: u1 = 0,
        /// Wakeup from Stop mode flag
        WUF: u1 = 0,
        /// Transmit enable acknowledge flag
        TEACK: u1 = 0,
        /// Receive enable acknowledge flag
        REACK: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        /// Parity error clear flag
        PECF: u1 = 0,
        /// Framing error clear flag
        FECF: u1 = 0,
        /// Noise detected clear flag
        NCF: u1 = 0,
        /// Overrun error clear flag
        ORECF: u1 = 0,
        /// Idle line detected clear flag
        IDLECF: u1 = 0,
        reserved1: u1 = 0,
        /// Transmission complete clear flag
        TCCF: u1 = 0,
        reserved2: u1 = 0,
        /// LIN break detection clear flag
        LBDCF: u1 = 0,
        /// CTS clear flag
        CTSCF: u1 = 0,
        reserved3: u1 = 0,
        /// Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// End of timeout clear flag
        EOBCF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Character match clear flag
        CMCF: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        /// Receive data value
        RDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        /// Transmit data value
        TDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Universal synchronous asynchronous receiver transmitter
pub const UART4 = extern struct {
    pub const Address: u32 = 0x40004c00;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// USART enable
        UE: u1 = 0,
        /// USART enable in Stop mode
        UESM: u1 = 0,
        /// Receiver enable
        RE: u1 = 0,
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Receiver wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// Mute mode enable
        MME: u1 = 0,
        /// Character match interrupt enable
        CMIE: u1 = 0,
        /// Oversampling mode
        OVER8: u1 = 0,
        /// Driver Enable deassertion time
        DEDT: u5 = 0,
        /// Driver Enable assertion time
        DEAT: u5 = 0,
        /// Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// End of Block interrupt enable
        EOBIE: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// LIN break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved5: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        /// Swap TX/RX pins
        SWAP: u1 = 0,
        /// RX pin active level inversion
        RXINV: u1 = 0,
        /// TX pin active level inversion
        TXINV: u1 = 0,
        /// Binary data inversion
        DATAINV: u1 = 0,
        /// Most significant bit first
        MSBFIRST: u1 = 0,
        /// Auto baud rate enable
        ABREN: u1 = 0,
        /// Auto baud rate mode
        ABRMOD: u2 = 0,
        /// Receiver timeout enable
        RTOEN: u1 = 0,
        /// Address of the USART node
        ADD0: u4 = 0,
        /// Address of the USART node
        ADD4: u4 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTS enable
        RTSE: u1 = 0,
        /// CTS enable
        CTSE: u1 = 0,
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// One sample bit method enable
        ONEBIT: u1 = 0,
        /// Overrun Disable
        OVRDIS: u1 = 0,
        /// DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// Driver enable mode
        DEM: u1 = 0,
        /// Driver enable polarity selection
        DEP: u1 = 0,
        reserved1: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        /// Prescaler value
        PSC: u8 = 0,
        /// Guard time value
        GT: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        /// Receiver timeout value
        RTO: u24 = 0,
        /// Block Length
        BLEN: u8 = 0,
    });

    /// Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        /// Auto baud rate request
        ABRRQ: u1 = 0,
        /// Send break request
        SBKRQ: u1 = 0,
        /// Mute mode request
        MMRQ: u1 = 0,
        /// Receive data flush request
        RXFRQ: u1 = 0,
        /// Transmit data flush request
        TXFRQ: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise detected flag
        NF: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// Idle line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBDF: u1 = 0,
        /// CTS interrupt flag
        CTSIF: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
        /// Receiver timeout
        RTOF: u1 = 0,
        /// End of block flag
        EOBF: u1 = 0,
        reserved1: u1 = 0,
        /// Auto baud rate error
        ABRE: u1 = 0,
        /// Auto baud rate flag
        ABRF: u1 = 0,
        /// Busy flag
        BUSY: u1 = 0,
        /// character match flag
        CMF: u1 = 0,
        /// Send break flag
        SBKF: u1 = 0,
        /// Receiver wakeup from Mute mode
        RWU: u1 = 0,
        /// Wakeup from Stop mode flag
        WUF: u1 = 0,
        /// Transmit enable acknowledge flag
        TEACK: u1 = 0,
        /// Receive enable acknowledge flag
        REACK: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        /// Parity error clear flag
        PECF: u1 = 0,
        /// Framing error clear flag
        FECF: u1 = 0,
        /// Noise detected clear flag
        NCF: u1 = 0,
        /// Overrun error clear flag
        ORECF: u1 = 0,
        /// Idle line detected clear flag
        IDLECF: u1 = 0,
        reserved1: u1 = 0,
        /// Transmission complete clear flag
        TCCF: u1 = 0,
        reserved2: u1 = 0,
        /// LIN break detection clear flag
        LBDCF: u1 = 0,
        /// CTS clear flag
        CTSCF: u1 = 0,
        reserved3: u1 = 0,
        /// Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// End of timeout clear flag
        EOBCF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Character match clear flag
        CMCF: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        /// Receive data value
        RDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        /// Transmit data value
        TDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Universal synchronous asynchronous receiver transmitter
pub const UART5 = extern struct {
    pub const Address: u32 = 0x40005000;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// USART enable
        UE: u1 = 0,
        /// USART enable in Stop mode
        UESM: u1 = 0,
        /// Receiver enable
        RE: u1 = 0,
        /// Transmitter enable
        TE: u1 = 0,
        /// IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Receiver wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// Mute mode enable
        MME: u1 = 0,
        /// Character match interrupt enable
        CMIE: u1 = 0,
        /// Oversampling mode
        OVER8: u1 = 0,
        /// Driver Enable deassertion time
        DEDT: u5 = 0,
        /// Driver Enable assertion time
        DEAT: u5 = 0,
        /// Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// End of Block interrupt enable
        EOBIE: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// LIN break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved5: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1 = 0,
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Clock enable
        CLKEN: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        /// Swap TX/RX pins
        SWAP: u1 = 0,
        /// RX pin active level inversion
        RXINV: u1 = 0,
        /// TX pin active level inversion
        TXINV: u1 = 0,
        /// Binary data inversion
        DATAINV: u1 = 0,
        /// Most significant bit first
        MSBFIRST: u1 = 0,
        /// Auto baud rate enable
        ABREN: u1 = 0,
        /// Auto baud rate mode
        ABRMOD: u2 = 0,
        /// Receiver timeout enable
        RTOEN: u1 = 0,
        /// Address of the USART node
        ADD0: u4 = 0,
        /// Address of the USART node
        ADD4: u4 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        /// Smartcard NACK enable
        NACK: u1 = 0,
        /// Smartcard mode enable
        SCEN: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
        /// RTS enable
        RTSE: u1 = 0,
        /// CTS enable
        CTSE: u1 = 0,
        /// CTS interrupt enable
        CTSIE: u1 = 0,
        /// One sample bit method enable
        ONEBIT: u1 = 0,
        /// Overrun Disable
        OVRDIS: u1 = 0,
        /// DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// Driver enable mode
        DEM: u1 = 0,
        /// Driver enable polarity selection
        DEP: u1 = 0,
        reserved1: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        /// fraction of USARTDIV
        DIV_Fraction: u4 = 0,
        /// mantissa of USARTDIV
        DIV_Mantissa: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        /// Prescaler value
        PSC: u8 = 0,
        /// Guard time value
        GT: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        /// Receiver timeout value
        RTO: u24 = 0,
        /// Block Length
        BLEN: u8 = 0,
    });

    /// Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        /// Auto baud rate request
        ABRRQ: u1 = 0,
        /// Send break request
        SBKRQ: u1 = 0,
        /// Mute mode request
        MMRQ: u1 = 0,
        /// Receive data flush request
        RXFRQ: u1 = 0,
        /// Transmit data flush request
        TXFRQ: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise detected flag
        NF: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// Idle line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBDF: u1 = 0,
        /// CTS interrupt flag
        CTSIF: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
        /// Receiver timeout
        RTOF: u1 = 0,
        /// End of block flag
        EOBF: u1 = 0,
        reserved1: u1 = 0,
        /// Auto baud rate error
        ABRE: u1 = 0,
        /// Auto baud rate flag
        ABRF: u1 = 0,
        /// Busy flag
        BUSY: u1 = 0,
        /// character match flag
        CMF: u1 = 0,
        /// Send break flag
        SBKF: u1 = 0,
        /// Receiver wakeup from Mute mode
        RWU: u1 = 0,
        /// Wakeup from Stop mode flag
        WUF: u1 = 0,
        /// Transmit enable acknowledge flag
        TEACK: u1 = 0,
        /// Receive enable acknowledge flag
        REACK: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        /// Parity error clear flag
        PECF: u1 = 0,
        /// Framing error clear flag
        FECF: u1 = 0,
        /// Noise detected clear flag
        NCF: u1 = 0,
        /// Overrun error clear flag
        ORECF: u1 = 0,
        /// Idle line detected clear flag
        IDLECF: u1 = 0,
        reserved1: u1 = 0,
        /// Transmission complete clear flag
        TCCF: u1 = 0,
        reserved2: u1 = 0,
        /// LIN break detection clear flag
        LBDCF: u1 = 0,
        /// CTS clear flag
        CTSCF: u1 = 0,
        reserved3: u1 = 0,
        /// Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// End of timeout clear flag
        EOBCF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Character match clear flag
        CMCF: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        /// Receive data value
        RDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        /// Transmit data value
        TDR: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const SPI1 = extern struct {
    pub const Address: u32 = 0x40013000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const SPI2 = extern struct {
    pub const Address: u32 = 0x40003800;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const SPI3 = extern struct {
    pub const Address: u32 = 0x40003c00;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const I2S2ext = extern struct {
    pub const Address: u32 = 0x40003400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const I2S3ext = extern struct {
    pub const Address: u32 = 0x40004000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Serial peripheral interface/Inter-IC sound
pub const SPI4 = extern struct {
    pub const Address: u32 = 0x40013c00;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Clock phase
        CPHA: u1 = 0,
        /// Clock polarity
        CPOL: u1 = 0,
        /// Master selection
        MSTR: u1 = 0,
        /// Baud rate control
        BR: u3 = 0,
        /// SPI enable
        SPE: u1 = 0,
        /// Frame format
        LSBFIRST: u1 = 0,
        /// Internal slave select
        SSI: u1 = 0,
        /// Software slave management
        SSM: u1 = 0,
        /// Receive only
        RXONLY: u1 = 0,
        /// CRC length
        CRCL: u1 = 0,
        /// CRC transfer next
        CRCNEXT: u1 = 0,
        /// Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// SS output enable
        SSOE: u1 = 0,
        /// NSS pulse management
        NSSP: u1 = 0,
        /// Frame format
        FRF: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        /// Data size
        DS: u4 = 0,
        /// FIFO reception threshold
        FRXTH: u1 = 0,
        /// Last DMA transfer for reception
        LDMA_RX: u1 = 0,
        /// Last DMA transfer for transmission
        LDMA_TX: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Receive buffer not empty
        RXNE: u1 = 0,
        /// Transmit buffer empty
        TXE: u1 = 0,
        /// Channel side
        CHSIDE: u1 = 0,
        /// Underrun flag
        UDR: u1 = 0,
        /// CRC error flag
        CRCERR: u1 = 0,
        /// Mode fault
        MODF: u1 = 0,
        /// Overrun flag
        OVR: u1 = 0,
        /// Busy flag
        BSY: u1 = 0,
        /// TI frame format error
        TIFRFE: u1 = 0,
        /// FIFO reception level
        FRLVL: u2 = 0,
        /// FIFO transmission level
        FTLVL: u2 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Data register
        DR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        /// CRC polynomial register
        CRCPOLY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Rx CRC register
        RxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        /// Tx CRC register
        TxCRC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// Data length to be transferred
        DATLEN: u2 = 0,
        /// Steady state clock polarity
        CKPOL: u1 = 0,
        /// I2S standard selection
        I2SSTD: u2 = 0,
        reserved1: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// I2S configuration mode
        I2SCFG: u2 = 0,
        /// I2S Enable
        I2SE: u1 = 0,
        /// I2S mode selection
        I2SMOD: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        /// I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// Odd factor for the prescaler
        ODD: u1 = 0,
        /// Master clock output enable
        MCKOE: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// External interrupt/event controller
pub const EXTI = extern struct {
    pub const Address: u32 = 0x40010400;

    /// Interrupt mask register
    pub const IMR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Interrupt Mask on line 0
        MR0: u1 = 0,
        /// Interrupt Mask on line 1
        MR1: u1 = 0,
        /// Interrupt Mask on line 2
        MR2: u1 = 0,
        /// Interrupt Mask on line 3
        MR3: u1 = 0,
        /// Interrupt Mask on line 4
        MR4: u1 = 0,
        /// Interrupt Mask on line 5
        MR5: u1 = 0,
        /// Interrupt Mask on line 6
        MR6: u1 = 0,
        /// Interrupt Mask on line 7
        MR7: u1 = 0,
        /// Interrupt Mask on line 8
        MR8: u1 = 0,
        /// Interrupt Mask on line 9
        MR9: u1 = 0,
        /// Interrupt Mask on line 10
        MR10: u1 = 0,
        /// Interrupt Mask on line 11
        MR11: u1 = 0,
        /// Interrupt Mask on line 12
        MR12: u1 = 0,
        /// Interrupt Mask on line 13
        MR13: u1 = 0,
        /// Interrupt Mask on line 14
        MR14: u1 = 0,
        /// Interrupt Mask on line 15
        MR15: u1 = 0,
        /// Interrupt Mask on line 16
        MR16: u1 = 0,
        /// Interrupt Mask on line 17
        MR17: u1 = 0,
        /// Interrupt Mask on line 18
        MR18: u1 = 0,
        /// Interrupt Mask on line 19
        MR19: u1 = 0,
        /// Interrupt Mask on line 20
        MR20: u1 = 0,
        /// Interrupt Mask on line 21
        MR21: u1 = 0,
        /// Interrupt Mask on line 22
        MR22: u1 = 0,
        /// Interrupt Mask on line 23
        MR23: u1 = 0,
        /// Interrupt Mask on line 24
        MR24: u1 = 0,
        /// Interrupt Mask on line 25
        MR25: u1 = 0,
        /// Interrupt Mask on line 26
        MR26: u1 = 0,
        /// Interrupt Mask on line 27
        MR27: u1 = 0,
        /// Interrupt Mask on line 28
        MR28: u1 = 0,
        /// Interrupt Mask on line 29
        MR29: u1 = 0,
        /// Interrupt Mask on line 30
        MR30: u1 = 0,
        /// Interrupt Mask on line 31
        MR31: u1 = 0,
    });

    /// Event mask register
    pub const EMR1 = mmio(Address + 0x00000004, 32, packed struct {
        /// Event Mask on line 0
        MR0: u1 = 0,
        /// Event Mask on line 1
        MR1: u1 = 0,
        /// Event Mask on line 2
        MR2: u1 = 0,
        /// Event Mask on line 3
        MR3: u1 = 0,
        /// Event Mask on line 4
        MR4: u1 = 0,
        /// Event Mask on line 5
        MR5: u1 = 0,
        /// Event Mask on line 6
        MR6: u1 = 0,
        /// Event Mask on line 7
        MR7: u1 = 0,
        /// Event Mask on line 8
        MR8: u1 = 0,
        /// Event Mask on line 9
        MR9: u1 = 0,
        /// Event Mask on line 10
        MR10: u1 = 0,
        /// Event Mask on line 11
        MR11: u1 = 0,
        /// Event Mask on line 12
        MR12: u1 = 0,
        /// Event Mask on line 13
        MR13: u1 = 0,
        /// Event Mask on line 14
        MR14: u1 = 0,
        /// Event Mask on line 15
        MR15: u1 = 0,
        /// Event Mask on line 16
        MR16: u1 = 0,
        /// Event Mask on line 17
        MR17: u1 = 0,
        /// Event Mask on line 18
        MR18: u1 = 0,
        /// Event Mask on line 19
        MR19: u1 = 0,
        /// Event Mask on line 20
        MR20: u1 = 0,
        /// Event Mask on line 21
        MR21: u1 = 0,
        /// Event Mask on line 22
        MR22: u1 = 0,
        /// Event Mask on line 23
        MR23: u1 = 0,
        /// Event Mask on line 24
        MR24: u1 = 0,
        /// Event Mask on line 25
        MR25: u1 = 0,
        /// Event Mask on line 26
        MR26: u1 = 0,
        /// Event Mask on line 27
        MR27: u1 = 0,
        /// Event Mask on line 28
        MR28: u1 = 0,
        /// Event Mask on line 29
        MR29: u1 = 0,
        /// Event Mask on line 30
        MR30: u1 = 0,
        /// Event Mask on line 31
        MR31: u1 = 0,
    });

    /// Rising Trigger selection register
    pub const RTSR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Rising trigger event configuration of line 0
        TR0: u1 = 0,
        /// Rising trigger event configuration of line 1
        TR1: u1 = 0,
        /// Rising trigger event configuration of line 2
        TR2: u1 = 0,
        /// Rising trigger event configuration of line 3
        TR3: u1 = 0,
        /// Rising trigger event configuration of line 4
        TR4: u1 = 0,
        /// Rising trigger event configuration of line 5
        TR5: u1 = 0,
        /// Rising trigger event configuration of line 6
        TR6: u1 = 0,
        /// Rising trigger event configuration of line 7
        TR7: u1 = 0,
        /// Rising trigger event configuration of line 8
        TR8: u1 = 0,
        /// Rising trigger event configuration of line 9
        TR9: u1 = 0,
        /// Rising trigger event configuration of line 10
        TR10: u1 = 0,
        /// Rising trigger event configuration of line 11
        TR11: u1 = 0,
        /// Rising trigger event configuration of line 12
        TR12: u1 = 0,
        /// Rising trigger event configuration of line 13
        TR13: u1 = 0,
        /// Rising trigger event configuration of line 14
        TR14: u1 = 0,
        /// Rising trigger event configuration of line 15
        TR15: u1 = 0,
        /// Rising trigger event configuration of line 16
        TR16: u1 = 0,
        /// Rising trigger event configuration of line 17
        TR17: u1 = 0,
        /// Rising trigger event configuration of line 18
        TR18: u1 = 0,
        /// Rising trigger event configuration of line 19
        TR19: u1 = 0,
        /// Rising trigger event configuration of line 20
        TR20: u1 = 0,
        /// Rising trigger event configuration of line 21
        TR21: u1 = 0,
        /// Rising trigger event configuration of line 22
        TR22: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Rising trigger event configuration of line 29
        TR29: u1 = 0,
        /// Rising trigger event configuration of line 30
        TR30: u1 = 0,
        /// Rising trigger event configuration of line 31
        TR31: u1 = 0,
    });

    /// Falling Trigger selection register
    pub const FTSR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Falling trigger event configuration of line 0
        TR0: u1 = 0,
        /// Falling trigger event configuration of line 1
        TR1: u1 = 0,
        /// Falling trigger event configuration of line 2
        TR2: u1 = 0,
        /// Falling trigger event configuration of line 3
        TR3: u1 = 0,
        /// Falling trigger event configuration of line 4
        TR4: u1 = 0,
        /// Falling trigger event configuration of line 5
        TR5: u1 = 0,
        /// Falling trigger event configuration of line 6
        TR6: u1 = 0,
        /// Falling trigger event configuration of line 7
        TR7: u1 = 0,
        /// Falling trigger event configuration of line 8
        TR8: u1 = 0,
        /// Falling trigger event configuration of line 9
        TR9: u1 = 0,
        /// Falling trigger event configuration of line 10
        TR10: u1 = 0,
        /// Falling trigger event configuration of line 11
        TR11: u1 = 0,
        /// Falling trigger event configuration of line 12
        TR12: u1 = 0,
        /// Falling trigger event configuration of line 13
        TR13: u1 = 0,
        /// Falling trigger event configuration of line 14
        TR14: u1 = 0,
        /// Falling trigger event configuration of line 15
        TR15: u1 = 0,
        /// Falling trigger event configuration of line 16
        TR16: u1 = 0,
        /// Falling trigger event configuration of line 17
        TR17: u1 = 0,
        /// Falling trigger event configuration of line 18
        TR18: u1 = 0,
        /// Falling trigger event configuration of line 19
        TR19: u1 = 0,
        /// Falling trigger event configuration of line 20
        TR20: u1 = 0,
        /// Falling trigger event configuration of line 21
        TR21: u1 = 0,
        /// Falling trigger event configuration of line 22
        TR22: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Falling trigger event configuration of line 29
        TR29: u1 = 0,
        /// Falling trigger event configuration of line 30.
        TR30: u1 = 0,
        /// Falling trigger event configuration of line 31
        TR31: u1 = 0,
    });

    /// Software interrupt event register
    pub const SWIER1 = mmio(Address + 0x00000010, 32, packed struct {
        /// Software Interrupt on line 0
        SWIER0: u1 = 0,
        /// Software Interrupt on line 1
        SWIER1: u1 = 0,
        /// Software Interrupt on line 2
        SWIER2: u1 = 0,
        /// Software Interrupt on line 3
        SWIER3: u1 = 0,
        /// Software Interrupt on line 4
        SWIER4: u1 = 0,
        /// Software Interrupt on line 5
        SWIER5: u1 = 0,
        /// Software Interrupt on line 6
        SWIER6: u1 = 0,
        /// Software Interrupt on line 7
        SWIER7: u1 = 0,
        /// Software Interrupt on line 8
        SWIER8: u1 = 0,
        /// Software Interrupt on line 9
        SWIER9: u1 = 0,
        /// Software Interrupt on line 10
        SWIER10: u1 = 0,
        /// Software Interrupt on line 11
        SWIER11: u1 = 0,
        /// Software Interrupt on line 12
        SWIER12: u1 = 0,
        /// Software Interrupt on line 13
        SWIER13: u1 = 0,
        /// Software Interrupt on line 14
        SWIER14: u1 = 0,
        /// Software Interrupt on line 15
        SWIER15: u1 = 0,
        /// Software Interrupt on line 16
        SWIER16: u1 = 0,
        /// Software Interrupt on line 17
        SWIER17: u1 = 0,
        /// Software Interrupt on line 18
        SWIER18: u1 = 0,
        /// Software Interrupt on line 19
        SWIER19: u1 = 0,
        /// Software Interrupt on line 20
        SWIER20: u1 = 0,
        /// Software Interrupt on line 21
        SWIER21: u1 = 0,
        /// Software Interrupt on line 22
        SWIER22: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Software Interrupt on line 29
        SWIER29: u1 = 0,
        /// Software Interrupt on line 309
        SWIER30: u1 = 0,
        /// Software Interrupt on line 319
        SWIER31: u1 = 0,
    });

    /// Pending register
    pub const PR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Pending bit 0
        PR0: u1 = 0,
        /// Pending bit 1
        PR1: u1 = 0,
        /// Pending bit 2
        PR2: u1 = 0,
        /// Pending bit 3
        PR3: u1 = 0,
        /// Pending bit 4
        PR4: u1 = 0,
        /// Pending bit 5
        PR5: u1 = 0,
        /// Pending bit 6
        PR6: u1 = 0,
        /// Pending bit 7
        PR7: u1 = 0,
        /// Pending bit 8
        PR8: u1 = 0,
        /// Pending bit 9
        PR9: u1 = 0,
        /// Pending bit 10
        PR10: u1 = 0,
        /// Pending bit 11
        PR11: u1 = 0,
        /// Pending bit 12
        PR12: u1 = 0,
        /// Pending bit 13
        PR13: u1 = 0,
        /// Pending bit 14
        PR14: u1 = 0,
        /// Pending bit 15
        PR15: u1 = 0,
        /// Pending bit 16
        PR16: u1 = 0,
        /// Pending bit 17
        PR17: u1 = 0,
        /// Pending bit 18
        PR18: u1 = 0,
        /// Pending bit 19
        PR19: u1 = 0,
        /// Pending bit 20
        PR20: u1 = 0,
        /// Pending bit 21
        PR21: u1 = 0,
        /// Pending bit 22
        PR22: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Pending bit 29
        PR29: u1 = 0,
        /// Pending bit 30
        PR30: u1 = 0,
        /// Pending bit 31
        PR31: u1 = 0,
    });

    /// Interrupt mask register
    pub const IMR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Interrupt Mask on external/internal line 32
        MR32: u1 = 0,
        /// Interrupt Mask on external/internal line 33
        MR33: u1 = 0,
        /// Interrupt Mask on external/internal line 34
        MR34: u1 = 0,
        /// Interrupt Mask on external/internal line 35
        MR35: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Event mask register
    pub const EMR2 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Event mask on external/internal line 32
        MR32: u1 = 0,
        /// Event mask on external/internal line 33
        MR33: u1 = 0,
        /// Event mask on external/internal line 34
        MR34: u1 = 0,
        /// Event mask on external/internal line 35
        MR35: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Rising Trigger selection register
    pub const RTSR2 = mmio(Address + 0x00000020, 32, packed struct {
        /// Rising trigger event configuration bit of line 32
        TR32: u1 = 0,
        /// Rising trigger event configuration bit of line 33
        TR33: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Falling Trigger selection register
    pub const FTSR2 = mmio(Address + 0x00000024, 32, packed struct {
        /// Falling trigger event configuration bit of line 32
        TR32: u1 = 0,
        /// Falling trigger event configuration bit of line 33
        TR33: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Software interrupt event register
    pub const SWIER2 = mmio(Address + 0x00000028, 32, packed struct {
        /// Software interrupt on line 32
        SWIER32: u1 = 0,
        /// Software interrupt on line 33
        SWIER33: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Pending register
    pub const PR2 = mmio(Address + 0x0000002c, 32, packed struct {
        /// Pending bit on line 32
        PR32: u1 = 0,
        /// Pending bit on line 33
        PR33: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Power control
pub const PWR = extern struct {
    pub const Address: u32 = 0x40007000;

    /// power control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// Low-power deep sleep
        LPDS: u1 = 0,
        /// Power down deepsleep
        PDDS: u1 = 0,
        /// Clear wakeup flag
        CWUF: u1 = 0,
        /// Clear standby flag
        CSBF: u1 = 0,
        /// Power voltage detector enable
        PVDE: u1 = 0,
        /// PVD level selection
        PLS: u3 = 0,
        /// Disable backup domain write protection
        DBP: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// power control/status register
    pub const CSR = mmio(Address + 0x00000004, 32, packed struct {
        /// Wakeup flag
        WUF: u1 = 0,
        /// Standby flag
        SBF: u1 = 0,
        /// PVD output
        PVDO: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Enable WKUP1 pin
        EWUP1: u1 = 0,
        /// Enable WKUP2 pin
        EWUP2: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Controller area network
pub const CAN = extern struct {
    pub const Address: u32 = 0x40006400;

    /// master control register
    pub const MCR = mmio(Address + 0x00000000, 32, packed struct {
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// master status register
    pub const MSR = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// transmit status register
    pub const TSR = mmio(Address + 0x00000008, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Lowest priority flag for mailbox 0
        TME0: u1 = 0,
        /// Lowest priority flag for mailbox 1
        TME1: u1 = 0,
        /// Lowest priority flag for mailbox 2
        TME2: u1 = 0,
        /// Lowest priority flag for mailbox 0
        LOW0: u1 = 0,
        /// Lowest priority flag for mailbox 1
        LOW1: u1 = 0,
        /// Lowest priority flag for mailbox 2
        LOW2: u1 = 0,
    });

    /// receive FIFO 0 register
    pub const RF0R = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// receive FIFO 1 register
    pub const RF1R = mmio(Address + 0x00000010, 32, packed struct {
        reserved1: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000014, 32, packed struct {
        reserved1: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// error status register
    pub const ESR = mmio(Address + 0x00000018, 32, packed struct {
        reserved1: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
    });

    /// bit timing register
    pub const BTR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved7: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
    });

    /// TX mailbox identifier register
    pub const TI0R = mmio(Address + 0x00000180, 32, packed struct {});

    /// mailbox data length control and time stamp register
    pub const TDT0R = mmio(Address + 0x00000184, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
    });

    /// mailbox data low register
    pub const TDL0R = mmio(Address + 0x00000188, 32, packed struct {});

    /// mailbox data high register
    pub const TDH0R = mmio(Address + 0x0000018c, 32, packed struct {});

    /// TX mailbox identifier register
    pub const TI1R = mmio(Address + 0x00000190, 32, packed struct {});

    /// mailbox data length control and time stamp register
    pub const TDT1R = mmio(Address + 0x00000194, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
    });

    /// mailbox data low register
    pub const TDL1R = mmio(Address + 0x00000198, 32, packed struct {});

    /// mailbox data high register
    pub const TDH1R = mmio(Address + 0x0000019c, 32, packed struct {});

    /// TX mailbox identifier register
    pub const TI2R = mmio(Address + 0x000001a0, 32, packed struct {});

    /// mailbox data length control and time stamp register
    pub const TDT2R = mmio(Address + 0x000001a4, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
    });

    /// mailbox data low register
    pub const TDL2R = mmio(Address + 0x000001a8, 32, packed struct {});

    /// mailbox data high register
    pub const TDH2R = mmio(Address + 0x000001ac, 32, packed struct {});

    /// receive FIFO mailbox identifier register
    pub const RI0R = mmio(Address + 0x000001b0, 32, packed struct {
        reserved1: u1 = 0,
    });

    /// receive FIFO mailbox data length control and time stamp register
    pub const RDT0R = mmio(Address + 0x000001b4, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// receive FIFO mailbox data low register
    pub const RDL0R = mmio(Address + 0x000001b8, 32, packed struct {});

    /// receive FIFO mailbox data high register
    pub const RDH0R = mmio(Address + 0x000001bc, 32, packed struct {});

    /// receive FIFO mailbox identifier register
    pub const RI1R = mmio(Address + 0x000001c0, 32, packed struct {
        reserved1: u1 = 0,
    });

    /// receive FIFO mailbox data length control and time stamp register
    pub const RDT1R = mmio(Address + 0x000001c4, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// receive FIFO mailbox data low register
    pub const RDL1R = mmio(Address + 0x000001c8, 32, packed struct {});

    /// receive FIFO mailbox data high register
    pub const RDH1R = mmio(Address + 0x000001cc, 32, packed struct {});

    /// filter master register
    pub const FMR = mmio(Address + 0x00000200, 32, packed struct {
        /// Filter init mode
        FINIT: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// CAN2 start bank
        CAN2SB: u6 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// filter mode register
    pub const FM1R = mmio(Address + 0x00000204, 32, packed struct {
        /// Filter mode
        FBM0: u1 = 0,
        /// Filter mode
        FBM1: u1 = 0,
        /// Filter mode
        FBM2: u1 = 0,
        /// Filter mode
        FBM3: u1 = 0,
        /// Filter mode
        FBM4: u1 = 0,
        /// Filter mode
        FBM5: u1 = 0,
        /// Filter mode
        FBM6: u1 = 0,
        /// Filter mode
        FBM7: u1 = 0,
        /// Filter mode
        FBM8: u1 = 0,
        /// Filter mode
        FBM9: u1 = 0,
        /// Filter mode
        FBM10: u1 = 0,
        /// Filter mode
        FBM11: u1 = 0,
        /// Filter mode
        FBM12: u1 = 0,
        /// Filter mode
        FBM13: u1 = 0,
        /// Filter mode
        FBM14: u1 = 0,
        /// Filter mode
        FBM15: u1 = 0,
        /// Filter mode
        FBM16: u1 = 0,
        /// Filter mode
        FBM17: u1 = 0,
        /// Filter mode
        FBM18: u1 = 0,
        /// Filter mode
        FBM19: u1 = 0,
        /// Filter mode
        FBM20: u1 = 0,
        /// Filter mode
        FBM21: u1 = 0,
        /// Filter mode
        FBM22: u1 = 0,
        /// Filter mode
        FBM23: u1 = 0,
        /// Filter mode
        FBM24: u1 = 0,
        /// Filter mode
        FBM25: u1 = 0,
        /// Filter mode
        FBM26: u1 = 0,
        /// Filter mode
        FBM27: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// filter scale register
    pub const FS1R = mmio(Address + 0x0000020c, 32, packed struct {
        /// Filter scale configuration
        FSC0: u1 = 0,
        /// Filter scale configuration
        FSC1: u1 = 0,
        /// Filter scale configuration
        FSC2: u1 = 0,
        /// Filter scale configuration
        FSC3: u1 = 0,
        /// Filter scale configuration
        FSC4: u1 = 0,
        /// Filter scale configuration
        FSC5: u1 = 0,
        /// Filter scale configuration
        FSC6: u1 = 0,
        /// Filter scale configuration
        FSC7: u1 = 0,
        /// Filter scale configuration
        FSC8: u1 = 0,
        /// Filter scale configuration
        FSC9: u1 = 0,
        /// Filter scale configuration
        FSC10: u1 = 0,
        /// Filter scale configuration
        FSC11: u1 = 0,
        /// Filter scale configuration
        FSC12: u1 = 0,
        /// Filter scale configuration
        FSC13: u1 = 0,
        /// Filter scale configuration
        FSC14: u1 = 0,
        /// Filter scale configuration
        FSC15: u1 = 0,
        /// Filter scale configuration
        FSC16: u1 = 0,
        /// Filter scale configuration
        FSC17: u1 = 0,
        /// Filter scale configuration
        FSC18: u1 = 0,
        /// Filter scale configuration
        FSC19: u1 = 0,
        /// Filter scale configuration
        FSC20: u1 = 0,
        /// Filter scale configuration
        FSC21: u1 = 0,
        /// Filter scale configuration
        FSC22: u1 = 0,
        /// Filter scale configuration
        FSC23: u1 = 0,
        /// Filter scale configuration
        FSC24: u1 = 0,
        /// Filter scale configuration
        FSC25: u1 = 0,
        /// Filter scale configuration
        FSC26: u1 = 0,
        /// Filter scale configuration
        FSC27: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// filter FIFO assignment register
    pub const FFA1R = mmio(Address + 0x00000214, 32, packed struct {
        /// Filter FIFO assignment for filter 0
        FFA0: u1 = 0,
        /// Filter FIFO assignment for filter 1
        FFA1: u1 = 0,
        /// Filter FIFO assignment for filter 2
        FFA2: u1 = 0,
        /// Filter FIFO assignment for filter 3
        FFA3: u1 = 0,
        /// Filter FIFO assignment for filter 4
        FFA4: u1 = 0,
        /// Filter FIFO assignment for filter 5
        FFA5: u1 = 0,
        /// Filter FIFO assignment for filter 6
        FFA6: u1 = 0,
        /// Filter FIFO assignment for filter 7
        FFA7: u1 = 0,
        /// Filter FIFO assignment for filter 8
        FFA8: u1 = 0,
        /// Filter FIFO assignment for filter 9
        FFA9: u1 = 0,
        /// Filter FIFO assignment for filter 10
        FFA10: u1 = 0,
        /// Filter FIFO assignment for filter 11
        FFA11: u1 = 0,
        /// Filter FIFO assignment for filter 12
        FFA12: u1 = 0,
        /// Filter FIFO assignment for filter 13
        FFA13: u1 = 0,
        /// Filter FIFO assignment for filter 14
        FFA14: u1 = 0,
        /// Filter FIFO assignment for filter 15
        FFA15: u1 = 0,
        /// Filter FIFO assignment for filter 16
        FFA16: u1 = 0,
        /// Filter FIFO assignment for filter 17
        FFA17: u1 = 0,
        /// Filter FIFO assignment for filter 18
        FFA18: u1 = 0,
        /// Filter FIFO assignment for filter 19
        FFA19: u1 = 0,
        /// Filter FIFO assignment for filter 20
        FFA20: u1 = 0,
        /// Filter FIFO assignment for filter 21
        FFA21: u1 = 0,
        /// Filter FIFO assignment for filter 22
        FFA22: u1 = 0,
        /// Filter FIFO assignment for filter 23
        FFA23: u1 = 0,
        /// Filter FIFO assignment for filter 24
        FFA24: u1 = 0,
        /// Filter FIFO assignment for filter 25
        FFA25: u1 = 0,
        /// Filter FIFO assignment for filter 26
        FFA26: u1 = 0,
        /// Filter FIFO assignment for filter 27
        FFA27: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CAN filter activation register
    pub const FA1R = mmio(Address + 0x0000021c, 32, packed struct {
        /// Filter active
        FACT0: u1 = 0,
        /// Filter active
        FACT1: u1 = 0,
        /// Filter active
        FACT2: u1 = 0,
        /// Filter active
        FACT3: u1 = 0,
        /// Filter active
        FACT4: u1 = 0,
        /// Filter active
        FACT5: u1 = 0,
        /// Filter active
        FACT6: u1 = 0,
        /// Filter active
        FACT7: u1 = 0,
        /// Filter active
        FACT8: u1 = 0,
        /// Filter active
        FACT9: u1 = 0,
        /// Filter active
        FACT10: u1 = 0,
        /// Filter active
        FACT11: u1 = 0,
        /// Filter active
        FACT12: u1 = 0,
        /// Filter active
        FACT13: u1 = 0,
        /// Filter active
        FACT14: u1 = 0,
        /// Filter active
        FACT15: u1 = 0,
        /// Filter active
        FACT16: u1 = 0,
        /// Filter active
        FACT17: u1 = 0,
        /// Filter active
        FACT18: u1 = 0,
        /// Filter active
        FACT19: u1 = 0,
        /// Filter active
        FACT20: u1 = 0,
        /// Filter active
        FACT21: u1 = 0,
        /// Filter active
        FACT22: u1 = 0,
        /// Filter active
        FACT23: u1 = 0,
        /// Filter active
        FACT24: u1 = 0,
        /// Filter active
        FACT25: u1 = 0,
        /// Filter active
        FACT26: u1 = 0,
        /// Filter active
        FACT27: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Filter bank 0 register 1
    pub const F0R1 = mmio(Address + 0x00000240, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 0 register 2
    pub const F0R2 = mmio(Address + 0x00000244, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 1 register 1
    pub const F1R1 = mmio(Address + 0x00000248, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 1 register 2
    pub const F1R2 = mmio(Address + 0x0000024c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 2 register 1
    pub const F2R1 = mmio(Address + 0x00000250, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 2 register 2
    pub const F2R2 = mmio(Address + 0x00000254, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 3 register 1
    pub const F3R1 = mmio(Address + 0x00000258, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 3 register 2
    pub const F3R2 = mmio(Address + 0x0000025c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 4 register 1
    pub const F4R1 = mmio(Address + 0x00000260, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 4 register 2
    pub const F4R2 = mmio(Address + 0x00000264, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 5 register 1
    pub const F5R1 = mmio(Address + 0x00000268, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 5 register 2
    pub const F5R2 = mmio(Address + 0x0000026c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 6 register 1
    pub const F6R1 = mmio(Address + 0x00000270, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 6 register 2
    pub const F6R2 = mmio(Address + 0x00000274, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 7 register 1
    pub const F7R1 = mmio(Address + 0x00000278, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 7 register 2
    pub const F7R2 = mmio(Address + 0x0000027c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 8 register 1
    pub const F8R1 = mmio(Address + 0x00000280, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 8 register 2
    pub const F8R2 = mmio(Address + 0x00000284, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 9 register 1
    pub const F9R1 = mmio(Address + 0x00000288, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 9 register 2
    pub const F9R2 = mmio(Address + 0x0000028c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 10 register 1
    pub const F10R1 = mmio(Address + 0x00000290, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 10 register 2
    pub const F10R2 = mmio(Address + 0x00000294, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 11 register 1
    pub const F11R1 = mmio(Address + 0x00000298, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 11 register 2
    pub const F11R2 = mmio(Address + 0x0000029c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 4 register 1
    pub const F12R1 = mmio(Address + 0x000002a0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 12 register 2
    pub const F12R2 = mmio(Address + 0x000002a4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 13 register 1
    pub const F13R1 = mmio(Address + 0x000002a8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 13 register 2
    pub const F13R2 = mmio(Address + 0x000002ac, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 14 register 1
    pub const F14R1 = mmio(Address + 0x000002b0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 14 register 2
    pub const F14R2 = mmio(Address + 0x000002b4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 15 register 1
    pub const F15R1 = mmio(Address + 0x000002b8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 15 register 2
    pub const F15R2 = mmio(Address + 0x000002bc, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 16 register 1
    pub const F16R1 = mmio(Address + 0x000002c0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 16 register 2
    pub const F16R2 = mmio(Address + 0x000002c4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 17 register 1
    pub const F17R1 = mmio(Address + 0x000002c8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 17 register 2
    pub const F17R2 = mmio(Address + 0x000002cc, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 18 register 1
    pub const F18R1 = mmio(Address + 0x000002d0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 18 register 2
    pub const F18R2 = mmio(Address + 0x000002d4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 19 register 1
    pub const F19R1 = mmio(Address + 0x000002d8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 19 register 2
    pub const F19R2 = mmio(Address + 0x000002dc, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 20 register 1
    pub const F20R1 = mmio(Address + 0x000002e0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 20 register 2
    pub const F20R2 = mmio(Address + 0x000002e4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 21 register 1
    pub const F21R1 = mmio(Address + 0x000002e8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 21 register 2
    pub const F21R2 = mmio(Address + 0x000002ec, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 22 register 1
    pub const F22R1 = mmio(Address + 0x000002f0, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 22 register 2
    pub const F22R2 = mmio(Address + 0x000002f4, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 23 register 1
    pub const F23R1 = mmio(Address + 0x000002f8, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 23 register 2
    pub const F23R2 = mmio(Address + 0x000002fc, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 24 register 1
    pub const F24R1 = mmio(Address + 0x00000300, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 24 register 2
    pub const F24R2 = mmio(Address + 0x00000304, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 25 register 1
    pub const F25R1 = mmio(Address + 0x00000308, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 25 register 2
    pub const F25R2 = mmio(Address + 0x0000030c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 26 register 1
    pub const F26R1 = mmio(Address + 0x00000310, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 26 register 2
    pub const F26R2 = mmio(Address + 0x00000314, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 27 register 1
    pub const F27R1 = mmio(Address + 0x00000318, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });

    /// Filter bank 27 register 2
    pub const F27R2 = mmio(Address + 0x0000031c, 32, packed struct {
        /// Filter bits
        FB0: u1 = 0,
        /// Filter bits
        FB1: u1 = 0,
        /// Filter bits
        FB2: u1 = 0,
        /// Filter bits
        FB3: u1 = 0,
        /// Filter bits
        FB4: u1 = 0,
        /// Filter bits
        FB5: u1 = 0,
        /// Filter bits
        FB6: u1 = 0,
        /// Filter bits
        FB7: u1 = 0,
        /// Filter bits
        FB8: u1 = 0,
        /// Filter bits
        FB9: u1 = 0,
        /// Filter bits
        FB10: u1 = 0,
        /// Filter bits
        FB11: u1 = 0,
        /// Filter bits
        FB12: u1 = 0,
        /// Filter bits
        FB13: u1 = 0,
        /// Filter bits
        FB14: u1 = 0,
        /// Filter bits
        FB15: u1 = 0,
        /// Filter bits
        FB16: u1 = 0,
        /// Filter bits
        FB17: u1 = 0,
        /// Filter bits
        FB18: u1 = 0,
        /// Filter bits
        FB19: u1 = 0,
        /// Filter bits
        FB20: u1 = 0,
        /// Filter bits
        FB21: u1 = 0,
        /// Filter bits
        FB22: u1 = 0,
        /// Filter bits
        FB23: u1 = 0,
        /// Filter bits
        FB24: u1 = 0,
        /// Filter bits
        FB25: u1 = 0,
        /// Filter bits
        FB26: u1 = 0,
        /// Filter bits
        FB27: u1 = 0,
        /// Filter bits
        FB28: u1 = 0,
        /// Filter bits
        FB29: u1 = 0,
        /// Filter bits
        FB30: u1 = 0,
        /// Filter bits
        FB31: u1 = 0,
    });
};

/// Universal serial bus full-speed device interface
pub const USB_FS = extern struct {
    pub const Address: u32 = 0x40005c00;

    /// endpoint 0 register
    pub const USB_EP0R = mmio(Address + 0x00000000, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 1 register
    pub const USB_EP1R = mmio(Address + 0x00000004, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 2 register
    pub const USB_EP2R = mmio(Address + 0x00000008, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 3 register
    pub const USB_EP3R = mmio(Address + 0x0000000c, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 4 register
    pub const USB_EP4R = mmio(Address + 0x00000010, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 5 register
    pub const USB_EP5R = mmio(Address + 0x00000014, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 6 register
    pub const USB_EP6R = mmio(Address + 0x00000018, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// endpoint 7 register
    pub const USB_EP7R = mmio(Address + 0x0000001c, 32, packed struct {
        /// Endpoint address
        EA: u4 = 0,
        /// Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// Endpoint kind
        EP_KIND: u1 = 0,
        /// Endpoint type
        EP_TYPE: u2 = 0,
        /// Setup transaction completed
        SETUP: u1 = 0,
        /// Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// Correct transfer for reception
        CTR_RX: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const USB_CNTR = mmio(Address + 0x00000040, 32, packed struct {
        /// Force USB Reset
        FRES: u1 = 0,
        /// Power down
        PDWN: u1 = 0,
        /// Low-power mode
        LPMODE: u1 = 0,
        /// Force suspend
        FSUSP: u1 = 0,
        /// Resume request
        RESUME: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Expected start of frame interrupt mask
        ESOFM: u1 = 0,
        /// Start of frame interrupt mask
        SOFM: u1 = 0,
        /// USB reset interrupt mask
        RESETM: u1 = 0,
        /// Suspend mode interrupt mask
        SUSPM: u1 = 0,
        /// Wakeup interrupt mask
        WKUPM: u1 = 0,
        /// Error interrupt mask
        ERRM: u1 = 0,
        /// Packet memory area over / underrun interrupt mask
        PMAOVRM: u1 = 0,
        /// Correct transfer interrupt mask
        CTRM: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt status register
    pub const ISTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Endpoint Identifier
        EP_ID: u4 = 0,
        /// Direction of transaction
        DIR: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Expected start frame
        ESOF: u1 = 0,
        /// start of frame
        SOF: u1 = 0,
        /// reset request
        RESET: u1 = 0,
        /// Suspend mode request
        SUSP: u1 = 0,
        /// Wakeup
        WKUP: u1 = 0,
        /// Error
        ERR: u1 = 0,
        /// Packet memory area over / underrun
        PMAOVR: u1 = 0,
        /// Correct transfer
        CTR: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// frame number register
    pub const FNR = mmio(Address + 0x00000048, 32, packed struct {
        /// Frame number
        FN: u11 = 0,
        /// Lost SOF
        LSOF: u2 = 0,
        /// Locked
        LCK: u1 = 0,
        /// Receive data - line status
        RXDM: u1 = 0,
        /// Receive data + line status
        RXDP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// device address
    pub const DADDR = mmio(Address + 0x0000004c, 32, packed struct {
        /// Device address
        ADD: u1 = 0,
        /// Device address
        ADD1: u1 = 0,
        /// Device address
        ADD2: u1 = 0,
        /// Device address
        ADD3: u1 = 0,
        /// Device address
        ADD4: u1 = 0,
        /// Device address
        ADD5: u1 = 0,
        /// Device address
        ADD6: u1 = 0,
        /// Enable function
        EF: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Buffer table address
    pub const BTABLE = mmio(Address + 0x00000050, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Buffer table
        BTABLE: u13 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Inter-integrated circuit
pub const I2C1 = extern struct {
    pub const Address: u32 = 0x40005400;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Peripheral enable
        PE: u1 = 0,
        /// TX Interrupt enable
        TXIE: u1 = 0,
        /// RX Interrupt enable
        RXIE: u1 = 0,
        /// Address match interrupt enable (slave only)
        ADDRIE: u1 = 0,
        /// Not acknowledge received interrupt enable
        NACKIE: u1 = 0,
        /// STOP detection Interrupt enable
        STOPIE: u1 = 0,
        /// Transfer Complete interrupt enable
        TCIE: u1 = 0,
        /// Error interrupts enable
        ERRIE: u1 = 0,
        /// Digital noise filter
        DNF: u4 = 0,
        /// Analog noise filter OFF
        ANFOFF: u1 = 0,
        /// Software reset
        SWRST: u1 = 0,
        /// DMA transmission requests enable
        TXDMAEN: u1 = 0,
        /// DMA reception requests enable
        RXDMAEN: u1 = 0,
        /// Slave byte control
        SBC: u1 = 0,
        /// Clock stretching disable
        NOSTRETCH: u1 = 0,
        /// Wakeup from STOP enable
        WUPEN: u1 = 0,
        /// General call enable
        GCEN: u1 = 0,
        /// SMBus Host address enable
        SMBHEN: u1 = 0,
        /// SMBus Device Default address enable
        SMBDEN: u1 = 0,
        /// SMBUS alert enable
        ALERTEN: u1 = 0,
        /// PEC enable
        PECEN: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Slave address bit 0 (master mode)
        SADD0: u1 = 0,
        /// Slave address bit 7:1 (master mode)
        SADD1: u7 = 0,
        /// Slave address bit 9:8 (master mode)
        SADD8: u2 = 0,
        /// Transfer direction (master mode)
        RD_WRN: u1 = 0,
        /// 10-bit addressing mode (master mode)
        ADD10: u1 = 0,
        /// 10-bit address header only read direction (master receiver mode)
        HEAD10R: u1 = 0,
        /// Start generation
        START: u1 = 0,
        /// Stop generation (master mode)
        STOP: u1 = 0,
        /// NACK generation (slave mode)
        NACK: u1 = 0,
        /// Number of bytes
        NBYTES: u8 = 0,
        /// NBYTES reload mode
        RELOAD: u1 = 0,
        /// Automatic end mode (master mode)
        AUTOEND: u1 = 0,
        /// Packet error checking byte
        PECBYTE: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Interface address
        OA1_0: u1 = 0,
        /// Interface address
        OA1_1: u7 = 0,
        /// Interface address
        OA1_8: u2 = 0,
        /// Own Address 1 10-bit mode
        OA1MODE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Own Address 1 enable
        OA1EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        /// Interface address
        OA2: u7 = 0,
        /// Own Address 2 masks
        OA2MSK: u3 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Own Address 2 enable
        OA2EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        /// SCL low period (master mode)
        SCLL: u8 = 0,
        /// SCL high period (master mode)
        SCLH: u8 = 0,
        /// Data hold time
        SDADEL: u4 = 0,
        /// Data setup time
        SCLDEL: u4 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Timing prescaler
        PRESC: u4 = 0,
    });

    /// Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        /// Bus timeout A
        TIMEOUTA: u12 = 0,
        /// Idle clock timeout detection
        TIDLE: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Clock timeout enable
        TIMOUTEN: u1 = 0,
        /// Bus timeout B
        TIMEOUTB: u12 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Extended clock timeout enable
        TEXTEN: u1 = 0,
    });

    /// Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        /// Transmit data register empty (transmitters)
        TXE: u1 = 0,
        /// Transmit interrupt status (transmitters)
        TXIS: u1 = 0,
        /// Receive data register not empty (receivers)
        RXNE: u1 = 0,
        /// Address matched (slave mode)
        ADDR: u1 = 0,
        /// Not acknowledge received flag
        NACKF: u1 = 0,
        /// Stop detection flag
        STOPF: u1 = 0,
        /// Transfer Complete (master mode)
        TC: u1 = 0,
        /// Transfer Complete Reload
        TCR: u1 = 0,
        /// Bus error
        BERR: u1 = 0,
        /// Arbitration lost
        ARLO: u1 = 0,
        /// Overrun/Underrun (slave mode)
        OVR: u1 = 0,
        /// PEC Error in reception
        PECERR: u1 = 0,
        /// Timeout or t_low detection flag
        TIMEOUT: u1 = 0,
        /// SMBus alert
        ALERT: u1 = 0,
        reserved1: u1 = 0,
        /// Bus busy
        BUSY: u1 = 0,
        /// Transfer direction (Slave mode)
        DIR: u1 = 0,
        /// Address match code (Slave mode)
        ADDCODE: u7 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Address Matched flag clear
        ADDRCF: u1 = 0,
        /// Not Acknowledge flag clear
        NACKCF: u1 = 0,
        /// Stop detection flag clear
        STOPCF: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Bus error flag clear
        BERRCF: u1 = 0,
        /// Arbitration lost flag clear
        ARLOCF: u1 = 0,
        /// Overrun/Underrun flag clear
        OVRCF: u1 = 0,
        /// PEC Error flag clear
        PECCF: u1 = 0,
        /// Timeout detection flag clear
        TIMOUTCF: u1 = 0,
        /// Alert flag clear
        ALERTCF: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        /// Packet error checking register
        PEC: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        /// 8-bit receive data
        RXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        /// 8-bit transmit data
        TXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Inter-integrated circuit
pub const I2C2 = extern struct {
    pub const Address: u32 = 0x40005800;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Peripheral enable
        PE: u1 = 0,
        /// TX Interrupt enable
        TXIE: u1 = 0,
        /// RX Interrupt enable
        RXIE: u1 = 0,
        /// Address match interrupt enable (slave only)
        ADDRIE: u1 = 0,
        /// Not acknowledge received interrupt enable
        NACKIE: u1 = 0,
        /// STOP detection Interrupt enable
        STOPIE: u1 = 0,
        /// Transfer Complete interrupt enable
        TCIE: u1 = 0,
        /// Error interrupts enable
        ERRIE: u1 = 0,
        /// Digital noise filter
        DNF: u4 = 0,
        /// Analog noise filter OFF
        ANFOFF: u1 = 0,
        /// Software reset
        SWRST: u1 = 0,
        /// DMA transmission requests enable
        TXDMAEN: u1 = 0,
        /// DMA reception requests enable
        RXDMAEN: u1 = 0,
        /// Slave byte control
        SBC: u1 = 0,
        /// Clock stretching disable
        NOSTRETCH: u1 = 0,
        /// Wakeup from STOP enable
        WUPEN: u1 = 0,
        /// General call enable
        GCEN: u1 = 0,
        /// SMBus Host address enable
        SMBHEN: u1 = 0,
        /// SMBus Device Default address enable
        SMBDEN: u1 = 0,
        /// SMBUS alert enable
        ALERTEN: u1 = 0,
        /// PEC enable
        PECEN: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Slave address bit 0 (master mode)
        SADD0: u1 = 0,
        /// Slave address bit 7:1 (master mode)
        SADD1: u7 = 0,
        /// Slave address bit 9:8 (master mode)
        SADD8: u2 = 0,
        /// Transfer direction (master mode)
        RD_WRN: u1 = 0,
        /// 10-bit addressing mode (master mode)
        ADD10: u1 = 0,
        /// 10-bit address header only read direction (master receiver mode)
        HEAD10R: u1 = 0,
        /// Start generation
        START: u1 = 0,
        /// Stop generation (master mode)
        STOP: u1 = 0,
        /// NACK generation (slave mode)
        NACK: u1 = 0,
        /// Number of bytes
        NBYTES: u8 = 0,
        /// NBYTES reload mode
        RELOAD: u1 = 0,
        /// Automatic end mode (master mode)
        AUTOEND: u1 = 0,
        /// Packet error checking byte
        PECBYTE: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Interface address
        OA1_0: u1 = 0,
        /// Interface address
        OA1_1: u7 = 0,
        /// Interface address
        OA1_8: u2 = 0,
        /// Own Address 1 10-bit mode
        OA1MODE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Own Address 1 enable
        OA1EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        /// Interface address
        OA2: u7 = 0,
        /// Own Address 2 masks
        OA2MSK: u3 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Own Address 2 enable
        OA2EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        /// SCL low period (master mode)
        SCLL: u8 = 0,
        /// SCL high period (master mode)
        SCLH: u8 = 0,
        /// Data hold time
        SDADEL: u4 = 0,
        /// Data setup time
        SCLDEL: u4 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Timing prescaler
        PRESC: u4 = 0,
    });

    /// Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        /// Bus timeout A
        TIMEOUTA: u12 = 0,
        /// Idle clock timeout detection
        TIDLE: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Clock timeout enable
        TIMOUTEN: u1 = 0,
        /// Bus timeout B
        TIMEOUTB: u12 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Extended clock timeout enable
        TEXTEN: u1 = 0,
    });

    /// Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        /// Transmit data register empty (transmitters)
        TXE: u1 = 0,
        /// Transmit interrupt status (transmitters)
        TXIS: u1 = 0,
        /// Receive data register not empty (receivers)
        RXNE: u1 = 0,
        /// Address matched (slave mode)
        ADDR: u1 = 0,
        /// Not acknowledge received flag
        NACKF: u1 = 0,
        /// Stop detection flag
        STOPF: u1 = 0,
        /// Transfer Complete (master mode)
        TC: u1 = 0,
        /// Transfer Complete Reload
        TCR: u1 = 0,
        /// Bus error
        BERR: u1 = 0,
        /// Arbitration lost
        ARLO: u1 = 0,
        /// Overrun/Underrun (slave mode)
        OVR: u1 = 0,
        /// PEC Error in reception
        PECERR: u1 = 0,
        /// Timeout or t_low detection flag
        TIMEOUT: u1 = 0,
        /// SMBus alert
        ALERT: u1 = 0,
        reserved1: u1 = 0,
        /// Bus busy
        BUSY: u1 = 0,
        /// Transfer direction (Slave mode)
        DIR: u1 = 0,
        /// Address match code (Slave mode)
        ADDCODE: u7 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Address Matched flag clear
        ADDRCF: u1 = 0,
        /// Not Acknowledge flag clear
        NACKCF: u1 = 0,
        /// Stop detection flag clear
        STOPCF: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Bus error flag clear
        BERRCF: u1 = 0,
        /// Arbitration lost flag clear
        ARLOCF: u1 = 0,
        /// Overrun/Underrun flag clear
        OVRCF: u1 = 0,
        /// PEC Error flag clear
        PECCF: u1 = 0,
        /// Timeout detection flag clear
        TIMOUTCF: u1 = 0,
        /// Alert flag clear
        ALERTCF: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        /// Packet error checking register
        PEC: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        /// 8-bit receive data
        RXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        /// 8-bit transmit data
        TXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Inter-integrated circuit
pub const I2C3 = extern struct {
    pub const Address: u32 = 0x40007800;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Peripheral enable
        PE: u1 = 0,
        /// TX Interrupt enable
        TXIE: u1 = 0,
        /// RX Interrupt enable
        RXIE: u1 = 0,
        /// Address match interrupt enable (slave only)
        ADDRIE: u1 = 0,
        /// Not acknowledge received interrupt enable
        NACKIE: u1 = 0,
        /// STOP detection Interrupt enable
        STOPIE: u1 = 0,
        /// Transfer Complete interrupt enable
        TCIE: u1 = 0,
        /// Error interrupts enable
        ERRIE: u1 = 0,
        /// Digital noise filter
        DNF: u4 = 0,
        /// Analog noise filter OFF
        ANFOFF: u1 = 0,
        /// Software reset
        SWRST: u1 = 0,
        /// DMA transmission requests enable
        TXDMAEN: u1 = 0,
        /// DMA reception requests enable
        RXDMAEN: u1 = 0,
        /// Slave byte control
        SBC: u1 = 0,
        /// Clock stretching disable
        NOSTRETCH: u1 = 0,
        /// Wakeup from STOP enable
        WUPEN: u1 = 0,
        /// General call enable
        GCEN: u1 = 0,
        /// SMBus Host address enable
        SMBHEN: u1 = 0,
        /// SMBus Device Default address enable
        SMBDEN: u1 = 0,
        /// SMBUS alert enable
        ALERTEN: u1 = 0,
        /// PEC enable
        PECEN: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Slave address bit 0 (master mode)
        SADD0: u1 = 0,
        /// Slave address bit 7:1 (master mode)
        SADD1: u7 = 0,
        /// Slave address bit 9:8 (master mode)
        SADD8: u2 = 0,
        /// Transfer direction (master mode)
        RD_WRN: u1 = 0,
        /// 10-bit addressing mode (master mode)
        ADD10: u1 = 0,
        /// 10-bit address header only read direction (master receiver mode)
        HEAD10R: u1 = 0,
        /// Start generation
        START: u1 = 0,
        /// Stop generation (master mode)
        STOP: u1 = 0,
        /// NACK generation (slave mode)
        NACK: u1 = 0,
        /// Number of bytes
        NBYTES: u8 = 0,
        /// NBYTES reload mode
        RELOAD: u1 = 0,
        /// Automatic end mode (master mode)
        AUTOEND: u1 = 0,
        /// Packet error checking byte
        PECBYTE: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Interface address
        OA1_0: u1 = 0,
        /// Interface address
        OA1_1: u7 = 0,
        /// Interface address
        OA1_8: u2 = 0,
        /// Own Address 1 10-bit mode
        OA1MODE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Own Address 1 enable
        OA1EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        /// Interface address
        OA2: u7 = 0,
        /// Own Address 2 masks
        OA2MSK: u3 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Own Address 2 enable
        OA2EN: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        /// SCL low period (master mode)
        SCLL: u8 = 0,
        /// SCL high period (master mode)
        SCLH: u8 = 0,
        /// Data hold time
        SDADEL: u4 = 0,
        /// Data setup time
        SCLDEL: u4 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Timing prescaler
        PRESC: u4 = 0,
    });

    /// Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        /// Bus timeout A
        TIMEOUTA: u12 = 0,
        /// Idle clock timeout detection
        TIDLE: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Clock timeout enable
        TIMOUTEN: u1 = 0,
        /// Bus timeout B
        TIMEOUTB: u12 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Extended clock timeout enable
        TEXTEN: u1 = 0,
    });

    /// Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        /// Transmit data register empty (transmitters)
        TXE: u1 = 0,
        /// Transmit interrupt status (transmitters)
        TXIS: u1 = 0,
        /// Receive data register not empty (receivers)
        RXNE: u1 = 0,
        /// Address matched (slave mode)
        ADDR: u1 = 0,
        /// Not acknowledge received flag
        NACKF: u1 = 0,
        /// Stop detection flag
        STOPF: u1 = 0,
        /// Transfer Complete (master mode)
        TC: u1 = 0,
        /// Transfer Complete Reload
        TCR: u1 = 0,
        /// Bus error
        BERR: u1 = 0,
        /// Arbitration lost
        ARLO: u1 = 0,
        /// Overrun/Underrun (slave mode)
        OVR: u1 = 0,
        /// PEC Error in reception
        PECERR: u1 = 0,
        /// Timeout or t_low detection flag
        TIMEOUT: u1 = 0,
        /// SMBus alert
        ALERT: u1 = 0,
        reserved1: u1 = 0,
        /// Bus busy
        BUSY: u1 = 0,
        /// Transfer direction (Slave mode)
        DIR: u1 = 0,
        /// Address match code (Slave mode)
        ADDCODE: u7 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Address Matched flag clear
        ADDRCF: u1 = 0,
        /// Not Acknowledge flag clear
        NACKCF: u1 = 0,
        /// Stop detection flag clear
        STOPCF: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Bus error flag clear
        BERRCF: u1 = 0,
        /// Arbitration lost flag clear
        ARLOCF: u1 = 0,
        /// Overrun/Underrun flag clear
        OVRCF: u1 = 0,
        /// PEC Error flag clear
        PECCF: u1 = 0,
        /// Timeout detection flag clear
        TIMOUTCF: u1 = 0,
        /// Alert flag clear
        ALERTCF: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        /// Packet error checking register
        PEC: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        /// 8-bit receive data
        RXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        /// 8-bit transmit data
        TXDATA: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Independent watchdog
pub const IWDG = extern struct {
    pub const Address: u32 = 0x40003000;

    /// Key register
    pub const KR = mmio(Address + 0x00000000, 32, packed struct {
        /// Key value
        KEY: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Prescaler register
    pub const PR = mmio(Address + 0x00000004, 32, packed struct {
        /// Prescaler divider
        PR: u3 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Reload register
    pub const RLR = mmio(Address + 0x00000008, 32, packed struct {
        /// Watchdog counter reload value
        RL: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Watchdog prescaler value update
        PVU: u1 = 0,
        /// Watchdog counter reload value update
        RVU: u1 = 0,
        /// Watchdog counter window value update
        WVU: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Window register
    pub const WINR = mmio(Address + 0x00000010, 32, packed struct {
        /// Watchdog counter window value
        WIN: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Window watchdog
pub const WWDG = extern struct {
    pub const Address: u32 = 0x40002c00;

    /// Control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// 7-bit counter
        T: u7 = 0,
        /// Activation bit
        WDGA: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Configuration register
    pub const CFR = mmio(Address + 0x00000004, 32, packed struct {
        /// 7-bit window value
        W: u7 = 0,
        /// Timer base
        WDGTB: u2 = 0,
        /// Early wakeup interrupt
        EWI: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Early wakeup interrupt flag
        EWIF: u1 = 0,
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Real-time clock
pub const RTC = extern struct {
    pub const Address: u32 = 0x40002800;

    /// time register
    pub const TR = mmio(Address + 0x00000000, 32, packed struct {
        /// Second units in BCD format
        SU: u4 = 0,
        /// Second tens in BCD format
        ST: u3 = 0,
        reserved1: u1 = 0,
        /// Minute units in BCD format
        MNU: u4 = 0,
        /// Minute tens in BCD format
        MNT: u3 = 0,
        reserved2: u1 = 0,
        /// Hour units in BCD format
        HU: u4 = 0,
        /// Hour tens in BCD format
        HT: u2 = 0,
        /// AM/PM notation
        PM: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// date register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        /// Date units in BCD format
        DU: u4 = 0,
        /// Date tens in BCD format
        DT: u2 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Month units in BCD format
        MU: u4 = 0,
        /// Month tens in BCD format
        MT: u1 = 0,
        /// Week day units
        WDU: u3 = 0,
        /// Year units in BCD format
        YU: u4 = 0,
        /// Year tens in BCD format
        YT: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        /// Wakeup clock selection
        WCKSEL: u3 = 0,
        /// Time-stamp event active edge
        TSEDGE: u1 = 0,
        /// Reference clock detection enable (50 or 60 Hz)
        REFCKON: u1 = 0,
        /// Bypass the shadow registers
        BYPSHAD: u1 = 0,
        /// Hour format
        FMT: u1 = 0,
        reserved1: u1 = 0,
        /// Alarm A enable
        ALRAE: u1 = 0,
        /// Alarm B enable
        ALRBE: u1 = 0,
        /// Wakeup timer enable
        WUTE: u1 = 0,
        /// Time stamp enable
        TSE: u1 = 0,
        /// Alarm A interrupt enable
        ALRAIE: u1 = 0,
        /// Alarm B interrupt enable
        ALRBIE: u1 = 0,
        /// Wakeup timer interrupt enable
        WUTIE: u1 = 0,
        /// Time-stamp interrupt enable
        TSIE: u1 = 0,
        /// Add 1 hour (summer time change)
        ADD1H: u1 = 0,
        /// Subtract 1 hour (winter time change)
        SUB1H: u1 = 0,
        /// Backup
        BKP: u1 = 0,
        /// Calibration output selection
        COSEL: u1 = 0,
        /// Output polarity
        POL: u1 = 0,
        /// Output selection
        OSEL: u2 = 0,
        /// Calibration output enable
        COE: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// initialization and status register
    pub const ISR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Alarm A write flag
        ALRAWF: u1 = 0,
        /// Alarm B write flag
        ALRBWF: u1 = 0,
        /// Wakeup timer write flag
        WUTWF: u1 = 0,
        /// Shift operation pending
        SHPF: u1 = 0,
        /// Initialization status flag
        INITS: u1 = 0,
        /// Registers synchronization flag
        RSF: u1 = 0,
        /// Initialization flag
        INITF: u1 = 0,
        /// Initialization mode
        INIT: u1 = 0,
        /// Alarm A flag
        ALRAF: u1 = 0,
        /// Alarm B flag
        ALRBF: u1 = 0,
        /// Wakeup timer flag
        WUTF: u1 = 0,
        /// Time-stamp flag
        TSF: u1 = 0,
        /// Time-stamp overflow flag
        TSOVF: u1 = 0,
        /// Tamper detection flag
        TAMP1F: u1 = 0,
        /// RTC_TAMP2 detection flag
        TAMP2F: u1 = 0,
        /// RTC_TAMP3 detection flag
        TAMP3F: u1 = 0,
        /// Recalibration pending Flag
        RECALPF: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// prescaler register
    pub const PRER = mmio(Address + 0x00000010, 32, packed struct {
        /// Synchronous prescaler factor
        PREDIV_S: u15 = 0,
        reserved1: u1 = 0,
        /// Asynchronous prescaler factor
        PREDIV_A: u7 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// wakeup timer register
    pub const WUTR = mmio(Address + 0x00000014, 32, packed struct {
        /// Wakeup auto-reload value bits
        WUT: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// alarm A register
    pub const ALRMAR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Second units in BCD format
        SU: u4 = 0,
        /// Second tens in BCD format
        ST: u3 = 0,
        /// Alarm A seconds mask
        MSK1: u1 = 0,
        /// Minute units in BCD format
        MNU: u4 = 0,
        /// Minute tens in BCD format
        MNT: u3 = 0,
        /// Alarm A minutes mask
        MSK2: u1 = 0,
        /// Hour units in BCD format
        HU: u4 = 0,
        /// Hour tens in BCD format
        HT: u2 = 0,
        /// AM/PM notation
        PM: u1 = 0,
        /// Alarm A hours mask
        MSK3: u1 = 0,
        /// Date units or day in BCD format
        DU: u4 = 0,
        /// Date tens in BCD format
        DT: u2 = 0,
        /// Week day selection
        WDSEL: u1 = 0,
        /// Alarm A date mask
        MSK4: u1 = 0,
    });

    /// alarm B register
    pub const ALRMBR = mmio(Address + 0x00000020, 32, packed struct {
        /// Second units in BCD format
        SU: u4 = 0,
        /// Second tens in BCD format
        ST: u3 = 0,
        /// Alarm B seconds mask
        MSK1: u1 = 0,
        /// Minute units in BCD format
        MNU: u4 = 0,
        /// Minute tens in BCD format
        MNT: u3 = 0,
        /// Alarm B minutes mask
        MSK2: u1 = 0,
        /// Hour units in BCD format
        HU: u4 = 0,
        /// Hour tens in BCD format
        HT: u2 = 0,
        /// AM/PM notation
        PM: u1 = 0,
        /// Alarm B hours mask
        MSK3: u1 = 0,
        /// Date units or day in BCD format
        DU: u4 = 0,
        /// Date tens in BCD format
        DT: u2 = 0,
        /// Week day selection
        WDSEL: u1 = 0,
        /// Alarm B date mask
        MSK4: u1 = 0,
    });

    /// write protection register
    pub const WPR = mmio(Address + 0x00000024, 32, packed struct {
        /// Write protection key
        KEY: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sub second register
    pub const SSR = mmio(Address + 0x00000028, 32, packed struct {
        /// Sub second value
        SS: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// shift control register
    pub const SHIFTR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Subtract a fraction of a second
        SUBFS: u15 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Add one second
        ADD1S: u1 = 0,
    });

    /// time stamp time register
    pub const TSTR = mmio(Address + 0x00000030, 32, packed struct {
        /// Second units in BCD format
        SU: u4 = 0,
        /// Second tens in BCD format
        ST: u3 = 0,
        reserved1: u1 = 0,
        /// Minute units in BCD format
        MNU: u4 = 0,
        /// Minute tens in BCD format
        MNT: u3 = 0,
        reserved2: u1 = 0,
        /// Hour units in BCD format
        HU: u4 = 0,
        /// Hour tens in BCD format
        HT: u2 = 0,
        /// AM/PM notation
        PM: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// time stamp date register
    pub const TSDR = mmio(Address + 0x00000034, 32, packed struct {
        /// Date units in BCD format
        DU: u4 = 0,
        /// Date tens in BCD format
        DT: u2 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Month units in BCD format
        MU: u4 = 0,
        /// Month tens in BCD format
        MT: u1 = 0,
        /// Week day units
        WDU: u3 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// timestamp sub second register
    pub const TSSSR = mmio(Address + 0x00000038, 32, packed struct {
        /// Sub second value
        SS: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// calibration register
    pub const CALR = mmio(Address + 0x0000003c, 32, packed struct {
        /// Calibration minus
        CALM: u9 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Use a 16-second calibration cycle period
        CALW16: u1 = 0,
        /// Use an 8-second calibration cycle period
        CALW8: u1 = 0,
        /// Increase frequency of RTC by 488.5 ppm
        CALP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// tamper and alternate function configuration register
    pub const TAFCR = mmio(Address + 0x00000040, 32, packed struct {
        /// Tamper 1 detection enable
        TAMP1E: u1 = 0,
        /// Active level for tamper 1
        TAMP1TRG: u1 = 0,
        /// Tamper interrupt enable
        TAMPIE: u1 = 0,
        /// Tamper 2 detection enable
        TAMP2E: u1 = 0,
        /// Active level for tamper 2
        TAMP2TRG: u1 = 0,
        /// Tamper 3 detection enable
        TAMP3E: u1 = 0,
        /// Active level for tamper 3
        TAMP3TRG: u1 = 0,
        /// Activate timestamp on tamper detection event
        TAMPTS: u1 = 0,
        /// Tamper sampling frequency
        TAMPFREQ: u3 = 0,
        /// Tamper filter count
        TAMPFLT: u2 = 0,
        /// Tamper precharge duration
        TAMPPRCH: u2 = 0,
        /// TAMPER pull-up disable
        TAMPPUDIS: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// PC13 value
        PC13VALUE: u1 = 0,
        /// PC13 mode
        PC13MODE: u1 = 0,
        /// PC14 value
        PC14VALUE: u1 = 0,
        /// PC 14 mode
        PC14MODE: u1 = 0,
        /// PC15 value
        PC15VALUE: u1 = 0,
        /// PC15 mode
        PC15MODE: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// alarm A sub second register
    pub const ALRMASSR = mmio(Address + 0x00000044, 32, packed struct {
        /// Sub seconds value
        SS: u15 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Mask the most-significant bits starting at this bit
        MASKSS: u4 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// alarm B sub second register
    pub const ALRMBSSR = mmio(Address + 0x00000048, 32, packed struct {
        /// Sub seconds value
        SS: u15 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Mask the most-significant bits starting at this bit
        MASKSS: u4 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// backup register
    pub const BKP0R = mmio(Address + 0x00000050, 32, packed struct {});

    /// backup register
    pub const BKP1R = mmio(Address + 0x00000054, 32, packed struct {});

    /// backup register
    pub const BKP2R = mmio(Address + 0x00000058, 32, packed struct {});

    /// backup register
    pub const BKP3R = mmio(Address + 0x0000005c, 32, packed struct {});

    /// backup register
    pub const BKP4R = mmio(Address + 0x00000060, 32, packed struct {});

    /// backup register
    pub const BKP5R = mmio(Address + 0x00000064, 32, packed struct {});

    /// backup register
    pub const BKP6R = mmio(Address + 0x00000068, 32, packed struct {});

    /// backup register
    pub const BKP7R = mmio(Address + 0x0000006c, 32, packed struct {});

    /// backup register
    pub const BKP8R = mmio(Address + 0x00000070, 32, packed struct {});

    /// backup register
    pub const BKP9R = mmio(Address + 0x00000074, 32, packed struct {});

    /// backup register
    pub const BKP10R = mmio(Address + 0x00000078, 32, packed struct {});

    /// backup register
    pub const BKP11R = mmio(Address + 0x0000007c, 32, packed struct {});

    /// backup register
    pub const BKP12R = mmio(Address + 0x00000080, 32, packed struct {});

    /// backup register
    pub const BKP13R = mmio(Address + 0x00000084, 32, packed struct {});

    /// backup register
    pub const BKP14R = mmio(Address + 0x00000088, 32, packed struct {});

    /// backup register
    pub const BKP15R = mmio(Address + 0x0000008c, 32, packed struct {});

    /// backup register
    pub const BKP16R = mmio(Address + 0x00000090, 32, packed struct {});

    /// backup register
    pub const BKP17R = mmio(Address + 0x00000094, 32, packed struct {});

    /// backup register
    pub const BKP18R = mmio(Address + 0x00000098, 32, packed struct {});

    /// backup register
    pub const BKP19R = mmio(Address + 0x0000009c, 32, packed struct {});

    /// backup register
    pub const BKP20R = mmio(Address + 0x000000a0, 32, packed struct {});

    /// backup register
    pub const BKP21R = mmio(Address + 0x000000a4, 32, packed struct {});

    /// backup register
    pub const BKP22R = mmio(Address + 0x000000a8, 32, packed struct {});

    /// backup register
    pub const BKP23R = mmio(Address + 0x000000ac, 32, packed struct {});

    /// backup register
    pub const BKP24R = mmio(Address + 0x000000b0, 32, packed struct {});

    /// backup register
    pub const BKP25R = mmio(Address + 0x000000b4, 32, packed struct {});

    /// backup register
    pub const BKP26R = mmio(Address + 0x000000b8, 32, packed struct {});

    /// backup register
    pub const BKP27R = mmio(Address + 0x000000bc, 32, packed struct {});

    /// backup register
    pub const BKP28R = mmio(Address + 0x000000c0, 32, packed struct {});

    /// backup register
    pub const BKP29R = mmio(Address + 0x000000c4, 32, packed struct {});

    /// backup register
    pub const BKP30R = mmio(Address + 0x000000c8, 32, packed struct {});

    /// backup register
    pub const BKP31R = mmio(Address + 0x000000cc, 32, packed struct {});
};

/// Basic timers
pub const TIM6 = extern struct {
    pub const Address: u32 = 0x40001000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// Low counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF Copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Low Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Basic timers
pub const TIM7 = extern struct {
    pub const Address: u32 = 0x40001400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        padding31: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// Low counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF Copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Low Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Digital-to-analog converter
pub const DAC = extern struct {
    pub const Address: u32 = 0x40007400;

    /// control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// DAC channel1 enable
        EN1: u1 = 0,
        /// DAC channel1 output buffer disable
        BOFF1: u1 = 0,
        /// DAC channel1 trigger enable
        TEN1: u1 = 0,
        /// DAC channel1 trigger selection
        TSEL1: u3 = 0,
        /// DAC channel1 noise/triangle wave generation enable
        WAVE1: u2 = 0,
        /// DAC channel1 mask/amplitude selector
        MAMP1: u4 = 0,
        /// DAC channel1 DMA enable
        DMAEN1: u1 = 0,
        /// DAC channel1 DMA Underrun Interrupt enable
        DMAUDRIE1: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel2 enable
        EN2: u1 = 0,
        /// DAC channel2 output buffer disable
        BOFF2: u1 = 0,
        /// DAC channel2 trigger enable
        TEN2: u1 = 0,
        /// DAC channel2 trigger selection
        TSEL2: u3 = 0,
        /// DAC channel2 noise/triangle wave generation enable
        WAVE2: u2 = 0,
        /// DAC channel2 mask/amplitude selector
        MAMP2: u4 = 0,
        /// DAC channel2 DMA enable
        DMAEN2: u1 = 0,
        /// DAC channel2 DMA underrun interrupt enable
        DMAUDRIE2: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// software trigger register
    pub const SWTRIGR = mmio(Address + 0x00000004, 32, packed struct {
        /// DAC channel1 software trigger
        SWTRIG1: u1 = 0,
        /// DAC channel2 software trigger
        SWTRIG2: u1 = 0,
        padding30: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel1 12-bit right-aligned data holding register
    pub const DHR12R1 = mmio(Address + 0x00000008, 32, packed struct {
        /// DAC channel1 12-bit right-aligned data
        DACC1DHR: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel1 12-bit left aligned data holding register
    pub const DHR12L1 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel1 12-bit left-aligned data
        DACC1DHR: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel1 8-bit right aligned data holding register
    pub const DHR8R1 = mmio(Address + 0x00000010, 32, packed struct {
        /// DAC channel1 8-bit right-aligned data
        DACC1DHR: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel2 12-bit right aligned data holding register
    pub const DHR12R2 = mmio(Address + 0x00000014, 32, packed struct {
        /// DAC channel2 12-bit right-aligned data
        DACC2DHR: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel2 12-bit left aligned data holding register
    pub const DHR12L2 = mmio(Address + 0x00000018, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel2 12-bit left-aligned data
        DACC2DHR: u12 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel2 8-bit right-aligned data holding register
    pub const DHR8R2 = mmio(Address + 0x0000001c, 32, packed struct {
        /// DAC channel2 8-bit right-aligned data
        DACC2DHR: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Dual DAC 12-bit right-aligned data holding register
    pub const DHR12RD = mmio(Address + 0x00000020, 32, packed struct {
        /// DAC channel1 12-bit right-aligned data
        DACC1DHR: u12 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel2 12-bit right-aligned data
        DACC2DHR: u12 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DUAL DAC 12-bit left aligned data holding register
    pub const DHR12LD = mmio(Address + 0x00000024, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel1 12-bit left-aligned data
        DACC1DHR: u12 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// DAC channel2 12-bit left-aligned data
        DACC2DHR: u12 = 0,
    });

    /// DUAL DAC 8-bit right aligned data holding register
    pub const DHR8RD = mmio(Address + 0x00000028, 32, packed struct {
        /// DAC channel1 8-bit right-aligned data
        DACC1DHR: u8 = 0,
        /// DAC channel2 8-bit right-aligned data
        DACC2DHR: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel1 data output register
    pub const DOR1 = mmio(Address + 0x0000002c, 32, packed struct {
        /// DAC channel1 data output
        DACC1DOR: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// channel2 data output register
    pub const DOR2 = mmio(Address + 0x00000030, 32, packed struct {
        /// DAC channel2 data output
        DACC2DOR: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000034, 32, packed struct {
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DAC channel1 DMA underrun flag
        DMAUDR1: u1 = 0,
        reserved28: u1 = 0,
        reserved27: u1 = 0,
        reserved26: u1 = 0,
        reserved25: u1 = 0,
        reserved24: u1 = 0,
        reserved23: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        /// DAC channel2 DMA underrun flag
        DMAUDR2: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Debug support
pub const DBGMCU = extern struct {
    pub const Address: u32 = 0xe0042000;

    /// MCU Device ID Code Register
    pub const IDCODE = mmio(Address + 0x00000000, 32, packed struct {
        /// Device Identifier
        DEV_ID: u12 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Revision Identifier
        REV_ID: u16 = 0,
    });

    /// Debug MCU Configuration Register
    pub const CR = mmio(Address + 0x00000004, 32, packed struct {
        /// Debug Sleep mode
        DBG_SLEEP: u1 = 0,
        /// Debug Stop Mode
        DBG_STOP: u1 = 0,
        /// Debug Standby Mode
        DBG_STANDBY: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Trace pin assignment control
        TRACE_IOEN: u1 = 0,
        /// Trace pin assignment control
        TRACE_MODE: u2 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB Low Freeze Register
    pub const APB1FZ = mmio(Address + 0x00000008, 32, packed struct {
        /// Debug Timer 2 stopped when Core is halted
        DBG_TIM2_STOP: u1 = 0,
        /// Debug Timer 3 stopped when Core is halted
        DBG_TIM3_STOP: u1 = 0,
        /// Debug Timer 4 stopped when Core is halted
        DBG_TIM4_STOP: u1 = 0,
        /// Debug Timer 5 stopped when Core is halted
        DBG_TIM5_STOP: u1 = 0,
        /// Debug Timer 6 stopped when Core is halted
        DBG_TIM6_STOP: u1 = 0,
        /// Debug Timer 7 stopped when Core is halted
        DBG_TIM7_STOP: u1 = 0,
        /// Debug Timer 12 stopped when Core is halted
        DBG_TIM12_STOP: u1 = 0,
        /// Debug Timer 13 stopped when Core is halted
        DBG_TIM13_STOP: u1 = 0,
        /// Debug Timer 14 stopped when Core is halted
        DBG_TIMER14_STOP: u1 = 0,
        /// Debug Timer 18 stopped when Core is halted
        DBG_TIM18_STOP: u1 = 0,
        /// Debug RTC stopped when Core is halted
        DBG_RTC_STOP: u1 = 0,
        /// Debug Window Wachdog stopped when Core is halted
        DBG_WWDG_STOP: u1 = 0,
        /// Debug Independent Wachdog stopped when Core is halted
        DBG_IWDG_STOP: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// SMBUS timeout mode stopped when Core is halted
        I2C1_SMBUS_TIMEOUT: u1 = 0,
        /// SMBUS timeout mode stopped when Core is halted
        I2C2_SMBUS_TIMEOUT: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        /// Debug CAN stopped when core is halted
        DBG_CAN_STOP: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// APB High Freeze Register
    pub const APB2FZ = mmio(Address + 0x0000000c, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Debug Timer 15 stopped when Core is halted
        DBG_TIM15_STOP: u1 = 0,
        /// Debug Timer 16 stopped when Core is halted
        DBG_TIM16_STOP: u1 = 0,
        /// Debug Timer 17 stopped when Core is halted
        DBG_TIM17_STO: u1 = 0,
        /// Debug Timer 19 stopped when Core is halted
        DBG_TIM19_STOP: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Advanced timer
pub const TIM1 = extern struct {
    pub const Address: u32 = 0x40012c00;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// Output Idle state 2
        OIS2: u1 = 0,
        /// Output Idle state 2
        OIS2N: u1 = 0,
        /// Output Idle state 3
        OIS3: u1 = 0,
        /// Output Idle state 3
        OIS3N: u1 = 0,
        /// Output Idle state 4
        OIS4: u1 = 0,
        reserved2: u1 = 0,
        /// Output Idle state 5
        OIS5: u1 = 0,
        reserved3: u1 = 0,
        /// Output Idle state 6
        OIS6: u1 = 0,
        reserved4: u1 = 0,
        /// Master mode selection 2
        MMS2: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit 3
        SMS3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        /// Break 2 interrupt flag
        B2IF: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 5 interrupt flag
        C5IF: u1 = 0,
        /// Capture/Compare 6 interrupt flag
        C6IF: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        /// Break 2 generation
        B2G: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// Output Compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output Compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output Compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// Output Compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output Compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PCS: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PCS: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        OC4CE: u1 = 0,
        /// Output Compare 3 mode bit 3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 4 mode bit 3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        /// Capture/Compare 2 complementary output enable
        CC2NE: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        /// Capture/Compare 3 complementary output enable
        CC3NE: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 4 output Polarity
        CC4NP: u1 = 0,
        /// Capture/Compare 5 output enable
        CC5E: u1 = 0,
        /// Capture/Compare 5 output Polarity
        CC5P: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 6 output enable
        CC6E: u1 = 0,
        /// Capture/Compare 6 output Polarity
        CC6P: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Capture/Compare 3 value
        CCR3: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Capture/Compare 3 value
        CCR4: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        /// Break 2 filter
        BK2F: u4 = 0,
        /// Break 2 enable
        BK2E: u1 = 0,
        /// Break 2 polarity
        BK2P: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 5 fast enable
        OC5FE: u1 = 0,
        /// Output compare 5 preload enable
        OC5PE: u1 = 0,
        /// Output compare 5 mode
        OC5M: u3 = 0,
        /// Output compare 5 clear enable
        OC5CE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Output compare 6 fast enable
        OC6FE: u1 = 0,
        /// Output compare 6 preload enable
        OC6PE: u1 = 0,
        /// Output compare 6 mode
        OC6M: u3 = 0,
        /// Output compare 6 clear enable
        OC6CE: u1 = 0,
        /// Outout Compare 5 mode bit 3
        OC5M_3: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Outout Compare 6 mode bit 3
        OC6M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        /// Capture/Compare 5 value
        CCR5: u16 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Group Channel 5 and Channel 1
        GC5C1: u1 = 0,
        /// Group Channel 5 and Channel 2
        GC5C2: u1 = 0,
        /// Group Channel 5 and Channel 3
        GC5C3: u1 = 0,
    });

    /// capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Capture/Compare 6 value
        CCR6: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        /// TIM1_ETR_ADC1 remapping capability
        TIM1_ETR_ADC1_RMP: u2 = 0,
        /// TIM1_ETR_ADC4 remapping capability
        TIM1_ETR_ADC4_RMP: u2 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Advanced timer
pub const TIM20 = extern struct {
    pub const Address: u32 = 0x40015000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// Output Idle state 2
        OIS2: u1 = 0,
        /// Output Idle state 2
        OIS2N: u1 = 0,
        /// Output Idle state 3
        OIS3: u1 = 0,
        /// Output Idle state 3
        OIS3N: u1 = 0,
        /// Output Idle state 4
        OIS4: u1 = 0,
        reserved2: u1 = 0,
        /// Output Idle state 5
        OIS5: u1 = 0,
        reserved3: u1 = 0,
        /// Output Idle state 6
        OIS6: u1 = 0,
        reserved4: u1 = 0,
        /// Master mode selection 2
        MMS2: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit 3
        SMS3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        /// Break 2 interrupt flag
        B2IF: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 5 interrupt flag
        C5IF: u1 = 0,
        /// Capture/Compare 6 interrupt flag
        C6IF: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        /// Break 2 generation
        B2G: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// Output Compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output Compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output Compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// Output Compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output Compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PCS: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PCS: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        OC4CE: u1 = 0,
        /// Output Compare 3 mode bit 3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 4 mode bit 3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        /// Capture/Compare 2 complementary output enable
        CC2NE: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        /// Capture/Compare 3 complementary output enable
        CC3NE: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 4 output Polarity
        CC4NP: u1 = 0,
        /// Capture/Compare 5 output enable
        CC5E: u1 = 0,
        /// Capture/Compare 5 output Polarity
        CC5P: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 6 output enable
        CC6E: u1 = 0,
        /// Capture/Compare 6 output Polarity
        CC6P: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Capture/Compare 3 value
        CCR3: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Capture/Compare 3 value
        CCR4: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        /// Break 2 filter
        BK2F: u4 = 0,
        /// Break 2 enable
        BK2E: u1 = 0,
        /// Break 2 polarity
        BK2P: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 5 fast enable
        OC5FE: u1 = 0,
        /// Output compare 5 preload enable
        OC5PE: u1 = 0,
        /// Output compare 5 mode
        OC5M: u3 = 0,
        /// Output compare 5 clear enable
        OC5CE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Output compare 6 fast enable
        OC6FE: u1 = 0,
        /// Output compare 6 preload enable
        OC6PE: u1 = 0,
        /// Output compare 6 mode
        OC6M: u3 = 0,
        /// Output compare 6 clear enable
        OC6CE: u1 = 0,
        /// Outout Compare 5 mode bit 3
        OC5M_3: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Outout Compare 6 mode bit 3
        OC6M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        /// Capture/Compare 5 value
        CCR5: u16 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Group Channel 5 and Channel 1
        GC5C1: u1 = 0,
        /// Group Channel 5 and Channel 2
        GC5C2: u1 = 0,
        /// Group Channel 5 and Channel 3
        GC5C3: u1 = 0,
    });

    /// capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Capture/Compare 6 value
        CCR6: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        /// TIM1_ETR_ADC1 remapping capability
        TIM1_ETR_ADC1_RMP: u2 = 0,
        /// TIM1_ETR_ADC4 remapping capability
        TIM1_ETR_ADC4_RMP: u2 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Advanced-timers
pub const TIM8 = extern struct {
    pub const Address: u32 = 0x40013400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        /// One-pulse mode
        OPM: u1 = 0,
        /// Direction
        DIR: u1 = 0,
        /// Center-aligned mode selection
        CMS: u2 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
        reserved1: u1 = 0,
        /// UIF status bit remapping
        UIFREMAP: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Capture/compare preloaded control
        CCPC: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1 = 0,
        /// Capture/compare DMA selection
        CCDS: u1 = 0,
        /// Master mode selection
        MMS: u3 = 0,
        /// TI1 selection
        TI1S: u1 = 0,
        /// Output Idle state 1
        OIS1: u1 = 0,
        /// Output Idle state 1
        OIS1N: u1 = 0,
        /// Output Idle state 2
        OIS2: u1 = 0,
        /// Output Idle state 2
        OIS2N: u1 = 0,
        /// Output Idle state 3
        OIS3: u1 = 0,
        /// Output Idle state 3
        OIS3N: u1 = 0,
        /// Output Idle state 4
        OIS4: u1 = 0,
        reserved2: u1 = 0,
        /// Output Idle state 5
        OIS5: u1 = 0,
        reserved3: u1 = 0,
        /// Output Idle state 6
        OIS6: u1 = 0,
        reserved4: u1 = 0,
        /// Master mode selection 2
        MMS2: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        /// OCREF clear selection
        OCCS: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        /// Slave mode selection bit 3
        SMS3: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        /// Update interrupt enable
        UIE: u1 = 0,
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        /// COM interrupt enable
        COMIE: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
        /// Break interrupt enable
        BIE: u1 = 0,
        /// Update DMA request enable
        UDE: u1 = 0,
        /// Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        /// COM DMA request enable
        COMDE: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        /// COM interrupt flag
        COMIF: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        /// Break interrupt flag
        BIF: u1 = 0,
        /// Break 2 interrupt flag
        B2IF: u1 = 0,
        /// Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 5 interrupt flag
        C5IF: u1 = 0,
        /// Capture/Compare 6 interrupt flag
        C6IF: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        /// Update generation
        UG: u1 = 0,
        /// Capture/compare 1 generation
        CC1G: u1 = 0,
        /// Capture/compare 2 generation
        CC2G: u1 = 0,
        /// Capture/compare 3 generation
        CC3G: u1 = 0,
        /// Capture/compare 4 generation
        CC4G: u1 = 0,
        /// Capture/Compare control update generation
        COMG: u1 = 0,
        /// Trigger generation
        TG: u1 = 0,
        /// Break generation
        BG: u1 = 0,
        /// Break 2 generation
        B2G: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Output Compare 1 fast enable
        OC1FE: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
        /// Output Compare 1 clear enable
        OC1CE: u1 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Output Compare 2 fast enable
        OC2FE: u1 = 0,
        /// Output Compare 2 preload enable
        OC2PE: u1 = 0,
        /// Output Compare 2 mode
        OC2M: u3 = 0,
        /// Output Compare 2 clear enable
        OC2CE: u1 = 0,
        /// Output Compare 1 mode bit 3
        OC1M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 2 mode bit 3
        OC2M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// Input capture 1 prescaler
        IC1PCS: u2 = 0,
        /// Input capture 1 filter
        IC1F: u4 = 0,
        /// Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// Input capture 2 prescaler
        IC2PCS: u2 = 0,
        /// Input capture 2 filter
        IC2F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// Output compare 3 mode
        OC3M: u3 = 0,
        /// Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// Output compare 4 mode
        OC4M: u3 = 0,
        /// Output compare 4 clear enable
        OC4CE: u1 = 0,
        /// Output Compare 3 mode bit 3
        OC3M_3: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output Compare 4 mode bit 3
        OC4M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        /// Capture/compare 3 selection
        CC3S: u2 = 0,
        /// Input capture 3 prescaler
        IC3PSC: u2 = 0,
        /// Input capture 3 filter
        IC3F: u4 = 0,
        /// Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// Input capture 4 prescaler
        IC4PSC: u2 = 0,
        /// Input capture 4 filter
        IC4F: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        /// Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        /// Capture/Compare 1 complementary output enable
        CC1NE: u1 = 0,
        /// Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        /// Capture/Compare 2 complementary output enable
        CC2NE: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        /// Capture/Compare 3 complementary output enable
        CC3NE: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 4 output Polarity
        CC4NP: u1 = 0,
        /// Capture/Compare 5 output enable
        CC5E: u1 = 0,
        /// Capture/Compare 5 output Polarity
        CC5P: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Capture/Compare 6 output enable
        CC6E: u1 = 0,
        /// Capture/Compare 6 output Polarity
        CC6P: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        /// counter value
        CNT: u16 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// UIF copy
        UIFCPY: u1 = 0,
    });

    /// prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        /// Prescaler value
        PSC: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Auto-reload value
        ARR: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        /// Repetition counter value
        REP: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        /// Capture/Compare 1 value
        CCR1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        /// Capture/Compare 2 value
        CCR2: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Capture/Compare 3 value
        CCR3: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        /// Capture/Compare 3 value
        CCR4: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        /// Dead-time generator setup
        DTG: u8 = 0,
        /// Lock configuration
        LOCK: u2 = 0,
        /// Off-state selection for Idle mode
        OSSI: u1 = 0,
        /// Off-state selection for Run mode
        OSSR: u1 = 0,
        /// Break enable
        BKE: u1 = 0,
        /// Break polarity
        BKP: u1 = 0,
        /// Automatic output enable
        AOE: u1 = 0,
        /// Main output enable
        MOE: u1 = 0,
        /// Break filter
        BKF: u4 = 0,
        /// Break 2 filter
        BK2F: u4 = 0,
        /// Break 2 enable
        BK2E: u1 = 0,
        /// Break 2 polarity
        BK2P: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        /// DMA base address
        DBA: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA burst length
        DBL: u5 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        /// DMA register for burst accesses
        DMAB: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Output compare 5 fast enable
        OC5FE: u1 = 0,
        /// Output compare 5 preload enable
        OC5PE: u1 = 0,
        /// Output compare 5 mode
        OC5M: u3 = 0,
        /// Output compare 5 clear enable
        OC5CE: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Output compare 6 fast enable
        OC6FE: u1 = 0,
        /// Output compare 6 preload enable
        OC6PE: u1 = 0,
        /// Output compare 6 mode
        OC6M: u3 = 0,
        /// Output compare 6 clear enable
        OC6CE: u1 = 0,
        /// Outout Compare 5 mode bit 3
        OC5M_3: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Outout Compare 6 mode bit 3
        OC6M_3: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        /// Capture/Compare 5 value
        CCR5: u16 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Group Channel 5 and Channel 1
        GC5C1: u1 = 0,
        /// Group Channel 5 and Channel 2
        GC5C2: u1 = 0,
        /// Group Channel 5 and Channel 3
        GC5C3: u1 = 0,
    });

    /// capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Capture/Compare 6 value
        CCR6: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        /// TIM8_ETR_ADC2 remapping capability
        TIM8_ETR_ADC2_RMP: u2 = 0,
        /// TIM8_ETR_ADC3 remapping capability
        TIM8_ETR_ADC3_RMP: u2 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC1 = extern struct {
    pub const Address: u32 = 0x50000000;

    /// interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        reserved5: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        reserved1: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        padding1: u1 = 0,
    });

    /// offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_1_15: u15 = 0,
        /// Differential mode for channels 18 to 16
        DIFSEL_16_18: u3 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC2 = extern struct {
    pub const Address: u32 = 0x50000100;

    /// interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        reserved5: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        reserved1: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        padding1: u1 = 0,
    });

    /// offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_1_15: u15 = 0,
        /// Differential mode for channels 18 to 16
        DIFSEL_16_18: u3 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC3 = extern struct {
    pub const Address: u32 = 0x50000400;

    /// interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        reserved5: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        reserved1: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        padding1: u1 = 0,
    });

    /// offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_1_15: u15 = 0,
        /// Differential mode for channels 18 to 16
        DIFSEL_16_18: u3 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC4 = extern struct {
    pub const Address: u32 = 0x50000500;

    /// interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        reserved5: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        reserved4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        reserved1: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved3: u1 = 0,
        padding1: u1 = 0,
    });

    /// offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        /// Differential mode for channels 15 to 1
        DIFSEL_1_15: u15 = 0,
        /// Differential mode for channels 18 to 16
        DIFSEL_16_18: u3 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC1_2 = extern struct {
    pub const Address: u32 = 0x50000300;

    /// ADC Common status register
    pub const CSR = mmio(Address + 0x00000000, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// End of regular conversion of the slave ADC
        EOC_SLV: u1 = 0,
        /// End of regular sequence flag of the slave ADC
        EOS_SLV: u1 = 0,
        /// Overrun flag of the slave ADC
        OVR_SLV: u1 = 0,
        /// End of injected conversion flag of the slave ADC
        JEOC_SLV: u1 = 0,
        /// End of injected sequence flag of the slave ADC
        JEOS_SLV: u1 = 0,
        /// Analog watchdog 1 flag of the slave ADC
        AWD1_SLV: u1 = 0,
        /// Analog watchdog 2 flag of the slave ADC
        AWD2_SLV: u1 = 0,
        /// Analog watchdog 3 flag of the slave ADC
        AWD3_SLV: u1 = 0,
        /// Injected Context Queue Overflow flag of the slave ADC
        JQOVF_SLV: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// ADC common control register
    pub const CCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Multi ADC mode selection
        MULT: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Delay between 2 sampling phases
        DELAY: u4 = 0,
        reserved4: u1 = 0,
        /// DMA configuration (for multi-ADC mode)
        DMACFG: u1 = 0,
        /// Direct memory access mode for multi ADC mode
        MDMA: u2 = 0,
        /// ADC clock mode
        CKMODE: u2 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// VREFINT enable
        VREFEN: u1 = 0,
        /// Temperature sensor enable
        TSEN: u1 = 0,
        /// VBAT enable
        VBATEN: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// ADC common regular data register for dual and triple modes
    pub const CDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Regular data of the master ADC
        RDATA_MST: u16 = 0,
        /// Regular data of the slave ADC
        RDATA_SLV: u16 = 0,
    });
};

/// Analog-to-Digital Converter
pub const ADC3_4 = extern struct {
    pub const Address: u32 = 0x50000700;

    /// ADC Common status register
    pub const CSR = mmio(Address + 0x00000000, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// End of regular conversion of the slave ADC
        EOC_SLV: u1 = 0,
        /// End of regular sequence flag of the slave ADC
        EOS_SLV: u1 = 0,
        /// Overrun flag of the slave ADC
        OVR_SLV: u1 = 0,
        /// End of injected conversion flag of the slave ADC
        JEOC_SLV: u1 = 0,
        /// End of injected sequence flag of the slave ADC
        JEOS_SLV: u1 = 0,
        /// Analog watchdog 1 flag of the slave ADC
        AWD1_SLV: u1 = 0,
        /// Analog watchdog 2 flag of the slave ADC
        AWD2_SLV: u1 = 0,
        /// Analog watchdog 3 flag of the slave ADC
        AWD3_SLV: u1 = 0,
        /// Injected Context Queue Overflow flag of the slave ADC
        JQOVF_SLV: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// ADC common control register
    pub const CCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Multi ADC mode selection
        MULT: u5 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Delay between 2 sampling phases
        DELAY: u4 = 0,
        reserved4: u1 = 0,
        /// DMA configuration (for multi-ADC mode)
        DMACFG: u1 = 0,
        /// Direct memory access mode for multi ADC mode
        MDMA: u2 = 0,
        /// ADC clock mode
        CKMODE: u2 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// VREFINT enable
        VREFEN: u1 = 0,
        /// Temperature sensor enable
        TSEN: u1 = 0,
        /// VBAT enable
        VBATEN: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// ADC common regular data register for dual and triple modes
    pub const CDR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Regular data of the master ADC
        RDATA_MST: u16 = 0,
        /// Regular data of the slave ADC
        RDATA_SLV: u16 = 0,
    });
};

/// System configuration controller _Comparator and Operational amplifier
pub const SYSCFG_COMP_OPAMP = extern struct {
    pub const Address: u32 = 0x40010000;

    /// configuration register 1
    pub const SYSCFG_CFGR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Memory mapping selection bits
        MEM_MODE: u2 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// USB interrupt remap
        USB_IT_RMP: u1 = 0,
        /// Timer 1 ITR3 selection
        TIM1_ITR_RMP: u1 = 0,
        /// DAC trigger remap (when TSEL = 001)
        DAC_TRIG_RMP: u1 = 0,
        /// ADC24 DMA remapping bit
        ADC24_DMA_RMP: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// TIM16 DMA request remapping bit
        TIM16_DMA_RMP: u1 = 0,
        /// TIM17 DMA request remapping bit
        TIM17_DMA_RMP: u1 = 0,
        /// TIM6 and DAC1 DMA request remapping bit
        TIM6_DAC1_DMA_RMP: u1 = 0,
        /// TIM7 and DAC2 DMA request remapping bit
        TIM7_DAC2_DMA_RMP: u1 = 0,
        reserved6: u1 = 0,
        /// Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB6_FM: u1 = 0,
        /// Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB7_FM: u1 = 0,
        /// Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB8_FM: u1 = 0,
        /// Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB9_FM: u1 = 0,
        /// I2C1 Fast Mode Plus
        I2C1_FM: u1 = 0,
        /// I2C2 Fast Mode Plus
        I2C2_FM: u1 = 0,
        /// Encoder mode
        ENCODER_MODE: u2 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        /// Interrupt enable bits from FPU
        FPU_IT: u6 = 0,
    });

    /// CCM SRAM protection register
    pub const SYSCFG_RCR = mmio(Address + 0x00000004, 32, packed struct {
        /// CCM SRAM page write protection bit
        PAGE0_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE1_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE2_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE3_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE4_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE5_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE6_WP: u1 = 0,
        /// CCM SRAM page write protection bit
        PAGE7_WP: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// external interrupt configuration register 1
    pub const SYSCFG_EXTICR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// EXTI 0 configuration bits
        EXTI0: u4 = 0,
        /// EXTI 1 configuration bits
        EXTI1: u4 = 0,
        /// EXTI 2 configuration bits
        EXTI2: u4 = 0,
        /// EXTI 3 configuration bits
        EXTI3: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// external interrupt configuration register 2
    pub const SYSCFG_EXTICR2 = mmio(Address + 0x0000000c, 32, packed struct {
        /// EXTI 4 configuration bits
        EXTI4: u4 = 0,
        /// EXTI 5 configuration bits
        EXTI5: u4 = 0,
        /// EXTI 6 configuration bits
        EXTI6: u4 = 0,
        /// EXTI 7 configuration bits
        EXTI7: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// external interrupt configuration register 3
    pub const SYSCFG_EXTICR3 = mmio(Address + 0x00000010, 32, packed struct {
        /// EXTI 8 configuration bits
        EXTI8: u4 = 0,
        /// EXTI 9 configuration bits
        EXTI9: u4 = 0,
        /// EXTI 10 configuration bits
        EXTI10: u4 = 0,
        /// EXTI 11 configuration bits
        EXTI11: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// external interrupt configuration register 4
    pub const SYSCFG_EXTICR4 = mmio(Address + 0x00000014, 32, packed struct {
        /// EXTI 12 configuration bits
        EXTI12: u4 = 0,
        /// EXTI 13 configuration bits
        EXTI13: u4 = 0,
        /// EXTI 14 configuration bits
        EXTI14: u4 = 0,
        /// EXTI 15 configuration bits
        EXTI15: u4 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// configuration register 2
    pub const SYSCFG_CFGR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Cortex-M0 LOCKUP bit enable bit
        LOCUP_LOCK: u1 = 0,
        /// SRAM parity lock bit
        SRAM_PARITY_LOCK: u1 = 0,
        /// PVD lock enable bit
        PVD_LOCK: u1 = 0,
        reserved1: u1 = 0,
        /// Bypass address bit 29 in parity calculation
        BYP_ADD_PAR: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// SRAM parity flag
        SRAM_PEF: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// control and status register
    pub const COMP1_CSR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Comparator 1 enable
        COMP1EN: u1 = 0,
        /// Comparator 1 mode
        COMP1MODE: u2 = 0,
        /// Comparator 1 inverting input selection
        COMP1INSEL: u3 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 1 output selection
        COMP1_OUT_SEL: u4 = 0,
        reserved4: u1 = 0,
        /// Comparator 1 output polarity
        COMP1POL: u1 = 0,
        /// Comparator 1 hysteresis
        COMP1HYST: u2 = 0,
        /// Comparator 1 blanking source
        COMP1_BLANKING: u3 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Comparator 1 output
        COMP1OUT: u1 = 0,
        /// Comparator 1 lock
        COMP1LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP2_CSR = mmio(Address + 0x00000020, 32, packed struct {
        /// Comparator 2 enable
        COMP2EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 2 mode
        COMP2MODE: u2 = 0,
        /// Comparator 2 inverting input selection
        COMP2INSEL: u3 = 0,
        /// Comparator 2 non inverted input selection
        COMP2INPSEL: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 1inverting input selection
        COMP2INMSEL: u1 = 0,
        /// Comparator 2 output selection
        COMP2_OUT_SEL: u4 = 0,
        reserved3: u1 = 0,
        /// Comparator 2 output polarity
        COMP2POL: u1 = 0,
        /// Comparator 2 hysteresis
        COMP2HYST: u2 = 0,
        /// Comparator 2 blanking source
        COMP2_BLANKING: u3 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Comparator 2 lock
        COMP2LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP3_CSR = mmio(Address + 0x00000024, 32, packed struct {
        /// Comparator 3 enable
        COMP3EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 3 mode
        COMP3MODE: u2 = 0,
        /// Comparator 3 inverting input selection
        COMP3INSEL: u3 = 0,
        /// Comparator 3 non inverted input selection
        COMP3INPSEL: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 3 output selection
        COMP3_OUT_SEL: u4 = 0,
        reserved4: u1 = 0,
        /// Comparator 3 output polarity
        COMP3POL: u1 = 0,
        /// Comparator 3 hysteresis
        COMP3HYST: u2 = 0,
        /// Comparator 3 blanking source
        COMP3_BLANKING: u3 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Comparator 3 output
        COMP3OUT: u1 = 0,
        /// Comparator 3 lock
        COMP3LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP4_CSR = mmio(Address + 0x00000028, 32, packed struct {
        /// Comparator 4 enable
        COMP4EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 4 mode
        COMP4MODE: u2 = 0,
        /// Comparator 4 inverting input selection
        COMP4INSEL: u3 = 0,
        /// Comparator 4 non inverted input selection
        COMP4INPSEL: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 4 window mode
        COM4WINMODE: u1 = 0,
        /// Comparator 4 output selection
        COMP4_OUT_SEL: u4 = 0,
        reserved3: u1 = 0,
        /// Comparator 4 output polarity
        COMP4POL: u1 = 0,
        /// Comparator 4 hysteresis
        COMP4HYST: u2 = 0,
        /// Comparator 4 blanking source
        COMP4_BLANKING: u3 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Comparator 4 output
        COMP4OUT: u1 = 0,
        /// Comparator 4 lock
        COMP4LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP5_CSR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Comparator 5 enable
        COMP5EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 5 mode
        COMP5MODE: u2 = 0,
        /// Comparator 5 inverting input selection
        COMP5INSEL: u3 = 0,
        /// Comparator 5 non inverted input selection
        COMP5INPSEL: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 5 output selection
        COMP5_OUT_SEL: u4 = 0,
        reserved4: u1 = 0,
        /// Comparator 5 output polarity
        COMP5POL: u1 = 0,
        /// Comparator 5 hysteresis
        COMP5HYST: u2 = 0,
        /// Comparator 5 blanking source
        COMP5_BLANKING: u3 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Comparator51 output
        COMP5OUT: u1 = 0,
        /// Comparator 5 lock
        COMP5LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP6_CSR = mmio(Address + 0x00000030, 32, packed struct {
        /// Comparator 6 enable
        COMP6EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 6 mode
        COMP6MODE: u2 = 0,
        /// Comparator 6 inverting input selection
        COMP6INSEL: u3 = 0,
        /// Comparator 6 non inverted input selection
        COMP6INPSEL: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 6 window mode
        COM6WINMODE: u1 = 0,
        /// Comparator 6 output selection
        COMP6_OUT_SEL: u4 = 0,
        reserved3: u1 = 0,
        /// Comparator 6 output polarity
        COMP6POL: u1 = 0,
        /// Comparator 6 hysteresis
        COMP6HYST: u2 = 0,
        /// Comparator 6 blanking source
        COMP6_BLANKING: u3 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        /// Comparator 6 output
        COMP6OUT: u1 = 0,
        /// Comparator 6 lock
        COMP6LOCK: u1 = 0,
    });

    /// control and status register
    pub const COMP7_CSR = mmio(Address + 0x00000034, 32, packed struct {
        /// Comparator 7 enable
        COMP7EN: u1 = 0,
        reserved1: u1 = 0,
        /// Comparator 7 mode
        COMP7MODE: u2 = 0,
        /// Comparator 7 inverting input selection
        COMP7INSEL: u3 = 0,
        /// Comparator 7 non inverted input selection
        COMP7INPSEL: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Comparator 7 output selection
        COMP7_OUT_SEL: u4 = 0,
        reserved4: u1 = 0,
        /// Comparator 7 output polarity
        COMP7POL: u1 = 0,
        /// Comparator 7 hysteresis
        COMP7HYST: u2 = 0,
        /// Comparator 7 blanking source
        COMP7_BLANKING: u3 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Comparator 7 output
        COMP7OUT: u1 = 0,
        /// Comparator 7 lock
        COMP7LOCK: u1 = 0,
    });

    /// control register
    pub const OPAMP1_CSR = mmio(Address + 0x00000038, 32, packed struct {
        /// OPAMP1 enable
        OPAMP1_EN: u1 = 0,
        /// OPAMP1 Non inverting input selection
        VP_SEL: u2 = 0,
        reserved1: u1 = 0,
        /// OPAMP1 inverting input selection
        VM_SEL: u2 = 0,
        /// Timer controlled Mux mode enable
        TCM_EN: u1 = 0,
        /// OPAMP1 inverting input secondary selection
        VMS_SEL: u1 = 0,
        /// OPAMP1 Non inverting input secondary selection
        VPS_SEL: u2 = 0,
        /// Calibration mode enable
        CALON: u1 = 0,
        /// Calibration selection
        CALSEL: u2 = 0,
        /// Gain in PGA mode
        PGA_GAIN: u4 = 0,
        /// User trimming enable
        USER_TRIM: u1 = 0,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5 = 0,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5 = 0,
        /// OPAMP 1 ouput status flag
        OUTCAL: u1 = 0,
        /// OPAMP 1 lock
        LOCK: u1 = 0,
    });

    /// control register
    pub const OPAMP2_CSR = mmio(Address + 0x0000003c, 32, packed struct {
        /// OPAMP2 enable
        OPAMP2EN: u1 = 0,
        /// OPAMP2 Non inverting input selection
        VP_SEL: u2 = 0,
        reserved1: u1 = 0,
        /// OPAMP2 inverting input selection
        VM_SEL: u2 = 0,
        /// Timer controlled Mux mode enable
        TCM_EN: u1 = 0,
        /// OPAMP2 inverting input secondary selection
        VMS_SEL: u1 = 0,
        /// OPAMP2 Non inverting input secondary selection
        VPS_SEL: u2 = 0,
        /// Calibration mode enable
        CALON: u1 = 0,
        /// Calibration selection
        CAL_SEL: u2 = 0,
        /// Gain in PGA mode
        PGA_GAIN: u4 = 0,
        /// User trimming enable
        USER_TRIM: u1 = 0,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5 = 0,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5 = 0,
        /// OPAMP 2 ouput status flag
        OUTCAL: u1 = 0,
        /// OPAMP 2 lock
        LOCK: u1 = 0,
    });

    /// control register
    pub const OPAMP3_CSR = mmio(Address + 0x00000040, 32, packed struct {
        /// OPAMP3 enable
        OPAMP3EN: u1 = 0,
        /// OPAMP3 Non inverting input selection
        VP_SEL: u2 = 0,
        reserved1: u1 = 0,
        /// OPAMP3 inverting input selection
        VM_SEL: u2 = 0,
        /// Timer controlled Mux mode enable
        TCM_EN: u1 = 0,
        /// OPAMP3 inverting input secondary selection
        VMS_SEL: u1 = 0,
        /// OPAMP3 Non inverting input secondary selection
        VPS_SEL: u2 = 0,
        /// Calibration mode enable
        CALON: u1 = 0,
        /// Calibration selection
        CALSEL: u2 = 0,
        /// Gain in PGA mode
        PGA_GAIN: u4 = 0,
        /// User trimming enable
        USER_TRIM: u1 = 0,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5 = 0,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5 = 0,
        /// OPAMP 3 ouput status flag
        OUTCAL: u1 = 0,
        /// OPAMP 3 lock
        LOCK: u1 = 0,
    });

    /// control register
    pub const OPAMP4_CSR = mmio(Address + 0x00000044, 32, packed struct {
        /// OPAMP4 enable
        OPAMP4EN: u1 = 0,
        /// OPAMP4 Non inverting input selection
        VP_SEL: u2 = 0,
        reserved1: u1 = 0,
        /// OPAMP4 inverting input selection
        VM_SEL: u2 = 0,
        /// Timer controlled Mux mode enable
        TCM_EN: u1 = 0,
        /// OPAMP4 inverting input secondary selection
        VMS_SEL: u1 = 0,
        /// OPAMP4 Non inverting input secondary selection
        VPS_SEL: u2 = 0,
        /// Calibration mode enable
        CALON: u1 = 0,
        /// Calibration selection
        CALSEL: u2 = 0,
        /// Gain in PGA mode
        PGA_GAIN: u4 = 0,
        /// User trimming enable
        USER_TRIM: u1 = 0,
        /// Offset trimming value (PMOS)
        TRIMOFFSETP: u5 = 0,
        /// Offset trimming value (NMOS)
        TRIMOFFSETN: u5 = 0,
        /// OPAMP 4 ouput status flag
        OUTCAL: u1 = 0,
        /// OPAMP 4 lock
        LOCK: u1 = 0,
    });
};

/// Flexible memory controller
pub const FMC = extern struct {
    pub const Address: u32 = 0xa0000400;

    /// SRAM/NOR-Flash chip-select control register 1
    pub const BCR1 = mmio(Address + 0x00000000, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select timing register 1
    pub const BTR1 = mmio(Address + 0x00000004, 32, packed struct {
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select control register 2
    pub const BCR2 = mmio(Address + 0x00000008, 32, packed struct {
        reserved1: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select timing register 2
    pub const BTR2 = mmio(Address + 0x0000000c, 32, packed struct {
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select control register 3
    pub const BCR3 = mmio(Address + 0x00000010, 32, packed struct {
        reserved1: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select timing register 3
    pub const BTR3 = mmio(Address + 0x00000014, 32, packed struct {
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select control register 4
    pub const BCR4 = mmio(Address + 0x00000018, 32, packed struct {
        reserved1: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash chip-select timing register 4
    pub const BTR4 = mmio(Address + 0x0000001c, 32, packed struct {
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// PC Card/NAND Flash control register 2
    pub const PCR2 = mmio(Address + 0x00000060, 32, packed struct {
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// FIFO status and interrupt register 2
    pub const SR2 = mmio(Address + 0x00000064, 32, packed struct {
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Common memory space timing register 2
    pub const PMEM2 = mmio(Address + 0x00000068, 32, packed struct {});

    /// Attribute memory space timing register 2
    pub const PATT2 = mmio(Address + 0x0000006c, 32, packed struct {});

    /// ECC result register 2
    pub const ECCR2 = mmio(Address + 0x00000074, 32, packed struct {});

    /// PC Card/NAND Flash control register 3
    pub const PCR3 = mmio(Address + 0x00000080, 32, packed struct {
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// FIFO status and interrupt register 3
    pub const SR3 = mmio(Address + 0x00000084, 32, packed struct {
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Common memory space timing register 3
    pub const PMEM3 = mmio(Address + 0x00000088, 32, packed struct {});

    /// Attribute memory space timing register 3
    pub const PATT3 = mmio(Address + 0x0000008c, 32, packed struct {});

    /// ECC result register 3
    pub const ECCR3 = mmio(Address + 0x00000094, 32, packed struct {});

    /// PC Card/NAND Flash control register 4
    pub const PCR4 = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// FIFO status and interrupt register 4
    pub const SR4 = mmio(Address + 0x000000a4, 32, packed struct {
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Common memory space timing register 4
    pub const PMEM4 = mmio(Address + 0x000000a8, 32, packed struct {});

    /// Attribute memory space timing register 4
    pub const PATT4 = mmio(Address + 0x000000ac, 32, packed struct {});

    /// I/O space timing register 4
    pub const PIO4 = mmio(Address + 0x000000b0, 32, packed struct {});

    /// SRAM/NOR-Flash write timing registers 1
    pub const BWTR1 = mmio(Address + 0x00000104, 32, packed struct {
        /// Bus turnaround phase duration
        BUSTURN: u4 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 2
    pub const BWTR2 = mmio(Address + 0x0000010c, 32, packed struct {
        /// Bus turnaround phase duration
        BUSTURN: u4 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 3
    pub const BWTR3 = mmio(Address + 0x00000114, 32, packed struct {
        /// Bus turnaround phase duration
        BUSTURN: u4 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 4
    pub const BWTR4 = mmio(Address + 0x0000011c, 32, packed struct {
        /// Bus turnaround phase duration
        BUSTURN: u4 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Nested Vectored Interrupt Controller
pub const NVIC = extern struct {
    pub const Address: u32 = 0xe000e100;

    /// Interrupt Set-Enable Register
    pub const ISER0 = mmio(Address + 0x00000000, 32, packed struct {});

    /// Interrupt Set-Enable Register
    pub const ISER1 = mmio(Address + 0x00000004, 32, packed struct {});

    /// Interrupt Set-Enable Register
    pub const ISER2 = mmio(Address + 0x00000008, 32, packed struct {});

    /// Interrupt Clear-Enable Register
    pub const ICER0 = mmio(Address + 0x00000080, 32, packed struct {});

    /// Interrupt Clear-Enable Register
    pub const ICER1 = mmio(Address + 0x00000084, 32, packed struct {});

    /// Interrupt Clear-Enable Register
    pub const ICER2 = mmio(Address + 0x00000088, 32, packed struct {});

    /// Interrupt Set-Pending Register
    pub const ISPR0 = mmio(Address + 0x00000100, 32, packed struct {});

    /// Interrupt Set-Pending Register
    pub const ISPR1 = mmio(Address + 0x00000104, 32, packed struct {});

    /// Interrupt Set-Pending Register
    pub const ISPR2 = mmio(Address + 0x00000108, 32, packed struct {});

    /// Interrupt Clear-Pending Register
    pub const ICPR0 = mmio(Address + 0x00000180, 32, packed struct {});

    /// Interrupt Clear-Pending Register
    pub const ICPR1 = mmio(Address + 0x00000184, 32, packed struct {});

    /// Interrupt Clear-Pending Register
    pub const ICPR2 = mmio(Address + 0x00000188, 32, packed struct {});

    /// Interrupt Active Bit Register
    pub const IABR0 = mmio(Address + 0x00000200, 32, packed struct {});

    /// Interrupt Active Bit Register
    pub const IABR1 = mmio(Address + 0x00000204, 32, packed struct {});

    /// Interrupt Active Bit Register
    pub const IABR2 = mmio(Address + 0x00000208, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR0 = mmio(Address + 0x00000300, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR1 = mmio(Address + 0x00000304, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR2 = mmio(Address + 0x00000308, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR3 = mmio(Address + 0x0000030c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR4 = mmio(Address + 0x00000310, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR5 = mmio(Address + 0x00000314, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR6 = mmio(Address + 0x00000318, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR7 = mmio(Address + 0x0000031c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR8 = mmio(Address + 0x00000320, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR9 = mmio(Address + 0x00000324, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR10 = mmio(Address + 0x00000328, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR11 = mmio(Address + 0x0000032c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR12 = mmio(Address + 0x00000330, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR13 = mmio(Address + 0x00000334, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR14 = mmio(Address + 0x00000338, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR15 = mmio(Address + 0x0000033c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR16 = mmio(Address + 0x00000340, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR17 = mmio(Address + 0x00000344, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR18 = mmio(Address + 0x00000348, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR19 = mmio(Address + 0x0000034c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR20 = mmio(Address + 0x00000350, 32, packed struct {});
};

/// Floting point unit
pub const FPU = extern struct {
    pub const Address: u32 = 0xe000ef34;

    /// Floating-point context control register
    pub const FPCCR = mmio(Address + 0x00000000, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved23: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
    });

    /// Floating-point context address register
    pub const FPCAR = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Location of unpopulated floating-point
        ADDRESS: u29 = 0,
    });

    /// Floating-point status control register
    pub const FPSCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Invalid operation cumulative exception bit
        IOC: u1 = 0,
        /// Division by zero cumulative exception bit.
        DZC: u1 = 0,
        /// Overflow cumulative exception bit
        OFC: u1 = 0,
        /// Underflow cumulative exception bit
        UFC: u1 = 0,
        /// Inexact cumulative exception bit
        IXC: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Input denormal cumulative exception bit.
        IDC: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Rounding Mode control field
        RMode: u2 = 0,
        /// Flush-to-zero mode control bit:
        FZ: u1 = 0,
        /// Default NaN mode control bit
        DN: u1 = 0,
        /// Alternative half-precision control bit
        AHP: u1 = 0,
        reserved17: u1 = 0,
        /// Overflow condition code flag
        V: u1 = 0,
        /// Carry condition code flag
        C: u1 = 0,
        /// Zero condition code flag
        Z: u1 = 0,
        /// Negative condition code flag
        N: u1 = 0,
    });
};

/// Memory protection unit
pub const MPU = extern struct {
    pub const Address: u32 = 0xe000ed90;

    /// MPU type register
    pub const MPU_TYPER = mmio(Address + 0x00000000, 32, packed struct {
        /// Separate flag
        SEPARATE: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Number of MPU data regions
        DREGION: u8 = 0,
        /// Number of MPU instruction regions
        IREGION: u8 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// MPU control register
    pub const MPU_CTRL = mmio(Address + 0x00000004, 32, packed struct {
        /// Enables the MPU
        ENABLE: u1 = 0,
        /// Enables the operation of MPU during hard fault
        HFNMIENA: u1 = 0,
        /// Enable priviliged software access to default memory map
        PRIVDEFENA: u1 = 0,
        padding29: u1 = 0,
        padding28: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// MPU region number register
    pub const MPU_RNR = mmio(Address + 0x00000008, 32, packed struct {
        /// MPU region
        REGION: u8 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// MPU region base address register
    pub const MPU_RBAR = mmio(Address + 0x0000000c, 32, packed struct {
        /// MPU region field
        REGION: u4 = 0,
        /// MPU region number valid
        VALID: u1 = 0,
        /// Region base address field
        ADDR: u27 = 0,
    });

    /// MPU region attribute and size register
    pub const MPU_RASR = mmio(Address + 0x00000010, 32, packed struct {
        /// Region enable bit.
        ENABLE: u1 = 0,
        /// Size of the MPU protection region
        SIZE: u5 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Subregion disable bits
        SRD: u8 = 0,
        /// memory attribute
        B: u1 = 0,
        /// memory attribute
        C: u1 = 0,
        /// Shareable memory attribute
        S: u1 = 0,
        /// memory attribute
        TEX: u3 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Access permission
        AP: u3 = 0,
        reserved5: u1 = 0,
        /// Instruction access disable bit
        XN: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// SysTick timer
pub const STK = extern struct {
    pub const Address: u32 = 0xe000e010;

    /// SysTick control and status register
    pub const CTRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        ENABLE: u1 = 0,
        /// SysTick exception request enable
        TICKINT: u1 = 0,
        /// Clock source selection
        CLKSOURCE: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SysTick reload value register
    pub const LOAD = mmio(Address + 0x00000004, 32, packed struct {
        /// RELOAD value
        RELOAD: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SysTick current value register
    pub const VAL = mmio(Address + 0x00000008, 32, packed struct {
        /// Current counter value
        CURRENT: u24 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SysTick calibration value register
    pub const CALIB = mmio(Address + 0x0000000c, 32, packed struct {
        /// Calibration value
        TENMS: u24 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// SKEW flag: Indicates whether the TENMS value is exact
        SKEW: u1 = 0,
        /// NOREF flag. Reads as zero
        NOREF: u1 = 0,
    });
};

/// System control block
pub const SCB = extern struct {
    pub const Address: u32 = 0xe000ed00;

    /// CPUID base register
    pub const CPUID = mmio(Address + 0x00000000, 32, packed struct {
        /// Revision number
        Revision: u4 = 0,
        /// Part number of the processor
        PartNo: u12 = 0,
        /// Reads as 0xF
        Constant: u4 = 0,
        /// Variant number
        Variant: u4 = 0,
        /// Implementer code
        Implementer: u8 = 0,
    });

    /// Interrupt control and state register
    pub const ICSR = mmio(Address + 0x00000004, 32, packed struct {
        /// Active vector
        VECTACTIVE: u9 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Return to base level
        RETTOBASE: u1 = 0,
        /// Pending vector
        VECTPENDING: u7 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Interrupt pending flag
        ISRPENDING: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// SysTick exception clear-pending bit
        PENDSTCLR: u1 = 0,
        /// SysTick exception set-pending bit
        PENDSTSET: u1 = 0,
        /// PendSV clear-pending bit
        PENDSVCLR: u1 = 0,
        /// PendSV set-pending bit
        PENDSVSET: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        /// NMI set-pending bit.
        NMIPENDSET: u1 = 0,
    });

    /// Vector table offset register
    pub const VTOR = mmio(Address + 0x00000008, 32, packed struct {
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Vector table base offset field
        TBLOFF: u21 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Application interrupt and reset control register
    pub const AIRCR = mmio(Address + 0x0000000c, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        /// Register key
        VECTKEYSTAT: u16 = 0,
    });

    /// System control register
    pub const SCR = mmio(Address + 0x00000010, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        /// Send Event on Pending bit
        SEVEONPEND: u1 = 0,
        padding27: u1 = 0,
        padding26: u1 = 0,
        padding25: u1 = 0,
        padding24: u1 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Configuration and control register
    pub const CCR = mmio(Address + 0x00000014, 32, packed struct {
        /// Configures how the processor enters Thread mode
        NONBASETHRDENA: u1 = 0,
        reserved1: u1 = 0,
        /// UNALIGN_ TRP
        UNALIGN__TRP: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// System handler priority registers
    pub const SHPR1 = mmio(Address + 0x00000018, 32, packed struct {
        /// Priority of system handler 4
        PRI_4: u8 = 0,
        /// Priority of system handler 5
        PRI_5: u8 = 0,
        /// Priority of system handler 6
        PRI_6: u8 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// System handler priority registers
    pub const SHPR2 = mmio(Address + 0x0000001c, 32, packed struct {
        reserved24: u1 = 0,
        reserved23: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Priority of system handler 11
        PRI_11: u8 = 0,
    });

    /// System handler priority registers
    pub const SHPR3 = mmio(Address + 0x00000020, 32, packed struct {
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Priority of system handler 14
        PRI_14: u8 = 0,
        /// Priority of system handler 15
        PRI_15: u8 = 0,
    });

    /// System handler control and state register
    pub const SHCRS = mmio(Address + 0x00000024, 32, packed struct {
        /// Memory management fault exception active bit
        MEMFAULTACT: u1 = 0,
        /// Bus fault exception active bit
        BUSFAULTACT: u1 = 0,
        reserved1: u1 = 0,
        /// Usage fault exception active bit
        USGFAULTACT: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// SVC call active bit
        SVCALLACT: u1 = 0,
        /// Debug monitor active bit
        MONITORACT: u1 = 0,
        reserved5: u1 = 0,
        /// PendSV exception active bit
        PENDSVACT: u1 = 0,
        /// SysTick exception active bit
        SYSTICKACT: u1 = 0,
        /// Usage fault exception pending bit
        USGFAULTPENDED: u1 = 0,
        /// Memory management fault exception pending bit
        MEMFAULTPENDED: u1 = 0,
        /// Bus fault exception pending bit
        BUSFAULTPENDED: u1 = 0,
        /// SVC call pending bit
        SVCALLPENDED: u1 = 0,
        /// Memory management fault enable bit
        MEMFAULTENA: u1 = 0,
        /// Bus fault enable bit
        BUSFAULTENA: u1 = 0,
        /// Usage fault enable bit
        USGFAULTENA: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Configurable fault status register
    pub const CFSR_UFSR_BFSR_MMFSR = mmio(Address + 0x00000028, 32, packed struct {
        reserved1: u1 = 0,
        /// Instruction access violation flag
        IACCVIOL: u1 = 0,
        reserved2: u1 = 0,
        /// Memory manager fault on unstacking for a return from exception
        MUNSTKERR: u1 = 0,
        /// Memory manager fault on stacking for exception entry.
        MSTKERR: u1 = 0,
        reserved3: u1 = 0,
        /// Memory Management Fault Address Register (MMAR) valid flag
        MMARVALID: u1 = 0,
        /// Instruction bus error
        IBUSERR: u1 = 0,
        /// Precise data bus error
        PRECISERR: u1 = 0,
        /// Imprecise data bus error
        IMPRECISERR: u1 = 0,
        /// Bus fault on unstacking for a return from exception
        UNSTKERR: u1 = 0,
        /// Bus fault on stacking for exception entry
        STKERR: u1 = 0,
        /// Bus fault on floating-point lazy state preservation
        LSPERR: u1 = 0,
        reserved4: u1 = 0,
        /// Bus Fault Address Register (BFAR) valid flag
        BFARVALID: u1 = 0,
        /// Undefined instruction usage fault
        UNDEFINSTR: u1 = 0,
        /// Invalid state usage fault
        INVSTATE: u1 = 0,
        /// Invalid PC load usage fault
        INVPC: u1 = 0,
        /// No coprocessor usage fault.
        NOCP: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Unaligned access usage fault
        UNALIGNED: u1 = 0,
        /// Divide by zero usage fault
        DIVBYZERO: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Hard fault status register
    pub const HFSR = mmio(Address + 0x0000002c, 32, packed struct {
        reserved1: u1 = 0,
        /// Vector table hard fault
        VECTTBL: u1 = 0,
        reserved29: u1 = 0,
        reserved28: u1 = 0,
        reserved27: u1 = 0,
        reserved26: u1 = 0,
        reserved25: u1 = 0,
        reserved24: u1 = 0,
        reserved23: u1 = 0,
        reserved22: u1 = 0,
        reserved21: u1 = 0,
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// Forced hard fault
        FORCED: u1 = 0,
        /// Reserved for Debug use
        DEBUG_VT: u1 = 0,
    });

    /// Memory management fault address register
    pub const MMFAR = @intToPtr(*volatile u32, Address + 0x00000034);

    /// Bus fault address register
    pub const BFAR = @intToPtr(*volatile u32, Address + 0x00000038);

    /// Auxiliary fault status register
    pub const AFSR = mmio(Address + 0x0000003c, 32, packed struct {
        /// Implementation defined
        IMPDEF: u32 = 0,
    });
};

/// Nested vectored interrupt controller
pub const NVIC_STIR = extern struct {
    pub const Address: u32 = 0xe000ef00;

    /// Software trigger interrupt register
    pub const STIR = mmio(Address + 0x00000000, 32, packed struct {
        /// Software generated interrupt ID
        INTID: u9 = 0,
        padding23: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Floating point unit CPACR
pub const FPU_CPACR = extern struct {
    pub const Address: u32 = 0xe000ed88;

    /// Coprocessor access control register
    pub const CPACR = mmio(Address + 0x00000000, 32, packed struct {
        reserved20: u1 = 0,
        reserved19: u1 = 0,
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        reserved15: u1 = 0,
        reserved14: u1 = 0,
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// System control block ACTLR
pub const SCB_ACTRL = extern struct {
    pub const Address: u32 = 0xe000e008;

    /// Auxiliary control register
    pub const ACTRL = mmio(Address + 0x00000000, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding22: u1 = 0,
        padding21: u1 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

const std = @import("std");
const root = @import("root");
const cpu = @import("cpu");
const config = @import("microzig-config");
const InterruptVector = extern union {
    C: fn () callconv(.C) void,
    Naked: fn () callconv(.Naked) void,
    // Interrupt is not supported on arm
};

fn makeUnhandledHandler(comptime str: []const u8) InterruptVector {
    return InterruptVector{
        .C = struct {
            fn unhandledInterrupt() callconv(.C) noreturn {
                @panic("unhandled interrupt: " ++ str);
            }
        }.unhandledInterrupt,
    };
}

pub const VectorTable = extern struct {
    initial_stack_pointer: u32 = config.end_of_stack,
    Reset: InterruptVector = InterruptVector{ .C = cpu.startup_logic._start },
    NMI: InterruptVector = makeUnhandledHandler("NMI"),
    HardFault: InterruptVector = makeUnhandledHandler("HardFault"),
    MemManage: InterruptVector = makeUnhandledHandler("MemManage"),
    BusFault: InterruptVector = makeUnhandledHandler("BusFault"),
    UsageFault: InterruptVector = makeUnhandledHandler("UsageFault"),

    reserved: [4]u32 = .{ 0, 0, 0, 0 },
    SVCall: InterruptVector = makeUnhandledHandler("SVCall"),
    DebugMonitor: InterruptVector = makeUnhandledHandler("DebugMonitor"),
    reserved1: u32 = 0,

    PendSV: InterruptVector = makeUnhandledHandler("PendSV"),
    SysTick: InterruptVector = makeUnhandledHandler("SysTick"),

    /// Window Watchdog interrupt
    WWDG: InterruptVector = makeUnhandledHandler("WWDG"),
    /// PVD through EXTI line detection interrupt
    PVD: InterruptVector = makeUnhandledHandler("PVD"),
    /// Tamper and TimeStamp interrupts
    TAMP_STAMP: InterruptVector = makeUnhandledHandler("TAMP_STAMP"),
    /// RTC Wakeup interrupt through the EXTI line
    RTC_WKUP: InterruptVector = makeUnhandledHandler("RTC_WKUP"),
    /// Flash global interrupt
    FLASH: InterruptVector = makeUnhandledHandler("FLASH"),
    /// RCC global interrupt
    RCC: InterruptVector = makeUnhandledHandler("RCC"),
    /// EXTI Line0 interrupt
    EXTI0: InterruptVector = makeUnhandledHandler("EXTI0"),
    /// EXTI Line3 interrupt
    EXTI1: InterruptVector = makeUnhandledHandler("EXTI1"),
    /// EXTI Line2 and Touch sensing interrupts
    EXTI2_TSC: InterruptVector = makeUnhandledHandler("EXTI2_TSC"),
    /// EXTI Line3 interrupt
    EXTI3: InterruptVector = makeUnhandledHandler("EXTI3"),
    /// EXTI Line4 interrupt
    EXTI4: InterruptVector = makeUnhandledHandler("EXTI4"),
    /// DMA1 channel 1 interrupt
    DMA1_CH1: InterruptVector = makeUnhandledHandler("DMA1_CH1"),
    /// DMA1 channel 2 interrupt
    DMA1_CH2: InterruptVector = makeUnhandledHandler("DMA1_CH2"),
    /// DMA1 channel 3 interrupt
    DMA1_CH3: InterruptVector = makeUnhandledHandler("DMA1_CH3"),
    /// DMA1 channel 4 interrupt
    DMA1_CH4: InterruptVector = makeUnhandledHandler("DMA1_CH4"),
    /// DMA1 channel 5 interrupt
    DMA1_CH5: InterruptVector = makeUnhandledHandler("DMA1_CH5"),
    /// DMA1 channel 6 interrupt
    DMA1_CH6: InterruptVector = makeUnhandledHandler("DMA1_CH6"),
    /// DMA1 channel 7interrupt
    DMA1_CH7: InterruptVector = makeUnhandledHandler("DMA1_CH7"),
    /// ADC1 and ADC2 global interrupt
    ADC1_2: InterruptVector = makeUnhandledHandler("ADC1_2"),
    /// USB High Priority/CAN_TX interrupts
    USB_HP_CAN_TX: InterruptVector = makeUnhandledHandler("USB_HP_CAN_TX"),
    /// USB Low Priority/CAN_RX0 interrupts
    USB_LP_CAN_RX0: InterruptVector = makeUnhandledHandler("USB_LP_CAN_RX0"),
    /// CAN_RX1 interrupt
    CAN_RX1: InterruptVector = makeUnhandledHandler("CAN_RX1"),
    /// CAN_SCE interrupt
    CAN_SCE: InterruptVector = makeUnhandledHandler("CAN_SCE"),
    /// EXTI Line5 to Line9 interrupts
    EXTI9_5: InterruptVector = makeUnhandledHandler("EXTI9_5"),
    /// TIM1 Break/TIM15 global interruts
    TIM1_BRK_TIM15: InterruptVector = makeUnhandledHandler("TIM1_BRK_TIM15"),
    /// TIM1 Update/TIM16 global interrupts
    TIM1_UP_TIM16: InterruptVector = makeUnhandledHandler("TIM1_UP_TIM16"),
    /// TIM1 trigger and commutation/TIM17 interrupts
    TIM1_TRG_COM_TIM17: InterruptVector = makeUnhandledHandler("TIM1_TRG_COM_TIM17"),
    /// TIM1 capture compare interrupt
    TIM1_CC: InterruptVector = makeUnhandledHandler("TIM1_CC"),
    /// TIM2 global interrupt
    TIM2: InterruptVector = makeUnhandledHandler("TIM2"),
    /// TIM3 global interrupt
    TIM3: InterruptVector = makeUnhandledHandler("TIM3"),
    /// TIM4 global interrupt
    TIM4: InterruptVector = makeUnhandledHandler("TIM4"),
    /// I2C1 event interrupt and EXTI Line23 interrupt
    I2C1_EV_EXTI23: InterruptVector = makeUnhandledHandler("I2C1_EV_EXTI23"),
    /// I2C1 error interrupt
    I2C1_ER: InterruptVector = makeUnhandledHandler("I2C1_ER"),
    /// I2C2 event interrupt & EXTI Line24 interrupt
    I2C2_EV_EXTI24: InterruptVector = makeUnhandledHandler("I2C2_EV_EXTI24"),
    /// I2C2 error interrupt
    I2C2_ER: InterruptVector = makeUnhandledHandler("I2C2_ER"),
    /// SPI1 global interrupt
    SPI1: InterruptVector = makeUnhandledHandler("SPI1"),
    /// SPI2 global interrupt
    SPI2: InterruptVector = makeUnhandledHandler("SPI2"),
    /// USART1 global interrupt and EXTI Line 25 interrupt
    USART1_EXTI25: InterruptVector = makeUnhandledHandler("USART1_EXTI25"),
    /// USART2 global interrupt and EXTI Line 26 interrupt
    USART2_EXTI26: InterruptVector = makeUnhandledHandler("USART2_EXTI26"),
    /// USART3 global interrupt and EXTI Line 28 interrupt
    USART3_EXTI28: InterruptVector = makeUnhandledHandler("USART3_EXTI28"),
    /// EXTI Line15 to Line10 interrupts
    EXTI15_10: InterruptVector = makeUnhandledHandler("EXTI15_10"),
    /// RTC alarm interrupt
    RTCAlarm: InterruptVector = makeUnhandledHandler("RTCAlarm"),
    /// USB wakeup from Suspend
    USB_WKUP: InterruptVector = makeUnhandledHandler("USB_WKUP"),
    /// TIM8 break interrupt
    TIM8_BRK: InterruptVector = makeUnhandledHandler("TIM8_BRK"),
    /// TIM8 update interrupt
    TIM8_UP: InterruptVector = makeUnhandledHandler("TIM8_UP"),
    /// TIM8 Trigger and commutation interrupts
    TIM8_TRG_COM: InterruptVector = makeUnhandledHandler("TIM8_TRG_COM"),
    /// TIM8 capture compare interrupt
    TIM8_CC: InterruptVector = makeUnhandledHandler("TIM8_CC"),
    /// ADC3 global interrupt
    ADC3: InterruptVector = makeUnhandledHandler("ADC3"),
    /// FSMC global interrupt
    FMC: InterruptVector = makeUnhandledHandler("FMC"),
    reserved2: u32 = 0,
    reserved3: u32 = 0,
    /// SPI3 global interrupt
    SPI3: InterruptVector = makeUnhandledHandler("SPI3"),
    /// UART4 global and EXTI Line 34 interrupts
    UART4_EXTI34: InterruptVector = makeUnhandledHandler("UART4_EXTI34"),
    /// UART5 global and EXTI Line 35 interrupts
    UART5_EXTI35: InterruptVector = makeUnhandledHandler("UART5_EXTI35"),
    /// TIM6 global and DAC12 underrun interrupts
    TIM6_DACUNDER: InterruptVector = makeUnhandledHandler("TIM6_DACUNDER"),
    /// TIM7 global interrupt
    TIM7: InterruptVector = makeUnhandledHandler("TIM7"),
    /// DMA2 channel1 global interrupt
    DMA2_CH1: InterruptVector = makeUnhandledHandler("DMA2_CH1"),
    /// DMA2 channel2 global interrupt
    DMA2_CH2: InterruptVector = makeUnhandledHandler("DMA2_CH2"),
    /// DMA2 channel3 global interrupt
    DMA2_CH3: InterruptVector = makeUnhandledHandler("DMA2_CH3"),
    /// DMA2 channel4 global interrupt
    DMA2_CH4: InterruptVector = makeUnhandledHandler("DMA2_CH4"),
    /// DMA2 channel5 global interrupt
    DMA2_CH5: InterruptVector = makeUnhandledHandler("DMA2_CH5"),
    /// ADC4 global interrupt
    ADC4: InterruptVector = makeUnhandledHandler("ADC4"),
    reserved4: u32 = 0,
    reserved5: u32 = 0,
    /// COMP1 & COMP2 & COMP3 interrupts combined with EXTI Lines 21, 22 and 29
    /// interrupts
    COMP123: InterruptVector = makeUnhandledHandler("COMP123"),
    /// COMP4 & COMP5 & COMP6 interrupts combined with EXTI Lines 30, 31 and 32
    /// interrupts
    COMP456: InterruptVector = makeUnhandledHandler("COMP456"),
    /// COMP7 interrupt combined with EXTI Line 33 interrupt
    COMP7: InterruptVector = makeUnhandledHandler("COMP7"),
    reserved6: u32 = 0,
    reserved7: u32 = 0,
    reserved8: u32 = 0,
    reserved9: u32 = 0,
    reserved10: u32 = 0,
    /// I2C3 Event interrupt
    I2C3_EV: InterruptVector = makeUnhandledHandler("I2C3_EV"),
    /// I2C3 Error interrupt
    I2C3_ER: InterruptVector = makeUnhandledHandler("I2C3_ER"),
    /// USB High priority interrupt
    USB_HP: InterruptVector = makeUnhandledHandler("USB_HP"),
    /// USB Low priority interrupt
    USB_LP: InterruptVector = makeUnhandledHandler("USB_LP"),
    /// USB wakeup from Suspend and EXTI Line 18
    USB_WKUP_EXTI: InterruptVector = makeUnhandledHandler("USB_WKUP_EXTI"),
    /// TIM20 Break interrupt
    TIM20_BRK: InterruptVector = makeUnhandledHandler("TIM20_BRK"),
    /// TIM20 Upgrade interrupt
    TIM20_UP: InterruptVector = makeUnhandledHandler("TIM20_UP"),
    /// TIM20 Trigger and Commutation interrupt
    TIM20_TRG_COM: InterruptVector = makeUnhandledHandler("TIM20_TRG_COM"),
    /// TIM20 Capture Compare interrupt
    TIM20_CC: InterruptVector = makeUnhandledHandler("TIM20_CC"),
    /// Floating point unit interrupt; Floating point interrupt
    FPU: InterruptVector = makeUnhandledHandler("FPU"),
    reserved11: u32 = 0,
    reserved12: u32 = 0,
    /// SPI4 Global interrupt
    SPI4: InterruptVector = makeUnhandledHandler("SPI4"),
};

fn isValidField(field_name: []const u8) bool {
    return !std.mem.startsWith(u8, field_name, "reserved") and
        !std.mem.eql(u8, field_name, "initial_stack_pointer") and
        !std.mem.eql(u8, field_name, "reset");
}

export const vectors: VectorTable linksection("microzig_flash_start") = blk: {
    var temp: VectorTable = .{};
    if (@hasDecl(root, "vector_table")) {
        const vector_table = root.vector_table;
        if (@typeInfo(vector_table) != .Struct)
            @compileLog("root.vector_table must be a struct");

        inline for (@typeInfo(vector_table).Struct.decls) |decl| {
            const calling_convention = @typeInfo(@TypeOf(@field(vector_table, decl.name))).Fn.calling_convention;
            const handler = @field(vector_table, decl.name);

            if (!@hasField(VectorTable, decl.name)) {
                var msg: []const u8 = "There is no such interrupt as '" ++ decl.name ++ "', declarations in 'root.vector_table' must be one of:\n";
                inline for (std.meta.fields(VectorTable)) |field| {
                    if (isValidField(field.name)) {
                        msg = msg ++ "    " ++ field.name ++ "\n";
                    }
                }

                @compileError(msg);
            }

            if (!isValidField(decl.name))
                @compileError("You are not allowed to specify '" ++ decl.name ++ "' in the vector table, for your sins you must now pay a $5 fine to the ZSF: https://github.com/sponsors/ziglang");

            @field(temp, decl.name) = switch (calling_convention) {
                .C => .{ .C = handler },
                .Naked => .{ .Naked = handler },
                // for unspecified calling convention we are going to generate small wrapper
                .Unspecified => .{
                    .C = struct {
                        fn wrapper() callconv(.C) void {
                            if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                                @call(.{ .modifier = .always_inline }, handler, .{});
                        }
                    }.wrapper,
                },

                else => @compileError("unsupported calling convention for function " ++ decl.name),
            };
        }
    }
    break :blk temp;
};
