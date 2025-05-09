const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADCSEL = enum(u2) {
    SYS = 0x0,
    PLL1_P = 0x1,
    HSI = 0x2,
    _,
};

pub const CLK48SEL = enum(u2) {
    DISABLE = 0x0,
    MSI = 0x1,
    PLL1_Q = 0x2,
    HSI48 = 0x3,
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

pub const I2C1SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    _,
};

pub const I2C3SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    _,
};

pub const LPTIM1SEL = enum(u2) {
    PCLK1 = 0x0,
    LSI = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LPTIM2SEL = enum(u2) {
    PCLK1 = 0x0,
    LSI = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LPTIM3SEL = enum(u2) {
    PCLK1 = 0x0,
    LSI = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LPUART1SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LPUART2SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LPUART3SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const LSCOSEL = enum(u1) {
    LSI = 0x0,
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
    Div1 = 0x0,
    Div128 = 0x1,
};

pub const MCOPRE = enum(u4) {
    Div1 = 0x0,
    Div2 = 0x1,
    Div4 = 0x2,
    Div8 = 0x3,
    Div16 = 0x4,
    Div32 = 0x5,
    Div64 = 0x6,
    Div128 = 0x7,
    Div256 = 0x8,
    Div512 = 0x9,
    Div1024 = 0xa,
    _,
};

pub const MCOSEL = enum(u4) {
    DISABLE = 0x0,
    SYS = 0x1,
    MSI = 0x2,
    HSI = 0x3,
    HSE = 0x4,
    PLL1_R = 0x5,
    LSI = 0x6,
    LSE = 0x7,
    HSI48 = 0x8,
    RTC = 0x9,
    RTC_WKUP = 0xa,
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

pub const MSISRANGE = enum(u4) {
    RANGE_81MHz = 0x4,
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
    Mul4 = 0x4,
    Mul5 = 0x5,
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
    Div32 = 0x1f,
    _,
};

pub const PLLQ = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
    _,
};

pub const PLLR = enum(u3) {
    Div2 = 0x1,
    Div3 = 0x2,
    Div4 = 0x3,
    Div5 = 0x4,
    Div6 = 0x5,
    Div7 = 0x6,
    Div8 = 0x7,
    _,
};

pub const PLLSRC = enum(u2) {
    DISABLE = 0x0,
    MSI = 0x1,
    HSI = 0x2,
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
    DISABLE = 0x0,
    LSE = 0x1,
    LSI = 0x2,
    HSE = 0x3,
};

pub const SW = enum(u3) {
    MSI = 0x0,
    HSI = 0x1,
    HSE = 0x2,
    PLL1_R = 0x3,
    LSI = 0x4,
    LSE = 0x5,
    _,
};

pub const TIM15SEL = enum(u1) {
    PCLK1_TIM = 0x0,
    PLL1_Q = 0x1,
};

pub const TIM1SEL = enum(u1) {
    PCLK1_TIM = 0x0,
    PLL1_Q = 0x1,
};

pub const USART1SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

pub const USART2SEL = enum(u2) {
    PCLK1 = 0x0,
    SYS = 0x1,
    HSI = 0x2,
    LSE = 0x3,
};

/// RCC address block description.
pub const RCC = extern struct {
    /// Clock control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// MSI clock enable This bit is set and cleared by software. Cleared by hardware to stop the MSI oscillator when entering Stop, Standby or Shutdown mode. Set by hardware to force the MSI oscillator ON when exiting Standby or Shutdown mode. Set by hardware to force the MSI oscillator ON when STOPWUCK=0 when exiting from Stop modes, or in case of a failure of the HSE oscillator Set by hardware when used directly or indirectly as system clock.
        MSION: u1,
        /// MSI clock ready flag This bit is set by hardware to indicate that the MSI oscillator is stable. Note: Once the MSION bit is cleared, MSIRDY goes low after 6 MSI clock cycles.
        MSIRDY: u1,
        /// MSI clock PLL enable Set and cleared by software to enable/ disable the PLL part of the MSI clock source. MSIPLLEN must be enabled after LSE is enabled (LSEON enabled) and ready (LSERDY set by hardware).There is a hardware protection to avoid enabling MSIPLLEN if LSE is not ready. This bit is cleared by hardware when LSE is disabled (LSEON = 0) or when the Clock Security System on LSE detects a LSE failure (refer to RCC_CSR register).
        MSIPLLEN: u1,
        /// MSI clock range selection Set by software to select the MSI clock range with MSIRANGE[3:0]. Write 0 has no effect. After a standby or a reset MSIRGSEL is at 0 and the MSI range value is provided by MSISRANGE in CSR register.
        MSIRGSEL: MSIRGSEL,
        /// MSI clock ranges These bits are configured by software to choose the frequency range of MSI when MSIRGSEL is set.12 frequency ranges are available: others: not allowed (hardware write protection) Note: Warning: MSIRANGE can be modified when MSI is OFF (MSION=0) or when MSI is ready (MSIRDY=1). MSIRANGE must NOT be modified when MSI is ON and NOT ready (MSION=1 and MSIRDY=0).
        MSIRANGE: MSIRANGE,
        /// HSI clock enable Set and cleared by software. Cleared by hardware to stop the HSI oscillator when entering Stop, Standby, or Shutdown mode. Forced by hardware to keep the HSI oscillator ON when it is used directly or indirectly as system clock (also when leaving Stop, Standby, or Shutdown modes, or in case of failure of the HSE oscillator used for system clock).
        HSION: u1,
        /// HSI always enable for peripheral kernels. Set and cleared by software to force HSI ON even in Stop modes. The HSI can only feed USART1, USART2, CEC and I2C1 peripherals configured with HSI as kernel clock. Keeping the HSI ON in Stop mode allows avoiding to slow down the communication speed because of the HSI startup time. This bit has no effect on HSION value.
        HSIKERON: u1,
        /// HSI clock ready flag Set by hardware to indicate that HSI oscillator is stable. This bit is set only when HSI is enabled by software by setting HSION. Note: Once the HSION bit is cleared, HSIRDY goes low after 6 HSI clock cycles.
        HSIRDY: u1,
        /// HSI automatic start from Stop Set and cleared by software. When the system wake-up clock is MSI, this bit is used to wake up the HSI is parallel of the system wake-up.
        HSIASFS: u1,
        reserved16: u4 = 0,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE oscillator when entering Stop, Standby, or Shutdown mode. This bit cannot be reset if the HSE oscillator is used directly or indirectly as the system clock.
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable. Note: Once the HSEON bit is cleared, HSERDY goes low after 6 HSE clock cycles.
        HSERDY: u1,
        /// HSE crystal oscillator bypass Set and cleared by software to bypass the oscillator with an external clock. The external clock must be enabled with the HSEON bit set, to be used by the device. The HSEBYP bit can be written only if the HSE oscillator is disabled.
        HSEBYP: u1,
        /// Clock security system enable Set by software to enable the clock security system. When CSSON is set, the clock detector is enabled by hardware when the HSE oscillator is ready, and disabled by hardware if a HSE clock failure is detected. This bit is set only and is cleared by reset.
        CSSON: u1,
        reserved24: u4 = 0,
        /// PLL enable Set and cleared by software to enable the PLL. Cleared by hardware when entering Stop, Standby or Shutdown mode. This bit cannot be reset if the PLL clock is used as the system clock.
        PLLON: u1,
        /// PLL clock ready flag Set by hardware to indicate that the PLL is locked.
        PLLRDY: u1,
        padding: u6 = 0,
    }),
    /// Internal clock sources calibration register.
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        /// MSI clock calibration These bits are initialized at startup with the factory-programmed MSI calibration trim value. When MSITRIM is written, MSICAL is updated with the sum of MSITRIM and the factory trim value.
        MSICAL: u8,
        /// MSI clock trimming These bits provide an additional user-programmable trimming value that is added to the MSICAL[7:0] bits. It can be programmed to adjust to variations in voltage and temperature that influence the frequency of the MSI.
        MSITRIM: u8,
        /// HSI clock calibration These bits are initialized at startup with the factory-programmed HSI calibration trim value. When HSITRIM is written, HSICAL is updated with the sum of HSITRIM and the factory trim value.
        HSICAL: u8,
        /// HSI clock trimming These bits provide an additional user-programmable trimming value that is added to the HSICAL[7:0] bits. It can be programmed to adjust to variations in voltage and temperature that influence the frequency of the HSI. The default value is 64 when added to the HSICAL value, trim the HSI to 161MHz 1 11%.
        HSITRIM: u7,
        padding: u1 = 0,
    }),
    /// Clock configuration register.
    /// offset: 0x08
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch This bitfield is controlled by software and hardware. The bitfield selects the clock for SYSCLK as follows: Others: Reserved The setting is forced by hardware to 000 (HSISYS selected) when the MCU exits Stop, Standby, or Shutdown mode, or when the setting is 001 (HSE selected) and HSE oscillator failure is detected.
        SW: SW,
        /// System clock switch status This bitfield is controlled by hardware to indicate the clock source used as system clock: Others: Reserved.
        SWS: SW,
        reserved8: u2 = 0,
        /// AHB prescaler This bitfield is controlled by software. To produce HCLK clock, it sets the division factor of SYSCLK clock as follows: 0xxx: 1 Caution: Depending on the device voltage range, the software has to set correctly these bits to ensure that the system frequency does not exceed the maximum allowed frequency (for more details, refer to Section14.1.4: Dynamic voltage scaling management). After a write operation to these bits and before decreasing the voltage range, this register must be read to be sure that the new value has been taken into account.
        HPRE: HPRE,
        /// APB prescaler This bitfield is controlled by software. To produce PCLK clock, it sets the division factor of HCLK clock as follows: 0xx: 1.
        PPRE: PPRE,
        /// Wake-up from Stop and CSS backup clock selection Set and cleared by software to select the system clock used when exiting Stop mode. The selected clock is also used as emergency clock for the Clock Security System on HSE. Warning: STOPWUCK must not be modified when the Clock Security System is enabled by HSECSSON in RCC_CR register and the system clock is HSE (SWS=10) or a switch on HSE is requested (SW=10).
        STOPWUCK: u1,
        /// Microcontroller clock output 2 clock selector This bitfield is controlled by software. It sets the clock selector for MCO2 output as follows: Others: Reserved Note: This clock output may have some truncated cycles at startup or during MCO2 clock source switching.
        MCO2SEL: MCOSEL,
        /// Microcontroller clock output 2 prescaler This bitfield is controlled by software. It sets the division factor of the clock sent to the MCO2 output as follows: ... Others: reserved It is highly recommended to set this field before the MCO2 output is enabled.
        MCO2PRE: MCOPRE,
        /// Microcontroller clock output clock selector This bitfield is controlled by software. It sets the clock selector for MCO output as follows: Others: Reserved Note: This clock output may have some truncated cycles at startup or during MCO clock source switching.
        MCOSEL: MCOSEL,
        /// Microcontroller clock output prescaler This bitfield is controlled by software. It sets the division factor of the clock sent to the MCO output as follows: ... Others: reserved It is highly recommended to set this field before the MCO output is enabled.
        MCOPRE: MCOPRE,
    }),
    /// PLL configuration register.
    /// offset: 0x0c
    PLLCFGR: mmio.Mmio(packed struct(u32) {
        /// PLL input clock source This bit is controlled by software to select PLL clock source, as follows: The bitfield can be written only when the PLL is disabled. When the PLL is not used, selecting 00 allows saving power.
        PLLSRC: PLLSRC,
        reserved4: u2 = 0,
        /// Division factor M of the PLL input clock divider This bit is controlled by software to divide the PLL input clock before the actual phase-locked loop, as follows: The bitfield can be written only when the PLL is disabled. Caution: The software must set these bits so that the PLL input frequency after the /M divider is between 2.66 and 161MHz.
        PLLM: PLLM,
        reserved8: u1 = 0,
        /// PLL frequency multiplication factor N This bit is controlled by software to set the division factor of the f<sub>VCO</sub> feedback divider (that determines the PLL multiplication ratio) as follows: ... ... The bitfield can be written only when the PLL is disabled. Caution: The software must set these bits so that the VCO output frequency is between 96 and 3441MHz.
        PLLN: PLLN,
        reserved16: u1 = 0,
        /// PLLPCLK clock output enable This bit is controlled by software to enable/disable the PLLPCLK clock output of the PLL: Disabling the PLLPCLK clock output, when not used, allows saving power.
        PLLPEN: u1,
        /// PLL VCO division factor P for PLLPCLK clock output This bitfield is controlled by software. It sets the PLL VCO division factor P as follows: ... The bitfield can be written only when the PLL is disabled. Caution: The software must set this bitfield so as not to exceed 541MHz on this clock.
        PLLP: PLLP,
        reserved24: u2 = 0,
        /// PLLQCLK clock output enable This bit is controlled by software to enable/disable the PLLQCLK clock output of the PLL: Disabling the PLLQCLK clock output, when not used, allows saving power.
        PLLQEN: u1,
        /// PLL VCO division factor Q for PLLQCLK clock output This bitfield is controlled by software. It sets the PLL VCO division factor Q as follows: The bitfield can be written only when the PLL is disabled. Caution: The software must set this bitfield so as not to exceed 541MHz on this clock.
        PLLQ: PLLQ,
        /// PLLRCLK clock output enable This bit is controlled by software to enable/disable the PLLRCLK clock output of the PLL: This bit cannot be written when PLLRCLK output of the PLL is selected for system clock. Disabling the PLLRCLK clock output, when not used, allows saving power.
        PLLREN: u1,
        /// PLL VCO division factor R for PLLRCLK clock output This bitfield is controlled by software. It sets the PLL VCO division factor R as follows: The bitfield can be written only when the PLL is disabled. The PLLRCLK clock can be selected as system clock. Caution: The software must set this bitfield so as not to exceed 122MHz on this clock.
        PLLR: PLLR,
    }),
    /// offset: 0x10
    reserved16: [8]u8,
    /// Clock interrupt enable register.
    /// offset: 0x18
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSI oscillator stabilization:.
        LSIRDYIE: u1,
        /// LSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSE oscillator stabilization:.
        LSERDYIE: u1,
        /// MSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the MSI oscillator stabilization.
        MSIRDYIE: u1,
        /// HSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSI oscillator stabilization:.
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSE oscillator stabilization:.
        HSERDYIE: u1,
        /// PLL ready interrupt enable Set and cleared by software to enable/disable interrupt caused by PLL lock:.
        PLLRDYIE: u1,
        reserved9: u3 = 0,
        /// LSE clock security system interrupt enable Set and cleared by software to enable/disable interrupt caused by the clock security system on LSE.
        LSECSSIE: u1,
        /// HSI48 ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the internal HSI48 oscillator.
        HSI48RDYIE: u1,
        padding: u21 = 0,
    }),
    /// Clock interrupt flag register.
    /// offset: 0x1c
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag Set by hardware when the LSI clock becomes stable and LSIRDYDIE is set. Cleared by software setting the LSIRDYC bit.
        LSIRDYF: u1,
        /// LSE ready interrupt flag Set by hardware when the LSE clock becomes stable and LSERDYDIE is set. Cleared by software setting the LSERDYC bit.
        LSERDYF: u1,
        /// MSI ready interrupt flag Set by hardware when the MSI clock becomes stable and MSIRDYDIE is set. Cleared by software setting the MSIRDYC bit.
        MSIRDYF: u1,
        /// HSI ready interrupt flag Set by hardware when the HSI clock becomes stable and HSIRDYIE is set in a response to setting the HSION (refer to Clock control register (RCC_CR)). When HSION is not set but the HSI oscillator is enabled by the peripheral through a clock request, this bit is not set and no interrupt is generated. Cleared by software setting the HSIRDYC bit.
        HSIRDYF: u1,
        /// HSE ready interrupt flag Set by hardware when the HSE clock becomes stable and HSERDYIE is set. Cleared by software setting the HSERDYC bit.
        HSERDYF: u1,
        /// PLL ready interrupt flag Set by hardware when the PLL locks and PLLRDYIE is set. Cleared by software setting the PLLRDYC bit.
        PLLRDYF: u1,
        reserved8: u2 = 0,
        /// HSE clock security system interrupt flag Set by hardware when a failure is detected in the HSE oscillator. Cleared by software setting the CSSC bit.
        CSSF: u1,
        /// LSE clock security system interrupt flag Set by hardware when a failure is detected in the LSE oscillator. Cleared by software by setting the LSECSSC bit.
        LSECSSF: u1,
        /// HSI48 ready interrupt flag Set by hardware when the HSI48 clock becomes stable and HSI48RDYIE is set in a response to setting the HSI48ON (refer to RCC clock recovery RC register (RCC_CRRCR)). Cleared by software setting the HSI48RDYC bit.
        HSI48RDYF: u1,
        padding: u21 = 0,
    }),
    /// Clock interrupt clear register.
    /// offset: 0x20
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear This bit is set by software to clear the LSIRDYF flag.
        LSIRDYC: u1,
        /// LSE ready interrupt clear This bit is set by software to clear the LSERDYF flag.
        LSERDYC: u1,
        /// MSI ready interrupt clear This bit is set by software to clear the MSIRDYF flag.
        MSIRDYC: u1,
        /// HSI ready interrupt clear This bit is set software to clear the HSIRDYF flag.
        HSIRDYC: u1,
        /// HSE ready interrupt clear This bit is set by software to clear the HSERDYF flag.
        HSERDYC: u1,
        /// PLL ready interrupt clear This bit is set by software to clear the PLLRDYF flag.
        PLLRDYC: u1,
        reserved8: u2 = 0,
        /// Clock security system interrupt clear This bit is set by software to clear the HSECSSF flag.
        CSSC: u1,
        /// LSE Clock security system interrupt clear This bit is set by software to clear the LSECSSF flag.
        LSECSSC: u1,
        /// HSI48 oscillator ready interrupt clear This bit is set by software to clear the HSI48RDYF flag.
        HSI48RDYC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// AHB peripheral reset register.
    /// offset: 0x28
    AHBRSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX reset Set and cleared by software.
        DMA1RST: u1,
        /// DMA2 and DMAMUX reset Set and cleared by software.
        DMA2RST: u1,
        reserved8: u6 = 0,
        /// Flash memory interface reset Set and cleared by software. This bit can only be set when the flash memory is in power down mode.
        FLASHRST: u1,
        reserved12: u3 = 0,
        /// CRC reset Set and cleared by software.
        CRCRST: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator reset Set and cleared by software.
        AESRST: u1,
        reserved18: u1 = 0,
        /// Random number generator reset Set and cleared by software.
        RNGRST: u1,
        reserved24: u5 = 0,
        /// Touch sensing controller reset Set and cleared by software.
        TSCRST: u1,
        padding: u7 = 0,
    }),
    /// I/O port reset register.
    /// offset: 0x2c
    GPIORSTR: mmio.Mmio(packed struct(u32) {
        /// I/O port A reset This bit is set and cleared by software.
        GPIOARST: u1,
        /// I/O port B reset This bit is set and cleared by software.
        GPIOBRST: u1,
        /// I/O port C reset This bit is set and cleared by software.
        GPIOCRST: u1,
        /// I/O port D reset This bit is set and cleared by software.
        GPIODRST: u1,
        /// I/O port E reset This bit is set and cleared by software.
        GPIOERST: u1,
        /// I/O port F reset This bit is set and cleared by software.
        GPIOFRST: u1,
        padding: u26 = 0,
    }),
    /// offset: 0x30
    reserved48: [8]u8,
    /// APB peripheral reset register 1.
    /// offset: 0x38
    APBRSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer reset Set and cleared by software.
        TIM2RST: u1,
        /// TIM3 timer reset Set and cleared by software.
        TIM3RST: u1,
        reserved4: u2 = 0,
        /// TIM6 timer reset Set and cleared by software.
        TIM6RST: u1,
        /// TIM7 timer reset Set and cleared by software.
        TIM7RST: u1,
        reserved7: u1 = 0,
        /// LPUART2 reset Set and cleared by software.
        LPUART2RST: u1,
        reserved9: u1 = 0,
        /// LCD reset<sup>(1)</sup> Set and cleared by software.
        LCDRST: u1,
        reserved12: u2 = 0,
        /// LPUART3 reset<sup>(1)</sup> Set and cleared by software.
        LPUART3RST: u1,
        /// USB reset<sup>(1)</sup> Set and cleared by software.
        USBRST: u1,
        /// SPI2 reset Set and cleared by software.
        SPI2RST: u1,
        /// SPI3 reset<sup>(1)</sup> Set and cleared by software.
        SPI3RST: u1,
        /// CRS reset<sup>(1)</sup> Set and cleared by software.
        CRSRST: u1,
        /// USART2 reset Set and cleared by software.
        USART2RST: u1,
        /// USART3 reset Set and cleared by software.
        USART3RST: u1,
        /// USART4 reset Set and cleared by software.
        USART4RST: u1,
        /// LPUART1 reset Set and cleared by software.
        LPUART1RST: u1,
        /// I2C1 reset Set and cleared by software.
        I2C1RST: u1,
        /// I2C2 reset Set and cleared by software.
        I2C2RST: u1,
        /// I2C3 reset Set and cleared by software.
        I2C3RST: u1,
        /// OPAMP reset Set and cleared by software.
        OPAMPRST: u1,
        /// I2C4 reset<sup>(1)</sup> Set and cleared by software.
        I2C4RST: u1,
        /// LPTIM3 reset Set and cleared by software.
        LPTIM3RST: u1,
        reserved28: u1 = 0,
        /// Power interface reset Set and cleared by software.
        PWRRST: u1,
        /// DAC1 interface reset Set and cleared by software.
        DAC1RST: u1,
        /// Low Power Timer 2 reset Set and cleared by software.
        LPTIM2RST: u1,
        /// Low Power Timer 1 reset Set and cleared by software.
        LPTIM1RST: u1,
    }),
    /// offset: 0x3c
    reserved60: [4]u8,
    /// APB peripheral reset register 2.
    /// offset: 0x40
    APBRSTR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF reset Set and cleared by software.
        SYSCFGRST: u1,
        reserved11: u10 = 0,
        /// TIM1 timer reset Set and cleared by software.
        TIM1RST: u1,
        /// SPI1 reset Set and cleared by software.
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset Set and cleared by software.
        USART1RST: u1,
        reserved16: u1 = 0,
        /// TIM15 timer reset Set and cleared by software.
        TIM15RST: u1,
        /// TIM16 timer reset Set and cleared by software.
        TIM16RST: u1,
        reserved20: u2 = 0,
        /// ADC reset Set and cleared by software.
        ADCRST: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x44
    reserved68: [4]u8,
    /// AHB peripheral clock enable register.
    /// offset: 0x48
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX clock enable Set and cleared by software. DMAMUX is enabled as long as at least one DMA peripheral is enabled.
        DMA1EN: u1,
        /// DMA2 and DMAMUX clock enable Set and cleared by software. DMAMUX is enabled as long as at least one DMA peripheral is enabled.
        DMA2EN: u1,
        reserved8: u6 = 0,
        /// Flash memory interface clock enable Set and cleared by software. This bit can only be cleared when the flash memory is in power down mode.
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable Set and cleared by software.
        CRCEN: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator Set and cleared by software.
        AESEN: u1,
        reserved18: u1 = 0,
        /// Random number generator clock enable Set and cleared by software.
        RNGEN: u1,
        reserved24: u5 = 0,
        /// Touch sensing controller clock enable Set and cleared by software.
        TSCEN: u1,
        padding: u7 = 0,
    }),
    /// I/O port clock enable register.
    /// offset: 0x4c
    GPIOENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable This bit is set and cleared by software.
        GPIOAEN: u1,
        /// I/O port B clock enable This bit is set and cleared by software.
        GPIOBEN: u1,
        /// I/O port C clock enable This bit is set and cleared by software.
        GPIOCEN: u1,
        /// I/O port D clock enable This bit is set and cleared by software.
        GPIODEN: u1,
        /// I/O port E clock enable<sup>(1)</sup> This bit is set and cleared by software.
        GPIOEEN: u1,
        /// I/O port F clock enable This bit is set and cleared by software.
        GPIOFEN: u1,
        padding: u26 = 0,
    }),
    /// Debug configuration register.
    /// offset: 0x50
    DBGCFGR: mmio.Mmio(packed struct(u32) {
        /// Debug support clock enable Set and cleared by software.
        DBGEN: u1,
        /// Debug support reset Set and cleared by software.
        DBGRST: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x54
    reserved84: [4]u8,
    /// APB peripheral clock enable register 1.
    /// offset: 0x58
    APBENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable Set and cleared by software.
        TIM2EN: u1,
        /// TIM3 timer clock enable Set and cleared by software.
        TIM3EN: u1,
        reserved4: u2 = 0,
        /// TIM6 timer clock enable Set and cleared by software.
        TIM6EN: u1,
        /// TIM7 timer clock enable Set and cleared by software.
        TIM7EN: u1,
        reserved7: u1 = 0,
        /// LPUART2 clock enable Set and cleared by software.
        LPUART2EN: u1,
        reserved9: u1 = 0,
        /// LCD clock enable<sup>(1)</sup> Set and cleared by software.
        LCDEN: u1,
        /// RTC APB clock enable Set and cleared by software.
        RTCAPBEN: u1,
        /// WWDG clock enable Set by software to enable the window watchdog clock. Cleared by hardware system reset This bit can also be set by hardware if the WWDG_SW option bit is 0.
        WWDGEN: u1,
        /// LPUART3 clock enable Set and cleared by software.
        LPUART3EN: u1,
        /// USB clock enable<sup>(1)</sup> Set and cleared by software.
        USBEN: u1,
        /// SPI2 clock enable Set and cleared by software.
        SPI2EN: u1,
        /// SPI3 clock enable<sup>(1)</sup> Set and cleared by software.
        SPI3EN: u1,
        /// CRS clock enable<sup>(1)</sup> Set and cleared by software.
        CRSEN: u1,
        /// USART2 clock enable Set and cleared by software.
        USART2EN: u1,
        /// USART3 clock enable Set and cleared by software.
        USART3EN: u1,
        /// USART4 clock enable Set and cleared by software.
        USART4EN: u1,
        /// LPUART1 clock enable Set and cleared by software.
        LPUART1EN: u1,
        /// I2C1 clock enable Set and cleared by software.
        I2C1EN: u1,
        /// I2C2 clock enable Set and cleared by software.
        I2C2EN: u1,
        /// I2C3 clock enable Set and cleared by software.
        I2C3EN: u1,
        /// OPAMP clock enable Set and cleared by software.
        OPAMPEN: u1,
        /// I2C4EN clock enable<sup>(1)</sup> Set and cleared by software.
        I2C4EN: u1,
        /// LPTIM3 clock enable Set and cleared by software.
        LPTIM3EN: u1,
        reserved28: u1 = 0,
        /// Power interface clock enable Set and cleared by software.
        PWREN: u1,
        /// DAC1 interface clock enable Set and cleared by software.
        DAC1EN: u1,
        /// LPTIM2 clock enable Set and cleared by software.
        LPTIM2EN: u1,
        /// LPTIM1 clock enable Set and cleared by software.
        LPTIM1EN: u1,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// APB peripheral clock enable register 2.
    /// offset: 0x60
    APBENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF clock enable Set and cleared by software.
        SYSCFGEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable Set and cleared by software.
        TIM1EN: u1,
        /// SPI1 clock enable Set and cleared by software.
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable Set and cleared by software.
        USART1EN: u1,
        reserved16: u1 = 0,
        /// TIM15 timer clock enable Set and cleared by software.
        TIM15EN: u1,
        /// TIM16 timer clock enable Set and cleared by software.
        TIM16EN: u1,
        reserved20: u2 = 0,
        /// ADC clock enable Set and cleared by software.
        ADCEN: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x64
    reserved100: [4]u8,
    /// AHB peripheral clock enable in Sleep/Stop mode register.
    /// offset: 0x68
    AHBSMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX clock enable during Sleep mode Set and cleared by software. Clock to DMAMUX during Sleep mode is enabled as long as the clock in Sleep mode is enabled to at least one DMA peripheral.
        DMA1SMEN: u1,
        /// DMA2 and DMAMUX clock enable during Sleep mode Set and cleared by software. Clock to DMAMUX during Sleep mode is enabled as long as the clock in Sleep mode is enabled to at least one DMA peripheral.
        DMA2SMEN: u1,
        reserved8: u6 = 0,
        /// Flash memory interface clock enable during Sleep mode Set and cleared by software. This bit can be activated only when the flash memory is in power down mode.
        FLASHSMEN: u1,
        /// SRAM clock enable during Sleep mode Set and cleared by software.
        SRAMSMEN: u1,
        reserved12: u2 = 0,
        /// CRC clock enable during Sleep mode Set and cleared by software.
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// AES hardware accelerator clock enable during Sleep mode Set and cleared by software.
        AESSMEN: u1,
        reserved18: u1 = 0,
        /// RNG clock enable during Sleep and Stop mode Set and cleared by software.
        RNGSMEN: u1,
        reserved24: u5 = 0,
        /// TSC clock enable during Sleep and Stop mode Set and cleared by software.
        TSCSMEN: u1,
        padding: u7 = 0,
    }),
    /// I/O port in Sleep mode clock enable register.
    /// offset: 0x6c
    GPIOSMENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable during Sleep mode Set and cleared by software.
        GPIOASMEN: u1,
        /// I/O port B clock enable during Sleep mode Set and cleared by software.
        GPIOBSMEN: u1,
        /// I/O port C clock enable during Sleep mode Set and cleared by software.
        GPIOCSMEN: u1,
        /// I/O port D clock enable during Sleep mode<sup>(1)</sup> Set and cleared by software.
        GPIODSMEN: u1,
        /// I/O port E clock enable during Sleep mode Set and cleared by software.
        GPIOESMEN: u1,
        /// I/O port F clock enable during Sleep mode Set and cleared by software.
        GPIOFSMEN: u1,
        padding: u26 = 0,
    }),
    /// offset: 0x70
    reserved112: [8]u8,
    /// APB peripheral clock enable in Sleep/Stop mode register 1.
    /// offset: 0x78
    APBSMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 timer clock enable during Sleep mode Set and cleared by software.
        TIM2SMEN: u1,
        /// TIM3 timer clock enable during Sleep mode Set and cleared by software.
        TIM3SMEN: u1,
        reserved4: u2 = 0,
        /// TIM6 timer clock enable during Sleep mode Set and cleared by software.
        TIM6SMEN: u1,
        /// TIM7 timer clock enable during Sleep mode Set and cleared by software.
        TIM7SMEN: u1,
        reserved7: u1 = 0,
        /// LPUART2 clock enable during Sleep and Stop modes Set and cleared by software.
        LPUART2SMEN: u1,
        reserved9: u1 = 0,
        /// LCD clock enable during Sleep mode<sup>(1)</sup> Set and cleared by software.
        LCDSMEN: u1,
        /// RTC APB clock enable during Sleep mode Set and cleared by software.
        RTCAPBSMEN: u1,
        /// WWDG clock enable during Sleep and Stop modes Set and cleared by software.
        WWDGSMEN: u1,
        /// LPUART3 clock enable during Sleep and Stop modes Set and cleared by software.
        LPUART3SMEN: u1,
        /// USB clock enable during Sleep mode<sup>(1)</sup> Set and cleared by software.
        USBSMEN: u1,
        /// SPI2 clock enable during Sleep mode Set and cleared by software.
        SPI2SMEN: u1,
        /// SPI3 clock enable during Sleep mode<sup>(1)</sup> Set and cleared by software.
        SPI3SMEN: u1,
        /// CRS clock enable during Sleep and Stop modes<sup>(1)</sup> Set and cleared by software.
        CRSSMEN: u1,
        /// USART2 clock enable during Sleep and Stop modes Set and cleared by software.
        USART2SMEN: u1,
        /// USART3 clock enable during Sleep mode Set and cleared by software.
        USART3SMEN: u1,
        /// USART4 clock enable during Sleep mode Set and cleared by software.
        USART4SMEN: u1,
        /// LPUART1 clock enable during Sleep and Stop modes Set and cleared by software.
        LPUART1SMEN: u1,
        /// I2C1 clock enable during Sleep and Stop modes Set and cleared by software.
        I2C1SMEN: u1,
        /// I2C2 clock enable during Sleep mode Set and cleared by software.
        I2C2SMEN: u1,
        /// I2C3 clock enable during Sleep mode Set and cleared by software.
        I2C3SMEN: u1,
        /// OPAMP clock enable during Sleep and Stop modes Set and cleared by software.
        OPAMPSMEN: u1,
        /// I2C4 clock enable during Sleep mode<sup>(1)</sup> Set and cleared by software.
        I2C4SMEN: u1,
        /// Low power timer 3 clock enable during Sleep mode Set and cleared by software.
        LPTIM3SMEN: u1,
        reserved28: u1 = 0,
        /// Power interface clock enable during Sleep mode Set and cleared by software.
        PWRSMEN: u1,
        /// DAC1 interface clock enable during Sleep and Stop modes Set and cleared by software.
        DAC1SMEN: u1,
        /// Low Power Timer 2 clock enable during Sleep and Stop modes Set and cleared by software.
        LPTIM2SMEN: u1,
        /// Low Power Timer 1 clock enable during Sleep and Stop modes Set and cleared by software.
        LPTIM1SMEN: u1,
    }),
    /// offset: 0x7c
    reserved124: [4]u8,
    /// APB peripheral clock enable in Sleep/Stop mode register 2.
    /// offset: 0x80
    APBSMENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG, COMP and VREFBUF clock enable during Sleep and Stop modes Set and cleared by software.
        SYSCFGSMEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable during Sleep mode Set and cleared by software.
        TIM1SMEN: u1,
        /// SPI1 clock enable during Sleep mode Set and cleared by software.
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during Sleep and Stop modes Set and cleared by software.
        USART1SMEN: u1,
        reserved16: u1 = 0,
        /// TIM15 timer clock enable during Sleep mode Set and cleared by software.
        TIM15SMEN: u1,
        /// TIM16 timer clock enable during Sleep mode Set and cleared by software.
        TIM16SMEN: u1,
        reserved20: u2 = 0,
        /// ADC clock enable during Sleep mode Set and cleared by software.
        ADCSMEN: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// Peripherals independent clock configuration register.
    /// offset: 0x88
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection This bitfield is controlled by software to select USART1 clock source as follows:.
        USART1SEL: USART1SEL,
        /// USART2 clock source selection This bitfield is controlled by software to select USART2 clock source as follows:.
        USART2SEL: USART2SEL,
        reserved6: u2 = 0,
        /// LPUART3 clock source selection<sup>(1)</sup> This bitfield is controlled by software to select LPUART3 clock source as follows:.
        LPUART3SEL: LPUART3SEL,
        /// LPUART2 clock source selection This bitfield is controlled by software to select LPUART2 clock source as follows:.
        LPUART2SEL: LPUART2SEL,
        /// LPUART1 clock source selection This bitfield is controlled by software to select LPUART1 clock source as follows:.
        LPUART1SEL: LPUART1SEL,
        /// I2C1 clock source selection This bitfield is controlled by software to select I2C1 clock source as follows:.
        I2C1SEL: I2C1SEL,
        reserved16: u2 = 0,
        /// I2C3 clock source selection This bitfield is controlled by software to select I2C3 clock source as follows:.
        I2C3SEL: I2C3SEL,
        /// LPTIM1 clock source selection This bitfield is controlled by software to select LPTIM1 clock source as follows:.
        LPTIM1SEL: LPTIM1SEL,
        /// LPTIM2 clock source selection This bitfield is controlled by software to select LPTIM2 clock source as follows:.
        LPTIM2SEL: LPTIM2SEL,
        /// LPTIM3 clock source selection This bitfield is controlled by software to select LPTIM3 clock source as follows:.
        LPTIM3SEL: LPTIM3SEL,
        /// TIM1 clock source selection This bit is set and cleared by software. It selects TIM1 clock source as follows:.
        TIM1SEL: TIM1SEL,
        /// TIM15 clock source selection This bit is set and cleared by software. It selects TIM15 clock source as follows:.
        TIM15SEL: TIM15SEL,
        /// 481MHz clock source selection This bitfield is controlled by software to select the 481MHz clock source used by the USB FS and the RNG:.
        CLK48SEL: CLK48SEL,
        /// ADCs clock source selection This bitfield is controlled by software to select the clock source for ADC:.
        ADCSEL: ADCSEL,
        padding: u2 = 0,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// RTC domain control register.
    /// offset: 0x90
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable Set and cleared by software to enable LSE oscillator:.
        LSEON: u1,
        /// LSE oscillator ready Set and cleared by hardware to indicate when the external 321kHz oscillator is ready (stable): After the LSEON bit is cleared, LSERDY goes low after 6 external low-speed oscillator clock cycles.
        LSERDY: u1,
        /// LSE oscillator bypass Set and cleared by software to bypass the LSE oscillator (in debug mode). This bit can be written only when the external 321kHz oscillator is disabled (LSEON=0 and LSERDY=0).
        LSEBYP: u1,
        /// LSE oscillator drive capability Set by software to select the LSE oscillator drive capability as follows: Applicable when the LSE oscillator is in Xtal mode, as opposed to bypass mode.
        LSEDRV: LSEDRV,
        /// CSS on LSE enable Set by software to enable the clock security system on LSE (321kHz) oscillator as follows: LSECSSON must be enabled after the LSE oscillator is enabled (LSEON bit enabled) and ready (LSERDY flag set by hardware), and after the RTCSEL bit is selected. Once enabled, this bit cannot be disabled, except after a LSE failure detection (LSECSSD =1). In that case the software must disable the LSECSSON bit.
        LSECSSON: u1,
        /// CSS on LSE failure Detection Set by hardware to indicate when a failure is detected by the clock security system on the external 321kHz oscillator (LSE):.
        LSECSSD: u1,
        /// LSE clock enable for system usage This bit must be set by software to enable the LSE clock for a system usage.
        LSESYSEN: u1,
        /// RTC clock source selection Set by software to select the clock source for the RTC as follows: Once the RTC clock source is selected, it cannot be changed anymore unless the RTC domain is reset, or unless a failure is detected on LSE (LSECSSD is set). The BDRST bit can be used to reset this bitfield to 00.
        RTCSEL: RTCSEL,
        reserved11: u1 = 0,
        /// LSE clock ready for system usage This flag is set by hardware to indicate that the LSE clock is ready for being used by the system (see LSESYSEN bit). This flag is set when LSE clock is ready (LSEON1=11 and LSERDY1=11) and two LSE clock cycles after that LSESYSEN is set. Cleared by hardware to indicate that the LSE clock is not ready to be used by the system.
        LSESYSRDY: u1,
        reserved15: u3 = 0,
        /// RTC clock enable Set and cleared by software. The bit enables clock to RTC and TAMP.
        RTCEN: u1,
        /// RTC domain software reset Set and cleared by software to reset the RTC domain:.
        BDRST: u1,
        reserved24: u7 = 0,
        /// Low-speed clock output (LSCO) enable Set and cleared by software.
        LSCOEN: u1,
        /// Low-speed clock output selection Set and cleared by software to select the low-speed output clock:.
        LSCOSEL: LSCOSEL,
        padding: u6 = 0,
    }),
    /// Control/status register.
    /// offset: 0x94
    CSR: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable Set and cleared by software to enable/disable the LSI oscillator:.
        LSION: u1,
        /// LSI oscillator ready Set and cleared by hardware to indicate when the LSI oscillator is ready (stable): After the LSION bit is cleared, LSIRDY goes low after 3 LSI oscillator clock cycles. This bit can be set even if LSION = 0 if the LSI is requested by the Clock Security System on LSE, by the Independent Watchdog or by the RTC.
        LSIRDY: u1,
        /// Internal low-speed oscillator pre-divided by 128 Set and reset by hardware to indicate when the low-speed internal RC oscillator has to be divided by 128. The software has to switch off the LSI before changing this bit.
        LSIPREDIV: LSIPREDIV,
        reserved8: u5 = 0,
        /// MSI range after Standby mode Set by software to chose the MSI frequency at startup. This range is used after exiting Standby mode until MSIRGSEL is set. After a pad or a power-on reset, the range is always 41MHz. MSISRANGE[3:0] can be written only when MSIRGSEL1=11. Others: Reserved Note: Changing the MSISRANGE[3:0] does not change the current MSI frequency.
        MSISRANGE: MSISRANGE,
        reserved23: u11 = 0,
        /// Remove reset flags Set by software to clear the reset flags.
        RMVF: u1,
        reserved25: u1 = 0,
        /// Option byte loader reset flag Set by hardware when a reset from the Option byte loading occurs. Cleared by setting the RMVF bit.
        OBLRSTF: u1,
        /// Pin reset flag Set by hardware when a reset from the NRST pin occurs. Cleared by setting the RMVF bit.
        PINRSTF: u1,
        /// BOR or POR/PDR flag Set by hardware when a BOR or POR/PDR occurs. Cleared by setting the RMVF bit.
        PWRRSTF: u1,
        /// Software reset flag Set by hardware when a software reset occurs. Cleared by setting the RMVF bit.
        SFTRSTF: u1,
        /// Independent window watchdog reset flag Set by hardware when an independent watchdog reset domain occurs. Cleared by setting the RMVF bit.
        IWDGRSTF: u1,
        /// Window watchdog reset flag Set by hardware when a window watchdog reset occurs. Cleared by setting the RMVF bit.
        WWDGRSTF: u1,
        /// Low-power reset flag Set by hardware when a reset occurs due to illegal Stop, Standby, or Shutdown mode entry. Cleared by setting the RMVF bit. This operates only if nRST_STOP, nRST_STDBY or nRST_SHDW option bits are cleared.
        LPWRRSTF: u1,
    }),
    /// RCC clock recovery RC register.
    /// offset: 0x98
    CRRCR: mmio.Mmio(packed struct(u32) {
        /// HSI48 RC oscillator enable<sup>(1)</sup>.
        HSI48ON: u1,
        /// HSI48 clock ready flag<sup>(1)</sup> The flag is set when the HSI48 clock is ready for use.
        HSI48RDY: u1,
        reserved7: u5 = 0,
        /// HSI48 clock calibration These bits are initialized at startup with the factory-programmed HSI48 calibration trim value.
        HSI48CAL: u9,
        padding: u16 = 0,
    }),
};
