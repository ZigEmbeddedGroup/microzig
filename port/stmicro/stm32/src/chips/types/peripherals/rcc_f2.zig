const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

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

pub const ISSRC = enum(u1) {
    /// PLLI2S clock used as I2S clock source
    PLLI2S = 0x0,
    /// External clock mapped on the I2S_CKIN pin used as I2S clock source
    CKIN = 0x1,
};

pub const MCO1SEL = enum(u2) {
    /// HSI clock selected
    HSI = 0x0,
    /// LSE oscillator selected
    LSE = 0x1,
    /// HSE oscillator clock selected
    HSE = 0x2,
    /// PLL clock selected
    PLL = 0x3,
};

pub const MCO2SEL = enum(u2) {
    /// System clock (SYSCLK) selected
    SYS = 0x0,
    /// PLLI2S clock selected
    PLLI2S = 0x1,
    /// HSE oscillator clock selected
    HSE = 0x2,
    /// PLL clock selected
    PLL = 0x3,
};

pub const MCOPRE = enum(u3) {
    /// No division
    Div1 = 0x0,
    /// Division by 2
    Div2 = 0x4,
    /// Division by 3
    Div3 = 0x5,
    /// Division by 4
    Div4 = 0x6,
    /// Division by 5
    Div5 = 0x7,
    _,
};

pub const PLLM = enum(u6) {
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
    Div32 = 0x20,
    Div33 = 0x21,
    Div34 = 0x22,
    Div35 = 0x23,
    Div36 = 0x24,
    Div37 = 0x25,
    Div38 = 0x26,
    Div39 = 0x27,
    Div40 = 0x28,
    Div41 = 0x29,
    Div42 = 0x2a,
    Div43 = 0x2b,
    Div44 = 0x2c,
    Div45 = 0x2d,
    Div46 = 0x2e,
    Div47 = 0x2f,
    Div48 = 0x30,
    Div49 = 0x31,
    Div50 = 0x32,
    Div51 = 0x33,
    Div52 = 0x34,
    Div53 = 0x35,
    Div54 = 0x36,
    Div55 = 0x37,
    Div56 = 0x38,
    Div57 = 0x39,
    Div58 = 0x3a,
    Div59 = 0x3b,
    Div60 = 0x3c,
    Div61 = 0x3d,
    Div62 = 0x3e,
    Div63 = 0x3f,
    _,
};

