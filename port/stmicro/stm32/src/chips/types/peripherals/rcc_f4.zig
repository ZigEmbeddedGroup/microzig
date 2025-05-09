const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CECSEL = enum(u1) {
    /// LSE clock is selected as HDMI-CEC clock
    LSE = 0x0,
    /// HSI divided by 488 clock is selected as HDMI-CEC clock
    HSI_Div488 = 0x1,
};

pub const CKDFSDMASEL = enum(u1) {
    /// CK_I2S_APB1 selected as audio clock
    I2S1 = 0x0,
    /// CK_I2S_APB2 selected as audio clock
    I2S2 = 0x1,
};

pub const CKDFSDMSEL = enum(u1) {
    /// APB2 clock used as Kernel clock
    PCLK2 = 0x0,
    /// System clock used as Kernel clock
    SYS = 0x1,
};

pub const CLK48SEL = enum(u1) {
    /// 48MHz clock from PLL is selected
    PLL1_Q = 0x0,
    /// 48MHz clock from PLLSAI is selected
    PLLSAI1_Q = 0x1,
};

pub const DSISEL = enum(u1) {
    /// DSI-PHY used as DSI byte lane clock source (usual case)
    DSI_PHY = 0x0,
    /// PLLR used as DSI byte lane clock source, used in case DSI PLL and DSI-PHY are off (low power mode)
    PLL1_R = 0x1,
};

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

pub const I2S1SRC = enum(u2) {
    /// I2Sx clock frequency = f(PLLI2S_R)
    PLLI2SR = 0x0,
    /// I2Sx clock frequency = I2S_CKIN Alternate function input frequency
    I2S_CKIN = 0x1,
    /// I2Sx clock frequency = f(PLL_R)
    PLLR = 0x2,
    /// I2Sx clock frequency = HSI/HSE depends on PLLSRC bit (PLLCFGR[22])
    HSI_HSE = 0x3,
};

pub const I2SSRC_CFGR = enum(u1) {
    /// PLLI2S clock used as I2S clock source
    PLLI2S = 0x0,
    /// External clock mapped on the I2S_CKIN pin used as I2S clock source
    CKIN = 0x1,
};

