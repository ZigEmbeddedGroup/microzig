const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCPRE = enum(u2) {
    /// PCLK2 divided by 2
    Div2 = 0x0,
    /// PCLK2 divided by 4
    Div4 = 0x1,
    /// PCLK2 divided by 6
    Div6 = 0x2,
    /// PCLK2 divided by 8
    Div8 = 0x3,
};

pub const HPRE = enum(u4) {
    /// SYSCLK not divided
    Div1 = 0x0,
    /// SYSCLK divided by 2
    Div2 = 0x8,
    /// SYSCLK divided by 4
    Div4 = 0x9,
    /// SYSCLK divided by 8
    Div8 = 0xa,
    /// SYSCLK divided by 16
    Div16 = 0xb,
    /// SYSCLK divided by 64
    Div64 = 0xc,
    /// SYSCLK divided by 128
    Div128 = 0xd,
    /// SYSCLK divided by 256
    Div256 = 0xe,
    /// SYSCLK divided by 512
    Div512 = 0xf,
    _,
};

pub const I2S2SRC = enum(u1) {
    /// System clock (SYSCLK) selected as I2S clock entry
    SYS = 0x0,
    /// PLL3 VCO clock selected as I2S clock entry
    PLL3 = 0x1,
};

pub const MCOSEL = enum(u4) {
    /// MCO output disabled, no clock on MCO
    DISABLE = 0x0,
    /// System clock selected
    SYS = 0x4,
    /// HSI oscillator clock selected
    HSI = 0x5,
    /// HSE oscillator clock selected
    HSE = 0x6,
    /// PLL clock divided by 2 selected
    PLL = 0x7,
    /// PLL2 clock selected
    PLL2 = 0x8,
    /// PLL3 clock divided by 2 selected
    PLL3DIV2 = 0x9,
    /// XT1 external oscillator selected
    XT1 = 0xa,
    /// PLL3 clock selected
    PLL3 = 0xb,
    _,
};

pub const PLL2MUL = enum(u4) {
    /// PLL clock entry x8
    Mul8 = 0x6,
    /// PLL clock entry x9
    Mul9 = 0x7,
    /// PLL clock entry x10
    Mul10 = 0x8,
    /// PLL clock entry x11
    Mul11 = 0x9,
    /// PLL clock entry x12
    Mul12 = 0xa,
    /// PLL clock entry x13
    Mul13 = 0xb,
    /// PLL clock entry x14
    Mul14 = 0xc,
    /// PLL clock entry x16
    Mul16 = 0xe,
    /// PLL clock entry x20
    Mul20 = 0xf,
    _,
};

pub const PLLMUL = enum(u4) {
    /// PLL input clock x4
    Mul4 = 0x2,
    /// PLL input clock x5
    Mul5 = 0x3,
    /// PLL input clock x6
    Mul6 = 0x4,
    /// PLL input clock x7
    Mul7 = 0x5,
    /// PLL input clock x8
    Mul8 = 0x6,
    /// PLL input clock x9
    Mul9 = 0x7,
    /// PLL input clock x6.5
    Mul6_5 = 0xd,
    _,
};

pub const PLLSRC = enum(u1) {
    /// HSI divided by 2 selected as PLL input clock
    HSI_Div2 = 0x0,
    /// HSE divided by PREDIV selected as PLL input clock
    HSE_Div_PREDIV = 0x1,
};

pub const PLLXTPRE = enum(u1) {
    /// HSE clock not divided
    Div1 = 0x0,
    /// HSE clock divided by 2
    Div2 = 0x1,
};

pub const PPRE = enum(u3) {
    /// HCLK not divided
    Div1 = 0x0,
    /// HCLK divided by 2
    Div2 = 0x4,
    /// HCLK divided by 4
    Div4 = 0x5,
    /// HCLK divided by 8
    Div8 = 0x6,
    /// HCLK divided by 16
    Div16 = 0x7,
    _,
};

