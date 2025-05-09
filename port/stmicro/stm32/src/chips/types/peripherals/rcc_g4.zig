const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    /// No clock selected
    DISABLE = 0x0,
    /// PLL 'P' clock selected as ADC clock
    PLL1_P = 0x1,
    /// System clock selected as ADC clock
    SYS = 0x2,
    _,
};

pub const CLK48SEL = enum(u2) {
    /// HSI48 oscillator clock selected as 48 MHz clock
    HSI48 = 0x0,
    /// PLLQCLK selected as 48 MHz clock
    PLL1_Q = 0x2,
    _,
};

pub const FDCANSEL = enum(u2) {
    /// HSE used as FDCAN clock source
    HSE = 0x0,
    /// PLLQCLK used as FDCAN clock source
    PLL1_Q = 0x1,
    /// PCLK used as FDCAN clock source
    PCLK1 = 0x2,
    _,
};

pub const HPRE = enum(u4) {
    /// SYSCLK not divided
    Div1 = 0x0,
    /// SYSCLK is divided by 2
    Div2 = 0x8,
    /// SYSCLK is divided by 4
    Div4 = 0x9,
    /// SYSCLK is divided by 8
    Div8 = 0xa,
    /// SYSCLK is divided by 16
    Div16 = 0xb,
    /// SYSCLK is divided by 64
    Div64 = 0xc,
    /// SYSCLK is divided by 128
    Div128 = 0xd,
    /// SYSCLK is divided by 256
    Div256 = 0xe,
    /// SYSCLK is divided by 512
    Div512 = 0xf,
    _,
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
    /// MCO1 not divided
    Div1 = 0x0,
    /// MCO clock is divided by 2
    Div2 = 0x1,
    /// MCO clock is divided by 4
    Div4 = 0x2,
    /// MCO clock is divided by 8
    Div8 = 0x3,
    /// MCO clock is divided divided by 16
    Div16 = 0x4,
    _,
};

pub const MCOSEL = enum(u4) {
    /// No clock, MCO output disabled
    DISABLE = 0x0,
    /// SYSCLK selected as MCO source
    SYS = 0x1,
    /// HSI selected as MCO source
    HSI = 0x3,
    /// HSE selected as MCO source
    HSE = 0x4,
    /// Main PLLCLK selected as MCO source
    PLLCLK = 0x5,
    /// LSI selected as MCO source
    LSI = 0x6,
    /// LSE selected as MCO source
    LSE = 0x7,
    /// HSI48 selected as MCO source
    HSI48 = 0x8,
    _,
};

pub const PLLM = enum(u4) {
    Div1 = 0x0,
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
    Div9 = 0x8,
    Div10 = 0x9,
    Div11 = 0xa,
    Div12 = 0xb,
    Div13 = 0xc,
    Div14 = 0xd,
    Div15 = 0xe,
    Div16 = 0xf,
};

