const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// debug support
pub const DBGMCU = extern struct {
    /// DBGMCU_IDCODE
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device identifier
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// Revision identifie
        REV_ID: u16,
    }),
    /// Debug MCU configuration register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Debug Sleep mode
        DBG_SLEEP: u1,
        /// Debug Stop mode
        DBG_STOP: u1,
        /// Debug Standby mode
        DBG_STANDBY: u1,
        reserved5: u2 = 0,
        /// Trace pin assignment control
        TRACE_IOEN: u1,
        /// Trace pin assignment control
        TRACE_MODE: u2,
        padding: u24 = 0,
    }),
    /// Debug MCU APB1 freeze register1
    /// offset: 0x08
    APB1_FZ: mmio.Mmio(packed struct(u32) {
        /// TIM2 counter stopped when core is halted
        DBG_TIM2_STOP: u1,
        /// TIM3 counter stopped when core is halted
        DBG_TIM3_STOP: u1,
        /// TIM4 counter stopped when core is halted
        DBG_TIM4_STOP: u1,
        /// TIM5 counter stopped when core is halted
        DBG_TIM5_STOP: u1,
        /// TIM6 counter stopped when core is halted
        DBG_TIM6_STOP: u1,
        /// TIM7 counter stopped when core is halted
        DBG_TIM7_STOP: u1,
        reserved10: u4 = 0,
        /// Debug RTC stopped when core is halted
        DBG_RTC_STOP: u1,
        /// Debug window watchdog stopped when core is halted
        DBG_WWDG_STOP: u1,
        /// Debug independent watchdog stopped when core is halted
        DBG_IWDG_STOP: u1,
        reserved21: u8 = 0,
        /// SMBUS timeout mode stopped when core is halted
        DBG_I2C1_SMBUS_TIMEOUT: u1,
        /// SMBUS timeout mode stopped when core is halted
        DBG_I2C2_SMBUS_TIMEOUT: u1,
        padding: u9 = 0,
    }),
    /// Debug MCU APB1 freeze register 2
    /// offset: 0x0c
    APB2_FZ: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// TIM counter stopped when core is halted
        DBG_TIM9_STOP: u1,
        /// TIM counter stopped when core is halted
        DBG_TIM10_STOP: u1,
        /// TIM counter stopped when core is halted
        DBG_TIM11_STOP: u1,
        padding: u27 = 0,
    }),
};
