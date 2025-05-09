const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Debug support
pub const DBGMCU = extern struct {
    /// DBGMCU_IDCODE
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// DEV_ID
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// REV_ID
        REV_ID: u16,
    }),
    /// DBGMCU_CR
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
        /// IWDG
        IWDG: u1,
        /// WWDG
        WWDG: u1,
        /// TIM1
        TIM1: u1,
        /// TIM2
        TIM2: u1,
        /// TIM3
        TIM3: u1,
        /// TIM4
        TIM4: u1,
        /// CAN1
        CAN1: u1,
        /// DBG_I2C1_SMBUS_TIMEOUT
        DBG_I2C1_SMBUS_TIMEOUT: u1,
        /// DBG_I2C2_SMBUS_TIMEOUT
        DBG_I2C2_SMBUS_TIMEOUT: u1,
        /// TIM8
        TIM8: u1,
        /// TIM5
        TIM5: u1,
        /// TIM6
        TIM6: u1,
        /// TIM7
        TIM7: u1,
        /// CAN2
        CAN2: u1,
        /// TIM15
        TIM15: u1,
        /// TIM16
        TIM16: u1,
        /// TIM17
        TIM17: u1,
        /// TIM12
        TIM12: u1,
        /// TIM13
        TIM13: u1,
        /// TIM14
        TIM14: u1,
        padding: u4 = 0,
    }),
};
