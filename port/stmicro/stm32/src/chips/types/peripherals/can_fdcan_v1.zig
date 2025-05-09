const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ACT = enum(u2) {
    /// Synchronizing: node is synchronizing on CAN communication.
    SYNC = 0x0,
    /// Idle: node is neither receiver nor transmitter.
    IDLE = 0x1,
    /// Receiver: node is operating as receiver.
    RX = 0x2,
    /// Transmitter: node is operating as transmitter.
    TX = 0x3,
};

pub const ANFE = enum(u2) {
    /// Accept in Rx FIFO 0
    ACCEPT_FIFO_0 = 0x0,
    /// Accept in Rx FIFO 1
    ACCEPT_FIFO_1 = 0x1,
    /// Reject
    REJECT = 0x2,
    _,
};

pub const ANFS = enum(u2) {
    /// Accept in Rx FIFO 0
    ACCEPT_FIFO_0 = 0x0,
    /// Accept in Rx FIFO 1
    ACCEPT_FIFO_1 = 0x1,
    /// Reject
    REJECT = 0x2,
    _,
};

pub const LEC = enum(u3) {
    /// No Error: No error occurred since LEC has been reset by successful reception or transmission.
    NO_ERROR = 0x0,
    /// Stuff Error: More than 5 equal bits in a sequence have occurred in a part of a received message where this is not allowed.
    STUFF = 0x1,
    /// Form Error: A fixed format part of a received frame has the wrong format.
    FORM = 0x2,
    /// AckError: The message transmitted by the FDCAN was not acknowledged by another node.
    ACK = 0x3,
    /// Bit1Error: During the transmission of a message (with the exception of the arbitration field), the device wanted to send a recessive level (bit of logical value 1), but the monitored bus value was dominant.
    BIT_1 = 0x4,
    /// Bit0Error: During the transmission of a message (or acknowledge bit, or active error flag, or overload flag), the device wanted to send a dominant level (data or identifier bit logical value 0), but the monitored bus value was recessive. During Bus_Off recovery this status is set each time a sequence of 11 recessive bits has been monitored. This enables the CPU to monitor the proceeding of the Bus_Off recovery sequence (indicating the bus is not stuck at dominant or continuously disturbed).
    BIT_0 = 0x5,
    /// CRCError: The CRC check sum of a received message was incorrect. The CRC of an incoming message does not match with the CRC calculated from the received data.
    CRC = 0x6,
    /// NoChange: Any read access to the Protocol status register re-initializes the LEC to ‘7’. When the LEC shows the value ‘7’, no CAN bus event was detected since the last CPU read access to the Protocol status register.
    NO_CHANGE = 0x7,
};

pub const MSI = enum(u2) {
    /// No FIFO selected
    NO_FIFO = 0x0,
    /// FIFO overrun
    OVERRUN = 0x1,
    /// Message stored in FIFO 0
    FIFO_0 = 0x2,
    /// Message stored in FIFO 1
    FIFO_1 = 0x3,
};

pub const PDIV = enum(u4) {
    /// Divide by 1
    DIV_1 = 0x0,
    /// Divide by 2
    DIV_2 = 0x1,
    /// Divide by 4
    DIV_4 = 0x2,
    /// Divide by 6
    DIV_6 = 0x3,
    /// Divide by 8
    DIV_8 = 0x4,
    /// Divide by 10
    DIV_10 = 0x5,
    /// Divide by 12
    DIV_12 = 0x6,
    /// Divide by 14
    DIV_14 = 0x7,
    /// Divide by 16
    DIV_16 = 0x8,
    /// Divide by 18
    DIV_18 = 0x9,
    /// Divide by 20
    DIV_20 = 0xa,
    /// Divide by 22
    DIV_22 = 0xb,
    /// Divide by 24
    DIV_24 = 0xc,
    /// Divide by 26
    DIV_26 = 0xd,
    /// Divide by 28
    DIV_28 = 0xe,
    /// Divide by 30
    DIV_30 = 0xf,
};

pub const TFQM = enum(u1) {
    /// Tx FIFO operation
    FIFO = 0x0,
    /// Tx queue operation
    QUEUE = 0x1,
};

pub const TOS = enum(u2) {
    /// Continuous operation
    CONTINUOUS = 0x0,
    /// Timeout controlled by Tx event FIFO
    TX_EVENT_FIFO = 0x1,
    /// Timeout controlled by Rx FIFO 0
    RX_FIFO_0 = 0x2,
    /// Timeout controlled by Rx FIFO 1
    RX_FIFO_1 = 0x3,
};

pub const TSS = enum(u2) {
    /// Timestamp counter value always 0x0000
    ZERO = 0x0,
    /// Timestamp counter value incremented according to TCP
    INCREMENT = 0x1,
    /// External timestamp counter from TIM3 value (tim3_cnt[0:15])
    EXTERNAL = 0x2,
    _,
};

