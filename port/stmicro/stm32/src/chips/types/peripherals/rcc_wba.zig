const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCSEL = enum(u3) {
    /// hclk4 clock selected
    HCLK4 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// pll1pclk selected
    PLL1_P = 0x2,
    /// HSE clock selected
    HSE = 0x3,
    /// HSI clock selected
    HSI = 0x4,
    _,
};

pub const HDIV5 = enum(u1) {
    /// hclk5 = SYSCLK not divided
    Div1 = 0x0,
    /// hclk5 = SYSCLK divided by 2
    Div2 = 0x1,
};

pub const HPRE = enum(u3) {
    /// DCLK not divided
    Div1 = 0x0,
    /// hclk = SYSCLK divided by 2
    Div2 = 0x4,
    /// hclk = SYSCLK divided by 4
    Div4 = 0x5,
    /// hclk = SYSCLK divided by 8
    Div8 = 0x6,
    /// hclk = SYSCLK divided by 16
    Div16 = 0x7,
    _,
};

pub const HPRE5 = enum(u3) {
    /// DCLK not divided
    Div1 = 0x0,
    /// hclk5 = SYSCLK divided by 2
    Div2 = 0x4,
    /// hclk5 = SYSCLK divided by 3
    Div3 = 0x5,
    /// hclk5 = SYSCLK divided by 4
    Div4 = 0x6,
    /// hclk5 = SYSCLK divided by 6
    Div6 = 0x7,
    _,
};

pub const HSEPRE = enum(u1) {
    /// HSE not divided, SYSCLK = HSE
    Div1 = 0x0,
    /// HSE divided, SYSCLK = HSE/2
    Div2 = 0x1,
};

pub const I2C1SEL = enum(u2) {
    /// pclk1 selected
    PCLK1 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    _,
};

pub const I2C3SEL = enum(u2) {
    /// pclk7 selected
    PCLK7 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    _,
};

