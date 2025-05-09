const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Debug support
pub const DBGMCU = extern struct {
    /// IDCODE
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// DEV_ID
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// REV_ID
        REV_ID: u16,
    }),
    /// Control Register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// DBG_SLEEP
        DBG_SLEEP: u1,
        /// DBG_STOP
        DBG_STOP: u1,
        /// DBG_STANDBY
        DBG_STANDBY: u1,
        reserved5: u2 = 0,
        /// TRACE_IOEN
        TRACE_IOEN: u1,
        /// TRACE_MODE
        TRACE_MODE: u2,
        padding: u24 = 0,
    }),
    /// Debug MCU APB1 Freeze registe
    /// offset: 0x08
    APB1FZR: mmio.Mmio(packed struct(u32) {
        /// TIM2
        TIM2: u1,
        /// TIM3
        TIM3: u1,
        /// TIM4
        TIM4: u1,
        /// TIM5
        TIM5: u1,
        /// TIM6
        TIM6: u1,
        /// TIM7
        TIM7: u1,
        /// TIM12
        TIM12: u1,
        /// TIM13
        TIM13: u1,
        /// TIM14
        TIM14: u1,
        reserved10: u1 = 0,
        /// RTC stopped when Core is halted
        RTC: u1,
        /// WWDG
        WWDG: u1,
        /// IWDEG
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1_SMBUS_TIMEOUT
        I2C1_SMBUS_TIMEOUT: u1,
        /// I2C2_SMBUS_TIMEOUT
        I2C2_SMBUS_TIMEOUT: u1,
        /// I2C3SMBUS_TIMEOUT
        I2C3_SMBUS_TIMEOUT: u1,
        /// SMBUS timeout mode stopped when Core is halted
        I2CFMP_SMBUS_TIMEOUT: u1,
        /// CAN1
        CAN1: u1,
        /// CAN2
        CAN2: u1,
        padding: u5 = 0,
    }),
    /// Debug MCU APB2 Freeze registe
    /// offset: 0x0c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        /// TIM1 counter stopped when core is halted
        TIM1: u1,
        /// TIM8 counter stopped when core is halted
        TIM8: u1,
        reserved16: u14 = 0,
        /// TIM9 counter stopped when core is halted
        TIM9: u1,
        /// TIM10 counter stopped when core is halted
        TIM10: u1,
        /// TIM11 counter stopped when core is halted
        TIM11: u1,
        padding: u13 = 0,
    }),
};
