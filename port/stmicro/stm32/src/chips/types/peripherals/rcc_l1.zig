const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

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

pub const MCOSEL = enum(u3) {
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

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Internal high-speed clock enable
        HSION: u1,
        /// Internal high-speed clock ready flag
        HSIRDY: u1,
        reserved8: u6 = 0,
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
        reserved24: u5 = 0,
        /// PLL enable
        PLLON: u1,
        /// PLL clock ready flag
        PLLRDY: u1,
        reserved28: u2 = 0,
        /// Clock security system enable
        CSSON: u1,
        /// RTC/LCD prescaler
        RTCPRE: RTCPRE,
        padding: u1 = 0,
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
    /// Clock configuration register
    /// offset: 0x08
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
        reserved16: u2 = 0,
        /// PLL entry clock source
        PLLSRC: PLLSRC,
        reserved18: u1 = 0,
        /// PLL multiplication factor
        PLLMUL: PLLMUL,
        /// PLL output division
        PLLDIV: PLLDIV,
        /// Microcontroller clock output selection
        MCOSEL: MCOSEL,
        reserved28: u1 = 0,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// Clock interrupt register
    /// offset: 0x0c
    CIR: mmio.Mmio(packed struct(u32) {
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
        /// Clock security system interrupt flag
        CSSF: u1,
        /// LSI ready interrupt enable
        LSIRDYIE: u1,
        /// LSE ready interrupt enable
        LSERDYIE: u1,
        /// HSI ready interrupt enable
        HSIRDYIE: u1,
        /// HSE ready interrupt enable
        HSERDYIE: u1,
        /// PLL ready interrupt enable
        PLLRDYIE: u1,
        /// MSI ready interrupt enable
        MSIRDYIE: u1,
        reserved16: u2 = 0,
        /// LSI ready interrupt clear
        LSIRDYC: u1,
        /// LSE ready interrupt clear
        LSERDYC: u1,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// PLL ready interrupt clear
        PLLRDYC: u1,
        /// MSI ready interrupt clear
        MSIRDYC: u1,
        reserved23: u1 = 0,
        /// Clock security system interrupt clear
        CSSC: u1,
        padding: u8 = 0,
    }),
    /// AHB peripheral reset register
    /// offset: 0x10
    AHBRSTR: mmio.Mmio(packed struct(u32) {
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
        /// IO port H reset
        GPIOHRST: u1,
        /// IO port F reset
        GPIOFRST: u1,
        /// IO port G reset
        GPIOGRST: u1,
        reserved12: u4 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved15: u2 = 0,
        /// FLASH reset
        FLASHRST: u1,
        reserved24: u8 = 0,
        /// DMA1 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        reserved30: u4 = 0,
        /// FSMC reset
        FSMCRST: u1,
        padding: u1 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x14
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// SYSCFGRST
        SYSCFGRST: u1,
        reserved2: u1 = 0,
        /// TIM9RST
        TIM9RST: u1,
        /// TM10RST
        TM10RST: u1,
        /// TM11RST
        TM11RST: u1,
        reserved9: u4 = 0,
        /// ADC1RST
        ADC1RST: u1,
        reserved11: u1 = 0,
        /// SDIORST
        SDIORST: u1,
        /// SPI1RST
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1RST
        USART1RST: u1,
        padding: u17 = 0,
    }),
    /// APB1 peripheral reset register
    /// offset: 0x18
    APB1RSTR: mmio.Mmio(packed struct(u32) {
        /// Timer 2 reset
        TIM2RST: u1,
        /// Timer 3 reset
        TIM3RST: u1,
        /// Timer 4 reset
        TIM4RST: u1,
        /// Timer 5 reset
        TIM5RST: u1,
        /// Timer 6reset
        TIM6RST: u1,
        /// Timer 7 reset
        TIM7RST: u1,
        reserved9: u3 = 0,
        /// LCD reset
        LCDRST: u1,
        reserved11: u1 = 0,
        /// Window watchdog reset
        WWDRST: u1,
        reserved14: u2 = 0,
        /// SPI 2 reset
        SPI2RST: u1,
        /// SPI 3 reset
        SPI3RST: u1,
        reserved17: u1 = 0,
        /// USART 2 reset
        USART2RST: u1,
        /// USART 3 reset
        USART3RST: u1,
        /// UART 4 reset
        UART4RST: u1,
        /// UART 5 reset
        UART5RST: u1,
        /// I2C 1 reset
        I2C1RST: u1,
        /// I2C 2 reset
        I2C2RST: u1,
        /// USB reset
        USBRST: u1,
        reserved28: u4 = 0,
        /// Power interface reset
        PWRRST: u1,
        /// DAC interface reset
        DACRST: u1,
        reserved31: u1 = 0,
        /// COMP interface reset
        COMPRST: u1,
    }),
    /// AHB peripheral clock enable register
    /// offset: 0x1c
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable
        GPIOAEN: u1,
        /// IO port B clock enable
        GPIOBEN: u1,
        /// IO port C clock enable
        GPIOCEN: u1,
        /// IO port D clock enable
        GPIODEN: u1,
        /// IO port E clock enable
        GPIOEEN: u1,
        /// IO port H clock enable
        GPIOHEN: u1,
        /// IO port F clock enable
        GPIOFEN: u1,
        /// IO port G clock enable
        GPIOGEN: u1,
        reserved12: u4 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved15: u2 = 0,
        /// FLASH clock enable
        FLASHEN: u1,
        reserved24: u8 = 0,
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        reserved30: u4 = 0,
        /// FSMCEN
        FSMCEN: u1,
        padding: u1 = 0,
    }),
    /// APB2 peripheral clock enable register
    /// offset: 0x20
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// System configuration controller clock enable
        SYSCFGEN: u1,
        reserved2: u1 = 0,
        /// TIM9 timer clock enable
        TIM9EN: u1,
        /// TIM10 timer clock enable
        TIM10EN: u1,
        /// TIM11 timer clock enable
        TIM11EN: u1,
        reserved9: u4 = 0,
        /// ADC1 interface clock enable
        ADC1EN: u1,
        reserved11: u1 = 0,
        /// SDIO clock enable
        SDIOEN: u1,
        /// SPI 1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        padding: u17 = 0,
    }),
    /// APB1 peripheral clock enable register
    /// offset: 0x24
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
        reserved9: u3 = 0,
        /// LCD clock enable
        LCDEN: u1,
        reserved11: u1 = 0,
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
        USART4EN: u1,
        /// UART 5 clock enable
        USART5EN: u1,
        /// I2C 1 clock enable
        I2C1EN: u1,
        /// I2C 2 clock enable
        I2C2EN: u1,
        /// USB clock enable
        USBEN: u1,
        reserved28: u4 = 0,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        reserved31: u1 = 0,
        /// COMP interface clock enable
        COMPEN: u1,
    }),
    /// AHB peripheral clock enable in low power mode register
    /// offset: 0x28
    AHBLPENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable during Sleep mode
        GPIOALPEN: u1,
        /// IO port B clock enable during Sleep mode
        GPIOBLPEN: u1,
        /// IO port C clock enable during Sleep mode
        GPIOCLPEN: u1,
        /// IO port D clock enable during Sleep mode
        GPIODLPEN: u1,
        /// IO port E clock enable during Sleep mode
        GPIOELPEN: u1,
        /// IO port H clock enable during Sleep mode
        GPIOHLPEN: u1,
        /// IO port F clock enable during Sleep mode
        GPIOFLPEN: u1,
        /// IO port G clock enable during Sleep mode
        GPIOGLPEN: u1,
        reserved12: u4 = 0,
        /// CRC clock enable during Sleep mode
        CRCLPEN: u1,
        reserved15: u2 = 0,
        /// FLASH clock enable during Sleep mode
        FLASHLPEN: u1,
        /// SRAM clock enable during Sleep mode
        SRAMLPEN: u1,
        reserved24: u7 = 0,
        /// DMA1 clock enable during Sleep mode
        DMA1LPEN: u1,
        /// DMA2 clock enable during Sleep mode
        DMA2LPEN: u1,
        padding: u6 = 0,
    }),
    /// APB2 peripheral clock enable in low power mode register
    /// offset: 0x2c
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        /// System configuration controller clock enable during Sleep mode
        SYSCFGLPEN: u1,
        reserved2: u1 = 0,
        /// TIM9 timer clock enable during Sleep mode
        TIM9LPEN: u1,
        /// TIM10 timer clock enable during Sleep mode
        TIM10LPEN: u1,
        /// TIM11 timer clock enable during Sleep mode
        TIM11LPEN: u1,
        reserved9: u4 = 0,
        /// ADC1 interface clock enable during Sleep mode
        ADC1LPEN: u1,
        reserved11: u1 = 0,
        /// SDIO clock enable during Sleep mode
        SDIOLPEN: u1,
        /// SPI 1 clock enable during Sleep mode
        SPI1LPEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during Sleep mode
        USART1LPEN: u1,
        padding: u17 = 0,
    }),
    /// APB1 peripheral clock enable in low power mode register
    /// offset: 0x30
    APB1LPENR: mmio.Mmio(packed struct(u32) {
        /// Timer 2 clock enable during Sleep mode
        TIM2LPEN: u1,
        /// Timer 3 clock enable during Sleep mode
        TIM3LPEN: u1,
        /// Timer 4 clock enable during Sleep mode
        TIM4LPEN: u1,
        reserved4: u1 = 0,
        /// Timer 6 clock enable during Sleep mode
        TIM6LPEN: u1,
        /// Timer 7 clock enable during Sleep mode
        TIM7LPEN: u1,
        reserved9: u3 = 0,
        /// LCD clock enable during Sleep mode
        LCDLPEN: u1,
        reserved11: u1 = 0,
        /// Window watchdog clock enable during Sleep mode
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI 2 clock enable during Sleep mode
        SPI2LPEN: u1,
        reserved17: u2 = 0,
        /// USART 2 clock enable during Sleep mode
        USART2LPEN: u1,
        /// USART 3 clock enable during Sleep mode
        USART3LPEN: u1,
        reserved21: u2 = 0,
        /// I2C 1 clock enable during Sleep mode
        I2C1LPEN: u1,
        /// I2C 2 clock enable during Sleep mode
        I2C2LPEN: u1,
        /// USB clock enable during Sleep mode
        USBLPEN: u1,
        reserved28: u4 = 0,
        /// Power interface clock enable during Sleep mode
        PWRLPEN: u1,
        /// DAC interface clock enable during Sleep mode
        DACLPEN: u1,
        reserved31: u1 = 0,
        /// COMP interface clock enable during Sleep mode
        COMPLPEN: u1,
    }),
    /// Control/status register
    /// offset: 0x34
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
        reserved16: u5 = 0,
        /// RTC and LCD clock source selection
        RTCSEL: RTCSEL,
        reserved22: u4 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// RTC software reset
        RTCRST: u1,
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
};
