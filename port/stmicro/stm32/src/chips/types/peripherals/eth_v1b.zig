const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const APCS = enum(u1) {
    /// MAC passes all incoming frames unmodified
    Disabled = 0x0,
    /// MAC strips the Pad/FCS field on incoming frames only for lengths less than or equal to 1500 bytes
    Strip = 0x1,
};

pub const BFD = enum(u1) {
    /// Address filters pass all received broadcast frames
    Enabled = 0x0,
    /// Address filters filter all incoming broadcast frames
    Disabled = 0x1,
};

pub const BL = enum(u2) {
    /// For retransmission n, wait up to 2^min(n, 10) time slots
    BL10 = 0x0,
    /// For retransmission n, wait up to 2^min(n, 8) time slots
    BL8 = 0x1,
    /// For retransmission n, wait up to 2^min(n, 4) time slots
    BL4 = 0x2,
    /// For retransmission n, wait up to 2^min(n, 1) time slots
    BL1 = 0x3,
};

pub const CR = enum(u3) {
    /// 60-100MHz HCLK/42
    CR_60_100 = 0x0,
    /// 100-150 MHz HCLK/62
    CR_100_150 = 0x1,
    /// 20-35MHz HCLK/16
    CR_20_35 = 0x2,
    /// 35-60MHz HCLK/16
    CR_35_60 = 0x3,
    /// 150-168MHz HCLK/102
    CR_150_168 = 0x4,
    _,
};

pub const CSD = enum(u1) {
    /// Errors generated due to loss of carrier
    Enabled = 0x0,
    /// No error generated due to loss of carrier
    Disabled = 0x1,
};

pub const CSR = enum(u1) {
    /// Counters roll over to zero after reaching the maximum value
    Rollover = 0x0,
    /// Counters do not roll over to zero after reaching the maximum value
    NotRollover = 0x1,
};

pub const CounterReset = enum(u1) {
    /// Reset all counters. Cleared automatically
    Reset = 0x1,
    _,
};

pub const DA = enum(u1) {
    /// Round-robin with Rx:Tx priority given by PM
    RoundRobin = 0x0,
    /// Rx has priority over Tx
    RxPriority = 0x1,
};

pub const DAIF = enum(u1) {
    /// Normal filtering of frames
    Normal = 0x0,
    /// Address check block operates in inverse filtering mode for the DA address comparison
    Invert = 0x1,
};

pub const DM = enum(u1) {
    /// MAC operates in half-duplex mode
    HalfDuplex = 0x0,
    /// MAC operates in full-duplex mode
    FullDuplex = 0x1,
};

pub const DMAOMR_SR = enum(u1) {
    /// Reception is stopped after transfer of the current frame
    Stopped = 0x0,
    /// Reception is placed in the Running state
    Started = 0x1,
};

pub const DTCEFD = enum(u1) {
    /// Drop frames with errors only in the receive checksum offload engine
    Enabled = 0x0,
    /// Do not drop frames that only have errors in the receive checksum offload engine
    Disabled = 0x1,
};

pub const FB = enum(u1) {
    /// AHB uses SINGLE and INCR burst transfers
    Variable = 0x0,
    /// AHB uses only fixed burst transfers
    Fixed = 0x1,
};

pub const FCB = enum(u1) {
    /// In half duplex only, deasserts back pressure
    DisableBackPressure = 0x0,
    /// In full duplex, initiate a Pause control frame. In half duplex, assert back pressure
    PauseOrBackPressure = 0x1,
};

pub const FEF = enum(u1) {
    /// Rx FIFO drops frames with error status
    Drop = 0x0,
    /// All frames except runt error frames are forwarded to the DMA
    Forward = 0x1,
};

pub const FES = enum(u1) {
    /// 10 Mbit/s
    FES10 = 0x0,
    /// 100 Mbit/s
    FES100 = 0x1,
};

pub const FPM = enum(u1) {
    /// PBL values used as-is
    x1 = 0x0,
    /// PBL values multiplied by 4
    x4 = 0x1,
};

pub const FTF = enum(u1) {
    /// Transmit FIFO controller logic is reset to its default values. Cleared automatically
    Flush = 0x1,
    _,
};

pub const FUGF = enum(u1) {
    /// Rx FIFO drops all frames of less than 64 bytes
    Drop = 0x0,
    /// Rx FIFO forwards undersized frames
    Forward = 0x1,
};

pub const HM = enum(u1) {
    /// MAC performs a perfect destination address filtering for multicast frames
    Perfect = 0x0,
    /// MAC performs destination address filtering of received multicast frames according to the hash table
    Hash = 0x1,
};

pub const HPF = enum(u1) {
    /// If HM or HU is set, only frames that match the Hash filter are passed
    HashOnly = 0x0,
    /// If HM or HU is set, frames that match either the perfect filter or the hash filter are passed
    HashOrPerfect = 0x1,
};

