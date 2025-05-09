const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Secure digital input/output interface
pub const SDMMC = extern struct {
    /// power control register
    /// offset: 0x00
    POWER: mmio.Mmio(packed struct(u32) {
        /// PWRCTRL
        PWRCTRL: u2,
        padding: u30 = 0,
    }),
    /// SDI clock control register
    /// offset: 0x04
    CLKCR: mmio.Mmio(packed struct(u32) {
        /// Clock divide factor
        CLKDIV: u8,
        /// Clock enable bit
        CLKEN: u1,
        /// Power saving configuration bit
        PWRSAV: u1,
        /// Clock divider bypass enable bit
        BYPASS: u1,
        /// Wide bus mode enable bit
        WIDBUS: u2,
        /// SDIO_CK dephasing selection bit
        NEGEDGE: u1,
        /// HW Flow Control enable
        HWFC_EN: u1,
        padding: u17 = 0,
    }),
    /// argument register
    /// offset: 0x08
    ARGR: mmio.Mmio(packed struct(u32) {
        /// Command argument
        CMDARG: u32,
    }),
    /// command register
    /// offset: 0x0c
    CMDR: mmio.Mmio(packed struct(u32) {
        /// Command index
        CMDINDEX: u6,
        /// Wait for response bits
        WAITRESP: u2,
        /// CPSM waits for interrupt request
        WAITINT: u1,
        /// CPSM Waits for ends of data transfer (CmdPend internal signal)
        WAITPEND: u1,
        /// Command path state machine (CPSM) Enable bit
        CPSMEN: u1,
        /// SD I/O suspend command
        SDIOSuspend: u1,
        padding: u20 = 0,
    }),
    /// command response register
    /// offset: 0x10
    RESPCMDR: mmio.Mmio(packed struct(u32) {
        /// Response command index
        RESPCMD: u6,
        padding: u26 = 0,
    }),
    /// response 1..4 register
    /// offset: 0x14
    RESPR: [4]mmio.Mmio(packed struct(u32) {
        /// see Table 132
        CARDSTATUS: u32,
    }),
    /// data timer register
    /// offset: 0x24
    DTIMER: mmio.Mmio(packed struct(u32) {
        /// Data timeout period
        DATATIME: u32,
    }),
    /// data length register
    /// offset: 0x28
    DLENR: mmio.Mmio(packed struct(u32) {
        /// Data length value
        DATALENGTH: u25,
        padding: u7 = 0,
    }),
    /// data control register
    /// offset: 0x2c
    DCTRL: mmio.Mmio(packed struct(u32) {
        /// DTEN
        DTEN: u1,
        /// Data transfer direction selection
        DTDIR: u1,
        /// Data transfer mode selection 1: Stream or SDIO multibyte data transfer
        DTMODE: u1,
        /// DMA enable bit
        DMAEN: u1,
        /// Data block size
        DBLOCKSIZE: u4,
        /// Read wait start
        RWSTART: u1,
        /// Read wait stop
        RWSTOP: u1,
        /// Read wait mode
        RWMOD: u1,
        /// SD I/O enable functions
        SDIOEN: u1,
        padding: u20 = 0,
    }),
    /// data counter register
    /// offset: 0x30
    DCNTR: mmio.Mmio(packed struct(u32) {
        /// Data count value
        DATACOUNT: u25,
        padding: u7 = 0,
    }),
    /// status register
    /// offset: 0x34
    STAR: mmio.Mmio(packed struct(u32) {
        /// Command response received (CRC check failed)
        CCRCFAIL: u1,
        /// Data block sent/received (CRC check failed)
        DCRCFAIL: u1,
        /// Command response timeout
        CTIMEOUT: u1,
        /// Data timeout
        DTIMEOUT: u1,
        /// Transmit FIFO underrun error
        TXUNDERR: u1,
        /// Received FIFO overrun error
        RXOVERR: u1,
        /// Command response received (CRC check passed)
        CMDREND: u1,
        /// Command sent (no response required)
        CMDSENT: u1,
        /// Data end (data counter, SDIDCOUNT, is zero)
        DATAEND: u1,
        /// Start bit not detected on all data signals in wide bus mode
        STBITERR: u1,
        /// Data block sent/received (CRC check passed)
        DBCKEND: u1,
        /// Command transfer in progress
        CMDACT: u1,
        /// Data transmit in progress
        TXACT: u1,
        /// Data receive in progress
        RXACT: u1,
        /// Transmit FIFO half empty: at least 8 words can be written into the FIFO
        TXFIFOHE: u1,
        /// Receive FIFO half full: there are at least 8 words in the FIFO
        RXFIFOHF: u1,
        /// Transmit FIFO full
        TXFIFOF: u1,
        /// Receive FIFO full
        RXFIFOF: u1,
        /// Transmit FIFO empty
        TXFIFOE: u1,
        /// Receive FIFO empty
        RXFIFOE: u1,
        /// Data available in transmit FIFO
        TXDAVL: u1,
        /// Data available in receive FIFO
        RXDAVL: u1,
        /// SDIO interrupt received
        SDIOIT: u1,
        padding: u9 = 0,
    }),
    /// interrupt clear register
    /// offset: 0x38
    ICR: mmio.Mmio(packed struct(u32) {
        /// CCRCFAIL flag clear bit
        CCRCFAILC: u1,
        /// DCRCFAIL flag clear bit
        DCRCFAILC: u1,
        /// CTIMEOUT flag clear bit
        CTIMEOUTC: u1,
        /// DTIMEOUT flag clear bit
        DTIMEOUTC: u1,
        /// TXUNDERR flag clear bit
        TXUNDERRC: u1,
        /// RXOVERR flag clear bit
        RXOVERRC: u1,
        /// CMDREND flag clear bit
        CMDRENDC: u1,
        /// CMDSENT flag clear bit
        CMDSENTC: u1,
        /// DATAEND flag clear bit
        DATAENDC: u1,
        /// STBITERR flag clear bit
        STBITERRC: u1,
        /// DBCKEND flag clear bit
        DBCKENDC: u1,
        reserved22: u11 = 0,
        /// SDIOIT flag clear bit
        SDIOITC: u1,
        padding: u9 = 0,
    }),
    /// mask register
    /// offset: 0x3c
    MASKR: mmio.Mmio(packed struct(u32) {
        /// Command CRC fail interrupt enable
        CCRCFAILIE: u1,
        /// Data CRC fail interrupt enable
        DCRCFAILIE: u1,
        /// Command timeout interrupt enable
        CTIMEOUTIE: u1,
        /// Data timeout interrupt enable
        DTIMEOUTIE: u1,
        /// Tx FIFO underrun error interrupt enable
        TXUNDERRIE: u1,
        /// Rx FIFO overrun error interrupt enable
        RXOVERRIE: u1,
        /// Command response received interrupt enable
        CMDRENDIE: u1,
        /// Command sent interrupt enable
        CMDSENTIE: u1,
        /// Data end interrupt enable
        DATAENDIE: u1,
        /// STBITERR interrupt enable
        STBITERRE: u1,
        /// Data block end interrupt enable
        DBCKENDIE: u1,
        /// Command acting interrupt enable
        CMDACTIE: u1,
        /// Data transmit acting interrupt enable
        TXACTIE: u1,
        /// Data receive acting interrupt enable
        RXACTIE: u1,
        /// Tx FIFO half empty interrupt enable
        TXFIFOHEIE: u1,
        /// Rx FIFO half full interrupt enable
        RXFIFOHFIE: u1,
        /// Tx FIFO full interrupt enable
        TXFIFOFIE: u1,
        /// Rx FIFO full interrupt enable
        RXFIFOFIE: u1,
        /// Tx FIFO empty interrupt enable
        TXFIFOEIE: u1,
        /// Rx FIFO empty interrupt enable
        RXFIFOEIE: u1,
        /// Data available in Tx FIFO interrupt enable
        TXDAVLIE: u1,
        /// Data available in Rx FIFO interrupt enable
        RXDAVLIE: u1,
        /// SDIO mode interrupt received interrupt enable
        SDIOITIE: u1,
        padding: u9 = 0,
    }),
    /// offset: 0x40
    reserved64: [8]u8,
    /// FIFO counter register
    /// offset: 0x48
    FIFOCNT: mmio.Mmio(packed struct(u32) {
        /// Remaining number of words to be written to or read from the FIFO
        FIFOCOUNT: u24,
        padding: u8 = 0,
    }),
    /// offset: 0x4c
    reserved76: [52]u8,
    /// data FIFO register
    /// offset: 0x80
    FIFOR: mmio.Mmio(packed struct(u32) {
        /// Receive and transmit FIFO data
        FIFOData: u32,
    }),
};