pub const PLLN = enum(u9) {
    Mul192 = 0xc0,
    Mul193 = 0xc1,
    Mul194 = 0xc2,
    Mul195 = 0xc3,
    Mul196 = 0xc4,
    Mul197 = 0xc5,
    Mul198 = 0xc6,
    Mul199 = 0xc7,
    Mul200 = 0xc8,
    Mul201 = 0xc9,
    Mul202 = 0xca,
    Mul203 = 0xcb,
    Mul204 = 0xcc,
    Mul205 = 0xcd,
    Mul206 = 0xce,
    Mul207 = 0xcf,
    Mul208 = 0xd0,
    Mul209 = 0xd1,
    Mul210 = 0xd2,
    Mul211 = 0xd3,
    Mul212 = 0xd4,
    Mul213 = 0xd5,
    Mul214 = 0xd6,
    Mul215 = 0xd7,
    Mul216 = 0xd8,
    Mul217 = 0xd9,
    Mul218 = 0xda,
    Mul219 = 0xdb,
    Mul220 = 0xdc,
    Mul221 = 0xdd,
    Mul222 = 0xde,
    Mul223 = 0xdf,
    Mul224 = 0xe0,
    Mul225 = 0xe1,
    Mul226 = 0xe2,
    Mul227 = 0xe3,
    Mul228 = 0xe4,
    Mul229 = 0xe5,
    Mul230 = 0xe6,
    Mul231 = 0xe7,
    Mul232 = 0xe8,
    Mul233 = 0xe9,
    Mul234 = 0xea,
    Mul235 = 0xeb,
    Mul236 = 0xec,
    Mul237 = 0xed,
    Mul238 = 0xee,
    Mul239 = 0xef,
    Mul240 = 0xf0,
    Mul241 = 0xf1,
    Mul242 = 0xf2,
    Mul243 = 0xf3,
    Mul244 = 0xf4,
    Mul245 = 0xf5,
    Mul246 = 0xf6,
    Mul247 = 0xf7,
    Mul248 = 0xf8,
    Mul249 = 0xf9,
    Mul250 = 0xfa,
    Mul251 = 0xfb,
    Mul252 = 0xfc,
    Mul253 = 0xfd,
    Mul254 = 0xfe,
    Mul255 = 0xff,
    Mul256 = 0x100,
    Mul257 = 0x101,
    Mul258 = 0x102,
    Mul259 = 0x103,
    Mul260 = 0x104,
    Mul261 = 0x105,
    Mul262 = 0x106,
    Mul263 = 0x107,
    Mul264 = 0x108,
    Mul265 = 0x109,
    Mul266 = 0x10a,
    Mul267 = 0x10b,
    Mul268 = 0x10c,
    Mul269 = 0x10d,
    Mul270 = 0x10e,
    Mul271 = 0x10f,
    Mul272 = 0x110,
    Mul273 = 0x111,
    Mul274 = 0x112,
    Mul275 = 0x113,
    Mul276 = 0x114,
    Mul277 = 0x115,
    Mul278 = 0x116,
    Mul279 = 0x117,
    Mul280 = 0x118,
    Mul281 = 0x119,
    Mul282 = 0x11a,
    Mul283 = 0x11b,
    Mul284 = 0x11c,
    Mul285 = 0x11d,
    Mul286 = 0x11e,
    Mul287 = 0x11f,
    Mul288 = 0x120,
    Mul289 = 0x121,
    Mul290 = 0x122,
    Mul291 = 0x123,
    Mul292 = 0x124,
    Mul293 = 0x125,
    Mul294 = 0x126,
    Mul295 = 0x127,
    Mul296 = 0x128,
    Mul297 = 0x129,
    Mul298 = 0x12a,
    Mul299 = 0x12b,
    Mul300 = 0x12c,
    Mul301 = 0x12d,
    Mul302 = 0x12e,
    Mul303 = 0x12f,
    Mul304 = 0x130,
    Mul305 = 0x131,
    Mul306 = 0x132,
    Mul307 = 0x133,
    Mul308 = 0x134,
    Mul309 = 0x135,
    Mul310 = 0x136,
    Mul311 = 0x137,
    Mul312 = 0x138,
    Mul313 = 0x139,
    Mul314 = 0x13a,
    Mul315 = 0x13b,
    Mul316 = 0x13c,
    Mul317 = 0x13d,
    Mul318 = 0x13e,
    Mul319 = 0x13f,
    Mul320 = 0x140,
    Mul321 = 0x141,
    Mul322 = 0x142,
    Mul323 = 0x143,
    Mul324 = 0x144,
    Mul325 = 0x145,
    Mul326 = 0x146,
    Mul327 = 0x147,
    Mul328 = 0x148,
    Mul329 = 0x149,
    Mul330 = 0x14a,
    Mul331 = 0x14b,
    Mul332 = 0x14c,
    Mul333 = 0x14d,
    Mul334 = 0x14e,
    Mul335 = 0x14f,
    Mul336 = 0x150,
    Mul337 = 0x151,
    Mul338 = 0x152,
    Mul339 = 0x153,
    Mul340 = 0x154,
    Mul341 = 0x155,
    Mul342 = 0x156,
    Mul343 = 0x157,
    Mul344 = 0x158,
    Mul345 = 0x159,
    Mul346 = 0x15a,
    Mul347 = 0x15b,
    Mul348 = 0x15c,
    Mul349 = 0x15d,
    Mul350 = 0x15e,
    Mul351 = 0x15f,
    Mul352 = 0x160,
    Mul353 = 0x161,
    Mul354 = 0x162,
    Mul355 = 0x163,
    Mul356 = 0x164,
    Mul357 = 0x165,
    Mul358 = 0x166,
    Mul359 = 0x167,
    Mul360 = 0x168,
    Mul361 = 0x169,
    Mul362 = 0x16a,
    Mul363 = 0x16b,
    Mul364 = 0x16c,
    Mul365 = 0x16d,
    Mul366 = 0x16e,
    Mul367 = 0x16f,
    Mul368 = 0x170,
    Mul369 = 0x171,
    Mul370 = 0x172,
    Mul371 = 0x173,
    Mul372 = 0x174,
    Mul373 = 0x175,
    Mul374 = 0x176,
    Mul375 = 0x177,
    Mul376 = 0x178,
    Mul377 = 0x179,
    Mul378 = 0x17a,
    Mul379 = 0x17b,
    Mul380 = 0x17c,
    Mul381 = 0x17d,
    Mul382 = 0x17e,
    Mul383 = 0x17f,
    Mul384 = 0x180,
    Mul385 = 0x181,
    Mul386 = 0x182,
    Mul387 = 0x183,
    Mul388 = 0x184,
    Mul389 = 0x185,
    Mul390 = 0x186,
    Mul391 = 0x187,
    Mul392 = 0x188,
    Mul393 = 0x189,
    Mul394 = 0x18a,
    Mul395 = 0x18b,
    Mul396 = 0x18c,
    Mul397 = 0x18d,
    Mul398 = 0x18e,
    Mul399 = 0x18f,
    Mul400 = 0x190,
    Mul401 = 0x191,
    Mul402 = 0x192,
    Mul403 = 0x193,
    Mul404 = 0x194,
    Mul405 = 0x195,
    Mul406 = 0x196,
    Mul407 = 0x197,
    Mul408 = 0x198,
    Mul409 = 0x199,
    Mul410 = 0x19a,
    Mul411 = 0x19b,
    Mul412 = 0x19c,
    Mul413 = 0x19d,
    Mul414 = 0x19e,
    Mul415 = 0x19f,
    Mul416 = 0x1a0,
    Mul417 = 0x1a1,
    Mul418 = 0x1a2,
    Mul419 = 0x1a3,
    Mul420 = 0x1a4,
    Mul421 = 0x1a5,
    Mul422 = 0x1a6,
    Mul423 = 0x1a7,
    Mul424 = 0x1a8,
    Mul425 = 0x1a9,
    Mul426 = 0x1aa,
    Mul427 = 0x1ab,
    Mul428 = 0x1ac,
    Mul429 = 0x1ad,
    Mul430 = 0x1ae,
    Mul431 = 0x1af,
    Mul432 = 0x1b0,
    _,
};

