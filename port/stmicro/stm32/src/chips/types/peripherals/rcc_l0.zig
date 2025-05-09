const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const HPRE = enum(u4) {
    /// system clock not divided
    Div1 = 0x0,
    /// system clock divided by 2
    Div2 = 0x8,
    /// system clock divided by 4
    Div4 = 0x9,
    /// system clock divided by 8
    Div8 = 0xa,
    /// system clock divided by 16
    Div16 = 0xb,
    /// system clock divided by 64
    Div64 = 0xc,
    /// system clock divided by 128
    Div128 = 0xd,
    /// system clock divided by 256
    Div256 = 0xe,
    /// system clock divided by 512
    Div512 = 0xf,
    _,
};

pub const I2CSEL = enum(u2) {
    /// APB clock selected as peripheral clock
    PCLK1 = 0x0,
    /// System clock selected as peripheral clock
    SYS = 0x1,
    /// HSI clock selected as peripheral clock
    HSI = 0x2,
    _,
};

pub const LPTIMSEL = enum(u2) {
    /// APB clock selected as Timer clock
    PCLK1 = 0x0,
    /// LSI clock selected as Timer clock
    LSI = 0x1,
    /// HSI clock selected as Timer clock
    HSI = 0x2,
    /// LSE clock selected as Timer clock
    LSE = 0x3,
};

pub const LSEDRV = enum(u2) {
    /// Low driving capability
    Low = 0x0,
    /// Medium low driving capability
    MediumLow = 0x1,
    /// Medium high driving capability
    MediumHigh = 0x2,
    /// High driving capability
    High = 0x3,
};

pub const MCOPRE = enum(u3) {
    /// No division
    Div1 = 0x0,
    /// Division by 2
    Div2 = 0x1,
    /// Division by 4
    Div4 = 0x2,
    /// Division by 8
    Div8 = 0x3,
    /// Division by 16
    Div16 = 0x4,
    _,
};

pub const MCOSEL = enum(u4) {
    /// No clock
    DISABLE = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI oscillator clock selected
    HSI = 0x2,
    /// MSI oscillator clock selected
    MSI = 0x3,
    /// HSE oscillator clock selected
    HSE = 0x4,
    /// PLL clock selected
    PLL = 0x5,
    /// LSI oscillator clock selected
    LSI = 0x6,
    /// LSE oscillator clock selected
    LSE = 0x7,
    _,
};

pub const MSIRANGE = enum(u3) {
    /// range 0 around 65.536 kHz
    Range66K = 0x0,
    /// range 1 around 131.072 kHz
    Range131K = 0x1,
    /// range 2 around 262.144 kHz
    Range262K = 0x2,
    /// range 3 around 524.288 kHz
    Range524K = 0x3,
    /// range 4 around 1.048 MHz
    Range1M = 0x4,
    /// range 5 around 2.097 MHz (reset value)
    Range2M = 0x5,
    /// range 6 around 4.194 MHz
    Range4M = 0x6,
    _,
};

pub const PLLDIV = enum(u2) {
    /// PLLVCO / 2
    Div2 = 0x1,
    /// PLLVCO / 3
    Div3 = 0x2,
    /// PLLVCO / 4
    Div4 = 0x3,
    _,
};

pub const PLLMUL = enum(u4) {
    /// PLL clock entry x 3
    Mul3 = 0x0,
    /// PLL clock entry x 4
    Mul4 = 0x1,
    /// PLL clock entry x 6
    Mul6 = 0x2,
    /// PLL clock entry x 8
    Mul8 = 0x3,
    /// PLL clock entry x 12
    Mul12 = 0x4,
    /// PLL clock entry x 16
    Mul16 = 0x5,
    /// PLL clock entry x 24
    Mul24 = 0x6,
    /// PLL clock entry x 32
    Mul32 = 0x7,
    /// PLL clock entry x 48
    Mul48 = 0x8,
    _,
};

