const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ETH_SEL_PHY = enum(u3) {
    /// GMII or MII
    MII_GMII = 0x0,
    /// RMII
    RMII = 0x4,
    _,
};

/// System configuration controller
pub const SYSCFG = extern struct {
    /// offset: 0x00
    reserved0: [4]u8,
    /// peripheral mode configuration register
    /// offset: 0x04
    PMCR: mmio.Mmio(packed struct(u32) {
        /// I2C1 Fm+
        I2C1FMP: u1,
        /// I2C2 Fm+
        I2C2FMP: u1,
        /// I2C3 Fm+
        I2C3FMP: u1,
        /// I2C4 Fm+
        I2C4FMP: u1,
        /// PB(6) Fm+
        PB6FMP: u1,
        /// PB(7) Fast Mode Plus
        PB7FMP: u1,
        /// PB(8) Fast Mode Plus
        PB8FMP: u1,
        /// PB(9) Fm+
        PB9FMP: u1,
        /// Booster Enable
        BOOSTE: u1,
        /// Analog switch supply voltage selection
        BOOSTVDDSEL: u1,
        reserved21: u11 = 0,
        /// Ethernet PHY interface selection.
        ETH_SEL_PHY: ETH_SEL_PHY,
        /// PA0 Switch Open
        PA0SO: u1,
        /// PA1 Switch Open
        PA1SO: u1,
        /// PC2 Switch Open
        PC2SO: u1,
        /// PC3 Switch Open
        PC3SO: u1,
        padding: u4 = 0,
    }),
    /// external interrupt configuration register
    /// offset: 0x08
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// compensation cell control/status register
    /// offset: 0x20
    CCCSR: mmio.Mmio(packed struct(u32) {
        /// enable
        EN: u1,
        /// Code selection
        CS: u1,
        reserved8: u6 = 0,
        /// Compensation cell ready flag
        RDY: u1,
        reserved16: u7 = 0,
        /// High-speed at low-voltage
        HSLV: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG compensation cell value register
    /// offset: 0x24
    CCVR: mmio.Mmio(packed struct(u32) {
        /// NMOS compensation value
        NCV: u4,
        /// PMOS compensation value
        PCV: u4,
        padding: u24 = 0,
    }),
    /// SYSCFG compensation cell code register
    /// offset: 0x28
    CCCR: mmio.Mmio(packed struct(u32) {
        /// NMOS compensation code
        NCC: u4,
        /// PMOS compensation code
        PCC: u4,
        padding: u24 = 0,
    }),
    /// SYSCFG power control register
    /// offset: 0x2c
    PWRCR: mmio.Mmio(packed struct(u32) {
        /// Overdrive enable
        ODEN: u4,
        padding: u28 = 0,
    }),
    /// offset: 0x30
    reserved48: [244]u8,
    /// SYSCFG package register
    /// offset: 0x124
    PKGR: mmio.Mmio(packed struct(u32) {
        /// Package
        PKG: u4,
        padding: u28 = 0,
    }),
    /// offset: 0x128
    reserved296: [472]u8,
    /// SYSCFG user register 0
    /// offset: 0x300
    UR0: mmio.Mmio(packed struct(u32) {
        /// Bank Swap
        BKS: u1,
        reserved16: u15 = 0,
        /// Readout protection
        RDP: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x304
    reserved772: [4]u8,
    /// SYSCFG user register 2
    /// offset: 0x308
    UR2: mmio.Mmio(packed struct(u32) {
        /// BOR_LVL Brownout Reset Threshold Level
        BORH: u2,
        reserved16: u14 = 0,
        /// Boot Address 0
        BOOT_ADD0: u16,
    }),
    /// SYSCFG user register 3
    /// offset: 0x30c
    UR3: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Boot Address 1
        BOOT_ADD1: u16,
    }),
    /// SYSCFG user register 4
    /// offset: 0x310
    UR4: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Mass Erase Protected Area Disabled for bank 1
        MEPAD_1: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 5
    /// offset: 0x314
    UR5: mmio.Mmio(packed struct(u32) {
        /// Mass erase secured area disabled for bank 1
        MESAD_1: u1,
        reserved16: u15 = 0,
        /// Write protection for flash bank 1
        WRPN_1: u8,
        padding: u8 = 0,
    }),
    /// SYSCFG user register 6
    /// offset: 0x318
    UR6: mmio.Mmio(packed struct(u32) {
        /// Protected area start address for bank 1
        PA_BEG_1: u12,
        reserved16: u4 = 0,
        /// Protected area end address for bank 1
        PA_END_1: u12,
        padding: u4 = 0,
    }),
    /// SYSCFG user register 7
    /// offset: 0x31c
    UR7: mmio.Mmio(packed struct(u32) {
        /// Secured area start address for bank 1
        SA_BEG_1: u12,
        reserved16: u4 = 0,
        /// Secured area end address for bank 1
        SA_END_1: u12,
        padding: u4 = 0,
    }),
    /// SYSCFG user register 8
    /// offset: 0x320
    UR8: mmio.Mmio(packed struct(u32) {
        /// Mass erase protected area disabled for bank 2
        MEPAD_2: u1,
        reserved16: u15 = 0,
        /// Mass erase secured area disabled for bank 2
        MESAD_2: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 9
    /// offset: 0x324
    UR9: mmio.Mmio(packed struct(u32) {
        /// Write protection for flash bank 2
        WRPN_2: u8,
        reserved16: u8 = 0,
        /// Protected area start address for bank 2
        PA_BEG_2: u12,
        padding: u4 = 0,
    }),
    /// SYSCFG user register 10
    /// offset: 0x328
    UR10: mmio.Mmio(packed struct(u32) {
        /// Protected area end address for bank 2
        PA_END_2: u12,
        reserved16: u4 = 0,
        /// Secured area start address for bank 2
        SA_BEG_2: u12,
        padding: u4 = 0,
    }),
    /// SYSCFG user register 11
    /// offset: 0x32c
    UR11: mmio.Mmio(packed struct(u32) {
        /// Secured area end address for bank 2
        SA_END_2: u12,
        reserved16: u4 = 0,
        /// Independent Watchdog 1 mode
        IWDG1M: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 12
    /// offset: 0x330
    UR12: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Secure mode
        SECURE: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 13
    /// offset: 0x334
    UR13: mmio.Mmio(packed struct(u32) {
        /// Secured DTCM RAM Size
        SDRS: u2,
        reserved16: u14 = 0,
        /// D1 Standby reset
        D1SBRST: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 14
    /// offset: 0x338
    UR14: mmio.Mmio(packed struct(u32) {
        /// D1 Stop Reset
        D1STPRST: u1,
        padding: u31 = 0,
    }),
    /// SYSCFG user register 15
    /// offset: 0x33c
    UR15: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// Freeze independent watchdog in Standby mode
        FZIWDGSTB: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 16
    /// offset: 0x340
    UR16: mmio.Mmio(packed struct(u32) {
        /// Freeze independent watchdog in Stop mode
        FZIWDGSTP: u1,
        reserved16: u15 = 0,
        /// Private key programmed
        PKP: u1,
        padding: u15 = 0,
    }),
    /// SYSCFG user register 17
    /// offset: 0x344
    UR17: mmio.Mmio(packed struct(u32) {
        /// I/O high speed / low voltage
        IO_HSLV: u1,
        padding: u31 = 0,
    }),
};
