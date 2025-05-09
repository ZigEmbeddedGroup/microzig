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
        reserved16: u4 = 0,
        /// Revision Identifier
        REV_ID: u16,
    }),
    /// Debug MCU Configuration Register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Debug Sleep mode
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
    /// APB Low Freeze Register
    /// offset: 0x08
    APB1FZR: mmio.Mmio(packed struct(u32) {
        /// Debug Timer 2 stopped when Core is halted
        TIM2: u1,
        /// Debug Timer 3 stopped when Core is halted
        TIM3: u1,
        /// Debug Timer 4 stopped when Core is halted
        TIM4: u1,
        /// Debug Timer 5 stopped when Core is halted
        TIM5: u1,
        /// Debug Timer 6 stopped when Core is halted
        TIM6: u1,
        /// Debug Timer 7 stopped when Core is halted
        TIM7: u1,
        /// Debug Timer 12 stopped when Core is halted
        TIM12: u1,
        /// Debug Timer 13 stopped when Core is halted
        TIM13: u1,
        /// Debug Timer 14 stopped when Core is halted
        TIM14: u1,
        /// Debug Timer 18 stopped when Core is halted
        TIM18: u1,
        /// Debug RTC stopped when Core is halted
        RTC: u1,
        /// Debug Window Wachdog stopped when Core is halted
        WWDG: u1,
        /// Debug Independent Wachdog stopped when Core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// SMBUS timeout mode stopped when Core is halted
        I2C1_SMBUS_TIMEOUT: u1,
        /// SMBUS timeout mode stopped when Core is halted
        I2C2_SMBUS_TIMEOUT: u1,
        reserved25: u2 = 0,
        /// Debug CAN stopped when core is halted
        CAN: u1,
        padding: u6 = 0,
    }),
    /// APB High Freeze Register
    /// offset: 0x0c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Debug Timer 15 stopped when Core is halted
        TIM15: u1,
        /// Debug Timer 16 stopped when Core is halted
        TIM16: u1,
        /// Debug Timer 17 stopped when Core is halted
        TIM17: u1,
        /// Debug Timer 19 stopped when Core is halted
        TIM19: u1,
        padding: u26 = 0,
    }),
};