pub const I2SSRC_DCKCFGR = enum(u2) {
    /// clock frequency = f(PLLI2S_R)
    PLLI2S_R = 0x0,
    /// clock frequency = I2S_CKIN Alternate function input frequency
    I2S_CKIN = 0x1,
    /// clock frequency = f(PLL_R)
    PLL_R = 0x2,
    /// clock frequency = HSI/HSE depends on PLLSRC bit (PLLCFGR[22])
    HSI_HSE = 0x3,
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

pub const LSEMOD = enum(u1) {
    /// LSE oscillator low power mode selection
    Low = 0x0,
    /// LSE oscillator high drive mode selection
    High = 0x1,
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

pub const PLLDIVR = enum(u5) {
    /// PLLSAIDIVQ = /1
    Div1 = 0x0,
    /// PLLSAIDIVQ = /2
    Div2 = 0x1,
    /// PLLSAIDIVQ = /3
    Div3 = 0x2,
    /// PLLSAIDIVQ = /4
    Div4 = 0x3,
    /// PLLSAIDIVQ = /5
    Div5 = 0x4,
    /// PLLSAIDIVQ = /6
    Div6 = 0x5,
    /// PLLSAIDIVQ = /7
    Div7 = 0x6,
    /// PLLSAIDIVQ = /8
    Div8 = 0x7,
    /// PLLSAIDIVQ = /9
    Div9 = 0x8,
    /// PLLSAIDIVQ = /10
    Div10 = 0x9,
    /// PLLSAIDIVQ = /11
    Div11 = 0xa,
    /// PLLSAIDIVQ = /12
    Div12 = 0xb,
    /// PLLSAIDIVQ = /13
    Div13 = 0xc,
    /// PLLSAIDIVQ = /14
    Div14 = 0xd,
    /// PLLSAIDIVQ = /15
    Div15 = 0xe,
    /// PLLSAIDIVQ = /16
    Div16 = 0xf,
    /// PLLSAIDIVQ = /17
    Div17 = 0x10,
    /// PLLSAIDIVQ = /18
    Div18 = 0x11,
    /// PLLSAIDIVQ = /19
    Div19 = 0x12,
    /// PLLSAIDIVQ = /20
    Div20 = 0x13,
    /// PLLSAIDIVQ = /21
    Div21 = 0x14,
    /// PLLSAIDIVQ = /22
    Div22 = 0x15,
    /// PLLSAIDIVQ = /23
    Div23 = 0x16,
    /// PLLSAIDIVQ = /24
    Div24 = 0x17,
    /// PLLSAIDIVQ = /25
    Div25 = 0x18,
    /// PLLSAIDIVQ = /26
    Div26 = 0x19,
    /// PLLSAIDIVQ = /27
    Div27 = 0x1a,
    /// PLLSAIDIVQ = /28
    Div28 = 0x1b,
    /// PLLSAIDIVQ = /29
    Div29 = 0x1c,
    /// PLLSAIDIVQ = /30
    Div30 = 0x1d,
    /// PLLSAIDIVQ = /31
    Div31 = 0x1e,
    /// PLLSAIDIVQ = /32
    Div32 = 0x1f,
};

pub const PLLI2SDIVQ = enum(u5) {
    /// PLLI2SDIVQ = /1
    Div1 = 0x0,
    /// PLLI2SDIVQ = /2
    Div2 = 0x1,
    /// PLLI2SDIVQ = /3
    Div3 = 0x2,
    /// PLLI2SDIVQ = /4
    Div4 = 0x3,
    /// PLLI2SDIVQ = /5
    Div5 = 0x4,
    /// PLLI2SDIVQ = /6
    Div6 = 0x5,
    /// PLLI2SDIVQ = /7
    Div7 = 0x6,
    /// PLLI2SDIVQ = /8
    Div8 = 0x7,
    /// PLLI2SDIVQ = /9
    Div9 = 0x8,
    /// PLLI2SDIVQ = /10
    Div10 = 0x9,
    /// PLLI2SDIVQ = /11
    Div11 = 0xa,
    /// PLLI2SDIVQ = /12
    Div12 = 0xb,
    /// PLLI2SDIVQ = /13
    Div13 = 0xc,
    /// PLLI2SDIVQ = /14
    Div14 = 0xd,
    /// PLLI2SDIVQ = /15
    Div15 = 0xe,
    /// PLLI2SDIVQ = /16
    Div16 = 0xf,
    /// PLLI2SDIVQ = /17
    Div17 = 0x10,
    /// PLLI2SDIVQ = /18
    Div18 = 0x11,
    /// PLLI2SDIVQ = /19
    Div19 = 0x12,
    /// PLLI2SDIVQ = /20
    Div20 = 0x13,
    /// PLLI2SDIVQ = /21
    Div21 = 0x14,
    /// PLLI2SDIVQ = /22
    Div22 = 0x15,
    /// PLLI2SDIVQ = /23
    Div23 = 0x16,
    /// PLLI2SDIVQ = /24
    Div24 = 0x17,
    /// PLLI2SDIVQ = /25
    Div25 = 0x18,
    /// PLLI2SDIVQ = /26
    Div26 = 0x19,
    /// PLLI2SDIVQ = /27
    Div27 = 0x1a,
    /// PLLI2SDIVQ = /28
    Div28 = 0x1b,
    /// PLLI2SDIVQ = /29
    Div29 = 0x1c,
    /// PLLI2SDIVQ = /30
    Div30 = 0x1d,
    /// PLLI2SDIVQ = /31
    Div31 = 0x1e,
    /// PLLI2SDIVQ = /32
    Div32 = 0x1f,
};

pub const PLLI2SDIVR = enum(u5) {
    /// PLLI2SDIVQ = /1
    Div1 = 0x0,
    /// PLLI2SDIVQ = /2
    Div2 = 0x1,
    /// PLLI2SDIVQ = /3
    Div3 = 0x2,
    /// PLLI2SDIVQ = /4
    Div4 = 0x3,
    /// PLLI2SDIVQ = /5
    Div5 = 0x4,
    /// PLLI2SDIVQ = /6
    Div6 = 0x5,
    /// PLLI2SDIVQ = /7
    Div7 = 0x6,
    /// PLLI2SDIVQ = /8
    Div8 = 0x7,
    /// PLLI2SDIVQ = /9
    Div9 = 0x8,
    /// PLLI2SDIVQ = /10
    Div10 = 0x9,
    /// PLLI2SDIVQ = /11
    Div11 = 0xa,
    /// PLLI2SDIVQ = /12
    Div12 = 0xb,
    /// PLLI2SDIVQ = /13
    Div13 = 0xc,
    /// PLLI2SDIVQ = /14
    Div14 = 0xd,
    /// PLLI2SDIVQ = /15
    Div15 = 0xe,
    /// PLLI2SDIVQ = /16
    Div16 = 0xf,
    /// PLLI2SDIVQ = /17
    Div17 = 0x10,
    /// PLLI2SDIVQ = /18
    Div18 = 0x11,
    /// PLLI2SDIVQ = /19
    Div19 = 0x12,
    /// PLLI2SDIVQ = /20
    Div20 = 0x13,
    /// PLLI2SDIVQ = /21
    Div21 = 0x14,
    /// PLLI2SDIVQ = /22
    Div22 = 0x15,
    /// PLLI2SDIVQ = /23
    Div23 = 0x16,
    /// PLLI2SDIVQ = /24
    Div24 = 0x17,
    /// PLLI2SDIVQ = /25
    Div25 = 0x18,
    /// PLLI2SDIVQ = /26
    Div26 = 0x19,
    /// PLLI2SDIVQ = /27
    Div27 = 0x1a,
    /// PLLI2SDIVQ = /28
    Div28 = 0x1b,
    /// PLLI2SDIVQ = /29
    Div29 = 0x1c,
    /// PLLI2SDIVQ = /30
    Div30 = 0x1d,
    /// PLLI2SDIVQ = /31
    Div31 = 0x1e,
    /// PLLI2SDIVQ = /32
    Div32 = 0x1f,
};

pub const PLLI2SSRC = enum(u1) {
    /// HSE or HSI depending on PLLSRC of PLLCFGR
    HSE_HSI = 0x0,
    /// External AFI clock (CK_PLLI2S_EXT) selected as PLL clock entry
    External = 0x1,
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

pub const PLLSAIDIVQ = enum(u5) {
    /// PLLSAIDIVQ = /1
    Div1 = 0x0,
    /// PLLSAIDIVQ = /2
    Div2 = 0x1,
    /// PLLSAIDIVQ = /3
    Div3 = 0x2,
    /// PLLSAIDIVQ = /4
    Div4 = 0x3,
    /// PLLSAIDIVQ = /5
    Div5 = 0x4,
    /// PLLSAIDIVQ = /6
    Div6 = 0x5,
    /// PLLSAIDIVQ = /7
    Div7 = 0x6,
    /// PLLSAIDIVQ = /8
    Div8 = 0x7,
    /// PLLSAIDIVQ = /9
    Div9 = 0x8,
    /// PLLSAIDIVQ = /10
    Div10 = 0x9,
    /// PLLSAIDIVQ = /11
    Div11 = 0xa,
    /// PLLSAIDIVQ = /12
    Div12 = 0xb,
    /// PLLSAIDIVQ = /13
    Div13 = 0xc,
    /// PLLSAIDIVQ = /14
    Div14 = 0xd,
    /// PLLSAIDIVQ = /15
    Div15 = 0xe,
    /// PLLSAIDIVQ = /16
    Div16 = 0xf,
    /// PLLSAIDIVQ = /17
    Div17 = 0x10,
    /// PLLSAIDIVQ = /18
    Div18 = 0x11,
    /// PLLSAIDIVQ = /19
    Div19 = 0x12,
    /// PLLSAIDIVQ = /20
    Div20 = 0x13,
    /// PLLSAIDIVQ = /21
    Div21 = 0x14,
    /// PLLSAIDIVQ = /22
    Div22 = 0x15,
    /// PLLSAIDIVQ = /23
    Div23 = 0x16,
    /// PLLSAIDIVQ = /24
    Div24 = 0x17,
    /// PLLSAIDIVQ = /25
    Div25 = 0x18,
    /// PLLSAIDIVQ = /26
    Div26 = 0x19,
    /// PLLSAIDIVQ = /27
    Div27 = 0x1a,
    /// PLLSAIDIVQ = /28
    Div28 = 0x1b,
    /// PLLSAIDIVQ = /29
    Div29 = 0x1c,
    /// PLLSAIDIVQ = /30
    Div30 = 0x1d,
    /// PLLSAIDIVQ = /31
    Div31 = 0x1e,
    /// PLLSAIDIVQ = /32
    Div32 = 0x1f,
};

pub const PLLSAIDIVR = enum(u2) {
    /// PLLSAIDIVR = /2
    Div2 = 0x0,
    /// PLLSAIDIVR = /4
    Div4 = 0x1,
    /// PLLSAIDIVR = /8
    Div8 = 0x2,
    /// PLLSAIDIVR = /16
    Div16 = 0x3,
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

pub const SAI1SRC = enum(u2) {
    /// SAI1 clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
    PLLSAI = 0x0,
    /// SAI1 clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
    PLLI2S = 0x1,
    /// SAI1 clock frequency = f(PLL_R)
    PLLR = 0x2,
    /// I2S_CKIN Alternate function input frequency
    I2S_CKIN = 0x3,
};

pub const SAI2SRC = enum(u2) {
    /// SAI2 clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
    PLLSAI = 0x0,
    /// SAI2 clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
    PLLI2S = 0x1,
    /// SAI2 clock frequency = f(PLL_R)
    PLLR = 0x2,
    /// SAI2 clock frequency = Alternate function input frequency
    HSI_HSE = 0x3,
};

pub const SAIASRC = enum(u2) {
    /// SAI1-A clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
    PLLSAI = 0x0,
    /// SAI1-A clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
    PLLI2S = 0x1,
    /// SAI1-A clock frequency = Alternate function input frequency
    I2S_CKIN = 0x2,
    _,
};

pub const SAIBSRC = enum(u2) {
    /// SAI1-B clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
    PLLSAI = 0x0,
    /// SAI1-B clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
    PLLI2S = 0x1,
    /// SAI1-B clock frequency = Alternate function input frequency
    I2S_CKIN = 0x2,
    _,
};

pub const SDIOSEL = enum(u1) {
    /// 48 MHz clock is selected as SD clock
    CLK48 = 0x0,
    /// System clock is selected as SD clock
    SYS = 0x1,
};

pub const SPDIFRXSEL = enum(u1) {
    /// SPDIF-Rx clock from PLL is selected
    PLL1_R = 0x0,
    /// SPDIF-Rx clock from PLLI2S is selected
    PLLI2S1_P = 0x1,
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
        /// PLLI2S enable
        PLLI2SON: u1,
        /// PLLI2S clock ready flag
        PLLI2SRDY: u1,
        /// PLLSAI enable
        PLLSAION: u1,
        /// PLLSAI clock ready flag
        PLLSAIRDY: u1,
        padding: u2 = 0,
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
        /// I2S clock selection
        I2SSRC: I2SSRC_CFGR,
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
        /// PLLSAI ready interrupt flag
        PLLSAIRDYF: u1,
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
        /// PLLSAI Ready Interrupt Enable
        PLLSAIRDYIE: u1,
        reserved16: u1 = 0,
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
        /// PLLSAI Ready Interrupt Clear
        PLLSAIRDYC: u1,
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
        /// IO port J reset
        GPIOJRST: u1,
        /// IO port K reset
        GPIOKRST: u1,
        reserved12: u1 = 0,
        /// CRC reset
        CRCRST: u1,
        reserved21: u8 = 0,
        /// DMA2 reset
        DMA1RST: u1,
        /// DMA2 reset
        DMA2RST: u1,
        /// DMA2D reset
        DMA2DRST: u1,
        reserved25: u1 = 0,
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
        /// CRYP module reset
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
        FMCRST: u1,
        /// QUADSPI module reset
        QUADSPIRST: u1,
        padding: u30 = 0,
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
        /// LPTIM1 reset
        LPTIM1RST: u1,
        reserved11: u1 = 0,
        /// Window watchdog reset
        WWDGRST: u1,
        reserved14: u2 = 0,
        /// SPI 2 reset
        SPI2RST: u1,
        /// SPI 3 reset
        SPI3RST: u1,
        /// SPDIF-IN reset
        SPDIFRST: u1,
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
        /// I2C3 reset
        I2C3RST: u1,
        /// FMPI2C1 reset
        FMPI2C1RST: u1,
        /// CAN1 reset
        CAN1RST: u1,
        /// CAN2 reset
        CAN2RST: u1,
        /// CAN 3 reset
        CAN3RST: u1,
        /// Power interface reset
        PWRRST: u1,
        /// DAC reset
        DACRST: u1,
        /// UART 7 reset
        UART7RST: u1,
        /// UART 8 reset
        UART8RST: u1,
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
        /// UART9 reset
        UART9RST: u1,
        /// UART10 reset
        UART10RST: u1,
        /// ADC interface reset (common to all ADCs)
        ADCRST: u1,
        reserved11: u2 = 0,
        /// SDIO reset
        SDIORST: u1,
        /// SPI 1 reset
        SPI1RST: u1,
        /// SPI4 reset
        SPI4RST: u1,
        /// System configuration controller reset
        SYSCFGRST: u1,
        reserved16: u1 = 0,
        /// TIM9 reset
        TIM9RST: u1,
        /// TIM10 reset
        TIM10RST: u1,
        /// TIM11 reset
        TIM11RST: u1,
        reserved20: u1 = 0,
        /// SPI5 reset
        SPI5RST: u1,
        /// SPI6 reset
        SPI6RST: u1,
        /// SAI1 reset
        SAI1RST: u1,
        /// SAI2 reset
        SAI2RST: u1,
        /// DFSDMRST
        DFSDMRST: u1,
        /// DFSDM2 reset
        DFSDM2RST: u1,
        /// LTDC reset
        LTDCRST: u1,
        /// DSI host reset
        DSIRST: u1,
        padding: u4 = 0,
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
        /// IO port J clock enable
        GPIOJEN: u1,
        /// IO port K clock enable
        GPIOKEN: u1,
        reserved12: u1 = 0,
        /// CRC clock enable
        CRCEN: u1,
        reserved18: u5 = 0,
        /// Backup SRAM interface clock enable
        BKPSRAMEN: u1,
        reserved20: u1 = 0,
        /// CCM data RAM clock enable
        CCMDATARAMEN: u1,
        /// DMA1 clock enable
        DMA1EN: u1,
        /// DMA2 clock enable
        DMA2EN: u1,
        /// DMA2D clock enable
        DMA2DEN: u1,
        reserved25: u1 = 0,
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
        /// CRYP clock enable
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
        FMCEN: u1,
        /// QUADSPI memory controller module clock enable
        QUADSPIEN: u1,
        padding: u30 = 0,
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
        /// LPTIM1 clock enable
        LPTIM1EN: u1,
        /// RTC APB clock enable
        RTCAPBEN: u1,
        /// Window watchdog clock enable
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable
        SPI2EN: u1,
        /// SPI3 clock enable
        SPI3EN: u1,
        /// SPDIF-IN clock enable
        SPDIFEN: u1,
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
        /// FMPI2C1 clock enable
        FMPI2C1EN: u1,
        /// CAN 1 clock enable
        CAN1EN: u1,
        /// CAN 2 clock enable
        CAN2EN: u1,
        /// CAN 3 clock enable
        CAN3EN: u1,
        /// Power interface clock enable
        PWREN: u1,
        /// DAC interface clock enable
        DACEN: u1,
        /// UART7 clock enable
        UART7EN: u1,
        /// UART8 clock enable
        UART8EN: u1,
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
        /// UART9 clock enable
        UART9EN: u1,
        /// UART10 clock enable
        UART10EN: u1,
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
        /// SPI4 clock enable
        SPI4EN: u1,
        /// System configuration controller clock enable
        SYSCFGEN: u1,
        /// EXTI ans external IT clock enable
        EXTITEN: u1,
        /// TIM9 clock enable
        TIM9EN: u1,
        /// TIM10 clock enable
        TIM10EN: u1,
        /// TIM11 clock enable
        TIM11EN: u1,
        reserved20: u1 = 0,
        /// SPI5 clock enable
        SPI5EN: u1,
        /// SPI6 clock enable
        SPI6EN: u1,
        /// SAI 1 clock enable
        SAI1EN: u1,
        /// SAI2 clock enable
        SAI2EN: u1,
        /// DFSDMEN
        DFSDMEN: u1,
        /// DFSDM2 clock enable
        DFSDM2EN: u1,
        /// LTDC clock enable
        LTDCEN: u1,
        /// DSI clocks enable
        DSIEN: u1,
        padding: u4 = 0,
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
        /// IO port J clock enable during Sleep mode
        GPIOJLPEN: u1,
        /// IO port K clock enable during Sleep mode
        GPIOKLPEN: u1,
        reserved12: u1 = 0,
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
        /// SRAM 3 interface clock enable during Sleep mode
        SRAM3LPEN: u1,
        reserved21: u1 = 0,
        /// DMA1 clock enable during Sleep mode
        DMA1LPEN: u1,
        /// DMA2 clock enable during Sleep mode
        DMA2LPEN: u1,
        /// DMA2D clock enable during Sleep mode
        DMA2DLPEN: u1,
        reserved25: u1 = 0,
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
        /// RNG clock enable during sleep mode
        RNGLPEN: u1,
    }),
    /// AHB2 peripheral clock enable in low power mode register
    /// offset: 0x54
    AHB2LPENR: mmio.Mmio(packed struct(u32) {
        /// Camera interface enable during Sleep mode
        DCMILPEN: u1,
        /// QUADSPI memory controller module clock enable during Sleep mode
        QUADSPILPEN: u1,
        reserved4: u2 = 0,
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
        FMCLPEN: u1,
        /// QUADSPI memory controller module clock enable during Sleep mode
        QUADSPILPEN: u1,
        padding: u30 = 0,
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
        /// LPTIM1 clock enable during sleep mode
        LPTIM1LPEN: u1,
        /// RTC APB clock enable during sleep mode
        RTCAPBLPEN: u1,
        /// Window watchdog clock enable during Sleep mode
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during Sleep mode
        SPI2LPEN: u1,
        /// SPI3 clock enable during Sleep mode
        SPI3LPEN: u1,
        /// SPDIF clock enable during Sleep mode
        SPDIFLPEN: u1,
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
        /// FMPI2C1 clock enable during Sleep
        FMPI2C1LPEN: u1,
        /// CAN 1 clock enable during Sleep mode
        CAN1LPEN: u1,
        /// CAN 2 clock enable during Sleep mode
        CAN2LPEN: u1,
        /// CAN3 clock enable during Sleep mode
        CAN3LPEN: u1,
        /// Power interface clock enable during Sleep mode
        PWRLPEN: u1,
        /// DAC interface clock enable during Sleep mode
        DACLPEN: u1,
        /// UART7 clock enable during Sleep mode
        UART7LPEN: u1,
        /// UART8 clock enable during Sleep mode
        UART8LPEN: u1,
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
        /// UART9 clock enable during Sleep mode
        UART9LPEN: u1,
        /// UART10 clock enable during Sleep mode
        UART10LPEN: u1,
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
        /// SPI4 clock enable during Sleep mode
        SPI4LPEN: u1,
        /// System configuration controller clock enable during Sleep mode
        SYSCFGLPEN: u1,
        /// EXTI and External IT clock enable during sleep mode
        EXTITLPEN: u1,
        /// TIM9 clock enable during sleep mode
        TIM9LPEN: u1,
        /// TIM10 clock enable during Sleep mode
        TIM10LPEN: u1,
        /// TIM11 clock enable during Sleep mode
        TIM11LPEN: u1,
        reserved20: u1 = 0,
        /// SPI5 clock enable during Sleep mode
        SPI5LPEN: u1,
        /// SPI 6 clock enable during Sleep mode
        SPI6LPEN: u1,
        /// SAI1 clock enable during Sleep mode
        SAI1LPEN: u1,
        /// SAI2 clock enable
        SAI2LPEN: u1,
        /// DFSDMLPEN
        DFSDMLPEN: u1,
        /// DFSDM2 clock enable during Sleep mode
        DFSDM2LPEN: u1,
        /// LTDC clock enable during Sleep mode
        LTDCLPEN: u1,
        /// DSI clocks enable during Sleep mode
        DSILPEN: u1,
        padding: u4 = 0,
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
        /// External low-speed oscillator bypass
        LSEMOD: LSEMOD,
        reserved8: u4 = 0,
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
        /// Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
        PLLM: PLLM,
        /// Main PLL (PLL) multiplication factor for VCO
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// Main PLL (PLL) division factor for main system clock
        PLLP: PLLP,
        reserved22: u4 = 0,
        /// PLLI2S entry clock source
        PLLI2SSRC: PLLI2SSRC,
        reserved24: u1 = 0,
        /// Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
        PLLQ: PLLQ,
        /// PLL division factor for I2S and System clocks
        PLLR: PLLR,
        padding: u1 = 0,
    }),
    /// RCC PLL configuration register
    /// offset: 0x88
    PLLSAICFGR: mmio.Mmio(packed struct(u32) {
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
    /// RCC Dedicated Clock Configuration Register
    /// offset: 0x8c
    DCKCFGR: mmio.Mmio(packed struct(u32) {
        /// PLLI2S division factor for SAI1 clock
        PLLI2SDIVQ: PLLI2SDIVQ,
        reserved8: u3 = 0,
        /// PLL division factor for SAI1 A/B clock
        PLLDIVR: PLLDIVR,
        reserved14: u1 = 0,
        /// DFSDM2 audio clock selection
        CKDFSDM2ASEL: CKDFSDMASEL,
        /// DFSDM1 audio clock selection
        CKDFSDM1ASEL: CKDFSDMASEL,
        /// division factor for LCD_CLK
        PLLSAIDIVR: PLLSAIDIVR,
        reserved20: u2 = 0,
        /// SAI1-A clock source selection
        SAI1ASRC: SAIASRC,
        /// SAI1-B clock source selection
        SAI1BSRC: SAIBSRC,
        /// Timers clocks prescalers selection
        TIMPRE: TIMPRE,
        /// I2S APB1 clocks source selection (I2S2/3)
        I2S1SRC: I2S1SRC,
        /// 48 MHz clock source selection
        CLK48SEL: CLK48SEL,
        /// SDIO clock source selection
        SDIOSEL: SDIOSEL,
        /// DSI clock source selection
        DSISEL: DSISEL,
        reserved31: u1 = 0,
        /// DFSDM1 Kernel clock selection
        CKDFSDM1SEL: CKDFSDMSEL,
    }),
    /// Clocks gated enable register
    /// offset: 0x90
    CKGATENR: mmio.Mmio(packed struct(u32) {
        /// AHB to APB1 Bridge clock enable
        AHB2APB1_CKEN: u1,
        /// AHB to APB2 Bridge clock enable
        AHB2APB2_CKEN: u1,
        /// Cortex M4 ETM clock enable
        CM4DBG_CKEN: u1,
        /// Spare clock enable
        SPARE_CKEN: u1,
        /// SRAM controller clock enable
        SRAM_CKEN: u1,
        /// Flash interface clock enable
        FLASH_CKEN: u1,
        /// RCC clock enable
        RCC_CKEN: u1,
        /// EVTCL clock enable
        EVTCL_CKEN: u1,
        padding: u24 = 0,
    }),
    /// DCKCFGR2 register
    /// offset: 0x94
    DCKCFGR2: mmio.Mmio(packed struct(u32) {
        reserved22: u22 = 0,
        /// FMPI2C1 kernel clock source selection
        FMPI2C1SEL: FMPI2CSEL,
        reserved26: u2 = 0,
        /// HDMI CEC clock source selection
        CECSEL: CECSEL,
        /// SDIO/USB clock selection
        CLK48SEL: CLK48SEL,
        /// SDIO clock selection
        SDIOSEL: SDIOSEL,
        /// SPDIF clock selection
        SPDIFRXSEL: SPDIFRXSEL,
        /// LPTIM1SEL
        LPTIM1SEL: LPTIMSEL,
    }),
};
