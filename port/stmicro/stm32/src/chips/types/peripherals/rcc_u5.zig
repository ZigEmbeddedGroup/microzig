const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCDACSEL = enum(u3) {
    /// HCLK clock selected
    HCLK1 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// PLL2 R (pll2_r_ck) selected
    PLL2_R = 0x2,
    /// HSE clock selected
    HSE = 0x3,
    /// HSI clock selected
    HSI = 0x4,
    /// MSIK clock selected
    MSIK = 0x5,
    _,
};

pub const ADFSEL = enum(u3) {
    /// HCLK selected
    HCLK3 = 0x0,
    /// PLL1 P (pll1_p_ck) selected
    PLL1_P = 0x1,
    /// PLL3 Q (pll3_q_ck) selected
    PLL3_Q = 0x2,
    /// input pin AUDIOCLK selected
    AUDIOCLK = 0x3,
    /// MSIK clock selected
    MSIK = 0x4,
    _,
};

pub const DACSEL = enum(u1) {
    /// LSE selected
    LSE = 0x0,
    /// LSI selected
    LSI = 0x1,
};

pub const DPRE = enum(u3) {
    /// DCLK not divided
    Div1 = 0x0,
    /// DCLK divided by 2
    Div2 = 0x4,
    /// DCLK divided by 4
    Div4 = 0x5,
    /// DCLK divided by 8
    Div8 = 0x6,
    /// DCLK divided by 16
    Div16 = 0x7,
    _,
};

pub const DSISEL = enum(u1) {
    /// PLL3 “P” (pll3_p_ck) selected
    PLL3_P = 0x0,
    /// DSI PHY PLL output selected (formerly called DCLK, renamed to DSI_PHY to match other chip families)
    DSI_PHY = 0x1,
};

