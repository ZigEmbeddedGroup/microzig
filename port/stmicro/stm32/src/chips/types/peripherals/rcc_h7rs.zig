const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCSEL = enum(u2) {
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// PER selected as peripheral clock
    PER = 0x2,
    _,
};

pub const ADFSEL = enum(u3) {
    /// hclk1 selected as ADF kernel clock (default after reset).
    HCLK1 = 0x0,
    /// pll2_p_ck selected as ADF kernel clock.
    PLL2_P = 0x1,
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

pub const DWNSPREAD = enum(u1) {
    /// Center-spread modulation selected (default after reset).
    CenterSpread = 0x0,
    /// Down-spread modulation selected.
    DownSpread = 0x1,
};

pub const ETHPHY_CLK_SEL = enum(u1) {
    /// hse_ker_ck selected as clock source (default after reset).
    HSE = 0x0,
    /// pll3_s_ck selected clock source.
    PLL3_S = 0x1,
};

pub const ETH_REF_CLK_SEL = enum(u2) {
    /// PAD ETH_RMII_REF_CLK selected as kernel peripheral clock (default after reset).
    ETH_RMII_REF = 0x0,
    /// hse_ker_ck selected as kernel peripheral clock.
    HSE = 0x1,
    /// eth_clk_fb selected as kernel peripheral clock.
    ETH = 0x2,
    _,
};

pub const FDCANSEL = enum(u2) {
    /// HSE selected as peripheral clock
    HSE = 0x0,
    /// pll1_q selected as peripheral clock
    PLL1_Q = 0x1,
    /// pll2_p selected as peripheral clock
    PLL2_P = 0x2,
    _,
};

pub const FMCSEL = enum(u2) {
    /// hclk5 selected as kernel peripheral clock (default after reset).
    HCLK5 = 0x0,
    /// pll1_q_ck selected as kernel peripheral clock.
    PLL1_Q = 0x1,
    /// pll2_r_ck selected as kernel peripheral clock.
    PLL2_R = 0x2,
    /// hsi_ker_ck selected as kernel peripheral clock.
    HSI = 0x3,
};

pub const FMCSWP = enum(u3) {
    /// The switch is in neutral mode and output clock is gated (default after reset).
    B_0x0 = 0x0,
    /// The switch is selecting hclk5.
    B_0x1 = 0x1,
    /// The switch is selecting pll1_q_ck.
    B_0x2 = 0x2,
    /// The switch is selecting pll2_r_ck.
    B_0x3 = 0x3,
    /// The switch is selecting hsi_ker_ck.
    B_0x4 = 0x4,
    /// The switch is in recovery position (hclk5/4).
    B_0x5 = 0x5,
    _,
};

pub const HPRE = enum(u4) {
    Div1 = 0x0,
    Div2 = 0x8,
    Div4 = 0x9,
    Div8 = 0xa,
    Div16 = 0xb,
    Div64 = 0xc,
    Div128 = 0xd,
    Div256 = 0xe,
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
    /// division by 1, hsi(_ker)_ck = 64 MHz (default after reset).
    Div1 = 0x0,
    /// division by 2, hsi(_ker)_ck = 32 MHz.
    Div2 = 0x1,
    /// division by 4, hsi(_ker)_ck = 16 MHz.
    Div4 = 0x2,
    /// division by 8, hsi(_ker)_ck = 8 MHz.
    Div8 = 0x3,
};

pub const I2C1_I3C1SEL = enum(u2) {
    /// rcc_pclk1 selected as peripheral clock
    PCLK1 = 0x0,
    /// pll3_r selected as peripheral clock
    PLL3_R = 0x1,
    /// hsi_ker selected as peripheral clock
    HSI = 0x2,
    /// csi_ker selected as peripheral clock
    CSI = 0x3,
};

pub const I2CSEL = enum(u2) {
    /// pclk1 selected as kernel clock (default after reset).
    PCLK1 = 0x0,
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

pub const LPTIMSEL = enum(u3) {
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

pub const OCTOSPISEL = enum(u2) {
    /// hclk5 selected as kernel peripheral clock (default after reset).
    HCLK5 = 0x0,
    /// pll2_s_ck selected as kernel peripheral clock.
    PLL2_S = 0x1,
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

pub const PLLDIVST = enum(u3) {
    Div1 = 0x0,
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
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
    Div63 = 0x3f,
    _,
};

pub const PLLN = enum(u9) {
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
    /// VCOH selected (default after reset).
    WideVCO = 0x0,
    /// VCOL selected.
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

pub const PSSISEL = enum(u1) {
    /// pll3_r_ck selected as kernel peripheral clock (default after reset).
    PLL3_R = 0x0,
    /// per_ck selected as kernel peripheral clock.
    PER = 0x1,
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

pub const SAI1SEL = enum(u3) {
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

pub const SAI2SEL = enum(u3) {
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
    /// spdifrx_symb_ck selected as SAI2 kernel clock.
    SPDIFRX_SYMB = 0x5,
    _,
};

pub const SDMMCSEL = enum(u1) {
    /// pll2_s_ck selected as kernel peripheral clock (default after reset).
    PLL2_S = 0x0,
    /// pll2_t_ck selected as kernel peripheral clock.
    PLL2_T = 0x1,
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

pub const SPI123SEL = enum(u3) {
    /// pll1_q_ck selected as SPI/I2S1 and 7 kernel clock (default after reset).
    PLL1_Q = 0x0,
    /// pll2_p_ck selected as SPI/I2S1 and 7 kernel clock.
    PLL2_P = 0x1,
    /// pll3_p_ck selected as SPI/I2S1 and 7 kernel clock.
    PLL3_P = 0x2,
    /// I2S_CKIN selected as SPI/I2S1 and 7 kernel clock.
    I2S_CKIN = 0x3,
    /// per_ck selected as SPI/I2S1,and 7 kernel clock.
    PER = 0x4,
    _,
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

pub const STOPKERWUCK = enum(u1) {
    /// HSI selected as wake up clock from system Stop (default after reset).
    HSI = 0x0,
    /// CSI selected as wake up clock from system Stop.
    CSI = 0x1,
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

pub const TIMPRE = enum(u1) {
    /// Timer kernel clock equal to 2x pclk by default
    DefaultX2 = 0x0,
    /// Timer kernel clock equal to 4x pclk by default
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

pub const USBPDCTRL = enum(u1) {
    /// In SUSPEND, PHY state machine, bias and USBPHYC PLL remain powered (default after reset).
    RemainPowered = 0x0,
    /// In SUSPEND, PHY state machine, bias and USBPHYC PLL are powered down.
    PowerDown = 0x1,
};

pub const USBPHYCSEL = enum(u2) {
    /// hse_ker_ck (default after reset).
    HSE = 0x0,
    /// hse_ker_ck / 2.
    HSE_DIV_2 = 0x1,
    /// pll3_q_ck.
    PLL3_Q = 0x2,
    _,
};

pub const USBREFCKSEL = enum(u4) {
    /// The kernel clock frequency provided to the USBPHYC is 16 MHz.
    Mhz16 = 0x3,
    /// The kernel clock frequency provided to the USBPHYC is 19.2 MHz.
    Mhz19_2 = 0x8,
    /// The kernel clock frequency provided to the USBPHYC is 20MHz.
    Mhz20 = 0x9,
    /// The kernel clock frequency provided to the USBPHYC is 24 MHz (default after reset).
    Mhz24 = 0xa,
    /// The kernel clock frequency provided to the USBPHYC is 32 MHz.
    Mhz32 = 0xb,
    /// The kernel clock frequency provided to the USBPHYC is 26 MHz.
    Mhz26 = 0xe,
    _,
};

pub const USB_OTG_FSSEL = enum(u2) {
    /// hsi48_ker_ck (default after reset).
    HSI48 = 0x0,
    /// pll3_q_ck.
    PLL3_Q = 0x1,
    /// hse_ker_ck.
    HSE = 0x2,
    /// clk48mohci.
    CLK48MOHCI = 0x3,
};

pub const XSPISWP = enum(u3) {
    /// The switch is in neutral mode and output clock is gated (default after reset).
    B_0x0 = 0x0,
    /// The switch is selecting hclk5.
    B_0x1 = 0x1,
    /// The switch is selecting pll2_s_ck.
    B_0x2 = 0x2,
    /// The switch is selecting pll2_t_ck.
    B_0x3 = 0x3,
    /// The switch is in recovery position (hclk5/4).
    B_0x4 = 0x4,
    _,
};

/// Reset and clock control.
pub const RCC = extern struct {
    /// RCC source control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// HSI clock enable Set and cleared by software. Set by hardware to force the HSI to ON when the product leaves Stop mode, if STOPWUCK = 0 or STOPKERWUCK = 0. Set by hardware to force the HSI to ON when the product leaves Standby mode or in case of a failure of the HSE which is used as the system clock source. This bit cannot be cleared if the HSI is used directly (via SW switch) as system clock, or if the HSI is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1) or if FMCCKP = 1, or if XSPICKP = 1.
        HSION: u1,
        /// HSI clock enable in Stop mode Set and reset by software to force the HSI to ON, even in Stop mode, in order to be quickly available as kernel clock for peripherals. This bit has no effect on the value of HSION.
        HSIKERON: u1,
        /// HSI clock ready flag Set by hardware to indicate that the HSI oscillator is stable.
        HSIRDY: u1,
        /// HSI clock divider Set and reset by software. These bits allow selecting a division ratio in order to configure the wanted HSI clock frequency. The HSIDIV cannot be changed if the HSI is selected as reference clock for at least one enabled PLL (PLLxON bit set to 1). In that case, the new HSIDIV value is ignored.
        HSIDIV: HSIDIV,
        /// HSI divider flag Set and reset by hardware. As a write operation to HSIDIV has not an immediate effect on the frequency, this flag indicates the current status of the HSI divider. HSIDIVF goes immediately to 0 when HSIDIV value is changed, and is set back to 1 when the output frequency matches the value programmed into HSIDIV. clock setting is completed).
        HSIDIVF: u1,
        reserved7: u1 = 0,
        /// CSI clock enable Set and reset by software to enable/disable CSI clock for system and/or peripheral. Set by hardware to force the CSI to ON when the system leaves Stop mode, if STOPWUCK = 1 or STOPKERWUCK = 1. This bit cannot be cleared if the CSI is used directly (via SW mux) as system clock, or if the CSI is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1) or if FMCCKP = 1, or if XSPICKP = 1.
        CSION: u1,
        /// CSI clock ready flag Set by hardware to indicate that the CSI oscillator is stable. This bit is activated only if the RC is enabled by CSION (it is not activated if the CSI is enabled by CSIKERON or by a peripheral request).
        CSIRDY: u1,
        /// CSI clock enable in Stop mode Set and reset by software to force the CSI to ON, even in Stop mode, in order to be quickly available as kernel clock for some peripherals. This bit has no effect on the value of CSION.
        CSIKERON: u1,
        reserved12: u2 = 0,
        /// HSI48 clock enable Set by software and cleared by software or by the hardware when the system enters to Stop or Standby mode.
        HSI48ON: u1,
        /// HSI48 clock ready flag Set by hardware to indicate that the HSI48 oscillator is stable.
        HSI48RDY: u1,
        reserved16: u2 = 0,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE when entering Stop or Standby mode. This bit cannot be cleared if the HSE is used directly (via SW mux) as system clock, or if the HSE is selected as reference clock for PLL1 with PLL1 enabled (PLL1ON bit set to 1) or if FMCCKP = 1, or if XSPICKP = 1.
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable.
        HSERDY: u1,
        /// HSE clock bypass Set and cleared by software to bypass the oscillator with an external clock. The external clock must be enabled with the HSEON bit to be used by the device. The HSEBYP bit can be written only if the HSE oscillator is disabled.
        HSEBYP: u1,
        /// external high speed clock type in Bypass mode Set and reset by software to select the external clock type (analog or digital). The external clock must be enabled with the HSEON bit to be used by the device. The HSEEXT bit can be written only if the HSE oscillator is disabled.
        HSEEXT: HSEEXT,
        /// HSE clock security system enable Set by software to enable clock security system on HSE. This bit is set only (disabled by a system reset or when the system enters in Standby mode). When HSECSSON is set, the clock detector is enabled by hardware when the HSE is ready and disabled by hardware if an oscillator failure is detected.
        HSECSSON: u1,
        reserved24: u3 = 0,
        /// (1/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3) or if FMCCKP = 1, or if XSPICKP = 1.
        @"PLLON[0]": u1,
        /// (1/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[0]": u1,
        /// (2/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3) or if FMCCKP = 1, or if XSPICKP = 1.
        @"PLLON[1]": u1,
        /// (2/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[1]": u1,
        /// (3/3 of PLLON) PLL1 enable Set and cleared by software to enable PLL1. Cleared by hardware when entering Stop or Standby mode. Note that the hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3) or if FMCCKP = 1, or if XSPICKP = 1.
        @"PLLON[2]": u1,
        /// (3/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[2]": u1,
        padding: u2 = 0,
    }),
    /// RCC HSI calibration register.
    /// offset: 0x04
    HSICFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration Set by hardware by option byte loading. Adjusted by software through trimming bits HSITRIM. This field represents the sum of engineering option byte calibration value and HSITRIM bits value.
        HSICAL: u12,
        reserved24: u12 = 0,
        /// HSI clock trimming Set by software to adjust calibration. HSITRIM field is added to the engineering option bytes loaded during reset phase (FLASH_HSI_opt) in order to form the calibration trimming value. HSICAL = HSITRIM + FLASH_HSI_opt. Note: The reset value of the field is 0x40.
        HSITRIM: u7,
        padding: u1 = 0,
    }),
    /// RCC clock recovery RC register.
    /// offset: 0x08
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// Internal RC 48 MHz clock calibration Set by hardware by option byte loading. Read-only.
        HSI48CAL: u10,
        padding: u22 = 0,
    }),
    /// RCC CSI calibration register.
    /// offset: 0x0c
    CSICFGR: mmio.Mmio(packed struct(u32) {
        /// CSI clock calibration Set by hardware by option byte loading. Adjusted by software through trimming bits CSITRIM. This field represents the sum of engineering option byte calibration value and CSITRIM bits value.
        CSICAL: u8,
        reserved24: u16 = 0,
        /// CSI clock trimming Set by software to adjust calibration. CSITRIM field is added to the engineering option bytes loaded during reset phase (FLASH_CSI_opt) in order to form the calibration trimming value. CSICAL = CSITRIM + FLASH_CSI_opt. Note: The reset value of the field is 0x20.
        CSITRIM: u6,
        padding: u2 = 0,
    }),
    /// RCC clock configuration register.
    /// offset: 0x10
    CFGR: mmio.Mmio(packed struct(u32) {
        /// system clock switch Set and reset by software to select system clock source (sys_ck). Set by hardware in order to force the selection of the HSI or CSI (depending on STOPWUCK selection) when leaving a system Stop mode or in case of failure of the HSE when used directly or indirectly as system clock. others: reserved.
        SW: SW,
        /// system clock switch status Set and reset by hardware to indicate which clock source is used as system clock. others: reserved.
        SWS: SW,
        /// system clock selection after a wake up from system Stop Set and reset by software to select the system wakeup clock from system Stop. The selected clock is also used as emergency clock for the clock security system (CSS) on HSE. See Section 1.: Dividers values can be changed on-the-fly. All dividers provide have 50% duty-cycles. for details. STOPWUCK must not be modified when CSS is enabled (by HSECSSON bit) and the system clock is HSE (SWS = 10) or a switch on HSE is requested (SW =10).
        STOPWUCK: STOPWUCK,
        /// kernel clock selection after a wake up from system Stop Set and reset by software to select the kernel wakeup clock from system Stop. See Section 1.: Dividers values can be changed on-the-fly. All dividers provide have 50% duty-cycles. for details.
        STOPKERWUCK: STOPKERWUCK,
        /// HSE division factor for RTC clock Set and cleared by software to divide the HSE to generate a clock for RTC. Caution: The software must set these bits correctly to ensure that the clock supplied to the RTC is lower than 1 MHz. These bits must be configured if needed before selecting the RTC clock source. ...
        RTCPRE: u6,
        reserved15: u1 = 0,
        /// timers clocks prescaler selection This bit is set and reset by software to control the clock frequency of all the timers connected to APB1 and APB2 domains. or 4, else it is equal to 4 x F<sub>rcc_pclkx_d2</sub> Refer to Table 64: Ratio between clock timer and pclk for more details.
        TIMPRE: TIMPRE,
        reserved18: u2 = 0,
        /// MCO1 prescaler Set and cleared by software to configure the prescaler of the MCO1. Modification of this prescaler may generate glitches on MCO1. It is highly recommended to change this prescaler only after reset, before enabling the external oscillators and the PLLs. ...
        MCO1PRE: MCOPRE,
        /// Microcontroller clock output 1 Set and cleared by software. Clock source selection may generate glitches on MCO1. It is highly recommended to configure these bits only after reset, before enabling the external oscillators and the PLLs. others: reserved.
        MCO1SEL: MCO1SEL,
        /// MCO2 prescaler Set and cleared by software to configure the prescaler of the MCO2. Modification of this prescaler may generate glitches on MCO2. It is highly recommended to change this prescaler only after reset, before enabling the external oscillators and the PLLs. ...
        MCO2PRE: MCOPRE,
        /// microcontroller clock output 2 Set and cleared by software. Clock source selection may generate glitches on MCO2. It is highly recommended to configure these bits only after reset, before enabling the external oscillators and the PLLs. others: reserved.
        MCO2SEL: MCO2SEL,
    }),
    /// offset: 0x14
    reserved20: [4]u8,
    /// RCC CPU domain clock configuration register.
    /// offset: 0x18
    CDCFGR: mmio.Mmio(packed struct(u32) {
        /// CPU domain core prescaler Set and reset by software to control the CPU clock division factor. Changing this division ratio has an impact on the frequency of the CPU clock and all bus matrix clocks. After changing this prescaler value, it takes up to 16 periods of the slowest APB clock before the new division ratio is taken into account. The application can check if the new division factor is taken into account by reading back this register. 0xxx: sys_ck not divided (default after reset).
        CPRE: HPRE,
        padding: u28 = 0,
    }),
    /// RCC AHB clock configuration register.
    /// offset: 0x1c
    BMCFGR: mmio.Mmio(packed struct(u32) {
        /// Bus matrix clock prescaler Set and reset by software to control the division factor of rcc_hclk[5:1] and rcc_aclk. This group of clocks is also named sys_bus_ck. Changing this division ratio has an impact on the frequency of all bus matrix clocks. 0xxx: sys_bus_ck= sys_cpu_ck (default after reset) Note: The clocks are divided by the new prescaler factor from 1 to 16 periods of the slowest APB clock among rcc_pclk1,2,4,5 after BMPRE update. Note: Note also that frequency of rcc_hclk[5:1] = rcc_aclk = sys_bus_ck.
        BMPRE: HPRE,
        padding: u28 = 0,
    }),
    /// RCC APB clocks configuration register.
    /// offset: 0x20
    APBCFGR: mmio.Mmio(packed struct(u32) {
        /// CPU domain APB1 prescaler Set and reset by software to control the division factor of rcc_pclk1. The clock is divided by the new prescaler factor from 1 to 16 cycles of sys_bus_ck after PPRE1 write. 0xx: rcc_pclk1 = sys_bus_ck (default after reset).
        PPRE1: PPRE,
        reserved4: u1 = 0,
        /// CPU domain APB2 prescaler Set and reset by software to control the division factor of rcc_pclk2. The clock is divided by the new prescaler factor from 1 to 16 cycles of sys_bus_ck after PPRE2 write. 0xx: rcc_pclk2 = sys_bus_ck (default after reset).
        PPRE2: PPRE,
        reserved8: u1 = 0,
        /// CPU domain APB4 prescaler Set and reset by software to control the division factor of rcc_pclk4. The clock is divided by the new prescaler factor from 1 to 16 cycles of sys_bus_ck after PPRE4 write. 0xx: rcc_pclk4 = sys_bus_ck (default after reset).
        PPRE4: PPRE,
        reserved12: u1 = 0,
        /// CPU domain APB5 prescaler Set and reset by software to control the division factor of rcc_pclk5. The clock is divided by the new prescaler factor from 1 to 16 cycles of sys_bus_ck after PPRE5 write. 0xx: rcc_pclk5 = sys_bus_ck (default after reset).
        PPRE5: PPRE,
        padding: u17 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// RCC PLLs clock source selection register.
    /// offset: 0x28
    PLLCKSELR: mmio.Mmio(packed struct(u32) {
        /// DIVMx and PLLs clock source selection Set and reset by software to select the PLL clock source. These bits can be written only when all PLLs are disabled. In order to save power, when no PLL is used, PLLSRC must be set to 11.
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// (1/3 of DIVM) prescaler for PLL1 Set and cleared by software to configure the prescaler of the PLL1. The hardware does not allow any modification of this prescaler when PLL1 is enabled (PLL1ON = 1). In order to save power when PLL1 is not used, the value of DIVM1 must be set to 0. ... ...
        @"DIVM[0]": PLLM,
        reserved12: u2 = 0,
        /// (2/3 of DIVM) prescaler for PLL1 Set and cleared by software to configure the prescaler of the PLL1. The hardware does not allow any modification of this prescaler when PLL1 is enabled (PLL1ON = 1). In order to save power when PLL1 is not used, the value of DIVM1 must be set to 0. ... ...
        @"DIVM[1]": PLLM,
        reserved20: u2 = 0,
        /// (3/3 of DIVM) prescaler for PLL1 Set and cleared by software to configure the prescaler of the PLL1. The hardware does not allow any modification of this prescaler when PLL1 is enabled (PLL1ON = 1). In order to save power when PLL1 is not used, the value of DIVM1 must be set to 0. ... ...
        @"DIVM[2]": PLLM,
        padding: u6 = 0,
    }),
    /// RCC PLLs configuration register.
    /// offset: 0x2c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of PLLFRACEN) PLL1 fractional latch enable Set and reset by software to latch the content of FRACN into the sigma-delta modulator. In order to latch the FRACN value into the sigma-delta modulator, PLL1FRACLE must be set to 0, then set to 1. The transition 0 to 1 transfers the content of FRACN into the modulator. Refer to PLL initialization procedure on page 444 for additional information.
        @"PLLFRACEN[0]": u1,
        /// (1/3 of PLLVCOSEL) PLL1 VCO selection Set and reset by software to select the proper VCO frequency range used for PLL1. This bit must be written before enabling the PLL1. It allows the application to select the VCO range: VCOH: working from 400 to 1600 MHz (F<sub>ref1_ck</sub> must be between 2 and 16 MHz) VCOL: working from 150 to 420 MHz (F<sub>ref1_ck</sub> must be between 1 and 2 MHz).
        @"PLLVCOSEL[0]": PLLVCOSEL,
        /// (1/3 of PLLSSCGEN) PLL1 SSCG enable Set and reset by software to enable the Spread Spectrum Clock Generator of PLL1, in order to reduce the amount of EMI peaks.
        @"PLLSSCGEN[0]": u1,
        /// (1/3 of PLLRGE) PLL1 input frequency range Set and reset by software to select the proper reference frequency range used for PLL1. This bit must be written before enabling the PLL1.
        @"PLLRGE[0]": PLLRGE,
        /// (1/3 of DIVPEN) PLL1 DIVP divider output enable Set and reset by software to enable the pll1_p_ck output of the PLL1. The hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3). In order to save power, when the pll1_p_ck output of the PLL1 is not used, the pll1_p_ck must be disabled.
        @"DIVPEN[0]": u1,
        /// (1/3 of DIVQEN) PLL1 DIVQ divider output enable Set and reset by software to enable the pll1_q_ck output of the PLL1. The hardware prevents writing this bit if FMCCKP = 1. In order to save power, when the pll1_q_ck output of the PLL1 is not used, the pll1_q_ck must be disabled.
        @"DIVQEN[0]": u1,
        /// (1/3 of DIVREN) PLL1 DIVR divider output enable Set and reset by software to enable the pll1_r_ck output of the PLL1. To save power, PLL1DIVREN and DIVR1 bits must be set to 0 when the pll1_r_ck is not used.
        @"DIVREN[0]": u1,
        /// (1/3 of DIVSEN) PLL1 DIVS divider output enable Set and reset by software to enable the pll1_s_ck output of the PLL1. To save power, PLL1DIVSEN must be set to 0 when the pll1_s_ck is not used.
        @"DIVSEN[0]": u1,
        /// (1/3 of DIVTEN) PLL1 DIVT divider output enable Set and reset by software to enable the pll1_t_ck output of the PLL1. To save power, PLL1DIVTEN must be set to 0 when the pll1_t_ck is not used.
        @"DIVTEN[0]": u1,
        reserved11: u1 = 0,
        /// (2/3 of PLLFRACEN) PLL1 fractional latch enable Set and reset by software to latch the content of FRACN into the sigma-delta modulator. In order to latch the FRACN value into the sigma-delta modulator, PLL1FRACLE must be set to 0, then set to 1. The transition 0 to 1 transfers the content of FRACN into the modulator. Refer to PLL initialization procedure on page 444 for additional information.
        @"PLLFRACEN[1]": u1,
        /// (2/3 of PLLVCOSEL) PLL1 VCO selection Set and reset by software to select the proper VCO frequency range used for PLL1. This bit must be written before enabling the PLL1. It allows the application to select the VCO range: VCOH: working from 400 to 1600 MHz (F<sub>ref1_ck</sub> must be between 2 and 16 MHz) VCOL: working from 150 to 420 MHz (F<sub>ref1_ck</sub> must be between 1 and 2 MHz).
        @"PLLVCOSEL[1]": PLLVCOSEL,
        /// (2/3 of PLLSSCGEN) PLL1 SSCG enable Set and reset by software to enable the Spread Spectrum Clock Generator of PLL1, in order to reduce the amount of EMI peaks.
        @"PLLSSCGEN[1]": u1,
        /// (2/3 of PLLRGE) PLL1 input frequency range Set and reset by software to select the proper reference frequency range used for PLL1. This bit must be written before enabling the PLL1.
        @"PLLRGE[1]": PLLRGE,
        /// (2/3 of DIVPEN) PLL1 DIVP divider output enable Set and reset by software to enable the pll1_p_ck output of the PLL1. The hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3). In order to save power, when the pll1_p_ck output of the PLL1 is not used, the pll1_p_ck must be disabled.
        @"DIVPEN[1]": u1,
        /// (2/3 of DIVQEN) PLL1 DIVQ divider output enable Set and reset by software to enable the pll1_q_ck output of the PLL1. The hardware prevents writing this bit if FMCCKP = 1. In order to save power, when the pll1_q_ck output of the PLL1 is not used, the pll1_q_ck must be disabled.
        @"DIVQEN[1]": u1,
        /// (2/3 of DIVREN) PLL1 DIVR divider output enable Set and reset by software to enable the pll1_r_ck output of the PLL1. To save power, PLL1DIVREN and DIVR1 bits must be set to 0 when the pll1_r_ck is not used.
        @"DIVREN[1]": u1,
        /// (2/3 of DIVSEN) PLL1 DIVS divider output enable Set and reset by software to enable the pll1_s_ck output of the PLL1. To save power, PLL1DIVSEN must be set to 0 when the pll1_s_ck is not used.
        @"DIVSEN[1]": u1,
        /// (2/3 of DIVTEN) PLL1 DIVT divider output enable Set and reset by software to enable the pll1_t_ck output of the PLL1. To save power, PLL1DIVTEN must be set to 0 when the pll1_t_ck is not used.
        @"DIVTEN[1]": u1,
        reserved22: u1 = 0,
        /// (3/3 of PLLFRACEN) PLL1 fractional latch enable Set and reset by software to latch the content of FRACN into the sigma-delta modulator. In order to latch the FRACN value into the sigma-delta modulator, PLL1FRACLE must be set to 0, then set to 1. The transition 0 to 1 transfers the content of FRACN into the modulator. Refer to PLL initialization procedure on page 444 for additional information.
        @"PLLFRACEN[2]": u1,
        /// (3/3 of PLLVCOSEL) PLL1 VCO selection Set and reset by software to select the proper VCO frequency range used for PLL1. This bit must be written before enabling the PLL1. It allows the application to select the VCO range: VCOH: working from 400 to 1600 MHz (F<sub>ref1_ck</sub> must be between 2 and 16 MHz) VCOL: working from 150 to 420 MHz (F<sub>ref1_ck</sub> must be between 1 and 2 MHz).
        @"PLLVCOSEL[2]": PLLVCOSEL,
        /// (3/3 of PLLSSCGEN) PLL1 SSCG enable Set and reset by software to enable the Spread Spectrum Clock Generator of PLL1, in order to reduce the amount of EMI peaks.
        @"PLLSSCGEN[2]": u1,
        /// (3/3 of PLLRGE) PLL1 input frequency range Set and reset by software to select the proper reference frequency range used for PLL1. This bit must be written before enabling the PLL1.
        @"PLLRGE[2]": PLLRGE,
        /// (3/3 of DIVPEN) PLL1 DIVP divider output enable Set and reset by software to enable the pll1_p_ck output of the PLL1. The hardware prevents writing this bit to 0, if the PLL1 output is used as the system clock (SW=3). In order to save power, when the pll1_p_ck output of the PLL1 is not used, the pll1_p_ck must be disabled.
        @"DIVPEN[2]": u1,
        /// (3/3 of DIVQEN) PLL1 DIVQ divider output enable Set and reset by software to enable the pll1_q_ck output of the PLL1. The hardware prevents writing this bit if FMCCKP = 1. In order to save power, when the pll1_q_ck output of the PLL1 is not used, the pll1_q_ck must be disabled.
        @"DIVQEN[2]": u1,
        /// (3/3 of DIVREN) PLL1 DIVR divider output enable Set and reset by software to enable the pll1_r_ck output of the PLL1. To save power, PLL1DIVREN and DIVR1 bits must be set to 0 when the pll1_r_ck is not used.
        @"DIVREN[2]": u1,
        /// (3/3 of DIVSEN) PLL1 DIVS divider output enable Set and reset by software to enable the pll1_s_ck output of the PLL1. To save power, PLL1DIVSEN must be set to 0 when the pll1_s_ck is not used.
        @"DIVSEN[2]": u1,
        /// (3/3 of DIVTEN) PLL1 DIVT divider output enable Set and reset by software to enable the pll1_t_ck output of the PLL1. To save power, PLL1DIVTEN must be set to 0 when the pll1_t_ck is not used.
        @"DIVTEN[2]": u1,
    }),
    /// RCC PLL dividers configuration register 1.
    /// offset: 0x30
    PLLDIVR: mmio.Mmio(packed struct(u32) {
        /// multiplication factor for PLL1 VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL is disabled (PLL1ON = PLL1RDY = 0). ..........: not used ... ... Others: wrong configurations The software must set correctly these bits to insure that the VCO output frequency is between its valid frequency range, that is: 128 to 544MHz if PLL1VCOSEL = 0 150 to 420 MHz if PLL1VCOSEL = 1 VCO output frequency = F<sub>ref1_ck</sub> x DIVN1, when fractional value 0 has been loaded into FRACN, with: DIVN1 between 8 and 420 The input frequency F<sub>ref1_ck</sub> must be between 1 and 16 MHz.
        PLLN: PLLN,
        /// PLL1 DIVP division factor Set and reset by software to control the frequency of the pll1_p_ck clock. These bits can be written only when the PLL1DIVPEN = 0. ...
        PLLP: PLLDIV,
        /// PLL1 DIVQ division factor Set and reset by software to control the frequency of the pll1_q_ck clock. These bits can be written only when the PLL1DIVQEN = 0. ...
        PLLQ: PLLDIV,
        reserved24: u1 = 0,
        /// PLL1 DIVR division factor Set and reset by software to control the frequency of the pll1_r_ck clock. These bits can be written only when the PLL1DIVREN = 0. ...
        PLLR: PLLDIV,
        padding: u1 = 0,
    }),
    /// RCC PLL fractional divider register.
    /// offset: 0x34
    PLLFRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. The software must set correctly these bits to insure that the VCO output frequency is between its valid frequency range, that is: 128 to 544 MHz if PLL1VCOSEL = 0 150 to 420 MHz if PLL1VCOSEL = 1 VCO output frequency = F<sub>ref1_ck</sub> x (DIVN1 + (FRACN / 2<sup>13</sup>)), with DIVN1 between 8 and 420 FRACN can be between 0 and 2<sup>13</sup>- 1 The input frequency F<sub>ref1_ck</sub> must be between 1 and 16 MHz. To change the FRACN value on-the-fly even if the PLL is enabled, the application must proceed as follows: Set the bit PLL1FRACLE to 0. Write the new fractional value into FRACN. Set the bit PLL1FRACLE to 1.
        FRACN: u13,
        padding: u16 = 0,
    }),
    /// offset: 0x38
    reserved56: [20]u8,
    /// RCC AHB peripheral kernel clock selection register.
    /// offset: 0x4c
    AHBPERCKSELR: mmio.Mmio(packed struct(u32) {
        /// FMC kernel clock source selection Set and reset by software.
        FMCSEL: FMCSEL,
        /// SDMMC1 and SDMMC2 kernel clock source selection Set and reset by software.
        SDMMCSEL: SDMMCSEL,
        reserved4: u1 = 0,
        /// XSPI1 kernel clock source selection Set and reset by software. 1x: pll2_t_ck selected as kernel peripheral clock.
        OCTOSPI1SEL: OCTOSPISEL,
        /// XSPI2 kernel clock source selection Set and reset by software. 1x: pll2_t_ck selected as kernel peripheral clock.
        OCTOSPI2SEL: OCTOSPISEL,
        /// USBPHYC kernel clock frequency selection Set and reset by software. This field is used to indicate to the USBPHYC, the frequency of the reference kernel clock provided to the USBPHYC. others: reserved.
        USBREFCKSEL: USBREFCKSEL,
        /// USBPHYC kernel clock source selection Set and reset by software.
        USBPHYCSEL: USBPHYCSEL,
        /// OTGFS kernel clock source selection Set and reset by software.
        USB_OTG_FSSEL: USB_OTG_FSSEL,
        /// Ethernet reference clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        ETH_REF_CLK_SEL: ETH_REF_CLK_SEL,
        /// Clock source selection for external Ethernet PHY Set and reset by software.
        ETHPHY_CLK_SEL: ETHPHY_CLK_SEL,
        reserved20: u1 = 0,
        /// ADF kernel clock source selection Set and reset by software. Note: I2S_CKIN is an external clock taken from a pin.
        ADFSEL: ADFSEL,
        reserved24: u1 = 0,
        /// SAR ADC kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        ADCSEL: ADCSEL,
        reserved27: u1 = 0,
        /// PSSI kernel clock source selection Set and reset by software.
        PSSISEL: PSSISEL,
        /// per_ck clock source selection.
        PERSEL: PERSEL,
        padding: u2 = 0,
    }),
    /// RCC APB1 peripherals kernel clock selection register.
    /// offset: 0x50
    APB1PERCKSELR: mmio.Mmio(packed struct(u32) {
        /// USART2,3, UART4,5,7,8 (APB1) kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        USART234578SEL: USART234578SEL,
        reserved4: u1 = 0,
        /// SPI/I2S2 and SPI/I2S3 kernel clock source selection Set and reset by software. If the selected clock is the external clock and this clock is stopped, it is not be possible to switch to another clock. Refer to Clock switches and gating on page 437 for additional information. others: reserved, the kernel clock is disabled Note: I2S_CKIN is an external clock taken from a pin.
        SPI23SEL: SPI123SEL,
        reserved8: u1 = 0,
        /// I2C2, I2C3 kernel clock source selection Set and reset by software.
        I2C23SEL: I2CSEL,
        reserved12: u2 = 0,
        /// I2C1 or I3C1 kernel clock source selection Set and reset by software.
        I2C1_I3C1SEL: I2C1_I3C1SEL,
        reserved16: u2 = 0,
        /// LPTIM1 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        LPTIM1SEL: LPTIM1SEL,
        reserved22: u3 = 0,
        /// FDCAN kernel clock source selection.
        FDCANSEL: FDCANSEL,
        /// SPDIFRX kernel clock source selection.
        SPDIFRXSEL: SPDIFRXSEL,
        reserved28: u2 = 0,
        /// HDMI-CEC kernel clock source selection Set and reset by software.
        CECSEL: CECSEL,
        padding: u2 = 0,
    }),
    /// RCC APB2 peripherals kernel clock selection register.
    /// offset: 0x54
    APB2PERCKSELR: mmio.Mmio(packed struct(u32) {
        /// USART1 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        USART1SEL: USART1SEL,
        reserved4: u1 = 0,
        /// SPI4 and 5 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        SPI45SEL: SPI45SEL,
        reserved8: u1 = 0,
        /// SPI/I2S1 kernel clock source selection Set and reset by software. If the selected clock is the external clock and this clock is stopped, it is not be possible to switch to another clock. Refer to Clock switches and gating on page 437 for additional information. others: reserved, the kernel clock is disabled Note: I2S_CKIN is an external clock taken from a pin.
        SPI1SEL: SPI123SEL,
        reserved16: u5 = 0,
        /// SAI1 kernel clock source selection Set and reset by software. If the selected clock is the external clock and this clock is stopped, it is not possible to switch to another clock. Refer to Clock switches and gating on page 437 for additional information. others: reserved, the kernel clock is disabled Note: I2S_CKIN is an external clock taken from a pin.
        SAI1SEL: SAI1SEL,
        reserved20: u1 = 0,
        /// SAI2 kernel clock source selection Set and reset by software. If the selected clock is the external clock and this clock is stopped, it is not possible to switch to another clock. Refer to Clock switches and gating on page 437 for additional information. others: reserved, the kernel clock is disabled Note: I2S_CKIN is an external clock taken from a pin. spdifrx_symb_ck is the symbol clock generated by the spdifrx (see Figure 51).
        SAI2SEL: SAI2SEL,
        padding: u9 = 0,
    }),
    /// RCC APB4,5 peripherals kernel clock selection register.
    /// offset: 0x58
    APB45PERCKSELR: mmio.Mmio(packed struct(u32) {
        /// LPUART1 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        LPUART1SEL: LPUARTSEL,
        reserved4: u1 = 0,
        /// SPI/I2S6 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        SPI6SEL: SPI6SEL,
        reserved8: u1 = 0,
        /// LPTIM2 and LPTIM3 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        LPTIM23SEL: LPTIMSEL,
        reserved12: u1 = 0,
        /// LPTIM4, and LPTIM5 kernel clock source selection Set and reset by software. others: reserved, the kernel clock is disabled.
        LPTIM45SEL: LPTIMSEL,
        padding: u17 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// RCC clock source interrupt enable register.
    /// offset: 0x60
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the LSI oscillator stabilization.
        LSIRDYIE: u1,
        /// LSE ready interrupt enable Set and reset by software to enable/disable interrupt caused by the LSE oscillator stabilization.
        LSERDYIE: u1,
        /// HSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSI oscillator stabilization.
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSE oscillator stabilization.
        HSERDYIE: u1,
        /// CSI ready interrupt enable Set and reset by software to enable/disable interrupt caused by the CSI oscillator stabilization.
        CSIRDYIE: u1,
        /// HSI48 ready interrupt enable Set and reset by software to enable/disable interrupt caused by the HSI48 oscillator stabilization.
        HSI48RDYIE: u1,
        /// (1/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[0]": u1,
        /// (2/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[1]": u1,
        /// (3/3 of PLLRDYIE) PLL1 ready interrupt enable Set and reset by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[2]": u1,
        /// LSE clock security system interrupt enable Set and reset by software to enable/disable interrupt caused by the clock security system (CSS) on external 32 kHz oscillator.
        LSECSSIE: u1,
        padding: u22 = 0,
    }),
    /// RCC clock source interrupt flag register.
    /// offset: 0x64
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag Reset by software by writing LSIRDYC bit. Set by hardware when the LSI clock becomes stable and LSIRDYIE is set.
        LSIRDYF: u1,
        /// LSE ready interrupt flag Reset by software by writing LSERDYC bit. Set by hardware when the LSE clock becomes stable and LSERDYIE is set.
        LSERDYF: u1,
        /// HSI ready interrupt flag Reset by software by writing HSIRDYC bit. Set by hardware when the HSI clock becomes stable and HSIRDYIE is set.
        HSIRDYF: u1,
        /// HSE ready interrupt flag Reset by software by writing HSERDYC bit. Set by hardware when the HSE clock becomes stable and HSERDYIE is set.
        HSERDYF: u1,
        /// CSI ready interrupt flag Reset by software by writing CSIRDYC bit. Set by hardware when the CSI clock becomes stable and CSIRDYIE is set.
        CSIRDYF: u1,
        /// HSI48 ready interrupt flag Reset by software by writing HSI48RDYC bit. Set by hardware when the HSI48 clock becomes stable and HSI48RDYIE is set.
        HSI48RDYF: u1,
        /// (1/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[0]": u1,
        /// (2/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[1]": u1,
        /// (3/3 of PLLRDYF) PLL1 ready interrupt flag Reset by software by writing PLL1RDYC bit. Set by hardware when the PLL1 locks and PLL1RDYIE is set.
        @"PLLRDYF[2]": u1,
        /// LSE clock security system interrupt flag Reset by software by writing LSECSSC bit. Set by hardware when a failure is detected on the external 32 kHz oscillator and LSECSSIE is set.
        LSECSSF: u1,
        /// HSE clock security system interrupt flag Reset by software by writing HSECSSC bit. Set by hardware in case of HSE clock failure.
        HSECSSF: u1,
        padding: u21 = 0,
    }),
    /// RCC clock source interrupt clear register.
    /// offset: 0x68
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear Set by software to clear LSIRDYF. Reset by hardware when clear done.
        LSIRDYC: u1,
        /// LSE ready interrupt clear Set by software to clear LSERDYF. Reset by hardware when clear done.
        LSERDYC: u1,
        /// HSI ready interrupt clear Set by software to clear HSIRDYF. Reset by hardware when clear done.
        HSIRDYC: u1,
        /// HSE ready interrupt clear Set by software to clear HSERDYF. Reset by hardware when clear done.
        HSERDYC: u1,
        /// CSI ready interrupt clear Set by software to clear CSIRDYF. Reset by hardware when clear done.
        CSIRDYC: u1,
        /// HSI48 ready interrupt clear Set by software to clear HSI48RDYF. Reset by hardware when clear done.
        HSI48RDYC: u1,
        /// (1/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[0]": u1,
        /// (2/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[1]": u1,
        /// (3/3 of PLLRDYC) PLL1 ready interrupt clear Set by software to clear PLL1RDYF. Reset by hardware when clear done.
        @"PLLRDYC[2]": u1,
        /// LSE clock security system interrupt clear Set by software to clear LSECSSF. Reset by hardware when clear done.
        LSECSSC: u1,
        /// HSE clock security system interrupt clear Set by software to clear HSECSSF. Reset by hardware when clear done.
        HSECSSC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x6c
    reserved108: [4]u8,
    /// RCC Backup domain control register.
    /// offset: 0x70
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enabled Set and reset by software.
        LSEON: u1,
        /// LSE oscillator ready Set and reset by hardware to indicate when the LSE is stable. This bit needs 6 cycles of lse_ck clock to fall down after LSEON has been set to 0.
        LSERDY: u1,
        /// LSE oscillator bypass Set and reset by software to bypass oscillator in debug mode. This bit must not be written when the LSE is enabled (by LSEON) or ready (LSERDY = 1).
        LSEBYP: u1,
        /// LSE oscillator driving capability Set by software to select the driving capability of the LSE oscillator.
        LSEDRV: LSEDRV,
        /// LSE clock security system enable Set by software to enable the clock security system on 32 kHz oscillator. LSECSSON must be enabled after LSE is enabled (LSEON enabled) and ready (LSERDY set by hardware) and after RTCSEL is selected. Once enabled, this bit can only be disabled, After a LSE failure detection (LSECSSD = 1). In that case the software must disable LSECSSON. After a back-up domain reset.
        LSECSSON: u1,
        /// LSE clock security system failure detection Set by hardware to indicate when a failure has been detected by the clock security system on the external 32 kHz oscillator.
        LSECSSD: u1,
        /// low-speed external clock type in Bypass mode Set and reset by software to select the external clock type (analog or digital). The external clock must be enabled with the LSEON bit, to be used by the device. The LSEEXT bit can be written only if the LSE oscillator is disabled.
        LSEEXT: u1,
        /// RTC clock source selection Set by software to select the clock source for the RTC. These bits can be written only one time (except in case of failure detection on LSE). These bits must be written before LSECSSON is enabled. The VSWRST bit can be used to reset them, then it can be written one time again. If HSE is selected as RTC clock, this clock is lost when the system is in Stop mode or in case of a pin reset (NRST).
        RTCSEL: RTCSEL,
        reserved12: u2 = 0,
        /// Re-Arm the LSECSS function Set by software. After a LSE failure detection, the software application can re-enable the LSECSS by writing this bit to 1. Reading this bit returns the written value. Prior to set this bit to 1, LSECSSON must be set to 0. Please refer to Section : CSS on LSE for details.
        LSECSSRA: u1,
        reserved15: u2 = 0,
        /// RTC clock enable Set and reset by software.
        RTCEN: u1,
        /// VSwitch domain software reset Set and reset by software. To generate a VSW reset, it is recommended to write this bit to 1, then back to 0.
        VSWRST: u1,
        padding: u15 = 0,
    }),
    /// RCC clock control and status register.
    /// offset: 0x74
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable Set and reset by software.
        LSION: u1,
        /// LSI oscillator ready Set and reset by hardware to indicate when the low-speed internal RC oscillator is stable. This bit needs 3 cycles of lsi_ck clock to fall down after LSION has been set to 0. This bit can be set even when LSION is not enabled if there is a request for LSI clock by the clock security system on LSE or by the low-speed watchdog or by the RTC.
        LSIRDY: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x78
    reserved120: [4]u8,
    /// RCC AHB5 peripheral reset register.
    /// offset: 0x7c
    AHB5RSTR: mmio.Mmio(packed struct(u32) {
        /// HPDMA1 block reset Set and reset by software.
        HPDMA1RST: u1,
        /// DMA2D block reset Set and reset by software.
        DMA2DRST: u1,
        reserved3: u1 = 0,
        /// JPEG block reset Set and reset by software.
        JPEGRST: u1,
        /// FMC and MCE3 blocks reset Set and reset by software. The hardware prevents writing this bit if FMCCKP = 1.
        FMCRST: u1,
        /// XSPI1 and MCE1 blocks reset Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI1RST: u1,
        reserved8: u2 = 0,
        /// SDMMC1 and DB_SDMMC1 blocks reset Set and reset by software.
        SDMMC1RST: u1,
        reserved12: u3 = 0,
        /// XSPI2 and MCE2 blocks reset Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI2RST: u1,
        reserved14: u1 = 0,
        /// XSPIM reset Set and reset by software.
        IOMNGRRST: u1,
        reserved19: u4 = 0,
        /// GFXMMU block reset Set and reset by software.
        GFXMMURST: u1,
        /// GPU block reset Set and reset by software.
        GPURST: u1,
        padding: u11 = 0,
    }),
    /// RCC AHB1 peripheral reset register.
    /// offset: 0x80
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// GPDMA1 blocks reset Set and reset by software.
        GPDMA1RST: u1,
        /// ADC1 and 2 blocks reset Set and reset by software.
        ADC12RST: u1,
        reserved15: u9 = 0,
        /// ETH1 block reset Set and reset by software.
        ETHRST: u1,
        reserved25: u9 = 0,
        /// OTGHS block reset Set and reset by software.
        USB_OTG_HSRST: u1,
        /// USBPHYC block reset Set and reset by software.
        USBPHYCRST: u1,
        /// OTGFS block reset Set and reset by software.
        USB_OTG_FSRST: u1,
        reserved31: u3 = 0,
        /// ADF block reset Set and reset by software.
        ADFRST: u1,
    }),
    /// RCC AHB2 peripheral reset register.
    /// offset: 0x84
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PSSI block reset Set and reset by software.
        PSSIRST: u1,
        reserved9: u7 = 0,
        /// SDMMC2 and SDMMC2 delay blocks reset Set and reset by software.
        SDMMC2RST: u1,
        reserved14: u4 = 0,
        /// CORDIC reset Set and reset by software.
        CORDICRST: u1,
        padding: u17 = 0,
    }),
    /// RCC AHB4 peripheral reset register.
    /// offset: 0x88
    AHB4RSTR: mmio.Mmio(packed struct(u32) {
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
        reserved12: u4 = 0,
        /// GPIOM block reset Set and reset by software.
        GPIOMRST: u1,
        /// GPION block reset Set and reset by software.
        GPIONRST: u1,
        /// GPIOO block reset Set and reset by software.
        GPIOORST: u1,
        /// GPIOP block reset Set and reset by software.
        GPIOPRST: u1,
        reserved19: u3 = 0,
        /// CRC block reset Set and reset by software.
        CRCRST: u1,
        padding: u12 = 0,
    }),
    /// RCC APB5 peripheral reset register.
    /// offset: 0x8c
    APB5RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// LTDC block reset Set and reset by software.
        LTDCRST: u1,
        /// DCMIPP block reset Set and reset by software.
        DCMIPPRST: u1,
        reserved4: u1 = 0,
        /// GFXTIM block reset Set and reset by software.
        GFXTIMRST: u1,
        padding: u27 = 0,
    }),
    /// RCC APB1 peripheral reset register 1.
    /// offset: 0x90
    APB1RSTR1: mmio.Mmio(packed struct(u32) {
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
        /// TIM13 block reset Set and reset by software.
        TIM13RST: u1,
        /// TIM14 block reset Set and reset by software.
        TIM14RST: u1,
        /// LPTIM1 block reset Set and reset by software.
        LPTIM1RST: u1,
        reserved14: u4 = 0,
        /// SPI2S2 block reset Set and reset by software.
        SPI2RST: u1,
        /// SPI2S3 block reset Set and reset by software.
        SPI3RST: u1,
        /// SPDIFRX block reset Set and reset by software.
        SPDIFRXRST: u1,
        /// USART2 block reset Set and reset by software.
        USART2RST: u1,
        /// USART3 block reset Set and reset by software.
        USART3RST: u1,
        /// UART4 block reset Set and reset by software.
        UART4RST: u1,
        /// UART5 block reset Set and reset by software.
        UART5RST: u1,
        /// I2C1/I3C1 block reset Set and reset by software.
        I2C1_I3C1RST: u1,
        /// I2C2 block reset Set and reset by software.
        I2C2RST: u1,
        /// I2C3 block reset Set and reset by software.
        I2C3RST: u1,
        reserved27: u3 = 0,
        /// HDMI-CEC block reset Set and reset by software.
        CECRST: u1,
        reserved30: u2 = 0,
        /// UART7 block reset Set and reset by software.
        UART7RST: u1,
        /// UART8 block reset Set and reset by software.
        UART8RST: u1,
    }),
    /// RCC APB1 peripheral reset register 2.
    /// offset: 0x94
    APB1RSTR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// clock recovery system reset Set and reset by software.
        CRSRST: u1,
        reserved5: u3 = 0,
        /// MDIOS block reset Set and reset by software.
        MDIOSRST: u1,
        reserved8: u2 = 0,
        /// FDCAN block reset Set and reset by software.
        FDCANRST: u1,
        reserved27: u18 = 0,
        /// UCPD block reset Set and reset by software.
        UCPDRST: u1,
        padding: u4 = 0,
    }),
    /// RCC APB2 peripheral reset register.
    /// offset: 0x98
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        /// TIM1 block reset Set and reset by software.
        TIM1RST: u1,
        reserved4: u3 = 0,
        /// USART1 block reset Set and reset by software.
        USART1RST: u1,
        reserved12: u7 = 0,
        /// SPI2S1 block reset Set and reset by software.
        SPI1RST: u1,
        /// SPI4 block reset Set and reset by software.
        SPI4RST: u1,
        reserved16: u2 = 0,
        /// TIM15 block reset Set and reset by software.
        TIM15RST: u1,
        /// TIM16 block reset Set and reset by software.
        TIM16RST: u1,
        /// TIM17 block reset Set and reset by software.
        TIM17RST: u1,
        /// TIM9 block reset Set and reset by software.
        TIM9RST: u1,
        /// SPI5 block reset Set and reset by software.
        SPI5RST: u1,
        reserved22: u1 = 0,
        /// SAI1 block reset Set and reset by software.
        SAI1RST: u1,
        /// SAI2 block reset Set and reset by software.
        SAI2RST: u1,
        padding: u8 = 0,
    }),
    /// RCC APB4 peripheral reset register.
    /// offset: 0x9c
    APB4RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS block reset Set and reset by software.
        SYSCFGRST: u1,
        reserved3: u1 = 0,
        /// LPUART1 block reset Set and reset by software.
        LPUART1RST: u1,
        reserved5: u1 = 0,
        /// SPI/I2S6 block reset Set and reset by software.
        SPI6RST: u1,
        reserved9: u3 = 0,
        /// LPTIM2 block reset Set and reset by software.
        LPTIM2RST: u1,
        /// LPTIM3 block reset Set and reset by software.
        LPTIM3RST: u1,
        /// LPTIM4 block reset Set and reset by software.
        LPTIM4RST: u1,
        /// LPTIM5 block reset Set and reset by software.
        LPTIM5RST: u1,
        reserved15: u2 = 0,
        /// VREF block reset Set and reset by software.
        VREFRST: u1,
        reserved26: u10 = 0,
        /// TMPSENS block reset Set and reset by software.
        TMPSENSRST: u1,
        padding: u5 = 0,
    }),
    /// offset: 0xa0
    reserved160: [4]u8,
    /// RCC AHB3 peripheral reset register.
    /// offset: 0xa4
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// random number generator block reset Set and reset by software.
        RNGRST: u1,
        /// HASH block reset Set and reset by software.
        HASHRST: u1,
        /// CRYP block reset Set and reset by software.
        CRYPRST: u1,
        reserved4: u1 = 0,
        /// SAES block reset Set and reset by software.
        SAESRST: u1,
        reserved6: u1 = 0,
        /// PKA block reset Set and reset by software.
        PKARST: u1,
        padding: u25 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// RCC AXI clocks gating disable register.
    /// offset: 0xb0
    CKGDISR: mmio.Mmio(packed struct(u32) {
        /// AXI interconnect matrix clock gating disable This bit is set and reset by software.
        AXICKG: u1,
        /// AXI master AHB clock gating disable This bit is set and reset by software.
        AHBMCKG: u1,
        /// AXI master SDMMC1 clock gating disable This bit is set and reset by software.
        SDMMC1CKG: u1,
        /// AXI master HPDMA1 clock gating disable This bit is set and reset by software.
        HPDMA1CKG: u1,
        /// AXI master CPU clock gating disable This bit is set and reset by software.
        CPUCKG: u1,
        /// AXI master 0 GPU clock gating disable This bit is set and reset by software.
        GPUS0CKG: u1,
        /// AXI master 1 GPU clock gating disable This bit is set and reset by software.
        GPUS1CKG: u1,
        /// AXI master cache GPU clock gating disable This bit is set and reset by software.
        GPUCLCKG: u1,
        /// AXI master DCMIPP clock gating disable This bit is set and reset by software.
        DCMIPPCKG: u1,
        /// AXI master DMA2D clock gating disable This bit is set and reset by software.
        DMA2DCKG: u1,
        /// AXI matrix slave GFXMMU clock gating disable This bit is set and reset by software.
        GFXMMUSCKG: u1,
        /// AXI master LTDC clock gating disable This bit is set and reset by software.
        LTDCCKG: u1,
        /// AXI master GFXMMU clock gating disable This bit is set and reset by software.
        GFXMMUMCKG: u1,
        /// AXI slave AHB clock gating disable This bit is set and reset by software.
        AHBSCKG: u1,
        /// AXI slave FMC and MCE3 clock gating disable This bit is set and reset by software.
        FMCCKG: u1,
        /// AXI slave XSPI1 and MCE1 clock gating disable This bit is set and reset by software.
        XSPI1CKG: u1,
        /// AXI slave XSPI2 and MCE2 clock gating disable This bit is set and reset by software.
        XSPI2CKG: u1,
        /// AXI matrix slave SRAM4 clock gating disable This bit is set and reset by software.
        AXIRAM4CKG: u1,
        /// AXI matrix slave SRAM3 clock gating disable This bit is set and reset by software.
        AXIRAM3CKG: u1,
        /// AXI slave SRAM2 clock gating disable This bit is set and reset by software.
        AXIRAM2CKG: u1,
        /// AXI slave SRAM1 / error code correction (ECC) clock gating disable This bit is set and reset by software.
        AXIRAM1CKG: u1,
        /// AXI slave Flash interface (FLIFT) clock gating disable This bit is set and reset by software.
        FLITFCKG: u1,
        reserved30: u8 = 0,
        /// EXTI clock gating disable This bit is set and reset by software.
        EXTICKG: u1,
        /// JTAG automatic clock gating disabling This bit is set and reset by software.
        JTAGCKG: u1,
    }),
    /// offset: 0xb4
    reserved180: [12]u8,
    /// RCC PLL dividers configuration register 2.
    /// offset: 0xc0
    PLLDIVR2: [3]mmio.Mmio(packed struct(u32) {
        /// PLL1 DIVS division factor Set and reset by software to control the frequency of the pll1_s_ck clock. This post-divider performs divisions with 50% duty-cycle. The duty-cycle of 50% is guaranteed only in the following conditions: With VCOL, if (DIVS+1) is even, With VCOH, for all DIVS values These bits can be written only when the PLL1DIVSEN = 0.
        PLLS: PLLDIVST,
        reserved8: u5 = 0,
        /// PLL1 DIVT division factor Set and reset by software to control the frequency of the pll1_t_ck clock. This post-divider performs divisions with 50% duty-cycle. The duty-cycle of 50% is guaranteed only in the following conditions: With VCOL, if (DIVT+1) is even, With VCOH, for all DIVT values These bits can be written only when the PLL1DIVTEN = 0.
        PLLT: PLLDIVST,
        padding: u21 = 0,
    }),
    /// RCC PLL Spread Spectrum Clock Generator register.
    /// offset: 0xcc
    PLLSSCGR: [3]mmio.Mmio(packed struct(u32) {
        /// Modulation Period Adjustment for PLL1 Set and reset by software to adjust the modulation period of the clock spreading generator.
        MOD_PER: u13,
        /// Dithering TPDF noise control for PLL1 Set and reset by software. This bit is used to enable or disable the injection of a dithering noise into the SSCG modulator. This dithering noise is generated using a triangular probability density function.
        TPDFN_DIS1: u1,
        /// Dithering RPDF noise control for PLL1 Set and reset by software. This bit is used to enable or disable the injection of a dithering noise into the SSCG modulator. This dithering noise is generated using a rectangular probability density function.
        RPDFN_DIS1: u1,
        /// Spread spectrum clock generator mode for PLL1 Set and reset by software to select the clock spreading mode.
        DWNSPREAD1: DWNSPREAD,
        /// Modulation Depth Adjustment for PLL1 Set and reset by software to adjust the modulation depth of the clock spreading generator.
        INC_STEP: u15,
        padding: u1 = 0,
    }),
    /// offset: 0xd8
    reserved216: [40]u8,
    /// RCC clock protection register.
    /// offset: 0x100
    CKPROTR: mmio.Mmio(packed struct(u32) {
        /// XSPI clock protection Set and cleared by software. When set to 1, this bit prevents disabling accidentally the XSPIs. The following fields cannot be modified when this bit is set to 1: PLL2ON, PLL2DIVSEN, PLL2DIVTEN, HSEON, HSION, CSION, XSPIxEN, OCTOSPIxLPEN, OCTOSPIxRST.
        XSPICKP: u1,
        /// FMC clock protection Set and cleared by software. When set to 1, this bit prevents disabling accidentally the FMC. The following fields cannot be modified when this bit is set to 1: PLL1ON, PLL2ON, PLL1DIVQEN, PLL2DIVREN, HSEON, HSION, CSION, FMCEN, FMCLPEN, FMCRST.
        FMCCKP: u1,
        reserved4: u2 = 0,
        /// XSPI1 kernel clock switch position Set by hardware. This field can be used to verify the real position of XSPI2 kernel switch selector.
        XSPI1SWP: XSPISWP,
        reserved8: u1 = 0,
        /// XSPI2 kernel clock switch position Set by hardware. This field can be used to verify the real position of XSPI2 kernel switch selector.
        XSPI2SWP: XSPISWP,
        reserved12: u1 = 0,
        /// FMC kernel clock switch position Set by hardware. This field can be used to verify the real position of FMC kernel switch selector.
        FMCSWP: FMCSWP,
        padding: u17 = 0,
    }),
    /// offset: 0x104
    reserved260: [44]u8,
    /// RCC Reset status register.
    /// offset: 0x130
    RSR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// remove reset flag Set and reset by software to reset the value of the reset flags.
        RMVF: u1,
        /// Option byte loading reset flag <sup>(1)</sup> Reset by software by the RMVF bit. Set by hardware when a reset from the option byte loading occurs.
        OBLRSTF: u1,
        reserved21: u3 = 0,
        /// BOR reset flag <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when a BOR reset occurs (pwr_bor_rst).
        BORRSTF: u1,
        /// pin reset flag (NRST) <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when a reset from pin occurs.
        PINRSTF: u1,
        /// POR/PDR reset flag <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when a POR/PDR reset occurs.
        PORRSTF: u1,
        /// system reset from CPU reset flag <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when the system reset is due to CPU.The CPU can generate a system reset by writing SYSRESETREQ bit of AIRCR register of the core M7.
        SFTRSTF: u1,
        reserved26: u1 = 0,
        /// independent watchdog reset flag <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when an independent watchdog reset occurs.
        IWDGRSTF: u1,
        reserved28: u1 = 0,
        /// window watchdog reset flag <sup>(1)</sup> Reset by software by writing the RMVF bit. Set by hardware when a window watchdog reset occurs.
        WWDGRSTF: u1,
        reserved30: u1 = 0,
        /// reset due to illegal Stop or Standby flag Reset by software by writing the RMVF bit. Set by hardware when the CPU goes erroneously in Stop or Standby mode,.
        LPWRRSTF: u1,
        padding: u1 = 0,
    }),
    /// RCC AHB5 clock enable register.
    /// offset: 0x134
    AHB5ENR: mmio.Mmio(packed struct(u32) {
        /// HPDMA1 peripheral clock enable Set and reset by software.
        HPDMA1EN: u1,
        /// DMA2D peripheral clock enable Set and reset by software.
        DMA2DEN: u1,
        reserved3: u1 = 0,
        /// JPEG peripheral clock enable Set and reset by software.
        JPEGEN: u1,
        /// FMC and MCE3 peripheral clocks enable Set and reset by software. The hardware prevents writing this bit if FMCCKP = 1. The peripheral clocks of the FMC are the kernel clock selected by FMCSEL, and the hclk5 bus interface clock.
        FMCEN: u1,
        /// XSPI1 and MCE1 peripheral clocks enable Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI1EN: u1,
        reserved8: u2 = 0,
        /// SDMMC1 and DB_SDMMC1 peripheral clocks enable Set and reset by software.
        SDMMC1EN: u1,
        reserved12: u3 = 0,
        /// XSPI2 and MCE2 peripheral clocks enable Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI2EN: u1,
        reserved14: u1 = 0,
        /// XSPIM peripheral clock enable Set and reset by software.
        IOMNGREN: u1,
        reserved19: u4 = 0,
        /// GFXMMU peripheral clock enable Set and reset by software.
        GFXMMUEN: u1,
        /// GPU peripheral clock enable Set and reset by software.
        GPUEN: u1,
        padding: u11 = 0,
    }),
    /// RCC AHB1 clock enable register.
    /// offset: 0x138
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// GPDMA1 clock enable Set and reset by software.
        GPDMA1EN: u1,
        /// ADC1 and 2 peripheral clocks enable Set and reset by software. The peripheral clocks of the ADC1 and 2 are the kernel clock selected by ADCSEL and provided to ADCx_CK input, and the hclk1 bus interface clock.
        ADC12EN: u1,
        reserved15: u9 = 0,
        /// ETH1 MAC peripheral clock enable Set and reset by software.
        ETHEN: u1,
        /// ETH1 transmission clock enable Set and reset by software.
        ETHTXEN: u1,
        /// ETH1 reception clock enable Set and reset by software.
        ETHRXEN: u1,
        reserved25: u7 = 0,
        /// OTGHS clocks enable Set and reset by software.
        USB_OTG_HSEN: u1,
        /// USBPHYC clocks enable Set and reset by software.
        USBPHYCEN: u1,
        /// OTGFS peripheral clocks enable Set and reset by software.
        USB_OTG_FSEN: u1,
        reserved31: u3 = 0,
        /// ADF clocks enable Set and reset by software.
        ADFEN: u1,
    }),
    /// RCC AHB2 clock enable register.
    /// offset: 0x13c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PSSI peripheral clocks enable Set and reset by software.
        PSSIEN: u1,
        reserved9: u7 = 0,
        /// SDMMC2 and SDMMC2 delay clock enable Set and reset by software.
        SDMMC2EN: u1,
        reserved14: u4 = 0,
        /// CORDIC clock enable Set and reset by software.
        CORDICEN: u1,
        reserved29: u14 = 0,
        /// SRAM1 clock enable Set and reset by software.
        SRAM1EN: u1,
        /// SRAM2 clock enable Set and reset by software.
        SRAM2EN: u1,
        padding: u1 = 0,
    }),
    /// RCC AHB4 clock enable register.
    /// offset: 0x140
    AHB4ENR: mmio.Mmio(packed struct(u32) {
        /// GPIOA peripheral clock enable Set and reset by software.
        GPIOAEN: u1,
        /// GPIOB peripheral clock enable Set and reset by software.
        GPIOBEN: u1,
        /// GPIOC peripheral clock enable Set and reset by software.
        GPIOCEN: u1,
        /// GPIOD peripheral clock enable Set and reset by software.
        GPIODEN: u1,
        /// GPIOE peripheral clock enable Set and reset by software.
        GPIOEEN: u1,
        /// GPIOF peripheral clock enable Set and reset by software.
        GPIOFEN: u1,
        /// GPIOG peripheral clock enable Set and reset by software.
        GPIOGEN: u1,
        /// GPIOH peripheral clock enable Set and reset by software.
        GPIOHEN: u1,
        reserved12: u4 = 0,
        /// GPIOM peripheral clock enable Set and reset by software.
        GPIOMEN: u1,
        /// GPION peripheral clock enable Set and reset by software.
        GPIONEN: u1,
        /// GPIOO peripheral clock enable Set and reset by software.
        GPIOOEN: u1,
        /// GPIOP peripheral clock enable Set and reset by software.
        GPIOPEN: u1,
        reserved19: u3 = 0,
        /// CRC clock enable Set and reset by software.
        CRCEN: u1,
        reserved28: u8 = 0,
        /// Backup RAM clock enable Set and reset by software.
        BKPRAMEN: u1,
        padding: u3 = 0,
    }),
    /// RCC APB5 clock enable register.
    /// offset: 0x144
    APB5ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// LTDC peripheral clock enable Provides the pixel clock (ltdc_clk) to the LTDC block. Set and reset by software.
        LTDCEN: u1,
        /// DCMIPP peripheral clock enable Set and reset by software.
        DCMIPPEN: u1,
        reserved4: u1 = 0,
        /// GFXTIM peripheral clock enable Set and reset by software.
        GFXTIMEN: u1,
        padding: u27 = 0,
    }),
    /// RCC APB1 clock enable register 1.
    /// offset: 0x148
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 peripheral clock enable Set and reset by software.
        TIM2EN: u1,
        /// TIM3 peripheral clock enable Set and reset by software.
        TIM3EN: u1,
        /// TIM4 peripheral clock enable Set and reset by software.
        TIM4EN: u1,
        /// TIM5 peripheral clock enable Set and reset by software.
        TIM5EN: u1,
        /// TIM6 peripheral clock enable Set and reset by software.
        TIM6EN: u1,
        /// TIM7 peripheral clock enable Set and reset by software.
        TIM7EN: u1,
        /// TIM12 peripheral clock enable Set and reset by software.
        TIM12EN: u1,
        /// TIM13 peripheral clock enable Set and reset by software.
        TIM13EN: u1,
        /// TIM14 peripheral clock enable Set and reset by software.
        TIM14EN: u1,
        /// LPTIM1 peripheral clocks enable Set and reset by software. The peripheral clocks of the LPTIM1 are the kernel clock selected by LPTIM1SEL and provided to clk_lpt input, and the rcc_pclk1 bus interface clock.
        LPTIM1EN: u1,
        reserved11: u1 = 0,
        /// WWDG clock enable Set by software, and reset by hardware when a system reset occurs.
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 peripheral clocks enable Set and reset by software. The peripheral clocks of the SPI2 are the kernel clock selected by I2S123SRC and provided to com_clk input, and the rcc_pclk1 bus interface clock.
        SPI2EN: u1,
        /// SPI3 peripheral clocks enable Set and reset by software. The peripheral clocks of the SPI3 are the kernel clock selected by I2S123SRC and provided to com_clk input, and the rcc_pclk1 bus interface clock.
        SPI3EN: u1,
        /// SPDIFRX peripheral clocks enable Set and reset by software. The peripheral clocks of the SPDIFRX are the kernel clock selected by SPDIFRXSEL and provided to SPDIFRX_CLK input, and the rcc_pclk1 bus interface clock.
        SPDIFRXEN: u1,
        /// USART2peripheral clocks enable Set and reset by software. The peripheral clocks of the USART2 are the kernel clock selected by USART234578SEL and provided to UCLK input, and the rcc_pclk1 bus interface clock.
        USART2EN: u1,
        /// USART3 peripheral clocks enable Set and reset by software. The peripheral clocks of the USART3 are the kernel clock selected by USART234578SEL and provided to UCLK input, and the rcc_pclk1 bus interface clock.
        USART3EN: u1,
        /// UART4 peripheral clocks enable Set and reset by software. The peripheral clocks of the UART4 are the kernel clock selected by USART234578SEL and provided to UCLK input, and the rcc_pclk1 bus interface clock.
        UART4EN: u1,
        /// UART5 peripheral clocks enable Set and reset by software.
        UART5EN: u1,
        /// I2C1/I3C1 peripheral clocks enable Set and reset by software.
        I2C1_I3C1EN: u1,
        /// I2C2 peripheral clocks enable Set and reset by software.
        I2C2EN: u1,
        /// I2C3 peripheral clocks enable Set and reset by software.
        I2C3EN: u1,
        reserved27: u3 = 0,
        /// HDMI-CEC peripheral clock enable Set and reset by software.
        CECEN: u1,
        reserved30: u2 = 0,
        /// UART7 peripheral clocks enable Set and reset by software.
        UART7EN: u1,
        /// UART8 peripheral clocks enable Set and reset by software.
        UART8EN: u1,
    }),
    /// RCC APB1 clock enable register 2.
    /// offset: 0x14c
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// clock recovery system peripheral clock enable Set and reset by software.
        CRSEN: u1,
        reserved5: u3 = 0,
        /// MDIOS peripheral clock enable Set and reset by software.
        MDIOSEN: u1,
        reserved8: u2 = 0,
        /// FDCAN peripheral clock enable Set and reset by software.
        FDCANEN: u1,
        reserved27: u18 = 0,
        /// UCPD peripheral clock enable Set and reset by software.
        UCPDEN: u1,
        padding: u4 = 0,
    }),
    /// RCC APB2 clock enable register.
    /// offset: 0x150
    APB2ENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 peripheral clock enable Set and reset by software.
        TIM1EN: u1,
        reserved4: u3 = 0,
        /// USART1 peripheral clocks enable Set and reset by software. The peripheral clocks of the USART1 are the kernel clock selected by USART1SEL, and the pclk2 bus interface clock.
        USART1EN: u1,
        reserved12: u7 = 0,
        /// SPI2S1 Peripheral Clocks Enable Set and reset by software. The peripheral clocks of the SPI2S1 are: the kernel clock selected by SPI1SEL, and the pclk2 bus interface clock.
        SPI1EN: u1,
        /// SPI4 Peripheral Clocks Enable Set and reset by software. The peripheral clocks of the SPI4 are: the kernel clock selected by SPI45SEL, and the pclk2 bus interface clock.
        SPI4EN: u1,
        reserved16: u2 = 0,
        /// TIM15 peripheral clock enable Set and reset by software.
        TIM15EN: u1,
        /// TIM16 peripheral clock enable Set and reset by software.
        TIM16EN: u1,
        /// TIM17 peripheral clock enable Set and reset by software.
        TIM17EN: u1,
        /// TIM9 peripheral clock enable Set and reset by software.
        TIM9EN: u1,
        /// SPI5 peripheral clocks enable Set and reset by software. The peripheral clocks of the SPI5 are the kernel clock selected by SPI45SEL, and the pclk2 bus interface clock.
        SPI5EN: u1,
        reserved22: u1 = 0,
        /// SAI1 peripheral clocks enable Set and reset by software. The peripheral clocks of the SAI1 are the kernel clock selected by SAI1SEL, and the pclk2 bus interface clock.
        SAI1EN: u1,
        /// SAI2 peripheral clocks enable Set and reset by software. The peripheral clocks of the SAI2 are the kernel clock selected by SAI2SEL, and the pclk2 bus interface clock.
        SAI2EN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB4 clock enable register.
    /// offset: 0x154
    APB4ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS peripheral clock enable Set and reset by software.
        SYSCFGEN: u1,
        reserved3: u1 = 0,
        /// LPUART1 peripheral clocks enable Set and reset by software. The peripheral clocks of the LPUART1 are the kernel clock selected by LPUART1SEL and provided to UCLK input, and the pclk4 bus interface clock.
        LPUART1EN: u1,
        reserved5: u1 = 0,
        /// SPI/I2S6 peripheral clocks enable Set and reset by software. The peripheral clocks of the SPI/I2S6 are the kernel clock selected by SPI6SEL and provided to com_clk input, and the pclk4 bus interface clock.
        SPI6EN: u1,
        reserved9: u3 = 0,
        /// LPTIM2 peripheral clocks enable Set and reset by software. The LPTIM2 kernel clock can be selected by LPTIM23SEL.
        LPTIM2EN: u1,
        /// LPTIM3 peripheral clocks enable Set and reset by software. The LPTIM3 kernel clock can be selected by LPTIM23SEL.
        LPTIM3EN: u1,
        /// LPTIM4 peripheral clocks enable Set and reset by software. The LPTIM4 kernel clock can be selected by LPTIM45SEL.
        LPTIM4EN: u1,
        /// LPTIM5 peripheral clocks enable Set and reset by software. The LPTIM5 kernel clock can be selected by LPTIM45SEL.
        LPTIM5EN: u1,
        reserved15: u2 = 0,
        /// VREF peripheral clock enable Set and reset by software.
        VREFEN: u1,
        /// RTC APB clock enable Set and reset by software.
        RTCAPBEN: u1,
        reserved26: u9 = 0,
        /// Temperature Sensor peripheral clock enable Set and reset by software.
        TMPSENSEN: u1,
        padding: u5 = 0,
    }),
    /// RCC AHB3 clock enable register.
    /// offset: 0x158
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// RNG peripheral clocks enable Set and reset by software.
        RNGEN: u1,
        /// HASH peripheral clock enable Set and reset by software.
        HASHEN: u1,
        /// CRYP peripheral clock enable Set and reset by software.
        CRYPEN: u1,
        reserved4: u1 = 0,
        /// SAES peripheral clock enable Set and reset by software. This bit controls the enable of the clock delivered to the SAES.
        SAESEN: u1,
        reserved6: u1 = 0,
        /// PKA peripheral clock enable Set and reset by software.
        PKAEN: u1,
        padding: u25 = 0,
    }),
    /// RCC AHB5 low-power clock enable register.
    /// offset: 0x15c
    AHB5LPENR: mmio.Mmio(packed struct(u32) {
        /// HPDMA1 low-power peripheral clock enable Set and reset by software.
        HPDMA1LPEN: u1,
        /// DMA2D low-power peripheral clock enable Set and reset by software.
        DMA2DLPEN: u1,
        /// FLITF low-power peripheral clock enable Set and reset by software.
        FLITFLPEN: u1,
        /// JPEG clock enable during Sleep mode Set and reset by software.
        JPEGLPEN: u1,
        /// FMC and MCE3 peripheral clocks enable during Sleep mode Set and reset by software. The hardware prevents writing this bit if FMCCKP = 1. The peripheral clocks of the FMC are the kernel clock selected by FMCSEL, and the hclk5 bus interface clock.
        FMCLPEN: u1,
        /// XSPI1 and MCE1 low-power peripheral clock enable Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI1LPEN: u1,
        reserved8: u2 = 0,
        /// SDMMC1 and SDMMC1 delay low-power peripheral clock enable Set and reset by software.
        SDMMC1LPEN: u1,
        reserved12: u3 = 0,
        /// XSPI2 and MCE2 low-power peripheral clock enable Set and reset by software. The hardware prevents writing this bit if XSPICKP = 1.
        XSPI2LPEN: u1,
        reserved14: u1 = 0,
        /// XSPIM low-power peripheral clock enable Set and reset by software.
        XSPIMLPEN: u1,
        reserved19: u4 = 0,
        /// GFXMMU low-power peripheral clock enable Set and reset by software.
        GFXMMULPEN: u1,
        /// GPU low-power peripheral clock enable Set and reset by software.
        GPULPEN: u1,
        reserved28: u7 = 0,
        /// DTCM1 low-power peripheral clock enable Set and reset by software.
        DTCM1LPEN: u1,
        /// DTCM2 low-power peripheral clock enable Set and reset by software.
        DTCM2LPEN: u1,
        /// ITCM low-power peripheral clock enable Set and reset by software.
        ITCMLPEN: u1,
        /// AXISRAM[4:1] low-power peripheral clock enable Set and reset by software.
        AXISRAMLPEN: u1,
    }),
    /// RCC AHB1 low-power clock enable register.
    /// offset: 0x160
    AHB1LPENR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// GPDMA1 clock enable in low-power mode Set and reset by software.
        GPDMA1LPEN: u1,
        /// ADC1 and 2 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the ADC1 and 2 are the kernel clock selected by ADCSEL and provided to ADCx_CK input, and the rcc_hclk1 bus interface clock.
        ADC12LPEN: u1,
        reserved15: u9 = 0,
        /// ETH1 MAC peripheral clock enable in low-power mode Set and reset by software.
        ETHLPEN: u1,
        /// ETH1 transmission peripheral clock enable in low-power mode Set and reset by software.
        ETHTXLPEN: u1,
        /// ETH1 reception peripheral clock enable in low-power mode Set and reset by software.
        ETHRXLPEN: u1,
        reserved24: u6 = 0,
        /// USBPHYC common block power-down control Set and reset by software.
        USBPDCTRL: USBPDCTRL,
        /// OTGHS peripheral clock enable in low-power mode Set and reset by software.
        USB_OTG_HSLPEN: u1,
        /// USBPHYC peripheral clock enable in low-power mode Set and reset by software.
        USBPHYCLPEN: u1,
        /// OTGFS clock enable in low-power mode Set and reset by software.
        USB_OTG_FSLPEN: u1,
        reserved31: u3 = 0,
        /// ADF clock enable in low-power mode Set and reset by software.
        ADFLPEN: u1,
    }),
    /// RCC AHB2 low-power clock enable register.
    /// offset: 0x164
    AHB2LPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// PSSI peripheral clock enable in low-power mode Set and reset by software.
        PSSILPEN: u1,
        reserved9: u7 = 0,
        /// SDMMC2 and SDMMC2 delay clock enable in low-power mode Set and reset by software.
        SDMMC2LPEN: u1,
        reserved14: u4 = 0,
        /// CORDIC clock enable in low-power mode Set and reset by software.
        CORDICLPEN: u1,
        reserved29: u14 = 0,
        /// SRAM1 clock enable in low-power mode Set and reset by software.
        SRAM1LPEN: u1,
        /// SRAM2 clock enable in low-power mode Set and reset by software.
        SRAM2LPEN: u1,
        padding: u1 = 0,
    }),
    /// RCC AHB4 low-power clock enable register.
    /// offset: 0x168
    AHB4LPENR: mmio.Mmio(packed struct(u32) {
        /// GPIOA peripheral clock enable in low-power mode Set and reset by software.
        GPIOALPEN: u1,
        /// GPIOB peripheral clock enable in low-power mode Set and reset by software.
        GPIOBLPEN: u1,
        /// GPIOC peripheral clock enable in low-power mode Set and reset by software.
        GPIOCLPEN: u1,
        /// GPIOD peripheral clock enable in low-power mode Set and reset by software.
        GPIODLPEN: u1,
        /// GPIOE peripheral clock enable in low-power mode Set and reset by software.
        GPIOELPEN: u1,
        /// GPIOF peripheral clock enable in low-power mode Set and reset by software.
        GPIOFLPEN: u1,
        /// GPIOG peripheral clock enable in low-power mode Set and reset by software.
        GPIOGLPEN: u1,
        /// GPIOH peripheral clock enable in low-power mode Set and reset by software.
        GPIOHLPEN: u1,
        reserved12: u4 = 0,
        /// GPIOM peripheral clock enable in low-power mode Set and reset by software.
        GPIOMLPEN: u1,
        /// GPION peripheral clock enable in low-power mode Set and reset by software.
        GPIONLPEN: u1,
        /// GPIOO peripheral clock enable in low-power mode Set and reset by software.
        GPIOOLPEN: u1,
        /// GPIOP peripheral clock enable in low-power mode Set and reset by software.
        GPIOPLPEN: u1,
        reserved19: u3 = 0,
        /// CRC clock enable in low-power mode Set and reset by software.
        CRCLPEN: u1,
        reserved28: u8 = 0,
        /// Backup RAM clock enable in low-power mode Set and reset by software.
        BKPRAMLPEN: u1,
        padding: u3 = 0,
    }),
    /// RCC AHB3 low-power clock enable register.
    /// offset: 0x16c
    AHB3LPENR: mmio.Mmio(packed struct(u32) {
        /// RNG peripheral clock enable in low-power mode Set and reset by software.
        RNGLPEN: u1,
        /// HASH peripheral clock enable in low-power mode Set and reset by software.
        HASHLPEN: u1,
        /// CRYP peripheral clock enable in low-power mode Set and reset by software.
        CRYPLPEN: u1,
        reserved4: u1 = 0,
        /// SAES peripheral clock enable in low-power mode Set and reset by software.
        SAESLPEN: u1,
        reserved6: u1 = 0,
        /// PKA peripheral clock enable in low-power mode Set and reset by software.
        PKALPEN: u1,
        padding: u25 = 0,
    }),
    /// RCC APB1 low-power clock enable register 1.
    /// offset: 0x170
    APB1LPENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 peripheral clock enable in low-power mode Set and reset by software.
        TIM2LPEN: u1,
        /// TIM3 peripheral clock enable in low-power mode Set and reset by software.
        TIM3LPEN: u1,
        /// TIM4 peripheral clock enable in low-power mode Set and reset by software.
        TIM4LPEN: u1,
        /// TIM5 peripheral clock enable in low-power mode Set and reset by software.
        TIM5LPEN: u1,
        /// TIM6 peripheral clock enable in low-power mode Set and reset by software.
        TIM6LPEN: u1,
        /// TIM7 peripheral clock enable in low-power mode Set and reset by software.
        TIM7LPEN: u1,
        /// TIM12 peripheral clock enable in low-power mode Set and reset by software.
        TIM12LPEN: u1,
        /// TIM13 peripheral clock enable in low-power mode Set and reset by software.
        TIM13LPEN: u1,
        /// TIM14 peripheral clock enable in low-power mode Set and reset by software.
        TIM14LPEN: u1,
        /// LPTIM1 peripheral clocks enable in low-power mode Set and reset by software.
        LPTIM1LPEN: u1,
        reserved11: u1 = 0,
        /// WWDG clock enable in low-power mode Set and reset by software.
        WWDGLPEN: u1,
        reserved14: u2 = 0,
        /// SPI2 peripheral clocks enable in low-power mode Set and reset by software.
        SPI2LPEN: u1,
        /// SPI3 peripheral clocks enable in low-power mode Set and reset by software.
        SPI3LPEN: u1,
        /// SPDIFRX peripheral clocks enable in low-power mode Set and reset by software.
        SPDIFRXLPEN: u1,
        /// USART2 peripheral clocks enable in low-power mode Set and reset by software.
        USART2LPEN: u1,
        /// USART3 peripheral clocks enable in low-power mode Set and reset by software.
        USART3LPEN: u1,
        /// UART4 peripheral clocks enable in low-power mode Set and reset by software.
        UART4LPEN: u1,
        /// UART5 peripheral clocks enable in low-power mode Set and reset by software.
        UART5LPEN: u1,
        /// I2C1/I3C1 peripheral clocks enable in low-power mode Set and reset by software.
        I2C1_I3C1LPEN: u1,
        /// I2C2 peripheral clocks enable in low-power mode Set and reset by software.
        I2C2LPEN: u1,
        /// I2C3 peripheral clocks enable in low-power mode Set and reset by software.
        I2C3LPEN: u1,
        reserved27: u3 = 0,
        /// HDMI-CEC peripheral clocks enable in low-power mode Set and reset by software.
        CECLPEN: u1,
        reserved30: u2 = 0,
        /// UART7 peripheral clocks enable in low-power mode Set and reset by software.
        UART7LPEN: u1,
        /// UART8 peripheral clocks enable in low-power mode Set and reset by software.
        UART8LPEN: u1,
    }),
    /// RCC APB1 low-power clock enable register 2.
    /// offset: 0x174
    APB1LPENR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// clock recovery system peripheral clock enable in low-power mode Set and reset by software.
        CRSLPEN: u1,
        reserved5: u3 = 0,
        /// MDIOS peripheral clock enable in low-power mode Set and reset by software.
        MDIOSLPEN: u1,
        reserved8: u2 = 0,
        /// FDCAN peripheral clock enable in low-power mode Set and reset by software.
        FDCANLPEN: u1,
        reserved27: u18 = 0,
        /// UCPD peripheral clock enable in low-power mode Set and reset by software.
        UCPDLPEN: u1,
        padding: u4 = 0,
    }),
    /// RCC APB2 low-power clock enable register.
    /// offset: 0x178
    APB2LPENR: mmio.Mmio(packed struct(u32) {
        /// TIM1 peripheral clock enable in low-power mode Set and reset by software.
        TIM1LPEN: u1,
        reserved4: u3 = 0,
        /// USART1 peripheral clock enable in low-power mode Set and reset by software. The peripheral clocks of the USART1 are the kernel clock selected by USART169SEL and provided to UCLK inputs, and the pclk2 bus interface clock.
        USART1LPEN: u1,
        reserved12: u7 = 0,
        /// SPI2S1 peripheral clock enable in low-power mode Set and reset by software. The peripheral clocks of the SPI2S1 are: the kernel clock selected by I2S1SEL and provided to spi_ker_ck input, and the pclk2 bus interface clock.
        SPI1LPEN: u1,
        /// SPI4 peripheral clock enable in low-power mode Set and reset by software. The peripheral clocks of the SPI4 are: the kernel clock selected by SPI45SEL and provided to com_clk input, and the pclk2 bus interface clock.
        SPI4LPEN: u1,
        reserved16: u2 = 0,
        /// TIM15 peripheral clock enable in low-power mode Set and reset by software.
        TIM15LPEN: u1,
        /// TIM16 peripheral clock enable in low-power mode Set and reset by software.
        TIM16LPEN: u1,
        /// TIM17 peripheral clock enable in low-power mode Set and reset by software.
        TIM17LPEN: u1,
        /// TIM9 peripheral clock enable in low-power mode Set and reset by software.
        TIM9LPEN: u1,
        /// SPI5 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the SPI5 are the kernel clock selected by SPI45SEL and provided to com_clk input, and the pclk2 bus interface clock.
        SPI5LPEN: u1,
        reserved22: u1 = 0,
        /// SAI1 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the SAI1 are: the kernel clock selected by SAI1SEL and provided to SAI_CK_A and SAI_CK_B inputs, and the pclk2 bus interface clock.
        SAI1LPEN: u1,
        /// SAI2 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the SAI2 are: the kernel clock selected by SAI2SEL and provided to SAI_CK_A and SAI_CK_B inputs, and the pclk2 bus interface clock.
        SAI2LPEN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB4 low-power clock enable register.
    /// offset: 0x17c
    APB4LPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SBS peripheral clock enable in low-power mode Set and reset by software.
        SYSCFGLPEN: u1,
        reserved3: u1 = 0,
        /// LPUART1 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the LPUART1 are the kernel clock selected by LPUART1SEL and provided to UCLK input, and the rcc_pclk4 bus interface clock.
        LPUART1LPEN: u1,
        reserved5: u1 = 0,
        /// SPI/I2S6 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the SPI/I2S6 are the kernel clock selected by SPI6SEL and provided to com_ck input, and the rcc_pclk4 bus interface clock.
        SPI6LPEN: u1,
        reserved9: u3 = 0,
        /// LPTIM2 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the LPTIM2 are the kernel clock selected by LPTIM23SEL and provided to clk_lpt input, and the pclk4 bus interface clock.
        LPTIM2LPEN: u1,
        /// LPTIM3 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the LPTIM3 are the kernel clock selected by LPTIM23SEL and provided to clk_lpt input, and the pclk4 bus interface clock.
        LPTIM3LPEN: u1,
        /// LPTIM4 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the LPTIM4 are the kernel clock selected by LPTIM45SEL and provided to clk_lpt input, and the pclk4 bus interface clock.
        LPTIM4LPEN: u1,
        /// LPTIM5 peripheral clocks enable in low-power mode Set and reset by software. The peripheral clocks of the LPTIM5 are the kernel clock selected by LPTIM45SEL and provided to clk_lpt input, and the pclk4 bus interface clock.
        LPTIM5LPEN: u1,
        reserved15: u2 = 0,
        /// VREF peripheral clock enable in low-power mode Set and reset by software.
        VREFLPEN: u1,
        /// RTC APB clock enable in low-power mode Set and reset by software.
        RTCAPBLPEN: u1,
        reserved26: u9 = 0,
        /// temperature sensor peripheral clock enable in low-power mode Set and reset by software.
        TMPSENSLPEN: u1,
        padding: u5 = 0,
    }),
    /// RCC APB5 sleep clock register.
    /// offset: 0x180
    APB5LPENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// LTDC peripheral clock enable in low-power mode Set and reset by software.
        LTDCLPEN: u1,
        /// DCMIPP peripheral clock enable in low-power mode Set and reset by software.
        DCMIPPLPEN: u1,
        reserved4: u1 = 0,
        /// GFXTIM peripheral clock enable in low-power mode Set and reset by software.
        GFXTIMLPEN: u1,
        padding: u27 = 0,
    }),
};
