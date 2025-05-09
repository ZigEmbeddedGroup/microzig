const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCSEL = enum(u2) {
    /// HSI used as ADC clock source
    HSI = 0x1,
    /// PLLPCLK used as ADC clock source
    PLL1_P = 0x2,
    /// SYSCLK used as ADC clock source
    SYS = 0x3,
    _,
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
    /// HSE oscillator clock selected
    HSE = 0x4,
    /// Main PLLRCLK clock selected
    PLL1_R = 0x5,
    /// LSI oscillator clock selected
    LSI = 0x6,
    /// LSE oscillator clock selected
    LSE = 0x8,
    /// Main PLLCLK oscillator clock selected
    PLL1_P = 0xd,
    /// Main PLLQCLK oscillator clock selected
    PLL1_Q = 0xe,
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
    PLL1_Q = 0x0,
    LSI = 0x1,
    LSE = 0x2,
    MSI = 0x3,
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

pub const SW = enum(u2) {
    MSI = 0x0,
    HSI = 0x1,
    HSE = 0x2,
    PLL1_R = 0x3,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// Clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// MSI clock enable
        MSION: u1,
        /// MSI clock ready flag (After reset this bit will be read 1 once the MSI is ready)
        MSIRDY: u1,
        /// MSI clock PLL enable
        MSIPLLEN: u1,
        /// MSI range control selection
        MSIRGSEL: MSIRGSEL,
        /// MSI clock ranges
        MSIRANGE: MSIRANGE,
        /// HSI clock enable
        HSION: u1,
        /// HSI always enable for peripheral kernel clocks.
        HSIKERON: u1,
        /// HSI clock ready flag. (After wakeup from Stop this bit will be read 1 once the HSI is ready)
        HSIRDY: u1,
        /// HSI automatic start from Stop
        HSIASFS: u1,
        /// HSI kernel clock ready flag for peripherals requests.
        HSIKERDY: u1,
        reserved16: u3 = 0,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        reserved19: u1 = 0,
        /// HSE Clock security system enable
        CSSON: u1,
        /// HSE sysclk prescaler
        HSEPRE: HSEPRE,
        /// Enable HSE VDDTCXO output on package pin PB0-VDDTCXO.
        HSEBYPPWR: u1,
        reserved24: u2 = 0,
        /// Main PLL enable
        PLLON: u1,
        /// Main PLL clock ready flag
        PLLRDY: u1,
        padding: u6 = 0,
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
        /// HCLK1 prescaler (CPU1, AHB1, AHB2, and SRAM1.)
        HPRE: HPRE,
        /// PCLK1 low-speed prescaler (APB1)
        PPRE1: PPRE,
        /// PCLK2 high-speed prescaler (APB2)
        PPRE2: PPRE,
        reserved15: u1 = 0,
        /// Wakeup from Stop and CSS backup clock selection
        STOPWUCK: u1,
        /// HCLK1 prescaler flag (CPU1, AHB1, AHB2, and SRAM1)
        HPREF: u1,
        /// PCLK1 prescaler flag (APB1)
        PPRE1F: u1,
        /// PCLK2 prescaler flag (APB2)
        PPRE2F: u1,
        reserved24: u5 = 0,
        /// Microcontroller clock output
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// PLL configuration register
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// Main PLL entry clock source
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor for the main PLL input clock
        PLLM: PLLM,
        reserved8: u1 = 0,
        /// Main PLL multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// Main PLL PLLPCLK output enable
        PLLPEN: u1,
        /// Main PLL division factor for PLLPCLK.
        PLLP: PLLP,
        reserved24: u2 = 0,
        /// Main PLL PLLQCLK output enable
        PLLQEN: u1,
        /// Main PLL division factor for PLLQCLK
        PLLQ: PLLQ,
        /// Main PLL PLLRCLK output enable
        PLLREN: u1,
        /// Main PLL division factor for PLLRCLK
        PLLR: PLLR,
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
        /// MSI ready interrupt enable
        MSIRDYIE: u1,
        /// HSI ready interrupt enable
        HSIRDYIE: u1,
        /// HSE ready interrupt enable
        HSERDYIE: u1,
        /// PLL ready interrupt enable
        PLLRDYIE: u1,
        reserved9: u3 = 0,
        /// LSE clock security system interrupt enable
        LSECSSIE: u1,
        padding: u22 = 0,
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
        reserved8: u2 = 0,
        /// HSE Clock security system interrupt flag
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
        /// MSI ready interrupt clear
        MSIRDYC: u1,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// PLL ready interrupt clear
        PLLRDYC: u1,
        reserved8: u2 = 0,
        /// HSE Clock security system interrupt clear
        CSSC: u1,
        /// LSE Clock security system interrupt clear
        LSECSSC: u1,
        padding: u22 = 0,
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
        /// DMAMUX1 reset
        DMAMUX1RST: u1,
        reserved12: u9 = 0,
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
        reserved7: u4 = 0,
        /// IO port H reset
        GPIOHRST: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral reset register
    /// offset: 0x30
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// PKARST
        PKARST: u1,
        /// AESRST
        AESRST: u1,
        /// RNGRST
        RNGRST: u1,
        /// HSEMRST
        HSEMRST: u1,
        /// IPCCRST
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
        reserved14: u13 = 0,
        /// SPI2 reset
        SPI2RST: u1,
        reserved17: u2 = 0,
        /// USART2 reset
        USART2RST: u1,
        reserved21: u3 = 0,
        /// I2C1 reset
        I2C1RST: u1,
        /// I2C2 reset
        I2C2RST: u1,
        /// I2C3 reset
        I2C3RST: u1,
        reserved29: u5 = 0,
        /// DAC reset
        DACRST: u1,
        reserved31: u1 = 0,
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
        /// Low-power timer 3 reset
        LPTIM3RST: u1,
        padding: u25 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x40
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// ADC reset
        ADCRST: u1,
        reserved11: u1 = 0,
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
        padding: u13 = 0,
    }),
    /// APB3 peripheral reset register
    /// offset: 0x44
    APB3RSTR: mmio.Mmio(packed struct(u32) {
        /// Sub-GHz radio SPI reset
        SUBGHZSPIRST: u1,
        padding: u31 = 0,
    }),
    /// AHB1 peripheral clock enable register
    /// offset: 0x48
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// CPU1 DMA1 clock enable
        DMA1EN: u1,
        /// CPU1 DMA2 clock enable
        DMA2EN: u1,
        /// CPU1 DMAMUX1 clock enable
        DMAMUX1EN: u1,
        reserved12: u9 = 0,
        /// CPU1 CRC clock enable
        CRCEN: u1,
        padding: u19 = 0,
    }),
    /// AHB2 peripheral clock enable register
    /// offset: 0x4c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// CPU1 IO port A clock enable
        GPIOAEN: u1,
        /// CPU1 IO port B clock enable
        GPIOBEN: u1,
        /// CPU1 IO port C clock enable
        GPIOCEN: u1,
        reserved7: u4 = 0,
        /// CPU1 IO port H clock enable
        GPIOHEN: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral clock enable register
    /// offset: 0x50
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// PKAEN
        PKAEN: u1,
        /// AESEN
        AESEN: u1,
        /// RNGEN
        RNGEN: u1,
        /// HSEMEN
        HSEMEN: u1,
        /// IPCCEN
        IPCCEN: u1,
        reserved25: u4 = 0,
        /// CPU1 Flash interface clock enable
        FLASHEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x54
    reserved84: [4]u8,
    /// APB1 peripheral clock enable register 1
    /// offset: 0x58
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// CPU1 TIM2 timer clock enable
        TIM2EN: u1,
        reserved10: u9 = 0,
        /// CPU1 RTC APB clock enable
        RTCAPBEN: u1,
        /// CPU1 Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// CPU1 SPI2 clock enable
        SPI2EN: u1,
        reserved17: u2 = 0,
        /// CPU1 USART2 clock enable
        USART2EN: u1,
        reserved21: u3 = 0,
        /// CPU1 I2C1 clocks enable
        I2C1EN: u1,
        /// CPU1 I2C2 clocks enable
        I2C2EN: u1,
        /// CPU1 I2C3 clocks enable
        I2C3EN: u1,
        reserved29: u5 = 0,
        /// CPU1 DAC clock enable
        DACEN: u1,
        reserved31: u1 = 0,
        /// CPU1 Low power timer 1 clocks enable
        LPTIM1EN: u1,
    }),
    /// APB1 peripheral clock enable register 2
    /// offset: 0x5c
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        /// CPU1 Low power UART 1 clocks enable
        LPUART1EN: u1,
        reserved5: u4 = 0,
        /// CPU1 Low power timer 2 clocks enable
        LPTIM2EN: u1,
        /// CPU1 Low power timer 3 clocks enable
        LPTIM3EN: u1,
        padding: u25 = 0,
    }),
    /// APB2 peripheral clock enable register
    /// offset: 0x60
    APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// CPU1 ADC clocks enable
        ADCEN: u1,
        reserved11: u1 = 0,
        /// CPU1 TIM1 timer clock enable
        TIM1EN: u1,
        /// CPU1 SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// CPU1 USART1clocks enable
        USART1EN: u1,
        reserved17: u2 = 0,
        /// CPU1 TIM16 timer clock enable
        TIM16EN: u1,
        /// CPU1 TIM17 timer clock enable
        TIM17EN: u1,
        padding: u13 = 0,
    }),
    /// APB3 peripheral clock enable register
    /// offset: 0x64
    APB3ENR: mmio.Mmio(packed struct(u32) {
        /// sub-GHz radio SPI clock enable
        SUBGHZSPIEN: u1,
        padding: u31 = 0,
    }),
    /// AHB1 peripheral clocks enable in Sleep modes register
    /// offset: 0x68
    AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable during CPU1 CSleep mode.
        DMA1SMEN: u1,
        /// DMA2 clock enable during CPU1 CSleep mode
        DMA2SMEN: u1,
        /// DMAMUX1 clock enable during CPU1 CSleep mode.
        DMAMUX1SMEN: u1,
        reserved12: u9 = 0,
        /// CRC clock enable during CPU1 CSleep mode.
        CRCSMEN: u1,
        padding: u19 = 0,
    }),
    /// AHB2 peripheral clocks enable in Sleep modes register
    /// offset: 0x6c
    AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable during CPU1 CSleep mode.
        GPIOASMEN: u1,
        /// IO port B clock enable during CPU1 CSleep mode.
        GPIOBSMEN: u1,
        /// IO port C clock enable during CPU1 CSleep mode.
        GPIOCSMEN: u1,
        reserved7: u4 = 0,
        /// IO port H clock enable during CPU1 CSleep mode.
        GPIOHSMEN: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0x70
    AHB3SMENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// PKA accelerator clock enable during CPU1 CSleep mode.
        PKASMEN: u1,
        /// AES accelerator clock enable during CPU1 CSleep mode.
        AESSMEN: u1,
        /// True RNG clocks enable during CPU1 Csleep and CStop modes
        RNGSMEN: u1,
        reserved23: u4 = 0,
        /// SRAM1 interface clock enable during CPU1 CSleep mode.
        SRAM1SMEN: u1,
        /// SRAM2 memory interface clock enable during CPU1 CSleep mode
        SRAM2SMEN: u1,
        /// Flash interface clock enable during CPU1 CSleep mode.
        FLASHSMEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x74
    reserved116: [4]u8,
    /// APB1 peripheral clocks enable in Sleep mode register 1
    /// offset: 0x78
    APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable during CPU1 CSleep mode.
        TIM2SMEN: u1,
        reserved10: u9 = 0,
        /// RTC bus clock enable during CPU1 CSleep mode.
        RTCAPBSMEN: u1,
        /// Window watchdog clocks enable during CPU1 CSleep mode.
        WWDGSMEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during CPU1 CSleep mode.
        SPI2SMEN: u1,
        reserved17: u2 = 0,
        /// USART2 clock enable during CPU1 CSleep mode.
        USART2SMEN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable during CPU1 Csleep and CStop modes
        I2C1SMEN: u1,
        /// I2C2 clock enable during CPU1 Csleep and CStop modes
        I2C2SMEN: u1,
        /// I2C3 clock enable during CPU1 Csleep and CStop modes
        I2C3SMEN: u1,
        reserved29: u5 = 0,
        /// DAC clock enable during CPU1 CSleep mode.
        DACSMEN: u1,
        reserved31: u1 = 0,
        /// Low power timer 1 clock enable during CPU1 Csleep and CStop mode
        LPTIM1SMEN: u1,
    }),
    /// APB1 peripheral clocks enable in Sleep mode register 2
    /// offset: 0x7c
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clock enable during CPU1 Csleep and CStop modes.
        LPUART1SMEN: u1,
        reserved5: u4 = 0,
        /// Low power timer 2 clock enable during CPU1 Csleep and CStop modes
        LPTIM2SMEN: u1,
        /// Low power timer 3 clock enable during CPU1 Csleep and CStop modes
        LPTIM3SMEN: u1,
        padding: u25 = 0,
    }),
    /// APB2 peripheral clocks enable in Sleep mode register
    /// offset: 0x80
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// ADC clocks enable during CPU1 Csleep and CStop modes
        ADCSMEN: u1,
        reserved11: u1 = 0,
        /// TIM1 timer clock enable during CPU1 CSleep mode.
        TIM1SMEN: u1,
        /// SPI1 clock enable during CPU1 CSleep mode.
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during CPU1 Csleep and CStop modes.
        USART1SMEN: u1,
        reserved17: u2 = 0,
        /// TIM16 timer clock enable during CPU1 CSleep mode.
        TIM16SMEN: u1,
        /// TIM17 timer clock enable during CPU1 CSleep mode.
        TIM17SMEN: u1,
        padding: u13 = 0,
    }),
    /// APB3 peripheral clock enable in Sleep mode register
    /// offset: 0x84
    APB3SMENR: mmio.Mmio(packed struct(u32) {
        /// Sub-GHz radio SPI clock enable during Sleep and Stop modes
        SUBGHZSPISMEN: u1,
        padding: u31 = 0,
    }),
    /// Peripherals independent clock configuration register
    /// offset: 0x88
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection
        USART1SEL: u2,
        /// USART2 clock source selection
        USART2SEL: u2,
        reserved8: u4 = 0,
        /// SPI2 I2S clock source selection
        SPI2SEL: u2,
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
        /// Low power timer 3 clock source selection
        LPTIM3SEL: u2,
        reserved28: u4 = 0,
        /// ADC clock source selection
        ADCSEL: ADCSEL,
        /// RNG clock source selection
        RNGSEL: RNGSEL,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// Backup domain control register
    /// offset: 0x90
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
        /// LSE system clock enable
        LSESYSEN: u1,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved11: u1 = 0,
        /// LSE system clock ready
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
        LSCOSEL: u1,
        padding: u6 = 0,
    }),
    /// Control/status register
    /// offset: 0x94
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable
        LSION: u1,
        /// LSI oscillator ready
        LSIRDY: u1,
        reserved4: u2 = 0,
        /// LSI frequency prescaler
        LSIPRE: u1,
        reserved8: u3 = 0,
        /// MSI clock ranges
        MSISRANGE: u4,
        reserved14: u2 = 0,
        /// Radio in reset status flag
        RFRSTF: u1,
        /// Radio reset
        RFRST: u1,
        reserved23: u7 = 0,
        /// Remove reset flag
        RMVF: u1,
        /// Radio illegal access flag
        RFILARSTF: u1,
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
    /// offset: 0x98
    reserved152: [112]u8,
    /// Extended clock recovery register
    /// offset: 0x108
    EXTCFGR: mmio.Mmio(packed struct(u32) {
        /// HCLK3 shared prescaler (AHB3, Flash, and SRAM2)
        SHDHPRE: HPRE,
        /// [dual core device only] HCLK2 prescaler (CPU2)
        C2HPRE: HPRE,
        reserved16: u8 = 0,
        /// HCLK3 shared prescaler flag (AHB3, Flash, and SRAM2)
        SHDHPREF: u1,
        /// CLK2 prescaler flag (CPU2)
        C2HPREF: u1,
        padding: u14 = 0,
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
        /// CPU2 DMAMUX1 clock enable
        DMAMUX1EN: u1,
        reserved12: u9 = 0,
        /// CPU2 CRC clock enable
        CRCEN: u1,
        padding: u19 = 0,
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
        reserved7: u4 = 0,
        /// CPU2 IO port H clock enable
        GPIOHEN: u1,
        padding: u24 = 0,
    }),
    /// CPU2 AHB3 peripheral clock enable register [dual core device only]
    /// offset: 0x150
    C2AHB3ENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// CPU2 PKA accelerator clock enable
        PKAEN: u1,
        /// CPU2 AES accelerator clock enable
        AESEN: u1,
        /// CPU2 True RNG clocks enable
        RNGEN: u1,
        /// CPU2 HSEM clock enable
        HSEMEN: u1,
        /// CPU2 IPCC interface clock enable
        IPCCEN: u1,
        reserved25: u4 = 0,
        /// CPU2 Flash interface clock enable
        FLASHEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x154
    reserved340: [4]u8,
    /// CPU2 APB1 peripheral clock enable register 1 [dual core device only]
    /// offset: 0x158
    C2APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// CPU2 TIM2 timer clock enable
        TIM2EN: u1,
        reserved10: u9 = 0,
        /// CPU2 RTC APB clock enable
        RTCAPBEN: u1,
        reserved14: u3 = 0,
        /// CPU2 SPI2 clock enable
        SPI2EN: u1,
        reserved17: u2 = 0,
        /// CPU2 USART2 clock enable
        USART2EN: u1,
        reserved21: u3 = 0,
        /// CPU2 I2C1 clocks enable
        I2C1EN: u1,
        /// CPU2 I2C2 clocks enable
        I2C2EN: u1,
        /// CPU2 I2C3 clocks enable
        I2C3EN: u1,
        reserved29: u5 = 0,
        /// CPU2 DAC clock enable
        DACEN: u1,
        reserved31: u1 = 0,
        /// CPU2 Low power timer 1 clocks enable
        LPTIM1EN: u1,
    }),
    /// CPU2 APB1 peripheral clock enable register 2 [dual core device only]
    /// offset: 0x15c
    C2APB1ENR2: mmio.Mmio(packed struct(u32) {
        /// CPU2 Low power UART 1 clocks enable
        LPUART1EN: u1,
        reserved5: u4 = 0,
        /// CPU2 Low power timer 2 clocks enable
        LPTIM2EN: u1,
        /// CPU2 Low power timer 3 clocks enable
        LPTIM3EN: u1,
        padding: u25 = 0,
    }),
    /// CPU2 APB2 peripheral clock enable register [dual core device only]
    /// offset: 0x160
    C2APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// ADC clocks enable
        ADCEN: u1,
        reserved11: u1 = 0,
        /// CPU2 TIM1 timer clock enable
        TIM1EN: u1,
        /// CPU2 SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// CPU2 USART1clocks enable
        USART1EN: u1,
        reserved17: u2 = 0,
        /// CPU2 TIM16 timer clock enable
        TIM16EN: u1,
        /// CPU2 TIM17 timer clock enable
        TIM17EN: u1,
        padding: u13 = 0,
    }),
    /// CPU2 APB3 peripheral clock enable register [dual core device only]
    /// offset: 0x164
    C2APB3ENR: mmio.Mmio(packed struct(u32) {
        /// CPU2 sub-GHz radio SPI clock enable
        SUBGHZSPIEN: u1,
        padding: u31 = 0,
    }),
    /// CPU2 AHB1 peripheral clocks enable in Sleep modes register [dual core device only]
    /// offset: 0x168
    C2AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 clock enable during CPU2 CSleep mode.
        DMA1SMEN: u1,
        /// DMA2 clock enable during CPU2 CSleep mode.
        DMA2SMEN: u1,
        /// DMAMUX1 clock enable during CPU2 CSleep mode.
        DMAMUX1SMEN: u1,
        reserved12: u9 = 0,
        /// CRC clock enable during CPU2 CSleep mode.
        CRCSMEN: u1,
        padding: u19 = 0,
    }),
    /// CPU2 AHB2 peripheral clocks enable in Sleep modes register [dual core device only]
    /// offset: 0x16c
    C2AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable during CPU2 CSleep mode.
        GPIOASMEN: u1,
        /// IO port B clock enable during CPU2 CSleep mode.
        GPIOBSMEN: u1,
        /// IO port C clock enable during CPU2 CSleep mode.
        GPIOCSMEN: u1,
        reserved7: u4 = 0,
        /// IO port H clock enable during CPU2 CSleep mode.
        GPIOHSMEN: u1,
        padding: u24 = 0,
    }),
    /// CPU2 AHB3 peripheral clocks enable in Sleep mode register [dual core device only]
    /// offset: 0x170
    C2AHB3SMENR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// PKA accelerator clock enable during CPU2 CSleep mode.
        PKASMEN: u1,
        /// AES accelerator clock enable during CPU2 CSleep mode.
        AESSMEN: u1,
        /// True RNG clock enable during CPU2 CSleep and CStop mode.
        RNGSMEN: u1,
        reserved23: u4 = 0,
        /// SRAM1 interface clock enable during CPU2 CSleep mode.
        SRAM1SMEN: u1,
        /// SRAM2 memory interface clock enable during CPU2 CSleep mode.
        SRAM2SMEN: u1,
        /// Flash interface clock enable during CPU2 CSleep mode.
        FLASHSMEN: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x174
    reserved372: [4]u8,
    /// CPU2 APB1 peripheral clocks enable in Sleep mode register 1 [dual core device only]
    /// offset: 0x178
    C2APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable during CPU2 CSleep mode.
        TIM2SMEN: u1,
        reserved10: u9 = 0,
        /// RTC bus clock enable during CPU2 CSleep mode.
        RTCAPBSMEN: u1,
        reserved14: u3 = 0,
        /// SPI2 clock enable during CPU2 CSleep mode.
        SPI2SMEN: u1,
        reserved17: u2 = 0,
        /// USART2 clock enable during CPU2 CSleep mode.
        USART2SMEN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable during CPU2 CSleep and CStop modes
        I2C1SMEN: u1,
        /// I2C2 clock enable during CPU2 CSleep and CStop modes
        I2C2SMEN: u1,
        /// I2C3 clock enable during CPU2 CSleep and CStop modes
        I2C3SMEN: u1,
        reserved29: u5 = 0,
        /// DAC clock enable during CPU2 CSleep mode.
        DACSMEN: u1,
        reserved31: u1 = 0,
        /// Low power timer 1 clock enable during CPU2 CSleep and CStop mode
        LPTIM1SMEN: u1,
    }),
    /// CPU2 APB1 peripheral clocks enable in Sleep mode register 2 [dual core device only]
    /// offset: 0x17c
    C2APB1SMENR2: mmio.Mmio(packed struct(u32) {
        /// Low power UART 1 clock enable during CPU2 CSleep and CStop mode
        LPUART1SMEN: u1,
        reserved5: u4 = 0,
        /// Low power timer 2 clocks enable during CPU2 CSleep and CStop modes.
        LPTIM2SMEN: u1,
        /// Low power timer 3 clocks enable during CPU2 CSleep and CStop modes.
        LPTIM3SMEN: u1,
        padding: u25 = 0,
    }),
    /// CPU2 APB2 peripheral clocks enable in Sleep mode register [dual core device only]
    /// offset: 0x180
    C2APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved9: u9 = 0,
        /// ADC clocks enable during CPU2 Csleep and CStop modes
        ADCSMEN: u1,
        reserved11: u1 = 0,
        /// TIM1 timer clock enable during CPU2 CSleep mode
        TIM1SMEN: u1,
        /// SPI1 clock enable during CPU2 CSleep mode
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1clock enable during CPU2 CSleep and CStop mode
        USART1SMEN: u1,
        reserved17: u2 = 0,
        /// TIM16 timer clock enable during CPU2 CSleep mode
        TIM16SMEN: u1,
        /// TIM17 timer clock enable during CPU2 CSleep mode
        TIM17SMEN: u1,
        padding: u13 = 0,
    }),
    /// CPU2 APB3 peripheral clock enable in Sleep mode register [dual core device only]
    /// offset: 0x184
    C2APB3SMENR: mmio.Mmio(packed struct(u32) {
        /// sub-GHz radio SPI clock enable during CPU2 CSleep and CStop modes
        SUBGHZSPISMEN: u1,
        padding: u31 = 0,
    }),
};