pub const PREDIV1 = enum(u4) {
    /// PREDIV input clock not divided
    Div1 = 0x0,
    /// PREDIV input clock divided by 2
    Div2 = 0x1,
    /// PREDIV input clock divided by 3
    Div3 = 0x2,
    /// PREDIV input clock divided by 4
    Div4 = 0x3,
    /// PREDIV input clock divided by 5
    Div5 = 0x4,
    /// PREDIV input clock divided by 6
    Div6 = 0x5,
    /// PREDIV input clock divided by 7
    Div7 = 0x6,
    /// PREDIV input clock divided by 8
    Div8 = 0x7,
    /// PREDIV input clock divided by 9
    Div9 = 0x8,
    /// PREDIV input clock divided by 10
    Div10 = 0x9,
    /// PREDIV input clock divided by 11
    Div11 = 0xa,
    /// PREDIV input clock divided by 12
    Div12 = 0xb,
    /// PREDIV input clock divided by 13
    Div13 = 0xc,
    /// PREDIV input clock divided by 14
    Div14 = 0xd,
    /// PREDIV input clock divided by 15
    Div15 = 0xe,
    /// PREDIV input clock divided by 16
    Div16 = 0xf,
};

pub const PREDIV1SRC = enum(u1) {
    /// HSE oscillator clock selected as PREDIV1 clock entry
    HSE = 0x0,
    /// PLL2 selected as PREDIV1 clock entry
    PLL2 = 0x1,
};

pub const RTCSEL = enum(u2) {
    /// No clock
    DISABLE = 0x0,
    /// LSE oscillator clock used as RTC clock
    LSE = 0x1,
    /// LSI oscillator clock used as RTC clock
    LSI = 0x2,
    /// HSE oscillator clock divided by a prescaler used as RTC clock
    HSE = 0x3,
};

pub const SW = enum(u2) {
    /// HSI oscillator used as system clock
    HSI = 0x0,
    /// HSE oscillator used as system clock
    HSE = 0x1,
    /// PLL used as system clock
    PLL1_P = 0x2,
    _,
};

