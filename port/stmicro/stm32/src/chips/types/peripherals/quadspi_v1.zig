const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// QuadSPI interface
pub const QUADSPI = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Enable
        EN: u1,
        /// Abort request
        ABORT: u1,
        /// DMA enable (not available on all chips!)
        DMAEN: u1,
        /// Timeout counter enable
        TCEN: u1,
        /// Sample shift
        SSHIFT: u1,
        reserved6: u1 = 0,
        /// Dual-flash mode
        DFM: u1,
        /// FLASH memory selection
        FSEL: u1,
        /// IFO threshold level
        FTHRES: u4,
        reserved16: u4 = 0,
        /// Transfer error interrupt enable
        TEIE: u1,
        /// Transfer complete interrupt enable
        TCIE: u1,
        /// FIFO threshold interrupt enable
        FTIE: u1,
        /// Status match interrupt enable
        SMIE: u1,
        /// TimeOut interrupt enable
        TOIE: u1,
        reserved22: u1 = 0,
        /// Automatic poll mode stop
        APMS: u1,
        /// Polling match mode
        PMM: u1,
        /// Clock prescaler
        PRESCALER: u8,
    }),
    /// device configuration register
    /// offset: 0x04
    DCR: mmio.Mmio(packed struct(u32) {
        /// Mode 0 / mode 3
        CKMODE: u1,
        reserved8: u7 = 0,
        /// Chip select high time
        CSHT: u3,
        reserved16: u5 = 0,
        /// FLASH memory size
        FSIZE: u5,
        padding: u11 = 0,
    }),
    /// status register
    /// offset: 0x08
    SR: mmio.Mmio(packed struct(u32) {
        /// Transfer error flag
        TEF: u1,
        /// Transfer complete flag
        TCF: u1,
        /// FIFO threshold flag
        FTF: u1,
        /// Status match flag
        SMF: u1,
        /// Timeout flag
        TOF: u1,
        /// Busy
        BUSY: u1,
        reserved8: u2 = 0,
        /// FIFO level
        FLEVEL: u7,
        padding: u17 = 0,
    }),
    /// flag clear register
    /// offset: 0x0c
    FCR: mmio.Mmio(packed struct(u32) {
        /// Clear transfer error flag
        CTEF: u1,
        /// Clear transfer complete flag
        CTCF: u1,
        reserved3: u1 = 0,
        /// Clear status match flag
        CSMF: u1,
        /// Clear timeout flag
        CTOF: u1,
        padding: u27 = 0,
    }),
    /// data length register
    /// offset: 0x10
    DLR: mmio.Mmio(packed struct(u32) {
        /// Data length
        DL: u32,
    }),
    /// communication configuration register
    /// offset: 0x14
    CCR: mmio.Mmio(packed struct(u32) {
        /// Instruction
        INSTRUCTION: u8,
        /// Instruction mode
        IMODE: u2,
        /// Address mode
        ADMODE: u2,
        /// Address size
        ADSIZE: u2,
        /// Alternate bytes mode
        ABMODE: u2,
        /// Alternate bytes size
        ABSIZE: u2,
        /// Number of dummy cycles
        DCYC: u5,
        reserved24: u1 = 0,
        /// Data mode
        DMODE: u2,
        /// Functional mode
        FMODE: u2,
        /// Send instruction only once mode
        SIOO: u1,
        /// Free-running clock mode (not available on all chips!)
        FRCM: u1,
        /// DDR hold half cycle
        DHHC: u1,
        /// Double data rate mode
        DDRM: u1,
    }),
    /// address register
    /// offset: 0x18
    AR: mmio.Mmio(packed struct(u32) {
        /// Address
        ADDRESS: u32,
    }),
    /// ABR
    /// offset: 0x1c
    ABR: mmio.Mmio(packed struct(u32) {
        /// ALTERNATE
        ALTERNATE: u32,
    }),
    /// data register
    /// offset: 0x20
    DR: mmio.Mmio(packed struct(u32) {
        /// Data
        DATA: u32,
    }),
    /// polling status mask register
    /// offset: 0x24
    PSMKR: mmio.Mmio(packed struct(u32) {
        /// Status mask
        MASK: u32,
    }),
    /// polling status match register
    /// offset: 0x28
    PSMAR: mmio.Mmio(packed struct(u32) {
        /// Status match
        MATCH: u32,
    }),
    /// polling interval register
    /// offset: 0x2c
    PIR: mmio.Mmio(packed struct(u32) {
        /// Polling interval
        INTERVAL: u16,
        padding: u16 = 0,
    }),
    /// low-power timeout register
    /// offset: 0x30
    LPTR: mmio.Mmio(packed struct(u32) {
        /// Timeout period
        TIMEOUT: u16,
        padding: u16 = 0,
    }),
};
