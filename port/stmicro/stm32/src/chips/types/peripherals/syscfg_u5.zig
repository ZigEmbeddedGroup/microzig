const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// System configuration controller
pub const SYSCFG = extern struct {
    /// SYSCFG secure configuration register
    /// offset: 0x00
    SECCFGR: mmio.Mmio(packed struct(u32) {
        /// SYSCFG clock control security
        SYSCFGSEC: u1,
        /// CLASSBSEC
        CLASSBSEC: u1,
        reserved3: u1 = 0,
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
        /// PB6_FMP
        PB6_FMP: u1,
        /// PB7_FMP
        PB7_FMP: u1,
        /// PB8_FMP
        PB8_FMP: u1,
        /// PB9_FMP
        PB9_FMP: u1,
        padding: u12 = 0,
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
    /// configuration register 2
    /// offset: 0x14
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// LOCKUP (hardfault) output enable bit
        CLL: u1,
        /// SRAM ECC lock bit
        SPL: u1,
        /// PVD lock enable bit
        PVDL: u1,
        /// ECC Lock
        ECCL: u1,
        padding: u28 = 0,
    }),
    /// memory erase status register
    /// offset: 0x18
    MESR: mmio.Mmio(packed struct(u32) {
        /// MCLR
        MCLR: u1,
        reserved16: u15 = 0,
        /// IPMEE
        IPMEE: u1,
        padding: u15 = 0,
    }),
    /// compensation cell control/status register
    /// offset: 0x1c
    CCCSR: mmio.Mmio(packed struct(u32) {
        /// EN1
        EN1: u1,
        /// CS1
        CS1: u1,
        /// EN2
        EN2: u1,
        /// CS2
        CS2: u1,
        reserved8: u4 = 0,
        /// RDY1
        RDY1: u1,
        /// RDY2
        RDY2: u1,
        padding: u22 = 0,
    }),
    /// compensation cell value register
    /// offset: 0x20
    CCVR: mmio.Mmio(packed struct(u32) {
        /// NCV1
        NCV1: u4,
        /// PCV1
        PCV1: u4,
        /// NCV2
        NCV2: u4,
        /// PCV2
        PCV2: u4,
        padding: u16 = 0,
    }),
    /// compensation cell code register
    /// offset: 0x24
    CCCR: mmio.Mmio(packed struct(u32) {
        /// NCC1
        NCC1: u4,
        /// PCC1
        PCC1: u4,
        /// NCC2
        NCC2: u4,
        /// PCC2
        PCC2: u4,
        padding: u16 = 0,
    }),
    /// offset: 0x28
    reserved40: [4]u8,
    /// RSS command register
    /// offset: 0x2c
    RSSCMDR: mmio.Mmio(packed struct(u32) {
        /// RSS commands
        RSSCMD: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [64]u8,
    /// USB Type C and Power Delivery register
    /// offset: 0x70
    UCPDR: mmio.Mmio(packed struct(u32) {
        /// CC1ENRXFILTER
        CC1ENRXFILTER: u1,
        /// CC2ENRXFILTER
        CC2ENRXFILTER: u1,
        padding: u30 = 0,
    }),
};
