const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    /// SYSCLK used as ADC clock source
    SYS = 0x0,
    /// PLLPCLK used as ADC clock source
    PLL1_P = 0x1,
    /// HSI used as ADC clock source
    HSI = 0x2,
    _,
};

pub const CECSEL = enum(u1) {
    /// HSI divided by 488 used as CEC clock
    HSI_DIV_488 = 0x0,
    /// LSE used as CEC clock
    LSE = 0x1,
};

pub const FDCANSEL = enum(u2) {
    /// PCLK used as FDCAN clock source
    PCLK1 = 0x0,
    /// PLLQCLK used as FDCAN clock source
    PLL1_Q = 0x1,
    /// HSE used as FDCAN clock source
    HSE = 0x2,
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

pub const HSIDIV = enum(u3) {
    /// HSI clock is not divided
    Div1 = 0x0,
    /// HSI clock is divided by 2
    Div2 = 0x1,
    /// HSI clock is divided by 4
    Div4 = 0x2,
    /// HSI clock is divided by 8
    Div8 = 0x3,
    /// HSI clock is divided by 16
    Div16 = 0x4,
    /// HSI clock is divided by 32
    Div32 = 0x5,
    /// HSI clock is divided by 64
    Div64 = 0x6,
    /// HSI clock is divided by 128
    Div128 = 0x7,
};

pub const I2C1SEL = enum(u2) {
    /// PCLK used as I2C1 clock source
    PCLK1 = 0x0,
    /// SYSCLK used as I2C1 clock source
    SYS = 0x1,
    /// HSI used as I2C1 clock source
    HSI = 0x2,
    _,
};

pub const I2C2I2S1SEL = enum(u2) {
    /// PCLK used as I2C2/I2S2 clock source
    PCLK1 = 0x0,
    /// SYSCLK used as I2C2/I2S2 clock source
    SYS = 0x1,
    /// HSI used as I2C2/I2S2 clock source
    HSI = 0x2,
    /// External clock used as I2C2/I2S2 clock source
    I2S_CKIN = 0x3,
};

pub const I2S1SEL = enum(u2) {
    /// SYSCLK used as I2S1 clock source
    SYS = 0x0,
    /// PLLPCLK used as I2S1 clock source
    PLL1_P = 0x1,
    /// HSI used as I2S1 clock source
    HSI = 0x2,
    /// External clock used as I2S1 clock source
    I2S_CKIN = 0x3,
};

pub const I2S2SEL = enum(u2) {
    /// SYSCLK used as I2S2 clock source
    SYS = 0x0,
    /// PLLPCLK used as I2S2 clock source
    PLL1_P = 0x1,
    /// HSI used as I2S2 clock source
    HSI = 0x2,
    /// External clock used as I2S2 clock source
    I2S_CKIN = 0x3,
};

pub const LPTIM1SEL = enum(u2) {
    /// PCLK used as LPTIM1 clock source
    PCLK1 = 0x0,
    /// LSI used as LPTIM1 clock source
    LSI = 0x1,
    /// HSI used as LPTIM1 clock source
    HSI = 0x2,
    /// LSE used as LPTIM1 clock source
    LSE = 0x3,
};

pub const LPTIM2SEL = enum(u2) {
    /// PCLK used as LPTIM2 clock source
    PCLK1 = 0x0,
    /// LSI used as LPTIM2 clock source
    LSI = 0x1,
    /// HSI used as LPTIM2 clock source
    HSI = 0x2,
    /// LSE used as LPTIM2 clock source
    LSE = 0x3,
};

pub const LPUART1SEL = enum(u2) {
    /// PCLK used as LPUART1 clock source
    PCLK1 = 0x0,
    /// SYSCLK used as LPUART1 clock source
    SYS = 0x1,
    /// HSI used as LPUART1 clock source
    HSI = 0x2,
    /// LSE used as LPUART1 clock source
    LSE = 0x3,
};

pub const LPUART2SEL = enum(u2) {
    /// PCLK used as LPUART2 clock source
    PCLK1 = 0x0,
    /// SYSCLK used as LPUART2 clock source
    SYS = 0x1,
    /// HSI used as LPUART2 clock source
    HSI = 0x2,
    /// LSE used as LPUART2 clock source
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

pub const MCOPRE = enum(u4) {
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
    /// MCO clock is divided divided by 32
    Div32 = 0x5,
    /// MCO clock is divided divided by 64
    Div64 = 0x6,
    /// MCO clock is divided divided by 128
    Div128 = 0x7,
    /// MCO clock is divided divided by 256
    Div256 = 0x8,
    /// MCO clock is divided divided by 512
    Div512 = 0x9,
    /// MCO clock is divided divided by 1024
    Div1024 = 0xa,
    _,
};

pub const MCOSEL = enum(u4) {
    /// No clock, MCO output disabled
    DISABLE = 0x0,
    /// SYSCLK selected as MCO source
    SYS = 0x1,
    /// HSI48 selected as MCO source
    HSI48 = 0x2,
    /// HSI selected as MCO source
    HSI = 0x3,
    /// HSE selected as MCO source
    HSE = 0x4,
    /// PLLRCLK selected as MCO source
    PLLRCLK = 0x5,
    /// LSI selected as MCO source
    LSI = 0x6,
    /// LSE selected as MCO source
    LSE = 0x7,
    /// PLLPCLK selected as MCO source
    PLL1_P = 0x8,
    /// PLLQCLK selected as MCO source
    PLL1_Q = 0x9,
    /// RTCCLK selected as MCO source
    RTCCLK = 0xa,
    /// RTC_Wakeup selected as MCO source
    RTC_WKUP = 0xb,
    _,
};

pub const PLLM = enum(u3) {
    Div1 = 0x0,
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
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
    _,
};

pub const PLLP = enum(u5) {
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
    Div17 = 0x10,
    Div18 = 0x11,
    Div19 = 0x12,
    Div20 = 0x13,
    Div21 = 0x14,
    Div22 = 0x15,
    Div23 = 0x16,
    Div24 = 0x17,
    Div25 = 0x18,
    Div26 = 0x19,
    Div27 = 0x1a,
    Div28 = 0x1b,
    Div29 = 0x1c,
    Div30 = 0x1d,
    Div31 = 0x1e,
    Div32 = 0x1f,
    _,
};

pub const PLLQ = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
    _,
};

pub const PLLR = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
    _,
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

pub const RNGDIV = enum(u2) {
    /// RNG clock is not divided
    Div1 = 0x0,
    /// RNG clock is divided by 2
    Div2 = 0x1,
    /// RNG clock is divided by 4
    Div4 = 0x2,
    /// RNG clock is divided by 8
    Div8 = 0x3,
};

pub const RNGSEL = enum(u2) {
    /// No clock used as RNG clock source
    DISABLE = 0x0,
    /// HSI divided by 8 used as RNG clock source
    HSI_DIV_8 = 0x1,
    /// SYSCLK used as RNG clock source
    SYS = 0x2,
    /// PLLQCLK used as RNG clock source
    PLL1_Q = 0x3,
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

pub const SW = enum(u3) {
    /// HSI selected as system clock
    HSI = 0x0,
    /// HSE selected as system clock
    HSE = 0x1,
    /// PLLRCLK selected as system clock
    PLL1_R = 0x2,
    /// LSI selected as system clock
    LSI = 0x3,
    /// LSE selected as system clock
    LSE = 0x4,
    _,
};

pub const TIM15SEL = enum(u1) {
    /// TIMPCLK used as TIM15 clock source
    PCLK1_TIM = 0x0,
    /// PLLQCLK used as TIM15 clock source
    PLL1_Q = 0x1,
};

pub const TIM1SEL = enum(u1) {
    /// TIMPCLK used as TIM1 clock source
    PCLK1_TIM = 0x0,
    /// PLLQCLK used as TIM1 clock source
    PLL1_Q = 0x1,
};

pub const USARTSEL = enum(u2) {
    /// PCLK used as USART clock source
    PCLK1 = 0x0,
    /// SYSCLK used as USART clock source
    SYS = 0x1,
    /// HSI used as USART clock source
    HSI = 0x2,
    /// LSE used as USART clock source
    LSE = 0x3,
};

pub const USBSEL = enum(u2) {
    /// HSI48 used as USB clock source
    HSI48 = 0x0,
    /// HSE used as USB clock source
    HSE = 0x1,
    /// PLLQCLK used as USB clock source
    PLL1_Q = 0x2,
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
        /// HSI clock division factor
        HSIDIV: HSIDIV,
        reserved16: u2 = 0,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE crystal oscillator bypass
        HSEBYP: u1,
        /// Clock security system enable
        CSSON: u1,
        reserved22: u2 = 0,
        /// HSI48ON
        HSI48ON: u1,
        /// HSI48RDY
        HSI48RDY: u1,
        /// PLL enable
        PLLON: u1,
        /// PLL clock ready flag
        PLLRDY: u1,
        padding: u6 = 0,
    }),
    /// Internal clock sources calibration register
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration
        HSICAL: u8,
        /// HSI clock trimming
        HSITRIM: u7,
        padding: u17 = 0,
    }),
    /// Clock configuration register
    /// offset: 0x08
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch
        SW: SW,
        /// System clock switch status
        SWS: SW,
        reserved8: u2 = 0,
        /// AHB prescaler
        HPRE: HPRE,
        /// APB prescaler
        PPRE: PPRE,
        reserved16: u1 = 0,
        /// MCO2SEL
        MCO2SEL: MCOSEL,
        /// MCO2PRE
        MCO2PRE: MCOPRE,
        /// Microcontroller clock output
        MCO1SEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCO1PRE: MCOPRE,
    }),
    /// PLL configuration register
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// PLL input clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor M of the PLL input clock divider
        PLLM: PLLM,
        reserved8: u1 = 0,
        /// PLL frequency multiplication factor N
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// PLLPCLK clock output enable
        PLLPEN: u1,
        /// PLL VCO division factor P for PLLPCLK clock output
        PLLP: PLLP,
        reserved24: u2 = 0,
        /// PLLQCLK clock output enable
        PLLQEN: u1,
        /// PLL VCO division factor Q for PLLQCLK clock output
        PLLQ: PLLQ,
        /// PLLRCLK clock output enable
        PLLREN: u1,
        /// PLL VCO division factor R for PLLRCLK clock output
        PLLR: PLLR,
    }),
    /// offset: 0x10
    reserved16: [4]u8,
    /// RCC clock recovery RC register
    /// offset: 0x14
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// HSI48 clock calibration
        HSI48CAL: u9,
        padding: u23 = 0,
    }),
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
        PLLSYSRDYIE: u1,
        padding: u26 = 0,
    }),
    /// Clock interrupt flag register
    /// offset: 0x1c
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag
        LSIRDYF: u1,
        /// LSE ready interrupt flag
        LSERDYF: u1,
        /// HSI48RDYF
        HSI48RDYF: u1,
        /// HSI ready interrupt flag
        HSIRDYF: u1,
        /// HSE ready interrupt flag
        HSERDYF: u1,
        /// PLL ready interrupt flag
        PLLSYSRDYF: u1,
        reserved8: u2 = 0,
        /// Clock security system interrupt flag
        CSSF: u1,
        /// LSE Clock security system interrupt flag
        LSECSSF: u1,
        padding: u22 = 0,
    }),
    /// Clock interrupt clear register
    /// offset: 0x20
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear
        LSIRDYC: u1,
        /// LSE ready interrupt clear
        LSERDYC: u1,
        /// HSI48RDYC
        HSI48RDYC: u1,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// PLL ready interrupt clear
        PLLSYSRDYC: u1,
        reserved8: u2 = 0,
        /// Clock security system interrupt clear
        CSSC: u1,
        /// LSE Clock security system interrupt clear
        LSECSSC: u1,
        padding: u22 = 0,
    }),
    /// GPIO reset register
    /// offset: 0x24
    GPIORSTR: mmio.Mmio(packed struct(u32) {
        /// I/O port A reset
        GPIOARST: u1,
        /// I/O port B reset
        GPIOBRST: u1,
        /// I/O port C reset
        GPIOCRST: u1,
        /// I/O port D reset
        GPIODRST: u1,
        reserved5: u1 = 0,
        /// I/O port F reset
        GPIOFRST: u1,
        padding: u26 = 0,
    }),
    /// AHB peripheral reset register
    /// offset: 0x28
    AHBRSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 reset
        DMA1RST: u1,
        /// DMA1 reset
        DMA2RST: u1,
        reserved8: u6 = 0,
        /// FLASH reset
        FLASHRST: u1,
        reserved12: u3 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator reset
        AESRST: u1,
        reserved18: u1 = 0,
        /// Random number generator reset
        RNGRST: u1,
        padding: u13 = 0,
    }),
    /// APB peripheral reset register 1
    /// offset: 0x2c
    APBRSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer reset
        TIM2RST: u1,
        /// TIM3 timer reset
        TIM3RST: u1,
        /// TIM4 timer reset
        TIM4RST: u1,
        reserved4: u1 = 0,
        /// TIM6 timer reset
        TIM6RST: u1,
        /// TIM7 timer reset
        TIM7RST: u1,
        reserved7: u1 = 0,
        /// LPUART2RST
        LPUART2RST: u1,
        /// USART5RST
        USART5RST: u1,
        /// USART6RST
        USART6RST: u1,
        reserved12: u2 = 0,
        /// FDCANRST
        FDCANRST: u1,
        /// USBRST
        USBRST: u1,
        /// SPI2 reset
        SPI2RST: u1,
        /// SPI3 reset
        SPI3RST: u1,
        /// CRSRST
        CRSRST: u1,
        /// USART2 reset
        USART2RST: u1,
        /// USART3 reset
        USART3RST: u1,
        /// USART4 reset
        USART4RST: u1,
        /// LPUART1 reset
        LPUART1RST: u1,
        /// I2C1 reset
        I2C1RST: u1,
        /// I2C2 reset
        I2C2RST: u1,
        /// I2C3RST reset
        I2C3RST: u1,
        /// HDMI CEC reset
        CECRST: u1,
        /// UCPD1 reset
        UCPD1RST: u1,
        /// UCPD2 reset
        UCPD2RST: u1,
        /// Debug support reset
        DBGRST: u1,
        /// Power interface reset
        PWRRST: u1,
        /// DAC1 interface reset
        DAC1RST: u1,
        /// Low Power Timer 2 reset
        LPTIM2RST: u1,
        /// Low Power Timer 1 reset
        LPTIM1RST: u1,
    }),
    /// APB peripheral reset register 2
    /// offset: 0x30
    APBRSTR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF reset
        SYSCFGRST: u1,
        reserved11: u10 = 0,
        /// TIM1 timer reset
        TIM1RST: u1,
        /// SPI1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset
        USART1RST: u1,
        /// TIM14 timer reset
        TIM14RST: u1,
        /// TIM15 timer reset
        TIM15RST: u1,
        /// TIM16 timer reset
        TIM16RST: u1,
        /// TIM17 timer reset
        TIM17RST: u1,
        reserved20: u1 = 0,
        /// ADC reset
        ADCRST: u1,
        padding: u11 = 0,
    }),
    /// GPIO clock enable register
    /// offset: 0x34
    GPIOENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable
        GPIOAEN: u1,
        /// I/O port B clock enable
        GPIOBEN: u1,
        /// I/O port C clock enable
        GPIOCEN: u1,
        /// I/O port D clock enable
        GPIODEN: u1,
        reserved5: u1 = 0,
        /// I/O port F clock enable
        GPIOFEN: u1,
        padding: u26 = 0,
    }),
    /// AHB peripheral clock enable register
    /// offset: 0x38
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        reserved8: u6 = 0,
        /// Flash memory interface clock enable
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator
        AESEN: u1,
        reserved18: u1 = 0,
        /// Random number generator clock enable
        RNGEN: u1,
        padding: u13 = 0,
    }),
    /// APB peripheral clock enable register 1
    /// offset: 0x3c
    APBENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable
        TIM2EN: u1,
        /// TIM3 timer clock enable
        TIM3EN: u1,
        /// TIM4 timer clock enable
        TIM4EN: u1,
        reserved4: u1 = 0,
        /// TIM6 timer clock enable
        TIM6EN: u1,
        /// TIM7 timer clock enable
        TIM7EN: u1,
        reserved7: u1 = 0,
        /// LPUART2 clock enable
        LPUART2EN: u1,
        /// USART5EN
        USART5EN: u1,
        /// USART6EN
        USART6EN: u1,
        /// RTC APB clock enable
        RTCAPBEN: u1,
        /// WWDG clock enable
        WWDGEN: u1,
        /// USBEN
        FDCANEN: u1,
        /// USBEN
        USBEN: u1,
        /// SPI2 clock enable
        SPI2EN: u1,
        /// SPI3 clock enable
        SPI3EN: u1,
        /// CRSEN
        CRSEN: u1,
        /// USART2 clock enable
        USART2EN: u1,
        /// USART3 clock enable
        USART3EN: u1,
        /// USART4 clock enable
        USART4EN: u1,
        /// LPUART1 clock enable
        LPUART1EN: u1,
        /// I2C1 clock enable
        I2C1EN: u1,
        /// I2C2 clock enable
        I2C2EN: u1,
        /// I2C3 clock enable
        I2C3EN: u1,
        /// HDMI CEC clock enable
        CECEN: u1,
        /// UCPD1 clock enable
        UCPD1EN: u1,
        /// UCPD2 clock enable
        UCPD2EN: u1,
        /// Debug support clock enable
        DBGEN: u1,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC1 interface clock enable
        DAC1EN: u1,
        /// LPTIM2 clock enable
        LPTIM2EN: u1,
        /// LPTIM1 clock enable
        LPTIM1EN: u1,
    }),
    /// APB peripheral clock enable register 2
    /// offset: 0x40
    APBENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF clock enable
        SYSCFGEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable
        TIM1EN: u1,
        /// SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        /// TIM14 timer clock enable
        TIM14EN: u1,
        /// TIM15 timer clock enable
        TIM15EN: u1,
        /// TIM16 timer clock enable
        TIM16EN: u1,
        /// TIM16 timer clock enable
        TIM17EN: u1,
        reserved20: u1 = 0,
        /// ADC clock enable
        ADCEN: u1,
        padding: u11 = 0,
    }),
    /// GPIO in Sleep mode clock enable register
    /// offset: 0x44
    GPIOSMENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable during Sleep mode
        GPIOASMEN: u1,
        /// I/O port B clock enable during Sleep mode
        GPIOBSMEN: u1,
        /// I/O port C clock enable during Sleep mode
        GPIOCSMEN: u1,
        /// I/O port D clock enable during Sleep mode
        GPIODSMEN: u1,
        reserved5: u1 = 0,
        /// I/O port F clock enable during Sleep mode
        GPIOFSMEN: u1,
        padding: u26 = 0,
    }),
    /// AHB peripheral clock enable in Sleep mode register
    /// offset: 0x48
    AHBSMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable during Sleep mode
        DMA1SMEN: u1,
        /// DMA2 clock enable during Sleep mode
        DMA2SMEN: u1,
        reserved8: u6 = 0,
        /// Flash memory interface clock enable during Sleep mode
        FLASHSMEN: u1,
        /// SRAM clock enable during Sleep mode
        SRAMSMEN: u1,
        reserved12: u2 = 0,
        /// CRC clock enable during Sleep mode
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator clock enable during Sleep mode
        AESSMEN: u1,
        reserved18: u1 = 0,
        /// Random number generator clock enable during Sleep mode
        RNGSMEN: u1,
        padding: u13 = 0,
    }),
    /// APB peripheral clock enable in Sleep mode register 1
    /// offset: 0x4c
    APBSMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable during Sleep mode
        TIM2SMEN: u1,
        /// TIM3 timer clock enable during Sleep mode
        TIM3SMEN: u1,
        /// TIM4 timer clock enable during Sleep mode
        TIM4SMEN: u1,
        reserved4: u1 = 0,
        /// TIM6 timer clock enable during Sleep mode
        TIM6SMEN: u1,
        /// TIM7 timer clock enable during Sleep mode
        TIM7SMEN: u1,
        reserved7: u1 = 0,
        /// LPUART2 clock enable
        LPUART2SMEN: u1,
        /// USART5 clock enable
        USART5SMEN: u1,
        /// USART6 clock enable
        USART6SMEN: u1,
        /// RTC APB clock enable during Sleep mode
        RTCAPBSMEN: u1,
        /// WWDG clock enable during Sleep mode
        WWDGSMEN: u1,
        /// FDCAN clock enable during Sleep mode
        FDCANSMEN: u1,
        /// USB clock enable during Sleep mode
        USBSMEN: u1,
        /// SPI2 clock enable during Sleep mode
        SPI2SMEN: u1,
        /// SPI3 clock enable during Sleep mode
        SPI3SMEN: u1,
        /// CRSS clock enable during Sleep mode
        CRSSSMEN: u1,
        /// USART2 clock enable during Sleep mode
        USART2SMEN: u1,
        /// USART3 clock enable during Sleep mode
        USART3SMEN: u1,
        /// USART4 clock enable during Sleep mode
        USART4SMEN: u1,
        /// LPUART1 clock enable during Sleep mode
        LPUART1SMEN: u1,
        /// I2C1 clock enable during Sleep mode
        I2C1SMEN: u1,
        /// I2C2 clock enable during Sleep mode
        I2C2SMEN: u1,
        /// I2C3 clock enable during Sleep mode
        I2C3SMEN: u1,
        /// HDMI CEC clock enable during Sleep mode
        CECSMEN: u1,
        /// UCPD1 clock enable during Sleep mode
        UCPD1SMEN: u1,
        /// UCPD2 clock enable during Sleep mode
        UCPD2SMEN: u1,
        /// Debug support clock enable during Sleep mode
        DBGSMEN: u1,
        /// Power interface clock enable during Sleep mode
        PWRSMEN: u1,
        /// DAC1 interface clock enable during Sleep mode
        DAC1SMEN: u1,
        /// Low Power Timer 2 clock enable during Sleep mode
        LPTIM2SMEN: u1,
        /// Low Power Timer 1 clock enable during Sleep mode
        LPTIM1SMEN: u1,
    }),
    /// APB peripheral clock enable in Sleep mode register 2
    /// offset: 0x50
    APBSMENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF clock enable during Sleep mode
        SYSCFGSMEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable during Sleep mode
        TIM1SMEN: u1,
        /// SPI1 clock enable during Sleep mode
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during Sleep mode
        USART1SMEN: u1,
        /// TIM14 timer clock enable during Sleep mode
        TIM14SMEN: u1,
        /// TIM15 timer clock enable during Sleep mode
        TIM15SMEN: u1,
        /// TIM16 timer clock enable during Sleep mode
        TIM16SMEN: u1,
        /// TIM16 timer clock enable during Sleep mode
        TIM17SMEN: u1,
        reserved20: u1 = 0,
        /// ADC clock enable during Sleep mode
        ADCSMEN: u1,
        padding: u11 = 0,
    }),
    /// Peripherals independent clock configuration register
    /// offset: 0x54
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection
        USART1SEL: USARTSEL,
        /// USART2 clock source selection
        USART2SEL: USARTSEL,
        /// USART3 clock source selection
        USART3SEL: USARTSEL,
        /// HDMI CEC clock source selection
        CECSEL: CECSEL,
        reserved8: u1 = 0,
        /// LPUART2 clock source selection
        LPUART2SEL: LPUART2SEL,
        /// LPUART1 clock source selection
        LPUART1SEL: LPUART1SEL,
        /// I2C1 clock source selection
        I2C1SEL: I2C1SEL,
        /// I2C2 or I2S1 clock source selection
        I2C2I2S1SEL: I2C2I2S1SEL,
        reserved18: u2 = 0,
        /// LPTIM1 clock source selection
        LPTIM1SEL: LPTIM1SEL,
        /// LPTIM2 clock source selection
        LPTIM2SEL: LPTIM2SEL,
        /// TIM1 clock source selection
        TIM1SEL: TIM1SEL,
        reserved24: u1 = 0,
        /// TIM15 clock source selection
        TIM15SEL: TIM15SEL,
        reserved26: u1 = 0,
        /// RNG clock source selection
        RNGSEL: RNGSEL,
        /// Division factor of RNG clock divider
        RNGDIV: RNGDIV,
        /// ADCs clock source selection
        ADCSEL: ADCSEL,
    }),
    /// Peripherals independent clock configuration register 2
    /// offset: 0x58
    CCIPR2: mmio.Mmio(packed struct(u32) {
        /// I2S1SEL
        I2S1SEL: I2S1SEL,
        /// I2S2SEL
        I2S2SEL: I2S2SEL,
        reserved8: u4 = 0,
        /// FDCANSEL
        FDCANSEL: FDCANSEL,
        reserved12: u2 = 0,
        /// USBSEL
        USBSEL: USBSEL,
        padding: u18 = 0,
    }),
    /// RTC domain control register
    /// offset: 0x5c
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable
        LSEON: u1,
        /// LSE oscillator ready
        LSERDY: u1,
        /// LSE oscillator bypass
        LSEBYP: u1,
        /// LSE oscillator drive capability
        LSEDRV: LSEDRV,
        /// CSS on LSE enable
        LSECSSON: u1,
        /// CSS on LSE failure Detection
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
        /// Low-speed clock output (LSCO) enable
        LSCOEN: u1,
        /// Low-speed clock output selection
        LSCOSEL: u1,
        padding: u6 = 0,
    }),
    /// Control/status register
    /// offset: 0x60
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable
        LSION: u1,
        /// LSI oscillator ready
        LSIRDY: u1,
        reserved23: u21 = 0,
        /// Remove reset flags
        RMVF: u1,
        reserved25: u1 = 0,
        /// Option byte loader reset flag
        OBLRSTF: u1,
        /// Pin reset flag
        PINRSTF: u1,
        /// BOR or POR/PDR flag
        PWRRSTF: u1,
        /// Software reset flag
        SFTRSTF: u1,
        /// Independent window watchdog reset flag
        IWDGRSTF: u1,
        /// Window watchdog reset flag
        WWDGRSTF: u1,
        /// Low-power reset flag
        LPWRRSTF: u1,
    }),
};
