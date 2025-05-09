const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// MCU debug component
pub const DBGMCU = extern struct {
    /// DBGMCU_IDCODE
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device dentification
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// Revision
        REV_ID: u16,
    }),
    /// Debug MCU configuration register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Debug Stop mode
        DBG_STOP: u1,
        /// Debug Standby mode
        DBG_STANDBY: u1,
        reserved4: u1 = 0,
        /// Trace pin assignment control
        TRACE_IOEN: u1,
        /// trace port and clock enable
        TRACE_EN: u1,
        /// Trace pin assignment control
        TRACE_MODE: u2,
        padding: u24 = 0,
    }),
    /// Debug MCU APB1L peripheral freeze register
    /// offset: 0x08
    APB1LFZR: mmio.Mmio(packed struct(u32) {
        /// TIM2 stop in debug
        DBG_TIM2_STOP: u1,
        /// TIM3 stop in debug
        DBG_TIM3_STOP: u1,
        /// TIM4 stop in debug
        DBG_TIM4_STOP: u1,
        /// TIM5 stop in debug
        DBG_TIM5_STOP: u1,
        /// TIM6 stop in debug
        DBG_TIM6_STOP: u1,
        /// TIM7 stop in debug
        DBG_TIM7_STOP: u1,
        reserved11: u5 = 0,
        /// Window watchdog counter stop in debug
        DBG_WWDG_STOP: u1,
        /// Independent watchdog counter stop in debug
        DBG_IWDG_STOP: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout stop in debug
        DBG_I2C1_STOP: u1,
        /// I2C2 SMBUS timeout stop in debug
        DBG_I2C2_STOP: u1,
        padding: u9 = 0,
    }),
    /// Debug MCU APB1H peripheral freeze register
    /// offset: 0x0c
    APB1HFZR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// I2C4 stop in debug
        DBG_I2C4_STOP: u1,
        reserved5: u3 = 0,
        /// LPTIM2 stop in debug
        DBG_LPTIM2_STOP: u1,
        padding: u26 = 0,
    }),
    /// Debug MCU APB2 peripheral freeze register
    /// offset: 0x10
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 counter stopped when core is halted
        DBG_TIM1_STOP: u1,
        reserved13: u1 = 0,
        /// TIM8 stop in debug
        DBG_TIM8_STOP: u1,
        reserved16: u2 = 0,
        /// TIM15 counter stopped when core is halted
        DBG_TIM15_STOP: u1,
        /// TIM16 counter stopped when core is halted
        DBG_TIM16_STOP: u1,
        /// DBG_TIM17_STOP
        DBG_TIM17_STOP: u1,
        padding: u13 = 0,
    }),
    /// Debug MCU APB3 peripheral freeze register
    /// offset: 0x14
    APB3FZR: mmio.Mmio(packed struct(u32) {
        reserved10: u10 = 0,
        /// I2C3 stop in debug
        DBG_I2C3_STOP: u1,
        reserved17: u6 = 0,
        /// LPTIM1 stop in debug
        DBG_LPTIM1_STOP: u1,
        /// LPTIM3 stop in debug
        DBG_LPTIM3_STOP: u1,
        /// LPTIM4 stop in debug
        DBG_LPTIM4_STOP: u1,
        reserved30: u10 = 0,
        /// RTC stop in debug
        DBG_RTC_STOP: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// Debug MCU AHB1 peripheral freeze register
    /// offset: 0x20
    AHB1FZR: mmio.Mmio(packed struct(u32) {
        /// GPDMA channel 0 stop in debug
        DBG_GPDMA0_STOP: u1,
        /// GPDMA channel 1 stop in debug
        DBG_GPDMA1_STOP: u1,
        /// GPDMA channel 2 stop in debug
        DBG_GPDMA2_STOP: u1,
        /// GPDMA channel 3 stop in debug
        DBG_GPDMA3_STOP: u1,
        /// GPDMA channel 4 stop in debug
        DBG_GPDMA4_STOP: u1,
        /// GPDMA channel 5 stop in debug
        DBG_GPDMA5_STOP: u1,
        /// GPDMA channel 6 stop in debug
        DBG_GPDMA6_STOP: u1,
        /// GPDMA channel 7 stop in debug
        DBG_GPDMA7_STOP: u1,
        /// GPDMA channel 8 stop in debug
        DBG_GPDMA8_STOP: u1,
        /// GPDMA channel 9 stop in debug
        DBG_GPDMA9_STOP: u1,
        /// GPDMA channel 10 stop in debug
        DBG_GPDMA10_STOP: u1,
        /// GPDMA channel 11 stop in debug
        DBG_GPDMA11_STOP: u1,
        /// GPDMA channel 12 stop in debug
        DBG_GPDMA12_STOP: u1,
        /// GPDMA channel 13 stop in debug
        DBG_GPDMA13_STOP: u1,
        /// GPDMA channel 14 stop in debug
        DBG_GPDMA14_STOP: u1,
        /// GPDMA channel 15 stop in debug
        DBG_GPDMA15_STOP: u1,
        padding: u16 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// Debug MCU AHB3 peripheral freeze register
    /// offset: 0x28
    AHB3FZR: mmio.Mmio(packed struct(u32) {
        /// LPDMA channel 0 stop in debug
        DBG_LPDMA0_STOP: u1,
        /// LPDMA channel 1 stop in debug
        DBG_LPDMA1_STOP: u1,
        /// LPDMA channel 2 stop in debug
        DBG_LPDMA2_STOP: u1,
        /// LPDMA channel 3 stop in debug
        DBG_LPDMA3_STOP: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x2c
    reserved44: [208]u8,
    /// DBGMCU status register
    /// offset: 0xfc
    DBGMCU_SR: mmio.Mmio(packed struct(u32) {
        /// Bit n identifies whether access port AP n is present in device Bit n = 0: APn absent Bit n = 1: APn present
        AP_PRESENT: u8,
        /// DECLARATION TO BE CONFIRMED by PRODUCT OWNER! Bit n identifies whether access port AP n is open (can be accessed via the debug port) or locked (debug access to the AP is blocked) Bit n = 0: APn locked Bit n = 1: APn enabled
        AP_LOCKED: u8,
        padding: u16 = 0,
    }),
    /// DBGMCU debug host authentication register
    /// offset: 0x100
    DBGMCU_DBG_AUTH_HOST: mmio.Mmio(packed struct(u32) {
        /// Device authentication key The device specific 64-bit authentication key (OEM key) must be written to this register (in two successive 32-bit writes, least significant word first) to permit RDP regression. Writing a wrong key locks access to the device and prevent code execution from the Flash memory.
        AUTH_KEY: u32,
    }),
    /// DBGMCU debug device authentication register
    /// offset: 0x104
    DBGMCU_DBG_AUTH_DEVICE: mmio.Mmio(packed struct(u32) {
        /// Device specific ID Device specific ID used for RDP regression.
        AUTH_ID: u32,
    }),
    /// offset: 0x108
    reserved264: [3784]u8,
    /// Debug MCU CoreSight peripheral identity register 4
    /// offset: 0xfd0
    PIDR4: mmio.Mmio(packed struct(u32) {
        /// JEP106 continuation code
        JEP106CON: u4,
        /// register file size
        KCOUNT_4: u4,
        padding: u24 = 0,
    }),
    /// offset: 0xfd4
    reserved4052: [12]u8,
    /// Debug MCU CoreSight peripheral identity register 0
    /// offset: 0xfe0
    PIDR0: mmio.Mmio(packed struct(u32) {
        /// part number bits [7:0]
        PARTNUM: u8,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight peripheral identity register 1
    /// offset: 0xfe4
    PIDR1: mmio.Mmio(packed struct(u32) {
        /// part number bits [11:8]
        PARTNUM: u4,
        /// JEP106 identity code bits [3:0]
        JEP106ID: u4,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight peripheral identity register 2
    /// offset: 0xfe8
    PIDR2: mmio.Mmio(packed struct(u32) {
        /// JEP106 identity code bits [6:4]
        JEP106ID: u3,
        /// JEDEC assigned value
        JEDEC: u1,
        /// component revision number
        REVISION: u4,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight peripheral identity register 3
    /// offset: 0xfec
    PIDR3: mmio.Mmio(packed struct(u32) {
        /// customer modified
        CMOD: u4,
        /// metal fix version
        REVAND: u4,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight component identity register 0
    /// offset: 0xff0
    CIDR0: mmio.Mmio(packed struct(u32) {
        /// component identification bits [7:0]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight component identity register 1
    /// offset: 0xff4
    CIDR1: mmio.Mmio(packed struct(u32) {
        /// component identification bits [11:8]
        PREAMBLE: u4,
        /// component identification bits [15:12] - component class
        CLASS: u4,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight component identity register 2
    /// offset: 0xff8
    CIDR2: mmio.Mmio(packed struct(u32) {
        /// component identification bits [23:16]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// Debug MCU CoreSight component identity register 3
    /// offset: 0xffc
    CIDR3: mmio.Mmio(packed struct(u32) {
        /// component identification bits [31:24]
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
};