pub const HU = enum(u1) {
    /// MAC performs a perfect destination address filtering for unicast frames
    Perfect = 0x0,
    /// MAC performs destination address filtering of received unicast frames according to the hash table
    Hash = 0x1,
};

pub const IFG = enum(u3) {
    /// 96 bit times
    IFG96 = 0x0,
    /// 88 bit times
    IFG88 = 0x1,
    /// 80 bit times
    IFG80 = 0x2,
    /// 72 bit times
    IFG72 = 0x3,
    /// 64 bit times
    IFG64 = 0x4,
    /// 56 bit times
    IFG56 = 0x5,
    /// 48 bit times
    IFG48 = 0x6,
    /// 40 bit times
    IFG40 = 0x7,
};

pub const IPCO = enum(u1) {
    /// IPv4 checksum offload disabled
    Disabled = 0x0,
    /// IPv4 checksums are checked in received frames
    Offload = 0x1,
};

pub const JD = enum(u1) {
    /// Jabber enabled, transmit frames up to 2048 bytes
    Enabled = 0x0,
    /// Jabber disabled, transmit frames up to 16384 bytes
    Disabled = 0x1,
};

pub const LM = enum(u1) {
    /// Normal mode
    Normal = 0x0,
    /// MAC operates in loopback mode at the MII
    Loopback = 0x1,
};

pub const MACAHR_SA = enum(u1) {
    /// This address is used for comparison with DA fields of the received frame
    Destination = 0x0,
    /// This address is used for comparison with SA fields of received frames
    Source = 0x1,
};

pub const MB = enum(u1) {
    /// Fixed burst transfers (INCRx and SINGLE) for burst lengths of 16 and below
    Normal = 0x0,
    /// If FB is low, start all bursts greater than 16 with INCR (undefined burst)
    Mixed = 0x1,
};

pub const MB_progress = enum(u1) {
    /// This bit is set to 1 by the application to indicate that a read or write access is in progress
    Busy = 0x1,
    _,
};

pub const MCFHP = enum(u1) {
    /// When MCP is set, MMC counters are preset to almost-half value 0x7FFF_FFF0
    AlmostHalf = 0x0,
    /// When MCP is set, MMC counters are preset to almost-full value 0xFFFF_FFF0
    AlmostFull = 0x1,
};

pub const MCP = enum(u1) {
    /// MMC counters will be preset to almost full or almost half. Cleared automatically
    Preset = 0x1,
    _,
};

pub const MW = enum(u1) {
    /// Read operation
    Read = 0x0,
    /// Write operation
    Write = 0x1,
};

pub const PBL = enum(u6) {
    /// Maximum of 1 beat per DMA transaction
    PBL1 = 0x1,
    /// Maximum of 2 beats per DMA transaction
    PBL2 = 0x2,
    /// Maximum of 4 beats per DMA transaction
    PBL4 = 0x4,
    /// Maximum of 8 beats per DMA transaction
    PBL8 = 0x8,
    /// Maximum of 16 beats per DMA transaction
    PBL16 = 0x10,
    /// Maximum of 32 beats per DMA transaction
    PBL32 = 0x20,
    _,
};

pub const PCF = enum(u2) {
    /// MAC prevents all control frames from reaching the application
    PreventAll = 0x0,
    /// MAC forwards all control frames to application except Pause
    ForwardAllExceptPause = 0x1,
    /// MAC forwards all control frames to application even if they fail the address filter
    ForwardAll = 0x2,
    /// MAC forwards control frames that pass the address filter
    ForwardAllFiltered = 0x3,
};

pub const PD = enum(u1) {
    /// All received frames will be dropped. Cleared automatically when a magic packet or wakeup frame is received
    Enabled = 0x1,
    _,
};

pub const PLT = enum(u2) {
    /// Pause time minus 4 slot times
    PLT4 = 0x0,
    /// Pause time minus 28 slot times
    PLT28 = 0x1,
    /// Pause time minus 144 slot times
    PLT144 = 0x2,
    /// Pause time minus 256 slot times
    PLT256 = 0x3,
};

pub const PMTIM = enum(u1) {
    /// PMT Status interrupt generation enabled
    Unmasked = 0x0,
    /// PMT Status interrupt generation disabled
    Masked = 0x1,
};

pub const PriorityRxOverTx = enum(u2) {
    /// RxDMA priority over TxDMA is 1:1
    OneToOne = 0x0,
    /// RxDMA priority over TxDMA is 2:1
    TwoToOne = 0x1,
    /// RxDMA priority over TxDMA is 3:1
    ThreeToOne = 0x2,
    /// RxDMA priority over TxDMA is 4:1
    FourToOne = 0x3,
};

