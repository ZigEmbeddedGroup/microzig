// generated using svd2zig.py
// DO NOT EDIT
// based on STM32F103xx version 1.3
const microzig_mmio = @import("microzig-mmio");
const mmio = microzig_mmio.mmio;
const MMIO = microzig_mmio.MMIO;
const Name = "STM32F103xx";

/// Flexible static memory controller
pub const FSMC = extern struct {
    pub const Address: u32 = 0xa0000000;

    /// SRAM/NOR-Flash chip-select control register 1
    pub const BCR1 = mmio(Address + 0x00000000, 32, packed struct {
        reserved1: u1 = 0,
        reserved2: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const PATT2 = mmio(Address + 0x0000006c, 32, packed struct {
        /// Attribute memory x setup time
        ATTSETx: u8 = 0,
        /// Attribute memory x wait time
        ATTWAITx: u8 = 0,
        /// Attribute memory x hold time
        ATTHOLDx: u8 = 0,
        /// Attribute memory x databus HiZ time
        ATTHIZx: u8 = 0,
    });

    /// ECC result register 2
    pub const ECCR2 = mmio(Address + 0x00000074, 32, packed struct {
        /// ECC result
        ECCx: u32 = 0,
    });

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
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 2
    pub const BWTR2 = mmio(Address + 0x0000010c, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 3
    pub const BWTR3 = mmio(Address + 0x00000114, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SRAM/NOR-Flash write timing registers 4
    pub const BWTR4 = mmio(Address + 0x0000011c, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });
};

/// Power control
pub const PWR = extern struct {
    pub const Address: u32 = 0x40007000;

    /// Power control register (PWR_CR)
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// Low Power Deep Sleep
        LPDS: u1 = 0,
        /// Power Down Deep Sleep
        PDDS: u1 = 0,
        /// Clear Wake-up Flag
        CWUF: u1 = 0,
        /// Clear STANDBY Flag
        CSBF: u1 = 0,
        /// Power Voltage Detector Enable
        PVDE: u1 = 0,
        /// PVD Level Selection
        PLS: u3 = 0,
        /// Disable Backup Domain write protection
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

    /// Power control register (PWR_CR)
    pub const CSR = mmio(Address + 0x00000004, 32, packed struct {
        /// Wake-Up Flag
        WUF: u1 = 0,
        /// STANDBY Flag
        SBF: u1 = 0,
        /// PVD Output
        PVDO: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Enable WKUP pin
        EWUP: u1 = 0,
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
        /// APB High speed prescaler (APB2)
        PPRE2: u3 = 0,
        /// ADC prescaler
        ADCPRE: u2 = 0,
        /// PLL entry clock source
        PLLSRC: u1 = 0,
        /// HSE divider for PLL entry
        PLLXTPRE: u1 = 0,
        /// PLL Multiplication Factor
        PLLMUL: u4 = 0,
        /// USB OTG FS prescaler
        OTGFSPRE: u1 = 0,
        reserved1: u1 = 0,
        /// Microcontroller clock output
        MCO: u3 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
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
        /// Alternate function I/O reset
        AFIORST: u1 = 0,
        reserved1: u1 = 0,
        /// IO port A reset
        IOPARST: u1 = 0,
        /// IO port B reset
        IOPBRST: u1 = 0,
        /// IO port C reset
        IOPCRST: u1 = 0,
        /// IO port D reset
        IOPDRST: u1 = 0,
        /// IO port E reset
        IOPERST: u1 = 0,
        /// IO port F reset
        IOPFRST: u1 = 0,
        /// IO port G reset
        IOPGRST: u1 = 0,
        /// ADC 1 interface reset
        ADC1RST: u1 = 0,
        /// ADC 2 interface reset
        ADC2RST: u1 = 0,
        /// TIM1 timer reset
        TIM1RST: u1 = 0,
        /// SPI 1 reset
        SPI1RST: u1 = 0,
        /// TIM8 timer reset
        TIM8RST: u1 = 0,
        /// USART1 reset
        USART1RST: u1 = 0,
        /// ADC 3 interface reset
        ADC3RST: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// TIM9 timer reset
        TIM9RST: u1 = 0,
        /// TIM10 timer reset
        TIM10RST: u1 = 0,
        /// TIM11 timer reset
        TIM11RST: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Timer 4 reset
        TIM4RST: u1 = 0,
        /// Timer 5 reset
        TIM5RST: u1 = 0,
        /// Timer 6 reset
        TIM6RST: u1 = 0,
        /// Timer 7 reset
        TIM7RST: u1 = 0,
        /// Timer 12 reset
        TIM12RST: u1 = 0,
        /// Timer 13 reset
        TIM13RST: u1 = 0,
        /// Timer 14 reset
        TIM14RST: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Window watchdog reset
        WWDGRST: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// SPI2 reset
        SPI2RST: u1 = 0,
        /// SPI3 reset
        SPI3RST: u1 = 0,
        reserved5: u1 = 0,
        /// USART 2 reset
        USART2RST: u1 = 0,
        /// USART 3 reset
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
        reserved6: u1 = 0,
        /// CAN reset
        CANRST: u1 = 0,
        reserved7: u1 = 0,
        /// Backup interface reset
        BKPRST: u1 = 0,
        /// Power interface reset
        PWRRST: u1 = 0,
        /// DAC interface reset
        DACRST: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// AHB Peripheral Clock enable register (RCC_AHBENR)
    pub const AHBENR = mmio(Address + 0x00000014, 32, packed struct {
        /// DMA1 clock enable
        DMA1EN: u1 = 0,
        /// DMA2 clock enable
        DMA2EN: u1 = 0,
        /// SRAM interface clock enable
        SRAMEN: u1 = 0,
        reserved1: u1 = 0,
        /// FLITF clock enable
        FLITFEN: u1 = 0,
        reserved2: u1 = 0,
        /// CRC clock enable
        CRCEN: u1 = 0,
        reserved3: u1 = 0,
        /// FSMC clock enable
        FSMCEN: u1 = 0,
        reserved4: u1 = 0,
        /// SDIO clock enable
        SDIOEN: u1 = 0,
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

    /// APB2 peripheral clock enable register (RCC_APB2ENR)
    pub const APB2ENR = mmio(Address + 0x00000018, 32, packed struct {
        /// Alternate function I/O clock enable
        AFIOEN: u1 = 0,
        reserved1: u1 = 0,
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
        /// ADC 1 interface clock enable
        ADC1EN: u1 = 0,
        /// ADC 2 interface clock enable
        ADC2EN: u1 = 0,
        /// TIM1 Timer clock enable
        TIM1EN: u1 = 0,
        /// SPI 1 clock enable
        SPI1EN: u1 = 0,
        /// TIM8 Timer clock enable
        TIM8EN: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1 = 0,
        /// ADC3 interface clock enable
        ADC3EN: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// TIM9 Timer clock enable
        TIM9EN: u1 = 0,
        /// TIM10 Timer clock enable
        TIM10EN: u1 = 0,
        /// TIM11 Timer clock enable
        TIM11EN: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Timer 5 clock enable
        TIM5EN: u1 = 0,
        /// Timer 6 clock enable
        TIM6EN: u1 = 0,
        /// Timer 7 clock enable
        TIM7EN: u1 = 0,
        /// Timer 12 clock enable
        TIM12EN: u1 = 0,
        /// Timer 13 clock enable
        TIM13EN: u1 = 0,
        /// Timer 14 clock enable
        TIM14EN: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Window watchdog clock enable
        WWDGEN: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// SPI 2 clock enable
        SPI2EN: u1 = 0,
        /// SPI 3 clock enable
        SPI3EN: u1 = 0,
        reserved5: u1 = 0,
        /// USART 2 clock enable
        USART2EN: u1 = 0,
        /// USART 3 clock enable
        USART3EN: u1 = 0,
        /// UART 4 clock enable
        UART4EN: u1 = 0,
        /// UART 5 clock enable
        UART5EN: u1 = 0,
        /// I2C 1 clock enable
        I2C1EN: u1 = 0,
        /// I2C 2 clock enable
        I2C2EN: u1 = 0,
        /// USB clock enable
        USBEN: u1 = 0,
        reserved6: u1 = 0,
        /// CAN clock enable
        CANEN: u1 = 0,
        reserved7: u1 = 0,
        /// Backup interface clock enable
        BKPEN: u1 = 0,
        /// Power interface clock enable
        PWREN: u1 = 0,
        /// DAC interface clock enable
        DACEN: u1 = 0,
        padding2: u1 = 0,
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
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// RTC clock source selection
        RTCSEL: u2 = 0,
        reserved10: u1 = 0,
        reserved9: u1 = 0,
        reserved8: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
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
        reserved23: u1 = 0,
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
};

/// General purpose I/O
pub const GPIOA = extern struct {
    pub const Address: u32 = 0x40010800;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOB = extern struct {
    pub const Address: u32 = 0x40010c00;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOC = extern struct {
    pub const Address: u32 = 0x40011000;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOD = extern struct {
    pub const Address: u32 = 0x40011400;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOE = extern struct {
    pub const Address: u32 = 0x40011800;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOF = extern struct {
    pub const Address: u32 = 0x40011c00;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// General purpose I/O
pub const GPIOG = extern struct {
    pub const Address: u32 = 0x40012000;

    /// Port configuration register low (GPIOn_CRL)
    pub const CRL = mmio(Address + 0x00000000, 32, packed struct {
        /// Port n.0 mode bits
        MODE0: u2 = 0,
        /// Port n.0 configuration bits
        CNF0: u2 = 0,
        /// Port n.1 mode bits
        MODE1: u2 = 0,
        /// Port n.1 configuration bits
        CNF1: u2 = 0,
        /// Port n.2 mode bits
        MODE2: u2 = 0,
        /// Port n.2 configuration bits
        CNF2: u2 = 0,
        /// Port n.3 mode bits
        MODE3: u2 = 0,
        /// Port n.3 configuration bits
        CNF3: u2 = 0,
        /// Port n.4 mode bits
        MODE4: u2 = 0,
        /// Port n.4 configuration bits
        CNF4: u2 = 0,
        /// Port n.5 mode bits
        MODE5: u2 = 0,
        /// Port n.5 configuration bits
        CNF5: u2 = 0,
        /// Port n.6 mode bits
        MODE6: u2 = 0,
        /// Port n.6 configuration bits
        CNF6: u2 = 0,
        /// Port n.7 mode bits
        MODE7: u2 = 0,
        /// Port n.7 configuration bits
        CNF7: u2 = 0,
    });

    /// Port configuration register high (GPIOn_CRL)
    pub const CRH = mmio(Address + 0x00000004, 32, packed struct {
        /// Port n.8 mode bits
        MODE8: u2 = 0,
        /// Port n.8 configuration bits
        CNF8: u2 = 0,
        /// Port n.9 mode bits
        MODE9: u2 = 0,
        /// Port n.9 configuration bits
        CNF9: u2 = 0,
        /// Port n.10 mode bits
        MODE10: u2 = 0,
        /// Port n.10 configuration bits
        CNF10: u2 = 0,
        /// Port n.11 mode bits
        MODE11: u2 = 0,
        /// Port n.11 configuration bits
        CNF11: u2 = 0,
        /// Port n.12 mode bits
        MODE12: u2 = 0,
        /// Port n.12 configuration bits
        CNF12: u2 = 0,
        /// Port n.13 mode bits
        MODE13: u2 = 0,
        /// Port n.13 configuration bits
        CNF13: u2 = 0,
        /// Port n.14 mode bits
        MODE14: u2 = 0,
        /// Port n.14 configuration bits
        CNF14: u2 = 0,
        /// Port n.15 mode bits
        MODE15: u2 = 0,
        /// Port n.15 configuration bits
        CNF15: u2 = 0,
    });

    /// Port input data register (GPIOn_IDR)
    pub const IDR = mmio(Address + 0x00000008, 32, packed struct {
        /// Port input data
        IDR0: u1 = 0,
        /// Port input data
        IDR1: u1 = 0,
        /// Port input data
        IDR2: u1 = 0,
        /// Port input data
        IDR3: u1 = 0,
        /// Port input data
        IDR4: u1 = 0,
        /// Port input data
        IDR5: u1 = 0,
        /// Port input data
        IDR6: u1 = 0,
        /// Port input data
        IDR7: u1 = 0,
        /// Port input data
        IDR8: u1 = 0,
        /// Port input data
        IDR9: u1 = 0,
        /// Port input data
        IDR10: u1 = 0,
        /// Port input data
        IDR11: u1 = 0,
        /// Port input data
        IDR12: u1 = 0,
        /// Port input data
        IDR13: u1 = 0,
        /// Port input data
        IDR14: u1 = 0,
        /// Port input data
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

    /// Port output data register (GPIOn_ODR)
    pub const ODR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Port output data
        ODR0: u1 = 0,
        /// Port output data
        ODR1: u1 = 0,
        /// Port output data
        ODR2: u1 = 0,
        /// Port output data
        ODR3: u1 = 0,
        /// Port output data
        ODR4: u1 = 0,
        /// Port output data
        ODR5: u1 = 0,
        /// Port output data
        ODR6: u1 = 0,
        /// Port output data
        ODR7: u1 = 0,
        /// Port output data
        ODR8: u1 = 0,
        /// Port output data
        ODR9: u1 = 0,
        /// Port output data
        ODR10: u1 = 0,
        /// Port output data
        ODR11: u1 = 0,
        /// Port output data
        ODR12: u1 = 0,
        /// Port output data
        ODR13: u1 = 0,
        /// Port output data
        ODR14: u1 = 0,
        /// Port output data
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

    /// Port bit set/reset register (GPIOn_BSRR)
    pub const BSRR = mmio(Address + 0x00000010, 32, packed struct {
        /// Set bit 0
        BS0: u1 = 0,
        /// Set bit 1
        BS1: u1 = 0,
        /// Set bit 1
        BS2: u1 = 0,
        /// Set bit 3
        BS3: u1 = 0,
        /// Set bit 4
        BS4: u1 = 0,
        /// Set bit 5
        BS5: u1 = 0,
        /// Set bit 6
        BS6: u1 = 0,
        /// Set bit 7
        BS7: u1 = 0,
        /// Set bit 8
        BS8: u1 = 0,
        /// Set bit 9
        BS9: u1 = 0,
        /// Set bit 10
        BS10: u1 = 0,
        /// Set bit 11
        BS11: u1 = 0,
        /// Set bit 12
        BS12: u1 = 0,
        /// Set bit 13
        BS13: u1 = 0,
        /// Set bit 14
        BS14: u1 = 0,
        /// Set bit 15
        BS15: u1 = 0,
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 2
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
        BR15: u1 = 0,
    });

    /// Port bit reset register (GPIOn_BRR)
    pub const BRR = mmio(Address + 0x00000014, 32, packed struct {
        /// Reset bit 0
        BR0: u1 = 0,
        /// Reset bit 1
        BR1: u1 = 0,
        /// Reset bit 1
        BR2: u1 = 0,
        /// Reset bit 3
        BR3: u1 = 0,
        /// Reset bit 4
        BR4: u1 = 0,
        /// Reset bit 5
        BR5: u1 = 0,
        /// Reset bit 6
        BR6: u1 = 0,
        /// Reset bit 7
        BR7: u1 = 0,
        /// Reset bit 8
        BR8: u1 = 0,
        /// Reset bit 9
        BR9: u1 = 0,
        /// Reset bit 10
        BR10: u1 = 0,
        /// Reset bit 11
        BR11: u1 = 0,
        /// Reset bit 12
        BR12: u1 = 0,
        /// Reset bit 13
        BR13: u1 = 0,
        /// Reset bit 14
        BR14: u1 = 0,
        /// Reset bit 15
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

    /// Port configuration lock register
    pub const LCKR = mmio(Address + 0x00000018, 32, packed struct {
        /// Port A Lock bit 0
        LCK0: u1 = 0,
        /// Port A Lock bit 1
        LCK1: u1 = 0,
        /// Port A Lock bit 2
        LCK2: u1 = 0,
        /// Port A Lock bit 3
        LCK3: u1 = 0,
        /// Port A Lock bit 4
        LCK4: u1 = 0,
        /// Port A Lock bit 5
        LCK5: u1 = 0,
        /// Port A Lock bit 6
        LCK6: u1 = 0,
        /// Port A Lock bit 7
        LCK7: u1 = 0,
        /// Port A Lock bit 8
        LCK8: u1 = 0,
        /// Port A Lock bit 9
        LCK9: u1 = 0,
        /// Port A Lock bit 10
        LCK10: u1 = 0,
        /// Port A Lock bit 11
        LCK11: u1 = 0,
        /// Port A Lock bit 12
        LCK12: u1 = 0,
        /// Port A Lock bit 13
        LCK13: u1 = 0,
        /// Port A Lock bit 14
        LCK14: u1 = 0,
        /// Port A Lock bit 15
        LCK15: u1 = 0,
        /// Lock key
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
};

/// Alternate function I/O
pub const AFIO = extern struct {
    pub const Address: u32 = 0x40010000;

    /// Event Control Register (AFIO_EVCR)
    pub const EVCR = mmio(Address + 0x00000000, 32, packed struct {
        /// Pin selection
        PIN: u4 = 0,
        /// Port selection
        PORT: u3 = 0,
        /// Event Output Enable
        EVOE: u1 = 0,
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

    /// AF remap and debug I/O configuration register (AFIO_MAPR)
    pub const MAPR = mmio(Address + 0x00000004, 32, packed struct {
        /// SPI1 remapping
        SPI1_REMAP: u1 = 0,
        /// I2C1 remapping
        I2C1_REMAP: u1 = 0,
        /// USART1 remapping
        USART1_REMAP: u1 = 0,
        /// USART2 remapping
        USART2_REMAP: u1 = 0,
        /// USART3 remapping
        USART3_REMAP: u2 = 0,
        /// TIM1 remapping
        TIM1_REMAP: u2 = 0,
        /// TIM2 remapping
        TIM2_REMAP: u2 = 0,
        /// TIM3 remapping
        TIM3_REMAP: u2 = 0,
        /// TIM4 remapping
        TIM4_REMAP: u1 = 0,
        /// CAN1 remapping
        CAN_REMAP: u2 = 0,
        /// Port D0/Port D1 mapping on OSCIN/OSCOUT
        PD01_REMAP: u1 = 0,
        /// Set and cleared by software
        TIM5CH4_IREMAP: u1 = 0,
        /// ADC 1 External trigger injected conversion remapping
        ADC1_ETRGINJ_REMAP: u1 = 0,
        /// ADC 1 external trigger regular conversion remapping
        ADC1_ETRGREG_REMAP: u1 = 0,
        /// ADC 2 external trigger injected conversion remapping
        ADC2_ETRGINJ_REMAP: u1 = 0,
        /// ADC 2 external trigger regular conversion remapping
        ADC2_ETRGREG_REMAP: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Serial wire JTAG configuration
        SWJ_CFG: u3 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// External interrupt configuration register 1 (AFIO_EXTICR1)
    pub const EXTICR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// EXTI0 configuration
        EXTI0: u4 = 0,
        /// EXTI1 configuration
        EXTI1: u4 = 0,
        /// EXTI2 configuration
        EXTI2: u4 = 0,
        /// EXTI3 configuration
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

    /// External interrupt configuration register 2 (AFIO_EXTICR2)
    pub const EXTICR2 = mmio(Address + 0x0000000c, 32, packed struct {
        /// EXTI4 configuration
        EXTI4: u4 = 0,
        /// EXTI5 configuration
        EXTI5: u4 = 0,
        /// EXTI6 configuration
        EXTI6: u4 = 0,
        /// EXTI7 configuration
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

    /// External interrupt configuration register 3 (AFIO_EXTICR3)
    pub const EXTICR3 = mmio(Address + 0x00000010, 32, packed struct {
        /// EXTI8 configuration
        EXTI8: u4 = 0,
        /// EXTI9 configuration
        EXTI9: u4 = 0,
        /// EXTI10 configuration
        EXTI10: u4 = 0,
        /// EXTI11 configuration
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

    /// External interrupt configuration register 4 (AFIO_EXTICR4)
    pub const EXTICR4 = mmio(Address + 0x00000014, 32, packed struct {
        /// EXTI12 configuration
        EXTI12: u4 = 0,
        /// EXTI13 configuration
        EXTI13: u4 = 0,
        /// EXTI14 configuration
        EXTI14: u4 = 0,
        /// EXTI15 configuration
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

    /// AF remap and debug I/O configuration register
    pub const MAPR2 = mmio(Address + 0x0000001c, 32, packed struct {
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// TIM9 remapping
        TIM9_REMAP: u1 = 0,
        /// TIM10 remapping
        TIM10_REMAP: u1 = 0,
        /// TIM11 remapping
        TIM11_REMAP: u1 = 0,
        /// TIM13 remapping
        TIM13_REMAP: u1 = 0,
        /// TIM14 remapping
        TIM14_REMAP: u1 = 0,
        /// NADV connect/disconnect
        FSMC_NADV: u1 = 0,
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

/// EXTI
pub const EXTI = extern struct {
    pub const Address: u32 = 0x40010400;

    /// Interrupt mask register (EXTI_IMR)
    pub const IMR = mmio(Address + 0x00000000, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Event mask register (EXTI_EMR)
    pub const EMR = mmio(Address + 0x00000004, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Rising Trigger selection register (EXTI_RTSR)
    pub const RTSR = mmio(Address + 0x00000008, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Falling Trigger selection register (EXTI_FTSR)
    pub const FTSR = mmio(Address + 0x0000000c, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Software interrupt event register (EXTI_SWIER)
    pub const SWIER = mmio(Address + 0x00000010, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Pending register (EXTI_PR)
    pub const PR = mmio(Address + 0x00000014, 32, packed struct {
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
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// DMA controller
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

/// DMA controller
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

/// Secure digital input/output interface
pub const SDIO = extern struct {
    pub const Address: u32 = 0x40018000;

    /// Bits 1:0 = PWRCTRL: Power supply control bits
    pub const POWER = mmio(Address + 0x00000000, 32, packed struct {
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

    /// SDI clock control register (SDIO_CLKCR)
    pub const CLKCR = mmio(Address + 0x00000004, 32, packed struct {
        /// Clock divide factor
        CLKDIV: u8 = 0,
        /// Clock enable bit
        CLKEN: u1 = 0,
        /// Power saving configuration bit
        PWRSAV: u1 = 0,
        /// Clock divider bypass enable bit
        BYPASS: u1 = 0,
        /// Wide bus mode enable bit
        WIDBUS: u2 = 0,
        /// SDIO_CK dephasing selection bit
        NEGEDGE: u1 = 0,
        /// HW Flow Control enable
        HWFC_EN: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Bits 31:0 = : Command argument
    pub const ARG = mmio(Address + 0x00000008, 32, packed struct {
        /// Command argument
        CMDARG: u32 = 0,
    });

    /// SDIO command register (SDIO_CMD)
    pub const CMD = mmio(Address + 0x0000000c, 32, packed struct {
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SDIO command register
    pub const RESPCMD = mmio(Address + 0x00000010, 32, packed struct {
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

    /// Bits 31:0 = CARDSTATUS1
    pub const RESPI1 = mmio(Address + 0x00000014, 32, packed struct {});

    /// Bits 31:0 = CARDSTATUS2
    pub const RESP2 = mmio(Address + 0x00000018, 32, packed struct {});

    /// Bits 31:0 = CARDSTATUS3
    pub const RESP3 = mmio(Address + 0x0000001c, 32, packed struct {});

    /// Bits 31:0 = CARDSTATUS4
    pub const RESP4 = mmio(Address + 0x00000020, 32, packed struct {});

    /// Bits 31:0 = DATATIME: Data timeout period
    pub const DTIMER = mmio(Address + 0x00000024, 32, packed struct {
        /// Data timeout period
        DATATIME: u32 = 0,
    });

    /// Bits 24:0 = DATALENGTH: Data length value
    pub const DLEN = mmio(Address + 0x00000028, 32, packed struct {
        /// Data length value
        DATALENGTH: u25 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SDIO data control register (SDIO_DCTRL)
    pub const DCTRL = mmio(Address + 0x0000002c, 32, packed struct {
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Bits 24:0 = DATACOUNT: Data count value
    pub const DCOUNT = mmio(Address + 0x00000030, 32, packed struct {
        /// Data count value
        DATACOUNT: u25 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SDIO status register (SDIO_STA)
    pub const STA = mmio(Address + 0x00000034, 32, packed struct {
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// SDIO interrupt clear register (SDIO_ICR)
    pub const ICR = mmio(Address + 0x00000038, 32, packed struct {
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

    /// SDIO mask register (SDIO_MASK)
    pub const MASK = mmio(Address + 0x0000003c, 32, packed struct {
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Bits 23:0 = FIFOCOUNT: Remaining number of words to be written to or read
    /// from the FIFO
    pub const FIFOCNT = mmio(Address + 0x00000048, 32, packed struct {
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// bits 31:0 = FIFOData: Receive and transmit FIFO data
    pub const FIFO = mmio(Address + 0x00000080, 32, packed struct {});
};

/// Real time clock
pub const RTC = extern struct {
    pub const Address: u32 = 0x40002800;

    /// RTC Control Register High
    pub const CRH = mmio(Address + 0x00000000, 32, packed struct {
        /// Second interrupt Enable
        SECIE: u1 = 0,
        /// Alarm interrupt Enable
        ALRIE: u1 = 0,
        /// Overflow interrupt Enable
        OWIE: u1 = 0,
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

    /// RTC Control Register Low
    pub const CRL = mmio(Address + 0x00000004, 32, packed struct {
        /// Second Flag
        SECF: u1 = 0,
        /// Alarm Flag
        ALRF: u1 = 0,
        /// Overflow Flag
        OWF: u1 = 0,
        /// Registers Synchronized Flag
        RSF: u1 = 0,
        /// Configuration Flag
        CNF: u1 = 0,
        /// RTC operation OFF
        RTOFF: u1 = 0,
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

    /// RTC Prescaler Load Register High
    pub const PRLH = mmio(Address + 0x00000008, 32, packed struct {
        /// RTC Prescaler Load Register High
        PRLH: u4 = 0,
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

    /// RTC Prescaler Load Register Low
    pub const PRLL = mmio(Address + 0x0000000c, 32, packed struct {
        /// RTC Prescaler Divider Register Low
        PRLL: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC Prescaler Divider Register High
    pub const DIVH = mmio(Address + 0x00000010, 32, packed struct {
        /// RTC prescaler divider register high
        DIVH: u4 = 0,
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

    /// RTC Prescaler Divider Register Low
    pub const DIVL = mmio(Address + 0x00000014, 32, packed struct {
        /// RTC prescaler divider register Low
        DIVL: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC Counter Register High
    pub const CNTH = mmio(Address + 0x00000018, 32, packed struct {
        /// RTC counter register high
        CNTH: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC Counter Register Low
    pub const CNTL = mmio(Address + 0x0000001c, 32, packed struct {
        /// RTC counter register Low
        CNTL: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC Alarm Register High
    pub const ALRH = mmio(Address + 0x00000020, 32, packed struct {
        /// RTC alarm register high
        ALRH: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC Alarm Register Low
    pub const ALRL = mmio(Address + 0x00000024, 32, packed struct {
        /// RTC alarm register low
        ALRL: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// Backup registers
pub const BKP = extern struct {
    pub const Address: u32 = 0x40006c04;

    /// Backup data register (BKP_DR)
    pub const DR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Backup data
        D1: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR2 = mmio(Address + 0x00000004, 32, packed struct {
        /// Backup data
        D2: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR3 = mmio(Address + 0x00000008, 32, packed struct {
        /// Backup data
        D3: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR4 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Backup data
        D4: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR5 = mmio(Address + 0x00000010, 32, packed struct {
        /// Backup data
        D5: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR6 = mmio(Address + 0x00000014, 32, packed struct {
        /// Backup data
        D6: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR7 = mmio(Address + 0x00000018, 32, packed struct {
        /// Backup data
        D7: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR8 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Backup data
        D8: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR9 = mmio(Address + 0x00000020, 32, packed struct {
        /// Backup data
        D9: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR10 = mmio(Address + 0x00000024, 32, packed struct {
        /// Backup data
        D10: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// RTC clock calibration register (BKP_RTCCR)
    pub const RTCCR = mmio(Address + 0x00000028, 32, packed struct {
        /// Calibration value
        CAL: u7 = 0,
        /// Calibration Clock Output
        CCO: u1 = 0,
        /// Alarm or second output enable
        ASOE: u1 = 0,
        /// Alarm or second output selection
        ASOS: u1 = 0,
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

    /// Backup control register (BKP_CR)
    pub const CR = mmio(Address + 0x0000002c, 32, packed struct {
        /// Tamper pin enable
        TPE: u1 = 0,
        /// Tamper pin active level
        TPAL: u1 = 0,
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

    /// BKP_CSR control/status register (BKP_CSR)
    pub const CSR = mmio(Address + 0x00000030, 32, packed struct {
        /// Clear Tamper event
        CTE: u1 = 0,
        /// Clear Tamper Interrupt
        CTI: u1 = 0,
        /// Tamper Pin interrupt enable
        TPIE: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Tamper Event Flag
        TEF: u1 = 0,
        /// Tamper Interrupt Flag
        TIF: u1 = 0,
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

    /// Backup data register (BKP_DR)
    pub const DR11 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Backup data
        DR11: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR12 = mmio(Address + 0x00000040, 32, packed struct {
        /// Backup data
        DR12: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR13 = mmio(Address + 0x00000044, 32, packed struct {
        /// Backup data
        DR13: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR14 = mmio(Address + 0x00000048, 32, packed struct {
        /// Backup data
        D14: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR15 = mmio(Address + 0x0000004c, 32, packed struct {
        /// Backup data
        D15: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR16 = mmio(Address + 0x00000050, 32, packed struct {
        /// Backup data
        D16: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR17 = mmio(Address + 0x00000054, 32, packed struct {
        /// Backup data
        D17: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR18 = mmio(Address + 0x00000058, 32, packed struct {
        /// Backup data
        D18: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR19 = mmio(Address + 0x0000005c, 32, packed struct {
        /// Backup data
        D19: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR20 = mmio(Address + 0x00000060, 32, packed struct {
        /// Backup data
        D20: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR21 = mmio(Address + 0x00000064, 32, packed struct {
        /// Backup data
        D21: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR22 = mmio(Address + 0x00000068, 32, packed struct {
        /// Backup data
        D22: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR23 = mmio(Address + 0x0000006c, 32, packed struct {
        /// Backup data
        D23: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR24 = mmio(Address + 0x00000070, 32, packed struct {
        /// Backup data
        D24: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR25 = mmio(Address + 0x00000074, 32, packed struct {
        /// Backup data
        D25: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR26 = mmio(Address + 0x00000078, 32, packed struct {
        /// Backup data
        D26: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR27 = mmio(Address + 0x0000007c, 32, packed struct {
        /// Backup data
        D27: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR28 = mmio(Address + 0x00000080, 32, packed struct {
        /// Backup data
        D28: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR29 = mmio(Address + 0x00000084, 32, packed struct {
        /// Backup data
        D29: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR30 = mmio(Address + 0x00000088, 32, packed struct {
        /// Backup data
        D30: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR31 = mmio(Address + 0x0000008c, 32, packed struct {
        /// Backup data
        D31: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR32 = mmio(Address + 0x00000090, 32, packed struct {
        /// Backup data
        D32: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR33 = mmio(Address + 0x00000094, 32, packed struct {
        /// Backup data
        D33: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR34 = mmio(Address + 0x00000098, 32, packed struct {
        /// Backup data
        D34: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR35 = mmio(Address + 0x0000009c, 32, packed struct {
        /// Backup data
        D35: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR36 = mmio(Address + 0x000000a0, 32, packed struct {
        /// Backup data
        D36: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR37 = mmio(Address + 0x000000a4, 32, packed struct {
        /// Backup data
        D37: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR38 = mmio(Address + 0x000000a8, 32, packed struct {
        /// Backup data
        D38: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR39 = mmio(Address + 0x000000ac, 32, packed struct {
        /// Backup data
        D39: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR40 = mmio(Address + 0x000000b0, 32, packed struct {
        /// Backup data
        D40: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR41 = mmio(Address + 0x000000b4, 32, packed struct {
        /// Backup data
        D41: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Backup data register (BKP_DR)
    pub const DR42 = mmio(Address + 0x000000b8, 32, packed struct {
        /// Backup data
        D42: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

    /// Key register (IWDG_KR)
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

    /// Prescaler register (IWDG_PR)
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

    /// Reload register (IWDG_RLR)
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

    /// Status register (IWDG_SR)
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Watchdog prescaler value update
        PVU: u1 = 0,
        /// Watchdog counter reload value update
        RVU: u1 = 0,
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

/// Window watchdog
pub const WWDG = extern struct {
    pub const Address: u32 = 0x40002c00;

    /// Control register (WWDG_CR)
    pub const CR = mmio(Address + 0x00000000, 32, packed struct {
        /// 7-bit counter (MSB to LSB)
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

    /// Configuration register (WWDG_CFR)
    pub const CFR = mmio(Address + 0x00000004, 32, packed struct {
        /// 7-bit window value
        W: u7 = 0,
        /// Timer Base
        WDGTB: u2 = 0,
        /// Early Wakeup Interrupt
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

    /// Status register (WWDG_SR)
    pub const SR = mmio(Address + 0x00000008, 32, packed struct {
        /// Early Wakeup Interrupt
        EWI: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        ICPCS: u2 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Capture/Compare value
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
        /// Capture/Compare value
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// Advanced timer
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// External trigger filter
        ETF: u4 = 0,
        /// External trigger prescaler
        ETPS: u2 = 0,
        /// External clock enable
        ECE: u1 = 0,
        /// External trigger polarity
        ETP: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        ICPCS: u2 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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

    /// capture/compare register 3
    pub const CCR3 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Capture/Compare value
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
        /// Capture/Compare value
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
        /// Capture/Compare value
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
        /// Capture/Compare value
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
        /// Capture/Compare value
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
        /// Capture/Compare value
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
        /// Capture/Compare value
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
        /// Capture/Compare value
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
pub const TIM5 = extern struct {
    pub const Address: u32 = 0x40000c00;

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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        /// Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
        /// Capture/Compare value
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
        /// Capture/Compare value
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
pub const TIM9 = extern struct {
    pub const Address: u32 = 0x40014c00;

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

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        reserved1: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
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
        reserved3: u1 = 0,
        reserved2: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// General purpose timer
pub const TIM12 = extern struct {
    pub const Address: u32 = 0x40001800;

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

    /// slave mode control register
    pub const SMCR = mmio(Address + 0x00000008, 32, packed struct {
        /// Slave mode selection
        SMS: u3 = 0,
        reserved1: u1 = 0,
        /// Trigger selection
        TS: u3 = 0,
        /// Master/Slave mode
        MSM: u1 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
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
        reserved3: u1 = 0,
        reserved2: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// General purpose timer
pub const TIM10 = extern struct {
    pub const Address: u32 = 0x40015000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
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

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
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

    /// capture/compare mode register (input mode)
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// General purpose timer
pub const TIM11 = extern struct {
    pub const Address: u32 = 0x40015400;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
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

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
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

    /// capture/compare mode register (input mode)
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// General purpose timer
pub const TIM13 = extern struct {
    pub const Address: u32 = 0x40001c00;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
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

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
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

    /// capture/compare mode register (input mode)
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// General purpose timer
pub const TIM14 = extern struct {
    pub const Address: u32 = 0x40002000;

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Counter enable
        CEN: u1 = 0,
        /// Update disable
        UDIS: u1 = 0,
        /// Update request source
        URS: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Auto-reload preload enable
        ARPE: u1 = 0,
        /// Clock division
        CKD: u2 = 0,
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
        /// Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
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

    /// status register
    pub const SR = mmio(Address + 0x00000010, 32, packed struct {
        /// Update interrupt flag
        UIF: u1 = 0,
        /// Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        reserved7: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
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

    /// capture/compare mode register (output mode)
    pub const CCMR1_Output = mmio(Address + 0x00000018, 32, packed struct {
        /// Capture/Compare 1 selection
        CC1S: u2 = 0,
        reserved1: u1 = 0,
        /// Output Compare 1 preload enable
        OC1PE: u1 = 0,
        /// Output Compare 1 mode
        OC1M: u3 = 0,
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

    /// capture/compare mode register (input mode)
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
        reserved1: u1 = 0,
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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
};

/// Basic timer
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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

/// Basic timer
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
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
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

/// Inter integrated circuit
pub const I2C1 = extern struct {
    pub const Address: u32 = 0x40005400;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Peripheral enable
        PE: u1 = 0,
        /// SMBus mode
        SMBUS: u1 = 0,
        reserved1: u1 = 0,
        /// SMBus type
        SMBTYPE: u1 = 0,
        /// ARP enable
        ENARP: u1 = 0,
        /// PEC enable
        ENPEC: u1 = 0,
        /// General call enable
        ENGC: u1 = 0,
        /// Clock stretching disable (Slave mode)
        NOSTRETCH: u1 = 0,
        /// Start generation
        START: u1 = 0,
        /// Stop generation
        STOP: u1 = 0,
        /// Acknowledge enable
        ACK: u1 = 0,
        /// Acknowledge/PEC Position (for data reception)
        POS: u1 = 0,
        /// Packet error checking
        PEC: u1 = 0,
        /// SMBus alert
        ALERT: u1 = 0,
        reserved2: u1 = 0,
        /// Software reset
        SWRST: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Peripheral clock frequency
        FREQ: u6 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Error interrupt enable
        ITERREN: u1 = 0,
        /// Event interrupt enable
        ITEVTEN: u1 = 0,
        /// Buffer interrupt enable
        ITBUFEN: u1 = 0,
        /// DMA requests enable
        DMAEN: u1 = 0,
        /// DMA last transfer
        LAST: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Interface address
        ADD0: u1 = 0,
        /// Interface address
        ADD7: u7 = 0,
        /// Interface address
        ADD10: u2 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Addressing mode (slave mode)
        ADDMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Dual addressing mode enable
        ENDUAL: u1 = 0,
        /// Interface address
        ADD2: u7 = 0,
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

    /// Data register
    pub const DR = mmio(Address + 0x00000010, 32, packed struct {
        /// 8-bit data register
        DR: u8 = 0,
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

    /// Status register 1
    pub const SR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Start bit (Master mode)
        SB: u1 = 0,
        /// Address sent (master mode)/matched (slave mode)
        ADDR: u1 = 0,
        /// Byte transfer finished
        BTF: u1 = 0,
        /// 10-bit header sent (Master mode)
        ADD10: u1 = 0,
        /// Stop detection (slave mode)
        STOPF: u1 = 0,
        reserved1: u1 = 0,
        /// Data register not empty (receivers)
        RxNE: u1 = 0,
        /// Data register empty (transmitters)
        TxE: u1 = 0,
        /// Bus error
        BERR: u1 = 0,
        /// Arbitration lost (master mode)
        ARLO: u1 = 0,
        /// Acknowledge failure
        AF: u1 = 0,
        /// Overrun/Underrun
        OVR: u1 = 0,
        /// PEC Error in reception
        PECERR: u1 = 0,
        reserved2: u1 = 0,
        /// Timeout or Tlow error
        TIMEOUT: u1 = 0,
        /// SMBus alert
        SMBALERT: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status register 2
    pub const SR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Master/slave
        MSL: u1 = 0,
        /// Bus busy
        BUSY: u1 = 0,
        /// Transmitter/receiver
        TRA: u1 = 0,
        reserved1: u1 = 0,
        /// General call address (Slave mode)
        GENCALL: u1 = 0,
        /// SMBus device default address (Slave mode)
        SMBDEFAULT: u1 = 0,
        /// SMBus host header (Slave mode)
        SMBHOST: u1 = 0,
        /// Dual flag (Slave mode)
        DUALF: u1 = 0,
        /// acket error checking register
        PEC: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock control register
    pub const CCR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Clock control register in Fast/Standard mode (Master mode)
        CCR: u12 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Fast mode duty cycle
        DUTY: u1 = 0,
        /// I2C master mode selection
        F_S: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TRISE register
    pub const TRISE = mmio(Address + 0x00000020, 32, packed struct {
        /// Maximum rise time in Fast/Standard mode (Master mode)
        TRISE: u6 = 0,
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

/// Inter integrated circuit
pub const I2C2 = extern struct {
    pub const Address: u32 = 0x40005800;

    /// Control register 1
    pub const CR1 = mmio(Address + 0x00000000, 32, packed struct {
        /// Peripheral enable
        PE: u1 = 0,
        /// SMBus mode
        SMBUS: u1 = 0,
        reserved1: u1 = 0,
        /// SMBus type
        SMBTYPE: u1 = 0,
        /// ARP enable
        ENARP: u1 = 0,
        /// PEC enable
        ENPEC: u1 = 0,
        /// General call enable
        ENGC: u1 = 0,
        /// Clock stretching disable (Slave mode)
        NOSTRETCH: u1 = 0,
        /// Start generation
        START: u1 = 0,
        /// Stop generation
        STOP: u1 = 0,
        /// Acknowledge enable
        ACK: u1 = 0,
        /// Acknowledge/PEC Position (for data reception)
        POS: u1 = 0,
        /// Packet error checking
        PEC: u1 = 0,
        /// SMBus alert
        ALERT: u1 = 0,
        reserved2: u1 = 0,
        /// Software reset
        SWRST: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Peripheral clock frequency
        FREQ: u6 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Error interrupt enable
        ITERREN: u1 = 0,
        /// Event interrupt enable
        ITEVTEN: u1 = 0,
        /// Buffer interrupt enable
        ITBUFEN: u1 = 0,
        /// DMA requests enable
        DMAEN: u1 = 0,
        /// DMA last transfer
        LAST: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Own address register 1
    pub const OAR1 = mmio(Address + 0x00000008, 32, packed struct {
        /// Interface address
        ADD0: u1 = 0,
        /// Interface address
        ADD7: u7 = 0,
        /// Interface address
        ADD10: u2 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Addressing mode (slave mode)
        ADDMODE: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Dual addressing mode enable
        ENDUAL: u1 = 0,
        /// Interface address
        ADD2: u7 = 0,
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

    /// Data register
    pub const DR = mmio(Address + 0x00000010, 32, packed struct {
        /// 8-bit data register
        DR: u8 = 0,
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

    /// Status register 1
    pub const SR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Start bit (Master mode)
        SB: u1 = 0,
        /// Address sent (master mode)/matched (slave mode)
        ADDR: u1 = 0,
        /// Byte transfer finished
        BTF: u1 = 0,
        /// 10-bit header sent (Master mode)
        ADD10: u1 = 0,
        /// Stop detection (slave mode)
        STOPF: u1 = 0,
        reserved1: u1 = 0,
        /// Data register not empty (receivers)
        RxNE: u1 = 0,
        /// Data register empty (transmitters)
        TxE: u1 = 0,
        /// Bus error
        BERR: u1 = 0,
        /// Arbitration lost (master mode)
        ARLO: u1 = 0,
        /// Acknowledge failure
        AF: u1 = 0,
        /// Overrun/Underrun
        OVR: u1 = 0,
        /// PEC Error in reception
        PECERR: u1 = 0,
        reserved2: u1 = 0,
        /// Timeout or Tlow error
        TIMEOUT: u1 = 0,
        /// SMBus alert
        SMBALERT: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Status register 2
    pub const SR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Master/slave
        MSL: u1 = 0,
        /// Bus busy
        BUSY: u1 = 0,
        /// Transmitter/receiver
        TRA: u1 = 0,
        reserved1: u1 = 0,
        /// General call address (Slave mode)
        GENCALL: u1 = 0,
        /// SMBus device default address (Slave mode)
        SMBDEFAULT: u1 = 0,
        /// SMBus host header (Slave mode)
        SMBHOST: u1 = 0,
        /// Dual flag (Slave mode)
        DUALF: u1 = 0,
        /// acket error checking register
        PEC: u8 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Clock control register
    pub const CCR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Clock control register in Fast/Standard mode (Master mode)
        CCR: u12 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Fast mode duty cycle
        DUTY: u1 = 0,
        /// I2C master mode selection
        F_S: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// TRISE register
    pub const TRISE = mmio(Address + 0x00000020, 32, packed struct {
        /// Maximum rise time in Fast/Standard mode (Master mode)
        TRISE: u6 = 0,
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

/// Serial peripheral interface
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
        /// Data frame format
        DFF: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
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

/// Serial peripheral interface
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
        /// Data frame format
        DFF: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
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

/// Serial peripheral interface
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
        /// Data frame format
        DFF: u1 = 0,
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
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Error interrupt enable
        ERRIE: u1 = 0,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
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

/// Universal synchronous asynchronous receiver transmitter
pub const USART1 = extern struct {
    pub const Address: u32 = 0x40013800;

    /// Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise error flag
        NE: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
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

    /// Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        /// Data value
        DR: u9 = 0,
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

    /// Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
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

    /// Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Send break
        SBK: u1 = 0,
        /// Receiver wakeup
        RWU: u1 = 0,
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
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// USART enable
        UE: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Address of the USART node
        ADD: u4 = 0,
        reserved1: u1 = 0,
        /// lin break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved2: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
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

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
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
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART2 = extern struct {
    pub const Address: u32 = 0x40004400;

    /// Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise error flag
        NE: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
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

    /// Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        /// Data value
        DR: u9 = 0,
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

    /// Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
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

    /// Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Send break
        SBK: u1 = 0,
        /// Receiver wakeup
        RWU: u1 = 0,
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
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// USART enable
        UE: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Address of the USART node
        ADD: u4 = 0,
        reserved1: u1 = 0,
        /// lin break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved2: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
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

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
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
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART3 = extern struct {
    pub const Address: u32 = 0x40004800;

    /// Status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise error flag
        NE: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBD: u1 = 0,
        /// CTS flag
        CTS: u1 = 0,
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

    /// Data register
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
        /// Data value
        DR: u9 = 0,
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

    /// Baud rate register
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
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

    /// Control register 1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Send break
        SBK: u1 = 0,
        /// Receiver wakeup
        RWU: u1 = 0,
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
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// USART enable
        UE: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Address of the USART node
        ADD: u4 = 0,
        reserved1: u1 = 0,
        /// lin break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved2: u1 = 0,
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
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Control register 3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
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

    /// Guard time and prescaler register
    pub const GTPR = mmio(Address + 0x00000018, 32, packed struct {
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
};

/// Analog to digital converter
pub const ADC1 = extern struct {
    pub const Address: u32 = 0x40012400;

    /// status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// Regular channel end of conversion
        EOC: u1 = 0,
        /// Injected channel end of conversion
        JEOC: u1 = 0,
        /// Injected channel start flag
        JSTRT: u1 = 0,
        /// Regular channel start flag
        STRT: u1 = 0,
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

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        /// Analog watchdog channel select bits
        AWDCH: u5 = 0,
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// Analog watchdog interrupt enable
        AWDIE: u1 = 0,
        /// Interrupt enable for injected channels
        JEOCIE: u1 = 0,
        /// Scan mode
        SCAN: u1 = 0,
        /// Enable the watchdog on a single channel in scan mode
        AWDSGL: u1 = 0,
        /// Automatic injected group conversion
        JAUTO: u1 = 0,
        /// Discontinuous mode on regular channels
        DISCEN: u1 = 0,
        /// Discontinuous mode on injected channels
        JDISCEN: u1 = 0,
        /// Discontinuous mode channel count
        DISCNUM: u3 = 0,
        /// Dual mode selection
        DUALMOD: u4 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Analog watchdog enable on injected channels
        JAWDEN: u1 = 0,
        /// Analog watchdog enable on regular channels
        AWDEN: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// Continuous conversion
        CONT: u1 = 0,
        /// A/D calibration
        CAL: u1 = 0,
        /// Reset calibration
        RSTCAL: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Direct memory access mode
        DMA: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Data alignment
        ALIGN: u1 = 0,
        /// External event select for injected group
        JEXTSEL: u3 = 0,
        /// External trigger conversion mode for injected channels
        JEXTTRIG: u1 = 0,
        reserved7: u1 = 0,
        /// External event select for regular group
        EXTSEL: u3 = 0,
        /// External trigger conversion mode for regular channels
        EXTTRIG: u1 = 0,
        /// Start conversion of injected channels
        JSWSTART: u1 = 0,
        /// Start conversion of regular channels
        SWSTART: u1 = 0,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Channel 10 sample time selection
        SMP10: u3 = 0,
        /// Channel 11 sample time selection
        SMP11: u3 = 0,
        /// Channel 12 sample time selection
        SMP12: u3 = 0,
        /// Channel 13 sample time selection
        SMP13: u3 = 0,
        /// Channel 14 sample time selection
        SMP14: u3 = 0,
        /// Channel 15 sample time selection
        SMP15: u3 = 0,
        /// Channel 16 sample time selection
        SMP16: u3 = 0,
        /// Channel 17 sample time selection
        SMP17: u3 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Channel 0 sample time selection
        SMP0: u3 = 0,
        /// Channel 1 sample time selection
        SMP1: u3 = 0,
        /// Channel 2 sample time selection
        SMP2: u3 = 0,
        /// Channel 3 sample time selection
        SMP3: u3 = 0,
        /// Channel 4 sample time selection
        SMP4: u3 = 0,
        /// Channel 5 sample time selection
        SMP5: u3 = 0,
        /// Channel 6 sample time selection
        SMP6: u3 = 0,
        /// Channel 7 sample time selection
        SMP7: u3 = 0,
        /// Channel 8 sample time selection
        SMP8: u3 = 0,
        /// Channel 9 sample time selection
        SMP9: u3 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET1: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET2: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET3: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET4: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        /// Analog watchdog higher threshold
        HT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        /// Analog watchdog lower threshold
        LT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        /// 13th conversion in regular sequence
        SQ13: u5 = 0,
        /// 14th conversion in regular sequence
        SQ14: u5 = 0,
        /// 15th conversion in regular sequence
        SQ15: u5 = 0,
        /// 16th conversion in regular sequence
        SQ16: u5 = 0,
        /// Regular channel sequence length
        L: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        /// 7th conversion in regular sequence
        SQ7: u5 = 0,
        /// 8th conversion in regular sequence
        SQ8: u5 = 0,
        /// 9th conversion in regular sequence
        SQ9: u5 = 0,
        /// 10th conversion in regular sequence
        SQ10: u5 = 0,
        /// 11th conversion in regular sequence
        SQ11: u5 = 0,
        /// 12th conversion in regular sequence
        SQ12: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        /// 1st conversion in regular sequence
        SQ1: u5 = 0,
        /// 2nd conversion in regular sequence
        SQ2: u5 = 0,
        /// 3rd conversion in regular sequence
        SQ3: u5 = 0,
        /// 4th conversion in regular sequence
        SQ4: u5 = 0,
        /// 5th conversion in regular sequence
        SQ5: u5 = 0,
        /// 6th conversion in regular sequence
        SQ6: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        /// 1st conversion in injected sequence
        JSQ1: u5 = 0,
        /// 2nd conversion in injected sequence
        JSQ2: u5 = 0,
        /// 3rd conversion in injected sequence
        JSQ3: u5 = 0,
        /// 4th conversion in injected sequence
        JSQ4: u5 = 0,
        /// Injected sequence length
        JL: u2 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        /// Regular data
        DATA: u16 = 0,
        /// ADC2 data
        ADC2DATA: u16 = 0,
    });
};

/// Analog to digital converter
pub const ADC2 = extern struct {
    pub const Address: u32 = 0x40012800;

    /// status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// Regular channel end of conversion
        EOC: u1 = 0,
        /// Injected channel end of conversion
        JEOC: u1 = 0,
        /// Injected channel start flag
        JSTRT: u1 = 0,
        /// Regular channel start flag
        STRT: u1 = 0,
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

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        /// Analog watchdog channel select bits
        AWDCH: u5 = 0,
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// Analog watchdog interrupt enable
        AWDIE: u1 = 0,
        /// Interrupt enable for injected channels
        JEOCIE: u1 = 0,
        /// Scan mode
        SCAN: u1 = 0,
        /// Enable the watchdog on a single channel in scan mode
        AWDSGL: u1 = 0,
        /// Automatic injected group conversion
        JAUTO: u1 = 0,
        /// Discontinuous mode on regular channels
        DISCEN: u1 = 0,
        /// Discontinuous mode on injected channels
        JDISCEN: u1 = 0,
        /// Discontinuous mode channel count
        DISCNUM: u3 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Analog watchdog enable on injected channels
        JAWDEN: u1 = 0,
        /// Analog watchdog enable on regular channels
        AWDEN: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// Continuous conversion
        CONT: u1 = 0,
        /// A/D calibration
        CAL: u1 = 0,
        /// Reset calibration
        RSTCAL: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Direct memory access mode
        DMA: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Data alignment
        ALIGN: u1 = 0,
        /// External event select for injected group
        JEXTSEL: u3 = 0,
        /// External trigger conversion mode for injected channels
        JEXTTRIG: u1 = 0,
        reserved7: u1 = 0,
        /// External event select for regular group
        EXTSEL: u3 = 0,
        /// External trigger conversion mode for regular channels
        EXTTRIG: u1 = 0,
        /// Start conversion of injected channels
        JSWSTART: u1 = 0,
        /// Start conversion of regular channels
        SWSTART: u1 = 0,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Channel 10 sample time selection
        SMP10: u3 = 0,
        /// Channel 11 sample time selection
        SMP11: u3 = 0,
        /// Channel 12 sample time selection
        SMP12: u3 = 0,
        /// Channel 13 sample time selection
        SMP13: u3 = 0,
        /// Channel 14 sample time selection
        SMP14: u3 = 0,
        /// Channel 15 sample time selection
        SMP15: u3 = 0,
        /// Channel 16 sample time selection
        SMP16: u3 = 0,
        /// Channel 17 sample time selection
        SMP17: u3 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Channel 0 sample time selection
        SMP0: u3 = 0,
        /// Channel 1 sample time selection
        SMP1: u3 = 0,
        /// Channel 2 sample time selection
        SMP2: u3 = 0,
        /// Channel 3 sample time selection
        SMP3: u3 = 0,
        /// Channel 4 sample time selection
        SMP4: u3 = 0,
        /// Channel 5 sample time selection
        SMP5: u3 = 0,
        /// Channel 6 sample time selection
        SMP6: u3 = 0,
        /// Channel 7 sample time selection
        SMP7: u3 = 0,
        /// Channel 8 sample time selection
        SMP8: u3 = 0,
        /// Channel 9 sample time selection
        SMP9: u3 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET1: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET2: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET3: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET4: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        /// Analog watchdog higher threshold
        HT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        /// Analog watchdog lower threshold
        LT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        /// 13th conversion in regular sequence
        SQ13: u5 = 0,
        /// 14th conversion in regular sequence
        SQ14: u5 = 0,
        /// 15th conversion in regular sequence
        SQ15: u5 = 0,
        /// 16th conversion in regular sequence
        SQ16: u5 = 0,
        /// Regular channel sequence length
        L: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        /// 7th conversion in regular sequence
        SQ7: u5 = 0,
        /// 8th conversion in regular sequence
        SQ8: u5 = 0,
        /// 9th conversion in regular sequence
        SQ9: u5 = 0,
        /// 10th conversion in regular sequence
        SQ10: u5 = 0,
        /// 11th conversion in regular sequence
        SQ11: u5 = 0,
        /// 12th conversion in regular sequence
        SQ12: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        /// 1st conversion in regular sequence
        SQ1: u5 = 0,
        /// 2nd conversion in regular sequence
        SQ2: u5 = 0,
        /// 3rd conversion in regular sequence
        SQ3: u5 = 0,
        /// 4th conversion in regular sequence
        SQ4: u5 = 0,
        /// 5th conversion in regular sequence
        SQ5: u5 = 0,
        /// 6th conversion in regular sequence
        SQ6: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        /// 1st conversion in injected sequence
        JSQ1: u5 = 0,
        /// 2nd conversion in injected sequence
        JSQ2: u5 = 0,
        /// 3rd conversion in injected sequence
        JSQ3: u5 = 0,
        /// 4th conversion in injected sequence
        JSQ4: u5 = 0,
        /// Injected sequence length
        JL: u2 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        /// Regular data
        DATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// Analog to digital converter
pub const ADC3 = extern struct {
    pub const Address: u32 = 0x40013c00;

    /// status register
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Analog watchdog flag
        AWD: u1 = 0,
        /// Regular channel end of conversion
        EOC: u1 = 0,
        /// Injected channel end of conversion
        JEOC: u1 = 0,
        /// Injected channel start flag
        JSTRT: u1 = 0,
        /// Regular channel start flag
        STRT: u1 = 0,
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

    /// control register 1
    pub const CR1 = mmio(Address + 0x00000004, 32, packed struct {
        /// Analog watchdog channel select bits
        AWDCH: u5 = 0,
        /// Interrupt enable for EOC
        EOCIE: u1 = 0,
        /// Analog watchdog interrupt enable
        AWDIE: u1 = 0,
        /// Interrupt enable for injected channels
        JEOCIE: u1 = 0,
        /// Scan mode
        SCAN: u1 = 0,
        /// Enable the watchdog on a single channel in scan mode
        AWDSGL: u1 = 0,
        /// Automatic injected group conversion
        JAUTO: u1 = 0,
        /// Discontinuous mode on regular channels
        DISCEN: u1 = 0,
        /// Discontinuous mode on injected channels
        JDISCEN: u1 = 0,
        /// Discontinuous mode channel count
        DISCNUM: u3 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Analog watchdog enable on injected channels
        JAWDEN: u1 = 0,
        /// Analog watchdog enable on regular channels
        AWDEN: u1 = 0,
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
    pub const CR2 = mmio(Address + 0x00000008, 32, packed struct {
        /// A/D converter ON / OFF
        ADON: u1 = 0,
        /// Continuous conversion
        CONT: u1 = 0,
        /// A/D calibration
        CAL: u1 = 0,
        /// Reset calibration
        RSTCAL: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// Direct memory access mode
        DMA: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        /// Data alignment
        ALIGN: u1 = 0,
        /// External event select for injected group
        JEXTSEL: u3 = 0,
        /// External trigger conversion mode for injected channels
        JEXTTRIG: u1 = 0,
        reserved7: u1 = 0,
        /// External event select for regular group
        EXTSEL: u3 = 0,
        /// External trigger conversion mode for regular channels
        EXTTRIG: u1 = 0,
        /// Start conversion of injected channels
        JSWSTART: u1 = 0,
        /// Start conversion of regular channels
        SWSTART: u1 = 0,
        /// Temperature sensor and VREFINT enable
        TSVREFE: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 1
    pub const SMPR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Channel 10 sample time selection
        SMP10: u3 = 0,
        /// Channel 11 sample time selection
        SMP11: u3 = 0,
        /// Channel 12 sample time selection
        SMP12: u3 = 0,
        /// Channel 13 sample time selection
        SMP13: u3 = 0,
        /// Channel 14 sample time selection
        SMP14: u3 = 0,
        /// Channel 15 sample time selection
        SMP15: u3 = 0,
        /// Channel 16 sample time selection
        SMP16: u3 = 0,
        /// Channel 17 sample time selection
        SMP17: u3 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// sample time register 2
    pub const SMPR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Channel 0 sample time selection
        SMP0: u3 = 0,
        /// Channel 1 sample time selection
        SMP1: u3 = 0,
        /// Channel 2 sample time selection
        SMP2: u3 = 0,
        /// Channel 3 sample time selection
        SMP3: u3 = 0,
        /// Channel 4 sample time selection
        SMP4: u3 = 0,
        /// Channel 5 sample time selection
        SMP5: u3 = 0,
        /// Channel 6 sample time selection
        SMP6: u3 = 0,
        /// Channel 7 sample time selection
        SMP7: u3 = 0,
        /// Channel 8 sample time selection
        SMP8: u3 = 0,
        /// Channel 9 sample time selection
        SMP9: u3 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR1 = mmio(Address + 0x00000014, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET1: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR2 = mmio(Address + 0x00000018, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET2: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR3 = mmio(Address + 0x0000001c, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET3: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected channel data offset register x
    pub const JOFR4 = mmio(Address + 0x00000020, 32, packed struct {
        /// Data offset for injected channel x
        JOFFSET4: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog higher threshold register
    pub const HTR = mmio(Address + 0x00000024, 32, packed struct {
        /// Analog watchdog higher threshold
        HT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// watchdog lower threshold register
    pub const LTR = mmio(Address + 0x00000028, 32, packed struct {
        /// Analog watchdog lower threshold
        LT: u12 = 0,
        padding20: u1 = 0,
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
    pub const SQR1 = mmio(Address + 0x0000002c, 32, packed struct {
        /// 13th conversion in regular sequence
        SQ13: u5 = 0,
        /// 14th conversion in regular sequence
        SQ14: u5 = 0,
        /// 15th conversion in regular sequence
        SQ15: u5 = 0,
        /// 16th conversion in regular sequence
        SQ16: u5 = 0,
        /// Regular channel sequence length
        L: u4 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 2
    pub const SQR2 = mmio(Address + 0x00000030, 32, packed struct {
        /// 7th conversion in regular sequence
        SQ7: u5 = 0,
        /// 8th conversion in regular sequence
        SQ8: u5 = 0,
        /// 9th conversion in regular sequence
        SQ9: u5 = 0,
        /// 10th conversion in regular sequence
        SQ10: u5 = 0,
        /// 11th conversion in regular sequence
        SQ11: u5 = 0,
        /// 12th conversion in regular sequence
        SQ12: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular sequence register 3
    pub const SQR3 = mmio(Address + 0x00000034, 32, packed struct {
        /// 1st conversion in regular sequence
        SQ1: u5 = 0,
        /// 2nd conversion in regular sequence
        SQ2: u5 = 0,
        /// 3rd conversion in regular sequence
        SQ3: u5 = 0,
        /// 4th conversion in regular sequence
        SQ4: u5 = 0,
        /// 5th conversion in regular sequence
        SQ5: u5 = 0,
        /// 6th conversion in regular sequence
        SQ6: u5 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected sequence register
    pub const JSQR = mmio(Address + 0x00000038, 32, packed struct {
        /// 1st conversion in injected sequence
        JSQ1: u5 = 0,
        /// 2nd conversion in injected sequence
        JSQ2: u5 = 0,
        /// 3rd conversion in injected sequence
        JSQ3: u5 = 0,
        /// 4th conversion in injected sequence
        JSQ4: u5 = 0,
        /// Injected sequence length
        JL: u2 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR1 = mmio(Address + 0x0000003c, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR2 = mmio(Address + 0x00000040, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR3 = mmio(Address + 0x00000044, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// injected data register x
    pub const JDR4 = mmio(Address + 0x00000048, 32, packed struct {
        /// Injected data
        JDATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// regular data register
    pub const DR = mmio(Address + 0x0000004c, 32, packed struct {
        /// Regular data
        DATA: u16 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

    /// CAN_MCR
    pub const CAN_MCR = mmio(Address + 0x00000000, 32, packed struct {
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

    /// CAN_MSR
    pub const CAN_MSR = mmio(Address + 0x00000004, 32, packed struct {
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

    /// CAN_TSR
    pub const CAN_TSR = mmio(Address + 0x00000008, 32, packed struct {
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

    /// CAN_RF0R
    pub const CAN_RF0R = mmio(Address + 0x0000000c, 32, packed struct {
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

    /// CAN_RF1R
    pub const CAN_RF1R = mmio(Address + 0x00000010, 32, packed struct {
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

    /// CAN_IER
    pub const CAN_IER = mmio(Address + 0x00000014, 32, packed struct {
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

    /// CAN_ESR
    pub const CAN_ESR = mmio(Address + 0x00000018, 32, packed struct {
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

    /// CAN_BTR
    pub const CAN_BTR = mmio(Address + 0x0000001c, 32, packed struct {
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

    /// CAN_TI0R
    pub const CAN_TI0R = mmio(Address + 0x00000180, 32, packed struct {});

    /// CAN_TDT0R
    pub const CAN_TDT0R = mmio(Address + 0x00000184, 32, packed struct {
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

    /// CAN_TDL0R
    pub const CAN_TDL0R = mmio(Address + 0x00000188, 32, packed struct {});

    /// CAN_TDH0R
    pub const CAN_TDH0R = mmio(Address + 0x0000018c, 32, packed struct {});

    /// CAN_TI1R
    pub const CAN_TI1R = mmio(Address + 0x00000190, 32, packed struct {});

    /// CAN_TDT1R
    pub const CAN_TDT1R = mmio(Address + 0x00000194, 32, packed struct {
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

    /// CAN_TDL1R
    pub const CAN_TDL1R = mmio(Address + 0x00000198, 32, packed struct {});

    /// CAN_TDH1R
    pub const CAN_TDH1R = mmio(Address + 0x0000019c, 32, packed struct {});

    /// CAN_TI2R
    pub const CAN_TI2R = mmio(Address + 0x000001a0, 32, packed struct {});

    /// CAN_TDT2R
    pub const CAN_TDT2R = mmio(Address + 0x000001a4, 32, packed struct {
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

    /// CAN_TDL2R
    pub const CAN_TDL2R = mmio(Address + 0x000001a8, 32, packed struct {});

    /// CAN_TDH2R
    pub const CAN_TDH2R = mmio(Address + 0x000001ac, 32, packed struct {});

    /// CAN_RI0R
    pub const CAN_RI0R = mmio(Address + 0x000001b0, 32, packed struct {
        reserved1: u1 = 0,
    });

    /// CAN_RDT0R
    pub const CAN_RDT0R = mmio(Address + 0x000001b4, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// CAN_RDL0R
    pub const CAN_RDL0R = mmio(Address + 0x000001b8, 32, packed struct {});

    /// CAN_RDH0R
    pub const CAN_RDH0R = mmio(Address + 0x000001bc, 32, packed struct {});

    /// CAN_RI1R
    pub const CAN_RI1R = mmio(Address + 0x000001c0, 32, packed struct {
        reserved1: u1 = 0,
    });

    /// CAN_RDT1R
    pub const CAN_RDT1R = mmio(Address + 0x000001c4, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// CAN_RDL1R
    pub const CAN_RDL1R = mmio(Address + 0x000001c8, 32, packed struct {});

    /// CAN_RDH1R
    pub const CAN_RDH1R = mmio(Address + 0x000001cc, 32, packed struct {});

    /// CAN_FMR
    pub const CAN_FMR = mmio(Address + 0x00000200, 32, packed struct {
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

    /// CAN_FM1R
    pub const CAN_FM1R = mmio(Address + 0x00000204, 32, packed struct {
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CAN_FS1R
    pub const CAN_FS1R = mmio(Address + 0x0000020c, 32, packed struct {
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CAN_FFA1R
    pub const CAN_FFA1R = mmio(Address + 0x00000214, 32, packed struct {
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// CAN_FA1R
    pub const CAN_FA1R = mmio(Address + 0x0000021c, 32, packed struct {
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
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
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
};

/// Digital to analog converter
pub const DAC = extern struct {
    pub const Address: u32 = 0x40007400;

    /// Control register (DAC_CR)
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
        reserved3: u1 = 0,
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
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// DAC software trigger register (DAC_SWTRIGR)
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

    /// DAC channel1 12-bit right-aligned data holding register(DAC_DHR12R1)
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

    /// DAC channel1 12-bit left aligned data holding register (DAC_DHR12L1)
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

    /// DAC channel1 8-bit right aligned data holding register (DAC_DHR8R1)
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

    /// DAC channel2 12-bit right aligned data holding register (DAC_DHR12R2)
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

    /// DAC channel2 12-bit left aligned data holding register (DAC_DHR12L2)
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

    /// DAC channel2 8-bit right-aligned data holding register (DAC_DHR8R2)
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

    /// Dual DAC 12-bit right-aligned data holding register (DAC_DHR12RD), Bits
    /// 31:28 Reserved, Bits 15:12 Reserved
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

    /// DUAL DAC 12-bit left aligned data holding register (DAC_DHR12LD), Bits 19:16
    /// Reserved, Bits 3:0 Reserved
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
        /// DAC channel2 12-bit right-aligned data
        DACC2DHR: u12 = 0,
    });

    /// DUAL DAC 8-bit right aligned data holding register (DAC_DHR8RD), Bits 31:16
    /// Reserved
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

    /// DAC channel1 data output register (DAC_DOR1)
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

    /// DAC channel2 data output register (DAC_DOR2)
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
};

/// Debug support
pub const DBG = extern struct {
    pub const Address: u32 = 0xe0042000;

    /// DBGMCU_IDCODE
    pub const IDCODE = mmio(Address + 0x00000000, 32, packed struct {
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
    });

    /// DBGMCU_CR
    pub const CR = mmio(Address + 0x00000004, 32, packed struct {
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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

/// Universal asynchronous receiver transmitter
pub const UART4 = extern struct {
    pub const Address: u32 = 0x40004c00;

    /// UART4_SR
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
        /// Parity error
        PE: u1 = 0,
        /// Framing error
        FE: u1 = 0,
        /// Noise error flag
        NE: u1 = 0,
        /// Overrun error
        ORE: u1 = 0,
        /// IDLE line detected
        IDLE: u1 = 0,
        /// Read data register not empty
        RXNE: u1 = 0,
        /// Transmission complete
        TC: u1 = 0,
        /// Transmit data register empty
        TXE: u1 = 0,
        /// LIN break detection flag
        LBD: u1 = 0,
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

    /// UART4_DR
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
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

    /// UART4_BRR
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        /// Send break
        SBK: u1 = 0,
        /// Receiver wakeup
        RWU: u1 = 0,
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
        /// TXE interrupt enable
        TXEIE: u1 = 0,
        /// PE interrupt enable
        PEIE: u1 = 0,
        /// Parity selection
        PS: u1 = 0,
        /// Parity control enable
        PCE: u1 = 0,
        /// Wakeup method
        WAKE: u1 = 0,
        /// Word length
        M: u1 = 0,
        /// USART enable
        UE: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        /// Address of the USART node
        ADD: u4 = 0,
        reserved1: u1 = 0,
        /// lin break detection length
        LBDL: u1 = 0,
        /// LIN break detection interrupt enable
        LBDIE: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        /// STOP bits
        STOP: u2 = 0,
        /// LIN mode enable
        LINEN: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA enable receiver
        DMAR: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
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

/// Universal asynchronous receiver transmitter
pub const UART5 = extern struct {
    pub const Address: u32 = 0x40005000;

    /// UART4_SR
    pub const SR = mmio(Address + 0x00000000, 32, packed struct {
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

    /// UART4_DR
    pub const DR = mmio(Address + 0x00000004, 32, packed struct {
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

    /// UART4_BRR
    pub const BRR = mmio(Address + 0x00000008, 32, packed struct {
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR1
    pub const CR1 = mmio(Address + 0x0000000c, 32, packed struct {
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR2
    pub const CR2 = mmio(Address + 0x00000010, 32, packed struct {
        reserved1: u1 = 0,
        reserved6: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
        padding8: u1 = 0,
        padding7: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// UART4_CR3
    pub const CR3 = mmio(Address + 0x00000014, 32, packed struct {
        /// Error interrupt enable
        EIE: u1 = 0,
        /// IrDA mode enable
        IREN: u1 = 0,
        /// IrDA low-power
        IRLP: u1 = 0,
        /// Half-duplex selection
        HDSEL: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        /// DMA enable transmitter
        DMAT: u1 = 0,
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

/// CRC calculation unit
pub const CRC = extern struct {
    pub const Address: u32 = 0x40023000;

    /// Data register
    pub const DR = @intToPtr(*volatile u32, Address + 0x00000000);

    /// Independent Data register
    pub const IDR = mmio(Address + 0x00000004, 32, packed struct {
        /// Independent Data register
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
        /// Reset bit
        RESET: u1 = 0,
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

/// FLASH
pub const FLASH = extern struct {
    pub const Address: u32 = 0x40022000;

    /// Flash access control register
    pub const ACR = mmio(Address + 0x00000000, 32, packed struct {
        /// Latency
        LATENCY: u3 = 0,
        /// Flash half cycle access enable
        HLFCYA: u1 = 0,
        /// Prefetch buffer enable
        PRFTBE: u1 = 0,
        /// Prefetch buffer status
        PRFTBS: u1 = 0,
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
        /// FPEC key
        KEY: u32 = 0,
    });

    /// Flash option key register
    pub const OPTKEYR = mmio(Address + 0x00000008, 32, packed struct {
        /// Option byte key
        OPTKEY: u32 = 0,
    });

    /// Status register
    pub const SR = mmio(Address + 0x0000000c, 32, packed struct {
        /// Busy
        BSY: u1 = 0,
        reserved1: u1 = 0,
        /// Programming error
        PGERR: u1 = 0,
        reserved2: u1 = 0,
        /// Write protection error
        WRPRTERR: u1 = 0,
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

    /// Control register
    pub const CR = mmio(Address + 0x00000010, 32, packed struct {
        /// Programming
        PG: u1 = 0,
        /// Page Erase
        PER: u1 = 0,
        /// Mass Erase
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
        padding19: u1 = 0,
        padding18: u1 = 0,
        padding17: u1 = 0,
        padding16: u1 = 0,
        padding15: u1 = 0,
        padding14: u1 = 0,
        padding13: u1 = 0,
        padding12: u1 = 0,
        padding11: u1 = 0,
        padding10: u1 = 0,
        padding9: u1 = 0,
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
        /// Flash Address
        FAR: u32 = 0,
    });

    /// Option byte register
    pub const OBR = mmio(Address + 0x0000001c, 32, packed struct {
        /// Option byte error
        OPTERR: u1 = 0,
        /// Read protection
        RDPRT: u1 = 0,
        reserved5: u1 = 0,
        reserved4: u1 = 0,
        reserved3: u1 = 0,
        reserved2: u1 = 0,
        reserved1: u1 = 0,
        padding6: u1 = 0,
        padding5: u1 = 0,
        padding4: u1 = 0,
        padding3: u1 = 0,
        padding2: u1 = 0,
        padding1: u1 = 0,
    });

    /// Write protection register
    pub const WRPR = mmio(Address + 0x00000020, 32, packed struct {
        /// Write protect
        WRP: u32 = 0,
    });
};

/// Nested Vectored Interrupt Controller
pub const NVIC = extern struct {
    pub const Address: u32 = 0xe000e000;

    /// Interrupt Controller Type Register
    pub const ICTR = mmio(Address + 0x00000004, 32, packed struct {
        /// Total number of interrupt lines in groups
        INTLINESNUM: u4 = 0,
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

    /// Interrupt Set-Enable Register
    pub const ISER0 = mmio(Address + 0x00000100, 32, packed struct {});

    /// Interrupt Set-Enable Register
    pub const ISER1 = mmio(Address + 0x00000104, 32, packed struct {});

    /// Interrupt Clear-Enable Register
    pub const ICER0 = mmio(Address + 0x00000180, 32, packed struct {});

    /// Interrupt Clear-Enable Register
    pub const ICER1 = mmio(Address + 0x00000184, 32, packed struct {});

    /// Interrupt Set-Pending Register
    pub const ISPR0 = mmio(Address + 0x00000200, 32, packed struct {});

    /// Interrupt Set-Pending Register
    pub const ISPR1 = mmio(Address + 0x00000204, 32, packed struct {});

    /// Interrupt Clear-Pending Register
    pub const ICPR0 = mmio(Address + 0x00000280, 32, packed struct {});

    /// Interrupt Clear-Pending Register
    pub const ICPR1 = mmio(Address + 0x00000284, 32, packed struct {});

    /// Interrupt Active Bit Register
    pub const IABR0 = mmio(Address + 0x00000300, 32, packed struct {});

    /// Interrupt Active Bit Register
    pub const IABR1 = mmio(Address + 0x00000304, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR0 = mmio(Address + 0x00000400, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR1 = mmio(Address + 0x00000404, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR2 = mmio(Address + 0x00000408, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR3 = mmio(Address + 0x0000040c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR4 = mmio(Address + 0x00000410, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR5 = mmio(Address + 0x00000414, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR6 = mmio(Address + 0x00000418, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR7 = mmio(Address + 0x0000041c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR8 = mmio(Address + 0x00000420, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR9 = mmio(Address + 0x00000424, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR10 = mmio(Address + 0x00000428, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR11 = mmio(Address + 0x0000042c, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR12 = mmio(Address + 0x00000430, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR13 = mmio(Address + 0x00000434, 32, packed struct {});

    /// Interrupt Priority Register
    pub const IPR14 = mmio(Address + 0x00000438, 32, packed struct {});

    /// Software Triggered Interrupt Register
    pub const STIR = mmio(Address + 0x00000f00, 32, packed struct {
        /// interrupt to be triggered
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

/// Universal serial bus full-speed device interface
pub const USB = extern struct {
    pub const Address: u32 = 0x40005c00;

    /// endpoint 0 register
    pub const EP0R = mmio(Address + 0x00000000, 32, packed struct {
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
    pub const EP1R = mmio(Address + 0x00000004, 32, packed struct {
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
    pub const EP2R = mmio(Address + 0x00000008, 32, packed struct {
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
    pub const EP3R = mmio(Address + 0x0000000c, 32, packed struct {
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
    pub const EP4R = mmio(Address + 0x00000010, 32, packed struct {
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
    pub const EP5R = mmio(Address + 0x00000014, 32, packed struct {
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
    pub const EP6R = mmio(Address + 0x00000018, 32, packed struct {
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
    pub const EP7R = mmio(Address + 0x0000001c, 32, packed struct {
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
    pub const CNTR = mmio(Address + 0x00000040, 32, packed struct {
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
        ADD: u7 = 0,
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
    /// Tamper interrupt
    TAMPER: InterruptVector = makeUnhandledHandler("TAMPER"),
    /// RTC global interrupt
    RTC: InterruptVector = makeUnhandledHandler("RTC"),
    /// Flash global interrupt
    FLASH: InterruptVector = makeUnhandledHandler("FLASH"),
    /// RCC global interrupt
    RCC: InterruptVector = makeUnhandledHandler("RCC"),
    /// EXTI Line0 interrupt
    EXTI0: InterruptVector = makeUnhandledHandler("EXTI0"),
    /// EXTI Line1 interrupt
    EXTI1: InterruptVector = makeUnhandledHandler("EXTI1"),
    /// EXTI Line2 interrupt
    EXTI2: InterruptVector = makeUnhandledHandler("EXTI2"),
    /// EXTI Line3 interrupt
    EXTI3: InterruptVector = makeUnhandledHandler("EXTI3"),
    /// EXTI Line4 interrupt
    EXTI4: InterruptVector = makeUnhandledHandler("EXTI4"),
    /// DMA1 Channel1 global interrupt
    DMA1_Channel1: InterruptVector = makeUnhandledHandler("DMA1_Channel1"),
    /// DMA1 Channel2 global interrupt
    DMA1_Channel2: InterruptVector = makeUnhandledHandler("DMA1_Channel2"),
    /// DMA1 Channel3 global interrupt
    DMA1_Channel3: InterruptVector = makeUnhandledHandler("DMA1_Channel3"),
    /// DMA1 Channel4 global interrupt
    DMA1_Channel4: InterruptVector = makeUnhandledHandler("DMA1_Channel4"),
    /// DMA1 Channel5 global interrupt
    DMA1_Channel5: InterruptVector = makeUnhandledHandler("DMA1_Channel5"),
    /// DMA1 Channel6 global interrupt
    DMA1_Channel6: InterruptVector = makeUnhandledHandler("DMA1_Channel6"),
    /// DMA1 Channel7 global interrupt
    DMA1_Channel7: InterruptVector = makeUnhandledHandler("DMA1_Channel7"),
    /// ADC1 global interrupt; ADC2 global interrupt
    ADC: InterruptVector = makeUnhandledHandler("ADC"),
    /// CAN1 TX interrupts
    CAN1_TX: InterruptVector = makeUnhandledHandler("CAN1_TX"),
    /// CAN1 RX0 interrupts
    CAN1_RX0: InterruptVector = makeUnhandledHandler("CAN1_RX0"),
    /// CAN1 RX1 interrupt
    CAN1_RX1: InterruptVector = makeUnhandledHandler("CAN1_RX1"),
    /// CAN1 SCE interrupt
    CAN1_SCE: InterruptVector = makeUnhandledHandler("CAN1_SCE"),
    /// EXTI Line[9:5] interrupts
    EXTI9_5: InterruptVector = makeUnhandledHandler("EXTI9_5"),
    /// TIM1 Break interrupt and TIM9 global interrupt
    TIM1_BRK_TIM9: InterruptVector = makeUnhandledHandler("TIM1_BRK_TIM9"),
    /// TIM1 Update interrupt and TIM10 global interrupt
    TIM1_UP_TIM10: InterruptVector = makeUnhandledHandler("TIM1_UP_TIM10"),
    /// TIM1 Trigger and Commutation interrupts and TIM11 global interrupt
    TIM1_TRG_COM_TIM11: InterruptVector = makeUnhandledHandler("TIM1_TRG_COM_TIM11"),
    /// TIM1 Capture Compare interrupt
    TIM1_CC: InterruptVector = makeUnhandledHandler("TIM1_CC"),
    /// TIM2 global interrupt
    TIM2: InterruptVector = makeUnhandledHandler("TIM2"),
    /// TIM3 global interrupt
    TIM3: InterruptVector = makeUnhandledHandler("TIM3"),
    /// TIM4 global interrupt
    TIM4: InterruptVector = makeUnhandledHandler("TIM4"),
    /// I2C1 event interrupt
    I2C1_EV: InterruptVector = makeUnhandledHandler("I2C1_EV"),
    /// I2C1 error interrupt
    I2C1_ER: InterruptVector = makeUnhandledHandler("I2C1_ER"),
    /// I2C2 event interrupt
    I2C2_EV: InterruptVector = makeUnhandledHandler("I2C2_EV"),
    /// I2C2 error interrupt
    I2C2_ER: InterruptVector = makeUnhandledHandler("I2C2_ER"),
    /// SPI1 global interrupt
    SPI1: InterruptVector = makeUnhandledHandler("SPI1"),
    /// SPI2 global interrupt
    SPI2: InterruptVector = makeUnhandledHandler("SPI2"),
    /// USART1 global interrupt
    USART1: InterruptVector = makeUnhandledHandler("USART1"),
    /// USART2 global interrupt
    USART2: InterruptVector = makeUnhandledHandler("USART2"),
    /// USART3 global interrupt
    USART3: InterruptVector = makeUnhandledHandler("USART3"),
    /// EXTI Line[15:10] interrupts
    EXTI15_10: InterruptVector = makeUnhandledHandler("EXTI15_10"),
    /// RTC Alarms through EXTI line interrupt
    RTCAlarm: InterruptVector = makeUnhandledHandler("RTCAlarm"),
    /// USB Device FS Wakeup through EXTI line interrupt
    USB_FS_WKUP: InterruptVector = makeUnhandledHandler("USB_FS_WKUP"),
    /// TIM8 Break interrupt and TIM12 global interrupt
    TIM8_BRK_TIM12: InterruptVector = makeUnhandledHandler("TIM8_BRK_TIM12"),
    /// TIM8 Update interrupt and TIM13 global interrupt
    TIM8_UP_TIM13: InterruptVector = makeUnhandledHandler("TIM8_UP_TIM13"),
    /// TIM8 Trigger and Commutation interrupts and TIM14 global interrupt
    TIM8_TRG_COM_TIM14: InterruptVector = makeUnhandledHandler("TIM8_TRG_COM_TIM14"),
    /// TIM8 Capture Compare interrupt
    TIM8_CC: InterruptVector = makeUnhandledHandler("TIM8_CC"),
    /// ADC3 global interrupt
    ADC3: InterruptVector = makeUnhandledHandler("ADC3"),
    /// FSMC global interrupt
    FSMC: InterruptVector = makeUnhandledHandler("FSMC"),
    /// SDIO global interrupt
    SDIO: InterruptVector = makeUnhandledHandler("SDIO"),
    /// TIM5 global interrupt
    TIM5: InterruptVector = makeUnhandledHandler("TIM5"),
    /// SPI3 global interrupt
    SPI3: InterruptVector = makeUnhandledHandler("SPI3"),
    /// UART4 global interrupt
    UART4: InterruptVector = makeUnhandledHandler("UART4"),
    /// UART5 global interrupt
    UART5: InterruptVector = makeUnhandledHandler("UART5"),
    /// TIM6 global interrupt
    TIM6: InterruptVector = makeUnhandledHandler("TIM6"),
    /// TIM7 global interrupt
    TIM7: InterruptVector = makeUnhandledHandler("TIM7"),
    /// DMA2 Channel1 global interrupt
    DMA2_Channel1: InterruptVector = makeUnhandledHandler("DMA2_Channel1"),
    /// DMA2 Channel2 global interrupt
    DMA2_Channel2: InterruptVector = makeUnhandledHandler("DMA2_Channel2"),
    /// DMA2 Channel3 global interrupt
    DMA2_Channel3: InterruptVector = makeUnhandledHandler("DMA2_Channel3"),
    /// DMA2 Channel4 and DMA2 Channel5 global interrupt
    DMA2_Channel4_5: InterruptVector = makeUnhandledHandler("DMA2_Channel4_5"),
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
