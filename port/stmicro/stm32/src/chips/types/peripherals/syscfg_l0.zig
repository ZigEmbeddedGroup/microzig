const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Memory mapping selection bits
        MEM_MODE: u2,
        reserved3: u1 = 0,
        /// User bank swapping
        UFB: u1,
        reserved8: u4 = 0,
        /// Boot mode selected by the boot pins status bits
        BOOT_MODE: u2,
        padding: u22 = 0,
    }),
    /// CFGR2
    /// offset: 0x04
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Firewall disable bit
        FWDIS: u1,
        reserved8: u7 = 0,
        /// Fm+ drive capability on PB6 enable bit
        I2C_PB6_FMP: u1,
        /// Fm+ drive capability on PB7 enable bit
        I2C_PB7_FMP: u1,
        /// Fm+ drive capability on PB8 enable bit
        I2C_PB8_FMP: u1,
        /// Fm+ drive capability on PB9 enable bit
        I2C_PB9_FMP: u1,
        /// I2C1 Fm+ drive capability enable bit
        I2C1_FMP: u1,
        /// I2C2 Fm+ drive capability enable bit
        I2C2_FMP: u1,
        /// I2C3 Fm+ drive capability enable bit
        I2C3_FMP: u1,
        padding: u17 = 0,
    }),
    /// external interrupt configuration register
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI configuration bits
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI configuration bits
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI configuration bits
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI configuration bits
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// CFGR3
    /// offset: 0x20
    CFGR3: mmio.Mmio(packed struct(u32) {
        /// VREFINT enable and scaler control for COMP2 enable bit
        EN_VREFINT: u1,
        reserved4: u3 = 0,
        /// VREFINT_ADC connection bit
        SEL_VREF_OUT: u2,
        reserved8: u2 = 0,
        /// VREFINT reference for ADC enable bit
        ENBUF_VREFINT_ADC: u1,
        /// Temperature sensor reference for ADC enable bit
        ENBUF_SENSOR_ADC: u1,
        reserved12: u2 = 0,
        /// VREFINT reference for COMP2 scaler enable bit
        ENBUF_VREFINT_COMP2: u1,
        /// VREFINT reference for HSI48 oscillator enable bit
        ENREF_HSI48: u1,
        reserved30: u16 = 0,
        /// VREFINT ready flag
        VREFINT_RDYF: u1,
        /// SYSCFG_CFGR3 lock bit
        REF_LOCK: u1,
    }),
};