pub const RD = enum(u1) {
    /// MAC attempts retries based on the settings of BL
    Enabled = 0x0,
    /// MAC attempts only 1 transmission
    Disabled = 0x1,
};

pub const RDP = enum(u6) {
    /// 1 beat per RxDMA transaction
    RDP1 = 0x1,
    /// 2 beats per RxDMA transaction
    RDP2 = 0x2,
    /// 4 beats per RxDMA transaction
    RDP4 = 0x4,
    /// 8 beats per RxDMA transaction
    RDP8 = 0x8,
    /// 16 beats per RxDMA transaction
    RDP16 = 0x10,
    /// 32 beats per RxDMA transaction
    RDP32 = 0x20,
    _,
};

pub const RFAEM = enum(u1) {
    /// Received-alignment-error counter half-full interrupt enabled
    Unmasked = 0x0,
    /// Received-alignment-error counter half-full interrupt disabled
    Masked = 0x1,
};

pub const RFCEM = enum(u1) {
    /// Received-crc-error counter half-full interrupt enabled
    Unmasked = 0x0,
    /// Received-crc-error counter half-full interrupt disabled
    Masked = 0x1,
};

pub const RGUFM = enum(u1) {
    /// Received-good-unicast counter half-full interrupt enabled
    Unmasked = 0x0,
    /// Received-good-unicast counter half-full interrupt disabled
    Masked = 0x1,
};

pub const ROD = enum(u1) {
    /// MAC receives all packets from PHY while transmitting
    Enabled = 0x0,
    /// MAC disables reception of frames in half-duplex mode
    Disabled = 0x1,
};

pub const RPD = enum(u32) {
    /// Poll the receive descriptor list
    Poll = 0x0,
    _,
};

pub const RPS = enum(u3) {
    /// Stopped, reset or Stop Receive command issued
    Stopped = 0x0,
    /// Running, fetching receive transfer descriptor
    RunningFetching = 0x1,
    /// Running, waiting for receive packet
    RunningWaiting = 0x3,
    /// Suspended, receive descriptor unavailable
    Suspended = 0x4,
    /// Running, writing data to host memory buffer
    RunningWriting = 0x7,
    _,
};

pub const RSF = enum(u1) {
    /// Rx FIFO operates in cut-through mode, subject to RTC bits
    CutThrough = 0x0,
    /// Frames are read from Rx FIFO after complete frame has been written
    StoreForward = 0x1,
};

pub const RTC = enum(u2) {
    /// 64 bytes
    RTC64 = 0x0,
    /// 32 bytes
    RTC32 = 0x1,
    /// 96 bytes
    RTC96 = 0x2,
    /// 128 bytes
    RTC128 = 0x3,
};

pub const SAIF = enum(u1) {
    /// Source address filter operates normally
    Normal = 0x0,
    /// Source address filter operation inverted
    Invert = 0x1,
};

pub const ST = enum(u1) {
    /// Transmission is placed in the Stopped state
    Stopped = 0x0,
    /// Transmission is placed in Running state
    Started = 0x1,
};

pub const TGFM = enum(u1) {
    /// Transmitted-good counter half-full interrupt enabled
    Unmasked = 0x0,
    /// Transmitted-good counter half-full interrupt disabled
    Masked = 0x1,
};

pub const TGFMSCM = enum(u1) {
    /// Transmitted-good-multiple-collision half-full interrupt enabled
    Unmasked = 0x0,
    /// Transmitted-good-multiple-collision half-full interrupt disabled
    Masked = 0x1,
};

pub const TGFSCM = enum(u1) {
    /// Transmitted-good-single-collision half-full interrupt enabled
    Unmasked = 0x0,
    /// Transmitted-good-single-collision half-full interrupt disabled
    Masked = 0x1,
};

pub const TPD = enum(u32) {
    /// Poll the transmit descriptor list
    Poll = 0x0,
    _,
};

pub const TPS = enum(u3) {
    /// Stopped, Reset or Stop Transmit command issued
    Stopped = 0x0,
    /// Running, fetching transmit transfer descriptor
    RunningFetching = 0x1,
    /// Running, waiting for status
    RunningWaiting = 0x2,
    /// Running, reading data from host memory buffer
    RunningReading = 0x3,
    /// Suspended, transmit descriptor unavailable or transmit buffer underflow
    Suspended = 0x6,
    /// Running, closing transmit descriptor
    Running = 0x7,
    _,
};

pub const TSF = enum(u1) {
    /// Transmission starts when the frame size in the Tx FIFO exceeds TTC threshold
    CutThrough = 0x0,
    /// Transmission starts when a full frame is in the Tx FIFO
    StoreForward = 0x1,
};

pub const TSTIM = enum(u1) {
    /// Time stamp interrupt generation enabled
    Unmasked = 0x0,
    /// Time stamp interrupt generation disabled
    Masked = 0x1,
};