pub const LPTIM1SEL = enum(u2) {
    /// pclk7 selected.
    PCLK7 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const LPTIM2SEL = enum(u2) {
    /// pclk7 selected.
    PCLK1 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const LPUARTSEL = enum(u2) {
    /// pclk7 selected
    PCLK7 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
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

pub const LSETRIM = enum(u2) {
    /// current source resistance 5/4 x R
    R5_4 = 0x0,
    /// current source resistance R
    R = 0x1,
    /// current source resistance 3/4 x R
    R3_4 = 0x2,
    /// current source resistance 2/3 x R
    R2_3 = 0x3,
};

pub const LSIPREDIV = enum(u1) {
    /// LSI not divided
    Div1 = 0x0,
    /// LSI divided by 128
    Div128 = 0x1,
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
    DISABLED = 0x0,
    /// sysclkpre system clock after PLL1RCLKPRE division selected
    SYSCLKPRE = 0x1,
    /// HSI clock selected
    HSI = 0x3,
    /// HSE clock selected
    HSE = 0x4,
    /// pll1rclk clock selected
    PLL1_R = 0x5,
    /// LSI clock selected
    LSI = 0x6,
    /// LSE clock selected
    LSE = 0x7,
    /// pll1pclk clock selected
    PLL1_P = 0x8,
    /// pll1qclk clock selected
    PLL1_Q = 0x9,
    /// hclk5 clock selected
    HCLK5 = 0xa,
    _,
};

pub const PLLRCLKPRE = enum(u1) {
    /// pll1rclk not divided, sysclkpre = pll1rclk
    Div1 = 0x0,
    /// pll1rclk divided, sysclkpre = pll1rclk divided
    Divided = 0x1,
};

pub const PLLRCLKPRESTEP = enum(u1) {
    /// pll1rclk 2-step division
    STEP2 = 0x0,
    /// pll1rclk 3-step division
    STEP3 = 0x1,
};

pub const PLLRGE = enum(u2) {
    /// PLL2 input (ref2_ck) clock range frequency between 4 and 8 MHz
    FREQ_4TO8MHZ = 0x0,
    /// PLL2 input (ref2_ck) clock range frequency between 8 and 16 MHz
    FREQ_8TO16MHZ = 0x3,
    _,
};

pub const PLLSRC = enum(u2) {
    /// no clock sent to PLL1
    DISABLE = 0x0,
    /// HSI clock selected as PLL1 clock entry
    HSI = 0x2,
    /// HSE clock after HSEPRE divider selected as PLL1 clock entry
    HSE = 0x3,
    _,
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

pub const RADIOSTSEL = enum(u2) {
    /// no clock selected, 2.4 GHz RADIO sleep timer kernel clock disabled
    DISABLE = 0x0,
    /// LSE oscillator clock selected
    LSE = 0x1,
    /// HSE oscillator clock divided by 1000 selected
    HSE = 0x3,
    _,
};

pub const RNGSEL = enum(u2) {
    /// LSE selected
    LSE = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// pll1qclk divide by 2 selected
    PLL1_Q = 0x3,
};

pub const RTCSEL = enum(u2) {
    /// no clock selected, RTC and TAMP kernel clock disabled
    DISABLE = 0x0,
    /// LSE oscillator clock selected, and enabled
    LSE = 0x1,
    /// LSI oscillator clock selected, and enabled
    LSI = 0x2,
    /// HSE oscillator clock divided by 32 selected, and enabled
    HSE = 0x3,
};

pub const SPI1SEL = enum(u2) {
    /// pclk2 selected
    PCLK2 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    _,
};

pub const SPI3SEL = enum(u2) {
    /// pclk2 selected
    PCLK7 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    _,
};

pub const SW = enum(u2) {
    /// HSI selected as system clock
    HSI = 0x0,
    /// HSE or HSE/2, as defined by HSEPRE, selected as system clock
    HSE = 0x2,
    /// pll1rclk selected as system clock
    PLL1_R = 0x3,
    _,
};

pub const SYSTICKSEL = enum(u2) {
    /// hclk1 divided by 8 selected
    HCLK1_DIV_8 = 0x0,
    /// LSI selected
    LSI = 0x1,
    /// LSE selected
    LSE = 0x2,
    _,
};

pub const TIMICSEL = enum(u1) {
    /// HSI divider disabled
    HSI = 0x0,
    /// HSI/256 generated and can be selected by TIM16, TIM17 and LPTIM2 as internal input capture
    HSI_DIV_256 = 0x1,
};

pub const USART1SEL = enum(u2) {
    /// pclk2 selected
    PCLK2 = 0x0,
    /// SYSCLK selected
    SYS = 0x1,
    /// HSI selected
    HSI = 0x2,
    /// LSE selected
    LSE = 0x3,
};

pub const USARTSEL = enum(u2) {
    /// pclk1 selected
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
        reserved8: u8 = 0,
        /// HSI clock enable Set and cleared by software. Cleared by hardware when entering Stop and Standby modes. Set by hardware to force the HSI oscillator on when exiting Stop and Standby modes. Set by hardware to force the HSI oscillator on in case of clock security failure of the HSE crystal oscillator. This bit is set by hardware if the HSI is used directly or indirectly as system clock. Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSION: u1,
        /// HSI enable for some peripheral kernels Set and cleared by software to force HSI oscillator on even in Stop modes. Keeping the HSI oscillator on in Stop modes allows the communication speed not to be reduced by the HSI oscillator startup time. This bit has no effect on register bit HSION value. Cleared by hardware when entering Standby modes. Refer to Peripherals clock gating and autonomous mode for more details. Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSIKERON: u1,
        /// HSI clock ready flag Set by hardware to indicate that HSI oscillator is stable. This bit is set only when HSI is enabled by software by setting HSION. Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: Once the HSION bit is cleared, HSIRDY goes low after six HSI clock cycles.
        HSIRDY: u1,
        reserved16: u5 = 0,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE clock for the CPU when entering Stop and Standby modes and on a HSECSS failure. When the HSE is used as 2.4 GHz RADIO kernel clock, enabled by RADIOEN and RADIOSMEN and the 2.4 GHz RADIO is active, HSEON is not be cleared when entering low power mode. In this case only Stop 0 mode is entered as low power mode. This bit cannot be reset if the HSE oscillator is used directly or indirectly as the system clock. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable. This bit is set both when HSE is enabled by software by setting HSEON and when requested as kernel clock by the 2.4 GHz RADIO. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSERDY: u1,
        reserved19: u1 = 0,
        /// HSE clock security system enable Set by software to enable the HSE clock security system. When HSECSSON is set, the clock detector is enabled by hardware when the HSE oscillator is ready and disabled by hardware if a HSE clock failure is detected. This bit is set only and is cleared by reset. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSECSSON: u1,
        /// HSE clock for SYSCLK prescaler Set and cleared by software to control the division factor of the HSE clock for SYSCLK. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSEPRE: HSEPRE,
        reserved24: u3 = 0,
        /// PLL1 enable Set and cleared by software to enable the main PLL. Cleared by hardware when entering Stop or Standby modes and when PLL1 on HSE is selected as sysclk, on a HSECSS failure. This bit cannot be reset if the PLL1 clock is used as the system clock. Access to the bit can be secured by RCC PLL1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PLLON: u1,
        /// PLL1 clock ready flag Set by hardware to indicate that the PLL1 is locked. Access to the bit can be secured by RCC PLL1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PLLRDY: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x04
    reserved4: [12]u8,
    /// RCC internal clock sources calibration register 3
    /// offset: 0x10
    ICSCR3: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration These bits are initialized at startup with the factory-programmed HSI calibration value. When HSITRIM[4:0] is written, HSICAL[11:0] is updated with the sum of HSITRIM[4:0] and the initial factory trim value.
        HSICAL: u12,
        reserved16: u4 = 0,
        /// HSI clock trimming These bits provide an additional user-programmable trimming value that is added to the HSICAL[11:0] bits. It can be programmed to adjust to voltage and temperature variations that influence the frequency of the HSI.
        HSITRIM: u5,
        padding: u11 = 0,
    }),
    /// offset: 0x14
    reserved20: [8]u8,
    /// RCC clock configuration register 1
    /// offset: 0x1c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// system clock switch Set and cleared by software to select system clock source (SYSCLK). Cleared by hardware when entering Stop and Standby modes When selecting HSE directly or indirectly as system clock and HSE oscillator clock security fails, cleared by hardware.
        SW: SW,
        /// system clock switch status Set and cleared by hardware to indicate which clock source is used as system clock.
        SWS: SW,
        reserved24: u20 = 0,
        /// microcontroller clock output Set and cleared by software. others: reserved Note: This clock output may have some truncated cycles at startup or during MCO clock source switching.
        MCOSEL: MCOSEL,
        /// microcontroller clock output prescaler Set and cleared by software. It is highly recommended to change this prescaler before MCO output is enabled. others: not allowed
        MCOPRE: MCOPRE,
        padding: u1 = 0,
    }),
    /// RCC clock configuration register 2
    /// offset: 0x20
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// AHB1, AHB2 and AHB4 prescaler Set and cleared by software to control the division factor of the AHB1, AHB2 and AHB4 clock (hclk1). The software must limit the incremental frequency step by setting these bits correctly to ensure that the hclk1 maximum incremental frequency step does not exceed the maximum allowed incremental frequency step (for more details, refer to Table�99: SYSCLK and bus maximum frequency). After a write operation to these bits and before decreasing the voltage range, this register must be read to be sure that the new value is taken into account. 0xx: hclk1 = SYSCLK not divided
        HPRE: HPRE,
        reserved4: u1 = 0,
        /// APB1 prescaler Set and cleared by software to control the division factor of the APB1 clock (pclk1). 0xx: pclk1 = hclk1 not divided
        PPRE1: PPRE,
        reserved8: u1 = 0,
        /// APB2 prescaler Set and cleared by software to control the division factor of the APB2 clock (pclk2). 0xx: pclk2 = hclk1 not divided
        PPRE2: PPRE,
        padding: u21 = 0,
    }),
    /// RCC clock configuration register 3
    /// offset: 0x24
    CFGR3: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// APB7 prescaler Set and cleared by software to control the division factor of the APB7 clock (pclk7). 0xx: hclk1 not divided
        PPRE7: PPRE,
        padding: u25 = 0,
    }),
    /// RCC PLL1 configuration register
    /// offset: 0x28
    PLL1CFGR: mmio.Mmio(packed struct(u32) {
        /// PLL1 entry clock source Set and cleared by software to select PLL1 clock source. These bits can be written only when the PLL1 is disabled. Cleared by hardware when entering Stop or Standby modes. Note: In order to save power, when no PLL1 clock is used, the value of PLL1SRC must be 0.
        PLLSRC: PLLSRC,
        /// PLL1 input frequency range Set and reset by software to select the proper reference frequency range used for PLL1. This bit must be written before enabling the PLL1. 00-01-10: PLL1 input (ref1_ck) clock range frequency between 4 and 8 MHz
        PLLRGE: PLLRGE,
        /// PLL1 fractional latch enable Set and reset by software to latch the content of PLL1FRACN into the ΣΔ modulator. In order to latch the PLL1FRACN value into the ΣΔ modulator, PLL1FRACEN must be set to 0, then set to 1: the transition 0 to 1 transfers the content of PLL1FRACN into the modulator (see PLL1 initialization phase for details).
        PLLFRACEN: u1,
        reserved8: u3 = 0,
        /// Prescaler for PLL1 Set and cleared by software to configure the prescaler of the PLL1. The VCO1 input frequency is PLL1 input clock frequency/PLL1M. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ...
        PLLM: u3,
        reserved16: u5 = 0,
        /// PLL1 DIVP divider output enable Set and reset by software to enable the pll1pclk output of the PLL1. To save power, PLL1PEN and PLL1P bits must be set to 0 when the pll1pclk is not used. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
        PLLPEN: u1,
        /// PLL1 DIVQ divider output enable Set and reset by software to enable the pll1qclk output of the PLL1. To save power, PLL1QEN and PLL1Q bits must be set to 0 when the pll1qclk is not used. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
        PLLQEN: u1,
        /// PLL1 DIVR divider output enable Set and cleared by software to enable the pll1rclk output of the PLL1. To save power, PLL1REN and PLL1R bits must be set to 0 when the pll1rclk is not used. This bit can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0).
        PLLREN: u1,
        reserved20: u1 = 0,
        /// pll1rclk clock for SYSCLK prescaler division enable Set and cleared by software to control the division of the pll1rclk clock for SYSCLK.
        PLLRCLKPRE: PLLRCLKPRE,
        /// pll1rclk clock for SYSCLK prescaler division step selection Set and cleared by software to control the division step of the pll1rclk clock for SYSCLK.
        PLLRCLKPRESTEP: PLLRCLKPRESTEP,
        /// pll1rclkpre not divided ready. Set by hardware after PLL1RCLKPRE has been set from divided to not divide, to indicate that the pll1rclk not divided is available on sysclkpre.
        PLLRCLKPRERDY: u1,
        padding: u9 = 0,
    }),
    /// offset: 0x2c
    reserved44: [8]u8,
    /// RCC PLL1 dividers register
    /// offset: 0x34
    PLL1DIVR: mmio.Mmio(packed struct(u32) {
        /// Multiplication factor for PLL1 VCO Set and reset by software to control the multiplication factor of the VCO. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ... ... others: reserved VCO output frequency = F<sub>ref1_ck</sub> x multiplication factor for PLL1 VCO, when fractional value 0 has been loaded into PLL1FRACN, with: Multiplication factor for PLL1 VCO between 4 and 512 input frequency F<sub>ref1_ck</sub> between 4 and 16�MHz
        PLLN: u9,
        /// PLL1 DIVP division factor Set and reset by software to control the frequency of the pll1pclk clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). Note that odd division factors are not allowed. ...
        PLLP: u7,
        /// PLL1 DIVQ division factor Set and reset by software to control the frequency of the PLl1QCLK clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ...
        PLLQ: u7,
        reserved24: u1 = 0,
        /// PLL1 DIVR division factor Set and reset by software to control the frequency of the pll1rclk clock. These bits can be written only when the PLL1 is disabled (PLL1ON = 0 and PLL1RDY = 0). ...
        PLLR: u7,
        padding: u1 = 0,
    }),
    /// RCC PLL1 fractional divider register
    /// offset: 0x38
    PLL1FRACR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Fractional part of the multiplication factor for PLL1 VCO Set and reset by software to control the fractional part of the multiplication factor of the VCO. These bits can be written at any time, allowing dynamic fine-tuning of the PLL1 VCO. VCO output frequency = F<sub>ref1_ck</sub> x [multiplication factor for PLL1 VCO + (PLL1FRACN / 2<sup>13</sup>)], with: Multiplication factor for PLL1 VCO must be between 4 and 512. PLL1FRACN can be between 0 and 2<sup>13</sup>- 1. The input frequency F<sub>ref1_ck</sub> must be between 4 and 16 MHz. To change the used fractional value on-the-fly even if the PLL1 is enabled, the application must proceed as follows: Set the bit PLL1FRACEN to 0. Write the new fractional value into PLL1FRACN. Set the bit PLL1FRACEN to 1.
        PLLFRACN: u13,
        padding: u16 = 0,
    }),
    /// offset: 0x3c
    reserved60: [20]u8,
    /// RCC clock interrupt enable register
    /// offset: 0x50
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSI1 oscillator stabilization. Access to the bit can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1RDYIE: u1,
        /// LSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSE oscillator stabilization. Access to the bit can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSERDYIE: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSI oscillator stabilization. Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSE oscillator stabilization. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSERDYIE: u1,
        reserved6: u1 = 0,
        /// PLL1 ready interrupt enable Set and cleared by software to enable/disable interrupt caused by PLL1 lock. Access to the bit can be secured by RCC PLL1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PLLRDYIE: u1,
        padding: u25 = 0,
    }),
    /// RCC clock interrupt flag register
    /// offset: 0x54
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt flag Set by hardware when the LSI1 clock becomes stable and LSI1RDYIE is set. Cleared by software setting the LSI1RDYC bit. Access to the bit can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1RDYF: u1,
        /// LSE ready interrupt flag Set by hardware when the LSE clock becomes stable and LSERDYIE is set. Cleared by software setting the LSERDYC bit. Access to the bit can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSERDYF: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt flag Set by hardware when the HSI clock becomes stable and HSIRDYIE is set in a response to setting the HSION (see CR). When HSION is not set but the HSI oscillator is enabled by the peripheral through a clock request, this bit is not set and no interrupt is generated. Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Cleared by software setting the HSIRDYC bit.
        HSIRDYF: u1,
        /// HSE ready interrupt flag Set by hardware when the HSE clock becomes stable and HSERDYIE is set. Cleared by software setting the HSERDYC bit. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSERDYF: u1,
        reserved6: u1 = 0,
        /// PLL1 ready interrupt flag Set by hardware when the PLL1 locks and PLL1RDYIE is set. Cleared by software setting the PLL1RDYC bit. Access to the bit can be secured by RCC PLL1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PLLRDYF: u1,
        reserved10: u3 = 0,
        /// HSE clock security system interrupt flag Set by hardware when a clock security failure is detected in the HSE oscillator. Cleared by software setting the HSECSSC bit. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSECSSF: u1,
        padding: u21 = 0,
    }),
    /// RCC clock interrupt clear register
    /// offset: 0x58
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI1 ready interrupt clear Writing this bit to 1 clears the LSI1RDYF flag. Writing 0 has no effect. Access to the bit can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1RDYC: u1,
        /// LSE ready interrupt clear Writing this bit to 1 clears the LSERDYF flag. Writing 0 has no effect. Access to the bit can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSERDYC: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt clear Writing this bit to 1 clears the HSIRDYF flag. Writing 0 has no effect.\ Access to the bit can be secured by RCC HSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSIRDYC: u1,
        /// HSE ready interrupt clear Writing this bit to 1 clears the HSERDYF flag. Writing 0 has no effect. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSERDYC: u1,
        reserved6: u1 = 0,
        /// PLL1 ready interrupt clear Writing this bit to 1 clears the PLL1RDYF flag. Writing 0 has no effect. Access to the bit can be secured by RCC PLL1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PLLRDYC: u1,
        reserved10: u3 = 0,
        /// High speed external clock security system interrupt clear Writing this bit to 1 clears the HSECSSF flag. Writing 0 has no effect. Access to the bit can be secured by RCC HSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSECSSC: u1,
        padding: u21 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// RCC AHB1 peripheral reset register
    /// offset: 0x60
    AHB1RSTR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 reset Set and cleared by software. Access can be secured by GPDMA1 SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPDMA1RST: u1,
        reserved12: u11 = 0,
        /// CRC reset Set and cleared by software. Access can be secured by GTZC_TZSC CRCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        CRCRST: u1,
        reserved16: u3 = 0,
        /// TSC reset Set and cleared by software. Access can be secured by GTZC_TZSC TSCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TSCRST: u1,
        padding: u15 = 0,
    }),
    /// RCC AHB2 peripheral reset register
    /// offset: 0x64
    AHB2RSTR: mmio.Mmio(packed struct(u32) {
        /// IO port A reset Set and cleared by software. Access can be secured by GPIOA SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOARST: u1,
        /// IO port B reset Set and cleared by software. Access can be secured by GPIOB SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOBRST: u1,
        /// IO port C reset Set and cleared by software. Access can be secured by GPIOC SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOCRST: u1,
        reserved7: u4 = 0,
        /// IO port H reset Set and cleared by software. Access can be secured by GPIOH SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOHRST: u1,
        reserved16: u8 = 0,
        /// AES hardware accelerator reset Set and cleared by software. Access can be secured by GTZC_TZSC AESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        AESRST: u1,
        /// Hash reset Set and cleared by software. Access can be secured by GTZC_TZSC HASHSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HASHRST: u1,
        /// Random number generator reset Set and cleared by software. Access can be secured by GTZC_TZSC RNGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RNGRST: u1,
        /// SAES hardware accelerator reset Set and cleared by software. Access can be secured by GTZC_TZSC SAESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SAESRST: u1,
        /// HSEM hardware accelerator reset Set and cleared by software. Can only be accessed secure when one or more features in the HSEM is secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSEMRST: u1,
        /// PKA reset Set and cleared by software. Access can be secured by GTZC_TZSC PKASEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PKARST: u1,
        padding: u10 = 0,
    }),
    /// offset: 0x68
    reserved104: [4]u8,
    /// RCC AHB4 peripheral reset register
    /// offset: 0x6c
    AHB4RSTR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// ADC4 reset Set and cleared by software. Access can be secred by GTZC_TZSC ADC4SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        ADC4RST: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB5 peripheral reset register
    /// offset: 0x70
    AHB5RSTR: mmio.Mmio(packed struct(u32) {
        /// 2.4 GHz RADIO reset Set and cleared by software. Access can be secured by GTZC_TZSC RADIOSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RADIORST: u1,
        padding: u31 = 0,
    }),
    /// RCC APB1 peripheral reset register 1
    /// offset: 0x74
    APB1RSTR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 reset Set and cleared by software. Access can be secured by GTZC_TZSC TIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM2RST: u1,
        /// TIM3 reset Set and cleared by software. Access can be secured by GTZC_TZSC TIM3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM3RST: u1,
        reserved17: u15 = 0,
        /// USART2 reset Set and cleared by software. Access can be secured by GTZC_TZSC UART2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        USART2RST: u1,
        reserved21: u3 = 0,
        /// I2C1 reset Set and cleared by software. Access can be secured by GTZC_TZSC I2C1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        I2C1RST: u1,
        padding: u10 = 0,
    }),
    /// RCC APB1 peripheral reset register 2
    /// offset: 0x78
    APB1RSTR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 reset Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPTIM2RST: u1,
        padding: u26 = 0,
    }),
    /// RCC APB2 peripheral reset register
    /// offset: 0x7c
    APB2RSTR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 reset Set and cleared by software. Access can be secured by GTZC_TZSC TIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM1RST: u1,
        /// SPI1 reset Set and cleared by software. Access can be secured by GTZC_TZSC SPI1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset Set and cleared by software. Access can be secured by GTZC_TZSC USART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        USART1RST: u1,
        reserved17: u2 = 0,
        /// TIM16 reset Set and cleared by software. Access can be secured by GTZC_TZSC TIM16SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM16RST: u1,
        /// TIM17 reset Set and cleared by software. Access can be secured by GTZC_TZSC TIM17SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM17RST: u1,
        padding: u13 = 0,
    }),
    /// RCC APB7 peripheral reset register
    /// offset: 0x80
    APB7RSTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG reset Set and cleared by software. Access can be secured by SYSCFG SYSCFGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SYSCFGRST: u1,
        reserved5: u3 = 0,
        /// SPI3 reset Set and cleared by software. Access can be secured by GTZC_TZSC SPI3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SPI3RST: u1,
        /// LPUART1 reset Set and cleared by software. Access can be secured by GTZC_TZSC LPUART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPUART1RST: u1,
        /// I2C3 reset Set and cleared by software. Access can be secured by GTZC_TZSC I2C3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        I2C3RST: u1,
        reserved11: u3 = 0,
        /// LPTIM1 reset Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPTIM1RST: u1,
        padding: u20 = 0,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// RCC AHB1 peripheral clock enable register
    /// offset: 0x88
    AHB1ENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 bus clock enable Set and cleared by software. Access can be secured by GPDMA1 SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPDMA1EN: u1,
        reserved8: u7 = 0,
        /// FLASH bus clock enable Set and cleared by software. This bit can be disabled only when the Flash memory is in power down mode. Can only be accessed secured when the Flash security state is secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC CRCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        CRCEN: u1,
        reserved16: u3 = 0,
        /// Touch sensing controller bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC TSCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TSCEN: u1,
        /// RAMCFG bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC RAMCFGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RAMCFGEN: u1,
        reserved24: u6 = 0,
        /// GTZC1 bus clock enable Set and reset by software. Can only be accessed secure when device is secure (TZEN = 1). When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GTZC1EN: u1,
        reserved31: u6 = 0,
        /// SRAM1 bus clock enable Set and reset by software. Access can be secured by GTZC_MPCBB1 SECx, INVSECSTATE. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SRAM1EN: u1,
    }),
    /// RCC AHB2 peripheral clock enable register
    /// offset: 0x8c
    AHB2ENR: mmio.Mmio(packed struct(u32) {
        /// IO port A bus clock enable Set and cleared by software. Access can be secured by GPIOA SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOAEN: u1,
        /// IO port B bus clock enable Set and cleared by software. Access can be secured by GPIOB SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOBEN: u1,
        /// IO port C bus clock enable Set and cleared by software. Access can be secured by GPIOC SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOCEN: u1,
        reserved7: u4 = 0,
        /// IO port H bus clock enable Set and cleared by software. Access can be secured by GPIOH SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOHEN: u1,
        reserved16: u8 = 0,
        /// AES bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC AESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        AESEN: u1,
        /// HASH bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC HASHSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HASHEN: u1,
        /// RNG bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC RNGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RNGEN: u1,
        /// SAES bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC SAESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SAESEN: u1,
        /// HSEM bus clock enable Set and cleared by software. Can only be accessed secure when one or more features in the HSEM is secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HSEMEN: u1,
        /// PKA bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC PKASEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PKAEN: u1,
        reserved30: u8 = 0,
        /// SRAM2 bus clock enable Set and cleared by software. Access can be secured by GTZC_MPCBB2 SECx, INVSECSTATE. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SRAM2EN: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// RCC AHB4 peripheral clock enable register
    /// offset: 0x94
    AHB4ENR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// PWR bus clock enable Set and cleared by software. Can only be accessed secure when one or more features in the PWR is/are secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PWREN: u1,
        reserved5: u2 = 0,
        /// ADC4 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC ADC4SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        ADC4EN: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB5 peripheral clock enable register
    /// offset: 0x98
    AHB5ENR: mmio.Mmio(packed struct(u32) {
        /// 2.4 GHz RADIO bus clock enable Set and cleared by software. Access can be secured by GTZC_TZSC RADIOSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Before accessing the 2.4 GHz RADIO sleep timers registers the RADIOCLKRDY bit must be checked. Note: When RADIOSMEN and STRADIOCLKON are both cleared, RADIOCLKRDY bit must be re-checked when exiting low-power modes (Sleep and Stop).
        RADIOEN: u1,
        padding: u31 = 0,
    }),
    /// RCC APB1 peripheral clock enable register 1
    /// offset: 0x9c
    APB1ENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC TIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM2EN: u1,
        /// TIM3 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC TIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM3EN: u1,
        reserved11: u9 = 0,
        /// WWDG bus clock enable Set by software to enable the window watchdog bus clock. Reset by hardware system reset. This bit can also be set by hardware if the WWDG_SW option bit is reset. Access can be secured by GTZC_TZSC WWDGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        WWDGEN: u1,
        reserved17: u5 = 0,
        /// USART2 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC USART2SEC When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV..
        USART2EN: u1,
        reserved21: u3 = 0,
        /// I2C1 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC I2C1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        I2C1EN: u1,
        padding: u10 = 0,
    }),
    /// RCC APB1 peripheral clock enable register 2
    /// offset: 0xa0
    APB1ENR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPTIM2EN: u1,
        padding: u26 = 0,
    }),
    /// RCC APB2 peripheral clock enable register
    /// offset: 0xa4
    APB2ENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC TIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM1EN: u1,
        /// SPI1 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC SPI1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC USART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        USART1EN: u1,
        reserved17: u2 = 0,
        /// TIM16 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC TIM16SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM16EN: u1,
        /// TIM17 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC TIM17SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM17EN: u1,
        padding: u13 = 0,
    }),
    /// RCC APB7 peripheral clock enable register
    /// offset: 0xa8
    APB7ENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG bus clock enable Set and cleared by software. Access can be secured by SYSCFG SYSCFGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SYSCFGEN: u1,
        reserved5: u3 = 0,
        /// SPI3 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC SPI3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SPI3EN: u1,
        /// LPUART1 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC LPUART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPUART1EN: u1,
        /// I2C3 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC I2C3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        I2C3EN: u1,
        reserved11: u3 = 0,
        /// LPTIM1 bus and kernel clocks enable Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LPTIM1EN: u1,
        reserved21: u9 = 0,
        /// RTC and TAMP bus clock enable Set and cleared by software. Can only be accessed secure when one or more features in the RTC or TAMP is/are secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RTCAPBEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xac
    reserved172: [4]u8,
    /// RCC AHB1 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xb0
    AHB1SMENR: mmio.Mmio(packed struct(u32) {
        /// GPDMA1 bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GPDMA1 SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        GPDMA1SMEN: u1,
        reserved8: u7 = 0,
        /// FLASH bus clock enable during Sleep and Stop modes Set and cleared by software. Can only be accessed secured when the Flash security state is secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        FLASHSMEN: u1,
        reserved12: u3 = 0,
        /// CRC bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC CRCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        CRCSMEN: u1,
        reserved16: u3 = 0,
        /// TSC bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TSCSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV..
        TSCSMEN: u1,
        /// RAMCFG bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC RAMCFGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RAMCFGSMEN: u1,
        reserved24: u6 = 0,
        /// GTZC1 bus clock enable during Sleep and Stop modes Set and cleared by software. Can only be accessed secure when one device is secure (TZEN = 1). When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GTZC1SMEN: u1,
        reserved29: u4 = 0,
        /// ICACHE bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC ICACHE_REGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV..
        ICACHESMEN: u1,
        reserved31: u1 = 0,
        /// SRAM1 bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_MPCBB1 SECx, INVSECSTATE. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SRAM1SMEN: u1,
    }),
    /// RCC AHB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xb4
    AHB2SMENR: mmio.Mmio(packed struct(u32) {
        /// IO port A bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GPIOA SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOASMEN: u1,
        /// IO port B bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GPIOB SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOBSMEN: u1,
        /// IO port C bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GPIOC SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOCSMEN: u1,
        reserved7: u4 = 0,
        /// IO port H bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GPIOH SECx. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        GPIOHSMEN: u1,
        reserved16: u8 = 0,
        /// AES bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC AESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        AESSMEN: u1,
        /// HASH bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC HASHSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        HASHSMEN: u1,
        /// Random number generator (RNG) bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC RNGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RNGSMEN: u1,
        /// SAES accelerator bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC SAESSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SAESSMEN: u1,
        reserved21: u1 = 0,
        /// PKA bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC PKASEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PKASMEN: u1,
        reserved30: u8 = 0,
        /// SRAM2 bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_MPCBB2 SECx, INVSECSTATE. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SRAM2SMEN: u1,
        padding: u1 = 0,
    }),
    /// offset: 0xb8
    reserved184: [4]u8,
    /// RCC AHB4 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xbc
    AHB4SMENR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// PWR bus clock enable during Sleep and Stop modes Set and cleared by software. Can only be accessed secure when one or more features in the PWR is/are secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        PWRSMEN: u1,
        reserved5: u2 = 0,
        /// ADC4 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC ADC4SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        ADC4SMEN: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB5 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xc0
    AHB5SMENR: mmio.Mmio(packed struct(u32) {
        /// 2.4 GHz RADIO bus clock enable during Sleep and Stop modes when the 2.4 GHz RADIO is active. Set and cleared by software. Access can be secured by GTZC_TZSC RADIOSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RADIOSMEN: u1,
        padding: u31 = 0,
    }),
    /// RCC APB1 peripheral clocks enable in Sleep and Stop modes register 1
    /// offset: 0xc4
    APB1SMENR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM2SMEN: u1,
        /// TIM3 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TIM3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM3SMEN: u1,
        reserved11: u9 = 0,
        /// Window watchdog bus clock enable during Sleep and Stop modes Set and cleared by software. This bit is forced to 1 by hardware when the hardware WWDG option is activated. Access can be secured by GTZC_TZSC WWDGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        WWDGSMEN: u1,
        reserved17: u5 = 0,
        /// USART2 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC USART2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        USART2SMEN: u1,
        reserved21: u3 = 0,
        /// I2C1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC I2C1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C1SMEN: u1,
        padding: u10 = 0,
    }),
    /// RCC APB1 peripheral clocks enable in Sleep and Stop modes register 2
    /// offset: 0xc8
    APB1SMENR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM2SMEN: u1,
        padding: u26 = 0,
    }),
    /// RCC APB2 peripheral clocks enable in Sleep and Stop modes register
    /// offset: 0xcc
    APB2SMENR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM1SMEN: u1,
        /// SPI1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC SPI1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC USART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        USART1SMEN: u1,
        reserved17: u2 = 0,
        /// TIM16 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TIM16SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM16SMEN: u1,
        /// TIM17 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC TIM17SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        TIM17SMEN: u1,
        padding: u13 = 0,
    }),
    /// RCC APB7 peripheral clock enable in Sleep and Stop modes register
    /// offset: 0xd0
    APB7SMENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// SYSCFG bus clock enable during Sleep and Stop modes Set and cleared by software. Access can be secured by SYSCFG SYSCFGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        SYSCFGSMEN: u1,
        reserved5: u3 = 0,
        /// SPI3 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC SPI3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        SPI3SMEN: u1,
        /// LPUART1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC LPUART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPUART1SMEN: u1,
        /// I2C3 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC I2C3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        I2C3SMEN: u1,
        reserved11: u3 = 0,
        /// LPTIM1 bus and kernel clocks enable during Sleep and Stop modes Set and cleared by software. Access can be secured by GTZC_TZSC LPTIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        LPTIM1SMEN: u1,
        reserved21: u9 = 0,
        /// RTC and TAMP APB clock enable during Sleep and Stop modes Set and cleared by software. Can only be accessed secure when one or more features in the RTC or TAMP is/are secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: This bit must be set to allow the peripheral to wake up from Stop modes.
        RTCAPBSMEN: u1,
        padding: u10 = 0,
    }),
    /// offset: 0xd4
    reserved212: [12]u8,
    /// RCC peripherals independent clock configuration register 1
    /// offset: 0xe0
    CCIPR1: mmio.Mmio(packed struct(u32) {
        /// USART1 kernel clock source selection This bits are used to select the USART1 kernel clock source. Access can be secured by GTZC_TZSC USART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The USART1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        USART1SEL: USART1SEL,
        /// USART2 kernel clock source selection This bits are used to select the USART2 kernel clock source. Access can be secured by GTZC_TZSC USART2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The USART2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI or LSE.
        USART2SEL: USARTSEL,
        reserved10: u6 = 0,
        /// I2C1 kernel clock source selection These bits are used to select the I2C1 kernel clock source. Access can be secured by GTZC_TZSC I2C1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The I2C1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI.
        I2C1SEL: I2C1SEL,
        reserved18: u6 = 0,
        /// Low-power timer 2 kernel clock source selection These bits are used to select the LPTIM2 kernel clock source. Access can be secured by GTZC_TZSC LPTIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The LPTIM2 is functional in Stop 0 and Stop 1 mode only when the kernel clock is LSI, LSE or HSI if HSIKERON = 1.
        LPTIM2SEL: LPTIM2SEL,
        /// SPI1 kernel clock source selection These bits are used to select the SPI1 kernel clock source. Access can be secured by GTZC_TZSC SPI1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The SPI1 is functional in Stop 0 and Stop 1 mode only when the kernel clock is HSI.
        SPI1SEL: SPI1SEL,
        /// SysTick clock source selection These bits are used to select the SysTick clock source. Access can be secured by RCC SYSCLKSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: When LSE or LSI is selected, the AHB frequency must be at least four times higher than the LSI or LSE frequency. In addition, a jitter up to one hclk1 cycle is introduced, due to the LSE or LSI sampling with hclk1 in the SysTick circuitry.
        SYSTICKSEL: SYSTICKSEL,
        reserved31: u7 = 0,
        /// Clocks sources for TIM16,TIM17 and LPTIM2 internal input capture When the TIMICSEL bit is set, the TIM16, TIM17 and LPTIM2 internal input capture can be connected to HSI/256. When TIMICSEL is cleared, the HSI, clock sources cannot be selected as TIM16, TIM17 or LPTIM2 internal input capture. Access can be secured by GTZC_TZSC TIM16SEC, TIM17SEC, or LPTIM2SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The clock division must be disabled (TIMICSEL configured to 0) before selecting or changing a clock sources division.
        TIMICSEL: TIMICSEL,
    }),
    /// RCC peripherals independent clock configuration register 2
    /// offset: 0xe4
    CCIPR2: mmio.Mmio(packed struct(u32) {
        reserved12: u12 = 0,
        /// RNGSEL kernel clock source selection These bits allow to select the RNG kernel clock source. Access can be secured by GTZC_TZSC RNGSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RNGSEL: RNGSEL,
        padding: u18 = 0,
    }),
    /// RCC peripherals independent clock configuration register 3
    /// offset: 0xe8
    CCIPR3: mmio.Mmio(packed struct(u32) {
        /// LPUART1 kernel clock source selection These bits are used to select the LPUART1 kernel clock source. Access can be secured by GTZC_TZSC LPUART1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The LPUART1 is functional in Stop modes only when the kernel clock is HSI or LSE.
        LPUART1SEL: LPUARTSEL,
        reserved3: u1 = 0,
        /// SPI3 kernel clock source selection These bits are used to select the SPI3 kernel clock source. Access can be secured by GTZC_TZSC SPI3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The SPI3 is functional in Stop modes only when the kernel clock is HSI.
        SPI3SEL: SPI3SEL,
        reserved6: u1 = 0,
        /// I2C3 kernel clock source selection These bits are used to select the I2C3 kernel clock source. Access can be secured by GTZC_TZSC I2C3SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The I2C3 is functional in Stop modes only when the kernel clock is HSI
        I2C3SEL: I2C3SEL,
        reserved10: u2 = 0,
        /// LPTIM1 kernel clock source selection These bits are used to select the LPTIM1 kernel clock source. Access can be secured by GTZC_TZSC LPTIM1SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The LPTIM1 is functional in Stop modes only when the kernel clock is LSI, LSE, HSI with HSIKERON = 1.
        LPTIM1SEL: LPTIM1SEL,
        /// ADC4 kernel clock source selection These bits are used to select the ADC4 kernel clock source. Access can be secured by GTZC_TZSC ADC4SEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. others: reserved Note: The ADC4 is functional in Stop modes only when the kernel clock is HSI.
        ADCSEL: ADCSEL,
        padding: u17 = 0,
    }),
    /// offset: 0xec
    reserved236: [4]u8,
    /// RCC backup domain control register
    /// offset: 0xf0
    BDCR: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable Set and cleared by software. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSEON: u1,
        /// LSE oscillator ready Set and cleared by hardware to indicate when the external 32�kHz oscillator is stable. After the LSEON bit is cleared, LSERDY goes low after six external low-speed oscillator clock cycles. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSERDY: u1,
        /// LSE oscillator bypass Set and cleared by software to bypass oscillator in debug mode. This bit can be written only when the external 32�kHz oscillator is disabled (LSEON = 0 and LSERDY = 0). Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSEBYP: u1,
        /// LSE oscillator drive capability Set by software to modulate the drive capability of the LSE oscillator. LSEDRV must be programmed to a different value than 0 before enabling the LSE oscillator in ‘Xtal’ mode. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: The oscillator is in ‘Xtal mode’ when it is not in bypass mode.
        LSEDRV: LSEDRV,
        /// Low speed external clock security enable Set by software to enable the LSECSS. LSECSSON must be enabled after the LSE oscillator is enabled (LSEON bit enabled) and ready (LSERDY flag set by hardware) and after the RTCSEL bit is selected. Once enabled, this bit cannot be disabled, except after a LSE failure detection (LSECSSD�=�1). In that case, the software must disable the LSECSSON bit. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSECSSON: u1,
        /// Low speed external clock security, LSE failure Detection Set by hardware to indicate when a failure is detected by the LSECCS on the external 32�kHz oscillator. Reset when LSCSSON bit is cleared. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSECSSD: u1,
        /// LSE system clock (LSESYS) enable Set by software to enable the LSE system clock generated by RCC. The lsesys clock is used for peripherals (USART, LPUART, LPTIM, RNG, 2.4 GHz RADIO) and functions (LSCO, MCO, TIM triggers, LPTIM trigger) excluding the RTC, TAMP and LSECSS. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSESYSEN: u1,
        /// RTC and TAMP kernel clock source enable and selection Set by software to enable and select the clock source for the RTC. Can only be accessed secure when one or more features in the RTC or TAMP is/are secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RTCSEL: RTCSEL,
        reserved11: u1 = 0,
        /// LSE system clock (LSESYS) ready Set and cleared by hardware to indicate when the LSE system clock is stable.When the LSESYSEN bit is set, the LSESYSRDY flag is set after two LSE clock cycles. The LSE clock must be already enabled and stable (LSEON and LSERDY are set). When the LSEON bit is cleared, LSERDY goes low after six external low-speed oscillator clock cycles. Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSESYSRDY: u1,
        /// LSE clock glitch filter enable Set and cleared by hardware to enable the LSE glitch filter. This bit can be written only when the LSE is disabled (LSEON = 0 and LSERDY = 0). Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSEGFON: u1,
        /// LSE trimming These bits are initialized at startup and after OBL_LAUNCH with SBF cleared with the factory-programmed LSE calibration value. Set and cleared by software. These bits must be modified only once after a BOR reset or an OBL_LAUNCH and before enabling LSE with LSEON (when both LSEON = 0 and LSERDY�= 0). Access can be secured by RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV. Note: OBL_LAUNCH of this field occurs only when SBF is cleared and must then only be started by software when LSE oscillator is disabled, LSEON = 0 and LSERDY = 0.
        LSETRIM: LSETRIM,
        reserved16: u1 = 0,
        /// Backup domain software reset Set and cleared by software. Can only be accessed secure when one or more features in the RTC or TAMP is secure. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        BDRST: u1,
        reserved18: u1 = 0,
        /// 2.4 GHz RADIO sleep timer kernel clock enable and selection Set and cleared by software. Access can be secured by GTZC_TZSC RADIOSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        RADIOSTSEL: RADIOSTSEL,
        reserved24: u4 = 0,
        /// Low-speed clock output (LSCO) enable Set and cleared by software. Access can be secured by RCC LSISEC and/or RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSCOEN: u1,
        /// Low-speed clock output selection Set and cleared by software. Access can be secured by RCC LSISEC and/or RCC LSESEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSCOSEL: LSCOSEL,
        /// LSI1 oscillator enable Set and cleared by software. Access can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1ON: u1,
        /// LSI1 oscillator ready Set and cleared by hardware to indicate when the LSI1 oscillator is stable. After the LSI1ON bit is cleared, LSI1RDY goes low after three internal low-speed oscillator clock cycles. This bit is set when the LSI1 is used by IWDG or RTC, even if LSI1ON = 0. Access can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1RDY: u1,
        /// LSI1 Low-speed clock divider configuration Set and cleared by software to enable the LSI1 division. This bit can be written only when the LSI1 is disabled (LSI1ON = 0 and LSI1RDY = 0). The LSI1PREDIV cannot be changed if the LSI1 is used by the IWDG or by the RTC. Access can be secured by RCC LSISEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
        LSI1PREDIV: LSIPREDIV,
        padding: u3 = 0,
    }),
    /// RCC control/status register
    /// offset: 0xf4
    CSR: mmio.Mmio(packed struct(u32) {
        reserved23: u23 = 0,
        /// Remove reset flag Set by software to clear the reset flags. Access can be secured by RCC RMVFSEC. When secure, a non-secure read/write access is RAZ/WI. It does not generate an illegal access interrupt. This bit can be protected against unprivileged access when secure with RCC SPRIV or when non-secure with RCC NSPRIV.
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
        /// Low-power reset flag Set by hardware when a reset occurs due to illegal Stop and Standby modes entry. Cleared by writing to the RMVF bit.
        LPWRRSTF: u1,
    }),
    /// offset: 0xf8
    reserved248: [24]u8,
    /// RCC secure configuration register
    /// offset: 0x110
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// HSI clock configuration and status bits security Set and reset by software.
        HSISEC: u1,
        /// HSE clock configuration bits, status bits and HSECSS security Set and reset by software.
        HSESEC: u1,
        reserved3: u1 = 0,
        /// LSI clock configuration and status bits security Set and reset by software.
        LSISEC: u1,
        /// LSE clock configuration and status bits security Set and reset by software.
        LSESEC: u1,
        /// SYSCLK selection, clock output on MCO configuration security Set and reset by software.
        SYSCLKSEC: u1,
        /// AHBx/APBx prescaler configuration bits security Set and reset by software.
        PRESCSEC: u1,
        /// PLL1 clock configuration and status bits security Set and reset by software.
        PLLSEC: u1,
        reserved12: u4 = 0,
        /// Remove reset flag security Set and reset by software.
        RMVFSEC: u1,
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
    /// offset: 0x118
    reserved280: [232]u8,
    /// RCC clock configuration register 2
    /// offset: 0x200
    CFGR4: mmio.Mmio(packed struct(u32) {
        /// AHB5 prescaler when SWS select PLL1 Set and cleared by software to control the division factor of the AHB5 clock (hclk5). Must not be changed when SYSCLK source indicated by SWS is PLL1. When SYSCLK source indicated by SWS is not PLL1: HPRE5 is not taken into account. When SYSCLK source indicated by SWS is PLL1: HPRE5 is taken into account, from the moment the system clock switch occurs Depending on the device voltage range, the software must set these bits correctly to ensure that the AHB5 frequency does not exceed the maximum allowed frequency (for more details, refer to Table�99: SYSCLK and bus maximum frequency). After a write operation to these bits and before decreasing the voltage range, this register must be read to be sure that the new value is taken into account. 0xx: hclk5 = SYSCLK not divided
        HPRE5: HPRE5,
        reserved4: u1 = 0,
        /// AHB5 divider when SWS select HSI or HSE Set and reset by software. Set to 1 by hardware when entering Stop 1 mode. When SYSCLK source indicated by SWS is HSI or HSE: HDIV5 is taken into account When SYSCLK source indicated by SWS is PLL1: HDIV5 is taken not taken into account Depending on the device voltage range, the software must set this bit correctly to ensure that the AHB5 frequency does not exceed the maximum allowed frequency (for more details, refer to Table�99). After a write operation to this bit and before decreasing the voltage range, this register must be read to be sure that the new value is taken into account.
        HDIV5: HDIV5,
        padding: u27 = 0,
    }),
    /// offset: 0x204
    reserved516: [4]u8,
    /// RCC RADIO peripheral clock enable register
    /// offset: 0x208
    RADIOENR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// 2.4 GHz RADIO baseband kernel clock (aclk) enable Set and cleared by software. Note: The HSE oscillator needs to be enabled by either HSEON or STRADIOCLKON.
        BBCLKEN: u1,
        reserved16: u14 = 0,
        /// 2.4 GHz RADIO bus clock enable and HSE oscillator enable by 2.4 GHz RADIO sleep timer wakeup event Set by hardware on a 2.4 GHz RADIO sleep timer wakeup event. Cleared by software writing zero to this bit. Note: Before accessing the 2.4 GHz RADIO registers the RADIOCLKRDY bit must be checked.
        STRADIOCLKON: u1,
        /// 2.4 GHz RADIO bus clock ready. Set and cleared by hardware to indicate that the 2.4 GHz RADIO bus clock is ready and the 2.4 GHz RADIO registers can be accessed. Note: Once both RADIOEN and STRADIOCLKON are cleared, RADIOCLKRDY goes low after three hclk5 clock cycles.
        RADIOCLKRDY: u1,
        padding: u14 = 0,
    }),
    /// offset: 0x20c
    reserved524: [4]u8,
    /// RCC external clock sources calibration register 1
    /// offset: 0x210
    ECSCR1: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// HSE clock trimming These bits provide user-programmable capacitor trimming value. It can be programmed to adjust the HSE oscillator frequency.
        HSETRIM: u6,
        padding: u10 = 0,
    }),
};
