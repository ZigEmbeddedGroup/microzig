const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ADCSEL = enum(u2) {
    /// System clock
    SYS = 0x0,
    /// HSIKER
    HSIKER = 0x2,
    _,
};

pub const HPRE = enum(u4) {
    /// SYSCLK not divided
    Div1 = 0x0,
    /// SYSCLK is divided by 2
    Div2 = 0x8,
    /// SYSCLK is divided by 4
    Div4 = 0x9,
    /// SYSCLK is divided by 8
    Div8 = 0xa,
    /// SYSCLK is divided by 16
    Div16 = 0xb,
    /// SYSCLK is divided by 64
    Div64 = 0xc,
    /// SYSCLK is divided by 128
    Div128 = 0xd,
    /// SYSCLK is divided by 256
    Div256 = 0xe,
    /// SYSCLK is divided by 512
    Div512 = 0xf,
    _,
};

pub const HSIDIV = enum(u3) {
    /// HSI clock is not divided
    Div1 = 0x0,
    /// HSI clock is divided by 2
    Div2 = 0x1,
    /// HSI clock is divided by 4
    Div4 = 0x2,
    /// HSI clock is divided by 8
    Div8 = 0x3,
    /// HSI clock is divided by 16
    Div16 = 0x4,
    /// HSI clock is divided by 32
    Div32 = 0x5,
    /// HSI clock is divided by 64
    Div64 = 0x6,
    /// HSI clock is divided by 128
    Div128 = 0x7,
};

pub const HSIKERDIV = enum(u3) {
    /// 1
    Div1 = 0x0,
    /// 2
    Div2 = 0x1,
    /// 3 (reset value)
    Div3 = 0x2,
    /// 4
    Div4 = 0x3,
    /// 5
    Div5 = 0x4,
    /// 6
    Div6 = 0x5,
    /// 7
    Div7 = 0x6,
    /// 8
    Div8 = 0x7,
};

pub const I2C1SEL = enum(u2) {
    /// PCLK
    PCLK1 = 0x0,
    /// SYSCLK
    SYS = 0x1,
    /// HSIKER
    HSIKER = 0x2,
    _,
};

pub const I2S1SEL = enum(u2) {
    /// SYSCLK
    SYS = 0x0,
    /// HSIKER
    HSIKER = 0x2,
    /// I2S_CKIN
    I2S_CKIN = 0x3,
    _,
};