pub const TTC = enum(u3) {
    /// 64 bytes
    TTC64 = 0x0,
    /// 128 bytes
    TTC128 = 0x1,
    /// 192 bytes
    TTC192 = 0x2,
    /// 256 bytes
    TTC256 = 0x3,
    /// 40 bytes
    TTC40 = 0x4,
    /// 32 bytes
    TTC32 = 0x5,
    /// 24 bytes
    TTC24 = 0x6,
    /// 16 bytes
    TTC16 = 0x7,
};

pub const USP = enum(u1) {
    /// PBL value used for both Rx and Tx DMA
    Combined = 0x0,
    /// RxDMA uses RDP value, TxDMA uses PBL value
    Separate = 0x1,
};

pub const VLANTC = enum(u1) {
    /// Full 16 bit VLAN identifiers are used for comparison and filtering
    VLANTC16 = 0x0,
    /// 12 bit VLAN identifies are used for comparison and filtering
    VLANTC12 = 0x1,
};

pub const WD = enum(u1) {
    /// Watchdog enabled, receive frames limited to 2048 bytes
    Enabled = 0x0,
    /// Watchdog disabled, receive frames may be up to to 16384 bytes
    Disabled = 0x1,
};

pub const WFFRPR = enum(u1) {
    /// Reset wakeup frame filter register point to 0b000. Automatically cleared
    Reset = 0x1,
    _,
};

pub const ZQPD = enum(u1) {
    /// Normal operation with automatic zero-quanta pause control frame generation
    Enabled = 0x0,
    /// Automatic generation of zero-quanta pause control frames is disabled
    Disabled = 0x1,
};

/// Ethernet Peripheral
pub const ETH = extern struct {
    /// Ethernet: media access control (MAC)
    /// offset: 0x00
    ETHERNET_MAC: u32,
    /// offset: 0x04
    reserved4: [1788]u8,
    /// Ethernet: Precision Time Protocol (PTP)
    /// offset: 0x700
    ETHERNET_PTP: u32,
    /// offset: 0x704
    reserved1796: [2300]u8,
    /// Ethernet: DMA mode register (DMA)
    /// offset: 0x1000
    ETHERNET_DMA: u32,
};

