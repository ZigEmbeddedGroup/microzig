const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const FMPI2CSEL = enum(u2) {
    /// APB clock selected as I2C clock
    PCLK1 = 0x0,
    /// System clock selected as I2C clock
    SYS = 0x1,
    /// HSI clock selected as I2C clock
    HSI = 0x2,
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

pub const ISSRC = enum(u2) {
    /// I2Sx clock frequency = f(PLLCLK_R)
    PLLCLKR = 0x0,
    /// I2Sx clock frequency = I2S_CKIN Alternate function input frequency
    I2S_CKIN = 0x1,
    /// I2Sx clock frequency = HSI/HSE depends on PLLSRC bit (PLLCFGR[22])
    HSI_HSE = 0x3,
    _,
};

pub const LPTIMSEL = enum(u2) {
    /// APB1 clock (PCLK1) selected as LPTILM1 clock
    PCLK1 = 0x0,
    /// LSI clock is selected as LPTILM1 clock
    LSI = 0x1,
    /// HSI clock is selected as LPTILM1 clock
    HSI = 0x2,
    /// LSE clock is selected as LPTILM1 clock
    LSE = 0x3,
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
    Mul128 = 0x80,
    Mul129 = 0x81,
    Mul130 = 0x82,
    Mul131 = 0x83,
    Mul132 = 0x84,
    Mul133 = 0x85,
    Mul134 = 0x86,
    Mul135 = 0x87,
    Mul136 = 0x88,
    Mul137 = 0x89,
    Mul138 = 0x8a,
    Mul139 = 0x8b,
    Mul140 = 0x8c,
    Mul141 = 0x8d,
    Mul142 = 0x8e,
    Mul143 = 0x8f,
    Mul144 = 0x90,
    Mul145 = 0x91,
    Mul146 = 0x92,
    Mul147 = 0x93,
    Mul148 = 0x94,
    Mul149 = 0x95,
    Mul150 = 0x96,
    Mul151 = 0x97,
    Mul152 = 0x98,
    Mul153 = 0x99,
    Mul154 = 0x9a,
    Mul155 = 0x9b,
    Mul156 = 0x9c,
    Mul157 = 0x9d,
    Mul158 = 0x9e,
    Mul159 = 0x9f,
    Mul160 = 0xa0,
    Mul161 = 0xa1,
    Mul162 = 0xa2,
    Mul163 = 0xa3,
    Mul164 = 0xa4,
    Mul165 = 0xa5,
    Mul166 = 0xa6,
    Mul167 = 0xa7,
    Mul168 = 0xa8,
    Mul169 = 0xa9,
    Mul170 = 0xaa,
    Mul171 = 0xab,
    Mul172 = 0xac,
    Mul173 = 0xad,
    Mul174 = 0xae,
    Mul175 = 0xaf,
    Mul176 = 0xb0,
    Mul177 = 0xb1,
    Mul178 = 0xb2,
    Mul179 = 0xb3,
    Mul180 = 0xb4,
    Mul181 = 0xb5,
    Mul182 = 0xb6,
    Mul183 = 0xb7,
    Mul184 = 0xb8,
    Mul185 = 0xb9,
    Mul186 = 0xba,
    Mul187 = 0xbb,
    Mul188 = 0xbc,
    Mul189 = 0xbd,
    Mul190 = 0xbe,
    Mul191 = 0xbf,
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
    /// HSI oscillator used as system clock
    HSI = 0x0,
    /// HSE oscillator used as system clock
    HSE = 0x1,
    /// PLL used as system clock
    PLL1_P = 0x2,
    _,
};

pub const TIMPRE = enum(u1) {
    /// If the APB prescaler is configured 1, TIMxCLK = PCLKx. Otherwise, TIMxCLK = 2xPCLKx
    Mul2 = 0x0,
    /// If the APB prescaler is configured 1, 2 or 4, TIMxCLK = HCLK. Otherwise, TIMxCLK = 4xPCLKx
    Mul4 = 0x1,
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
        padding: u6 = 0,
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
        /// PLL division factor for I2S and System clocks
        PLLR: PLLR,
        padding: u1 = 0,
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
        /// MCO output enable
        MCO1EN: u1,
        /// MCO output enable
        MCO2EN: u1,
        /// APB Low speed prescaler (APB1)
        PPRE1: PPRE,
        /// APB high-speed prescaler (APB2)
        PPRE2: PPRE,
        /// HSE division factor for RTC clock
        RTCPRE: u5,
        /// Microcontroller clock output 1
        MCO1SEL: MCO1SEL,
        reserved24: u1 = 0,
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
        reserved7: u2 = 0,
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
        reserved16: u3 = 0,
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
        reserved7: u4 = 0,
        /// IO port H reset
        GPIOHRST: u1,
        reserved12: u4 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved21: u8 = 0,
        /// DMA2 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        reserved31: u8 = 0,
        /// RNGRST
        RNGRST: u1,
    }),
    /// offset: 0x14
    reserved20: [12]u8,
    /// APB1 peripheral reset register
    /// offset: 0x20
    APB1RSTR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// TIM5 reset
        TIM5RST: u1,
        /// TIM6 reset
        TIM6RST: u1,
        reserved9: u4 = 0,
        /// LPTIM1 reset
        LPTIM1RST: u1,
        reserved11: u1 = 0,
        /// Window watchdog reset
        WWDGRST: u1,
        reserved14: u2 = 0,
        /// SPI 2 reset
        SPI2RST: u1,
        reserved17: u2 = 0,
        /// USART 2 reset
        USART2RST: u1,
        reserved21: u3 = 0,
        /// I2C 1 reset
        I2C1RST: u1,
        /// I2C 2 reset
        I2C2RST: u1,
        reserved24: u1 = 0,
        /// FMPI2C1 reset
        FMPI2C1RST: u1,
        reserved28: u3 = 0,
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
        reserved4: u3 = 0,
        /// USART1 reset
        USART1RST: u1,
        /// USART6 reset
        USART6RST: u1,
        reserved8: u2 = 0,
        /// ADC interface reset (common to all ADCs)
        ADCRST: u1,
        reserved12: u3 = 0,
        /// SPI 1 reset
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// System configuration controller reset
        SYSCFGRST: u1,
        reserved16: u1 = 0,
        /// TIM9 reset
        TIM9RST: u1,
        reserved18: u1 = 0,
        /// TIM11 reset
        TIM11RST: u1,
        reserved20: u1 = 0,
        /// SPI5 reset
        SPI5RST: u1,
        padding: u11 = 0,
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
        reserved7: u4 = 0,
        /// IO port H clock enable
        GPIOHEN: u1,
        reserved12: u4 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved21: u8 = 0,
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        reserved31: u8 = 0,
        /// RNG clock enable
        RNGEN: u1,
    }),
    /// offset: 0x34
    reserved52: [12]u8,
    /// APB1 peripheral clock enable register
    /// offset: 0x40
    APB1ENR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// TIM5 clock enable
        TIM5EN: u1,
        /// TIM6 clock enable
        TIM6EN: u1,
        reserved9: u4 = 0,
        /// LPTIM1 clock enable
        LPTIM1EN: u1,
        /// RTC APB clock enable
        RTCAPBEN: u1,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable
        SPI2EN: u1,
        reserved17: u2 = 0,
        /// USART 2 clock enable
        USART2EN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable
        I2C1EN: u1,
        /// I2C2 clock enable
        I2C2EN: u1,
        reserved24: u1 = 0,
        /// FMPI2C1 clock enable
        FMPI2C1EN: u1,
        reserved28: u3 = 0,
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
        reserved4: u3 = 0,
        /// USART1 clock enable
        USART1EN: u1,
        /// USART6 clock enable
        USART6EN: u1,
        reserved8: u2 = 0,
        /// ADC1 clock enable
        ADC1EN: u1,
        reserved12: u3 = 0,
        /// SPI1 clock enable
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// System configuration controller clock enable
        SYSCFGEN: u1,
        /// EXTI ans external IT clock enable
        EXTITEN: u1,
        /// TIM9 clock enable
        TIM9EN: u1,
        reserved18: u1 = 0,
        /// TIM11 clock enable
        TIM11EN: u1,
        reserved20: u1 = 0,
        /// SPI5 clock enable
        SPI5EN: u1,
        padding: u11 = 0,
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
        reserved7: u4 = 0,
        /// IO port H clock enable during Sleep mode
        GPIOHLPEN: u1,
        reserved12: u4 = 0,
        /// CRC clock enable during Sleep mode
        CRCLPEN: u1,
        reserved15: u2 = 0,
        /// Flash interface clock enable during Sleep mode
        FLASHLPEN: u1,
        /// SRAM 1interface clock enable during Sleep mode
        SRAM1LPEN: u1,
        reserved21: u4 = 0,
        /// DMA1 clock enable during Sleep mode
        DMA1LPEN: u1,
        /// DMA2 clock enable during Sleep mode
        DMA2LPEN: u1,
        reserved31: u8 = 0,
        /// RNG clock enable during sleep mode
        RNGLPEN: u1,
    }),
    /// offset: 0x54
    reserved84: [12]u8,
    /// APB1 peripheral clock enable in low power mode register
    /// offset: 0x60
    APB1LPENR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// TIM5 clock enable during Sleep mode
        TIM5LPEN: u1,
        /// TIM6 clock enable during Sleep mode
        TIM6LPEN: u1,
        reserved9: u4 = 0,
        /// LPTIM1 clock enable during sleep mode
        LPTIM1LPEN: u1,
        /// RTC APB clock enable during sleep mode
        RTCAPBLPEN: u1,
        /// Window watchdog clock enable during Sleep mode
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during Sleep mode
        SPI2LPEN: u1,
        reserved17: u2 = 0,
        /// USART2 clock enable during Sleep mode
        USART2LPEN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable during Sleep mode
        I2C1LPEN: u1,
        /// I2C2 clock enable during Sleep mode
        I2C2LPEN: u1,
        reserved24: u1 = 0,
        /// FMPI2C1 clock enable during Sleep
        FMPI2C1LPEN: u1,
        reserved28: u3 = 0,
        /// Power interface clock enable during Sleep mode
        PWRLPEN: u1,
        /// DAC interface clock enable during sleep mode
        DACLPEN: u1,
        padding: u2 = 0,
    }),
    /// APB2 peripheral clock enabled in low power mode register
    /// offset: 0x64
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 clock enable during Sleep mode
        TIM1LPEN: u1,
        reserved4: u3 = 0,
        /// USART1 clock enable during Sleep mode
        USART1LPEN: u1,
        /// USART6 clock enable during Sleep mode
        USART6LPEN: u1,
        reserved8: u2 = 0,
        /// ADC1 clock enable during Sleep mode
        ADC1LPEN: u1,
        reserved11: u2 = 0,
        /// SDIO clock enable during Sleep mode
        SDIOLPEN: u1,
        /// SPI 1 clock enable during Sleep mode
        SPI1LPEN: u1,
        reserved14: u1 = 0,
        /// System configuration controller clock enable during Sleep mode
        SYSCFGLPEN: u1,
        /// EXTI and External IT clock enable during sleep mode
        EXTITLPEN: u1,
        /// TIM9 clock enable during sleep mode
        TIM9LPEN: u1,
        reserved18: u1 = 0,
        /// TIM11 clock enable during Sleep mode
        TIM11LPEN: u1,
        reserved20: u1 = 0,
        /// SPI5 clock enable during Sleep mode
        SPI5LPEN: u1,
        padding: u11 = 0,
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
    /// offset: 0x84
    reserved132: [8]u8,
    /// DCKCFGR register
    /// offset: 0x8c
    DCKCFGR: mmio.Mmio(packed struct(u32) {
        reserved24: u24 = 0,
        /// TIMPRE
        TIMPRE: TIMPRE,
        /// I2SSRC
        I2SSRC: ISSRC,
        padding: u5 = 0,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// DCKCFGR2 register
    /// offset: 0x94
    DCKCFGR2: mmio.Mmio(packed struct(u32) {
        reserved22: u22 = 0,
        /// FMPI2C1 kernel clock source selection
        FMPI2C1SEL: FMPI2CSEL,
        reserved30: u6 = 0,
        /// LPTIM1SEL
        LPTIM1SEL: LPTIMSEL,
    }),
};