pub const PLLSRC = enum(u1) {
    /// HSI selected as PLL input clock
    HSI = 0x0,
    /// HSE selected as PLL input clock
    HSE = 0x1,
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

pub const RTCPRE = enum(u2) {
    /// HSE divided by 2
    Div2 = 0x0,
    /// HSE divided by 4
    Div4 = 0x1,
    /// HSE divided by 8
    Div8 = 0x2,
    /// HSE divided by 16
    Div16 = 0x3,
};

pub const RTCSEL = enum(u2) {
    /// No clock
    DISABLE = 0x0,
    /// LSE oscillator clock used as RTC clock
    LSE = 0x1,
    /// LSI oscillator clock used as RTC clock
    LSI = 0x2,
    /// HSE oscillator clock divided by a programmable prescaler (selection through the RTCPRE[1:0] bits in the RCC clock control register (RCC_CR)) used as the RTC clock
    HSE = 0x3,
};

pub const STOPWUCK = enum(u1) {
    /// Internal 64 KHz to 4 MHz (MSI) oscillator selected as wake-up from Stop clock
    MSI = 0x0,
    /// Internal 16 MHz (HSI) oscillator selected as wake-up from Stop clock (or HSI/4 if HSIDIVEN=1)
    HSI = 0x1,
};

pub const SW = enum(u2) {
    /// MSI oscillator used as system clock
    MSI = 0x0,
    /// HSI oscillator used as system clock
    HSI = 0x1,
    /// HSE oscillator used as system clock
    HSE = 0x2,
    /// PLL used as system clock
    PLL1_R = 0x3,
};

pub const UARTSEL = enum(u2) {
    /// APB clock selected as peripheral clock
    PCLK1 = 0x0,
    /// System clock selected as peripheral clock
    SYS = 0x1,
    /// HSI clock selected as peripheral clock
    HSI = 0x2,
    /// LSE clock selected as peripheral clock
    LSE = 0x3,
};

pub const USART1SEL = enum(u2) {
    /// APB clock selected as peripheral clock
    PCLK2 = 0x0,
    /// System clock selected as peripheral clock
    SYS = 0x1,
    /// HSI clock selected as peripheral clock
    HSI = 0x2,
    /// LSE clock selected as peripheral clock
    LSE = 0x3,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// 16 MHz high-speed internal clock enable
        HSION: u1,
        /// High-speed internal clock enable bit for some IP kernels
        HSIKERON: u1,
        /// Internal high-speed clock ready flag
        HSIRDY: u1,
        /// HSIDIVEN
        HSIDIVEN: u1,
        /// HSIDIVF
        HSIDIVF: u1,
        /// 16 MHz high-speed internal clock output enable
        HSIOUTEN: u1,
        reserved8: u2 = 0,
        /// MSI clock enable
        MSION: u1,
        /// MSI clock ready flag
        MSIRDY: u1,
        reserved16: u6 = 0,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE clock bypass
        HSEBYP: u1,
        /// Clock security system on HSE enable
        CSSHSEON: u1,
        /// TC/LCD prescaler
        RTCPRE: RTCPRE,
        reserved24: u2 = 0,
        /// PLL enable
        PLLON: u1,
        /// PLL clock ready flag
        PLLRDY: u1,
        padding: u6 = 0,
    }),
    /// Internal clock sources calibration register
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        /// nternal high speed clock calibration
        HSICAL: u8,
        /// High speed internal clock trimming
        HSITRIM: u5,
        /// MSI clock ranges
        MSIRANGE: MSIRANGE,
        /// MSI clock calibration
        MSICAL: u8,
        /// MSI clock trimming
        MSITRIM: u8,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// Clock configuration register
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch
        SW: SW,
        /// System clock switch status
        SWS: SW,
        /// AHB prescaler
        HPRE: HPRE,
        /// APB low-speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        reserved15: u1 = 0,
        /// Wake-up from stop clock selection
        STOPWUCK: STOPWUCK,
        /// PLL entry clock source
        PLLSRC: PLLSRC,
        reserved18: u1 = 0,
        /// PLL multiplication factor
        PLLMUL: PLLMUL,
        /// PLL output division
        PLLDIV: PLLDIV,
        /// Microcontroller clock output selection
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// Clock interrupt enable register
    /// offset: 0x10
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag
        LSIRDYIE: u1,
        /// LSE ready interrupt flag
        LSERDYIE: u1,
        /// HSI ready interrupt flag
        HSIRDYIE: u1,
        /// HSE ready interrupt flag
        HSERDYIE: u1,
        /// PLL ready interrupt flag
        PLLRDYIE: u1,
        /// MSI ready interrupt flag
        MSIRDYIE: u1,
        reserved7: u1 = 0,
        /// LSE CSS interrupt flag
        CSSLSE: u1,
        padding: u24 = 0,
    }),
    /// Clock interrupt flag register
    /// offset: 0x14
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag
        LSIRDYF: u1,
        /// LSE ready interrupt flag
        LSERDYF: u1,
        /// HSI ready interrupt flag
        HSIRDYF: u1,
        /// HSE ready interrupt flag
        HSERDYF: u1,
        /// PLL ready interrupt flag
        PLLRDYF: u1,
        /// MSI ready interrupt flag
        MSIRDYF: u1,
        reserved7: u1 = 0,
        /// LSE Clock Security System Interrupt flag
        CSSLSEF: u1,
        /// Clock Security System Interrupt flag
        CSSHSEF: u1,
        padding: u23 = 0,
    }),
    /// Clock interrupt clear register
    /// offset: 0x18
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready Interrupt clear
        LSIRDYC: u1,
        /// LSE ready Interrupt clear
        LSERDYC: u1,
        /// HSI ready Interrupt clear
        HSIRDYC: u1,
        /// HSE ready Interrupt clear
        HSERDYC: u1,
        /// PLL ready Interrupt clear
        PLLRDYC: u1,
        /// MSI ready Interrupt clear
        MSIRDYC: u1,
        reserved7: u1 = 0,
        /// LSE Clock Security System Interrupt clear
        CSSLSEC: u1,
        /// Clock Security System Interrupt clear
        CSSHSEC: u1,
        padding: u23 = 0,
    }),
    /// GPIO reset register
    /// offset: 0x1c
    GPIORSTR: mmio.Mmio(packed struct(u32) {
        /// I/O port A reset
        GPIOARST: u1,
        /// I/O port B reset
        GPIOBRST: u1,
        /// I/O port A reset
        GPIOCRST: u1,
        /// I/O port D reset
        GPIODRST: u1,
        /// I/O port E reset
        GPIOERST: u1,
        reserved7: u2 = 0,
        /// I/O port H reset
        GPIOHRST: u1,
        padding: u24 = 0,
    }),
    /// AHB peripheral reset register
    /// offset: 0x20
    AHBRSTR: mmio.Mmio(packed struct(u32) {
        /// DMA reset
        DMA1RST: u1,
        reserved8: u7 = 0,
        /// Memory interface reset
        MIFRST: u1,
        reserved12: u3 = 0,
        /// Test integration module reset
        CRCRST: u1,
        reserved16: u3 = 0,
        /// Touch Sensing reset
        TSCRST: u1,
        reserved20: u3 = 0,
        /// Random Number Generator module reset
        RNGRST: u1,
        reserved24: u3 = 0,
        /// Crypto module reset
        CRYPRST: u1,
        padding: u7 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x24
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// System configuration controller reset
        SYSCFGRST: u1,
        reserved2: u1 = 0,
        /// TIM21 timer reset
        TIM21RST: u1,
        reserved5: u2 = 0,
        /// TIM22 timer reset
        TIM22RST: u1,
        reserved9: u3 = 0,
        /// ADC interface reset
        ADCRST: u1,
        reserved12: u2 = 0,
        /// SPI 1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset
        USART1RST: u1,
        reserved22: u7 = 0,
        /// DBG reset
        DBGRST: u1,
        padding: u9 = 0,
    }),
    /// APB1 peripheral reset register
    /// offset: 0x28
    APB1RSTR: mmio.Mmio(packed struct(u32) {
        /// Timer 2 reset
        TIM2RST: u1,
        /// Timer 3 reset
        TIM3RST: u1,
        reserved4: u2 = 0,
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
        reserved17: u2 = 0,
        /// USART2 reset
        USART2RST: u1,
        /// LPUART1 reset
        LPUART1RST: u1,
        /// USART4 reset
        USART4RST: u1,
        /// USART5 reset
        USART5RST: u1,
        /// I2C1 reset
        I2C1RST: u1,
        /// I2C2 reset
        I2C2RST: u1,
        /// USB reset
        USBRST: u1,
        reserved27: u3 = 0,
        /// Clock recovery system reset
        CRSRST: u1,
        /// Power interface reset
        PWRRST: u1,
        /// DAC interface reset
        DACRST: u1,
        /// I2C3 reset
        I2C3RST: u1,
        /// Low power timer reset
        LPTIM1RST: u1,
    }),
    /// GPIO clock enable register
    /// offset: 0x2c
    GPIOENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable
        GPIOAEN: u1,
        /// IO port B clock enable
        GPIOBEN: u1,
        /// IO port A clock enable
        GPIOCEN: u1,
        /// I/O port D clock enable
        GPIODEN: u1,
        /// IO port E clock enable
        GPIOEEN: u1,
        reserved7: u2 = 0,
        /// I/O port H clock enable
        GPIOHEN: u1,
        padding: u24 = 0,
    }),
    /// AHB peripheral clock enable register
    /// offset: 0x30
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// DMA clock enable
        DMA1EN: u1,
        reserved8: u7 = 0,
        /// NVM interface clock enable
        MIFEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved16: u3 = 0,
        /// Touch Sensing clock enable
        TSCEN: u1,
        reserved20: u3 = 0,
        /// Random Number Generator clock enable
        RNGEN: u1,
        reserved24: u3 = 0,
        /// Crypto clock enable
        CRYPEN: u1,
        padding: u7 = 0,
    }),
    /// APB2 peripheral clock enable register
    /// offset: 0x34
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// System configuration controller clock enable
        SYSCFGEN: u1,
        reserved2: u1 = 0,
        /// TIM21 timer clock enable
        TIM21EN: u1,
        reserved5: u2 = 0,
        /// TIM22 timer clock enable
        TIM22EN: u1,
        reserved7: u1 = 0,
        /// Firewall clock enable
        FWEN: u1,
        reserved9: u1 = 0,
        /// ADC clock enable
        ADCEN: u1,
        reserved12: u2 = 0,
        /// SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        reserved22: u7 = 0,
        /// DBG clock enable
        DBGEN: u1,
        padding: u9 = 0,
    }),
    /// APB1 peripheral clock enable register
    /// offset: 0x38
    APB1ENR: mmio.Mmio(packed struct(u32) {
        /// Timer2 clock enable
        TIM2EN: u1,
        /// Timer 3 clock enbale
        TIM3EN: u1,
        reserved4: u2 = 0,
        /// Timer 6 clock enable
        TIM6EN: u1,
        /// Timer 7 clock enable
        TIM7EN: u1,
        reserved11: u5 = 0,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable
        SPI2EN: u1,
        reserved17: u2 = 0,
        /// UART2 clock enable
        USART2EN: u1,
        /// LPUART1 clock enable
        LPUART1EN: u1,
        /// USART4 clock enable
        USART4EN: u1,
        /// USART5 clock enable
        USART5EN: u1,
        /// I2C1 clock enable
        I2C1EN: u1,
        /// I2C2 clock enable
        I2C2EN: u1,
        /// USB clock enable
        USBEN: u1,
        reserved27: u3 = 0,
        /// Clock recovery system clock enable
        CRSEN: u1,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        /// I2C3 clock enable
        I2C3EN: u1,
        /// Low power timer clock enable
        LPTIM1EN: u1,
    }),
    /// GPIO clock enable in sleep mode register
    /// offset: 0x3c
    GPIOSMEN: mmio.Mmio(packed struct(u32) {
        /// Port A clock enable during Sleep mode
        GPIOASMEN: u1,
        /// Port B clock enable during Sleep mode
        GPIOBSMEN: u1,
        /// Port C clock enable during Sleep mode
        GPIOCSMEN: u1,
        /// Port D clock enable during Sleep mode
        GPIODSMEN: u1,
        /// Port E clock enable during Sleep mode
        GPIOESMEN: u1,
        reserved7: u2 = 0,
        /// Port H clock enable during Sleep mode
        GPIOHSMEN: u1,
        padding: u24 = 0,
    }),
    /// AHB peripheral clock enable in sleep mode register
    /// offset: 0x40
    AHBSMENR: mmio.Mmio(packed struct(u32) {
        /// DMA clock enable during sleep mode
        DMA1SMEN: u1,
        reserved8: u7 = 0,
        /// NVM interface clock enable during sleep mode
        MIFSMEN: u1,
        /// SRAM interface clock enable during sleep mode
        SRAMSMEN: u1,
        reserved12: u2 = 0,
        /// CRC clock enable during sleep mode
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// Touch Sensing clock enable during sleep mode
        TSCSMEN: u1,
        reserved20: u3 = 0,
        /// Random Number Generator clock enable during sleep mode
        RNGSMEN: u1,
        reserved24: u3 = 0,
        /// Crypto clock enable during sleep mode
        CRYPSMEN: u1,
        padding: u7 = 0,
    }),
    /// APB2 peripheral clock enable in sleep mode register
    /// offset: 0x44
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        /// System configuration controller clock enable during sleep mode
        SYSCFGSMEN: u1,
        reserved2: u1 = 0,
        /// TIM21 timer clock enable during sleep mode
        TIM21SMEN: u1,
        reserved5: u2 = 0,
        /// TIM22 timer clock enable during sleep mode
        TIM22SMEN: u1,
        reserved9: u3 = 0,
        /// ADC clock enable during sleep mode
        ADCSMEN: u1,
        reserved12: u2 = 0,
        /// SPI1 clock enable during sleep mode
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during sleep mode
        USART1SMEN: u1,
        reserved22: u7 = 0,
        /// DBG clock enable during sleep mode
        DBGSMEN: u1,
        padding: u9 = 0,
    }),
    /// APB1 peripheral clock enable in sleep mode register
    /// offset: 0x48
    APB1SMENR: mmio.Mmio(packed struct(u32) {
        /// Timer2 clock enable during sleep mode
        TIM2SMEN: u1,
        /// Timer 3 clock enable during sleep mode
        TIM3SMEN: u1,
        reserved4: u2 = 0,
        /// Timer 6 clock enable during sleep mode
        TIM6SMEN: u1,
        /// Timer 7 clock enable during sleep mode
        TIM7SMEN: u1,
        reserved11: u5 = 0,
        /// Window watchdog clock enable during sleep mode
        WWDGSMEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during sleep mode
        SPI2SMEN: u1,
        reserved17: u2 = 0,
        /// UART2 clock enable during sleep mode
        USART2SMEN: u1,
        /// LPUART1 clock enable during sleep mode
        LPUART1SMEN: u1,
        /// USART4 clock enabe during sleep mode
        USART4SMEN: u1,
        /// USART5 clock enable during sleep mode
        USART5SMEN: u1,
        /// I2C1 clock enable during sleep mode
        I2C1SMEN: u1,
        /// I2C2 clock enable during sleep mode
        I2C2SMEN: u1,
        /// USB clock enable during sleep mode
        USBSMEN: u1,
        reserved27: u3 = 0,
        /// Clock recovery system clock enable during sleep mode
        CRSSMEN: u1,
        /// Power interface clock enable during sleep mode
        PWRSMEN: u1,
        /// DAC interface clock enable during sleep mode
        DACSMEN: u1,
        /// I2C3 clock enable during sleep mode
        I2C3SMEN: u1,
        /// Low power timer clock enable during sleep mode
        LPTIM1SMEN: u1,
    }),
    /// Clock configuration register
    /// offset: 0x4c
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection
        USART1SEL: USART1SEL,
        /// USART2 clock source selection
        USART2SEL: UARTSEL,
        reserved10: u6 = 0,
        /// LPUART1 clock source selection
        LPUART1SEL: UARTSEL,
        /// I2C1 clock source selection
        I2C1SEL: I2CSEL,
        reserved16: u2 = 0,
        /// I2C3 clock source selection
        I2C3SEL: I2CSEL,
        /// Low Power Timer clock source selection
        LPTIM1SEL: LPTIMSEL,
        padding: u12 = 0,
    }),
    /// Control and status register
    /// offset: 0x50
    CSR: mmio.Mmio(packed struct(u32) {
        /// Internal low-speed oscillator enable
        LSION: u1,
        /// Internal low-speed oscillator ready
        LSIRDY: u1,
        reserved8: u6 = 0,
        /// External low-speed oscillator enable
        LSEON: u1,
        /// External low-speed oscillator ready
        LSERDY: u1,
        /// External low-speed oscillator bypass
        LSEBYP: u1,
        /// LSEDRV
        LSEDRV: LSEDRV,
        /// CSSLSEON
        CSSLSEON: u1,
        /// CSS on LSE failure detection flag
        CSSLSED: u1,
        reserved16: u1 = 0,
        /// RTC and LCD clock source selection
        RTCSEL: RTCSEL,
        /// RTC clock enable
        RTCEN: u1,
        /// RTC software reset
        RTCRST: u1,
        reserved23: u3 = 0,
        /// Remove reset flag
        RMVF: u1,
        /// Firewall reset flag
        FWRSTF: u1,
        /// OBLRSTF
        OBLRSTF: u1,
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
};