pub const PLLN = enum(u7) {
    Mul8 = 0x8,
    Mul9 = 0x9,
    Mul10 = 0xa,
    Mul11 = 0xb,
    Mul12 = 0xc,
    Mul13 = 0xd,
    Mul14 = 0xe,
    Mul15 = 0xf,
    Mul16 = 0x10,
    Mul17 = 0x11,
    Mul18 = 0x12,
    Mul19 = 0x13,
    Mul20 = 0x14,
    Mul21 = 0x15,
    Mul22 = 0x16,
    Mul23 = 0x17,
    Mul24 = 0x18,
    Mul25 = 0x19,
    Mul26 = 0x1a,
    Mul27 = 0x1b,
    Mul28 = 0x1c,
    Mul29 = 0x1d,
    Mul30 = 0x1e,
    Mul31 = 0x1f,
    Mul32 = 0x20,
    Mul33 = 0x21,
    Mul34 = 0x22,
    Mul35 = 0x23,
    Mul36 = 0x24,
    Mul37 = 0x25,
    Mul38 = 0x26,
    Mul39 = 0x27,
    Mul40 = 0x28,
    Mul41 = 0x29,
    Mul42 = 0x2a,
    Mul43 = 0x2b,
    Mul44 = 0x2c,
    Mul45 = 0x2d,
    Mul46 = 0x2e,
    Mul47 = 0x2f,
    Mul48 = 0x30,
    Mul49 = 0x31,
    Mul50 = 0x32,
    Mul51 = 0x33,
    Mul52 = 0x34,
    Mul53 = 0x35,
    Mul54 = 0x36,
    Mul55 = 0x37,
    Mul56 = 0x38,
    Mul57 = 0x39,
    Mul58 = 0x3a,
    Mul59 = 0x3b,
    Mul60 = 0x3c,
    Mul61 = 0x3d,
    Mul62 = 0x3e,
    Mul63 = 0x3f,
    Mul64 = 0x40,
    Mul65 = 0x41,
    Mul66 = 0x42,
    Mul67 = 0x43,
    Mul68 = 0x44,
    Mul69 = 0x45,
    Mul70 = 0x46,
    Mul71 = 0x47,
    Mul72 = 0x48,
    Mul73 = 0x49,
    Mul74 = 0x4a,
    Mul75 = 0x4b,
    Mul76 = 0x4c,
    Mul77 = 0x4d,
    Mul78 = 0x4e,
    Mul79 = 0x4f,
    Mul80 = 0x50,
    Mul81 = 0x51,
    Mul82 = 0x52,
    Mul83 = 0x53,
    Mul84 = 0x54,
    Mul85 = 0x55,
    Mul86 = 0x56,
    Mul87 = 0x57,
    Mul88 = 0x58,
    Mul89 = 0x59,
    Mul90 = 0x5a,
    Mul91 = 0x5b,
    Mul92 = 0x5c,
    Mul93 = 0x5d,
    Mul94 = 0x5e,
    Mul95 = 0x5f,
    Mul96 = 0x60,
    Mul97 = 0x61,
    Mul98 = 0x62,
    Mul99 = 0x63,
    Mul100 = 0x64,
    Mul101 = 0x65,
    Mul102 = 0x66,
    Mul103 = 0x67,
    Mul104 = 0x68,
    Mul105 = 0x69,
    Mul106 = 0x6a,
    Mul107 = 0x6b,
    Mul108 = 0x6c,
    Mul109 = 0x6d,
    Mul110 = 0x6e,
    Mul111 = 0x6f,
    Mul112 = 0x70,
    Mul113 = 0x71,
    Mul114 = 0x72,
    Mul115 = 0x73,
    Mul116 = 0x74,
    Mul117 = 0x75,
    Mul118 = 0x76,
    Mul119 = 0x77,
    Mul120 = 0x78,
    Mul121 = 0x79,
    Mul122 = 0x7a,
    Mul123 = 0x7b,
    Mul124 = 0x7c,
    Mul125 = 0x7d,
    Mul126 = 0x7e,
    Mul127 = 0x7f,
    _,
};

pub const PLLP = enum(u5) {
    Div2 = 0x2,
    Div3 = 0x3,
    Div4 = 0x4,
    Div5 = 0x5,
    Div6 = 0x6,
    Div7 = 0x7,
    Div8 = 0x8,
    Div9 = 0x9,
    Div10 = 0xa,
    Div11 = 0xb,
    Div12 = 0xc,
    Div13 = 0xd,
    Div14 = 0xe,
    Div15 = 0xf,
    Div16 = 0x10,
    Div17 = 0x11,
    Div18 = 0x12,
    Div19 = 0x13,
    Div20 = 0x14,
    Div21 = 0x15,
    Div22 = 0x16,
    Div23 = 0x17,
    Div24 = 0x18,
    Div25 = 0x19,
    Div26 = 0x1a,
    Div27 = 0x1b,
    Div28 = 0x1c,
    Div29 = 0x1d,
    Div30 = 0x1e,
    Div31 = 0x1f,
    _,
};

pub const PLLPBIT = enum(u1) {
    Div7 = 0x0,
    Div17 = 0x1,
};

