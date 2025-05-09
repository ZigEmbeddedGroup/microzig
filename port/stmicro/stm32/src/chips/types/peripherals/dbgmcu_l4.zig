const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// MCU debug component
pub const DBGMCU = extern struct {
    /// DBGMCU_IDCODE
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device identifier
        DEV_ID: u16,
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
    APB1FZR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 counter stopped when core is halted
        TIM2: u1,
        /// TIM3 counter stopped when core is halted
        TIM3: u1,
        /// TIM4 counter stopped when core is halted
        TIM4: u1,
        /// TIM5 counter stopped when core is halted
        TIM5: u1,
        /// TIM6 counter stopped when core is halted
        TIM6: u1,
        /// TIM7 counter stopped when core is halted
        TIM7: u1,
        reserved10: u4 = 0,
        /// RTC counter stopped when core is halted
        RTC: u1,
        /// Window watchdog counter stopped when core is halted
        WWDG: u1,
        /// Independent watchdog counter stopped when core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout counter stopped when core is halted
        I2C1: u1,
        /// I2C2 SMBUS timeout counter stopped when core is halted
        I2C2: u1,
        /// I2C3 SMBUS timeout counter stopped when core is halted
        I2C3: u1,
        reserved25: u1 = 0,
        /// bxCAN stopped when core is halted
        CAN: u1,
        reserved31: u5 = 0,
        /// LPTIM1 counter stopped when core is halted
        LPTIM1: u1,
    }),
    /// Debug MCU APB1 freeze register 2
    /// offset: 0x0c
    APB1FZR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 counter stopped when core is halted
        LPTIM2: u1,
        padding: u26 = 0,
    }),
    /// Debug MCU APB2 freeze register
    /// offset: 0x10
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 counter stopped when core is halted
        TIM1: u1,
        reserved13: u1 = 0,
        /// TIM8 counter stopped when core is halted
        TIM8: u1,
        reserved16: u2 = 0,
        /// TIM15 counter stopped when core is halted
        TIM15: u1,
        /// TIM16 counter stopped when core is halted
        TIM16: u1,
        /// TIM17 counter stopped when core is halted
        TIM17: u1,
        padding: u13 = 0,
    }),
};
