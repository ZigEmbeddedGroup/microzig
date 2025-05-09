const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

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
    /// System flash memory mapped at 0x000010000
    System_Flash = 0x1,
    /// Embedded SRAM mapped at 0x000010000
    SRAM = 0x3,
    _,
};

/// SYSCFG register block
pub const SYSCFG = extern struct {
    /// SYSCFG configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection bits These bits are set and cleared by software. They control the memory internal mapping at address 0x000010000. After reset these bits take on the value selected by the actual boot mode configuration. Refer to Section12.5: Boot configuration for more details. X0: Main flash memory mapped at 0x000010000
        MEM_MODE: MEM_MODE,
        reserved3: u1 = 0,
        /// PA11 pin remapping This bit is set and cleared by software. When set, it remaps the PA11 pin to operate as PA9 GPIO port, instead as PA11 GPIO port. 0: No remap (PA11) 1: Remap (PA9)
        PA11_RMP: u1,
        /// PA12 pin remapping This bit is set and cleared by software. When set, it remaps the PA12 pin to operate as PA10 GPIO port, instead as PA12 GPIO port. 0: No remap (PA12) 1: Remap (PA10)
        PA12_RMP: u1,
        /// IR output polarity selection
        IR_POL: u1,
        /// IR Modulation Envelope signal selection This bitfield selects the signal for IR modulation envelope:
        IR_MOD: IR_MOD,
        /// I/O analog switch voltage booster enable This bit selects the way of supplying I/O analog switches: When using the analog inputs , setting to 0 is recommended for high V<sub>DD</sub>, setting to 1 for low V<sub>DD</sub> (less than 2.4 V).
        BOOSTEN: u1,
        reserved16: u7 = 0,
        /// Fast Mode Plus (FM+) enable for PB6 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PB6 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PB6_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB7 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PB7 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PB7_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB8 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PB8 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PB8_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PB9 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PB9 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PB9_FMP: u1,
        reserved22: u2 = 0,
        /// Fast Mode Plus (FM+) enable for PA9 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PA9 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PA9_FMP: u1,
        /// Fast Mode Plus (FM+) enable for PA10 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on PA10 I/O port. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on this I/O port can be enabled through one of I2Cx_FMP bits. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C_PA10_FMP: u1,
        /// Fast Mode Plus (FM+) enable for I2C3 This bit is set and cleared by software. It enables I<sup>2</sup>C FM+ driving capability on I/O ports configured as I2C3 through GPIOx_AFR registers. With this bit in disable state, the I<sup>2</sup>C FM+ driving capability on I/O ports configured as I2C3 can be enabled through their corresponding I2Cx_FMP bit. When I<sup>2</sup>C FM+ is enabled, the speed control is ignored. Note: This control bit is kept for legacy reasons. It is recommended to use the FMP bit of the I2Cx_CR1 register instead. 0: Disable 1: Enable
        I2C3_FMP: u1,
        padding: u7 = 0,
    }),
    /// offset: 0x04
    reserved4: [20]u8,
    /// SYSCFG configuration register 2
    /// offset: 0x18
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex<Superscript>1<Default 1 Font>-M0+ LOCKUP bit enable bit This bit is set by software and cleared by a system reset. It can be use to enable and lock the connection of Cortex<Superscript>1<Default 1 Font>-M0+ LOCKUP (Hardfault) output to TIM1/15/16 Break input.
        CCL: u1,
        /// SRAM1 parity lock bit This bit is set by software and cleared by a system reset. It can be used to enable and lock the SRAM1 parity error signal connection to TIM1/15/16 Break input.
        SPL: u1,
        /// PVD lock enable bit This bit is set by software and cleared by a system reset. It can be used to enable and lock the PVD connection to TIM1/15/16 Break input, as well as the PVDE and PLS[2:0] in the PWR_CR register.
        PVDL: u1,
        /// ECC error lock bit This bit is set by software and cleared by a system reset. It can be used to enable and lock the flash ECC 2-bit error detection signal connection to TIM1/15/16 Break input.
        ECCL: u1,
        /// Backup SRAM2 parity lock This bit is set by software and cleared by a system reset. It can be used to enable and lock the SRAM2 parity error signal connection to TIM1/15/16 Break input.
        BKPL: u1,
        reserved7: u2 = 0,
        /// Backup SRAM2 parity error flag This bit is set by hardware when an SRAM2 parity error is detected. It is cleared by software by writing 1.
        BKPF: u1,
        /// SRAM1 parity error flag This bit is set by hardware when an SRAM1 parity error is detected. It is cleared by software by writing 1.
        SPF: u1,
        padding: u23 = 0,
    }),
    /// SYSCFG SRAM2 control and status register
    /// offset: 0x1c
    SCSR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 erase Setting this bit starts a hardware SRAM2 erase operation. This bit is automatically cleared at the end of the SRAM2 erase operation. Note: This bit is write-protected: setting this bit is possible only after the correct key sequence is written in the SYSCFG_SKR register.
        SRAM2ER: u1,
        /// SRAM2 busy by erase operation
        SRAM2BSY: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG SRAM2 key register
    /// offset: 0x20
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 write protection key for software erase The following steps are required to unlock the write protection of the SRAM2ER bit in the SYSCFG_CFGR2 register: Write 0xCA into KEY[7:0] Write 0x53 into KEY[7:0] Writing a wrong key reactivates the write protection.
        KEY: u8,
        padding: u24 = 0,
    }),
    /// SYSCFG TSC comparator register
    /// offset: 0x24
    TSCCR: mmio.Mmio(packed struct(u32) {
        /// Comparator mode for group 2 on I/O 1
        G2_IO1: u1,
        /// Comparator mode for group 2 on I/O 3
        G2_IO3: u1,
        /// Comparator mode for group 4 on I/O 3
        G4_IO3: u1,
        /// Comparator mode for group 6 on I/O 1
        G6_IO1: u1,
        /// Comparator mode for group 7 on I/O 1
        G7_IO1: u1,
        /// I/O control in comparator mode The I/O control in comparator mode can be overwritten by hardware.
        TSC_IOCTRL: u1,
        padding: u26 = 0,
    }),
    /// offset: 0x28
    reserved40: [88]u8,
    /// SYSCFG interrupt line 0 status register
    /// offset: 0x80
    ITLINE0: mmio.Mmio(packed struct(u32) {
        /// Window watchdog interrupt pending flag
        WWDG: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 1 status register
    /// offset: 0x84
    ITLINE1: mmio.Mmio(packed struct(u32) {
        /// PVD supply monitoring interrupt request pending (EXTI line 16).
        PVDOUT: u1,
        /// V<sub>DDUSB</sub> supply monitoring interrupt request pending (EXTI line 19)
        PVMOUT1: u1,
        /// ADC supply monitoring interrupt request pending (EXTI line 20)
        PVMOUT3: u1,
        /// DAC supply monitoring interrupt request pending (EXTI line 21)
        PVMOUT4: u1,
        padding: u28 = 0,
    }),
    /// SYSCFG interrupt line 2 status register
    /// offset: 0x88
    ITLINE2: mmio.Mmio(packed struct(u32) {
        /// Tamper interrupt request pending (EXTI line 21)
        TAMP: u1,
        /// RTC interrupt request pending (EXTI line 19)
        RTC: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 3 status register
    /// offset: 0x8c
    ITLINE3: mmio.Mmio(packed struct(u32) {
        /// Flash interface interrupt request pending
        FLASH_ITF: u1,
        /// Flash interface ECC interrupt request pending
        FLASH_ECC: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 4 status register
    /// offset: 0x90
    ITLINE4: mmio.Mmio(packed struct(u32) {
        /// Reset and clock control interrupt request pending
        RCC: u1,
        /// CRS interrupt request pending
        CRS: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 5 status register
    /// offset: 0x94
    ITLINE5: mmio.Mmio(packed struct(u32) {
        /// EXTI line 0 interrupt request pending
        EXTI0: u1,
        /// EXTI line 1 interrupt request pending
        EXTI1: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 6 status register
    /// offset: 0x98
    ITLINE6: mmio.Mmio(packed struct(u32) {
        /// EXTI line 2 interrupt request pending
        EXTI2: u1,
        /// EXTI line 3 interrupt request pending
        EXTI3: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 7 status register
    /// offset: 0x9c
    ITLINE7: mmio.Mmio(packed struct(u32) {
        /// EXTI line 4 interrupt request pending
        EXTI4: u1,
        /// EXTI line 5 interrupt request pending
        EXTI5: u1,
        /// EXTI line 6 interrupt request pending
        EXTI6: u1,
        /// EXTI line 7 interrupt request pending
        EXTI7: u1,
        /// EXTI line 8 interrupt request pending
        EXTI8: u1,
        /// EXTI line 9 interrupt request pending
        EXTI9: u1,
        /// EXTI line 10 interrupt request pending
        EXTI10: u1,
        /// EXTI line 11 interrupt request pending
        EXTI11: u1,
        /// EXTI line 12 interrupt request pending
        EXTI12: u1,
        /// EXTI line 13 interrupt request pending
        EXTI13: u1,
        /// EXTI line 14 interrupt request pending
        EXTI14: u1,
        /// EXTI line 15 interrupt request pending
        EXTI15: u1,
        padding: u20 = 0,
    }),
    /// SYSCFG interrupt line 8 status register
    /// offset: 0xa0
    ITLINE8: mmio.Mmio(packed struct(u32) {
        /// USB interrupt request pending
        USB: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 9 status register
    /// offset: 0xa4
    ITLINE9: mmio.Mmio(packed struct(u32) {
        /// DMA1 channel 1 interrupt request pending
        DMA1_CH1: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 10 status register
    /// offset: 0xa8
    ITLINE10: mmio.Mmio(packed struct(u32) {
        /// DMA1 channel 2 interrupt request pending
        DMA1_CH2: u1,
        /// DMA1 channel 3 interrupt request pending
        DMA1_CH3: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 11 status register
    /// offset: 0xac
    ITLINE11: mmio.Mmio(packed struct(u32) {
        /// DMAMUX interrupt request pending
        DMAMUX: u1,
        /// DMA1 channel 4 interrupt request pending
        DMA1_CH4: u1,
        /// DMA1 channel 5 interrupt request pending
        DMA1_CH5: u1,
        /// DMA1 channel 6 interrupt request pending
        DMA1_CH6: u1,
        /// DMA1 channel 7 interrupt request pending
        DMA1_CH7: u1,
        /// DMA2 channel 1 interrupt request pending
        DMA2_CH1: u1,
        /// DMA2 channel 2 interrupt request pending
        DMA2_CH2: u1,
        /// DMA2 channel 3 interrupt request pending
        DMA2_CH3: u1,
        /// DMA2 channel 4 interrupt request pending
        DMA2_CH4: u1,
        /// DMA2 channel 5 interrupt request pending
        DMA2_CH5: u1,
        padding: u22 = 0,
    }),
    /// SYSCFG interrupt line 12 status register
    /// offset: 0xb0
    ITLINE12: mmio.Mmio(packed struct(u32) {
        /// ADC interrupt request pending
        ADC: u1,
        /// Comparator 1 interrupt request pending (EXTI line 17)
        COMP1: u1,
        /// Comparator 2 interrupt request pending (EXTI line 18)
        COMP2: u1,
        padding: u29 = 0,
    }),
    /// SYSCFG interrupt line 13 status register
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
    /// SYSCFG interrupt line 14 status register
    /// offset: 0xb8
    ITLINE14: mmio.Mmio(packed struct(u32) {
        /// Timer 1 capture compare 1 interrupt request pending
        TIM1_CC1: u1,
        /// Timer 1 capture compare 2 interrupt request pending
        TIM1_CC2: u1,
        /// Timer 1 capture compare 3 interrupt request pending
        TIM1_CC3: u1,
        /// Timer 1 capture compare 4 interrupt request pending
        TIM1_CC4: u1,
        padding: u28 = 0,
    }),
    /// SYSCFG interrupt line 15 status register
    /// offset: 0xbc
    ITLINE15: mmio.Mmio(packed struct(u32) {
        /// Timer 2 interrupt request pending
        TIM2: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 16 status register
    /// offset: 0xc0
    ITLINE16: mmio.Mmio(packed struct(u32) {
        /// Timer 3 interrupt request pending
        TIM3: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 17 status register
    /// offset: 0xc4
    ITLINE17: mmio.Mmio(packed struct(u32) {
        /// Timer 6 interrupt request pending
        TIM6: u1,
        /// DAC underrun interrupt request pending
        DAC: u1,
        /// Low-power timer 1 interrupt request pending (EXTI line 29)
        LPTIM1: u1,
        padding: u29 = 0,
    }),
    /// SYSCFG interrupt line 18 status register
    /// offset: 0xc8
    ITLINE18: mmio.Mmio(packed struct(u32) {
        /// Timer 7 interrupt request pending
        TIM7: u1,
        /// Low-power timer 2 interrupt request pending (EXTI line 30)
        LPTIM2: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 19 status register
    /// offset: 0xcc
    ITLINE19: mmio.Mmio(packed struct(u32) {
        /// Timer 15 interrupt request pending
        TIM15: u1,
        /// Low-power timer 3 interrupt request pending
        LPTIM3: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 20 status register
    /// offset: 0xd0
    ITLINE20: mmio.Mmio(packed struct(u32) {
        /// Timer 16 interrupt request pending
        TIM16: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 21 status register
    /// offset: 0xd4
    ITLINE21: mmio.Mmio(packed struct(u32) {
        /// TSC max count error interrupt request pending
        TSC_MCE: u1,
        /// TSC end of acquisition interrupt request pending
        TSC_EOA: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 22 status register
    /// offset: 0xd8
    ITLINE22: mmio.Mmio(packed struct(u32) {
        /// LCD interrupt request pending
        LCD: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 23 status register
    /// offset: 0xdc
    ITLINE23: mmio.Mmio(packed struct(u32) {
        /// I2C1 interrupt request pending (EXTI line 33)
        I2C1: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 24 status register
    /// offset: 0xe0
    ITLINE24: mmio.Mmio(packed struct(u32) {
        /// I2C2 interrupt request pending
        I2C2: u1,
        /// I2C4 interrupt request pending
        I2C4: u1,
        /// I2C3 interrupt request pending (EXTI line 23)
        I2C3: u1,
        padding: u29 = 0,
    }),
    /// SYSCFG interrupt line 25 status register
    /// offset: 0xe4
    ITLINE25: mmio.Mmio(packed struct(u32) {
        /// SPI1 interrupt request pending
        SPI1: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 26 status register
    /// offset: 0xe8
    ITLINE26: mmio.Mmio(packed struct(u32) {
        /// SPI2 interrupt request pending
        SPI2: u1,
        /// SPI3 interrupt request pending
        SPI3: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 27 status register
    /// offset: 0xec
    ITLINE27: mmio.Mmio(packed struct(u32) {
        /// USART1 interrupt request pending, combined with EXTI line 25
        USART1: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG interrupt line 28 status register
    /// offset: 0xf0
    ITLINE28: mmio.Mmio(packed struct(u32) {
        /// USART2 interrupt request pending (EXTI line 35)
        USART2: u1,
        /// LPUART2 interrupt request pending (EXTI line 31)
        LPUART2: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 29 status register
    /// offset: 0xf4
    ITLINE29: mmio.Mmio(packed struct(u32) {
        /// USART3 interrupt request pending
        USART3: u1,
        /// LPUART1 interrupt request pending (EXTI line 30)
        LPUART1: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 30 status register
    /// offset: 0xf8
    ITLINE30: mmio.Mmio(packed struct(u32) {
        /// USART4 interrupt request pending
        USART4: u1,
        /// LPUART3 interrupt request pending (EXTI line 32)
        LPUART3: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG interrupt line 31 status register
    /// offset: 0xfc
    ITLINE31: mmio.Mmio(packed struct(u32) {
        /// RNG interrupt request pending
        RNG: u1,
        /// AES interrupt request pending
        AES: u1,
        padding: u30 = 0,
    }),
};