pub const TX = enum(u2) {
    /// Reset value, FDCANx_TX TX is controlled by the CAN core, updated at the end of the CAN bit time
    RESET = 0x0,
    /// Sample point can be monitored at pin FDCANx_TX
    SAMPLE_POINT = 0x1,
    /// Dominant (0) level at pin FDCANx_TX
    DOMINANT = 0x2,
    /// Recessive (1) at pin FDCANx_TX
    RECESSIVE = 0x3,
};

/// Controller area network with flexible data rate (FD)
pub const FDCAN = extern struct {
    /// FDCAN core release register
    /// offset: 0x00
    CREL: mmio.Mmio(packed struct(u32) {
        /// DAY
        DAY: u8,
        /// MON
        MON: u8,
        /// YEAR
        YEAR: u4,
        /// SUBSTEP
        SUBSTEP: u4,
        /// STEP
        STEP: u4,
        /// REL
        REL: u4,
    }),
    /// FDCAN endian register
    /// offset: 0x04
    ENDN: mmio.Mmio(packed struct(u32) {
        /// Endianness test value. The endianness test value is 0x8765 4321
        ETV: u32,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// FDCAN data bit timing and prescaler register
    /// offset: 0x0c
    DBTP: mmio.Mmio(packed struct(u32) {
        /// Synchronization jump width. Must always be smaller than DTSEG2, valid values are 0 to 15. The value used by the hardware is the one programmed, incremented by 1: tSJW = (DSJW + 1) x tq.
        DSJW: u4,
        /// Data time segment after sample point. Valid values are 0 to 15. The value used by the hardware is the one programmed, incremented by 1, i.e. tBS2 = (DTSEG2 + 1) x tq
        DTSEG2: u4,
        /// Data time segment before sample point. Valid values are 0 to 31. The value used by the hardware is the one programmed, incremented by 1, i.e. tBS1 = (DTSEG1 + 1) x tq
        DTSEG1: u5,
        reserved16: u3 = 0,
        /// Data bit rate prescaler. The value by which the oscillator frequency is divided to generate the bit time quanta. The bit time is built up from a multiple of this quanta. Valid values for the Baud Rate Prescaler are 0 to 31. The hardware interpreters this value as the value programmed plus 1
        DBRP: u5,
        reserved23: u2 = 0,
        /// Transceiver delay compensation
        TDC: u1,
        padding: u8 = 0,
    }),
    /// FDCAN test register
    /// offset: 0x10
    TEST: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Loop back mode
        LBCK: u1,
        /// Control of transmit pin
        TX: TX,
        /// Receive pin. Monitors the actual value of pin FDCANx_RX
        RX: u1,
        padding: u24 = 0,
    }),
    /// FDCAN RAM watchdog register
    /// offset: 0x14
    RWD: mmio.Mmio(packed struct(u32) {
        /// Watchdog configuration. Start value of the message RAM watchdog counter. With the reset value of 00, the counter is disabled. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of FDCAN_CCCR register are set to 1
        WDC: u8,
        /// Watchdog value. Actual message RAM watchdog counter value
        WDV: u8,
        padding: u16 = 0,
    }),
    /// FDCAN CC control register
    /// offset: 0x18
    CCCR: mmio.Mmio(packed struct(u32) {
        /// Initialization
        INIT: u1,
        /// Configuration change enable
        CCE: u1,
        /// ASM restricted operation mode. The restricted operation mode is intended for applications that adapt themselves to different CAN bit rates. The application tests different bit rates and leaves the Restricted operation Mode after it has received a valid frame. In the optional Restricted operation Mode the node is able to transmit and receive data and remote frames and it gives acknowledge to valid frames, but it does not send active error frames or overload frames. In case of an error condition or overload condition, it does not send dominant bits, instead it waits for the occurrence of bus idle condition to resynchronize itself to the CAN communication. The error counters are not incremented. Bit ASM can only be set by software when both CCE and INIT are set to 1. The bit can be reset by the software at any time
        ASM: u1,
        /// Clock stop acknowledge
        CSA: u1,
        /// Clock stop request
        CSR: u1,
        /// Bus monitoring mode. Bit MON can only be set by software when both CCE and INIT are set to 1. The bit can be reset by the Host at any time
        MON: u1,
        /// Disable automatic retransmission
        DAR: u1,
        /// Test mode enable
        TEST: u1,
        /// FD operation enable
        FDOE: u1,
        /// FDCAN bit rate switching
        BRSE: u1,
        reserved12: u2 = 0,
        /// Protocol exception handling disable
        PXHD: u1,
        /// Edge filtering during bus integration
        EFBI: u1,
        /// If this bit is set, the FDCAN pauses for two CAN bit times before starting the next transmission after successfully transmitting a frame
        TXP: u1,
        /// Non ISO operation. If this bit is set, the FDCAN uses the CAN FD frame format as specified by the Bosch CAN FD Specification V1.0
        NISO: u1,
        padding: u16 = 0,
    }),
    /// FDCAN nominal bit timing and prescaler register
    /// offset: 0x1c
    NBTP: mmio.Mmio(packed struct(u32) {
        /// Nominal time segment after sample point. Valid values are 0 to 127. The actual interpretation by the hardware of this value is such that one more than the programmed value is used
        NTSEG2: u7,
        reserved8: u1 = 0,
        /// Nominal time segment before sample point. Valid values are 0 to 255. The actual interpretation by the hardware of this value is such that one more than the programmed value is used. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        NTSEG1: u8,
        /// Bit rate prescaler. Value by which the oscillator frequency is divided for generating the bit time quanta. The bit time is built up from a multiple of this quanta. Valid values are 0 to 511. The actual interpretation by the hardware of this value is such that one more than the value programmed here is used. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        NBRP: u9,
        /// Nominal (re)synchronization jump width. Valid values are 0 to 127. The actual interpretation by the hardware of this value is such that the used value is the one programmed incremented by one. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        NSJW: u7,
    }),
    /// FDCAN timestamp counter configuration register
    /// offset: 0x20
    TSCC: mmio.Mmio(packed struct(u32) {
        /// Timestamp select. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TSS: TSS,
        reserved16: u14 = 0,
        /// Timestamp counter prescaler. Configures the timestamp and timeout counters time unit in multiples of CAN bit times [1 … 16]. The actual interpretation by the hardware of this value is such that one more than the value programmed here is used. In CAN FD mode the internal timestamp counter TCP does not provide a constant time base due to the different CAN bit times between arbitration phase and data phase. Thus CAN FD requires an external counter for timestamp generation (TSS = 10). These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TCP: u4,
        padding: u12 = 0,
    }),
    /// FDCAN timestamp counter value register
    /// offset: 0x24
    TSCV: mmio.Mmio(packed struct(u32) {
        /// Timestamp counter. The internal/external timestamp counter value is captured on start of frame (both Rx and Tx). When TSCC[TSS] = 01, the timestamp counter is incremented in multiples of CAN bit times [1 … 16] depending on the configuration of TSCC[TCP]. A wrap around sets interrupt flag IR[TSW]. Write access resets the counter to 0. When TSCC.TSS = 10, TSC reflects the external timestamp counter value. A write access has no impact
        TSC: u16,
        padding: u16 = 0,
    }),
    /// FDCAN timeout counter configuration register
    /// offset: 0x28
    TOCC: mmio.Mmio(packed struct(u32) {
        /// Timeout counter enable. This is a protected write (P) bit, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        ETOC: u1,
        /// Timeout select. When operating in Continuous mode, a write to TOCV presets the counter to the value configured by TOCC[TOP] and continues down-counting. When the timeout counter is controlled by one of the FIFOs, an empty FIFO presets the counter to the value configured by TOCC[TOP]. Down-counting is started when the first FIFO element is stored. These are protected write (P) bits, write access is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TOS: TOS,
        reserved16: u13 = 0,
        /// Timeout period. Start value of the timeout counter (down-counter). Configures the timeout period
        TOP: u16,
    }),
    /// FDCAN timeout counter value register
    /// offset: 0x2c
    TOCV: mmio.Mmio(packed struct(u32) {
        /// Timeout counter. The timeout counter is decremented in multiples of CAN bit times [1 … 16] depending on the configuration of TSCC.TCP. When decremented to 0, interrupt flag IR.TOO is set and the timeout counter is stopped. Start and reset/restart conditions are configured via TOCC.TOS
        TOC: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [16]u8,
    /// FDCAN error counter register
    /// offset: 0x40
    ECR: mmio.Mmio(packed struct(u32) {
        /// Transmit error counter. Actual state of the transmit error counter, values between 0 and 255. When CCCR.ASM is set, the CAN protocol controller does not increment TEC and REC when a CAN protocol error is detected, but CEL is still incremented
        TEC: u8,
        /// Receive error counter. Actual state of the receive error counter, values between 0 and 127
        REC: u7,
        /// Receive error passive
        RP: u1,
        /// CAN error logging. The counter is incremented each time when a CAN protocol error causes the transmit error counter or the receive error counter to be incremented. It is reset by read access to CEL. The counter stops at 0xFF; the next increment of TEC or REC sets interrupt flag IR[ELO]. Access type is RX: reset on read.
        CEL: u8,
        padding: u8 = 0,
    }),
    /// FDCAN protocol status register
    /// offset: 0x44
    PSR: mmio.Mmio(packed struct(u32) {
        /// Last error code. The LEC indicates the type of the last error to occur on the CAN bus. This field is cleared to 0 when a message has been transferred (reception or transmission) without error. Access type is RS: set on read.
        LEC: LEC,
        /// Activity. Monitors the module’s CAN communication state
        ACT: ACT,
        /// Error passive
        EP: u1,
        /// Warning Sstatus
        EW: u1,
        /// Bus_Off status
        BO: u1,
        /// Data last error code. Type of last error that occurred in the data phase of a FDCAN format frame with its BRS flag set. Coding is the same as for LEC. This field is cleared to 0 when a FDCAN format frame with its BRS flag set has been transferred (reception or transmission) without error. Access type is RS: set on read.
        DLEC: u3,
        /// ESI flag of last received FDCAN message. This bit is set together with REDL, independent of acceptance filtering. Access type is RX: reset on read.
        RESI: u1,
        /// BRS flag of last received FDCAN message. This bit is set together with REDL, independent of acceptance filtering. Access type is RX: reset on read.
        RBRS: u1,
        /// Received FDCAN message. This bit is set independent of acceptance filtering. Access type is RX: reset on read.
        REDL: u1,
        /// Protocol exception event
        PXE: u1,
        reserved16: u1 = 0,
        /// Transmitter delay compensation value. Position of the secondary sample point, defined by the sum of the measured delay from FDCAN_TX to FDCAN_RX and TDCR.TDCO. The SSP position is, in the data phase, the number of minimum time quanta (mtq) between the start of the transmitted bit and the secondary sample point. Valid values are 0 to 127 mtq
        TDCV: u7,
        padding: u9 = 0,
    }),
    /// FDCAN transmitter delay compensation register
    /// offset: 0x48
    TDCR: mmio.Mmio(packed struct(u32) {
        /// Transmitter delay compensation filter window length. Defines the minimum value for the SSP position, dominant edges on FDCAN_RX that would result in an earlier SSP position are ignored for transmitter delay measurements. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TDCF: u7,
        reserved8: u1 = 0,
        /// Transmitter delay compensation offset. Offset value defining the distance between the measured delay from FDCAN_TX to FDCAN_RX and the secondary sample point. Valid values are 0 to 127 mtq. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TDCO: u7,
        padding: u17 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// FDCAN interrupt register
    /// offset: 0x50
    IR: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X new message
        @"RFN[0]": u1,
        /// Rx FIFO X full
        @"RFF[0]": u1,
        /// Rx FIFO X message lost
        @"RFL[0]": u1,
        /// Rx FIFO X new message
        @"RFN[1]": u1,
        /// Rx FIFO X full
        @"RFF[1]": u1,
        /// Rx FIFO X message lost
        @"RFL[1]": u1,
        /// High-priority message
        HPM: u1,
        /// Transmission completed
        TC: u1,
        /// Transmission cancellation finished
        TCF: u1,
        /// Tx FIFO empty
        TFE: u1,
        /// Tx event FIFO New Entry
        TEFN: u1,
        /// Tx event FIFO full
        TEFF: u1,
        /// Tx event FIFO element lost
        TEFL: u1,
        /// Timestamp wraparound
        TSW: u1,
        /// Message RAM access failure. The flag is set when the Rx handler: has not completed acceptance filtering or storage of an accepted message until the arbitration field of the following message has been received. In this case acceptance filtering or message storage is aborted and the Rx handler starts processing of the following message. was unable to write a message to the message RAM. In this case message storage is aborted. In both cases the FIFO put index is not updated. The partly stored message is overwritten when the next message is stored to this location. The flag is also set when the Tx Handler was not able to read a message from the Message RAM in time. In this case message transmission is aborted. In case of a Tx Handler access failure the FDCAN is switched into Restricted operation Mode (see mode). To leave Restricted operation Mode, the Host CPU has to reset CCCR.ASM.
        MRAF: u1,
        /// Timeout occurred
        TOO: u1,
        /// Error logging overflow
        ELO: u1,
        /// Error passive
        EP: u1,
        /// Warning status
        EW: u1,
        /// Bus_Off status
        BO: u1,
        /// Watchdog interrupt
        WDI: u1,
        /// Protocol error in arbitration phase (nominal bit time is used)
        PEA: u1,
        /// Protocol error in data phase (data bit time is used)
        PED: u1,
        /// Access to reserved address
        ARA: u1,
        padding: u8 = 0,
    }),
    /// FDCAN interrupt enable register
    /// offset: 0x54
    IE: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X new message interrupt enable
        @"RFNE[0]": u1,
        /// Rx FIFO X full interrupt enable
        @"RFFE[0]": u1,
        /// Rx FIFO X message lost interrupt enable
        @"RFLE[0]": u1,
        /// Rx FIFO X new message interrupt enable
        @"RFNE[1]": u1,
        /// Rx FIFO X full interrupt enable
        @"RFFE[1]": u1,
        /// Rx FIFO X message lost interrupt enable
        @"RFLE[1]": u1,
        /// High-priority message interrupt enable
        HPME: u1,
        /// Transmission completed interrupt enable
        TCE: u1,
        /// Transmission cancellation finished interrupt enable
        TCFE: u1,
        /// Tx FIFO empty interrupt enable
        TFEE: u1,
        /// Tx event FIFO new entry interrupt enable
        TEFNE: u1,
        /// Tx event FIFO full interrupt enable
        TEFFE: u1,
        /// Tx event FIFO element lost interrupt enable
        TEFLE: u1,
        /// Timestamp wraparound interrupt enable
        TSWE: u1,
        /// Message RAM access failure interrupt enable
        MRAFE: u1,
        /// Timeout occurred interrupt enable
        TOOE: u1,
        /// Error logging overflow interrupt enable
        ELOE: u1,
        /// Error passive interrupt enable
        EPE: u1,
        /// Warning status interrupt enable
        EWE: u1,
        /// Bus_Off status enable
        BOE: u1,
        /// Watchdog interrupt enable
        WDIE: u1,
        /// Protocol error in arbitration phase enable
        PEAE: u1,
        /// Protocol error in data phase enable
        PEDE: u1,
        /// Access to reserved address enable
        ARAE: u1,
        padding: u8 = 0,
    }),
    /// FDCAN interrupt line select register
    /// offset: 0x58
    ILS: mmio.Mmio(packed struct(u32) {
        /// (1/2 of RXFIFO) RX FIFO bit grouping the following interruption. RFLL: Rx FIFO X message lost interrupt line RFFL: Rx FIFO X full interrupt line RFNL: Rx FIFO X new message interrupt line.
        @"RXFIFO[0]": u1,
        /// (2/2 of RXFIFO) RX FIFO bit grouping the following interruption. RFLL: Rx FIFO X message lost interrupt line RFFL: Rx FIFO X full interrupt line RFNL: Rx FIFO X new message interrupt line.
        @"RXFIFO[1]": u1,
        /// Status message bit grouping the following interruption. TCFL: Transmission cancellation finished interrupt line TCL: Transmission completed interrupt line HPML: High-priority message interrupt line.
        SMSG: u1,
        /// Tx FIFO ERROR grouping the following interruption. TEFLL: Tx event FIFO element lost interrupt line TEFFL: Tx event FIFO full interrupt line TEFNL: Tx event FIFO new entry interrupt line TFEL: Tx FIFO empty interrupt line.
        TFERR: u1,
        /// Interrupt regrouping the following interruption. TOOL: Timeout occurred interrupt line MRAFL: Message RAM access failure interrupt line TSWL: Timestamp wraparound interrupt line.
        MISC: u1,
        /// Bit and line error grouping the following interruption. EPL Error passive interrupt line ELOL: Error logging overflow interrupt line.
        BERR: u1,
        /// Protocol error grouping the following interruption. ARAL: Access to reserved address line PEDL: Protocol error in data phase line PEAL: Protocol error in arbitration phase line WDIL: Watchdog interrupt line BOL: Bus_Off status EWL: Warning status interrupt line.
        PERR: u1,
        padding: u25 = 0,
    }),
    /// FDCAN interrupt line enable register
    /// offset: 0x5c
    ILE: mmio.Mmio(packed struct(u32) {
        /// Enable interrupt line 0
        EINT0: u1,
        /// Enable interrupt line 1
        EINT1: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x60
    reserved96: [32]u8,
    /// FDCAN global filter configuration register
    /// offset: 0x80
    RXGFC: mmio.Mmio(packed struct(u32) {
        /// Reject remote frames extended. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        RRFE: u1,
        /// Reject remote frames standard. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        RRFS: u1,
        /// Accept non-matching frames extended. Defines how received messages with 29-bit IDs that do not match any element of the filter list are treated. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        ANFE: ANFE,
        /// Accept Non-matching frames standard. Defines how received messages with 11-bit IDs that do not match any element of the filter list are treated. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        ANFS: ANFS,
        reserved8: u2 = 0,
        /// FIFO 1 operation mode (overwrite or blocking). This is a protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        F1OM: u1,
        /// FIFO 0 operation mode (overwrite or blocking). This is protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        F0OM: u1,
        reserved16: u6 = 0,
        /// List size standard. >28: Values greater than 28 are interpreted as 28. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1.
        LSS: u5,
        reserved24: u3 = 0,
        /// List size extended. >8: Values greater than 8 are interpreted as 8. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1.
        LSE: u4,
        padding: u4 = 0,
    }),
    /// FDCAN extended ID and mask register
    /// offset: 0x84
    XIDAM: mmio.Mmio(packed struct(u32) {
        /// Extended ID mask. For acceptance filtering of extended frames the Extended ID AND Mask is AND-ed with the Message ID of a received frame. Intended for masking of 29-bit IDs in SAE J1939. With the reset value of all bits set to 1 the mask is not active. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        EIDM: u29,
        padding: u3 = 0,
    }),
    /// FDCAN high-priority message status register
    /// offset: 0x88
    HPMS: mmio.Mmio(packed struct(u32) {
        /// Buffer index. Index of Rx FIFO element to which the message was stored. Only valid when MSI[1] = 1
        BIDX: u3,
        reserved6: u3 = 0,
        /// Message storage indicator
        MSI: MSI,
        /// Filter index. Index of matching filter element. Range is 0 to RXGFC[LSS] - 1 or RXGFC[LSE] - 1
        FIDX: u5,
        reserved15: u2 = 0,
        /// Filter list. Indicates the filter list of the matching filter element
        FLST: u1,
        padding: u16 = 0,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// FDCAN Rx FIFO X status register
    /// offset: 0x90
    RXFS: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X fill level. Number of elements stored in Rx FIFO X, range 0 to 3
        FFL: u4,
        reserved8: u4 = 0,
        /// Rx FIFO X get index. Rx FIFO X read index pointer, range 0 to 2
        FGI: u2,
        reserved16: u6 = 0,
        /// Rx FIFO X put index. Rx FIFO X write index pointer, range 0 to 2
        FPI: u2,
        reserved24: u6 = 0,
        /// Rx FIFO X full
        FF: u1,
        /// Rx FIFO X message lost. This bit is a copy of interrupt flag IR[RFL]. When IR[RFL] is reset, this bit is also reset
        RFL: u1,
        padding: u6 = 0,
    }),
    /// CAN Rx FIFO X acknowledge register
    /// offset: 0x94
    RXFA: mmio.Mmio(packed struct(u32) {
        /// Rx FIFO X acknowledge index. After the Host has read a message or a sequence of messages from Rx FIFO X it has to write the buffer index of the last element read from Rx FIFO X to FAI. This sets the Rx FIFO X get index RXFS[FGI] to FAI + 1 and update the FIFO X fill level RXFS[FFL]
        FAI: u3,
        padding: u29 = 0,
    }),
    /// offset: 0x98
    reserved152: [40]u8,
    /// FDCAN Tx buffer configuration register
    /// offset: 0xc0
    TXBC: mmio.Mmio(packed struct(u32) {
        reserved24: u24 = 0,
        /// Tx FIFO/queue mode. This is a protected write (P) bit, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        TFQM: TFQM,
        padding: u7 = 0,
    }),
    /// FDCAN Tx FIFO/queue status register
    /// offset: 0xc4
    TXFQS: mmio.Mmio(packed struct(u32) {
        /// Tx FIFO free level. Number of consecutive free Tx FIFO elements starting from TFGI, range 0 to 3. Read as 0 when Tx queue operation is configured (TXBC[TFQM] = 1)
        TFFL: u3,
        reserved8: u5 = 0,
        /// Tx FIFO get index. Tx FIFO read index pointer, range 0 to 3. Read as 0 when Tx queue operation is configured (TXBC.TFQM = 1)
        TFGI: u2,
        reserved16: u6 = 0,
        /// Tx FIFO/queue put index. Tx FIFO/queue write index pointer, range 0 to 3
        TFQPI: u2,
        reserved21: u3 = 0,
        /// Tx FIFO/queue full
        TFQF: u1,
        padding: u10 = 0,
    }),
    /// FDCAN Tx buffer request pending register
    /// offset: 0xc8
    TXBRP: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TRP) Transmission request pending. Each Tx buffer has its own transmission request pending bit. The bits are set via register TXBAR. The bits are reset after a requested transmission has completed or has been canceled via register TXBCR. After a TXBRP bit has been set, a Tx scan is started to check for the pending Tx request with the highest priority (Tx buffer with lowest Message ID). A cancellation request resets the corresponding transmission request pending bit of register TXBRP. In case a transmission has already been started when a cancellation is requested, this is done at the end of the transmission, regardless whether the transmission was successful or not. The cancellation request bits are reset directly after the corresponding TXBRP bit has been reset. After a cancellation has been requested, a finished cancellation is signaled via TXBCF after successful transmission together with the corresponding TXBTO bit when the transmission has not yet been started at the point of cancellation when the transmission has been aborted due to lost arbitration when an error occurred during frame transmission In DAR mode all transmissions are automatically canceled if they are not successful. The corresponding TXBCF bit is set for all unsuccessful transmissions
        @"TRP[0]": u1,
        /// (2/3 of TRP) Transmission request pending. Each Tx buffer has its own transmission request pending bit. The bits are set via register TXBAR. The bits are reset after a requested transmission has completed or has been canceled via register TXBCR. After a TXBRP bit has been set, a Tx scan is started to check for the pending Tx request with the highest priority (Tx buffer with lowest Message ID). A cancellation request resets the corresponding transmission request pending bit of register TXBRP. In case a transmission has already been started when a cancellation is requested, this is done at the end of the transmission, regardless whether the transmission was successful or not. The cancellation request bits are reset directly after the corresponding TXBRP bit has been reset. After a cancellation has been requested, a finished cancellation is signaled via TXBCF after successful transmission together with the corresponding TXBTO bit when the transmission has not yet been started at the point of cancellation when the transmission has been aborted due to lost arbitration when an error occurred during frame transmission In DAR mode all transmissions are automatically canceled if they are not successful. The corresponding TXBCF bit is set for all unsuccessful transmissions
        @"TRP[1]": u1,
        /// (3/3 of TRP) Transmission request pending. Each Tx buffer has its own transmission request pending bit. The bits are set via register TXBAR. The bits are reset after a requested transmission has completed or has been canceled via register TXBCR. After a TXBRP bit has been set, a Tx scan is started to check for the pending Tx request with the highest priority (Tx buffer with lowest Message ID). A cancellation request resets the corresponding transmission request pending bit of register TXBRP. In case a transmission has already been started when a cancellation is requested, this is done at the end of the transmission, regardless whether the transmission was successful or not. The cancellation request bits are reset directly after the corresponding TXBRP bit has been reset. After a cancellation has been requested, a finished cancellation is signaled via TXBCF after successful transmission together with the corresponding TXBTO bit when the transmission has not yet been started at the point of cancellation when the transmission has been aborted due to lost arbitration when an error occurred during frame transmission In DAR mode all transmissions are automatically canceled if they are not successful. The corresponding TXBCF bit is set for all unsuccessful transmissions
        @"TRP[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer add request register
    /// offset: 0xcc
    TXBAR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of AR) Add request. Each Tx buffer has its own add request bit. Writing a 1 sets the corresponding add request bit; writing a 0 has no impact. This enables the Host to set transmission requests for multiple Tx buffers with one write to TXBAR. When no Tx scan is running, the bits are reset immediately, else the bits remain set until the Tx scan process has completed
        @"AR[0]": u1,
        /// (2/3 of AR) Add request. Each Tx buffer has its own add request bit. Writing a 1 sets the corresponding add request bit; writing a 0 has no impact. This enables the Host to set transmission requests for multiple Tx buffers with one write to TXBAR. When no Tx scan is running, the bits are reset immediately, else the bits remain set until the Tx scan process has completed
        @"AR[1]": u1,
        /// (3/3 of AR) Add request. Each Tx buffer has its own add request bit. Writing a 1 sets the corresponding add request bit; writing a 0 has no impact. This enables the Host to set transmission requests for multiple Tx buffers with one write to TXBAR. When no Tx scan is running, the bits are reset immediately, else the bits remain set until the Tx scan process has completed
        @"AR[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer cancellation request register
    /// offset: 0xd0
    TXBCR: mmio.Mmio(packed struct(u32) {
        /// (1/3 of CR) Cancellation request. Each Tx buffer has its own cancellation request bit. Writing a 1 sets the corresponding CR bit; writing a 0 has no impact. This enables the Host to set cancellation requests for multiple Tx buffers with one write to TXBCR. The bits remain set until the corresponding TXBRP bit is reset
        @"CR[0]": u1,
        /// (2/3 of CR) Cancellation request. Each Tx buffer has its own cancellation request bit. Writing a 1 sets the corresponding CR bit; writing a 0 has no impact. This enables the Host to set cancellation requests for multiple Tx buffers with one write to TXBCR. The bits remain set until the corresponding TXBRP bit is reset
        @"CR[1]": u1,
        /// (3/3 of CR) Cancellation request. Each Tx buffer has its own cancellation request bit. Writing a 1 sets the corresponding CR bit; writing a 0 has no impact. This enables the Host to set cancellation requests for multiple Tx buffers with one write to TXBCR. The bits remain set until the corresponding TXBRP bit is reset
        @"CR[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer transmission occurred register
    /// offset: 0xd4
    TXBTO: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TO) Transmission occurred.. Each Tx buffer has its own TO bit. The bits are set when the corresponding TXBRP bit is cleared after a successful transmission. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"TO[0]": u1,
        /// (2/3 of TO) Transmission occurred.. Each Tx buffer has its own TO bit. The bits are set when the corresponding TXBRP bit is cleared after a successful transmission. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"TO[1]": u1,
        /// (3/3 of TO) Transmission occurred.. Each Tx buffer has its own TO bit. The bits are set when the corresponding TXBRP bit is cleared after a successful transmission. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"TO[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer cancellation finished register
    /// offset: 0xd8
    TXBCF: mmio.Mmio(packed struct(u32) {
        /// (1/3 of CF) Cancellation finished. Each Tx buffer has its own CF bit. The bits are set when the corresponding TXBRP bit is cleared after a cancellation was requested via TXBCR. In case the corresponding TXBRP bit was not set at the point of cancellation, CF is set immediately. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"CF[0]": u1,
        /// (2/3 of CF) Cancellation finished. Each Tx buffer has its own CF bit. The bits are set when the corresponding TXBRP bit is cleared after a cancellation was requested via TXBCR. In case the corresponding TXBRP bit was not set at the point of cancellation, CF is set immediately. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"CF[1]": u1,
        /// (3/3 of CF) Cancellation finished. Each Tx buffer has its own CF bit. The bits are set when the corresponding TXBRP bit is cleared after a cancellation was requested via TXBCR. In case the corresponding TXBRP bit was not set at the point of cancellation, CF is set immediately. The bits are reset when a new transmission is requested by writing a 1 to the corresponding bit of register TXBAR
        @"CF[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer transmission interrupt enable register
    /// offset: 0xdc
    TXBTIE: mmio.Mmio(packed struct(u32) {
        /// (1/3 of TIE) Transmission interrupt enable. Each Tx buffer has its own TIE bit
        @"TIE[0]": u1,
        /// (2/3 of TIE) Transmission interrupt enable. Each Tx buffer has its own TIE bit
        @"TIE[1]": u1,
        /// (3/3 of TIE) Transmission interrupt enable. Each Tx buffer has its own TIE bit
        @"TIE[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx buffer cancellation finished interrupt enable register
    /// offset: 0xe0
    TXBCIE: mmio.Mmio(packed struct(u32) {
        /// (1/3 of CFIE) Cancellation finished interrupt enable.. Each Tx buffer has its own CFIE bit
        @"CFIE[0]": u1,
        /// (2/3 of CFIE) Cancellation finished interrupt enable.. Each Tx buffer has its own CFIE bit
        @"CFIE[1]": u1,
        /// (3/3 of CFIE) Cancellation finished interrupt enable.. Each Tx buffer has its own CFIE bit
        @"CFIE[2]": u1,
        padding: u29 = 0,
    }),
    /// FDCAN Tx event FIFO status register
    /// offset: 0xe4
    TXEFS: mmio.Mmio(packed struct(u32) {
        /// Event FIFO fill level. Number of elements stored in Tx event FIFO, range 0 to 3
        EFFL: u3,
        reserved8: u5 = 0,
        /// Event FIFO get index. Tx event FIFO read index pointer, range 0 to 3
        EFGI: u2,
        reserved16: u6 = 0,
        /// Event FIFO put index. Tx event FIFO write index pointer, range 0 to 3
        EFPI: u2,
        reserved24: u6 = 0,
        /// Event FIFO full
        EFF: u1,
        /// Tx event FIFO element lost. This bit is a copy of interrupt flag IR[TEFL]. When IR[TEFL] is reset, this bit is also reset. 0 No Tx event FIFO element lost 1 Tx event FIFO element lost, also set after write attempt to Tx event FIFO of size 0
        TEFL: u1,
        padding: u6 = 0,
    }),
    /// FDCAN Tx event FIFO acknowledge register
    /// offset: 0xe8
    TXEFA: mmio.Mmio(packed struct(u32) {
        /// Event FIFO acknowledge index. After the Host has read an element or a sequence of elements from the Tx event FIFO, it has to write the index of the last element read from Tx event FIFO to EFAI. This sets the Tx event FIFO get index TXEFS[EFGI] to EFAI + 1 and updates the FIFO 0 fill level TXEFS[EFFL]
        EFAI: u2,
        padding: u30 = 0,
    }),
    /// offset: 0xec
    reserved236: [20]u8,
    /// FDCAN CFG clock divider register
    /// offset: 0x100
    CKDIV: mmio.Mmio(packed struct(u32) {
        /// input clock divider. The APB clock could be divided prior to be used by the CAN sub system. The rate must be computed using the divider output clock. These are protected write (P) bits, which means that write access by the bits is possible only when the bit 1 [CCE] and bit 0 [INIT] of CCCR register are set to 1
        PDIV: PDIV,
        padding: u28 = 0,
    }),
};
