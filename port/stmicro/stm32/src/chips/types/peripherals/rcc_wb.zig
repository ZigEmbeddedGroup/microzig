const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    /// No clock selected
    DISABLE = 0x0,
    PLLSAI1_R = 0x1,
    PLL1_P = 0x2,
    /// SYSCLK clock selected
    SYS = 0x3,
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

pub const HPRE = enum(u4) {
    /// DCLK not divided
    Div1 = 0x0,
    /// hclk = SYSCLK divided by 3
    Div3 = 0x1,
    /// hclk = SYSCLK divided by 5
    Div5 = 0x2,
    /// hclk = SYSCLK divided by 6
    Div6 = 0x5,
    /// hclk = SYSCLK divided by 8
    Div10 = 0x6,
    /// hclk = SYSCLK divided by 32
    Div32 = 0x7,
    /// hclk = SYSCLK divided by 2
    Div2 = 0x8,
    /// hclk = SYSCLK divided by 4
    Div4 = 0x9,
    /// hclk = SYSCLK divided by 8
    Div8 = 0xa,
    /// hclk = SYSCLK divided by 16
    Div16 = 0xb,
    /// hclk = SYSCLK divided by 64
    Div64 = 0xc,
    /// hclk = SYSCLK divided by 128
    Div128 = 0xd,
    /// hclk = SYSCLK divided by 256
    Div256 = 0xe,
    /// hclk = SYSCLK divided by 256
    Div512 = 0xf,
    _,
};

pub const HSEPRE = enum(u1) {
    Div1 = 0x0,
    Div2 = 0x1,
};

pub const I2C1SEL = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    _,
};

pub const I2C3SEL = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    _,
};

pub const LPTIM1SEL = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// LSI clock selected
    LSI = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    /// LSE clock selected
    LSE = 0x3,
};

pub const LPTIM2SEL = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// LSI clock selected
    LSI = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    /// LSE clock selected
    LSE = 0x3,
};

pub const LPUART1SEL = enum(u2) {
    /// PCLK clock selected
    PCLK1 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    HSE = 0x3,
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
    /// MSI oscillator clock selected
    MSI = 0x2,
    /// HSI oscillator clock selected
    HSI = 0x3,
    /// HSE clock selected (after stabilization, after HSERDY = 1)
    HSE = 0x4,
    /// PLL clock selected
    PLL_R = 0x5,
    /// LSI1 oscillator clock selected
    LSI1 = 0x6,
    /// LSI2 oscillator clock selected
    LSI2 = 0x7,
    /// LSE oscillator clock selected
    LSE = 0x8,
    /// HSI48 oscillator clock selected
    HSI48 = 0x9,
    /// HSE clock selected (before stabilization, after HSEON = 1)
    HSE_UNSTABLE = 0xc,
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
    Mul6 = 0x6,
    Mul7 = 0x7,
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
    _,
};

pub const PLLQ = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    _,
};

pub const PLLR = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    _,
};

