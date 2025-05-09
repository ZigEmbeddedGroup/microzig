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

pub const MCOSEL = enum(u3) {
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
    _,
};

pub const PLLMUL = enum(u4) {
    /// PLL input clock x2
    Mul2 = 0x0,
    /// PLL input clock x3
    Mul3 = 0x1,
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
    /// PLL input clock x10
    Mul10 = 0x8,
    /// PLL input clock x11
    Mul11 = 0x9,
    /// PLL input clock x12
    Mul12 = 0xa,
    /// PLL input clock x13
    Mul13 = 0xb,
    /// PLL input clock x14
    Mul14 = 0xc,
    /// PLL input clock x15
    Mul15 = 0xd,
    /// PLL input clock x16
    Mul16 = 0xe,
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
    /// HSI selected as system clock
    HSI = 0x0,
    /// HSE selected as system clock
    HSE = 0x1,
    /// PLL selected as system clock
    PLL1_P = 0x2,
    _,
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
        padding: u6 = 0,
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
        reserved24: u2 = 0,
        /// Microcontroller clock output
        MCOSEL: MCOSEL,
        padding: u5 = 0,
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
        reserved7: u2 = 0,
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
        reserved16: u3 = 0,
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
        reserved23: u2 = 0,
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
        /// IO port F reset
        GPIOFRST: u1,
        /// IO port G reset
        GPIOGRST: u1,
        /// ADC 1 interface reset
        ADC1RST: u1,
        reserved11: u1 = 0,
        /// TIM1 timer reset
        TIM1RST: u1,
        /// SPI 1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset
        USART1RST: u1,
        reserved16: u1 = 0,
        /// TIM15 timer reset
        TIM15RST: u1,
        /// TIM16 timer reset
        TIM16RST: u1,
        /// TIM17 timer reset
        TIM17RST: u1,
        padding: u13 = 0,
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
        /// Timer 12 reset
        TIM12RST: u1,
        /// Timer 13 reset
        TIM13RST: u1,
        /// Timer 14 reset
        TIM14RST: u1,
        reserved11: u2 = 0,
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
        reserved27: u4 = 0,
        /// Backup interface reset
        BKPRST: u1,
        /// Power interface reset
        PWRRST: u1,
        /// DAC interface reset
        DACRST: u1,
        /// CEC reset
        CECRST: u1,
        padding: u1 = 0,
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
        reserved8: u1 = 0,
        /// FSMC clock enable
        FSMCEN: u1,
        padding: u23 = 0,
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
        /// I/O port F clock enable
        GPIOFEN: u1,
        /// I/O port G clock enable
        GPIOGEN: u1,
        /// ADC 1 interface clock enable
        ADC1EN: u1,
        reserved11: u1 = 0,
        /// TIM1 Timer clock enable
        TIM1EN: u1,
        /// SPI 1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        reserved16: u1 = 0,
        /// TIM15 Timer clock enable
        TIM15EN: u1,
        /// TIM16 Timer clock enable
        TIM16EN: u1,
        /// TIM17 Timer clock enable
        TIM17EN: u1,
        padding: u13 = 0,
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
        /// Timer 12 clock enable
        TIM12EN: u1,
        /// Timer 13 clock enable
        TIM13EN: u1,
        /// Timer 14 clock enable
        TIM14EN: u1,
        reserved11: u2 = 0,
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
        reserved27: u4 = 0,
        /// Backup interface clock enable
        BKPEN: u1,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        /// CEC clock enable
        CECEN: u1,
        padding: u1 = 0,
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
    /// offset: 0x28
    reserved40: [4]u8,
    /// Clock configuration register 2
    /// offset: 0x2c
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// PREDIV1 division factor
        PREDIV1: PREDIV1,
        padding: u28 = 0,
    }),
};
