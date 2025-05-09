const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const TFQM = enum(u1) {
    /// Tx FIFO operation
    FIFO = 0x0,
    /// Tx queue operation
    QUEUE = 0x1,
};

/// Controller area network with flexible data rate (FD)
pub const FDCAN = extern struct {
    /// FDCAN Core Release Register
    /// offset: 0x00
    CREL: mmio.Mmio(packed struct(u32) {
        /// Timestamp Day
        DAY: u8,
        /// Timestamp Month
        MON: u8,
        /// Timestamp Year
        YEAR: u4,
        /// Sub-step of Core release
        SUBSTEP: u4,
        /// Step of Core release
        STEP: u4,
        /// Core release
        REL: u4,
    }),
    /// FDCAN Core Release Register
    /// offset: 0x04
    ENDN: mmio.Mmio(packed struct(u32) {
        /// Endiannes Test Value
        ETV: u32,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// FDCAN Data Bit Timing and Prescaler Register
    /// offset: 0x0c
    DBTP: mmio.Mmio(packed struct(u32) {
        /// Synchronization Jump Width
        DSJW: u4,
        /// Data time segment after sample point
        DTSEG2: u4,
        /// Data time segment after sample point
        DTSEG1: u5,
        reserved16: u3 = 0,
        /// Data BIt Rate Prescaler
        DBRP: u5,
        reserved23: u2 = 0,
        /// Transceiver Delay Compensation
        TDC: u1,
        padding: u8 = 0,
    }),
    /// FDCAN Test Register
    /// offset: 0x10
    TEST: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Loop Back mode
        LBCK: u1,
        /// Loop Back mode
        TX: u2,
        /// Control of Transmit Pin
        RX: u1,
        padding: u24 = 0,
    }),
    /// FDCAN RAM Watchdog Register
    /// offset: 0x14
    RWD: mmio.Mmio(packed struct(u32) {
        /// Watchdog configuration
        WDC: u8,
        /// Watchdog value
        WDV: u8,
        padding: u16 = 0,
    }),
    /// FDCAN CC Control Register
    /// offset: 0x18
    CCCR: mmio.Mmio(packed struct(u32) {
        /// Initialization
        INIT: u1,
        /// Configuration Change Enable
        CCE: u1,
        /// ASM Restricted Operation Mode
        ASM: u1,
        /// Clock Stop Acknowledge
        CSA: u1,
        /// Clock Stop Request
        CSR: u1,
        /// Bus Monitoring Mode
        MON: u1,
        /// Disable Automatic Retransmission
        DAR: u1,
        /// Test Mode Enable
        TEST: u1,
        /// FD Operation Enable
        FDOE: u1,
        /// FDCAN Bit Rate Switching
        BSE: u1,
        reserved12: u2 = 0,
        /// Protocol Exception Handling Disable
        PXHD: u1,
        /// Edge Filtering during Bus Integration
        EFBI: u1,
        /// TXP
        TXP: u1,
        /// Non ISO Operation
        NISO: u1,
        padding: u16 = 0,
    }),
    /// FDCAN Nominal Bit Timing and Prescaler Register
    /// offset: 0x1c
    NBTP: mmio.Mmio(packed struct(u32) {
        /// Nominal Time segment after sample point
        NTSEG2: u7,
        reserved8: u1 = 0,
        /// Nominal Time segment before sample point
        NTSEG1: u8,
        /// Bit Rate Prescaler
        NBRP: u9,
        /// NSJW: Nominal (Re)Synchronization Jump Width.
        NSJW: u7,
    }),
    /// FDCAN Timestamp Counter Configuration Register
    /// offset: 0x20
    TSCC: mmio.Mmio(packed struct(u32) {
        /// Timestamp Select
        TSS: u2,
        reserved16: u14 = 0,
        /// Timestamp Counter Prescaler
        TCP: u4,
        padding: u12 = 0,
    }),
    /// FDCAN Timestamp Counter Value Register
    /// offset: 0x24
    TSCV: mmio.Mmio(packed struct(u32) {
        /// Timestamp Counter
        TSC: u16,
        padding: u16 = 0,
    }),
    /// FDCAN Timeout Counter Configuration Register
    /// offset: 0x28
    TOCC: mmio.Mmio(packed struct(u32) {
        /// Enable Timeout Counter
        ETOC: u1,
        /// Timeout Select
        TOS: u2,
        reserved16: u13 = 0,
        /// Timeout Period
        TOP: u16,
    }),
    /// FDCAN Timeout Counter Value Register
    /// offset: 0x2c
    TOCV: mmio.Mmio(packed struct(u32) {
        /// Timeout Counter
        TOC: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [16]u8,
    /// FDCAN Error Counter Register
    /// offset: 0x40
    ECR: mmio.Mmio(packed struct(u32) {
        /// Transmit Error Counter
        TEC: u8,
        /// Receive Error Counter
        REC: u7,
        /// Receive Error Passive
        RP: u1,
        /// AN Error Logging
        CEL: u8,
        padding: u8 = 0,
    }),
    /// FDCAN Protocol Status Register
    /// offset: 0x44
    PSR: mmio.Mmio(packed struct(u32) {
        /// Last Error Code
        LEC: u3,
        /// Activity
        ACT: u2,
        /// Error Passive
        EP: u1,
        /// Warning Status
        EW: u1,
        /// Bus_Off Status
        BO: u1,
        /// Data Last Error Code
        DLEC: u3,
        /// ESI flag of last received FDCAN Message
        RESI: u1,
        /// BRS flag of last received FDCAN Message
        RBRS: u1,
        /// Received FDCAN Message
        REDL: u1,
        /// Protocol Exception Event
        PXE: u1,
        reserved16: u1 = 0,
        /// Transmitter Delay Compensation Value
        TDCV: u7,
        padding: u9 = 0,
    }),
    /// FDCAN Transmitter Delay Compensation Register
    /// offset: 0x48
    TDCR: mmio.Mmio(packed struct(u32) {
        /// Transmitter Delay Compensation Filter Window Length
        TDCF: u7,
        reserved8: u1 = 0,
        /// Transmitter Delay Compensation Offset
        TDCO: u7,
        padding: u17 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// FDCAN Interrupt Register
    /// offset: 0x50
    IR: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X New Message
        @"RFN[0]": u1,
        /// Rx FIFO X Watermark Reached
        @"RFW[0]": u1,
        /// Rx FIFO X Full
        @"RFF[0]": u1,
        /// Rx FIFO X Message Lost
        @"RFL[0]": u1,
        /// Rx FIFO X New Message
        @"RFN[1]": u1,
        /// Rx FIFO X Watermark Reached
        @"RFW[1]": u1,
        /// Rx FIFO X Full
        @"RFF[1]": u1,
        /// Rx FIFO X Message Lost
        @"RFL[1]": u1,
        /// High Priority Message
        HPM: u1,
        /// Transmission Completed
        TC: u1,
        /// Transmission Cancellation Finished
        TCF: u1,
        /// Tx FIFO Empty
        TEF: u1,
        /// Tx Event FIFO New Entry
        TEFN: u1,
        /// Tx Event FIFO Watermark Reached
        TEFW: u1,
        /// Tx Event FIFO Full
        TEFF: u1,
        /// Tx Event FIFO Element Lost
        TEFL: u1,
        /// Timestamp Wraparound
        TSW: u1,
        /// Message RAM Access Failure
        MRAF: u1,
        /// Timeout Occurred
        TOO: u1,
        /// Message stored to Dedicated Rx Buffer
        DRX: u1,
        reserved22: u2 = 0,
        /// Error Logging Overflow
        ELO: u1,
        /// Error Passive
        EP: u1,
        /// Warning Status
        EW: u1,
        /// Bus_Off Status
        BO: u1,
        /// Watchdog Interrupt
        WDI: u1,
        /// Protocol Error in Arbitration Phase (Nominal Bit Time is used)
        PEA: u1,
        /// Protocol Error in Data Phase (Data Bit Time is used)
        PED: u1,
        /// Access to Reserved Address
        ARA: u1,
        padding: u2 = 0,
    }),
    /// FDCAN Interrupt Enable Register
    /// offset: 0x54
    IE: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X New Message Enable
        @"RFNE[0]": u1,
        /// Rx FIFO X Watermark Reached Enable
        @"RFWE[0]": u1,
        /// Rx FIFO X Full Enable
        @"RFFE[0]": u1,
        /// Rx FIFO X Message Lost Enable
        @"RFLE[0]": u1,
        /// Rx FIFO X New Message Enable
        @"RFNE[1]": u1,
        /// Rx FIFO X Watermark Reached Enable
        @"RFWE[1]": u1,
        /// Rx FIFO X Full Enable
        @"RFFE[1]": u1,
        /// Rx FIFO X Message Lost Enable
        @"RFLE[1]": u1,
        /// High Priority Message Enable
        HPME: u1,
        /// Transmission Completed Enable
        TCE: u1,
        /// Transmission Cancellation Finished Enable
        TCFE: u1,
        /// Tx FIFO Empty Enable
        TEFE: u1,
        /// Tx Event FIFO New Entry Enable
        TEFNE: u1,
        /// Tx Event FIFO Watermark Reached Enable
        TEFWE: u1,
        /// Tx Event FIFO Full Enable
        TEFFE: u1,
        /// Tx Event FIFO Element Lost Enable
        TEFLE: u1,
        /// Timestamp Wraparound Enable
        TSWE: u1,
        /// Message RAM Access Failure Enable
        MRAFE: u1,
        /// Timeout Occurred Enable
        TOOE: u1,
        /// Message stored to Dedicated Rx Buffer Enable
        DRXE: u1,
        /// Bit Error Corrected Interrupt Enable
        BECE: u1,
        /// Bit Error Uncorrected Interrupt Enable
        BEUE: u1,
        /// Error Logging Overflow Enable
        ELOE: u1,
        /// Error Passive Enable
        EPE: u1,
        /// Warning Status Enable
        EWE: u1,
        /// Bus_Off Status Enable
        BOE: u1,
        /// Watchdog Interrupt Enable
        WDIE: u1,
        /// Protocol Error in Arbitration Phase Enable
        PEAE: u1,
        /// Protocol Error in Data Phase Enable
        PEDE: u1,
        /// Access to Reserved Address Enable
        ARAE: u1,
        padding: u2 = 0,
    }),
    /// FDCAN Interrupt Line Select Register
    /// offset: 0x58
    ILS: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X New Message Interrupt Line
        @"RFNL[0]": u1,
        /// Rx FIFO X Watermark Reached Interrupt Line
        @"RFWL[0]": u1,
        /// Rx FIFO X Full Interrupt Line
        @"RFFL[0]": u1,
        /// Rx FIFO X Message Lost Interrupt Line
        @"RFLL[0]": u1,
        /// Rx FIFO X New Message Interrupt Line
        @"RFNL[1]": u1,
        /// Rx FIFO X Watermark Reached Interrupt Line
        @"RFWL[1]": u1,
        /// Rx FIFO X Full Interrupt Line
        @"RFFL[1]": u1,
        /// Rx FIFO X Message Lost Interrupt Line
        @"RFLL[1]": u1,
        /// High Priority Message Interrupt Line
        HPML: u1,
        /// Transmission Completed Interrupt Line
        TCL: u1,
        /// Transmission Cancellation Finished Interrupt Line
        TCFL: u1,
        /// Tx FIFO Empty Interrupt Line
        TEFL: u1,
        /// Tx Event FIFO New Entry Interrupt Line
        TEFNL: u1,
        /// Tx Event FIFO Watermark Reached Interrupt Line
        TEFWL: u1,
        /// Tx Event FIFO Full Interrupt Line
        TEFFL: u1,
        /// Tx Event FIFO Element Lost Interrupt Line
        TEFLL: u1,
        /// Timestamp Wraparound Interrupt Line
        TSWL: u1,
        /// Message RAM Access Failure Interrupt Line
        MRAFL: u1,
        /// Timeout Occurred Interrupt Line
        TOOL: u1,
        /// Message stored to Dedicated Rx Buffer Interrupt Line
        DRXL: u1,
        /// Bit Error Corrected Interrupt Line
        BECL: u1,
        /// Bit Error Uncorrected Interrupt Line
        BEUL: u1,
        /// Error Logging Overflow Interrupt Line
        ELOL: u1,
        /// Error Passive Interrupt Line
        EPL: u1,
        /// Warning Status Interrupt Line
        EWL: u1,
        /// Bus_Off Status
        BOL: u1,
        /// Watchdog Interrupt Line
        WDIL: u1,
        /// Protocol Error in Arbitration Phase Line
        PEAL: u1,
        /// Protocol Error in Data Phase Line
        PEDL: u1,
        /// Access to Reserved Address Line
        ARAL: u1,
        padding: u2 = 0,
    }),
    /// FDCAN Interrupt Line Enable Register
    /// offset: 0x5c
    ILE: mmio.Mmio(packed struct(u32) {
        /// Enable Interrupt Line 0
        EINT0: u1,
        /// Enable Interrupt Line 1
        EINT1: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x60
    reserved96: [32]u8,
    /// FDCAN Global Filter Configuration Register
    /// offset: 0x80
    GFC: mmio.Mmio(packed struct(u32) {
        /// Reject Remote Frames Extended
        RRFE: u1,
        /// Reject Remote Frames Standard
        RRFS: u1,
        /// Accept Non-matching Frames Extended
        ANFE: u2,
        /// Accept Non-matching Frames Standard
        ANFS: u2,
        padding: u26 = 0,
    }),
    /// FDCAN Standard ID Filter Configuration Register
    /// offset: 0x84
    SIDFC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Filter List Standard Start Address
        FLSSA: u14,
        /// List Size Standard
        LSS: u8,
        padding: u8 = 0,
    }),
    /// FDCAN Extended ID Filter Configuration Register
    /// offset: 0x88
    XIDFC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Filter List Standard Start Address
        FLESA: u14,
        /// List Size Extended
        LSE: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// FDCAN Extended ID and Mask Register
    /// offset: 0x90
    XIDAM: mmio.Mmio(packed struct(u32) {
        /// Extended ID Mask
        EIDM: u29,
        padding: u3 = 0,
    }),
    /// FDCAN High Priority Message Status Register
    /// offset: 0x94
    HPMS: mmio.Mmio(packed struct(u32) {
        /// Buffer Index
        BIDX: u6,
        /// Message Storage Indicator
        MSI: u2,
        /// Filter Index
        FIDX: u7,
        /// Filter List
        FLST: u1,
        padding: u16 = 0,
    }),
    /// FDCAN New Data 1 Register
    /// offset: 0x98
    NDAT1: mmio.Mmio(packed struct(u32) {
        /// New data (buffers 0 - 31)
        ND: u32,
    }),
    /// FDCAN New Data 2 Register
    /// offset: 0x9c
    NDAT2: mmio.Mmio(packed struct(u32) {
        /// New data (buffers 32 - 63)
        ND: u32,
    }),
    /// FDCAN Rx FIFO X Configuration Register
    /// offset: 0xa0
    RXFC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Rx FIFO X Start Address
        FSA: u14,
        /// Rx FIFO X Size
        FS: u7,
        reserved24: u1 = 0,
        /// FIFO X Watermark
        FWM: u7,
        /// FIFO X operation mode
        FOM: u1,
    }),
    /// FDCAN Rx FIFO X Status Register
    /// offset: 0xa4
    RXFS: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X Fill Level
        FFL: u7,
        reserved8: u1 = 0,
        /// Rx FIFO X Get Index
        FGI: u6,
        reserved16: u2 = 0,
        /// Rx FIFO X Put Index
        FPI: u6,
        reserved24: u2 = 0,
        /// Rx FIFO X Full
        FF: u1,
        /// Rx FIFO X Message Lost
        RFL: u1,
        padding: u6 = 0,
    }),
    /// CAN Rx FIFO X Acknowledge Register
    /// offset: 0xa8
    RXFA: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X Acknowledge Index
        FAI: u6,
        padding: u26 = 0,
    }),
    /// FDCAN Rx Buffer Configuration Register
    /// offset: 0xac
    RXBC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Rx Buffer Start Address
        RBSA: u14,
        padding: u16 = 0,
    }),
    /// offset: 0xb0
    reserved176: [12]u8,
    /// FDCAN Rx Buffer Element Size Configuration Register
    /// offset: 0xbc
    RXESC: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X Data Field Size
        @"FDS[0]": u3,
        reserved4: u1 = 0,
        /// Rx FIFO X Data Field Size
        @"FDS[1]": u3,
        reserved8: u1 = 0,
        /// Rx Buffer Data Field Size
        RBDS: u3,
        padding: u21 = 0,
    }),
    /// FDCAN Tx Buffer Configuration Register
    /// offset: 0xc0
    TXBC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Tx Buffers Start Address
        TBSA: u14,
        /// Number of Dedicated Transmit Buffers
        NDTB: u6,
        reserved24: u2 = 0,
        /// Transmit FIFO/Queue Size
        TFQS: u6,
        /// Tx FIFO/Queue Mode
        TFQM: TFQM,
        padding: u1 = 0,
    }),
    /// FDCAN Tx FIFO/Queue Status Register
    /// offset: 0xc4
    TXFQS: mmio.Mmio(packed struct(u32) {
        /// Tx FIFO Free Level
        TFFL: u6,
        reserved8: u2 = 0,
        /// TFGI
        TFGI: u5,
        reserved16: u3 = 0,
        /// Tx FIFO/Queue Put Index
        TFQPI: u5,
        /// Tx FIFO/Queue Full
        TFQF: u1,
        padding: u10 = 0,
    }),
    /// FDCAN Tx Buffer Element Size Configuration Register
    /// offset: 0xc8
    TXESC: mmio.Mmio(packed struct(u32) {
        /// Tx Buffer Data Field Size
        TBDS: u3,
        padding: u29 = 0,
    }),
    /// FDCAN Tx Buffer Request Pending Register
    /// offset: 0xcc
    TXBRP: mmio.Mmio(packed struct(u32) {
        /// (1/32 of TRP) Transmission Request Pending
        @"TRP[0]": u1,
        /// (2/32 of TRP) Transmission Request Pending
        @"TRP[1]": u1,
        /// (3/32 of TRP) Transmission Request Pending
        @"TRP[2]": u1,
        /// (4/32 of TRP) Transmission Request Pending
        @"TRP[3]": u1,
        /// (5/32 of TRP) Transmission Request Pending
        @"TRP[4]": u1,
        /// (6/32 of TRP) Transmission Request Pending
        @"TRP[5]": u1,
        /// (7/32 of TRP) Transmission Request Pending
        @"TRP[6]": u1,
        /// (8/32 of TRP) Transmission Request Pending
        @"TRP[7]": u1,
        /// (9/32 of TRP) Transmission Request Pending
        @"TRP[8]": u1,
        /// (10/32 of TRP) Transmission Request Pending
        @"TRP[9]": u1,
        /// (11/32 of TRP) Transmission Request Pending
        @"TRP[10]": u1,
        /// (12/32 of TRP) Transmission Request Pending
        @"TRP[11]": u1,
        /// (13/32 of TRP) Transmission Request Pending
        @"TRP[12]": u1,
        /// (14/32 of TRP) Transmission Request Pending
        @"TRP[13]": u1,
        /// (15/32 of TRP) Transmission Request Pending
        @"TRP[14]": u1,
        /// (16/32 of TRP) Transmission Request Pending
        @"TRP[15]": u1,
        /// (17/32 of TRP) Transmission Request Pending
        @"TRP[16]": u1,
        /// (18/32 of TRP) Transmission Request Pending
        @"TRP[17]": u1,
        /// (19/32 of TRP) Transmission Request Pending
        @"TRP[18]": u1,
        /// (20/32 of TRP) Transmission Request Pending
        @"TRP[19]": u1,
        /// (21/32 of TRP) Transmission Request Pending
        @"TRP[20]": u1,
        /// (22/32 of TRP) Transmission Request Pending
        @"TRP[21]": u1,
        /// (23/32 of TRP) Transmission Request Pending
        @"TRP[22]": u1,
        /// (24/32 of TRP) Transmission Request Pending
        @"TRP[23]": u1,
        /// (25/32 of TRP) Transmission Request Pending
        @"TRP[24]": u1,
        /// (26/32 of TRP) Transmission Request Pending
        @"TRP[25]": u1,
        /// (27/32 of TRP) Transmission Request Pending
        @"TRP[26]": u1,
        /// (28/32 of TRP) Transmission Request Pending
        @"TRP[27]": u1,
        /// (29/32 of TRP) Transmission Request Pending
        @"TRP[28]": u1,
        /// (30/32 of TRP) Transmission Request Pending
        @"TRP[29]": u1,
        /// (31/32 of TRP) Transmission Request Pending
        @"TRP[30]": u1,
        /// (32/32 of TRP) Transmission Request Pending
        @"TRP[31]": u1,
    }),
    /// FDCAN Tx Buffer Add Request Register
    /// offset: 0xd0
    TXBAR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of AR) Add Request
        @"AR[0]": u1,
        /// (2/32 of AR) Add Request
        @"AR[1]": u1,
        /// (3/32 of AR) Add Request
        @"AR[2]": u1,
        /// (4/32 of AR) Add Request
        @"AR[3]": u1,
        /// (5/32 of AR) Add Request
        @"AR[4]": u1,
        /// (6/32 of AR) Add Request
        @"AR[5]": u1,
        /// (7/32 of AR) Add Request
        @"AR[6]": u1,
        /// (8/32 of AR) Add Request
        @"AR[7]": u1,
        /// (9/32 of AR) Add Request
        @"AR[8]": u1,
        /// (10/32 of AR) Add Request
        @"AR[9]": u1,
        /// (11/32 of AR) Add Request
        @"AR[10]": u1,
        /// (12/32 of AR) Add Request
        @"AR[11]": u1,
        /// (13/32 of AR) Add Request
        @"AR[12]": u1,
        /// (14/32 of AR) Add Request
        @"AR[13]": u1,
        /// (15/32 of AR) Add Request
        @"AR[14]": u1,
        /// (16/32 of AR) Add Request
        @"AR[15]": u1,
        /// (17/32 of AR) Add Request
        @"AR[16]": u1,
        /// (18/32 of AR) Add Request
        @"AR[17]": u1,
        /// (19/32 of AR) Add Request
        @"AR[18]": u1,
        /// (20/32 of AR) Add Request
        @"AR[19]": u1,
        /// (21/32 of AR) Add Request
        @"AR[20]": u1,
        /// (22/32 of AR) Add Request
        @"AR[21]": u1,
        /// (23/32 of AR) Add Request
        @"AR[22]": u1,
        /// (24/32 of AR) Add Request
        @"AR[23]": u1,
        /// (25/32 of AR) Add Request
        @"AR[24]": u1,
        /// (26/32 of AR) Add Request
        @"AR[25]": u1,
        /// (27/32 of AR) Add Request
        @"AR[26]": u1,
        /// (28/32 of AR) Add Request
        @"AR[27]": u1,
        /// (29/32 of AR) Add Request
        @"AR[28]": u1,
        /// (30/32 of AR) Add Request
        @"AR[29]": u1,
        /// (31/32 of AR) Add Request
        @"AR[30]": u1,
        /// (32/32 of AR) Add Request
        @"AR[31]": u1,
    }),
    /// FDCAN Tx Buffer Cancellation Request Register
    /// offset: 0xd4
    TXBCR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of CR) Cancellation Request
        @"CR[0]": u1,
        /// (2/32 of CR) Cancellation Request
        @"CR[1]": u1,
        /// (3/32 of CR) Cancellation Request
        @"CR[2]": u1,
        /// (4/32 of CR) Cancellation Request
        @"CR[3]": u1,
        /// (5/32 of CR) Cancellation Request
        @"CR[4]": u1,
        /// (6/32 of CR) Cancellation Request
        @"CR[5]": u1,
        /// (7/32 of CR) Cancellation Request
        @"CR[6]": u1,
        /// (8/32 of CR) Cancellation Request
        @"CR[7]": u1,
        /// (9/32 of CR) Cancellation Request
        @"CR[8]": u1,
        /// (10/32 of CR) Cancellation Request
        @"CR[9]": u1,
        /// (11/32 of CR) Cancellation Request
        @"CR[10]": u1,
        /// (12/32 of CR) Cancellation Request
        @"CR[11]": u1,
        /// (13/32 of CR) Cancellation Request
        @"CR[12]": u1,
        /// (14/32 of CR) Cancellation Request
        @"CR[13]": u1,
        /// (15/32 of CR) Cancellation Request
        @"CR[14]": u1,
        /// (16/32 of CR) Cancellation Request
        @"CR[15]": u1,
        /// (17/32 of CR) Cancellation Request
        @"CR[16]": u1,
        /// (18/32 of CR) Cancellation Request
        @"CR[17]": u1,
        /// (19/32 of CR) Cancellation Request
        @"CR[18]": u1,
        /// (20/32 of CR) Cancellation Request
        @"CR[19]": u1,
        /// (21/32 of CR) Cancellation Request
        @"CR[20]": u1,
        /// (22/32 of CR) Cancellation Request
        @"CR[21]": u1,
        /// (23/32 of CR) Cancellation Request
        @"CR[22]": u1,
        /// (24/32 of CR) Cancellation Request
        @"CR[23]": u1,
        /// (25/32 of CR) Cancellation Request
        @"CR[24]": u1,
        /// (26/32 of CR) Cancellation Request
        @"CR[25]": u1,
        /// (27/32 of CR) Cancellation Request
        @"CR[26]": u1,
        /// (28/32 of CR) Cancellation Request
        @"CR[27]": u1,
        /// (29/32 of CR) Cancellation Request
        @"CR[28]": u1,
        /// (30/32 of CR) Cancellation Request
        @"CR[29]": u1,
        /// (31/32 of CR) Cancellation Request
        @"CR[30]": u1,
        /// (32/32 of CR) Cancellation Request
        @"CR[31]": u1,
    }),
    /// FDCAN Tx Buffer Transmission Occurred Register
    /// offset: 0xd8
    TXBTO: mmio.Mmio(packed struct(u32) {
        /// (1/32 of TO) Transmission Occurred
        @"TO[0]": u1,
        /// (2/32 of TO) Transmission Occurred
        @"TO[1]": u1,
        /// (3/32 of TO) Transmission Occurred
        @"TO[2]": u1,
        /// (4/32 of TO) Transmission Occurred
        @"TO[3]": u1,
        /// (5/32 of TO) Transmission Occurred
        @"TO[4]": u1,
        /// (6/32 of TO) Transmission Occurred
        @"TO[5]": u1,
        /// (7/32 of TO) Transmission Occurred
        @"TO[6]": u1,
        /// (8/32 of TO) Transmission Occurred
        @"TO[7]": u1,
        /// (9/32 of TO) Transmission Occurred
        @"TO[8]": u1,
        /// (10/32 of TO) Transmission Occurred
        @"TO[9]": u1,
        /// (11/32 of TO) Transmission Occurred
        @"TO[10]": u1,
        /// (12/32 of TO) Transmission Occurred
        @"TO[11]": u1,
        /// (13/32 of TO) Transmission Occurred
        @"TO[12]": u1,
        /// (14/32 of TO) Transmission Occurred
        @"TO[13]": u1,
        /// (15/32 of TO) Transmission Occurred
        @"TO[14]": u1,
        /// (16/32 of TO) Transmission Occurred
        @"TO[15]": u1,
        /// (17/32 of TO) Transmission Occurred
        @"TO[16]": u1,
        /// (18/32 of TO) Transmission Occurred
        @"TO[17]": u1,
        /// (19/32 of TO) Transmission Occurred
        @"TO[18]": u1,
        /// (20/32 of TO) Transmission Occurred
        @"TO[19]": u1,
        /// (21/32 of TO) Transmission Occurred
        @"TO[20]": u1,
        /// (22/32 of TO) Transmission Occurred
        @"TO[21]": u1,
        /// (23/32 of TO) Transmission Occurred
        @"TO[22]": u1,
        /// (24/32 of TO) Transmission Occurred
        @"TO[23]": u1,
        /// (25/32 of TO) Transmission Occurred
        @"TO[24]": u1,
        /// (26/32 of TO) Transmission Occurred
        @"TO[25]": u1,
        /// (27/32 of TO) Transmission Occurred
        @"TO[26]": u1,
        /// (28/32 of TO) Transmission Occurred
        @"TO[27]": u1,
        /// (29/32 of TO) Transmission Occurred
        @"TO[28]": u1,
        /// (30/32 of TO) Transmission Occurred
        @"TO[29]": u1,
        /// (31/32 of TO) Transmission Occurred
        @"TO[30]": u1,
        /// (32/32 of TO) Transmission Occurred
        @"TO[31]": u1,
    }),
    /// FDCAN Tx Buffer Cancellation Finished Register
    /// offset: 0xdc
    TXBCF: mmio.Mmio(packed struct(u32) {
        /// (1/32 of CF) Cancellation Finished
        @"CF[0]": u1,
        /// (2/32 of CF) Cancellation Finished
        @"CF[1]": u1,
        /// (3/32 of CF) Cancellation Finished
        @"CF[2]": u1,
        /// (4/32 of CF) Cancellation Finished
        @"CF[3]": u1,
        /// (5/32 of CF) Cancellation Finished
        @"CF[4]": u1,
        /// (6/32 of CF) Cancellation Finished
        @"CF[5]": u1,
        /// (7/32 of CF) Cancellation Finished
        @"CF[6]": u1,
        /// (8/32 of CF) Cancellation Finished
        @"CF[7]": u1,
        /// (9/32 of CF) Cancellation Finished
        @"CF[8]": u1,
        /// (10/32 of CF) Cancellation Finished
        @"CF[9]": u1,
        /// (11/32 of CF) Cancellation Finished
        @"CF[10]": u1,
        /// (12/32 of CF) Cancellation Finished
        @"CF[11]": u1,
        /// (13/32 of CF) Cancellation Finished
        @"CF[12]": u1,
        /// (14/32 of CF) Cancellation Finished
        @"CF[13]": u1,
        /// (15/32 of CF) Cancellation Finished
        @"CF[14]": u1,
        /// (16/32 of CF) Cancellation Finished
        @"CF[15]": u1,
        /// (17/32 of CF) Cancellation Finished
        @"CF[16]": u1,
        /// (18/32 of CF) Cancellation Finished
        @"CF[17]": u1,
        /// (19/32 of CF) Cancellation Finished
        @"CF[18]": u1,
        /// (20/32 of CF) Cancellation Finished
        @"CF[19]": u1,
        /// (21/32 of CF) Cancellation Finished
        @"CF[20]": u1,
        /// (22/32 of CF) Cancellation Finished
        @"CF[21]": u1,
        /// (23/32 of CF) Cancellation Finished
        @"CF[22]": u1,
        /// (24/32 of CF) Cancellation Finished
        @"CF[23]": u1,
        /// (25/32 of CF) Cancellation Finished
        @"CF[24]": u1,
        /// (26/32 of CF) Cancellation Finished
        @"CF[25]": u1,
        /// (27/32 of CF) Cancellation Finished
        @"CF[26]": u1,
        /// (28/32 of CF) Cancellation Finished
        @"CF[27]": u1,
        /// (29/32 of CF) Cancellation Finished
        @"CF[28]": u1,
        /// (30/32 of CF) Cancellation Finished
        @"CF[29]": u1,
        /// (31/32 of CF) Cancellation Finished
        @"CF[30]": u1,
        /// (32/32 of CF) Cancellation Finished
        @"CF[31]": u1,
    }),
    /// FDCAN Tx Buffer Transmission Interrupt Enable Register
    /// offset: 0xe0
    TXBTIE: mmio.Mmio(packed struct(u32) {
        /// (1/32 of TIE) Transmission Interrupt Enable
        @"TIE[0]": u1,
        /// (2/32 of TIE) Transmission Interrupt Enable
        @"TIE[1]": u1,
        /// (3/32 of TIE) Transmission Interrupt Enable
        @"TIE[2]": u1,
        /// (4/32 of TIE) Transmission Interrupt Enable
        @"TIE[3]": u1,
        /// (5/32 of TIE) Transmission Interrupt Enable
        @"TIE[4]": u1,
        /// (6/32 of TIE) Transmission Interrupt Enable
        @"TIE[5]": u1,
        /// (7/32 of TIE) Transmission Interrupt Enable
        @"TIE[6]": u1,
        /// (8/32 of TIE) Transmission Interrupt Enable
        @"TIE[7]": u1,
        /// (9/32 of TIE) Transmission Interrupt Enable
        @"TIE[8]": u1,
        /// (10/32 of TIE) Transmission Interrupt Enable
        @"TIE[9]": u1,
        /// (11/32 of TIE) Transmission Interrupt Enable
        @"TIE[10]": u1,
        /// (12/32 of TIE) Transmission Interrupt Enable
        @"TIE[11]": u1,
        /// (13/32 of TIE) Transmission Interrupt Enable
        @"TIE[12]": u1,
        /// (14/32 of TIE) Transmission Interrupt Enable
        @"TIE[13]": u1,
        /// (15/32 of TIE) Transmission Interrupt Enable
        @"TIE[14]": u1,
        /// (16/32 of TIE) Transmission Interrupt Enable
        @"TIE[15]": u1,
        /// (17/32 of TIE) Transmission Interrupt Enable
        @"TIE[16]": u1,
        /// (18/32 of TIE) Transmission Interrupt Enable
        @"TIE[17]": u1,
        /// (19/32 of TIE) Transmission Interrupt Enable
        @"TIE[18]": u1,
        /// (20/32 of TIE) Transmission Interrupt Enable
        @"TIE[19]": u1,
        /// (21/32 of TIE) Transmission Interrupt Enable
        @"TIE[20]": u1,
        /// (22/32 of TIE) Transmission Interrupt Enable
        @"TIE[21]": u1,
        /// (23/32 of TIE) Transmission Interrupt Enable
        @"TIE[22]": u1,
        /// (24/32 of TIE) Transmission Interrupt Enable
        @"TIE[23]": u1,
        /// (25/32 of TIE) Transmission Interrupt Enable
        @"TIE[24]": u1,
        /// (26/32 of TIE) Transmission Interrupt Enable
        @"TIE[25]": u1,
        /// (27/32 of TIE) Transmission Interrupt Enable
        @"TIE[26]": u1,
        /// (28/32 of TIE) Transmission Interrupt Enable
        @"TIE[27]": u1,
        /// (29/32 of TIE) Transmission Interrupt Enable
        @"TIE[28]": u1,
        /// (30/32 of TIE) Transmission Interrupt Enable
        @"TIE[29]": u1,
        /// (31/32 of TIE) Transmission Interrupt Enable
        @"TIE[30]": u1,
        /// (32/32 of TIE) Transmission Interrupt Enable
        @"TIE[31]": u1,
    }),
    /// FDCAN Tx Buffer Cancellation Finished Interrupt Enable Register
    /// offset: 0xe4
    TXBCIE: mmio.Mmio(packed struct(u32) {
        /// (1/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[0]": u1,
        /// (2/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[1]": u1,
        /// (3/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[2]": u1,
        /// (4/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[3]": u1,
        /// (5/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[4]": u1,
        /// (6/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[5]": u1,
        /// (7/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[6]": u1,
        /// (8/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[7]": u1,
        /// (9/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[8]": u1,
        /// (10/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[9]": u1,
        /// (11/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[10]": u1,
        /// (12/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[11]": u1,
        /// (13/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[12]": u1,
        /// (14/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[13]": u1,
        /// (15/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[14]": u1,
        /// (16/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[15]": u1,
        /// (17/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[16]": u1,
        /// (18/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[17]": u1,
        /// (19/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[18]": u1,
        /// (20/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[19]": u1,
        /// (21/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[20]": u1,
        /// (22/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[21]": u1,
        /// (23/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[22]": u1,
        /// (24/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[23]": u1,
        /// (25/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[24]": u1,
        /// (26/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[25]": u1,
        /// (27/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[26]": u1,
        /// (28/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[27]": u1,
        /// (29/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[28]": u1,
        /// (30/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[29]": u1,
        /// (31/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[30]": u1,
        /// (32/32 of CF) Cancellation Finished Interrupt Enable
        @"CF[31]": u1,
    }),
    /// offset: 0xe8
    reserved232: [8]u8,
    /// FDCAN Tx Event FIFO Configuration Register
    /// offset: 0xf0
    TXEFC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Event FIFO Start Address
        EFSA: u14,
        /// Event FIFO Size
        EFS: u6,
        reserved24: u2 = 0,
        /// Event FIFO Watermark
        EFWM: u6,
        padding: u2 = 0,
    }),
    /// FDCAN Tx Event FIFO Status Register
    /// offset: 0xf4
    TXEFS: mmio.Mmio(packed struct(u32) {
        /// Event FIFO Fill Level
        EFFL: u6,
        reserved8: u2 = 0,
        /// Event FIFO Get Index
        EFGI: u5,
        reserved16: u3 = 0,
        /// Event FIFO put index
        EFPI: u5,
        reserved24: u3 = 0,
        /// Event FIFO Full
        EFF: u1,
        /// Tx Event FIFO Element Lost
        TEFL: u1,
        padding: u6 = 0,
    }),
    /// FDCAN Tx Event FIFO Acknowledge Register
    /// offset: 0xf8
    TXEFA: mmio.Mmio(packed struct(u32) {
        /// Event FIFO Acknowledge Index
        EFAI: u5,
        padding: u27 = 0,
    }),
    /// offset: 0xfc
    reserved252: [4]u8,
    /// FDCAN TT Trigger Memory Configuration Register
    /// offset: 0x100
    TTTMC: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Trigger Memory Start Address
        TMSA: u14,
        /// Trigger Memory Elements
        TME: u7,
        padding: u9 = 0,
    }),
    /// FDCAN TT Reference Message Configuration Register
    /// offset: 0x104
    TTRMC: mmio.Mmio(packed struct(u32) {
        /// Reference Identifier
        RID: u29,
        reserved30: u1 = 0,
        /// Extended Identifier
        XTD: u1,
        /// Reference Message Payload Select
        RMPS: u1,
    }),
    /// FDCAN TT Operation Configuration Register
    /// offset: 0x108
    TTOCF: mmio.Mmio(packed struct(u32) {
        /// Operation Mode
        OM: u2,
        reserved3: u1 = 0,
        /// Gap Enable
        GEN: u1,
        /// Time Master
        TM: u1,
        /// LD of Synchronization Deviation Limit
        LDSDL: u3,
        /// Initial Reference Trigger Offset
        IRTO: u7,
        /// Enable External Clock Synchronization
        EECS: u1,
        /// Application Watchdog Limit
        AWL: u8,
        /// Enable Global Time Filtering
        EGTF: u1,
        /// Enable Clock Calibration
        ECC: u1,
        /// Event Trigger Polarity
        EVTP: u1,
        padding: u5 = 0,
    }),
    /// FDCAN TT Matrix Limits Register
    /// offset: 0x10c
    TTMLM: mmio.Mmio(packed struct(u32) {
        /// Cycle Count Max
        CCM: u6,
        /// Cycle Start Synchronization
        CSS: u2,
        /// Tx Enable Window
        TXEW: u4,
        reserved16: u4 = 0,
        /// Expected Number of Tx Triggers
        ENTT: u12,
        padding: u4 = 0,
    }),
    /// FDCAN TUR Configuration Register
    /// offset: 0x110
    TURCF: mmio.Mmio(packed struct(u32) {
        /// Numerator Configuration Low
        NCL: u16,
        /// Denominator Configuration
        DC: u14,
        reserved31: u1 = 0,
        /// Enable Local Time
        ELT: u1,
    }),
    /// FDCAN TT Operation Control Register
    /// offset: 0x114
    TTOCN: mmio.Mmio(packed struct(u32) {
        /// Set Global time
        SGT: u1,
        /// External Clock Synchronization
        ECS: u1,
        /// Stop Watch Polarity
        SWP: u1,
        /// Stop Watch Source
        SWS: u2,
        /// Register Time Mark Interrupt Pulse Enable
        RTIE: u1,
        /// Register Time Mark Compare
        TMC: u2,
        /// Trigger Time Mark Interrupt Pulse Enable
        TTIE: u1,
        /// Gap Control Select
        GCS: u1,
        /// Finish Gap
        FGP: u1,
        /// Time Mark Gap
        TMG: u1,
        /// Next is Gap
        NIG: u1,
        /// External Synchronization Control
        ESCN: u1,
        reserved15: u1 = 0,
        /// TT Operation Control Register Locked
        LCKC: u1,
        padding: u16 = 0,
    }),
    /// FDCAN TT Global Time Preset Register
    /// offset: 0x118
    TTGTP: mmio.Mmio(packed struct(u32) {
        /// Time Preset
        NCL: u16,
        /// Cycle Time Target Phase
        CTP: u16,
    }),
    /// FDCAN TT Time Mark Register
    /// offset: 0x11c
    TTTMK: mmio.Mmio(packed struct(u32) {
        /// Time Mark
        TM: u16,
        /// Time Mark Cycle Code
        TICC: u7,
        reserved31: u8 = 0,
        /// TT Time Mark Register Locked
        LCKM: u1,
    }),
    /// FDCAN TT Interrupt Register
    /// offset: 0x120
    TTIR: mmio.Mmio(packed struct(u32) {
        /// Start of Basic Cycle
        SBC: u1,
        /// Start of Matrix Cycle
        SMC: u1,
        /// Change of Synchronization Mode
        CSM: u1,
        /// Start of Gap
        SOG: u1,
        /// Register Time Mark Interrupt
        RTMI: u1,
        /// Trigger Time Mark Event Internal
        TTMI: u1,
        /// Stop Watch Event
        SWE: u1,
        /// Global Time Wrap
        GTW: u1,
        /// Global Time Discontinuity
        GTD: u1,
        /// Global Time Error
        GTE: u1,
        /// Tx Count Underflow
        TXU: u1,
        /// Tx Count Overflow
        TXO: u1,
        /// Scheduling Error 1
        SE1: u1,
        /// Scheduling Error 2
        SE2: u1,
        /// Error Level Changed
        ELC: u1,
        /// Initialization Watch Trigger
        IWTG: u1,
        /// Watch Trigger
        WT: u1,
        /// Application Watchdog
        AW: u1,
        /// Configuration Error
        CER: u1,
        padding: u13 = 0,
    }),
    /// FDCAN TT Interrupt Enable Register
    /// offset: 0x124
    TTIE: mmio.Mmio(packed struct(u32) {
        /// Start of Basic Cycle Interrupt Enable
        SBCE: u1,
        /// Start of Matrix Cycle Interrupt Enable
        SMCE: u1,
        /// Change of Synchronization Mode Interrupt Enable
        CSME: u1,
        /// Start of Gap Interrupt Enable
        SOGE: u1,
        /// Register Time Mark Interrupt Enable
        RTMIE: u1,
        /// Trigger Time Mark Event Internal Interrupt Enable
        TTMIE: u1,
        /// Stop Watch Event Interrupt Enable
        SWEE: u1,
        /// Global Time Wrap Interrupt Enable
        GTWE: u1,
        /// Global Time Discontinuity Interrupt Enable
        GTDE: u1,
        /// Global Time Error Interrupt Enable
        GTEE: u1,
        /// Tx Count Underflow Interrupt Enable
        TXUE: u1,
        /// Tx Count Overflow Interrupt Enable
        TXOE: u1,
        /// Scheduling Error 1 Interrupt Enable
        SE1E: u1,
        /// Scheduling Error 2 Interrupt Enable
        SE2E: u1,
        /// Change Error Level Interrupt Enable
        ELCE: u1,
        /// Initialization Watch Trigger Interrupt Enable
        IWTGE: u1,
        /// Watch Trigger Interrupt Enable
        WTE: u1,
        /// Application Watchdog Interrupt Enable
        AWE: u1,
        /// Configuration Error Interrupt Enable
        CERE: u1,
        padding: u13 = 0,
    }),
    /// FDCAN TT Interrupt Line Select Register
    /// offset: 0x128
    TTILS: mmio.Mmio(packed struct(u32) {
        /// Start of Basic Cycle Interrupt Line
        SBCL: u1,
        /// Start of Matrix Cycle Interrupt Line
        SMCL: u1,
        /// Change of Synchronization Mode Interrupt Line
        CSML: u1,
        /// Start of Gap Interrupt Line
        SOGL: u1,
        /// Register Time Mark Interrupt Line
        RTMIL: u1,
        /// Trigger Time Mark Event Internal Interrupt Line
        TTMIL: u1,
        /// Stop Watch Event Interrupt Line
        SWEL: u1,
        /// Global Time Wrap Interrupt Line
        GTWL: u1,
        /// Global Time Discontinuity Interrupt Line
        GTDL: u1,
        /// Global Time Error Interrupt Line
        GTEL: u1,
        /// Tx Count Underflow Interrupt Line
        TXUL: u1,
        /// Tx Count Overflow Interrupt Line
        TXOL: u1,
        /// Scheduling Error 1 Interrupt Line
        SE1L: u1,
        /// Scheduling Error 2 Interrupt Line
        SE2L: u1,
        /// Change Error Level Interrupt Line
        ELCL: u1,
        /// Initialization Watch Trigger Interrupt Line
        IWTGL: u1,
        /// Watch Trigger Interrupt Line
        WTL: u1,
        /// Application Watchdog Interrupt Line
        AWL: u1,
        /// Configuration Error Interrupt Line
        CERL: u1,
        padding: u13 = 0,
    }),
    /// FDCAN TT Operation Status Register
    /// offset: 0x12c
    TTOST: mmio.Mmio(packed struct(u32) {
        /// Error Level
        EL: u2,
        /// Master State
        MS: u2,
        /// Synchronization State
        SYS: u2,
        /// Quality of Global Time Phase
        QGTP: u1,
        /// Quality of Clock Speed
        QCS: u1,
        /// Reference Trigger Offset
        RTO: u8,
        reserved22: u6 = 0,
        /// Wait for Global Time Discontinuity
        WGTD: u1,
        /// Gap Finished Indicator
        GFI: u1,
        /// Time Master Priority
        TMP: u3,
        /// Gap Started Indicator
        GSI: u1,
        /// Wait for Event
        WFE: u1,
        /// Application Watchdog Event
        AWE: u1,
        /// Wait for External Clock Synchronization
        WECS: u1,
        /// Schedule Phase Lock
        SPL: u1,
    }),
    /// FDCAN TUR Numerator Actual Register
    /// offset: 0x130
    TURNA: mmio.Mmio(packed struct(u32) {
        /// Numerator Actual Value
        NAV: u18,
        padding: u14 = 0,
    }),
    /// FDCAN TT Local and Global Time Register
    /// offset: 0x134
    TTLGT: mmio.Mmio(packed struct(u32) {
        /// Local Time
        LT: u16,
        /// Global Time
        GT: u16,
    }),
    /// FDCAN TT Cycle Time and Count Register
    /// offset: 0x138
    TTCTC: mmio.Mmio(packed struct(u32) {
        /// Cycle Time
        CT: u16,
        /// Cycle Count
        CC: u6,
        padding: u10 = 0,
    }),
    /// FDCAN TT Capture Time Register
    /// offset: 0x13c
    TTCPT: mmio.Mmio(packed struct(u32) {
        /// Cycle Count Value
        CCV: u6,
        reserved16: u10 = 0,
        /// Stop Watch Value
        SWV: u16,
    }),
    /// FDCAN TT Cycle Sync Mark Register
    /// offset: 0x140
    TTCSM: mmio.Mmio(packed struct(u32) {
        /// Cycle Sync Mark
        CSM: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x144
    reserved324: [444]u8,
    /// FDCAN TT Trigger Select Register
    /// offset: 0x300
    TTTS: mmio.Mmio(packed struct(u32) {
        /// Stop watch trigger input selection
        SWTDEL: u2,
        reserved4: u2 = 0,
        /// Event trigger input selection
        EVTSEL: u2,
        padding: u26 = 0,
    }),
};
