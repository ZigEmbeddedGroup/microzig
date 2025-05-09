const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// secure configuration register
    /// offset: 0x00
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// clock control, memory erase status and compensation cell registers security
        SYSCFGSEC: u1,
        /// Class B security
        CLASSBSEC: u1,
        reserved3: u1 = 0,
        /// FPU security
        FPUSEC: u1,
        padding: u28 = 0,
    }),
    /// configuration register 1
    /// offset: 0x04
    CFGR1: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// I/O analog switch voltage booster enable Access can be protected by GTZC_TZSC ADC4SEC. Note: Refer to Table�121 for setting.
        BOOSTEN: u1,
        /// GPIO analog switch control voltage selection Access can be protected by GTZC_TZSC ADC4SEC. Note: Refer to Table�121 for setting.
        ANASWVDD: u1,
        reserved16: u6 = 0,
        /// Fast-mode Plus drive capability activation on PA6 This bit can be read and written only with secure access if PA6 is secure in GPIOA. This bit enables the Fast-mode Plus drive mode for PA6 when PA6 is not used by I2C peripheral. This can be used to dive a LED for instance. Access can be protected by GPIOA SEC6.
        PA6_FMP: u1,
        /// Fast-mode Plus drive capability activation on PA7 This bit can be read and written only with secure access if PA7 is secure in GPIOA. This bit enables the Fast-mode Plus drive mode for PA7 when PA7 is not used by I2C peripheral. This can be used to dive a LED for instance. Access can be protected by GPIOA SEC7.
        PA7_FMP: u1,
        /// Fast-mode Plus drive capability activation on PA15 This bit can be read and written only with secure access if PA15 is secure in GPIOA. This bit enables the Fast-mode Plus drive mode for PA15 when PA15 is not used by I2C peripheral. This can be used to dive a LED for instance. Access can be protected by GPIOA SEC15.
        PA15_FMP: u1,
        /// Fast-mode Plus drive capability activation on PB3 This bit can be read and written only with secure access if PB3 is secure in GPIOB. This bit enables the Fast-mode Plus drive mode for PB3 when PB3 is not used by I2C peripheral. This can be used to dive a LED for instance. Access can be protected by GPIOB SEC3.
        PB3_FMP: u1,
        padding: u12 = 0,
    }),
    /// FPU interrupt mask register
    /// offset: 0x08
    FPUIMR: mmio.Mmio(packed struct(u32) {
        /// Floating point unit interrupts enable bits FPU_IE[5]: Inexact interrupt enable (interrupt disable at reset) FPU_IE[4]: Input abnormal interrupt enable FPU_IE[3]: Overflow interrupt enable FPU_IE[2]: Underflow interrupt enable FPU_IE[1]: Divide-by-zero interrupt enable FPU_IE[0]: Invalid operation Interrupt enable
        FPU_IE: u6,
        padding: u26 = 0,
    }),
    /// CPU non-secure lock register
    /// offset: 0x0c
    CNSLCKR: mmio.Mmio(packed struct(u32) {
        /// VTOR_NS register lock This bit is set by software and cleared only by a system reset.
        LOCKNSVTOR: u1,
        /// Non-secure MPU registers lock This bit is set by software and cleared only by a system reset. When set, this bit disables write access to non-secure MPU_CTRL_NS, MPU_RNR_NS and MPU_RBAR_NS registers.
        LOCKNSMPU: u1,
        padding: u30 = 0,
    }),
    /// CPU secure lock register
    /// offset: 0x10
    CSLOCKR: mmio.Mmio(packed struct(u32) {
        /// VTOR_S register and AIRCR register bits lock This bit is set by software and cleared only by a system reset. When set, it disables write access to VTOR_S register, PRIS and BFHFNMINS bits in the AIRCR register.
        LOCKSVTAIRCR: u1,
        /// Secure MPU registers lock This bit is set by software and cleared only by a system reset. When set, it disables write access to secure MPU_CTRL, MPU_RNR and MPU_RBAR registers.
        LOCKSMPU: u1,
        /// SAU registers lock This bit is set by software and cleared only by a system reset. When set, it disables write access to SAU_CTRL, SAU_RNR, SAU_RBAR and SAU_RLAR registers.
        LOCKSAU: u1,
        padding: u29 = 0,
    }),
    /// configuration register 2
    /// offset: 0x14
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Cortex-M33 LOCKUP (hardfault) output enable This bit is set by software and cleared only by a system reset. It can be used to enable and lock the connection of Cortex-M33 LOCKUP (hardfault) output to TIM1/16/17 break input.
        CLL: u1,
        /// SRAM2 parity lock bit This bit is set by software and cleared only by a system reset. It can be used to enable and lock the SRAM2 parity error signal connection to TIM1/16/17 break inputs.
        SPL: u1,
        /// PVD lock enable bit This bit is set by software and cleared only by a system reset. It can be used to enable and lock the PVD connection to TIM1/16/17 break input, as well as the PVDE and PVDLS[2:0] in the PWR register.
        PVDL: u1,
        /// ECC lock This bit is set by software and cleared only by a system reset. It can be used to enable and lock the Flash ECC double error signal connection to TIM1/16/17 break input.
        ECCL: u1,
        padding: u28 = 0,
    }),
    /// memory erase status register
    /// offset: 0x18
    MESR: mmio.Mmio(packed struct(u32) {
        /// Device memories erase status This bit is set by hardware when SRAM2, ICACHE, PKA SRAM erase is completed after power-on reset or tamper detection (refer to Section�75: Tamper and backup registers (TAMP) for more details). This bit is not reset by system reset and is cleared by software by writing 1 to it.
        MCLR: u1,
        reserved16: u15 = 0,
        /// ICACHE and PKA SRAM erase status This bit is set by hardware when ICACHE and PKA SRAM erase is completed after potential tamper detection (refer to Section�75: Tamper and backup registers (TAMP) for more details). This bit is cleared by software by writing 1 to it.
        IPMEE: u1,
        padding: u15 = 0,
    }),
    /// compensation cell control/status register
    /// offset: 0x1c
    CCCSR: mmio.Mmio(packed struct(u32) {
        /// VDD I/Os compensation cell enable This bit enables the compensation cell of the I/Os supplied by V<sub>DD</sub>.
        EN1: u1,
        /// VDD I/Os code selection This bit selects the code to be applied for the compensation cell of the I/Os supplied by V<sub>DD</sub>.
        CS1: u1,
        reserved8: u6 = 0,
        /// VDD I/Os compensation cell ready flag This bit provides the compensation cell status of the I/Os supplied by V<sub>DD</sub>. Note: The HSI clock is required for the compensation cell to work properly. The compensation cell ready bit (RDY1) is not set if the HSI clock is not enabled (HSION).
        RDY1: u1,
        padding: u23 = 0,
    }),
    /// compensation cell value register
    /// offset: 0x20
    CCVR: mmio.Mmio(packed struct(u32) {
        /// NMOS compensation value of the I/Os supplied by V<sub>DD</sub> This value is provided by the cell and can be used by the CPU to compute an I/Os compensation cell code for NMOS transistors. This code is applied to the I/Os compensation cell when the CS1 bit of the CCCSR is reset.
        NCV1: u4,
        /// PMOS compensation value of the I/Os supplied by V<sub>DD</sub> This value is provided by the cell and can be used by the CPU to compute an I/Os compensation cell code for PMOS transistors. This code is applied to the I/Os compensation cell when the CS1 bit of the CCCSR is reset.
        PCV1: u4,
        padding: u24 = 0,
    }),
    /// compensation cell code register
    /// offset: 0x24
    CCCR: mmio.Mmio(packed struct(u32) {
        /// NMOS compensation code of the I/Os supplied by V<sub>DD</sub> These bits are written by software to define an I/Os compensation cell code for NMOS transistors. This code is applied to the I/Os compensation cell when the CS1 bit of the CCCSR is set.
        NCC1: u4,
        /// PMOS compensation code of the I/Os supplied by V<sub>DD</sub> These bits are written by software to define an I/Os compensation cell code for PMOS transistors. This code is applied to the I/Os compensation cell when the CS1 bit of the CCCSR is set.
        PCC1: u4,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// RSS command register
    /// offset: 0x2c
    RSSCMDR: mmio.Mmio(packed struct(u32) {
        /// RSS commands This field defines a command to be executed by the RSS.
        RSSCMD: u16,
        padding: u16 = 0,
    }),
};
