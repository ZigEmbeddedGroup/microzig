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
        reserved1: u1 = 0,
        /// Debug Stop Mode
        DBG_STOP: u1,
        /// Debug Standby Mode
        DBG_STANDBY: u1,
        padding: u29 = 0,
    }),
    /// DBG APB freeze register 1
    /// offset: 0x08
    APB1FZR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// TIM3 counter stopped when core is halted
        TIM3: u1,
        reserved10: u8 = 0,
        /// Debug RTC stopped when Core is halted
        RTC: u1,
        /// Debug Window Wachdog stopped when Core is halted
        WWDG: u1,
        /// Debug Independent Wachdog stopped when Core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout mode stopped when core is halted
        I2C1: u1,
        padding: u10 = 0,
    }),
    /// DBG APB freeze register 2
    /// offset: 0x0c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1
        TIM1: u1,
        reserved15: u3 = 0,
        /// TIM14
        TIM14: u1,
        reserved17: u1 = 0,
        /// TIM16
        TIM16: u1,
        /// TIM17
        TIM17: u1,
        padding: u13 = 0,
    }),
};
