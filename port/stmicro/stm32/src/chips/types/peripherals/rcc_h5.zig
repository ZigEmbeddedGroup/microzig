const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCDACSEL = enum(u3) {
    /// rcc_hclk selected as kernel clock (default after reset)
    HCLK2 = 0x0,
    /// sys_ck selected as kernel clock
    SYS = 0x1,
    /// pll2_r_ck selected as kernel clock
    PLL2_R = 0x2,
    /// hse_ck selected as kernel clock
    HSE = 0x3,
    /// hsi_ker_ck selected as kernel clock
    HSI = 0x4,
    /// csi_ker_ck selected as kernel clock
    CSI = 0x5,
    _,
};

pub const CECSEL = enum(u2) {
    /// lse_ck selected as kernel clock (default after reset)
    LSE = 0x0,
    /// lsi_ker_ck selected as kernel clock
    LSI = 0x1,
    /// csi_ker_ck/122 selected as kernel clock
    CSI_DIV_122 = 0x2,
    _,
};

pub const DACHOLDSEL = enum(u1) {
    /// dac_hold_ck selected as kernel clock (default after reset)
    DAC_HOLD = 0x0,
    /// dac_hold_ck selected as kernel clock
    DAC_HOLD_2 = 0x1,
};

pub const FDCANSEL = enum(u2) {
    /// hse_ck selected as kernel clock (default after reset)
    HSE = 0x0,
    /// pll1_q_ck selected as kernel clock
    PLL1_Q = 0x1,
    /// pll2_q_ck selected as kernel clock
    PLL2_Q = 0x2,
    _,
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

pub const HSEEXT = enum(u1) {
    /// HSE in analog mode (default after reset)
    Analog = 0x0,
    /// HSE in digital mode
    Digital = 0x1,
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

pub const I2C34SEL = enum(u2) {
    /// rcc_pclk3 selected as peripheral clock
    PCLK3 = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// hsi_ker selected as peripheral clock
    HSI = 0x2,
    /// csi_ker selected as peripheral clock
    CSI = 0x3,
};

pub const I2CSEL = enum(u2) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// hsi_ker selected as peripheral clock
    HSI = 0x2,
    /// csi_ker selected as peripheral clock
    CSI = 0x3,
};

pub const LPTIM2SEL = enum(u3) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x1,
    /// LSE selected as peripheral clock
    LSE = 0x3,
    /// LSI selected as peripheral clock
    LSI = 0x4,
    /// PER selected as peripheral clock
    PER = 0x5,
    _,
};

