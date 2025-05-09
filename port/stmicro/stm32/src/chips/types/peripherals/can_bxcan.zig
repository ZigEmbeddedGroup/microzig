const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const IDE = enum(u1) {
    /// Standard identifier
    Standard = 0x0,
    /// Extended identifier
    Extended = 0x1,
};

pub const LEC = enum(u3) {
    /// No Error
    NoError = 0x0,
    /// Stuff Error
    Stuff = 0x1,
    /// Form Error
    Form = 0x2,
    /// Acknowledgment Error
    Ack = 0x3,
    /// Bit recessive Error
    BitRecessive = 0x4,
    /// Bit dominant Error
    BitDominant = 0x5,
    /// CRC Error
    Crc = 0x6,
    /// Set by software
    Custom = 0x7,
};

pub const RTR = enum(u1) {
    /// Data frame
    Data = 0x0,
    /// Remote frame
    Remote = 0x1,
};

pub const SILM = enum(u1) {
    /// Normal operation
    Normal = 0x0,
    /// Silent Mode
    Silent = 0x1,
};

/// Controller area network
pub const CAN = extern struct {
    /// master control register
    /// offset: 0x00
    MCR: mmio.Mmio(packed struct(u32) {
        /// INRQ
        INRQ: u1,
        /// SLEEP
        SLEEP: u1,
        /// TXFP
        TXFP: u1,
        /// RFLM
        RFLM: u1,
        /// NART
        NART: u1,
        /// AWUM
        AWUM: u1,
        /// ABOM
        ABOM: u1,
        /// TTCM
        TTCM: u1,
        reserved15: u7 = 0,
        /// RESET
        RESET: u1,
        /// DBF
        DBF: u1,
        padding: u15 = 0,
    }),
    /// master status register
    /// offset: 0x04
    MSR: mmio.Mmio(packed struct(u32) {
        /// INAK
        INAK: u1,
        /// SLAK
        SLAK: u1,
        /// ERRI
        ERRI: u1,
        /// WKUI
        WKUI: u1,
        /// SLAKI
        SLAKI: u1,
        reserved8: u3 = 0,
        /// TXM
        TXM: u1,
        /// RXM
        RXM: u1,
        /// SAMP
        SAMP: u1,
        /// RX
        RX: u1,
        padding: u20 = 0,
    }),
    /// transmit status register
    /// offset: 0x08
    TSR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of RQCP) RQCP0
        @"RQCP[0]": u1,
        /// (1/3 of TXOK) TXOK0
        @"TXOK[0]": u1,
        /// (1/3 of ALST) ALST0
        @"ALST[0]": u1,
        /// (1/3 of TERR) TERR0
        @"TERR[0]": u1,
        reserved7: u3 = 0,
        /// (1/3 of ABRQ) ABRQ0
        @"ABRQ[0]": u1,
        /// (2/3 of RQCP) RQCP0
        @"RQCP[1]": u1,
        /// (2/3 of TXOK) TXOK0
        @"TXOK[1]": u1,
        /// (2/3 of ALST) ALST0
        @"ALST[1]": u1,
        /// (2/3 of TERR) TERR0
        @"TERR[1]": u1,
        reserved15: u3 = 0,
        /// (2/3 of ABRQ) ABRQ0
        @"ABRQ[1]": u1,
        /// (3/3 of RQCP) RQCP0
        @"RQCP[2]": u1,
        /// (3/3 of TXOK) TXOK0
        @"TXOK[2]": u1,
        /// (3/3 of ALST) ALST0
        @"ALST[2]": u1,
        /// (3/3 of TERR) TERR0
        @"TERR[2]": u1,
        reserved23: u3 = 0,
        /// (3/3 of ABRQ) ABRQ0
        @"ABRQ[2]": u1,
        /// CODE
        CODE: u2,
        /// (1/3 of TME) Lowest priority flag for mailbox 0
        @"TME[0]": u1,
        /// (2/3 of TME) Lowest priority flag for mailbox 0
        @"TME[1]": u1,
        /// (3/3 of TME) Lowest priority flag for mailbox 0
        @"TME[2]": u1,
        /// (1/3 of LOW) Lowest priority flag for mailbox 0
        @"LOW[0]": u1,
        /// (2/3 of LOW) Lowest priority flag for mailbox 0
        @"LOW[1]": u1,
        /// (3/3 of LOW) Lowest priority flag for mailbox 0
        @"LOW[2]": u1,
    }),
    /// receive FIFO 0 register
    /// offset: 0x0c
    RFR: [2]mmio.Mmio(packed struct(u32) {
        /// FMP0
        FMP: u2,
        reserved3: u1 = 0,
        /// FULL0
        FULL: u1,
        /// FOVR0
        FOVR: u1,
        /// RFOM0
        RFOM: u1,
        padding: u26 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x14
    IER: mmio.Mmio(packed struct(u32) {
        /// TMEIE
        TMEIE: u1,
        /// (1/2 of FMPIE) FMPIE0
        @"FMPIE[0]": u1,
        /// (1/2 of FFIE) FFIE0
        @"FFIE[0]": u1,
        /// (1/2 of FOVIE) FOVIE0
        @"FOVIE[0]": u1,
        /// (2/2 of FMPIE) FMPIE0
        @"FMPIE[1]": u1,
        /// (2/2 of FFIE) FFIE0
        @"FFIE[1]": u1,
        /// (2/2 of FOVIE) FOVIE0
        @"FOVIE[1]": u1,
        reserved8: u1 = 0,
        /// EWGIE
        EWGIE: u1,
        /// EPVIE
        EPVIE: u1,
        /// BOFIE
        BOFIE: u1,
        /// LECIE
        LECIE: u1,
        reserved15: u3 = 0,
        /// ERRIE
        ERRIE: u1,
        /// WKUIE
        WKUIE: u1,
        /// SLKIE
        SLKIE: u1,
        padding: u14 = 0,
    }),
    /// error status register
    /// offset: 0x18
    ESR: mmio.Mmio(packed struct(u32) {
        /// EWGF
        EWGF: u1,
        /// EPVF
        EPVF: u1,
        /// BOFF
        BOFF: u1,
        reserved4: u1 = 0,
        /// LEC
        LEC: LEC,
        reserved16: u9 = 0,
        /// TEC
        TEC: u8,
        /// REC
        REC: u8,
    }),
    /// bit timing register
    /// offset: 0x1c
    BTR: mmio.Mmio(packed struct(u32) {
        /// BRP
        BRP: u10,
        reserved16: u6 = 0,
        /// (1/2 of TS) TS1
        @"TS[0]": u4,
        /// (2/2 of TS) TS1
        @"TS[1]": u4,
        /// SJW
        SJW: u2,
        reserved30: u4 = 0,
        /// Loop Back Mode enabled
        LBKM: u1,
        /// SILM
        SILM: SILM,
    }),
    /// offset: 0x20
    reserved32: [352]u8,
    /// CAN Transmit cluster
    /// offset: 0x180
    TX: u32,
    /// offset: 0x184
    reserved388: [44]u8,
    /// CAN Receive cluster
    /// offset: 0x1b0
    RX: u32,
    /// offset: 0x1b4
    reserved436: [76]u8,
    /// filter master register
    /// offset: 0x200
    FMR: mmio.Mmio(packed struct(u32) {
        /// FINIT
        FINIT: u1,
        reserved8: u7 = 0,
        /// CAN2SB
        CAN2SB: u6,
        padding: u18 = 0,
    }),
    /// filter mode register
    /// offset: 0x204
    FM1R: mmio.Mmio(packed struct(u32) {
        /// (1/28 of FBM) Filter mode
        @"FBM[0]": u1,
        /// (2/28 of FBM) Filter mode
        @"FBM[1]": u1,
        /// (3/28 of FBM) Filter mode
        @"FBM[2]": u1,
        /// (4/28 of FBM) Filter mode
        @"FBM[3]": u1,
        /// (5/28 of FBM) Filter mode
        @"FBM[4]": u1,
        /// (6/28 of FBM) Filter mode
        @"FBM[5]": u1,
        /// (7/28 of FBM) Filter mode
        @"FBM[6]": u1,
        /// (8/28 of FBM) Filter mode
        @"FBM[7]": u1,
        /// (9/28 of FBM) Filter mode
        @"FBM[8]": u1,
        /// (10/28 of FBM) Filter mode
        @"FBM[9]": u1,
        /// (11/28 of FBM) Filter mode
        @"FBM[10]": u1,
        /// (12/28 of FBM) Filter mode
        @"FBM[11]": u1,
        /// (13/28 of FBM) Filter mode
        @"FBM[12]": u1,
        /// (14/28 of FBM) Filter mode
        @"FBM[13]": u1,
        /// (15/28 of FBM) Filter mode
        @"FBM[14]": u1,
        /// (16/28 of FBM) Filter mode
        @"FBM[15]": u1,
        /// (17/28 of FBM) Filter mode
        @"FBM[16]": u1,
        /// (18/28 of FBM) Filter mode
        @"FBM[17]": u1,
        /// (19/28 of FBM) Filter mode
        @"FBM[18]": u1,
        /// (20/28 of FBM) Filter mode
        @"FBM[19]": u1,
        /// (21/28 of FBM) Filter mode
        @"FBM[20]": u1,
        /// (22/28 of FBM) Filter mode
        @"FBM[21]": u1,
        /// (23/28 of FBM) Filter mode
        @"FBM[22]": u1,
        /// (24/28 of FBM) Filter mode
        @"FBM[23]": u1,
        /// (25/28 of FBM) Filter mode
        @"FBM[24]": u1,
        /// (26/28 of FBM) Filter mode
        @"FBM[25]": u1,
        /// (27/28 of FBM) Filter mode
        @"FBM[26]": u1,
        /// (28/28 of FBM) Filter mode
        @"FBM[27]": u1,
        padding: u4 = 0,
    }),
    /// offset: 0x208
    reserved520: [4]u8,
    /// filter scale register
    /// offset: 0x20c
    FS1R: mmio.Mmio(packed struct(u32) {
        /// (1/28 of FSC) Filter scale configuration
        @"FSC[0]": u1,
        /// (2/28 of FSC) Filter scale configuration
        @"FSC[1]": u1,
        /// (3/28 of FSC) Filter scale configuration
        @"FSC[2]": u1,
        /// (4/28 of FSC) Filter scale configuration
        @"FSC[3]": u1,
        /// (5/28 of FSC) Filter scale configuration
        @"FSC[4]": u1,
        /// (6/28 of FSC) Filter scale configuration
        @"FSC[5]": u1,
        /// (7/28 of FSC) Filter scale configuration
        @"FSC[6]": u1,
        /// (8/28 of FSC) Filter scale configuration
        @"FSC[7]": u1,
        /// (9/28 of FSC) Filter scale configuration
        @"FSC[8]": u1,
        /// (10/28 of FSC) Filter scale configuration
        @"FSC[9]": u1,
        /// (11/28 of FSC) Filter scale configuration
        @"FSC[10]": u1,
        /// (12/28 of FSC) Filter scale configuration
        @"FSC[11]": u1,
        /// (13/28 of FSC) Filter scale configuration
        @"FSC[12]": u1,
        /// (14/28 of FSC) Filter scale configuration
        @"FSC[13]": u1,
        /// (15/28 of FSC) Filter scale configuration
        @"FSC[14]": u1,
        /// (16/28 of FSC) Filter scale configuration
        @"FSC[15]": u1,
        /// (17/28 of FSC) Filter scale configuration
        @"FSC[16]": u1,
        /// (18/28 of FSC) Filter scale configuration
        @"FSC[17]": u1,
        /// (19/28 of FSC) Filter scale configuration
        @"FSC[18]": u1,
        /// (20/28 of FSC) Filter scale configuration
        @"FSC[19]": u1,
        /// (21/28 of FSC) Filter scale configuration
        @"FSC[20]": u1,
        /// (22/28 of FSC) Filter scale configuration
        @"FSC[21]": u1,
        /// (23/28 of FSC) Filter scale configuration
        @"FSC[22]": u1,
        /// (24/28 of FSC) Filter scale configuration
        @"FSC[23]": u1,
        /// (25/28 of FSC) Filter scale configuration
        @"FSC[24]": u1,
        /// (26/28 of FSC) Filter scale configuration
        @"FSC[25]": u1,
        /// (27/28 of FSC) Filter scale configuration
        @"FSC[26]": u1,
        /// (28/28 of FSC) Filter scale configuration
        @"FSC[27]": u1,
        padding: u4 = 0,
    }),
    /// offset: 0x210
    reserved528: [4]u8,
    /// filter FIFO assignment register
    /// offset: 0x214
    FFA1R: mmio.Mmio(packed struct(u32) {
        /// (1/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[0]": u1,
        /// (2/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[1]": u1,
        /// (3/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[2]": u1,
        /// (4/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[3]": u1,
        /// (5/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[4]": u1,
        /// (6/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[5]": u1,
        /// (7/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[6]": u1,
        /// (8/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[7]": u1,
        /// (9/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[8]": u1,
        /// (10/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[9]": u1,
        /// (11/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[10]": u1,
        /// (12/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[11]": u1,
        /// (13/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[12]": u1,
        /// (14/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[13]": u1,
        /// (15/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[14]": u1,
        /// (16/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[15]": u1,
        /// (17/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[16]": u1,
        /// (18/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[17]": u1,
        /// (19/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[18]": u1,
        /// (20/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[19]": u1,
        /// (21/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[20]": u1,
        /// (22/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[21]": u1,
        /// (23/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[22]": u1,
        /// (24/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[23]": u1,
        /// (25/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[24]": u1,
        /// (26/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[25]": u1,
        /// (27/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[26]": u1,
        /// (28/28 of FFA) Filter FIFO assignment for filter 0
        @"FFA[27]": u1,
        padding: u4 = 0,
    }),
    /// offset: 0x218
    reserved536: [4]u8,
    /// filter activation register
    /// offset: 0x21c
    FA1R: mmio.Mmio(packed struct(u32) {
        /// (1/28 of FACT) Filter active
        @"FACT[0]": u1,
        /// (2/28 of FACT) Filter active
        @"FACT[1]": u1,
        /// (3/28 of FACT) Filter active
        @"FACT[2]": u1,
        /// (4/28 of FACT) Filter active
        @"FACT[3]": u1,
        /// (5/28 of FACT) Filter active
        @"FACT[4]": u1,
        /// (6/28 of FACT) Filter active
        @"FACT[5]": u1,
        /// (7/28 of FACT) Filter active
        @"FACT[6]": u1,
        /// (8/28 of FACT) Filter active
        @"FACT[7]": u1,
        /// (9/28 of FACT) Filter active
        @"FACT[8]": u1,
        /// (10/28 of FACT) Filter active
        @"FACT[9]": u1,
        /// (11/28 of FACT) Filter active
        @"FACT[10]": u1,
        /// (12/28 of FACT) Filter active
        @"FACT[11]": u1,
        /// (13/28 of FACT) Filter active
        @"FACT[12]": u1,
        /// (14/28 of FACT) Filter active
        @"FACT[13]": u1,
        /// (15/28 of FACT) Filter active
        @"FACT[14]": u1,
        /// (16/28 of FACT) Filter active
        @"FACT[15]": u1,
        /// (17/28 of FACT) Filter active
        @"FACT[16]": u1,
        /// (18/28 of FACT) Filter active
        @"FACT[17]": u1,
        /// (19/28 of FACT) Filter active
        @"FACT[18]": u1,
        /// (20/28 of FACT) Filter active
        @"FACT[19]": u1,
        /// (21/28 of FACT) Filter active
        @"FACT[20]": u1,
        /// (22/28 of FACT) Filter active
        @"FACT[21]": u1,
        /// (23/28 of FACT) Filter active
        @"FACT[22]": u1,
        /// (24/28 of FACT) Filter active
        @"FACT[23]": u1,
        /// (25/28 of FACT) Filter active
        @"FACT[24]": u1,
        /// (26/28 of FACT) Filter active
        @"FACT[25]": u1,
        /// (27/28 of FACT) Filter active
        @"FACT[26]": u1,
        /// (28/28 of FACT) Filter active
        @"FACT[27]": u1,
        padding: u4 = 0,
    }),
    /// offset: 0x220
    reserved544: [32]u8,
    /// CAN Filter Bank cluster
    /// offset: 0x240
    FB: u32,
};

/// CAN Filter Bank cluster
pub const FB = extern struct {
    /// Filter bank 0 register 1
    /// offset: 0x00
    FR1: mmio.Mmio(packed struct(u32) {
        /// (1/32 of FB) Filter bits
        @"FB[0]": u1,
        /// (2/32 of FB) Filter bits
        @"FB[1]": u1,
        /// (3/32 of FB) Filter bits
        @"FB[2]": u1,
        /// (4/32 of FB) Filter bits
        @"FB[3]": u1,
        /// (5/32 of FB) Filter bits
        @"FB[4]": u1,
        /// (6/32 of FB) Filter bits
        @"FB[5]": u1,
        /// (7/32 of FB) Filter bits
        @"FB[6]": u1,
        /// (8/32 of FB) Filter bits
        @"FB[7]": u1,
        /// (9/32 of FB) Filter bits
        @"FB[8]": u1,
        /// (10/32 of FB) Filter bits
        @"FB[9]": u1,
        /// (11/32 of FB) Filter bits
        @"FB[10]": u1,
        /// (12/32 of FB) Filter bits
        @"FB[11]": u1,
        /// (13/32 of FB) Filter bits
        @"FB[12]": u1,
        /// (14/32 of FB) Filter bits
        @"FB[13]": u1,
        /// (15/32 of FB) Filter bits
        @"FB[14]": u1,
        /// (16/32 of FB) Filter bits
        @"FB[15]": u1,
        /// (17/32 of FB) Filter bits
        @"FB[16]": u1,
        /// (18/32 of FB) Filter bits
        @"FB[17]": u1,
        /// (19/32 of FB) Filter bits
        @"FB[18]": u1,
        /// (20/32 of FB) Filter bits
        @"FB[19]": u1,
        /// (21/32 of FB) Filter bits
        @"FB[20]": u1,
        /// (22/32 of FB) Filter bits
        @"FB[21]": u1,
        /// (23/32 of FB) Filter bits
        @"FB[22]": u1,
        /// (24/32 of FB) Filter bits
        @"FB[23]": u1,
        /// (25/32 of FB) Filter bits
        @"FB[24]": u1,
        /// (26/32 of FB) Filter bits
        @"FB[25]": u1,
        /// (27/32 of FB) Filter bits
        @"FB[26]": u1,
        /// (28/32 of FB) Filter bits
        @"FB[27]": u1,
        /// (29/32 of FB) Filter bits
        @"FB[28]": u1,
        /// (30/32 of FB) Filter bits
        @"FB[29]": u1,
        /// (31/32 of FB) Filter bits
        @"FB[30]": u1,
        /// (32/32 of FB) Filter bits
        @"FB[31]": u1,
    }),
    /// Filter bank 0 register 2
    /// offset: 0x04
    FR2: mmio.Mmio(packed struct(u32) {
        /// (1/32 of FB) Filter bits
        @"FB[0]": u1,
        /// (2/32 of FB) Filter bits
        @"FB[1]": u1,
        /// (3/32 of FB) Filter bits
        @"FB[2]": u1,
        /// (4/32 of FB) Filter bits
        @"FB[3]": u1,
        /// (5/32 of FB) Filter bits
        @"FB[4]": u1,
        /// (6/32 of FB) Filter bits
        @"FB[5]": u1,
        /// (7/32 of FB) Filter bits
        @"FB[6]": u1,
        /// (8/32 of FB) Filter bits
        @"FB[7]": u1,
        /// (9/32 of FB) Filter bits
        @"FB[8]": u1,
        /// (10/32 of FB) Filter bits
        @"FB[9]": u1,
        /// (11/32 of FB) Filter bits
        @"FB[10]": u1,
        /// (12/32 of FB) Filter bits
        @"FB[11]": u1,
        /// (13/32 of FB) Filter bits
        @"FB[12]": u1,
        /// (14/32 of FB) Filter bits
        @"FB[13]": u1,
        /// (15/32 of FB) Filter bits
        @"FB[14]": u1,
        /// (16/32 of FB) Filter bits
        @"FB[15]": u1,
        /// (17/32 of FB) Filter bits
        @"FB[16]": u1,
        /// (18/32 of FB) Filter bits
        @"FB[17]": u1,
        /// (19/32 of FB) Filter bits
        @"FB[18]": u1,
        /// (20/32 of FB) Filter bits
        @"FB[19]": u1,
        /// (21/32 of FB) Filter bits
        @"FB[20]": u1,
        /// (22/32 of FB) Filter bits
        @"FB[21]": u1,
        /// (23/32 of FB) Filter bits
        @"FB[22]": u1,
        /// (24/32 of FB) Filter bits
        @"FB[23]": u1,
        /// (25/32 of FB) Filter bits
        @"FB[24]": u1,
        /// (26/32 of FB) Filter bits
        @"FB[25]": u1,
        /// (27/32 of FB) Filter bits
        @"FB[26]": u1,
        /// (28/32 of FB) Filter bits
        @"FB[27]": u1,
        /// (29/32 of FB) Filter bits
        @"FB[28]": u1,
        /// (30/32 of FB) Filter bits
        @"FB[29]": u1,
        /// (31/32 of FB) Filter bits
        @"FB[30]": u1,
        /// (32/32 of FB) Filter bits
        @"FB[31]": u1,
    }),
};

/// CAN Receive cluster
pub const RX = extern struct {
    /// receive FIFO mailbox identifier register
    /// offset: 0x00
    RIR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// RTR
        RTR: RTR,
        /// IDE
        IDE: IDE,
        /// EXID
        EXID: u18,
        /// STID
        STID: u11,
    }),
    /// mailbox data high register
    /// offset: 0x04
    RDTR: mmio.Mmio(packed struct(u32) {
        /// DLC
        DLC: u4,
        reserved8: u4 = 0,
        /// FMI
        FMI: u8,
        /// TIME
        TIME: u16,
    }),
    /// mailbox data high register
    /// offset: 0x08
    RDLR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DATA) DATA0
        @"DATA[0]": u8,
        /// (2/4 of DATA) DATA0
        @"DATA[1]": u8,
        /// (3/4 of DATA) DATA0
        @"DATA[2]": u8,
        /// (4/4 of DATA) DATA0
        @"DATA[3]": u8,
    }),
    /// receive FIFO mailbox data high register
    /// offset: 0x0c
    RDHR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DATA) DATA4
        @"DATA[0]": u8,
        /// (2/4 of DATA) DATA4
        @"DATA[1]": u8,
        /// (3/4 of DATA) DATA4
        @"DATA[2]": u8,
        /// (4/4 of DATA) DATA4
        @"DATA[3]": u8,
    }),
};

