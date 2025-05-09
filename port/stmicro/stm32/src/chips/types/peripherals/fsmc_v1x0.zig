const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ACCMOD = enum(u2) {
    /// Access mode A
    A = 0x0,
    /// Access mode B
    B = 0x1,
    /// Access mode C
    C = 0x2,
    /// Access mode D
    D = 0x3,
};

pub const CPSIZE = enum(u3) {
    /// No burst split when crossing page boundary
    NoBurstSplit = 0x0,
    /// 128 bytes CRAM page size
    Bytes128 = 0x1,
    /// 256 bytes CRAM page size
    Bytes256 = 0x2,
    /// 512 bytes CRAM page size
    Bytes512 = 0x3,
    /// 1024 bytes CRAM page size
    Bytes1024 = 0x4,
    _,
};

pub const MTYP = enum(u2) {
    /// SRAM memory type
    SRAM = 0x0,
    /// PSRAM (CRAM) memory type
    PSRAM = 0x1,
    /// NOR Flash/OneNAND Flash
    Flash = 0x2,
    _,
};

pub const MWID = enum(u2) {
    /// Memory data bus width 8 bits
    Bits8 = 0x0,
    /// Memory data bus width 16 bits
    Bits16 = 0x1,
    /// Memory data bus width 32 bits
    Bits32 = 0x2,
    _,
};

pub const WAITCFG = enum(u1) {
    /// NWAIT signal is active one data cycle before wait state
    BeforeWaitState = 0x0,
    /// NWAIT signal is active during wait state
    DuringWaitState = 0x1,
};

pub const WAITPOL = enum(u1) {
    /// NWAIT active low
    ActiveLow = 0x0,
    /// NWAIT active high
    ActiveHigh = 0x1,
};

/// Flexible static memory controller
pub const FSMC = extern struct {
    /// SRAM/NOR-Flash chip-select control register 1-4
    /// offset: 0x00
    BCR: mmio.Mmio(packed struct(u32) {
        /// Memory bank enable bit
        MBKEN: u1,
        /// Address/data multiplexing enable bit
        MUXEN: u1,
        /// Memory type
        MTYP: MTYP,
        /// Memory data bus width
        MWID: MWID,
        /// Flash access enable
        FACCEN: u1,
        reserved8: u1 = 0,
        /// Burst enable bit
        BURSTEN: u1,
        /// Wait signal polarity bit
        WAITPOL: WAITPOL,
        /// WRAPMOD
        WRAPMOD: u1,
        /// Wait timing configuration
        WAITCFG: WAITCFG,
        /// Write enable bit
        WREN: u1,
        /// Wait enable bit
        WAITEN: u1,
        /// Extended mode enable
        EXTMOD: u1,
        /// Wait signal during asynchronous transfers
        ASYNCWAIT: u1,
        /// CRAM page size
        CPSIZE: CPSIZE,
        /// Write burst enable
        CBURSTRW: u1,
        padding: u12 = 0,
    }),
    /// SRAM/NOR-Flash chip-select timing register 1-4
    /// offset: 0x04
    BTR: mmio.Mmio(packed struct(u32) {
        /// Address setup phase duration
        ADDSET: u4,
        /// Address-hold phase duration
        ADDHLD: u4,
        /// Data-phase duration
        DATAST: u8,
        /// Bus turnaround phase duration
        BUSTURN: u4,
        /// Clock divide ratio (for FMC_CLK signal)
        CLKDIV: u4,
        /// Data latency for synchronous memory
        DATLAT: u4,
        /// Access mode
        ACCMOD: ACCMOD,
        padding: u2 = 0,
    }),
    /// offset: 0x08
    reserved8: [252]u8,
    /// SRAM/NOR-Flash write timing registers 1-4
    /// offset: 0x104
    BWTR: mmio.Mmio(packed struct(u32) {
        /// Address setup phase duration
        ADDSET: u4,
        /// Address-hold phase duration
        ADDHLD: u4,
        /// Data-phase duration
        DATAST: u8,
        /// Bus turnaround phase duration
        BUSTURN: u4,
        reserved28: u8 = 0,
        /// Access mode
        ACCMOD: ACCMOD,
        padding: u2 = 0,
    }),
};
