const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Flash
pub const FLASH = extern struct {
    /// Access control register
    /// offset: 0x00
    ACR: mmio.Mmio(packed struct(u32) {
        /// Latency
        LATENCY: u1,
        /// Prefetch enable
        PRFTEN: u1,
        /// 64-bit access
        ACC64: u1,
        /// Flash mode during Sleep
        SLEEP_PD: u1,
        /// Flash mode during Run
        RUN_PD: u1,
        padding: u27 = 0,
    }),
    /// Program/erase control register
    /// offset: 0x04
    PECR: mmio.Mmio(packed struct(u32) {
        /// FLASH_PECR and data EEPROM lock
        PELOCK: u1,
        /// Program memory lock
        PRGLOCK: u1,
        /// Option bytes block lock
        OPTLOCK: u1,
        /// Program memory selection
        PROG: u1,
        /// Data EEPROM selection
        DATA: u1,
        reserved8: u3 = 0,
        /// Fixed time data write for Byte, Half Word and Word programming
        FTDW: u1,
        /// Page or Double Word erase mode
        ERASE: u1,
        /// Half Page/Double Word programming mode
        FPRG: u1,
        reserved15: u4 = 0,
        /// Parallel bank mode
        PARALLELBANK: u1,
        /// End of programming interrupt enable
        EOPIE: u1,
        /// Error interrupt enable
        ERRIE: u1,
        /// Launch the option byte loading
        OBL_LAUNCH: u1,
        padding: u13 = 0,
    }),
    /// Power down key register
    /// offset: 0x08
    PDKEYR: u32,
    /// Program/erase key register
    /// offset: 0x0c
    PEKEYR: u32,
    /// Program memory key register
    /// offset: 0x10
    PRGKEYR: u32,
    /// Option byte key register
    /// offset: 0x14
    OPTKEYR: u32,
    /// Status register
    /// offset: 0x18
    SR: mmio.Mmio(packed struct(u32) {
        /// Write/erase operations in progress
        BSY: u1,
        /// End of operation
        EOP: u1,
        /// End of high voltage
        ENDHV: u1,
        /// Flash memory module ready after low power mode
        READY: u1,
        reserved8: u4 = 0,
        /// Write protected error
        WRPERR: u1,
        /// Programming alignment error
        PGAERR: u1,
        /// Size error
        SIZERR: u1,
        /// Option validity error
        OPTVERR: u1,
        /// Option UserValidity Error
        OPTVERRUSR: u1,
        padding: u19 = 0,
    }),
    /// Option byte register
    /// offset: 0x1c
    OBR: mmio.Mmio(packed struct(u32) {
        /// Read protection
        RDPRT: u8,
        reserved16: u8 = 0,
        /// BOR_LEV
        BOR_LEV: u4,
        /// IWDG_SW
        IWDG_SW: u1,
        /// nRTS_STOP
        nRTS_STOP: u1,
        /// nRST_STDBY
        nRST_STDBY: u1,
        /// Boot From Bank 2
        BFB2: u1,
        padding: u8 = 0,
    }),
    /// Write protection register
    /// offset: 0x20
    WRPR1: mmio.Mmio(packed struct(u32) {
        /// Write protection
        WRP1: u32,
    }),
    /// offset: 0x24
    reserved36: [92]u8,
    /// Write protection register
    /// offset: 0x80
    WRPR2: mmio.Mmio(packed struct(u32) {
        /// WRP2
        WRP2: u32,
    }),
    /// Write protection register
    /// offset: 0x84
    WRPR3: mmio.Mmio(packed struct(u32) {
        /// WRP3
        WRP3: u32,
    }),
};
