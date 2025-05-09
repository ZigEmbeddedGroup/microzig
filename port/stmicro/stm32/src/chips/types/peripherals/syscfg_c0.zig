const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const IR_MOD = enum(u2) {
    /// TIM16
    TIM16 = 0x0,
    /// USART1
    USART1 = 0x1,
    /// USART2
    USART2 = 0x2,
    _,
};

pub const MEM_MODE = enum(u2) {
    /// Main Flash memory mapped at address 0
    MAIN_FLASH = 0x0,
    /// System Flash memory mapped at address 0
    SYSTEM_FLASH = 0x1,
    /// Main Flash memory mapped at address 0 (alternate encoding)
    MAIN_FLASH_ALT = 0x2,
    /// Embedded SRAM mapped at address 0
    SRAM = 0x3,
};

pub const PINMUX0 = enum(u2) {
    /// PB7
    PB7 = 0x0,
    /// PC14
    PC14 = 0x1,
    _,
};

pub const PINMUX1 = enum(u2) {
    /// PF2
    PF2 = 0x0,
    /// PA0
    PA0 = 0x1,
    /// PA1
    PA1 = 0x2,
    /// PA2
    PA2 = 0x3,
};

pub const PINMUX2 = enum(u2) {
    /// PA8
    PA8 = 0x0,
    /// PA11
    PA11 = 0x1,
    _,
};

pub const PINMUX3 = enum(u2) {
    /// PA14
    PA14 = 0x0,
    /// PB6
    PB6 = 0x1,
    /// PC15
    PC15 = 0x2,
    _,
};

pub const PINMUX4 = enum(u2) {
    /// PA7
    PA7 = 0x0,
    /// PA12
    PA12 = 0x1,
    _,
};

pub const PINMUX5 = enum(u2) {
    /// PA3
    PA3 = 0x0,
    /// PA4
    PA4 = 0x1,
    /// PA5
    PA5 = 0x2,
    /// PA6
    PA6 = 0x3,
};