pub const PLLQ = enum(u2) {
    Div2 = 0x0,
    Div4 = 0x1,
    Div6 = 0x2,
    Div8 = 0x3,
};

pub const PLLR = enum(u2) {
    Div2 = 0x0,
    Div4 = 0x1,
    Div6 = 0x2,
    Div8 = 0x3,
};

pub const PLLSRC = enum(u2) {
    /// No clock selected as PLL entry clock source
    DISABLE = 0x0,
    /// HSI selected as PLL entry clock source
    HSI = 0x2,
    /// HSE selected as PLL entry clock source
    HSE = 0x3,
    _,
};

pub const PPRE = enum(u3) {
    /// HCLK not divided
    Div1 = 0x0,
    /// HCLK is divided by 2
    Div2 = 0x4,
    /// HCLK is divided by 4
    Div4 = 0x5,
    /// HCLK is divided by 8
    Div8 = 0x6,
    /// HCLK is divided by 16
    Div16 = 0x7,
    _,
};

pub const RTCSEL = enum(u2) {
    /// No clock used as RTC clock
    DISABLE = 0x0,
    /// LSE used as RTC clock
    LSE = 0x1,
    /// LSI used as RTC clock
    LSI = 0x2,
    /// HSE divided by 32 used as RTC clock
    HSE_Div32 = 0x3,
};

