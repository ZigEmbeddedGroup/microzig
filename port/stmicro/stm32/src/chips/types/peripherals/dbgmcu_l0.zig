const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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
        /// Debug Sleep Mode
        DBG_SLEEP: u1,
        /// Debug Stop Mode
        DBG_STOP: u1,
        /// Debug Standby Mode
        DBG_STANDBY: u1,
        padding: u29 = 0,
    }),
    /// APB Low Freeze Register
    /// offset: 0x08
    APB1FZR: mmio.Mmio(packed struct(u32) {
        /// Debug Timer 2 stopped when Core is halted
        TIM2: u1,
        reserved4: u3 = 0,
        /// Debug Timer 6 stopped when Core is halted
        TIM6: u1,
        reserved10: u5 = 0,
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
        reserved31: u8 = 0,
        /// LPTIM1 counter stopped when core is halted
        LPTIM: u1,
    }),
    /// APB High Freeze Register
    /// offset: 0x0c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Debug Timer 21 stopped when Core is halted
        TIM21: u1,
        reserved6: u3 = 0,
        /// Debug Timer 22 stopped when Core is halted
        TIM22: u1,
        padding: u25 = 0,
    }),
};