pub const PLLP = enum(u2) {
    /// PLLP=2
    Div2 = 0x0,
    /// PLLP=4
    Div4 = 0x1,
    /// PLLP=6
    Div6 = 0x2,
    /// PLLP=8
    Div8 = 0x3,
};

pub const PLLQ = enum(u4) {
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
    _,
};

pub const PLLR = enum(u3) {
    Div2 = 0x2,
    Div3 = 0x3,
    Div4 = 0x4,
    Div5 = 0x5,
    Div6 = 0x6,
    Div7 = 0x7,
    _,
};

pub const PLLSRC = enum(u1) {
    /// HSI clock selected as PLL and PLLI2S clock entry
    HSI = 0x0,
    /// HSE oscillator clock selected as PLL and PLLI2S clock entry
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

pub const SPREADSEL = enum(u1) {
    /// Center spread
    Center = 0x0,
    /// Down spread
    Down = 0x1,
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
    /// clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Internal high-speed clock enable
        HSION: u1,
        /// Internal high-speed clock ready flag
        HSIRDY: u1,
        reserved3: u1 = 0,
        /// Internal high-speed clock trimming
        HSITRIM: u5,
        /// Internal high-speed clock calibration
        HSICAL: u8,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE clock bypass
        HSEBYP: u1,
        /// Clock security system enable
        CSSON: u1,
        reserved24: u4 = 0,
        /// Main PLL (PLL) enable
        PLLON: u1,
        /// Main PLL (PLL) clock ready flag
        PLLRDY: u1,
        /// PLLI2S enable
        PLLI2SON: u1,
        /// PLLI2S clock ready flag
        PLLI2SRDY: u1,
        padding: u4 = 0,
    }),
    /// PLL configuration register
    /// offset: 0x04
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
        PLLM: PLLM,
        /// Main PLL (PLL) multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// Main PLL (PLL) division factor for main system clock
        PLLP: PLLP,
        reserved22: u4 = 0,
        /// Main PLL(PLL) and audio PLL (PLLI2S) entry clock source
        PLLSRC: PLLSRC,
        reserved24: u1 = 0,
        /// Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
        PLLQ: PLLQ,
        padding: u4 = 0,
    }),
    /// clock configuration register
    /// offset: 0x08
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch
        SW: SW,
        /// System clock switch status
        SWS: SW,
        /// AHB prescaler
        HPRE: HPRE,
        reserved10: u2 = 0,
        /// APB Low speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        /// HSE division factor for RTC clock
        RTCPRE: u5,
        /// Microcontroller clock output 1
        MCO1SEL: MCO1SEL,
        /// I2S clock selection
        I2SSRC: ISSRC,
        /// MCO1 prescaler
        MCO1PRE: MCOPRE,
        /// MCO2 prescaler
        MCO2PRE: MCOPRE,
        /// Microcontroller clock output 2
        MCO2SEL: MCO2SEL,
    }),
    /// clock interrupt register
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
        /// Main PLL (PLL) ready interrupt flag
        PLLRDYF: u1,
        /// PLLI2S ready interrupt flag
        PLLI2SRDYF: u1,
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
        /// Main PLL (PLL) ready interrupt enable
        PLLRDYIE: u1,
        /// PLLI2S ready interrupt enable
        PLLI2SRDYIE: u1,
        reserved16: u2 = 0,
        /// LSI ready interrupt clear
        LSIRDYC: u1,
        /// LSE ready interrupt clear
        LSERDYC: u1,
        /// HSI ready interrupt clear
        HSIRDYC: u1,
        /// HSE ready interrupt clear
        HSERDYC: u1,
        /// Main PLL(PLL) ready interrupt clear
        PLLRDYC: u1,
        /// PLLI2S ready interrupt clear
        PLLI2SRDYC: u1,
        reserved23: u1 = 0,
        /// Clock security system interrupt clear
        CSSC: u1,
        padding: u8 = 0,
    }),
    /// AHB1 peripheral reset register
    /// offset: 0x10
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
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
        /// IO port I reset
        GPIOIRST: u1,
        reserved12: u3 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved21: u8 = 0,
        /// DMA2 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        reserved25: u2 = 0,
        /// Ethernet MAC reset
        ETHRST: u1,
        reserved29: u3 = 0,
        /// USB OTG HS module reset
        USB_OTG_HSRST: u1,
        padding: u2 = 0,
    }),
    /// AHB2 peripheral reset register
    /// offset: 0x14
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
        /// Camera interface reset
        DCMIRST: u1,
        reserved4: u3 = 0,
        /// Cryptographic module reset
        CRYPRST: u1,
        /// Hash module reset
        HSAHRST: u1,
        /// Random number generator module reset
        RNGRST: u1,
        /// USB OTG FS module reset
        USB_OTG_FSRST: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral reset register
    /// offset: 0x18
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// Flexible static memory controller module reset
        FSMCRST: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// APB1 peripheral reset register
    /// offset: 0x20
    APB1RSTR: mmio.Mmio(packed struct(u32) {
        /// TIM2 reset
        TIM2RST: u1,
        /// TIM3 reset
        TIM3RST: u1,
        /// TIM4 reset
        TIM4RST: u1,
        /// TIM5 reset
        TIM5RST: u1,
        /// TIM6 reset
        TIM6RST: u1,
        /// TIM7 reset
        TIM7RST: u1,
        /// TIM12 reset
        TIM12RST: u1,
        /// TIM13 reset
        TIM13RST: u1,
        /// TIM14 reset
        TIM14RST: u1,
        reserved11: u2 = 0,
        /// Window watchdog reset
        WWDGRST: u1,
        reserved14: u2 = 0,
        /// SPI 2 reset
        SPI2RST: u1,
        /// SPI 3 reset
        SPI3RST: u1,
        reserved17: u1 = 0,
        /// USART 2 reset
        UART2RST: u1,
        /// USART 3 reset
        UART3RST: u1,
        /// USART 4 reset
        UART4RST: u1,
        /// USART 5 reset
        UART5RST: u1,
        /// I2C 1 reset
        I2C1RST: u1,
        /// I2C 2 reset
        I2C2RST: u1,
        /// I2C3 reset
        I2C3RST: u1,
        reserved25: u1 = 0,
        /// CAN1 reset
        CAN1RST: u1,
        /// CAN2 reset
        CAN2RST: u1,
        reserved28: u1 = 0,
        /// Power interface reset
        PWRRST: u1,
        /// DAC reset
        DACRST: u1,
        padding: u2 = 0,
    }),
    /// APB2 peripheral reset register
    /// offset: 0x24
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// TIM1 reset
        TIM1RST: u1,
        /// TIM8 reset
        TIM8RST: u1,
        reserved4: u2 = 0,
        /// USART1 reset
        USART1RST: u1,
        /// USART6 reset
        USART6RST: u1,
        reserved8: u2 = 0,
        /// ADC interface reset (common to all ADCs)
        ADCRST: u1,
        reserved11: u2 = 0,
        /// SDIO reset
        SDIORST: u1,
        /// SPI 1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// System configuration controller reset
        SYSCFGRST: u1,
        reserved16: u1 = 0,
        /// TIM9 reset
        TIM9RST: u1,
        /// TIM10 reset
        TIM10RST: u1,
        /// TIM11 reset
        TIM11RST: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x28
    reserved40: [8]u8,
    /// AHB1 peripheral clock register
    /// offset: 0x30
    AHB1ENR: mmio.Mmio(packed struct(u32) {
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
        /// IO port I clock enable
        GPIOIEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved18: u5 = 0,
        /// Backup SRAM interface clock enable
        BKPSRAMEN: u1,
        reserved21: u2 = 0,
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        reserved25: u2 = 0,
        /// Ethernet MAC clock enable
        ETHEN: u1,
        /// Ethernet Transmission clock enable
        ETHTXEN: u1,
        /// Ethernet Reception clock enable
        ETHRXEN: u1,
        /// Ethernet PTP clock enable
        ETHPTPEN: u1,
        /// USB OTG HS clock enable
        USB_OTG_HSEN: u1,
        /// USB OTG HSULPI clock enable
        USB_OTG_HSULPIEN: u1,
        padding: u1 = 0,
    }),
    /// AHB2 peripheral clock enable register
    /// offset: 0x34
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// Camera interface enable
        DCMIEN: u1,
        reserved4: u3 = 0,
        /// Cryptographic modules clock enable
        CRYPEN: u1,
        /// Hash modules clock enable
        HASHEN: u1,
        /// Random number generator clock enable
        RNGEN: u1,
        /// USB OTG FS clock enable
        USB_OTG_FSEN: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral clock enable register
    /// offset: 0x38
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// Flexible static memory controller module clock enable
        FSMCEN: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x3c
    reserved60: [4]u8,
    /// APB1 peripheral clock enable register
    /// offset: 0x40
    APB1ENR: mmio.Mmio(packed struct(u32) {
        /// TIM2 clock enable
        TIM2EN: u1,
        /// TIM3 clock enable
        TIM3EN: u1,
        /// TIM4 clock enable
        TIM4EN: u1,
        /// TIM5 clock enable
        TIM5EN: u1,
        /// TIM6 clock enable
        TIM6EN: u1,
        /// TIM7 clock enable
        TIM7EN: u1,
        /// TIM12 clock enable
        TIM12EN: u1,
        /// TIM13 clock enable
        TIM13EN: u1,
        /// TIM14 clock enable
        TIM14EN: u1,
        reserved11: u2 = 0,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable
        SPI2EN: u1,
        /// SPI3 clock enable
        SPI3EN: u1,
        reserved17: u1 = 0,
        /// USART 2 clock enable
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
        reserved25: u1 = 0,
        /// CAN 1 clock enable
        CAN1EN: u1,
        /// CAN 2 clock enable
        CAN2EN: u1,
        reserved28: u1 = 0,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        padding: u2 = 0,
    }),
    /// APB2 peripheral clock enable register
    /// offset: 0x44
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 clock enable
        TIM1EN: u1,
        /// TIM8 clock enable
        TIM8EN: u1,
        reserved4: u2 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        /// USART6 clock enable
        USART6EN: u1,
        reserved8: u2 = 0,
        /// ADC1 clock enable
        ADC1EN: u1,
        /// ADC2 clock enable
        ADC2EN: u1,
        /// ADC3 clock enable
        ADC3EN: u1,
        /// SDIO clock enable
        SDIOEN: u1,
        /// SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// System configuration controller clock enable
        SYSCFGEN: u1,
        reserved16: u1 = 0,
        /// TIM9 clock enable
        TIM9EN: u1,
        /// TIM10 clock enable
        TIM10EN: u1,
        /// TIM11 clock enable
        TIM11EN: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x48
    reserved72: [8]u8,
    /// AHB1 peripheral clock enable in low power mode register
    /// offset: 0x50
    AHB1LPENR: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable during sleep mode
        GPIOALPEN: u1,
        /// IO port B clock enable during Sleep mode
        GPIOBLPEN: u1,
        /// IO port C clock enable during Sleep mode
        GPIOCLPEN: u1,
        /// IO port D clock enable during Sleep mode
        GPIODLPEN: u1,
        /// IO port E clock enable during Sleep mode
        GPIOELPEN: u1,
        /// IO port F clock enable during Sleep mode
        GPIOFLPEN: u1,
        /// IO port G clock enable during Sleep mode
        GPIOGLPEN: u1,
        /// IO port H clock enable during Sleep mode
        GPIOHLPEN: u1,
        /// IO port I clock enable during Sleep mode
        GPIOILPEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable during Sleep mode
        CRCLPEN: u1,
        reserved15: u2 = 0,
        /// Flash interface clock enable during Sleep mode
        FLASHLPEN: u1,
        /// SRAM 1interface clock enable during Sleep mode
        SRAM1LPEN: u1,
        /// SRAM 2 interface clock enable during Sleep mode
        SRAM2LPEN: u1,
        /// Backup SRAM interface clock enable during Sleep mode
        BKPSRAMLPEN: u1,
        reserved21: u2 = 0,
        /// DMA1 clock enable during Sleep mode
        DMA1LPEN: u1,
        /// DMA2 clock enable during Sleep mode
        DMA2LPEN: u1,
        reserved25: u2 = 0,
        /// Ethernet MAC clock enable during Sleep mode
        ETHLPEN: u1,
        /// Ethernet transmission clock enable during Sleep mode
        ETHTXLPEN: u1,
        /// Ethernet reception clock enable during Sleep mode
        ETHRXLPEN: u1,
        /// Ethernet PTP clock enable during Sleep mode
        ETHPTPLPEN: u1,
        /// USB OTG HS clock enable during Sleep mode
        USB_OTG_HSLPEN: u1,
        /// USB OTG HS ULPI clock enable during Sleep mode
        USB_OTG_HSULPILPEN: u1,
        padding: u1 = 0,
    }),
    /// AHB2 peripheral clock enable in low power mode register
    /// offset: 0x54
    AHB2LPENR: mmio.Mmio(packed struct(u32) {
        /// Camera interface enable during Sleep mode
        DCMILPEN: u1,
        reserved4: u3 = 0,
        /// Cryptography modules clock enable during Sleep mode
        CRYPLPEN: u1,
        /// Hash modules clock enable during Sleep mode
        HASHLPEN: u1,
        /// Random number generator clock enable during Sleep mode
        RNGLPEN: u1,
        /// USB OTG FS clock enable during Sleep mode
        USB_OTG_FSLPEN: u1,
        padding: u24 = 0,
    }),
    /// AHB3 peripheral clock enable in low power mode register
    /// offset: 0x58
    AHB3LPENR: mmio.Mmio(packed struct(u32) {
        /// Flexible static memory controller module clock enable during Sleep mode
        FSMCLPEN: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// APB1 peripheral clock enable in low power mode register
    /// offset: 0x60
    APB1LPENR: mmio.Mmio(packed struct(u32) {
        /// TIM2 clock enable during Sleep mode
        TIM2LPEN: u1,
        /// TIM3 clock enable during Sleep mode
        TIM3LPEN: u1,
        /// TIM4 clock enable during Sleep mode
        TIM4LPEN: u1,
        /// TIM5 clock enable during Sleep mode
        TIM5LPEN: u1,
        /// TIM6 clock enable during Sleep mode
        TIM6LPEN: u1,
        /// TIM7 clock enable during Sleep mode
        TIM7LPEN: u1,
        /// TIM12 clock enable during Sleep mode
        TIM12LPEN: u1,
        /// TIM13 clock enable during Sleep mode
        TIM13LPEN: u1,
        /// TIM14 clock enable during Sleep mode
        TIM14LPEN: u1,
        reserved11: u2 = 0,
        /// Window watchdog clock enable during Sleep mode
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during Sleep mode
        SPI2LPEN: u1,
        /// SPI3 clock enable during Sleep mode
        SPI3LPEN: u1,
        reserved17: u1 = 0,
        /// USART2 clock enable during Sleep mode
        USART2LPEN: u1,
        /// USART3 clock enable during Sleep mode
        USART3LPEN: u1,
        /// UART4 clock enable during Sleep mode
        UART4LPEN: u1,
        /// UART5 clock enable during Sleep mode
        UART5LPEN: u1,
        /// I2C1 clock enable during Sleep mode
        I2C1LPEN: u1,
        /// I2C2 clock enable during Sleep mode
        I2C2LPEN: u1,
        /// I2C3 clock enable during Sleep mode
        I2C3LPEN: u1,
        reserved25: u1 = 0,
        /// CAN 1 clock enable during Sleep mode
        CAN1LPEN: u1,
        /// CAN 2 clock enable during Sleep mode
        CAN2LPEN: u1,
        reserved28: u1 = 0,
        /// Power interface clock enable during Sleep mode
        PWRLPEN: u1,
        /// DAC interface clock enable during Sleep mode
        DACLPEN: u1,
        padding: u2 = 0,
    }),
    /// APB2 peripheral clock enabled in low power mode register
    /// offset: 0x64
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 clock enable during Sleep mode
        TIM1LPEN: u1,
        /// TIM8 clock enable during Sleep mode
        TIM8LPEN: u1,
        reserved4: u2 = 0,
        /// USART1 clock enable during Sleep mode
        USART1LPEN: u1,
        /// USART6 clock enable during Sleep mode
        USART6LPEN: u1,
        reserved8: u2 = 0,
        /// ADC1 clock enable during Sleep mode
        ADC1LPEN: u1,
        /// ADC2 clock enable during Sleep mode
        ADC2LPEN: u1,
        /// ADC 3 clock enable during Sleep mode
        ADC3LPEN: u1,
        /// SDIO clock enable during Sleep mode
        SDIOLPEN: u1,
        /// SPI 1 clock enable during Sleep mode
        SPI1LPEN: u1,
        reserved14: u1 = 0,
        /// System configuration controller clock enable during Sleep mode
        SYSCFGLPEN: u1,
        reserved16: u1 = 0,
        /// TIM9 clock enable during sleep mode
        TIM9LPEN: u1,
        /// TIM10 clock enable during Sleep mode
        TIM10LPEN: u1,
        /// TIM11 clock enable during Sleep mode
        TIM11LPEN: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x68
    reserved104: [8]u8,
    /// Backup domain control register
    /// offset: 0x70
    BDCR: mmio.Mmio(packed struct(u32) {
        /// External low-speed oscillator enable
        LSEON: u1,
        /// External low-speed oscillator ready
        LSERDY: u1,
        /// External low-speed oscillator bypass
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
    /// clock control & status register
    /// offset: 0x74
    CSR: mmio.Mmio(packed struct(u32) {
        /// Internal low-speed oscillator enable
        LSION: u1,
        /// Internal low-speed oscillator ready
        LSIRDY: u1,
        reserved24: u22 = 0,
        /// Remove reset flag
        RMVF: u1,
        /// BOR reset flag
        BORRSTF: u1,
        /// PIN reset flag
        PADRSTF: u1,
        /// POR/PDR reset flag
        PORRSTF: u1,
        /// Software reset flag
        SFTRSTF: u1,
        /// Independent watchdog reset flag
        WDGRSTF: u1,
        /// Window watchdog reset flag
        WWDGRSTF: u1,
        /// Low-power reset flag
        LPWRRSTF: u1,
    }),
    /// offset: 0x78
    reserved120: [8]u8,
    /// spread spectrum clock generation register
    /// offset: 0x80
    SSCGR: mmio.Mmio(packed struct(u32) {
        /// Modulation period
        MODPER: u13,
        /// Incrementation step
        INCSTEP: u15,
        reserved30: u2 = 0,
        /// Spread Select
        SPREADSEL: SPREADSEL,
        /// Spread spectrum modulation enable
        SSCGEN: u1,
    }),
    /// PLLI2S configuration register
    /// offset: 0x84
    PLLI2SCFGR: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// PLLI2S multiplication factor for VCO
        PLLN: PLLN,
        reserved28: u13 = 0,
        /// PLLI2S division factor for I2S clocks
        PLLR: PLLR,
        padding: u1 = 0,
    }),
};