/// Ethernet: DMA controller operation
pub const ETHERNET_DMA = extern struct {
    /// Ethernet DMA bus mode register
    /// offset: 0x00
    DMABMR: mmio.Mmio(packed struct(u32) {
        /// Software reset
        SR: u1,
        /// DMA arbitration
        DA: DA,
        /// Descriptor skip length
        DSL: u5,
        /// Enhanced descriptor format enable
        EDFE: u1,
        /// Programmable burst length
        PBL: PBL,
        /// Rx-Tx priority ratio
        PM: PriorityRxOverTx,
        /// Fixed burst
        FB: FB,
        /// Rx DMA PBL
        RDP: RDP,
        /// Use separate PBL
        USP: USP,
        /// 4xPBL mode
        FPM: FPM,
        /// Address-aligned beats
        AAB: u1,
        /// Mixed burst
        MB: MB,
        padding: u5 = 0,
    }),
    /// Ethernet DMA transmit poll demand register
    /// offset: 0x04
    DMATPDR: mmio.Mmio(packed struct(u32) {
        /// Transmit poll demand
        TPD: TPD,
    }),
    /// EHERNET DMA receive poll demand register
    /// offset: 0x08
    DMARPDR: mmio.Mmio(packed struct(u32) {
        /// Receive poll demand
        RPD: RPD,
    }),
    /// Ethernet DMA receive descriptor list address register
    /// offset: 0x0c
    DMARDLAR: mmio.Mmio(packed struct(u32) {
        /// Start of receive list
        SRL: u32,
    }),
    /// Ethernet DMA transmit descriptor list address register
    /// offset: 0x10
    DMATDLAR: mmio.Mmio(packed struct(u32) {
        /// Start of transmit list
        STL: u32,
    }),
    /// Ethernet DMA status register
    /// offset: 0x14
    DMASR: mmio.Mmio(packed struct(u32) {
        /// Transmit status
        TS: u1,
        /// Transmit process stopped status
        TPSS: u1,
        /// Transmit buffer unavailable status
        TBUS: u1,
        /// Transmit jabber timeout status
        TJTS: u1,
        /// Receive overflow status
        ROS: u1,
        /// Transmit underflow status
        TUS: u1,
        /// Receive status
        RS: u1,
        /// Receive buffer unavailable status
        RBUS: u1,
        /// Receive process stopped status
        RPSS: u1,
        /// PWTS
        PWTS: u1,
        /// Early transmit status
        ETS: u1,
        reserved13: u2 = 0,
        /// Fatal bus error status
        FBES: u1,
        /// Early receive status
        ERS: u1,
        /// Abnormal interrupt summary
        AIS: u1,
        /// Normal interrupt summary
        NIS: u1,
        /// Receive process state
        RPS: RPS,
        /// Transmit process state
        TPS: TPS,
        /// Error bits status
        EBS: u3,
        reserved27: u1 = 0,
        /// MMC status
        MMCS: u1,
        /// PMT status
        PMTS: u1,
        /// Time stamp trigger status
        TSTS: u1,
        padding: u2 = 0,
    }),
    /// Ethernet DMA operation mode register
    /// offset: 0x18
    DMAOMR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Start/stop receive
        SR: DMAOMR_SR,
        /// Operate on second frame
        OSF: u1,
        /// Receive threshold control
        RTC: RTC,
        reserved6: u1 = 0,
        /// Forward undersized good frames
        FUGF: FUGF,
        /// Forward error frames
        FEF: FEF,
        reserved13: u5 = 0,
        /// Start/stop transmission
        ST: ST,
        /// Transmit threshold control
        TTC: TTC,
        reserved20: u3 = 0,
        /// Flush transmit FIFO
        FTF: FTF,
        /// Transmit store and forward
        TSF: TSF,
        reserved24: u2 = 0,
        /// Disable flushing of received frames
        DFRF: u1,
        /// Receive store and forward
        RSF: RSF,
        /// Dropping of TCP/IP checksum error frames disable
        DTCEFD: DTCEFD,
        padding: u5 = 0,
    }),
    /// Ethernet DMA interrupt enable register
    /// offset: 0x1c
    DMAIER: mmio.Mmio(packed struct(u32) {
        /// Transmit interrupt enable
        TIE: u1,
        /// Transmit process stopped interrupt enable
        TPSIE: u1,
        /// Transmit buffer unavailable interrupt enable
        TBUIE: u1,
        /// Transmit jabber timeout interrupt enable
        TJTIE: u1,
        /// Receive overflow interrupt enable
        ROIE: u1,
        /// Transmit underflow interrupt enable
        TUIE: u1,
        /// Receive interrupt enable
        RIE: u1,
        /// Receive buffer unavailable interrupt enable
        RBUIE: u1,
        /// Receive process stopped interrupt enable
        RPSIE: u1,
        /// Receive watchdog timeout interrupt enable
        RWTIE: u1,
        /// Early transmit interrupt enable
        ETIE: u1,
        reserved13: u2 = 0,
        /// Fatal bus error interrupt enable
        FBEIE: u1,
        /// Early receive interrupt enable
        ERIE: u1,
        /// Abnormal interrupt summary enable
        AISE: u1,
        /// Normal interrupt summary enable
        NISE: u1,
        padding: u15 = 0,
    }),
    /// Ethernet DMA missed frame and buffer overflow counter register
    /// offset: 0x20
    DMAMFBOCR: mmio.Mmio(packed struct(u32) {
        /// Missed frames by the controller
        MFC: u16,
        /// Overflow bit for missed frame counter
        OMFC: u1,
        /// Missed frames by the application
        MFA: u11,
        /// Overflow bit for FIFO overflow counter
        OFOC: u1,
        padding: u3 = 0,
    }),
    /// Ethernet DMA receive status watchdog timer register
    /// offset: 0x24
    DMARSWTR: mmio.Mmio(packed struct(u32) {
        /// Receive status watchdog timer count
        RSWTC: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    reserved40: [32]u8,
    /// Ethernet DMA current host transmit descriptor register
    /// offset: 0x48
    DMACHTDR: mmio.Mmio(packed struct(u32) {
        /// Host transmit descriptor address pointer
        HTDAP: u32,
    }),
    /// Ethernet DMA current host receive descriptor register
    /// offset: 0x4c
    DMACHRDR: mmio.Mmio(packed struct(u32) {
        /// Host receive descriptor address pointer
        HRDAP: u32,
    }),
    /// Ethernet DMA current host transmit buffer address register
    /// offset: 0x50
    DMACHTBAR: mmio.Mmio(packed struct(u32) {
        /// Host transmit buffer address pointer
        HTBAP: u32,
    }),
    /// Ethernet DMA current host receive buffer address register
    /// offset: 0x54
    DMACHRBAR: mmio.Mmio(packed struct(u32) {
        /// Host receive buffer address pointer
        HRBAP: u32,
    }),
};

/// Ethernet: media access control (MAC)
pub const ETHERNET_MAC = extern struct {
    /// Ethernet MAC configuration register
    /// offset: 0x00
    MACCR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Receiver enable
        RE: u1,
        /// Transmitter enable
        TE: u1,
        /// Deferral check
        DC: u1,
        /// Back-off limit
        BL: BL,
        /// Automatic pad/CRC stripping
        APCS: APCS,
        reserved9: u1 = 0,
        /// Retry disable
        RD: RD,
        /// IPv4 checksum offload
        IPCO: IPCO,
        /// Duplex mode
        DM: DM,
        /// Loopback mode
        LM: LM,
        /// Receive own disable
        ROD: ROD,
        /// Fast Ethernet speed
        FES: FES,
        reserved16: u1 = 0,
        /// Carrier sense disable
        CSD: CSD,
        /// Interframe gap
        IFG: IFG,
        reserved22: u2 = 0,
        /// Jabber disable
        JD: JD,
        /// Watchdog disable
        WD: WD,
        reserved25: u1 = 0,
        /// CRC stripping for type frames
        CSTF: u1,
        padding: u6 = 0,
    }),
    /// Ethernet MAC frame filter register
    /// offset: 0x04
    MACFFR: mmio.Mmio(packed struct(u32) {
        /// Promiscuous mode
        PM: u1,
        /// Hash unicast
        HU: HU,
        /// Hash multicast
        HM: HM,
        /// Destination address unique filtering
        DAIF: DAIF,
        /// Pass all multicast
        PAM: u1,
        /// Broadcast frames disable
        BFD: BFD,
        /// Pass control frames
        PCF: PCF,
        // skipped overlapping field SAIF at offset 7 bits
        /// Source address filter
        SAF: u1,
        /// Hash or perfect filter
        HPF: HPF,
        reserved31: u21 = 0,
        /// Receive all
        RA: u1,
    }),
    /// Ethernet MAC hash table high register
    /// offset: 0x08
    MACHTHR: mmio.Mmio(packed struct(u32) {
        /// Upper 32 bits of hash table
        HTH: u32,
    }),
    /// Ethernet MAC hash table low register
    /// offset: 0x0c
    MACHTLR: mmio.Mmio(packed struct(u32) {
        /// Lower 32 bits of hash table
        HTL: u32,
    }),
    /// Ethernet MAC MII address register
    /// offset: 0x10
    MACMIIAR: mmio.Mmio(packed struct(u32) {
        /// MII busy
        MB: MB_progress,
        /// MII write
        MW: MW,
        /// Clock range
        CR: CR,
        reserved6: u1 = 0,
        /// MII register - select the desired MII register in the PHY device
        MR: u5,
        /// PHY address - select which of possible 32 PHYs is being accessed
        PA: u5,
        padding: u16 = 0,
    }),
    /// Ethernet MAC MII data register
    /// offset: 0x14
    MACMIIDR: mmio.Mmio(packed struct(u32) {
        /// MII data read from/written to the PHY
        MD: u16,
        padding: u16 = 0,
    }),
    /// Ethernet MAC flow control register
    /// offset: 0x18
    MACFCR: mmio.Mmio(packed struct(u32) {
        /// Flow control busy/back pressure activate
        FCB: FCB,
        /// Transmit flow control enable
        TFCE: u1,
        /// Receive flow control enable
        RFCE: u1,
        /// Unicast pause frame detect
        UPFD: u1,
        /// Pause low threshold
        PLT: PLT,
        reserved7: u1 = 0,
        /// Zero-quanta pause disable
        ZQPD: ZQPD,
        reserved16: u8 = 0,
        /// Pause time
        PT: u16,
    }),
    /// Ethernet MAC VLAN tag register
    /// offset: 0x1c
    MACVLANTR: mmio.Mmio(packed struct(u32) {
        /// VLAN tag identifier (for receive frames)
        VLANTI: u16,
        /// 12-bit VLAN tag comparison
        VLANTC: VLANTC,
        padding: u15 = 0,
    }),
    /// offset: 0x20
    reserved32: [8]u8,
    /// Ethernet MAC remote wakeup frame filter register
    /// offset: 0x28
    MACRWUFFR: u32,
    /// Ethernet MAC PMT control and status register
    /// offset: 0x2c
    MACPMTCSR: mmio.Mmio(packed struct(u32) {
        /// Power down
        PD: PD,
        /// Magic packet enable
        MPE: u1,
        /// Wakeup frame enable
        WFE: u1,
        reserved5: u2 = 0,
        /// Magic packet received
        MPR: u1,
        /// Wakeup frame received
        WFR: u1,
        reserved9: u2 = 0,
        /// Global unicast
        GU: u1,
        reserved31: u21 = 0,
        /// Wakeup frame filter register pointer reset
        WFFRPR: WFFRPR,
    }),
    /// offset: 0x30
    reserved48: [4]u8,
    /// Ethernet MAC debug register
    /// offset: 0x34
    MACDBGR: mmio.Mmio(packed struct(u32) {
        /// MAC MII receive protocol engine active
        MMRPEA: u1,
        /// MAC small FIFO read/write controllers status
        MSFRWCS: u2,
        reserved4: u1 = 0,
        /// Rx FIFO write controller active
        RFWRA: u1,
        /// Rx FIFO read controller status
        RFRCS: u2,
        reserved8: u1 = 0,
        /// Rx FIFO fill level
        RFFL: u2,
        reserved16: u6 = 0,
        /// MAC MII transmit engine active
        MMTEA: u1,
        /// MAC transmit frame controller status
        MTFCS: u2,
        /// MAC transmitter in pause
        MTP: u1,
        /// Tx FIFO read status
        TFRS: u2,
        /// Tx FIFO write active
        TFWA: u1,
        reserved24: u1 = 0,
        /// Tx FIFO not empty
        TFNE: u1,
        /// Tx FIFO full
        TFF: u1,
        padding: u6 = 0,
    }),
    /// Ethernet MAC interrupt status register
    /// offset: 0x38
    MACSR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// PMT status
        PMTS: u1,
        /// MMC status
        MMCS: u1,
        /// MMC receive status
        MMCRS: u1,
        /// MMC transmit status
        MMCTS: u1,
        reserved9: u2 = 0,
        /// Time stamp trigger status
        TSTS: u1,
        padding: u22 = 0,
    }),
    /// Ethernet MAC interrupt mask register
    /// offset: 0x3c
    MACIMR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// PMT interrupt mask
        PMTIM: PMTIM,
        reserved9: u5 = 0,
        /// Time stamp trigger interrupt mask
        TSTIM: TSTIM,
        padding: u22 = 0,
    }),
    /// Ethernet MAC address 0 high register
    /// offset: 0x40
    MACA0HR: mmio.Mmio(packed struct(u32) {
        /// Ethernet MAC address 0 high
        MACA0H: u16,
        reserved31: u15 = 0,
        /// Always 1
        MO: u1,
    }),
    /// Ethernet MAC address 0 low register
    /// offset: 0x44
    MACA0LR: mmio.Mmio(packed struct(u32) {
        /// Ethernet MAC address 0 low
        MACA0L: u32,
    }),
    /// Ethernet MAC address 1/2/3 high register
    /// offset: 0x48
    MACAHR: mmio.Mmio(packed struct(u32) {
        /// Ethernet MAC address 1/2/3 high
        MACAH: u16,
        reserved24: u8 = 0,
        /// MBC
        MBC: u6,
        /// SA
        SA: MACAHR_SA,
        /// AE
        AE: u1,
    }),
    /// Ethernet MAC address 1/2/3 low register
    /// offset: 0x4c
    MACALR: mmio.Mmio(packed struct(u32) {
        /// Ethernet MAC address 1/2/3 low
        MACAL: u32,
    }),
    /// offset: 0x50
    reserved80: [176]u8,
    /// Ethernet MMC control register
    /// offset: 0x100
    MMCCR: mmio.Mmio(packed struct(u32) {
        /// Counter reset
        CR: CounterReset,
        /// Counter stop rollover
        CSR: CSR,
        /// Reset on read
        ROR: u1,
        /// MMC counter freeze
        MCF: u1,
        /// MMC counter preset
        MCP: MCP,
        /// MMC counter Full-Half preset
        MCFHP: MCFHP,
        padding: u26 = 0,
    }),
    /// Ethernet MMC receive interrupt register
    /// offset: 0x104
    MMCRIR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Received frames CRC error status
        RFCES: u1,
        /// Received frames alignment error status
        RFAES: u1,
        reserved17: u10 = 0,
        /// Received good Unicast frames status
        RGUFS: u1,
        padding: u14 = 0,
    }),
    /// Ethernet MMC transmit interrupt register
    /// offset: 0x108
    MMCTIR: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// Transmitted good frames single collision status
        TGFSCS: u1,
        /// Transmitted good frames more than single collision status
        TGFMSCS: u1,
        reserved21: u5 = 0,
        /// Transmitted good frames status
        TGFS: u1,
        padding: u10 = 0,
    }),
    /// Ethernet MMC receive interrupt mask register
    /// offset: 0x10c
    MMCRIMR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Received frame CRC error mask
        RFCEM: RFCEM,
        /// Received frames alignment error mask
        RFAEM: RFAEM,
        reserved17: u10 = 0,
        /// Received good Unicast frames mask
        RGUFM: RGUFM,
        padding: u14 = 0,
    }),
    /// Ethernet MMC transmit interrupt mask register
    /// offset: 0x110
    MMCTIMR: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// Transmitted good frames single collision mask
        TGFSCM: TGFSCM,
        /// Transmitted good frames more than single collision mask
        TGFMSCM: TGFMSCM,
        /// Transmitted good frames mask
        TGFM: TGFM,
        padding: u15 = 0,
    }),
    /// offset: 0x114
    reserved276: [56]u8,
    /// Ethernet MMC transmitted good frames after a single collision counter
    /// offset: 0x14c
    MMCTGFSCCR: mmio.Mmio(packed struct(u32) {
        /// Transmitted good frames single collision counter
        TGFSCC: u32,
    }),
    /// Ethernet MMC transmitted good frames after more than a single collision
    /// offset: 0x150
    MMCTGFMSCCR: mmio.Mmio(packed struct(u32) {
        /// TGFMSCC
        TGFMSCC: u32,
    }),
    /// offset: 0x154
    reserved340: [20]u8,
    /// Ethernet MMC transmitted good frames counter register
    /// offset: 0x168
    MMCTGFCR: mmio.Mmio(packed struct(u32) {
        /// HTL
        TGFC: u32,
    }),
    /// offset: 0x16c
    reserved364: [40]u8,
    /// Ethernet MMC received frames with CRC error counter register
    /// offset: 0x194
    MMCRFCECR: mmio.Mmio(packed struct(u32) {
        /// RFCFC
        RFCFC: u32,
    }),
    /// Ethernet MMC received frames with alignment error counter register
    /// offset: 0x198
    MMCRFAECR: mmio.Mmio(packed struct(u32) {
        /// RFAEC
        RFAEC: u32,
    }),
    /// offset: 0x19c
    reserved412: [40]u8,
    /// MMC received good unicast frames counter register
    /// offset: 0x1c4
    MMCRGUFCR: mmio.Mmio(packed struct(u32) {
        /// RGUFC
        RGUFC: u32,
    }),
};

