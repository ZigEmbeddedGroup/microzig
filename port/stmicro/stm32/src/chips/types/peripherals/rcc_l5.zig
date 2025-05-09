const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    /// No clock selected
    DISABLE = 0x0,
    /// PLLADC1CLK clock selected
    PLLSAI1_R = 0x1,
    /// SYSCLK clock selected
    SYS = 0x3,
    _,
};

pub const CLK48SEL = enum(u2) {
    /// HSI48 clock selected
    HSI48 = 0x0,
    /// PLLSAI1_Q aka PLL48M1CLK clock selected
    PLLSAI1_Q = 0x1,
    /// PLL_Q aka PLL48M2CLK clock selected
    PLL1_Q = 0x2,
    /// MSI clock selected
    MSI = 0x3,
};

pub const FDCANSEL = enum(u2) {
    /// HSE clock selected
    HSE = 0x0,
    /// PLL "Q" clock selected
    PLL1_Q = 0x1,
    /// PLLSAI "P" clock selected
    PLLSAI1_P = 0x2,
    _,
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

pub const LSCOSEL = enum(u1) {
    /// LSI clock selected"
    LSI = 0x0,
    /// LSE clock selected
    LSE = 0x1,
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
    /// MCO divided by 1
    Div1 = 0x0,
    /// MCO divided by 2
    Div2 = 0x1,
    /// MCO divided by 4
    Div4 = 0x2,
    /// MCO divided by 8
    Div8 = 0x3,
    /// MCO divided by 16
    Div16 = 0x4,
    _,
};

pub const MCOSEL = enum(u4) {
    /// MCO output disabled, no clock on MCO
    DISABLE = 0x0,
    /// SYSCLK system clock selected
    SYS = 0x1,
    /// MSI clock selected
    MSI = 0x2,
    /// HSI clock selected
    HSI = 0x3,
    /// HSE clock selected
    HSE = 0x4,
    /// Main PLL clock selected
    PLL = 0x5,
    /// LSI clock selected
    LSI = 0x6,
    /// LSE clock selected
    LSE = 0x7,
    /// Internal HSI48 clock selected
    HSI48 = 0x8,
    _,
};

pub const MSIRANGE = enum(u4) {
    /// range 0 around 100 kHz
    Range100K = 0x0,
    /// range 1 around 200 kHz
    Range200K = 0x1,
    /// range 2 around 400 kHz
    Range400K = 0x2,
    /// range 3 around 800 kHz
    Range800K = 0x3,
    /// range 4 around 1 MHz
    Range1M = 0x4,
    /// range 5 around 2 MHz
    Range2M = 0x5,
    /// range 6 around 4 MHz
    Range4M = 0x6,
    /// range 7 around 8 MHz
    Range8M = 0x7,
    /// range 8 around 16 MHz
    Range16M = 0x8,
    /// range 9 around 24 MHz
    Range24M = 0x9,
    /// range 10 around 32 MHz
    Range32M = 0xa,
    /// range 11 around 48 MHz
    Range48M = 0xb,
    _,
};

pub const MSIRGSEL = enum(u1) {
    /// MSI Range is provided by MSISRANGE[3:0] in RCC_CSR register
    CSR = 0x0,
    /// MSI Range is provided by MSIRANGE[3:0] in the RCC_CR register
    CR = 0x1,
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
    /// No clock sent to PLL
    DISABLE = 0x0,
    /// MSI selected as PLL input clock
    MSI = 0x1,
    /// HSI selected as PLL input clock
    HSI = 0x2,
    /// HSE selected as PLL input clock
    HSE = 0x3,
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

pub const STOPWUCK = enum(u1) {
    /// MSI oscillator selected as wake-up from Stop clock and CSS backup clock
    MSI = 0x0,
    /// HSI oscillator selected as wake-up from stop clock and CSS backup clock
    HSI = 0x1,
};

pub const SW = enum(u2) {
    /// MSI selected as system clock
    MSI = 0x0,
    /// HSI selected as system clock
    HSI = 0x1,
    /// HSE selected as system clock
    HSE = 0x2,
    /// PLL selected as system clock
    PLL1_R = 0x3,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// MSI clock enable
        MSION: u1,
        /// MSI clock ready flag
        MSIRDY: u1,
        /// MSI clock PLL enable
        MSIPLLEN: u1,
        /// MSI clock range selection
        MSIRGSEL: MSIRGSEL,
        /// MSI clock ranges
        MSIRANGE: MSIRANGE,
        /// HSI clock enable
        HSION: u1,
        /// HSI always enable for peripheral kernels
        HSIKERON: u1,
        /// HSI clock ready flag
        HSIRDY: u1,
        /// HSI automatic start from Stop
        HSIASFS: u1,
        reserved16: u4 = 0,
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
        /// SAI1 PLL enable
        PLLSAI1ON: u1,
        /// SAI1 PLL clock ready flag
        PLLSAI1RDY: u1,
        /// SAI2 PLL enable
        PLLSAI2ON: u1,
        /// SAI2 PLL clock ready flag
        PLLSAI2RDY: u1,
        reserved31: u1 = 0,
        /// PRIV
        PRIV: u1,
    }),
    /// Internal clock sources calibration register
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        /// MSI clock calibration
        MSICAL: u8,
        /// MSI clock trimming
        MSITRIM: u8,
        /// HSI clock calibration
        HSICAL: u8,
        /// HSI clock trimming
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
        /// APB low-speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        reserved15: u1 = 0,
        /// Wakeup from Stop and CSS backup clock selection
        STOPWUCK: STOPWUCK,
        reserved24: u8 = 0,
        /// Microcontroller clock output selection
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// PLL configuration register
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// PLL clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor for the PLL input clock
        PLLM: PLLM,
        /// PLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// PLL PLLSAI3CLK output enable
        PLLPEN: u1,
        /// PLL division factor for PLLSAI3CLK (SAI1 and SAI2 clock)
        PLLPBIT: PLLPBIT,
        reserved20: u2 = 0,
        /// PLL PLLUSB1CLK output enable
        PLLQEN: u1,
        /// PLL division factor for PLLUSB1CLK(48 MHz clock)
        PLLQ: PLLQ,
        reserved24: u1 = 0,
        /// PLL PLLCLK output enable
        PLLREN: u1,
        /// PLL division factor for PLLCLK (system clock)
        PLLR: PLLR,
        /// PLL division factor for PLLSAI2CLK
        PLLP: PLLP,
    }),
    /// PLLSAI1 configuration register
    /// offset: 0x10
    PLLSAI1CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor for the PLL input clock
        PLLM: PLLM,
        /// PLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// PLL PLLSAI3CLK output enable
        PLLPEN: u1,
        /// PLL division factor for PLLSAI3CLK (SAI1 and SAI2 clock)
        PLLPBIT: PLLPBIT,
        reserved20: u2 = 0,
        /// PLL PLLUSB1CLK output enable
        PLLQEN: u1,
        /// PLL division factor for PLLUSB1CLK(48 MHz clock)
        PLLQ: PLLQ,
        reserved24: u1 = 0,
        /// PLL PLLCLK output enable
        PLLREN: u1,
        /// PLL division factor for PLLCLK (system clock)
        PLLR: PLLR,
        /// PLL division factor for PLLSAI2CLK
        PLLP: PLLP,
    }),
    /// PLLSAI2 configuration register
    /// offset: 0x14
    PLLSAI2CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor for the PLL input clock
        PLLM: PLLM,
        /// PLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// PLL PLLSAI3CLK output enable
        PLLPEN: u1,
        /// PLL division factor for PLLSAI3CLK (SAI1 and SAI2 clock)
        PLLPBIT: PLLPBIT,
        reserved20: u2 = 0,
        /// PLL PLLUSB1CLK output enable
        PLLQEN: u1,
        /// PLL division factor for PLLUSB1CLK(48 MHz clock)
        PLLQ: PLLQ,
        reserved24: u1 = 0,
        /// PLL PLLCLK output enable
        PLLREN: u1,
        /// PLL division factor for PLLCLK (system clock)
        PLLR: PLLR,
        /// PLL division factor for PLLSAI2CLK
        PLLP: PLLP,
    }),
    /// Clock interrupt enable register
    /// offset: 0x18
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable
        LSIRDYIE: u1,
        /// LSE ready interrupt enable
        LSERDYIE: u1,
        /// MSI ready interrupt enable
        MSIRDYIE: u1,
        /// HSI ready interrupt enable
        HSIRDYIE: u1,
        /// HSE ready interrupt enable
        HSERDYIE: u1,
        /// PLL ready interrupt enable
        PLLRDYIE: u1,
        /// PLLSAI1 ready interrupt enable
        PLLSAI1RDYIE: u1,
        /// PLLSAI2 ready interrupt enable
        PLLSAI2RDYIE: u1,
        reserved9: u1 = 0,
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
        /// MSI ready interrupt flag
        MSIRDYF: u1,
        /// HSI ready interrupt flag
        HSIRDYF: u1,
        /// HSE ready interrupt flag
        HSERDYF: u1,
        /// PLL ready interrupt flag
        PLLRDYF: u1,
        /// PLLSAI1 ready interrupt flag
        PLLSAI1RDYF: u1,
        /// PLLSAI2 ready interrupt flag
        PLLSAI2RDYF: u1,
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
        /// MSI ready interrupt clear
        MSIRDYC: u1,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// PLL ready interrupt clear
        PLLRDYC: u1,
        /// PLLSAI1 ready interrupt clear
        PLLSAI1RDYC: u1,
        /// PLLSAI2 ready interrupt clear
        PLLSAI2RDYC: u1,
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
        reserved8: u5 = 0,
        /// Flash memory interface reset
        FLASHRST: u1,
        reserved12: u3 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved16: u3 = 0,
        /// Touch Sensing Controller reset
        TSCRST: u1,
        reserved22: u5 = 0,
        /// GTZC reset
        GTZCRST: u1,
        padding: u9 = 0,
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
        /// IO port H reset
        GPIOHRST: u1,
        reserved13: u5 = 0,
        /// ADC reset
        ADCRST: u1,
        reserved16: u2 = 0,
        /// AES hardware accelerator reset
        AESRST: u1,
        /// Hash reset
        HASHRST: u1,
        /// Random number generator reset
        RNGRST: u1,
        /// PKARST
        PKARST: u1,
        reserved21: u1 = 0,
        /// OTFDEC1RST
        OTFDEC1RST: u1,
        /// SDMMC1 reset
        SDMMC1RST: u1,
        padding: u9 = 0,
    }),
    /// AHB3 peripheral reset register
    /// offset: 0x30
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller reset
        FMCRST: u1,
        reserved8: u7 = 0,
        /// OCTOSPI1RST
        OCTOSPI1RST: u1,
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
        reserved14: u8 = 0,
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
        /// I2C3 reset
        I2C3RST: u1,
        /// CRS reset
        CRSRST: u1,
        reserved28: u3 = 0,
        /// Power interface reset
        PWRRST: u1,
        /// DAC1 interface reset
        DAC1RST: u1,
        /// OPAMP interface reset
        OPAMPRST: u1,
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
        reserved5: u3 = 0,
        /// Low-power timer 2 reset
        LPTIM2RST: u1,
        /// LPTIM3RST
        LPTIM3RST: u1,
        reserved9: u2 = 0,
        /// FDCAN1RST
        FDCAN1RST: u1,
        reserved21: u11 = 0,
        /// USBRST
        USBRST: u1,
        reserved23: u1 = 0,
        /// UCPD1RST
        UCPD1RST: u1,
        padding: u8 = 0,
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
        reserved16: u1 = 0,
        /// TIM15 timer reset
        TIM15RST: u1,
        /// TIM16 timer reset
        TIM16RST: u1,
        /// TIM17 timer reset
        TIM17RST: u1,
        reserved21: u2 = 0,
        /// Serial audio interface 1 (SAI1) reset
        SAI1RST: u1,
        /// Serial audio interface 2 (SAI2) reset
        SAI2RST: u1,
        reserved24: u1 = 0,
        /// Digital filters for sigma-delata modulators (DFSDM) reset
        DFSDM1RST: u1,
        padding: u7 = 0,
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
        reserved8: u5 = 0,
        /// Flash memory interface clock enable
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved16: u3 = 0,
        /// Touch Sensing Controller clock enable
        TSCEN: u1,
        reserved22: u5 = 0,
        /// GTZCEN
        GTZCEN: u1,
        padding: u9 = 0,
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
        /// IO port H clock enable
        GPIOHEN: u1,
        reserved13: u5 = 0,
        /// ADC clock enable
        ADCEN: u1,
        reserved16: u2 = 0,
        /// AES accelerator clock enable
        AESEN: u1,
        /// HASH clock enable
        HASHEN: u1,
        /// Random Number Generator clock enable
        RNGEN: u1,
        /// PKAEN
        PKAEN: u1,
        reserved21: u1 = 0,
        /// OTFDEC1EN
        OTFDEC1EN: u1,
        /// SDMMC1 clock enable
        SDMMC1EN: u1,
        padding: u9 = 0,
    }),
    /// AHB3 peripheral clock enable register
    /// offset: 0x50
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller clock enable
        FMCEN: u1,
        reserved8: u7 = 0,
        /// OCTOSPI1EN
        OCTOSPI1EN: u1,
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
        reserved10: u4 = 0,
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
        /// I2C3 clock enable
        I2C3EN: u1,
        /// Clock Recovery System clock enable
        CRSEN: u1,
        reserved28: u3 = 0,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC1 interface clock enable
        DAC1EN: u1,
        /// OPAMP interface clock enable
        OPAMPEN: u1,
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
        reserved5: u3 = 0,
        /// LPTIM2EN
        LPTIM2EN: u1,
        /// LPTIM3EN
        LPTIM3EN: u1,
        reserved9: u2 = 0,
        /// FDCAN1EN
        FDCAN1EN: u1,
        reserved21: u11 = 0,
        /// USBEN
        USBEN: u1,
        reserved23: u1 = 0,
        /// UCPD1EN
        UCPD1EN: u1,
        padding: u8 = 0,
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
        reserved16: u1 = 0,
        /// TIM15 timer clock enable
        TIM15EN: u1,
        /// TIM16 timer clock enable
        TIM16EN: u1,
        /// TIM17 timer clock enable
        TIM17EN: u1,
        reserved21: u2 = 0,
        /// SAI1 clock enable
        SAI1EN: u1,
        /// SAI2 clock enable
        SAI2EN: u1,
        reserved24: u1 = 0,
        /// DFSDM timer clock enable
        DFSDM1EN: u1,
        padding: u7 = 0,
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
        reserved8: u5 = 0,
        /// Flash memory interface clocks enable during Sleep and Stop modes
        FLASHSMEN: u1,
        /// SRAM1 interface clocks enable during Sleep and Stop modes
        SRAM1SMEN: u1,
        reserved12: u2 = 0,
        /// CRCSMEN
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// Touch Sensing Controller clocks enable during Sleep and Stop modes
        TSCSMEN: u1,
        reserved22: u5 = 0,
        /// GTZCSMEN
        GTZCSMEN: u1,
        /// ICACHESMEN
        ICACHESMEN: u1,
        padding: u8 = 0,
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
        /// IO port H clocks enable during Sleep and Stop modes
        GPIOHSMEN: u1,
        reserved9: u1 = 0,
        /// SRAM2 interface clocks enable during Sleep and Stop modes
        SRAM2SMEN: u1,
        reserved13: u3 = 0,
        /// ADC clocks enable during Sleep and Stop modes
        ADCFSSMEN: u1,
        reserved16: u2 = 0,
        /// AES accelerator clocks enable during Sleep and Stop modes
        AESSMEN: u1,
        /// HASH clock enable during Sleep and Stop modes
        HASHSMEN: u1,
        /// Random Number Generator clocks enable during Sleep and Stop modes
        RNGSMEN: u1,
        /// PKASMEN
        PKASMEN: u1,
        reserved21: u1 = 0,
        /// OTFDEC1SMEN
        OTFDEC1SMEN: u1,
        /// SDMMC1 clocks enable during Sleep and Stop modes
        SDMMC1SMEN: u1,
        padding: u9 = 0,
    }),
    /// AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x70
    AHB3SMENR: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller clocks enable during Sleep and Stop modes
        FMCSMEN: u1,
        reserved8: u7 = 0,
        /// OCTOSPI1SMEN
        OCTOSPI1SMEN: u1,
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
        reserved10: u4 = 0,
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
        /// I2C3 clocks enable during Sleep and Stop modes
        I2C3SMEN: u1,
        /// CRS clock enable during Sleep and Stop modes
        CRSSMEN: u1,
        reserved28: u3 = 0,
        /// Power interface clocks enable during Sleep and Stop modes
        PWRSMEN: u1,
        /// DAC1 interface clocks enable during Sleep and Stop modes
        DAC1SMEN: u1,
        /// OPAMP interface clocks enable during Sleep and Stop modes
        OPAMPSMEN: u1,
        /// Low power timer 1 clocks enable during Sleep and Stop modes
        LPTIM1SMEN: u1,
    }),
    /// APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0x7c
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clocks enable during Sleep and Stop modes
        LPUART1SMEN: u1,
        /// I2C4 clocks enable during Sleep and Stop modes
        I2C4SMEN: u1,
        reserved5: u3 = 0,
        /// LPTIM2SMEN
        LPTIM2SMEN: u1,
        /// LPTIM3SMEN
        LPTIM3SMEN: u1,
        reserved9: u2 = 0,
        /// FDCAN1SMEN
        FDCAN1SMEN: u1,
        reserved21: u11 = 0,
        /// USBSMEN
        USBSMEN: u1,
        reserved23: u1 = 0,
        /// UCPD1SMEN
        UCPD1SMEN: u1,
        padding: u8 = 0,
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
        reserved16: u1 = 0,
        /// TIM15 timer clocks enable during Sleep and Stop modes
        TIM15SMEN: u1,
        /// TIM16 timer clocks enable during Sleep and Stop modes
        TIM16SMEN: u1,
        /// TIM17 timer clocks enable during Sleep and Stop modes
        TIM17SMEN: u1,
        reserved21: u2 = 0,
        /// SAI1 clocks enable during Sleep and Stop modes
        SAI1SMEN: u1,
        /// SAI2 clocks enable during Sleep and Stop modes
        SAI2SMEN: u1,
        reserved24: u1 = 0,
        /// DFSDM timer clocks enable during Sleep and Stop modes
        DFSDM1SMEN: u1,
        padding: u7 = 0,
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
        /// Low power timer 2 clock source selection
        LPTIM2SEL: u2,
        /// Low-power timer 3 clock source selection
        LPTIM3SEL: u2,
        /// FDCAN clock source selection
        FDCANSEL: FDCANSEL,
        /// 48 MHz clock source selection
        CLK48SEL: CLK48SEL,
        /// ADCs clock source selection
        ADCSEL: ADCSEL,
        padding: u2 = 0,
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
        /// LSESYSEN
        LSESYSEN: u1,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved11: u1 = 0,
        /// LSESYSRDY
        LSESYSRDY: u1,
        reserved15: u3 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// Backup domain software reset
        BDRST: u1,
        reserved24: u7 = 0,
        /// Low speed clock output enable
        LSCOEN: u1,
        /// Low speed clock output selection
        LSCOSEL: LSCOSEL,
        padding: u6 = 0,
    }),
    /// CSR
    /// offset: 0x94
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable
        LSION: u1,
        /// LSI oscillator ready
        LSIRDY: u1,
        reserved4: u2 = 0,
        /// LSIPREDIV
        LSIPREDIV: u1,
        reserved8: u3 = 0,
        /// SI range after Standby mode
        MSISRANGE: u4,
        reserved23: u11 = 0,
        /// Remove reset flag
        RMVF: u1,
        reserved25: u1 = 0,
        /// Option byte loader reset flag
        OBLRSTF: u1,
        /// Pin reset flag
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
        /// Digital filter for sigma delta modulator kernel clock source selection
        DFSDMSEL: u1,
        /// Digital filter for sigma delta modulator audio clock source selection
        ADFSDMSEL: u2,
        /// SAI1 clock source selection
        SAI1SEL: u3,
        /// SAI2 clock source selection
        SAI2SEL: u3,
        reserved14: u3 = 0,
        /// SDMMC clock selection
        SDMMCSEL: u1,
        reserved20: u5 = 0,
        /// Octospi clock source selection
        OCTOSPISEL: u2,
        padding: u10 = 0,
    }),
    /// offset: 0xa0
    reserved160: [24]u8,
    /// RCC secure configuration register
    /// offset: 0xb8
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// HSISEC
        HSISEC: u1,
        /// HSESEC
        HSESEC: u1,
        /// MSISEC
        MSISEC: u1,
        /// LSISEC
        LSISEC: u1,
        /// LSESEC
        LSESEC: u1,
        /// SYSCLKSEC
        SYSCLKSEC: u1,
        /// PRESCSEC
        PRESCSEC: u1,
        /// PLLSEC
        PLLSEC: u1,
        /// PLLSAI1SEC
        PLLSAI1SEC: u1,
        /// PLLSAI2SEC
        PLLSAI2SEC: u1,
        /// CLK48SEC
        CLK48SEC: u1,
        /// HSI48SEC
        HSI48SEC: u1,
        /// RMVFSEC
        RMVFSEC: u1,
        padding: u19 = 0,
    }),
    /// RCC secure status register
    /// offset: 0xbc
    SECSR: mmio.Mmio(packed struct(u32) {
        /// HSISECF
        HSISECF: u1,
        /// HSESECF
        HSESECF: u1,
        /// MSISECF
        MSISECF: u1,
        /// LSISECF
        LSISECF: u1,
        /// LSESECF
        LSESECF: u1,
        /// SYSCLKSECF
        SYSCLKSECF: u1,
        /// PRESCSECF
        PRESCSECF: u1,
        /// PLLSECF
        PLLSECF: u1,
        /// PLLSAI1SECF
        PLLSAI1SECF: u1,
        /// PLLSAI2SECF
        PLLSAI2SECF: u1,
        /// CLK48SECF
        CLK48SECF: u1,
        /// HSI48SECF
        HSI48SECF: u1,
        /// RMVFSECF
        RMVFSECF: u1,
        padding: u19 = 0,
    }),
    /// offset: 0xc0
    reserved192: [40]u8,
    /// RCC AHB1 security status register
    /// offset: 0xe8
    AHB1SECSR: mmio.Mmio(packed struct(u32) {
        /// DMA1SECF
        DMA1SECF: u1,
        /// DMA2SECF
        DMA2SECF: u1,
        /// DMAMUX1SECF
        DMAMUX1SECF: u1,
        reserved8: u5 = 0,
        /// FLASHSECF
        FLASHSECF: u1,
        /// SRAM1SECF
        SRAM1SECF: u1,
        reserved12: u2 = 0,
        /// CRCSECF
        CRCSECF: u1,
        reserved16: u3 = 0,
        /// TSCSECF
        TSCSECF: u1,
        reserved22: u5 = 0,
        /// GTZCSECF
        GTZCSECF: u1,
        /// ICACHESECF
        ICACHESECF: u1,
        padding: u8 = 0,
    }),
    /// RCC AHB2 security status register
    /// offset: 0xec
    AHB2SECSR: mmio.Mmio(packed struct(u32) {
        /// GPIOASECF
        GPIOASECF: u1,
        /// GPIOBSECF
        GPIOBSECF: u1,
        /// GPIOCSECF
        GPIOCSECF: u1,
        /// GPIODSECF
        GPIODSECF: u1,
        /// GPIOESECF
        GPIOESECF: u1,
        /// GPIOFSECF
        GPIOFSECF: u1,
        /// GPIOGSECF
        GPIOGSECF: u1,
        /// GPIOHSECF
        GPIOHSECF: u1,
        reserved9: u1 = 0,
        /// SRAM2SECF
        SRAM2SECF: u1,
        reserved21: u11 = 0,
        /// OTFDEC1SECF
        OTFDEC1SECF: u1,
        /// SDMMC1SECF
        SDMMC1SECF: u1,
        padding: u9 = 0,
    }),
    /// RCC AHB3 security status register
    /// offset: 0xf0
    AHB3SECSR: mmio.Mmio(packed struct(u32) {
        /// FSMCSECF
        FSMCSECF: u1,
        reserved8: u7 = 0,
        /// OCTOSPI1SECF
        OCTOSPI1SECF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0xf4
    reserved244: [4]u8,
    /// RCC APB1 security status register 1
    /// offset: 0xf8
    APB1SECSR1: mmio.Mmio(packed struct(u32) {
        /// TIM2SECF
        TIM2SECF: u1,
        /// TIM3SECF
        TIM3SECF: u1,
        /// TIM4SECF
        TIM4SECF: u1,
        /// TIM5SECF
        TIM5SECF: u1,
        /// TIM6SECF
        TIM6SECF: u1,
        /// TIM7SECF
        TIM7SECF: u1,
        reserved10: u4 = 0,
        /// RTCAPBSECF
        RTCAPBSECF: u1,
        /// WWDGSECF
        WWDGSECF: u1,
        reserved14: u2 = 0,
        /// SPI2SECF
        SPI2SECF: u1,
        /// SPI3SECF
        SPI3SECF: u1,
        reserved17: u1 = 0,
        /// UART2SECF
        UART2SECF: u1,
        /// UART3SECF
        UART3SECF: u1,
        /// UART4SECF
        UART4SECF: u1,
        /// UART5SECF
        UART5SECF: u1,
        /// I2C1SECF
        I2C1SECF: u1,
        /// I2C2SECF
        I2C2SECF: u1,
        /// I2C3SECF
        I2C3SECF: u1,
        /// CRSSECF
        CRSSECF: u1,
        reserved28: u3 = 0,
        /// PWRSECF
        PWRSECF: u1,
        /// DACSECF
        DACSECF: u1,
        /// OPAMPSECF
        OPAMPSECF: u1,
        /// LPTIM1SECF
        LPTIM1SECF: u1,
    }),
    /// RCC APB1 security status register 2
    /// offset: 0xfc
    APB1SECSR2: mmio.Mmio(packed struct(u32) {
        /// LPUART1SECF
        LPUART1SECF: u1,
        /// I2C4SECF
        I2C4SECF: u1,
        reserved5: u3 = 0,
        /// LPTIM2SECF
        LPTIM2SECF: u1,
        /// LPTIM3SECF
        LPTIM3SECF: u1,
        reserved9: u2 = 0,
        /// FDCAN1SECF
        FDCAN1SECF: u1,
        reserved21: u11 = 0,
        /// USBSECF
        USBSECF: u1,
        reserved23: u1 = 0,
        /// UCPD1SECF
        UCPD1SECF: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 security status register
    /// offset: 0x100
    APB2SECSR: mmio.Mmio(packed struct(u32) {
        /// SYSCFGSECF
        SYSCFGSECF: u1,
        reserved11: u10 = 0,
        /// TIM1SECF
        TIM1SECF: u1,
        /// SPI1SECF
        SPI1SECF: u1,
        /// TIM8SECF
        TIM8SECF: u1,
        /// USART1SECF
        USART1SECF: u1,
        reserved16: u1 = 0,
        /// TIM15SECF
        TIM15SECF: u1,
        /// TIM16SECF
        TIM16SECF: u1,
        /// TIM17SECF
        TIM17SECF: u1,
        reserved21: u2 = 0,
        /// SAI1SECF
        SAI1SECF: u1,
        /// SAI2SECF
        SAI2SECF: u1,
        reserved24: u1 = 0,
        /// DFSDM1SECF
        DFSDM1SECF: u1,
        padding: u7 = 0,
    }),
};