pub const PLLSRC = enum(u2) {
    /// No clock selected as PLL entry clock source
    DISABLE = 0x0,
    /// MSI selected as PLL entry clock source
    MSI = 0x1,
    /// HSI selected as PLL entry clock source
    HSI = 0x2,
    /// HSE selected as PLL entry clock source
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

pub const RNGSEL = enum(u2) {
    /// CLK48
    CLK48 = 0x0,
    /// LSI clock selected
    LSI = 0x1,
    /// LSE clock selected
    LSE = 0x2,
    _,
};

pub const RTCSEL = enum(u2) {
    /// No clock selected
    DISABLE = 0x0,
    /// LSE oscillator clock selected
    LSE = 0x1,
    /// LSI oscillator clock selected
    LSI = 0x2,
    /// HSE oscillator clock divided by 32 selected
    HSE = 0x3,
};

pub const SAI1SEL = enum(u2) {
    PLLSAI1_P = 0x0,
    PLL1_P = 0x1,
    HSI = 0x2,
    SAI1_EXTCLK = 0x3,
};

pub const SW = enum(u2) {
    MSI = 0x0,
    HSI = 0x1,
    HSE = 0x2,
    PLL1_R = 0x3,
};

pub const USART1SEL = enum(u2) {
    /// PCLK clock selected
    PCLK2 = 0x0,
    /// SYSCLK clock selected
    SYS = 0x1,
    /// HSI clock selected
    HSI = 0x2,
    HSE = 0x3,
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
        reserved4: u1 = 0,
        /// MSI clock ranges
        MSIRANGE: MSIRANGE,
        /// HSI clock enabled
        HSION: u1,
        /// HSI always enable for peripheral kernels
        HSIKERON: u1,
        /// HSI clock ready flag
        HSIRDY: u1,
        /// HSI automatic start from Stop
        HSIASFS: u1,
        /// HSI kernel clock ready flag for peripherals requests
        HSIKERDY: u1,
        reserved16: u3 = 0,
        /// HSE clock enabled
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE crystal oscillator bypass
        HSEBYP: u1,
        /// HSE Clock security system enable
        CSSON: u1,
        /// HSE sysclk and PLL M divider prescaler
        HSEPRE: HSEPRE,
        reserved24: u3 = 0,
        /// Main PLL enable
        PLLON: u1,
        /// Main PLL clock ready flag
        PLLRDY: u1,
        /// SAI1 PLL enable
        PLLSAI1ON: u1,
        /// SAI1 PLL clock ready flag
        PLLSAI1RDY: u1,
        padding: u4 = 0,
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
        /// PB low-speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        reserved15: u1 = 0,
        /// Wakeup from Stop and CSS backup clock selection
        STOPWUCK: u1,
        /// AHB prescaler flag
        HPREF: u1,
        /// APB1 prescaler flag
        PPRE1F: u1,
        /// APB2 prescaler flag
        PPRE2F: u1,
        reserved24: u5 = 0,
        /// Microcontroller clock output
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// PLLSYS configuration register
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// Main PLL, PLLSAI1 and PLLSAI2 entry clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor M for the main PLL and audio PLL (PLLSAI1 and PLLSAI2) input clock
        PLLM: PLLM,
        reserved8: u1 = 0,
        /// Main PLLSYS multiplication factor N
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// Main PLLSYSP output enable
        PLLPEN: u1,
        /// Main PLL division factor P for PPLSYSSAICLK
        PLLP: PLLP,
        reserved24: u2 = 0,
        /// Main PLLSYSQ output enable
        PLLQEN: u1,
        /// Main PLLSYS division factor Q for PLLSYSUSBCLK
        PLLQ: PLLQ,
        /// Main PLLSYSR PLLCLK output enable
        PLLREN: u1,
        /// Main PLLSYS division factor R for SYSCLK (system clock)
        PLLR: PLLR,
    }),
    /// PLLSAI1 configuration register
    /// offset: 0x10
    PLLSAI1CFGR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// SAIPLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// SAIPLL PLLSAI1CLK output enable
        PLLPEN: u1,
        /// SAI1PLL division factor P for PLLSAICLK (SAI1clock)
        PLLP: PLLP,
        reserved24: u2 = 0,
        /// SAIPLL PLLSAIUSBCLK output enable
        PLLQEN: u1,
        /// SAIPLL division factor Q for PLLSAIUSBCLK (48 MHz clock)
        PLLQ: PLLQ,
        /// PLLSAI PLLADC1CLK output enable
        PLLREN: u1,
        /// PLLSAI division factor R for PLLADC1CLK (ADC clock)
        PLLR: PLLR,
    }),
    /// offset: 0x14
    reserved20: [4]u8,
    /// Clock interrupt enable register
    /// offset: 0x18
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt enable
        LSI1RDYIE: u1,
        /// LSE ready interrupt enable
        LSERDYIE: u1,
        /// MSI ready interrupt enable
        MSIRDYIE: u1,
        /// HSI ready interrupt enable
        HSIRDYIE: u1,
        /// HSE ready interrupt enable
        HSERDYIE: u1,
        /// PLLSYS ready interrupt enable
        PLLRDYIE: u1,
        /// PLLSAI1 ready interrupt enable
        PLLSAI1RDYIE: u1,
        reserved9: u2 = 0,
        /// LSE clock security system interrupt enable
        LSECSSIE: u1,
        /// HSI48 ready interrupt enable
        HSI48RDYIE: u1,
        /// LSI2 ready interrupt enable
        LSI2RDYIE: u1,
        padding: u20 = 0,
    }),
    /// Clock interrupt flag register
    /// offset: 0x1c
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt flag
        LSI1RDYF: u1,
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
        reserved8: u1 = 0,
        /// HSE Clock security system interrupt flag
        HSECSSF: u1,
        /// LSE Clock security system interrupt flag
        LSECSSF: u1,
        /// HSI48 ready interrupt flag
        HSI48RDYF: u1,
        /// LSI2 ready interrupt flag
        LSI2RDYF: u1,
        padding: u20 = 0,
    }),
    /// Clock interrupt clear register
    /// offset: 0x20
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt clear
        LSI1RDYC: u1,
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
        reserved8: u1 = 0,
        /// HSE Clock security system interrupt clear
        HSECSSC: u1,
        /// LSE Clock security system interrupt clear
        LSECSSC: u1,
        /// HSI48 ready interrupt clear
        HSI48RDYC: u1,
        /// LSI2 ready interrupt clear
        LSI2RDYC: u1,
        padding: u20 = 0,
    }),
    /// Step Down converter control register
    /// offset: 0x24
    SMPSCR: mmio.Mmio(packed struct(u32) {
        /// Step Down converter clock selection
        SMPSSEL: u2,
        reserved4: u2 = 0,
        /// Step Down converter clock prescaler
        SMPSDIV: u2,
        reserved8: u2 = 0,
        /// Step Down converter clock switch status
        SMPSSWS: u2,
        padding: u22 = 0,
    }),
    /// AHB1 peripheral reset register
    /// offset: 0x28
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        /// DMAMUX reset
        DMAMUX1RST: u1,
        reserved12: u9 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved16: u3 = 0,
        /// Touch Sensing Controller reset
        TSCRST: u1,
        padding: u15 = 0,
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
        reserved7: u2 = 0,
        /// IO port H reset
        GPIOHRST: u1,
        reserved13: u5 = 0,
        /// ADC reset
        ADCRST: u1,
        reserved16: u2 = 0,
        /// AES1 hardware accelerator reset
        AES1RST: u1,
        padding: u15 = 0,
    }),
    /// AHB3 peripheral reset register
    /// offset: 0x30
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// Quad SPI memory interface reset
        QUADSPIRST: u1,
        reserved16: u7 = 0,
        /// PKA interface reset
        PKARST: u1,
        /// AES2 interface reset
        AES2RST: u1,
        /// RNG interface reset
        RNGRST: u1,
        /// HSEM interface reset
        HSEMRST: u1,
        /// IPCC interface reset
        IPCCRST: u1,
        reserved25: u4 = 0,
        /// Flash interface reset
        FLASHRST: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x34
    reserved52: [4]u8,
    /// APB1 peripheral reset register 1
    /// offset: 0x38
    APB1RSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer reset
        TIM2RST: u1,
        reserved9: u8 = 0,
        /// LCD interface reset
        LCDRST: u1,
        reserved14: u4 = 0,
        /// SPI2 reset
        SPI2RST: u1,
        reserved21: u6 = 0,
        /// I2C1 reset
        I2C1RST: u1,
        reserved23: u1 = 0,
        /// I2C3 reset
        I2C3RST: u1,
        /// CRS reset
        CRSRST: u1,
        reserved26: u1 = 0,
        /// USB FS reset
        USBRST: u1,
        reserved31: u4 = 0,
        /// Low Power Timer 1 reset
        LPTIM1RST: u1,
    }),
    /// APB1 peripheral reset register 2
    /// offset: 0x3c
    APB1RSTR2: mmio.Mmio(packed struct(u32) {
        /// Low-power UART 1 reset
        LPUART1RST: u1,
        reserved5: u4 = 0,
        /// Low-power timer 2 reset
        LPTIM2RST: u1,
        padding: u26 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x40
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 timer reset
        TIM1RST: u1,
        /// SPI1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset
        USART1RST: u1,
        reserved17: u2 = 0,
        /// TIM16 timer reset
        TIM16RST: u1,
        /// TIM17 timer reset
        TIM17RST: u1,
        reserved21: u2 = 0,
        /// Serial audio interface 1 (SAI1) reset
        SAI1RST: u1,
        padding: u10 = 0,
    }),
    /// APB3 peripheral reset register
    /// offset: 0x44
    APB3RSTR: mmio.Mmio(packed struct(u32) {
        /// Radio system BLE reset
        RFRST: u1,
        padding: u31 = 0,
    }),
    /// AHB1 peripheral clock enable register
    /// offset: 0x48
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        /// DMAMUX clock enable
        DMAMUX1EN: u1,
        reserved12: u9 = 0,
        /// CPU1 CRC clock enable
        CRCEN: u1,
        reserved16: u3 = 0,
        /// Touch Sensing Controller clock enable
        TSCEN: u1,
        padding: u15 = 0,
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
        reserved7: u2 = 0,
        /// IO port H clock enable
        GPIOHEN: u1,
        reserved13: u5 = 0,
        /// ADC clock enable
        ADCEN: u1,
        reserved16: u2 = 0,
        /// AES1 accelerator clock enable
        AES1EN: u1,
        padding: u15 = 0,
    }),
    /// AHB3 peripheral clock enable register
    /// offset: 0x50
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// QUADSPIEN
        QUADSPIEN: u1,
        reserved16: u7 = 0,
        /// PKAEN
        PKAEN: u1,
        /// AES2EN
        AES2EN: u1,
        /// RNGEN
        RNGEN: u1,
        /// HSEMEN
        HSEMEN: u1,
        /// IPCCEN
        IPCCEN: u1,
        reserved25: u4 = 0,
        /// FLASHEN
        FLASHEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x54
    reserved84: [4]u8,
    /// APB1ENR1
    /// offset: 0x58
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// CPU1 TIM2 timer clock enable
        TIM2EN: u1,
        reserved9: u8 = 0,
        /// CPU1 LCD clock enable
        LCDEN: u1,
        /// CPU1 RTC APB clock enable
        RTCAPBEN: u1,
        /// CPU1 Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// CPU1 SPI2 clock enable
        SPI2EN: u1,
        reserved21: u6 = 0,
        /// CPU1 I2C1 clock enable
        I2C1EN: u1,
        reserved23: u1 = 0,
        /// CPU1 I2C3 clock enable
        I2C3EN: u1,
        /// CPU1 CRS clock enable
        CRSEN: u1,
        reserved26: u1 = 0,
        /// CPU1 USB clock enable
        USBEN: u1,
        reserved31: u4 = 0,
        /// CPU1 Low power timer 1 clock enable
        LPTIM1EN: u1,
    }),
    /// APB1 peripheral clock enable register 2
    /// offset: 0x5c
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        /// CPU1 Low power UART 1 clock enable
        LPUART1EN: u1,
        reserved5: u4 = 0,
        /// CPU1 LPTIM2EN
        LPTIM2EN: u1,
        padding: u26 = 0,
    }),
    /// APB2ENR
    /// offset: 0x60
    APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// CPU1 TIM1 timer clock enable
        TIM1EN: u1,
        /// CPU1 SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// CPU1 USART1clock enable
        USART1EN: u1,
        reserved17: u2 = 0,
        /// CPU1 TIM16 timer clock enable
        TIM16EN: u1,
        /// CPU1 TIM17 timer clock enable
        TIM17EN: u1,
        reserved21: u2 = 0,
        /// CPU1 SAI1 clock enable
        SAI1EN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0x64
    reserved100: [4]u8,
    /// AHB1 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x68
    AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// CPU1 DMA1 clocks enable during Sleep and Stop modes
        DMA1SMEN: u1,
        /// CPU1 DMA2 clocks enable during Sleep and Stop modes
        DMA2SMEN: u1,
        /// CPU1 DMAMUX clocks enable during Sleep and Stop modes
        DMAMUX1SMEN: u1,
        reserved9: u6 = 0,
        /// CPU1 SRAM1 interface clocks enable during Sleep and Stop modes
        SRAM1SMEN: u1,
        reserved12: u2 = 0,
        /// CPU1 CRCSMEN
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// CPU1 Touch Sensing Controller clocks enable during Sleep and Stop modes
        TSCSMEN: u1,
        padding: u15 = 0,
    }),
    /// AHB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x6c
    AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// CPU1 IO port A clocks enable during Sleep and Stop modes
        GPIOASMEN: u1,
        /// CPU1 IO port B clocks enable during Sleep and Stop modes
        GPIOBSMEN: u1,
        /// CPU1 IO port C clocks enable during Sleep and Stop modes
        GPIOCSMEN: u1,
        /// CPU1 IO port D clocks enable during Sleep and Stop modes
        GPIODSMEN: u1,
        /// CPU1 IO port E clocks enable during Sleep and Stop modes
        GPIOESMEN: u1,
        reserved7: u2 = 0,
        /// CPU1 IO port H clocks enable during Sleep and Stop modes
        GPIOHSMEN: u1,
        reserved13: u5 = 0,
        /// CPU1 ADC clocks enable during Sleep and Stop modes
        ADCFSSMEN: u1,
        reserved16: u2 = 0,
        /// CPU1 AES1 accelerator clocks enable during Sleep and Stop modes
        AES1SMEN: u1,
        padding: u15 = 0,
    }),
    /// AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x70
    AHB3SMENR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// QUADSPISMEN
        QUADSPISMEN: u1,
        reserved16: u7 = 0,
        /// PKA accelerator clocks enable during CPU1 sleep mode
        PKASMEN: u1,
        /// AES2 accelerator clocks enable during CPU1 sleep mode
        AES2SMEN: u1,
        /// True RNG clocks enable during CPU1 sleep mode
        RNGSMEN: u1,
        reserved24: u5 = 0,
        /// SRAM2a and SRAM2b memory interface clocks enable during CPU1 sleep mode
        SRAM2SMEN: u1,
        /// Flash interface clocks enable during CPU1 sleep mode
        FLASHSMEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x74
    reserved116: [4]u8,
    /// APB1SMENR1
    /// offset: 0x78
    APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clocks enable during CPU1 Sleep mode
        TIM2SMEN: u1,
        reserved9: u8 = 0,
        /// LCD clocks enable during CPU1 Sleep mode
        LCDSMEN: u1,
        /// RTC APB clocks enable during CPU1 Sleep mode
        RTCAPBSMEN: u1,
        /// Window watchdog clocks enable during CPU1 Sleep mode
        WWDGSMEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clocks enable during CPU1 Sleep mode
        SPI2SMEN: u1,
        reserved21: u6 = 0,
        /// I2C1 clocks enable during CPU1 Sleep mode
        I2C1SMEN: u1,
        reserved23: u1 = 0,
        /// I2C3 clocks enable during CPU1 Sleep mode
        I2C3SMEN: u1,
        /// CRS clocks enable during CPU1 Sleep mode
        CRSMEN: u1,
        reserved26: u1 = 0,
        /// USB FS clocks enable during CPU1 Sleep mode
        USBSMEN: u1,
        reserved31: u4 = 0,
        /// Low power timer 1 clocks enable during CPU1 Sleep mode
        LPTIM1SMEN: u1,
    }),
    /// APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0x7c
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clocks enable during CPU1 Sleep mode
        LPUART1SMEN: u1,
        reserved5: u4 = 0,
        /// Low power timer 2 clocks enable during CPU1 Sleep mode
        LPTIM2SMEN: u1,
        padding: u26 = 0,
    }),
    /// APB2SMENR
    /// offset: 0x80
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 timer clocks enable during CPU1 Sleep mode
        TIM1SMEN: u1,
        /// SPI1 clocks enable during CPU1 Sleep mode
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1clocks enable during CPU1 Sleep mode
        USART1SMEN: u1,
        reserved17: u2 = 0,
        /// TIM16 timer clocks enable during CPU1 Sleep mode
        TIM16SMEN: u1,
        /// TIM17 timer clocks enable during CPU1 Sleep mode
        TIM17SMEN: u1,
        reserved21: u2 = 0,
        /// SAI1 clocks enable during CPU1 Sleep mode
        SAI1SMEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// CCIPR
    /// offset: 0x88
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection
        USART1SEL: USART1SEL,
        reserved10: u8 = 0,
        /// LPUART1 clock source selection
        LPUART1SEL: LPUART1SEL,
        /// I2C1 clock source selection
        I2C1SEL: I2C1SEL,
        reserved16: u2 = 0,
        /// I2C3 clock source selection
        I2C3SEL: I2C3SEL,
        /// Low power timer 1 clock source selection
        LPTIM1SEL: LPTIM1SEL,
        /// Low power timer 2 clock source selection
        LPTIM2SEL: LPTIM2SEL,
        /// SAI1 clock source selection
        SAI1SEL: SAI1SEL,
        reserved26: u2 = 0,
        /// 48 MHz clock source selection
        CLK48SEL: CLK48SEL,
        /// ADCs clock source selection
        ADCSEL: ADCSEL,
        /// RNG clock source selection
        RNGSEL: RNGSEL,
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
        /// CSS on LSE failure detection
        LSECSSD_: u1,
        reserved8: u1 = 0,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// Backup domain software reset
        BDRST: u1,
        reserved24: u7 = 0,
        /// Low speed clock output enable
        LSCOEN: u1,
        /// Low speed clock output selection
        LSCOSEL: u2,
        padding: u5 = 0,
    }),
    /// CSR
    /// offset: 0x94
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI1 oscillator enabled
        LSI1ON: u1,
        /// LSI1 oscillator ready
        LSI1RDY: u1,
        /// LSI2 oscillator enabled
        LSI2ON: u1,
        /// LSI2 oscillator ready
        LSI2RDY: u1,
        /// LSI2 oscillator trimming enable
        LSI2TRIMEN: u1,
        /// LSI2 oscillator trim OK
        LSI2TRIMOK: u1,
        reserved8: u2 = 0,
        /// LSI2 oscillator bias configuration
        LSI2BW: u4,
        reserved14: u2 = 0,
        /// RF system wakeup clock source selection
        RFWKPSEL: u2,
        /// Radio system BLE and 802.15.4 reset status
        RFRSTS: u1,
        reserved23: u6 = 0,
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
        /// HSI48 oscillator enabled
        HSI48ON: u1,
        /// HSI48 clock ready
        HSI48RDY: u1,
        reserved7: u5 = 0,
        /// HSI48 clock calibration
        HSI48CAL: u9,
        padding: u16 = 0,
    }),
    /// Clock HSE register
    /// offset: 0x9c
    HSECR: mmio.Mmio(packed struct(u32) {
        /// Register lock system
        UNLOCKED: u1,
        reserved3: u2 = 0,
        /// HSE Sense amplifier threshold
        HSES: u1,
        /// HSE current control
        HSEGMC: u3,
        reserved8: u1 = 0,
        /// HSE capacitor tuning
        HSETUNE: u6,
        padding: u18 = 0,
    }),
    /// offset: 0xa0
    reserved160: [104]u8,
    /// Extended clock recovery register
    /// offset: 0x108
    EXTCFGR: mmio.Mmio(packed struct(u32) {
        /// Shared AHB prescaler
        SHDHPRE: HPRE,
        /// CPU2 AHB prescaler
        C2HPRE: HPRE,
        reserved16: u8 = 0,
        /// Shared AHB prescaler flag
        SHDHPREF: u1,
        /// CPU2 AHB prescaler flag
        C2HPREF: u1,
        reserved20: u2 = 0,
        /// RF clock source selected
        RFCSS: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x10c
    reserved268: [60]u8,
    /// CPU2 AHB1 peripheral clock enable register
    /// offset: 0x148
    C2AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 DMA1 clock enable
        DMA1EN: u1,
        /// CPU2 DMA2 clock enable
        DMA2EN: u1,
        /// CPU2 DMAMUX clock enable
        DMAMUX1EN: u1,
        reserved9: u6 = 0,
        /// CPU2 SRAM1 clock enable
        SRAM1EN: u1,
        reserved12: u2 = 0,
        /// CPU2 CRC clock enable
        CRCEN: u1,
        reserved16: u3 = 0,
        /// CPU2 Touch Sensing Controller clock enable
        TSCEN: u1,
        padding: u15 = 0,
    }),
    /// CPU2 AHB2 peripheral clock enable register
    /// offset: 0x14c
    C2AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 IO port A clock enable
        GPIOAEN: u1,
        /// CPU2 IO port B clock enable
        GPIOBEN: u1,
        /// CPU2 IO port C clock enable
        GPIOCEN: u1,
        /// CPU2 IO port D clock enable
        GPIODEN: u1,
        /// CPU2 IO port E clock enable
        GPIOEEN: u1,
        reserved7: u2 = 0,
        /// CPU2 IO port H clock enable
        GPIOHEN: u1,
        reserved13: u5 = 0,
        /// CPU2 ADC clock enable
        ADCEN: u1,
        reserved16: u2 = 0,
        /// CPU2 AES1 accelerator clock enable
        AES1EN: u1,
        padding: u15 = 0,
    }),
    /// CPU2 AHB3 peripheral clock enable register
    /// offset: 0x150
    C2AHB3ENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// CPU2 PKAEN
        PKAEN: u1,
        /// CPU2 AES2EN
        AES2EN: u1,
        /// CPU2 RNGEN
        RNGEN: u1,
        /// CPU2 HSEMEN
        HSEMEN: u1,
        /// CPU2 IPCCEN
        IPCCEN: u1,
        reserved25: u4 = 0,
        /// CPU2 FLASHEN
        FLASHEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x154
    reserved340: [4]u8,
    /// CPU2 APB1ENR1
    /// offset: 0x158
    C2APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// CPU2 TIM2 timer clock enable
        TIM2EN: u1,
        reserved9: u8 = 0,
        /// CPU2 LCD clock enable
        LCDEN: u1,
        /// CPU2 RTC APB clock enable
        RTCAPBEN: u1,
        reserved14: u3 = 0,
        /// CPU2 SPI2 clock enable
        SPI2EN: u1,
        reserved21: u6 = 0,
        /// CPU2 I2C1 clock enable
        I2C1EN: u1,
        reserved23: u1 = 0,
        /// CPU2 I2C3 clock enable
        I2C3EN: u1,
        /// CPU2 CRS clock enable
        CRSEN: u1,
        reserved26: u1 = 0,
        /// CPU2 USB clock enable
        USBEN: u1,
        reserved31: u4 = 0,
        /// CPU2 Low power timer 1 clock enable
        LPTIM1EN: u1,
    }),
    /// CPU2 APB1 peripheral clock enable register 2
    /// offset: 0x15c
    C2APB1ENR2: mmio.Mmio(packed struct(u32) {
        /// CPU2 Low power UART 1 clock enable
        LPUART1EN: u1,
        reserved5: u4 = 0,
        /// CPU2 LPTIM2EN
        LPTIM2EN: u1,
        padding: u26 = 0,
    }),
    /// CPU2 APB2ENR
    /// offset: 0x160
    C2APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// CPU2 TIM1 timer clock enable
        TIM1EN: u1,
        /// CPU2 SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// CPU2 USART1clock enable
        USART1EN: u1,
        reserved17: u2 = 0,
        /// CPU2 TIM16 timer clock enable
        TIM16EN: u1,
        /// CPU2 TIM17 timer clock enable
        TIM17EN: u1,
        reserved21: u2 = 0,
        /// CPU2 SAI1 clock enable
        SAI1EN: u1,
        padding: u10 = 0,
    }),
    /// CPU2 APB3ENR
    /// offset: 0x164
    C2APB3ENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 BLE interface clock enable
        BLEEN: u1,
        /// CPU2 802.15.4 interface clock enable
        EN802: u1,
        padding: u30 = 0,
    }),
    /// CPU2 AHB1 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x168
    C2AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 DMA1 clocks enable during Sleep and Stop modes
        DMA1SMEN: u1,
        /// CPU2 DMA2 clocks enable during Sleep and Stop modes
        DMA2SMEN: u1,
        /// CPU2 DMAMUX clocks enable during Sleep and Stop modes
        DMAMUX1SMEN: u1,
        reserved9: u6 = 0,
        /// SRAM1 interface clock enable during CPU1 CSleep mode
        SRAM1SMEN: u1,
        reserved12: u2 = 0,
        /// CPU2 CRCSMEN
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// CPU2 Touch Sensing Controller clocks enable during Sleep and Stop modes
        TSCSMEN: u1,
        padding: u15 = 0,
    }),
    /// CPU2 AHB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x16c
    C2AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 IO port A clocks enable during Sleep and Stop modes
        GPIOASMEN: u1,
        /// CPU2 IO port B clocks enable during Sleep and Stop modes
        GPIOBSMEN: u1,
        /// CPU2 IO port C clocks enable during Sleep and Stop modes
        GPIOCSMEN: u1,
        /// CPU2 IO port D clocks enable during Sleep and Stop modes
        GPIODSMEN: u1,
        /// CPU2 IO port E clocks enable during Sleep and Stop modes
        GPIOESMEN: u1,
        reserved7: u2 = 0,
        /// CPU2 IO port H clocks enable during Sleep and Stop modes
        GPIOHSMEN: u1,
        reserved13: u5 = 0,
        /// CPU2 ADC clocks enable during Sleep and Stop modes
        ADCFSSMEN: u1,
        reserved16: u2 = 0,
        /// CPU2 AES1 accelerator clocks enable during Sleep and Stop modes
        AES1SMEN: u1,
        padding: u15 = 0,
    }),
    /// CPU2 AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x170
    C2AHB3SMENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// PKA accelerator clocks enable during CPU2 sleep modes
        PKASMEN: u1,
        /// AES2 accelerator clocks enable during CPU2 sleep modes
        AES2SMEN: u1,
        /// True RNG clocks enable during CPU2 sleep modes
        RNGSMEN: u1,
        reserved24: u5 = 0,
        /// SRAM2a and SRAM2b memory interface clocks enable during CPU2 sleep modes
        SRAM2SMEN: u1,
        /// Flash interface clocks enable during CPU2 sleep modes
        FLASHSMEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x174
    reserved372: [4]u8,
    /// CPU2 APB1SMENR1
    /// offset: 0x178
    C2APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clocks enable during CPU2 Sleep mode
        TIM2SMEN: u1,
        reserved9: u8 = 0,
        /// LCD clocks enable during CPU2 Sleep mode
        LCDSMEN: u1,
        /// RTC APB clocks enable during CPU2 Sleep mode
        RTCAPBSMEN: u1,
        reserved14: u3 = 0,
        /// SPI2 clocks enable during CPU2 Sleep mode
        SPI2SMEN: u1,
        reserved21: u6 = 0,
        /// I2C1 clocks enable during CPU2 Sleep mode
        I2C1SMEN: u1,
        reserved23: u1 = 0,
        /// I2C3 clocks enable during CPU2 Sleep mode
        I2C3SMEN: u1,
        /// CRS clocks enable during CPU2 Sleep mode
        CRSMEN: u1,
        reserved26: u1 = 0,
        /// USB FS clocks enable during CPU2 Sleep mode
        USBSMEN: u1,
        reserved31: u4 = 0,
        /// Low power timer 1 clocks enable during CPU2 Sleep mode
        LPTIM1SMEN: u1,
    }),
    /// CPU2 APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0x17c
    C2APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clocks enable during CPU2 Sleep mode
        LPUART1SMEN: u1,
        reserved5: u4 = 0,
        /// Low power timer 2 clocks enable during CPU2 Sleep mode
        LPTIM2SMEN: u1,
        padding: u26 = 0,
    }),
    /// CPU2 APB2SMENR
    /// offset: 0x180
    C2APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 timer clocks enable during CPU2 Sleep mode
        TIM1SMEN: u1,
        /// SPI1 clocks enable during CPU2 Sleep mode
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1clocks enable during CPU2 Sleep mode
        USART1SMEN: u1,
        reserved17: u2 = 0,
        /// TIM16 timer clocks enable during CPU2 Sleep mode
        TIM16SMEN: u1,
        /// TIM17 timer clocks enable during CPU2 Sleep mode
        TIM17SMEN: u1,
        reserved21: u2 = 0,
        /// SAI1 clocks enable during CPU2 Sleep mode
        SAI1SMEN: u1,
        padding: u10 = 0,
    }),
    /// CPU2 APB3SMENR
    /// offset: 0x184
    C2APB3SMENR: mmio.Mmio(packed struct(u32) {
        /// BLE interface clocks enable during CPU2 Sleep mode
        BLESMEN: u1,
        /// 802.15.4 interface clocks enable during CPU2 Sleep modes
        SMEN802: u1,
        padding: u30 = 0,
    }),
};
