const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Debug support
pub const DBGMCU = extern struct {
    /// Identity code
    /// offset: 0x00
    IDC: mmio.Mmio(packed struct(u32) {
        /// Device ID
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// Revision ID
        REV_ID: u16,
    }),
    /// Configuration register
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        /// Allow debug in D1 Sleep mode
        DBGSLEEP_D1: u1,
        /// Allow debug in D1 Stop mode
        DBGSTOP_D1: u1,
        /// Allow debug in D1 Standby mode
        DBGSTBY_D1: u1,
        reserved20: u17 = 0,
        /// Trace clock enable enable
        TRACECLKEN: u1,
        /// D1 debug clock enable enable
        D1DBGCKEN: u1,
        /// D3 debug clock enable enable
        D3DBGCKEN: u1,
        reserved28: u5 = 0,
        /// External trigger output enable
        TRGOEN: u1,
        padding: u3 = 0,
    }),
    /// offset: 0x08
    reserved8: [44]u8,
    /// APB3 peripheral freeze register
    /// offset: 0x34
    APB3FZR1: mmio.Mmio(packed struct(u32) {
        reserved6: u6 = 0,
        /// WWDG1 stop in debug mode
        WWDG1: u1,
        padding: u25 = 0,
    }),
    /// offset: 0x38
    reserved56: [4]u8,
    /// APB1L peripheral freeze register
    /// offset: 0x3c
    APB1LFZR1: mmio.Mmio(packed struct(u32) {
        /// TIM2 stop in debug mode
        TIM2: u1,
        /// TIM3 stop in debug mode
        TIM3: u1,
        /// TIM4 stop in debug mode
        TIM4: u1,
        /// TIM5 stop in debug mode
        TIM5: u1,
        /// TIM6 stop in debug mode
        TIM6: u1,
        /// TIM7 stop in debug mode
        TIM7: u1,
        /// TIM12 stop in debug mode
        TIM12: u1,
        /// TIM13 stop in debug mode
        TIM13: u1,
        /// TIM14 stop in debug mode
        TIM14: u1,
        /// LPTIM1 stop in debug mode
        LPTIM1: u1,
        reserved21: u11 = 0,
        /// I2C1 SMBUS timeout stop in debug mode
        I2C1: u1,
        /// I2C2 SMBUS timeout stop in debug mode
        I2C2: u1,
        /// I2C3 SMBUS timeout stop in debug mode
        I2C3: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x40
    reserved64: [12]u8,
    /// APB2 peripheral freeze register
    /// offset: 0x4c
    APB2FZR1: mmio.Mmio(packed struct(u32) {
        /// TIM1 stop in debug mode
        TIM1: u1,
        /// TIM8 stop in debug mode
        TIM8: u1,
        reserved16: u14 = 0,
        /// TIM15 stop in debug mode
        TIM15: u1,
        /// TIM16 stop in debug mode
        TIM16: u1,
        /// TIM17 stop in debug mode
        TIM17: u1,
        reserved29: u10 = 0,
        /// HRTIM stop in debug mode
        HRTIM: u1,
        padding: u2 = 0,
    }),
    /// offset: 0x50
    reserved80: [4]u8,
    /// APB4 peripheral freeze register
    /// offset: 0x54
    APB4FZR1: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// I2C4 SMBUS timeout stop in debug mode
        I2C4: u1,
        reserved9: u1 = 0,
        /// LPTIM2 stop in debug mode
        LPTIM2: u1,
        /// LPTIM3 stop in debug mode
        LPTIM3: u1,
        /// LPTIM4 stop in debug mode
        LPTIM4: u1,
        /// LPTIM5 stop in debug mode
        LPTIM5: u1,
        reserved16: u3 = 0,
        /// RTC stop in debug mode
        RTC: u1,
        reserved18: u1 = 0,
        /// Independent watchdog for D1 stop in debug mode
        IWDG1: u1,
        padding: u13 = 0,
    }),
};
