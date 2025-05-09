const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// PER selected as peripheral clock
    PER = 0x2,
    _,
};

pub const CECSEL = enum(u2) {
    /// LSE selected as peripheral clock
    LSE = 0x0,
    /// LSI selected as peripheral clock
    LSI = 0x1,
    /// csi_ker selected as peripheral clock
    CSI = 0x2,
    _,
};

pub const DFSDMSEL = enum(u1) {
    /// rcc_pclk2 selected as peripheral clock
    PCLK2 = 0x0,
    /// System clock selected as peripheral clock
    SYS = 0x1,
};

pub const FDCANSEL = enum(u2) {
    /// HSE selected as peripheral clock
    HSE = 0x0,
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x1,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x2,
    _,
};

pub const FMCSEL = enum(u2) {
    /// rcc_hclk3 selected as peripheral clock
    HCLK3 = 0x0,
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x1,
    /// pll2_r selected as peripheral clock
    PLL2_R = 0x2,
    /// PER selected as peripheral clock
    PER = 0x3,
};

pub const HPRE = enum(u4) {
    /// sys_ck not divided
    Div1 = 0x0,
    /// sys_ck divided by 2
    Div2 = 0x8,
    /// sys_ck divided by 4
    Div4 = 0x9,
    /// sys_ck divided by 8
    Div8 = 0xa,
    /// sys_ck divided by 16
    Div16 = 0xb,
    /// sys_ck divided by 64
    Div64 = 0xc,
    /// sys_ck divided by 128
    Div128 = 0xd,
    /// sys_ck divided by 256
    Div256 = 0xe,
    /// sys_ck divided by 512
    Div512 = 0xf,
    _,
};

pub const HRTIMSEL = enum(u1) {
    /// The HRTIM prescaler clock source is the same as other timers (rcc_timy_ker_ck)
    TIMY_KER = 0x0,
    /// The HRTIM prescaler clock source is the CPU clock (c_ck)
    C_CK = 0x1,
};

pub const HSIDIV = enum(u2) {
    /// No division
    Div1 = 0x0,
    /// Division by 2
    Div2 = 0x1,
    /// Division by 4
    Div4 = 0x2,
    /// Division by 8
    Div8 = 0x3,
};

pub const I2C1235SEL = enum(u2) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// hsi_ker selected as peripheral clock
    HSI = 0x2,
    /// csi_ker selected as peripheral clock
    CSI = 0x3,
};

pub const I2C4SEL = enum(u2) {
    /// rcc_pclk4 selected as peripheral clock
    PCLK4 = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// hsi_ker selected as peripheral clock
    HSI = 0x2,
    /// csi_ker selected as peripheral clock
    CSI = 0x3,
};

pub const LPTIM1SEL = enum(u3) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x1,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x2,
    /// LSE selected as peripheral clock
    LSE = 0x3,
    /// LSI selected as peripheral clock
    LSI = 0x4,
    /// PER selected as peripheral clock
    PER = 0x5,
    _,
};

pub const LPTIM2SEL = enum(u3) {
    /// rcc_pclk4 selected as peripheral clock
    PCLK4 = 0x0,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x1,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x2,
    /// LSE selected as peripheral clock
    LSE = 0x3,
    /// LSI selected as peripheral clock
    LSI = 0x4,
    /// PER selected as peripheral clock
    PER = 0x5,
    _,
};

