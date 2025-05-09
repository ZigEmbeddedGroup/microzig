const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Microcontroller debug unit.
pub const DBGMCU = extern struct {
    /// DBGMCU identity code register.
    /// offset: 0x00
    IDCODE: mmio.Mmio(packed struct(u32) {
        /// device identification.
        DEV_ID: u12,
        reserved16: u4 = 0,
        /// revision.
        REV_ID: u16,
    }),
    /// DBGMCU configuration register.
    /// offset: 0x04
    CR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Allows debug in Stop mode All clocks are disabled automatically in Stop mode. All active clocks and oscillators continue to run during Stop mode, allowing full debug capability. On exit from Stop mode, the clock settings are set to the Stop mode exit state.
        STOP: u1,
        /// Allows debug in Standby mode All clocks are disabled and the core powered down automatically in Standby mode. All active clocks and oscillators continue to run during Standby mode, and the core supply is maintained, allowing full debug capability. On exit from Standby mode, a system reset is performed.
        STANDBY: u1,
        reserved4: u1 = 0,
        /// trace pin enable.
        TRACE_IOEN: u1,
        /// trace port and clock enable. This bit enables the trace port clock, TRACECK.
        TRACE_EN: u1,
        /// trace pin assignment.
        TRACE_MODE: u2,
        reserved16: u8 = 0,
        /// Debug credentials reset type This bit selects which type of reset is used to revoke the debug authentication credentials.
        DCRT: u1,
        padding: u15 = 0,
    }),
    /// DBGMCU APB1L peripheral freeze register.
    /// offset: 0x08
    APB1LFZR: mmio.Mmio(packed struct(u32) {
        /// TIM2 stop in debug.
        TIM2_STOP: u1,
        /// TIM3 stop in debug.
        TIM3_STOP: u1,
        /// TIM4 stop in debug.
        TIM4_STOP: u1,
        /// TIM5 stop in debug.
        TIM5_STOP: u1,
        /// TIM6 stop in debug.
        TIM6_STOP: u1,
        /// TIM7 stop in debug.
        TIM7_STOP: u1,
        /// TIM12 stop in debug.
        TIM12_STOP: u1,
        /// TIM13 stop in debug.
        TIM13_STOP: u1,
        /// TIM14 stop in debug.
        TIM14_STOP: u1,
        reserved11: u2 = 0,
        /// WWDG stop in debug.
        WWDG_STOP: u1,
        /// IWDG stop in debug.
        IWDG_STOP: u1,
        reserved21: u8 = 0,
        /// I2C1 SMBUS timeout stop in debug.
        I2C1_STOP: u1,
        /// I2C2 SMBUS timeout stop in debug.
        I2C2_STOP: u1,
        /// I3C1 SCL stall counter stop in debug.
        I3C1_STOP: u1,
        padding: u8 = 0,
    }),
    /// DBGMCU APB1H peripheral freeze register.
    /// offset: 0x0c
    APB1HFZR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// LPTIM2 stop in debug.
        LPTIM2_STOP: u1,
        padding: u26 = 0,
    }),
    /// DBGMCU APB2 peripheral freeze register.
    /// offset: 0x10
    APB2FZR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// TIM1 stop in debug.
        TIM1_STOP: u1,
        reserved13: u1 = 0,
        /// TIM8 stop in debug.
        TIM8_STOP: u1,
        reserved16: u2 = 0,
        /// TIM15 stop in debug.
        TIM15_STOP: u1,
        /// TIM16 stop in debug.
        TIM16_STOP: u1,
        /// TIM17 stop in debug.
        TIM17_STOP: u1,
        padding: u13 = 0,
    }),
    /// DBGMCU APB3 peripheral freeze register.
    /// offset: 0x14
    APB3FZR: mmio.Mmio(packed struct(u32) {
        reserved10: u10 = 0,
        /// I2C3 SMBUS timeout stop in debug.
        I2C3_STOP: u1,
        /// I2C4 SMBUS timeout stop in debug.
        I2C4_STOP: u1,
        reserved17: u5 = 0,
        /// LPTIM1 stop in debug.
        LPTIM1_STOP: u1,
        /// LPTIM3 stop in debug.
        LPTIM3_STOP: u1,
        /// LPTIM4 stop in debug.
        LPTIM4_STOP: u1,
        /// LPTIM5 stop in debug.
        LPTIM5_STOP: u1,
        /// LPTIM6 stop in debug.
        LPTIM6_STOP: u1,
        reserved30: u8 = 0,
        /// RTC stop in debug.
        RTC_STOP: u1,
        padding: u1 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// DBGMCU AHB1 peripheral freeze register.
    /// offset: 0x20
    AHB1FZR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[0]": u1,
        /// (2/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[1]": u1,
        /// (3/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[2]": u1,
        /// (4/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[3]": u1,
        /// (5/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[4]": u1,
        /// (6/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[5]": u1,
        /// (7/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[6]": u1,
        /// (8/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[7]": u1,
        /// (9/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[8]": u1,
        /// (10/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[9]": u1,
        /// (11/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[10]": u1,
        /// (12/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[11]": u1,
        /// (13/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[12]": u1,
        /// (14/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[13]": u1,
        /// (15/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[14]": u1,
        /// (16/16 of GPDMA1_STOP) GPDMA1 channel 0 stop in debug.
        @"GPDMA1_STOP[15]": u1,
        /// (1/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[0]": u1,
        /// (2/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[1]": u1,
        /// (3/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[2]": u1,
        /// (4/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[3]": u1,
        /// (5/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[4]": u1,
        /// (6/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[5]": u1,
        /// (7/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[6]": u1,
        /// (8/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[7]": u1,
        /// (9/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[8]": u1,
        /// (10/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[9]": u1,
        /// (11/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[10]": u1,
        /// (12/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[11]": u1,
        /// (13/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[12]": u1,
        /// (14/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[13]": u1,
        /// (15/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[14]": u1,
        /// (16/16 of GPDMA2_STOP) GPDMA2 channel 0 stop in debug.
        @"GPDMA2_STOP[15]": u1,
    }),
    /// offset: 0x24
    reserved36: [216]u8,
    /// DBGMCU status register.
    /// offset: 0xfc
    SR: mmio.Mmio(packed struct(u32) {
        /// Bit n identifies whether access port AP n is present in device Bit n = 0: APn absent Bit n = 1: APn present.
        AP_PRESENT: u16,
        /// Bit n identifies whether access port AP n is open (can be accessed via the debug port) or locked (debug access to the AP is blocked) Bit n = 0: APn locked Bit n = 1: APn enabled.
        AP_ENABLED: u16,
    }),
    /// DBGMCU debug authentication mailbox host register.
    /// offset: 0x100
    AUTH_HOST: u32,
    /// DBGMCU debug authentication mailbox device register.
    /// offset: 0x104
    AUTH_DEVICE: u32,
    /// DBGMCU debug authentication mailbox acknowledge register.
    /// offset: 0x108
    AUTH_ACK: mmio.Mmio(packed struct(u32) {
        /// Host to device acknowledge. The device sets this bit to indicate that it has placed a message in the DBGMCU_DBG_AUTH_DEVICE register. It should be reset by the host after reading the message.
        HOST_ACK: u1,
        /// Device to device acknowledge. The host sets this bit to indicate that it has placed a message in the DBGMCU_DBG_AUTH_HOST register. It is reset by the device after reading the message.
        DEV_ACK: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x10c
    reserved268: [3780]u8,
    /// DBGMCU CoreSight peripheral identity register 4.
    /// offset: 0xfd0
    PIDR4: mmio.Mmio(packed struct(u32) {
        /// JEP106 continuation code.
        JEP106CON: u4,
        /// register file size.
        SIZE: u4,
        padding: u24 = 0,
    }),
    /// offset: 0xfd4
    reserved4052: [12]u8,
    /// DBGMCU CoreSight peripheral identity register 0.
    /// offset: 0xfe0
    PIDR0: mmio.Mmio(packed struct(u32) {
        /// part number bits [7:0].
        PARTNUM: u8,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight peripheral identity register 1.
    /// offset: 0xfe4
    PIDR1: mmio.Mmio(packed struct(u32) {
        /// part number bits [11:8].
        PARTNUM: u4,
        /// JEP106 identity code bits [3:0].
        JEP106ID: u4,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight peripheral identity register 2.
    /// offset: 0xfe8
    PIDR2: mmio.Mmio(packed struct(u32) {
        /// JEP106 identity code bits [6:4].
        JEP106ID: u3,
        /// JEDEC assigned value.
        JEDEC: u1,
        /// component revision number.
        REVISION: u4,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight peripheral identity register 3.
    /// offset: 0xfec
    PIDR3: mmio.Mmio(packed struct(u32) {
        /// customer modified.
        CMOD: u4,
        /// metal fix version.
        REVAND: u4,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight component identity register 0.
    /// offset: 0xff0
    CIDR0: mmio.Mmio(packed struct(u32) {
        /// component identification bits [7:0].
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight component identity register 1.
    /// offset: 0xff4
    CIDR1: mmio.Mmio(packed struct(u32) {
        /// component identification bits [11:8].
        PREAMBLE: u4,
        /// component identification bits [15:12] - component class.
        CLASS: u4,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight component identity register 2.
    /// offset: 0xff8
    CIDR2: mmio.Mmio(packed struct(u32) {
        /// component identification bits [23:16].
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
    /// DBGMCU CoreSight component identity register 3.
    /// offset: 0xffc
    CIDR3: mmio.Mmio(packed struct(u32) {
        /// component identification bits [31:24].
        PREAMBLE: u8,
        padding: u24 = 0,
    }),
};
