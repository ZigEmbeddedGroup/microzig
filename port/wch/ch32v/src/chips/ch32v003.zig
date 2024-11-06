const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  CH32V00xxx View File
    pub const CH32V00xxx = struct {
        pub const peripherals = struct {
            ///  Device electronic signature
            pub const ESIG = @as(*volatile types.peripherals.ESIG, @ptrFromInt(0x1ffff7e0));
            ///  General purpose timer
            pub const TIM2 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000000));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.peripherals.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.peripherals.IWDG, @ptrFromInt(0x40003000));
            ///  Inter integrated circuit
            pub const I2C1 = @as(*volatile types.peripherals.I2C1, @ptrFromInt(0x40005400));
            ///  Power control
            pub const PWR = @as(*volatile types.peripherals.PWR, @ptrFromInt(0x40007000));
            ///  Alternate function I/O
            pub const AFIO = @as(*volatile types.peripherals.AFIO, @ptrFromInt(0x40010000));
            ///  EXTI
            pub const EXTI = @as(*volatile types.peripherals.EXTI, @ptrFromInt(0x40010400));
            ///  General purpose I/O
            pub const GPIOA = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40010800));
            ///  General purpose I/O
            pub const GPIOC = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011000));
            ///  General purpose I/O
            pub const GPIOD = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011400));
            ///  Analog to digital converter
            pub const ADC1 = @as(*volatile types.peripherals.ADC1, @ptrFromInt(0x40012400));
            ///  Advanced timer
            pub const TIM1 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface
            pub const SPI1 = @as(*volatile types.peripherals.SPI1, @ptrFromInt(0x40013000));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40013800));
            ///  DMA1 controller
            pub const DMA1 = @as(*volatile types.peripherals.DMA1, @ptrFromInt(0x40020000));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.peripherals.RCC, @ptrFromInt(0x40021000));
            ///  FLASH
            pub const FLASH = @as(*volatile types.peripherals.FLASH, @ptrFromInt(0x40022000));
            ///  Extend configuration
            pub const EXTEND = @as(*volatile types.peripherals.EXTEND, @ptrFromInt(0x40023800));
            ///  Debug support
            pub const DBG = @as(*volatile types.peripherals.DBG, @ptrFromInt(0xe000d000));
            ///  Programmable Fast Interrupt Controller
            pub const PFIC = @as(*volatile types.peripherals.PFIC, @ptrFromInt(0xe000e000));
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  Power control
        pub const PWR = extern struct {
            ///  Power control register (PWR_CTRL)
            CTLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Power Down Deep Sleep
                PDDS: u1,
                reserved4: u2,
                ///  Power Voltage Detector Enable
                PVDE: u1,
                ///  PVD Level Selection
                PLS: u3,
                padding: u24,
            }),
            ///  Power control state register (PWR_CSR)
            CSR: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PVD Output
                PVDO: u1,
                padding: u29,
            }),
            ///  Automatic wake-up control state register (PWR_AWUCSR)
            AWUCSR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Automatic wake-up enable
                AWUEN: u1,
                padding: u30,
            }),
            ///  Automatic wake window comparison value register (PWR_AWUAPR)
            AWUAPR: mmio.Mmio(packed struct(u32) {
                ///  AWU window value
                AWUAPR: u6,
                padding: u26,
            }),
            ///  Automatic wake-up prescaler register (PWR_AWUPSC)
            AWUPSC: mmio.Mmio(packed struct(u32) {
                ///  Wake-up prescaler
                AWUPSC: u4,
                padding: u28,
            }),
        };

        ///  Reset and clock control
        pub const RCC = extern struct {
            ///  Clock control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Internal High Speed clock enable
                HSION: u1,
                ///  Internal High Speed clock ready flag
                HSIRDY: u1,
                reserved3: u1,
                ///  Internal High Speed clock trimming
                HSITRIM: u5,
                ///  Internal High Speed clock Calibration
                HSICAL: u8,
                ///  External High Speed clock enable
                HSEON: u1,
                ///  External High Speed clock ready flag
                HSERDY: u1,
                ///  External High Speed clock Bypass
                HSEBYP: u1,
                ///  Clock Security System enable
                CSSON: u1,
                reserved24: u4,
                ///  PLL enable
                PLLON: u1,
                ///  PLL clock ready flag
                PLLRDY: u1,
                padding: u6,
            }),
            ///  Clock configuration register (RCC_CFGR0)
            CFGR0: mmio.Mmio(packed struct(u32) {
                ///  System clock Switch
                SW: u2,
                ///  System Clock Switch Status
                SWS: u2,
                ///  AHB prescaler
                HPRE: u4,
                ///  APB Low speed prescaler (APB1)
                PPRE1: u3,
                ///  APB High speed prescaler (APB2)
                PPRE2: u3,
                ///  ADC prescaler
                ADCPRE: u2,
                ///  PLL entry clock source
                PLLSRC: u1,
                reserved24: u7,
                ///  Microcontroller clock output
                MCO: u3,
                padding: u5,
            }),
            ///  Clock interrupt register (RCC_INTR)
            INTR: mmio.Mmio(packed struct(u32) {
                ///  LSI Ready Interrupt flag
                LSIRDYF: u1,
                reserved2: u1,
                ///  HSI Ready Interrupt flag
                HSIRDYF: u1,
                ///  HSE Ready Interrupt flag
                HSERDYF: u1,
                ///  PLL Ready Interrupt flag
                PLLRDYF: u1,
                reserved7: u2,
                ///  Clock Security System Interrupt flag
                CSSF: u1,
                ///  LSI Ready Interrupt Enable
                LSIRDYIE: u1,
                reserved10: u1,
                ///  HSI Ready Interrupt Enable
                HSIRDYIE: u1,
                ///  HSE Ready Interrupt Enable
                HSERDYIE: u1,
                ///  PLL Ready Interrupt Enable
                PLLRDYIE: u1,
                reserved16: u3,
                ///  LSI Ready Interrupt Clear
                LSIRDYC: u1,
                reserved18: u1,
                ///  HSI Ready Interrupt Clear
                HSIRDYC: u1,
                ///  HSE Ready Interrupt Clear
                HSERDYC: u1,
                ///  PLL Ready Interrupt Clear
                PLLRDYC: u1,
                reserved23: u2,
                ///  Clock security system interrupt clear
                CSSC: u1,
                padding: u8,
            }),
            ///  APB2 peripheral reset register (RCC_APB2PRSTR)
            APB2PRSTR: mmio.Mmio(packed struct(u32) {
                ///  Alternate function I/O reset
                AFIORST: u1,
                reserved2: u1,
                ///  IO port A reset
                IOPARST: u1,
                reserved4: u1,
                ///  IO port C reset
                IOPCRST: u1,
                ///  IO port D reset
                IOPDRST: u1,
                reserved9: u3,
                ///  ADC 1 interface reset
                ADC1RST: u1,
                reserved11: u1,
                ///  TIM1 timer reset
                TIM1RST: u1,
                ///  SPI 1 reset
                SPI1RST: u1,
                reserved14: u1,
                ///  USART1 reset
                USART1RST: u1,
                padding: u17,
            }),
            ///  APB1 peripheral reset register (RCC_APB1PRSTR)
            APB1PRSTR: mmio.Mmio(packed struct(u32) {
                reserved11: u11,
                ///  Window watchdog reset
                WWDGRST: u1,
                reserved21: u9,
                ///  I2C1 reset
                I2C1RST: u1,
                reserved28: u6,
                ///  Power interface reset
                PWRRST: u1,
                padding: u3,
            }),
            ///  AHB Peripheral Clock enable register (RCC_AHBPCENR)
            AHBPCENR: mmio.Mmio(packed struct(u32) {
                ///  DMA clock enable
                DMA1EN: u1,
                reserved2: u1,
                ///  SRAM interface clock enable
                SRAMEN: u1,
                padding: u29,
            }),
            ///  APB2 peripheral clock enable register (RCC_APB2PCENR)
            APB2PCENR: mmio.Mmio(packed struct(u32) {
                ///  Alternate function I/O clock enable
                AFIOEN: u1,
                reserved2: u1,
                ///  I/O port A clock enable
                IOPAEN: u1,
                reserved4: u1,
                ///  I/O port C clock enable
                IOPCEN: u1,
                ///  I/O port D clock enable
                IOPDEN: u1,
                reserved9: u3,
                ///  ADC1 interface clock enable
                ADC1EN: u1,
                reserved11: u1,
                ///  TIM1 Timer clock enable
                TIM1EN: u1,
                ///  SPI 1 clock enable
                SPI1EN: u1,
                reserved14: u1,
                ///  USART1 clock enable
                USART1EN: u1,
                padding: u17,
            }),
            ///  APB1 peripheral clock enable register (RCC_APB1PCENR)
            APB1PCENR: mmio.Mmio(packed struct(u32) {
                ///  Timer 2 clock enable
                TIM2EN: u1,
                reserved11: u10,
                ///  Window watchdog clock enable
                WWDGEN: u1,
                reserved21: u9,
                ///  I2C 1 clock enable
                I2C1EN: u1,
                reserved28: u6,
                ///  Power interface clock enable
                PWREN: u1,
                padding: u3,
            }),
            reserved36: [4]u8,
            ///  Control/status register (RCC_RSTSCKR)
            RSTSCKR: mmio.Mmio(packed struct(u32) {
                ///  Internal low speed oscillator enable
                LSION: u1,
                ///  Internal low speed oscillator ready
                LSIRDY: u1,
                reserved24: u22,
                ///  Remove reset flag
                RMVF: u1,
                reserved26: u1,
                ///  PIN reset flag
                PINRSTF: u1,
                ///  POR/PDR reset flag
                PORRSTF: u1,
                ///  Software reset flag
                SFTRSTF: u1,
                ///  Independent watchdog reset flag
                IWDGRSTF: u1,
                ///  Window watchdog reset flag
                WWDGRSTF: u1,
                ///  Low-power reset flag
                LPWRRSTF: u1,
            }),
        };

        ///  Extend configuration
        pub const EXTEND = extern struct {
            ///  Configure the extended control register
            EXTEND_CTR: mmio.Mmio(packed struct(u32) {
                ///  Configure the PLL clock delay time
                PLL_CFG: u4,
                reserved6: u2,
                ///  LOCKUP_Enable
                LOCKUP_EN: u1,
                ///  LOCKUP RESET
                LOCKUP_RESET: u1,
                reserved10: u2,
                ///  LDO_TRIM
                LDO_TRIM: u1,
                ///  FLASH clock trimming
                FLASH_CLK_TRIM: u3,
                ///  Control Register write enable
                WR_EN: u1,
                ///  Control Register write lock
                WR_LOCK: u1,
                ///  OPA Enalbe
                OPA_EN: u1,
                ///  OPA negative end channel selection
                OPA_NSEL: u1,
                ///  OPA positive end channel selection
                OPA_PSEL: u1,
                padding: u13,
            }),
            ///  Configure the extended key register
            EXTEND_KR: mmio.Mmio(packed struct(u32) {
                ///  Write key value
                KEY: u32,
            }),
        };

        ///  General purpose I/O
        pub const GPIOA = extern struct {
            ///  Port configuration register low (GPIOn_CFGLR)
            CFGLR: mmio.Mmio(packed struct(u32) {
                ///  Port n.0 mode bits
                MODE0: u2,
                ///  Port n.0 configuration bits
                CNF0: u2,
                ///  Port n.1 mode bits
                MODE1: u2,
                ///  Port n.1 configuration bits
                CNF1: u2,
                ///  Port n.2 mode bits
                MODE2: u2,
                ///  Port n.2 configuration bits
                CNF2: u2,
                ///  Port n.3 mode bits
                MODE3: u2,
                ///  Port n.3 configuration bits
                CNF3: u2,
                ///  Port n.4 mode bits
                MODE4: u2,
                ///  Port n.4 configuration bits
                CNF4: u2,
                ///  Port n.5 mode bits
                MODE5: u2,
                ///  Port n.5 configuration bits
                CNF5: u2,
                ///  Port n.6 mode bits
                MODE6: u2,
                ///  Port n.6 configuration bits
                CNF6: u2,
                ///  Port n.7 mode bits
                MODE7: u2,
                ///  Port n.7 configuration bits
                CNF7: u2,
            }),
            reserved8: [4]u8,
            ///  Port input data register (GPIOn_INDR)
            INDR: mmio.Mmio(packed struct(u32) {
                ///  Port input data
                IDR0: u1,
                ///  Port input data
                IDR1: u1,
                ///  Port input data
                IDR2: u1,
                ///  Port input data
                IDR3: u1,
                ///  Port input data
                IDR4: u1,
                ///  Port input data
                IDR5: u1,
                ///  Port input data
                IDR6: u1,
                ///  Port input data
                IDR7: u1,
                padding: u24,
            }),
            ///  Port output data register (GPIOn_OUTDR)
            OUTDR: mmio.Mmio(packed struct(u32) {
                ///  Port output data
                ODR0: u1,
                ///  Port output data
                ODR1: u1,
                ///  Port output data
                ODR2: u1,
                ///  Port output data
                ODR3: u1,
                ///  Port output data
                ODR4: u1,
                ///  Port output data
                ODR5: u1,
                ///  Port output data
                ODR6: u1,
                ///  Port output data
                ODR7: u1,
                padding: u24,
            }),
            ///  Port bit set/reset register (GPIOn_BSHR)
            BSHR: mmio.Mmio(packed struct(u32) {
                ///  Set bit 0
                BS0: u1,
                ///  Set bit 1
                BS1: u1,
                ///  Set bit 1
                BS2: u1,
                ///  Set bit 3
                BS3: u1,
                ///  Set bit 4
                BS4: u1,
                ///  Set bit 5
                BS5: u1,
                ///  Set bit 6
                BS6: u1,
                ///  Set bit 7
                BS7: u1,
                reserved16: u8,
                ///  Reset bit 0
                BR0: u1,
                ///  Reset bit 1
                BR1: u1,
                ///  Reset bit 2
                BR2: u1,
                ///  Reset bit 3
                BR3: u1,
                ///  Reset bit 4
                BR4: u1,
                ///  Reset bit 5
                BR5: u1,
                ///  Reset bit 6
                BR6: u1,
                ///  Reset bit 7
                BR7: u1,
                padding: u8,
            }),
            ///  Port bit reset register (GPIOn_BCR)
            BCR: mmio.Mmio(packed struct(u32) {
                ///  Reset bit 0
                BR0: u1,
                ///  Reset bit 1
                BR1: u1,
                ///  Reset bit 1
                BR2: u1,
                ///  Reset bit 3
                BR3: u1,
                ///  Reset bit 4
                BR4: u1,
                ///  Reset bit 5
                BR5: u1,
                ///  Reset bit 6
                BR6: u1,
                ///  Reset bit 7
                BR7: u1,
                padding: u24,
            }),
            ///  Port configuration lock register
            LCKR: mmio.Mmio(packed struct(u32) {
                ///  Port A Lock bit 0
                LCK0: u1,
                ///  Port A Lock bit 1
                LCK1: u1,
                ///  Port A Lock bit 2
                LCK2: u1,
                ///  Port A Lock bit 3
                LCK3: u1,
                ///  Port A Lock bit 4
                LCK4: u1,
                ///  Port A Lock bit 5
                LCK5: u1,
                ///  Port A Lock bit 6
                LCK6: u1,
                ///  Port A Lock bit 7
                LCK7: u1,
                ///  Lock key
                LCKK: u1,
                padding: u23,
            }),
        };

        ///  Programmable Fast Interrupt Controller
        pub const PFIC = extern struct {
            ///  Interrupt Status Register
            ISR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Interrupt ID Status
                INTENSTA2_3: u2,
                reserved12: u8,
                ///  Interrupt ID Status
                INTENSTA12_31: u20,
            }),
            ///  Interrupt Status Register
            ISR2: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u32,
            }),
            ///  Interrupt Status Register
            ISR3: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u32,
            }),
            ///  Interrupt Status Register
            ISR4: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u8,
                padding: u24,
            }),
            reserved32: [16]u8,
            ///  Interrupt Pending Register
            IPR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDSTA
                PENDSTA2_3: u2,
                reserved12: u8,
                ///  PENDSTA
                PENDSTA12_31: u20,
            }),
            ///  Interrupt Pending Register
            IPR2: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u32,
            }),
            ///  Interrupt Pending Register
            IPR3: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u32,
            }),
            ///  Interrupt Pending Register
            IPR4: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u8,
                padding: u24,
            }),
            reserved64: [16]u8,
            ///  Interrupt Priority Register
            ITHRESDR: mmio.Mmio(packed struct(u32) {
                ///  THRESHOLD
                THRESHOLD: u8,
                padding: u24,
            }),
            reserved72: [4]u8,
            ///  Interrupt Config Register
            CFGR: mmio.Mmio(packed struct(u32) {
                reserved7: u7,
                ///  RESETSYS
                RESETSYS: u1,
                reserved16: u8,
                ///  KEYCODE
                KEYCODE: u16,
            }),
            ///  Interrupt Global Register
            GISR: mmio.Mmio(packed struct(u32) {
                ///  NESTSTA
                NESTSTA: u8,
                ///  GACTSTA
                GACTSTA: u1,
                ///  GPENDSTA
                GPENDSTA: u1,
                padding: u22,
            }),
            ///  ID Config Register
            VTFIDR: mmio.Mmio(packed struct(u32) {
                ///  VTFID0
                VTFID0: u8,
                ///  VTFID1
                VTFID1: u8,
                ///  VTFID2
                VTFID2: u8,
                ///  VTFID3
                VTFID3: u8,
            }),
            reserved96: [12]u8,
            ///  Interrupt 0 address Register
            VTFADDRR0: mmio.Mmio(packed struct(u32) {
                ///  VTF0EN
                VTF0EN: u1,
                ///  ADDR0
                ADDR0: u31,
            }),
            ///  Interrupt 1 address Register
            VTFADDRR1: mmio.Mmio(packed struct(u32) {
                ///  VTF1EN
                VTF1EN: u1,
                ///  ADDR1
                ADDR1: u31,
            }),
            ///  Interrupt 2 address Register
            VTFADDRR2: mmio.Mmio(packed struct(u32) {
                ///  VTF2EN
                VTF2EN: u1,
                ///  ADDR2
                ADDR2: u31,
            }),
            ///  Interrupt 3 address Register
            VTFADDRR3: mmio.Mmio(packed struct(u32) {
                ///  VTF3EN
                VTF3EN: u1,
                ///  ADDR3
                ADDR3: u31,
            }),
            reserved256: [144]u8,
            ///  Interrupt Setting Register
            IENR1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  INTEN
                INTEN: u20,
            }),
            ///  Interrupt Setting Register
            IENR2: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u32,
            }),
            ///  Interrupt Setting Register
            IENR3: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u32,
            }),
            ///  Interrupt Setting Register
            IENR4: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u8,
                padding: u24,
            }),
            reserved384: [112]u8,
            ///  Interrupt Clear Register
            IRER1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  INTRSET
                INTRSET: u20,
            }),
            ///  Interrupt Clear Register
            IRER2: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u32,
            }),
            ///  Interrupt Clear Register
            IRER3: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u32,
            }),
            ///  Interrupt Clear Register
            IRER4: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u8,
                padding: u24,
            }),
            reserved512: [112]u8,
            ///  Interrupt Pending Register
            IPSR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDSET
                PENDSET2_3: u2,
                reserved12: u8,
                ///  PENDSET
                PENDSET12_31: u20,
            }),
            ///  Interrupt Pending Register
            IPSR2: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u32,
            }),
            ///  Interrupt Pending Register
            IPSR3: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u32,
            }),
            ///  Interrupt Pending Register
            IPSR4: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u8,
                padding: u24,
            }),
            reserved640: [112]u8,
            ///  Interrupt Pending Clear Register
            IPRR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDRESET
                PENDRESET2_3: u2,
                reserved12: u8,
                ///  PENDRESET
                PENDRESET12_31: u20,
            }),
            ///  Interrupt Pending Clear Register
            IPRR2: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u32,
            }),
            ///  Interrupt Pending Clear Register
            IPRR3: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u32,
            }),
            ///  Interrupt Pending Clear Register
            IPRR4: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u8,
                padding: u24,
            }),
            reserved768: [112]u8,
            ///  Interrupt ACTIVE Register
            IACTR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  IACTS
                IACTS2_3: u2,
                reserved12: u8,
                ///  IACTS
                IACTS12_31: u20,
            }),
            ///  Interrupt ACTIVE Register
            IACTR2: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u32,
            }),
            ///  Interrupt ACTIVE Register
            IACTR3: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u32,
            }),
            ///  Interrupt ACTIVE Register
            IACTR4: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u8,
                padding: u24,
            }),
            reserved1024: [240]u8,
            ///  Interrupt Priority Register
            IPRIOR0: u8,
            ///  Interrupt Priority Register
            IPRIOR1: u8,
            ///  Interrupt Priority Register
            IPRIOR2: u8,
            ///  Interrupt Priority Register
            IPRIOR3: u8,
            ///  Interrupt Priority Register
            IPRIOR4: u8,
            ///  Interrupt Priority Register
            IPRIOR5: u8,
            ///  Interrupt Priority Register
            IPRIOR6: u8,
            ///  Interrupt Priority Register
            IPRIOR7: u8,
            ///  Interrupt Priority Register
            IPRIOR8: u8,
            ///  Interrupt Priority Register
            IPRIOR9: u8,
            ///  Interrupt Priority Register
            IPRIOR10: u8,
            ///  Interrupt Priority Register
            IPRIOR11: u8,
            ///  Interrupt Priority Register
            IPRIOR12: u8,
            ///  Interrupt Priority Register
            IPRIOR13: u8,
            ///  Interrupt Priority Register
            IPRIOR14: u8,
            ///  Interrupt Priority Register
            IPRIOR15: u8,
            ///  Interrupt Priority Register
            IPRIOR16: u8,
            ///  Interrupt Priority Register
            IPRIOR17: u8,
            ///  Interrupt Priority Register
            IPRIOR18: u8,
            ///  Interrupt Priority Register
            IPRIOR19: u8,
            ///  Interrupt Priority Register
            IPRIOR20: u8,
            ///  Interrupt Priority Register
            IPRIOR21: u8,
            ///  Interrupt Priority Register
            IPRIOR22: u8,
            ///  Interrupt Priority Register
            IPRIOR23: u8,
            ///  Interrupt Priority Register
            IPRIOR24: u8,
            ///  Interrupt Priority Register
            IPRIOR25: u8,
            ///  Interrupt Priority Register
            IPRIOR26: u8,
            ///  Interrupt Priority Register
            IPRIOR27: u8,
            ///  Interrupt Priority Register
            IPRIOR28: u8,
            ///  Interrupt Priority Register
            IPRIOR29: u8,
            ///  Interrupt Priority Register
            IPRIOR30: u8,
            ///  Interrupt Priority Register
            IPRIOR31: u8,
            ///  Interrupt Priority Register
            IPRIOR32: u8,
            ///  Interrupt Priority Register
            IPRIOR33: u8,
            ///  Interrupt Priority Register
            IPRIOR34: u8,
            ///  Interrupt Priority Register
            IPRIOR35: u8,
            ///  Interrupt Priority Register
            IPRIOR36: u8,
            ///  Interrupt Priority Register
            IPRIOR37: u8,
            ///  Interrupt Priority Register
            IPRIOR38: u8,
            ///  Interrupt Priority Register
            IPRIOR39: u8,
            ///  Interrupt Priority Register
            IPRIOR40: u8,
            ///  Interrupt Priority Register
            IPRIOR41: u8,
            ///  Interrupt Priority Register
            IPRIOR42: u8,
            ///  Interrupt Priority Register
            IPRIOR43: u8,
            ///  Interrupt Priority Register
            IPRIOR44: u8,
            ///  Interrupt Priority Register
            IPRIOR45: u8,
            ///  Interrupt Priority Register
            IPRIOR46: u8,
            ///  Interrupt Priority Register
            IPRIOR47: u8,
            ///  Interrupt Priority Register
            IPRIOR48: u8,
            ///  Interrupt Priority Register
            IPRIOR49: u8,
            ///  Interrupt Priority Register
            IPRIOR50: u8,
            ///  Interrupt Priority Register
            IPRIOR51: u8,
            ///  Interrupt Priority Register
            IPRIOR52: u8,
            ///  Interrupt Priority Register
            IPRIOR53: u8,
            ///  Interrupt Priority Register
            IPRIOR54: u8,
            ///  Interrupt Priority Register
            IPRIOR55: u8,
            ///  Interrupt Priority Register
            IPRIOR56: u8,
            ///  Interrupt Priority Register
            IPRIOR57: u8,
            ///  Interrupt Priority Register
            IPRIOR58: u8,
            ///  Interrupt Priority Register
            IPRIOR59: u8,
            ///  Interrupt Priority Register
            IPRIOR60: u8,
            ///  Interrupt Priority Register
            IPRIOR61: u8,
            ///  Interrupt Priority Register
            IPRIOR62: u8,
            ///  Interrupt Priority Register
            IPRIOR63: u8,
            reserved3344: [2256]u8,
            ///  System Control Register
            SCTLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  SLEEPONEXIT
                SLEEPONEXIT: u1,
                ///  SLEEPDEEP
                SLEEPDEEP: u1,
                ///  WFITOWFE
                WFITOWFE: u1,
                ///  SEVONPEND
                SEVONPEND: u1,
                ///  SETEVENT
                SETEVENT: u1,
                reserved31: u25,
                ///  SYSRESET
                SYSRESET: u1,
            }),
            reserved4096: [748]u8,
            ///  System counter control register
            STK_CTLR: mmio.Mmio(packed struct(u32) {
                ///  System counter enable
                STE: u1,
                ///  System counter interrupt enable
                STIE: u1,
                ///  System selects the clock source
                STCLK: u1,
                ///  System reload register
                STRE: u1,
                ///  System Mode
                MODE: u1,
                ///  System Initialization update
                INIT: u1,
                reserved31: u25,
                ///  System software triggered interrupts enable
                SWIE: u1,
            }),
            ///  System START
            STK_SR: mmio.Mmio(packed struct(u32) {
                ///  CNTIF
                CNTIF: u1,
                padding: u31,
            }),
            ///  System counter low register
            STK_CNTL: mmio.Mmio(packed struct(u32) {
                ///  CNTL
                CNTL: u32,
            }),
            reserved4112: [4]u8,
            ///  System compare low register
            STK_CMPLR: mmio.Mmio(packed struct(u32) {
                ///  CMPL
                CMPL: u32,
            }),
        };

        ///  FLASH
        pub const FLASH = extern struct {
            ///  Flash key register
            ACTLR: mmio.Mmio(packed struct(u32) {
                ///  Number of FLASH wait states
                LATENCY: u1,
                padding: u31,
            }),
            ///  Flash key register
            KEYR: mmio.Mmio(packed struct(u32) {
                ///  FPEC key
                KEYR: u32,
            }),
            ///  Flash option key register
            OBKEYR: mmio.Mmio(packed struct(u32) {
                ///  Option byte key
                OPTKEY: u32,
            }),
            ///  Status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Busy
                BSY: u1,
                reserved4: u3,
                ///  Write protection error
                WRPRTERR: u1,
                ///  End of operation
                EOP: u1,
                reserved14: u8,
                ///  BOOT mode
                BOOT_MODE: u1,
                ///  BOOT lock
                BOOT_LOCK: u1,
                padding: u16,
            }),
            ///  Control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Programming
                PG: u1,
                ///  Page Erase
                PER: u1,
                ///  Mass Erase
                MER: u1,
                reserved4: u1,
                ///  Option byte programming
                OBPG: u1,
                ///  Option byte erase
                OBER: u1,
                ///  Start
                STRT: u1,
                ///  Lock
                LOCK: u1,
                reserved9: u1,
                ///  Option bytes write enable
                OBWRE: u1,
                ///  Error interrupt enable
                ERRIE: u1,
                reserved12: u1,
                ///  End of operation interrupt enable
                EOPIE: u1,
                reserved15: u2,
                ///  Fast programmable lock
                FLOCK: u1,
                ///  Fast programming
                PAGE_PG: u1,
                ///  Fast erase
                PAGE_ER: u1,
                ///  Buffer load
                BUFLOAD: u1,
                ///  Buffer reset
                BUFRST: u1,
                padding: u12,
            }),
            ///  Flash address register
            ADDR: mmio.Mmio(packed struct(u32) {
                ///  Flash Address
                ADDR: u32,
            }),
            reserved28: [4]u8,
            ///  Option byte register
            OBR: mmio.Mmio(packed struct(u32) {
                ///  Option byte error
                OBERR: u1,
                ///  Read protection
                RDPRT: u1,
                ///  IWDG_SW
                IWDG_SW: u1,
                ///  STOP_RST
                STOP_RST: u1,
                ///  STANDY_RST
                STANDY_RST: u1,
                ///  CFG_RST_MODE
                CFG_RST_MODE: u2,
                reserved10: u3,
                ///  DATA0
                DATA0: u8,
                ///  DATA1
                DATA1: u8,
                padding: u6,
            }),
            ///  Write protection register
            WPR: mmio.Mmio(packed struct(u32) {
                ///  Write protect
                WRP: u32,
            }),
            ///  Mode select register
            MODEKEYR: mmio.Mmio(packed struct(u32) {
                ///  Mode select
                MODEKEYR: u32,
            }),
            ///  Boot mode key register
            BOOT_MODEKEYP: mmio.Mmio(packed struct(u32) {
                ///  Boot mode key
                MODEKEYR: u32,
            }),
        };

        ///  Alternate function I/O
        pub const AFIO = extern struct {
            reserved4: [4]u8,
            ///  AF remap and debug I/O configuration register (AFIO_PCFR)
            PCFR: mmio.Mmio(packed struct(u32) {
                ///  SPI1 remapping
                SPI1RM: u1,
                ///  I2C1 remapping
                I2C1RM: u1,
                ///  USART1 remapping
                USART1RM: u1,
                reserved6: u3,
                ///  TIM1 remapping
                TIM1RM: u2,
                ///  TIM2 remapping
                TIM2RM: u2,
                reserved15: u5,
                ///  Port A1/Port A2 mapping on OSCIN/OSCOUT
                PA12RM: u1,
                reserved17: u1,
                ///  ADC 1 External trigger injected conversion remapping
                ADC1_ETRGINJ_RM: u1,
                ///  ADC 1 external trigger regular conversion remapping
                ADC1_ETRGREG_RM: u1,
                reserved21: u2,
                ///  USART1 remapping
                USART1REMAP1: u1,
                ///  I2C1 remapping
                I2C1REMAP1: u1,
                ///  TIM1_CH1 channel selection
                TIM1_IREMAP: u1,
                ///  Serial wire JTAG configuration
                SWCFG: u3,
                padding: u5,
            }),
            ///  External interrupt configuration register (AFIO_EXTICR)
            EXTICR: mmio.Mmio(packed struct(u32) {
                ///  EXTI0 configuration
                EXTI0: u2,
                ///  EXTI1 configuration
                EXTI1: u2,
                ///  EXTI2 configuration
                EXTI2: u2,
                ///  EXTI3 configuration
                EXTI3: u2,
                ///  EXTI4 configuration
                EXTI4: u2,
                ///  EXTI5 configuration
                EXTI5: u2,
                ///  EXTI6 configuration
                EXTI6: u2,
                ///  EXTI7 configuration
                EXTI7: u2,
                padding: u16,
            }),
        };

        ///  EXTI
        pub const EXTI = extern struct {
            ///  Interrupt mask register (EXTI_INTENR)
            INTENR: mmio.Mmio(packed struct(u32) {
                ///  Interrupt Mask on line 0
                MR0: u1,
                ///  Interrupt Mask on line 1
                MR1: u1,
                ///  Interrupt Mask on line 2
                MR2: u1,
                ///  Interrupt Mask on line 3
                MR3: u1,
                ///  Interrupt Mask on line 4
                MR4: u1,
                ///  Interrupt Mask on line 5
                MR5: u1,
                ///  Interrupt Mask on line 6
                MR6: u1,
                ///  Interrupt Mask on line 7
                MR7: u1,
                ///  Interrupt Mask on line 8
                MR8: u1,
                ///  Interrupt Mask on line 9
                MR9: u1,
                padding: u22,
            }),
            ///  Event mask register (EXTI_EVENR)
            EVENR: mmio.Mmio(packed struct(u32) {
                ///  Event Mask on line 0
                MR0: u1,
                ///  Event Mask on line 1
                MR1: u1,
                ///  Event Mask on line 2
                MR2: u1,
                ///  Event Mask on line 3
                MR3: u1,
                ///  Event Mask on line 4
                MR4: u1,
                ///  Event Mask on line 5
                MR5: u1,
                ///  Event Mask on line 6
                MR6: u1,
                ///  Event Mask on line 7
                MR7: u1,
                ///  Event Mask on line 8
                MR8: u1,
                ///  Event Mask on line 9
                MR9: u1,
                padding: u22,
            }),
            ///  Rising Trigger selection register (EXTI_RTENR)
            RTENR: mmio.Mmio(packed struct(u32) {
                ///  Rising trigger event configuration of line 0
                TR0: u1,
                ///  Rising trigger event configuration of line 1
                TR1: u1,
                ///  Rising trigger event configuration of line 2
                TR2: u1,
                ///  Rising trigger event configuration of line 3
                TR3: u1,
                ///  Rising trigger event configuration of line 4
                TR4: u1,
                ///  Rising trigger event configuration of line 5
                TR5: u1,
                ///  Rising trigger event configuration of line 6
                TR6: u1,
                ///  Rising trigger event configuration of line 7
                TR7: u1,
                ///  Rising trigger event configuration of line 8
                TR8: u1,
                ///  Rising trigger event configuration of line 9
                TR9: u1,
                padding: u22,
            }),
            ///  Falling Trigger selection register (EXTI_FTENR)
            FTENR: mmio.Mmio(packed struct(u32) {
                ///  Falling trigger event configuration of line 0
                TR0: u1,
                ///  Falling trigger event configuration of line 1
                TR1: u1,
                ///  Falling trigger event configuration of line 2
                TR2: u1,
                ///  Falling trigger event configuration of line 3
                TR3: u1,
                ///  Falling trigger event configuration of line 4
                TR4: u1,
                ///  Falling trigger event configuration of line 5
                TR5: u1,
                ///  Falling trigger event configuration of line 6
                TR6: u1,
                ///  Falling trigger event configuration of line 7
                TR7: u1,
                ///  Falling trigger event configuration of line 8
                TR8: u1,
                ///  Falling trigger event configuration of line 9
                TR9: u1,
                padding: u22,
            }),
            ///  Software interrupt event register (EXTI_SWIEVR)
            SWIEVR: mmio.Mmio(packed struct(u32) {
                ///  Software Interrupt on line 0
                SWIER0: u1,
                ///  Software Interrupt on line 1
                SWIER1: u1,
                ///  Software Interrupt on line 2
                SWIER2: u1,
                ///  Software Interrupt on line 3
                SWIER3: u1,
                ///  Software Interrupt on line 4
                SWIER4: u1,
                ///  Software Interrupt on line 5
                SWIER5: u1,
                ///  Software Interrupt on line 6
                SWIER6: u1,
                ///  Software Interrupt on line 7
                SWIER7: u1,
                ///  Software Interrupt on line 8
                SWIER8: u1,
                ///  Software Interrupt on line 9
                SWIER9: u1,
                padding: u22,
            }),
            ///  Pending register (EXTI_INTFR)
            INTFR: mmio.Mmio(packed struct(u32) {
                ///  Pending bit 0
                PR0: u1,
                ///  Pending bit 1
                PR1: u1,
                ///  Pending bit 2
                PR2: u1,
                ///  Pending bit 3
                PR3: u1,
                ///  Pending bit 4
                PR4: u1,
                ///  Pending bit 5
                PR5: u1,
                ///  Pending bit 6
                PR6: u1,
                ///  Pending bit 7
                PR7: u1,
                ///  Pending bit 8
                PR8: u1,
                ///  Pending bit 9
                PR9: u1,
                padding: u22,
            }),
        };

        ///  DMA1 controller
        pub const DMA1 = extern struct {
            ///  DMA interrupt status register (DMA_INTFR)
            INTFR: mmio.Mmio(packed struct(u32) {
                ///  Channel 1 Global interrupt flag
                GIF1: u1,
                ///  Channel 1 Transfer Complete flag
                TCIF1: u1,
                ///  Channel 1 Half Transfer Complete flag
                HTIF1: u1,
                ///  Channel 1 Transfer Error flag
                TEIF1: u1,
                ///  Channel 2 Global interrupt flag
                GIF2: u1,
                ///  Channel 2 Transfer Complete flag
                TCIF2: u1,
                ///  Channel 2 Half Transfer Complete flag
                HTIF2: u1,
                ///  Channel 2 Transfer Error flag
                TEIF2: u1,
                ///  Channel 3 Global interrupt flag
                GIF3: u1,
                ///  Channel 3 Transfer Complete flag
                TCIF3: u1,
                ///  Channel 3 Half Transfer Complete flag
                HTIF3: u1,
                ///  Channel 3 Transfer Error flag
                TEIF3: u1,
                ///  Channel 4 Global interrupt flag
                GIF4: u1,
                ///  Channel 4 Transfer Complete flag
                TCIF4: u1,
                ///  Channel 4 Half Transfer Complete flag
                HTIF4: u1,
                ///  Channel 4 Transfer Error flag
                TEIF4: u1,
                ///  Channel 5 Global interrupt flag
                GIF5: u1,
                ///  Channel 5 Transfer Complete flag
                TCIF5: u1,
                ///  Channel 5 Half Transfer Complete flag
                HTIF5: u1,
                ///  Channel 5 Transfer Error flag
                TEIF5: u1,
                ///  Channel 6 Global interrupt flag
                GIF6: u1,
                ///  Channel 6 Transfer Complete flag
                TCIF6: u1,
                ///  Channel 6 Half Transfer Complete flag
                HTIF6: u1,
                ///  Channel 6 Transfer Error flag
                TEIF6: u1,
                ///  Channel 7 Global interrupt flag
                GIF7: u1,
                ///  Channel 7 Transfer Complete flag
                TCIF7: u1,
                ///  Channel 7 Half Transfer Complete flag
                HTIF7: u1,
                ///  Channel 7 Transfer Error flag
                TEIF7: u1,
                padding: u4,
            }),
            ///  DMA interrupt flag clear register (DMA_INTFCR)
            INTFCR: mmio.Mmio(packed struct(u32) {
                ///  Channel 1 Global interrupt clear
                CGIF1: u1,
                ///  Channel 1 Transfer Complete clear
                CTCIF1: u1,
                ///  Channel 1 Half Transfer clear
                CHTIF1: u1,
                ///  Channel 1 Transfer Error clear
                CTEIF1: u1,
                ///  Channel 2 Global interrupt clear
                CGIF2: u1,
                ///  Channel 2 Transfer Complete clear
                CTCIF2: u1,
                ///  Channel 2 Half Transfer clear
                CHTIF2: u1,
                ///  Channel 2 Transfer Error clear
                CTEIF2: u1,
                ///  Channel 3 Global interrupt clear
                CGIF3: u1,
                ///  Channel 3 Transfer Complete clear
                CTCIF3: u1,
                ///  Channel 3 Half Transfer clear
                CHTIF3: u1,
                ///  Channel 3 Transfer Error clear
                CTEIF3: u1,
                ///  Channel 4 Global interrupt clear
                CGIF4: u1,
                ///  Channel 4 Transfer Complete clear
                CTCIF4: u1,
                ///  Channel 4 Half Transfer clear
                CHTIF4: u1,
                ///  Channel 4 Transfer Error clear
                CTEIF4: u1,
                ///  Channel 5 Global interrupt clear
                CGIF5: u1,
                ///  Channel 5 Transfer Complete clear
                CTCIF5: u1,
                ///  Channel 5 Half Transfer clear
                CHTIF5: u1,
                ///  Channel 5 Transfer Error clear
                CTEIF5: u1,
                ///  Channel 6 Global interrupt clear
                CGIF6: u1,
                ///  Channel 6 Transfer Complete clear
                CTCIF6: u1,
                ///  Channel 6 Half Transfer clear
                CHTIF6: u1,
                ///  Channel 6 Transfer Error clear
                CTEIF6: u1,
                ///  Channel 7 Global interrupt clear
                CGIF7: u1,
                ///  Channel 7 Transfer Complete clear
                CTCIF7: u1,
                ///  Channel 7 Half Transfer clear
                CHTIF7: u1,
                ///  Channel 7 Transfer Error clear
                CTEIF7: u1,
                padding: u4,
            }),
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR1: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 1 number of data register
            CNTR1: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 1 peripheral address register
            PADDR1: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 1 memory address register
            MADDR1: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved28: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR2: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 2 number of data register
            CNTR2: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 2 peripheral address register
            PADDR2: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 2 memory address register
            MADDR2: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved48: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR3: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 3 number of data register
            CNTR3: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 3 peripheral address register
            PADDR3: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 3 memory address register
            MADDR3: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved68: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR4: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 4 number of data register
            CNTR4: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 4 peripheral address register
            PADDR4: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 4 memory address register
            MADDR4: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved88: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR5: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 5 number of data register
            CNTR5: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 5 peripheral address register
            PADDR5: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 5 memory address register
            MADDR5: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved108: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR6: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 6 number of data register
            CNTR6: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 6 peripheral address register
            PADDR6: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 6 memory address register
            MADDR6: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved128: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR7: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                EN: u1,
                ///  Transfer complete interrupt enable
                TCIE: u1,
                ///  Half Transfer interrupt enable
                HTIE: u1,
                ///  Transfer error interrupt enable
                TEIE: u1,
                ///  Data transfer direction
                DIR: u1,
                ///  Circular mode
                CIRC: u1,
                ///  Peripheral increment mode
                PINC: u1,
                ///  Memory increment mode
                MINC: u1,
                ///  Peripheral size
                PSIZE: u2,
                ///  Memory size
                MSIZE: u2,
                ///  Channel Priority level
                PL: u2,
                ///  Memory to memory mode
                MEM2MEM: u1,
                padding: u17,
            }),
            ///  DMA channel 7 number of data register
            CNTR7: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 7 peripheral address register
            PADDR7: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 7 memory address register
            MADDR7: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
        };

        ///  Independent watchdog
        pub const IWDG = extern struct {
            ///  Key register (IWDG_CTLR)
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Key value
                KEY: u16,
                padding: u16,
            }),
            ///  Prescaler register (IWDG_PSCR)
            PSCR: mmio.Mmio(packed struct(u32) {
                ///  Prescaler divider
                PR: u3,
                padding: u29,
            }),
            ///  Reload register (IWDG_RLDR)
            RLDR: mmio.Mmio(packed struct(u32) {
                ///  Watchdog counter reload value
                RL: u12,
                padding: u20,
            }),
            ///  Status register (IWDG_SR)
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Watchdog prescaler value update
                PVU: u1,
                ///  Watchdog counter reload value update
                RVU: u1,
                padding: u30,
            }),
        };

        ///  Window watchdog
        pub const WWDG = extern struct {
            ///  Control register (WWDG_CR)
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  7-bit counter (MSB to LSB)
                T: u7,
                ///  Activation bit
                WDGA: u1,
                padding: u24,
            }),
            ///  Configuration register (WWDG_CFR)
            CFGR: mmio.Mmio(packed struct(u32) {
                ///  7-bit window value
                W: u7,
                ///  Timer Base
                WDGTB: u2,
                ///  Early Wakeup Interrupt
                EWI: u1,
                padding: u22,
            }),
            ///  Status register (WWDG_SR)
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Early Wakeup Interrupt Flag
                WEIF: u1,
                padding: u31,
            }),
        };

        ///  Advanced timer
        pub const TIM1 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Counter enable
                CEN: u1,
                ///  Update disable
                UDIS: u1,
                ///  Update request source
                URS: u1,
                ///  One-pulse mode
                OPM: u1,
                ///  Direction
                DIR: u1,
                ///  Center-aligned mode selection
                CMS: u2,
                ///  Auto-reload preload enable
                ARPE: u1,
                ///  Clock division
                CKD: u2,
                reserved14: u4,
                ///  Timer capture value configuration enable
                TMR_CAP_OV_EN: u1,
                ///  Timer capture level indication enable
                TMR_CAP_LVL_EN: u1,
                padding: u16,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  Capture/compare preloaded control
                CCPC: u1,
                reserved2: u1,
                ///  Capture/compare control update selection
                CCUS: u1,
                ///  Capture/compare DMA selection
                CCDS: u1,
                ///  Master mode selection
                MMS: u3,
                ///  TI1 selection
                TI1S: u1,
                ///  Output Idle state 1
                OIS1: u1,
                ///  Output Idle state 1
                OIS1N: u1,
                ///  Output Idle state 2
                OIS2: u1,
                ///  Output Idle state 2
                OIS2N: u1,
                ///  Output Idle state 3
                OIS3: u1,
                ///  Output Idle state 3
                OIS3N: u1,
                ///  Output Idle state 4
                OIS4: u1,
                padding: u17,
            }),
            ///  slave mode control register
            SMCFGR: mmio.Mmio(packed struct(u32) {
                ///  Slave mode selection
                SMS: u3,
                reserved4: u1,
                ///  Trigger selection
                TS: u3,
                ///  Master/Slave mode
                MSM: u1,
                ///  External trigger filter
                ETF: u4,
                ///  External trigger prescaler
                ETPS: u2,
                ///  External clock enable
                ECE: u1,
                ///  External trigger polarity
                ETP: u1,
                padding: u16,
            }),
            ///  DMA/Interrupt enable register
            DMAINTENR: mmio.Mmio(packed struct(u32) {
                ///  Update interrupt enable
                UIE: u1,
                ///  Capture/Compare 1 interrupt enable
                CC1IE: u1,
                ///  Capture/Compare 2 interrupt enable
                CC2IE: u1,
                ///  Capture/Compare 3 interrupt enable
                CC3IE: u1,
                ///  Capture/Compare 4 interrupt enable
                CC4IE: u1,
                ///  COM interrupt enable
                COMIE: u1,
                ///  Trigger interrupt enable
                TIE: u1,
                ///  Break interrupt enable
                BIE: u1,
                ///  Update DMA request enable
                UDE: u1,
                ///  Capture/Compare 1 DMA request enable
                CC1DE: u1,
                ///  Capture/Compare 2 DMA request enable
                CC2DE: u1,
                ///  Capture/Compare 3 DMA request enable
                CC3DE: u1,
                ///  Capture/Compare 4 DMA request enable
                CC4DE: u1,
                ///  COM DMA request enable
                COMDE: u1,
                ///  Trigger DMA request enable
                TDE: u1,
                padding: u17,
            }),
            ///  status register
            INTFR: mmio.Mmio(packed struct(u32) {
                ///  Update interrupt flag
                UIF: u1,
                ///  Capture/compare 1 interrupt flag
                CC1IF: u1,
                ///  Capture/Compare 2 interrupt flag
                CC2IF: u1,
                ///  Capture/Compare 3 interrupt flag
                CC3IF: u1,
                ///  Capture/Compare 4 interrupt flag
                CC4IF: u1,
                ///  COM interrupt flag
                COMIF: u1,
                ///  Trigger interrupt flag
                TIF: u1,
                ///  Break interrupt flag
                BIF: u1,
                reserved9: u1,
                ///  Capture/Compare 1 overcapture flag
                CC1OF: u1,
                ///  Capture/compare 2 overcapture flag
                CC2OF: u1,
                ///  Capture/Compare 3 overcapture flag
                CC3OF: u1,
                ///  Capture/Compare 4 overcapture flag
                CC4OF: u1,
                padding: u19,
            }),
            ///  event generation register
            SWEVGR: mmio.Mmio(packed struct(u32) {
                ///  Update generation
                UG: u1,
                ///  Capture/compare 1 generation
                CC1G: u1,
                ///  Capture/compare 2 generation
                CC2G: u1,
                ///  Capture/compare 3 generation
                CC3G: u1,
                ///  Capture/compare 4 generation
                CC4G: u1,
                ///  Capture/Compare control update generation
                COMG: u1,
                ///  Trigger generation
                TG: u1,
                ///  Break generation
                BG: u1,
                padding: u24,
            }),
            ///  capture/compare mode register (output mode)
            CHCTLR1_Output: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 selection
                CC1S: u2,
                ///  Output Compare 1 fast enable
                OC1FE: u1,
                ///  Output Compare 1 preload enable
                OC1PE: u1,
                ///  Output Compare 1 mode
                OC1M: u3,
                ///  Output Compare 1 clear enable
                OC1CE: u1,
                ///  Capture/Compare 2 selection
                CC2S: u2,
                ///  Output Compare 2 fast enable
                OC2FE: u1,
                ///  Output Compare 2 preload enable
                OC2PE: u1,
                ///  Output Compare 2 mode
                OC2M: u3,
                ///  Output Compare 2 clear enable
                OC2CE: u1,
                padding: u16,
            }),
            ///  capture/compare mode register (output mode)
            CHCTLR2_Output: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 3 selection
                CC3S: u2,
                ///  Output compare 3 fast enable
                OC3FE: u1,
                ///  Output compare 3 preload enable
                OC3PE: u1,
                ///  Output compare 3 mode
                OC3M: u3,
                ///  Output compare 3 clear enable
                OC3CE: u1,
                ///  Capture/Compare 4 selection
                CC4S: u2,
                ///  Output compare 4 fast enable
                OC4FE: u1,
                ///  Output compare 4 preload enable
                OC4PE: u1,
                ///  Output compare 4 mode
                OC4M: u3,
                ///  Output compare 4 clear enable
                OC4CE: u1,
                padding: u16,
            }),
            ///  capture/compare enable register
            CCER: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 output enable
                CC1E: u1,
                ///  Capture/Compare 1 output Polarity
                CC1P: u1,
                ///  Capture/Compare 1 complementary output enable
                CC1NE: u1,
                ///  Capture/Compare 1 output Polarity
                CC1NP: u1,
                ///  Capture/Compare 2 output enable
                CC2E: u1,
                ///  Capture/Compare 2 output Polarity
                CC2P: u1,
                ///  Capture/Compare 2 complementary output enable
                CC2NE: u1,
                ///  Capture/Compare 2 output Polarity
                CC2NP: u1,
                ///  Capture/Compare 3 output enable
                CC3E: u1,
                ///  Capture/Compare 3 output Polarity
                CC3P: u1,
                ///  Capture/Compare 3 complementary output enable
                CC3NE: u1,
                ///  Capture/Compare 3 output Polarity
                CC3NP: u1,
                ///  Capture/Compare 4 output enable
                CC4E: u1,
                ///  Capture/Compare 3 output Polarity
                CC4P: u1,
                padding: u18,
            }),
            ///  counter
            CNT: mmio.Mmio(packed struct(u32) {
                ///  counter value
                CNT: u16,
                padding: u16,
            }),
            ///  prescaler
            PSC: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u16,
                padding: u16,
            }),
            ///  auto-reload register
            ATRLR: mmio.Mmio(packed struct(u32) {
                ///  Auto-reload value
                ATRLR: u16,
                padding: u16,
            }),
            ///  repetition counter register
            RPTCR: mmio.Mmio(packed struct(u32) {
                ///  Repetition counter value
                RPTCR: u8,
                padding: u24,
            }),
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CH1CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CH2CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH3CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH4CVR: u16,
                padding: u16,
            }),
            ///  break and dead-time register
            BDTR: mmio.Mmio(packed struct(u32) {
                ///  Dead-time generator setup
                DTG: u8,
                ///  Lock configuration
                LOCK: u2,
                ///  Off-state selection for Idle mode
                OSSI: u1,
                ///  Off-state selection for Run mode
                OSSR: u1,
                ///  Break enable
                BKE: u1,
                ///  Break polarity
                BKP: u1,
                ///  Automatic output enable
                AOE: u1,
                ///  Main output enable
                MOE: u1,
                padding: u16,
            }),
            ///  DMA control register
            DMACFGR: mmio.Mmio(packed struct(u32) {
                ///  DMA base address
                DBA: u5,
                reserved8: u3,
                ///  DMA burst length
                DBL: u5,
                padding: u19,
            }),
            ///  DMA address for full transfer
            DMAADR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAADR: u16,
                padding: u16,
            }),
        };

        ///  General purpose timer
        pub const TIM2 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Counter enable
                CEN: u1,
                ///  Update disable
                UDIS: u1,
                ///  Update request source
                URS: u1,
                ///  One-pulse mode
                OPM: u1,
                ///  Direction
                DIR: u1,
                ///  Center-aligned mode selection
                CMS: u2,
                ///  Auto-reload preload enable
                ARPE: u1,
                ///  Clock division
                CKD: u2,
                reserved14: u4,
                ///  Timer capture value configuration enable
                TMR_CAP_OV_EN: u1,
                ///  Timer capture level indication enable
                TMR_CAP_LVL_EN: u1,
                padding: u16,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                ///  Capture/compare DMA selection
                CCDS: u1,
                ///  Master mode selection
                MMS: u3,
                ///  TI1 selection
                TI1S: u1,
                padding: u24,
            }),
            ///  slave mode control register
            SMCFGR: mmio.Mmio(packed struct(u32) {
                ///  Slave mode selection
                SMS: u3,
                reserved4: u1,
                ///  Trigger selection
                TS: u3,
                ///  Master/Slave mode
                MSM: u1,
                ///  External trigger filter
                ETF: u4,
                ///  External trigger prescaler
                ETPS: u2,
                ///  External clock enable
                ECE: u1,
                ///  External trigger polarity
                ETP: u1,
                padding: u16,
            }),
            ///  DMA/Interrupt enable register
            DMAINTENR: mmio.Mmio(packed struct(u32) {
                ///  Update interrupt enable
                UIE: u1,
                ///  Capture/Compare 1 interrupt enable
                CC1IE: u1,
                ///  Capture/Compare 2 interrupt enable
                CC2IE: u1,
                ///  Capture/Compare 3 interrupt enable
                CC3IE: u1,
                ///  Capture/Compare 4 interrupt enable
                CC4IE: u1,
                reserved6: u1,
                ///  Trigger interrupt enable
                TIE: u1,
                reserved8: u1,
                ///  Update DMA request enable
                UDE: u1,
                ///  Capture/Compare 1 DMA request enable
                CC1DE: u1,
                ///  Capture/Compare 2 DMA request enable
                CC2DE: u1,
                ///  Capture/Compare 3 DMA request enable
                CC3DE: u1,
                ///  Capture/Compare 4 DMA request enable
                CC4DE: u1,
                reserved14: u1,
                ///  Trigger DMA request enable
                TDE: u1,
                padding: u17,
            }),
            ///  status register
            INTFR: mmio.Mmio(packed struct(u32) {
                ///  Update interrupt flag
                UIF: u1,
                ///  Capture/compare 1 interrupt flag
                CC1IF: u1,
                ///  Capture/Compare 2 interrupt flag
                CC2IF: u1,
                ///  Capture/Compare 3 interrupt flag
                CC3IF: u1,
                ///  Capture/Compare 4 interrupt flag
                CC4IF: u1,
                reserved6: u1,
                ///  Trigger interrupt flag
                TIF: u1,
                reserved9: u2,
                ///  Capture/Compare 1 overcapture flag
                CC1OF: u1,
                ///  Capture/compare 2 overcapture flag
                CC2OF: u1,
                ///  Capture/Compare 3 overcapture flag
                CC3OF: u1,
                ///  Capture/Compare 4 overcapture flag
                CC4OF: u1,
                padding: u19,
            }),
            ///  event generation register
            SWEVGR: mmio.Mmio(packed struct(u32) {
                ///  Update generation
                UG: u1,
                ///  Capture/compare 1 generation
                CC1G: u1,
                ///  Capture/compare 2 generation
                CC2G: u1,
                ///  Capture/compare 3 generation
                CC3G: u1,
                ///  Capture/compare 4 generation
                CC4G: u1,
                reserved6: u1,
                ///  Trigger generation
                TG: u1,
                padding: u25,
            }),
            ///  capture/compare mode register 1 (output mode)
            CHCTLR1_Output: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 selection
                CC1S: u2,
                ///  Output compare 1 fast enable
                OC1FE: u1,
                ///  Output compare 1 preload enable
                OC1PE: u1,
                ///  Output compare 1 mode
                OC1M: u3,
                ///  Output compare 1 clear enable
                OC1CE: u1,
                ///  Capture/Compare 2 selection
                CC2S: u2,
                ///  Output compare 2 fast enable
                OC2FE: u1,
                ///  Output compare 2 preload enable
                OC2PE: u1,
                ///  Output compare 2 mode
                OC2M: u3,
                ///  Output compare 2 clear enable
                OC2CE: u1,
                padding: u16,
            }),
            ///  capture/compare mode register 2 (output mode)
            CHCTLR2_Output: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 3 selection
                CC3S: u2,
                ///  Output compare 3 fast enable
                OC3FE: u1,
                ///  Output compare 3 preload enable
                OC3PE: u1,
                ///  Output compare 3 mode
                OC3M: u3,
                ///  Output compare 3 clear enable
                OC3CE: u1,
                ///  Capture/Compare 4 selection
                CC4S: u2,
                ///  Output compare 4 fast enable
                OC4FE: u1,
                ///  Output compare 4 preload enable
                OC4PE: u1,
                ///  Output compare 4 mode
                OC4M: u3,
                ///  Output compare 4 clear enable
                OC4CE: u1,
                padding: u16,
            }),
            ///  capture/compare enable register
            CCER: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 output enable
                CC1E: u1,
                ///  Capture/Compare 1 output Polarity
                CC1P: u1,
                reserved4: u2,
                ///  Capture/Compare 2 output enable
                CC2E: u1,
                ///  Capture/Compare 2 output Polarity
                CC2P: u1,
                reserved8: u2,
                ///  Capture/Compare 3 output enable
                CC3E: u1,
                ///  Capture/Compare 3 output Polarity
                CC3P: u1,
                reserved12: u2,
                ///  Capture/Compare 4 output enable
                CC4E: u1,
                ///  Capture/Compare 3 output Polarity
                CC4P: u1,
                padding: u18,
            }),
            ///  counter
            CNT: mmio.Mmio(packed struct(u32) {
                ///  counter value
                CNT: u16,
                padding: u16,
            }),
            ///  prescaler
            PSC: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u16,
                padding: u16,
            }),
            ///  auto-reload register
            ATRLR: mmio.Mmio(packed struct(u32) {
                ///  Auto-reload value
                ATRLR: u16,
                padding: u16,
            }),
            reserved52: [4]u8,
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CH1CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CH2CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH3CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH4CVR: u16,
                padding: u16,
            }),
            reserved72: [4]u8,
            ///  DMA control register
            DMACFGR: mmio.Mmio(packed struct(u32) {
                ///  DMA base address
                DBA: u5,
                reserved8: u3,
                ///  DMA burst length
                DBL: u5,
                padding: u19,
            }),
            ///  DMA address for full transfer
            DMAADR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAADR: u16,
                padding: u16,
            }),
        };

        ///  Inter integrated circuit
        pub const I2C1 = extern struct {
            ///  Control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Peripheral enable
                PE: u1,
                reserved4: u3,
                ///  ARP enable
                ENARP: u1,
                ///  PEC enable
                ENPEC: u1,
                ///  General call enable
                ENGC: u1,
                ///  Clock stretching disable (Slave mode)
                NOSTRETCH: u1,
                ///  Start generation
                START: u1,
                ///  Stop generation
                STOP: u1,
                ///  Acknowledge enable
                ACK: u1,
                ///  Acknowledge/PEC Position (for data reception)
                POS: u1,
                ///  Packet error checking
                PEC: u1,
                reserved15: u2,
                ///  Software reset
                SWRST: u1,
                padding: u16,
            }),
            ///  Control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  Peripheral clock frequency
                FREQ: u6,
                reserved8: u2,
                ///  Error interrupt enable
                ITERREN: u1,
                ///  Event interrupt enable
                ITEVTEN: u1,
                ///  Buffer interrupt enable
                ITBUFEN: u1,
                ///  DMA requests enable
                DMAEN: u1,
                ///  DMA last transfer
                LAST: u1,
                padding: u19,
            }),
            ///  Own address register 1
            OADDR1: mmio.Mmio(packed struct(u32) {
                ///  Interface address
                ADD0: u1,
                ///  Interface address
                ADD7_1: u7,
                ///  Interface address
                ADD9_8: u2,
                reserved15: u5,
                ///  Addressing mode (slave mode)
                ADDMODE: u1,
                padding: u16,
            }),
            ///  Own address register 2
            OADDR2: mmio.Mmio(packed struct(u32) {
                ///  Dual addressing mode enable
                ENDUAL: u1,
                ///  Interface address
                ADD2: u7,
                padding: u24,
            }),
            ///  Data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  8-bit data register
                DATAR: u8,
                padding: u24,
            }),
            ///  Status register 1
            STAR1: mmio.Mmio(packed struct(u32) {
                ///  Start bit (Master mode)
                SB: u1,
                ///  Address sent (master mode)/matched (slave mode)
                ADDR: u1,
                ///  Byte transfer finished
                BTF: u1,
                ///  10-bit header sent (Master mode)
                ADD10: u1,
                ///  Stop detection (slave mode)
                STOPF: u1,
                reserved6: u1,
                ///  Data register not empty (receivers)
                RxNE: u1,
                ///  Data register empty (transmitters)
                TxE: u1,
                ///  Bus error
                BERR: u1,
                ///  Arbitration lost (master mode)
                ARLO: u1,
                ///  Acknowledge failure
                AF: u1,
                ///  Overrun/Underrun
                OVR: u1,
                ///  PEC Error in reception
                PECERR: u1,
                padding: u19,
            }),
            ///  Status register 2
            STAR2: mmio.Mmio(packed struct(u32) {
                ///  Master/slave
                MSL: u1,
                ///  Bus busy
                BUSY: u1,
                ///  Transmitter/receiver
                TRA: u1,
                reserved4: u1,
                ///  General call address (Slave mode)
                GENCALL: u1,
                reserved7: u2,
                ///  Dual flag (Slave mode)
                DUALF: u1,
                ///  acket error checking register
                PEC: u8,
                padding: u16,
            }),
            ///  Clock control register
            CKCFGR: mmio.Mmio(packed struct(u32) {
                ///  Clock control register in Fast/Standard mode (Master mode)
                CCR: u12,
                reserved14: u2,
                ///  Fast mode duty cycle
                DUTY: u1,
                ///  I2C master mode selection
                F_S: u1,
                padding: u16,
            }),
        };

        ///  Serial peripheral interface
        pub const SPI1 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Clock phase
                CPHA: u1,
                ///  Clock polarity
                CPOL: u1,
                ///  Master selection
                MSTR: u1,
                ///  Baud rate control
                BR: u3,
                ///  SPI enable
                SPE: u1,
                ///  Frame format
                LSBFIRST: u1,
                ///  Internal slave select
                SSI: u1,
                ///  Software slave management
                SSM: u1,
                ///  Receive only
                RXONLY: u1,
                ///  Data frame format
                DFF: u1,
                ///  CRC transfer next
                CRCNEXT: u1,
                ///  Hardware CRC calculation enable
                CRCEN: u1,
                ///  Output enable in bidirectional mode
                BIDIOE: u1,
                ///  Bidirectional data mode enable
                BIDIMODE: u1,
                padding: u16,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  Rx buffer DMA enable
                RXDMAEN: u1,
                ///  Tx buffer DMA enable
                TXDMAEN: u1,
                ///  SS output enable
                SSOE: u1,
                reserved5: u2,
                ///  Error interrupt enable
                ERRIE: u1,
                ///  RX buffer not empty interrupt enable
                RXNEIE: u1,
                ///  Tx buffer empty interrupt enable
                TXEIE: u1,
                padding: u24,
            }),
            ///  status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Receive buffer not empty
                RXNE: u1,
                ///  Transmit buffer empty
                TXE: u1,
                ///  Channel side
                CHSID: u1,
                ///  Underrun flag
                UDR: u1,
                ///  CRC error flag
                CRCERR: u1,
                ///  Mode fault
                MODF: u1,
                ///  Overrun flag
                OVR: u1,
                ///  Busy flag
                BSY: u1,
                padding: u24,
            }),
            ///  data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data register
                DATAR: u16,
                padding: u16,
            }),
            ///  CRCR polynomial register
            CRCR: mmio.Mmio(packed struct(u32) {
                ///  CRC polynomial register
                CRCPOLY: u16,
                padding: u16,
            }),
            ///  RX CRC register
            RCRCR: mmio.Mmio(packed struct(u32) {
                ///  Rx CRC register
                RXCRC: u16,
                padding: u16,
            }),
            ///  send CRC register
            TCRCR: mmio.Mmio(packed struct(u32) {
                ///  Tx CRC register
                TXCRC: u16,
                padding: u16,
            }),
            reserved36: [8]u8,
            ///  high speed control register
            HSCR: mmio.Mmio(packed struct(u32) {
                ///  High speed mode read enable
                HSRXEN: u1,
                padding: u31,
            }),
        };

        ///  Universal synchronous asynchronous receiver transmitter
        pub const USART1 = extern struct {
            ///  Status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Parity error
                PE: u1,
                ///  Framing error
                FE: u1,
                ///  Noise error flag
                NE: u1,
                ///  Overrun error
                ORE: u1,
                ///  IDLE line detected
                IDLE: u1,
                ///  Read data register not empty
                RXNE: u1,
                ///  Transmission complete
                TC: u1,
                ///  Transmit data register empty
                TXE: u1,
                ///  LIN break detection flag
                LBD: u1,
                ///  CTS flag
                CTS: u1,
                padding: u22,
            }),
            ///  Data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data value
                DR: u9,
                padding: u23,
            }),
            ///  Baud rate register
            BRR: mmio.Mmio(packed struct(u32) {
                ///  fraction of USARTDIV
                DIV_Fraction: u4,
                ///  mantissa of USARTDIV
                DIV_Mantissa: u12,
                padding: u16,
            }),
            ///  Control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Send break
                SBK: u1,
                ///  Receiver wakeup
                RWU: u1,
                ///  Receiver enable
                RE: u1,
                ///  Transmitter enable
                TE: u1,
                ///  IDLE interrupt enable
                IDLEIE: u1,
                ///  RXNE interrupt enable
                RXNEIE: u1,
                ///  Transmission complete interrupt enable
                TCIE: u1,
                ///  TXE interrupt enable
                TXEIE: u1,
                ///  PE interrupt enable
                PEIE: u1,
                ///  Parity selection
                PS: u1,
                ///  Parity control enable
                PCE: u1,
                ///  Wakeup method
                WAKE: u1,
                ///  Word length
                M: u1,
                ///  USART enable
                UE: u1,
                padding: u18,
            }),
            ///  Control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  Address of the USART node
                ADD: u4,
                reserved5: u1,
                ///  lin break detection length
                LBDL: u1,
                ///  LIN break detection interrupt enable
                LBDIE: u1,
                reserved8: u1,
                ///  Last bit clock pulse
                LBCL: u1,
                ///  Clock phase
                CPHA: u1,
                ///  Clock polarity
                CPOL: u1,
                ///  Clock enable
                CLKEN: u1,
                ///  STOP bits
                STOP: u2,
                ///  LIN mode enable
                LINEN: u1,
                padding: u17,
            }),
            ///  Control register 3
            CTLR3: mmio.Mmio(packed struct(u32) {
                ///  Error interrupt enable
                EIE: u1,
                ///  IrDA mode enable
                IREN: u1,
                ///  IrDA low-power
                IRLP: u1,
                ///  Half-duplex selection
                HDSEL: u1,
                ///  Smartcard NACK enable
                NACK: u1,
                ///  Smartcard mode enable
                SCEN: u1,
                ///  DMA enable receiver
                DMAR: u1,
                ///  DMA enable transmitter
                DMAT: u1,
                ///  RTS enable
                RTSE: u1,
                ///  CTS enable
                CTSE: u1,
                ///  CTS interrupt enable
                CTSIE: u1,
                padding: u21,
            }),
            ///  Guard time and prescaler register
            GPR: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u8,
                ///  Guard time value
                GT: u8,
                padding: u16,
            }),
        };

        ///  Analog to digital converter
        pub const ADC1 = extern struct {
            ///  status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog flag
                AWD: u1,
                ///  Regular channel end of conversion
                EOC: u1,
                ///  Injected channel end of conversion
                JEOC: u1,
                ///  Injected channel start flag
                JSTRT: u1,
                ///  Regular channel start flag
                STRT: u1,
                padding: u27,
            }),
            ///  control register 1/TKEY_V_CTLR
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select bits
                AWDCH: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Analog watchdog interrupt enable
                AWDIE: u1,
                ///  Interrupt enable for injected channels
                JEOCIE: u1,
                ///  Scan mode enable
                SCAN: u1,
                ///  Enable the watchdog on a single channel in scan mode
                AWDSGL: u1,
                ///  Automatic injected group conversion
                JAUTO: u1,
                ///  Discontinuous mode on regular channels
                DISCEN: u1,
                ///  Discontinuous mode on injected channels
                JDISCEN: u1,
                ///  Discontinuous mode channel count
                DISCNUM: u3,
                reserved22: u6,
                ///  Analog watchdog enable on injected channels
                JAWDEN: u1,
                ///  Analog watchdog enable on regular channels
                AWDEN: u1,
                reserved25: u1,
                ///  ADC Calibration voltage selection
                ADC_CAL_VOL: u2,
                padding: u5,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  A/D converter ON / OFF
                ADON: u1,
                ///  Continuous conversion
                CONT: u1,
                ///  A/D calibration
                CAL: u1,
                ///  Reset calibration
                RSTCAL: u1,
                reserved8: u4,
                ///  Direct memory access mode
                DMA: u1,
                reserved11: u2,
                ///  Data alignment
                ALIGN: u1,
                ///  External event select for injected group
                JEXTSEL: u3,
                ///  External trigger conversion mode for injected channels
                JEXTTRIG: u1,
                reserved17: u1,
                ///  External event select for regular group
                EXTSEL: u3,
                ///  External trigger conversion mode for regular channels
                EXTTRIG: u1,
                ///  Start conversion of injected channels
                JSWSTART: u1,
                ///  Start conversion of regular channels
                SWSTART: u1,
                padding: u9,
            }),
            ///  sample time register 1
            SAMPTR1_CHARGE1: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SMP10_TKCG10: u3,
                ///  Channel 11 sample time selection
                SMP11_TKCG11: u3,
                ///  Channel 12 sample time selection
                SMP12_TKCG12: u3,
                ///  Channel 13 sample time selection
                SMP13_TKCG13: u3,
                ///  Channel 14 sample time selection
                SMP14_TKCG14: u3,
                ///  Channel 15 sample time selection
                SMP15_TKCG15: u3,
                padding: u14,
            }),
            ///  sample time register 2
            SAMPTR2_CHARGE2: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SMP0_TKCG0: u3,
                ///  Channel 1 sample time selection
                SMP1_TKCG1: u3,
                ///  Channel 2 sample time selection
                SMP2_TKCG2: u3,
                ///  Channel 3 sample time selection
                SMP3_TKCG3: u3,
                ///  Channel 4 sample time selection
                SMP4_TKCG4: u3,
                ///  Channel 5 sample time selection
                SMP5_TKCG5: u3,
                ///  Channel 6 sample time selection
                SMP6_TKCG6: u3,
                ///  Channel 7 sample time selection
                SMP7_TKCG7: u3,
                ///  Channel 8 sample time selection
                SMP8_TKCG8: u3,
                ///  Channel 9 sample time selection
                SMP9_TKCG9: u3,
                padding: u2,
            }),
            ///  injected channel data offset register x
            IOFR1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET1: u10,
                padding: u22,
            }),
            ///  injected channel data offset register x
            IOFR2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET2: u10,
                padding: u22,
            }),
            ///  injected channel data offset register x
            IOFR3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET3: u10,
                padding: u22,
            }),
            ///  injected channel data offset register x
            IOFR4: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET4: u10,
                padding: u22,
            }),
            ///  watchdog higher threshold register
            WDHTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                HT: u10,
                padding: u22,
            }),
            ///  watchdog lower threshold register
            WDLTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                LT: u10,
                padding: u22,
            }),
            ///  regular sequence register 1
            RSQR1: mmio.Mmio(packed struct(u32) {
                ///  13th conversion in regular sequence
                SQ13: u5,
                ///  14th conversion in regular sequence
                SQ14: u5,
                ///  15th conversion in regular sequence
                SQ15: u5,
                ///  16th conversion in regular sequence
                SQ16: u5,
                ///  Regular channel sequence length
                L: u4,
                padding: u8,
            }),
            ///  regular sequence register 2
            RSQR2: mmio.Mmio(packed struct(u32) {
                ///  7th conversion in regular sequence
                SQ7: u5,
                ///  8th conversion in regular sequence
                SQ8: u5,
                ///  9th conversion in regular sequence
                SQ9: u5,
                ///  10th conversion in regular sequence
                SQ10: u5,
                ///  11th conversion in regular sequence
                SQ11: u5,
                ///  12th conversion in regular sequence
                SQ12: u5,
                padding: u2,
            }),
            ///  regular sequence register 3
            RSQR3: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in regular sequence
                SQ1: u5,
                ///  2nd conversion in regular sequence
                SQ2: u5,
                ///  3rd conversion in regular sequence
                SQ3: u5,
                ///  4th conversion in regular sequence
                SQ4: u5,
                ///  5th conversion in regular sequence
                SQ5: u5,
                ///  6th conversion in regular sequence
                SQ6: u5,
                padding: u2,
            }),
            ///  injected sequence register
            ISQR: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in injected sequence
                JSQ1: u5,
                ///  2nd conversion in injected sequence
                JSQ2: u5,
                ///  3rd conversion in injected sequence
                JSQ3: u5,
                ///  4th conversion in injected sequence
                JSQ4: u5,
                ///  Injected sequence length
                JL: u2,
                padding: u10,
            }),
            ///  injected data register 1
            IDATAR1: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                IDATA: u16,
                padding: u16,
            }),
            ///  injected data register 2
            IDATAR2: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                IDATA: u16,
                padding: u16,
            }),
            ///  injected data register 3
            IDATAR3: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                IDATA: u16,
                padding: u16,
            }),
            ///  injected data register 4
            IDATAR4: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                IDATA: u16,
                padding: u16,
            }),
            ///  regular data register
            RDATAR: mmio.Mmio(packed struct(u32) {
                ///  Regular data
                DATA: u32,
            }),
            ///  delay data register
            DLYR: mmio.Mmio(packed struct(u32) {
                ///  External trigger data delay time configuration
                DLYVLU: u9,
                ///  External trigger source delay selection
                DLYSRC: u1,
                padding: u22,
            }),
        };

        ///  Debug support
        pub const DBG = extern struct {
            ///  DBGMCU_CFGR1
            CFGR1: mmio.Mmio(packed struct(u32) {
                ///  DEG_IWDG
                DEG_IWDG: u1,
                ///  DEG_WWDG
                DEG_WWDG: u1,
                ///  DEG_I2C1
                DEG_I2C1: u1,
                reserved4: u1,
                ///  DEG_TIM1
                DEG_TIM1: u1,
                ///  DEG_TIM2
                DEG_TIM2: u1,
                padding: u26,
            }),
            ///  DBGMCU_CFGR2
            CFGR2: mmio.Mmio(packed struct(u32) {
                ///  DBG_SLEEP
                DBG_SLEEP: u1,
                ///  DBG_STOP
                DBG_STOP: u1,
                ///  DBG_STANDBY
                DBG_STANDBY: u1,
                padding: u29,
            }),
        };

        ///  Device electronic signature
        pub const ESIG = extern struct {
            ///  Flash capacity register
            FLACAP: mmio.Mmio(packed struct(u16) {
                ///  Flash size
                FLASHSIZE: u16,
            }),
            reserved8: [6]u8,
            ///  Unique identity 1
            UNIID1: mmio.Mmio(packed struct(u32) {
                ///  Unique identity[31:0]
                U_ID: u32,
            }),
            ///  Unique identity 2
            UNIID2: mmio.Mmio(packed struct(u32) {
                ///  Unique identity[63:32]
                U_ID: u32,
            }),
            ///  Unique identity 3
            UNIID3: mmio.Mmio(packed struct(u32) {
                ///  Unique identity[95:64]
                U_ID: u32,
            }),
        };
    };
};