pub const LSCOSEL = enum(u1) {
    /// LSI
    LSI = 0x0,
    /// LSE
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

pub const MCOPRE = enum(u4) {
    /// MCO2 not divided
    Div1 = 0x0,
    /// MCO clock is divided by 2
    Div2 = 0x1,
    /// MCO clock is divided by 4
    Div4 = 0x2,
    /// MCO clock is divided by 8
    Div8 = 0x3,
    /// MCO clock is divided divided by 16
    Div16 = 0x4,
    /// MCO clock is divided divided by 32
    Div32 = 0x5,
    /// MCO clock is divided divided by 64
    Div64 = 0x6,
    /// MCO clock is divided divided by 128
    Div128 = 0x7,
    _,
};

pub const MCOSEL = enum(u4) {
    /// No clock, MCO output disabled
    DISABLE = 0x0,
    /// SYSCLK selected as MCO source
    SYS = 0x1,
    /// HSI selected as MCO source
    HSI = 0x3,
    /// HSE selected as MCO source
    HSE = 0x4,
    /// LSI selected as MCO source
    LSI = 0x6,
    /// LSE selected as MCO source
    LSE = 0x7,
    _,
};

pub const PPRE = enum(u3) {
    /// HCLK not divided
    Div1 = 0x0,
    /// HCLK is divided by 2
    Div2 = 0x4,
    /// HCLK is divided by 4
    Div4 = 0x5,
    /// HCLK is divided by 8
    Div8 = 0x6,
    /// HCLK is divided by 16
    Div16 = 0x7,
    _,
};

pub const RTCSEL = enum(u2) {
    /// No clock used as RTC clock
    DISABLE = 0x0,
    /// LSE used as RTC clock
    LSE = 0x1,
    /// LSI used as RTC clock
    LSI = 0x2,
    /// HSE divided by 32 used as RTC clock
    HSE_Div32 = 0x3,
};

pub const SW = enum(u3) {
    /// HSISYS (HSI divided by HSIDIV) selected as system clock
    HSISYS = 0x0,
    /// HSE selected as system clock
    HSE = 0x1,
    /// LSI selected as system clock
    LSI = 0x3,
    /// LSE selected as system clock
    LSE = 0x4,
    _,
};

pub const USART1SEL = enum(u2) {
    /// PCLK
    PCLK1 = 0x0,
    /// SYSCLK
    SYS = 0x1,
    /// HSIKER
    HSIKER = 0x2,
    /// LSE
    LSE = 0x3,
};

/// RCC address block description
pub const RCC = extern struct {
    /// RCC clock control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// HSI kernel clock division factor This bitfield controlled by software sets the division factor of the kernel clock divider to produce HSIKER clock:
        HSIKERDIV: HSIKERDIV,
        /// HSI clock enable Set and cleared by software and hardware, with hardware taking priority. Kept low by hardware as long as the device is in a low-power mode. Kept high by hardware as long as the system is clocked with a clock derived from HSI. This includes the exit from low-power modes and the system clock fall-back to HSI upon failing HSE oscillator clock selected as system clock source.
        HSION: u1,
        /// HSI always-enable for peripheral kernels. Set and cleared by software. Setting the bit activates the HSI oscillator in Run and Stop modes, regardless of the HSION bit state. The HSI clock can only feed USART1, USART2, and I2C1 peripherals configured with HSI as kernel clock. Note: Keeping the HSI active in Stop mode allows speeding up the serial interface communication as the HSI clock is ready immediately upon exiting Stop mode.
        HSIKERON: u1,
        /// HSI clock ready flag Set by hardware when the HSI oscillator is enabled through HSION and ready to use (stable). Note: Upon clearing HSION, HSIRDY goes low after six HSI clock cycles.
        HSIRDY: u1,
        /// HSI clock division factor This bitfield controlled by software sets the division factor of the HSI clock divider to produce HSISYS clock:
        HSIDIV: HSIDIV,
        reserved16: u2 = 0,
        /// HSE clock enable Set and cleared by software. Cleared by hardware to stop the HSE oscillator when entering Stop, or Standby, or Shutdown mode. This bit cannot be cleared if the HSE oscillator is used directly or indirectly as the system clock.
        HSEON: u1,
        /// HSE clock ready flag Set by hardware to indicate that the HSE oscillator is stable and ready for use. Note: Upon clearing HSEON, HSERDY goes low after six HSE clock cycles.
        HSERDY: u1,
        /// HSE crystal oscillator bypass Set and cleared by software. When the bit is set, the internal HSE oscillator is bypassed for use of an external clock. The external clock must then be enabled with the HSEON bit set. Write access to the bit is only effective when the HSE oscillator is disabled.
        HSEBYP: u1,
        /// Clock security system enable Set by software to enable the clock security system. When the bit is set, the clock detector is enabled by hardware when the HSE oscillator is ready, and disabled by hardware if a HSE clock failure is detected. The bit is cleared by hardware upon reset.
        CSSON: u1,
        padding: u12 = 0,
    }),
    /// RCC internal clock source calibration register
    /// offset: 0x04
    ICSCR: mmio.Mmio(packed struct(u32) {
        /// HSI clock calibration This bitfield directly acts on the HSI clock frequency. Its value is a sum of an internal factory-programmed number and the value of the HSITRIM[6:0] bitfield. In the factory, the internal number is set to calibrate the HSI clock frequency to 48 MHz (with HSITRIM[6:0] left at its reset value). Refer to the device datasheet for HSI calibration accuracy and for the frequency trimming granularity. Note: The trimming effect presents discontinuities at HSICAL[7:0] multiples of 64.
        HSICAL: u8,
        /// HSI clock trimming The value of this bitfield contributes to the HSICAL[7:0] bitfield value. It allows HSI clock frequency user trimming. The HSI frequency accuracy as stated in the device datasheet applies when this bitfield is left at its reset value.
        HSITRIM: u7,
        padding: u17 = 0,
    }),
    /// RCC clock configuration register
    /// offset: 0x08
    CFGR: mmio.Mmio(packed struct(u32) {
        /// System clock switch This bitfield is controlled by software and hardware. The bitfield selects the clock for SYSCLK as follows: Others: Reserved The setting is forced by hardware to 000 (HSISYS selected) when the MCU exits Stop, or Standby, or Shutdown mode, or when the setting is 001 (HSE selected) and HSE oscillator failure is detected.
        SW: SW,
        /// System clock switch status This bitfield is controlled by hardware to indicate the clock source used as system clock: Others: Reserved
        SWS: SW,
        reserved8: u2 = 0,
        /// AHB prescaler This bitfield is controlled by software. To produce HCLK clock, it sets the division factor of SYSCLK clock as follows: 0xxx: 1
        HPRE: HPRE,
        /// APB prescaler This bitfield is controlled by software. To produce PCLK clock, it sets the division factor of HCLK clock as follows: 0xx: 1
        PPRE: PPRE,
        reserved16: u1 = 0,
        /// Microcontroller clock output 2 clock selector This bitfield is controlled by software. It sets the clock selector for MCO2 output as follows: This bitfield is controlled by software. It sets the clock selector for MCO output as follows: Note: This clock output may have some truncated cycles at startup or during MCO2 clock source switching.
        MCO2SEL: MCOSEL,
        /// Microcontroller clock output 2 prescaler This bitfield is controlled by software. It sets the division factor of the clock sent to the MCO2 output as follows: ... It is highly recommended to set this field before the MCO2 output is enabled.
        MCO2PRE: MCOPRE,
        /// Microcontroller clock output clock selector This bitfield is controlled by software. It sets the clock selector for MCO output as follows: Note: This clock output may have some truncated cycles at startup or during MCO clock source switching. Any other value means no clock on MCO.
        MCO1SEL: MCOSEL,
        /// Microcontroller clock output prescaler This bitfield is controlled by software. It sets the division factor of the clock sent to the MCO output as follows: ... It is highly recommended to set this field before the MCO output is enabled.
        MCO1PRE: MCOPRE,
    }),
    /// offset: 0x0c
    reserved12: [12]u8,
    /// RCC clock interrupt enable register
    /// offset: 0x18
    CIER: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSI oscillator stabilization:
        LSIRDYIE: u1,
        /// LSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the LSE oscillator stabilization:
        LSERDYIE: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSI oscillator stabilization:
        HSIRDYIE: u1,
        /// HSE ready interrupt enable Set and cleared by software to enable/disable interrupt caused by the HSE oscillator stabilization:
        HSERDYIE: u1,
        padding: u27 = 0,
    }),
    /// RCC clock interrupt flag register
    /// offset: 0x1c
    CIFR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt flag This flag indicates a pending interrupt upon LSE clock getting ready. Set by hardware when the LSI clock becomes stable and LSIRDYDIE is set. Cleared by software setting the LSIRDYC bit.
        LSIRDYF: u1,
        /// LSE ready interrupt flag This flag indicates a pending interrupt upon LSE clock getting ready. Set by hardware when the LSE clock becomes stable and LSERDYDIE is set. Cleared by software setting the LSERDYC bit.
        LSERDYF: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt flag This flag indicates a pending interrupt upon HSI clock getting ready. Set by hardware when the HSI clock becomes stable and HSIRDYIE is set in response to setting the HSION (refer to ). When HSION is not set but the HSI oscillator is enabled by the peripheral through a clock request, this bit is not set and no interrupt is generated. Cleared by software setting the HSIRDYC bit.
        HSIRDYF: u1,
        /// HSE ready interrupt flag This flag indicates a pending interrupt upon HSE clock getting ready. Set by hardware when the HSE clock becomes stable and HSERDYIE is set. Cleared by software setting the HSERDYC bit.
        HSERDYF: u1,
        reserved8: u3 = 0,
        /// HSE clock security system interrupt flag This flag indicates a pending interrupt upon HSE clock failure. Set by hardware when a failure is detected in the HSE oscillator. Cleared by software setting the CSSC bit.
        CSSF: u1,
        /// LSE clock security system interrupt flag This flag indicates a pending interrupt upon LSE clock failure. Set by hardware when a failure is detected in the LSE oscillator. Cleared by software by setting the LSECSSC bit.
        LSECSSF: u1,
        padding: u22 = 0,
    }),
    /// RCC clock interrupt clear register
    /// offset: 0x20
    CICR: mmio.Mmio(packed struct(u32) {
        /// LSI ready interrupt clear This bit is set by software to clear the LSIRDYF flag.
        LSIRDYC: u1,
        /// LSE ready interrupt clear This bit is set by software to clear the LSERDYF flag.
        LSERDYC: u1,
        reserved3: u1 = 0,
        /// HSI ready interrupt clear This bit is set software to clear the HSIRDYF flag.
        HSIRDYC: u1,
        /// HSE ready interrupt clear This bit is set by software to clear the HSERDYF flag.
        HSERDYC: u1,
        reserved8: u3 = 0,
        /// Clock security system interrupt clear This bit is set by software to clear the HSECSSF flag.
        CSSC: u1,
        /// LSE Clock security system interrupt clear This bit is set by software to clear the LSECSSF flag.
        LSECSSC: u1,
        padding: u22 = 0,
    }),
    /// RCC I/O port reset register
    /// offset: 0x24
    GPIORSTR: mmio.Mmio(packed struct(u32) {
        /// I/O port A reset This bit is set and cleared by software.
        GPIOARST: u1,
        /// I/O port B reset This bit is set and cleared by software.
        GPIOBRST: u1,
        /// I/O port C reset This bit is set and cleared by software.
        GPIOCRST: u1,
        /// I/O port D reset This bit is set and cleared by software.
        GPIODRST: u1,
        reserved5: u1 = 0,
        /// I/O port F reset This bit is set and cleared by software.
        GPIOFRST: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB peripheral reset register
    /// offset: 0x28
    AHBRSTR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX reset Set and cleared by software.
        DMA1RST: u1,
        reserved8: u7 = 0,
        /// Flash memory interface reset Set and cleared by software. This bit can only be set when the Flash memory is in power down mode.
        FLASHRST: u1,
        reserved12: u3 = 0,
        /// CRC reset Set and cleared by software.
        CRCRST: u1,
        padding: u19 = 0,
    }),
    /// RCC APB peripheral reset register 1
    /// offset: 0x2c
    APBRSTR1: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TIM3 timer reset Set and cleared by software.
        TIM3RST: u1,
        reserved17: u15 = 0,
        /// USART2 reset Set and cleared by software.
        USART2RST: u1,
        reserved21: u3 = 0,
        /// I2C1 reset Set and cleared by software.
        I2C1RST: u1,
        reserved27: u5 = 0,
        /// Debug support reset Set and cleared by software.
        DBGRST: u1,
        /// Power interface reset Set and cleared by software.
        PWRRST: u1,
        padding: u3 = 0,
    }),
    /// RCC APB peripheral reset register 2
    /// offset: 0x30
    APBRSTR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG reset Set and cleared by software.
        SYSCFGRST: u1,
        reserved11: u10 = 0,
        /// TIM1 timer reset Set and cleared by software.
        TIM1RST: u1,
        /// SPI1 reset Set and cleared by software.
        SPI1RST: u1,
        reserved14: u1 = 0,
        /// USART1 reset Set and cleared by software.
        USART1RST: u1,
        /// TIM14 timer reset Set and cleared by software.
        TIM14RST: u1,
        reserved17: u1 = 0,
        /// TIM16 timer reset Set and cleared by software.
        TIM16RST: u1,
        /// TIM16 timer reset Set and cleared by software.
        TIM17RST: u1,
        reserved20: u1 = 0,
        /// ADC reset Set and cleared by software.
        ADCRST: u1,
        padding: u11 = 0,
    }),
    /// RCC I/O port clock enable register
    /// offset: 0x34
    GPIOENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable This bit is set and cleared by software.
        GPIOAEN: u1,
        /// I/O port B clock enable This bit is set and cleared by software.
        GPIOBEN: u1,
        /// I/O port C clock enable This bit is set and cleared by software.
        GPIOCEN: u1,
        /// I/O port D clock enable This bit is set and cleared by software.
        GPIODEN: u1,
        reserved5: u1 = 0,
        /// I/O port F clock enable This bit is set and cleared by software.
        GPIOFEN: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB peripheral clock enable register
    /// offset: 0x38
    AHBENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX clock enable Set and cleared by software. DMAMUX is enabled as long as at least one DMA peripheral is enabled.
        DMA1EN: u1,
        reserved8: u7 = 0,
        /// Flash memory interface clock enable Set and cleared by software. This bit can only be cleared when the Flash memory is in power down mode.
        FLASHEN: u1,
        reserved12: u3 = 0,
        /// CRC clock enable Set and cleared by software.
        CRCEN: u1,
        padding: u19 = 0,
    }),
    /// RCC APB peripheral clock enable register 1
    /// offset: 0x3c
    APBENR1: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TIM3 timer clock enable Set and cleared by software.
        TIM3EN: u1,
        reserved10: u8 = 0,
        /// RTC APB clock enable Set and cleared by software.
        RTCAPBEN: u1,
        /// WWDG clock enable Set by software to enable the window watchdog clock. Cleared by hardware system reset This bit can also be set by hardware if the WWDG_SW option bit is 0.
        WWDGEN: u1,
        reserved17: u5 = 0,
        /// USART2 clock enable Set and cleared by software.
        USART2EN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable Set and cleared by software.
        I2C1EN: u1,
        reserved27: u5 = 0,
        /// Debug support clock enable Set and cleared by software.
        DBGEN: u1,
        /// Power interface clock enable Set and cleared by software.
        PWREN: u1,
        padding: u3 = 0,
    }),
    /// RCC APB peripheral clock enable register 2
    /// offset: 0x40
    APBENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clock enable Set and cleared by software.
        SYSCFGEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable Set and cleared by software.
        TIM1EN: u1,
        /// SPI1 clock enable Set and cleared by software.
        SPI1EN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable Set and cleared by software.
        USART1EN: u1,
        /// TIM14 timer clock enable Set and cleared by software.
        TIM14EN: u1,
        reserved17: u1 = 0,
        /// TIM16 timer clock enable Set and cleared by software.
        TIM16EN: u1,
        /// TIM16 timer clock enable Set and cleared by software.
        TIM17EN: u1,
        reserved20: u1 = 0,
        /// ADC clock enable Set and cleared by software.
        ADCEN: u1,
        padding: u11 = 0,
    }),
    /// RCC I/O port in Sleep mode clock enable register
    /// offset: 0x44
    GPIOSMENR: mmio.Mmio(packed struct(u32) {
        /// I/O port A clock enable during Sleep mode Set and cleared by software.
        GPIOASMEN: u1,
        /// I/O port B clock enable during Sleep mode Set and cleared by software.
        GPIOBSMEN: u1,
        /// I/O port C clock enable during Sleep mode Set and cleared by software.
        GPIOCSMEN: u1,
        /// I/O port D clock enable during Sleep mode Set and cleared by software.
        GPIODSMEN: u1,
        reserved5: u1 = 0,
        /// I/O port F clock enable during Sleep mode Set and cleared by software.
        GPIOFSMEN: u1,
        padding: u26 = 0,
    }),
    /// RCC AHB peripheral clock enable in Sleep/Stop mode register
    /// offset: 0x48
    AHBSMENR: mmio.Mmio(packed struct(u32) {
        /// DMA1 and DMAMUX clock enable during Sleep mode Set and cleared by software. Clock to DMAMUX during Sleep mode is enabled as long as the clock in Sleep mode is enabled to at least one DMA peripheral.
        DMA1SMEN: u1,
        reserved8: u7 = 0,
        /// Flash memory interface clock enable during Sleep mode Set and cleared by software. This bit can be activated only when the Flash memory is in power down mode.
        FLASHSMEN: u1,
        /// SRAM clock enable during Sleep mode Set and cleared by software.
        SRAMSMEN: u1,
        reserved12: u2 = 0,
        /// CRC clock enable during Sleep mode Set and cleared by software.
        CRCSMEN: u1,
        padding: u19 = 0,
    }),
    /// RCC APB peripheral clock enable in Sleep/Stop mode register 1
    /// offset: 0x4c
    APBSMENR1: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TIM3 timer clock enable during Sleep mode Set and cleared by software.
        TIM3SMEN: u1,
        reserved10: u8 = 0,
        /// RTC APB clock enable during Sleep mode Set and cleared by software.
        RTCAPBSMEN: u1,
        /// WWDG clock enable during Sleep and Stop modes Set and cleared by software.
        WWDGSMEN: u1,
        reserved17: u5 = 0,
        /// USART2 clock enable during Sleep and Stop modes Set and cleared by software.
        USART2SMEN: u1,
        reserved21: u3 = 0,
        /// I2C1 clock enable during Sleep and Stop modes Set and cleared by software.
        I2C1SMEN: u1,
        reserved27: u5 = 0,
        /// Debug support clock enable during Sleep mode Set and cleared by software.
        DBGSMEN: u1,
        /// Power interface clock enable during Sleep mode Set and cleared by software.
        PWRSMEN: u1,
        padding: u3 = 0,
    }),
    /// RCC APB peripheral clock enable in Sleep/Stop mode register 2
    /// offset: 0x50
    APBSMENR2: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clock enable during Sleep and Stop modes Set and cleared by software.
        SYSCFGSMEN: u1,
        reserved11: u10 = 0,
        /// TIM1 timer clock enable during Sleep mode Set and cleared by software.
        TIM1SMEN: u1,
        /// SPI1 clock enable during Sleep mode Set and cleared by software.
        SPI1SMEN: u1,
        reserved14: u1 = 0,
        /// USART1 clock enable during Sleep and Stop modes Set and cleared by software.
        USART1SMEN: u1,
        /// TIM14 timer clock enable during Sleep mode Set and cleared by software.
        TIM14SMEN: u1,
        reserved17: u1 = 0,
        /// TIM16 timer clock enable during Sleep mode Set and cleared by software.
        TIM16SMEN: u1,
        /// TIM16 timer clock enable during Sleep mode Set and cleared by software.
        TIM17SMEN: u1,
        reserved20: u1 = 0,
        /// ADC clock enable during Sleep mode Set and cleared by software.
        ADCSMEN: u1,
        padding: u11 = 0,
    }),
    /// RCC peripherals independent clock configuration register
    /// offset: 0x54
    CCIPR: mmio.Mmio(packed struct(u32) {
        /// USART1 clock source selection This bitfield is controlled by software to select USART1 clock source as follows:
        USART1SEL: USART1SEL,
        reserved12: u10 = 0,
        /// I2C1 clock source selection This bitfield is controlled by software to select I2C1 clock source as follows:
        I2C1SEL: I2C1SEL,
        /// I2S1 clock source selection This bitfield is controlled by software to select I2S1 clock source as follows:
        I2S1SEL: I2S1SEL,
        reserved30: u14 = 0,
        /// ADCs clock source selection This bitfield is controlled by software to select the clock source for ADC:
        ADCSEL: ADCSEL,
    }),
    /// offset: 0x58
    reserved88: [4]u8,
    /// RCC control/status register 1
    /// offset: 0x5c
    CSR1: mmio.Mmio(packed struct(u32) {
        /// LSE oscillator enable Set and cleared by software to enable LSE oscillator:
        LSEON: u1,
        /// LSE oscillator ready Set and cleared by hardware to indicate when the external 32 kHz oscillator is ready (stable): After the LSEON bit is cleared, LSERDY goes low after 6 external low-speed oscillator clock cycles.
        LSERDY: u1,
        /// LSE oscillator bypass Set and cleared by software to bypass the LSE oscillator (in debug mode). This bit can be written only when the external 32 kHz oscillator is disabled (LSEON=0 and LSERDY=0).
        LSEBYP: u1,
        /// LSE oscillator drive capability Set by software to select the LSE oscillator drive capability as follows: Applicable when the LSE oscillator is in Xtal mode, as opposed to bypass mode.
        LSEDRV: LSEDRV,
        /// CSS on LSE enable Set by software to enable the clock security system on LSE (32 kHz) oscillator as follows: LSECSSON must be enabled after the LSE oscillator is enabled (LSEON bit enabled) and ready (LSERDY flag set by hardware), and after the RTCSEL bit is selected. Once enabled, this bit cannot be disabled, except after a LSE failure detection (LSECSSD =1). In that case the software must disable the LSECSSON bit.
        LSECSSON: u1,
        /// CSS on LSE failure Detection Set by hardware to indicate when a failure is detected by the clock security system on the external 32 kHz oscillator (LSE):
        LSECSSD: u1,
        reserved8: u1 = 0,
        /// RTC clock source selection Set by software to select the clock source for the RTC as follows: Once the RTC clock source is selected, it cannot be changed anymore unless the RTC domain is reset, or unless a failure is detected on LSE (LSECSSD is set). The RTCRST bit can be used to reset this bitfield to 00.
        RTCSEL: RTCSEL,
        reserved15: u5 = 0,
        /// RTC clock enable Set and cleared by software. The bit enables clock to RTC and TAMP.
        RTCEN: u1,
        /// RTC domain software reset Set and cleared by software to reset the RTC domain:
        RTCRST: u1,
        reserved24: u7 = 0,
        /// Low-speed clock output (LSCO) enable Set and cleared by software.
        LSCOEN: u1,
        /// Low-speed clock output selection Set and cleared by software to select the low-speed output clock:
        LSCOSEL: LSCOSEL,
        padding: u6 = 0,
    }),
    /// RCC control/status register 2
    /// offset: 0x60
    CSR2: mmio.Mmio(packed struct(u32) {
        /// LSI oscillator enable Set and cleared by software to enable/disable the LSI oscillator:
        LSION: u1,
        /// LSI oscillator ready Set and cleared by hardware to indicate when the LSI oscillator is ready (stable): After the LSION bit is cleared, LSIRDY goes low after 3 LSI oscillator clock cycles. This bit can be set even if LSION = 0 if the LSI is requested by the Clock Security System on LSE, by the Independent Watchdog or by the RTC.
        LSIRDY: u1,
        reserved23: u21 = 0,
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
        /// Low-power reset flag Set by hardware when a reset occurs due to illegal Stop, or Standby, or Shutdown mode entry. Cleared by setting the RMVF bit. This operates only if nRST_STOP, or nRST_STDBY or nRST_SHDW option bits are cleared.
        LPWRRSTF: u1,
    }),
};
