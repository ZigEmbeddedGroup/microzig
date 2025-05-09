const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Microcontroller debug unit
pub const DBGMCU = extern struct {
    /// identity code register
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device ID
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// Revision ID
        REV_ID: u16,
    }),
    /// status and configuration register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Allows debug in Stop mode Write access can be protected by PWR_SECCFGR.LPMSEC. The CPU debug and clocks remain active and the HSI oscillators is used as system clock during Stop debug mode, allowing CPU debug capability. On exit from Stop mode, the clock settings are set to the Stop mode exit state.
        DBG_STOP: u1,
        /// Allows debug in Standby mode Write access can be protected by PWR_SECCFGR.LPMSEC. The CPU debug and clocks remain active and the HSI oscillator is used as system clock, the supply and SRAM memory content is maintained during Standby debug mode, allowing CPU debug capability. On exit from Standby mode, a standby reset is performed.
        DBG_STANDBY: u1,
        reserved16: u13 = 0,
        /// Device low power mode selected 10x: Standby mode others reserved
        LPMS: u3,
        /// Device Stop flag
        STOPF: u1,
        /// Device Standby flag
        SBF: u1,
        reserved24: u3 = 0,
        /// CPU Sleep
        CS: u1,
        /// CPU DeepSleep
        CDS: u1,
        padding: u6 = 0,
    }),
    /// APB1L peripheral freeze register
    /// offset: 0x08
    APB1LFZR: mmio.Mmio(packed struct(u32) {
        /// TIM2 stop in CPU debug Write access can be protected by GTZC_TZSC.TIM2SEC.
        DBG_TIM2_STOP: u1,
        /// TIM3 stop in CPU debug Write access can be protected by GTZC_TZSC.TIM3SEC.
        DBG_TIM3_STOP: u1,
        reserved11: u9 = 0,
        /// WWDG stop in CPU debug Write access can be protected by GTZC_TZSC.WWDGSEC
        DBG_WWDG_STOP: u1,
        /// IWDG stop in CPU debug Write access can be protected by GTZC_TZSC.IWDGSEC.
        DBG_IWDG_STOP: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout stop in CPU debug Write access can be protected by GTZC_TZSC.I2C1SEC.
        DBG_I2C1_STOP: u1,
        padding: u10 = 0,
    }),
    /// APB1H peripheral freeze register
    /// offset: 0x0c
    APB1HFZR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 stop in CPU debug Write access can be protected by GTZC_TZSC.LPTIM2SEC.
        DBG_LPTIM2_STOP: u1,
        padding: u26 = 0,
    }),
    /// APB2 peripheral freeze register
    /// offset: 0x10
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 stop in CPU debug Write access can be protected by GTZC_TZSC.TIM1SEC.
        DBG_TIM1_STOP: u1,
        reserved17: u5 = 0,
        /// TIM16 stop in CPU debug Write access can be protected by GTZC_TZSC.TIM16SEC.
        DBG_TIM16_STOP: u1,
        /// TIM17 stop in CPU debug Write access can be protected by GTZC_TZSC.TIM17SEC.
        DBG_TIM17_STOP: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x14
    reserved20: [16]u8,
    /// APB7 peripheral freeze register
    /// offset: 0x24
    APB7FZR: mmio.Mmio(packed struct(u32) {
        reserved10: u10 = 0,
        /// I2C3 stop in CPU debug Access can be protected by GTZC_TZSC.I2C3SEC.
        DBG_I2C3_STOP: u1,
        reserved17: u6 = 0,
        /// LPTIM1 stop in CPU debug Access can be protected by GTZC_TZSC.LPTIM1SEC.
        DBG_LPTIM1_STOP: u1,
        reserved30: u12 = 0,
        /// RTC stop in CPU debug Access can be protected by GTZC_TZSC.TIM17SEC. Can only be accessed secure when one or more features in the RTC or TAMP is/are secure.
        DBG_RTC_STOP: u1,
        padding: u1 = 0,
    }),
    /// AHB1 peripheral freeze register
    /// offset: 0x28
    AHB1FZR: mmio.Mmio(packed struct(u32) {
        /// GPDMA 1 channel 0 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC0.
        DBG_GPDMA1_CH0_STOP: u1,
        /// GPDMA 1 channel 1 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC1.
        DBG_GPDMA1_CH1_STOP: u1,
        /// GPDMA 1 channel 2 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC2.
        DBG_GPDMA1_CH2_STOP: u1,
        /// GPDMA 1 channel 3 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC3.
        DBG_GPDMA1_CH3_STOP: u1,
        /// GPDMA 1 channel 4 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC4.
        DBG_GPDMA1_CH4_STOP: u1,
        /// GPDMA 1 channel 5 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC5.
        DBG_GPDMA1_CH5_STOP: u1,
        /// GPDMA 1 channel 6 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC6.
        DBG_GPDMA1_CH6_STOP: u1,
        /// GPDMA 1 channel 7 stop in CPU debug Write access can be protected by GPDMA_SECCFGR.SEC7.
        DBG_GPDMA1_CH7_STOP: u1,
        padding: u24 = 0,
    }),
    /// offset: 0x2c
    reserved44: [208]u8,
    /// status register
    /// offset: 0xfc
    SR: mmio.Mmio(packed struct(u32) {
        /// Bit n identifies whether access port APn is present in device Bit n�=�0: APn absent Bit n�=�1: APn present
        AP_PRESENT: u16,
        /// Bit n identifies whether access port APn is open (can be accessed via the debug port) or locked (debug access to the APn is blocked, except for access) Bit n�=�0: APn locked (except for access to DBGMCU) Bit n�=�1: APn enabled
        AP_ENABLED: u16,
    }),
    /// debug host authentication register
    /// offset: 0x100
    DBG_AUTH_HOST: mmio.Mmio(packed struct(u32) {
        /// Device authentication key The device specific 64-bit authentication key (OEMn key) must be written to this register (in two successive 32-bit writes, least significant word first) to permit RDP regression. Writing a wrong key locks access to the device and prevent code execution from the Flash memory.
        AUTH_KEY: u32,
    }),
    /// debug device authentication register
    /// offset: 0x104
    DBG_AUTH_DEVICE: mmio.Mmio(packed struct(u32) {
        /// Device specific ID Device specific ID used for RDP regression.
        AUTH_ID: u32,
    }),
    /// offset: 0x108
    reserved264: [1748]u8,
    /// part number codification register
    /// offset: 0x7dc
    PNCR: mmio.Mmio(packed struct(u32) {
        /// Part number codification
        CODIFICATION: u32,
    }),
    /// offset: 0x7e0
    reserved2016: [2032]u8,
    /// CoreSight peripheral identity register 4
    /// offset: 0xfd0
    PIDR4: mmio.Mmio(packed struct(u32) {
        /// JEP106 continuation code
        JEP106CON: u4,
        /// Register file size
        F4KCOUNT: u4,
        padding: u24 = 0,
    }),
    /// offset: 0xfd4
    reserved4052: [12]u8,
    /// CoreSight peripheral identity register 0
    /// offset: 0xfe0
    PIDR0: mmio.Mmio(packed struct(u32) {
        /// Part number bits [7:0]
        PARTNUM: u8,
        padding: u24 = 0,
    }),
    /// CoreSight peripheral identity register 1
    /// offset: 0xfe4
    PIDR1: mmio.Mmio(packed struct(u32) {
        /// Part number bits [11:8]
        PARTNUM: u4,
        /// JEP106 identity code bits [3:0]
        JEP106ID: u4,
        padding: u24 = 0,
    }),
    /// CoreSight peripheral identity register 2
    /// offset: 0xfe8
    PIDR2: mmio.Mmio(packed struct(u32) {
        /// JEP106 identity code bits [6:4]
        JEP106ID: u3,
        /// JEDEC assigned value
        JEDEC: u1,
        /// Component revision number
        REVISION: u4,
        padding: u24 = 0,
    }),
    /// CoreSight peripheral identity register 3
    /// offset: 0xfec
    PIDR3: mmio.Mmio(packed struct(u32) {
        /// Customer modified
        CMOD: u4,
        /// Metal fix version
        REVAND: u4,
        padding: u24 = 0,
    }),
    /// CoreSight component identity register 0
    /// offset: 0xff0
    CIDR0: mmio.Mmio(packed struct(u32) {
        /// Component ID bits [7:0]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// CoreSight peripheral identity register 1
    /// offset: 0xff4
    CIDR1: mmio.Mmio(packed struct(u32) {
        /// Component ID bits [11:8]
        PREAMBLE: u4,
        /// Component ID bits [15:12] - component class
        CLASS: u4,
        padding: u24 = 0,
    }),
    /// CoreSight component identity register 2
    /// offset: 0xff8
    CIDR2: mmio.Mmio(packed struct(u32) {
        /// Component ID bits [23:16]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// CoreSight component identity register 3
    /// offset: 0xffc
    CIDR3: mmio.Mmio(packed struct(u32) {
        /// Component ID bits [31:24]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
};
