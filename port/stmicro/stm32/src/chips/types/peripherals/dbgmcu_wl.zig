const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Microcontroller Debug Unit
pub const DBGMCU = extern struct {
    /// Identity Code Register
    /// offset: 0x00
    IDCODER: mmio.Mmio(packed struct(u32) {
        /// Device ID
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// Revision
        REV_ID: u16,
    }),
    /// Configuration Register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Allow debug in SLEEP mode
        DBG_SLEEP: u1,
        /// Allow debug in STOP mode
        DBG_STOP: u1,
        /// Allow debug in STANDBY mode
        DBG_STANDBY: u1,
        padding: u29 = 0,
    }),
    /// offset: 0x08
    reserved8: [52]u8,
    /// CPU1 APB1 Peripheral Freeze Register 1
    /// offset: 0x3c
    APB1FZR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 stop in CPU1 debug
        TIM2: u1,
        reserved10: u9 = 0,
        /// RTC stop in CPU1 debug
        RTC: u1,
        /// WWDG stop in CPU1 debug
        WWDG: u1,
        /// IWDG stop in CPU1 debug
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout stop in CPU1 debug
        I2C1: u1,
        /// I2C2 SMBUS timeout stop in CPU1 debug
        I2C2: u1,
        /// I2C3 SMBUS timeout stop in CPU1 debug
        I2C3: u1,
        reserved31: u7 = 0,
        /// LPTIM1 stop in CPU1 debug
        LPTIM1: u1,
    }),
    /// CPU2 APB1 Peripheral Freeze Register 1 [dual core device
    /// offset: 0x40
    C2APB1FZR1: mmio.Mmio(packed struct(u32) {
        /// TIM2
        TIM2: u1,
        reserved10: u9 = 0,
        /// RTC
        RTC: u1,
        reserved12: u1 = 0,
        /// IWDG
        IWDG: u1,
        reserved21: u8 = 0,
        /// I2C1
        I2C1: u1,
        /// I2C2
        I2C2: u1,
        /// I2C3
        I2C3: u1,
        reserved31: u7 = 0,
        /// LPTIM1
        LPTIM1: u1,
    }),
    /// CPU1 APB1 Peripheral Freeze Register 2
    /// offset: 0x44
    APB1FZR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2
        LPTIM2: u1,
        /// LPTIM3
        LPTIM3: u1,
        padding: u25 = 0,
    }),
    /// CPU2 APB1 Peripheral Freeze Register 2 [dual core device
    /// offset: 0x48
    C2APB1FZR2: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2
        LPTIM2: u1,
        /// LPTIM3
        LPTIM3: u1,
        padding: u25 = 0,
    }),
    /// CPU1 APB2 Peripheral Freeze Register
    /// offset: 0x4c
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1
        TIM1: u1,
        reserved17: u5 = 0,
        /// TIM16
        TIM16: u1,
        /// TIM17
        TIM17: u1,
        padding: u13 = 0,
    }),
    /// CPU2 APB2 Peripheral Freeze Register [dual core device
    /// offset: 0x50
    C2APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1
        TIM1: u1,
        reserved17: u5 = 0,
        /// TIM16
        TIM16: u1,
        /// TIM17
        TIM17: u1,
        padding: u13 = 0,
    }),
};