/// register block
pub const SYSCFG = extern struct {
    /// configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection bits. This bitfield controlled by software selects the memory internally mapped at the address 0x0000_0000. Its reset value is determined by the boot mode configuration. Refer to Reference Manual section 2.5 for more details.
        MEM_MODE: MEM_MODE,
        reserved3: u1 = 0,
        /// PA11 pin remapping This bit is set and cleared by software. When set, it remaps the PA11 pin to operate as PA9 GPIO port, instead as PA11 GPIO port.
        PA11_RMP: u1,
        /// PA12 pin remapping This bit is set and cleared by software. When set, it remaps the PA12 pin to operate as PA10 GPIO port, instead as PA12 GPIO port.
        PA12_RMP: u1,
        /// IR output polarity selection
        IR_POL: u1,
        /// IR Modulation Envelope signal selection This bitfield selects the signal for IR modulation envelope:
        IR_MOD: IR_MOD,
        reserved16: u8 = 0,
        /// Fast Mode Plus (FM+) enable for PB6 This bit is set and cleared by software. It enables I2C FM+ driving capability on PB6 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PB6_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB7 This bit is set and cleared by software. It enables I2C FM+ driving capability on PB7 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PB7_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB8 This bit is set and cleared by software. It enables I2C FM+ driving capability on PB8 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PB8_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB9 This bit is set and cleared by software. It enables I2C FM+ driving capability on PB9 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PB9_FMP: u1,
        /// Fast Mode Plus (FM+) enable for I2C1 This bit is set and cleared by software. It enables I2C FM+ driving capability on I/O ports configured as I2C1 through GPIOx_AFR registers. With this bit in disable state, the I2C FM+ driving capability on I/O ports configured as I2C1 can be enabled through their corresponding I2Cx_FMP bit. When I2C FM+ is enabled, the speed control is ignored.
        I2C1_FMP: u1,
        reserved22: u1 = 0,
        /// Fast Mode Plus (FM+) enable for PA9 This bit is set and cleared by software. It enables I2C FM+ driving capability on PA9 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PA9_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PA10 This bit is set and cleared by software. It enables I2C FM+ driving capability on PA10 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PA10_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PC14 This bit is set and cleared by software. It enables I2C FM+ driving capability on PC14 I/O port. With this bit in disable state, the I2C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I2C FM+ is enabled, the speed control is ignored.
        I2C_PC14_FMP: u1,
        padding: u7 = 0,
    }),
    /// offset: 0x04
    reserved4: [20]u8,
    /// configuration register 2
    /// offset: 0x18
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex<Superscript>�<Default � Font>-M0+ LOCKUP enable This bit is set by software and cleared by system reset. When set, it enables the connection of Cortex<Superscript>�<Default � Font>-M0+ LOCKUP (HardFault) output to the TIM1/16/17 Break input.
        LOCKUP_LOCK: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x1c
    reserved28: [32]u8,
    /// configuration register 3
    /// offset: 0x3c
    CFGR3: mmio.Mmio(packed struct(u32) {
        /// Pin GPIO multiplexer 0 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved Pin F2 of WLCSP14 package GPIO assignment 1x: Reserved
        PINMUX0: PINMUX0,
        /// Pin GPIO multiplexer 1 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved
        PINMUX1: PINMUX1,
        /// Pin GPIO multiplexer 2 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved 1x: Reserved
        PINMUX2: PINMUX2,
        /// Pin GPIO multiplexer 3 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved
        PINMUX3: PINMUX3,
        /// Pin GPIO multiplexer 4 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved 1x: Reserved
        PINMUX4: PINMUX4,
        /// Pin GPIO multiplexer 5 This bit is set by software and cleared by system reset. It assigns a GPIO to a pin. 1x: Reserved
        PINMUX5: PINMUX5,
        padding: u20 = 0,
    }),
    /// offset: 0x40
    reserved64: [64]u8,
    /// interrupt line 0 status register
    /// offset: 0x80
    ITLINE0: mmio.Mmio(packed struct(u32) {
        /// Window watchdog interrupt pending flag
        WWDG: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// interrupt line 2 status register
    /// offset: 0x88
    ITLINE2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// RTC interrupt request pending (EXTI line 19)
        RTC: u1,
        padding: u30 = 0,
    }),
    /// interrupt line 3 status register
    /// offset: 0x8c
    ITLINE3: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Flash interface interrupt request pending
        FLASH_ITF: u1,
        padding: u30 = 0,
    }),
    /// interrupt line 4 status register
    /// offset: 0x90
    ITLINE4: mmio.Mmio(packed struct(u32) {
        /// Reset and clock control interrupt request pending
        RCC: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 5 status register
    /// offset: 0x94
    ITLINE5: mmio.Mmio(packed struct(u32) {
        /// (1/2 of EXTI) EXTI
        @"EXTI[0]": u1,
        /// (2/2 of EXTI) EXTI
        @"EXTI[1]": u1,
        padding: u30 = 0,
    }),
    /// interrupt line 6 status register
    /// offset: 0x98
    ITLINE6: mmio.Mmio(packed struct(u32) {
        /// (1/2 of EXTI) EXTI
        @"EXTI[0]": u1,
        /// (2/2 of EXTI) EXTI
        @"EXTI[1]": u1,
        padding: u30 = 0,
    }),
    /// interrupt line 7 status register
    /// offset: 0x9c
    ITLINE7: mmio.Mmio(packed struct(u32) {
        /// (1/12 of EXTI) EXTI
        @"EXTI[0]": u1,
        /// (2/12 of EXTI) EXTI
        @"EXTI[1]": u1,
        /// (3/12 of EXTI) EXTI
        @"EXTI[2]": u1,
        /// (4/12 of EXTI) EXTI
        @"EXTI[3]": u1,
        /// (5/12 of EXTI) EXTI
        @"EXTI[4]": u1,
        /// (6/12 of EXTI) EXTI
        @"EXTI[5]": u1,
        /// (7/12 of EXTI) EXTI
        @"EXTI[6]": u1,
        /// (8/12 of EXTI) EXTI
        @"EXTI[7]": u1,
        /// (9/12 of EXTI) EXTI
        @"EXTI[8]": u1,
        /// (10/12 of EXTI) EXTI
        @"EXTI[9]": u1,
        /// (11/12 of EXTI) EXTI
        @"EXTI[10]": u1,
        /// (12/12 of EXTI) EXTI
        @"EXTI[11]": u1,
        padding: u20 = 0,
    }),
    /// offset: 0xa0
    reserved160: [4]u8,
    /// interrupt line 9 status register
    /// offset: 0xa4
    ITLINE9: mmio.Mmio(packed struct(u32) {
        /// DMA1 channel 1interrupt request pending
        DMA1_CH1: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 10 status register
    /// offset: 0xa8
    ITLINE10: mmio.Mmio(packed struct(u32) {
        /// DMA1 channel 2 interrupt request pending
        DMA1_CH2: u1,
        /// DMA1 channel 3 interrupt request pending
        DMA1_CH3: u1,
        padding: u30 = 0,
    }),
    /// interrupt line 11 status register
    /// offset: 0xac
    ITLINE11: mmio.Mmio(packed struct(u32) {
        /// DMAMUX interrupt request pending
        DMAMUX: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 12 status register
    /// offset: 0xb0
    ITLINE12: mmio.Mmio(packed struct(u32) {
        /// ADC interrupt request pending
        ADC: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 13 status register
    /// offset: 0xb4
    ITLINE13: mmio.Mmio(packed struct(u32) {
        /// Timer 1 commutation interrupt request pending
        TIM1_CCU: u1,
        /// Timer 1 trigger interrupt request pending
        TIM1_TRG: u1,
        /// Timer 1 update interrupt request pending
        TIM1_UPD: u1,
        /// Timer 1 break interrupt request pending
        TIM1_BRK: u1,
        padding: u28 = 0,
    }),
    /// interrupt line 14 status register
    /// offset: 0xb8
    ITLINE14: mmio.Mmio(packed struct(u32) {
        /// Timer 1 capture compare interrupt request pending
        TIM1_CC: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xbc
    reserved188: [4]u8,
    /// interrupt line 16 status register
    /// offset: 0xc0
    ITLINE16: mmio.Mmio(packed struct(u32) {
        /// Timer 3 interrupt request pending
        TIM3: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xc4
    reserved196: [8]u8,
    /// interrupt line 19 status register
    /// offset: 0xcc
    ITLINE19: mmio.Mmio(packed struct(u32) {
        /// Timer 14 interrupt request pending
        TIM14: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xd0
    reserved208: [4]u8,
    /// interrupt line 21 status register
    /// offset: 0xd4
    ITLINE21: mmio.Mmio(packed struct(u32) {
        /// Timer 16 interrupt request pending
        TIM16: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 22 status register
    /// offset: 0xd8
    ITLINE22: mmio.Mmio(packed struct(u32) {
        /// Timer 17 interrupt request pending
        TIM17: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 23 status register
    /// offset: 0xdc
    ITLINE23: mmio.Mmio(packed struct(u32) {
        /// I2C1 interrupt request pending, combined with EXTI line 23
        I2C1: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xe0
    reserved224: [4]u8,
    /// interrupt line 25 status register
    /// offset: 0xe4
    ITLINE25: mmio.Mmio(packed struct(u32) {
        /// SPI1 interrupt request pending
        SPI1: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xe8
    reserved232: [4]u8,
    /// interrupt line 27 status register
    /// offset: 0xec
    ITLINE27: mmio.Mmio(packed struct(u32) {
        /// USART1 interrupt request pending, combined with EXTI line 25
        USART1: u1,
        padding: u31 = 0,
    }),
    /// interrupt line 28 status register
    /// offset: 0xf0
    ITLINE28: mmio.Mmio(packed struct(u32) {
        /// USART2 interrupt request pending (EXTI line 26)
        USART2: u1,
        padding: u31 = 0,
    }),
};
