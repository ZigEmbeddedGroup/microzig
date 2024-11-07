const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  CH32V103xx View File
    pub const CH32V103xx = struct {
        pub const peripherals = struct {
            ///  General purpose timer
            pub const TIM2 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000000));
            ///  General purpose timer
            pub const TIM3 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000400));
            ///  General purpose timer
            pub const TIM4 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000800));
            ///  Real time clock
            pub const RTC = @as(*volatile types.peripherals.RTC, @ptrFromInt(0x40002800));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.peripherals.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.peripherals.IWDG, @ptrFromInt(0x40003000));
            ///  Serial peripheral interface
            pub const SPI2 = @as(*volatile types.peripherals.SPI1, @ptrFromInt(0x40003800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40004400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART3 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40004800));
            ///  Inter integrated circuit
            pub const I2C1 = @as(*volatile types.peripherals.I2C1, @ptrFromInt(0x40005400));
            ///  Inter integrated circuit
            pub const I2C2 = @as(*volatile types.peripherals.I2C1, @ptrFromInt(0x40005800));
            ///  Universal serial bus full-speed device interface
            pub const USBD = @as(*volatile types.peripherals.USBD, @ptrFromInt(0x40005c00));
            ///  Backup registers
            pub const BKP = @as(*volatile types.peripherals.BKP, @ptrFromInt(0x40006c00));
            ///  Power control
            pub const PWR = @as(*volatile types.peripherals.PWR, @ptrFromInt(0x40007000));
            ///  Digital to analog converter
            pub const DAC1 = @as(*volatile types.peripherals.DAC1, @ptrFromInt(0x40007400));
            ///  Alternate function I/O
            pub const AFIO = @as(*volatile types.peripherals.AFIO, @ptrFromInt(0x40010000));
            ///  EXTI
            pub const EXTI = @as(*volatile types.peripherals.EXTI, @ptrFromInt(0x40010400));
            ///  General purpose I/O
            pub const GPIOA = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40010800));
            ///  General purpose I/O
            pub const GPIOB = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40010c00));
            ///  General purpose I/O
            pub const GPIOC = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011000));
            ///  General purpose I/O
            pub const GPIOD = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011400));
            ///  Analog to digital converter
            pub const ADC = @as(*volatile types.peripherals.ADC, @ptrFromInt(0x40012400));
            ///  Advanced timer
            pub const TIM1 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface
            pub const SPI1 = @as(*volatile types.peripherals.SPI1, @ptrFromInt(0x40013000));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40013800));
            ///  DMA controller
            pub const DMA = @as(*volatile types.peripherals.DMA, @ptrFromInt(0x40020000));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.peripherals.RCC, @ptrFromInt(0x40021000));
            ///  FLASH
            pub const FLASH = @as(*volatile types.peripherals.FLASH, @ptrFromInt(0x40022000));
            ///  CRC calculation unit
            pub const CRC = @as(*volatile types.peripherals.CRC, @ptrFromInt(0x40023000));
            ///  USB register
            pub const USBHD_DEVICE = @as(*volatile types.peripherals.USBHD_DEVICE, @ptrFromInt(0x40023400));
            pub const USBHD_HOST = @as(*volatile types.peripherals.USBHD_HOST, @ptrFromInt(0x40023400));
            ///  extension configuration
            pub const EXTEND = @as(*volatile types.peripherals.EXTEND, @ptrFromInt(0x40023800));
            ///  Programmable Fast Interrupt Controller
            pub const PFIC = @as(*volatile types.peripherals.PFIC, @ptrFromInt(0xe000e000));
            ///  Debug support
            pub const DBG = @as(*volatile types.peripherals.DBG, @ptrFromInt(0xe0042000));
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  Power control
        pub const PWR = extern struct {
            ///  Power control register (PWR_CTRL)
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Low Power Deep Sleep
                LPDS: u1,
                ///  Power Down Deep Sleep
                PDDS: u1,
                ///  Clear Wake-up Flag
                CWUF: u1,
                ///  Clear STANDBY Flag
                CSBF: u1,
                ///  Power Voltage Detector Enable
                PVDE: u1,
                ///  PVD Level Selection
                PLS: u3,
                ///  Disable Backup Domain write protection
                DBP: u1,
                padding: u23,
            }),
            ///  Power control register (PWR_CSR)
            CSR: mmio.Mmio(packed struct(u32) {
                ///  Wake-Up Flag
                WUF: u1,
                ///  STANDBY Flag
                SBF: u1,
                ///  PVD Output
                PVDO: u1,
                reserved8: u5,
                ///  Enable WKUP pin
                EWUP: u1,
                padding: u23,
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
            ///  Clock configuration register(RCC_CFGR0)
            CFGR0: mmio.Mmio(packed struct(u32) {
                ///  System clock Switch
                SW: u2,
                ///  System Clock Switch Status
                SWS: u2,
                ///  AHB prescaler
                HPRE: u4,
                ///  APB Low speed prescaler(APB1)
                PPRE1: u3,
                ///  APB High speed prescaler(APB2)
                PPRE2: u3,
                ///  ADC prescaler
                ADCPRE: u2,
                ///  PLL entry clock source
                PLLSRC: u1,
                ///  HSE divider for PLL entry
                PLLXTPRE: u1,
                ///  PLL Multiplication Factor
                PLLMUL: u4,
                ///  USB prescaler
                USBPRE: u1,
                reserved24: u1,
                ///  Microcontroller clock output
                MCO: u3,
                padding: u5,
            }),
            ///  Clock interrupt register(RCC_INTR)
            INTR: mmio.Mmio(packed struct(u32) {
                ///  LSI Ready Interrupt flag
                LSIRDYF: u1,
                ///  LSE Ready Interrupt flag
                LSERDYF: u1,
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
                ///  LSE Ready Interrupt Enable
                LSERDYIE: u1,
                ///  HSI Ready Interrupt Enable
                HSIRDYIE: u1,
                ///  HSE Ready Interrupt Enable
                HSERDYIE: u1,
                ///  PLL Ready Interrupt Enable
                PLLRDYIE: u1,
                reserved16: u3,
                ///  LSI Ready Interrupt Clear
                LSIRDYC: u1,
                ///  LSE Ready Interrupt Clear
                LSERDYC: u1,
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
            ///  APB2 peripheral reset register(RCC_APB2PRSTR)
            APB2PRSTR: mmio.Mmio(packed struct(u32) {
                ///  Alternate function I/O reset
                AFIORST: u1,
                reserved2: u1,
                ///  IO port A reset
                IOPARST: u1,
                ///  IO port B reset
                IOPBRST: u1,
                ///  IO port C reset
                IOPCRST: u1,
                ///  IO port D reset
                IOPDRST: u1,
                reserved9: u3,
                ///  ADC interface reset
                ADCRST: u1,
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
            ///  APB1 peripheral reset register(RCC_APB1PRSTR)
            APB1PRSTR: mmio.Mmio(packed struct(u32) {
                ///  Timer 2 reset
                TIM2RST: u1,
                ///  Timer 3 reset
                TIM3RST: u1,
                ///  Timer 4 reset
                TIM4RST: u1,
                reserved11: u8,
                ///  Window watchdog reset
                WWDGRST: u1,
                reserved14: u2,
                ///  SPI2 reset
                SPI2RST: u1,
                reserved17: u2,
                ///  USART 2 reset
                USART2RST: u1,
                ///  USART 3 reset
                USART3RST: u1,
                reserved21: u2,
                ///  I2C1 reset
                I2C1RST: u1,
                ///  I2C2 reset
                I2C2RST: u1,
                ///  USBD reset
                USBDRST: u1,
                reserved25: u1,
                ///  CAN reset
                CANRST: u1,
                reserved27: u1,
                ///  Backup interface reset
                BKPRST: u1,
                ///  Power interface reset
                PWRRST: u1,
                ///  DAC interface reset
                DACRST: u1,
                padding: u2,
            }),
            ///  AHB Peripheral Clock enable register(RCC_AHBPCENR)
            AHBPCENR: mmio.Mmio(packed struct(u32) {
                ///  DMA clock enable
                DMAEN: u1,
                reserved2: u1,
                ///  SRAM interface clock enable
                SRAMEN: u1,
                reserved4: u1,
                ///  FLITF clock enable
                FLITFEN: u1,
                reserved6: u1,
                ///  CRC clock enable
                CRCEN: u1,
                reserved12: u5,
                ///  USBHD clock enable
                USBHDEN: u1,
                padding: u19,
            }),
            ///  APB2 peripheral clock enable register (RCC_APB2PCENR)
            APB2PCENR: mmio.Mmio(packed struct(u32) {
                ///  Alternate function I/O clock enable
                AFIOEN: u1,
                reserved2: u1,
                ///  I/O port A clock enable
                IOPAEN: u1,
                ///  I/O port B clock enable
                IOPBEN: u1,
                ///  I/O port C clock enable
                IOPCEN: u1,
                ///  I/O port D clock enable
                IOPDEN: u1,
                reserved9: u3,
                ///  ADC interface clock enable
                ADCEN: u1,
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
                ///  Timer 3 clock enable
                TIM3EN: u1,
                ///  Timer 4 clock enable
                TIM4EN: u1,
                reserved11: u8,
                ///  Window watchdog clock enable
                WWDGEN: u1,
                reserved14: u2,
                ///  SPI 2 clock enable
                SPI2EN: u1,
                reserved17: u2,
                ///  USART 2 clock enable
                USART2EN: u1,
                ///  USART 3 clock enable
                USART3EN: u1,
                reserved21: u2,
                ///  I2C 1 clock enable
                I2C1EN: u1,
                ///  I2C 2 clock enable
                I2C2EN: u1,
                ///  USBD clock enable
                USBDEN: u1,
                reserved25: u1,
                ///  CAN clock enable
                CANEN: u1,
                reserved27: u1,
                ///  Backup interface clock enable
                BKPEN: u1,
                ///  Power interface clock enable
                PWREN: u1,
                ///  DAC interface clock enable
                DACEN: u1,
                padding: u2,
            }),
            ///  Backup domain control register(RCC_BDCTLR)
            BDCTLR: mmio.Mmio(packed struct(u32) {
                ///  External Low Speed oscillator enable
                LSEON: u1,
                ///  External Low Speed oscillator ready
                LSERDY: u1,
                ///  External Low Speed oscillator bypass
                LSEBYP: u1,
                reserved8: u5,
                ///  RTC clock source selection
                RTCSEL: u2,
                reserved15: u5,
                ///  RTC clock enable
                RTCEN: u1,
                ///  Backup domain software reset
                BDRST: u1,
                padding: u15,
            }),
            ///  Control/status register(RCC_RSTSCKR)
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
            ///  AHB reset register(RCC_APHBRSTR)
            AHBRSTR: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  USBHD reset
                USBHDRST: u1,
                padding: u19,
            }),
        };

        ///  extension configuration
        pub const EXTEND = extern struct {
            ///  EXTEND register
            EXTEND_CTR: mmio.Mmio(packed struct(u32) {
                ///  USBD Lowspeed Enable
                USBDLS: u1,
                ///  USBD pullup Enable
                USBDPU: u1,
                ///  USBHD IO(PB6/PB7) Enable
                USBHDIO: u1,
                ///  USB 5V Enable
                USB5VSEL: u1,
                ///  Whether HSI is divided
                HSIPRE: u1,
                reserved6: u1,
                ///  LOCKUP
                LKUPEN: u1,
                ///  LOCKUP RESET
                LKUPRESET: u1,
                ///  ULLDOTRIM
                ULLDOTRIM: u2,
                ///  LDOTRIM
                LDOTRIM: u1,
                padding: u21,
            }),
        };

        ///  General purpose I/O
        pub const GPIOA = extern struct {
            ///  Port configuration register low(GPIOn_CFGLR)
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
            ///  Port configuration register high (GPIOn_CFGHR)
            CFGHR: mmio.Mmio(packed struct(u32) {
                ///  Port n.8 mode bits
                MODE8: u2,
                ///  Port n.8 configuration bits
                CNF8: u2,
                ///  Port n.9 mode bits
                MODE9: u2,
                ///  Port n.9 configuration bits
                CNF9: u2,
                ///  Port n.10 mode bits
                MODE10: u2,
                ///  Port n.10 configuration bits
                CNF10: u2,
                ///  Port n.11 mode bits
                MODE11: u2,
                ///  Port n.11 configuration bits
                CNF11: u2,
                ///  Port n.12 mode bits
                MODE12: u2,
                ///  Port n.12 configuration bits
                CNF12: u2,
                ///  Port n.13 mode bits
                MODE13: u2,
                ///  Port n.13 configuration bits
                CNF13: u2,
                ///  Port n.14 mode bits
                MODE14: u2,
                ///  Port n.14 configuration bits
                CNF14: u2,
                ///  Port n.15 mode bits
                MODE15: u2,
                ///  Port n.15 configuration bits
                CNF15: u2,
            }),
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
                ///  Port input data
                IDR8: u1,
                ///  Port input data
                IDR9: u1,
                ///  Port input data
                IDR10: u1,
                ///  Port input data
                IDR11: u1,
                ///  Port input data
                IDR12: u1,
                ///  Port input data
                IDR13: u1,
                ///  Port input data
                IDR14: u1,
                ///  Port input data
                IDR15: u1,
                padding: u16,
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
                ///  Port output data
                ODR8: u1,
                ///  Port output data
                ODR9: u1,
                ///  Port output data
                ODR10: u1,
                ///  Port output data
                ODR11: u1,
                ///  Port output data
                ODR12: u1,
                ///  Port output data
                ODR13: u1,
                ///  Port output data
                ODR14: u1,
                ///  Port output data
                ODR15: u1,
                padding: u16,
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
                ///  Set bit 8
                BS8: u1,
                ///  Set bit 9
                BS9: u1,
                ///  Set bit 10
                BS10: u1,
                ///  Set bit 11
                BS11: u1,
                ///  Set bit 12
                BS12: u1,
                ///  Set bit 13
                BS13: u1,
                ///  Set bit 14
                BS14: u1,
                ///  Set bit 15
                BS15: u1,
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
                ///  Reset bit 8
                BR8: u1,
                ///  Reset bit 9
                BR9: u1,
                ///  Reset bit 10
                BR10: u1,
                ///  Reset bit 11
                BR11: u1,
                ///  Reset bit 12
                BR12: u1,
                ///  Reset bit 13
                BR13: u1,
                ///  Reset bit 14
                BR14: u1,
                ///  Reset bit 15
                BR15: u1,
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
                ///  Reset bit 8
                BR8: u1,
                ///  Reset bit 9
                BR9: u1,
                ///  Reset bit 10
                BR10: u1,
                ///  Reset bit 11
                BR11: u1,
                ///  Reset bit 12
                BR12: u1,
                ///  Reset bit 13
                BR13: u1,
                ///  Reset bit 14
                BR14: u1,
                ///  Reset bit 15
                BR15: u1,
                padding: u16,
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
                ///  Port A Lock bit 8
                LCK8: u1,
                ///  Port A Lock bit 9
                LCK9: u1,
                ///  Port A Lock bit 10
                LCK10: u1,
                ///  Port A Lock bit 11
                LCK11: u1,
                ///  Port A Lock bit 12
                LCK12: u1,
                ///  Port A Lock bit 13
                LCK13: u1,
                ///  Port A Lock bit 14
                LCK14: u1,
                ///  Port A Lock bit 15
                LCK15: u1,
                ///  Lock key
                LCKK: u1,
                padding: u15,
            }),
        };

        ///  Universal serial bus full-speed device interface
        pub const USBD = extern struct {
            ///  endpoint 0 register
            EP0R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved4: [2]u8,
            ///  endpoint 1 register
            EP1R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved8: [2]u8,
            ///  endpoint 2 register
            EP2R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved12: [2]u8,
            ///  endpoint 3 register
            EP3R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved16: [2]u8,
            ///  endpoint 4 register
            EP4R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved20: [2]u8,
            ///  endpoint 5 register
            EP5R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved24: [2]u8,
            ///  endpoint 6 register
            EP6R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved28: [2]u8,
            ///  endpoint 7 register
            EP7R: mmio.Mmio(packed struct(u16) {
                ///  Endpoint address
                EA: u4,
                ///  Status bits, for transmission transfers
                STAT_TX: u2,
                ///  Data Toggle, for transmission transfers
                DTOG_TX: u1,
                ///  Correct Transfer for transmission
                CTR_TX: u1,
                ///  Endpoint kind
                EP_KIND: u1,
                ///  Endpoint type
                EP_TYPE: u2,
                ///  Setup transaction completed
                SETUP: u1,
                ///  Status bits, for reception transfers
                STAT_RX: u2,
                ///  Data Toggle, for reception transfers
                DTOG_RX: u1,
                ///  Correct transfer for reception
                CTR_RX: u1,
            }),
            reserved64: [34]u8,
            ///  control register
            CNTR: mmio.Mmio(packed struct(u16) {
                ///  Force USB Reset
                FRES: u1,
                ///  Power down
                PDWN: u1,
                ///  Low-power mode
                LPMODE: u1,
                ///  Force suspend
                FSUSP: u1,
                ///  Resume request
                RESUME: u1,
                reserved8: u3,
                ///  Expected start of frame interrupt mask
                ESOFM: u1,
                ///  Start of frame interrupt mask
                SOFM: u1,
                ///  USB reset interrupt mask
                RESETM: u1,
                ///  Suspend mode interrupt mask
                SUSPM: u1,
                ///  Wakeup interrupt mask
                WKUPM: u1,
                ///  Error interrupt mask
                ERRM: u1,
                ///  Packet memory area over / underrun interrupt mask
                PMAOVRM: u1,
                ///  Correct transfer interrupt mask
                CTRM: u1,
            }),
            reserved68: [2]u8,
            ///  interrupt status register
            ISTR: mmio.Mmio(packed struct(u16) {
                ///  Endpoint Identifier
                EP_ID: u4,
                ///  Direction of transaction
                DIR: u1,
                reserved8: u3,
                ///  Expected start frame
                ESOF: u1,
                ///  start of frame
                SOF: u1,
                ///  reset request
                RESET: u1,
                ///  Suspend mode request
                SUSP: u1,
                ///  Wakeup
                WKUP: u1,
                ///  Error
                ERR: u1,
                ///  Packet memory area over / underrun
                PMAOVR: u1,
                ///  Correct transfer
                CTR: u1,
            }),
            reserved72: [2]u8,
            ///  frame number register
            FNR: mmio.Mmio(packed struct(u16) {
                ///  Frame number
                FN: u11,
                ///  Lost SOF
                LSOF: u2,
                ///  Locked
                LCK: u1,
                ///  Receive data - line status
                RXDM: u1,
                ///  Receive data + line status
                RXDP: u1,
            }),
            reserved76: [2]u8,
            ///  device address
            DADDR: mmio.Mmio(packed struct(u16) {
                ///  Device address
                ADD: u7,
                ///  Enable function
                EF: u1,
                padding: u8,
            }),
            reserved80: [2]u8,
            ///  Buffer table address
            BTABLE: mmio.Mmio(packed struct(u16) {
                reserved3: u3,
                ///  Buffer table
                BTABLE: u13,
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
                INTENSTA: u28,
                padding: u4,
            }),
            reserved32: [24]u8,
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
                PENDSTA: u28,
                padding: u4,
            }),
            reserved64: [24]u8,
            ///  Interrupt Priority Register
            ITHRESDR: mmio.Mmio(packed struct(u32) {
                ///  THRESHOLD
                THRESHOLD: u8,
                padding: u24,
            }),
            ///  Interrupt Fast Address Register
            FIBADDRR: mmio.Mmio(packed struct(u32) {
                reserved28: u28,
                ///  BASEADDR
                BASEADDR: u4,
            }),
            ///  Interrupt Config Register
            CFGR: mmio.Mmio(packed struct(u32) {
                ///  HWSTKCTRL
                HWSTKCTRL: u1,
                ///  NESTCTRL
                NESTCTRL: u1,
                ///  NMISET
                NMISET: u1,
                ///  NMIRESET
                NMIRESET: u1,
                ///  EXCSET
                EXCSET: u1,
                ///  EXCRESET
                EXCRESET: u1,
                ///  PFICRSET
                PFICRSET: u1,
                ///  SYSRESET
                SYSRESET: u1,
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
            reserved96: [16]u8,
            ///  Interrupt 0 address Register
            FIFOADDRR0: mmio.Mmio(packed struct(u32) {
                ///  OFFADDR0
                OFFADDR0: u24,
                ///  IRQID0
                IRQID0: u8,
            }),
            ///  Interrupt 1 address Register
            FIFOADDRR1: mmio.Mmio(packed struct(u32) {
                ///  OFFADDR1
                OFFADDR1: u24,
                ///  IRQID1
                IRQID1: u8,
            }),
            ///  Interrupt 2 address Register
            FIFOADDRR2: mmio.Mmio(packed struct(u32) {
                ///  OFFADDR2
                OFFADDR2: u24,
                ///  IRQID2
                IRQID2: u8,
            }),
            ///  Interrupt 3 address Register
            FIFOADDRR3: mmio.Mmio(packed struct(u32) {
                ///  OFFADDR3
                OFFADDR3: u24,
                ///  IRQID3
                IRQID3: u8,
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
                INTEN: u28,
                padding: u4,
            }),
            reserved384: [120]u8,
            ///  Interrupt Clear Register
            IRER1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  INTRSET
                INTRSET: u20,
            }),
            ///  Interrupt Clear Register
            IRER2: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u28,
                padding: u4,
            }),
            reserved512: [120]u8,
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
                PENDSET: u28,
                padding: u4,
            }),
            reserved640: [120]u8,
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
                PENDRESET: u28,
                padding: u4,
            }),
            reserved768: [120]u8,
            ///  Interrupt ACTIVE Register
            IACTR1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  IACTS
                IACTS: u20,
            }),
            ///  Interrupt ACTIVE Register
            IACTR2: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u28,
                padding: u4,
            }),
            reserved3344: [2568]u8,
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
                padding: u26,
            }),
            reserved4096: [748]u8,
            ///  STK_CTLR Register
            STK_CTLR: mmio.Mmio(packed struct(u32) {
                ///  STE
                STE: u1,
                padding: u31,
            }),
            ///  System counter low register; modify only each 8-bits.
            STK_CNTL: mmio.Mmio(packed struct(u32) {
                ///  CNTL
                CNTL: u32,
            }),
            ///  System counter high register; modify only each 8-bits.
            STK_CNTH: mmio.Mmio(packed struct(u32) {
                ///  CNTH
                CNTH: u32,
            }),
            ///  System compare low register; modify only each 8-bits.
            STK_CMPLR: mmio.Mmio(packed struct(u32) {
                ///  CMPL
                CMPL: u32,
            }),
            ///  System compare high register; modify only each 8-bits.
            STK_CMPHR: mmio.Mmio(packed struct(u32) {
                ///  CMPH
                CMPH: u32,
            }),
        };

        ///  FLASH
        pub const FLASH = extern struct {
            ///  Flash access control register
            ACTLR: mmio.Mmio(packed struct(u32) {
                ///  Latency
                LATENCY: u3,
                reserved4: u1,
                ///  Prefetch buffer enable
                PRFTBE: u1,
                ///  Prefetch buffer status
                PRFTBS: u1,
                padding: u26,
            }),
            ///  Flash key register
            KEYR: mmio.Mmio(packed struct(u32) {
                ///  FPEC key
                KEYR: u32,
            }),
            ///  Flash option key register
            OBKEYR: mmio.Mmio(packed struct(u32) {
                ///  Option byte key
                OBKEYR: u32,
            }),
            ///  Status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Busy
                BSY: u1,
                reserved2: u1,
                ///  Programming error
                PGERR: u1,
                reserved4: u1,
                ///  Write protection error
                WRPRTERR: u1,
                ///  End of operation
                EOP: u1,
                padding: u26,
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
                ///  FAST programming lock
                FLOCK: u1,
                ///  execute fast programming
                FTPG: u1,
                ///  execute fast 128byte erase
                FTER: u1,
                ///  execute data load inner buffer
                BUFLOAD: u1,
                ///  execute inner buffer reset
                BUFRST: u1,
                padding: u12,
            }),
            ///  Flash address register
            ADDR: mmio.Mmio(packed struct(u32) {
                ///  Flash Address
                FAR: u32,
            }),
            reserved28: [4]u8,
            ///  Option byte register
            OBR: mmio.Mmio(packed struct(u32) {
                ///  Option byte error
                OPTERR: u1,
                ///  Read protection
                RDPRT: u1,
                ///  IWDG_SW
                IWDG_SW: u1,
                ///  nRST_STOP
                nRST_STOP: u1,
                ///  nRST_STDBY
                nRST_STDBY: u1,
                ///  USBD compatible speed mode configure
                USBD_MODE: u1,
                ///  USBD compatible inner pull up resistance configure
                USBD_PU: u1,
                ///  Power on reset time
                POR_CTR: u1,
                reserved10: u2,
                ///  Data0
                Data0: u8,
                ///  Data1
                Data1: u8,
                padding: u6,
            }),
            ///  Write protection register
            WPR: mmio.Mmio(packed struct(u32) {
                ///  Write protect
                WRP: u32,
            }),
            ///  Extension key register
            MODEKEYR: mmio.Mmio(packed struct(u32) {
                ///  high speed write /erase mode ENABLE
                MODEKEYR: u32,
            }),
        };

        ///  Alternate function I/O
        pub const AFIO = extern struct {
            ///  Event Control Register (AFIO_ECR)
            ECR: mmio.Mmio(packed struct(u32) {
                ///  Pin selection
                PIN: u4,
                ///  Port selection
                PORT: u3,
                ///  Event Output Enable
                EVOE: u1,
                padding: u24,
            }),
            ///  AF remap and debug I/O configuration register (AFIO_PCFR1)
            PCFR1: mmio.Mmio(packed struct(u32) {
                ///  SPI1 remapping
                SPI1_REMAP: u1,
                ///  I2C1 remapping
                I2C1_REMAP: u1,
                ///  USART1 remapping
                USART1_REMAP: u1,
                ///  USART2 remapping
                USART2_REMAP: u1,
                ///  USART3 remapping
                USART3_REMAP: u2,
                ///  TIM1 remapping
                TIM1_REMAP: u2,
                ///  TIM2 remapping
                TIM2_REMAP: u2,
                ///  TIM3 remapping
                TIM3_REMAP: u2,
                ///  TIM4 remapping
                TIM4_REMAP: u1,
                ///  CAN1 remapping
                CAN_REMAP: u2,
                ///  Port D0/Port D1 mapping on OSCIN/OSCOUT
                PD01_REMAP: u1,
                ///  Set and cleared by software
                TIM5CH4_IREMAP: u1,
                ///  ADC 1 External trigger injected conversion remapping
                ADC1_ETRGINJ_REMAP: u1,
                ///  ADC 1 external trigger regular conversion remapping
                ADC1_ETRGREG_REMAP: u1,
                ///  ADC 2 external trigger injected conversion remapping
                ADC2_ETRGINJ_REMAP: u1,
                ///  ADC 2 external trigger regular conversion remapping
                ADC2_ETRGREG_REMAP: u1,
                reserved24: u3,
                ///  Serial wire JTAG configuration
                SWJ_CFG: u3,
                padding: u5,
            }),
            ///  External interrupt configuration register 1 (AFIO_EXTICR1)
            EXTICR1: mmio.Mmio(packed struct(u32) {
                ///  EXTI0 configuration
                EXTI0: u4,
                ///  EXTI1 configuration
                EXTI1: u4,
                ///  EXTI2 configuration
                EXTI2: u4,
                ///  EXTI3 configuration
                EXTI3: u4,
                padding: u16,
            }),
            ///  External interrupt configuration register 2 (AFIO_EXTICR2)
            EXTICR2: mmio.Mmio(packed struct(u32) {
                ///  EXTI4 configuration
                EXTI4: u4,
                ///  EXTI5 configuration
                EXTI5: u4,
                ///  EXTI6 configuration
                EXTI6: u4,
                ///  EXTI7 configuration
                EXTI7: u4,
                padding: u16,
            }),
            ///  External interrupt configuration register 3 (AFIO_EXTICR3)
            EXTICR3: mmio.Mmio(packed struct(u32) {
                ///  EXTI8 configuration
                EXTI8: u4,
                ///  EXTI9 configuration
                EXTI9: u4,
                ///  EXTI10 configuration
                EXTI10: u4,
                ///  EXTI11 configuration
                EXTI11: u4,
                padding: u16,
            }),
            ///  External interrupt configuration register 4 (AFIO_EXTICR4)
            EXTICR4: mmio.Mmio(packed struct(u32) {
                ///  EXTI12 configuration
                EXTI12: u4,
                ///  EXTI13 configuration
                EXTI13: u4,
                ///  EXTI14 configuration
                EXTI14: u4,
                ///  EXTI15 configuration
                EXTI15: u4,
                padding: u16,
            }),
            reserved28: [4]u8,
            ///  AF remap and debug I/O configuration register
            PCFR2: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  TIM9 remapping
                TIM9_REMAP: u1,
                ///  TIM10 remapping
                TIM10_REMAP: u1,
                ///  TIM11 remapping
                TIM11_REMAP: u1,
                ///  TIM13 remapping
                TIM13_REMAP: u1,
                ///  TIM14 remapping
                TIM14_REMAP: u1,
                ///  NADV connect/disconnect
                FSMC_NADV: u1,
                padding: u21,
            }),
        };

        ///  EXTI
        pub const EXTI = extern struct {
            ///  Interrupt mask register(EXTI_INTENR)
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
                ///  Interrupt Mask on line 10
                MR10: u1,
                ///  Interrupt Mask on line 11
                MR11: u1,
                ///  Interrupt Mask on line 12
                MR12: u1,
                ///  Interrupt Mask on line 13
                MR13: u1,
                ///  Interrupt Mask on line 14
                MR14: u1,
                ///  Interrupt Mask on line 15
                MR15: u1,
                ///  Interrupt Mask on line 16
                MR16: u1,
                ///  Interrupt Mask on line 17
                MR17: u1,
                ///  Interrupt Mask on line 18
                MR18: u1,
                padding: u13,
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
                ///  Event Mask on line 10
                MR10: u1,
                ///  Event Mask on line 11
                MR11: u1,
                ///  Event Mask on line 12
                MR12: u1,
                ///  Event Mask on line 13
                MR13: u1,
                ///  Event Mask on line 14
                MR14: u1,
                ///  Event Mask on line 15
                MR15: u1,
                ///  Event Mask on line 16
                MR16: u1,
                ///  Event Mask on line 17
                MR17: u1,
                ///  Event Mask on line 18
                MR18: u1,
                padding: u13,
            }),
            ///  Rising Trigger selection register(EXTI_RTENR)
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
                ///  Rising trigger event configuration of line 10
                TR10: u1,
                ///  Rising trigger event configuration of line 11
                TR11: u1,
                ///  Rising trigger event configuration of line 12
                TR12: u1,
                ///  Rising trigger event configuration of line 13
                TR13: u1,
                ///  Rising trigger event configuration of line 14
                TR14: u1,
                ///  Rising trigger event configuration of line 15
                TR15: u1,
                ///  Rising trigger event configuration of line 16
                TR16: u1,
                ///  Rising trigger event configuration of line 17
                TR17: u1,
                ///  Rising trigger event configuration of line 18
                TR18: u1,
                padding: u13,
            }),
            ///  Falling Trigger selection register(EXTI_FTENR)
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
                ///  Falling trigger event configuration of line 10
                TR10: u1,
                ///  Falling trigger event configuration of line 11
                TR11: u1,
                ///  Falling trigger event configuration of line 12
                TR12: u1,
                ///  Falling trigger event configuration of line 13
                TR13: u1,
                ///  Falling trigger event configuration of line 14
                TR14: u1,
                ///  Falling trigger event configuration of line 15
                TR15: u1,
                ///  Falling trigger event configuration of line 16
                TR16: u1,
                ///  Falling trigger event configuration of line 17
                TR17: u1,
                ///  Falling trigger event configuration of line 18
                TR18: u1,
                padding: u13,
            }),
            ///  Software interrupt event register(EXTI_SWIEVR)
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
                ///  Software Interrupt on line 10
                SWIER10: u1,
                ///  Software Interrupt on line 11
                SWIER11: u1,
                ///  Software Interrupt on line 12
                SWIER12: u1,
                ///  Software Interrupt on line 13
                SWIER13: u1,
                ///  Software Interrupt on line 14
                SWIER14: u1,
                ///  Software Interrupt on line 15
                SWIER15: u1,
                ///  Software Interrupt on line 16
                SWIER16: u1,
                ///  Software Interrupt on line 17
                SWIER17: u1,
                ///  Software Interrupt on line 18
                SWIER18: u1,
                padding: u13,
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
                ///  Pending bit 10
                PR10: u1,
                ///  Pending bit 11
                PR11: u1,
                ///  Pending bit 12
                PR12: u1,
                ///  Pending bit 13
                PR13: u1,
                ///  Pending bit 14
                PR14: u1,
                ///  Pending bit 15
                PR15: u1,
                ///  Pending bit 16
                PR16: u1,
                ///  Pending bit 17
                PR17: u1,
                ///  Pending bit 18
                PR18: u1,
                padding: u13,
            }),
        };

        ///  DMA controller
        pub const DMA = extern struct {
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

        ///  Real time clock
        pub const RTC = extern struct {
            ///  RTC Control Register High
            CTLRH: mmio.Mmio(packed struct(u32) {
                ///  Second interrupt Enable
                SECIE: u1,
                ///  Alarm interrupt Enable
                ALRIE: u1,
                ///  Overflow interrupt Enable
                OWIE: u1,
                padding: u29,
            }),
            ///  RTC Control Register Low
            CTLRL: mmio.Mmio(packed struct(u32) {
                ///  Second Flag
                SECF: u1,
                ///  Alarm Flag
                ALRF: u1,
                ///  Overflow Flag
                OWF: u1,
                ///  Registers Synchronized Flag
                RSF: u1,
                ///  Configuration Flag
                CNF: u1,
                ///  RTC operation OFF
                RTOFF: u1,
                padding: u26,
            }),
            ///  RTC Prescaler Load Register High
            PSCRH: mmio.Mmio(packed struct(u32) {
                ///  RTC Prescaler Load Register High
                PRLH: u4,
                padding: u28,
            }),
            ///  RTC Prescaler Load Register Low
            PSCRL: mmio.Mmio(packed struct(u32) {
                ///  RTC Prescaler Divider Register Low
                PRLL: u16,
                padding: u16,
            }),
            ///  RTC Prescaler Divider Register High
            DIVH: mmio.Mmio(packed struct(u32) {
                ///  RTC prescaler divider register high
                DIVH: u4,
                padding: u28,
            }),
            ///  RTC Prescaler Divider Register Low
            DIVL: mmio.Mmio(packed struct(u32) {
                ///  RTC prescaler divider register Low
                DIVL: u16,
                padding: u16,
            }),
            ///  RTC Counter Register High
            CNTH: mmio.Mmio(packed struct(u32) {
                ///  RTC counter register high
                CNTH: u16,
                padding: u16,
            }),
            ///  RTC Counter Register Low
            CNTL: mmio.Mmio(packed struct(u32) {
                ///  RTC counter register Low
                CNTL: u16,
                padding: u16,
            }),
            ///  RTC Alarm Register High
            ALRMH: mmio.Mmio(packed struct(u32) {
                ///  RTC alarm register high
                ALRMH: u16,
                padding: u16,
            }),
            ///  RTC Alarm Register Low
            ALRML: mmio.Mmio(packed struct(u32) {
                ///  RTC alarm register low
                ALRML: u16,
                padding: u16,
            }),
        };

        ///  Backup registers
        pub const BKP = extern struct {
            reserved4: [4]u8,
            ///  Backup data register (BKP_DR)
            DATAR1: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D1: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR2: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D2: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR3: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D3: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR4: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D4: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR5: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D5: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR6: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D6: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR7: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D7: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR8: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D8: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR9: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D9: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR10: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D10: u16,
                padding: u16,
            }),
            ///  RTC clock calibration register (BKP_OCTLR)
            OCTLR: mmio.Mmio(packed struct(u32) {
                ///  Calibration value
                CAL: u7,
                ///  Calibration Clock Output
                CCO: u1,
                ///  Alarm or second output enable
                ASOE: u1,
                ///  Alarm or second output selection
                ASOS: u1,
                padding: u22,
            }),
            ///  Backup control register (BKP_TPCTLR)
            TPCTLR: mmio.Mmio(packed struct(u32) {
                ///  Tamper pin enable
                TPE: u1,
                ///  Tamper pin active level
                TPAL: u1,
                padding: u30,
            }),
            ///  BKP_TPCSR control/status register (BKP_CSR)
            TPCSR: mmio.Mmio(packed struct(u32) {
                ///  Clear Tamper event
                CTE: u1,
                ///  Clear Tamper Interrupt
                CTI: u1,
                ///  Tamper Pin interrupt enable
                TPIE: u1,
                reserved8: u5,
                ///  Tamper Event Flag
                TEF: u1,
                ///  Tamper Interrupt Flag
                TIF: u1,
                padding: u22,
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
                padding: u22,
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
                ARR: u16,
                padding: u16,
            }),
            ///  repetition counter register
            RPTCR: mmio.Mmio(packed struct(u32) {
                ///  Repetition counter value
                REP: u8,
                padding: u24,
            }),
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CCR1: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CCR2: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CCR3: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CCR4: u16,
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
            DMAR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAB: u16,
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
                padding: u22,
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
                ///  Capture/Compare control update generation
                COMG: u1,
                ///  Trigger generation
                TG: u1,
                ///  Break generation
                BG: u1,
                padding: u24,
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
                ARR: u16,
                padding: u16,
            }),
            reserved52: [4]u8,
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CCR1: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CCR2: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CCR3: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CCR4: u16,
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
            DMAR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAB: u16,
                padding: u16,
            }),
        };

        ///  CRC calculation unit
        pub const CRC = extern struct {
            ///  Data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data Register
                DATA: u32,
            }),
            ///  Independent Data register
            IDATAR: mmio.Mmio(packed struct(u32) {
                ///  Independent Data register
                IDATA: u8,
                padding: u24,
            }),
            ///  Control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Reset bit
                RST: u1,
                padding: u31,
            }),
        };

        ///  USB register
        pub const USBHD_DEVICE = extern struct {
            ///  USB base control
            R8_USB_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                RB_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                RB_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                RB_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                RB_UC_INT_BUSY: u1,
                ///  bit mask of USB system control
                MASK_UC_SYS_CTRL: u2,
                ///  enable USB low speed: 0=12Mbps, 1=1.5Mbps
                RB_UC_LOW_SPEED: u1,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            ///  USB device physical prot control
            R8_UDEV_CTRL: mmio.Mmio(packed struct(u8) {
                ///  enable USB physical port I/O: 0=disable, 1=enable;enable USB port: 0=disable, 1=enable port, automatic disabled if USB device detached
                RB_UD_PORT_EN: u1,
                ///  general purpose bit
                RB_UD_GP_BIT: u1,
                ///  enable USB physical port low speed: 0=full speed, 1=low speed
                RB_UD_LOW_SPEED: u1,
                reserved4: u1,
                ///  ReadOnly: indicate current UDM pin level
                RB_UD_DM_PIN: u1,
                ///  ReadOnly: indicate current UDP pin level
                RB_UD_DP_PIN: u1,
                reserved7: u1,
                ///  disable USB UDP/UDM pulldown resistance: 0=enable pulldown, 1=disable
                RB_UD_PD_DIS: u1,
            }),
            ///  USB interrupt enable
            R8_USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB bus reset event for USB device mode
                RB_UIE_BUS_RST: u1,
                ///  enable interrupt for USB transfer completion
                RB_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                RB_UIE_SUSPEND: u1,
                ///  enable interrupt for host SOF timer action for USB host mode
                RB_UIE_HST_SOF: u1,
                ///  enable interrupt for FIFO overflow
                RB_UIE_FIFO_OV: u1,
                reserved6: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_DEV_NAK: u1,
                ///  enable interrupt for SOF received for USB device mode
                RB_UIE_DEV_SOF: u1,
            }),
            ///  USB device address
            R8_USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            reserved5: [1]u8,
            ///  USB miscellaneous status
            R8_USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_DEV_ATTACH: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_DM_LEVEL: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            R8_USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  bus reset event interrupt flag for USB device mode, direct bit address clear or write 1 to clear
                RB_UIF_BUS_RST: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  RO, indicate USB SIE free status
                RB_U_SIE_FREE: u1,
                ///  RO, indicate current USB transfer toggle is OK
                RB_U_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            R8_USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer handshake response for USB host mode: 0000=no response, time out from device, others=handshake response PID received
                MASK_UIS_H_RES: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            /// V103 is u10
            R16_USB_RX_LEN: u16,
            // reserved12: [3]u8, for F103
            reserved12: [2]u8,
            ///  endpoint 4/1 mode
            R8_UEP4_1_MOD: mmio.Mmio(packed struct(u8) {
                reserved2: u2,
                ///  enable USB endpoint 4 transmittal (IN)
                RB_UEP4_TX_EN: u1,
                ///  enable USB endpoint 4 receiving (OUT)
                RB_UEP4_RX_EN: u1,
                ///  buffer mode of USB endpoint 1
                RB_UEP1_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 1 transmittal (IN)
                RB_UEP1_TX_EN: u1,
                ///  enable USB endpoint 1 receiving (OUT)
                RB_UEP1_RX_EN: u1,
            }),
            ///  endpoint 2/3 mode
            R8_UEP2_3_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 2
                RB_UEP2_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 2 transmittal (IN)
                RB_UEP2_TX_EN: u1,
                ///  enable USB endpoint 2 receiving (OUT)
                RB_UEP2_RX_EN: u1,
                ///  buffer mode of USB endpoint 3
                RB_UEP3_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 3 transmittal (IN)
                RB_UEP3_TX_EN: u1,
                ///  enable USB endpoint 3 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            ///  endpoint 5/6 mode
            R8_UEP5_6_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 2
                RB_UEP5_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 2 transmittal (IN)
                RB_UEP5_TX_EN: u1,
                ///  enable USB endpoint 2 receiving (OUT)
                RB_UEP5_RX_EN: u1,
                ///  buffer mode of USB endpoint 3
                RB_UEP6_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 3 transmittal (IN)
                RB_UEP6_TX_EN: u1,
                ///  enable USB endpoint 3 receiving (OUT)
                RB_UEP6_RX_EN: u1,
            }),
            ///  endpoint 7 mode
            R8_UEP7_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 7
                RB_UEP7_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 7 transmittal (IN)
                RB_UEP7_TX_EN: u1,
                ///  enable USB endpoint 7 receiving (OUT)
                RB_UEP7_RX_EN: u1,
                reserved8: u4,
            }),
            ///  endpoint 0 DMA buffer address
            R16_UEP0_DMA: u16,
            reserved20: [2]u8,
            ///  endpoint 1 DMA buffer address
            R16_UEP1_DMA: u16,
            reserved24: [2]u8,
            ///  endpoint 2 DMA buffer address
            R16_UEP2_DMA: u16,
            reserved28: [2]u8,
            ///  endpoint 3 DMA buffer address
            R16_UEP3_DMA: u16,
            reserved32: [2]u8,
            ///  endpoint 4 DMA buffer address
            R16_UEP4_DMA: u16,
            reserved36: [2]u8,
            ///  endpoint 5 DMA buffer address
            R16_UEP5_DMA: u16,
            reserved40: [2]u8,
            ///  endpoint 6 DMA buffer address
            R16_UEP6_DMA: u16,
            reserved44: [2]u8,
            ///  endpoint 7 DMA buffer address
            R16_UEP7_DMA: u16,
            reserved48: [2]u8,
            ///  endpoint 0 transmittal length
            R16_UEP0_T_LEN: u16,
            ///  endpoint 0 control
            R8_UEP0_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved53: [1]u8,
            ///  endpoint 1 transmittal length
            R16_UEP1_T_LEN: u16,
            ///  endpoint 1 control
            R8_UEP1_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1;RB_UH_PRE_PID_EN
                RB_UEP_R_TOG: u1,
            }),
            reserved57: [1]u8,
            ///  endpoint 2 transmittal length
            R16_UEP2_T_LEN: u16,
            ///  endpoint 2 control
            R8_UEP2_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved61: [1]u8,
            ///  endpoint 3 transmittal length
            R16_UEP3_T_LEN: u16,
            ///  endpoint 3 control
            R8_UEP3_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved65: [1]u8,
            ///  endpoint 4 transmittal length
            R16_UEP4_T_LEN: u16,
            ///  endpoint 4 control
            R8_UEP4_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved68: [1]u8,
            ///  endpoint 5 transmittal length
            R16_UEP5_T_LEN: u16,
            ///  endpoint 5 control
            R8_UEP5_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved72: [1]u8,
            ///  endpoint 6 transmittal length
            R16_UEP6_T_LEN: u16,
            ///  endpoint 6 control
            R8_UEP6_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
            reserved76: [1]u8,
            ///  endpoint 7 transmittal length
            R16_UEP7_T_LEN: u16,
            ///  endpoint 7 control
            R8_UEP7_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
        };

        pub const USBHD_HOST = extern struct {
            ///  USB base control
            R8_USB_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                RB_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                RB_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                RB_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                RB_UC_INT_BUSY: u1,
                ///  bit mask of USB system control
                MASK_UC_SYS_CTRL: u2,
                ///  enable USB low speed: 0=12Mbps, 1=1.5Mbps
                RB_UC_LOW_SPEED: u1,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            ///  USB device physical prot control
            R8_UHOST_CTRL: mmio.Mmio(packed struct(u8) {
                ///  enable USB port: 0=disable, 1=enable port, automatic disabled if USB device detached
                RB_UH_PORT_EN: u1,
                ///  control USB bus reset: 0=normal, 1=force bus reset
                RB_UH_BUS_RESET: u1,
                ///  enable USB port low speed: 0=full speed, 1=low speed
                RB_UH_LOW_SPEED: u1,
                reserved4: u1,
                ///  ReadOnly: indicate current UDM pin level
                RB_UH_DM_PIN: u1,
                ///  ReadOnly: indicate current UDP pin level
                RB_UH_DP_PIN: u1,
                reserved7: u1,
                ///  disable USB UDP/UDM pulldown resistance: 0=enable pulldown, 1=disable
                RB_UH_PD_DIS: u1,
            }),
            ///  USB interrupt enable
            R8_USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB device detected event for USB host mode
                RB_UIE_DETECT: u1,
                ///  enable interrupt for USB transfer completion
                RB_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                RB_UIE_SUSPEND: u1,
                ///  enable interrupt for host SOF timer action for USB host mode
                RB_UIE_HST_SOF: u1,
                ///  enable interrupt for FIFO overflow
                RB_UIE_FIFO_OV: u1,
                reserved6: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_DEV_NAK: u1,
                ///  enable interrupt for SOF received for USB device mode
                RB_UIE_DEV_SOF: u1,
            }),
            ///  USB device address
            R8_USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            reserved5: [1]u8,
            ///  USB miscellaneous status
            R8_USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_DEV_ATTACH: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_DM_LEVEL: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            R8_USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  device detected event interrupt flag for USB host mode, direct bit address clear or write 1 to clear
                RB_UIF_DETECT: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  RO, indicate USB SIE free status
                RB_U_SIE_FREE: u1,
                ///  RO, indicate current USB transfer toggle is OK
                RB_U_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            R8_USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer endpoint number for USB device mode
                MASK_UIS_ENDP: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            /// V103 is u10
            R16_USB_RX_LEN: u16,
            // reserved12: [3]u8, for F103
            reserved14: [3]u8,
            ///  host endpoint mode
            R8_UH_EP_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB host IN endpoint
                RB_UH_EP_RBUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 2 transmittal (IN)
                RB_UEP2_TX_EN: u1,
                ///  enable USB host IN endpoint receiving
                RB_UH_EP_RX_EN: u1,
                ///  buffer mode of USB host OUT endpoint
                RB_UH_EP_TBUF_MOD: u1,
                reserved6: u1,
                ///  enable USB host OUT endpoint transmittal
                RB_UH_EP_TX_EN: u1,
                ///  enable USB endpoint 3 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            reserved24: [10]u8,
            ///  host rx endpoint buffer high address
            R16_UH_RX_DMA: u16,
            reserved28: [2]u8,
            ///  host tx endpoint buffer high address
            R16_UH_TX_DMA: u16,
            reserved55: [24]u8,
            ///  host aux setup
            R8_UH_SETUP: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  USB host automatic SOF enable
                RB_UH_SOF_EN: u1,
                ///  USB host PRE PID enable for low speed device via hub
                RB_UH_PRE_PID_EN: u1,
            }),
            reserved57: [1]u8,
            ///  host endpoint and PID
            R8_UH_EP_PID: mmio.Mmio(packed struct(u8) {
                ///  bit mask of endpoint number for USB host transfer
                MASK_UH_ENDP: u4,
                ///  bit mask of token PID for USB host transfer
                MASK_UH_TOKEN: u4,
            }),
            reserved59: [1]u8,
            ///  host receiver endpoint control
            R8_UH_RX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion: 0=manual toggle, 1=automatic toggle
                RB_UH_R_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of host receiving (IN): 0=DATA0, 1=DATA1
                RB_UH_R_TOG: u1,
            }),
            reserved61: [1]u8,
            ///  host transmittal endpoint transmittal length
            R16_UH_TX_LEN: u16,
            ///  host transmittal endpoint control
            R8_UH_TX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                RB_UEP_AUTO_TOG: u1,
                reserved6: u1,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                RB_UEP_T_TOG: u1,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                RB_UEP_R_TOG: u1,
            }),
        };

        ///  Inter integrated circuit
        pub const I2C1 = extern struct {
            ///  Control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Peripheral enable
                PE: u1,
                ///  SMBus mode
                SMBUS: u1,
                reserved3: u1,
                ///  SMBus type
                SMBTYPE: u1,
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
                ///  SMBus alert
                ALERT: u1,
                reserved15: u1,
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
                reserved14: u4,
                ///  must set 1 bit
                MUST1: u1,
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
                DR: u8,
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
                reserved14: u1,
                ///  Timeout or Tlow error
                TIMEOUT: u1,
                ///  SMBus alert
                SMBALERT: u1,
                padding: u16,
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
                ///  SMBus device default address (Slave mode)
                SMBDEFAULT: u1,
                ///  SMBus host header (Slave mode)
                SMBHOST: u1,
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
            ///  RTR register
            RTR: mmio.Mmio(packed struct(u32) {
                ///  Maximum rise time in Fast/Standard mode (Master mode)
                TRISE: u6,
                padding: u26,
            }),
        };

        ///  Debug support
        pub const DBG = extern struct {
            ///  DBGMCU_IDCODE
            IDCODE: mmio.Mmio(packed struct(u32) {
                ///  DEV_ID
                DEV_ID: u12,
                reserved16: u4,
                ///  REV_ID
                REV_ID: u16,
            }),
            ///  DBGMCU_CFGR
            CFGR: mmio.Mmio(packed struct(u32) {
                ///  DBG_SLEEP
                DBG_SLEEP: u1,
                ///  DBG_STOP
                DBG_STOP: u1,
                ///  DBG_STANDBY
                DBG_STANDBY: u1,
                reserved5: u2,
                ///  TRACE_IOEN
                TRACE_IOEN: u1,
                ///  TRACE_MODE
                TRACE_MODE: u2,
                ///  DBG_IWDG_STOP
                DBG_IWDG_STOP: u1,
                ///  DBG_WWDG_STOP
                DBG_WWDG_STOP: u1,
                ///  DBG_TIM1_STOP
                DBG_TIM1_STOP: u1,
                ///  DBG_TIM2_STOP
                DBG_TIM2_STOP: u1,
                ///  DBG_TIM3_STOP
                DBG_TIM3_STOP: u1,
                ///  DBG_TIM4_STOP
                DBG_TIM4_STOP: u1,
                ///  DBG_CAN1_STOP
                DBG_CAN1_STOP: u1,
                ///  DBG_I2C1_SMBUS_TIMEOUT
                DBG_I2C1_SMBUS_TIMEOUT: u1,
                ///  DBG_I2C2_SMBUS_TIMEOUT
                DBG_I2C2_SMBUS_TIMEOUT: u1,
                ///  DBG_TIM8_STOP
                DBG_TIM8_STOP: u1,
                ///  DBG_TIM5_STOP
                DBG_TIM5_STOP: u1,
                ///  DBG_TIM6_STOP
                DBG_TIM6_STOP: u1,
                ///  DBG_TIM7_STOP
                DBG_TIM7_STOP: u1,
                ///  DBG_CAN2_STOP
                DBG_CAN2_STOP: u1,
                padding: u10,
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
                reserved4: u2,
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
                RxCRC: u16,
                padding: u16,
            }),
            ///  TX CRC register
            TCRCR: mmio.Mmio(packed struct(u32) {
                ///  Tx CRC register
                TxCRC: u16,
                padding: u16,
            }),
            ///  I2S configuration register
            I2SCFGR: mmio.Mmio(packed struct(u32) {
                ///  Channel length (number of bits per audio channel)
                CHLEN: u1,
                ///  Data length to be transferred
                DATLEN: u2,
                ///  Steady state clock polarity
                CKPOL: u1,
                ///  I2S standard selection
                I2SSTD: u2,
                reserved7: u1,
                ///  PCM frame synchronization
                PCMSYNC: u1,
                ///  I2S configuration mode
                I2SCFG: u2,
                ///  I2S Enable
                I2SE: u1,
                ///  I2S mode selection
                I2SMOD: u1,
                padding: u20,
            }),
            ///  I2S prescaler register
            I2SPR: mmio.Mmio(packed struct(u32) {
                ///  I2S Linear prescaler
                I2SDIV: u8,
                ///  Odd factor for the prescaler
                ODD: u1,
                ///  Master clock output enable
                MCKOE: u1,
                padding: u22,
            }),
        };

        ///  Digital to analog converter
        pub const DAC1 = extern struct {
            ///  Control register (DAC_CTLR)
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 enable
                EN1: u1,
                ///  DAC channel1 output buffer disable
                BOFF1: u1,
                ///  DAC channel1 trigger enable
                TEN1: u1,
                ///  DAC channel1 trigger selection
                TSEL1: u3,
                ///  DAC channel1 noise/triangle wave generation enable
                WAVE1: u2,
                ///  DAC channel1 mask/amplitude selector
                MAMP1: u4,
                ///  DAC channel1 DMA enable
                DMAEN1: u1,
                reserved16: u3,
                ///  DAC channel2 enable
                EN2: u1,
                ///  DAC channel2 output buffer disable
                BOFF2: u1,
                ///  DAC channel2 trigger enable
                TEN2: u1,
                ///  DAC channel2 trigger selection
                TSEL2: u3,
                ///  DAC channel2 noise/triangle wave generation enable
                WAVE2: u2,
                ///  DAC channel2 mask/amplitude selector
                MAMP2: u4,
                ///  DAC channel2 DMA enable
                DMAEN2: u1,
                padding: u3,
            }),
            ///  DAC software trigger register (DAC_SWTR)
            SWTR: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 software trigger
                SWTRIG1: u1,
                ///  DAC channel2 software trigger
                SWTRIG2: u1,
                padding: u30,
            }),
            ///  DAC channel1 12-bit right-aligned data holding register(DAC_R12BDHR1)
            R12BDHR1: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 12-bit right-aligned data
                DACC1DHR: u12,
                padding: u20,
            }),
            ///  DAC channel1 12-bit left aligned data holding register (DAC_L12BDHR1)
            L12BDHR1: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC channel1 12-bit left-aligned data
                DACC1DHR: u12,
                padding: u16,
            }),
            reserved20: [4]u8,
            ///  DAC channel2 12-bit right aligned data holding register (DAC_R12BDHR2)
            R12BDHR2: mmio.Mmio(packed struct(u32) {
                ///  DAC channel2 12-bit right-aligned data
                DACC2DHR: u12,
                padding: u20,
            }),
            ///  DAC channel2 12-bit left aligned data holding register (DAC_L12BDHR2)
            L12BDHR2: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC channel2 12-bit left-aligned data
                DACC2DHR: u12,
                padding: u16,
            }),
            reserved44: [16]u8,
            ///  DAC channel1 data output register (DAC_DOR1)
            DOR1: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 data output
                DACC1DOR: u12,
                padding: u20,
            }),
            ///  DAC channel2 data output register (DAC_DOR2)
            DOR2: mmio.Mmio(packed struct(u32) {
                ///  DAC channel2 data output
                DACC2DOR: u12,
                padding: u20,
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
        pub const ADC = extern struct {
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
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select bits
                AWDCH: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Analog watchdog interrupt enable
                AWDIE: u1,
                ///  Interrupt enable for injected channels
                JEOCIE: u1,
                ///  Scan mode
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
                ///  Dual mode selection
                DUALMOD: u4,
                reserved22: u2,
                ///  Analog watchdog enable on injected channels
                JAWDEN: u1,
                ///  Analog watchdog enable on regular channels
                AWDEN: u1,
                ///  Touch key enable, including TKEY_F and TKEY_V
                TKENABLE: u1,
                padding: u7,
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
                ///  Temperature sensor and VREFINT enable
                TSVREFE: u1,
                padding: u8,
            }),
            ///  sample time register 1
            SAMPTR1: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SMP10: u3,
                ///  Channel 11 sample time selection
                SMP11: u3,
                ///  Channel 12 sample time selection
                SMP12: u3,
                ///  Channel 13 sample time selection
                SMP13: u3,
                ///  Channel 14 sample time selection
                SMP14: u3,
                ///  Channel 15 sample time selection
                SMP15: u3,
                ///  Channel 16 sample time selection
                SMP16: u3,
                ///  Channel 17 sample time selection
                SMP17: u3,
                padding: u8,
            }),
            ///  sample time register 2
            SAMPTR2: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SMP0: u3,
                ///  Channel 1 sample time selection
                SMP1: u3,
                ///  Channel 2 sample time selection
                SMP2: u3,
                ///  Channel 3 sample time selection
                SMP3: u3,
                ///  Channel 4 sample time selection
                SMP4: u3,
                ///  Channel 5 sample time selection
                SMP5: u3,
                ///  Channel 6 sample time selection
                SMP6: u3,
                ///  Channel 7 sample time selection
                SMP7: u3,
                ///  Channel 8 sample time selection
                SMP8: u3,
                ///  Channel 9 sample time selection
                SMP9: u3,
                padding: u2,
            }),
            ///  injected channel data offset register x
            IOFR1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET1: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET2: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET3: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR4: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET4: u12,
                padding: u20,
            }),
            ///  watchdog higher threshold register
            WDHTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                HT: u12,
                padding: u20,
            }),
            ///  watchdog lower threshold register
            WDLTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                LT: u12,
                padding: u20,
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
            ///  injected data register x
            IDATAR1: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR2: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR3: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR4: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  regular data register
            RDATAR: mmio.Mmio(packed struct(u32) {
                ///  Regular data
                DATA: u16,
                ///  ADC2 data
                ADC2DATA: u16,
            }),
        };
    };
};
