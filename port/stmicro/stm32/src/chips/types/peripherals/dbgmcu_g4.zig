const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Debug support
pub const DBGMCU = extern struct {
    /// MCU Device ID Code Register
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device Identifier
        DEV_ID: u16,
        /// Revision Identifier
        REV_ID: u16,
    }),
    /// Debug MCU Configuration Register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Debug Sleep Mode
        DBG_SLEEP: u1,
        /// Debug Stop Mode
        DBG_STOP: u1,
        /// Debug Standby Mode
        DBG_STANDBY: u1,
        reserved5: u2 = 0,
        /// Trace pin assignment control
        TRACE_IOEN: u1,
        /// Trace pin assignment control
        TRACE_MODE: u2,
        padding: u24 = 0,
    }),
    /// APB Low Freeze Register 1
    /// offset: 0x08
    APB1LFZR: mmio.Mmio(packed struct(u32) {
        /// Debug Timer 2 stopped when Core is halted
        TIM2: u1,
        /// TIM3 counter stopped when core is halted
        TIM3: u1,
        /// TIM4 counter stopped when core is halted
        TIM4: u1,
        /// TIM5 counter stopped when core is halted
        TIM5: u1,
        /// Debug Timer 6 stopped when Core is halted
        TIM6: u1,
        /// TIM7 counter stopped when core is halted
        TIM7: u1,
        reserved10: u4 = 0,
        /// Debug RTC stopped when Core is halted
        RTC: u1,
        /// Debug Window Wachdog stopped when Core is halted
        WWDG: u1,
        /// Debug Independent Wachdog stopped when Core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout mode stopped when core is halted
        I2C1: u1,
        /// I2C2 SMBUS timeout mode stopped when core is halted
        I2C2: u1,
        reserved30: u7 = 0,
        /// I2C3 SMBUS timeout mode stopped when core is halted
        I2C3: u1,
        /// LPTIM1 counter stopped when core is halted
        LPTIMER: u1,
    }),
    /// APB Low Freeze Register 2
    /// offset: 0x0c
    APB1HFZR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// I2C4
        I2C4: u1,
        padding: u30 = 0,
    }),
    /// APB High Freeze Register
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
        reserved20: u1 = 0,
        /// TIM20counter stopped when core is halted
        TIM20: u1,
        reserved26: u5 = 0,
        /// HRTIM0
        HRTIM0: u1,
        /// HRTIM0
        HRTIM1: u1,
        /// HRTIM0
        HRTIM2: u1,
        /// HRTIM0
        HRTIM3: u1,
        padding: u2 = 0,
    }),
};
