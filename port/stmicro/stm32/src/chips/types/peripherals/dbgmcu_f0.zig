const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Debug support
pub const DBGMCU = extern struct {
    /// MCU Device ID Code Register
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// Device Identifier
        DEV_ID: u12,
        /// Division Identifier
        DIV_ID: u4,
        /// Revision Identifier
        REV_ID: u16,
    }),
    /// Debug MCU Configuration Register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Debug Stop Mode
        DBG_STOP: u1,
        /// Debug Standby Mode
        DBG_STANDBY: u1,
        padding: u29 = 0,
    }),
    /// Debug MCU APB1 freeze register
    /// offset: 0x08
    APB1_FZ: mmio.Mmio(packed struct(u32) {
        /// TIM2 counter stopped when core is halted
        TIM2: u1,
        /// TIM3 counter stopped when core is halted
        TIM3: u1,
        reserved4: u2 = 0,
        /// TIM6 counter stopped when core is halted
        TIM6: u1,
        /// TIM7 counter stopped when core is halted
        TIM7: u1,
        reserved8: u2 = 0,
        /// TIM14 counter stopped when core is halted
        TIM14: u1,
        reserved10: u1 = 0,
        /// Debug RTC stopped when core is halted
        RTC: u1,
        /// Debug window watchdog stopped when core is halted
        WWDG: u1,
        /// Debug independent watchdog stopped when core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// SMBUS timeout mode stopped when core is halted
        DBG_I2C1_SMBUS_TIMEOUT: u1,
        reserved25: u3 = 0,
        /// CAN stopped when core is halted
        CAN: u1,
        padding: u6 = 0,
    }),
    /// Debug MCU APB2 freeze register
    /// offset: 0x0c
    APB2_FZ: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 counter stopped when core is halted
        TIM1: u1,
        reserved16: u4 = 0,
        /// TIM15 counter stopped when core is halted
        TIM15: u1,
        /// TIM16 counter stopped when core is halted
        TIM16: u1,
        /// TIM17 counter stopped when core is halted
        TIM17: u1,
        padding: u13 = 0,
    }),
};
