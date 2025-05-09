const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

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

pub const ECCPS = enum(u3) {
    /// ECC page size 256 bytes
    Bytes256 = 0x0,
    /// ECC page size 512 bytes
    Bytes512 = 0x1,
    /// ECC page size 1024 bytes
    Bytes1024 = 0x2,
    /// ECC page size 2048 bytes
    Bytes2048 = 0x3,
    /// ECC page size 4096 bytes
    Bytes4096 = 0x4,
    /// ECC page size 8192 bytes
    Bytes8192 = 0x5,
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

pub const PTYP = enum(u1) {
    /// NAND Flash
    NANDFlash = 0x1,
    _,
};

pub const PWID = enum(u2) {
    /// External memory device width 8 bits
    Bits8 = 0x0,
    /// External memory device width 16 bits
    Bits16 = 0x1,
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
    /// SRAM/NOR-Flash chip-select control register 1
    /// offset: 0x00
    BCR1: mmio.Mmio(packed struct(u32) {
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
        reserved11: u1 = 0,
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
        /// Continuous clock enable
        CCLKEN: u1,
        /// Write FIFO disable
        WFDIS: u1,
        padding: u10 = 0,
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
    /// SRAM/NOR-Flash chip-select control register 2-4
    /// offset: 0x08
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
        reserved11: u1 = 0,
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
    /// offset: 0x0c
    reserved12: [116]u8,
    /// PC Card/NAND Flash control register
    /// offset: 0x80
    PCR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Wait feature enable bit
        PWAITEN: u1,
        /// NAND Flash memory bank enable bit
        PBKEN: u1,
        /// Memory type
        PTYP: PTYP,
        /// Data bus width
        PWID: PWID,
        /// ECC computation logic enable bit
        ECCEN: u1,
        reserved9: u2 = 0,
        /// CLE to RE delay
        TCLR: u4,
        /// ALE to RE delay
        TAR: u4,
        /// ECC page size
        ECCPS: ECCPS,
        padding: u12 = 0,
    }),
    /// FIFO status and interrupt register
    /// offset: 0x84
    SR: mmio.Mmio(packed struct(u32) {
        /// Interrupt rising edge status
        IRS: u1,
        /// Interrupt high-level status
        ILS: u1,
        /// Interrupt falling edge status
        IFS: u1,
        /// Interrupt rising edge detection enable bit
        IREN: u1,
        /// Interrupt high-level detection enable bit
        ILEN: u1,
        /// Interrupt falling edge detection enable bit
        IFEN: u1,
        /// FIFO empty status
        FEMPT: u1,
        padding: u25 = 0,
    }),
    /// Common memory space timing register
    /// offset: 0x88
    PMEM: mmio.Mmio(packed struct(u32) {
        /// Common memory x setup time
        MEMSET: u8,
        /// Common memory wait time
        MEMWAIT: u8,
        /// Common memory hold time
        MEMHOLD: u8,
        /// Common memory x data bus Hi-Z time
        MEMHIZ: u8,
    }),
    /// Attribute memory space timing register
    /// offset: 0x8c
    PATT: mmio.Mmio(packed struct(u32) {
        /// Attribute memory setup time
        ATTSET: u8,
        /// Attribute memory wait time
        ATTWAIT: u8,
        /// Attribute memory hold time
        ATTHOLD: u8,
        /// Attribute memory data bus Hi-Z time
        ATTHIZ: u8,
    }),
    /// offset: 0x90
    reserved144: [4]u8,
    /// ECC result register
    /// offset: 0x94
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC computation result value
        ECC: u32,
    }),
    /// offset: 0x98
    reserved152: [108]u8,
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