pub const SW = enum(u2) {
    /// HSI selected as system clock
    HSI = 0x1,
    /// HSE selected as system clock
    HSE = 0x2,
    /// PLLRCLK selected as system clock
    PLL1_R = 0x3,
    _,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// HSI clock enable
        HSION: u1,
        /// HSI always enable for peripheral kernels
        HSIKERON: u1,
        /// HSI clock ready flag
        HSIRDY: u1,
        reserved16: u5 = 0,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE crystal oscillator bypass
        HSEBYP: u1,
        /// Clock security system enable
        CSSON: u1,
        reserved24: u4 = 0,
        /// Main PLL enable
        PLLON: u1,
        /// Main PLL clock ready flag
        PLLRDY: u1,
        padding: u6 = 0,
    }),
    /// Internal clock sources calibration register
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Internal High Speed clock Calibration
        HSICAL0: u8,
        /// Internal High Speed clock trimming
        HSITRIM: u7,
        padding: u1 = 0,
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
        /// PB low-speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        reserved24: u10 = 0,
        /// Microcontroller clock output
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// PLL configuration register
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// Main PLL, PLLSAI1 and PLLSAI2 entry clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor for the main PLL and audio PLL (PLLSAI1 and PLLSAI2) input clock
        PLLM: PLLM,
        /// Main PLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// Main PLL PLLSAI3CLK output enable
        PLLPEN: u1,
        /// Main PLL division factor for PLLSAI3CLK (SAI1 and SAI2 clock)
        PLLPBIT: PLLPBIT,
        reserved20: u2 = 0,
        /// Main PLL PLLUSB1CLK output enable
        PLLQEN: u1,
        /// Main PLL division factor for PLLUSB1CLK(48 MHz clock)
        PLLQ: PLLQ,
        reserved24: u1 = 0,
        /// Main PLL PLLCLK output enable
        PLLREN: u1,
        /// Main PLL division factor for PLLCLK (system clock)
        PLLR: PLLR,
        /// Main PLL division factor for PLLSAI2CLK
        PLLP: PLLP,
    }),
    /// offset: 0x10
    reserved16: [8]u8,
    /// Clock interrupt enable register
    /// offset: 0x18
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable
        LSIRDYIE: u1,
        /// LSE ready interrupt enable
        LSERDYIE: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt enable
        HSIRDYIE: u1,
        /// HSE ready interrupt enable
        HSERDYIE: u1,
        /// PLL ready interrupt enable
        PLLRDYIE: u1,
        reserved9: u3 = 0,
        /// LSE clock security system interrupt enable
        LSECSSIE: u1,
        /// HSI48 ready interrupt enable
        HSI48RDYIE: u1,
        padding: u21 = 0,
    }),
    /// Clock interrupt flag register
    /// offset: 0x1c
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag
        LSIRDYF: u1,
        /// LSE ready interrupt flag
        LSERDYF: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt flag
        HSIRDYF: u1,
        /// HSE ready interrupt flag
        HSERDYF: u1,
        /// PLL ready interrupt flag
        PLLRDYF: u1,
        reserved8: u2 = 0,
        /// Clock security system interrupt flag
        CSSF: u1,
        /// LSE Clock security system interrupt flag
        LSECSSF: u1,
        /// HSI48 ready interrupt flag
        HSI48RDYF: u1,
        padding: u21 = 0,
    }),
    /// Clock interrupt clear register
    /// offset: 0x20
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear
        LSIRDYC: u1,
        /// LSE ready interrupt clear
        LSERDYC: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// PLL ready interrupt clear
        PLLRDYC: u1,
        reserved8: u2 = 0,
        /// Clock security system interrupt clear
        CSSC: u1,
        /// LSE Clock security system interrupt clear
        LSECSSC: u1,
        /// HSI48 oscillator ready interrupt clear
        HSI48RDYC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// AHB1 peripheral reset register
    /// offset: 0x28
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        /// DMAMUX1RST
        DMAMUX1RST: u1,
        /// CORDIC reset
        CORDICRST: u1,
        /// FMAC reset
        FMACRST: u1,
        reserved8: u3 = 0,
        /// Flash memory interface reset
        FLASHRST: u1,
        reserved12: u3 = 0,
        /// CRC reset
        CRCRST: u1,
        padding: u19 = 0,
    }),
    /// AHB2 peripheral reset register
    /// offset: 0x2c
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
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
        reserved13: u6 = 0,
        /// ADC reset
        ADC12RST: u1,
        /// SAR ADC345 interface reset
        ADC345RST: u1,
        reserved16: u1 = 0,
        /// DAC1 interface reset
        DAC1RST: u1,
        /// DAC2 interface reset
        DAC2RST: u1,
        /// DAC3 interface reset
        DAC3RST: u1,
        /// DAC4 interface reset
        DAC4RST: u1,
        reserved24: u4 = 0,
        /// Cryptography module reset
        AESRST: u1,
        reserved26: u1 = 0,
        /// Random Number Generator module reset
        RNGRST: u1,
        padding: u5 = 0,
    }),
    /// AHB3 peripheral reset register
    /// offset: 0x30
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller reset
        FMCRST: u1,
        reserved8: u7 = 0,
        /// Quad SPI 1 module reset
        QUADSPIRST: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x34
    reserved52: [4]u8,
    /// APB1 peripheral reset register 1
    /// offset: 0x38
    APB1RSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer reset
        TIM2RST: u1,
        /// TIM3 timer reset
        TIM3RST: u1,
        /// TIM3 timer reset
        TIM4RST: u1,
        /// TIM5 timer reset
        TIM5RST: u1,
        /// TIM6 timer reset
        TIM6RST: u1,
        /// TIM7 timer reset
        TIM7RST: u1,
        reserved8: u2 = 0,
        /// Clock recovery system reset
        CRSRST: u1,
        reserved14: u5 = 0,
        /// SPI2 reset
        SPI2RST: u1,
        /// SPI3 reset
        SPI3RST: u1,
        reserved17: u1 = 0,
        /// USART2 reset
        USART2RST: u1,
        /// USART3 reset
        USART3RST: u1,
        /// UART4 reset
        UART4RST: u1,
        /// UART5 reset
        UART5RST: u1,
        /// I2C1 reset
        I2C1RST: u1,
        /// I2C2 reset
        I2C2RST: u1,
        /// USBD reset
        USBRST: u1,
        reserved25: u1 = 0,
        /// FDCAN reset
        FDCANRST: u1,
        reserved28: u2 = 0,
        /// Power interface reset
        PWRRST: u1,
        reserved30: u1 = 0,
        /// I2C3 interface reset
        I2C3RST: u1,
        /// Low Power Timer 1 reset
        LPTIM1RST: u1,
    }),
    /// APB1 peripheral reset register 2
    /// offset: 0x3c
    APB1RSTR2: mmio.Mmio(packed struct(u32) {
        /// Low-power UART 1 reset
        LPUART1RST: u1,
        /// I2C4 reset
        I2C4RST: u1,
        reserved8: u6 = 0,
        /// UCPD1 reset
        UCPD1RST: u1,
        padding: u23 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x40
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// System configuration (SYSCFG) reset
        SYSCFGRST: u1,
        reserved11: u10 = 0,
        /// TIM1 timer reset
        TIM1RST: u1,
        /// SPI1 reset
        SPI1RST: u1,
        /// TIM8 timer reset
        TIM8RST: u1,
        /// USART1 reset
        USART1RST: u1,
        /// SPI 4 reset
        SPI4RST: u1,
        /// TIM15 timer reset
        TIM15RST: u1,
        /// TIM16 timer reset
        TIM16RST: u1,
        /// TIM17 timer reset
        TIM17RST: u1,
        reserved20: u1 = 0,
        /// Timer 20 reset
        TIM20RST: u1,
        /// Serial audio interface 1 (SAI1) reset
        SAI1RST: u1,
        reserved26: u4 = 0,
        /// HRTIMER reset
        HRTIM1RST: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x44
    reserved68: [4]u8,
    /// AHB1 peripheral clock enable register
    /// offset: 0x48
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        /// DMAMUX clock enable
        DMAMUX1EN: u1,
        /// CORDIC clock enable
        CORDICEN: u1,
        /// FMAC clock enable
        FMACEN: u1,
        reserved8: u3 = 0,
        /// Flash memory interface clock enable
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable
        CRCEN: u1,
        padding: u19 = 0,
    }),
    /// AHB2 peripheral clock enable register
    /// offset: 0x4c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
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
        /// IO port F clock enable
        GPIOFEN: u1,
        /// IO port G clock enable
        GPIOGEN: u1,
        reserved13: u6 = 0,
        /// ADC clock enable
        ADC12EN: u1,
        /// DCMI clock enable
        ADC345EN: u1,
        reserved16: u1 = 0,
        /// AES accelerator clock enable
        DAC1EN: u1,
        /// HASH clock enable
        DAC2EN: u1,
        /// Random Number Generator clock enable
        DAC3EN: u1,
        /// DAC4 clock enable
        DAC4EN: u1,
        reserved24: u4 = 0,
        /// AES clock enable
        AESEN: u1,
        reserved26: u1 = 0,
        /// Random Number Generator clock enable
        RNGEN: u1,
        padding: u5 = 0,
    }),
    /// AHB3 peripheral clock enable register
    /// offset: 0x50
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller clock enable
        FMCEN: u1,
        reserved8: u7 = 0,
        /// QUADSPI memory interface clock enable
        QUADSPIEN: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x54
    reserved84: [4]u8,
    /// APB1ENR1
    /// offset: 0x58
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable
        TIM2EN: u1,
        /// TIM3 timer clock enable
        TIM3EN: u1,
        /// TIM4 timer clock enable
        TIM4EN: u1,
        /// TIM5 timer clock enable
        TIM5EN: u1,
        /// TIM6 timer clock enable
        TIM6EN: u1,
        /// TIM7 timer clock enable
        TIM7EN: u1,
        reserved8: u2 = 0,
        /// CRSclock enable
        CRSEN: u1,
        reserved10: u1 = 0,
        /// RTC APB clock enable
        RTCAPBEN: u1,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable
        SPI2EN: u1,
        /// SPI3 clock enable
        SPI3EN: u1,
        reserved17: u1 = 0,
        /// USART2 clock enable
        USART2EN: u1,
        /// USART3 clock enable
        USART3EN: u1,
        /// UART4 clock enable
        UART4EN: u1,
        /// UART5 clock enable
        UART5EN: u1,
        /// I2C1 clock enable
        I2C1EN: u1,
        /// I2C2 clock enable
        I2C2EN: u1,
        /// USB device clock enable
        USBEN: u1,
        reserved25: u1 = 0,
        /// FDCAN clock enable
        FDCANEN: u1,
        reserved28: u2 = 0,
        /// Power interface clock enable
        PWREN: u1,
        reserved30: u1 = 0,
        /// I2C3 clock enable
        I2C3EN: u1,
        /// Low power timer 1 clock enable
        LPTIM1EN: u1,
    }),
    /// APB1 peripheral clock enable register 2
    /// offset: 0x5c
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clock enable
        LPUART1EN: u1,
        /// I2C4 clock enable
        I2C4EN: u1,
        reserved8: u6 = 0,
        /// UCPD1 clock enable
        UCPD1EN: u1,
        padding: u23 = 0,
    }),
    /// APB2ENR
    /// offset: 0x60
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clock enable
        SYSCFGEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable
        TIM1EN: u1,
        /// SPI1 clock enable
        SPI1EN: u1,
        /// TIM8 timer clock enable
        TIM8EN: u1,
        /// USART1clock enable
        USART1EN: u1,
        /// SPI 4 clock enable
        SPI4EN: u1,
        /// TIM15 timer clock enable
        TIM15EN: u1,
        /// TIM16 timer clock enable
        TIM16EN: u1,
        /// TIM17 timer clock enable
        TIM17EN: u1,
        reserved20: u1 = 0,
        /// Timer 20 clock enable
        TIM20EN: u1,
        /// SAI1 clock enable
        SAI1EN: u1,
        reserved26: u4 = 0,
        /// HRTIMER clock enable
        HRTIM1EN: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x64
    reserved100: [4]u8,
    /// AHB1 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x68
    AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clocks enable during Sleep and Stop modes
        DMA1SMEN: u1,
        /// DMA2 clocks enable during Sleep and Stop modes
        DMA2SMEN: u1,
        /// DMAMUX clock enable during Sleep and Stop modes
        DMAMUX1SMEN: u1,
        /// CORDIC clock enable during sleep mode
        CORDICSMEN: u1,
        /// FMACSM clock enable
        FMACSMEN: u1,
        reserved8: u3 = 0,
        /// Flash memory interface clocks enable during Sleep and Stop modes
        FLASHSMEN: u1,
        /// SRAM1 interface clocks enable during Sleep and Stop modes
        SRAM1SMEN: u1,
        reserved12: u2 = 0,
        /// CRCSMEN
        CRCSMEN: u1,
        padding: u19 = 0,
    }),
    /// AHB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x6c
    AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clocks enable during Sleep and Stop modes
        GPIOASMEN: u1,
        /// IO port B clocks enable during Sleep and Stop modes
        GPIOBSMEN: u1,
        /// IO port C clocks enable during Sleep and Stop modes
        GPIOCSMEN: u1,
        /// IO port D clocks enable during Sleep and Stop modes
        GPIODSMEN: u1,
        /// IO port E clocks enable during Sleep and Stop modes
        GPIOESMEN: u1,
        /// IO port F clocks enable during Sleep and Stop modes
        GPIOFSMEN: u1,
        /// IO port G clocks enable during Sleep and Stop modes
        GPIOGSMEN: u1,
        reserved9: u2 = 0,
        /// CCM SRAM interface clocks enable during Sleep and Stop modes
        CCMSRAMSMEN: u1,
        /// SRAM2 interface clocks enable during Sleep and Stop modes
        SRAM2SMEN: u1,
        reserved13: u2 = 0,
        /// ADC clocks enable during Sleep and Stop modes
        ADC12SMEN: u1,
        /// DCMI clock enable during Sleep and Stop modes
        ADC345SMEN: u1,
        reserved16: u1 = 0,
        /// AES accelerator clocks enable during Sleep and Stop modes
        DAC1SMEN: u1,
        /// HASH clock enable during Sleep and Stop modes
        DAC2SMEN: u1,
        /// DAC3 clock enable during sleep mode
        DAC3SMEN: u1,
        /// DAC4 clock enable during sleep mode
        DAC4SMEN: u1,
        reserved24: u4 = 0,
        /// Cryptography clock enable during sleep mode
        AESMEN: u1,
        reserved26: u1 = 0,
        /// Random Number Generator clock enable during sleep mode
        RNGEN: u1,
        padding: u5 = 0,
    }),
    /// AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x70
    AHB3SMENR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller clocks enable during Sleep and Stop modes
        FMCSMEN: u1,
        reserved8: u7 = 0,
        /// QUADSPI memory interface clock enable during Sleep and Stop modes
        QUADSPISMEN: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x74
    reserved116: [4]u8,
    /// APB1SMENR1
    /// offset: 0x78
    APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clocks enable during Sleep and Stop modes
        TIM2SMEN: u1,
        /// TIM3 timer clocks enable during Sleep and Stop modes
        TIM3SMEN: u1,
        /// TIM4 timer clocks enable during Sleep and Stop modes
        TIM4SMEN: u1,
        /// TIM5 timer clocks enable during Sleep and Stop modes
        TIM5SMEN: u1,
        /// TIM6 timer clocks enable during Sleep and Stop modes
        TIM6SMEN: u1,
        /// TIM7 timer clocks enable during Sleep and Stop modes
        TIM7SMEN: u1,
        reserved8: u2 = 0,
        /// CRS clock enable during sleep mode
        CRSSMEN: u1,
        reserved10: u1 = 0,
        /// RTC APB clock enable during Sleep and Stop modes
        RTCAPBSMEN: u1,
        /// Window watchdog clocks enable during Sleep and Stop modes
        WWDGSMEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clocks enable during Sleep and Stop modes
        SPI2SMEN: u1,
        /// SPI3 clocks enable during Sleep and Stop modes
        SP3SMEN: u1,
        reserved17: u1 = 0,
        /// USART2 clocks enable during Sleep and Stop modes
        USART2SMEN: u1,
        /// USART3 clocks enable during Sleep and Stop modes
        USART3SMEN: u1,
        /// UART4 clocks enable during Sleep and Stop modes
        UART4SMEN: u1,
        /// UART5 clocks enable during Sleep and Stop modes
        UART5SMEN: u1,
        /// I2C1 clocks enable during Sleep and Stop modes
        I2C1SMEN: u1,
        /// I2C2 clocks enable during Sleep and Stop modes
        I2C2SMEN: u1,
        /// USB device clocks enable during Sleep and Stop modes
        USBSMEN: u1,
        reserved25: u1 = 0,
        /// FDCAN clock enable during sleep mode
        FDCANSMEN: u1,
        reserved28: u2 = 0,
        /// Power interface clocks enable during Sleep and Stop modes
        PWRSMEN: u1,
        reserved30: u1 = 0,
        /// I2C3 clocks enable during Sleep and Stop modes
        I2C3SMEN: u1,
        /// Low Power Timer1 clock enable during sleep mode
        LPTIM1SMEN: u1,
    }),
    /// APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0x7c
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clocks enable during Sleep and Stop modes
        LPUART1SMEN: u1,
        /// I2C4 clocks enable during Sleep and Stop modes
        I2C4SMEN: u1,
        reserved8: u6 = 0,
        /// UCPD1 clocks enable during Sleep and Stop modes
        UCPD1SMEN: u1,
        padding: u23 = 0,
    }),
    /// APB2SMENR
    /// offset: 0x80
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clocks enable during Sleep and Stop modes
        SYSCFGSMEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clocks enable during Sleep and Stop modes
        TIM1SMEN: u1,
        /// SPI1 clocks enable during Sleep and Stop modes
        SPI1SMEN: u1,
        /// TIM8 timer clocks enable during Sleep and Stop modes
        TIM8SMEN: u1,
        /// USART1clocks enable during Sleep and Stop modes
        USART1SMEN: u1,
        /// SPI4 timer clocks enable during Sleep and Stop modes
        SPI4SMEN: u1,
        /// TIM15 timer clocks enable during Sleep and Stop modes
        TIM15SMEN: u1,
        /// TIM16 timer clocks enable during Sleep and Stop modes
        TIM16SMEN: u1,
        /// TIM17 timer clocks enable during Sleep and Stop modes
        TIM17SMEN: u1,
        reserved20: u1 = 0,
        /// Timer 20clock enable during sleep mode
        TIM20SMEN: u1,
        /// SAI1 clock enable during sleep mode
        SAI1SMEN: u1,
        reserved26: u4 = 0,
        /// HRTIMER clock enable during sleep mode
        HRTIM1SMEN: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// CCIPR
    /// offset: 0x88
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection
        USART1SEL: u2,
        /// USART2 clock source selection
        USART2SEL: u2,
        /// USART3 clock source selection
        USART3SEL: u2,
        /// UART4 clock source selection
        UART4SEL: u2,
        /// UART5 clock source selection
        UART5SEL: u2,
        /// LPUART1 clock source selection
        LPUART1SEL: u2,
        /// I2C1 clock source selection
        I2C1SEL: u2,
        /// I2C2 clock source selection
        I2C2SEL: u2,
        /// I2C3 clock source selection
        I2C3SEL: u2,
        /// Low power timer 1 clock source selection
        LPTIM1SEL: u2,
        /// SAI1 clock source selection
        SAI1SEL: u2,
        /// I2S23 clock source selection
        I2S23SEL: u2,
        /// FDCAN clock source selection
        FDCANSEL: FDCANSEL,
        /// 48 MHz clock source selection
        CLK48SEL: CLK48SEL,
        /// ADCs clock source selection
        ADC12SEL: ADCSEL,
        /// ADC3/4/5 clock source selection
        ADC345SEL: ADCSEL,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// BDCR
    /// offset: 0x90
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable
        LSEON: u1,
        /// LSE oscillator ready
        LSERDY: u1,
        /// LSE oscillator bypass
        LSEBYP: u1,
        /// SE oscillator drive capability
        LSEDRV: LSEDRV,
        /// LSECSSON
        LSECSSON: u1,
        /// LSECSSD
        LSECSSD: u1,
        reserved8: u1 = 0,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// RTC domain software reset
        BDRST: u1,
        reserved24: u7 = 0,
        /// Low speed clock output enable
        LSCOEN: u1,
        /// Low speed clock output selection
        LSCOSEL: u1,
        padding: u6 = 0,
    }),
    /// CSR
    /// offset: 0x94
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable
        LSION: u1,
        /// LSI oscillator ready
        LSIRDY: u1,
        reserved23: u21 = 0,
        /// Remove reset flag
        RMVF: u1,
        reserved25: u1 = 0,
        /// Option byte loader reset flag
        OBLRSTF: u1,
        /// Pad reset flag
        PINRSTF: u1,
        /// BOR flag
        BORRSTF: u1,
        /// Software reset flag
        SFTRSTF: u1,
        /// Independent window watchdog reset flag
        IWDGRSTF: u1,
        /// Window watchdog reset flag
        WWDGRSTF: u1,
        /// Low-power reset flag
        LPWRRSTF: u1,
    }),
    /// Clock recovery RC register
    /// offset: 0x98
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// HSI48 clock enable
        HSI48ON: u1,
        /// HSI48 clock ready flag
        HSI48RDY: u1,
        reserved7: u5 = 0,
        /// HSI48 clock calibration
        HSI48CAL: u9,
        padding: u16 = 0,
    }),
    /// Peripherals independent clock configuration register
    /// offset: 0x9c
    CCIPR2: mmio.Mmio(packed struct(u32) {
        /// I2C4 clock source selection
        I2C4SEL: u2,
        reserved20: u18 = 0,
        /// Octospi clock source selection
        QUADSPISEL: u2,
        padding: u10 = 0,
    }),
};
