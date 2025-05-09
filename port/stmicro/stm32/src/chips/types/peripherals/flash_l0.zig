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
        reserved3: u1 = 0,
        /// Flash mode during Sleep
        SLEEP_PD: u1,
        /// Flash mode during Run
        RUN_PD: u1,
        /// Disable Buffer
        DISAB_BUF: u1,
        /// Pre-read data address
        PRE_READ: u1,
        padding: u25 = 0,
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
        FIX: u1,
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
        reserved14: u2 = 0,
        /// RDERR
        RDERR: u1,
        reserved16: u1 = 0,
        /// NOTZEROERR
        NOTZEROERR: u1,
        /// FWWERR
        FWWERR: u1,
        padding: u14 = 0,
    }),
    /// Option byte register
    /// offset: 0x1c
    OPTR: mmio.Mmio(packed struct(u32) {
        /// Read protection
        RDPROT: u8,
        /// Selection of protection mode of WPR bits
        WPRMOD: u1,
        reserved16: u7 = 0,
        /// BOR_LEV
        BOR_LEV: u4,
        padding: u12 = 0,
    }),
    /// Write Protection Register 1
    /// offset: 0x20
    WRPROT: mmio.Mmio(packed struct(u32) {
        /// (1/32 of WRPROT) Write Protection
        @"WRPROT[0]": u1,
        /// (2/32 of WRPROT) Write Protection
        @"WRPROT[1]": u1,
        /// (3/32 of WRPROT) Write Protection
        @"WRPROT[2]": u1,
        /// (4/32 of WRPROT) Write Protection
        @"WRPROT[3]": u1,
        /// (5/32 of WRPROT) Write Protection
        @"WRPROT[4]": u1,
        /// (6/32 of WRPROT) Write Protection
        @"WRPROT[5]": u1,
        /// (7/32 of WRPROT) Write Protection
        @"WRPROT[6]": u1,
        /// (8/32 of WRPROT) Write Protection
        @"WRPROT[7]": u1,
        /// (9/32 of WRPROT) Write Protection
        @"WRPROT[8]": u1,
        /// (10/32 of WRPROT) Write Protection
        @"WRPROT[9]": u1,
        /// (11/32 of WRPROT) Write Protection
        @"WRPROT[10]": u1,
        /// (12/32 of WRPROT) Write Protection
        @"WRPROT[11]": u1,
        /// (13/32 of WRPROT) Write Protection
        @"WRPROT[12]": u1,
        /// (14/32 of WRPROT) Write Protection
        @"WRPROT[13]": u1,
        /// (15/32 of WRPROT) Write Protection
        @"WRPROT[14]": u1,
        /// (16/32 of WRPROT) Write Protection
        @"WRPROT[15]": u1,
        /// (17/32 of WRPROT) Write Protection
        @"WRPROT[16]": u1,
        /// (18/32 of WRPROT) Write Protection
        @"WRPROT[17]": u1,
        /// (19/32 of WRPROT) Write Protection
        @"WRPROT[18]": u1,
        /// (20/32 of WRPROT) Write Protection
        @"WRPROT[19]": u1,
        /// (21/32 of WRPROT) Write Protection
        @"WRPROT[20]": u1,
        /// (22/32 of WRPROT) Write Protection
        @"WRPROT[21]": u1,
        /// (23/32 of WRPROT) Write Protection
        @"WRPROT[22]": u1,
        /// (24/32 of WRPROT) Write Protection
        @"WRPROT[23]": u1,
        /// (25/32 of WRPROT) Write Protection
        @"WRPROT[24]": u1,
        /// (26/32 of WRPROT) Write Protection
        @"WRPROT[25]": u1,
        /// (27/32 of WRPROT) Write Protection
        @"WRPROT[26]": u1,
        /// (28/32 of WRPROT) Write Protection
        @"WRPROT[27]": u1,
        /// (29/32 of WRPROT) Write Protection
        @"WRPROT[28]": u1,
        /// (30/32 of WRPROT) Write Protection
        @"WRPROT[29]": u1,
        /// (31/32 of WRPROT) Write Protection
        @"WRPROT[30]": u1,
        /// (32/32 of WRPROT) Write Protection
        @"WRPROT[31]": u1,
    }),
    /// offset: 0x24
    reserved36: [92]u8,
    /// Write Protection Register 2
    /// offset: 0x80
    WRPROT2: mmio.Mmio(packed struct(u32) {
        /// (1/32 of WRPROT) Write Protection
        @"WRPROT[0]": u1,
        /// (2/32 of WRPROT) Write Protection
        @"WRPROT[1]": u1,
        /// (3/32 of WRPROT) Write Protection
        @"WRPROT[2]": u1,
        /// (4/32 of WRPROT) Write Protection
        @"WRPROT[3]": u1,
        /// (5/32 of WRPROT) Write Protection
        @"WRPROT[4]": u1,
        /// (6/32 of WRPROT) Write Protection
        @"WRPROT[5]": u1,
        /// (7/32 of WRPROT) Write Protection
        @"WRPROT[6]": u1,
        /// (8/32 of WRPROT) Write Protection
        @"WRPROT[7]": u1,
        /// (9/32 of WRPROT) Write Protection
        @"WRPROT[8]": u1,
        /// (10/32 of WRPROT) Write Protection
        @"WRPROT[9]": u1,
        /// (11/32 of WRPROT) Write Protection
        @"WRPROT[10]": u1,
        /// (12/32 of WRPROT) Write Protection
        @"WRPROT[11]": u1,
        /// (13/32 of WRPROT) Write Protection
        @"WRPROT[12]": u1,
        /// (14/32 of WRPROT) Write Protection
        @"WRPROT[13]": u1,
        /// (15/32 of WRPROT) Write Protection
        @"WRPROT[14]": u1,
        /// (16/32 of WRPROT) Write Protection
        @"WRPROT[15]": u1,
        /// (17/32 of WRPROT) Write Protection
        @"WRPROT[16]": u1,
        /// (18/32 of WRPROT) Write Protection
        @"WRPROT[17]": u1,
        /// (19/32 of WRPROT) Write Protection
        @"WRPROT[18]": u1,
        /// (20/32 of WRPROT) Write Protection
        @"WRPROT[19]": u1,
        /// (21/32 of WRPROT) Write Protection
        @"WRPROT[20]": u1,
        /// (22/32 of WRPROT) Write Protection
        @"WRPROT[21]": u1,
        /// (23/32 of WRPROT) Write Protection
        @"WRPROT[22]": u1,
        /// (24/32 of WRPROT) Write Protection
        @"WRPROT[23]": u1,
        /// (25/32 of WRPROT) Write Protection
        @"WRPROT[24]": u1,
        /// (26/32 of WRPROT) Write Protection
        @"WRPROT[25]": u1,
        /// (27/32 of WRPROT) Write Protection
        @"WRPROT[26]": u1,
        /// (28/32 of WRPROT) Write Protection
        @"WRPROT[27]": u1,
        /// (29/32 of WRPROT) Write Protection
        @"WRPROT[28]": u1,
        /// (30/32 of WRPROT) Write Protection
        @"WRPROT[29]": u1,
        /// (31/32 of WRPROT) Write Protection
        @"WRPROT[30]": u1,
        /// (32/32 of WRPROT) Write Protection
        @"WRPROT[31]": u1,
    }),
};