/// Ethernet: Precision time protocol
pub const ETHERNET_PTP = extern struct {
    /// Ethernet PTP time stamp control register
    /// offset: 0x00
    PTPTSCR: mmio.Mmio(packed struct(u32) {
        /// TSE
        TSE: u1,
        /// TSFCU
        TSFCU: u1,
        /// TSSTI
        TSSTI: u1,
        /// TSSTU
        TSSTU: u1,
        /// TSITE
        TSITE: u1,
        /// TTSARU
        TTSARU: u1,
        reserved8: u2 = 0,
        /// TSSARFE
        TSSARFE: u1,
        /// TSSSR
        TSSSR: u1,
        /// TSPTPPSV2E
        TSPTPPSV2E: u1,
        /// TSSPTPOEFE
        TSSPTPOEFE: u1,
        /// TSSIPV6FE
        TSSIPV6FE: u1,
        /// TSSIPV4FE
        TSSIPV4FE: u1,
        /// TSSEME
        TSSEME: u1,
        /// TSSMRME
        TSSMRME: u1,
        /// TSCNT
        TSCNT: u2,
        /// TSPFFMAE
        TSPFFMAE: u1,
        padding: u13 = 0,
    }),
    /// Ethernet PTP subsecond increment register
    /// offset: 0x04
    PTPSSIR: mmio.Mmio(packed struct(u32) {
        /// STSSI
        STSSI: u8,
        padding: u24 = 0,
    }),
    /// Ethernet PTP time stamp high register
    /// offset: 0x08
    PTPTSHR: mmio.Mmio(packed struct(u32) {
        /// STS
        STS: u32,
    }),
    /// Ethernet PTP time stamp low register
    /// offset: 0x0c
    PTPTSLR: mmio.Mmio(packed struct(u32) {
        /// STSS
        STSS: u31,
        /// STPNS
        STPNS: u1,
    }),
    /// Ethernet PTP time stamp high update register
    /// offset: 0x10
    PTPTSHUR: mmio.Mmio(packed struct(u32) {
        /// TSUS
        TSUS: u32,
    }),
    /// Ethernet PTP time stamp low update register
    /// offset: 0x14
    PTPTSLUR: mmio.Mmio(packed struct(u32) {
        /// TSUSS
        TSUSS: u31,
        /// TSUPNS
        TSUPNS: u1,
    }),
    /// Ethernet PTP time stamp addend register
    /// offset: 0x18
    PTPTSAR: mmio.Mmio(packed struct(u32) {
        /// TSA
        TSA: u32,
    }),
    /// Ethernet PTP target time high register
    /// offset: 0x1c
    PTPTTHR: mmio.Mmio(packed struct(u32) {
        /// 0
        TTSH: u32,
    }),
    /// Ethernet PTP target time low register
    /// offset: 0x20
    PTPTTLR: mmio.Mmio(packed struct(u32) {
        /// TTSL
        TTSL: u32,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// Ethernet PTP time stamp status register
    /// offset: 0x28
    PTPTSSR: mmio.Mmio(packed struct(u32) {
        /// TSSO
        TSSO: u1,
        /// TSSO
        TSTTR: u1,
        padding: u30 = 0,
    }),
    /// Ethernet PTP PPS control register
    /// offset: 0x2c
    PTPPPSCR: mmio.Mmio(packed struct(u32) {
        /// TSSO
        TSSO: u1,
        /// TSTTR
        TSTTR: u1,
        padding: u30 = 0,
    }),
};