pub const USBPRE = enum(u1) {
    /// PLL clock is divided by 1.5
    Div1_5 = 0x0,
    /// PLL clock is not divided
    Div1 = 0x1,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Internal High Speed clock enable
        HSION: u1,
        /// Internal High Speed clock ready flag
        HSIRDY: u1,
        reserved3: u1 = 0,
        /// Internal High Speed clock trimming
        HSITRIM: u5,
        /// Internal High Speed clock Calibration
        HSICAL: u8,
        /// External High Speed clock enable
        HSEON: u1,
        /// External High Speed clock ready flag
        HSERDY: u1,
        /// External High Speed clock Bypass
        HSEBYP: u1,
        /// Clock Security System enable
        CSSON: u1,
        reserved24: u4 = 0,
        /// PLL enable
        PLLON: u1,
        /// PLL clock ready flag
        PLLRDY: u1,
        /// PLL2 enable
        PLL2ON: u1,
        /// PLL2 clock ready flag
        PLL2RDY: u1,
        /// PLL3 enable
        PLL3ON: u1,
        /// PLL3 clock ready flag
        PLL3RDY: u1,
        padding: u2 = 0,
    }),
    /// Clock configuration register (RCC_CFGR)
    /// offset: 0x04
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock Switch
        SW: SW,
        /// System Clock Switch Status
        SWS: SW,
        /// AHB prescaler
        HPRE: HPRE,
        /// APB Low speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB High speed prescaler (APB2)
        PPRE2: PPRE,
        /// ADC prescaler
        ADCPRE: ADCPRE,
        /// PLL entry clock source
        PLLSRC: PLLSRC,
        /// HSE divider for PLL entry
        PLLXTPRE: PLLXTPRE,
        /// PLL Multiplication Factor
        PLLMUL: PLLMUL,
        /// USB prescaler
        USBPRE: USBPRE,
        reserved24: u1 = 0,
        /// Microcontroller clock output
        MCOSEL: MCOSEL,
        padding: u4 = 0,
    }),
    /// Clock interrupt register (RCC_CIR)
    /// offset: 0x08
    CIR: mmio.Mmio(packed struct(u32) {
        /// LSI Ready Interrupt flag
        LSIRDYF: u1,
        /// LSE Ready Interrupt flag
        LSERDYF: u1,
        /// HSI Ready Interrupt flag
        HSIRDYF: u1,
        /// HSE Ready Interrupt flag
        HSERDYF: u1,
        /// PLL Ready Interrupt flag
        PLLRDYF: u1,
        /// PLL2 Ready Interrupt flag
        PLL2RDYF: u1,
        /// PLL3 Ready Interrupt flag
        PLL3RDYF: u1,
        /// Clock Security System Interrupt flag
        CSSF: u1,
        /// LSI Ready Interrupt Enable
        LSIRDYIE: u1,
        /// LSE Ready Interrupt Enable
        LSERDYIE: u1,
        /// HSI Ready Interrupt Enable
        HSIRDYIE: u1,
        /// HSE Ready Interrupt Enable
        HSERDYIE: u1,
        /// PLL Ready Interrupt Enable
        PLLRDYIE: u1,
        /// PLL2 Ready Interrupt Enable
        PLL2RDYIE: u1,
        /// PLL3 Ready Interrupt Enable
        PLL3RDYIE: u1,
        reserved16: u1 = 0,
        /// LSI Ready Interrupt Clear
        LSIRDYC: u1,
        /// LSE Ready Interrupt Clear
        LSERDYC: u1,
        /// HSI Ready Interrupt Clear
        HSIRDYC: u1,
        /// HSE Ready Interrupt Clear
        HSERDYC: u1,
        /// PLL Ready Interrupt Clear
        PLLRDYC: u1,
        /// PLL2 Ready Interrupt Clear
        PLL2RDYC: u1,
        /// PLL3 Ready Interrupt Clear
        PLL3RDYC: u1,
        /// Clock security system interrupt clear
        CSSC: u1,
        padding: u8 = 0,
    }),
    /// APB2 peripheral reset register (RCC_APB2RSTR)
    /// offset: 0x0c
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// Alternate function I/O reset
        AFIORST: u1,
        reserved2: u1 = 0,
        /// IO port A reset
        GPIOARST: u1,
        /// IO port B reset
        GPIOBRST: u1,
        /// IO port C reset
        GPIOCRST: u1,
        /// IO port D reset
        GPIODRST: u1,
        /// IO port E reset
        GPIOERST: u1,
        reserved9: u2 = 0,
        /// ADC 1 interface reset
        ADC1RST: u1,
        /// ADC 2 interface reset
        ADC2RST: u1,
        /// TIM1 timer reset
        TIM1RST: u1,
        /// SPI 1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset
        USART1RST: u1,
        padding: u17 = 0,
    }),
    /// APB1 peripheral reset register (RCC_APB1RSTR)
    /// offset: 0x10
    APB1RSTR: mmio.Mmio(packed struct(u32) {
        /// Timer 2 reset
        TIM2RST: u1,
        /// Timer 3 reset
        TIM3RST: u1,
        /// Timer 4 reset
        TIM4RST: u1,
        /// Timer 5 reset
        TIM5RST: u1,
        /// Timer 6 reset
        TIM6RST: u1,
        /// Timer 7 reset
        TIM7RST: u1,
        reserved11: u5 = 0,
        /// Window watchdog reset
        WWDGRST: u1,
        reserved14: u2 = 0,
        /// SPI2 reset
        SPI2RST: u1,
        /// SPI3 reset
        SPI3RST: u1,
        reserved17: u1 = 0,
        /// USART 2 reset
        USART2RST: u1,
        /// USART 3 reset
        USART3RST: u1,
        /// USART 4 reset
        UART4RST: u1,
        /// USART 5 reset
        UART5RST: u1,
        /// I2C1 reset
        I2C1RST: u1,
        /// I2C2 reset
        I2C2RST: u1,
        reserved25: u2 = 0,
        /// CAN1 reset
        CAN1RST: u1,
        /// CAN2 reset
        CAN2RST: u1,
        /// Backup interface reset
        BKPRST: u1,
        /// Power interface reset
        PWRRST: u1,
        /// DAC interface reset
        DACRST: u1,
        padding: u2 = 0,
    }),
    /// AHB Peripheral Clock enable register (RCC_AHBENR)
    /// offset: 0x14
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        /// SRAM interface clock enable
        SRAMEN: u1,
        reserved4: u1 = 0,
        /// FLASH clock enable
        FLASHEN: u1,
        reserved6: u1 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved12: u5 = 0,
        /// USB OTG FS clock enable
        USB_OTG_FSEN: u1,
        reserved14: u1 = 0,
        /// Ethernet MAC clock enable
        ETHEN: u1,
        /// Ethernet MAC TX clock enable
        ETHTXEN: u1,
        /// Ethernet MAC RX clock enable
        ETHRXEN: u1,
        padding: u15 = 0,
    }),
    /// APB2 peripheral clock enable register (RCC_APB2ENR)
    /// offset: 0x18
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// Alternate function I/O clock enable
        AFIOEN: u1,
        reserved2: u1 = 0,
        /// I/O port A clock enable
        GPIOAEN: u1,
        /// I/O port B clock enable
        GPIOBEN: u1,
        /// I/O port C clock enable
        GPIOCEN: u1,
        /// I/O port D clock enable
        GPIODEN: u1,
        /// I/O port E clock enable
        GPIOEEN: u1,
        reserved9: u2 = 0,
        /// ADC 1 interface clock enable
        ADC1EN: u1,
        /// ADC 2 interface clock enable
        ADC2EN: u1,
        /// TIM1 Timer clock enable
        TIM1EN: u1,
        /// SPI 1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        padding: u17 = 0,
    }),
    /// APB1 peripheral clock enable register (RCC_APB1ENR)
    /// offset: 0x1c
    APB1ENR: mmio.Mmio(packed struct(u32) {
        /// Timer 2 clock enable
        TIM2EN: u1,
        /// Timer 3 clock enable
        TIM3EN: u1,
        /// Timer 4 clock enable
        TIM4EN: u1,
        /// Timer 5 clock enable
        TIM5EN: u1,
        /// Timer 6 clock enable
        TIM6EN: u1,
        /// Timer 7 clock enable
        TIM7EN: u1,
        reserved11: u5 = 0,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI 2 clock enable
        SPI2EN: u1,
        /// SPI 3 clock enable
        SPI3EN: u1,
        reserved17: u1 = 0,
        /// USART 2 clock enable
        USART2EN: u1,
        /// USART 3 clock enable
        USART3EN: u1,
        /// UART 4 clock enable
        UART4EN: u1,
        /// UART 5 clock enable
        UART5EN: u1,
        /// I2C 1 clock enable
        I2C1EN: u1,
        /// I2C 2 clock enable
        I2C2EN: u1,
        reserved25: u2 = 0,
        /// CAN1 clock enable
        CAN1EN: u1,
        /// CAN2 clock enable
        CAN2EN: u1,
        /// Backup interface clock enable
        BKPEN: u1,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        padding: u2 = 0,
    }),
    /// Backup domain control register (RCC_BDCR)
    /// offset: 0x20
    BDCR: mmio.Mmio(packed struct(u32) {
        /// External Low Speed oscillator enable
        LSEON: u1,
        /// External Low Speed oscillator ready
        LSERDY: u1,
        /// External Low Speed oscillator bypass
        LSEBYP: u1,
        reserved8: u5 = 0,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// Backup domain software reset
        BDRST: u1,
        padding: u15 = 0,
    }),
    /// Control/status register (RCC_CSR)
    /// offset: 0x24
    CSR: mmio.Mmio(packed struct(u32) {
        /// Internal low speed oscillator enable
        LSION: u1,
        /// Internal low speed oscillator ready
        LSIRDY: u1,
        reserved24: u22 = 0,
        /// Remove reset flag
        RMVF: u1,
        reserved26: u1 = 0,
        /// PIN reset flag
        PINRSTF: u1,
        /// POR/PDR reset flag
        PORRSTF: u1,
        /// Software reset flag
        SFTRSTF: u1,
        /// Independent watchdog reset flag
        IWDGRSTF: u1,
        /// Window watchdog reset flag
        WWDGRSTF: u1,
        /// Low-power reset flag
        LPWRRSTF: u1,
    }),
    /// AHB peripheral clock reset register (RCC_AHBRSTR)
    /// offset: 0x28
    AHBRSTR: mmio.Mmio(packed struct(u32) {
        reserved12: u12 = 0,
        /// USB OTG FS reset
        USB_OTG_FSRST: u1,
        reserved14: u1 = 0,
        /// Ethernet MAC reset
        ETHRST: u1,
        padding: u17 = 0,
    }),
    /// Clock configuration register 2
    /// offset: 0x2c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// PREDIV1 division factor
        PREDIV1: PREDIV1,
        /// PREDIV2 division factor
        PREDIV2: PREDIV1,
        /// PLL2 Multiplication Factor
        PLL2MUL: PLL2MUL,
        /// PLL3 Multiplication Factor
        PLL3MUL: PLL2MUL,
        /// PREDIV1 entry clock source
        PREDIV1SRC: PREDIV1SRC,
        /// I2S2 clock source
        I2S2SRC: I2S2SRC,
        /// I2S3 clock source
        I2S3SRC: I2S2SRC,
        padding: u13 = 0,
    }),
};
