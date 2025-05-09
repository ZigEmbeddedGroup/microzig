const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

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

pub const CAS = enum(u2) {
    /// 1 cycle
    Clocks1 = 0x1,
    /// 2 cycles
    Clocks2 = 0x2,
    /// 3 cycles
    Clocks3 = 0x3,
    _,
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

pub const MODE = enum(u3) {
    /// Normal Mode
    Normal = 0x0,
    /// Clock Configuration Enable
    ClockConfigurationEnable = 0x1,
    /// PALL (All Bank Precharge) command
    PALL = 0x2,
    /// Auto-refresh command
    AutoRefreshCommand = 0x3,
    /// Load Mode Resgier
    LoadModeRegister = 0x4,
    /// Self-refresh command
    SelfRefreshCommand = 0x5,
    /// Power-down command
    PowerDownCommand = 0x6,
    _,
};

pub const MODES = enum(u2) {
    /// Normal Mode
    Normal = 0x0,
    /// Self-refresh mode
    SelfRefresh = 0x1,
    /// Power-down mode
    PowerDown = 0x2,
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

pub const NB = enum(u1) {
    /// Two internal Banks
    NB2 = 0x0,
    /// Four internal Banks
    NB4 = 0x1,
};

pub const NC = enum(u2) {
    /// 8 bits
    Bits8 = 0x0,
    /// 9 bits
    Bits9 = 0x1,
    /// 10 bits
    Bits10 = 0x2,
    /// 11 bits
    Bits11 = 0x3,
};

pub const NR = enum(u2) {
    /// 11 bits
    Bits11 = 0x0,
    /// 12 bits
    Bits12 = 0x1,
    /// 13 bits
    Bits13 = 0x2,
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

pub const RPIPE = enum(u2) {
    /// No clock cycle delay
    NoDelay = 0x0,
    /// One clock cycle delay
    Clocks1 = 0x1,
    /// Two clock cycles delay
    Clocks2 = 0x2,
    _,
};

pub const SDCLK = enum(u2) {
    /// SDCLK clock disabled
    Disabled = 0x0,
    /// SDCLK period = 2 x HCLK period
    Div2 = 0x2,
    /// SDCLK period = 3 x HCLK period
    Div3 = 0x3,
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

/// Flexible memory controller
pub const FMC = extern struct {
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
        /// Continuous clock enable
        CCLKEN: u1,
        padding: u11 = 0,
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
    /// offset: 0x0c
    reserved12: [84]u8,
    /// PC Card/NAND Flash control register 2-4
    /// offset: 0x60
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
    /// FIFO status and interrupt register 2-4
    /// offset: 0x64
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
    /// Common memory space timing register 2-4
    /// offset: 0x68
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
    /// Attribute memory space timing register 2-4
    /// offset: 0x6c
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
    /// offset: 0x70
    reserved112: [4]u8,
    /// ECC result register 2-3
    /// offset: 0x74
    ECCR: mmio.Mmio(packed struct(u32) {
        /// ECC computation result value
        ECC: u32,
    }),
    /// offset: 0x78
    reserved120: [56]u8,
    /// I/O space timing register 4
    /// offset: 0xb0
    PIO4: mmio.Mmio(packed struct(u32) {
        /// IOSETx
        IOSETx: u8,
        /// IOWAITx
        IOWAITx: u8,
        /// IOHOLDx
        IOHOLDx: u8,
        /// IOHIZx
        IOHIZx: u8,
    }),
    /// offset: 0xb4
    reserved180: [80]u8,
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
    /// offset: 0x108
    reserved264: [56]u8,
    /// SDRAM Control Register 1-2
    /// offset: 0x140
    SDCR: [2]mmio.Mmio(packed struct(u32) {
        /// Number of column address bits
        NC: NC,
        /// Number of row address bits
        NR: NR,
        /// Memory data bus width
        MWID: MWID,
        /// Number of internal banks
        NB: NB,
        /// CAS latency
        CAS: CAS,
        /// Write protection
        WP: u1,
        /// SDRAM clock configuration
        SDCLK: SDCLK,
        /// Burst read
        RBURST: u1,
        /// Read pipe
        RPIPE: RPIPE,
        padding: u17 = 0,
    }),
    /// SDRAM Timing register 1-2
    /// offset: 0x148
    SDTR: [2]mmio.Mmio(packed struct(u32) {
        /// Load Mode Register to Active
        TMRD: u4,
        /// Exit self-refresh delay
        TXSR: u4,
        /// Self refresh time
        TRAS: u4,
        /// Row cycle delay
        TRC: u4,
        /// Recovery delay
        TWR: u4,
        /// Row precharge delay
        TRP: u4,
        /// Row to column delay
        TRCD: u4,
        padding: u4 = 0,
    }),
    /// SDRAM Command Mode register
    /// offset: 0x150
    SDCMR: mmio.Mmio(packed struct(u32) {
        /// Command mode
        MODE: MODE,
        /// Command target bank 2
        CTB2: u1,
        /// Command target bank 1
        CTB1: u1,
        /// Number of Auto-refresh
        NRFS: u4,
        /// Mode Register definition
        MRD: u13,
        padding: u10 = 0,
    }),
    /// SDRAM Refresh Timer register
    /// offset: 0x154
    SDRTR: mmio.Mmio(packed struct(u32) {
        /// Clear Refresh error flag
        CRE: u1,
        /// Refresh Timer Count
        COUNT: u13,
        /// RES Interrupt Enable
        REIE: u1,
        padding: u17 = 0,
    }),
    /// SDRAM Status register
    /// offset: 0x158
    SDSR: mmio.Mmio(packed struct(u32) {
        /// Refresh error flag
        RE: u1,
        /// Status Mode for Bank 1
        MODES1: MODES,
        /// Status Mode for Bank 2
        MODES2: MODES,
        /// Busy status
        BUSY: u1,
        padding: u26 = 0,
    }),
};