pub const LPTIMSEL = enum(u3) {
    /// rcc_pclk3 selected as peripheral clock
    PCLK3 = 0x0,
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

pub const LPUSARTSEL = enum(u3) {
    /// rcc_pclk3 selected as kernel clock (default after reset)
    PCLK3 = 0x0,
    /// pll2_q_ck selected as kernel clock
    PLL2_Q = 0x1,
    /// pll3_q_ck selected as kernel clock
    PLL3_Q = 0x2,
    /// hsi_ker_ck selected as kernel clock
    HSI = 0x3,
    /// csi_ker_ck selected as kernel clock
    CSI = 0x4,
    /// lse_ck selected as kernel clock
    LSE = 0x5,
    _,
};

pub const LSCOSEL = enum(u1) {
    /// LSI clock selected
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

pub const LSEEXT = enum(u1) {
    /// LSE in analog mode (default after Backup domain reset)
    Analog = 0x0,
    /// LSE in digital mode (do not use if RTC is active).
    Digital = 0x1,
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

pub const NSPRIV = enum(u1) {
    /// Read and write to RCC non-secure functions can be done by privileged or unprivileged access.
    B_0x0 = 0x0,
    /// Read and write to RCC non-secure functions can be done by privileged access only
    B_0x1 = 0x1,
};

pub const OCTOSPISEL = enum(u2) {
    /// rcc_hclk selected as kernel clock (default after reset)
    HCLK4 = 0x0,
    /// pll1_q_ck selected as kernel clock
    PLL1_Q = 0x1,
    /// pll2_r_ck selected as kernel clock
    PLL2_R = 0x2,
    /// per_ck selected as kernel clock
    PER = 0x3,
};

pub const PERSEL = enum(u2) {
    /// hsi_ker_ck selected as kernel clock (default after reset)
    HSI = 0x0,
    /// csi_ker_ck selected as kernel clock
    CSI = 0x1,
    /// hse_ck selected as kernel clock
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
    /// no clock send to DIVMx divider and PLLs (default after reset)
    DISABLE = 0x0,
    /// HSI selected as PLL clock (hsi_ck)
    HSI = 0x1,
    /// CSI selected as PLL clock (csi_ck)
    CSI = 0x2,
    /// HSE selected as PLL clock (hse_ck)
    HSE = 0x3,
};

pub const PLLVCOSEL = enum(u1) {
    /// VCO frequency range 192 to 836 MHz
    WideVCO = 0x0,
    /// VCO frequency range 150 to 420 MHz
    MediumVCO = 0x1,
};

pub const PPRE = enum(u3) {
    /// rcc_pclk3 = rcc_hclk1 / 1
    Div1 = 0x0,
    /// rcc_pclk3 = rcc_hclk1 / 2
    Div2 = 0x4,
    /// rcc_pclk3 = rcc_hclk1 / 4
    Div4 = 0x5,
    /// rcc_pclk3 = rcc_hclk1 / 8
    Div8 = 0x6,
    /// rcc_pclk3 = rcc_hclk1 / 16
    Div16 = 0x7,
    _,
};

pub const RNGSEL = enum(u2) {
    /// hsi48_ker_ck selected as kernel clock (default after reset)
    HSI48 = 0x0,
    /// pll1_q_ck selected as kernel clock
    PLL1_Q = 0x1,
    /// lse_ck selected as kernel clock
    LSE = 0x2,
    /// lsi_ker_ck selected as kernel clock
    LSI = 0x3,
};

pub const RTCSEL = enum(u2) {
    /// no clock (default after Backup domain reset)
    DISABLE = 0x0,
    /// LSE selected as RTC clock
    LSE = 0x1,
    /// LSI selected as RTC clock
    LSI = 0x2,
    /// HSE divided by RTCPRE value selected as RTC clock
    HSE_DIV_RTCPRE = 0x3,
};

pub const SAISEL = enum(u3) {
    /// pll1_q_ck selected as kernel clock (default after reset)
    PLL1_Q = 0x0,
    /// pll2_p_ck selected as kernel clock
    PLL2_P = 0x1,
    /// pll3_p_ck selected as kernel clock
    PLL3_P = 0x2,
    /// AUDIOCLK selected as kernel clock
    AUDIOCLK = 0x3,
    /// per_ck selected as kernel clock
    PER = 0x4,
    _,
};

pub const SDMMCSEL = enum(u1) {
    /// pll1_q_ck selected as kernel clock (default after reset)
    PLL1_Q = 0x0,
    /// pll2_r_ck selected as kernel clock
    PLL2_R = 0x1,
};

pub const SPI1SEL = enum(u3) {
    /// pll1_q_ck selected as kernel clock (default after reset)
    PLL1_Q = 0x0,
    /// pll2_p_ck selected as kernel clock
    PLL2_P = 0x1,
    /// pll3_p_ck selected as kernel clock
    PLL3_P = 0x2,
    /// AUDIOCLK selected as kernel clock
    AUDIOCLK = 0x3,
    /// per_ck selected as kernel clock
    PER = 0x4,
    _,
};

pub const SPI2SEL = enum(u3) {
    /// pll1_q_ck selected as kernel clock (default after reset)
    PLL1_Q = 0x0,
    /// pll2_p_ck selected as kernel clock
    PLL2_P = 0x1,
    /// pll3_p_ck selected as kernel clock
    PLL3_P = 0x2,
    /// AUDIOCLK selected as kernel clock
    AUDIOCLK = 0x3,
    /// per_ck selected as kernel clock
    PER = 0x4,
    _,
};

pub const SPI3SEL = enum(u3) {
    /// pll1_q_ck selected as kernel clock (default after reset)
    PLL1_Q = 0x0,
    /// pll2_p_ck selected as kernel clock
    PLL2_P = 0x1,
    /// pll3_p_ck selected as kernel clock
    PLL3_P = 0x2,
    /// AUDIOCLK selected as kernel clock
    AUDIOCLK = 0x3,
    /// per_ck selected as kernel clock
    PER = 0x4,
    _,
};

pub const SPI4SEL = enum(u3) {
    /// rcc_pclk2 selected as kernel clock (default after reset)
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

pub const SPI5SEL = enum(u3) {
    /// rcc_pclk3 selected as kernel clock (default after reset)
    PCLK3 = 0x0,
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
    /// HSE selected as peripheral clock
    HSE = 0x5,
    _,
};

pub const SPRIV = enum(u1) {
    /// Read and write to RCC secure functions can be done by privileged or unprivileged access.
    Any = 0x0,
    /// Read and write to RCC secure functions can be done by privileged access only
    Privileged = 0x1,
};

pub const STOPKERWUCK = enum(u1) {
    /// HSI selected as wakeup clock from system Stop (default after reset)
    HSI = 0x0,
    /// CSI selected as wakeup clock from system Stop
    CSI = 0x1,
};

pub const STOPWUCK = enum(u1) {
    /// CSI selected as wakeup clock from system Stop
    CSI = 0x1,
    _,
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

pub const SYSTICKSEL = enum(u2) {
    /// rcc_hclk/8 selected as clock source (default after reset)
    HCLK1_DIV_8 = 0x0,
    /// lsi_ker_ck[1] selected as clock source
    LSI = 0x1,
    /// lse_ck[1] selected as clock source
    LSE = 0x2,
    _,
};

pub const TIMICSEL = enum(u1) {
    /// No internal clock available for timers input capture (default after reset)
    B_0x0 = 0x0,
    /// hsi_ker_ck/1024, hsi_ker_ck/8 and csi_ker_ck/128 selected for timers input capture
    B_0x1 = 0x1,
};

pub const TIMPRE = enum(u1) {
    /// The timers kernel clock is equal to rcc_hclk1 if PPRE1 or PPRE2 corresponds to a division by 1 or 2, else it is equal to 2 x Frcc_pclk1 or 2 x Frcc_pclk2 (default after reset)
    DefaultX2 = 0x0,
    /// The timers kernel clock is equal to 2 x Frcc_pclk1 or 2 x Frcc_pclk2 if PPRE1 or PPRE2 corresponds to a division by 1, 2 or 4, else it is equal to 4 x Frcc_pclk1 or 4 x Frcc_pclk2
    DefaultX4 = 0x1,
};

pub const USART1SEL = enum(u3) {
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

pub const USARTSEL = enum(u3) {
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

/// Reset and clock controller
pub const RCC = extern struct {
    /// RCC clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// HSI clock enable Set and cleared by software. Set by hardware to force the HSI to ON when the product leaves Stop mode, if STOPWUCK = 1 or STOPKERWUCK = 1. Set by hardware to force the HSI to ON when the product leaves Standby mode or in case of a failure of the HSE which is used as the system clock source. This bit cannot be cleared if the HSI is used directly (via SW mux) as system clock, or if the HSI is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1).
        HSION: u1,
        /// HSI clock ready flag Set by hardware to indicate that the HSI oscillator is stable.
        HSIRDY: u1,
        /// HSI clock enable in Stop mode Set and reset by software to force the HSI to ON, even in Stop mode, in order to be quickly available as kernel clock for peripherals. This bit has no effect on the value of HSION.
        HSIKERON: u1,
        /// HSI clock divider Set and reset by software. These bits allow selecting a division ratio in order to configure the wanted HSI clock frequency. The HSIDIV cannot be changed if the HSI is selected as reference clock for at least one enabled PLL (PLLxON bit set to 1). In that case, the new HSIDIV value is ignored.
        HSIDIV: HSIDIV,
        /// HSI divider flag Set and reset by hardware. As a write operation to HSIDIV has not an immediate effect on the frequency, this flag indicates the current status of the HSI divider. HSIDIVF goes immediately to 0 when HSIDIV value is changed, and is set back to 1 when the output frequency matches the value programmed into HSIDIV.
        HSIDIVF: u1,
        reserved8: u2 = 0,
        /// CSI clock enable Set and reset by software to enable/disable CSI clock for system and/or peripheral. Set by hardware to force the CSI to ON when the system leaves Stop mode, if STOPWUCK = 1 or STOPKERWUCK = 1. This bit cannot be cleared if the CSI is used directly (via SW mux) as system clock, or if the CSI is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1).
        CSION: u1,
        /// CSI clock ready flag Set by hardware to indicate that the CSI oscillator is stable. This bit is activated only if the RC is enabled by CSION (it is not activated if the CSI is enabled by CSIKERON or by a peripheral request).
        CSIRDY: u1,
        /// CSI clock enable in Stop mode Set and reset by software to force the CSI to ON, even in Stop mode, in order to be quickly available as kernel clock for some peripherals. This bit has no effect on the value of CSION.
        CSIKERON: u1,
        reserved12: u1 = 0,
        /// HSI48 clock enable Set by software and cleared by software or by the hardware when the system enters to Stop or Standby mode.
        HSI48ON: u1,
        /// HSI48 clock ready flag Set by hardware to indicate that the HSI48 oscillator is stable.
        HSI48RDY: u1,
        reserved16: u2 = 0,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE when entering Stop or Standby mode. This bit cannot be cleared if the HSE is used directly (via SW mux) as system clock, or if the HSE is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1).
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable.
        HSERDY: u1,
        /// HSE clock bypass Set and cleared by software to bypass the oscillator with an external clock. The external clock must be enabled with the HSEON bit to be used by the device. The HSEBYP bit can be written only if the HSE oscillator is disabled.
        HSEBYP: u1,
        /// HSE clock security system enable Set by software to enable clock security system on HSE. This bit is “set only” (disabled by a system reset or when the system enters in Standby mode). When HSECSSON is set, the clock detector is enabled by hardware when the HSE is ready and disabled by hardware if an oscillator failure is detected.
        HSECSSON: u1,
        /// external high speed clock type in Bypass mode Set and reset by software to select the external clock type (analog or digital). The external clock must be enabled with the HSEON bit to be used by the device. The HSEEXT bit can be written only if the HSE oscillator is disabled.
        HSEEXT: HSEEXT,
        reserved24: u3 = 0,
        /// (1/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock.
        @"PLLON[0]": u1,
        /// (1/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[0]": u1,
        /// (2/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock.
        @"PLLON[1]": u1,
        /// (2/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[1]": u1,
        /// (3/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock.
        @"PLLON[2]": u1,
        /// (3/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[2]": u1,
        padding: u2 = 0,
    }),
    /// offset: 0x04
    reserved4: [12]u8,
    /// RCC HSI calibration register
    /// offset: 0x10
    HSICFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration Set by hardware by option byte loading during system reset nreset. Adjusted by software through trimming bits HSITRIM. This field represents the sum of engineering option byte calibration value and HSITRIM bits value.
        HSICAL: u12,
        reserved16: u4 = 0,
        /// HSI clock trimming Set by software to adjust calibration. HSITRIM field is added to the engineering option bytes loaded during reset phase (FLASH_HSI_OPT) in order to form the calibration trimming value. HSICAL = HSITRIM + FLASH_HSI_OPT. After a change of HSITRIM it takes one system clock cycle before the new HSITRIM value is updated Note: The reset value of the field is 0x40.
        HSITRIM: u7,
        padding: u9 = 0,
    }),
    /// RCC clock recovery RC register
    /// offset: 0x14
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// Internal RC 48 MHz clock calibration Set by hardware by option-byte loading during system reset NRESET. Read-only.
        HSI48CAL: u10,
        padding: u22 = 0,
    }),
    /// RCC CSI calibration register
    /// offset: 0x18
    CSICFGR: mmio.Mmio(packed struct(u32) {
        /// CSI clock calibration Set by hardware by option byte loading during system reset NRESET. Adjusted by software through trimming bits CSITRIM. This field represents the sum of engineering option byte calibration value and CSITRIM bits value.
        CSICAL: u8,
        reserved16: u8 = 0,
        /// CSI clock trimming Set by software to adjust calibration. CSITRIM field is added to the engineering option bytes loaded during reset phase (FLASH_CSI_OPT) in order to form the calibration trimming value. CSICAL = CSITRIM + FLASH_CSI_OPT. Note: The reset value of the field is 0x20.
        CSITRIM: u6,
        padding: u10 = 0,
    }),
    /// RCC clock configuration register
    /// offset: 0x1c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// system clock and trace clock switch Set and reset by software to select system clock and trace clock sources (sys_ck). Set by hardware in order to: - force the selection of the HSI or CSI (depending on STOPWUCK selection) when leaving a system Stop mode - force the selection of the HSI in case of failure of the HSE when used directly or indirectly as system clock others: reserved
        SW: SW,
        /// system clock switch status Set and reset by hardware to indicate which clock source is used as system clock. 000: HSI used as system clock (hsi_ck) (default after reset). others: reserved
        SWS: SW,
        /// system clock selection after a wakeup from system Stop Set and reset by software to select the system wakeup clock from system Stop. The selected clock is also used as emergency clock for the clock security system (CSS) on HSE. 0: HSI selected as wakeup clock from system Stop (default after reset) STOPWUCK must not be modified when CSS is enabled (by HSECSSON bit) and the system clock is HSE (SWS = 10) or a switch on HSE is requested (SW =10).
        STOPWUCK: STOPWUCK,
        /// kernel clock selection after a wakeup from system Stop Set and reset by software to select the kernel wakeup clock from system Stop.
        STOPKERWUCK: STOPKERWUCK,
        /// HSE division factor for RTC clock Set and cleared by software to divide the HSE to generate a clock for RTC. Caution: The software must set these bits correctly to ensure that the clock supplied to the RTC is lower than 1 MHz. These bits must be configured if needed before selecting the RTC clock source. ...
        RTCPRE: u6,
        reserved15: u1 = 0,
        /// timers clocks prescaler selection This bit is set and reset by software to control the clock frequency of all the timers connected to APB1 and APB2 domains.
        TIMPRE: TIMPRE,
        reserved18: u2 = 0,
        /// MCO1 prescaler Set and cleared by software to configure the prescaler of the MCO1. Modification of this prescaler may generate glitches on MCO1. It is highly recommended to change this prescaler only after reset, before enabling the external oscillators and the PLLs. ...
        MCO1PRE: MCOPRE,
        /// Microcontroller clock output 1 Set and cleared by software. Clock source selection may generate glitches on MCO1. It is highly recommended to configure these bits only after reset, before enabling the external oscillators and the PLLs. others: reserved
        MCO1SEL: MCO1SEL,
        /// MCO2 prescaler Set and cleared by software to configure the prescaler of the MCO2. Modification of this prescaler may generate glitches on MCO2. It is highly recommended to change this prescaler only after reset, before enabling the external oscillators and the PLLs. ...
        MCO2PRE: MCOPRE,
        /// microcontroller clock output 2 Set and cleared by software. Clock source selection may generate glitches on MCO2. It is highly recommended to configure these bits only after reset, before enabling the external oscillators and the PLLs. others: reserved
        MCO2SEL: MCO2SEL,
    }),
    /// RCC CPU domain clock configuration register 2
    /// offset: 0x20
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// AHB prescaler Set and reset by software to control the division factor of rcc_hclk. Changing this division ratio has an impact on the frequency of all bus matrix clocks 0xxx: rcc_hclk = sys_ck (default after reset)
        HPRE: HPRE,
        /// APB low-speed prescaler (APB1) Set and reset by software to control the division factor of rcc_pclk1. The clock is divided by the new prescaler factor from 1 to 16 cycles of rcc_hclk after PPRE write. 0xx: rcc_pclk1 = rcc_hclk1 (default after reset)
        PPRE1: PPRE,
        reserved8: u1 = 0,
        /// APB high-speed prescaler (APB2) Set and reset by software to control APB high-speed clocks division factor. The clocks are divided with the new prescaler factor from 1 to 16 APB cycles after PPRE2 write. 0xx: rcc_pclk2 = rcc_hclk1
        PPRE2: PPRE,
        reserved12: u1 = 0,
        /// APB low-speed prescaler (APB3) Set and reset by software to control APB low-speed clocks division factor. The clocks are divided with the new prescaler factor from 1 to 16 APB cycles after PPRE3 write. 0xx: rcc_pclk3 = rcc_hclk1
        PPRE3: PPRE,
        reserved16: u1 = 0,
        /// AHB1 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB1 peripherals from RCC_AHB1ENR are used and when their clocks are disabled in RCC_AHB1ENR. When this bit is set, all the AHB1 peripherals clocks from RCC_AHB1ENR are off. enable control bits
        AHB1DIS: u1,
        /// AHB2 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB2 peripherals from RCC_AHB2ENR are used and when their clocks are disabled in RCC_AHB2ENR. When this bit is set, all the AHB2 peripherals clocks from RCC_AHB2ENR are off. enable control bits
        AHB2DIS: u1,
        reserved19: u1 = 0,
        /// AHB4 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB4 peripherals from RCC_AHB4ENR are used and when their clocks are disabled in RCC_AHB4ENR. When this bit is set, all the AHB4 peripherals clocks from RCC_AHB4ENR are off. enable control bits
        AHB4DIS: u1,
        /// APB1 clock disable value This bit can be set in order to further reduce power consumption, when none of the APB1 peripherals (except IWDG) are used and when their clocks are disabled in RCC_APB1ENR. When this bit is set, all the APB1 peripherals clocks are off, except for IWDG. control bits
        APB1DIS: u1,
        /// APB2 clock disable value This bit can be set in order to further reduce power consumption, when none of the APB2 peripherals are used and when their clocks are disabled in RCC_APB2ENR. When this bit is set, all the APB2 peripherals clocks are off. control bits
        APB2DIS: u1,
        /// APB3 clock disable value.Set and cleared by software This bit can be set in order to further reduce power consumption, when none of the APB3 peripherals are used and when their clocks are disabled in RCC_APB3ENR. When this bit is set, all the APB3 peripherals clocks are off. control bits
        APB3DIS: u1,
        padding: u9 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// RCC PLL clock source selection register
    /// offset: 0x28
    PLLCFGR: [3]mmio.Mmio(packed struct(u32) {
        /// DIVMx and PLLs clock source selection Set and reset by software to select the PLL clock source. These bits can be written only when all PLLs are disabled. In order to save power, when no PLL is used, the value of PLL1SRC must be set to '00'. 00: no clock send to DIVMx divider and PLLs (default after reset).
        PLLSRC: PLLSRC,
        /// PLL1 input frequency range Set and reset by software to select the proper reference frequency range used for PLL1. This bit must be written before enabling the PLL1.
        PLLRGE: PLLRGE,
        /// PLL1 fractional latch enable Set and reset by software to latch the content of FRACN1 into the sigma-delta modulator. In order to latch the FRACN1 value into the sigma-delta modulator, PLL1FRACEN must be set to 0, then set to 1. The transition 0 to 1 transfers the content of FRACN1 into the modulator.
        PLLFRACEN: u1,
        /// PLL1 VCO selection Set and reset by software to select the proper VCO frequency range used for PLL1. This bit must be written before enabling the PLL1.
        PLLVCOSEL: PLLVCOSEL,
        reserved8: u2 = 0,
        /// prescaler for PLL1 Set and cleared by software to configure the prescaler of the PLL1. The hardware does not allow any modification of this prescaler when PLL1 is enabled (PLL1ON = 1 or PLL1RDY = 1). In order to save power when PLL1 is not used, the value of DIVM1 must be set to 0. ... ...
        DIVM: PLLM,
        reserved16: u2 = 0,
        /// PLL1 DIVP divider output enable Set and reset by software to enable the pll1_p_ck output of the PLL1. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). In order to save power, when the pll1_p_ck output of the PLL1 is not used, the pll1_p_ck must be disabled.
        PLLPEN: u1,
        /// PLL1 DIVQ divider output enable Set and reset by software to enable the pll1_q_ck output of the PLL1. In order to save power, when the pll1_q_ck output of the PLL1 is not used, the pll1_q_ck must be disabled. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
        PLLQEN: u1,
        /// PLL1 DIVR divider output enable Set and reset by software to enable the pll1_r_ck output of the PLL1. To save power, DIVR1EN and DIVR1 bits must be set to 0 when the pll1_r_ck is not used. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
        PLLREN: u1,
        padding: u13 = 0,
    }),
    /// RCC PLL1 dividers register
    /// offset: 0x34
    PLLDIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL is disabled (PLL1ON = 0 and PLL1RDY = 0). ... ... Others: reserved
        PLLN: PLLN,
        /// PLL1 DIVP division factor Set and reset by software to control the frequency of the pll1_p_ck clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). Note that odd division factors are not allowed. ...
        PLLP: PLLDIV,
        /// PLL1 DIVQ division factor Set and reset by software to control the frequency of the pll1_q_ck clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ...
        PLLQ: PLLDIV,
        reserved24: u1 = 0,
        /// PLL1 DIVR division factor Set and reset by software to control the frequency of the pll1_r_ck clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ...
        PLLR: PLLDIV,
        padding: u1 = 0,
    }),
    /// RCC PLL1 fractional divider register
    /// offset: 0x38
    PLLFRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. The software must set correctly these bits to insure that the VCO output frequency is between its valid frequency range, that is: * 128 to 560 MHz if PLL1VCOSEL = 0 * 150 to 420 MHz if PLL1VCOSEL = 1 VCO output frequency = Fref1_ck x (PLL1N + (PLL1FRACN / 213)), with * PLL1N between 8 and 420 * PLL1FRACN can be between 0 and 213- 1 * The input frequency Fref1_ck must be between 1 and 16 MHz. To change the PLL1FRACN value on-the-fly even if the PLL is enabled, the application must proceed as follows: * Set the bit PLL1FRACEN to 0 * Write the new fractional value into PLL1FRACN * Set the bit PLL1FRACEN to 1
        PLLFRACN: u13,
        padding: u16 = 0,
    }),
    /// offset: 0x3c
    reserved60: [20]u8,
    /// RCC clock source interrupt enable register
    /// offset: 0x50
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the LSI oscillator stabilization.
        LSIRDYIE: u1,
        /// LSE ready interrupt enable Set and reset by software to enable/disable interrupt caused by the LSE oscillator stabilization.
        LSERDYIE: u1,
        /// CSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the CSI oscillator stabilization.
        CSIRDYIE: u1,
        /// HSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSI oscillator stabilization.
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSE oscillator stabilization.
        HSERDYIE: u1,
        /// HSI48 ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSI48 oscillator stabilization.
        HSI48RDYIE: u1,
        /// (1/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[0]": u1,
        /// (2/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[1]": u1,
        /// (3/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[2]": u1,
        padding: u23 = 0,
    }),
    /// RCC clock source interrupt flag register
    /// offset: 0x54
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag Reset by software by writing LSIRDYC bit. Set by hardware when the LSI clock becomes stable and LSIRDYIE is set.
        LSIRDYF: u1,
        /// LSE ready interrupt flag Reset by software by writing LSERDYC bit. Set by hardware when the LSE clock becomes stable and LSERDYIE is set.
        LSERDYF: u1,
        /// CSI ready interrupt flag Reset by software by writing CSIRDYC bit. Set by hardware when the CSI clock becomes stable and CSIRDYIE is set.
        CSIRDYF: u1,
        /// HSI ready interrupt flag Reset by software by writing HSIRDYC bit. Set by hardware when the HSI clock becomes stable and HSIRDYIE is set.
        HSIRDYF: u1,
        /// HSE ready interrupt flag Reset by software by writing HSERDYC bit. Set by hardware when the HSE clock becomes stable and HSERDYIE is set.
        HSERDYF: u1,
        /// HSI48 ready interrupt flag Reset by software by writing HSI48RDYC bit. Set by hardware when the HSI48 clock becomes stable and HSI48RDYIE is set.
        HSI48RDYF: u1,
        /// (1/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[0]": u1,
        /// (2/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[1]": u1,
        /// (3/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[2]": u1,
        reserved10: u1 = 0,
        /// HSE clock security system interrupt flag Reset by software by writing HSECSSC bit. Set by hardware in case of HSE clock failure.
        HSECSSF: u1,
        padding: u21 = 0,
    }),
    /// RCC clock source interrupt clear register
    /// offset: 0x58
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear Set by software to clear LSIRDYF. Reset by hardware when clear done.
        LSIRDYC: u1,
        /// LSE ready interrupt clear Set by software to clear LSERDYF. Reset by hardware when clear done.
        LSERDYC: u1,
        /// HSI ready interrupt clear Set by software to clear CSIRDYF. Reset by hardware when clear done.
        CSIRDYC: u1,
        /// HSI ready interrupt clear Set by software to clear HSIRDYF. Reset by hardware when clear done.
        HSIRDYC: u1,
        /// HSE ready interrupt clear Set by software to clear HSERDYF. Reset by hardware when clear done.
        HSERDYC: u1,
        /// HSI48 ready interrupt clear Set by software to clear HSI48RDYF. Reset by hardware when clear done.
        HSI48RDYC: u1,
        /// (1/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[0]": u1,
        /// (2/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[1]": u1,
        /// (3/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[2]": u1,
        reserved10: u1 = 0,
        /// HSE clock security system interrupt clear Set by software to clear HSECSSF. Reset by hardware when clear done.
        HSECSSC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// RCC AHB1 reset register
    /// offset: 0x60
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 block reset Set and reset by software.
        GPDMA1RST: u1,
        /// GPDMA2 block reset Set and reset by software.
        GPDMA2RST: u1,
        reserved12: u10 = 0,
        /// CRC block reset Set and reset by software.
        CRCRST: u1,
        reserved14: u1 = 0,
        /// CORDIC block reset Set and reset by software.
        CORDICRST: u1,
        /// FMAC block reset Set and reset by software.
        FMACRST: u1,
        reserved17: u1 = 0,
        /// RAMCFG block reset Set and reset by software.
        RAMCFGRST: u1,
        reserved19: u1 = 0,
        /// ETH1 block reset Set and reset by software
        ETHRST: u1,
        reserved24: u4 = 0,
        /// TZSC1 reset Set and reset by software
        TZSC1RST: u1,
        padding: u7 = 0,
    }),
    /// RCC AHB2 peripheral reset register
    /// offset: 0x64
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
        /// GPIOA block reset Set and reset by software.
        GPIOARST: u1,
        /// GPIOB block reset Set and reset by software.
        GPIOBRST: u1,
        /// GPIOC block reset Set and reset by software.
        GPIOCRST: u1,
        /// GPIOD block reset Set and reset by software.
        GPIODRST: u1,
        /// GPIOE block reset Set and reset by software.
        GPIOERST: u1,
        /// GPIOF block reset Set and reset by software.
        GPIOFRST: u1,
        /// GPIOG block reset Set and reset by software.
        GPIOGRST: u1,
        /// GPIOH block reset Set and reset by software.
        GPIOHRST: u1,
        /// GPIOI block reset Set and reset by software.
        GPIOIRST: u1,
        reserved10: u1 = 0,
        /// ADC1 and 2 blocks reset Set and reset by software.
        ADC12RST: u1,
        /// DAC block reset Set and reset by software.
        DAC1RST: u1,
        /// digital camera interface block reset (DCMI or PSSI depending which interface is active) Set and reset by software.
        DCMI_PSSIRST: u1,
        reserved16: u3 = 0,
        /// AES block reset Set and reset by software.
        AESRST: u1,
        /// HASH block reset Set and reset by software.
        HASHRST: u1,
        /// RNG block reset Set and reset by software.
        RNGRST: u1,
        /// PKA block reset Set and reset by software.
        PKARST: u1,
        /// SAES block reset Set and reset by software.
        SAESRST: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x68
    reserved104: [4]u8,
    /// RCC AHB4 peripheral reset register
    /// offset: 0x6c
    AHB4RSTR: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// OTFDEC1 block reset Set and reset by software.
        OTFDEC1RST: u1,
        reserved11: u3 = 0,
        /// SDMMC1 and SDMMC1 delay blocks reset Set and reset by software.
        SDMMC1RST: u1,
        /// SDMMC2 and SDMMC2 delay blocks reset Set and reset by software.
        SDMMC2RST: u1,
        reserved16: u3 = 0,
        /// FMC block reset Set and reset by software.
        FMCRST: u1,
        reserved20: u3 = 0,
        /// OCTOSPI1 block reset Set and reset by software.
        OCTOSPI1RST: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x70
    reserved112: [4]u8,
    /// RCC APB1 peripheral low reset register
    /// offset: 0x74
    APB1LRSTR: mmio.Mmio(packed struct(u32) {
        /// TIM2 block reset Set and reset by software.
        TIM2RST: u1,
        /// TIM3 block reset Set and reset by software.
        TIM3RST: u1,
        /// TIM4 block reset Set and reset by software.
        TIM4RST: u1,
        /// TIM5 block reset Set and reset by software.
        TIM5RST: u1,
        /// TIM6 block reset Set and reset by software.
        TIM6RST: u1,
        /// TIM7 block reset Set and reset by software.
        TIM7RST: u1,
        /// TIM12 block reset Set and reset by software.
        TIM12RST: u1,
        /// TIM13 block reset t Set and reset by software.
        TIM13RST: u1,
        /// TIM14 block reset Set and reset by software.
        TIM14RST: u1,
        reserved14: u5 = 0,
        /// SPI2 block reset Set and reset by software.
        SPI2RST: u1,
        /// SPI3 block reset Set and reset by software.
        SPI3RST: u1,
        reserved17: u1 = 0,
        /// USART2 block reset Set and reset by software.
        USART2RST: u1,
        /// USART3 block reset Set and reset by software.
        USART3RST: u1,
        /// UART4 block reset Set and reset by software.
        UART4RST: u1,
        /// UART5 block reset Set and reset by software.
        UART5RST: u1,
        /// I2C1 block reset Set and reset by software.
        I2C1RST: u1,
        /// I2C2 block reset Set and reset by software.
        I2C2RST: u1,
        /// I3C1 block reset Set and reset by software.
        I3C1RST: u1,
        /// CRS block reset Set and reset by software.
        CRSRST: u1,
        /// USART6 block reset Set and reset by software.
        USART6RST: u1,
        /// USART10 block reset Set and reset by software.
        USART10RST: u1,
        /// USART11 block reset Set and reset by software.
        USART11RST: u1,
        /// HDMI-CEC block reset Set and reset by software.
        CECRST: u1,
        reserved30: u1 = 0,
        /// UART7 block reset Set and reset by software.
        UART7RST: u1,
        /// UART8 block reset Set and reset by software.
        UART8RST: u1,
    }),
    /// RCC APB1 peripheral high reset register
    /// offset: 0x78
    APB1HRSTR: mmio.Mmio(packed struct(u32) {
        /// UART9 block reset Set and reset by software.
        UART9RST: u1,
        /// UART12 block reset Set and reset by software.
        UART12RST: u1,
        reserved3: u1 = 0,
        /// DTS block reset Set and reset by software.
        DTSRST: u1,
        reserved5: u1 = 0,
        /// LPTIM2 block reset Set and reset by software.
        LPTIM2RST: u1,
        reserved9: u3 = 0,
        /// FDCAN1 and FDCAN2 blocks reset Set and reset by software.
        FDCAN12RST: u1,
        reserved23: u13 = 0,
        /// UCPD block reset Set and reset by software.
        UCPDRST: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 peripheral reset register
    /// offset: 0x7c
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 block reset Set and reset by software.
        TIM1RST: u1,
        /// SPI1 block reset Set and reset by software.
        SPI1RST: u1,
        /// TIM8 block reset Set and reset by software.
        TIM8RST: u1,
        /// USART1 block reset Set and reset by software.
        USART1RST: u1,
        reserved16: u1 = 0,
        /// TIM15 block reset Set and reset by software.
        TIM15RST: u1,
        /// TIM16 block reset Set and reset by software.
        TIM16RST: u1,
        /// TIM17 block reset Set and reset by software.
        TIM17RST: u1,
        /// SPI4 block reset Set and reset by software.
        SPI4RST: u1,
        /// SPI6 block reset Set and reset by software.
        SPI6RST: u1,
        /// SAI1 block reset Set and reset by software.
        SAI1RST: u1,
        /// SAI2 block reset Set and reset by software.
        SAI2RST: u1,
        reserved24: u1 = 0,
        /// USB block reset Set and reset by software.
        USBRST: u1,
        padding: u7 = 0,
    }),
    /// RCC APB3 peripheral reset register
    /// offset: 0x80
    APB3RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS block reset Set and reset by software.
        SYSCFGRST: u1,
        reserved5: u3 = 0,
        /// SPI5 block reset Set and reset by software.
        SPI5RST: u1,
        /// LPUART1 block reset Set and reset by software.
        LPUART1RST: u1,
        /// I2C3 block reset Set and reset by software.
        I2C3RST: u1,
        /// I2C4 block reset Set and reset by software.
        I2C4RST: u1,
        reserved11: u2 = 0,
        /// LPTIM1 block reset Set and reset by software.
        LPTIM1RST: u1,
        /// LPTIM3 block reset Set and reset by software.
        LPTIM3RST: u1,
        /// LPTIM4 block reset Set and reset by software.
        LPTIM4RST: u1,
        /// LPTIM5 block reset Set and reset by software.
        LPTIM5RST: u1,
        /// LPTIM6 block reset Set and reset by software.
        LPTIM6RST: u1,
        reserved20: u4 = 0,
        /// VREF block reset Set and reset by software.
        VREFRST: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// RCC AHB1 peripherals clock register
    /// offset: 0x88
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 clock enable Set and reset by software.
        GPDMA1EN: u1,
        /// GPDMA2 clock enable Set and reset by software.
        GPDMA2EN: u1,
        reserved8: u6 = 0,
        /// Flash interface clock enable Set and reset by software.
        FLITFEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable Set and reset by software.
        CRCEN: u1,
        reserved14: u1 = 0,
        /// CORDIC clock enable Set and reset by software.
        CORDICEN: u1,
        /// FMAC clock enable Set and reset by software.
        FMACEN: u1,
        reserved17: u1 = 0,
        /// RAMCFG clock enable Set and reset by software.
        RAMCFGEN: u1,
        reserved19: u1 = 0,
        /// ETH clock enable Set and reset by software
        ETHEN: u1,
        /// ETHTX clock enable Set and reset by software
        ETHTXEN: u1,
        /// ETHRX clock enable Set and reset by software
        ETHRXEN: u1,
        reserved24: u2 = 0,
        /// TZSC1 clock enable Set and reset by software
        TZSC1EN: u1,
        reserved28: u3 = 0,
        /// BKPRAM clock enable Set and reset by software
        BKPRAMEN: u1,
        reserved30: u1 = 0,
        /// DCACHE clock enable Set and reset by software
        DCACHEEN: u1,
        /// SRAM1 clock enable Set and reset by software.
        SRAM1EN: u1,
    }),
    /// RCC AHB2 peripheral clock register
    /// offset: 0x8c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// GPIOA clock enable Set and reset by software.
        GPIOAEN: u1,
        /// GPIOB clock enable Set and reset by software.
        GPIOBEN: u1,
        /// GPIOC clock enable Set and reset by software.
        GPIOCEN: u1,
        /// GPIOD clock enable Set and reset by software.
        GPIODEN: u1,
        /// GPIOE clock enable Set and reset by software.
        GPIOEEN: u1,
        /// GPIOF clock enable Set and reset by software.
        GPIOFEN: u1,
        /// GPIOG clock enable Set and reset by software.
        GPIOGEN: u1,
        /// GPIOH clock enable Set and reset by software.
        GPIOHEN: u1,
        /// GPIOI clock enable Set and reset by software.
        GPIOIEN: u1,
        reserved10: u1 = 0,
        /// ADC1 and 2 peripherals clock enabled Set and reset by software.
        ADC12EN: u1,
        /// DAC clock enable Set and reset by software.
        DAC1EN: u1,
        /// digital camera interface clock enable (DCMI or PSSI depending which interface is active) Set and reset by software.
        DCMI_PSSIEN: u1,
        reserved16: u3 = 0,
        /// AES clock enable Set and reset by software.
        AESEN: u1,
        /// HASH clock enable Set and reset by software.
        HASHEN: u1,
        /// RNG clock enable Set and reset by software.
        RNGEN: u1,
        /// PKA clock enable Set and reset by software.
        PKAEN: u1,
        /// SAES clock enable Set and reset by software.
        SAESEN: u1,
        reserved30: u9 = 0,
        /// SRAM3 clock enable Set and reset by software.
        SRAM3EN: u1,
        /// SRAM2 clock enable Set and reset by software.
        SRAM2EN: u1,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// RCC AHB4 peripheral clock register
    /// offset: 0x94
    AHB4ENR: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// OTFDEC1 clock enable Set and reset by software.
        OTFDEC1EN: u1,
        reserved11: u3 = 0,
        /// SDMMC1 and SDMMC1 delay peripheral clock enable reset
        SDMMC1EN: u1,
        /// SDMMC2 and SDMMC2 delay peripheral clock enabled Set and reset by software.
        SDMMC2EN: u1,
        reserved16: u3 = 0,
        /// FMC clock enable Set and reset by software.
        FMCEN: u1,
        reserved20: u3 = 0,
        /// OCTOSPI1 clock enable Set and reset by software.
        OCTOSPI1EN: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x98
    reserved152: [4]u8,
    /// RCC APB1 peripheral clock register
    /// offset: 0x9c
    APB1LENR: mmio.Mmio(packed struct(u32) {
        /// TIM2 clock enable Set and reset by software.
        TIM2EN: u1,
        /// TIM3 clock enable Set and reset by software.
        TIM3EN: u1,
        /// TIM4 clock enable Set and reset by software.
        TIM4EN: u1,
        /// TIM5 clock enable Set and reset by software.
        TIM5EN: u1,
        /// TIM6 clock enable Set and reset by software.
        TIM6EN: u1,
        /// TIM7 clock enable Set and reset by software.
        TIM7EN: u1,
        /// TIM12 clock enable Set and reset by software.
        TIM12EN: u1,
        /// TIM13 clock enable Set and reset by software.
        TIM13EN: u1,
        /// TIM14 clock enable Set and reset by software.
        TIM14EN: u1,
        reserved11: u2 = 0,
        /// WWDG clock enable Set and reset by software.
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable Set and reset by software.
        SPI2EN: u1,
        /// SPI3 clock enable Set and reset by software.
        SPI3EN: u1,
        reserved17: u1 = 0,
        /// USART2 clock enable Set and reset by software.
        USART2EN: u1,
        /// USART3 clock enable Set and reset by software.
        USART3EN: u1,
        /// UART4 clock enable Set and reset by software.
        UART4EN: u1,
        /// UART5 clock enable Set and reset by software.
        UART5EN: u1,
        /// I2C1 clock enable Set and reset by software.
        I2C1EN: u1,
        /// I2C2 clock enable Set and reset by software.
        I2C2EN: u1,
        /// I3C1 clock enable Set and reset by software.
        I3C1EN: u1,
        /// CRS clock enable Set and reset by software.
        CRSEN: u1,
        /// USART6 clock enable Set and reset by software.
        USART6EN: u1,
        /// USART10 clock enable Set and reset by software.
        USART10EN: u1,
        /// USART11 clock enable
        USART11EN: u1,
        /// HDMI-CEC clock enable Set and reset by software.
        CECEN: u1,
        reserved30: u1 = 0,
        /// UART7 clock enable Set and reset by software.
        UART7EN: u1,
        /// UART8 clock enable Set and reset by software.
        UART8EN: u1,
    }),
    /// RCC APB1 peripheral clock register
    /// offset: 0xa0
    APB1HENR: mmio.Mmio(packed struct(u32) {
        /// UART9 clock enable Set and reset by software.
        UART9EN: u1,
        /// UART12 clock enable Set and reset by software.
        UART12EN: u1,
        reserved3: u1 = 0,
        /// DTS clock enable Set and reset by software.
        DTSEN: u1,
        reserved5: u1 = 0,
        /// LPTIM2 clock enable Set and reset by software.
        LPTIM2EN: u1,
        reserved9: u3 = 0,
        /// FDCAN1 and FDCAN2 peripheral clock enable Set and reset by software.
        FDCAN12EN: u1,
        reserved23: u13 = 0,
        /// UCPD clock enable Set and reset by software.
        UCPDEN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 peripheral clock register
    /// offset: 0xa4
    APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 clock enable Set and reset by software.
        TIM1EN: u1,
        /// SPI1 clock enable Set and reset by software.
        SPI1EN: u1,
        /// TIM8 clock enable Set and reset by software.
        TIM8EN: u1,
        /// USART1 clock enable Set and reset by software.
        USART1EN: u1,
        reserved16: u1 = 0,
        /// TIM15 clock enable Set and reset by software.
        TIM15EN: u1,
        /// TIM16 clock enable Set and reset by software.
        TIM16EN: u1,
        /// TIM17 clock enable Set and reset by software.
        TIM17EN: u1,
        /// SPI4 clock enable Set and reset by software.
        SPI4EN: u1,
        /// SPI6 clock enable Set and reset by software.
        SPI6EN: u1,
        /// SAI1 clock enable Set and reset by software.
        SAI1EN: u1,
        /// SAI2 clock enable Set and cleared by software.
        SAI2EN: u1,
        reserved24: u1 = 0,
        /// USB clock enable Set and reset by software.
        USBEN: u1,
        padding: u7 = 0,
    }),
    /// RCC APB3 peripheral clock register
    /// offset: 0xa8
    APB3ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS clock enable Set and reset by software.
        SYSCFGEN: u1,
        reserved5: u3 = 0,
        /// SPI5 clock enable Set and reset by software.
        SPI5EN: u1,
        /// LPUART1 clock enable Set and reset by software.
        LPUART1EN: u1,
        /// I2C3 clock enable Set and reset by software.
        I2C3EN: u1,
        /// I2C4 clock enable Set and reset by software.
        I2C4EN: u1,
        reserved11: u2 = 0,
        /// LPTIM1 clock enable Set and reset by software.
        LPTIM1EN: u1,
        /// LPTIM3 clock enable Set and reset by software.
        LPTIM3EN: u1,
        /// LPTIM4 clock enable Set and reset by software.
        LPTIM4EN: u1,
        /// LPTIM5 clock enable Set and reset by software.
        LPTIM5EN: u1,
        /// LPTIM6 clock enable Set and reset by software.
        LPTIM6EN: u1,
        reserved20: u4 = 0,
        /// VREF clock enable Set and reset by software.
        VREFEN: u1,
        /// RTC APB interface clock enable Set and reset by software.
        RTCAPBEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xac
    reserved172: [4]u8,
    /// RCC AHB1 sleep clock register
    /// offset: 0xb0
    AHB1LPENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 clock enable during sleep mode Set and reset by software.
        GPDMA1LPEN: u1,
        /// GPDMA2 clock enable during sleep mode Set and reset by software.
        GPDMA2LPEN: u1,
        reserved8: u6 = 0,
        /// Flash interface (FLITF) clock enable during sleep mode Set and reset by software.
        FLITFLPEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable during sleep mode Set and reset by software.
        CRCLPEN: u1,
        reserved14: u1 = 0,
        /// CORDIC clock enable during sleep mode Set and reset by software.
        CORDICLPEN: u1,
        /// FMAC clock enable during sleep mode Set and reset by software.
        FMACLPEN: u1,
        reserved17: u1 = 0,
        /// RAMCFG clock enable during sleep mode Set and reset by software.
        RAMCFGLPEN: u1,
        reserved19: u1 = 0,
        /// ETH clock enable during Sleep mode Set and reset by software
        ETHLPEN: u1,
        /// ETHTX clock enable during sleep mode Set and reset by software
        ETHTXLPEN: u1,
        /// ETHRX clock enable during sleep mode Set and reset by software
        ETHRXLPEN: u1,
        reserved24: u2 = 0,
        /// TZSC1 clock enable during sleep mode Set and reset by software
        TZSC1LPEN: u1,
        reserved28: u3 = 0,
        /// BKPRAM clock enable during sleep mode Set and reset by software
        BKPRAMLPEN: u1,
        /// ICACHE clock enable during sleep mode Set and reset by software
        ICACHELPEN: u1,
        /// DCACHE clock enable during sleep mode Set and reset by software
        DCACHELPEN: u1,
        /// SRAM1 clock enable during sleep mode Set and reset by software
        SRAM1LPEN: u1,
    }),
    /// RCC AHB2 sleep clock register
    /// offset: 0xb4
    AHB2LPENR: mmio.Mmio(packed struct(u32) {
        /// GPIOA clock enable during sleep mode Set and reset by software.
        GPIOALPEN: u1,
        /// GPIOB clock enable during sleep mode Set and reset by software.
        GPIOBLPEN: u1,
        /// GPIOC clock enable during sleep mode Set and reset by software.
        GPIOCLPEN: u1,
        /// GPIOD clock enable during sleep mode Set and reset by software.
        GPIODLPEN: u1,
        /// GPIOE clock enable during sleep mode Set and reset by software.
        GPIOELPEN: u1,
        /// GPIOF clock enable during sleep mode Set and reset by software.
        GPIOFLPEN: u1,
        /// GPIOG clock enable during sleep mode Set and reset by software.
        GPIOGLPEN: u1,
        /// GPIOH clock enable during sleep mode Set and reset by software.
        GPIOHLPEN: u1,
        /// GPIOI clock enable during sleep mode Set and reset by software.
        GPIOILPEN: u1,
        reserved10: u1 = 0,
        /// ADC1 and 2 peripherals clock enable during sleep mode Set and reset by software.
        ADC12LPEN: u1,
        /// DAC clock enable during sleep mode Set and reset by software.
        DAC1LPEN: u1,
        /// digital camera interface clock enable during sleep mode (DCMI or PSSI depending which interface is active) Set and reset by software.
        DCMI_PSSILPEN: u1,
        reserved16: u3 = 0,
        /// AES clock enable during sleep mode Set and reset by software.
        AESLPEN: u1,
        /// HASH clock enable during sleep mode Set and reset by software.
        HASHLPEN: u1,
        /// RNG clock enable during sleep mode Set and reset by software.
        RNGLPEN: u1,
        /// PKA clock enable during sleep mode Set and reset by software.
        PKALPEN: u1,
        /// SAES clock enable during sleep mode Set and reset by software.
        SAESLPEN: u1,
        reserved30: u9 = 0,
        /// SRAM2 clock enable during sleep mode Set and reset by software.
        SRAM2LPEN: u1,
        /// SRAM3 clock enable during sleep mode Set and reset by software.
        SRAM3LPEN: u1,
    }),
    /// offset: 0xb8
    reserved184: [4]u8,
    /// RCC AHB4 sleep clock register
    /// offset: 0xbc
    AHB4LPENR: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// OTFDEC1 clock enable during sleep mode Set and reset by software.
        OTFDEC1LPEN: u1,
        reserved11: u3 = 0,
        /// SDMMC1 and SDMMC1 delay peripheral clock enable during sleep mode Set and reset by software
        SDMMC1LPEN: u1,
        /// SDMMC2 and SDMMC2 delay peripheral clock enable during sleep mode Set and reset by software.
        SDMMC2LPEN: u1,
        reserved16: u3 = 0,
        /// FMC clock enable during sleep mode Set and reset by software.
        FMCLPEN: u1,
        reserved20: u3 = 0,
        /// OCTOSPI1 clock enable during sleep mode Set and reset by software.
        OCTOSPI1LPEN: u1,
        padding: u11 = 0,
    }),
    /// offset: 0xc0
    reserved192: [4]u8,
    /// RCC APB1 sleep clock register
    /// offset: 0xc4
    APB1LLPENR: mmio.Mmio(packed struct(u32) {
        /// TIM2 clock enable during sleep mode Set and reset by software.
        TIM2LPEN: u1,
        /// TIM3 clock enable during sleep mode Set and reset by software.
        TIM3LPEN: u1,
        /// TIM4 clock enable during sleep mode Set and reset by software.
        TIM4LPEN: u1,
        /// TIM5 clock enable during sleep mode Set and reset by software.
        TIM5LPEN: u1,
        /// TIM6 clock enable during sleep mode Set and reset by software.
        TIM6LPEN: u1,
        /// TIM7 clock enable during sleep mode Set and reset by software.
        TIM7LPEN: u1,
        /// TIM12 clock enable during sleep mode Set and reset by software.
        TIM12LPEN: u1,
        /// TIM13 clock enable during sleep mode Set and reset by software.
        TIM13LPEN: u1,
        /// TIM14 clock enable during sleep mode Set and reset by software.
        TIM14LPEN: u1,
        reserved11: u2 = 0,
        /// WWDG clock enable during sleep mode Set and reset by software.
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable during sleep mode Set and reset by software.
        SPI2LPEN: u1,
        /// SPI3 clock enable during sleep mode Set and reset by software.
        SPI3LPEN: u1,
        reserved17: u1 = 0,
        /// USART2 clock enable during sleep mode Set and reset by software.
        USART2LPEN: u1,
        /// USART3 clock enable during sleep mode Set and reset by software.
        USART3LPEN: u1,
        /// UART4 clock enable during sleep mode Set and reset by software.
        UART4LPEN: u1,
        /// UART5 clock enable during sleep mode Set and reset by software.
        UART5LPEN: u1,
        /// I2C1 clock enable during sleep mode Set and reset by software.
        I2C1LPEN: u1,
        /// I2C2 clock enable during sleep mode Set and reset by software.
        I2C2LPEN: u1,
        /// I3C1 clock enable during sleep mode Set and reset by software.
        I3C1LPEN: u1,
        /// CRS clock enable during sleep mode Set and reset by software.
        CRSLPEN: u1,
        /// USART6 clock enable during sleep mode Set and reset by software.
        USART6LPEN: u1,
        /// USART10 clock enable during sleep mode Set and reset by software.
        USART10LPEN: u1,
        /// USART11 clock enable during sleep mode Set and reset by software.
        USART11LPEN: u1,
        /// HDMI-CEC clock enable during sleep mode Set and reset by software.
        CECLPEN: u1,
        reserved30: u1 = 0,
        /// UART7 clock enable during sleep mode Set and reset by software.
        UART7LPEN: u1,
        /// UART8 clock enable during sleep mode Set and reset by software.
        UART8LPEN: u1,
    }),
    /// RCC APB1 sleep clock register
    /// offset: 0xc8
    APB1HLPENR: mmio.Mmio(packed struct(u32) {
        /// UART9 clock enable during sleep mode Set and reset by software.
        UART9LPEN: u1,
        /// UART12 clock enable during sleep mode Set and reset by software.
        UART12LPEN: u1,
        reserved3: u1 = 0,
        /// DTS clock enable during sleep mode Set and reset by software.
        DTSLPEN: u1,
        reserved5: u1 = 0,
        /// LPTIM2 clock enable during sleep mode Set and reset by software.
        LPTIM2LPEN: u1,
        reserved9: u3 = 0,
        /// FDCAN1 and FDCAN2 peripheral clock enable during sleep mode Set and reset by software.
        FDCAN12LPEN: u1,
        reserved23: u13 = 0,
        /// UCPD clock enable during sleep mode Set and reset by software.
        UCPDLPEN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 sleep clock register
    /// offset: 0xcc
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 clock enable during sleep mode Set and reset by software.
        TIM1LPEN: u1,
        /// SPI1 clock enable during sleep mode Set and reset by software.
        SPI1LPEN: u1,
        /// TIM8 clock enable during sleep mode Set and reset by software.
        TIM8LPEN: u1,
        /// USART1 clock enable during sleep mode Set and reset by software.
        USART1LPEN: u1,
        reserved16: u1 = 0,
        /// TIM15 clock enable during sleep mode Set and reset by software.
        TIM15LPEN: u1,
        /// TIM16 clock enable during sleep mode Set and reset by software.
        TIM16LPEN: u1,
        /// TIM17 clock enable during sleep mode Set and reset by software.
        TIM17LPEN: u1,
        /// SPI4 clock enable during sleep mode Set and reset by software.
        SPI4LPEN: u1,
        /// SPI6 clock enable during sleep mode Set and reset by software.
        SPI6LPEN: u1,
        /// SAI1 clock enable during sleep mode Set and reset by software.
        SAI1LPEN: u1,
        /// SAI2 clock enable during sleep mode Set and reset by software.
        SAI2LPEN: u1,
        reserved24: u1 = 0,
        /// USB clock enable during sleep mode Set and reset by software.
        USBLPEN: u1,
        padding: u7 = 0,
    }),
    /// RCC APB3 sleep clock register
    /// offset: 0xd0
    APB3LPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS clock enable during sleep mode Set and reset by software.
        SYSCFGLPEN: u1,
        reserved5: u3 = 0,
        /// SPI5 clock enable during Slsleepeep mode Set and reset by software.
        SPI5LPEN: u1,
        /// LPUART1 clock enable during sleep mode Set and reset by software.
        LPUART1LPEN: u1,
        /// I2C3 clock enable during sleep mode Set and reset by software.
        I2C3LPEN: u1,
        /// I2C4 clock enable during sleep mode Set and reset by software.
        I2C4LPEN: u1,
        reserved11: u2 = 0,
        /// LPTIM1 clock enable during sleep mode Set and reset by software.
        LPTIM1LPEN: u1,
        /// LPTIM3 clock enable during sleep mode Set and reset by software.
        LPTIM3LPEN: u1,
        /// LPTIM4 clock enable during sleep mode Set and reset by software.
        LPTIM4LPEN: u1,
        /// LPTIM5 clock enable during sleep mode Set and reset by software.
        LPTIM5LPEN: u1,
        /// LPTIM6 clock enable during sleep mode Set and reset by software.
        LPTIM6LPEN: u1,
        reserved20: u4 = 0,
        /// VREF clock enable during sleep mode Set and reset by software.
        VREFLPEN: u1,
        /// RTC APB interface clock enable during sleep mode Set and reset by software.
        RTCAPBLPEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xd4
    reserved212: [4]u8,
    /// RCC kernel clock configuration register
    /// offset: 0xd8
    CCIPR1: mmio.Mmio(packed struct(u32) {
        /// USART1 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        USART1SEL: USART1SEL,
        /// USART2 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        USART2SEL: USARTSEL,
        /// USART3 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        USART3SEL: USARTSEL,
        /// UART4 kernel clock source selection others: reserved, the kernel clock is disabled
        UART4SEL: USARTSEL,
        /// UART5 kernel clock source selection others: reserved, the kernel clock is disabled
        UART5SEL: USARTSEL,
        /// USART6 kernel clock source selection others: reserved, the kernel clock is disabled
        USART6SEL: USARTSEL,
        /// UART7 kernel clock source selection others: reserved, the kernel clock is disabled
        UART7SEL: USARTSEL,
        /// UART8 kernel clock source selection others: reserved, the kernel clock is disabled
        UART8SEL: USARTSEL,
        /// UART9 kernel clock source selection others: reserved, the kernel clock is disabled
        UART9SEL: USARTSEL,
        /// USART10 kernel clock source selection others: reserved, the kernel clock is disabled
        USART10SEL: USARTSEL,
        reserved31: u1 = 0,
        /// TIM12, TIM15 and LPTIM2 input capture source selection Set and reset by software.
        TIMICSEL: TIMICSEL,
    }),
    /// RCC kernel clock configuration register
    /// offset: 0xdc
    CCIPR2: mmio.Mmio(packed struct(u32) {
        /// USART11 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        USART11SEL: USARTSEL,
        reserved4: u1 = 0,
        /// USART12 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        USART12SEL: USARTSEL,
        reserved8: u1 = 0,
        /// LPTIM1 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM1SEL: LPTIMSEL,
        reserved12: u1 = 0,
        /// LPTIM2 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM2SEL: LPTIM2SEL,
        reserved16: u1 = 0,
        /// LPTIM3 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM3SEL: LPTIMSEL,
        reserved20: u1 = 0,
        /// LPTIM4 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM4SEL: LPTIMSEL,
        reserved24: u1 = 0,
        /// LPTIM5 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM5SEL: LPTIMSEL,
        reserved28: u1 = 0,
        /// LPTIM6 kernel clock source selection others: reserved, the kernel clock is disabled
        LPTIM6SEL: LPTIMSEL,
        padding: u1 = 0,
    }),
    /// RCC kernel clock configuration register
    /// offset: 0xe0
    CCIPR3: mmio.Mmio(packed struct(u32) {
        /// SPI1 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        SPI1SEL: SPI1SEL,
        /// SPI2 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        SPI2SEL: SPI2SEL,
        /// SPI3 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled
        SPI3SEL: SPI3SEL,
        /// SPI4 kernel clock source selection others: reserved, the kernel clock is disabled
        SPI4SEL: SPI4SEL,
        /// SPI5 kernel clock source selection others: reserved, the kernel clock is disabled
        SPI5SEL: SPI5SEL,
        /// SPI6 kernel clock source selection others: reserved, the kernel clock is disabled
        SPI6SEL: SPI6SEL,
        reserved24: u6 = 0,
        /// LPUART1 kernel clock source selection others: reserved, the kernel clock is disabled
        LPUART1SEL: LPUSARTSEL,
        padding: u5 = 0,
    }),
    /// RCC kernel clock configuration register
    /// offset: 0xe4
    CCIPR4: mmio.Mmio(packed struct(u32) {
        /// OCTOSPI1 kernel clock source selection Set and reset by software.
        OCTOSPI1SEL: OCTOSPISEL,
        /// SYSTICK clock source selection Note: rcc_hclk frequency must be four times higher than lsi_ker_ck/lse_ck (period (LSI/LSE) ≥ 4 * period (HCLK).
        SYSTICKSEL: SYSTICKSEL,
        /// USB kernel clock source selection
        USBSEL: USBSEL,
        /// SDMMC1 kernel clock source selection
        SDMMC1SEL: SDMMCSEL,
        /// SDMMC2 kernel clock source selection
        SDMMC2SEL: SDMMCSEL,
        reserved16: u8 = 0,
        /// I2C1 kernel clock source selection
        I2C1SEL: I2CSEL,
        /// I2C2 kernel clock source selection
        I2C2SEL: I2CSEL,
        /// I2C3 kernel clock source selection
        I2C3SEL: I2C34SEL,
        /// I2C4 kernel clock source selection
        I2C4SEL: I2C34SEL,
        /// I3C1 kernel clock source selection
        I3C1SEL: I2CSEL,
        padding: u6 = 0,
    }),
    /// RCC kernel clock configuration register
    /// offset: 0xe8
    CCIPR5: mmio.Mmio(packed struct(u32) {
        /// ADC and DAC kernel clock source selection others: reserved, the kernel clock is disabled
        ADCDACSEL: ADCDACSEL,
        /// DAC hold clock
        DACHOLDSEL: DACHOLDSEL,
        /// RNG kernel clock source selection
        RNGSEL: RNGSEL,
        /// HSMI-CEC kernel clock source selection
        CECSEL: CECSEL,
        /// FDCAN1 and FDCAN2 kernel clock source selection
        FDCAN12SEL: FDCANSEL,
        reserved16: u6 = 0,
        /// SAI1 kernel clock source selection others: reserved, the kernel clock is disabled
        SAI1SEL: SAISEL,
        /// SAI2 kernel clock source selection others: reserved, the kernel clock is disabled
        SAI2SEL: SAISEL,
        reserved30: u8 = 0,
        /// per_ck clock source selection
        PERSEL: PERSEL,
    }),
    /// offset: 0xec
    reserved236: [4]u8,
    /// RCC Backup domain control register
    /// offset: 0xf0
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enabled Set and reset by software.
        LSEON: u1,
        /// LSE oscillator ready Set and reset by hardware to indicate when the LSE is stable. This bit needs 6 cycles of lse_ck clock to fall down after LSEON has been set to 0.
        LSERDY: u1,
        /// LSE oscillator bypass Set and reset by software to bypass oscillator in debug mode. This bit must not be written when the LSE is enabled (by LSEON) or ready (LSERDY = 1)
        LSEBYP: u1,
        /// LSE oscillator driving capability Set by software to select the driving capability of the LSE oscillator. These bit can be written only if LSE oscillator is disabled (LSEON = 0 and LSERDY = 0).
        LSEDRV: LSEDRV,
        /// LSE clock security system enable Set by software to enable the clock security system on 32 kHz oscillator. LSECSSON must be enabled after LSE is enabled (LSEON enabled) and ready (LSERDY set by hardware) and after RTCSEL is selected. Once enabled, this bit cannot be disabled, except after a LSE failure detection (LSECSSD = 1). In that case the software must disable LSECSSON.
        LSECSSON: u1,
        /// LSE clock security system failure detection Set by hardware to indicate when a failure has been detected by the clock security system on the external 32 kHz oscillator.
        LSECSSD: u1,
        /// low-speed external clock type in bypass mode Set and reset by software to select the external clock type (analog or digital). The external clock must be enabled with the LSEON bit, to be used by the device. The LSEEXT bit can be written only if the LSE oscillator is disabled.
        LSEEXT: LSEEXT,
        /// RTC clock source selection Set by software to select the clock source for the RTC. These bits can be written only one time (except in case of failure detection on LSE). These bits must be written before LSECSSON is enabled. The VSWRST bit can be used to reset them, then it can be written one time again. If HSE is selected as RTC clock, this clock is lost when the system is in Stop mode or in case of a pin reset (NRST).
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable Set and reset by software.
        RTCEN: u1,
        /// VSwitch domain software reset Set and reset by software.
        VSWRST: u1,
        reserved24: u7 = 0,
        /// Low-speed clock output (LSCO) enable Set and cleared by software.
        LSCOEN: u1,
        /// Low-speed clock output selection Set and cleared by software.
        LSCOSEL: LSCOSEL,
        /// LSI oscillator enable Set and cleared by software.
        LSION: u1,
        /// LSI oscillator ready Set and cleared by hardware to indicate when the LSI oscillator is stable. After the LSION bit is cleared, LSIRDY goes low after three internal low-speed oscillator clock cycles. This bit is set when the LSI is used by IWDG or RTC, even if LSION = 0.
        LSIRDY: u1,
        padding: u4 = 0,
    }),
    /// RCC reset status register
    /// offset: 0xf4
    RSR: mmio.Mmio(packed struct(u32) {
        reserved23: u23 = 0,
        /// remove reset flag Set and reset by software to reset the value of the reset flags.
        RMVF: u1,
        reserved26: u2 = 0,
        /// pin reset flag (NRST) Reset by software by writing the RMVF bit. Set by hardware when a reset from pin occurs.
        PINRSTF: u1,
        /// BOR reset flag Reset by software by writing the RMVF bit. Set by hardware when a BOR reset occurs (pwr_bor_rst).
        BORRSTF: u1,
        /// system reset from CPU reset flag Reset by software by writing the RMVF bit. Set by hardware when the system reset is due to CPU.The CPU can generate a system reset by writing SYSRESETREQ bit of AIRCR register of the core M33.
        SFTRSTF: u1,
        /// independent watchdog reset flag Reset by software by writing the RMVF bit. Set by hardware when an independent watchdog reset occurs.
        IWDGRSTF: u1,
        /// window watchdog reset flag Reset by software by writing the RMVF bit. Set by hardware when a window watchdog reset occurs.
        WWDGRSTF: u1,
        /// Low-power reset flag Set by hardware when a reset occurs due to Stop or Standby mode entry, whereas the corresponding nRST_STOP, nRST_STBY option bit is cleared. Cleared by writing to the RMVF bit.
        LPWRRSTF: u1,
    }),
    /// offset: 0xf8
    reserved248: [24]u8,
    /// RCC secure configuration register
    /// offset: 0x110
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock configuration and status bits security Set and reset by software.
        HSISEC: u1,
        /// HSE clock configuration bits, status bits and HSE_CSS security Set and reset by software.
        HSESEC: u1,
        /// CSI clock configuration and status bits security Set and reset by software.
        CSISEC: u1,
        /// LSI clock configuration and status bits security Set and reset by software.
        LSISEC: u1,
        /// LSE clock configuration and status bits security Set and reset by software.
        LSESEC: u1,
        /// SYSCLK clock selection, STOPWUCK bit, clock output on MCO configuration security Set and reset by software.
        SYSCLKSEC: u1,
        /// AHBx/APBx prescaler configuration bits security Set and reset by software.
        PRESCSEC: u1,
        /// (1/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[0]": u1,
        /// (2/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[1]": u1,
        /// (3/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[2]": u1,
        reserved11: u1 = 0,
        /// HSI48 clock configuration and status bits security Set and reset by software.
        HSI48SEC: u1,
        /// Remove reset flag security Set and reset by software.
        RMVFSEC: u1,
        /// per_ck selection security Set and reset by software.
        PERSELSEC: u1,
        padding: u18 = 0,
    }),
    /// RCC privilege configuration register
    /// offset: 0x114
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// RCC secure functions privilege configuration Set and reset by software. This bit can be written only by a secure privileged access.
        SPRIV: SPRIV,
        /// RCC non-secure functions privilege configuration Set and reset by software. This bit can be written only by privileged access, secure or non-secure.
        NSPRIV: NSPRIV,
        padding: u30 = 0,
    }),
};