/// CAN Transmit cluster
pub const TX = extern struct {
    /// TX mailbox identifier register
    /// offset: 0x00
    TIR: mmio.Mmio(packed struct(u32) {
        /// TXRQ
        TXRQ: u1,
        /// RTR
        RTR: RTR,
        /// IDE
        IDE: IDE,
        /// EXID
        EXID: u18,
        /// STID
        STID: u11,
    }),
    /// mailbox data length control and time stamp register
    /// offset: 0x04
    TDTR: mmio.Mmio(packed struct(u32) {
        /// DLC
        DLC: u4,
        reserved8: u4 = 0,
        /// TGT
        TGT: u1,
        reserved16: u7 = 0,
        /// TIME
        TIME: u16,
    }),
    /// mailbox data low register
    /// offset: 0x08
    TDLR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DATA) DATA0
        @"DATA[0]": u8,
        /// (2/4 of DATA) DATA0
        @"DATA[1]": u8,
        /// (3/4 of DATA) DATA0
        @"DATA[2]": u8,
        /// (4/4 of DATA) DATA0
        @"DATA[3]": u8,
    }),
    /// mailbox data high register
    /// offset: 0x0c
    TDHR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DATA) DATA4
        @"DATA[0]": u8,
        /// (2/4 of DATA) DATA4
        @"DATA[1]": u8,
        /// (3/4 of DATA) DATA4
        @"DATA[2]": u8,
        /// (4/4 of DATA) DATA4
        @"DATA[3]": u8,
    }),
};
