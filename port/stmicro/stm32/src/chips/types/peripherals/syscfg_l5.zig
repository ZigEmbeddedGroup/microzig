const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// SYSCFG secure configuration register
    /// offset: 0x00
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clock control security
        SYSCFGSEC: u1,
        /// ClassB security
        CLASSBSEC: u1,
        /// SRAM2 security
        SRAM2SEC: u1,
        /// FPUSEC
        FPUSEC: u1,
        padding: u28 = 0,
    }),
    /// configuration register 1
    /// offset: 0x04
    CFGR1: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// I/O analog switch voltage booster enable
        BOOSTEN: u1,
        /// GPIO analog switch control voltage selection
        ANASWVDD: u1,
        reserved16: u6 = 0,
        /// Fast-mode Plus (Fm+) driving capability activation on PB6
        I2C_PB6_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB7
        I2C_PB7_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB8
        I2C_PB8_FMP: u1,
        /// Fast-mode Plus (Fm+) driving capability activation on PB9
        I2C_PB9_FMP: u1,
        /// I2C1 Fast-mode Plus driving capability activation
        I2C1_FMP: u1,
        /// I2C2 Fast-mode Plus driving capability activation
        I2C2_FMP: u1,
        /// I2C3 Fast-mode Plus driving capability activation
        I2C3_FMP: u1,
        /// I2C4_FMP
        I2C4_FMP: u1,
        padding: u8 = 0,
    }),
    /// FPU interrupt mask register
    /// offset: 0x08
    FPUIMR: mmio.Mmio(packed struct(u32) {
        /// Floating point unit interrupts enable bits
        FPU_IE: u6,
        padding: u26 = 0,
    }),
    /// SYSCFG CPU non-secure lock register
    /// offset: 0x0c
    CNSLCKR: mmio.Mmio(packed struct(u32) {
        /// VTOR_NS register lock
        LOCKNSVTOR: u1,
        /// Non-secure MPU registers lock
        LOCKNSMPU: u1,
        padding: u30 = 0,
    }),
    /// SYSCFG CPU secure lock register
    /// offset: 0x10
    CSLOCKR: mmio.Mmio(packed struct(u32) {
        /// LOCKSVTAIRCR
        LOCKSVTAIRCR: u1,
        /// LOCKSMPU
        LOCKSMPU: u1,
        /// LOCKSAU
        LOCKSAU: u1,
        padding: u29 = 0,
    }),
    /// CFGR2
    /// offset: 0x14
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// LOCKUP (hardfault) output enable bit
        CLL: u1,
        /// SRAM2 parity lock bit
        SPL: u1,
        /// PVD lock enable bit
        PVDL: u1,
        /// ECC Lock
        ECCL: u1,
        reserved8: u4 = 0,
        /// SRAM2 parity error flag
        SPF: u1,
        padding: u23 = 0,
    }),
    /// SCSR
    /// offset: 0x18
    SCSR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 Erase
        SRAM2ER: u1,
        /// SRAM2 busy by erase operation
        SRAM2BSY: u1,
        padding: u30 = 0,
    }),
    /// SKR
    /// offset: 0x1c
    SKR: mmio.Mmio(packed struct(u32) {
        /// SRAM2 write protection key for software erase
        KEY: u8,
        padding: u24 = 0,
    }),
    /// SWPR
    /// offset: 0x20
    SWPR: mmio.Mmio(packed struct(u32) {
        /// P0WP
        P0WP: u1,
        /// P1WP
        P1WP: u1,
        /// P2WP
        P2WP: u1,
        /// P3WP
        P3WP: u1,
        /// P4WP
        P4WP: u1,
        /// P5WP
        P5WP: u1,
        /// P6WP
        P6WP: u1,
        /// P7WP
        P7WP: u1,
        /// P8WP
        P8WP: u1,
        /// P9WP
        P9WP: u1,
        /// P10WP
        P10WP: u1,
        /// P11WP
        P11WP: u1,
        /// P12WP
        P12WP: u1,
        /// P13WP
        P13WP: u1,
        /// P14WP
        P14WP: u1,
        /// P15WP
        P15WP: u1,
        /// P16WP
        P16WP: u1,
        /// P17WP
        P17WP: u1,
        /// P18WP
        P18WP: u1,
        /// P19WP
        P19WP: u1,
        /// P20WP
        P20WP: u1,
        /// P21WP
        P21WP: u1,
        /// P22WP
        P22WP: u1,
        /// P23WP
        P23WP: u1,
        /// P24WP
        P24WP: u1,
        /// P25WP
        P25WP: u1,
        /// P26WP
        P26WP: u1,
        /// P27WP
        P27WP: u1,
        /// P28WP
        P28WP: u1,
        /// P29WP
        P29WP: u1,
        /// P30WP
        P30WP: u1,
        /// SRAM2 page 31 write protection
        P31WP: u1,
    }),
    /// SWPR2
    /// offset: 0x24
    SWPR2: mmio.Mmio(packed struct(u32) {
        /// P32WP
        P32WP: u1,
        /// P33WP
        P33WP: u1,
        /// P34WP
        P34WP: u1,
        /// P35WP
        P35WP: u1,
        /// P36WP
        P36WP: u1,
        /// P37WP
        P37WP: u1,
        /// P38WP
        P38WP: u1,
        /// P39WP
        P39WP: u1,
        /// P40WP
        P40WP: u1,
        /// P41WP
        P41WP: u1,
        /// P42WP
        P42WP: u1,
        /// P43WP
        P43WP: u1,
        /// P44WP
        P44WP: u1,
        /// P45WP
        P45WP: u1,
        /// P46WP
        P46WP: u1,
        /// P47WP
        P47WP: u1,
        /// P48WP
        P48WP: u1,
        /// P49WP
        P49WP: u1,
        /// P50WP
        P50WP: u1,
        /// P51WP
        P51WP: u1,
        /// P52WP
        P52WP: u1,
        /// P53WP
        P53WP: u1,
        /// P54WP
        P54WP: u1,
        /// P55WP
        P55WP: u1,
        /// P56WP
        P56WP: u1,
        /// P57WP
        P57WP: u1,
        /// P58WP
        P58WP: u1,
        /// P59WP
        P59WP: u1,
        /// P60WP
        P60WP: u1,
        /// P61WP
        P61WP: u1,
        /// P62WP
        P62WP: u1,
        /// P63WP
        P63WP: u1,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// RSSCMDR
    /// offset: 0x2c
    RSSCMDR: mmio.Mmio(packed struct(u32) {
        /// RSS commands
        RSSCMD: u8,
        padding: u24 = 0,
    }),
};