pub const FDCANSEL = enum(u2) {
    /// HSE clock selected
    HSE = 0x0,
    /// PLL1 Q (pll1_q_ck) selected
    PLL1_Q = 0x1,
    /// PLL2 P (pll2_p_ck) selected
    PLL2_P = 0x2,
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

pub const HSEEXT = enum(u1) {
    /// external HSE clock analog mode
    ANALOG = 0x0,
    /// external HSE clock digital mode (through I/O Schmitt trigger)
    DIGITAL = 0x1,
};

pub const HSPISEL = enum(u2) {
    /// SYSCLK selected
    SYS = 0x0,
    /// PLL1 “Q” (pll1_q_ck) selected, can be up to 200 MHz
    PLL1_Q = 0x1,
    /// PLL2 “Q” (pll2_q_ck) selected, can be up to 200 MHz
    PLL2_Q = 0x2,
    /// PLL3 “R” (pll3_r_ck) selected, can be up to 200 MHz
    PLL3_R = 0x3,
};

pub const I2C3SEL = enum(u2) {
    /// PCLK3 selected
    PCLK3 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// MSIK selected
    MSIK = 0x3,
};

pub const I2CSEL = enum(u2) {
    /// PCLK1 selected
    PCLK1 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// MSIK selected
    MSIK = 0x3,
};

pub const ICLKSEL = enum(u2) {
    /// HSI48 clock selected
    HSI48 = 0x0,
    /// PLL2 Q (pll2_q_ck) selected
    PLL2_Q = 0x1,
    /// PLL1 Q (pll1_q_ck) selected
    PLL1_Q = 0x2,
    /// MSIK clock selected
    MSIK = 0x3,
};

pub const LPTIM2SEL = enum(u2) {
    /// PCLK1 selected
    PCLK1 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const LPTIMSEL = enum(u2) {
    /// PCLK3 selected
    PCLK3 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const LPUSARTSEL = enum(u3) {
    /// PCLK3 selected
    PCLK3 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
    /// MSIK selected
    MSIK = 0x4,
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

pub const LSIPREDIV = enum(u1) {
    /// LSI not divided
    Div1 = 0x0,
    /// LSI divided by 128
    Div128 = 0x1,
};

pub const LTDCSEL = enum(u1) {
    /// PLL3 “R” (pll3_r_ck) selected
    PLL3_R = 0x0,
    /// PLL2 “R” (pll2_r_ck) selected
    PLL2_R = 0x1,
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
    /// MSIS clock selected
    MSIS = 0x2,
    /// HSI clock selected
    HSI = 0x3,
    /// HSE clock selected
    HSE = 0x4,
    /// Main PLL clock pll1_r_ck selected
    PLL1_R = 0x5,
    /// LSI clock selected
    LSI = 0x6,
    /// LSE clock selected
    LSE = 0x7,
    /// Internal HSI48 clock selected
    HSI48 = 0x8,
    /// MSIK clock selected
    MSIK = 0x9,
    _,
};

pub const MDFSEL = enum(u3) {
    /// HCLK selected
    HCLK1 = 0x0,
    /// PLL1 P (pll1_p_ck) selected
    PLL1_P = 0x1,
    /// PLL3 Q (pll3_q_ck) selected
    PLL3_Q = 0x2,
    /// input pin AUDIOCLK selected
    AUDIOCLK = 0x3,
    /// MSIK clock selected
    MSIK = 0x4,
    _,
};

pub const MSIBIAS = enum(u1) {
    /// MSI bias continuous mode (clock accuracy fast settling time)
    CONTINUOUS = 0x0,
    /// MSI bias sampling mode (ultra-low-power mode)
    SAMPLING = 0x1,
};

pub const MSIPLLFAST = enum(u1) {
    /// MSI PLL normal start-up
    NORMAL = 0x0,
    /// MSI PLL fast start-up
    FAST = 0x1,
};

pub const MSIPLLSEL = enum(u1) {
    /// PLL mode applied to MSIK (MSI kernel) clock output
    MSIK = 0x0,
    /// PLL mode applied to MSIS (MSI system) clock output
    MSIS = 0x1,
};

pub const MSIRANGE = enum(u4) {
    /// range 0 around 48 MHz
    RANGE_48MHZ = 0x0,
    /// range 1 around 24 MHz
    RANGE_24MHZ = 0x1,
    /// range 2 around 16 MHz
    RANGE_16MHZ = 0x2,
    /// range 3 around 12 MHz
    RANGE_12MHZ = 0x3,
    /// range 4 around 4 MHz (reset value)
    RANGE_4MHZ = 0x4,
    /// range 5 around 2 MHz
    RANGE_2MHZ = 0x5,
    /// range 6 around 1.33 MHz
    RANGE_1_33MHZ = 0x6,
    /// range 7 around 1 MHz
    RANGE_1MHZ = 0x7,
    /// range 8 around 3.072 MHz
    RANGE_3_072MHZ = 0x8,
    /// range 9 around 1.536 MHz
    RANGE_1_536MHZ = 0x9,
    /// range 10 around 1.024 MHz
    RANGE_1_024MHZ = 0xa,
    /// range 11 around 768 kHz
    RANGE_768KHZ = 0xb,
    /// range 12 around 400 kHz
    RANGE_400KHZ = 0xc,
    /// range 13 around 200 kHz
    RANGE_200KHZ = 0xd,
    /// range 14 around 133 kHz
    RANGE_133KHZ = 0xe,
    /// range 15 around 100 kHz
    RANGE_100KHZ = 0xf,
};

pub const MSIRGSEL = enum(u1) {
    /// MSIS/MSIK ranges provided by MSISSRANGE[3:0] and MSIKSRANGE[3:0] in RCC_CSR
    CSR = 0x0,
    /// MSIS/MSIK ranges provided by MSISRANGE[3:0] and MSIKRANGE[3:0] in RCC_ICSCR1
    ICSCR1 = 0x1,
};

pub const MSIXSRANGE = enum(u4) {
    /// range 4 around 4M Hz (reset value)
    RANGE_4MHZ = 0x4,
    /// range 5 around 2 MHz
    RANGE_2MHZ = 0x5,
    /// range 6 around 1.5 MHz
    RANGE_1_5MHZ = 0x6,
    /// range 7 around 1 MHz
    RANGE_1MHZ = 0x7,
    /// range 8 around 3.072 MHz
    RANGE_3_072MHZ = 0x8,
    _,
};

pub const OCTOSPISEL = enum(u2) {
    /// SYSCLK selected
    SYS = 0x0,
    /// MSIK selected
    MSIK = 0x1,
    /// PLL1 Q (pll1_q_ck) selected, can be up to 200 MHz
    PLL1_Q = 0x2,
    /// PLL2 Q (pll2_q_ck) selected, can be up to 200 MHz
    PLL2_Q = 0x3,
};

pub const OTGHSSEL = enum(u2) {
    /// HSE selected
    HSE = 0x0,
    /// PLL1 “P” (pll1_q_ck) selected,
    PLL1_P = 0x1,
    /// HSE/2 selected
    HSE_DIV_2 = 0x2,
    /// PLL1 “P” divided by 2 (pll1_p_ck/2) selected
    PLL1_P_DIV_2 = 0x3,
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

pub const PLLMBOOST = enum(u4) {
    /// division by 1 (bypass)
    Div1 = 0x0,
    /// division by 2
    Div2 = 0x1,
    /// division by 4
    Div4 = 0x2,
    /// division by 6
    Div6 = 0x3,
    /// division by 8
    Div8 = 0x4,
    /// division by 10
    Div10 = 0x5,
    /// division by 12
    Div12 = 0x6,
    /// division by 14
    Div14 = 0x7,
    /// division by 16
    Div16 = 0x8,
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
    /// PLL2 input (ref2_ck) clock range frequency between 4 and 8 MHz
    FREQ_4TO8MHZ = 0x0,
    /// PLL2 input (ref2_ck) clock range frequency between 8 and 16 MHz
    FREQ_8TO16MHZ = 0x3,
    _,
};

pub const PLLSRC = enum(u2) {
    /// No clock sent to PLL3
    DISABLE = 0x0,
    /// MSIS clock selected as PLL3 clock entry
    MSIS = 0x1,
    /// HSI clock selected as PLL3 clock entry
    HSI = 0x2,
    /// HSE clock selected as PLL3 clock entry
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
    /// HSI48 selected
    HSI48 = 0x0,
    /// HSI48 / 2 selected, can be used in Range 4
    HSI48_DIV_2 = 0x1,
    /// HSI selected
    HSI = 0x2,
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

pub const SAESSEL = enum(u1) {
    /// SHSI selected
    SHSI = 0x0,
    /// SHSI / 2 selected, can be used in Range 4
    SHSI_DIV_2 = 0x1,
};

pub const SAISEL = enum(u3) {
    /// PLL2 P (pll2_p_ck) selected
    PLL2_P = 0x0,
    /// PLL3 P (pll3_p_ck) selected
    PLL3_P = 0x1,
    /// PLL1 P (pll1_p_ck) selected
    PLL1_P = 0x2,
    /// input pin AUDIOCLK selected
    AUDIOCLK = 0x3,
    /// HSI clock selected
    HSI = 0x4,
    _,
};

pub const SDMMCSEL = enum(u1) {
    /// ICLK clock selected
    ICLK = 0x0,
    /// PLL1 P (pll1_p_ck) selected, in case higher than 48 MHz is needed (for SDR50 mode)
    PLL1_P = 0x1,
};

pub const SECURITY = enum(u1) {
    /// non secure
    NON_SECURE = 0x0,
    /// secure
    SECURE = 0x1,
};

pub const SPI1SEL = enum(u2) {
    /// PCLK2 selected
    PCLK2 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// MSIK selected
    MSIK = 0x3,
};

pub const SPI2SEL = enum(u2) {
    /// PCLK2 selected
    PCLK1 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// MSIK selected
    MSIK = 0x3,
};

pub const SPI3SEL = enum(u2) {
    /// PCLK2 selected
    PCLK3 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// MSIK selected
    MSIK = 0x3,
};

pub const STOPKERWUCK = enum(u1) {
    /// MSIK oscillator automatically enabled when exiting Stop mode
    MSIK = 0x0,
    /// HSI oscillator automatically enabled when exiting Stop mode
    HSI = 0x1,
};

pub const STOPWUCK = enum(u1) {
    /// MSIS oscillator selected as wakeup from stop clock and CSS backup clock
    MSIS = 0x0,
    /// HSI oscillator selected as wakeup from stop clock and CSS backup clock
    HSI = 0x1,
};

pub const SW = enum(u2) {
    /// MSIS selected as system clock
    MSIS = 0x0,
    /// HSI selected as system clock
    HSI = 0x1,
    /// HSE selected as system clock
    HSE = 0x2,
    /// PLL pll1_r_ck selected as system clock
    PLL1_R = 0x3,
};

pub const SYSTICKSEL = enum(u2) {
    /// HCLK/8 selected
    HCLK1_DIV_8 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// LSE selected
    LSE = 0x2,
    _,
};

pub const TIMICSEL = enum(u3) {
    /// No sources can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    DISABLE = 0x0,
    /// HSI/256, MSIS/1024 and MSIS/4 generated and can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    HSI256_MSIS1024_MSIS4 = 0x4,
    /// HSI/256, MSIS/1024 and MSIK/4 generated and can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    HSI256_MSIS1024_MSIK4 = 0x5,
    /// HSI/256, MSIK/1024 and MSIS/4 generated and can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    HSI256_MSIK1024_MSIS4 = 0x6,
    /// HSI/256, MSIK/1024 and MSIK/4 generated and can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    HSI256_MSIK1024_MSIK4 = 0x7,
    _,
};

pub const USART1SEL = enum(u2) {
    /// PCLK2 selected
    PCLK2 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const USARTSEL = enum(u2) {
    /// PCLK1 selected
    PCLK1 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

/// Reset and clock control
pub const RCC = extern struct {
    /// RCC clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// MSIS clock enable Set and cleared by software. Cleared by hardware to stop the MSIS oscillator when entering Stop, Standby or Shutdown mode. Set by hardware to force the MSIS oscillator ON when exiting Standby or Shutdown mode. Set by hardware to force the MSIS oscillator ON when STOPWUCK = 0 when exiting Stop modes or in case of a failure of the HSE oscillator. Set by hardware when used directly or indirectly as system clock.
        MSISON: u1,
        /// MSI enable for some peripheral kernels Set and cleared by software to force MSI ON even in Stop modes. Keeping the MSI ON in Stop mode allows the communication speed not to be reduced by the MSI startup time. This bit has no effect on MSISON and MSIKON values (see autonomous mode for more details). The MSIKERON must be configured at 0 before entering Stop 3 mode.
        MSIKERON: u1,
        /// MSIS clock ready flag Set by hardware to indicate that the MSIS oscillator is stable. This bit is set only when MSIS is enabled by software by setting MSISON. Note: Once the MSISON bit is cleared, MSISRDY goes low after six MSIS clock cycles.
        MSISRDY: u1,
        /// MSI clock PLL-mode enable Set and cleared by software to enable/disable the PLL part of the MSI clock source. MSIPLLEN must be enabled after LSE is enabled (LSEON enabled) and ready (LSERDY set by hardware). A hardware protection prevents from enabling MSIPLLEN if LSE is not ready. This bit is cleared by hardware when LSE is disabled (LSEON = 0) or when the CSS on LSE detects a LSE failure (see RCC_CSR).
        MSIPLLEN: u1,
        /// MSIK clock enable Set and cleared by software. Cleared by hardware to stop the MSIK when entering Stop, Standby or Shutdown mode. Set by hardware to force the MSIK oscillator ON when exiting Standby or Shutdown mode. Set by hardware to force the MSIK oscillator ON when STOPWUCK = 0 or STOPKERWUCK = 0 when exiting Stop modes or in case of a failure of the HSE oscillator.
        MSIKON: u1,
        /// MSIK clock ready flag Set by hardware to indicate that the MSIK is stable. This bit is set only when MSI kernel oscillator is enabled by software by setting MSIKON. Note: Once the MSIKON bit is cleared, MSIKRDY goes low after six MSIK oscillator clock cycles.
        MSIKRDY: u1,
        /// MSI clock with PLL mode selection Set and cleared by software to select which MSI output clock uses the PLL mode. This bit can be written only when the MSI PLL mode is disabled (MSIPLLEN = 0). Note: If the MSI kernel clock output uses the same oscillator source than the MSI system clock output, then the PLL mode is applied to the both clocks outputs.
        MSIPLLSEL: MSIPLLSEL,
        /// MSI PLL mode fast startup Set and reset by software to enable/disable the fast PLL mode start-up of the MSI clock source. This bit is used only if PLL mode is selected (MSIPLLEN = 1). The fast start-up feature is not active the first time the PLL mode is selected. The fast start-up is active when the MSI in PLL mode returns from switch off.
        MSIPLLFAST: MSIPLLFAST,
        /// HSI clock enable Set and cleared by software. Cleared by hardware to stop the HSI oscillator when entering Stop, Standby or Shutdown mode. Set by hardware to force the HSI oscillator ON when STOPWUCK = 1 when leaving Stop modes, or in case of failure of the HSE crystal oscillator. This bit is set by hardware if the HSI is used directly or indirectly as system clock.
        HSION: u1,
        /// HSI enable for some peripheral kernels Set and cleared by software to force HSI ON even in Stop modes. Keeping the HSI ON in Stop mode allows the communication speed not to be reduced by the HSI startup time. This bit has no effect on HSION value. Refer to for more details. The HSIKERON must be configured at 0 before entering Stop 3 mode.
        HSIKERON: u1,
        /// HSI clock ready flag Set by hardware to indicate that HSI oscillator is stable. This bit is set only when HSI is enabled by software by setting HSION. Note: Once the HSION bit is cleared, HSIRDY goes low after six HSI clock cycles.
        HSIRDY: u1,
        reserved12: u1 = 0,
        /// HSI48 clock enable Set and cleared by software. Cleared by hardware to stop the HSI48 when entering in Stop, Standby or Shutdown modes.
        HSI48ON: u1,
        /// HSI48 clock ready flag Set by hardware to indicate that HSI48 oscillator is stable. This bit is set only when HSI48 is enabled by software by setting HSI48ON.
        HSI48RDY: u1,
        /// SHSI clock enable Set and cleared by software. Cleared by hardware to stop the SHSI when entering in Stop, Standby or Shutdown modes.
        SHSION: u1,
        /// SHSI clock ready flag Set by hardware to indicate that the SHSI oscillator is stable. This bit is set only when SHSI is enabled by software by setting SHSION. Note: Once the SHSION bit is cleared, SHSIRDY goes low after six SHSI clock cycles.
        SHSIRDY: u1,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE oscillator when entering Stop, Standby or Shutdown mode. This bit cannot be reset if the HSE oscillator is used directly or indirectly as the system clock.
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable. Note: Once the HSEON bit is cleared, HSERDY goes low after six HSE clock cycles.
        HSERDY: u1,
        /// HSE crystal oscillator bypass Set and cleared by software to bypass the oscillator with an external clock. The external clock must be enabled with the HSEON bit set, to be used by the device. The HSEBYP bit can be written only if the HSE oscillator is disabled.
        HSEBYP: u1,
        /// Clock security system enable Set by software to enable the clock security system. When CSSON is set, the clock detector is enabled by hardware when the HSE oscillator is ready, and disabled by hardware if a HSE clock failure is detected. This bit is set only and is cleared by reset.
        CSSON: u1,
        /// HSE external clock bypass mode Set and reset by software to select the external clock mode in bypass mode. External clock mode must be configured with HSEON bit to be used by the device. This bit can be written only if the HSE oscillator is disabled. This bit is active only if the HSE bypass mode is enabled.
        HSEEXT: HSEEXT,
        reserved24: u3 = 0,
        /// (1/3 of PLLON) PLL1 enable Set and cleared by software to enable the main PLL. Cleared by hardware when entering Stop, Standby or Shutdown mode. This bit cannot be reset if the PLL1 clock is used as the system clock.
        @"PLLON[0]": u1,
        /// (1/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[0]": u1,
        /// (2/3 of PLLON) PLL1 enable Set and cleared by software to enable the main PLL. Cleared by hardware when entering Stop, Standby or Shutdown mode. This bit cannot be reset if the PLL1 clock is used as the system clock.
        @"PLLON[1]": u1,
        /// (2/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[1]": u1,
        /// (3/3 of PLLON) PLL1 enable Set and cleared by software to enable the main PLL. Cleared by hardware when entering Stop, Standby or Shutdown mode. This bit cannot be reset if the PLL1 clock is used as the system clock.
        @"PLLON[2]": u1,
        /// (3/3 of PLLRDY) PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked.
        @"PLLRDY[2]": u1,
        padding: u2 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// RCC internal clock sources calibration register 1
    /// offset: 0x08
    ICSCR1: mmio.Mmio(packed struct(u32) {
        /// MSIRC3 clock calibration for MSI ranges 12 to 15 These bits are initialized at startup with the factory-programmed MSIRC3 calibration trim value for ranges 12 to 15. When MSITRIM3 is written, MSICAL3 is updated with the sum of MSITRIM3[4:0] and the factory calibration trim value MSIRC2[4:0]. There is no hardware protection to limit a potential overflow due to the addition of MSITRIM bitfield and factory program bitfield for this calibration value. Control must be managed by software at user level.
        MSICAL3: u5,
        /// MSIRC2 clock calibration for MSI ranges 8 to 11 These bits are initialized at startup with the factory-programmed MSIRC2 calibration trim value for ranges 8 to 11. When MSITRIM2 is written, MSICAL2 is updated with the sum of MSITRIM2[4:0] and the factory calibration trim value MSIRC2[4:0]. There is no hardware protection to limit a potential overflow due to the addition of MSITRIM bitfield and factory program bitfield for this calibration value. Control must be managed by software at user level.
        MSICAL2: u5,
        /// MSIRC1 clock calibration for MSI ranges 4 to 7 These bits are initialized at startup with the factory-programmed MSIRC1 calibration trim value for ranges 4 to 7. When MSITRIM1 is written, MSICAL1 is updated with the sum of MSITRIM1[4:0] and the factory calibration trim value MSIRC1[4:0]. There is no hardware protection to limit a potential overflow due to the addition of MSITRIM bitfield and factory program bitfield for this calibration value. Control must be managed by software at user level.
        MSICAL1: u5,
        /// MSIRC0 clock calibration for MSI ranges 0 to 3 These bits are initialized at startup with the factory-programmed MSIRC0 calibration trim value for ranges 0 to 3. When MSITRIM0 is written, MSICAL0 is updated with the sum of MSITRIM0[4:0] and the factory-programmed calibration trim value MSIRC0[4:0].
        MSICAL0: u5,
        reserved22: u2 = 0,
        /// MSI bias mode selection Set by software to select the MSI bias mode. By default, the MSI bias is in continuous mode in order to maintain the output clocks accuracy. Setting this bit reduces the MSI consumption under range 4 but decrease its accuracy.
        MSIBIAS: MSIBIAS,
        /// MSI clock range selection Set by software to select the MSIS and MSIK clocks range with MSISRANGE[3:0] and MSIKRANGE[3:0]. Write 0 has no effect. After exiting Standby or Shutdown mode, or after a reset, this bit is at 0 and the MSIS and MSIK ranges are provided by MSISSRANGE[3:0] and MSIKSRANGE[3:0] in RCC_CSR.
        MSIRGSEL: MSIRGSEL,
        /// MSIK clock ranges These bits are configured by software to choose the frequency range of MSIK oscillator when MSIRGSEL is set. 16 frequency ranges are available: Note: MSIKRANGE can be modified when MSIK is OFF (MSISON = 0) or when MSIK is ready (MSIKRDY = 1). MSIKRANGE must NOT be modified when MSIK is ON and NOT ready (MSIKON = 1 and MSIKRDY = 0) MSIKRANGE is kept when the device wakes up from Stop mode, except when the MSIK range is above 24 MHz. In this case MSIKRANGE is changed by hardware into Range 2 (24 MHz).
        MSIKRANGE: MSIRANGE,
        /// MSIS clock ranges These bits are configured by software to choose the frequency range of MSIS oscillator when MSIRGSEL is set. 16 frequency ranges are available: Note: MSISRANGE can be modified when MSIS is OFF (MSISON = 0) or when MSIS is ready (MSISRDY = 1). MSISRANGE must NOT be modified when MSIS is ON and NOT ready (MSISON = 1 and MSISRDY = 0) MSISRANGE is kept when the device wakes up from Stop mode, except when the MSIS range is above 24 MHz. In this case MSISRANGE is changed by hardware into Range 2 (24 MHz).
        MSISRANGE: MSIRANGE,
    }),
    /// RCC internal clock sources calibration register 2
    /// offset: 0x0c
    ICSCR2: mmio.Mmio(packed struct(u32) {
        /// MSI clock trimming for ranges 12 to 15 These bits provide an additional user-programmable trimming value that is added to the factory-programmed calibration trim value MSIRC3[4:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the MSI.
        MSITRIM3: u5,
        /// MSI clock trimming for ranges 8 to 11 These bits provide an additional user-programmable trimming value that is added to the factory-programmed calibration trim value MSIRC2[4:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the MSI.
        MSITRIM2: u5,
        /// MSI clock trimming for ranges 4 to 7 These bits provide an additional user-programmable trimming value that is added to the factory-programmed calibration trim value MSIRC1[4:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the MSI.
        MSITRIM1: u5,
        /// MSI clock trimming for ranges 0 to 3 These bits provide an additional user-programmable trimming value that is added to the factory-programmed calibration trim value MSIRC0[4:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the MSI.
        MSITRIM0: u5,
        padding: u12 = 0,
    }),
    /// RCC internal clock sources calibration register 3
    /// offset: 0x10
    ICSCR3: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration These bits are initialized at startup with the factory-programmed HSI calibration trim value. When HSITRIM is written, HSICAL is updated with the sum of HSITRIM and the factory trim value.
        HSICAL: u12,
        reserved16: u4 = 0,
        /// HSI clock trimming These bits provide an additional user-programmable trimming value that is added to the HSICAL[11:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the HSI.
        HSITRIM: u5,
        padding: u11 = 0,
    }),
    /// RCC clock recovery RC register
    /// offset: 0x14
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// HSI48 clock calibration These bits are initialized at startup with the factory-programmed HSI48 calibration trim value.
        HSI48CAL: u9,
        padding: u23 = 0,
    }),
    /// offset: 0x18
    reserved24: [4]u8,
    /// RCC clock configuration register 1
    /// offset: 0x1c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// system clock switch Set and cleared by software to select system clock source (SYSCLK). Configured by hardware to force MSIS oscillator selection when exiting Standby or Shutdown mode. Configured by hardware to force MSIS or HSI oscillator selection when exiting Stop mode or in case of HSE oscillator failure, depending on STOPWUCK value.
        SW: SW,
        /// system clock switch status Set and cleared by hardware to indicate which clock source is used as system clock.
        SWS: SW,
        /// wakeup from Stop and CSS backup clock selection Set and cleared by software to select the system clock used when exiting Stop mode. The selected clock is also used as emergency clock for the clock security system on HSE. Warning: STOPWUCK must not be modified when the CSS is enabled by HSECSSON bit in RCC_CR and the system clock is HSE (SWS = 10) or a switch on HSE is requested (SW = 10).
        STOPWUCK: STOPWUCK,
        /// wakeup from Stop kernel clock automatic enable selection Set and cleared by software to enable automatically another oscillator when exiting Stop mode. This oscillator can be used as independent kernel clock by peripherals.
        STOPKERWUCK: STOPKERWUCK,
        reserved24: u18 = 0,
        /// microcontroller clock output Set and cleared by software. Others: reserved Note: This clock output may have some truncated cycles at startup or during MCO clock source switching.
        MCOSEL: MCOSEL,
        /// microcontroller clock output prescaler Set and cleared by software. It is highly recommended to change this prescaler before MCO output is enabled. Others: not allowed
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// RCC clock configuration register 2
    /// offset: 0x20
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// AHB prescaler Set and cleared by software to control the division factor of the AHB clock (HCLK). Depending on the device voltage range, the software must set these bits correctly to ensure that the system frequency does not exceed the maximum allowed frequency (for more details, refer to ). After a write operation to these bits and before decreasing the voltage range, this register must be read to be sure that the new value is taken into account. 0xxx: SYSCLK not divided
        HPRE: HPRE,
        /// APB1 prescaler Set and cleared by software to control the division factor of the APB1 clock (PCLK1). 0xx: HCLK not divided
        PPRE1: PPRE,
        reserved8: u1 = 0,
        /// APB2 prescaler Set and cleared by software to control the division factor of the APB2 clock (PCLK2). 0xx: HCLK not divided
        PPRE2: PPRE,
        reserved12: u1 = 0,
        /// DSI PHY prescaler This bitfiled is set and cleared by software to control the division factor of DSI PHY bus clock (DCLK). 0xx: DCLK not divided Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        DPRE: DPRE,
        reserved16: u1 = 0,
        /// AHB1 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB1 peripherals (except those listed hereafter) are used and when their clocks are disabled in RCC_AHB1ENR. When this bit is set, all the AHB1 peripherals clocks are off, except for FLASH, BKPSRAM, ICACHE, DCACHE1 and SRAM1.
        AHB1DIS: u1,
        /// AHB2_1 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB2 peripherals from RCC_AHB2ENR1 (except SRAM2 and SRAM3) are used and when their clocks are disabled in RCC_AHB2ENR1. When this bit is set, all the AHB2 peripherals clocks from RCC_AHB2ENR1 are off, except for SRAM2 and SRAM3.
        AHB2DIS1: u1,
        /// AHB2_2 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB2 peripherals from RCC_AHB2ENR2 are used and when their clocks are disabled in RCC_AHB2ENR2. When this bit is set, all the AHB2 peripherals clocks from RCC_AHB2EBNR2 are off.
        AHB2DIS2: u1,
        /// APB1 clock disable This bit can be set in order to further reduce power consumption, when none of the APB1 peripherals (except IWDG) are used and when their clocks are disabled in RCC_APB1ENR. When this bit is set, all the APB1 peripherals clocks are off, except for IWDG.
        APB1DIS: u1,
        /// APB2 clock disable This bit can be set in order to further reduce power consumption, when none of the APB2 peripherals are used and when their clocks are disabled in RCC_APB2ENR. When this bit is set, all the APB2 peripherals clocks are off.
        APB2DIS: u1,
        padding: u11 = 0,
    }),
    /// RCC clock configuration register 3
    /// offset: 0x24
    CFGR3: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// APB3 prescaler Set and cleared by software to control the division factor of the APB3 clock (PCLK3). 0xx: HCLK not divided
        PPRE3: PPRE,
        reserved16: u9 = 0,
        /// AHB3 clock disable This bit can be set in order to further reduce power consumption, when none of the AHB3 peripherals (except SRAM4) are used and when their clocks are disabled in RCC_AHB3ENR. When this bit is set, all the AHB3 peripherals clocks are off, except for SRAM4.
        AHB3DIS: u1,
        /// APB3 clock disable This bit can be set in order to further reduce power consumption, when none of the APB3 peripherals from RCC_APB3ENR are used and when their clocks are disabled in RCC_APB3ENR. When this bit is set, all the APB3 peripherals clocks are off.
        APB3DIS: u1,
        padding: u14 = 0,
    }),
    /// RCC PLL1 configuration register
    /// offset: 0x28
    PLL1CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL entry clock source Set and cleared by software to select PLL clock source. These bits can be written only when the PLL is disabled. In order to save power, when no PLL is used, the value of PLLSRC must be 0.
        PLLSRC: PLLSRC,
        /// PLL input frequency range Set and reset by software to select the proper reference frequency range used for PLL. This bit must be written before enabling the PLL. 00-01-10: PLL input (ref1_ck) clock range frequency between 4 and 8 MHz
        PLLRGE: PLLRGE,
        /// PLL fractional latch enable Set and reset by software to latch the content of PLLFRACN into the Î£Î modulator. In order to latch the PLLFRACN value into the Î£Î modulator, PLLFRACEN must be set to 0, then set to 1: the transition 0 to 1 transfers the content of PLLFRACN into the modulator (see for details).
        PLLFRACEN: u1,
        reserved8: u3 = 0,
        /// Prescaler for PLL Set and cleared by software to configure the prescaler of the PLL. The VCO1 input frequency is PLL input clock frequency/PLLM. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0). ...
        PLLM: PLLM,
        /// Prescaler for EPOD booster input clock Set and cleared by software to configure the prescaler of the PLL, used for the EPOD booster. The EPOD booster input frequency is PLL input clock frequency/PLLMBOOST. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0) and EPOD Boost mode is disabled (see ). others: reserved
        PLLMBOOST: PLLMBOOST,
        /// PLL DIVP divider output enable Set and reset by software to enable the PLL_p_ck output of the PLL. To save power, PLLPEN and PLLP bits must be set to 0 when the PLL_p_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLPEN: u1,
        /// PLL DIVQ divider output enable Set and reset by software to enable the PLL_q_ck output of the PLL. To save power, PLLQEN and PLLQ bits must be set to 0 when the PLL_q_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLQEN: u1,
        /// PLL DIVR divider output enable Set and reset by software to enable the PLL_r_ck output of the PLL. To save power, PLLRENPLL2REN and PLLR bits must be set to 0 when the PLL_r_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLREN: u1,
        padding: u13 = 0,
    }),
    /// RCC PLL2 configuration register
    /// offset: 0x2c
    PLL2CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL entry clock source Set and cleared by software to select PLL clock source. These bits can be written only when the PLL is disabled. In order to save power, when no PLL is used, the value of PLLSRC must be 0.
        PLLSRC: PLLSRC,
        /// PLL input frequency range Set and reset by software to select the proper reference frequency range used for PLL. This bit must be written before enabling the PLL. 00-01-10: PLL input (ref1_ck) clock range frequency between 4 and 8 MHz
        PLLRGE: PLLRGE,
        /// PLL fractional latch enable Set and reset by software to latch the content of PLLFRACN into the Î£Î modulator. In order to latch the PLLFRACN value into the Î£Î modulator, PLLFRACEN must be set to 0, then set to 1: the transition 0 to 1 transfers the content of PLLFRACN into the modulator (see for details).
        PLLFRACEN: u1,
        reserved8: u3 = 0,
        /// Prescaler for PLL Set and cleared by software to configure the prescaler of the PLL. The VCO1 input frequency is PLL input clock frequency/PLLM. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0). ...
        PLLM: PLLM,
        reserved16: u4 = 0,
        /// PLL DIVP divider output enable Set and reset by software to enable the PLL_p_ck output of the PLL. To save power, PLLPEN and PLLP bits must be set to 0 when the PLL_p_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLPEN: u1,
        /// PLL DIVQ divider output enable Set and reset by software to enable the PLL_q_ck output of the PLL. To save power, PLLQEN and PLLQ bits must be set to 0 when the PLL_q_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLQEN: u1,
        /// PLL DIVR divider output enable Set and reset by software to enable the PLL_r_ck output of the PLL. To save power, PLLRENPLL2REN and PLLR bits must be set to 0 when the PLL_r_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLREN: u1,
        padding: u13 = 0,
    }),
    /// RCC PLL3 configuration register
    /// offset: 0x30
    PLL3CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL entry clock source Set and cleared by software to select PLL clock source. These bits can be written only when the PLL is disabled. In order to save power, when no PLL is used, the value of PLLSRC must be 0.
        PLLSRC: PLLSRC,
        /// PLL input frequency range Set and reset by software to select the proper reference frequency range used for PLL. This bit must be written before enabling the PLL. 00-01-10: PLL input (ref1_ck) clock range frequency between 4 and 8 MHz
        PLLRGE: PLLRGE,
        /// PLL fractional latch enable Set and reset by software to latch the content of PLLFRACN into the Î£Î modulator. In order to latch the PLLFRACN value into the Î£Î modulator, PLLFRACEN must be set to 0, then set to 1: the transition 0 to 1 transfers the content of PLLFRACN into the modulator (see for details).
        PLLFRACEN: u1,
        reserved8: u3 = 0,
        /// Prescaler for PLL Set and cleared by software to configure the prescaler of the PLL. The VCO1 input frequency is PLL input clock frequency/PLLM. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0). ...
        PLLM: PLLM,
        reserved16: u4 = 0,
        /// PLL DIVP divider output enable Set and reset by software to enable the PLL_p_ck output of the PLL. To save power, PLLPEN and PLLP bits must be set to 0 when the PLL_p_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLPEN: u1,
        /// PLL DIVQ divider output enable Set and reset by software to enable the PLL_q_ck output of the PLL. To save power, PLLQEN and PLLQ bits must be set to 0 when the PLL_q_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLQEN: u1,
        /// PLL DIVR divider output enable Set and reset by software to enable the PLL_r_ck output of the PLL. To save power, PLLRENPLL2REN and PLLR bits must be set to 0 when the PLL_r_ck is not used. This bit can be written only when the PLL is disabled (PLLON = 0 and PLLRDY = 0).
        PLLREN: u1,
        padding: u13 = 0,
    }),
    /// RCC PLL1 dividers register
    /// offset: 0x34
    PLL1DIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1 VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL is disabled (PLL1ON = 0 and PLL1RDY = 0). ... ... Others: reserved VCO output frequency = Fref1_ck x PLL1N, when fractional value 0 has been loaded into PLL1FRACN, with: PLL1N between 4 and 512 input frequency Fref1_ck between 4 and 16 MHz
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
    PLL1FRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. VCO output frequency = Fref1_ck x (PLL1N + (PLL1FRACN / 213)), with: PLL1N must be between 4 and 512. PLL1FRACN can be between 0 and 213- 1. The input frequency Fref1_ck must be between 4 and 16 MHz. To change the FRACN value on-the-fly even if the PLL is enabled, the application must proceed as follows: Set the bit PLL1FRACEN to 0. Write the new fractional value into PLL1FRACN. Set the bit PLL1FRACEN to 1.
        PLLFRACN: u13,
        padding: u16 = 0,
    }),
    /// RCC PLL2 dividers configuration register
    /// offset: 0x3c
    PLL2DIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1 VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL is disabled (PLL1ON = 0 and PLL1RDY = 0). ... ... Others: reserved VCO output frequency = Fref1_ck x PLL1N, when fractional value 0 has been loaded into PLL1FRACN, with: PLL1N between 4 and 512 input frequency Fref1_ck between 4 and 16 MHz
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
    /// RCC PLL2 fractional divider register
    /// offset: 0x40
    PLL2FRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. VCO output frequency = Fref1_ck x (PLL1N + (PLL1FRACN / 213)), with: PLL1N must be between 4 and 512. PLL1FRACN can be between 0 and 213- 1. The input frequency Fref1_ck must be between 4 and 16 MHz. To change the FRACN value on-the-fly even if the PLL is enabled, the application must proceed as follows: Set the bit PLL1FRACEN to 0. Write the new fractional value into PLL1FRACN. Set the bit PLL1FRACEN to 1.
        PLLFRACN: u13,
        padding: u16 = 0,
    }),
    /// RCC PLL3 dividers configuration register
    /// offset: 0x44
    PLL3DIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1 VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL is disabled (PLL1ON = 0 and PLL1RDY = 0). ... ... Others: reserved VCO output frequency = Fref1_ck x PLL1N, when fractional value 0 has been loaded into PLL1FRACN, with: PLL1N between 4 and 512 input frequency Fref1_ck between 4 and 16 MHz
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
    /// RCC PLL3 fractional divider register
    /// offset: 0x48
    PLL3FRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. VCO output frequency = Fref1_ck x (PLL1N + (PLL1FRACN / 213)), with: PLL1N must be between 4 and 512. PLL1FRACN can be between 0 and 213- 1. The input frequency Fref1_ck must be between 4 and 16 MHz. To change the FRACN value on-the-fly even if the PLL is enabled, the application must proceed as follows: Set the bit PLL1FRACEN to 0. Write the new fractional value into PLL1FRACN. Set the bit PLL1FRACEN to 1.
        PLLFRACN: u13,
        padding: u16 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// RCC clock interrupt enable register
    /// offset: 0x50
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSI oscillator stabilization.
        LSIRDYIE: u1,
        /// LSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSE oscillator stabilization.
        LSERDYIE: u1,
        /// MSIS ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the MSIS oscillator stabilization.
        MSISRDYIE: u1,
        /// HSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSI oscillator stabilization.
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSE oscillator stabilization.
        HSERDYIE: u1,
        /// HSI48 ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSI48 oscillator stabilization.
        HSI48RDYIE: u1,
        /// (1/3 of PLLRDYIE) PLL ready interrupt enable Set and cleared by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[0]": u1,
        /// (2/3 of PLLRDYIE) PLL ready interrupt enable Set and cleared by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[1]": u1,
        /// (3/3 of PLLRDYIE) PLL ready interrupt enable Set and cleared by software to enable/disable interrupt caused by PLL1 lock.
        @"PLLRDYIE[2]": u1,
        reserved11: u2 = 0,
        /// MSIK ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the MSIK oscillator stabilization.
        MSIKRDYIE: u1,
        /// SHSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the SHSI oscillator stabilization.
        SHSIRDYIE: u1,
        padding: u19 = 0,
    }),
    /// RCC clock interrupt flag register
    /// offset: 0x54
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag Set by hardware when the LSI clock becomes stable and LSIRDYIE is set. Cleared by software setting the LSIRDYC bit.
        LSIRDYF: u1,
        /// LSE ready interrupt flag Set by hardware when the LSE clock becomes stable and LSERDYIE is set. Cleared by software setting the LSERDYC bit.
        LSERDYF: u1,
        /// MSIS ready interrupt flag Set by hardware when the MSIS clock becomes stable and MSISRDYIE is set. Cleared by software setting the MSISRDYC bit.
        MSISRDYF: u1,
        /// HSI ready interrupt flag Set by hardware when the HSI clock becomes stable and HSIRDYIE is set in a response to setting the HSION (see RCC_CR). When HSION is not set but the HSI oscillator is enabled by the peripheral through a clock request, this bit is not set and no interrupt is generated. Cleared by software setting the HSIRDYC bit.
        HSIRDYF: u1,
        /// HSE ready interrupt flag Set by hardware when the HSE clock becomes stable and HSERDYIE is set. Cleared by software setting the HSERDYC bit.
        HSERDYF: u1,
        /// HSI48 ready interrupt flag Set by hardware when the HSI48 clock becomes stable and HSI48RDYIE is set. Cleared by software setting the HSI48RDYC bit.
        HSI48RDYF: u1,
        /// (1/3 of PLLRDYF) PLL1 ready interrupt flag Set by hardware when the PLL1 locks and PLL1RDYIE is set. Cleared by software setting the PLL1RDYC bit.
        @"PLLRDYF[0]": u1,
        /// (2/3 of PLLRDYF) PLL1 ready interrupt flag Set by hardware when the PLL1 locks and PLL1RDYIE is set. Cleared by software setting the PLL1RDYC bit.
        @"PLLRDYF[1]": u1,
        /// (3/3 of PLLRDYF) PLL1 ready interrupt flag Set by hardware when the PLL1 locks and PLL1RDYIE is set. Cleared by software setting the PLL1RDYC bit.
        @"PLLRDYF[2]": u1,
        reserved10: u1 = 0,
        /// Clock security system interrupt flag Set by hardware when a failure is detected in the HSE oscillator. Cleared by software setting the CSSC bit.
        CSSF: u1,
        /// MSIK ready interrupt flag Set by hardware when the MSIK clock becomes stable and MSIKRDYIE is set. Cleared by software setting the MSIKRDYC bit.
        MSIKRDYF: u1,
        /// SHSI ready interrupt flag Set by hardware when the SHSI clock becomes stable and SHSIRDYIE is set. Cleared by software setting the SHSIRDYC bit.
        SHSIRDYF: u1,
        padding: u19 = 0,
    }),
    /// RCC clock interrupt clear register
    /// offset: 0x58
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear Writing this bit to 1 clears the LSIRDYF flag. Writing 0 has no effect.
        LSIRDYC: u1,
        /// LSE ready interrupt clear Writing this bit to 1 clears the LSERDYF flag. Writing 0 has no effect.
        LSERDYC: u1,
        /// MSIS ready interrupt clear Writing this bit to 1 clears the MSISRDYF flag. Writing 0 has no effect.
        MSISRDYC: u1,
        /// HSI ready interrupt clear Writing this bit to 1 clears the HSIRDYF flag. Writing 0 has no effect.
        HSIRDYC: u1,
        /// HSE ready interrupt clear Writing this bit to 1 clears the HSERDYF flag. Writing 0 has no effect.
        HSERDYC: u1,
        /// HSI48 ready interrupt clear Writing this bit to 1 clears the HSI48RDYF flag. Writing 0 has no effect.
        HSI48RDYC: u1,
        /// (1/3 of PLLRDYC) PLL1 ready interrupt clear Writing this bit to 1 clears the PLL1RDYF flag. Writing 0 has no effect.
        @"PLLRDYC[0]": u1,
        /// (2/3 of PLLRDYC) PLL1 ready interrupt clear Writing this bit to 1 clears the PLL1RDYF flag. Writing 0 has no effect.
        @"PLLRDYC[1]": u1,
        /// (3/3 of PLLRDYC) PLL1 ready interrupt clear Writing this bit to 1 clears the PLL1RDYF flag. Writing 0 has no effect.
        @"PLLRDYC[2]": u1,
        reserved10: u1 = 0,
        /// Clock security system interrupt clear Writing this bit to 1 clears the CSSF flag. Writing 0 has no effect.
        CSSC: u1,
        /// MSIK oscillator ready interrupt clear Writing this bit to 1 clears the MSIKRDYF flag. Writing 0 has no effect.
        MSIKRDYC: u1,
        /// SHSI oscillator ready interrupt clear Writing this bit to 1 clears the SHSIRDYF flag. Writing 0 has no effect.
        SHSIRDYC: u1,
        padding: u19 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// RCC AHB1 peripheral reset register
    /// offset: 0x60
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 reset Set and cleared by software.
        GPDMA1RST: u1,
        /// CORDIC reset Set and cleared by software.
        CORDICRST: u1,
        /// FMAC reset Set and cleared by software.
        FMACRST: u1,
        /// MDF1 reset Set and cleared by software.
        MDF1RST: u1,
        reserved12: u8 = 0,
        /// CRC reset Set and cleared by software.
        CRCRST: u1,
        reserved15: u2 = 0,
        /// JPEG reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        JPEGRST: u1,
        /// TSC reset Set and cleared by software.
        TSCRST: u1,
        /// RAMCFG reset Set and cleared by software.
        RAMCFGRST: u1,
        /// DMA2D reset Set and cleared by software.
        DMA2DRST: u1,
        /// GFXMMU reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXMMURST: u1,
        /// GPU2D reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPU2DRST: u1,
        padding: u11 = 0,
    }),
    /// RCC AHB2 peripheral reset register 1
    /// offset: 0x64
    AHB2RSTR1: mmio.Mmio(packed struct(u32) {
        /// IO port A reset Set and cleared by software.
        GPIOARST: u1,
        /// IO port B reset Set and cleared by software.
        GPIOBRST: u1,
        /// IO port C reset Set and cleared by software.
        GPIOCRST: u1,
        /// IO port D reset Set and cleared by software.
        GPIODRST: u1,
        /// IO port E reset Set and cleared by software.
        GPIOERST: u1,
        /// IO port F reset Set and cleared by software.
        GPIOFRST: u1,
        /// IO port G reset Set and cleared by software.
        GPIOGRST: u1,
        /// IO port H reset Set and cleared by software.
        GPIOHRST: u1,
        /// IO port I reset Set and cleared by software.
        GPIOIRST: u1,
        /// I/O port J reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPIOJRST: u1,
        /// ADC1 and ADC2 reset This bit is set and cleared by software. Note: This bit impacts ADC1 in STM32U535/545/575/585, and ADC1/ADC2 in�STM32U59x/5Ax/5Fx/5Gx.
        ADC12RST: u1,
        reserved12: u1 = 0,
        /// DCMI and PSSI reset Set and cleared by software.
        DCMIRST: u1,
        reserved14: u1 = 0,
        /// OTG_FS reset Set and cleared by software.
        USB_OTG_FSRST: u1,
        reserved16: u1 = 0,
        /// AES hardware accelerator reset Set and cleared by software.
        AESRST: u1,
        /// Hash reset Set and cleared by software.
        HASHRST: u1,
        /// Random number generator reset Set and cleared by software.
        RNGRST: u1,
        /// PKA reset Set and cleared by software.
        PKARST: u1,
        /// SAES hardware accelerator reset Set and cleared by software.
        SAESRST: u1,
        /// OCTOSPIM reset Set and cleared by software.
        OCTOSPIMRST: u1,
        reserved23: u1 = 0,
        /// OTFDEC1 reset Set and cleared by software.
        OTFDEC1RST: u1,
        /// OTFDEC2 reset Set and cleared by software.
        OTFDEC2RST: u1,
        reserved27: u2 = 0,
        /// SDMMC1 reset Set and cleared by software.
        SDMMC1RST: u1,
        /// SDMMC2 reset Set and cleared by software.
        SDMMC2RST: u1,
        padding: u3 = 0,
    }),
    /// RCC AHB2 peripheral reset register 2
    /// offset: 0x68
    AHB2RSTR2: mmio.Mmio(packed struct(u32) {
        /// Flexible memory controller reset Set and cleared by software.
        FSMCRST: u1,
        reserved4: u3 = 0,
        /// OCTOSPI1 reset Set and cleared by software.
        OCTOSPI1RST: u1,
        reserved8: u3 = 0,
        /// OCTOSPI2 reset Set and cleared by software.
        OCTOSPI2RST: u1,
        reserved12: u3 = 0,
        /// HSPI1 reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        HSPI1RST: u1,
        padding: u19 = 0,
    }),
    /// RCC AHB3 peripheral reset register
    /// offset: 0x6c
    AHB3RSTR: mmio.Mmio(packed struct(u32) {
        /// LPGPIO1 reset Set and cleared by software.
        LPGPIO1RST: u1,
        reserved5: u4 = 0,
        /// ADC4 reset Set and cleared by software.
        ADC4RST: u1,
        /// DAC1 reset Set and cleared by software.
        DAC1RST: u1,
        reserved9: u2 = 0,
        /// LPDMA1 reset Set and cleared by software.
        LPDMA1RST: u1,
        /// ADF1 reset Set and cleared by software.
        ADF1RST: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x70
    reserved112: [4]u8,
    /// RCC APB1 peripheral reset register 1
    /// offset: 0x74
    APB1RSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 reset Set and cleared by software.
        TIM2RST: u1,
        /// TIM3 reset Set and cleared by software.
        TIM3RST: u1,
        /// TIM4 reset Set and cleared by software.
        TIM4RST: u1,
        /// TIM5 reset Set and cleared by software.
        TIM5RST: u1,
        /// TIM6 reset Set and cleared by software.
        TIM6RST: u1,
        /// TIM7 reset Set and cleared by software.
        TIM7RST: u1,
        reserved14: u8 = 0,
        /// SPI2 reset Set and cleared by software.
        SPI2RST: u1,
        reserved17: u2 = 0,
        /// USART2 reset Set and cleared by software.
        USART2RST: u1,
        /// USART3 reset Set and cleared by software.
        USART3RST: u1,
        /// UART4 reset Set and cleared by software.
        UART4RST: u1,
        /// UART5 reset Set and cleared by software.
        UART5RST: u1,
        /// I2C1 reset Set and cleared by software.
        I2C1RST: u1,
        /// I2C2 reset Set and cleared by software.
        I2C2RST: u1,
        reserved24: u1 = 0,
        /// CRS reset Set and cleared by software.
        CRSRST: u1,
        /// USART6 reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USART6RST: u1,
        padding: u6 = 0,
    }),
    /// RCC APB1 peripheral reset register 2
    /// offset: 0x78
    APB1RSTR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// I2C4 reset Set and cleared by software
        I2C4RST: u1,
        reserved5: u3 = 0,
        /// LPTIM2 reset Set and cleared by software.
        LPTIM2RST: u1,
        /// I2C5 reset This bit is set and cleared by software Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C5RST: u1,
        /// I2C6 reset This bit is set and cleared by software Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C6RST: u1,
        reserved9: u1 = 0,
        /// FDCAN1 reset Set and cleared by software.
        FDCAN1RST: u1,
        reserved23: u13 = 0,
        /// UCPD1 reset Set and cleared by software.
        UCPD1RST: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 peripheral reset register
    /// offset: 0x7c
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 reset Set and cleared by software.
        TIM1RST: u1,
        /// SPI1 reset Set and cleared by software.
        SPI1RST: u1,
        /// TIM8 reset Set and cleared by software.
        TIM8RST: u1,
        /// USART1 reset Set and cleared by software.
        USART1RST: u1,
        reserved16: u1 = 0,
        /// TIM15 reset Set and cleared by software.
        TIM15RST: u1,
        /// TIM16 reset Set and cleared by software.
        TIM16RST: u1,
        /// TIM17 reset Set and cleared by software.
        TIM17RST: u1,
        reserved21: u2 = 0,
        /// SAI1 reset Set and cleared by software.
        SAI1RST: u1,
        /// SAI2 reset Set and cleared by software.
        SAI2RST: u1,
        reserved24: u1 = 0,
        /// USB reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USBRST: u1,
        /// GFXTIM reset This bit is set and cleared by software. Note: .This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXTIMRST: u1,
        /// LTDC reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        LTDCRST: u1,
        /// DSI reset This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        DSIRST: u1,
        padding: u4 = 0,
    }),
    /// RCC APB3 peripheral reset register
    /// offset: 0x80
    APB3RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG reset Set and cleared by software.
        SYSCFGRST: u1,
        reserved5: u3 = 0,
        /// SPI3 reset Set and cleared by software.
        SPI3RST: u1,
        /// LPUART1 reset Set and cleared by software.
        LPUART1RST: u1,
        /// I2C3 reset Set and cleared by software.
        I2C3RST: u1,
        reserved11: u3 = 0,
        /// LPTIM1 reset Set and cleared by software.
        LPTIM1RST: u1,
        /// LPTIM3 reset Set and cleared by software.
        LPTIM3RST: u1,
        /// LPTIM4 reset Set and cleared by software.
        LPTIM4RST: u1,
        /// OPAMP reset Set and cleared by software.
        OPAMPRST: u1,
        /// COMP reset Set and cleared by software.
        COMPRST: u1,
        reserved20: u4 = 0,
        /// VREFBUF reset Set and cleared by software.
        VREFRST: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// RCC AHB1 peripheral clock enable register
    /// offset: 0x88
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 clock enable Set and cleared by software.
        GPDMA1EN: u1,
        /// CORDIC clock enable Set and cleared by software.
        CORDICEN: u1,
        /// FMAC clock enable Set and reset by software.
        FMACEN: u1,
        /// MDF1 clock enable Set and reset by software.
        MDF1EN: u1,
        reserved8: u4 = 0,
        /// FLASH clock enable Set and cleared by software. This bit can be disabled only when the Flash memory is in power down mode.
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable Set and cleared by software.
        CRCEN: u1,
        reserved15: u2 = 0,
        /// JPEG clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        JPEGEN: u1,
        /// Touch sensing controller clock enable Set and cleared by software.
        TSCEN: u1,
        /// RAMCFG clock enable Set and cleared by software.
        RAMCFGEN: u1,
        /// DMA2D clock enable Set and cleared by software.
        DMA2DEN: u1,
        /// GFXMMU clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXMMUEN: u1,
        /// GPU2D clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPU2DEN: u1,
        /// DCACHE2 clock enable This bit is set and reset by software. Note: DCACHE2 clock must be enabled to access memories, even if the DCACHE2 is bypassed. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        DCACHE2EN: u1,
        reserved24: u2 = 0,
        /// GTZC1 clock enable Set and reset by software.
        GTZC1EN: u1,
        reserved28: u3 = 0,
        /// BKPSRAM clock enable Set and reset by software.
        BKPSRAMEN: u1,
        reserved30: u1 = 0,
        /// DCACHE1 clock enable Set and reset by software. Note: DCACHE1 clock must be enabled when external memories are accessed through OCTOSPI1, OCTOSPI2 or FSMC, even if the DCACHE1 is bypassed.
        DCACHE1EN: u1,
        /// SRAM1 clock enable Set and reset by software.
        SRAM1EN: u1,
    }),
    /// RCC AHB2 peripheral clock enable register 1
    /// offset: 0x8c
    AHB2ENR1: mmio.Mmio(packed struct(u32) {
        /// IO port A clock enable Set and cleared by software.
        GPIOAEN: u1,
        /// IO port B clock enable Set and cleared by software.
        GPIOBEN: u1,
        /// IO port C clock enable Set and cleared by software.
        GPIOCEN: u1,
        /// IO port D clock enable Set and cleared by software.
        GPIODEN: u1,
        /// IO port E clock enable Set and cleared by software.
        GPIOEEN: u1,
        /// IO port F clock enable Set and cleared by software.
        GPIOFEN: u1,
        /// IO port G clock enable Set and cleared by software.
        GPIOGEN: u1,
        /// IO port H clock enable Set and cleared by software.
        GPIOHEN: u1,
        /// IO port I clock enable Set and cleared by software.
        GPIOIEN: u1,
        /// I/O port J clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPIOJEN: u1,
        /// ADC1 and ADC2 clock enable This bit is set and cleared by software. Note: This bit impacts ADC1 in STM32U535/545/575/585, and ADC1/ADC2 in�STM32U59x/5Ax/5Fx/5Gx.
        ADC12EN: u1,
        reserved12: u1 = 0,
        /// DCMI and PSSI clock enable Set and cleared by software.
        DCMIEN: u1,
        reserved14: u1 = 0,
        /// OTG_FS clock enable Set and cleared by software.
        USB_OTG_FSEN: u1,
        /// OTG_HS PHY clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USB_OTG_HS_PHYEN: u1,
        /// AES clock enable Set and cleared by software.
        AESEN: u1,
        /// HASH clock enable Set and cleared by software
        HASHEN: u1,
        /// RNG clock enable Set and cleared by software.
        RNGEN: u1,
        /// PKA clock enable Set and cleared by software.
        PKAEN: u1,
        /// SAES clock enable Set and cleared by software.
        SAESEN: u1,
        /// OCTOSPIM clock enable Set and cleared by software.
        OCTOSPIMEN: u1,
        reserved23: u1 = 0,
        /// OTFDEC1 clock enable Set and cleared by software.
        OTFDEC1EN: u1,
        /// OTFDEC2 clock enable Set and cleared by software.
        OTFDEC2EN: u1,
        reserved27: u2 = 0,
        /// SDMMC1 clock enable Set and cleared by software.
        SDMMC1EN: u1,
        /// SDMMC2 clock enable Set and cleared by software.
        SDMMC2EN: u1,
        reserved30: u1 = 0,
        /// SRAM2 clock enable Set and reset by software.
        SRAM2EN: u1,
        /// SRAM3 clock enable Set and reset by software.
        SRAM3EN: u1,
    }),
    /// RCC AHB2 peripheral clock enable register 2
    /// offset: 0x90
    AHB2ENR2: mmio.Mmio(packed struct(u32) {
        /// FSMC clock enable Set and cleared by software.
        FSMCEN: u1,
        reserved4: u3 = 0,
        /// OCTOSPI1 clock enable Set and cleared by software.
        OCTOSPI1EN: u1,
        reserved8: u3 = 0,
        /// OCTOSPI2 clock enable Set and cleared by software.
        OCTOSPI2EN: u1,
        reserved12: u3 = 0,
        /// HSPI1 clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        HSPI1EN: u1,
        reserved30: u17 = 0,
        /// SRAM6 clock enable This bit is set and reset by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        SRAM6EN: u1,
        /// SRAM5 clock enable This bit is set and reset by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        SRAM5EN: u1,
    }),
    /// RCC AHB3 peripheral clock enable register
    /// offset: 0x94
    AHB3ENR: mmio.Mmio(packed struct(u32) {
        /// LPGPIO1 enable Set and cleared by software.
        LPGPIO1EN: u1,
        reserved2: u1 = 0,
        /// PWR clock enable Set and cleared by software.
        PWREN: u1,
        reserved5: u2 = 0,
        /// ADC4 clock enable Set and cleared by software.
        ADC4EN: u1,
        /// DAC1 clock enable Set and cleared by software.
        DAC1EN: u1,
        reserved9: u2 = 0,
        /// LPDMA1 clock enable Set and cleared by software.
        LPDMA1EN: u1,
        /// ADF1 clock enable Set and cleared by software.
        ADF1EN: u1,
        reserved12: u1 = 0,
        /// GTZC2 clock enable Set and cleared by software.
        GTZC2EN: u1,
        reserved31: u18 = 0,
        /// SRAM4 clock enable Set and reset by software.
        SRAM4EN: u1,
    }),
    /// offset: 0x98
    reserved152: [4]u8,
    /// RCC APB1 peripheral clock enable register 1
    /// offset: 0x9c
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 clock enable Set and cleared by software.
        TIM2EN: u1,
        /// TIM3 clock enable Set and cleared by software.
        TIM3EN: u1,
        /// TIM4 clock enable Set and cleared by software.
        TIM4EN: u1,
        /// TIM5 clock enable Set and cleared by software.
        TIM5EN: u1,
        /// TIM6 clock enable Set and cleared by software.
        TIM6EN: u1,
        /// TIM7 clock enable Set and cleared by software.
        TIM7EN: u1,
        reserved11: u5 = 0,
        /// WWDG clock enable Set by software to enable the window watchdog clock. Reset by hardware system reset. This bit can also be set by hardware if the WWDG_SW option bit is reset.
        WWDGEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clock enable Set and cleared by software.
        SPI2EN: u1,
        reserved17: u2 = 0,
        /// USART2 clock enable Set and cleared by software.
        USART2EN: u1,
        /// USART3 clock enable Set and cleared by software.
        USART3EN: u1,
        /// UART4 clock enable Set and cleared by software.
        UART4EN: u1,
        /// UART5 clock enable Set and cleared by software.
        UART5EN: u1,
        /// I2C1 clock enable Set and cleared by software.
        I2C1EN: u1,
        /// I2C2 clock enable Set and cleared by software.
        I2C2EN: u1,
        reserved24: u1 = 0,
        /// CRS clock enable Set and cleared by software.
        CRSEN: u1,
        /// USART6 clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USART6EN: u1,
        padding: u6 = 0,
    }),
    /// RCC APB1 peripheral clock enable register 2
    /// offset: 0xa0
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// I2C4 clock enable Set and cleared by software
        I2C4EN: u1,
        reserved5: u3 = 0,
        /// LPTIM2 clock enable Set and cleared by software.
        LPTIM2EN: u1,
        /// I2C5 clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C5EN: u1,
        /// I2C6 clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C6EN: u1,
        reserved9: u1 = 0,
        /// FDCAN1 clock enable Set and cleared by software.
        FDCAN1EN: u1,
        reserved23: u13 = 0,
        /// UCPD1 clock enable Set and cleared by software.
        UCPD1EN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 peripheral clock enable register
    /// offset: 0xa4
    APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 clock enable Set and cleared by software.
        TIM1EN: u1,
        /// SPI1 clock enable Set and cleared by software.
        SPI1EN: u1,
        /// TIM8 clock enable Set and cleared by software.
        TIM8EN: u1,
        /// USART1clock enable Set and cleared by software.
        USART1EN: u1,
        reserved16: u1 = 0,
        /// TIM15 clock enable Set and cleared by software.
        TIM15EN: u1,
        /// TIM16 clock enable Set and cleared by software.
        TIM16EN: u1,
        /// TIM17 clock enable Set and cleared by software.
        TIM17EN: u1,
        reserved21: u2 = 0,
        /// SAI1 clock enable Set and cleared by software.
        SAI1EN: u1,
        /// SAI2 clock enable Set and cleared by software.
        SAI2EN: u1,
        reserved24: u1 = 0,
        /// USB clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USBEN: u1,
        /// GFXTIM clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXTIMEN: u1,
        /// LTDC clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        LTDCEN: u1,
        /// DSI clock enable This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        DSIEN: u1,
        padding: u4 = 0,
    }),
    /// RCC APB3 peripheral clock enable register
    /// offset: 0xa8
    APB3ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG clock enable Set and cleared by software.
        SYSCFGEN: u1,
        reserved5: u3 = 0,
        /// SPI3 clock enable Set and cleared by software.
        SPI3EN: u1,
        /// LPUART1 clock enable Set and cleared by software.
        LPUART1EN: u1,
        /// I2C3 clock enable Set and cleared by software.
        I2C3EN: u1,
        reserved11: u3 = 0,
        /// LPTIM1 clock enable Set and cleared by software.
        LPTIM1EN: u1,
        /// LPTIM3 clock enable Set and cleared by software.
        LPTIM3EN: u1,
        /// LPTIM4 clock enable Set and cleared by software.
        LPTIM4EN: u1,
        /// OPAMP clock enable Set and cleared by software.
        OPAMPEN: u1,
        /// COMP clock enable Set and cleared by software.
        COMPEN: u1,
        reserved20: u4 = 0,
        /// VREFBUF clock enable Set and cleared by software.
        VREFEN: u1,
        /// RTC and TAMP APB clock enable Set and cleared by software.
        RTCAPBEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xac
    reserved172: [4]u8,
    /// RCC AHB1 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xb0
    AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        GPDMA1SMEN: u1,
        /// CORDIC clocks enable during Sleep and Stop modes Set and cleared by software during Sleep mode.
        CORDICSMEN: u1,
        /// FMAC clocks enable during Sleep and Stop modes. Set and cleared by software.
        FMACSMEN: u1,
        /// MDF1 clocks enable during Sleep and Stop modes. Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        MDF1SMEN: u1,
        reserved8: u4 = 0,
        /// FLASH clocks enable during Sleep and Stop modes Set and cleared by software.
        FLASHSMEN: u1,
        reserved12: u3 = 0,
        /// CRC clocks enable during Sleep and Stop modes Set and cleared by software.
        CRCSMEN: u1,
        reserved15: u2 = 0,
        /// JPEG clocks enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        JPEGSMEN: u1,
        /// TSC clocks enable during Sleep and Stop modes Set and cleared by software.
        TSCSMEN: u1,
        /// RAMCFG clocks enable during Sleep and Stop modes Set and cleared by software.
        RAMCFGSMEN: u1,
        /// DMA2D clocks enable during Sleep and Stop modes Set and cleared by software.
        DMA2DSMEN: u1,
        /// GFXMMU clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXMMUSMEN: u1,
        /// GPU2D clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPU2DSMEN: u1,
        /// DCACHE2 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        DCACHE2SMEN: u1,
        reserved24: u2 = 0,
        /// GTZC1 clocks enable during Sleep and Stop modes Set and cleared by software.
        GTZC1SMEN: u1,
        reserved28: u3 = 0,
        /// BKPSRAM clocks enable during Sleep and Stop modes Set and cleared by software
        BKPSRAMSMEN: u1,
        /// ICACHE clocks enable during Sleep and Stop modes Set and cleared by software.
        ICACHESMEN: u1,
        /// DCACHE1 clocks enable during Sleep and Stop modes Set and cleared by software.
        DCACHE1SMEN: u1,
        /// SRAM1 clocks enable during Sleep and Stop modes Set and cleared by software.
        SRAM1SMEN: u1,
    }),
    /// RCC AHB2 peripheral clocks enable in Sleep and Stop modes register 1
    /// offset: 0xb4
    AHB2SMENR1: mmio.Mmio(packed struct(u32) {
        /// IO port A clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOASMEN: u1,
        /// IO port B clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOBSMEN: u1,
        /// IO port C clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOCSMEN: u1,
        /// IO port D clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIODSMEN: u1,
        /// IO port E clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOESMEN: u1,
        /// IO port F clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOFSMEN: u1,
        /// IO port G clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOGSMEN: u1,
        /// IO port H clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOHSMEN: u1,
        /// IO port I clocks enable during Sleep and Stop modes Set and cleared by software.
        GPIOISMEN: u1,
        /// I/O port J clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GPIOJSMEN: u1,
        /// ADC1 and ADC2 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit impacts ADC1 in STM32U535/545/575/585 and ADC1/ADC2 in�STM32U59x/5Ax/5Fx/5Gx.
        ADC12SMEN: u1,
        reserved12: u1 = 0,
        /// DCMI and PSSI clocks enable during Sleep and Stop modes Set and cleared by software.
        DCMISMEN: u1,
        reserved14: u1 = 0,
        /// OTG_FS clocks enable during Sleep and Stop modes Set and cleared by software.
        USB_OTG_FSSMEN: u1,
        /// OTG_HS PHY clock enable during Sleep and Stop modes This bit is set and cleared by software Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USB_OTG_HS_PHYSMEN: u1,
        /// AES clock enable during Sleep and Stop modes Set and cleared by software
        AESSMEN: u1,
        /// HASH clock enable during Sleep and Stop modes Set and cleared by software
        HASHSMEN: u1,
        /// Random number generator (RNG) clocks enable during Sleep and Stop modes Set and cleared by software.
        RNGSMEN: u1,
        /// PKA clocks enable during Sleep and Stop modes Set and cleared by software.
        PKASMEN: u1,
        /// SAES accelerator clocks enable during Sleep and Stop modes Set and cleared by software.
        SAESSMEN: u1,
        /// OCTOSPIM clocks enable during Sleep and Stop modes Set and cleared by software.
        OCTOSPIMSMEN: u1,
        reserved23: u1 = 0,
        /// OTFDEC1 clocks enable during Sleep and Stop modes Set and cleared by software.
        OTFDEC1SMEN: u1,
        /// OTFDEC2 clocks enable during Sleep and Stop modes Set and cleared by software.
        OTFDEC2SMEN: u1,
        reserved27: u2 = 0,
        /// SDMMC1 clocks enable during Sleep and Stop modes Set and cleared by software.
        SDMMC1SMEN: u1,
        /// SDMMC2 clocks enable during Sleep and Stop modes Set and cleared by software.
        SDMMC2SMEN: u1,
        reserved30: u1 = 0,
        /// SRAM2 clocks enable during Sleep and Stop modes Set and cleared by software.
        SRAM2SMEN: u1,
        /// SRAM3 clocks enable during Sleep and Stop modes Set and cleared by software.
        SRAM3SMEN: u1,
    }),
    /// RCC AHB2 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0xb8
    AHB2SMENR2: mmio.Mmio(packed struct(u32) {
        /// FSMC clocks enable during Sleep and Stop modes Set and cleared by software.
        FSMCSMEN: u1,
        reserved4: u3 = 0,
        /// OCTOSPI1 clocks enable during Sleep and Stop modes Set and cleared by software.
        OCTOSPI1SMEN: u1,
        reserved8: u3 = 0,
        /// OCTOSPI2 clocks enable during Sleep and Stop modes Set and cleared by software.
        OCTOSPI2SMEN: u1,
        reserved12: u3 = 0,
        /// HSPI1 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        HSPI1SMEN: u1,
        reserved30: u17 = 0,
        /// SRAM6 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        SRAM6SMEN: u1,
        /// SRAM5 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        SRAM5SMEN: u1,
    }),
    /// RCC AHB3 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xbc
    AHB3SMENR: mmio.Mmio(packed struct(u32) {
        /// LPGPIO1 enable during Sleep and Stop modes Set and cleared by software.
        LPGPIO1SMEN: u1,
        reserved2: u1 = 0,
        /// PWR clock enable during Sleep and Stop modes Set and cleared by software.
        PWRSMEN: u1,
        reserved5: u2 = 0,
        /// ADC4 clock enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        ADC4SMEN: u1,
        /// DAC1 clock enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        DAC1SMEN: u1,
        reserved9: u2 = 0,
        /// LPDMA1 clock enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPDMA1SMEN: u1,
        /// ADF1 clock enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        ADF1SMEN: u1,
        reserved12: u1 = 0,
        /// GTZC2 clock enable during Sleep and Stop modes Set and cleared by software.
        GTZC2SMEN: u1,
        reserved31: u18 = 0,
        /// SRAM4 clocks enable during Sleep and Stop modes Set and cleared by software.
        SRAM4SMEN: u1,
    }),
    /// offset: 0xc0
    reserved192: [4]u8,
    /// RCC APB1 peripheral clocks enable in Sleep and Stop modes register 1
    /// offset: 0xc4
    APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM2SMEN: u1,
        /// TIM3 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM3SMEN: u1,
        /// TIM4 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM4SMEN: u1,
        /// TIM5 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM5SMEN: u1,
        /// TIM6 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM6SMEN: u1,
        /// TIM7 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM7SMEN: u1,
        reserved11: u5 = 0,
        /// Window watchdog clocks enable during Sleep and Stop modes Set and cleared by software. This bit is forced to 1 by hardware when the hardware WWDG option is activated.
        WWDGSMEN: u1,
        reserved14: u2 = 0,
        /// SPI2 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI2SMEN: u1,
        reserved17: u2 = 0,
        /// USART2 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        USART2SMEN: u1,
        /// USART3 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        USART3SMEN: u1,
        /// UART4 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        UART4SMEN: u1,
        /// UART5 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        UART5SMEN: u1,
        /// I2C1 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C1SMEN: u1,
        /// I2C2 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C2SMEN: u1,
        reserved24: u1 = 0,
        /// CRS clock enable during Sleep and Stop modes Set and cleared by software.
        CRSSMEN: u1,
        /// USART6 clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USART6SMEN: u1,
        padding: u6 = 0,
    }),
    /// RCC APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0xc8
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// I2C4 clocks enable during Sleep and Stop modes Set and cleared by software Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C4SMEN: u1,
        reserved5: u3 = 0,
        /// LPTIM2 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM2SMEN: u1,
        /// I2C5 clock enable during Sleep and Stop modes This bit is set and cleared by software Note: This bit must be set to allow the peripheral to wake up from Stop modes. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C5SMEN: u1,
        /// I2C6 clock enable during Sleep and Stop modes This bit is set and cleared by software Note: This bit must be set to allow the peripheral to wake up from Stop modes. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        I2C6SMEN: u1,
        reserved9: u1 = 0,
        /// FDCAN1 clocks enable during Sleep and Stop modes Set and cleared by software.
        FDCAN1SMEN: u1,
        reserved23: u13 = 0,
        /// UCPD1 clocks enable during Sleep and Stop modes Set and cleared by software.
        UCPD1SMEN: u1,
        padding: u8 = 0,
    }),
    /// RCC APB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xcc
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM1SMEN: u1,
        /// SPI1 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI1SMEN: u1,
        /// TIM8 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM8SMEN: u1,
        /// USART1clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        USART1SMEN: u1,
        reserved16: u1 = 0,
        /// TIM15 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM15SMEN: u1,
        /// TIM16 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM16SMEN: u1,
        /// TIM17 clocks enable during Sleep and Stop modes Set and cleared by software.
        TIM17SMEN: u1,
        reserved21: u2 = 0,
        /// SAI1 clocks enable during Sleep and Stop modes Set and cleared by software.
        SAI1SMEN: u1,
        /// SAI2 clocks enable during Sleep and Stop modes Set and cleared by software.
        SAI2SMEN: u1,
        reserved24: u1 = 0,
        /// USB clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        USBSMEN: u1,
        /// GFXTIM clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        GFXTIMSMEN: u1,
        /// LTDC clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        LTDCSMEN: u1,
        /// DSI clock enable during Sleep and Stop modes This bit is set and cleared by software. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        DSISMEN: u1,
        padding: u4 = 0,
    }),
    /// RCC APB3 peripheral clock enable in Sleep and Stop modes register
    /// offset: 0xd0
    APB3SMENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG clocks enable during Sleep and Stop modes Set and cleared by software.
        SYSCFGSMEN: u1,
        reserved5: u3 = 0,
        /// SPI3 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI3SMEN: u1,
        /// LPUART1 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPUART1SMEN: u1,
        /// I2C3 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C3SMEN: u1,
        reserved11: u3 = 0,
        /// LPTIM1 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM1SMEN: u1,
        /// LPTIM3 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM3SMEN: u1,
        /// LPTIM4 clocks enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM4SMEN: u1,
        /// OPAMP clocks enable during Sleep and Stop modes Set and cleared by software.
        OPAMPSMEN: u1,
        /// COMP clocks enable during Sleep and Stop modes Set and cleared by software.
        COMPSMEN: u1,
        reserved20: u4 = 0,
        /// VREFBUF clocks enable during Sleep and Stop modes Set and cleared by software.
        VREFSMEN: u1,
        /// RTC and TAMP APB clock enable during Sleep and Stop modes Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        RTCAPBSMEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xd4
    reserved212: [4]u8,
    /// RCC SmartRun domain peripheral autonomous mode register
    /// offset: 0xd8
    SRDAMR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// SPI3 autonomous mode enable in Stop 0,1, 2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI3AMEN: u1,
        /// LPUART1 autonomous mode enable in Stop 0,1, 2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPUART1AMEN: u1,
        /// I2C3 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C3AMEN: u1,
        reserved11: u3 = 0,
        /// LPTIM1 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM1AMEN: u1,
        /// LPTIM3 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM3AMEN: u1,
        /// LPTIM4 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM4AMEN: u1,
        /// OPAMP autonomous mode enable in Stop 0,1,2 mode Set and cleared by software.
        OPAMPAMEN: u1,
        /// COMP autonomous mode enable in Stop 0,1,2 mode Set and cleared by software.
        COMPAMEN: u1,
        reserved20: u4 = 0,
        /// VREFBUF autonomous mode enable in Stop 0,1,2 mode Set and cleared by software.
        VREFAMEN: u1,
        /// RTC and TAMP autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        RTCAPBAMEN: u1,
        reserved25: u3 = 0,
        /// ADC4 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        ADC4AMEN: u1,
        /// LPGPIO1 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software.
        LPGPIO1AMEN: u1,
        /// DAC1 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        DAC1AMEN: u1,
        /// LPDMA1 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPDMA1AMEN: u1,
        /// ADF1 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        ADF1AMEN: u1,
        reserved31: u1 = 0,
        /// SRAM4 autonomous mode enable in Stop 0,1,2 mode Set and cleared by software.
        SRAM4AMEN: u1,
    }),
    /// offset: 0xdc
    reserved220: [4]u8,
    /// RCC peripherals independent clock configuration register 1
    /// offset: 0xe0
    CCIPR1: mmio.Mmio(packed struct(u32) {
        /// USART1 kernel clock source selection This bits are used to select the USART1 kernel clock source. Note: The USART1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        USART1SEL: USART1SEL,
        /// USART2 kernel clock source selection This bits are used to select the USART2 kernel clock source. Note: The USART2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        USART2SEL: USARTSEL,
        /// USART3 kernel clock source selection This bits are used to select the USART3 kernel clock source. Note: The USART3 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        USART3SEL: USARTSEL,
        /// UART4 kernel clock source selection This bits are used to select the UART4 kernel clock source. Note: The UART4 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        UART4SEL: USARTSEL,
        /// UART5 kernel clock source selection These bits are used to select the UART5 kernel clock source. Note: The UART5 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        UART5SEL: USARTSEL,
        /// I2C1 kernel clock source selection These bits are used to select the I2C1 kernel clock source. Note: The I2C1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or MSIK.
        I2C1SEL: I2CSEL,
        /// I2C2 kernel clock source selection These bits are used to select the I2C2 kernel clock source. Note: The I2C2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or MSIK.
        I2C2SEL: I2CSEL,
        /// I2C4 kernel clock source selection These bits are used to select the I2C4 kernel clock source. Note: The I2C4 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or MSIK.
        I2C4SEL: I2CSEL,
        /// SPI2 kernel clock source selection These bits are used to select the SPI2 kernel clock source. Note: The SPI2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or MSIK.
        SPI2SEL: SPI2SEL,
        /// Low-power timer 2 kernel clock source selection These bits are used to select the LPTIM2 kernel clock source. Note: The LPTIM2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is LSI, LSE or HSI if HSIKERON = 1.
        LPTIM2SEL: LPTIM2SEL,
        /// SPI1 kernel clock source selection These bits are used to select the SPI1 kernel clock source. Note: The SPI1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or MSIK.
        SPI1SEL: SPI1SEL,
        /// SysTick clock source selection These bits are used to select the SysTick clock source. Note: When LSE or LSI is selected, the AHB frequency must be at least four times higher than the LSI or LSE frequency. In addition, a jitter up to one HCLK cycle is introduced, due to the LSE or LSI sampling with HCLK in the SysTick circuitry.
        SYSTICKSEL: SYSTICKSEL,
        /// FDCAN1 kernel clock source selection These bits are used to select the FDCAN1 kernel clock source.
        FDCAN1SEL: FDCANSEL,
        /// intermediate clock source selection These bits are used to select the clock source used by OTG_FS and SDMMC.
        ICLKSEL: ICLKSEL,
        reserved29: u1 = 0,
        /// Clocks sources for TIM16,TIM17 and LPTIM2 internal input capture When the TIMICSEL2 bit is set, the TIM16, TIM17 and LPTIM2 internal input capture can be connected either to HSI/256, MSI/4 or MSI/1024. Depending on TIMICSEL[1:0] value, MSI is either MSIK or MSIS. When TIMICSEL2 is cleared, the HSI, MSIK and MSIS clock sources cannot be selected as TIM16, TIM17 or LPTIM2 internal input capture. 0xx: HSI, MSIK and MSIS dividers disabled Note: The clock division must be disabled (TIMICSEL configured to 0xx) before selecting or changing a clock sources division.
        TIMICSEL: TIMICSEL,
    }),
    /// RCC peripherals independent clock configuration register 2
    /// offset: 0xe4
    CCIPR2: mmio.Mmio(packed struct(u32) {
        /// MDF1 kernel clock source selection These bits are used to select the MDF1 kernel clock source. others: reserved
        MDF1SEL: MDFSEL,
        reserved5: u2 = 0,
        /// SAI1 kernel clock source selection These bits are used to select the SAI1 kernel clock source. others: reserved Note: If the selected clock is the external clock and this clock is stopped, a switch to another clock is impossible.
        SAI1SEL: SAISEL,
        /// SAI2 kernel clock source selection These bits are used to select the SAI2 kernel clock source. others: reserved Note: If the selected clock is the external clock and this clock is stopped, a switch to another clock is impossible.
        SAI2SEL: SAISEL,
        /// SAES kernel clock source selection This bit is used to select the SAES kernel clock source.
        SAESSEL: SAESSEL,
        /// RNGSEL kernel clock source selection These bits are used to select the RNG kernel clock source.
        RNGSEL: RNGSEL,
        /// SDMMC1 and SDMMC2 kernel clock source selection This bit is used to select the SDMMC kernel clock source. It is recommended to change this bit only after reset and before enabling the SDMMC.
        SDMMCSEL: SDMMCSEL,
        /// DSI kernel clock source selection This bit is used to select the DSI kernel clock source. This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. Note: If not present, consider this bit as reserved and keep it at reset value.
        DSISEL: DSISEL,
        /// USART6 kernel clock source selection These bits are used to select the USART6 kernel clock source. The USART6 is functional in Stop 0 and Stop 1 modes only when the kernel clock is HSI or LSE. Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        USART6SEL: USARTSEL,
        /// LTDC kernel clock source selection This bit is used to select the LTDC kernel clock source. Note: This bit is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bit as reserved and keep it at reset value.
        LTDCSEL: LTDCSEL,
        reserved20: u1 = 0,
        /// OCTOSPI1 and OCTOSPI2 kernel clock source selection These bits are used to select the OCTOSPI1 and OCTOSPI2 kernel clock source.
        OCTOSPISEL: OCTOSPISEL,
        /// HSPI1 kernel clock source selection These bits are used to select the HSPI1 kernel clock source. Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        HSPI1SEL: HSPISEL,
        /// I2C5 kernel clock source selection These bits are used to select the I2C5 kernel clock source. The I2C5 is functional in Stop 0 and Stop 1 modes only when the kernel clock is HSI�or MSIK. Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        I2C5SEL: I2CSEL,
        /// I2C6 kernel clock source selection These bits are used to select the I2C6 kernel clock source. The I2C6 is functional in Stop 0 and Stop 1 modes only when the kernel clock is HSI�or MSIK. Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        I2C6SEL: I2CSEL,
        reserved30: u2 = 0,
        /// OTG_HS PHY kernel clock source selection These bits are used to select the OTG_HS PHY kernel clock source. Note: This bitfield is only available on some devices in the STM32U5 Series. Refer to the device datasheet for availability of its associated peripheral. If not present, consider this bitfield as reserved and keep it at reset value.
        OTGHSSEL: OTGHSSEL,
    }),
    /// RCC peripherals independent clock configuration register 3
    /// offset: 0xe8
    CCIPR3: mmio.Mmio(packed struct(u32) {
        /// LPUART1 kernel clock source selection These bits are used to select the LPUART1 kernel clock source. others: reserved Note: The LPUART1 is functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is HSI, LSE or MSIK.
        LPUART1SEL: LPUSARTSEL,
        /// SPI3 kernel clock source selection These bits are used to select the SPI3 kernel clock source. Note: The SPI3 is functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is HSI or MSIK.
        SPI3SEL: SPI3SEL,
        reserved6: u1 = 0,
        /// I2C3 kernel clock source selection These bits are used to select the I2C3 kernel clock source. Note: The I2C3 is functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is HSI or MSIK.
        I2C3SEL: I2C3SEL,
        /// LPTIM3 and LPTIM4 kernel clock source selection These bits are used to select the LPTIM3 and LPTIM4 kernel clock source. Note: The LPTIM3 and LPTIM4 are functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is LSI, LSE, HSI with HSIKERON = 1 or MSIK with MSIKERON = 1.
        LPTIM34SEL: LPTIMSEL,
        /// LPTIM1 kernel clock source selection These bits are used to select the LPTIM1 kernel clock source. Note: The LPTIM1 is functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is LSI, LSE, HSI with HSIKERON = 1 or MSIK with MSIKERON = 1.
        LPTIM1SEL: LPTIMSEL,
        /// ADC1, ADC4 and DAC1 kernel clock source selection These bits are used to select the ADC1, ADC4 and DAC1 kernel clock source. others: reserved Note: The ADC1, ADC4 and DAC1 are functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is HSI or MSIK (only ADC4 and DAC1 are functional in Stop 2 mode).
        ADCDACSEL: ADCDACSEL,
        /// DAC1 sample and hold clock source selection This bit is used to select the DAC1 sample and hold clock source.
        DAC1SEL: DACSEL,
        /// ADF1 kernel clock source selection These bits are used to select the ADF1 kernel clock source. others: reserved Note: The ADF1 is functional in Stop 0, Stop 1 and Stop 2 modes only when the kernel clock is AUDIOCLK or MSIK.
        ADF1SEL: ADFSEL,
        padding: u13 = 0,
    }),
    /// offset: 0xec
    reserved236: [4]u8,
    /// RCC Backup domain control register
    /// offset: 0xf0
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable Set and cleared by software.
        LSEON: u1,
        /// LSE oscillator ready Set and cleared by hardware to indicate when the external 32 kHz oscillator is stable. After the LSEON bit is cleared, LSERDY goes low after six external low-speed oscillator clock cycles.
        LSERDY: u1,
        /// LSE oscillator bypass Set and cleared by software to bypass oscillator in debug mode. This bit can be written only when the external 32 kHz oscillator is disabled (LSEON = 0 and LSERDY = 0).
        LSEBYP: u1,
        /// LSE oscillator drive capability Set by software to modulate the drive capability of the LSE oscillator. This field can be written only when the external 32 kHz oscillator is disabled (LSEON = 0 and LSERDY = 0). Note: The oscillator is in 'Xtal mode when it is not in bypass mode.
        LSEDRV: LSEDRV,
        /// CSS on LSE enable Set by software to enable the CSS on LSE. LSECSSON must be enabled after the LSE oscillator is enabled (LSEON bit enabled) and ready (LSERDY flag set by hardware), and after the RTCSEL bit is selected. Once enabled, this bit cannot be disabled, except after a LSE failure detection (LSECSSD = 1). In that case, the software must disable the LSECSSON bit.
        LSECSSON: u1,
        /// CSS on LSE failure Detection Set by hardware to indicate when a failure is detected by the CCS on the external 32 kHz oscillator (LSE).
        LSECSSD: u1,
        /// LSE system clock (LSESYS) enable Set by software to enable always the LSE system clock generated by RCC. This clock can be used by any peripheral when its source clock is the LSE or at system level in case of one of the LSCOSEL, MCO, MSI PLL mode or CSS on LSE is needed. The LSESYS clock can be generated even if LSESYSEN= 0 if the LSE clock is requested by the CSS on LSE, by a peripheral or any other source clock using LSE.
        LSESYSEN: u1,
        /// RTC and TAMP clock source selection Set by software to select the clock source for the RTC and TAMP . Once the RTC and TAMP clock source has been selected, it cannot be changed anymore unless the Backup domain is reset, or unless a failure is detected on LSE (LSECSSD is set). The BDRST bit can be used to reset them.
        RTCSEL: RTCSEL,
        reserved11: u1 = 0,
        /// LSE system clock (LSESYS) ready Set and cleared by hardware to indicate when the LSE system clock is stable.When the LSESYSEN bit is set, the LSESYSRDY flag is set after two LSE clock cycles. The LSE clock must be already enabled and stable (LSEON and LSERDY are set). When the LSEON bit is cleared, LSERDY goes low after six external low-speed oscillator clock cycles.
        LSESYSRDY: u1,
        /// LSE clock glitch filter enable Set and cleared by hardware to enable the LSE glitch filter. This bit can be written only when the LSE is disabled (LSEON = 0 and LSERDY = 0)
        LSEGFON: u1,
        reserved15: u2 = 0,
        /// RTC and TAMP clock enable Set and cleared by software.
        RTCEN: u1,
        /// Backup domain software reset Set and cleared by software.
        BDRST: u1,
        reserved24: u7 = 0,
        /// Low-speed clock output (LSCO) enable Set and cleared by software.
        LSCOEN: u1,
        /// Low-speed clock output selection Set and cleared by software.
        LSCOSEL: LSCOSEL,
        /// LSI oscillator enable Set and cleared by software.
        LSION: u1,
        /// LSI oscillator ready Set and cleared by hardware to indicate when the LSI oscillator is stable. After the LSION bit is cleared, LSIRDY goes low after three internal low-speed oscillator clock cycles. This bit is set when the LSI is used by IWDG or RTC, even if LSION = 0.
        LSIRDY: u1,
        /// Low-speed clock divider configuration Set and cleared by software to enable the LSI division. This bit can be written only when the LSI is disabled (LSION = 0 and LSIRDY = 0). If the LSI was previously enabled, it is necessary to wait for at least 60 Î¼s after clearing LSION bit (synchronization time for LSI to be really disabled), before writing LSIPREDIV. The LSIPREDIV cannot be changed if the LSI is used by the IWDG or by the RTC.
        LSIPREDIV: LSIPREDIV,
        padding: u3 = 0,
    }),
    /// RCC control/status register
    /// offset: 0xf4
    CSR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// MSIK range after Standby mode Set by software to chose the MSIK frequency at startup. This range is used after exiting Standby mode until MSIRGSEL is set. After a NRST pin or a power-on reset or when exiting Shutdown mode, the range is always 4 MHz. MSIKSRANGE can be written only when MSIRGSEL = 1. others: reserved Note: Changing the MSIKSRANGE does not change the current MSIK frequency.
        MSIKSRANGE: MSIXSRANGE,
        /// MSIS range after Standby mode Set by software to chose the MSIS frequency at startup. This range is used after exiting Standby mode until MSIRGSEL is set. After a NRST pin or a power-on reset or when exiting Shutdown mode, the range is always 4 MHz. MSISSRANGE can be written only when MSIRGSEL = 1. others: reserved Note: Changing the MSISSRANGE does not change the current MSIS frequency.
        MSISSRANGE: MSIXSRANGE,
        reserved23: u7 = 0,
        /// Remove reset flag Set by software to clear the reset flags.
        RMVF: u1,
        reserved25: u1 = 0,
        /// Option byte loader reset flag Set by hardware when a reset from the option byte loading occurs. Cleared by writing to the RMVF bit.
        OBLRSTF: u1,
        /// NRST pin reset flag Set by hardware when a reset from the NRST pin occurs. Cleared by writing to the RMVF bit.
        PINRSTF: u1,
        /// BOR flag Set by hardware when a BOR occurs. Cleared by writing to the RMVF bit.
        BORRSTF: u1,
        /// Software reset flag Set by hardware when a software reset occurs. Cleared by writing to the RMVF bit.
        SFTRSTF: u1,
        /// Independent watchdog reset flag Set by hardware when an independent watchdog reset domain occurs. Cleared by writing to the RMVF bit.
        IWDGRSTF: u1,
        /// Window watchdog reset flag Set by hardware when a window watchdog reset occurs. Cleared by writing to the RMVF bit.
        WWDGRSTF: u1,
        /// Low-power reset flag Set by hardware when a reset occurs due to Stop, Standby or Shutdown mode entry, whereas the corresponding nRST_STOP, nRST_STBY or nRST_SHDW option bit is cleared. Cleared by writing to the RMVF bit.
        LPWRRSTF: u1,
    }),
    /// offset: 0xf8
    reserved248: [24]u8,
    /// RCC secure configuration register
    /// offset: 0x110
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock configuration and status bits security Set and reset by software.
        HSISEC: SECURITY,
        /// HSE clock configuration bits, status bits and HSE_CSS security Set and reset by software.
        HSESEC: SECURITY,
        /// MSI clock configuration and status bits security Set and reset by software.
        MSISEC: SECURITY,
        /// LSI clock configuration and status bits security Set and reset by software.
        LSISEC: SECURITY,
        /// LSE clock configuration and status bits security Set and reset by software.
        LSESEC: SECURITY,
        /// SYSCLK clock selection, STOPWUCK bit, clock output on MCO configuration security Set and reset by software.
        SYSCLKSEC: SECURITY,
        /// AHBx/APBx prescaler configuration bits security Set and reset by software.
        PRESCSEC: SECURITY,
        /// (1/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[0]": SECURITY,
        /// (2/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[1]": SECURITY,
        /// (3/3 of PLLSEC) PLL1 clock configuration and status bits security Set and reset by software.
        @"PLLSEC[2]": SECURITY,
        /// intermediate clock source selection security Set and reset by software.
        ICLKSEC: SECURITY,
        /// HSI48 clock configuration and status bits security Set and reset by software.
        HSI48SEC: SECURITY,
        /// Remove reset flag security Set and reset by software.
        RMVFSEC: SECURITY,
        padding: u19 = 0,
    }),
    /// RCC privilege configuration register
    /// offset: 0x114
    PRIVCFGR: mmio.Mmio(packed struct(u32) {
        /// RCC secure functions privilege configuration Set and reset by software. This bit can be written only by a secure privileged access.
        SPRIV: u1,
        /// RCC non-secure functions privilege configuration Set and reset by software. This bit can be written only by privileged access, secure or non-secure.
        NSPRIV: u1,
        padding: u30 = 0,
    }),
};
