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
        /// Debug Sleep Mode
        DBG_SLEEP: u1,
        /// Debug Stop Mode
        DBG_STOP: u1,
        /// Debug Standby Mode
        DBG_STANDBY: u1,
        reserved5: u2 = 0,
        /// Trace port and clock enable
        TRACE_IOEN: u1,
        reserved28: u22 = 0,
        /// External trigger output enable
        TRGOEN: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x08
    reserved8: [52]u8,
    /// APB1 Low Freeze Register CPU1
    /// offset: 0x3c
    APB1FZR1: mmio.Mmio(packed struct(u32) {
        /// Debug Timer 2 stopped when Core is halted
        TIM2: u1,
        reserved10: u9 = 0,
        /// RTC counter stopped when core is halted
        RTC: u1,
        /// WWDG counter stopped when core is halted
        WWDG: u1,
        /// IWDG counter stopped when core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// Debug I2C1 SMBUS timeout stopped when Core is halted
        I2C1: u1,
        reserved23: u1 = 0,
        /// Debug I2C3 SMBUS timeout stopped when core is halted
        I2C3: u1,
        reserved31: u7 = 0,
        /// Debug LPTIM1 stopped when Core is halted
        LPTIM1: u1,
    }),
    /// APB1 Low Freeze Register CPU2
    /// offset: 0x40
    C2AP_B1FZR1: mmio.Mmio(packed struct(u32) {
        /// LPTIM2 counter stopped when core is halted
        LPTIM2: u1,
        reserved10: u9 = 0,
        /// RTC counter stopped when core is halted
        RTC: u1,
        reserved12: u1 = 0,
        /// IWDG stopped when core is halted
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout stopped when core is halted
        I2C1: u1,
        reserved23: u1 = 0,
        /// I2C3 SMBUS timeout stopped when core is halted
        I2C3: u1,
        reserved31: u7 = 0,
        /// LPTIM1 counter stopped when core is halted
        LPTIM1: u1,
    }),
    /// APB1 High Freeze Register CPU1
    /// offset: 0x44
    APB1FZR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 counter stopped when core is halted
        LPTIM2: u1,
        padding: u26 = 0,
    }),
    /// APB1 High Freeze Register CPU2
    /// offset: 0x48
    C2APB1FZR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 counter stopped when core is halted
        LPTIM2: u1,
        padding: u26 = 0,
    }),
    /// APB2 Freeze Register CPU1
    /// offset: 0x4c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 counter stopped when core is halted
        TIM1: u1,
        reserved17: u5 = 0,
        /// TIM16 counter stopped when core is halted
        TIM16: u1,
        /// TIM17 counter stopped when core is halted
        TIM17: u1,
        padding: u13 = 0,
    }),
};
