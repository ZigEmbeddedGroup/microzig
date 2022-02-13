// generated using svd2zig.py
// DO NOT EDIT
// based on STM32F303 version 1.4
const mmio = @import("microzig-mmio").mmio;
const Name = "STM32F303";
pub const GPIOA = extern struct {
    pub const Address: u32 = 0x48000000;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OT1: u1, // bit offset: 1 desc: Port x configuration bits (y = 0..15)
        OT2: u1, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OT3: u1, // bit offset: 3 desc: Port x configuration bits (y = 0..15)
        OT4: u1, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OT5: u1, // bit offset: 5 desc: Port x configuration bits (y = 0..15)
        OT6: u1, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OT7: u1, // bit offset: 7 desc: Port x configuration bits (y = 0..15)
        OT8: u1, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OT9: u1, // bit offset: 9 desc: Port x configuration bits (y = 0..15)
        OT10: u1, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OT11: u1, // bit offset: 11 desc: Port x configuration bits (y = 0..15)
        OT12: u1, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OT13: u1, // bit offset: 13 desc: Port x configuration bits (y = 0..15)
        OT14: u1, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OT15: u1, // bit offset: 15 desc: Port x configuration bits (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOB = extern struct {
    pub const Address: u32 = 0x48000400;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOC = extern struct {
    pub const Address: u32 = 0x48000800;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOD = extern struct {
    pub const Address: u32 = 0x48000c00;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOE = extern struct {
    pub const Address: u32 = 0x48001000;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOF = extern struct {
    pub const Address: u32 = 0x48001400;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOG = extern struct {
    pub const Address: u32 = 0x48001800;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const GPIOH = extern struct {
    pub const Address: u32 = 0x48001c00;
    // byte offset: 0 GPIO port mode register
    pub const MODER = mmio(Address + 0x00000000, 32, packed struct {
        MODER0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        MODER1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        MODER2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        MODER3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        MODER4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        MODER5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        MODER6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        MODER7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        MODER8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        MODER9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        MODER10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        MODER11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        MODER12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        MODER13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        MODER14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        MODER15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 4 GPIO port output type register
    pub const OTYPER = mmio(Address + 0x00000004, 32, packed struct {
        OT0: u1, // bit offset: 0 desc: Port x configuration bit 0
        OT1: u1, // bit offset: 1 desc: Port x configuration bit 1
        OT2: u1, // bit offset: 2 desc: Port x configuration bit 2
        OT3: u1, // bit offset: 3 desc: Port x configuration bit 3
        OT4: u1, // bit offset: 4 desc: Port x configuration bit 4
        OT5: u1, // bit offset: 5 desc: Port x configuration bit 5
        OT6: u1, // bit offset: 6 desc: Port x configuration bit 6
        OT7: u1, // bit offset: 7 desc: Port x configuration bit 7
        OT8: u1, // bit offset: 8 desc: Port x configuration bit 8
        OT9: u1, // bit offset: 9 desc: Port x configuration bit 9
        OT10: u1, // bit offset: 10 desc: Port x configuration bit 10
        OT11: u1, // bit offset: 11 desc: Port x configuration bit 11
        OT12: u1, // bit offset: 12 desc: Port x configuration bit 12
        OT13: u1, // bit offset: 13 desc: Port x configuration bit 13
        OT14: u1, // bit offset: 14 desc: Port x configuration bit 14
        OT15: u1, // bit offset: 15 desc: Port x configuration bit 15
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 GPIO port output speed register
    pub const OSPEEDR = mmio(Address + 0x00000008, 32, packed struct {
        OSPEEDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        OSPEEDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        OSPEEDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        OSPEEDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        OSPEEDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        OSPEEDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        OSPEEDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        OSPEEDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        OSPEEDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        OSPEEDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        OSPEEDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        OSPEEDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        OSPEEDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        OSPEEDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        OSPEEDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        OSPEEDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 12 GPIO port pull-up/pull-down register
    pub const PUPDR = mmio(Address + 0x0000000c, 32, packed struct {
        PUPDR0: u2, // bit offset: 0 desc: Port x configuration bits (y = 0..15)
        PUPDR1: u2, // bit offset: 2 desc: Port x configuration bits (y = 0..15)
        PUPDR2: u2, // bit offset: 4 desc: Port x configuration bits (y = 0..15)
        PUPDR3: u2, // bit offset: 6 desc: Port x configuration bits (y = 0..15)
        PUPDR4: u2, // bit offset: 8 desc: Port x configuration bits (y = 0..15)
        PUPDR5: u2, // bit offset: 10 desc: Port x configuration bits (y = 0..15)
        PUPDR6: u2, // bit offset: 12 desc: Port x configuration bits (y = 0..15)
        PUPDR7: u2, // bit offset: 14 desc: Port x configuration bits (y = 0..15)
        PUPDR8: u2, // bit offset: 16 desc: Port x configuration bits (y = 0..15)
        PUPDR9: u2, // bit offset: 18 desc: Port x configuration bits (y = 0..15)
        PUPDR10: u2, // bit offset: 20 desc: Port x configuration bits (y = 0..15)
        PUPDR11: u2, // bit offset: 22 desc: Port x configuration bits (y = 0..15)
        PUPDR12: u2, // bit offset: 24 desc: Port x configuration bits (y = 0..15)
        PUPDR13: u2, // bit offset: 26 desc: Port x configuration bits (y = 0..15)
        PUPDR14: u2, // bit offset: 28 desc: Port x configuration bits (y = 0..15)
        PUPDR15: u2, // bit offset: 30 desc: Port x configuration bits (y = 0..15)
    });
    // byte offset: 16 GPIO port input data register
    pub const IDR = mmio(Address + 0x00000010, 32, packed struct {
        IDR0: u1, // bit offset: 0 desc: Port input data (y = 0..15)
        IDR1: u1, // bit offset: 1 desc: Port input data (y = 0..15)
        IDR2: u1, // bit offset: 2 desc: Port input data (y = 0..15)
        IDR3: u1, // bit offset: 3 desc: Port input data (y = 0..15)
        IDR4: u1, // bit offset: 4 desc: Port input data (y = 0..15)
        IDR5: u1, // bit offset: 5 desc: Port input data (y = 0..15)
        IDR6: u1, // bit offset: 6 desc: Port input data (y = 0..15)
        IDR7: u1, // bit offset: 7 desc: Port input data (y = 0..15)
        IDR8: u1, // bit offset: 8 desc: Port input data (y = 0..15)
        IDR9: u1, // bit offset: 9 desc: Port input data (y = 0..15)
        IDR10: u1, // bit offset: 10 desc: Port input data (y = 0..15)
        IDR11: u1, // bit offset: 11 desc: Port input data (y = 0..15)
        IDR12: u1, // bit offset: 12 desc: Port input data (y = 0..15)
        IDR13: u1, // bit offset: 13 desc: Port input data (y = 0..15)
        IDR14: u1, // bit offset: 14 desc: Port input data (y = 0..15)
        IDR15: u1, // bit offset: 15 desc: Port input data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 GPIO port output data register
    pub const ODR = mmio(Address + 0x00000014, 32, packed struct {
        ODR0: u1, // bit offset: 0 desc: Port output data (y = 0..15)
        ODR1: u1, // bit offset: 1 desc: Port output data (y = 0..15)
        ODR2: u1, // bit offset: 2 desc: Port output data (y = 0..15)
        ODR3: u1, // bit offset: 3 desc: Port output data (y = 0..15)
        ODR4: u1, // bit offset: 4 desc: Port output data (y = 0..15)
        ODR5: u1, // bit offset: 5 desc: Port output data (y = 0..15)
        ODR6: u1, // bit offset: 6 desc: Port output data (y = 0..15)
        ODR7: u1, // bit offset: 7 desc: Port output data (y = 0..15)
        ODR8: u1, // bit offset: 8 desc: Port output data (y = 0..15)
        ODR9: u1, // bit offset: 9 desc: Port output data (y = 0..15)
        ODR10: u1, // bit offset: 10 desc: Port output data (y = 0..15)
        ODR11: u1, // bit offset: 11 desc: Port output data (y = 0..15)
        ODR12: u1, // bit offset: 12 desc: Port output data (y = 0..15)
        ODR13: u1, // bit offset: 13 desc: Port output data (y = 0..15)
        ODR14: u1, // bit offset: 14 desc: Port output data (y = 0..15)
        ODR15: u1, // bit offset: 15 desc: Port output data (y = 0..15)
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 GPIO port bit set/reset register
    pub const BSRR = mmio(Address + 0x00000018, 32, packed struct {
        BS0: u1, // bit offset: 0 desc: Port x set bit y (y= 0..15)
        BS1: u1, // bit offset: 1 desc: Port x set bit y (y= 0..15)
        BS2: u1, // bit offset: 2 desc: Port x set bit y (y= 0..15)
        BS3: u1, // bit offset: 3 desc: Port x set bit y (y= 0..15)
        BS4: u1, // bit offset: 4 desc: Port x set bit y (y= 0..15)
        BS5: u1, // bit offset: 5 desc: Port x set bit y (y= 0..15)
        BS6: u1, // bit offset: 6 desc: Port x set bit y (y= 0..15)
        BS7: u1, // bit offset: 7 desc: Port x set bit y (y= 0..15)
        BS8: u1, // bit offset: 8 desc: Port x set bit y (y= 0..15)
        BS9: u1, // bit offset: 9 desc: Port x set bit y (y= 0..15)
        BS10: u1, // bit offset: 10 desc: Port x set bit y (y= 0..15)
        BS11: u1, // bit offset: 11 desc: Port x set bit y (y= 0..15)
        BS12: u1, // bit offset: 12 desc: Port x set bit y (y= 0..15)
        BS13: u1, // bit offset: 13 desc: Port x set bit y (y= 0..15)
        BS14: u1, // bit offset: 14 desc: Port x set bit y (y= 0..15)
        BS15: u1, // bit offset: 15 desc: Port x set bit y (y= 0..15)
        BR0: u1, // bit offset: 16 desc: Port x set bit y (y= 0..15)
        BR1: u1, // bit offset: 17 desc: Port x reset bit y (y = 0..15)
        BR2: u1, // bit offset: 18 desc: Port x reset bit y (y = 0..15)
        BR3: u1, // bit offset: 19 desc: Port x reset bit y (y = 0..15)
        BR4: u1, // bit offset: 20 desc: Port x reset bit y (y = 0..15)
        BR5: u1, // bit offset: 21 desc: Port x reset bit y (y = 0..15)
        BR6: u1, // bit offset: 22 desc: Port x reset bit y (y = 0..15)
        BR7: u1, // bit offset: 23 desc: Port x reset bit y (y = 0..15)
        BR8: u1, // bit offset: 24 desc: Port x reset bit y (y = 0..15)
        BR9: u1, // bit offset: 25 desc: Port x reset bit y (y = 0..15)
        BR10: u1, // bit offset: 26 desc: Port x reset bit y (y = 0..15)
        BR11: u1, // bit offset: 27 desc: Port x reset bit y (y = 0..15)
        BR12: u1, // bit offset: 28 desc: Port x reset bit y (y = 0..15)
        BR13: u1, // bit offset: 29 desc: Port x reset bit y (y = 0..15)
        BR14: u1, // bit offset: 30 desc: Port x reset bit y (y = 0..15)
        BR15: u1, // bit offset: 31 desc: Port x reset bit y (y = 0..15)
    });
    // byte offset: 28 GPIO port configuration lock register
    pub const LCKR = mmio(Address + 0x0000001c, 32, packed struct {
        LCK0: u1, // bit offset: 0 desc: Port x lock bit y (y= 0..15)
        LCK1: u1, // bit offset: 1 desc: Port x lock bit y (y= 0..15)
        LCK2: u1, // bit offset: 2 desc: Port x lock bit y (y= 0..15)
        LCK3: u1, // bit offset: 3 desc: Port x lock bit y (y= 0..15)
        LCK4: u1, // bit offset: 4 desc: Port x lock bit y (y= 0..15)
        LCK5: u1, // bit offset: 5 desc: Port x lock bit y (y= 0..15)
        LCK6: u1, // bit offset: 6 desc: Port x lock bit y (y= 0..15)
        LCK7: u1, // bit offset: 7 desc: Port x lock bit y (y= 0..15)
        LCK8: u1, // bit offset: 8 desc: Port x lock bit y (y= 0..15)
        LCK9: u1, // bit offset: 9 desc: Port x lock bit y (y= 0..15)
        LCK10: u1, // bit offset: 10 desc: Port x lock bit y (y= 0..15)
        LCK11: u1, // bit offset: 11 desc: Port x lock bit y (y= 0..15)
        LCK12: u1, // bit offset: 12 desc: Port x lock bit y (y= 0..15)
        LCK13: u1, // bit offset: 13 desc: Port x lock bit y (y= 0..15)
        LCK14: u1, // bit offset: 14 desc: Port x lock bit y (y= 0..15)
        LCK15: u1, // bit offset: 15 desc: Port x lock bit y (y= 0..15)
        LCKK: u1, // bit offset: 16 desc: Lok Key
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 GPIO alternate function low register
    pub const AFRL = mmio(Address + 0x00000020, 32, packed struct {
        AFRL0: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL1: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL2: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL3: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL4: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL5: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL6: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 0..7)
        AFRL7: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 0..7)
    });
    // byte offset: 36 GPIO alternate function high register
    pub const AFRH = mmio(Address + 0x00000024, 32, packed struct {
        AFRH8: u4, // bit offset: 0 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH9: u4, // bit offset: 4 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH10: u4, // bit offset: 8 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH11: u4, // bit offset: 12 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH12: u4, // bit offset: 16 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH13: u4, // bit offset: 20 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH14: u4, // bit offset: 24 desc: Alternate function selection for port x bit y (y = 8..15)
        AFRH15: u4, // bit offset: 28 desc: Alternate function selection for port x bit y (y = 8..15)
    });
    // byte offset: 40 Port bit reset register
    pub const BRR = mmio(Address + 0x00000028, 32, packed struct {
        BR0: u1, // bit offset: 0 desc: Port x Reset bit y
        BR1: u1, // bit offset: 1 desc: Port x Reset bit y
        BR2: u1, // bit offset: 2 desc: Port x Reset bit y
        BR3: u1, // bit offset: 3 desc: Port x Reset bit y
        BR4: u1, // bit offset: 4 desc: Port x Reset bit y
        BR5: u1, // bit offset: 5 desc: Port x Reset bit y
        BR6: u1, // bit offset: 6 desc: Port x Reset bit y
        BR7: u1, // bit offset: 7 desc: Port x Reset bit y
        BR8: u1, // bit offset: 8 desc: Port x Reset bit y
        BR9: u1, // bit offset: 9 desc: Port x Reset bit y
        BR10: u1, // bit offset: 10 desc: Port x Reset bit y
        BR11: u1, // bit offset: 11 desc: Port x Reset bit y
        BR12: u1, // bit offset: 12 desc: Port x Reset bit y
        BR13: u1, // bit offset: 13 desc: Port x Reset bit y
        BR14: u1, // bit offset: 14 desc: Port x Reset bit y
        BR15: u1, // bit offset: 15 desc: Port x Reset bit y
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TSC = extern struct {
    pub const Address: u32 = 0x40024000;
    // byte offset: 0 control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        TSCE: u1, // bit offset: 0 desc: Touch sensing controller enable
        START: u1, // bit offset: 1 desc: Start a new acquisition
        AM: u1, // bit offset: 2 desc: Acquisition mode
        SYNCPOL: u1, // bit offset: 3 desc: Synchronization pin polarity
        IODEF: u1, // bit offset: 4 desc: I/O Default mode
        MCV: u3, // bit offset: 5 desc: Max count value
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PGPSC: u3, // bit offset: 12 desc: pulse generator prescaler
        SSPSC: u1, // bit offset: 15 desc: Spread spectrum prescaler
        SSE: u1, // bit offset: 16 desc: Spread spectrum enable
        SSD: u7, // bit offset: 17 desc: Spread spectrum deviation
        CTPL: u4, // bit offset: 24 desc: Charge transfer pulse low
        CTPH: u4, // bit offset: 28 desc: Charge transfer pulse high
    });
    // byte offset: 4 interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        EOAIE: u1, // bit offset: 0 desc: End of acquisition interrupt enable
        MCEIE: u1, // bit offset: 1 desc: Max count error interrupt enable
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
    // byte offset: 8 interrupt clear register
    pub const ICR = mmio(Address + 0x00000008, 32, packed struct {
        EOAIC: u1, // bit offset: 0 desc: End of acquisition interrupt clear
        MCEIC: u1, // bit offset: 1 desc: Max count error interrupt clear
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
    // byte offset: 12 interrupt status register
    pub const ISR = mmio(Address + 0x0000000c, 32, packed struct {
        EOAF: u1, // bit offset: 0 desc: End of acquisition flag
        MCEF: u1, // bit offset: 1 desc: Max count error flag
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
    // byte offset: 16 I/O hysteresis control register
    pub const IOHCR = mmio(Address + 0x00000010, 32, packed struct {
        G1_IO1: u1, // bit offset: 0 desc: G1_IO1 Schmitt trigger hysteresis mode
        G1_IO2: u1, // bit offset: 1 desc: G1_IO2 Schmitt trigger hysteresis mode
        G1_IO3: u1, // bit offset: 2 desc: G1_IO3 Schmitt trigger hysteresis mode
        G1_IO4: u1, // bit offset: 3 desc: G1_IO4 Schmitt trigger hysteresis mode
        G2_IO1: u1, // bit offset: 4 desc: G2_IO1 Schmitt trigger hysteresis mode
        G2_IO2: u1, // bit offset: 5 desc: G2_IO2 Schmitt trigger hysteresis mode
        G2_IO3: u1, // bit offset: 6 desc: G2_IO3 Schmitt trigger hysteresis mode
        G2_IO4: u1, // bit offset: 7 desc: G2_IO4 Schmitt trigger hysteresis mode
        G3_IO1: u1, // bit offset: 8 desc: G3_IO1 Schmitt trigger hysteresis mode
        G3_IO2: u1, // bit offset: 9 desc: G3_IO2 Schmitt trigger hysteresis mode
        G3_IO3: u1, // bit offset: 10 desc: G3_IO3 Schmitt trigger hysteresis mode
        G3_IO4: u1, // bit offset: 11 desc: G3_IO4 Schmitt trigger hysteresis mode
        G4_IO1: u1, // bit offset: 12 desc: G4_IO1 Schmitt trigger hysteresis mode
        G4_IO2: u1, // bit offset: 13 desc: G4_IO2 Schmitt trigger hysteresis mode
        G4_IO3: u1, // bit offset: 14 desc: G4_IO3 Schmitt trigger hysteresis mode
        G4_IO4: u1, // bit offset: 15 desc: G4_IO4 Schmitt trigger hysteresis mode
        G5_IO1: u1, // bit offset: 16 desc: G5_IO1 Schmitt trigger hysteresis mode
        G5_IO2: u1, // bit offset: 17 desc: G5_IO2 Schmitt trigger hysteresis mode
        G5_IO3: u1, // bit offset: 18 desc: G5_IO3 Schmitt trigger hysteresis mode
        G5_IO4: u1, // bit offset: 19 desc: G5_IO4 Schmitt trigger hysteresis mode
        G6_IO1: u1, // bit offset: 20 desc: G6_IO1 Schmitt trigger hysteresis mode
        G6_IO2: u1, // bit offset: 21 desc: G6_IO2 Schmitt trigger hysteresis mode
        G6_IO3: u1, // bit offset: 22 desc: G6_IO3 Schmitt trigger hysteresis mode
        G6_IO4: u1, // bit offset: 23 desc: G6_IO4 Schmitt trigger hysteresis mode
        G7_IO1: u1, // bit offset: 24 desc: G7_IO1 Schmitt trigger hysteresis mode
        G7_IO2: u1, // bit offset: 25 desc: G7_IO2 Schmitt trigger hysteresis mode
        G7_IO3: u1, // bit offset: 26 desc: G7_IO3 Schmitt trigger hysteresis mode
        G7_IO4: u1, // bit offset: 27 desc: G7_IO4 Schmitt trigger hysteresis mode
        G8_IO1: u1, // bit offset: 28 desc: G8_IO1 Schmitt trigger hysteresis mode
        G8_IO2: u1, // bit offset: 29 desc: G8_IO2 Schmitt trigger hysteresis mode
        G8_IO3: u1, // bit offset: 30 desc: G8_IO3 Schmitt trigger hysteresis mode
        G8_IO4: u1, // bit offset: 31 desc: G8_IO4 Schmitt trigger hysteresis mode
    });
    // byte offset: 24 I/O analog switch control register
    pub const IOASCR = mmio(Address + 0x00000018, 32, packed struct {
        G1_IO1: u1, // bit offset: 0 desc: G1_IO1 analog switch enable
        G1_IO2: u1, // bit offset: 1 desc: G1_IO2 analog switch enable
        G1_IO3: u1, // bit offset: 2 desc: G1_IO3 analog switch enable
        G1_IO4: u1, // bit offset: 3 desc: G1_IO4 analog switch enable
        G2_IO1: u1, // bit offset: 4 desc: G2_IO1 analog switch enable
        G2_IO2: u1, // bit offset: 5 desc: G2_IO2 analog switch enable
        G2_IO3: u1, // bit offset: 6 desc: G2_IO3 analog switch enable
        G2_IO4: u1, // bit offset: 7 desc: G2_IO4 analog switch enable
        G3_IO1: u1, // bit offset: 8 desc: G3_IO1 analog switch enable
        G3_IO2: u1, // bit offset: 9 desc: G3_IO2 analog switch enable
        G3_IO3: u1, // bit offset: 10 desc: G3_IO3 analog switch enable
        G3_IO4: u1, // bit offset: 11 desc: G3_IO4 analog switch enable
        G4_IO1: u1, // bit offset: 12 desc: G4_IO1 analog switch enable
        G4_IO2: u1, // bit offset: 13 desc: G4_IO2 analog switch enable
        G4_IO3: u1, // bit offset: 14 desc: G4_IO3 analog switch enable
        G4_IO4: u1, // bit offset: 15 desc: G4_IO4 analog switch enable
        G5_IO1: u1, // bit offset: 16 desc: G5_IO1 analog switch enable
        G5_IO2: u1, // bit offset: 17 desc: G5_IO2 analog switch enable
        G5_IO3: u1, // bit offset: 18 desc: G5_IO3 analog switch enable
        G5_IO4: u1, // bit offset: 19 desc: G5_IO4 analog switch enable
        G6_IO1: u1, // bit offset: 20 desc: G6_IO1 analog switch enable
        G6_IO2: u1, // bit offset: 21 desc: G6_IO2 analog switch enable
        G6_IO3: u1, // bit offset: 22 desc: G6_IO3 analog switch enable
        G6_IO4: u1, // bit offset: 23 desc: G6_IO4 analog switch enable
        G7_IO1: u1, // bit offset: 24 desc: G7_IO1 analog switch enable
        G7_IO2: u1, // bit offset: 25 desc: G7_IO2 analog switch enable
        G7_IO3: u1, // bit offset: 26 desc: G7_IO3 analog switch enable
        G7_IO4: u1, // bit offset: 27 desc: G7_IO4 analog switch enable
        G8_IO1: u1, // bit offset: 28 desc: G8_IO1 analog switch enable
        G8_IO2: u1, // bit offset: 29 desc: G8_IO2 analog switch enable
        G8_IO3: u1, // bit offset: 30 desc: G8_IO3 analog switch enable
        G8_IO4: u1, // bit offset: 31 desc: G8_IO4 analog switch enable
    });
    // byte offset: 32 I/O sampling control register
    pub const IOSCR = mmio(Address + 0x00000020, 32, packed struct {
        G1_IO1: u1, // bit offset: 0 desc: G1_IO1 sampling mode
        G1_IO2: u1, // bit offset: 1 desc: G1_IO2 sampling mode
        G1_IO3: u1, // bit offset: 2 desc: G1_IO3 sampling mode
        G1_IO4: u1, // bit offset: 3 desc: G1_IO4 sampling mode
        G2_IO1: u1, // bit offset: 4 desc: G2_IO1 sampling mode
        G2_IO2: u1, // bit offset: 5 desc: G2_IO2 sampling mode
        G2_IO3: u1, // bit offset: 6 desc: G2_IO3 sampling mode
        G2_IO4: u1, // bit offset: 7 desc: G2_IO4 sampling mode
        G3_IO1: u1, // bit offset: 8 desc: G3_IO1 sampling mode
        G3_IO2: u1, // bit offset: 9 desc: G3_IO2 sampling mode
        G3_IO3: u1, // bit offset: 10 desc: G3_IO3 sampling mode
        G3_IO4: u1, // bit offset: 11 desc: G3_IO4 sampling mode
        G4_IO1: u1, // bit offset: 12 desc: G4_IO1 sampling mode
        G4_IO2: u1, // bit offset: 13 desc: G4_IO2 sampling mode
        G4_IO3: u1, // bit offset: 14 desc: G4_IO3 sampling mode
        G4_IO4: u1, // bit offset: 15 desc: G4_IO4 sampling mode
        G5_IO1: u1, // bit offset: 16 desc: G5_IO1 sampling mode
        G5_IO2: u1, // bit offset: 17 desc: G5_IO2 sampling mode
        G5_IO3: u1, // bit offset: 18 desc: G5_IO3 sampling mode
        G5_IO4: u1, // bit offset: 19 desc: G5_IO4 sampling mode
        G6_IO1: u1, // bit offset: 20 desc: G6_IO1 sampling mode
        G6_IO2: u1, // bit offset: 21 desc: G6_IO2 sampling mode
        G6_IO3: u1, // bit offset: 22 desc: G6_IO3 sampling mode
        G6_IO4: u1, // bit offset: 23 desc: G6_IO4 sampling mode
        G7_IO1: u1, // bit offset: 24 desc: G7_IO1 sampling mode
        G7_IO2: u1, // bit offset: 25 desc: G7_IO2 sampling mode
        G7_IO3: u1, // bit offset: 26 desc: G7_IO3 sampling mode
        G7_IO4: u1, // bit offset: 27 desc: G7_IO4 sampling mode
        G8_IO1: u1, // bit offset: 28 desc: G8_IO1 sampling mode
        G8_IO2: u1, // bit offset: 29 desc: G8_IO2 sampling mode
        G8_IO3: u1, // bit offset: 30 desc: G8_IO3 sampling mode
        G8_IO4: u1, // bit offset: 31 desc: G8_IO4 sampling mode
    });
    // byte offset: 40 I/O channel control register
    pub const IOCCR = mmio(Address + 0x00000028, 32, packed struct {
        G1_IO1: u1, // bit offset: 0 desc: G1_IO1 channel mode
        G1_IO2: u1, // bit offset: 1 desc: G1_IO2 channel mode
        G1_IO3: u1, // bit offset: 2 desc: G1_IO3 channel mode
        G1_IO4: u1, // bit offset: 3 desc: G1_IO4 channel mode
        G2_IO1: u1, // bit offset: 4 desc: G2_IO1 channel mode
        G2_IO2: u1, // bit offset: 5 desc: G2_IO2 channel mode
        G2_IO3: u1, // bit offset: 6 desc: G2_IO3 channel mode
        G2_IO4: u1, // bit offset: 7 desc: G2_IO4 channel mode
        G3_IO1: u1, // bit offset: 8 desc: G3_IO1 channel mode
        G3_IO2: u1, // bit offset: 9 desc: G3_IO2 channel mode
        G3_IO3: u1, // bit offset: 10 desc: G3_IO3 channel mode
        G3_IO4: u1, // bit offset: 11 desc: G3_IO4 channel mode
        G4_IO1: u1, // bit offset: 12 desc: G4_IO1 channel mode
        G4_IO2: u1, // bit offset: 13 desc: G4_IO2 channel mode
        G4_IO3: u1, // bit offset: 14 desc: G4_IO3 channel mode
        G4_IO4: u1, // bit offset: 15 desc: G4_IO4 channel mode
        G5_IO1: u1, // bit offset: 16 desc: G5_IO1 channel mode
        G5_IO2: u1, // bit offset: 17 desc: G5_IO2 channel mode
        G5_IO3: u1, // bit offset: 18 desc: G5_IO3 channel mode
        G5_IO4: u1, // bit offset: 19 desc: G5_IO4 channel mode
        G6_IO1: u1, // bit offset: 20 desc: G6_IO1 channel mode
        G6_IO2: u1, // bit offset: 21 desc: G6_IO2 channel mode
        G6_IO3: u1, // bit offset: 22 desc: G6_IO3 channel mode
        G6_IO4: u1, // bit offset: 23 desc: G6_IO4 channel mode
        G7_IO1: u1, // bit offset: 24 desc: G7_IO1 channel mode
        G7_IO2: u1, // bit offset: 25 desc: G7_IO2 channel mode
        G7_IO3: u1, // bit offset: 26 desc: G7_IO3 channel mode
        G7_IO4: u1, // bit offset: 27 desc: G7_IO4 channel mode
        G8_IO1: u1, // bit offset: 28 desc: G8_IO1 channel mode
        G8_IO2: u1, // bit offset: 29 desc: G8_IO2 channel mode
        G8_IO3: u1, // bit offset: 30 desc: G8_IO3 channel mode
        G8_IO4: u1, // bit offset: 31 desc: G8_IO4 channel mode
    });
    // byte offset: 48 I/O group control status register
    pub const IOGCSR = mmio(Address + 0x00000030, 32, packed struct {
        G1E: u1, // bit offset: 0 desc: Analog I/O group x enable
        G2E: u1, // bit offset: 1 desc: Analog I/O group x enable
        G3E: u1, // bit offset: 2 desc: Analog I/O group x enable
        G4E: u1, // bit offset: 3 desc: Analog I/O group x enable
        G5E: u1, // bit offset: 4 desc: Analog I/O group x enable
        G6E: u1, // bit offset: 5 desc: Analog I/O group x enable
        G7E: u1, // bit offset: 6 desc: Analog I/O group x enable
        G8E: u1, // bit offset: 7 desc: Analog I/O group x enable
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        G1S: u1, // bit offset: 16 desc: Analog I/O group x status
        G2S: u1, // bit offset: 17 desc: Analog I/O group x status
        G3S: u1, // bit offset: 18 desc: Analog I/O group x status
        G4S: u1, // bit offset: 19 desc: Analog I/O group x status
        G5S: u1, // bit offset: 20 desc: Analog I/O group x status
        G6S: u1, // bit offset: 21 desc: Analog I/O group x status
        G7S: u1, // bit offset: 22 desc: Analog I/O group x status
        G8S: u1, // bit offset: 23 desc: Analog I/O group x status
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 I/O group x counter register
    pub const IOG1CR = mmio(Address + 0x00000034, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 56 I/O group x counter register
    pub const IOG2CR = mmio(Address + 0x00000038, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 60 I/O group x counter register
    pub const IOG3CR = mmio(Address + 0x0000003c, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 64 I/O group x counter register
    pub const IOG4CR = mmio(Address + 0x00000040, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 68 I/O group x counter register
    pub const IOG5CR = mmio(Address + 0x00000044, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 72 I/O group x counter register
    pub const IOG6CR = mmio(Address + 0x00000048, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 76 I/O group x counter register
    pub const IOG7CR = mmio(Address + 0x0000004c, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
    // byte offset: 80 I/O group x counter register
    pub const IOG8CR = mmio(Address + 0x00000050, 32, packed struct {
        CNT: u14, // bit offset: 0 desc: Counter value
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
pub const CRC = extern struct {
    pub const Address: u32 = 0x40023000;
    // byte offset: 0 Data register
    pub const DR = mmio(Address + 0x00000000, 32, packed struct {
        DR: u32, // bit offset: 0 desc: Data register bits
    });
    // byte offset: 4 Independent data register
    pub const IDR = mmio(Address + 0x00000004, 32, packed struct {
        IDR: u8, // bit offset: 0 desc: General-purpose 8-bit data register bits
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
    // byte offset: 8 Control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        RESET: u1, // bit offset: 0 desc: reset bit
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        POLYSIZE: u2, // bit offset: 3 desc: Polynomial size
        REV_IN: u2, // bit offset: 5 desc: Reverse input data
        REV_OUT: u1, // bit offset: 7 desc: Reverse output data
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
    // byte offset: 16 Initial CRC value
    pub const INIT = mmio(Address + 0x00000010, 32, packed struct {
        INIT: u32, // bit offset: 0 desc: Programmable initial CRC value
    });
    // byte offset: 20 CRC polynomial
    pub const POL = mmio(Address + 0x00000014, 32, packed struct {
        POL: u32, // bit offset: 0 desc: Programmable polynomial
    });
};
pub const Flash = extern struct {
    pub const Address: u32 = 0x40022000;
    // byte offset: 0 Flash access control register
    pub const ACR = mmio(Address + 0x00000000, 32, packed struct {
        LATENCY: u3, // bit offset: 0 desc: LATENCY
        reserved1: u1 = 0,
        PRFTBE: u1, // bit offset: 4 desc: PRFTBE
        PRFTBS: u1, // bit offset: 5 desc: PRFTBS
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
    // byte offset: 4 Flash key register
    pub const KEYR = mmio(Address + 0x00000004, 32, packed struct {
        FKEYR: u32, // bit offset: 0 desc: Flash Key
    });
    // byte offset: 8 Flash option key register
    pub const OPTKEYR = mmio(Address + 0x00000008, 32, packed struct {
        OPTKEYR: u32, // bit offset: 0 desc: Option byte key
    });
    // byte offset: 12 Flash status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        BSY: u1, // bit offset: 0 desc: Busy
        reserved1: u1 = 0,
        PGERR: u1, // bit offset: 2 desc: Programming error
        reserved2: u1 = 0,
        WRPRT: u1, // bit offset: 4 desc: Write protection error
        EOP: u1, // bit offset: 5 desc: End of operation
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
    // byte offset: 16 Flash control register
    pub const CR = mmio(Address + 0x00000010, 32, packed struct {
        PG: u1, // bit offset: 0 desc: Programming
        PER: u1, // bit offset: 1 desc: Page erase
        MER: u1, // bit offset: 2 desc: Mass erase
        reserved1: u1 = 0,
        OPTPG: u1, // bit offset: 4 desc: Option byte programming
        OPTER: u1, // bit offset: 5 desc: Option byte erase
        STRT: u1, // bit offset: 6 desc: Start
        LOCK: u1, // bit offset: 7 desc: Lock
        reserved2: u1 = 0,
        OPTWRE: u1, // bit offset: 9 desc: Option bytes write enable
        ERRIE: u1, // bit offset: 10 desc: Error interrupt enable
        reserved3: u1 = 0,
        EOPIE: u1, // bit offset: 12 desc: End of operation interrupt enable
        FORCE_OPTLOAD: u1, // bit offset: 13 desc: Force option byte loading
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
    // byte offset: 20 Flash address register
    pub const AR = mmio(Address + 0x00000014, 32, packed struct {
        FAR: u32, // bit offset: 0 desc: Flash address
    });
    // byte offset: 28 Option byte register
    pub const OBR = mmio(Address + 0x0000001c, 32, packed struct {
        OPTERR: u1, // bit offset: 0 desc: Option byte error
        LEVEL1_PROT: u1, // bit offset: 1 desc: Level 1 protection status
        LEVEL2_PROT: u1, // bit offset: 2 desc: Level 2 protection status
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        WDG_SW: u1, // bit offset: 8 desc: WDG_SW
        nRST_STOP: u1, // bit offset: 9 desc: nRST_STOP
        nRST_STDBY: u1, // bit offset: 10 desc: nRST_STDBY
        reserved6: u1 = 0,
        BOOT1: u1, // bit offset: 12 desc: BOOT1
        VDDA_MONITOR: u1, // bit offset: 13 desc: VDDA_MONITOR
        SRAM_PARITY_CHECK: u1, // bit offset: 14 desc: SRAM_PARITY_CHECK
        reserved7: u1 = 0,
        Data0: u8, // bit offset: 16 desc: Data0
        Data1: u8, // bit offset: 24 desc: Data1
    });
    // byte offset: 32 Write protection register
    pub const WRPR = mmio(Address + 0x00000020, 32, packed struct {
        WRP: u32, // bit offset: 0 desc: Write protect
    });
};
pub const RCC = extern struct {
    pub const Address: u32 = 0x40021000;
    // byte offset: 0 Clock control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        HSION: u1, // bit offset: 0 desc: Internal High Speed clock enable
        HSIRDY: u1, // bit offset: 1 desc: Internal High Speed clock ready flag
        reserved1: u1 = 0,
        HSITRIM: u5, // bit offset: 3 desc: Internal High Speed clock trimming
        HSICAL: u8, // bit offset: 8 desc: Internal High Speed clock Calibration
        HSEON: u1, // bit offset: 16 desc: External High Speed clock enable
        HSERDY: u1, // bit offset: 17 desc: External High Speed clock ready flag
        HSEBYP: u1, // bit offset: 18 desc: External High Speed clock Bypass
        CSSON: u1, // bit offset: 19 desc: Clock Security System enable
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        PLLON: u1, // bit offset: 24 desc: PLL enable
        PLLRDY: u1, // bit offset: 25 desc: PLL clock ready flag
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Clock configuration register (RCC_CFGR)
    pub const CFGR = mmio(Address + 0x00000004, 32, packed struct {
        SW: u2, // bit offset: 0 desc: System clock Switch
        SWS: u2, // bit offset: 2 desc: System Clock Switch Status
        HPRE: u4, // bit offset: 4 desc: AHB prescaler
        PPRE1: u3, // bit offset: 8 desc: APB Low speed prescaler (APB1)
        PPRE2: u3, // bit offset: 11 desc: APB high speed prescaler (APB2)
        reserved1: u1 = 0,
        PLLSRC: u2, // bit offset: 15 desc: PLL entry clock source
        PLLXTPRE: u1, // bit offset: 17 desc: HSE divider for PLL entry
        PLLMUL: u4, // bit offset: 18 desc: PLL Multiplication Factor
        USBPRES: u1, // bit offset: 22 desc: USB prescaler
        I2SSRC: u1, // bit offset: 23 desc: I2S external clock source selection
        MCO: u3, // bit offset: 24 desc: Microcontroller clock output
        reserved2: u1 = 0,
        MCOF: u1, // bit offset: 28 desc: Microcontroller Clock Output Flag
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Clock interrupt register (RCC_CIR)
    pub const CIR = mmio(Address + 0x00000008, 32, packed struct {
        LSIRDYF: u1, // bit offset: 0 desc: LSI Ready Interrupt flag
        LSERDYF: u1, // bit offset: 1 desc: LSE Ready Interrupt flag
        HSIRDYF: u1, // bit offset: 2 desc: HSI Ready Interrupt flag
        HSERDYF: u1, // bit offset: 3 desc: HSE Ready Interrupt flag
        PLLRDYF: u1, // bit offset: 4 desc: PLL Ready Interrupt flag
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CSSF: u1, // bit offset: 7 desc: Clock Security System Interrupt flag
        LSIRDYIE: u1, // bit offset: 8 desc: LSI Ready Interrupt Enable
        LSERDYIE: u1, // bit offset: 9 desc: LSE Ready Interrupt Enable
        HSIRDYIE: u1, // bit offset: 10 desc: HSI Ready Interrupt Enable
        HSERDYIE: u1, // bit offset: 11 desc: HSE Ready Interrupt Enable
        PLLRDYIE: u1, // bit offset: 12 desc: PLL Ready Interrupt Enable
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        LSIRDYC: u1, // bit offset: 16 desc: LSI Ready Interrupt Clear
        LSERDYC: u1, // bit offset: 17 desc: LSE Ready Interrupt Clear
        HSIRDYC: u1, // bit offset: 18 desc: HSI Ready Interrupt Clear
        HSERDYC: u1, // bit offset: 19 desc: HSE Ready Interrupt Clear
        PLLRDYC: u1, // bit offset: 20 desc: PLL Ready Interrupt Clear
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        CSSC: u1, // bit offset: 23 desc: Clock security system interrupt clear
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 APB2 peripheral reset register (RCC_APB2RSTR)
    pub const APB2RSTR = mmio(Address + 0x0000000c, 32, packed struct {
        SYSCFGRST: u1, // bit offset: 0 desc: SYSCFG and COMP reset
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
        TIM1RST: u1, // bit offset: 11 desc: TIM1 timer reset
        SPI1RST: u1, // bit offset: 12 desc: SPI 1 reset
        TIM8RST: u1, // bit offset: 13 desc: TIM8 timer reset
        USART1RST: u1, // bit offset: 14 desc: USART1 reset
        reserved11: u1 = 0,
        TIM15RST: u1, // bit offset: 16 desc: TIM15 timer reset
        TIM16RST: u1, // bit offset: 17 desc: TIM16 timer reset
        TIM17RST: u1, // bit offset: 18 desc: TIM17 timer reset
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 APB1 peripheral reset register (RCC_APB1RSTR)
    pub const APB1RSTR = mmio(Address + 0x00000010, 32, packed struct {
        TIM2RST: u1, // bit offset: 0 desc: Timer 2 reset
        TIM3RST: u1, // bit offset: 1 desc: Timer 3 reset
        TIM4RST: u1, // bit offset: 2 desc: Timer 14 reset
        reserved1: u1 = 0,
        TIM6RST: u1, // bit offset: 4 desc: Timer 6 reset
        TIM7RST: u1, // bit offset: 5 desc: Timer 7 reset
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        WWDGRST: u1, // bit offset: 11 desc: Window watchdog reset
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        SPI2RST: u1, // bit offset: 14 desc: SPI2 reset
        SPI3RST: u1, // bit offset: 15 desc: SPI3 reset
        reserved9: u1 = 0,
        USART2RST: u1, // bit offset: 17 desc: USART 2 reset
        USART3RST: u1, // bit offset: 18 desc: USART3 reset
        UART4RST: u1, // bit offset: 19 desc: UART 4 reset
        UART5RST: u1, // bit offset: 20 desc: UART 5 reset
        I2C1RST: u1, // bit offset: 21 desc: I2C1 reset
        I2C2RST: u1, // bit offset: 22 desc: I2C2 reset
        USBRST: u1, // bit offset: 23 desc: USB reset
        reserved10: u1 = 0,
        CANRST: u1, // bit offset: 25 desc: CAN reset
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        PWRRST: u1, // bit offset: 28 desc: Power interface reset
        DACRST: u1, // bit offset: 29 desc: DAC interface reset
        I2C3RST: u1, // bit offset: 30 desc: I2C3 reset
        padding1: u1 = 0,
    });
    // byte offset: 20 AHB Peripheral Clock enable register (RCC_AHBENR)
    pub const AHBENR = mmio(Address + 0x00000014, 32, packed struct {
        DMAEN: u1, // bit offset: 0 desc: DMA1 clock enable
        DMA2EN: u1, // bit offset: 1 desc: DMA2 clock enable
        SRAMEN: u1, // bit offset: 2 desc: SRAM interface clock enable
        reserved1: u1 = 0,
        FLITFEN: u1, // bit offset: 4 desc: FLITF clock enable
        FMCEN: u1, // bit offset: 5 desc: FMC clock enable
        CRCEN: u1, // bit offset: 6 desc: CRC clock enable
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        IOPHEN: u1, // bit offset: 16 desc: IO port H clock enable
        IOPAEN: u1, // bit offset: 17 desc: I/O port A clock enable
        IOPBEN: u1, // bit offset: 18 desc: I/O port B clock enable
        IOPCEN: u1, // bit offset: 19 desc: I/O port C clock enable
        IOPDEN: u1, // bit offset: 20 desc: I/O port D clock enable
        IOPEEN: u1, // bit offset: 21 desc: I/O port E clock enable
        IOPFEN: u1, // bit offset: 22 desc: I/O port F clock enable
        IOPGEN: u1, // bit offset: 23 desc: I/O port G clock enable
        TSCEN: u1, // bit offset: 24 desc: Touch sensing controller clock enable
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        ADC12EN: u1, // bit offset: 28 desc: ADC1 and ADC2 clock enable
        ADC34EN: u1, // bit offset: 29 desc: ADC3 and ADC4 clock enable
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 APB2 peripheral clock enable register (RCC_APB2ENR)
    pub const APB2ENR = mmio(Address + 0x00000018, 32, packed struct {
        SYSCFGEN: u1, // bit offset: 0 desc: SYSCFG clock enable
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
        TIM1EN: u1, // bit offset: 11 desc: TIM1 Timer clock enable
        SPI1EN: u1, // bit offset: 12 desc: SPI 1 clock enable
        TIM8EN: u1, // bit offset: 13 desc: TIM8 Timer clock enable
        USART1EN: u1, // bit offset: 14 desc: USART1 clock enable
        reserved11: u1 = 0,
        TIM15EN: u1, // bit offset: 16 desc: TIM15 timer clock enable
        TIM16EN: u1, // bit offset: 17 desc: TIM16 timer clock enable
        TIM17EN: u1, // bit offset: 18 desc: TIM17 timer clock enable
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 APB1 peripheral clock enable register (RCC_APB1ENR)
    pub const APB1ENR = mmio(Address + 0x0000001c, 32, packed struct {
        TIM2EN: u1, // bit offset: 0 desc: Timer 2 clock enable
        TIM3EN: u1, // bit offset: 1 desc: Timer 3 clock enable
        TIM4EN: u1, // bit offset: 2 desc: Timer 4 clock enable
        reserved1: u1 = 0,
        TIM6EN: u1, // bit offset: 4 desc: Timer 6 clock enable
        TIM7EN: u1, // bit offset: 5 desc: Timer 7 clock enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        WWDGEN: u1, // bit offset: 11 desc: Window watchdog clock enable
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        SPI2EN: u1, // bit offset: 14 desc: SPI 2 clock enable
        SPI3EN: u1, // bit offset: 15 desc: SPI 3 clock enable
        reserved9: u1 = 0,
        USART2EN: u1, // bit offset: 17 desc: USART 2 clock enable
        USART3EN: u1, // bit offset: 18 desc: USART 3 clock enable
        USART4EN: u1, // bit offset: 19 desc: USART 4 clock enable
        USART5EN: u1, // bit offset: 20 desc: USART 5 clock enable
        I2C1EN: u1, // bit offset: 21 desc: I2C 1 clock enable
        I2C2EN: u1, // bit offset: 22 desc: I2C 2 clock enable
        USBEN: u1, // bit offset: 23 desc: USB clock enable
        reserved10: u1 = 0,
        CANEN: u1, // bit offset: 25 desc: CAN clock enable
        DAC2EN: u1, // bit offset: 26 desc: DAC2 interface clock enable
        reserved11: u1 = 0,
        PWREN: u1, // bit offset: 28 desc: Power interface clock enable
        DACEN: u1, // bit offset: 29 desc: DAC interface clock enable
        I2C3EN: u1, // bit offset: 30 desc: I2C3 clock enable
        padding1: u1 = 0,
    });
    // byte offset: 32 Backup domain control register (RCC_BDCR)
    pub const BDCR = mmio(Address + 0x00000020, 32, packed struct {
        LSEON: u1, // bit offset: 0 desc: External Low Speed oscillator enable
        LSERDY: u1, // bit offset: 1 desc: External Low Speed oscillator ready
        LSEBYP: u1, // bit offset: 2 desc: External Low Speed oscillator bypass
        LSEDRV: u2, // bit offset: 3 desc: LSE oscillator drive capability
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RTCSEL: u2, // bit offset: 8 desc: RTC clock source selection
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        RTCEN: u1, // bit offset: 15 desc: RTC clock enable
        BDRST: u1, // bit offset: 16 desc: Backup domain software reset
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Control/status register (RCC_CSR)
    pub const CSR = mmio(Address + 0x00000024, 32, packed struct {
        LSION: u1, // bit offset: 0 desc: Internal low speed oscillator enable
        LSIRDY: u1, // bit offset: 1 desc: Internal low speed oscillator ready
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
        RMVF: u1, // bit offset: 24 desc: Remove reset flag
        OBLRSTF: u1, // bit offset: 25 desc: Option byte loader reset flag
        PINRSTF: u1, // bit offset: 26 desc: PIN reset flag
        PORRSTF: u1, // bit offset: 27 desc: POR/PDR reset flag
        SFTRSTF: u1, // bit offset: 28 desc: Software reset flag
        IWDGRSTF: u1, // bit offset: 29 desc: Independent watchdog reset flag
        WWDGRSTF: u1, // bit offset: 30 desc: Window watchdog reset flag
        LPWRRSTF: u1, // bit offset: 31 desc: Low-power reset flag
    });
    // byte offset: 40 AHB peripheral reset register
    pub const AHBRSTR = mmio(Address + 0x00000028, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        FMCRST: u1, // bit offset: 5 desc: FMC reset
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
        IOPHRST: u1, // bit offset: 16 desc: I/O port H reset
        IOPARST: u1, // bit offset: 17 desc: I/O port A reset
        IOPBRST: u1, // bit offset: 18 desc: I/O port B reset
        IOPCRST: u1, // bit offset: 19 desc: I/O port C reset
        IOPDRST: u1, // bit offset: 20 desc: I/O port D reset
        IOPERST: u1, // bit offset: 21 desc: I/O port E reset
        IOPFRST: u1, // bit offset: 22 desc: I/O port F reset
        IOPGRST: u1, // bit offset: 23 desc: Touch sensing controller reset
        TSCRST: u1, // bit offset: 24 desc: Touch sensing controller reset
        reserved18: u1 = 0,
        reserved17: u1 = 0,
        reserved16: u1 = 0,
        ADC12RST: u1, // bit offset: 28 desc: ADC1 and ADC2 reset
        ADC34RST: u1, // bit offset: 29 desc: ADC3 and ADC4 reset
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 Clock configuration register 2
    pub const CFGR2 = mmio(Address + 0x0000002c, 32, packed struct {
        PREDIV: u4, // bit offset: 0 desc: PREDIV division factor
        ADC12PRES: u5, // bit offset: 4 desc: ADC1 and ADC2 prescaler
        ADC34PRES: u5, // bit offset: 9 desc: ADC3 and ADC4 prescaler
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
    // byte offset: 48 Clock configuration register 3
    pub const CFGR3 = mmio(Address + 0x00000030, 32, packed struct {
        USART1SW: u2, // bit offset: 0 desc: USART1 clock source selection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        I2C1SW: u1, // bit offset: 4 desc: I2C1 clock source selection
        I2C2SW: u1, // bit offset: 5 desc: I2C2 clock source selection
        I2C3SW: u1, // bit offset: 6 desc: I2C3 clock source selection
        reserved3: u1 = 0,
        TIM1SW: u1, // bit offset: 8 desc: Timer1 clock source selection
        TIM8SW: u1, // bit offset: 9 desc: Timer8 clock source selection
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        USART2SW: u2, // bit offset: 16 desc: USART2 clock source selection
        USART3SW: u2, // bit offset: 18 desc: USART3 clock source selection
        UART4SW: u2, // bit offset: 20 desc: UART4 clock source selection
        UART5SW: u2, // bit offset: 22 desc: UART5 clock source selection
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
pub const DMA1 = extern struct {
    pub const Address: u32 = 0x40020000;
    // byte offset: 0 DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        GIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt flag
        TCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete flag
        HTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer Complete flag
        TEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error flag
        GIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt flag
        TCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete flag
        HTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer Complete flag
        TEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error flag
        GIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt flag
        TCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete flag
        HTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer Complete flag
        TEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error flag
        GIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt flag
        TCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete flag
        HTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer Complete flag
        TEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error flag
        GIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt flag
        TCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete flag
        HTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer Complete flag
        TEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error flag
        GIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt flag
        TCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete flag
        HTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer Complete flag
        TEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error flag
        GIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt flag
        TCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete flag
        HTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer Complete flag
        TEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error flag
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        CGIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt clear
        CTCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete clear
        CHTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer clear
        CTEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error clear
        CGIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt clear
        CTCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete clear
        CHTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer clear
        CTEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error clear
        CGIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt clear
        CTCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete clear
        CHTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer clear
        CTEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error clear
        CGIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt clear
        CTCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete clear
        CHTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer clear
        CTEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error clear
        CGIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt clear
        CTCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete clear
        CHTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer clear
        CTEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error clear
        CGIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt clear
        CTCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete clear
        CHTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer clear
        CTEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error clear
        CGIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt clear
        CTCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete clear
        CHTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer clear
        CTEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error clear
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 12 DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 20 DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 28 DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 32 DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 40 DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 48 DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 52 DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 60 DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 68 DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 72 DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 80 DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 88 DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 92 DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 100 DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 108 DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 112 DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 116 DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 120 DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 128 DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 132 DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 140 DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
};
pub const DMA2 = extern struct {
    pub const Address: u32 = 0x40020400;
    // byte offset: 0 DMA interrupt status register (DMA_ISR)
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        GIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt flag
        TCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete flag
        HTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer Complete flag
        TEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error flag
        GIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt flag
        TCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete flag
        HTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer Complete flag
        TEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error flag
        GIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt flag
        TCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete flag
        HTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer Complete flag
        TEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error flag
        GIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt flag
        TCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete flag
        HTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer Complete flag
        TEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error flag
        GIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt flag
        TCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete flag
        HTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer Complete flag
        TEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error flag
        GIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt flag
        TCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete flag
        HTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer Complete flag
        TEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error flag
        GIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt flag
        TCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete flag
        HTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer Complete flag
        TEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error flag
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 DMA interrupt flag clear register (DMA_IFCR)
    pub const IFCR = mmio(Address + 0x00000004, 32, packed struct {
        CGIF1: u1, // bit offset: 0 desc: Channel 1 Global interrupt clear
        CTCIF1: u1, // bit offset: 1 desc: Channel 1 Transfer Complete clear
        CHTIF1: u1, // bit offset: 2 desc: Channel 1 Half Transfer clear
        CTEIF1: u1, // bit offset: 3 desc: Channel 1 Transfer Error clear
        CGIF2: u1, // bit offset: 4 desc: Channel 2 Global interrupt clear
        CTCIF2: u1, // bit offset: 5 desc: Channel 2 Transfer Complete clear
        CHTIF2: u1, // bit offset: 6 desc: Channel 2 Half Transfer clear
        CTEIF2: u1, // bit offset: 7 desc: Channel 2 Transfer Error clear
        CGIF3: u1, // bit offset: 8 desc: Channel 3 Global interrupt clear
        CTCIF3: u1, // bit offset: 9 desc: Channel 3 Transfer Complete clear
        CHTIF3: u1, // bit offset: 10 desc: Channel 3 Half Transfer clear
        CTEIF3: u1, // bit offset: 11 desc: Channel 3 Transfer Error clear
        CGIF4: u1, // bit offset: 12 desc: Channel 4 Global interrupt clear
        CTCIF4: u1, // bit offset: 13 desc: Channel 4 Transfer Complete clear
        CHTIF4: u1, // bit offset: 14 desc: Channel 4 Half Transfer clear
        CTEIF4: u1, // bit offset: 15 desc: Channel 4 Transfer Error clear
        CGIF5: u1, // bit offset: 16 desc: Channel 5 Global interrupt clear
        CTCIF5: u1, // bit offset: 17 desc: Channel 5 Transfer Complete clear
        CHTIF5: u1, // bit offset: 18 desc: Channel 5 Half Transfer clear
        CTEIF5: u1, // bit offset: 19 desc: Channel 5 Transfer Error clear
        CGIF6: u1, // bit offset: 20 desc: Channel 6 Global interrupt clear
        CTCIF6: u1, // bit offset: 21 desc: Channel 6 Transfer Complete clear
        CHTIF6: u1, // bit offset: 22 desc: Channel 6 Half Transfer clear
        CTEIF6: u1, // bit offset: 23 desc: Channel 6 Transfer Error clear
        CGIF7: u1, // bit offset: 24 desc: Channel 7 Global interrupt clear
        CTCIF7: u1, // bit offset: 25 desc: Channel 7 Transfer Complete clear
        CHTIF7: u1, // bit offset: 26 desc: Channel 7 Half Transfer clear
        CTEIF7: u1, // bit offset: 27 desc: Channel 7 Transfer Error clear
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 DMA channel configuration register (DMA_CCR)
    pub const CCR1 = mmio(Address + 0x00000008, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 12 DMA channel 1 number of data register
    pub const CNDTR1 = mmio(Address + 0x0000000c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 DMA channel 1 peripheral address register
    pub const CPAR1 = mmio(Address + 0x00000010, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 20 DMA channel 1 memory address register
    pub const CMAR1 = mmio(Address + 0x00000014, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 28 DMA channel configuration register (DMA_CCR)
    pub const CCR2 = mmio(Address + 0x0000001c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 32 DMA channel 2 number of data register
    pub const CNDTR2 = mmio(Address + 0x00000020, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DMA channel 2 peripheral address register
    pub const CPAR2 = mmio(Address + 0x00000024, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 40 DMA channel 2 memory address register
    pub const CMAR2 = mmio(Address + 0x00000028, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 48 DMA channel configuration register (DMA_CCR)
    pub const CCR3 = mmio(Address + 0x00000030, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 52 DMA channel 3 number of data register
    pub const CNDTR3 = mmio(Address + 0x00000034, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 DMA channel 3 peripheral address register
    pub const CPAR3 = mmio(Address + 0x00000038, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 60 DMA channel 3 memory address register
    pub const CMAR3 = mmio(Address + 0x0000003c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 68 DMA channel configuration register (DMA_CCR)
    pub const CCR4 = mmio(Address + 0x00000044, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 72 DMA channel 4 number of data register
    pub const CNDTR4 = mmio(Address + 0x00000048, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 DMA channel 4 peripheral address register
    pub const CPAR4 = mmio(Address + 0x0000004c, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 80 DMA channel 4 memory address register
    pub const CMAR4 = mmio(Address + 0x00000050, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 88 DMA channel configuration register (DMA_CCR)
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 92 DMA channel 5 number of data register
    pub const CNDTR5 = mmio(Address + 0x0000005c, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 DMA channel 5 peripheral address register
    pub const CPAR5 = mmio(Address + 0x00000060, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 100 DMA channel 5 memory address register
    pub const CMAR5 = mmio(Address + 0x00000064, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 108 DMA channel configuration register (DMA_CCR)
    pub const CCR6 = mmio(Address + 0x0000006c, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 112 DMA channel 6 number of data register
    pub const CNDTR6 = mmio(Address + 0x00000070, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 116 DMA channel 6 peripheral address register
    pub const CPAR6 = mmio(Address + 0x00000074, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 120 DMA channel 6 memory address register
    pub const CMAR6 = mmio(Address + 0x00000078, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
    // byte offset: 128 DMA channel configuration register (DMA_CCR)
    pub const CCR7 = mmio(Address + 0x00000080, 32, packed struct {
        EN: u1, // bit offset: 0 desc: Channel enable
        TCIE: u1, // bit offset: 1 desc: Transfer complete interrupt enable
        HTIE: u1, // bit offset: 2 desc: Half Transfer interrupt enable
        TEIE: u1, // bit offset: 3 desc: Transfer error interrupt enable
        DIR: u1, // bit offset: 4 desc: Data transfer direction
        CIRC: u1, // bit offset: 5 desc: Circular mode
        PINC: u1, // bit offset: 6 desc: Peripheral increment mode
        MINC: u1, // bit offset: 7 desc: Memory increment mode
        PSIZE: u2, // bit offset: 8 desc: Peripheral size
        MSIZE: u2, // bit offset: 10 desc: Memory size
        PL: u2, // bit offset: 12 desc: Channel Priority level
        MEM2MEM: u1, // bit offset: 14 desc: Memory to memory mode
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
    // byte offset: 132 DMA channel 7 number of data register
    pub const CNDTR7 = mmio(Address + 0x00000084, 32, packed struct {
        NDT: u16, // bit offset: 0 desc: Number of data to transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 DMA channel 7 peripheral address register
    pub const CPAR7 = mmio(Address + 0x00000088, 32, packed struct {
        PA: u32, // bit offset: 0 desc: Peripheral address
    });
    // byte offset: 140 DMA channel 7 memory address register
    pub const CMAR7 = mmio(Address + 0x0000008c, 32, packed struct {
        MA: u32, // bit offset: 0 desc: Memory address
    });
};
pub const TIM2 = extern struct {
    pub const Address: u32 = 0x40000000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
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
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS_3: u1, // bit offset: 16 desc: Slave mode selection bit3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
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
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output compare 3 mode bit3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output compare 4 mode bit3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved2: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved3: u1 = 0,
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved4: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 3 output Polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNTL: u16, // bit offset: 0 desc: Low counter value
        CNTH: u15, // bit offset: 16 desc: High counter value
        CNT_or_UIFCPY: u1, // bit offset: 31 desc: if IUFREMAP=0 than CNT with read write access else UIFCPY with read only access
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARRL: u16, // bit offset: 0 desc: Low Auto-reload value
        ARRH: u16, // bit offset: 16 desc: High Auto-reload value
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1L: u16, // bit offset: 0 desc: Low Capture/Compare 1 value
        CCR1H: u16, // bit offset: 16 desc: High Capture/Compare 1 value (on TIM2)
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2L: u16, // bit offset: 0 desc: Low Capture/Compare 2 value
        CCR2H: u16, // bit offset: 16 desc: High Capture/Compare 2 value (on TIM2)
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR3H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR4H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TIM3 = extern struct {
    pub const Address: u32 = 0x40000400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
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
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS_3: u1, // bit offset: 16 desc: Slave mode selection bit3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
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
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output compare 3 mode bit3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output compare 4 mode bit3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved2: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved3: u1 = 0,
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved4: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 3 output Polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNTL: u16, // bit offset: 0 desc: Low counter value
        CNTH: u15, // bit offset: 16 desc: High counter value
        CNT_or_UIFCPY: u1, // bit offset: 31 desc: if IUFREMAP=0 than CNT with read write access else UIFCPY with read only access
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARRL: u16, // bit offset: 0 desc: Low Auto-reload value
        ARRH: u16, // bit offset: 16 desc: High Auto-reload value
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1L: u16, // bit offset: 0 desc: Low Capture/Compare 1 value
        CCR1H: u16, // bit offset: 16 desc: High Capture/Compare 1 value (on TIM2)
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2L: u16, // bit offset: 0 desc: Low Capture/Compare 2 value
        CCR2H: u16, // bit offset: 16 desc: High Capture/Compare 2 value (on TIM2)
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR3H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR4H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TIM4 = extern struct {
    pub const Address: u32 = 0x40000800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
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
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS_3: u1, // bit offset: 16 desc: Slave mode selection bit3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        reserved1: u1 = 0,
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        reserved2: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        reserved3: u1 = 0,
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        reserved1: u1 = 0,
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        reserved1: u1 = 0,
        TG: u1, // bit offset: 6 desc: Trigger generation
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
    // byte offset: 24 capture/compare mode register 1 (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        O24CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output compare 3 mode bit3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output compare 4 mode bit3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        reserved1: u1 = 0,
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved2: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        reserved3: u1 = 0,
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved4: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 3 output Polarity
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNTL: u16, // bit offset: 0 desc: Low counter value
        CNTH: u15, // bit offset: 16 desc: High counter value
        CNT_or_UIFCPY: u1, // bit offset: 31 desc: if IUFREMAP=0 than CNT with read write access else UIFCPY with read only access
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARRL: u16, // bit offset: 0 desc: Low Auto-reload value
        ARRH: u16, // bit offset: 16 desc: High Auto-reload value
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1L: u16, // bit offset: 0 desc: Low Capture/Compare 1 value
        CCR1H: u16, // bit offset: 16 desc: High Capture/Compare 1 value (on TIM2)
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2L: u16, // bit offset: 0 desc: Low Capture/Compare 2 value
        CCR2H: u16, // bit offset: 16 desc: High Capture/Compare 2 value (on TIM2)
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR3H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4L: u16, // bit offset: 0 desc: Low Capture/Compare value
        CCR4H: u16, // bit offset: 16 desc: High Capture/Compare value (on TIM2)
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TIM15 = extern struct {
    pub const Address: u32 = 0x40014000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved4: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
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
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        reserved1: u1 = 0,
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        SMS_3: u1, // bit offset: 16 desc: Slave mode selection bit 3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        reserved3: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        reserved1: u1 = 0,
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        reserved2: u1 = 0,
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode bit 3
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output Compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PSC: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        reserved1: u1 = 0,
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
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
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u8, // bit offset: 0 desc: Repetition counter value
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
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TIM16 = extern struct {
    pub const Address: u32 = 0x40014400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved4: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
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
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        reserved4: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
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
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
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
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF Copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u8, // bit offset: 0 desc: Repetition counter value
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
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 80 option register
    pub const OR = mmio(Address + 0x00000050, 32, packed struct {
        raw: u32, // placeholder field
    });
};
pub const TIM17 = extern struct {
    pub const Address: u32 = 0x40014800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved4: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
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
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        reserved4: u1 = 0,
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PSC: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
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
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
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
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF Copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u8, // bit offset: 0 desc: Repetition counter value
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
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const USART1 = extern struct {
    pub const Address: u32 = 0x40013800;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        UE: u1, // bit offset: 0 desc: USART enable
        UESM: u1, // bit offset: 1 desc: USART enable in Stop mode
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Receiver wakeup method
        M: u1, // bit offset: 12 desc: Word length
        MME: u1, // bit offset: 13 desc: Mute mode enable
        CMIE: u1, // bit offset: 14 desc: Character match interrupt enable
        OVER8: u1, // bit offset: 15 desc: Oversampling mode
        DEDT: u5, // bit offset: 16 desc: Driver Enable deassertion time
        DEAT: u5, // bit offset: 21 desc: Driver Enable assertion time
        RTOIE: u1, // bit offset: 26 desc: Receiver timeout interrupt enable
        EOBIE: u1, // bit offset: 27 desc: End of Block interrupt enable
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDM7: u1, // bit offset: 4 desc: 7-bit Address Detection/4-bit Address Detection
        LBDL: u1, // bit offset: 5 desc: LIN break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved5: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        SWAP: u1, // bit offset: 15 desc: Swap TX/RX pins
        RXINV: u1, // bit offset: 16 desc: RX pin active level inversion
        TXINV: u1, // bit offset: 17 desc: TX pin active level inversion
        DATAINV: u1, // bit offset: 18 desc: Binary data inversion
        MSBFIRST: u1, // bit offset: 19 desc: Most significant bit first
        ABREN: u1, // bit offset: 20 desc: Auto baud rate enable
        ABRMOD: u2, // bit offset: 21 desc: Auto baud rate mode
        RTOEN: u1, // bit offset: 23 desc: Receiver timeout enable
        ADD0: u4, // bit offset: 24 desc: Address of the USART node
        ADD4: u4, // bit offset: 28 desc: Address of the USART node
    });
    // byte offset: 8 Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        ONEBIT: u1, // bit offset: 11 desc: One sample bit method enable
        OVRDIS: u1, // bit offset: 12 desc: Overrun Disable
        DDRE: u1, // bit offset: 13 desc: DMA Disable on Reception Error
        DEM: u1, // bit offset: 14 desc: Driver enable mode
        DEP: u1, // bit offset: 15 desc: Driver enable polarity selection
        reserved1: u1 = 0,
        SCARCNT: u3, // bit offset: 17 desc: Smartcard auto-retry count
        WUS: u2, // bit offset: 20 desc: Wakeup from Stop mode interrupt flag selection
        WUFIE: u1, // bit offset: 22 desc: Wakeup from Stop mode interrupt enable
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        RTO: u24, // bit offset: 0 desc: Receiver timeout value
        BLEN: u8, // bit offset: 24 desc: Block Length
    });
    // byte offset: 24 Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        ABRRQ: u1, // bit offset: 0 desc: Auto baud rate request
        SBKRQ: u1, // bit offset: 1 desc: Send break request
        MMRQ: u1, // bit offset: 2 desc: Mute mode request
        RXFRQ: u1, // bit offset: 3 desc: Receive data flush request
        TXFRQ: u1, // bit offset: 4 desc: Transmit data flush request
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
    // byte offset: 28 Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NF: u1, // bit offset: 2 desc: Noise detected flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: Idle line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBDF: u1, // bit offset: 8 desc: LIN break detection flag
        CTSIF: u1, // bit offset: 9 desc: CTS interrupt flag
        CTS: u1, // bit offset: 10 desc: CTS flag
        RTOF: u1, // bit offset: 11 desc: Receiver timeout
        EOBF: u1, // bit offset: 12 desc: End of block flag
        reserved1: u1 = 0,
        ABRE: u1, // bit offset: 14 desc: Auto baud rate error
        ABRF: u1, // bit offset: 15 desc: Auto baud rate flag
        BUSY: u1, // bit offset: 16 desc: Busy flag
        CMF: u1, // bit offset: 17 desc: character match flag
        SBKF: u1, // bit offset: 18 desc: Send break flag
        RWU: u1, // bit offset: 19 desc: Receiver wakeup from Mute mode
        WUF: u1, // bit offset: 20 desc: Wakeup from Stop mode flag
        TEACK: u1, // bit offset: 21 desc: Transmit enable acknowledge flag
        REACK: u1, // bit offset: 22 desc: Receive enable acknowledge flag
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        PECF: u1, // bit offset: 0 desc: Parity error clear flag
        FECF: u1, // bit offset: 1 desc: Framing error clear flag
        NCF: u1, // bit offset: 2 desc: Noise detected clear flag
        ORECF: u1, // bit offset: 3 desc: Overrun error clear flag
        IDLECF: u1, // bit offset: 4 desc: Idle line detected clear flag
        reserved1: u1 = 0,
        TCCF: u1, // bit offset: 6 desc: Transmission complete clear flag
        reserved2: u1 = 0,
        LBDCF: u1, // bit offset: 8 desc: LIN break detection clear flag
        CTSCF: u1, // bit offset: 9 desc: CTS clear flag
        reserved3: u1 = 0,
        RTOCF: u1, // bit offset: 11 desc: Receiver timeout clear flag
        EOBCF: u1, // bit offset: 12 desc: End of timeout clear flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CMCF: u1, // bit offset: 17 desc: Character match clear flag
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        WUCF: u1, // bit offset: 20 desc: Wakeup from Stop mode clear flag
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        RDR: u9, // bit offset: 0 desc: Receive data value
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
    // byte offset: 40 Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        TDR: u9, // bit offset: 0 desc: Transmit data value
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
pub const USART2 = extern struct {
    pub const Address: u32 = 0x40004400;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        UE: u1, // bit offset: 0 desc: USART enable
        UESM: u1, // bit offset: 1 desc: USART enable in Stop mode
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Receiver wakeup method
        M: u1, // bit offset: 12 desc: Word length
        MME: u1, // bit offset: 13 desc: Mute mode enable
        CMIE: u1, // bit offset: 14 desc: Character match interrupt enable
        OVER8: u1, // bit offset: 15 desc: Oversampling mode
        DEDT: u5, // bit offset: 16 desc: Driver Enable deassertion time
        DEAT: u5, // bit offset: 21 desc: Driver Enable assertion time
        RTOIE: u1, // bit offset: 26 desc: Receiver timeout interrupt enable
        EOBIE: u1, // bit offset: 27 desc: End of Block interrupt enable
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDM7: u1, // bit offset: 4 desc: 7-bit Address Detection/4-bit Address Detection
        LBDL: u1, // bit offset: 5 desc: LIN break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved5: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        SWAP: u1, // bit offset: 15 desc: Swap TX/RX pins
        RXINV: u1, // bit offset: 16 desc: RX pin active level inversion
        TXINV: u1, // bit offset: 17 desc: TX pin active level inversion
        DATAINV: u1, // bit offset: 18 desc: Binary data inversion
        MSBFIRST: u1, // bit offset: 19 desc: Most significant bit first
        ABREN: u1, // bit offset: 20 desc: Auto baud rate enable
        ABRMOD: u2, // bit offset: 21 desc: Auto baud rate mode
        RTOEN: u1, // bit offset: 23 desc: Receiver timeout enable
        ADD0: u4, // bit offset: 24 desc: Address of the USART node
        ADD4: u4, // bit offset: 28 desc: Address of the USART node
    });
    // byte offset: 8 Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        ONEBIT: u1, // bit offset: 11 desc: One sample bit method enable
        OVRDIS: u1, // bit offset: 12 desc: Overrun Disable
        DDRE: u1, // bit offset: 13 desc: DMA Disable on Reception Error
        DEM: u1, // bit offset: 14 desc: Driver enable mode
        DEP: u1, // bit offset: 15 desc: Driver enable polarity selection
        reserved1: u1 = 0,
        SCARCNT: u3, // bit offset: 17 desc: Smartcard auto-retry count
        WUS: u2, // bit offset: 20 desc: Wakeup from Stop mode interrupt flag selection
        WUFIE: u1, // bit offset: 22 desc: Wakeup from Stop mode interrupt enable
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        RTO: u24, // bit offset: 0 desc: Receiver timeout value
        BLEN: u8, // bit offset: 24 desc: Block Length
    });
    // byte offset: 24 Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        ABRRQ: u1, // bit offset: 0 desc: Auto baud rate request
        SBKRQ: u1, // bit offset: 1 desc: Send break request
        MMRQ: u1, // bit offset: 2 desc: Mute mode request
        RXFRQ: u1, // bit offset: 3 desc: Receive data flush request
        TXFRQ: u1, // bit offset: 4 desc: Transmit data flush request
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
    // byte offset: 28 Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NF: u1, // bit offset: 2 desc: Noise detected flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: Idle line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBDF: u1, // bit offset: 8 desc: LIN break detection flag
        CTSIF: u1, // bit offset: 9 desc: CTS interrupt flag
        CTS: u1, // bit offset: 10 desc: CTS flag
        RTOF: u1, // bit offset: 11 desc: Receiver timeout
        EOBF: u1, // bit offset: 12 desc: End of block flag
        reserved1: u1 = 0,
        ABRE: u1, // bit offset: 14 desc: Auto baud rate error
        ABRF: u1, // bit offset: 15 desc: Auto baud rate flag
        BUSY: u1, // bit offset: 16 desc: Busy flag
        CMF: u1, // bit offset: 17 desc: character match flag
        SBKF: u1, // bit offset: 18 desc: Send break flag
        RWU: u1, // bit offset: 19 desc: Receiver wakeup from Mute mode
        WUF: u1, // bit offset: 20 desc: Wakeup from Stop mode flag
        TEACK: u1, // bit offset: 21 desc: Transmit enable acknowledge flag
        REACK: u1, // bit offset: 22 desc: Receive enable acknowledge flag
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        PECF: u1, // bit offset: 0 desc: Parity error clear flag
        FECF: u1, // bit offset: 1 desc: Framing error clear flag
        NCF: u1, // bit offset: 2 desc: Noise detected clear flag
        ORECF: u1, // bit offset: 3 desc: Overrun error clear flag
        IDLECF: u1, // bit offset: 4 desc: Idle line detected clear flag
        reserved1: u1 = 0,
        TCCF: u1, // bit offset: 6 desc: Transmission complete clear flag
        reserved2: u1 = 0,
        LBDCF: u1, // bit offset: 8 desc: LIN break detection clear flag
        CTSCF: u1, // bit offset: 9 desc: CTS clear flag
        reserved3: u1 = 0,
        RTOCF: u1, // bit offset: 11 desc: Receiver timeout clear flag
        EOBCF: u1, // bit offset: 12 desc: End of timeout clear flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CMCF: u1, // bit offset: 17 desc: Character match clear flag
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        WUCF: u1, // bit offset: 20 desc: Wakeup from Stop mode clear flag
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        RDR: u9, // bit offset: 0 desc: Receive data value
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
    // byte offset: 40 Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        TDR: u9, // bit offset: 0 desc: Transmit data value
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
pub const USART3 = extern struct {
    pub const Address: u32 = 0x40004800;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        UE: u1, // bit offset: 0 desc: USART enable
        UESM: u1, // bit offset: 1 desc: USART enable in Stop mode
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Receiver wakeup method
        M: u1, // bit offset: 12 desc: Word length
        MME: u1, // bit offset: 13 desc: Mute mode enable
        CMIE: u1, // bit offset: 14 desc: Character match interrupt enable
        OVER8: u1, // bit offset: 15 desc: Oversampling mode
        DEDT: u5, // bit offset: 16 desc: Driver Enable deassertion time
        DEAT: u5, // bit offset: 21 desc: Driver Enable assertion time
        RTOIE: u1, // bit offset: 26 desc: Receiver timeout interrupt enable
        EOBIE: u1, // bit offset: 27 desc: End of Block interrupt enable
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDM7: u1, // bit offset: 4 desc: 7-bit Address Detection/4-bit Address Detection
        LBDL: u1, // bit offset: 5 desc: LIN break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved5: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        SWAP: u1, // bit offset: 15 desc: Swap TX/RX pins
        RXINV: u1, // bit offset: 16 desc: RX pin active level inversion
        TXINV: u1, // bit offset: 17 desc: TX pin active level inversion
        DATAINV: u1, // bit offset: 18 desc: Binary data inversion
        MSBFIRST: u1, // bit offset: 19 desc: Most significant bit first
        ABREN: u1, // bit offset: 20 desc: Auto baud rate enable
        ABRMOD: u2, // bit offset: 21 desc: Auto baud rate mode
        RTOEN: u1, // bit offset: 23 desc: Receiver timeout enable
        ADD0: u4, // bit offset: 24 desc: Address of the USART node
        ADD4: u4, // bit offset: 28 desc: Address of the USART node
    });
    // byte offset: 8 Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        ONEBIT: u1, // bit offset: 11 desc: One sample bit method enable
        OVRDIS: u1, // bit offset: 12 desc: Overrun Disable
        DDRE: u1, // bit offset: 13 desc: DMA Disable on Reception Error
        DEM: u1, // bit offset: 14 desc: Driver enable mode
        DEP: u1, // bit offset: 15 desc: Driver enable polarity selection
        reserved1: u1 = 0,
        SCARCNT: u3, // bit offset: 17 desc: Smartcard auto-retry count
        WUS: u2, // bit offset: 20 desc: Wakeup from Stop mode interrupt flag selection
        WUFIE: u1, // bit offset: 22 desc: Wakeup from Stop mode interrupt enable
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        RTO: u24, // bit offset: 0 desc: Receiver timeout value
        BLEN: u8, // bit offset: 24 desc: Block Length
    });
    // byte offset: 24 Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        ABRRQ: u1, // bit offset: 0 desc: Auto baud rate request
        SBKRQ: u1, // bit offset: 1 desc: Send break request
        MMRQ: u1, // bit offset: 2 desc: Mute mode request
        RXFRQ: u1, // bit offset: 3 desc: Receive data flush request
        TXFRQ: u1, // bit offset: 4 desc: Transmit data flush request
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
    // byte offset: 28 Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NF: u1, // bit offset: 2 desc: Noise detected flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: Idle line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBDF: u1, // bit offset: 8 desc: LIN break detection flag
        CTSIF: u1, // bit offset: 9 desc: CTS interrupt flag
        CTS: u1, // bit offset: 10 desc: CTS flag
        RTOF: u1, // bit offset: 11 desc: Receiver timeout
        EOBF: u1, // bit offset: 12 desc: End of block flag
        reserved1: u1 = 0,
        ABRE: u1, // bit offset: 14 desc: Auto baud rate error
        ABRF: u1, // bit offset: 15 desc: Auto baud rate flag
        BUSY: u1, // bit offset: 16 desc: Busy flag
        CMF: u1, // bit offset: 17 desc: character match flag
        SBKF: u1, // bit offset: 18 desc: Send break flag
        RWU: u1, // bit offset: 19 desc: Receiver wakeup from Mute mode
        WUF: u1, // bit offset: 20 desc: Wakeup from Stop mode flag
        TEACK: u1, // bit offset: 21 desc: Transmit enable acknowledge flag
        REACK: u1, // bit offset: 22 desc: Receive enable acknowledge flag
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        PECF: u1, // bit offset: 0 desc: Parity error clear flag
        FECF: u1, // bit offset: 1 desc: Framing error clear flag
        NCF: u1, // bit offset: 2 desc: Noise detected clear flag
        ORECF: u1, // bit offset: 3 desc: Overrun error clear flag
        IDLECF: u1, // bit offset: 4 desc: Idle line detected clear flag
        reserved1: u1 = 0,
        TCCF: u1, // bit offset: 6 desc: Transmission complete clear flag
        reserved2: u1 = 0,
        LBDCF: u1, // bit offset: 8 desc: LIN break detection clear flag
        CTSCF: u1, // bit offset: 9 desc: CTS clear flag
        reserved3: u1 = 0,
        RTOCF: u1, // bit offset: 11 desc: Receiver timeout clear flag
        EOBCF: u1, // bit offset: 12 desc: End of timeout clear flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CMCF: u1, // bit offset: 17 desc: Character match clear flag
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        WUCF: u1, // bit offset: 20 desc: Wakeup from Stop mode clear flag
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        RDR: u9, // bit offset: 0 desc: Receive data value
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
    // byte offset: 40 Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        TDR: u9, // bit offset: 0 desc: Transmit data value
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
pub const UART4 = extern struct {
    pub const Address: u32 = 0x40004c00;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        UE: u1, // bit offset: 0 desc: USART enable
        UESM: u1, // bit offset: 1 desc: USART enable in Stop mode
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Receiver wakeup method
        M: u1, // bit offset: 12 desc: Word length
        MME: u1, // bit offset: 13 desc: Mute mode enable
        CMIE: u1, // bit offset: 14 desc: Character match interrupt enable
        OVER8: u1, // bit offset: 15 desc: Oversampling mode
        DEDT: u5, // bit offset: 16 desc: Driver Enable deassertion time
        DEAT: u5, // bit offset: 21 desc: Driver Enable assertion time
        RTOIE: u1, // bit offset: 26 desc: Receiver timeout interrupt enable
        EOBIE: u1, // bit offset: 27 desc: End of Block interrupt enable
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDM7: u1, // bit offset: 4 desc: 7-bit Address Detection/4-bit Address Detection
        LBDL: u1, // bit offset: 5 desc: LIN break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved5: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        SWAP: u1, // bit offset: 15 desc: Swap TX/RX pins
        RXINV: u1, // bit offset: 16 desc: RX pin active level inversion
        TXINV: u1, // bit offset: 17 desc: TX pin active level inversion
        DATAINV: u1, // bit offset: 18 desc: Binary data inversion
        MSBFIRST: u1, // bit offset: 19 desc: Most significant bit first
        ABREN: u1, // bit offset: 20 desc: Auto baud rate enable
        ABRMOD: u2, // bit offset: 21 desc: Auto baud rate mode
        RTOEN: u1, // bit offset: 23 desc: Receiver timeout enable
        ADD0: u4, // bit offset: 24 desc: Address of the USART node
        ADD4: u4, // bit offset: 28 desc: Address of the USART node
    });
    // byte offset: 8 Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        ONEBIT: u1, // bit offset: 11 desc: One sample bit method enable
        OVRDIS: u1, // bit offset: 12 desc: Overrun Disable
        DDRE: u1, // bit offset: 13 desc: DMA Disable on Reception Error
        DEM: u1, // bit offset: 14 desc: Driver enable mode
        DEP: u1, // bit offset: 15 desc: Driver enable polarity selection
        reserved1: u1 = 0,
        SCARCNT: u3, // bit offset: 17 desc: Smartcard auto-retry count
        WUS: u2, // bit offset: 20 desc: Wakeup from Stop mode interrupt flag selection
        WUFIE: u1, // bit offset: 22 desc: Wakeup from Stop mode interrupt enable
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        RTO: u24, // bit offset: 0 desc: Receiver timeout value
        BLEN: u8, // bit offset: 24 desc: Block Length
    });
    // byte offset: 24 Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        ABRRQ: u1, // bit offset: 0 desc: Auto baud rate request
        SBKRQ: u1, // bit offset: 1 desc: Send break request
        MMRQ: u1, // bit offset: 2 desc: Mute mode request
        RXFRQ: u1, // bit offset: 3 desc: Receive data flush request
        TXFRQ: u1, // bit offset: 4 desc: Transmit data flush request
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
    // byte offset: 28 Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NF: u1, // bit offset: 2 desc: Noise detected flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: Idle line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBDF: u1, // bit offset: 8 desc: LIN break detection flag
        CTSIF: u1, // bit offset: 9 desc: CTS interrupt flag
        CTS: u1, // bit offset: 10 desc: CTS flag
        RTOF: u1, // bit offset: 11 desc: Receiver timeout
        EOBF: u1, // bit offset: 12 desc: End of block flag
        reserved1: u1 = 0,
        ABRE: u1, // bit offset: 14 desc: Auto baud rate error
        ABRF: u1, // bit offset: 15 desc: Auto baud rate flag
        BUSY: u1, // bit offset: 16 desc: Busy flag
        CMF: u1, // bit offset: 17 desc: character match flag
        SBKF: u1, // bit offset: 18 desc: Send break flag
        RWU: u1, // bit offset: 19 desc: Receiver wakeup from Mute mode
        WUF: u1, // bit offset: 20 desc: Wakeup from Stop mode flag
        TEACK: u1, // bit offset: 21 desc: Transmit enable acknowledge flag
        REACK: u1, // bit offset: 22 desc: Receive enable acknowledge flag
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        PECF: u1, // bit offset: 0 desc: Parity error clear flag
        FECF: u1, // bit offset: 1 desc: Framing error clear flag
        NCF: u1, // bit offset: 2 desc: Noise detected clear flag
        ORECF: u1, // bit offset: 3 desc: Overrun error clear flag
        IDLECF: u1, // bit offset: 4 desc: Idle line detected clear flag
        reserved1: u1 = 0,
        TCCF: u1, // bit offset: 6 desc: Transmission complete clear flag
        reserved2: u1 = 0,
        LBDCF: u1, // bit offset: 8 desc: LIN break detection clear flag
        CTSCF: u1, // bit offset: 9 desc: CTS clear flag
        reserved3: u1 = 0,
        RTOCF: u1, // bit offset: 11 desc: Receiver timeout clear flag
        EOBCF: u1, // bit offset: 12 desc: End of timeout clear flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CMCF: u1, // bit offset: 17 desc: Character match clear flag
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        WUCF: u1, // bit offset: 20 desc: Wakeup from Stop mode clear flag
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        RDR: u9, // bit offset: 0 desc: Receive data value
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
    // byte offset: 40 Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        TDR: u9, // bit offset: 0 desc: Transmit data value
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
pub const UART5 = extern struct {
    pub const Address: u32 = 0x40005000;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        UE: u1, // bit offset: 0 desc: USART enable
        UESM: u1, // bit offset: 1 desc: USART enable in Stop mode
        RE: u1, // bit offset: 2 desc: Receiver enable
        TE: u1, // bit offset: 3 desc: Transmitter enable
        IDLEIE: u1, // bit offset: 4 desc: IDLE interrupt enable
        RXNEIE: u1, // bit offset: 5 desc: RXNE interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transmission complete interrupt enable
        TXEIE: u1, // bit offset: 7 desc: interrupt enable
        PEIE: u1, // bit offset: 8 desc: PE interrupt enable
        PS: u1, // bit offset: 9 desc: Parity selection
        PCE: u1, // bit offset: 10 desc: Parity control enable
        WAKE: u1, // bit offset: 11 desc: Receiver wakeup method
        M: u1, // bit offset: 12 desc: Word length
        MME: u1, // bit offset: 13 desc: Mute mode enable
        CMIE: u1, // bit offset: 14 desc: Character match interrupt enable
        OVER8: u1, // bit offset: 15 desc: Oversampling mode
        DEDT: u5, // bit offset: 16 desc: Driver Enable deassertion time
        DEAT: u5, // bit offset: 21 desc: Driver Enable assertion time
        RTOIE: u1, // bit offset: 26 desc: Receiver timeout interrupt enable
        EOBIE: u1, // bit offset: 27 desc: End of Block interrupt enable
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDM7: u1, // bit offset: 4 desc: 7-bit Address Detection/4-bit Address Detection
        LBDL: u1, // bit offset: 5 desc: LIN break detection length
        LBDIE: u1, // bit offset: 6 desc: LIN break detection interrupt enable
        reserved5: u1 = 0,
        LBCL: u1, // bit offset: 8 desc: Last bit clock pulse
        CPHA: u1, // bit offset: 9 desc: Clock phase
        CPOL: u1, // bit offset: 10 desc: Clock polarity
        CLKEN: u1, // bit offset: 11 desc: Clock enable
        STOP: u2, // bit offset: 12 desc: STOP bits
        LINEN: u1, // bit offset: 14 desc: LIN mode enable
        SWAP: u1, // bit offset: 15 desc: Swap TX/RX pins
        RXINV: u1, // bit offset: 16 desc: RX pin active level inversion
        TXINV: u1, // bit offset: 17 desc: TX pin active level inversion
        DATAINV: u1, // bit offset: 18 desc: Binary data inversion
        MSBFIRST: u1, // bit offset: 19 desc: Most significant bit first
        ABREN: u1, // bit offset: 20 desc: Auto baud rate enable
        ABRMOD: u2, // bit offset: 21 desc: Auto baud rate mode
        RTOEN: u1, // bit offset: 23 desc: Receiver timeout enable
        ADD0: u4, // bit offset: 24 desc: Address of the USART node
        ADD4: u4, // bit offset: 28 desc: Address of the USART node
    });
    // byte offset: 8 Control register 3
    pub const CR3 = mmio(Address + 0x00000008, 32, packed struct {
        EIE: u1, // bit offset: 0 desc: Error interrupt enable
        IREN: u1, // bit offset: 1 desc: IrDA mode enable
        IRLP: u1, // bit offset: 2 desc: IrDA low-power
        HDSEL: u1, // bit offset: 3 desc: Half-duplex selection
        NACK: u1, // bit offset: 4 desc: Smartcard NACK enable
        SCEN: u1, // bit offset: 5 desc: Smartcard mode enable
        DMAR: u1, // bit offset: 6 desc: DMA enable receiver
        DMAT: u1, // bit offset: 7 desc: DMA enable transmitter
        RTSE: u1, // bit offset: 8 desc: RTS enable
        CTSE: u1, // bit offset: 9 desc: CTS enable
        CTSIE: u1, // bit offset: 10 desc: CTS interrupt enable
        ONEBIT: u1, // bit offset: 11 desc: One sample bit method enable
        OVRDIS: u1, // bit offset: 12 desc: Overrun Disable
        DDRE: u1, // bit offset: 13 desc: DMA Disable on Reception Error
        DEM: u1, // bit offset: 14 desc: Driver enable mode
        DEP: u1, // bit offset: 15 desc: Driver enable polarity selection
        reserved1: u1 = 0,
        SCARCNT: u3, // bit offset: 17 desc: Smartcard auto-retry count
        WUS: u2, // bit offset: 20 desc: Wakeup from Stop mode interrupt flag selection
        WUFIE: u1, // bit offset: 22 desc: Wakeup from Stop mode interrupt enable
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Baud rate register
    pub const BRR = mmio(Address + 0x0000000c, 32, packed struct {
        DIV_Fraction: u4, // bit offset: 0 desc: fraction of USARTDIV
        DIV_Mantissa: u12, // bit offset: 4 desc: mantissa of USARTDIV
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000010, 32, packed struct {
        PSC: u8, // bit offset: 0 desc: Prescaler value
        GT: u8, // bit offset: 8 desc: Guard time value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 Receiver timeout register
    pub const RTOR = mmio(Address + 0x00000014, 32, packed struct {
        RTO: u24, // bit offset: 0 desc: Receiver timeout value
        BLEN: u8, // bit offset: 24 desc: Block Length
    });
    // byte offset: 24 Request register
    pub const RQR = mmio(Address + 0x00000018, 32, packed struct {
        ABRRQ: u1, // bit offset: 0 desc: Auto baud rate request
        SBKRQ: u1, // bit offset: 1 desc: Send break request
        MMRQ: u1, // bit offset: 2 desc: Mute mode request
        RXFRQ: u1, // bit offset: 3 desc: Receive data flush request
        TXFRQ: u1, // bit offset: 4 desc: Transmit data flush request
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
    // byte offset: 28 Interrupt & status register
    pub const ISR = mmio(Address + 0x0000001c, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Parity error
        FE: u1, // bit offset: 1 desc: Framing error
        NF: u1, // bit offset: 2 desc: Noise detected flag
        ORE: u1, // bit offset: 3 desc: Overrun error
        IDLE: u1, // bit offset: 4 desc: Idle line detected
        RXNE: u1, // bit offset: 5 desc: Read data register not empty
        TC: u1, // bit offset: 6 desc: Transmission complete
        TXE: u1, // bit offset: 7 desc: Transmit data register empty
        LBDF: u1, // bit offset: 8 desc: LIN break detection flag
        CTSIF: u1, // bit offset: 9 desc: CTS interrupt flag
        CTS: u1, // bit offset: 10 desc: CTS flag
        RTOF: u1, // bit offset: 11 desc: Receiver timeout
        EOBF: u1, // bit offset: 12 desc: End of block flag
        reserved1: u1 = 0,
        ABRE: u1, // bit offset: 14 desc: Auto baud rate error
        ABRF: u1, // bit offset: 15 desc: Auto baud rate flag
        BUSY: u1, // bit offset: 16 desc: Busy flag
        CMF: u1, // bit offset: 17 desc: character match flag
        SBKF: u1, // bit offset: 18 desc: Send break flag
        RWU: u1, // bit offset: 19 desc: Receiver wakeup from Mute mode
        WUF: u1, // bit offset: 20 desc: Wakeup from Stop mode flag
        TEACK: u1, // bit offset: 21 desc: Transmit enable acknowledge flag
        REACK: u1, // bit offset: 22 desc: Receive enable acknowledge flag
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 Interrupt flag clear register
    pub const ICR = mmio(Address + 0x00000020, 32, packed struct {
        PECF: u1, // bit offset: 0 desc: Parity error clear flag
        FECF: u1, // bit offset: 1 desc: Framing error clear flag
        NCF: u1, // bit offset: 2 desc: Noise detected clear flag
        ORECF: u1, // bit offset: 3 desc: Overrun error clear flag
        IDLECF: u1, // bit offset: 4 desc: Idle line detected clear flag
        reserved1: u1 = 0,
        TCCF: u1, // bit offset: 6 desc: Transmission complete clear flag
        reserved2: u1 = 0,
        LBDCF: u1, // bit offset: 8 desc: LIN break detection clear flag
        CTSCF: u1, // bit offset: 9 desc: CTS clear flag
        reserved3: u1 = 0,
        RTOCF: u1, // bit offset: 11 desc: Receiver timeout clear flag
        EOBCF: u1, // bit offset: 12 desc: End of timeout clear flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        CMCF: u1, // bit offset: 17 desc: Character match clear flag
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        WUCF: u1, // bit offset: 20 desc: Wakeup from Stop mode clear flag
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 Receive data register
    pub const RDR = mmio(Address + 0x00000024, 32, packed struct {
        RDR: u9, // bit offset: 0 desc: Receive data value
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
    // byte offset: 40 Transmit data register
    pub const TDR = mmio(Address + 0x00000028, 32, packed struct {
        TDR: u9, // bit offset: 0 desc: Transmit data value
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
pub const SPI1 = extern struct {
    pub const Address: u32 = 0x40013000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const SPI2 = extern struct {
    pub const Address: u32 = 0x40003800;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const SPI3 = extern struct {
    pub const Address: u32 = 0x40003c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const I2S2ext = extern struct {
    pub const Address: u32 = 0x40003400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const I2S3ext = extern struct {
    pub const Address: u32 = 0x40004000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const SPI4 = extern struct {
    pub const Address: u32 = 0x40013c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CPHA: u1, // bit offset: 0 desc: Clock phase
        CPOL: u1, // bit offset: 1 desc: Clock polarity
        MSTR: u1, // bit offset: 2 desc: Master selection
        BR: u3, // bit offset: 3 desc: Baud rate control
        SPE: u1, // bit offset: 6 desc: SPI enable
        LSBFIRST: u1, // bit offset: 7 desc: Frame format
        SSI: u1, // bit offset: 8 desc: Internal slave select
        SSM: u1, // bit offset: 9 desc: Software slave management
        RXONLY: u1, // bit offset: 10 desc: Receive only
        CRCL: u1, // bit offset: 11 desc: CRC length
        CRCNEXT: u1, // bit offset: 12 desc: CRC transfer next
        CRCEN: u1, // bit offset: 13 desc: Hardware CRC calculation enable
        BIDIOE: u1, // bit offset: 14 desc: Output enable in bidirectional mode
        BIDIMODE: u1, // bit offset: 15 desc: Bidirectional data mode enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        RXDMAEN: u1, // bit offset: 0 desc: Rx buffer DMA enable
        TXDMAEN: u1, // bit offset: 1 desc: Tx buffer DMA enable
        SSOE: u1, // bit offset: 2 desc: SS output enable
        NSSP: u1, // bit offset: 3 desc: NSS pulse management
        FRF: u1, // bit offset: 4 desc: Frame format
        ERRIE: u1, // bit offset: 5 desc: Error interrupt enable
        RXNEIE: u1, // bit offset: 6 desc: RX buffer not empty interrupt enable
        TXEIE: u1, // bit offset: 7 desc: Tx buffer empty interrupt enable
        DS: u4, // bit offset: 8 desc: Data size
        FRXTH: u1, // bit offset: 12 desc: FIFO reception threshold
        LDMA_RX: u1, // bit offset: 13 desc: Last DMA transfer for reception
        LDMA_TX: u1, // bit offset: 14 desc: Last DMA transfer for transmission
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
    // byte offset: 8 status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        RXNE: u1, // bit offset: 0 desc: Receive buffer not empty
        TXE: u1, // bit offset: 1 desc: Transmit buffer empty
        CHSIDE: u1, // bit offset: 2 desc: Channel side
        UDR: u1, // bit offset: 3 desc: Underrun flag
        CRCERR: u1, // bit offset: 4 desc: CRC error flag
        MODF: u1, // bit offset: 5 desc: Mode fault
        OVR: u1, // bit offset: 6 desc: Overrun flag
        BSY: u1, // bit offset: 7 desc: Busy flag
        TIFRFE: u1, // bit offset: 8 desc: TI frame format error
        FRLVL: u2, // bit offset: 9 desc: FIFO reception level
        FTLVL: u2, // bit offset: 11 desc: FIFO transmission level
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
    // byte offset: 12 data register
    pub const DR = mmio(Address + 0x0000000c, 32, packed struct {
        DR: u16, // bit offset: 0 desc: Data register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 CRC polynomial register
    pub const CRCPR = mmio(Address + 0x00000010, 32, packed struct {
        CRCPOLY: u16, // bit offset: 0 desc: CRC polynomial register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 RX CRC register
    pub const RXCRCR = mmio(Address + 0x00000014, 32, packed struct {
        RxCRC: u16, // bit offset: 0 desc: Rx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 TX CRC register
    pub const TXCRCR = mmio(Address + 0x00000018, 32, packed struct {
        TxCRC: u16, // bit offset: 0 desc: Tx CRC register
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 I2S configuration register
    pub const I2SCFGR = mmio(Address + 0x0000001c, 32, packed struct {
        CHLEN: u1, // bit offset: 0 desc: Channel length (number of bits per audio channel)
        DATLEN: u2, // bit offset: 1 desc: Data length to be transferred
        CKPOL: u1, // bit offset: 3 desc: Steady state clock polarity
        I2SSTD: u2, // bit offset: 4 desc: I2S standard selection
        reserved1: u1 = 0,
        PCMSYNC: u1, // bit offset: 7 desc: PCM frame synchronization
        I2SCFG: u2, // bit offset: 8 desc: I2S configuration mode
        I2SE: u1, // bit offset: 10 desc: I2S Enable
        I2SMOD: u1, // bit offset: 11 desc: I2S mode selection
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
    // byte offset: 32 I2S prescaler register
    pub const I2SPR = mmio(Address + 0x00000020, 32, packed struct {
        I2SDIV: u8, // bit offset: 0 desc: I2S Linear prescaler
        ODD: u1, // bit offset: 8 desc: Odd factor for the prescaler
        MCKOE: u1, // bit offset: 9 desc: Master clock output enable
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
pub const EXTI = extern struct {
    pub const Address: u32 = 0x40010400;
    // byte offset: 0 Interrupt mask register
    pub const IMR1 = mmio(Address + 0x00000000, 32, packed struct {
        MR0: u1, // bit offset: 0 desc: Interrupt Mask on line 0
        MR1: u1, // bit offset: 1 desc: Interrupt Mask on line 1
        MR2: u1, // bit offset: 2 desc: Interrupt Mask on line 2
        MR3: u1, // bit offset: 3 desc: Interrupt Mask on line 3
        MR4: u1, // bit offset: 4 desc: Interrupt Mask on line 4
        MR5: u1, // bit offset: 5 desc: Interrupt Mask on line 5
        MR6: u1, // bit offset: 6 desc: Interrupt Mask on line 6
        MR7: u1, // bit offset: 7 desc: Interrupt Mask on line 7
        MR8: u1, // bit offset: 8 desc: Interrupt Mask on line 8
        MR9: u1, // bit offset: 9 desc: Interrupt Mask on line 9
        MR10: u1, // bit offset: 10 desc: Interrupt Mask on line 10
        MR11: u1, // bit offset: 11 desc: Interrupt Mask on line 11
        MR12: u1, // bit offset: 12 desc: Interrupt Mask on line 12
        MR13: u1, // bit offset: 13 desc: Interrupt Mask on line 13
        MR14: u1, // bit offset: 14 desc: Interrupt Mask on line 14
        MR15: u1, // bit offset: 15 desc: Interrupt Mask on line 15
        MR16: u1, // bit offset: 16 desc: Interrupt Mask on line 16
        MR17: u1, // bit offset: 17 desc: Interrupt Mask on line 17
        MR18: u1, // bit offset: 18 desc: Interrupt Mask on line 18
        MR19: u1, // bit offset: 19 desc: Interrupt Mask on line 19
        MR20: u1, // bit offset: 20 desc: Interrupt Mask on line 20
        MR21: u1, // bit offset: 21 desc: Interrupt Mask on line 21
        MR22: u1, // bit offset: 22 desc: Interrupt Mask on line 22
        MR23: u1, // bit offset: 23 desc: Interrupt Mask on line 23
        MR24: u1, // bit offset: 24 desc: Interrupt Mask on line 24
        MR25: u1, // bit offset: 25 desc: Interrupt Mask on line 25
        MR26: u1, // bit offset: 26 desc: Interrupt Mask on line 26
        MR27: u1, // bit offset: 27 desc: Interrupt Mask on line 27
        MR28: u1, // bit offset: 28 desc: Interrupt Mask on line 28
        MR29: u1, // bit offset: 29 desc: Interrupt Mask on line 29
        MR30: u1, // bit offset: 30 desc: Interrupt Mask on line 30
        MR31: u1, // bit offset: 31 desc: Interrupt Mask on line 31
    });
    // byte offset: 4 Event mask register
    pub const EMR1 = mmio(Address + 0x00000004, 32, packed struct {
        MR0: u1, // bit offset: 0 desc: Event Mask on line 0
        MR1: u1, // bit offset: 1 desc: Event Mask on line 1
        MR2: u1, // bit offset: 2 desc: Event Mask on line 2
        MR3: u1, // bit offset: 3 desc: Event Mask on line 3
        MR4: u1, // bit offset: 4 desc: Event Mask on line 4
        MR5: u1, // bit offset: 5 desc: Event Mask on line 5
        MR6: u1, // bit offset: 6 desc: Event Mask on line 6
        MR7: u1, // bit offset: 7 desc: Event Mask on line 7
        MR8: u1, // bit offset: 8 desc: Event Mask on line 8
        MR9: u1, // bit offset: 9 desc: Event Mask on line 9
        MR10: u1, // bit offset: 10 desc: Event Mask on line 10
        MR11: u1, // bit offset: 11 desc: Event Mask on line 11
        MR12: u1, // bit offset: 12 desc: Event Mask on line 12
        MR13: u1, // bit offset: 13 desc: Event Mask on line 13
        MR14: u1, // bit offset: 14 desc: Event Mask on line 14
        MR15: u1, // bit offset: 15 desc: Event Mask on line 15
        MR16: u1, // bit offset: 16 desc: Event Mask on line 16
        MR17: u1, // bit offset: 17 desc: Event Mask on line 17
        MR18: u1, // bit offset: 18 desc: Event Mask on line 18
        MR19: u1, // bit offset: 19 desc: Event Mask on line 19
        MR20: u1, // bit offset: 20 desc: Event Mask on line 20
        MR21: u1, // bit offset: 21 desc: Event Mask on line 21
        MR22: u1, // bit offset: 22 desc: Event Mask on line 22
        MR23: u1, // bit offset: 23 desc: Event Mask on line 23
        MR24: u1, // bit offset: 24 desc: Event Mask on line 24
        MR25: u1, // bit offset: 25 desc: Event Mask on line 25
        MR26: u1, // bit offset: 26 desc: Event Mask on line 26
        MR27: u1, // bit offset: 27 desc: Event Mask on line 27
        MR28: u1, // bit offset: 28 desc: Event Mask on line 28
        MR29: u1, // bit offset: 29 desc: Event Mask on line 29
        MR30: u1, // bit offset: 30 desc: Event Mask on line 30
        MR31: u1, // bit offset: 31 desc: Event Mask on line 31
    });
    // byte offset: 8 Rising Trigger selection register
    pub const RTSR1 = mmio(Address + 0x00000008, 32, packed struct {
        TR0: u1, // bit offset: 0 desc: Rising trigger event configuration of line 0
        TR1: u1, // bit offset: 1 desc: Rising trigger event configuration of line 1
        TR2: u1, // bit offset: 2 desc: Rising trigger event configuration of line 2
        TR3: u1, // bit offset: 3 desc: Rising trigger event configuration of line 3
        TR4: u1, // bit offset: 4 desc: Rising trigger event configuration of line 4
        TR5: u1, // bit offset: 5 desc: Rising trigger event configuration of line 5
        TR6: u1, // bit offset: 6 desc: Rising trigger event configuration of line 6
        TR7: u1, // bit offset: 7 desc: Rising trigger event configuration of line 7
        TR8: u1, // bit offset: 8 desc: Rising trigger event configuration of line 8
        TR9: u1, // bit offset: 9 desc: Rising trigger event configuration of line 9
        TR10: u1, // bit offset: 10 desc: Rising trigger event configuration of line 10
        TR11: u1, // bit offset: 11 desc: Rising trigger event configuration of line 11
        TR12: u1, // bit offset: 12 desc: Rising trigger event configuration of line 12
        TR13: u1, // bit offset: 13 desc: Rising trigger event configuration of line 13
        TR14: u1, // bit offset: 14 desc: Rising trigger event configuration of line 14
        TR15: u1, // bit offset: 15 desc: Rising trigger event configuration of line 15
        TR16: u1, // bit offset: 16 desc: Rising trigger event configuration of line 16
        TR17: u1, // bit offset: 17 desc: Rising trigger event configuration of line 17
        TR18: u1, // bit offset: 18 desc: Rising trigger event configuration of line 18
        TR19: u1, // bit offset: 19 desc: Rising trigger event configuration of line 19
        TR20: u1, // bit offset: 20 desc: Rising trigger event configuration of line 20
        TR21: u1, // bit offset: 21 desc: Rising trigger event configuration of line 21
        TR22: u1, // bit offset: 22 desc: Rising trigger event configuration of line 22
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TR29: u1, // bit offset: 29 desc: Rising trigger event configuration of line 29
        TR30: u1, // bit offset: 30 desc: Rising trigger event configuration of line 30
        TR31: u1, // bit offset: 31 desc: Rising trigger event configuration of line 31
    });
    // byte offset: 12 Falling Trigger selection register
    pub const FTSR1 = mmio(Address + 0x0000000c, 32, packed struct {
        TR0: u1, // bit offset: 0 desc: Falling trigger event configuration of line 0
        TR1: u1, // bit offset: 1 desc: Falling trigger event configuration of line 1
        TR2: u1, // bit offset: 2 desc: Falling trigger event configuration of line 2
        TR3: u1, // bit offset: 3 desc: Falling trigger event configuration of line 3
        TR4: u1, // bit offset: 4 desc: Falling trigger event configuration of line 4
        TR5: u1, // bit offset: 5 desc: Falling trigger event configuration of line 5
        TR6: u1, // bit offset: 6 desc: Falling trigger event configuration of line 6
        TR7: u1, // bit offset: 7 desc: Falling trigger event configuration of line 7
        TR8: u1, // bit offset: 8 desc: Falling trigger event configuration of line 8
        TR9: u1, // bit offset: 9 desc: Falling trigger event configuration of line 9
        TR10: u1, // bit offset: 10 desc: Falling trigger event configuration of line 10
        TR11: u1, // bit offset: 11 desc: Falling trigger event configuration of line 11
        TR12: u1, // bit offset: 12 desc: Falling trigger event configuration of line 12
        TR13: u1, // bit offset: 13 desc: Falling trigger event configuration of line 13
        TR14: u1, // bit offset: 14 desc: Falling trigger event configuration of line 14
        TR15: u1, // bit offset: 15 desc: Falling trigger event configuration of line 15
        TR16: u1, // bit offset: 16 desc: Falling trigger event configuration of line 16
        TR17: u1, // bit offset: 17 desc: Falling trigger event configuration of line 17
        TR18: u1, // bit offset: 18 desc: Falling trigger event configuration of line 18
        TR19: u1, // bit offset: 19 desc: Falling trigger event configuration of line 19
        TR20: u1, // bit offset: 20 desc: Falling trigger event configuration of line 20
        TR21: u1, // bit offset: 21 desc: Falling trigger event configuration of line 21
        TR22: u1, // bit offset: 22 desc: Falling trigger event configuration of line 22
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TR29: u1, // bit offset: 29 desc: Falling trigger event configuration of line 29
        TR30: u1, // bit offset: 30 desc: Falling trigger event configuration of line 30.
        TR31: u1, // bit offset: 31 desc: Falling trigger event configuration of line 31
    });
    // byte offset: 16 Software interrupt event register
    pub const SWIER1 = mmio(Address + 0x00000010, 32, packed struct {
        SWIER0: u1, // bit offset: 0 desc: Software Interrupt on line 0
        SWIER1: u1, // bit offset: 1 desc: Software Interrupt on line 1
        SWIER2: u1, // bit offset: 2 desc: Software Interrupt on line 2
        SWIER3: u1, // bit offset: 3 desc: Software Interrupt on line 3
        SWIER4: u1, // bit offset: 4 desc: Software Interrupt on line 4
        SWIER5: u1, // bit offset: 5 desc: Software Interrupt on line 5
        SWIER6: u1, // bit offset: 6 desc: Software Interrupt on line 6
        SWIER7: u1, // bit offset: 7 desc: Software Interrupt on line 7
        SWIER8: u1, // bit offset: 8 desc: Software Interrupt on line 8
        SWIER9: u1, // bit offset: 9 desc: Software Interrupt on line 9
        SWIER10: u1, // bit offset: 10 desc: Software Interrupt on line 10
        SWIER11: u1, // bit offset: 11 desc: Software Interrupt on line 11
        SWIER12: u1, // bit offset: 12 desc: Software Interrupt on line 12
        SWIER13: u1, // bit offset: 13 desc: Software Interrupt on line 13
        SWIER14: u1, // bit offset: 14 desc: Software Interrupt on line 14
        SWIER15: u1, // bit offset: 15 desc: Software Interrupt on line 15
        SWIER16: u1, // bit offset: 16 desc: Software Interrupt on line 16
        SWIER17: u1, // bit offset: 17 desc: Software Interrupt on line 17
        SWIER18: u1, // bit offset: 18 desc: Software Interrupt on line 18
        SWIER19: u1, // bit offset: 19 desc: Software Interrupt on line 19
        SWIER20: u1, // bit offset: 20 desc: Software Interrupt on line 20
        SWIER21: u1, // bit offset: 21 desc: Software Interrupt on line 21
        SWIER22: u1, // bit offset: 22 desc: Software Interrupt on line 22
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SWIER29: u1, // bit offset: 29 desc: Software Interrupt on line 29
        SWIER30: u1, // bit offset: 30 desc: Software Interrupt on line 309
        SWIER31: u1, // bit offset: 31 desc: Software Interrupt on line 319
    });
    // byte offset: 20 Pending register
    pub const PR1 = mmio(Address + 0x00000014, 32, packed struct {
        PR0: u1, // bit offset: 0 desc: Pending bit 0
        PR1: u1, // bit offset: 1 desc: Pending bit 1
        PR2: u1, // bit offset: 2 desc: Pending bit 2
        PR3: u1, // bit offset: 3 desc: Pending bit 3
        PR4: u1, // bit offset: 4 desc: Pending bit 4
        PR5: u1, // bit offset: 5 desc: Pending bit 5
        PR6: u1, // bit offset: 6 desc: Pending bit 6
        PR7: u1, // bit offset: 7 desc: Pending bit 7
        PR8: u1, // bit offset: 8 desc: Pending bit 8
        PR9: u1, // bit offset: 9 desc: Pending bit 9
        PR10: u1, // bit offset: 10 desc: Pending bit 10
        PR11: u1, // bit offset: 11 desc: Pending bit 11
        PR12: u1, // bit offset: 12 desc: Pending bit 12
        PR13: u1, // bit offset: 13 desc: Pending bit 13
        PR14: u1, // bit offset: 14 desc: Pending bit 14
        PR15: u1, // bit offset: 15 desc: Pending bit 15
        PR16: u1, // bit offset: 16 desc: Pending bit 16
        PR17: u1, // bit offset: 17 desc: Pending bit 17
        PR18: u1, // bit offset: 18 desc: Pending bit 18
        PR19: u1, // bit offset: 19 desc: Pending bit 19
        PR20: u1, // bit offset: 20 desc: Pending bit 20
        PR21: u1, // bit offset: 21 desc: Pending bit 21
        PR22: u1, // bit offset: 22 desc: Pending bit 22
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PR29: u1, // bit offset: 29 desc: Pending bit 29
        PR30: u1, // bit offset: 30 desc: Pending bit 30
        PR31: u1, // bit offset: 31 desc: Pending bit 31
    });
    // byte offset: 24 Interrupt mask register
    pub const IMR2 = mmio(Address + 0x00000018, 32, packed struct {
        MR32: u1, // bit offset: 0 desc: Interrupt Mask on external/internal line 32
        MR33: u1, // bit offset: 1 desc: Interrupt Mask on external/internal line 33
        MR34: u1, // bit offset: 2 desc: Interrupt Mask on external/internal line 34
        MR35: u1, // bit offset: 3 desc: Interrupt Mask on external/internal line 35
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
    // byte offset: 28 Event mask register
    pub const EMR2 = mmio(Address + 0x0000001c, 32, packed struct {
        MR32: u1, // bit offset: 0 desc: Event mask on external/internal line 32
        MR33: u1, // bit offset: 1 desc: Event mask on external/internal line 33
        MR34: u1, // bit offset: 2 desc: Event mask on external/internal line 34
        MR35: u1, // bit offset: 3 desc: Event mask on external/internal line 35
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
    // byte offset: 32 Rising Trigger selection register
    pub const RTSR2 = mmio(Address + 0x00000020, 32, packed struct {
        TR32: u1, // bit offset: 0 desc: Rising trigger event configuration bit of line 32
        TR33: u1, // bit offset: 1 desc: Rising trigger event configuration bit of line 33
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
    // byte offset: 36 Falling Trigger selection register
    pub const FTSR2 = mmio(Address + 0x00000024, 32, packed struct {
        TR32: u1, // bit offset: 0 desc: Falling trigger event configuration bit of line 32
        TR33: u1, // bit offset: 1 desc: Falling trigger event configuration bit of line 33
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
    // byte offset: 40 Software interrupt event register
    pub const SWIER2 = mmio(Address + 0x00000028, 32, packed struct {
        SWIER32: u1, // bit offset: 0 desc: Software interrupt on line 32
        SWIER33: u1, // bit offset: 1 desc: Software interrupt on line 33
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
    // byte offset: 44 Pending register
    pub const PR2 = mmio(Address + 0x0000002c, 32, packed struct {
        PR32: u1, // bit offset: 0 desc: Pending bit on line 32
        PR33: u1, // bit offset: 1 desc: Pending bit on line 33
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
pub const PWR = extern struct {
    pub const Address: u32 = 0x40007000;
    // byte offset: 0 power control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        LPDS: u1, // bit offset: 0 desc: Low-power deep sleep
        PDDS: u1, // bit offset: 1 desc: Power down deepsleep
        CWUF: u1, // bit offset: 2 desc: Clear wakeup flag
        CSBF: u1, // bit offset: 3 desc: Clear standby flag
        PVDE: u1, // bit offset: 4 desc: Power voltage detector enable
        PLS: u3, // bit offset: 5 desc: PVD level selection
        DBP: u1, // bit offset: 8 desc: Disable backup domain write protection
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
    // byte offset: 4 power control/status register
    pub const CSR = mmio(Address + 0x00000004, 32, packed struct {
        WUF: u1, // bit offset: 0 desc: Wakeup flag
        SBF: u1, // bit offset: 1 desc: Standby flag
        PVDO: u1, // bit offset: 2 desc: PVD output
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        EWUP1: u1, // bit offset: 8 desc: Enable WKUP1 pin
        EWUP2: u1, // bit offset: 9 desc: Enable WKUP2 pin
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
pub const CAN = extern struct {
    pub const Address: u32 = 0x40006400;
    // byte offset: 0 master control register
    pub const MCR = mmio(Address + 0x00000000, 32, packed struct {
        INRQ: u1, // bit offset: 0 desc: INRQ
        SLEEP: u1, // bit offset: 1 desc: SLEEP
        TXFP: u1, // bit offset: 2 desc: TXFP
        RFLM: u1, // bit offset: 3 desc: RFLM
        NART: u1, // bit offset: 4 desc: NART
        AWUM: u1, // bit offset: 5 desc: AWUM
        ABOM: u1, // bit offset: 6 desc: ABOM
        TTCM: u1, // bit offset: 7 desc: TTCM
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RESET: u1, // bit offset: 15 desc: RESET
        DBF: u1, // bit offset: 16 desc: DBF
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 master status register
    pub const MSR = mmio(Address + 0x00000004, 32, packed struct {
        INAK: u1, // bit offset: 0 desc: INAK
        SLAK: u1, // bit offset: 1 desc: SLAK
        ERRI: u1, // bit offset: 2 desc: ERRI
        WKUI: u1, // bit offset: 3 desc: WKUI
        SLAKI: u1, // bit offset: 4 desc: SLAKI
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TXM: u1, // bit offset: 8 desc: TXM
        RXM: u1, // bit offset: 9 desc: RXM
        SAMP: u1, // bit offset: 10 desc: SAMP
        RX: u1, // bit offset: 11 desc: RX
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
    // byte offset: 8 transmit status register
    pub const TSR = mmio(Address + 0x00000008, 32, packed struct {
        RQCP0: u1, // bit offset: 0 desc: RQCP0
        TXOK0: u1, // bit offset: 1 desc: TXOK0
        ALST0: u1, // bit offset: 2 desc: ALST0
        TERR0: u1, // bit offset: 3 desc: TERR0
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ABRQ0: u1, // bit offset: 7 desc: ABRQ0
        RQCP1: u1, // bit offset: 8 desc: RQCP1
        TXOK1: u1, // bit offset: 9 desc: TXOK1
        ALST1: u1, // bit offset: 10 desc: ALST1
        TERR1: u1, // bit offset: 11 desc: TERR1
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        ABRQ1: u1, // bit offset: 15 desc: ABRQ1
        RQCP2: u1, // bit offset: 16 desc: RQCP2
        TXOK2: u1, // bit offset: 17 desc: TXOK2
        ALST2: u1, // bit offset: 18 desc: ALST2
        TERR2: u1, // bit offset: 19 desc: TERR2
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        ABRQ2: u1, // bit offset: 23 desc: ABRQ2
        CODE: u2, // bit offset: 24 desc: CODE
        TME0: u1, // bit offset: 26 desc: Lowest priority flag for mailbox 0
        TME1: u1, // bit offset: 27 desc: Lowest priority flag for mailbox 1
        TME2: u1, // bit offset: 28 desc: Lowest priority flag for mailbox 2
        LOW0: u1, // bit offset: 29 desc: Lowest priority flag for mailbox 0
        LOW1: u1, // bit offset: 30 desc: Lowest priority flag for mailbox 1
        LOW2: u1, // bit offset: 31 desc: Lowest priority flag for mailbox 2
    });
    // byte offset: 12 receive FIFO 0 register
    pub const RF0R = mmio(Address + 0x0000000c, 32, packed struct {
        FMP0: u2, // bit offset: 0 desc: FMP0
        reserved1: u1 = 0,
        FULL0: u1, // bit offset: 3 desc: FULL0
        FOVR0: u1, // bit offset: 4 desc: FOVR0
        RFOM0: u1, // bit offset: 5 desc: RFOM0
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
    // byte offset: 16 receive FIFO 1 register
    pub const RF1R = mmio(Address + 0x00000010, 32, packed struct {
        FMP1: u2, // bit offset: 0 desc: FMP1
        reserved1: u1 = 0,
        FULL1: u1, // bit offset: 3 desc: FULL1
        FOVR1: u1, // bit offset: 4 desc: FOVR1
        RFOM1: u1, // bit offset: 5 desc: RFOM1
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
    // byte offset: 20 interrupt enable register
    pub const IER = mmio(Address + 0x00000014, 32, packed struct {
        TMEIE: u1, // bit offset: 0 desc: TMEIE
        FMPIE0: u1, // bit offset: 1 desc: FMPIE0
        FFIE0: u1, // bit offset: 2 desc: FFIE0
        FOVIE0: u1, // bit offset: 3 desc: FOVIE0
        FMPIE1: u1, // bit offset: 4 desc: FMPIE1
        FFIE1: u1, // bit offset: 5 desc: FFIE1
        FOVIE1: u1, // bit offset: 6 desc: FOVIE1
        reserved1: u1 = 0,
        EWGIE: u1, // bit offset: 8 desc: EWGIE
        EPVIE: u1, // bit offset: 9 desc: EPVIE
        BOFIE: u1, // bit offset: 10 desc: BOFIE
        LECIE: u1, // bit offset: 11 desc: LECIE
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        ERRIE: u1, // bit offset: 15 desc: ERRIE
        WKUIE: u1, // bit offset: 16 desc: WKUIE
        SLKIE: u1, // bit offset: 17 desc: SLKIE
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 error status register
    pub const ESR = mmio(Address + 0x00000018, 32, packed struct {
        EWGF: u1, // bit offset: 0 desc: EWGF
        EPVF: u1, // bit offset: 1 desc: EPVF
        BOFF: u1, // bit offset: 2 desc: BOFF
        reserved1: u1 = 0,
        LEC: u3, // bit offset: 4 desc: LEC
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TEC: u8, // bit offset: 16 desc: TEC
        REC: u8, // bit offset: 24 desc: REC
    });
    // byte offset: 28 bit timing register
    pub const BTR = mmio(Address + 0x0000001c, 32, packed struct {
        BRP: u10, // bit offset: 0 desc: BRP
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TS1: u4, // bit offset: 16 desc: TS1
        TS2: u3, // bit offset: 20 desc: TS2
        reserved7: u1 = 0,
        SJW: u2, // bit offset: 24 desc: SJW
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        LBKM: u1, // bit offset: 30 desc: LBKM
        SILM: u1, // bit offset: 31 desc: SILM
    });
    // byte offset: 384 TX mailbox identifier register
    pub const TI0R = mmio(Address + 0x00000180, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 388 mailbox data length control and time stamp register
    pub const TDT0R = mmio(Address + 0x00000184, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 392 mailbox data low register
    pub const TDL0R = mmio(Address + 0x00000188, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 396 mailbox data high register
    pub const TDH0R = mmio(Address + 0x0000018c, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 400 TX mailbox identifier register
    pub const TI1R = mmio(Address + 0x00000190, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 404 mailbox data length control and time stamp register
    pub const TDT1R = mmio(Address + 0x00000194, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 408 mailbox data low register
    pub const TDL1R = mmio(Address + 0x00000198, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 412 mailbox data high register
    pub const TDH1R = mmio(Address + 0x0000019c, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 416 TX mailbox identifier register
    pub const TI2R = mmio(Address + 0x000001a0, 32, packed struct {
        TXRQ: u1, // bit offset: 0 desc: TXRQ
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 420 mailbox data length control and time stamp register
    pub const TDT2R = mmio(Address + 0x000001a4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TGT: u1, // bit offset: 8 desc: TGT
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 424 mailbox data low register
    pub const TDL2R = mmio(Address + 0x000001a8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 428 mailbox data high register
    pub const TDH2R = mmio(Address + 0x000001ac, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 432 receive FIFO mailbox identifier register
    pub const RI0R = mmio(Address + 0x000001b0, 32, packed struct {
        reserved1: u1 = 0,
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 436 receive FIFO mailbox data length control and time stamp register
    pub const RDT0R = mmio(Address + 0x000001b4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        FMI: u8, // bit offset: 8 desc: FMI
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 440 receive FIFO mailbox data low register
    pub const RDL0R = mmio(Address + 0x000001b8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 444 receive FIFO mailbox data high register
    pub const RDH0R = mmio(Address + 0x000001bc, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 448 receive FIFO mailbox identifier register
    pub const RI1R = mmio(Address + 0x000001c0, 32, packed struct {
        reserved1: u1 = 0,
        RTR: u1, // bit offset: 1 desc: RTR
        IDE: u1, // bit offset: 2 desc: IDE
        EXID: u18, // bit offset: 3 desc: EXID
        STID: u11, // bit offset: 21 desc: STID
    });
    // byte offset: 452 receive FIFO mailbox data length control and time stamp register
    pub const RDT1R = mmio(Address + 0x000001c4, 32, packed struct {
        DLC: u4, // bit offset: 0 desc: DLC
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        FMI: u8, // bit offset: 8 desc: FMI
        TIME: u16, // bit offset: 16 desc: TIME
    });
    // byte offset: 456 receive FIFO mailbox data low register
    pub const RDL1R = mmio(Address + 0x000001c8, 32, packed struct {
        DATA0: u8, // bit offset: 0 desc: DATA0
        DATA1: u8, // bit offset: 8 desc: DATA1
        DATA2: u8, // bit offset: 16 desc: DATA2
        DATA3: u8, // bit offset: 24 desc: DATA3
    });
    // byte offset: 460 receive FIFO mailbox data high register
    pub const RDH1R = mmio(Address + 0x000001cc, 32, packed struct {
        DATA4: u8, // bit offset: 0 desc: DATA4
        DATA5: u8, // bit offset: 8 desc: DATA5
        DATA6: u8, // bit offset: 16 desc: DATA6
        DATA7: u8, // bit offset: 24 desc: DATA7
    });
    // byte offset: 512 filter master register
    pub const FMR = mmio(Address + 0x00000200, 32, packed struct {
        FINIT: u1, // bit offset: 0 desc: Filter init mode
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CAN2SB: u6, // bit offset: 8 desc: CAN2 start bank
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
    // byte offset: 516 filter mode register
    pub const FM1R = mmio(Address + 0x00000204, 32, packed struct {
        FBM0: u1, // bit offset: 0 desc: Filter mode
        FBM1: u1, // bit offset: 1 desc: Filter mode
        FBM2: u1, // bit offset: 2 desc: Filter mode
        FBM3: u1, // bit offset: 3 desc: Filter mode
        FBM4: u1, // bit offset: 4 desc: Filter mode
        FBM5: u1, // bit offset: 5 desc: Filter mode
        FBM6: u1, // bit offset: 6 desc: Filter mode
        FBM7: u1, // bit offset: 7 desc: Filter mode
        FBM8: u1, // bit offset: 8 desc: Filter mode
        FBM9: u1, // bit offset: 9 desc: Filter mode
        FBM10: u1, // bit offset: 10 desc: Filter mode
        FBM11: u1, // bit offset: 11 desc: Filter mode
        FBM12: u1, // bit offset: 12 desc: Filter mode
        FBM13: u1, // bit offset: 13 desc: Filter mode
        FBM14: u1, // bit offset: 14 desc: Filter mode
        FBM15: u1, // bit offset: 15 desc: Filter mode
        FBM16: u1, // bit offset: 16 desc: Filter mode
        FBM17: u1, // bit offset: 17 desc: Filter mode
        FBM18: u1, // bit offset: 18 desc: Filter mode
        FBM19: u1, // bit offset: 19 desc: Filter mode
        FBM20: u1, // bit offset: 20 desc: Filter mode
        FBM21: u1, // bit offset: 21 desc: Filter mode
        FBM22: u1, // bit offset: 22 desc: Filter mode
        FBM23: u1, // bit offset: 23 desc: Filter mode
        FBM24: u1, // bit offset: 24 desc: Filter mode
        FBM25: u1, // bit offset: 25 desc: Filter mode
        FBM26: u1, // bit offset: 26 desc: Filter mode
        FBM27: u1, // bit offset: 27 desc: Filter mode
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 524 filter scale register
    pub const FS1R = mmio(Address + 0x0000020c, 32, packed struct {
        FSC0: u1, // bit offset: 0 desc: Filter scale configuration
        FSC1: u1, // bit offset: 1 desc: Filter scale configuration
        FSC2: u1, // bit offset: 2 desc: Filter scale configuration
        FSC3: u1, // bit offset: 3 desc: Filter scale configuration
        FSC4: u1, // bit offset: 4 desc: Filter scale configuration
        FSC5: u1, // bit offset: 5 desc: Filter scale configuration
        FSC6: u1, // bit offset: 6 desc: Filter scale configuration
        FSC7: u1, // bit offset: 7 desc: Filter scale configuration
        FSC8: u1, // bit offset: 8 desc: Filter scale configuration
        FSC9: u1, // bit offset: 9 desc: Filter scale configuration
        FSC10: u1, // bit offset: 10 desc: Filter scale configuration
        FSC11: u1, // bit offset: 11 desc: Filter scale configuration
        FSC12: u1, // bit offset: 12 desc: Filter scale configuration
        FSC13: u1, // bit offset: 13 desc: Filter scale configuration
        FSC14: u1, // bit offset: 14 desc: Filter scale configuration
        FSC15: u1, // bit offset: 15 desc: Filter scale configuration
        FSC16: u1, // bit offset: 16 desc: Filter scale configuration
        FSC17: u1, // bit offset: 17 desc: Filter scale configuration
        FSC18: u1, // bit offset: 18 desc: Filter scale configuration
        FSC19: u1, // bit offset: 19 desc: Filter scale configuration
        FSC20: u1, // bit offset: 20 desc: Filter scale configuration
        FSC21: u1, // bit offset: 21 desc: Filter scale configuration
        FSC22: u1, // bit offset: 22 desc: Filter scale configuration
        FSC23: u1, // bit offset: 23 desc: Filter scale configuration
        FSC24: u1, // bit offset: 24 desc: Filter scale configuration
        FSC25: u1, // bit offset: 25 desc: Filter scale configuration
        FSC26: u1, // bit offset: 26 desc: Filter scale configuration
        FSC27: u1, // bit offset: 27 desc: Filter scale configuration
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 532 filter FIFO assignment register
    pub const FFA1R = mmio(Address + 0x00000214, 32, packed struct {
        FFA0: u1, // bit offset: 0 desc: Filter FIFO assignment for filter 0
        FFA1: u1, // bit offset: 1 desc: Filter FIFO assignment for filter 1
        FFA2: u1, // bit offset: 2 desc: Filter FIFO assignment for filter 2
        FFA3: u1, // bit offset: 3 desc: Filter FIFO assignment for filter 3
        FFA4: u1, // bit offset: 4 desc: Filter FIFO assignment for filter 4
        FFA5: u1, // bit offset: 5 desc: Filter FIFO assignment for filter 5
        FFA6: u1, // bit offset: 6 desc: Filter FIFO assignment for filter 6
        FFA7: u1, // bit offset: 7 desc: Filter FIFO assignment for filter 7
        FFA8: u1, // bit offset: 8 desc: Filter FIFO assignment for filter 8
        FFA9: u1, // bit offset: 9 desc: Filter FIFO assignment for filter 9
        FFA10: u1, // bit offset: 10 desc: Filter FIFO assignment for filter 10
        FFA11: u1, // bit offset: 11 desc: Filter FIFO assignment for filter 11
        FFA12: u1, // bit offset: 12 desc: Filter FIFO assignment for filter 12
        FFA13: u1, // bit offset: 13 desc: Filter FIFO assignment for filter 13
        FFA14: u1, // bit offset: 14 desc: Filter FIFO assignment for filter 14
        FFA15: u1, // bit offset: 15 desc: Filter FIFO assignment for filter 15
        FFA16: u1, // bit offset: 16 desc: Filter FIFO assignment for filter 16
        FFA17: u1, // bit offset: 17 desc: Filter FIFO assignment for filter 17
        FFA18: u1, // bit offset: 18 desc: Filter FIFO assignment for filter 18
        FFA19: u1, // bit offset: 19 desc: Filter FIFO assignment for filter 19
        FFA20: u1, // bit offset: 20 desc: Filter FIFO assignment for filter 20
        FFA21: u1, // bit offset: 21 desc: Filter FIFO assignment for filter 21
        FFA22: u1, // bit offset: 22 desc: Filter FIFO assignment for filter 22
        FFA23: u1, // bit offset: 23 desc: Filter FIFO assignment for filter 23
        FFA24: u1, // bit offset: 24 desc: Filter FIFO assignment for filter 24
        FFA25: u1, // bit offset: 25 desc: Filter FIFO assignment for filter 25
        FFA26: u1, // bit offset: 26 desc: Filter FIFO assignment for filter 26
        FFA27: u1, // bit offset: 27 desc: Filter FIFO assignment for filter 27
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 540 CAN filter activation register
    pub const FA1R = mmio(Address + 0x0000021c, 32, packed struct {
        FACT0: u1, // bit offset: 0 desc: Filter active
        FACT1: u1, // bit offset: 1 desc: Filter active
        FACT2: u1, // bit offset: 2 desc: Filter active
        FACT3: u1, // bit offset: 3 desc: Filter active
        FACT4: u1, // bit offset: 4 desc: Filter active
        FACT5: u1, // bit offset: 5 desc: Filter active
        FACT6: u1, // bit offset: 6 desc: Filter active
        FACT7: u1, // bit offset: 7 desc: Filter active
        FACT8: u1, // bit offset: 8 desc: Filter active
        FACT9: u1, // bit offset: 9 desc: Filter active
        FACT10: u1, // bit offset: 10 desc: Filter active
        FACT11: u1, // bit offset: 11 desc: Filter active
        FACT12: u1, // bit offset: 12 desc: Filter active
        FACT13: u1, // bit offset: 13 desc: Filter active
        FACT14: u1, // bit offset: 14 desc: Filter active
        FACT15: u1, // bit offset: 15 desc: Filter active
        FACT16: u1, // bit offset: 16 desc: Filter active
        FACT17: u1, // bit offset: 17 desc: Filter active
        FACT18: u1, // bit offset: 18 desc: Filter active
        FACT19: u1, // bit offset: 19 desc: Filter active
        FACT20: u1, // bit offset: 20 desc: Filter active
        FACT21: u1, // bit offset: 21 desc: Filter active
        FACT22: u1, // bit offset: 22 desc: Filter active
        FACT23: u1, // bit offset: 23 desc: Filter active
        FACT24: u1, // bit offset: 24 desc: Filter active
        FACT25: u1, // bit offset: 25 desc: Filter active
        FACT26: u1, // bit offset: 26 desc: Filter active
        FACT27: u1, // bit offset: 27 desc: Filter active
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 576 Filter bank 0 register 1
    pub const F0R1 = mmio(Address + 0x00000240, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 580 Filter bank 0 register 2
    pub const F0R2 = mmio(Address + 0x00000244, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 584 Filter bank 1 register 1
    pub const F1R1 = mmio(Address + 0x00000248, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 588 Filter bank 1 register 2
    pub const F1R2 = mmio(Address + 0x0000024c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 592 Filter bank 2 register 1
    pub const F2R1 = mmio(Address + 0x00000250, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 596 Filter bank 2 register 2
    pub const F2R2 = mmio(Address + 0x00000254, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 600 Filter bank 3 register 1
    pub const F3R1 = mmio(Address + 0x00000258, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 604 Filter bank 3 register 2
    pub const F3R2 = mmio(Address + 0x0000025c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 608 Filter bank 4 register 1
    pub const F4R1 = mmio(Address + 0x00000260, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 612 Filter bank 4 register 2
    pub const F4R2 = mmio(Address + 0x00000264, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 616 Filter bank 5 register 1
    pub const F5R1 = mmio(Address + 0x00000268, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 620 Filter bank 5 register 2
    pub const F5R2 = mmio(Address + 0x0000026c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 624 Filter bank 6 register 1
    pub const F6R1 = mmio(Address + 0x00000270, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 628 Filter bank 6 register 2
    pub const F6R2 = mmio(Address + 0x00000274, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 632 Filter bank 7 register 1
    pub const F7R1 = mmio(Address + 0x00000278, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 636 Filter bank 7 register 2
    pub const F7R2 = mmio(Address + 0x0000027c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 640 Filter bank 8 register 1
    pub const F8R1 = mmio(Address + 0x00000280, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 644 Filter bank 8 register 2
    pub const F8R2 = mmio(Address + 0x00000284, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 648 Filter bank 9 register 1
    pub const F9R1 = mmio(Address + 0x00000288, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 652 Filter bank 9 register 2
    pub const F9R2 = mmio(Address + 0x0000028c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 656 Filter bank 10 register 1
    pub const F10R1 = mmio(Address + 0x00000290, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 660 Filter bank 10 register 2
    pub const F10R2 = mmio(Address + 0x00000294, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 664 Filter bank 11 register 1
    pub const F11R1 = mmio(Address + 0x00000298, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 668 Filter bank 11 register 2
    pub const F11R2 = mmio(Address + 0x0000029c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 672 Filter bank 4 register 1
    pub const F12R1 = mmio(Address + 0x000002a0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 676 Filter bank 12 register 2
    pub const F12R2 = mmio(Address + 0x000002a4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 680 Filter bank 13 register 1
    pub const F13R1 = mmio(Address + 0x000002a8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 684 Filter bank 13 register 2
    pub const F13R2 = mmio(Address + 0x000002ac, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 688 Filter bank 14 register 1
    pub const F14R1 = mmio(Address + 0x000002b0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 692 Filter bank 14 register 2
    pub const F14R2 = mmio(Address + 0x000002b4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 696 Filter bank 15 register 1
    pub const F15R1 = mmio(Address + 0x000002b8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 700 Filter bank 15 register 2
    pub const F15R2 = mmio(Address + 0x000002bc, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 704 Filter bank 16 register 1
    pub const F16R1 = mmio(Address + 0x000002c0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 708 Filter bank 16 register 2
    pub const F16R2 = mmio(Address + 0x000002c4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 712 Filter bank 17 register 1
    pub const F17R1 = mmio(Address + 0x000002c8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 716 Filter bank 17 register 2
    pub const F17R2 = mmio(Address + 0x000002cc, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 720 Filter bank 18 register 1
    pub const F18R1 = mmio(Address + 0x000002d0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 724 Filter bank 18 register 2
    pub const F18R2 = mmio(Address + 0x000002d4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 728 Filter bank 19 register 1
    pub const F19R1 = mmio(Address + 0x000002d8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 732 Filter bank 19 register 2
    pub const F19R2 = mmio(Address + 0x000002dc, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 736 Filter bank 20 register 1
    pub const F20R1 = mmio(Address + 0x000002e0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 740 Filter bank 20 register 2
    pub const F20R2 = mmio(Address + 0x000002e4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 744 Filter bank 21 register 1
    pub const F21R1 = mmio(Address + 0x000002e8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 748 Filter bank 21 register 2
    pub const F21R2 = mmio(Address + 0x000002ec, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 752 Filter bank 22 register 1
    pub const F22R1 = mmio(Address + 0x000002f0, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 756 Filter bank 22 register 2
    pub const F22R2 = mmio(Address + 0x000002f4, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 760 Filter bank 23 register 1
    pub const F23R1 = mmio(Address + 0x000002f8, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 764 Filter bank 23 register 2
    pub const F23R2 = mmio(Address + 0x000002fc, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 768 Filter bank 24 register 1
    pub const F24R1 = mmio(Address + 0x00000300, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 772 Filter bank 24 register 2
    pub const F24R2 = mmio(Address + 0x00000304, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 776 Filter bank 25 register 1
    pub const F25R1 = mmio(Address + 0x00000308, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 780 Filter bank 25 register 2
    pub const F25R2 = mmio(Address + 0x0000030c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 784 Filter bank 26 register 1
    pub const F26R1 = mmio(Address + 0x00000310, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 788 Filter bank 26 register 2
    pub const F26R2 = mmio(Address + 0x00000314, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 792 Filter bank 27 register 1
    pub const F27R1 = mmio(Address + 0x00000318, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
    // byte offset: 796 Filter bank 27 register 2
    pub const F27R2 = mmio(Address + 0x0000031c, 32, packed struct {
        FB0: u1, // bit offset: 0 desc: Filter bits
        FB1: u1, // bit offset: 1 desc: Filter bits
        FB2: u1, // bit offset: 2 desc: Filter bits
        FB3: u1, // bit offset: 3 desc: Filter bits
        FB4: u1, // bit offset: 4 desc: Filter bits
        FB5: u1, // bit offset: 5 desc: Filter bits
        FB6: u1, // bit offset: 6 desc: Filter bits
        FB7: u1, // bit offset: 7 desc: Filter bits
        FB8: u1, // bit offset: 8 desc: Filter bits
        FB9: u1, // bit offset: 9 desc: Filter bits
        FB10: u1, // bit offset: 10 desc: Filter bits
        FB11: u1, // bit offset: 11 desc: Filter bits
        FB12: u1, // bit offset: 12 desc: Filter bits
        FB13: u1, // bit offset: 13 desc: Filter bits
        FB14: u1, // bit offset: 14 desc: Filter bits
        FB15: u1, // bit offset: 15 desc: Filter bits
        FB16: u1, // bit offset: 16 desc: Filter bits
        FB17: u1, // bit offset: 17 desc: Filter bits
        FB18: u1, // bit offset: 18 desc: Filter bits
        FB19: u1, // bit offset: 19 desc: Filter bits
        FB20: u1, // bit offset: 20 desc: Filter bits
        FB21: u1, // bit offset: 21 desc: Filter bits
        FB22: u1, // bit offset: 22 desc: Filter bits
        FB23: u1, // bit offset: 23 desc: Filter bits
        FB24: u1, // bit offset: 24 desc: Filter bits
        FB25: u1, // bit offset: 25 desc: Filter bits
        FB26: u1, // bit offset: 26 desc: Filter bits
        FB27: u1, // bit offset: 27 desc: Filter bits
        FB28: u1, // bit offset: 28 desc: Filter bits
        FB29: u1, // bit offset: 29 desc: Filter bits
        FB30: u1, // bit offset: 30 desc: Filter bits
        FB31: u1, // bit offset: 31 desc: Filter bits
    });
};
pub const USB_FS = extern struct {
    pub const Address: u32 = 0x40005c00;
    // byte offset: 0 endpoint 0 register
    pub const USB_EP0R = mmio(Address + 0x00000000, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 endpoint 1 register
    pub const USB_EP1R = mmio(Address + 0x00000004, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 endpoint 2 register
    pub const USB_EP2R = mmio(Address + 0x00000008, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 endpoint 3 register
    pub const USB_EP3R = mmio(Address + 0x0000000c, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 endpoint 4 register
    pub const USB_EP4R = mmio(Address + 0x00000010, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 endpoint 5 register
    pub const USB_EP5R = mmio(Address + 0x00000014, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 endpoint 6 register
    pub const USB_EP6R = mmio(Address + 0x00000018, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 endpoint 7 register
    pub const USB_EP7R = mmio(Address + 0x0000001c, 32, packed struct {
        EA: u4, // bit offset: 0 desc: Endpoint address
        STAT_TX: u2, // bit offset: 4 desc: Status bits, for transmission transfers
        DTOG_TX: u1, // bit offset: 6 desc: Data Toggle, for transmission transfers
        CTR_TX: u1, // bit offset: 7 desc: Correct Transfer for transmission
        EP_KIND: u1, // bit offset: 8 desc: Endpoint kind
        EP_TYPE: u2, // bit offset: 9 desc: Endpoint type
        SETUP: u1, // bit offset: 11 desc: Setup transaction completed
        STAT_RX: u2, // bit offset: 12 desc: Status bits, for reception transfers
        DTOG_RX: u1, // bit offset: 14 desc: Data Toggle, for reception transfers
        CTR_RX: u1, // bit offset: 15 desc: Correct transfer for reception
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 control register
    pub const USB_CNTR = mmio(Address + 0x00000040, 32, packed struct {
        FRES: u1, // bit offset: 0 desc: Force USB Reset
        PDWN: u1, // bit offset: 1 desc: Power down
        LPMODE: u1, // bit offset: 2 desc: Low-power mode
        FSUSP: u1, // bit offset: 3 desc: Force suspend
        RESUME: u1, // bit offset: 4 desc: Resume request
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ESOFM: u1, // bit offset: 8 desc: Expected start of frame interrupt mask
        SOFM: u1, // bit offset: 9 desc: Start of frame interrupt mask
        RESETM: u1, // bit offset: 10 desc: USB reset interrupt mask
        SUSPM: u1, // bit offset: 11 desc: Suspend mode interrupt mask
        WKUPM: u1, // bit offset: 12 desc: Wakeup interrupt mask
        ERRM: u1, // bit offset: 13 desc: Error interrupt mask
        PMAOVRM: u1, // bit offset: 14 desc: Packet memory area over / underrun interrupt mask
        CTRM: u1, // bit offset: 15 desc: Correct transfer interrupt mask
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 interrupt status register
    pub const ISTR = mmio(Address + 0x00000044, 32, packed struct {
        EP_ID: u4, // bit offset: 0 desc: Endpoint Identifier
        DIR: u1, // bit offset: 4 desc: Direction of transaction
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ESOF: u1, // bit offset: 8 desc: Expected start frame
        SOF: u1, // bit offset: 9 desc: start of frame
        RESET: u1, // bit offset: 10 desc: reset request
        SUSP: u1, // bit offset: 11 desc: Suspend mode request
        WKUP: u1, // bit offset: 12 desc: Wakeup
        ERR: u1, // bit offset: 13 desc: Error
        PMAOVR: u1, // bit offset: 14 desc: Packet memory area over / underrun
        CTR: u1, // bit offset: 15 desc: Correct transfer
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 frame number register
    pub const FNR = mmio(Address + 0x00000048, 32, packed struct {
        FN: u11, // bit offset: 0 desc: Frame number
        LSOF: u2, // bit offset: 11 desc: Lost SOF
        LCK: u1, // bit offset: 13 desc: Locked
        RXDM: u1, // bit offset: 14 desc: Receive data - line status
        RXDP: u1, // bit offset: 15 desc: Receive data + line status
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 device address
    pub const DADDR = mmio(Address + 0x0000004c, 32, packed struct {
        ADD: u1, // bit offset: 0 desc: Device address
        ADD1: u1, // bit offset: 1 desc: Device address
        ADD2: u1, // bit offset: 2 desc: Device address
        ADD3: u1, // bit offset: 3 desc: Device address
        ADD4: u1, // bit offset: 4 desc: Device address
        ADD5: u1, // bit offset: 5 desc: Device address
        ADD6: u1, // bit offset: 6 desc: Device address
        EF: u1, // bit offset: 7 desc: Enable function
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
    // byte offset: 80 Buffer table address
    pub const BTABLE = mmio(Address + 0x00000050, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        BTABLE: u13, // bit offset: 3 desc: Buffer table
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const I2C1 = extern struct {
    pub const Address: u32 = 0x40005400;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Peripheral enable
        TXIE: u1, // bit offset: 1 desc: TX Interrupt enable
        RXIE: u1, // bit offset: 2 desc: RX Interrupt enable
        ADDRIE: u1, // bit offset: 3 desc: Address match interrupt enable (slave only)
        NACKIE: u1, // bit offset: 4 desc: Not acknowledge received interrupt enable
        STOPIE: u1, // bit offset: 5 desc: STOP detection Interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transfer Complete interrupt enable
        ERRIE: u1, // bit offset: 7 desc: Error interrupts enable
        DNF: u4, // bit offset: 8 desc: Digital noise filter
        ANFOFF: u1, // bit offset: 12 desc: Analog noise filter OFF
        SWRST: u1, // bit offset: 13 desc: Software reset
        TXDMAEN: u1, // bit offset: 14 desc: DMA transmission requests enable
        RXDMAEN: u1, // bit offset: 15 desc: DMA reception requests enable
        SBC: u1, // bit offset: 16 desc: Slave byte control
        NOSTRETCH: u1, // bit offset: 17 desc: Clock stretching disable
        WUPEN: u1, // bit offset: 18 desc: Wakeup from STOP enable
        GCEN: u1, // bit offset: 19 desc: General call enable
        SMBHEN: u1, // bit offset: 20 desc: SMBus Host address enable
        SMBDEN: u1, // bit offset: 21 desc: SMBus Device Default address enable
        ALERTEN: u1, // bit offset: 22 desc: SMBUS alert enable
        PECEN: u1, // bit offset: 23 desc: PEC enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        SADD0: u1, // bit offset: 0 desc: Slave address bit 0 (master mode)
        SADD1: u7, // bit offset: 1 desc: Slave address bit 7:1 (master mode)
        SADD8: u2, // bit offset: 8 desc: Slave address bit 9:8 (master mode)
        RD_WRN: u1, // bit offset: 10 desc: Transfer direction (master mode)
        ADD10: u1, // bit offset: 11 desc: 10-bit addressing mode (master mode)
        HEAD10R: u1, // bit offset: 12 desc: 10-bit address header only read direction (master receiver mode)
        START: u1, // bit offset: 13 desc: Start generation
        STOP: u1, // bit offset: 14 desc: Stop generation (master mode)
        NACK: u1, // bit offset: 15 desc: NACK generation (slave mode)
        NBYTES: u8, // bit offset: 16 desc: Number of bytes
        RELOAD: u1, // bit offset: 24 desc: NBYTES reload mode
        AUTOEND: u1, // bit offset: 25 desc: Automatic end mode (master mode)
        PECBYTE: u1, // bit offset: 26 desc: Packet error checking byte
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        OA1_0: u1, // bit offset: 0 desc: Interface address
        OA1_1: u7, // bit offset: 1 desc: Interface address
        OA1_8: u2, // bit offset: 8 desc: Interface address
        OA1MODE: u1, // bit offset: 10 desc: Own Address 1 10-bit mode
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OA1EN: u1, // bit offset: 15 desc: Own Address 1 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        OA2: u7, // bit offset: 1 desc: Interface address
        OA2MSK: u3, // bit offset: 8 desc: Own Address 2 masks
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        OA2EN: u1, // bit offset: 15 desc: Own Address 2 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        SCLL: u8, // bit offset: 0 desc: SCL low period (master mode)
        SCLH: u8, // bit offset: 8 desc: SCL high period (master mode)
        SDADEL: u4, // bit offset: 16 desc: Data hold time
        SCLDEL: u4, // bit offset: 20 desc: Data setup time
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PRESC: u4, // bit offset: 28 desc: Timing prescaler
    });
    // byte offset: 20 Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        TIMEOUTA: u12, // bit offset: 0 desc: Bus timeout A
        TIDLE: u1, // bit offset: 12 desc: Idle clock timeout detection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIMOUTEN: u1, // bit offset: 15 desc: Clock timeout enable
        TIMEOUTB: u12, // bit offset: 16 desc: Bus timeout B
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        TEXTEN: u1, // bit offset: 31 desc: Extended clock timeout enable
    });
    // byte offset: 24 Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        TXE: u1, // bit offset: 0 desc: Transmit data register empty (transmitters)
        TXIS: u1, // bit offset: 1 desc: Transmit interrupt status (transmitters)
        RXNE: u1, // bit offset: 2 desc: Receive data register not empty (receivers)
        ADDR: u1, // bit offset: 3 desc: Address matched (slave mode)
        NACKF: u1, // bit offset: 4 desc: Not acknowledge received flag
        STOPF: u1, // bit offset: 5 desc: Stop detection flag
        TC: u1, // bit offset: 6 desc: Transfer Complete (master mode)
        TCR: u1, // bit offset: 7 desc: Transfer Complete Reload
        BERR: u1, // bit offset: 8 desc: Bus error
        ARLO: u1, // bit offset: 9 desc: Arbitration lost
        OVR: u1, // bit offset: 10 desc: Overrun/Underrun (slave mode)
        PECERR: u1, // bit offset: 11 desc: PEC Error in reception
        TIMEOUT: u1, // bit offset: 12 desc: Timeout or t_low detection flag
        ALERT: u1, // bit offset: 13 desc: SMBus alert
        reserved1: u1 = 0,
        BUSY: u1, // bit offset: 15 desc: Bus busy
        DIR: u1, // bit offset: 16 desc: Transfer direction (Slave mode)
        ADDCODE: u7, // bit offset: 17 desc: Address match code (Slave mode)
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDRCF: u1, // bit offset: 3 desc: Address Matched flag clear
        NACKCF: u1, // bit offset: 4 desc: Not Acknowledge flag clear
        STOPCF: u1, // bit offset: 5 desc: Stop detection flag clear
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        BERRCF: u1, // bit offset: 8 desc: Bus error flag clear
        ARLOCF: u1, // bit offset: 9 desc: Arbitration lost flag clear
        OVRCF: u1, // bit offset: 10 desc: Overrun/Underrun flag clear
        PECCF: u1, // bit offset: 11 desc: PEC Error flag clear
        TIMOUTCF: u1, // bit offset: 12 desc: Timeout detection flag clear
        ALERTCF: u1, // bit offset: 13 desc: Alert flag clear
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
    // byte offset: 32 PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        PEC: u8, // bit offset: 0 desc: Packet error checking register
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
    // byte offset: 36 Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        RXDATA: u8, // bit offset: 0 desc: 8-bit receive data
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
    // byte offset: 40 Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        TXDATA: u8, // bit offset: 0 desc: 8-bit transmit data
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
pub const I2C2 = extern struct {
    pub const Address: u32 = 0x40005800;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Peripheral enable
        TXIE: u1, // bit offset: 1 desc: TX Interrupt enable
        RXIE: u1, // bit offset: 2 desc: RX Interrupt enable
        ADDRIE: u1, // bit offset: 3 desc: Address match interrupt enable (slave only)
        NACKIE: u1, // bit offset: 4 desc: Not acknowledge received interrupt enable
        STOPIE: u1, // bit offset: 5 desc: STOP detection Interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transfer Complete interrupt enable
        ERRIE: u1, // bit offset: 7 desc: Error interrupts enable
        DNF: u4, // bit offset: 8 desc: Digital noise filter
        ANFOFF: u1, // bit offset: 12 desc: Analog noise filter OFF
        SWRST: u1, // bit offset: 13 desc: Software reset
        TXDMAEN: u1, // bit offset: 14 desc: DMA transmission requests enable
        RXDMAEN: u1, // bit offset: 15 desc: DMA reception requests enable
        SBC: u1, // bit offset: 16 desc: Slave byte control
        NOSTRETCH: u1, // bit offset: 17 desc: Clock stretching disable
        WUPEN: u1, // bit offset: 18 desc: Wakeup from STOP enable
        GCEN: u1, // bit offset: 19 desc: General call enable
        SMBHEN: u1, // bit offset: 20 desc: SMBus Host address enable
        SMBDEN: u1, // bit offset: 21 desc: SMBus Device Default address enable
        ALERTEN: u1, // bit offset: 22 desc: SMBUS alert enable
        PECEN: u1, // bit offset: 23 desc: PEC enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        SADD0: u1, // bit offset: 0 desc: Slave address bit 0 (master mode)
        SADD1: u7, // bit offset: 1 desc: Slave address bit 7:1 (master mode)
        SADD8: u2, // bit offset: 8 desc: Slave address bit 9:8 (master mode)
        RD_WRN: u1, // bit offset: 10 desc: Transfer direction (master mode)
        ADD10: u1, // bit offset: 11 desc: 10-bit addressing mode (master mode)
        HEAD10R: u1, // bit offset: 12 desc: 10-bit address header only read direction (master receiver mode)
        START: u1, // bit offset: 13 desc: Start generation
        STOP: u1, // bit offset: 14 desc: Stop generation (master mode)
        NACK: u1, // bit offset: 15 desc: NACK generation (slave mode)
        NBYTES: u8, // bit offset: 16 desc: Number of bytes
        RELOAD: u1, // bit offset: 24 desc: NBYTES reload mode
        AUTOEND: u1, // bit offset: 25 desc: Automatic end mode (master mode)
        PECBYTE: u1, // bit offset: 26 desc: Packet error checking byte
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        OA1_0: u1, // bit offset: 0 desc: Interface address
        OA1_1: u7, // bit offset: 1 desc: Interface address
        OA1_8: u2, // bit offset: 8 desc: Interface address
        OA1MODE: u1, // bit offset: 10 desc: Own Address 1 10-bit mode
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OA1EN: u1, // bit offset: 15 desc: Own Address 1 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        OA2: u7, // bit offset: 1 desc: Interface address
        OA2MSK: u3, // bit offset: 8 desc: Own Address 2 masks
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        OA2EN: u1, // bit offset: 15 desc: Own Address 2 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        SCLL: u8, // bit offset: 0 desc: SCL low period (master mode)
        SCLH: u8, // bit offset: 8 desc: SCL high period (master mode)
        SDADEL: u4, // bit offset: 16 desc: Data hold time
        SCLDEL: u4, // bit offset: 20 desc: Data setup time
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PRESC: u4, // bit offset: 28 desc: Timing prescaler
    });
    // byte offset: 20 Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        TIMEOUTA: u12, // bit offset: 0 desc: Bus timeout A
        TIDLE: u1, // bit offset: 12 desc: Idle clock timeout detection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIMOUTEN: u1, // bit offset: 15 desc: Clock timeout enable
        TIMEOUTB: u12, // bit offset: 16 desc: Bus timeout B
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        TEXTEN: u1, // bit offset: 31 desc: Extended clock timeout enable
    });
    // byte offset: 24 Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        TXE: u1, // bit offset: 0 desc: Transmit data register empty (transmitters)
        TXIS: u1, // bit offset: 1 desc: Transmit interrupt status (transmitters)
        RXNE: u1, // bit offset: 2 desc: Receive data register not empty (receivers)
        ADDR: u1, // bit offset: 3 desc: Address matched (slave mode)
        NACKF: u1, // bit offset: 4 desc: Not acknowledge received flag
        STOPF: u1, // bit offset: 5 desc: Stop detection flag
        TC: u1, // bit offset: 6 desc: Transfer Complete (master mode)
        TCR: u1, // bit offset: 7 desc: Transfer Complete Reload
        BERR: u1, // bit offset: 8 desc: Bus error
        ARLO: u1, // bit offset: 9 desc: Arbitration lost
        OVR: u1, // bit offset: 10 desc: Overrun/Underrun (slave mode)
        PECERR: u1, // bit offset: 11 desc: PEC Error in reception
        TIMEOUT: u1, // bit offset: 12 desc: Timeout or t_low detection flag
        ALERT: u1, // bit offset: 13 desc: SMBus alert
        reserved1: u1 = 0,
        BUSY: u1, // bit offset: 15 desc: Bus busy
        DIR: u1, // bit offset: 16 desc: Transfer direction (Slave mode)
        ADDCODE: u7, // bit offset: 17 desc: Address match code (Slave mode)
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDRCF: u1, // bit offset: 3 desc: Address Matched flag clear
        NACKCF: u1, // bit offset: 4 desc: Not Acknowledge flag clear
        STOPCF: u1, // bit offset: 5 desc: Stop detection flag clear
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        BERRCF: u1, // bit offset: 8 desc: Bus error flag clear
        ARLOCF: u1, // bit offset: 9 desc: Arbitration lost flag clear
        OVRCF: u1, // bit offset: 10 desc: Overrun/Underrun flag clear
        PECCF: u1, // bit offset: 11 desc: PEC Error flag clear
        TIMOUTCF: u1, // bit offset: 12 desc: Timeout detection flag clear
        ALERTCF: u1, // bit offset: 13 desc: Alert flag clear
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
    // byte offset: 32 PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        PEC: u8, // bit offset: 0 desc: Packet error checking register
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
    // byte offset: 36 Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        RXDATA: u8, // bit offset: 0 desc: 8-bit receive data
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
    // byte offset: 40 Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        TXDATA: u8, // bit offset: 0 desc: 8-bit transmit data
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
pub const I2C3 = extern struct {
    pub const Address: u32 = 0x40007800;
    // byte offset: 0 Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        PE: u1, // bit offset: 0 desc: Peripheral enable
        TXIE: u1, // bit offset: 1 desc: TX Interrupt enable
        RXIE: u1, // bit offset: 2 desc: RX Interrupt enable
        ADDRIE: u1, // bit offset: 3 desc: Address match interrupt enable (slave only)
        NACKIE: u1, // bit offset: 4 desc: Not acknowledge received interrupt enable
        STOPIE: u1, // bit offset: 5 desc: STOP detection Interrupt enable
        TCIE: u1, // bit offset: 6 desc: Transfer Complete interrupt enable
        ERRIE: u1, // bit offset: 7 desc: Error interrupts enable
        DNF: u4, // bit offset: 8 desc: Digital noise filter
        ANFOFF: u1, // bit offset: 12 desc: Analog noise filter OFF
        SWRST: u1, // bit offset: 13 desc: Software reset
        TXDMAEN: u1, // bit offset: 14 desc: DMA transmission requests enable
        RXDMAEN: u1, // bit offset: 15 desc: DMA reception requests enable
        SBC: u1, // bit offset: 16 desc: Slave byte control
        NOSTRETCH: u1, // bit offset: 17 desc: Clock stretching disable
        WUPEN: u1, // bit offset: 18 desc: Wakeup from STOP enable
        GCEN: u1, // bit offset: 19 desc: General call enable
        SMBHEN: u1, // bit offset: 20 desc: SMBus Host address enable
        SMBDEN: u1, // bit offset: 21 desc: SMBus Device Default address enable
        ALERTEN: u1, // bit offset: 22 desc: SMBUS alert enable
        PECEN: u1, // bit offset: 23 desc: PEC enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        SADD0: u1, // bit offset: 0 desc: Slave address bit 0 (master mode)
        SADD1: u7, // bit offset: 1 desc: Slave address bit 7:1 (master mode)
        SADD8: u2, // bit offset: 8 desc: Slave address bit 9:8 (master mode)
        RD_WRN: u1, // bit offset: 10 desc: Transfer direction (master mode)
        ADD10: u1, // bit offset: 11 desc: 10-bit addressing mode (master mode)
        HEAD10R: u1, // bit offset: 12 desc: 10-bit address header only read direction (master receiver mode)
        START: u1, // bit offset: 13 desc: Start generation
        STOP: u1, // bit offset: 14 desc: Stop generation (master mode)
        NACK: u1, // bit offset: 15 desc: NACK generation (slave mode)
        NBYTES: u8, // bit offset: 16 desc: Number of bytes
        RELOAD: u1, // bit offset: 24 desc: NBYTES reload mode
        AUTOEND: u1, // bit offset: 25 desc: Automatic end mode (master mode)
        PECBYTE: u1, // bit offset: 26 desc: Packet error checking byte
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        OA1_0: u1, // bit offset: 0 desc: Interface address
        OA1_1: u7, // bit offset: 1 desc: Interface address
        OA1_8: u2, // bit offset: 8 desc: Interface address
        OA1MODE: u1, // bit offset: 10 desc: Own Address 1 10-bit mode
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OA1EN: u1, // bit offset: 15 desc: Own Address 1 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Own address register 2
    pub const OAR2 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved1: u1 = 0,
        OA2: u7, // bit offset: 1 desc: Interface address
        OA2MSK: u3, // bit offset: 8 desc: Own Address 2 masks
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        OA2EN: u1, // bit offset: 15 desc: Own Address 2 enable
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 Timing register
    pub const TIMINGR = mmio(Address + 0x00000010, 32, packed struct {
        SCLL: u8, // bit offset: 0 desc: SCL low period (master mode)
        SCLH: u8, // bit offset: 8 desc: SCL high period (master mode)
        SDADEL: u4, // bit offset: 16 desc: Data hold time
        SCLDEL: u4, // bit offset: 20 desc: Data setup time
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PRESC: u4, // bit offset: 28 desc: Timing prescaler
    });
    // byte offset: 20 Status register 1
    pub const TIMEOUTR = mmio(Address + 0x00000014, 32, packed struct {
        TIMEOUTA: u12, // bit offset: 0 desc: Bus timeout A
        TIDLE: u1, // bit offset: 12 desc: Idle clock timeout detection
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TIMOUTEN: u1, // bit offset: 15 desc: Clock timeout enable
        TIMEOUTB: u12, // bit offset: 16 desc: Bus timeout B
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        TEXTEN: u1, // bit offset: 31 desc: Extended clock timeout enable
    });
    // byte offset: 24 Interrupt and Status register
    pub const ISR = mmio(Address + 0x00000018, 32, packed struct {
        TXE: u1, // bit offset: 0 desc: Transmit data register empty (transmitters)
        TXIS: u1, // bit offset: 1 desc: Transmit interrupt status (transmitters)
        RXNE: u1, // bit offset: 2 desc: Receive data register not empty (receivers)
        ADDR: u1, // bit offset: 3 desc: Address matched (slave mode)
        NACKF: u1, // bit offset: 4 desc: Not acknowledge received flag
        STOPF: u1, // bit offset: 5 desc: Stop detection flag
        TC: u1, // bit offset: 6 desc: Transfer Complete (master mode)
        TCR: u1, // bit offset: 7 desc: Transfer Complete Reload
        BERR: u1, // bit offset: 8 desc: Bus error
        ARLO: u1, // bit offset: 9 desc: Arbitration lost
        OVR: u1, // bit offset: 10 desc: Overrun/Underrun (slave mode)
        PECERR: u1, // bit offset: 11 desc: PEC Error in reception
        TIMEOUT: u1, // bit offset: 12 desc: Timeout or t_low detection flag
        ALERT: u1, // bit offset: 13 desc: SMBus alert
        reserved1: u1 = 0,
        BUSY: u1, // bit offset: 15 desc: Bus busy
        DIR: u1, // bit offset: 16 desc: Transfer direction (Slave mode)
        ADDCODE: u7, // bit offset: 17 desc: Address match code (Slave mode)
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 Interrupt clear register
    pub const ICR = mmio(Address + 0x0000001c, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDRCF: u1, // bit offset: 3 desc: Address Matched flag clear
        NACKCF: u1, // bit offset: 4 desc: Not Acknowledge flag clear
        STOPCF: u1, // bit offset: 5 desc: Stop detection flag clear
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        BERRCF: u1, // bit offset: 8 desc: Bus error flag clear
        ARLOCF: u1, // bit offset: 9 desc: Arbitration lost flag clear
        OVRCF: u1, // bit offset: 10 desc: Overrun/Underrun flag clear
        PECCF: u1, // bit offset: 11 desc: PEC Error flag clear
        TIMOUTCF: u1, // bit offset: 12 desc: Timeout detection flag clear
        ALERTCF: u1, // bit offset: 13 desc: Alert flag clear
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
    // byte offset: 32 PEC register
    pub const PECR = mmio(Address + 0x00000020, 32, packed struct {
        PEC: u8, // bit offset: 0 desc: Packet error checking register
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
    // byte offset: 36 Receive data register
    pub const RXDR = mmio(Address + 0x00000024, 32, packed struct {
        RXDATA: u8, // bit offset: 0 desc: 8-bit receive data
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
    // byte offset: 40 Transmit data register
    pub const TXDR = mmio(Address + 0x00000028, 32, packed struct {
        TXDATA: u8, // bit offset: 0 desc: 8-bit transmit data
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
pub const IWDG = extern struct {
    pub const Address: u32 = 0x40003000;
    // byte offset: 0 Key register
    pub const KR = mmio(Address + 0x00000000, 32, packed struct {
        KEY: u16, // bit offset: 0 desc: Key value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 Prescaler register
    pub const PR = mmio(Address + 0x00000004, 32, packed struct {
        PR: u3, // bit offset: 0 desc: Prescaler divider
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
    // byte offset: 8 Reload register
    pub const RLR = mmio(Address + 0x00000008, 32, packed struct {
        RL: u12, // bit offset: 0 desc: Watchdog counter reload value
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
    // byte offset: 12 Status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        PVU: u1, // bit offset: 0 desc: Watchdog prescaler value update
        RVU: u1, // bit offset: 1 desc: Watchdog counter reload value update
        WVU: u1, // bit offset: 2 desc: Watchdog counter window value update
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
    // byte offset: 16 Window register
    pub const WINR = mmio(Address + 0x00000010, 32, packed struct {
        WIN: u12, // bit offset: 0 desc: Watchdog counter window value
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
pub const WWDG = extern struct {
    pub const Address: u32 = 0x40002c00;
    // byte offset: 0 Control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        T: u7, // bit offset: 0 desc: 7-bit counter
        WDGA: u1, // bit offset: 7 desc: Activation bit
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
    // byte offset: 4 Configuration register
    pub const CFR = mmio(Address + 0x00000004, 32, packed struct {
        W: u7, // bit offset: 0 desc: 7-bit window value
        WDGTB: u2, // bit offset: 7 desc: Timer base
        EWI: u1, // bit offset: 9 desc: Early wakeup interrupt
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
    // byte offset: 8 Status register
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        EWIF: u1, // bit offset: 0 desc: Early wakeup interrupt flag
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
pub const RTC = extern struct {
    pub const Address: u32 = 0x40002800;
    // byte offset: 0 time register
    pub const TR = mmio(Address + 0x00000000, 32, packed struct {
        SU: u4, // bit offset: 0 desc: Second units in BCD format
        ST: u3, // bit offset: 4 desc: Second tens in BCD format
        reserved1: u1 = 0,
        MNU: u4, // bit offset: 8 desc: Minute units in BCD format
        MNT: u3, // bit offset: 12 desc: Minute tens in BCD format
        reserved2: u1 = 0,
        HU: u4, // bit offset: 16 desc: Hour units in BCD format
        HT: u2, // bit offset: 20 desc: Hour tens in BCD format
        PM: u1, // bit offset: 22 desc: AM/PM notation
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 date register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        DU: u4, // bit offset: 0 desc: Date units in BCD format
        DT: u2, // bit offset: 4 desc: Date tens in BCD format
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MU: u4, // bit offset: 8 desc: Month units in BCD format
        MT: u1, // bit offset: 12 desc: Month tens in BCD format
        WDU: u3, // bit offset: 13 desc: Week day units
        YU: u4, // bit offset: 16 desc: Year units in BCD format
        YT: u4, // bit offset: 20 desc: Year tens in BCD format
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        WCKSEL: u3, // bit offset: 0 desc: Wakeup clock selection
        TSEDGE: u1, // bit offset: 3 desc: Time-stamp event active edge
        REFCKON: u1, // bit offset: 4 desc: Reference clock detection enable (50 or 60 Hz)
        BYPSHAD: u1, // bit offset: 5 desc: Bypass the shadow registers
        FMT: u1, // bit offset: 6 desc: Hour format
        reserved1: u1 = 0,
        ALRAE: u1, // bit offset: 8 desc: Alarm A enable
        ALRBE: u1, // bit offset: 9 desc: Alarm B enable
        WUTE: u1, // bit offset: 10 desc: Wakeup timer enable
        TSE: u1, // bit offset: 11 desc: Time stamp enable
        ALRAIE: u1, // bit offset: 12 desc: Alarm A interrupt enable
        ALRBIE: u1, // bit offset: 13 desc: Alarm B interrupt enable
        WUTIE: u1, // bit offset: 14 desc: Wakeup timer interrupt enable
        TSIE: u1, // bit offset: 15 desc: Time-stamp interrupt enable
        ADD1H: u1, // bit offset: 16 desc: Add 1 hour (summer time change)
        SUB1H: u1, // bit offset: 17 desc: Subtract 1 hour (winter time change)
        BKP: u1, // bit offset: 18 desc: Backup
        COSEL: u1, // bit offset: 19 desc: Calibration output selection
        POL: u1, // bit offset: 20 desc: Output polarity
        OSEL: u2, // bit offset: 21 desc: Output selection
        COE: u1, // bit offset: 23 desc: Calibration output enable
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 initialization and status register
    pub const ISR = mmio(Address + 0x0000000c, 32, packed struct {
        ALRAWF: u1, // bit offset: 0 desc: Alarm A write flag
        ALRBWF: u1, // bit offset: 1 desc: Alarm B write flag
        WUTWF: u1, // bit offset: 2 desc: Wakeup timer write flag
        SHPF: u1, // bit offset: 3 desc: Shift operation pending
        INITS: u1, // bit offset: 4 desc: Initialization status flag
        RSF: u1, // bit offset: 5 desc: Registers synchronization flag
        INITF: u1, // bit offset: 6 desc: Initialization flag
        INIT: u1, // bit offset: 7 desc: Initialization mode
        ALRAF: u1, // bit offset: 8 desc: Alarm A flag
        ALRBF: u1, // bit offset: 9 desc: Alarm B flag
        WUTF: u1, // bit offset: 10 desc: Wakeup timer flag
        TSF: u1, // bit offset: 11 desc: Time-stamp flag
        TSOVF: u1, // bit offset: 12 desc: Time-stamp overflow flag
        TAMP1F: u1, // bit offset: 13 desc: Tamper detection flag
        TAMP2F: u1, // bit offset: 14 desc: RTC_TAMP2 detection flag
        TAMP3F: u1, // bit offset: 15 desc: RTC_TAMP3 detection flag
        RECALPF: u1, // bit offset: 16 desc: Recalibration pending Flag
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 prescaler register
    pub const PRER = mmio(Address + 0x00000010, 32, packed struct {
        PREDIV_S: u15, // bit offset: 0 desc: Synchronous prescaler factor
        reserved1: u1 = 0,
        PREDIV_A: u7, // bit offset: 16 desc: Asynchronous prescaler factor
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 wakeup timer register
    pub const WUTR = mmio(Address + 0x00000014, 32, packed struct {
        WUT: u16, // bit offset: 0 desc: Wakeup auto-reload value bits
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 alarm A register
    pub const ALRMAR = mmio(Address + 0x0000001c, 32, packed struct {
        SU: u4, // bit offset: 0 desc: Second units in BCD format
        ST: u3, // bit offset: 4 desc: Second tens in BCD format
        MSK1: u1, // bit offset: 7 desc: Alarm A seconds mask
        MNU: u4, // bit offset: 8 desc: Minute units in BCD format
        MNT: u3, // bit offset: 12 desc: Minute tens in BCD format
        MSK2: u1, // bit offset: 15 desc: Alarm A minutes mask
        HU: u4, // bit offset: 16 desc: Hour units in BCD format
        HT: u2, // bit offset: 20 desc: Hour tens in BCD format
        PM: u1, // bit offset: 22 desc: AM/PM notation
        MSK3: u1, // bit offset: 23 desc: Alarm A hours mask
        DU: u4, // bit offset: 24 desc: Date units or day in BCD format
        DT: u2, // bit offset: 28 desc: Date tens in BCD format
        WDSEL: u1, // bit offset: 30 desc: Week day selection
        MSK4: u1, // bit offset: 31 desc: Alarm A date mask
    });
    // byte offset: 32 alarm B register
    pub const ALRMBR = mmio(Address + 0x00000020, 32, packed struct {
        SU: u4, // bit offset: 0 desc: Second units in BCD format
        ST: u3, // bit offset: 4 desc: Second tens in BCD format
        MSK1: u1, // bit offset: 7 desc: Alarm B seconds mask
        MNU: u4, // bit offset: 8 desc: Minute units in BCD format
        MNT: u3, // bit offset: 12 desc: Minute tens in BCD format
        MSK2: u1, // bit offset: 15 desc: Alarm B minutes mask
        HU: u4, // bit offset: 16 desc: Hour units in BCD format
        HT: u2, // bit offset: 20 desc: Hour tens in BCD format
        PM: u1, // bit offset: 22 desc: AM/PM notation
        MSK3: u1, // bit offset: 23 desc: Alarm B hours mask
        DU: u4, // bit offset: 24 desc: Date units or day in BCD format
        DT: u2, // bit offset: 28 desc: Date tens in BCD format
        WDSEL: u1, // bit offset: 30 desc: Week day selection
        MSK4: u1, // bit offset: 31 desc: Alarm B date mask
    });
    // byte offset: 36 write protection register
    pub const WPR = mmio(Address + 0x00000024, 32, packed struct {
        KEY: u8, // bit offset: 0 desc: Write protection key
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
    // byte offset: 40 sub second register
    pub const SSR = mmio(Address + 0x00000028, 32, packed struct {
        SS: u16, // bit offset: 0 desc: Sub second value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 shift control register
    pub const SHIFTR = mmio(Address + 0x0000002c, 32, packed struct {
        SUBFS: u15, // bit offset: 0 desc: Subtract a fraction of a second
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
        ADD1S: u1, // bit offset: 31 desc: Add one second
    });
    // byte offset: 48 time stamp time register
    pub const TSTR = mmio(Address + 0x00000030, 32, packed struct {
        SU: u4, // bit offset: 0 desc: Second units in BCD format
        ST: u3, // bit offset: 4 desc: Second tens in BCD format
        reserved1: u1 = 0,
        MNU: u4, // bit offset: 8 desc: Minute units in BCD format
        MNT: u3, // bit offset: 12 desc: Minute tens in BCD format
        reserved2: u1 = 0,
        HU: u4, // bit offset: 16 desc: Hour units in BCD format
        HT: u2, // bit offset: 20 desc: Hour tens in BCD format
        PM: u1, // bit offset: 22 desc: AM/PM notation
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 time stamp date register
    pub const TSDR = mmio(Address + 0x00000034, 32, packed struct {
        DU: u4, // bit offset: 0 desc: Date units in BCD format
        DT: u2, // bit offset: 4 desc: Date tens in BCD format
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MU: u4, // bit offset: 8 desc: Month units in BCD format
        MT: u1, // bit offset: 12 desc: Month tens in BCD format
        WDU: u3, // bit offset: 13 desc: Week day units
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 timestamp sub second register
    pub const TSSSR = mmio(Address + 0x00000038, 32, packed struct {
        SS: u16, // bit offset: 0 desc: Sub second value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 calibration register
    pub const CALR = mmio(Address + 0x0000003c, 32, packed struct {
        CALM: u9, // bit offset: 0 desc: Calibration minus
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CALW16: u1, // bit offset: 13 desc: Use a 16-second calibration cycle period
        CALW8: u1, // bit offset: 14 desc: Use an 8-second calibration cycle period
        CALP: u1, // bit offset: 15 desc: Increase frequency of RTC by 488.5 ppm
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 tamper and alternate function configuration register
    pub const TAFCR = mmio(Address + 0x00000040, 32, packed struct {
        TAMP1E: u1, // bit offset: 0 desc: Tamper 1 detection enable
        TAMP1TRG: u1, // bit offset: 1 desc: Active level for tamper 1
        TAMPIE: u1, // bit offset: 2 desc: Tamper interrupt enable
        TAMP2E: u1, // bit offset: 3 desc: Tamper 2 detection enable
        TAMP2TRG: u1, // bit offset: 4 desc: Active level for tamper 2
        TAMP3E: u1, // bit offset: 5 desc: Tamper 3 detection enable
        TAMP3TRG: u1, // bit offset: 6 desc: Active level for tamper 3
        TAMPTS: u1, // bit offset: 7 desc: Activate timestamp on tamper detection event
        TAMPFREQ: u3, // bit offset: 8 desc: Tamper sampling frequency
        TAMPFLT: u2, // bit offset: 11 desc: Tamper filter count
        TAMPPRCH: u2, // bit offset: 13 desc: Tamper precharge duration
        TAMPPUDIS: u1, // bit offset: 15 desc: TAMPER pull-up disable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PC13VALUE: u1, // bit offset: 18 desc: PC13 value
        PC13MODE: u1, // bit offset: 19 desc: PC13 mode
        PC14VALUE: u1, // bit offset: 20 desc: PC14 value
        PC14MODE: u1, // bit offset: 21 desc: PC 14 mode
        PC15VALUE: u1, // bit offset: 22 desc: PC15 value
        PC15MODE: u1, // bit offset: 23 desc: PC15 mode
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 alarm A sub second register
    pub const ALRMASSR = mmio(Address + 0x00000044, 32, packed struct {
        SS: u15, // bit offset: 0 desc: Sub seconds value
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MASKSS: u4, // bit offset: 24 desc: Mask the most-significant bits starting at this bit
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 alarm B sub second register
    pub const ALRMBSSR = mmio(Address + 0x00000048, 32, packed struct {
        SS: u15, // bit offset: 0 desc: Sub seconds value
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MASKSS: u4, // bit offset: 24 desc: Mask the most-significant bits starting at this bit
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 80 backup register
    pub const BKP0R = mmio(Address + 0x00000050, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 84 backup register
    pub const BKP1R = mmio(Address + 0x00000054, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 88 backup register
    pub const BKP2R = mmio(Address + 0x00000058, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 92 backup register
    pub const BKP3R = mmio(Address + 0x0000005c, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 96 backup register
    pub const BKP4R = mmio(Address + 0x00000060, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 100 backup register
    pub const BKP5R = mmio(Address + 0x00000064, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 104 backup register
    pub const BKP6R = mmio(Address + 0x00000068, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 108 backup register
    pub const BKP7R = mmio(Address + 0x0000006c, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 112 backup register
    pub const BKP8R = mmio(Address + 0x00000070, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 116 backup register
    pub const BKP9R = mmio(Address + 0x00000074, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 120 backup register
    pub const BKP10R = mmio(Address + 0x00000078, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 124 backup register
    pub const BKP11R = mmio(Address + 0x0000007c, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 128 backup register
    pub const BKP12R = mmio(Address + 0x00000080, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 132 backup register
    pub const BKP13R = mmio(Address + 0x00000084, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 136 backup register
    pub const BKP14R = mmio(Address + 0x00000088, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 140 backup register
    pub const BKP15R = mmio(Address + 0x0000008c, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 144 backup register
    pub const BKP16R = mmio(Address + 0x00000090, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 148 backup register
    pub const BKP17R = mmio(Address + 0x00000094, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 152 backup register
    pub const BKP18R = mmio(Address + 0x00000098, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 156 backup register
    pub const BKP19R = mmio(Address + 0x0000009c, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 160 backup register
    pub const BKP20R = mmio(Address + 0x000000a0, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 164 backup register
    pub const BKP21R = mmio(Address + 0x000000a4, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 168 backup register
    pub const BKP22R = mmio(Address + 0x000000a8, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 172 backup register
    pub const BKP23R = mmio(Address + 0x000000ac, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 176 backup register
    pub const BKP24R = mmio(Address + 0x000000b0, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 180 backup register
    pub const BKP25R = mmio(Address + 0x000000b4, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 184 backup register
    pub const BKP26R = mmio(Address + 0x000000b8, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 188 backup register
    pub const BKP27R = mmio(Address + 0x000000bc, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 192 backup register
    pub const BKP28R = mmio(Address + 0x000000c0, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 196 backup register
    pub const BKP29R = mmio(Address + 0x000000c4, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 200 backup register
    pub const BKP30R = mmio(Address + 0x000000c8, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
    // byte offset: 204 backup register
    pub const BKP31R = mmio(Address + 0x000000cc, 32, packed struct {
        BKP: u32, // bit offset: 0 desc: BKP
    });
};
pub const TIM6 = extern struct {
    pub const Address: u32 = 0x40001000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
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
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
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
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: Low counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF Copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Low Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const TIM7 = extern struct {
    pub const Address: u32 = 0x40001400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        MMS: u3, // bit offset: 4 desc: Master mode selection
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
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
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
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
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
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: Low counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF Copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Low Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
pub const DAC = extern struct {
    pub const Address: u32 = 0x40007400;
    // byte offset: 0 control register
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        EN1: u1, // bit offset: 0 desc: DAC channel1 enable
        BOFF1: u1, // bit offset: 1 desc: DAC channel1 output buffer disable
        TEN1: u1, // bit offset: 2 desc: DAC channel1 trigger enable
        TSEL1: u3, // bit offset: 3 desc: DAC channel1 trigger selection
        WAVE1: u2, // bit offset: 6 desc: DAC channel1 noise/triangle wave generation enable
        MAMP1: u4, // bit offset: 8 desc: DAC channel1 mask/amplitude selector
        DMAEN1: u1, // bit offset: 12 desc: DAC channel1 DMA enable
        DMAUDRIE1: u1, // bit offset: 13 desc: DAC channel1 DMA Underrun Interrupt enable
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        EN2: u1, // bit offset: 16 desc: DAC channel2 enable
        BOFF2: u1, // bit offset: 17 desc: DAC channel2 output buffer disable
        TEN2: u1, // bit offset: 18 desc: DAC channel2 trigger enable
        TSEL2: u3, // bit offset: 19 desc: DAC channel2 trigger selection
        WAVE2: u2, // bit offset: 22 desc: DAC channel2 noise/triangle wave generation enable
        MAMP2: u4, // bit offset: 24 desc: DAC channel2 mask/amplitude selector
        DMAEN2: u1, // bit offset: 28 desc: DAC channel2 DMA enable
        DMAUDRIE2: u1, // bit offset: 29 desc: DAC channel2 DMA underrun interrupt enable
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 software trigger register
    pub const SWTRIGR = mmio(Address + 0x00000004, 32, packed struct {
        SWTRIG1: u1, // bit offset: 0 desc: DAC channel1 software trigger
        SWTRIG2: u1, // bit offset: 1 desc: DAC channel2 software trigger
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
    // byte offset: 8 channel1 12-bit right-aligned data holding register
    pub const DHR12R1 = mmio(Address + 0x00000008, 32, packed struct {
        DACC1DHR: u12, // bit offset: 0 desc: DAC channel1 12-bit right-aligned data
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
    // byte offset: 12 channel1 12-bit left aligned data holding register
    pub const DHR12L1 = mmio(Address + 0x0000000c, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC1DHR: u12, // bit offset: 4 desc: DAC channel1 12-bit left-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 channel1 8-bit right aligned data holding register
    pub const DHR8R1 = mmio(Address + 0x00000010, 32, packed struct {
        DACC1DHR: u8, // bit offset: 0 desc: DAC channel1 8-bit right-aligned data
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
    // byte offset: 20 channel2 12-bit right aligned data holding register
    pub const DHR12R2 = mmio(Address + 0x00000014, 32, packed struct {
        DACC2DHR: u12, // bit offset: 0 desc: DAC channel2 12-bit right-aligned data
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
    // byte offset: 24 channel2 12-bit left aligned data holding register
    pub const DHR12L2 = mmio(Address + 0x00000018, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC2DHR: u12, // bit offset: 4 desc: DAC channel2 12-bit left-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 channel2 8-bit right-aligned data holding register
    pub const DHR8R2 = mmio(Address + 0x0000001c, 32, packed struct {
        DACC2DHR: u8, // bit offset: 0 desc: DAC channel2 8-bit right-aligned data
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
    // byte offset: 32 Dual DAC 12-bit right-aligned data holding register
    pub const DHR12RD = mmio(Address + 0x00000020, 32, packed struct {
        DACC1DHR: u12, // bit offset: 0 desc: DAC channel1 12-bit right-aligned data
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC2DHR: u12, // bit offset: 16 desc: DAC channel2 12-bit right-aligned data
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 DUAL DAC 12-bit left aligned data holding register
    pub const DHR12LD = mmio(Address + 0x00000024, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DACC1DHR: u12, // bit offset: 4 desc: DAC channel1 12-bit left-aligned data
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        DACC2DHR: u12, // bit offset: 20 desc: DAC channel2 12-bit left-aligned data
    });
    // byte offset: 40 DUAL DAC 8-bit right aligned data holding register
    pub const DHR8RD = mmio(Address + 0x00000028, 32, packed struct {
        DACC1DHR: u8, // bit offset: 0 desc: DAC channel1 8-bit right-aligned data
        DACC2DHR: u8, // bit offset: 8 desc: DAC channel2 8-bit right-aligned data
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 channel1 data output register
    pub const DOR1 = mmio(Address + 0x0000002c, 32, packed struct {
        DACC1DOR: u12, // bit offset: 0 desc: DAC channel1 data output
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
    // byte offset: 48 channel2 data output register
    pub const DOR2 = mmio(Address + 0x00000030, 32, packed struct {
        DACC2DOR: u12, // bit offset: 0 desc: DAC channel2 data output
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
    // byte offset: 52 status register
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
        DMAUDR1: u1, // bit offset: 13 desc: DAC channel1 DMA underrun flag
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
        DMAUDR2: u1, // bit offset: 29 desc: DAC channel2 DMA underrun flag
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const DBGMCU = extern struct {
    pub const Address: u32 = 0xe0042000;
    // byte offset: 0 MCU Device ID Code Register
    pub const IDCODE = mmio(Address + 0x00000000, 32, packed struct {
        DEV_ID: u12, // bit offset: 0 desc: Device Identifier
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        REV_ID: u16, // bit offset: 16 desc: Revision Identifier
    });
    // byte offset: 4 Debug MCU Configuration Register
    pub const CR = mmio(Address + 0x00000004, 32, packed struct {
        DBG_SLEEP: u1, // bit offset: 0 desc: Debug Sleep mode
        DBG_STOP: u1, // bit offset: 1 desc: Debug Stop Mode
        DBG_STANDBY: u1, // bit offset: 2 desc: Debug Standby Mode
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        TRACE_IOEN: u1, // bit offset: 5 desc: Trace pin assignment control
        TRACE_MODE: u2, // bit offset: 6 desc: Trace pin assignment control
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
    // byte offset: 8 APB Low Freeze Register
    pub const APB1FZ = mmio(Address + 0x00000008, 32, packed struct {
        DBG_TIM2_STOP: u1, // bit offset: 0 desc: Debug Timer 2 stopped when Core is halted
        DBG_TIM3_STOP: u1, // bit offset: 1 desc: Debug Timer 3 stopped when Core is halted
        DBG_TIM4_STOP: u1, // bit offset: 2 desc: Debug Timer 4 stopped when Core is halted
        DBG_TIM5_STOP: u1, // bit offset: 3 desc: Debug Timer 5 stopped when Core is halted
        DBG_TIM6_STOP: u1, // bit offset: 4 desc: Debug Timer 6 stopped when Core is halted
        DBG_TIM7_STOP: u1, // bit offset: 5 desc: Debug Timer 7 stopped when Core is halted
        DBG_TIM12_STOP: u1, // bit offset: 6 desc: Debug Timer 12 stopped when Core is halted
        DBG_TIM13_STOP: u1, // bit offset: 7 desc: Debug Timer 13 stopped when Core is halted
        DBG_TIMER14_STOP: u1, // bit offset: 8 desc: Debug Timer 14 stopped when Core is halted
        DBG_TIM18_STOP: u1, // bit offset: 9 desc: Debug Timer 18 stopped when Core is halted
        DBG_RTC_STOP: u1, // bit offset: 10 desc: Debug RTC stopped when Core is halted
        DBG_WWDG_STOP: u1, // bit offset: 11 desc: Debug Window Wachdog stopped when Core is halted
        DBG_IWDG_STOP: u1, // bit offset: 12 desc: Debug Independent Wachdog stopped when Core is halted
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        I2C1_SMBUS_TIMEOUT: u1, // bit offset: 21 desc: SMBUS timeout mode stopped when Core is halted
        I2C2_SMBUS_TIMEOUT: u1, // bit offset: 22 desc: SMBUS timeout mode stopped when Core is halted
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        DBG_CAN_STOP: u1, // bit offset: 25 desc: Debug CAN stopped when core is halted
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 APB High Freeze Register
    pub const APB2FZ = mmio(Address + 0x0000000c, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBG_TIM15_STOP: u1, // bit offset: 2 desc: Debug Timer 15 stopped when Core is halted
        DBG_TIM16_STOP: u1, // bit offset: 3 desc: Debug Timer 16 stopped when Core is halted
        DBG_TIM17_STO: u1, // bit offset: 4 desc: Debug Timer 17 stopped when Core is halted
        DBG_TIM19_STOP: u1, // bit offset: 5 desc: Debug Timer 19 stopped when Core is halted
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
pub const TIM1 = extern struct {
    pub const Address: u32 = 0x40012c00;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
        OIS2N: u1, // bit offset: 11 desc: Output Idle state 2
        OIS3: u1, // bit offset: 12 desc: Output Idle state 3
        OIS3N: u1, // bit offset: 13 desc: Output Idle state 3
        OIS4: u1, // bit offset: 14 desc: Output Idle state 4
        reserved2: u1 = 0,
        OIS5: u1, // bit offset: 16 desc: Output Idle state 5
        reserved3: u1 = 0,
        OIS6: u1, // bit offset: 18 desc: Output Idle state 6
        reserved4: u1 = 0,
        MMS2: u4, // bit offset: 20 desc: Master mode selection 2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS3: u1, // bit offset: 16 desc: Slave mode selection bit 3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        B2IF: u1, // bit offset: 8 desc: Break 2 interrupt flag
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        C5IF: u1, // bit offset: 16 desc: Capture/Compare 5 interrupt flag
        C6IF: u1, // bit offset: 17 desc: Capture/Compare 6 interrupt flag
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
        B2G: u1, // bit offset: 8 desc: Break 2 generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output Compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output Compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output Compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PCS: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PCS: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        OC4CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output Compare 3 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output Compare 4 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        CC2NE: u1, // bit offset: 6 desc: Capture/Compare 2 complementary output enable
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        CC3NE: u1, // bit offset: 10 desc: Capture/Compare 3 complementary output enable
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved1: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 4 output Polarity
        CC5E: u1, // bit offset: 16 desc: Capture/Compare 5 output enable
        CC5P: u1, // bit offset: 17 desc: Capture/Compare 5 output Polarity
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC6E: u1, // bit offset: 20 desc: Capture/Compare 6 output enable
        CC6P: u1, // bit offset: 21 desc: Capture/Compare 6 output Polarity
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u16, // bit offset: 0 desc: Repetition counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        BK2F: u4, // bit offset: 20 desc: Break 2 filter
        BK2E: u1, // bit offset: 24 desc: Break 2 enable
        BK2P: u1, // bit offset: 25 desc: Break 2 polarity
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 84 capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC5FE: u1, // bit offset: 2 desc: Output compare 5 fast enable
        OC5PE: u1, // bit offset: 3 desc: Output compare 5 preload enable
        OC5M: u3, // bit offset: 4 desc: Output compare 5 mode
        OC5CE: u1, // bit offset: 7 desc: Output compare 5 clear enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        OC6FE: u1, // bit offset: 10 desc: Output compare 6 fast enable
        OC6PE: u1, // bit offset: 11 desc: Output compare 6 preload enable
        OC6M: u3, // bit offset: 12 desc: Output compare 6 mode
        OC6CE: u1, // bit offset: 15 desc: Output compare 6 clear enable
        OC5M_3: u1, // bit offset: 16 desc: Outout Compare 5 mode bit 3
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        OC6M_3: u1, // bit offset: 24 desc: Outout Compare 6 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 88 capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        CCR5: u16, // bit offset: 0 desc: Capture/Compare 5 value
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
        GC5C1: u1, // bit offset: 29 desc: Group Channel 5 and Channel 1
        GC5C2: u1, // bit offset: 30 desc: Group Channel 5 and Channel 2
        GC5C3: u1, // bit offset: 31 desc: Group Channel 5 and Channel 3
    });
    // byte offset: 92 capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        CCR6: u16, // bit offset: 0 desc: Capture/Compare 6 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        TIM1_ETR_ADC1_RMP: u2, // bit offset: 0 desc: TIM1_ETR_ADC1 remapping capability
        TIM1_ETR_ADC4_RMP: u2, // bit offset: 2 desc: TIM1_ETR_ADC4 remapping capability
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
pub const TIM20 = extern struct {
    pub const Address: u32 = 0x40015000;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
        OIS2N: u1, // bit offset: 11 desc: Output Idle state 2
        OIS3: u1, // bit offset: 12 desc: Output Idle state 3
        OIS3N: u1, // bit offset: 13 desc: Output Idle state 3
        OIS4: u1, // bit offset: 14 desc: Output Idle state 4
        reserved2: u1 = 0,
        OIS5: u1, // bit offset: 16 desc: Output Idle state 5
        reserved3: u1 = 0,
        OIS6: u1, // bit offset: 18 desc: Output Idle state 6
        reserved4: u1 = 0,
        MMS2: u4, // bit offset: 20 desc: Master mode selection 2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS3: u1, // bit offset: 16 desc: Slave mode selection bit 3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        B2IF: u1, // bit offset: 8 desc: Break 2 interrupt flag
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        C5IF: u1, // bit offset: 16 desc: Capture/Compare 5 interrupt flag
        C6IF: u1, // bit offset: 17 desc: Capture/Compare 6 interrupt flag
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
        B2G: u1, // bit offset: 8 desc: Break 2 generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output Compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output Compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output Compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PCS: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PCS: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        OC4CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output Compare 3 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output Compare 4 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        CC2NE: u1, // bit offset: 6 desc: Capture/Compare 2 complementary output enable
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        CC3NE: u1, // bit offset: 10 desc: Capture/Compare 3 complementary output enable
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved1: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 4 output Polarity
        CC5E: u1, // bit offset: 16 desc: Capture/Compare 5 output enable
        CC5P: u1, // bit offset: 17 desc: Capture/Compare 5 output Polarity
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC6E: u1, // bit offset: 20 desc: Capture/Compare 6 output enable
        CC6P: u1, // bit offset: 21 desc: Capture/Compare 6 output Polarity
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u16, // bit offset: 0 desc: Repetition counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        BK2F: u4, // bit offset: 20 desc: Break 2 filter
        BK2E: u1, // bit offset: 24 desc: Break 2 enable
        BK2P: u1, // bit offset: 25 desc: Break 2 polarity
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 84 capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC5FE: u1, // bit offset: 2 desc: Output compare 5 fast enable
        OC5PE: u1, // bit offset: 3 desc: Output compare 5 preload enable
        OC5M: u3, // bit offset: 4 desc: Output compare 5 mode
        OC5CE: u1, // bit offset: 7 desc: Output compare 5 clear enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        OC6FE: u1, // bit offset: 10 desc: Output compare 6 fast enable
        OC6PE: u1, // bit offset: 11 desc: Output compare 6 preload enable
        OC6M: u3, // bit offset: 12 desc: Output compare 6 mode
        OC6CE: u1, // bit offset: 15 desc: Output compare 6 clear enable
        OC5M_3: u1, // bit offset: 16 desc: Outout Compare 5 mode bit 3
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        OC6M_3: u1, // bit offset: 24 desc: Outout Compare 6 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 88 capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        CCR5: u16, // bit offset: 0 desc: Capture/Compare 5 value
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
        GC5C1: u1, // bit offset: 29 desc: Group Channel 5 and Channel 1
        GC5C2: u1, // bit offset: 30 desc: Group Channel 5 and Channel 2
        GC5C3: u1, // bit offset: 31 desc: Group Channel 5 and Channel 3
    });
    // byte offset: 92 capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        CCR6: u16, // bit offset: 0 desc: Capture/Compare 6 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        TIM1_ETR_ADC1_RMP: u2, // bit offset: 0 desc: TIM1_ETR_ADC1 remapping capability
        TIM1_ETR_ADC4_RMP: u2, // bit offset: 2 desc: TIM1_ETR_ADC4 remapping capability
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
pub const TIM8 = extern struct {
    pub const Address: u32 = 0x40013400;
    // byte offset: 0 control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        CEN: u1, // bit offset: 0 desc: Counter enable
        UDIS: u1, // bit offset: 1 desc: Update disable
        URS: u1, // bit offset: 2 desc: Update request source
        OPM: u1, // bit offset: 3 desc: One-pulse mode
        DIR: u1, // bit offset: 4 desc: Direction
        CMS: u2, // bit offset: 5 desc: Center-aligned mode selection
        ARPE: u1, // bit offset: 7 desc: Auto-reload preload enable
        CKD: u2, // bit offset: 8 desc: Clock division
        reserved1: u1 = 0,
        UIFREMAP: u1, // bit offset: 11 desc: UIF status bit remapping
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
    // byte offset: 4 control register 2
    pub const CR2 = mmio(Address + 0x00000004, 32, packed struct {
        CCPC: u1, // bit offset: 0 desc: Capture/compare preloaded control
        reserved1: u1 = 0,
        CCUS: u1, // bit offset: 2 desc: Capture/compare control update selection
        CCDS: u1, // bit offset: 3 desc: Capture/compare DMA selection
        MMS: u3, // bit offset: 4 desc: Master mode selection
        TI1S: u1, // bit offset: 7 desc: TI1 selection
        OIS1: u1, // bit offset: 8 desc: Output Idle state 1
        OIS1N: u1, // bit offset: 9 desc: Output Idle state 1
        OIS2: u1, // bit offset: 10 desc: Output Idle state 2
        OIS2N: u1, // bit offset: 11 desc: Output Idle state 2
        OIS3: u1, // bit offset: 12 desc: Output Idle state 3
        OIS3N: u1, // bit offset: 13 desc: Output Idle state 3
        OIS4: u1, // bit offset: 14 desc: Output Idle state 4
        reserved2: u1 = 0,
        OIS5: u1, // bit offset: 16 desc: Output Idle state 5
        reserved3: u1 = 0,
        OIS6: u1, // bit offset: 18 desc: Output Idle state 6
        reserved4: u1 = 0,
        MMS2: u4, // bit offset: 20 desc: Master mode selection 2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        SMS: u3, // bit offset: 0 desc: Slave mode selection
        OCCS: u1, // bit offset: 3 desc: OCREF clear selection
        TS: u3, // bit offset: 4 desc: Trigger selection
        MSM: u1, // bit offset: 7 desc: Master/Slave mode
        ETF: u4, // bit offset: 8 desc: External trigger filter
        ETPS: u2, // bit offset: 12 desc: External trigger prescaler
        ECE: u1, // bit offset: 14 desc: External clock enable
        ETP: u1, // bit offset: 15 desc: External trigger polarity
        SMS3: u1, // bit offset: 16 desc: Slave mode selection bit 3
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 DMA/Interrupt enable register
    pub const DIER = mmio(Address + 0x0000000c, 32, packed struct {
        UIE: u1, // bit offset: 0 desc: Update interrupt enable
        CC1IE: u1, // bit offset: 1 desc: Capture/Compare 1 interrupt enable
        CC2IE: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt enable
        CC3IE: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt enable
        CC4IE: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt enable
        COMIE: u1, // bit offset: 5 desc: COM interrupt enable
        TIE: u1, // bit offset: 6 desc: Trigger interrupt enable
        BIE: u1, // bit offset: 7 desc: Break interrupt enable
        UDE: u1, // bit offset: 8 desc: Update DMA request enable
        CC1DE: u1, // bit offset: 9 desc: Capture/Compare 1 DMA request enable
        CC2DE: u1, // bit offset: 10 desc: Capture/Compare 2 DMA request enable
        CC3DE: u1, // bit offset: 11 desc: Capture/Compare 3 DMA request enable
        CC4DE: u1, // bit offset: 12 desc: Capture/Compare 4 DMA request enable
        COMDE: u1, // bit offset: 13 desc: COM DMA request enable
        TDE: u1, // bit offset: 14 desc: Trigger DMA request enable
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
    // byte offset: 16 status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        UIF: u1, // bit offset: 0 desc: Update interrupt flag
        CC1IF: u1, // bit offset: 1 desc: Capture/compare 1 interrupt flag
        CC2IF: u1, // bit offset: 2 desc: Capture/Compare 2 interrupt flag
        CC3IF: u1, // bit offset: 3 desc: Capture/Compare 3 interrupt flag
        CC4IF: u1, // bit offset: 4 desc: Capture/Compare 4 interrupt flag
        COMIF: u1, // bit offset: 5 desc: COM interrupt flag
        TIF: u1, // bit offset: 6 desc: Trigger interrupt flag
        BIF: u1, // bit offset: 7 desc: Break interrupt flag
        B2IF: u1, // bit offset: 8 desc: Break 2 interrupt flag
        CC1OF: u1, // bit offset: 9 desc: Capture/Compare 1 overcapture flag
        CC2OF: u1, // bit offset: 10 desc: Capture/compare 2 overcapture flag
        CC3OF: u1, // bit offset: 11 desc: Capture/Compare 3 overcapture flag
        CC4OF: u1, // bit offset: 12 desc: Capture/Compare 4 overcapture flag
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        C5IF: u1, // bit offset: 16 desc: Capture/Compare 5 interrupt flag
        C6IF: u1, // bit offset: 17 desc: Capture/Compare 6 interrupt flag
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 event generation register
    pub const EGR = mmio(Address + 0x00000014, 32, packed struct {
        UG: u1, // bit offset: 0 desc: Update generation
        CC1G: u1, // bit offset: 1 desc: Capture/compare 1 generation
        CC2G: u1, // bit offset: 2 desc: Capture/compare 2 generation
        CC3G: u1, // bit offset: 3 desc: Capture/compare 3 generation
        CC4G: u1, // bit offset: 4 desc: Capture/compare 4 generation
        COMG: u1, // bit offset: 5 desc: Capture/Compare control update generation
        TG: u1, // bit offset: 6 desc: Trigger generation
        BG: u1, // bit offset: 7 desc: Break generation
        B2G: u1, // bit offset: 8 desc: Break 2 generation
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
    // byte offset: 24 capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        OC1FE: u1, // bit offset: 2 desc: Output Compare 1 fast enable
        OC1PE: u1, // bit offset: 3 desc: Output Compare 1 preload enable
        OC1M: u3, // bit offset: 4 desc: Output Compare 1 mode
        OC1CE: u1, // bit offset: 7 desc: Output Compare 1 clear enable
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        OC2FE: u1, // bit offset: 10 desc: Output Compare 2 fast enable
        OC2PE: u1, // bit offset: 11 desc: Output Compare 2 preload enable
        OC2M: u3, // bit offset: 12 desc: Output Compare 2 mode
        OC2CE: u1, // bit offset: 15 desc: Output Compare 2 clear enable
        OC1M_3: u1, // bit offset: 16 desc: Output Compare 1 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC2M_3: u1, // bit offset: 24 desc: Output Compare 2 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 capture/compare mode register 1 (input mode)
    pub const CCMR1_Input = mmio(Address + 0x00000018, 32, packed struct {
        CC1S: u2, // bit offset: 0 desc: Capture/Compare 1 selection
        IC1PCS: u2, // bit offset: 2 desc: Input capture 1 prescaler
        IC1F: u4, // bit offset: 4 desc: Input capture 1 filter
        CC2S: u2, // bit offset: 8 desc: Capture/Compare 2 selection
        IC2PCS: u2, // bit offset: 10 desc: Input capture 2 prescaler
        IC2F: u4, // bit offset: 12 desc: Input capture 2 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register (output mode)
    pub const CCMR2_Output = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/Compare 3 selection
        OC3FE: u1, // bit offset: 2 desc: Output compare 3 fast enable
        OC3PE: u1, // bit offset: 3 desc: Output compare 3 preload enable
        OC3M: u3, // bit offset: 4 desc: Output compare 3 mode
        OC3CE: u1, // bit offset: 7 desc: Output compare 3 clear enable
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        OC4FE: u1, // bit offset: 10 desc: Output compare 4 fast enable
        OC4PE: u1, // bit offset: 11 desc: Output compare 4 preload enable
        OC4M: u3, // bit offset: 12 desc: Output compare 4 mode
        OC4CE: u1, // bit offset: 15 desc: Output compare 4 clear enable
        OC3M_3: u1, // bit offset: 16 desc: Output Compare 3 mode bit 3
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC4M_3: u1, // bit offset: 24 desc: Output Compare 4 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 capture/compare mode register 2 (input mode)
    pub const CCMR2_Input = mmio(Address + 0x0000001c, 32, packed struct {
        CC3S: u2, // bit offset: 0 desc: Capture/compare 3 selection
        IC3PSC: u2, // bit offset: 2 desc: Input capture 3 prescaler
        IC3F: u4, // bit offset: 4 desc: Input capture 3 filter
        CC4S: u2, // bit offset: 8 desc: Capture/Compare 4 selection
        IC4PSC: u2, // bit offset: 10 desc: Input capture 4 prescaler
        IC4F: u4, // bit offset: 12 desc: Input capture 4 filter
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 capture/compare enable register
    pub const CCER = mmio(Address + 0x00000020, 32, packed struct {
        CC1E: u1, // bit offset: 0 desc: Capture/Compare 1 output enable
        CC1P: u1, // bit offset: 1 desc: Capture/Compare 1 output Polarity
        CC1NE: u1, // bit offset: 2 desc: Capture/Compare 1 complementary output enable
        CC1NP: u1, // bit offset: 3 desc: Capture/Compare 1 output Polarity
        CC2E: u1, // bit offset: 4 desc: Capture/Compare 2 output enable
        CC2P: u1, // bit offset: 5 desc: Capture/Compare 2 output Polarity
        CC2NE: u1, // bit offset: 6 desc: Capture/Compare 2 complementary output enable
        CC2NP: u1, // bit offset: 7 desc: Capture/Compare 2 output Polarity
        CC3E: u1, // bit offset: 8 desc: Capture/Compare 3 output enable
        CC3P: u1, // bit offset: 9 desc: Capture/Compare 3 output Polarity
        CC3NE: u1, // bit offset: 10 desc: Capture/Compare 3 complementary output enable
        CC3NP: u1, // bit offset: 11 desc: Capture/Compare 3 output Polarity
        CC4E: u1, // bit offset: 12 desc: Capture/Compare 4 output enable
        CC4P: u1, // bit offset: 13 desc: Capture/Compare 3 output Polarity
        reserved1: u1 = 0,
        CC4NP: u1, // bit offset: 15 desc: Capture/Compare 4 output Polarity
        CC5E: u1, // bit offset: 16 desc: Capture/Compare 5 output enable
        CC5P: u1, // bit offset: 17 desc: Capture/Compare 5 output Polarity
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CC6E: u1, // bit offset: 20 desc: Capture/Compare 6 output enable
        CC6P: u1, // bit offset: 21 desc: Capture/Compare 6 output Polarity
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 counter
    pub const CNT = mmio(Address + 0x00000024, 32, packed struct {
        CNT: u16, // bit offset: 0 desc: counter value
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
        UIFCPY: u1, // bit offset: 31 desc: UIF copy
    });
    // byte offset: 40 prescaler
    pub const PSC = mmio(Address + 0x00000028, 32, packed struct {
        PSC: u16, // bit offset: 0 desc: Prescaler value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 auto-reload register
    pub const ARR = mmio(Address + 0x0000002c, 32, packed struct {
        ARR: u16, // bit offset: 0 desc: Auto-reload value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 repetition counter register
    pub const RCR = mmio(Address + 0x00000030, 32, packed struct {
        REP: u16, // bit offset: 0 desc: Repetition counter value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 capture/compare register 1
    pub const CCR1 = mmio(Address + 0x00000034, 32, packed struct {
        CCR1: u16, // bit offset: 0 desc: Capture/Compare 1 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 capture/compare register 2
    pub const CCR2 = mmio(Address + 0x00000038, 32, packed struct {
        CCR2: u16, // bit offset: 0 desc: Capture/Compare 2 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        CCR3: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 64 capture/compare register 4
    pub const CCR4 = mmio(Address + 0x00000040, 32, packed struct {
        CCR4: u16, // bit offset: 0 desc: Capture/Compare 3 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 68 break and dead-time register
    pub const BDTR = mmio(Address + 0x00000044, 32, packed struct {
        DTG: u8, // bit offset: 0 desc: Dead-time generator setup
        LOCK: u2, // bit offset: 8 desc: Lock configuration
        OSSI: u1, // bit offset: 10 desc: Off-state selection for Idle mode
        OSSR: u1, // bit offset: 11 desc: Off-state selection for Run mode
        BKE: u1, // bit offset: 12 desc: Break enable
        BKP: u1, // bit offset: 13 desc: Break polarity
        AOE: u1, // bit offset: 14 desc: Automatic output enable
        MOE: u1, // bit offset: 15 desc: Main output enable
        BKF: u4, // bit offset: 16 desc: Break filter
        BK2F: u4, // bit offset: 20 desc: Break 2 filter
        BK2E: u1, // bit offset: 24 desc: Break 2 enable
        BK2P: u1, // bit offset: 25 desc: Break 2 polarity
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 72 DMA control register
    pub const DCR = mmio(Address + 0x00000048, 32, packed struct {
        DBA: u5, // bit offset: 0 desc: DMA base address
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DBL: u5, // bit offset: 8 desc: DMA burst length
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
    // byte offset: 76 DMA address for full transfer
    pub const DMAR = mmio(Address + 0x0000004c, 32, packed struct {
        DMAB: u16, // bit offset: 0 desc: DMA register for burst accesses
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 84 capture/compare mode register 3 (output mode)
    pub const CCMR3_Output = mmio(Address + 0x00000054, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        OC5FE: u1, // bit offset: 2 desc: Output compare 5 fast enable
        OC5PE: u1, // bit offset: 3 desc: Output compare 5 preload enable
        OC5M: u3, // bit offset: 4 desc: Output compare 5 mode
        OC5CE: u1, // bit offset: 7 desc: Output compare 5 clear enable
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        OC6FE: u1, // bit offset: 10 desc: Output compare 6 fast enable
        OC6PE: u1, // bit offset: 11 desc: Output compare 6 preload enable
        OC6M: u3, // bit offset: 12 desc: Output compare 6 mode
        OC6CE: u1, // bit offset: 15 desc: Output compare 6 clear enable
        OC5M_3: u1, // bit offset: 16 desc: Outout Compare 5 mode bit 3
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        OC6M_3: u1, // bit offset: 24 desc: Outout Compare 6 mode bit 3
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 88 capture/compare register 5
    pub const CCR5 = mmio(Address + 0x00000058, 32, packed struct {
        CCR5: u16, // bit offset: 0 desc: Capture/Compare 5 value
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
        GC5C1: u1, // bit offset: 29 desc: Group Channel 5 and Channel 1
        GC5C2: u1, // bit offset: 30 desc: Group Channel 5 and Channel 2
        GC5C3: u1, // bit offset: 31 desc: Group Channel 5 and Channel 3
    });
    // byte offset: 92 capture/compare register 6
    pub const CCR6 = mmio(Address + 0x0000005c, 32, packed struct {
        CCR6: u16, // bit offset: 0 desc: Capture/Compare 6 value
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 option registers
    pub const OR = mmio(Address + 0x00000060, 32, packed struct {
        TIM8_ETR_ADC2_RMP: u2, // bit offset: 0 desc: TIM8_ETR_ADC2 remapping capability
        TIM8_ETR_ADC3_RMP: u2, // bit offset: 2 desc: TIM8_ETR_ADC3 remapping capability
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
pub const ADC1 = extern struct {
    pub const Address: u32 = 0x50000000;
    // byte offset: 0 interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        ADRDY: u1, // bit offset: 0 desc: ADRDY
        EOSMP: u1, // bit offset: 1 desc: EOSMP
        EOC: u1, // bit offset: 2 desc: EOC
        EOS: u1, // bit offset: 3 desc: EOS
        OVR: u1, // bit offset: 4 desc: OVR
        JEOC: u1, // bit offset: 5 desc: JEOC
        JEOS: u1, // bit offset: 6 desc: JEOS
        AWD1: u1, // bit offset: 7 desc: AWD1
        AWD2: u1, // bit offset: 8 desc: AWD2
        AWD3: u1, // bit offset: 9 desc: AWD3
        JQOVF: u1, // bit offset: 10 desc: JQOVF
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
    // byte offset: 4 interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        ADRDYIE: u1, // bit offset: 0 desc: ADRDYIE
        EOSMPIE: u1, // bit offset: 1 desc: EOSMPIE
        EOCIE: u1, // bit offset: 2 desc: EOCIE
        EOSIE: u1, // bit offset: 3 desc: EOSIE
        OVRIE: u1, // bit offset: 4 desc: OVRIE
        JEOCIE: u1, // bit offset: 5 desc: JEOCIE
        JEOSIE: u1, // bit offset: 6 desc: JEOSIE
        AWD1IE: u1, // bit offset: 7 desc: AWD1IE
        AWD2IE: u1, // bit offset: 8 desc: AWD2IE
        AWD3IE: u1, // bit offset: 9 desc: AWD3IE
        JQOVFIE: u1, // bit offset: 10 desc: JQOVFIE
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
    // byte offset: 8 control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        ADEN: u1, // bit offset: 0 desc: ADEN
        ADDIS: u1, // bit offset: 1 desc: ADDIS
        ADSTART: u1, // bit offset: 2 desc: ADSTART
        JADSTART: u1, // bit offset: 3 desc: JADSTART
        ADSTP: u1, // bit offset: 4 desc: ADSTP
        JADSTP: u1, // bit offset: 5 desc: JADSTP
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
        ADVREGEN: u1, // bit offset: 28 desc: ADVREGEN
        DEEPPWD: u1, // bit offset: 29 desc: DEEPPWD
        ADCALDIF: u1, // bit offset: 30 desc: ADCALDIF
        ADCAL: u1, // bit offset: 31 desc: ADCAL
    });
    // byte offset: 12 configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        DMAEN: u1, // bit offset: 0 desc: DMAEN
        DMACFG: u1, // bit offset: 1 desc: DMACFG
        reserved1: u1 = 0,
        RES: u2, // bit offset: 3 desc: RES
        ALIGN: u1, // bit offset: 5 desc: ALIGN
        EXTSEL: u4, // bit offset: 6 desc: EXTSEL
        EXTEN: u2, // bit offset: 10 desc: EXTEN
        OVRMOD: u1, // bit offset: 12 desc: OVRMOD
        CONT: u1, // bit offset: 13 desc: CONT
        AUTDLY: u1, // bit offset: 14 desc: AUTDLY
        AUTOFF: u1, // bit offset: 15 desc: AUTOFF
        DISCEN: u1, // bit offset: 16 desc: DISCEN
        DISCNUM: u3, // bit offset: 17 desc: DISCNUM
        JDISCEN: u1, // bit offset: 20 desc: JDISCEN
        JQM: u1, // bit offset: 21 desc: JQM
        AWD1SGL: u1, // bit offset: 22 desc: AWD1SGL
        AWD1EN: u1, // bit offset: 23 desc: AWD1EN
        JAWD1EN: u1, // bit offset: 24 desc: JAWD1EN
        JAUTO: u1, // bit offset: 25 desc: JAUTO
        AWDCH1CH: u5, // bit offset: 26 desc: AWDCH1CH
        padding1: u1 = 0,
    });
    // byte offset: 20 sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SMP1: u3, // bit offset: 3 desc: SMP1
        SMP2: u3, // bit offset: 6 desc: SMP2
        SMP3: u3, // bit offset: 9 desc: SMP3
        SMP4: u3, // bit offset: 12 desc: SMP4
        SMP5: u3, // bit offset: 15 desc: SMP5
        SMP6: u3, // bit offset: 18 desc: SMP6
        SMP7: u3, // bit offset: 21 desc: SMP7
        SMP8: u3, // bit offset: 24 desc: SMP8
        SMP9: u3, // bit offset: 27 desc: SMP9
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: SMP10
        SMP11: u3, // bit offset: 3 desc: SMP11
        SMP12: u3, // bit offset: 6 desc: SMP12
        SMP13: u3, // bit offset: 9 desc: SMP13
        SMP14: u3, // bit offset: 12 desc: SMP14
        SMP15: u3, // bit offset: 15 desc: SMP15
        SMP16: u3, // bit offset: 18 desc: SMP16
        SMP17: u3, // bit offset: 21 desc: SMP17
        SMP18: u3, // bit offset: 24 desc: SMP18
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        LT1: u12, // bit offset: 0 desc: LT1
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT1: u12, // bit offset: 16 desc: HT1
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        LT2: u8, // bit offset: 0 desc: LT2
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT2: u8, // bit offset: 16 desc: HT2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        LT3: u8, // bit offset: 0 desc: LT3
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT3: u8, // bit offset: 16 desc: HT3
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        L3: u4, // bit offset: 0 desc: L3
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SQ1: u5, // bit offset: 6 desc: SQ1
        reserved3: u1 = 0,
        SQ2: u5, // bit offset: 12 desc: SQ2
        reserved4: u1 = 0,
        SQ3: u5, // bit offset: 18 desc: SQ3
        reserved5: u1 = 0,
        SQ4: u5, // bit offset: 24 desc: SQ4
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        SQ5: u5, // bit offset: 0 desc: SQ5
        reserved1: u1 = 0,
        SQ6: u5, // bit offset: 6 desc: SQ6
        reserved2: u1 = 0,
        SQ7: u5, // bit offset: 12 desc: SQ7
        reserved3: u1 = 0,
        SQ8: u5, // bit offset: 18 desc: SQ8
        reserved4: u1 = 0,
        SQ9: u5, // bit offset: 24 desc: SQ9
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        SQ10: u5, // bit offset: 0 desc: SQ10
        reserved1: u1 = 0,
        SQ11: u5, // bit offset: 6 desc: SQ11
        reserved2: u1 = 0,
        SQ12: u5, // bit offset: 12 desc: SQ12
        reserved3: u1 = 0,
        SQ13: u5, // bit offset: 18 desc: SQ13
        reserved4: u1 = 0,
        SQ14: u5, // bit offset: 24 desc: SQ14
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        SQ15: u5, // bit offset: 0 desc: SQ15
        reserved1: u1 = 0,
        SQ16: u5, // bit offset: 6 desc: SQ16
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
    // byte offset: 64 regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        regularDATA: u16, // bit offset: 0 desc: regularDATA
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        JL: u2, // bit offset: 0 desc: JL
        JEXTSEL: u4, // bit offset: 2 desc: JEXTSEL
        JEXTEN: u2, // bit offset: 6 desc: JEXTEN
        JSQ1: u5, // bit offset: 8 desc: JSQ1
        reserved1: u1 = 0,
        JSQ2: u5, // bit offset: 14 desc: JSQ2
        reserved2: u1 = 0,
        JSQ3: u5, // bit offset: 20 desc: JSQ3
        reserved3: u1 = 0,
        JSQ4: u5, // bit offset: 26 desc: JSQ4
        padding1: u1 = 0,
    });
    // byte offset: 96 offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        OFFSET1: u12, // bit offset: 0 desc: OFFSET1
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
        OFFSET1_CH: u5, // bit offset: 26 desc: OFFSET1_CH
        OFFSET1_EN: u1, // bit offset: 31 desc: OFFSET1_EN
    });
    // byte offset: 100 offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        OFFSET2: u12, // bit offset: 0 desc: OFFSET2
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
        OFFSET2_CH: u5, // bit offset: 26 desc: OFFSET2_CH
        OFFSET2_EN: u1, // bit offset: 31 desc: OFFSET2_EN
    });
    // byte offset: 104 offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        OFFSET3: u12, // bit offset: 0 desc: OFFSET3
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
        OFFSET3_CH: u5, // bit offset: 26 desc: OFFSET3_CH
        OFFSET3_EN: u1, // bit offset: 31 desc: OFFSET3_EN
    });
    // byte offset: 108 offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        OFFSET4: u12, // bit offset: 0 desc: OFFSET4
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
        OFFSET4_CH: u5, // bit offset: 26 desc: OFFSET4_CH
        OFFSET4_EN: u1, // bit offset: 31 desc: OFFSET4_EN
    });
    // byte offset: 128 injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        JDATA1: u16, // bit offset: 0 desc: JDATA1
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        JDATA2: u16, // bit offset: 0 desc: JDATA2
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        JDATA3: u16, // bit offset: 0 desc: JDATA3
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 140 injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        JDATA4: u16, // bit offset: 0 desc: JDATA4
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 160 Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        AWD2CH: u18, // bit offset: 1 desc: AWD2CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        AWD3CH: u18, // bit offset: 1 desc: AWD3CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 176 Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        DIFSEL_1_15: u15, // bit offset: 1 desc: Differential mode for channels 15 to 1
        DIFSEL_16_18: u3, // bit offset: 16 desc: Differential mode for channels 18 to 16
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 180 Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        CALFACT_S: u7, // bit offset: 0 desc: CALFACT_S
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CALFACT_D: u7, // bit offset: 16 desc: CALFACT_D
        padding9: u1 = 0,
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
pub const ADC2 = extern struct {
    pub const Address: u32 = 0x50000100;
    // byte offset: 0 interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        ADRDY: u1, // bit offset: 0 desc: ADRDY
        EOSMP: u1, // bit offset: 1 desc: EOSMP
        EOC: u1, // bit offset: 2 desc: EOC
        EOS: u1, // bit offset: 3 desc: EOS
        OVR: u1, // bit offset: 4 desc: OVR
        JEOC: u1, // bit offset: 5 desc: JEOC
        JEOS: u1, // bit offset: 6 desc: JEOS
        AWD1: u1, // bit offset: 7 desc: AWD1
        AWD2: u1, // bit offset: 8 desc: AWD2
        AWD3: u1, // bit offset: 9 desc: AWD3
        JQOVF: u1, // bit offset: 10 desc: JQOVF
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
    // byte offset: 4 interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        ADRDYIE: u1, // bit offset: 0 desc: ADRDYIE
        EOSMPIE: u1, // bit offset: 1 desc: EOSMPIE
        EOCIE: u1, // bit offset: 2 desc: EOCIE
        EOSIE: u1, // bit offset: 3 desc: EOSIE
        OVRIE: u1, // bit offset: 4 desc: OVRIE
        JEOCIE: u1, // bit offset: 5 desc: JEOCIE
        JEOSIE: u1, // bit offset: 6 desc: JEOSIE
        AWD1IE: u1, // bit offset: 7 desc: AWD1IE
        AWD2IE: u1, // bit offset: 8 desc: AWD2IE
        AWD3IE: u1, // bit offset: 9 desc: AWD3IE
        JQOVFIE: u1, // bit offset: 10 desc: JQOVFIE
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
    // byte offset: 8 control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        ADEN: u1, // bit offset: 0 desc: ADEN
        ADDIS: u1, // bit offset: 1 desc: ADDIS
        ADSTART: u1, // bit offset: 2 desc: ADSTART
        JADSTART: u1, // bit offset: 3 desc: JADSTART
        ADSTP: u1, // bit offset: 4 desc: ADSTP
        JADSTP: u1, // bit offset: 5 desc: JADSTP
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
        ADVREGEN: u1, // bit offset: 28 desc: ADVREGEN
        DEEPPWD: u1, // bit offset: 29 desc: DEEPPWD
        ADCALDIF: u1, // bit offset: 30 desc: ADCALDIF
        ADCAL: u1, // bit offset: 31 desc: ADCAL
    });
    // byte offset: 12 configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        DMAEN: u1, // bit offset: 0 desc: DMAEN
        DMACFG: u1, // bit offset: 1 desc: DMACFG
        reserved1: u1 = 0,
        RES: u2, // bit offset: 3 desc: RES
        ALIGN: u1, // bit offset: 5 desc: ALIGN
        EXTSEL: u4, // bit offset: 6 desc: EXTSEL
        EXTEN: u2, // bit offset: 10 desc: EXTEN
        OVRMOD: u1, // bit offset: 12 desc: OVRMOD
        CONT: u1, // bit offset: 13 desc: CONT
        AUTDLY: u1, // bit offset: 14 desc: AUTDLY
        AUTOFF: u1, // bit offset: 15 desc: AUTOFF
        DISCEN: u1, // bit offset: 16 desc: DISCEN
        DISCNUM: u3, // bit offset: 17 desc: DISCNUM
        JDISCEN: u1, // bit offset: 20 desc: JDISCEN
        JQM: u1, // bit offset: 21 desc: JQM
        AWD1SGL: u1, // bit offset: 22 desc: AWD1SGL
        AWD1EN: u1, // bit offset: 23 desc: AWD1EN
        JAWD1EN: u1, // bit offset: 24 desc: JAWD1EN
        JAUTO: u1, // bit offset: 25 desc: JAUTO
        AWDCH1CH: u5, // bit offset: 26 desc: AWDCH1CH
        padding1: u1 = 0,
    });
    // byte offset: 20 sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SMP1: u3, // bit offset: 3 desc: SMP1
        SMP2: u3, // bit offset: 6 desc: SMP2
        SMP3: u3, // bit offset: 9 desc: SMP3
        SMP4: u3, // bit offset: 12 desc: SMP4
        SMP5: u3, // bit offset: 15 desc: SMP5
        SMP6: u3, // bit offset: 18 desc: SMP6
        SMP7: u3, // bit offset: 21 desc: SMP7
        SMP8: u3, // bit offset: 24 desc: SMP8
        SMP9: u3, // bit offset: 27 desc: SMP9
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: SMP10
        SMP11: u3, // bit offset: 3 desc: SMP11
        SMP12: u3, // bit offset: 6 desc: SMP12
        SMP13: u3, // bit offset: 9 desc: SMP13
        SMP14: u3, // bit offset: 12 desc: SMP14
        SMP15: u3, // bit offset: 15 desc: SMP15
        SMP16: u3, // bit offset: 18 desc: SMP16
        SMP17: u3, // bit offset: 21 desc: SMP17
        SMP18: u3, // bit offset: 24 desc: SMP18
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        LT1: u12, // bit offset: 0 desc: LT1
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT1: u12, // bit offset: 16 desc: HT1
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        LT2: u8, // bit offset: 0 desc: LT2
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT2: u8, // bit offset: 16 desc: HT2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        LT3: u8, // bit offset: 0 desc: LT3
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT3: u8, // bit offset: 16 desc: HT3
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        L3: u4, // bit offset: 0 desc: L3
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SQ1: u5, // bit offset: 6 desc: SQ1
        reserved3: u1 = 0,
        SQ2: u5, // bit offset: 12 desc: SQ2
        reserved4: u1 = 0,
        SQ3: u5, // bit offset: 18 desc: SQ3
        reserved5: u1 = 0,
        SQ4: u5, // bit offset: 24 desc: SQ4
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        SQ5: u5, // bit offset: 0 desc: SQ5
        reserved1: u1 = 0,
        SQ6: u5, // bit offset: 6 desc: SQ6
        reserved2: u1 = 0,
        SQ7: u5, // bit offset: 12 desc: SQ7
        reserved3: u1 = 0,
        SQ8: u5, // bit offset: 18 desc: SQ8
        reserved4: u1 = 0,
        SQ9: u5, // bit offset: 24 desc: SQ9
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        SQ10: u5, // bit offset: 0 desc: SQ10
        reserved1: u1 = 0,
        SQ11: u5, // bit offset: 6 desc: SQ11
        reserved2: u1 = 0,
        SQ12: u5, // bit offset: 12 desc: SQ12
        reserved3: u1 = 0,
        SQ13: u5, // bit offset: 18 desc: SQ13
        reserved4: u1 = 0,
        SQ14: u5, // bit offset: 24 desc: SQ14
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        SQ15: u5, // bit offset: 0 desc: SQ15
        reserved1: u1 = 0,
        SQ16: u5, // bit offset: 6 desc: SQ16
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
    // byte offset: 64 regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        regularDATA: u16, // bit offset: 0 desc: regularDATA
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        JL: u2, // bit offset: 0 desc: JL
        JEXTSEL: u4, // bit offset: 2 desc: JEXTSEL
        JEXTEN: u2, // bit offset: 6 desc: JEXTEN
        JSQ1: u5, // bit offset: 8 desc: JSQ1
        reserved1: u1 = 0,
        JSQ2: u5, // bit offset: 14 desc: JSQ2
        reserved2: u1 = 0,
        JSQ3: u5, // bit offset: 20 desc: JSQ3
        reserved3: u1 = 0,
        JSQ4: u5, // bit offset: 26 desc: JSQ4
        padding1: u1 = 0,
    });
    // byte offset: 96 offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        OFFSET1: u12, // bit offset: 0 desc: OFFSET1
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
        OFFSET1_CH: u5, // bit offset: 26 desc: OFFSET1_CH
        OFFSET1_EN: u1, // bit offset: 31 desc: OFFSET1_EN
    });
    // byte offset: 100 offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        OFFSET2: u12, // bit offset: 0 desc: OFFSET2
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
        OFFSET2_CH: u5, // bit offset: 26 desc: OFFSET2_CH
        OFFSET2_EN: u1, // bit offset: 31 desc: OFFSET2_EN
    });
    // byte offset: 104 offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        OFFSET3: u12, // bit offset: 0 desc: OFFSET3
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
        OFFSET3_CH: u5, // bit offset: 26 desc: OFFSET3_CH
        OFFSET3_EN: u1, // bit offset: 31 desc: OFFSET3_EN
    });
    // byte offset: 108 offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        OFFSET4: u12, // bit offset: 0 desc: OFFSET4
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
        OFFSET4_CH: u5, // bit offset: 26 desc: OFFSET4_CH
        OFFSET4_EN: u1, // bit offset: 31 desc: OFFSET4_EN
    });
    // byte offset: 128 injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        JDATA1: u16, // bit offset: 0 desc: JDATA1
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        JDATA2: u16, // bit offset: 0 desc: JDATA2
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        JDATA3: u16, // bit offset: 0 desc: JDATA3
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 140 injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        JDATA4: u16, // bit offset: 0 desc: JDATA4
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 160 Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        AWD2CH: u18, // bit offset: 1 desc: AWD2CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        AWD3CH: u18, // bit offset: 1 desc: AWD3CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 176 Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        DIFSEL_1_15: u15, // bit offset: 1 desc: Differential mode for channels 15 to 1
        DIFSEL_16_18: u3, // bit offset: 16 desc: Differential mode for channels 18 to 16
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 180 Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        CALFACT_S: u7, // bit offset: 0 desc: CALFACT_S
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CALFACT_D: u7, // bit offset: 16 desc: CALFACT_D
        padding9: u1 = 0,
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
pub const ADC3 = extern struct {
    pub const Address: u32 = 0x50000400;
    // byte offset: 0 interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        ADRDY: u1, // bit offset: 0 desc: ADRDY
        EOSMP: u1, // bit offset: 1 desc: EOSMP
        EOC: u1, // bit offset: 2 desc: EOC
        EOS: u1, // bit offset: 3 desc: EOS
        OVR: u1, // bit offset: 4 desc: OVR
        JEOC: u1, // bit offset: 5 desc: JEOC
        JEOS: u1, // bit offset: 6 desc: JEOS
        AWD1: u1, // bit offset: 7 desc: AWD1
        AWD2: u1, // bit offset: 8 desc: AWD2
        AWD3: u1, // bit offset: 9 desc: AWD3
        JQOVF: u1, // bit offset: 10 desc: JQOVF
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
    // byte offset: 4 interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        ADRDYIE: u1, // bit offset: 0 desc: ADRDYIE
        EOSMPIE: u1, // bit offset: 1 desc: EOSMPIE
        EOCIE: u1, // bit offset: 2 desc: EOCIE
        EOSIE: u1, // bit offset: 3 desc: EOSIE
        OVRIE: u1, // bit offset: 4 desc: OVRIE
        JEOCIE: u1, // bit offset: 5 desc: JEOCIE
        JEOSIE: u1, // bit offset: 6 desc: JEOSIE
        AWD1IE: u1, // bit offset: 7 desc: AWD1IE
        AWD2IE: u1, // bit offset: 8 desc: AWD2IE
        AWD3IE: u1, // bit offset: 9 desc: AWD3IE
        JQOVFIE: u1, // bit offset: 10 desc: JQOVFIE
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
    // byte offset: 8 control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        ADEN: u1, // bit offset: 0 desc: ADEN
        ADDIS: u1, // bit offset: 1 desc: ADDIS
        ADSTART: u1, // bit offset: 2 desc: ADSTART
        JADSTART: u1, // bit offset: 3 desc: JADSTART
        ADSTP: u1, // bit offset: 4 desc: ADSTP
        JADSTP: u1, // bit offset: 5 desc: JADSTP
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
        ADVREGEN: u1, // bit offset: 28 desc: ADVREGEN
        DEEPPWD: u1, // bit offset: 29 desc: DEEPPWD
        ADCALDIF: u1, // bit offset: 30 desc: ADCALDIF
        ADCAL: u1, // bit offset: 31 desc: ADCAL
    });
    // byte offset: 12 configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        DMAEN: u1, // bit offset: 0 desc: DMAEN
        DMACFG: u1, // bit offset: 1 desc: DMACFG
        reserved1: u1 = 0,
        RES: u2, // bit offset: 3 desc: RES
        ALIGN: u1, // bit offset: 5 desc: ALIGN
        EXTSEL: u4, // bit offset: 6 desc: EXTSEL
        EXTEN: u2, // bit offset: 10 desc: EXTEN
        OVRMOD: u1, // bit offset: 12 desc: OVRMOD
        CONT: u1, // bit offset: 13 desc: CONT
        AUTDLY: u1, // bit offset: 14 desc: AUTDLY
        AUTOFF: u1, // bit offset: 15 desc: AUTOFF
        DISCEN: u1, // bit offset: 16 desc: DISCEN
        DISCNUM: u3, // bit offset: 17 desc: DISCNUM
        JDISCEN: u1, // bit offset: 20 desc: JDISCEN
        JQM: u1, // bit offset: 21 desc: JQM
        AWD1SGL: u1, // bit offset: 22 desc: AWD1SGL
        AWD1EN: u1, // bit offset: 23 desc: AWD1EN
        JAWD1EN: u1, // bit offset: 24 desc: JAWD1EN
        JAUTO: u1, // bit offset: 25 desc: JAUTO
        AWDCH1CH: u5, // bit offset: 26 desc: AWDCH1CH
        padding1: u1 = 0,
    });
    // byte offset: 20 sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SMP1: u3, // bit offset: 3 desc: SMP1
        SMP2: u3, // bit offset: 6 desc: SMP2
        SMP3: u3, // bit offset: 9 desc: SMP3
        SMP4: u3, // bit offset: 12 desc: SMP4
        SMP5: u3, // bit offset: 15 desc: SMP5
        SMP6: u3, // bit offset: 18 desc: SMP6
        SMP7: u3, // bit offset: 21 desc: SMP7
        SMP8: u3, // bit offset: 24 desc: SMP8
        SMP9: u3, // bit offset: 27 desc: SMP9
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: SMP10
        SMP11: u3, // bit offset: 3 desc: SMP11
        SMP12: u3, // bit offset: 6 desc: SMP12
        SMP13: u3, // bit offset: 9 desc: SMP13
        SMP14: u3, // bit offset: 12 desc: SMP14
        SMP15: u3, // bit offset: 15 desc: SMP15
        SMP16: u3, // bit offset: 18 desc: SMP16
        SMP17: u3, // bit offset: 21 desc: SMP17
        SMP18: u3, // bit offset: 24 desc: SMP18
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        LT1: u12, // bit offset: 0 desc: LT1
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT1: u12, // bit offset: 16 desc: HT1
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        LT2: u8, // bit offset: 0 desc: LT2
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT2: u8, // bit offset: 16 desc: HT2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        LT3: u8, // bit offset: 0 desc: LT3
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT3: u8, // bit offset: 16 desc: HT3
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        L3: u4, // bit offset: 0 desc: L3
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SQ1: u5, // bit offset: 6 desc: SQ1
        reserved3: u1 = 0,
        SQ2: u5, // bit offset: 12 desc: SQ2
        reserved4: u1 = 0,
        SQ3: u5, // bit offset: 18 desc: SQ3
        reserved5: u1 = 0,
        SQ4: u5, // bit offset: 24 desc: SQ4
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        SQ5: u5, // bit offset: 0 desc: SQ5
        reserved1: u1 = 0,
        SQ6: u5, // bit offset: 6 desc: SQ6
        reserved2: u1 = 0,
        SQ7: u5, // bit offset: 12 desc: SQ7
        reserved3: u1 = 0,
        SQ8: u5, // bit offset: 18 desc: SQ8
        reserved4: u1 = 0,
        SQ9: u5, // bit offset: 24 desc: SQ9
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        SQ10: u5, // bit offset: 0 desc: SQ10
        reserved1: u1 = 0,
        SQ11: u5, // bit offset: 6 desc: SQ11
        reserved2: u1 = 0,
        SQ12: u5, // bit offset: 12 desc: SQ12
        reserved3: u1 = 0,
        SQ13: u5, // bit offset: 18 desc: SQ13
        reserved4: u1 = 0,
        SQ14: u5, // bit offset: 24 desc: SQ14
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        SQ15: u5, // bit offset: 0 desc: SQ15
        reserved1: u1 = 0,
        SQ16: u5, // bit offset: 6 desc: SQ16
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
    // byte offset: 64 regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        regularDATA: u16, // bit offset: 0 desc: regularDATA
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        JL: u2, // bit offset: 0 desc: JL
        JEXTSEL: u4, // bit offset: 2 desc: JEXTSEL
        JEXTEN: u2, // bit offset: 6 desc: JEXTEN
        JSQ1: u5, // bit offset: 8 desc: JSQ1
        reserved1: u1 = 0,
        JSQ2: u5, // bit offset: 14 desc: JSQ2
        reserved2: u1 = 0,
        JSQ3: u5, // bit offset: 20 desc: JSQ3
        reserved3: u1 = 0,
        JSQ4: u5, // bit offset: 26 desc: JSQ4
        padding1: u1 = 0,
    });
    // byte offset: 96 offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        OFFSET1: u12, // bit offset: 0 desc: OFFSET1
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
        OFFSET1_CH: u5, // bit offset: 26 desc: OFFSET1_CH
        OFFSET1_EN: u1, // bit offset: 31 desc: OFFSET1_EN
    });
    // byte offset: 100 offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        OFFSET2: u12, // bit offset: 0 desc: OFFSET2
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
        OFFSET2_CH: u5, // bit offset: 26 desc: OFFSET2_CH
        OFFSET2_EN: u1, // bit offset: 31 desc: OFFSET2_EN
    });
    // byte offset: 104 offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        OFFSET3: u12, // bit offset: 0 desc: OFFSET3
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
        OFFSET3_CH: u5, // bit offset: 26 desc: OFFSET3_CH
        OFFSET3_EN: u1, // bit offset: 31 desc: OFFSET3_EN
    });
    // byte offset: 108 offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        OFFSET4: u12, // bit offset: 0 desc: OFFSET4
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
        OFFSET4_CH: u5, // bit offset: 26 desc: OFFSET4_CH
        OFFSET4_EN: u1, // bit offset: 31 desc: OFFSET4_EN
    });
    // byte offset: 128 injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        JDATA1: u16, // bit offset: 0 desc: JDATA1
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        JDATA2: u16, // bit offset: 0 desc: JDATA2
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        JDATA3: u16, // bit offset: 0 desc: JDATA3
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 140 injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        JDATA4: u16, // bit offset: 0 desc: JDATA4
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 160 Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        AWD2CH: u18, // bit offset: 1 desc: AWD2CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        AWD3CH: u18, // bit offset: 1 desc: AWD3CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 176 Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        DIFSEL_1_15: u15, // bit offset: 1 desc: Differential mode for channels 15 to 1
        DIFSEL_16_18: u3, // bit offset: 16 desc: Differential mode for channels 18 to 16
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 180 Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        CALFACT_S: u7, // bit offset: 0 desc: CALFACT_S
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CALFACT_D: u7, // bit offset: 16 desc: CALFACT_D
        padding9: u1 = 0,
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
pub const ADC4 = extern struct {
    pub const Address: u32 = 0x50000500;
    // byte offset: 0 interrupt and status register
    pub const ISR = mmio(Address + 0x00000000, 32, packed struct {
        ADRDY: u1, // bit offset: 0 desc: ADRDY
        EOSMP: u1, // bit offset: 1 desc: EOSMP
        EOC: u1, // bit offset: 2 desc: EOC
        EOS: u1, // bit offset: 3 desc: EOS
        OVR: u1, // bit offset: 4 desc: OVR
        JEOC: u1, // bit offset: 5 desc: JEOC
        JEOS: u1, // bit offset: 6 desc: JEOS
        AWD1: u1, // bit offset: 7 desc: AWD1
        AWD2: u1, // bit offset: 8 desc: AWD2
        AWD3: u1, // bit offset: 9 desc: AWD3
        JQOVF: u1, // bit offset: 10 desc: JQOVF
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
    // byte offset: 4 interrupt enable register
    pub const IER = mmio(Address + 0x00000004, 32, packed struct {
        ADRDYIE: u1, // bit offset: 0 desc: ADRDYIE
        EOSMPIE: u1, // bit offset: 1 desc: EOSMPIE
        EOCIE: u1, // bit offset: 2 desc: EOCIE
        EOSIE: u1, // bit offset: 3 desc: EOSIE
        OVRIE: u1, // bit offset: 4 desc: OVRIE
        JEOCIE: u1, // bit offset: 5 desc: JEOCIE
        JEOSIE: u1, // bit offset: 6 desc: JEOSIE
        AWD1IE: u1, // bit offset: 7 desc: AWD1IE
        AWD2IE: u1, // bit offset: 8 desc: AWD2IE
        AWD3IE: u1, // bit offset: 9 desc: AWD3IE
        JQOVFIE: u1, // bit offset: 10 desc: JQOVFIE
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
    // byte offset: 8 control register
    pub const CR = mmio(Address + 0x00000008, 32, packed struct {
        ADEN: u1, // bit offset: 0 desc: ADEN
        ADDIS: u1, // bit offset: 1 desc: ADDIS
        ADSTART: u1, // bit offset: 2 desc: ADSTART
        JADSTART: u1, // bit offset: 3 desc: JADSTART
        ADSTP: u1, // bit offset: 4 desc: ADSTP
        JADSTP: u1, // bit offset: 5 desc: JADSTP
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
        ADVREGEN: u1, // bit offset: 28 desc: ADVREGEN
        DEEPPWD: u1, // bit offset: 29 desc: DEEPPWD
        ADCALDIF: u1, // bit offset: 30 desc: ADCALDIF
        ADCAL: u1, // bit offset: 31 desc: ADCAL
    });
    // byte offset: 12 configuration register
    pub const CFGR = mmio(Address + 0x0000000c, 32, packed struct {
        DMAEN: u1, // bit offset: 0 desc: DMAEN
        DMACFG: u1, // bit offset: 1 desc: DMACFG
        reserved1: u1 = 0,
        RES: u2, // bit offset: 3 desc: RES
        ALIGN: u1, // bit offset: 5 desc: ALIGN
        EXTSEL: u4, // bit offset: 6 desc: EXTSEL
        EXTEN: u2, // bit offset: 10 desc: EXTEN
        OVRMOD: u1, // bit offset: 12 desc: OVRMOD
        CONT: u1, // bit offset: 13 desc: CONT
        AUTDLY: u1, // bit offset: 14 desc: AUTDLY
        AUTOFF: u1, // bit offset: 15 desc: AUTOFF
        DISCEN: u1, // bit offset: 16 desc: DISCEN
        DISCNUM: u3, // bit offset: 17 desc: DISCNUM
        JDISCEN: u1, // bit offset: 20 desc: JDISCEN
        JQM: u1, // bit offset: 21 desc: JQM
        AWD1SGL: u1, // bit offset: 22 desc: AWD1SGL
        AWD1EN: u1, // bit offset: 23 desc: AWD1EN
        JAWD1EN: u1, // bit offset: 24 desc: JAWD1EN
        JAUTO: u1, // bit offset: 25 desc: JAUTO
        AWDCH1CH: u5, // bit offset: 26 desc: AWDCH1CH
        padding1: u1 = 0,
    });
    // byte offset: 20 sample time register 1
    pub const SMPR1 = mmio(Address + 0x00000014, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SMP1: u3, // bit offset: 3 desc: SMP1
        SMP2: u3, // bit offset: 6 desc: SMP2
        SMP3: u3, // bit offset: 9 desc: SMP3
        SMP4: u3, // bit offset: 12 desc: SMP4
        SMP5: u3, // bit offset: 15 desc: SMP5
        SMP6: u3, // bit offset: 18 desc: SMP6
        SMP7: u3, // bit offset: 21 desc: SMP7
        SMP8: u3, // bit offset: 24 desc: SMP8
        SMP9: u3, // bit offset: 27 desc: SMP9
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000018, 32, packed struct {
        SMP10: u3, // bit offset: 0 desc: SMP10
        SMP11: u3, // bit offset: 3 desc: SMP11
        SMP12: u3, // bit offset: 6 desc: SMP12
        SMP13: u3, // bit offset: 9 desc: SMP13
        SMP14: u3, // bit offset: 12 desc: SMP14
        SMP15: u3, // bit offset: 15 desc: SMP15
        SMP16: u3, // bit offset: 18 desc: SMP16
        SMP17: u3, // bit offset: 21 desc: SMP17
        SMP18: u3, // bit offset: 24 desc: SMP18
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 32 watchdog threshold register 1
    pub const TR1 = mmio(Address + 0x00000020, 32, packed struct {
        LT1: u12, // bit offset: 0 desc: LT1
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT1: u12, // bit offset: 16 desc: HT1
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 36 watchdog threshold register
    pub const TR2 = mmio(Address + 0x00000024, 32, packed struct {
        LT2: u8, // bit offset: 0 desc: LT2
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT2: u8, // bit offset: 16 desc: HT2
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 watchdog threshold register 3
    pub const TR3 = mmio(Address + 0x00000028, 32, packed struct {
        LT3: u8, // bit offset: 0 desc: LT3
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        HT3: u8, // bit offset: 16 desc: HT3
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 48 regular sequence register 1
    pub const SQR1 = mmio(Address + 0x00000030, 32, packed struct {
        L3: u4, // bit offset: 0 desc: L3
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SQ1: u5, // bit offset: 6 desc: SQ1
        reserved3: u1 = 0,
        SQ2: u5, // bit offset: 12 desc: SQ2
        reserved4: u1 = 0,
        SQ3: u5, // bit offset: 18 desc: SQ3
        reserved5: u1 = 0,
        SQ4: u5, // bit offset: 24 desc: SQ4
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 52 regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000034, 32, packed struct {
        SQ5: u5, // bit offset: 0 desc: SQ5
        reserved1: u1 = 0,
        SQ6: u5, // bit offset: 6 desc: SQ6
        reserved2: u1 = 0,
        SQ7: u5, // bit offset: 12 desc: SQ7
        reserved3: u1 = 0,
        SQ8: u5, // bit offset: 18 desc: SQ8
        reserved4: u1 = 0,
        SQ9: u5, // bit offset: 24 desc: SQ9
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 56 regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000038, 32, packed struct {
        SQ10: u5, // bit offset: 0 desc: SQ10
        reserved1: u1 = 0,
        SQ11: u5, // bit offset: 6 desc: SQ11
        reserved2: u1 = 0,
        SQ12: u5, // bit offset: 12 desc: SQ12
        reserved3: u1 = 0,
        SQ13: u5, // bit offset: 18 desc: SQ13
        reserved4: u1 = 0,
        SQ14: u5, // bit offset: 24 desc: SQ14
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 60 regular sequence register 4
    pub const SQR4 = mmio(Address + 0x0000003c, 32, packed struct {
        SQ15: u5, // bit offset: 0 desc: SQ15
        reserved1: u1 = 0,
        SQ16: u5, // bit offset: 6 desc: SQ16
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
    // byte offset: 64 regular Data Register
    pub const DR = mmio(Address + 0x00000040, 32, packed struct {
        regularDATA: u16, // bit offset: 0 desc: regularDATA
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 76 injected sequence register
    pub const JSQR = mmio(Address + 0x0000004c, 32, packed struct {
        JL: u2, // bit offset: 0 desc: JL
        JEXTSEL: u4, // bit offset: 2 desc: JEXTSEL
        JEXTEN: u2, // bit offset: 6 desc: JEXTEN
        JSQ1: u5, // bit offset: 8 desc: JSQ1
        reserved1: u1 = 0,
        JSQ2: u5, // bit offset: 14 desc: JSQ2
        reserved2: u1 = 0,
        JSQ3: u5, // bit offset: 20 desc: JSQ3
        reserved3: u1 = 0,
        JSQ4: u5, // bit offset: 26 desc: JSQ4
        padding1: u1 = 0,
    });
    // byte offset: 96 offset register 1
    pub const OFR1 = mmio(Address + 0x00000060, 32, packed struct {
        OFFSET1: u12, // bit offset: 0 desc: OFFSET1
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
        OFFSET1_CH: u5, // bit offset: 26 desc: OFFSET1_CH
        OFFSET1_EN: u1, // bit offset: 31 desc: OFFSET1_EN
    });
    // byte offset: 100 offset register 2
    pub const OFR2 = mmio(Address + 0x00000064, 32, packed struct {
        OFFSET2: u12, // bit offset: 0 desc: OFFSET2
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
        OFFSET2_CH: u5, // bit offset: 26 desc: OFFSET2_CH
        OFFSET2_EN: u1, // bit offset: 31 desc: OFFSET2_EN
    });
    // byte offset: 104 offset register 3
    pub const OFR3 = mmio(Address + 0x00000068, 32, packed struct {
        OFFSET3: u12, // bit offset: 0 desc: OFFSET3
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
        OFFSET3_CH: u5, // bit offset: 26 desc: OFFSET3_CH
        OFFSET3_EN: u1, // bit offset: 31 desc: OFFSET3_EN
    });
    // byte offset: 108 offset register 4
    pub const OFR4 = mmio(Address + 0x0000006c, 32, packed struct {
        OFFSET4: u12, // bit offset: 0 desc: OFFSET4
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
        OFFSET4_CH: u5, // bit offset: 26 desc: OFFSET4_CH
        OFFSET4_EN: u1, // bit offset: 31 desc: OFFSET4_EN
    });
    // byte offset: 128 injected data register 1
    pub const JDR1 = mmio(Address + 0x00000080, 32, packed struct {
        JDATA1: u16, // bit offset: 0 desc: JDATA1
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 injected data register 2
    pub const JDR2 = mmio(Address + 0x00000084, 32, packed struct {
        JDATA2: u16, // bit offset: 0 desc: JDATA2
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 136 injected data register 3
    pub const JDR3 = mmio(Address + 0x00000088, 32, packed struct {
        JDATA3: u16, // bit offset: 0 desc: JDATA3
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 140 injected data register 4
    pub const JDR4 = mmio(Address + 0x0000008c, 32, packed struct {
        JDATA4: u16, // bit offset: 0 desc: JDATA4
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 160 Analog Watchdog 2 Configuration Register
    pub const AWD2CR = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        AWD2CH: u18, // bit offset: 1 desc: AWD2CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 Analog Watchdog 3 Configuration Register
    pub const AWD3CR = mmio(Address + 0x000000a4, 32, packed struct {
        reserved1: u1 = 0,
        AWD3CH: u18, // bit offset: 1 desc: AWD3CH
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 176 Differential Mode Selection Register 2
    pub const DIFSEL = mmio(Address + 0x000000b0, 32, packed struct {
        reserved1: u1 = 0,
        DIFSEL_1_15: u15, // bit offset: 1 desc: Differential mode for channels 15 to 1
        DIFSEL_16_18: u3, // bit offset: 16 desc: Differential mode for channels 18 to 16
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 180 Calibration Factors
    pub const CALFACT = mmio(Address + 0x000000b4, 32, packed struct {
        CALFACT_S: u7, // bit offset: 0 desc: CALFACT_S
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        CALFACT_D: u7, // bit offset: 16 desc: CALFACT_D
        padding9: u1 = 0,
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
pub const ADC1_2 = extern struct {
    pub const Address: u32 = 0x50000300;
    // byte offset: 0 ADC Common status register
    pub const CSR = mmio(Address + 0x00000000, 32, packed struct {
        ADDRDY_MST: u1, // bit offset: 0 desc: ADDRDY_MST
        EOSMP_MST: u1, // bit offset: 1 desc: EOSMP_MST
        EOC_MST: u1, // bit offset: 2 desc: EOC_MST
        EOS_MST: u1, // bit offset: 3 desc: EOS_MST
        OVR_MST: u1, // bit offset: 4 desc: OVR_MST
        JEOC_MST: u1, // bit offset: 5 desc: JEOC_MST
        JEOS_MST: u1, // bit offset: 6 desc: JEOS_MST
        AWD1_MST: u1, // bit offset: 7 desc: AWD1_MST
        AWD2_MST: u1, // bit offset: 8 desc: AWD2_MST
        AWD3_MST: u1, // bit offset: 9 desc: AWD3_MST
        JQOVF_MST: u1, // bit offset: 10 desc: JQOVF_MST
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADRDY_SLV: u1, // bit offset: 16 desc: ADRDY_SLV
        EOSMP_SLV: u1, // bit offset: 17 desc: EOSMP_SLV
        EOC_SLV: u1, // bit offset: 18 desc: End of regular conversion of the slave ADC
        EOS_SLV: u1, // bit offset: 19 desc: End of regular sequence flag of the slave ADC
        OVR_SLV: u1, // bit offset: 20 desc: Overrun flag of the slave ADC
        JEOC_SLV: u1, // bit offset: 21 desc: End of injected conversion flag of the slave ADC
        JEOS_SLV: u1, // bit offset: 22 desc: End of injected sequence flag of the slave ADC
        AWD1_SLV: u1, // bit offset: 23 desc: Analog watchdog 1 flag of the slave ADC
        AWD2_SLV: u1, // bit offset: 24 desc: Analog watchdog 2 flag of the slave ADC
        AWD3_SLV: u1, // bit offset: 25 desc: Analog watchdog 3 flag of the slave ADC
        JQOVF_SLV: u1, // bit offset: 26 desc: Injected Context Queue Overflow flag of the slave ADC
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 ADC common control register
    pub const CCR = mmio(Address + 0x00000008, 32, packed struct {
        MULT: u5, // bit offset: 0 desc: Multi ADC mode selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DELAY: u4, // bit offset: 8 desc: Delay between 2 sampling phases
        reserved4: u1 = 0,
        DMACFG: u1, // bit offset: 13 desc: DMA configuration (for multi-ADC mode)
        MDMA: u2, // bit offset: 14 desc: Direct memory access mode for multi ADC mode
        CKMODE: u2, // bit offset: 16 desc: ADC clock mode
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        VREFEN: u1, // bit offset: 22 desc: VREFINT enable
        TSEN: u1, // bit offset: 23 desc: Temperature sensor enable
        VBATEN: u1, // bit offset: 24 desc: VBAT enable
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 ADC common regular data register for dual and triple modes
    pub const CDR = mmio(Address + 0x0000000c, 32, packed struct {
        RDATA_MST: u16, // bit offset: 0 desc: Regular data of the master ADC
        RDATA_SLV: u16, // bit offset: 16 desc: Regular data of the slave ADC
    });
};
pub const ADC3_4 = extern struct {
    pub const Address: u32 = 0x50000700;
    // byte offset: 0 ADC Common status register
    pub const CSR = mmio(Address + 0x00000000, 32, packed struct {
        ADDRDY_MST: u1, // bit offset: 0 desc: ADDRDY_MST
        EOSMP_MST: u1, // bit offset: 1 desc: EOSMP_MST
        EOC_MST: u1, // bit offset: 2 desc: EOC_MST
        EOS_MST: u1, // bit offset: 3 desc: EOS_MST
        OVR_MST: u1, // bit offset: 4 desc: OVR_MST
        JEOC_MST: u1, // bit offset: 5 desc: JEOC_MST
        JEOS_MST: u1, // bit offset: 6 desc: JEOS_MST
        AWD1_MST: u1, // bit offset: 7 desc: AWD1_MST
        AWD2_MST: u1, // bit offset: 8 desc: AWD2_MST
        AWD3_MST: u1, // bit offset: 9 desc: AWD3_MST
        JQOVF_MST: u1, // bit offset: 10 desc: JQOVF_MST
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADRDY_SLV: u1, // bit offset: 16 desc: ADRDY_SLV
        EOSMP_SLV: u1, // bit offset: 17 desc: EOSMP_SLV
        EOC_SLV: u1, // bit offset: 18 desc: End of regular conversion of the slave ADC
        EOS_SLV: u1, // bit offset: 19 desc: End of regular sequence flag of the slave ADC
        OVR_SLV: u1, // bit offset: 20 desc: Overrun flag of the slave ADC
        JEOC_SLV: u1, // bit offset: 21 desc: End of injected conversion flag of the slave ADC
        JEOS_SLV: u1, // bit offset: 22 desc: End of injected sequence flag of the slave ADC
        AWD1_SLV: u1, // bit offset: 23 desc: Analog watchdog 1 flag of the slave ADC
        AWD2_SLV: u1, // bit offset: 24 desc: Analog watchdog 2 flag of the slave ADC
        AWD3_SLV: u1, // bit offset: 25 desc: Analog watchdog 3 flag of the slave ADC
        JQOVF_SLV: u1, // bit offset: 26 desc: Injected Context Queue Overflow flag of the slave ADC
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 ADC common control register
    pub const CCR = mmio(Address + 0x00000008, 32, packed struct {
        MULT: u5, // bit offset: 0 desc: Multi ADC mode selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DELAY: u4, // bit offset: 8 desc: Delay between 2 sampling phases
        reserved4: u1 = 0,
        DMACFG: u1, // bit offset: 13 desc: DMA configuration (for multi-ADC mode)
        MDMA: u2, // bit offset: 14 desc: Direct memory access mode for multi ADC mode
        CKMODE: u2, // bit offset: 16 desc: ADC clock mode
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        VREFEN: u1, // bit offset: 22 desc: VREFINT enable
        TSEN: u1, // bit offset: 23 desc: Temperature sensor enable
        VBATEN: u1, // bit offset: 24 desc: VBAT enable
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 ADC common regular data register for dual and triple modes
    pub const CDR = mmio(Address + 0x0000000c, 32, packed struct {
        RDATA_MST: u16, // bit offset: 0 desc: Regular data of the master ADC
        RDATA_SLV: u16, // bit offset: 16 desc: Regular data of the slave ADC
    });
};
pub const SYSCFG_COMP_OPAMP = extern struct {
    pub const Address: u32 = 0x40010000;
    // byte offset: 0 configuration register 1
    pub const SYSCFG_CFGR1 = mmio(Address + 0x00000000, 32, packed struct {
        MEM_MODE: u2, // bit offset: 0 desc: Memory mapping selection bits
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        USB_IT_RMP: u1, // bit offset: 5 desc: USB interrupt remap
        TIM1_ITR_RMP: u1, // bit offset: 6 desc: Timer 1 ITR3 selection
        DAC_TRIG_RMP: u1, // bit offset: 7 desc: DAC trigger remap (when TSEL = 001)
        ADC24_DMA_RMP: u1, // bit offset: 8 desc: ADC24 DMA remapping bit
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        TIM16_DMA_RMP: u1, // bit offset: 11 desc: TIM16 DMA request remapping bit
        TIM17_DMA_RMP: u1, // bit offset: 12 desc: TIM17 DMA request remapping bit
        TIM6_DAC1_DMA_RMP: u1, // bit offset: 13 desc: TIM6 and DAC1 DMA request remapping bit
        TIM7_DAC2_DMA_RMP: u1, // bit offset: 14 desc: TIM7 and DAC2 DMA request remapping bit
        reserved6: u1 = 0,
        I2C_PB6_FM: u1, // bit offset: 16 desc: Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB7_FM: u1, // bit offset: 17 desc: Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB8_FM: u1, // bit offset: 18 desc: Fast Mode Plus (FM+) driving capability activation bits.
        I2C_PB9_FM: u1, // bit offset: 19 desc: Fast Mode Plus (FM+) driving capability activation bits.
        I2C1_FM: u1, // bit offset: 20 desc: I2C1 Fast Mode Plus
        I2C2_FM: u1, // bit offset: 21 desc: I2C2 Fast Mode Plus
        ENCODER_MODE: u2, // bit offset: 22 desc: Encoder mode
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        FPU_IT: u6, // bit offset: 26 desc: Interrupt enable bits from FPU
    });
    // byte offset: 4 CCM SRAM protection register
    pub const SYSCFG_RCR = mmio(Address + 0x00000004, 32, packed struct {
        PAGE0_WP: u1, // bit offset: 0 desc: CCM SRAM page write protection bit
        PAGE1_WP: u1, // bit offset: 1 desc: CCM SRAM page write protection bit
        PAGE2_WP: u1, // bit offset: 2 desc: CCM SRAM page write protection bit
        PAGE3_WP: u1, // bit offset: 3 desc: CCM SRAM page write protection bit
        PAGE4_WP: u1, // bit offset: 4 desc: CCM SRAM page write protection bit
        PAGE5_WP: u1, // bit offset: 5 desc: CCM SRAM page write protection bit
        PAGE6_WP: u1, // bit offset: 6 desc: CCM SRAM page write protection bit
        PAGE7_WP: u1, // bit offset: 7 desc: CCM SRAM page write protection bit
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
    // byte offset: 8 external interrupt configuration register 1
    pub const SYSCFG_EXTICR1 = mmio(Address + 0x00000008, 32, packed struct {
        EXTI0: u4, // bit offset: 0 desc: EXTI 0 configuration bits
        EXTI1: u4, // bit offset: 4 desc: EXTI 1 configuration bits
        EXTI2: u4, // bit offset: 8 desc: EXTI 2 configuration bits
        EXTI3: u4, // bit offset: 12 desc: EXTI 3 configuration bits
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 external interrupt configuration register 2
    pub const SYSCFG_EXTICR2 = mmio(Address + 0x0000000c, 32, packed struct {
        EXTI4: u4, // bit offset: 0 desc: EXTI 4 configuration bits
        EXTI5: u4, // bit offset: 4 desc: EXTI 5 configuration bits
        EXTI6: u4, // bit offset: 8 desc: EXTI 6 configuration bits
        EXTI7: u4, // bit offset: 12 desc: EXTI 7 configuration bits
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 external interrupt configuration register 3
    pub const SYSCFG_EXTICR3 = mmio(Address + 0x00000010, 32, packed struct {
        EXTI8: u4, // bit offset: 0 desc: EXTI 8 configuration bits
        EXTI9: u4, // bit offset: 4 desc: EXTI 9 configuration bits
        EXTI10: u4, // bit offset: 8 desc: EXTI 10 configuration bits
        EXTI11: u4, // bit offset: 12 desc: EXTI 11 configuration bits
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 external interrupt configuration register 4
    pub const SYSCFG_EXTICR4 = mmio(Address + 0x00000014, 32, packed struct {
        EXTI12: u4, // bit offset: 0 desc: EXTI 12 configuration bits
        EXTI13: u4, // bit offset: 4 desc: EXTI 13 configuration bits
        EXTI14: u4, // bit offset: 8 desc: EXTI 14 configuration bits
        EXTI15: u4, // bit offset: 12 desc: EXTI 15 configuration bits
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 configuration register 2
    pub const SYSCFG_CFGR2 = mmio(Address + 0x00000018, 32, packed struct {
        LOCUP_LOCK: u1, // bit offset: 0 desc: Cortex-M0 LOCKUP bit enable bit
        SRAM_PARITY_LOCK: u1, // bit offset: 1 desc: SRAM parity lock bit
        PVD_LOCK: u1, // bit offset: 2 desc: PVD lock enable bit
        reserved1: u1 = 0,
        BYP_ADD_PAR: u1, // bit offset: 4 desc: Bypass address bit 29 in parity calculation
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        SRAM_PEF: u1, // bit offset: 8 desc: SRAM parity flag
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
    // byte offset: 28 control and status register
    pub const COMP1_CSR = mmio(Address + 0x0000001c, 32, packed struct {
        COMP1EN: u1, // bit offset: 0 desc: Comparator 1 enable
        COMP1_INP_DAC: u1, // bit offset: 1 desc: COMP1_INP_DAC
        COMP1MODE: u2, // bit offset: 2 desc: Comparator 1 mode
        COMP1INSEL: u3, // bit offset: 4 desc: Comparator 1 inverting input selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        COMP1_OUT_SEL: u4, // bit offset: 10 desc: Comparator 1 output selection
        reserved4: u1 = 0,
        COMP1POL: u1, // bit offset: 15 desc: Comparator 1 output polarity
        COMP1HYST: u2, // bit offset: 16 desc: Comparator 1 hysteresis
        COMP1_BLANKING: u3, // bit offset: 18 desc: Comparator 1 blanking source
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        COMP1OUT: u1, // bit offset: 30 desc: Comparator 1 output
        COMP1LOCK: u1, // bit offset: 31 desc: Comparator 1 lock
    });
    // byte offset: 32 control and status register
    pub const COMP2_CSR = mmio(Address + 0x00000020, 32, packed struct {
        COMP2EN: u1, // bit offset: 0 desc: Comparator 2 enable
        reserved1: u1 = 0,
        COMP2MODE: u2, // bit offset: 2 desc: Comparator 2 mode
        COMP2INSEL: u3, // bit offset: 4 desc: Comparator 2 inverting input selection
        COMP2INPSEL: u1, // bit offset: 7 desc: Comparator 2 non inverted input selection
        reserved2: u1 = 0,
        COMP2INMSEL: u1, // bit offset: 9 desc: Comparator 1inverting input selection
        COMP2_OUT_SEL: u4, // bit offset: 10 desc: Comparator 2 output selection
        reserved3: u1 = 0,
        COMP2POL: u1, // bit offset: 15 desc: Comparator 2 output polarity
        COMP2HYST: u2, // bit offset: 16 desc: Comparator 2 hysteresis
        COMP2_BLANKING: u3, // bit offset: 18 desc: Comparator 2 blanking source
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
        COMP2LOCK: u1, // bit offset: 31 desc: Comparator 2 lock
    });
    // byte offset: 36 control and status register
    pub const COMP3_CSR = mmio(Address + 0x00000024, 32, packed struct {
        COMP3EN: u1, // bit offset: 0 desc: Comparator 3 enable
        reserved1: u1 = 0,
        COMP3MODE: u2, // bit offset: 2 desc: Comparator 3 mode
        COMP3INSEL: u3, // bit offset: 4 desc: Comparator 3 inverting input selection
        COMP3INPSEL: u1, // bit offset: 7 desc: Comparator 3 non inverted input selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        COMP3_OUT_SEL: u4, // bit offset: 10 desc: Comparator 3 output selection
        reserved4: u1 = 0,
        COMP3POL: u1, // bit offset: 15 desc: Comparator 3 output polarity
        COMP3HYST: u2, // bit offset: 16 desc: Comparator 3 hysteresis
        COMP3_BLANKING: u3, // bit offset: 18 desc: Comparator 3 blanking source
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        COMP3OUT: u1, // bit offset: 30 desc: Comparator 3 output
        COMP3LOCK: u1, // bit offset: 31 desc: Comparator 3 lock
    });
    // byte offset: 40 control and status register
    pub const COMP4_CSR = mmio(Address + 0x00000028, 32, packed struct {
        COMP4EN: u1, // bit offset: 0 desc: Comparator 4 enable
        reserved1: u1 = 0,
        COMP4MODE: u2, // bit offset: 2 desc: Comparator 4 mode
        COMP4INSEL: u3, // bit offset: 4 desc: Comparator 4 inverting input selection
        COMP4INPSEL: u1, // bit offset: 7 desc: Comparator 4 non inverted input selection
        reserved2: u1 = 0,
        COM4WINMODE: u1, // bit offset: 9 desc: Comparator 4 window mode
        COMP4_OUT_SEL: u4, // bit offset: 10 desc: Comparator 4 output selection
        reserved3: u1 = 0,
        COMP4POL: u1, // bit offset: 15 desc: Comparator 4 output polarity
        COMP4HYST: u2, // bit offset: 16 desc: Comparator 4 hysteresis
        COMP4_BLANKING: u3, // bit offset: 18 desc: Comparator 4 blanking source
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        COMP4OUT: u1, // bit offset: 30 desc: Comparator 4 output
        COMP4LOCK: u1, // bit offset: 31 desc: Comparator 4 lock
    });
    // byte offset: 44 control and status register
    pub const COMP5_CSR = mmio(Address + 0x0000002c, 32, packed struct {
        COMP5EN: u1, // bit offset: 0 desc: Comparator 5 enable
        reserved1: u1 = 0,
        COMP5MODE: u2, // bit offset: 2 desc: Comparator 5 mode
        COMP5INSEL: u3, // bit offset: 4 desc: Comparator 5 inverting input selection
        COMP5INPSEL: u1, // bit offset: 7 desc: Comparator 5 non inverted input selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        COMP5_OUT_SEL: u4, // bit offset: 10 desc: Comparator 5 output selection
        reserved4: u1 = 0,
        COMP5POL: u1, // bit offset: 15 desc: Comparator 5 output polarity
        COMP5HYST: u2, // bit offset: 16 desc: Comparator 5 hysteresis
        COMP5_BLANKING: u3, // bit offset: 18 desc: Comparator 5 blanking source
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        COMP5OUT: u1, // bit offset: 30 desc: Comparator51 output
        COMP5LOCK: u1, // bit offset: 31 desc: Comparator 5 lock
    });
    // byte offset: 48 control and status register
    pub const COMP6_CSR = mmio(Address + 0x00000030, 32, packed struct {
        COMP6EN: u1, // bit offset: 0 desc: Comparator 6 enable
        reserved1: u1 = 0,
        COMP6MODE: u2, // bit offset: 2 desc: Comparator 6 mode
        COMP6INSEL: u3, // bit offset: 4 desc: Comparator 6 inverting input selection
        COMP6INPSEL: u1, // bit offset: 7 desc: Comparator 6 non inverted input selection
        reserved2: u1 = 0,
        COM6WINMODE: u1, // bit offset: 9 desc: Comparator 6 window mode
        COMP6_OUT_SEL: u4, // bit offset: 10 desc: Comparator 6 output selection
        reserved3: u1 = 0,
        COMP6POL: u1, // bit offset: 15 desc: Comparator 6 output polarity
        COMP6HYST: u2, // bit offset: 16 desc: Comparator 6 hysteresis
        COMP6_BLANKING: u3, // bit offset: 18 desc: Comparator 6 blanking source
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        COMP6OUT: u1, // bit offset: 30 desc: Comparator 6 output
        COMP6LOCK: u1, // bit offset: 31 desc: Comparator 6 lock
    });
    // byte offset: 52 control and status register
    pub const COMP7_CSR = mmio(Address + 0x00000034, 32, packed struct {
        COMP7EN: u1, // bit offset: 0 desc: Comparator 7 enable
        reserved1: u1 = 0,
        COMP7MODE: u2, // bit offset: 2 desc: Comparator 7 mode
        COMP7INSEL: u3, // bit offset: 4 desc: Comparator 7 inverting input selection
        COMP7INPSEL: u1, // bit offset: 7 desc: Comparator 7 non inverted input selection
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        COMP7_OUT_SEL: u4, // bit offset: 10 desc: Comparator 7 output selection
        reserved4: u1 = 0,
        COMP7POL: u1, // bit offset: 15 desc: Comparator 7 output polarity
        COMP7HYST: u2, // bit offset: 16 desc: Comparator 7 hysteresis
        COMP7_BLANKING: u3, // bit offset: 18 desc: Comparator 7 blanking source
        reserved13: u1 = 0,
        reserved12: u1 = 0,
        reserved11: u1 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        COMP7OUT: u1, // bit offset: 30 desc: Comparator 7 output
        COMP7LOCK: u1, // bit offset: 31 desc: Comparator 7 lock
    });
    // byte offset: 56 control register
    pub const OPAMP1_CSR = mmio(Address + 0x00000038, 32, packed struct {
        OPAMP1_EN: u1, // bit offset: 0 desc: OPAMP1 enable
        FORCE_VP: u1, // bit offset: 1 desc: FORCE_VP
        VP_SEL: u2, // bit offset: 2 desc: OPAMP1 Non inverting input selection
        reserved1: u1 = 0,
        VM_SEL: u2, // bit offset: 5 desc: OPAMP1 inverting input selection
        TCM_EN: u1, // bit offset: 7 desc: Timer controlled Mux mode enable
        VMS_SEL: u1, // bit offset: 8 desc: OPAMP1 inverting input secondary selection
        VPS_SEL: u2, // bit offset: 9 desc: OPAMP1 Non inverting input secondary selection
        CALON: u1, // bit offset: 11 desc: Calibration mode enable
        CALSEL: u2, // bit offset: 12 desc: Calibration selection
        PGA_GAIN: u4, // bit offset: 14 desc: Gain in PGA mode
        USER_TRIM: u1, // bit offset: 18 desc: User trimming enable
        TRIMOFFSETP: u5, // bit offset: 19 desc: Offset trimming value (PMOS)
        TRIMOFFSETN: u5, // bit offset: 24 desc: Offset trimming value (NMOS)
        TSTREF: u1, // bit offset: 29 desc: TSTREF
        OUTCAL: u1, // bit offset: 30 desc: OPAMP 1 ouput status flag
        LOCK: u1, // bit offset: 31 desc: OPAMP 1 lock
    });
    // byte offset: 60 control register
    pub const OPAMP2_CSR = mmio(Address + 0x0000003c, 32, packed struct {
        OPAMP2EN: u1, // bit offset: 0 desc: OPAMP2 enable
        FORCE_VP: u1, // bit offset: 1 desc: FORCE_VP
        VP_SEL: u2, // bit offset: 2 desc: OPAMP2 Non inverting input selection
        reserved1: u1 = 0,
        VM_SEL: u2, // bit offset: 5 desc: OPAMP2 inverting input selection
        TCM_EN: u1, // bit offset: 7 desc: Timer controlled Mux mode enable
        VMS_SEL: u1, // bit offset: 8 desc: OPAMP2 inverting input secondary selection
        VPS_SEL: u2, // bit offset: 9 desc: OPAMP2 Non inverting input secondary selection
        CALON: u1, // bit offset: 11 desc: Calibration mode enable
        CAL_SEL: u2, // bit offset: 12 desc: Calibration selection
        PGA_GAIN: u4, // bit offset: 14 desc: Gain in PGA mode
        USER_TRIM: u1, // bit offset: 18 desc: User trimming enable
        TRIMOFFSETP: u5, // bit offset: 19 desc: Offset trimming value (PMOS)
        TRIMOFFSETN: u5, // bit offset: 24 desc: Offset trimming value (NMOS)
        TSTREF: u1, // bit offset: 29 desc: TSTREF
        OUTCAL: u1, // bit offset: 30 desc: OPAMP 2 ouput status flag
        LOCK: u1, // bit offset: 31 desc: OPAMP 2 lock
    });
    // byte offset: 64 control register
    pub const OPAMP3_CSR = mmio(Address + 0x00000040, 32, packed struct {
        OPAMP3EN: u1, // bit offset: 0 desc: OPAMP3 enable
        FORCE_VP: u1, // bit offset: 1 desc: FORCE_VP
        VP_SEL: u2, // bit offset: 2 desc: OPAMP3 Non inverting input selection
        reserved1: u1 = 0,
        VM_SEL: u2, // bit offset: 5 desc: OPAMP3 inverting input selection
        TCM_EN: u1, // bit offset: 7 desc: Timer controlled Mux mode enable
        VMS_SEL: u1, // bit offset: 8 desc: OPAMP3 inverting input secondary selection
        VPS_SEL: u2, // bit offset: 9 desc: OPAMP3 Non inverting input secondary selection
        CALON: u1, // bit offset: 11 desc: Calibration mode enable
        CALSEL: u2, // bit offset: 12 desc: Calibration selection
        PGA_GAIN: u4, // bit offset: 14 desc: Gain in PGA mode
        USER_TRIM: u1, // bit offset: 18 desc: User trimming enable
        TRIMOFFSETP: u5, // bit offset: 19 desc: Offset trimming value (PMOS)
        TRIMOFFSETN: u5, // bit offset: 24 desc: Offset trimming value (NMOS)
        TSTREF: u1, // bit offset: 29 desc: TSTREF
        OUTCAL: u1, // bit offset: 30 desc: OPAMP 3 ouput status flag
        LOCK: u1, // bit offset: 31 desc: OPAMP 3 lock
    });
    // byte offset: 68 control register
    pub const OPAMP4_CSR = mmio(Address + 0x00000044, 32, packed struct {
        OPAMP4EN: u1, // bit offset: 0 desc: OPAMP4 enable
        FORCE_VP: u1, // bit offset: 1 desc: FORCE_VP
        VP_SEL: u2, // bit offset: 2 desc: OPAMP4 Non inverting input selection
        reserved1: u1 = 0,
        VM_SEL: u2, // bit offset: 5 desc: OPAMP4 inverting input selection
        TCM_EN: u1, // bit offset: 7 desc: Timer controlled Mux mode enable
        VMS_SEL: u1, // bit offset: 8 desc: OPAMP4 inverting input secondary selection
        VPS_SEL: u2, // bit offset: 9 desc: OPAMP4 Non inverting input secondary selection
        CALON: u1, // bit offset: 11 desc: Calibration mode enable
        CALSEL: u2, // bit offset: 12 desc: Calibration selection
        PGA_GAIN: u4, // bit offset: 14 desc: Gain in PGA mode
        USER_TRIM: u1, // bit offset: 18 desc: User trimming enable
        TRIMOFFSETP: u5, // bit offset: 19 desc: Offset trimming value (PMOS)
        TRIMOFFSETN: u5, // bit offset: 24 desc: Offset trimming value (NMOS)
        TSTREF: u1, // bit offset: 29 desc: TSTREF
        OUTCAL: u1, // bit offset: 30 desc: OPAMP 4 ouput status flag
        LOCK: u1, // bit offset: 31 desc: OPAMP 4 lock
    });
};
pub const FMC = extern struct {
    pub const Address: u32 = 0xa0000400;
    // byte offset: 0 SRAM/NOR-Flash chip-select control register 1
    pub const BCR1 = mmio(Address + 0x00000000, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        reserved2: u1 = 0,
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        CCLKEN: u1, // bit offset: 20 desc: CCLKEN
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 SRAM/NOR-Flash chip-select timing register 1
    pub const BTR1 = mmio(Address + 0x00000004, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 SRAM/NOR-Flash chip-select control register 2
    pub const BCR2 = mmio(Address + 0x00000008, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 SRAM/NOR-Flash chip-select timing register 2
    pub const BTR2 = mmio(Address + 0x0000000c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 16 SRAM/NOR-Flash chip-select control register 3
    pub const BCR3 = mmio(Address + 0x00000010, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 20 SRAM/NOR-Flash chip-select timing register 3
    pub const BTR3 = mmio(Address + 0x00000014, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 24 SRAM/NOR-Flash chip-select control register 4
    pub const BCR4 = mmio(Address + 0x00000018, 32, packed struct {
        MBKEN: u1, // bit offset: 0 desc: MBKEN
        MUXEN: u1, // bit offset: 1 desc: MUXEN
        MTYP: u2, // bit offset: 2 desc: MTYP
        MWID: u2, // bit offset: 4 desc: MWID
        FACCEN: u1, // bit offset: 6 desc: FACCEN
        reserved1: u1 = 0,
        BURSTEN: u1, // bit offset: 8 desc: BURSTEN
        WAITPOL: u1, // bit offset: 9 desc: WAITPOL
        WRAPMOD: u1, // bit offset: 10 desc: WRAPMOD
        WAITCFG: u1, // bit offset: 11 desc: WAITCFG
        WREN: u1, // bit offset: 12 desc: WREN
        WAITEN: u1, // bit offset: 13 desc: WAITEN
        EXTMOD: u1, // bit offset: 14 desc: EXTMOD
        ASYNCWAIT: u1, // bit offset: 15 desc: ASYNCWAIT
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        CBURSTRW: u1, // bit offset: 19 desc: CBURSTRW
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 SRAM/NOR-Flash chip-select timing register 4
    pub const BTR4 = mmio(Address + 0x0000001c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: BUSTURN
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 96 PC Card/NAND Flash control register 2
    pub const PCR2 = mmio(Address + 0x00000060, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 100 FIFO status and interrupt register 2
    pub const SR2 = mmio(Address + 0x00000064, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
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
    // byte offset: 104 Common memory space timing register 2
    pub const PMEM2 = mmio(Address + 0x00000068, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 108 Attribute memory space timing register 2
    pub const PATT2 = mmio(Address + 0x0000006c, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: ATTSETx
        ATTWAITx: u8, // bit offset: 8 desc: ATTWAITx
        ATTHOLDx: u8, // bit offset: 16 desc: ATTHOLDx
        ATTHIZx: u8, // bit offset: 24 desc: ATTHIZx
    });
    // byte offset: 116 ECC result register 2
    pub const ECCR2 = mmio(Address + 0x00000074, 32, packed struct {
        ECCx: u32, // bit offset: 0 desc: ECCx
    });
    // byte offset: 128 PC Card/NAND Flash control register 3
    pub const PCR3 = mmio(Address + 0x00000080, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 132 FIFO status and interrupt register 3
    pub const SR3 = mmio(Address + 0x00000084, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
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
    // byte offset: 136 Common memory space timing register 3
    pub const PMEM3 = mmio(Address + 0x00000088, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 140 Attribute memory space timing register 3
    pub const PATT3 = mmio(Address + 0x0000008c, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: ATTSETx
        ATTWAITx: u8, // bit offset: 8 desc: ATTWAITx
        ATTHOLDx: u8, // bit offset: 16 desc: ATTHOLDx
        ATTHIZx: u8, // bit offset: 24 desc: ATTHIZx
    });
    // byte offset: 148 ECC result register 3
    pub const ECCR3 = mmio(Address + 0x00000094, 32, packed struct {
        ECCx: u32, // bit offset: 0 desc: ECCx
    });
    // byte offset: 160 PC Card/NAND Flash control register 4
    pub const PCR4 = mmio(Address + 0x000000a0, 32, packed struct {
        reserved1: u1 = 0,
        PWAITEN: u1, // bit offset: 1 desc: PWAITEN
        PBKEN: u1, // bit offset: 2 desc: PBKEN
        PTYP: u1, // bit offset: 3 desc: PTYP
        PWID: u2, // bit offset: 4 desc: PWID
        ECCEN: u1, // bit offset: 6 desc: ECCEN
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        TCLR: u4, // bit offset: 9 desc: TCLR
        TAR: u4, // bit offset: 13 desc: TAR
        ECCPS: u3, // bit offset: 17 desc: ECCPS
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 164 FIFO status and interrupt register 4
    pub const SR4 = mmio(Address + 0x000000a4, 32, packed struct {
        IRS: u1, // bit offset: 0 desc: IRS
        ILS: u1, // bit offset: 1 desc: ILS
        IFS: u1, // bit offset: 2 desc: IFS
        IREN: u1, // bit offset: 3 desc: IREN
        ILEN: u1, // bit offset: 4 desc: ILEN
        IFEN: u1, // bit offset: 5 desc: IFEN
        FEMPT: u1, // bit offset: 6 desc: FEMPT
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
    // byte offset: 168 Common memory space timing register 4
    pub const PMEM4 = mmio(Address + 0x000000a8, 32, packed struct {
        MEMSETx: u8, // bit offset: 0 desc: MEMSETx
        MEMWAITx: u8, // bit offset: 8 desc: MEMWAITx
        MEMHOLDx: u8, // bit offset: 16 desc: MEMHOLDx
        MEMHIZx: u8, // bit offset: 24 desc: MEMHIZx
    });
    // byte offset: 172 Attribute memory space timing register 4
    pub const PATT4 = mmio(Address + 0x000000ac, 32, packed struct {
        ATTSETx: u8, // bit offset: 0 desc: ATTSETx
        ATTWAITx: u8, // bit offset: 8 desc: ATTWAITx
        ATTHOLDx: u8, // bit offset: 16 desc: ATTHOLDx
        ATTHIZx: u8, // bit offset: 24 desc: ATTHIZx
    });
    // byte offset: 176 I/O space timing register 4
    pub const PIO4 = mmio(Address + 0x000000b0, 32, packed struct {
        IOSETx: u8, // bit offset: 0 desc: IOSETx
        IOWAITx: u8, // bit offset: 8 desc: IOWAITx
        IOHOLDx: u8, // bit offset: 16 desc: IOHOLDx
        IOHIZx: u8, // bit offset: 24 desc: IOHIZx
    });
    // byte offset: 260 SRAM/NOR-Flash write timing registers 1
    pub const BWTR1 = mmio(Address + 0x00000104, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: Bus turnaround phase duration
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 268 SRAM/NOR-Flash write timing registers 2
    pub const BWTR2 = mmio(Address + 0x0000010c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: Bus turnaround phase duration
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 276 SRAM/NOR-Flash write timing registers 3
    pub const BWTR3 = mmio(Address + 0x00000114, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: Bus turnaround phase duration
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 284 SRAM/NOR-Flash write timing registers 4
    pub const BWTR4 = mmio(Address + 0x0000011c, 32, packed struct {
        ADDSET: u4, // bit offset: 0 desc: ADDSET
        ADDHLD: u4, // bit offset: 4 desc: ADDHLD
        DATAST: u8, // bit offset: 8 desc: DATAST
        BUSTURN: u4, // bit offset: 16 desc: Bus turnaround phase duration
        CLKDIV: u4, // bit offset: 20 desc: CLKDIV
        DATLAT: u4, // bit offset: 24 desc: DATLAT
        ACCMOD: u2, // bit offset: 28 desc: ACCMOD
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const NVIC = extern struct {
    pub const Address: u32 = 0xe000e100;
    // byte offset: 0 Interrupt Set-Enable Register
    pub const ISER0 = mmio(Address + 0x00000000, 32, packed struct {
        SETENA: u32, // bit offset: 0 desc: SETENA
    });
    // byte offset: 4 Interrupt Set-Enable Register
    pub const ISER1 = mmio(Address + 0x00000004, 32, packed struct {
        SETENA: u32, // bit offset: 0 desc: SETENA
    });
    // byte offset: 8 Interrupt Set-Enable Register
    pub const ISER2 = mmio(Address + 0x00000008, 32, packed struct {
        SETENA: u32, // bit offset: 0 desc: SETENA
    });
    // byte offset: 128 Interrupt Clear-Enable Register
    pub const ICER0 = mmio(Address + 0x00000080, 32, packed struct {
        CLRENA: u32, // bit offset: 0 desc: CLRENA
    });
    // byte offset: 132 Interrupt Clear-Enable Register
    pub const ICER1 = mmio(Address + 0x00000084, 32, packed struct {
        CLRENA: u32, // bit offset: 0 desc: CLRENA
    });
    // byte offset: 136 Interrupt Clear-Enable Register
    pub const ICER2 = mmio(Address + 0x00000088, 32, packed struct {
        CLRENA: u32, // bit offset: 0 desc: CLRENA
    });
    // byte offset: 256 Interrupt Set-Pending Register
    pub const ISPR0 = mmio(Address + 0x00000100, 32, packed struct {
        SETPEND: u32, // bit offset: 0 desc: SETPEND
    });
    // byte offset: 260 Interrupt Set-Pending Register
    pub const ISPR1 = mmio(Address + 0x00000104, 32, packed struct {
        SETPEND: u32, // bit offset: 0 desc: SETPEND
    });
    // byte offset: 264 Interrupt Set-Pending Register
    pub const ISPR2 = mmio(Address + 0x00000108, 32, packed struct {
        SETPEND: u32, // bit offset: 0 desc: SETPEND
    });
    // byte offset: 384 Interrupt Clear-Pending Register
    pub const ICPR0 = mmio(Address + 0x00000180, 32, packed struct {
        CLRPEND: u32, // bit offset: 0 desc: CLRPEND
    });
    // byte offset: 388 Interrupt Clear-Pending Register
    pub const ICPR1 = mmio(Address + 0x00000184, 32, packed struct {
        CLRPEND: u32, // bit offset: 0 desc: CLRPEND
    });
    // byte offset: 392 Interrupt Clear-Pending Register
    pub const ICPR2 = mmio(Address + 0x00000188, 32, packed struct {
        CLRPEND: u32, // bit offset: 0 desc: CLRPEND
    });
    // byte offset: 512 Interrupt Active Bit Register
    pub const IABR0 = mmio(Address + 0x00000200, 32, packed struct {
        ACTIVE: u32, // bit offset: 0 desc: ACTIVE
    });
    // byte offset: 516 Interrupt Active Bit Register
    pub const IABR1 = mmio(Address + 0x00000204, 32, packed struct {
        ACTIVE: u32, // bit offset: 0 desc: ACTIVE
    });
    // byte offset: 520 Interrupt Active Bit Register
    pub const IABR2 = mmio(Address + 0x00000208, 32, packed struct {
        ACTIVE: u32, // bit offset: 0 desc: ACTIVE
    });
    // byte offset: 768 Interrupt Priority Register
    pub const IPR0 = mmio(Address + 0x00000300, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 772 Interrupt Priority Register
    pub const IPR1 = mmio(Address + 0x00000304, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 776 Interrupt Priority Register
    pub const IPR2 = mmio(Address + 0x00000308, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 780 Interrupt Priority Register
    pub const IPR3 = mmio(Address + 0x0000030c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 784 Interrupt Priority Register
    pub const IPR4 = mmio(Address + 0x00000310, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 788 Interrupt Priority Register
    pub const IPR5 = mmio(Address + 0x00000314, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 792 Interrupt Priority Register
    pub const IPR6 = mmio(Address + 0x00000318, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 796 Interrupt Priority Register
    pub const IPR7 = mmio(Address + 0x0000031c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 800 Interrupt Priority Register
    pub const IPR8 = mmio(Address + 0x00000320, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 804 Interrupt Priority Register
    pub const IPR9 = mmio(Address + 0x00000324, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 808 Interrupt Priority Register
    pub const IPR10 = mmio(Address + 0x00000328, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 812 Interrupt Priority Register
    pub const IPR11 = mmio(Address + 0x0000032c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 816 Interrupt Priority Register
    pub const IPR12 = mmio(Address + 0x00000330, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 820 Interrupt Priority Register
    pub const IPR13 = mmio(Address + 0x00000334, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 824 Interrupt Priority Register
    pub const IPR14 = mmio(Address + 0x00000338, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 828 Interrupt Priority Register
    pub const IPR15 = mmio(Address + 0x0000033c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 832 Interrupt Priority Register
    pub const IPR16 = mmio(Address + 0x00000340, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 836 Interrupt Priority Register
    pub const IPR17 = mmio(Address + 0x00000344, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 840 Interrupt Priority Register
    pub const IPR18 = mmio(Address + 0x00000348, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 844 Interrupt Priority Register
    pub const IPR19 = mmio(Address + 0x0000034c, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
    // byte offset: 848 Interrupt Priority Register
    pub const IPR20 = mmio(Address + 0x00000350, 32, packed struct {
        IPR_N0: u8, // bit offset: 0 desc: IPR_N0
        IPR_N1: u8, // bit offset: 8 desc: IPR_N1
        IPR_N2: u8, // bit offset: 16 desc: IPR_N2
        IPR_N3: u8, // bit offset: 24 desc: IPR_N3
    });
};
pub const FPU = extern struct {
    pub const Address: u32 = 0xe000ef34;
    // byte offset: 0 Floating-point context control register
    pub const FPCCR = mmio(Address + 0x00000000, 32, packed struct {
        LSPACT: u1, // bit offset: 0 desc: LSPACT
        USER: u1, // bit offset: 1 desc: USER
        reserved1: u1 = 0,
        THREAD: u1, // bit offset: 3 desc: THREAD
        HFRDY: u1, // bit offset: 4 desc: HFRDY
        MMRDY: u1, // bit offset: 5 desc: MMRDY
        BFRDY: u1, // bit offset: 6 desc: BFRDY
        reserved2: u1 = 0,
        MONRDY: u1, // bit offset: 8 desc: MONRDY
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
        LSPEN: u1, // bit offset: 30 desc: LSPEN
        ASPEN: u1, // bit offset: 31 desc: ASPEN
    });
    // byte offset: 4 Floating-point context address register
    pub const FPCAR = mmio(Address + 0x00000004, 32, packed struct {
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        ADDRESS: u29, // bit offset: 3 desc: Location of unpopulated floating-point
    });
    // byte offset: 8 Floating-point status control register
    pub const FPSCR = mmio(Address + 0x00000008, 32, packed struct {
        IOC: u1, // bit offset: 0 desc: Invalid operation cumulative exception bit
        DZC: u1, // bit offset: 1 desc: Division by zero cumulative exception bit.
        OFC: u1, // bit offset: 2 desc: Overflow cumulative exception bit
        UFC: u1, // bit offset: 3 desc: Underflow cumulative exception bit
        IXC: u1, // bit offset: 4 desc: Inexact cumulative exception bit
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        IDC: u1, // bit offset: 7 desc: Input denormal cumulative exception bit.
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
        RMode: u2, // bit offset: 22 desc: Rounding Mode control field
        FZ: u1, // bit offset: 24 desc: Flush-to-zero mode control bit:
        DN: u1, // bit offset: 25 desc: Default NaN mode control bit
        AHP: u1, // bit offset: 26 desc: Alternative half-precision control bit
        reserved17: u1 = 0,
        V: u1, // bit offset: 28 desc: Overflow condition code flag
        C: u1, // bit offset: 29 desc: Carry condition code flag
        Z: u1, // bit offset: 30 desc: Zero condition code flag
        N: u1, // bit offset: 31 desc: Negative condition code flag
    });
};
pub const MPU = extern struct {
    pub const Address: u32 = 0xe000ed90;
    // byte offset: 0 MPU type register
    pub const MPU_TYPER = mmio(Address + 0x00000000, 32, packed struct {
        SEPARATE: u1, // bit offset: 0 desc: Separate flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DREGION: u8, // bit offset: 8 desc: Number of MPU data regions
        IREGION: u8, // bit offset: 16 desc: Number of MPU instruction regions
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 MPU control register
    pub const MPU_CTRL = mmio(Address + 0x00000004, 32, packed struct {
        ENABLE: u1, // bit offset: 0 desc: Enables the MPU
        HFNMIENA: u1, // bit offset: 1 desc: Enables the operation of MPU during hard fault
        PRIVDEFENA: u1, // bit offset: 2 desc: Enable priviliged software access to default memory map
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
    // byte offset: 8 MPU region number register
    pub const MPU_RNR = mmio(Address + 0x00000008, 32, packed struct {
        REGION: u8, // bit offset: 0 desc: MPU region
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
    // byte offset: 12 MPU region base address register
    pub const MPU_RBAR = mmio(Address + 0x0000000c, 32, packed struct {
        REGION: u4, // bit offset: 0 desc: MPU region field
        VALID: u1, // bit offset: 4 desc: MPU region number valid
        ADDR: u27, // bit offset: 5 desc: Region base address field
    });
    // byte offset: 16 MPU region attribute and size register
    pub const MPU_RASR = mmio(Address + 0x00000010, 32, packed struct {
        ENABLE: u1, // bit offset: 0 desc: Region enable bit.
        SIZE: u5, // bit offset: 1 desc: Size of the MPU protection region
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SRD: u8, // bit offset: 8 desc: Subregion disable bits
        B: u1, // bit offset: 16 desc: memory attribute
        C: u1, // bit offset: 17 desc: memory attribute
        S: u1, // bit offset: 18 desc: Shareable memory attribute
        TEX: u3, // bit offset: 19 desc: memory attribute
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        AP: u3, // bit offset: 24 desc: Access permission
        reserved5: u1 = 0,
        XN: u1, // bit offset: 28 desc: Instruction access disable bit
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};
pub const STK = extern struct {
    pub const Address: u32 = 0xe000e010;
    // byte offset: 0 SysTick control and status register
    pub const CTRL = mmio(Address + 0x00000000, 32, packed struct {
        ENABLE: u1, // bit offset: 0 desc: Counter enable
        TICKINT: u1, // bit offset: 1 desc: SysTick exception request enable
        CLKSOURCE: u1, // bit offset: 2 desc: Clock source selection
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
        COUNTFLAG: u1, // bit offset: 16 desc: COUNTFLAG
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 4 SysTick reload value register
    pub const LOAD = mmio(Address + 0x00000004, 32, packed struct {
        RELOAD: u24, // bit offset: 0 desc: RELOAD value
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 8 SysTick current value register
    pub const VAL = mmio(Address + 0x00000008, 32, packed struct {
        CURRENT: u24, // bit offset: 0 desc: Current counter value
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 SysTick calibration value register
    pub const CALIB = mmio(Address + 0x0000000c, 32, packed struct {
        TENMS: u24, // bit offset: 0 desc: Calibration value
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        SKEW: u1, // bit offset: 30 desc: SKEW flag: Indicates whether the TENMS value is exact
        NOREF: u1, // bit offset: 31 desc: NOREF flag. Reads as zero
    });
};
pub const SCB = extern struct {
    pub const Address: u32 = 0xe000ed00;
    // byte offset: 0 CPUID base register
    pub const CPUID = mmio(Address + 0x00000000, 32, packed struct {
        Revision: u4, // bit offset: 0 desc: Revision number
        PartNo: u12, // bit offset: 4 desc: Part number of the processor
        Constant: u4, // bit offset: 16 desc: Reads as 0xF
        Variant: u4, // bit offset: 20 desc: Variant number
        Implementer: u8, // bit offset: 24 desc: Implementer code
    });
    // byte offset: 4 Interrupt control and state register
    pub const ICSR = mmio(Address + 0x00000004, 32, packed struct {
        VECTACTIVE: u9, // bit offset: 0 desc: Active vector
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        RETTOBASE: u1, // bit offset: 11 desc: Return to base level
        VECTPENDING: u7, // bit offset: 12 desc: Pending vector
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        ISRPENDING: u1, // bit offset: 22 desc: Interrupt pending flag
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        PENDSTCLR: u1, // bit offset: 25 desc: SysTick exception clear-pending bit
        PENDSTSET: u1, // bit offset: 26 desc: SysTick exception set-pending bit
        PENDSVCLR: u1, // bit offset: 27 desc: PendSV clear-pending bit
        PENDSVSET: u1, // bit offset: 28 desc: PendSV set-pending bit
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        NMIPENDSET: u1, // bit offset: 31 desc: NMI set-pending bit.
    });
    // byte offset: 8 Vector table offset register
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
        TBLOFF: u21, // bit offset: 9 desc: Vector table base offset field
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 12 Application interrupt and reset control register
    pub const AIRCR = mmio(Address + 0x0000000c, 32, packed struct {
        VECTRESET: u1, // bit offset: 0 desc: VECTRESET
        VECTCLRACTIVE: u1, // bit offset: 1 desc: VECTCLRACTIVE
        SYSRESETREQ: u1, // bit offset: 2 desc: SYSRESETREQ
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        PRIGROUP: u3, // bit offset: 8 desc: PRIGROUP
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        ENDIANESS: u1, // bit offset: 15 desc: ENDIANESS
        VECTKEYSTAT: u16, // bit offset: 16 desc: Register key
    });
    // byte offset: 16 System control register
    pub const SCR = mmio(Address + 0x00000010, 32, packed struct {
        reserved1: u1 = 0,
        SLEEPONEXIT: u1, // bit offset: 1 desc: SLEEPONEXIT
        SLEEPDEEP: u1, // bit offset: 2 desc: SLEEPDEEP
        reserved2: u1 = 0,
        SEVEONPEND: u1, // bit offset: 4 desc: Send Event on Pending bit
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
    // byte offset: 20 Configuration and control register
    pub const CCR = mmio(Address + 0x00000014, 32, packed struct {
        NONBASETHRDENA: u1, // bit offset: 0 desc: Configures how the processor enters Thread mode
        USERSETMPEND: u1, // bit offset: 1 desc: USERSETMPEND
        reserved1: u1 = 0,
        UNALIGN__TRP: u1, // bit offset: 3 desc: UNALIGN_ TRP
        DIV_0_TRP: u1, // bit offset: 4 desc: DIV_0_TRP
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        BFHFNMIGN: u1, // bit offset: 8 desc: BFHFNMIGN
        STKALIGN: u1, // bit offset: 9 desc: STKALIGN
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
    // byte offset: 24 System handler priority registers
    pub const SHPR1 = mmio(Address + 0x00000018, 32, packed struct {
        PRI_4: u8, // bit offset: 0 desc: Priority of system handler 4
        PRI_5: u8, // bit offset: 8 desc: Priority of system handler 5
        PRI_6: u8, // bit offset: 16 desc: Priority of system handler 6
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 28 System handler priority registers
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
        PRI_11: u8, // bit offset: 24 desc: Priority of system handler 11
    });
    // byte offset: 32 System handler priority registers
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
        PRI_14: u8, // bit offset: 16 desc: Priority of system handler 14
        PRI_15: u8, // bit offset: 24 desc: Priority of system handler 15
    });
    // byte offset: 36 System handler control and state register
    pub const SHCRS = mmio(Address + 0x00000024, 32, packed struct {
        MEMFAULTACT: u1, // bit offset: 0 desc: Memory management fault exception active bit
        BUSFAULTACT: u1, // bit offset: 1 desc: Bus fault exception active bit
        reserved1: u1 = 0,
        USGFAULTACT: u1, // bit offset: 3 desc: Usage fault exception active bit
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        SVCALLACT: u1, // bit offset: 7 desc: SVC call active bit
        MONITORACT: u1, // bit offset: 8 desc: Debug monitor active bit
        reserved5: u1 = 0,
        PENDSVACT: u1, // bit offset: 10 desc: PendSV exception active bit
        SYSTICKACT: u1, // bit offset: 11 desc: SysTick exception active bit
        USGFAULTPENDED: u1, // bit offset: 12 desc: Usage fault exception pending bit
        MEMFAULTPENDED: u1, // bit offset: 13 desc: Memory management fault exception pending bit
        BUSFAULTPENDED: u1, // bit offset: 14 desc: Bus fault exception pending bit
        SVCALLPENDED: u1, // bit offset: 15 desc: SVC call pending bit
        MEMFAULTENA: u1, // bit offset: 16 desc: Memory management fault enable bit
        BUSFAULTENA: u1, // bit offset: 17 desc: Bus fault enable bit
        USGFAULTENA: u1, // bit offset: 18 desc: Usage fault enable bit
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 40 Configurable fault status register
    pub const CFSR_UFSR_BFSR_MMFSR = mmio(Address + 0x00000028, 32, packed struct {
        reserved1: u1 = 0,
        IACCVIOL: u1, // bit offset: 1 desc: Instruction access violation flag
        reserved2: u1 = 0,
        MUNSTKERR: u1, // bit offset: 3 desc: Memory manager fault on unstacking for a return from exception
        MSTKERR: u1, // bit offset: 4 desc: Memory manager fault on stacking for exception entry.
        MLSPERR: u1, // bit offset: 5 desc: MLSPERR
        reserved3: u1 = 0,
        MMARVALID: u1, // bit offset: 7 desc: Memory Management Fault Address Register (MMAR) valid flag
        IBUSERR: u1, // bit offset: 8 desc: Instruction bus error
        PRECISERR: u1, // bit offset: 9 desc: Precise data bus error
        IMPRECISERR: u1, // bit offset: 10 desc: Imprecise data bus error
        UNSTKERR: u1, // bit offset: 11 desc: Bus fault on unstacking for a return from exception
        STKERR: u1, // bit offset: 12 desc: Bus fault on stacking for exception entry
        LSPERR: u1, // bit offset: 13 desc: Bus fault on floating-point lazy state preservation
        reserved4: u1 = 0,
        BFARVALID: u1, // bit offset: 15 desc: Bus Fault Address Register (BFAR) valid flag
        UNDEFINSTR: u1, // bit offset: 16 desc: Undefined instruction usage fault
        INVSTATE: u1, // bit offset: 17 desc: Invalid state usage fault
        INVPC: u1, // bit offset: 18 desc: Invalid PC load usage fault
        NOCP: u1, // bit offset: 19 desc: No coprocessor usage fault.
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        UNALIGNED: u1, // bit offset: 24 desc: Unaligned access usage fault
        DIVBYZERO: u1, // bit offset: 25 desc: Divide by zero usage fault
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
    // byte offset: 44 Hard fault status register
    pub const HFSR = mmio(Address + 0x0000002c, 32, packed struct {
        reserved1: u1 = 0,
        VECTTBL: u1, // bit offset: 1 desc: Vector table hard fault
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
        FORCED: u1, // bit offset: 30 desc: Forced hard fault
        DEBUG_VT: u1, // bit offset: 31 desc: Reserved for Debug use
    });
    // byte offset: 52 Memory management fault address register
    pub const MMFAR = mmio(Address + 0x00000034, 32, packed struct {
        MMFAR: u32, // bit offset: 0 desc: Memory management fault address
    });
    // byte offset: 56 Bus fault address register
    pub const BFAR = mmio(Address + 0x00000038, 32, packed struct {
        BFAR: u32, // bit offset: 0 desc: Bus fault address
    });
    // byte offset: 60 Auxiliary fault status register
    pub const AFSR = mmio(Address + 0x0000003c, 32, packed struct {
        IMPDEF: u32, // bit offset: 0 desc: Implementation defined
    });
};
pub const NVIC_STIR = extern struct {
    pub const Address: u32 = 0xe000ef00;
    // byte offset: 0 Software trigger interrupt register
    pub const STIR = mmio(Address + 0x00000000, 32, packed struct {
        INTID: u9, // bit offset: 0 desc: Software generated interrupt ID
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
pub const FPU_CPACR = extern struct {
    pub const Address: u32 = 0xe000ed88;
    // byte offset: 0 Coprocessor access control register
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
        CP: u4, // bit offset: 20 desc: CP
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
pub const SCB_ACTRL = extern struct {
    pub const Address: u32 = 0xe000e008;
    // byte offset: 0 Auxiliary control register
    pub const ACTRL = mmio(Address + 0x00000000, 32, packed struct {
        DISMCYCINT: u1, // bit offset: 0 desc: DISMCYCINT
        DISDEFWBUF: u1, // bit offset: 1 desc: DISDEFWBUF
        DISFOLD: u1, // bit offset: 2 desc: DISFOLD
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        DISFPCA: u1, // bit offset: 8 desc: DISFPCA
        DISOOFP: u1, // bit offset: 9 desc: DISOOFP
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

    /// COMP1 & COMP2 & COMP3 interrupts combined with EXTI Lines 21, 22 and 29 interrupts
    COMP123: InterruptVector = makeUnhandledHandler("COMP123"),

    /// COMP4 & COMP5 & COMP6 interrupts combined with EXTI Lines 30, 31 and 32 interrupts
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