pub const LPUARTSEL = enum(u3) {
    /// rcc_pclk_d4 selected as peripheral clock
    PCLK4 = 0x0,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
    /// csi_ker selected as peripheral clock
    CSI = 0x4,
    /// LSE selected as peripheral clock
    LSE = 0x5,
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

pub const MCO1SEL = enum(u3) {
    /// HSI selected for micro-controller clock output
    HSI = 0x0,
    /// LSE selected for micro-controller clock output
    LSE = 0x1,
    /// HSE selected for micro-controller clock output
    HSE = 0x2,
    /// pll1_q selected for micro-controller clock output
    PLL1_Q = 0x3,
    /// HSI48 selected for micro-controller clock output
    HSI48 = 0x4,
    _,
};

pub const MCO2SEL = enum(u3) {
    /// System clock selected for micro-controller clock output
    SYS = 0x0,
    /// pll2_p selected for micro-controller clock output
    PLL2_P = 0x1,
    /// HSE selected for micro-controller clock output
    HSE = 0x2,
    /// pll1_p selected for micro-controller clock output
    PLL1_P = 0x3,
    /// CSI selected for micro-controller clock output
    CSI = 0x4,
    /// LSI selected for micro-controller clock output
    LSI = 0x5,
    _,
};

pub const MCOPRE = enum(u4) {
    /// Divide by 1
    Div1 = 0x1,
    /// Divide by 2
    Div2 = 0x2,
    /// Divide by 3
    Div3 = 0x3,
    /// Divide by 4
    Div4 = 0x4,
    /// Divide by 5
    Div5 = 0x5,
    /// Divide by 6
    Div6 = 0x6,
    /// Divide by 7
    Div7 = 0x7,
    /// Divide by 8
    Div8 = 0x8,
    /// Divide by 9
    Div9 = 0x9,
    /// Divide by 10
    Div10 = 0xa,
    /// Divide by 11
    Div11 = 0xb,
    /// Divide by 12
    Div12 = 0xc,
    /// Divide by 13
    Div13 = 0xd,
    /// Divide by 14
    Div14 = 0xe,
    /// Divide by 15
    Div15 = 0xf,
    _,
};

pub const PERSEL = enum(u2) {
    /// HSI selected as peripheral clock
    HSI = 0x0,
    /// CSI selected as peripheral clock
    CSI = 0x1,
    /// HSE selected as peripheral clock
    HSE = 0x2,
    _,
};

pub const PLLDIV = enum(u7) {
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
    Div33 = 0x20,
    Div34 = 0x21,
    Div35 = 0x22,
    Div36 = 0x23,
    Div37 = 0x24,
    Div38 = 0x25,
    Div39 = 0x26,
    Div40 = 0x27,
    Div41 = 0x28,
    Div42 = 0x29,
    Div43 = 0x2a,
    Div44 = 0x2b,
    Div45 = 0x2c,
    Div46 = 0x2d,
    Div47 = 0x2e,
    Div48 = 0x2f,
    Div49 = 0x30,
    Div50 = 0x31,
    Div51 = 0x32,
    Div52 = 0x33,
    Div53 = 0x34,
    Div54 = 0x35,
    Div55 = 0x36,
    Div56 = 0x37,
    Div57 = 0x38,
    Div58 = 0x39,
    Div59 = 0x3a,
    Div60 = 0x3b,
    Div61 = 0x3c,
    Div62 = 0x3d,
    Div63 = 0x3e,
    Div64 = 0x3f,
    Div65 = 0x40,
    Div66 = 0x41,
    Div67 = 0x42,
    Div68 = 0x43,
    Div69 = 0x44,
    Div70 = 0x45,
    Div71 = 0x46,
    Div72 = 0x47,
    Div73 = 0x48,
    Div74 = 0x49,
    Div75 = 0x4a,
    Div76 = 0x4b,
    Div77 = 0x4c,
    Div78 = 0x4d,
    Div79 = 0x4e,
    Div80 = 0x4f,
    Div81 = 0x50,
    Div82 = 0x51,
    Div83 = 0x52,
    Div84 = 0x53,
    Div85 = 0x54,
    Div86 = 0x55,
    Div87 = 0x56,
    Div88 = 0x57,
    Div89 = 0x58,
    Div90 = 0x59,
    Div91 = 0x5a,
    Div92 = 0x5b,
    Div93 = 0x5c,
    Div94 = 0x5d,
    Div95 = 0x5e,
    Div96 = 0x5f,
    Div97 = 0x60,
    Div98 = 0x61,
    Div99 = 0x62,
    Div100 = 0x63,
    Div101 = 0x64,
    Div102 = 0x65,
    Div103 = 0x66,
    Div104 = 0x67,
    Div105 = 0x68,
    Div106 = 0x69,
    Div107 = 0x6a,
    Div108 = 0x6b,
    Div109 = 0x6c,
    Div110 = 0x6d,
    Div111 = 0x6e,
    Div112 = 0x6f,
    Div113 = 0x70,
    Div114 = 0x71,
    Div115 = 0x72,
    Div116 = 0x73,
    Div117 = 0x74,
    Div118 = 0x75,
    Div119 = 0x76,
    Div120 = 0x77,
    Div121 = 0x78,
    Div122 = 0x79,
    Div123 = 0x7a,
    Div124 = 0x7b,
    Div125 = 0x7c,
    Div126 = 0x7d,
    Div127 = 0x7e,
    Div128 = 0x7f,
};

pub const PLLM = enum(u6) {
    Div1 = 0x1,
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
    _,
};

pub const PLLN = enum(u9) {
    Mul4 = 0x3,
    Mul5 = 0x4,
    Mul6 = 0x5,
    Mul7 = 0x6,
    Mul8 = 0x7,
    Mul9 = 0x8,
    Mul10 = 0x9,
    Mul11 = 0xa,
    Mul12 = 0xb,
    Mul13 = 0xc,
    Mul14 = 0xd,
    Mul15 = 0xe,
    Mul16 = 0xf,
    Mul17 = 0x10,
    Mul18 = 0x11,
    Mul19 = 0x12,
    Mul20 = 0x13,
    Mul21 = 0x14,
    Mul22 = 0x15,
    Mul23 = 0x16,
    Mul24 = 0x17,
    Mul25 = 0x18,
    Mul26 = 0x19,
    Mul27 = 0x1a,
    Mul28 = 0x1b,
    Mul29 = 0x1c,
    Mul30 = 0x1d,
    Mul31 = 0x1e,
    Mul32 = 0x1f,
    Mul33 = 0x20,
    Mul34 = 0x21,
    Mul35 = 0x22,
    Mul36 = 0x23,
    Mul37 = 0x24,
    Mul38 = 0x25,
    Mul39 = 0x26,
    Mul40 = 0x27,
    Mul41 = 0x28,
    Mul42 = 0x29,
    Mul43 = 0x2a,
    Mul44 = 0x2b,
    Mul45 = 0x2c,
    Mul46 = 0x2d,
    Mul47 = 0x2e,
    Mul48 = 0x2f,
    Mul49 = 0x30,
    Mul50 = 0x31,
    Mul51 = 0x32,
    Mul52 = 0x33,
    Mul53 = 0x34,
    Mul54 = 0x35,
    Mul55 = 0x36,
    Mul56 = 0x37,
    Mul57 = 0x38,
    Mul58 = 0x39,
    Mul59 = 0x3a,
    Mul60 = 0x3b,
    Mul61 = 0x3c,
    Mul62 = 0x3d,
    Mul63 = 0x3e,
    Mul64 = 0x3f,
    Mul65 = 0x40,
    Mul66 = 0x41,
    Mul67 = 0x42,
    Mul68 = 0x43,
    Mul69 = 0x44,
    Mul70 = 0x45,
    Mul71 = 0x46,
    Mul72 = 0x47,
    Mul73 = 0x48,
    Mul74 = 0x49,
    Mul75 = 0x4a,
    Mul76 = 0x4b,
    Mul77 = 0x4c,
    Mul78 = 0x4d,
    Mul79 = 0x4e,
    Mul80 = 0x4f,
    Mul81 = 0x50,
    Mul82 = 0x51,
    Mul83 = 0x52,
    Mul84 = 0x53,
    Mul85 = 0x54,
    Mul86 = 0x55,
    Mul87 = 0x56,
    Mul88 = 0x57,
    Mul89 = 0x58,
    Mul90 = 0x59,
    Mul91 = 0x5a,
    Mul92 = 0x5b,
    Mul93 = 0x5c,
    Mul94 = 0x5d,
    Mul95 = 0x5e,
    Mul96 = 0x5f,
    Mul97 = 0x60,
    Mul98 = 0x61,
    Mul99 = 0x62,
    Mul100 = 0x63,
    Mul101 = 0x64,
    Mul102 = 0x65,
    Mul103 = 0x66,
    Mul104 = 0x67,
    Mul105 = 0x68,
    Mul106 = 0x69,
    Mul107 = 0x6a,
    Mul108 = 0x6b,
    Mul109 = 0x6c,
    Mul110 = 0x6d,
    Mul111 = 0x6e,
    Mul112 = 0x6f,
    Mul113 = 0x70,
    Mul114 = 0x71,
    Mul115 = 0x72,
    Mul116 = 0x73,
    Mul117 = 0x74,
    Mul118 = 0x75,
    Mul119 = 0x76,
    Mul120 = 0x77,
    Mul121 = 0x78,
    Mul122 = 0x79,
    Mul123 = 0x7a,
    Mul124 = 0x7b,
    Mul125 = 0x7c,
    Mul126 = 0x7d,
    Mul127 = 0x7e,
    Mul128 = 0x7f,
    Mul129 = 0x80,
    Mul130 = 0x81,
    Mul131 = 0x82,
    Mul132 = 0x83,
    Mul133 = 0x84,
    Mul134 = 0x85,
    Mul135 = 0x86,
    Mul136 = 0x87,
    Mul137 = 0x88,
    Mul138 = 0x89,
    Mul139 = 0x8a,
    Mul140 = 0x8b,
    Mul141 = 0x8c,
    Mul142 = 0x8d,
    Mul143 = 0x8e,
    Mul144 = 0x8f,
    Mul145 = 0x90,
    Mul146 = 0x91,
    Mul147 = 0x92,
    Mul148 = 0x93,
    Mul149 = 0x94,
    Mul150 = 0x95,
    Mul151 = 0x96,
    Mul152 = 0x97,
    Mul153 = 0x98,
    Mul154 = 0x99,
    Mul155 = 0x9a,
    Mul156 = 0x9b,
    Mul157 = 0x9c,
    Mul158 = 0x9d,
    Mul159 = 0x9e,
    Mul160 = 0x9f,
    Mul161 = 0xa0,
    Mul162 = 0xa1,
    Mul163 = 0xa2,
    Mul164 = 0xa3,
    Mul165 = 0xa4,
    Mul166 = 0xa5,
    Mul167 = 0xa6,
    Mul168 = 0xa7,
    Mul169 = 0xa8,
    Mul170 = 0xa9,
    Mul171 = 0xaa,
    Mul172 = 0xab,
    Mul173 = 0xac,
    Mul174 = 0xad,
    Mul175 = 0xae,
    Mul176 = 0xaf,
    Mul177 = 0xb0,
    Mul178 = 0xb1,
    Mul179 = 0xb2,
    Mul180 = 0xb3,
    Mul181 = 0xb4,
    Mul182 = 0xb5,
    Mul183 = 0xb6,
    Mul184 = 0xb7,
    Mul185 = 0xb8,
    Mul186 = 0xb9,
    Mul187 = 0xba,
    Mul188 = 0xbb,
    Mul189 = 0xbc,
    Mul190 = 0xbd,
    Mul191 = 0xbe,
    Mul192 = 0xbf,
    Mul193 = 0xc0,
    Mul194 = 0xc1,
    Mul195 = 0xc2,
    Mul196 = 0xc3,
    Mul197 = 0xc4,
    Mul198 = 0xc5,
    Mul199 = 0xc6,
    Mul200 = 0xc7,
    Mul201 = 0xc8,
    Mul202 = 0xc9,
    Mul203 = 0xca,
    Mul204 = 0xcb,
    Mul205 = 0xcc,
    Mul206 = 0xcd,
    Mul207 = 0xce,
    Mul208 = 0xcf,
    Mul209 = 0xd0,
    Mul210 = 0xd1,
    Mul211 = 0xd2,
    Mul212 = 0xd3,
    Mul213 = 0xd4,
    Mul214 = 0xd5,
    Mul215 = 0xd6,
    Mul216 = 0xd7,
    Mul217 = 0xd8,
    Mul218 = 0xd9,
    Mul219 = 0xda,
    Mul220 = 0xdb,
    Mul221 = 0xdc,
    Mul222 = 0xdd,
    Mul223 = 0xde,
    Mul224 = 0xdf,
    Mul225 = 0xe0,
    Mul226 = 0xe1,
    Mul227 = 0xe2,
    Mul228 = 0xe3,
    Mul229 = 0xe4,
    Mul230 = 0xe5,
    Mul231 = 0xe6,
    Mul232 = 0xe7,
    Mul233 = 0xe8,
    Mul234 = 0xe9,
    Mul235 = 0xea,
    Mul236 = 0xeb,
    Mul237 = 0xec,
    Mul238 = 0xed,
    Mul239 = 0xee,
    Mul240 = 0xef,
    Mul241 = 0xf0,
    Mul242 = 0xf1,
    Mul243 = 0xf2,
    Mul244 = 0xf3,
    Mul245 = 0xf4,
    Mul246 = 0xf5,
    Mul247 = 0xf6,
    Mul248 = 0xf7,
    Mul249 = 0xf8,
    Mul250 = 0xf9,
    Mul251 = 0xfa,
    Mul252 = 0xfb,
    Mul253 = 0xfc,
    Mul254 = 0xfd,
    Mul255 = 0xfe,
    Mul256 = 0xff,
    Mul257 = 0x100,
    Mul258 = 0x101,
    Mul259 = 0x102,
    Mul260 = 0x103,
    Mul261 = 0x104,
    Mul262 = 0x105,
    Mul263 = 0x106,
    Mul264 = 0x107,
    Mul265 = 0x108,
    Mul266 = 0x109,
    Mul267 = 0x10a,
    Mul268 = 0x10b,
    Mul269 = 0x10c,
    Mul270 = 0x10d,
    Mul271 = 0x10e,
    Mul272 = 0x10f,
    Mul273 = 0x110,
    Mul274 = 0x111,
    Mul275 = 0x112,
    Mul276 = 0x113,
    Mul277 = 0x114,
    Mul278 = 0x115,
    Mul279 = 0x116,
    Mul280 = 0x117,
    Mul281 = 0x118,
    Mul282 = 0x119,
    Mul283 = 0x11a,
    Mul284 = 0x11b,
    Mul285 = 0x11c,
    Mul286 = 0x11d,
    Mul287 = 0x11e,
    Mul288 = 0x11f,
    Mul289 = 0x120,
    Mul290 = 0x121,
    Mul291 = 0x122,
    Mul292 = 0x123,
    Mul293 = 0x124,
    Mul294 = 0x125,
    Mul295 = 0x126,
    Mul296 = 0x127,
    Mul297 = 0x128,
    Mul298 = 0x129,
    Mul299 = 0x12a,
    Mul300 = 0x12b,
    Mul301 = 0x12c,
    Mul302 = 0x12d,
    Mul303 = 0x12e,
    Mul304 = 0x12f,
    Mul305 = 0x130,
    Mul306 = 0x131,
    Mul307 = 0x132,
    Mul308 = 0x133,
    Mul309 = 0x134,
    Mul310 = 0x135,
    Mul311 = 0x136,
    Mul312 = 0x137,
    Mul313 = 0x138,
    Mul314 = 0x139,
    Mul315 = 0x13a,
    Mul316 = 0x13b,
    Mul317 = 0x13c,
    Mul318 = 0x13d,
    Mul319 = 0x13e,
    Mul320 = 0x13f,
    Mul321 = 0x140,
    Mul322 = 0x141,
    Mul323 = 0x142,
    Mul324 = 0x143,
    Mul325 = 0x144,
    Mul326 = 0x145,
    Mul327 = 0x146,
    Mul328 = 0x147,
    Mul329 = 0x148,
    Mul330 = 0x149,
    Mul331 = 0x14a,
    Mul332 = 0x14b,
    Mul333 = 0x14c,
    Mul334 = 0x14d,
    Mul335 = 0x14e,
    Mul336 = 0x14f,
    Mul337 = 0x150,
    Mul338 = 0x151,
    Mul339 = 0x152,
    Mul340 = 0x153,
    Mul341 = 0x154,
    Mul342 = 0x155,
    Mul343 = 0x156,
    Mul344 = 0x157,
    Mul345 = 0x158,
    Mul346 = 0x159,
    Mul347 = 0x15a,
    Mul348 = 0x15b,
    Mul349 = 0x15c,
    Mul350 = 0x15d,
    Mul351 = 0x15e,
    Mul352 = 0x15f,
    Mul353 = 0x160,
    Mul354 = 0x161,
    Mul355 = 0x162,
    Mul356 = 0x163,
    Mul357 = 0x164,
    Mul358 = 0x165,
    Mul359 = 0x166,
    Mul360 = 0x167,
    Mul361 = 0x168,
    Mul362 = 0x169,
    Mul363 = 0x16a,
    Mul364 = 0x16b,
    Mul365 = 0x16c,
    Mul366 = 0x16d,
    Mul367 = 0x16e,
    Mul368 = 0x16f,
    Mul369 = 0x170,
    Mul370 = 0x171,
    Mul371 = 0x172,
    Mul372 = 0x173,
    Mul373 = 0x174,
    Mul374 = 0x175,
    Mul375 = 0x176,
    Mul376 = 0x177,
    Mul377 = 0x178,
    Mul378 = 0x179,
    Mul379 = 0x17a,
    Mul380 = 0x17b,
    Mul381 = 0x17c,
    Mul382 = 0x17d,
    Mul383 = 0x17e,
    Mul384 = 0x17f,
    Mul385 = 0x180,
    Mul386 = 0x181,
    Mul387 = 0x182,
    Mul388 = 0x183,
    Mul389 = 0x184,
    Mul390 = 0x185,
    Mul391 = 0x186,
    Mul392 = 0x187,
    Mul393 = 0x188,
    Mul394 = 0x189,
    Mul395 = 0x18a,
    Mul396 = 0x18b,
    Mul397 = 0x18c,
    Mul398 = 0x18d,
    Mul399 = 0x18e,
    Mul400 = 0x18f,
    Mul401 = 0x190,
    Mul402 = 0x191,
    Mul403 = 0x192,
    Mul404 = 0x193,
    Mul405 = 0x194,
    Mul406 = 0x195,
    Mul407 = 0x196,
    Mul408 = 0x197,
    Mul409 = 0x198,
    Mul410 = 0x199,
    Mul411 = 0x19a,
    Mul412 = 0x19b,
    Mul413 = 0x19c,
    Mul414 = 0x19d,
    Mul415 = 0x19e,
    Mul416 = 0x19f,
    Mul417 = 0x1a0,
    Mul418 = 0x1a1,
    Mul419 = 0x1a2,
    Mul420 = 0x1a3,
    Mul421 = 0x1a4,
    Mul422 = 0x1a5,
    Mul423 = 0x1a6,
    Mul424 = 0x1a7,
    Mul425 = 0x1a8,
    Mul426 = 0x1a9,
    Mul427 = 0x1aa,
    Mul428 = 0x1ab,
    Mul429 = 0x1ac,
    Mul430 = 0x1ad,
    Mul431 = 0x1ae,
    Mul432 = 0x1af,
    Mul433 = 0x1b0,
    Mul434 = 0x1b1,
    Mul435 = 0x1b2,
    Mul436 = 0x1b3,
    Mul437 = 0x1b4,
    Mul438 = 0x1b5,
    Mul439 = 0x1b6,
    Mul440 = 0x1b7,
    Mul441 = 0x1b8,
    Mul442 = 0x1b9,
    Mul443 = 0x1ba,
    Mul444 = 0x1bb,
    Mul445 = 0x1bc,
    Mul446 = 0x1bd,
    Mul447 = 0x1be,
    Mul448 = 0x1bf,
    Mul449 = 0x1c0,
    Mul450 = 0x1c1,
    Mul451 = 0x1c2,
    Mul452 = 0x1c3,
    Mul453 = 0x1c4,
    Mul454 = 0x1c5,
    Mul455 = 0x1c6,
    Mul456 = 0x1c7,
    Mul457 = 0x1c8,
    Mul458 = 0x1c9,
    Mul459 = 0x1ca,
    Mul460 = 0x1cb,
    Mul461 = 0x1cc,
    Mul462 = 0x1cd,
    Mul463 = 0x1ce,
    Mul464 = 0x1cf,
    Mul465 = 0x1d0,
    Mul466 = 0x1d1,
    Mul467 = 0x1d2,
    Mul468 = 0x1d3,
    Mul469 = 0x1d4,
    Mul470 = 0x1d5,
    Mul471 = 0x1d6,
    Mul472 = 0x1d7,
    Mul473 = 0x1d8,
    Mul474 = 0x1d9,
    Mul475 = 0x1da,
    Mul476 = 0x1db,
    Mul477 = 0x1dc,
    Mul478 = 0x1dd,
    Mul479 = 0x1de,
    Mul480 = 0x1df,
    Mul481 = 0x1e0,
    Mul482 = 0x1e1,
    Mul483 = 0x1e2,
    Mul484 = 0x1e3,
    Mul485 = 0x1e4,
    Mul486 = 0x1e5,
    Mul487 = 0x1e6,
    Mul488 = 0x1e7,
    Mul489 = 0x1e8,
    Mul490 = 0x1e9,
    Mul491 = 0x1ea,
    Mul492 = 0x1eb,
    Mul493 = 0x1ec,
    Mul494 = 0x1ed,
    Mul495 = 0x1ee,
    Mul496 = 0x1ef,
    Mul497 = 0x1f0,
    Mul498 = 0x1f1,
    Mul499 = 0x1f2,
    Mul500 = 0x1f3,
    Mul501 = 0x1f4,
    Mul502 = 0x1f5,
    Mul503 = 0x1f6,
    Mul504 = 0x1f7,
    Mul505 = 0x1f8,
    Mul506 = 0x1f9,
    Mul507 = 0x1fa,
    Mul508 = 0x1fb,
    Mul509 = 0x1fc,
    Mul510 = 0x1fd,
    Mul511 = 0x1fe,
    Mul512 = 0x1ff,
    _,
};

pub const PLLRGE = enum(u2) {
    /// Frequency is between 1 and 2 MHz
    Range1 = 0x0,
    /// Frequency is between 2 and 4 MHz
    Range2 = 0x1,
    /// Frequency is between 4 and 8 MHz
    Range4 = 0x2,
    /// Frequency is between 8 and 16 MHz
    Range8 = 0x3,
};

pub const PLLSRC = enum(u2) {
    /// HSI selected as PLL clock
    HSI = 0x0,
    /// CSI selected as PLL clock
    CSI = 0x1,
    /// HSE selected as PLL clock
    HSE = 0x2,
    /// No clock sent to DIVMx dividers and PLLs
    DISABLE = 0x3,
};

pub const PLLVCOSEL = enum(u1) {
    /// VCO frequency range 192 to 836 MHz
    WideVCO = 0x0,
    /// VCO frequency range 150 to 420 MHz
    MediumVCO = 0x1,
};

pub const PPRE = enum(u3) {
    /// rcc_hclk not divided
    Div1 = 0x0,
    /// rcc_hclk divided by 2
    Div2 = 0x4,
    /// rcc_hclk divided by 4
    Div4 = 0x5,
    /// rcc_hclk divided by 8
    Div8 = 0x6,
    /// rcc_hclk divided by 16
    Div16 = 0x7,
    _,
};

pub const RNGSEL = enum(u2) {
    /// HSI48 selected as peripheral clock
    HSI48 = 0x0,
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x1,
    /// LSE selected as peripheral clock
    LSE = 0x2,
    /// LSI selected as peripheral clock
    LSI = 0x3,
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

pub const SAIASEL = enum(u3) {
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x0,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x1,
    /// pll3_p selected as peripheral clock
    PLL3_P = 0x2,
    /// i2s_ckin selected as peripheral clock
    I2S_CKIN = 0x3,
    /// PER selected as peripheral clock
    PER = 0x4,
    _,
};

pub const SAISEL = enum(u3) {
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x0,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x1,
    /// pll3_p selected as peripheral clock
    PLL3_P = 0x2,
    /// I2S_CKIN selected as peripheral clock
    I2S_CKIN = 0x3,
    /// PER selected as peripheral clock
    PER = 0x4,
    _,
};

pub const SDMMCSEL = enum(u1) {
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x0,
    /// pll2_r selected as peripheral clock
    PLL2_R = 0x1,
};

pub const SPDIFRXSEL = enum(u2) {
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x0,
    /// pll2_r selected as peripheral clock
    PLL2_R = 0x1,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
};

pub const SPI45SEL = enum(u3) {
    /// APB2 clock selected as peripheral clock
    PCLK2 = 0x0,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
    /// csi_ker selected as peripheral clock
    CSI = 0x4,
    /// HSE selected as peripheral clock
    HSE = 0x5,
    _,
};

pub const SPI6SEL = enum(u3) {
    /// rcc_pclk4 selected as peripheral clock
    PCLK4 = 0x0,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
    /// csi_ker selected as peripheral clock
    CSI = 0x4,
    /// HSE selected as peripheral clock
    HSE = 0x5,
    _,
};

pub const STOPWUCK = enum(u1) {
    /// HSI selected as wake up clock from system Stop
    HSI = 0x0,
    /// CSI selected as wake up clock from system Stop
    CSI = 0x1,
};

pub const SW = enum(u3) {
    /// HSI selected as system clock
    HSI = 0x0,
    /// CSI selected as system clock
    CSI = 0x1,
    /// HSE selected as system clock
    HSE = 0x2,
    /// PLL1 selected as system clock
    PLL1_P = 0x3,
    _,
};

pub const SWPMISEL = enum(u1) {
    /// pclk selected as peripheral clock
    PCLK1 = 0x0,
    /// hsi_ker selected as peripheral clock
    HSI = 0x1,
};

pub const TIMPRE = enum(u1) {
    /// Timer kernel clock equal to 2x pclk by default
    DefaultX2 = 0x0,
    /// Timer kernel clock equal to 4x pclk by default
    DefaultX4 = 0x1,
};

pub const USART16910SEL = enum(u3) {
    /// rcc_pclk2 selected as peripheral clock
    PCLK2 = 0x0,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
    /// csi_ker selected as peripheral clock
    CSI = 0x4,
    /// LSE selected as peripheral clock
    LSE = 0x5,
    _,
};

pub const USART234578SEL = enum(u3) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll2_q selected as peripheral clock
    PLL2_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// hsi_ker selected as peripheral clock
    HSI = 0x3,
    /// csi_ker selected as peripheral clock
    CSI = 0x4,
    /// LSE selected as peripheral clock
    LSE = 0x5,
    _,
};

pub const USBSEL = enum(u2) {
    /// Disable the kernel clock
    DISABLE = 0x0,
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x1,
    /// pll3_q selected as peripheral clock
    PLL3_Q = 0x2,
    /// HSI48 selected as peripheral clock
    HSI48 = 0x3,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Internal high-speed clock enable
        HSION: u1,
        /// High Speed Internal clock enable in Stop mode
        HSIKERON: u1,
        /// HSI clock ready flag
        HSIRDY: u1,
        /// HSI clock divider
        HSIDIV: HSIDIV,
        /// HSI divider flag
        HSIDIVF: u1,
        reserved7: u1 = 0,
        /// CSI clock enable
        CSION: u1,
        /// CSI clock ready flag
        CSIRDY: u1,
        /// CSI clock enable in Stop mode
        CSIKERON: u1,
        reserved12: u2 = 0,
        /// RC48 clock enable
        HSI48ON: u1,
        /// RC48 clock ready flag
        HSI48RDY: u1,
        /// D1 domain clocks ready flag
        D1CKRDY: u1,
        /// D2 domain clocks ready flag
        D2CKRDY: u1,
        /// HSE clock enable
        HSEON: u1,
        /// HSE clock ready flag
        HSERDY: u1,
        /// HSE clock bypass
        HSEBYP: u1,
        /// HSE Clock Security System enable
        HSECSSON: u1,
        reserved24: u4 = 0,
        /// (1/3 of PLLON) PLL1 enable
        @"PLLON[0]": u1,
        /// (1/3 of PLLRDY) PLL1 clock ready flag
        @"PLLRDY[0]": u1,
        /// (2/3 of PLLON) PLL1 enable
        @"PLLON[1]": u1,
        /// (2/3 of PLLRDY) PLL1 clock ready flag
        @"PLLRDY[1]": u1,
        /// (3/3 of PLLON) PLL1 enable
        @"PLLON[2]": u1,
        /// (3/3 of PLLRDY) PLL1 clock ready flag
        @"PLLRDY[2]": u1,
        padding: u2 = 0,
    }),
    /// RCC HSI configuration register
    /// offset: 0x04
    HSICFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration
        HSICAL: u12,
        reserved24: u12 = 0,
        /// HSI clock trimming
        HSITRIM: u7,
        padding: u1 = 0,
    }),
    /// RCC Clock Recovery RC Register
    /// offset: 0x08
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// Internal RC 48 MHz clock calibration
        HSI48CAL: u10,
        padding: u22 = 0,
    }),
    /// RCC CSI configuration register
    /// offset: 0x0c
    CSICFGR: mmio.Mmio(packed struct(u32) {
        /// CSI clock calibration
        CSICAL: u9,
        reserved24: u15 = 0,
        /// CSI clock trimming
        CSITRIM: u6,
        padding: u2 = 0,
    }),
    /// RCC Clock Configuration Register
    /// offset: 0x10
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch
        SW: SW,
        /// System clock switch status
        SWS: SW,
        /// System clock selection after a wake up from system Stop
        STOPWUCK: STOPWUCK,
        /// Kernel clock selection after a wake up from system Stop
        STOPKERWUCK: STOPWUCK,
        /// HSE division factor for RTC clock
        RTCPRE: u6,
        /// High Resolution Timer clock prescaler selection
        HRTIMSEL: HRTIMSEL,
        /// Timers clocks prescaler selection
        TIMPRE: TIMPRE,
        reserved18: u2 = 0,
        /// MCO1 prescaler
        MCO1PRE: MCOPRE,
        /// Micro-controller clock output 1
        MCO1SEL: MCO1SEL,
        /// MCO2 prescaler
        MCO2PRE: MCOPRE,
        /// Micro-controller clock output 2
        MCO2SEL: MCO2SEL,
    }),
    /// offset: 0x14
    reserved20: [4]u8,
    /// RCC Domain 1 Clock Configuration Register
    /// offset: 0x18
    D1CFGR: mmio.Mmio(packed struct(u32) {
        /// D1 domain AHB prescaler
        HPRE: HPRE,
        /// D1 domain APB3 prescaler
        D1PPRE: PPRE,
        reserved8: u1 = 0,
        /// D1 domain Core prescaler
        D1CPRE: HPRE,
        padding: u20 = 0,
    }),
    /// RCC Domain 2 Clock Configuration Register
    /// offset: 0x1c
    D2CFGR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// D2 domain APB1 prescaler
        D2PPRE1: PPRE,
        reserved8: u1 = 0,
        /// D2 domain APB2 prescaler
        D2PPRE2: PPRE,
        padding: u21 = 0,
    }),
    /// RCC Domain 3 Clock Configuration Register
    /// offset: 0x20
    D3CFGR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// D3 domain APB4 prescaler
        D3PPRE: PPRE,
        padding: u25 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// RCC PLLs Clock Source Selection Register
    /// offset: 0x28
    PLLCKSELR: mmio.Mmio(packed struct(u32) {
        /// DIVMx and PLLs clock source selection
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// (1/3 of DIVM) Prescaler for PLL1
        @"DIVM[0]": PLLM,
        reserved12: u2 = 0,
        /// (2/3 of DIVM) Prescaler for PLL1
        @"DIVM[1]": PLLM,
        reserved20: u2 = 0,
        /// (3/3 of DIVM) Prescaler for PLL1
        @"DIVM[2]": PLLM,
        padding: u6 = 0,
    }),
    /// RCC PLLs Configuration Register
    /// offset: 0x2c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of PLLFRACEN) PLL1 fractional latch enable
        @"PLLFRACEN[0]": u1,
        /// (1/3 of PLLVCOSEL) PLL1 VCO selection
        @"PLLVCOSEL[0]": PLLVCOSEL,
        /// (1/3 of PLLRGE) PLL1 input frequency range
        @"PLLRGE[0]": PLLRGE,
        /// (2/3 of PLLFRACEN) PLL1 fractional latch enable
        @"PLLFRACEN[1]": u1,
        /// (2/3 of PLLVCOSEL) PLL1 VCO selection
        @"PLLVCOSEL[1]": PLLVCOSEL,
        /// (2/3 of PLLRGE) PLL1 input frequency range
        @"PLLRGE[1]": PLLRGE,
        /// (3/3 of PLLFRACEN) PLL1 fractional latch enable
        @"PLLFRACEN[2]": u1,
        /// (3/3 of PLLVCOSEL) PLL1 VCO selection
        @"PLLVCOSEL[2]": PLLVCOSEL,
        /// (3/3 of PLLRGE) PLL1 input frequency range
        @"PLLRGE[2]": PLLRGE,
        reserved16: u4 = 0,
        /// (1/3 of DIVPEN) PLL1 DIVP divider output enable
        @"DIVPEN[0]": u1,
        /// (1/3 of DIVQEN) PLL1 DIVQ divider output enable
        @"DIVQEN[0]": u1,
        /// (1/3 of DIVREN) PLL1 DIVR divider output enable
        @"DIVREN[0]": u1,
        /// (2/3 of DIVPEN) PLL1 DIVP divider output enable
        @"DIVPEN[1]": u1,
        /// (2/3 of DIVQEN) PLL1 DIVQ divider output enable
        @"DIVQEN[1]": u1,
        /// (2/3 of DIVREN) PLL1 DIVR divider output enable
        @"DIVREN[1]": u1,
        /// (3/3 of DIVPEN) PLL1 DIVP divider output enable
        @"DIVPEN[2]": u1,
        /// (3/3 of DIVQEN) PLL1 DIVQ divider output enable
        @"DIVQEN[2]": u1,
        /// (3/3 of DIVREN) PLL1 DIVR divider output enable
        @"DIVREN[2]": u1,
        padding: u7 = 0,
    }),
    /// RCC PLL1 Dividers Configuration Register
    /// offset: 0x30
    PLLDIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1 VCO
        PLLN: PLLN,
        /// PLL DIVP division factor
        PLLP: PLLDIV,
        /// PLL DIVQ division factor
        PLLQ: PLLDIV,
        reserved24: u1 = 0,
        /// PLL DIVR division factor
        PLLR: PLLDIV,
        padding: u1 = 0,
    }),
    /// RCC PLL1 Fractional Divider Register
    /// offset: 0x34
    PLLFRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Fractional part of the multiplication factor for PLL VCO
        FRACN: u13,
        padding: u16 = 0,
    }),
    /// offset: 0x38
    reserved56: [20]u8,
    /// RCC Domain 1 Kernel Clock Configuration Register
    /// offset: 0x4c
    D1CCIPR: mmio.Mmio(packed struct(u32) {
        /// FMC kernel clock source selection
        FMCSEL: FMCSEL,
        reserved4: u2 = 0,
        /// OCTOSPI kernel clock source selection
        OCTOSPISEL: FMCSEL,
        reserved16: u10 = 0,
        /// SDMMC kernel clock source selection
        SDMMCSEL: SDMMCSEL,
        reserved28: u11 = 0,
        /// per_ck clock source selection
        PERSEL: PERSEL,
        padding: u2 = 0,
    }),
    /// RCC Domain 2 Kernel Clock Configuration Register
    /// offset: 0x50
    D2CCIP1R: mmio.Mmio(packed struct(u32) {
        /// SAI1 and DFSDM1 kernel Aclk clock source selection
        SAI1SEL: SAISEL,
        reserved6: u3 = 0,
        /// SAI2 kernel clock source A source selection
        SAI2ASEL: SAIASEL,
        /// SAI2 kernel clock source B source selection
        SAI2BSEL: SAIASEL,
        /// SPI/I2S1,2 and 3 kernel clock source selection
        SPI123SEL: SAISEL,
        reserved16: u1 = 0,
        /// SPI4 and 5 kernel clock source selection
        SPI45SEL: SPI45SEL,
        reserved20: u1 = 0,
        /// SPDIFRX kernel clock source selection
        SPDIFRXSEL: SPDIFRXSEL,
        reserved24: u2 = 0,
        /// DFSDM1 kernel Clk clock source selection
        DFSDM1SEL: DFSDMSEL,
        reserved28: u3 = 0,
        /// FDCAN kernel clock source selection
        FDCANSEL: FDCANSEL,
        reserved31: u1 = 0,
        /// SWPMI kernel clock source selection
        SWPMISEL: SWPMISEL,
    }),
    /// RCC Domain 2 Kernel Clock Configuration Register
    /// offset: 0x54
    D2CCIP2R: mmio.Mmio(packed struct(u32) {
        /// USART2/3, UART4,5, 7/8 (APB1) kernel clock source selection
        USART234578SEL: USART234578SEL,
        /// USART1, 6, 9 and 10 kernel clock source selection
        USART16910SEL: USART16910SEL,
        reserved8: u2 = 0,
        /// RNG kernel clock source selection
        RNGSEL: RNGSEL,
        reserved12: u2 = 0,
        /// I2C1,2,3 kernel clock source selection
        I2C1235SEL: I2C1235SEL,
        reserved20: u6 = 0,
        /// USBOTG 1 and 2 kernel clock source selection
        USBSEL: USBSEL,
        /// HDMI-CEC kernel clock source selection
        CECSEL: CECSEL,
        reserved28: u4 = 0,
        /// LPTIM1 kernel clock source selection
        LPTIM1SEL: LPTIM1SEL,
        padding: u1 = 0,
    }),
    /// RCC Domain 3 Kernel Clock Configuration Register
    /// offset: 0x58
    D3CCIPR: mmio.Mmio(packed struct(u32) {
        /// LPUART1 kernel clock source selection
        LPUART1SEL: LPUARTSEL,
        reserved8: u5 = 0,
        /// I2C4 kernel clock source selection
        I2C4SEL: I2C4SEL,
        /// LPTIM2 kernel clock source selection
        LPTIM2SEL: LPTIM2SEL,
        /// LPTIM3,4,5 kernel clock source selection
        LPTIM345SEL: LPTIM2SEL,
        /// SAR ADC kernel clock source selection
        ADCSEL: ADCSEL,
        reserved27: u9 = 0,
        /// DFSDM2 kernel clock source selection
        DFSDM2SEL: u1,
        /// SPI6 kernel clock source selection
        SPI6SEL: SPI6SEL,
        padding: u1 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// RCC Clock Source Interrupt Enable Register
    /// offset: 0x60
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready Interrupt Enable
        LSIRDYIE: u1,
        /// LSE ready Interrupt Enable
        LSERDYIE: u1,
        /// HSI ready Interrupt Enable
        HSIRDYIE: u1,
        /// HSE ready Interrupt Enable
        HSERDYIE: u1,
        /// CSI ready Interrupt Enable
        CSIRDYIE: u1,
        /// RC48 ready Interrupt Enable
        HSI48RDYIE: u1,
        /// (1/3 of PLLRDYIE) PLL1 ready Interrupt Enable
        @"PLLRDYIE[0]": u1,
        /// (2/3 of PLLRDYIE) PLL1 ready Interrupt Enable
        @"PLLRDYIE[1]": u1,
        /// (3/3 of PLLRDYIE) PLL1 ready Interrupt Enable
        @"PLLRDYIE[2]": u1,
        /// LSE clock security system Interrupt Enable
        LSECSSIE: u1,
        padding: u22 = 0,
    }),
    /// RCC Clock Source Interrupt Flag Register
    /// offset: 0x64
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready Interrupt Flag
        LSIRDYF: u1,
        /// LSE ready Interrupt Flag
        LSERDYF: u1,
        /// HSI ready Interrupt Flag
        HSIRDYF: u1,
        /// HSE ready Interrupt Flag
        HSERDYF: u1,
        /// CSI ready Interrupt Flag
        CSIRDYF: u1,
        /// RC48 ready Interrupt Flag
        HSI48RDYF: u1,
        /// (1/3 of PLLRDYF) PLL1 ready Interrupt Flag
        @"PLLRDYF[0]": u1,
        /// (2/3 of PLLRDYF) PLL1 ready Interrupt Flag
        @"PLLRDYF[1]": u1,
        /// (3/3 of PLLRDYF) PLL1 ready Interrupt Flag
        @"PLLRDYF[2]": u1,
        /// LSE clock security system Interrupt Flag
        LSECSSF: u1,
        /// HSE clock security system Interrupt Flag
        HSECSSF: u1,
        padding: u21 = 0,
    }),
    /// RCC Clock Source Interrupt Clear Register
    /// offset: 0x68
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready Interrupt Clear
        LSIRDYC: u1,
        /// LSE ready Interrupt Clear
        LSERDYC: u1,
        /// HSI ready Interrupt Clear
        HSIRDYC: u1,
        /// HSE ready Interrupt Clear
        HSERDYC: u1,
        /// CSI ready Interrupt Clear
        HSE_ready_Interrupt_Clear: u1,
        /// RC48 ready Interrupt Clear
        HSI48RDYC: u1,
        /// (1/3 of PLLRDYC) PLL1 ready Interrupt Clear
        @"PLLRDYC[0]": u1,
        /// (2/3 of PLLRDYC) PLL1 ready Interrupt Clear
        @"PLLRDYC[1]": u1,
        /// (3/3 of PLLRDYC) PLL1 ready Interrupt Clear
        @"PLLRDYC[2]": u1,
        /// LSE clock security system Interrupt Clear
        LSECSSC: u1,
        /// HSE clock security system Interrupt Clear
        HSECSSC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x6c
    reserved108: [4]u8,
    /// RCC Backup Domain Control Register
    /// offset: 0x70
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enabled
        LSEON: u1,
        /// LSE oscillator ready
        LSERDY: u1,
        /// LSE oscillator bypass
        LSEBYP: u1,
        /// LSE oscillator driving capability
        LSEDRV: LSEDRV,
        /// LSE clock security system enable
        LSECSSON: u1,
        /// LSE clock security system failure detection
        LSECSSD: u1,
        reserved8: u1 = 0,
        /// RTC clock source selection
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable
        RTCEN: u1,
        /// VSwitch domain software reset
        BDRST: u1,
        padding: u15 = 0,
    }),
    /// RCC Clock Control and Status Register
    /// offset: 0x74
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable
        LSION: u1,
        /// LSI oscillator ready
        LSIRDY: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x78
    reserved120: [4]u8,
    /// RCC AHB3 Reset Register
    /// offset: 0x7c
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// MDMA block reset
        MDMARST: u1,
        reserved4: u3 = 0,
        /// DMA2D block reset
        DMA2DRST: u1,
        /// JPGDEC block reset
        JPGDECRST: u1,
        reserved12: u6 = 0,
        /// FMC block reset
        FMCRST: u1,
        reserved14: u1 = 0,
        /// OCTOSPI1 and OCTOSPI1 delay block reset
        OCTOSPI1RST: u1,
        reserved16: u1 = 0,
        /// SDMMC1 and SDMMC1 delay block reset
        SDMMC1RST: u1,
        reserved19: u2 = 0,
        /// OCTOSPI2 and OCTOSPI2 delay block reset
        OCTOSPI2RST: u1,
        reserved21: u1 = 0,
        /// OCTOSPI IO manager reset
        IOMNGRRST: u1,
        /// OTFDEC1 reset
        OTFD1RST: u1,
        /// OTFDEC2 reset
        OTFD2RST: u1,
        reserved31: u7 = 0,
        /// CPU reset
        CPURST: u1,
    }),
    /// RCC AHB1 Peripheral Reset Register
    /// offset: 0x80
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 block reset
        DMA1RST: u1,
        /// DMA2 block reset
        DMA2RST: u1,
        reserved5: u3 = 0,
        /// ADC1&2 block reset
        ADC12RST: u1,
        reserved14: u8 = 0,
        /// ART block reset
        ARTRST: u1,
        /// ETH block reset
        ETHRST: u1,
        reserved25: u9 = 0,
        /// USB_OTG_HS block reset
        USB_OTG_HSRST: u1,
        reserved27: u1 = 0,
        /// USB_OTG_FS block reset
        USB_OTG_FSRST: u1,
        padding: u4 = 0,
    }),
    /// RCC AHB2 Peripheral Reset Register
    /// offset: 0x84
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
        /// DCMI block reset
        DCMIRST: u1,
        reserved4: u3 = 0,
        /// CRYPography block reset
        CRYPRST: u1,
        /// Hash block reset
        HASHRST: u1,
        /// Random Number Generator block reset
        RNGRST: u1,
        reserved9: u2 = 0,
        /// SDMMC2 and SDMMC2 Delay block reset
        SDMMC2RST: u1,
        reserved11: u1 = 0,
        /// BDMA1 block reset
        BDMA1RST: u1,
        reserved16: u4 = 0,
        /// FMAC reset
        FMACRST: u1,
        /// CORDIC reset
        CORDICRST: u1,
        padding: u14 = 0,
    }),
    /// RCC AHB4 Peripheral Reset Register
    /// offset: 0x88
    AHB4RSTR: mmio.Mmio(packed struct(u32) {
        /// GPIO block reset
        GPIOARST: u1,
        /// GPIO block reset
        GPIOBRST: u1,
        /// GPIO block reset
        GPIOCRST: u1,
        /// GPIO block reset
        GPIODRST: u1,
        /// GPIO block reset
        GPIOERST: u1,
        /// GPIO block reset
        GPIOFRST: u1,
        /// GPIO block reset
        GPIOGRST: u1,
        /// GPIO block reset
        GPIOHRST: u1,
        /// GPIO block reset
        GPIOIRST: u1,
        /// GPIO block reset
        GPIOJRST: u1,
        /// GPIO block reset
        GPIOKRST: u1,
        reserved19: u8 = 0,
        /// CRC block reset
        CRCRST: u1,
        reserved21: u1 = 0,
        /// BDMA2 block reset
        BDMA2RST: u1,
        reserved24: u2 = 0,
        /// ADC3 block reset
        ADC3RST: u1,
        /// HSEM block reset
        HSEMRST: u1,
        padding: u6 = 0,
    }),
    /// RCC APB3 Peripheral Reset Register
    /// offset: 0x8c
    APB3RSTR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// LTDC block reset
        LTDCRST: u1,
        /// DSI block reset
        DSIRST: u1,
        padding: u27 = 0,
    }),
    /// RCC APB1 Peripheral Reset Register
    /// offset: 0x90
    APB1LRSTR: mmio.Mmio(packed struct(u32) {
        /// TIM block reset
        TIM2RST: u1,
        /// TIM block reset
        TIM3RST: u1,
        /// TIM block reset
        TIM4RST: u1,
        /// TIM block reset
        TIM5RST: u1,
        /// TIM block reset
        TIM6RST: u1,
        /// TIM block reset
        TIM7RST: u1,
        /// TIM block reset
        TIM12RST: u1,
        /// TIM block reset
        TIM13RST: u1,
        /// TIM block reset
        TIM14RST: u1,
        /// TIM block reset
        LPTIM1RST: u1,
        reserved14: u4 = 0,
        /// SPI2 block reset
        SPI2RST: u1,
        /// SPI3 block reset
        SPI3RST: u1,
        /// SPDIFRX block reset
        SPDIFRXRST: u1,
        /// USART2 block reset
        USART2RST: u1,
        /// USART3 block reset
        USART3RST: u1,
        /// UART4 block reset
        UART4RST: u1,
        /// UART5 block reset
        UART5RST: u1,
        /// I2C1 block reset
        I2C1RST: u1,
        /// I2C2 block reset
        I2C2RST: u1,
        /// I2C3 block reset
        I2C3RST: u1,
        reserved25: u1 = 0,
        /// I2C5 block reset
        I2C5RST: u1,
        reserved27: u1 = 0,
        /// HDMI-CEC block reset
        CECRST: u1,
        reserved29: u1 = 0,
        /// DAC1 (containing two converters) reset
        DAC1RST: u1,
        /// UART7 block reset
        UART7RST: u1,
        /// UART8 block reset
        UART8RST: u1,
    }),
    /// RCC APB1 Peripheral Reset Register
    /// offset: 0x94
    APB1HRSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Clock Recovery System reset
        CRSRST: u1,
        /// SWPMI block reset
        SWPMIRST: u1,
        reserved4: u1 = 0,
        /// OPAMP block reset
        OPAMPRST: u1,
        /// MDIOS block reset
        MDIOSRST: u1,
        reserved8: u2 = 0,
        /// FDCAN block reset
        FDCANRST: u1,
        reserved24: u15 = 0,
        /// TIM23 block reset
        TIM23RST: u1,
        /// TIM24 block reset
        TIM24RST: u1,
        padding: u6 = 0,
    }),
    /// RCC APB2 Peripheral Reset Register
    /// offset: 0x98
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// TIM1 block reset
        TIM1RST: u1,
        /// TIM8 block reset
        TIM8RST: u1,
        reserved4: u2 = 0,
        /// USART1 block reset
        USART1RST: u1,
        /// USART6 block reset
        USART6RST: u1,
        /// UART9 block reset
        UART9RST: u1,
        /// USART10 block reset
        USART10RST: u1,
        reserved12: u4 = 0,
        /// SPI1 block reset
        SPI1RST: u1,
        /// SPI4 block reset
        SPI4RST: u1,
        reserved16: u2 = 0,
        /// TIM15 block reset
        TIM15RST: u1,
        /// TIM16 block reset
        TIM16RST: u1,
        /// TIM17 block reset
        TIM17RST: u1,
        reserved20: u1 = 0,
        /// SPI5 block reset
        SPI5RST: u1,
        reserved22: u1 = 0,
        /// SAI1 block reset
        SAI1RST: u1,
        /// SAI2 block reset
        SAI2RST: u1,
        /// SAI3 block reset
        SAI3RST: u1,
        reserved28: u3 = 0,
        /// DFSDM1 block reset
        DFSDM1RST: u1,
        /// HRTIM block reset
        HRTIMRST: u1,
        padding: u2 = 0,
    }),
    /// RCC APB4 Peripheral Reset Register
    /// offset: 0x9c
    APB4RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG block reset
        SYSCFGRST: u1,
        reserved3: u1 = 0,
        /// LPUART1 block reset
        LPUART1RST: u1,
        reserved5: u1 = 0,
        /// SPI6 block reset
        SPI6RST: u1,
        reserved7: u1 = 0,
        /// I2C4 block reset
        I2C4RST: u1,
        reserved9: u1 = 0,
        /// LPTIM2 block reset
        LPTIM2RST: u1,
        /// LPTIM3 block reset
        LPTIM3RST: u1,
        /// LPTIM4 block reset
        LPTIM4RST: u1,
        /// LPTIM5 block reset
        LPTIM5RST: u1,
        /// DAC2 (containing one converter) reset
        DAC2RST: u1,
        /// COMP12 Blocks Reset
        COMP12RST: u1,
        /// VREF block reset
        VREFRST: u1,
        reserved21: u5 = 0,
        /// SAI4 block reset
        SAI4RST: u1,
        reserved26: u4 = 0,
        /// Digital temperature sensor block reset
        DTSRST: u1,
        padding: u5 = 0,
    }),
    /// Global Control Register
    /// offset: 0xa0
    GCR: mmio.Mmio(packed struct(u32) {
        /// WWDG1 reset scope control
        WW1RSC: u1,
        padding: u31 = 0,
    }),
    /// offset: 0xa4
    reserved164: [4]u8,
    /// RCC D3 Autonomous mode Register
    /// offset: 0xa8
    D3AMR: mmio.Mmio(packed struct(u32) {
        /// BDMA2 and DMAMUX Autonomous mode enable
        BDMA2AMEN: u1,
        reserved3: u2 = 0,
        /// LPUART1 Autonomous mode enable
        LPUART1AMEN: u1,
        reserved5: u1 = 0,
        /// SPI6 Autonomous mode enable
        SPI6AMEN: u1,
        reserved7: u1 = 0,
        /// I2C4 Autonomous mode enable
        I2C4AMEN: u1,
        reserved9: u1 = 0,
        /// LPTIM2 Autonomous mode enable
        LPTIM2AMEN: u1,
        /// LPTIM3 Autonomous mode enable
        LPTIM3AMEN: u1,
        /// LPTIM4 Autonomous mode enable
        LPTIM4AMEN: u1,
        /// LPTIM5 Autonomous mode enable
        LPTIM5AMEN: u1,
        /// DAC2 (containing one converter) Autonomous mode enable
        DAC2AMEN: u1,
        /// COMP12 Autonomous mode enable
        COMP12AMEN: u1,
        /// VREF Autonomous mode enable
        VREFAMEN: u1,
        /// RTC Autonomous mode enable
        RTCAMEN: u1,
        reserved19: u2 = 0,
        /// CRC Autonomous mode enable
        CRCAMEN: u1,
        reserved21: u1 = 0,
        /// SAI4 Autonomous mode enable
        SAI4AMEN: u1,
        reserved24: u2 = 0,
        /// ADC3 Autonomous mode enable
        ADC3AMEN: u1,
        reserved26: u1 = 0,
        /// Digital temperature sensor Autonomous mode enable
        DTSAMEN: u1,
        reserved28: u1 = 0,
        /// Backup RAM Autonomous mode enable
        BKPSRAMAMEN: u1,
        /// SRAM4 Autonomous mode enable
        SRAM4AMEN: u1,
        padding: u2 = 0,
    }),
    /// offset: 0xac
    reserved172: [132]u8,
    /// RCC Reset Status Register
    /// offset: 0x130
    RSR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Remove reset flag
        RMVF: u1,
        /// CPU reset flag
        CPURSTF: u1,
        reserved19: u1 = 0,
        /// D1 domain power switch reset flag
        D1RSTF: u1,
        /// D2 domain power switch reset flag
        D2RSTF: u1,
        /// BOR reset flag
        BORRSTF: u1,
        /// Pin reset flag (NRST)
        PINRSTF: u1,
        /// POR/PDR reset flag
        PORRSTF: u1,
        /// System reset from CPU reset flag
        SFTRSTF: u1,
        reserved26: u1 = 0,
        /// Independent Watchdog reset flag
        IWDG1RSTF: u1,
        reserved28: u1 = 0,
        /// Window Watchdog reset flag
        WWDG1RSTF: u1,
        reserved30: u1 = 0,
        /// Reset due to illegal D1 DStandby or CPU CStop flag
        LPWRRSTF: u1,
        padding: u1 = 0,
    }),
    /// RCC AHB3 Clock Register
    /// offset: 0x134
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// MDMA Peripheral Clock Enable
        MDMAEN: u1,
        reserved4: u3 = 0,
        /// DMA2D Peripheral Clock Enable
        DMA2DEN: u1,
        /// JPGDEC Peripheral Clock Enable
        JPGDECEN: u1,
        reserved12: u6 = 0,
        /// FMC Peripheral Clocks Enable
        FMCEN: u1,
        reserved14: u1 = 0,
        /// OCTOSPI1 and OCTOSPI1 Delay Clock Enable
        OCTOSPI1EN: u1,
        reserved16: u1 = 0,
        /// SDMMC1 and SDMMC1 Delay Clock Enable
        SDMMC1EN: u1,
        reserved19: u2 = 0,
        /// OCTOSPI2 and OCTOSPI2 delay block enable
        OCTOSPI2EN: u1,
        reserved21: u1 = 0,
        /// OCTOSPI IO manager enable
        IOMNGREN: u1,
        /// OTFDEC1 enable
        OTFD1EN: u1,
        /// OTFDEC2 enable
        OTFD2EN: u1,
        reserved28: u4 = 0,
        /// D1 DTCM1 block enable
        DTCM1EN: u1,
        /// D1 DTCM2 block enable
        DTCM2EN: u1,
        /// D1 ITCM block enable
        ITCM1EN: u1,
        /// AXISRAM block enable
        AXISRAMEN: u1,
    }),
    /// RCC AHB1 Clock Register
    /// offset: 0x138
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 Clock Enable
        DMA1EN: u1,
        /// DMA2 Clock Enable
        DMA2EN: u1,
        reserved5: u3 = 0,
        /// ADC1/2 Peripheral Clocks Enable
        ADC12EN: u1,
        reserved14: u8 = 0,
        /// ART Clock Enable
        ARTEN: u1,
        /// Ethernet MAC bus interface Clock Enable
        ETHEN: u1,
        /// Ethernet Transmission Clock Enable
        ETHTXEN: u1,
        /// Ethernet Reception Clock Enable
        ETHRXEN: u1,
        reserved25: u7 = 0,
        /// USB_OTG_HS Peripheral Clocks Enable
        USB_OTG_HSEN: u1,
        /// USB_OTG_HS ULPI clock enable
        USB_OTG_HS_ULPIEN: u1,
        /// USB_OTG_FS Peripheral Clocks Enable
        USB_OTG_FSEN: u1,
        /// USB_OTG_FS ULPI clock enable
        USB_OTG_FS_ULPIEN: u1,
        padding: u3 = 0,
    }),
    /// RCC AHB2 Clock Register
    /// offset: 0x13c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// DCMI peripheral clock
        DCMIEN: u1,
        reserved4: u3 = 0,
        /// CRYP peripheral clock enable
        CRYPEN: u1,
        /// HASH peripheral clock enable
        HASHEN: u1,
        /// RNG peripheral clocks enable
        RNGEN: u1,
        reserved9: u2 = 0,
        /// SDMMC2 and SDMMC2 delay clock enable
        SDMMC2EN: u1,
        reserved11: u1 = 0,
        /// BDMA1 clock enable
        BDMA1EN: u1,
        reserved16: u4 = 0,
        /// FMAC enable
        FMACEN: u1,
        /// CORDIC enable
        CORDICEN: u1,
        reserved29: u11 = 0,
        /// SRAM1 block enable
        SRAM1EN: u1,
        /// SRAM2 block enable
        SRAM2EN: u1,
        /// SRAM3 block enable
        SRAM3EN: u1,
    }),
    /// RCC AHB4 Clock Register
    /// offset: 0x140
    AHB4ENR: mmio.Mmio(packed struct(u32) {
        /// 0GPIO peripheral clock enable
        GPIOAEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOBEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOCEN: u1,
        /// 0GPIO peripheral clock enable
        GPIODEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOEEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOFEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOGEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOHEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOIEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOJEN: u1,
        /// 0GPIO peripheral clock enable
        GPIOKEN: u1,
        reserved19: u8 = 0,
        /// CRC peripheral clock enable
        CRCEN: u1,
        reserved21: u1 = 0,
        /// BDMA2 and DMAMUX2 Clock Enable
        BDMA2EN: u1,
        reserved24: u2 = 0,
        /// ADC3 Peripheral Clocks Enable
        ADC3EN: u1,
        /// HSEM peripheral clock enable
        HSEMEN: u1,
        reserved28: u2 = 0,
        /// Backup RAM Clock Enable
        BKPSRAMEN: u1,
        padding: u3 = 0,
    }),
    /// RCC APB3 Clock Register
    /// offset: 0x144
    APB3ENR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// LTDC peripheral clock enable
        LTDCEN: u1,
        /// DSI Peripheral clocks enable
        DSIEN: u1,
        reserved6: u1 = 0,
        /// WWDG1 Clock Enable
        WWDG1EN: u1,
        padding: u25 = 0,
    }),
    /// RCC APB1 Clock Register
    /// offset: 0x148
    APB1LENR: mmio.Mmio(packed struct(u32) {
        /// TIM peripheral clock enable
        TIM2EN: u1,
        /// TIM peripheral clock enable
        TIM3EN: u1,
        /// TIM peripheral clock enable
        TIM4EN: u1,
        /// TIM peripheral clock enable
        TIM5EN: u1,
        /// TIM peripheral clock enable
        TIM6EN: u1,
        /// TIM peripheral clock enable
        TIM7EN: u1,
        /// TIM peripheral clock enable
        TIM12EN: u1,
        /// TIM peripheral clock enable
        TIM13EN: u1,
        /// TIM peripheral clock enable
        TIM14EN: u1,
        /// LPTIM1 Peripheral Clocks Enable
        LPTIM1EN: u1,
        reserved11: u1 = 0,
        /// WWDG2 peripheral clock enable
        WWDG2EN: u1,
        reserved14: u2 = 0,
        /// SPI2 Peripheral Clocks Enable
        SPI2EN: u1,
        /// SPI3 Peripheral Clocks Enable
        SPI3EN: u1,
        /// SPDIFRX Peripheral Clocks Enable
        SPDIFRXEN: u1,
        /// USART2 Peripheral Clocks Enable
        USART2EN: u1,
        /// USART3 Peripheral Clocks Enable
        USART3EN: u1,
        /// UART4 Peripheral Clocks Enable
        UART4EN: u1,
        /// UART5 Peripheral Clocks Enable
        UART5EN: u1,
        /// I2C1 Peripheral Clocks Enable
        I2C1EN: u1,
        /// I2C2 Peripheral Clocks Enable
        I2C2EN: u1,
        /// I2C3 Peripheral Clocks Enable
        I2C3EN: u1,
        reserved25: u1 = 0,
        /// I2C5 Peripheral Clocks Enable
        I2C5EN: u1,
        reserved27: u1 = 0,
        /// HDMI-CEC peripheral clock enable
        CECEN: u1,
        reserved29: u1 = 0,
        /// DAC1 (containing two converters) peripheral clock enable
        DAC1EN: u1,
        /// UART7 Peripheral Clocks Enable
        UART7EN: u1,
        /// UART8 Peripheral Clocks Enable
        UART8EN: u1,
    }),
    /// RCC APB1 Clock Register
    /// offset: 0x14c
    APB1HENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Clock Recovery System peripheral clock enable
        CRSEN: u1,
        /// SWPMI Peripheral Clocks Enable
        SWPMIEN: u1,
        reserved4: u1 = 0,
        /// OPAMP peripheral clock enable
        OPAMPEN: u1,
        /// MDIOS peripheral clock enable
        MDIOSEN: u1,
        reserved8: u2 = 0,
        /// FDCAN Peripheral Clocks Enable
        FDCANEN: u1,
        reserved24: u15 = 0,
        /// TIM23 block enable
        TIM23EN: u1,
        /// TIM24 block enable
        TIM24EN: u1,
        padding: u6 = 0,
    }),
    /// RCC APB2 Clock Register
    /// offset: 0x150
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 peripheral clock enable
        TIM1EN: u1,
        /// TIM8 peripheral clock enable
        TIM8EN: u1,
        reserved4: u2 = 0,
        /// USART1 Peripheral Clocks Enable
        USART1EN: u1,
        /// USART6 Peripheral Clocks Enable
        USART6EN: u1,
        /// UART9 Peripheral Clocks Enable
        UART9EN: u1,
        /// USART10 Peripheral Clocks Enable
        USART10EN: u1,
        reserved12: u4 = 0,
        /// SPI1 Peripheral Clocks Enable
        SPI1EN: u1,
        /// SPI4 Peripheral Clocks Enable
        SPI4EN: u1,
        reserved16: u2 = 0,
        /// TIM15 peripheral clock enable
        TIM15EN: u1,
        /// TIM16 peripheral clock enable
        TIM16EN: u1,
        /// TIM17 peripheral clock enable
        TIM17EN: u1,
        reserved20: u1 = 0,
        /// SPI5 Peripheral Clocks Enable
        SPI5EN: u1,
        reserved22: u1 = 0,
        /// SAI1 Peripheral Clocks Enable
        SAI1EN: u1,
        /// SAI2 Peripheral Clocks Enable
        SAI2EN: u1,
        /// SAI3 Peripheral Clocks Enable
        SAI3EN: u1,
        reserved28: u3 = 0,
        /// DFSDM1 Peripheral Clocks Enable
        DFSDM1EN: u1,
        /// HRTIM peripheral clock enable
        HRTIMEN: u1,
        padding: u2 = 0,
    }),
    /// RCC APB4 Clock Register
    /// offset: 0x154
    APB4ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG peripheral clock enable
        SYSCFGEN: u1,
        reserved3: u1 = 0,
        /// LPUART1 Peripheral Clocks Enable
        LPUART1EN: u1,
        reserved5: u1 = 0,
        /// SPI6 Peripheral Clocks Enable
        SPI6EN: u1,
        reserved7: u1 = 0,
        /// I2C4 Peripheral Clocks Enable
        I2C4EN: u1,
        reserved9: u1 = 0,
        /// LPTIM2 Peripheral Clocks Enable
        LPTIM2EN: u1,
        /// LPTIM3 Peripheral Clocks Enable
        LPTIM3EN: u1,
        /// LPTIM4 Peripheral Clocks Enable
        LPTIM4EN: u1,
        /// LPTIM5 Peripheral Clocks Enable
        LPTIM5EN: u1,
        /// DAC2 (containing one converter) peripheral clock enable
        DAC2EN: u1,
        /// COMP1/2 peripheral clock enable
        COMP12EN: u1,
        /// VREF peripheral clock enable
        VREFEN: u1,
        /// RTC APB Clock Enable
        RTCAPBEN: u1,
        reserved21: u4 = 0,
        /// SAI4 Peripheral Clocks Enable
        SAI4EN: u1,
        reserved26: u4 = 0,
        /// Digital temperature sensor block enable
        DTSEN: u1,
        padding: u5 = 0,
    }),
    /// offset: 0x158
    reserved344: [4]u8,
    /// RCC AHB3 Sleep Clock Register
    /// offset: 0x15c
    AHB3LPENR: mmio.Mmio(packed struct(u32) {
        /// MDMA Clock Enable During CSleep Mode
        MDMALPEN: u1,
        reserved4: u3 = 0,
        /// DMA2D Clock Enable During CSleep Mode
        DMA2DLPEN: u1,
        /// JPGDEC Clock Enable During CSleep Mode
        JPGDECLPEN: u1,
        reserved8: u2 = 0,
        /// FLASH Clock Enable During CSleep Mode
        FLASHLPEN: u1,
        reserved12: u3 = 0,
        /// FMC Peripheral Clocks Enable During CSleep Mode
        FMCLPEN: u1,
        reserved14: u1 = 0,
        /// OCTOSPI1 and OCTOSPI1 Delay Clock Enable During CSleep Mode
        OCTOSPI1LPEN: u1,
        reserved16: u1 = 0,
        /// SDMMC1 and SDMMC1 Delay Clock Enable During CSleep Mode
        SDMMC1LPEN: u1,
        reserved19: u2 = 0,
        /// OCTOSPI2 and OCTOSPI2 delay block enable during CSleep Mode
        OCTOSPI2LPEN: u1,
        reserved21: u1 = 0,
        /// OCTOSPI IO manager enable during CSleep Mode
        IOMNGRLPEN: u1,
        /// OTFDEC1 enable during CSleep Mode
        OTFD1LPEN: u1,
        /// OTFDEC2 enable during CSleep Mode
        OTFD2LPEN: u1,
        reserved28: u4 = 0,
        /// D1DTCM1 Block Clock Enable During CSleep mode
        D1DTCM1LPEN: u1,
        /// D1 DTCM2 Block Clock Enable During CSleep mode
        DTCM2LPEN: u1,
        /// D1ITCM Block Clock Enable During CSleep mode
        ITCMLPEN: u1,
        /// AXISRAM Block Clock Enable During CSleep mode
        AXISRAMLPEN: u1,
    }),
    /// RCC AHB1 Sleep Clock Register
    /// offset: 0x160
    AHB1LPENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 Clock Enable During CSleep Mode
        DMA1LPEN: u1,
        /// DMA2 Clock Enable During CSleep Mode
        DMA2LPEN: u1,
        reserved5: u3 = 0,
        /// ADC1/2 Peripheral Clocks Enable During CSleep Mode
        ADC12LPEN: u1,
        reserved14: u8 = 0,
        /// ART Clock Enable During CSleep Mode
        ARTLPEN: u1,
        /// Ethernet MAC bus interface Clock Enable During CSleep Mode
        ETHLPEN: u1,
        /// Ethernet Transmission Clock Enable During CSleep Mode
        ETHTXLPEN: u1,
        /// Ethernet Reception Clock Enable During CSleep Mode
        ETHRXLPEN: u1,
        reserved25: u7 = 0,
        /// USB_OTG_HS peripheral clock enable during CSleep mode
        USB_OTG_HSLPEN: u1,
        /// USB_PHY1 clock enable during CSleep mode
        USB_OTG_HS_ULPILPEN: u1,
        /// USB_OTG_FS peripheral clock enable during CSleep mode
        USB_OTG_FSLPEN: u1,
        /// USB_PHY2 clocks enable during CSleep mode
        USB_OTG_FS_ULPILPEN: u1,
        padding: u3 = 0,
    }),
    /// RCC AHB2 Sleep Clock Register
    /// offset: 0x164
    AHB2LPENR: mmio.Mmio(packed struct(u32) {
        /// DCMI peripheral clock enable during csleep mode
        DCMILPEN: u1,
        reserved4: u3 = 0,
        /// CRYP peripheral clock enable during CSleep mode
        CRYPLPEN: u1,
        /// HASH peripheral clock enable during CSleep mode
        HASHLPEN: u1,
        /// RNG peripheral clock enable during CSleep mode
        RNGLPEN: u1,
        reserved9: u2 = 0,
        /// SDMMC2 and SDMMC2 Delay Clock Enable During CSleep Mode
        SDMMC2LPEN: u1,
        reserved11: u1 = 0,
        /// BDMA1 Clock Enable During CSleep Mode
        BDMA1LPEN: u1,
        reserved16: u4 = 0,
        /// FMAC enable during CSleep Mode
        FMACLPEN: u1,
        /// CORDIC enable during CSleep Mode
        CORDICLPEN: u1,
        reserved29: u11 = 0,
        /// SRAM1 Clock Enable During CSleep Mode
        SRAM1LPEN: u1,
        /// SRAM2 Clock Enable During CSleep Mode
        SRAM2LPEN: u1,
        /// SRAM3 Clock Enable During CSleep Mode
        SRAM3LPEN: u1,
    }),
    /// RCC AHB4 Sleep Clock Register
    /// offset: 0x168
    AHB4LPENR: mmio.Mmio(packed struct(u32) {
        /// GPIO peripheral clock enable during CSleep mode
        GPIOALPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOBLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOCLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIODLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOELPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOFLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOGLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOHLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOILPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOJLPEN: u1,
        /// GPIO peripheral clock enable during CSleep mode
        GPIOKLPEN: u1,
        reserved19: u8 = 0,
        /// CRC peripheral clock enable during CSleep mode
        CRCLPEN: u1,
        reserved21: u1 = 0,
        /// BDMA2 Clock Enable During CSleep Mode
        BDMA2LPEN: u1,
        reserved24: u2 = 0,
        /// ADC3 Peripheral Clocks Enable During CSleep Mode
        ADC3LPEN: u1,
        reserved28: u3 = 0,
        /// Backup RAM Clock Enable During CSleep Mode
        BKPSRAMLPEN: u1,
        /// SRAM4 Clock Enable During CSleep Mode
        SRAM4LPEN: u1,
        padding: u2 = 0,
    }),
    /// RCC APB3 Sleep Clock Register
    /// offset: 0x16c
    APB3LPENR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// LTDC peripheral clock enable during CSleep mode
        LTDCLPEN: u1,
        /// DSI Peripheral Clock Enable During CSleep Mode
        DSILPEN: u1,
        reserved6: u1 = 0,
        /// WWDG1 Clock Enable During CSleep Mode
        WWDG1LPEN: u1,
        padding: u25 = 0,
    }),
    /// RCC APB1 Low Sleep Clock Register
    /// offset: 0x170
    APB1LLPENR: mmio.Mmio(packed struct(u32) {
        /// TIM2 peripheral clock enable during CSleep mode
        TIM2LPEN: u1,
        /// TIM3 peripheral clock enable during CSleep mode
        TIM3LPEN: u1,
        /// TIM4 peripheral clock enable during CSleep mode
        TIM4LPEN: u1,
        /// TIM5 peripheral clock enable during CSleep mode
        TIM5LPEN: u1,
        /// TIM6 peripheral clock enable during CSleep mode
        TIM6LPEN: u1,
        /// TIM7 peripheral clock enable during CSleep mode
        TIM7LPEN: u1,
        /// TIM12 peripheral clock enable during CSleep mode
        TIM12LPEN: u1,
        /// TIM13 peripheral clock enable during CSleep mode
        TIM13LPEN: u1,
        /// TIM14 peripheral clock enable during CSleep mode
        TIM14LPEN: u1,
        /// LPTIM1 Peripheral Clocks Enable During CSleep Mode
        LPTIM1LPEN: u1,
        reserved11: u1 = 0,
        /// WWDG2 peripheral Clocks Enable During CSleep Mode
        WWDG2LPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 Peripheral Clocks Enable During CSleep Mode
        SPI2LPEN: u1,
        /// SPI3 Peripheral Clocks Enable During CSleep Mode
        SPI3LPEN: u1,
        /// SPDIFRX Peripheral Clocks Enable During CSleep Mode
        SPDIFRXLPEN: u1,
        /// USART2 Peripheral Clocks Enable During CSleep Mode
        USART2LPEN: u1,
        /// USART3 Peripheral Clocks Enable During CSleep Mode
        USART3LPEN: u1,
        /// UART4 Peripheral Clocks Enable During CSleep Mode
        UART4LPEN: u1,
        /// UART5 Peripheral Clocks Enable During CSleep Mode
        UART5LPEN: u1,
        /// I2C1 Peripheral Clocks Enable During CSleep Mode
        I2C1LPEN: u1,
        /// I2C2 Peripheral Clocks Enable During CSleep Mode
        I2C2LPEN: u1,
        /// I2C3 Peripheral Clocks Enable During CSleep Mode
        I2C3LPEN: u1,
        reserved25: u1 = 0,
        /// I2C5 block enable during CSleep Mode
        I2C5LPEN: u1,
        reserved27: u1 = 0,
        /// HDMI-CEC Peripheral Clocks Enable During CSleep Mode
        CECLPEN: u1,
        reserved29: u1 = 0,
        /// DAC1 (containing two converters) peripheral clock enable during CSleep mode
        DAC1LPEN: u1,
        /// UART7 Peripheral Clocks Enable During CSleep Mode
        UART7LPEN: u1,
        /// UART8 Peripheral Clocks Enable During CSleep Mode
        UART8LPEN: u1,
    }),
    /// RCC APB1 High Sleep Clock Register
    /// offset: 0x174
    APB1HLPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Clock Recovery System peripheral clock enable during CSleep mode
        CRSLPEN: u1,
        /// SWPMI Peripheral Clocks Enable During CSleep Mode
        SWPMILPEN: u1,
        reserved4: u1 = 0,
        /// OPAMP peripheral clock enable during CSleep mode
        OPAMPLPEN: u1,
        /// MDIOS peripheral clock enable during CSleep mode
        MDIOSLPEN: u1,
        reserved8: u2 = 0,
        /// FDCAN Peripheral Clocks Enable During CSleep Mode
        FDCANLPEN: u1,
        reserved24: u15 = 0,
        /// TIM23 block enable during CSleep Mode
        TIM23LPEN: u1,
        /// TIM24 block enable during CSleep Mode
        TIM24LPEN: u1,
        padding: u6 = 0,
    }),
    /// RCC APB2 Sleep Clock Register
    /// offset: 0x178
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 peripheral clock enable during CSleep mode
        TIM1LPEN: u1,
        /// TIM8 peripheral clock enable during CSleep mode
        TIM8LPEN: u1,
        reserved4: u2 = 0,
        /// USART1 Peripheral Clocks Enable During CSleep Mode
        USART1LPEN: u1,
        /// USART6 Peripheral Clocks Enable During CSleep Mode
        USART6LPEN: u1,
        reserved12: u6 = 0,
        /// SPI1 Peripheral Clocks Enable During CSleep Mode
        SPI1LPEN: u1,
        /// SPI4 Peripheral Clocks Enable During CSleep Mode
        SPI4LPEN: u1,
        reserved16: u2 = 0,
        /// TIM15 peripheral clock enable during CSleep mode
        TIM15LPEN: u1,
        /// TIM16 peripheral clock enable during CSleep mode
        TIM16LPEN: u1,
        /// TIM17 peripheral clock enable during CSleep mode
        TIM17LPEN: u1,
        reserved20: u1 = 0,
        /// SPI5 Peripheral Clocks Enable During CSleep Mode
        SPI5LPEN: u1,
        reserved22: u1 = 0,
        /// SAI1 Peripheral Clocks Enable During CSleep Mode
        SAI1LPEN: u1,
        /// SAI2 Peripheral Clocks Enable During CSleep Mode
        SAI2LPEN: u1,
        /// SAI3 Peripheral Clocks Enable During CSleep Mode
        SAI3LPEN: u1,
        reserved28: u3 = 0,
        /// DFSDM1 Peripheral Clocks Enable During CSleep Mode
        DFSDM1LPEN: u1,
        /// HRTIM peripheral clock enable during CSleep mode
        HRTIMLPEN: u1,
        padding: u2 = 0,
    }),
    /// RCC APB4 Sleep Clock Register
    /// offset: 0x17c
    APB4LPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG peripheral clock enable during CSleep mode
        SYSCFGLPEN: u1,
        reserved3: u1 = 0,
        /// LPUART1 Peripheral Clocks Enable During CSleep Mode
        LPUART1LPEN: u1,
        reserved5: u1 = 0,
        /// SPI6 Peripheral Clocks Enable During CSleep Mode
        SPI6LPEN: u1,
        reserved7: u1 = 0,
        /// I2C4 Peripheral Clocks Enable During CSleep Mode
        I2C4LPEN: u1,
        reserved9: u1 = 0,
        /// LPTIM2 Peripheral Clocks Enable During CSleep Mode
        LPTIM2LPEN: u1,
        /// LPTIM3 Peripheral Clocks Enable During CSleep Mode
        LPTIM3LPEN: u1,
        /// LPTIM4 Peripheral Clocks Enable During CSleep Mode
        LPTIM4LPEN: u1,
        /// LPTIM5 Peripheral Clocks Enable During CSleep Mode
        LPTIM5LPEN: u1,
        /// DAC2 (containing one converter) peripheral clock enable during CSleep mode
        DAC2LPEN: u1,
        /// COMP1/2 peripheral clock enable during CSleep mode
        COMP12LPEN: u1,
        /// VREF peripheral clock enable during CSleep mode
        VREFLPEN: u1,
        /// RTC APB Clock Enable During CSleep Mode
        RTCAPBLPEN: u1,
        reserved21: u4 = 0,
        /// SAI4 Peripheral Clocks Enable During CSleep Mode
        SAI4LPEN: u1,
        reserved26: u4 = 0,
        /// Digital temperature sensor block enable during CSleep Mode
        DTSLPEN: u1,
        padding: u5 = 0,
    }),
};
